#!/bin/bash
# Cursor afterFileEdit: remind /skill-test after skill edits
set +e
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  FILE_PATH=$(echo "$INPUT" | jq -r '.file_path // .tool_input.file_path // empty')
else
  FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi
FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')
echo "$FILE_PATH" | grep -qE '(^|/)\.cursor/skills/' || exit 0
SKILL_NAME=$(echo "$FILE_PATH" | grep -oE '\.cursor/skills/[^/]+' | sed 's|\.cursor/skills/||')
[ -n "$SKILL_NAME" ] || exit 0
echo "Skill modified: $SKILL_NAME. Run /skill-test static $SKILL_NAME" >&2
exit 0
