; Seven Forces intro controller setup, entrance states, and scroll debug
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
