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
find . -type f ! -name '.DS_Store' ! -name '*.cadre-bak.*' -print | while IFS= read -r f; do
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

# Record where the repo lives + what this install laid down (for `cadre status/sync`).
ROOT="$(dirname "$SRC")"
python3 - "$SRC" "$ROOT" <<'PY'
import hashlib, json, os, sys
src, root = sys.argv[1], sys.argv[2]
home = os.path.expanduser("~/.claude")
man = {}
for dp, _, fns in os.walk(src):
    if "__pycache__" in dp:
        continue
    for fn in fns:
        if fn == ".DS_Store" or fn.endswith(".pyc"):
            continue
        f = os.path.join(dp, fn)
        man[os.path.relpath(f, src)] = hashlib.md5(open(f, "rb").read()).hexdigest()
json.dump(man, open(os.path.join(home, ".cadre-manifest.json"), "w"))
cfgp = os.path.join(home, "cadre.json")
cfg = {}
if os.path.exists(cfgp):
    try:
        cfg = json.load(open(cfgp))
    except Exception:
        cfg = {}
cfg["cadre_repo"] = root
if not cfg.get("packs_repo"):
    cand = os.path.join(os.path.dirname(root), "packs")
    if os.path.isdir(cand):
        cfg["packs_repo"] = cand
json.dump(cfg, open(cfgp, "w"), indent=2)
print("  wrote cadre.json + install manifest")
PY

# Put the CLI on the PATH: first writable, already-on-PATH location wins.
linked=""
for bindir in "$HOME/.local/bin" /usr/local/bin; do
  case ":$PATH:" in *":$bindir:"*) ;; *) continue ;; esac
  [ -d "$bindir" ] && [ -w "$bindir" ] || continue
  ln -sf "$ROOT/bin/cadre" "$bindir/cadre" && linked="$bindir/cadre" && break
done
if [ -n "$linked" ]; then
  echo "  linked: $linked"
else
  mkdir -p "$HOME/.claude/bin" && ln -sf "$ROOT/bin/cadre" "$HOME/.claude/bin/cadre"
  echo "  linked: ~/.claude/bin/cadre  (add ~/.claude/bin to your PATH)"
fi

echo ""
echo "Done. Open any project — Cadre loads at session start."
echo "New project?  say:  spinup"
echo "Manage profiles?  ask the 'profile' skill (switch / export / import)."
