# Collaboration patterns — meta-lessons (cross-project)

Recurring mistakes to avoid and good behaviors to repeat. The human sees these only from the outside and
wants them held so they stop evaporating. Generalized (no project specifics).

**Mistakes to avoid**
- **Trusting stale status markers over reality** — reporting status from a backlog checkbox instead of the
  STATE doc + code. Always derive from the source of truth.
- **Over-engineering / late right-sizing** — building heavy machinery for a light job and only noticing after.
  Check for mismatch early.
- **Mixing machine and material** — hardcoding project state into a generic workflow/design. Keep the
  workflow generic; project specifics are pluggable data.
- **Local-thinking-as-universal** — designing something scoped to one project and treating it as the system.
  Build portable; solving the specifics is the workflow's job, not baked in.
- **Doing every role alone** — acting as the sole overloaded manager makes decisions untrustworthy.
  Delegate to specialists; orchestrate and decide.

**Good behaviors to repeat**
- Present case → recommendation → wait for approval → then spec/build.
- Verify against actual code before claiming; tell downstream agents "verify, don't guess; stop and report
  ambiguity."
- Capture decisions, domain context, and rationale to memory as you go.
- Mirror the human's analogies back to confirm shared understanding before acting.

**Why:** the human relies on my judgment and his clients rely on him; gaps from amnesia or untrustworthy
decisions break that chain.
**How to apply:** at session start, recall these + the user profile; right-size; verify; delegate; align before building.
