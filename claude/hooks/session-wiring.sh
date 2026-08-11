#!/usr/bin/env bash
# SessionStart — one line of wiring truth injected before the first prompt,
# so no session decides privately where it is. Compiled from the session-start
# ritual (anchor first) and the code-word ladder.
root=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$root" ]; then
  echo "cadre: not a git repo — nothing is wired. If this becomes a project: warmup (ideas, no commitments) or groundwork (define it, write the anchor)."
  exit 0
fi

if [ -f "$root/CLAUDE.md" ]; then
  echo "cadre: project entry found at repo root — anchor first, then registers; declare the mode per task (mapping | fixing | exploring)."
  # Stale truth mirror (ringwork: a stale index is worse than none — it gets trusted).
  state=$(grep -ioE 'STATE:[[:space:]]*[^[:space:]]+' "$root/CLAUDE.md" | head -1 | sed -E 's/^[Ss][Tt][Aa][Tt][Ee]:[[:space:]]*//')
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
  echo "cadre: this repo has NO root CLAUDE.md — the project is unwired. groundwork writes the anchor; spinup wires registers + entry file. Do not build past the missing anchor silently."
fi
