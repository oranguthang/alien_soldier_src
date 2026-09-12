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
total is allowed to grow but never to fall below the original 4,822. Reviewed
preserved-data definitions retain their exact imported spelling too; for
example, `Sound_UnreferencedSFXChannelPointers` records `; was: unused_10`
after its six pointer values were identified.

These mappings establish symbol continuity, not semantic correctness. Their
default evidence level is `hypothesis`. Correcting a semantic name must retain
the same historical mapping unless a documented source correction proves that
the mapping itself was wrong.

The current reconstruction carries 14,049 checked mappings. The total grows
when a live address-derived ROM or RAM definition receives an evidence-backed
name; corrections to an already renamed symbol retain its existing imported
IDA mapping and therefore do not inflate this count.

A few definitions in the imported disassembly were already named by an
extraction role rather than by address. The provenance grammar admits only
the exact historical `JumpTable1`, `JumpTable2`, and `PCMPart1` through
`PCMPart9` forms, plus the imported semantic `LoadPalette` and
`CheckFlagsLoadObjData` labels, in addition to the generated suffix pattern.
These spellings are continuity evidence, not reconstructed semantics; their
replacement names still require records in `config/name_audit.json`, and the
exceptions do not broaden the accepted address-derived source vocabulary.
