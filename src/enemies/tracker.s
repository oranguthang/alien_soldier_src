Enemy_TrackerMain:                                      ; DATA XREF: ROM:off_5DC   o  ; was: sub_32EE0
                lea     (word_FF9800).w,a4
                bsr.w   Enemy_TrackerDispatcher
                subq.w  #1,$5A(a5)
                beq.s   loc_32F24
                btst    #7,$22(a5)
                bne.s   loc_32F24
                tst.w   $24(a5)
                bmi.s   loc_32F04
                tst.w   (word_FF808C).w
                bmi.w   locret_330A4
loc_32F04:                                              ; CODE XREF: Enemy_TrackerMain+1A   j
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_32F24
                moveq   #9,d7
                moveq   #0,d0
                moveq   #1,d1
                move.w  (word_FF808A).w,d2
                jsr     (Enemy_SetProjectileDifficulty).l
loc_32F24:                                              ; CODE XREF: Enemy_TrackerMain+C   j
                                        ; Enemy_TrackerMain+14   j
                move.l  #off_E953C,8(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Enemy_TrackerMain
; Tracker enemy state dispatcher using jump table
Enemy_TrackerDispatcher:                                ; CODE XREF: Enemy_TrackerMain+4   p  ; was: sub_32F32
                movea.w 4(a5),a0
                lea     off_32F3E(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerDispatcher
; ---------------------------------------------------------------------------
off_32F3E:      dc.w    Enemy_TrackerSpawnWave-*        ; DATA XREF: Enemy_TrackerDispatcher+4   o
                dc.w    Enemy_TrackerFallState-*
                dc.w    Enemy_TrackerWaveMotion-*
                dc.w    Enemy_TrackerWaveMotion_Loop-*
                dc.w    Enemy_TrackerOffScreen-*
                dc.w    Enemy_TrackerSineWave-*
                dc.w    Enemy_TrackerSineWave_VerticalAccel-*
                dc.w    Enemy_TrackerReverse-*
                dc.w    locret_330A4-*
word_32F50:     dc.w    2, 4, $A, $E, 4, 4, 4, 4
                                        ; DATA XREF: Enemy_TrackerSpawnWave+A   r

; Spawns wave of tracker projectiles in formation pattern
Enemy_TrackerSpawnWave:                                 ; DATA XREF: ROM:off_32F3E   o  ; was: sub_32F60
                lea     (a5),a0
                move.w  $5E(a5),d7
                andi.w  #$FF,d7
                move.w  word_32F50(pc,d7.w),d5
                move.b  $5E(a5),d7
                moveq   #0,d6
loc_32F74:                                              ; CODE XREF: Enemy_TrackerSpawnWave+1E   j
                bsr.w   Enemy_TrackerInitProjectile
                jsr     (Projectile_UpdateTrajectory).l
                dbne    d7,loc_32F74
                rts
; End of function Enemy_TrackerSpawnWave
; Initializes individual tracker projectile with params
Enemy_TrackerInitProjectile:                            ; CODE XREF: Enemy_TrackerSpawnWave:loc_32F74   p  ; was: sub_32F84
                move.w  $5E(a5),$5E(a0)
                move.w  #$200,$5A(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                add.w   d6,$10(a0)
                move.w  d6,$5C(a0)
                addi.w  #$20,d6                         ; ' '
                move.w  d5,4(a0)
                move.w  #$3B4,(a0)
                move.w  #$ED00,2(a0)
                move.w  #$400,$E(a0)
                move.l  #off_EB3C8,8(a0)
                move.b  #$C0,$21(a0)
                move.w  #1,$24(a0)
                move.w  #$32,$26(a0)                    ; '2'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #$40,$20(a0)                    ; '@'
                move.b  #8,$23(a0)
                rts
; End of function Enemy_TrackerInitProjectile
; Tracker falling state with upward negative velocity
Enemy_TrackerFallState:                                 ; DATA XREF: ROM:00032F40   o  ; was: sub_32FF4
                move.l  #$FFFEC000,$18(a5)
                move.w  #8,4(a5)
                rts
; End of function Enemy_TrackerFallState
; Tracker enemy off-screen check marking for removal
Enemy_TrackerOffScreen:                                 ; CODE XREF: Enemy_TrackerWaveMotion:loc_33056   j  ; was: sub_33004
                                        ; Enemy_TrackerSineWave+24   j
                                        ; DATA XREF:
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcc.w   locret_330A4
                ori.w   #$1000,2(a5)
                rts
; End of function Enemy_TrackerOffScreen
; Tracker wave motion with oscillating vertical acceleration
Enemy_TrackerWaveMotion:                                ; DATA XREF: ROM:00032F42   o  ; was: sub_33016
                move.l  #$FFFF0000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$800,$5C(a5)
                addq.w  #2,4(a5)
; Execute wave motion pattern with acceleration reversal
Enemy_TrackerWaveMotion_Loop:                           ; DATA XREF: ROM:00032F44   o  ; was: loc_3303A
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_3304A
                neg.l   d0
loc_3304A:                                              ; CODE XREF: Enemy_TrackerWaveMotion+30   j
                cmpi.l  #$10000,d0
                bne.s   loc_33056
                neg.l   $5C(a5)
loc_33056:                                              ; CODE XREF: Enemy_TrackerWaveMotion+3A   j
                bra.w   Enemy_TrackerOffScreen
; End of function Enemy_TrackerWaveMotion
; Tracker sine wave motion with smooth oscillation
Enemy_TrackerSineWave:                                  ; DATA XREF: ROM:00032F48   o  ; was: sub_3305A
                move.l  #$FFFEC000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$1C0,$5C(a5)
                addq.w  #2,4(a5)
; Applies vertical acceleration during sine wave movement pattern
Enemy_TrackerSineWave_VerticalAccel:                    ; CODE XREF: Enemy_TrackerReverse+1C   j  ; was: loc_33076
                                        ; DATA XREF: ROM:00032F4A   o
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                bra.w   Enemy_TrackerOffScreen
; End of function Enemy_TrackerSineWave
; Tracker reverse motion returning to wave pattern
Enemy_TrackerReverse:                                   ; DATA XREF: ROM:00032F4C   o  ; was: sub_33082
                move.l  #$FFFEC000,$18(a5)
                subq.w  #1,$5C(a5)
                bpl.w   locret_330A4
                move.l  #$FFFFFE40,$5C(a5)
                subq.w  #2,4(a5)
                bra.s   Enemy_TrackerSineWave_VerticalAccel
; ---------------------------------------------------------------------------
                addq.w  #2,4(a5)
locret_330A4:                                           ; CODE XREF: Enemy_TrackerMain+20   j
                                        ; Enemy_TrackerOffScreen+6   j
                rts
; End of function Enemy_TrackerReverse
; Tracker enemy main (win cutscene)
Enemy_TrackerWinMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_330A6
                tst.w   4(a5)
                beq.s   loc_330BC
                cmpi.b  #$80,(byte_FFA958).w
                beq.s   loc_330BC
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_330BC:                                              ; CODE XREF: Enemy_TrackerWinMain+4   j
                                        ; Enemy_TrackerWinMain+C   j
                btst    #7,(dword_FF8062).w
                beq.s   loc_330D4
                btst    #7,(dword_FFA960).w
                beq.s   loc_330D4
                bclr    #0,(dword_FF9410).w
                bra.s   loc_330DA
; ---------------------------------------------------------------------------
loc_330D4:                                              ; CODE XREF: Enemy_TrackerWinMain+1C   j
                                        ; Enemy_TrackerWinMain+24   j
                bset    #0,(dword_FF9410).w
loc_330DA:                                              ; CODE XREF: Enemy_TrackerWinMain+2C   j
                bsr.w   Enemy_TrackerWinSpawnBullet
                move.w  4(a5),d0
                lea     off_330EA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerWinMain
; ---------------------------------------------------------------------------
off_330EA:      dc.w    Enemy_TrackerSt21State1-*       ; DATA XREF: Enemy_TrackerWinMain+3C   o
                dc.w    Enemy_TrackerSt21State2-*
                dc.w    Enemy_TrackerSt21SpawnInit-*
                dc.w    Enemy_TrackerSt21Attack2-*

; Tracker state 1 (Stage 21)
Enemy_TrackerSt21State1:                                ; DATA XREF: ROM:off_330EA   o  ; was: sub_330F2
                addq.w  #2,4(a5)
                move.w  #$E000,2(a5)
                move.l  #off_E9680,8(a5)
                move.w  #$8480,$E(a5)
                move.w  #$1B0,$10(a5)
                move.w  #$170,$14(a5)
                move.w  (dword_FFFF08).w,$5C(a5)
                andi.w  #3,$5C(a5)
                rts
; End of function Enemy_TrackerSt21State1
; Tracker state 2 (Stage 21)
Enemy_TrackerSt21State2:                                ; DATA XREF: ROM:000330EC   o  ; was: sub_33124
                btst    #0,(dword_FF9410).w
                bne.s   locret_33138
                cmpi.w  #$FFFC,(dword_FF8062).w
                bgt.s   locret_33138
                addq.w  #2,4(a5)
locret_33138:                                           ; CODE XREF: Enemy_TrackerSt21State2+6   j
                                        ; Enemy_TrackerSt21State2+E   j
                rts
; End of function Enemy_TrackerSt21State2
; Tracker spawn init (Stage 21)
Enemy_TrackerSt21SpawnInit:                             ; DATA XREF: ROM:000330EE   o  ; was: sub_3313A
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_331AC
                addq.w  #2,4(a5)
                bsr.w   Enemy_TrackerSt21Attack1
                bsr.w   Enemy_TrackerWinInitSprite
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #1,$5C(a5)
                move.w  $5C(a5),d0
                andi.w  #$3F,d0                         ; '?'
                add.w   d0,d0
                move.w  word_331AE(pc,d0.w),d0
                beq.s   loc_3318E
                move.l  #word_1CEC6C,8(a0)
                move.b  #1,$5E(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$E818E818,$28(a0)
                rts
; ---------------------------------------------------------------------------
loc_3318E:                                              ; CODE XREF: Enemy_TrackerSt21SpawnInit+32   j
                move.l  #word_1CEC90,8(a0)
                move.b  #0,$5E(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
locret_331AC:                                           ; CODE XREF: Enemy_TrackerSt21SpawnInit+6   j
                rts
; End of function Enemy_TrackerSt21SpawnInit
; ---------------------------------------------------------------------------
word_331AE:     dc.w    1, 0, 0, 0, 1, 0, 0, 0
                                        ; DATA XREF: Enemy_TrackerSt21SpawnInit+2E   r
                dc.w    1, 0, 0, 0, 0, 0, 0, 0
                dc.w    0, 0, 0, 1, 0, 0, 0, 1
                dc.w    0, 0, 0, 1, 0, 0, 0, 0
                dc.w    0, 1, 0, 0, 0, 1, 0, 0
                dc.w    0, 1, 0, 0, 0, 0, 0, 0
                dc.w    0, 0, 1, 0, 0, 0, 1, 0
                dc.w    0, 0, 1, 0, 0, 0, 1, 0

; Tracker attack 1 (Stage 21)
Enemy_TrackerSt21Attack1:                               ; CODE XREF: Enemy_TrackerSt21SpawnInit+C   p  ; was: sub_3322E
                move.l  (dword_FF8062).w,d0
                bpl.s   loc_33236
                neg.l   d0
loc_33236:                                              ; CODE XREF: Enemy_TrackerSt21Attack1+4   j
                swap    d0
                andi.w  #$E,d0
                move.w  word_33244(pc,d0.w),$48(a5)
                rts
; End of function Enemy_TrackerSt21Attack1
; ---------------------------------------------------------------------------
word_33244:     dc.w    $30, $20, $18, $10, $C, 8, 4, 2, 2, 2
                                        ; DATA XREF: Enemy_TrackerSt21Attack1+E   r

; Tracker attack 2 (Stage 21)
Enemy_TrackerSt21Attack2:                               ; DATA XREF: ROM:000330F0   o  ; was: sub_33258
                subq.w  #1,$48(a5)
                bne.s   locret_3328E
                lea     word_33290(pc),a1
                nop
                move.w  $5C(a5),d0
                andi.w  #3,d0
                lsl.w   #4,d0
                lea     (a1,d0.w),a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.w  (a1,d0.w),$10(a5)
                move.w  2(a1,d0.w),$14(a5)
                subq.w  #2,4(a5)
locret_3328E:                                           ; CODE XREF: Enemy_TrackerSt21Attack2+4   j
                rts
; End of function Enemy_TrackerSt21Attack2
; ---------------------------------------------------------------------------
word_33290:     dc.w    $B0, $170, $D0, $170, $F0, $170, $110, $170, $130, $170, $150, $170, $170, $170, $190, $170
                                        ; DATA XREF: Enemy_TrackerSt21Attack2+6   o
                dc.w    $1B0, $170, $1D0, $170, $1D0, $150, $1D0, $130, $1D0, $110, $1D0, $F0, $1D0, $D0, $1D0, $B0

; Tracker movement (win cutscene)
Enemy_TrackerWinMovement:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_332D0
                btst    #0,$5F(a5)
                bne.w   Enemy_TrackerWinFollow
                tst.w   4(a5)
                beq.s   loc_33346
                btst    #0,$5E(a5)
                bne.s   loc_3330E
                cmpi.l  #$FFFD8000,$18(a5)
                ble.s   loc_332FA
                addi.l  #-$2000,$18(a5)
loc_332FA:                                              ; CODE XREF: Enemy_TrackerWinMovement+20   j
                cmpi.l  #$FFFEC000,$1C(a5)
                ble.s   loc_33332
                addi.l  #-$2000,$1C(a5)
                bra.s   loc_33332
; ---------------------------------------------------------------------------
loc_3330E:                                              ; CODE XREF: Enemy_TrackerWinMovement+16   j
                cmpi.l  #$FFFE0000,$18(a5)
                ble.s   loc_33320
                addi.l  #-$2000,$18(a5)
loc_33320:                                              ; CODE XREF: Enemy_TrackerWinMovement+46   j
                cmpi.l  #$FFFF0000,$1C(a5)
                ble.s   loc_33332
                addi.l  #-$2000,$1C(a5)
loc_33332:                                              ; CODE XREF: Enemy_TrackerWinMovement+32   j
                                        ; Enemy_TrackerWinMovement+3C   j
                cmpi.w  #$60,$10(a5)                    ; '`'
                blt.w   Enemy_TrackerSt21OffScreen
                cmpi.w  #$60,$14(a5)                    ; '`'
                blt.w   Enemy_TrackerSt21OffScreen
loc_33346:                                              ; CODE XREF: Enemy_TrackerWinMovement+E   j
                move.w  4(a5),d0
                lea     off_33352(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_TrackerWinMovement
; ---------------------------------------------------------------------------
off_33352:      dc.w    Enemy_TrackerSt21Damage-*       ; DATA XREF: Enemy_TrackerWinMovement+7A   o
                dc.w    Enemy_TrackerSt21Damage_CheckCollision-*
                dc.w    nullsub_75-*

; Tracker damage (Stage 21)
Enemy_TrackerSt21Damage:                                ; DATA XREF: ROM:off_33352   o  ; was: sub_33358
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                btst    #0,$5E(a5)
                bne.s   loc_33380
                move.w  #$64,$26(a5)                    ; 'd'
                move.l  #$FFFD8000,$18(a5)
                move.l  #$FFFEC000,$1C(a5)
                bra.s   Enemy_TrackerSt21Damage_CheckCollision
; ---------------------------------------------------------------------------
loc_33380:                                              ; CODE XREF: Enemy_TrackerSt21Damage+E   j
                move.w  #$C8,$26(a5)
                move.l  #$FFFE0000,$18(a5)
                move.l  #$FFFF0000,$1C(a5)
; Handles collision detection and damage response for tracker enemy
Enemy_TrackerSt21Damage_CheckCollision:                 ; CODE XREF: Enemy_TrackerSt21Damage+26   j  ; was: loc_33396
                                        ; DATA XREF: ROM:00033354   o
                bclr    #7,$22(a5)
                beq.s   locret_333FE
                bclr    #4,$22(a5)
                beq.s   loc_333B4
                move.b  #$32,d0                         ; '2'
                jsr     (Sound_PlaySFX).l
                bsr.w   Enemy_TrackerSt21Destroy
loc_333B4:                                              ; CODE XREF: Enemy_TrackerSt21Damage+4C   j
                btst    #0,$5E(a5)
                bne.s   loc_333D6
                move.l  #$FFFFA000,$4C(a5)
                move.l  #$10000,$18(a5)
                move.l  #$FFFC0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_333D6:                                              ; CODE XREF: Enemy_TrackerSt21Damage+62   j
                move.l  #$FFFFE800,$4C(a5)
                move.l  #$FFFFE800,$50(a5)
                move.l  $18(a5),d0
                move.l  $1C(a5),d1
                neg.l   d0
                neg.l   d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
locret_333FE:                                           ; CODE XREF: Enemy_TrackerSt21Damage+44   j
                rts
; End of function Enemy_TrackerSt21Damage
nullsub_75:                                             ; DATA XREF: ROM:00033356   o
                rts
; End of function nullsub_75

; Tracker destroy (Stage 21)
Enemy_TrackerSt21Destroy:                               ; CODE XREF: Enemy_TrackerSt21Damage+58   p  ; was: sub_33402
                tst.w   $48(a5)
                bne.w   locret_334B0
                move.w  #1,$48(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_334B0
                tst.w   (word_FFFF0E).w
                beq.s   loc_33426
                move.w  #3,d1
                bra.s   loc_3342A
; ---------------------------------------------------------------------------
loc_33426:                                              ; CODE XREF: Enemy_TrackerSt21Destroy+1C   j
                move.w  #$F,d1
loc_3342A:                                              ; CODE XREF: Enemy_TrackerSt21Destroy+22   j
                move.b  (dword_FFFF08).w,d0
                and.w   d1,d0
                beq.s   loc_33482
                btst    #0,$5E(a5)
                bne.s   loc_33440
                move.w  #1,d0
                bra.s   loc_33444
; ---------------------------------------------------------------------------
loc_33440:                                              ; CODE XREF: Enemy_TrackerSt21Destroy+36   j
                move.w  #0,d0
loc_33444:                                              ; CODE XREF: Enemy_TrackerSt21Destroy+3C   j
                jsr     (loc_2BD20).l
                bset    #3,2(a0)
                bset    #2,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a0)
                rts
; ---------------------------------------------------------------------------
loc_33482:                                              ; CODE XREF: Enemy_TrackerSt21Destroy+2E   j
                bsr.w   Enemy_TrackerSt21Collision
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$4C(a0)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$50(a0)
locret_334B0:                                           ; CODE XREF: Enemy_TrackerSt21Destroy+4   j
                                        ; Enemy_TrackerSt21Destroy+14   j
                rts
; End of function Enemy_TrackerSt21Destroy
; Tracker follow player (win cutscene)
Enemy_TrackerWinFollow:                                 ; CODE XREF: Enemy_TrackerWinMovement+6   j  ; was: sub_334B2
                move.l  (dword_FF8062).w,d0
                move.l  (dword_FFA960).w,d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_334D2
                ori.w   #$200,2(a5)
locret_334D2:                                           ; CODE XREF: Enemy_TrackerWinFollow+18   j
                rts
; End of function Enemy_TrackerWinFollow
; Tracker off-screen (Stage 21)
Enemy_TrackerSt21OffScreen:                             ; CODE XREF: Enemy_TrackerWinMovement+68   j  ; was: sub_334D4
                                        ; Enemy_TrackerWinMovement+72   j
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_TrackerSt21OffScreen
; Initialize tracker sprite (win)
Enemy_TrackerWinInitSprite:                             ; CODE XREF: Enemy_TrackerSt21SpawnInit+10   p  ; was: sub_334DC
                                        ; Enemy_TrackerWinSpawnBullet+12   p
                move.w  #$3B0,(a0)
                move.w  #$CC00,2(a0)
                move.w  #$6400,$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #$10,$23(a0)
                clr.w   $C(a0)
                rts
; End of function Enemy_TrackerWinInitSprite
; Spawns tracker bullets (win)
Enemy_TrackerWinSpawnBullet:                            ; CODE XREF: Enemy_TrackerWinMain:loc_330DA   p  ; was: sub_334FE
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   locret_33578
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_33578
                bsr.w   Enemy_TrackerWinInitSprite
                move.w  #$400,$E(a0)
                clr.b   $21(a0)
                move.b  #$60,$20(a0)                    ; '`'
                bset    #0,$5F(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_3357A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                addq.w  #1,$5A(a5)
                move.w  $5A(a5),d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                btst    #0,(dword_FF9410).w
                bne.s   loc_33560
                lea     word_3358A(pc),a1
                nop
                bra.s   loc_33566
; ---------------------------------------------------------------------------
loc_33560:                                              ; CODE XREF: Enemy_TrackerWinSpawnBullet+58   j
                lea     word_335AA(pc),a1
                nop
loc_33566:                                              ; CODE XREF: Enemy_TrackerWinSpawnBullet+60   j
                move.w  (a1,d0.w),$10(a0)
                move.w  2(a1,d0.w),$14(a0)
                move.w  #$40,$48(a0)                    ; '@'
locret_33578:                                           ; CODE XREF: Enemy_TrackerWinSpawnBullet+8   j
                                        ; Enemy_TrackerWinSpawnBullet+10   j
                rts
; End of function Enemy_TrackerWinSpawnBullet
; ---------------------------------------------------------------------------
off_3357A:      dc.l    word_1CEC96                     ; DATA XREF: Enemy_TrackerWinSpawnBullet+38   r
                dc.l    word_1CEC9C
                dc.l    word_1CECA8
                dc.l    word_1CEC96
word_3358A:     dc.w    $1D0, $120, $170, $170, $1D0, $B0, $D0, $170, $1D0, $120, $1D0, $B0, $170, $170, $D0, $170
                                        ; DATA XREF: Enemy_TrackerWinSpawnBullet+5A   o
word_335AA:     dc.w    $1D0, $B0, $D0, $80, $170, $80, $1D0, $120, $60, $B0, $D0, $170, $60, $120, $170, $170
                                        ; DATA XREF: Enemy_TrackerWinSpawnBullet:loc_33560   o

; Tracker collision (Stage 21)
Enemy_TrackerSt21Collision:                             ; CODE XREF: Enemy_TrackerSt21Destroy:loc_33482   p  ; was: sub_335CA
                move.w  #$458,(a0)
                move.w  #$8E00,2(a0)
                move.w  #$44C8,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.w  #$40,$48(a0)                    ; '@'
                rts
; End of function Enemy_TrackerSt21Collision
; Tracker bullet (Stage 21)
Projectile_TrackerSt21Bullet:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_335EE
                move.w  4(a5),d0
                lea     off_335FA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_TrackerSt21Bullet
; ---------------------------------------------------------------------------
off_335FA:      dc.w    Enemy_TrackerSt21UpdateAI-*     ; DATA XREF: Projectile_TrackerSt21Bullet+4   o
                dc.w    Enemy_TrackerSt21UpdateAI_VerticalWave-*
                dc.w    Enemy_TrackerSt21Animation-*
                dc.w    nullsub_76-*

; Tracker AI update (Stage 21)
Enemy_TrackerSt21UpdateAI:                              ; DATA XREF: ROM:off_335FA   o  ; was: sub_33602
                move.w  $14(a5),$4A(a5)
                addq.w  #2,4(a5)
; Applies sine wave vertical offset to Y position based on frame counter
Enemy_TrackerSt21UpdateAI_VerticalWave:                 ; DATA XREF: ROM:000335FC   o  ; was: loc_3360C
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #3,d0
                move.b  word_3363C(pc,d0.w),d0
                ext.w   d0
                add.w   $4A(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3363A
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_3363A:                                           ; CODE XREF: Enemy_TrackerSt21UpdateAI+26   j
                rts
; End of function Enemy_TrackerSt21UpdateAI
; ---------------------------------------------------------------------------
word_3363C:     dc.w    $FF00, $100                     ; DATA XREF: Enemy_TrackerSt21UpdateAI+14   r

; Tracker animation (Stage 21)
Enemy_TrackerSt21Animation:                             ; DATA XREF: ROM:000335FE   o  ; was: sub_33640
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$10,d0
                bpl.s   locret_33660
                move.w  #$C8,$26(a5)
                jsr     (Projectile_CheckLifetime).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
locret_33660:                                           ; CODE XREF: Enemy_TrackerSt21Animation+A   j
                rts
; End of function Enemy_TrackerSt21Animation
nullsub_76:                                             ; DATA XREF: ROM:00033600   o
                rts
; End of function nullsub_76

; Collision detection
