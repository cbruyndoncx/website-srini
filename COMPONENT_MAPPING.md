# Component Mapping Guide

Quick reference for mapping website sections to specific AppKit Mobile components. Use this during implementation to ensure consistency with the framework.

## Navigation Components

### Header/Navbar
- **AppKit Source:** `index-homepages.html` or `index-components.html`
- **Component:** `.navbar`, `.navbar-expand-lg`
- **Features:**
  - Responsive hamburger menu for mobile
  - Brand logo with link to home
  - Primary navigation links
  - Optional: Search bar, theme toggle
- **Notes:** Use Bootstrap 5 navbar classes, test mobile menu functionality

### Footer
- **AppKit Source:** `index-homepages.html`
- **Component:** Multi-column footer layout
- **Features:**
  - Legal links (Privacy, Terms, etc.)
  - Social media icons
  - Contact information
  - Newsletter signup (optional)
  - Copyright notice
- **Notes:** Keep consistent across all pages

### Off-Canvas Sidebar (Mobile Menu)
- **AppKit Source:** `component-sidebars.html`
- **Component:** `.offcanvas`, `.offcanvas-start`
- **Features:** Slide-in animation, overlay backdrop

---

## Homepage Components

### Hero Section
- **AppKit Source:** `index-homepages.html`
- **Component:** `.hero`, hero banner variations
- **Features:**
  - Large headline (H1)
  - Subheading/value proposition
  - CTA button(s)
  - Background image or gradient
- **Usage:** Main landing section at top of homepage

### Feature Cards (Services Overview)
- **AppKit Source:** `component-card-content.html`
- **Component:** `.card`, `.card-body`
- **Layout:** Grid system (`.row`, `.col-md-4`)
- **Features:**
  - Icon or image
  - Title (H3)
  - Description text
  - Optional: Link or CTA button
- **Usage:** Display 3-4 key services on homepage

### Testimonials Carousel
- **AppKit Source:** `component-reviews.html` + carousel functionality
- **Component:** `.carousel`, review cards
- **Features:**
  - Customer photo (optional)
  - Review text
  - Star rating
  - Customer name and role
  - Automatic rotation or manual controls
- **Usage:** Social proof section on homepage

---

## Service Page Components

### Service Cards/Grid
- **AppKit Source:** `component-card-content.html`
- **Component:** `.card` with image and content
- **Layout:** Grid (`.row`, `.col-md-6` or `.col-lg-4`)
- **Features:**
  - Service image/icon
  - Title and description
  - "Learn More" or "Book Now" button
- **Usage:** Display all available services

### Tabs for Service Categories
- **AppKit Source:** `component-tabs.html`
- **Component:** `.nav-tabs`, `.tab-content`
- **Features:**
  - Multiple tabs for categories
  - Content area switches on tab click
  - Mobile-friendly stacked layout
- **Usage:** Organize services by category (optional)

### Accordions for Service Details
- **AppKit Source:** `component-accordions.html`
- **Component:** `.accordion`, `.accordion-item`
- **Features:**
  - Expand/collapse sections
  - Icon indicator (chevron)
  - Only one open at a time (optional)
- **Usage:** Detailed service information, FAQs within service page

---

## Booking Page Components

### Form Inputs
- **AppKit Source:** `component-inputs.html`
- **Components:** `.form-control`, `.form-label`, `.form-select`
- **Input Types:**
  - Text input (name, phone)
  - Email input
  - Select dropdown (service type)
  - Textarea (message/notes)
  - Date/time picker (can use native HTML5 or plugin)
  - Checkboxes/toggles for options
- **Usage:** Booking request form

### Form Validation
- **JavaScript:** Custom validation or Bootstrap validation classes
- **Classes:** `.is-valid`, `.is-invalid`
- **Feedback:** `.valid-feedback`, `.invalid-feedback`

### Success Modal
- **AppKit Source:** `component-modals.html`
- **Component:** `.modal`, programmatic modal API
- **Features:**
  - Modal header with title
  - Modal body with confirmation message
  - Close button
  - Optional: Display submitted data
- **Usage:** Show after form submission

---

## About Page Components

### Content Sections
- **AppKit Source:** `index-pages.html`
- **Component:** Standard content layout with Bootstrap grid
- **Features:**
  - Two-column layout (text + image)
  - Full-width text sections
  - Pull quotes or highlights

### Team Member Cards (Optional)
- **AppKit Source:** `component-card-content.html`
- **Component:** `.card` with image and bio
- **Features:**
  - Team member photo
  - Name and title
  - Brief bio
  - Social links (optional)
- **Layout:** Grid (`.col-md-3` or `.col-lg-4`)

### Image Gallery (Optional)
- **AppKit Source:** Image gallery components
- **Component:** Grid of images with lightbox
- **Features:**
  - Thumbnail grid
  - Click to enlarge
  - Navigation between images
- **Usage:** Office photos, team photos, etc.

---

## Contact Page Components

### Contact Form
- **AppKit Source:** `page-contact.html` template
- **Components:** Form inputs (text, email, textarea)
- **Fields:**
  - Name
  - Email
  - Subject (optional)
  - Message
- **Validation:** JavaScript validation before submission

### Contact Information Cards
- **AppKit Source:** `component-card-content.html`
- **Component:** `.card` with icon and text
- **Features:**
  - Icon (phone, email, location)
  - Label and value
  - Clickable links (tel:, mailto:)
- **Layout:** Grid (`.col-md-4`)

### Map Integration
- **Options:**
  - Embedded Google Maps iframe
  - Static map image with link to Google Maps
  - Leaflet.js for custom map (more complex)
- **Usage:** Show business location or service area

---

## Testimonials Page Components

### Review Cards
- **AppKit Source:** `component-reviews.html`
- **Component:** Review card component
- **Features:**
  - Customer name and photo (optional)
  - Star rating (5-star visual)
  - Review text
  - Date (optional)
  - Service received (optional)
- **Layout:** Grid or list layout

### Star Rating Display
- **Implementation:** Icon font (Font Awesome) or SVG stars
- **Colors:** Filled stars (gold/yellow), empty stars (gray)
- **Usage:** Visual rating in review cards

### Carousel or Grid View
- **Option 1:** Carousel for rotating testimonials
- **Option 2:** Grid layout showing all testimonials at once
- **Recommendation:** Grid with pagination for better UX

---

## FAQ Page Components

### Accordions
- **AppKit Source:** `component-accordions.html`
- **Component:** `.accordion`, `.accordion-item`
- **Structure:**
  - Question as accordion header
  - Answer as accordion body (collapsed by default)
  - Expand/collapse on click
- **Features:**
  - Chevron/arrow indicator
  - Smooth animation
  - Optional: Keep one always open
- **Usage:** Organize FAQs by category with section headers

### Search/Filter (Optional)
- **Implementation:** JavaScript filter function
- **Features:**
  - Search input at top of page
  - Filter accordion items based on keyword
  - Show/hide matching questions
- **Usage:** Help users find specific questions quickly

---

## Pricing Page Components

### Pricing Tables
- **AppKit Source:** `component-pricing.html`
- **Component:** Pricing card/table component
- **Structure:**
  - Tier name (Basic, Pro, Premium)
  - Price with period ($/month)
  - Feature list with checkmarks
  - CTA button
- **Layout:** Grid (`.col-md-4` for 3 tiers)

### Feature Comparison Table (Alternative)
- **Implementation:** HTML table with responsive classes
- **Features:**
  - First column: feature names
  - Other columns: checkmarks/X for each tier
  - Highlight recommended tier
- **Usage:** Detailed side-by-side comparison

### Toggle for Billing Period (Optional)
- **Component:** Toggle switch (monthly/annually)
- **JavaScript:** Switch prices dynamically on toggle
- **Usage:** Show different pricing for monthly vs. annual billing

---

## Locations Page Components

### Location Cards
- **AppKit Source:** `page-places.html` or `component-card-content.html`
- **Component:** `.card` with location details
- **Features:**
  - Location name
  - Address
  - Phone number
  - Hours of operation
  - Map link or embedded map
- **Layout:** Grid (`.col-md-6` or `.col-lg-4`)

### List View (Alternative)
- **AppKit Source:** `list-content.html`
- **Component:** List group or card list
- **Features:**
  - Vertical list of locations
  - Expandable for more details (accordion style)
- **Usage:** If many locations, list view may be cleaner

---

## Blog/News Page Components

### Article Cards
- **AppKit Source:** `list-content.html`
- **Component:** Content card with image, title, excerpt
- **Features:**
  - Featured image
  - Article title (linked to full article)
  - Excerpt or summary (2-3 sentences)
  - Read more link
  - Date published
  - Author (optional)
- **Layout:** Grid or vertical list

### Individual Article Page
- **AppKit Source:** `index-pages.html`
- **Component:** Standard content page layout
- **Features:**
  - Article title (H1)
  - Author and date
  - Full article content
  - Social sharing buttons
  - Related articles section (optional)

---

## Shared Interactive Components

### Modals
- **AppKit Source:** `component-modals.html`
- **Component:** `.modal`, `.modal-dialog`
- **Triggers:** Button click, form submission, programmatic call
- **Uses:**
  - Form confirmation
  - Alerts and notices
  - Image lightbox
  - Video embeds
- **Programmatic API:** `showModal(title, content)` function

### Action Sheets (Mobile)
- **AppKit Source:** `component-actionsheets.html`
- **Component:** Bottom sheet for mobile selection
- **Uses:**
  - Select from list of options
  - Confirm actions
  - Share menu
- **Platform:** Optimized for mobile/touch devices

### Toasts
- **AppKit Source:** Toast components
- **Component:** `.toast`
- **Uses:**
  - Non-intrusive notifications
  - Success/error messages
  - Brief updates
- **Position:** Top-right or bottom-right corner
- **Auto-dismiss:** After 3-5 seconds

### Buttons
- **AppKit Source:** `component-buttons.html`
- **Component:** `.btn`, `.btn-primary`, `.btn-secondary`, etc.
- **Variations:**
  - Primary (main CTA)
  - Secondary (less prominent actions)
  - Outline style
  - Icon buttons
  - Button groups
- **Sizes:** `.btn-sm`, `.btn-lg`

---

## Theme Components

### Dark/Light Mode Toggle
- **AppKit Source:** `highlights.html`, `component-colors.html`
- **Component:** Toggle switch or icon button
- **Location:** Navbar (top-right)
- **Functionality:**
  - Click to toggle between themes
  - Save preference to localStorage
  - Apply theme class to `<body>` or `<html>`
- **Auto-detection:** Check `prefers-color-scheme` media query on load

### Color Scheme Selector (Optional)
- **AppKit Source:** `component-colors.html`
- **Component:** Color swatch buttons
- **Features:**
  - Multiple color pack options
  - Preview of colors
  - Apply selected color scheme
  - Save to localStorage
- **Usage:** Advanced customization option

### Smart AppKit Content Switching
- **Technique:** Use CSS classes or JavaScript to show/hide elements
- **Example:** Different hero images for light vs. dark mode
- **Classes:** `.light-mode-only`, `.dark-mode-only`
- **CSS:**
  ```css
  [data-theme="light"] .dark-mode-only { display: none; }
  [data-theme="dark"] .light-mode-only { display: none; }
  ```

---

## Data Visualization Components

### Charts (Charts.js)
- **AppKit Source:** Charts.js plugin in `/code/plugins/`
- **Chart Types:**
  - Line chart
  - Bar chart
  - Pie/doughnut chart
  - Radar chart
- **Usage:** Statistics, performance metrics, demo data
- **Implementation:**
  ```javascript
  const ctx = document.getElementById('myChart');
  new Chart(ctx, {
    type: 'bar',
    data: { /* data */ },
    options: { responsive: true }
  });
  ```

### Stats/Metrics Display
- **Component:** Custom card or counter
- **Features:**
  - Large number (stat value)
  - Label/description
  - Optional icon
  - Optional: Animated count-up effect
- **Layout:** Grid (`.col-md-3` for 4 stats)

---

## Social Components

### Social Share Buttons
- **AppKit Source:** `component-sharing.html`
- **Component:** Social share button group
- **Platforms:** Facebook, Twitter, LinkedIn, Email, etc.
- **Implementation:**
  - Link to sharing URL with query parameters
  - Example: `https://twitter.com/intent/tweet?url=...&text=...`

### Social Media Icon Links
- **Component:** Icon font (Font Awesome) or SVG icons
- **Location:** Footer, contact page, about page
- **Platforms:** Facebook, Instagram, Twitter, LinkedIn, etc.
- **Style:** Icon-only or icon with label

### Social Media Embeds (Optional)
- **Instagram Feed:** Embed widget or third-party service
- **Twitter Timeline:** Embedded timeline widget
- **Facebook Page Plugin:** Like box or page embed
- **Usage:** Show social proof, recent posts

---

## Notes on Component Usage

1. **Always reference AppKit first:** Don't create custom components if AppKit has an equivalent
2. **Keep it consistent:** Use the same component styles throughout the site
3. **Mobile-first:** Test all components on mobile devices first
4. **Accessibility:** Ensure all interactive components are keyboard accessible
5. **Performance:** Lazy-load components below the fold when possible
6. **Customization:** Use custom CSS in `/assets/css/custom.css` to override AppKit styles as needed

---

## Quick Reference Links

When implementing, open these AppKit files for reference:
- `index-homepages.html` - Homepage templates and hero sections
- `index-components.html` - Full component library index
- `component-*.html` - Specific component examples
- `page-*.html` - Full page templates for common pages

Copy component HTML from these files and customize with your content.
