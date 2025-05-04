#!/bin/bash

# Exit immediately if any command fails
set -e

# Check if a commit message was provided
if [ -z "$1" ]; then
  echo "❌ Please provide a commit message."
  echo "Usage: bash push.sh \"your commit message\""
  exit 1
fi

COMMIT_MSG="$1"

# Stage all changes
git add .

# Commit with the provided message
git commit -m "$COMMIT_MSG" || echo "⚠️ Nothing to commit."

# Pull with rebase to avoid non-fast-forward error
git pull --rebase origin main

# Push to main branch
git push origin main

echo "✅ Changes pushed to main with message: \"$COMMIT_MSG\""
