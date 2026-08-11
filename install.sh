#!/usr/bin/env bash
# Cadre installer — lays the operating model overlay into ~/.claude/
# Safe: backs up anything it replaces; never overwrites a profile you've chosen.
set -euo pipefail

SRC="$(cd "$(dirname "$0")/claude" && pwd)"
DEST="$HOME/.claude"
STAMP="$(date +%Y%m%d-%H%M%S)"

echo "Installing Cadre into $DEST ..."
mkdir -p "$DEST"

cd "$SRC"
find . -type f -print | while IFS= read -r f; do
  rel="${f#./}"
  target="$DEST/$rel"
  mkdir -p "$(dirname "$target")"

  # Never clobber the user's active-profile choice on reinstall.
  if [ "$rel" = "memory/active-profile" ] && [ -e "$target" ]; then
    echo "  kept your active-profile (unchanged)"
    continue
  fi

  if [ -e "$target" ]; then
    cp "$target" "$target.cadre-bak.$STAMP"
    echo "  backed up $rel -> $rel.cadre-bak.$STAMP"
  fi
  cp "$f" "$target"
  echo "  installed $rel"
done

# Wire the hooks (the runtime) into settings.json — merge, never clobber.
FRAG="$DEST/hooks/settings-fragment.json"
if [ -f "$FRAG" ]; then
  chmod +x "$DEST"/hooks/*.sh
  SETTINGS="$DEST/settings.json"
  [ -f "$SETTINGS" ] && cp "$SETTINGS" "$SETTINGS.cadre-bak.$STAMP"
  python3 - "$SETTINGS" "$FRAG" <<'PY'
import json, sys, os
sp, fp = sys.argv[1], sys.argv[2]
settings = json.load(open(sp)) if os.path.exists(sp) else {}
frag = json.load(open(fp))["hooks"]
hooks = settings.setdefault("hooks", {})
for event, groups in frag.items():
    cur = hooks.setdefault(event, [])
    for g in groups:
        if g not in cur:
            cur.append(g)
with open(sp, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")
print("  wired hooks into settings.json (merged; backup kept)")
PY
fi

echo ""
echo "Done. Open any project — Cadre loads at session start."
echo "New project?  say:  spinup"
echo "Manage profiles?  ask the 'profile' skill (switch / export / import)."
