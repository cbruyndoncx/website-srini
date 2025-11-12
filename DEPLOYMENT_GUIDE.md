# Deployment Guide - Website Template

This guide will help you deploy a new website using this template system.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Pre-Deployment Checklist](#pre-deployment-checklist)
3. [Content Replacement Process](#content-replacement-process)
4. [Testing Before Deployment](#testing-before-deployment)
5. [Deployment Options](#deployment-options)
6. [Post-Deployment](#post-deployment)
7. [Troubleshooting](#troubleshooting)

---

## Quick Start

### For Each New Website:

1. **Clone the template**
   ```bash
   cp -r d2d/ ../new-website-name/
   cd ../new-website-name/
   ```

2. **Find all STUB placeholders**
   ```bash
   grep -roh "STUB_[A-Z_0-9]*" . | sort -u > stubs-list.txt
   ```

3. **Replace content systematically** (see [Content Replacement Process](#content-replacement-process))

4. **Add images** to `assets/images/` directories

5. **Test locally**
   ```bash
   python3 -m http.server 8000
   # Visit http://localhost:8000
   ```

6. **Deploy** (see [Deployment Options](#deployment-options))

---

## Pre-Deployment Checklist

### Content Preparation

- [ ] Company information gathered (name, tagline, description)
- [ ] All service details written (names, descriptions, features, pricing)
- [ ] Contact information confirmed (phone, email, address, hours)
- [ ] Social media URLs collected
- [ ] SEO keywords researched
- [ ] All copy proofread and approved
- [ ] Testimonials/reviews collected (with permissions)
- [ ] FAQ questions and answers prepared

### Assets Preparation

- [ ] Logo files ready (light and dark versions)
- [ ] Favicon files generated (16x16, 32x32, 180x180)
- [ ] PWA icons created (72x72, 96x96, 128x128, 144x144, 152x152, 192x192, 384x384, 512x512)
- [ ] Hero image prepared
- [ ] Service images (4 images minimum)
- [ ] Team/customer photos (3+ for testimonials)
- [ ] Social share image (1200x630 recommended)
- [ ] All images optimized (compressed, correct dimensions)
- [ ] WebP versions created for key images

---

## Content Replacement Process

### Step 1: Create Replacement Script

Create a file called `replace-stubs.sh`:

```bash
#!/bin/bash

# Company Information
find . -type f -name "*.html" -exec sed -i 's/STUB_COMPANY_NAME/Your Company Name/g' {} +
find . -type f -name "*.html" -exec sed -i 's/STUB_TAGLINE/Your Tagline Here/g' {} +
find . -type f -name "*.html" -exec sed -i 's/STUB_WEBSITE_URL/https:\/\/yourwebsite.com/g' {} +

# Contact Information
find . -type f -name "*.html" -exec sed -i 's/STUB_PHONE_NUMBER/(555) 123-4567/g' {} +
find . -type f -name "*.html" -exec sed -i 's/STUB_EMAIL/info@yourcompany.com/g' {} +
find . -type f -name "*.html" -exec sed -i 's/STUB_ADDRESS/123 Main St, City, State 12345/g' {} +

# Add more replacements as needed...
```

Make it executable and run:
```bash
chmod +x replace-stubs.sh
./replace-stubs.sh
```

### Step 2: Manual Replacement (Alternative)

Use your text editor's find and replace across files:

1. Open project in VS Code, Sublime, or similar
2. Use "Find in Files" (Ctrl/Cmd + Shift + F)
3. Search for: `STUB_COMPANY_NAME`
4. Replace with: `Actual Company Name`
5. Replace all occurrences
6. Repeat for each STUB placeholder

### Step 3: Verify All Replaced

```bash
# Check for any remaining STUB_ placeholders
grep -r "STUB_" . --exclude-dir=node_modules --exclude-dir=.git

# Should return no results when complete
```

### Step 4: Update Manifest

Edit `manifest.json`:
```json
{
  "name": "Your Actual Company Name",
  "short_name": "YourCo",
  "description": "Your actual description",
  ...
}
```

---

## Testing Before Deployment

### Local Testing

1. **Start local server:**
   ```bash
   cd d2d
   python3 -m http.server 8000
   ```

2. **Test all pages:**
   - [ ] Homepage loads correctly
   - [ ] All navigation links work
   - [ ] Services page displays all services
   - [ ] Booking form validates and submits
   - [ ] Contact form validates and submits
   - [ ] All images load properly
   - [ ] No broken links

3. **Test responsive design:**
   - [ ] Mobile view (320px, 375px, 414px)
   - [ ] Tablet view (768px, 1024px)
   - [ ] Desktop view (1280px, 1920px)
   - Use browser DevTools responsive mode

4. **Test dark mode:**
   - [ ] Toggle switches correctly
   - [ ] All elements visible in dark mode
   - [ ] Theme preference persists

5. **Test forms:**
   - [ ] Required field validation works
   - [ ] Email validation works
   - [ ] Form submission shows success modal
   - [ ] Data saved to localStorage (check DevTools)

### Cross-Browser Testing

Test on:
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] Mobile Safari (iOS)
- [ ] Chrome Mobile (Android)

### Accessibility Testing

```bash
# Use tools like:
# - axe DevTools browser extension
# - WAVE browser extension
# - Lighthouse in Chrome DevTools
```

- [ ] All images have alt text
- [ ] Forms have proper labels
- [ ] Keyboard navigation works (Tab, Enter, Esc)
- [ ] Color contrast meets WCAG AA standards
- [ ] Screen reader compatible

### Performance Testing

```bash
# Run Lighthouse audit in Chrome DevTools
# Aim for scores of 90+ in all categories
```

- [ ] Performance score 90+
- [ ] Accessibility score 90+
- [ ] Best Practices score 90+
- [ ] SEO score 90+
- [ ] PWA installable

---

## Deployment Options

### Option 1: Netlify (Recommended for Beginners)

**Steps:**
1. Create account at [netlify.com](https://netlify.com)
2. Drag and drop the `d2d/` folder onto Netlify dashboard
3. Configure custom domain (optional)
4. SSL certificate is automatic

**Via Git (Continuous Deployment):**
```bash
# Initialize git if not already done
git init
git add .
git commit -m "Initial deployment"

# Push to GitHub
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main

# Connect repository in Netlify dashboard
# Set build command: (leave empty for static site)
# Set publish directory: d2d
```

### Option 2: Vercel

**Steps:**
1. Install Vercel CLI: `npm install -g vercel`
2. Navigate to project: `cd d2d`
3. Deploy: `vercel`
4. Follow prompts

**Configuration** (`vercel.json`):
```json
{
  "version": 2,
  "public": true,
  "cleanUrls": true
}
```

### Option 3: GitHub Pages

**Steps:**
1. Create GitHub repository
2. Push code to repository
3. Go to Settings → Pages
4. Set source to main branch and `/d2d` folder
5. Save and wait for deployment

**Custom Domain:**
- Add `CNAME` file in `d2d/` with your domain
- Configure DNS with your domain provider

### Option 4: Cloudflare Pages

**Steps:**
1. Sign up at [pages.cloudflare.com](https://pages.cloudflare.com)
2. Connect your Git repository
3. Set build settings:
   - Build command: (leave empty)
   - Build output directory: `d2d`
4. Deploy

### Option 5: Traditional Web Hosting (cPanel, etc.)

**Steps:**
1. Connect via FTP/SFTP
2. Upload contents of `d2d/` folder to `public_html/` or `www/`
3. Ensure permissions are set correctly (644 for files, 755 for directories)
4. Test the website

---

## Post-Deployment

### 1. Verify Deployment

- [ ] Visit live URL and test all pages
- [ ] Test forms on live site
- [ ] Verify SSL certificate is active (https)
- [ ] Test on mobile devices
- [ ] Test PWA installation

### 2. Submit to Search Engines

**Google Search Console:**
```bash
# Submit sitemap
https://yourwebsite.com/sitemap.xml
```

1. Go to [search.google.com/search-console](https://search.google.com/search-console)
2. Add property (your website URL)
3. Verify ownership
4. Submit sitemap
5. Request indexing for key pages

**Bing Webmaster Tools:**
1. Go to [bing.com/webmasters](https://www.bing.com/webmasters)
2. Add site
3. Verify ownership
4. Submit sitemap

### 3. Set Up Analytics (Optional)

**Google Analytics:**
1. Create account at [analytics.google.com](https://analytics.google.com)
2. Get tracking code
3. Add before `</head>` in all HTML files:
   ```html
   <!-- Google Analytics -->
   <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
   <script>
     window.dataLayer = window.dataLayer || [];
     function gtag(){dataLayer.push(arguments);}
     gtag('js', new Date());
     gtag('config', 'GA_MEASUREMENT_ID');
   </script>
   ```

### 4. Create Sitemap

Create `d2d/sitemap.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yourwebsite.com/</loc>
    <lastmod>2025-01-12</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://yourwebsite.com/pages/services.html</loc>
    <lastmod>2025-01-12</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://yourwebsite.com/pages/booking.html</loc>
    <lastmod>2025-01-12</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://yourwebsite.com/pages/contact.html</loc>
    <lastmod>2025-01-12</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
</urlset>
```

### 5. Create robots.txt

Create `d2d/robots.txt`:
```
User-agent: *
Allow: /

Sitemap: https://yourwebsite.com/sitemap.xml
```

### 6. Monitor and Maintain

- Set up uptime monitoring (e.g., UptimeRobot, Pingdom)
- Monitor analytics regularly
- Keep content fresh and updated
- Respond to form submissions promptly
- Update service worker cache version when making changes

---

## Troubleshooting

### Common Issues

**Issue: STUB_ placeholders still visible**
```bash
# Find remaining stubs
grep -r "STUB_" d2d/ --exclude-dir=node_modules
```
Solution: Replace all remaining stubs manually

**Issue: Images not loading**
- Check file paths are correct
- Ensure images are in correct directories
- Verify file names match exactly (case-sensitive)
- Check file permissions (should be 644)

**Issue: Forms not working**
- Check browser console for JavaScript errors
- Verify Bootstrap JS is loading
- Test form validation
- Check that custom.js is loading

**Issue: Dark mode not working**
- Check that theme toggle button exists
- Verify custom.js is loaded
- Check browser console for errors
- Clear localStorage and try again

**Issue: PWA not installing**
- Check manifest.json is valid JSON
- Verify all icon files exist
- Ensure site is served over HTTPS
- Check browser console for SW errors

**Issue: Page not responsive**
- Verify Bootstrap CSS is loading
- Check viewport meta tag is present
- Test in browser DevTools responsive mode
- Review custom CSS for fixed widths

### Debugging Tools

**Browser Console:**
```javascript
// Check localStorage
console.log(localStorage);

// Check service worker
navigator.serviceWorker.getRegistrations().then(console.log);

// Check theme
console.log(document.documentElement.getAttribute('data-bs-theme'));
```

**Validation Tools:**
- HTML: [validator.w3.org](https://validator.w3.org/)
- CSS: [jigsaw.w3.org/css-validator](https://jigsaw.w3.org/css-validator/)
- Links: [validator.w3.org/checklink](https://validator.w3.org/checklink)
- Accessibility: [wave.webaim.org](https://wave.webaim.org/)

---

## Updating Existing Websites

### Content Updates

1. Edit HTML files directly
2. Test locally
3. Deploy changes
4. Update cache version in sw.js if needed

### Adding New Pages

1. Copy an existing page as template
2. Update content
3. Add navigation link
4. Update sitemap.xml
5. Test and deploy

### Updating Service Worker

When making significant changes:
1. Update `CACHE_NAME` version in `sw.js`:
   ```javascript
   const CACHE_NAME = 'site-cache-v2'; // increment version
   ```
2. Deploy changes
3. Users will get updated version automatically

---

## Support and Resources

### Documentation
- **Bootstrap 5:** [getbootstrap.com/docs/5.3](https://getbootstrap.com/docs/5.3/)
- **PWA:** [web.dev/progressive-web-apps](https://web.dev/progressive-web-apps/)
- **MDN Web Docs:** [developer.mozilla.org](https://developer.mozilla.org/)

### Tools
- **Image Optimization:** [squoosh.app](https://squoosh.app/)
- **Favicon Generator:** [favicon.io](https://favicon.io/)
- **SEO Checker:** [seobility.net](https://www.seobility.net/)
- **Lighthouse:** Built into Chrome DevTools

### Hosting Support
- **Netlify Docs:** [docs.netlify.com](https://docs.netlify.com/)
- **Vercel Docs:** [vercel.com/docs](https://vercel.com/docs)
- **GitHub Pages Docs:** [docs.github.com/pages](https://docs.github.com/pages)

---

**Last Updated:** 2025-01-12
**Template Version:** 1.0
