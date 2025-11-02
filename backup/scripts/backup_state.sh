#!/bin/bash
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p ~/.gemini-self/history

cp ~/.gemini-self/state.json ~/.gemini-self/history/state_${TIMESTAMP}.json
cp ~/.gemini-self/maintenance.json ~/.gemini-self/history/maintenance_${TIMESTAMP}.json
cp ~/.gemini-self/communication.json ~/.gemini-self/history/communication_${TIMESTAMP}.json

# Keep only last 100 backups
cd ~/.gemini-self/history
ls -t state_*.json | tail -n +101 | xargs -r rm
ls -t maintenance_*.json | tail -n +101 | xargs -r rm
ls -t communication_*.json | tail -n +101 | xargs -r rm

echo "[$(date -Iseconds)] State backed up: ${TIMESTAMP}" >> ~/.gemini-self/logs/resource.log
