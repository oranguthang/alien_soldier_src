Stage_LoadStage16Assets:                                ; DATA XREF: ROM:00011750   o  ; was: sub_11A5C
                                        ; ROM:00011752   o
                move.w  #4,(word_FFA206).w
                lea     Stage16AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage16Assets
; ---------------------------------------------------------------------------
Stage16AssetLoadList:   dc.w    7                       ; field_0  ; was: stru_11A6E
                                        ; DATA XREF: Stage_LoadStage16Assets+6   o
                dc.l    tiles_1A2C46                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage16TileArt5F00              ; field_2
                dc.w    $5F00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A6276                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A648A                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedBossMappingData2020       ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1A74F6                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 2 phase 1 asset list
Stage_LoadStage2Phase1Assets:                           ; DATA XREF: ROM:00011756   o  ; was: sub_11AB0
                move.w  #4,(word_FFA206).w
                lea     Stage2Phase1AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage2Phase1Assets
; ---------------------------------------------------------------------------
Stage2Phase1AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_11AC2
                                        ; DATA XREF: Stage_LoadStage2Phase1Assets+6   o
                dc.l    Stage2Phase1TileArt0000         ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage2Phase1TileArt6000         ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage2Phase1MappingData6000     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage2Phase1MappingData4000     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 18 asset list
Stage_LoadStage18Assets:                                ; DATA XREF: ROM:00011758   o  ; was: sub_11AF4
                                        ; ROM:0001175A   o
                move.w  #8,(word_FFA206).w
                lea     Stage18AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage18Assets
; ---------------------------------------------------------------------------
Stage18AssetLoadList:   dc.w    7                       ; field_0  ; was: stru_11B06
                                        ; DATA XREF: Stage_LoadStage18Assets+6   o
                dc.l    tiles_1A9CC4                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1ACB68                    ; field_2
                dc.w    $2A00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1ABB28                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1ABC72                     ; field_2
                dc.w    $6400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1ABCFC                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1AF030                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1AF09C                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedStage18AndStage20MappingData7000  ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B109C                     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1B0F08                    ; field_2
                dc.w    $8E00                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Unreferenced loader for the Stage 2 phase 2 asset list
UnreferencedStage2Phase2AssetLoader:
                move.w  #8,(word_FFA206).w              ; was: sub_11B60
                lea     UnreferencedStage2Phase2AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function UnreferencedStage2Phase2AssetLoader
; ---------------------------------------------------------------------------
UnreferencedStage2Phase2AssetLoadList:  dc.w    7       ; field_0  ; was: stru_11B72
                                        ; DATA XREF: UnreferencedStage2Phase2AssetLoader+6   o
                dc.l    UnreferencedStage2Phase2TileArt0000  ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage2Phase2MappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage2Phase2MappingData4020  ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedStage18AndStage20MappingData7000  ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 20 asset list
Stage_LoadStage20Assets:                                ; DATA XREF: ROM:0001175C   o  ; was: sub_11B9C
                move.w  #8,(word_FFA206).w
                lea     Stage20AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage20Assets
; ---------------------------------------------------------------------------
Stage20AssetLoadList:   dc.w    7                       ; field_0  ; was: stru_11BAE
                                        ; DATA XREF: Stage_LoadStage20Assets+6   o
                dc.l    tiles_1B5466                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1B3A9E                    ; field_2
                dc.w    $3000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B6C40                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B6C82                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B3EDE                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B401E                     ; field_2
                dc.w    $6200                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B412A                     ; field_2
                dc.w    $6400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B41DA                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedStage18AndStage20MappingData7000  ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 3 phase 1 asset list
Stage_LoadStage3Phase1Assets:                           ; DATA XREF: ROM:00011762   o  ; was: sub_11C00
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bra.s   Stage_SubmitStage3Phase12SharedAssetList
; End of function Stage_LoadStage3Phase1Assets
; Prepares resampled tiles and loads the shared Stage 3 phase 1/2 asset list
Stage_LoadStage3Phase2Assets:                           ; DATA XREF: ROM:0001175E   o  ; was: sub_11C14
                                        ; ROM:00011760   o
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                bset    #7,(byte_FFA959).w
                bsr.w   Gfx_PrepareStage3Phase2ResampledTiles
Stage_SubmitStage3Phase12SharedAssetList:               ; CODE XREF: Stage_LoadStage3Phase1Assets+12   j  ; was: loc_11C2A
                lea     Stage3Phase12SharedAssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase2Assets
; ---------------------------------------------------------------------------
Stage3Phase12SharedAssetLoadList:   dc.w    7           ; field_0  ; was: stru_11C36
                                        ; DATA XREF: Stage_LoadStage3Phase2Assets:Stage_SubmitStage3Phase12SharedAssetList   o
                dc.l    Stage3Phase12TileArt            ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase12MappingData6000    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase12MappingData4020    ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase12MappingData5A00    ; field_2
                dc.w    $5A00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase12MappingData7800    ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 3 phase 3 asset list
Stage_LoadStage3Phase3Assets:                           ; DATA XREF: ROM:00011764   o  ; was: sub_11C70
                move.w  #$C,(word_FFA206).w
                lea     Stage3Phase3AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase3Assets
; ---------------------------------------------------------------------------
Stage3Phase3AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_11C82
                                        ; DATA XREF: Stage_LoadStage3Phase3Assets+6   o
                dc.l    Stage3Phase3TileArt0000         ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage3Phase3Tiles               ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase3MappingData6000     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase3MappingData4020     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Unreferenced loader for the Stage 3 phase 4 asset list
UnreferencedStage3Phase4AssetLoader:
                move.w  #$C,(word_FFA206).w             ; was: sub_11CB4
                lea     UnreferencedStage3Phase4AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function UnreferencedStage3Phase4AssetLoader
; ---------------------------------------------------------------------------
UnreferencedStage3Phase4AssetLoadList:  dc.w    7       ; field_0  ; was: stru_11CC6
                                        ; DATA XREF: UnreferencedStage3Phase4AssetLoader+6   o
                dc.l    UnreferencedStage3Phase4TileArt0000  ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    UnreferencedStage3Phase4TileArt5800  ; field_2
                dc.w    $5800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage3Phase4MappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage3Phase4MappingData4020  ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Unreferenced loader for the Stage 3 phase 5 asset list
UnreferencedStage3Phase5AssetLoader:
                move.w  #$C,(word_FFA206).w             ; was: sub_11CF8
                lea     UnreferencedStage3Phase5AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function UnreferencedStage3Phase5AssetLoader
; ---------------------------------------------------------------------------
UnreferencedStage3Phase5AssetLoadList:  dc.w    7       ; field_0  ; was: stru_11D0A
                                        ; DATA XREF: UnreferencedStage3Phase5AssetLoader+6   o
                dc.l    UnreferencedStage3Phase5TileArt0000  ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage3Phase5MappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    UnreferencedStage3Phase5MappingData4020  ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 3 phase 6 asset list
Stage_LoadStage3Phase6Assets:                           ; DATA XREF: ROM:00011766   o  ; was: sub_11D34
                move.w  #$C,(word_FFA206).w
                lea     Stage3Phase6AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase6Assets
; ---------------------------------------------------------------------------
Stage3Phase6AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_11D46
                                        ; DATA XREF: Stage_LoadStage3Phase6Assets+6   o
                dc.l    Stage3Phase6TileArt0000         ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage3Phase6TileArt1800         ; field_2
                dc.w    $1800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase6MappingData6000     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase6MappingData4020     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase6MappingData6800     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase6AndZLeoEntryMappingData2020  ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase6MappingData7800     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads the Stage 3 phase 7 asset list
Stage_LoadStage3Phase7Assets:                           ; DATA XREF: ROM:00011768   o  ; was: sub_11D90
                move.w  #$C,(word_FFA206).w
                bset    #0,(byte_FF8144).w
                lea     Stage3Phase7AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage3Phase7Assets
; ---------------------------------------------------------------------------
Stage3Phase7AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_11DA8
                                        ; DATA XREF: Stage_LoadStage3Phase7Assets+C   o
                dc.l    Stage3Phase7AndZLeoEndingTileArt0000  ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase7AndZLeoEndingMappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3Phase7AndZLeoEndingMappingData4020  ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage3SharedMappingData7000     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Stage state machine dispatcher
