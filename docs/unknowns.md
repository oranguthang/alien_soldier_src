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

Two especially broad data labels are explicitly registered:

| Symbol | ROM address | Evidence | Current statement |
|---|---:|---|---|
| `unknown_1` | `0x0E8020` | unknown | Large data structure; format and ownership are unverified. |
| `unknown_2` | `0x180000` | unknown | Start of the final data bank; semantic role is unverified. |

The 4,822 semantic names with `; was:` history are a second review queue. Their
default level is `hypothesis`, not `confirmed`; see `docs/provenance.md`.
