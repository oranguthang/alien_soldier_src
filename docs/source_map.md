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
| `0x02A30E-0x03153F` | enemies, projectiles, boss helpers | 2 | hypothesis |
| `0x031540-0x082323` | boss-heavy code and first padding gap | 12 | hypothesis |
| `0x082324-0x0E7FFF` | sound driver/data and second padding gap | 1 | static |
| `0x0E8000-0x17FFFF` | mixed data and third padding gap | 1 | unknown |
| `0x180000-0x1FFFFF` | final data bank and ROM end byte | 1 | unknown |

The ranges are intentionally address ordered. A broad owner is not proof that
every routine in that interval belongs to the named subsystem. As analysis
improves, modules may be split and moved between subsystem directories without
changing emitted order or bytes.
