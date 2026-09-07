# Source Reconstruction 1.0 modularization plan

This document is the working plan for turning the preservation-complete 0.5
source into a semantic Source Reconstruction 1.0 source tree. The machine-
readable destination contract is `config/source_reconstruction_1_0.json`.

The benchmark is the released `flicky_src` tree: an address-ordered include
index, cohesive subsystem modules, evidence-backed names, a real formatter,
strict lint, and byte identity. A smaller module count is not a goal. A reader
must be able to find code by game concept without first knowing its ROM address.

## Measured starting point

`make source-inventory` reads the layout, source, provenance markers, and AS
listing and writes `build/source_inventory.json`. The initial branch inventory
is:

| Metric | Starting value | 1.0 destination |
|---|---:|---:|
| Byte-emitting modules | 26 | Determined by semantic boundaries |
| Source lines | 119,569 | Informational only |
| Mean module length | 4,598.8 | Normally 200-700 |
| Modules over 1,000 lines | 25 | 0, except reviewed concrete-boss waivers |
| Generic/address-bucket filenames | 25 | 0 |
| Address-derived ROM definitions | 9,493 | 0 |
| Imported procedure mappings | 4,325 | Fully reviewed with provenance retained |

The 200-700 range is a design target, not a slicing interval. The default hard
ceiling is 1,000 lines. A longer file is acceptable only when it describes one
specific boss whose procedure family and private tables would become harder to
understand if separated. Every such exception must be named in the contract;
there are no pre-approved exceptions.

## Boundary rules

1. Find entry points, dispatch tables, callers, callees, state variables, and
   private data before choosing a filename.
2. Keep a state machine with its private helpers and tables when ROM order
   permits it. Split shared engines from object-specific behavior.
3. Never split in the middle of a procedure. Never use every-N-lines cuts.
4. Keep `src/main.s` in ROM order. A logical subsystem may therefore own
   several files separated by other ROM-resident code.
5. Use a neutral concept name while ownership is uncertain. Do not put an
   address, `bank`, `boss_code`, or an unverified boss identity in a filename.
6. Treat every pre-existing semantic label as a hypothesis. Rename it when
   instructions, data flow, call sites, or runtime evidence contradict it.
7. Separate byte-preserving file moves from semantic renames in reviewable
   commits. Run `make verify` and `make verify-layout` after every move wave.

## Work sequence

### 1. Establish enforcement tooling

- Maintain an exact source inventory from the assembler listing.
- Add a full-source formatter with a check mode.
- Make layout and lint understand nested semantic modules.
- Add path, size, vocabulary, provenance, and address-derived-name gates.
- Keep the current 0.5 release gate green while the stricter 1.0 thresholds
  burn down; only switch the release contract when every threshold is met.

### 2. Rebuild the system and opening region

The current boundary at `0x0033FA` bisects `Input_ReadController`. It must be
removed. The following anchors are the first-wave map, not automatic cut
points. Each boundary is accepted only after its cross-references and private
data are checked.

| ROM start | Anchor | Candidate ownership |
|---:|---|---|
| `0x000000` | `dword_0` | exception vectors and cartridge header |
| `0x000200` | `Reset` | boot and hardware initialization |
| `0x0004BA` | `Sys_CheckRegionLock` | canonical region check |
| `0x0005DC` | `off_5DC` | top-level object handler table |
| `0x000A7A` | `VBLANK` | vertical-blank dispatcher |
| `0x000D12` | `Gfx_VBlankDMATransfer` | VBlank DMA processing |
| `0x000EF4` | `Effect_UpdatePaletteFade` | palette fade engine |
| `0x001356` | `VBlank_EffectDispatcher` | VBlank effects |
| `0x0015BC` | `Effect_InitTransitionFade` | transition effects |
| `0x00195C` | `VBlank_Epsilon1ScrollEffect` | HBlank/scroll effects |
| `0x001D32` | `Gfx_QueueDMAClear` | DMA command queue |
| `0x002016` | `Sys_ProcessObjectList` | object update engine |
| `0x0021F0` | `Sys_InitObjectPointers` | object/sprite initialization |
| `0x00263E` | `LoadObjData` | object data loading |
| `0x002A58` | `Sys_ClearDMABuffer` | tile and DMA preparation |
| `0x002D40` | `Sys_InitFullGame` | game initialization |
| `0x002E7E` | `Input_InitControllers` | memory and controller initialization |
| `0x003134` | `Sys_ClearVDPCommandBuffer` | VDP clearing and command buffers |
| `0x00339A` | `Data_Copy16Bytes` | ownership unresolved; audit before move |
| `0x0033A4` | `Input_InitControllerState` | controller input family |
| `0x00354A` | `Math_CalculateAngleToPlayer` | angle/vector math |
| `0x003954` | `UI_AddScoreBCD` | BCD score arithmetic |
| `0x0039AA` | `Gfx_FadePaletteTransition` | palette transitions |
| `0x004094` | `Gfx_PrimaryEffectDispatcher` | primary graphics-effect dispatch |
| `0x004386` | `Results_UpdateNumbers` | results-number rendering |
| `0x004594` | `Gfx_BuildVDPCommandList` | text/VDP command construction |
| `0x004840` | `Gfx_ClearPlanesAndInit` | story-screen initialization |
| `0x005150` | `Cutscene_PlanetDispatcher` | planet sequence |
| `0x00588C` | `UI_StoryTextDispatcher` | story text |
| `0x007644` | `Cutscene_UpdateStarPositions` | planet/star rendering |
| `0x007B30` | `Cutscene_InitCreditsScreen` | credits screen |
| `0x007D68` | `Effect_InitializeStarfield` | starfield/planet effects |
| `0x008618` | `Math_LookupSineTable` | sine lookup helpers and table |
| `0x0086F0` | `Cutscene_ShipObjectDispatcher` | ship object family; continues past old file boundary |

The former `Player_StateDispatcher` was contradicted by its dispatch variable
and targets, which update palettes, scroll, and tiles. The complete static
caller/target audit is recorded in `config/name_audit.json`; this became the
first corrected Sonnet-label item.

### 3. Reconstruct shared gameplay engines

Extract stage loading, scrolling, collision, player state, weapons,
projectiles, UI, and common actor engines before boss-specific modules. Shared
helpers stay outside boss directories even when the first known caller is a
boss.

### 4. Reconstruct bosses by identity and state machine

Identify each boss from spawn tables, graphics/data references, stage context,
and runtime traces. Use concrete boss directories or filenames only after that
identity is supported. Keep common boss lifecycle and collision code separate.
This phase eliminates every `boss_code_*.s` container.

### 5. Reconstruct sound and data ownership

Separate the Z80 driver, command interface, music/SFX metadata, and sample
tables. Move anonymous data banks into the module that consumes them where ROM
order and assembler constraints allow; otherwise give the data a format/role
name supported by references.

### 6. Audit all names and release gates

Burn down both queues: address-derived identifiers and earlier generated
semantic names. Record uncertain cases with evidence levels. The release is
ready only when all six user-facing commands pass independently:

```text
make split
make build
make verify
make test
make format
make lint
```

`make format` must be idempotent, and `make lint` must include formatter check,
source/layout policy, Python/config checks, and documentation-link validation.
