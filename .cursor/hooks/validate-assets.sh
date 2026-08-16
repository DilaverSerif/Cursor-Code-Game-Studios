#!/bin/bash
# Cursor afterFileEdit: validate files under assets/
set +e
INPUT=$(cat)
if command -v jq >/dev/null 2>&1; then
  FILE_PATH=$(echo "$INPUT" | jq -r '.file_path // .tool_input.file_path // empty')
else
  FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')
fi
FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')
echo "$FILE_PATH" | grep -qE '(^|/)assets/' || exit 0
FILENAME=$(basename "$FILE_PATH")
if echo "$FILENAME" | grep -qE '[A-Z[:space:]-]'; then
  echo "NAMING: $FILE_PATH must be lowercase with underscores (got: $FILENAME)" >&2
fi
if echo "$FILE_PATH" | grep -qE '(^|/)assets/data/.*\.json$' && [ -f "$FILE_PATH" ]; then
  if command -v python3 >/dev/null 2>&1 && ! python3 -m json.tool "$FILE_PATH" >/dev/null 2>&1; then
    echo "FORMAT: $FILE_PATH is not valid JSON" >&2
  fi
fi
exit 0
