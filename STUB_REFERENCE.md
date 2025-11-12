# STUB Reference Guide

This document lists ALL content placeholders (STUB_xxx) used throughout the website template. Replace these with actual content for each new website deployment.

## Quick Search and Replace

To find all remaining stubs in your project:
```bash
grep -r "STUB_" d2d/ | wc -l
```

To list all unique stubs:
```bash
grep -roh "STUB_[A-Z_0-9]*" d2d/ | sort -u
```

---

## Global Stubs (Used Across Multiple Pages)

### Company Information
- `STUB_COMPANY_NAME` - Your company/business name
- `STUB_TAGLINE` - Company tagline or slogan
- `STUB_WEBSITE_URL` - Full website URL (e.g., https://example.com)
- `STUB_COMPANY_SHORT_DESCRIPTION` - Brief company description (2-3 sentences)
- `STUB_FOOTER_COMPANY_DESCRIPTION` - Footer company description

### Contact Information
- `STUB_PHONE_NUMBER` - Business phone number
- `STUB_EMAIL` - Business email address
- `STUB_ADDRESS` - Full business address
- `STUB_BUSINESS_HOURS` - Operating hours

### Social Media
- `STUB_FACEBOOK_URL` - Facebook page URL
- `STUB_TWITTER_URL` - Twitter/X profile URL
- `STUB_INSTAGRAM_URL` - Instagram profile URL
- `STUB_LINKEDIN_URL` - LinkedIn company page URL

### Navigation Labels
- `STUB_NAV_HOME` - Home nav link text (default: "Home")
- `STUB_NAV_SERVICES` - Services nav link text (default: "Services")
- `STUB_NAV_BOOKING` - Booking nav link text (default: "Book Now")
- `STUB_NAV_CONTACT` - Contact nav link text (default: "Contact")

### Footer Sections
- `STUB_FOOTER_QUICK_LINKS_TITLE` - Quick Links section title
- `STUB_FOOTER_SERVICES_TITLE` - Services section title
- `STUB_FOOTER_CONTACT_TITLE` - Contact section title
- `STUB_COPYRIGHT_TEXT` - Copyright text (e.g., "© 2025 Company Name. All rights reserved.")

### Button Text
- `STUB_BOOK_NOW_TEXT` - "Book Now" button text
- `STUB_CALL_US_BUTTON` - "Call Us" button text
- `STUB_CONTACT_US_BUTTON` - "Contact Us" button text
- `STUB_CLOSE_BUTTON_TEXT` - "Close" button text
- `STUB_GO_HOME_BUTTON_TEXT` - "Go Home" button text

---

## Homepage (index.html)

### SEO & Meta Tags
- `STUB_META_DESCRIPTION` - Homepage meta description (150-160 characters)
- `STUB_KEYWORD1` through `STUB_KEYWORD5` - SEO keywords
- `STUB_HOME_OG_TITLE` - Open Graph title for social sharing
- `STUB_HOME_OG_DESCRIPTION` - Open Graph description
- `STUB_OG_IMAGE_URL` - Open Graph image URL

### Hero Section
- `STUB_HERO_HEADLINE` - Main hero headline
- `STUB_HERO_SUBHEADLINE` - Hero subheadline/description
- `STUB_HERO_CTA_PRIMARY` - Primary CTA button text
- `STUB_HERO_CTA_SECONDARY` - Secondary CTA button text
- `STUB_HERO_IMAGE_URL` - Hero image URL
- `STUB_HERO_IMAGE_ALT` - Hero image alt text

### Benefits Section
- `STUB_BENEFITS_SECTION_TITLE` - Benefits section heading
- `STUB_BENEFITS_SECTION_SUBTITLE` - Benefits section subheading
- `STUB_BENEFIT_1_TITLE` - First benefit title
- `STUB_BENEFIT_1_DESCRIPTION` - First benefit description
- `STUB_BENEFIT_2_TITLE` - Second benefit title
- `STUB_BENEFIT_2_DESCRIPTION` - Second benefit description
- `STUB_BENEFIT_3_TITLE` - Third benefit title
- `STUB_BENEFIT_3_DESCRIPTION` - Third benefit description

### Services Overview
- `STUB_SERVICES_SECTION_TITLE` - Services section heading
- `STUB_SERVICES_SECTION_SUBTITLE` - Services section subheading
- `STUB_SERVICE_1_NAME` - First service name
- `STUB_SERVICE_1_SHORT_DESCRIPTION` - First service short description
- `STUB_SERVICE_1_IMAGE_URL` - First service image URL
- `STUB_SERVICE_1_IMAGE_ALT` - First service image alt text
- `STUB_SERVICE_2_NAME` - Second service name
- `STUB_SERVICE_2_SHORT_DESCRIPTION` - Second service short description
- `STUB_SERVICE_2_IMAGE_URL` - Second service image URL
- `STUB_SERVICE_2_IMAGE_ALT` - Second service image alt text
- `STUB_SERVICE_3_NAME` - Third service name
- `STUB_SERVICE_3_SHORT_DESCRIPTION` - Third service short description
- `STUB_SERVICE_3_IMAGE_URL` - Third service image URL
- `STUB_SERVICE_3_IMAGE_ALT` - Third service image alt text
- `STUB_SERVICE_4_NAME` - Fourth service name
- `STUB_SERVICE_4_SHORT_DESCRIPTION` - Fourth service short description
- `STUB_SERVICE_4_IMAGE_URL` - Fourth service image URL
- `STUB_SERVICE_4_IMAGE_ALT` - Fourth service image alt text

### Statistics Section
- `STUB_STAT_1_NUMBER` - First statistic number (e.g., "500+")
- `STUB_STAT_1_LABEL` - First statistic label
- `STUB_STAT_2_NUMBER` - Second statistic number
- `STUB_STAT_2_LABEL` - Second statistic label
- `STUB_STAT_3_NUMBER` - Third statistic number
- `STUB_STAT_3_LABEL` - Third statistic label
- `STUB_STAT_4_NUMBER` - Fourth statistic number
- `STUB_STAT_4_LABEL` - Fourth statistic label

### Testimonials Section
- `STUB_TESTIMONIALS_SECTION_TITLE` - Testimonials section heading
- `STUB_TESTIMONIALS_SECTION_SUBTITLE` - Testimonials section subheading
- `STUB_TESTIMONIAL_1_QUOTE` - First customer testimonial quote
- `STUB_TESTIMONIAL_1_NAME` - First customer name
- `STUB_TESTIMONIAL_1_TITLE` - First customer title/location
- `STUB_TESTIMONIAL_1_IMAGE_URL` - First customer image URL
- `STUB_TESTIMONIAL_2_QUOTE` - Second customer testimonial quote
- `STUB_TESTIMONIAL_2_NAME` - Second customer name
- `STUB_TESTIMONIAL_2_TITLE` - Second customer title/location
- `STUB_TESTIMONIAL_2_IMAGE_URL` - Second customer image URL
- `STUB_TESTIMONIAL_3_QUOTE` - Third customer testimonial quote
- `STUB_TESTIMONIAL_3_NAME` - Third customer name
- `STUB_TESTIMONIAL_3_TITLE` - Third customer title/location
- `STUB_TESTIMONIAL_3_IMAGE_URL` - Third customer image URL

### CTA Section
- `STUB_CTA_TITLE` - Call-to-action title
- `STUB_CTA_SUBTITLE` - Call-to-action subtitle
- `STUB_CTA_BUTTON_TEXT` - CTA button text

---

## Services Page (pages/services.html)

### SEO & Meta Tags
- `STUB_SERVICES_META_DESCRIPTION` - Services page meta description
- `STUB_SERVICES_META_KEYWORDS` - Services page meta keywords
- `STUB_SERVICES_OG_TITLE` - Services page Open Graph title
- `STUB_SERVICES_OG_DESCRIPTION` - Services page Open Graph description
- `STUB_SERVICES_PAGE_TITLE` - Services page title

### Page Header
- `STUB_SERVICES_HEADER_TITLE` - Services page main heading
- `STUB_SERVICES_HEADER_SUBTITLE` - Services page subheading

### Service 1 Details
- `STUB_SERVICE_1_LONG_DESCRIPTION` - Detailed service 1 description
- `STUB_SERVICE_1_FEATURE_1` through `STUB_SERVICE_1_FEATURE_5` - Service 1 features
- `STUB_SERVICE_1_PRICE` - Service 1 pricing

### Service 2 Details
- `STUB_SERVICE_2_LONG_DESCRIPTION` - Detailed service 2 description
- `STUB_SERVICE_2_FEATURE_1` through `STUB_SERVICE_2_FEATURE_5` - Service 2 features
- `STUB_SERVICE_2_PRICE` - Service 2 pricing

### Service 3 Details
- `STUB_SERVICE_3_LONG_DESCRIPTION` - Detailed service 3 description
- `STUB_SERVICE_3_FEATURE_1` through `STUB_SERVICE_3_FEATURE_5` - Service 3 features
- `STUB_SERVICE_3_PRICE` - Service 3 pricing

### Service 4 Details
- `STUB_SERVICE_4_LONG_DESCRIPTION` - Detailed service 4 description
- `STUB_SERVICE_4_FEATURE_1` through `STUB_SERVICE_4_FEATURE_5` - Service 4 features
- `STUB_SERVICE_4_PRICE` - Service 4 pricing

### Services CTA
- `STUB_SERVICES_CTA_TITLE` - Services page CTA title
- `STUB_SERVICES_CTA_SUBTITLE` - Services page CTA subtitle
- `STUB_SERVICES_CTA_BUTTON` - Services page CTA button text

---

## Booking Page (pages/booking.html)

### SEO & Meta Tags
- `STUB_BOOKING_META_DESCRIPTION` - Booking page meta description
- `STUB_BOOKING_META_KEYWORDS` - Booking page meta keywords
- `STUB_BOOKING_OG_TITLE` - Booking page Open Graph title
- `STUB_BOOKING_OG_DESCRIPTION` - Booking page Open Graph description
- `STUB_BOOKING_PAGE_TITLE` - Booking page title

### Page Header
- `STUB_BOOKING_HEADER_TITLE` - Booking page main heading
- `STUB_BOOKING_HEADER_SUBTITLE` - Booking page subheading

### Step Indicators
- `STUB_STEP_1_LABEL` - Step 1 label (e.g., "Personal Info")
- `STUB_STEP_2_LABEL` - Step 2 label (e.g., "Service Details")
- `STUB_STEP_3_LABEL` - Step 3 label (e.g., "Address")

### Form Sections
- `STUB_PERSONAL_INFO_TITLE` - Personal information section title
- `STUB_SERVICE_DETAILS_TITLE` - Service details section title
- `STUB_ADDRESS_INFO_TITLE` - Address information section title
- `STUB_ADDITIONAL_INFO_TITLE` - Additional information section title

### Form Labels & Errors
- `STUB_FIRST_NAME_LABEL` - First name field label
- `STUB_FIRST_NAME_ERROR` - First name validation error message
- `STUB_LAST_NAME_LABEL` - Last name field label
- `STUB_LAST_NAME_ERROR` - Last name validation error message
- `STUB_EMAIL_LABEL` - Email field label
- `STUB_EMAIL_ERROR` - Email validation error message
- `STUB_PHONE_LABEL` - Phone field label
- `STUB_PHONE_ERROR` - Phone validation error message
- `STUB_SERVICE_TYPE_LABEL` - Service type field label
- `STUB_SERVICE_TYPE_ERROR` - Service type validation error message
- `STUB_SERVICE_DATE_LABEL` - Service date field label
- `STUB_SERVICE_DATE_ERROR` - Service date validation error message
- `STUB_SERVICE_TIME_LABEL` - Service time field label
- `STUB_SERVICE_TIME_ERROR` - Service time validation error message
- `STUB_ESTIMATED_ITEMS_LABEL` - Estimated items field label
- `STUB_PICKUP_ADDRESS_LABEL` - Pickup address field label
- `STUB_PICKUP_ADDRESS_ERROR` - Pickup address validation error
- `STUB_CITY_LABEL` - City field label
- `STUB_CITY_ERROR` - City validation error message
- `STUB_STATE_LABEL` - State field label
- `STUB_STATE_ERROR` - State validation error message
- `STUB_ZIP_LABEL` - ZIP code field label
- `STUB_ZIP_ERROR` - ZIP validation error message
- `STUB_DELIVERY_ADDRESS_LABEL` - Delivery address field label
- `STUB_DELIVERY_ADDRESS_ERROR` - Delivery address validation error
- `STUB_SAME_AS_PICKUP_LABEL` - "Same as pickup" checkbox label
- `STUB_SPECIAL_INSTRUCTIONS_LABEL` - Special instructions field label
- `STUB_SPECIAL_INSTRUCTIONS_PLACEHOLDER` - Special instructions placeholder
- `STUB_TERMS_CHECKBOX_LABEL` - Terms acceptance checkbox label
- `STUB_TERMS_ERROR` - Terms acceptance validation error

### Form Options
- `STUB_SELECT_SERVICE_PLACEHOLDER` - Service dropdown placeholder
- `STUB_SELECT_TIME_PLACEHOLDER` - Time dropdown placeholder
- `STUB_TIME_MORNING` - Morning time option label
- `STUB_TIME_AFTERNOON` - Afternoon time option label
- `STUB_TIME_EVENING` - Evening time option label

### Form Buttons
- `STUB_SUBMIT_BUTTON_TEXT` - Form submit button text

### Sidebar
- `STUB_WHY_BOOK_TITLE` - "Why Book" section title
- `STUB_BENEFIT_1_SHORT_DESC` - Benefit 1 short description
- `STUB_BENEFIT_2_SHORT_DESC` - Benefit 2 short description
- `STUB_BENEFIT_3_SHORT_DESC` - Benefit 3 short description
- `STUB_NEED_HELP_TITLE` - "Need Help" section title
- `STUB_NEED_HELP_TEXT` - Need help section text

### Success Modal
- `STUB_SUCCESS_MODAL_TITLE` - Success modal title
- `STUB_SUCCESS_MODAL_MESSAGE` - Success modal main message
- `STUB_SUCCESS_MODAL_SUBTEXT` - Success modal subtext

---

## Contact Page (pages/contact.html)

### SEO & Meta Tags
- `STUB_CONTACT_META_DESCRIPTION` - Contact page meta description
- `STUB_CONTACT_META_KEYWORDS` - Contact page meta keywords
- `STUB_CONTACT_OG_TITLE` - Contact page Open Graph title
- `STUB_CONTACT_OG_DESCRIPTION` - Contact page Open Graph description
- `STUB_CONTACT_PAGE_TITLE` - Contact page title

### Page Header
- `STUB_CONTACT_HEADER_TITLE` - Contact page main heading
- `STUB_CONTACT_HEADER_SUBTITLE` - Contact page subheading

### Contact Info Cards
- `STUB_VISIT_US_TITLE` - Visit us card title
- `STUB_CALL_US_TITLE` - Call us card title
- `STUB_EMAIL_US_TITLE` - Email us card title

### Contact Form
- `STUB_CONTACT_FORM_TITLE` - Contact form heading
- `STUB_CONTACT_NAME_LABEL` - Name field label
- `STUB_CONTACT_NAME_ERROR` - Name validation error
- `STUB_CONTACT_EMAIL_LABEL` - Email field label
- `STUB_CONTACT_EMAIL_ERROR` - Email validation error
- `STUB_CONTACT_PHONE_LABEL` - Phone field label (optional)
- `STUB_CONTACT_SUBJECT_LABEL` - Subject field label
- `STUB_CONTACT_SUBJECT_ERROR` - Subject validation error
- `STUB_CONTACT_MESSAGE_LABEL` - Message field label
- `STUB_CONTACT_MESSAGE_ERROR` - Message validation error
- `STUB_CONTACT_MESSAGE_PLACEHOLDER` - Message placeholder text
- `STUB_CONTACT_NEWSLETTER_LABEL` - Newsletter opt-in label
- `STUB_SEND_MESSAGE_BUTTON` - Send message button text

### Subject Options
- `STUB_SUBJECT_OPTION_1` through `STUB_SUBJECT_OPTION_5` - Contact form subject options

### Business Hours
- `STUB_BUSINESS_HOURS_TITLE` - Business hours section title
- `STUB_HOURS_MONDAY` through `STUB_HOURS_SUNDAY` - Hours for each day

### Social Section
- `STUB_CONNECT_TITLE` - Social connect section title
- `STUB_CONNECT_TEXT` - Social connect section text

### Map Section
- `STUB_LOCATION_TITLE` - Map section title
- `STUB_MAP_EMBED_URL` - Google Maps embed URL (or use placeholder image)

### Success Modal
- `STUB_CONTACT_SUCCESS_TITLE` - Contact success modal title
- `STUB_CONTACT_SUCCESS_MESSAGE` - Contact success modal message
- `STUB_CONTACT_SUCCESS_SUBTEXT` - Contact success modal subtext

---

## Image Placeholders

All images should be replaced with actual images. Use placeholder services like:
- **placeholder.com**: `https://via.placeholder.com/WIDTHxHEIGHT/COLOR/TEXTCOLOR?text=YOUR+TEXT`
- **unsplash.com**: High-quality free stock photos
- **picsum.photos**: `https://picsum.photos/WIDTH/HEIGHT`

### Required Images:
- Logo files in `/d2d/assets/images/logos/`:
  - `logo.png` - Main logo (light background)
  - `logo-dark.png` - Dark mode logo
- Favicon files in `/d2d/assets/images/`:
  - `favicon-32x32.png`
  - `favicon-16x16.png`
  - `apple-touch-icon.png`
- Service images in `/d2d/assets/images/services/`:
  - `service-1.jpg` through `service-4.jpg`
- Customer/testimonial images in `/d2d/assets/images/team/`:
  - `customer-1.jpg` through `customer-3.jpg`
- Hero image: `/d2d/assets/images/hero-image.jpg`
- Social share image: `/d2d/assets/images/social-share.jpg`

---

## Replacement Workflow

### Step 1: Create Content Spreadsheet
Create a spreadsheet with columns:
- Stub Name
- Replacement Value
- Page(s) Used
- Status (Pending/Complete)

### Step 2: Bulk Find and Replace
For each website:
```bash
# Find all stubs
grep -roh "STUB_[A-Z_0-9]*" d2d/ | sort -u > stubs_to_replace.txt

# Replace using sed (example)
sed -i 's/STUB_COMPANY_NAME/Acme Moving Co/g' d2d/**/*.html
```

### Step 3: Verify All Replaced
```bash
# Check for remaining stubs
grep -r "STUB_" d2d/
# Should return no results when complete
```

### Step 4: Quality Check
- Test all forms
- Check all links
- Verify all images load
- Test responsive design on multiple devices
- Validate HTML and accessibility

---

## Tips for Multiple Websites

### Create a Master Template
1. Keep this template repository as a master
2. Clone for each new website project
3. Use a configuration file or script to automate replacements

### Use Environment-Based Configs
Create a `config.json` for each website:
```json
{
  "company": {
    "name": "Acme Moving Co",
    "tagline": "We Move You Forward",
    "email": "info@acmemoving.com"
  },
  "services": [
    {
      "name": "Local Moving",
      "description": "...",
      "price": "$99/hr"
    }
  ]
}
```

Then use a build script to inject values.

### Document Customizations
For each deployed website, document:
- All stub replacements
- Any custom code changes
- Unique features or requirements
- Deployment details

---

## Validation Checklist

Before launching each website:
- [ ] All STUB_ placeholders replaced (run `grep -r "STUB_" d2d/`)
- [ ] All images uploaded and displaying correctly
- [ ] All links tested and working
- [ ] Contact form tested
- [ ] Booking form tested
- [ ] Responsive design tested (mobile, tablet, desktop)
- [ ] Cross-browser testing completed
- [ ] SEO meta tags customized for each page
- [ ] Social media links updated
- [ ] Google Analytics or tracking code added (if needed)
- [ ] Privacy policy and terms of service added/updated
- [ ] Favicon and app icons added
- [ ] PWA manifest configured
- [ ] Site tested in dark and light modes
- [ ] Accessibility audit passed
- [ ] Performance audit passed (Lighthouse)

---

## Quick Reference: Most Common Stubs

These are the stubs you'll replace most frequently:

1. `STUB_COMPANY_NAME` - Used everywhere
2. `STUB_PHONE_NUMBER` - Contact info
3. `STUB_EMAIL` - Contact info
4. `STUB_ADDRESS` - Contact info
5. `STUB_SERVICE_1_NAME` through `STUB_SERVICE_4_NAME` - All service names
6. `STUB_HERO_HEADLINE` - Homepage main message
7. `STUB_FACEBOOK_URL`, `STUB_TWITTER_URL`, etc. - Social media
8. All image URLs - Replace with actual image paths

---

**Last Updated:** 2025-01-12
**Template Version:** 1.0
