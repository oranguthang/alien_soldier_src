Projectile_BackStringerRopeSegment:                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_45696
                bclr    #0,$5E(a5)
                beq.s   loc_456CA
                move.w  #$1000,d0
                muls.w  $5C(a5),d0
                add.l   d0,$14(a5)
                clr.w   $5C(a5)
                move.w  #2,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_456CA
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_456CA:                                              ; CODE XREF: Projectile_BackStringerRopeSegment+6   j
                                        ; Projectile_BackStringerRopeSegment+2A   j
                move.w  #$168,d0
                add.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                clr.l   $1C(a5)
                move.w  (dword_FFA414).w,d0
                cmp.w   $14(a5),d0
                bpl.s   locret_456EA
                bclr    #7,(word_FFA40E).w
locret_456EA:                                           ; CODE XREF: Projectile_BackStringerRopeSegment+4C   j
                rts
; End of function Projectile_BackStringerRopeSegment
; Spawns falling projectiles periodically
Projectile_BackStringerSpawnDrops:                      ; CODE XREF: Boss_BackStringerAttackStateMachine:loc_449D0   p  ; was: sub_456EC
                                        ; sub_4484A:loc_44A80   p
                tst.w   (word_FFC680).w
                beq.w   locret_4577A
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_4577A
                tst.w   $47C(a5)
                bpl.s   loc_45716
                subq.w  #1,$47E(a5)
                bpl.s   locret_4577A
                move.w  #7,$47C(a5)
                move.w  #$B,$47E(a5)
loc_45716:                                              ; CODE XREF: Projectile_BackStringerSpawnDrops+16   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_4577A
                subq.w  #1,$47C(a5)
                move.w  #$318,(a0)
                move.w  #$CD00,2(a0)
                move.w  #$8300,$E(a0)
                move.l  #word_EC406,8(a0)
                move.b  #4,$20(a0)
                move.b  #$80,$21(a0)
                move.l  #$F404FC04,$28(a0)
                move.w  #2,$24(a0)
                move.w  #$14F,$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                move.w  $10(a0),$5C(a0)
                move.w  $10(a0),$5E(a0)
locret_4577A:                                           ; CODE XREF: Projectile_BackStringerSpawnDrops+4   j
                                        ; Projectile_BackStringerSpawnDrops+10   j
                rts
; End of function Projectile_BackStringerSpawnDrops
; Projectile that bounces off ground and tracks player
