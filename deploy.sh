#!/bin/bash

# pleymob.com Deploy Script
# Copies content from Obsidian and pushes to GitHub Pages

OBSIDIAN_PATH="/Users/alfredo/Library/Mobile Documents/iCloud~md~obsidian/Documents/Docs/Projects/pleymob.com"
REPO_PATH="/Users/alfredo/Developer/github.com/gutierrezfredo/pleymob.com"

echo "🚀 Deploying pleymob.com..."
echo ""

# 1. Copy content from Obsidian
echo "📝 Copying content from Obsidian..."
cp "$OBSIDIAN_PATH/index.md" "$REPO_PATH/index.md"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to copy content from Obsidian"
    exit 1
fi

# 2. Check if there are changes
cd "$REPO_PATH"
if [[ -z $(git status -s) ]]; then
    echo "✨ No changes to deploy"
    exit 0
fi

# 3. Show what changed
echo ""
echo "📄 Changes detected:"
git status -s

# 4. Commit and push
echo ""
echo "💾 Committing changes..."
git add index.md
git commit -m "Update content from Obsidian

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

echo ""
echo "⬆️  Pushing to GitHub..."
git push

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployed successfully!"
    echo "🌐 Site will update at: https://pleymob.com"
    echo "⏱  GitHub Pages takes ~1 minute to rebuild"
else
    echo ""
    echo "❌ Error: Failed to push to GitHub"
    exit 1
fi
