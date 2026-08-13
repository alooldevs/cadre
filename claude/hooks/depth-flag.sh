#!/usr/bin/env bash
# UserPromptSubmit — flags for the D14 reply-length guard.
# depth: human asked for a long reply this turn (one-shot).
# talk:  discuss / btw / warmup — conversation, not a job; persists until a work prompt.
exec python3 -c "
import json, sys, os, re

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
prompt = (d.get('user_prompt') or d.get('prompt') or '').lower()
tmp = os.environ.get('TMPDIR', '/tmp')
sid = str(d.get('session_id', 'x'))
talk = os.path.join(tmp, 'cadre-talk-' + sid)
depth = os.path.join(tmp, 'cadre-depth-' + sid)

if re.search(r'\\b(discuss|brainstorm|btw|aside|warmup|side\\s*quest)\\b', prompt):
    open(talk, 'w').close()
if os.path.exists(talk) and re.search(
    r'\\b(go ahead|confirmed|implement|spinup|groundwork|back to work)\\b', prompt
):
    os.remove(talk)

if re.search(r'\\b(detail|details|explain|elaborate|long|deep|deeper|expand|full|verbose|walk me)\\b', prompt):
    open(depth, 'w').close()
"
