#!/bin/bash

#####################################################
# Website Validation Script
#
# Validates a deployed website for completeness
# and common issues
#
# Usage: ./validate-site.sh [directory]
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

# Set directory
SITE_DIR="${1:-.}"

if [ ! -d "$SITE_DIR" ]; then
    print_error "Directory not found: $SITE_DIR"
    exit 1
fi

print_header "Website Validation"
print_info "Validating: $SITE_DIR"
echo ""

ERRORS=0
WARNINGS=0
PASSED=0

# Check 1: STUB placeholders
print_header "Check 1: STUB Placeholders"

STUB_COUNT=$(grep -roh "STUB_[A-Z_0-9]*" "$SITE_DIR" --exclude-dir=node_modules --exclude-dir=.git 2>/dev/null | wc -l)

if [ "$STUB_COUNT" -eq 0 ]; then
    print_success "No STUB placeholders found"
    PASSED=$((PASSED + 1))
else
    print_error "Found $STUB_COUNT STUB placeholders that need to be replaced"
    ERRORS=$((ERRORS + 1))

    # Show first 10 unique stubs
    echo ""
    print_info "First 10 remaining stubs:"
    grep -roh "STUB_[A-Z_0-9]*" "$SITE_DIR" --exclude-dir=node_modules --exclude-dir=.git 2>/dev/null | sort -u | head -10
fi

# Check 2: Required files
print_header "Check 2: Required Files"

REQUIRED_FILES=(
    "index.html"
    "manifest.json"
    "sw.js"
    "offline.html"
    "assets/css/custom.css"
    "assets/js/custom.js"
    "pages/services.html"
    "pages/booking.html"
    "pages/contact.html"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$SITE_DIR/$file" ]; then
        print_success "$file exists"
        PASSED=$((PASSED + 1))
    else
        print_error "$file is missing"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check 3: Required images
print_header "Check 3: Required Images"

REQUIRED_IMAGES=(
    "assets/images/logos/logo.png"
    "assets/images/favicon-32x32.png"
)

for img in "${REQUIRED_IMAGES[@]}"; do
    if [ -f "$SITE_DIR/$img" ]; then
        print_success "$img exists"
        PASSED=$((PASSED + 1))
    else
        print_warning "$img is missing"
        WARNINGS=$((WARNINGS + 1))
    fi
done

# Check 4: Critical content
print_header "Check 4: Critical Content"

CRITICAL_STUBS=(
    "STUB_COMPANY_NAME"
    "STUB_PHONE_NUMBER"
    "STUB_EMAIL"
    "STUB_ADDRESS"
)

for stub in "${CRITICAL_STUBS[@]}"; do
    if grep -r "$stub" "$SITE_DIR" > /dev/null 2>&1; then
        print_error "Critical stub not replaced: $stub"
        ERRORS=$((ERRORS + 1))
    else
        print_success "$stub has been replaced"
        PASSED=$((PASSED + 1))
    fi
done

# Check 5: HTML validation
print_header "Check 5: HTML Structure"

if command -v tidy &> /dev/null; then
    HTML_FILES=$(find "$SITE_DIR" -name "*.html" | head -5)
    for file in $HTML_FILES; do
        if tidy -q -e "$file" 2>&1 | grep -q "Error"; then
            print_warning "$(basename $file) has HTML errors"
            WARNINGS=$((WARNINGS + 1))
        else
            print_success "$(basename $file) is valid"
            PASSED=$((PASSED + 1))
        fi
    done
else
    print_info "tidy not installed, skipping HTML validation"
    print_info "Install with: sudo apt-get install tidy (or brew install tidy-html5)"
fi

# Check 6: Links validation
print_header "Check 6: Internal Links"

BROKEN_LINKS=0

# Check navigation links
if [ -f "$SITE_DIR/index.html" ]; then
    LINKS=$(grep -oh 'href="[^"]*"' "$SITE_DIR/index.html" | sed 's/href="//;s/"$//' | grep -v "^http" | grep -v "^#" | grep -v "^mailto" | grep -v "^tel")

    for link in $LINKS; do
        # Remove leading /
        link_path="${link#/}"

        if [ ! -f "$SITE_DIR/$link_path" ] && [ ! -d "$SITE_DIR/$link_path" ]; then
            print_warning "Broken link: $link"
            BROKEN_LINKS=$((BROKEN_LINKS + 1))
            WARNINGS=$((WARNINGS + 1))
        fi
    done

    if [ $BROKEN_LINKS -eq 0 ]; then
        print_success "No broken internal links found"
        PASSED=$((PASSED + 1))
    else
        print_warning "Found $BROKEN_LINKS broken internal links"
    fi
fi

# Check 7: JavaScript errors
print_header "Check 7: JavaScript Syntax"

JS_FILES=$(find "$SITE_DIR" -name "*.js" -not -path "*/node_modules/*")

if command -v node &> /dev/null; then
    for js_file in $JS_FILES; do
        if node -c "$js_file" 2>/dev/null; then
            print_success "$(basename $js_file) has valid syntax"
            PASSED=$((PASSED + 1))
        else
            print_error "$(basename $js_file) has syntax errors"
            ERRORS=$((ERRORS + 1))
        fi
    done
else
    print_info "Node.js not installed, skipping JavaScript validation"
fi

# Check 8: Manifest validation
print_header "Check 8: PWA Manifest"

if [ -f "$SITE_DIR/manifest.json" ]; then
    if command -v jq &> /dev/null; then
        if jq empty "$SITE_DIR/manifest.json" 2>/dev/null; then
            print_success "manifest.json is valid JSON"
            PASSED=$((PASSED + 1))

            # Check for required fields
            NAME=$(jq -r '.name' "$SITE_DIR/manifest.json")
            if [ "$NAME" != "null" ] && [ "$NAME" != "STUB_COMPANY_NAME" ]; then
                print_success "Manifest name is set: $NAME"
                PASSED=$((PASSED + 1))
            else
                print_error "Manifest name not configured"
                ERRORS=$((ERRORS + 1))
            fi
        else
            print_error "manifest.json is invalid JSON"
            ERRORS=$((ERRORS + 1))
        fi
    else
        print_info "jq not installed, skipping manifest validation"
    fi
else
    print_error "manifest.json not found"
    ERRORS=$((ERRORS + 1))
fi

# Check 9: Robots.txt and sitemap
print_header "Check 9: SEO Files"

if [ -f "$SITE_DIR/robots.txt" ]; then
    print_success "robots.txt exists"
    PASSED=$((PASSED + 1))
else
    print_warning "robots.txt not found"
    WARNINGS=$((WARNINGS + 1))
fi

if [ -f "$SITE_DIR/sitemap.xml" ]; then
    print_success "sitemap.xml exists"
    PASSED=$((PASSED + 1))
else
    print_warning "sitemap.xml not found"
    WARNINGS=$((WARNINGS + 1))
fi

# Check 10: File sizes
print_header "Check 10: File Sizes"

# Check for large images
LARGE_IMAGES=$(find "$SITE_DIR/assets/images" -type f -size +500k 2>/dev/null)

if [ -n "$LARGE_IMAGES" ]; then
    print_warning "Found images larger than 500KB:"
    echo "$LARGE_IMAGES" | while read img; do
        SIZE=$(du -h "$img" | cut -f1)
        echo "  - $(basename $img): $SIZE"
    done
    WARNINGS=$((WARNINGS + 1))
else
    print_success "All images are optimally sized"
    PASSED=$((PASSED + 1))
fi

# Check total size
TOTAL_SIZE=$(du -sh "$SITE_DIR" 2>/dev/null | cut -f1)
print_info "Total site size: $TOTAL_SIZE"

# Summary
print_header "Validation Summary"

TOTAL_CHECKS=$((PASSED + WARNINGS + ERRORS))

echo ""
echo -e "${GREEN}✓ Passed:   ${NC}$PASSED"
echo -e "${YELLOW}⚠ Warnings: ${NC}$WARNINGS"
echo -e "${RED}✗ Errors:   ${NC}$ERRORS"
echo -e "──────────────────"
echo -e "Total Checks: $TOTAL_CHECKS"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    print_success "Website is ready for deployment! 🎉"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    print_warning "Website has some warnings but is deployable"
    exit 0
else
    print_error "Website has errors that should be fixed before deployment"
    exit 1
fi
