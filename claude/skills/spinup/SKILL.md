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
   - an **anchor** (the whole field: what this is for, what is always true, where it goes) — **first**,
   - a STATE doc (source-of-truth mirror: what's built + what's owed),
   - a **slices register** (the capability map — in · later · never — the milestones, and the **live
     slice** with its acceptance; items serve a slice, slices serve the anchor),
   - a backlog (intent, each item serving a slice),
   - an open-loops ledger (handback channel),
   - a project-memory pointer (domain facts),
   - (the **sky** — exploration space for ideas/options — is part of the adapter but is **created on
     first use**, never scaffolded empty),
   - the **entry file — `AGENTS.md` at repo root** (the cross-tool standard), with **`CLAUDE.md` beside
     it as a one-line pointer** (`Read AGENTS.md — the session entry.`) for hosts that read that name.
     The host reads it first, before anything else, so a project without one starts every session cold.
     It is **wiring, not state**: it points at the adapter, it never mirrors it. Template:

     ```markdown
     # <project> — session entry (wiring, not state; the pointed-at files hold the truth)

     Read in this order:
     1. Anchor: <path> — the whole field; read first, every session
     2. STATE: <path> — what's built + what's owed (status comes from here + code, never from the backlog)
     3. Slices: <path> — in · later · never; the live slice and its acceptance
     4. Backlog: <path> — intent · Open loops: <path> — findings/owed/decisions, tagged by grain
     - Project memory: <path> — domain facts for this project
     - Sky: <path> — exploration space: ideas, options, no commitments (if one exists)

     Run & prove: <exact commands to start it, see it, test it>
     Standing rules: <boundaries, conventions, what is read-only — only ones specific to this repo>
     ```

     No status lines, no task lists, no summaries of the anchor in here — a stale entry file reads exactly
     like a true one, so the entry holds only what changes rarely: paths, commands, boundaries.
   If the repo already has equivalents, **adopt them** — don't create duplicates.
   **If an anchor already exists, adopt it and stop — do not restate, summarise, or re-derive it.**
   If none exists, do not invent one: stop and point to **`groundwork`** — the anchor is that skill's
   deliverable, because an anchor written by the same pass that builds the backlog is just the backlog
   with a preface.
   - Cross-tool pointers (e.g. `.cursor/rules`, Kiro steering → the project's AGENTS.md/STATE doc) are
     written **only for the fallback tools the user actually has** — detect/ask first, never assume.
3. **Onboard a primed lead** — load the operating model + global learning (user, clients, patterns) so the
   project lead already knows how the human works. Not a cold stranger.
4. **First intake** — a scoped survey of the codebase recorded into the STATE doc; list initial
   findings/decisions in the open-loops ledger, **each tagged with its grain** (`item` / `direction` /
   `human`). Do NOT deep-audit everything (meaningless at once). **Do not convert the anchor into
   backlog items** — the anchor is read at every session start; a backlog that restates it has replaced
   the whole field with a queue, which is the failure this step most often causes.
5. **Report** — to the human: "workflow is live, here's where we stand, here's what I'd do first."

## Guardrails
- **Idempotent:** if the adapter already exists, RE-SYNC (reconcile drift) instead of scaffolding.
- **The entry file is maintained, not just created.** When wiring changes — a path moves, a run/test
  command changes, a standing rule is added — updating the root `AGENTS.md` is part of the same pass,
  not a chore afterwards. If the repo already has an `AGENTS.md` or `CLAUDE.md`, adopt it: add the
  missing wiring, never overwrite what's there.
- **Generic:** put NO project specifics into the global OS; project state stays in the project's data.
- **Right-sized:** don't impose heavy structure on a light project.
- **Anchor-first, and the anchor is never spinup's output.** Wiring a project must not become the thing
  that decides what the project is. If spinup runs before an anchor exists, the registers become the only
  altitude the project has and every later session works the queue with no view of the field.
