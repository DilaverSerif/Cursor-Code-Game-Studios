#!/bin/bash
# Cursor sessionStart: inject studio context
set +e
cat >/dev/null
{
  echo "=== Cursor Code Game Studios — Session Context ==="
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$BRANCH" ]; then
    echo "Branch: $BRANCH"
    echo ""
    echo "Recent commits:"
    git log --oneline -5 2>/dev/null | while read -r line; do echo "  $line"; done
  fi
  LATEST_SPRINT=$(ls -t production/sprints/sprint-*.md 2>/dev/null | head -1)
  if [ -n "$LATEST_SPRINT" ]; then
    echo ""
    echo "Active sprint: $(basename "$LATEST_SPRINT" .md)"
  fi
  LATEST_MILESTONE=$(ls -t production/milestones/*.md 2>/dev/null | head -1)
  if [ -n "$LATEST_MILESTONE" ]; then
    echo "Active milestone: $(basename "$LATEST_MILESTONE" .md)"
  fi
  STATE_FILE="production/session-state/active.md"
  if [ -f "$STATE_FILE" ]; then
    echo ""
    echo "=== ACTIVE SESSION STATE DETECTED ==="
    echo "Read $STATE_FILE to recover context."
    echo "Quick summary (last 20 lines):"
    tail -20 "$STATE_FILE" 2>/dev/null
    echo "=== END SESSION STATE PREVIEW ==="
  fi
  echo "==================================="
} | python3 -c 'import json,sys; print(json.dumps({"additional_context": sys.stdin.read()}))'
exit 0
