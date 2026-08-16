#!/bin/bash
# Cursor preCompact: remind recovery from session state
set +e
cat >/dev/null
mkdir -p production/session-logs 2>/dev/null
echo "Context compaction at $(date)" >> production/session-logs/compaction-log.txt 2>/dev/null
python3 -c 'import json; print(json.dumps({"user_message":"Context compacting. Read production/session-state/active.md to recover."}))'
exit 0
