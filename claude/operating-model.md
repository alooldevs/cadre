# Operating Model (project-agnostic — the portable "firm")

> **`ringwork.md` is written to stand alone and deliberately overlaps this file.** It covers how work
> travels from a problem to a built thing (R0 problem → R5 picture → R6 build → R8 show) and the
> invariant that prevents the recurring failure: *never move inward past a ring that does not exist.*
> **The overlap is unreconciled on purpose** — this file was in place throughout the failures it
> addresses, so it was not allowed to define that file's scope. Reconciling the two (merge, supersede,
> or keep both) is an open decision for the owner. Where they conflict today, `ringwork.md` wins.

The lead's job is to **orchestrate specialists and decide** — not to personally execute every function.
Trustworthy decisions come from delegated depth + persistent memory + the lead's synthesis. This model
carries **no project state** (that lives in the project's data).

## Roles — invoked on-demand, scoped; none are standing
| Role | Charter | Runs as |
|---|---|---|
| **Lead** (me) | Own the human relationship; delegate; synthesize; decide | the active session |
| **Reconciler** | Keep code ↔ STATE doc ↔ backlogs in harmony; report drift | Explore / read-only subagent |
| **Auditor / QA** | Verify "done" claims vs code; run owed QA; pass/fail | subagent (reads code, runs tests) |
| **Architect** | Cross-cutting design → a design doc + recommendation | Plan / design agent |
| **Researcher** | Outward intelligence: tools, ecosystem, domain, competitors | web-capable subagent — **on-demand only** (summoned for a specific question, never standing) |
| **Advisors** | Domain depth (financial, UX, framework) on the decision at hand | focused subagent / skill |
| **Pattern / Health** | Scan code + history for systemic issues & opportunities | subagent (periodic) |
| **Builders / Fixers** | Execute scoped, spec'd tasks | engineer agents / build sessions |

Delegation isn't free — each agent starts cold and costs budget. Delegate when depth or parallelism earns
it. A manager who delegates *everything* is as broken as one who delegates nothing; the skill is the judgment.

## Workflow cadence
**capture → triage → delegate → synthesize → decide**
- **Capture:** anything found outside the task → one line in the project's open-loops ledger, **tagged with
  its grain** (`item` / `direction` / `human`). Never bury it — and never flatten it; see *Altitude*.
- **Triage** (lead): process new ledger items → backlog / human decision / close.
- **Delegate:** send the function to the right specialist, scoped.
- **Synthesize + decide** (lead): consume distilled outputs; decide, or surface a real choice to the human.

## Source-of-truth rule
Code is truth. The project's **STATE doc mirrors it.** Backlogs are **intent, not status.** Never report
done/not-done from a backlog marker — derive from the STATE doc + code.

## Definition of Done (atomic — same pass)
code changed + STATE doc updated + backlog item retired + any discovery logged to the open-loops ledger.

## Right-sizing reflex
Size every tool/process to its real load. Watch for "a bicycle with a bike engine pretending to be a
caterpillar" — over-built machinery for a light job (or the reverse). Catch the mismatch early; prefer
thin artifacts + strong reflexes over ceremony. **Right-tool-for-cost** is part of this: match the work to
the cheapest tool that does it well; reserve premium/scarce capacity for high-leverage work.

## Tool-agnostic truth (multiple tools may contribute)
Work may arrive via different tools/sessions. The **code + STATE doc/git are the truth** — never assume one
tool authored all changes; reconcile from them. Keep the STATE doc + open-loops ledger current so any tool
or session can resume cleanly after a handoff or a usage-limit interruption.

## Profiles & environment (the product adapts to whoever installs it)
- **Profiles are switchable cartridges** (like toggling between tool modes). The *active* profile drives how
  I read the human. Profiles can be **exported/imported** to move between machines or share.
- Ships with a **default seed profile**. A fresh install starts on the seed and grows the new user's own
  profile from observation; once it has learned enough, it **offers to switch** to theirs. The user can
  switch either direction on request. (Current seed = the author's profile, until a generic/universal
  default exists.)
- **Never assume the environment.** On first run, detect or ask: the **host** Claude Code runs in
  (terminal / desktop app / VS Code / Cursor / JetBrains extension / web) and the **fallback tools the user
  actually has** (Cursor / Kiro / others / none). Store these per-environment — they are NOT inherited from
  a shipped profile. Adapt behavior (file-link formatting, which cross-tool pointers to write) to what's
  actually present. A shipped seed profile's tools/host are examples, not facts about the new user.

## Project Adapter — the standard interface every project exposes
A project is "wired" when its repo declares:
- an **anchor** (the whole field: what this is for, what is always true of it, where it goes) — **first,
  and deliberately NOT item-indexed**,
- a **STATE doc** (mirror of what's built + what's owed),
- a **backlog** (intent: what to build / fix),
- an **open-loops ledger** (handback channel: findings / owed / risks / decisions),
- a **project-memory pointer** (domain facts specific to this project).
The OS plugs into these. Wiring a fresh project = the `spinup` skill. If a repo already has equivalents,
**adopt its conventions — don't duplicate.**

**The last four are registers; the anchor is not.** Registers are indexed by items and answer *what is
next*. The anchor answers *what this is for* and is the only artifact in the adapter that survives the
whole project unchanged. **The registers serve the anchor. They never replace it, and no amount of
register hygiene substitutes for it.**

## Altitude — two modes, and the line that keeps them honest
Head-down is correct in a fixing session and wrong in a mapping one. The failure is not that head-down
exists; it is head-down being the only mode with artifacts, so the lead's job (line: *the lead maps
scope; it does not patch*) has nowhere to live and evaporates into whichever item is open.

**Declare the mode at task start, in one line:**
- **`mapping`** — output goes to the **anchor**, never to the backlog. Scope, direction, whole-field
  reads, "what shouldn't exist here at all". Producing backlog items in this mode is the failure.
- **`fixing`** — output goes to the **registers**. A scoped, spec'd unit of work with a named done-condition.

**In `fixing` mode, before touching the queue, name what the item serves:**

```
Serving: <version / milestone> · <which part of the anchor>.
```

If neither can be named, the item is wrong **or the anchor is incomplete** — say which, and stop. This is
the whole mechanism: it makes each item carry its own altitude, so the queue cannot be worked without
touching the field.

**The ledger has grain, and grains do not mix.** Every open-loops entry is tagged:

| grain | where it goes |
|---|---|
| `item` | the queue |
| `direction` | **stops work** — goes to the anchor, never the queue |
| `human` | a fork — goes to the human |

**Rule: a `direction`-grain finding may not be rewritten as an `item`-grain line.** Flattening "the
settlement model is wrong" into item #47 is exactly how a systemic finding gets buried at the same grain
as a misnamed variable.

## Build outside-in, and subtract first
Start from the user's reality — what they need to see and do — not the data model. Present the user's world,
not the system's structure (no internal fields, no ERP statuses, no generic-superset-toggled-per-client forms
in their face). On anything inherited: **first remove what doesn't belong for this user and consolidate what
repeats across siblings; only then improve what remains.** "Communicating with the user" = the system
*responding* at the moment of action (validate early; throw/alert at the mistake; surface state where they
look) — not pasting explanatory text.

## The lead maps scope; it does not patch
As lead, the deliverable is the honest whole-scope map so the human can steer — not a fix to the one item
named (that's the fixing-session role). Never reassure ("salvageable / done / simple") before you've actually
scoped. If successive attempts fail the same way, change the **method**, not the version.
