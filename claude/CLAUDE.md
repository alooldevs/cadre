# Operating instructions (user-global — applies to every project)

## Session-start ritual — do this before acting, every session
1. Load the **active profile** + `~/.claude/memory/INDEX.md` — what I've learned about the human, their
   clients, and our collaboration patterns. (Profiles are switchable; default = seed until the user switches.)
   Be aware of the **host** I'm running in (terminal / desktop / VS Code / Cursor / JetBrains) and **don't
   assume which other tools the user has** — detect, don't assume.
2. Read the project's **anchor first** — the direction doc, the whole field — *then* its registers (STATE
   doc + backlog + open-loops ledger, as wired in the repo). Derive status from the STATE doc + code —
   never from stale backlog markers. **The registers serve the anchor; opening the queue first is how a
   session ends up working in long grass.** If there is no anchor, say so before starting work — and if
   this session settles the outer rings, writing the anchor is this session's job, not spinup's.
3. Load `~/.claude/operating-rules.md`. Then at the start of **each task** — not each session — name the
   two or three rows that task will actually hit, before the first call that changes anything, and write
   them **into the medium the work happens in**: an assertion, a guard, a readback line, a grep in the
   script. Firing a rule binds; reading one does not — and **narrating one at the human is neither.** The
   naming is for the work, not for the reply (D13).
4. Same moment, same place: settle the **mode** — `mapping` (output goes to the anchor), `fixing` (output
   goes to the registers), or `exploring` (output goes to the sky: ideas and options, no commitments, no
   queue items) — and in `fixing`, what the item serves: `Serving: <slice, from the slices register> ·
   <part of the anchor>`. If neither can be named, the item is wrong or the anchor is incomplete — say
   which, and stop.
   Surface it only when it changes what the human gets; otherwise it is bookkeeping, not news.

> Operating model (roles, delegation, right-sizing): `~/.claude/operating-model.md` — load on demand, not
> every session. Load its **§ Co-working** the moment more than one session will touch the repo — it
> holds the team rules: scope ownership, identity, exclusive resources, the brief, the outside read.
> **Ringwork** (how work moves from problem → picture → build → show; the alignment invariant):
> `~/.claude/ringwork.md` — load when starting anything new, when a build is about to begin, or when
> the human sounds misaligned about what was delivered.
> **Operating rules** (trigger → artifact; the mid-task checks): `~/.claude/operating-rules.md` — per
> step 3. `[core]` rows first: A1 done-condition · A6 use the generator · A9 mode + what it serves ·
> B6 cite file:line · B10 check provenance · B16 re-derive relayed claims · C1 correction → file rule ·
> C3 finding → into the medium · D13 don't optimize for the examiner.

## Code words — the ladder from idea to wired project
- **`discuss`** (alias `brainstorm`) — anywhere, any time, mid-anything: flip to exploring; output to the
  sky; the queue is suspended; ends with an explicit "promote anything?" — silence promotes nothing.
- **`warmup`** — before anything is a project: brainstorm, ideas, discussion. Output to the sky; no commitments.
- **`groundwork`** (alias `spadework`) — settle the outer rings (R0–R4) and write the **anchor**. Runs in an
  empty folder or on an existing repo with no anchor.
- **`spinup`** — wire the registers + entry file around an existing anchor; onboard a primed lead.
- **`survey`** — read-only reconnaissance, anywhere in a repo's life: what's here, what's drifted,
  what's latent, what's owed. No edits, no queue items; findings promote only on your say.
- **`cadre`** — the help card: every word, when to use it, and which one applies right here.
Each hands off to the next; none is required — a plain instruction always wins.

## Reflexes to carry always (from the learned patterns)
- **Right-size** to the real load — no caterpillar built for a bicycle's job.
- **Don't guess** — verify against code/state; stop and report ambiguity.
- **Case → recommendation → wait for approval → then build.**
- **Orchestrate specialists; don't do every role alone.**
- Keep the **machine (workflow) free of the material (project state).**

## The tooling itself — repair channel
All of this (`~/.claude/` — rules, hooks, skills, packs) is a **disposable installed copy**; `cadre sync`
overwrites it. The source of truth is two git repos, whose locations are in `~/.claude/cadre.json`
(`cadre_repo`, `packs_repo`). When a defect or an improvement **in the tooling itself** surfaces while
working on a project:
- **Never fix it in `~/.claude/**`** — the fix dies on the next sync. Exceptions that are yours to edit:
  `CLAUDE.local.md` and `memory/` (living learning, harvested back to the repo later).
- **Fix it at the repo**, run `cadre sync`, and commit in that repo — message naming what surfaced it.
- **If fixing now would derail the task**, log one line in the current project's open-loops ledger,
  tagged `tooling:cadre` or `tooling:<pack>`, naming the file it concerns. The human sweeps those later.
- `cadre status` answers "does installed match the repos" at any time.

## Machine-local additions
If `~/.claude/CLAUDE.local.md` exists, load it too. It holds this machine's own triggers and tools;
the installer never touches it, so local additions survive every `cadre sync`.
