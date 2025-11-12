#!/bin/bash

#####################################################
# Website Deployment Automation Script
#
# This script automates the process of creating
# and deploying a new website from the template
#
# Usage: ./deploy-new-site.sh config.json
#####################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo ""
}

# Check if config file is provided
if [ -z "$1" ]; then
    print_error "No configuration file provided"
    echo "Usage: ./deploy-new-site.sh config.json"
    echo ""
    echo "Example config.json:"
    echo "{"
    echo "  \"project_name\": \"acme-moving\","
    echo "  \"company_name\": \"Acme Moving Co\","
    echo "  \"deploy_method\": \"netlify\""
    echo "}"
    exit 1
fi

CONFIG_FILE="$1"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    print_error "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    print_error "jq is not installed. Please install it first:"
    echo "  Ubuntu/Debian: sudo apt-get install jq"
    echo "  macOS: brew install jq"
    exit 1
fi

print_header "Website Deployment Automation"

# Read configuration
PROJECT_NAME=$(jq -r '.project_name' "$CONFIG_FILE")
COMPANY_NAME=$(jq -r '.company_name' "$CONFIG_FILE")
DEPLOY_METHOD=$(jq -r '.deploy_method // "manual"' "$CONFIG_FILE")

print_info "Project Name: $PROJECT_NAME"
print_info "Company Name: $COMPANY_NAME"
print_info "Deployment Method: $DEPLOY_METHOD"

# Create project directory
PROJECT_DIR="../$PROJECT_NAME"

print_header "Step 1: Creating Project Directory"

if [ -d "$PROJECT_DIR" ]; then
    print_warning "Project directory already exists: $PROJECT_DIR"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Deployment cancelled"
        exit 0
    fi
    rm -rf "$PROJECT_DIR"
fi

mkdir -p "$PROJECT_DIR"
print_success "Created project directory: $PROJECT_DIR"

# Copy template files
print_header "Step 2: Copying Template Files"

cp -r d2d/* "$PROJECT_DIR/"
print_success "Template files copied"

# Create logs directory
mkdir -p "$PROJECT_DIR/logs"
LOG_FILE="$PROJECT_DIR/logs/deployment-$(date +%Y%m%d-%H%M%S).log"

# Function to log and print
log_print() {
    echo "$1" | tee -a "$LOG_FILE"
}

log_print "Deployment started at $(date)"
log_print "Configuration file: $CONFIG_FILE"

# Replace STUB placeholders
print_header "Step 3: Replacing STUB Placeholders"

# Count total stubs before replacement
TOTAL_STUBS=$(grep -roh "STUB_[A-Z_0-9]*" "$PROJECT_DIR" | wc -l)
print_info "Found $TOTAL_STUBS STUB placeholders to replace"

# Function to replace stub in all HTML files
replace_stub() {
    local stub="$1"
    local value="$2"

    if [ -n "$value" ] && [ "$value" != "null" ]; then
        find "$PROJECT_DIR" -type f \( -name "*.html" -o -name "*.js" -o -name "*.json" \) -exec sed -i "s|$stub|$value|g" {} +
        log_print "Replaced: $stub -> $value"
    fi
}

# Read all values from config and replace
while IFS='=' read -r stub value; do
    if [ -n "$stub" ]; then
        config_value=$(jq -r ".stubs.$stub // empty" "$CONFIG_FILE")
        if [ -n "$config_value" ] && [ "$config_value" != "null" ]; then
            replace_stub "$stub" "$config_value"
        fi
    fi
done < <(grep -roh "STUB_[A-Z_0-9]*" "$PROJECT_DIR" | sort -u)

# Count remaining stubs after replacement
REMAINING_STUBS=$(grep -roh "STUB_[A-Z_0-9]*" "$PROJECT_DIR" | wc -l)
REPLACED_COUNT=$((TOTAL_STUBS - REMAINING_STUBS))

print_success "Replaced $REPLACED_COUNT STUB placeholders"

if [ $REMAINING_STUBS -gt 0 ]; then
    print_warning "$REMAINING_STUBS STUB placeholders still remain"
    print_info "Saving list of remaining stubs to: $PROJECT_DIR/remaining-stubs.txt"
    grep -roh "STUB_[A-Z_0-9]*" "$PROJECT_DIR" | sort -u > "$PROJECT_DIR/remaining-stubs.txt"
fi

# Copy images if provided
print_header "Step 4: Copying Images"

IMAGES_DIR=$(jq -r '.images_directory // empty' "$CONFIG_FILE")

if [ -n "$IMAGES_DIR" ] && [ "$IMAGES_DIR" != "null" ] && [ -d "$IMAGES_DIR" ]; then
    print_info "Copying images from: $IMAGES_DIR"

    # Copy to various subdirectories
    if [ -d "$IMAGES_DIR/logos" ]; then
        cp -r "$IMAGES_DIR/logos/"* "$PROJECT_DIR/assets/images/logos/" 2>/dev/null || true
        print_success "Copied logo images"
    fi

    if [ -d "$IMAGES_DIR/services" ]; then
        cp -r "$IMAGES_DIR/services/"* "$PROJECT_DIR/assets/images/services/" 2>/dev/null || true
        print_success "Copied service images"
    fi

    if [ -d "$IMAGES_DIR/team" ]; then
        cp -r "$IMAGES_DIR/team/"* "$PROJECT_DIR/assets/images/team/" 2>/dev/null || true
        print_success "Copied team images"
    fi

    # Copy icons
    if [ -d "$IMAGES_DIR/icons" ]; then
        mkdir -p "$PROJECT_DIR/assets/images/icons"
        cp -r "$IMAGES_DIR/icons/"* "$PROJECT_DIR/assets/images/icons/" 2>/dev/null || true
        print_success "Copied PWA icons"
    fi
else
    print_warning "No images directory provided or directory not found"
    print_info "You'll need to add images manually to: $PROJECT_DIR/assets/images/"
fi

# Create sitemap.xml
print_header "Step 5: Creating Sitemap"

WEBSITE_URL=$(jq -r '.stubs.STUB_WEBSITE_URL // "https://example.com"' "$CONFIG_FILE")

cat > "$PROJECT_DIR/sitemap.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>$WEBSITE_URL/</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>$WEBSITE_URL/pages/services.html</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>$WEBSITE_URL/pages/booking.html</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>$WEBSITE_URL/pages/contact.html</loc>
    <lastmod>$(date +%Y-%m-%d)</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
</urlset>
EOF

print_success "Created sitemap.xml"

# Create robots.txt
cat > "$PROJECT_DIR/robots.txt" << EOF
User-agent: *
Allow: /

Sitemap: $WEBSITE_URL/sitemap.xml
EOF

print_success "Created robots.txt"

# Initialize Git repository
print_header "Step 6: Initializing Git Repository"

cd "$PROJECT_DIR"

if [ -d ".git" ]; then
    print_warning "Git repository already exists"
else
    git init
    print_success "Initialized Git repository"
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << EOF
# Logs
logs/
*.log

# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo

# Environment files
.env
.env.local

# Build files (if you add a build process later)
dist/
build/
node_modules/

# Backup files
*.bak
*~
EOF
    print_success "Created .gitignore"
fi

# Create initial commit
git add .
git commit -m "Initial deployment from template

Project: $PROJECT_NAME
Company: $COMPANY_NAME
Deployment date: $(date +%Y-%m-%d)
" || true

print_success "Created initial Git commit"

cd - > /dev/null

# Run validation tests
print_header "Step 7: Running Validation Tests"

VALIDATION_ERRORS=0

# Check for remaining critical stubs
CRITICAL_STUBS="STUB_COMPANY_NAME STUB_PHONE_NUMBER STUB_EMAIL STUB_ADDRESS"
for stub in $CRITICAL_STUBS; do
    if grep -r "$stub" "$PROJECT_DIR" > /dev/null 2>&1; then
        print_warning "Critical stub not replaced: $stub"
        VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
    fi
done

# Check if required images exist
REQUIRED_IMAGES="logos/logo.png"
for img in $REQUIRED_IMAGES; do
    if [ ! -f "$PROJECT_DIR/assets/images/$img" ]; then
        print_warning "Required image missing: $img"
        VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
    fi
done

if [ $VALIDATION_ERRORS -eq 0 ]; then
    print_success "All validation tests passed"
else
    print_warning "Found $VALIDATION_ERRORS validation warnings"
fi

# Deployment
print_header "Step 8: Deployment"

case "$DEPLOY_METHOD" in
    "netlify")
        print_info "Deploying to Netlify..."

        if command -v netlify &> /dev/null; then
            cd "$PROJECT_DIR"
            netlify deploy --prod --dir . || print_warning "Netlify deployment failed. Deploy manually."
            cd - > /dev/null
            print_success "Deployed to Netlify"
        else
            print_warning "Netlify CLI not installed"
            print_info "Install with: npm install -g netlify-cli"
            print_info "Then run: cd $PROJECT_DIR && netlify deploy"
        fi
        ;;

    "vercel")
        print_info "Deploying to Vercel..."

        if command -v vercel &> /dev/null; then
            cd "$PROJECT_DIR"
            vercel --prod || print_warning "Vercel deployment failed. Deploy manually."
            cd - > /dev/null
            print_success "Deployed to Vercel"
        else
            print_warning "Vercel CLI not installed"
            print_info "Install with: npm install -g vercel"
            print_info "Then run: cd $PROJECT_DIR && vercel"
        fi
        ;;

    "github-pages")
        print_info "Setting up for GitHub Pages deployment..."

        GITHUB_REPO=$(jq -r '.github_repo // empty' "$CONFIG_FILE")

        if [ -n "$GITHUB_REPO" ] && [ "$GITHUB_REPO" != "null" ]; then
            cd "$PROJECT_DIR"
            git remote add origin "$GITHUB_REPO" 2>/dev/null || true
            git branch -M main
            print_info "To complete deployment, run:"
            echo "  cd $PROJECT_DIR"
            echo "  git push -u origin main"
            echo ""
            echo "Then enable GitHub Pages in repository settings"
            cd - > /dev/null
        else
            print_warning "GitHub repository URL not provided in config"
            print_info "Add 'github_repo' to your config file"
        fi
        ;;

    "manual")
        print_info "Manual deployment selected"
        print_info "Project is ready at: $PROJECT_DIR"
        ;;

    *)
        print_warning "Unknown deployment method: $DEPLOY_METHOD"
        print_info "Project is ready for manual deployment at: $PROJECT_DIR"
        ;;
esac

# Generate deployment report
print_header "Step 9: Generating Deployment Report"

REPORT_FILE="$PROJECT_DIR/DEPLOYMENT_REPORT.md"

cat > "$REPORT_FILE" << EOF
# Deployment Report

**Project:** $PROJECT_NAME
**Company:** $COMPANY_NAME
**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Deployment Method:** $DEPLOY_METHOD

---

## Summary

- **STUB Placeholders Replaced:** $REPLACED_COUNT / $TOTAL_STUBS
- **Remaining Stubs:** $REMAINING_STUBS
- **Validation Warnings:** $VALIDATION_ERRORS
- **Git Repository:** Initialized
- **Sitemap:** Created
- **Robots.txt:** Created

---

## Project Structure

\`\`\`
$PROJECT_NAME/
├── index.html
├── pages/
│   ├── services.html
│   ├── booking.html
│   └── contact.html
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
├── manifest.json
├── sw.js
├── offline.html
├── sitemap.xml
└── robots.txt
\`\`\`

---

## Next Steps

### 1. Review Remaining Stubs

EOF

if [ $REMAINING_STUBS -gt 0 ]; then
    echo "The following STUB placeholders need to be replaced:" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
    cat "$PROJECT_DIR/remaining-stubs.txt" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
else
    echo "✓ All STUB placeholders have been replaced!" >> "$REPORT_FILE"
fi

cat >> "$REPORT_FILE" << EOF

### 2. Add Missing Images

Check the following directories and add images as needed:
- \`assets/images/logos/\` - Company logo (logo.png, logo-dark.png)
- \`assets/images/services/\` - Service images (service-1.jpg through service-4.jpg)
- \`assets/images/team/\` - Team/customer photos
- \`assets/images/icons/\` - PWA icons (various sizes)

### 3. Test Locally

\`\`\`bash
cd $PROJECT_DIR
python3 -m http.server 8000
# Visit http://localhost:8000
\`\`\`

Test the following:
- [ ] All pages load correctly
- [ ] Navigation works
- [ ] Forms validate and submit
- [ ] Images display properly
- [ ] Dark mode toggle works
- [ ] Responsive design on mobile/tablet/desktop
- [ ] PWA installation

### 4. Deploy

EOF

case "$DEPLOY_METHOD" in
    "netlify")
        echo "Deployment to Netlify has been initiated." >> "$REPORT_FILE"
        echo "Check the Netlify dashboard for the live URL." >> "$REPORT_FILE"
        ;;
    "vercel")
        echo "Deployment to Vercel has been initiated." >> "$REPORT_FILE"
        echo "Check the Vercel dashboard for the live URL." >> "$REPORT_FILE"
        ;;
    "github-pages")
        echo "To complete GitHub Pages deployment:" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        echo "\`\`\`bash" >> "$REPORT_FILE"
        echo "cd $PROJECT_DIR" >> "$REPORT_FILE"
        echo "git push -u origin main" >> "$REPORT_FILE"
        echo "\`\`\`" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
        echo "Then enable GitHub Pages in your repository settings." >> "$REPORT_FILE"
        ;;
    *)
        echo "Ready for manual deployment." >> "$REPORT_FILE"
        echo "Upload the contents of \`$PROJECT_DIR\` to your web server." >> "$REPORT_FILE"
        ;;
esac

cat >> "$REPORT_FILE" << EOF

### 5. Post-Deployment

- [ ] Submit sitemap to Google Search Console
- [ ] Submit sitemap to Bing Webmaster Tools
- [ ] Set up Google Analytics (optional)
- [ ] Test on live URL
- [ ] Verify SSL certificate
- [ ] Test PWA installation on mobile

---

## Configuration Used

\`\`\`json
$(cat "$CONFIG_FILE")
\`\`\`

---

## Logs

Full deployment log: \`logs/deployment-$(date +%Y%m%d-%H%M%S).log\`

EOF

print_success "Generated deployment report: $REPORT_FILE"

# Final summary
print_header "Deployment Complete!"

echo ""
print_success "Project created at: $PROJECT_DIR"
print_info "Deployment report: $REPORT_FILE"

if [ $REMAINING_STUBS -gt 0 ]; then
    print_warning "There are $REMAINING_STUBS STUB placeholders remaining"
    print_info "See: $PROJECT_DIR/remaining-stubs.txt"
fi

if [ $VALIDATION_ERRORS -gt 0 ]; then
    print_warning "There are $VALIDATION_ERRORS validation warnings"
    print_info "Review the deployment report for details"
fi

echo ""
print_info "Next steps:"
echo "  1. Review remaining stubs and images"
echo "  2. Test locally: cd $PROJECT_DIR && python3 -m http.server 8000"
echo "  3. Complete deployment if needed"
echo "  4. Review: $REPORT_FILE"
echo ""

log_print "Deployment completed at $(date)"

print_success "Done! 🎉"
