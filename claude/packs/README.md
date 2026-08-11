# Packs — domain cartridges for the runtime

Cadre is domain-agnostic by rule: the machine stays free of the material. A **pack** is where
material lives — a domain's knowledge with teeth (contracts, probes, gates, generators) that plugs
into the runtime without touching the core.

## Anatomy

A pack is a directory at `~/.claude/packs/<name>/` containing at minimum:

```
detect.sh      executable; the pack's only required interface
...            anything else the pack ships: contracts, scripts, reference material
```

## The detect.sh contract

Session-wiring runs every `~/.claude/packs/*/detect.sh` at session start, from the session's
working directory. The contract:

- **Fast.** Milliseconds. It runs on every session start, in every project.
- **Silent when not applicable.** Exit 0 with no output if this project isn't the pack's domain.
  No "pack X: not relevant" noise — silence is the default, exactly like rings that don't apply.
- **Orienting when applicable.** Print what a session should know before its first move: run the
  probe, point at the contracts, name the gate. Output is injected into the session's context.

## Rules

- A pack never edits the core. If a pack needs a new event, the core grows the generic mechanism
  and the pack uses it.
- Packs are material: project- or domain-specific facts belong here, never in cadre's own files.
- The cadre repo ships the mechanism and this note — packs themselves live and version wherever
  their material lives, and install by being copied into `~/.claude/packs/`.
