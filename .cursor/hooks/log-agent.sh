#!/bin/bash
# Cursor subagentStart: audit trail
set +e
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  AGENT_NAME=$(echo "$INPUT" | jq -r '.subagent_type // .agent_type // "unknown"' 2>/dev/null)
else
  AGENT_NAME="unknown"
fi
mkdir -p production/session-logs 2>/dev/null
echo "$(date +%Y%m%d_%H%M%S) | Agent invoked: $AGENT_NAME" >> production/session-logs/agent-audit.log 2>/dev/null
exit 0
