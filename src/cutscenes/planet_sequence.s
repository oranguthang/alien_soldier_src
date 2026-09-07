Cutscene_PlanetDispatcher:
                move.w  (word_FF00EE).l,d0  ; was: sub_5150
                lea     off_515E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_PlanetDispatcher
; ---------------------------------------------------------------------------
off_515E:       dc.w Cutscene_InitPlanetState-*         ; DATA XREF: Cutscene_PlanetDispatcher+6   o
                dc.w Cutscene_SetupPlanetRotate-*
                dc.w Cutscene_PlanetZoomIn-*
                dc.w Cutscene_PlanetHold-*
                dc.w Cutscene_PlanetZoomOut-*
                dc.w Cutscene_PlanetZoomOut-*
                dc.w Cutscene_InitPlanetZoomIn-*
                dc.w Cutscene_PlanetFadeOutAlt-*
                dc.w Cutscene_UpdatePlanetGraphics-*
                dc.w Cutscene_PlanetFadeInAlt-*
                dc.w nullsub_15-*


; Initializes planet cutscene state machine and advances state index
Cutscene_InitPlanetState:                               ; DATA XREF: ROM:off_515E   o  ; was: sub_5174
                move.w  #1,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_InitPlanetState
; Sets up planet rotation cutscene with sprite parameters and VDP settings
Cutscene_SetupPlanetRotate:                               ; DATA XREF: ROM:00005160   o  ; was: sub_5184
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
                lea     (word_FFC9E0).w,a5
                move.w  #$CC00,word_FFC9E2-word_FFC9E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D38,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$C0,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$120,(word_FF00D4).l
                move.w  #$C0,(word_FF00D6).l
                move.w  #1,(word_FF00D8).l
                move.w  #3,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #3,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr Cutscene_PlanetRotate(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_SetupPlanetRotate
; Animates planet zooming in with rotation and palette fade out
Cutscene_PlanetZoomIn:                               ; DATA XREF: ROM:00005162   o  ; was: sub_5214
                addi.l  #$80,(dword_FFC9F8).w
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_FadeOutPalette
                bsr.w Gfx_UpdatePlanetPalette
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetZoomIn
; Holds planet rotation during cutscene while timer counts down
Cutscene_PlanetHold:                               ; DATA XREF: ROM:00005164   o  ; was: sub_5244
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
; End of function Cutscene_PlanetHold
; Advances planet cutscene to next state by incrementing state index
Cutscene_AdvancePlanetState:
                addq.w  #2,(word_FF00EE).l  ; was: sub_5256
                rts
; End of function Cutscene_AdvancePlanetState
; Animates planet zooming out with reverse rotation and palette fade in
Cutscene_PlanetZoomOut:                               ; DATA XREF: ROM:00005166   o  ; was: sub_525E
                                        ; ROM:00005168   o
                subi.l  #$80,(dword_FFC9F8).w
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdateVDPRegistersWithMask
                bsr.w Gfx_UpdatePlanetPalette
                tst.w   (word_FF00C6).l
                bpl.w   locret_514E
                clr.l   (dword_FFC9F8).w
                move.w  #$100,(word_FF00F2).l
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetZoomOut
; Initializes planet zoom-in animation during Sega screen cutscene
Cutscene_InitPlanetZoomIn:                               ; DATA XREF: ROM:0000516A   o  ; was: sub_5290
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
                subq.w  #1,(word_FF00F2).l
                bne.w   locret_514E
                lea     (word_FFC9E0).w,a5
                move.w  #$CC00,word_FFC9E2-word_FFC9E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189DBC,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$180,$10(a5)
                move.w  #$120,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,(word_FFC9E2).w
                move.w  #$4E0,(word_FF00DC).l
                move.w  #$120,(word_FF00D4).l
                move.w  #$180,(word_FF00D6).l
                move.w  #3,(word_FF00D8).l
                move.w  #1,(word_FF00DA).l
                move.l  #$5C000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #3,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr Cutscene_PlanetRotate(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_InitPlanetZoomIn
; Fades out planet during Sega screen cutscene (alternate)
Cutscene_PlanetFadeOutAlt:                               ; DATA XREF: ROM:0000516C   o  ; was: sub_532E
                ori.w   #$8000,(word_FFC9E2).w
                subi.l  #$40,(dword_FFC9FC).w ; '@'
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_FadeOutPalette
                bsr.w Gfx_UpdatePlanetPalette
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_514E
; End of function Cutscene_PlanetFadeOutAlt
; Sets delay timer to $80 frames and advances cutscene state
Cutscene_SetDelayAndAdvance:
                move.w  #$80,(word_FF00F2).l  ; was: sub_5354
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_SetDelayAndAdvance
; Updates planet graphics during cutscene
Cutscene_UpdatePlanetGraphics:                               ; DATA XREF: ROM:0000516E   o  ; was: sub_5364
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdatePlanetPalette
; End of function Cutscene_UpdatePlanetGraphics
; Waits for delay timer to expire before advancing cutscene state
Cutscene_WaitDelayTimer:
                subq.w  #1,(word_FF00F2).l  ; was: sub_536C
                bne.w   locret_514E
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_WaitDelayTimer
; Fades in planet during Sega screen cutscene (alternate)
Cutscene_PlanetFadeInAlt:                               ; DATA XREF: ROM:00005170   o  ; was: sub_537E
                addi.l  #$40,(dword_FFC9FC).w ; '@'
                bsr.w Cutscene_CopyPlanetCoords
                bsr.w Gfx_UpdateVDPRegistersWithMask
                bsr.w Gfx_UpdatePlanetPalette
                tst.w   (word_FF00C6).l
                bpl.w   locret_514E
                clr.w   (word_FFC9E2).w
                addq.w  #2,(word_FF00EE).l
                rts
; End of function Cutscene_PlanetFadeInAlt
nullsub_15:                             ; DATA XREF: ROM:00005172   o
                rts
; End of function nullsub_15


; State machine dispatcher for second cutscene sequence
Cutscene_StateMachine2:
                move.w  (word_FF00F0).l,d0  ; was: sub_53AA
                lea     off_53B8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_StateMachine2
; ---------------------------------------------------------------------------
off_53B8:       dc.w Cutscene_InitShipDelay-*         ; DATA XREF: Cutscene_StateMachine2+6   o
                dc.w Cutscene_InitShipSprite-*
                dc.w Cutscene_ShipFadeOut-*
                dc.w Cutscene_WaitShipDelay-*
                dc.w Cutscene_ShipFadeIn-*
                dc.w Cutscene_InitShipSprite2-*
                dc.w Cutscene_ShipZoomIn-*
                dc.w Cutscene_WaitShipDelay2-*
                dc.w Cutscene_ShipZoomOut-*
                dc.w nullsub_16-*


; Initializes delay timer to $100 frames for ship animation
Cutscene_InitShipDelay:                               ; DATA XREF: ROM:off_53B8   o  ; was: sub_53CC
                move.w  #$100,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipDelay
; Initializes ship sprite data during Sega screen cutscene
Cutscene_InitShipSprite:                               ; DATA XREF: ROM:000053BA   o  ; was: sub_53DC
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                lea     (word_FFCA40).w,a5
                move.w  #$CC00,word_FFCA42-word_FFCA40(a5)
                move.w  #$10,(a5)
                move.l  #word_189D8C,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$180,$10(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$4F0,(word_FF00E6).l
                move.w  #$C0,(word_FF00DE).l
                move.w  #$180,(word_FF00E0).l
                move.w  #1,(word_FF00E2).l
                move.w  #3,(word_FF00E4).l
                move.l  #$5E000002,(dword_FF00CA).l
                move.w  #$F,(word_FF00CE).l
                move.w  #3,(word_FF00D2).l
                clr.w   (word_FF00D0).l
                jsr Cutscene_ClearSpriteBuffer(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipSprite
; Fades out ship sprite during cutscene
Cutscene_ShipFadeOut:                               ; DATA XREF: ROM:000053BC   o  ; was: sub_546C
                subi.l  #$80,(dword_FFCA58).w
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeOutShip
                bsr.w Gfx_UpdateShipPalette
                cmpi.w  #$40,(word_FF00D0).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipFadeOut
; Updates ship graphics and waits for delay timer
Cutscene_WaitShipDelay:                               ; DATA XREF: ROM:000053BE   o  ; was: sub_549C
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_WaitShipDelay
; Fades in ship sprite during cutscene
Cutscene_ShipFadeIn:                               ; DATA XREF: ROM:000053C0   o  ; was: sub_54B6
                addi.l  #$80,(dword_FFCA58).w
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeInShip
                bsr.w Gfx_UpdateShipPalette
                tst.w   (word_FF00D0).l
                bpl.w   locret_514E
                clr.l   (dword_FFCA58).w
                move.w  #$100,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipFadeIn
; Initializes second ship sprite configuration
Cutscene_InitShipSprite2:                               ; DATA XREF: ROM:000053C2   o  ; was: sub_54E8
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                lea     (word_FFCA40).w,a5
                move.w  #$CC00,word_FFCA42-word_FFCA40(a5)
                move.w  #$10,(a5)
                move.l  #word_189DEC,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$C0,$10(a5)
                move.w  #$C0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                andi.w  #$7FFF,(word_FFCA42).w
                move.w  #$4F0,(word_FF00E6).l
                move.w  #$C0,(word_FF00DE).l
                move.w  #$C0,(word_FF00E0).l
                move.w  #3,(word_FF00E2).l
                move.w  #1,(word_FF00E4).l
                move.l  #$5E000002,(dword_FF00CA).l
                move.w  #$F,(word_FF00CE).l
                move.w  #3,(word_FF00D2).l
                clr.w   (word_FF00D0).l
                jsr Cutscene_ClearSpriteBuffer(pc)    ; (pc)
                nop
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_InitShipSprite2
; Zooms in ship sprite by increasing rotation value
Cutscene_ShipZoomIn:                               ; DATA XREF: ROM:000053C4   o  ; was: sub_5586
                ori.w   #$8000,(word_FFCA42).w
                addi.l  #$40,(dword_FFCA5C).w ; '@'
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeOutShip
                bsr.w Gfx_UpdateShipPalette
                cmpi.w  #$40,(word_FF00D0).l ; '@'
                bne.w   locret_514E
                move.w  #$80,(word_FF00F4).l
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipZoomIn
; Updates ship graphics and waits for delay timer
Cutscene_WaitShipDelay2:                               ; DATA XREF: ROM:000053C6   o  ; was: sub_55BC
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Gfx_UpdateShipPalette
                subq.w  #1,(word_FF00F4).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_WaitShipDelay2
; Zooms out ship sprite by decreasing rotation value
Cutscene_ShipZoomOut:                               ; DATA XREF: ROM:000053C8   o  ; was: sub_55D6
                subi.l  #$40,(dword_FFCA5C).w ; '@'
                bsr.w Cutscene_RenderSpriteGrid
                bsr.w Cutscene_FadeInShip
                bsr.w Gfx_UpdateShipPalette
                tst.w   (word_FF00D0).l
                bpl.w   locret_514E
                clr.w   (word_FFCA42).w
                addq.w  #2,(word_FF00F0).l
                rts
; End of function Cutscene_ShipZoomOut
nullsub_16:                             ; DATA XREF: ROM:000053CA   o
                rts
; End of function nullsub_16


; State machine dispatcher for star field animation
Cutscene_StateMachine3:
                move.w  (word_FF00EA).l,d0  ; was: sub_5602
                lea     off_5610(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Cutscene_StateMachine3
; ---------------------------------------------------------------------------
off_5610:       dc.w Cutscene_InitStarDelay-*         ; DATA XREF: Cutscene_StateMachine3+6   o
                dc.w Cutscene_InitStarSprites-*
                dc.w Cutscene_AnimateStars-*
                dc.w Cutscene_WaitTimerDelay-*
                dc.w Cutscene_FadeStarObjects-*
                dc.w nullsub_17-*


; Initializes long delay timer for star field sequence
Cutscene_InitStarDelay:                               ; DATA XREF: ROM:off_5610   o  ; was: sub_561C
                move.w  #$2480,(word_FF00FE).l
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_InitStarDelay
; Initializes multiple star sprite objects for parallax effect
Cutscene_InitStarSprites:                               ; DATA XREF: ROM:00005612   o  ; was: sub_562C
                subq.w  #1,(word_FF00FE).l
                bne.w   locret_514E
                lea     (Entity_ObjectPool).w,a5
                move.w  #$CC00,word_FFC622-Entity_ObjectPool(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC680).w,a5
                move.w  #$CC00,word_FFC682-word_FFC680(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC6E0).w,a5
                move.w  #$CC00,word_FFC6E2-word_FFC6E0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC740).w,a5
                move.w  #$CC00,word_FFC742-word_FFC740(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$9C,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC7A0).w,a5
                move.w  #$CC00,word_FFC7A2-word_FFC7A0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC800).w,a5
                move.w  #$CC00,word_FFC802-word_FFC800(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC860).w,a5
                move.w  #$CC00,word_FFC862-word_FFC860(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC8C0).w,a5
                move.w  #$CC00,word_FFC8C2-word_FFC8C0(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$20,$10(a5) ; ' '
                move.w  #$C4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC920).w,a5
                move.w  #$CC00,word_FFC922-word_FFC920(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$ED00,$E(a5)
                move.w  #$110,$10(a5)
                move.w  #$B0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (word_FFC980).w,a5
                move.w  #$CC00,word_FFC982-word_FFC980(a5)
                move.w  #$10,(a5)
                move.l  #word_189D68,8(a5)
                move.w  #$E500,$E(a5)
                move.w  #$130,$10(a5)
                move.w  #$B0,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   (word_FF00E8).l
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_InitStarSprites
; Animates star sprites and advances state after 20 cycles
Cutscene_AnimateStars:                               ; DATA XREF: ROM:00005614   o  ; was: sub_5824
                addq.w  #1,(word_FF00E8).l
                bsr.w Cutscene_UpdateStarPositions
                cmpi.w  #$14,(word_FF00E8).l
                bne.w   locret_514E
                move.w  #$40,(word_FF00FE).l ; '@'
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_AnimateStars
; Waits for timer countdown before advancing cutscene state
Cutscene_WaitTimerDelay:                               ; DATA XREF: ROM:00005616   o  ; was: sub_584A
                subq.w  #1,(word_FF00FE).l
                bne.w   locret_514E
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_WaitTimerDelay
; Fades out star objects by decrementing timer and clearing object slots
Cutscene_FadeStarObjects:                               ; DATA XREF: ROM:00005618   o  ; was: sub_585C
                subq.w  #1,(word_FF00E8).l
                bsr.w Cutscene_UpdateStarPositions
                tst.w   (word_FF00E8).l
                bpl.w   locret_514E
                lea     (word_FFC622).w,a0
                move.w  #9,d0
loc_5878:                               ; CODE XREF: Cutscene_FadeStarObjects+22   j
                clr.w   (a0)
                adda.w  #$60,a0 ; '`'
                dbf     d0,loc_5878
                addq.w  #2,(word_FF00EA).l
                rts
; End of function Cutscene_FadeStarObjects
nullsub_17:                             ; DATA XREF: ROM:0000561A   o
                rts
; End of function nullsub_17


; Dispatches story screen text rendering states
