Boss_SharpssteelSpawnProjectileWave:                    ; CODE XREF: Boss_SharpssteelTimerCountdown+76   p  ; was: sub_48DA0
                lea     (word_1B514).l,a4
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$12,d4
                moveq   #5,d7
                bsr.s   Projectile_SpawnRadialPattern
                moveq   #$10,d4
                moveq   #3,d7
; End of function Boss_SharpssteelSpawnProjectileWave
; Spawns projectiles in radial pattern using sine table
Projectile_SpawnRadialPattern:                          ; CODE XREF: Boss_SharpssteelSpawnProjectileWave+E   p  ; was: sub_48DB4
                                        ; Projectile_SpawnRadialPattern+70   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_48E28
                move.w  #$364,(a0)
                move.w  #$EC00,2(a0)
                move.w  #0,$E(a0)
                move.l  #off_1A0F1A,8(a0)
                move.b  #$20,$20(a0)                    ; ' '
                moveq   #0,d0
                move.b  byte_48E2A(pc,d5.w),d0
                asl.w   #1,d0
                move.w  -$80(a4,d0.w),d1
                move.w  (a4,d0.w),d2
                ext.l   d1
                ext.l   d2
                muls.w  d4,d1
                muls.w  d4,d2
                move.l  d1,$1C(a0)
                asr.l   #1,d2
                move.l  d2,$18(a0)
                move.b  byte_48E34(pc,d6.w),d0
                ext.w   d0
                bpl.s   loc_48E0A
                ori.w   #$800,$E(a0)
loc_48E0A:                                              ; CODE XREF: Projectile_SpawnRadialPattern+4E   j
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                move.b  byte_48E34+1(pc,d6.w),d0
                ext.w   d0
                addi.w  #$160,d0
                move.w  d0,$14(a0)
                addq.w  #1,d5
                addq.w  #2,d6
                dbf     d7,Projectile_SpawnRadialPattern
locret_48E28:                                           ; CODE XREF: Projectile_SpawnRadialPattern+6   j
                rts
; End of function Projectile_SpawnRadialPattern
; ---------------------------------------------------------------------------
byte_48E2A:     dc.b    $B4, $B8, $BC, $C4, $C8, $CC, $B6, $BA, $C6, $CA
                                        ; DATA XREF: Projectile_SpawnRadialPattern+28   r
byte_48E34:     dc.b    $D0, 0, $E0, $F8, $F0, $F0, $10, $F0, $20, $F8
                                        ; DATA XREF: Projectile_SpawnRadialPattern+48   r
                                        ; Projectile_SpawnRadialPattern+5E   r
                dc.b    $30, 0, $C0, $24, $D0, $20, $30, $20, $40, $24

; Handles falling bomb with gravity and explosion
Enemy_FallingBombLogic:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_48E48
                tst.w   (word_FF808C).w
                bpl.w   loc_48EDA
                addi.l  #$B00,$1C(a5)
                tst.w   4(a5)
                bne.s   loc_48E98
                tst.w   $1C(a5)
                bmi.s   locret_48E96
                addq.w  #2,4(a5)
                bset    #4,$E(a5)
                bset    #7,$E(a5)
                move.b  #$C0,$21(a5)
                move.w  #1,$24(a5)
                move.w  #$64,$26(a5)                    ; 'd'
                move.l  #$F60AF60A,$28(a5)
                move.l  #$FC04FC04,$2C(a5)
locret_48E96:                                           ; CODE XREF: Enemy_FallingBombLogic+1A   j
                                        ; Enemy_FallingBombLogic+D4   j
                rts
; ---------------------------------------------------------------------------
loc_48E98:                                              ; CODE XREF: Enemy_FallingBombLogic+14   j
                bclr    #7,$22(a5)
                beq.s   loc_48EAA
                bclr    #4,$22(a5)
                beq.s   loc_48EDA
                bra.s   loc_48EB0
; ---------------------------------------------------------------------------
loc_48EAA:                                              ; CODE XREF: Enemy_FallingBombLogic+56   j
                tst.w   $24(a5)
                bpl.s   loc_48EEC
loc_48EB0:                                              ; CODE XREF: Enemy_FallingBombLogic+60   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_48EDA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                moveq   #$15,d0
                jsr     (loc_2BD20).l
                move.w  #$E440,2(a0)
                move.l  #$2000,$1C(a0)
loc_48EDA:                                              ; CODE XREF: Enemy_FallingBombLogic+4   j
                                        ; Enemy_FallingBombLogic+5E   j
                clr.l   $1C(a5)
                move.l  #off_E95A4,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_48EEC:                                              ; CODE XREF: Enemy_FallingBombLogic+66   j
                cmpi.w  #$150,$14(a5)
                bmi.s   loc_48F18
                move.w  $E(a5),d0
                andi.w  #$8000,d0
                movem.l d0,-(sp)
                move.l  #$FFFC8000,$1C(a5)
                jsr     (loc_3F182).l
                movem.l (sp)+,d0
                or.w    d0,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_48F18:                                              ; CODE XREF: Enemy_FallingBombLogic+AA   j
                tst.w   $48(a5)
                bne.w   locret_48E96
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  $10(a0),d0
                cmp.w   $10(a5),d0
                bpl.s   locret_48F60
                addi.w  #$F0,d0
                cmp.w   $10(a5),d0
                bmi.s   locret_48F60
                move.w  $14(a0),d0
                subi.w  #$A,d0
                cmp.w   $14(a5),d0
                bpl.s   locret_48F60
                addi.w  #$10,d0
                cmp.w   $14(a5),d0
                bmi.s   locret_48F60
                addq.w  #1,$48(a5)
                bclr    #4,$E(a5)
                move.w  #$FFFE,$1C(a5)
locret_48F60:                                           ; CODE XREF: Enemy_FallingBombLogic+E4   j
                                        ; Enemy_FallingBombLogic+EE   j
                rts
; End of function Enemy_FallingBombLogic
; Spawns 14 debris particles during defeat
Boss_SharpssteelSpawnDebris:                            ; CODE XREF: Boss_SharpssteelMain+22   j  ; was: sub_48F62
                move.b  #1,(byte_FF830E).w
                clr.w   8(a5)
                bset    #0,(byte_FFA272).w
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.w   2(a5)
                move.w  #$80,$48(a5)
                movea.w a5,a0
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$D,d7
loc_48F9C:                                              ; CODE XREF: Boss_SharpssteelSpawnDebris+98   j
                movem.l d6-d7/a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,d6-d7/a0
                lea     $60(a0),a0
                move.w  #$3BC,(a0)
                bset    #1,2(a0)
                bset    #3,2(a0)
                bset    #2,2(a0)
                move.w  d5,$48(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                swap    d0
                asr.l   #1,d0
                addi.l  #$12000,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #1,d6
                btst    #0,d6
                bne.s   loc_48FF0
                neg.w   d0
loc_48FF0:                                              ; CODE XREF: Boss_SharpssteelSpawnDebris+8A   j
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                addq.w  #1,d5
                dbf     d7,loc_48F9C
                rts
; End of function Boss_SharpssteelSpawnDebris
; Creates screen shake and debris during destruction
Effect_ShipDestructionDebris:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_49000
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                addq.w  #1,$48(a5)
                move.w  $48(a5),d0
                bset    #7,2(a5)
                btst    #0,d0
                beq.s   loc_49026
                bclr    #7,2(a5)
loc_49026:                                              ; CODE XREF: Effect_ShipDestructionDebris+1E   j
                andi.w  #7,d0
                bne.s   loc_4906E
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_49040
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
loc_49040:                                              ; CODE XREF: Effect_ShipDestructionDebris+34   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4906E
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                neg.l   d0
                asr.l   #3,d0
                move.l  d0,$18(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (Projectile_InitType88).l
loc_4906E:                                              ; CODE XREF: Effect_ShipDestructionDebris+2A   j
                                        ; Effect_ShipDestructionDebris+46   j
                subi.l  #$4000,$18(a5)
                tst.w   $18(a5)
                bpl.s   loc_49086
                addi.l  #$1000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_49086:                                              ; CODE XREF: Effect_ShipDestructionDebris+7A   j
                subi.l  #$1000,$1C(a5)
                rts
; End of function Effect_ShipDestructionDebris
; Spawns 6 radial projectiles with angle offsets
Boss_SharpssteelSpawnSixRadialShots:                    ; CODE XREF: Boss_SharpssteelComplexPhase+D2   p  ; was: sub_49090
                move.l  #$FFFA0000,d6
                moveq   #5,d7
loc_49098:                                              ; CODE XREF: Boss_SharpssteelSpawnSixRadialShots+10   j
                bsr.s   Projectile_InitSharpssteelShot
                addi.l  #$8000,d6
                dbf     d7,loc_49098
                rts
; End of function Boss_SharpssteelSpawnSixRadialShots
; Initializes projectile with position and trajectory
Projectile_InitSharpssteelShot:                         ; CODE XREF: Boss_SharpssteelSpawnSixRadialShots:loc_49098   p  ; was: sub_490A6
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_490FE
                move.w  #$414,(a0)
                move.w  #$C480,2(a0)
                move.b  #0,$20(a0)
                move.w  $4F0(a5),$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  $4E8(a5),8(a0)
                move.w  $4EE(a5),$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F010FA06,$2C(a0)
                move.w  #$56,$26(a0)                    ; 'V'
                move.l  d6,$1C(a0)
                move.w  d7,$48(a0)
                andi.w  #1,$48(a0)
                move.w  #$F,$4A(a0)
locret_490FE:                                           ; CODE XREF: Projectile_InitSharpssteelShot+6   j
                rts
; End of function Projectile_InitSharpssteelShot
; Toggles sprite flash bit based on timer
