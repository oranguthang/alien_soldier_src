# Unknowns register

The machine-readable thresholds live in `config/source_policy.json`.

At the start of release 0.5 work the source contained 10,497 defined symbols
with neutral address-derived names: 9,493 ROM labels and 1,004 RAM equates.
This is a burn-down ceiling: new such names fail lint, while evidence-backed
work should reduce the count. The preservation contract does not require zero,
but Source Reconstruction 1.0 does. An unresolved release-quality name must be
role-neutral, independent of its address, and registered here with its evidence
level.

The first evidence-backed RAM pass reduced the live count to 10,493 by naming
`GameModeIndex`, `GameSubstateIndex`, `StageTableIndex`, and
`Entity_ObjectPool`. Their old address names remain in provenance markers.

The first Sonnet-label audit reduced it again to 10,491 by naming the two
graphics-effect handler tables at `0x0040AC` and `0x00432E`. The corrected
dispatcher claims and their static evidence are recorded in
`config/name_audit.json`.

The asset-bank reconstruction reduced it to 10,488. `SegaScreenPalette` is
confirmed by its 16-color payload and the frontend copy loop. Two address-based
placeholders became role-neutral unknowns pending stronger evidence.

Two especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `UnidentifiedSegaTilemap` | `0x0E8020` | hypothesis | 48 sequential tile words adjacent to the SEGA art; no live pointer has been found. |
| `UnidentifiedTilemapData` | `0x180000` | unknown | Tile-like words at the frontend asset boundary; no live pointer has been found. |

The 4,822 semantic names with `; was:` history are a second review queue. Their
default level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.
