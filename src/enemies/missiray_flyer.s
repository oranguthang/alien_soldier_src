; Collision and animation helpers for the flyer preceding Missiray
Enemy_FlyerCollision:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_33664
                move.w  4(a5),d0
                lea     off_33670(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerCollision
; ---------------------------------------------------------------------------
off_33670:      dc.w    Enemy_FlyerDamage-*             ; DATA XREF: Enemy_FlyerCollision+4   o
                dc.w    Enemy_FlyerUpdateSprites1-*
                dc.w    Enemy_FlyerUpdateSprites2-*
                dc.w    Enemy_FlyerAnimation1-*
                dc.w    Enemy_FlyerRenderUpdate-*

; Damage handler
Enemy_FlyerDamage:                                      ; DATA XREF: ROM:off_33670   o  ; was: sub_3367A
                clr.w   $4A(a5)
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   loc_336A2
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_33696
                move.w  #$454,(a0)
                move.w  a0,$40(a5)
loc_33696:                                              ; CODE XREF: Enemy_FlyerDamage+12   j
                addq.w  #2,4(a5)
                move.w  #$200,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_336A2:                                              ; CODE XREF: Enemy_FlyerDamage+A   j
                addq.w  #4,4(a5)
                rts
; End of function Enemy_FlyerDamage
; Updates flyer sprites 1
Enemy_FlyerUpdateSprites1:                              ; DATA XREF: ROM:00033672   o  ; was: sub_336A8
                subq.w  #1,$48(a5)
                bne.s   locret_336B2
                addq.w  #2,4(a5)
locret_336B2:                                           ; CODE XREF: Enemy_FlyerUpdateSprites1+4   j
                rts
; End of function Enemy_FlyerUpdateSprites1
; Updates flyer sprites 2
Enemy_FlyerUpdateSprites2:                              ; DATA XREF: ROM:00033674   o  ; was: sub_336B4
                moveq   #0,d0
                move.l  d0,$4C(a5)
                move.l  d0,$50(a5)
                move.l  d0,$54(a5)
                move.l  d0,$58(a5)
                move.l  d0,$5C(a5)
                move.w  #9,d7
                lea     $4C(a5),a1
loc_336D2:                                              ; CODE XREF: Enemy_FlyerUpdateSprites2+2C   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_336E4
                move.w  #$10,(a0)
                move.w  a0,(a1)+
                dbf     d7,loc_336D2
loc_336E4:                                              ; CODE XREF: Enemy_FlyerUpdateSprites2+24   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerUpdateSprites2
; Flyer animation 1
Enemy_FlyerAnimation1:                                  ; DATA XREF: ROM:00033676   o  ; was: sub_336EA
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   loc_336FA
                lea     word_3377A(pc),a1
                nop
                bra.s   loc_33700
; ---------------------------------------------------------------------------
loc_336FA:                                              ; CODE XREF: Enemy_FlyerAnimation1+6   j
                lea     word_337A8(pc),a1
                nop
loc_33700:                                              ; CODE XREF: Enemy_FlyerAnimation1+E   j
                move.w  $4A(a5),d0
                lea     (a1,d0.w),a1
                lea     $4C(a5),a2
                lea     word_33766(pc),a3
                nop
                move.w  #9,d7
loc_33716:                                              ; CODE XREF: Enemy_FlyerAnimation1:loc_33734   j
                move.w  (a1)+,d4
                tst.w   (a2)
                beq.s   loc_33734
                movea.w (a2)+,a0
                move.w  (a3)+,d0
                move.w  #$180,d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w   Enemy_FlyerAnimation2
loc_33734:                                              ; CODE XREF: Enemy_FlyerAnimation1+30   j
                dbf     d7,loc_33716
                move.w  (a1)+,$48(a5)
                tst.w   (a1)
                bmi.s   loc_3374C
                addi.w  #$16,$4A(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_3374C:                                              ; CODE XREF: Enemy_FlyerAnimation1+54   j
                move.w  #$1000,2(a5)
                cmpi.w  #$3E0,(word_FFDB20).w
                beq.s   locret_33764
                movea.w $40(a5),a0
                move.w  #$1000,2(a0)
locret_33764:                                           ; CODE XREF: Enemy_FlyerAnimation1+6E   j
                rts
; End of function Enemy_FlyerAnimation1
; ---------------------------------------------------------------------------
word_33766:     dc.w    $90, $B0, $D0, $F0, $110, $130, $150, $170, $190, $1B0
                                        ; DATA XREF: Enemy_FlyerAnimation1+22   o
word_3377A:     dc.w    $200, $1C0, $130, $220, $90, 0, $110, $190
                                        ; DATA XREF: Enemy_FlyerAnimation1+8   o
                dc.w    $A0, $30, $200, $1E0, $1B8, $128, $210, $78
                dc.w    0, $F0, $170, $A0, $40, $200, $FFFF
word_337A8:     dc.w    0, $10, $20, $30, $40, $80, $90, $A0
                                        ; DATA XREF: Enemy_FlyerAnimation1:loc_336FA   o
                dc.w    $B0, $C0, $100, $C0, $B0, $A0, $90, $80
                dc.w    $40, $30, $20, $10, 0, $100, $FFFF

; Render update handler
Enemy_FlyerRenderUpdate:                                ; DATA XREF: ROM:00033678   o  ; was: sub_337D6
                subq.w  #1,$48(a5)
                bne.s   locret_337E2
                move.w  #4,4(a5)
locret_337E2:                                           ; CODE XREF: Enemy_FlyerRenderUpdate+4   j
                rts
; End of function Enemy_FlyerRenderUpdate
; Dispatches to appropriate state handler for flyer enemy behavior
Enemy_FlyerStateDispatcher:
                move.w  4(a5),d0                        ; was: sub_337E4
                lea     off_337F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerStateDispatcher
; ---------------------------------------------------------------------------
off_337F0:      dc.w    Enemy_FlyerInitState-*          ; DATA XREF: Enemy_FlyerStateDispatcher+4   o
                dc.w    Enemy_FlyerInitState_WaitLoop-*
                dc.w    Enemy_FlyerSpawnPair-*
                dc.w    Enemy_FlyerSetupAnimation-*
                dc.w    Enemy_FlyerVerticalOscillation-*
                dc.w    Enemy_FlyerFireMissiray-*

; Initializes flyer with timer and transitions through initialization sequence
Enemy_FlyerInitState:                                   ; DATA XREF: ROM:off_337F0   o  ; was: sub_337FC
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
; Wait during initialization and handle Missiray fire
Enemy_FlyerInitState_WaitLoop:                          ; DATA XREF: ROM:000337F2   o  ; was: loc_33806
                bsr.w   Enemy_FlyerPeriodicMissirayFire
                subq.w  #1,$48(a5)
                bne.s   locret_3381A
                move.w  #8,$4A(a5)
                addq.w  #2,4(a5)
locret_3381A:                                           ; CODE XREF: Enemy_FlyerInitState+12   j
                rts
; End of function Enemy_FlyerInitState
; Spawns pair of projectiles and stores references, handles spawn failure
Enemy_FlyerSpawnPair:                                   ; DATA XREF: ROM:000337F4   o  ; was: sub_3381C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_33840
                move.w  #$10,(a0)
                move.w  a0,$5C(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_33842
                move.w  #$10,(a0)
                move.w  a0,$5E(a5)
                addq.w  #2,4(a5)
locret_33840:                                           ; CODE XREF: Enemy_FlyerSpawnPair+6   j
                rts
; ---------------------------------------------------------------------------
loc_33842:                                              ; CODE XREF: Enemy_FlyerSpawnPair+16   j
                movea.w $5C(a5),a0
                move.w  #$1000,2(a0)
                subq.w  #4,4(a5)
                rts
; End of function Enemy_FlyerSpawnPair
; Sets up animation parameters for spawned projectile pair with random offset
Enemy_FlyerSetupAnimation:                              ; DATA XREF: ROM:000337F6   o  ; was: sub_33852
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_3389C(pc,d0.w),d0
                move.w  #$170,d1
                movea.w $5C(a5),a0
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w   Enemy_FlyerAnimation2
                addi.w  #$30,d0                         ; '0'
                movea.w $5E(a5),a0
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w   Enemy_FlyerAnimation2
                move.w  #$30,$48(a5)                    ; '0'
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerSetupAnimation
; ---------------------------------------------------------------------------
word_3389C:     dc.w    $90, $A0, $B0, $C0, $D0, $E0, $F0, $100, $110, $120, $130, $140, $150, $160, $170, $180
                                        ; DATA XREF: Enemy_FlyerSetupAnimation+A   r

; Controls vertical oscillation movement for flying enemy
Enemy_FlyerVerticalOscillation:                         ; DATA XREF: ROM:000337F8   o  ; was: sub_338BC
                subq.w  #1,$48(a5)
                bne.s   locret_338CC
                subq.w  #1,$4A(a5)
                beq.s   loc_338CE
                subq.w  #4,4(a5)
locret_338CC:                                           ; CODE XREF: Enemy_FlyerVerticalOscillation+4   j
                rts
; ---------------------------------------------------------------------------
loc_338CE:                                              ; CODE XREF: Enemy_FlyerVerticalOscillation+A   j
                move.w  #$200,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerVerticalOscillation
; Handles firing Missiray projectile with countdown timer
Enemy_FlyerFireMissiray:                                ; DATA XREF: ROM:000337FA   o  ; was: sub_338DA
                bsr.w   Enemy_FlyerPeriodicProjectileFire
                subq.w  #1,$48(a5)
                bne.s   locret_338EA
                move.w  #0,4(a5)
locret_338EA:                                           ; CODE XREF: Enemy_FlyerFireMissiray+8   j
                rts
; End of function Enemy_FlyerFireMissiray
; Periodically fires Missiray bullets at random intervals
Enemy_FlyerPeriodicMissirayFire:                        ; CODE XREF: Enemy_FlyerInitState:loc_33806   p  ; was: sub_338EC
                move.w  (word_FFA000).w,d7
                andi.w  #$3F,d7                         ; '?'
                bne.s   locret_33922
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_33922
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  #$120,d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFF000,d3
                bsr.w   Projectile_MissirayBulletInit
locret_33922:                                           ; CODE XREF: Enemy_FlyerPeriodicMissirayFire+8   j
                                        ; Enemy_FlyerPeriodicMissirayFire+10   j
                rts
; End of function Enemy_FlyerPeriodicMissirayFire
; Periodically fires projectiles at intervals with trajectory update
Enemy_FlyerPeriodicProjectileFire:                      ; CODE XREF: Enemy_FlyerFireMissiray   p  ; was: sub_33924
                move.w  (word_FFA000).w,d7
                andi.w  #$3F,d7                         ; '?'
                bne.s   locret_33954
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_33954
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  #$120,d1
                move.l  #$FFFF0000,d2
                bsr.w   Projectile_InitMissirayBullet
locret_33954:                                           ; CODE XREF: Enemy_FlyerPeriodicProjectileFire+8   j
                                        ; Enemy_FlyerPeriodicProjectileFire+10   j
                rts
; End of function Enemy_FlyerPeriodicProjectileFire
; Bullet projectile init
Projectile_MissirayBulletInit:                          ; CODE XREF: Enemy_FlyerPeriodicMissirayFire+32   p  ; was: sub_33956
                                        ; Segment_MissirayType1Fire+34   p
                move.b  #0,$47(a0)
                move.l  #word_EB3D8,8(a0)
                move.l  #$F010FE02,$2C(a0)
                move.l  #$F010F808,$28(a0)
                bra.s   loc_33998
; End of function Projectile_MissirayBulletInit
; Flyer animation 2
Enemy_FlyerAnimation2:                                  ; CODE XREF: Enemy_FlyerAnimation1+46   p  ; was: sub_33976
                                        ; Enemy_FlyerSetupAnimation+22   p
                move.b  #1,$47(a0)
                move.l  #word_EB3FC,8(a0)
                move.l  #$E020FE02,$2C(a0)
                move.l  #$E020F808,$28(a0)
                move.w  d4,$48(a0)
loc_33998:                                              ; CODE XREF: Projectile_MissirayBulletInit+1E   j
                move.w  #$3C4,(a0)
                move.w  #$400,$E(a0)
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   loc_339B0
                ori.w   #$4000,$E(a0)
loc_339B0:                                              ; CODE XREF: Enemy_FlyerAnimation2+32   j
                move.w  #$CC00,2(a0)
                move.w  #$28,$24(a0)                    ; '('
                move.w  #$64,$26(a0)                    ; 'd'
                move.b  #$40,$20(a0)                    ; '@'
                clr.w   $C(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$58(a0)
                move.l  d3,$5C(a0)
                rts
; End of function Enemy_FlyerAnimation2
; Flyer animation 3
Enemy_FlyerAnimation3:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_339DE
                tst.w   4(a5)
                beq.s   loc_33A44
                cmpi.w  #$E,4(a5)
                bcc.s   loc_33A44
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   loc_33A22
                btst    #1,(byte_FF80EC).w
                bne.w   loc_33A30
                moveq   #0,d0
                move.b  $2C(a5),d0
                ext.w   d0
                add.w   $14(a5),d0
                cmp.w   (dword_FFDB34).w,d0
                bgt.s   loc_33A22
                bset    #6,(byte_FFDB42).w
                move.w  #$12,4(a5)
                clr.b   $21(a5)
                bra.s   loc_33A44
; ---------------------------------------------------------------------------
loc_33A22:                                              ; CODE XREF: Enemy_FlyerAnimation3+14   j
                                        ; Enemy_FlyerAnimation3+30   j
                bclr    #7,$22(a5)
                bne.s   loc_33A30
                tst.w   $24(a5)
                bpl.s   loc_33A44
loc_33A30:                                              ; CODE XREF: Enemy_FlyerAnimation3+1C   j
                                        ; Enemy_FlyerAnimation3+4A   j
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                move.w  #$E,4(a5)
                clr.b   $21(a5)
loc_33A44:                                              ; CODE XREF: Enemy_FlyerAnimation3+4   j
                                        ; Enemy_FlyerAnimation3+C   j
                move.w  4(a5),d0
                lea     off_33A50(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyerAnimation3
; ---------------------------------------------------------------------------
off_33A50:      dc.w    Enemy_FlyerAnimation4-*         ; DATA XREF: Enemy_FlyerAnimation3+6A   o
                dc.w    Enemy_FlyerInitFallState-*
                dc.w    Enemy_FlyerAccelerateFall-*
                dc.w    Projectile_FlyerAccelerateDown-*
                dc.w    Projectile_FlyerDecelerate-*
                dc.w    Enemy_FlyerAnimation5-*
                dc.w    Enemy_FlyerAnimation6-*
                dc.w    Projectile_FlyerUpdate3-*
                dc.w    Projectile_FlyerUpdate4-*
                dc.w    Stage24_UpdateBackground-*
                dc.w    Stage24_UpdateForeground-*

; Flyer animation 4
Enemy_FlyerAnimation4:                                  ; DATA XREF: ROM:off_33A50   o  ; was: sub_33A66
                tst.b   $47(a5)
                bne.s   loc_33A72
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_33A72:                                              ; CODE XREF: Enemy_FlyerAnimation4+4   j
                move.w  #$A,4(a5)
                rts
; End of function Enemy_FlyerAnimation4
; Initializes falling state with velocity and collision parameters
Enemy_FlyerInitFallState:                               ; DATA XREF: ROM:00033A52   o  ; was: sub_33A7A
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.w  #$FFFC,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyerInitFallState
; Accelerates vertical fall and transitions to flyer projectile state
Enemy_FlyerAccelerateFall:                              ; DATA XREF: ROM:00033A54   o  ; was: sub_33A92
                addi.l  #$1800,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_33ADE
                cmpi.w  #2,$1C(a5)
                bcs.s   locret_33ADE
                clr.l   $1C(a5)
                move.l  #off_EB492,8(a5)
                clr.w   $C(a5)
                ori.w   #$2000,2(a5)
                move.l  #$E020FE02,$2C(a5)
                move.l  #$E020F808,$28(a5)
                move.w  #$18,$48(a5)
                addq.w  #2,4(a5)
                bsr.w   Projectile_FlyerUpdate2
locret_33ADE:                                           ; CODE XREF: Enemy_FlyerAccelerateFall+E   j
                                        ; Enemy_FlyerAccelerateFall+16   j
                rts
; End of function Enemy_FlyerAccelerateFall
; Projectile update 1
Projectile_FlyerUpdate1:                                ; CODE XREF: Projectile_FlyerAccelerateDown   p  ; was: sub_33AE0
                                        ; sub_33B86   p
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                beq.s   Projectile_FlyerUpdate2
                rts
; End of function Projectile_FlyerUpdate1
; Updates flyer projectile and applies homing behavior on interval
Projectile_FlyerUpdateWithHoming:
                move.w  (word_FFA000).w,d7              ; was: sub_33AEC
                andi.w  #3,d7
                bne.s   locret_33B12
                bsr.s   Projectile_FlyerUpdate2
                cmpi.w  #$88,(a0)
                bne.s   locret_33B12
                move.l  #$FE02F40C,$2C(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$32,$26(a0)                    ; '2'
locret_33B12:                                           ; CODE XREF: Projectile_FlyerUpdateWithHoming+8   j
                                        ; Projectile_FlyerUpdateWithHoming+10   j
                rts
; End of function Projectile_FlyerUpdateWithHoming
; Projectile update 2
Projectile_FlyerUpdate2:                                ; CODE XREF: Enemy_FlyerAccelerateFall+48   p  ; was: sub_33B14
                                        ; Projectile_FlyerUpdate1+8   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_33B52
                jsr     (Projectile_InitType88).l
                andi.w  #$FEFF,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  #off_E95DC,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $29(a5),d0
                andi.w  #$FF,d0
                add.w   d0,$14(a0)
locret_33B52:                                           ; CODE XREF: Projectile_FlyerUpdate2+6   j
                rts
; End of function Projectile_FlyerUpdate2
; Accelerates projectile downward and transitions animation state
Projectile_FlyerAccelerateDown:                         ; DATA XREF: ROM:00033A56   o  ; was: sub_33B54
                bsr.w   Projectile_FlyerUpdate1
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bcs.s   locret_33B84
                move.l  #word_EB3FC,8(a5)
                clr.w   $C(a5)
                andi.w  #$DFFF,2(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_33B84:                                           ; CODE XREF: Projectile_FlyerAccelerateDown+12   j
                rts
; End of function Projectile_FlyerAccelerateDown
; Decelerates projectile and restores original velocity after timer
Projectile_FlyerDecelerate:                             ; DATA XREF: ROM:00033A58   o  ; was: sub_33B86
                bsr.w   Projectile_FlyerUpdate1
                addi.l  #-$800,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33BA2
                move.l  $58(a5),$1C(a5)
                addq.w  #4,4(a5)
locret_33BA2:                                           ; CODE XREF: Projectile_FlyerDecelerate+10   j
                rts
; End of function Projectile_FlyerDecelerate
; Flyer animation 5
Enemy_FlyerAnimation5:                                  ; DATA XREF: ROM:00033A5A   o  ; was: sub_33BA4
                subq.w  #1,$48(a5)
                bmi.s   loc_33BAC
                rts
; ---------------------------------------------------------------------------
loc_33BAC:                                              ; CODE XREF: Enemy_FlyerAnimation5+4   j
                clr.w   $48(a5)
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.l  $58(a5),$1C(a5)
                addq.w  #2,4(a5)
                move.b  #$57,d0                         ; 'W'
                jsr     (Sound_PlaySFX).l
; End of function Enemy_FlyerAnimation5
; Flyer animation 6
Enemy_FlyerAnimation6:                                  ; DATA XREF: ROM:00033A5C   o  ; was: sub_33BD0
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                bsr.w   Projectile_FlyerUpdate1
                cmpi.w  #$80,$14(a5)
                bgt.s   locret_33BEA
                move.w  #$1000,2(a5)
locret_33BEA:                                           ; CODE XREF: Enemy_FlyerAnimation6+12   j
                rts
; End of function Enemy_FlyerAnimation6
; Projectile update 3
Projectile_FlyerUpdate3:                                ; DATA XREF: ROM:00033A5E   o  ; was: sub_33BEC
                clr.l   $1C(a5)
                btst    #3,(word_FFA40E).w
                bne.s   loc_33C00
                move.w  #$FFFE,$18(a5)
                bra.s   loc_33C06
; ---------------------------------------------------------------------------
loc_33C00:                                              ; CODE XREF: Projectile_FlyerUpdate3+A   j
                move.w  #2,$18(a5)
loc_33C06:                                              ; CODE XREF: Projectile_FlyerUpdate3+12   j
                addq.w  #2,4(a5)
                move.w  #$18,$48(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.l  #$2000,$5C(a5)
                rts
; End of function Projectile_FlyerUpdate3
; Projectile update 4
Projectile_FlyerUpdate4:                                ; DATA XREF: ROM:00033A60   o  ; was: sub_33C22
                eori.w  #$8000,2(a5)
                bsr.w   Projectile_FlyerUpdate1
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33C48
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
locret_33C48:                                           ; CODE XREF: Projectile_FlyerUpdate4+16   j
                rts
; End of function Projectile_FlyerUpdate4
; Background update
