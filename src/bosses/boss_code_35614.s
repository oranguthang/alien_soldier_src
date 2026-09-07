Boss_CheckScreenBounds:                                 ; CODE XREF: Boss_TerobusterUpdateBodyParts+72   j  ; was: sub_35614
                                        ; Boss_ShellshogunBoundsCheck+18   j
                tst.w   (dword_FFA908).w
                bmi.s   loc_35624
                cmpi.w  #$80,(dword_FFA908).w
                bpl.s   loc_3564E
                bra.s   loc_3562C
; ---------------------------------------------------------------------------
loc_35624:                                              ; CODE XREF: Boss_CheckScreenBounds+4   j
                cmpi.w  #$FEB0,(dword_FFA908).w
                bmi.s   loc_3564E
loc_3562C:                                              ; CODE XREF: Boss_CheckScreenBounds+E   j
                tst.w   (dword_FFA90C).w
                bmi.s   loc_35644
                cmpi.w  #$E0,(dword_FFA90C).w
                bmi.s   loc_3564E
                cmpi.w  #$1D0,(dword_FFA90C).w
                bpl.s   loc_3564E
                rts
; ---------------------------------------------------------------------------
loc_35644:                                              ; CODE XREF: Boss_CheckScreenBounds+1C   j
                cmpi.w  #$FFD0,(dword_FFA90C).w
                bmi.s   loc_3564E
                rts
; ---------------------------------------------------------------------------
loc_3564E:                                              ; CODE XREF: Boss_CheckScreenBounds+C   j
                                        ; Boss_CheckScreenBounds+16   j
                move.w  #$FEB0,(dword_FFA908).w
                rts
; End of function Boss_CheckScreenBounds
; Main handler checking boss state and HP thresholds
Boss_JetsripperMainHandler:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_35656
                clr.w   $52(a5)
                bsr.s   Boss_JetsripperUpdateState
                tst.w   (a5)
                beq.s   locret_35680
                movea.w $48(a5),a0
                bset    #0,2(a0)
                move.w  $52(a5),d0
                beq.s   locret_35680
                cmp.w   (word_FFA010).w,d0
                bmi.s   locret_35680
                move.w  d0,(word_FFA010).w
                asr.w   #1,d0
                move.w  d0,(word_FFA014).w
locret_35680:                                           ; CODE XREF: Boss_JetsripperMainHandler+8   j
                                        ; Boss_JetsripperMainHandler+18   j
                rts
; End of function Boss_JetsripperMainHandler
; Updates Jetsripper state machine and transition logic
Boss_JetsripperUpdateState:                             ; CODE XREF: Boss_JetsripperMainHandler+4   p  ; was: sub_35682
                tst.w   4(a5)
                beq.w   Boss_JetsripperStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   loc_356B2
                btst    #1,(byte_FF80EC).w
                bne.s   loc_356B2
                tst.w   (word_FF8200).w
                bne.s   loc_356B2
                move.b  #2,(byte_FF80EC).w
                move.w  #$1E,4(a5)
                bset    #0,(byte_FFA272).w
loc_356B2:                                              ; CODE XREF: Boss_JetsripperUpdateState+E   j
                                        ; Boss_JetsripperUpdateState+16   j
                bsr.w   Boss_JetsripperUpdatePalette
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
; State dispatcher for Jetstripper boss using jump table
Boss_JetsripperStateDispatch:                           ; CODE XREF: Boss_JetsripperUpdateState+4   j  ; was: loc_356C8
                move.w  4(a5),d0
                movea.w off_356D8(pc,d0.w),a0
                adda.l  #Boss_JetsripperInitState,a0
                jmp     (a0)
; End of function Boss_JetsripperUpdateState
; ---------------------------------------------------------------------------
off_356D8:      dc.w    Boss_JetsripperInitState-Boss_JetsripperInitState
                                        ; DATA XREF: Boss_JetsripperUpdateState+4A   r
                dc.w    Boss_JetsripperInitBody-Boss_JetsripperInitState
                dc.w    Boss_JetsripperAlignToCenter-Boss_JetsripperInitState
                dc.w    Boss_JetsripperUpdateMovement-Boss_JetsripperInitState
                dc.w    Boss_JetsripperRotateState-Boss_JetsripperInitState
                dc.w    Boss_JetsripperIdleState-Boss_JetsripperInitState
                dc.w    Boss_JetsripperAlignState-Boss_JetsripperInitState
                dc.w    Boss_JetsripperPatrolState-Boss_JetsripperInitState
                dc.w    Boss_JetsripperEnterScreen-Boss_JetsripperInitState
                dc.w    Boss_JetsripperStateThunk-Boss_JetsripperInitState
                dc.w    Boss_JetsripperAttackTimer-Boss_JetsripperInitState
                dc.w    Boss_JetsripperEndAttack-Boss_JetsripperInitState
                dc.w    Boss_JetsripperDivePrep-Boss_JetsripperInitState
                dc.w    Boss_JetsripperDiveExecute-Boss_JetsripperInitState
                dc.w    Boss_JetsripperSwingAttack-Boss_JetsripperInitState
                dc.w    Boss_JetsripperDeathInit-Boss_JetsripperInitState
                dc.w    Boss_JetsripperDeathFade-Boss_JetsripperInitState

; Initializes boss state and spawns linked objects
Boss_JetsripperInitState:                               ; DATA XREF: Boss_JetsripperUpdateState+4E   o  ; was: sub_356FA
                                        ; ROM:off_356D8   o
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  #$E4,d0
                moveq   #0,d1
                jmp     Sprite_ClearAllExcept
; End of function Boss_JetsripperInitState
; Initializes 18 body segments with physics parameters
Boss_JetsripperInitBody:                                ; DATA XREF: ROM:000356DA   o  ; was: sub_3570E
                move.w  #$10,4(a5)
                movea.w a5,a0
                moveq   #0,d0
                moveq   #0,d1
                moveq   #$11,d7
loc_3571C:                                              ; CODE XREF: Boss_JetsripperInitBody+6C   j
                move.w  #$E8,(a0)
                move.w  #$C000,2(a0)
                move.w  #$8300,$E(a0)
                move.l  #word_EB654,8(a0)
                move.b  #$20,$20(a0)                    ; ' '
                move.w  d1,$48(a0)
                move.b  #$50,$21(a0)                    ; 'P'
                btst    #0,d0
                beq.s   Boss_JetsripperInitBodyParts
                move.b  #$10,$21(a0)
; Initializes Jetstripper body segment collision and position data
Boss_JetsripperInitBodyParts:                           ; CODE XREF: Boss_JetsripperInitBody+3A   j  ; was: loc_35750
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F20EF20E,$28(a0)
                move.w  #$C,$24(a0)
                move.w  #$50,$26(a0)                    ; 'P'
                move.b  #4,$23(a0)
                lea     $60(a0),a0
                addq.w  #1,d0
                addq.w  #6,d1
                dbf     d7,loc_3571C
                move.w  #$E4,(a5)
                move.w  #$CC00,2(a5)
                move.w  #$320,$10(a5)
                move.w  #$320,$130(a5)
                move.b  #$80,$23(a5)
                move.w  #$20,$24(a5)                    ; ' '
                move.w  a5,$48(a5)
                clr.w   $4C(a5)
                clr.w   $4E(a5)
                move.w  #$E0,$54(a5)
                move.w  #$70,$56(a5)                    ; 'p'
                clr.w   $5A(a5)
                clr.w   $BE(a5)
                move.w  #0,d0
                bra.w   Boss_JetsripperFillAngleBuffer
; End of function Boss_JetsripperInitBody
; Handles boss entering screen until position threshold
Boss_JetsripperEnterScreen:                             ; DATA XREF: ROM:000356E8   o  ; was: sub_357C8
                bsr.w   Boss_JetsripperOscillate
                cmpi.w  #$810,$5E(a5)
                bpl.w   loc_35868
                addq.w  #2,4(a5)
                clr.w   $4C(a5)
                move.w  #$40,$4E(a5)                    ; '@'
                bra.w   loc_35868
; End of function Boss_JetsripperEnterScreen
; Attributes: thunk
; Thunk routine jumping to alignment state handler
Boss_JetsripperStateThunk:                              ; DATA XREF: ROM:000356EA   o  ; was: sub_357E8
                bra.w   Boss_JetsripperAlignToCenter
; End of function Boss_JetsripperStateThunk
; Handles attack timer countdown and sound trigger
Boss_JetsripperAttackTimer:                             ; DATA XREF: ROM:000356EC   o  ; was: sub_357EC
                subq.w  #1,$5C(a5)
                bpl.w   Boss_JetsripperUpdateMovement
                addq.w  #2,4(a5)
                move.b  #$48,d0                         ; 'H'
                jsr     (Sound_PlaySFX).l
                move.w  #8,$52(a5)
                moveq   #3,d0
                jsr     (UI_CheckVictoryCondition).l
                bra.w   Boss_JetsripperUpdateMovement
; End of function Boss_JetsripperAttackTimer
; Ends attack phase and resets state parameters
Boss_JetsripperEndAttack:                               ; DATA XREF: ROM:000356EE   o  ; was: sub_35814
                tst.w   (word_FF80C2).w
                bne.w   Boss_JetsripperUpdateMovement
                move.w  #6,4(a5)
                move.w  #8,$5C(a5)
                move.w  #$60,$11E(a5)                   ; '`'
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                bra.w   Boss_JetsripperUpdateMovement
; End of function Boss_JetsripperEndAttack
; Handles Jetsripper rotation state with angle check
Boss_JetsripperRotateState:                             ; DATA XREF: ROM:000356E0   o  ; was: sub_3583C
                bsr.w   Boss_JetsripperAdjustRadius
                move.w  $56(a5),d0
                addi.w  #8,d0
                andi.w  #$1F8,d0
                subq.w  #1,$4C(a5)
                bpl.s   loc_35864
                cmpi.w  #$70,d0                         ; 'p'
                bne.s   loc_35864
                addq.w  #2,4(a5)
                clr.w   $4C(a5)
                clr.w   $4E(a5)
loc_35864:                                              ; CODE XREF: Boss_JetsripperRotateState+14   j
                                        ; Boss_JetsripperRotateState+1A   j
                move.w  d0,$56(a5)
loc_35868:                                              ; CODE XREF: Boss_JetsripperEnterScreen+A   j
                                        ; Boss_JetsripperEnterScreen+1C   j
                bsr.w   Boss_JetsripperCalculateSegmentY
                bsr.w   Boss_JetsripperUpdateSegments
                bsr.w   Boss_JetsripperFindLowestSegment
                move.w  #$C740,$48(a5)
                movea.w a5,a3
                moveq   #$11,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bsr.w   Boss_JetsripperUpdateAllSprites
                cmpi.w  #$144,$14(a5)
                bmi.s   locret_35896
                move.w  #$144,$14(a5)
locret_35896:                                           ; CODE XREF: Boss_JetsripperRotateState+52   j
                rts
; End of function Boss_JetsripperRotateState
; Idle state with oscillation and attack condition checks
Boss_JetsripperIdleState:                               ; DATA XREF: ROM:000356E2   o  ; was: sub_35898
                bsr.w   Boss_JetsripperOscillate
                subi.w  #1,(word_FF8234).w
                bmi.w   loc_35908
                cmpi.w  #0,$56(a5)
                bne.s   loc_358CA
                tst.w   $4C(a5)
                beq.s   loc_358CA
                cmpi.w  #$710,$5E(a5)
                bpl.s   loc_358CA
                move.w  #$C,4(a5)
                clr.w   $4C(a5)
                bra.w   loc_35868
; ---------------------------------------------------------------------------
loc_358CA:                                              ; CODE XREF: Boss_JetsripperIdleState+14   j
                                        ; Boss_JetsripperIdleState+1A   j
                cmpi.w  #$12,(word_FF8234).w
                bmi.w   loc_35868
                btst    #0,(dword_FFFF08+1).w
                beq.w   loc_35868
                cmpi.w  #0,$56(a5)
                bne.w   loc_35868
                tst.w   $4C(a5)
                bne.w   loc_35868
                move.w  #$18,4(a5)
                move.w  #0,$4C(a5)
                bra.w   loc_35868
; ---------------------------------------------------------------------------
loc_35900:                                              ; CODE XREF: Boss_JetsripperPatrolState+A   j
                move.w  #1,$4C(a5)
                bra.s   loc_3590C
; ---------------------------------------------------------------------------
loc_35908:                                              ; CODE XREF: Boss_JetsripperIdleState+A   j
                clr.w   $4C(a5)
loc_3590C:                                              ; CODE XREF: Boss_JetsripperIdleState+6E   j
                move.w  #4,4(a5)
                move.w  #$40,$4E(a5)                    ; '@'
                move.w  #$100,$5C(a5)
                bra.w   loc_35868
; End of function Boss_JetsripperIdleState
; Alignment state adjusting radius until reaching target angle
Boss_JetsripperAlignState:                              ; DATA XREF: ROM:000356E4   o  ; was: sub_35922
                bsr.w   Boss_JetsripperAdjustRadius
                move.w  $56(a5),d0
                subi.w  #8,d0
                andi.w  #$1F8,d0
                subq.w  #1,$4C(a5)
                bpl.s   loc_3594C
                cmpi.w  #$90,d0
                bne.s   loc_3594C
                addq.w  #2,4(a5)
                move.w  #1,$4C(a5)
                clr.w   $4E(a5)
loc_3594C:                                              ; CODE XREF: Boss_JetsripperAlignState+14   j
                                        ; Boss_JetsripperAlignState+1A   j
                move.w  d0,$56(a5)
                bra.w   loc_35868
; End of function Boss_JetsripperAlignState
; Patrol state with oscillation and position threshold checks
Boss_JetsripperPatrolState:                             ; DATA XREF: ROM:000356E6   o  ; was: sub_35954
                bsr.w   Boss_JetsripperOscillate
                subi.w  #1,(word_FF8234).w
                bmi.w   loc_35900
                cmpi.w  #$100,$56(a5)
                bne.s   loc_35986
                tst.w   $4C(a5)
                bne.s   loc_35986
                cmpi.w  #$870,$5E(a5)
                bmi.s   loc_35986
                move.w  #8,4(a5)
                clr.w   $4C(a5)
                bra.w   loc_35868
; ---------------------------------------------------------------------------
loc_35986:                                              ; CODE XREF: Boss_JetsripperPatrolState+14   j
                                        ; Boss_JetsripperPatrolState+1A   j
                cmpi.w  #$12,(word_FF8234).w
                bmi.w   loc_35868
                btst    #0,(dword_FFFF08+1).w
                bne.w   loc_35868
                cmpi.w  #$100,$56(a5)
                bne.w   loc_35868
                tst.w   $4C(a5)
                beq.w   loc_35868
                move.w  #$18,4(a5)
                move.w  #2,$4C(a5)
                bra.w   loc_35868
; End of function Boss_JetsripperPatrolState
; Updates vertical oscillation movement pattern
Boss_JetsripperOscillate:                               ; CODE XREF: Boss_JetsripperEnterScreen   p  ; was: sub_359BC
                                        ; sub_35898   p
                move.w  #1,$52(a5)
                bsr.w   Boss_JetsripperAdjustRadius
                move.w  $56(a5),d0
                tst.w   $4C(a5)
                bne.s   loc_359DE
                addq.w  #8,d0
                subq.w  #1,$4E(a5)
                bpl.s   Boss_JetsripperUpdateAngle
                addq.w  #1,$4C(a5)
                bra.s   loc_359EA
; ---------------------------------------------------------------------------
loc_359DE:                                              ; CODE XREF: Boss_JetsripperOscillate+12   j
                subq.w  #8,d0
                subq.w  #1,$4E(a5)
                bpl.s   Boss_JetsripperUpdateAngle
                clr.w   $4C(a5)
loc_359EA:                                              ; CODE XREF: Boss_JetsripperOscillate+20   j
                move.w  #$18,$4E(a5)
; Updates boss angle and calculates velocity for movement
Boss_JetsripperUpdateAngle:                             ; CODE XREF: Boss_JetsripperOscillate+1A   j  ; was: loc_359F0
                                        ; Boss_JetsripperOscillate+28   j
                andi.w  #$1F8,d0
                move.w  d0,$56(a5)
                bsr.w   Boss_JetsripperCalcVelocity
                add.l   d2,$130(a5)
                rts
; End of function Boss_JetsripperOscillate
; Moves boss toward center alignment position
Boss_JetsripperAlignToCenter:                           ; CODE XREF: Boss_JetsripperStateThunk   j  ; was: sub_35A02
                                        ; DATA XREF: ROM:000356DC   o
                move.w  #2,$52(a5)
                bsr.w   Boss_JetsripperAdjustRadius
                move.w  $56(a5),d0
                subi.w  #$10,d0
                tst.w   $4C(a5)
                bne.s   loc_35A1E
                addi.w  #$20,d0                         ; ' '
loc_35A1E:                                              ; CODE XREF: Boss_JetsripperAlignToCenter+16   j
                andi.w  #$1F0,d0
                subq.w  #1,$4E(a5)
                bpl.s   loc_35A46
                cmpi.w  #$80,d0
                bne.s   loc_35A46
                addq.w  #2,4(a5)
                move.w  #4,$52(a5)
                clr.w   $4C(a5)
                clr.w   $4E(a5)
                move.w  #$A0,$11E(a5)
loc_35A46:                                              ; CODE XREF: Boss_JetsripperAlignToCenter+24   j
                                        ; Boss_JetsripperAlignToCenter+2A   j
                move.w  d0,$56(a5)
                bra.w   loc_35AD8
; End of function Boss_JetsripperAlignToCenter
; Main movement update with direction oscillation
Boss_JetsripperUpdateMovement:                          ; CODE XREF: Boss_JetsripperAttackTimer+4   j  ; was: sub_35A4E
                                        ; Boss_JetsripperAttackTimer+24   j
                addi.w  #2,(word_FF8234).w
                move.w  $56(a5),d0
                move.b  (dword_FFFF08).w,d1
                andi.w  #$F,d1
                addi.w  #$18,d1
                tst.w   $4C(a5)
                bne.s   loc_35A84
                cmpi.w  #$180,d0
                bpl.s   loc_35A76
                cmpi.w  #$100,d0
                bpl.s   loc_35A7E
loc_35A76:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+20   j
                addq.w  #8,d0
                subq.w  #1,$4E(a5)
                bpl.s   loc_35A9A
loc_35A7E:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+26   j
                addq.w  #1,$4C(a5)
                bra.s   loc_35A96
; ---------------------------------------------------------------------------
loc_35A84:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+1A   j
                cmpi.w  #$180,d0
                bpl.s   loc_35A92
                subq.w  #8,d0
                subq.w  #1,$4E(a5)
                bpl.s   loc_35A9A
loc_35A92:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+3A   j
                clr.w   $4C(a5)
loc_35A96:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+34   j
                move.w  d1,$4E(a5)
loc_35A9A:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+2E   j
                                        ; Boss_JetsripperUpdateMovement+42   j
                andi.w  #$1F8,d0
                move.w  d0,$56(a5)
                cmpi.w  #$14,4(a5)
                beq.s   loc_35AD8
                cmpi.w  #$16,4(a5)
                beq.s   loc_35AD8
                subq.w  #1,$5C(a5)
                bpl.s   loc_35AD8
                bsr.w   Boss_JetsripperSpawnProjectile
                move.w  #$30,$4C(a5)                    ; '0'
                cmpi.w  #$7C0,$5E(a5)
                bmi.s   loc_35AD2
                move.w  #8,4(a5)
                bra.s   loc_35AD8
; ---------------------------------------------------------------------------
loc_35AD2:                                              ; CODE XREF: Boss_JetsripperUpdateMovement+7A   j
                move.w  #$C,4(a5)
loc_35AD8:                                              ; CODE XREF: Boss_JetsripperAlignToCenter+48   j
                                        ; Boss_JetsripperUpdateMovement+5A   j
                bsr.w   Boss_JetsripperCalculateSegmentY
                bsr.w   Boss_JetsripperUpdateSegments
                bsr.w   Boss_JetsripperFindLowestSegment
                move.w  #$C980,$48(a5)
                movea.w a5,a3
                moveq   #$11,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bsr.w   Boss_JetsripperUpdateAllSprites
                cmpi.w  #$144,$14(a5)
                bmi.s   Boss_JetsripperSelectSprite
                move.w  #$144,$14(a5)
; Selects sprite frame based on animation timer
Boss_JetsripperSelectSprite:                            ; CODE XREF: Boss_JetsripperUpdateMovement+B0   j  ; was: loc_35B06
                move.w  (word_FFA000).w,d0
                andi.w  #4,d0
                move.l  off_35B1C(pc,d0.w),8(a5)
                bclr    #4,$E(a5)
                rts
; End of function Boss_JetsripperUpdateMovement
; ---------------------------------------------------------------------------
off_35B1C:      dc.l    word_EB6F6                      ; DATA XREF: Boss_JetsripperUpdateMovement+C0   r
                dc.l    word_EB70E

; Prepares dive attack with velocity calculation and sound
Boss_JetsripperDivePrep:                                ; DATA XREF: ROM:000356F0   o  ; was: sub_35B24
                subi.w  #1,(word_FF8234).w
                move.w  #1,$52(a5)
                bsr.w   Boss_JetsripperCalcVelocity
                add.l   d2,$130(a5)
                move.w  $56(a5),d0
                cmpi.w  #$180,d0
                bne.s   loc_35B6A
                cmpi.w  #$142,$14(a5)
                bmi.w   loc_35868
                move.b  #$DA,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #$144,$14(a5)
                move.w  #8,$52(a5)
                bra.w   loc_35868
; ---------------------------------------------------------------------------
loc_35B6A:                                              ; CODE XREF: Boss_JetsripperDivePrep+1C   j
                tst.w   $4C(a5)
                bne.s   loc_35B74
                addq.w  #8,d0
                bra.s   loc_35B7C
; ---------------------------------------------------------------------------
loc_35B74:                                              ; CODE XREF: Boss_JetsripperDivePrep+4A   j
                subq.w  #8,d0
                move.w  #$18,$4E(a5)
loc_35B7C:                                              ; CODE XREF: Boss_JetsripperDivePrep+4E   j
                andi.w  #$1F8,d0
                move.w  d0,$56(a5)
                bra.w   loc_35868
; End of function Boss_JetsripperDivePrep
; Executes dive attack with angle rotation and bounce
Boss_JetsripperDiveExecute:                             ; DATA XREF: ROM:000356F2   o  ; was: sub_35B88
                clr.l   $18(a5)
                move.w  $56(a5),d0
                move.w  $5A(a5),d2
                tst.w   $4C(a5)
                beq.s   loc_35BB0
                subq.w  #8,d2
                subi.w  #$20,d0                         ; ' '
                andi.w  #$1E0,d0
                cmpi.w  #$80,d0
                bne.s   loc_35BC4
                clr.w   $4C(a5)
                bra.s   loc_35BC4
; ---------------------------------------------------------------------------
loc_35BB0:                                              ; CODE XREF: Boss_JetsripperDiveExecute+10   j
                addq.w  #8,d2
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1E0,d0
                cmpi.w  #$80,d0
                bne.s   loc_35BC4
                addq.w  #1,$4C(a5)
loc_35BC4:                                              ; CODE XREF: Boss_JetsripperDiveExecute+20   j
                                        ; Boss_JetsripperDiveExecute+26   j
                move.w  d0,$56(a5)
                andi.w  #$1FE,d2
                move.w  d2,$5A(a5)
                addq.w  #4,$54(a5)
                cmpi.w  #$1A0,$54(a5)
                bmi.s   loc_35C38
                move.b  #$D7,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #8,$52(a5)
                move.w  #$1A0,$54(a5)
                move.w  #$80,d0
                move.w  d0,$56(a5)
                bsr.w   Boss_JetsripperFillAngleBuffer
                clr.w   $BE(a5)
                clr.w   $5A(a5)
                bsr.w   Boss_JetsripperProcessSegmentChain
                move.l  #$28000,$18(a5)
                move.l  #$FFFA8000,$1C(a5)
                subi.w  #$34,(word_FF8234).w            ; '4'
                jsr     (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   locret_35C36
                move.l  #$FFFD8000,$18(a5)
locret_35C36:                                           ; CODE XREF: Boss_JetsripperDiveExecute+A4   j
                rts
; ---------------------------------------------------------------------------
loc_35C38:                                              ; CODE XREF: Boss_JetsripperDiveExecute+52   j
                bsr.w   Boss_JetsripperCalculateSegmentY
                bsr.w   Boss_JetsripperUpdateSegments
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                movea.w a5,a3
                moveq   #$11,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bsr.w   Boss_JetsripperUpdateAllSprites
                move.l  #word_EB696,8(a5)
                move.w  $E(a5),d0
                andi.w  #$E7FF,d0
                move.w  d0,$E(a5)
                rts
; End of function Boss_JetsripperDiveExecute
; Swing attack with oscillating angle and velocity changes
Boss_JetsripperSwingAttack:                             ; DATA XREF: ROM:000356F4   o  ; was: sub_35C6C
                move.w  $56(a5),d0
                move.w  $5A(a5),d1
                move.w  $BE(a5),d2
                tst.w   $4E(a5)
                beq.s   loc_35C92
                addq.w  #2,d1
                addi.w  #$10,d0
                subq.w  #2,d2
                cmpi.w  #$FFE4,d2
                bne.s   loc_35CA4
                clr.w   $4E(a5)
                bra.s   loc_35CA4
; ---------------------------------------------------------------------------
loc_35C92:                                              ; CODE XREF: Boss_JetsripperSwingAttack+10   j
                subq.w  #2,d1
                subi.w  #$10,d0
                addq.w  #2,d2
                cmpi.w  #$1C,d2
                bne.s   loc_35CA4
                addq.w  #1,$4E(a5)
loc_35CA4:                                              ; CODE XREF: Boss_JetsripperSwingAttack+1E   j
                                        ; Boss_JetsripperSwingAttack+24   j
                andi.w  #$1FE,d0
                move.w  d0,$56(a5)
                move.w  d2,$BE(a5)
                andi.w  #$1FE,d1
                move.w  d1,$5A(a5)
                bsr.w   Boss_JetsripperFillAngleBuffer
                subq.w  #8,$54(a5)
                cmpi.w  #$120,$54(a5)
                bpl.s   loc_35CCE
                move.w  #$120,$54(a5)
loc_35CCE:                                              ; CODE XREF: Boss_JetsripperSwingAttack+5A   j
                addi.l  #$2400,$1C(a5)
                bmi.s   Boss_JetsripperProcessSegmentChain
                cmpi.w  #$138,$14(a5)
                bmi.s   Boss_JetsripperProcessSegmentChain
                move.b  #$48,d0                         ; 'H'
                jsr     (Sound_PlaySFX).l
                move.w  #8,$52(a5)
                move.w  #$138,$14(a5)
                clr.l   $1C(a5)
                move.w  #$180,$56(a5)
                clr.w   $BE(a5)
                clr.w   $5A(a5)
                jsr     (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_35D24
                move.w  #8,4(a5)
                clr.w   $4C(a5)
                moveq   #$A,d1
                bsr.w   Boss_JetsripperFillAngleGradient
                bra.s   Boss_JetsripperProcessSegmentChain
; ---------------------------------------------------------------------------
loc_35D24:                                              ; CODE XREF: Boss_JetsripperSwingAttack+A4   j
                move.w  #$C,4(a5)
                move.w  #1,$4C(a5)
                moveq   #$FFFFFFF6,d1
                bsr.w   Boss_JetsripperFillAngleGradient
; End of function Boss_JetsripperSwingAttack
; Updates all body segments and linked sprite positions
Boss_JetsripperProcessSegmentChain:                     ; CODE XREF: Boss_JetsripperDiveExecute+82   p  ; was: sub_35D36
                                        ; Boss_JetsripperSwingAttack+6A   j
                bsr.w   Boss_JetsripperCalculateSegmentY
                bsr.w   Boss_JetsripperUpdateSegments
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                movea.w a5,a3
                moveq   #$11,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bra.w   Boss_JetsripperUpdateAllSprites
; End of function Boss_JetsripperProcessSegmentChain
; Initializes Jetsripper death sequence with particles
Boss_JetsripperDeathInit:                               ; DATA XREF: ROM:000356F6   o  ; was: sub_35D54
                addq.w  #2,4(a5)
                move.w  #3,(word_FF808C).w
                jsr     (Sprite_ClearObjectFlags).l
                clr.w   2(a5)
                move.w  #$C0,$4C(a5)
                jsr     (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_35DAA
                move.w  #$EC,(a0)
                clr.w   4(a0)
                move.w  #$CD00,2(a0)
                move.w  #$8300,$E(a0)
                move.l  #word_EB654,8(a0)
                move.l  #off_35F6A,$4C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                clr.w   $48(a0)
loc_35DAA:                                              ; CODE XREF: Boss_JetsripperDeathInit+20   j
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$10,d7
loc_35DB0:                                              ; CODE XREF: Boss_JetsripperDeathInit+76   j
                move.w  #$EC,(a0)
                move.w  #$CD00,2(a0)
                move.l  #off_35F7A,$4C(a0)
                clr.w   4(a0)
                lea     $60(a0),a0
                dbf     d7,loc_35DB0
                suba.w  #$60,a0                         ; '`'
                move.l  #off_35FBA,$4C(a0)
locret_35DDA:                                           ; CODE XREF: Boss_JetsripperDeathFade+A   j
                rts
; End of function Boss_JetsripperDeathInit
; Handles Jetsripper death fade animation
Boss_JetsripperDeathFade:                               ; DATA XREF: ROM:000356F8   o  ; was: sub_35DDC
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$4C(a5)
                bpl.s   locret_35DDA
                moveq   #0,d0
                moveq   #0,d1
                jmp     Sprite_ClearAllExcept
; End of function Boss_JetsripperDeathFade
; Adjusts radius parameter toward target value 0xC0
Boss_JetsripperAdjustRadius:                            ; CODE XREF: Boss_JetsripperRotateState   p  ; was: sub_35DF2
                                        ; sub_35922   p
                move.w  $54(a5),d0
                cmpi.w  #$C0,d0
                bpl.s   loc_35E0E
                addi.w  #$A,d0
                cmpi.w  #$B5,d0
                bmi.s   loc_35E18
loc_35E06:                                              ; CODE XREF: Boss_JetsripperAdjustRadius+24   j
                move.w  #$C0,$54(a5)
                rts
; ---------------------------------------------------------------------------
loc_35E0E:                                              ; CODE XREF: Boss_JetsripperAdjustRadius+8   j
                subi.w  #$A,d0
                cmpi.w  #$CB,d0
                bmi.s   loc_35E06
loc_35E18:                                              ; CODE XREF: Boss_JetsripperAdjustRadius+12   j
                move.w  d0,$54(a5)
                rts
; End of function Boss_JetsripperAdjustRadius
; Updates oscillating angle that increments/decrements in 8-pixel steps
Boss_UpdateOscillatingAngle:
                move.w  $56(a5),d0                      ; was: sub_35E1E
                tst.w   $4C(a5)
                beq.s   loc_35E46
                subq.w  #8,d0
                andi.w  #$1F8,d0
                cmpi.w  #$1A8,d0
                bne.s   loc_35E56
                move.w  #$1B0,d0
                cmpi.w  #$128,$14(a5)
                bmi.s   loc_35E56
                clr.w   $4C(a5)
                bra.s   loc_35E56
; ---------------------------------------------------------------------------
loc_35E46:                                              ; CODE XREF: Boss_UpdateOscillatingAngle+8   j
                addq.w  #8,d0
                andi.w  #$1F8,d0
                cmpi.w  #$58,d0                         ; 'X'
                bne.s   loc_35E56
                addq.w  #1,$4C(a5)
loc_35E56:                                              ; CODE XREF: Boss_UpdateOscillatingAngle+14   j
                                        ; Boss_UpdateOscillatingAngle+20   j
                move.w  d0,$56(a5)
                rts
; End of function Boss_UpdateOscillatingAngle
; Finds sprite segment with lowest Y position in chain
Boss_FindLowestSegment:
                movea.w #(word_FFC680-M68K_RAM),a0      ; was: sub_35E5C
                movea.w a5,a1
                move.l  $44(a5),d1
                moveq   #$10,d7
loc_35E68:                                              ; CODE XREF: Boss_FindLowestSegment+1C   j
                cmp.l   $44(a0),d1
                bpl.s   loc_35E74
                move.l  $44(a0),d1
                movea.w a0,a1
loc_35E74:                                              ; CODE XREF: Boss_FindLowestSegment+10   j
                lea     $60(a0),a0
                dbf     d7,loc_35E68
                move.w  a1,$48(a5)
                move.w  a1,$4A(a5)
                move.w  #$144,$14(a1)
                rts
; End of function Boss_FindLowestSegment
; Finds segment with highest Y position for targeting
Boss_JetsripperFindLowestSegment:                       ; CODE XREF: Boss_JetsripperRotateState+34   p  ; was: sub_35E8C
                                        ; Boss_JetsripperUpdateMovement+92   p
                movea.w #(word_FFC920-M68K_RAM),a0
                movea.w #(word_FFC8C0-M68K_RAM),a1
                move.l  $44(a1),d1
                moveq   #3,d7
loc_35E9A:                                              ; CODE XREF: Boss_JetsripperFindLowestSegment+1E   j
                cmp.l   $44(a0),d1
                bpl.s   loc_35EA6
                move.l  $44(a0),d1
                movea.w a0,a1
loc_35EA6:                                              ; CODE XREF: Boss_JetsripperFindLowestSegment+12   j
                lea     $60(a0),a0
                dbf     d7,loc_35E9A
                move.w  a1,$48(a5)
                move.w  a1,$4A(a5)
                move.w  #$144,$14(a1)
                rts
; End of function Boss_JetsripperFindLowestSegment
; Updates sprites for all body segments
Boss_JetsripperUpdateAllSprites:                        ; CODE XREF: Boss_JetsripperRotateState+48   p  ; was: sub_35EBE
                                        ; Boss_JetsripperUpdateMovement+A6   p
                movea.w a5,a0
                movea.l #off_35F6A,a1
                moveq   #0,d7
                bsr.s   Boss_JetsripperUpdateHeadSprite
                movea.l #off_35F7A,a1
                moveq   #$F,d7
                bsr.s   Boss_JetsripperUpdateBodySprite
                movea.l #off_35FBA,a1
                moveq   #0,d7
; End of function Boss_JetsripperUpdateAllSprites
; Updates head segment sprite with 4-direction facing
Boss_JetsripperUpdateHeadSprite:                        ; CODE XREF: Boss_JetsripperUpdateAllSprites+A   p  ; was: sub_35EDC
                                        ; Boss_JetsripperUpdateHeadSprite+4A   j
                move.w  $56(a0),d0
                add.w   $5A(a5),d0
                andi.w  #$1FE,d0
                bset    #4,$E(a0)
                cmpi.w  #$100,d0
                bmi.s   loc_35EFA
                bclr    #4,$E(a0)
loc_35EFA:                                              ; CODE XREF: Boss_JetsripperUpdateHeadSprite+16   j
                bset    #3,$E(a0)
                cmpi.w  #$180,d0
                bpl.s   loc_35F12
                cmpi.w  #$80,d0
                bmi.s   loc_35F12
                bclr    #3,$E(a0)
loc_35F12:                                              ; CODE XREF: Boss_JetsripperUpdateHeadSprite+28   j
                                        ; Boss_JetsripperUpdateHeadSprite+2E   j
                addi.w  #$20,d0                         ; ' '
                andi.w  #$C0,d0
                asr.w   #4,d0
                move.l  (a1,d0.w),8(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperUpdateHeadSprite
                rts
; End of function Boss_JetsripperUpdateHeadSprite
; Updates body segment sprites with 16-direction facing
Boss_JetsripperUpdateBodySprite:                        ; CODE XREF: Boss_JetsripperUpdateAllSprites+14   p  ; was: sub_35F2C
                                        ; Boss_JetsripperUpdateBodySprite+38   j
                move.w  $56(a0),d0
                add.w   $5A(a5),d0
                andi.w  #$1FE,d0
                bset    #3,$E(a0)
                cmpi.w  #$180,d0
                bpl.s   Boss_JetsripperUpdateBodyFrame
                cmpi.w  #$80,d0
                bmi.s   Boss_JetsripperUpdateBodyFrame
                bclr    #3,$E(a0)
; Updates body sprite frame based on calculated angle
Boss_JetsripperUpdateBodyFrame:                         ; CODE XREF: Boss_JetsripperUpdateBodySprite+16   j  ; was: loc_35F50
                                        ; Boss_JetsripperUpdateBodySprite+1C   j
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                asr.w   #3,d0
                move.l  (a1,d0.w),8(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperUpdateBodySprite
                rts
; End of function Boss_JetsripperUpdateBodySprite
; ---------------------------------------------------------------------------
off_35F6A:      dc.l    word_EB654                      ; DATA XREF: Boss_JetsripperDeathInit+3E   o
                                        ; Boss_JetsripperUpdateAllSprites+2   o
                dc.l    word_EB660
                dc.l    word_EB672
                dc.l    word_EB660
off_35F7A:      dc.l    word_EB684                      ; DATA XREF: Boss_JetsripperDeathInit+66   o
                                        ; Boss_JetsripperUpdateAllSprites+C   o
                dc.l    word_EB6C6
                dc.l    word_EB6CC
                dc.l    word_EB6D2
                dc.l    word_EB6D8
                dc.l    word_EB6D2
                dc.l    word_EB6CC
                dc.l    word_EB6C6
                dc.l    word_EB684
                dc.l    word_EB6BA
                dc.l    word_EB68A
                dc.l    word_EB6C0
                dc.l    word_EB690
                dc.l    word_EB6C0
                dc.l    word_EB68A
                dc.l    word_EB6BA
off_35FBA:      dc.l    word_EB6A8                      ; DATA XREF: Boss_JetsripperDeathInit+7E   o
                                        ; Boss_JetsripperUpdateAllSprites+16   o
                dc.l    word_EB6AE
                dc.l    word_EB6B4
                dc.l    word_EB6AE

; Fills angle buffer with constant value for segments
Boss_JetsripperFillAngleBuffer:                         ; CODE XREF: Boss_JetsripperInitBody+B6   j  ; was: sub_35FCA
                                        ; Boss_JetsripperDiveExecute+76   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$47,d7                         ; 'G'
loc_35FD2:                                              ; CODE XREF: Boss_JetsripperFillAngleBuffer+A   j
                move.w  d0,(a0)+
                dbf     d7,loc_35FD2
                rts
; End of function Boss_JetsripperFillAngleBuffer
; Fills angle buffer with gradient values for wave motion
Boss_JetsripperFillAngleGradient:                       ; CODE XREF: Boss_JetsripperSwingAttack+B2   p  ; was: sub_35FDA
                                        ; Boss_JetsripperSwingAttack+C6   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  $56(a5),d0
                move.w  #$1FE,d2
                move.w  #$47,d7                         ; 'G'
loc_35FEA:                                              ; CODE XREF: Boss_JetsripperFillAngleGradient+16   j
                move.w  d0,(a0)+
                add.w   d1,d0
                and.w   d2,d0
                dbf     d7,loc_35FEA
                rts
; End of function Boss_JetsripperFillAngleGradient
; Calculates Y positions for all body segments
Boss_JetsripperCalculateSegmentY:                       ; CODE XREF: Boss_JetsripperRotateState:loc_35868   p  ; was: sub_35FF6
                                        ; sub_35A4E:loc_35AD8   p
                moveq   #$19,d1
                move.w  $54(a5),d0
                bpl.s   loc_36004
                moveq   #0,d0
                move.w  d0,$54(a5)
loc_36004:                                              ; CODE XREF: Boss_JetsripperCalculateSegmentY+6   j
                                        ; Boss_JetsripperCalculateSegmentY+14   j
                subq.w  #1,d1
                subi.w  #$11,d0
                bpl.s   loc_36004
                addi.w  #$11,d0
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$10,d7
loc_36016:                                              ; CODE XREF: Boss_JetsripperCalculateSegmentY+28   j
                move.w  d1,$54(a0)
                lea     $60(a0),a0
                dbf     d7,loc_36016
                movea.w #(word_FFC680-M68K_RAM),a0
loc_36026:                                              ; CODE XREF: Boss_JetsripperCalculateSegmentY+38   j
                subq.w  #1,$54(a0)
                lea     $60(a0),a0
                dbf     d0,loc_36026
                rts
; End of function Boss_JetsripperCalculateSegmentY
; Calculates Y velocity from sine lookup using angle offset
Math_CalculateSineVelocity:
                move.w  #3,d3                           ; was: sub_36034
                movea.l #word_1B514,a0
                move.w  $56(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d2
                muls.w  d3,d2
                asl.l   #2,d2
                move.l  d2,$18(a5)
                rts
; End of function Math_CalculateSineVelocity
; Calculates vertical velocity from sine table
Boss_JetsripperCalcVelocity:                            ; CODE XREF: Boss_JetsripperOscillate+3C   p  ; was: sub_36058
                                        ; Boss_JetsripperDivePrep+C   p
                moveq   #$C,d3
                movea.l #word_1B514,a0
                move.w  $176(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d2
                muls.w  d3,d2
                rts
; End of function Boss_JetsripperCalcVelocity
; Updates positions of sprite segment chain based on velocity deltas
Boss_UpdateSegmentChainPositions:
                movea.w #(word_FFC980-M68K_RAM),a0      ; was: sub_36074
                movea.w a0,a1
                lea     -$60(a0),a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  $4C(a5),d0
                move.w  $4E(a5),d1
                swap    d0
                swap    d1
                asr.l   #8,d0
                asr.l   #8,d1
                moveq   #0,d2
                moveq   #0,d3
                moveq   #8,d7
loc_36098:                                              ; CODE XREF: Boss_UpdateSegmentChainPositions+38   j
                add.l   d0,d2
                add.l   d1,d3
                add.l   d2,$56(a0)
                add.l   d3,$56(a1)
                lea     -$60(a0),a0
                lea     $60(a1),a1
                dbf     d7,loc_36098
                movea.w a5,a0
                bclr    #0,2(a5)
                movea.w #(word_FFC680-M68K_RAM),a1
                movea.l #word_1B514,a2
                move.w  $5A(a5),d1
                move.w  #$1FE,d2
                moveq   #$10,d7
loc_360CC:                                              ; CODE XREF: Boss_UpdateSegmentChainPositions+94   j
                move.w  $56(a1),d3
                and.w   d2,d3
                move.w  -$80(a2,d3.w),d4
                add.w   d1,d3
                and.w   d2,d3
                move.w  (a2,d3.w),d5
                move.w  $54(a1),d3
                muls.w  d3,d4
                muls.w  d3,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $44(a0),d4
                move.l  d4,$44(a1)
                add.l   $40(a0),d5
                move.l  d5,$40(a1)
                bclr    #0,2(a1)
                lea     $60(a0),a0
                lea     $60(a1),a1
                dbf     d7,loc_360CC
                rts
; End of function Boss_UpdateSegmentChainPositions
; Updates all segment positions with wave motion
Boss_JetsripperUpdateSegments:                          ; CODE XREF: Boss_JetsripperRotateState+30   p  ; was: sub_3610E
                                        ; Boss_JetsripperUpdateMovement+8E   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  $56(a5),d0
                move.w  #$47,d7                         ; 'G'
loc_3611A:                                              ; CODE XREF: Boss_JetsripperUpdateSegments+12   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_3611A
                movea.w a5,a0
                bclr    #0,2(a0)
                clr.w   $58(a0)
                movea.w #(word_FFC680-M68K_RAM),a1
                movea.w #(byte_FF9808-M68K_RAM),a2
                movea.l #word_1B514,a3
                move.w  $5A(a5),d1
                move.w  #$1FE,d2
                moveq   #0,d6
                moveq   #$10,d7
loc_3614A:                                              ; CODE XREF: Boss_JetsripperUpdateSegments+88   j
                move.w  (a2),d3
                add.w   d6,d3
                and.w   d2,d3
                move.w  d3,$56(a1)
                move.w  -$80(a3,d3.w),d4
                add.w   d1,d3
                and.w   d2,d3
                move.w  (a3,d3.w),d5
                move.w  $54(a1),d3
                muls.w  d3,d4
                muls.w  d3,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $44(a0),d4
                move.l  d4,$44(a1)
                add.l   $40(a0),d5
                move.l  d5,$40(a1)
                bclr    #0,2(a1)
                clr.w   $58(a1)
                lea     $60(a0),a0
                lea     $60(a1),a1
                lea     8(a2),a2
                add.w   $BE(a5),d6
                dbf     d7,loc_3614A
                rts
; End of function Boss_JetsripperUpdateSegments
; Updates palette colors for glow effect
Boss_JetsripperUpdatePalette:                           ; CODE XREF: Boss_JetsripperUpdateState:loc_356B2   p  ; was: sub_3619C
                movea.w #(word_FFE37A-M68K_RAM),a0
                moveq   #0,d0
                btst    #1,(word_FFA000+1).w
                bne.s   loc_361AC
                moveq   #8,d0
loc_361AC:                                              ; CODE XREF: Boss_JetsripperUpdatePalette+C   j
                move.w  (dword_FFFF08).w,d1
                andi.w  #$F0,d1
                bne.s   Boss_JetsripperWritePalette
                moveq   #$10,d0
; Writes palette colors from lookup table for damage flash
Boss_JetsripperWritePalette:                            ; CODE XREF: Boss_JetsripperUpdatePalette+18   j  ; was: loc_361B8
                move.w  word_361C6(pc,d0.w),(a0)+
                move.w  word_361C6+2(pc,d0.w),(a0)+
                move.w  word_361C6+4(pc,d0.w),(a0)+
                rts
; End of function Boss_JetsripperUpdatePalette
; ---------------------------------------------------------------------------
word_361C6:     dc.w    $46, $28A, $4CE, 0, 2, 6, $2A, 0, $AAA, $CCC, $EEE, 0
                                        ; DATA XREF: Boss_JetsripperUpdatePalette:loc_361B8   r
                                        ; Boss_JetsripperUpdatePalette+20   r

; Clamps segment Y position to maximum 0x144
Boss_JetsripperClampY:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_361DE
                cmpi.w  #$144,$14(a5)
                bmi.s   locret_361EC
                move.w  #$144,$14(a5)
locret_361EC:                                           ; CODE XREF: Boss_JetsripperClampY+6   j
                rts
; End of function Boss_JetsripperClampY
; Updates body segment with gravity physics
Boss_JetsripperSegmentPhysics:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_361EE
                tst.w   4(a5)
                beq.w   loc_36276
                addi.l  #$4000,$1C(a5)
                movea.l $4C(a5),a1
                move.w  $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1E0,d0
                move.w  d0,$56(a5)
                cmpi.l  #off_35F7A,$4C(a5)
                beq.s   loc_36254
                bset    #3,$E(a5)
                cmpi.w  #$180,d0
                bpl.s   loc_36234
                cmpi.w  #$80,d0
                bmi.s   loc_36234
                bclr    #3,$E(a5)
loc_36234:                                              ; CODE XREF: Boss_JetsripperSegmentPhysics+38   j
                                        ; Boss_JetsripperSegmentPhysics+3E   j
                bset    #4,$E(a5)
                cmpi.w  #$100,d0
                bmi.s   loc_36246
                bclr    #4,$E(a5)
loc_36246:                                              ; CODE XREF: Boss_JetsripperSegmentPhysics+50   j
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  (a1,d0.w),8(a5)
                rts
; ---------------------------------------------------------------------------
loc_36254:                                              ; CODE XREF: Boss_JetsripperSegmentPhysics+2C   j
                bset    #3,$E(a5)
                cmpi.w  #$180,d0
                bpl.s   loc_3626C
                cmpi.w  #$80,d0
                bmi.s   loc_3626C
                bclr    #3,$E(a5)
loc_3626C:                                              ; CODE XREF: Boss_JetsripperSegmentPhysics+70   j
                                        ; Boss_JetsripperSegmentPhysics+76   j
                asr.w   #3,d0
                move.l  (a1,d0.w),8(a5)
                rts
; ---------------------------------------------------------------------------
loc_36276:                                              ; CODE XREF: Boss_JetsripperSegmentPhysics+4   j
                subq.w  #1,$48(a5)
                bpl.s   locret_362CC
                addq.w  #1,4(a5)
                move.w  #$CF00,2(a5)
                move.w  #4,(word_FFA010).w
                move.l  #$FFFC0000,$1C(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_362CC
                move.l  #off_E9560,8(a0)
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFE0000,$1C(a0)
                move.b  #$C1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_362CC:                                           ; CODE XREF: Boss_JetsripperSegmentPhysics+8C   j
                                        ; Boss_JetsripperSegmentPhysics+AC   j
                rts
; End of function Boss_JetsripperSegmentPhysics
; Creates Jetsripper projectile with trajectory
Boss_JetsripperSpawnProjectile:                         ; CODE XREF: Boss_JetsripperUpdateMovement+6A   p  ; was: sub_362CE
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_36366
                move.w  #$1FC,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C400,$E(a0)
                move.w  #$F00,8(a0)
                move.w  #$F0F0,$A(a0)
                move.b  #$C0,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$F20EF20E,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$32,$26(a0)                    ; '2'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$20000,$4C(a0)
                move.l  #$40000,$54(a0)
                move.l  #$1000,$48(a0)
                move.l  #$2000,$50(a0)
                move.w  #9,$58(a0)
                move.w  (dword_FFA410).w,d0
                cmp.w   $10(a5),d0
                bpl.s   Boss_JetsripperSetProjectileVel
                neg.l   $48(a0)
                neg.l   $4C(a0)
; Sets projectile velocity based on boss position
Boss_JetsripperSetProjectileVel:                        ; CODE XREF: Boss_JetsripperSpawnProjectile+82   j  ; was: loc_3635A
                move.l  $4C(a0),$18(a0)
                move.l  $54(a0),$1C(a0)
locret_36366:                                           ; CODE XREF: Boss_JetsripperSpawnProjectile+6   j
                rts
; End of function Boss_JetsripperSpawnProjectile
; Updates projectile with bouncing logic
Boss_JetsripperProjectileUpdate:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_36368
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$8B0,d0
                bpl.s   loc_36382
                cmpi.w  #$6D0,d0
                bmi.s   loc_36382
                tst.w   (word_FF808C).w
                bmi.s   loc_3638A
loc_36382:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+C   j
                                        ; Boss_JetsripperProjectileUpdate+12   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3638A:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+18   j
                bclr    #7,$22(a5)
                beq.s   loc_363C2
                bclr    #4,$22(a5)
                beq.s   loc_363B4
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_363B4
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (Effect_SpawnDestructionBlast).l
loc_363B4:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+30   j
                                        ; Boss_JetsripperProjectileUpdate+38   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
loc_363C2:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+28   j
                tst.w   $50(a5)
                bmi.s   loc_363EC
                cmpi.w  #$144,$14(a5)
                bmi.s   loc_363F4
loc_363D0:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+8A   j
                move.l  $4C(a5),$18(a5)
                neg.l   $54(a5)
                neg.l   $50(a5)
                move.l  $54(a5),$1C(a5)
                move.w  #9,$58(a5)
                bra.s   loc_363F4
; ---------------------------------------------------------------------------
loc_363EC:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+5E   j
                cmpi.w  #$CC,$14(a5)
                bmi.s   loc_363D0
loc_363F4:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+66   j
                                        ; Boss_JetsripperProjectileUpdate+82   j
                subq.w  #1,$58(a5)
                bmi.s   Boss_JetsripperProjectileFinal
                move.l  $48(a5),d0
                sub.l   d0,$18(a5)
                move.l  $50(a5),d0
                sub.l   d0,$1C(a5)
; Finalizes projectile update with palette masking
Boss_JetsripperProjectileFinal:                         ; CODE XREF: Boss_JetsripperProjectileUpdate+90   j  ; was: loc_3640A
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Boss_JetsripperProjectileUpdate
; Calculates distance to player for AI
Boss_CalculatePlayerDistance:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_3641A
                move.w  (word_FFEC02).w,(word_FFEC04).w
                tst.w   4(a5)
                beq.s   loc_3648A
                tst.w   6(a5)
                beq.s   loc_3648A
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3644C
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3644C
                tst.w   (word_FF8200).w
                bne.s   loc_3644C
                bset    #0,(byte_FFA272).w
                bra.w   Boss_ShiperInitDefeat
; ---------------------------------------------------------------------------
loc_3644C:                                              ; CODE XREF: Boss_CalculatePlayerDistance+18   j
                                        ; Boss_CalculatePlayerDistance+20   j
                jsr     (Gfx_InitPaletteFade).l
                clr.b   $49(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$58(a5)
                addi.l  #$6000,$7C(a5)
                bmi.s   loc_3648A
                cmpi.w  #$150,$74(a5)
                bmi.s   loc_3648A
                clr.l   $7C(a5)
                move.w  #$150,$74(a5)
                tst.w   (word_FFA010).w
                bne.s   loc_3648A
                move.w  #1,(word_FFA010).w
loc_3648A:                                              ; CODE XREF: Boss_CalculatePlayerDistance+A   j
                                        ; Boss_CalculatePlayerDistance+10   j
                move.w  4(a5),d0
                movea.w off_3649A(pc,d0.w),a0
                adda.l  #Boss_CheckPlayerProximity,a0
                jmp     (a0)
; End of function Boss_CalculatePlayerDistance
; ---------------------------------------------------------------------------
off_3649A:      dc.w    Boss_CheckPlayerProximity-Boss_CheckPlayerProximity
                                        ; DATA XREF: Boss_CalculatePlayerDistance+74   r
                dc.w    Boss_ShiperInit-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperLoadGraphics-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperSetupState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperAttackDecision-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperAttackDecision_UpdateAndSpawn-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRiseState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperHoverState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDecelerateVertical-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRetreatLogic-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRiseState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperHoverState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperWaitDescend-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatWait-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDeathHandler-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperPhaseCheck-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatSequence-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatFadeOut-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperCheckHealthTransition-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperCheckHealthTransition_WaitFade-Boss_CheckPlayerProximity

; Checks if player is within proximity range
Boss_CheckPlayerProximity:                              ; DATA XREF: Boss_CalculatePlayerDistance+78   o  ; was: sub_364C2
                                        ; ROM:off_3649A   o
                addq.w  #2,4(a5)
                addq.w  #1,6(a5)
                move.l  #word_364F4,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$13,(word_FFA944).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jmp     Sprite_ClearAllExcept
; End of function Boss_CheckPlayerProximity
nullsub_77:
                rts
; End of function nullsub_77
; ---------------------------------------------------------------------------
word_364F4:     dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $4000
                                        ; DATA XREF: Boss_CheckPlayerProximity+8   o

; Initializes Shiper Honeyviper boss by processing pointer data and setting up trigonometric tables
Boss_ShiperInit:                                        ; DATA XREF: ROM:0003649C   o  ; was: sub_36504
                jsr     (Gfx_RenderScrollingBackground).l
                bpl.s   locret_36530
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                movea.l #stru_36532,a0
                jsr     (Data_ProcessPointer).l
                movem.l (sp)+,a5
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$10,d0
                jmp     Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
locret_36530:                                           ; CODE XREF: Boss_ShiperInit+6   j
                rts
; End of function Boss_ShiperInit
; ---------------------------------------------------------------------------
stru_36532:     dc.w    7                               ; field_0
                                        ; DATA XREF: Boss_ShiperInit+10   o
                dc.l    tiles_10DA6C                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_13F4B0                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF

; Waits for system ready then loads boss graphics via DMA transfer
Boss_ShiperLoadGraphics:                                ; DATA XREF: ROM:0003649E   o  ; was: sub_36544
                tst.w   (word_FFF720).w
                bmi.s   locret_36560
                addq.w  #2,4(a5)
                movea.l #word_36562,a0
                jsr     (Gfx_DMATransferTiles).l
                move.w  #$80,(dword_FFA908).w
locret_36560:                                           ; CODE XREF: Boss_ShiperLoadGraphics+4   j
                rts
; End of function Boss_ShiperLoadGraphics
; ---------------------------------------------------------------------------
word_36562:     dc.w    $6100, $2000, $204, $708, $90A, $B0C, $D0E, $150F, $1011, $1213, $1400
                                        ; DATA XREF: Boss_ShiperLoadGraphics+A   o

; Sets up complete boss state machine with positions sprites and collision data
Boss_ShiperSetupState:                                  ; DATA XREF: ROM:000364A0   o  ; was: sub_36578
                move.w  #$14,4(a5)
                move.w  #4,$174(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$24,(word_FFF74A).w            ; '$'
                clr.w   (word_FFF74E).w
                move.w  #$A,(word_FF8090).w
                move.b  #3,(byte_FFA95B).w
                move.w  #8,$5A(a5)
                move.w  #2,$5C(a5)
                bset    #1,$5E(a5)
                move.w  #$258,$10(a5)
                move.w  #$258,$70(a5)
                move.w  #$150,$14(a5)
                move.w  #$150,$74(a5)
                move.w  #$C180,2(a5)
                move.w  #$CB00,$E(a5)
                move.l  #word_366E4,8(a5)
                move.b  #$30,$20(a5)                    ; '0'
                move.w  #$10,$60(a5)
                move.w  #$CD80,$62(a5)
                move.w  #$CB00,$6E(a5)
                move.l  #word_366F0,$68(a5)
                move.b  #$30,$80(a5)                    ; '0'
                movea.l #word_366BC,a0
                moveq   #4,d7
loc_3660A:                                              ; CODE XREF: Boss_ShiperSetupState+B0   j
                movea.w (a0)+,a1
                move.w  #$10,(a1)
                move.w  #$8080,2(a1)
                move.b  #$80,$20(a1)
                move.w  (a0)+,$E(a1)
                move.w  (a0)+,8(a1)
                move.w  (a0)+,$A(a1)
                dbf     d7,loc_3660A
                move.b  #$20,$260(a5)                   ; ' '
                move.b  #$20,$320(a5)                   ; ' '
                move.w  #$10,$1E0(a5)
                move.w  #$C080,$1E2(a5)
                move.b  #$28,$200(a5)                   ; '('
                move.w  #$10,$2A0(a5)
                move.w  #$C080,$2A2(a5)
                move.b  #$24,$2C0(a5)                   ; '$'
                movea.w #(word_FFC980-M68K_RAM),a0
                moveq   #$30,d0                         ; '0'
                moveq   #5,d7
loc_36664:                                              ; CODE XREF: Boss_ShiperSetupState+112   j
                move.w  #$10,(a0)
                move.w  #$8080,2(a0)
                move.b  d0,$20(a0)
                move.w  #$639E,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                lea     $60(a0),a0
                subq.w  #4,d0
                dbf     d7,loc_36664
                move.w  #$63A7,$54E(a5)
                move.w  #$F00,$548(a5)
                move.w  #$F0F0,$54A(a5)
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                move.w  #$10,(a0)
                movea.l #word_1BA9E,a1
                jsr     (Sprite_InitFromPointerTable).l
                bsr.w   Boss_ShiperTentaclePosition
                bra.w   Boss_ShiperScrollUpdate
; End of function Boss_ShiperSetupState
; ---------------------------------------------------------------------------
word_366BC:     dc.w    $C6E0, $63B7, $500, $F8F8, $C7A0, $63BB, $900, $F4F8, $C740, $63C1
                                        ; DATA XREF: Boss_ShiperSetupState+8A   o
                dc.w    $400, $F8FC, $C860, $E3E7, 0, $FCFC, $C920, $E3E3, $500, $F6FA
word_366E4:     dc.w    $2892, $500, $E8, $A88A, $D00, $F8
                                        ; DATA XREF: Boss_ShiperSetupState+5C   o
word_366F0:     dc.w    $2898, $900, $C1E2, $A896, $400, $C900
                                        ; DATA XREF: Boss_ShiperSetupState+7C   o

; Boss attack decision logic choosing between dive and ranged attacks
Boss_ShiperAttackDecision:                              ; DATA XREF: ROM:000364A2   o  ; was: sub_366FC
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperAttackDecision_UpdateAndSpawn
                addq.w  #2,4(a5)
                move.w  #$E,$174(a5)
                cmpi.w  #$13C,(word_FF8234).w
                bpl.s   loc_3671A
                clr.w   $174(a5)
loc_3671A:                                              ; CODE XREF: Boss_ShiperAttackDecision+18   j
                clr.l   $78(a5)
; Updates boss state and spawns projectiles during attack phase
Boss_ShiperAttackDecision_UpdateAndSpawn:               ; CODE XREF: Boss_ShiperAttackDecision+6   j  ; was: loc_3671E
                                        ; DATA XREF: ROM:000364A4   o
                bsr.w   Boss_ShiperUpdateMain
                bsr.w   Boss_ShiperSpawnProjectile
                cmpi.w  #2,$174(a5)
                bne.s   locret_3677C
                subq.w  #1,$5A(a5)
                bpl.s   locret_3677C
                btst    #0,$5E(a5)
                beq.s   locret_3677C
loc_3673C:                                              ; CODE XREF: Boss_ShiperCheckHealthTransition+34   j
                jsr     (Physics_CalculateDistanceTo).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                move.w  #4,$174(a5)
                tst.w   d1
                bpl.s   loc_3677E
                cmpi.w  #$1C08,$58(a5)
                bmi.s   loc_3677E
                move.w  #$C,4(a5)
                move.w  #2,$5C(a5)
                move.l  #$FFFE4000,$78(a5)
                bset    #1,$5E(a5)
locret_3677C:                                           ; CODE XREF: Boss_ShiperAttackDecision+30   j
                                        ; Boss_ShiperAttackDecision+36   j
                rts
; ---------------------------------------------------------------------------
loc_3677E:                                              ; CODE XREF: Boss_ShiperAttackDecision+5C   j
                                        ; Boss_ShiperAttackDecision+64   j
                move.w  #$10,4(a5)
                move.w  #4,$5C(a5)
                move.l  #$18000,$78(a5)
                bclr    #1,$5E(a5)
                rts
; End of function Boss_ShiperAttackDecision
; Boss retreat state transition with timer based on remaining health
Boss_ShiperRetreatState:                                ; CODE XREF: Boss_ShiperHoverState+34   j  ; was: sub_3679A
                                        ; Boss_ShiperHoverState+3C   j
                move.w  #8,4(a5)
                clr.w   $5C(a5)
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #4,d0
                addq.w  #1,d0
                move.w  d0,$5A(a5)
                rts
; End of function Boss_ShiperRetreatState
; Checks health counter and transitions state when conditions met
Boss_ShiperCheckHealthTransition:                       ; DATA XREF: ROM:000364BE   o  ; was: sub_367B6
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperCheckHealthTransition_WaitFade
                addq.w  #2,4(a5)
                move.w  #$A,$174(a5)
                clr.l   $78(a5)
; Waits for palette fade to reach threshold before transitioning
Boss_ShiperCheckHealthTransition_WaitFade:              ; CODE XREF: Boss_ShiperCheckHealthTransition+6   j  ; was: loc_367CC
                                        ; DATA XREF: ROM:000364C0   o
                bsr.w   Boss_ShiperUpdateMain
                addi.w  #4,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   locret_367EE
                subq.w  #1,$5A(a5)
                bpl.s   locret_367EE
                btst    #0,$5E(a5)
                bne.w   loc_3673C
locret_367EE:                                           ; CODE XREF: Boss_ShiperCheckHealthTransition+26   j
                                        ; Boss_ShiperCheckHealthTransition+2C   j
                rts
; End of function Boss_ShiperCheckHealthTransition
; Initializes hover state parameters including timers and counters
Boss_ShiperInitHoverState:                              ; CODE XREF: Boss_ShiperHoverState+2A   j  ; was: sub_367F0
                                        ; Boss_ShiperRetreatLogic+12   j
                move.w  #$24,4(a5)                      ; '$'
                move.w  #8,$5C(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                rts
; End of function Boss_ShiperInitHoverState
; Boss rising movement state with upward velocity accumulation
Boss_ShiperRiseState:                                   ; DATA XREF: ROM:000364A6   o  ; was: sub_36804
                                        ; ROM:000364AE   o
                bsr.w   Boss_ShiperUpdateMain
                addi.l  #$1E00,$78(a5)
                bmi.s   loc_36816
                clr.l   $78(a5)
loc_36816:                                              ; CODE XREF: Boss_ShiperRiseState+C   j
                tst.w   $54(a5)
                bmi.s   locret_36824
                addq.w  #2,4(a5)
                clr.l   $78(a5)
locret_36824:                                           ; CODE XREF: Boss_ShiperRiseState+16   j
                rts
; End of function Boss_ShiperRiseState
; Boss hovering state with conditional movement based on timer and flags
Boss_ShiperHoverState:                                  ; DATA XREF: ROM:000364A8   o  ; was: sub_36826
                                        ; ROM:000364B0   o
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   locret_36872
                cmpi.w  #$E,4(a5)
                beq.s   loc_3684A
                subq.w  #1,$5A(a5)
                bpl.s   loc_36866
                addq.w  #2,4(a5)
                clr.w   $5C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3684A:                                              ; CODE XREF: Boss_ShiperHoverState+12   j
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1BC8,$58(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
loc_36866:                                              ; CODE XREF: Boss_ShiperHoverState+18   j
                subq.w  #2,4(a5)
                move.l  #$FFFDA000,$78(a5)
locret_36872:                                           ; CODE XREF: Boss_ShiperHoverState+A   j
                rts
; End of function Boss_ShiperHoverState
; Decreases vertical velocity and transitions when Y position negative
Boss_ShiperDecelerateVertical:                          ; DATA XREF: ROM:000364AA   o  ; was: sub_36874
                bsr.w   Boss_ShiperUpdateMain
                subi.l  #$2000,$78(a5)
                bpl.s   loc_36886
                clr.l   $78(a5)
loc_36886:                                              ; CODE XREF: Boss_ShiperDecelerateVertical+C   j
                tst.w   $54(a5)
                bmi.s   locret_36894
                addq.w  #2,4(a5)
                clr.l   $78(a5)
locret_36894:                                           ; CODE XREF: Boss_ShiperDecelerateVertical+16   j
                rts
; End of function Boss_ShiperDecelerateVertical
; Handles retreat logic with timer checks and position validation
Boss_ShiperRetreatLogic:                                ; DATA XREF: ROM:000364AC   o  ; was: sub_36896
                bsr.w   Boss_ShiperUpdateMain
                btst    #0,$5E(a5)
                beq.s   locret_368CA
                subi.w  #$28,(word_FF8234).w            ; '('
                bmi.w   Boss_ShiperInitHoverState
                cmpi.w  #$1C98,$58(a5)
                bpl.w   Boss_ShiperRetreatState
                subq.w  #1,$5A(a5)
                bmi.w   Boss_ShiperRetreatState
                subq.w  #2,4(a5)
                move.l  #$24000,$78(a5)
locret_368CA:                                           ; CODE XREF: Boss_ShiperRetreatLogic+A   j
                rts
; End of function Boss_ShiperRetreatLogic
; Boss state waiting for descent condition then transitioning to next state
Boss_ShiperWaitDescend:                                 ; DATA XREF: ROM:000364B2   o  ; was: sub_368CC
                bsr.w   Boss_ShiperUpdateMain
                cmpi.w  #6,$16C(a5)
                bpl.s   locret_368E6
                addq.w  #2,4(a5)
                clr.w   $174(a5)
                move.w  #$30,$5A(a5)                    ; '0'
locret_368E6:                                           ; CODE XREF: Boss_ShiperWaitDescend+A   j
                rts
; End of function Boss_ShiperWaitDescend
; Boss defeat state with timer counting down to victory check
Boss_ShiperDefeatWait:                                  ; DATA XREF: ROM:000364B4   o  ; was: sub_368E8
                bsr.w   Boss_ShiperUpdateMain
                subq.w  #1,$5A(a5)
                bpl.s   locret_368FE
                addq.w  #2,4(a5)
                moveq   #2,d0
                jmp     UI_CheckVictoryCondition
; ---------------------------------------------------------------------------
locret_368FE:                                           ; CODE XREF: Boss_ShiperDefeatWait+8   j
                rts
; End of function Boss_ShiperDefeatWait
; Boss death handler checking multiple conditions before triggering defeat sequence
Boss_ShiperDeathHandler:                                ; DATA XREF: ROM:000364B6   o  ; was: sub_36900
                bsr.w   Boss_ShiperUpdateMain
                tst.w   (word_FF80C2).w
                bne.s   locret_3692E
                btst    #0,$5E(a5)
                bne.s   locret_3692E
                cmpi.w  #2,$174(a5)
                bne.s   locret_3692E
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                move.w  #$104,(word_FFDB20).w
                bra.w   Boss_ShiperRetreatState
; ---------------------------------------------------------------------------
locret_3692E:                                           ; CODE XREF: Boss_ShiperDeathHandler+8   j
                                        ; Boss_ShiperDeathHandler+10   j
                rts
; End of function Boss_ShiperDeathHandler
; Sets boss defeat flags clears state and increments stage counter
Boss_ShiperInitDefeat:                                  ; CODE XREF: Boss_CalculatePlayerDistance+2E   j  ; was: sub_36930
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.l   $78(a5)
                move.w  #4,(word_FF808C).w
; End of function Boss_ShiperInitDefeat
; Checks boss phase transition conditions based on altitude and flags
Boss_ShiperPhaseCheck:                                  ; DATA XREF: ROM:000364B8   o  ; was: sub_3694C
                cmpi.w  #$C,$174(a5)
                beq.s   loc_36962
                cmpi.w  #6,$16C(a5)
                bpl.s   Boss_ShiperUpdateWithFade
                move.w  #$A,$174(a5)
loc_36962:                                              ; CODE XREF: Boss_ShiperPhaseCheck+6   j
                btst    #0,$5E(a5)
                beq.s   Boss_ShiperUpdateWithFade
                cmpi.w  #$C,$174(a5)
                bne.s   Boss_ShiperUpdateWithFade
                move.w  #6,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #$C0,$5A(a5)
; End of function Boss_ShiperPhaseCheck
; Updates boss with palette fade effect during phase transitions
Boss_ShiperUpdateWithFade:                              ; CODE XREF: Boss_ShiperPhaseCheck+E   j  ; was: sub_36982
                                        ; Boss_ShiperPhaseCheck+1C   j
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_ShiperSpawnDebris
                bra.w   Boss_ShiperUpdateMain
; End of function Boss_ShiperUpdateWithFade
; Handles boss defeat sequence with sprite cleanup and screen effects
Boss_ShiperDefeatSequence:                              ; DATA XREF: ROM:000364BA   o  ; was: sub_36990
                bsr.w   Boss_ShiperUpdateWithFade
                subq.w  #1,$5A(a5)
                bmi.s   loc_369B0
                cmpi.w  #$1C,$5A(a5)
                bpl.w   locret_36A18
                moveq   #$1C,d0
                sub.w   $5A(a5),d0
                jmp     (Gfx_SetFadeParams).l
; ---------------------------------------------------------------------------
loc_369B0:                                              ; CODE XREF: Boss_ShiperDefeatSequence+8   j
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$5A(a5)                    ; '@'
                clr.w   6(a5)
                move.w  #$30,$4A(a5)                    ; '0'
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                clr.w   (word_FF8090).w
                move.b  #4,(byte_FFA95B).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jsr     (Sprite_ClearAllExcept).l
                jsr     (Boss_InitDefeatExplosion).l
                moveq   #$1C,d0
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_ShiperDefeatSequence
; Handles boss defeat fade out countdown before final transition
Boss_ShiperDefeatFadeOut:                               ; DATA XREF: ROM:000364BC   o  ; was: sub_369F6
                move.w  $5A(a5),d0
                subi.w  #$30,d0                         ; '0'
                bmi.s   loc_36A06
                jsr     (Gfx_SetFadeParams).l
loc_36A06:                                              ; CODE XREF: Boss_ShiperDefeatFadeOut+8   j
                subq.w  #1,$5A(a5)
                bpl.s   locret_36A18
                subq.w  #1,$4A(a5)
                bpl.s   locret_36A18
                bset    #4,2(a5)
locret_36A18:                                           ; CODE XREF: Boss_ShiperDefeatSequence+10   j
                                        ; Boss_ShiperDefeatFadeOut+14   j
                rts
; End of function Boss_ShiperDefeatFadeOut
; Main boss update wrapper calling position collision animation and physics subsystems
Boss_ShiperUpdateMain:                                  ; CODE XREF: Boss_ShiperAttackDecision:loc_3671E   p  ; was: sub_36A1A
                                        ; sub_367B6:loc_367CC   p
                bsr.w   Boss_ShiperScrollUpdate
                bsr.w   Boss_ShiperPositionUpdate
                bsr.w   Boss_ShiperStateDispatcher
                bra.w   Boss_ShiperPhysicsHandler
; End of function Boss_ShiperUpdateMain
; Boss state dispatcher using jump table for movement mode selection
Boss_ShiperStateDispatcher:                             ; CODE XREF: Boss_ShiperUpdateMain+8   p  ; was: sub_36A2A
                move.w  $5C(a5),d0
                movea.w off_36A3A(pc,d0.w),a0
                adda.l  #Boss_ShiperToggleDirection,a0
                jmp     (a0)
; End of function Boss_ShiperStateDispatcher
; ---------------------------------------------------------------------------
off_36A3A:      dc.w    Boss_ShiperToggleDirection-Boss_ShiperToggleDirection
                                        ; DATA XREF: Boss_ShiperStateDispatcher+4   r
                dc.w    Boss_ShiperMoveHorizontalA-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperMoveHorizontalB-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperToggleDirection-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperMoveHorizontal_Return-Boss_ShiperToggleDirection

; Toggles boss horizontal movement direction flag when landing
Boss_ShiperToggleDirection:                             ; DATA XREF: Boss_ShiperStateDispatcher+8   o  ; was: sub_36A44
                                        ; ROM:off_36A3A   o
                btst    #0,$5E(a5)
                beq.s   loc_36A52
                eori.b  #2,$5E(a5)
loc_36A52:                                              ; CODE XREF: Boss_ShiperToggleDirection+6   j
                btst    #1,$5E(a5)
                bne.s   Boss_ShiperMoveHorizontalB
; End of function Boss_ShiperToggleDirection
; Boss horizontal movement handler applying velocity when grounded
Boss_ShiperMoveHorizontalA:                             ; DATA XREF: ROM:00036A3C   o  ; was: sub_36A5A
                btst    #0,$5E(a5)
                beq.s   loc_36A6A
                move.l  #$10000,$4C(a5)
loc_36A6A:                                              ; CODE XREF: Boss_ShiperMoveHorizontalA+6   j
                tst.w   $54(a5)
                bmi.s   loc_36A7A
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_36A7A:                                              ; CODE XREF: Boss_ShiperMoveHorizontalA+14   j
                subi.l  #$D000,$4C(a5)
                rts
; End of function Boss_ShiperMoveHorizontalA
; Boss horizontal movement in opposite direction when airborne
Boss_ShiperMoveHorizontalB:                             ; CODE XREF: Boss_ShiperToggleDirection+14   j  ; was: sub_36A84
                                        ; DATA XREF: ROM:00036A3E   o
                btst    #0,$5E(a5)
                beq.s   loc_36A94
                move.l  #$FFFF0000,$4C(a5)
loc_36A94:                                              ; CODE XREF: Boss_ShiperMoveHorizontalB+6   j
                tst.w   $54(a5)
                bpl.s   loc_36AA4
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_36AA4:                                              ; CODE XREF: Boss_ShiperMoveHorizontalB+14   j
                subi.l  #$D000,$4C(a5)
; Return from Shiper horizontal movement
Boss_ShiperMoveHorizontal_Return:                       ; DATA XREF: ROM:00036A42   o  ; was: locret_36AAC
                rts
; End of function Boss_ShiperMoveHorizontalB
; Boss physics handler managing velocity accumulation and state transitions
Boss_ShiperPhysicsHandler:                              ; CODE XREF: Boss_ShiperUpdateMain+C   j  ; was: sub_36AAE
                move.l  $178(a5),d0
                add.l   d0,$16C(a5)
                tst.w   $16C(a5)
                bpl.s   loc_36AC0
                clr.l   $16C(a5)
loc_36AC0:                                              ; CODE XREF: Boss_ShiperPhysicsHandler+C   j
                move.w  $174(a5),d0
                movea.w off_36AD0(pc,d0.w),a0
                adda.l  #Boss_ShiperRotationInit,a0
                jmp     (a0)
; End of function Boss_ShiperPhysicsHandler
; ---------------------------------------------------------------------------
off_36AD0:      dc.w    Boss_ShiperRotationInit-Boss_ShiperRotationInit
                                        ; DATA XREF: Boss_ShiperPhysicsHandler+16   r
                dc.w    Boss_ShiperRotation_State0-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationAccel-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotation_State1-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationLogic-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationAccelAlt-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotation_State2-Boss_ShiperRotationInit
                dc.w    Boss_ShiperSpinAttack-Boss_ShiperRotationInit
                dc.w    Boss_ShiperSpinAttack_Spin-Boss_ShiperRotationInit

; Initializes boss rotation state and manages continuous angle updates
Boss_ShiperRotationInit:                                ; CODE XREF: Boss_ShiperSpinAttack+60   j  ; was: sub_36AE2
                                        ; DATA XREF: Boss_ShiperPhysicsHandler+1A   o
                addq.w  #2,$174(a5)
                clr.l   $178(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Initial rotation state with acceleration
Boss_ShiperRotation_State0:                             ; DATA XREF: ROM:00036AD2   o  ; was: loc_36AF2
                addi.l  #$3800,$178(a5)
                cmpi.w  #$C,$16C(a5)
                bmi.s   loc_36B0A
                move.l  #$FFFE4000,$178(a5)
loc_36B0A:                                              ; CODE XREF: Boss_ShiperRotationInit+1E   j
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (dword_FFFF08).w,d4
                andi.w  #$1F,d4
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #4,d0
loc_36B24:                                              ; CODE XREF: Boss_ShiperRotationAccelAlt+3E   j
                move.w  $170(a5),d1
                move.w  #$3FF,d2
                tst.w   $17C(a5)
                bne.s   loc_36B50
                add.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bpl.s   loc_36B68
                cmpi.w  #$20,d1                         ; ' '
                bmi.s   loc_36B68
                move.w  d3,d3
                bpl.s   loc_36B68
                addq.w  #1,$17C(a5)
                move.w  d4,$17E(a5)
                bra.s   loc_36B68
; ---------------------------------------------------------------------------
loc_36B50:                                              ; CODE XREF: Boss_ShiperRotationInit+4E   j
                sub.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bmi.s   loc_36B68
                cmpi.w  #$3FF,d1
                bpl.s   loc_36B68
                clr.w   $17C(a5)
                move.w  d4,$17E(a5)
loc_36B68:                                              ; CODE XREF: Boss_ShiperRotationInit+58   j
                                        ; Boss_ShiperRotationInit+5E   j
                move.w  d1,$170(a5)
                rts
; End of function Boss_ShiperRotationInit
; Boss rotation/angle acceleration with velocity increase and upper limit
Boss_ShiperRotationAccel:                               ; DATA XREF: ROM:00036AD4   o  ; was: sub_36B6E
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Rotation state 1 with velocity limit check
Boss_ShiperRotation_State1:                             ; DATA XREF: ROM:00036AD6   o  ; was: loc_36B7A
                addi.l  #$4000,$178(a5)
                moveq   #8,d0
                move.w  $170(a5),d1
                beq.s   loc_36B9C
                cmpi.w  #$1FF,d1
                bpl.s   loc_36B92
                moveq   #$FFFFFFF8,d0
loc_36B92:                                              ; CODE XREF: Boss_ShiperRotationAccel+20   j
                add.w   d0,d1
                andi.w  #$3F8,d1
                move.w  d1,$170(a5)
loc_36B9C:                                              ; CODE XREF: Boss_ShiperRotationAccel+1A   j
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   locret_36BAE
                move.w  #$40,$16C(a5)                   ; '@'
                addq.w  #2,$174(a5)
locret_36BAE:                                           ; CODE XREF: Boss_ShiperRotationAccel+34   j
                rts
; End of function Boss_ShiperRotationAccel
; Complex boss rotation logic with timer-based direction changes and limits
Boss_ShiperRotationLogic:                               ; DATA XREF: ROM:00036AD8   o  ; was: sub_36BB0
                moveq   #4,d3
                move.w  $17E(a5),d2
                subq.w  #1,d2
                move.w  $170(a5),d1
                move.l  $178(a5),d0
                bpl.s   loc_36BCC
                cmpi.w  #$7A,d2                         ; 'z'
                bpl.s   loc_36BD6
                add.w   d3,d1
                bra.s   loc_36BD6
; ---------------------------------------------------------------------------
loc_36BCC:                                              ; CODE XREF: Boss_ShiperRotationLogic+10   j
                sub.w   d3,d1
                cmpi.w  #$52,d2                         ; 'R'
                bpl.s   loc_36BD6
                add.w   d3,d1
loc_36BD6:                                              ; CODE XREF: Boss_ShiperRotationLogic+16   j
                                        ; Boss_ShiperRotationLogic+1A   j
                addi.l  #$3800,d0
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   loc_36BFC
                move.w  #$40,$16C(a5)                   ; '@'
                move.l  #$FFFA8000,d0
                moveq   #0,d1
                move.w  #$80,d2
                eori.w  #1,$17C(a5)
loc_36BFC:                                              ; CODE XREF: Boss_ShiperRotationLogic+32   j
                move.l  d0,$178(a5)
                move.w  d1,$170(a5)
                move.w  d2,$17E(a5)
                rts
; End of function Boss_ShiperRotationLogic
; Alternative rotation acceleration mode with higher velocity limits
Boss_ShiperRotationAccelAlt:                            ; DATA XREF: ROM:00036ADA   o  ; was: sub_36C0A
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Faster rotation acceleration state
Boss_ShiperRotation_State2:                             ; DATA XREF: ROM:00036ADC   o  ; was: loc_36C16
                addi.l  #$6000,$178(a5)
                cmpi.w  #$10,$16C(a5)
                bmi.s   loc_36C2E
                move.l  #$FFFCC000,$178(a5)
loc_36C2E:                                              ; CODE XREF: Boss_ShiperRotationAccelAlt+1A   j
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (dword_FFFF08).w,d4
                andi.w  #7,d4
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                bra.w   loc_36B24
; End of function Boss_ShiperRotationAccelAlt
; Boss spin attack with rotation acceleration screen shake and damage
Boss_ShiperSpinAttack:                                  ; DATA XREF: ROM:00036ADE   o  ; was: sub_36C4C
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
; Spin attack execution with deceleration
Boss_ShiperSpinAttack_Spin:                             ; DATA XREF: ROM:00036AE0   o  ; was: loc_36C54
                subi.l  #$3000,$178(a5)
                tst.w   $17C(a5)
                bne.s   loc_36C7A
                addq.w  #4,$170(a5)
                andi.w  #$3FC,$170(a5)
                cmpi.w  #$110,$170(a5)
                bne.s   locret_36C78
                addq.w  #1,$17C(a5)
locret_36C78:                                           ; CODE XREF: Boss_ShiperSpinAttack+26   j
                                        ; Boss_ShiperSpinAttack+40   j
                rts
; ---------------------------------------------------------------------------
loc_36C7A:                                              ; CODE XREF: Boss_ShiperSpinAttack+14   j
                subi.w  #$10,$170(a5)
                andi.w  #$3F0,$170(a5)
                cmpi.w  #$3A0,$170(a5)
                bne.s   locret_36C78
                move.w  #8,(word_FFA010).w
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_ShiperSpawnCircleShot
                subi.w  #$12C,(word_FF8234).w
                clr.w   $174(a5)
                bra.w   Boss_ShiperRotationInit
; End of function Boss_ShiperSpinAttack
; Updates boss position handling collision detection and sprite positioning
Boss_ShiperPositionUpdate:                              ; CODE XREF: Boss_ShiperUpdateMain+4   p  ; was: sub_36CB0
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                movea.w #(word_FFC680-M68K_RAM),a1
                move.w  $10(a1),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$10(a0)
                move.w  $14(a1),d0
                addi.w  #-$28,d0
                move.w  d0,$14(a0)
                move.l  #$1400,d2
                move.l  #$FFFE8000,d3
                move.l  #$FFFE0000,d4
                cmpi.w  #6,$5C(a5)
                bne.s   loc_36CFC
                move.l  #$C000,d2
                move.l  #$FFFB8000,d3
                move.l  #$FFFE4000,d4
loc_36CFC:                                              ; CODE XREF: Boss_ShiperPositionUpdate+38   j
                bclr    #0,$5E(a5)
                move.l  $54(a5),d0
                add.l   d2,d0
                move.l  $50(a5),d1
                bmi.s   loc_36D2E
                move.l  d3,d0
                moveq   #0,d1
                move.l  d4,$7C(a5)
                bset    #0,$5E(a5)
                movem.l d0,-(sp)
                move.b  #$B9,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
loc_36D2E:                                              ; CODE XREF: Boss_ShiperPositionUpdate+5C   j
                add.l   d0,d1
                move.l  d0,$54(a5)
                move.l  d1,$50(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-5,d0
                addi.w  #-$33,d1
                move.b  (dword_FFFF08).w,d2
                andi.w  #3,d2
                add.w   d2,d0
                btst    #4,(word_FFA000+1).w
                bne.s   loc_36D5C
                addq.w  #1,d1
loc_36D5C:                                              ; CODE XREF: Boss_ShiperPositionUpdate+A8   j
                move.w  d0,$D0(a5)
                move.w  d1,$D4(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-$D,d0
                addi.w  #-$27,d1
                move.w  d1,d7
                btst    #2,(word_FFA000+1).w
                bne.s   loc_36D80
                addq.w  #1,d1
loc_36D80:                                              ; CODE XREF: Boss_ShiperPositionUpdate+CC   j
                move.w  d0,$190(a5)
                btst    #3,(word_FFA000+1).w
                beq.s   loc_36D8E
                addq.w  #2,d0
loc_36D8E:                                              ; CODE XREF: Boss_ShiperPositionUpdate+DA   j
                move.w  d0,$130(a5)
                move.w  d1,$194(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  $16A(a5),d1
                tst.w   $168(a5)
                bne.s   loc_36DB4
                sub.w   d0,d1
                bpl.s   loc_36DC4
                clr.w   d1
                addq.w  #1,$168(a5)
                bra.s   loc_36DC4
; ---------------------------------------------------------------------------
loc_36DB4:                                              ; CODE XREF: Boss_ShiperPositionUpdate+F6   j
                add.w   d0,d1
                cmpi.w  #4,d1
                bmi.s   loc_36DC4
                move.w  #4,d1
                clr.w   $168(a5)
loc_36DC4:                                              ; CODE XREF: Boss_ShiperPositionUpdate+FA   j
                                        ; Boss_ShiperPositionUpdate+102   j
                move.w  d1,$16A(a5)
                add.w   d7,d1
                addq.w  #4,d1
                move.w  d1,$134(a5)
; End of function Boss_ShiperPositionUpdate
; Calculates and positions boss tentacle appendages using trigonometric sine/cosine tables
Boss_ShiperTentaclePosition:                            ; CODE XREF: Boss_ShiperSetupState+13C   p  ; was: sub_36DD0
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #1,d0
                move.w  #$1FE,d1
                move.w  $228(a5),d2
                btst    #0,$22C(a5)
                bne.s   loc_36DFC
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   loc_36E06
loc_36DF4:                                              ; CODE XREF: Boss_ShiperTentaclePosition+34   j
                eori.b  #1,$22C(a5)
                bra.s   loc_36E06
; ---------------------------------------------------------------------------
loc_36DFC:                                              ; CODE XREF: Boss_ShiperTentaclePosition+18   j
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$60,d2                         ; '`'
                bmi.s   loc_36DF4
loc_36E06:                                              ; CODE XREF: Boss_ShiperTentaclePosition+22   j
                                        ; Boss_ShiperTentaclePosition+2A   j
                move.w  d2,$228(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #3,d0
                move.w  $22A(a5),d2
                btst    #1,$22C(a5)
                bne.s   loc_36E32
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$1A8,d2
                bmi.s   loc_36E3C
loc_36E2A:                                              ; CODE XREF: Boss_ShiperTentaclePosition+6A   j
                eori.b  #2,$22C(a5)
                bra.s   loc_36E3C
; ---------------------------------------------------------------------------
loc_36E32:                                              ; CODE XREF: Boss_ShiperTentaclePosition+4E   j
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   loc_36E2A
loc_36E3C:                                              ; CODE XREF: Boss_ShiperTentaclePosition+58   j
                                        ; Boss_ShiperTentaclePosition+60   j
                move.w  d2,$22A(a5)
                movea.l #word_1B514,a0
                movea.l #off_36FCE,a1
                move.w  #$D300,$1EE(a5)
                move.w  #$D300,$2AE(a5)
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addq.w  #5,d0
                addi.w  #-$20,d1
                swap    d0
                swap    d1
                move.w  $228(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   loc_36E92
                move.w  #$CB00,$1EE(a5)
loc_36E92:                                              ; CODE XREF: Boss_ShiperTentaclePosition+BA   j
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$1E8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d5
                move.l  d4,d6
                asl.l   #1,d5
                asl.l   #1,d6
                add.l   d1,d3
                add.l   d0,d4
                add.l   d1,d5
                add.l   d0,d6
                move.l  d3,$1F4(a5)
                move.l  d4,$1F0(a5)
                move.l  d5,$254(a5)
                move.l  d6,$250(a5)
                move.w  $22A(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   loc_36EEA
                move.w  #$CB00,$2AE(a5)
loc_36EEA:                                              ; CODE XREF: Boss_ShiperTentaclePosition+112   j
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$2A8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d0
                move.l  d4,d1
                asl.l   #1,d0
                asl.l   #1,d1
                add.l   d5,d3
                add.l   d6,d4
                add.l   d5,d0
                add.l   d6,d1
                move.l  d3,$2B4(a5)
                move.l  d4,$2B0(a5)
                move.l  d0,$314(a5)
                move.l  d1,$310(a5)
                movea.w #(dword_FF9A00-M68K_RAM),a0
                move.w  $170(a5),d0
                moveq   #4,d7
loc_36F28:                                              ; CODE XREF: Boss_ShiperTentaclePosition+15E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_36F28
                movea.w #(word_FFC980-M68K_RAM),a0
                move.l  $70(a5),d0
                move.l  $74(a5),d1
                swap    d0
                swap    d1
                addi.w  #-$2C,d0
                addi.w  #-$14,d1
                swap    d0
                swap    d1
                add.l   $16C(a5),d0
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(word_FFC9E0-M68K_RAM),a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                movea.w #(word_FF9500-M68K_RAM),a3
                movea.w #(dword_FF9A00-M68K_RAM),a4
                move.w  #$200,d3
                moveq   #$B,d0
                moveq   #1,d5
                move.w  #$3FC,d6
                moveq   #4,d7
loc_36F78:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1F8   j
                move.w  (a4),d4
                muls.w  d5,d4
                add.w   d3,d4
                and.w   d6,d4
                move.l  (a2,d4.w),d1
                move.l  (a3,d4.w),d2
                add.l   $14(a0),d1
                add.l   $10(a0),d2
                move.l  d1,$14(a1)
                move.l  d2,$10(a1)
                cmpi.w  #$144,$14(a1)
                bmi.s   loc_36FA6
                move.w  #$144,$14(a1)
loc_36FA6:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1CE   j
                bset    #7,$E(a1)
                cmp.w   $16C(a5),d0
                bpl.s   loc_36FB8
                bclr    #7,$E(a1)
loc_36FB8:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1E0   j
                movea.w a1,a0
                lea     $60(a1),a1
                lea     2(a4),a4
                addi.w  #$10,d0
                addq.w  #1,d5
                dbf     d7,loc_36F78
                rts
; End of function Boss_ShiperTentaclePosition
; ---------------------------------------------------------------------------
off_36FCE:      dc.l    word_EBA02                      ; DATA XREF: Boss_ShiperTentaclePosition+76   o
                dc.l    word_EB9FC
                dc.l    word_EB9F6
                dc.l    word_EB9F0
                dc.l    word_EB9EA
                dc.l    word_EBA14
                dc.l    word_EBA0E
                dc.l    word_EBA08

; Spawns random debris particle sprites during boss destruction
Boss_ShiperSpawnDebris:                                 ; CODE XREF: Boss_ShiperUpdateWithFade+6   p  ; was: sub_36FEE
                move.w  #3,(word_FFA010).w
                jsr     (Projectile_InitTypeA4).l
                bne.s   locret_37046
                jsr     (Sprite_InitWithDefaultState).l
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
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_3715E
                movea.l #dword_2ABF0,a1                 ; make offsets?
                jsr     (Sprite_InitType94FromTable).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7E,d0                         ; '~'
                addi.w  #$C0,d0
                movea.l #word_1B514,a1
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
                jsr     (loc_1C11C).l
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
                jsr     (loc_1C144).l
                beq.s   loc_37210
                rts
; ---------------------------------------------------------------------------
loc_37208:                                              ; CODE XREF: Boss_ShiperSpawnProjectile+14   j
                jsr     (loc_1C11C).l
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
Enemy_BossProjectileMovement:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_37276
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
                jsr     (Projectile_UpdateTrajectory).l
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
                lea     (word_1B514).l,a1
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
Enemy_BounceRotateProjectile:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_37436
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
                lea     (word_1C972).l,a0
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
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
locret_374C4:                                           ; CODE XREF: Enemy_BounceRotateProjectile+62   j
                                        ; Enemy_BounceRotateProjectile+6E   j
                rts
; End of function Enemy_BounceRotateProjectile
; Main Antroid boss handler dispatching to state routines
Boss_AntroidMainHandler:                                ; DATA XREF: ROM:off_5DC   o  ; was: sub_374C6
                tst.w   4(a5)
                beq.w   Boss_AntroidStateDispatch
                tst.w   8(a5)
                beq.s   Boss_AntroidStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   loc_374EC
                btst    #1,(byte_FF80EC).w
                bne.s   loc_374EC
                tst.w   (word_FF8200).w
                beq.w   Boss_AntroidChargeAttack
loc_374EC:                                              ; CODE XREF: Boss_AntroidMainHandler+14   j
                                        ; Boss_AntroidMainHandler+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
; State dispatcher for Antroid boss using jump table
Boss_AntroidStateDispatch:                              ; CODE XREF: Boss_AntroidMainHandler+4   j  ; was: loc_374FE
                                        ; Boss_AntroidMainHandler+C   j
                move.w  4(a5),d0
                movea.w off_3750E(pc,d0.w),a0
                adda.l  #Boss_AntroidInitState,a0
                jmp     (a0)
; End of function Boss_AntroidMainHandler
; ---------------------------------------------------------------------------
off_3750E:      dc.w    Boss_AntroidInitState-Boss_AntroidInitState
                                        ; DATA XREF: Boss_AntroidMainHandler+3C   r
                dc.w    Boss_AntroidInitPhase-Boss_AntroidInitState
                dc.w    Boss_AntroidIdleUpdate-Boss_AntroidInitState
                dc.w    Boss_AntroidBattleDecision-Boss_AntroidInitState
                dc.w    Boss_AntroidAttackState1-Boss_AntroidInitState
                dc.w    Boss_AntroidFlyingAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidAttackState2-Boss_AntroidInitState
                dc.w    Boss_AntroidDivingAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpAttackState-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpApplyGravity-Boss_AntroidInitState
                dc.w    Boss_AntroidJump_FallCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidWaitState-Boss_AntroidInitState
                dc.w    Boss_AntroidWait_CountdownCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidInit_PhaseTimer-Boss_AntroidInitState
                dc.w    Boss_AntroidInit_CheckReady-Boss_AntroidInitState
                dc.w    Boss_AntroidRamAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidDeathFadeState-Boss_AntroidInitState
                dc.w    Boss_AntroidDeathTimer-Boss_AntroidInitState
                dc.w    Boss_AntroidIdleState-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlamAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlamAttack_ApplyGravity-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_DecelerateX-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_AccelerateDown-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_TimerCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_WaitComplete-Boss_AntroidInitState
                dc.w    Boss_AntroidEarthquakeAttack-Boss_AntroidInitState

; Initializes boss state clearing objects
Boss_AntroidInitState:                                  ; DATA XREF: Boss_AntroidMainHandler+40   o  ; was: sub_37542
                                        ; ROM:off_3750E   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$30,d0                         ; '0'
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                rts
; End of function Boss_AntroidInitState
; Initializes Antroid boss phase with metasprite setup
Boss_AntroidInitPhase:                                  ; DATA XREF: ROM:00037510   o  ; was: sub_37558
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$E,d7
                movea.l #off_349B6,a0
                movea.l #off_349F2,a1
                movea.l #word_34A02,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                moveq   #$A,d7
                movea.l #off_349C6,a0
                movea.l #word_349F6,a1
                movea.l #word_34A20,a2
                jsr     (loc_343F2).l
                move.w  #$30,(a5)                       ; '0'
                move.w  #$8D00,2(a5)
                move.w  #$C100,$962(a5)
                move.w  #$C100,$542(a5)
                move.w  #$2C8,$550(a5)
                clr.w   6(a5)
                movea.l #word_1B9E4,a1
                jsr     (Sprite_InitFromPointerTable).l
                move.w  #2,$1DE(a5)
                move.w  #$100,$54(a5)
                bsr.w   Boss_AntroidInitPhysics
                bra.w   Boss_AntroidSetIdleAnim
; ---------------------------------------------------------------------------
loc_375D8:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+62   j
                move.w  #$1A,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
; Phase initialization timer with state increment
Boss_AntroidInit_PhaseTimer:                            ; DATA XREF: ROM:00037528   o  ; was: loc_375E4
                subq.w  #1,$11C(a5)
                bmi.s   loc_375FA
                addq.w  #2,4(a5)
                moveq   #1,d0
                jsr     (UI_CheckVictoryCondition).l
                bra.w   loc_3773E
; ---------------------------------------------------------------------------
loc_375FA:                                              ; CODE XREF: Boss_AntroidInitPhase+90   j
                addq.w  #2,4(a5)
; Checks ready flag for battle transition
Boss_AntroidInit_CheckReady:                            ; DATA XREF: ROM:0003752A   o  ; was: loc_375FE
                tst.w   (word_FF80C2).w
                bne.s   loc_37622
                clr.b   (byte_FF80EC).w
                subi.w  #$40,(word_FFA970).w            ; '@'
                clr.w   $1DE(a5)
                move.w  #6,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
                bra.w   Boss_AntroidBattleDecision
; ---------------------------------------------------------------------------
loc_37622:                                              ; CODE XREF: Boss_AntroidInitPhase+AA   j
                bra.w   loc_3773E
; End of function Boss_AntroidInitPhase
; Initializes Antroid boss position and physics parameters at start of battle
Boss_AntroidInitPosition:
                move.w  #$24,4(a5)                      ; '$'  ; was: sub_37626
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                clr.w   $54(a5)
                bsr.w   Boss_AntroidInitPhysics
; End of function Boss_AntroidInitPosition
; Updates Antroid boss idle animation and sprite rendering
Boss_AntroidIdleState:                                  ; DATA XREF: ROM:00037532   o  ; was: sub_37648
                lea     word_38322(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; End of function Boss_AntroidIdleState
; Transitions to idle state saving animation and loading table
Boss_AntroidTransitionToIdle:                           ; CODE XREF: Boss_AntroidJumpAttackState+CA   j  ; was: sub_37656
                move.w  $58(a5),(dword_FF8040).w
                move.w  $C(a5),(dword_FF8040+2).w
                moveq   #4,d0
                bsr.w   Boss_AntroidLoadAnimTable
                move.w  (dword_FF8040).w,$58(a5)
                move.w  (dword_FF8040+2).w,$C(a5)
                bra.s   loc_3767C
; ---------------------------------------------------------------------------
loc_37676:                                              ; CODE XREF: Boss_AntroidEarthquakeAttack+4   j
                                        ; Boss_AntroidFlyingAttack+54   j
                moveq   #4,d0
                bsr.w   Boss_AntroidLoadAnimTable
loc_3767C:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+1E   j
                clr.w   $23C(a5)
; Idle state update with animation interpolation and sprite render
Boss_AntroidIdleUpdate:                                 ; CODE XREF: Boss_AntroidWaitState+5E   j  ; was: loc_37680
                                        ; DATA XREF: ROM:00037512   o
                tst.w   $58(a5)
                bmi.s   loc_376A2
                lea     word_3832C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $11E(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_376A2:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+2E   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                move.w  a5,$48(a5)
                tst.w   $1DE(a5)
                bne.w   loc_375D8
                addq.w  #2,4(a5)
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #5,d0
                addq.w  #2,d0
                move.w  d0,$11C(a5)
; Battle decision logic choosing attack based on distance and random
Boss_AntroidBattleDecision:                             ; CODE XREF: Boss_AntroidInitPhase+C6   j  ; was: loc_376D0
                                        ; DATA XREF: ROM:00037514   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_3773E
                tst.w   $23E(a5)
                beq.s   loc_3773E
                tst.w   (word_FF8234).w
                beq.w   loc_3776E
                move.w  (dword_FFFF08).w,d7
                move.w  d7,d0
                andi.w  #$C800,d0
                beq.w   Boss_AntroidInitIdleState
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$A8,d0
                bpl.s   loc_3771E
                cmpi.w  #$3600,(word_FF8200).w
                bmi.w   Boss_AntroidStartAttackAnim
                btst    #0,d7
                bne.w   Boss_AntroidStartAttackAnim
                move.w  d7,d0
                andi.w  #$14,d0
                beq.w   Boss_AntroidInitJumpAttack
                bra.w   Boss_AntroidInitIdleState
; ---------------------------------------------------------------------------
loc_3771E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+A6   j
                cmpi.w  #$F8,d0
                bpl.s   loc_3772E
                move.w  d7,d0
                andi.w  #$70,d0                         ; 'p'
                beq.w   Boss_AntroidInitJumpAttack
loc_3772E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+CC   j
                move.w  d7,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                bra.w   Boss_AntroidStartAttack2Setup
; ---------------------------------------------------------------------------
loc_3773E:                                              ; CODE XREF: Boss_AntroidInitPhase+9E   j
                                        ; sub_37558:loc_37622   j
                lea     word_38332(pc),a1
                nop
                move.w  (word_FFA000).w,d0
                andi.w  #$FF,d0
                cmpi.w  #$E0,d0
                bmi.s   loc_37758
                lea     word_38344(pc),a1
                nop
loc_37758:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+FA   j
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $11E(a5),a0
                move.w  #$14E,$14(a0)
                bra.w   Boss_AntroidUpdateFlipDirection
; ---------------------------------------------------------------------------
loc_3776E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+8A   j
                move.w  #$32,4(a5)                      ; '2'
                move.w  #$B4,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
; End of function Boss_AntroidTransitionToIdle
; Executes Antroid boss earthquake attack with screen shake and ground slam animation
Boss_AntroidEarthquakeAttack:                           ; DATA XREF: ROM:00037540   o  ; was: sub_37788
                subq.w  #1,$11C(a5)
                bmi.w   loc_37676
                addi.w  #3,(word_FF8234).w
                lea     word_38356(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                move.l  #word_EB77A,$548(a5)
                move.w  #$14E,$554(a5)
                move.l  #word_EB77A,$968(a5)
                move.w  #$14E,$974(a5)
                bra.w   Boss_AntroidUpdateMetaspriteTable
; End of function Boss_AntroidEarthquakeAttack
; Sets boss to idle animation with parameter 8
Boss_AntroidSetIdleAnim:                                ; CODE XREF: Boss_AntroidInitPhase+7C   j  ; was: sub_377C4
                                        ; Boss_AntroidDivingAttack+3C   j
                moveq   #8,d0
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidSetIdleAnim
; Attack state checking phase and initializing attack
Boss_AntroidAttackState1:                               ; DATA XREF: ROM:00037516   o  ; was: sub_377CA
                cmpi.w  #2,$29C(a5)
                bne.s   loc_377D4
                bra.s   Boss_AntroidStartAttack1
; ---------------------------------------------------------------------------
loc_377D4:                                              ; CODE XREF: Boss_AntroidAttackState1+6   j
                lea     word_38360(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $48(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
; Starts attack state 1 with animation index setup
Boss_AntroidStartAttack1:                               ; CODE XREF: Boss_AntroidAttackState1+8   j  ; was: loc_377F0
                moveq   #$A,d0
                bsr.w   Boss_AntroidStartAnimation
; End of function Boss_AntroidAttackState1
; Flying attack state with gravity and proximity checks
Boss_AntroidFlyingAttack:                               ; DATA XREF: ROM:00037518   o  ; was: sub_377F6
                addi.l  #$5000,$1C(a5)
                bmi.s   loc_3787E
                movea.w #(byte_FFCB60-M68K_RAM),a1
                movea.w #(word_FFCF80-M68K_RAM),a0
                tst.w   6(a5)
                beq.s   loc_37810
                exg     a0,a1
loc_37810:                                              ; CODE XREF: Boss_AntroidFlyingAttack+16   j
                cmpi.w  #$14E,$14(a0)
                bmi.s   loc_3787E
                bsr.w   Boss_AntroidPlayAttackSFX
                bmi.s   loc_37846
                tst.w   $1DE(a5)
                beq.s   loc_37830
                cmpi.w  #$D60,$BC(a5)
                bmi.s   loc_37846
                bra.w   Boss_AntroidStartAttack2Setup
; ---------------------------------------------------------------------------
loc_37830:                                              ; CODE XREF: Boss_AntroidFlyingAttack+2C   j
                cmpi.w  #$C70,$BC(a5)
                bmi.s   loc_37846
                cmpi.w  #$D10,$BC(a5)
                bpl.s   loc_37846
                subq.w  #1,$11C(a5)
                bpl.s   loc_3784E
loc_37846:                                              ; CODE XREF: Boss_AntroidFlyingAttack+26   j
                                        ; Boss_AntroidFlyingAttack+34   j
                bsr.w   Boss_AntroidEndAttack
                bra.w   loc_37676
; ---------------------------------------------------------------------------
loc_3784E:                                              ; CODE XREF: Boss_AntroidFlyingAttack+4E   j
                move.w  #2,$23C(a5)
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$70,d0                         ; 'p'
                bpl.s   Boss_AntroidStartAttack2Setup
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1E,d0
                beq.s   Boss_AntroidStartAttack2Setup
                bsr.w   Boss_AntroidEndAttack
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                beq.w   Boss_AntroidStartAttackAnim
                bra.w   Boss_AntroidInitJumpAttack
; ---------------------------------------------------------------------------
loc_3787E:                                              ; CODE XREF: Boss_AntroidFlyingAttack+8   j
                                        ; Boss_AntroidFlyingAttack+20   j
                lea     word_38360(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; ---------------------------------------------------------------------------
; Sets up attack state 2 with animation index
Boss_AntroidStartAttack2Setup:                          ; CODE XREF: Boss_AntroidTransitionToIdle+E4   j  ; was: loc_3788C
                                        ; Boss_AntroidFlyingAttack+36   j
                moveq   #$C,d0
                bsr.w   Boss_AntroidSetAnimIndex
; End of function Boss_AntroidFlyingAttack
; Second attack state variant with different animation
Boss_AntroidAttackState2:                               ; DATA XREF: ROM:0003751A   o  ; was: sub_37892
                cmpi.w  #2,$29C(a5)
                bne.s   loc_3789C
                bra.s   Boss_AntroidStartAttack3
; ---------------------------------------------------------------------------
loc_3789C:                                              ; CODE XREF: Boss_AntroidAttackState2+6   j
                lea     word_3836E(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $48(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
; Starts attack state 3 with animation setup
Boss_AntroidStartAttack3:                               ; CODE XREF: Boss_AntroidAttackState2+8   j  ; was: loc_378B8
                moveq   #$E,d0
                bsr.w   Boss_AntroidStartAnimation
; End of function Boss_AntroidAttackState2
; Diving attack state with vertical movement
Boss_AntroidDivingAttack:                               ; DATA XREF: ROM:0003751C   o  ; was: sub_378BE
                addi.l  #$5000,$1C(a5)
                bmi.w   loc_3794C
                movea.w #(byte_FFCB60-M68K_RAM),a0
                movea.w #(word_FFCF80-M68K_RAM),a1
                tst.w   6(a5)
                beq.s   loc_378DA
                exg     a0,a1
loc_378DA:                                              ; CODE XREF: Boss_AntroidDivingAttack+18   j
                cmpi.w  #$14E,$14(a0)
                bmi.s   loc_3794C
                bsr.w   Boss_AntroidPlayAttackSFX
                bmi.w   loc_37676
                tst.w   $1DE(a5)
                beq.s   loc_378FE
                cmpi.w  #$D60,$BC(a5)
                bmi.w   loc_37676
                bra.w   Boss_AntroidSetIdleAnim
; ---------------------------------------------------------------------------
loc_378FE:                                              ; CODE XREF: Boss_AntroidDivingAttack+30   j
                cmpi.w  #$C70,$BC(a5)
                bmi.w   loc_37676
                cmpi.w  #$D10,$BC(a5)
                bpl.w   loc_37676
                subq.w  #1,$11C(a5)
                bpl.s   loc_3791C
                bra.w   loc_37676
; ---------------------------------------------------------------------------
loc_3791C:                                              ; CODE XREF: Boss_AntroidDivingAttack+58   j
                move.w  #2,$23C(a5)
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$70,d0                         ; 'p'
                bpl.w   Boss_AntroidSetIdleAnim
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7800,d0
                beq.w   Boss_AntroidSetIdleAnim
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                beq.w   Boss_AntroidStartAttackAnim
                bra.w   Boss_AntroidInitJumpAttack
; ---------------------------------------------------------------------------
loc_3794C:                                              ; CODE XREF: Boss_AntroidDivingAttack+8   j
                                        ; Boss_AntroidDivingAttack+22   j
                lea     word_3836E(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; End of function Boss_AntroidDivingAttack
; Starts boss animation sequence with parameter
Boss_AntroidStartAnimation:                             ; CODE XREF: Boss_AntroidAttackState1+28   p  ; was: sub_3795A
                                        ; Boss_AntroidAttackState2+28   p
                move.w  d0,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFE4000,$1C(a5)
                move.l  #$40000,$18(a5)
                tst.w   $54(a5)
                beq.s   locret_37980
                neg.l   $18(a5)
locret_37980:                                           ; CODE XREF: Boss_AntroidStartAnimation+20   j
                rts
; End of function Boss_AntroidStartAnimation
; Plays attack sound and applies screen shake
Boss_AntroidPlayAttackSFX:                              ; CODE XREF: Boss_AntroidFlyingAttack+22   p  ; was: sub_37982
                                        ; Boss_AntroidDivingAttack+24   p
                move.b  #$AF,d0
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                tst.w   $1DE(a5)
                bne.s   locret_3799E
                subi.w  #$A,(word_FF8234).w
locret_3799E:                                           ; CODE XREF: Boss_AntroidPlayAttackSFX+14   j
                rts
; End of function Boss_AntroidPlayAttackSFX
; Initializes jump attack updating flip and loading animation
Boss_AntroidInitJumpAttack:                             ; CODE XREF: Boss_AntroidTransitionToIdle+C0   j  ; was: sub_379A0
                                        ; Boss_AntroidTransitionToIdle+D4   j
                bsr.w   Boss_AntroidUpdateFlipDirection
                moveq   #$10,d0
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidInitJumpAttack
; Jump attack state with gravity physics and landing check
Boss_AntroidJumpAttackState:                            ; DATA XREF: ROM:0003751E   o  ; was: sub_379AA
                cmpi.w  #3,$29C(a5)
                beq.s   loc_379C4
                lea     word_3837C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bra.w   Boss_AntroidUpdateMetaspriteTable
; ---------------------------------------------------------------------------
loc_379C4:                                              ; CODE XREF: Boss_AntroidJumpAttackState+6   j
                subi.w  #$3C,(word_FF8234).w            ; '<'
                addq.w  #2,4(a5)
                move.w  #2,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF30000,$1C(a5)
                move.l  #$38000,$18(a5)
                tst.w   $23C(a5)
                bne.s   loc_379FA
                move.l  #$28000,$18(a5)
loc_379FA:                                              ; CODE XREF: Boss_AntroidJumpAttackState+46   j
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpApplyGravity
                neg.l   $18(a5)
; Applies gravity during jump and checks floor collision
Boss_AntroidJumpApplyGravity:                           ; CODE XREF: Boss_AntroidJumpAttackState+54   j  ; was: loc_37A04
                                        ; DATA XREF: ROM:00037520   o
                addi.l  #$C000,$1C(a5)
                bmi.s   loc_37A22
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$142,d0
                bmi.s   loc_37A22
                sub.w   d0,$14(a5)
                bra.s   loc_37A30
; ---------------------------------------------------------------------------
loc_37A22:                                              ; CODE XREF: Boss_AntroidJumpAttackState+62   j
                                        ; Boss_AntroidJumpAttackState+70   j
                lea     word_3837C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37A30:                                              ; CODE XREF: Boss_AntroidJumpAttackState+76   j
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                addq.w  #2,4(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
; Jump attack fall state with gravity application
Boss_AntroidJump_FallCheck:                             ; DATA XREF: ROM:00037522   o  ; was: loc_37A60
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_37A78
                movea.w $17E(a5),a0
                cmpi.w  #$14E,$14(a0)
                bpl.w   Boss_AntroidTransitionToIdle
loc_37A78:                                              ; CODE XREF: Boss_AntroidJumpAttackState+BE   j
                lea     word_3832C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bra.w   Boss_AntroidUpdateMetaspriteTable
; End of function Boss_AntroidJumpAttackState
; Updates boss flip direction and loads attack animation table
Boss_AntroidStartAttackAnim:                            ; CODE XREF: Boss_AntroidTransitionToIdle+AE   j  ; was: sub_37A8A
                                        ; Boss_AntroidTransitionToIdle+B6   j
                bsr.w   Boss_AntroidUpdateFlipDirection
                moveq   #$26,d0                         ; '&'
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidStartAttackAnim
; Complex jump slam attack with trajectory tracking, ground detection, and damage triggers
Boss_AntroidJumpSlamAttack:                             ; DATA XREF: ROM:00037534   o  ; was: sub_37A94
                cmpi.w  #3,$29C(a5)
                beq.s   loc_37AAA
                lea     word_383A0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37AAA:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+6   j
                                        ; Boss_AntroidJumpSlamAttack+1FE   j
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$28,4(a5)                      ; '('
                move.w  #2,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF78000,$1C(a5)
                move.l  #$FFFE1000,$18(a5)
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpSlamAttack_ApplyGravity
                neg.l   $18(a5)
; Applies gravity during jump slam descent phase
Boss_AntroidJumpSlamAttack_ApplyGravity:                ; CODE XREF: Boss_AntroidJumpSlamAttack+48   j  ; was: loc_37AE2
                                        ; DATA XREF: ROM:00037536   o
                subi.w  #$10,$56(a5)
                addi.l  #$8000,$1C(a5)
                bmi.s   loc_37B00
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$14A,d0
                bpl.s   loc_37B0E
loc_37B00:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+5C   j
                lea     word_383A0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37B0E:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+6A   j
                subi.w  #$58,(word_FF8234).w            ; 'X'
                bmi.s   loc_37B52
                tst.w   $54(a5)
                beq.s   loc_37B26
                cmpi.w  #$D38,$BC(a5)
                bpl.s   loc_37B52
                bra.s   loc_37B2E
; ---------------------------------------------------------------------------
loc_37B26:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+86   j
                cmpi.w  #$C48,$BC(a5)
                bmi.s   loc_37B52
loc_37B2E:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+90   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$380,d0
                beq.s   loc_37B52
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$88,d0
                bmi.w   loc_37C74
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$2A00,d0
                beq.w   loc_37C74
loc_37B52:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+80   j
                                        ; Boss_AntroidJumpSlamAttack+8E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,(word_FFA010).w
                clr.w   $56(a5)
                move.w  a5,$48(a5)
                movea.w $17E(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                clr.l   $1C(a5)
; Jump slam pre-impact horizontal deceleration
Boss_AntroidJumpSlam_DecelerateX:                       ; DATA XREF: ROM:00037538   o  ; was: loc_37B80
                tst.w   $58(a5)
                bmi.s   loc_37BA6
                move.l  #$1800,d0
                tst.l   $18(a5)
                bpl.s   loc_37B94
                neg.l   d0
loc_37B94:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+FC   j
                sub.l   d0,$18(a5)
                lea     word_383B6(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37BA6:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+F0   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                move.l  #word_EB720,$C8(a5)
                move.w  #5,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF80000,$1C(a5)
                move.l  #$78000,$18(a5)
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpSlam_AccelerateDown
                neg.l   $18(a5)
; Accelerates boss downward during jump slam attack
Boss_AntroidJumpSlam_AccelerateDown:                    ; CODE XREF: Boss_AntroidJumpSlamAttack+154   j  ; was: loc_37BEE
                                        ; DATA XREF: ROM:0003753A   o
                addi.l  #$8000,$1C(a5)
                bmi.s   loc_37C06
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$14C,d0
                bpl.s   loc_37C14
loc_37C06:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+162   j
                lea     word_383C0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37C14:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+170   j
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #word_EB732,$C8(a5)
                clr.w   $56(a5)
                move.w  #$A,$17C(a5)
                move.w  a5,$48(a5)
                movea.w $17E(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                clr.l   $1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
; Jump slam timer check with animation interpolation
Boss_AntroidJumpSlam_TimerCheck:                        ; DATA XREF: ROM:0003753C   o  ; was: loc_37C5E
                subq.w  #1,$17C(a5)
                bmi.w   loc_37676
                lea     word_383CE(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37C74:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+AE   j
                                        ; Boss_AntroidJumpSlamAttack+BA   j
                moveq   #$30,d0                         ; '0'
                bsr.w   Boss_AntroidLoadAnimTable
                move.w  #3,(word_FFA010).w
                move.l  #word_EB720,$C8(a5)
                clr.w   $56(a5)
; Waits for animation frame 3 completion before next action
Boss_AntroidJumpSlam_WaitComplete:                      ; DATA XREF: ROM:0003753E   o  ; was: loc_37C8C
                cmpi.w  #3,$29C(a5)
                beq.w   loc_37AAA
                lea     word_38394(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; End of function Boss_AntroidJumpSlamAttack
; Sets idle animation index for Antroid boss
Boss_AntroidInitIdleState:                              ; CODE XREF: Boss_AntroidTransitionToIdle+98   j  ; was: sub_37CA4
                                        ; Boss_AntroidTransitionToIdle+C4   j
                moveq   #$16,d0
                bsr.w   Boss_AntroidSetAnimIndex
; End of function Boss_AntroidInitIdleState
; Wait state with timer countdown and projectile spawning
Boss_AntroidWaitState:                                  ; DATA XREF: ROM:00037524   o  ; was: sub_37CAA
                tst.w   $58(a5)
                bmi.s   loc_37CBE
                lea     word_383D4(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37CBE:                                              ; CODE XREF: Boss_AntroidWaitState+4   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
; Wait state countdown with projectile spawning
Boss_AntroidWait_CountdownCheck:                        ; DATA XREF: ROM:00037526   o  ; was: loc_37CD6
                move.w  #1,(word_FFA010).w
                subq.w  #1,$11C(a5)
                bpl.s   loc_37D0C
                tst.w   $23E(a5)
                beq.s   loc_37D0C
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
                move.w  $4A(a5),$48(a5)
                clr.w   $29C(a5)
                bra.w   Boss_AntroidIdleUpdate
; ---------------------------------------------------------------------------
loc_37D0C:                                              ; CODE XREF: Boss_AntroidWaitState+36   j
                                        ; Boss_AntroidWaitState+3C   j
                btst    #1,(word_FFA000+1).w
                beq.s   loc_37D18
                subq.w  #1,(word_FF8234).w
loc_37D18:                                              ; CODE XREF: Boss_AntroidWaitState+68   j
                bsr.w   Boss_AntroidSpawnProjectile
                lea     word_383E2(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bsr.w   Boss_AntroidUpdateMetaspriteTable
                movea.w $11E(a5),a0
                move.w  #$14E,$14(a0)
                rts
; End of function Boss_AntroidWaitState
; Boss charge attack with distance check
Boss_AntroidChargeAttack:                               ; CODE XREF: Boss_AntroidMainHandler+22   j  ; was: sub_37D3A
                move.w  #$1E,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #1,$11C(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$20000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$CC0,$BC(a5)
                bmi.w   loc_37D96
                neg.l   $18(a5)
                clr.w   $54(a5)
loc_37D96:                                              ; CODE XREF: Boss_AntroidChargeAttack+50   j
                bsr.w   Boss_AntroidUpdateFlipDirection
; End of function Boss_AntroidChargeAttack
; Boss ram attack with collision
Boss_AntroidRamAttack:                                  ; DATA XREF: ROM:0003752C   o  ; was: sub_37D9A
                cmpi.w  #$180,$56(a5)
                beq.s   loc_37DAC
                subq.w  #8,$56(a5)
                andi.w  #$1FE,$56(a5)
loc_37DAC:                                              ; CODE XREF: Boss_AntroidRamAttack+6   j
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_AntroidUpdateMetaspriteFlipped
                addi.l  #$4000,$1C(a5)
                bmi.s   locret_37DF4
                cmpi.w  #$148,$14(a5)
                bmi.w   locret_37DF4
                move.w  #5,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                subq.w  #1,$11C(a5)
                bpl.w   loc_37DF6
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$148,$14(a5)
locret_37DF4:                                           ; CODE XREF: Boss_AntroidRamAttack+24   j
                                        ; Boss_AntroidRamAttack+2C   j
                rts
; ---------------------------------------------------------------------------
loc_37DF6:                                              ; CODE XREF: Boss_AntroidRamAttack+40   j
                move.l  #$FFFE0000,$1C(a5)
                rts
; End of function Boss_AntroidRamAttack
; Boss death state with palette fade and timer progression
Boss_AntroidDeathFadeState:                             ; DATA XREF: ROM:0003752E   o  ; was: sub_37E00
                jsr     (Gfx_UpdatePaletteFade).l
                addq.w  #1,$11C(a5)
                move.w  $11C(a5),d0
                cmpi.w  #$A0,d0
                bpl.s   Boss_AntroidEnterDefeatedState
                subi.w  #$90,d0
                bmi.s   loc_37E1E
                bsr.w   Gfx_SetFadeParamsThunk
loc_37E1E:                                              ; CODE XREF: Boss_AntroidDeathFadeState+18   j
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
; End of function Boss_AntroidDeathFadeState
; Updates boss metasprite with horizontal flip toggle
Boss_AntroidUpdateMetaspriteFlipped:                    ; CODE XREF: Boss_AntroidRamAttack+18   p  ; was: sub_37E2A
                bsr.w   Boss_AntroidSpawnDebris
                lea     word_383EE(pc),a1
                nop
                jsr     Anim_InterpolateToTarget(pc)    ; (pc)
                nop
                bsr.w   Boss_AntroidSetupMetasprite
                move.l  #word_EB720,$C8(a5)
                bset    #4,$CE(a5)
                eori.w  #$800,$CE(a5)
                rts
; End of function Boss_AntroidUpdateMetaspriteFlipped
; Transitions boss to defeated state clearing objects
Boss_AntroidEnterDefeatedState:                         ; CODE XREF: Boss_AntroidDeathFadeState+12   j  ; was: sub_37E54
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$14,6(a5)
                moveq   #$30,d0                         ; '0'
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
; End of function Boss_AntroidEnterDefeatedState
; Death sequence timer with fade effect
Boss_AntroidDeathTimer:                                 ; DATA XREF: ROM:00037530   o  ; was: sub_37E6C
                subq.w  #1,6(a5)
                move.w  6(a5),d0
                bpl.s   loc_37E7E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_37E7E:                                              ; CODE XREF: Boss_AntroidDeathTimer+8   j
                cmpi.w  #$10,d0
                bmi.w   Gfx_SetFadeParamsThunk
                moveq   #$10,d0
                bra.w   Gfx_SetFadeParamsThunk
; End of function Boss_AntroidDeathTimer
; Updates boss sprite graphics and animation
Boss_AntroidUpdateSprite:                               ; CODE XREF: Boss_AntroidIdleState+A   j  ; was: sub_37E8C
                                        ; Boss_AntroidTransitionToIdle+3A   p
                move.l  #word_EB732,$C8(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #$7F,d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   Boss_AntroidSetupMetasprite
                btst    #1,d0
                beq.s   Boss_AntroidSetupMetasprite
                move.l  #word_EB720,$C8(a5)
; End of function Boss_AntroidUpdateSprite
; Sets up boss metasprite rendering
Boss_AntroidSetupMetasprite:                            ; CODE XREF: Boss_AntroidEarthquakeAttack+18   p  ; was: sub_37EB0
                                        ; Boss_AntroidJumpAttackState+12   p
                moveq   #$18,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_AntroidSetupMetasprite
; Switches metasprite table based on frame counter for animation variety
Boss_AntroidUpdateMetaspriteTable:                      ; CODE XREF: Boss_AntroidEarthquakeAttack+38   j  ; was: sub_37EB8
                                        ; Boss_AntroidJumpAttackState+16   j
                move.l  #word_EB732,$C8(a5)
                btst    #1,(word_FFA000+1).w
                beq.s   locret_37ED0
                move.l  #word_EB720,$C8(a5)
locret_37ED0:                                           ; CODE XREF: Boss_AntroidUpdateMetaspriteTable+E   j
                rts
; End of function Boss_AntroidUpdateMetaspriteTable
; Loads animation table pointer for boss
Boss_AntroidLoadAnimTable:                              ; CODE XREF: Boss_AntroidTransitionToIdle+E   p  ; was: sub_37ED2
                                        ; Boss_AntroidTransitionToIdle+22   p
                movea.w #(byte_FFCB60-M68K_RAM),a0
                movea.w #(word_FFCF80-M68K_RAM),a1
                bra.s   loc_37EE4
; End of function Boss_AntroidLoadAnimTable
; Sets boss animation index from parameter
Boss_AntroidSetAnimIndex:                               ; CODE XREF: Boss_AntroidFlyingAttack+98   p  ; was: sub_37EDC
                                        ; Boss_AntroidInitIdleState+2   p
                movea.w #(byte_FFCB60-M68K_RAM),a1
                movea.w #(word_FFCF80-M68K_RAM),a0
loc_37EE4:                                              ; CODE XREF: Boss_AntroidLoadAnimTable+8   j
                move.w  d0,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                tst.w   6(a5)
                beq.s   loc_37F06
                exg     a0,a1
loc_37F06:                                              ; CODE XREF: Boss_AntroidSetAnimIndex+26   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                move.w  a1,$11E(a5)
                move.w  a0,$17E(a5)
                move.l  #word_EB732,$C8(a5)
                rts
; End of function Boss_AntroidSetAnimIndex
; Spawns debris projectiles at random offsets
Boss_AntroidSpawnDebris:                                ; CODE XREF: Boss_AntroidUpdateMetaspriteFlipped   p  ; was: sub_37F26
                btst    #0,(word_FFA000+1).w
                bne.s   locret_37F76
                jsr     (Projectile_InitTypeA4).l
                bne.s   locret_37F76
                movea.l #dword_2ABF0,a1                 ; make offsets?
                jsr     (Projectile_FindFreeSlotComplex).l
                move.b  #0,$20(a0)
                move.l  #$FFFE8000,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$F,d1
                subi.w  #$20,d0                         ; ' '
                subq.w  #8,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_37F76:                                           ; CODE XREF: Boss_AntroidSpawnDebris+6   j
                                        ; Boss_AntroidSpawnDebris+E   j
                rts
; End of function Boss_AntroidSpawnDebris
; Attributes: thunk
; Thunk wrapper that jumps to graphics fade parameter setting function
Gfx_SetFadeParamsThunk:                                 ; CODE XREF: Boss_AntroidDeathFadeState+1A   p  ; was: sub_37F78
                                        ; Boss_AntroidDeathTimer+16   j
                jmp     (Gfx_SetFadeParams).l
; End of function Gfx_SetFadeParamsThunk
; Updates boss flip direction based on player position
Boss_AntroidUpdateFlipDirection:                        ; CODE XREF: Boss_AntroidTransitionToIdle+114   j  ; was: sub_37F7E
                                        ; sub_379A0   p
                jsr     (Physics_CalculateDistanceTo).l
                move.w  $54(a5),d7
                move.w  #$100,$54(a5)
                tst.w   d1
                bmi.s   loc_37F98
                move.w  #0,$54(a5)
loc_37F98:                                              ; CODE XREF: Boss_AntroidUpdateFlipDirection+12   j
                cmp.w   $54(a5),d7
                beq.w   locret_37FEA
; End of function Boss_AntroidUpdateFlipDirection
; Initializes boss physics and movement parameters
Boss_AntroidInitPhysics:                                ; CODE XREF: Boss_AntroidInitPhase+78   p  ; was: sub_37FA0
                                        ; Boss_AntroidInitPosition+1E   p
                moveq   #3,d0
                tst.w   $54(a5)
                bne.s   loc_37FCA
                bset    d0,$E(a5)
                bset    d0,$6E(a5)
                bclr    d0,$CE(a5)
                bset    d0,$12E(a5)
                bset    d0,$18E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$42E(a5)
                bset    d0,$84E(a5)
                rts
; ---------------------------------------------------------------------------
loc_37FCA:                                              ; CODE XREF: Boss_AntroidInitPhysics+6   j
                bclr    d0,$E(a5)
                bclr    d0,$6E(a5)
                bset    d0,$CE(a5)
                bclr    d0,$12E(a5)
                bclr    d0,$18E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$42E(a5)
                bclr    d0,$84E(a5)
locret_37FEA:                                           ; CODE XREF: Boss_AntroidUpdateFlipDirection+1E   j
                rts
; End of function Boss_AntroidInitPhysics
; Spawns Antroid projectile with velocity calculation
Boss_AntroidSpawnProjectile:                            ; CODE XREF: Boss_AntroidWaitState:loc_37D18   p  ; was: sub_37FEC
                btst    #0,(word_FFA000+1).w
                bne.w   locret_380A2
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_380A2
                move.w  #$158,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C3C3,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #8,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FA06FA06,$2C(a0)
                move.w  #$3A,$26(a0)                    ; ':'
                move.w  $D0(a5),$10(a0)
                move.w  $D4(a5),$14(a0)
                addq.w  #8,$10(a0)
                addq.w  #8,$14(a0)
                move.w  #5,$48(a0)
                clr.w   $4A(a0)
                move.l  #$1200,$4C(a0)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                sub.w   $11C(a5),d1
                addq.w  #2,d1
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                add.w   d1,d0
                swap    d0
                asr.l   #2,d0
                move.l  d0,$18(a0)
                moveq   #0,d0
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                swap    d0
                neg.l   d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                tst.w   $54(a5)
                beq.s   locret_380A2
                neg.l   $18(a0)
                neg.l   $4C(a0)
                subi.w  #$10,$10(a0)
locret_380A2:                                           ; CODE XREF: Boss_AntroidSpawnProjectile+6   j
                                        ; Boss_AntroidSpawnProjectile+10   j
                rts
; End of function Boss_AntroidSpawnProjectile
; Updates Antroid projectile with fade and collision
Boss_AntroidProjectileUpdate:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_380A4
                tst.w   (word_FF808C).w
                bpl.s   loc_380FA
                bclr    #7,$22(a5)
                beq.s   loc_380C4
                bclr    #4,$22(a5)
                beq.s   loc_380FA
                move.w  #3,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_380C4:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+C   j
                move.l  $4C(a5),d0
                sub.l   d0,$18(a5)
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_380EA
                cmpi.w  #$144,$14(a5)
                bmi.s   loc_380EA
                move.l  #$FFFD8000,$1C(a5)
                clr.b   $21(a5)
loc_380EA:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+30   j
                                        ; Boss_AntroidProjectileUpdate+38   j
                subq.w  #1,$48(a5)
                bpl.s   locret_38112
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bmi.s   Boss_AntroidProjectileFade
loc_380FA:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+4   j
                                        ; Boss_AntroidProjectileUpdate+14   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Applies fade palette to projectile during animation
Boss_AntroidProjectileFade:                             ; CODE XREF: Boss_AntroidProjectileUpdate+54   j  ; was: loc_38102
                move.w  word_38114(pc,d0.w),$E(a5)
                move.w  #6,$48(a5)
                addq.w  #2,$4A(a5)
locret_38112:                                           ; CODE XREF: Boss_AntroidProjectileUpdate+4A   j
                rts
; End of function Boss_AntroidProjectileUpdate
; ---------------------------------------------------------------------------
word_38114:     dc.w    $C3C7, $C3CB, $C3CF
                                        ; DATA XREF: Boss_AntroidProjectileUpdate:loc_38102   r

; Interpolates animation values toward target state
Anim_InterpolateToTarget:                               ; CODE XREF: Boss_AntroidIdleState+6   p  ; was: sub_3811A
                                        ; Boss_AntroidTransitionToIdle+36   p
                clr.w   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_3819C
loc_38124:                                              ; CODE XREF: Anim_InterpolateToTarget+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_381AC
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_38146
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_38146:                                              ; CODE XREF: Anim_InterpolateToTarget+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_38156
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_38156:                                              ; CODE XREF: Anim_InterpolateToTarget+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_38166
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_38124
; ---------------------------------------------------------------------------
loc_38166:                                              ; CODE XREF: Anim_InterpolateToTarget+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_383F8,d0
                movea.l d0,a0
                bsr.w   Boss_AntroidResetAnimation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                addq.w  #1,$23E(a5)
                tst.w   $C(a5)
                bmi.s   loc_381AC
loc_3819C:                                              ; CODE XREF: Anim_InterpolateToTarget+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$E,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_381AC:                                              ; CODE XREF: Anim_InterpolateToTarget+E   j
                                        ; Anim_InterpolateToTarget+80   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$176(a5)
                movea.w #(dword_FF940C-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                movea.w #(dword_FF9424-M68K_RAM),a2
                movea.w #(dword_FF9430-M68K_RAM),a3
                tst.w   6(a5)
                beq.s   loc_381F2
                exg     a0,a1
                exg     a2,a3
loc_381F2:                                              ; CODE XREF: Anim_InterpolateToTarget+D2   j
                move.b  (a0),d2
                asl.w   #1,d2
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$1D6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$236(a5)
                move.w  d1,$296(a5)
                move.b  8(a0),d2
                asl.w   #1,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$2F6(a5)
                move.w  d2,$356(a5)
                move.b  (a1),d2
                asl.w   #1,d2
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$5F6(a5)
                move.b  4(a1),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  8(a1),d2
                asl.w   #1,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$716(a5)
                move.w  d2,$776(a5)
                move.b  (a2),d0
                asl.w   #1,d0
                add.w   d3,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  4(a2),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  8(a2),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.b  (a3),d0
                asl.w   #1,d0
                add.w   d3,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.w  d0,$896(a5)
                move.b  4(a3),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$8F6(a5)
                move.w  d1,$956(a5)
                move.b  8(a3),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Anim_InterpolateToTarget
; Resets boss animation to initial state
Boss_AntroidResetAnimation:                             ; CODE XREF: Anim_InterpolateToTarget+62   p  ; was: sub_382BC
                movea.l #word_34A36,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$E,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_AntroidResetAnimation
; Loads animation frame delay data for 14 frames of Antroid animation
Boss_AntroidLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1     ; was: sub_382D2
                moveq   #$E,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_AntroidLoadFrameDelays
; Calculates vertical offset based on two sprite positions for composite rendering
Boss_AntroidCalculateYOffset:
                move.w  $974(a5),d0                     ; was: sub_382DE
                move.w  $554(a5),d1
                cmp.w   d0,d1
                bpl.s   loc_382EC
                move.w  d0,d1
loc_382EC:                                              ; CODE XREF: Boss_AntroidCalculateYOffset+A   j
                move.w  #$14C,d0
                sub.w   d1,d0
                add.w   d0,$14(a5)
                rts
; End of function Boss_AntroidCalculateYOffset
; Ends attack phase and returns to idle
Boss_AntroidEndAttack:                                  ; CODE XREF: Boss_AntroidFlyingAttack:loc_37846   p  ; was: sub_382F8
                                        ; Boss_AntroidFlyingAttack+74   p
                eori.w  #2,6(a5)
                movea.w #(dword_FF940C-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                movea.w #(dword_FF9424-M68K_RAM),a2
                movea.w #(dword_FF9430-M68K_RAM),a3
                moveq   #2,d7
; Swaps palette buffers for boss color animation
Boss_AntroidSwapPaletteBuffers:                         ; CODE XREF: Boss_AntroidEndAttack+24   j  ; was: loc_38310
                move.l  (a0),d0
                move.l  (a1),(a0)+
                move.l  d0,(a1)+
                move.l  (a2),d0
                move.l  (a3),(a2)+
                move.l  d0,(a3)+
                dbf     d7,Boss_AntroidSwapPaletteBuffers
                rts
; End of function Boss_AntroidEndAttack
; ---------------------------------------------------------------------------
word_38322:     dc.w    $2020, $60, $2020, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidIdleState   o
word_3832C:     dc.w    $131B, $70, $FFFE               ; DATA XREF: Boss_AntroidTransitionToIdle+30   o
                                        ; sub_379AA:loc_37A78   o
word_38332:     dc.w    $80C, $60, $808, $60, $80C, $70, $808, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidTransitionToIdle:loc_3773E   o
word_38344:     dc.w    $204, $60, $202, $60, $204, $70, $202, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidTransitionToIdle+FC   o
word_38356:     dc.w    $214, $E0, $106, $60, $FFFF
                                        ; DATA XREF: Boss_AntroidEarthquakeAttack+E   o
word_38360:     dc.w    $1313, $30, $A1E, $40, $2828, $40, $FFFE
                                        ; DATA XREF: Boss_AntroidAttackState1:loc_377D4   o
                                        ; sub_377F6:loc_3787E   o
word_3836E:     dc.w    $1313, $50, $A1E, $20, $2828, $20, $FFFE
                                        ; DATA XREF: Boss_AntroidAttackState2:loc_3789C   o
                                        ; sub_378BE:loc_3794C   o
word_3837C:     dc.w    $910, $90, $D0D, $90, $80D0, $80B, $A0, $410, $A0, $1010, $B0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpAttackState+8   o
                                        ; sub_379AA:loc_37A22   o
word_38394:     dc.w    $60A, $90, $505, $90, $80B, $A0
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+202   o
word_383A0:     dc.w    $910, $90, $F0F, $90, $410, $C0, $C0C, $C0, $1313, $E0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+8   o
                                        ; sub_37A94:loc_37B00   o
word_383B6:     dc.w    $608, $F0, $E0E, $F0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+104   o
word_383C0:     dc.w    $C0C, $D0, $606, $D0, $E0E, $E0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack:loc_37C06   o
word_383CE:     dc.w    $808, $E0, $FFFE                ; DATA XREF: Boss_AntroidJumpSlamAttack+1D2   o
word_383D4:     dc.w    $181C, $100, $A0A, $100, $608, $110, $FFFE
                                        ; DATA XREF: Boss_AntroidWaitState+6   o
word_383E2:     dc.w    $203, $110, $130, $60, $80A9, $FFFF
                                        ; DATA XREF: Boss_AntroidWaitState+72   o
word_383EE:     dc.w    $808, 0, $808, $10, $FFFF
                                        ; DATA XREF: Boss_AntroidUpdateMetaspriteFlipped+4   o
word_383F8:     binclude "data/other/word_383F8.bin"
word_383F8_End:

; Main Terobuster boss handler with state dispatch
Boss_TerobusterMain:                                    ; DATA XREF: ROM:off_5DC   o  ; was: sub_38518
                tst.w   4(a5)
                beq.w   loc_38566
                jsr     (Gfx_InitPaletteFade).l
                tst.w   8(a5)
                beq.s   loc_38566
                btst    #2,(byte_FF80EC).w
                bne.s   loc_38544
                btst    #1,(byte_FF80EC).w
                bne.s   loc_38544
                tst.w   (word_FF8200).w
                beq.w   Boss_TerobusterBattleState
loc_38544:                                              ; CODE XREF: Boss_TerobusterMain+1A   j
                                        ; Boss_TerobusterMain+22   j
                lea     word_3859C(pc),a0
                nop
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),$1DE(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_38566:                                              ; CODE XREF: Boss_TerobusterMain+4   j
                                        ; Boss_TerobusterMain+12   j
                move.w  4(a5),d0
                movea.w off_38576(pc,d0.w),a0
                adda.l  #word_3859C,a0
                jmp     (a0)
; End of function Boss_TerobusterMain
; ---------------------------------------------------------------------------
off_38576:      dc.w    Boss_TerobusterInit-word_3859C
                                        ; DATA XREF: Boss_TerobusterMain+52   r
                dc.w    Boss_TerobusterSetup-word_3859C
                dc.w    Boss_TerobusterMainAI-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState3-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState4-word_3859C
                dc.w    Boss_TerobusterAttackPattern1-word_3859C
                dc.w    Boss_TerobusterAttackPattern3-word_3859C
                dc.w    Boss_TerobusterDefeatInit-word_3859C
                dc.w    Boss_TerobusterFadeIn-word_3859C
                dc.w    Boss_TerobusterDescend-word_3859C
                dc.w    Boss_TerobusterDescend_FallingState-word_3859C
                dc.w    Boss_TerobusterDescend_LandingState-word_3859C
                dc.w    Boss_TerobusterBattleEnd-word_3859C
                dc.w    Boss_TerobusterPostBattleCleanup-word_3859C
                dc.w    Boss_TerobusterMainAI_AttackState4-word_3859C
                dc.w    Boss_TerobusterMainAI_RockAttackLoop-word_3859C
                dc.w    Boss_TerobusterMainAI-word_3859C
                dc.w    Boss_TerobusterDefeatTimer-word_3859C
                dc.w    Boss_TerobusterDefeatComplete-word_3859C
word_3859C:     dc.w    0, 2, 4, 2                      ; DATA XREF: Boss_TerobusterMain:loc_38544   o
                                        ; Boss_TerobusterMain+56   o

; Initializes Terobuster boss clearing sprites and setting flags
Boss_TerobusterInit:                                    ; DATA XREF: ROM:off_38576   o  ; was: sub_385A4
                addq.w  #2,4(a5)
                move.b  #1,(byte_FF830E).w
                move.w  #1,8(a5)
                move.w  #$B4,d0
                move.w  #$12C,d1
                jsr     (Sprite_ClearAllExcept).l
                move.w  #$80,$48(a5)
locret_385C8:                                           ; CODE XREF: Boss_TerobusterSetup+4   j
                                        ; Boss_TerobusterSetup+A   j
                rts
; End of function Boss_TerobusterInit
; Sets up Terobuster boss with complex metasprite initialization
Boss_TerobusterSetup:                                   ; DATA XREF: ROM:00038578   o  ; was: sub_385CA
                tst.b   (word_FFF720).w
                bmi.s   locret_385C8
                subq.w  #1,$48(a5)
                bpl.s   locret_385C8
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$A,d7
                movea.l #dword_34A8C,a0
                movea.l #word_34AB8,a1
                movea.l #word_34AC4,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$B4,(a5)
                clr.w   $54(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $A(a5)
                move.w  #$D00,2(a5)
                move.w  #$200,$10(a5)
                move.w  #$C100,$1E2(a5)
                move.w  #$C100,$3C2(a5)
                move.w  #$10,$420(a5)
                move.w  #$8000,$422(a5)
                move.w  #$6467,$42E(a5)
                move.w  #$800,$428(a5)
                move.w  #$F4FC,$42A(a5)
                move.b  #$10,$440(a5)
                move.w  #$10,$480(a5)
                move.w  #$C000,$482(a5)
                move.w  #$B00,$48E(a5)
                move.l  #word_EB86A,$488(a5)
                move.b  #$10,$4A0(a5)
                movea.l #word_1BB4C,a1
                jsr     (Sprite_InitFromPointerTable).l
                lea     word_3868A(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                bra.w   Boss_TerobusterIntro
; ---------------------------------------------------------------------------
word_3868A:     dc.w    $6100, $2000, $201, $2A2B, $2C2D, $2E2F
                                        ; DATA XREF: Boss_TerobusterSetup+B0   o
; ---------------------------------------------------------------------------
loc_38696:                                              ; CODE XREF: Boss_TerobusterMainAI+F2   j
                                        ; Boss_TerobusterMainAI+1AC   j
                move.w  #2,$A(a5)
                bra.s   loc_386A2
; ---------------------------------------------------------------------------
loc_3869E:                                              ; CODE XREF: Boss_TerobusterMainAI+EE   j
                                        ; Boss_TerobusterMainAI+1A8   j
                clr.w   $A(a5)
loc_386A2:                                              ; CODE XREF: Boss_TerobusterSetup+D2   j
                                        ; Boss_TerobusterMainAI+286   j
                move.w  #4,4(a5)
                tst.w   (word_FF8234).w
                beq.s   loc_386B0
                bpl.s   loc_386B6
loc_386B0:                                              ; CODE XREF: Boss_TerobusterSetup+E2   j
                move.w  #$20,4(a5)                      ; ' '
loc_386B6:                                              ; CODE XREF: Boss_TerobusterSetup+E4   j
                move.w  #$10,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_386D6
                exg     a0,a1
loc_386D6:                                              ; CODE XREF: Boss_TerobusterSetup+108   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                lea     word_3936A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
; End of function Boss_TerobusterSetup
; Complex boss AI state machine with attack patterns
Boss_TerobusterMainAI:                                  ; DATA XREF: ROM:0003857A   o  ; was: sub_386EE
                                        ; ROM:00038596   o
                cmpi.w  #$20,4(a5)                      ; ' '
                bne.s   loc_3870A
                addi.w  #$C,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3876C
                move.w  #$1E0,(word_FF8234).w
loc_3870A:                                              ; CODE XREF: Boss_TerobusterMainAI+6   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_3876C
                jsr     (Physics_CalculateDistanceTo).l
                addi.w  #$28,d1                         ; '('
                tst.w   d1
                bmi.s   loc_38732
                tst.w   (word_FFFF0E).w
                beq.s   loc_38744
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.w   loc_38826
                bra.s   loc_38744
; ---------------------------------------------------------------------------
loc_38732:                                              ; CODE XREF: Boss_TerobusterMainAI+2E   j
                btst    #7,(word_FFA000+1).w
                beq.s   loc_38744
                cmpi.w  #$1180,$BC(a5)
                bmi.w   loc_388F0
loc_38744:                                              ; CODE XREF: Boss_TerobusterMainAI+34   j
                                        ; Boss_TerobusterMainAI+42   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                cmpi.w  #$1190,$BC(a5)
                bpl.w   loc_38774
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   loc_38826
                bra.w   loc_38834
; ---------------------------------------------------------------------------
loc_3876C:                                              ; CODE XREF: Boss_TerobusterMainAI+14   j
                                        ; Boss_TerobusterMainAI+20   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38774:                                              ; CODE XREF: Boss_TerobusterMainAI+6A   j
                move.w  #6,4(a5)
                move.w  #8,$58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $1DC(a5)
; Terobuster boss attack state with missile spawning
Boss_TerobusterMainAI_AttackState3:                     ; DATA XREF: ROM:0003857C   o  ; was: loc_3878A
                cmpi.w  #8,$58(a5)
                beq.s   loc_3879A
                cmpi.w  #$18,$58(a5)
                bne.s   loc_387E4
loc_3879A:                                              ; CODE XREF: Boss_TerobusterMainAI+A2   j
                tst.w   $1DC(a5)
                beq.s   loc_387E4
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                move.b  #$49,d0                         ; 'I'
                jsr     (Sound_PlaySFX).l
                subi.w  #$80,(word_FF8234).w
                bmi.s   loc_387CC
                subq.w  #1,$11C(a5)
                bmi.s   loc_387CC
                cmpi.w  #$11A0,$BC(a5)
                bpl.s   loc_387E4
loc_387CC:                                              ; CODE XREF: Boss_TerobusterMainAI+CE   j
                                        ; Boss_TerobusterMainAI+D4   j
                moveq   #8,d0
                moveq   #$18,d1
                tst.w   $A(a5)
                beq.s   loc_387D8
                exg     d0,d1
loc_387D8:                                              ; CODE XREF: Boss_TerobusterMainAI+E6   j
                cmp.w   $58(a5),d0
                beq.w   loc_3869E
                bra.w   loc_38696
; ---------------------------------------------------------------------------
loc_387E4:                                              ; CODE XREF: Boss_TerobusterMainAI+AA   j
                                        ; Boss_TerobusterMainAI+B0   j
                bsr.w   Boss_TerobusterSpawnHomingMissile
                lea     word_39304(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_38802
                exg     a0,a1
loc_38802:                                              ; CODE XREF: Boss_TerobusterMainAI+110   j
                cmpi.w  #5,$58(a5)
                bmi.s   loc_38814
                cmpi.w  #$18,$58(a5)
                bpl.s   loc_38814
                exg     a0,a1
loc_38814:                                              ; CODE XREF: Boss_TerobusterMainAI+11A   j
                                        ; Boss_TerobusterMainAI+122   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38826:                                              ; CODE XREF: Boss_TerobusterMainAI+3E   j
                                        ; Boss_TerobusterMainAI+76   j
                move.w  #$1C,4(a5)
                move.w  #8,$11C(a5)
                bra.s   loc_3883A
; ---------------------------------------------------------------------------
loc_38834:                                              ; CODE XREF: Boss_TerobusterMainAI+7A   j
                move.w  #8,4(a5)
loc_3883A:                                              ; CODE XREF: Boss_TerobusterMainAI+144   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Terobuster boss screen shake attack phase
Boss_TerobusterMainAI_AttackState4:                     ; DATA XREF: ROM:0003857E   o  ; was: loc_38844
                                        ; ROM:00038592   o
                cmpi.w  #$10,$58(a5)
                beq.s   loc_38854
                cmpi.w  #$20,$58(a5)                    ; ' '
                bne.s   loc_3889E
loc_38854:                                              ; CODE XREF: Boss_TerobusterMainAI+15C   j
                tst.w   $1DC(a5)
                beq.s   loc_3889E
                move.w  #3,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                move.b  #$49,d0                         ; 'I'
                jsr     (Sound_PlaySFX).l
                subi.w  #$80,(word_FF8234).w
                bmi.s   loc_38886
                subq.w  #1,$11C(a5)
                bmi.s   loc_38886
                cmpi.w  #$1220,$BC(a5)
                bmi.s   loc_3889E
loc_38886:                                              ; CODE XREF: Boss_TerobusterMainAI+188   j
                                        ; Boss_TerobusterMainAI+18E   j
                moveq   #$10,d0
                moveq   #$20,d1                         ; ' '
                tst.w   $A(a5)
                beq.s   loc_38892
                exg     d0,d1
loc_38892:                                              ; CODE XREF: Boss_TerobusterMainAI+1A0   j
                cmp.w   $58(a5),d0
                bne.w   loc_3869E
                bra.w   loc_38696
; ---------------------------------------------------------------------------
loc_3889E:                                              ; CODE XREF: Boss_TerobusterMainAI+164   j
                                        ; Boss_TerobusterMainAI+16A   j
                bsr.w   Boss_TerobusterSpawnHomingMissile
                lea     word_39348(pc),a0
                nop
                lea     word_39326(pc),a1
                nop
                cmpi.w  #8,4(a5)
                beq.s   loc_388B8
                exg     a0,a1
loc_388B8:                                              ; CODE XREF: Boss_TerobusterMainAI+1C6   j
                bsr.w   Boss_TerobusterInterpolateAnimation
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFC9E0-M68K_RAM),a1
                tst.w   $A(a5)
                beq.s   loc_388CC
                exg     a0,a1
loc_388CC:                                              ; CODE XREF: Boss_TerobusterMainAI+1DA   j
                cmpi.w  #$10,$58(a5)
                bmi.s   loc_388DE
                cmpi.w  #$20,$58(a5)                    ; ' '
                bpl.s   loc_388DE
                exg     a0,a1
loc_388DE:                                              ; CODE XREF: Boss_TerobusterMainAI+1E4   j
                                        ; Boss_TerobusterMainAI+1EC   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14C,$14(a0)
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_388F0:                                              ; CODE XREF: Boss_TerobusterMainAI+52   j
                move.w  #$1E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $1DC(a5)
                move.w  #$C800,d0
                move.w  #$C9E0,d1
                tst.w   $A(a5)
                beq.s   loc_38914
                exg     d0,d1
loc_38914:                                              ; CODE XREF: Boss_TerobusterMainAI+222   j
                move.w  d0,$48(a5)
                move.w  d0,$4A(a5)
                move.w  d1,$11E(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                move.w  d0,$11C(a5)
                move.w  #$38,$17C(a5)                   ; '8'
; Terobuster falling rock spawn phase
Boss_TerobusterMainAI_RockAttackLoop:                   ; DATA XREF: ROM:00038594   o  ; was: loc_38932
                lea     word_39086(pc),a4
                nop
                tst.w   $11C(a5)
                bne.s   loc_38944
                lea     word_39090(pc),a4
                nop
loc_38944:                                              ; CODE XREF: Boss_TerobusterMainAI+24E   j
                subq.w  #1,$17C(a5)
                bmi.s   loc_3896E
                addi.w  #6,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3895E
                move.w  #$1E0,(word_FF8234).w
loc_3895E:                                              ; CODE XREF: Boss_TerobusterMainAI+268   j
                lea     word_392D2(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterSpawnFallingRock
                bra.s   loc_38986
; ---------------------------------------------------------------------------
loc_3896E:                                              ; CODE XREF: Boss_TerobusterMainAI+25A   j
                subi.w  #$E,(word_FF8234).w
                bmi.w   loc_386A2
                lea     word_392D8(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterSpawnMultiDirectional
loc_38986:                                              ; CODE XREF: Boss_TerobusterMainAI+27E   j
                bsr.w   Boss_TerobusterInitMetasprite
                movea.w $48(a5),a0
                move.l  #word_EB7FE,8(a0)
                movea.w $11E(a5),a0
                move.w  #$14C,$14(a0)
                rts
; End of function Boss_TerobusterMainAI
; Terobuster boss intro positioning and animation setup
Boss_TerobusterIntro:                                   ; CODE XREF: Boss_TerobusterSetup+BC   j  ; was: sub_389A2
                move.w  #$10,4(a5)
                move.w  #$196,$10(a5)
                move.w  #$60,$14(a5)                    ; '`'
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                lea     word_3939A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
                bsr.w   Gfx_SetPaletteSequence
; End of function Boss_TerobusterIntro
; Boss fade in effect preparing for battle start
Boss_TerobusterFadeIn:                                  ; DATA XREF: ROM:00038586   o  ; was: sub_389CA
                addq.w  #2,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
loc_389D4:                                              ; CODE XREF: Boss_TerobusterDescend+12   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; End of function Boss_TerobusterFadeIn
; Boss descending animation with position interpolation
Boss_TerobusterDescend:                                 ; DATA XREF: ROM:00038588   o  ; was: sub_389DC
                subq.w  #1,$11C(a5)
                bmi.s   loc_389F0
                move.w  $11C(a5),d0
                subi.w  #$10,d0
                bsr.w   Boss_TerobusterLoadTilesByIndex
                bra.s   loc_389D4
; ---------------------------------------------------------------------------
loc_389F0:                                              ; CODE XREF: Boss_TerobusterDescend+4   j
                addq.w  #2,4(a5)
; Terobuster descending with velocity accumulation
Boss_TerobusterDescend_FallingState:                    ; DATA XREF: ROM:0003858A   o  ; was: loc_389F4
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$14C,$3D4(a5)
                bpl.s   loc_38A12
                lea     word_392E2(pc),a1
                nop
                bsr.w   Boss_TerobusterInterpolateAnimation
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38A12:                                              ; CODE XREF: Boss_TerobusterDescend+26   j
                addq.w  #2,4(a5)
                bsr.w   Boss_TerobusterInitBattleState
                clr.w   $11C(a5)
; Terobuster landing state with animation checks
Boss_TerobusterDescend_LandingState:                    ; DATA XREF: ROM:0003858C   o  ; was: loc_38A1E
                tst.w   $11C(a5)
                beq.s   loc_38A32
loc_38A24:                                              ; CODE XREF: Boss_TerobusterDescend+74   j
                tst.w   $58(a5)
                bmi.s   loc_38A74
                lea     word_392FE(pc),a1
                nop
                bra.s   loc_38A5A
; ---------------------------------------------------------------------------
loc_38A32:                                              ; CODE XREF: Boss_TerobusterDescend+46   j
                tst.w   $58(a5)
                bpl.s   loc_38A54
                addq.w  #1,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$4E,d0                         ; 'N'
                jsr     (Sound_PlaySFX).l
                bra.w   loc_38A24
; ---------------------------------------------------------------------------
loc_38A54:                                              ; CODE XREF: Boss_TerobusterDescend+5A   j
                lea     word_392EC(pc),a1
                nop
loc_38A5A:                                              ; CODE XREF: Boss_TerobusterDescend+54   j
                bsr.w   Boss_TerobusterInterpolateAnimation
                bsr.w   Boss_TerobusterInitMetasprite
                move.l  #word_EB7FE,$1E8(a0)
                move.l  #word_EB7FE,$3C8(a0)
                rts
; ---------------------------------------------------------------------------
loc_38A74:                                              ; CODE XREF: Boss_TerobusterDescend+4C   j
                addq.w  #2,4(a5)
                move.w  a5,$4A(a5)
                move.w  #$30,$11C(a5)                   ; '0'
                lea     word_3936A(pc),a0
                nop
                bsr.w   Boss_TerobusterLoadFrameDelays
; End of function Boss_TerobusterDescend
; Boss battle end sequence with victory condition check
Boss_TerobusterBattleEnd:                               ; DATA XREF: ROM:0003858E   o  ; was: sub_38A8C
                subq.w  #1,$11C(a5)
                bmi.s   loc_38A9A
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; ---------------------------------------------------------------------------
loc_38A9A:                                              ; CODE XREF: Boss_TerobusterBattleEnd+4   j
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Sys_WaitVBlank).l
; End of function Boss_TerobusterBattleEnd
; Post-battle cleanup clearing flags and updating camera
Boss_TerobusterPostBattleCleanup:                       ; DATA XREF: ROM:00038590   o  ; was: sub_38AB0
                tst.w   (word_FF80C2).w
                bne.s   loc_38AC4
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                bra.w   loc_3869E
; ---------------------------------------------------------------------------
loc_38AC4:                                              ; CODE XREF: Boss_TerobusterPostBattleCleanup+4   j
                bsr.w   Boss_TerobusterApplyAngles
                bra.w   Boss_TerobusterInitMetasprite
; End of function Boss_TerobusterPostBattleCleanup
; Battle state management with phase transitions
Boss_TerobusterBattleState:                             ; CODE XREF: Boss_TerobusterMain+28   j  ; was: sub_38ACC
                move.b  #$AC,d0
                jsr     (Sound_PlaySFX).l
                bset    #0,(byte_FFA272).w
                move.w  #$A,4(a5)
                move.b  #2,(byte_FF80EC).w
                clr.w   8(a5)
                move.w  #4,(word_FF808C).w
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                jsr     (Sprite_ClearObjectFlags).l
                move.l  #$20000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   loc_38B1C
                move.l  #$FFFE0000,$18(a5)
loc_38B1C:                                              ; CODE XREF: Boss_TerobusterBattleState+46   j
                move.l  #$FFFF0000,$1C(a5)
                move.w  #$FFFF,$48(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #9,d7
loc_38B30:                                              ; CODE XREF: Boss_TerobusterBattleState+80   j
                btst    #7,2(a0)
                bne.s   loc_38B40
                bset    #4,2(a0)
                bra.s   loc_38B48
; ---------------------------------------------------------------------------
loc_38B40:                                              ; CODE XREF: Boss_TerobusterBattleState+6A   j
                move.w  #$B8,(a0)
                clr.w   4(a0)
loc_38B48:                                              ; CODE XREF: Boss_TerobusterBattleState+72   j
                lea     $60(a0),a0
                dbf     d7,loc_38B30
                move.w  #4,$422(a5)
                move.w  #4,$482(a5)
; End of function Boss_TerobusterBattleState
; First attack pattern with projectile timing
Boss_TerobusterAttackPattern1:                          ; DATA XREF: ROM:00038580   o  ; was: sub_38B5C
                addi.l  #$3000,$1C(a5)
                bmi.s   Boss_TerobusterAttackPattern2
                cmpi.w  #$142,$14(a5)
                bmi.s   Boss_TerobusterAttackPattern2
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                addq.w  #1,$48(a5)
                beq.s   loc_38B94
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$A0,$48(a5)
                bra.s   Boss_TerobusterAttackPattern2
; ---------------------------------------------------------------------------
loc_38B94:                                              ; CODE XREF: Boss_TerobusterAttackPattern1+22   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  #$FFFDE000,$1C(a5)
; End of function Boss_TerobusterAttackPattern1
; Second attack pattern with alternate timing
Boss_TerobusterAttackPattern2:                          ; CODE XREF: Boss_TerobusterAttackPattern1+8   j  ; was: sub_38BA6
                                        ; Boss_TerobusterAttackPattern1+10   j
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$3E,d0                         ; '>'
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Boss_TerobusterAttackPattern2
; Third attack pattern with combined attacks
Boss_TerobusterAttackPattern3:                          ; DATA XREF: ROM:00038582   o  ; was: sub_38BC0
                subq.w  #1,$48(a5)
                bpl.s   loc_38BCE
                addq.w  #2,4(a5)
                clr.w   6(a5)
loc_38BCE:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+4   j
                                        ; Boss_TerobusterDefeatInit+E   j
                bsr.w   Boss_TerobusterAttackPattern2
                cmpi.w  #$40,$48(a5)                    ; '@'
                bpl.s   loc_38BE8
                btst    #0,(word_FFA000+1).w
                bne.s   loc_38BE8
                move.w  #$FFD0,(dword_FFA90C).w
loc_38BE8:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+18   j
                                        ; Boss_TerobusterAttackPattern3+20   j
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_38C64
                movea.l #dword_2ABF0,a1                 ; make offsets?
                btst    #1,(word_FFA000+1).w
                bne.s   loc_38C18
                movea.l #dword_2AD28,a1
                move.l  #$FFFD2000,$1C(a0)
loc_38C18:                                              ; CODE XREF: Boss_TerobusterAttackPattern3+48   j
                jsr     (Projectile_FindFreeSlotComplex).l
                move.b  #0,$20(a0)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$3C,d0                         ; '<'
                subi.w  #$34,d1                         ; '4'
                move.b  (dword_FFFF08).w,d2
                move.b  (dword_FFFF08+1).w,d3
                andi.w  #$3C,d2                         ; '<'
                andi.w  #$3C,d3                         ; '<'
                add.w   d2,d0
                add.w   d3,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_38C64
                move.b  #$BB,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_38C64:                                           ; CODE XREF: Boss_TerobusterAttackPattern3+3A   j
                                        ; Boss_TerobusterAttackPattern3+98   j
                rts
; End of function Boss_TerobusterAttackPattern3
; Initializes defeat sequence with explosion spawn
Boss_TerobusterDefeatInit:                              ; DATA XREF: ROM:00038584   o  ; was: sub_38C66
                bsr.w   Boss_TerobusterSetFadeParams
                addq.w  #1,6(a5)
                cmpi.w  #$F,6(a5)
                bmi.w   loc_38BCE
                move.w  #$22,4(a5)                      ; '"'
                move.w  #8,$48(a5)
                move.w  #$FFD0,(dword_FFA90C).w
                move.b  #4,(byte_FFA95A).w
                move.w  #$B4,d0
                move.w  #$12C,d1
                jsr     (Sprite_ClearAllExcept).l
                jsr     (Boss_InitDefeatExplosion).l
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                subi.w  #$18,d0
                subi.w  #$10,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Boss_TerobusterDefeatInit
; Defeat timer countdown before final state
Boss_TerobusterDefeatTimer:                             ; DATA XREF: ROM:00038598   o  ; was: sub_38CBE
                subq.w  #1,$48(a5)
                bpl.s   loc_38CCE
                addq.w  #2,4(a5)
                move.w  #$C0,$48(a5)
loc_38CCE:                                              ; CODE XREF: Boss_TerobusterDefeatTimer+4   j
                bra.w   Boss_TerobusterSetFadeParams
; End of function Boss_TerobusterDefeatTimer
; Completes defeat sequence removing boss entity
Boss_TerobusterDefeatComplete:                          ; DATA XREF: ROM:0003859A   o  ; was: sub_38CD2
                subq.w  #1,$48(a5)
                bpl.s   loc_38CE0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_38CE0:                                              ; CODE XREF: Boss_TerobusterDefeatComplete+4   j
                subq.w  #1,6(a5)
                bpl.w   Boss_TerobusterSetFadeParams
                rts
; End of function Boss_TerobusterDefeatComplete
; Sets graphics fade parameters using boss state value for death sequence
Boss_TerobusterSetFadeParams:                           ; CODE XREF: Boss_TerobusterDefeatInit   p  ; was: sub_38CEA
                                        ; sub_38CBE:loc_38CCE   j
                move.w  6(a5),d0
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_TerobusterSetFadeParams
; Calculates oscillating word values for animation effects
Boss_TerobusterOscillateValue:                          ; CODE XREF: Boss_TerobusterInitMetasprite+C   p  ; was: sub_38CF4
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                move.w  word_38D0C(pc,d0.w),d0
                move.w  d0,(word_FFE37E).w
                move.w  d0,(word_FFE3FE).w
                rts
; End of function Boss_TerobusterOscillateValue
; ---------------------------------------------------------------------------
word_38D0C:     dc.w    2, 6, $A, $C, $C, $A, 6, 2
                                        ; DATA XREF: Boss_TerobusterOscillateValue+A   r

; Initializes battle state with sound flag and timer setup
Boss_TerobusterInitBattleState:                         ; CODE XREF: Boss_TerobusterDescend+3A   p  ; was: sub_38D1C
                clr.l   $1C(a5)
                move.w  #$C800,$4A(a5)
                move.w  #$14C,$1F4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #5,(word_FFA010).w
                move.w  #5,(word_FFA014).w
                move.b  #$DA,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_TerobusterInitBattleState
; Updates boss body part positions with offset calculations
Boss_TerobusterUpdateBodyParts:                         ; CODE XREF: Boss_TerobusterInitMetasprite+8   p  ; was: sub_38D4C
                move.w  $1DE(a5),d1
                move.w  $10(a5),$490(a5)
                move.w  $14(a5),$494(a5)
                addi.w  #-$10,$490(a5)
                addi.w  #$18,$494(a5)
                add.w   d1,$494(a5)
                cmpi.w  #$13C,$494(a5)
                bmi.s   loc_38D7A
                move.w  #$13C,$494(a5)
loc_38D7A:                                              ; CODE XREF: Boss_TerobusterUpdateBodyParts+26   j
                move.w  $23C(a5),d0
                beq.s   loc_38D86
                subq.w  #4,d0
                bpl.s   loc_38D86
                moveq   #0,d0
loc_38D86:                                              ; CODE XREF: Boss_TerobusterUpdateBodyParts+32   j
                                        ; Boss_TerobusterUpdateBodyParts+36   j
                move.w  d0,$23C(a5)
                add.w   $10(a5),d0
                addi.w  #-$44,d0
                move.w  d0,$430(a5)
                move.w  $14(a5),$434(a5)
                addi.w  #-$2C,$434(a5)
                add.w   d1,$434(a5)
                move.w  #$CC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                add.w   $14(a5),d1
                addi.w  #$3E,d1                         ; '>'
                move.w  d1,(dword_FFA90C).w
                jmp     Boss_CheckScreenBounds
; End of function Boss_TerobusterUpdateBodyParts
; Spawns projectiles with trajectory and velocity updates
Boss_TerobusterSpawnProjectile:                         ; CODE XREF: Boss_TerobusterInitMetasprite+10   j  ; was: sub_38DC4
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_38E06
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_38E06
                movea.l #dword_2AD28,a1
                jsr     (Projectile_FindFreeSlotComplex).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$14,$10(a0)
                addi.w  #-$30,$14(a0)
                move.b  #4,$20(a0)
                move.w  #2,$18(a0)
locret_38E06:                                           ; CODE XREF: Boss_TerobusterSpawnProjectile+8   j
                                        ; Boss_TerobusterSpawnProjectile+10   j
                rts
; End of function Boss_TerobusterSpawnProjectile
; Initializes metasprite and updates boss animation state
Boss_TerobusterInitMetasprite:                          ; CODE XREF: Boss_TerobusterMainAI+82   j  ; was: sub_38E08
                                        ; Boss_TerobusterMainAI+134   j
                moveq   #9,d7
                jsr     (Sprite_InitMetaspriteSimple).l
                bsr.w   Boss_TerobusterUpdateBodyParts
                bsr.w   Boss_TerobusterOscillateValue
                bra.w   Boss_TerobusterSpawnProjectile
; End of function Boss_TerobusterInitMetasprite
; Periodically spawns homing missiles from Terobuster boss body position
Boss_TerobusterSpawnHomingMissile:                      ; CODE XREF: Boss_TerobusterMainAI:loc_387E4   p  ; was: sub_38E1C
                                        ; sub_386EE:loc_3889E   p
                tst.w   (word_FFFF0E).w
                bne.s   loc_38E2A
                cmpi.w  #$1190,$BC(a5)
                bmi.s   locret_38EA0
loc_38E2A:                                              ; CODE XREF: Boss_TerobusterSpawnHomingMissile+4   j
                move.w  (word_FFA000).w,d0
                btst    #8,d0
                bne.s   locret_38EA0
                andi.w  #$1F,d0
                bne.s   locret_38EA0
                movea.w #(byte_FFD880-M68K_RAM),a0
                jsr     (loc_1C144).l
                bne.s   locret_38EA0
                move.w  #$138,(a0)
                move.w  #$8D00,2(a0)
                move.b  #$C0,$21(a0)
                move.b  #8,$23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #8,$20(a0)
                move.w  #$14,$26(a0)
                move.w  $490(a5),$10(a0)
                move.w  $494(a5),$14(a0)
                addi.w  #$C,$10(a0)
                addi.w  #-$30,$14(a0)
                move.w  #$180,$56(a0)
                move.b  #$4A,d0                         ; 'J'
                jsr     (Sound_PlaySFX).l
locret_38EA0:                                           ; CODE XREF: Boss_TerobusterSpawnHomingMissile+C   j
                                        ; Boss_TerobusterSpawnHomingMissile+16   j
                rts
; End of function Boss_TerobusterSpawnHomingMissile
; Updates homing missile trajectory with rotation, trail spawning, and player tracking
Enemy_HomingMissileUpdate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_38EA2
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_38EC2
                btst    #7,$22(a5)
                bne.s   loc_38EC2
                tst.w   (word_FF808C).w
                bpl.s   loc_38EC2
                tst.w   $24(a5)
                bpl.s   loc_38ED8
loc_38EC2:                                              ; CODE XREF: Enemy_HomingMissileUpdate+A   j
                                        ; Enemy_HomingMissileUpdate+12   j
                neg.l   $18(a5)
                neg.l   $1C(a5)
                move.l  #off_E9584,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_38ED8:                                              ; CODE XREF: Enemy_HomingMissileUpdate+1E   j
                lea     word_38FEC(pc),a0
                nop
                move.w  $56(a5),d1
                subi.w  #$10,d1
                move.w  d1,d0
                asr.w   #2,d0
                andi.w  #$38,d0                         ; '8'
                move.w  (a0,d0.w),$E(a5)
                move.w  2(a0,d0.w),8(a5)
                move.w  4(a0,d0.w),$A(a5)
                andi.w  #$1FE,d1
                cmpi.w  #$100,d1
                bmi.s   loc_38F10
                eori.w  #$1800,$E(a5)
loc_38F10:                                              ; CODE XREF: Enemy_HomingMissileUpdate+66   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_38F5E
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_38F5E
                movea.l #dword_2AD6C,a1
                jsr     (Projectile_FindFreeSlotComplex).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asl.l   #2,d0
                neg.l   d0
                add.l   d0,$10(a0)
                asr.l   #2,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asl.l   #2,d0
                neg.l   d0
                add.l   d0,$14(a0)
                asr.l   #3,d0
                move.l  d0,$1C(a0)
loc_38F5E:                                              ; CODE XREF: Enemy_HomingMissileUpdate+76   j
                                        ; Enemy_HomingMissileUpdate+7E   j
                lea     (word_1B514).l,a1
                move.w  d1,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.l  d1,d3
                move.l  d2,d4
                asr.l   #1,d3
                asr.l   #1,d4
                asl.l   #4,d1
                asl.l   #4,d2
                tst.l   d1
                bpl.s   loc_38F8A
                cmp.l   $1C(a5),d1
                bpl.s   loc_38F96
                bra.s   loc_38F90
; ---------------------------------------------------------------------------
loc_38F8A:                                              ; CODE XREF: Enemy_HomingMissileUpdate+DE   j
                cmp.l   $1C(a5),d1
                bmi.s   loc_38F96
loc_38F90:                                              ; CODE XREF: Enemy_HomingMissileUpdate+E6   j
                add.l   d3,$1C(a5)
                bra.s   loc_38F9A
; ---------------------------------------------------------------------------
loc_38F96:                                              ; CODE XREF: Enemy_HomingMissileUpdate+E4   j
                                        ; Enemy_HomingMissileUpdate+EC   j
                move.l  d1,$1C(a5)
loc_38F9A:                                              ; CODE XREF: Enemy_HomingMissileUpdate+F2   j
                tst.l   d2
                bpl.s   loc_38FA6
                cmp.l   $18(a5),d2
                bpl.s   loc_38FB2
                bra.s   loc_38FAC
; ---------------------------------------------------------------------------
loc_38FA6:                                              ; CODE XREF: Enemy_HomingMissileUpdate+FA   j
                cmp.l   $18(a5),d2
                bcs.s   loc_38FB2
loc_38FAC:                                              ; CODE XREF: Enemy_HomingMissileUpdate+102   j
                add.l   d4,$18(a5)
                bra.s   loc_38FB6
; ---------------------------------------------------------------------------
loc_38FB2:                                              ; CODE XREF: Enemy_HomingMissileUpdate+100   j
                                        ; Enemy_HomingMissileUpdate+108   j
                move.l  d2,$18(a5)
loc_38FB6:                                              ; CODE XREF: Enemy_HomingMissileUpdate+10E   j
                jsr     (Math_CalculateAngleToPlayer).l
                sub.w   $56(a5),d2
                bmi.w   loc_38FD8
                cmpi.w  #$100,d2
                bpl.w   loc_38FE0
loc_38FCC:                                              ; CODE XREF: Enemy_HomingMissileUpdate+13A   j
                addq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                rts
; ---------------------------------------------------------------------------
loc_38FD8:                                              ; CODE XREF: Enemy_HomingMissileUpdate+11E   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_38FCC
loc_38FE0:                                              ; CODE XREF: Enemy_HomingMissileUpdate+126   j
                subq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                rts
; End of function Enemy_HomingMissileUpdate
; ---------------------------------------------------------------------------
word_38FEC:     dc.w    $D478, $400, $F8FC, 0
                                        ; DATA XREF: Enemy_HomingMissileUpdate:loc_38ED8   o
                dc.w    $D474, $500, $F8F8, 0
                dc.w    $D470, $500, $F8F8, 0
                dc.w    $D46C, $500, $F8F8, 0
                dc.w    $D46A, $100, $FCF8, 0
                dc.w    $DC6C, $500, $F8F8, 0
                dc.w    $DC70, $500, $F8F8, 0
                dc.w    $DC74, $500, $F8F8, 0

; Spawns 8-way directional projectiles with animated effects from table data
Boss_TerobusterSpawnMultiDirectional:                   ; CODE XREF: Boss_TerobusterMainAI+294   p  ; was: sub_3902C
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_39084
                move.w  #$14,$23C(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_39084
                move.w  (a4)+,d0
                move.w  (a4)+,d1
                move.w  (a4)+,d2
                jsr     (Projectile_SpawnDirectional8Way).l
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_39084
                move.w  #1,$1C(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.l   #1,d0
                addi.l  #$28000,d0
                move.l  d0,$18(a0)
                move.w  (a4)+,d1
                move.w  (a4)+,d2
                jsr     (Enemy_SpawnAnimatedProjectile).l
locret_39084:                                           ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+8   j
                                        ; Boss_TerobusterSpawnMultiDirectional+16   j
                rts
; End of function Boss_TerobusterSpawnMultiDirectional
; ---------------------------------------------------------------------------
word_39086:     dc.w    $40, $FFB2, $FFD6, $FFCC, $FFD8
                                        ; DATA XREF: Boss_TerobusterMainAI:loc_38932   o
word_39090:     dc.w    $30, $FFC4, $10, $FFD0, $C
                                        ; DATA XREF: Boss_TerobusterMainAI+250   o

; Spawns falling rocks with randomized position offsets and downward velocity
Boss_TerobusterSpawnFallingRock:                        ; CODE XREF: Boss_TerobusterMainAI+27A   p  ; was: sub_3909A
                btst    #0,(word_FFA000+1).w
                bne.s   locret_390EE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_390EE
                move.b  (dword_FFFF08).w,d1
                andi.w  #7,d1
                subi.w  #4,d1
                move.b  (dword_FFFF08+1).w,d2
                andi.w  #7,d2
                subi.w  #4,d2
                add.w   2(a4),d1
                add.w   4(a4),d2
                add.w   $10(a5),d1
                add.w   $14(a5),d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                movea.l #dword_2AD6C,a1
                jsr     (Projectile_FindFreeSlotComplex).l
                move.l  #$FFFFC000,$1C(a0)
locret_390EE:                                           ; CODE XREF: Boss_TerobusterSpawnFallingRock+6   j
                                        ; Boss_TerobusterSpawnFallingRock+E   j
                rts
; End of function Boss_TerobusterSpawnFallingRock
; Boss movement physics with acceleration and boundaries
Boss_TerobusterMovementPhysics:                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_390F0
                jsr     (RandomNumber).l
                tst.w   4(a5)
                bne.s   loc_39120
                addq.w  #2,4(a5)
                move.w  #$CF00,2(a5)
                tst.l   $4C(a5)
                bne.s   loc_39112
                move.w  #$8F00,2(a5)
loc_39112:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+1A   j
                move.w  #1,$48(a5)
                move.w  (dword_FFFF08+2).w,$56(a5)
                bra.s   loc_39164
; ---------------------------------------------------------------------------
loc_39120:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+A   j
                btst    #0,(word_FFA000+1).w
                beq.s   loc_39148
                tst.w   $54(a5)
                bpl.s   loc_3913C
                cmpi.w  #$FFFF,$54(a5)
                beq.s   loc_39148
                addq.w  #1,$54(a5)
                bra.s   loc_39148
; ---------------------------------------------------------------------------
loc_3913C:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+3C   j
                cmpi.w  #1,$54(a5)
                beq.s   loc_39148
                subq.w  #1,$54(a5)
loc_39148:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+36   j
                                        ; Boss_TerobusterMovementPhysics+44   j
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_39196
                tst.w   $48(a5)
                beq.s   loc_39196
                cmpi.w  #$140,$14(a5)
                bmi.s   loc_39196
                clr.w   $48(a5)
loc_39164:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+2E   j
                move.l  #$FFFCF000,$1C(a5)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                swap    d0
                subi.l  #$38000,d0
                move.l  d0,$18(a5)
                tst.w   $18(a5)
                bmi.s   loc_39190
                move.w  #8,$54(a5)
                bra.s   loc_39196
; ---------------------------------------------------------------------------
loc_39190:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+96   j
                move.w  #$FFF8,$54(a5)
loc_39196:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+60   j
                                        ; Boss_TerobusterMovementPhysics+66   j
                move.l  $4C(a5),d1
                beq.s   locret_391CA
                movea.l d1,a0
                andi.w  #$E7FF,$E(a5)
                move.w  $56(a5),d0
                add.w   $54(a5),d0
                move.w  d0,$56(a5)
                andi.w  #$2C,d0                         ; ','
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   loc_391C0
                bset    #3,$E(a5)
loc_391C0:                                              ; CODE XREF: Boss_TerobusterMovementPhysics+C8   j
                andi.w  #$1C,d0
                move.l  (a0,d0.w),8(a5)
locret_391CA:                                           ; CODE XREF: Boss_TerobusterMovementPhysics+AA   j
                rts
; End of function Boss_TerobusterMovementPhysics
; Interpolates animation frames with delay loading
Boss_TerobusterInterpolateAnimation:                    ; CODE XREF: Boss_TerobusterMainAI+100   p  ; was: sub_391CC
                                        ; sub_386EE:loc_388B8   p
                clr.w   $1DC(a5)
                tst.w   $C(a5)
                bpl.s   loc_3922E
loc_391D6:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+2A   j
                move.w  $58(a5),d0
                bmi.s   Boss_TerobusterApplyAngles
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_391EC
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_391EC:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+18   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_391F8
                clr.w   $58(a5)
                bra.s   loc_391D6
; ---------------------------------------------------------------------------
loc_391F8:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+24   j
                addq.w  #4,$58(a5)
                subq.w  #1,$17E(a5)
                addq.w  #1,$1DC(a5)
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3936A,d0
                movea.l d0,a0
                bsr.w   Boss_TerobusterCalculateDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                tst.w   $C(a5)
                bmi.s   Boss_TerobusterApplyAngles
loc_3922E:                                              ; CODE XREF: Boss_TerobusterInterpolateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #5,d7
                jsr     (Anim_ApplyInterpolationStep).l
; End of function Boss_TerobusterInterpolateAnimation
; Applies animation angles to 9 boss body parts
