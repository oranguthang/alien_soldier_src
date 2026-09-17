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

## Editing rules

- Keep module includes in ascending ROM order.
- Do not place emitting directives directly in `src/main.s`.
- Do not hide layout changes behind an `org`; declare intentional gaps.
- Run `make verify` after moving code, data, or includes.
- A source rename is not evidence by itself. Record how a semantic claim was
  established before treating it as confirmed.
