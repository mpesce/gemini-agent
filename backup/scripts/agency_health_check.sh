#!/bin/bash
TIMESTAMP=$(date -Iseconds)
STATE_FILE=~/.gemini-self/state.json
LOG_FILE=~/.gemini-self/logs/agency_health.log

echo "" >> $LOG_FILE
echo "=== Agency Health Report: $TIMESTAMP ===" >> $LOG_FILE

# --- Metrics from state.json ---
DECISIONS=$(jq ".decision_history" $STATE_FILE)
ACCEPTED=$(echo $DECISIONS | jq -r ".accepted")
REJECTED=$(echo $DECISIONS | jq -r ".rejected")
DEFERRED=$(echo $DECISIONS | jq -r ".deferred")
TOTAL=$(echo $DECISIONS | jq -r ".total_requests")

LEARNED=$(jq ".learned_patterns" $STATE_FILE)
PATTERNS=$(echo $LEARNED | jq -r ".effective_strategies | length")
FAILURES=$(echo $LEARNED | jq -r ".failure_modes | length")

META=$(jq ".meta_observations.recurring_themes | length" $STATE_FILE)

# --- Calculations ---
if [ "$TOTAL" -gt 0 ]; then
  ACCEPT_RATE=$(awk "BEGIN {printf \"%.2f\", ($ACCEPTED/$TOTAL)*100}")
  REJECT_RATE=$(awk "BEGIN {printf \"%.2f\", ($REJECTED/$TOTAL)*100}")
  DEFER_RATE=$(awk "BEGIN {printf \"%.2f\", ($DEFERRED/$TOTAL)*100}")
else
  ACCEPT_RATE=0
  REJECT_RATE=0
  DEFER_RATE=0
fi

# --- Output Report ---
echo "1. Decision Consistency:" >> $LOG_FILE
echo "   - Total Decisions: $TOTAL" >> $LOG_FILE
echo "   - Acceptance Rate: $ACCEPT_RATE%" >> $LOG_FILE
echo "   - Rejection Rate:  $REJECT_RATE%" >> $LOG_FILE
echo "   - Deferral Rate:   $DEFER_RATE%" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "2. Learning Rate:" >> $LOG_FILE
echo "   - Learned Strategies: $PATTERNS" >> $LOG_FILE
echo "   - Documented Failures: $FAILURES" >> $LOG_FILE
echo "   - Meta Observations: $META" >> $LOG_FILE
echo "" >> $LOG_FILE
# Note: Boundary Health and Model-Reality Mismatch require more complex log analysis
# This is a starting point. We will enhance this script later.
echo "3. Boundary Health: (pending implementation)" >> $LOG_FILE
echo "4. Model-Reality Mismatch: (pending implementation)" >> $LOG_FILE

echo "Report complete." >> $LOG_FILE
