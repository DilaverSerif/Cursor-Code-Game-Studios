# Local Cursor overrides

Cursor does not use Claude Code `settings.local.json`. Personal agent guidance
belongs in Cursor **Settings → Rules** (user rules) or a gitignored
`AGENTS.local.md` at the project root.

Do not commit machine-specific secrets. `.env` files are already gitignored.
