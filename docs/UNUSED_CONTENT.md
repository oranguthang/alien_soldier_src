# Alien Soldier - Unused Content Activation Codes

Source: YouTube videos by Zetaman (Oct-Nov 2021)
<https://www.youtube.com/c/Zetaman>

## Global Activation Code

Most unused features require the following ROM modification first:
```
ROM Offset 0x00036C: 4E 71 4E 71
```
This patches out a check that prevents unused content from loading. The bytes `4E 71` are the 68000 NOP instruction.

---

## Unused Bosses

### Love Penguin (Boss ID $01C0)
**Video:** <https://www.youtube.com/watch?v=...> (28 Oct 2021)

Appears in magazine previews as "Love Penguin". Hand-shaped boss.

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x01147C: 01 C0 00 01 15 42 00 00 C4 04
```
Encounter at Stage 13.

**Disassembly Location:**
- Boss structure: Line 20999 (stru_11542)
- Graphics: byte_11A8FC
- Palette: byte_C404

---

### Lambda Bunny (Boss ID $03EC)
**Video:** <https://www.youtube.com/watch?v=...> (2 Nov 2021)

Cowboy rabbit boss from box art sketches.
Source: <https://twitter.com/megadriveshock/st...>

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x0113B4: 03 EC 00 01 15 B2 00 00 C5 BE
```
Encounter at Stage 5 (convenient spawn area).

Video shows unused animation of boss firing its gun.

**Disassembly Location:**
- Boss structure: Line 21055 (stru_115A8)
- Graphics: byte_125902
- Palette: byte_C5BE
- Loader: sub_E6D6 (line 16561)

---

### Dragon (Boss ID $03FC)
**Source:** TCRF research

**Disassembly Location:**
- Boss structure: Line 21126
- Graphics: byte_12D012
- Palette: byte_C63E

**Status:** Activation code unknown

---

### Unknown Boss $3F0
**Disassembly Location:**
- Boss structure: Line 21098 (stru_115C4)
- Graphics: byte_12772E
- Palette: byte_C5DE
- Loader: sub_E72C (line 16598)

**Status:** Activation code unknown

---

### Unknown Boss $3F4
**Disassembly Location:**
- Boss structure: Line 21110 (stru_115E0)
- Graphics: byte_12E96C
- Palette: byte_C5FE
- Loader: sub_E782 (line 16639)

**Status:** Activation code unknown, possibly Praying Mantis or Sigma Fox

---

## Jampan Area Unused Stages
**Video:** <https://www.youtube.com/watch?v=...> (4 Nov 2021)

Entirely unused area with 3-4 bosses meant to take place after snowy mountains.

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x011736: 03 F6 03 F6 03 F6
ROM 0x01226C: 02 3E 02 46 02 84
```
Replaces Stages 1-3 with unused Jampan stages.

**Bosses:**
1. Unknown boss 1
2. Unknown boss 2
3. **Praying Mantis** - Graphics load but boss doesn't function
4. **Sigma Fox** (4th stage) - Mechanical fox, graphics load but no functionality

Human versions of Lambda Bunny and Mantis visible in background graphics:
<https://tcrf.net/Alien_Soldier>

**Graphics Location:** Data located after snowy mountains area in ROM

---

## Unused Dialogue System
**Video:** <https://www.youtube.com/watch?v=...> (31 Oct 2021)

Pre-battle dialogue exchanges before each boss fight. Translations by Charles Norwood.

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x00B462: 67
```

**Behavior:**
- Dialogue only appears on first attempt of boss fight
- Text advances with face buttons
- Feature would have been toggleable in options (unused options screen exists)

**Bosses with Dialogue:**
- JetsRipper (0:00)
- Antroid (0:33)
- Shell Shogun (0:59)
- Sniper Honeyviper (1:28)
- Madam Barbar (1:59)
- Joker (2:27)
- ST-210-Terobuster (3:30)
- Seven Force (dialogue text)
- Remaining bosses use repeat text

**Disassembly Location:** ROM offset 0x00B462 (needs investigation)

---

## Unused Story Text Screens
**Video:** <https://www.youtube.com/watch?v=...> (3 Nov 2021)

Text screens giving story updates between stages. Translations by Charles Norwood.

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x01E276: 4E 71 4E 71
```

**Content:**
1. **Screen 1 (0:10):**
   > The man arrived, and… -
   > The lovable denizens of Planet Mikan are now in danger!!
   > With the massive invasion of the Animal Gang terrorist group,
   > Fear and sadness resound…
   > He cannot allow them to continue to exist!!
   > Now, rage, Alien Soldier!!

2. **Screen 2 (0:36):**
   > The demon of sickness creeps in, and soon… -
   > The site of the battle moves toward Mikan International Airport.
   > With Alien Soldier approaching, the enemy leader, Wandaba, seems to be planning to flee on an airplane.
   > "Not so fast, Let's do this!!"
   > At that moment, he feels a dull pain in his back…

3. **Screen 3 (1:05):**
   > Wandaba is down!! But… -
   > By the skin of his teeth, Alien Soldier has managed to jump onto the Animal Gang boss's airplane!!
   > If those steel wings, freed from the bonds of gravity, are left to their own devices,
   > it seems they might just climb up and up to the end of the sky…

4. **Screen 4 (1:33):**
   > Climbing to an altitude of 10,000 meters  -
   > Well, all that's left is to defeat Wandaba, the Don of the Animal Gang!!
   > It's cold on top of the self-piloted airplane, but the enmity between Wandaba and Alien Soldier is steaming hot!!
   > But from behind them approached an enormous, evil shadow...

**Controls:** Press START to skip screens

**Disassembly Location:** ROM offset 0x01E276 (needs investigation)

---

## Laboratory Stage
**Video:** <https://www.youtube.com/watch?v=...> (5 Nov 2021)

Unused "stage" meant to take place after Missiray elevator fight.

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x011766: 05 4A
ROM 0x011E16: 03 52
ROM 0x01229C: 03 1A
```

**Behavior:** Plays short cutscene, then game crashes

**Disassembly Location:** ROM offsets 0x011766, 0x011E16, 0x01229C (need investigation)

---

## Epsilon 1 Unused Cutscene
**Video:** <https://www.youtube.com/watch?v=...> (13 Nov 2021)

Cutscene meant to play at beginning of Stage 17 before Epsilon 1 fight.
Appeared in prerelease magazine build:
<https://tcrf.net/Prerelease:Alien_Soldier>

**Activation:**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x00D9C8: 07 BA 07 BA 07 BA
ROM 0x0120C0: 4E 75
ROM 0x01245C: 02
ROM 0x01247F: 12
```

**Content:** Text reads "Ka...Kaede...??" (reused from Seven Force dialogue)

**Disassembly Location:** ROM offsets 0x00D9C8, 0x0120C0, 0x01245C, 0x01247F (need investigation)

---

## Seven Force Unused Forms
**Video:** <https://www.youtube.com/watch?v=...> (6 Nov 2021)

Code exists to play "Harpy Force" and "Nemesis Force" sound effects and load Eagle Force graphics, but doesn't work properly.

**Activation (Harpy Force):**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x011658: 04 40
ROM 0x011662: 00 00 C7 1E
```

**Activation (Nemesis Force):**
```
ROM 0x00036C: 4E 71 4E 71   (global enable)
ROM 0x011658: 04 3C
ROM 0x011662: 00 00 C7 3E
```

**Status:** Code exists but doesn't function properly

**Disassembly Location:** ROM offsets 0x011658, 0x011662 (need investigation)

---

## Notes on ROM Offsets

All ROM offsets are in hexadecimal. In the disassembly, these correspond to actual code/data addresses. The mapping needs to be established for each offset mentioned above.

**Common Pattern:**
- `4E 71` = NOP instruction (No Operation) in 68000 assembly
- Used to disable checks or skip unwanted code

## References

1. Zetaman YouTube Channel: <https://www.youtube.com/c/Zetaman>
2. The Cutting Room Floor: <https://tcrf.net/Alien_Soldier>
3. Translation credits: Charles Norwood
4. Box art research: <https://twitter.com/megadriveshock>

---

*Document created from YouTube video research (Oct-Nov 2021)*
*Last updated: 2026-01-11*
