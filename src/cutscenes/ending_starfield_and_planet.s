; Completes the fade-in, initializes 59 star sprites and four particle banks
EndingStarfield_Initialize:                             ; DATA XREF: ROM:00007C3E   o  ; was: sub_7D68
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Cutscene_Return
                subq.w  #2,(CutscenePaletteStep).l
                move.w  (CutscenePaletteStep).l,d0
                lea     (PaletteActiveColor01).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (CutscenePaletteStep).l
                bne.w   Cutscene_Return
                lea     (SecondaryEntityType).w,a5
                move.w  #$3A,d7                         ; ':'
EndingStarfield_InitializeNextSprite:                   ; CODE XREF: EndingStarfield_Initialize+5C   j  ; was: loc_7DA4
                move.w  #$8C00,2(a5)
                move.w  #0,8(a5)
                move.w  #$FCFC,$A(a5)
                move.w  #$10,(a5)
                move.w  #$6364,$E(a5)
                adda.w  #$60,a5                         ; '`'
                dbf     d7,EndingStarfield_InitializeNextSprite
                lea     (CutsceneWorkBuffer).l,a2
                lea     (EndingStarYPositions).l,a3
                lea     (EndingStarDepthValues).l,a1
                lea     (EndingStarXVelocities).l,a4
                lea     (EndingStarYVelocities).l,a5
                move.w  #$FF,d7
EndingStarfield_InitializeNextParticle:                 ; CODE XREF: EndingStarfield_Initialize+D0   j  ; was: loc_7DEA
                jsr     (RandomNumber).l
                move.w  d0,d2
                andi.w  #$7F,d2
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                bsr.w   Math_LookupSineCosinePair
                muls.w  d2,d0
                move.l  d0,d3
                swap    d0
                addi.w  #$128,d0
                move.w  d0,(a2)+
                clr.w   (a2)+
                asr.l   #4,d3
                move.l  d3,(a4)+
                muls.w  d2,d1
                move.l  d1,d3
                swap    d1
                addi.w  #$E8,d1
                move.w  d1,(a3)+
                clr.w   (a3)+
                asr.l   #4,d3
                move.l  d3,(a5)+
                jsr     (RandomNumber).l
                clr.w   d0
                swap    d0
                move.l  d0,$C00(a1)
                clr.l   (a1)+
                dbf     d7,EndingStarfield_InitializeNextParticle
                move.w  #$1A0,(CutsceneTimer).l
                addq.w  #2,(dword_FF8128+2).w
; Updates the starfield and accent colors during its $1A0-frame hold
EndingStarfield_UpdateAndHold:                          ; DATA XREF: ROM:00007C40   o  ; was: loc_7E48
                bsr.w   EndingSequence_AnimateAccentColors
                bsr.w   EndingStarfield_Update
                subq.w  #1,(CutsceneTimer).l
                bne.w   Cutscene_Return
                clr.w   (CutscenePaletteStep).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingStarfield_Initialize
; Integrates one of four particle banks and publishes it to 59 star sprites
EndingStarfield_Update:                                 ; CODE XREF: EndingStarfield_Initialize+E4   p  ; was: sub_7E66
                                        ; EndingStarfield_FadeOutAndPreparePlanet   p
                lea     (CutsceneWorkBuffer).l,a2
                lea     (EndingStarYPositions).l,a3
                lea     (EndingStarDepthValues).l,a1
                lea     (EndingStarXVelocities).l,a4
                lea     (EndingStarYVelocities).l,a5
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                adda.w  d0,a4
                adda.w  d0,a5
                move.w  #$3A,d7                         ; ':'
EndingStarfield_IntegrateNextParticle:                  ; CODE XREF: EndingStarfield_Update+44   j  ; was: loc_7E9C
                move.l  (a4)+,d0
                add.l   d0,(a2)+
                move.l  (a5)+,d0
                add.l   d0,(a3)+
                move.l  $C00(a1),d0
                add.l   d0,(a1)+
                dbf     d7,EndingStarfield_IntegrateNextParticle
                lea     (CutsceneWorkBuffer).l,a2
                lea     (EndingStarYPositions).l,a3
                lea     (EndingStarDepthValues).l,a1
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                lea     (SecondaryEntityType).w,a5
                move.w  #$3A,d7                         ; ':'
EndingStarfield_UpdateNextSprite:                       ; CODE XREF: EndingStarfield_Update+9A   j  ; was: loc_7ED8
                move.l  (a2)+,$10(a5)
                move.l  (a3)+,$14(a5)
                move.w  (a1),d0
                addq.w  #4,a1
                andi.w  #$FFF0,d0
                lsr.w   #4,d0
                cmpi.w  #3,d0
                bcs.s   EndingStarfield_StoreSpriteFrame
                move.w  #2,d0
EndingStarfield_StoreSpriteFrame:                       ; CODE XREF: EndingStarfield_Update+88   j  ; was: loc_7EF4
                addi.w  #$6364,d0
                move.w  d0,$E(a5)
                adda.w  #$60,a5                         ; '`'
                dbf     d7,EndingStarfield_UpdateNextSprite
                rts
; End of function EndingStarfield_Update
; Fades out the starfield, clears its objects, and seeds planet-background loading
EndingStarfield_FadeOutAndPreparePlanet:                ; DATA XREF: ROM:00007C42   o  ; was: sub_7F06
                bsr.w   EndingStarfield_Update
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Cutscene_Return
                subq.w  #2,(CutscenePaletteStep).l
                move.w  (CutscenePaletteStep).l,d0
                lea     (PaletteActiveColor01).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(CutscenePaletteStep).l
                bne.w   Cutscene_Return
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                jsr     (Sys_ClearEntityObjectPool).l
                move.l  #Gfx_DefaultVRAMTransferParameters,(TilemapTransferBase).w
                move.w  #$800,(TilemapRowXOrFillWord).w
                move.w  #0,(TilemapRowYPosition).w
                move.w  #$1F,(TilemapRowCountdown).w
                lea     (LargeTilemapBuffer).l,a0
                move.l  #$80008000,d1
                move.w  #$7FF,d0
EndingPlanet_SetNextBufferHighBits:                     ; CODE XREF: EndingStarfield_FadeOutAndPreparePlanet+76   j  ; was: loc_7F7A
                or.l    d1,(a0)+
                dbf     d0,EndingPlanet_SetNextBufferHighBits
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingStarfield_FadeOutAndPreparePlanet
; Finishes background loading and configures the ending planet scene
EndingPlanet_Initialize:                                ; DATA XREF: ROM:00007C44   o  ; was: sub_7F86
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                tst.w   (TilemapRowCountdown).w
                bpl.w   Cutscene_Return
                lea     (CreditsAndPlanetPaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(CutscenePaletteStep).l
                move.b  #6,(VDPReg11Shadow+1).w
                move.b  #3,(byte_FFA95A).w
                clr.l   (EndingScrollPhase).l
                clr.l   (EndingScrollRate).l
                moveq   #0,d0
                lea     (HScrollBuffer).w,a0
                move.w  #$1B,d7
EndingPlanet_ClearNextHScrollBlock:                     ; CODE XREF: EndingPlanet_Initialize+5C   j  ; was: loc_7FDC
                move.l  d0,(a0)
                adda.w  #$20,a0                         ; ' '
                dbf     d7,EndingPlanet_ClearNextHScrollBlock
                lea     (VScrollBuffer).w,a0
                move.w  #9,d7
EndingPlanet_ClearNextVScrollPair:                      ; CODE XREF: EndingPlanet_Initialize+6A   j  ; was: loc_7FEE
                move.l  d0,(a0)+
                dbf     d7,EndingPlanet_ClearNextVScrollPair
                lea     (Entity_ObjectPool).w,a5
                move.w  #$CC00,PrimaryEntityFlags-Entity_ObjectPool(a5)
                move.w  #$10,(a5)
                move.l  #Sprite_SharedGraphicsFrameTable,8(a5)
                move.w  #$8001,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$130,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
                lea     (SecondaryEntityType).w,a5
                move.w  #$CC00,SecondaryEntityFlags-SecondaryEntityType(a5)
                move.w  #$10,(a5)
                move.l  #EndingPlanetSpriteMappingsB,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                lea     (TertiaryEntityType).w,a5
                move.w  #$CC00,TertiaryEntityFlags-TertiaryEntityType(a5)
                move.w  #$10,(a5)
                move.l  #EndingPlanetSpriteMappingsA,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$110,$10(a5)
                move.w  #$D0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                move.w  #$4E0,(SpriteGridFirstTile).l
                move.w  #$D0,(SpriteGridCenterY).l
                move.w  #$118,(SpriteGridCenterX).l
                move.w  #4,(SpriteGridRowLimit).l
                move.w  #4,(SpriteGridColumnLimit).l
                move.l  #$5C000002,(PatternVDPCommand).l
                move.w  #$F,(PlanetPatternWriteOnly).l
                move.w  #1,(PatternFrameMask).l
                clr.w   (PatternDissolveStep).l
                jsr     Cutscene_FillPlanetPattern(pc)  ; (pc)
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                bsr.w   EndingPlanet_StartFadeIn
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingPlanet_Initialize
; Fades in the planet, animates its vertical motion, then dissolves its pattern
EndingPlanet_ShowAndDissolve:                           ; DATA XREF: ROM:00007C46   o  ; was: sub_80F8
                bsr.w   EndingPlanet_UpdateFadeIn
                bsr.w   EndingPlanet_DispatchVerticalMotion
                bsr.w   EndingSequence_AnimateAccentColors
                bsr.w   Cutscene_RenderPlanetSpriteGrid
                tst.w   (CutscenePaletteStep).l
                bne.w   Cutscene_Return
                bsr.w   Cutscene_ErasePlanetPatternStep
                cmpi.w  #$40,(PatternDissolveStep).l    ; '@'
                bcs.w   Cutscene_Return
                move.w  #$100,(CutsceneTimer).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingPlanet_ShowAndDissolve
; Starts the planet fade at step -14 and immediately applies that step
EndingPlanet_StartFadeIn:                               ; CODE XREF: EndingPlanet_Initialize+168   p  ; was: sub_8130
                move.w  #$FFF2,(CutscenePaletteStep).l
                bra.s   EndingPlanet_ApplyFadeStep
; End of function EndingPlanet_StartFadeIn
; Advances and applies the planet fade every eighth frame until step zero
EndingPlanet_UpdateFadeIn:                              ; CODE XREF: EndingPlanet_ShowAndDissolve   p  ; was: sub_813A
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Cutscene_Return
                tst.w   (CutscenePaletteStep).l
                beq.w   Cutscene_Return
                addq.w  #2,(CutscenePaletteStep).l
EndingPlanet_ApplyFadeStep:                             ; CODE XREF: EndingPlanet_StartFadeIn+8   j  ; was: loc_8156
                move.w  (CutscenePaletteStep).l,d0
                lea     (PaletteActiveColor01).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function EndingPlanet_UpdateFadeIn
; Holds the dissolved planet while its timer and vertical-motion state continue
EndingPlanet_HoldDissolved:                             ; DATA XREF: ROM:00007C48   o  ; was: sub_816E
                bsr.w   EndingPlanet_DispatchVerticalMotion
                subq.w  #1,(CutsceneTimer).l
                bne.w   Cutscene_Return
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingPlanet_HoldDissolved
; Restores the planet pattern, hides the secondary object, and starts the zoom delay
EndingPlanet_RevealPattern:                             ; DATA XREF: ROM:00007C4A   o  ; was: sub_8182
                bsr.w   EndingPlanet_DispatchVerticalMotion
                bsr.w   EndingSequence_AnimateAccentColors
                bsr.w   Cutscene_RenderPlanetSpriteGrid
                bsr.w   Cutscene_RevealPlanetPatternStep
                tst.w   (PatternDissolveStep).l
                bne.w   Cutscene_Return
                clr.w   (TertiaryEntityFlags).w
                clr.w   (PlanetZoomFrameIndex).l
                move.w  #$140,(CutsceneTimer).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function EndingPlanet_RevealPattern
; Selects a fixed-size entry in the shared sprite graphics-frame table
Sprite_SelectSharedGraphicsFrame:                       ; CODE XREF: EndingPlanet_RunZoom+1A   p  ; was: sub_81B4
                                        ; Boss_SnakeAdvanceAnimation+26   p
                moveq   #0,d0
                move.w  d1,d0
                lsl.w   #1,d1
                add.w   d1,d0
                addi.l  #Sprite_SharedGraphicsFrameTable,d0
                move.l  d0,8(a5)
                rts
; End of function Sprite_SelectSharedGraphicsFrame
; Dispatches the secondary planet object's vertical-velocity state
EndingPlanet_DispatchVerticalMotion:                    ; CODE XREF: EndingPlanet_ShowAndDissolve+4   p  ; was: sub_81C8
                                        ; EndingPlanet_HoldDissolved   p
                lea     (SecondaryEntityType).w,a5
                move.w  SecondaryEntityState-SecondaryEntityType(a5),d0
                lea     EndingPlanet_VerticalMotionStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function EndingPlanet_DispatchVerticalMotion
; ---------------------------------------------------------------------------
EndingPlanet_VerticalMotionStates:  dc.w    EndingPlanet_StartRising-*  ; DATA XREF: EndingPlanet_DispatchVerticalMotion+8   o  ; was: off_81D8
                dc.w    EndingPlanet_AccelerateDownward-*
                dc.w    EndingPlanet_AccelerateUpward-*

; Starts the secondary planet object with upward velocity
EndingPlanet_StartRising:                               ; DATA XREF: ROM:EndingPlanet_VerticalMotionStates   o  ; was: sub_81DE
                move.l  #$FFFFC000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function EndingPlanet_StartRising
; Accelerates its vertical velocity downward until it reaches `$4000`
EndingPlanet_AccelerateDownward:                        ; DATA XREF: ROM:000081DA   o  ; was: sub_81EC
                addi.l  #$200,$1C(a5)
                cmpi.l  #$4000,$1C(a5)
                bne.w   Cutscene_Return
                addq.w  #2,4(a5)
                rts
; End of function EndingPlanet_AccelerateDownward
; Accelerates its vertical velocity upward and loops the motion state
EndingPlanet_AccelerateUpward:                          ; DATA XREF: ROM:000081DC   o  ; was: sub_8206
                subi.l  #$200,$1C(a5)
                cmpi.l  #$FFFFC000,$1C(a5)
                bne.w   Cutscene_Return
                subq.w  #2,4(a5)
                rts
; End of function EndingPlanet_AccelerateUpward
; Dispatches the primary planet object's five zoom states
EndingPlanet_DispatchZoomObject:                        ; CODE XREF: EndingPlanet_RunZoom+8   p  ; was: sub_8220
                lea     (Entity_ObjectPool).w,a5
                move.w  PrimaryEntityState-Entity_ObjectPool(a5),d0
                lea     EndingPlanet_ZoomObjectStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function EndingPlanet_DispatchZoomObject
; ---------------------------------------------------------------------------
EndingPlanet_ZoomObjectStates:  dc.w    EndingPlanet_StartZoom-*  ; DATA XREF: EndingPlanet_DispatchZoomObject+8   o  ; was: off_8230
                dc.w    EndingPlanet_ApproachCenter-*
                dc.w    EndingPlanet_PauseAtCenter-*
                dc.w    EndingPlanet_ExitScreen-*
                dc.w    EndingPlanet_ZoomObjectComplete-*

; Initializes the zoom orbit, palette step, sound, and 32-object burst
EndingPlanet_StartZoom:                                 ; DATA XREF: ROM:EndingPlanet_ZoomObjectStates   o  ; was: sub_823A
                andi.w  #$7FFF,(SecondaryEntityFlags).w
                ori.w   #$8000,2(a5)
                move.w  #$1A0,(PlanetZoomAngle).l
                move.l  #$200000,(PlanetZoomRadius).l
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                move.w  #$10,(CutscenePaletteStep).l
                addq.w  #2,4(a5)
                bra.w   EndingPlanet_InitializeBurst
; End of function EndingPlanet_StartZoom
; Shrinks the orbit radius to zero while updating velocity from sine/cosine
EndingPlanet_ApproachCenter:                            ; DATA XREF: ROM:00008232   o  ; was: sub_8272
                bsr.w   EndingPlanet_AnimateTileAttributes
                bsr.w   EndingPlanet_AdvanceFrameIndex
                bsr.w   EndingPlanet_UpdateZoomPalette
                subi.l  #$8000,(PlanetZoomRadius).l
                subi.w  #4,(PlanetZoomAngle).l
                move.w  (PlanetZoomAngle).l,d0
                bsr.w   Math_LookupSineCosinePair
                move.l  (PlanetZoomRadius).l,d2
                asl.l   #8,d2
                swap    d2
                muls.w  d2,d0
                asr.l   #7,d0
                move.l  d0,$18(a5)
                muls.w  d2,d1
                asr.l   #8,d1
                move.l  d1,$1C(a5)
                tst.l   (PlanetZoomRadius).l
                bne.w   Cutscene_Return
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,$40(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function EndingPlanet_ApproachCenter
; Holds at the center for `$20` frames, then launches the planet and debris
EndingPlanet_PauseAtCenter:                             ; DATA XREF: ROM:00008234   o  ; was: sub_82D2
                bsr.w   EndingPlanet_AnimateTileAttributes
                subq.w  #1,$40(a5)
                bne.w   Cutscene_Return
                move.b  #$31,d0                         ; '1'
                jsr     (Sound_PlaySFX).l
                move.w  #8,(CutscenePaletteStep).l
                move.l  #$74000,$18(a5)
                move.l  #$57000,$1C(a5)
                addq.w  #2,4(a5)
                bra.w   EndingPlanet_CreateDebris
; End of function EndingPlanet_PauseAtCenter
; Accelerates the planet and debris until the planet crosses X `$120`
EndingPlanet_ExitScreen:                                ; DATA XREF: ROM:00008236   o  ; was: sub_8308
                bsr.w   EndingPlanet_AnimateTileAttributes
                bsr.w   EndingPlanet_AdvanceFrameIndex
                bsr.w   EndingPlanet_UpdateZoomPalette
                bsr.w   EndingPlanet_UpdateDebris
                subi.l  #$4000,$18(a5)
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$120,$10(a5)
                bcs.w   Cutscene_Return
                clr.w   2(a5)
                addq.w  #2,4(a6)
                rts
; End of function EndingPlanet_ExitScreen
EndingPlanet_ZoomObjectComplete:                        ; DATA XREF: ROM:00008238   o  ; was: nullsub_19
                rts
; End of function EndingPlanet_ZoomObjectComplete

; Creates the single planet-debris object at the planet's current position
EndingPlanet_CreateDebris:                              ; CODE XREF: EndingPlanet_PauseAtCenter+32   j  ; was: sub_833E
                lea     (EndingPlanetDebrisType).w,a4
                move.w  #$EC00,EndingPlanetDebrisFlags-EndingPlanetDebrisType(a4)
                move.w  #$10,(a4)
                move.l  #EndingPlanetDebrisAnimationSequence,8(a4)
                move.w  #$8100,$E(a4)
                clr.w   $C(a4)
                clr.w   4(a4)
                move.w  $14(a5),$14(a4)
                move.w  $10(a5),$10(a4)
                move.l  #$FFFC0000,$18(a4)
                move.l  #$FFFD0000,$1C(a4)
                rts
; End of function EndingPlanet_CreateDebris
; Accelerates the debris and clears it when its lifetime counter reaches `$80`
EndingPlanet_UpdateDebris:                              ; CODE XREF: EndingPlanet_ExitScreen+C   p  ; was: sub_8380
                lea     (EndingPlanetDebrisType).w,a4
                addi.l  #$4000,EndingPlanetDebrisXVel-EndingPlanetDebrisType(a4)
                addi.l  #$3000,$1C(a4)
                cmpi.w  #$80,$C(a4)
                bcs.w   Cutscene_Return
                clr.w   2(a4)
                rts
; End of function EndingPlanet_UpdateDebris
; Initializes 32 randomized burst objects around the planet center
EndingPlanet_InitializeBurst:                           ; CODE XREF: EndingPlanet_StartZoom+34   j  ; was: sub_83A4
                lea     (QuaternaryEntityType).w,a4
                move.w  #$1F,d7
EndingPlanet_InitializeNextBurstObject:                 ; CODE XREF: EndingPlanet_InitializeBurst+68   j  ; was: loc_83AC
                move.w  #$EC00,2(a4)
                move.w  #$10,(a4)
                move.l  #EndingPlanetBurstAnimationSequence,8(a4)
                move.w  #$8100,$E(a4)
                clr.w   $C(a4)
                clr.w   4(a4)
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                addi.w  #$178,d0
                move.w  d0,$10(a4)
                subi.w  #$188,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$18(a4)
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                addi.w  #$118,d0
                move.w  d0,$14(a4)
                subi.w  #$128,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$1C(a4)
                adda.w  #$60,a4                         ; '`'
                dbf     d7,EndingPlanet_InitializeNextBurstObject
                rts
; End of function EndingPlanet_InitializeBurst
; Scans all 32 burst objects and clears those whose lifetime reached `$80`
EndingPlanet_ClearExpiredBurstObjects:                  ; CODE XREF: EndingPlanet_RunZoom+C   p  ; was: sub_8412
                lea     (QuaternaryEntityType).w,a5
                move.w  #$1F,d7
EndingPlanet_CheckNextBurstObject:                      ; CODE XREF: EndingPlanet_ClearExpiredBurstObjects+10   j  ; was: loc_841A
                bsr.w   EndingPlanet_ClearExpiredBurstObject
                adda.w  #$60,a5                         ; '`'
                dbf     d7,EndingPlanet_CheckNextBurstObject
                rts
; End of function EndingPlanet_ClearExpiredBurstObjects
; Clears one burst object when its lifetime field reaches `$80`
EndingPlanet_ClearExpiredBurstObject:                   ; CODE XREF: EndingPlanet_ClearExpiredBurstObjects:EndingPlanet_CheckNextBurstObject   p  ; was: sub_8428
                cmpi.w  #$80,$C(a5)
                bcs.w   Cutscene_Return
                clr.w   2(a5)
                rts
; End of function EndingPlanet_ClearExpiredBurstObject
; Moves the zoom palette step toward zero on alternate frames
EndingPlanet_UpdateZoomPalette:                         ; CODE XREF: EndingPlanet_ApproachCenter+8   p  ; was: sub_8438
                                        ; EndingPlanet_ExitScreen+8   p
                tst.w   (CutscenePaletteStep).l
                beq.w   Cutscene_Return
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #1,d0
                bne.w   Cutscene_Return
                subq.w  #2,(CutscenePaletteStep).l
                move.w  (CutscenePaletteStep).l,d0
                lea     (PaletteActiveColor01).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function EndingPlanet_UpdateZoomPalette
; Cycles the planet object's tile attributes through four frame phases
EndingPlanet_AnimateTileAttributes:                     ; CODE XREF: EndingPlanet_ApproachCenter   p  ; was: sub_846C
                                        ; EndingPlanet_PauseAtCenter   p
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #3,d0
                lsl.w   #1,d0
                move.w  EndingPlanet_TileAttributeCycle(pc,d0.w),(PrimaryEntitySpriteAttr).w
                rts
; End of function EndingPlanet_AnimateTileAttributes
; ---------------------------------------------------------------------------
EndingPlanet_TileAttributeCycle:    dc.w    1, $801, $1801, $1001  ; was: word_847E

; Advances the shared graphics-frame index, doubling cadence after `$20`
EndingPlanet_AdvanceFrameIndex:                         ; CODE XREF: EndingPlanet_ApproachCenter+4   p  ; was: sub_8486
                                        ; EndingPlanet_ExitScreen+4   p
                cmpi.w  #$3E,(PlanetZoomFrameIndex).l   ; '>'
                beq.w   Cutscene_Return
                cmpi.w  #$20,(PlanetZoomFrameIndex).l   ; ' '
                bcc.s   EndingPlanet_AdvanceFrameIndexFast
                move.w  (CutsceneTimer).l,d0
                andi.w  #3,d0
                bne.w   Cutscene_Return
                addq.w  #2,(PlanetZoomFrameIndex).l
                rts
; ---------------------------------------------------------------------------
EndingPlanet_AdvanceFrameIndexFast:                     ; CODE XREF: EndingPlanet_AdvanceFrameIndex+14   j  ; was: loc_84B2
                move.w  (CutsceneTimer).l,d0
                andi.w  #1,d0
                bne.w   Cutscene_Return
                addq.w  #2,(PlanetZoomFrameIndex).l
                rts
; End of function EndingPlanet_AdvanceFrameIndex
; Coordinates the zoom object, particles, frame selection, scroll, timer, and sound
EndingPlanet_RunZoom:                                   ; DATA XREF: ROM:00007C4C   o  ; was: sub_84C8
                bsr.w   EndingSequence_AnimateAccentColors
                bsr.w   EndingPlanet_DispatchVerticalMotion
                bsr.w   EndingPlanet_DispatchZoomObject
                bsr.w   EndingPlanet_ClearExpiredBurstObjects
                lea     (Entity_ObjectPool).w,a5
                move.w  (PlanetZoomFrameIndex).l,d1
                bsr.w   Sprite_SelectSharedGraphicsFrame
                bsr.w   EndingPlanet_UpdatePerspectiveScroll
                subq.w  #1,(CutsceneTimer).l
                beq.w   EndingPlanet_FinishZoom
                cmpi.w  #$80,(CutsceneTimer).l
                bne.w   Cutscene_Return
                move.b  #1,d0
                jmp     (Sound_QueueRequest).l
; End of function EndingPlanet_RunZoom
; Integrates an accelerating phase and builds symmetric H/V perspective scroll bands
EndingPlanet_UpdatePerspectiveScroll:                   ; CODE XREF: EndingPlanet_RunZoom+1E   p  ; was: sub_850A
                                        ; EndingPlanet_FadeOutZoom   p
                addi.l  #$80,(EndingScrollRate).l
                move.l  (EndingScrollRate).l,d0
                add.l   d0,(EndingScrollPhase).l
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (HScrollPlaneARow112).w,a0
                move.w  #$D,d7
EndingPlanet_WriteForwardHScroll:                       ; CODE XREF: EndingPlanet_UpdatePerspectiveScroll+3C   j  ; was: loc_8538
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0                         ; ' '
                dbf     d7,EndingPlanet_WriteForwardHScroll
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (HScrollPlaneARow104).w,a0
                move.w  #$D,d7
EndingPlanet_WriteReverseHScroll:                       ; CODE XREF: EndingPlanet_UpdatePerspectiveScroll+60   j  ; was: loc_855C
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0                         ; ' '
                dbf     d7,EndingPlanet_WriteReverseHScroll
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (VScrollPlaneAColumn10).w,a0
                move.w  #9,d7
EndingPlanet_WriteForwardVScroll:                       ; CODE XREF: EndingPlanet_UpdatePerspectiveScroll+8A   j  ; was: loc_8586
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,EndingPlanet_WriteForwardVScroll
                move.l  (EndingScrollPhase).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (VScrollPlaneAColumn9).w,a0
                move.w  #9,d7
EndingPlanet_WriteReverseVScroll:                       ; CODE XREF: EndingPlanet_UpdatePerspectiveScroll+AE   j  ; was: loc_85AA
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,EndingPlanet_WriteReverseVScroll
                rts
; End of function EndingPlanet_UpdatePerspectiveScroll
; Selects the final ending state after the zoom timer expires
EndingPlanet_FinishZoom:                                ; CODE XREF: EndingPlanet_RunZoom+28   j  ; was: sub_85BE
                clr.w   (CutscenePaletteStep).l
                move.w  #$18,(dword_FF8128+2).w
                rts
; End of function EndingPlanet_FinishZoom
; Continues perspective scroll while fading out and handing control to credits mode
EndingPlanet_FadeOutZoom:                               ; DATA XREF: ROM:00007C4E   o  ; was: sub_85CC
                bsr.w   EndingPlanet_UpdatePerspectiveScroll
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Cutscene_Return
                subq.w  #2,(CutscenePaletteStep).l
                move.w  (CutscenePaletteStep).l,d0
                lea     (PaletteActiveColor01).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(CutscenePaletteStep).l
                bne.w   Cutscene_Return
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                move.w  #1,(dword_FF8128).w
                rts
; End of function EndingPlanet_FadeOutZoom
