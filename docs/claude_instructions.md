# Alien Soldier Disassembly - Documentation Workflow

## Project Overview

- **Source file**: `alien_soldier_j.s` - Main assembly source (~123K lines)
- **Original ROM**: `alien_soldier_j.bin` - Reference ROM for verification
- **Workflow dir**: `workflow/` - Reports, batch files, and state

## Makefile Workflow

### Step 1: Generate Reference Data

Generate reference screenshots and memory dumps:

```bash
make reference MOVIE=tas       # TAS speedrun reference
make reference MOVIE=longplay  # Full game reference
make reference MOVIE=menus     # Menu exploration reference
```

Creates `reference/{type}/` with:
- Screenshots every 20 frames (`.png`)
- Memory state dumps (`.genstate`)

### Step 2: Find Unanalyzed Procedures

```bash
make find-unanalyzed
```

Creates `workflow/unanalyzed_procedures.txt`.

### Step 3: Run Analysis

Analyze procedures by NoP'ing them out and comparing:

```bash
make analyze MOVIE=tas      # Analyze with TAS movie
make analyze MOVIE=longplay # Analyze with longplay
make analyze MOVIE=menus    # Analyze with menus
```

Output: `diffs/{type}/{procedure}/` with diff screenshots and state dumps.

### Step 4: Generate Reports

```bash
make report MOVIE=tas
```

Generates:
- `workflow/analysis_report_tas.txt` - Human-readable
- `workflow/analysis_report_tas.csv` - For documentation workflow

---

## Documentation Workflow (Claude + Human)

### Step 1: Set Movie Type

```bash
make set-movie MOVIE=tas
```

Saves to `workflow/.movie` for subsequent commands.

### Step 2: Prepare Batch

```bash
make prepare-batch COUNT=40
```

Creates `workflow/batch_procedures.txt` with:
- Code for each procedure
- Scene and frame context
- Memory change indicators (RAM, VDP, Z80, etc.)
- Links to visual diffs

### Step 3: Claude Analyzes (use `/document` skill)

Run the `/document` skill which:
1. Reads `workflow/batch_procedures.txt`
2. Analyzes each procedure's code and context
3. Creates `workflow/rename_batch.csv`

**CSV format:**
```csv
old_name,new_name,description
sub_1234,Player_UpdateHealth,"Updates player health bar"
```

### Step 4: Apply Renames

```bash
make rename
```

This will:
1. Read `workflow/rename_batch.csv`
2. Apply all renames to `alien_soldier_j.s`
3. Mark procedures as `processed=true` in the report CSV

### Step 5: Verify and Commit

```bash
make build
make compare
git add alien_soldier_j.s
git commit -m "Document batch N: X procedures"
```

---

## Naming Conventions

### Category Prefixes

| Prefix | Purpose |
|--------|---------|
| `Gfx_` | VDP, VRAM, palettes, tiles, DMA |
| `Sys_` | Initialization, memory, game loop |
| `Sound_` | Z80, audio driver, SFX, music |
| `Input_` | Controllers, button handling |
| `Physics_` | Movement, collisions, gravity |
| `Sprite_` | Sprite rendering, OAM |
| `Anim_` | Animation updates |
| `Effect_` | Visual effects (explosions, particles) |
| `Player_` | Player character logic |
| `Boss_` | Boss AI and attacks |
| `Enemy_` | Enemy AI |
| `UI_` | Menus, HUD, text |
| `Math_` | Calculations, RNG |
| `Stage_` | Level/stage logic |
| `Object_` | Game objects, entities |

### Good Names

```
Gfx_LoadSegaLogoTiles       - Specific action
Sys_InitWorkRAM             - Clear purpose
Sound_InitZ80Driver         - What it does
Player_UpdateXPosition      - Actor + action
```

### Bad Names

```
DoStuff                     - Too vague
Function1                   - Meaningless
Process                     - Too generic
```

---

## Understanding Procedure Context

### Memory Change Indicators (CSV columns)

| Column | Meaning |
|--------|---------|
| `RAM` | M68K work RAM modified |
| `VDP` | Video registers or VRAM changed |
| `Z80` | Sound CPU memory affected |
| `YM2612` | FM synth registers |
| `PSG` | PSG sound chip |

### Change Types

| Type | Visual Effect |
|------|---------------|
| `visual_change` | Graphics differ |
| `black_screen` | Screen went black |
| `frozen` | Game froze |
| `red_screen` | Error screen |

### Interpreting Visuals

- **Black screen** - Clearing/initialization
- **Graphics appeared** - Loading tiles/sprites
- **Palette changed** - Setting colors
- **Sprites moved** - Updating positions

---

## Memory Dump Analysis

For procedures with memory changes, compare states:

```bash
python scripts/compare_states.py \
    --diffs-dir diffs/tas \
    --reference-dir reference/tas \
    --output-dir reports
```

Reports show:
- RAM changes - Variable updates
- VRAM changes - Graphics loading
- CRAM changes - Palette updates
- VDP register changes - Video configuration

---

## Debug Workflow

When modifications break the game:

```bash
make debug MOVIE=tas
```

This:
1. Builds ROM
2. Runs with memory comparison
3. Stops at first difference
4. Generates detailed report in `reports/`

---

## File Reference

### Generated (gitignored)

- `reference/{type}/` - Reference screenshots + dumps
- `diffs/{type}/` - Diff screenshots per procedure
- `reports/` - Memory comparison reports
- `workflow/batch_procedures.txt` - Current batch to document
- `workflow/rename_batch.csv` - Renames to apply
- `alien_soldier_j_backup_*.s` - Auto backups

### In Git

- `alien_soldier_j.s` - Main source
- `alien_soldier_j.bin` - Original ROM
- `workflow/analysis_report_*.csv` - Analysis reports with processed status
- `workflow/.movie` - Current movie type
- `scripts/*.py` - Build and analysis scripts
- `docs/` - Documentation

---

## Troubleshooting

### Build fails: "jump distance too big"

A `bsr.s` became too far. Usually a name collision - check for duplicates.

### Build fails: "symbol double defined"

Two labels have the same name. Check batch_renames.csv for duplicates.

### ROMs don't match

Something changed binary output. Restore from backup and fix the issue.

### No procedures to process

All procedures marked as `processed=true`. Generate new analysis with different movie type.

---

## Quick Reference

```bash
# Setup (once per movie type)
make set-movie MOVIE=tas

# Each batch iteration
make prepare-batch COUNT=40   # Create batch
/document                     # Claude documents (creates rename_batch.csv)
make rename                   # Apply renames
make build && make compare    # Verify
git commit                    # Save progress
```
