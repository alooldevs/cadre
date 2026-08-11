#!/usr/bin/env bash
# Stop — compiled from operating-rules D14: a reply past 15 non-empty lines,
# with no request for depth, gets sent back to be cut. Fires at most once per
# session so it corrects the habit without becoming a nag.
exec python3 -c "
import json, sys, os

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
if d.get('stop_hook_active'):
    sys.exit(0)

tmp = os.environ.get('TMPDIR', '/tmp')
sid = str(d.get('session_id', 'x'))

# The human asked for depth this turn — stand down and consume the flag.
depth_flag = os.path.join(tmp, 'cadre-depth-' + sid)
if os.path.exists(depth_flag):
    os.remove(depth_flag)
    sys.exit(0)

msg = d.get('last_assistant_message') or ''
lines = [l for l in msg.splitlines() if l.strip()]
if len(lines) <= 15:
    sys.exit(0)

once = os.path.join(tmp, 'cadre-d14-' + sid)
if os.path.exists(once):
    sys.exit(0)
open(once, 'w').close()

print(json.dumps({
    'decision': 'block',
    'reason': ('D14: that reply is %d non-empty lines and no depth was requested. '
               'Resend it short: the outcome first, then only what changes the human'\"'\"'s next move, '
               'under 15 lines, ending with one line offering the detail.') % len(lines),
}))
"
