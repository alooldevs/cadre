#!/usr/bin/env bash
# UserPromptSubmit — compiled from operating-rules A2.
# Examples in the prompt are members, not the class. Inject the artifact so the
# model cannot hang on the named instance (the invoice, "defects") as the spec.
exec python3 -c "
import json, sys, re

try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
prompt = d.get('user_prompt') or d.get('prompt') or ''
if not re.search(r'(?i)\\b(e\\.g\\.?|for example|such as|example\\s+\\d|example[:\\s])', prompt):
    sys.exit(0)
print(
    'cadre A2: this prompt uses examples. They are members, not the class and not the spec. '
    'Before acting, the class is ___; members not listed include ___, ___. Work the class. '
    'One-reply finish is fine when that class is in view; a finish that only treats the named '
    'example is underweighted. If no done-condition can be written, this is not a job — do not '
    'update STATE, do not enqueue.'
)
"
