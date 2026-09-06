# Source and subsystem map

The authoritative machine-readable map is `config/rom_layout.json`. The table
below is an orientation layer; exact ownership is checked from the assembler
listing by `make verify-layout`.

| ROM range | Broad owner | Files | Confidence |
|---|---|---:|---|
| `0x000000-0x008A79` | boot, system, input, interrupts | 2 | mixed: static/hypothesis |
| `0x008A7A-0x00D713` | opening and cutscene support | 1 | hypothesis |
| `0x00D714-0x010D15` | stage systems | 1 | hypothesis |
| `0x010D16-0x013B29` | background and scroll rendering | 1 | hypothesis |
| `0x013B2A-0x016F35` | collision and shared gameplay | 1 | hypothesis |
| `0x016F36-0x02018F` | player, weapons, projectiles | 2 | hypothesis |
| `0x020190-0x02A30D` | UI, results, transitions, effects | 1 | hypothesis |
| `0x02A30E-0x03153F` | enemies, projectiles, boss helpers | 2 | hypothesis |
| `0x031540-0x082323` | boss-heavy code and first padding gap | 12 | hypothesis |
| `0x082324-0x0E7FFF` | sound driver/data and second padding gap | 1 | static |
| `0x0E8000-0x17FFFF` | mixed data and third padding gap | 1 | unknown |
| `0x180000-0x1FFFFF` | final data bank and ROM end byte | 1 | unknown |

The ranges are intentionally address ordered. A broad owner is not proof that
every routine in that interval belongs to the named subsystem. As analysis
improves, modules may be split and moved between subsystem directories without
changing emitted order or bytes.
