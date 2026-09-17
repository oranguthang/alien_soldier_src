# Source layout

`src/main.s` is the only assembly entrypoint. AS processes it as one translation
unit, so the ordered `include` list is also the ROM layout; there is no linker
or linker script.

The ranges, subsystem ownership, fixed landmarks, padding gaps, and maximum
module size are declared in `config/rom_layout.json`. Run `make verify-layout`
to compare that declaration with the assembler listing, module files, and built
ROM. `make verify` runs this check after the byte-identity build.

## Module size policy

The preservation-stage 0.5 layout still enforces a temporary 6,000-line limit
for byte-emitting `.s` modules. This only guards the first partition of a
roughly 120,000-line source; it is not an acceptable 1.0 module policy.

The Source Reconstruction 1.0 destination is normally 200-700 lines per
cohesive module, with a default hard ceiling of 1,000 lines. The sole possible
exception is one concrete boss whose state machine and private data cannot be
split without harming readability. Exceptions are reviewed individually and
declared in `config/source_reconstruction_1_0.json`. See
`docs/modularization_plan.md` for the migration rules and measured baseline.

The 1,000-line ceiling is now identical in `config/rom_layout.json`, the
development release contract, and the Source Reconstruction 1.0 contract.
`make lint` checks every declared module against it, while `make release-audit`
rejects a release threshold that attempts to weaken the destination contract.
The same audit rejects generic module filenames declared in the ROM layout.

Definition-only `.inc` files are outside this limit. They will receive their
own structure and policy as the RAM and hardware maps mature.

## Naming confidence

Directory names identify the best-supported broad subsystem. Existing mixed
and address-derived filenames are migration debt, not a naming convention.
Release 1.0 permits neither ROM-address filenames nor containers such as
`boss_code_31540.s`; uncertain code receives a role-neutral concept name until
stronger evidence supports a narrower identity.

Many symbol descriptions were generated during an earlier automated pass and
must be treated as hypotheses. Existing `; was:` annotations retain the IDA
name as provenance. A semantic name may be corrected whenever stronger static
or runtime evidence appears; byte identity, references, documentation, and the
unknowns register must be updated together.

## Padding is alignment

The `$FF` gaps between regions are not filler. The VDP latches the upper bits of
a DMA source address, so a transfer crossing a 128 KiB boundary wraps to the
start of that block instead of continuing, and the cartridge is laid out so that
no transferred payload straddles one: all 289 uncompressed art payloads sit
inside a single block. The `org` directives that skip those gaps are what holds
that arrangement.

`config/rom_layout.json` declares the rule in `dma_alignment` and
`make verify-layout` enforces it with a ceiling of zero. Compressed art is
exempt, because the 68000 expands it rather than the VDP transferring it; three
`artcomp` payloads cross a boundary in the canonical image and always have.

Two directives in the source are alignment for the same kind of reason and must
not be treated as decoration either: `align $8000` before the PCM banks keeps
them on the 32 KiB granularity the Z80 bank register selects, and `align0 2`
keeps word data even. Both survive relocation on their own; the `org` gaps do
not, because they encode absolute positions.

## Pointers are checked by moving the layout

A reference the assembler owns moves when the layout moves. A value written as a
literal does not. `make verify-relocation` separates the two by rebuilding the
ROM twice with the layout perturbed, under `build/relocation/`, and requiring
every reference to follow. Nothing under `src/` is touched and no emulator is
involved: the perturbed entrypoint and the files it replaces are generated and
assembled from the output directory.

Two perturbations are declared in `config/rom_layout.json`:

| Probe | What moves | What it tests |
|---|---|---|
| `content` | Every padding gap grows by whole DMA blocks, so all content moves | References to data, with the DMA alignment invariant deliberately held still |
| `code` | Unreachable `nop`s are inserted inside the code region, so code labels move relative to one another while the `org` directives hold the content | References to code, and the relative offsets between code labels |
| `returns` | Every safe `rts` is duplicated, so every procedure moves relative to every other one | That the source still assembles with the whole code region rearranged |

The filler for `returns` is a second `rts` rather than a `nop` for a reason
worth stating. A `nop` costs four cycles, and four cycles anywhere move the frame
counter, which desynchronises a recorded movie on a ROM that plays perfectly by
hand — a failure that looks exactly like a broken pointer and is not one. A
second `rts` after an existing one is unreachable by construction and free. It is
not inserted after every `rts`: five in the tree are the first entry of a branch
table of two-byte instructions reached by `jmp Table(pc,d0.w)`, where an extra
entry shifts every later mode, and those are told apart by what follows them — a
return is followed by a label, a table slot by another instruction.

A value that equals the address of a symbol which moved, and that did not move
with it, is reported. Both defects found this way were the same shape: a 32-bit
address encoded as two `dc.w` constants, in the stage tile asset command lists
and in `Boss_SunsetStingBodyPartInitTable`.

Precision is the hard part, because with fifteen thousand symbols a four-byte
window matches one by accident often. Four rules cut that down, each stated
rather than tuned: a window that runs past the statement that emitted it is
reading across two statements; a word- or byte-sized instruction cannot carry a
32-bit address; a site authored as a symbol is relocated by the assembler and
cannot be stale; and bytes inside a `binclude` payload are opaque, so nothing
about the source follows from them. What survives is listed in
`accepted_coincidences` with the reason it is a number rather than an address.

The probe cannot see a pointer that carries flags in its high bits, because the
stored value no longer equals the symbol address. `Boss_SunsetStingBodyPartInitTable`
holds several of those, with the top byte as flags and the low 24 bits as the
address, and they remain written as literals.

## Editing rules

- Keep module includes in ascending ROM order.
- Do not place emitting directives directly in `src/main.s`.
- Do not hide layout changes behind an `org`; declare intentional gaps.
- Run `make verify` after moving code, data, or includes.
- A source rename is not evidence by itself. Record how a semantic claim was
  established before treating it as confirmed.
