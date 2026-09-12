# Runtime verification

`config/runtime_scenarios.json` defines six project-specific checkpoints using
the pinned TAS movie and emulator commit. Screenshots are retained only as
diagnostic evidence; pass/fail is determined by named RAM assertions.

| Scenario | Frame | Primary assertion |
|---|---:|---|
| boot | 20 | top-level mode and substate are reset |
| title | 320 | `GameModeIndex == 0x14` |
| gameplay start | 700 | gameplay mode, Stage 1 table index |
| boss transition | 900 | object-pool slot `+0x1E0` dispatches through `Object_UpdateProximityPickupEmitterType48` (`0x48`) |
| stage change | 1920 | gameplay mode, Stage 2 table index (`0x02`) |
| credits | 70000 | credits main-loop mode (`0x90`) and substate |

`GameModeIndex` is confirmed statically by `Sys_DispatchGameState`, which uses
it directly as the byte offset into `off_C7C`. `StageTableIndex` similarly
indexes `off_1226C`. The Stage 1 transition expectation is supported by
`Entity_UpdateHandlerTable` and the type-$48 object observed at the checkpoint.
Static behavior proves that this object oscillates, may create a large pickup
near the player, and then becomes a short-lived type-$C4 burst; it is not the
later Jetsripper boss-core handler.

Run `make runtime`. Captures are reproducible outputs under `runtime/captures/`
and are ignored by Git. The current Gens helper writes zero in the header frame
field when a dump accompanies a screenshot, so the zero header is not used as
evidence; the requested frame is encoded in the capture filename and chosen by
the emulator's screenshot interval. Each emulator invocation has a 300-second
deadline; the credits checkpoint at frame 70000 can exceed three minutes on a
loaded Windows host even though the shorter checkpoints complete promptly.
