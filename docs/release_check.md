# Release check

`make release-check` is the single ordered release 0.5 gate. It runs:

1. private asset identity and range policy;
2. source and project lint: style, naming vocabulary, provenance, branch-target
   resolution and text hygiene across every tracked text file;
3. Python verification tests;
4. cleanup of reproducible outputs;
5. a fresh byte-identical Japanese ROM build plus layout verification;
6. canonical symbol export and contract coverage;
7. all twelve emulator scenarios and 78 named RAM expectations;
8. the static release audit, which resolves every requirement in
   `config/source_reconstruction_1_0.json` to a file, target, scenario or
   artifact that exists, checks that every partial or planned requirement names
   the excluded scope that limits it, recounts every figure the documentation
   quotes from the artefact that owns it, and searches the whole reachable git
   history for ROM-derived payloads.

The gate intentionally performs a clean build. `make clean` preserves the
user-supplied ROM, all 579 extracted segments, movies, traces, workflow files,
source backups, emulator configuration, and other maintainer evidence.

The declarative inputs are in `config/release_0_5.json` for the gate itself and
`config/source_reconstruction_1_0.json` for the release manifest. Release 0.5 remains a
development label aimed at Source Reconstruction 1.0; a passing gate does not
rename the release or silently add the European ROM profile.

## Counters are recounted, not trusted

The manifest carries a `counters` block of eleven figures: the module count, the
asset count, the number of definitions, provenance mappings, resolved branch
targets, exact-address records, work RAM fields, declared subsystems, tracked
text files, runtime scenarios and runtime expectations. The audit recounts each
one from the artefact that owns it — the layout, the asset manifest, a source
scan, the name registry, `src/ram_addrs.inc`, the source policy, the tracked
file list and the scenario config — and fails on any drift.

Prose counters go stale silently: a module split or a rename moves the real
number and nothing complains. Four figures quoted in the documentation had
drifted by the time the release gate first ran in full. Declaring them in one
place and recounting them there is what stops a stale figure from surviving into
a tag.
