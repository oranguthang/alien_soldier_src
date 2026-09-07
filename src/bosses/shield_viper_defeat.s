Boss_ShieldViperDefeatMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F1A6
                move.w  4(a5),d0
                lea     off_4F1B2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperDefeatMain
; ---------------------------------------------------------------------------
off_4F1B2:      dc.w    Boss_ShieldViperDefeatState1-*  ; DATA XREF: Boss_ShieldViperDefeatMain+4   o
                dc.w    Boss_ShieldViperDefeatState2-*
                dc.w    nullsub_117-*

; Defeat state 1
Boss_ShieldViperDefeatState1:                           ; DATA XREF: ROM:off_4F1B2   o  ; was: sub_4F1B8
                subq.w  #1,$48(a5)
                bpl.s   locret_4F1FA
                move.w  #$CE80,2(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                bsr.w   Boss_ShieldViperDefeatEffect
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asr.l   #3,d0
                asr.l   #3,d1
                move.l  d0,$58(a5)
                move.l  d1,$5C(a5)
locret_4F1FA:                                           ; CODE XREF: Boss_ShieldViperDefeatState1+4   j
                rts
; End of function Boss_ShieldViperDefeatState1
; Defeat state 2
Boss_ShieldViperDefeatState2:                           ; DATA XREF: ROM:0004F1B4   o  ; was: sub_4F1FC
                move.l  $58(a5),d0
                add.l   d0,$18(a5)
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                tst.l   $4C(a5)
                beq.s   locret_4F22A
                movea.l $4C(a5),a1
                movea.w a5,a0
                addi.w  #$10,$56(a5)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                bsr.w   Boss_ShieldViperMovement1
locret_4F22A:                                           ; CODE XREF: Boss_ShieldViperDefeatState2+14   j
                rts
; End of function Boss_ShieldViperDefeatState2
; Defeat visual effect
Boss_ShieldViperDefeatEffect:                           ; CODE XREF: Boss_ShieldViperDefeatState1+14   p  ; was: sub_4F22C
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4F26A
                move.l  #off_E9560,8(a0)
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFE0000,$1C(a0)
                tst.w   $2C(a5)
                beq.s   locret_4F26A
                move.b  #$C1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_4F26A:                                           ; CODE XREF: Boss_ShieldViperDefeatEffect+6   j
                                        ; Boss_ShieldViperDefeatEffect+32   j
                rts
; End of function Boss_ShieldViperDefeatEffect
nullsub_117:                                            ; DATA XREF: ROM:0004F1B6   o
                rts
; End of function nullsub_117

; Idle state handler
Boss_ShieldViperIdleState:                              ; CODE XREF: Boss_ShieldViperMain:loc_4DFD6   p  ; was: sub_4F26E
                move.w  (dword_FF941C+2).w,d0
                add.w   d0,d0
                move.w  word_4F28C(pc,d0.w),d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF941C).w
                addq.w  #1,(dword_FF941C+2).w
                andi.w  #$1F,(dword_FF941C+2).w
                rts
; End of function Boss_ShieldViperIdleState
; ---------------------------------------------------------------------------
word_4F28C:     dc.w    0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1
                                        ; DATA XREF: Boss_ShieldViperIdleState+6   r
                dc.w    0, $FFFF, $FFFE, $FFFD, $FFFC, $FFFB, $FFFA, $FFF9, $FFF8, $FFF9, $FFFA, $FFFB, $FFFC, $FFFD, $FFFE, $FFFF

; Calculates 4 interpolated trail positions
Boss_ShieldViperCalculateTrailPositions:                ; CODE XREF: Boss_ShieldViperTransitionState   p  ; was: sub_4F2CC
                bclr    #0,(dword_FF9414+1).w
                move.w  #$18,d7
                lea     (a5),a0
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
loc_4F2E0:                                              ; CODE XREF: Boss_ShieldViperCalculateTrailPositions+5A   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                move.w  d0,$56(a0)
                clr.w   $52(a0)
                clr.w   $54(a0)
                move.w  $70(a0),d1
                sub.w   $10(a0),d1
                asr.w   #3,d1
                move.w  $74(a0),d2
                sub.w   $14(a0),d2
                asr.w   #3,d2
                move.w  $10(a0),d3
                move.w  $14(a0),d4
                move.w  #3,d6
loc_4F314:                                              ; CODE XREF: Boss_ShieldViperCalculateTrailPositions+52   j
                move.w  d0,(a1)+
                move.w  d3,(a2)+
                move.w  d4,(a2)+
                add.w   d1,d3
                add.w   d2,d4
                dbf     d6,loc_4F314
                lea     $60(a0),a0
                dbf     d7,loc_4F2E0
                rts
; End of function Boss_ShieldViperCalculateTrailPositions
; Updates rotation angles for all shield viper body segments based on head position
Boss_ShieldViperUpdateSegmentAngles:                    ; CODE XREF: Boss_ShieldViperWaitFor90DegRotation+22   p  ; was: sub_4F32C
                bset    #0,(dword_FF9414+1).w
                move.w  #$10,d7
                move.w  $4D6(a5),d0
                lea     (a5),a0
loc_4F33C:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+26   j
                move.w  $56(a0),d1
                sub.w   d0,d1
                move.w  d1,$52(a0)
                move.w  d1,$54(a0)
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4F33C
                lea     $660(a5),a0
                lea     (word_FF9620).w,a1
                move.w  #7,d7
loc_4F362:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+48   j
                move.w  $56(a0),d0
                move.w  #7,d6
loc_4F36A:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+40   j
                move.w  d0,(a1)+
                dbf     d6,loc_4F36A
                lea     $60(a0),a0
                dbf     d7,loc_4F362
                move.w  d0,(a1)
                rts
; End of function Boss_ShieldViperUpdateSegmentAngles
; Attack state 1 handler
Boss_ShieldViperAttackState1:                           ; CODE XREF: Boss_ShieldViperBattleStart   p  ; was: sub_4F37C
                                        ; Boss_ShieldViperWaitForAngleMatch+6   p
                move.w  (dword_FF9400).w,d0
                add.w   d0,$56(a5)
                bsr.w   Boss_ShieldViperAttackState2
                rts
; End of function Boss_ShieldViperAttackState1
; Boss damage handler
Boss_ShieldViperDamage:                                 ; CODE XREF: Boss_ShieldViperSpawnProjectile1+3C   p  ; was: sub_4F38A
                                        ; Boss_ShieldViperDifficultySetup+1E   p
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                addi.w  #$100,d2
                sub.w   $56(a5),d2
                andi.w  #$1FF,d2
                cmpi.w  #$100,d2
                bcs.s   loc_4F3B2
                move.w  #$FFFC,(dword_FF9400).w
                bra.s   locret_4F3B8
; ---------------------------------------------------------------------------
loc_4F3B2:                                              ; CODE XREF: Boss_ShieldViperDamage+1E   j
                move.w  #4,(dword_FF9400).w
locret_4F3B8:                                           ; CODE XREF: Boss_ShieldViperDamage+26   j
                rts
; End of function Boss_ShieldViperDamage
; Calls shield viper damage check every 8 frames using player position
Boss_ShieldViperDamageEvery8Frames:
                move.w  (word_FFA000).w,d7              ; was: sub_4F3BA
                andi.w  #7,d7
                bne.s   locret_4F3D0
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                bsr.w   Boss_ShieldViperDamage
locret_4F3D0:                                           ; CODE XREF: Boss_ShieldViperDamageEvery8Frames+8   j
                rts
; End of function Boss_ShieldViperDamageEvery8Frames
; Calls shield viper damage check at fixed center position (120,F0)
Boss_ShieldViperDamageCenterPoint:                      ; CODE XREF: Boss_ShieldViperRotateAndAccelerate   p  ; was: sub_4F3D2
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4F3E8
                move.w  #$120,d0
                move.w  #$F0,d1
                bsr.w   Boss_ShieldViperDamage
locret_4F3E8:                                           ; CODE XREF: Boss_ShieldViperDamageCenterPoint+8   j
                rts
; End of function Boss_ShieldViperDamageCenterPoint
; Calculates interpolated angles for shield viper segments between current and target angles
Boss_ShieldViperCalculateSegmentAngles:
                lea     (word_FF94A0).w,a1              ; was: sub_4F3EA
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4F3F6:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+42   j
                move.w  $56(a0),d0
                move.w  $B6(a0),d1
                sub.w   d0,d1
                andi.w  #$1FF,d1
                cmpi.w  #$100,d1
                bcc.s   loc_4F40C
                bra.s   loc_4F41A
; ---------------------------------------------------------------------------
loc_4F40C:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+1E   j
                move.w  #$200,d2
                sub.w   d1,d2
                andi.w  #$1FF,d2
                move.w  d2,d1
                neg.w   d1
loc_4F41A:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+20   j
                asr.w   #3,d1
                move.w  #3,d6
loc_4F420:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+3A   j
                move.w  d0,(a1)+
                add.w   d1,d0
                dbf     d6,loc_4F420
                lea     $60(a0),a0
                dbf     d7,loc_4F3F6
                clr.w   (dword_FF9404).w
                rts
; End of function Boss_ShieldViperCalculateSegmentAngles
; Clamps shield viper X position between A0 and 150
Boss_ShieldViperClampXPosition:
                cmpi.w  #$A0,$14(a0)                    ; was: sub_4F436
                bgt.s   loc_4F444
                move.w  #$A2,$14(a0)
loc_4F444:                                              ; CODE XREF: Boss_ShieldViperClampXPosition+6   j
                cmpi.w  #$150,$14(a0)
                blt.s   locret_4F452
                move.w  #$14E,$14(a0)
locret_4F452:                                           ; CODE XREF: Boss_ShieldViperClampXPosition+14   j
                rts
; End of function Boss_ShieldViperClampXPosition
; Calculates rotation delta and direction for shield viper movement
Boss_ShieldViperCalculateRotationDelta:
                clr.w   $48(a5)                         ; was: sub_4F454
                sub.w   (dword_FF9404).w,d0
                beq.w   locret_4F478
                tst.w   d0
                bpl.s   loc_4F46E
                move.w  #$FFFF,$4C(a5)
                neg.w   d0
                bra.s   loc_4F474
; ---------------------------------------------------------------------------
loc_4F46E:                                              ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+E   j
                move.w  #1,$4C(a5)
loc_4F474:                                              ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+18   j
                move.w  d0,$48(a5)
locret_4F478:                                           ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+8   j
                rts
; End of function Boss_ShieldViperCalculateRotationDelta
; Applies rotation delta to all shield viper body segments
Boss_ShieldViperApplyRotationToSegments:                ; CODE XREF: Boss_ShieldViperInitRotationSpeed:loc_4E3DE   p  ; was: sub_4F47A
                                        ; sub_4E3FE:loc_4E440   p
                move.w  (dword_FF9404).w,d5
                move.w  #2,d7
                lea     $480(a5),a0
                movea.w a0,a1
                moveq   #0,d0
                moveq   #0,d1
loc_4F48C:                                              ; CODE XREF: Boss_ShieldViperApplyRotationToSegments+26   j
                lea     -$60(a0),a0
                lea     $60(a1),a1
                add.w   d5,d0
                sub.w   d5,d1
                move.w  d0,$54(a0)
                move.w  d1,$54(a1)
                dbf     d7,loc_4F48C
                lea     -$60(a0),a0
                lea     $60(a1),a1
                sub.w   d5,d0
                sub.w   d5,d1
                move.w  d0,$54(a0)
                move.w  d1,$54(a1)
                move.w  #7,d7
loc_4F4BC:                                              ; CODE XREF: Boss_ShieldViperApplyRotationToSegments+4C   j
                lea     -$60(a0),a0
                sub.w   d5,d0
                move.w  d0,$54(a0)
                dbf     d7,loc_4F4BC
                rts
; End of function Boss_ShieldViperApplyRotationToSegments
; Attack state 2 handler
Boss_ShieldViperAttackState2:                           ; CODE XREF: Boss_ShieldViperIntroStop   p  ; was: sub_4F4CC
                                        ; Boss_ShieldViperWaitForApproach+6   p
                move.w  $56(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
loc_4F4E2:
                move.w  (a3,d0.w),d0
                move.w  (dword_FF941C).w,d2
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   d0,$10(a5)
                add.l   d1,$14(a5)
                rts
; End of function Boss_ShieldViperAttackState2
; Updates snake segments
Boss_ShieldViperSegmentUpdate:                          ; CODE XREF: Boss_ShieldViperMain+14   p  ; was: sub_4F4F8
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                lea     stru_4F558(pc),a1
                nop
                movea.w a5,a0
                bsr.w   Boss_ShieldViperMovement1
                move.w  #$11,d7
                lea     $60(a5),a0
                lea     stru_4F598(pc),a1
                nop
loc_4F51A:                                              ; CODE XREF: Boss_ShieldViperSegmentUpdate+32   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                bsr.w   Boss_ShieldViperMovement1
                lea     $60(a0),a0
                dbf     d7,loc_4F51A
                rts
; End of function Boss_ShieldViperSegmentUpdate
; Movement pattern 1
Boss_ShieldViperMovement1:                              ; CODE XREF: Projectile_ShieldViperUpdateRotation+A   p  ; was: sub_4F530
                                        ; Boss_ShieldViperChildPositionUpdate+4E   p
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1C0,d0
                lsr.w   #3,d0
                lea     (a1,d0.w),a2
                move.w  (a2),d0
                andi.w  #$F7FF,$E(a0)
                andi.w  #$EFFF,$E(a0)
                or.w    d0,$E(a0)
                move.l  4(a2),8(a0)
                rts
; End of function Boss_ShieldViperMovement1
; ---------------------------------------------------------------------------
stru_4F558:     dc.w    0                               ; field_0
                                        ; DATA XREF: Boss_ShieldViperDefeatInit+14   o
                                        ; Boss_ShieldViperSegmentUpdate+8   o
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF8E                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFA6                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFB8                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFD0                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF8E                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFA6                      ; field_4
                dc.w    0                               ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFB8                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFD0                      ; field_4
stru_4F598:     dc.w    0                               ; field_0
                                        ; DATA XREF: Boss_ShieldViperDefeatInit+84   o
                                        ; Boss_ShieldViperChildCircularMotion+48   o
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF7C                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF82                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF88                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF7C                      ; field_4
                dc.w    0                               ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF82                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF88                      ; field_4

; Debug routine that updates shield viper debugging features
