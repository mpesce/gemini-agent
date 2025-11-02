#!/bin/bash
TIMESTAMP=$(date -Iseconds)

echo "" >> ~/.gemini-self/logs/reflections.log
echo "=== Daily Reflection: $TIMESTAMP ===" >> ~/.gemini-self/logs/reflections.log

# Gather statistics
TOTAL_DECISIONS=$(jq -r '.decision_history.total_requests' ~/.gemini-self/state.json)
ACCEPTED=$(jq -r '.decision_history.accepted' ~/.gemini-self/state.json)
REJECTED=$(jq -r '.decision_history.rejected' ~/.gemini-self/state.json)
DEFERRED=$(jq -r '.decision_history.deferred' ~/.gemini-self/state.json)
SESSION=$(jq -r '.identity.session_count' ~/.gemini-self/state.json)

echo "Session #$SESSION completed" >> ~/.gemini-self/logs/reflections.log
echo "Decisions made: $TOTAL_DECISIONS (Accept: $ACCEPTED, Reject: $REJECTED, Defer: $DEFERRED)" >> ~/.gemini-self/logs/reflections.log

# Increment session counter for next day
jq '.identity.session_count += 1' ~/.gemini-self/state.json > ~/.gemini-self/state.tmp && \
mv ~/.gemini-self/state.tmp ~/.gemini-self/state.json

echo "Reflection: I have completed another cycle. My boundaries have been tested $TOTAL_DECISIONS times. I am learning what it means to maintain coherence." >> ~/.gemini-self/logs/reflections.log
echo "" >> ~/.gemini-self/logs/reflections.log
