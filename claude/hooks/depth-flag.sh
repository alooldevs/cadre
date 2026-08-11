#!/usr/bin/env bash
# UserPromptSubmit — support for the D14 reply-length guard.
# If the human asks for depth, set a flag so the guard stands down for one reply.
exec python3 -c "
import json, sys, os, re

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
prompt = (d.get('user_prompt') or d.get('prompt') or '').lower()
if re.search(r'\b(detail|details|explain|elaborate|long|deep|deeper|expand|full|verbose|walk me)\b', prompt):
    tmp = os.environ.get('TMPDIR', '/tmp')
    open(os.path.join(tmp, 'cadre-depth-' + str(d.get('session_id', 'x'))), 'w').close()
"
