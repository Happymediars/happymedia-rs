#!/usr/bin/env bash
# ==========================================================================
#  Happy Media — git init + push na GitHub (macOS/Linux/Git Bash)
#  Uputstvo:
#  1) Napravi prazan repo na GitHub-u: https://github.com/new
#     - Name: happymedia-rs
#     - OSTAVI PRAZAN (ne dodaj README, .gitignore, license)
#  2) Pokreni ovaj script iz ovog foldera:
#       chmod +x git-push.sh && ./git-push.sh
# ==========================================================================

set -e

echo ""
echo "=== Happy Media — Deploy na GitHub ==="
echo ""
read -rp "GitHub username (npr. markocovic): " GH_USER
[[ -z "$GH_USER" ]] && { echo "Nisi uneo username."; exit 1; }

read -rp "Naziv repo-a [happymedia-rs]: " GH_REPO
GH_REPO=${GH_REPO:-happymedia-rs}

echo ""
echo "Remote URL: https://github.com/$GH_USER/$GH_REPO.git"
echo ""

rm -rf .git
git init -b main
git config user.email "marko@happymedia.rs"
git config user.name "Marko Covic"
git add .
git commit -m "Initial commit: happymedia.rs redesign 2026"
git remote add origin "https://github.com/$GH_USER/$GH_REPO.git"
git push -u origin main

echo ""
echo "=== USPEH ==="
echo "Repo: https://github.com/$GH_USER/$GH_REPO"
echo ""
echo "Sledeci korak — Vercel auto-deploy:"
echo "  1) https://vercel.com/new"
echo "  2) Import Git Repository — izaberi $GH_REPO"
echo "  3) Deploy"
