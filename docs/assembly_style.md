# Assembly style

Alien Soldier uses the same deterministic Mega Drive assembly layout as the
Flicky Source Reconstruction 1.0 tree:

- definitions begin in column zero;
- mnemonics begin in column 16;
- operands begin in column 24;
- ordinary inline comments begin in column 56, or two spaces after unusually
  long code;
- tabs, trailing whitespace, CR line endings, and non-ASCII source text are
  rejected;
- consecutive blank lines and redundant final blank lines are collapsed.

`make format` applies the canonical form to every `.s` and `.inc` file and then
runs `make lint`. The operation must be idempotent. Because label width can
change alignment, normal rename workflow is:

```text
make format
make verify
make test
make lint
```

Formatting is never allowed to explain a ROM difference. If `make verify`
fails after formatting, the formatter or source edit is wrong.
