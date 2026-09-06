# Source layout

`src/main.s` is the only assembly entrypoint. AS processes it as one translation
unit, so the ordered `include` list is also the ROM layout; there is no linker
or linker script.

The ranges, subsystem ownership, fixed landmarks, padding gaps, and maximum
module size are declared in `config/rom_layout.json`. Run `make verify-layout`
to compare that declaration with the assembler listing, module files, and built
ROM. `make verify` runs this check after the byte-identity build.

## Module size policy

Alien Soldier uses a 6000-line limit for byte-emitting `.s` modules. This is a
project-specific first partition of a roughly 120,000-line source, not a claim
that every current file is already a final semantic unit. The limit is strict
and machine checked. Future evidence-backed splits should normally make files
smaller and more cohesive.

Definition-only `.inc` files are outside this limit. They will receive their
own structure and policy as the RAM and hardware maps mature.

## Naming confidence

Directory names identify the best-supported broad subsystem. Filenames for
mixed or uncertain areas include their starting ROM address, such as
`boss_code_31540.s`, rather than asserting a narrower interpretation.

Many symbol descriptions were generated during an earlier automated pass and
must be treated as hypotheses. Existing `; was:` annotations retain the IDA
name as provenance. A semantic name may be corrected whenever stronger static
or runtime evidence appears; byte identity, references, documentation, and the
unknowns register must be updated together.

## Editing rules

- Keep module includes in ascending ROM order.
- Do not place emitting directives directly in `src/main.s`.
- Do not hide layout changes behind an `org`; declare intentional gaps.
- Run `make verify` after moving code, data, or includes.
- A source rename is not evidence by itself. Record how a semantic claim was
  established before treating it as confirmed.
