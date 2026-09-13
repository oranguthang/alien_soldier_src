Stage_LoadAssetsForCurrentTableIndex:                   ; CODE XREF: StageReady_Initialize+16   p  ; was: sub_11722
                                        ; RetryPrompt_Initialize+10   p
                bsr.w   Stage_LoadSharedMappings
                move.w  (StageTableIndex).w,d0
                movea.w Stage_AssetLoaderOffsets(pc,d0.w),a0
                adda.l  #Stage_LoadSharedMappings,a0
                jmp     (a0)
; End of function Stage_LoadAssetsForCurrentTableIndex
; ---------------------------------------------------------------------------
Stage_AssetLoaderOffsets:   dc.w    Stage_LoadStage1BaseAssets-Stage_LoadSharedMappings  ; was: off_11736
                                        ; DATA XREF: Stage_LoadAssetsForCurrentTableIndex+8   r
                dc.w    Stage_LoadStage1BaseAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1BaseAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1Phase1Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1Phase2Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1Phase2Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1Phase2Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage8Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage1Phase3Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage10EnemyAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage10EnemyAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage10EnemyAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadTeleportAssets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage16Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage16Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage16Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage2Phase1Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage18Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage18Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage20Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase2Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase2Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase1Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase3Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase6Assets-Stage_LoadSharedMappings
                dc.w    Stage_LoadStage3Phase7Assets-Stage_LoadSharedMappings

; Loads the shared type-7 mappings record used by every table-index entry
Stage_LoadSharedMappings:                               ; CODE XREF: Stage_LoadAssetsForCurrentTableIndex   p  ; was: sub_1176A
                                        ; DATA XREF: Stage_LoadAssetsForCurrentTableIndex+C   o
                lea     Stage_SharedMappingsLoadList(pc),a0
                nop
                jmp     (LoadObjData).l
; End of function Stage_LoadSharedMappings
; ---------------------------------------------------------------------------
Stage_SharedMappingsLoadList:   dc.w    7               ; field_0  ; was: stru_11776
                                        ; DATA XREF: Stage_LoadSharedMappings   o
                dc.l    SharedGameplayTileArtD000       ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Loads the base Stage 1 (Xi-Tiger) asset list
Stage_LoadStage1BaseAssets:                             ; CODE XREF: Stage_LoadStage1Phase1Assets+4   p  ; was: sub_11780
                                        ; DATA XREF: ROM:Stage_AssetLoaderOffsets   o
                clr.w   (StageProcessTableOffset).w
                lea     Stage1BaseAssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1BaseAssets
; ---------------------------------------------------------------------------
Stage1BaseAssetLoadList:    dc.w    7                   ; field_0  ; was: stru_11790
                                        ; DATA XREF: Stage_LoadStage1BaseAssets+4   o
                dc.l    Stage1BaseTileArt0              ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1BaseTileArt1              ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1AndShellshogunSharedTileArt  ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1BaseMappingData6000       ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1BaseMappingData4000       ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1BaseMappingData6800       ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1BaseMappingData2000       ; field_2
                dc.w    $2000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1BaseMappingData7800       ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads initial object set for Stage 1 phase 1
Stage_LoadStage1Phase1Assets:                           ; DATA XREF: ROM:0001173C   o  ; was: sub_117E2
                clr.w   (StageProcessTableOffset).w
                bsr.w   Stage_LoadStage1BaseAssets
                lea     Stage1Phase1AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase1Assets
; ---------------------------------------------------------------------------
Stage1Phase1AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_117F6
                                        ; DATA XREF: Stage_LoadStage1Phase1Assets+8   o
                dc.l    Stage1Phase1AndShellshogunTileArt  ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1AndShellshogunSharedTileArt  ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase1AndShellshogunMappingData6800  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase1AndShellshogunMappingData2000  ; field_2
                dc.w    $2000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF
Boss_ShellshogunAssetLoadList:  dc.w    7               ; field_0  ; was: stru_11820
                                        ; DATA XREF: Camera_ShellshogunBossInit+26   o
                dc.l    Stage1Phase1AndShellshogunTileArt  ; field_2
                dc.w    $2B80                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1AndShellshogunSharedTileArt  ; field_2
                dc.w    $5AC0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase1AndShellshogunMappingData6800  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase1AndShellshogunMappingData2000  ; field_2
                dc.w    $2000                           ; field_6
                dc.w    $FFFF

; Loads object set for Stage 1 phase 2
Stage_LoadStage1Phase2Assets:                           ; DATA XREF: ROM:0001173E   o  ; was: sub_11842
                                        ; ROM:00011740   o
                clr.w   (StageProcessTableOffset).w
                lea     Stage1Phase2AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase2Assets
; ---------------------------------------------------------------------------
Stage1Phase2AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_11852
                                        ; DATA XREF: Stage_LoadStage1Phase2Assets+4   o
                dc.l    Stage1Phase2TileArt0            ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1Phase2TileArt1            ; field_2
                dc.w    $5BE0                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase2MappingData6000     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase2MappingData4000     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase2MappingData7800     ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads assets for Stage 8 (train/Flying-Neo)
Stage_LoadStage8Assets:                                 ; DATA XREF: ROM:00011744   o  ; was: sub_1188C
                clr.w   (StageProcessTableOffset).w
                lea     Stage8AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage8Assets
; ---------------------------------------------------------------------------
Stage8AssetLoadList:    dc.w    7                       ; field_0  ; was: stru_1189C
                                        ; DATA XREF: Stage_LoadStage8Assets+4   o
                dc.l    Stage1Phase3AndStage8TileArt0   ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1Phase3AndStage8TileArt1   ; field_2
                dc.w    $3AC0                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1Phase3AndStage8TileArt2   ; field_2
                dc.w    $3D00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3AndStage8MappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3AndStage8MappingData4000  ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads object set for Stage 1 phase 3
Stage_LoadStage1Phase3Assets:                           ; DATA XREF: ROM:00011746   o  ; was: sub_118D6
                clr.w   (StageProcessTableOffset).w
                lea     Stage1Phase3AssetLoadList(pc),a0
                nop
                jmp     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
; ---------------------------------------------------------------------------
                nop
; End of function Stage_LoadStage1Phase3Assets
; ---------------------------------------------------------------------------
Stage1Phase3AssetLoadList:  dc.w    7                   ; field_0  ; was: stru_118E6
                                        ; DATA XREF: Stage_LoadStage1Phase3Assets+4   o
                dc.l    Stage1Phase3AndStage8TileArt0   ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1Phase3AndStage8TileArt1   ; field_2
                dc.w    $3AC0                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage1Phase3AndStage8TileArt2   ; field_2
                dc.w    $3D00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3AndStage8MappingData6000  ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3AndStage8MappingData4000  ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3MappingData6800     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3MappingData2020     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage1Phase3AndStage8TileArt1   ; field_2
                dc.w    $9600                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads Stage 10 enemy configuration
Stage_LoadStage10EnemyAssets:                           ; DATA XREF: ROM:00011748   o  ; was: sub_11938
                                        ; ROM:0001174A   o
                move.w  #4,(StageProcessTableOffset).w
                lea     Stage10EnemyAssetLoadList(pc),a0
                nop
                jsr     Stage_DispatchAssetListLoaderByGameMode(pc)  ; (pc)
                nop
                lea     Stage10EnemyTileBlockAdjustmentDescriptor(pc),a0
                nop
                move.w  #$A000,d0
                jmp     Gfx_AdjustSelectedTileBlocks
; End of function Stage_LoadStage10EnemyAssets
; ---------------------------------------------------------------------------
Stage10EnemyAssetLoadList:  dc.w    7                   ; field_0  ; was: stru_1195A
                                        ; DATA XREF: Stage_LoadStage10EnemyAssets+6   o
                dc.l    Stage10AndTeleportTileArt0000   ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage10AndTeleportTileArt4000   ; field_2
                dc.w    $4000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage10EnemyTileArt0            ; field_2
                dc.w    $3720                           ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage10EnemyTileArt1            ; field_2
                dc.w    $1840                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10EnemyMappingData6000     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10EnemyMappingData4020     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10AndTeleportMappingData6800  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10AndTeleportMappingData2020  ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10TeleportSharedAssetData  ; field_2
                dc.w    $7800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF
Stage10EnemyTileBlockAdjustmentDescriptor:  dc.b    $40, 0, $D1, $D2, $D3, $D5, $D6, $D7, $DC, $E4  ; was: byte_119BC
                                        ; DATA XREF: Stage_LoadStage10EnemyAssets+12   o
                dc.b    $FF, 0

; Loads the teleport-scene asset list and initializes its tile-loop parameters
Stage_LoadTeleportAssets:                               ; CODE XREF: Stage12To13_UpdateTeleportFadeIn+64   p  ; was: sub_119C8
                                        ; DATA XREF: ROM:0001174E   o
                move.w  #4,(StageProcessTableOffset).w
                lea     TeleportAssetLoadList(pc),a0
                nop
                jsr     (LoadObjData).l
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                movea.w #(TileInterpSourceB-M68K_RAM),a1
                move.w  #$6000,(word_FF8048).w
                move.w  #$F,(word_FF804A).w
                move.w  #1,(dword_FF8044+2).w
                jmp     Gfx_LoadTilesLoop
; End of function Stage_LoadTeleportAssets
; ---------------------------------------------------------------------------
TeleportAssetLoadList:  dc.w    7                       ; field_0  ; was: stru_119FA
                                        ; DATA XREF: Stage_LoadTeleportAssets+6   o
                dc.l    Stage10AndTeleportTileArt0000   ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage12AndTeleportTileArt0000   ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    Stage10AndTeleportTileArt4000   ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    TeleportMappingData6000         ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    TeleportMappingData4020         ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10AndTeleportMappingData6800  ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10AndTeleportMappingData2020  ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    SharedMappingData7000           ; field_2
                dc.w    $7400                           ; field_6
                dc.w    6                               ; field_0
                dc.l    Stage10TeleportSharedAssetData  ; field_2
                dc.w    $7800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    TeleportTileArt                 ; field_2
                dc.w    $9600                           ; field_6
                dc.w    7                               ; field_0
                dc.l    SharedSceneAndStageTileArt9000  ; field_2
                dc.w    $9000                           ; field_6
                dc.w    $FFFF

; Loads object data for stage 16/17 (Sylpheed)
