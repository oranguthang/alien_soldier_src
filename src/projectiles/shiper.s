; Shiper projectile spawning and update handlers

; Spawns Shiper's oscillating shot at a frame-counter interval
Boss_ShiperSpawnOscillatingShot:                        ; CODE XREF: Boss_ShiperUpdateAttackAndSpawnProjectile+26   p  ; was: sub_371E8
                move.w  (FrameCounter).w,d0
                andi.w  #$1F,d0
                bne.w   Boss_ShiperSpawnOscillatingShotReturn
                movea.w #(byte_FFD700-M68K_RAM),a0
                tst.w   (DifficultyMode).w
                bne.s   Boss_ShiperSpawnOscillatingShotUseEnemySlots
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                beq.s   Boss_ShiperSpawnOscillatingShotInitialize
                rts
; ---------------------------------------------------------------------------
Boss_ShiperSpawnOscillatingShotUseEnemySlots:           ; CODE XREF: Boss_ShiperSpawnOscillatingShot+14   j  ; was: loc_37208
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   Boss_ShiperSpawnOscillatingShotReturn
Boss_ShiperSpawnOscillatingShotInitialize:              ; CODE XREF: Boss_ShiperSpawnOscillatingShot+1C   j  ; was: loc_37210
                move.w  #$98,(a0)
                move.w  #$8D80,2(a0)
                clr.w   $24(a0)
                move.w  #$E3E8,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #8,$20(a0)
                move.b  #$84,$21(a0)
                move.l  #$F808F808,$28(a0)
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  $10(a1),$10(a0)
                addi.w  #-8,$10(a0)
                move.w  $14(a1),$14(a0)
                addi.w  #-$24,$14(a0)
                move.w  (RandomNumberState).w,d0
                andi.w  #$FF,d0
                addi.w  #$60,d0                         ; '`'
                move.w  d0,$48(a0)
                move.w  d0,$4A(a0)
Boss_ShiperSpawnOscillatingShotReturn:                  ; CODE XREF: Boss_ShiperSpawnOscillatingShot+8   j  ; was: locret_37274
                                        ; Boss_ShiperSpawnOscillatingShot+26   j
                rts
; End of function Boss_ShiperSpawnOscillatingShot
; Updates Shiper's oscillating shot, then emits its terminal projectile burst
Projectile_ShiperOscillatingShot:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_37276
                move.w  (PrimaryCameraXPosition).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$1AD8,d0
                bpl.s   Projectile_ShiperOscillatingShotUpdate
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Projectile_ShiperOscillatingShotUpdate:                 ; CODE XREF: Projectile_ShiperOscillatingShot+C   j  ; was: loc_3728C
                tst.w   (word_FF808C).w
                bpl.s   Projectile_ShiperOscillatingShotBurst
                tst.w   $24(a5)
                bpl.s   Projectile_ShiperOscillatingShotSteer
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_ShiperOscillatingShotBurst
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr     (Projectile_InitializeAimedDelayedCollisionShot).l
Projectile_ShiperOscillatingShotBurst:                  ; CODE XREF: Projectile_ShiperOscillatingShot+1A   j  ; was: loc_372B6
                                        ; Projectile_ShiperOscillatingShot+28   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
Projectile_ShiperOscillatingShotSteer:                  ; CODE XREF: Projectile_ShiperOscillatingShot+20   j  ; was: loc_372C4
                addq.w  #1,$4A(a5)
                move.w  #$E3E8,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                btst    #1,$4B(a5)
                bne.s   Projectile_ShiperOscillatingShotChooseVelocity
                move.w  #$E3F1,$E(a5)
                move.w  #$900,8(a5)
                move.w  #$F4FA,$A(a5)
Projectile_ShiperOscillatingShotChooseVelocity:         ; CODE XREF: Projectile_ShiperOscillatingShot+6A   j  ; was: loc_372F4
                jsr     (RandomNumber).l
                move.w  (RandomNumberState).w,d1
                andi.w  #$1FFF,d1
                addi.w  #$1000,d1
                ext.l   d1
                move.w  $4A(a5),d3
                andi.w  #$7F,d3
                move.w  (RandomNumberState).w,d2
                andi.w  #$3F,d2                         ; '?'
                add.w   d3,d2
                add.w   (PrimaryEntityYPos).w,d2
                subi.w  #$90,d2
                move.l  #$20000,$1C(a5)
                cmp.w   $14(a5),d2
                bpl.s   Projectile_ShiperOscillatingShotSteerHorizontal
                neg.l   $1C(a5)
Projectile_ShiperOscillatingShotSteerHorizontal:        ; CODE XREF: Projectile_ShiperOscillatingShot+B8   j  ; was: loc_37334
                tst.w   $48(a5)
                bmi.s   Projectile_ShiperOscillatingShotAccelerateLeft
                subq.w  #1,$48(a5)
                move.w  (PrimaryEntityXPos).w,d0
                cmp.w   $10(a5),d0
                bpl.s   Projectile_ShiperOscillatingShotAccelerateRight
Projectile_ShiperOscillatingShotAccelerateLeft:         ; CODE XREF: Projectile_ShiperOscillatingShot+C2   j  ; was: loc_37348
                tst.w   $18(a5)
                bpl.s   Projectile_ShiperOscillatingShotApplyLeftAcceleration
                cmpi.w  #$FFFE,$18(a5)
                bmi.s   Projectile_ShiperOscillatingShotReturn
Projectile_ShiperOscillatingShotApplyLeftAcceleration:  ; CODE XREF: Projectile_ShiperOscillatingShot+D6   j  ; was: loc_37356
                sub.l   d1,$18(a5)
Projectile_ShiperOscillatingShotReturn:                 ; CODE XREF: Projectile_ShiperOscillatingShot+DE   j  ; was: locret_3735A
                                        ; Projectile_ShiperOscillatingShot+F2   j
                rts
; ---------------------------------------------------------------------------
Projectile_ShiperOscillatingShotAccelerateRight:        ; CODE XREF: Projectile_ShiperOscillatingShot+D0   j  ; was: loc_3735C
                tst.w   $18(a5)
                bmi.s   Projectile_ShiperOscillatingShotApplyRightAcceleration
                cmpi.w  #4,$18(a5)
                bpl.s   Projectile_ShiperOscillatingShotReturn
Projectile_ShiperOscillatingShotApplyRightAcceleration:  ; CODE XREF: Projectile_ShiperOscillatingShot+EA   j  ; was: loc_3736A
                add.l   d1,$18(a5)
                rts
; End of function Projectile_ShiperOscillatingShot
; Spawns four projectiles in circular pattern with angle calculation
Boss_ShiperSpawnCircleShot:                             ; CODE XREF: Boss_ShiperSpinAttack+52   p  ; was: sub_37370
                moveq   #0,d5
                moveq   #$FFFFFFE0,d6
                moveq   #3,d7
Boss_ShiperSpawnCircleShotNext:                         ; CODE XREF: Boss_ShiperSpawnCircleShot+A0   j  ; was: loc_37376
                jsr     (Projectile_FindFreeSlot).l
                bne.w   Boss_ShiperSpawnCircleShotReturn
                move.w  #$35C,(a0)
                move.w  #$8D00,2(a0)
                move.w  d6,d0
                addi.w  #$20,d6                         ; ' '
                add.w   $430(a5),d0
                move.w  d0,$10(a0)
                move.w  $434(a5),$14(a0)
                move.b  #$C0,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  Boss_ShiperCircleShotObjectParameters(pc,d5.w),$E(a0)
                move.w  Boss_ShiperCircleShotObjectParameters+2(pc,d5.w),8(a0)
                move.w  Boss_ShiperCircleShotObjectParameters+4(pc,d5.w),$A(a0)
                move.w  Boss_ShiperCircleShotObjectParameters+6(pc,d5.w),$26(a0)
                addq.w  #8,d5
                lea     (Math_SineTable).l,a1
                move.w  (RandomNumberState).w,d0
                andi.w  #$3E,d0                         ; '>'
                subi.w  #$20,d0                         ; ' '
                addi.w  #$160,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movem.l d5-d7,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,d5-d7
                dbf     d7,Boss_ShiperSpawnCircleShotNext
Boss_ShiperSpawnCircleShotReturn:                       ; CODE XREF: Boss_ShiperSpawnCircleShot+C   j  ; was: locret_37414
                rts
; End of function Boss_ShiperSpawnCircleShot
; ---------------------------------------------------------------------------
Boss_ShiperCircleShotObjectParameters:  dc.w    $A3F7, $A00, $F4F4, $7A, $A410, $500, $F8F8, $3D, $A400, $F00, $F0F0, $F4, $A410, $500, $F8F8, $3D  ; was: word_37416
                                        ; DATA XREF: Boss_ShiperSpawnCircleShot+4A   r
                                        ; Boss_ShiperSpawnCircleShot+50   r

; Updates Shiper's rotating bouncing shot and converts it to debris on impact
Projectile_ShiperBouncingShot:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_37436
                tst.w   (word_FF808C).w
                bpl.w   Projectile_ShiperBouncingShotConvertToDebris
                moveq   #1,d1
                tst.w   $18(a5)
                bmi.s   Projectile_ShiperBouncingShotUpdateRotation
                moveq   #$FFFFFFFF,d1
Projectile_ShiperBouncingShotUpdateRotation:            ; CODE XREF: Projectile_ShiperBouncingShot+E   j  ; was: loc_37448
                add.w   d1,$48(a5)
                move.w  $48(a5),d0
                asr.w   #1,d0
                andi.w  #6,d0
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                bclr    #7,$22(a5)
                beq.s   Projectile_ShiperBouncingShotApplyGravity
                bclr    #4,$22(a5)
                beq.s   Projectile_ShiperBouncingShotConvertToDebris
                clr.b   $21(a5)
                move.l  $18(a5),d0
                neg.l   d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.w  #$FFFD,$1C(a5)
Projectile_ShiperBouncingShotApplyGravity:              ; CODE XREF: Projectile_ShiperBouncingShot+3A   j  ; was: loc_37490
                addi.l  #$1000,$1C(a5)
                bmi.s   Projectile_ShiperBouncingShotReturn
                moveq   #0,d0
                moveq   #7,d1
                jsr     (Physics_AddEntityOffset).l
                beq.s   Projectile_ShiperBouncingShotReturn
Projectile_ShiperBouncingShotConvertToDebris:           ; CODE XREF: Projectile_ShiperBouncingShot+4   j  ; was: loc_374A6
                                        ; Projectile_ShiperBouncingShot+42   j
                move.w  #$FFFD,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.l  #SharedCombatSpriteAnimation00,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
Projectile_ShiperBouncingShotReturn:                    ; CODE XREF: Projectile_ShiperBouncingShot+62   j  ; was: locret_374C4
                                        ; Projectile_ShiperBouncingShot+6E   j
                rts
; End of function Projectile_ShiperBouncingShot
