<<<<<<< HEAD
# hng13-stage1-devops
Repository for HNG13 stage1 devops task

This is a project by Banjo daniel

A simple Bash script that does the following:

* Collect Parameters from User Input Prompt for and validate
* Clone the Repository
* Navigate into the Cloned Directory
* SSH into the Remote Server
* Prepare the Remote Environment On the remote host
* Deploy the Dockerized Application
* Configure Nginx as a Reverse Proxy
* Validate Deployment
* Implement Logging and Error Handling
* Ensure Idempotency and Cleanup
=======
# Faridat Suleiman

# Slack username: Jazzmin.jsx

# DESCRIPTION: Multi-Page Profile Application with Contact Us page and About Me page

A responsive, accessible multi-page web application featuring a Profile Card, Contact Us form, and About Me page.

# Domain: 

## Features

### Profile Page (`index.html`)
- **Responsive Profile Card**: Adapts to mobile, tablet, and desktop
- **Live Time Display**: Shows current Nigerian time with milliseconds
- **Social Links**: Accessible social media links with security attributes
- **Semantic HTML**: Proper use of semantic elements

### Contact Us Page (`contact.html`)
- **Form Validation**: Real-time validation for all fields
- **Accessibility**: Full keyboard navigation and screen reader support
- **Success Feedback**: Clear success message upon valid submission
- **Error Handling**: Specific error messages for each field

### About Me Page (`about.html`)
- **Reflective Content**: Personal insights and professional goals
- **Semantic Structure**: Proper sectioning and heading hierarchy
- **Responsive Design**: Optimized for all screen sizes

## Technical Features

### Accessibility
- Semantic HTML5 elements
- ARIA labels and descriptions
- Keyboard navigation support
- Focus indicators
- Screen reader compatibility

### Responsive Design
- Mobile-first approach
- CSS Grid and Flexbox layouts
- Media queries for different screen sizes
- Flexible typography and spacing

### Form Validation
- Required field validation
- Email format validation
- Minimum length requirements
- Real-time feedback
- Accessible error messages

## Setup Instructions

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Local web server (optional, for enhanced testing)

### Installation

1. **Download all files** to a project folder

2. **Open in browser**:
   - Double-click `index.html` to start with the Profile page
   - Navigate between pages using the navigation menu

## Testing

### Automated Testing IDs
All major elements include `data-testid` attributes:

#### Profile Page
- `test-profile-card` - Main container
- `test-user-name` - User's name
- `test-user-bio` - Biography
- `test-user-time` - Current time
- `test-user-avatar` - Profile image
- `test-user-social-links` - Social media container
- `test-user-hobbies` - Hobbies list
- `test-user-dislikes` - Dislikes list

#### Contact Page
- `test-contact-page` - Main container
- `test-contact-name` - Full name input
- `test-contact-email` - Email input
- `test-contact-subject` - Subject input
- `test-contact-message` - Message textarea
- `test-contact-submit` - Submit button
- `test-contact-error-*` - Field-specific error messages
- `test-contact-success` - Success message

#### About Page
- `test-about-page` - Main container
- `test-about-bio` - Biography section
- `test-about-goals` - Program goals
- `test-about-confidence` - Low confidence areas
- `test-about-future-note` - Note to future self
- `test-about-extra` - Additional thoughts

### Manual Testing Checklist

#### Navigation
- [ ] All navigation links work correctly
- [ ] Current page is highlighted in navigation
- [ ] Keyboard navigation works (Tab, Enter)
- [ ] Mobile navigation stacks vertically

#### Contact Form
- [ ] All fields are required
- [ ] Email validation rejects invalid formats
- [ ] Message requires minimum 10 characters
- [ ] Error messages show for invalid fields
- [ ] Success message appears on valid submission
- [ ] Form clears after successful submission

#### Accessibility
- [ ] All images have alt text
- [ ] Form fields have associated labels
- [ ] Error messages are announced by screen readers
- [ ] Focus indicators are visible
- [ ] Semantic HTML structure is correct

#### Responsiveness
- [ ] Layout adapts to mobile screens
- [ ] Content remains readable on all devices
- [ ] Navigation works on touch devices
- [ ] Forms are usable on mobile

## Browser Compatibility

- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+

## Customization

### Styling
Modify CSS custom properties in `:root` selector:
```css
:root {
    --primary-color: #3a86ff;
    --secondary-color: #8338ec;
    /* Add your custom colors */
}
```

### Content
Update the HTML content in each page to reflect your personal information.

### Form Behavior
The contact form currently shows success messages without backend integration. For production use, connect to a form processing service.

## License

This project is open source and available under the [MIT License](LICENSE).
```

This comprehensive implementation provides a complete multi-page application with proper accessibility, responsive design, and form validation - all with detailed explanations for each component.
>>>>>>> 85a9633 (profile card page with contact us and about me pages)
