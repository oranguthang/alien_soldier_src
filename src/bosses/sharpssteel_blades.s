; Sharpssteel complex-phase states, blade collision/graphics, and pose commands

Boss_SharpssteelWaitForComplexAlignmentState:           ; DATA XREF: ROM:00047C88   o  ; was: sub_484E4
                move.w  $314(a5),d0
                sub.w   (Entity57YPos).w,d0
                cmpi.w  #$38,d0                         ; '8'
                bmi.s   Boss_SharpssteelInitializeComplexAcceleration
                bsr.w   Boss_SharpssteelUpdateBladeAnglesFromPose
                bra.w   Boss_SharpssteelUpdateBladePresentation
; ---------------------------------------------------------------------------
Boss_SharpssteelInitializeComplexAcceleration:          ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+C   j
                addq.w  #2,4(a5)
                move.w  #8,(PlaneAShakeLevel).w
                move.w  #2,(PlaneBShakeLevel).w
                bset    #0,(Entity57Work5A).w
                clr.l   (Entity57YVel).w
                move.l  #$8000,(Entity57XVel).w
                move.l  #$A000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Boss_SharpssteelAccelerateComplexMotionState
                neg.l   $18(a5)
                neg.l   (Entity57XVel).w
; Advances the complex-phase motion until the blade animation trigger fires
Boss_SharpssteelAccelerateComplexMotionState:           ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+46   j  ; was: loc_48534
                                        ; DATA XREF: ROM:00047C8A   o
                addi.l  #$1200,$1C(a5)
                btst    #0,$23E(a5)
                bne.s   Boss_SharpssteelBeginComplexOscillation
                move.w  $314(a5),d0
                subi.w  #$30,d0                         ; '0'
                move.w  d0,(Entity57YPos).w
                lea     Boss_SharpssteelComplexOscillationPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginComplexOscillation:                ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+5E   j
                addq.w  #2,4(a5)
                bset    #1,(Entity57Work5A).w
                clr.w   $11E(a5)
                addi.l  #$A000,$1C(a5)
                move.l  #$15000,d0
                tst.w   $18(a5)
                bpl.s   Boss_SharpssteelApplyComplexHorizontalVelocity
                neg.l   d0
Boss_SharpssteelApplyComplexHorizontalVelocity:         ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+96   j
                move.l  d0,$18(a5)
; Oscillates vertically until the blade pose supplies its completion trigger
Boss_SharpssteelComplexOscillationState:                ; DATA XREF: ROM:00047C8C   o  ; was: loc_48582
                tst.w   $58(a5)
                bmi.s   Boss_SharpssteelBeginBladeShotBurst
                bsr.w   Boss_SharpssteelUpdateVerticalOscillation
                lea     Boss_SharpssteelComplexOscillationPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginBladeShotBurst:                    ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+A2   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $23E(a5)
                move.w  #3,$11C(a5)
; Emits three triggered bursts while steering toward the shared X target
Boss_SharpssteelBladeShotBurstState:                    ; DATA XREF: ROM:00047C8E   o  ; was: loc_485AE
                btst    #1,$23E(a5)
                beq.s   Boss_SharpssteelCheckBladeShotBurstRepeat
                bsr.w   Boss_SharpssteelSpawnSixBladeShots
Boss_SharpssteelCheckBladeShotBurstRepeat:              ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+D0   j
                btst    #0,$23E(a5)
                beq.s   Boss_SharpssteelUpdateBladeShotBurstMotion
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                subq.w  #1,$11C(a5)
                bmi.s   Boss_SharpssteelFinishBladeShotBurst
Boss_SharpssteelUpdateBladeShotBurstMotion:             ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+DC   j
                bsr.w   Boss_SharpssteelSteerTowardSharedHorizontalTarget
                bsr.w   Boss_SharpssteelUpdateVerticalOscillation
                lea     Boss_SharpssteelComplexExitPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; ---------------------------------------------------------------------------
Boss_SharpssteelFinishBladeShotBurst:                   ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+EC   j
                addq.w  #2,4(a5)
; Falls to the lower bound before returning to the post-dive cycle selector
Boss_SharpssteelComplexExitFallState:                   ; DATA XREF: ROM:00047C90   o  ; was: loc_485E8
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$200,$14(a5)
                bpl.w   Boss_SharpssteelSelectPostDiveCycle
                lea     Boss_SharpssteelComplexExitPoseCommands(pc),a1
                nop
                bra.w   Boss_SharpssteelUpdateBladeAssembly
; End of function Boss_SharpssteelWaitForComplexAlignmentState
; Alternates vertical acceleration between the Y $170/$172 bounds
Boss_SharpssteelUpdateVerticalOscillation:              ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+A4   p  ; was: sub_48604
                                        ; Boss_SharpssteelWaitForComplexAlignmentState+F2   p
                tst.w   $11E(a5)
                bne.s   Boss_SharpssteelUpdateDownwardOscillation
                move.l  $1C(a5),d0
                bpl.s   Boss_SharpssteelAccelerateOscillationUpward
                cmpi.w  #$170,$14(a5)
                bmi.s   Boss_SharpssteelReverseVerticalOscillation
                cmpi.l  #$FFFE8000,d0
                bmi.s   Boss_SharpssteelUpdateVerticalOscillationReturn
Boss_SharpssteelAccelerateOscillationUpward:            ; CODE XREF: Boss_SharpssteelUpdateVerticalOscillation+A   j
                subi.l  #$E00,$1C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelUpdateDownwardOscillation:              ; CODE XREF: Boss_SharpssteelUpdateVerticalOscillation+4   j
                move.l  $1C(a5),d0
                bmi.s   Boss_SharpssteelAccelerateOscillationDownward
                cmpi.w  #$172,$14(a5)
                bpl.s   Boss_SharpssteelReverseVerticalOscillation
                cmpi.l  #$18000,d0
                bpl.s   Boss_SharpssteelUpdateVerticalOscillationReturn
Boss_SharpssteelAccelerateOscillationDownward:          ; CODE XREF: Boss_SharpssteelUpdateVerticalOscillation+2A   j
                addi.l  #$E00,$1C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelReverseVerticalOscillation:             ; CODE XREF: Boss_SharpssteelUpdateVerticalOscillation+12   j
                                        ; Boss_SharpssteelUpdateVerticalOscillation+32   j
                eori.w  #2,$11E(a5)
Boss_SharpssteelUpdateVerticalOscillationReturn:        ; CODE XREF: Boss_SharpssteelUpdateVerticalOscillation+1A   j
                                        ; Boss_SharpssteelUpdateVerticalOscillation+3A   j
                rts
; End of function Boss_SharpssteelUpdateVerticalOscillation
; Accelerates horizontal velocity toward the shared target, with speed limits
Boss_SharpssteelSteerTowardSharedHorizontalTarget:      ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState:Boss_SharpssteelUpdateBladeShotBurstMotion   p  ; was: sub_48652
                move.w  (PlayerCenterX).w,d0
                sub.w   $10(a5),d0
                bpl.s   Boss_SharpssteelHandleRightTarget
                move.l  $18(a5),d0
                bpl.s   Boss_SharpssteelAccelerateTowardLeftTarget
                cmpi.l  #$FFFD8000,$18(a5)
                bmi.s   Boss_SharpssteelHorizontalSteeringReturn
Boss_SharpssteelAccelerateTowardLeftTarget:             ; CODE XREF: Boss_SharpssteelSteerTowardSharedHorizontalTarget+E   j
                subi.l  #$3000,$18(a5)
Boss_SharpssteelHorizontalSteeringReturn:               ; CODE XREF: Boss_SharpssteelSteerTowardSharedHorizontalTarget+18   j
                                        ; Boss_SharpssteelSteerTowardSharedHorizontalTarget+32   j
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelHandleRightTarget:                      ; CODE XREF: Boss_SharpssteelSteerTowardSharedHorizontalTarget+8   j
                move.l  $18(a5),d0
                bmi.s   Boss_SharpssteelAccelerateTowardRightTarget
                cmpi.l  #$28000,$18(a5)
                bpl.s   Boss_SharpssteelHorizontalSteeringReturn
Boss_SharpssteelAccelerateTowardRightTarget:            ; CODE XREF: Boss_SharpssteelSteerTowardSharedHorizontalTarget+28   j
                addi.l  #$3000,$18(a5)
                rts
; End of function Boss_SharpssteelSteerTowardSharedHorizontalTarget
; Runs blade pose commands, palette updates, core frames, and part rendering
Boss_SharpssteelUpdateBladeAssembly:                    ; CODE XREF: Boss_SharpssteelRunBladeEntranceDelayState+A   j  ; was: sub_48690
                                        ; Boss_SharpssteelWaitForPlayerAfterBladeEntranceState+A   j
                bsr.w   Boss_SharpssteelRunBladePoseCommands
Boss_SharpssteelUpdateBladePresentation:                ; CODE XREF: Boss_SharpssteelManualControlState+40   j
                                        ; Boss_SharpssteelWaitForComplexAlignmentState+12   j
                bsr.w   Boss_SharpssteelUpdateBackgroundPaletteFade
                bsr.w   Boss_SharpssteelUpdateCoreSpriteFrames
                moveq   #$11,d7
                jmp     Sprite_BeginMetaspritePartTraversal
; End of function Boss_SharpssteelUpdateBladeAssembly
; Clears the sprite-priority bit on all 18 embedded blade parts
Boss_SharpssteelClearBladePartPriorityBits:             ; CODE XREF: Boss_SharpssteelInitializeFallingShotCycle+4E   p  ; was: sub_486A4
                                        ; Boss_SharpssteelInitializeAttackSelection+82   p
                movea.w a5,a0
                moveq   #7,d0
                moveq   #$11,d7
Boss_SharpssteelClearBladePartPriorityBitsLoop:         ; CODE XREF: Boss_SharpssteelClearBladePartPriorityBits+E   j
                bclr    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_SharpssteelClearBladePartPriorityBitsLoop
                rts
; End of function Boss_SharpssteelClearBladePartPriorityBits
; Sets the sprite-priority bit on all 18 embedded blade parts
Boss_SharpssteelSetBladePartPriorityBits:               ; CODE XREF: Boss_SharpssteelInitializeBladeEntrance+4A   p  ; was: sub_486B8
                                        ; Boss_SharpssteelOpeningVerticalTurnState+2C   p
                movea.w a5,a0
                moveq   #7,d0
                moveq   #$11,d7
Boss_SharpssteelSetBladePartPriorityBitsLoop:           ; CODE XREF: Boss_SharpssteelSetBladePartPriorityBits+E   j
                bset    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_SharpssteelSetBladePartPriorityBitsLoop
                rts
; End of function Boss_SharpssteelSetBladePartPriorityBits
; Clears sprite priority on blade-part group A
Boss_SharpssteelClearBladeGroupAPriorityBits:           ; CODE XREF: Boss_SharpssteelInitializeDiveAttack+46   p  ; was: sub_486CC
                bclr    #7,$24E(a5)
                bclr    #7,$2AE(a5)
                bclr    #7,$30E(a5)
                bclr    #7,$36E(a5)
                rts
; End of function Boss_SharpssteelClearBladeGroupAPriorityBits
; Sets sprite priority on blade-part group A
Boss_SharpssteelSetBladeGroupAPriorityBits:             ; CODE XREF: Boss_SharpssteelAccelerateBladeAssemblyState+5E   p  ; was: sub_486E6
                                        ; Boss_SharpssteelFarRangeBladeAttackState+10   p
                bset    #7,$24E(a5)
                bset    #7,$2AE(a5)
                bset    #7,$30E(a5)
                bset    #7,$36E(a5)
                rts
; End of function Boss_SharpssteelSetBladeGroupAPriorityBits
; Clears sprite priority on blade-part group B
Boss_SharpssteelClearBladeGroupBPriorityBits:           ; CODE XREF: Boss_SharpssteelInitializeDiveAttack+4A   p  ; was: sub_48700
                bclr    #7,$3CE(a5)
                bclr    #7,$42E(a5)
                bclr    #7,$48E(a5)
                bclr    #7,$4EE(a5)
                rts
; End of function Boss_SharpssteelClearBladeGroupBPriorityBits
; Sets sprite priority on blade-part group B
Boss_SharpssteelSetBladeGroupBPriorityBits:             ; CODE XREF: Boss_SharpssteelAccelerateBladeAssemblyState+5A   p  ; was: sub_4871A
                bset    #7,$3CE(a5)
                bset    #7,$42E(a5)
                bset    #7,$48E(a5)
                bset    #7,$4EE(a5)
                rts
; End of function Boss_SharpssteelSetBladeGroupBPriorityBits
; Enables collision and writes the collision value for the outer blade group
Boss_SharpssteelEnableOuterBladeHitboxes:
                bset    #6,$5C1(a5)                     ; was: sub_48734
                bset    #6,$681(a5)
                move.w  d1,$5C6(a5)
                move.w  d1,$686(a5)
                movea.w #(EleventhEntityType-M68K_RAM),a0
                bra.s   Boss_SharpssteelEnableLinkedBladeHitboxes
; End of function Boss_SharpssteelEnableOuterBladeHitboxes
; Enables collision and writes the collision value for the inner blade group
Boss_SharpssteelEnableInnerBladeHitboxes:               ; CODE XREF: Boss_SharpssteelFarRangeBladeAttackState+18   p  ; was: sub_4874E
                                        ; Boss_SharpssteelCloseRangeBladeAttackState+18   p
                bset    #6,$561(a5)
                bset    #6,$621(a5)
                move.w  d1,$566(a5)
                move.w  d1,$626(a5)
                movea.w #(SeventhEntityType-M68K_RAM),a0
Boss_SharpssteelEnableLinkedBladeHitboxes:              ; CODE XREF: Boss_SharpssteelEnableOuterBladeHitboxes+18   j
                moveq   #6,d0
                bset    d0,$21(a0)
                bset    d0,$81(a0)
                bset    d0,$E1(a0)
                bset    d0,$141(a0)
                move.w  d1,$26(a0)
                move.w  d1,$86(a0)
                move.w  d1,$E6(a0)
                move.w  d1,$146(a0)
                rts
; End of function Boss_SharpssteelEnableInnerBladeHitboxes
; Disables collision for the outer blade group
Boss_SharpssteelDisableOuterBladeHitboxes:
                bclr    #6,$5C1(a5)                     ; was: sub_4878A
                bclr    #6,$681(a5)
                movea.w #(EleventhEntityType-M68K_RAM),a0
                bra.s   Boss_SharpssteelDisableLinkedBladeHitboxes
; End of function Boss_SharpssteelDisableOuterBladeHitboxes
; Disables collision for the inner blade group
Boss_SharpssteelDisableInnerBladeHitboxes:              ; CODE XREF: Boss_SharpssteelFarRangeBladeAttackState+2E   p  ; was: sub_4879C
                                        ; Boss_SharpssteelCloseRangeBladeAttackState+2E   p
                bclr    #6,$561(a5)
                bclr    #6,$621(a5)
                movea.w #(SeventhEntityType-M68K_RAM),a0
Boss_SharpssteelDisableLinkedBladeHitboxes:             ; CODE XREF: Boss_SharpssteelDisableOuterBladeHitboxes+10   j
                moveq   #6,d0
                bclr    d0,$21(a0)
                bclr    d0,$81(a0)
                bclr    d0,$E1(a0)
                bclr    d0,$141(a0)
                rts
; End of function Boss_SharpssteelDisableInnerBladeHitboxes
; Writes one collision value to four blade parts
Boss_SharpssteelSetBladeCollisionValuesA:
                move.w  d0,$686(a5)                     ; was: sub_487C0
                move.w  d0,$566(a5)
                move.w  d0,$386(a5)
                move.w  d0,$326(a5)
                rts
; End of function Boss_SharpssteelSetBladeCollisionValuesA
; Writes one collision value to the complementary four blade parts
Boss_SharpssteelSetBladeCollisionValuesB:
                move.w  d0,$626(a5)                     ; was: sub_487D2
                move.w  d0,$5C6(a5)
                move.w  d0,$506(a5)
                move.w  d0,$4A6(a5)
                rts
; End of function Boss_SharpssteelSetBladeCollisionValuesB
; Enables the two collision flags on all six core segments
Boss_SharpssteelEnableCoreSegmentCollision:             ; CODE XREF: Boss_SharpssteelOpeningVerticalTurnState+30   p  ; was: sub_487E4
                move.w  #$50,d0                         ; 'P'
                or.b    d0,$21(a5)
                or.b    d0,$81(a5)
                or.b    d0,$E1(a5)
                or.b    d0,$141(a5)
                or.b    d0,$1A1(a5)
                or.b    d0,$201(a5)
                rts
; End of function Boss_SharpssteelEnableCoreSegmentCollision
; Disables the two collision flags on all six core segments
Boss_SharpssteelDisableCoreSegmentCollision:            ; CODE XREF: Boss_SharpssteelInitializeFallingShotCycle+30   p  ; was: sub_48802
                                        ; Boss_SharpssteelInitializeDiveAttack+42   p
                move.w  #$FFAF,d0
                and.b   d0,$21(a5)
                and.b   d0,$81(a5)
                and.b   d0,$E1(a5)
                and.b   d0,$141(a5)
                and.b   d0,$1A1(a5)
                and.b   d0,$201(a5)
                rts
; End of function Boss_SharpssteelDisableCoreSegmentCollision
; Updates the directional sprite frames of the two visible core objects
Boss_SharpssteelUpdateCoreSpriteFrames:                 ; CODE XREF: Boss_SharpssteelUpdateBladeAssembly+8   p  ; was: sub_48820
                lea     Boss_SharpssteelCoreDirectionalSpriteFrames(pc),a1
                nop
                movea.w #(TenthEntityType-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jsr     (Sprite_UpdateFourDirectionFrame).l
                movea.w #(FourteenthEntityType-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jmp     Sprite_UpdateFourDirectionFrame
; End of function Boss_SharpssteelUpdateCoreSpriteFrames
; ---------------------------------------------------------------------------
Boss_SharpssteelCoreDirectionalSpriteFrames:    dc.l    Boss_SharpssteelCoreDirectionalMapping0  ; DATA XREF: Boss_SharpssteelUpdateCoreSpriteFrames   o
                dc.l    Boss_SharpssteelCoreDirectionalMapping1
                dc.l    Boss_SharpssteelCoreDirectionalMapping2
                dc.l    Boss_SharpssteelCoreDirectionalMapping3

; Configures blade-part mappings and tile attributes for graphics set A
Boss_SharpssteelConfigureBladeGraphicsSetA:             ; CODE XREF: Boss_SharpssteelInitializeState+46   p  ; was: sub_48856
                                        ; Boss_SharpssteelManualControlState+8   p
                move.w  #$EB9C,$24E(a5)
                move.w  #$B00,$248(a5)
                move.w  #$F4F0,$24A(a5)
                move.w  #$FB9C,$3CE(a5)
                move.w  #$B00,$3C8(a5)
                move.w  #$F4F0,$3CA(a5)
                moveq   #0,d1
                move.w  #$F7FF,d2
                cmpi.w  #$100,$56(a5)
                bpl.s   Boss_SharpssteelSelectBladeGraphicsTableA
                move.w  #$800,d1
                eori.w  #$1800,$24E(a5)
                eori.w  #$1800,$3CE(a5)
Boss_SharpssteelSelectBladeGraphicsTableA:              ; CODE XREF: Boss_SharpssteelConfigureBladeGraphicsSetA+30   j
                lea     Boss_SharpssteelBladeGraphicsMappingsA(pc),a0
                nop
                bra.s   Boss_SharpssteelApplyBladeGraphicsSet
; End of function Boss_SharpssteelConfigureBladeGraphicsSetA
; Configures blade-part mappings and tile attributes for graphics set B
Boss_SharpssteelConfigureBladeGraphicsSetB:             ; CODE XREF: Boss_SharpssteelManualControlState+14   p  ; was: sub_488A0
                                        ; Boss_SharpssteelInitializeFallingShotCycle+4A   p
                move.w  #$EB90,$24E(a5)
                move.w  #$E00,$248(a5)
                move.w  #$F0F4,$24A(a5)
                move.w  #$E390,$3CE(a5)
                move.w  #$E00,$3C8(a5)
                move.w  #$F0F4,$3CA(a5)
                moveq   #0,d1
                move.w  #$EFFF,d2
                cmpi.w  #$80,$56(a5)
                bmi.s   Boss_SharpssteelSelectBladeGraphicsTableB
                cmpi.w  #$180,$56(a5)
                bpl.s   Boss_SharpssteelSelectBladeGraphicsTableB
                move.w  #$1000,d1
                eori.w  #$1800,$24E(a5)
                eori.w  #$1800,$3CE(a5)
Boss_SharpssteelSelectBladeGraphicsTableB:              ; CODE XREF: Boss_SharpssteelConfigureBladeGraphicsSetB+30   j
                                        ; Boss_SharpssteelConfigureBladeGraphicsSetB+38   j
                lea     Boss_SharpssteelBladeGraphicsMappingsB(pc),a0
                nop
Boss_SharpssteelApplyBladeGraphicsSet:                  ; CODE XREF: Boss_SharpssteelConfigureBladeGraphicsSetA+48   j
                movea.w a5,a1
                moveq   #5,d7
Boss_SharpssteelApplyBladeGraphicsSetLoop:              ; CODE XREF: Boss_SharpssteelConfigureBladeGraphicsSetB+64   j
                and.w   d2,$E(a1)
                or.w    d1,$E(a1)
                move.l  (a0)+,8(a1)
                lea     $60(a1),a1
                dbf     d7,Boss_SharpssteelApplyBladeGraphicsSetLoop
                rts
; End of function Boss_SharpssteelConfigureBladeGraphicsSetB
; ---------------------------------------------------------------------------
Boss_SharpssteelBladeGraphicsMappingsB: dc.l    Boss_SharpssteelBladeGraphicsBMapping0  ; DATA XREF: Boss_SharpssteelConfigureBladeGraphicsSetB:Boss_SharpssteelSelectBladeGraphicsTableB   o
                dc.l    Boss_SharpssteelBladeGraphicsBMapping1
                dc.l    Boss_SharpssteelBladeGraphicsBMapping2
                dc.l    Boss_SharpssteelBladeGraphicsBMapping3
                dc.l    Boss_SharpssteelBladeGraphicsBMapping4
                dc.l    Boss_SharpssteelBladeGraphicsBMapping5
Boss_SharpssteelBladeGraphicsMappingsA: dc.l    Boss_SharpssteelBladeGraphicsAMapping0  ; DATA XREF: Boss_SharpssteelConfigureBladeGraphicsSetA:Boss_SharpssteelSelectBladeGraphicsTableA   o
                dc.l    Boss_SharpssteelBladeGraphicsAMapping1
                dc.l    Boss_SharpssteelBladeGraphicsAMapping2
                dc.l    Boss_SharpssteelBladeGraphicsAMapping3
                dc.l    Boss_SharpssteelBladeGraphicsAMapping4
                dc.l    Boss_SharpssteelBladeGraphicsAMapping5

; Sets collision-box group sizes for the outer blade group
Boss_SharpssteelSetOuterBladeGroupSizes:                ; CODE XREF: Boss_SharpssteelCloseRangeBladeAttackState+32   p  ; was: sub_4893A
                                        ; Boss_SharpssteelInitializeDiveAttack+52   p
                moveq   #$18,d0
                bsr.s   Boss_SharpssteelSelectOuterBladeGroup
                moveq   #$18,d0
; End of function Boss_SharpssteelSetOuterBladeGroupSizes
; Sets collision-box group sizes for the inner blade group
Boss_SharpssteelSetInnerBladeGroupSizes:                ; CODE XREF: Boss_SharpssteelInitializeManualControl+32   p  ; was: sub_48940
                                        ; Boss_SharpssteelInitializeBladeEntrance+50   p
                movea.w #(SeventhEntityType-M68K_RAM),a0
                bra.s   Boss_SharpssteelStoreBladeGroupSizes
; ---------------------------------------------------------------------------
Boss_SharpssteelSelectOuterBladeGroup:                  ; CODE XREF: Boss_SharpssteelInitializeFallingShotCycle+5A   j
                                        ; Boss_SharpssteelSetOuterBladeGroupSizes+2   p
                movea.w #(EleventhEntityType-M68K_RAM),a0
Boss_SharpssteelStoreBladeGroupSizes:                   ; CODE XREF: Boss_SharpssteelSetInnerBladeGroupSizes+4   j
                move.b  d0,$20(a0)
                move.b  d0,$80(a0)
                move.b  d0,$E0(a0)
                subq.w  #8,d0
                move.b  d0,$140(a0)
                rts
; End of function Boss_SharpssteelSetInnerBladeGroupSizes
; Loads 3 palette colors based on frame counter
Boss_SharpssteelUpdateFlashingPaletteColors:
                moveq   #6,d0                           ; was: sub_4895E
                btst    #0,(FrameCounter+1).w
                bne.s   Boss_SharpssteelSelectFlashingPaletteTriplet
                moveq   #0,d0
Boss_SharpssteelSelectFlashingPaletteTriplet:           ; CODE XREF: Boss_SharpssteelUpdateFlashingPaletteColors+8   j
                movea.w #(PaletteActiveColor51-M68K_RAM),a0
                move.w  Boss_SharpssteelFlashingPaletteTriplets(pc,d0.w),(a0)+
                move.w  Boss_SharpssteelFlashingPaletteTriplets+2(pc,d0.w),(a0)+
                move.w  Boss_SharpssteelFlashingPaletteTriplets+4(pc,d0.w),(a0)+
                rts
; End of function Boss_SharpssteelUpdateFlashingPaletteColors
; ---------------------------------------------------------------------------
Boss_SharpssteelFlashingPaletteTriplets:    dc.w    $8C8, $664, $220, $EEE, $AAA, $888
                                        ; DATA XREF: Boss_SharpssteelUpdateFlashingPaletteColors+10   r
                                        ; Boss_SharpssteelUpdateFlashingPaletteColors+14   r

; Controls background palette fade with limits
Boss_SharpssteelUpdateBackgroundPaletteFade:            ; CODE XREF: Boss_SharpssteelUpdateBladeAssembly:Boss_SharpssteelUpdateBladePresentation   p  ; was: sub_48988
                move.w  $3BE(a5),d0
                bne.s   Boss_SharpssteelSelectBackgroundFadeStep
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelSelectBackgroundFadeStep:               ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+4   j
                move.w  $3BC(a5),d7
                bne.s   Boss_SharpssteelApplyBackgroundFadeMode
                btst    #0,(FrameCounter+1).w
                bne.s   Boss_SharpssteelApplyBackgroundFadeMode
                moveq   #1,d7
Boss_SharpssteelApplyBackgroundFadeMode:                ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+C   j
                                        ; Boss_SharpssteelUpdateBackgroundPaletteFade+14   j
                cmpi.w  #2,d0
                beq.s   Boss_SharpssteelDecreaseBackgroundFade
                move.w  $35E(a5),d0
                add.w   d7,d0
                move.w  d0,$35E(a5)
                bmi.s   Boss_SharpssteelClampIncreasingBackgroundFade
                moveq   #0,d0
                bra.s   Boss_SharpssteelFinishBackgroundFade
; ---------------------------------------------------------------------------
Boss_SharpssteelClampIncreasingBackgroundFade:          ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+28   j
                cmpi.w  #$FFF8,d0
                bpl.s   Boss_SharpssteelApplyBackgroundPalette
                move.w  #$FFF8,d0
                bra.s   Boss_SharpssteelApplyBackgroundPalette
; ---------------------------------------------------------------------------
Boss_SharpssteelDecreaseBackgroundFade:                 ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+1C   j
                move.w  $35E(a5),d0
                sub.w   d7,d0
                move.w  d0,$35E(a5)
                bmi.s   Boss_SharpssteelClampDecreasingBackgroundFade
                moveq   #0,d0
                bra.s   Boss_SharpssteelApplyBackgroundPalette
; ---------------------------------------------------------------------------
Boss_SharpssteelClampDecreasingBackgroundFade:          ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+44   j
                cmpi.w  #$FFF8,d0
                bpl.s   Boss_SharpssteelApplyBackgroundPalette
                move.w  #$FFF8,d0
Boss_SharpssteelFinishBackgroundFade:                   ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+2C   j
                clr.w   $3BE(a5)
Boss_SharpssteelApplyBackgroundPalette:                 ; CODE XREF: Boss_SharpssteelUpdateBackgroundPaletteFade+32   j
                                        ; Boss_SharpssteelUpdateBackgroundPaletteFade+38   j
                movea.w #(PaletteActiveColor50-M68K_RAM),a0
                moveq   #$D,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_SharpssteelUpdateBackgroundPaletteFade
; Parses pose commands, interpolates pose bytes, and derives blade-part angles
Boss_SharpssteelRunBladePoseCommands:                   ; CODE XREF: Boss_SharpssteelManualControlState+3C   p  ; was: sub_489F0
                                        ; sub_48690   p
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   Boss_SharpssteelApplyBladePoseInterpolationStep
Boss_SharpssteelParseBladePoseCommandLoop:              ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+24   j
                                        ; Boss_SharpssteelRunBladePoseCommands+44   j
                move.w  $58(a5),d0
                bmi.w   Boss_SharpssteelUpdateBladeAnglesFromPose
                cmpi.b  #$80,(a1,d0.w)
                bne.s   Boss_SharpssteelReadBladePoseCommand
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   Boss_SharpssteelParseBladePoseCommandLoop
; ---------------------------------------------------------------------------
Boss_SharpssteelReadBladePoseCommand:                   ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_SharpssteelHandleBladePoseLoopCommand
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
Boss_SharpssteelHandleBladePoseLoopCommand:             ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   Boss_SharpssteelBeginBladePoseInterpolation
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   Boss_SharpssteelParseBladePoseCommandLoop
; ---------------------------------------------------------------------------
Boss_SharpssteelBeginBladePoseInterpolation:            ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+3A   j
                move.w  d3,(PoseCommandWord).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #Boss_SharpssteelBladePoseTargets,d0
                movea.l d0,a0
                bsr.w   Boss_SharpssteelInitializeBladePoseInterpolation
                moveq   #0,d0
                move.b  (PoseDurationByte).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   Boss_SharpssteelUpdateBladeAnglesFromPose
Boss_SharpssteelApplyBladePoseInterpolationStep:        ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+8   j
                subq.w  #1,$C(a5)
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                moveq   #7,d7
                jsr     (Anim_AdvancePoseChannelInterpolation).l
Boss_SharpssteelUpdateBladeAnglesFromPose:              ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+E   p
                                        ; Boss_SharpssteelRunBladePoseCommands+E   j
                move.w  #$1FE,d7
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  #$180,d1
                move.w  #$80,d2
                sub.w   d0,d1
                and.w   d7,d1
                move.w  d1,$B6(a5)
                and.w   d7,d1
                move.w  d1,$116(a5)
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$176(a5)
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$1D6(a5)
                and.w   d7,d2
                move.w  d2,$236(a5)
                move.w  $B6(a5),d1
                move.b  4(a0),d2
                asl.w   #1,d2
                subi.w  #$80,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$296(a5)
                move.b  8(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$2F6(a5)
                move.b  $C(a0),d2
                asl.w   #1,d2
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$356(a5)
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$3B6(a5)
                move.w  d3,$596(a5)
                move.w  d3,$656(a5)
                move.b  $10(a0),d2
                asl.w   #1,d2
                addi.w  #$80,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$416(a5)
                move.b  $14(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$476(a5)
                move.b  $18(a0),d2
                asl.w   #1,d2
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$4D6(a5)
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$536(a5)
                move.w  d3,$5F6(a5)
                move.w  d3,$6B6(a5)
                moveq   #0,d0
                moveq   #0,d1
                moveq   #0,d2
                moveq   #0,d4
                move.b  $1C(a0),d0
                beq.s   Boss_SharpssteelApplyBladePoseOffsets
                ext.w   d0
                ext.l   d0
                move.w  d0,d1
                asr.w   #1,d1
                move.l  d0,d2
                divs.w  #3,d2
                asr.w   #2,d4
Boss_SharpssteelApplyBladePoseOffsets:                  ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+14E   j
                move.w  $B2(a5),d3
                sub.w   d4,d3
                move.w  d3,$B4(a5)
                move.w  $112(a5),d3
                sub.w   d2,d3
                move.w  d3,$114(a5)
                move.w  $172(a5),d3
                sub.w   d2,d3
                move.w  d3,$174(a5)
                move.w  $1D2(a5),d3
                sub.w   d1,d3
                move.w  d3,$1D4(a5)
                move.w  $232(a5),d3
                sub.w   d0,d3
                move.w  d3,$234(a5)
                rts
; End of function Boss_SharpssteelRunBladePoseCommands
; Calculates interpolation deltas from the current pose to a target pose
Boss_SharpssteelInitializeBladePoseInterpolation:       ; CODE XREF: Boss_SharpssteelRunBladePoseCommands+5C   p  ; was: sub_48B84
                movea.l #Boss_SharpssteelNeutralPose,a1
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #7,d7
                jmp     Anim_CalculatePoseChannelDeltas
; End of function Boss_SharpssteelInitializeBladePoseInterpolation
; Initializes eight Sharpssteel blade pose channels from bytes at a0
Boss_SharpssteelInitializeBladePoseChannels:            ; CODE XREF: Boss_SharpssteelInitializeComplexPhase+48   p  ; was: sub_48B9A
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a1
                moveq   #7,d7
                jmp     Anim_InitializePoseChannelsFromBytes
; End of function Boss_SharpssteelInitializeBladePoseChannels
; ---------------------------------------------------------------------------
Boss_SharpssteelManualControlPoseCommands:  dc.b    $20, $20, 0, $10, $20, $20, 0, $18, $FF, $FF
                                        ; DATA XREF: Boss_SharpssteelManualControlState+36   o
Boss_SharpssteelHighSpeedPoseCommands:  dc.b    $C, $C, 0, $38, 7, $C, 0, $40, 7, 7, 0, $40, $C, $C, 0, $48
                                        ; DATA XREF: Boss_SharpssteelUpdateHorizontalAttackMotion:Boss_SharpssteelUseHighSpeedBladePose   o
                dc.b    7, $C, 0, $50, $80, 1, 7, 7, 0, $50, $FF, $FF
Boss_SharpssteelRightwardPoseCommands:  dc.b    $A, $A, 0, $38, 5, $A, 0, $40, 5, 5, 0, $40, $A, $A, 0, $48
                                        ; DATA XREF: Boss_SharpssteelUpdateHorizontalAttackMotion+64   o
                dc.b    5, $A, 0, $50, $80, 1, 5, 5, 0, $50, $FF, $FF
Boss_SharpssteelAssemblyTriggerPoseCommands:    dc.b    $10, $18, 0, $58, 8, 8, 0, $58, $10, $14, 0, $60, $2C, $2C, 0, $60
                                        ; DATA XREF: Boss_SharpssteelWaitForTwoBladeTriggersState+12   o
                dc.b    $C, $14, 0, $68, $14, $14, 0, $68, $10, $12, 0, $70, $12, $12, 0, $70
                dc.b    $FF, $FE
Boss_SharpssteelAssemblyDelayPoseCommands:  dc.b    5, $A, 0, 0, 8, 8, 0, 0, 5, $A, 0, 8, 8, 8, 0, 8
                                        ; DATA XREF: Boss_SharpssteelAccelerateBladeAssemblyState+14   o
                                        ; Boss_SharpssteelAccelerateBladeAssemblyState+3E   o
                dc.b    $80, 1, $FF, $FF
Boss_SharpssteelOpeningTurnPoseCommands:    dc.b    $A, $A, 0, $10, $10, $18, 0, $18, $C, $C, 0, $18, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelOpeningVerticalTurnState+A   o
Boss_SharpssteelAssemblyThresholdPoseCommands:  dc.b    $32, $32, 0, $20, 8, $A, 0, $28, 8, 8, 0, $28, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelOpeningVerticalTurnState+4A   o
Boss_SharpssteelAssemblySweepPoseCommands:  dc.b    5, 9, 0, $30, $12, $12, 0, $30, 6, $20, 0, $28, $11, $11, 0, $28
                                        ; DATA XREF: Boss_SharpssteelOpeningVerticalTurnState+E0   o
                dc.b    $FF, $FE
Boss_SharpssteelFarRangeAttackPoseCommands: dc.b    $13, $1C, 0, $80, $C, $C, 0, $80, $C, $40, 0, $88, $80, 1, 9, $D
                                        ; DATA XREF: Boss_SharpssteelFarRangeBladeAttackState+36   o
                dc.b    0, $88, $A, $A, 0, $88, $80, 2, $18, $1C, 0, $78, 6, 6, 0, $78
                dc.b    $FF, $FE
Boss_SharpssteelCloseRangeAttackPoseCommands:   dc.b    $13, $1C, 0, $90, $C, $C, 0, $90, $C, $40, 0, $98, $80, 1, 9, $D
                                        ; DATA XREF: Boss_SharpssteelCloseRangeBladeAttackState+3A   o
                dc.b    0, $98, $A, $A, 0, $98, $80, 2, $16, $1A, 0, $78, 6, 6, 0, $78
                dc.b    $FF, $FE
Boss_SharpssteelDivePoseCommands:   dc.b    6, $20, 0, 0, $A, $A, 0, 0, $10, $10, 0, $18, $FF, $FE
                                        ; DATA XREF: Boss_SharpssteelDiveAttackState:Boss_SharpssteelUpdateDiveAttackPose   o
Boss_SharpssteelComplexOscillationPoseCommands: dc.b    8, $10, 0, $A8, $20, $20, 0, $A8, $A, $30, 0, $B0, 4, 8, 0, $B0
                                        ; DATA XREF: Boss_SharpssteelWaitForComplexAlignmentState+6C   o
                                        ; Boss_SharpssteelWaitForComplexAlignmentState+A8   o
                dc.b    $80, 1, 2, 4, 0, $B0, $18, $18, 0, $B0, $FF, $FE
Boss_SharpssteelComplexExitPoseCommands:    dc.b    8, $10, 0, $B8, $20, $20, 0, $B8, $80, 2, $A, $30, 0, $C0, 4, 8
                                        ; DATA XREF: Boss_SharpssteelWaitForComplexAlignmentState+F6   o
                                        ; Boss_SharpssteelWaitForComplexAlignmentState+116   o
                dc.b    0, $C0, $80, 1, 2, 4, 0, $B8, $18, $18, 0, $B8, $FF, $FE
Boss_SharpssteelBladePoseTargets:   dc.b    0, $18, $C0, $30, $E8, $40, $D0, 3, 0, 8, $D8, $2C, $F8, $28, $D4, $18
                                        ; DATA XREF: Boss_SharpssteelRunBladePoseCommands+54   o
                dc.b    0, $10, $C0, $C8, $F0, $40, $38, $60, 0, 8, 4, 8, $F8, $FC, $F8, 0
                dc.b    0, $20, $E0, 0, $E0, $20, 0, $23, 0, $18, $B4, 0, $E8, $4C, 0, $F8
                dc.b    0, $20, 0, $D0, $E0, 0, $30, $48, $FC, 0, $7F, 8, $F0, $40, $C0, 3
                dc.b    $18, 8, $10, $D8, $D8, $E8, $F8, 3, 0, $10, $C0, $28, $F8, 0, $18, 3
                dc.b    $EC, $38, $30, 2, $20, $40, $C0, 3, $EC, $10, $D0, $CC, $F0, $30, $34, $30
                dc.b    0, $10, $E0, $C8, $F0, $20, $38, 8, $20, $10, $E0, $C8, $F0, $20, $38, 8
                dc.b    $F6, $20, $E0, $F8, $10, $60, $FC, $14, 0, $18, 0, $E0, $E8, 0, $20, $38
                dc.b    $F6, $30, $10, $28, $F0, $24, $20, $F8, $18, $10, $E0, $EA, $E0, $10, $14, $24
                dc.b    $18, $10, $A0, $E0, $E0, $34, $38, $20, $F0, $20, $F0, 8, $E8, 8, $17, $FC
Boss_SharpssteelComplexPhaseInitialPose:    dc.b    0, $20, $10, $20, $E0, $20, 0, 3, $F0, $1C, $24, $1C, $20, $38, $B0, $50
                                        ; DATA XREF: Boss_SharpssteelInitializeComplexPhase+42   o
                dc.b    $12, $30, 0, $28, $E8, $30, $E0, $30, 0, $18, $C0, $30, $E8, $40, $D0, 3
                dc.b    0, $18, $C0, $30, $E8, $40, $D0, 3
