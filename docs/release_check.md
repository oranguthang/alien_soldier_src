# Release check

`make release-check` is the single ordered release 0.5 gate. It runs:

1. private asset identity and range policy;
2. source/project lint;
3. Python verification tests;
4. cleanup of reproducible outputs;
5. a fresh byte-identical Japanese ROM build plus layout verification;
6. canonical symbol export and contract coverage;
7. all twelve emulator scenarios and 78 named RAM expectations;
8. the static release audit, which resolves every requirement in
   `config/source_reconstruction_1_0.json` to a file, target, scenario or
   artifact that exists, checks that every partial or planned requirement names
   the excluded scope that limits it, and searches the whole reachable git
   history for ROM-derived payloads.

The gate intentionally performs a clean build. `make clean` preserves the
user-supplied ROM, all 579 extracted segments, movies, traces, workflow files,
source backups, emulator configuration, and other maintainer evidence.

The declarative inputs are in `config/release_0_5.json` for the gate itself and
`config/source_reconstruction_1_0.json` for the release manifest. Release 0.5 remains a
development label aimed at Source Reconstruction 1.0; a passing gate does not
rename the release or silently add the European ROM profile.
