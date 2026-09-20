# Compressed payload boundaries

The preservation source includes the original bytes. Eight former payload files
contained two consecutive LZSS archives but exposed only the first archive's
name. The ranges below are now independent extracted assets and `binclude`
symbols. `tests/test_payload_archives.py` checks their headers, exact lengths,
decoded tile counts, and the pointers that use them.

| Second archive ROM address | First symbol | Second symbol | Decoded tiles |
| --- | --- | --- | ---: |
| `$104F32` | `Stage15TileArt` | `Stage15TileArt2` | 28 |
| `$105B9E` | `Stage22And24TileArt` | `Stage22And24TileArt2` | 123 |
| `$123172` | `Boss_BackStringerTileArt` | `Boss_BackStringerTileArt2` | 27 |
| `$1291DE` | `EntityType3F0TileArt` | `UnreferencedEntityType3F0TileArt2` | 303 |
| `$138EE4` | `Boss_WolfGaropaTileArt1` | `UnreferencedWolfGaropaTileArt2` | 75 |
| `$13D42A` | `Boss_ZLeoTileArt1` | `UnreferencedZLeoTileArt2` | 322 |
| `$188A16` | `StoryScreenMappingData6000` | `UnreferencedIntroSceneSpriteArt` | 194 |
| `$1BE2CA` | `SevenForcesVictoryCutsceneMappingData4020` | `UnreferencedSevenForcesCutsceneTileArt` | 44 |

The first six second archives are in `data/artcomp/`; the last two follow
mapping payloads in `data/mappings/`. Their tile counts come from decoding the
individual second archives, not from their filenames. `Unreferenced` means no
even-aligned absolute pointer to the archive start was found in the canonical
ROM; it does not prove runtime inaccessibility.

Three compact load commands formerly formed a second-archive address by
adding the first archive's length. They now name the archive directly:

| Command | Former expression | Direct symbol |
| --- | --- | --- |
| `Stage7TileAssetCommands` | `Stage15TileArt+$410` | `Stage15TileArt2` |
| `Stage16TileAssetCommands` | `Boss_VictorTileArt_End+$1840` | `Boss_BackStringerTileArt2` |
| `Stage18TileAssetCommands` | `Stage22And24TileArt+$A08` | `Stage22And24TileArt2` |

The original expression and direct symbol have exactly the same canonical
address. This fixes a source-level relocation hazard but does not establish
that it caused any observed rendering failure.

Two purported archive ends also had non-archive data after the compressed
stream. The archive at `$1BE2CA` ends at `$1BE722`; its 64-byte remainder is
`UnreferencedSevenForcesCutscenePostArtData`. The archive at `$19BF9E` ends at
`$19C492`; its 18-byte remainder is
`UnreferencedPostStageTileArtSpriteMapping`. The latter has three six-byte
sprite-command-shaped records, with the final record's high bit set. The
64-byte tail also begins with command-shaped records, but its full purpose and
visual owner remain unverified. Both retain role-neutral names pending a
reader trace. All 128 `artcomp` assets now end exactly at the first archive's
header-defined boundary. The extracted asset count is 589.

## Stage 4 rendering regression still open

Claude's parallel repacker worktree reported that a platform before Sniper
Honeyviper disappears after moving compressed payloads. A 16-byte shift of
all payloads failed before this split; an 8 KiB shift also failed; a repack
after the split did not. A 16-byte shift after the split was not retested, and
shift size was not isolated from growing the image beyond 2 MiB. Stage 4's
compact asset list selects indices 0 and 8 in `Stage_SharedTileSourceTable`;
neither directly names the three corrected interior pointers. The current
evidence therefore does not identify the defective pointer or the missing
platform's artwork. `docs/unknowns.md` tracks this as an open investigation.
