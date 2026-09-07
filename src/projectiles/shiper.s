Boss_ShiperSpawnDebris:                                 ; CODE XREF: Boss_ShiperUpdateWithFade+6   p  ; was: sub_36FEE
                move.w  #3,(word_FFA010).w
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   locret_37046
                jsr     (Sprite_InitType58FromTable).l
                clr.b   $20(a0)
                move.w  #$FFFA,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$1F,d1
                subi.w  #$24,d0                         ; '$'
                subi.w  #$24,d1                         ; '$'
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_37046:                                           ; CODE XREF: Boss_ShiperSpawnDebris+C   j
                rts
; End of function Boss_ShiperSpawnDebris
; Calculates and updates boss-related parallax scrolling and screen positioning
Boss_ShiperScrollUpdate:                                ; CODE XREF: Boss_ShiperSetupState+140   j  ; was: sub_37048
                                        ; sub_36A1A   p
                movea.w #(byte_FFE482-M68K_RAM),a0
                moveq   #$FFFFFF80,d0
                move.w  #$BF,d7
loc_37052:                                              ; CODE XREF: Boss_ShiperScrollUpdate+E   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_37052
                move.w  $50(a5),d0
                bmi.s   loc_37062
                moveq   #0,d0
loc_37062:                                              ; CODE XREF: Boss_ShiperScrollUpdate+16   j
                add.w   $74(a5),d0
                subi.w  #$3A,d0                         ; ':'
                move.w  d0,$14(a5)
                move.w  $70(a5),d0
                add.w   $4C(a5),d0
                move.w  d0,$10(a5)
                moveq   #$17,d0
                sub.w   $74(a5),d0
                move.w  d0,(word_FF9E02).w
                moveq   #0,d6
                move.w  $70(a5),d6
                subi.w  #$A8,d6
                move.w  $74(a5),d2
                subi.w  #$80,d2
                asl.w   #2,d2
                addi.w  #-$1BFE,d2
                movea.w d2,a1
                moveq   #$32,d7                         ; '2'
loc_370A0:                                              ; CODE XREF: Boss_ShiperScrollUpdate+5C   j
                move.w  d6,(a1)
                subq.w  #4,a1
                dbf     d7,loc_370A0
                move.w  $74(a5),d7
                sub.w   $14(a5),d7
                subi.w  #$38,d7                         ; '8'
                moveq   #0,d1
                move.w  $10(a5),d1
                sub.w   $70(a5),d1
                ext.l   d1
                asl.l   #4,d1
                divs.w  d7,d1
                swap    d1
                move.w  #0,d1
                asr.l   #4,d1
                subq.w  #1,d7
loc_370CE:                                              ; CODE XREF: Boss_ShiperScrollUpdate+90   j
                move.w  d6,(a1)
                subq.w  #4,a1
                swap    d6
                add.l   d1,d6
                swap    d6
                dbf     d7,loc_370CE
                moveq   #$FFFFFFD0,d1
                move.w  $14(a5),d0
                sub.w   d0,d1
                move.w  d1,(word_FFEC02).w
                subi.w  #$80,d0
                move.w  d0,$4A(a5)
                move.w  $10(a5),d6
                subi.w  #$A8,d6
                moveq   #$45,d7                         ; 'E'
loc_370FA:                                              ; CODE XREF: Boss_ShiperScrollUpdate+B6   j
                move.w  d6,(a1)
                subq.w  #4,a1
                dbf     d7,loc_370FA
                rts
; End of function Boss_ShiperScrollUpdate
; Spawns angled projectile with sine/cosine calculated velocity
Boss_ShiperSpawnAngledProjectile:
                btst    #0,(word_FFA000+1).w            ; was: sub_37104
                bne.s   locret_3715E
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_3715E
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Sprite_InitType94FromTable).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7E,d0                         ; '~'
                addi.w  #$C0,d0
                movea.l #Math_SineTable,a1
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #3,d1
                asl.l   #4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F808F808,$2C(a0)
                move.w  #$14,$26(a0)
locret_3715E:                                           ; CODE XREF: Boss_ShiperSpawnAngledProjectile+6   j
                                        ; Boss_ShiperSpawnAngledProjectile+E   j
                rts
; End of function Boss_ShiperSpawnAngledProjectile
; Spawns falling debris projectiles at random horizontal positions during Shellshogun boss fight
Boss_ShellshogunSpawnFallingDebris:
                moveq   #0,d7                           ; was: sub_37160
                tst.w   (word_FFFF0E).w
                beq.s   loc_3716A
                moveq   #2,d7
loc_3716A:                                              ; CODE XREF: Boss_ShellshogunSpawnFallingDebris+6   j
                                        ; Boss_ShellshogunSpawnFallingDebris+82   j
                jsr     (RandomNumber).l
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   locret_371E6
                move.w  #$108,(a0)
                move.w  #$ED80,2(a0)
                move.w  #$8480,$E(a0)
                move.b  #$10,$20(a0)
                move.l  #off_E9788,8(a0)
                clr.w   $C(a5)
                move.b  #$80,$21(a0)
                move.l  #$FE06FE06,$28(a0)
                move.l  #$FFFF6000,$18(a0)
                move.w  #2,$1C(a0)
                move.w  (dword_FFFF08).w,$1E(a0)
                move.w  #$90,$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                add.w   d0,$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                add.w   (dword_FFA410).w,d0
                move.w  d0,$10(a0)
                dbf     d7,loc_3716A
locret_371E6:                                           ; CODE XREF: Boss_ShellshogunSpawnFallingDebris+1A   j
                rts
; End of function Boss_ShellshogunSpawnFallingDebris
; Spawns boss projectiles periodically at random frame intervals
Boss_ShiperSpawnProjectile:                             ; CODE XREF: Boss_ShiperAttackDecision+26   p  ; was: sub_371E8
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.w   locret_37274
                movea.w #(byte_FFD700-M68K_RAM),a0
                tst.w   (word_FFFF0E).w
                bne.s   loc_37208
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                beq.s   loc_37210
                rts
; ---------------------------------------------------------------------------
loc_37208:                                              ; CODE XREF: Boss_ShiperSpawnProjectile+14   j
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   locret_37274
loc_37210:                                              ; CODE XREF: Boss_ShiperSpawnProjectile+1C   j
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
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$60,d0                         ; '`'
                move.w  d0,$48(a0)
                move.w  d0,$4A(a0)
locret_37274:                                           ; CODE XREF: Boss_ShiperSpawnProjectile+8   j
                                        ; Boss_ShiperSpawnProjectile+26   j
                rts
; End of function Boss_ShiperSpawnProjectile
; Boss projectile movement with horizontal acceleration and vertical oscillation
Enemy_BossProjectileMovement:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_37276
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$1AD8,d0
                bpl.s   loc_3728C
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3728C:                                              ; CODE XREF: Enemy_BossProjectileMovement+C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_372B6
                tst.w   $24(a5)
                bpl.s   loc_372C4
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_372B6
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr     (Enemy_InitDirectionalProjectile).l
loc_372B6:                                              ; CODE XREF: Enemy_BossProjectileMovement+1A   j
                                        ; Enemy_BossProjectileMovement+28   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
loc_372C4:                                              ; CODE XREF: Enemy_BossProjectileMovement+20   j
                addq.w  #1,$4A(a5)
                move.w  #$E3E8,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                btst    #1,$4B(a5)
                bne.s   loc_372F4
                move.w  #$E3F1,$E(a5)
                move.w  #$900,8(a5)
                move.w  #$F4FA,$A(a5)
loc_372F4:                                              ; CODE XREF: Enemy_BossProjectileMovement+6A   j
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d1
                andi.w  #$1FFF,d1
                addi.w  #$1000,d1
                ext.l   d1
                move.w  $4A(a5),d3
                andi.w  #$7F,d3
                move.w  (dword_FFFF08).w,d2
                andi.w  #$3F,d2                         ; '?'
                add.w   d3,d2
                add.w   (dword_FFC634).w,d2
                subi.w  #$90,d2
                move.l  #$20000,$1C(a5)
                cmp.w   $14(a5),d2
                bpl.s   loc_37334
                neg.l   $1C(a5)
loc_37334:                                              ; CODE XREF: Enemy_BossProjectileMovement+B8   j
                tst.w   $48(a5)
                bmi.s   loc_37348
                subq.w  #1,$48(a5)
                move.w  (dword_FFC630).w,d0
                cmp.w   $10(a5),d0
                bpl.s   loc_3735C
loc_37348:                                              ; CODE XREF: Enemy_BossProjectileMovement+C2   j
                tst.w   $18(a5)
                bpl.s   loc_37356
                cmpi.w  #$FFFE,$18(a5)
                bmi.s   locret_3735A
loc_37356:                                              ; CODE XREF: Enemy_BossProjectileMovement+D6   j
                sub.l   d1,$18(a5)
locret_3735A:                                           ; CODE XREF: Enemy_BossProjectileMovement+DE   j
                                        ; Enemy_BossProjectileMovement+F2   j
                rts
; ---------------------------------------------------------------------------
loc_3735C:                                              ; CODE XREF: Enemy_BossProjectileMovement+D0   j
                tst.w   $18(a5)
                bmi.s   loc_3736A
                cmpi.w  #4,$18(a5)
                bpl.s   locret_3735A
loc_3736A:                                              ; CODE XREF: Enemy_BossProjectileMovement+EA   j
                add.l   d1,$18(a5)
                rts
; End of function Enemy_BossProjectileMovement
; Spawns four projectiles in circular pattern with angle calculation
Boss_ShiperSpawnCircleShot:                             ; CODE XREF: Boss_ShiperSpinAttack+52   p  ; was: sub_37370
                moveq   #0,d5
                moveq   #$FFFFFFE0,d6
                moveq   #3,d7
loc_37376:                                              ; CODE XREF: Boss_ShiperSpawnCircleShot+A0   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_37414
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
                move.w  word_37416(pc,d5.w),$E(a0)
                move.w  word_37416+2(pc,d5.w),8(a0)
                move.w  word_37416+4(pc,d5.w),$A(a0)
                move.w  word_37416+6(pc,d5.w),$26(a0)
                addq.w  #8,d5
                lea     (Math_SineTable).l,a1
                move.w  (dword_FFFF08).w,d0
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
                dbf     d7,loc_37376
locret_37414:                                           ; CODE XREF: Boss_ShiperSpawnCircleShot+C   j
                rts
; End of function Boss_ShiperSpawnCircleShot
; ---------------------------------------------------------------------------
word_37416:     dc.w    $A3F7, $A00, $F4F4, $7A, $A410, $500, $F8F8, $3D, $A400, $F00, $F0F0, $F4, $A410, $500, $F8F8, $3D
                                        ; DATA XREF: Boss_ShiperSpawnCircleShot+4A   r
                                        ; Boss_ShiperSpawnCircleShot+50   r

; Bouncing projectile with rotation animation gravity and deflection on collision
Enemy_BounceRotateProjectile:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_37436
                tst.w   (word_FF808C).w
                bpl.w   loc_374A6
                moveq   #1,d1
                tst.w   $18(a5)
                bmi.s   loc_37448
                moveq   #$FFFFFFFF,d1
loc_37448:                                              ; CODE XREF: Enemy_BounceRotateProjectile+E   j
                add.w   d1,$48(a5)
                move.w  $48(a5),d0
                asr.w   #1,d0
                andi.w  #6,d0
                andi.w  #$E7FF,$E(a5)
                lea     (Object_CameraPriorityTable).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                bclr    #7,$22(a5)
                beq.s   loc_37490
                bclr    #4,$22(a5)
                beq.s   loc_374A6
                clr.b   $21(a5)
                move.l  $18(a5),d0
                neg.l   d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.w  #$FFFD,$1C(a5)
loc_37490:                                              ; CODE XREF: Enemy_BounceRotateProjectile+3A   j
                addi.l  #$1000,$1C(a5)
                bmi.s   locret_374C4
                moveq   #0,d0
                moveq   #7,d1
                jsr     (Physics_AddEntityOffset).l
                beq.s   locret_374C4
loc_374A6:                                              ; CODE XREF: Enemy_BounceRotateProjectile+4   j
                                        ; Enemy_BounceRotateProjectile+42   j
                move.w  #$FFFD,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.l  #off_E953C,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
locret_374C4:                                           ; CODE XREF: Enemy_BounceRotateProjectile+62   j
                                        ; Enemy_BounceRotateProjectile+6E   j
                rts
; End of function Enemy_BounceRotateProjectile
; Main Antroid boss handler dispatching to state routines
