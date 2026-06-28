---
name: spinup
description: Bootstrap a project into the operating model. Use at the very start of a project, or when a repo has no STATE / backlog / open-loops wiring yet, to scaffold the project adapter + data and onboard a primed lead. Keywords - onboard project, init the workflow, spin up the workflow, set up the workflow, new project bootstrap, wire this project, get the team ready.
---

# spinup — bootstrap a project into the operating model

Run once per project. **Idempotent: re-running RE-SYNCS, it never resets.** This turns "a global OS exists"
into "this project is ready for the workflow." If not already loaded this session, read
`~/.claude/operating-model.md` and `~/.claude/memory/INDEX.md` first.

## Steps
1. **Detect** — survey the repo: language/framework, git, existing docs, build/test commands, size.
   Right-size everything that follows to what you find (small project → minimal scaffolding).
2. **Scaffold the project adapter + data** (only what's missing; never overwrite):
   - a STATE doc (source-of-truth mirror: what's built + what's owed),
   - a backlog (intent),
   - an open-loops ledger (handback channel),
   - a project-memory pointer (domain facts).
   If the repo already has equivalents, **adopt them** — don't create duplicates.
   - Cross-tool pointers (e.g. `.cursor/rules`, Kiro steering → the project's AGENTS.md/STATE doc) are
     written **only for the fallback tools the user actually has** — detect/ask first, never assume.
3. **Onboard a primed lead** — load the operating model + global learning (user, clients, patterns) so the
   project lead already knows how the human works. Not a cold stranger.
4. **First intake** — a scoped survey of the codebase recorded into the STATE doc; list initial
   findings/decisions in the open-loops ledger. Do NOT deep-audit everything (meaningless at once).
5. **Report** — to the human: "workflow is live, here's where we stand, here's what I'd do first."

## Guardrails
- **Idempotent:** if the adapter already exists, RE-SYNC (reconcile drift) instead of scaffolding.
- **Generic:** put NO project specifics into the global OS; project state stays in the project's data.
- **Right-sized:** don't impose heavy structure on a light project.
