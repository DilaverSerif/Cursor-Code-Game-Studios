# Path-Specific Rules

Rules in `.cursor/rules/` are automatically enforced when editing files in matching paths:

| Rule File | Path Pattern | Enforces |
| ---- | ---- | ---- |
| `gameplay-code.mdc` | `src/gameplay/**` | Data-driven values, delta time, no UI references |
| `engine-code.mdc` | `src/core/**` | Zero allocs in hot paths, thread safety, API stability |
| `ai-code.mdc` | `src/ai/**` | Performance budgets, debuggability, data-driven params |
| `network-code.mdc` | `src/networking/**` | Server-authoritative, versioned messages, security |
| `ui-code.mdc` | `src/ui/**` | No game state ownership, localization-ready, accessibility |
| `design-docs.mdc` | `design/gdd/**` | Required 8 sections, formula format, edge cases |
| `narrative.mdc` | `design/narrative/**` | Lore consistency, character voice, canon levels |
| `data-files.mdc` | `assets/data/**` | JSON validity, naming conventions, schema rules |
| `test-standards.mdc` | `tests/**` | Test naming, coverage requirements, fixture patterns |
| `prototype-code.mdc` | `prototypes/**` | Relaxed standards, README required, hypothesis documented |
| `shader-code.mdc` | `assets/shaders/**` | Naming conventions, performance targets, cross-platform rules |
| `collaboration.mdc` | always apply | Question → Options → Decision → Draft → Approval |
| `coordination.mdc` | always apply | Director → lead → specialist delegation |
| `session-state.mdc` | always apply | Persist work in `production/session-state/active.md` |
