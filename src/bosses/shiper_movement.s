; Runs line scroll/screen positioning, vertical bounce and sprite anchors,
; horizontal motion, then motion-phase integration and rotation dispatch
Boss_ShiperUpdateMotionPipeline:                        ; CODE XREF: Boss_ShiperUpdateAttackAndSpawnProjectile   p  ; was: sub_36A1A
                                        ; Boss_ShiperUpdateCombatCounterRefill   p
                bsr.w   Boss_ShiperUpdatePositionAndLineScroll
                bsr.w   Boss_ShiperUpdateBounceAndSpriteAnchors
                bsr.w   Boss_ShiperDispatchHorizontalMotion
                bra.w   Boss_ShiperIntegrateMotionPhaseAndDispatchRotation
; End of function Boss_ShiperUpdateMotionPipeline
; Dispatches field $5C through the five-entry horizontal-motion table
Boss_ShiperDispatchHorizontalMotion:                    ; CODE XREF: Boss_ShiperUpdateMotionPipeline+8   p  ; was: sub_36A2A
                move.w  $5C(a5),d0
                movea.w Boss_ShiperMovementStates(pc,d0.w),a0
                adda.l  #Boss_ShiperHandleBounceDirectionToggle,a0
                jmp     (a0)
; End of function Boss_ShiperDispatchHorizontalMotion
; ---------------------------------------------------------------------------
Boss_ShiperMovementStates:  dc.w    Boss_ShiperHandleBounceDirectionToggle-Boss_ShiperHandleBounceDirectionToggle  ; was: off_36A3A
                                        ; DATA XREF: Boss_ShiperDispatchHorizontalMotion+4   r
                dc.w    Boss_ShiperUpdateHorizontalMotionModeA-Boss_ShiperHandleBounceDirectionToggle
                dc.w    Boss_ShiperUpdateHorizontalMotionModeB-Boss_ShiperHandleBounceDirectionToggle
                dc.w    Boss_ShiperHandleBounceDirectionToggle-Boss_ShiperHandleBounceDirectionToggle
                dc.w    Boss_ShiperMoveHorizontalReturn-Boss_ShiperHandleBounceDirectionToggle

; A bounce event in flag $5E.0 toggles direction bit $5E.1 before mode A/B is selected
Boss_ShiperHandleBounceDirectionToggle:                 ; DATA XREF: Boss_ShiperDispatchHorizontalMotion+8   o  ; was: sub_36A44
                                        ; ROM:Boss_ShiperMovementStates   o
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperToggleDirectionSelectMotion
                eori.b  #2,$5E(a5)
Boss_ShiperToggleDirectionSelectMotion:                 ; CODE XREF: Boss_ShiperHandleBounceDirectionToggle+6   j  ; was: loc_36A52
                btst    #1,$5E(a5)
                bne.s   Boss_ShiperUpdateHorizontalMotionModeB
; End of function Boss_ShiperHandleBounceDirectionToggle
; On a bounce, mode A seeds horizontal motion $4C to +$10000. The high word of
; vertical velocity $54 then selects addition or subtraction of $D000
Boss_ShiperUpdateHorizontalMotionModeA:                 ; DATA XREF: ROM:00036A3C   o  ; was: sub_36A5A
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperMoveHorizontalAApplyAcceleration
                move.l  #$10000,$4C(a5)
Boss_ShiperMoveHorizontalAApplyAcceleration:            ; CODE XREF: Boss_ShiperUpdateHorizontalMotionModeA+6   j  ; was: loc_36A6A
                tst.w   $54(a5)
                bmi.s   Boss_ShiperMoveHorizontalAReverseAcceleration
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShiperMoveHorizontalAReverseAcceleration:          ; CODE XREF: Boss_ShiperUpdateHorizontalMotionModeA+14   j  ; was: loc_36A7A
                subi.l  #$D000,$4C(a5)
                rts
; End of function Boss_ShiperUpdateHorizontalMotionModeA
; On a bounce, mode B seeds horizontal motion $4C to -$10000. The high word of
; vertical velocity $54 selects the complementary $D000 acceleration sign
Boss_ShiperUpdateHorizontalMotionModeB:                 ; CODE XREF: Boss_ShiperHandleBounceDirectionToggle+14   j  ; was: sub_36A84
                                        ; DATA XREF: ROM:00036A3E   o
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperMoveHorizontalBApplyAcceleration
                move.l  #$FFFF0000,$4C(a5)
Boss_ShiperMoveHorizontalBApplyAcceleration:            ; CODE XREF: Boss_ShiperUpdateHorizontalMotionModeB+6   j  ; was: loc_36A94
                tst.w   $54(a5)
                bpl.s   Boss_ShiperMoveHorizontalBReverseAcceleration
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShiperMoveHorizontalBReverseAcceleration:          ; CODE XREF: Boss_ShiperUpdateHorizontalMotionModeB+14   j  ; was: loc_36AA4
                subi.l  #$D000,$4C(a5)
; Return from Shiper horizontal movement
Boss_ShiperMoveHorizontalReturn:                        ; DATA XREF: ROM:00036A42   o  ; was: locret_36AAC
                rts
; End of function Boss_ShiperUpdateHorizontalMotionModeB
; Integrates derivative $178 into motion phase $16C, clamps negative phase to
; zero, then dispatches rotation state field $174
Boss_ShiperIntegrateMotionPhaseAndDispatchRotation:     ; CODE XREF: Boss_ShiperUpdateMotionPipeline+C   j  ; was: sub_36AAE
                move.l  $178(a5),d0
                add.l   d0,$16C(a5)
                tst.w   $16C(a5)
                bpl.s   Boss_ShiperPhysicsDispatchRotation
                clr.l   $16C(a5)
Boss_ShiperPhysicsDispatchRotation:                     ; CODE XREF: Boss_ShiperIntegrateMotionPhaseAndDispatchRotation+C   j  ; was: loc_36AC0
                move.w  $174(a5),d0
                movea.w Boss_ShiperRotationStates(pc,d0.w),a0
                adda.l  #Boss_ShiperInitializeRotationOscillation,a0
                jmp     (a0)
; End of function Boss_ShiperIntegrateMotionPhaseAndDispatchRotation
; ---------------------------------------------------------------------------
Boss_ShiperRotationStates:  dc.w    Boss_ShiperInitializeRotationOscillation-Boss_ShiperInitializeRotationOscillation  ; was: off_36AD0
                                        ; DATA XREF: Boss_ShiperIntegrateMotionPhaseAndDispatchRotation+16   r
                dc.w    Boss_ShiperRotationState0-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperBeginRotationAccelerationPhase-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperRotationState1-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperUpdateRotationMotionCycle-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperBeginFastRotationOscillation-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperRotationState2-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperUpdateSpinShotCycle-Boss_ShiperInitializeRotationOscillation
                dc.w    Boss_ShiperSpinAttackActive-Boss_ShiperInitializeRotationOscillation

; Advances the rotation state, clears derivative/direction/timer state, and
; falls through to the bounded random-delay angle oscillator
Boss_ShiperInitializeRotationOscillation:               ; CODE XREF: Boss_ShiperUpdateSpinShotCycle+60   j  ; was: sub_36AE2
                                        ; DATA XREF: Boss_ShiperIntegrateMotionPhaseAndDispatchRotation+1A   o
                addq.w  #2,$174(a5)
                clr.l   $178(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Initial rotation state with acceleration
Boss_ShiperRotationState0:                              ; DATA XREF: ROM:00036AD2   o  ; was: loc_36AF2
                addi.l  #$3800,$178(a5)
                cmpi.w  #$C,$16C(a5)
                bmi.s   Boss_ShiperRotationInitUpdateAngle
                move.l  #$FFFE4000,$178(a5)
Boss_ShiperRotationInitUpdateAngle:                     ; CODE XREF: Boss_ShiperInitializeRotationOscillation+1E   j  ; was: loc_36B0A
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (RandomNumberState).w,d4
                andi.w  #$1F,d4
                move.w  (RandomNumberState).w,d0
                andi.w  #1,d0
                addq.w  #4,d0
Boss_ShiperUpdateOscillatingRotation:                   ; CODE XREF: Boss_ShiperBeginFastRotationOscillation+3E   j  ; was: loc_36B24
                move.w  $170(a5),d1
                move.w  #$3FF,d2
                tst.w   $17C(a5)
                bne.s   Boss_ShiperUpdateOscillatingRotationDecrease
                add.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bpl.s   Boss_ShiperUpdateOscillatingRotationStore
                cmpi.w  #$20,d1                         ; ' '
                bmi.s   Boss_ShiperUpdateOscillatingRotationStore
                move.w  d3,d3
                bpl.s   Boss_ShiperUpdateOscillatingRotationStore
                addq.w  #1,$17C(a5)
                move.w  d4,$17E(a5)
                bra.s   Boss_ShiperUpdateOscillatingRotationStore
; ---------------------------------------------------------------------------
Boss_ShiperUpdateOscillatingRotationDecrease:           ; CODE XREF: Boss_ShiperInitializeRotationOscillation+4E   j  ; was: loc_36B50
                sub.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bmi.s   Boss_ShiperUpdateOscillatingRotationStore
                cmpi.w  #$3FF,d1
                bpl.s   Boss_ShiperUpdateOscillatingRotationStore
                clr.w   $17C(a5)
                move.w  d4,$17E(a5)
Boss_ShiperUpdateOscillatingRotationStore:              ; CODE XREF: Boss_ShiperInitializeRotationOscillation+58   j  ; was: loc_36B68
                                        ; Boss_ShiperInitializeRotationOscillation+5E   j
                move.w  d1,$170(a5)
                rts
; End of function Boss_ShiperInitializeRotationOscillation
; Advances into the acceleration phase. The following state adds $4000 to the
; derivative, steps the angle by eight, and caps motion phase $16C at $40
Boss_ShiperBeginRotationAccelerationPhase:              ; DATA XREF: ROM:00036AD4   o  ; was: sub_36B6E
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Rotation state 1 with velocity limit check
Boss_ShiperRotationState1:                              ; DATA XREF: ROM:00036AD6   o  ; was: loc_36B7A
                addi.l  #$4000,$178(a5)
                moveq   #8,d0
                move.w  $170(a5),d1
                beq.s   Boss_ShiperRotationAccelCheckMotionLimit
                cmpi.w  #$1FF,d1
                bpl.s   Boss_ShiperRotationAccelApplyStep
                moveq   #$FFFFFFF8,d0
Boss_ShiperRotationAccelApplyStep:                      ; CODE XREF: Boss_ShiperBeginRotationAccelerationPhase+20   j  ; was: loc_36B92
                add.w   d0,d1
                andi.w  #$3F8,d1
                move.w  d1,$170(a5)
Boss_ShiperRotationAccelCheckMotionLimit:               ; CODE XREF: Boss_ShiperBeginRotationAccelerationPhase+1A   j  ; was: loc_36B9C
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   Boss_ShiperRotationAccelReturn
                move.w  #$40,$16C(a5)                   ; '@'
                addq.w  #2,$174(a5)
Boss_ShiperRotationAccelReturn:                         ; CODE XREF: Boss_ShiperBeginRotationAccelerationPhase+34   j  ; was: locret_36BAE
                rts
; End of function Boss_ShiperBeginRotationAccelerationPhase
; Applies sign- and timer-sensitive four-unit angle steps while accelerating
; the derivative. Reaching phase $40 resets angle, timer, and derivative
Boss_ShiperUpdateRotationMotionCycle:                   ; DATA XREF: ROM:00036AD8   o  ; was: sub_36BB0
                moveq   #4,d3
                move.w  $17E(a5),d2
                subq.w  #1,d2
                move.w  $170(a5),d1
                move.l  $178(a5),d0
                bpl.s   Boss_ShiperRotationLogicDecreaseAngle
                cmpi.w  #$7A,d2                         ; 'z'
                bpl.s   Boss_ShiperRotationLogicUpdateMotion
                add.w   d3,d1
                bra.s   Boss_ShiperRotationLogicUpdateMotion
; ---------------------------------------------------------------------------
Boss_ShiperRotationLogicDecreaseAngle:                  ; CODE XREF: Boss_ShiperUpdateRotationMotionCycle+10   j  ; was: loc_36BCC
                sub.w   d3,d1
                cmpi.w  #$52,d2                         ; 'R'
                bpl.s   Boss_ShiperRotationLogicUpdateMotion
                add.w   d3,d1
Boss_ShiperRotationLogicUpdateMotion:                   ; CODE XREF: Boss_ShiperUpdateRotationMotionCycle+16   j  ; was: loc_36BD6
                                        ; Boss_ShiperUpdateRotationMotionCycle+1A   j
                addi.l  #$3800,d0
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   Boss_ShiperRotationLogicStore
                move.w  #$40,$16C(a5)                   ; '@'
                move.l  #$FFFA8000,d0
                moveq   #0,d1
                move.w  #$80,d2
                eori.w  #1,$17C(a5)
Boss_ShiperRotationLogicStore:                          ; CODE XREF: Boss_ShiperUpdateRotationMotionCycle+32   j  ; was: loc_36BFC
                move.l  d0,$178(a5)
                move.w  d1,$170(a5)
                move.w  d2,$17E(a5)
                rts
; End of function Boss_ShiperUpdateRotationMotionCycle
; Advances into the faster oscillator phase. It accelerates by $6000 until
; phase $10, reverses with derivative $FFFCC000, and uses random 8-11 angle steps
Boss_ShiperBeginFastRotationOscillation:                ; DATA XREF: ROM:00036ADA   o  ; was: sub_36C0A
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Faster rotation acceleration state
Boss_ShiperRotationState2:                              ; DATA XREF: ROM:00036ADC   o  ; was: loc_36C16
                addi.l  #$6000,$178(a5)
                cmpi.w  #$10,$16C(a5)
                bmi.s   Boss_ShiperRotationAccelAltUpdateAngle
                move.l  #$FFFCC000,$178(a5)
Boss_ShiperRotationAccelAltUpdateAngle:                 ; CODE XREF: Boss_ShiperBeginFastRotationOscillation+1A   j  ; was: loc_36C2E
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (RandomNumberState).w,d4
                andi.w  #7,d4
                move.w  (RandomNumberState).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                bra.w   Boss_ShiperUpdateOscillatingRotation
; End of function Boss_ShiperBeginFastRotationOscillation
; Starts the spin-shot cycle. Forward rotation targets angle $110; reverse
; rotation targets $3A0 before shaking Plane A, firing, and resetting rotation
Boss_ShiperUpdateSpinShotCycle:                         ; DATA XREF: ROM:00036ADE   o  ; was: sub_36C4C
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
; Spin attack execution with deceleration
Boss_ShiperSpinAttackActive:                            ; DATA XREF: ROM:00036AE0   o  ; was: loc_36C54
                subi.l  #$3000,$178(a5)
                tst.w   $17C(a5)
                bne.s   Boss_ShiperSpinAttackReverseRotation
                addq.w  #4,$170(a5)
                andi.w  #$3FC,$170(a5)
                cmpi.w  #$110,$170(a5)
                bne.s   Boss_ShiperSpinAttackReturn
                addq.w  #1,$17C(a5)
Boss_ShiperSpinAttackReturn:                            ; CODE XREF: Boss_ShiperUpdateSpinShotCycle+26   j  ; was: locret_36C78
                                        ; Boss_ShiperUpdateSpinShotCycle+40   j
                rts
; ---------------------------------------------------------------------------
Boss_ShiperSpinAttackReverseRotation:                   ; CODE XREF: Boss_ShiperUpdateSpinShotCycle+14   j  ; was: loc_36C7A
                subi.w  #$10,$170(a5)
                andi.w  #$3F0,$170(a5)
                cmpi.w  #$3A0,$170(a5)
                bne.s   Boss_ShiperSpinAttackReturn
                move.w  #8,(PlaneAShakeLevel).w
                move.b  #$A1,d0
                jsr     (Sound_QueueSFXRequest).l
                bsr.w   Boss_ShiperSpawnCircleShot
                subi.w  #$12C,(BossCombatCounter).w
                clr.w   $174(a5)
                bra.w   Boss_ShiperInitializeRotationOscillation
; End of function Boss_ShiperUpdateSpinShotCycle
; Positions the sixteenth record from the second, integrates the vertical
; bounce, and derives the jittered and bobbing auxiliary sprite anchors
Boss_ShiperUpdateBounceAndSpriteAnchors:                ; CODE XREF: Boss_ShiperUpdateMotionPipeline+4   p  ; was: sub_36CB0
                movea.w #(SixteenthEntityType-M68K_RAM),a0
                movea.w #(SecondaryEntityType-M68K_RAM),a1
                move.w  $10(a1),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$10(a0)
                move.w  $14(a1),d0
                addi.w  #-$28,d0
                move.w  d0,$14(a0)
                move.l  #$1400,d2
                move.l  #$FFFE8000,d3
                move.l  #$FFFE0000,d4
                cmpi.w  #6,$5C(a5)
                bne.s   Boss_ShiperPositionUpdateIntegrateVerticalMotion
                move.l  #$C000,d2
                move.l  #$FFFB8000,d3
                move.l  #$FFFE4000,d4
Boss_ShiperPositionUpdateIntegrateVerticalMotion:       ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+38   j  ; was: loc_36CFC
                bclr    #0,$5E(a5)
                move.l  $54(a5),d0
                add.l   d2,d0
                move.l  $50(a5),d1
                bmi.s   Boss_ShiperPositionUpdateStoreVerticalMotion
                move.l  d3,d0
                moveq   #0,d1
                move.l  d4,$7C(a5)
                bset    #0,$5E(a5)
                movem.l d0,-(sp)
                move.b  #$B9,d0
                jsr     (Sound_QueueSFXRequest).l
                movem.l (sp)+,d0
Boss_ShiperPositionUpdateStoreVerticalMotion:           ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+5C   j  ; was: loc_36D2E
                add.l   d0,d1
                move.l  d0,$54(a5)
                move.l  d1,$50(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-5,d0
                addi.w  #-$33,d1
                move.b  (RandomNumberState).w,d2
                andi.w  #3,d2
                add.w   d2,d0
                btst    #4,(FrameCounter+1).w
                bne.s   Boss_ShiperPositionUpdateStorePrimaryJitter
                addq.w  #1,d1
Boss_ShiperPositionUpdateStorePrimaryJitter:            ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+A8   j  ; was: loc_36D5C
                move.w  d0,$D0(a5)
                move.w  d1,$D4(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-$D,d0
                addi.w  #-$27,d1
                move.w  d1,d7
                btst    #2,(FrameCounter+1).w
                bne.s   Boss_ShiperPositionUpdateStoreSecondaryX
                addq.w  #1,d1
Boss_ShiperPositionUpdateStoreSecondaryX:               ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+CC   j  ; was: loc_36D80
                move.w  d0,$190(a5)
                btst    #3,(FrameCounter+1).w
                beq.s   Boss_ShiperPositionUpdateStoreSecondaryPosition
                addq.w  #2,d0
Boss_ShiperPositionUpdateStoreSecondaryPosition:        ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+DA   j  ; was: loc_36D8E
                move.w  d0,$130(a5)
                move.w  d1,$194(a5)
                move.b  (RandomNumberState).w,d0
                andi.w  #3,d0
                move.w  $16A(a5),d1
                tst.w   $168(a5)
                bne.s   Boss_ShiperPositionUpdateIncreaseBobbingOffset
                sub.w   d0,d1
                bpl.s   Boss_ShiperPositionUpdateStoreBobbingOffset
                clr.w   d1
                addq.w  #1,$168(a5)
                bra.s   Boss_ShiperPositionUpdateStoreBobbingOffset
; ---------------------------------------------------------------------------
Boss_ShiperPositionUpdateIncreaseBobbingOffset:         ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+F6   j  ; was: loc_36DB4
                add.w   d0,d1
                cmpi.w  #4,d1
                bmi.s   Boss_ShiperPositionUpdateStoreBobbingOffset
                move.w  #4,d1
                clr.w   $168(a5)
Boss_ShiperPositionUpdateStoreBobbingOffset:            ; CODE XREF: Boss_ShiperUpdateBounceAndSpriteAnchors+FA   j  ; was: loc_36DC4
                                        ; Boss_ShiperUpdateBounceAndSpriteAnchors+102   j
                move.w  d1,$16A(a5)
                add.w   d7,d1
                addq.w  #4,d1
                move.w  d1,$134(a5)
; End of function Boss_ShiperUpdateBounceAndSpriteAnchors
; Updates two bounded swing angles and their direction frames, derives both
; endpoints, shifts five rotation-history words, then positions five chain parts
Boss_ShiperUpdateTentaclesAndChainParts:                ; CODE XREF: Boss_ShiperInitializeEncounterEntities+13C   p  ; was: sub_36DD0
                move.b  (RandomNumberState).w,d0
                andi.w  #$F,d0
                addq.w  #1,d0
                move.w  #$1FE,d1
                move.w  $228(a5),d2
                btst    #0,$22C(a5)
                bne.s   Boss_ShiperTentacleDecreaseFirstSwing
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   Boss_ShiperTentacleStoreFirstAngle
Boss_ShiperTentacleReverseFirstSwing:                   ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+34   j  ; was: loc_36DF4
                eori.b  #1,$22C(a5)
                bra.s   Boss_ShiperTentacleStoreFirstAngle
; ---------------------------------------------------------------------------
Boss_ShiperTentacleDecreaseFirstSwing:                  ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+18   j  ; was: loc_36DFC
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$60,d2                         ; '`'
                bmi.s   Boss_ShiperTentacleReverseFirstSwing
Boss_ShiperTentacleStoreFirstAngle:                     ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+22   j  ; was: loc_36E06
                                        ; Boss_ShiperUpdateTentaclesAndChainParts+2A   j
                move.w  d2,$228(a5)
                move.b  (RandomNumberState+1).w,d0
                andi.w  #$F,d0
                addq.w  #3,d0
                move.w  $22A(a5),d2
                btst    #1,$22C(a5)
                bne.s   Boss_ShiperTentacleDecreaseSecondSwing
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$1A8,d2
                bmi.s   Boss_ShiperTentacleStoreSecondAngle
Boss_ShiperTentacleReverseSecondSwing:                  ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+6A   j  ; was: loc_36E2A
                eori.b  #2,$22C(a5)
                bra.s   Boss_ShiperTentacleStoreSecondAngle
; ---------------------------------------------------------------------------
Boss_ShiperTentacleDecreaseSecondSwing:                 ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+4E   j  ; was: loc_36E32
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   Boss_ShiperTentacleReverseSecondSwing
Boss_ShiperTentacleStoreSecondAngle:                    ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+58   j  ; was: loc_36E3C
                                        ; Boss_ShiperUpdateTentaclesAndChainParts+60   j
                move.w  d2,$22A(a5)
                movea.l #Math_SineTable,a0
                movea.l #Boss_ShiperTentacleDirectionFrames,a1
                move.w  #$D300,$1EE(a5)
                move.w  #$D300,$2AE(a5)
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addq.w  #5,d0
                addi.w  #-$20,d1
                swap    d0
                swap    d1
                move.w  $228(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   Boss_ShiperTentacleSelectFirstFrame
                move.w  #$CB00,$1EE(a5)
Boss_ShiperTentacleSelectFirstFrame:                    ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+BA   j  ; was: loc_36E92
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$1E8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d5
                move.l  d4,d6
                asl.l   #1,d5
                asl.l   #1,d6
                add.l   d1,d3
                add.l   d0,d4
                add.l   d1,d5
                add.l   d0,d6
                move.l  d3,$1F4(a5)
                move.l  d4,$1F0(a5)
                move.l  d5,$254(a5)
                move.l  d6,$250(a5)
                move.w  $22A(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   Boss_ShiperTentacleSelectSecondFrame
                move.w  #$CB00,$2AE(a5)
Boss_ShiperTentacleSelectSecondFrame:                   ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+112   j  ; was: loc_36EEA
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$2A8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d0
                move.l  d4,d1
                asl.l   #1,d0
                asl.l   #1,d1
                add.l   d5,d3
                add.l   d6,d4
                add.l   d5,d0
                add.l   d6,d1
                move.l  d3,$2B4(a5)
                move.l  d4,$2B0(a5)
                move.l  d0,$314(a5)
                move.l  d1,$310(a5)
                movea.w #(ShiperRotationHistory-M68K_RAM),a0
                move.w  $170(a5),d0
                moveq   #4,d7
Boss_ShiperTentacleShiftRotationHistory:                ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+15E   j  ; was: loc_36F28
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,Boss_ShiperTentacleShiftRotationHistory
                movea.w #(TenthEntityType-M68K_RAM),a0
                move.l  $70(a5),d0
                move.l  $74(a5),d1
                swap    d0
                swap    d1
                addi.w  #-$2C,d0
                addi.w  #-$14,d1
                swap    d0
                swap    d1
                add.l   $16C(a5),d0
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(EleventhEntityType-M68K_RAM),a1
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a2
                movea.w #(ShiperCosineTable-M68K_RAM),a3
                movea.w #(ShiperRotationHistory-M68K_RAM),a4
                move.w  #$200,d3
                moveq   #$B,d0
                moveq   #1,d5
                move.w  #$3FC,d6
                moveq   #4,d7
Boss_ShiperTentaclePositionNextChainPart:               ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+1F8   j  ; was: loc_36F78
                move.w  (a4),d4
                muls.w  d5,d4
                add.w   d3,d4
                and.w   d6,d4
                move.l  (a2,d4.w),d1
                move.l  (a3,d4.w),d2
                add.l   $14(a0),d1
                add.l   $10(a0),d2
                move.l  d1,$14(a1)
                move.l  d2,$10(a1)
                cmpi.w  #$144,$14(a1)
                bmi.s   Boss_ShiperTentaclePositionSetChainFlip
                move.w  #$144,$14(a1)
Boss_ShiperTentaclePositionSetChainFlip:                ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+1CE   j  ; was: loc_36FA6
                bset    #7,$E(a1)
                cmp.w   $16C(a5),d0
                bpl.s   Boss_ShiperTentaclePositionAdvanceChainPart
                bclr    #7,$E(a1)
Boss_ShiperTentaclePositionAdvanceChainPart:            ; CODE XREF: Boss_ShiperUpdateTentaclesAndChainParts+1E0   j  ; was: loc_36FB8
                movea.w a1,a0
                lea     $60(a1),a1
                lea     2(a4),a4
                addi.w  #$10,d0
                addq.w  #1,d5
                dbf     d7,Boss_ShiperTentaclePositionNextChainPart
                rts
; End of function Boss_ShiperUpdateTentaclesAndChainParts
; ---------------------------------------------------------------------------
Boss_ShiperTentacleDirectionFrames: dc.l    Boss_ShiperTentacleSpriteMapping04  ; DATA XREF: Boss_ShiperUpdateTentaclesAndChainParts+76   o  ; was: off_36FCE
                dc.l    Boss_ShiperTentacleSpriteMapping03
                dc.l    Boss_ShiperTentacleSpriteMapping02
                dc.l    Boss_ShiperTentacleSpriteMapping01
                dc.l    Boss_ShiperTentacleSpriteMapping00
                dc.l    Boss_ShiperTentacleSpriteMapping07
                dc.l    Boss_ShiperTentacleSpriteMapping06
                dc.l    Boss_ShiperTentacleSpriteMapping05
