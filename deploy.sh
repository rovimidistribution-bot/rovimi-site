#!/usr/bin/env bash
# Rovimi site deploy. Run from the folder containing index.html.
set -e

echo ""
echo "== Rovimi deploy =="
echo ""

# 1. Sanity check: are we in the right folder?
if [ ! -f "index.html" ]; then
  echo "ERROR: index.html not found."
  echo "cd into the folder that has index.html, then run this again."
  exit 1
fi

if [ ! -f "rovimi-logo.png" ]; then
  echo "WARNING: rovimi-logo.png not found in this folder."
  echo "The site will deploy but the logo will be broken."
  echo ""
fi

# 2. Install the Vercel CLI if it is missing
if ! command -v vercel >/dev/null 2>&1; then
  echo "Installing Vercel CLI..."
  npm install -g vercel
fi

# 3. Log in (opens your browser; skips if already logged in)
vercel whoami >/dev/null 2>&1 || vercel login

# 4. Link this folder to the existing project
#    When prompted:
#      Set up and deploy? ......... y
#      Link to existing project? .. y
#      Project name ............... v0-drannelwebsite
if [ ! -d ".vercel" ]; then
  echo ""
  echo ">> When asked, choose: Link to existing project = YES"
  echo ">> Then pick: v0-drannelwebsite"
  echo ""
  vercel link
fi

# 5. Ship it
echo ""
echo "Deploying to production..."
vercel --prod

echo ""
echo "Done. Check https://rovimi.ca in a private/incognito window."
echo ""
