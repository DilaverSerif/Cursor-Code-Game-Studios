#!/bin/bash
# Cursor beforeShellExecution: warn on push to protected branches
set +e
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  COMMAND=$(echo "$INPUT" | jq -r '.command // .tool_input.command // empty')
else
  COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi
if ! echo "$COMMAND" | grep -qE 'git[[:space:]]+push'; then
  echo '{"permission":"allow"}'
  exit 0
fi
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
MATCHED=""
for branch in develop main master; do
  if [ "$CURRENT_BRANCH" = "$branch" ] || echo "$COMMAND" | grep -qE "[[:space:]]${branch}([[:space:]]|$)"; then
    MATCHED="$branch"
    break
  fi
done
if [ -n "$MATCHED" ]; then
  MSG="Push to protected branch '$MATCHED' detected. Ensure build and tests pass."
  python3 -c 'import json,sys; print(json.dumps({"permission":"allow","user_message":sys.argv[1],"agent_message":sys.argv[1]}))' "$MSG"
  exit 0
fi
echo '{"permission":"allow"}'
exit 0
