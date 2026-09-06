# Naming contract

Names describe behavior only as strongly as the available evidence permits.
The source currently contains thousands of names from an earlier automated
interpretation pass; those names are hypotheses until reviewed.

## Rules

- Prefer `Subsystem_ActionObject` for behavior with direct evidence, for
  example `Sound_LoadZ80Driver`.
- Keep a neutral address-derived name when the role is unknown. A wrong
  semantic name is worse than an explicit unknown.
- Use a broad subsystem plus ROM address for a mixed module whose exact role is
  not yet established.
- Preserve the original IDA symbol through its `; was:` provenance mapping
  when renaming a definition.
- Rename all references atomically and require `make verify` afterward.
- Do not infer behavior solely from a caller name that is itself provisional.

## Evidence levels

- `unknown`: no supported semantic claim.
- `hypothesis`: plausible static interpretation; not independently verified.
- `static`: supported by instructions, data flow, and call sites.
- `runtime`: observed through a named emulator scenario or trace.
- `confirmed`: supported by independent static and runtime evidence, or by an
  authoritative hardware/data-format specification plus matching behavior.

Descriptions and maps must state the level when a reader could otherwise
mistake a hypothesis for a confirmed fact.
