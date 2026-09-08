Boss_ShellshogunMainHandler:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_394D8
                tst.w   4(a5)
                beq.w   Boss_ShellshogunDispatchState
                tst.w   $26(a5)
                beq.w   Boss_ShellshogunDispatchState
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_ShellshogunUpdatePaletteAndScreenPosition
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_ShellshogunUpdatePaletteAndScreenPosition
                tst.w   (word_FF8200).w
                beq.w   Boss_ShellshogunBeginDefeat
Boss_ShellshogunUpdatePaletteAndScreenPosition:         ; CODE XREF: Boss_ShellshogunMainHandler+16   j  ; was: loc_39500
                                        ; Boss_ShellshogunMainHandler+1E   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$17E(a5)
Boss_ShellshogunDispatchState:                          ; CODE XREF: Boss_ShellshogunMainHandler+4   j  ; was: loc_39512
                                        ; Boss_ShellshogunMainHandler+C   j
                move.w  4(a5),d0
                movea.w Boss_ShellshogunStateOffsets(pc,d0.w),a0
                adda.l  #Boss_ShellshogunInitState,a0
                jmp     (a0)
; End of function Boss_ShellshogunMainHandler
; ---------------------------------------------------------------------------
Boss_ShellshogunStateOffsets:   dc.w    Boss_ShellshogunInitState-Boss_ShellshogunInitState  ; was: off_39522
                                        ; DATA XREF: Boss_ShellshogunMainHandler+3E   r
                dc.w    Boss_ShellshogunSetupPhase-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunEntrancePoseState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunPreBattleDelayState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunWaitForStageReadyState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDecisionState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunPoseGateState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunSlamPreparationState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunSlamFollowThroughState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDefeatLaunchState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDefeatPaletteState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDefeatDissolveState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDefeatCompletionDelayState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunTransitionState-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunVerticalMovement-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunJumpAttackUpdate-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunJumpAttack_AirPhase-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDescendUpdate-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunLandingSequence-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunDecelerateHorizontal-Boss_ShellshogunInitState
                dc.w    Boss_ShellshogunTimedStageAdvanceState-Boss_ShellshogunInitState

; Initializes Shellshogun boss state and clears objects
Boss_ShellshogunInitState:                              ; DATA XREF: Boss_ShellshogunMainHandler+42   o  ; was: sub_3954C
                                        ; ROM:Boss_ShellshogunStateOffsets   o
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$F4,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                clr.w   8(a5)
                clr.w   $A(a5)
                move.b  #1,(byte_FF830E).w
Boss_ShellshogunInitializationWaitReturn:               ; CODE XREF: Boss_ShellshogunSetupPhase+4   j  ; was: locret_39570
                                        ; Boss_ShellshogunSetupPhase+C   j
                rts
; End of function Boss_ShellshogunInitState
; Sets up boss phase with metasprite initialization
Boss_ShellshogunSetupPhase:                             ; DATA XREF: ROM:00039524   o  ; was: sub_39572
                subq.w  #1,$48(a5)
                bmi.w   Boss_ShellshogunInitializationWaitReturn
                tst.w   (word_FFF720).w
                bmi.s   Boss_ShellshogunInitializationWaitReturn
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                move.w  #$20,$BC(a5)                    ; ' '
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
                clr.w   $23C(a5)
                clr.w   $29C(a5)
                addq.w  #1,$26(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$15,d7
                moveq   #$17,d7
                movea.l #Boss_ShellshogunMetaspriteDescriptors,a0
                movea.l #Boss_ShellshogunPartRadii,a1
                movea.l #Boss_ShellshogunPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                bset    #7,$6E(a5)
                bset    #7,$CE(a5)
                bset    #7,$4EE(a5)
                bsr.w   Boss_ShellshogunInitPalette
                bset    #0,2(a5)
                bset    #0,$482(a5)
                bset    #0,$8A2(a5)
                move.w  #$F4,(a5)
                move.w  #$100,$54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                move.w  #$6464,d0
                moveq   #2,d7
Boss_ShellshogunInitializeAuxiliaryParts:               ; CODE XREF: Boss_ShellshogunSetupPhase+C4   j  ; was: loc_39610
                move.w  #$10,(a0)
                move.w  #$8000,2(a0)
                move.w  d0,$E(a0)
                move.b  #$80,$20(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                addq.w  #4,d0
                lea     $60(a0),a0
                dbf     d7,Boss_ShellshogunInitializeAuxiliaryParts
                move.w  #0,$9C8(a5)
                move.w  #$FCFC,$9CA(a5)
                movea.w #(byte_FFD040-M68K_RAM),a0
                moveq   #2,d7
Boss_ShellshogunInitializeSecondaryObjects:             ; CODE XREF: Boss_ShellshogunSetupPhase+10A   j  ; was: loc_3964C
                move.w  #$10,(a0)
                clr.w   2(a0)
                clr.w   $10(a0)
                clr.b   $21(a0)
                move.b  #$10,$23(a0)
                move.l  #$FA06FA06,$2C(a0)
                move.l  #$FA06FA06,$28(a0)
                move.w  #$63,$26(a0)                    ; 'c'
                lea     $60(a0),a0
                dbf     d7,Boss_ShellshogunInitializeSecondaryObjects
                move.w  #$8300,$A2E(a5)
                move.w  #$C000,$A22(a5)
                move.l  #word_EB98A,$A28(a5)
                move.b  #$C,$A40(a5)
                movea.l #Boss_ShellshogunObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                movea.l #Boss_ShellshogunIntroTileLoadCommand,a0
                jsr     (Gfx_LoadCompressedTiles).l
                bsr.w   Boss_ShellshogunInitSprites
                move.w  #$2E0,$490(a5)
                move.w  #$2E0,$8B0(a5)
                bra.w   Boss_ShellshogunSetParams
; End of function Boss_ShellshogunSetupPhase
; ---------------------------------------------------------------------------
Boss_ShellshogunIntroTileLoadCommand:   dc.b    $61, 0, $20, 0, 2, 1, 3, 1, 2, 4, 5, 6  ; was: byte_396C6
                                        ; DATA XREF: Boss_ShellshogunSetupPhase+134   o

; Checks phase conditions and advances state
Boss_ShellshogunEntrancePoseState:                      ; DATA XREF: ROM:00039526   o  ; was: sub_396D2
                bsr.w   Boss_ShellshogunSetParams
                tst.w   $17C(a5)
                beq.s   Boss_ShellshogunEntrancePoseReturn
                cmpi.w  #$C,$58(a5)
                beq.s   Boss_ShellshogunTriggerEntranceEffect
                cmpi.w  #4,$58(a5)
                bne.s   Boss_ShellshogunEntrancePoseReturn
                cmpi.w  #$13A8,$17E(a5)
                bpl.s   Boss_ShellshogunTriggerEntranceEffect
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$BE(a5)                    ; '@'
Boss_ShellshogunTriggerEntranceEffect:                  ; CODE XREF: Boss_ShellshogunEntrancePoseState+10   j  ; was: loc_39708
                                        ; Boss_ShellshogunEntrancePoseState+20   j
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$A1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Boss_ShellshogunEntrancePoseReturn:                     ; CODE XREF: Boss_ShellshogunEntrancePoseState+8   j  ; was: locret_3971E
                                        ; Boss_ShellshogunEntrancePoseState+18   j
                rts
; End of function Boss_ShellshogunEntrancePoseState
; Runs the common update during the timed pre-battle delay
Boss_ShellshogunPreBattleDelayState:                    ; DATA XREF: ROM:00039528   o  ; was: sub_39720
                move.w  #$10,$BC(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                bsr.w   Boss_ShellshogunDecisionState
                subq.w  #1,$BE(a5)
                bpl.s   Boss_ShellshogunPreBattleDelayReturn
                addq.w  #2,4(a5)
                moveq   #4,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Input_CheckButtonMode).l
Boss_ShellshogunPreBattleDelayReturn:                   ; CODE XREF: Boss_ShellshogunPreBattleDelayState+1E   j  ; was: locret_39756
                rts
; End of function Boss_ShellshogunPreBattleDelayState
; Waits for the shared stage gate before entering battle
Boss_ShellshogunWaitForStageReadyState:                 ; DATA XREF: ROM:0003952A   o  ; was: sub_39758
                move.w  #$10,$BC(a5)
                bsr.w   Boss_ShellshogunDecisionState
                tst.w   (word_FF80C2).w
                bne.s   Boss_ShellshogunWaitForStageReadyReturn
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                subi.w  #$40,(word_FFA970).w            ; '@'
Boss_ShellshogunWaitForStageReadyReturn:                ; CODE XREF: Boss_ShellshogunWaitForStageReadyState+E   j  ; was: locret_39776
                rts
; End of function Boss_ShellshogunWaitForStageReadyState
; Initializes the defeat launch when shared boss health reaches zero
Boss_ShellshogunBeginDefeat:                            ; CODE XREF: Boss_ShellshogunMainHandler+24   j  ; was: sub_39778
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$48,(word_FF809E).w            ; 'H'
                move.w  #$12,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.b  #$C,$A40(a5)
                clr.b   $A41(a5)
                move.w  #$13F,$BC(a5)
                clr.w   6(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   Boss_ShellshogunInitializeDefeatLaunch
; End of function Boss_ShellshogunBeginDefeat
; Updates the launched boss during the first defeat state
Boss_ShellshogunDefeatLaunchState:                      ; DATA XREF: ROM:00039534   o  ; was: sub_397C4
                jsr     (Gfx_UpdatePaletteFade).l
                tst.w   $BC(a5)
                bpl.s   Boss_ShellshogunUpdateDefeatLaunch
                jsr     (Gfx_QueueDMATransfer).l
                addq.w  #4,6(a5)
                cmpi.w  #$20,6(a5)                      ; ' '
                bmi.s   Boss_ShellshogunUpdateDefeatLaunch
                addq.w  #2,4(a5)
                move.w  #$60,$BC(a5)                    ; '`'
                clr.w   $26(a5)
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$F4,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
Boss_ShellshogunUpdateDefeatLaunch:                     ; CODE XREF: Boss_ShellshogunDefeatLaunchState+A   j  ; was: loc_39802
                                        ; Boss_ShellshogunDefeatLaunchState+1C   j
                subq.w  #1,$BC(a5)
                addi.w  #$C,$56(a5)
                andi.w  #$1FE,$56(a5)
                addi.l  #$4000,$1C(a5)
                bmi.s   Boss_ShellshogunRenderDefeatLaunch
                cmpi.w  #$120,$14(a5)
                bmi.s   Boss_ShellshogunRenderDefeatLaunch
                move.w  #$120,$14(a5)
Boss_ShellshogunInitializeDefeatLaunch:                 ; CODE XREF: Boss_ShellshogunBeginDefeat+4A   j  ; was: loc_3982A
                move.l  #$FFFBA000,$1C(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  (dword_FFFF08).w,$1A(a5)
                cmpi.w  #$12A8,$17E(a5)
                bmi.s   Boss_ShellshogunSetPositiveDefeatVelocity
                cmpi.w  #$1328,$17E(a5)
                bpl.s   Boss_ShellshogunSetNegativeDefeatVelocity
                btst    #3,(dword_FFFF08+1).w
                bne.s   Boss_ShellshogunSetNegativeDefeatVelocity
Boss_ShellshogunSetPositiveDefeatVelocity:              ; CODE XREF: Boss_ShellshogunDefeatLaunchState+86   j  ; was: loc_3985C
                move.w  #2,$18(a5)
                bra.s   Boss_ShellshogunRenderDefeatLaunch
; ---------------------------------------------------------------------------
Boss_ShellshogunSetNegativeDefeatVelocity:              ; CODE XREF: Boss_ShellshogunDefeatLaunchState+8E   j  ; was: loc_39864
                                        ; Boss_ShellshogunDefeatLaunchState+96   j
                move.w  #$FFFD,$18(a5)
Boss_ShellshogunRenderDefeatLaunch:                     ; CODE XREF: Boss_ShellshogunDefeatLaunchState+56   j  ; was: loc_3986A
                                        ; Boss_ShellshogunDefeatLaunchState+5E   j
                bsr.w   Boss_ShellshogunFlashOnHit
                lea     word_3A380(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bra.w   Boss_ShellshogunUpdateWrapper
; End of function Boss_ShellshogunDefeatLaunchState
; Advances the palette phase and starts the post-boss player effect
Boss_ShellshogunDefeatPaletteState:                     ; DATA XREF: ROM:00039536   o  ; was: sub_3987C
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$BC(a5)
                bpl.s   Boss_ShellshogunDefeatPaletteRender
                addq.w  #2,4(a5)
                jsr     (Effect_InitPlayerSpawn).l
                move.b  #4,(byte_FFA95A).w
Boss_ShellshogunDefeatPaletteRender:                    ; CODE XREF: Boss_ShellshogunDefeatPaletteState+A   j  ; was: loc_39898
                jmp     Gfx_QueueDMATransfer
; End of function Boss_ShellshogunDefeatPaletteState
; Reduces the defeat-effect step before the final delay
Boss_ShellshogunDefeatDissolveState:                    ; DATA XREF: ROM:00039538   o  ; was: sub_3989E
                subq.w  #2,6(a5)
                bne.s   Boss_ShellshogunDefeatDissolveRender
                addq.w  #2,4(a5)
                move.w  #$E0,$BC(a5)
Boss_ShellshogunDefeatDissolveRender:                   ; CODE XREF: Boss_ShellshogunDefeatDissolveState+4   j  ; was: loc_398AE
                jmp     Gfx_QueueDMATransfer
; End of function Boss_ShellshogunDefeatDissolveState
; Waits before marking the defeated boss object complete
Boss_ShellshogunDefeatCompletionDelayState:             ; DATA XREF: ROM:0003953A   o  ; was: sub_398B4
                subq.w  #1,$BC(a5)
                bpl.s   Boss_ShellshogunDefeatCompletionDelayReturn
                bset    #4,2(a5)
Boss_ShellshogunDefeatCompletionDelayReturn:            ; CODE XREF: Boss_ShellshogunDefeatCompletionDelayState+4   j  ; was: locret_398C0
                rts
; End of function Boss_ShellshogunDefeatCompletionDelayState
; Resets Shellshogun boss to idle state with cleared velocities and animations
Boss_ShellshogunReturnToDecisionState:                  ; CODE XREF: Boss_ShellshogunPoseGateState+2A   j  ; was: sub_398C2
                                        ; Boss_ShellshogunSlamFollowThroughState+2E   j
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #4,d0
                addq.w  #2,d0
                move.w  d0,$BC(a5)
Boss_ShellshogunInitializeDecisionState:                ; CODE XREF: Boss_ShellshogunDecisionState+B6   j  ; was: loc_398D2
                                        ; Boss_ShellshogunPoseGateState+52   j
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.w   $29C(a5)
                clr.b   $A41(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
; End of function Boss_ShellshogunReturnToDecisionState
; Selects the next combat state after the active decision delay
Boss_ShellshogunDecisionState:                          ; CODE XREF: Boss_ShellshogunPreBattleDelayState+16   p  ; was: sub_398FE
                                        ; Boss_ShellshogunWaitForStageReadyState+6   p
                                        ; DATA XREF:
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   Boss_ShellshogunCheckDecisionTimer
                bsr.w   Boss_ShellshogunCheckDefeat
Boss_ShellshogunCheckDecisionTimer:                     ; CODE XREF: Boss_ShellshogunDecisionState+8   j  ; was: loc_3990C
                subq.w  #1,$BC(a5)
                bpl.s   Boss_ShellshogunUpdateDecisionPose
                move.w  (word_FF8234).w,d0
                beq.w   Boss_ShellshogunBeginTimedStageAdvance
                cmpi.w  #$6000,(word_FF8200).w
                bpl.s   Boss_ShellshogunSelectAttackByDistance
                cmpi.w  #$1D8,d0
                bpl.w   Boss_ShellshogunInitJumpAttack
Boss_ShellshogunSelectAttackByDistance:                 ; CODE XREF: Boss_ShellshogunDecisionState+22   j  ; was: loc_3992A
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$D0,d0
                bpl.s   Boss_ShellshogunSelectLongRangeAttack
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   Boss_ShellshogunBeginPoseGateState
                btst    #1,d0
                beq.w   Boss_ShellshogunInitAttackState
                btst    #0,d0
                beq.w   Boss_ShellshogunSlamAttackInit
                bra.w   Boss_ShellshogunInitDescendState
; ---------------------------------------------------------------------------
Boss_ShellshogunSelectLongRangeAttack:                  ; CODE XREF: Boss_ShellshogunDecisionState+36   j  ; was: loc_39954
                btst    #3,(dword_FFFF08).w
                bne.w   Boss_ShellshogunInitAttackState
Boss_ShellshogunBeginPoseGateState:                     ; CODE XREF: Boss_ShellshogunDecisionState+40   j  ; was: loc_3995E
                move.w  #$C,4(a5)
                move.w  #4,$58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShellshogunUpdateDecisionPose:                     ; CODE XREF: Boss_ShellshogunDecisionState+12   j  ; was: loc_39972
                lea     word_3A2E6(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunUpdateWrapper
                move.w  #$148,$494(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShellshogunBeginTimedStageAdvance:                 ; CODE XREF: Boss_ShellshogunDecisionState+18   j  ; was: loc_39988
                move.b  #$42,d0                         ; 'B'
                jsr     (Sound_PlaySFX).l
                move.w  #$28,4(a5)                      ; '('
                move.w  #$BA,$BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Shellshogun shell projectile attack with scroll
Boss_ShellshogunTimedStageAdvanceState:                 ; DATA XREF: ROM:0003954A   o  ; was: loc_399A8
                subq.w  #1,$BC(a5)
                bpl.s   Boss_ShellshogunUpdateTimedStageAdvance
                move.w  #$50,$BC(a5)                    ; 'P'
                bra.w   Boss_ShellshogunInitializeDecisionState
; ---------------------------------------------------------------------------
Boss_ShellshogunUpdateTimedStageAdvance:                ; CODE XREF: Boss_ShellshogunDecisionState+AE   j  ; was: loc_399B8
                addi.w  #3,(word_FF8234).w
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                lea     word_3A2F0(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunUpdateWrapper
                move.w  #$148,$494(a5)
                move.l  #word_EB888,$68(a5)
                rts
; End of function Boss_ShellshogunDecisionState
; Evaluates pose events and position before returning or starting a slam
Boss_ShellshogunPoseGateState:                          ; DATA XREF: ROM:0003952E   o  ; was: sub_399E8
                bsr.w   Boss_ShellshogunSetParams
                tst.w   $17C(a5)
                beq.s   Boss_ShellshogunPoseGateReturn
                cmpi.w  #$C,$58(a5)
                beq.s   Boss_ShellshogunTriggerPoseGateEffect
                cmpi.w  #4,$58(a5)
                bne.s   Boss_ShellshogunPoseGateReturn
                tst.w   (word_FF8234).w
                bne.s   Boss_ShellshogunEvaluatePoseGatePosition
                clr.w   $58(a5)
                move.w  #4,$BC(a5)
                bra.w   Boss_ShellshogunReturnToDecisionState
; ---------------------------------------------------------------------------
Boss_ShellshogunEvaluatePoseGatePosition:               ; CODE XREF: Boss_ShellshogunPoseGateState+1E   j  ; was: loc_39A16
                move.w  $17E(a5),d0
                tst.w   $54(a5)
                beq.s   Boss_ShellshogunCheckLeftPoseGateThreshold
                cmpi.w  #$1288,d0
                bpl.s   Boss_ShellshogunCheckPoseGateSlamDistance
                bra.s   Boss_ShellshogunReturnFromPoseGate
; ---------------------------------------------------------------------------
Boss_ShellshogunCheckLeftPoseGateThreshold:             ; CODE XREF: Boss_ShellshogunPoseGateState+36   j  ; was: loc_39A28
                cmpi.w  #$1348,d0
                bmi.s   Boss_ShellshogunCheckPoseGateSlamDistance
Boss_ShellshogunReturnFromPoseGate:                     ; CODE XREF: Boss_ShellshogunPoseGateState+3E   j  ; was: loc_39A2E
                move.w  #4,$58(a5)
                move.w  #$60,$BC(a5)                    ; '`'
                bra.w   Boss_ShellshogunInitializeDecisionState
; ---------------------------------------------------------------------------
Boss_ShellshogunTriggerPoseGateEffect:                  ; CODE XREF: Boss_ShellshogunPoseGateState+10   j  ; was: loc_39A3E
                                        ; Boss_ShellshogunPoseGateState+74   j
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$A1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Boss_ShellshogunPoseGateReturn:                         ; CODE XREF: Boss_ShellshogunPoseGateState+8   j  ; was: locret_39A54
                                        ; Boss_ShellshogunPoseGateState+18   j
                rts
; ---------------------------------------------------------------------------
Boss_ShellshogunCheckPoseGateSlamDistance:              ; CODE XREF: Boss_ShellshogunPoseGateState+3C   j  ; was: loc_39A56
                                        ; Boss_ShellshogunPoseGateState+44   j
                jsr     (Physics_GetPlayerDelta).l
                beq.s   Boss_ShellshogunTriggerPoseGateEffect
                cmpi.w  #$88,d0
                bpl.s   Boss_ShellshogunTriggerPoseGateEffect
                bsr.w   Boss_ShellshogunSlamAttackInit
                bra.s   Boss_ShellshogunTriggerPoseGateEffect
; End of function Boss_ShellshogunPoseGateState
; Initiates Shellshogun slam attack sequence with physics and sound effects
Boss_ShellshogunSlamAttackInit:                         ; CODE XREF: Boss_ShellshogunDecisionState+4E   j  ; was: sub_39A6A
                                        ; Boss_ShellshogunPoseGateState+7C   p
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
; Shellshogun slam attack preparation
Boss_ShellshogunSlamPreparationState:                   ; DATA XREF: ROM:00039530   o  ; was: loc_39A8A
                bsr.w   Boss_ShellshogunPhysicsUpdate
                cmpi.w  #$14,$58(a5)
                bmi.s   Boss_ShellshogunUpdateSlamAnimation
                addq.w  #2,4(a5)
                move.w  #$CEC0,$48(a5)
                move.w  $296(a5),$29C(a5)
                move.b  #$C0,$A41(a5)
                subi.w  #$50,(word_FF8234).w            ; 'P'
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
                bra.s   Boss_ShellshogunUpdateSlamAnimation
; End of function Boss_ShellshogunSlamAttackInit
; Updates the slam follow-through pose and linked-part rotation
Boss_ShellshogunSlamFollowThroughState:                 ; DATA XREF: ROM:00039532   o  ; was: sub_39ABE
                bsr.s   Boss_ShellshogunUpdateSlamAnimation
                tst.w   $17C(a5)
                beq.s   Boss_ShellshogunUpdateSlamRotation
                cmpi.w  #$18,$58(a5)
                bne.s   Boss_ShellshogunUpdateSlamRotation
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                clr.b   $A41(a5)
Boss_ShellshogunUpdateSlamRotation:                     ; CODE XREF: Boss_ShellshogunSlamFollowThroughState+6   j  ; was: loc_39AE8
                                        ; Boss_ShellshogunSlamFollowThroughState+E   j
                tst.w   $58(a5)
                bmi.w   Boss_ShellshogunReturnToDecisionState
                move.w  $29C(a5),d0
                beq.s   Boss_ShellshogunStoreSlamRotation
                addi.w  #$10,d0
                andi.w  #$1F0,d0
Boss_ShellshogunStoreSlamRotation:                      ; CODE XREF: Boss_ShellshogunSlamFollowThroughState+36   j  ; was: loc_39AFE
                move.w  d0,$29C(a5)
                rts
; End of function Boss_ShellshogunSlamFollowThroughState
; Advances and renders the slam pose stream
Boss_ShellshogunUpdateSlamAnimation:                    ; CODE XREF: Boss_ShellshogunSlamAttackInit+2A   j  ; was: sub_39B04
                                        ; Boss_ShellshogunSlamAttackInit+52   j
                lea     word_3A2FA(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                rts
; End of function Boss_ShellshogunUpdateSlamAnimation
; Initialize Shellshogun boss attack state with timers and flags
Boss_ShellshogunInitAttackState:                        ; CODE XREF: Boss_ShellshogunDecisionState+46   j  ; was: sub_39B1C
                                        ; Boss_ShellshogunDecisionState+5C   j
                move.w  #$1A,4(a5)
                move.w  #1,$11E(a5)
                move.w  #0,$29C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_ShellshogunInitAttackState
; Handle Shellshogun state transition with animation and sprite updates
Boss_ShellshogunTransitionState:                        ; DATA XREF: ROM:0003953C   o  ; was: sub_39B38
                tst.w   $11E(a5)
                bpl.s   loc_39B58
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.b  #$C0,$A41(a5)
                subi.w  #$20,$29C(a5)                   ; ' '
                andi.w  #$1E0,$29C(a5)
loc_39B58:                                              ; CODE XREF: Boss_ShellshogunTransitionState+4   j
                lea     word_3A33E(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunRenderSprites
                move.l  #word_EB876,$68(a5)
                rts
; End of function Boss_ShellshogunTransitionState
; Manage Shellshogun vertical movement and collision with screen shake effects
Boss_ShellshogunVerticalMovement:                       ; DATA XREF: ROM:0003953E   o  ; was: sub_39B70
                tst.w   $58(a5)
                bpl.s   loc_39B7E
                clr.l   $18(a5)
                bra.w   Boss_ShellshogunReturnToDecisionState
; ---------------------------------------------------------------------------
loc_39B7E:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+4   j
                tst.w   $29C(a5)
                beq.s   loc_39B90
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
loc_39B90:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+12   j
                tst.w   $17C(a5)
                beq.s   loc_39BD0
                cmpi.w  #$FFFD,$11E(a5)
                bne.s   loc_39BD0
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                subi.w  #$62,(word_FF8234).w            ; 'b'
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                addq.w  #1,$11C(a5)
                move.l  #$FFFA4000,$18(a5)
                tst.w   $54(a5)
                bne.s   loc_39BD0
                neg.l   $18(a5)
loc_39BD0:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+24   j
                                        ; Boss_ShellshogunVerticalMovement+2C   j
                tst.w   $54(a5)
                beq.s   loc_39BF0
                addi.l  #$4000,$18(a5)
                bmi.s   loc_39BFA
loc_39BE0:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+88   j
                clr.l   $18(a5)
                tst.w   $11C(a5)
                beq.s   loc_39BFA
                clr.b   $A41(a5)
                bra.s   loc_39BFA
; ---------------------------------------------------------------------------
loc_39BF0:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+64   j
                subi.l  #$4000,$18(a5)
                bmi.s   loc_39BE0
loc_39BFA:                                              ; CODE XREF: Boss_ShellshogunVerticalMovement+6E   j
                                        ; Boss_ShellshogunVerticalMovement+78   j
                lea     word_3A33E(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                bra.w   Boss_ShellshogunUpdateSpriteFlip
; End of function Boss_ShellshogunVerticalMovement
; Initialize Shellshogun jump attack with position and animation setup
Boss_ShellshogunInitJumpAttack:                         ; CODE XREF: Boss_ShellshogunDecisionState+28   j  ; was: sub_39C14
                move.w  #$1E,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                move.w  #$C,$11E(a5)
                move.b  #$C0,$A41(a5)
                move.b  #8,$A40(a5)
                move.w  #0,$29C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; End of function Boss_ShellshogunInitJumpAttack
; Update Shellshogun during jump attack with sound effects and defeat checks
Boss_ShellshogunJumpAttackUpdate:                       ; DATA XREF: ROM:00039540   o  ; was: sub_39C4C
                tst.w   $11E(a5)
                bmi.s   loc_39C9A
                bsr.w   Boss_ShellshogunCheckDefeat
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
                bne.s   loc_39C6E
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
loc_39C6E:                                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+16   j
                move.w  #$C860,$23E(a5)
                cmpi.w  #9,$58(a5)
                bmi.s   loc_39C82
                move.w  #$CC80,$23E(a5)
loc_39C82:                                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+2E   j
                lea     word_3A326(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunRenderSprites
                move.l  #word_EB888,$68(a5)
                rts
; ---------------------------------------------------------------------------
loc_39C9A:                                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C860,$23E(a5)
; Shellshogun jump attack air phase with rotation
Boss_ShellshogunJumpAttack_AirPhase:                    ; DATA XREF: ROM:00039542   o  ; was: loc_39CAE
                subq.w  #1,(word_FF8234).w
                tst.w   $58(a5)
                bpl.s   loc_39CC6
                move.b  #$C,$A40(a5)
                clr.b   $A41(a5)
                bra.w   Boss_ShellshogunReturnToDecisionState
; ---------------------------------------------------------------------------
loc_39CC6:                                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+6A   j
                subi.w  #$10,$29C(a5)
                andi.w  #$1E0,$29C(a5)
                bne.s   loc_39CDE
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
loc_39CDE:                                              ; CODE XREF: Boss_ShellshogunJumpAttackUpdate+86   j
                lea     word_3A338(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bra.w   Boss_ShellshogunRenderSprites
; End of function Boss_ShellshogunJumpAttackUpdate
; Initialize Shellshogun descending state with timer values
Boss_ShellshogunInitDescendState:                       ; CODE XREF: Boss_ShellshogunDecisionState+52   j  ; was: sub_39CEC
                move.w  #$22,4(a5)                      ; '"'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,$11E(a5)
; End of function Boss_ShellshogunInitDescendState
; Update Shellshogun descending animation and prepare for impact
Boss_ShellshogunDescendUpdate:                          ; DATA XREF: ROM:00039544   o  ; was: sub_39D02
                tst.w   $11E(a5)
                bmi.s   loc_39D20
                lea     word_3A358(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bsr.w   Boss_ShellshogunUpdateWrapper
                move.l  #word_EB876,$68(a5)
                rts
; ---------------------------------------------------------------------------
loc_39D20:                                              ; CODE XREF: Boss_ShellshogunDescendUpdate+4   j
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFA4000,$1C(a5)
                move.w  #$18,$BE(a5)
                move.w  #3,$11C(a5)
                bsr.w   Boss_ShellshogunCheckDefeat
; End of function Boss_ShellshogunDescendUpdate
; Handle Shellshogun landing with screen shake and vertical velocity
Boss_ShellshogunLandingSequence:                        ; DATA XREF: ROM:00039546   o  ; was: sub_39D44
                subq.w  #1,$11C(a5)
                bne.s   loc_39D78
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                subi.w  #$7D,(word_FF8234).w            ; '}'
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.l   #1,d0
                addi.l  #$13000,d0
                move.l  d0,$18(a5)
                tst.w   $54(a5)
                beq.s   loc_39D78
                neg.l   $18(a5)
loc_39D78:                                              ; CODE XREF: Boss_ShellshogunLandingSequence+4   j
                                        ; Boss_ShellshogunLandingSequence+2E   j
                subq.w  #1,$BE(a5)
                bpl.s   loc_39D92
                cmpi.w  #$FFE0,$BE(a5)
                bmi.s   loc_39D92
                addi.w  #$10,$56(a5)
                andi.w  #$1F0,$56(a5)
loc_39D92:                                              ; CODE XREF: Boss_ShellshogunLandingSequence+38   j
                                        ; Boss_ShellshogunLandingSequence+40   j
                addi.l  #$3000,$1C(a5)
                bmi.s   loc_39DA4
                cmpi.w  #$148,$8B4(a5)
                bpl.s   loc_39DB2
loc_39DA4:                                              ; CODE XREF: Boss_ShellshogunLandingSequence+56   j
                lea     word_3A358(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bra.w   Boss_ShellshogunUpdateWrapper
; ---------------------------------------------------------------------------
loc_39DB2:                                              ; CODE XREF: Boss_ShellshogunLandingSequence+5E   j
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$148,$8B4(a5)
                clr.l   $1C(a5)
                move.w  #5,(word_FFA010).w
                move.w  #5,(word_FFA014).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ShellshogunLandingSequence
; Decelerate Shellshogun horizontal velocity to zero
Boss_ShellshogunDecelerateHorizontal:                   ; DATA XREF: ROM:00039548   o  ; was: sub_39DEA
                tst.w   $18(a5)
                bpl.s   loc_39E00
                addi.l  #$1000,$18(a5)
                bmi.s   loc_39E0A
loc_39DFA:                                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+1E   j
                clr.l   $18(a5)
                bra.s   loc_39E0A
; ---------------------------------------------------------------------------
loc_39E00:                                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+4   j
                subi.l  #$1000,$18(a5)
                bmi.s   loc_39DFA
loc_39E0A:                                              ; CODE XREF: Boss_ShellshogunDecelerateHorizontal+E   j
                                        ; Boss_ShellshogunDecelerateHorizontal+14   j
                tst.w   $58(a5)
                bmi.w   Boss_ShellshogunReturnToDecisionState
                lea     word_3A372(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                bra.w   Boss_ShellshogunUpdateWrapper
; End of function Boss_ShellshogunDecelerateHorizontal
; Sets boss parameters and sprite properties
Boss_ShellshogunSetParams:                              ; CODE XREF: Boss_ShellshogunSetupPhase+150   j  ; was: sub_39E20
                                        ; sub_396D2   p
                lea     word_3A314(pc),a1
                nop
                bsr.w   Boss_ShellshogunAnimUpdate
                move.w  #$148,$494(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CAA0,$4A(a5)
                cmpi.w  #9,$58(a5)
                bpl.s   loc_39E56
                move.w  #$148,$8B4(a5)
                move.w  #$CEC0,$48(a5)
                move.w  #$CEC0,$4A(a5)
loc_39E56:                                              ; CODE XREF: Boss_ShellshogunSetParams+22   j
                bra.w   *+4
; End of function Boss_ShellshogunSetParams
; Wrapper calling boss update routine
Boss_ShellshogunUpdateWrapper:                          ; CODE XREF: Boss_ShellshogunDefeatLaunchState+B4   j  ; was: sub_39E5A
                                        ; Boss_ShellshogunDecisionState+7E   p
                bsr.w   Boss_ShellshogunPhysicsUpdate
; End of function Boss_ShellshogunUpdateWrapper
; Renders boss metasprites and updates display
