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
- `src/main.s` is an address-ordered index over 379 modules with a checked
  1,000-line ceiling; the current mean is 313.4 lines, the largest module is
  986 lines, and no waiver is active.
  Layout, release, and 1.0 contracts share that exact ceiling, and the release
  audit rejects a weaker value or a generic declared module filename.
- `config/rom_layout.json` is checked against listing addresses, landmarks,
  padding ranges, and the built image.
- Naming/evidence rules, 16,051 provenance mappings, and a zero-live-
  address-derived-definition policy are checked.
- Source/subsystem and RAM orientation maps exist without overstating the
  automatically generated semantic names.
- Initial source/project lint and unit tests are wired as `make lint` and
  `make test`.
- Six pinned runtime scenarios check 13 named RAM expectations across boot,
  title, gameplay, boss entry, stage change, and credits.
- The listing exports 16,064 canonical ROM/RAM/hardware addresses; layout
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

The contract does not require invented semantics. No live address-derived
definitions remain in executable, preserved-ROM, or RAM source. The exact-
address audit registry contains 15,831 records. A further 513 provenance-mapped
current names do not yet appear as current-name or alias records; this is an
upper-bound semantic review queue because aliases that share an address must
be folded into one record. `make semantic-audit` identifies 513 binary-backed
`_End` aliases that immediately follow their `binclude` payload and therefore
do not represent separate semantic review work. The resulting actionable
upper bound is 0 names: the queue is closed, and the classifier reports no
other pending `_End` labels and no modules remaining. Promote or correct names only with recorded static or runtime
evidence.
The older source-mutating analysis workflows are also outside the release
interface until made module-aware; see `docs/tooling_status.md`.

Before publishing or tagging a release, execute and retain the result of the
full `make release-check` gate on a supported host.

Semantic labels from the earlier automated naming pass are explicitly not
grandfathered as facts. They may be renamed as evidence improves, while their
former IDA labels remain available through provenance annotations.
