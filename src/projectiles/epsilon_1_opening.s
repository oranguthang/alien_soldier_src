Boss_Epsilon1BounceProjectile:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4577C
                tst.w   (word_FFC680).w
                beq.s   loc_4578A
                cmpi.w  #$17C,$14(a5)
                bmi.s   loc_45792
loc_4578A:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+4   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45792:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_4579E
                tst.w   $24(a5)
                bpl.s   loc_457C2
loc_4579E:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+1A   j
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                clr.b   $21(a5)
                clr.w   $24(a5)
                eori.w  #$1000,$E(a5)
                move.l  #$FFFD0000,$1C(a5)
                bsr.w   Boss_Epsilon1CalculateHorizontalVelocity
loc_457C2:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+20   j
                bset    #3,$E(a5)
                addq.w  #1,$48(a5)
                btst    #2,$49(a5)
                bne.s   loc_457DA
                bclr    #3,$E(a5)
loc_457DA:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+56   j
                tst.b   $21(a5)
                beq.w   loc_458A2
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  4(a5),d0
                bne.w   loc_4588A
                move.w  $48(a5),d0
                andi.w  #7,d0
                bne.s   loc_4580A
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   $5C(a5),d0
                move.w  d0,$5E(a5)
loc_4580A:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+7A   j
                move.w  $5E(a5),d0
                cmp.w   $10(a5),d0
                bpl.s   loc_4582C
                tst.w   $18(a5)
                bpl.s   loc_45822
                cmpi.w  #$FFFE,$18(a5)
                bmi.s   loc_45842
loc_45822:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+9C   j
                subi.l  #$1000,$18(a5)
                bra.s   loc_45842
; ---------------------------------------------------------------------------
loc_4582C:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+96   j
                tst.w   $18(a5)
                bmi.s   loc_4583A
                cmpi.w  #2,$18(a5)
                bpl.s   loc_45842
loc_4583A:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+B4   j
                addi.l  #$1000,$18(a5)
loc_45842:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+A4   j
                                        ; Boss_Epsilon1BounceProjectile+AE   j
                addi.l  #$1800,$1C(a5)
                cmpi.w  #$FFFF,$1C(a5)
                bmi.s   loc_4585A
                move.l  #$FFFDC000,$1C(a5)
loc_4585A:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+D4   j
                move.w  $14(a5),d0
                subi.w  #$A,d0
                cmp.w   $14(a4),d0
                bpl.s   locret_45888
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                move.l  #$4000,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$48(a5)
locret_45888:                                           ; CODE XREF: Boss_Epsilon1BounceProjectile+EA   j
                rts
; ---------------------------------------------------------------------------
loc_4588A:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+6E   j
                bset    #0,$5E(a4)
                addq.w  #1,$5C(a4)
                move.w  $14(a4),d0
                addi.w  #$A,d0
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_458A2:                                              ; CODE XREF: Boss_Epsilon1BounceProjectile+62   j
                addi.l  #$4000,$1C(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_458BE
                bclr    #7,2(a5)
locret_458BE:                                           ; CODE XREF: Boss_Epsilon1BounceProjectile+13A   j
                rts
; End of function Boss_Epsilon1BounceProjectile
; Calculates horizontal velocity from random value
Boss_Epsilon1CalculateHorizontalVelocity:               ; CODE XREF: Boss_Epsilon1BounceProjectile+42   p  ; was: sub_458C0
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                btst    #1,(word_FFA000+1).w
                bne.s   loc_458D2
                neg.l   d0
loc_458D2:                                              ; CODE XREF: Boss_Epsilon1CalculateHorizontalVelocity+E   j
                move.l  d0,$18(a5)
                rts
; End of function Boss_Epsilon1CalculateHorizontalVelocity
; Spawns two projectiles at different angles
Boss_Epsilon1SpawnDualProjectiles:                      ; CODE XREF: Boss_BackStringerAttackStateMachine+34E   p  ; was: sub_458D8
                move.w  $70(a5),d5
                move.w  $74(a5),d6
                subi.w  #$10,d6
                moveq   #2,d3
                move.w  #$180,d4
                moveq   #8,d7
                bsr.s   Projectile_SpawnAngled
                moveq   #$FFFFFFFE,d3
                move.w  #$80,d4
                moveq   #$FFFFFFF8,d7
; End of function Boss_Epsilon1SpawnDualProjectiles
; Spawns angled projectile with trajectory parameters
Projectile_SpawnAngled:                                 ; CODE XREF: Boss_Epsilon1SpawnDualProjectiles+14   p  ; was: sub_458F6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_45944
                move.w  #$328,(a0)
                move.w  #$CC80,2(a0)
                move.l  #word_EC412,8(a0)
                move.w  #$A300,$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$88,$26(a0)
                move.w  #1,$1C(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.w  d7,$48(a0)
                move.w  d3,$4E(a0)
                move.w  d4,$56(a0)
locret_45944:                                           ; CODE XREF: Projectile_SpawnAngled+6   j
                rts
; End of function Projectile_SpawnAngled
; Handles debris bouncing physics
Boss_Epsilon1DebrisPhysics:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_45946
                tst.w   (word_FF808C).w
                bpl.s   loc_45976
                bclr    #7,$22(a5)
                beq.s   loc_4599C
                bclr    #4,$22(a5)
                beq.s   loc_45976
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_45976
                jsr     (Pickup_SpawnLarge).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_45976:                                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+4   j
                                        ; Boss_Epsilon1DebrisPhysics+14   j
                move.l  $18(a5),d0
                asr.l   #3,d0
                neg.l   d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #3,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                move.l  #off_E9584,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
loc_4599C:                                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+C   j
                subi.l  #$1000,$1C(a5)
                cmpi.w  #$90,$14(a5)
                bpl.s   loc_459B4
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_459B4:                                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+64   j
                move.w  $4C(a5),d0
                add.w   $4E(a5),d0
                andi.w  #6,d0
                move.w  d0,$4C(a5)
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                move.w  $56(a5),d0
                add.w   $48(a5),d0
                andi.w  #$1FE,d0
                move.w  d0,$56(a5)
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_45A58
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_45A58
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                move.l  $1C(a5),d1
                neg.l   d0
                neg.l   d1
                asl.l   #1,d0
                asl.l   #1,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                add.l   d0,$10(a0)
                add.l   d1,$14(a0)
                move.w  #$360,(a0)
                move.w  #$EC80,2(a0)
                move.w  #$A300,$E(a0)
                move.l  #off_EC42A,8(a0)
                move.w  $4E(a5),$4A(a0)
                clr.b   $20(a0)
locret_45A58:                                           ; CODE XREF: Boss_Epsilon1DebrisPhysics+BA   j
                                        ; Boss_Epsilon1DebrisPhysics+C2   j
                rts
; End of function Boss_Epsilon1DebrisPhysics
; Updates projectile rotation based on spin direction
Boss_Epsilon1ProjectileRotation:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_45A5A
                cmpi.w  #$80,$C(a5)
                bmi.s   loc_45A6A
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45A6A:                                              ; CODE XREF: Boss_Epsilon1ProjectileRotation+6   j
                move.w  $48(a5),d0
                add.w   $4A(a5),d0
                andi.w  #6,d0
                move.w  d0,$48(a5)
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                rts
; End of function Boss_Epsilon1ProjectileRotation
; Chain segment falling state
Projectile_BackStringerChainFalling:                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_45A90
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_45AA0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45AA0:                                              ; CODE XREF: Projectile_BackStringerChainFalling+6   j
                addi.l  #$2000,$1C(a5)
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                tst.w   $48(a5)
                bne.s   loc_45ACA
                movea.w a5,a0
                move.w  $56(a5),d0
                move.w  #$8300,$E(a5)
                move.w  $4A(a5),d1
                bra.w   loc_44FE2
; ---------------------------------------------------------------------------
loc_45ACA:                                              ; CODE XREF: Projectile_BackStringerChainFalling+24   j
                jmp     Sprite_UpdateRotatedFrame
; End of function Projectile_BackStringerChainFalling
; Main boss handler
