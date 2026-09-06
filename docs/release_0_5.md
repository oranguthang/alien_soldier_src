# Release 0.5 work contract

Release 0.5 is the development name for the preservation-first Source
Reconstruction 1.0 effort. It is not a released 1.0 claim yet.

## Completed foundations

- The canonical profile is the Japanese ROM only; the European ROM is outside
  this profile.
- `make verify` compares directly with the user-supplied canonical dump.
- Original padding, checksum path, region path, and all previously differing
  bytes are restored.
- The ROM and all 579 extracted segments have pinned sizes, ranges, and hashes.
- Vendored assembler/converter files and the emulator commit are pinned.
- Ordinary cleanup preserves extracted private assets.
- `src/main.s` is an address-ordered index over 26 modules with a checked
  6000-line ceiling.
- `config/rom_layout.json` is checked against listing addresses, landmarks,
  padding ranges, and the built image.

## Remaining release gates

- Naming, style, provenance, and evidence-level contracts.
- Source map, subsystem map, reviewed RAM map, and unknowns register.
- Lint for assembly, configuration, Python, and documentation links.
- Tests for build and verification tooling.
- Named runtime scenarios for boot, title/menu, gameplay start, stage change,
  boss transition, and completion/credits, each with RAM/state assertions.
- A single `make release-check` gate: asset policy, lint, tests, clean byte
  identity, symbols/layout, runtime checks, and release audit.

Semantic labels from the earlier automated naming pass are explicitly not
grandfathered as facts. They may be renamed as evidence improves, while their
former IDA labels remain available through provenance annotations.
