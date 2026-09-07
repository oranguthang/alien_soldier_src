Math_CalculateAngleToPlayer:                            ; CODE XREF: Math_CalculateAngleBetween+4   p  ; was: sub_354A
                                        ; sub_2BFD0   p
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
loc_355A:                                               ; CODE XREF: Boss_CaterpillarUpdateRotation+1E   p
                                        ; Boss_SnakeAI+1E   p
                bsr.s   Math_Arctan2Lookup
                asr.w   #7,d2
                andi.w  #$1FE,d2
                rts
; End of function Math_CalculateAngleToPlayer
; Calculates angle between two entities using arctan lookup
Math_CalculateAngleBetween:                             ; CODE XREF: Enemy_InitDirectionalProjectile+44   p  ; was: sub_3564
                movea.w a5,a4
                movea.w a0,a5
                bsr.s   Math_CalculateAngleToPlayer
                movea.w a5,a0
                movea.w a4,a5
                rts
; End of function Math_CalculateAngleBetween
; Wrapper for Math_Arctan2Lookup that preserves d0-d1/a0 registers
Math_Arctan2WithPreserve:
                movem.l d0-d1/a0,-(sp)                  ; was: sub_3570
                jsr     Math_Arctan2Lookup(pc)          ; (pc)
                nop
                movem.l (sp)+,d0-d1/a0
                rts
; End of function Math_Arctan2WithPreserve
; Arctangent2 function using lookup table
Math_Arctan2Lookup:                                     ; CODE XREF: Math_CalculateAngleToPlayer:loc_355A   p  ; was: sub_3580
                                        ; Math_Arctan2WithPreserve+4   p
                lea     word_36A4(pc),a0
                nop
                tst.w   d0
                bmi.w   loc_3626
                bne.w   loc_35B0
                tst.w   d1
                bmi.w   loc_35A4
                bne.w   loc_359E
loc_359A:                                               ; CODE XREF: Math_Arctan2Lookup+32   j
                clr.w   d2
                rts
; ---------------------------------------------------------------------------
loc_359E:                                               ; CODE XREF: Math_Arctan2Lookup+16   j
                move.w  #$4000,d2
                rts
; ---------------------------------------------------------------------------
loc_35A4:                                               ; CODE XREF: Math_Arctan2Lookup+12   j
                move.w  #$C000,d2
                rts
; ---------------------------------------------------------------------------
loc_35AA:                                               ; CODE XREF: Math_Arctan2Lookup+AA   j
                move.w  #$8000,d2
                rts
; ---------------------------------------------------------------------------
loc_35B0:                                               ; CODE XREF: Math_Arctan2Lookup+C   j
                tst.w   d1
                beq.s   loc_359A
                bmi.w   loc_35EE
                cmp.w   d0,d1
                bcs.w   loc_35C8
                bne.w   loc_35DA
                move.w  #$2000,d2
                rts
; ---------------------------------------------------------------------------
loc_35C8:                                               ; CODE XREF: Math_Arctan2Lookup+3A   j
                clr.w   d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                add.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_35DA:                                               ; CODE XREF: Math_Arctan2Lookup+3E   j
                move.w  #$4000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                sub.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_35EE:                                               ; CODE XREF: Math_Arctan2Lookup+34   j
                neg.w   d1
                cmp.w   d0,d1
                bcs.w   loc_3600
                bne.w   loc_3612
                move.w  #$E000,d2
                rts
; ---------------------------------------------------------------------------
loc_3600:                                               ; CODE XREF: Math_Arctan2Lookup+72   j
                clr.w   d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                sub.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3612:                                               ; CODE XREF: Math_Arctan2Lookup+76   j
                move.w  #$C000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                add.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3626:                                               ; CODE XREF: Math_Arctan2Lookup+8   j
                neg.w   d0
                tst.w   d1
                beq.w   loc_35AA
                bmi.w   loc_366A
                cmp.w   d0,d1
                bcs.w   loc_3642
                bne.w   loc_3656
                move.w  #$6000,d2
                rts
; ---------------------------------------------------------------------------
loc_3642:                                               ; CODE XREF: Math_Arctan2Lookup+B4   j
                move.w  #$8000,d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                sub.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3656:                                               ; CODE XREF: Math_Arctan2Lookup+B8   j
                move.w  #$4000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                add.w   (a0,d0.w),d2
                rts
; ---------------------------------------------------------------------------
loc_366A:                                               ; CODE XREF: Math_Arctan2Lookup+AE   j
                neg.w   d1
                cmp.w   d0,d1
                bcs.w   loc_367C
                bne.w   loc_3690
                move.w  #$A000,d2
                rts
; ---------------------------------------------------------------------------
loc_367C:                                               ; CODE XREF: Math_Arctan2Lookup+EE   j
                move.w  #$8000,d2
                swap    d1
                clr.w   d1
                divu.w  d0,d1
                lsr.w   #8,d1
                add.w   d1,d1
                add.w   (a0,d1.w),d2
                rts
; ---------------------------------------------------------------------------
loc_3690:                                               ; CODE XREF: Math_Arctan2Lookup+F2   j
                move.w  #$C000,d2
                swap    d0
                clr.w   d0
                divu.w  d1,d0
                lsr.w   #8,d0
                add.w   d0,d0
                sub.w   (a0,d0.w),d2
                rts
; End of function Math_Arctan2Lookup
; ---------------------------------------------------------------------------
word_36A4:      binclude "data/other/word_36A4.bin"
word_36A4_End:

; Calculates square root of d0 using Newton-Raphson method
Math_SquareRoot:
                tst.l   d0                              ; was: sub_38A4
                beq.s   locret_38C8
                cmpi.l  #$10000,d0
                bcc.s   loc_38FA
                cmpi.w  #$271,d0
                bhi.s   loc_38CA
                move.w  d1,-(sp)
                move.w  #$FFFF,d1
loc_38BC:                                               ; CODE XREF: Math_SquareRoot+1C   j
                addq.w  #2,d1
                sub.w   d1,d0
                bpl.s   loc_38BC
                asr.w   #1,d1
                move.w  d1,d0
                move.w  (sp)+,d1
locret_38C8:                                            ; CODE XREF: Math_SquareRoot+2   j
                rts
; ---------------------------------------------------------------------------
loc_38CA:                                               ; CODE XREF: Math_SquareRoot+10   j
                movem.w d1-d4,-(sp)
                move.w  #7,d4
                clr.w   d1
                clr.w   d2
loc_38D6:                                               ; CODE XREF: Math_SquareRoot:loc_38EE   j
                add.w   d0,d0
                addx.w  d1,d1
                add.w   d0,d0
                addx.w  d1,d1
                add.w   d2,d2
                move.w  d2,d3
                add.w   d3,d3
                cmp.w   d3,d1
                bls.s   loc_38EE
                addq.w  #1,d2
                addq.w  #1,d3
                sub.w   d3,d1
loc_38EE:                                               ; CODE XREF: Math_SquareRoot+42   j
                dbf     d4,loc_38D6
                move.w  d2,d0
                movem.w (sp)+,d1-d4
                rts
; ---------------------------------------------------------------------------
loc_38FA:                                               ; CODE XREF: Math_SquareRoot+A   j
                movem.l d1-d4,-(sp)
                moveq   #$D,d4
                moveq   #0,d1
                moveq   #0,d2
loc_3904:                                               ; CODE XREF: Math_SquareRoot:loc_391C   j
                add.l   d0,d0
                addx.w  d1,d1
                add.l   d0,d0
                addx.w  d1,d1
                add.w   d2,d2
                move.w  d2,d3
                add.w   d3,d3
                cmp.w   d3,d1
                bls.s   loc_391C
                addq.w  #1,d2
                addq.w  #1,d3
                sub.w   d3,d1
loc_391C:                                               ; CODE XREF: Math_SquareRoot+70   j
                dbf     d4,loc_3904
                add.l   d0,d0
                addx.w  d1,d1
                add.l   d0,d0
                addx.l  d1,d1
                add.w   d2,d2
                move.l  d2,d3
                add.w   d3,d3
                cmp.l   d3,d1
                bls.s   loc_3938
                addq.w  #1,d2
                addq.w  #1,d3
                sub.l   d3,d1
loc_3938:                                               ; CODE XREF: Math_SquareRoot+8C   j
                add.l   d0,d0
                addx.l  d1,d1
                add.l   d0,d0
                addx.l  d1,d1
                add.w   d2,d2
                move.l  d2,d3
                add.l   d3,d3
                cmp.l   d3,d1
                bls.s   loc_394C
                addq.w  #1,d2
loc_394C:                                               ; CODE XREF: Math_SquareRoot+A4   j
                move.w  d2,d0
                movem.l (sp)+,d1-d4
                rts
; End of function Math_SquareRoot
; Adds BCD value to score with overflow check and clamping
