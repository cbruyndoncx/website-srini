# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a static commercial website built with **AppKit Mobile** - a Bootstrap 5-based mobile-first framework with Progressive Web App (PWA) capabilities. The entire site is client-side only with zero backend dependencies.

**Key Technologies:**
- HTML5, CSS3, Vanilla JavaScript
- AppKit Mobile (Bootstrap 5.x - no jQuery)
- Charts.js for data visualization
- localStorage/sessionStorage for client-side data persistence
- PWA features: service workers, manifest, offline support

## Project Structure

```
/d2d/                          # Website root & entry point
├── index.html                 # Main landing page
├── /pages/                    # All static HTML pages
│   ├── services.html
│   ├── booking.html
│   ├── about.html
│   ├── contact.html
│   ├── testimonials.html
│   ├── faq.html
│   ├── locations.html
│   └── pricing.html
├── /assets/
│   ├── /css/                  # Custom stylesheets & SCSS
│   ├── /js/                   # Custom JavaScript files
│   └── /images/               # Logo, photos, icons
└── /code/                     # AppKit template library
    ├── index-homepages.html   # Homepage templates
    ├── index-components.html  # Component library
    ├── /bootstrap/            # Bootstrap core files
    └── /plugins/              # AppKit plugins (Charts.js, PWA, etc.)
```

## Architecture & Design Principles

### Component-First Approach
**Always use AppKit Mobile components** - never create custom components when AppKit equivalents exist. Reference the component library in `/code/index-components.html` for all UI elements.

### Key AppKit Components
- **Layout:** Grid system, Cards, Tabs, Accordions
- **Interactive:** Modals, Action Sheets, Toasts, Programmatic APIs
- **Forms:** Styled inputs, textareas, selects, checkboxes, toggles
- **Data Display:** Pricing tables, review cards, Charts.js integration, list groups
- **Media:** Carousels/sliders, image galleries, video embeds
- **Theming:** Dark/Light mode with auto-detection, color packs, highlight colors

### Static Content Strategy
Since this is a fully static site with no backend:
- **Forms:** Use `mailto:` actions or localStorage for demos with confirmation modals
- **Testimonials:** Hard-coded HTML cards, optionally randomized via JavaScript arrays
- **Blog/News:** Each article is a separate HTML file; manually update index
- **Search:** Client-side JavaScript filtering of current page content only
- **Analytics/Charts:** Charts.js with hard-coded sample data for demonstration

### Progressive Web App (PWA)
- Configure `manifest.json` with app name, icons, theme colors, display mode
- Implement service worker for offline caching of static assets
- Add "Add to Home Screen" capability using AppKit's PWA plugin
- Create offline fallback page for when network is unavailable
- Include app icons in multiple sizes (192x192, 512x512)

### Theme System
- **Dark/Light Mode:** Auto-detection based on device preference + manual toggle
- **Smart AppKit:** Different content/images for light vs. dark mode
- **Color Packs:** Use AppKit's pre-built color schemes or customize
- **Persistence:** Save user theme preference in localStorage

## Development Guidelines

### File Organization
- All pages are standalone HTML files in `/pages/` directory
- Custom CSS goes in `/assets/css/` - keep AppKit core files separate
- Custom JavaScript in `/assets/js/` for interactions and client-side logic
- Images and media in `/assets/images/`

### HTML Structure
Each page should include:
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title | Site Name</title>

  <!-- SEO Meta Tags -->
  <meta name="description" content="150-character description">
  <meta name="keywords" content="relevant, keywords">

  <!-- Open Graph for social sharing -->
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description">
  <meta property="og:image" content="/assets/images/social-share.jpg">

  <!-- AppKit CSS -->
  <link rel="stylesheet" href="/code/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="/code/css/appkit.min.css">
  <link rel="stylesheet" href="/assets/css/custom.css">

  <!-- PWA Manifest -->
  <link rel="manifest" href="/manifest.json">
</head>
<body>
  <!-- AppKit Navbar -->
  <!-- Page Content -->
  <!-- AppKit Footer -->

  <!-- AppKit JavaScript -->
  <script src="/code/js/appkit.min.js"></script>
  <script src="/assets/js/custom.js"></script>
</body>
</html>
```

### Form Handling Pattern
```javascript
// Client-side form validation and handling
document.getElementById('form-id').addEventListener('submit', function(e) {
  e.preventDefault();

  // Validate inputs
  const formData = {
    // collect form data
  };

  // Save to localStorage for demo purposes
  localStorage.setItem('lastSubmission', JSON.stringify(formData));

  // Show AppKit modal confirmation
  showModal('Success', 'Thank you! We will contact you soon.');
});
```

### Responsive Design
- Mobile-first approach (AppKit is optimized for mobile)
- Test on multiple screen sizes: mobile (320px+), tablet (768px+), desktop (1024px+)
- Use AppKit's responsive grid system
- Ensure touch-optimized interactions

### Accessibility Requirements
- Include ARIA labels and roles on interactive elements
- Support keyboard navigation (tab order, focus states)
- Maintain WCAG AA color contrast ratios
- Add alt text to all images
- Use semantic HTML5 (header, main, nav, footer)
- Include skip-to-content link for screen readers

## Performance & Optimization

- Minify CSS/JS files for production
- Lazy-load images below the fold
- Optimize images (use WebP with fallbacks)
- Limit third-party scripts to essentials
- Leverage browser caching for static assets
- Keep total page size under 1MB for fast mobile load times

## SEO Best Practices

- Unique title and meta description per page
- Semantic HTML5 structure throughout
- Descriptive alt text on all images
- Clean, readable URLs (e.g., `/services.html` not `/page2.html`)
- Internal linking between related pages
- Create `sitemap.xml` for search engine crawlers
- Include structured data (JSON-LD) for LocalBusiness

## Deployment

This site can be deployed to any static hosting platform:
- **Netlify:** Drag-and-drop deployment, free SSL
- **Vercel:** Git integration, instant deployments
- **GitHub Pages:** Free hosting, custom domain support
- **Cloudflare Pages:** Fast CDN, unlimited bandwidth
- **Firebase Hosting:** Google infrastructure

Before deploying:
1. Minify CSS and JavaScript files
2. Optimize and compress all images
3. Test on multiple devices and browsers
4. Validate HTML/CSS with W3C validators
5. Test PWA functionality (install, offline mode)
6. Configure custom domain and SSL certificate

## Component Reference Map

When building pages, reference these AppKit components:

| Website Section | AppKit Component Source | Component Type |
|----------------|------------------------|----------------|
| Homepage Hero | `index-homepages.html` | Hero section with CTA buttons |
| Service Cards | `component-card-content.html` | Card grid with images/icons |
| Booking Form | `component-inputs.html` + Modals | Form components + confirmation modal |
| About Us | `index-pages.html` | Standard content page layout |
| Contact Form | `page-contact.html` | Contact page template with form |
| Testimonials | `component-reviews.html` | Review cards with ratings |
| FAQ Section | `component-accordions.html` | Accordion expand/collapse |
| Location List | `page-places.html` | Card columns with location details |
| Pricing Tiers | `component-pricing.html` | Comparison pricing tables |
| News/Blog | `list-content.html` | Article list with previews |
| Social Share | `component-sharing.html` | Social media share buttons |
| Theme Toggle | `highlights.html` + `component-colors.html` | Dark mode + color switcher |
| Charts/Stats | Charts.js integration | Data visualization components |

## Important Constraints

- **No Backend:** All functionality must be client-side only
- **No jQuery:** AppKit Bootstrap 5.x version doesn't use jQuery
- **No User-Generated Content:** All content is pre-approved and hard-coded
- **No Real Form Submission:** Forms are demo-only using localStorage or mailto:
- **Static Updates:** Content changes require manual HTML/JS file edits
- **Client-Side Only:** Use localStorage/sessionStorage for any data persistence needs

## Reference Documentation

Full project specification is available in `plan.md` which includes:
- Detailed component integration guide
- PWA implementation details
- Theming and branding customization
- Complete page structure examples
- Step-by-step implementation checklist
