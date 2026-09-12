Stage_DispatchVisualAssetLoader:                        ; CODE XREF: Camera_UpdateSmooth+E   p  ; was: sub_11DD2
                                        ; Stage_StartTimeBonusAndPreloadNextPhase+12   p
                clr.b   (byte_FFA230).w
                move.w  (StageTableIndex).w,d0
                movea.w Stage_VisualAssetLoaderOffsets(pc,d0.w),a0
                adda.l  #Stage_ExpandAndSubmitTileAssetCommands,a0
                jmp     (a0)
; End of function Stage_DispatchVisualAssetLoader
; ---------------------------------------------------------------------------
Stage_VisualAssetLoaderOffsets: dc.w    Stage_LoadStage1VisualAssets-Stage_ExpandAndSubmitTileAssetCommands  ; was: off_11DE6
                                        ; DATA XREF: Stage_DispatchVisualAssetLoader+8   r
                dc.w    Stage_LoadStage2VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage3VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage4VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage5VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage6VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage7VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage8TrainVisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage9FliesVisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage10VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage11VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage12VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage13Palette-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage14VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage15VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage16VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage17Palettes-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage18VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage19VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage20VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage21VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage22VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage23VisualAssetNoOp-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage_LoadStage24VisualAssets-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage25VisualAssetNoOp-Stage_ExpandAndSubmitTileAssetCommands
                dc.w    Stage26VisualAssetNoOp-Stage_ExpandAndSubmitTileAssetCommands

; Expands compact tile commands into load records and submits the resulting list
Stage_ExpandAndSubmitTileAssetCommands:                 ; CODE XREF: Stage_LoadStage1VisualAssets+12   j  ; was: sub_11E1A
                                        ; Stage_LoadStage2VisualAssets+12   j
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

; Loads the shared palette and compact tile commands for Stage 1
Stage_LoadStage1VisualAssets:                           ; DATA XREF: ROM:Stage_VisualAssetLoaderOffsets   o  ; was: sub_11E86
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage1TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage1VisualAssets
; ---------------------------------------------------------------------------
Stage1TileAssetCommands:    dc.w    0, $6000, 2, $7000, 4, $8000, $FFFF  ; was: word_11E9C
                                        ; DATA XREF: Stage_LoadStage1VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 2
Stage_LoadStage2VisualAssets:                           ; DATA XREF: ROM:00011DE8   o  ; was: sub_11EAA
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage2TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage2VisualAssets
; ---------------------------------------------------------------------------
Stage2TileAssetCommands:    dc.w    0, $6000, 2, $7000, $C, $8000, $FFFF  ; was: word_11EC0
                                        ; DATA XREF: Stage_LoadStage2VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 3
Stage_LoadStage3VisualAssets:                           ; DATA XREF: ROM:00011DEA   o  ; was: sub_11ECE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage3TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage3VisualAssets
; ---------------------------------------------------------------------------
Stage3TileAssetCommands:    dc.w    0, $7000, 8, $8000, $FFFF  ; was: word_11EE4
                                        ; DATA XREF: Stage_LoadStage3VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 4
Stage_LoadStage4VisualAssets:                           ; DATA XREF: ROM:00011DEC   o  ; was: sub_11EEE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage4TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage4VisualAssets
; ---------------------------------------------------------------------------
Stage4TileAssetCommands:    dc.w    0, $7000, 8, $8000, $FFFF  ; was: word_11F04
                                        ; DATA XREF: Stage_LoadStage4VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 5
Stage_LoadStage5VisualAssets:                           ; DATA XREF: ROM:00011DEE   o  ; was: sub_11F0E
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage5TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage5VisualAssets
; ---------------------------------------------------------------------------
Stage5TileAssetCommands:    dc.w    0, $6000, 2, $7000, 6, $8000, $FFFF  ; was: word_11F24
                                        ; DATA XREF: Stage_LoadStage5VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 6
Stage_LoadStage6VisualAssets:                           ; DATA XREF: ROM:00011DF0   o  ; was: sub_11F32
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage6TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage6VisualAssets
; ---------------------------------------------------------------------------
Stage6TileAssetCommands:    dc.w    0, $6000, 2, $7000, 4, $8000, $FFFF  ; was: word_11F48
                                        ; DATA XREF: Stage_LoadStage6VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 7
Stage_LoadStage7VisualAssets:                           ; DATA XREF: ROM:00011DF2   o  ; was: sub_11F56
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage7TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage7VisualAssets
; ---------------------------------------------------------------------------
Stage7TileAssetCommands:    dc.w    0, $6000, 4, $7000, 7, $10, $4F32, $8000, $FFFF  ; was: word_11F6C
                                        ; DATA XREF: Stage_LoadStage7VisualAssets+C   o

; Loads the shared palette and compact tile commands for the Stage 8 train
Stage_LoadStage8TrainVisualAssets:                      ; DATA XREF: ROM:00011DF4   o  ; was: sub_11F7E
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage8TrainTileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage8TrainVisualAssets
; ---------------------------------------------------------------------------
Stage8TrainTileAssetCommands:   dc.w    0, $6000, 7, $11, $63AE, $8000, $FFFF  ; was: word_11F94
                                        ; DATA XREF: Stage_LoadStage8TrainVisualAssets+C   o

; Loads the shared palette and compact tile commands for the Stage 9 flies
Stage_LoadStage9FliesVisualAssets:                      ; DATA XREF: ROM:00011DF6   o  ; was: sub_11FA2
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage9FliesTileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage9FliesVisualAssets
; ---------------------------------------------------------------------------
Stage9FliesTileAssetCommands:   dc.w    $C, $8000, $FFFF  ; DATA XREF: Stage_LoadStage9FliesVisualAssets+C   o  ; was: word_11FB8

; Loads the shared palette and compact tile commands for Stage 10
Stage_LoadStage10VisualAssets:                          ; DATA XREF: ROM:00011DF8   o  ; was: sub_11FBE
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage10TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage10VisualAssets
; ---------------------------------------------------------------------------
Stage10TileAssetCommands:   dc.w    0, $6000, 6, $7000, $A, $8000, $FFFF  ; was: word_11FD4
                                        ; DATA XREF: Stage_LoadStage10VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 11
Stage_LoadStage11VisualAssets:                          ; DATA XREF: ROM:00011DFA   o  ; was: sub_11FE2
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage11TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage11VisualAssets
; ---------------------------------------------------------------------------
Stage11TileAssetCommands:   dc.w    0, $6000, 6, $7000, 4, $8000, $FFFF  ; was: word_11FF8
                                        ; DATA XREF: Stage_LoadStage11VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 12
Stage_LoadStage12VisualAssets:                          ; DATA XREF: ROM:00011DFC   o  ; was: sub_12006
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage12TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage12VisualAssets
; ---------------------------------------------------------------------------
Stage12TileAssetCommands:   dc.w    0, $6000, 6, $7000, $A, $8000, $FFFF  ; was: word_1201C
                                        ; DATA XREF: Stage_LoadStage12VisualAssets+C   o

; Loads the Stage 13 palette command
Stage_LoadStage13Palette:                               ; DATA XREF: ROM:00011DFE   o  ; was: sub_1202A
                lea     (Boss_SnakePaletteCommand).l,a0
                jmp     Gfx_LoadPaletteCommand
; End of function Stage_LoadStage13Palette
; Unreferenced compact command loader for shared tile source zero at $6000
UnreferencedLoadSharedTileSource0To6000:
                lea     UnreferencedSharedTileSource0To6000Command(pc),a0  ; was: sub_12036
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function UnreferencedLoadSharedTileSource0To6000
; ---------------------------------------------------------------------------
UnreferencedSharedTileSource0To6000Command: dc.w    0, $6000, $FFFF  ; DATA XREF: UnreferencedLoadSharedTileSource0To6000   o  ; was: word_12040

; Loads the shared palette and compact tile commands for Stage 14
Stage_LoadStage14VisualAssets:                          ; DATA XREF: ROM:00011E00   o  ; was: sub_12046
                bset    #0,(byte_FF80F8).w
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage14TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage14VisualAssets
; ---------------------------------------------------------------------------
Stage14TileAssetCommands:   dc.w    0, $6000, $FFFF     ; DATA XREF: Stage_LoadStage14VisualAssets+12   o  ; was: word_12062

; Loads the Stage 15 palette and direct tile-asset list
Stage_LoadStage15VisualAssets:                          ; DATA XREF: ROM:00011E02   o  ; was: sub_12068
                bset    #0,(byte_FF80F8).w
                lea     (Stage15PaletteCommands).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage15VisualAssetLoadList(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage15VisualAssets
; ---------------------------------------------------------------------------
Stage15VisualAssetLoadList: dc.w    7                   ; field_0  ; was: stru_12086
                                        ; DATA XREF: Stage_LoadStage15VisualAssets+12   o
                dc.l    tiles_104B22                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Loads the shared palette and compact tile commands for Stage 16
Stage_LoadStage16VisualAssets:                          ; DATA XREF: ROM:00011E04   o  ; was: sub_12090
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage16TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage16VisualAssets
; ---------------------------------------------------------------------------
Stage16TileAssetCommands:   dc.w    $C, $6000, 7, $12, $3172, $7000, $FFFF  ; was: word_120A6
                                        ; DATA XREF: Stage_LoadStage16VisualAssets+C   o

; Loads palettes for stage 17
Stage_LoadStage17Palettes:                              ; DATA XREF: ROM:00011E06   o  ; was: sub_120B4
                lea     (Stage17PaletteCommandBank).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     (Boss_Epsilon1PaletteCommands).l,a0
                jmp     Gfx_LoadPalettePreservingSharedColor
; End of function Stage_LoadStage17Palettes
; Loads the shared palette and compact tile commands for Stage 18
Stage_LoadStage18VisualAssets:                          ; DATA XREF: ROM:00011E08   o  ; was: sub_120CC
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage18TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage18VisualAssets
; ---------------------------------------------------------------------------
Stage18TileAssetCommands:   dc.w    $C, $6000, 7, $10, $5B9E, $7000, $FFFF  ; was: word_120E2
                                        ; DATA XREF: Stage_LoadStage18VisualAssets+C   o

; Loads the shared palette and compact tile commands for Stage 19
Stage_LoadStage19VisualAssets:                          ; DATA XREF: ROM:00011E0A   o  ; was: sub_120F0
                lea     (SharedStagePaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Stage19TileAssetCommands(pc),a0
                nop
                bra.w   Stage_ExpandAndSubmitTileAssetCommands
; End of function Stage_LoadStage19VisualAssets
; ---------------------------------------------------------------------------
Stage19TileAssetCommands:   dc.w    6, $6000, $C, $7000, $FFFF  ; was: word_12106
                                        ; DATA XREF: Stage_LoadStage19VisualAssets+C   o

UnreferencedVisualAssetNoOpBeforeStage20:               ; was: nullsub_138
                rts
; End of function UnreferencedVisualAssetNoOpBeforeStage20

; Loads the direct tile-asset list for Stage 20
Stage_LoadStage20VisualAssets:                          ; DATA XREF: ROM:00011E0C   o  ; was: sub_12112
                lea     Stage20VisualAssetLoadList(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage20VisualAssets
; ---------------------------------------------------------------------------
Stage20VisualAssetLoadList: dc.w    7                   ; field_0  ; was: stru_1211E
                                        ; DATA XREF: Stage_LoadStage20VisualAssets   o
                dc.l    tiles_132E9A                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Loads the direct tile-asset list for Stage 21
Stage_LoadStage21VisualAssets:                          ; DATA XREF: ROM:00011E0E   o  ; was: sub_12128
                lea     Stage21VisualAssetLoadList(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage21VisualAssets
; ---------------------------------------------------------------------------
Stage21VisualAssetLoadList: dc.w    7                   ; field_0  ; was: stru_12134
                                        ; DATA XREF: Stage_LoadStage21VisualAssets   o
                dc.l    tiles_1CE516                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Loads the direct tile-asset list for Stage 22
Stage_LoadStage22VisualAssets:                          ; DATA XREF: ROM:00011E10   o  ; was: sub_1213E
                lea     Stage22VisualAssetLoadList(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage22VisualAssets
; ---------------------------------------------------------------------------
Stage22VisualAssetLoadList: dc.w    7                   ; field_0  ; was: stru_1214A
                                        ; DATA XREF: Stage_LoadStage22VisualAssets   o
                dc.l    tiles_105196                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Deliberate no-op visual loader for Stage 23
Stage23VisualAssetNoOp:                                 ; DATA XREF: ROM:00011E12   o  ; was: nullsub_30
                rts
; End of function Stage23VisualAssetNoOp
; Loads the direct tile-asset list for Stage 24
Stage_LoadStage24VisualAssets:                          ; DATA XREF: ROM:00011E14   o  ; was: sub_12156
                lea     Stage24VisualAssetLoadList(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_LoadStage24VisualAssets
; ---------------------------------------------------------------------------
Stage24VisualAssetLoadList: dc.w    7                   ; field_0  ; was: stru_12162
                                        ; DATA XREF: Stage_LoadStage24VisualAssets   o
                dc.l    tiles_105196                    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Unreferenced duplicate loader for the Stage 20 tile asset
UnreferencedReloadStage20TileAsset:
                lea     UnreferencedStage20TileReloadList(pc),a0  ; was: sub_1216C
                nop
                jmp     (Data_ProcessPointer).l
; End of function UnreferencedReloadStage20TileAsset
; ---------------------------------------------------------------------------
UnreferencedStage20TileReloadList:  dc.w    7           ; field_0  ; was: stru_12178
                                        ; DATA XREF: UnreferencedReloadStage20TileAsset   o
                dc.l    tiles_132E9A                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

UnreferencedVisualAssetNoOpBeforeSecondaryLoader:       ; was: nullsub_33
                rts
; End of function UnreferencedVisualAssetNoOpBeforeSecondaryLoader

; Deliberate no-op visual loader for Stage 25
Stage25VisualAssetNoOp:                                 ; DATA XREF: ROM:00011E16   o  ; was: nullsub_31
                rts
; End of function Stage25VisualAssetNoOp
; Deliberate no-op visual loader for Stage 26
Stage26VisualAssetNoOp:                                 ; DATA XREF: ROM:00011E18   o  ; was: nullsub_32
                rts
; End of function Stage26VisualAssetNoOp
; Unreferenced direct loader for one shared gameplay tile asset
UnreferencedLoadSharedGameplayTileAsset:
                lea     UnreferencedSharedGameplayTileAssetLoadList(pc),a0  ; was: sub_12188
                nop
                jmp     (Data_ProcessPointer).l
; End of function UnreferencedLoadSharedGameplayTileAsset
; ---------------------------------------------------------------------------
UnreferencedSharedGameplayTileAssetLoadList:    dc.w    7  ; field_0  ; was: stru_12194
                                        ; DATA XREF: UnreferencedLoadSharedGameplayTileAsset   o
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
