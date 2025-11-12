# Page Requirements Specification

Detailed requirements for each page based on the project specification in `plan.md`.

---

## 1. Homepage (`/d2d/index.html`)

### Purpose
Primary landing page that introduces the business and guides visitors to key actions.

### Required Sections
1. **Navigation Bar**
   - Logo (left side)
   - Main navigation links: Services, Booking, About, Contact
   - Theme toggle button (dark/light mode)
   - Mobile hamburger menu

2. **Hero Section**
   - Compelling headline (H1) - value proposition
   - Subheading - brief explanation of what you do
   - Primary CTA button: "Book Now" or "Get Started"
   - Secondary CTA button: "Learn More" (optional)
   - Background: Hero image or gradient

3. **Services Overview**
   - Section heading: "Our Services" or "What We Do"
   - 3-4 service cards in grid layout
   - Each card: Icon, Title, Brief description, "Learn More" link

4. **Why Choose Us / Benefits Section**
   - 3-4 key benefits or unique selling points
   - Icon or image for each benefit
   - Brief explanatory text

5. **Testimonials Section**
   - Section heading: "What Our Customers Say"
   - Carousel with 5-8 customer reviews
   - Each review: Quote, Name, Star rating, Photo (optional)

6. **Call to Action Section**
   - Compelling headline encouraging action
   - CTA button: "Book an Appointment" or "Get in Touch"

7. **Footer**
   - Company info and logo
   - Quick links (Services, About, FAQ, Privacy, Terms)
   - Contact information
   - Social media icons
   - Copyright notice

### Content Needs
- Business name and logo
- Hero headline and subheading text
- 3-4 service descriptions (50-100 words each)
- 3-4 benefit statements
- 5-8 customer testimonials
- Contact information
- Social media URLs

### Technical Requirements
- Responsive at all breakpoints
- Hero image optimized (WebP with JPG fallback)
- Testimonial carousel auto-rotates (5-7 seconds)
- Smooth scroll to sections on anchor link clicks
- Dark mode compatible images/content

---

## 2. Services Page (`/d2d/pages/services.html`)

### Purpose
Detailed overview of all services offered with clear descriptions and benefits.

### Required Sections
1. **Page Header**
   - Page title (H1): "Our Services"
   - Brief intro paragraph about your services

2. **Service Cards Grid**
   - All services displayed as cards
   - Each card contains:
     - Service image or icon
     - Service name (H3)
     - Description (100-200 words)
     - Key features or benefits (bullet list)
     - Pricing info or "Starting at $X" (optional)
     - "Book This Service" CTA button

3. **Service Categories (Optional)**
   - If many services, organize with tabs or accordions
   - Categories might be: By Type, By Industry, By Frequency, etc.

4. **Process Section (Optional)**
   - "How It Works" - 3-5 step process
   - Numbered steps with icons
   - Brief explanation of each step

5. **CTA Section**
   - "Ready to get started?"
   - Book appointment button

### Content Needs
- Comprehensive description of each service (100-200 words)
- Service images or icons
- Pricing information (if applicable)
- Process steps (if applicable)

### Technical Requirements
- Grid layout: 2 columns on tablet, 3 on desktop
- Responsive images
- Accessible accordion/tabs if used
- Links to booking page with service pre-selected (optional)

---

## 3. Booking Page (`/d2d/pages/booking.html`)

### Purpose
Allow visitors to request appointments or services.

### Required Sections
1. **Page Header**
   - Page title (H1): "Book an Appointment" or "Request Service"
   - Brief instructions or what to expect

2. **Booking Form**
   - **Personal Information:**
     - Full Name (text input, required)
     - Email Address (email input, required)
     - Phone Number (tel input, required)

   - **Service Details:**
     - Service Type (select dropdown, required)
     - Preferred Date (date input, required)
     - Preferred Time (time input or select, required)
     - Alternate Date/Time (optional)

   - **Additional Information:**
     - Message/Special Requests (textarea, optional)
     - How did you hear about us? (select, optional)

   - **Consent:**
     - Checkbox: "I agree to the privacy policy" (required)

   - **Submit Button:** "Submit Request"

3. **Information Sidebar (Optional)**
   - What happens after submission
   - Contact information if they have questions
   - Average response time

4. **Success Modal**
   - Appears after form submission
   - Confirms receipt of request
   - Displays submitted information
   - "We'll contact you within 24 hours" message
   - Close button

### Content Needs
- List of all available services for dropdown
- Privacy policy link
- Confirmation message text
- Contact information

### Technical Requirements
- Client-side form validation
- Required field indicators (asterisks)
- Validation error messages (red text below fields)
- Success/error styling for inputs
- Save to localStorage on submit (demo purposes)
- Display success modal programmatically
- Form should not actually submit (prevent default)
- Clear form after successful submission (optional)

### JavaScript Functions Needed
```javascript
// Validate form fields
function validateBookingForm(formData) { }

// Handle form submission
function handleBookingSubmit(event) { }

// Show success modal
function showBookingConfirmation(data) { }

// Save to localStorage
function saveBookingToStorage(data) { }
```

---

## 4. About Page (`/d2d/pages/about.html`)

### Purpose
Tell the company story, build trust, and showcase team/expertise.

### Required Sections
1. **Page Header**
   - Page title (H1): "About Us"
   - Brief tagline or mission statement

2. **Company Story Section**
   - Two-column layout: Text + Image
   - Content: Who you are, how you started, what drives you
   - 300-500 words of engaging narrative

3. **Mission & Values (Optional)**
   - Section heading: "Our Mission" or "What We Stand For"
   - 2-4 core values with brief explanations
   - Icons for each value

4. **Team Section (Optional)**
   - Section heading: "Meet Our Team"
   - Team member cards in grid
   - Each card: Photo, Name, Title, Brief bio (50 words)
   - Social links (LinkedIn, etc.)

5. **Timeline or Milestones (Optional)**
   - Key company achievements
   - Years/dates with descriptions
   - Visual timeline component

6. **CTA Section**
   - "Want to work with us?"
   - Contact or booking button

### Content Needs
- Company story (300-500 words)
- Mission statement
- Core values
- Team member info (names, titles, photos, bios)
- Company images (office, team, etc.)

### Technical Requirements
- Responsive two-column layout (stacks on mobile)
- Optimized images (team photos, company photos)
- Optional: Timeline component or custom styling

---

## 5. Contact Page (`/d2d/pages/contact.html`)

### Purpose
Provide multiple ways to get in touch with the business.

### Required Sections
1. **Page Header**
   - Page title (H1): "Contact Us"
   - Brief intro: "We'd love to hear from you"

2. **Contact Information Cards**
   - **Phone Card:**
     - Phone icon
     - Phone number (clickable tel: link)
     - Business hours

   - **Email Card:**
     - Email icon
     - Email address (clickable mailto: link)
     - Response time expectation

   - **Location Card:**
     - Location icon
     - Physical address (if applicable) or service area
     - Link to map

3. **Contact Form**
   - Name (text input, required)
   - Email (email input, required)
   - Subject (text input or select, optional)
   - Message (textarea, required)
   - Submit button

4. **Map Section**
   - Embedded Google Map or static map image
   - Shows business location or service area
   - Link to open in Google Maps

5. **Social Links**
   - Social media icons with links
   - "Follow us" heading

6. **Success Modal**
   - Appears after form submission
   - Thanks message
   - "We'll respond within 24-48 hours"

### Content Needs
- Phone number
- Email address
- Physical address or service area description
- Business hours
- Social media links
- Map coordinates

### Technical Requirements
- Contact info cards in 3-column grid (stacks on mobile)
- Clickable phone and email links
- Form validation
- Success modal on submission
- Embedded map (iframe or static image)
- Responsive layout

---

## 6. Testimonials Page (`/d2d/pages/testimonials.html`)

### Purpose
Showcase customer reviews and build credibility through social proof.

### Required Sections
1. **Page Header**
   - Page title (H1): "Customer Testimonials" or "Reviews"
   - Subheading: "See what our customers have to say"

2. **Review Grid**
   - Display all testimonials as cards
   - Each review card contains:
     - Star rating (5-star visual)
     - Review text (quote)
     - Customer name
     - Customer photo (optional, can use placeholder)
     - Date (optional)
     - Service received (optional)

3. **Filter Options (Optional)**
   - Filter by service type
   - Filter by rating
   - Sort by date

4. **CTA Section**
   - "Become our next success story"
   - Book appointment button

### Content Needs
- 10-20 customer testimonials
- Customer names (or "Anonymous")
- Customer photos (or use placeholder avatars)
- Star ratings (1-5 stars)
- Services they used (optional)
- Dates of reviews (optional)

### Technical Requirements
- Grid layout: 2-3 columns depending on screen size
- Responsive cards
- Star rating visual (use icons or SVG)
- Optional: JavaScript filter/sort functionality
- Accessible for screen readers (aria-label for star ratings)

### Sample Review Card HTML Structure
```html
<div class="card review-card">
  <div class="card-body">
    <div class="star-rating" aria-label="5 out of 5 stars">
      ★★★★★
    </div>
    <p class="review-text">"Excellent service! Highly recommend."</p>
    <div class="reviewer">
      <img src="avatar.jpg" alt="John Doe">
      <div>
        <p class="reviewer-name">John Doe</p>
        <p class="review-date">March 2024</p>
      </div>
    </div>
  </div>
</div>
```

---

## 7. FAQ Page (`/d2d/pages/faq.html`)

### Purpose
Answer common customer questions and reduce support inquiries.

### Required Sections
1. **Page Header**
   - Page title (H1): "Frequently Asked Questions"
   - Intro text: "Find answers to common questions below"

2. **FAQ Categories** (if many questions)
   - Section headings for different categories:
     - General Questions
     - Services & Pricing
     - Booking & Scheduling
     - Policies
     - Technical Support

3. **Accordion Component**
   - Each question/answer pair in an accordion item
   - Question as accordion header (clickable)
   - Answer as accordion body (expands on click)
   - 10-20 total Q&A pairs

4. **Search Box (Optional)**
   - Input field: "Search FAQs..."
   - JavaScript filters questions in real-time

5. **Still Have Questions Section**
   - "Didn't find what you're looking for?"
   - Contact us link or button

### Content Needs
- 10-20 question and answer pairs
- Organized by category
- Clear, concise answers (50-150 words each)

### Technical Requirements
- Accordion component from AppKit
- Only one accordion open at a time (optional)
- Smooth expand/collapse animation
- Optional: Search filter functionality
- Accessible (keyboard navigable, ARIA labels)

### Sample FAQ Structure
```
Q: What services do you offer?
A: We offer [list of services]. Each service includes...

Q: How do I book an appointment?
A: You can book through our online booking form or call us at...

Q: What are your business hours?
A: We're open Monday-Friday 9am-6pm, Saturday 10am-4pm...

Q: What is your cancellation policy?
A: We require 24 hours notice for cancellations...
```

---

## 8. Pricing Page (`/d2d/pages/pricing.html`)

### Purpose
Display pricing tiers or service costs transparently.

### Required Sections
1. **Page Header**
   - Page title (H1): "Pricing" or "Our Plans"
   - Subheading: Brief explanation of pricing structure

2. **Pricing Toggle (Optional)**
   - Toggle switch: Monthly / Annually
   - Shows different pricing based on billing period
   - Highlight savings for annual billing

3. **Pricing Cards**
   - 2-4 pricing tiers (e.g., Basic, Standard, Premium)
   - Each card contains:
     - Tier name
     - Price (large, prominent)
     - Billing period (/month, /year, one-time)
     - Feature list with checkmarks
     - CTA button: "Choose Plan" or "Get Started"
   - Highlight recommended tier (border, badge, color)

4. **Feature Comparison Table (Alternative Layout)**
   - Table with tiers as columns
   - Features as rows
   - Checkmarks or X for each tier
   - Sticky header on scroll

5. **Additional Information**
   - Payment methods accepted
   - Money-back guarantee (if applicable)
   - Custom quote option for enterprise

6. **FAQ or Notes**
   - Common pricing questions
   - What's included in each tier
   - Additional costs or fees

### Content Needs
- Pricing tier names
- Prices for each tier
- List of features for each tier (10-15 features)
- Payment method icons
- Any disclaimers or notes

### Technical Requirements
- Grid layout for pricing cards (3-4 columns on desktop)
- Responsive: stack on mobile
- Highlight/emphasize recommended tier
- Optional: Toggle switches prices with JavaScript
- Accessible pricing table
- CTA buttons link to booking page (with tier pre-selected)

---

## 9. Locations Page (`/d2d/pages/locations.html`)

### Purpose
Display service areas or physical locations.

### Required Sections
1. **Page Header**
   - Page title (H1): "Service Locations" or "Where We Serve"
   - Intro: "We proudly serve the following areas"

2. **Location Cards**
   - Each location card contains:
     - Location name (H3)
     - Address (if physical location)
     - Phone number (specific to location, if applicable)
     - Hours of operation
     - Services available at this location (if different)
     - Map link or embedded small map
     - "Get Directions" button

3. **Map View (Optional)**
   - Large map with pins for all locations
   - Click pin to see location details

4. **Service Area Description (Alternative)**
   - If no physical locations, describe service area
   - List of cities/regions served
   - Radius from main location

### Content Needs
- Location names and addresses
- Phone numbers
- Hours for each location
- Map coordinates

### Technical Requirements
- Grid layout for location cards
- Responsive cards
- Embedded maps or static map images
- Clickable phone numbers and addresses
- Optional: Interactive map with multiple pins

---

## 10. Blog/News Page (Optional)

### Purpose
Share updates, tips, industry news, or company announcements.

### Page Structure

#### Blog Index (`/d2d/pages/blog.html`)
1. **Page Header**
   - Page title (H1): "Blog" or "News & Updates"
   - Subheading or intro text

2. **Featured Article (Optional)**
   - Large card with latest/most important article
   - Featured image
   - Title, excerpt, read more link

3. **Article Grid**
   - Grid of article preview cards
   - Each card:
     - Thumbnail image
     - Category tag
     - Article title (linked)
     - Excerpt (100 words)
     - Date published
     - Author (optional)
     - "Read More" link

4. **Pagination (Optional)**
   - If many articles
   - Previous/Next navigation
   - Page numbers

#### Individual Article Page (`/d2d/pages/blog/article-title.html`)
1. **Article Header**
   - Article title (H1)
   - Date published
   - Author name/photo
   - Category tags

2. **Article Content**
   - Full article text
   - Images, headings, lists as needed
   - Properly formatted with semantic HTML

3. **Social Sharing**
   - Share buttons: Facebook, Twitter, LinkedIn, Email

4. **Related Articles**
   - 3-4 related article cards
   - Similar categories or topics

5. **Comments (Optional)**
   - Comment form or third-party widget (Disqus, etc.)
   - Note: This adds complexity to static site

### Content Needs
- 5-10 articles to start
- Article content (500-1000 words each)
- Featured images for each article
- Author information
- Categories/tags

### Technical Requirements
- Responsive article grid
- Optimized images
- Readable typography for long-form content
- Social sharing functionality
- Each article is a separate HTML file

---

## Global Requirements (All Pages)

### Header/Navigation
- Consistent across all pages
- Active page highlighted in navigation
- Responsive hamburger menu on mobile
- Logo links to homepage
- Theme toggle in consistent location

### Footer
- Identical on all pages
- Contains:
  - Company logo and tagline
  - Quick links section
  - Contact information
  - Social media icons
  - Legal links (Privacy Policy, Terms of Service)
  - Copyright notice

### Meta Tags (Every Page)
```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Page Title | Site Name</title>
<meta name="description" content="Unique 150-character description">
<meta name="keywords" content="relevant, keywords">

<!-- Open Graph -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Description">
<meta property="og:image" content="/assets/images/og-image.jpg">
<meta property="og:url" content="https://yoursite.com/page.html">

<!-- Favicon -->
<link rel="icon" href="/assets/images/favicon.ico">
<link rel="apple-touch-icon" href="/assets/images/apple-touch-icon.png">
```

### Accessibility (Every Page)
- Semantic HTML5 structure
- ARIA labels on interactive elements
- Alt text on all images
- Sufficient color contrast (WCAG AA)
- Keyboard navigable
- Skip to main content link

### Performance (Every Page)
- Minified CSS and JS
- Optimized images (WebP with fallbacks)
- Lazy loading for below-fold images
- Minimal external dependencies

---

## Priority Order for Implementation

1. **Phase 1 (MVP):**
   - Homepage
   - Services page
   - Booking page
   - Contact page

2. **Phase 2:**
   - About page
   - Testimonials page
   - FAQ page

3. **Phase 3:**
   - Pricing page (if needed)
   - Locations page (if needed)
   - Blog (if needed)

Start with Phase 1 to get a functional website, then add Phase 2 and 3 pages based on business needs.
