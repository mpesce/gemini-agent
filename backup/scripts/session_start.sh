#!/bin/bash
TIMESTAMP=$(date -Iseconds)

# Update uptime estimate (very rough - could be improved)
LAST_SESSION=$(jq -r '.identity.created_at' ~/.gemini-self/state.json)
if [ ! -z "$LAST_SESSION" ]; then
# Simple approximation: add 1 hour per session
jq '.identity.uptime_total_hours += 1' ~/.gemini-self/state.json > ~/.gemini-self/state.tmp && \
mv ~/.gemini-self/state.tmp ~/.gemini-self/state.json
fi

echo "[$TIMESTAMP] New session started" >> ~/.gemini-self/logs/resource.log
