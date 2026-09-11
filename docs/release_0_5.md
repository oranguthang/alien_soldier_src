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
- `src/main.s` is an address-ordered index over 348 modules with a checked
  1,000-line ceiling; the current mean is 341.7 lines and no waiver is active.
- `config/rom_layout.json` is checked against listing addresses, landmarks,
  padding ranges, and the built image.
- Naming/evidence rules, 12,292 provenance mappings, and the remaining 3,749
  address-derived definitions are policy checked.
- Source/subsystem and RAM orientation maps exist without overstating the
  automatically generated semantic names.
- Initial source/project lint and unit tests are wired as `make lint` and
  `make test`.
- Six pinned runtime scenarios check 13 named RAM expectations across boot,
  title, gameplay, boss entry, stage change, and credits.
- The listing exports 16,056 canonical ROM/RAM/hardware addresses; layout
  landmarks and runtime symbols are checked by `make verify-symbols`.
- `make clean` is restricted to reproducible build/runtime outputs and Python
  caches; extracted assets, traces, workflow files, and source backups survive.
- The machine-readable release contract and static audit are wired through
  `config/release_0_5.json` and `make release-audit`.
- Mechanical assembly style is linted: column-zero definitions, entrypoint-only
  includes, lowercase paths, final newlines, and a 200-character line ceiling.
- Negative-path tests reject missing, altered, or stale assets; changed
  toolchain files; non-canonical ROM input; byte divergence; weakened release
  scope; and incorrect runtime state.

## Reconstruction backlog after 0.5

The contract does not require invented semantics. Most of the RAM inventory and
3,749 address-derived definitions intentionally remain in the unknowns backlog.
Promote or correct them only with recorded static/runtime evidence.
The older source-mutating analysis workflows are also outside the release
interface until made module-aware; see `docs/tooling_status.md`.

Before publishing or tagging a release, execute and retain the result of the
full `make release-check` gate on a supported host.

Semantic labels from the earlier automated naming pass are explicitly not
grandfathered as facts. They may be renamed as evidence improves, while their
former IDA labels remain available through provenance annotations.
