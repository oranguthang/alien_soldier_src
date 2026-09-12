; Loads the Xi Tiger transition's object data, palettes, and frame-decompression state
XiTigerCutscene_LoadAssets:                             ; DATA XREF: ROM:StageTransition_InitializeHandlerTable   o  ; was: sub_1E86A
                                        ; StageTransition_DispatchUpdate+8   o
                lea     XiTigerCutscene_AssetLoadDescriptors(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (XiTigerCutscenePaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  (PlayerHealth).w,(DisplayedPlayerHealth).w
                move.w  #$7000,d0
                move.w  d0,(DisplayedBossHealth).w
                move.w  d0,(BossHealth).w
                move.w  d0,(BossMaxHealth).w
                bset    #0,(byte_FFA272).w
                jmp     CutsceneProjection_Initialize
; End of function XiTigerCutscene_LoadAssets
; ---------------------------------------------------------------------------
XiTigerCutscene_AssetLoadDescriptors:   dc.w    7       ; field_0  ; was: stru_1E8A4
                                        ; DATA XREF: XiTigerCutscene_LoadAssets   o
                dc.l    XiTigerCutsceneTileArt          ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    XiTigerCutsceneMappingDataA     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    XiTigerCutsceneMappingDataB     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    3                               ; field_0
                dc.l    byte_18BE42                     ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18C634                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18C5E6                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    XiTigerCutsceneTileArt7800      ; field_2
                dc.w    $7800                           ; field_6
                dc.w    $FFFF

; Updates the HUD and dispatches the current Xi Tiger cutscene state
XiTigerCutscene_Update:                                 ; DATA XREF: ROM:StageTransition_UpdateHandlerTable   o  ; was: sub_1E8F6
                jsr     (UI_BuildHUDSpriteList).l
                jsr     (UI_UpdateGameplayHUD).l
                move.w  (dword_FF8128).w,d0
                movea.w XiTigerCutscene_StateTable(pc,d0.w),a0
                adda.l  #XiTigerCutscene_Setup,a0
                jmp     (a0)
; End of function XiTigerCutscene_Update
; ---------------------------------------------------------------------------
XiTigerCutscene_StateTable: dc.w    XiTigerCutscene_Setup-XiTigerCutscene_Setup  ; was: off_1E912
                                        ; DATA XREF: XiTigerCutscene_Update+10   r
                dc.w    XiTigerCutscene_WaitBeforeReveal-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_AdvanceReveal-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_InitializeReveal-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_AnimateReveal-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_UpdateRevealOffsets-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_AnimateFlash-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_AnimateFadeOut-XiTigerCutscene_Setup
                dc.w    XiTigerCutscene_EnterStageHandler-XiTigerCutscene_Setup

; Sets up Xi Tiger cutscene
XiTigerCutscene_Setup:                                  ; DATA XREF: XiTigerCutscene_Update+14   o  ; was: sub_1E924
                                        ; ROM:XiTigerCutscene_StateTable   o
                addq.w  #2,(dword_FF8128).w
                move.l  #$20000,(dword_FF812C).w
                move.w  #$100,(dword_FF8130).w
                move.b  #$1E,d0
                jsr     (Sound_PlaySFX).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                bsr.w   XiTigerCutscene_InitializeDisplayObject
                lea     $60(a0),a0
                bsr.w   XiTigerCutscene_InitializeDisplayObject
                bset    #3,$E(a0)
                move.w  #0,(dword_FFA900).w
                move.w  #$28,(dword_FFA908).w           ; '('
                lea     XiTigerCutscene_TileTransferDescriptor(pc),a0
                nop
                jsr     (Tilemap_QueueIndexedColumns).l
                lea     XiTigerCutscene_IndexedRowTransferDescriptor(pc),a0
                nop
                jmp     Tilemap_QueueIndexedRows
; End of function XiTigerCutscene_Setup
; ---------------------------------------------------------------------------
XiTigerCutscene_TileTransferDescriptor: dc.l    $44214000, $1020203, $B0C090A  ; was: dword_1E97A
                                        ; DATA XREF: XiTigerCutscene_Setup+3E   o
XiTigerCutscene_IndexedRowTransferDescriptor:   dc.l    $68204000, $4010405, $607080D, $E0F1011  ; was: dword_1E986
                                        ; DATA XREF: XiTigerCutscene_Setup+4A   o

; Initializes Xi-Tiger cutscene with graphics
XiTigerCutscene_InitializeDisplayObject:                ; CODE XREF: XiTigerCutscene_Setup+20   p  ; was: sub_1E996
                                        ; XiTigerCutscene_Setup+28   p
                move.w  #$10,(a0)
                move.w  #$CC00,2(a0)
                move.w  #$E3C0,$E(a0)
                move.l  #XiTigerCutscene_DisplayObjectSpriteMapping,8(a0)
XiTigerCutscene_Return:                                 ; CODE XREF: XiTigerCutscene_InitializeReveal+4   j  ; was: locret_1E9AE
                                        ; XiTigerCutscene_SpawnMarker+6   j
                rts
; End of function XiTigerCutscene_InitializeDisplayObject
; Advances the initial reveal source and palette phase
XiTigerCutscene_AdvanceReveal:                          ; DATA XREF: ROM:0001E916   o  ; was: sub_1E9B0
                subi.l  #$1800,(CutsceneScaleStep).w
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.s   XiTigerCutscene_UpdateRevealFrame
                addq.w  #2,(dword_FF8130+2).w
                cmpi.w  #$E,(dword_FF8130+2).w
                bmi.s   XiTigerCutscene_UpdateRevealFrame
                addq.w  #2,(dword_FF8128).w
XiTigerCutscene_UpdateRevealFrame:                      ; CODE XREF: XiTigerCutscene_AdvanceReveal+10   j  ; was: loc_1E9D2
                                        ; XiTigerCutscene_AdvanceReveal+1C   j
                bsr.w   XiTigerCutscene_ApplyPaletteFade
                bra.s   XiTigerCutscene_RenderWaitingFrame
; End of function XiTigerCutscene_AdvanceReveal
; Holds the opening composition while emitting particles, then begins the reveal
XiTigerCutscene_WaitBeforeReveal:                       ; DATA XREF: ROM:0001E914   o  ; was: sub_1E9D8
                subq.w  #1,(dword_FF8130).w
                bpl.s   XiTigerCutscene_UpdateWaitingFrame
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$50,(dword_FF8130).w           ; 'P'
                clr.w   (Entity_ObjectPool).w
                clr.w   (word_FFC680).w
XiTigerCutscene_UpdateWaitingFrame:                     ; CODE XREF: XiTigerCutscene_WaitBeforeReveal+4   j  ; was: loc_1E9FA
                bsr.w   XiTigerCutscene_SpawnRandomParticle
                move.w  (dword_FF8128+2).w,d0
                cmpi.w  #$200,d0
                bmi.s   XiTigerCutscene_RenderWaitingFrame
                andi.w  #$F,d0
                bne.s   XiTigerCutscene_RenderWaitingFrame
                moveq   #$E,d7
                bsr.w   XiTigerCutscene_SpawnMarkerPair
XiTigerCutscene_RenderWaitingFrame:                     ; CODE XREF: XiTigerCutscene_AdvanceReveal+26   j  ; was: loc_1EA14
                                        ; XiTigerCutscene_WaitBeforeReveal+2E   j
                bsr.w   XiTigerCutscene_UpdateActorAndLayerPositions
                bsr.w   XiTigerCutscene_BuildCompositeSprite
                jmp     CutsceneProjection_BuildFrame
; End of function XiTigerCutscene_WaitBeforeReveal
; Initializes the scrolling reveal and its raster-effect state
XiTigerCutscene_InitializeReveal:                       ; DATA XREF: ROM:0001E918   o  ; was: sub_1EA22
                subq.w  #1,(dword_FF8130).w
                bpl.w   XiTigerCutscene_Return
                move.b  #$82,d0
                jsr     (Sound_QueueBGMRequest).l
                addq.w  #2,(dword_FF8128).w
                clr.w   (word_FFE3BA).w
                clr.w   (word_FFE3BC).w
                clr.w   (dword_FF8128+2).w
                move.l  #$1820000,(dword_FF812C).w
                clr.w   (dword_FF8130).w
                move.w  #$FFE0,(dword_FF8134+2).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #7,(VDPReg11Shadow+1).w
                move.b  #6,(byte_FFA95A).w
                move.b  #9,(byte_FFA95B).w
                move.w  #0,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  #0,(dword_FFA908).w
                move.w  #0,(dword_FFA90C).w
                jsr     (Tilemap_DirectTransferFromPrimaryCamera).l
                move.w  #$1E0,(dword_FFA900).w
                jmp     Tilemap_DirectTransferFromSecondaryCamera
; End of function XiTigerCutscene_InitializeReveal
; Animates the reveal's palette phase, offsets, and composition
XiTigerCutscene_AnimateReveal:                          ; DATA XREF: ROM:0001E91A   o  ; was: sub_1EA9A
                move.w  (FrameCounter).w,d0
                andi.w  #$F,d0
                bne.s   XiTigerCutscene_UpdateRevealOffsets
                subq.w  #2,(dword_FF8130+2).w
                bne.s   XiTigerCutscene_UpdateRevealOffsets
                addq.w  #2,(dword_FF8128).w
; Updates the reveal offsets on alternating frames; this path does not read input
XiTigerCutscene_UpdateRevealOffsets:                    ; CODE XREF: XiTigerCutscene_AnimateReveal+8   j  ; was: loc_1EAAE
                                        ; XiTigerCutscene_AnimateReveal+E   j
                                        ; DATA XREF:
                btst    #0,(FrameCounter+1).w
                bne.s   XiTigerCutscene_AdvanceRevealTimer
                addq.w  #1,(dword_FF8134+2).w
                bmi.s   XiTigerCutscene_AdvanceRevealTimer
                clr.w   (dword_FF8134+2).w
XiTigerCutscene_AdvanceRevealTimer:                     ; CODE XREF: XiTigerCutscene_UpdateRevealOffsets+6   j  ; was: loc_1EAC0
                                        ; XiTigerCutscene_UpdateRevealOffsets+C   j
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$C0,(dword_FF8128+2).w
                bne.s   XiTigerCutscene_ContinueReveal
                move.b  #$11,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$48,(word_FFE3BA).w            ; 'H'
                move.w  #$2AE,(word_FFE3BC).w
                move.w  #$C,(dword_FF8130+2).w
                bra.s   XiTigerCutscene_AnimateFlash
; ---------------------------------------------------------------------------
XiTigerCutscene_ContinueReveal:                         ; CODE XREF: XiTigerCutscene_UpdateRevealOffsets+18   j  ; was: loc_1EAEE
                bsr.w   XiTigerCutscene_UpdateWaveAndLayerPositions
                bsr.w   XiTigerCutscene_ApplyPaletteFade
                bra.w   XiTigerCutscene_BuildCompositeSprite
; End of function XiTigerCutscene_AnimateReveal
; Animates the timed palette flash before fade-out
XiTigerCutscene_AnimateFlash:                           ; CODE XREF: XiTigerCutscene_UpdateRevealOffsets+3A   j  ; was: sub_1EAFA
                                        ; DATA XREF: ROM:0001E91E   o
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$160,(dword_FF8128+2).w
                bne.s   XiTigerCutscene_UpdateFlash
                addq.w  #2,(dword_FF8128).w
                bra.s   XiTigerCutscene_AnimateFadeOut
; ---------------------------------------------------------------------------
XiTigerCutscene_UpdateFlash:                            ; CODE XREF: XiTigerCutscene_AnimateFlash+A   j  ; was: loc_1EB0C
                subq.w  #1,(dword_FF8130+2).w
                bpl.s   XiTigerCutscene_ApplyFlashPalette
                clr.w   (dword_FF8130+2).w
XiTigerCutscene_ApplyFlashPalette:                      ; CODE XREF: XiTigerCutscene_UpdateFlash+6   j  ; was: loc_1EB16
                movea.w #(byte_FFE322-M68K_RAM),a0
                move.w  #$8000,d7
                moveq   #$E,d5
                bsr.w   XiTigerCutscene_ApplySelectedPaletteFade
                bsr.w   XiTigerCutscene_UpdateWaveAndLayerPositions
                bra.w   XiTigerCutscene_BuildCompositeSprite
; End of function XiTigerCutscene_AnimateFlash
; Reduces the reveal offset and palette intensity before leaving the cutscene
XiTigerCutscene_AnimateFadeOut:                         ; CODE XREF: XiTigerCutscene_AnimateFlash+10   j  ; was: sub_1EB2C
                                        ; DATA XREF: ROM:0001E920   o
                subq.w  #2,(dword_FF8134+2).w
                addq.w  #1,(dword_FF8130+2).w
                cmpi.w  #$10,(dword_FF8130+2).w
                bne.s   XiTigerCutscene_UpdateFadeOut
                addq.w  #2,(dword_FF8128).w
                rts
; ---------------------------------------------------------------------------
XiTigerCutscene_UpdateFadeOut:                          ; CODE XREF: XiTigerCutscene_AnimateFadeOut+E   j  ; was: loc_1EB42
                bsr.w   XiTigerCutscene_UpdateWaveAndLayerPositions
                bsr.w   XiTigerCutscene_BuildCompositeSprite
                bra.w   XiTigerCutscene_ApplyPaletteFade
; End of function XiTigerCutscene_AnimateFadeOut
; Leaves the transition cutscene for the Xi Tiger stage handler
XiTigerCutscene_EnterStageHandler:                      ; DATA XREF: ROM:0001E922   o  ; was: sub_1EB4E
                jsr     (Stage_LoadAssetsForCurrentTableIndex).l
                move.w  #$80,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #0,(XiTigerConfigIndex).w
                rts
; End of function XiTigerCutscene_EnterStageHandler
; Builds three ten-entry strips for the cutscene's composite sprite
XiTigerCutscene_BuildCompositeSprite:                   ; CODE XREF: XiTigerCutscene_WaitBeforeReveal+40   p  ; was: sub_1EB66
                                        ; XiTigerCutscene_AnimateReveal+5C   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$C3DC,d0
                move.w  #$F00,d1
                move.w  #$A0,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   XiTigerCutscene_WriteCompositeStrip
                move.w  #$140,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   XiTigerCutscene_WriteCompositeStrip
                move.w  #$160,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   XiTigerCutscene_WriteCompositeStrip
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function XiTigerCutscene_BuildCompositeSprite
; Writes one ten-entry strip into the OAM staging list
XiTigerCutscene_WriteCompositeStrip:                    ; CODE XREF: XiTigerCutscene_BuildCompositeSprite+14   p  ; was: sub_1EB9E
                                        ; XiTigerCutscene_BuildCompositeSprite+1E   p
                move.w  #$80,d2
                moveq   #9,d7
XiTigerCutscene_WriteNextStripEntry:                    ; CODE XREF: XiTigerCutscene_WriteCompositeStrip+12   j  ; was: loc_1EBA4
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d0,(a0)+
                move.w  d2,(a0)+
                addi.w  #$20,d2                         ; ' '
                dbf     d7,XiTigerCutscene_WriteNextStripEntry
                rts
; End of function XiTigerCutscene_WriteCompositeStrip
; Updates the paired display objects and layer offsets from the phase accumulator
XiTigerCutscene_UpdateActorAndLayerPositions:           ; CODE XREF: XiTigerCutscene_WaitBeforeReveal:XiTigerCutscene_RenderWaitingFrame   p  ; was: sub_1EBB6
                addi.l  #$800,(dword_FF812C).w
                move.w  (dword_FF812C).w,d0
                add.w   d0,(dword_FF8128+2).w
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                movea.w #(word_FFC680-M68K_RAM),a1
                move.w  (dword_FF8128+2).w,d0
                andi.w  #$3F,d0                         ; '?'
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   XiTigerCutscene_ApplyActorPositions
                subi.w  #$20,d0                         ; ' '
                eori.w  #$1F,d0
XiTigerCutscene_ApplyActorPositions:                    ; CODE XREF: XiTigerCutscene_UpdateActorAndLayerPositions+24   j  ; was: loc_1EBE4
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                addi.w  #$133,d0
                move.w  d0,$14(a0)
                move.w  d0,$14(a1)
                asr.w   #1,d2
                move.w  #$14E,d0
                add.w   d2,d0
                move.w  d0,$10(a0)
                move.w  #$F2,d0
                sub.w   d2,d0
                move.w  d0,$10(a1)
                asr.w   #1,d1
                addq.w  #1,d1
                move.w  d1,(dword_FFA90C).w
                asr.w   #1,d1
                subi.w  #$18,d1
                move.w  d1,(CutsceneVerticalOffset).w
                rts
; End of function XiTigerCutscene_UpdateActorAndLayerPositions
; Applies the main palette fade to all 64 cutscene colors
XiTigerCutscene_ApplyPaletteFade:                       ; CODE XREF: XiTigerCutscene_AdvanceReveal:XiTigerCutscene_UpdateRevealFrame   p  ; was: sub_1EC20
                                        ; XiTigerCutscene_AnimateReveal+58   p
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                move.w  #$E000,d7
                moveq   #$3F,d5                         ; '?'
XiTigerCutscene_ApplySelectedPaletteFade:               ; CODE XREF: XiTigerCutscene_AnimateFlash+26   p  ; was: loc_1EC2A
                move.w  (dword_FF8130+2).w,d0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function XiTigerCutscene_ApplyPaletteFade
; Writes the sine-wave raster table and updates the cutscene layer positions
XiTigerCutscene_UpdateWaveAndLayerPositions:            ; CODE XREF: XiTigerCutscene_AnimateReveal:XiTigerCutscene_ContinueReveal   p  ; was: sub_1EC34
                                        ; XiTigerCutscene_AnimateFlash+2A   p
                movea.w #(word_FFE402-M68K_RAM),a0
                lea     (Math_QuarterSineTable).l,a1
                moveq   #0,d0
                addi.w  #$108,(dword_FF8134).w
                move.w  (dword_FF8134).w,d0
                move.l  #$1814000,d3
                move.w  #$DF,d7
XiTigerCutscene_WriteNextWaveLine:                      ; CODE XREF: XiTigerCutscene_UpdateWaveAndLayerPositions+3A   j  ; was: loc_1EC54
                move.w  d0,d2
                andi.w  #$1FE,d2
                move.w  (a1,d2.w),d1
                ext.l   d1
                asl.l   #8,d1
                swap    d1
                move.w  d1,(a0)
                swap    d0
                add.l   d3,d0
                swap    d0
                addq.w  #4,a0
                dbf     d7,XiTigerCutscene_WriteNextWaveLine
                subq.w  #4,(dword_FFA90C).w
                move.w  (dword_FF8134+2).w,d7
                asr.w   #1,d7
                addq.w  #1,(dword_FF8130).w
                move.w  (dword_FF8130).w,d0
                andi.w  #$3F,d0                         ; '?'
                btst    #6,(dword_FF8130+1).w
                beq.s   XiTigerCutscene_UpdateLayerPositions
                eori.w  #$3F,d0                         ; '?'
                btst    #0,(FrameCounter+1).w
                bne.s   XiTigerCutscene_UpdateLayerPositions
                addq.w  #1,(dword_FF8130).w
XiTigerCutscene_UpdateLayerPositions:                   ; CODE XREF: XiTigerCutscene_UpdateWaveAndLayerPositions+5A   j  ; was: loc_1ECA0
                                        ; XiTigerCutscene_UpdateWaveAndLayerPositions+66   j
                subi.w  #$20,d0                         ; ' '
                ext.l   d0
                asl.l   #8,d0
                asl.l   #5,d0
                move.l  #$FFF80000,d1
                sub.l   d0,d1
                move.l  d1,d2
                swap    d2
                sub.w   d7,d2
                move.w  d2,(word_FFEC18).w
                move.w  d2,(word_FFEC34).w
                sub.l   d0,d1
                swap    d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC14).w
                move.w  d1,(word_FFEC10).w
                move.w  d1,(word_FFEC0C).w
                move.w  d1,(word_FFEC08).w
                move.w  d1,(word_FFEC38).w
                move.w  d1,(word_FFEC3C).w
                move.w  d1,(word_FFEC40).w
                move.w  d1,(word_FFEC44).w
                moveq   #$FFFFFFF6,d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC1C).w
                move.w  d1,(word_FFEC30).w
                moveq   #$FFFFFFF4,d1
                swap    d0
                add.w   d0,d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC20).w
                move.w  d1,(word_FFEC24).w
                move.w  d1,(word_FFEC28).w
                move.w  d1,(word_FFEC2C).w
                move.w  (FrameCounter).w,d0
                andi.w  #2,d0
                asl.w   #2,d0
                move.w  XiTigerCutscene_AlternatingPaletteFrames(pc,d0.w),(word_FFE326).w
                move.w  XiTigerCutscene_AlternatingPaletteFrames+2(pc,d0.w),(word_FFE328).w
                move.w  XiTigerCutscene_AlternatingPaletteFrames+4(pc,d0.w),(word_FFE324).w
                rts
; End of function XiTigerCutscene_UpdateWaveAndLayerPositions
; ---------------------------------------------------------------------------
XiTigerCutscene_AlternatingPaletteFrames:   dc.w    $26, $68C, 2, 0  ; was: word_1ED28
                                        ; DATA XREF: XiTigerCutscene_UpdateWaveAndLayerPositions+E0   r
                                        ; XiTigerCutscene_UpdateWaveAndLayerPositions+E6   r
                dc.w    $48, $248, 4, 0

; Spawns the two marker sprites at symmetric horizontal offsets
XiTigerCutscene_SpawnMarkerPair:                        ; CODE XREF: XiTigerCutscene_WaitBeforeReveal+38   p  ; was: sub_1ED38
                bsr.s   XiTigerCutscene_SpawnMarker
                neg.w   d7
; Spawns one animated marker sprite at X = $120 + d7
XiTigerCutscene_SpawnMarker:                            ; CODE XREF: XiTigerCutscene_SpawnMarkerPair   p  ; was: sub_1ED3C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   XiTigerCutscene_Return
                move.w  #$120,$10(a0)
                add.w   d7,$10(a0)
                lea     (XiTigerCutscene_MarkerSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$274,(a0)
                rts
; End of function XiTigerCutscene_SpawnMarker
; Anchors a marker to the scrolling vertical offset and advances its animation
XiTigerCutscene_UpdateMarker:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_1ED62
                move.w  #$E1,d0
                sub.w   (CutsceneVerticalOffset).w,d0
                move.w  d0,$14(a5)
                jsr     (Anim_UpdateSpriteFrame).l
                bset    #7,$E(a5)
                rts
; End of function XiTigerCutscene_UpdateMarker
; Spawns one randomly positioned particle used during the opening hold
XiTigerCutscene_SpawnRandomParticle:                    ; CODE XREF: XiTigerCutscene_WaitBeforeReveal:XiTigerCutscene_UpdateWaitingFrame   p  ; was: sub_1ED7C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   XiTigerCutscene_Return
                move.b  (RandomNumberState).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.b  (RandomNumberState+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$100,d0
                move.w  d0,$14(a0)
                lea     (Effect_SharedBurstParticleSpriteFrames).l,a1
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                jmp     Sprite_InitFromTable
; End of function XiTigerCutscene_SpawnRandomParticle
