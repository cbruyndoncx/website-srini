# Technical Implementation Notes

Technical guidance and code patterns for implementing the static website with AppKit Mobile.

---

## Project Setup

### Directory Structure Creation
```bash
# Create all necessary directories
mkdir -p d2d/pages
mkdir -p d2d/assets/css
mkdir -p d2d/assets/js
mkdir -p d2d/assets/images
mkdir -p d2d/code
```

### AppKit Framework Setup
1. Download AppKit Mobile from source
2. Extract to `/d2d/code/` directory
3. Verify structure includes:
   - `/code/bootstrap/` - Bootstrap core files
   - `/code/css/appkit.min.css` - AppKit styles
   - `/code/js/appkit.min.js` - AppKit JavaScript
   - `/code/plugins/` - Charts.js and other plugins

---

## HTML Template Structure

### Base Page Template
```html
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Page description (150 chars max)">
  <meta name="keywords" content="keyword1, keyword2, keyword3">

  <title>Page Title | Site Name</title>

  <!-- Open Graph Meta Tags -->
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description">
  <meta property="og:image" content="/assets/images/og-image.jpg">
  <meta property="og:url" content="https://yoursite.com/page.html">
  <meta property="og:type" content="website">

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Page Title">
  <meta name="twitter:description" content="Page description">
  <meta name="twitter:image" content="/assets/images/og-image.jpg">

  <!-- Favicon -->
  <link rel="icon" type="image/png" sizes="32x32" href="/assets/images/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/assets/images/favicon-16x16.png">
  <link rel="apple-touch-icon" sizes="180x180" href="/assets/images/apple-touch-icon.png">

  <!-- AppKit CSS -->
  <link rel="stylesheet" href="/code/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="/code/css/appkit.min.css">

  <!-- Custom CSS -->
  <link rel="stylesheet" href="/assets/css/custom.css">

  <!-- PWA Manifest -->
  <link rel="manifest" href="/manifest.json">

  <!-- Theme Color -->
  <meta name="theme-color" content="#007bff">
</head>
<body>
  <!-- Skip to main content link (accessibility) -->
  <a href="#main-content" class="skip-link">Skip to main content</a>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <!-- Navbar content -->
  </nav>

  <!-- Main Content -->
  <main id="main-content">
    <!-- Page-specific content -->
  </main>

  <!-- Footer -->
  <footer class="footer bg-dark text-light">
    <!-- Footer content -->
  </footer>

  <!-- AppKit JavaScript -->
  <script src="/code/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/code/js/appkit.min.js"></script>

  <!-- Custom JavaScript -->
  <script src="/assets/js/custom.js"></script>
</body>
</html>
```

---

## Dark/Light Mode Implementation

### HTML Setup
```html
<!-- Theme toggle button in navbar -->
<button id="theme-toggle" class="btn btn-outline-secondary" aria-label="Toggle dark mode">
  <span id="theme-icon">🌙</span>
</button>
```

### JavaScript Implementation (`/assets/js/custom.js`)
```javascript
// Theme Management
(function() {
  const html = document.documentElement;
  const themeToggle = document.getElementById('theme-toggle');
  const themeIcon = document.getElementById('theme-icon');

  // Check for saved theme preference or default to 'light'
  const currentTheme = localStorage.getItem('theme') || 'light';

  // Check for system preference if no saved theme
  if (!localStorage.getItem('theme')) {
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      setTheme('dark');
    }
  } else {
    setTheme(currentTheme);
  }

  // Theme toggle click handler
  if (themeToggle) {
    themeToggle.addEventListener('click', function() {
      const theme = html.getAttribute('data-theme');
      const newTheme = theme === 'light' ? 'dark' : 'light';
      setTheme(newTheme);
    });
  }

  // Set theme function
  function setTheme(theme) {
    html.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);

    // Update icon
    if (themeIcon) {
      themeIcon.textContent = theme === 'light' ? '🌙' : '☀️';
    }

    // Update meta theme-color
    const metaThemeColor = document.querySelector('meta[name="theme-color"]');
    if (metaThemeColor) {
      metaThemeColor.setAttribute('content', theme === 'light' ? '#007bff' : '#1a1a1a');
    }
  }

  // Listen for system theme changes
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
    if (!localStorage.getItem('theme')) {
      setTheme(e.matches ? 'dark' : 'light');
    }
  });
})();
```

### CSS Variables for Theming (`/assets/css/custom.css`)
```css
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --background-color: #ffffff;
  --text-color: #212529;
  --border-color: #dee2e6;
  --card-bg: #ffffff;
  --navbar-bg: #f8f9fa;
  --footer-bg: #343a40;
}

[data-theme="dark"] {
  --background-color: #1a1a1a;
  --text-color: #e9ecef;
  --border-color: #495057;
  --card-bg: #2d2d2d;
  --navbar-bg: #212529;
  --footer-bg: #000000;
}

body {
  background-color: var(--background-color);
  color: var(--text-color);
  transition: background-color 0.3s ease, color 0.3s ease;
}

.card {
  background-color: var(--card-bg);
  border-color: var(--border-color);
}

.navbar {
  background-color: var(--navbar-bg) !important;
}
```

---

## Form Handling Pattern

### Form HTML Structure
```html
<form id="booking-form" novalidate>
  <div class="mb-3">
    <label for="name" class="form-label">Full Name <span class="text-danger">*</span></label>
    <input type="text" class="form-control" id="name" name="name" required>
    <div class="invalid-feedback">Please enter your name.</div>
  </div>

  <div class="mb-3">
    <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
    <input type="email" class="form-control" id="email" name="email" required>
    <div class="invalid-feedback">Please enter a valid email.</div>
  </div>

  <div class="mb-3">
    <label for="service" class="form-label">Service Type <span class="text-danger">*</span></label>
    <select class="form-select" id="service" name="service" required>
      <option value="">Choose a service...</option>
      <option value="service1">Service 1</option>
      <option value="service2">Service 2</option>
    </select>
    <div class="invalid-feedback">Please select a service.</div>
  </div>

  <div class="mb-3">
    <label for="message" class="form-label">Message</label>
    <textarea class="form-control" id="message" name="message" rows="4"></textarea>
  </div>

  <div class="mb-3 form-check">
    <input type="checkbox" class="form-check-input" id="privacy" name="privacy" required>
    <label class="form-check-label" for="privacy">
      I agree to the <a href="/privacy.html">privacy policy</a> <span class="text-danger">*</span>
    </label>
    <div class="invalid-feedback">You must agree to the privacy policy.</div>
  </div>

  <button type="submit" class="btn btn-primary">Submit Request</button>
</form>
```

### Form Validation JavaScript
```javascript
// Form Validation and Handling
(function() {
  const forms = document.querySelectorAll('form[novalidate]');

  forms.forEach(form => {
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      event.stopPropagation();

      if (form.checkValidity()) {
        handleFormSubmit(form);
      }

      form.classList.add('was-validated');
    });
  });

  function handleFormSubmit(form) {
    // Collect form data
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    // Add timestamp
    data.timestamp = new Date().toISOString();

    // Save to localStorage (demo purposes)
    const storageKey = `form_${form.id}_${Date.now()}`;
    localStorage.setItem(storageKey, JSON.stringify(data));

    // Show success modal
    showSuccessModal(data, form.id);

    // Reset form
    form.reset();
    form.classList.remove('was-validated');
  }

  function showSuccessModal(data, formId) {
    let title = 'Success!';
    let message = 'Thank you for your submission. We will contact you soon.';

    if (formId === 'booking-form') {
      title = 'Booking Request Received';
      message = `Thank you, ${data.name}! We've received your booking request for ${data.service}. We'll contact you at ${data.email} within 24 hours to confirm your appointment.`;
    } else if (formId === 'contact-form') {
      title = 'Message Sent';
      message = `Thank you, ${data.name}! Your message has been received. We'll respond to ${data.email} within 24-48 hours.`;
    }

    // Create and show Bootstrap modal
    const modalHtml = `
      <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="successModalLabel">${title}</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <p>${message}</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    `;

    // Remove existing modal if present
    const existingModal = document.getElementById('successModal');
    if (existingModal) {
      existingModal.remove();
    }

    // Add modal to DOM
    document.body.insertAdjacentHTML('beforeend', modalHtml);

    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('successModal'));
    modal.show();

    // Remove modal from DOM after it's hidden
    document.getElementById('successModal').addEventListener('hidden.bs.modal', function() {
      this.remove();
    });
  }
})();
```

---

## Navigation Active State

### JavaScript for Active Page Highlighting
```javascript
// Highlight active navigation link
(function() {
  const currentPage = window.location.pathname;
  const navLinks = document.querySelectorAll('.navbar-nav .nav-link');

  navLinks.forEach(link => {
    const linkPath = new URL(link.href).pathname;
    if (linkPath === currentPage) {
      link.classList.add('active');
      link.setAttribute('aria-current', 'page');
    }
  });
})();
```

---

## PWA Implementation

### Manifest.json
```json
{
  "name": "Your Business Name",
  "short_name": "Business",
  "description": "Description of your business",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#007bff",
  "orientation": "portrait-primary",
  "icons": [
    {
      "src": "/assets/images/icon-72x72.png",
      "sizes": "72x72",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-96x96.png",
      "sizes": "96x96",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-128x128.png",
      "sizes": "128x128",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-144x144.png",
      "sizes": "144x144",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-152x152.png",
      "sizes": "152x152",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-384x384.png",
      "sizes": "384x384",
      "type": "image/png"
    },
    {
      "src": "/assets/images/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

### Service Worker (sw.js)
```javascript
const CACHE_NAME = 'site-cache-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/pages/services.html',
  '/pages/booking.html',
  '/pages/about.html',
  '/pages/contact.html',
  '/code/bootstrap/css/bootstrap.min.css',
  '/code/css/appkit.min.css',
  '/assets/css/custom.css',
  '/code/bootstrap/js/bootstrap.bundle.min.js',
  '/code/js/appkit.min.js',
  '/assets/js/custom.js',
  '/offline.html'
];

// Install service worker and cache resources
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

// Fetch from cache, fallback to network
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Cache hit - return response
        if (response) {
          return response;
        }

        // Clone the request
        const fetchRequest = event.request.clone();

        return fetch(fetchRequest).then(response => {
          // Check if valid response
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }

          // Clone the response
          const responseToCache = response.clone();

          caches.open(CACHE_NAME)
            .then(cache => {
              cache.put(event.request, responseToCache);
            });

          return response;
        }).catch(() => {
          // Network failed, return offline page
          return caches.match('/offline.html');
        });
      })
  );
});

// Clean up old caches
self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (!cacheWhitelist.includes(cacheName)) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
```

### Service Worker Registration (in custom.js)
```javascript
// Register Service Worker for PWA
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/sw.js')
      .then(registration => {
        console.log('ServiceWorker registration successful');
      })
      .catch(err => {
        console.log('ServiceWorker registration failed: ', err);
      });
  });
}
```

### Offline Page (offline.html)
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Offline | Your Site</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      padding: 50px;
    }
    h1 { color: #333; }
    p { color: #666; }
  </style>
</head>
<body>
  <h1>You're Offline</h1>
  <p>It looks like you've lost your internet connection.</p>
  <p>Please check your connection and try again.</p>
</body>
</html>
```

---

## Image Optimization

### Responsive Images with WebP
```html
<picture>
  <source srcset="/assets/images/hero.webp" type="image/webp">
  <source srcset="/assets/images/hero.jpg" type="image/jpeg">
  <img src="/assets/images/hero.jpg" alt="Description" loading="lazy" class="img-fluid">
</picture>
```

### Lazy Loading
```html
<!-- Native lazy loading -->
<img src="/assets/images/image.jpg" alt="Description" loading="lazy" class="img-fluid">
```

---

## Accessibility Helpers

### Skip to Main Content Link (CSS)
```css
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000;
  color: #fff;
  padding: 8px;
  text-decoration: none;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}
```

### ARIA Labels for Icons
```html
<button aria-label="Close modal">
  <span aria-hidden="true">&times;</span>
</button>
```

---

## Performance Optimization

### Critical CSS Inlining
Extract above-the-fold CSS and inline it in `<style>` tags in the `<head>`, then load the rest asynchronously:

```html
<style>
  /* Critical CSS here */
</style>
<link rel="preload" href="/assets/css/custom.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="/assets/css/custom.css"></noscript>
```

### Defer Non-Critical JavaScript
```html
<script src="/assets/js/custom.js" defer></script>
```

---

## Local Development

### Simple HTTP Server
```bash
# Python 3
cd d2d
python3 -m http.server 8000

# Node.js (with http-server)
npx http-server d2d -p 8000

# PHP
cd d2d
php -S localhost:8000
```

Then visit `http://localhost:8000` in your browser.

---

## Testing Checklist

### Browser Testing
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile Safari (iOS)
- Chrome Mobile (Android)

### Responsive Testing Breakpoints
- 320px (small mobile)
- 375px (iPhone SE)
- 768px (tablet)
- 1024px (desktop)
- 1920px (large desktop)

### Functionality Testing
- All navigation links work
- Forms validate correctly
- Forms show success modals
- Dark/light mode toggles
- Mobile menu opens/closes
- Modals open/close
- Accordions expand/collapse
- Carousels rotate

### Accessibility Testing
- Keyboard navigation (Tab, Enter, Esc)
- Screen reader testing (NVDA, JAWS, VoiceOver)
- Color contrast checker
- Alt text on all images
- ARIA labels on interactive elements

### Performance Testing
- Google Lighthouse audit (aim for 90+ score)
- WebPageTest.org
- Check page load time (<3 seconds)
- Check total page size (<1MB ideally)

---

## Git Ignore Recommendations

Create `.gitignore`:
```
# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo

# Temporary files
*.log
*.tmp

# Build files (if using build tools)
node_modules/
dist/
build/

# Environment files
.env
.env.local
```

---

## Deployment Notes

### Pre-Deployment Checklist
- [ ] Minify CSS and JavaScript
- [ ] Optimize all images
- [ ] Test all forms
- [ ] Test on multiple devices
- [ ] Check all links
- [ ] Remove console.log statements
- [ ] Update meta descriptions
- [ ] Test PWA installation
- [ ] Test offline mode

### Build Commands (if using build tools)
```bash
# Example with minification tools
npx terser assets/js/custom.js -o assets/js/custom.min.js
npx clean-css-cli -o assets/css/custom.min.css assets/css/custom.css
```

### Deployment to Netlify
1. Drag and drop `d2d/` folder to Netlify
2. Configure custom domain
3. SSL is automatic

### Deployment to GitHub Pages
```bash
# Create gh-pages branch
git checkout -b gh-pages

# Push to GitHub
git push origin gh-pages

# Enable GitHub Pages in repo settings
```

---

## Common Issues and Solutions

### Issue: Dark mode flashes on page load
**Solution:** Add inline script in `<head>` before CSS:
```html
<script>
  const theme = localStorage.getItem('theme') || 'light';
  document.documentElement.setAttribute('data-theme', theme);
</script>
```

### Issue: Forms submit to URL with query parameters
**Solution:** Ensure `event.preventDefault()` is called in form handler

### Issue: Modal backdrop stays after closing
**Solution:** Ensure Bootstrap JS is loaded and initialized correctly

### Issue: Service worker not updating
**Solution:** Increment `CACHE_NAME` version number in `sw.js`

### Issue: PWA not installable
**Solution:**
- Check manifest.json is valid
- Ensure HTTPS (required for PWA)
- Verify icons exist at specified paths
- Check service worker is registered

---

## Useful Code Snippets

### Smooth Scrolling to Anchor Links
```javascript
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      target.scrollIntoView({ behavior: 'smooth' });
    }
  });
});
```

### Back to Top Button
```javascript
// Show/hide back to top button
const backToTop = document.getElementById('back-to-top');
if (backToTop) {
  window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
      backToTop.style.display = 'block';
    } else {
      backToTop.style.display = 'none';
    }
  });

  backToTop.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
}
```

### Star Rating Generator
```javascript
function generateStarRating(rating) {
  const fullStar = '★';
  const emptyStar = '☆';
  let stars = '';

  for (let i = 1; i <= 5; i++) {
    stars += i <= rating ? fullStar : emptyStar;
  }

  return `<span class="star-rating" aria-label="${rating} out of 5 stars">${stars}</span>`;
}
```
