Enemy_Stage12FloaterInit:                               ; CODE XREF: Enemy_Stage12FloaterAttack+2   p  ; was: sub_2E2BE
                                        ; Enemy_Stage12LauncherWait+2   p
                move.w  #$EF00,2(a5)
                moveq   #0,d1
                ori.w   #$8000,d1
                move.w  d1,$E(a5)
                move.b  #$10,$20(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                lea     word_2E304(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_Stage12FloaterInit
; ---------------------------------------------------------------------------
word_2E304:     dc.w    $1804, $1100, $1802, $1100
                                        ; DATA XREF: Enemy_Stage12FloaterInit+26   o

; Main handler for floater enemy
Enemy_Stage12FloaterMain:                               ; CODE XREF: Enemy_Stage12FloaterDispatcher+2C   j  ; was: sub_2E30C
                                        ; Enemy_Stage12LauncherDispatcher+2C   j
                move.w  $5C(a5),d0
                beq.s   locret_2E31E
                subq.w  #4,d0
                move.l  off_2E320(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2E31E:                                           ; CODE XREF: Enemy_Stage12FloaterMain+4   j
                rts
; End of function Enemy_Stage12FloaterMain
; ---------------------------------------------------------------------------
off_2E320:      dc.l    off_1A0F1A                      ; DATA XREF: Enemy_Stage12FloaterMain+8   r
                dc.l    off_1A0F2E

; State dispatcher for floater
Enemy_Stage12FloaterDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E328
                tst.w   4(a5)
                beq.s   loc_2E352
                tst.w   $24(a5)
                bmi.w   Enemy_Stage12LauncherMain
                tst.w   (word_FF808C).w
                bpl.w   Enemy_Stage12LauncherMain
                bclr    #7,$22(a5)
                bne.w   Enemy_Stage12LauncherMain
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2E352:                                              ; CODE XREF: Enemy_Stage12FloaterDispatcher+4   j
                bsr.s   Enemy_Stage12FloaterState1
                bra.w   Enemy_Stage12FloaterMain
; End of function Enemy_Stage12FloaterDispatcher
; Floater state 1 movement
Enemy_Stage12FloaterState1:                             ; CODE XREF: Enemy_Stage12FloaterDispatcher:loc_2E352   p  ; was: sub_2E358
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E368(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12FloaterState1
; ---------------------------------------------------------------------------
off_2E368:      dc.w    Enemy_Stage12FloaterAttack-*    ; DATA XREF: Enemy_Stage12FloaterState1+8   o
                dc.w    Enemy_Stage12FloaterAttack_CheckDistance-*
                dc.w    Enemy_Stage12FloaterCheckBounds-*
                dc.w    Enemy_Stage12FloaterFall-*
                dc.w    Enemy_FallUntilOffscreen-*
                dc.w    nullsub_67-*
                dc.w    nullsub_68-*

; Floater attack with projectile
Enemy_Stage12FloaterAttack:                             ; DATA XREF: ROM:off_2E368   o  ; was: sub_2E376
                moveq   #0,d0
                bsr.w   Enemy_Stage12FloaterInit
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Calculates distance to player and initiates dive attack when close enough
Enemy_Stage12FloaterAttack_CheckDistance:               ; DATA XREF: ROM:0002E36A   o  ; was: loc_2E386
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$60,d0                         ; '`'
                bcc.w   locret_2E3A0
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,4(a5)
locret_2E3A0:                                           ; CODE XREF: Enemy_Stage12FloaterAttack+1A   j
                rts
; End of function Enemy_Stage12FloaterAttack
; Checks if floater reached Y bound
Enemy_Stage12FloaterCheckBounds:                        ; DATA XREF: ROM:0002E36C   o  ; was: sub_2E3A2
                cmpi.w  #$150,$14(a5)
                bcc.s   locret_2E3AE
                addq.w  #2,4(a5)
locret_2E3AE:                                           ; CODE XREF: Enemy_Stage12FloaterCheckBounds+6   j
                rts
; End of function Enemy_Stage12FloaterCheckBounds
; Floater falling state with collision
Enemy_Stage12FloaterFall:                               ; DATA XREF: ROM:0002E36E   o  ; was: sub_2E3B0
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                tst.w   d2
                bne.s   locret_2E3F2
                addq.w  #2,4(a5)
                move.b  #$C0,$21(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (Math_SineTable).l,a1
                move.w  (a1,d0.w),d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_2E3F2:                                           ; CODE XREF: Enemy_Stage12FloaterFall+C   j
                rts
; End of function Enemy_Stage12FloaterFall
; Entity falls with gravity until offscreen then transitions to explosion
Enemy_FallUntilOffscreen:                               ; DATA XREF: ROM:0002E370   o  ; was: sub_2E3F4
                                        ; ROM:0002E630   o
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E414
                ori.w   #$1000,$E(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   locret_2E414
                bra.s   loc_2E416
; ---------------------------------------------------------------------------
locret_2E414:                                           ; CODE XREF: Enemy_FallUntilOffscreen+E   j
                                        ; Enemy_FallUntilOffscreen+1C   j
                rts
; ---------------------------------------------------------------------------
loc_2E416:                                              ; CODE XREF: Enemy_Stage10FlyInit+92   j
                                        ; Enemy_FallUntilOffscreen+1E   j
                movea.w a5,a0
                jsr     (Projectile_InitType88FromCurrent).l
                move.l  #off_1A0E96,8(a5)
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                rts
; End of function Enemy_FallUntilOffscreen
nullsub_67:                                             ; DATA XREF: ROM:0002E372   o
                                        ; ROM:0002E632   o
                rts
; End of function nullsub_67

nullsub_68:                                             ; DATA XREF: ROM:0002E374   o
                rts
; End of function nullsub_68

; Main handler for launcher enemy
Enemy_Stage12LauncherMain:                              ; CODE XREF: Enemy_Stage12FloaterDispatcher+A   j  ; was: sub_2E43A
                                        ; Enemy_Stage12FloaterDispatcher+12   j
                tst.w   $24(a5)
                bmi.s   loc_2E46C
                btst    #4,$22(a5)
                bne.s   loc_2E46C
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
loc_2E46C:                                              ; CODE XREF: Enemy_Stage12LauncherMain+4   j
                                        ; Enemy_Stage12LauncherMain+C   j
                clr.w   4(a5)
                move.w  #$2D0,(a5)
                move.w  #$10,$48(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #$FFFB8000,$1C(a5)
                rts
; End of function Enemy_Stage12LauncherMain
; Launcher explosion with flicker
Enemy_Stage12LauncherExplode:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E490
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E4C6
                jsr     (Projectile_ExplodeWithSound).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2E4BE
                moveq   #$F,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E4BE:                                              ; CODE XREF: Enemy_Stage12LauncherExplode+24   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2E4C6:                                              ; CODE XREF: Enemy_Stage12LauncherExplode+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E4DA
                bclr    #7,2(a5)
locret_2E4DA:                                           ; CODE XREF: Enemy_Stage12LauncherExplode+42   j
                rts
; End of function Enemy_Stage12LauncherExplode
; Main handler for turret enemy
Enemy_Stage12TurretMain:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E4DC
                tst.w   (word_FF808C).w
                bpl.w   Enemy_Stage12TurretHide
                bsr.s   Enemy_Stage12TurretDispatcher
                move.l  (dword_FFDB30).w,$10(a5)
                move.l  (dword_FFDB34).w,$14(a5)
                cmpi.w  #4,4(a5)
                bcc.w   Enemy_Stage12TurretFire
                rts
; End of function Enemy_Stage12TurretMain
; State dispatcher for turret
Enemy_Stage12TurretDispatcher:                          ; CODE XREF: Enemy_Stage12TurretMain+8   p  ; was: sub_2E4FE
                move.w  4(a5),d0
                lea     off_2E50A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12TurretDispatcher
; ---------------------------------------------------------------------------
off_2E50A:      dc.w    Enemy_Stage12TurretInit-*       ; DATA XREF: Enemy_Stage12TurretDispatcher+4   o
                dc.w    Enemy_Stage12TurretIdle-*
                dc.w    Enemy_Stage12TurretAttack-*
                dc.w    Enemy_Stage12TurretReload-*
                dc.w    Enemy_Stage12TurretCheckPlayer-*
                dc.w    Enemy_Stage12TurretDefeat-*
                dc.w    Enemy_Stage12TurretExplode-*

; Initializes turret sprite
Enemy_Stage12TurretInit:                                ; DATA XREF: ROM:off_2E50A   o  ; was: sub_2E518
                move.w  #$D00,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretInit
; Turret idle state
Enemy_Stage12TurretIdle:                                ; DATA XREF: ROM:0002E50C   o  ; was: sub_2E524
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   locret_2E53E
                cmpi.w  #6,(word_FFDB24).w
                bcs.s   locret_2E53E
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_2E53E:                                           ; CODE XREF: Enemy_Stage12TurretIdle+6   j
                                        ; Enemy_Stage12TurretIdle+E   j
                rts
; End of function Enemy_Stage12TurretIdle
; Turret attack state
Enemy_Stage12TurretAttack:                              ; DATA XREF: ROM:0002E50E   o  ; was: sub_2E540
                subq.w  #1,$48(a5)
                bne.s   locret_2E54A
                addq.w  #2,4(a5)
locret_2E54A:                                           ; CODE XREF: Enemy_Stage12TurretAttack+4   j
                rts
; End of function Enemy_Stage12TurretAttack
; Turret reload delay
Enemy_Stage12TurretReload:                              ; DATA XREF: ROM:0002E510   o  ; was: sub_2E54C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2E560
                move.w  #$10,(a0)
                move.w  a0,$4A(a5)
                addq.w  #2,4(a5)
locret_2E560:                                           ; CODE XREF: Enemy_Stage12TurretReload+6   j
                rts
; End of function Enemy_Stage12TurretReload
; Checks player position for firing
Enemy_Stage12TurretCheckPlayer:                         ; DATA XREF: ROM:0002E512   o  ; was: sub_2E562
                cmpi.w  #$140,$14(a5)
                bcs.s   locret_2E58C
                movea.w $4A(a5),a0
                move.w  #$2E4,(a0)
                addq.w  #2,4(a5)
                move.w  #$38,$4E(a0)                    ; '8'
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,$4C(a0)
locret_2E58C:                                           ; CODE XREF: Enemy_Stage12TurretCheckPlayer+6   j
                rts
; End of function Enemy_Stage12TurretCheckPlayer
; Turret defeat sequence
Enemy_Stage12TurretDefeat:                              ; DATA XREF: ROM:0002E514   o  ; was: sub_2E58E
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage12TurretDefeat
; Turret explosion effect
Enemy_Stage12TurretExplode:                             ; DATA XREF: ROM:0002E516   o  ; was: sub_2E59A
                subq.w  #1,$48(a5)
                bne.s   locret_2E5A6
                move.w  #6,4(a5)
locret_2E5A6:                                           ; CODE XREF: Enemy_Stage12TurretExplode+4   j
                rts
; End of function Enemy_Stage12TurretExplode
; Turret fires projectile
Enemy_Stage12TurretFire:                                ; CODE XREF: Enemy_Stage12TurretMain+1C   j  ; was: sub_2E5A8
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_2E5BE
                move.w  (word_FFA000).w,d7
                andi.w  #$FF,d7
                bne.s   locret_2E5E0
                bra.s   loc_2E5C8
; ---------------------------------------------------------------------------
loc_2E5BE:                                              ; CODE XREF: Enemy_Stage12TurretFire+8   j
                move.w  (word_FFA000).w,d7
                andi.w  #$1FF,d7
                bne.s   locret_2E5E0
loc_2E5C8:                                              ; CODE XREF: Enemy_Stage12TurretFire+14   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2E5E0
                move.w  #$90,(a0)
                move.w  #1,$5E(a0)
                move.w  #$B0,$14(a0)
locret_2E5E0:                                           ; CODE XREF: Enemy_Stage12TurretFire+12   j
                                        ; Enemy_Stage12TurretFire+1E   j
                rts
; End of function Enemy_Stage12TurretFire
; Hides turret enemy
Enemy_Stage12TurretHide:                                ; CODE XREF: Enemy_Stage12TurretMain+4   j  ; was: sub_2E5E2
                move.w  #$1000,2(a5)
                rts
; End of function Enemy_Stage12TurretHide
; State dispatcher for launcher
Enemy_Stage12LauncherDispatcher:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E5EA
                tst.w   4(a5)
                beq.s   loc_2E614
                tst.w   $24(a5)
                bmi.w   Enemy_Stage12LauncherMain
                tst.w   (word_FF808C).w
                bpl.w   Enemy_Stage12LauncherMain
                bclr    #7,$22(a5)
                bne.w   Enemy_Stage12LauncherMain
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2E614:                                              ; CODE XREF: Enemy_Stage12LauncherDispatcher+4   j
                bsr.s   Enemy_Stage12LauncherInit
                bra.w   Enemy_Stage12FloaterMain
; End of function Enemy_Stage12LauncherDispatcher
; Initializes launcher sprite
Enemy_Stage12LauncherInit:                              ; CODE XREF: Enemy_Stage12LauncherDispatcher:loc_2E614   p  ; was: sub_2E61A
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E62A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage12LauncherInit
; ---------------------------------------------------------------------------
off_2E62A:      dc.w    Enemy_Stage12LauncherWait-*     ; DATA XREF: Enemy_Stage12LauncherInit+8   o
                dc.w    Enemy_Stage12LauncherWait_UpdateLoop-*
                dc.w    Enemy_LauncherPrepareShot-*
                dc.w    Enemy_FallUntilOffscreen-*
                dc.w    nullsub_67-*

; Launcher wait state with position update
Enemy_Stage12LauncherWait:                              ; DATA XREF: ROM:off_2E62A   o  ; was: sub_2E634
                moveq   #4,d0
                bsr.w   Enemy_Stage12FloaterInit
                move.b  #0,$20(a5)
                move.b  #$80,$21(a5)
                move.b  #$40,$23(a5)                    ; '@'
                move.w  #$ED00,2(a5)
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
; Update launcher position while waiting for timer
Enemy_Stage12LauncherWait_UpdateLoop:                   ; DATA XREF: ROM:0002E62C   o  ; was: loc_2E65C
                bsr.w   Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$4E(a5)
                bne.s   locret_2E670
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_2E670:                                           ; CODE XREF: Enemy_Stage12LauncherWait+30   j
                rts
; End of function Enemy_Stage12LauncherWait
; Updates launcher position relative to ship
Enemy_Stage12LauncherUpdatePosition:                    ; CODE XREF: Enemy_Stage12LauncherWait:loc_2E65C   p  ; was: sub_2E672
                                        ; sub_2E690   p
                move.l  (dword_FFDB30).w,$10(a5)
                move.l  (dword_FFDB34).w,$14(a5)
                move.w  $4C(a5),d0
                add.w   d0,$10(a5)
                move.w  $4E(a5),d0
                add.w   d0,$14(a5)
                rts
; End of function Enemy_Stage12LauncherUpdatePosition
; Stage 12 launcher prepares shot with timer and velocity setup
Enemy_LauncherPrepareShot:                              ; DATA XREF: ROM:0002E62E   o  ; was: sub_2E690
                bsr.w   Enemy_Stage12LauncherUpdatePosition
                subq.w  #1,$48(a5)
                bne.s   locret_2E6C0
                ori.b   #$40,$21(a5)                    ; '@'
                move.w  #$EF00,2(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #8,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                addq.w  #2,4(a5)
locret_2E6C0:                                           ; CODE XREF: Enemy_LauncherPrepareShot+8   j
                rts
; End of function Enemy_LauncherPrepareShot
; Main dispatcher for Stage 10 bomber enemy
