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
else
  echo "cadre: this repo has NO root CLAUDE.md — the project is unwired. groundwork writes the anchor; spinup wires registers + entry file. Do not build past the missing anchor silently."
fi
