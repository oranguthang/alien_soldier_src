# Source Reconstruction 1.0

This document states what the 1.0 release claims and what it does not. The
machine-readable form is `config/source_reconstruction_1_0.json`, and
`make release-audit` resolves every claim below to a file, a target, a scenario
or an artifact that exists.

1.0 is a preservation release. It reproduces the original cartridge in a form
that can be read, navigated and checked. It does not claim to explain every
byte.

## What the release claims

- **Byte identity.** `make verify` assembles `src/main.s` with the vendored
  toolchain and compares the result with the user-supplied Japanese cartridge
  dump byte by byte, not by hash alone, reproducing SHA-1
  `8f6eb584ed9487b8504fbc21d86783f58e6c9cd6`.
- **Source, not blobs.** All executable 68000 code is assembly source across 398
  address-ordered modules indexed by `src/main.s`. Include order is ROM order;
  there is no linker, so `config/rom_layout.json` owns the memory map, the
  landmarks, the padding gap and every module range, and `make verify-layout`
  checks them against the assembler listing and the built image.
- **The source is self-contained.** Every `jsr`, `jmp`, `bsr`, `bra`, `dbf` and
  conditional branch written against a symbol resolves to a definition in the
  source; `make lint` resolves 16,102 of them and fails on the first it cannot.
- **No address is an identity.** No live definition is address-derived, which
  `make lint` enforces with a ceiling of zero.
- **Names are checkable, not merely documented.** Every definition is owned by
  one of 192 declared subsystems, derives from a symbol that exists, or is a
  declared hardware exception. The vocabulary is a closed list in
  `config/source_policy.json`; a new owner token fails lint.
- **Name evidence is traceable, with a declared review debt.**
  `config/name_audit.json` holds 15,833 exact-address records with imported
  and current names. The 60 Gusthead loop, return, dispatch, and table bases
  have been reviewed, as have 20 options-screen, 70 Jampan, 35 Sharpssteel, and
  43 Sirene, 45 Medusa, 84 Valkirie, 15 graphics/asset, and 14 Missiray records.
  A wider scan found 457 records matching additional generic evidence sentences;
  18 timer-return, 41 palette-fade, 66 OAM/mapping, 30 object-pipeline, 20
  stage-intro, 26 time-bonus, 26 message-render, 26 message-script, 20
  options-menu, 19 weapon-selection, 33 weapon-setup loadout, 31
  controller/background, 32 boss asset-set, 29 graphics-list, 35 asset-set
  palette-command, and 17 standalone or banked palette-command records were
  then reviewed. The curated `NAME-002` detector has zero matches, but a wider
  duplicate-basis review remains. Seven boss-identity records remain visual
  hypotheses (`NAME-003`); neither open issue is semantically resolved.
- **Provenance is retained.** 16,053 `; was:` markers map current definitions to
  the imported labels they replaced.
- **Cross-reference comments stay navigable.** Imported `CODE XREF`, `DATA XREF`
  and continuation `ROM:` comments contain no retired address-derived symbol
  names; `make lint` enforces this without touching the `; was:` markers.
- **No address is formed from a literal.** No work RAM address is reached
  through a raw `$FFFFxxxx` immediate. `make lint` rejects one in any
  address-forming instruction with a ceiling of zero, so `movea.l`, `cmpa.l`,
  `lea`, `pea`, `adda.l` and `suba.l` must name what they point at.
- **A memory map.** 1,293 work RAM fields, the hardware ports and the shared
  equates are named in include files and documented in `docs/ram_map.md`.
- **Behaviour observed, not assumed.** Twelve scenarios replay three pinned
  movies under the pinned emulator and check 78 named work RAM expectations,
  each resolved through `src/ram_addrs.inc`. Every observed mode value names a
  handler in `Sys_GameStateHandlers`, so a checkpoint states which routine owns
  the frame rather than merely recording a number.
- **One gate.** `make release-check` runs the whole thing in a fixed order on a
  clean tree.

## What the release does not claim

Each entry below is an `excluded_scope` record in the manifest with the control
that limits it. They are stated here rather than left implicit.

| Registry | What is excluded | Status |
| --- | --- | --- |
| `PROFILE-001` | The European ROM. Only the Japanese cartridge is accepted. | unsupported |
| `SND-001` | The Z80 sound driver program, which stays a verbatim payload and is never disassembled. | unsupported |
| `NAME-001` | 513 `_End` aliases that follow their own `binclude` payload hold no separate record. | partial |
| `NAME-002` | Zero records match the curated 55-sentence generic detector; a wider duplicate-basis review is pending. | partial |
| `NAME-003` | Seven boss-identity names remain provisional until pinned visual evidence or behavior-only renaming. | partial |
| `LAYOUT-001` | Module sizes: 232 of 398 modules sit inside the preferred 200–700 line band, 149 are shorter and 17 are longer. | partial |
| `TOOL-001` | Four exploratory commands remain outside release evidence; their source operations address modules. The obsolete pointer debugger is retired, and `verify-relocation` checks pointers across the current layout. | unsupported |
| `TOOL-002` | The monolithic asset splitter is retired; `make split` extracts canonical data under the asset manifest. | unsupported |
| `RELEASE-001` | The isolated 1.0 branch has not yet passed its final gate or received its final tag. | planned |
| `commit_body_convention` | Commits made before this manifest carry a title and attribution without a body. | partial |
| `frame_image_comparison` | Pixel comparison. The runtime layer checks state, not frames. | planned |
| `linux_aggregate_gate` | A gate run on Linux. The vendored Linux toolchain is present but untested. | partial |

## Why the exclusions are shaped this way

`SND-001` is the one place this repository holds executable code that the source
boundary rule would otherwise forbid. It is named rather than hidden: the
payload has an owning module, a declared ROM range and a pinned hash.

`LAYOUT-001` is a consequence of a module rule, not an oversight. A procedure
and its private tables are not split merely to reach a line count, and ROM order
is preserved by include order, so a subsystem that is contiguous in ROM stays in
one module even when that module is short or long. The 1000-line ceiling is the
hard limit and no module reaches it.

## Naming is not grandfathered

Semantic labels from the earlier automated pass are not facts. They were
reviewed module by module and corrected where the code disagreed; they may be
corrected again as evidence improves, and the imported label stays reachable
through the provenance marker either way. An unresolved symbol takes a
role-neutral name and an entry in `docs/unknowns.md` rather than an invented
behaviour.

## Release status

The manifest carries a `status` field and `make release-audit` reads it. While it
says `development` the audit checks only the claims above. Once it says
`tag-ready` the audit additionally requires a clean working tree and refuses to
pass if `source-reconstruction-1.0` already exists, so the status is a commitment
rather than a note: it cannot be left set after the tag is created.

The order is therefore fixed. The manifest is set to `tag-ready` and committed,
`make release-check` runs the whole gate against that commit, and only then is the
annotated tag created on it. A gate that has not run against the exact commit
being tagged does not count.

After tagging, one metadata-only commit may change the manifest to `tagged`
and record the tag in this document. The audit then requires an annotated tag
with a release description, pointing either to the checked commit or to that
metadata commit's parent. A later source change cannot silently inherit the
old tag as evidence for a new release.

An earlier local `source-reconstruction-1.0` tag was removed while separating
the preservation branch from later authoring work. This isolated branch remains
in `development` until its final gate passes; no 1.0 tag currently exists.
