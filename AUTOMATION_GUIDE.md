# Automation Tools Guide

This guide explains how to use the automation scripts to quickly deploy multiple websites from the template.

---

## 📋 Available Scripts

### 1. `generate-config.sh` - Configuration File Generator

**Purpose:** Interactive script to create a configuration file with all your content.

**Usage:**
```bash
./generate-config.sh [output-file]
```

**Example:**
```bash
./generate-config.sh acme-moving-config.json
```

**What it does:**
- Asks you questions about your business
- Collects company information, services, contact details
- Generates a JSON configuration file
- Includes all essential STUB replacements

**When to use:** First step when creating a new website. Creates the config file you'll use for deployment.

---

### 2. `deploy-new-site.sh` - Automated Deployment Script

**Purpose:** Main automation script that creates and deploys a complete website.

**Usage:**
```bash
./deploy-new-site.sh config.json
```

**Example:**
```bash
./deploy-new-site.sh acme-moving-config.json
```

**What it does:**
1. ✅ Creates project directory
2. ✅ Copies template files
3. ✅ Replaces all STUB placeholders from config
4. ✅ Copies images (if provided)
5. ✅ Creates sitemap.xml and robots.txt
6. ✅ Initializes Git repository
7. ✅ Runs validation tests
8. ✅ Deploys to hosting (Netlify, Vercel, GitHub Pages)
9. ✅ Generates deployment report

**When to use:** After creating your config file. This is your main deployment automation.

---

### 3. `validate-site.sh` - Website Validation Script

**Purpose:** Validates a website for completeness and common issues.

**Usage:**
```bash
./validate-site.sh [directory]
```

**Example:**
```bash
./validate-site.sh ../acme-moving/
```

**What it validates:**
- ✓ All STUB placeholders replaced
- ✓ Required files exist
- ✓ Required images exist
- ✓ Critical content filled in
- ✓ HTML structure validity
- ✓ Internal links work
- ✓ JavaScript syntax
- ✓ PWA manifest validity
- ✓ SEO files (robots.txt, sitemap.xml)
- ✓ Image file sizes

**When to use:** Before deployment or after manual changes to verify everything is correct.

---

## 🚀 Quick Start Workflow

### Complete Workflow for a New Website

**Step 1: Generate Configuration**
```bash
./generate-config.sh acme-config.json
```
Answer the interactive questions about your business.

**Step 2: Review and Edit Config** (Optional)
```bash
nano acme-config.json  # or use your preferred editor
```
Add more detailed content, testimonials, etc.

**Step 3: Deploy the Website**
```bash
./deploy-new-site.sh acme-config.json
```

**Step 4: Validate**
```bash
./validate-site.sh ../acme-moving/
```

**Step 5: Test Locally**
```bash
cd ../acme-moving
python3 -m http.server 8000
```
Visit http://localhost:8000

**Step 6: Push to Production**
If using Git deployment:
```bash
cd ../acme-moving
git push -u origin main
```

---

## 📝 Configuration File Format

### Basic Structure

```json
{
  "project_name": "acme-moving",
  "company_name": "Acme Moving Co",
  "deploy_method": "netlify",
  "github_repo": "https://github.com/user/repo.git",
  "images_directory": "/path/to/images",
  "stubs": {
    "STUB_COMPANY_NAME": "Acme Moving Co",
    "STUB_PHONE_NUMBER": "(555) 123-4567",
    ...
  }
}
```

### Required Fields

- `project_name` - Directory name (lowercase, no spaces)
- `company_name` - Official company name
- `deploy_method` - One of: `netlify`, `vercel`, `github-pages`, `manual`

### Optional Fields

- `github_repo` - GitHub repository URL (required for GitHub Pages)
- `images_directory` - Path to folder containing images
- `stubs` - Object containing all STUB replacements

### Deployment Methods

**netlify:**
- Requires Netlify CLI: `npm install -g netlify-cli`
- Automatically deploys to Netlify
- Creates production deployment

**vercel:**
- Requires Vercel CLI: `npm install -g vercel`
- Automatically deploys to Vercel
- Creates production deployment

**github-pages:**
- Requires `github_repo` field
- Initializes Git repository
- Sets up remote
- You must manually push to trigger deployment

**manual:**
- No automatic deployment
- Project ready for manual upload
- Use FTP, drag-and-drop, etc.

---

## 🖼️ Images Directory Structure

If you provide an `images_directory`, organize it like this:

```
/path/to/images/
├── logos/
│   ├── logo.png
│   └── logo-dark.png
├── services/
│   ├── service-1.jpg
│   ├── service-2.jpg
│   ├── service-3.jpg
│   └── service-4.jpg
├── team/
│   ├── customer-1.jpg
│   ├── customer-2.jpg
│   └── customer-3.jpg
└── icons/
    ├── icon-72x72.png
    ├── icon-96x96.png
    ├── icon-128x128.png
    ├── icon-144x144.png
    ├── icon-152x152.png
    ├── icon-192x192.png
    ├── icon-384x384.png
    └── icon-512x512.png
```

The deployment script will automatically copy images to the correct locations.

---

## 🔧 Advanced Usage

### Using Partial Configs

You don't have to include every STUB in your config. The script will only replace the STUBs you provide. Others will remain for manual editing.

**Example minimal config:**
```json
{
  "project_name": "test-site",
  "company_name": "Test Co",
  "deploy_method": "manual",
  "stubs": {
    "STUB_COMPANY_NAME": "Test Co",
    "STUB_PHONE_NUMBER": "555-1234",
    "STUB_EMAIL": "info@test.co"
  }
}
```

### Multiple Configs for Testing

Create different config files for different scenarios:
```bash
./generate-config.sh config-production.json
./generate-config.sh config-staging.json
./generate-config.sh config-development.json
```

### Redeploying with Updates

To update an existing deployment:
```bash
# Update your config file
nano acme-config.json

# Redeploy (will overwrite)
./deploy-new-site.sh acme-config.json
```

---

## 📊 Validation Output

The validation script provides detailed output:

```
═══════════════════════════════════════
  Check 1: STUB Placeholders
═══════════════════════════════════════

✓ No STUB placeholders found

═══════════════════════════════════════
  Check 2: Required Files
═══════════════════════════════════════

✓ index.html exists
✓ manifest.json exists
✓ sw.js exists
...

═══════════════════════════════════════
  Validation Summary
═══════════════════════════════════════

✓ Passed:   25
⚠ Warnings: 2
✗ Errors:   0
──────────────────
Total Checks: 27

⚠ Website has some warnings but is deployable
```

---

## 🐛 Troubleshooting

### "jq: command not found"

Install jq:
```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq
```

### "Permission denied"

Make scripts executable:
```bash
chmod +x *.sh
```

### "Directory already exists"

The script will ask if you want to overwrite. To force overwrite:
```bash
rm -rf ../project-name
./deploy-new-site.sh config.json
```

### Deployment fails

Check that CLI tools are installed:
```bash
# For Netlify
npm install -g netlify-cli

# For Vercel
npm install -g vercel
```

### Images not copying

Ensure images_directory path is absolute:
```json
"images_directory": "/home/user/projects/images"
```

---

## 📖 Example Workflow

### Complete Example: Deploying 3 Websites

```bash
# Website 1: Acme Moving
./generate-config.sh acme-config.json
# Answer questions...
./deploy-new-site.sh acme-config.json
./validate-site.sh ../acme-moving/

# Website 2: Bob's Plumbing
./generate-config.sh bobs-config.json
# Answer questions...
./deploy-new-site.sh bobs-config.json
./validate-site.sh ../bobs-plumbing/

# Website 3: City Cleaners
./generate-config.sh city-config.json
# Answer questions...
./deploy-new-site.sh city-config.json
./validate-site.sh ../city-cleaners/
```

Each deployment takes minutes instead of hours!

---

## 📁 Generated Files

After running `deploy-new-site.sh`, you'll find:

```
../project-name/
├── [All website files]
├── logs/
│   └── deployment-YYYYMMDD-HHMMSS.log
├── remaining-stubs.txt (if any stubs remain)
└── DEPLOYMENT_REPORT.md
```

**Check these files:**
- `DEPLOYMENT_REPORT.md` - Summary of deployment
- `remaining-stubs.txt` - List of stubs to manually replace
- `logs/deployment-*.log` - Detailed log of all operations

---

## 🎯 Best Practices

### 1. Always Start with Generate Config
Use the interactive generator even if you plan to edit manually. It ensures you don't miss any fields.

### 2. Keep Config Files Organized
```bash
mkdir configs
mv *.json configs/
```

### 3. Version Control Your Configs
```bash
git add configs/
git commit -m "Add website configurations"
```

### 4. Test Locally First
Always test with local server before deploying to production.

### 5. Run Validation Before Deployment
```bash
./validate-site.sh ../project/ && ./deploy-new-site.sh config.json
```

### 6. Save Images Organized
Keep a master images folder with subdirectories for each client:
```
/images/
├── acme-moving/
├── bobs-plumbing/
└── city-cleaners/
```

---

## 🔄 Continuous Deployment

### Setting Up Auto-Deploy

**With Netlify:**
```bash
cd ../project-name
netlify init
# Follow prompts to connect Git repository
# Every push will auto-deploy
```

**With Vercel:**
```bash
cd ../project-name
vercel --prod
vercel git connect
# Every push will auto-deploy
```

**With GitHub Pages:**
```bash
# Already set up by deploy script
# Just push to deploy:
git push origin main
```

---

## 💡 Tips & Tricks

### Quick Deploy for Testing
```bash
# Minimal config for quick testing
echo '{
  "project_name": "test",
  "company_name": "Test Co",
  "deploy_method": "manual",
  "stubs": {
    "STUB_COMPANY_NAME": "Test Co"
  }
}' > test-config.json

./deploy-new-site.sh test-config.json
```

### Batch Processing
```bash
# Deploy multiple sites
for config in configs/*.json; do
    ./deploy-new-site.sh "$config"
done
```

### Copy Config as Template
```bash
# Use an existing config as template
cp configs/acme-config.json configs/new-client-config.json
# Edit as needed
nano configs/new-client-config.json
```

---

## 📞 Support

For issues or questions:
1. Check `DEPLOYMENT_GUIDE.md`
2. Review `STUB_REFERENCE.md`
3. Read logs in `logs/` directory
4. Run validation script for diagnostics

---

**Last Updated:** 2025-01-12
**Version:** 1.0

---

## Summary

These automation scripts reduce website deployment from **hours to minutes**:

- 🚀 **generate-config.sh** - Create config in 5 minutes
- ⚙️ **deploy-new-site.sh** - Deploy complete site automatically
- ✅ **validate-site.sh** - Verify everything is correct

**Total time per website: ~15 minutes** (vs 2-4 hours manually)
