#!/bin/bash

#####################################################
# Configuration File Generator
#
# Interactive script to generate a configuration
# file for a new website deployment
#
# Usage: ./generate-config.sh [output-file]
#####################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo ""
}

# Output file
OUTPUT_FILE="${1:-config.json}"

print_header "Configuration File Generator"
echo ""
print_info "This script will help you create a configuration file for deployment"
echo ""

# Basic Information
print_header "Basic Information"

read -p "Project name (lowercase, no spaces): " PROJECT_NAME
read -p "Company name: " COMPANY_NAME
read -p "Company tagline: " TAGLINE
read -p "Website URL (e.g., https://example.com): " WEBSITE_URL

# Contact Information
print_header "Contact Information"

read -p "Phone number: " PHONE
read -p "Email address: " EMAIL
read -p "Business address: " ADDRESS
read -p "Business hours: " HOURS

# Social Media
print_header "Social Media"

read -p "Facebook URL (or press Enter to skip): " FACEBOOK
read -p "Twitter URL (or press Enter to skip): " TWITTER
read -p "Instagram URL (or press Enter to skip): " INSTAGRAM
read -p "LinkedIn URL (or press Enter to skip): " LINKEDIN

# Services
print_header "Services Information"

echo "Enter information for 4 services:"
echo ""

declare -a SERVICE_NAMES
declare -a SERVICE_DESCRIPTIONS
declare -a SERVICE_PRICES

for i in {1..4}; do
    echo "Service $i:"
    read -p "  Name: " name
    read -p "  Short description: " desc
    read -p "  Price: " price
    SERVICE_NAMES[$i]=$name
    SERVICE_DESCRIPTIONS[$i]=$desc
    SERVICE_PRICES[$i]=$price
    echo ""
done

# Hero Section
print_header "Homepage Hero Section"

read -p "Main headline: " HERO_HEADLINE
read -p "Subheadline: " HERO_SUB

# Company Description
print_header "Company Description"

read -p "Short description (2-3 sentences): " COMPANY_DESC
read -p "SEO meta description (150-160 chars): " META_DESC

# Benefits
print_header "Key Benefits"

echo "Enter 3 key benefits:"
echo ""

declare -a BENEFIT_TITLES
declare -a BENEFIT_DESCS

for i in {1..3}; do
    echo "Benefit $i:"
    read -p "  Title: " title
    read -p "  Description: " desc
    BENEFIT_TITLES[$i]=$title
    BENEFIT_DESCS[$i]=$desc
    echo ""
done

# Statistics
print_header "Statistics (Optional)"

echo "Enter 4 statistics to display:"
echo ""

declare -a STAT_NUMBERS
declare -a STAT_LABELS

for i in {1..4}; do
    echo "Statistic $i:"
    read -p "  Number (e.g., 15+ or 5,000+): " number
    read -p "  Label: " label
    STAT_NUMBERS[$i]=$number
    STAT_LABELS[$i]=$label
    echo ""
done

# Deployment
print_header "Deployment Configuration"

echo "Select deployment method:"
echo "  1) Netlify"
echo "  2) Vercel"
echo "  3) GitHub Pages"
echo "  4) Manual"
read -p "Choice (1-4): " DEPLOY_CHOICE

case $DEPLOY_CHOICE in
    1) DEPLOY_METHOD="netlify" ;;
    2) DEPLOY_METHOD="vercel" ;;
    3) DEPLOY_METHOD="github-pages" ;;
    *) DEPLOY_METHOD="manual" ;;
esac

GITHUB_REPO=""
if [ "$DEPLOY_METHOD" == "github-pages" ]; then
    read -p "GitHub repository URL: " GITHUB_REPO
fi

# Images
print_header "Images Directory (Optional)"

read -p "Path to images directory (or press Enter to skip): " IMAGES_DIR

# Generate JSON
print_header "Generating Configuration File"

cat > "$OUTPUT_FILE" << EOF
{
  "project_name": "$PROJECT_NAME",
  "company_name": "$COMPANY_NAME",
  "deploy_method": "$DEPLOY_METHOD",
EOF

if [ -n "$GITHUB_REPO" ]; then
    echo "  \"github_repo\": \"$GITHUB_REPO\"," >> "$OUTPUT_FILE"
fi

if [ -n "$IMAGES_DIR" ]; then
    echo "  \"images_directory\": \"$IMAGES_DIR\"," >> "$OUTPUT_FILE"
fi

cat >> "$OUTPUT_FILE" << EOF
  "stubs": {
    "STUB_COMPANY_NAME": "$COMPANY_NAME",
    "STUB_TAGLINE": "$TAGLINE",
    "STUB_WEBSITE_URL": "$WEBSITE_URL",
    "STUB_META_DESCRIPTION": "$META_DESC",
    "STUB_COMPANY_SHORT_DESCRIPTION": "$COMPANY_DESC",
    "STUB_PHONE_NUMBER": "$PHONE",
    "STUB_EMAIL": "$EMAIL",
    "STUB_ADDRESS": "$ADDRESS",
    "STUB_BUSINESS_HOURS": "$HOURS",
EOF

if [ -n "$FACEBOOK" ]; then
    echo "    \"STUB_FACEBOOK_URL\": \"$FACEBOOK\"," >> "$OUTPUT_FILE"
fi

if [ -n "$TWITTER" ]; then
    echo "    \"STUB_TWITTER_URL\": \"$TWITTER\"," >> "$OUTPUT_FILE"
fi

if [ -n "$INSTAGRAM" ]; then
    echo "    \"STUB_INSTAGRAM_URL\": \"$INSTAGRAM\"," >> "$OUTPUT_FILE"
fi

if [ -n "$LINKEDIN" ]; then
    echo "    \"STUB_LINKEDIN_URL\": \"$LINKEDIN\"," >> "$OUTPUT_FILE"
fi

cat >> "$OUTPUT_FILE" << EOF
    "STUB_HERO_HEADLINE": "$HERO_HEADLINE",
    "STUB_HERO_SUBHEADLINE": "$HERO_SUB",
    "STUB_SERVICE_1_NAME": "${SERVICE_NAMES[1]}",
    "STUB_SERVICE_1_SHORT_DESCRIPTION": "${SERVICE_DESCRIPTIONS[1]}",
    "STUB_SERVICE_1_PRICE": "${SERVICE_PRICES[1]}",
    "STUB_SERVICE_2_NAME": "${SERVICE_NAMES[2]}",
    "STUB_SERVICE_2_SHORT_DESCRIPTION": "${SERVICE_DESCRIPTIONS[2]}",
    "STUB_SERVICE_2_PRICE": "${SERVICE_PRICES[2]}",
    "STUB_SERVICE_3_NAME": "${SERVICE_NAMES[3]}",
    "STUB_SERVICE_3_SHORT_DESCRIPTION": "${SERVICE_DESCRIPTIONS[3]}",
    "STUB_SERVICE_3_PRICE": "${SERVICE_PRICES[3]}",
    "STUB_SERVICE_4_NAME": "${SERVICE_NAMES[4]}",
    "STUB_SERVICE_4_SHORT_DESCRIPTION": "${SERVICE_DESCRIPTIONS[4]}",
    "STUB_SERVICE_4_PRICE": "${SERVICE_PRICES[4]}",
    "STUB_BENEFIT_1_TITLE": "${BENEFIT_TITLES[1]}",
    "STUB_BENEFIT_1_DESCRIPTION": "${BENEFIT_DESCS[1]}",
    "STUB_BENEFIT_2_TITLE": "${BENEFIT_TITLES[2]}",
    "STUB_BENEFIT_2_DESCRIPTION": "${BENEFIT_DESCS[2]}",
    "STUB_BENEFIT_3_TITLE": "${BENEFIT_TITLES[3]}",
    "STUB_BENEFIT_3_DESCRIPTION": "${BENEFIT_DESCS[3]}",
    "STUB_STAT_1_NUMBER": "${STAT_NUMBERS[1]}",
    "STUB_STAT_1_LABEL": "${STAT_LABELS[1]}",
    "STUB_STAT_2_NUMBER": "${STAT_NUMBERS[2]}",
    "STUB_STAT_2_LABEL": "${STAT_LABELS[2]}",
    "STUB_STAT_3_NUMBER": "${STAT_NUMBERS[3]}",
    "STUB_STAT_3_LABEL": "${STAT_LABELS[3]}",
    "STUB_STAT_4_NUMBER": "${STAT_NUMBERS[4]}",
    "STUB_STAT_4_LABEL": "${STAT_LABELS[4]}",
    "STUB_COPYRIGHT_TEXT": "© 2025 $COMPANY_NAME. All rights reserved.",
    "STUB_NAV_HOME": "Home",
    "STUB_NAV_SERVICES": "Services",
    "STUB_NAV_BOOKING": "Book Now",
    "STUB_NAV_CONTACT": "Contact",
    "STUB_BOOK_NOW_TEXT": "Book Now",
    "STUB_FOOTER_COMPANY_DESCRIPTION": "$COMPANY_DESC",
    "STUB_FOOTER_QUICK_LINKS_TITLE": "Quick Links",
    "STUB_FOOTER_SERVICES_TITLE": "Our Services",
    "STUB_FOOTER_CONTACT_TITLE": "Contact Us"
  }
}
EOF

print_success "Configuration file generated: $OUTPUT_FILE"
echo ""
print_info "Next steps:"
echo "  1. Review and edit $OUTPUT_FILE if needed"
echo "  2. Add more STUB replacements as needed"
echo "  3. Run: ./deploy-new-site.sh $OUTPUT_FILE"
echo ""
print_info "Note: This config file contains basic stubs."
print_info "You may need to add more detailed content for:"
echo "  - Service features"
echo "  - Long descriptions"
echo "  - Testimonials"
echo "  - Form labels"
echo ""
print_info "See STUB_REFERENCE.md for a complete list of all stubs"
echo ""
print_success "Done! 🎉"
