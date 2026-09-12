Stage_DispatchVisualAssetLoader:                        ; CODE XREF: Camera_UpdateSmooth+E   p  ; was: sub_11DD2
                                        ; Stage_StartTimeBonusAndPreloadNextPhase+12   p
                clr.b   (byte_FFA230).w
                move.w  (StageTableIndex).w,d0
                movea.w Stage_VisualAssetLoaderOffsets(pc,d0.w),a0
                adda.l  #Stage_ExpandAndSubmitTileAssetCommands,a0
                jmp     (a0)
; End of function Stage_DispatchVisualAssetLoader
; ---------------------------------------------------------------------------
Stage_VisualAssetLoaderOffsets: dc.w    Gfx_LoadStagePalette-Stage_ExpandAndSubmitTileAssetCommands  ; was: off_11DE6
                                        ; DATA XREF: Stage_DispatchVisualAssetLoader+8   r
                dc.w    Stage_LoadVisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage3Assets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadPaletteAndTilesA-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadPaletteAndTilesB-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage6Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage7Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadTrainGraphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadFliesGraphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage10Assets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage11Assets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage12Assets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Gfx_LoadSnakePalette-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage14Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage5Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage17Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Gfx_LoadStage17Palettes-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Gfx_Stage18Background-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Gfx_LoadStage19Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Gfx_LoadStage20Graphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadTiles1-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage22_LoadGraphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Weapon_EmptyState0-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage24_LoadGraphics-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Weapon_EmptyState1-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Weapon_EmptyState2-Stage_ExpandAndSubmitTileAssetCommands

; Expands compact tile commands into load records and submits the resulting list
Stage_ExpandAndSubmitTileAssetCommands:                 ; CODE XREF: Gfx_LoadStagePalette+12   j  ; was: sub_11E1A
                                        ; Stage_LoadVisualAssets+12   j
                movea.w #(byte_FF82A0-M68K_RAM),a1
                movea.w #(word_FF826E-M68K_RAM),a2
                lea     Stage_SharedTileSourceTable(pc),a3
                nop
Stage_ReadNextTileAssetCommand:                         ; CODE XREF: Stage_ExpandAndSubmitTileAssetCommands+1E   j  ; was: loc_11E28
                                        ; Stage_ExpandAndSubmitTileAssetCommands+3E   j
                move.w  (a0)+,d0
                bmi.s   Stage_TerminateAndSubmitExpandedAssetList
                btst    #0,d0
                beq.s   Stage_ExpandIndexedTileAssetCommand
                move.w  d0,(a1)+
                move.l  (a0)+,(a1)+
                move.w  (a0)+,(a1)+
                bra.w   Stage_ReadNextTileAssetCommand
; ---------------------------------------------------------------------------
Stage_ExpandIndexedTileAssetCommand:                    ; CODE XREF: Stage_ExpandAndSubmitTileAssetCommands+16   j  ; was: loc_11E3C
                move.w  d0,d1
                asl.w   #1,d1
                move.w  (a0)+,d2
                move.w  #7,(a1)+
                move.l  (a3,d1.w),(a1)+
                move.w  d2,(a1)+
                lsr.w   #5,d2
                move.w  d2,(a2,d0.w)
                ori.w   #$800,(a2,d0.w)
                bra.w   Stage_ReadNextTileAssetCommand
; ---------------------------------------------------------------------------
; Terminates the expanded record list and submits it to the pointer processor
Stage_TerminateAndSubmitExpandedAssetList:              ; CODE XREF: Stage_ExpandAndSubmitTileAssetCommands+10   j  ; was: loc_11E5C
                move.w  #$FFFF,(a1)
                movea.w #(byte_FF82A0-M68K_RAM),a0
                jmp     (Data_ProcessPointer).l
; End of function Stage_ExpandAndSubmitTileAssetCommands
; ---------------------------------------------------------------------------
Stage_SharedTileSourceTable:    dc.l    tiles_1001D6    ; DATA XREF: Stage_ExpandAndSubmitTileAssetCommands+8   o  ; was: off_11E6A
                dc.l    tiles_100DA2
                dc.l    tiles_1018F0
                dc.l    tiles_10213C
                dc.l    tiles_102AE0
                dc.l    tiles_103124
                dc.l    tiles_103A26

; Loads stage palette data
Gfx_LoadStagePalette:                                   ; DATA XREF: ROM:Stage_VisualAssetLoaderOffsets   o  ; was: sub_11E86
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11E9C(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Gfx_LoadStagePalette
; ---------------------------------------------------------------------------
word_11E9C:     dc.w    0, $6000, 2, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Gfx_LoadStagePalette+C   o

; Loads stage palette and tile data
Stage_LoadVisualAssets:                                 ; DATA XREF: ROM:00011DE8   o  ; was: sub_11EAA
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11EC0(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadVisualAssets
; ---------------------------------------------------------------------------
word_11EC0:     dc.w    0, $6000, 2, $7000, $C, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadVisualAssets+C   o

; Loads Stage 3 palette and tile graphics
Stage_LoadStage3Assets:                                 ; DATA XREF: ROM:00011DEA   o  ; was: sub_11ECE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11EE4(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage3Assets
; ---------------------------------------------------------------------------
word_11EE4:     dc.w    0, $7000, 8, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage3Assets+C   o

; Loads stage 5 palette and first tileset via DMA
Stage_LoadPaletteAndTilesA:                             ; DATA XREF: ROM:00011DEC   o  ; was: sub_11EEE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11F04(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadPaletteAndTilesA
; ---------------------------------------------------------------------------
word_11F04:     dc.w    0, $7000, 8, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadPaletteAndTilesA+C   o

; Loads stage 5 palette and second tileset via DMA
Stage_LoadPaletteAndTilesB:                             ; DATA XREF: ROM:00011DEE   o  ; was: sub_11F0E
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11F24(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadPaletteAndTilesB
; ---------------------------------------------------------------------------
word_11F24:     dc.w    0, $6000, 2, $7000, 6, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadPaletteAndTilesB+C   o

; Loads Stage 6 palette and tile graphics data to VRAM
Stage_LoadStage6Graphics:                               ; DATA XREF: ROM:00011DF0   o  ; was: sub_11F32
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11F48(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage6Graphics
; ---------------------------------------------------------------------------
word_11F48:     dc.w    0, $6000, 2, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage6Graphics+C   o

; Loads Stage 7 palette and tile graphics data to VRAM
Stage_LoadStage7Graphics:                               ; DATA XREF: ROM:00011DF2   o  ; was: sub_11F56
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11F6C(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage7Graphics
; ---------------------------------------------------------------------------
word_11F6C:     dc.w    0, $6000, 4, $7000, 7, $10, $4F32, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage7Graphics+C   o

; Loads train stage tile graphics to VRAM
Stage_LoadTrainGraphics:                                ; DATA XREF: ROM:00011DF4   o  ; was: sub_11F7E
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11F94(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadTrainGraphics
; ---------------------------------------------------------------------------
word_11F94:     dc.w    0, $6000, 7, $11, $63AE, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadTrainGraphics+C   o

; Loads palette and tile graphics for flies stage
Stage_LoadFliesGraphics:                                ; DATA XREF: ROM:00011DF6   o  ; was: sub_11FA2
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11FB8(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadFliesGraphics
; ---------------------------------------------------------------------------
word_11FB8:     dc.w    $C, $8000, $FFFF                ; DATA XREF: Stage_LoadFliesGraphics+C   o

; Loads palette and tile graphics for Stage 10
Stage_LoadStage10Assets:                                ; DATA XREF: ROM:00011DF8   o  ; was: sub_11FBE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11FD4(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage10Assets
; ---------------------------------------------------------------------------
word_11FD4:     dc.w    0, $6000, 6, $7000, $A, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage10Assets+C   o

; Loads palette and tile assets
Stage_LoadStage11Assets:                                ; DATA XREF: ROM:00011DFA   o  ; was: sub_11FE2
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_11FF8(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage11Assets
; ---------------------------------------------------------------------------
word_11FF8:     dc.w    0, $6000, 6, $7000, 4, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage11Assets+C   o

; Loads Stage 12 palette and tiles
Stage_LoadStage12Assets:                                ; DATA XREF: ROM:00011DFC   o  ; was: sub_12006
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_1201C(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage12Assets
; ---------------------------------------------------------------------------
word_1201C:     dc.w    0, $6000, 6, $7000, $A, $8000, $FFFF
                                        ; DATA XREF: Stage_LoadStage12Assets+C   o

; Loads Snake boss palette
Gfx_LoadSnakePalette:                                   ; DATA XREF: ROM:00011DFE   o  ; was: sub_1202A
                lea     (Boss_SnakePaletteCommand).l,a0
                jmp     Gfx_LoadPaletteCommand
; End of function Gfx_LoadSnakePalette
; Loads tile data for Stage 4 at VRAM $6000
Gfx_LoadStage4Tiles:
                lea     word_12040(pc),a0               ; was: sub_12036
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Gfx_LoadStage4Tiles
; ---------------------------------------------------------------------------
word_12040:     dc.w    0, $6000, $FFFF                 ; DATA XREF: Gfx_LoadStage4Tiles   o

; Loads Stage 14 graphics
Stage_LoadStage14Graphics:                              ; DATA XREF: ROM:00011E00   o  ; was: sub_12046
                bset    #0,(byte_FF80F8).w
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_12062(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage14Graphics
; ---------------------------------------------------------------------------
word_12062:     dc.w    0, $6000, $FFFF                 ; DATA XREF: Stage_LoadStage14Graphics+12   o

; Loads Stage 5 palette and graphics data
Stage_LoadStage5Graphics:                               ; DATA XREF: ROM:00011E02   o  ; was: sub_12068
                bset    #0,(byte_FF80F8).w
                lea     (Stage5PaletteCommands).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     stru_12086(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage5Graphics
; ---------------------------------------------------------------------------
stru_12086:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadStage5Graphics+12   o
                dc.l    tiles_104B22                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Loads Stage 17 graphics
Stage_LoadStage17Graphics:                              ; DATA XREF: ROM:00011E04   o  ; was: sub_12090
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_120A6(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage17Graphics
; ---------------------------------------------------------------------------
word_120A6:     dc.w    $C, $6000, 7, $12, $3172, $7000, $FFFF
                                        ; DATA XREF: Stage_LoadStage17Graphics+C   o

; Loads palettes for stage 17
Gfx_LoadStage17Palettes:                                ; DATA XREF: ROM:00011E06   o  ; was: sub_120B4
                lea     (Stage17PaletteCommandBank).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     (Boss_Epsilon1PaletteCommands).l,a0
                jmp     Gfx_LoadPalettePreservingSharedColor
; End of function Gfx_LoadStage17Palettes
; Background graphics setup
Gfx_Stage18Background:                                  ; DATA XREF: ROM:00011E08   o  ; was: sub_120CC
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_120E2(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Gfx_Stage18Background
; ---------------------------------------------------------------------------
word_120E2:     dc.w    $C, $6000, 7, $10, $5B9E, $7000, $FFFF
                                        ; DATA XREF: Gfx_Stage18Background+C   o

; Loads Stage 19 graphics
Gfx_LoadStage19Graphics:                                ; DATA XREF: ROM:00011E0A   o  ; was: sub_120F0
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     word_12106(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Gfx_LoadStage19Graphics
; ---------------------------------------------------------------------------
word_12106:     dc.w    6, $6000, $C, $7000, $FFFF
                                        ; DATA XREF: Gfx_LoadStage19Graphics+C   o

nullsub_138:
                rts
; End of function nullsub_138

; Loads Stage 20 graphics
Gfx_LoadStage20Graphics:                                ; DATA XREF: ROM:00011E0C   o  ; was: sub_12112
                lea     stru_1211E(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Gfx_LoadStage20Graphics
; ---------------------------------------------------------------------------
stru_1211E:     dc.w    7                               ; field_0
                                        ; DATA XREF: Gfx_LoadStage20Graphics   o
                dc.l    tiles_132E9A                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Loads stage tiles 1
Stage_LoadTiles1:                                       ; DATA XREF: ROM:00011E0E   o  ; was: sub_12128
                lea     stru_12134(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadTiles1
; ---------------------------------------------------------------------------
stru_12134:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_LoadTiles1   o
                dc.l    tiles_1CE516                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Loads stage graphics
Stage22_LoadGraphics:                                   ; DATA XREF: ROM:00011E10   o  ; was: sub_1213E
                lea     stru_1214A(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage22_LoadGraphics
; ---------------------------------------------------------------------------
stru_1214A:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage22_LoadGraphics   o
                dc.l    tiles_105196                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Empty weapon system state handler
Weapon_EmptyState0:                                     ; DATA XREF: ROM:00011E12   o  ; was: nullsub_30
                rts
; End of function Weapon_EmptyState0
; Loads stage graphics
Stage24_LoadGraphics:                                   ; DATA XREF: ROM:00011E14   o  ; was: sub_12156
                lea     stru_12162(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage24_LoadGraphics
; ---------------------------------------------------------------------------
stru_12162:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage24_LoadGraphics   o
                dc.l    tiles_105196                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Initializes graphics data structure pointer 1
Data_InitGraphicsStruct1:
                lea     stru_12178(pc),a0               ; was: sub_1216C
                nop
                jmp     (Data_ProcessPointer).l
; End of function Data_InitGraphicsStruct1
; ---------------------------------------------------------------------------
stru_12178:     dc.w    7                               ; field_0
                                        ; DATA XREF: Data_InitGraphicsStruct1   o
                dc.l    tiles_132E9A                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

nullsub_33:
                rts
; End of function nullsub_33

; Empty weapon system state handler
Weapon_EmptyState1:                                     ; DATA XREF: ROM:00011E16   o  ; was: nullsub_31
                rts
; End of function Weapon_EmptyState1
; Empty weapon system state handler
Weapon_EmptyState2:                                     ; DATA XREF: ROM:00011E18   o  ; was: nullsub_32
                rts
; End of function Weapon_EmptyState2
; Initializes graphics data structure pointer 2
Data_InitGraphicsStruct2:
                lea     stru_12194(pc),a0               ; was: sub_12188
                nop
                jmp     (Data_ProcessPointer).l
; End of function Data_InitGraphicsStruct2
; ---------------------------------------------------------------------------
stru_12194:     dc.w    7                               ; field_0
                                        ; DATA XREF: Data_InitGraphicsStruct2   o
                dc.l    tiles_FEB6E                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Loads Xi-Tiger boss tile graphics
Stage_LoadXiTigerGraphics:                              ; CODE XREF: Stage_XiTigerHandler+22   p  ; was: sub_1219E
                clr.w   (word_FF807A).w
                jsr     (Stage_InitializationNoOpHook).l
                bsr.w   Sys_ClearRAMBuffer
                clr.w   (word_FFFF3E).w
                move.w  (WeaponStateIndex).w,d0
                beq.s   loc_121C4
                cmpi.w  #$10,d0
                bpl.s   loc_121C4
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bra.s   loc_121D0
; ---------------------------------------------------------------------------
loc_121C4:                                              ; CODE XREF: Stage_LoadXiTigerGraphics+16   j
                                        ; Stage_LoadXiTigerGraphics+1C   j
                move.w  #2,(WeaponStateIndex).w
                move.w  #4,(word_FFA21E).w
loc_121D0:                                              ; CODE XREF: Stage_LoadXiTigerGraphics+24   j
                bsr.s   Stage_LoadXiTigerPalette
                jsr     (Gfx_ProcessPaletteSlots).l
                jmp     Player_InitializeStats
; End of function Stage_LoadXiTigerGraphics
; Loads Xi-Tiger boss palette
Stage_LoadXiTigerPalette:                               ; CODE XREF: Stage_LoadXiTigerGraphics:loc_121D0   p  ; was: sub_121DE
                move.w  (word_FF814C).w,d0
                movea.w off_121EE(pc,d0.w),a0
                adda.l  #Stage_LoadXiTigerSprites,a0
                jmp     (a0)
; End of function Stage_LoadXiTigerPalette
; ---------------------------------------------------------------------------
off_121EE:      dc.w    Stage_LoadXiTigerSprites-Stage_LoadXiTigerSprites
                                        ; DATA XREF: Stage_LoadXiTigerPalette+4   r

; Loads Xi-Tiger sprite data to VRAM
Stage_LoadXiTigerSprites:                               ; DATA XREF: Stage_LoadXiTigerPalette+8   o  ; was: sub_121F0
                                        ; ROM:off_121EE   o
                lea     stru_121FE(pc),a0
                nop
                bsr.w   Stage_ApplyConfigurationRecord
                bra.w   loc_1233A
; End of function Stage_LoadXiTigerSprites
; ---------------------------------------------------------------------------
stru_121FE:     dc.w    $76                             ; field_0
                                        ; DATA XREF: Stage_LoadXiTigerSprites   o
                dc.l    $80000000                       ; field_2
                dc.w    0                               ; field_6
                dc.b    0                               ; field_8
                dc.b    0                               ; field_9
                dc.w    $8000                           ; field_A
                dc.w    $800                            ; field_C
                dc.w    0                               ; field_E
                dc.w    0                               ; field_10
                dc.w    0                               ; field_12
                dc.w    8                               ; field_14
                dc.w    0                               ; field_16
                dc.b    $F0                             ; field_18
                dc.b    $A8                             ; field_19
                dc.l    Stage8AlternatePaletteOffsetList  ; field_1A

; Initializes stage state including RAM clear and player stats
