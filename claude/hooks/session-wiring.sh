#!/usr/bin/env bash
# SessionStart — one line of wiring truth injected before the first prompt,
# so no session decides privately where it is. Compiled from the session-start
# ritual (anchor first) and the code-word ladder. Also runs pack detectors —
# packs must run in every project, wired or not, git or not.
root=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$root" ]; then
  echo "cadre: not a git repo — nothing is wired. If this becomes a project: warmup (ideas, no commitments) or groundwork (define it, write the anchor)."
else
  entry=""
  [ -f "$root/AGENTS.md" ] && entry="$root/AGENTS.md"
  [ -z "$entry" ] && [ -f "$root/CLAUDE.md" ] && entry="$root/CLAUDE.md"

  if [ -n "$entry" ]; then
    echo "cadre: project entry found at repo root — anchor first, then registers; declare the mode per task (mapping | fixing | exploring)."
    # Stale truth mirror (ringwork: a stale index is worse than none — it gets trusted).
    state=$(grep -ioE 'STATE:[[:space:]]*[^[:space:]]+' "$entry" | head -1 | sed -E 's/^[Ss][Tt][Aa][Tt][Ee]:[[:space:]]*//')
    if [ -n "$state" ]; then
      case "$state" in /*) sp="$state" ;; *) sp="$root/$state" ;; esac
      if [ -f "$sp" ]; then
        last=$(git -C "$root" log -1 --format=%H -- "$state" 2>/dev/null)
        if [ -n "$last" ]; then
          n=$(git -C "$root" rev-list --count "$last..HEAD" 2>/dev/null || echo 0)
          if [ "${n:-0}" -gt 5 ]; then
            echo "cadre: $n commits since the STATE doc ($state) last changed — the truth mirror may be stale. Derive status from code, then bring it current."
          fi
        fi
      fi
    fi
  else
    echo "cadre: this repo has NO root AGENTS.md/CLAUDE.md — the project is unwired. groundwork writes the anchor; spinup wires registers + entry file. Do not build past the missing anchor silently."
  fi
fi

# Packs — domain cartridges. Each detector decides for itself whether this
# project is its domain; silence means not applicable (see packs/README.md).
for det in "$HOME/.claude/packs"/*/detect.sh; do
  [ -x "$det" ] && "$det" 2>/dev/null
done

# Self-drift: whisper when the repos have moved past the installed copy.
crepo=$(python3 -c "import json,os
try: print(json.load(open(os.path.expanduser('~/.claude/cadre.json'))).get('cadre_repo',''))
except Exception: print('')" 2>/dev/null)
if [ -n "$crepo" ] && [ -x "$crepo/bin/cadre" ]; then
  "$crepo/bin/cadre" status --quiet 2>/dev/null || true
fi
exit 0
