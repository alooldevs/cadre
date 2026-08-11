#!/usr/bin/env bash
# PostToolUse (Bash) — compiled from memory/git-no-claude-coauthor.md.
# After any git commit, strip AI attribution trailers from the commit that just landed.
# The rule existed as prose and was violated while loaded; this runs regardless.
set -u
payload=$(cat)

cmd=$(printf '%s' "$payload" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null) || exit 0
case "$cmd" in *"git commit"*) ;; *) exit 0 ;; esac

cwd=$(printf '%s' "$payload" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("cwd",""))' 2>/dev/null)
cd "${cwd:-.}" 2>/dev/null || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

msg=$(git log -1 --format=%B 2>/dev/null) || exit 0
printf '%s\n' "$msg" | grep -qiE '^co-authored-by:|generated with' || exit 0

clean=$(printf '%s\n' "$msg" | sed -E '/^[Cc]o-[Aa]uthored-[Bb]y:/d; /[Gg]enerated [Ww]ith/d')

# Amend is only safe when nothing is staged (it would sweep staged changes in).
if git diff --cached --quiet 2>/dev/null; then
  git commit --amend --no-verify --allow-empty -m "$clean" >/dev/null 2>&1 && exit 0
fi

# Couldn't fix it silently — hand the model the exact command.
python3 - <<'PY'
import json
print(json.dumps({
    "decision": "block",
    "reason": ("An AI attribution trailer landed on the last commit and could not be auto-stripped "
               "(staged changes present). Strip it now, without committing the staged files: "
               "FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f "
               "--msg-filter 'sed \"/^Co-[Aa]uthored-by:/d; /[Gg]enerated with/d\"' HEAD~1..HEAD")
}))
PY
