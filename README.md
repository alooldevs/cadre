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
- **A runtime, not just prose.** The rules that can fire on a string or an event are compiled into
  [Claude Code hooks](https://code.claude.com/docs/en/hooks) — scripts the machine runs regardless of
  whether the model remembers. Shipped so far: no AI co-author trailer on commits (auto-stripped);
  wiring status + stale-STATE warning at session start; the anchor re-injected every 10 turns so the
  field can't evaporate; and at Stop — reply length (D14), agreement without a change (C2),
  method-narration (D13), and additions-with-zero-deletions (B9).

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

## Packs (domain cartridges)
The core stays domain-agnostic; domain knowledge ships as **packs** — `~/.claude/packs/<name>/` with a
`detect.sh` that session-wiring runs at every session start. Silent when the project isn't its domain;
orienting (probe output, contract pointers, gates) when it is. See `claude/packs/README.md` for the
anatomy. First pack: a Frappe kit — probe, trigger-indexed framework contracts, scope generator.

## Profiles (switchable cartridges)
Cadre ships with a **seed profile** (the author's working style) as the default. A fresh install starts on the
seed, learns *you* over time, then offers to switch to your own. Switch either way, or export/import a profile
to move it between machines — just ask the `profile` skill.

Your profile is **yours**: client data and project specifics never live in it, and your toolset/host are
detected per-machine, not assumed.

## The code words
A ladder from idea to wired project — start wherever you actually are:
- **`warmup`** — just talking: brainstorm, ideas, discussion. Nothing is committed.
- **`groundwork`** — settle what the project *is* (problem → direction → position → shape) and write its
  anchor. Works in an empty folder.
- **`spinup`** — wire the repo: state doc, slices, backlog, open-loops ledger, entry file
  (`AGENTS.md` — the cross-tool standard, so any agent enters through the same contract). Walks you in warm.
- **`discuss`** — anywhere, mid-anything: step out of the work and think. The queue is suspended;
  nothing becomes scope unless you promote it on exit.
- **`survey`** — read-only reconnaissance: what's here, what's drifted, what's latent, what's owed.
  Nothing gets changed; findings promote only on your say.
- **`cadre`** — the help card: every word, when to use it, and which one applies right where you stand.

## Layout
```
claude/                 # overlay installed into ~/.claude/
  CLAUDE.md             # session-start ritual
  operating-model.md    # the firm: roles, workflow, altitude (load on demand)
  ringwork.md           # problem → picture → build → show; the alignment invariant
  operating-rules.md    # trigger → artifact; the mid-task checks
  hooks/                # the runtime: compiled rules that fire on events, not on memory
  skills/cadre/         # code word: the help card — all words + which applies here
  skills/warmup/        # code word: free exploration, output to the sky
  skills/discuss/       # code word: step out of the work, anywhere; promote on exit only
  skills/groundwork/    # code word: settle the outer rings, write the anchor
  skills/spinup/        # code word: wire the repo around the anchor
  skills/survey/        # code word: read-only reconnaissance, the whole-scope map
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

