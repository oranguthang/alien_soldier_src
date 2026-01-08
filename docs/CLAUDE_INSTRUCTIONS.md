# Alien Soldier Disassembly - Documentation Workflow

This document describes the complete workflow for documenting procedures in the Alien Soldier disassembly project.

## Project Overview

- **Source file**: `alien_soldier_j.s` - Main assembly source (~123K lines)
- **Database**: `procedure_database.csv` - Tracks all procedures and their documentation status
- **Original ROM**: `alien_soldier_j.bin` - Reference ROM for verification

## Database Structure

The `procedure_database.csv` has these columns:

| Column | Description |
|--------|-------------|
| `old_name` | Original IDA-generated name (e.g., `sub_1234`) |
| `scene` | Game scene where procedure is used |
| `frame` | Frame number from analysis |
| `new_name` | Human-readable name (empty until renamed) |
| `description` | What the procedure does |
| `category` | Category: `Gfx`, `Sys`, `Sound`, `Input`, `Physics`, `Boss`, `Player`, `Sprite`, `Anim`, `Effect`, `AI` |
| `status` | `pending` or `analyzed` |

## Complete Workflow

### Step 1: Prepare a Batch

Extract pending procedures for analysis:

```bash
python scripts/prepare_batch.py --batch-size 40
```

This creates `batch_extract.txt` with procedure code for analysis.

### Step 2: Analyze Procedures

Read the extracted code and determine:
1. **New name**: Use format `Category_ActionDescription` (e.g., `Gfx_ClearVRAM`, `Boss_UpdateHealthBar`)
2. **Description**: Brief explanation of what the procedure does
3. **Category**: One of the predefined categories

### Step 3: Update Database

Create `batch_analysis.csv` with analysis results:

```csv
old_name,new_name,description,category
sub_1234,Gfx_ClearScreen,Clears entire screen buffer,Gfx
sub_5678,Boss_SpawnProjectile,Creates boss projectile with velocity,Boss
```

Then update the database:

```python
python -c "
import csv

# Load analysis results
with open('batch_analysis.csv', 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    updates = {row['old_name']: row for row in reader}

# Load and update database
with open('procedure_database.csv', 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    rows = list(reader)
    fieldnames = reader.fieldnames

for row in rows:
    if row['old_name'] in updates:
        update = updates[row['old_name']]
        row['new_name'] = update['new_name']
        row['description'] = update['description']
        row['category'] = update['category']
        row['status'] = 'analyzed'

with open('procedure_database.csv', 'w', encoding='utf-8', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

print(f'Updated {len(updates)} procedures')
"
```

### Step 4: Apply Renames to Source

**IMPORTANT**: The rename script now checks for collisions before applying changes!

```bash
python scripts/rename_procedures.py --database procedure_database.csv --source alien_soldier_j.s
```

The script will:
1. Check for duplicate new names in the batch
2. Check for conflicts with existing labels in the source
3. **REFUSE to proceed if any collisions are detected**
4. Create a backup before making changes
5. Apply all renames if validation passes

### Step 5: Build and Verify

**Always verify after renaming!**

```bash
# Build the ROM
make build

# Compare with original (MUST be identical!)
make compare
```

Expected output:
```
============================================================
SUCCESS: ROMs are identical!
============================================================
```

**If build fails or ROMs differ, DO NOT COMMIT. Fix the issue first.**

### Step 6: Commit Changes

Only commit after successful verification:

```bash
git add alien_soldier_j.s procedure_database.csv
git commit -m "Document [Scene] procedures - Batch N (X procedures)"
```

## Handling Name Collisions

### Types of Collisions

1. **Duplicate in batch**: Two procedures assigned the same new name
2. **Conflict with existing**: New name matches an already-existing label

### When Collision is Detected

The rename script will output:
```
ERROR: Name collisions detected! Cannot proceed with renaming.
================================================================================
  DUPLICATE: 'Effect_SpawnExplosion' is assigned to multiple procedures: sub_16E34, sub_18F58
  COLLISION: 'sub_1234' -> 'Gfx_ClearVRAM' conflicts with existing label 'Gfx_ClearVRAM'
```

### How to Fix

1. **For duplicates**: Analyze both procedures and give them distinct names
   - Example: `Effect_SpawnExplosion` vs `Effect_SpawnExplosionWithVelocity`
   - Or realize one is misnamed (like `Physics_ApplyVerticalDecel` was)

2. **For conflicts with existing**: The procedure was already renamed
   - Clear the `new_name` field in the database for that procedure
   - Or check if the existing label needs a different name

### Cleanup Script

Remove already-renamed procedures from pending renames:

```python
python -c "
import csv
import re

# Get existing labels from source
with open('alien_soldier_j.s', 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

labels = set(re.findall(r'^([A-Za-z_][A-Za-z0-9_]*):', content, re.MULTILINE))

# Update database
with open('procedure_database.csv', 'r', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    rows = list(reader)
    fieldnames = reader.fieldnames

for row in rows:
    # If old_name no longer exists, it was already renamed
    if row['old_name'] not in labels and row.get('new_name'):
        row['new_name'] = ''  # Clear to prevent re-rename attempt

with open('procedure_database.csv', 'w', encoding='utf-8', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)
"
```

## Useful Commands

### Check Progress

```bash
# Count analyzed vs pending
tail -n +2 procedure_database.csv | awk -F',' '{print $7}' | sort | uniq -c

# Progress by scene
tail -n +2 procedure_database.csv | awk -F',' '$7=="analyzed" {print $2}' | sort | uniq -c | sort -rn
```

### Extract Single Procedure

```bash
python scripts/get_procedure.py sub_1234
```

### Search for Procedure Usage

```bash
grep -n "sub_1234" alien_soldier_j.s
```

### Find Procedures by Pattern

```bash
grep -n "^sub_[0-9A-F]*:" alien_soldier_j.s | wc -l  # Count all sub_* procedures
grep -n "^Gfx_" alien_soldier_j.s                     # Find all Gfx_ procedures
```

## Naming Conventions

### Categories and Prefixes

| Prefix | Category | Used For |
|--------|----------|----------|
| `Gfx_` | Graphics | VDP, VRAM, palettes, tiles |
| `Sys_` | System | Initialization, memory, game loop |
| `Sound_` | Sound | Z80, audio driver, SFX |
| `Input_` | Input | Controllers, button reading |
| `Physics_` | Physics | Movement, collision, gravity |
| `Sprite_` | Sprite | OAM, sprite rendering |
| `Anim_` | Animation | Frame updates, animation tables |
| `Effect_` | Effects | Explosions, particles, visual FX |
| `Player_` | Player | Epsilon Eagle logic |
| `Boss_` | Boss | Boss AI, attacks, patterns |
| `Enemy_` | Enemy | Regular enemy AI |
| `AI_` | AI | Generic AI routines |
| `Data_` | Data | Data loading, tables |
| `Math_` | Math | Calculations, RNG |

### Good Names

- `Gfx_ClearVRAM` - Clear action on VRAM
- `Boss_UpdateHealthBar` - Update action for boss health
- `Physics_ApplyGravity` - Apply physics calculation
- `Sprite_InitFromTable` - Initialize sprite from data table

### Bad Names

- `DoStuff` - Too vague
- `Function1` - Meaningless
- `HandleThings` - Not specific enough

## Files to Ignore

These are in `.gitignore` and should not be committed:

- `batch_extract.txt` - Temporary batch extraction
- `batch_analysis.csv` - Temporary analysis results
- `rename_log.txt` - Rename operation log
- `alien_soldier_j_backup_*.s` - Backup files
- `asbuilt.bin` - Built ROM (regenerated)

## Troubleshooting

### Build Fails with "jump distance too big"

A `bsr.s` (short branch) became too far after renaming. This is usually caused by a name collision where the assembler resolves to a different label. **Fix the collision first**, don't just change `bsr.s` to `bsr.w`.

### Build Fails with "symbol double defined"

Two labels have the same name. Check for:
1. Duplicate names in your batch
2. New name conflicts with existing label

### ROMs Don't Match

Something changed the binary output. Possible causes:
1. Accidentally modified code (not just labels)
2. Label name affected offset calculation (rare)

Restore from backup and retry.

### "No procedures with new names found"

All procedures in database either:
1. Have empty `new_name` field
2. Were already renamed (old_name doesn't exist in source)

Run the cleanup script to sync database with source state.
