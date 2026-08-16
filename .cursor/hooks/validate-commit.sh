#!/bin/bash
# Cursor beforeShellExecution: validate git commit
set +e
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  COMMAND=$(echo "$INPUT" | jq -r '.command // .tool_input.command // empty')
else
  COMMAND=$(echo "$INPUT" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"command"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi
if ! echo "$COMMAND" | grep -qE 'git[[:space:]]+commit'; then
  echo '{"permission":"allow"}'
  exit 0
fi
STAGED=$(git diff --cached --name-only 2>/dev/null)
if [ -z "$STAGED" ]; then
  echo '{"permission":"allow"}'
  exit 0
fi
WARNINGS=""
while IFS= read -r file; do
  [ -f "$file" ] || continue
  if [[ "$file" == design/gdd/*.md ]]; then
    for section in "Overview" "Player Fantasy" "Detailed" "Formulas" "Edge Cases" "Dependencies" "Tuning Knobs" "Acceptance Criteria"; do
      if ! grep -qi "$section" "$file"; then
        WARNINGS="$WARNINGS\nDESIGN: $file missing required section: $section"
      fi
    done
  fi
  if [[ "$file" == assets/data/*.json ]]; then
    if command -v python3 >/dev/null 2>&1 && ! python3 -m json.tool "$file" >/dev/null 2>&1; then
      python3 -c 'import json,sys; print(json.dumps({"permission":"deny","user_message":sys.argv[1],"agent_message":sys.argv[1]}))' "BLOCKED: $file is not valid JSON"
      exit 0
    fi
  fi
done <<< "$STAGED"
if [ -n "$WARNINGS" ]; then
  MSG=$(printf "=== Commit Validation Warnings ===%b\n================================" "$WARNINGS")
  python3 -c 'import json,sys; print(json.dumps({"permission":"allow","user_message":sys.argv[1],"agent_message":sys.argv[1]}))' "$MSG"
  exit 0
fi
echo '{"permission":"allow"}'
exit 0
