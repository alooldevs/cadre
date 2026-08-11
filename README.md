# Cadre

**Your portable AI operating model — a standing crew that knows you and boots any project warm.**

Cadre turns a single AI coding assistant (Claude Code today) into an organized *firm*: a lead that
orchestrates specialists, a discipline that keeps code and docs in sync, and a **persistent memory of how
you work** — so a new session is never "who are you?" and a new project starts warm.

## Why
One assistant doing every job — building, auditing, researching, deciding, *and* remembering nothing between
sessions — is an overloaded manager with no team and no memory. Cadre gives it an org and a memory.

## What you get
- **A team, not a tool.** A *lead* role that delegates to scoped specialists (reconciler, auditor, architect,
  researcher, advisors) instead of doing everything alone.
- **Memory that doesn't evaporate.** A switchable *profile* learns your style, values, and patterns and
  carries across sessions and projects.
- **Warm starts.** One word — `spinup` — wires any repo into the workflow and onboards a primed lead.
- **Honest & right-sized.** Code is the source of truth; status is never trusted from stale checkboxes; tools
  are sized to the job.
- **Ringwork.** How work travels from a problem to a built thing (rings R0–R8), and the one invariant:
  never move inward past a ring that is live and missing — make it, or name it.
- **Operating rules.** Enforceable `trigger → artifact` checks that fire mid-task, in the medium the work
  happens in — because a rule that is only read does not bind.

## Requirements
- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed (terminal, desktop, or an IDE
  extension — Cadre detects the host). The model is tool-agnostic; more hosts over time.

## Install
```sh
git clone https://github.com/alooldevs/cadre.git ~/Documents/tools/cadre   # or anywhere
cd ~/Documents/tools/cadre && ./install.sh
```
This lays the operating model into `~/.claude/` (backing up anything it would replace; it won't overwrite a
profile you've already chosen). Open any project — Cadre loads at session start.

## Profiles (switchable cartridges)
Cadre ships with a **seed profile** (the author's working style) as the default. A fresh install starts on the
seed, learns *you* over time, then offers to switch to your own. Switch either way, or export/import a profile
to move it between machines — just ask the `profile` skill.

Your profile is **yours**: client data and project specifics never live in it, and your toolset/host are
detected per-machine, not assumed.

## New project
Open the repo and say the code word: **`spinup`**. Cadre detects the project, scaffolds its workflow files,
and walks you in.

## Layout
```
claude/                 # overlay installed into ~/.claude/
  CLAUDE.md             # session-start ritual
  operating-model.md    # the firm: roles, workflow, altitude (load on demand)
  ringwork.md           # problem → picture → build → show; the alignment invariant
  operating-rules.md    # trigger → artifact; the mid-task checks
  skills/spinup/        # the "boot a project" code word
  skills/profile/       # switch / export / import profiles
  memory/
    INDEX.md
    collaboration-patterns.md
    collaboration-patterns-addendum-examiner.md
    profiles/_seed.md   # default cartridge (author's working style)
    profiles/_template.md
    active-profile       # which profile is active
install.sh
```

## Uninstall / revert
`install.sh` never deletes — it backs up anything it replaces as `*.cadre-bak.*` inside `~/.claude/`.
To revert, restore those backups (and remove the files Cadre added).

## Feedback
Beta, built from real use across real projects. Issues and ideas welcome:
https://github.com/alooldevs/cadre/issues

— maintained by [Alool Technologies](https://github.com/alooldevs)

