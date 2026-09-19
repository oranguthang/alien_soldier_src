# Tooling progress

## 2026-09-19: procedure batch source lookup

`scripts/prepare_batch.py` now reads the ROM-ordered `.s` includes from
`src/main.s`, locates each requested procedure in its owning module, and prints
that module in the batch. A missing included module fails explicitly. The two
focused tests in `tests/test_prepare_batch.py` pass, a live lookup finds `Reset`
in `src/system/boot.s` among 379 modules, and `make lint` passes.

This was one piece of the legacy tooling migration, not a release claim. The
exploratory workflow remains outside the release interface described in
`docs/tooling_status.md`.

The module-aware `rename_symbols.py` now preserves every `; was:` suffix when
renaming live references. A focused test covers the case where a provenance
alias is itself another symbol being renamed; the alias remains historical
evidence rather than turning into the new name.

Batch extraction now scans the entire owning module for its matching imported
`End of function` marker, including routines longer than 500 lines. If that
marker is absent, it shows the module remainder and explicitly says the
procedure boundary is uncertain; it no longer invents a 100-line boundary.

`make rename` now calls `scripts/rename_batch.py`, which delegates all source
edits to the module-aware `rename_symbols.py` and marks the selected movie's
analysis report only after a successful rename. The legacy single-file
`rename_procedures.py` CLI refuses to run. This fixes source targeting and
provenance handling; the semantic basis and byte identity still require human
review and `make verify`.

`make set-movie`, `make show-movie`, and `make prepare-batch` now use a shared
Python movie selector instead of POSIX `if`, `cat`, or shell redirection. The
batch command selects its report from the validated movie marker and extracts
source from the 379 ordered modules. Focused tests exercise the CLI arguments
and report selection without launching the emulator.

The extra tracked Python, test, and documentation files changed the release
manifest's tracked-text counter. It was recounted from the current tree so
`make release-audit` remains a useful drift detector after this migration.

`make find-unanalyzed` now selects delimited code routines whose current-name
evidence is `hypothesis` in `config/name_audit.json`, in ROM order. The current
tree yields seven code candidates. The former transfer-tuple hypothesis is
now an explicit `unknown`, not a code perturbation candidate. Old unpinned
`analysis_results.csv`
cannot silently remove candidates. `analyze_procedures.py` resolves each name
to its owning module, changes only a unique temporary worker copy, records
module and ROM order in its output, and defaults to one worker. The old
monolithic finder CLI refuses to run. These are static and isolated-test
results only: no emulator batch was run, so the findings are not release
runtime evidence.

The old `debug-pointers` and `report-pointers` CLIs are now retired. Their
address-derived data-label search cannot select the current semantic source,
and their cleanup could delete prior diff directories. They fail before any
worker, emulator, or filesystem cleanup starts, directing maintainers to
`make verify-relocation`, the module-aware pointer gate already used by
`make release-check`. Existing diff data was not removed.

The direct `find_unreferenced_labels.py` command now scans all ROM-ordered
modules and included equates as one source graph, excluding comments and
quoted payload paths. On this tree it finds 399 labels without symbolic
references, including externally consumed cartridge-header fields; this is a
review queue, not a dead-code count. The old single-file data splitter now
refuses to run, because it would bypass canonical asset extraction and the
manifest. `prepare_batch.py` also defaults to `src/main.s` for direct use.

The imported cross-reference comments had 40 surviving address-derived symbol
names in 28 modules, not the older documented count of 207. Thirty-three map
uniquely through `; was:` provenance; the remaining seven table references
were resolved against the existing assembler listing at their ROM addresses.
Only comment text changed, and the provenance markers remain intact. Source
lint now rejects a retired name in a `CODE XREF`, `DATA XREF`, or continuation
`ROM:` comment, so this cleanup remains checkable.

The broad `docs/source_map.md` table had 23 stale file counts and two boundaries
that cut across a source module after the source was split into smaller
ROM-ordered modules. Its 57 ranges now count all 380 modules from
`config/rom_layout.json`. Project lint checks range continuity,
exactly one broad-range owner per module, and the count in each row; future
semantic splits cannot silently leave the orientation map stale.

The former long `stages/stage_and_boss_transition_states.s` was divided at
the Missiray entry-state boundary `$00F7FA`. Its dispatch, table, asteroid,
Destroyer Proto, Shield Viper, and Wolf Garopa block remains 583 lines;
the Missiray/Stage 24/Z-Leo block is 278 lines in
`stages/missiray_stage24_z_leo_transitions.s`. The source is now 381 modules:
208 in the 200-700 line preference, 145 shorter, 28 longer, none over 1000.
