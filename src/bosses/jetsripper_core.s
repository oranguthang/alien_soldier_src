; Checks whether the current boss position is inside the shared screen bounds
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
Boss_JetsripperMainHandler:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_35656
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
                jmp     Object_ClearAllExceptTypes
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
                jsr     (Physics_GetPlayerDelta).l
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
                jsr     (Physics_GetPlayerDelta).l
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
                jsr     (Projectile_FindFreeOrRecycleSlot).l
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
                jmp     Object_ClearAllExceptTypes
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
