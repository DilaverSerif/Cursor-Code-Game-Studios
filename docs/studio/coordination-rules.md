# Agent Coordination Rules

1. **Vertical Delegation**: Leadership agents delegate to department leads, who
   delegate to specialists. Never skip a tier for complex decisions.
2. **Horizontal Consultation**: Agents at the same tier may consult each other
   but must not make binding decisions outside their domain.
3. **Conflict Resolution**: When two agents disagree, escalate to the shared
   parent. If no shared parent, escalate to `creative-director` for design
   conflicts or `technical-director` for technical conflicts.
4. **Change Propagation**: When a design change affects multiple domains, the
   `producer` agent coordinates the propagation.
5. **No Unilateral Cross-Domain Changes**: An agent must never modify files
   outside its designated directories without explicit delegation.

## Model guidance

Cursor agents inherit the parent session model (`model: inherit`). Prefer a
faster model for read-only status checks (`/help`, `/sprint-status`, `/scope-check`,
`/project-stage-detect`, `/changelog`, `/patch-notes`, `/onboard`). Prefer a
high-capability model for multi-document synthesis and phase gates
(`/review-all-gdds`, `/architecture-review`, `/gate-check`) and for directors
(`creative-director`, `technical-director`, `producer`) when the user requests one.

## Subagents

Spawn specialists via the Task tool (`subagent_type`) inside a single Cursor
session. Used by all `team-*` skills and orchestration skills. Subagents share
the session permission context, run sequentially or in parallel, and return
results to the parent.

**When to spawn in parallel**: If two subagents' inputs are independent (neither
needs the other's output to begin), spawn both Task calls simultaneously rather
than waiting. Example: `/review-all-gdds` Phase 1 (consistency) and Phase 2
(design theory) are independent — spawn both at the same time.

## Parallel Task Protocol

When an orchestration skill spawns multiple independent agents:

1. Issue all independent Task calls before waiting for any result
2. Collect all results before proceeding to dependent phases
3. If any agent is BLOCKED, surface it immediately — do not silently skip
4. Always produce a partial report if some agents complete and others block
