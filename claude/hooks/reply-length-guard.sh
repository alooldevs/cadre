#!/usr/bin/env bash
# Stop — compiled from operating-rules D14.
# Long + work this turn  → bounce: trace to STATE, chat gets what is on the human.
# Long + no work         → bounce: cut, do not touch the adapter (talk is not a job).
# Talk/depth flag        → stand down (conversation or requested depth).
# Fires at most once per session.
exec python3 -c "
import json, sys, os, subprocess

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
if d.get('stop_hook_active'):
    sys.exit(0)

tmp = os.environ.get('TMPDIR', '/tmp')
sid = str(d.get('session_id', 'x'))

talk_flag = os.path.join(tmp, 'cadre-talk-' + sid)
if os.path.exists(talk_flag):
    sys.exit(0)

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

cwd = d.get('cwd') or '.'
dirty = False
try:
    inside = subprocess.run(
        ['git', '-C', cwd, 'rev-parse', '--is-inside-work-tree'],
        capture_output=True, text=True, timeout=10)
    if inside.returncode == 0 and inside.stdout.strip() == 'true':
        r = subprocess.run(['git', '-C', cwd, 'diff', '--quiet', 'HEAD'],
                           capture_output=True, timeout=10)
        dirty = r.returncode != 0
except Exception:
    dirty = False

n = len(lines)
if dirty:
    reason = (
        'D14: that reply is %d non-empty lines and work happened this turn. '
        'The overflow is the trace addressed to the wrong reader. Write what changed, '
        'where, why, file:line into STATE / worklog (Definition of Done — already owed). '
        'Then resend to the human only: the outcome, the cause in one line, and what is '
        'on them. End with: Detail: <adapter file>. Do not dump the chat into STATE as a '
        'second copy of a long reply — the adapter mirrors the work, not the overflow.'
    ) % n
else:
    reason = (
        'D14: that reply is %d non-empty lines and no work landed on disk this turn. '
        'This was conversation, not a done-report. Resend weighted-short: the thing they '
        'were pointing at (the class, not the example), nothing else. Do not update STATE, '
        'the sky, or any register — a long chat is not a reason to write the adapter.'
    ) % n

print(json.dumps({'decision': 'block', 'reason': reason}))
"
