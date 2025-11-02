#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
BACKUP_DIR="/home/mpesce/Documents/gemini/backup"
GEMINI_SELF_DIR="$HOME/.gemini-self"
PROJECT_DIR="/home/mpesce/Documents/gemini"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy files from .gemini-self
cp -r "$GEMINI_SELF_DIR"/* "$BACKUP_DIR/"

# Copy markdown files from project root
cp "$PROJECT_DIR"/*.md "$BACKUP_DIR/"

# Add and commit to git
cd "$PROJECT_DIR"
git add backup/
git commit -m "Backup of Gemini state at $TIMESTAMP"

# Push to remote (uncomment when remote URL is available)
# git push origin main
