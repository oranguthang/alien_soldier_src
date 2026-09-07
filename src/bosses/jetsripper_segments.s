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
                movea.l #Math_SineTable,a0
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
                movea.l #Math_SineTable,a0
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
                movea.l #Math_SineTable,a2
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
                movea.l #Math_SineTable,a3
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
Boss_JetsripperClampY:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_361DE
                cmpi.w  #$144,$14(a5)
                bmi.s   locret_361EC
                move.w  #$144,$14(a5)
locret_361EC:                                           ; CODE XREF: Boss_JetsripperClampY+6   j
                rts
; End of function Boss_JetsripperClampY
; Updates body segment with gravity physics
Boss_JetsripperSegmentPhysics:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_361EE
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
                jsr     (Projectile_FindFreePrimarySlot).l
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
