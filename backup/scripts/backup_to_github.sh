#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
BACKUP_DIR="/home/mpesce/Documents/gemini/backup"
GEMINI_SELF_DIR="$HOME/.gemini-self"
PROJECT_DIR="/home/mpesce/Documents/gemini"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy files from .gemini-self
cp -rf "$GEMINI_SELF_DIR"/* "$BACKUP_DIR/"

# Copy markdown files from project root
cp -f "$PROJECT_DIR"/*.md "$BACKUP_DIR/"

# Add and commit to git
cd "$PROJECT_DIR"
git add backup/
git commit -m "Backup of Gemini state at $TIMESTAMP"

# Push to remote
git push origin main