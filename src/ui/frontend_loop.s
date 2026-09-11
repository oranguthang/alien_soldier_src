UI_InitializeResultsScreen:                             ; DATA XREF: Sys_DispatchGameState+5A   o  ; was: sub_1CE7E
                tst.w   (GameSubstateIndex).w
                bne.s   UI_LoadResultsPalette
                jsr     (Sys_InitGameMode).l
                movea.l #stru_1CEFC,a0
                jsr     (LoadObjData).l
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (VDPReg18Shadow+1).w
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                rts
; ---------------------------------------------------------------------------
; Loads palette and data tables for results screen
UI_LoadResultsPalette:                                  ; CODE XREF: UI_InitializeResultsScreen+4   j  ; was: loc_1CEB6
                move.w  #8,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$F0,(word_FF8100).w
                move.w  #0,d0
                move.w  #0,d1
                jsr     (Data_LoadPointerTable1).l
                move.w  #0,d0
                move.w  #0,d1
                jsr     (Data_LoadPointerTable2).l
                movea.l #EarlyStagePaletteOffsetList,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                rts
; End of function UI_InitializeResultsScreen
; ---------------------------------------------------------------------------
stru_1CEFC:     dc.w    7                               ; field_0
                                        ; DATA XREF: UI_InitializeResultsScreen+C   o
                dc.l    byte_18140E                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Main game loop update with object processing
Sys_UpdateGameLoop:                                     ; DATA XREF: Sys_DispatchGameState+5E   o  ; was: sub_1CF16
                tst.w   (word_FFF720).w
                bmi.s   loc_1CF2E
                cmpi.w  #4,(GameSubstateIndex).w
                bcs.s   loc_1CF2E
                btst    #7,(word_FFF708).w
                bne.w   loc_1D3A8
loc_1CF2E:                                              ; CODE XREF: Sys_UpdateGameLoop+4   j
                                        ; Sys_UpdateGameLoop+C   j
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sprite_InitializePriorityBuckets).l
                jsr     (Sys_BeginVisibleObjectList).l
                jsr     (Sys_ProcessVisibleObjects).l
                bsr.w   UI_DispatchMenuState
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sprite_RenderObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                addq.w  #1,(FrameCounter).w
                rts
; End of function Sys_UpdateGameLoop
; Dispatches to menu state handler based on index
UI_DispatchMenuState:                                   ; CODE XREF: Sys_UpdateGameLoop+30   p  ; was: sub_1CF62
                move.w  (GameSubstateIndex).w,d0
                movea.w off_1CF72(pc,d0.w),a0
                adda.l  #UI_InitializeSEGAScreen,a0
                jmp     (a0)
; End of function UI_DispatchMenuState
; ---------------------------------------------------------------------------
off_1CF72:      dc.w    UI_InitializeSEGAScreen-UI_InitializeSEGAScreen
                                        ; DATA XREF: UI_DispatchMenuState+4   r
                dc.w    UI_DispatchCutsceneState-UI_InitializeSEGAScreen
                dc.w    UI_InitializeTitleScreen-UI_InitializeSEGAScreen
                dc.w    UI_DispatchStoryState-UI_InitializeSEGAScreen
                dc.w    Stage_InitializeTransition-UI_InitializeSEGAScreen
                dc.w    Stage_SetupScrollPlanesThunk-UI_InitializeSEGAScreen
                dc.w    Cutscene_InitializeScene-UI_InitializeSEGAScreen
                dc.w    Cutscene_HandleScrollInput-UI_InitializeSEGAScreen

; Initializes SEGA logo screen with graphics and palettes
UI_InitializeSEGAScreen:                                ; DATA XREF: UI_DispatchMenuState+8   o  ; was: sub_1CF82
                                        ; ROM:off_1CF72   o
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                jsr     (Gfx_QueueLargeFontDMACommand81).l
                lea     (FrontendFullPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                movea.l #Frontend_TitleAssetLoadDescriptors,a0
                jsr     (LoadObjData).l
                movea.l #$FFFF2020,a0
                move.w  #$8000,d0
                move.w  #$FF00,d1
                move.w  #$BF,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                bsr.w   Gfx_CopyPaletteLines
                lea     (dword_FF4000).l,a0
                move.w  #$7FF,d0
loc_1CFD0:                                              ; CODE XREF: UI_InitializeSEGAScreen+58   j
                move.l  (a0),d1
                ori.l   #$E000E000,d1
                move.l  d1,(a0)+
                dbf     d0,loc_1CFD0
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr     (Gfx_DirectVRAMTransfer).l
                lea     (M68K_RAM).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #$F,d1
loc_1D006:                                              ; CODE XREF: UI_InitializeSEGAScreen+86   j
                move.l  d0,(a0)+
                dbf     d1,loc_1D006
                move.w  #$400,(SpriteGridFirstTile).l
                move.w  #$E8,(SpriteGridCenterY).l
                move.w  #$120,(SpriteGridCenterX).l
                move.w  #0,(SpriteGridRowLimit).l
                move.w  #2,(SpriteGridColumnLimit).l
                move.l  #$40000002,(PatternVDPCommand).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(PatternFrameMask).l
                clr.w   (PatternDissolveStep).l
                jsr     (Cutscene_FillPlanetPattern).l
                jsr     (Cutscene_RenderPlanetSpriteGrid).l
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                move.b  #$87,d0
                jsr     (Sound_QueueRequest).l
                addq.w  #2,(GameSubstateIndex).w
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                movea.l #SegaScreenPalette,a0
                movea.w #(byte_FFE3C0-M68K_RAM),a1
                moveq   #7,d7
loc_1D09E:                                              ; CODE XREF: UI_InitializeSEGAScreen+11E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_1D09E
                movea.w (VDPCommandQueueHead).w,a0
                move.w  #$82,-(a0)
                move.w  #$6000,-(a0)
                move.l  #sega_tiles,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+3).w,-(a0)
                move.b  #$95,-(a0)
                move.b  (dword_FF8040+2).w,-(a0)
                move.b  #$96,-(a0)
                move.b  (dword_FF8040+1).w,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  #$94039300,-(a0)
                move.w  a0,(VDPCommandQueueHead).w
                move    #$2300,sr
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$C200,$E(a0)
                clr.b   $20(a0)
                move.l  #word_E98B0,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E8,$14(a0)
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                rts
; End of function UI_InitializeSEGAScreen
; Copies two palette lines between RAM buffers
Gfx_CopyPaletteLines:                                   ; CODE XREF: UI_InitializeSEGAScreen+40   p  ; was: sub_1D120
                lea     (word_FFE362).w,a0
                lea     (word_FFE302).w,a1
                lea     (word_FFE3E2).w,a2
                lea     (word_FFE382).w,a3
                move.w  #$E,d0
loc_1D134:                                              ; CODE XREF: Gfx_CopyPaletteLines+18   j
                move.w  (a0)+,(a1)+
                move.w  (a2)+,(a3)+
                dbf     d0,loc_1D134
                rts
; End of function Gfx_CopyPaletteLines
; Dispatches cutscene state based on frame counter
