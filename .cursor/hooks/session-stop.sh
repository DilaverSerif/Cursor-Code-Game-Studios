#!/bin/bash
# Cursor sessionEnd / stop: archive session summary
set +e
cat >/dev/null
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p production/session-logs 2>/dev/null
STATE_FILE="production/session-state/active.md"
if [ -f "$STATE_FILE" ]; then
  {
    echo "## Archived Session State: $TIMESTAMP"
    cat "$STATE_FILE"
    echo "---"
  } >> production/session-logs/session-log.md 2>/dev/null
fi
exit 0
