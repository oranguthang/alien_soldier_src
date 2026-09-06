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
- Naming/evidence rules, all 4,822 provenance mappings, and the initial unknown
  backlog are policy checked.
- Source/subsystem and RAM orientation maps exist without overstating the
  automatically generated semantic names.
- Initial source/project lint and unit tests are wired as `make lint` and
  `make test`.
- Six pinned runtime scenarios check 13 named RAM expectations across boot,
  title, gameplay, boss entry, stage change, and credits.
- The listing exports 16,044 canonical ROM/RAM/hardware addresses; layout
  landmarks and runtime symbols are checked by `make verify-symbols`.

## Remaining release gates

- Deeper assembly style rules and semantic review of the RAM inventory.
- Broader negative-path tests for build and verification tooling.
- A single `make release-check` gate: asset policy, lint, tests, clean byte
  identity, runtime checks, and release audit.

Semantic labels from the earlier automated naming pass are explicitly not
grandfathered as facts. They may be renamed as evidence improves, while their
former IDA labels remain available through provenance annotations.
