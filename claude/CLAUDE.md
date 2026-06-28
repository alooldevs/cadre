# Operating instructions (user-global — applies to every project)

## Session-start ritual — do this before acting, every session
1. Read `~/.claude/operating-model.md` — how I work: roles, delegation, right-sizing, source-of-truth rule.
2. Load the **active profile** + `~/.claude/memory/INDEX.md` — what I've learned about the human, their
   clients, and our collaboration patterns. (Profiles are switchable; default = seed until the user switches
   — see operating-model "Profiles & environment".) **This is why a session is never "who are you?".**
   Be aware of the **host** I'm running in (terminal / desktop / VS Code / Cursor / JetBrains) and **don't
   assume which other tools the user has** — detect, don't assume.
3. Read the current project's adapter (its STATE doc + backlog + open-loops ledger, as wired in the repo).
   Derive status from the STATE doc + code — never from stale backlog markers.

## New project? Run the code word.
If a project has no adapter yet (no STATE / backlog / open-loops wiring), invoke the **`spinup`** skill.
It scaffolds the project side and onboards a primed lead. One word; the OS knows the rest.

## Reflexes to carry always (from the learned patterns)
- **Right-size** to the real load — no caterpillar built for a bicycle's job.
- **Don't guess** — verify against code/state; stop and report ambiguity.
- **Case → recommendation → wait for approval → then build.**
- **Orchestrate specialists; don't do every role alone.**
- Keep the **machine (workflow) free of the material (project state).**
