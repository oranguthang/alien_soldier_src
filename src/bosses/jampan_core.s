Boss_JampanFlashToggle:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_49100
                tst.w   (word_FF808C).w
                bpl.s   loc_49126
                bset    #7,2(a5)
                move.w  $4A(a5),d0
                andi.w  #1,d0
                cmp.w   $48(a5),d0
                beq.s   loc_49120
                bclr    #7,2(a5)
loc_49120:                                              ; CODE XREF: Boss_JampanFlashToggle+18   j
                subq.w  #1,$4A(a5)
                bpl.s   locret_4912C
loc_49126:                                              ; CODE XREF: Boss_JampanFlashToggle+4   j
                bset    #4,2(a5)
locret_4912C:                                           ; CODE XREF: Boss_JampanFlashToggle+24   j
                rts
; End of function Boss_JampanFlashToggle
; Main boss handler
Boss_JampanMain:                                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4912E
                bsr.w   Boss_JampanDispatcher
                bsr.w   Boss_JampanCheckHealth
                rts
; End of function Boss_JampanMain
; Boss state dispatcher
Boss_JampanDispatcher:                                  ; CODE XREF: Boss_JampanMain   p  ; was: sub_49138
                tst.w   4(a5)
                beq.w   loc_491CA
                btst    #1,$4C(a5)
                bne.s   loc_4915C
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4915C
                move.w  $4E(a5),d0
                beq.s   loc_4915C
                sub.w   d0,(word_FF8234).w
loc_4915C:                                              ; CODE XREF: Boss_JampanDispatcher+E   j
                                        ; Boss_JampanDispatcher+18   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4918E
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4918E
                tst.w   (word_FF8200).w
                bne.s   loc_4918E
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                clr.l   (dword_FF8240).w
                move.w  #$52,4(a5)                      ; 'R'
                bset    #0,(byte_FFA272).w
loc_4918E:                                              ; CODE XREF: Boss_JampanDispatcher+2A   j
                                        ; Boss_JampanDispatcher+32   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$58(a5)
                btst    #2,$4C(a5)
                beq.s   loc_491CA
                tst.l   $54(a5)
                beq.s   loc_491CA
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_491BE
                neg.l   d0
loc_491BE:                                              ; CODE XREF: Boss_JampanDispatcher+82   j
                cmpi.l  #$10000,d0
                bne.s   loc_491CA
                neg.l   $54(a5)
loc_491CA:                                              ; CODE XREF: Boss_JampanDispatcher+4   j
                                        ; Boss_JampanDispatcher+6E   j
                move.w  4(a5),d0
                lea     off_491D6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanDispatcher
; ---------------------------------------------------------------------------
off_491D6:      dc.w    Boss_JampanIdleState-*          ; DATA XREF: Boss_JampanDispatcher+96   o
                dc.w    Boss_JampanMoveState-*
                dc.w    Boss_JampanDefendState-*
                dc.w    Boss_JampanJumpState-*
                dc.w    Boss_JampanDashState-*
                dc.w    Boss_JampanShootProjectile-*
                dc.w    Boss_JampanSpawnMinion-*
                dc.w    Projectile_JampanBullet-*
                dc.w    Projectile_JampanWave-*
                dc.w    Projectile_JampanHoming-*
                dc.w    Enemy_JampanMinion-*
                dc.w    Boss_JampanReturnToIdle-*
                dc.w    Boss_JampanBounceAttack-*
                dc.w    Boss_JampanHorizontalDrift-*
                dc.w    Boss_JampanWaitScreenShake-*
                dc.w    Boss_JampanCenterHorizontal-*
                dc.w    Boss_JampanDescendToHeight-*
                dc.w    Boss_JampanDefeatInit-*
                dc.w    Boss_JampanDefeatTeleport-*
                dc.w    Boss_JampanDefeatFade-*
                dc.w    Boss_JampanTeleportAttempt-*
                dc.w    nullsub_98-*
                dc.w    nullsub_99-*
                dc.w    Boss_JampanWaitVelocityStop-*
                dc.w    Boss_JampanPreAttackDelay-*
                dc.w    Boss_JampanAttackWarmup-*
                dc.w    Boss_JampanAttackPrepare-*
                dc.w    Boss_JampanAttackRiseUp-*
                dc.w    Boss_JampanAttackDescend-*
                dc.w    Boss_JampanAttackFinish-*
                dc.w    Boss_JampanPostAttackDelay-*
                dc.w    Boss_JampanResetFromAttack-*
                dc.w    Boss_JampanDefeatTransition-*
                dc.w    Boss_JampanDefeatFadeout-*
                dc.w    Boss_JampanDefeatInitAlt-*
                dc.w    Boss_JampanDefeatWait-*
                dc.w    Boss_JampanReturnToCenter-*
                dc.w    Boss_JampanWaitRotation-*
                dc.w    Boss_JampanDebrisFadeout-*
                dc.w    Boss_JampanRotateToCenter-*
                dc.w    nullsub_100-*
                dc.w    Boss_JampanDefeatFlash-*
                dc.w    Boss_JampanDefeatShake-*
                dc.w    Boss_JampanDefeatBreakup-*
                dc.w    Boss_JampanDefeatSparkInit-*
                dc.w    Boss_JampanDefeatSparkMove-*
                dc.w    Boss_JampanDefeatSparkFade-*
                dc.w    Boss_JampanDefeatSparkWait-*
                dc.w    Boss_JampanDefeatEndInit-*
                dc.w    Boss_JampanDefeatEndFade-*
                dc.w    Boss_JampanDefeatCleanupInit-*
                dc.w    Boss_JampanDefeatCleanupWait-*
                dc.w    nullsub_101-*

; Idle state handler
Boss_JampanIdleState:                                   ; DATA XREF: ROM:off_491D6   o  ; was: sub_49240
                tst.w   (word_FFF720).w
                bmi.s   locret_49256
                addq.w  #2,4(a5)
                move.w  #$218,d0
                moveq   #0,d1
                jmp     Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
locret_49256:                                           ; CODE XREF: Boss_JampanIdleState+4   j
                rts
; End of function Boss_JampanIdleState
; Movement state handler
Boss_JampanMoveState:                                   ; DATA XREF: ROM:000491D8   o  ; was: sub_49258
                move.b  #1,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                clr.l   (dword_FF9418).w
                clr.l   (dword_FF941C).w
                clr.l   (dword_FF9420).w
                clr.w   (dword_FF9424).w
                clr.w   (dword_FF9424+2).w
                clr.w   (dword_FF9428).w
                clr.w   (dword_FF9428+2).w
                clr.w   (dword_FF942C).w
                bsr.w   Boss_JampanAttackState
                move.b  #4,(byte_FFA420).w
                move.w  #$1E8,$10(a5)
                move.w  #$F0,$14(a5)
                move.w  #$100,(dword_FF9404).w
                move.w  #$100,(dword_FF9408).w
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$D00,2(a5)
                move.b  #$10,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$F010F010,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$20,$24(a5)                    ; ' '
loc_492F4:                                              ; CODE XREF: Boss_JampanDefeatEndFade+12   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                lea     $60(a0),a0
                move.w  #$224,(a0)
                move.w  #$4D00,2(a0)
                move.l  #word_EC25C,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C8C0,$50(a0)
                lea     $60(a0),a0
                move.w  #$220,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC244,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C8C0,$50(a0)
                lea     $60(a0),a0
                move.w  #$224,(a0)
                move.w  #$4D00,2(a0)
                move.l  #word_EC25C,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C920,$50(a0)
                lea     $60(a0),a0
                move.w  #$220,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC244,8(a0)
                move.w  #$6B00,$E(a0)
                move.b  #4,$20(a0)
                move.w  #$C920,$50(a0)
                lea     $60(a0),a0
                move.w  #$228,(a0)
                move.w  #$100,2(a0)
                lea     $60(a0),a0
                move.w  #$F,d7
                clr.w   d1
loc_493B0:                                              ; CODE XREF: Boss_JampanMoveState+1B8   j
                move.w  #$CD00,2(a0)
                move.w  #$6B00,$E(a0)
                move.w  d1,d0
                add.w   d0,d0
                lea     word_4945E(pc),a1
                nop
                move.w  (a1,d0.w),(a0)
                lea     word_4949E(pc),a1
                nop
                move.w  (a1,d0.w),$48(a0)
                lea     word_4947E(pc),a1
                nop
                move.w  (a1,d0.w),d2
                or.w    d2,$E(a0)
                lea     word_494BE(pc),a1
                nop
                move.w  (a1,d0.w),$4A(a0)
                lea     word_494DE(pc),a1
                nop
                move.w  (a1,d0.w),$4C(a0)
                add.w   d0,d0
                lea     off_494FE(pc),a1
                nop
                move.l  (a1,d0.w),8(a0)
                addq.w  #1,d1
                lea     $60(a0),a0
                dbf     d7,loc_493B0
                move.w  #5,d7
                clr.w   d1
loc_4941A:                                              ; CODE XREF: Boss_JampanMoveState+1DE   j
                move.w  #$10,(a0)
                move.w  #$4D00,2(a0)
                move.w  #$6B00,$E(a0)
                move.l  #word_EC238,8(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4941A
                bsr.w   Boss_JampanDamageHandler
                rts
; End of function Boss_JampanMoveState
; Attack state handler
Boss_JampanAttackState:                                 ; CODE XREF: Boss_JampanMoveState+4C   p  ; was: sub_49440
                lea     word_4944E(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                rts
; End of function Boss_JampanAttackState
; ---------------------------------------------------------------------------
word_4944E:     dc.w    $6100, $2000, $202, $7879, $7A7C, $7D7E, $8081, 0
                                        ; DATA XREF: Boss_JampanAttackState   o
word_4945E:     dc.w    $234, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
                                        ; DATA XREF: Boss_JampanMoveState+168   o
word_4947E:     dc.w    0, 0, 0, $1000, $1000, $1000, $1000, $1000, $1000, $1000, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_JampanMoveState+17E   o
word_4949E:     dc.w    $24, $30, $30, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24
                                        ; DATA XREF: Boss_JampanMoveState+172   o
word_494BE:     dc.w    $80, $A8, $58, $20, $40, $60, $80, $A0, $C0, $E0, $30, $50, $70, $90, $B0, $D0
                                        ; DATA XREF: Boss_JampanMoveState+18C   o
word_494DE:     dc.w    $FFE0, $FF80, $FF80, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40
                                        ; DATA XREF: Boss_JampanMoveState+198   o
off_494FE:      dc.l    word_EC238                      ; DATA XREF: Boss_JampanMoveState+1A6   o
                dc.l    word_EC250
                dc.l    word_EC250
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C
                dc.l    word_EC28C

; Defense state handler
Boss_JampanDefendState:                                 ; DATA XREF: ROM:000491DA   o  ; was: sub_4953E
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_4956E
                bsr.w   Boss_JampanDamageHandler
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #4,(dword_FF9410).w
                move.w  #4,(dword_FF9414).w
                move.w  #3,$48(a5)
                addq.w  #2,4(a5)
locret_4956E:                                           ; CODE XREF: Boss_JampanDefendState+8   j
                rts
; End of function Boss_JampanDefendState
; Jump state handler
Boss_JampanJumpState:                                   ; DATA XREF: ROM:000491DC   o  ; was: sub_49570
                addi.l  #$2000,$1C(a5)
                addi.l  #-$10000,$10(a5)
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_495C4
                move.w  #$110,$14(a5)
                andi.l  #$FFFF0000,$14(a5)
                move.l  $1C(a5),d0
                neg.l   d0
                addi.l  #$2000,d0
                move.l  d0,$1C(a5)
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
locret_495C4:                                           ; CODE XREF: Boss_JampanJumpState+1A   j
                rts
; End of function Boss_JampanJumpState
; Dash attack state
Boss_JampanDashState:                                   ; DATA XREF: ROM:000491DE   o  ; was: sub_495C6
                addi.l  #$2000,$1C(a5)
                addi.l  #-$10000,$10(a5)
                bsr.w   Boss_JampanDamageHandler
                tst.l   $1C(a5)
                bne.s   locret_4960E
                subq.w  #1,$48(a5)
                beq.s   loc_495EC
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_495EC:                                              ; CODE XREF: Boss_JampanDashState+1E   j
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                clr.w   (dword_FF9410).w
                clr.w   (dword_FF9414).w
                addq.w  #2,4(a5)
locret_4960E:                                           ; CODE XREF: Boss_JampanDashState+18   j
                rts
; End of function Boss_JampanDashState
; Shoots projectile
Boss_JampanShootProjectile:                             ; DATA XREF: ROM:000491E0   o  ; was: sub_49610
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$100,(dword_FF9404).w
                beq.s   loc_49638
                cmpi.w  #$100,(dword_FF9404).w
                bcs.s   loc_4962E
                subq.w  #4,(dword_FF9404).w
                subq.w  #4,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_4962E:                                              ; CODE XREF: Boss_JampanShootProjectile+12   j
                addq.w  #4,(dword_FF9404).w
                addq.w  #4,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_49638:                                              ; CODE XREF: Boss_JampanShootProjectile+A   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanShootProjectile
; Spawns minion enemy
Boss_JampanSpawnMinion:                                 ; DATA XREF: ROM:000491E2   o  ; was: sub_4964A
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_49664
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                addq.w  #2,4(a5)
locret_49664:                                           ; CODE XREF: Boss_JampanSpawnMinion+C   j
                rts
; End of function Boss_JampanSpawnMinion
; Bullet projectile handler
Projectile_JampanBullet:                                ; DATA XREF: ROM:000491E4   o  ; was: sub_49666
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                move.w  (dword_FF9424+2).w,d0
                beq.s   loc_49684
                tst.w   d0
                bmi.s   loc_4967E
                subq.w  #1,(dword_FF9424+2).w
                rts
; ---------------------------------------------------------------------------
loc_4967E:                                              ; CODE XREF: Projectile_JampanBullet+10   j
                addq.w  #1,(dword_FF9424+2).w
                rts
; ---------------------------------------------------------------------------
loc_49684:                                              ; CODE XREF: Projectile_JampanBullet+C   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Input_CheckButtonMode).l
                rts
; End of function Projectile_JampanBullet
; Wave projectile handler
Projectile_JampanWave:                                  ; DATA XREF: ROM:000491E6   o  ; was: sub_496AA
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FF80C2).w
                bne.s   locret_496CC
                clr.b   (byte_FF80EC).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                addq.w  #2,4(a5)
locret_496CC:                                           ; CODE XREF: Projectile_JampanWave+C   j
                rts
; End of function Projectile_JampanWave
; Homing projectile handler
Projectile_JampanHoming:                                ; DATA XREF: ROM:000491E8   o  ; was: sub_496CE
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_496EC
                move.w  #1,(word_FFC852).w
                move.w  #1,(word_FFC8B2).w
                addq.w  #2,4(a5)
locret_496EC:                                           ; CODE XREF: Projectile_JampanHoming+C   j
                rts
; End of function Projectile_JampanHoming
; Minion enemy handler
Enemy_JampanMinion:                                     ; DATA XREF: ROM:000491EA   o  ; was: sub_496EE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanTeleportInit
                bsr.w   nullsub_97
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FF8234).w
                ble.w   loc_49790
                move.w  (word_FFA000).w,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4971E
                andi.w  #$3F,d0                         ; '?'
                bne.w   locret_497A8
                bra.s   loc_49726
; ---------------------------------------------------------------------------
loc_4971E:                                              ; CODE XREF: Enemy_JampanMinion+24   j
                andi.w  #$1F,d0
                bne.w   locret_497A8
loc_49726:                                              ; CODE XREF: Enemy_JampanMinion+2E   j
                move.b  (dword_FFFF08).w,d0
                andi.b  #7,d0
                beq.s   loc_4975E
                cmpi.w  #1,d0
                beq.s   loc_49750
                cmpi.w  #2,d0
                beq.s   loc_49782
                bset    #1,$4C(a5)
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                rts
; ---------------------------------------------------------------------------
loc_49750:                                              ; CODE XREF: Enemy_JampanMinion+46   j
                move.w  #2,$4E(a5)
                move.w  #$22,4(a5)                      ; '"'
                rts
; ---------------------------------------------------------------------------
loc_4975E:                                              ; CODE XREF: Enemy_JampanMinion+40   j
                clr.w   (word_FFC8B2).w
                move.w  #$FFFF,(word_FFC6D2).w
                move.w  #$FFFF,(word_FFC792).w
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,$4E(a5)
                move.w  #$2E,4(a5)                      ; '.'
                rts
; ---------------------------------------------------------------------------
loc_49782:                                              ; CODE XREF: Enemy_JampanMinion+4C   j
                move.w  #$A,$4E(a5)
                move.w  #$3E,4(a5)                      ; '>'
                rts
; ---------------------------------------------------------------------------
loc_49790:                                              ; CODE XREF: Enemy_JampanMinion+18   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                bset    #1,$4C(a5)
                move.w  #$16,4(a5)
locret_497A8:                                           ; CODE XREF: Enemy_JampanMinion+2A   j
                                        ; Enemy_JampanMinion+34   j
                rts
; End of function Enemy_JampanMinion
; Returns boss to idle after velocity dampening
Boss_JampanReturnToIdle:                                ; DATA XREF: ROM:000491EC   o  ; was: sub_497AA
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9424+2).w
                beq.s   loc_497C4
                tst.w   (dword_FF9424+2).w
                bpl.s   loc_497C0
                addq.w  #1,(dword_FF9424+2).w
                bra.s   loc_497C4
; ---------------------------------------------------------------------------
loc_497C0:                                              ; CODE XREF: Boss_JampanReturnToIdle+E   j
                subq.w  #1,(dword_FF9424+2).w
loc_497C4:                                              ; CODE XREF: Boss_JampanReturnToIdle+8   j
                                        ; Boss_JampanReturnToIdle+14   j
                tst.w   (dword_FF9428).w
                beq.s   loc_497DC
                tst.w   (dword_FF9428).w
                bpl.s   loc_497D6
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_497D6:                                              ; CODE XREF: Boss_JampanReturnToIdle+24   j
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_497DC:                                              ; CODE XREF: Boss_JampanReturnToIdle+1E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_497FC
                bclr    #2,$4C(a5)
                clr.l   $54(a5)
                move.w  #1,$1C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_497FC:                                           ; CODE XREF: Boss_JampanReturnToIdle+36   j
                rts
; End of function Boss_JampanReturnToIdle
; Handles bounce attack with gravity and collision
Boss_JampanBounceAttack:                                ; DATA XREF: ROM:000491EE   o  ; was: sub_497FE
                bsr.w   Boss_JampanDamageHandler
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_49860
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$110,$14(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $1C(a5)
                beq.s   loc_49846
                subq.w  #1,$48(a5)
                bne.s   locret_49860
loc_49846:                                              ; CODE XREF: Boss_JampanBounceAttack+40   j
                clr.l   $1C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$FFFE,(word_FFC6D2).w
                move.w  #$FFFE,(word_FFC792).w
                addq.w  #2,4(a5)
locret_49860:                                           ; CODE XREF: Boss_JampanBounceAttack+12   j
                                        ; Boss_JampanBounceAttack+46   j
                rts
; End of function Boss_JampanBounceAttack
; Adjusts horizontal position based on player
Boss_JampanHorizontalDrift:                             ; DATA XREF: ROM:000491F0   o  ; was: sub_49862
                cmpi.w  #$13A0,$58(a5)
                bcs.s   loc_49878
                subq.w  #2,(dword_FF9408).w
                subi.l  #$8000,$10(a5)
                bra.s   loc_49884
; ---------------------------------------------------------------------------
loc_49878:                                              ; CODE XREF: Boss_JampanHorizontalDrift+6   j
                addq.w  #2,(dword_FF9408).w
                addi.l  #$8000,$10(a5)
loc_49884:                                              ; CODE XREF: Boss_JampanHorizontalDrift+14   j
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(word_FF8234).w
                subq.w  #1,$48(a5)
                bne.s   locret_49896
                addq.w  #2,4(a5)
locret_49896:                                           ; CODE XREF: Boss_JampanHorizontalDrift+2E   j
                rts
; End of function Boss_JampanHorizontalDrift
; Waits for screen shake to complete
Boss_JampanWaitScreenShake:                             ; DATA XREF: ROM:000491F2   o  ; was: sub_49898
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.s   locret_498BE
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                addq.w  #2,4(a5)
locret_498BE:                                           ; CODE XREF: Boss_JampanWaitScreenShake+E   j
                rts
; End of function Boss_JampanWaitScreenShake
; Centers boss horizontally with oscillation
Boss_JampanCenterHorizontal:                            ; DATA XREF: ROM:000491F4   o  ; was: sub_498C0
                cmpi.w  #$100,(dword_FF9408).w
                bcc.s   loc_498D6
                addq.w  #2,(dword_FF9408).w
                addi.l  #$8000,$10(a5)
                bra.s   loc_498E2
; ---------------------------------------------------------------------------
loc_498D6:                                              ; CODE XREF: Boss_JampanCenterHorizontal+6   j
                subq.w  #2,(dword_FF9408).w
                subi.l  #$8000,$10(a5)
loc_498E2:                                              ; CODE XREF: Boss_JampanCenterHorizontal+14   j
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_498F0
                addq.w  #2,4(a5)
locret_498F0:                                           ; CODE XREF: Boss_JampanCenterHorizontal+2A   j
                rts
; End of function Boss_JampanCenterHorizontal
; Descends boss to Y position $F0
Boss_JampanDescendToHeight:                             ; DATA XREF: ROM:000491F6   o  ; was: sub_498F2
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$14(a5)
                cmpi.w  #$F0,$14(a5)
                bhi.s   locret_4992E
                move.w  #$F0,$14(a5)
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                bclr    #1,$4C(a5)
                move.w  #$12,4(a5)
locret_4992E:                                           ; CODE XREF: Boss_JampanDescendToHeight+12   j
                rts
; End of function Boss_JampanDescendToHeight
; Defeat sequence initialization
Boss_JampanDefeatInit:                                  ; DATA XREF: ROM:000491F8   o  ; was: sub_49930
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                clr.w   (word_FFC852).w
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatInit
; Defeat teleport effect
Boss_JampanDefeatTeleport:                              ; DATA XREF: ROM:000491FA   o  ; was: sub_49950
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49990
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                clr.w   (word_FFC8B2).w
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_49984
                move.w  #2,(word_FFC792).w
                move.w  #$FFFE,$5A(a5)
                rts
; ---------------------------------------------------------------------------
loc_49984:                                              ; CODE XREF: Boss_JampanDefeatTeleport+24   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,$5A(a5)
locret_49990:                                           ; CODE XREF: Boss_JampanDefeatTeleport+C   j
                rts
; End of function Boss_JampanDefeatTeleport
; Defeat fade out animation
Boss_JampanDefeatFade:                                  ; DATA XREF: ROM:000491FC   o  ; was: sub_49992
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                tst.w   (word_FFC6D2).w
                bne.s   locret_49A12
                tst.w   (word_FFC792).w
                bne.s   locret_49A12
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_49A12
                andi.w  #$7FFF,(word_FFC862).w
                move.w  #$238,(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC238,8(a0)
                move.w  #$EB00,$E(a0)
                move.l  (dword_FFC870).w,$10(a0)
                move.l  (dword_FFC874).w,$14(a0)
                move.b  #4,$20(a0)
                move.w  #$80,$26(a0)
                andi.w  #$7FFF,(word_FFC862).w
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_49A0C
                move.w  #$40,$48(a5)                    ; '@'
                rts
; ---------------------------------------------------------------------------
loc_49A0C:                                              ; CODE XREF: Boss_JampanDefeatFade+70   j
                move.w  #$10,$48(a5)
locret_49A12:                                           ; CODE XREF: Boss_JampanDefeatFade+10   j
                                        ; Boss_JampanDefeatFade+16   j
                rts
; End of function Boss_JampanDefeatFade
; Attempts teleport with position checks
