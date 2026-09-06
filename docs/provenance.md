# Source provenance

The canonical input identity is recorded in `assets/manifest.json`; tool binary
identity and origin are recorded in `config/toolchain.json`.

The assembly initially carried 4,822 unique mappings from the current symbol to the
original IDA-generated name. They use `; was: sub_...`, `loc_...`,
`locret_...`, or `nullsub_...`. In 298 cases the historical annotation is on
the first instruction after the owning label, which is how the earlier rename
tool wrote it. `scripts/lint_source.py` deliberately associates such a marker
with the most recent definition and checks that both sides remain unique.
Reviewed RAM renames add mappings such as `; was: word_FFA284`, so the checked
total is allowed to grow but never to fall below the original 4,822.

These mappings establish symbol continuity, not semantic correctness. Their
default evidence level is `hypothesis`. Correcting a semantic name must retain
the same historical mapping unless a documented source correction proves that
the mapping itself was wrong.
