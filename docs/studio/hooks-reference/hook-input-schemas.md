# Hook Input/Output Schemas

Cursor hooks receive JSON on stdin. Project hooks run from the repository root.
Scripts in `.cursor/hooks/` parse the fields below (with fallbacks).

## beforeShellExecution

```json
{
  "command": "git commit -m 'feat: add player health system'"
}
```

`validate-commit.sh` and `validate-push.sh` also accept the older
`tool_input.command` shape. Return `{"permission":"allow"}` or
`{"permission":"deny","user_message":"...","agent_message":"..."}`.

## afterFileEdit

```json
{
  "file_path": "/abs/path/to/assets/data/enemy_stats.json",
  "edits": [{ "old_string": "...", "new_string": "..." }]
}
```

`validate-assets.sh` and `validate-skill-change.sh` also accept
`tool_input.file_path`.

## sessionStart

```json
{
  "session_id": "...",
  "is_background_agent": false,
  "composer_mode": "agent"
}
```

Output: `{"additional_context": "..."}`. Used by `session-start.sh` and
`detect-gaps.sh`.

## subagentStart / subagentStop

```json
{
  "subagent_type": "game-designer",
  "task": "..."
}
```

`log-agent.sh` / `log-agent-stop.sh` also accept `agent_type`.

## preCompact

Observational. `pre-compact.sh` returns
`{"user_message":"Context compacting. Read production/session-state/active.md to recover."}`.

## sessionEnd / stop

Fire-and-forget. `session-stop.sh` archives `production/session-state/active.md`.
