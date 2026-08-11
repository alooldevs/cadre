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

**Writing the message is not enough.** Proven 2026-08-11: a commit written with no trailer still landed
with `Co-authored-by: Cursor` — the harness appends it after the message leaves the author's hands. So
the rule is a check, not a disposition:

```sh
git log -1 --format=%B | grep -i "co-authored\|generated with" && \
  git commit --amend -m "$(git log -1 --format=%B | sed '/^Co-authored-by:/Id; /generated with/Id')"
```

Run the check after **every** commit, before reporting it done. Same for PR bodies unless asked.
