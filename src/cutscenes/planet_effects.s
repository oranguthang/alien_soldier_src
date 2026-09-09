Effect_InitializeStarfield:                             ; DATA XREF: ROM:00007C3E   o  ; was: sub_7D68
                move.w  (word_FFA280).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                lea     (word_FFC680).w,a5
                move.w  #$3A,d7                         ; ':'
loc_7DA4:                                               ; CODE XREF: Effect_InitializeStarfield+5C   j
                move.w  #$8C00,2(a5)
                move.w  #0,8(a5)
                move.w  #$FCFC,$A(a5)
                move.w  #$10,(a5)
                move.w  #$6364,$E(a5)
                adda.w  #$60,a5                         ; '`'
                dbf     d7,loc_7DA4
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                lea     (dword_FF1C00).l,a4
                lea     (dword_FF2000).l,a5
                move.w  #$FF,d7
loc_7DEA:                                               ; CODE XREF: Effect_InitializeStarfield+D0   j
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
                dbf     d7,loc_7DEA
                move.w  #$1A0,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
; Animates credits colors and updates starfield
Effect_InitializeStarfield_WaitLoop:                    ; DATA XREF: ROM:00007C40   o  ; was: loc_7E48
                bsr.w   Gfx_AnimateCreditsColors
                bsr.w   Effect_UpdateStarfield
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                clr.w   (word_FF010C).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Effect_InitializeStarfield
; Updates starfield sprite positions using velocity buffers
Effect_UpdateStarfield:                                 ; CODE XREF: Effect_InitializeStarfield+E4   p  ; was: sub_7E66
                                        ; sub_7F06   p
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                lea     (dword_FF1C00).l,a4
                lea     (dword_FF2000).l,a5
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                adda.w  d0,a4
                adda.w  d0,a5
                move.w  #$3A,d7                         ; ':'
loc_7E9C:                                               ; CODE XREF: Effect_UpdateStarfield+44   j
                move.l  (a4)+,d0
                add.l   d0,(a2)+
                move.l  (a5)+,d0
                add.l   d0,(a3)+
                move.l  $C00(a1),d0
                add.l   d0,(a1)+
                dbf     d7,loc_7E9C
                lea     (word_FF1000).l,a2
                lea     (word_FF1400).l,a3
                lea     (dword_FF1800).l,a1
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #8,d0
                adda.w  d0,a2
                adda.w  d0,a3
                adda.w  d0,a1
                lea     (word_FFC680).w,a5
                move.w  #$3A,d7                         ; ':'
loc_7ED8:                                               ; CODE XREF: Effect_UpdateStarfield+9A   j
                move.l  (a2)+,$10(a5)
                move.l  (a3)+,$14(a5)
                move.w  (a1),d0
                addq.w  #4,a1
                andi.w  #$FFF0,d0
                lsr.w   #4,d0
                cmpi.w  #3,d0
                bcs.s   loc_7EF4
                move.w  #2,d0
loc_7EF4:                                               ; CODE XREF: Effect_UpdateStarfield+88   j
                addi.w  #$6364,d0
                move.w  d0,$E(a5)
                adda.w  #$60,a5                         ; '`'
                dbf     d7,loc_7ED8
                rts
; End of function Effect_UpdateStarfield
; Fades out Sega screen and initializes scrolling background system
Cutscene_SegaScreenFadeOut:                             ; DATA XREF: ROM:00007C42   o  ; was: sub_7F06
                bsr.w   Effect_UpdateStarfield
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF010C).l
                bne.w   locret_514E
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr     (Sys_ClearEntityObjectPool).l
                move.l  #dword_11326,(dword_FFA940).w
                move.w  #$800,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                lea     (dword_FF4000).l,a0
                move.l  #$80008000,d1
                move.w  #$7FF,d0
loc_7F7A:                                               ; CODE XREF: Cutscene_SegaScreenFadeOut+76   j
                or.l    d1,(a0)+
                dbf     d0,loc_7F7A
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_SegaScreenFadeOut
; Initializes planet cutscene with scrolling background and palettes
Cutscene_InitPlanetScene:                               ; DATA XREF: ROM:00007C44   o  ; was: sub_7F86
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   locret_514E
                lea     (word_B982).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$FFF2,(word_FF010C).l
                move.b  #6,(word_FFF7E6+1).w
                move.b  #3,(byte_FFA95A).w
                clr.l   (dword_FF0110).l
                clr.l   (dword_FF0114).l
                moveq   #0,d0
                lea     (word_FFE400).w,a0
                move.w  #$1B,d7
loc_7FDC:                                               ; CODE XREF: Cutscene_InitPlanetScene+5C   j
                move.l  d0,(a0)
                adda.w  #$20,a0                         ; ' '
                dbf     d7,loc_7FDC
                lea     (word_FFEC00).w,a0
                move.w  #9,d7
loc_7FEE:                                               ; CODE XREF: Cutscene_InitPlanetScene+6A   j
                move.l  d0,(a0)+
                dbf     d7,loc_7FEE
                lea     (Entity_ObjectPool).w,a5
                move.w  #$CC00,word_FFC622-Entity_ObjectPool(a5)
                move.w  #$10,(a5)
                move.l  #Sprite_SharedGraphicsFrameTable,8(a5)
                move.w  #$8001,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$130,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_18B0CE,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$190,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_18B04A,8(a5)
                move.w  #$8900,$E(a5)
                move.w  #$110,$10(a5)
                move.w  #$D0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   4(a5)
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$D0,(word_FF00D4).l
                move.w  #$118,(word_FF00D6).l
                move.w  #4,(word_FF00D8).l
                move.w  #4,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #1,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr     Cutscene_PlanetRotate(pc)       ; (pc)
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                bsr.w   Cutscene_ResetPlanetFade
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_InitPlanetScene
; Main controller for planet cutscene sequence with fade and scroll
Cutscene_PlanetSequenceCtrl:                            ; DATA XREF: ROM:00007C46   o  ; was: sub_80F8
                bsr.w   Cutscene_PlanetFadeInStep
                bsr.w   Cutscene_PlanetPaletteUpdate
                bsr.w   Gfx_AnimateCreditsColors
                bsr.w   Cutscene_PlanetScroll
                tst.w   (word_FF010C).l
                bne.w   locret_514E
                bsr.w   Gfx_FadeOutPalette
                cmpi.w  #$40,(word_FF00C6).l            ; '@'
                bcs.w   locret_514E
                move.w  #$100,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetSequenceCtrl
; Resets planet fade value to -14 and continues fade logic
Cutscene_ResetPlanetFade:                               ; CODE XREF: Cutscene_InitPlanetScene+168   p  ; was: sub_8130
                move.w  #$FFF2,(word_FF010C).l
                bra.s   loc_8156
; End of function Cutscene_ResetPlanetFade
; Gradually fades in planet scene palette every 8 frames
Cutscene_PlanetFadeInStep:                              ; CODE XREF: Cutscene_PlanetSequenceCtrl   p  ; was: sub_813A
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                tst.w   (word_FF010C).l
                beq.w   locret_514E
                addq.w  #2,(word_FF010C).l
loc_8156:                                               ; CODE XREF: Cutscene_ResetPlanetFade+8   j
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Cutscene_PlanetFadeInStep
; Planet fade out effect
Cutscene_PlanetFadeOut:                                 ; DATA XREF: ROM:00007C48   o  ; was: sub_816E
                bsr.w   Cutscene_PlanetPaletteUpdate
                subq.w  #1,(word_FF0106).l
                bne.w   locret_514E
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetFadeOut
; Transition to next stage
Cutscene_PlanetTransition:                              ; DATA XREF: ROM:00007C4A   o  ; was: sub_8182
                bsr.w   Cutscene_PlanetPaletteUpdate
                bsr.w   Gfx_AnimateCreditsColors
                bsr.w   Cutscene_PlanetScroll
                bsr.w   Gfx_UpdateVDPRegistersWithMask
                tst.w   (word_FF00C6).l
                bne.w   locret_514E
                clr.w   (word_FFC6E2).w
                clr.w   (word_FF0118).l
                move.w  #$140,(word_FF0106).l
                addq.w  #2,(dword_FF8128+2).w
                rts
; End of function Cutscene_PlanetTransition
; Sets sprite graphics pointer from table
Sprite_SetGraphicsPointer:                              ; CODE XREF: Cutscene_PlanetZoomMainLoop+1A   p  ; was: sub_81B4
                                        ; Boss_SnakeAdvanceAnimation+26   p
                moveq   #0,d0
                move.w  d1,d0
                lsl.w   #1,d1
                add.w   d1,d0
                addi.l  #Sprite_SharedGraphicsFrameTable,d0
                move.l  d0,8(a5)
                rts
; End of function Sprite_SetGraphicsPointer
; Updates planet palette
Cutscene_PlanetPaletteUpdate:                           ; CODE XREF: Cutscene_PlanetSequenceCtrl+4   p  ; was: sub_81C8
                                        ; sub_816E   p
                lea     (word_FFC680).w,a5
                move.w  word_FFC684-word_FFC680(a5),d0
                lea     off_81D8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetPaletteUpdate
; ---------------------------------------------------------------------------
off_81D8:       dc.w    Cutscene_PlanetStarfield-*      ; DATA XREF: Cutscene_PlanetPaletteUpdate+8   o
                dc.w    Cutscene_PlanetShipApproach-*
                dc.w    Cutscene_PlanetTextDisplay-*

; Starfield background effect
Cutscene_PlanetStarfield:                               ; DATA XREF: ROM:off_81D8   o  ; was: sub_81DE
                move.l  #$FFFFC000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetStarfield
; Ship approaching planet
Cutscene_PlanetShipApproach:                            ; DATA XREF: ROM:000081DA   o  ; was: sub_81EC
                addi.l  #$200,$1C(a5)
                cmpi.l  #$4000,$1C(a5)
                bne.w   locret_514E
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetShipApproach
; Text display handler
Cutscene_PlanetTextDisplay:                             ; DATA XREF: ROM:000081DC   o  ; was: sub_8206
                subi.l  #$200,$1C(a5)
                cmpi.l  #$FFFFC000,$1C(a5)
                bne.w   locret_514E
                subq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetTextDisplay
; Dispatches to planet sprite handler based on state value
Cutscene_PlanetSpriteHandler:                           ; CODE XREF: Cutscene_PlanetZoomMainLoop+8   p  ; was: sub_8220
                lea     (Entity_ObjectPool).w,a5
                move.w  word_FFC624-Entity_ObjectPool(a5),d0
                lea     off_8230(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetSpriteHandler
; ---------------------------------------------------------------------------
off_8230:       dc.w    Cutscene_InitPlanetZoom-*       ; DATA XREF: Cutscene_PlanetSpriteHandler+8   o
                dc.w    Cutscene_PlanetZoomInStep-*
                dc.w    Cutscene_PlanetZoomPause-*
                dc.w    Cutscene_PlanetZoomComplete-*
                dc.w    nullsub_19-*

; Initializes planet zoom effect with sound and stage setup
Cutscene_InitPlanetZoom:                                ; DATA XREF: ROM:off_8230   o  ; was: sub_823A
                andi.w  #$7FFF,(word_FFC682).w
                ori.w   #$8000,2(a5)
                move.w  #$1A0,(word_FF011A).l
                move.l  #$200000,(dword_FF011C).l
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                move.w  #$10,(word_FF010C).l
                addq.w  #2,4(a5)
                bra.w   Stage_Stage18Init
; End of function Cutscene_InitPlanetZoom
; Zooms planet sprite toward center with scaling and velocity
Cutscene_PlanetZoomInStep:                              ; DATA XREF: ROM:00008232   o  ; was: sub_8272
                bsr.w   Cutscene_AnimatePlanetSprite
                bsr.w   Cutscene_PlanetZoomProgress
                bsr.w   Cutscene_PlanetFadeOutStep
                subi.l  #$8000,(dword_FF011C).l
                subi.w  #4,(word_FF011A).l
                move.w  (word_FF011A).l,d0
                bsr.w   Math_LookupSineCosinePair
                move.l  (dword_FF011C).l,d2
                asl.l   #8,d2
                swap    d2
                muls.w  d2,d0
                asr.l   #7,d0
                move.l  d0,$18(a5)
                muls.w  d2,d1
                asr.l   #8,d1
                move.l  d1,$1C(a5)
                tst.l   (dword_FF011C).l
                bne.w   locret_514E
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,$40(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Cutscene_PlanetZoomInStep
; Pauses between zoom phases and plays sound effect
Cutscene_PlanetZoomPause:                               ; DATA XREF: ROM:00008234   o  ; was: sub_82D2
                bsr.w   Cutscene_AnimatePlanetSprite
                subq.w  #1,$40(a5)
                bne.w   locret_514E
                move.b  #$31,d0                         ; '1'
                jsr     (Sound_PlaySFX).l
                move.w  #8,(word_FF010C).l
                move.l  #$74000,$18(a5)
                move.l  #$57000,$1C(a5)
                addq.w  #2,4(a5)
                bra.w   Effect_CreatePlanetDebris
; End of function Cutscene_PlanetZoomPause
; Completes planet zoom by moving sprite off-screen
Cutscene_PlanetZoomComplete:                            ; DATA XREF: ROM:00008236   o  ; was: sub_8308
                bsr.w   Cutscene_AnimatePlanetSprite
                bsr.w   Cutscene_PlanetZoomProgress
                bsr.w   Cutscene_PlanetFadeOutStep
                bsr.w   Effect_UpdatePlanetDebris
                subi.l  #$4000,$18(a5)
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$120,$10(a5)
                bcs.w   locret_514E
                clr.w   2(a5)
                addq.w  #2,4(a6)
                rts
; End of function Cutscene_PlanetZoomComplete
nullsub_19:                                             ; DATA XREF: ROM:00008238   o
                rts
; End of function nullsub_19

; Creates debris sprite with velocity for planet explosion effect
Effect_CreatePlanetDebris:                              ; CODE XREF: Cutscene_PlanetZoomPause+32   j  ; was: sub_833E
                lea     (word_FFD820).w,a4
                move.w  #$EC00,word_FFD822-word_FFD820(a4)
                move.w  #$10,(a4)
                move.l  #off_18B13C,8(a4)
                move.w  #$8100,$E(a4)
                clr.w   $C(a4)
                clr.w   4(a4)
                move.w  $14(a5),$14(a4)
                move.w  $10(a5),$10(a4)
                move.l  #$FFFC0000,$18(a4)
                move.l  #$FFFD0000,$1C(a4)
                rts
; End of function Effect_CreatePlanetDebris
; Updates debris sprite position and clears when off-screen
Effect_UpdatePlanetDebris:                              ; CODE XREF: Cutscene_PlanetZoomComplete+C   p  ; was: sub_8380
                lea     (word_FFD820).w,a4
                addi.l  #$4000,dword_FFD838-word_FFD820(a4)
                addi.l  #$3000,$1C(a4)
                cmpi.w  #$80,$C(a4)
                bcs.w   locret_514E
                clr.w   2(a4)
                rts
; End of function Effect_UpdatePlanetDebris
; Stage 18 initialization
Stage_Stage18Init:                                      ; CODE XREF: Cutscene_InitPlanetZoom+34   j  ; was: sub_83A4
                lea     (word_FFC740).w,a4
                move.w  #$1F,d7
loc_83AC:                                               ; CODE XREF: Stage_Stage18Init+68   j
                move.w  #$EC00,2(a4)
                move.w  #$10,(a4)
                move.l  #off_18B11C,8(a4)
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
                dbf     d7,loc_83AC
                rts
; End of function Stage_Stage18Init
; Iterates through sprites and clears those beyond screen bounds
Effect_ClearOffscreenSprites:                           ; CODE XREF: Cutscene_PlanetZoomMainLoop+C   p  ; was: sub_8412
                lea     (word_FFC740).w,a5
                move.w  #$1F,d7
loc_841A:                                               ; CODE XREF: Effect_ClearOffscreenSprites+10   j
                bsr.w   Effect_CheckAndClearSprite
                adda.w  #$60,a5                         ; '`'
                dbf     d7,loc_841A
                rts
; End of function Effect_ClearOffscreenSprites
; Checks if sprite animation counter exceeds threshold and clears
Effect_CheckAndClearSprite:                             ; CODE XREF: Effect_ClearOffscreenSprites:loc_841A   p  ; was: sub_8428
                cmpi.w  #$80,$C(a5)
                bcs.w   locret_514E
                clr.w   2(a5)
                rts
; End of function Effect_CheckAndClearSprite
; Fades out planet palette gradually with timing control
Cutscene_PlanetFadeOutStep:                             ; CODE XREF: Cutscene_PlanetZoomInStep+8   p  ; was: sub_8438
                                        ; Cutscene_PlanetZoomComplete+8   p
                tst.w   (word_FF010C).l
                beq.w   locret_514E
                move.w  (word_FFA280).w,d0
                andi.w  #1,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Cutscene_PlanetFadeOutStep
; Animates planet sprite attribute cycling through 4 values
Cutscene_AnimatePlanetSprite:                           ; CODE XREF: Cutscene_PlanetZoomInStep   p  ; was: sub_846C
                                        ; sub_82D2   p
                move.w  (word_FFA280).w,d0
                andi.w  #3,d0
                lsl.w   #1,d0
                move.w  word_847E(pc,d0.w),(word_FFC62E).w
                rts
; End of function Cutscene_AnimatePlanetSprite
; ---------------------------------------------------------------------------
word_847E:      dc.w    1, $801, $1801, $1001

; Increments planet zoom level with variable speed
Cutscene_PlanetZoomProgress:                            ; CODE XREF: Cutscene_PlanetZoomInStep+4   p  ; was: sub_8486
                                        ; Cutscene_PlanetZoomComplete+4   p
                cmpi.w  #$3E,(word_FF0118).l            ; '>'
                beq.w   locret_514E
                cmpi.w  #$20,(word_FF0118).l            ; ' '
                bcc.s   loc_84B2
                move.w  (word_FF0106).l,d0
                andi.w  #3,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0118).l
                rts
; ---------------------------------------------------------------------------
loc_84B2:                                               ; CODE XREF: Cutscene_PlanetZoomProgress+14   j
                move.w  (word_FF0106).l,d0
                andi.w  #1,d0
                bne.w   locret_514E
                addq.w  #2,(word_FF0118).l
                rts
; End of function Cutscene_PlanetZoomProgress
; Main loop for planet zoom cutscene with subsystem coordination
Cutscene_PlanetZoomMainLoop:                            ; DATA XREF: ROM:00007C4C   o  ; was: sub_84C8
                bsr.w   Gfx_AnimateCreditsColors
                bsr.w   Cutscene_PlanetPaletteUpdate
                bsr.w   Cutscene_PlanetSpriteHandler
                bsr.w   Effect_ClearOffscreenSprites
                lea     (Entity_ObjectPool).w,a5
                move.w  (word_FF0118).l,d1
                bsr.w   Sprite_SetGraphicsPointer
                bsr.w   Cutscene_Calculate3DRotation
                subq.w  #1,(word_FF0106).l
                beq.w   Cutscene_FinalizePlanetZoom
                cmpi.w  #$80,(word_FF0106).l
                bne.w   locret_514E
                move.b  #1,d0
                jmp     (Input_ProcessButtons).l
; End of function Cutscene_PlanetZoomMainLoop
; Calculates 3D rotation perspective and updates scroll buffers
Cutscene_Calculate3DRotation:                           ; CODE XREF: Cutscene_PlanetZoomMainLoop+1E   p  ; was: sub_850A
                                        ; sub_85CC   p
                addi.l  #$80,(dword_FF0114).l
                move.l  (dword_FF0114).l,d0
                add.l   d0,(dword_FF0110).l
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #2,d3
                move.l  d1,d0
                asr.l   #1,d0
                neg.l   d0
                lea     (word_FFE5C0).w,a0
                move.w  #$D,d7
loc_8538:                                               ; CODE XREF: Cutscene_Calculate3DRotation+3C   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #$20,a0                         ; ' '
                dbf     d7,loc_8538
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asr.l   #1,d0
                lea     (word_FFE5A0).w,a0
                move.w  #$D,d7
loc_855C:                                               ; CODE XREF: Cutscene_Calculate3DRotation+60   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #$20,a0                         ; ' '
                dbf     d7,loc_855C
                move.l  (dword_FF0110).l,d1
                move.l  d1,d3
                asr.l   #1,d3
                move.l  d1,d0
                neg.l   d0
                asl.l   #1,d1
                lea     (word_FFEC28).w,a0
                move.w  #9,d7
loc_8586:                                               ; CODE XREF: Cutscene_Calculate3DRotation+8A   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                sub.l   d1,d0
                adda.w  #4,a0
                dbf     d7,loc_8586
                move.l  (dword_FF0110).l,d1
                move.l  d1,d0
                asl.l   #1,d1
                lea     (word_FFEC24).w,a0
                move.w  #9,d7
loc_85AA:                                               ; CODE XREF: Cutscene_Calculate3DRotation+AE   j
                move.l  d0,d2
                swap    d2
                move.w  d2,(a0)
                add.l   d3,d1
                add.l   d1,d0
                suba.w  #4,a0
                dbf     d7,loc_85AA
                rts
; End of function Cutscene_Calculate3DRotation
; Finalizes planet zoom cutscene and sets transition timer
Cutscene_FinalizePlanetZoom:                            ; CODE XREF: Cutscene_PlanetZoomMainLoop+28   j  ; was: sub_85BE
                clr.w   (word_FF010C).l
                move.w  #$18,(dword_FF8128+2).w
                rts
; End of function Cutscene_FinalizePlanetZoom
; Handles fade out during planet zoom with completion check
Cutscene_PlanetZoomFadeOut:                             ; DATA XREF: ROM:00007C4E   o  ; was: sub_85CC
                bsr.w   Cutscene_Calculate3DRotation
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_514E
                subq.w  #2,(word_FF010C).l
                move.w  (word_FF010C).l,d0
                lea     (word_FFE302).w,a0
                move.w  #$3E,d5                         ; '>'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                cmpi.w  #$FFF2,(word_FF010C).l
                bne.w   locret_514E
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.w  #1,(dword_FF8128).w
                rts
; End of function Cutscene_PlanetZoomFadeOut
; Looks up sine and cosine values from table with angle wrapping
