#!/usr/bin/env bash
# Stop — compiled from operating-rules C2, D13 and D15.
# C2: agreement shipped alone ("you're right" with no "Changing now:") gets bounced.
# D13: method-narration at the human (rule IDs in prose, readback confirms,
# mode/serving declared in the reply) gets bounced.
# D15: pleasantry openers ("great question") and closers ("hope this helps").
# All string triggers.
exec python3 -c "
import json, sys, os, re

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
if d.get('stop_hook_active'):
    sys.exit(0)

msg = d.get('last_assistant_message') or ''
if not msg.strip():
    sys.exit(0)
low = msg.lower()
lines = [l for l in msg.splitlines() if l.strip()]
violations = []

# C2 — agreement as the opening move, no change attached anywhere in the reply.
opening = ' '.join(lines[:2]).lower()
agreement = re.search(r\"\b(you'?re right|you are right|good point|good catch|fair enough|fair point)\b\", opening)
if agreement and 'changing now' not in low:
    violations.append(
        'C2: the reply opens with agreement and attaches no change. '
        'Append: Changing now: <file/command/check> — or do not ship the agreement.')

# D13 — evidence about my adherence instead of about the subject.
d13_patterns = [
    r'\bper [a-e]\d{1,2}\b',
    r'\brule [a-e]\d{1,2}\b',
    r'readback confirms',
    r'compliance, not verification',
    r'against its own rows',
    r'^\s*mode:\s*(mapping|fixing|exploring)\b',
    r'^\s*serving:\s',
]
for p in d13_patterns:
    if re.search(p, low, re.MULTILINE):
        violations.append(
            'D13: the reply narrates method at the human (matched: ' + p + '). '
            'Cut it — the work carries the method or it did not happen. '
            'Keep only evidence about the subject: file:line, a re-runnable command, a count.')
        break

# D15 — pleasantry opener on the first line, or pleasantry closer on the last.
first = lines[0].lower() if lines else ''
last = lines[-1].lower() if lines else ''
opener = re.search(r'^(great question|good question|sure[!,]|certainly[!,]|absolutely[!,]|happy to help)', first)
closer = re.search(r'\b(hope this helps|hope that helps|let me know if|feel free to|happy to clarify|anything else\?)', last)
if opener or closer:
    matched = (opener or closer).group(0)
    violations.append(
        'D15: the reply carries a pleasantry (' + matched + '). Delete the sentence — '
        'the first line is the answer or the do-able action, and the reply ends when '
        'the answer is done.')

if violations:
    print(json.dumps({'decision': 'block', 'reason': ' '.join(violations)}))
"
