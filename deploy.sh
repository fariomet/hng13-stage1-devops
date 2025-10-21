#!/bin/bash

# everything logged here
LOG_FILE="deploy_$(date +%Y%m%d).log"

# error handling
trap 'echo "An error has occurred at line $LINENO" | tee -a  $LOG_FILE; exit 1' ERR
set -e

echo "Starting deployment..." | tee -a $LOG_FILE

# parameters
read -p "Git Repo URL: " GIT_REPO
read -p "Personal Access Token: " PAT
read -p "Branch (default: main): " BRANCH
BRANCH=${BRANCH:-main}  # default to main if empty

# remote server SSH details
read -p "Remote SSH Username: " SSH_USER
read -p "Remote Server IP: " REMOTE_IP
read -p "SSH Key Path: " SSH_KEY
read -p "Application Port (internal container): " APP_PORT

# cloning repo
REPO_NAME=$(basename "$GIT_REPO" .git)
if [ -d "$REPO_NAME" ]; then
        echo "Repo exists! Pulling new changes..." | tee -a $LOG_FILE
        cd "$REPO_NAME"
        git pull origin "$BRANCH"
else
        echo "Cloning repository..." | tee -a $LOG_FILE
        git clone -b "$BRANCH" "https://$PAT@${GIT_REPO#https://}" "$REPO_NAME"
        cd "$REPO_NAME"
fi

# verifying dockerfile or docker-compose.yaml
if [ -f Dockerfile ] || [ -f docker-compose.yml ]; then
        echo "Docker config found." | tee -a $LOG_FILE
else
        echo "No Dockerfile or docker-compose.yml found!" | tee -a $LOG_FILE
        exit 1
fi

# ssh to remote server
echo "Checking SSH connectivity..." | tee -a $LOG_FILE
ssh -i "$SSH_KEY" "$SSH_USER@$REMOTE_IP" "echo 'SSH connection successful'" | tee -a $LOG_FILE

# preparing remote env
ssh -i "$SSH_KEY" "$SSH_USER@$REMOTE_IP" bash <<EOF
sudo apt update
sudo apt install -y docker.io docker-compose nginx
sudo usermod -aG docker $SSH_USER
sudo systemctl enable --now docker nginx
docker --version
docker-compose --version
nginx -v
EOF

# deploying dockerized app
scp -r . "$SSH_USER@$REMOTE_IP:~/$(pwd)"
ssh -i "$SSH_KEY" "$SSH_USER@$REMOTE_IP" bash <<EOF
cd ~/$(pwd)
if [ -f docker-compose.yml ]; then
    docker-compose down
    docker-compose up -d --build
else
    docker stop $REPO_NAME || true
    docker rm $REPO_NAME || true
    docker build -t $REPO_NAME .
    docker run -d -p $APP_PORT:$APP_PORT --name $REPO_NAME $REPO_NAME
fi

## container health check

STATUS=$(docker inspect --format='{{.State.Health.Status}}' $REPO_NAME 2>/dev/null || echo "no healthcheck")
echo "Container health: $STATUS" | tee -a $LOG_FILE
if [ "$STATUS" != "healthy" ]; then
        echo "Running runtime HTTP health check..." | tee -a $LOG_FILE
        for i in {1..5}; do
                STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$APP_PORT)
                if [ "$STATUS_CODE" -eq 200 ]; then
                        echo "Container is responding on port $APP_PORT!" | tee -a $LOG_FILE
                        break
                else
                        echo "Attempt $i: App not ready yet, waiting 5s.." | tee -a $LOG_FILE
                        sleep 5
                fi
        done
fi

docker logs --tail 20 $REPO_NAME
curl -I http://localhost:$APP_PORT
EOF

# configuring NGINX as reverse proxy
ssh -i "$SSH_KEY" "$SSH_USER@$REMOTE_IP" bash <<EOF
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80;
    location / {
        proxy_pass http://localhost:$APP_PORT;
    }
}
EOL
sudo nginx -t && sudo systemctl reload nginx
EOF

# validating deployment
ssh -i "$SSH_KEY"  "$SSH_USER@$REMOTE_IP" "docker ps; curl -I http://localhost:$APP_PORT"

echo "Deployment completed successfully!" | tee -a $LOG_FILE
