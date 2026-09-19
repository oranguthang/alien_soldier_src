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
