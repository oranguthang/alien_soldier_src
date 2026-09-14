Entity_UpdateSevenForcesIntro:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_54B84
                move.w  4(a5),d0
                beq.w   Entity_SevenForcesNoOpState
                movea.w Entity_SevenForcesIntroStateOffsets(pc,d0.w),a0
                adda.l  #Entity_SevenForcesIntroInitState0,a0
                jmp     (a0)
; End of function Entity_UpdateSevenForcesIntro
; ---------------------------------------------------------------------------
Entity_SevenForcesIntroStateOffsets:    dc.w    Entity_SevenForcesIntroInitState0-Entity_SevenForcesIntroInitState0  ; was: off_54B98
                                        ; DATA XREF: Entity_UpdateSevenForcesIntro+8   r
                dc.w    Entity_SevenForcesIntroInitState0-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesEntranceState4-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSwitchTransformationFrameState6-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesWaitForTransformationState8-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesBeginFormSequenceStateA-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesValkirieFadeInStateC-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesValkirieFadeOutStateE-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesStartMedusaEntranceState10-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesUpdateMedusaEntranceState12-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesMedusaHoldState14-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesMedusaFadeOutState16-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesStartSylpheedEntranceState18-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesUpdateSylpheedEntranceState1A-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSylpheedHoldState1C-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesWaitForSylpheedScrollState1E-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSylpheedFadeOutState20-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesStartArtemisEntranceState22-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesUpdateArtemisEntranceState24-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesWaitForArtemisSignalState26-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesArtemisFadeOutState28-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesStartSireneEntranceState2A-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesUpdateSireneEntranceState2C-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSireneHoldState2E-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesResetState30-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSirenePaletteEventState32-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesSirenePaletteEventState34-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesExplosionSequenceState36-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesExplosionWaitState38-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesArmFinalFadeState3A-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesFinalFadeState3C-Entity_SevenForcesIntroInitState0
                dc.w    Entity_SevenForcesFinishIntroState3E-Entity_SevenForcesIntroInitState0

; State 0/2 entry: initialize the Seven Forces intro entity
Entity_SevenForcesIntroInitState0:                      ; DATA XREF: Entity_UpdateSevenForcesIntro+C   o  ; was: sub_54BD8
                                        ; ROM:Entity_SevenForcesIntroStateOffsets   o
                bra.w   Entity_InitSevenForcesIntro
; End of function Entity_SevenForcesIntroInitState0
; Configure the Seven Forces intro state and three VDP DMA channels
; No static caller is present in the reconstructed ROM
SevenForces_SetupIntroDma:                              ; was: sub_54BDC
                move.w  #4,4(a5)
                move.b  #6,(VDPReg11Shadow+1).w
                move.b  #$8A,(VDPReg17Shadow+1).w
                move.b  #3,(PlaneAScrollModeFlags).w
                move.b  #3,(PlaneBScrollModeFlags).w
                move.w  #$58,(RasterEffectIndex).w      ; 'X'
                clr.w   (RasterEffectInitState).w
                move.w  #$4000,(TilemapTransferBase).w
                move.w  #1,(TilemapRowXOrFillWord).w
                jsr     (Tilemap_FillPlaneDirectToVRAM).l
                move.w  #$6000,(TilemapTransferBase).w
                move.w  #2,(TilemapRowXOrFillWord).w
                jsr     (Tilemap_FillPlaneDirectToVRAM).l
                move.w  #$5000,(TilemapTransferBase).w
                move.w  #0,(TilemapRowXOrFillWord).w
                jsr     (Tilemap_FillPlaneDirectToVRAM).l
                rts
; End of function SevenForces_SetupIntroDma
; Initialize the Seven Forces entrance sprite and palette
Entity_InitSevenForcesIntro:                            ; CODE XREF: Entity_SevenForcesIntroInitState0   j  ; was: sub_54C3C
                move.w  #4,4(a5)
                move.w  #$E900,2(a5)
                move.w  #$2300,$E(a5)
                move.b  #$14,$20(a5)
                move.l  #Stage24SceneObject_SpriteAnimation,8(a5)
                clr.w   $C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$60,$10(a5)                    ; '`'
                move.w  #$128,$14(a5)
                lea     (SevenForcesIntroPaletteCommand).l,a0
                jmp     Gfx_LoadPaletteCommand
; End of function Entity_InitSevenForcesIntro
; State 4 entry thunk for the Seven Forces entrance timer
Entity_SevenForcesEntranceState4:                       ; DATA XREF: ROM:00054B9C   o  ; was: sub_54C7E
                bra.w   Entity_UpdateSevenForcesEntranceState4
; End of function Entity_SevenForcesEntranceState4
; Exercise paired scroll-table generators with live directional input
; No static caller is present in the reconstructed ROM
Debug_SevenForcesScrollTableTest:                       ; was: sub_54C82
                btst    #6,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckAlternateLayerInput
                btst    #0,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckVerticalPositiveInput
                subi.l  #$800,(SharedPatternRow0Long1).w
                subi.l  #$400,(SharedPatternRow0Long3).w
Debug_SevenForcesScrollTableTestCheckVerticalPositiveInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+E   j  ; was: loc_54CA2
                btst    #1,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckHorizontalPositiveInput
                addi.l  #$800,(SharedPatternRow0Long1).w
                addi.l  #$400,(SharedPatternRow0Long3).w
Debug_SevenForcesScrollTableTestCheckHorizontalPositiveInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+26   j  ; was: loc_54CBA
                btst    #3,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckHorizontalNegativeInput
                addi.l  #$800,(SharedPatternRow0Long0).w
                addi.l  #$400,(SharedPatternRow0Long2).w
Debug_SevenForcesScrollTableTestCheckHorizontalNegativeInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+3E   j  ; was: loc_54CD2
                btst    #2,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckAlternateLayerInput
                subi.l  #$800,(SharedPatternRow0Long0).w
                subi.l  #$400,(SharedPatternRow0Long2).w
Debug_SevenForcesScrollTableTestCheckAlternateLayerInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+6   j  ; was: loc_54CEA
                                        ; Debug_SevenForcesScrollTableTest+56   j
                btst    #4,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckResetInput
                btst    #0,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckAlternateVerticalPositiveInput
                subi.l  #$800,(SharedPatternRow0Long5).w
                subi.l  #$400,(SharedPatternRow0Long7).w
Debug_SevenForcesScrollTableTestCheckAlternateVerticalPositiveInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+76   j  ; was: loc_54D0A
                btst    #1,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckAlternateHorizontalPositiveInput
                addi.l  #$800,(SharedPatternRow0Long5).w
                addi.l  #$400,(SharedPatternRow0Long7).w
Debug_SevenForcesScrollTableTestCheckAlternateHorizontalPositiveInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+8E   j  ; was: loc_54D22
                btst    #3,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckAlternateHorizontalNegativeInput
                addi.l  #$800,(SharedPatternRow0Long4).w
                addi.l  #$400,(SharedPatternRow0Long6).w
Debug_SevenForcesScrollTableTestCheckAlternateHorizontalNegativeInput:  ; CODE XREF: Debug_SevenForcesScrollTableTest+A6   j  ; was: loc_54D3A
                btst    #2,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestCheckResetInput
                subi.l  #$800,(SharedPatternRow0Long4).w
                subi.l  #$400,(SharedPatternRow0Long6).w
Debug_SevenForcesScrollTableTestCheckResetInput:        ; CODE XREF: Debug_SevenForcesScrollTableTest+6E   j  ; was: loc_54D52
                                        ; Debug_SevenForcesScrollTableTest+BE   j
                btst    #5,(ControllerHeldState).w
                beq.s   Debug_SevenForcesScrollTableTestAccumulateOffsets
                clr.l   (SharedPatternRow0Long0).w
                clr.l   (SharedPatternRow0Long2).w
                clr.l   (SharedPatternRow0Long4).w
                clr.l   (SharedPatternRow0Long6).w
                clr.l   (SharedPatternRow0Long1).w
                clr.l   (SharedPatternRow0Long3).w
                clr.l   (SharedPatternRow0Long5).w
                clr.l   (SharedPatternRow0Long7).w
                clr.l   (SharedPatternRow1Long0).w
                clr.l   (SharedPatternRow1Long2).w
                clr.l   (SharedPatternRow1Long4).w
                clr.l   (SharedPatternRow1Long6).w
                clr.l   (SharedPatternRow1Long1).w
                clr.l   (SharedPatternRow1Long3).w
                clr.l   (SharedPatternRow1Long5).w
                clr.l   (SharedPatternRow1Long7).w
Debug_SevenForcesScrollTableTestAccumulateOffsets:      ; CODE XREF: Debug_SevenForcesScrollTableTest+D6   j  ; was: loc_54D9A
                move.l  (SharedPatternRow0Long0).w,d0
                add.l   d0,(SharedPatternRow1Long0).w
                move.l  (SharedPatternRow0Long2).w,d0
                add.l   d0,(SharedPatternRow1Long2).w
                move.l  (SharedPatternRow0Long1).w,d0
                add.l   d0,(SharedPatternRow1Long1).w
                move.l  (SharedPatternRow0Long3).w,d0
                add.l   d0,(SharedPatternRow1Long3).w
                move.l  (SharedPatternRow0Long4).w,d0
                add.l   d0,(SharedPatternRow1Long4).w
                move.l  (SharedPatternRow0Long6).w,d0
                add.l   d0,(SharedPatternRow1Long6).w
                move.l  (SharedPatternRow0Long5).w,d0
                add.l   d0,(SharedPatternRow1Long5).w
                move.l  (SharedPatternRow0Long7).w,d0
                add.l   d0,(SharedPatternRow1Long7).w
                move.l  (SharedPatternRow1Long0).w,d3
                move.l  (SharedPatternRow1Long4).w,d4
                move.l  (SharedPatternRow1Long1).w,d5
                move.l  (SharedPatternRow1Long5).w,d6
                btst    #0,(FrameCounter+1).w
                bne.s   Debug_SevenForcesScrollTableTestBuildTables
                move.l  (SharedPatternRow1Long2).w,d3
                move.l  (SharedPatternRow1Long6).w,d4
                move.l  (SharedPatternRow1Long3).w,d5
                move.l  (SharedPatternRow1Long7).w,d6
Debug_SevenForcesScrollTableTestBuildTables:            ; CODE XREF: Debug_SevenForcesScrollTableTest+16E   j  ; was: loc_54E02
                movea.w #(HScrollBuffer-M68K_RAM),a0
                movea.w #(HScrollAuxBuffer-M68K_RAM),a1
                moveq   #$F,d7
                moveq   #0,d1
                moveq   #0,d2
Debug_SevenForcesScrollTableTestBuildPrimaryLoop:       ; CODE XREF: Debug_SevenForcesScrollTableTest+1B6   j  ; was: loc_54E10
                lea     -$20(a1),a1
                swap    d1
                move.w  d1,(a0)
                neg.w   d1
                move.w  d1,(a1)
                neg.w   d1
                swap    d1
                add.l   d3,d1
                swap    d2
                move.w  d2,2(a0)
                neg.w   d2
                move.w  d2,2(a1)
                neg.w   d2
                swap    d2
                add.l   d4,d2
                lea     $20(a0),a0
                dbf     d7,Debug_SevenForcesScrollTableTestBuildPrimaryLoop
                movea.w #(VScrollBuffer-M68K_RAM),a0
                movea.w #(VScrollAuxBuffer-M68K_RAM),a1
                moveq   #9,d7
                moveq   #0,d1
                moveq   #0,d2
Debug_SevenForcesScrollTableTestBuildSecondaryLoop:     ; CODE XREF: Debug_SevenForcesScrollTableTest+1E4   j  ; was: loc_54E4A
                swap    d1
                swap    d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                neg.w   d2
                move.w  d2,-(a1)
                neg.w   d2
                neg.w   d1
                move.w  d1,-(a1)
                neg.w   d1
                swap    d1
                swap    d2
                add.l   d5,d1
                add.l   d6,d2
                dbf     d7,Debug_SevenForcesScrollTableTestBuildSecondaryLoop
                movea.w #(SevenForcesPattern-M68K_RAM),a0
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                movea.w #(SevenForcesPattern-M68K_RAM),a0
                move.w  #$20,d0                         ; ' '
                move.w  #$8F02,d3
                move.l  #$94009320,d4
                jsr     (VDP_QueueCommand_Build).l
                move.w  #0,(PaletteActiveColor12).w
                btst    #0,(FrameCounter+1).w
                bne.s   Debug_SevenForcesScrollTableTestWriteAlternateMarkers
                move.w  #$FCCC,(SevenForcesPatchA).w
                move.w  #$ECCC,(SevenForcesPatchB).w
                move.w  #$2CCC,(SevenForcesPatchC).w
                move.w  #$1CCC,(SevenForcesPatchD).w
                move.w  #$E0,(PaletteActiveColor14).w
                move.w  #$E0,(PaletteActiveColor15).w
                move.w  #$E0,(PaletteActiveColor01).w
                move.w  #$E0,(PaletteActiveColor02).w
                rts
; ---------------------------------------------------------------------------
Debug_SevenForcesScrollTableTestWriteAlternateMarkers:  ; CODE XREF: Debug_SevenForcesScrollTableTest+23C   j  ; was: loc_54EF2
                move.w  #$CCEC,(SevenForcesAltPatchA).w
                move.w  #$CCFC,(SevenForcesAltPatchB).w
                move.w  #$CC2C,(SevenForcesAltPatchC).w
                move.w  #$CC1C,(SevenForcesAltPatchD).w
                move.w  #$E0,(PaletteActiveColor14).w
                move.w  #$E0,(PaletteActiveColor15).w
                move.w  #$E0,(PaletteActiveColor01).w
                move.w  #$E0,(PaletteActiveColor02).w
                rts
; End of function Debug_SevenForcesScrollTableTest
; Finish state 4 after its timer and advance the stage entrance phase
Entity_UpdateSevenForcesEntranceState4:                 ; CODE XREF: Entity_SevenForcesEntranceState4   j  ; was: sub_54F24
                subq.w  #1,$48(a5)
                bpl.s   Entity_UpdateSevenForcesEntranceState4Return
                addq.w  #2,4(a5)
                move.l  #$10000,$18(a5)
                bset    #0,(StageTimerPauseFlag).w
                jsr     (Stage_TransitionToNextPhase).l
                subq.w  #2,(StageStateOffset).w
Entity_UpdateSevenForcesEntranceState4Return:           ; CODE XREF: Entity_UpdateSevenForcesEntranceState4+4   j  ; was: locret_54F46
                rts
; End of function Entity_UpdateSevenForcesEntranceState4
; State 6: switch the entity mapping after it reaches X=$E0
Entity_SevenForcesSwitchTransformationFrameState6:      ; DATA XREF: ROM:00054B9E   o  ; was: sub_54F48
                cmpi.w  #$E0,$10(a5)
                bmi.s   Entity_SevenForcesSwitchTransformationFrameReturn
                addq.w  #2,4(a5)
                move.w  #8,$48(a5)
                move.l  #Stage24SceneObject_CompositeSpriteFrame,8(a5)
                clr.w   $C(a5)
                clr.l   $18(a5)
Entity_SevenForcesSwitchTransformationFrameReturn:      ; CODE XREF: Entity_SevenForcesSwitchTransformationFrameState6+6   j  ; was: locret_54F6A
                rts
; End of function Entity_SevenForcesSwitchTransformationFrameState6
; State 8: wait for the shared transition work and local timer
Entity_SevenForcesWaitForTransformationState8:          ; DATA XREF: ROM:00054BA0   o  ; was: sub_54F6C
                tst.w   (MessageSequenceState).w
                bne.s   Entity_SevenForcesWaitForTransformationReturn
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesWaitForTransformationReturn
                addq.w  #2,4(a5)
Entity_SevenForcesWaitForTransformationReturn:          ; CODE XREF: Entity_SevenForcesWaitForTransformationState8+4   j  ; was: locret_54F7C
                                        ; Entity_SevenForcesWaitForTransformationState8+A   j
                rts
; End of function Entity_SevenForcesWaitForTransformationState8
; State A: arm the first form-transition state and sound
Entity_SevenForcesBeginFormSequenceStateA:              ; DATA XREF: ROM:00054BA2   o  ; was: sub_54F7E
                tst.w   (MessageSequenceState).w
                bne.s   Entity_SevenForcesBeginFormSequenceReturn
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                clr.w   $5E(a5)
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesBeginFormSequenceReturn:              ; CODE XREF: Entity_SevenForcesBeginFormSequenceStateA+4   j  ; was: locret_54F9C
                rts
; End of function Entity_SevenForcesBeginFormSequenceStateA
; State C: fade in the Valkirie palette, then arm its hold timer
Entity_SevenForcesValkirieFadeInStateC:                 ; DATA XREF: ROM:00054BA4   o  ; was: sub_54F9E
                subq.w  #1,$48(a5)
                bpl.w   Entity_SevenForcesNoOpState
                addq.w  #1,$5E(a5)
                cmpi.w  #$E,$5E(a5)
                bmi.s   Entity_SevenForcesValkirieFadeInApplyPalette
                addq.w  #2,4(a5)
                move.w  #$34,$48(a5)                    ; '4'
                clr.w   2(a5)
                move.b  #$96,d0
                jsr     (Sound_QueueBGMRequest).l
                move.b  #$23,d0                         ; '#'
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesValkirieAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesValkirieFadeInApplyPalette:           ; CODE XREF: Entity_SevenForcesValkirieFadeInStateC+12   j  ; was: loc_54FE0
                bra.w   Gfx_UpdateSevenForcesValkiriePaletteFade
; End of function Entity_SevenForcesValkirieFadeInStateC
; State E: count down Valkirie hold and fade-out values, then reset
Entity_SevenForcesValkirieFadeOutStateE:                ; DATA XREF: ROM:00054BA6   o  ; was: sub_54FE4
                subq.w  #1,$48(a5)
                bpl.w   Gfx_UpdateSevenForcesValkiriePaletteFade
                subq.w  #1,$5E(a5)
                bpl.w   Gfx_UpdateSevenForcesValkiriePaletteFade
Entity_SevenForcesResetState:                           ; CODE XREF: Entity_SevenForcesMedusaFadeOutState16+16   j  ; was: loc_54FF4
                                        ; Entity_SevenForcesSylpheedFadeOutState20+16   j
                clr.w   4(a5)
                rts
; End of function Entity_SevenForcesValkirieFadeOutStateE
; State $10: launch the Medusa entrance trajectory
Entity_SevenForcesStartMedusaEntranceState10:           ; DATA XREF: ROM:00054BA8   o  ; was: sub_54FFA
                addq.w  #2,4(a5)
                move.l  #$FFFCC000,$1C(a5)
                move.l  #$12000,$18(a5)
                cmpi.w  #$150,$10(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntranceState12
                neg.l   $18(a5)
; State $12: apply gravity until Medusa reaches the landing threshold
Entity_SevenForcesUpdateMedusaEntranceState12:          ; CODE XREF: Entity_SevenForcesStartMedusaEntranceState10+1A   j  ; was: loc_5501A
                                        ; DATA XREF: ROM:00054BAA   o
                addi.l  #$2800,$1C(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntrancePalette
                cmpi.w  #$F0,$14(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesMedusaAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                move.b  #1,(SceneSequenceFlags).w
Entity_SevenForcesUpdateMedusaEntrancePalette:          ; CODE XREF: Entity_SevenForcesStartMedusaEntranceState10+28   j  ; was: loc_55056
                                        ; Entity_SevenForcesStartMedusaEntranceState10+30   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartMedusaEntranceState10
; State $14: hold Medusa, play the timed cue, and update its palette
Entity_SevenForcesMedusaHoldState14:                    ; DATA XREF: ROM:00054BAC   o  ; was: sub_5505A
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesMedusaHoldCheckSound
                addq.w  #2,4(a5)
Entity_SevenForcesMedusaHoldCheckSound:                 ; CODE XREF: Entity_SevenForcesMedusaHoldState14+4   j  ; was: loc_55064
                cmpi.w  #$38,$48(a5)                    ; '8'
                bne.s   Entity_SevenForcesMedusaHoldApplyPalette
                move.b  #$25,d0                         ; '%'
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesMedusaHoldApplyPalette:               ; CODE XREF: Entity_SevenForcesMedusaHoldState14+10   j  ; was: loc_55076
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesMedusaHoldState14
; State $16: advance Medusa's fade value on alternate frames, then reset
Entity_SevenForcesMedusaFadeOutState16:                 ; DATA XREF: ROM:00054BAE   o  ; was: sub_5507A
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bmi.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesMedusaFadeOutState16
; State $18: launch the Sylpheed entrance trajectory
Entity_SevenForcesStartSylpheedEntranceState18:         ; DATA XREF: ROM:00054BB0   o  ; was: sub_55094
                move.b  #1,(SceneSequenceFlags).w
                addq.w  #2,4(a5)
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$18000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntranceState1A
                neg.l   $18(a5)
; State $1A: apply gravity until Sylpheed reaches the landing threshold
Entity_SevenForcesUpdateSylpheedEntranceState1A:        ; CODE XREF: Entity_SevenForcesStartSylpheedEntranceState18+20   j  ; was: loc_550BA
                                        ; DATA XREF: ROM:00054BB2   o
                addi.l  #$2800,$1C(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntrancePalette
                cmpi.w  #$F0,$14(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesSylpheedAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesUpdateSylpheedEntrancePalette:        ; CODE XREF: Entity_SevenForcesStartSylpheedEntranceState18+2E   j  ; was: loc_550F0
                                        ; Entity_SevenForcesStartSylpheedEntranceState18+36   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartSylpheedEntranceState18
; State $1C: hold Sylpheed, play the timed cue, and update its palette
Entity_SevenForcesSylpheedHoldState1C:                  ; DATA XREF: ROM:00054BB4   o  ; was: sub_550F4
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesSylpheedHoldApplyPalette
                addq.w  #2,4(a5)
                move.b  #$24,d0                         ; '$'
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesSylpheedHoldApplyPalette:             ; CODE XREF: Entity_SevenForcesSylpheedHoldState1C+4   j  ; was: loc_55108
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesSylpheedHoldState1C
; State $1E: wait for the Sylpheed scroll threshold
Entity_SevenForcesWaitForSylpheedScrollState1E:         ; DATA XREF: ROM:00054BB6   o  ; was: sub_5510C
                cmpi.w  #$F760,(PrimaryCameraYPosition).w
                bpl.s   Entity_SevenForcesWaitForSylpheedScrollApplyPalette
                addq.w  #2,4(a5)
Entity_SevenForcesWaitForSylpheedScrollApplyPalette:    ; CODE XREF: Entity_SevenForcesWaitForSylpheedScrollState1E+6   j  ; was: loc_55118
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesWaitForSylpheedScrollState1E
; State $20: advance Sylpheed's fade value on alternate frames, then reset
Entity_SevenForcesSylpheedFadeOutState20:               ; DATA XREF: ROM:00054BB8   o  ; was: sub_5511C
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bmi.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesSylpheedFadeOutState20
; State $22: configure and launch the Artemis entrance trajectory
Entity_SevenForcesStartArtemisEntranceState22:          ; DATA XREF: ROM:00054BBA   o  ; was: sub_55136
                addq.w  #2,4(a5)
                bclr    #0,(PlayerModeFlags).w
                bclr    #4,(PlayerSpriteAttributes).w
                move.w  #$58,(PlayerStateOffset).w      ; 'X'
                clr.l   (PlayerXVelocity).w
                clr.l   (PlayerYVelocity).w
                move.w  #$34,(PlayerScriptStateOffset).w  ; '4'
                bset    #2,(PlayerRestrictionFlags).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.l  #$38000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Entity_SevenForcesUpdateArtemisEntranceState24
                neg.l   $18(a5)
; State $24: decelerate Artemis upward until it reaches the height threshold
Entity_SevenForcesUpdateArtemisEntranceState24:         ; CODE XREF: Entity_SevenForcesStartArtemisEntranceState22+46   j  ; was: loc_55182
                                        ; DATA XREF: ROM:00054BBC   o
                subi.l  #$1000,(PlayerYVelocity).w
                subi.l  #$2000,$1C(a5)
                bpl.s   Entity_SevenForcesUpdateArtemisEntrancePalette
                cmpi.w  #$100,$14(a5)
                bpl.s   Entity_SevenForcesUpdateArtemisEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesArtemisAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesUpdateArtemisEntrancePalette:         ; CODE XREF: Entity_SevenForcesStartArtemisEntranceState22+5C   j  ; was: loc_551BA
                                        ; Entity_SevenForcesStartArtemisEntranceState22+64   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartArtemisEntranceState22
; State $26: wait for the Artemis completion signal and configure its hold
Entity_SevenForcesWaitForArtemisSignalState26:          ; DATA XREF: ROM:00054BBE   o  ; was: sub_551BE
                subi.l  #$1000,(PlayerYVelocity).w
                tst.b   (SceneSequenceFlags).w
                bne.s   Entity_SevenForcesWaitForArtemisSignalApplyPalette
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$10,$4A(a5)
                clr.w   (PlayerStateOffset).w
                move.w  #$FF84,(PlayerYPosition).w
                move.w  #$D0,(PlayerXPosition).w
                bset    #0,(PlayerObjectFlags).w
Entity_SevenForcesWaitForArtemisSignalApplyPalette:     ; CODE XREF: Entity_SevenForcesWaitForArtemisSignalState26+C   j  ; was: loc_551F2
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesWaitForArtemisSignalState26
; State $28: run Artemis hold timers and fade-out, then reset
Entity_SevenForcesArtemisFadeOutState28:                ; DATA XREF: ROM:00054BC0   o  ; was: sub_551F6
                tst.w   $48(a5)
                bmi.s   Entity_SevenForcesArtemisFadeOutUpdateTimer
                subq.w  #1,$48(a5)
                bpl.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                move.b  #1,(SceneSequenceFlags).w
                bclr    #2,(PlayerRestrictionFlags).w
Entity_SevenForcesArtemisFadeOutUpdateTimer:            ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+4   j  ; was: loc_55210
                subq.w  #1,$4A(a5)
                bne.s   Entity_SevenForcesArtemisFadeOutApplyPalette
                jsr     (Gfx_QueueArtemisIndexedRows).l
                bra.s   Entity_SevenForcesArtemisFadeOutCheckReset
; ---------------------------------------------------------------------------
Entity_SevenForcesArtemisFadeOutApplyPalette:           ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+1E   j  ; was: loc_5521E
                bpl.w   Gfx_UpdateSevenForcesArtemisPaletteFade
Entity_SevenForcesArtemisFadeOutCheckReset:             ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+26   j  ; was: loc_55222
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bmi.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesArtemisFadeOutState28
; State $2A: launch the Sirene entrance trajectory
Entity_SevenForcesStartSireneEntranceState2A:           ; DATA XREF: ROM:00054BC2   o  ; was: sub_5523C
                addq.w  #2,4(a5)
                move.w  #$34,(PlayerScriptStateOffset).w  ; '4'
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Entity_SevenForcesUpdateSireneEntranceState2C
                neg.l   $18(a5)
; State $2C: apply gravity until Sirene reaches the lower threshold
Entity_SevenForcesUpdateSireneEntranceState2C:          ; CODE XREF: Entity_SevenForcesStartSireneEntranceState2A+20   j  ; was: loc_55262
                                        ; DATA XREF: ROM:00054BC4   o
                addi.l  #$2000,$1C(a5)
                bmi.s   Entity_SevenForcesUpdateSireneEntrancePalette
                cmpi.w  #$170,$14(a5)
                bmi.s   Entity_SevenForcesUpdateSireneEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5)                    ; '@'
Entity_SevenForcesUpdateSireneEntrancePalette:          ; CODE XREF: Entity_SevenForcesStartSireneEntranceState2A+2E   j  ; was: loc_55282
                                        ; Entity_SevenForcesStartSireneEntranceState2A+36   j
                bra.w   Gfx_UpdateSevenForcesArtemisPaletteFade
; End of function Entity_SevenForcesStartSireneEntranceState2A
; State $2E: hold Sirene while advancing its palette counter
Entity_SevenForcesSireneHoldState2E:                    ; DATA XREF: ROM:00054BC6   o  ; was: sub_55286
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesSireneHoldUpdatePalette
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$28,d0                         ; '('
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesSireneAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesSireneHoldUpdatePalette:              ; CODE XREF: Entity_SevenForcesSireneHoldState2E+4   j  ; was: loc_552AC
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bmi.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                rts
; End of function Entity_SevenForcesSireneHoldState2E
; State $30: reset the Seven Forces intro controller
Entity_SevenForcesResetState30:                         ; DATA XREF: ROM:00054BC8   o  ; was: sub_552BA
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesResetState30
; State $32: apply the first timed Sirene palette and sound event
Entity_SevenForcesSirenePaletteEventState32:            ; DATA XREF: ROM:00054BCA   o  ; was: sub_552BE
                cmpi.w  #$9C,(StageStateOffset).w
                bne.s   Entity_SevenForcesSirenePaletteEventState32Return
                move.b  #$27,d0                         ; '''
                jsr     (Sound_QueueSFXRequest).l
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesSireneTimedAssetSetA).l,a1
                jsr     (Boss_LoadAssetSet).l
                bra.w   Entity_SevenForcesResetState
; ---------------------------------------------------------------------------
Entity_SevenForcesSirenePaletteEventState32Return:      ; CODE XREF: Entity_SevenForcesSirenePaletteEventState32+6   j  ; was: locret_552EA
                rts
; End of function Entity_SevenForcesSirenePaletteEventState32
; State $34: apply the second timed Sirene palette and sound event
Entity_SevenForcesSirenePaletteEventState34:            ; DATA XREF: ROM:00054BCC   o  ; was: sub_552EC
                cmpi.w  #$A6,(StageStateOffset).w
                bne.s   Entity_SevenForcesSirenePaletteEventState34Return
                move.b  #$26,d0                         ; '&'
                jsr     (Sound_QueueSFXRequest).l
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesSireneTimedAssetSetB).l,a1
                jsr     (Boss_LoadAssetSet).l
                bra.w   Entity_SevenForcesResetState
; ---------------------------------------------------------------------------
Entity_SevenForcesSirenePaletteEventState34Return:      ; CODE XREF: Entity_SevenForcesSirenePaletteEventState34+6   j  ; was: locret_55318
                rts
; End of function Entity_SevenForcesSirenePaletteEventState34
; State $36: run the random explosion sequence and arm its wait state
Entity_SevenForcesExplosionSequenceState36:             ; DATA XREF: ROM:00054BCE   o  ; was: sub_5531A
                addq.w  #1,$48(a5)
                cmpi.w  #2,$48(a5)
                bne.s   Entity_SevenForcesExplosionSequenceCheckTransition
                move.b  #3,d0
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesExplosionSequenceCheckTransition:     ; CODE XREF: Entity_SevenForcesExplosionSequenceState36+A   j  ; was: loc_55330
                bsr.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                cmpi.w  #$98,(StageStateOffset).w
                bne.s   Entity_SevenForcesSpawnRandomExplosion
                addq.w  #2,4(a5)
                move.w  #$200,$48(a5)
                move.b  #1,(SoundFadeOutDelay).w
                move.w  #$C0,(ExplosionSoundDelay).w
Entity_SevenForcesSpawnRandomExplosion:                 ; CODE XREF: Entity_SevenForcesExplosionSequenceState36+20   j  ; was: loc_55352
                                        ; sub_553CC:Entity_SevenForcesExplosionWaitUpdate   p
                move.w  #2,(PlaneAShakeLevel).w
                move.w  #2,(PlaneBShakeLevel).w
                jsr     (Projectile_UpdateWithExplosionSound).l
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Entity_SevenForcesSpawnRandomExplosionReturn
                jsr     (Sprite_InitType160).l
                move.l  #SharedCombatSpriteAnimation00,8(a0)
                btst    #0,(RandomNumberState).w
                beq.s   Entity_SevenForcesInitRandomExplosionMotion
                move.l  #SharedCombatSpriteAnimation01,8(a0)
Entity_SevenForcesInitRandomExplosionMotion:            ; CODE XREF: Entity_SevenForcesExplosionSequenceState36+66   j  ; was: loc_5538A
                move.b  #0,$20(a0)
                moveq   #0,d0
                move.w  (RandomNumberState).w,d0
                asl.w   #1,d0
                addi.l  #$80000,d0
                move.l  d0,$1C(a0)
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$FF,d1
                subi.w  #$80,d0
                subi.w  #$80,d1
                addi.w  #$120,d0
                addi.w  #$F0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
Entity_SevenForcesSpawnRandomExplosionReturn:           ; CODE XREF: Entity_SevenForcesExplosionSequenceState36+50   j  ; was: locret_553CA
                rts
; End of function Entity_SevenForcesExplosionSequenceState36
; State $38: keep spawning explosions until the wait timer expires
Entity_SevenForcesExplosionWaitState38:                 ; DATA XREF: ROM:00054BD0   o  ; was: sub_553CC
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesExplosionWaitUpdate
                addq.w  #2,4(a5)
                move.b  #1,(SceneSequenceFlags).w
Entity_SevenForcesExplosionWaitUpdate:                  ; CODE XREF: Entity_SevenForcesExplosionWaitState38+4   j  ; was: loc_553DC
                bsr.w   Entity_SevenForcesSpawnRandomExplosion
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bmi.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                rts
; End of function Entity_SevenForcesExplosionWaitState38
; State $3A: wait for the final-fade trigger and arm shared transition work
Entity_SevenForcesArmFinalFadeState3A:                  ; DATA XREF: ROM:00054BD2   o  ; was: sub_553EE
                cmpi.w  #$A2,(StageStateOffset).w
                bne.s   Entity_SevenForcesArmFinalFadeReturn
                addq.w  #2,4(a5)
                clr.w   $5E(a5)
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.b  #1,(AlternateTimeBonusSound).w
Entity_SevenForcesArmFinalFadeReturn:                   ; CODE XREF: Entity_SevenForcesArmFinalFadeState3A+6   j  ; was: locret_5540A
                rts
; End of function Entity_SevenForcesArmFinalFadeState3A
; State $3C: spawn transition particles while fading the palette
Entity_SevenForcesFinalFadeState3C:                     ; DATA XREF: ROM:00054BD4   o  ; was: sub_5540C
                bsr.w   Effect_SpawnSevenForcesTransitionParticle
                subq.w  #1,$5E(a5)
                cmpi.w  #$FFF2,$5E(a5)
                bpl.s   Entity_SevenForcesApplyFinalFade
                addq.w  #2,4(a5)
                move.w  #$210,$48(a5)
Entity_SevenForcesApplyFinalFade:                       ; CODE XREF: Entity_SevenForcesFinalFadeState3C+E   j  ; was: loc_55426
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Entity_SevenForcesFinalFadeState3C
; State $3E: spawn transition particles and enter the next stage state
Entity_SevenForcesFinishIntroState3E:                   ; DATA XREF: ROM:00054BD6   o  ; was: sub_5543A
                bsr.w   Effect_SpawnSevenForcesTransitionParticle
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesFinishIntroReturn
                tst.w   (GameplayExitMode).w
                bne.s   Entity_SevenForcesFinishIntroReturn
                move.b  #$93,(PendingStageBGMRequest).w
                move.l  #StageTransitionMessageSequence_Shared,(StageMessageCursor).w
                jmp     Stage_StartInterstageTransition
; ---------------------------------------------------------------------------
Entity_SevenForcesFinishIntroReturn:                    ; CODE XREF: Entity_SevenForcesFinishIntroState3E+8   j  ; was: locret_5545E
                                        ; Entity_SevenForcesFinishIntroState3E+E   j
                rts
; End of function Entity_SevenForcesFinishIntroState3E
; Apply Valkirie's single-range intro palette fade
Gfx_UpdateSevenForcesValkiriePaletteFade:               ; CODE XREF: Entity_SevenForcesValkirieFadeInStateC:Entity_SevenForcesValkirieFadeInApplyPalette   j  ; was: sub_55460
                                        ; Entity_SevenForcesValkirieFadeOutStateE+4   j
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                moveq   #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(PaletteActiveColor50).w
                rts
; End of function Gfx_UpdateSevenForcesValkiriePaletteFade
; Apply the shared three-range Seven Forces palette fade
Gfx_UpdateSevenForcesMultiRangePaletteFade:             ; CODE XREF: Entity_SevenForcesStartMedusaEntranceState10:Entity_SevenForcesUpdateMedusaEntrancePalette   j  ; was: sub_5547C
                                        ; sub_5505A:Entity_SevenForcesMedusaHoldApplyPalette   j
                movea.w #(PaletteActiveColor16-M68K_RAM),a0
                moveq   #$F,d5
                move.w  $5E(a5),d0
                neg.w   d0
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveColor33-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(PaletteActiveColor50).w
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveColor01-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_UpdateSevenForcesMultiRangePaletteFade
; Apply Artemis's four-range intro palette fade
Gfx_UpdateSevenForcesArtemisPaletteFade:                ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+A   j  ; was: sub_554C0
                                        ; sub_551F6:Entity_SevenForcesArtemisFadeOutApplyPalette   j
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveColor01-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveColor21-M68K_RAM),a0
                moveq   #7,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                neg.w   d0
                movea.w #(PaletteActiveColor16-M68K_RAM),a0
                moveq   #4,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(PaletteActiveColor50).w
                move.w  $5E(a5),d0
                movea.w #(PaletteActiveColor33-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_UpdateSevenForcesArtemisPaletteFade
; Initialize the shared form-transition sprite from camera coordinates
Entity_InitSevenForcesTransitionSprite:                 ; CODE XREF: Entity_StartSevenForcesMedusaTransition+6   p  ; was: sub_55518
                                        ; Entity_StartSevenForcesSylpheedTransition+6   p
                move.b  #$14,$20(a5)
                clr.w   $C(a5)
                move.w  #$CD00,2(a5)
                move.l  #Boss_ValkirieMetaspriteFrame,8(a5)
                move.w  #$6300,$E(a5)
                move.w  (PrimaryEntityXPos).w,$10(a5)
                move.w  (PrimaryEntityYPos).w,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Entity_InitSevenForcesTransitionSprite
; Spawn a randomized particle during the final Seven Forces transition
Effect_SpawnSevenForcesTransitionParticle:              ; CODE XREF: Entity_SevenForcesFinalFadeState3C   p  ; was: sub_5554C
                                        ; sub_5543A   p
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Effect_SpawnSevenForcesTransitionParticleReturn
                move.w  #$188,(a0)
                move.w  #$8400,2(a0)
                move.w  #$10,$48(a0)
                moveq   #0,d0
                move.w  (RandomNumberState).w,d0
                andi.w  #$1F,d0
                addq.w  #8,d0
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                move.l  d0,$18(a0)
                move.b  #$70,$20(a0)                    ; 'p'
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$7F,d1
                subi.w  #$80,d0
                addi.w  #$120,d0
                addi.w  #$A0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  #$44F4,$E(a0)
                btst    #0,(RandomNumberState).w
                bne.s   Effect_InitSevenForcesTransitionParticleMapping
                move.w  #$44F5,$E(a0)
Effect_InitSevenForcesTransitionParticleMapping:        ; CODE XREF: Effect_SpawnSevenForcesTransitionParticle+66   j  ; was: loc_555BA
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
Effect_SpawnSevenForcesTransitionParticleReturn:        ; CODE XREF: Effect_SpawnSevenForcesTransitionParticle+6   j  ; was: locret_555C6
                rts
; End of function Effect_SpawnSevenForcesTransitionParticle
; Dispatch the post-battle transition requested by the completed boss
Boss_QueueSevenForcesPostBattleTransition:              ; CODE XREF: Entity_UpdateValkirieBattle+26   j  ; was: sub_555C8
                                        ; Boss_UpdateMedusa+26   j
                bset    #0,(StageTimerPauseFlag).w
                movea.w #(Entity60Type-M68K_RAM),a5
                bsr.s   Entity_DispatchSevenForcesPostBattleTransition
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_QueueSevenForcesPostBattleTransition
; Dispatch a post-battle transition by the caller-supplied even index
Entity_DispatchSevenForcesPostBattleTransition:         ; CODE XREF: Boss_QueueSevenForcesPostBattleTransition+A   p  ; was: sub_555DA
                movea.w Entity_SevenForcesPostBattleTransitionOffsets(pc,d0.w),a1
                adda.l  #Entity_ResetSevenForcesTransitionController,a1
                jmp     (a1)
; End of function Entity_DispatchSevenForcesPostBattleTransition
; ---------------------------------------------------------------------------
Entity_SevenForcesPostBattleTransitionOffsets:  dc.w    Entity_ResetSevenForcesTransitionController-Entity_ResetSevenForcesTransitionController  ; was: off_555E6
                                        ; DATA XREF: Entity_DispatchSevenForcesPostBattleTransition   r
                dc.w    Entity_StartSevenForcesMedusaTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesSylpheedTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesArtemisTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesSireneTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_ResumeSevenForcesIntroState24-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_ResumeSevenForcesIntroState26-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesFinalTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_SevenForcesPostBattleNoOp-Entity_ResetSevenForcesTransitionController

; Reset the Seven Forces transition controller state
Entity_ResetSevenForcesTransitionController:            ; DATA XREF: Entity_DispatchSevenForcesPostBattleTransition+4   o  ; was: sub_555F8
                                        ; ROM:Entity_SevenForcesPostBattleTransitionOffsets   o
                move.w  #0,4(a5)
                rts
; End of function Entity_ResetSevenForcesTransitionController
; Start the Medusa form transition after Valkirie completes
Entity_StartSevenForcesMedusaTransition:                ; DATA XREF: ROM:000555E8   o  ; was: sub_55600
                move.w  #$10,4(a5)
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF4,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesMedusaTransition
; Start the Sylpheed form transition after Medusa completes
Entity_StartSevenForcesSylpheedTransition:              ; DATA XREF: ROM:000555EA   o  ; was: sub_5562A
                move.w  #$18,4(a5)
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                lea     (SevenForcesSylpheedTransitionPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (PlaneAScrollModeFlags).w
                clr.b   (PlaneBScrollModeFlags).w
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesSylpheedTransition
; Start the Artemis form transition after Sylpheed completes
Entity_StartSevenForcesArtemisTransition:               ; DATA XREF: ROM:000555EC   o  ; was: sub_5566C
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$22,4(a5)                      ; '"'
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                lea     (SevenForcesArtemisTransitionPaletteCommands).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesArtemisTransition
; Start the Sirene form transition after Artemis completes
Entity_StartSevenForcesSireneTransition:                ; DATA XREF: ROM:000555EE   o  ; was: sub_556A8
                move.w  #$2A,4(a5)                      ; '*'
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesSireneTransition
; Resume the intro controller at state $24 and clear obsolete objects
Entity_ResumeSevenForcesIntroState24:                   ; DATA XREF: ROM:000555F0   o  ; was: sub_556D2
                move.w  #$24,4(a5)                      ; '$'
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_ResumeSevenForcesIntroState24
; Resume the intro controller at state $26 and clear obsolete objects
Entity_ResumeSevenForcesIntroState26:                   ; DATA XREF: ROM:000555F2   o  ; was: sub_556F4
                move.w  #$26,4(a5)                      ; '&'
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_ResumeSevenForcesIntroState26
; Start the final explosion sequence after Sirene completes
Entity_StartSevenForcesFinalTransition:                 ; DATA XREF: ROM:000555F4   o  ; was: sub_55716
                move.w  #$36,4(a5)                      ; '6'
                bclr    #0,(PlayerObjectFlags).w
                bset    #0,(PlayerModeFlags).w
                bclr    #2,(PlayerModeFlags).w
                clr.w   $48(a5)
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (PlaneAScrollModeFlags).w
                clr.b   (PlaneBScrollModeFlags).w
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                rts
; End of function Entity_StartSevenForcesFinalTransition
; Intentional no-op post-battle transition entry
Entity_SevenForcesPostBattleNoOp:                       ; DATA XREF: ROM:000555F6   o  ; was: nullsub_127
                rts
; End of function Entity_SevenForcesPostBattleNoOp
