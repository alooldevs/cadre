#!/usr/bin/env bash
# UserPromptSubmit — the narrowing fix, supply side. Every 10th turn, re-inject
# the head of the anchor into context so the whole field cannot evaporate from
# the window. The model can't feel a long session; this script counts it.
exec python3 -c "
import json, sys, os, re

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)

tmp = os.environ.get('TMPDIR', '/tmp')
sid = str(d.get('session_id', 'x'))
cf = os.path.join(tmp, 'cadre-turns-' + sid)
n = 0
try:
    n = int(open(cf).read().strip())
except Exception:
    pass
n += 1
open(cf, 'w').write(str(n))
if n % 10:
    sys.exit(0)

root = d.get('cwd') or '.'
while root not in ('/', '') and not os.path.isdir(os.path.join(root, '.git')):
    root = os.path.dirname(root)
entry = os.path.join(root, 'CLAUDE.md')
if not os.path.isfile(entry):
    sys.exit(0)
m = re.search(r'[Aa]nchor:\s*(\S+)', open(entry).read())
if not m:
    sys.exit(0)
anchor = m.group(1)
if not os.path.isabs(anchor):
    anchor = os.path.join(root, anchor)
if not os.path.isfile(anchor):
    sys.exit(0)
head = ''.join(open(anchor).readlines()[:40])
print('cadre field refresh (turn %d): the anchor, so the whole field stays in view.\n'
      'Before the next unit of work, name what it serves.\n---\n%s' % (n, head))
"
