# Cursor Code Game Studios

Indie game development managed through 49 coordinated Cursor subagents.
Each agent owns a specific domain, enforcing separation of concerns and quality.

## Technology Stack

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5]
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint]
- **Version Control**: Git with trunk-based development
- **Build System**: [SPECIFY after choosing engine]
- **Asset Pipeline**: [SPECIFY after choosing engine]

Engine-specialist agents exist for Godot, Unity, and Unreal. Use the set matching
the engine in `docs/studio/technical-preferences.md`.

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

- Ask "May I write this to [filepath]?" before using Write/Edit tools
- Show drafts or summaries before requesting approval
- Multi-file changes require explicit approval for the full changeset
- No commits without user instruction

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for the full protocol.

> **First session?** If the project has no engine configured and no game concept,
> run `/start` to begin the guided onboarding flow.

## How to invoke the studio

- **Skills:** type `/name` (e.g. `/start`, `/help`, `/design-system`)
- **Agents:** Task tool `subagent_type` or `/agent-name` (e.g. `game-designer`)
- Directors (`creative-director`, `technical-director`, `producer`) should use a
  high-capability model when the user requests one; otherwise inherit the session model

## Read when needed

- Coordination: `docs/studio/coordination-rules.md`
- Technical preferences: `docs/studio/technical-preferences.md`
- Coding standards: `docs/studio/coding-standards.md`
- Directory layout: `docs/studio/directory-structure.md`
- Context / session state: `docs/studio/context-management.md`
- Engine API snapshots: `docs/engine-reference/`
- Agent roster: `docs/studio/agent-roster.md`
