# Tooling status

The release interface is the list in `config/release_0_5.json`. Those commands
are module-aware and are covered by the release gate.

Several older exploratory commands predate the split from
`alien_soldier_j.s` to the address-ordered `src/main.s` translation unit:
`analyze`, `debug-pointers`, `find-unanalyzed`, `prepare-batch`, and `rename`.
They are retained as research material but are outside the release 0.5
contract until their source mutation logic can address individual modules.
They must not be used as evidence for preservation or semantic correctness.

Read-only trace parsing and report generation do not mutate source and remain
useful, but their output is evidence only when its ROM, movie, emulator commit,
frame range, and interpretation are recorded.
