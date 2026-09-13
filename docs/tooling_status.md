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

The name-audit test discovers definitions across every `.s` and `.inc` module
in one pass and compares the resulting symbol set with the audit registry. This
preserves the exact missing-name check while avoiding one whole-source regular
expression scan per audit record; at 9,818 records the local test time fell from
about 271 seconds to less than one second.

`make semantic-audit` is the module-aware, read-only queue for the remaining
Sonnet-name review. It joins provenance-owning current definitions against the
exact current names in `config/name_audit.json`, reports the backlog by source
module, and separates binary-backed `_End` aliases from ordinary end labels
that still need semantic review. It never rewrites source and does not require
a listing, ROM build, trace, or emulator.

`make trace` passes an inert screenshot interval to the pinned emulator. This
is required because that emulator currently evaluates its maximum-frame and
movie-finished termination checks only while screenshot automation is enabled.
The workaround produces no periodic captures, bounds the TAS trace at its
pinned 90,000-frame limit, and lets the longplay/menu traces stop at movie end
when a requested breakpoint is never reached. Rendering uses frameskip 8 to
keep a negative breakpoint search practical; emulated frame numbers and CPU
execution remain unchanged.
