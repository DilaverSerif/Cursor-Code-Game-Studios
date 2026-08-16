#!/bin/bash
# Cursor sessionStart: suggest /start or reverse-document on gaps
set +e
cat >/dev/null
{
  echo "=== Checking for Documentation Gaps ==="
  FRESH_PROJECT=true
  TECH="docs/studio/technical-preferences.md"
  if [ -f "$TECH" ]; then
    ENGINE_LINE=$(grep -E "^\- \*\*Engine\*\*:" "$TECH" 2>/dev/null)
    if [ -n "$ENGINE_LINE" ] && ! echo "$ENGINE_LINE" | grep -q "TO BE CONFIGURED" 2>/dev/null; then
      FRESH_PROJECT=false
    fi
  fi
  [ -f "design/gdd/game-concept.md" ] && FRESH_PROJECT=false
  if [ -d "src" ]; then
    SRC_CHECK=$(find src -type f \( -name "*.gd" -o -name "*.cs" -o -name "*.cpp" -o -name "*.h" -o -name "*.ts" \) 2>/dev/null | head -1)
    [ -n "$SRC_CHECK" ] && FRESH_PROJECT=false
  fi
  if [ "$FRESH_PROJECT" = true ]; then
    echo "NEW PROJECT: No engine, concept, or source. Run: /start"
    echo "==================================="
  else
    echo "Project artifacts found. For a full gap analysis run: /project-stage-detect"
    echo "==================================="
  fi
} | python3 -c 'import json,sys; print(json.dumps({"additional_context": sys.stdin.read()}))'
exit 0
