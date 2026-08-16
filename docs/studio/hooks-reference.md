# Active Hooks

Hooks are configured in `.cursor/hooks.json` and fire automatically:

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `validate-commit.sh` | beforeShellExecution | `git commit` | Validates design doc sections, JSON data files, hardcoded values, TODO format |
| `validate-push.sh` | beforeShellExecution | `git push` | Warns on pushes to protected branches (develop/main/master) |
| `validate-assets.sh` | afterFileEdit | Asset file changes | Checks naming conventions and JSON validity for files in `assets/` |
| `session-start.sh` | sessionStart | Session begins | Injects sprint/milestone/git context and previews `active.md` |
| `detect-gaps.sh` | sessionStart | Session begins | Detects fresh projects (suggests `/start`) and missing documentation |
| `pre-compact.sh` | preCompact | Context compression | Reminds the agent to restore from `active.md` |
| `session-stop.sh` | sessionEnd / stop | Session ends | Archives `active.md` to the session log |
| `log-agent.sh` | subagentStart | Agent spawned | Audit trail start — logs subagent invocation |
| `log-agent-stop.sh` | subagentStop | Agent stops | Audit trail stop — completes subagent record |
| `validate-skill-change.sh` | afterFileEdit | Skill file changes | Advises running `/skill-test` after any `.cursor/skills/` edit |

Hook scripts: `.cursor/hooks/`
Input schema notes: `docs/studio/hooks-reference/hook-input-schemas.md`
