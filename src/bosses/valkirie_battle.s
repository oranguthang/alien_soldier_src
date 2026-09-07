Boss_ValkirieIntroMove:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_5575E
                tst.w   4(a5)
                beq.w   loc_557AA
                tst.w   8(a5)
                beq.s   loc_557AA
                btst    #2,(byte_FF80EC).w
                bne.s   loc_5578A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_5578A
                tst.w   (word_FF8200).w
                bne.s   loc_5578A
                moveq   #2,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_5578A:                                              ; CODE XREF: Boss_ValkirieIntroMove+14   j
                                        ; Boss_ValkirieIntroMove+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #0,d0
                jsr     Boss_ValkirieUpdatePalette(pc)  ; (pc)
                nop
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$BC(a5)
loc_557AA:                                              ; CODE XREF: Boss_ValkirieIntroMove+4   j
                                        ; Boss_ValkirieIntroMove+C   j
                move.w  4(a5),d0
                movea.w off_557BA(pc,d0.w),a0
                adda.l  #Boss_ValkirieIntroStop,a0
                jmp     (a0)
; End of function Boss_ValkirieIntroMove
; ---------------------------------------------------------------------------
off_557BA:      dc.w    Boss_ValkirieIntroStop-Boss_ValkirieIntroStop
                                        ; DATA XREF: Boss_ValkirieIntroMove+50   r
                dc.w    Boss_ValkirieInitParts-Boss_ValkirieIntroStop
                dc.w    Camera_BossMode_State2-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieAttackState1-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieShootPattern1-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieAttackDecision-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieRisingAttack-Boss_ValkirieIntroStop
                dc.w    Boss_Valkirie_ChargeApplyGravity-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieChargeUpdate-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieUpdateHealth-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieDamageCheck-Boss_ValkirieIntroStop
                dc.w    Boss_Valkirie_ChargeApplyGravity-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieShootPattern3-Boss_ValkirieIntroStop
                dc.w    Camera_BossMode_State6-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieSpawnProjectile3-Boss_ValkirieIntroStop
                dc.w    Camera_BossMode_State7-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieSpawnProjectile4-Boss_ValkirieIntroStop
                dc.w    Boss_ValkirieHealthCheckAttack-Boss_ValkirieIntroStop
                dc.w    Camera_BossMode_State8-Boss_ValkirieIntroStop

; Intro stop position
Boss_ValkirieIntroStop:                                 ; DATA XREF: Boss_ValkirieIntroMove+54   o  ; was: sub_557E0
                                        ; ROM:off_557BA   o
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #off_59E94,a0
                movea.l #word_59EFC,a1
                movea.l #word_59F16,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_59F4A,$2FC(a5)
                move.l  #word_563E6,$35C(a5)
                move.w  #$42C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #Boss_ValkirieIntroObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bsr.w   Boss_ValkirieMovePattern1
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w   Boss_ValkirieIdleState
; End of function Boss_ValkirieIntroStop
; Initializes Valkirie boss position ($120,$E0), facing, velocities, and part pointers
Boss_ValkirieInitState:
                move.w  #2,4(a5)                        ; was: sub_5584A
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$140,$8B4(a5)
; End of function Boss_ValkirieInitState
; Initializes Valkirie body parts at offsets $4A/$8B4/$674 based on flags in $23E
Boss_ValkirieInitParts:                                 ; DATA XREF: ROM:000557BC   o  ; was: sub_55882
                bclr    #0,$23E(a5)
                beq.s   loc_55896
                move.w  #$CEC0,$4A(a5)
                move.w  #$140,$8B4(a5)
loc_55896:                                              ; CODE XREF: Boss_ValkirieInitParts+6   j
                bclr    #1,$23E(a5)
                beq.s   loc_558AA
                move.w  #$CC80,$4A(a5)
                move.w  #$140,$674(a5)
loc_558AA:                                              ; CODE XREF: Boss_ValkirieInitParts+1A   j
                lea     word_56244(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; End of function Boss_ValkirieInitParts
; Idle state handler
Boss_ValkirieIdleState:                                 ; CODE XREF: Boss_ValkirieIntroStop+66   j  ; was: sub_558B4
                move.w  #4,4(a5)
                move.w  #$100,$54(a5)
                move.w  #$C0,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  $10(a5),$70(a5)
                move.w  #$C680,$48(a5)
                move.w  #$CC80,$4A(a5)
                bset    #0,$62(a5)
                move.w  #$140,$674(a5)
; Camera state 2 for boss battle focus
Camera_BossMode_State2:                                 ; DATA XREF: ROM:000557BE   o  ; was: loc_558EE
                subq.w  #1,$11C(a5)
                bpl.s   loc_55900
                addq.w  #2,4(a5)
                moveq   #8,d0
                jsr     (UI_CheckVictoryCondition).l
loc_55900:                                              ; CODE XREF: Boss_ValkirieIdleState+3E   j
                lea     word_56262(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; End of function Boss_ValkirieIdleState
; Attack state 1 handler
Boss_ValkirieAttackState1:                              ; DATA XREF: ROM:000557C0   o  ; was: sub_5590A
                tst.w   (word_FF80C2).w
                bne.s   loc_55926
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (word_FFA02A).w
                subi.w  #$58,(word_FFA970).w            ; 'X'
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55926:                                              ; CODE XREF: Boss_ValkirieAttackState1+4   j
                lea     word_56262(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55930:                                              ; CODE XREF: Boss_ValkirieAttackState1+18   j
                                        ; Boss_ValkirieAttackDecision+6   j
                move.w  #8,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieAttackState1
; Shooting pattern 1
Boss_ValkirieShootPattern1:                             ; DATA XREF: ROM:000557C2   o  ; was: sub_5594E
                bclr    #0,$23E(a5)
                beq.s   loc_559AA
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$80,d0
                bpl.s   loc_55966
                bra.w   Boss_ValkirieCollisionCheck
; ---------------------------------------------------------------------------
loc_55966:                                              ; CODE XREF: Boss_ValkirieShootPattern1+12   j
                cmpi.w  #$700,$BC(a5)
                bmi.s   loc_5598E
                cmpi.w  #$840,$BC(a5)
                bpl.s   loc_5598E
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   loc_55CAC
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   Boss_ValkirieShootPattern2
loc_5598E:                                              ; CODE XREF: Boss_ValkirieShootPattern1+1E   j
                                        ; Boss_ValkirieShootPattern1+26   j
                cmpi.w  #$720,$BC(a5)
                bmi.s   loc_559A6
                cmpi.w  #$820,$BC(a5)
                bpl.s   loc_559A6
                cmpi.w  #$F8,d0
                bpl.w   Boss_ValkirieSpawnDualShot
loc_559A6:                                              ; CODE XREF: Boss_ValkirieShootPattern1+46   j
                                        ; Boss_ValkirieShootPattern1+4E   j
                bra.w   loc_559B8
; ---------------------------------------------------------------------------
loc_559AA:                                              ; CODE XREF: Boss_ValkirieShootPattern1+6   j
                bsr.w   Boss_ValkirieSetFacing
                lea     word_56262(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_559B8:                                              ; CODE XREF: Boss_ValkirieShootPattern1:loc_559A6   j
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                move.w  #$CC80,d0
                move.w  #$CC80,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieShootPattern1
; Checks facing and distance to player, decides between projectile attacks or melee charge
Boss_ValkirieAttackDecision:                            ; CODE XREF: Boss_ValkirieRisingAttack+42   j  ; was: sub_559D8
                                        ; DATA XREF: ROM:000557C4   o
                tst.w   $58(a5)
                bpl.s   loc_559E2
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_559E2:                                              ; CODE XREF: Boss_ValkirieAttackDecision+4   j
                bclr    #0,$23E(a5)
                beq.s   loc_55A32
                jsr     Boss_ValkirieCheckFacing(pc)    ; (pc)
                nop
                bmi.s   loc_55A30
                cmpi.w  #$30,d0                         ; '0'
                bmi.s   loc_55A30
                cmpi.w  #$A0,d0
                bpl.s   loc_55A30
                move.w  d0,d1
                cmpi.w  #$46,d1                         ; 'F'
                bpl.s   loc_55A0E
                move.l  #$8000,d0
                bra.s   loc_55A28
; ---------------------------------------------------------------------------
loc_55A0E:                                              ; CODE XREF: Boss_ValkirieAttackDecision+2C   j
                move.l  #$FFFE8000,d0
                cmpi.w  #$70,d1                         ; 'p'
                bpl.s   loc_55A1C
                bra.s   loc_55A28
; ---------------------------------------------------------------------------
loc_55A1C:                                              ; CODE XREF: Boss_ValkirieAttackDecision+40   j
                tst.w   (word_FFFF0E).w
                beq.s   loc_55A28
                move.l  #$FFFDC000,d0
loc_55A28:                                              ; CODE XREF: Boss_ValkirieAttackDecision+34   j
                                        ; Boss_ValkirieAttackDecision+42   j
                bsr.w   Boss_ValkirieSetVelocityFacing
                bra.w   Boss_ValkirieChargeAttack
; ---------------------------------------------------------------------------
loc_55A30:                                              ; CODE XREF: Boss_ValkirieAttackDecision+18   j
                                        ; Boss_ValkirieAttackDecision+1E   j
                bra.s   loc_55A3C
; ---------------------------------------------------------------------------
loc_55A32:                                              ; CODE XREF: Boss_ValkirieAttackDecision+10   j
                lea     word_5628E(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55A3C:                                              ; CODE XREF: Boss_ValkirieAttackDecision:loc_55A30   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                move.w  a5,d0
                move.w  a5,d1
                bsr.w   Boss_ValkirieSpawnProjectile2
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$FFFE0000,d0
                bsr.w   Boss_ValkirieSetVelocityFacing
                move.b  #$5A,d0                         ; 'Z'
                jsr     (Sound_PlaySFX).l
; End of function Boss_ValkirieAttackDecision
; Rises upward with vertical velocity, spawns projectiles when flag set, transitions states
Boss_ValkirieRisingAttack:                              ; DATA XREF: ROM:000557C6   o  ; was: sub_55A68
                addi.l  #$2000,$1C(a5)
                bclr    #0,$23E(a5)
                bne.s   loc_55A82
                lea     word_5628E(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55A82:                                              ; CODE XREF: Boss_ValkirieRisingAttack+E   j
                move.w  #$A,4(a5)
                clr.b   $23E(a5)
                move.w  #$CEC0,d0
                move.w  #$CC80,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$5A,d0                         ; 'Z'
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_ValkirieAttackDecision
; End of function Boss_ValkirieRisingAttack
; Sets state $22, spawns two projectiles at $CEC0 positions, clears state flags
Boss_ValkirieSpawnDualShot:                             ; CODE XREF: Boss_ValkirieShootPattern1+54   j  ; was: sub_55AAE
                move.w  #$22,4(a5)                      ; '"'
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieSpawnDualShot
; Checks health thresholds ($810/$730) and spawns projectiles based on part status
Boss_ValkirieHealthCheckAttack:                         ; DATA XREF: ROM:000557DC   o  ; was: sub_55ACE
                bclr    #7,$23E(a5)
                beq.s   loc_55AF2
                tst.w   $54(a5)
                bne.s   loc_55AE8
                cmpi.w  #$810,$BC(a5)
                bmi.s   loc_55AF2
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55AE8:                                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+C   j
                cmpi.w  #$730,$BC(a5)
                bmi.w   loc_55930
loc_55AF2:                                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+6   j
                                        ; Boss_ValkirieHealthCheckAttack+14   j
                bclr    #0,$23E(a5)
                beq.s   loc_55B08
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
                bra.s   loc_55B1C
; ---------------------------------------------------------------------------
loc_55B08:                                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+2A   j
                bclr    #1,$23E(a5)
                beq.s   loc_55B1C
                move.w  #$CC80,d0
                move.w  #$CC80,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
loc_55B1C:                                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+38   j
                                        ; Boss_ValkirieHealthCheckAttack+40   j
                lea     word_562A4(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; End of function Boss_ValkirieHealthCheckAttack
; Charges with velocity, spawns projectile, selects movement pattern based on player position
Boss_ValkirieChargeAttack:                              ; CODE XREF: Boss_ValkirieAttackDecision+54   j  ; was: sub_55B26
                move.w  #$E,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  a5,d0
                move.w  a5,d1
                bsr.w   Boss_ValkirieSpawnProjectile2
                move.b  #$5A,d0                         ; 'Z'
                jsr     (Sound_PlaySFX).l
                cmpi.w  #$120,(dword_FFA414).w
                bmi.s   loc_55B6C
                tst.w   (dword_FFA41C).w
                bmi.s   loc_55B82
loc_55B62:                                              ; CODE XREF: Boss_ValkirieChargeAttack+6E   j
                move.l  #word_56330,$41C(a5)
                bra.s   Boss_Valkirie_ChargeApplyGravity
; ---------------------------------------------------------------------------
loc_55B6C:                                              ; CODE XREF: Boss_ValkirieChargeAttack+34   j
                cmpi.w  #$E0,(dword_FFA414).w
                bmi.s   loc_55B8C
                btst    #1,(word_FFA000+1).w
                bne.s   loc_55B82
                tst.w   (dword_FFA41C).w
                bmi.s   loc_55B96
loc_55B82:                                              ; CODE XREF: Boss_ValkirieChargeAttack+3A   j
                                        ; Boss_ValkirieChargeAttack+54   j
                move.l  #word_56350,$41C(a5)
                bra.s   Boss_Valkirie_ChargeApplyGravity
; ---------------------------------------------------------------------------
loc_55B8C:                                              ; CODE XREF: Boss_ValkirieChargeAttack+4C   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_55B62
loc_55B96:                                              ; CODE XREF: Boss_ValkirieChargeAttack+5A   j
                move.l  #word_56370,$41C(a5)
; Applies gravity during charge attack and spawns bullets
Boss_Valkirie_ChargeApplyGravity:                       ; CODE XREF: Boss_ValkirieChargeAttack+44   j  ; was: loc_55B9E
                                        ; Boss_ValkirieChargeAttack+64   j
                                        ; DATA XREF:
                addi.l  #$2000,$1C(a5)
                bclr    #0,$23E(a5)
                bne.s   loc_55BBA
                bsr.w   Projectile_ValkirieBullet
                movea.l $41C(a5),a1
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55BBA:                                              ; CODE XREF: Boss_ValkirieChargeAttack+86   j
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$858(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CE60,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
                lea     word_55C64(pc),a0
                nop
                bsr.w   Boss_ValkirieUpdateParts
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ValkirieChargeAttack
; Updates charge velocity, handles part destruction flag, checks collision conditions
Boss_ValkirieChargeUpdate:                              ; DATA XREF: ROM:000557CA   o  ; was: sub_55BF0
                tst.w   $58(a5)
                bpl.s   loc_55C02
                clr.l   $8B8(a5)
                bsr.w   Boss_ValkirieSpawnEffect
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55C02:                                              ; CODE XREF: Boss_ValkirieChargeUpdate+4   j
                tst.l   $8B8(a5)
                beq.s   loc_55C28
                bpl.s   loc_55C1A
                addi.l  #$1000,$8B8(a5)
                bmi.s   loc_55C28
                clr.l   $8B8(a5)
                bra.s   loc_55C28
; ---------------------------------------------------------------------------
loc_55C1A:                                              ; CODE XREF: Boss_ValkirieChargeUpdate+18   j
                subi.l  #$1000,$8B8(a5)
                bpl.s   loc_55C28
                clr.l   $8B8(a5)
loc_55C28:                                              ; CODE XREF: Boss_ValkirieChargeUpdate+16   j
                                        ; Boss_ValkirieChargeUpdate+22   j
                bclr    #2,$23E(a5)
                beq.s   loc_55C3A
                lea     word_55C82(pc),a0
                nop
                bsr.w   Boss_ValkirieDestroyParts
loc_55C3A:                                              ; CODE XREF: Boss_ValkirieChargeUpdate+3E   j
                bclr    #3,$23E(a5)
                beq.s   loc_55C58
                tst.w   (word_FFFF0E).w
                beq.s   loc_55C58
                bsr.w   Boss_ValkirieCheckFacing
                bmi.s   loc_55C58
                cmpi.w  #$80,d0
                bpl.s   loc_55C58
                bra.w   Boss_ValkirieCollisionCheck
; ---------------------------------------------------------------------------
loc_55C58:                                              ; CODE XREF: Boss_ValkirieChargeUpdate+50   j
                                        ; Boss_ValkirieChargeUpdate+56   j
                bsr.w   Projectile_ValkirieBullet
                movea.l $41C(a5),a1
                bra.w   Boss_ValkirieBattleStart
; End of function Boss_ValkirieChargeUpdate
; ---------------------------------------------------------------------------
word_55C64:     dc.w    $4D, $7840, $CB60, $F808, $F808, $CBC0, $FA06, $FA06, $CC20, $FA06, $FA06, $CCE0, $FC04, $FC04, 0
                                        ; DATA XREF: Boss_ValkirieChargeAttack+B6   o
word_55C82:     dc.w    $BF00, $540, $600, $6C0, 0
                                        ; DATA XREF: Boss_ValkirieChargeUpdate+40   o

; Bullet projectile handler
Projectile_ValkirieBullet:                              ; CODE XREF: Boss_ValkirieChargeAttack+88   p  ; was: sub_55C8C
                                        ; sub_55BF0:loc_55C58   p
                movea.w #(byte_FFCCE0-M68K_RAM),a1
                moveq   #$18,d3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_55CA2
                jsr     (Projectile_FindFreeSlot).l
                beq.s   loc_55CA4
locret_55CA2:                                           ; CODE XREF: Projectile_ValkirieBullet+C   j
                rts
; ---------------------------------------------------------------------------
loc_55CA4:                                              ; CODE XREF: Projectile_ValkirieBullet+14   j
                moveq   #0,d4
                jmp     Projectile_CopyValkirieData
; ---------------------------------------------------------------------------
loc_55CAC:                                              ; CODE XREF: Boss_ValkirieShootPattern1+30   j
                move.w  #$14,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CC20,d0
                move.w  #$CC80,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
                move.w  #$53,$11C(a5)                   ; 'S'
                bsr.w   Boss_ValkirieMovePattern1
; End of function Projectile_ValkirieBullet
; Checks if boss takes damage
Boss_ValkirieDamageCheck:                               ; DATA XREF: ROM:000557CE   o  ; was: sub_55CD6
                tst.w   $58(a5)
                bmi.w   loc_55D1A
                bclr    #3,$23E(a5)
                beq.s   loc_55CF2
                move.w  #$CC80,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
loc_55CF2:                                              ; CODE XREF: Boss_ValkirieDamageCheck+E   j
                bclr    #0,$23E(a5)
                beq.s   loc_55D04
                move.b  #$4F,d0                         ; 'O'
                jsr     (Sound_PlaySFX).l
loc_55D04:                                              ; CODE XREF: Boss_ValkirieDamageCheck+22   j
                subq.w  #1,$11C(a5)
                bne.s   loc_55D10
                bset    #4,(byte_FFC9DE).w
loc_55D10:                                              ; CODE XREF: Boss_ValkirieDamageCheck+32   j
                lea     word_562CA(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55D1A:                                              ; CODE XREF: Boss_ValkirieDamageCheck+4   j
                bset    #7,(byte_FFC9DE).w
                move.w  #$24,4(a5)                      ; '$'
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Camera state 8 for boss battle tracking
Camera_BossMode_State8:                                 ; DATA XREF: ROM:000557DE   o  ; was: loc_55D34
                moveq   #0,d1
                move.w  (word_FFD1D0).w,d0
                sub.w   $4F0(a5),d0
                bpl.s   loc_55D42
                neg.w   d0
loc_55D42:                                              ; CODE XREF: Boss_ValkirieDamageCheck+68   j
                cmpi.w  #$10,d0
                bpl.s   loc_55D4A
                addq.w  #1,d1
loc_55D4A:                                              ; CODE XREF: Boss_ValkirieDamageCheck+70   j
                move.w  (word_FFD1D4).w,d0
                sub.w   $4F4(a5),d0
                bpl.s   loc_55D56
                neg.w   d0
loc_55D56:                                              ; CODE XREF: Boss_ValkirieDamageCheck+7C   j
                cmpi.w  #$10,d0
                bpl.s   loc_55D60
                tst.w   d1
                bne.s   loc_55D6A
loc_55D60:                                              ; CODE XREF: Boss_ValkirieDamageCheck+84   j
                lea     word_562F0(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55D6A:                                              ; CODE XREF: Boss_ValkirieDamageCheck+88   j
                bset    #5,(byte_FFC9DE).w
                bra.w   loc_55930
; End of function Boss_ValkirieDamageCheck
; Collision detection with player
Boss_ValkirieCollisionCheck:                            ; CODE XREF: Boss_ValkirieShootPattern1+14   j  ; was: sub_55D74
                                        ; Boss_ValkirieChargeUpdate+64   j
                move.w  #$12,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #4,d0
                move.w  d0,$11C(a5)
                lea     word_55E5E(pc),a0
                nop
                bsr.w   Boss_ValkirieDestroyParts
                clr.w   $54(a5)
                tst.w   d1
                bmi.s   loc_55DAE
                move.w  #$100,$54(a5)
loc_55DAE:                                              ; CODE XREF: Boss_ValkirieCollisionCheck+32   j
                move.w  #$C6E0,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile1
                lea     word_56390(pc),a1
                nop
                bsr.w   Boss_ValkirieBattleStart
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bra.w   Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieCollisionCheck
; Updates boss health
Boss_ValkirieUpdateHealth:                              ; DATA XREF: ROM:000557CC   o  ; was: sub_55DD0
                bclr    #0,$23E(a5)
                beq.s   loc_55DEC
                lea     word_55E40(pc),a0
                nop
                bsr.w   Boss_ValkirieUpdateParts
                move.b  #$C6,d0
                jsr     (Sound_PlaySFX).l
loc_55DEC:                                              ; CODE XREF: Boss_ValkirieUpdateHealth+6   j
                bclr    #1,$23E(a5)
                beq.s   loc_55E20
                subq.w  #1,$11C(a5)
                bmi.w   loc_55E2E
                jsr     Boss_ValkirieCheckFacing(pc)    ; (pc)
                nop
                bmi.w   loc_55E2E
                cmpi.w  #$80,d0
                bmi.s   loc_55E20
                btst    #0,(dword_FFFF08+1).w
                beq.w   loc_55E2E
                lea     word_55E5E(pc),a0
                nop
                bsr.w   Boss_ValkirieDestroyParts
loc_55E20:                                              ; CODE XREF: Boss_ValkirieUpdateHealth+22   j
                                        ; Boss_ValkirieUpdateHealth+3A   j
                bsr.w   Projectile_ValkirieBullet
                lea     word_56390(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55E2E:                                              ; CODE XREF: Boss_ValkirieUpdateHealth+28   j
                                        ; Boss_ValkirieUpdateHealth+32   j
                lea     word_55E5E(pc),a0
                nop
                bsr.w   Boss_ValkirieDestroyParts
                bsr.w   Boss_ValkirieSpawnEffect
                bra.w   loc_55930
; End of function Boss_ValkirieUpdateHealth
; ---------------------------------------------------------------------------
word_55E40:     dc.w    7, $3242, $CB60, $F808, $F808, $CBC0, $FA06, $FA06, $CC20, $FA06, $FA06, $CCE0, $FC04, $FC04, 0
                                        ; DATA XREF: Boss_ValkirieUpdateHealth+8   o
word_55E5E:     dc.w    $BD00, $540, $600, $6C0, 0
                                        ; DATA XREF: Boss_ValkirieCollisionCheck+22   o
                                        ; Boss_ValkirieUpdateHealth+46   o

; Checks damage flicker flag (bit 6 of $23E) and timing for visual effect
Boss_ValkirieFlickerCheck:
                tst.w   (word_FFFF0E).w                 ; was: sub_55E68
                beq.s   locret_55E7C
                bclr    #6,$23E(a5)
                beq.s   locret_55E7C
                btst    #0,(dword_FFFF08).w
locret_55E7C:                                           ; CODE XREF: Boss_ValkirieFlickerCheck+4   j
                                        ; Boss_ValkirieFlickerCheck+C   j
                rts
; End of function Boss_ValkirieFlickerCheck
; Spawns visual effect sprite from pointer table at $1BEFC
Boss_ValkirieSpawnEffect:                               ; CODE XREF: Boss_ValkirieChargeUpdate+A   p  ; was: sub_55E7E
                                        ; Boss_ValkirieUpdateHealth+68   p
                lea     (Boss_ValkirieEffectObjectInitTable).l,a1
                jmp     Object_InitGroupFromTable
; End of function Boss_ValkirieSpawnEffect
; Updates multiple Valkirie body parts with animation IDs, velocities, and flags from table
Boss_ValkirieUpdateParts:                               ; CODE XREF: Boss_ValkirieChargeAttack+BC   p  ; was: sub_55E8A
                                        ; Boss_ValkirieUpdateHealth+E   p
                move.w  (a0)+,d1
                moveq   #0,d2
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                ext.w   d2
                swap    d2
                asr.l   #4,d2
                tst.w   $54(a5)
                bne.s   loc_55EA0
                neg.l   d2
loc_55EA0:                                              ; CODE XREF: Boss_ValkirieUpdateParts+12   j
                                        ; Boss_ValkirieUpdateParts+2C   j
                move.w  (a0)+,d0
                beq.s   locret_55EB8
                movea.w d0,a1
                move.w  d1,$26(a1)
                move.l  d2,$18(a1)
                or.b    d3,$21(a1)
                move.l  (a0)+,$2C(a1)
                bra.s   loc_55EA0
; ---------------------------------------------------------------------------
locret_55EB8:                                           ; CODE XREF: Boss_ValkirieUpdateParts+18   j
                rts
; End of function Boss_ValkirieUpdateParts
; Destroys boss parts on defeat
Boss_ValkirieDestroyParts:                              ; CODE XREF: Boss_ValkirieChargeUpdate+46   p  ; was: sub_55EBA
                                        ; Boss_ValkirieCollisionCheck+28   p
                move.b  (a0)+,d1
                move.b  (a0)+,d2
loc_55EBE:                                              ; CODE XREF: Boss_ValkirieDestroyParts+12   j
                move.w  (a0)+,d0
                beq.s   locret_55ECE
                movea.w d0,a1
                and.b   d1,-$39BF(a1)
                clr.l   -$39C8(a1)
                bra.s   loc_55EBE
; ---------------------------------------------------------------------------
locret_55ECE:                                           ; CODE XREF: Boss_ValkirieDestroyParts+6   j
                rts
; End of function Boss_ValkirieDestroyParts
; Shooting pattern 2
Boss_ValkirieShootPattern2:                             ; CODE XREF: Boss_ValkirieShootPattern1+3C   j  ; was: sub_55ED0
                move.w  #$18,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w   Boss_ValkirieSpawnProjectile2
; End of function Boss_ValkirieShootPattern2
; Shooting pattern 3
Boss_ValkirieShootPattern3:                             ; DATA XREF: ROM:000557D2   o  ; was: sub_55EF0
                bclr    #0,$23E(a5)
                bne.s   loc_55F02
                lea     word_562FA(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F02:                                              ; CODE XREF: Boss_ValkirieShootPattern3+6   j
                addq.w  #2,4(a5)
; Camera state 6 for boss battle positioning
Camera_BossMode_State6:                                 ; DATA XREF: ROM:000557D4   o  ; was: loc_55F06
                bclr    #0,$23E(a5)
                bne.s   loc_55F18
                lea     word_562FA(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F18:                                              ; CODE XREF: Boss_ValkirieShootPattern3+1C   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.w  #3,(word_FFA010).w
                move.b  #$A0,d0
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_ValkirieSetPartFlash
; End of function Boss_ValkirieShootPattern3
; Spawns projectile type 3
Boss_ValkirieSpawnProjectile3:                          ; DATA XREF: ROM:000557D6   o  ; was: sub_55F34
                bclr    #0,$23E(a5)
                bne.s   loc_55F4E
                addq.w  #6,$11C(a5)
                bsr.w   Boss_ValkirieUpdatePartOffsets
                lea     word_562FA(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F4E:                                              ; CODE XREF: Boss_ValkirieSpawnProjectile3+6   j
                addq.w  #2,4(a5)
                bclr    #6,$2C1(a5)
; Camera state 7 for boss battle adjustment
Camera_BossMode_State7:                                 ; DATA XREF: ROM:000557D8   o  ; was: loc_55F58
                subi.w  #$A,$11C(a5)
                bmi.s   loc_55F6E
                bsr.w   Boss_ValkirieUpdatePartOffsets
                lea     word_562FA(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F6E:                                              ; CODE XREF: Boss_ValkirieSpawnProjectile3+2A   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  $2F2(a5),$2F4(a5)
                move.w  $352(a5),$354(a5)
                move.b  #$F1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ValkirieSpawnProjectile3
; Spawns projectile type 4
Boss_ValkirieSpawnProjectile4:                          ; DATA XREF: ROM:000557DA   o  ; was: sub_55F96
                tst.w   $58(a5)
                bmi.w   loc_55930
                lea     word_56322(pc),a1
                nop
                bra.w   Boss_ValkirieBattleStart
; End of function Boss_ValkirieSpawnProjectile4
; Updates Y-offsets of parts at $2F4 and $354 based on base offset $11C
Boss_ValkirieUpdatePartOffsets:                         ; CODE XREF: Boss_ValkirieSpawnProjectile3+C   p  ; was: sub_55FA8
                                        ; Boss_ValkirieSpawnProjectile3+2C   p
                move.w  $11C(a5),d0
                move.w  $2F2(a5),d1
                add.w   d0,d1
                move.w  d1,$2F4(a5)
                move.w  $352(a5),d1
                add.w   d0,d1
                move.w  d1,$354(a5)
                rts
; End of function Boss_ValkirieUpdatePartOffsets
; Sets part flash effect flag, duration ($64 frames), and velocity values
Boss_ValkirieSetPartFlash:                              ; CODE XREF: Boss_ValkirieShootPattern3+40   p  ; was: sub_55FC2
                bset    #6,$2C1(a5)
                move.w  #$64,$2C6(a5)                   ; 'd'
                move.l  #$F808F808,$2CC(a5)
                rts
; End of function Boss_ValkirieSetPartFlash
; Sets X-velocity from d0, negates if facing flag ($54) indicates left direction
Boss_ValkirieSetVelocityFacing:                         ; CODE XREF: Boss_ValkirieAttackDecision:loc_55A28   p  ; was: sub_55FD8
                                        ; Boss_ValkirieAttackDecision+82   p
                tst.w   $54(a5)
                beq.s   loc_55FE0
                neg.l   d0
loc_55FE0:                                              ; CODE XREF: Boss_ValkirieSetVelocityFacing+4   j
                move.l  d0,$18(a5)
                rts
; End of function Boss_ValkirieSetVelocityFacing
; Spawns projectile type 1
Boss_ValkirieSpawnProjectile1:                          ; CODE XREF: Boss_ValkirieAttackState1+40   p  ; was: sub_55FE6
                                        ; Boss_ValkirieShootPattern1+86   p
                move.w  #$140,d4
                bsr.s   Boss_ValkirieSpawnProjectile2
                move.w  d4,$14(a0)
                rts
; End of function Boss_ValkirieSpawnProjectile1
; Spawns projectile type 2
Boss_ValkirieSpawnProjectile2:                          ; CODE XREF: Boss_ValkirieAttackDecision+70   p  ; was: sub_55FF2
                                        ; Boss_ValkirieChargeAttack+20   p
                moveq   #0,d2
                movea.w $48(a5),a0
                bclr    d2,2(a0)
                movea.w $4A(a5),a0
                bclr    d2,2(a0)
                move.w  d0,$48(a5)
                move.w  d1,$4A(a5)
                movea.w d0,a0
                bset    d2,2(a0)
                movea.w d1,a0
                bset    d2,2(a0)
                rts
; End of function Boss_ValkirieSpawnProjectile2
; Checks player facing direction
Boss_ValkirieCheckFacing:                               ; CODE XREF: Boss_ValkirieAttackDecision+12   p  ; was: sub_5601A
                                        ; Boss_ValkirieChargeUpdate+58   p
                jsr     (Physics_GetPlayerDelta).l
                tst.w   $54(a5)
                beq.s   loc_5602E
                tst.w   d1
                bmi.s   loc_56032
loc_5602A:                                              ; CODE XREF: Boss_ValkirieCheckFacing+16   j
                moveq   #1,d3
                rts
; ---------------------------------------------------------------------------
loc_5602E:                                              ; CODE XREF: Boss_ValkirieCheckFacing+A   j
                tst.w   d1
                bmi.s   loc_5602A
loc_56032:                                              ; CODE XREF: Boss_ValkirieCheckFacing+E   j
                moveq   #$FFFFFFFF,d3
                rts
; End of function Boss_ValkirieCheckFacing
; Sets boss facing direction
Boss_ValkirieSetFacing:                                 ; CODE XREF: Boss_ValkirieShootPattern1:loc_559AA   p  ; was: sub_56036
                                        ; Boss_ArtemisSpawnProjectile6+6   p
                jsr     (Physics_GetPlayerDelta).l
                clr.w   $54(a5)
                tst.w   d1
                bmi.s   locret_5604A
                move.w  #$100,$54(a5)
locret_5604A:                                           ; CODE XREF: Boss_ValkirieSetFacing+C   j
                rts
; End of function Boss_ValkirieSetFacing
; Battle start initialization
Boss_ValkirieBattleStart:                               ; CODE XREF: Boss_ValkirieInitParts+2E   j  ; was: sub_5604C
                                        ; Boss_ValkirieIdleState+52   j
                bsr.w   Boss_ValkirieAnimationScript
                bsr.w   Boss_ValkirieUpdateSprites
                moveq   #$18,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieBattleStart
; Updates boss sprites
