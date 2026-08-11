#!/usr/bin/env bash
# Stop — compiled from operating-rules B9. A session under full authority to
# delete still produces zero deletions; only counting the diff catches it.
# Fires once per session, only when the uncommitted diff is large and one-way.
exec python3 -c "
import json, sys, os, re, subprocess

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
if d.get('stop_hook_active'):
    sys.exit(0)

tmp = os.environ.get('TMPDIR', '/tmp')
sid = str(d.get('session_id', 'x'))
once = os.path.join(tmp, 'cadre-b9-' + sid)
if os.path.exists(once):
    sys.exit(0)

cwd = d.get('cwd') or '.'
try:
    out = subprocess.run(['git', '-C', cwd, 'diff', '--shortstat', 'HEAD'],
                         capture_output=True, text=True, timeout=10).stdout
except Exception:
    sys.exit(0)
ins = re.search(r'(\d+) insertion', out)
dels = re.search(r'(\d+) deletion', out)
ins = int(ins.group(1)) if ins else 0
dels = int(dels.group(1)) if dels else 0
if ins < 100 or dels > 0:
    sys.exit(0)

open(once, 'w').close()
print(json.dumps({
    'decision': 'block',
    'reason': ('B9: the uncommitted diff adds %d lines and deletes 0. '
               'Paste into the reply: \"Adds %d, deletes 0. Merge/delete candidate: ___ — '
               'not taken because ___.\" This surfaces the option; it does not mandate deletion.'
               % (ins, ins)),
}))
"
