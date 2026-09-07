Enemy_HomingMissileUpdate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_38EA2
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_38EC2
                btst    #7,$22(a5)
                bne.s   loc_38EC2
                tst.w   (word_FF808C).w
                bpl.s   loc_38EC2
                tst.w   $24(a5)
                bpl.s   loc_38ED8
loc_38EC2:                                              ; CODE XREF: Enemy_HomingMissileUpdate+A   j
                                        ; Enemy_HomingMissileUpdate+12   j
                neg.l   $18(a5)
                neg.l   $1C(a5)
                move.l  #off_E9584,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_38ED8:                                              ; CODE XREF: Enemy_HomingMissileUpdate+1E   j
                lea     word_38FEC(pc),a0
                nop
                move.w  $56(a5),d1
                subi.w  #$10,d1
                move.w  d1,d0
                asr.w   #2,d0
                andi.w  #$38,d0                         ; '8'
                move.w  (a0,d0.w),$E(a5)
                move.w  2(a0,d0.w),8(a5)
                move.w  4(a0,d0.w),$A(a5)
                andi.w  #$1FE,d1
                cmpi.w  #$100,d1
                bmi.s   loc_38F10
                eori.w  #$1800,$E(a5)
loc_38F10:                                              ; CODE XREF: Enemy_HomingMissileUpdate+66   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_38F5E
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_38F5E
                movea.l #Projectile_HomingAndRockSpriteFrames,a1
                jsr     (Projectile_FindFreeSlotComplex).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asl.l   #2,d0
                neg.l   d0
                add.l   d0,$10(a0)
                asr.l   #2,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asl.l   #2,d0
                neg.l   d0
                add.l   d0,$14(a0)
                asr.l   #3,d0
                move.l  d0,$1C(a0)
loc_38F5E:                                              ; CODE XREF: Enemy_HomingMissileUpdate+76   j
                                        ; Enemy_HomingMissileUpdate+7E   j
                lea     (word_1B514).l,a1
                move.w  d1,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.l  d1,d3
                move.l  d2,d4
                asr.l   #1,d3
                asr.l   #1,d4
                asl.l   #4,d1
                asl.l   #4,d2
                tst.l   d1
                bpl.s   loc_38F8A
                cmp.l   $1C(a5),d1
                bpl.s   loc_38F96
                bra.s   loc_38F90
; ---------------------------------------------------------------------------
loc_38F8A:                                              ; CODE XREF: Enemy_HomingMissileUpdate+DE   j
                cmp.l   $1C(a5),d1
                bmi.s   loc_38F96
loc_38F90:                                              ; CODE XREF: Enemy_HomingMissileUpdate+E6   j
                add.l   d3,$1C(a5)
                bra.s   loc_38F9A
; ---------------------------------------------------------------------------
loc_38F96:                                              ; CODE XREF: Enemy_HomingMissileUpdate+E4   j
                                        ; Enemy_HomingMissileUpdate+EC   j
                move.l  d1,$1C(a5)
loc_38F9A:                                              ; CODE XREF: Enemy_HomingMissileUpdate+F2   j
                tst.l   d2
                bpl.s   loc_38FA6
                cmp.l   $18(a5),d2
                bpl.s   loc_38FB2
                bra.s   loc_38FAC
; ---------------------------------------------------------------------------
loc_38FA6:                                              ; CODE XREF: Enemy_HomingMissileUpdate+FA   j
                cmp.l   $18(a5),d2
                bcs.s   loc_38FB2
loc_38FAC:                                              ; CODE XREF: Enemy_HomingMissileUpdate+102   j
                add.l   d4,$18(a5)
                bra.s   loc_38FB6
; ---------------------------------------------------------------------------
loc_38FB2:                                              ; CODE XREF: Enemy_HomingMissileUpdate+100   j
                                        ; Enemy_HomingMissileUpdate+108   j
                move.l  d2,$18(a5)
loc_38FB6:                                              ; CODE XREF: Enemy_HomingMissileUpdate+10E   j
                jsr     (Math_CalculateAngleToPlayer).l
                sub.w   $56(a5),d2
                bmi.w   loc_38FD8
                cmpi.w  #$100,d2
                bpl.w   loc_38FE0
loc_38FCC:                                              ; CODE XREF: Enemy_HomingMissileUpdate+13A   j
                addq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                rts
; ---------------------------------------------------------------------------
loc_38FD8:                                              ; CODE XREF: Enemy_HomingMissileUpdate+11E   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_38FCC
loc_38FE0:                                              ; CODE XREF: Enemy_HomingMissileUpdate+126   j
                subq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                rts
; End of function Enemy_HomingMissileUpdate
; ---------------------------------------------------------------------------
word_38FEC:     dc.w    $D478, $400, $F8FC, 0
                                        ; DATA XREF: Enemy_HomingMissileUpdate:loc_38ED8   o
                dc.w    $D474, $500, $F8F8, 0
                dc.w    $D470, $500, $F8F8, 0
                dc.w    $D46C, $500, $F8F8, 0
                dc.w    $D46A, $100, $FCF8, 0
                dc.w    $DC6C, $500, $F8F8, 0
                dc.w    $DC70, $500, $F8F8, 0
                dc.w    $DC74, $500, $F8F8, 0

; Spawns 8-way directional projectiles with animated effects from table data
Boss_TerobusterSpawnMultiDirectional:                   ; CODE XREF: Boss_TerobusterMainAI+294   p  ; was: sub_3902C
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_39084
                move.w  #$14,$23C(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_39084
                move.w  (a4)+,d0
                move.w  (a4)+,d1
                move.w  (a4)+,d2
                jsr     (Projectile_SpawnDirectional8Way).l
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_39084
                move.w  #1,$1C(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.l   #1,d0
                addi.l  #$28000,d0
                move.l  d0,$18(a0)
                move.w  (a4)+,d1
                move.w  (a4)+,d2
                jsr     (Enemy_SpawnAnimatedProjectile).l
locret_39084:                                           ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+8   j
                                        ; Boss_TerobusterSpawnMultiDirectional+16   j
                rts
; End of function Boss_TerobusterSpawnMultiDirectional
; ---------------------------------------------------------------------------
word_39086:     dc.w    $40, $FFB2, $FFD6, $FFCC, $FFD8
                                        ; DATA XREF: Boss_TerobusterMainAI:loc_38932   o
word_39090:     dc.w    $30, $FFC4, $10, $FFD0, $C
                                        ; DATA XREF: Boss_TerobusterMainAI+250   o

; Spawns falling rocks with randomized position offsets and downward velocity
Boss_TerobusterSpawnFallingRock:                        ; CODE XREF: Boss_TerobusterMainAI+27A   p  ; was: sub_3909A
                btst    #0,(word_FFA000+1).w
                bne.s   locret_390EE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_390EE
                move.b  (dword_FFFF08).w,d1
                andi.w  #7,d1
                subi.w  #4,d1
                move.b  (dword_FFFF08+1).w,d2
                andi.w  #7,d2
                subi.w  #4,d2
                add.w   2(a4),d1
                add.w   4(a4),d2
                add.w   $10(a5),d1
                add.w   $14(a5),d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                movea.l #Projectile_HomingAndRockSpriteFrames,a1
                jsr     (Projectile_FindFreeSlotComplex).l
                move.l  #$FFFFC000,$1C(a0)
locret_390EE:                                           ; CODE XREF: Boss_TerobusterSpawnFallingRock+6   j
                                        ; Boss_TerobusterSpawnFallingRock+E   j
                rts
; End of function Boss_TerobusterSpawnFallingRock
; Boss movement physics with acceleration and boundaries
Boss_TerobusterMovementPhysics:                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_390F0
                jsr     (RandomNumber).l
                tst.w   4(a5)
                bne.s   loc_39120
                addq.w  #2,4(a5)
                move.w  #$CF00,2(a5)
                tst.l   $4C(a5)
                bne.s   loc_39112
                move.w  #$8F00,2(a5)
loc_39112:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+1A   j
                move.w  #1,$48(a5)
                move.w  (dword_FFFF08+2).w,$56(a5)
                bra.s   loc_39164
; ---------------------------------------------------------------------------
loc_39120:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+A   j
                btst    #0,(word_FFA000+1).w
                beq.s   loc_39148
                tst.w   $54(a5)
                bpl.s   loc_3913C
                cmpi.w  #$FFFF,$54(a5)
                beq.s   loc_39148
                addq.w  #1,$54(a5)
                bra.s   loc_39148
; ---------------------------------------------------------------------------
loc_3913C:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+3C   j
                cmpi.w  #1,$54(a5)
                beq.s   loc_39148
                subq.w  #1,$54(a5)
loc_39148:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+36   j
                                        ; Boss_TerobusterMovementPhysics+44   j
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_39196
                tst.w   $48(a5)
                beq.s   loc_39196
                cmpi.w  #$140,$14(a5)
                bmi.s   loc_39196
                clr.w   $48(a5)
loc_39164:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+2E   j
                move.l  #$FFFCF000,$1C(a5)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                swap    d0
                subi.l  #$38000,d0
                move.l  d0,$18(a5)
                tst.w   $18(a5)
                bmi.s   loc_39190
                move.w  #8,$54(a5)
                bra.s   loc_39196
; ---------------------------------------------------------------------------
loc_39190:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+96   j
                move.w  #$FFF8,$54(a5)
loc_39196:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+60   j
                                        ; Boss_TerobusterMovementPhysics+66   j
                move.l  $4C(a5),d1
                beq.s   locret_391CA
                movea.l d1,a0
                andi.w  #$E7FF,$E(a5)
                move.w  $56(a5),d0
                add.w   $54(a5),d0
                move.w  d0,$56(a5)
                andi.w  #$2C,d0                         ; ','
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   loc_391C0
                bset    #3,$E(a5)
loc_391C0:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+C8   j
                andi.w  #$1C,d0
                move.l  (a0,d0.w),8(a5)
locret_391CA:                                           ; CODE XREF: Boss_TerobusterMovementPhysics+AA   j
                rts
; End of function Boss_TerobusterMovementPhysics
; Interpolates animation frames with delay loading
