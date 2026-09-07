# Naming contract

Names describe behavior only as strongly as the available evidence permits.
The source currently contains thousands of names from an earlier automated
interpretation pass; those names are hypotheses until reviewed.

## Rules

- Prefer `Subsystem_ActionObject` for behavior with direct evidence, for
  example `Sound_LoadZ80Driver`.
- During migration, leave an existing address-derived name unchanged until its
  references have been reviewed. Release 1.0 contains no live address-derived
  identifiers: unresolved definitions receive stable role-neutral names and a
  corresponding unknowns-register entry. A wrong semantic name is worse than
  an explicit unknown.
- Use a broad role-neutral concept name for a module whose exact ownership is
  not yet established. ROM addresses and containers such as `bank` or
  `boss_code` are not module identities.
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

## Mechanical style

- Global labels and EQU definitions begin in column zero; instructions and
  directives remain indented.
- Only `src/main.s` owns include directives.
- Source paths are lowercase and source files end with a newline.
- Assembly lines are at most 200 characters. This accommodates imported XREF
  comments without allowing generated annotations to grow without bound.

The preservation subset of these rules is currently enforced by `make lint`.
The stricter destination and its migration order are declared in
`config/source_reconstruction_1_0.json` and `docs/modularization_plan.md`.
Passing mechanical style checks never establishes semantic confidence in a
label.
