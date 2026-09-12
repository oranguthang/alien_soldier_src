; Deep Strider controller, attack states, and linked-part rendering
Boss_DeepStriderMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3E582
                tst.w   4(a5)
                beq.w   Boss_DeepStriderStateDispatch
                tst.w   8(a5)
                beq.s   Boss_DeepStriderStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_DeepStriderUpdateStageRelativeX
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_DeepStriderUpdateStageRelativeX
                tst.w   (BossHealth).w
                beq.w   Boss_DeepStriderBeginDefeat
Boss_DeepStriderUpdateStageRelativeX:                   ; CODE XREF: Boss_DeepStriderMain+14   j  ; was: loc_3E5A8
                                        ; Boss_DeepStriderMain+1C   j
                jsr     (Gfx_ProcessDefaultColorFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
; State machine dispatcher for Deep Strider boss
Boss_DeepStriderStateDispatch:                          ; CODE XREF: Boss_DeepStriderMain+4   j  ; was: loc_3E5BA
                                        ; Boss_DeepStriderMain+C   j
                move.w  4(a5),d0
                movea.w Boss_DeepStriderStateOffsets(pc,d0.w),a0
                adda.l  #Boss_DeepStriderInit,a0
                jmp     (a0)
; End of function Boss_DeepStriderMain
; ---------------------------------------------------------------------------
Boss_DeepStriderStateOffsets:   dc.w    Boss_DeepStriderInit-Boss_DeepStriderInit  ; was: off_3E5CA
                                        ; DATA XREF: Boss_DeepStriderMain+3C   r
                dc.w    Boss_DeepStriderIntroRise-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroRisingState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroRiseDelayState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroDiveState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroLaunchSetupState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroArcLandingState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroPoseAlignmentState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleEntryPoseState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleEntryDelayState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleDescendState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleDescentDelayState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleAscendState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattleDecisionState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDiveAttackState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatFallState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatRiseState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatBurstState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatCompletionDelayState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderHoverAndShootState-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderHoverExitRiseState-Boss_DeepStriderInit

; Initializes Deep Strider boss state
Boss_DeepStriderInit:                                   ; DATA XREF: Boss_DeepStriderMain+40   o  ; was: sub_3E5F4
                                        ; ROM:Boss_DeepStriderStateOffsets   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
; End of function Boss_DeepStriderInit
; Clears sprites except boss
Boss_DeepStriderClearStageObjects:                      ; CODE XREF: Boss_DeepStriderDefeatRiseState+38   p  ; was: sub_3E5FC
                move.w  #$19C,d0
                move.w  #$208,d1
                jmp     Object_ClearAllExceptTypes
; End of function Boss_DeepStriderClearStageObjects
; Boss intro rise sequence
Boss_DeepStriderIntroRise:                              ; DATA XREF: ROM:0003E5CC   o  ; was: sub_3E60A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$D,d7
                movea.l #Boss_DeepStriderMetaspriteDescriptors,a0
                movea.l #Boss_DeepStriderPartRadii,a1
                movea.l #Boss_DeepStriderPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$19C,(a5)
                bset    #0,$2A2(a5)
                move.w  #$D00,$4E2(a5)
                lea     (Boss_DeepStriderObjectInitTable).l,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #4,4(a5)
                move.w  #$180,$536(a5)
                move.w  #$B8,$4F0(a5)
                move.w  #$60,$4F4(a5)                   ; '`'
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$100,$54(a5)
                move.w  #$80,$56(a5)
                move.w  #$1E2,$1DC(a5)
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$12000,$4FC(a5)
                clr.w   $11C(a5)
; Deep Strider intro rising with projectiles
Boss_DeepStriderIntroRisingState:                       ; DATA XREF: ROM:0003E5CE   o  ; was: loc_3E6A0
                tst.w   $11C(a5)
                bne.s   Boss_DeepStriderAdvanceIntroRise
                cmpi.w  #$110,$4F4(a5)
                bmi.s   Boss_DeepStriderAdvanceIntroRise
                addq.w  #1,$11C(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
Boss_DeepStriderAdvanceIntroRise:                       ; CODE XREF: Boss_DeepStriderIntroRise+9A   j  ; was: loc_3E6C0
                                        ; Boss_DeepStriderIntroRise+A2   j
                addq.w  #1,$1DC(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.l   $4FC(a5)
                move.w  #$34,$11C(a5)                   ; '4'
; Waits during intro rise before next state
Boss_DeepStriderIntroRiseDelayState:                    ; DATA XREF: ROM:0003E5D0   o  ; was: loc_3E6E4
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #2,$29C(a5)
                move.w  #$100,$54(a5)
                bsr.w   Boss_DeepStriderSetupDivePositionAndVelocity
; End of function Boss_DeepStriderIntroRise
; Boss intro dive sequence
Boss_DeepStriderIntroDiveState:                         ; DATA XREF: ROM:0003E5D2   o  ; was: sub_3E700
                bsr.w   Boss_DeepStriderDiveSequence
                bmi.w   Boss_DeepStriderMotionStateReturn
                addq.w  #2,4(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                move.w  #$38,$11C(a5)                   ; '8'
; Sets up dive parameters and velocities
Boss_DeepStriderIntroLaunchSetupState:                  ; DATA XREF: ROM:0003E5D4   o  ; was: loc_3E71A
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$198,$4F0(a5)
                move.w  #$160,$4F4(a5)
                clr.w   $54(a5)
                move.w  #$1A0,$56(a5)
                move.w  #$28,$1DC(a5)                   ; '('
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #0,$23E(a5)
                move.l  #$FFFF0000,$4F8(a5)
                move.l  #$FFF80000,$4FC(a5)
                clr.w   $11C(a5)
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
; End of function Boss_DeepStriderIntroDiveState
; Lands the introductory launch arc before aligning the battle-entry pose
Boss_DeepStriderIntroArcLandingState:                   ; DATA XREF: ROM:0003E5D6   o  ; was: sub_3E776
                subq.w  #1,$1DE(a5)
                subq.w  #1,$1DC(a5)
                subq.w  #1,$56(a5)
                addi.l  #$3800,$4FC(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                cmpi.w  #$120,$2B4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$120,$2B4(a5)
                move.w  #$C8C0,$48(a5)
                move.w  #$C8C0,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
; Aligns the linked-part pose before the battle-entry sequence
Boss_DeepStriderIntroPoseAlignmentState:                ; DATA XREF: ROM:0003E5D8   o  ; was: loc_3E7B6
                subq.w  #6,$56(a5)
                subq.w  #2,$1DC(a5)
                andi.w  #$1FE,$1DC(a5)
                cmpi.w  #$1E0,$1DC(a5)
                bne.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                clr.w   $17C(a5)
                moveq   #0,d0
                jsr     (BossMessage_Start).l
                bra.s   Boss_DeepStriderBattleEntryPoseState
; End of function Boss_DeepStriderIntroArcLandingState
; Holds the battle-entry pose before starting the repeating attack cycle
Boss_DeepStriderBattleEntryDelayState:                  ; DATA XREF: ROM:0003E5DC   o  ; was: sub_3E7E8
                subq.w  #1,$17E(a5)
                bpl.s   Boss_DeepStriderUpdateBattleEntryPose
                bra.w   Boss_DeepStriderBeginBattleCycle
; End of function Boss_DeepStriderBattleEntryDelayState
; Oscillates the linked-part pose while waiting for the battle-entry sequence
Boss_DeepStriderBattleEntryPoseState:                   ; CODE XREF: Boss_DeepStriderIntroPoseAlignmentState+70   j  ; was: sub_3E7F2
                                        ; DATA XREF: ROM:0003E5DA   o
                tst.w   (MessageSequenceState).w
                bne.s   Boss_DeepStriderUpdateBattleEntryPose
                addq.w  #2,4(a5)
                move.w  #$40,$17E(a5)                   ; '@'
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
Boss_DeepStriderUpdateBattleEntryPose:                  ; CODE XREF: Boss_DeepStriderBattleEntryDelayState+4   j  ; was: loc_3E80C
                                        ; Boss_DeepStriderBattleEntryPoseState+4   j
                andi.w  #$1FC,$1DE(a5)
                tst.w   $11E(a5)
                bpl.s   Boss_DeepStriderCountDownBattleEntryPause
                tst.w   $17C(a5)
                bne.s   Boss_DeepStriderAdjustNegativeBattleEntryPose
                cmpi.w  #$1E0,$1DE(a5)
                beq.s   Boss_DeepStriderRotatePositiveBattleEntryPose
                addq.w  #4,$1DE(a5)
Boss_DeepStriderRotatePositiveBattleEntryPose:          ; CODE XREF: Boss_DeepStriderBattleEntryPoseState+32   j  ; was: loc_3E82A
                addq.w  #3,$56(a5)
                addq.w  #2,$1DC(a5)
                cmpi.w  #$1FA,$1DC(a5)
                bpl.s   Boss_DeepStriderRandomizeNextBattleEntryPose
                subq.w  #1,$11C(a5)
                bmi.s   Boss_DeepStriderRandomizeNextBattleEntryPose
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
Boss_DeepStriderAdjustNegativeBattleEntryPose:          ; CODE XREF: Boss_DeepStriderBattleEntryPoseState+2A   j  ; was: loc_3E844
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   Boss_DeepStriderRotateNegativeBattleEntryPose
                subq.w  #4,$1DE(a5)
Boss_DeepStriderRotateNegativeBattleEntryPose:          ; CODE XREF: Boss_DeepStriderBattleEntryPoseState+58   j  ; was: loc_3E850
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1D8,$1DC(a5)
                bmi.s   Boss_DeepStriderRandomizeNextBattleEntryPose
                subq.w  #1,$11C(a5)
                bmi.s   Boss_DeepStriderRandomizeNextBattleEntryPose
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
Boss_DeepStriderCountDownBattleEntryPause:              ; CODE XREF: Boss_DeepStriderBattleEntryPoseState+24   j  ; was: loc_3E86A
                subq.w  #1,$11E(a5)
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
Boss_DeepStriderRandomizeNextBattleEntryPose:           ; CODE XREF: Boss_DeepStriderBattleEntryPoseState+46   j  ; was: loc_3E872
                                        ; Boss_DeepStriderBattleEntryPoseState+4C   j
                move.b  (RandomNumberState).w,d0
                andi.w  #$F,d0
                addq.w  #6,d0
                move.w  d0,$11C(a5)
                move.w  (RandomNumberState).w,d0
                andi.w  #3,d0
                move.w  d0,$11E(a5)
                eori.w  #1,$17C(a5)
                bra.w   Boss_DeepStriderUpdateParts
; End of function Boss_DeepStriderBattleEntryPoseState
; Main battle logic with attack patterns and phase transitions
Boss_DeepStriderBeginBattleCycle:                       ; CODE XREF: Boss_DeepStriderBattleEntryDelayState+6   j  ; was: sub_3E896
                addq.w  #2,4(a5)
                move.w  #2,$11C(a5)
                move.w  #$80,$536(a5)
; Deep Strider battle descend with rotation
Boss_DeepStriderBattleDescendState:                     ; DATA XREF: ROM:0003E5DE   o  ; was: loc_3E8A6
                andi.w  #$1FC,$1DE(a5)
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   Boss_DeepStriderContinueBattleDescent
                subq.w  #4,$1DE(a5)
Boss_DeepStriderContinueBattleDescent:                  ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1C   j  ; was: loc_3E8B8
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1CC,$1DC(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
; Deep Strider battle wait timer
Boss_DeepStriderBattleDescentDelayState:                ; DATA XREF: ROM:0003E5E0   o  ; was: loc_3E8CE
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   $11E(a5)
                addq.w  #2,$29C(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.l  #$1E000,$4F8(a5)
                move.l  #$FFFB0000,$4FC(a5)
                bclr    #0,$2A2(a5)
; Deep Strider battle ascend with projectiles
Boss_DeepStriderBattleAscendState:                      ; DATA XREF: ROM:0003E5E2   o  ; was: loc_3E90A
                tst.w   $11E(a5)
                bne.s   Boss_DeepStriderAdvanceBattleAscent
                cmpi.w  #$150,$4F4(a5)
                bmi.s   Boss_DeepStriderAdvanceBattleAscent
                addq.w  #1,$11E(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
Boss_DeepStriderAdvanceBattleAscent:                    ; CODE XREF: Boss_DeepStriderBeginBattleCycle+78   j  ; was: loc_3E92A
                                        ; Boss_DeepStriderBeginBattleCycle+80   j
                addq.w  #6,$56(a5)
                addq.w  #1,$1DC(a5)
                subi.l  #$C00,$4F8(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                move.w  #$B,$17C(a5)
Boss_DeepStriderBeginBattleDecisionState:               ; CODE XREF: Boss_DeepStriderBeginBattleCycle+28A   j  ; was: loc_3E952
                                        ; Boss_DeepStriderDiveAttackState+10   j
                move.w  #$1A,4(a5)
                bclr    #0,(byte_FF825C).w
                move.b  #$10,$141(a5)
                move.w  #$18,$534(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                tst.w   (DifficultyMode).w
                bne.s   Boss_DeepStriderRandomizeBattleDecisionDelay
                move.w  #$10,$11C(a5)
                bra.s   Boss_DeepStriderBattleDecisionState
; ---------------------------------------------------------------------------
Boss_DeepStriderRandomizeBattleDecisionDelay:           ; CODE XREF: Boss_DeepStriderBeginBattleCycle+EC   j  ; was: loc_3E98C
                move.w  (RandomNumberState).w,d0
                andi.w  #$3F,d0                         ; '?'
                addq.w  #4,d0
                move.w  d0,$11C(a5)
; Idle timer before attack selection
Boss_DeepStriderBattleDecisionState:                    ; CODE XREF: Boss_DeepStriderBeginBattleCycle+F4   j  ; was: loc_3E99A
                                        ; DATA XREF: ROM:0003E5E4   o
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                subq.w  #1,$17C(a5)
                cmpi.w  #$A,$17C(a5)
                bpl.w   Boss_DeepStriderBeginDiveAttack
                tst.w   $17C(a5)
                bmi.w   Boss_DeepStriderBeginHoverAndShoot
                btst    #0,(byte_FF8244).w
                beq.w   Boss_DeepStriderBeginDiveAttack
                moveq   #7,d0
                btst    #6,(byte_FF8244).w
                beq.w   Boss_DeepStriderTestDiveRandomSelection
                moveq   #1,d0
Boss_DeepStriderTestDiveRandomSelection:                ; CODE XREF: Boss_DeepStriderBeginBattleCycle+134   j  ; was: loc_3E9D0
                move.w  (RandomNumberState).w,d1
                and.w   d0,d1
                beq.s   Boss_DeepStriderBeginHoverAndShoot
                bra.w   Boss_DeepStriderBeginDiveAttack
; ---------------------------------------------------------------------------
Boss_DeepStriderBeginHoverAndShoot:                     ; CODE XREF: Boss_DeepStriderBeginBattleCycle+11E   j  ; was: loc_3E9DC
                                        ; Boss_DeepStriderBeginBattleCycle+140   j
                move.w  #$26,4(a5)                      ; '&'
                move.w  #1,$534(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                move.w  #$BF,$17C(a5)
                move.w  #$180,$56(a5)
                move.w  #$180,$536(a5)
                move.w  #$1F4,$1DC(a5)
                clr.w   $23C(a5)
                move.w  #$1E0,$1DE(a5)
                bsr.w   Boss_DeepStriderCalculatePhaseDiveX
                move.w  d0,$4F0(a5)
                move.w  #$1B0,$4F4(a5)
; Deep Strider hovering with angle firing
Boss_DeepStriderHoverAndShootState:                     ; DATA XREF: ROM:0003E5F0   o  ; was: loc_3EA20
                jsr     (Physics_GetPlayerDelta).l
                move.w  #$100,$54(a5)
                tst.w   d1
                bpl.s   Boss_DeepStriderApplyHoverFacing
                clr.w   $54(a5)
Boss_DeepStriderApplyHoverFacing:                       ; CODE XREF: Boss_DeepStriderBeginBattleCycle+198   j  ; was: loc_3EA34
                tst.w   $11E(a5)
                bne.s   Boss_DeepStriderDecreaseHoverJointAngle
                addq.w  #1,$56(a5)
                cmpi.w  #$190,$56(a5)
                beq.s   Boss_DeepStriderReverseHoverJointMotion
                bra.s   Boss_DeepStriderUpdateHoverVerticalMotion
; ---------------------------------------------------------------------------
Boss_DeepStriderDecreaseHoverJointAngle:                ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1A2   j  ; was: loc_3EA48
                subq.w  #1,$56(a5)
                cmpi.w  #$178,$56(a5)
                bne.s   Boss_DeepStriderUpdateHoverVerticalMotion
Boss_DeepStriderReverseHoverJointMotion:                ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1AE   j  ; was: loc_3EA54
                eori.w  #1,$11E(a5)
Boss_DeepStriderUpdateHoverVerticalMotion:              ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1B0   j  ; was: loc_3EA5A
                                        ; Boss_DeepStriderBeginBattleCycle+1BC   j
                tst.w   $11C(a5)
                beq.s   Boss_DeepStriderAccelerateHoverUpward
                addi.l  #$C00,$4FC(a5)
                bmi.s   Boss_DeepStriderCheckHoverDownwardHeight
                cmpi.l  #$10000,$4FC(a5)
                bmi.s   Boss_DeepStriderCheckHoverDownwardHeight
                move.l  #$10000,$4FC(a5)
Boss_DeepStriderCheckHoverDownwardHeight:               ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1D2   j  ; was: loc_3EA7C
                                        ; Boss_DeepStriderBeginBattleCycle+1DC   j
                cmpi.w  #$160,$4F4(a5)
                bmi.s   Boss_DeepStriderUpdateHoverAttack
                tst.w   $17C(a5)
                bmi.w   Boss_DeepStriderBeginHoverExitRise
                bra.s   Boss_DeepStriderReverseHoverVerticalMotion
; ---------------------------------------------------------------------------
Boss_DeepStriderAccelerateHoverUpward:                  ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1C8   j  ; was: loc_3EA8E
                subi.l  #$1000,$4FC(a5)
                bpl.s   Boss_DeepStriderCheckHoverUpwardHeight
                cmpi.l  #$FFFF0000,$4FC(a5)
                bpl.s   Boss_DeepStriderCheckHoverUpwardHeight
                move.l  #$FFFF0000,$4FC(a5)
Boss_DeepStriderCheckHoverUpwardHeight:                 ; CODE XREF: Boss_DeepStriderBeginBattleCycle+200   j  ; was: loc_3EAAA
                                        ; Boss_DeepStriderBeginBattleCycle+20A   j
                cmpi.w  #$170,$4F4(a5)
                bpl.s   Boss_DeepStriderUpdateHoverAttack
Boss_DeepStriderReverseHoverVerticalMotion:             ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1F6   j  ; was: loc_3EAB2
                eori.w  #1,$11C(a5)
Boss_DeepStriderUpdateHoverAttack:                      ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1EC   j  ; was: loc_3EAB8
                                        ; Boss_DeepStriderBeginBattleCycle+21A   j
                subq.w  #1,$17C(a5)
                cmpi.w  #$9F,$17C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                bsr.w   Boss_DeepStriderFireAngleProjectile
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
Boss_DeepStriderBeginHoverExitRise:                     ; CODE XREF: Boss_DeepStriderBeginBattleCycle+1F2   j  ; was: loc_3EACE
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.l  #$FFFB0000,$4FC(a5)
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
                move.w  #$B,$17C(a5)
; Deep Strider post-dive rising with scroll
Boss_DeepStriderHoverExitRiseState:                     ; DATA XREF: ROM:0003E5F2   o  ; was: loc_3EAF2
                addq.w  #1,$11C(a5)
                addi.l  #$3A00,$4FC(a5)
                subq.w  #8,$56(a5)
                subq.w  #1,$1DC(a5)
                cmpi.w  #$18,$11C(a5)
                bmi.s   Boss_DeepStriderCheckHoverExitHeight
                addq.w  #2,$1DC(a5)
                addq.w  #4,$56(a5)
Boss_DeepStriderCheckHoverExitHeight:                   ; CODE XREF: Boss_DeepStriderBeginBattleCycle+276   j  ; was: loc_3EB16
                cmpi.w  #$1C0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                bra.w   Boss_DeepStriderBeginBattleDecisionState
; ---------------------------------------------------------------------------
Boss_DeepStriderBeginDiveAttack:                        ; CODE XREF: Boss_DeepStriderBeginBattleCycle+116   j  ; was: loc_3EB24
                                        ; Boss_DeepStriderBeginBattleCycle+128   j
                move.b  #$12,$141(a5)
                clr.w   $17E(a5)
                move.w  #$1C,4(a5)
                move.w  $29C(a5),d0
                beq.s   Boss_DeepStriderSetNonzeroDiveFacing
                cmpi.w  #4,d0
                bpl.s   Boss_DeepStriderSetZeroDiveFacing
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   Boss_DeepStriderSetNonzeroDiveFacing
Boss_DeepStriderSetZeroDiveFacing:                      ; CODE XREF: Boss_DeepStriderBeginBattleCycle+2A8   j  ; was: loc_3EB4A
                clr.w   $54(a5)
                bra.s   Boss_DeepStriderInitializeDiveMotion
; ---------------------------------------------------------------------------
Boss_DeepStriderSetNonzeroDiveFacing:                   ; CODE XREF: Boss_DeepStriderBeginBattleCycle+2A2   j  ; was: loc_3EB50
                                        ; Boss_DeepStriderBeginBattleCycle+2B2   j
                move.w  #$100,$54(a5)
Boss_DeepStriderInitializeDiveMotion:                   ; CODE XREF: Boss_DeepStriderBeginBattleCycle+2B8   j  ; was: loc_3EB56
                bsr.w   Boss_DeepStriderSetupDivePositionAndVelocity
; End of function Boss_DeepStriderBeginBattleCycle
; Checks dive completion and damage state
Boss_DeepStriderDiveAttackState:                        ; DATA XREF: ROM:0003E5E6   o  ; was: sub_3EB5A
                bsr.w   Boss_DeepStriderDiveSequence
                bmi.s   Boss_DeepStriderUpdateDiveImpactSignal
                tst.w   $54(a5)
                bne.s   Boss_DeepStriderAdvanceDivePhaseIndex
                subq.w  #2,$29C(a5)
                bra.w   Boss_DeepStriderBeginBattleDecisionState
; ---------------------------------------------------------------------------
Boss_DeepStriderAdvanceDivePhaseIndex:                  ; CODE XREF: Boss_DeepStriderDiveAttackState+A   j  ; was: loc_3EB6E
                addq.w  #2,$29C(a5)
                bra.w   Boss_DeepStriderBeginBattleDecisionState
; ---------------------------------------------------------------------------
Boss_DeepStriderUpdateDiveImpactSignal:                 ; CODE XREF: Boss_DeepStriderDiveAttackState+4   j  ; was: loc_3EB76
                tst.w   $17E(a5)
                bne.s   Boss_DeepStriderPollDiveImpactSignal
                bclr    #1,$142(a5)
                beq.s   Boss_DeepStriderDiveAttackStateReturn
                bset    #1,(byte_FF825C).w
                move.w  #2,$17E(a5)
Boss_DeepStriderPollDiveImpactSignal:                   ; CODE XREF: Boss_DeepStriderDiveAttackState+20   j  ; was: loc_3EB90
                bclr    #1,(byte_FF825C).w
                bne.s   Boss_DeepStriderPublishDiveImpactPosition
                clr.w   $17E(a5)
                rts
; ---------------------------------------------------------------------------
Boss_DeepStriderPublishDiveImpactPosition:              ; CODE XREF: Boss_DeepStriderDiveAttackState+3C   j  ; was: loc_3EB9E
                move.w  #$64,(word_FF824E).w            ; 'd'
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $130(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8250).w
                move.w  $134(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8252).w
Boss_DeepStriderDiveAttackStateReturn:                  ; CODE XREF: Boss_DeepStriderDiveAttackState+28   j  ; was: locret_3EBC8
                rts
; End of function Boss_DeepStriderDiveAttackState
; Starts the final defeat sequence after the boss counter reaches zero
Boss_DeepStriderBeginDefeat:                            ; CODE XREF: Boss_DeepStriderMain+22   j  ; was: sub_3EBCA
                move.w  #4,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$80,$536(a5)
                move.w  #$30,$1DC(a5)                   ; '0'
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$FFFBE000,$4FC(a5)
                move.l  #$FFFEE000,$4F8(a5)
                cmpi.w  #$880,$BC(a5)
                bpl.s   Boss_DeepStriderDefeatFallState
                neg.l   $4F8(a5)
; Fades the palette and emits debris while the defeated boss falls
Boss_DeepStriderDefeatFallState:                        ; CODE XREF: Boss_DeepStriderBeginDefeat+5E   j  ; was: loc_3EC2E
                                        ; DATA XREF: ROM:0003E5E8   o
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_DeepStriderSpawnDefeatDebris
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                cmpi.w  #$150,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.l  #$FFFEE000,$4FC(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
; End of function Boss_DeepStriderBeginDefeat
; Raises the defeated boss before clearing the remaining stage objects
Boss_DeepStriderDefeatRiseState:                        ; DATA XREF: ROM:0003E5EA   o  ; was: sub_3EC7A
                jsr     (Gfx_UpdatePaletteFade).l
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                cmpi.w  #$180,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  $4F0(a5),$10(a5)
                move.w  #$30,$48(a5)                    ; '0'
                move.w  #$100,2(a5)
                clr.w   8(a5)
                bsr.w   Boss_DeepStriderClearStageObjects
; End of function Boss_DeepStriderDefeatRiseState
; Emits the final vertical burst after the defeat hold timer
Boss_DeepStriderDefeatBurstState:                       ; DATA XREF: ROM:0003E5EC   o  ; was: sub_3ECB6
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bpl.w   Boss_DeepStriderMotionStateReturn
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                movea.w a5,a0
                move.l  #$FFF80000,d4
                move.w  $10(a5),d5
Boss_DeepStriderSpawnNextDefeatBurst:                   ; CODE XREF: Boss_DeepStriderDefeatBurstState+60   j  ; was: loc_3ECE6
                lea     $60(a0),a0
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                jsr     (Projectile_InitType1A8).l
                move.l  #SharedCombatSpriteAnimation00,8(a0)
                move.l  d4,$1C(a0)
                move.w  #$150,$14(a0)
                move.w  d5,$10(a0)
                addi.l  #$8000,d4
                bmi.s   Boss_DeepStriderSpawnNextDefeatBurst
; End of function Boss_DeepStriderDefeatBurstState
; Waits before hiding the defeated boss object
Boss_DeepStriderDefeatCompletionDelayState:             ; DATA XREF: ROM:0003E5EE   o  ; was: sub_3ED18
                subq.w  #1,$48(a5)
                bpl.s   Boss_DeepStriderDefeatCompletionDelayReturn
                bset    #4,2(a5)
Boss_DeepStriderDefeatCompletionDelayReturn:            ; CODE XREF: Boss_DeepStriderDefeatCompletionDelayState+4   j  ; was: locret_3ED24
                rts
; End of function Boss_DeepStriderDefeatCompletionDelayState
; Spawns randomized debris during the final defeat fall
Boss_DeepStriderSpawnDefeatDebris:                      ; CODE XREF: Boss_DeepStriderBeginDefeat+6A   p  ; was: sub_3ED26
                move.w  #2,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                btst    #0,(FrameCounter+1).w
                bne.s   Boss_DeepStriderSpawnDefeatDebrisReturn
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   Boss_DeepStriderSpawnDefeatDebrisReturn
                jsr     (Sprite_InitType160).l
                move.l  #SharedCombatSpriteAnimation00,8(a0)
                move.b  (RandomNumberState).w,d1
                andi.w  #3,d1
                bne.s   Boss_DeepStriderApplyDefeatDebrisMotion
                move.l  #SharedCombatSpriteAnimation05,8(a0)
Boss_DeepStriderApplyDefeatDebrisMotion:                ; CODE XREF: Boss_DeepStriderSpawnDefeatDebris+32   j  ; was: loc_3ED62
                move.w  (RandomNumberState).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  $4F0(a5),$10(a0)
                add.w   d0,$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  #$FFFC2000,$1C(a0)
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Boss_DeepStriderSpawnDefeatDebrisReturn
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Boss_DeepStriderSpawnDefeatDebrisReturn:                ; CODE XREF: Boss_DeepStriderSpawnDefeatDebris+12   j  ; was: locret_3ED9A
                                        ; Boss_DeepStriderSpawnDefeatDebris+1A   j
                rts
; End of function Boss_DeepStriderSpawnDefeatDebris
; Spawns quad projectile pattern
Boss_DeepStriderSpawnQuadVolley:                        ; CODE XREF: Boss_DeepStriderIntroRise+B2   p  ; was: sub_3ED9C
                                        ; Boss_DeepStriderIntroDiveState+72   p
                move.w  $D0(a5),d5
                move.w  #$150,d6
                jmp     Projectile_SpawnFourDirectionalShots
; End of function Boss_DeepStriderSpawnQuadVolley
; Selects the phase-dependent dive start position and velocity
Boss_DeepStriderSetupDivePositionAndVelocity:           ; CODE XREF: Boss_DeepStriderIntroRise+F2   p  ; was: sub_3EDAA
                                        ; Boss_DeepStriderBeginBattleCycle:Boss_DeepStriderInitializeDiveMotion   p
                move.w  #$180,$536(a5)
                clr.w   $11C(a5)
                bsr.w   Boss_DeepStriderCalculatePhaseDiveX
                move.w  d0,$4F0(a5)
                move.w  #$160,$4F4(a5)
                move.w  #$17C,$56(a5)
                move.w  #$1FC,$1DC(a5)
                move.w  #$1A0,$1DE(a5)
                move.w  #$20,$23C(a5)                   ; ' '
                move.w  #$1B0,$23E(a5)
                move.l  #$FFFC4800,$4F8(a5)
                move.l  #$FFFA0000,$4FC(a5)
                tst.w   $54(a5)
                beq.s   Boss_DeepStriderSetupDivePositionReturn
                neg.l   $4F8(a5)
Boss_DeepStriderSetupDivePositionReturn:                ; CODE XREF: Boss_DeepStriderSetupDivePositionAndVelocity+4A   j  ; was: locret_3EDFA
                rts
; End of function Boss_DeepStriderSetupDivePositionAndVelocity
; Calculates the dive start X coordinate for the current phase index
Boss_DeepStriderCalculatePhaseDiveX:                    ; CODE XREF: Boss_DeepStriderBeginBattleCycle+17C   p  ; was: sub_3EDFC
                                        ; Boss_DeepStriderSetupDivePositionAndVelocity+A   p
                moveq   #0,d2
                move.w  $29C(a5),d0
                move.w  Boss_DeepStriderDiveXOffsets(pc,d0.w),d0
                move.w  (dword_FFA900).w,d1
                subi.w  #$710,d1
                sub.w   d1,d0
                add.w   d2,d0
                rts
; End of function Boss_DeepStriderCalculatePhaseDiveX
; ---------------------------------------------------------------------------
Boss_DeepStriderDiveXOffsets:   dc.w    $90, $170, $250  ; DATA XREF: Boss_DeepStriderCalculatePhaseDiveX+6   r  ; was: word_3EE14

; Boss dive attack sequence
Boss_DeepStriderDiveSequence:                           ; CODE XREF: Boss_DeepStriderIntroDiveState   p  ; was: sub_3EE1A
                                        ; sub_3EB5A   p
                addq.w  #1,$11C(a5)
                move.b  #$4C,d0                         ; 'L'
                cmpi.w  #3,$11C(a5)
                beq.s   Boss_DeepStriderEmitTimedDiveVolley
                move.b  #$4D,d0                         ; 'M'
                cmpi.w  #$32,$11C(a5)                   ; '2'
                bne.s   Boss_DeepStriderUpdateDiveRotation
Boss_DeepStriderEmitTimedDiveVolley:                    ; CODE XREF: Boss_DeepStriderDiveSequence+E   j  ; was: loc_3EE36
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnQuadVolley
Boss_DeepStriderUpdateDiveRotation:                     ; CODE XREF: Boss_DeepStriderDiveSequence+1A   j  ; was: loc_3EE40
                subq.w  #4,$56(a5)
                move.w  (FrameCounter).w,d0
                andi.w  #3,d0
                bne.s   Boss_DeepStriderAdjustDivePrimaryJoint
                addq.w  #1,$56(a5)
Boss_DeepStriderAdjustDivePrimaryJoint:                 ; CODE XREF: Boss_DeepStriderDiveSequence+32   j  ; was: loc_3EE52
                cmpi.w  #$11,$11C(a5)
                bmi.s   Boss_DeepStriderExpandDiveTailJoint
                cmpi.w  #$34,$11C(a5)                   ; '4'
                bpl.s   Boss_DeepStriderRestoreDivePrimaryJoint
                cmpi.w  #$1F4,$1DC(a5)
                beq.s   Boss_DeepStriderExpandDiveTailJoint
                subq.w  #1,$1DC(a5)
                bra.s   Boss_DeepStriderExpandDiveTailJoint
; ---------------------------------------------------------------------------
Boss_DeepStriderRestoreDivePrimaryJoint:                ; CODE XREF: Boss_DeepStriderDiveSequence+46   j  ; was: loc_3EE70
                cmpi.w  #$1FC,$1DC(a5)
                beq.s   Boss_DeepStriderExpandDiveTailJoint
                addq.w  #1,$1DC(a5)
Boss_DeepStriderExpandDiveTailJoint:                    ; CODE XREF: Boss_DeepStriderDiveSequence+3E   j  ; was: loc_3EE7C
                                        ; Boss_DeepStriderDiveSequence+4E   j
                cmpi.w  #$1A,$11C(a5)
                bmi.s   Boss_DeepStriderExpandDiveSecondaryJoint
                cmpi.w  #$1F0,$23E(a5)
                beq.s   Boss_DeepStriderExpandDiveSecondaryJoint
                addq.w  #1,$23E(a5)
Boss_DeepStriderExpandDiveSecondaryJoint:               ; CODE XREF: Boss_DeepStriderDiveSequence+68   j  ; was: loc_3EE90
                                        ; Boss_DeepStriderDiveSequence+70   j
                cmpi.w  #$1F8,$1DE(a5)
                beq.s   Boss_DeepStriderDecelerateDiveHorizontal
                addq.w  #1,$1DE(a5)
Boss_DeepStriderDecelerateDiveHorizontal:               ; CODE XREF: Boss_DeepStriderDiveSequence+7C   j  ; was: loc_3EE9C
                cmpi.w  #$30,$11C(a5)                   ; '0'
                bmi.s   Boss_DeepStriderAdvanceDiveMotion
                tst.w   $4F8(a5)
                bmi.s   Boss_DeepStriderDecelerateNegativeDiveHorizontal
                subi.l  #$3000,$4F8(a5)
                bra.s   Boss_DeepStriderAdvanceDiveMotion
; ---------------------------------------------------------------------------
Boss_DeepStriderDecelerateNegativeDiveHorizontal:       ; CODE XREF: Boss_DeepStriderDiveSequence+8E   j  ; was: loc_3EEB4
                addi.l  #$3000,$4F8(a5)
Boss_DeepStriderAdvanceDiveMotion:                      ; CODE XREF: Boss_DeepStriderDiveSequence+88   j  ; was: loc_3EEBC
                                        ; Boss_DeepStriderDiveSequence+98   j
                bsr.w   Boss_DeepStriderUpdateParts
                addi.l  #$3200,$4FC(a5)
                bmi.w   Boss_DeepStriderMotionStateReturn
                cmpi.w  #$1E0,$14(a5)
                bmi.w   *+4
Boss_DeepStriderMotionStateReturn:                      ; CODE XREF: Boss_DeepStriderIntroDiveState+4   j  ; was: locret_3EED6
                                        ; Boss_DeepStriderDefeatBurstState+A   j
                rts
; End of function Boss_DeepStriderDiveSequence
; Updates boss metasprite parts
Boss_DeepStriderUpdateParts:                            ; CODE XREF: Boss_DeepStriderIntroRise+C8   j  ; was: sub_3EED8
                                        ; Boss_DeepStriderIntroRise+DE   j
                move.w  #$1FF,d0
                and.w   d0,$56(a5)
                and.w   d0,$1DC(a5)
                and.w   d0,$1DE(a5)
                and.w   d0,$23C(a5)
                and.w   d0,$23E(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  $1DC(a5),d0
                moveq   #2,d7
; Updates rotation angles for body parts
Boss_DeepStriderShiftJointAngleHistory:                 ; CODE XREF: Boss_DeepStriderUpdateParts+28   j  ; was: loc_3EEFA
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,Boss_DeepStriderShiftJointAngleHistory
                move.w  $1DC(a5),$B6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  d0,d1
                add.w   d0,d1
                move.w  d1,$116(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  d0,d1
                add.w   d0,d1
                add.w   d0,d1
                move.w  d1,$176(a5)
                move.w  $1DC(a5),d0
                move.w  #$100,d1
                sub.w   d0,d1
                move.w  d1,$1D6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$236(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$296(a5)
                move.w  (dword_FF9404).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$2F6(a5)
                move.w  d1,d2
                addi.w  #$80,d1
                add.w   $23E(a5),d1
                move.w  d1,$356(a5)
                subi.w  #$80,d2
                sub.w   $23E(a5),d2
                move.w  d2,$3B6(a5)
                move.w  $B6(a5),d1
                addi.w  #$80,d1
                add.w   $23C(a5),d1
                move.w  d1,$4D6(a5)
                move.w  $116(a5),d2
                subi.w  #$80,d2
                add.w   $1DE(a5),d2
                move.w  d2,$416(a5)
                move.w  d2,$476(a5)
                moveq   #$C,d7
                jmp     Sprite_UpdateMetaspriteFourFrameRotationAndLoadCount
; End of function Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
Boss_DeepStriderRotationFramesA:    dc.l    Boss_DeepStriderRotationMappingA0  ; DATA XREF: ROM:0003F00C   o  ; was: off_3EFAE
                dc.l    Boss_DeepStriderRotationMappingA1
                dc.l    Boss_DeepStriderRotationMappingA2
                dc.l    Boss_DeepStriderRotationMappingA3
Boss_DeepStriderRotationFramesB:    dc.l    Boss_DeepStriderRotationMappingB0  ; DATA XREF: ROM:0003F004   o  ; was: off_3EFBE
                                        ; ROM:0003F008   o
                dc.l    Boss_DeepStriderRotationMappingB1
                dc.l    Boss_DeepStriderRotationMappingB2
                dc.l    Boss_DeepStriderRotationMappingB3
Boss_DeepStriderRotationFramesC:    dc.l    Boss_DeepStriderRotationMappingC0  ; DATA XREF: ROM:0003F024   o  ; was: off_3EFCE
                                        ; ROM:0003F030   o
                dc.l    Boss_DeepStriderRotationMappingC1
                dc.l    Boss_DeepStriderRotationMappingC2
                dc.l    Boss_DeepStriderRotationMappingC3
Boss_DeepStriderRotationFramesD:    dc.l    Boss_DeepStriderRotationMappingC3  ; DATA XREF: ROM:0003F020   o  ; was: off_3EFDE
                                        ; ROM:0003F02C   o
                dc.l    Boss_DeepStriderRotationMappingC2
                dc.l    Boss_DeepStriderRotationMappingC1
                dc.l    Boss_DeepStriderRotationMappingC0
Boss_DeepStriderInlineSpriteDescriptorA:    dc.w    $6397, $A00, $F4F4  ; DATA XREF: ROM:0003F014   o  ; was: word_3EFEE
                                        ; ROM:0003F028   o
Boss_DeepStriderInlineSpriteDescriptorB:    dc.w    $63A0, $500, $F8F8  ; DATA XREF: ROM:0003F018   o  ; was: word_3EFF4
Boss_DeepStriderInlineSpriteDescriptorC:    dc.w    $63A4, $500, $F8F8  ; DATA XREF: ROM:0003F01C   o  ; was: word_3EFFA
Boss_DeepStriderMetaspriteDescriptors:      dc.l    Boss_DeepStriderRootMapping+$400000  ; DATA XREF: Boss_DeepStriderIntroRise+E   o  ; was: off_3F000
                dc.l    Boss_DeepStriderRotationFramesB
                dc.l    Boss_DeepStriderRotationFramesB
                dc.l    Boss_DeepStriderRotationFramesA
                dc.l    Boss_DeepStriderRootMapping+$400000
                dc.l    Boss_DeepStriderInlineSpriteDescriptorA+1
                dc.l    Boss_DeepStriderInlineSpriteDescriptorB+1
                dc.l    Boss_DeepStriderInlineSpriteDescriptorC+1
                dc.l    Boss_DeepStriderRotationFramesD+$28000000
                dc.l    Boss_DeepStriderRotationFramesC
                dc.l    Boss_DeepStriderInlineSpriteDescriptorA+1
                dc.l    Boss_DeepStriderRotationFramesD+$28000000
                dc.l    Boss_DeepStriderRotationFramesC
                dc.l    0
Boss_DeepStriderPartRadii:  dc.w    $15, $1210, $1410   ; DATA XREF: Boss_DeepStriderIntroRise+14   o  ; was: word_3F038
                dc.w    $C0A, $C0C, $E10
                dc.w    $1418
Boss_DeepStriderPartLinks:  dc.w    $C007, $C006, $C065  ; was: word_3F046
                                        ; DATA XREF: Boss_DeepStriderIntroRise+1A   o
                dc.w    $C0C4, $C007, $C187
                dc.w    $C1E7, $C247, $C2A7
                dc.w    $C2A7, $C0C4, $C3C4
                dc.w    $C067, 7

; Fires angled projectile from Deep Strider boss using sine table
Boss_DeepStriderFireAngleProjectile:                    ; CODE XREF: Boss_DeepStriderBeginBattleCycle+230   p  ; was: sub_3F062
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Boss_DeepStriderFireAngleProjectileReturn
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Boss_DeepStriderFireAngleProjectileReturn
                move.w  #$350,(a0)
                move.w  #$AD80,2(a0)
                move.w  #$4411,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$10,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$50,$26(a0)                    ; 'P'
                move.l  #$FF01FF01,$2C(a0)
                move.w  (RandomNumberState).w,d3
                ext.l   d3
                asl.l   #2,d3
                lea     (Math_SineTable).l,a1
                move.w  $56(a5),d7
                addi.w  #$20,d7                         ; ' '
                andi.w  #$1FE,d7
                move.w  -$80(a1,d7.w),d0
                move.w  (a1,d7.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                clr.l   $18(a0)
                move.w  $134(a5),$14(a0)
                addq.w  #2,$14(a0)
                move.w  $130(a5),$10(a0)
                btst    #3,$12E(a5)
                beq.s   Boss_DeepStriderApplyPositiveProjectileFacing
                subq.w  #4,$10(a0)
                sub.l   d3,$18(a0)
                sub.l   d1,$18(a0)
                rts
; ---------------------------------------------------------------------------
Boss_DeepStriderApplyPositiveProjectileFacing:          ; CODE XREF: Boss_DeepStriderFireAngleProjectile+94   j  ; was: loc_3F106
                addq.w  #4,$10(a0)
                add.l   d3,$18(a0)
                add.l   d1,$18(a0)
Boss_DeepStriderFireAngleProjectileReturn:              ; CODE XREF: Boss_DeepStriderFireAngleProjectile+8   j  ; was: locret_3F112
                                        ; Boss_DeepStriderFireAngleProjectile+12   j
                rts
; End of function Boss_DeepStriderFireAngleProjectile
