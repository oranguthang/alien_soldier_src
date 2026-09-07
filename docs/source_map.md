# Source and subsystem map

The authoritative machine-readable map is `config/rom_layout.json`. The table
below is an orientation layer; exact ownership is checked from the assembler
listing by `make verify-layout`.

| ROM range | Broad owner | Files | Confidence |
|---|---|---:|---|
| `0x000000-0x003549` | header, boot, interrupts, rendering primitives, objects, input | 18 | mixed: static/hypothesis |
| `0x00354A-0x00483F` | math, score, palette, results, and text engines | 6 | mixed: static/hypothesis |
| `0x004840-0x009321` | story, planet, credits, and ship sequences | 9 | hypothesis |
| `0x009322-0x00C83D` | title/options/password UI, results, and palette assets | 6 | hypothesis |
| `0x00C83E-0x00D713` | camera dispatch and early-stage transitions | 4 | hypothesis |
| `0x00D714-0x010025` | stage groups, boss transitions, and dispatch helpers | 13 | hypothesis |
| `0x010026-0x010D15` | camera, scroll planes, and tilemap rendering | 4 | static/hypothesis |
| `0x010D16-0x012B69` | DMA, asset transfer, and stage loading/configuration | 7 | static/hypothesis |
| `0x012B6A-0x013ADD` | debug UI, HUD, status display, and player physics | 5 | hypothesis |
| `0x013ADE-0x0146FB` | entity, terrain, and combat collision | 2 | static/hypothesis |
| `0x0146FC-0x016F35` | player terrain and state families | 9 | hypothesis |
| `0x016F36-0x019A6B` | player rendering, weapons, projectiles, and weapon UI | 7 | hypothesis |
| `0x019A6C-0x01C3F9` | stage intros, Seven Force projectiles, object utilities, and projectile slots | 6 | hypothesis |
| `0x01C3FA-0x01E83D` | stage background, gameplay, frontend, results, and transitions | 14 | hypothesis |
| `0x01E83E-0x020249` | cutscenes, stage initialization, menus, and results scrolling | 5 | hypothesis |
| `0x02024A-0x023CB9` | results data, credits, selection UI, and floating icons | 6 | hypothesis |
| `0x023CBA-0x02A30D` | demo, cutscene, transition, VDP layout, and Valkirie systems | 8 | hypothesis |
| `0x02A30E-0x02B6B1` | shared combat helpers, sprite debug tooling, and enemy projectiles | 3 | hypothesis |
| `0x02B6B2-0x02C0FF` | Jetsripper combat, stage 25 destruction, and shared boss runtime | 3 | hypothesis |
| `0x02C100-0x02CB85` | Snake/Bugmax projectiles, Jetsripper movement, and actor states | 3 | hypothesis |
| `0x02CB86-0x02D3E7` | Jetsripper/Joker combat, ship enemy, and phase attacks | 3 | hypothesis |
| `0x02D3E8-0x02DF7D` | circle, stage 17, and bird enemies | 3 | hypothesis |
| `0x02DF7E-0x02F1A1` | stage 10/12 enemies, flyer, train, and Xi-Tiger intro | 5 | hypothesis |
| `0x02F1A2-0x030B39` | Xi-Tiger, Antroid, ship, stage 18, and Jetsripper weapons | 6 | hypothesis |
| `0x030B3A-0x032343` | stage 11 parts, Gusthead, and Destroyer Proto | 4 | hypothesis |
| `0x032344-0x033C49` | stage 14/Jetsripper, Wolf Garopa, Tracker, and Missiray flyer | 4 | hypothesis |
| `0x033C4A-0x035613` | stage 24 visuals, boss projectiles, metasprites, and sprite tables | 4 | hypothesis |
| `0x035614-0x0374C5` | Jetsripper and Shiper state, movement, and projectiles | 6 | hypothesis |
| `0x0374C6-0x0394D7` | Antroid and Terobuster systems | 7 | hypothesis |
| `0x0394D8-0x03B29D` | Shellshogun and Madam Barbar systems | 4 | hypothesis |
| `0x03B29E-0x03D0AD` | Joker and Flying Neo systems | 4 | hypothesis |
| `0x03D0AE-0x040CED` | Caterpillar, Xi-Tiger, Deep Strider, Gusthead, and Snake | 7 | hypothesis |
| `0x040CEE-0x045ACF` | Sunset Sting, Viblack, Back Stringer, and opening Epsilon projectiles | 12 | hypothesis |
| `0x045AD0-0x0490FF` | Epsilon 1 and Sharpssteel systems | 9 | hypothesis |
| `0x049100-0x04BEBB` | Jampan and Destroyer MK2 systems | 7 | hypothesis |
| `0x04BEBC-0x04DDD1` | Bugmax systems | 4 | hypothesis |
| `0x04DDD2-0x050CD3` | Shield Viper and Wolf Garopa systems | 8 | hypothesis |
| `0x050CD4-0x0537B7` | Valkirie transition, Z-Leo, and Valkirie Force | 8 | hypothesis |
| `0x0537B8-0x05575D` | Missiray and Seven Forces introduction/forms | 6 | hypothesis |
| `0x05575E-0x057497` | Valkirie battle/rendering and Medusa | 3 | hypothesis |
| `0x057498-0x058FED` | Sirene, Artemis, and an unidentified Seven Force | 4 | hypothesis |
| `0x058FEE-0x05A43B` | alternate Valkirie and Sylpheed systems | 3 | hypothesis |
| `0x05A43C-0x082323` | final entity stub, included data, and first padding gap | 1 | static |
| `0x082324-0x083E6F` | 68k sound driver, playback, and sequence commands | 6 | static |
| `0x083E70-0x084A6F` | embedded Z80 sound program | 1 | static |
| `0x084A70-0x085265` | channel playback and sound lookup tables | 4 | static |
| `0x085266-0x097FFF` | music tracks and sound effects | 5 | static |
| `0x098000-0x0E7FFF` | PCM sample banks and second padding gap | 1 | static |
| `0x0E8000-0x17FFFF` | mixed data and third padding gap | 1 | unknown |
| `0x180000-0x1FFFFF` | final data bank and ROM end byte | 1 | unknown |

The ranges are intentionally address ordered. A broad owner is not proof that
every routine in that interval belongs to the named subsystem. As analysis
improves, modules may be split and moved between subsystem directories without
changing emitted order or bytes.
