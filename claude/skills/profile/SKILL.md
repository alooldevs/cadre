---
name: profile
description: Manage which learning profile is active and move profiles between machines. Use to switch the active profile (to your own, or back to the seed), export your profile to a portable/shareable file, or import one. Keywords - switch profile, use my profile, switch to seed, export profile, import my profile, default vs my profile.
---

# profile — switch / export / import the active learning profile

Profiles are switchable cartridges in `~/.claude/memory/profiles/`. The active one is named in
`~/.claude/memory/active-profile`. The session-start ritual loads whatever it points to.

## Switch
1. List available: `~/.claude/memory/profiles/*.md`.
2. Write the chosen path (e.g. `profiles/alex.md`) into `~/.claude/memory/active-profile`.
- Fresh install starts on `profiles/_seed.md`. As you work, grow the user's own profile in
  `profiles/<name>.md`; once it has enough signal, **offer** to switch to it — never switch silently.

## Export
- The active profile file **is** the portable cartridge. Copy it out (to a repo, a gist, anywhere) to move it
  to another machine or share it.

## Import
- Drop a profile file into `~/.claude/memory/profiles/` and point `active-profile` at it.

## Rules
- A profile holds **how a person works** — never client data or project specifics (those are project-level),
  and never tools/host (detected per-machine).
