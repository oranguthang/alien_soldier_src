Player_SpawnCircleAttack:                               ; DATA XREF: ROM:00017F30   o  ; was: sub_18530
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.w   Weapon_BeamFireEmptyExit
                move.w  #$38,(word_FF8238).w            ; '8'
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_1854C:                                              ; CODE XREF: Player_SpawnCircleAttack+26   j
                move.w  (a0),d0
                bne.w   locret_1869E
                lea     $60(a0),a0
                dbf     d7,loc_1854C
                move.w  #$E0,(word_FF8140).w
                move.b  #$C0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   loc_18578
                subi.w  #$A,$10(a4)
loc_18578:                                              ; CODE XREF: Player_SpawnCircleAttack+40   j
                move.w  #$8C,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_18586
                move.w  #$8C,d0
loc_18586:                                              ; CODE XREF: Player_SpawnCircleAttack+50   j
                sub.w   d0,$10(a4)
                bpl.s   loc_18590
                clr.w   $10(a4)
loc_18590:                                              ; CODE XREF: Player_SpawnCircleAttack+5A   j
                moveq   #0,d5
                movea.l #byte_184D8,a0
                move.b  (a0,d6.w),d5
                move.w  d5,d7
                asl.w   #2,d5
                movea.l #word_1B514,a0
                move.w  -$80(a0,d5.w),d3
                move.w  (a0,d5.w),d4
                muls.w  #$27,d3                         ; '''
                muls.w  #$27,d4                         ; '''
                move.l  d3,(dword_FF8040).w
                move.l  d4,(dword_FF8044).w
                move.w  d1,d3
                move.w  d2,d4
                sub.w   $10(a5),d3
                sub.w   $14(a5),d4
                move.w  d3,(word_FF8048).w
                move.w  d4,(word_FF804A).w
                movea.l #dword_19632,a0
                move.l  (a0,d7.w),d3
                move.l  $20(a0,d7.w),d4
                move.w  d7,d6
                addq.w  #8,d6
                andi.w  #$70,d6                         ; 'p'
                asr.w   #3,d6
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
                movea.l #word_186B0,a2
                moveq   #1,d5
                move.w  (word_FF808A).w,d0
                andi.w  #$8000,d0
loc_18600:                                              ; CODE XREF: Player_SpawnCircleAttack+150   j
                move.w  #$60,(a0)                       ; '`'
                move.w  #$8E80,2(a0)
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  (word_FF8048).w,$58(a0)
                move.w  (word_FF804A).w,$5A(a0)
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.l  (dword_FF8040).w,$48(a0)
                move.l  (dword_FF8044).w,$4C(a0)
                clr.l   $50(a0)
                clr.l   $54(a0)
                move.w  (a2,d6.w),$E(a0)
                move.w  $10(a2,d6.w),8(a0)
                move.w  $20(a2,d6.w),$A(a0)
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                move.b  #4,$23(a0)
                move.w  #$D,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_SetCircleAttackProperties
                move.w  #$E,$26(a0)
; Sets sprite properties for circular attack pattern projectiles
Weapon_SetCircleAttackProperties:                       ; CODE XREF: Player_SpawnCircleAttack+134   j  ; was: loc_1866C
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  d5,$5E(a0)
                addq.w  #3,d5
                lea     $60(a0),a0
                dbf     d7,loc_18600
                andi.w  #6,d6
                asl.w   #1,d6
                move.l  off_186A0(pc,d6.w),(dword_FF8020).w
                clr.w   (word_FF801C).w
                move.b  #$B4,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_1869E:                                           ; CODE XREF: Player_SpawnCircleAttack+1E   j
                rts
; End of function Player_SpawnCircleAttack
; ---------------------------------------------------------------------------
off_186A0:      dc.l    off_19932                       ; DATA XREF: Player_SpawnCircleAttack+15A   r
                dc.l    off_19972
                dc.l    off_19952
                dc.l    off_19972
word_186B0:     dc.w    $65A0, $75A0, $75A0, $7DA0, $6DA0, $6DA0, $65A0, $65A0
                                        ; DATA XREF: Player_SpawnCircleAttack+C0   o
                dc.w    $C00, $500, $300, $500, $C00, $500, $300, $500
                dc.w    $F0FC, $F8F8, $FCF0, $F8F8, $F0FC, $F8F8, $FCF0, $F8F8

nullsub_49:
                rts
; End of function nullsub_49

; Fires homing projectile that tracks player position
Weapon_FireHomingShot:                                  ; DATA XREF: ROM:00017F2E   o  ; was: sub_186E2
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                btst    #0,(word_FFA000+1).w
                bne.s   locret_18716
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_1870A:                                              ; CODE XREF: Weapon_FireHomingShot+30   j
                move.w  (a0),d0
                beq.s   loc_18718
                lea     $60(a0),a0
                dbf     d7,loc_1870A
locret_18716:                                           ; CODE XREF: Weapon_FireHomingShot+20   j
                rts
; ---------------------------------------------------------------------------
loc_18718:                                              ; CODE XREF: Weapon_FireHomingShot+2A   j
                tst.w   (word_FFA22A).w
                bne.s   loc_18722
                subq.w  #2,$10(a4)
loc_18722:                                              ; CODE XREF: Weapon_FireHomingShot+3A   j
                move.w  #3,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_18730
                move.w  #2,d0
loc_18730:                                              ; CODE XREF: Weapon_FireHomingShot+48   j
                sub.w   d0,$10(a4)
                bpl.s   loc_1873A
                clr.w   $10(a4)
loc_1873A:                                              ; CODE XREF: Weapon_FireHomingShot+52   j
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                sub.w   $10(a5),d1
                sub.w   $14(a5),d2
                move.w  d1,$58(a0)
                move.w  d2,$5A(a0)
                clr.l   $50(a5)
                clr.l   $54(a5)
                move.w  #$74,(a0)                       ; 't'
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #4,$23(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_SetHomingProjectileData
                move.w  #4,$26(a0)
; Sets homing projectile velocity and sprite animation data
Weapon_SetHomingProjectileData:                         ; CODE XREF: Weapon_FireHomingShot+92   j  ; was: loc_1877C
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$12,$5E(a0)
                lea     byte_184D8(pc),a1
                moveq   #0,d5
                move.b  (a1,d6.w),d5
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                movea.l (dword_FF802C).w,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                andi.w  #$70,d6                         ; 'p'
                asr.w   #3,d6
                movea.l #word_187EC,a1
                move.w  (a1,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.w  $10(a1,d6.w),8(a0)
                move.w  $20(a1,d6.w),$A(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_187EA
                move.b  #$B3,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_187EA:                                           ; CODE XREF: Weapon_FireHomingShot+FC   j
                rts
; End of function Weapon_FireHomingShot
; ---------------------------------------------------------------------------
word_187EC:     dc.w    $65A3, $75A6, $75A0, $7DA6, $6DA3, $6DA6, $65A0, $65A6
                                        ; DATA XREF: Weapon_FireHomingShot+D8   o
                dc.w    $800, $A00, $200, $A00, $800, $A00, $200, $A00
                dc.w    $F4FC, $F4F4, $FCF4, $F4F4, $F4FC, $F4F4, $FCF4, $F4F4

nullsub_50:
                rts
; End of function nullsub_50

; Calculates projectile spawn position
Weapon_CalculateOffsetPosition:
                move.b  (a4,d6.w),d0                    ; was: sub_1881E
                move.b  8(a4,d6.w),d1
                ext.w   d0
                ext.w   d1
                btst    #3,$E(a5)
                beq.s   loc_18834
                neg.w   d0
loc_18834:                                              ; CODE XREF: Weapon_CalculateOffsetPosition+12   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Weapon_CalculateOffsetPosition
; Spawns random debris particle with velocity
Effect_SpawnRandomDebris:                               ; CODE XREF: Weapon_FireProjectile+4   j  ; was: sub_18846
                                        ; Weapon_FireMultipleShots+4   j
                btst    #0,(word_FFA000+1).w
                bne.s   locret_18860
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_18854:                                              ; CODE XREF: Effect_SpawnRandomDebris+16   j
                tst.w   (a0)
                beq.s   Effect_CreateDebrisParticle
                lea     $60(a0),a0
                dbf     d7,loc_18854
locret_18860:                                           ; CODE XREF: Effect_SpawnRandomDebris+6   j
                rts
; ---------------------------------------------------------------------------
; Creates random debris particle effect with velocity
Effect_CreateDebrisParticle:                            ; CODE XREF: Effect_SpawnRandomDebris+10   j  ; was: loc_18862
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d1
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                jsr     (Sprite_InitType160).l
                move.w  #$334,(a0)
                move.l  #off_E9738,8(a0)
                move.b  #$40,$21(a0)                    ; '@'
                clr.b   $23(a0)
                move.w  #1,$26(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6                         ; '|'
                movea.l #dword_193B2,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$1C(a0)
                add.l   (dword_FF8240).w,d1
                move.l  d1,$18(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_188EC
                move.b  #$D3,d0
                jsr     (Sound_PlaySFX).l
locret_188EC:                                           ; CODE XREF: Effect_SpawnRandomDebris+9A   j
                rts
; End of function Effect_SpawnRandomDebris
; Checks if enemy damage exceeds threshold
Enemy_CheckDamageThreshold:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_188EE
                bclr    #7,$22(a5)
                bne.s   Enemy_SetFlashOnDamage
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_18904
; Sets enemy sprite flash flag when damage threshold exceeded
Enemy_SetFlashOnDamage:                                 ; CODE XREF: Enemy_CheckDamageThreshold+6   j  ; was: loc_188FE
                bset    #4,2(a5)
locret_18904:                                           ; CODE XREF: Enemy_CheckDamageThreshold+E   j
                rts
; End of function Enemy_CheckDamageThreshold
; Updates target sight position
Player_UpdateTargetSight:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_18906
                movea.w #(word_FFA400-M68K_RAM),a0
                clr.w   $56(a5)
                move.w  $10(a0),d5
                move.w  $14(a0),d6
                add.w   (word_FF8032).w,d5
                add.w   (word_FF8034).w,d6
                move.w  (word_FF8030).w,d0
                move.w  (word_FF8036).w,d7
                add.w   $50(a5),d7
                andi.w  #$1FE,d7
                movea.l #word_1B514,a2
                move.w  -$80(a2,d7.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d0,d1
                muls.w  d0,d2
                asl.l   #2,d1
                asl.l   #2,d2
                swap    d1
                swap    d2
                add.w   d6,d1
                add.w   d5,d2
                move.w  d1,$14(a5)
                move.w  d2,$10(a5)
                move.w  (word_FF803C).w,d0
                cmp.w   $48(a5),d0
                bne.s   locret_18984
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_18972
                bclr    #7,2(a0)
                rts
; ---------------------------------------------------------------------------
loc_18972:                                              ; CODE XREF: Player_UpdateTargetSight+62   j
                bset    #7,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_18984:                                           ; CODE XREF: Player_UpdateTargetSight+56   j
                rts
; End of function Player_UpdateTargetSight
; Marks sprite object for removal by setting deactivation flag
Sprite_MarkForRemoval:                                  ; CODE XREF: Weapon_UpdateRotatingProjectile+30   j  ; was: sub_18986
                                        ; Weapon_UpdateRotatingProjectile+3A   j
                bset    #4,2(a5)
                rts
; End of function Sprite_MarkForRemoval
; Spawns particle effect when enemy takes knockback damage
Effect_SpawnKnockbackParticle:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_1898E
                bclr    #7,$22(a5)
                bne.s   loc_189A6
                bclr    #6,$23(a5)
                beq.s   loc_189E0
                bclr    #4,$23(a5)
                bne.s   loc_18A0C
loc_189A6:                                              ; CODE XREF: Effect_SpawnKnockbackParticle+6   j
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a5)
                move.l  d2,$18(a5)
                lea     (Effect_KnockbackParticleSpriteFrames).l,a1
                jsr     (Sprite_InitTypeA4FromCurrentTable).l
                move.w  #$8C80,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_189E0:                                              ; CODE XREF: Effect_SpawnKnockbackParticle+E   j
                subq.w  #1,$5E(a5)
                bpl.s   locret_18A0A
                clr.b   $21(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                lea     (Effect_KnockbackImpactSpriteFrames).l,a1
                jmp     Sprite_InitTypeA4FromCurrentTable
; ---------------------------------------------------------------------------
locret_18A0A:                                           ; CODE XREF: Effect_SpawnKnockbackParticle+56   j
                rts
; ---------------------------------------------------------------------------
loc_18A0C:                                              ; CODE XREF: Effect_SpawnKnockbackParticle+16   j
                move.l  #word_1805C,$4A(a5)
                move.w  #$456C,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$F00,8(a5)
                move.w  #$F0F0,$A(a5)
loc_18A2C:                                              ; CODE XREF: Weapon_HandleProjectileHit+4C   j
                                        ; Weapon_HandleExplosiveImpact+9E   j
                move.w  #$18C,(a5)
                move.w  #$8C80,2(a5)
                clr.b   $21(a5)
                lea     dword_19632(pc),a1
                nop
                move.w  (dword_FFFF08).w,d6
                andi.w  #$7C,d6                         ; '|'
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                move.b  #$C8,d0
                jmp     (Sound_PlaySFX).l
; End of function Effect_SpawnKnockbackParticle
; Updates rotating projectile animation and boundary checking
