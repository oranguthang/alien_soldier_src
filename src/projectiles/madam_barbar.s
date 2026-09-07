Projectile_MadamBarbarDebris:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_3AE36
                tst.w   (word_FF808C).w
                bpl.s   loc_3AE42
                tst.w   $24(a5)
                bpl.s   loc_3AE78
loc_3AE42:                                              ; CODE XREF: Projectile_MadamBarbarDebris+4   j
                clr.l   $18(a5)
                move.l  #$FFFEE000,$1C(a5)
                btst    #4,$E(a5)
                beq.s   loc_3AE5A
                neg.l   $1C(a5)
loc_3AE5A:                                              ; CODE XREF: Projectile_MadamBarbarDebris+1E   j
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
loc_3AE78:                                              ; CODE XREF: Projectile_MadamBarbarDebris+A   j
                bclr    #3,$E(a5)
                btst    #2,(word_FFA000+1).w
                bne.s   loc_3AE8C
                bset    #3,$E(a5)
loc_3AE8C:                                              ; CODE XREF: Projectile_MadamBarbarDebris+4E   j
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
                move.w  4(a5),d0
                bne.w   loc_3AF32
                tst.w   $4A(a5)
                beq.s   loc_3AF0A
                subq.w  #1,$48(a5)
                bmi.s   loc_3AED6
                cmpi.w  #$600,$5E(a5)
                bpl.s   loc_3AEBC
                cmpi.w  #$4A0,$5E(a5)
                bpl.s   locret_3AF30
loc_3AEBC:                                              ; CODE XREF: Projectile_MadamBarbarDebris+7C   j
                addq.w  #1,4(a5)
                move.l  $4C(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                neg.l   $4C(a5)
                bclr    #4,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AED6:                                              ; CODE XREF: Projectile_MadamBarbarDebris+74   j
                                        ; Projectile_MadamBarbarDebris+18C   j
                clr.l   $18(a5)
                cmpi.w  #$FFD0,$48(a5)
                bmi.s   loc_3AEF4
                cmpi.w  #$FFE0,$48(a5)
                bpl.s   locret_3AF08
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   locret_3AF08
loc_3AEF4:                                              ; CODE XREF: Projectile_MadamBarbarDebris+AA   j
                move.l  $4C(a5),$18(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                move.w  d0,$48(a5)
locret_3AF08:                                           ; CODE XREF: Projectile_MadamBarbarDebris+B2   j
                                        ; Projectile_MadamBarbarDebris+BC   j
                rts
; ---------------------------------------------------------------------------
loc_3AF0A:                                              ; CODE XREF: Projectile_MadamBarbarDebris+6E   j
                subi.l  #$3000,$1C(a5)
                bpl.s   locret_3AF30
                cmpi.w  #$B8,$14(a5)
                bpl.s   locret_3AF30
                move.w  #$B8,$14(a5)
                clr.l   $1C(a5)
                move.l  $4C(a5),$18(a5)
                addq.w  #1,$4A(a5)
locret_3AF30:                                           ; CODE XREF: Projectile_MadamBarbarDebris+84   j
                                        ; Projectile_MadamBarbarDebris+DC   j
                rts
; ---------------------------------------------------------------------------
loc_3AF32:                                              ; CODE XREF: Projectile_MadamBarbarDebris+66   j
                cmpi.w  #1,d0
                bne.s   loc_3AF64
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_3AF4A
                addi.l  #$3000,$1C(a5)
                bmi.s   locret_3AF30
loc_3AF4A:                                              ; CODE XREF: Projectile_MadamBarbarDebris+108   j
                bsr.w   Boss_MadamBarbarCheckCollision
                beq.s   locret_3AF30
                addq.w  #1,4(a5)
                move.b  #$82,$21(a5)
                clr.w   $48(a5)
                jmp     Physics_AlignToTerrain
; ---------------------------------------------------------------------------
loc_3AF64:                                              ; CODE XREF: Projectile_MadamBarbarDebris+100   j
                cmpi.w  #3,d0
                bne.s   loc_3AFA8
loc_3AF6A:                                              ; CODE XREF: Projectile_MadamBarbarDebris+180   j
                move.w  #3,4(a5)
                clr.l   $18(a5)
                bclr    #1,(byte_FF825C).w
                bne.s   loc_3AF86
                subq.w  #1,4(a5)
                clr.w   $48(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AF86:                                              ; CODE XREF: Projectile_MadamBarbarDebris+144   j
                move.w  #7,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                move.w  $10(a5),d0
                move.w  d0,(word_FF8250).w
                move.w  $14(a5),d0
                addi.w  #-$14,d0
                move.w  d0,(word_FF8252).w
                rts
; ---------------------------------------------------------------------------
loc_3AFA8:                                              ; CODE XREF: Projectile_MadamBarbarDebris+132   j
                bclr    #1,$22(a5)
                beq.s   loc_3AFB8
                bset    #1,(byte_FF825C).w
                bra.s   loc_3AF6A
; ---------------------------------------------------------------------------
loc_3AFB8:                                              ; CODE XREF: Projectile_MadamBarbarDebris+178   j
                move.b  #$82,$21(a5)
                subq.w  #1,$48(a5)
                bmi.w   loc_3AED6
                cmpi.w  #$650,$5E(a5)
                bpl.s   loc_3AFD6
                cmpi.w  #$450,$5E(a5)
                bpl.s   loc_3AFDE
loc_3AFD6:                                              ; CODE XREF: Projectile_MadamBarbarDebris+196   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AFDE:                                              ; CODE XREF: Projectile_MadamBarbarDebris+19E   j
                bsr.s   Boss_MadamBarbarCheckCollision
                beq.s   loc_3B004
                moveq   #8,d0
                tst.w   $18(a5)
                bpl.s   loc_3AFEC
                moveq   #$FFFFFFF8,d0
loc_3AFEC:                                              ; CODE XREF: Projectile_MadamBarbarDebris+1B2   j
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                beq.s   locret_3B012
                move.b  #$80,$21(a5)
                move.l  #$FFFC0000,$1C(a5)
loc_3B004:                                              ; CODE XREF: Projectile_MadamBarbarDebris+1AA   j
                subq.w  #1,4(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
locret_3B012:                                           ; CODE XREF: Projectile_MadamBarbarDebris+1BE   j
                rts
; End of function Projectile_MadamBarbarDebris
; Checks collision at boss center position for projectile spawning
Boss_MadamBarbarCheckCollision:                         ; CODE XREF: Projectile_MadamBarbarDebris:loc_3AF4A   p  ; was: sub_3B014
                                        ; sub_3AE36:loc_3AFDE   p
                moveq   #0,d0
                moveq   #$C,d1
                jmp     Physics_AddEntityOffset
; End of function Boss_MadamBarbarCheckCollision
; Spawns boss projectiles with random position offset calculations
Boss_MadamBarbarSpawnProjectile:                        ; CODE XREF: Boss_MadamBarbarAttackPhase   p  ; was: sub_3B01E
                                        ; Boss_MadamBarbarIdleUpdate+1A   p
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_3B066
                movea.l #dword_3B178,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$8100,2(a0)
                move.b  #$20,$20(a0)                    ; ' '
loc_3B03E:                                              ; CODE XREF: Boss_MadamBarbarSpawnDropProjectile+54   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_3B066:                                           ; CODE XREF: Boss_MadamBarbarSpawnProjectile+6   j
                                        ; Boss_MadamBarbarSpawnDropProjectile+8   j
                rts
; End of function Boss_MadamBarbarSpawnProjectile
; Spawn falling projectile from Madam Barbar boss
Boss_MadamBarbarSpawnDropProjectile:                    ; CODE XREF: Boss_MadamBarbarAIState+244   p  ; was: sub_3B068
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   locret_3B066
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_3B066
                move.w  #$11C,(a0)
                clr.w   4(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C3C3,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$B3,$26(a0)
                move.b  #4,$20(a0)
                move.w  #$F,$48(a0)
                move.w  #2,$4A(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                move.l  d0,$18(a0)
                bra.w   loc_3B03E
; End of function Boss_MadamBarbarSpawnDropProjectile
; Handle Madam Barbar dropped projectile animation and bouncing behavior
Projectile_MadamBarbarDropBehavior:                     ; DATA XREF: ROM:off_5DC   o  ; was: sub_3B0C0
                tst.w   (word_FF808C).w
                bmi.s   loc_3B0CE
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3B0CE:                                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+4   j
                tst.w   4(a5)
                bne.s   loc_3B0FC
                subq.w  #1,$48(a5)
                bpl.s   locret_3B0FA
                move.w  #$F,$48(a5)
                addq.w  #1,$E(a5)
                cmpi.b  #$C5,$F(a5)
                bne.s   locret_3B0FA
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_3B0FA:                                           ; CODE XREF: Projectile_MadamBarbarDropBehavior+18   j
                                        ; Projectile_MadamBarbarDropBehavior+2A   j
                rts
; ---------------------------------------------------------------------------
loc_3B0FC:                                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+12   j
                move.w  #$C3C5,$E(a5)
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_3B114
                addi.l  #$6000,$1C(a5)
                bmi.s   locret_3B134
loc_3B114:                                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+48   j
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                beq.s   locret_3B134
                subq.w  #1,$4A(a5)
                bmi.s   loc_3B136
                move.l  #$FFFC4000,$1C(a5)
                move.w  #$C3D2,$E(a5)
locret_3B134:                                           ; CODE XREF: Projectile_MadamBarbarDropBehavior+52   j
                                        ; Projectile_MadamBarbarDropBehavior+5E   j
                rts
; ---------------------------------------------------------------------------
loc_3B136:                                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+64   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_3B168
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_3B168
                jsr     (Effect_SpawnDestructionBlast).l
                bset    #2,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFF6000,$1C(a0)
loc_3B168:                                              ; CODE XREF: Projectile_MadamBarbarDropBehavior+7E   j
                                        ; Projectile_MadamBarbarDropBehavior+86   j
                clr.l   $18(a5)
                move.w  #$FFFE,$1C(a5)
                jmp     Projectile_CheckLifetime
; End of function Projectile_MadamBarbarDropBehavior
; ---------------------------------------------------------------------------
dword_3B178:    dc.l    $163BC, $FCFC, $163BD, $FCFC, $163BE, $FCFC, $263BF
                                        ; DATA XREF: Boss_MadamBarbarSpawnProjectile+8   o
                dc.l    $500F8F8, $163BE, $FCFC, $163BD, $FCFC, $163BC, $FCFC
                dc.w    $FFFF
dword_3B1B2:    dc.l    $100000, $10000C                ; DATA XREF: Boss_MadamBarbarIntro:loc_3A65C   o
                                        ; Boss_MadamBarbarIdleUpdate+1E   o
                dc.w    $FFFF
dword_3B1BC:    dc.l    $70000, $7000C                  ; DATA XREF: Boss_MadamBarbarAIState+248   o
                dc.w    $FFFF
dword_3B1C6:    dc.l    $40018, $4000C                  ; DATA XREF: Boss_MadamBarbarAttackPhase+58   o
                dc.w    $FFFF
dword_3B1D0:    dc.l    $F70D0018, $220018, $E3200024, $FE0E0024, $180024, $F0200018
                                        ; DATA XREF: Boss_MadamBarbarAIState+1F6   o
                dc.w    $FFFE
dword_3B1EA:    dc.l    $100030, $10003C, $100048, $100054
                                        ; DATA XREF: Boss_MadamBarbarAIState:loc_3A830   o
                dc.w    $FFFF
dword_3B1FC:    dc.l    $100060, $10006C, $100078, $100084
                                        ; DATA XREF: Boss_MadamBarbarAIState:loc_3A8AC   o
                dc.w    $FFFF
word_3B20E:     dc.w    $D828, $A8D8, $8818, $D820, $A8E0, $F8E8, $E028, $A0D8
                                        ; DATA XREF: Boss_MadamBarbarSetup+CA   o
                                        ; Boss_MadamBarbarUpdateAnimation+5A   o
                dc.w    $9020, $D020, $B0E0, $F0E0, $A028, $E0D8, $8010, $E028
                dc.w    $A0D8, $F0, $4408, $3CF8, $B404, $CC04, $B4FC, $CCFC
                dc.w    $C030, $A0D0, $9020, $D020, $B0E0, $F0E0, $E030, $C0D0
                dc.w    $C018, $8870, $C0E8, $F890, $C030, $A0D0, $D020, $9020
                dc.w    $F0E0, $B0E0, $E030, $C0D0, $8870, $C018, $F890, $C0E8
                dc.w    $E030, $C0D0, $9020, $D020, $B0E0, $F0E0, $C030, $A0D0
                dc.w    $8870, $C018, $F890, $C0E8, $E030, $C0D0, $D020, $9020
                dc.w    $F0E0, $B0E0, $C030, $A0D0, $C018, $8870, $C0E8, $F890

; Main Joker boss update handler with state dispatching and fade
