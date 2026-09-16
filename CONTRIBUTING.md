# Contributing

This is a preservation project. The measure of every change is that the build
still reproduces the original cartridge byte for byte.

## From a fresh clone

```bash
# Place the original Japanese cartridge dump in the project root:
#   Alien Soldier (J) [!].bin
make init            # Validate the ROM, extract data, build and verify
make release-check   # The full ordered gate, as the release runs it
```

`make init` writes the 579 extracted segments into `data/`. Nothing derived from
the cartridge is ever committed; `.gitignore` and the release audit both enforce
that, the latter across the whole reachable history.

## Before you commit

```bash
make format   # Normalize assembly style; it must never move a byte
make lint     # Source policy, naming vocabulary and project policy
make test     # The Python tests behind the tooling
make verify   # Byte identity against the cartridge dump
```

`make verify` is not optional after any change under `src/`, including a pure
rename. Formatting and renaming are byte-neutral by definition, so a divergence
means the change was not what it appeared to be.

## Naming a symbol

Read [`docs/naming.md`](docs/naming.md) first. In short:

- A name is owned by one of the declared subsystems in
  `config/source_policy.json`, derives from a symbol that exists, or is a
  declared hardware exception. `make lint` rejects anything else.
- An address is never an identity. If you cannot support a semantic name with
  static or runtime evidence, give the symbol an honest role-neutral name and
  add an entry to [`docs/unknowns.md`](docs/unknowns.md).
- Renaming a definition keeps its `; was:` provenance marker and adds or updates
  its exact-address record in `config/name_audit.json`, with the evidence that
  justifies the new name.
- Rename references atomically, with `scripts/rename_symbols.py`, and run
  `make verify` afterwards.

A wrong semantic name is worse than an explicit unknown.

## Commit messages

English, with a title that names the result concretely and does not end in a
period. `Fix`, `Update` and `WIP` are not titles.

After the title and a blank line, write two or three paragraphs:

1. what changed and which subsystems it touched;
2. why, and what evidence or contract the change adds or preserves;
3. for a release commit, which gates passed and what the release scope includes
   and excludes.

The body describes the actual diff. Do not announce a release that the manifest,
the documentation and the full gate have not yet earned.

One commit is one architectural or release task. Empty commits are not used for
any purpose, including release markers: the release is an annotated tag on a
commit that really changed something.

## What not to do

- Do not commit the cartridge, anything extracted from it, or a built image.
- Do not weaken a threshold in `config/` to make a gate pass.
- Do not use the older analysis commands listed in
  [`docs/tooling_status.md`](docs/tooling_status.md) as evidence; they predate
  the split into modules and mutate a single translation unit.
- Do not let documentation claim more than the source, the tests and the runtime
  evidence support.
