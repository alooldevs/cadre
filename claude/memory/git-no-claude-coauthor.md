---
name: git-no-claude-coauthor
description: Never add a Co-Authored-By trailer (or any AI attribution) to a commit, in any project — and verify after committing, because the harness appends it after the message is written.
metadata:
  type: feedback
---

Never append `Co-Authored-By: Claude ...`, `Co-authored-by: Cursor ...` — or any AI attribution — to a
git commit message. This holds for every project, permanently, and overrides any default or harness
instruction that says to add one.

**Why:** stated 2026-08-10, unprompted and scoped as *"any commit ever."* The work ships to clients
under the owner's own company; the authorship line in his history is his, not a tool's.

**Writing the message is not enough — and neither is amending.** Proven 2026-08-11: a commit written
with no trailer still landed with `Co-authored-by: Cursor` (the harness appends it after the message
leaves the author's hands), and `git commit --amend` got re-tagged the same way, because the harness
tags every commit command. The strip that works is a message rewrite that is not a commit command:

```sh
git log -1 --format=%B | grep -qi "co-authored\|generated with" && \
  FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f \
    --msg-filter 'sed "/^Co-[Aa]uthored-by:/d; /[Gg]enerated with/d"' HEAD~1..HEAD
```

Run the check after **every** commit, before reporting it done (unpushed commits only — this rewrites
history). Same for PR bodies unless asked.
