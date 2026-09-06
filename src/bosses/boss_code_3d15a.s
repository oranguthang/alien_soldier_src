Boss_CaterpillarInitSegments:                              ; CODE XREF: Boss_CaterpillarInit+4   j  ; was: sub_3D15A
                movea.w a5,a0
                lea     word_3D19A(pc),a1
                nop
                moveq   #0,d7
                bsr.s Boss_CaterpillarInitSegment
                lea     $2A0(a0),a0
                moveq   #$D,d7
; End of function Boss_CaterpillarInitSegments
; Initializes single segment with sprite parameters
Boss_CaterpillarInitSegment:                              ; CODE XREF: Boss_CaterpillarInitSegments+A   p  ; was: sub_3D16C
                                        ; Boss_CaterpillarInitSegment+28   j
                lea     $60(a0),a0
                move.w  #$C300,$E(a0)
                clr.w   4(a0)
                move.w  #$4080,2(a0)
                clr.b   $21(a0)
                move.b  #$20,$20(a0) ; ' '
                move.w  (a1)+,(a0)
                move.w  (a1)+,$58(a0)
                move.w  (a1)+,$5A(a0)
                dbf d7,Boss_CaterpillarInitSegment
                rts
; End of function Boss_CaterpillarInitSegment
; ---------------------------------------------------------------------------
word_3D19A:     dc.w $288, $3D8, $28    ; DATA XREF: Boss_CaterpillarInitSegments+2   o
                dc.w $13C, $4D8, $48
                dc.w $144, $518, $50
                dc.w $13C, $558, $58
                dc.w $13C, $5D8, $68
                dc.w $13C, $658, $78
                dc.w $144, $6D8, $88
                dc.w $13C, $758, $98
                dc.w $140, $7D8, $A8
                dc.w $144, $818, $B0
                dc.w $13C, $858, $B8
                dc.w $144, $898, $C0
                dc.w $140, $8D8, $C8
                dc.w $144, $918, $D0
                dc.w $140, $958, $D8


; Caterpillar part 2 with projectile firing
Boss_CaterpillarPart2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D1F4
                tst.w   4(a5)
                bne.s   loc_3D23A
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.l  #word_EB5E6,8(a5)
                move.w  #$43,$24(a5) ; 'C'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #3,$4A(a5)
                clr.w   $4C(a5)
                clr.w   $54(a5)
loc_3D23A:                              ; CODE XREF: Boss_CaterpillarPart2+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D246
                jmp Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D246:                              ; CODE XREF: Boss_CaterpillarPart2+4A   j
                bsr.w Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0 ; 'p'
                bpl.s   loc_3D260
                bset    #4,2(a5)
locret_3D25E:                           ; CODE XREF: Boss_CaterpillarPart2+70   j
                                        ; Boss_CaterpillarPart2+76   j ...
                rts
; ---------------------------------------------------------------------------
loc_3D260:                              ; CODE XREF: Boss_CaterpillarPart2+62   j
                tst.b   $21(a5)
                beq.s   locret_3D25E
                subq.w  #1,$48(a5)
                bpl.s   locret_3D25E
                subq.w  #1,$4C(a5)
                bpl.s   locret_3D25E
                move.w  #4,$4C(a5)
                subq.w  #1,$4A(a5)
                bpl.s   loc_3D29C
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,$48(a5)
                move.w  #3,$4A(a5)
                move.w  #$FFF8,$54(a5)
                rts
; ---------------------------------------------------------------------------
loc_3D29C:                              ; CODE XREF: Boss_CaterpillarPart2+88   j
                bsr.w Boss_CaterpillarCheckFreeSlot
                bne.s   locret_3D25E
                move.w  $54(a5),d7
                addq.w  #8,d7
                andi.w  #$18,d7
                cmpi.w  #$18,d7
                bne.s   loc_3D2B4
                moveq   #8,d7
loc_3D2B4:                              ; CODE XREF: Boss_CaterpillarPart2+BC   j
                move.w  d7,$54(a5)
                move.w  word_3D2E0(pc,d7.w),d6
                move.w  word_3D2E0+2(pc,d7.w),d0
                move.w  word_3D2E0+4(pc,d7.w),d1
                move.w  #$8000,d2
                jsr (Enemy_InitHomingProjectile).l
                move.l  #$FFFEE000,$18(a0)
                subi.l  #$12000,$50(a0)
                rts
; End of function Boss_CaterpillarPart2
; ---------------------------------------------------------------------------
word_3D2E0:     dc.w $C0, $FFF0, $E, 0, $80, 0, $10, 0, $40, $10, $E, 0
                                        ; DATA XREF: Boss_CaterpillarPart2+C4   r
                                        ; Boss_CaterpillarPart2+C8   r ...


; Caterpillar part 3 with attack patterns
Boss_CaterpillarPart3:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D2F8
                tst.w   4(a5)
                bne.s   loc_3D332
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$58,$24(a5) ; 'X'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #8,$4A(a5)
                clr.w   $4C(a5)
loc_3D332:                              ; CODE XREF: Boss_CaterpillarPart3+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D33E
                jmp Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D33E:                              ; CODE XREF: Boss_CaterpillarPart3+3E   j
                bsr.w Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0 ; 'p'
                bpl.s   loc_3D358
                bset    #4,2(a5)
locret_3D356:                           ; CODE XREF: Boss_CaterpillarPart3+64   j
                rts
; ---------------------------------------------------------------------------
loc_3D358:                              ; CODE XREF: Boss_CaterpillarPart3+56   j
                tst.b   $21(a5)
                beq.s   locret_3D356
                subq.w  #1,$48(a5)
                bpl.s   loc_3D36A
                move.w  #$80,$48(a5)
loc_3D36A:                              ; CODE XREF: Boss_CaterpillarPart3+6A   j
                move.w  (word_FFA000).w,d0
                andi.w  #$C,d0
                move.l  off_3D37A(pc,d0.w),8(a5)
                rts
; End of function Boss_CaterpillarPart3
; ---------------------------------------------------------------------------
off_3D37A:      dc.l word_EB5B6         ; DATA XREF: Boss_CaterpillarPart3+7A   r
                dc.l word_EB5CE
                dc.l word_EB5F2
                dc.l word_EB5CE


; Caterpillar part 4 with animation states
Boss_CaterpillarPart4:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D38A
                tst.w   4(a5)
                bne.s   loc_3D3C4
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$6E,$24(a5) ; 'n'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #8,$4A(a5)
                clr.w   $4C(a5)
loc_3D3C4:                              ; CODE XREF: Boss_CaterpillarPart4+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D3D0
                jmp Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D3D0:                              ; CODE XREF: Boss_CaterpillarPart4+3E   j
                bsr.w Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0 ; 'p'
                bpl.s   loc_3D3EA
                bset    #4,2(a5)
locret_3D3E8:                           ; CODE XREF: Boss_CaterpillarPart4+64   j
                rts
; ---------------------------------------------------------------------------
loc_3D3EA:                              ; CODE XREF: Boss_CaterpillarPart4+56   j
                tst.b   $21(a5)
                beq.s   locret_3D3E8
                subq.w  #1,$48(a5)
                bpl.s   loc_3D3F8
                nop
loc_3D3F8:                              ; CODE XREF: Boss_CaterpillarPart4+6A   j
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #4,d0
                move.l  off_3D40A(pc,d0.w),8(a5)
                rts
; End of function Boss_CaterpillarPart4
; ---------------------------------------------------------------------------
off_3D40A:      dc.l word_EB60A         ; DATA XREF: Boss_CaterpillarPart4+78   r
                dc.l word_EB616


; Caterpillar part 1 entity with timer
Boss_CaterpillarPart1:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D412
                tst.w   4(a5)
                bne.s   loc_3D43E
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.b  #$10,$23(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$1FF,$5C(a5)
                move.l  #word_EB622,8(a5)
loc_3D43E:                              ; CODE XREF: Boss_CaterpillarPart1+4   j
                subq.w  #1,$5C(a5)
                bpl.w Boss_CaterpillarUpdateSegmentPos
                move.w  #$294,(a5)
                clr.w   4(a5)
                rts
; End of function Boss_CaterpillarPart1
; Updates segment position with sine wave calculation
Boss_CaterpillarUpdateSegmentPos:                              ; CODE XREF: Boss_CaterpillarPart2:loc_3D246   p  ; was: sub_3D450
                                        ; sub_3D2F8:loc_3D33E   p ...
                move.w  $58(a5),d0
                sub.w   (dword_FFA908).w,d0
                move.w  d0,$10(a5)
                bset    #7,2(a5)
                move.b  $4E(a5),$21(a5)
                cmpi.w  #$70,$10(a5) ; 'p'
                bmi.s   loc_3D478
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_3D482
loc_3D478:                              ; CODE XREF: Boss_CaterpillarUpdateSegmentPos+1E   j
                bclr    #7,2(a5)
                clr.b   $21(a5)
loc_3D482:                              ; CODE XREF: Boss_CaterpillarUpdateSegmentPos+26   j
                movea.w #(word_FF9800-M68K_RAM),a0
                adda.w  $5A(a5),a0
                move.w  (a0)+,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  (a2,d0.w),d1
                ext.l   d1
                asl.l   #6,d1
                swap    d1
                move.w  #$A8,d2
                sub.w   d1,d2
                move.w  d2,$14(a5)
                rts
; End of function Boss_CaterpillarUpdateSegmentPos
; Checks for free projectile slot
Boss_CaterpillarCheckFreeSlot:                              ; CODE XREF: Boss_CaterpillarPart2:loc_3D29C   p  ; was: sub_3D4AC
                movea.w #(byte_FFD280-M68K_RAM),a0
                jmp     loc_1C0A4
; End of function Boss_CaterpillarCheckFreeSlot
; Shooting star entity with state machine
Boss_CaterpillarShootingStar:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D4B6
                tst.w   4(a5)
                beq.w   loc_3D546
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
                btst    #1,$4C(a5)
                bne.s   loc_3D4EC
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3D4EC
                tst.w   (word_FF8200).w
                bne.s   loc_3D4EC
                move.b  #2,(byte_FF80EC).w
                move.w  #$A,4(a5)
loc_3D4EC:                              ; CODE XREF: Boss_CaterpillarShootingStar+1A   j
                                        ; Boss_CaterpillarShootingStar+22   j ...
                lea     (dword_FF9420).w,a0
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                move.w  #6,d7
loc_3D502:                              ; CODE XREF: Boss_CaterpillarShootingStar+5C   j
                move.w  (dword_FF940C+2).w,d6
                subq.w  #1,d6
loc_3D508:                              ; CODE XREF: Boss_CaterpillarShootingStar+58   j
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d6,loc_3D508
                dbf     d7,loc_3D502
                move.w  #6,d7
                lea     (dword_FF9420).w,a1
                lea     $60(a5),a0
                move.w  (dword_FF940C+2).w,d6
                add.w   d6,d6
                add.w   d6,d6
loc_3D52A:                              ; CODE XREF: Boss_CaterpillarShootingStar+8C   j
                lea     (a1,d6.w),a1
                move.w  (a1),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a0)
                move.w  2(a1),$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3D52A
loc_3D546:                              ; CODE XREF: Boss_CaterpillarShootingStar+4   j
                move.w  4(a5),d0
                lea     off_3D552(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_CaterpillarShootingStar
; ---------------------------------------------------------------------------
off_3D552:      dc.w Boss_CaterpillarShipInit-*        ; DATA XREF: Boss_CaterpillarShootingStar+94   o
                dc.w Boss_CaterpillarShipState1-*
                dc.w Boss_CaterpillarShipState2-*
                dc.w Boss_CaterpillarRotateAndWait-*
                dc.w Boss_CaterpillarRotationOnly-*
                dc.w Boss_CaterpillarShipState3-*
                dc.w Boss_CaterpillarShipState4-*
                dc.w nullsub_79-*


; Initializes caterpillar ship with body parts
Boss_CaterpillarShipInit:                              ; DATA XREF: ROM:off_3D552   o  ; was: sub_3D562
                tst.b   (word_FFF720).w
                bmi.w   locret_3D62E
                addq.w  #2,4(a5)
                move.w  #6,(dword_FF940C+2).w
                move.w  #$C,(dword_FF940C).w
                move.w  #$170,(dword_FF9408).w
                move.w  #$100,(dword_FF9408+2).w
                move.w  #$4000,(word_FF8202).w
                move.w  #$4000,(word_FF8200).w
                move.w  #$CD00,2(a5)
                move.b  #$10,$20(a5)
                move.b  #$50,$21(a5) ; 'P'
                move.b  #$10,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$24(a5) ; '('
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.w  #6,d7
                lea     $60(a5),a0
loc_3D5D4:                              ; CODE XREF: Boss_CaterpillarShipInit+C8   j
                move.w  #$10,(a0)
                move.l  #word_EB62E,8(a0)
                move.w  #$E45A,$E(a0)
                move.w  #$8D00,2(a0)
                move.w  #$80,$26(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #$10,$20(a0)
                move.w  #$14,$24(a0)
                btst    #0,d7
                bne.s   loc_3D626
                move.b  #$50,$21(a0) ; 'P'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
loc_3D626:                              ; CODE XREF: Boss_CaterpillarShipInit+AC   j
                lea     $60(a0),a0
                dbf     d7,loc_3D5D4
locret_3D62E:                           ; CODE XREF: Boss_CaterpillarShipInit+4   j
                rts
; End of function Boss_CaterpillarShipInit
; Ship state 1 with rotation initialization
Boss_CaterpillarShipState1:                              ; DATA XREF: ROM:0003D554   o  ; was: sub_3D630
                bsr.w Boss_CaterpillarUpdateRotation
                move.b  #$80,$23(a5)
                clr.b   (byte_FF80EC).w
                clr.w   $4A(a5)
                move.w  #$220,(dword_FF9408).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_CaterpillarShipState1
; Ship state 2 with altitude oscillation
Boss_CaterpillarShipState2:                              ; DATA XREF: ROM:0003D556   o  ; was: sub_3D654
                bsr.w Boss_CaterpillarUpdateRotation
                cmpi.w  #$880,(dword_FFA908).w
                bcc.s   loc_3D68A
                subq.w  #1,$48(a5)
                bne.s   locret_3D6B2
                eori.w  #1,$4A(a5)
                beq.s   loc_3D67C
                move.w  #$100,$48(a5)
                move.w  #$C0,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_3D67C:                              ; CODE XREF: Boss_CaterpillarShipState2+18   j
                move.w  #$100,$48(a5)
                move.w  #$220,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_3D68A:                              ; CODE XREF: Boss_CaterpillarShipState2+A   j
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   $21(a5)
                move.w  #$120,(dword_FF9408).w
                move.w  #$F0,(dword_FF9408+2).w
                bset    #1,$4C(a5)
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_3D6B2:                           ; CODE XREF: Boss_CaterpillarShipState2+10   j
                rts
; End of function Boss_CaterpillarShipState2
; Caterpillar boss rotation with timer-based state transition
Boss_CaterpillarRotateAndWait:                              ; DATA XREF: ROM:0003D558   o  ; was: sub_3D6B4
                bsr.w Boss_CaterpillarUpdateRotation
                subq.w  #1,$48(a5)
                bne.s   locret_3D6D2
                move.w  #$40,(dword_FF9408).w ; '@'
                move.w  #$80,(dword_FF9408+2).w
                addq.w  #2,4(a5)
                addq.w  #3,(dword_FF940C).w
locret_3D6D2:                           ; CODE XREF: Boss_CaterpillarRotateAndWait+8   j
                rts
; End of function Boss_CaterpillarRotateAndWait
; Update only rotation for Caterpillar boss
Boss_CaterpillarRotationOnly:                              ; DATA XREF: ROM:0003D55A   o  ; was: sub_3D6D4
                bsr.w Boss_CaterpillarUpdateRotation
                rts
; End of function Boss_CaterpillarRotationOnly
; Ship state 3 defeating boss sequence
Boss_CaterpillarShipState3:                              ; DATA XREF: ROM:0003D55C   o  ; was: sub_3D6DA
                bsr.w Boss_CaterpillarUpdateRotation
                jsr (Projectile_ExplodeOnImpact).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                andi.w  #$7FFF,2(a5)
                move.w  #$10,$48(a5)
                move.w  a5,$4A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3D724
                move.w  #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_3D724:                           ; CODE XREF: Boss_CaterpillarShipState3+32   j
                rts
; End of function Boss_CaterpillarShipState3
; Ship state 4 final defeat cleanup
Boss_CaterpillarShipState4:                              ; DATA XREF: ROM:0003D55E   o  ; was: sub_3D726
                bsr.w Boss_CaterpillarUpdateRotation
                subq.w  #1,$48(a5)
                bne.s   locret_3D782
                movea.w $4A(a5),a0
                lea     $60(a0),a0
                move.l  #off_E953C,8(a0)
                jsr (Projectile_InitType88).l
                lea     $2A0(a5),a1
                cmpa.w  a1,a0
                bhi.s   loc_3D784
                move.w  a0,$4A(a5)
                move.w  #$A,$48(a5)
                movea.w a0,a4
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3D782
                move.w  #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
locret_3D782:                           ; CODE XREF: Boss_CaterpillarShipState4+8   j
                                        ; Boss_CaterpillarShipState4+3A   j
                rts
; ---------------------------------------------------------------------------
loc_3D784:                              ; CODE XREF: Boss_CaterpillarShipState4+26   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_CaterpillarShipState4
nullsub_79:                             ; DATA XREF: ROM:0003D560   o
                rts
; End of function nullsub_79


; Updates ship rotation with sine calculation
Boss_CaterpillarUpdateRotation:                              ; CODE XREF: Boss_CaterpillarShipState1   p  ; was: sub_3D78C
                                        ; sub_3D654   p ...
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3D7D8
                move.w  (dword_FF9408).w,d0
                sub.w   (dword_FFA900).w,d0
                move.w  (dword_FF9408+2).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  (dword_FF9400).w,d1
                addi.w  #$100,d1
                sub.w   d2,d1
                andi.w  #$1FF,d1
                cmpi.w  #$100,d1
                beq.s   loc_3D7D8
                cmpi.w  #$100,d1
                bcs.s   loc_3D7D2
                move.w  #8,(dword_FF9400+2).w
                bra.s   loc_3D7D8
; ---------------------------------------------------------------------------
loc_3D7D2:                              ; CODE XREF: Boss_CaterpillarUpdateRotation+3C   j
                move.w  #$FFF8,(dword_FF9400+2).w
loc_3D7D8:                              ; CODE XREF: Boss_CaterpillarUpdateRotation+8   j
                                        ; Boss_CaterpillarUpdateRotation+36   j ...
                move.w  (dword_FF9400+2).w,d0
                add.w   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
                move.w  (dword_FF9400).w,d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                move.w  (dword_FF940C).w,d2
                muls.w  d2,d0
                muls.w  d2,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Boss_CaterpillarUpdateRotation
nullsub_80:
                rts
; End of function nullsub_80


; Main Xi-Tiger boss handler with state dispatch
Boss_XiTigerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D814
                tst.w   4(a5)
                beq.w   loc_3D878
                tst.w   8(a5)
                beq.s   loc_3D878
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3D85A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3D85A
                tst.w   (word_FF8200).w
                bne.s   loc_3D85A
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr (Sprite_ClearObjectFlags).l
                move.b  #1,(byte_FF830E).w
                move.w  #$FFFF,(word_FF821E).w
                bra.w Boss_XiTigerAttackPattern1
; ---------------------------------------------------------------------------
loc_3D85A:                              ; CODE XREF: Boss_XiTigerMain+14   j
                                        ; Boss_XiTigerMain+1C   j ...
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                move.w  #$13E,d0
                add.w   (dword_FFA904).w,d0
                move.w  d0,$23C(a5)
loc_3D878:                              ; CODE XREF: Boss_XiTigerMain+4   j
                                        ; Boss_XiTigerMain+C   j
                move.w  4(a5),d0
                movea.w off_3D888(pc,d0.w),a0
                adda.l  #Boss_XiTigerInit,a0
                jmp     (a0)
; End of function Boss_XiTigerMain
; ---------------------------------------------------------------------------
off_3D888:      dc.w Boss_XiTigerInit-Boss_XiTigerInit
                                        ; DATA XREF: Boss_XiTigerMain+68   r
                dc.w Boss_XiTigerSetup-Boss_XiTigerInit
                dc.w Boss_XiTigerFallingLanding-Boss_XiTigerInit
                dc.w Boss_XiTigerBattleStart-Boss_XiTigerInit
                dc.w Boss_XiTigerBattleActive-Boss_XiTigerInit
                dc.w Boss_XiTigerMovementAI-Boss_XiTigerInit
                dc.w Boss_XiTigerIdle_AttackDecision-Boss_XiTigerInit
                dc.w Boss_XiTigerDash_Decelerate-Boss_XiTigerInit
                dc.w Boss_XiTigerDashPrep-Boss_XiTigerInit
                dc.w Boss_XiTigerDashDecelerate-Boss_XiTigerInit
                dc.w Boss_XiTigerCloseRange_JumpPrep-Boss_XiTigerInit
                dc.w Boss_XiTigerJumpRise-Boss_XiTigerInit
                dc.w Boss_XiTigerJumpPeak-Boss_XiTigerInit
                dc.w Boss_XiTigerLandedState-Boss_XiTigerInit
                dc.w Boss_XiTigerAttackPattern2-Boss_XiTigerInit
                dc.w Boss_XiTigerAttackPattern3-Boss_XiTigerInit
                dc.w Boss_XiTigerDefeatInit-Boss_XiTigerInit
                dc.w Boss_XiTigerDefeatUpdate-Boss_XiTigerInit
                dc.w Boss_XiTigerDefeatComplete-Boss_XiTigerInit
                dc.w Boss_XiTigerDefeatFinal-Boss_XiTigerInit
                dc.w Boss_XiTigerCloseRangeAI-Boss_XiTigerInit


; Initializes Xi-Tiger boss clearing sprites
Boss_XiTigerInit:                              ; DATA XREF: Boss_XiTigerMain+6C   o  ; was: sub_3D8B2
                                        ; ROM:off_3D888   o ...
                addq.w  #2,4(a5)
                move.w  #2,(word_FF821E).w
                move.w  #$114,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                addq.w  #1,8(a5)
locret_3D8CC:                           ; CODE XREF: Boss_XiTigerSetup+4   j
                rts
; End of function Boss_XiTigerInit
; Complex setup with metasprite initialization
Boss_XiTigerSetup:                              ; DATA XREF: ROM:0003D88A   o  ; was: sub_3D8CE
                tst.w   (word_FFF720).w
                bmi.s   locret_3D8CC
                movea.w a5,a4
                move.w  #$8280,(dword_FF8040).w
                moveq   #$18,d7
                movea.l #dword_34CF6,a0
                movea.l #word_34D5A,a1
                movea.l #word_34D74,a2
                jsr (Sprite_InitMetaspriteComplex).l
                bset    #0,2(a5)
                bset    #0,$6C2(a5)
                bset    #0,$902(a5)
                bset    #0,$482(a5)
                bset    #3,$482(a5)
                addq.w  #4,4(a5)
                move.w  #$114,(a5)
                move.w  #$D00,2(a5)
                clr.w   $54(a5)
                clr.w   $56(a5)
                movea.l #word_1BBCE,a1
                jsr (Sprite_InitFromPointerTable).l
                move.w  #$C000,$242(a5)
                move.w  #$C000,$422(a5)
                move.l  #word_EBA68,$248(a5)
                move.l  #word_EBA68,$428(a5)
                move.w  #$2C,$266(a5) ; ','
                bclr    #7,$48E(a5)
                movea.l #$FFFF22C0,a0
                move.w  #$80,d0
                moveq   #9,d7
loc_3D96A:                              ; CODE XREF: Boss_XiTigerSetup+AC   j
                moveq   #$F,d6
loc_3D96C:                              ; CODE XREF: Boss_XiTigerSetup:loc_3D976   j
                move.w  (a0)+,d1
                beq.s   loc_3D976
                sub.w   d0,d1
                move.w  d1,-2(a0)
loc_3D976:                              ; CODE XREF: Boss_XiTigerSetup+A0   j
                dbf     d6,loc_3D96C
                dbf     d7,loc_3D96A
                movea.l #word_3D9BE,a0
                jsr (Gfx_LoadCompressedTiles).l
                bsr.w Boss_XiTigerFlipDirection
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$E0,$490(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                lea     word_3E502(pc),a0
                nop
                bsr.w Boss_XiTigerLoadAnimData
                bra.w   loc_3DA64
; End of function Boss_XiTigerSetup
; ---------------------------------------------------------------------------
word_3D9BE:     dc.w $6100, $2000, $302, $1816, $1719, $1C1A, $1B1D, $1E, $1F00
                                        ; DATA XREF: Boss_XiTigerSetup+B0   o


; Xi-Tiger falling state with ground landing detection
Boss_XiTigerFallingLanding:                              ; DATA XREF: ROM:0003D88C   o  ; was: sub_3D9D0
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DA30
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DA30
                addq.w  #2,4(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                move.b  #$A1,d0
                jsr (Sound_PlaySFX).l
                move.w  $23C(a5),$914(a5)
                move.w  #$CF20,$4A(a5)
                clr.l   $1C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_3DA64
; ---------------------------------------------------------------------------
loc_3DA30:                              ; CODE XREF: Boss_XiTigerFallingLanding+10   j
                                        ; Boss_XiTigerFallingLanding+1A   j
                lea     word_3E456(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerFallingLanding
; Starts battle activating boss movement
Boss_XiTigerBattleStart:                              ; DATA XREF: ROM:0003D88E   o  ; was: sub_3DA3E
                tst.w   $58(a5)
                bpl.s   loc_3DA64
                addq.w  #2,4(a5)
                clr.l   $498(a5)
                clr.w   $17E(a5)
                addq.w  #1,$1DC(a5)
                addq.w  #1,$1DE(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_3DA86
; ---------------------------------------------------------------------------
loc_3DA64:                              ; CODE XREF: Boss_XiTigerSetup+EC   j
                                        ; Boss_XiTigerFallingLanding+5E   j ...
                lea     word_3E478(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleStart
; Active battle state with AI update
Boss_XiTigerBattleActive:                              ; DATA XREF: ROM:0003D890   o  ; was: sub_3DA72
                cmpi.w  #$FFFC,$17E(a5)
                bne.s   loc_3DA86
                addq.w  #2,4(a5)
                moveq   #5,d0
                jsr (UI_CheckVictoryCondition).l
loc_3DA86:                              ; CODE XREF: Boss_XiTigerBattleStart+24   j
                                        ; Boss_XiTigerBattleActive+6   j ...
                lea     word_3E3D2(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleActive
; Movement AI with position tracking
Boss_XiTigerMovementAI:                              ; DATA XREF: ROM:0003D892   o  ; was: sub_3DA94
                tst.w   (word_FF80C2).w
                bne.s   loc_3DA86
                clr.b   (byte_FF80EC).w
                addi.w  #$40,(word_FFA974).w ; '@'
                bra.w   loc_3DB10
; End of function Boss_XiTigerMovementAI
; Check recovery conditions and transition Xi-Tiger state
Boss_XiTigerRecoveryCheck:
                tst.w   $58(a5)  ; was: sub_3DAA8
                bpl.s   loc_3DABE
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3DABE:                              ; CODE XREF: Boss_XiTigerRecoveryCheck+4   j
                move.w  a5,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$148,$914(a5)
                lea     word_3E3E8(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerRecoveryCheck
; Check button input to reverse Xi-Tiger state
Boss_XiTigerButtonCheck:
                btst    #6,(word_FFF708).w  ; was: sub_3DAE2
                beq.s   loc_3DAF8
                subq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFE,$C(a5)
loc_3DAF8:                              ; CODE XREF: Boss_XiTigerButtonCheck+6   j
                lea     word_3E464(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerButtonCheck
; Xi-Tiger idle/waiting state with scroll and distance checks
Boss_XiTigerIdleState:                              ; CODE XREF: Boss_XiTigerDashDecelerate+24   j  ; was: sub_3DB06
                                        ; Boss_XiTigerCloseRangeAI+E   j ...
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3DB10:                              ; CODE XREF: Boss_XiTigerMovementAI+10   j
                move.w  #$C,4(a5)
                move.w  #$C,$17E(a5)
                move.l  #word_EBA2C,$68(a5)
                bclr    #6,$261(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                move.w  #1,$1DC(a5)
                move.w  #1,$1DE(a5)
; Xi-Tiger idle state with attack decision
Boss_XiTigerIdle_AttackDecision:                              ; DATA XREF: ROM:0003D894   o  ; was: loc_3DB48
                move.w  #2,(word_FF8246).w
                addi.w  #$10,(word_FF8234).w
                tst.w   $17E(a5)
                bpl.s   loc_3DB8A
                move.w  #$C,$17E(a5)
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3DB8A
                move.w  #$1E0,(word_FF8234).w
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$A0,d0
                bmi.w   loc_3DC7A
                btst    #0,(dword_FFFF08).w
                bne.w   loc_3DBA6
                bra.w   loc_3DD56
; ---------------------------------------------------------------------------
loc_3DB8A:                              ; CODE XREF: Boss_XiTigerIdleState+52   j
                                        ; Boss_XiTigerIdleState+60   j
                lea     word_3E3D2(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bsr.w Boss_XiTigerUpdateSprites
                move.w  (word_FFA000).w,d5
                andi.w  #$F,d5
                beq.w Boss_XiTigerSetFacingDirection
                rts
; ---------------------------------------------------------------------------
loc_3DBA6:                              ; CODE XREF: Boss_XiTigerIdleState+7C   j
                                        ; Boss_XiTigerDashDecelerate+44   j ...
                move.w  #$10,4(a5)
                move.l  #word_EBA2C,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #0,$1DC(a5)
                move.w  #1,$1DE(a5)
                move.w  #3,$17E(a5)
                bsr.w Boss_XiTigerSetFacingDirection
; End of function Boss_XiTigerIdleState
; Xi-Tiger dash preparation with sound and rotation setup
Boss_XiTigerDashPrep:                              ; DATA XREF: ROM:0003D898   o  ; was: sub_3DBE6
                tst.w   $17E(a5)
                bpl.s   loc_3DC24
                subi.w  #$A0,(word_FF8234).w
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                bset    #6,$261(a5)
                move.l  #$80000,$498(a5)
                tst.w   $54(a5)
                beq.s   loc_3DC24
                neg.l   $498(a5)
loc_3DC24:                              ; CODE XREF: Boss_XiTigerDashPrep+4   j
                                        ; Boss_XiTigerDashPrep+38   j ...
                lea     word_3E42E(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerDashPrep
; Xi-Tiger dash deceleration and attack decision logic
Boss_XiTigerDashDecelerate:                              ; DATA XREF: ROM:0003D89A   o  ; was: sub_3DC32
                tst.l   $498(a5)
                beq.s   loc_3DC4C
                bmi.s   loc_3DC44
                subi.l  #$4000,$498(a5)
                bra.s   loc_3DC4C
; ---------------------------------------------------------------------------
loc_3DC44:                              ; CODE XREF: Boss_XiTigerDashDecelerate+6   j
                addi.l  #$4000,$498(a5)
loc_3DC4C:                              ; CODE XREF: Boss_XiTigerDashDecelerate+4   j
                                        ; Boss_XiTigerDashDecelerate+10   j
                tst.w   $58(a5)
                bpl.s   loc_3DC24
                tst.w   (word_FF8234).w
                bmi.w Boss_XiTigerIdleState
                clr.l   $498(a5)
                bsr.w Boss_XiTigerSetFacingDirection
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$98,d0
                bmi.w   loc_3DC7A
                andi.w  #2,d5
                beq.w   loc_3DD56
                bra.w   loc_3DBA6
; ---------------------------------------------------------------------------
loc_3DC7A:                              ; CODE XREF: Boss_XiTigerIdleState+72   j
                                        ; Boss_XiTigerDashDecelerate+38   j ...
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #1,$1DC(a5)
                move.w  #0,$1DE(a5)
; Xi-Tiger dash deceleration with animation
Boss_XiTigerDash_Decelerate:                              ; DATA XREF: ROM:0003D896   o  ; was: loc_3DCA8
                tst.w   $58(a5)
                bmi.s   loc_3DCBC
                lea     word_3E3F2(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
loc_3DCBC:                              ; CODE XREF: Boss_XiTigerDashDecelerate+7A   j
                                        ; Boss_XiTigerCloseRangeAI+24   j
                move.w  #$28,4(a5) ; '('
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                addq.w  #4,d0
                move.w  d0,$17E(a5)
                bset    #6,$261(a5)
                move.w  #4,$58(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w Boss_XiTigerSetFacingDirection
; End of function Boss_XiTigerDashDecelerate
; Xi-Tiger close range attack AI decision logic
Boss_XiTigerCloseRangeAI:                              ; DATA XREF: ROM:0003D8B0   o  ; was: sub_3DCE6
                tst.w   $17E(a5)
                bpl.s   loc_3DD1A
                bsr.w Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w Boss_XiTigerIdleState
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$98,d0
                bpl.s   loc_3DD0E
                andi.w  #3,d5
                beq.w   loc_3DD56
                bra.w   loc_3DCBC
; ---------------------------------------------------------------------------
loc_3DD0E:                              ; CODE XREF: Boss_XiTigerCloseRangeAI+1A   j
                andi.w  #1,d5
                beq.w   loc_3DD56
                bra.w   loc_3DBA6
; ---------------------------------------------------------------------------
loc_3DD1A:                              ; CODE XREF: Boss_XiTigerCloseRangeAI+4   j
                lea     word_3E3FC(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                move.w  $58(a5),d0
                subq.w  #4,d0
                andi.w  #$C,d0
                cmpi.w  #8,d0
                bne.w Boss_XiTigerUpdateSprites
                tst.w   $C(a5)
                bne.w Boss_XiTigerUpdateSprites
                subi.w  #$30,(word_FF8234).w ; '0'
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
                bsr.w Boss_XiTigerSetAnimationData
                bra.w Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
loc_3DD56:                              ; CODE XREF: Boss_XiTigerIdleState+80   j
                                        ; Boss_XiTigerDashDecelerate+40   j ...
                move.w  #$14,4(a5)
                clr.w   $17E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #word_EBA2C,$68(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; Xi-Tiger close range jump preparation
Boss_XiTigerCloseRange_JumpPrep:                              ; DATA XREF: ROM:0003D89C   o  ; was: loc_3DD8C
                cmpi.w  #$FFFD,$17E(a5)
                bne.s   loc_3DDB6
                addq.w  #2,4(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  #$20000,$498(a5)
                tst.w   $54(a5)
                beq.s   loc_3DDB6
                neg.l   $498(a5)
loc_3DDB6:                              ; CODE XREF: Boss_XiTigerCloseRangeAI+AC   j
                                        ; Boss_XiTigerCloseRangeAI+CA   j ...
                lea     word_3E444(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerCloseRangeAI
; Xi-Tiger jump rising phase with gravity
Boss_XiTigerJumpRise:                              ; DATA XREF: ROM:0003D89E   o  ; was: sub_3DDC4
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DDB6
                move.l  #word_EBA4A,$68(a5)
                addq.w  #2,4(a5)
                bset    #6,$261(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                subi.w  #$E0,(word_FF8234).w
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
loc_3DDFA:                              ; CODE XREF: Boss_XiTigerJumpPeak+10   j
                lea     word_3E456(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpRise
; Xi-Tiger jump peak and landing detection
Boss_XiTigerJumpPeak:                              ; DATA XREF: ROM:0003D8A0   o  ; was: sub_3DE08
                addi.l  #$4000,$1C(a5)
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DDFA
                addq.w  #2,4(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                move.b  #$A4,d0
                jsr (Sound_PlaySFX).l
                bclr    #6,$261(a5)
                move.w  $23C(a5),$914(a5)
                move.w  #$CF20,$4A(a5)
                clr.l   $1C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3DE62:                              ; CODE XREF: Boss_XiTigerLandedState+48   j
                lea     word_3E3E8(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bra.w Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpPeak
; Xi-Tiger landed state with AI decision logic
Boss_XiTigerLandedState:                              ; DATA XREF: ROM:0003D8A2   o  ; was: sub_3DE70
                tst.w   $58(a5)
                bpl.s   loc_3DE9E
                clr.l   $498(a5)
                bsr.w Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w Boss_XiTigerIdleState
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$A0,d0
                bpl.w   loc_3DBA6
                andi.w  #4,d5
                beq.w   loc_3DC7A
                bra.w   loc_3DD56
; ---------------------------------------------------------------------------
loc_3DE9E:                              ; CODE XREF: Boss_XiTigerLandedState+4   j
                move.l  $498(a5),d0
                beq.s   loc_3DEB4
                bmi.s   loc_3DEAE
                subi.l  #$2000,d0
                bra.s   loc_3DEB4
; ---------------------------------------------------------------------------
loc_3DEAE:                              ; CODE XREF: Boss_XiTigerLandedState+34   j
                addi.l  #$2000,d0
loc_3DEB4:                              ; CODE XREF: Boss_XiTigerLandedState+32   j
                                        ; Boss_XiTigerLandedState+3C   j
                move.l  d0,$498(a5)
                bra.s   loc_3DE62
; End of function Boss_XiTigerLandedState
; Attack pattern 1 with claw strikes
Boss_XiTigerAttackPattern1:                              ; CODE XREF: Boss_XiTigerMain+42   j  ; was: sub_3DEBA
                move.w  #$1C,4(a5)
                move.w  #$30,(word_FF809E).w ; '0'
                move.l  #word_EBA4A,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFB4000,$1C(a5)
                move.l  #$12000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$100,$BC(a5)
                bmi.s   loc_3DF06
                neg.l   $18(a5)
                clr.w   $54(a5)
loc_3DF06:                              ; CODE XREF: Boss_XiTigerAttackPattern1+42   j
                bsr.w Boss_XiTigerFlipDirection
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; End of function Boss_XiTigerAttackPattern1
; Attack pattern 2 with jumping
Boss_XiTigerAttackPattern2:                              ; DATA XREF: ROM:0003D8A4   o  ; was: sub_3DF12
                jsr (Gfx_UpdatePaletteFade).l
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DF6A
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DF6A
                addq.w  #2,4(a5)
                move.w  #$C0,$11C(a5)
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                clr.l   $1C(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                move.b  #$A1,d0
                jsr (Sound_PlaySFX).l
loc_3DF6A:                              ; CODE XREF: Boss_XiTigerAttackPattern2+E   j
                                        ; Boss_XiTigerAttackPattern2+18   j
                lea     word_3E464(pc),a1
                nop
                bsr.w Boss_XiTigerProcessAnimation
                bsr.w Boss_XiTigerUpdateSprites
                bra.w Boss_XiTigerSpawnProjectile
; End of function Boss_XiTigerAttackPattern2
; Attack pattern 3 with projectiles
Boss_XiTigerAttackPattern3:                              ; DATA XREF: ROM:0003D8A6   o  ; was: sub_3DF7C
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$11C(a5)
                bpl.s   loc_3DF9A
                addq.w  #2,4(a5)
                clr.w   6(a5)
                move.b  #$14,d0
                jsr (Sound_PlaySFX).l
loc_3DF9A:                              ; CODE XREF: Boss_XiTigerAttackPattern3+A   j
                tst.l   $18(a5)
                beq.s   loc_3DFB4
                bpl.s   loc_3DFAC
                addi.l  #$1000,$18(a5)
                bra.s   loc_3DFB4
; ---------------------------------------------------------------------------
loc_3DFAC:                              ; CODE XREF: Boss_XiTigerAttackPattern3+24   j
                subi.l  #$1000,$18(a5)
loc_3DFB4:                              ; CODE XREF: Boss_XiTigerAttackPattern3+22   j
                                        ; Boss_XiTigerAttackPattern3+2E   j
                lea     word_3E46E(pc),a1
                nop
loc_3DFBA:                              ; CODE XREF: Boss_XiTigerDefeatInit+40   j
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                bsr.w Boss_XiTigerProcessAnimation
                bsr.w Boss_XiTigerUpdateSprites
                bra.w Boss_XiTigerSpawnProjectile
; End of function Boss_XiTigerAttackPattern3
; Initializes boss defeat sequence
Boss_XiTigerDefeatInit:                              ; DATA XREF: ROM:0003D8A8   o  ; was: sub_3DFD2
                jsr (Gfx_UpdatePaletteFade).l
                bsr.w Gfx_QueueDMATransfer
                addq.w  #1,6(a5)
                cmpi.w  #$20,6(a5) ; ' '
                bmi.s   loc_3E00C
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$11C(a5) ; ' '
                clr.w   8(a5)
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$114,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
loc_3E00C:                              ; CODE XREF: Boss_XiTigerDefeatInit+14   j
                lea     word_3E46E(pc),a1
                nop
                bra.s   loc_3DFBA
; End of function Boss_XiTigerDefeatInit
; Updates defeat animation and effects
Boss_XiTigerDefeatUpdate:                              ; DATA XREF: ROM:0003D8AA   o  ; was: sub_3E014
                subq.w  #1,$11C(a5)
                bpl.s   loc_3E02A
                addq.w  #2,4(a5)
                jsr (Effect_InitPlayerSpawn).l
                addi.w  #$20,$14(a0) ; ' '
loc_3E02A:                              ; CODE XREF: Boss_XiTigerDefeatUpdate+4   j
                bra.w Gfx_QueueDMATransfer
; End of function Boss_XiTigerDefeatUpdate
; Completes defeat clearing boss entity
Boss_XiTigerDefeatComplete:                              ; DATA XREF: ROM:0003D8AC   o  ; was: sub_3E02E
                subq.w  #2,6(a5)
                bne.s   loc_3E03E
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
loc_3E03E:                              ; CODE XREF: Boss_XiTigerDefeatComplete+4   j
                bra.w Gfx_QueueDMATransfer
; End of function Boss_XiTigerDefeatComplete
; Final defeat state cleanup
Boss_XiTigerDefeatFinal:                              ; DATA XREF: ROM:0003D8AE   o  ; was: sub_3E042
                subq.w  #1,$11C(a5)
                bpl.s   locret_3E04E
                bset    #4,2(a5)
locret_3E04E:                           ; CODE XREF: Boss_XiTigerDefeatFinal+4   j
                rts
; End of function Boss_XiTigerDefeatFinal
; Updates boss sprite rendering
Boss_XiTigerUpdateSprites:                              ; CODE XREF: Boss_XiTigerFallingLanding+6A   j  ; was: sub_3E050
                                        ; Boss_XiTigerBattleStart+30   j ...
                moveq   #$17,d7
                jsr (Sprite_InitMetaspriteSimple).l
                bsr.w Boss_XiTigerUpdateBody
                bsr.w Boss_XiTigerUpdateClaws
                rts
; End of function Boss_XiTigerUpdateSprites
; Sets Xi-Tiger boss facing direction based on player position
Boss_XiTigerSetFacingDirection:                              ; CODE XREF: Boss_XiTigerIdleState+9A   j  ; was: sub_3E062
                                        ; Boss_XiTigerIdleState+DC   p ...
                clr.w   $54(a5)
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s Boss_XiTigerFlipDirection
                move.w  #$100,$54(a5)
; End of function Boss_XiTigerSetFacingDirection
; Flips boss sprite direction
Boss_XiTigerFlipDirection:                              ; CODE XREF: Boss_XiTigerSetup+BC   p  ; was: sub_3E076
                                        ; sub_3DEBA:loc_3DF06   p ...
                moveq   #3,d5
                tst.w   $54(a5)
                beq.s   loc_3E094
                bset    d5,$6E(a5)
                bset    d5,$2AE(a5)
                bset    d5,$5AE(a5)
                bclr    d5,$CE(a5)
                bclr    d5,$7EE(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E094:                              ; CODE XREF: Boss_XiTigerFlipDirection+6   j
                bclr    d5,$6E(a5)
                bclr    d5,$2AE(a5)
                bclr    d5,$5AE(a5)
                bset    d5,$CE(a5)
                bset    d5,$7EE(a5)
                rts
; End of function Boss_XiTigerFlipDirection
; Updates Xi-Tiger boss palette values based on position comparison
Boss_XiTigerUpdatePalette:
                move.w  $6D4(a5),d0  ; was: sub_3E0AA
                cmp.w   $914(a5),d0
                bpl.s   loc_3E0C8
                move.w  #$CF20,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E0C8:                              ; CODE XREF: Boss_XiTigerUpdatePalette+8   j
                move.w  #$CCE0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                rts
; End of function Boss_XiTigerUpdatePalette
; Sets Xi-Tiger animation data pointer based on controller input
Boss_XiTigerSetAnimationData:                              ; CODE XREF: Boss_XiTigerCloseRangeAI+68   p  ; was: sub_3E0DC
                move.l  #word_EBA2C,$68(a5)
                btst    #3,(word_FFA000+1).w
                bne.s   locret_3E0F4
                move.l  #word_EBA4A,$68(a5)
locret_3E0F4:                           ; CODE XREF: Boss_XiTigerSetAnimationData+E   j
                rts
; End of function Boss_XiTigerSetAnimationData
; Updates claw sprites based on state
Boss_XiTigerUpdateClaws:                              ; CODE XREF: Boss_XiTigerUpdateSprites+C   p  ; was: sub_3E0F6
                movea.w #(word_FFC860-M68K_RAM),a0
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
                tst.w   $1DE(a5)
                beq.s   loc_3E114
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
loc_3E114:                              ; CODE XREF: Boss_XiTigerUpdateClaws+12   j
                bsr.s Boss_XiTigerSetClawSprite
                movea.w #(word_FFCA40-M68K_RAM),a0
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
                tst.w   $1DC(a5)
                beq.s Boss_XiTigerSetClawSprite
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
; End of function Boss_XiTigerUpdateClaws
; Sets claw sprite graphics pointer
Boss_XiTigerSetClawSprite:                              ; CODE XREF: Boss_XiTigerUpdateClaws:loc_3E114   p  ; was: sub_3E134
                                        ; Boss_XiTigerUpdateClaws+32   j
                move.w  $56(a0),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_3E150
                eori.w  #$1800,$E(a0)
loc_3E150:                              ; CODE XREF: Boss_XiTigerSetClawSprite+14   j
                tst.w   $54(a5)
                beq.s   loc_3E15C
                eori.w  #$800,$E(a0)
loc_3E15C:                              ; CODE XREF: Boss_XiTigerSetClawSprite+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                add.w   d1,d0
                move.l  off_3E16C(pc,d0.w),8(a0)
                rts
; End of function Boss_XiTigerSetClawSprite
; ---------------------------------------------------------------------------
off_3E16C:      dc.l word_EBA68         ; DATA XREF: Boss_XiTigerSetClawSprite+30   r
                dc.l word_EBA74
                dc.l word_EBAA4
                dc.l word_EBA86
                dc.l word_EBB1C
                dc.l word_EBA86
                dc.l word_EBAA4
                dc.l word_EBA74


; Updates boss body metasprite positions
Boss_XiTigerUpdateBody:                              ; CODE XREF: Boss_XiTigerUpdateSprites+8   p  ; was: sub_3E18C
                move.w  #$C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0 ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp Boss_CheckScreenBounds
; End of function Boss_XiTigerUpdateBody
; Queues DMA transfer to VRAM
Gfx_QueueDMATransfer:                              ; CODE XREF: Boss_ShellshogunChargeAttack+C   p  ; was: sub_3E1AA
                                        ; sub_3987C:loc_39898   j ...
                move.w  6(a5),d0
                asr.w   #1,d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$3F,d5 ; '?'
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Gfx_QueueDMATransfer
; Spawns boss projectile with trajectory
Boss_XiTigerSpawnProjectile:                              ; CODE XREF: Boss_XiTigerAttackPattern2+66   j  ; was: sub_3E1C0
                                        ; Boss_XiTigerAttackPattern3+52   j
                jsr (Projectile_SpawnAtPosition).l
                bne.s   locret_3E21A
                movea.l #dword_2ABF0,a1 ; make offsets?
                jsr (Projectile_FindFreeSlotComplex).l
                move.b  #0,$20(a0)
                move.w  #$FFFD,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d0 ; ' '
                subi.w  #$10,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_3E21A:                           ; CODE XREF: Boss_XiTigerSpawnProjectile+6   j
                rts
; End of function Boss_XiTigerSpawnProjectile
; Processes boss animation with interpolation
Boss_XiTigerProcessAnimation:                              ; CODE XREF: Boss_XiTigerFallingLanding+66   p  ; was: sub_3E21C
                                        ; Boss_XiTigerBattleStart+2C   p ...
                clr.w   $29C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3E2A2
loc_3E226:                              ; CODE XREF: Boss_XiTigerProcessAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3E2B2
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3E248
                move.b  1(a1,d0.w),d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3E248:                              ; CODE XREF: Boss_XiTigerProcessAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3E258
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E258:                              ; CODE XREF: Boss_XiTigerProcessAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3E268
                clr.w   $58(a5)
                clr.w   $A(a5)
                bra.s   loc_3E226
; ---------------------------------------------------------------------------
loc_3E268:                              ; CODE XREF: Boss_XiTigerProcessAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3E492,d0
                movea.l d0,a0
                bsr.w Boss_XiTigerCalculateDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$A(a5)
                addq.w  #1,$29C(a5)
                subq.w  #1,$17E(a5)
                tst.w   $C(a5)
                bmi.s   loc_3E2B2
loc_3E2A2:                              ; CODE XREF: Boss_XiTigerProcessAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$F,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_3E2B2:                              ; CODE XREF: Boss_XiTigerProcessAnimation+E   j
                                        ; Boss_XiTigerProcessAnimation+84   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  $3C(a0),d6
                asl.w   #1,d6
                move.w  d6,d0
                addi.w  #$80,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                move.w  d0,$1D6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$236(a5)
                move.w  d1,$296(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d6,d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d1
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d0,$3B6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$416(a5)
                move.w  d1,$476(a5)
                move.b  $2C(a0),d1
                asl.w   #1,d1
                add.w   d6,d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d1
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $34(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $38(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                rts
; End of function Boss_XiTigerProcessAnimation
; Calculates animation interpolation deltas
Boss_XiTigerCalculateDeltas:                              ; CODE XREF: Boss_XiTigerProcessAnimation+62   p  ; was: sub_3E3B0
                movea.l #word_34DA6,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$F,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_XiTigerCalculateDeltas
; Loads animation data from table
Boss_XiTigerLoadAnimData:                              ; CODE XREF: Boss_XiTigerSetup+E8   p  ; was: sub_3E3C6
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #$F,d7
                jmp Anim_LoadFrameDelays
; End of function Boss_XiTigerLoadAnimData
; ---------------------------------------------------------------------------
word_3E3D2:     dc.w $F510, 0, $15, 0, $80DC, $F510, $10, $15, $10, $80DC, $FFFF
                                        ; DATA XREF: Boss_XiTigerBattleActive:loc_3DA86   o
                                        ; sub_3DB06:loc_3DB8A   o
word_3E3E8:     dc.w $F810, $70, $C, $70, $FFFE
                                        ; DATA XREF: Boss_XiTigerRecoveryCheck+2C   o
                                        ; sub_3DE08:loc_3DE62   o
word_3E3F2:     dc.w $FC08              ; DATA XREF: Boss_XiTigerDashDecelerate+7C   o
                dc.w $20, $12, $20, $FFFE
word_3E3FC:     dc.w $F810, $20, 3, $20, $F50E, $30, 4, $30, $F810, $20, 3, $20, $F511, $40, 4, $40
                                        ; DATA XREF: Boss_XiTigerCloseRangeAI:loc_3DD1A   o
                dc.w $F810, $20, 3, $20, $F510, $50, 4, $50, $FFFF
word_3E42E:     dc.w $F414, $80, $16, $80
                                        ; DATA XREF: Boss_XiTigerDashPrep:loc_3DC24   o
                dc.w $8880, $90, $FE10, $90, $10, $90, $FFFE
word_3E444:     dc.w $F410, $70, $18, $70, $FC0C, $A0, $C, $A0, $FFFE
                                        ; DATA XREF: Boss_XiTigerCloseRangeAI:loc_3DDB6   o
word_3E456:     dc.w $CA40, $B0, $FE0C, $B0, 8, $B0, $FFFE
                                        ; DATA XREF: Boss_XiTigerFallingLanding:loc_3DA30   o
                                        ; sub_3DDC4:loc_3DDFA   o
word_3E464:     dc.w $C, $A0, $C, $B0, $FFFF
                                        ; DATA XREF: Boss_XiTigerButtonCheck:loc_3DAF8   o
                                        ; sub_3DF12:loc_3DF6A   o
word_3E46E:     dc.w $E220, $C0, $E120, $70, $FFFF
                                        ; DATA XREF: Boss_XiTigerAttackPattern3:loc_3DFB4   o
                                        ; sub_3DFD2:loc_3E00C   o
word_3E478:     dc.w $F058, $D0, $38, $D0, $EC50, $C0, $D040, $C0, $ED18, $10, $14, $10, $FFFE
                                        ; DATA XREF: Boss_XiTigerBattleStart:loc_3DA64   o
word_3E492:     dc.w $C8EC, $3860, $1038, $38F0, $8C50, $AC70, $6400, $E0FA, $D4F8, $3050, $1014, $1018, $9640, $9870, $50C0, $606
                                        ; DATA XREF: Boss_XiTigerProcessAnimation+5A   o
                dc.w $C4E4, $B470, $1010, $4000, $9080, $3070, $6EF8, $D0FA, $D600, $2000, $800, $5000, $A090, $5070, $6EF0, $D00C
                dc.w $D608, $3010, $1008, $4000, $A090, $6060, $6008, $D00C, $DA06, $1800, $F8F4, $6000, $9490, $4080, $70F8, $C00C
                dc.w $CCE8, $2038, $808, $6000, $9688, $F060, $38D0, $20FC
word_3E502:     dc.w $D0F8, $60, $10E0, $6000, $8880, $A070, $A0A0, 0, $D000, $6860, $1000, $1000, $8830, $C090, $A0A0, $F0
                                        ; DATA XREF: Boss_XiTigerSetup+E2   o
                dc.w $C0E0, $C0C0, $1010, $4000, $8080, $A050, $6400, $E010, $C0D0, $C060, 0, $6030, $8070, $AC70, $5800, $D8F8
                dc.w $D808, $2800, $1040, $40E0, $A0B0, $C070, $6010, $D80A, $C800, $40E0, $1030, $10, $8040, $2070, $5000, $F000
                dc.w $C8F0, $5050, $1030, $10, $9030, $B070, $5000, $F000, $D0F6, $5450, $1830, $410, $8A2C, $B068, $50FC, $F000


; Main Deep Strider boss dispatcher
Boss_DeepStriderMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3E582
                tst.w   4(a5)
                beq.w Boss_DeepStriderStateDispatch
                tst.w   8(a5)
                beq.s Boss_DeepStriderStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3E5A8
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3E5A8
                tst.w   (word_FF8200).w
                beq.w Boss_DeepStriderReviveInit
loc_3E5A8:                              ; CODE XREF: Boss_DeepStriderMain+14   j
                                        ; Boss_DeepStriderMain+1C   j
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
; State machine dispatcher for Deep Strider boss
Boss_DeepStriderStateDispatch:                              ; CODE XREF: Boss_DeepStriderMain+4   j  ; was: loc_3E5BA
                                        ; Boss_DeepStriderMain+C   j
                move.w  4(a5),d0
                movea.w off_3E5CA(pc,d0.w),a0
                adda.l  #Boss_DeepStriderInit,a0
                jmp     (a0)
; End of function Boss_DeepStriderMain
; ---------------------------------------------------------------------------
off_3E5CA:      dc.w Boss_DeepStriderInit-Boss_DeepStriderInit
                                        ; DATA XREF: Boss_DeepStriderMain+3C   r
                dc.w Boss_DeepStriderIntroRise-Boss_DeepStriderInit
                dc.w Boss_DeepStriderIntro_RisingPhase-Boss_DeepStriderInit
                dc.w Boss_DeepStriderIntroWait-Boss_DeepStriderInit
                dc.w Boss_DeepStriderIntroDive-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDiveSetup-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDeathStart-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDeathRotate-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDeathSequence-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDefeatDelay-Boss_DeepStriderInit
                dc.w Boss_DeepStriderBattle_DescendPhase-Boss_DeepStriderInit
                dc.w Boss_DeepStriderBattle_WaitTimer-Boss_DeepStriderInit
                dc.w Boss_DeepStriderBattle_AscendPhase-Boss_DeepStriderInit
                dc.w Boss_DeepStriderIdleTimer-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDiveCheck-Boss_DeepStriderInit
                dc.w Boss_DeepStriderRevive_PaletteFade-Boss_DeepStriderInit
                dc.w Boss_DeepStriderReviveRise-Boss_DeepStriderInit
                dc.w Boss_DeepStriderReviveComplete-Boss_DeepStriderInit
                dc.w Boss_DeepStriderDefeatFinal-Boss_DeepStriderInit
                dc.w Boss_DeepStriderBattle_HoverAndShoot-Boss_DeepStriderInit
                dc.w Boss_DeepStriderBattle_PostDiveRise-Boss_DeepStriderInit


; Initializes Deep Strider boss state
Boss_DeepStriderInit:                              ; DATA XREF: Boss_DeepStriderMain+40   o  ; was: sub_3E5F4
                                        ; ROM:off_3E5CA   o ...
                addq.w  #2,4(a5)
                clr.w   8(a5)
; End of function Boss_DeepStriderInit
; Clears sprites except boss
Boss_DeepStriderClearSprites:                              ; CODE XREF: Boss_DeepStriderReviveRise+38   p  ; was: sub_3E5FC
                move.w  #$19C,d0
                move.w  #$208,d1
                jmp Sprite_ClearAllExcept
; End of function Boss_DeepStriderClearSprites
; Boss intro rise sequence
Boss_DeepStriderIntroRise:                              ; DATA XREF: ROM:0003E5CC   o  ; was: sub_3E60A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$D,d7
                movea.l #off_3F000,a0
                movea.l #word_3F038,a1
                movea.l #word_3F046,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$19C,(a5)
                bset    #0,$2A2(a5)
                move.w  #$D00,$4E2(a5)
                lea     (word_1BC6A).l,a1
                jsr (Sprite_InitFromPointerTable).l
                move.w  #4,4(a5)
                move.w  #$180,$536(a5)
                move.w  #$B8,$4F0(a5)
                move.w  #$60,$4F4(a5) ; '`'
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$100,$54(a5)
                move.w  #$80,$56(a5)
                move.w  #$1E2,$1DC(a5)
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5) ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$12000,$4FC(a5)
                clr.w   $11C(a5)
; Deep Strider intro rising with projectiles
Boss_DeepStriderIntro_RisingPhase:                              ; DATA XREF: ROM:0003E5CE   o  ; was: loc_3E6A0
                tst.w   $11C(a5)
                bne.s   loc_3E6C0
                cmpi.w  #$110,$4F4(a5)
                bmi.s   loc_3E6C0
                addq.w  #1,$11C(a5)
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
loc_3E6C0:                              ; CODE XREF: Boss_DeepStriderIntroRise+9A   j
                                        ; Boss_DeepStriderIntroRise+A2   j
                addq.w  #1,$1DC(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.l   $4FC(a5)
                move.w  #$34,$11C(a5) ; '4'
; Waits during intro rise before next state
Boss_DeepStriderIntroWait:                              ; DATA XREF: ROM:0003E5D0   o  ; was: loc_3E6E4
                subq.w  #1,$11C(a5)
                bpl.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #2,$29C(a5)
                move.w  #$100,$54(a5)
                bsr.w Boss_DeepStriderSetupPosition
; End of function Boss_DeepStriderIntroRise
; Boss intro dive sequence
Boss_DeepStriderIntroDive:                              ; DATA XREF: ROM:0003E5D2   o  ; was: sub_3E700
                bsr.w Boss_DeepStriderDiveSequence
                bmi.w   locret_3EED6
                addq.w  #2,4(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                move.w  #$38,$11C(a5) ; '8'
; Sets up dive parameters and velocities
Boss_DeepStriderDiveSetup:                              ; DATA XREF: ROM:0003E5D4   o  ; was: loc_3E71A
                subq.w  #1,$11C(a5)
                bpl.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$198,$4F0(a5)
                move.w  #$160,$4F4(a5)
                clr.w   $54(a5)
                move.w  #$1A0,$56(a5)
                move.w  #$28,$1DC(a5) ; '('
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5) ; ' '
                move.w  #0,$23E(a5)
                move.l  #$FFFF0000,$4F8(a5)
                move.l  #$FFF80000,$4FC(a5)
                clr.w   $11C(a5)
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
; End of function Boss_DeepStriderIntroDive
; Starts boss death sequence
Boss_DeepStriderDeathStart:                              ; DATA XREF: ROM:0003E5D6   o  ; was: sub_3E776
                subq.w  #1,$1DE(a5)
                subq.w  #1,$1DC(a5)
                subq.w  #1,$56(a5)
                addi.l  #$3800,$4FC(a5)
                bmi.w Boss_DeepStriderUpdateParts
                cmpi.w  #$120,$2B4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$120,$2B4(a5)
                move.w  #$C8C0,$48(a5)
                move.w  #$C8C0,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
; Rotates boss during death sequence
Boss_DeepStriderDeathRotate:                              ; DATA XREF: ROM:0003E5D8   o  ; was: loc_3E7B6
                subq.w  #6,$56(a5)
                subq.w  #2,$1DC(a5)
                andi.w  #$1FE,$1DC(a5)
                cmpi.w  #$1E0,$1DC(a5)
                bne.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                clr.w   $17C(a5)
                moveq   #0,d0
                jsr (UI_CheckVictoryCondition).l
                bra.s Boss_DeepStriderDeathSequence
; End of function Boss_DeepStriderDeathStart
; Delay timer before defeat
Boss_DeepStriderDefeatDelay:                              ; DATA XREF: ROM:0003E5DC   o  ; was: sub_3E7E8
                subq.w  #1,$17E(a5)
                bpl.s   loc_3E80C
                bra.w Boss_DeepStriderBattleLogic
; End of function Boss_DeepStriderDefeatDelay
; Boss death animation sequence
Boss_DeepStriderDeathSequence:                              ; CODE XREF: Boss_DeepStriderDeathStart+70   j  ; was: sub_3E7F2
                                        ; DATA XREF: ROM:0003E5DA   o
                tst.w   (word_FF80C2).w
                bne.s   loc_3E80C
                addq.w  #2,4(a5)
                move.w  #$40,$17E(a5) ; '@'
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
loc_3E80C:                              ; CODE XREF: Boss_DeepStriderDefeatDelay+4   j
                                        ; Boss_DeepStriderDeathSequence+4   j
                andi.w  #$1FC,$1DE(a5)
                tst.w   $11E(a5)
                bpl.s   loc_3E86A
                tst.w   $17C(a5)
                bne.s   loc_3E844
                cmpi.w  #$1E0,$1DE(a5)
                beq.s   loc_3E82A
                addq.w  #4,$1DE(a5)
loc_3E82A:                              ; CODE XREF: Boss_DeepStriderDeathSequence+32   j
                addq.w  #3,$56(a5)
                addq.w  #2,$1DC(a5)
                cmpi.w  #$1FA,$1DC(a5)
                bpl.s   loc_3E872
                subq.w  #1,$11C(a5)
                bmi.s   loc_3E872
                bra.w Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E844:                              ; CODE XREF: Boss_DeepStriderDeathSequence+2A   j
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   loc_3E850
                subq.w  #4,$1DE(a5)
loc_3E850:                              ; CODE XREF: Boss_DeepStriderDeathSequence+58   j
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1D8,$1DC(a5)
                bmi.s   loc_3E872
                subq.w  #1,$11C(a5)
                bmi.s   loc_3E872
                bra.w Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E86A:                              ; CODE XREF: Boss_DeepStriderDeathSequence+24   j
                subq.w  #1,$11E(a5)
                bra.w Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E872:                              ; CODE XREF: Boss_DeepStriderDeathSequence+46   j
                                        ; Boss_DeepStriderDeathSequence+4C   j ...
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #6,d0
                move.w  d0,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$11E(a5)
                eori.w  #1,$17C(a5)
                bra.w Boss_DeepStriderUpdateParts
; End of function Boss_DeepStriderDeathSequence
; Main battle logic with attack patterns and phase transitions
Boss_DeepStriderBattleLogic:                              ; CODE XREF: Boss_DeepStriderDefeatDelay+6   j  ; was: sub_3E896
                addq.w  #2,4(a5)
                move.w  #2,$11C(a5)
                move.w  #$80,$536(a5)
; Deep Strider battle descend with rotation
Boss_DeepStriderBattle_DescendPhase:                              ; DATA XREF: ROM:0003E5DE   o  ; was: loc_3E8A6
                andi.w  #$1FC,$1DE(a5)
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   loc_3E8B8
                subq.w  #4,$1DE(a5)
loc_3E8B8:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1C   j
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1CC,$1DC(a5)
                bpl.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
; Deep Strider battle wait timer
Boss_DeepStriderBattle_WaitTimer:                              ; DATA XREF: ROM:0003E5E0   o  ; was: loc_3E8CE
                subq.w  #1,$11C(a5)
                bpl.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5) ; ' '
                clr.w   $11E(a5)
                addq.w  #2,$29C(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.l  #$1E000,$4F8(a5)
                move.l  #$FFFB0000,$4FC(a5)
                bclr    #0,$2A2(a5)
; Deep Strider battle ascend with projectiles
Boss_DeepStriderBattle_AscendPhase:                              ; DATA XREF: ROM:0003E5E2   o  ; was: loc_3E90A
                tst.w   $11E(a5)
                bne.s   loc_3E92A
                cmpi.w  #$150,$4F4(a5)
                bmi.s   loc_3E92A
                addq.w  #1,$11E(a5)
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
loc_3E92A:                              ; CODE XREF: Boss_DeepStriderBattleLogic+78   j
                                        ; Boss_DeepStriderBattleLogic+80   j
                addq.w  #6,$56(a5)
                addq.w  #1,$1DC(a5)
                subi.l  #$C00,$4F8(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                move.w  #$B,$17C(a5)
loc_3E952:                              ; CODE XREF: Boss_DeepStriderBattleLogic+28A   j
                                        ; Boss_DeepStriderDiveCheck+10   j ...
                move.w  #$1A,4(a5)
                bclr    #0,(byte_FF825C).w
                move.b  #$10,$141(a5)
                move.w  #$18,$534(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_3E98C
                move.w  #$10,$11C(a5)
                bra.s Boss_DeepStriderIdleTimer
; ---------------------------------------------------------------------------
loc_3E98C:                              ; CODE XREF: Boss_DeepStriderBattleLogic+EC   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addq.w  #4,d0
                move.w  d0,$11C(a5)
; Idle timer before attack selection
Boss_DeepStriderIdleTimer:                              ; CODE XREF: Boss_DeepStriderBattleLogic+F4   j  ; was: loc_3E99A
                                        ; DATA XREF: ROM:0003E5E4   o
                subq.w  #1,$11C(a5)
                bpl.w Boss_DeepStriderUpdateParts
                subq.w  #1,$17C(a5)
                cmpi.w  #$A,$17C(a5)
                bpl.w   loc_3EB24
                tst.w   $17C(a5)
                bmi.w   loc_3E9DC
                btst    #0,(byte_FF8244).w
                beq.w   loc_3EB24
                moveq   #7,d0
                btst    #6,(byte_FF8244).w
                beq.w   loc_3E9D0
                moveq   #1,d0
loc_3E9D0:                              ; CODE XREF: Boss_DeepStriderBattleLogic+134   j
                move.w  (dword_FFFF08).w,d1
                and.w   d0,d1
                beq.s   loc_3E9DC
                bra.w   loc_3EB24
; ---------------------------------------------------------------------------
loc_3E9DC:                              ; CODE XREF: Boss_DeepStriderBattleLogic+11E   j
                                        ; Boss_DeepStriderBattleLogic+140   j
                move.w  #$26,4(a5) ; '&'
                move.w  #1,$534(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                move.w  #$BF,$17C(a5)
                move.w  #$180,$56(a5)
                move.w  #$180,$536(a5)
                move.w  #$1F4,$1DC(a5)
                clr.w   $23C(a5)
                move.w  #$1E0,$1DE(a5)
                bsr.w Boss_DeepStriderCalculateX
                move.w  d0,$4F0(a5)
                move.w  #$1B0,$4F4(a5)
; Deep Strider hovering with angle firing
Boss_DeepStriderBattle_HoverAndShoot:                              ; DATA XREF: ROM:0003E5F0   o  ; was: loc_3EA20
                jsr (Physics_CalculateDistanceTo).l
                move.w  #$100,$54(a5)
                tst.w   d1
                bpl.s   loc_3EA34
                clr.w   $54(a5)
loc_3EA34:                              ; CODE XREF: Boss_DeepStriderBattleLogic+198   j
                tst.w   $11E(a5)
                bne.s   loc_3EA48
                addq.w  #1,$56(a5)
                cmpi.w  #$190,$56(a5)
                beq.s   loc_3EA54
                bra.s   loc_3EA5A
; ---------------------------------------------------------------------------
loc_3EA48:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1A2   j
                subq.w  #1,$56(a5)
                cmpi.w  #$178,$56(a5)
                bne.s   loc_3EA5A
loc_3EA54:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1AE   j
                eori.w  #1,$11E(a5)
loc_3EA5A:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1B0   j
                                        ; Boss_DeepStriderBattleLogic+1BC   j
                tst.w   $11C(a5)
                beq.s   loc_3EA8E
                addi.l  #$C00,$4FC(a5)
                bmi.s   loc_3EA7C
                cmpi.l  #$10000,$4FC(a5)
                bmi.s   loc_3EA7C
                move.l  #$10000,$4FC(a5)
loc_3EA7C:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1D2   j
                                        ; Boss_DeepStriderBattleLogic+1DC   j
                cmpi.w  #$160,$4F4(a5)
                bmi.s   loc_3EAB8
                tst.w   $17C(a5)
                bmi.w   loc_3EACE
                bra.s   loc_3EAB2
; ---------------------------------------------------------------------------
loc_3EA8E:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1C8   j
                subi.l  #$1000,$4FC(a5)
                bpl.s   loc_3EAAA
                cmpi.l  #$FFFF0000,$4FC(a5)
                bpl.s   loc_3EAAA
                move.l  #$FFFF0000,$4FC(a5)
loc_3EAAA:                              ; CODE XREF: Boss_DeepStriderBattleLogic+200   j
                                        ; Boss_DeepStriderBattleLogic+20A   j
                cmpi.w  #$170,$4F4(a5)
                bpl.s   loc_3EAB8
loc_3EAB2:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1F6   j
                eori.w  #1,$11C(a5)
loc_3EAB8:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1EC   j
                                        ; Boss_DeepStriderBattleLogic+21A   j
                subq.w  #1,$17C(a5)
                cmpi.w  #$9F,$17C(a5)
                bpl.w Boss_DeepStriderUpdateParts
                bsr.w Boss_DeepStriderFireAngleProjectile
                bra.w Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3EACE:                              ; CODE XREF: Boss_DeepStriderBattleLogic+1F2   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.l  #$FFFB0000,$4FC(a5)
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
                move.w  #$B,$17C(a5)
; Deep Strider post-dive rising with scroll
Boss_DeepStriderBattle_PostDiveRise:                              ; DATA XREF: ROM:0003E5F2   o  ; was: loc_3EAF2
                addq.w  #1,$11C(a5)
                addi.l  #$3A00,$4FC(a5)
                subq.w  #8,$56(a5)
                subq.w  #1,$1DC(a5)
                cmpi.w  #$18,$11C(a5)
                bmi.s   loc_3EB16
                addq.w  #2,$1DC(a5)
                addq.w  #4,$56(a5)
loc_3EB16:                              ; CODE XREF: Boss_DeepStriderBattleLogic+276   j
                cmpi.w  #$1C0,$4F4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB24:                              ; CODE XREF: Boss_DeepStriderBattleLogic+116   j
                                        ; Boss_DeepStriderBattleLogic+128   j ...
                move.b  #$12,$141(a5)
                clr.w   $17E(a5)
                move.w  #$1C,4(a5)
                move.w  $29C(a5),d0
                beq.s   loc_3EB50
                cmpi.w  #4,d0
                bpl.s   loc_3EB4A
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_3EB50
loc_3EB4A:                              ; CODE XREF: Boss_DeepStriderBattleLogic+2A8   j
                clr.w   $54(a5)
                bra.s   loc_3EB56
; ---------------------------------------------------------------------------
loc_3EB50:                              ; CODE XREF: Boss_DeepStriderBattleLogic+2A2   j
                                        ; Boss_DeepStriderBattleLogic+2B2   j
                move.w  #$100,$54(a5)
loc_3EB56:                              ; CODE XREF: Boss_DeepStriderBattleLogic+2B8   j
                bsr.w Boss_DeepStriderSetupPosition
; End of function Boss_DeepStriderBattleLogic
; Checks dive completion and damage state
Boss_DeepStriderDiveCheck:                              ; DATA XREF: ROM:0003E5E6   o  ; was: sub_3EB5A
                bsr.w Boss_DeepStriderDiveSequence
                bmi.s   loc_3EB76
                tst.w   $54(a5)
                bne.s   loc_3EB6E
                subq.w  #2,$29C(a5)
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB6E:                              ; CODE XREF: Boss_DeepStriderDiveCheck+A   j
                addq.w  #2,$29C(a5)
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB76:                              ; CODE XREF: Boss_DeepStriderDiveCheck+4   j
                tst.w   $17E(a5)
                bne.s   loc_3EB90
                bclr    #1,$142(a5)
                beq.s   locret_3EBC8
                bset    #1,(byte_FF825C).w
                move.w  #2,$17E(a5)
loc_3EB90:                              ; CODE XREF: Boss_DeepStriderDiveCheck+20   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_3EB9E
                clr.w   $17E(a5)
                rts
; ---------------------------------------------------------------------------
loc_3EB9E:                              ; CODE XREF: Boss_DeepStriderDiveCheck+3C   j
                move.w  #$64,(word_FF824E).w ; 'd'
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $130(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8250).w
                move.w  $134(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8252).w
locret_3EBC8:                           ; CODE XREF: Boss_DeepStriderDiveCheck+28   j
                rts
; End of function Boss_DeepStriderDiveCheck
; Initializes boss revival sequence
Boss_DeepStriderReviveInit:                              ; CODE XREF: Boss_DeepStriderMain+22   j  ; was: sub_3EBCA
                move.w  #4,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                jsr (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$80,$536(a5)
                move.w  #$30,$1DC(a5) ; '0'
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5) ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$FFFBE000,$4FC(a5)
                move.l  #$FFFEE000,$4F8(a5)
                cmpi.w  #$880,$BC(a5)
                bpl.s Boss_DeepStriderRevive_PaletteFade
                neg.l   $4F8(a5)
; Fades palette and spawns debris during revival
Boss_DeepStriderRevive_PaletteFade:                              ; CODE XREF: Boss_DeepStriderReviveInit+5E   j  ; was: loc_3EC2E
                                        ; DATA XREF: ROM:0003E5E8   o
                jsr (Gfx_UpdatePaletteFade).l
                bsr.w Boss_DeepStriderSpawnDebris
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                bmi.w Boss_DeepStriderUpdateParts
                cmpi.w  #$150,$4F4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.l  #$FFFEE000,$4FC(a5)
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
; End of function Boss_DeepStriderReviveInit
; Boss rises during revival
Boss_DeepStriderReviveRise:                              ; DATA XREF: ROM:0003E5EA   o  ; was: sub_3EC7A
                jsr (Gfx_UpdatePaletteFade).l
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                cmpi.w  #$180,$4F4(a5)
                bmi.w Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  $4F0(a5),$10(a5)
                move.w  #$30,$48(a5) ; '0'
                move.w  #$100,2(a5)
                clr.w   8(a5)
                bsr.w Boss_DeepStriderClearSprites
; End of function Boss_DeepStriderReviveRise
; Completes boss revival with debris
Boss_DeepStriderReviveComplete:                              ; DATA XREF: ROM:0003E5EC   o  ; was: sub_3ECB6
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bpl.w   locret_3EED6
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #8,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                movea.w a5,a0
                move.l  #$FFF80000,d4
                move.w  $10(a5),d5
loc_3ECE6:                              ; CODE XREF: Boss_DeepStriderReviveComplete+60   j
                lea     $60(a0),a0
                move.b  #$30,d0 ; '0'
                jsr (Sound_PlaySFX).l
                jsr (Projectile_InitType2A).l
                move.l  #off_E953C,8(a0)
                move.l  d4,$1C(a0)
                move.w  #$150,$14(a0)
                move.w  d5,$10(a0)
                addi.l  #$8000,d4
                bmi.s   loc_3ECE6
; End of function Boss_DeepStriderReviveComplete
; Final defeat of Deep Strider
Boss_DeepStriderDefeatFinal:                              ; DATA XREF: ROM:0003E5EE   o  ; was: sub_3ED18
                subq.w  #1,$48(a5)
                bpl.s   locret_3ED24
                bset    #4,2(a5)
locret_3ED24:                           ; CODE XREF: Boss_DeepStriderDefeatFinal+4   j
                rts
; End of function Boss_DeepStriderDefeatFinal
; Spawns debris projectiles during Deep Strider boss revival
Boss_DeepStriderSpawnDebris:                              ; CODE XREF: Boss_DeepStriderReviveInit+6A   p  ; was: sub_3ED26
                move.w  #2,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                btst    #0,(word_FFA000+1).w
                bne.s   locret_3ED9A
                jsr (Projectile_FindFreeSlotAndClear).l
                bne.s   locret_3ED9A
                jsr (Sprite_InitializeProperties).l
                move.l  #off_E953C,8(a0)
                move.b  (dword_FFFF08).w,d1
                andi.w  #3,d1
                bne.s   loc_3ED62
                move.l  #off_E95DC,8(a0)
loc_3ED62:                              ; CODE XREF: Boss_DeepStriderSpawnDebris+32   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  $4F0(a5),$10(a0)
                add.w   d0,$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  #$FFFC2000,$1C(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_3ED9A
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_3ED9A:                           ; CODE XREF: Boss_DeepStriderSpawnDebris+12   j
                                        ; Boss_DeepStriderSpawnDebris+1A   j ...
                rts
; End of function Boss_DeepStriderSpawnDebris
; Spawns quad projectile pattern
Boss_DeepStriderSpawnProjectiles:                              ; CODE XREF: Boss_DeepStriderIntroRise+B2   p  ; was: sub_3ED9C
                                        ; Boss_DeepStriderIntroDive+72   p ...
                move.w  $D0(a5),d5
                move.w  #$150,d6
                jmp Projectile_SpawnQuadPattern
; End of function Boss_DeepStriderSpawnProjectiles
; Sets up boss position and velocity
Boss_DeepStriderSetupPosition:                              ; CODE XREF: Boss_DeepStriderIntroRise+F2   p  ; was: sub_3EDAA
                                        ; sub_3E896:loc_3EB56   p
                move.w  #$180,$536(a5)
                clr.w   $11C(a5)
                bsr.w Boss_DeepStriderCalculateX
                move.w  d0,$4F0(a5)
                move.w  #$160,$4F4(a5)
                move.w  #$17C,$56(a5)
                move.w  #$1FC,$1DC(a5)
                move.w  #$1A0,$1DE(a5)
                move.w  #$20,$23C(a5) ; ' '
                move.w  #$1B0,$23E(a5)
                move.l  #$FFFC4800,$4F8(a5)
                move.l  #$FFFA0000,$4FC(a5)
                tst.w   $54(a5)
                beq.s   locret_3EDFA
                neg.l   $4F8(a5)
locret_3EDFA:                           ; CODE XREF: Boss_DeepStriderSetupPosition+4A   j
                rts
; End of function Boss_DeepStriderSetupPosition
; Calculates boss X coordinate
Boss_DeepStriderCalculateX:                              ; CODE XREF: Boss_DeepStriderBattleLogic+17C   p  ; was: sub_3EDFC
                                        ; Boss_DeepStriderSetupPosition+A   p
                moveq   #0,d2
                move.w  $29C(a5),d0
                move.w  word_3EE14(pc,d0.w),d0
                move.w  (dword_FFA900).w,d1
                subi.w  #$710,d1
                sub.w   d1,d0
                add.w   d2,d0
                rts
; End of function Boss_DeepStriderCalculateX
; ---------------------------------------------------------------------------
word_3EE14:     dc.w $90, $170, $250    ; DATA XREF: Boss_DeepStriderCalculateX+6   r


; Boss dive attack sequence
Boss_DeepStriderDiveSequence:                              ; CODE XREF: Boss_DeepStriderIntroDive   p  ; was: sub_3EE1A
                                        ; sub_3EB5A   p
                addq.w  #1,$11C(a5)
                move.b  #$4C,d0 ; 'L'
                cmpi.w  #3,$11C(a5)
                beq.s   loc_3EE36
                move.b  #$4D,d0 ; 'M'
                cmpi.w  #$32,$11C(a5) ; '2'
                bne.s   loc_3EE40
loc_3EE36:                              ; CODE XREF: Boss_DeepStriderDiveSequence+E   j
                jsr (Sound_PlaySFX).l
                bsr.w Boss_DeepStriderSpawnProjectiles
loc_3EE40:                              ; CODE XREF: Boss_DeepStriderDiveSequence+1A   j
                subq.w  #4,$56(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3EE52
                addq.w  #1,$56(a5)
loc_3EE52:                              ; CODE XREF: Boss_DeepStriderDiveSequence+32   j
                cmpi.w  #$11,$11C(a5)
                bmi.s   loc_3EE7C
                cmpi.w  #$34,$11C(a5) ; '4'
                bpl.s   loc_3EE70
                cmpi.w  #$1F4,$1DC(a5)
                beq.s   loc_3EE7C
                subq.w  #1,$1DC(a5)
                bra.s   loc_3EE7C
; ---------------------------------------------------------------------------
loc_3EE70:                              ; CODE XREF: Boss_DeepStriderDiveSequence+46   j
                cmpi.w  #$1FC,$1DC(a5)
                beq.s   loc_3EE7C
                addq.w  #1,$1DC(a5)
loc_3EE7C:                              ; CODE XREF: Boss_DeepStriderDiveSequence+3E   j
                                        ; Boss_DeepStriderDiveSequence+4E   j ...
                cmpi.w  #$1A,$11C(a5)
                bmi.s   loc_3EE90
                cmpi.w  #$1F0,$23E(a5)
                beq.s   loc_3EE90
                addq.w  #1,$23E(a5)
loc_3EE90:                              ; CODE XREF: Boss_DeepStriderDiveSequence+68   j
                                        ; Boss_DeepStriderDiveSequence+70   j
                cmpi.w  #$1F8,$1DE(a5)
                beq.s   loc_3EE9C
                addq.w  #1,$1DE(a5)
loc_3EE9C:                              ; CODE XREF: Boss_DeepStriderDiveSequence+7C   j
                cmpi.w  #$30,$11C(a5) ; '0'
                bmi.s   loc_3EEBC
                tst.w   $4F8(a5)
                bmi.s   loc_3EEB4
                subi.l  #$3000,$4F8(a5)
                bra.s   loc_3EEBC
; ---------------------------------------------------------------------------
loc_3EEB4:                              ; CODE XREF: Boss_DeepStriderDiveSequence+8E   j
                addi.l  #$3000,$4F8(a5)
loc_3EEBC:                              ; CODE XREF: Boss_DeepStriderDiveSequence+88   j
                                        ; Boss_DeepStriderDiveSequence+98   j
                bsr.w Boss_DeepStriderUpdateParts
                addi.l  #$3200,$4FC(a5)
                bmi.w   locret_3EED6
                cmpi.w  #$1E0,$14(a5)
                bmi.w   *+4
locret_3EED6:                           ; CODE XREF: Boss_DeepStriderIntroDive+4   j
                                        ; Boss_DeepStriderReviveComplete+A   j ...
                rts
; End of function Boss_DeepStriderDiveSequence
; Updates boss metasprite parts
Boss_DeepStriderUpdateParts:                              ; CODE XREF: Boss_DeepStriderIntroRise+C8   j  ; was: sub_3EED8
                                        ; Boss_DeepStriderIntroRise+DE   j ...
                move.w  #$1FF,d0
                and.w   d0,$56(a5)
                and.w   d0,$1DC(a5)
                and.w   d0,$1DE(a5)
                and.w   d0,$23C(a5)
                and.w   d0,$23E(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  $1DC(a5),d0
                moveq   #2,d7
; Updates rotation angles for body parts
Boss_DeepStriderUpdateAngles:                              ; CODE XREF: Boss_DeepStriderUpdateParts+28   j  ; was: loc_3EEFA
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf d7,Boss_DeepStriderUpdateAngles
                move.w  $1DC(a5),$B6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  d0,d1
                add.w   d0,d1
                move.w  d1,$116(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  d0,d1
                add.w   d0,d1
                add.w   d0,d1
                move.w  d1,$176(a5)
                move.w  $1DC(a5),d0
                move.w  #$100,d1
                sub.w   d0,d1
                move.w  d1,$1D6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$236(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$296(a5)
                move.w  (dword_FF9404).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$2F6(a5)
                move.w  d1,d2
                addi.w  #$80,d1
                add.w   $23E(a5),d1
                move.w  d1,$356(a5)
                subi.w  #$80,d2
                sub.w   $23E(a5),d2
                move.w  d2,$3B6(a5)
                move.w  $B6(a5),d1
                addi.w  #$80,d1
                add.w   $23C(a5),d1
                move.w  d1,$4D6(a5)
                move.w  $116(a5),d2
                subi.w  #$80,d2
                add.w   $1DE(a5),d2
                move.w  d2,$416(a5)
                move.w  d2,$476(a5)
                moveq   #$C,d7
                jmp Sprite_UpdateMetaspriteParts
; End of function Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
off_3EFAE:      dc.l word_EBDE6         ; DATA XREF: ROM:0003F00C   o
                dc.l word_EBDDA
                dc.l word_EBDD4
                dc.l word_EBDCE
off_3EFBE:      dc.l word_EBE16         ; DATA XREF: ROM:0003F004   o
                                        ; ROM:0003F008   o
                dc.l word_EBE10
                dc.l word_EBE0A
                dc.l word_EBE04
off_3EFCE:      dc.l word_EBE5E         ; DATA XREF: ROM:0003F024   o
                                        ; ROM:0003F030   o
                dc.l word_EBE58
                dc.l word_EBE52
                dc.l word_EBE4C
off_3EFDE:      dc.l word_EBE4C         ; DATA XREF: ROM:0003F020   o
                                        ; ROM:0003F02C   o
                dc.l word_EBE52
                dc.l word_EBE58
                dc.l word_EBE5E
word_3EFEE:     dc.w $6397, $A00, $F4F4 ; DATA XREF: ROM:0003F014   o
                                        ; ROM:0003F028   o
word_3EFF4:     dc.w $63A0, $500, $F8F8 ; DATA XREF: ROM:0003F018   o
word_3EFFA:     dc.w $63A4, $500, $F8F8 ; DATA XREF: ROM:0003F01C   o
off_3F000:      dc.l word_EBE7C+$400000 ; DATA XREF: Boss_DeepStriderIntroRise+E   o
                dc.l off_3EFBE
                dc.l off_3EFBE
                dc.l off_3EFAE
                dc.l word_EBE7C+$400000
                dc.l word_3EFEE+1
                dc.l word_3EFF4+1
                dc.l word_3EFFA+1
                dc.l off_3EFDE+$28000000
                dc.l off_3EFCE
                dc.l word_3EFEE+1
                dc.l off_3EFDE+$28000000
                dc.l off_3EFCE
                dc.l 0
word_3F038:     dc.w $15, $1210, $1410  ; DATA XREF: Boss_DeepStriderIntroRise+14   o
                dc.w $C0A, $C0C, $E10
                dc.w $1418
word_3F046:     dc.w $C007, $C006, $C065
                                        ; DATA XREF: Boss_DeepStriderIntroRise+1A   o
                dc.w $C0C4, $C007, $C187
                dc.w $C1E7, $C247, $C2A7
                dc.w $C2A7, $C0C4, $C3C4
                dc.w $C067, 7


; Fires angled projectile from Deep Strider boss using sine table
Boss_DeepStriderFireAngleProjectile:                              ; CODE XREF: Boss_DeepStriderBattleLogic+230   p  ; was: sub_3F062
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_3F112
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_3F112
                move.w  #$350,(a0)
                move.w  #$AD80,2(a0)
                move.w  #$4411,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$10,$20(a0)
                move.b  #$40,$21(a0) ; '@'
                move.w  #$50,$26(a0) ; 'P'
                move.l  #$FF01FF01,$2C(a0)
                move.w  (dword_FFFF08).w,d3
                ext.l   d3
                asl.l   #2,d3
                lea     (word_1B514).l,a1
                move.w  $56(a5),d7
                addi.w  #$20,d7 ; ' '
                andi.w  #$1FE,d7
                move.w  -$80(a1,d7.w),d0
                move.w  (a1,d7.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                clr.l   $18(a0)
                move.w  $134(a5),$14(a0)
                addq.w  #2,$14(a0)
                move.w  $130(a5),$10(a0)
                btst    #3,$12E(a5)
                beq.s   loc_3F106
                subq.w  #4,$10(a0)
                sub.l   d3,$18(a0)
                sub.l   d1,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_3F106:                              ; CODE XREF: Boss_DeepStriderFireAngleProjectile+94   j
                addq.w  #4,$10(a0)
                add.l   d3,$18(a0)
                add.l   d1,$18(a0)
locret_3F112:                           ; CODE XREF: Boss_DeepStriderFireAngleProjectile+8   j
                                        ; Boss_DeepStriderFireAngleProjectile+12   j
                rts
; End of function Boss_DeepStriderFireAngleProjectile
; Handles enemy bouncing on floor collision or spawning explosion
Enemy_BounceOnFloorOrExplode:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3F114
                tst.w   (word_FF808C).w
                bpl.s   loc_3F14E
                bclr    #7,$22(a5)
                beq.s   loc_3F146
                bclr    #4,$22(a5)
                beq.s   loc_3F14E
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_3F14E
                jsr     (loc_2BD00).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                bra.s   loc_3F14E
; ---------------------------------------------------------------------------
loc_3F146:                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+C   j
                jsr (Collision_GetEntityPosition).l
                beq.s   loc_3F164
loc_3F14E:                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+4   j
                                        ; Enemy_BounceOnFloorOrExplode+14   j ...
                neg.w   $18(a5)
                move.w  #$FFFE,$1C(a5)
                lea     (dword_2ABF0).l,a1 ; make offsets?
                jmp Sys_PassObjectAddress
; ---------------------------------------------------------------------------
loc_3F164:                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+38   j
                addi.l  #$E00,$1C(a5)
                bmi.s   locret_3F196
                cmpi.w  #$14C,$14(a5)
                bmi.s   locret_3F196
                clr.l   $18(a5)
                move.l  #$FFFC0000,$1C(a5)
loc_3F182:                              ; CODE XREF: Enemy_FallingBombLogic+C0   p
                move.l  #off_1A0E96,8(a5)
                jsr (Enemy_GetEntityAddress).l
                move.w  #$4000,$E(a5)
locret_3F196:                           ; CODE XREF: Enemy_BounceOnFloorOrExplode+58   j
                                        ; Enemy_BounceOnFloorOrExplode+60   j
                rts
; End of function Enemy_BounceOnFloorOrExplode
; ---------------------------------------------------------------------------
off_3F198:      dc.l word_EBFE0         ; DATA XREF: Boss_GustheadMain+20   o
                dc.l word_EBFF8


; Wrapper for Gusthead boss main
Boss_GustheadMainWrapper:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3F1A0
                bsr.s Boss_GustheadMain
                rts
; End of function Boss_GustheadMainWrapper
; Main Gusthead boss handler
Boss_GustheadMain:                              ; CODE XREF: Boss_GustheadMainWrapper   p  ; was: sub_3F1A4
                tst.w   4(a5)
                beq.w   loc_3F240
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_3F1D2
                addq.w  #4,$58(a5)
                andi.w  #4,$58(a5)
                move.w  $58(a5),d0
                lea     off_3F198(pc),a1
                move.l  (a1,d0.w),8(a5)
                clr.w   $C(a5)
loc_3F1D2:                              ; CODE XREF: Boss_GustheadMain+10   j
                tst.w   (word_FFA968).w
                beq.s   loc_3F1E0
                move.l  (dword_FFA960).w,d0
                add.l   d0,$10(a5)
loc_3F1E0:                              ; CODE XREF: Boss_GustheadMain+32   j
                cmpi.w  #$50,4(a5) ; 'P'
                bcc.s   loc_3F1F0
                move.l  (dword_FF8240).w,(dword_FF9428).w
                bra.s   loc_3F1FC
; ---------------------------------------------------------------------------
loc_3F1F0:                              ; CODE XREF: Boss_GustheadMain+42   j
                move.l  (dword_FFA960).w,d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,(dword_FF9428).w
loc_3F1FC:                              ; CODE XREF: Boss_GustheadMain+4A   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3F22E
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3F22E
                tst.w   (word_FF8200).w
                bne.s   loc_3F22E
                move.b  #2,(byte_FF80EC).w
                bset    #7,$4A(a5)
                clr.l   (dword_FF8240).w
                move.w  #$5C,4(a5) ; '\'
                bset    #0,(byte_FFA272).w
loc_3F22E:                              ; CODE XREF: Boss_GustheadMain+5E   j
                                        ; Boss_GustheadMain+66   j ...
                jsr (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5C(a5)
loc_3F240:                              ; CODE XREF: Boss_GustheadMain+4   j
                move.w  4(a5),d0
                lea     off_3F24C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadMain
; ---------------------------------------------------------------------------
off_3F24C:      dc.w Boss_GustheadInitBattle-*        ; DATA XREF: Boss_GustheadMain+A0   o
                dc.w Boss_GustheadSetupParts-*
                dc.w Boss_GustheadStartIntro-*
                dc.w Boss_GustheadIntroFlicker-*
                dc.w Boss_GustheadIntroReveal-*
                dc.w Boss_GustheadBattleStart-*
                dc.w Boss_GustheadDefeatSequence-*
                dc.w Boss_GustheadTentacleMain-*
                dc.w Boss_GustheadTentacleUpdate-*
                dc.w Boss_GustheadTentacleDamage-*
                dc.w Boss_GustheadTentacleDamage_RetractLoop-*
                dc.w Boss_GustheadTentacleDefeat-*
                dc.w Boss_GustheadDefeatPhase1-*
                dc.w Boss_GustheadDefeatPhase2-*
                dc.w Boss_GustheadDefeatPhase3-*
                dc.w Boss_GustheadDefeatPhase4-*
                dc.w Boss_GustheadInitBounceMovement-*
                dc.w Boss_GustheadInitBounceMovement_UpdateLoop-*
                dc.w Boss_GustheadBounceAttackLogic-*
                dc.w Boss_GustheadInitFallMovement-*
                dc.w Boss_GustheadFallBounceLogic-*
                dc.w Boss_GustheadInitDefeatBounce-*
                dc.w Boss_GustheadInitDefeatBounce_RiseLoop-*
                dc.w Boss_GustheadAttackSequence1-*
                dc.w Boss_GustheadRepositionAttack-*
                dc.w Boss_GustheadScrollUp-*
                dc.w Boss_GustheadFlipSprite-*
                dc.w Boss_GustheadReturnToIdle-*
                dc.w Boss_GustheadDefeatStart-*
                dc.w Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w Boss_GustheadDefeatStart_UpdateLoop-*
                dc.w Boss_GustheadRiseAttack-*
                dc.w Boss_GustheadRiseAttack_UpdateLoop-*
                dc.w Boss_GustheadAttackSequence2-*
                dc.w Boss_GustheadMoveToPosition-*
                dc.w Boss_GustheadScrollDown-*
                dc.w Boss_GustheadFlipSprite2-*
                dc.w Boss_GustheadPrepareDefeat-*
                dc.w Boss_GustheadDefeatScrollReset-*
                dc.w Boss_GustheadDefeat_ResetPhysics-*
                dc.w Boss_GustheadDefeatScrollReset_TentacleLoop-*
                dc.w Boss_GustheadDefeatSink-*
                dc.w Boss_GustheadDefeatWaitCamera-*
                dc.w Boss_GustheadRotateAttack-*
                dc.w Boss_GustheadRotateWait-*
                dc.w Boss_GustheadDefeatInitPhase-*
                dc.w Boss_GustheadDefeatSlowScroll-*
                dc.w Boss_GustheadDefeatFall-*
                dc.w Boss_GustheadDefeatStopScroll-*
                dc.w Boss_GustheadDefeatCheck-*
                dc.w Boss_GustheadDefeatExit-*
                dc.w Boss_GustheadDefeatWait-*
                dc.w Boss_GustheadDefeatFinalize-*


; Initializes Gusthead battle
Boss_GustheadInitBattle:                              ; DATA XREF: ROM:off_3F24C   o  ; was: sub_3F2B8
                tst.w   (word_FFF720).w
                bmi.w   locret_4076C
                addq.w  #2,4(a5)
                move.w  #$1B0,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; End of function Boss_GustheadInitBattle
; Sets up boss parts and tentacles
Boss_GustheadSetupParts:                              ; DATA XREF: ROM:0003F24E   o  ; was: sub_3F2D0
                addq.w  #2,4(a5)
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
                move.b  #4,(byte_FFA420).w
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                move.b  #$40,$20(a5) ; '@'
                move.w  #$4C00,2(a5)
                move.b  #$10,$21(a5)
                move.b  #$88,$23(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$16,$24(a5)
                move.w  #$50,$26(a5) ; 'P'
                move.w  #$300,$E(a5)
                move.l  #word_EBFF8,8(a5)
                move.w  #3,d7
                movea.w a5,a0
                lea     $60(a0),a0
                clr.b   d5
loc_3F35C:                              ; CODE XREF: Boss_GustheadSetupParts+DA   j
                move.w  #3,d6
                clr.b   d0
loc_3F362:                              ; CODE XREF: Boss_GustheadSetupParts+D2   j
                move.w  #$1BC,(a0)
                move.w  #$4C00,2(a0)
                move.w  #$B00,$E(a0)
                move.l  #word_EC022,8(a0)
                tst.b   d0
                bne.s   loc_3F386
                move.w  #$28,$48(a0) ; '('
                bra.s   loc_3F38C
; ---------------------------------------------------------------------------
loc_3F386:                              ; CODE XREF: Boss_GustheadSetupParts+AC   j
                move.w  #$18,$48(a0)
loc_3F38C:                              ; CODE XREF: Boss_GustheadSetupParts+B4   j
                move.w  #$80,d1
                add.w   d1,$48(a0)
                move.b  d5,$4B(a0)
                move.b  d0,$4A(a0)
                lea     $60(a0),a0
                addq.b  #1,d0
                dbf     d6,loc_3F362
                addi.b  #$40,d5 ; '@'
                dbf     d7,loc_3F35C
                move.w  #$10,(a0)
                move.w  #$6100,2(a0)
                move.l  #off_E9680,8(a0)
                move.w  #$480,$E(a0)
                rts
; End of function Boss_GustheadSetupParts
; Starts boss intro sequence
Boss_GustheadStartIntro:                              ; DATA XREF: ROM:0003F250   o  ; was: sub_3F3C8
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                rts
; End of function Boss_GustheadStartIntro
; Intro flicker animation
Boss_GustheadIntroFlicker:                              ; DATA XREF: ROM:0003F252   o  ; was: sub_3F3D4
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3F3E4
                eori.w  #$8000,2(a5)
loc_3F3E4:                              ; CODE XREF: Boss_GustheadIntroFlicker+8   j
                subq.w  #1,$48(a5)
                bne.s   locret_3F3F4
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
locret_3F3F4:                           ; CODE XREF: Boss_GustheadIntroFlicker+14   j
                rts
; End of function Boss_GustheadIntroFlicker
; Reveals boss with tentacle setup
Boss_GustheadIntroReveal:                              ; DATA XREF: ROM:0003F254   o  ; was: sub_3F3F6
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                bne.s   loc_3F406
                eori.w  #$8000,2(a5)
loc_3F406:                              ; CODE XREF: Boss_GustheadIntroReveal+8   j
                subq.w  #1,$48(a5)
                bne.s   locret_3F44A
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #$10,(dword_FF940C).w
                move.w  #$40,(dword_FF9400).w ; '@'
                move.w  #$80,(dword_FF9404).w
                move.w  #$180,(dword_FF9408).w
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateBounce
locret_3F44A:                           ; CODE XREF: Boss_GustheadIntroReveal+14   j
                rts
; End of function Boss_GustheadIntroReveal
; Starts active battle phase
Boss_GustheadBattleStart:                              ; DATA XREF: ROM:0003F256   o  ; was: sub_3F44C
                move.w  #3,d7
                movea.w a5,a0
                lea     $60(a0),a0
loc_3F456:                              ; CODE XREF: Boss_GustheadBattleStart+1C   j
                move.w  #3,d6
loc_3F45A:                              ; CODE XREF: Boss_GustheadBattleStart+18   j
                subi.w  #2,$48(a0)
                lea     $60(a0),a0
                dbf     d6,loc_3F45A
                dbf     d7,loc_3F456
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3F488
                addq.w  #2,4(a5)
locret_3F488:                           ; CODE XREF: Boss_GustheadBattleStart+36   j
                rts
; End of function Boss_GustheadBattleStart
; Boss defeat animation sequence
Boss_GustheadDefeatSequence:                              ; DATA XREF: ROM:0003F258   o  ; was: sub_3F48A
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subi.l  #$2000,(dword_FF940C).w
                bne.s   locret_3F4C0
                ori.w   #$8000,2(a5)
                move.b  #$50,$21(a5) ; 'P'
                addq.w  #2,4(a5)
                move.w  #3,d0
                jsr (UI_CheckVictoryCondition).l
locret_3F4C0:                           ; CODE XREF: Boss_GustheadDefeatSequence+1A   j
                rts
; End of function Boss_GustheadDefeatSequence
; Main handler for tentacle part
Boss_GustheadTentacleMain:                              ; DATA XREF: ROM:0003F25A   o  ; was: sub_3F4C2
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateBounce
                tst.w   (word_FF80C2).w
                bne.s   locret_3F4E8
                clr.b   (byte_FF80EC).w
                ori.w   #$100,2(a5)
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
locret_3F4E8:                           ; CODE XREF: Boss_GustheadTentacleMain+10   j
                rts
; End of function Boss_GustheadTentacleMain
; Updates single tentacle position
Boss_GustheadTentacleUpdate:                              ; DATA XREF: ROM:0003F25C   o  ; was: sub_3F4EA
                cmpi.w  #$3200,(word_FF8200).w
                bcs.s Boss_GustheadTentacleExtendStart
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                tst.w   d0
                beq.s   loc_3F50A
                cmpi.w  #1,d0
                beq.s   loc_3F51A
                cmpi.w  #2,d0
                beq.s   loc_3F52A
loc_3F50A:                              ; CODE XREF: Boss_GustheadTentacleUpdate+12   j
                move.w  #1,$5A(a5)
                move.w  #$12,4(a5)
                bra.w Boss_GustheadTentacleDamage
; ---------------------------------------------------------------------------
loc_3F51A:                              ; CODE XREF: Boss_GustheadTentacleUpdate+18   j
                move.w  #3,$5A(a5)
                move.w  #$20,4(a5) ; ' '
                bra.w Boss_GustheadInitBounceMovement
; ---------------------------------------------------------------------------
loc_3F52A:                              ; CODE XREF: Boss_GustheadTentacleUpdate+1E   j
                move.w  #2,$5A(a5)
                move.w  #$2A,4(a5) ; '*'
                bra.w Boss_GustheadInitDefeatBounce
; End of function Boss_GustheadTentacleUpdate
; Alternative tentacle retraction routine for Gusthead boss
Boss_GustheadTentacleRetractAlt:
                bset    #6,$4A(a5)  ; was: sub_3F53A
                move.w  #$38,4(a5) ; '8'
                bra.w Boss_GustheadDefeatStart
; End of function Boss_GustheadTentacleRetractAlt
; Initializes tentacle extension state for Gusthead boss
Boss_GustheadTentacleExtendStart:                              ; CODE XREF: Boss_GustheadTentacleUpdate+6   j  ; was: sub_3F54A
                bset    #6,$4A(a5)
                move.w  #1,(word_FFA968).w
                clr.l   (dword_FFA960).w
                move.w  #$40,4(a5) ; '@'
                bra.w Boss_GustheadRiseAttack
; End of function Boss_GustheadTentacleExtendStart
; Handles tentacle damage
Boss_GustheadTentacleDamage:                              ; CODE XREF: Boss_GustheadTentacleUpdate+2C   j  ; was: sub_3F564
                                        ; DATA XREF: ROM:0003F25E   o
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #$F0,$52(a5)
; Update tentacles during retract phase after damage
Boss_GustheadTentacleDamage_RetractLoop:                              ; DATA XREF: ROM:0003F260   o  ; was: loc_3F5A2
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadTentacleRetract
                subi.w  #8,(dword_FF9404).w
                andi.w  #$1F8,(dword_FF9404).w
                bne.w   locret_4076C
                addq.w  #2,4(a5)
                move.l  #$FFFE0000,(dword_FF9410).w
                move.l  #$1000,(dword_FF941C).w
                cmpi.w  #$120,(dword_FFA410).w
                bcc.s   loc_3F5E4
                move.l  #$FFFFF000,(dword_FF9418).w
                bra.s   locret_3F5EC
; ---------------------------------------------------------------------------
loc_3F5E4:                              ; CODE XREF: Boss_GustheadTentacleDamage+74   j
                move.l  #$1000,(dword_FF9418).w
locret_3F5EC:                           ; CODE XREF: Boss_GustheadTentacleDamage+7E   j
                rts
; End of function Boss_GustheadTentacleDamage
; Tentacle defeat sequence
Boss_GustheadTentacleDefeat:                              ; DATA XREF: ROM:0003F262   o  ; was: sub_3F5EE
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadCoreMain
                bsr.s Boss_GustheadTentacleRetract
                move.l  (dword_FF9418).w,d0
                add.l   d0,(dword_FF940C).w
                cmpi.l  #$C0000,(dword_FF940C).w
                beq.s   loc_3F620
                cmpi.l  #$FFF40000,(dword_FF940C).w
                bne.s   locret_3F62A
loc_3F620:                              ; CODE XREF: Boss_GustheadTentacleDefeat+26   j
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_3F62A:                           ; CODE XREF: Boss_GustheadTentacleDefeat+30   j
                rts
; End of function Boss_GustheadTentacleDefeat
; Retracts defeated tentacle
Boss_GustheadTentacleRetract:                              ; CODE XREF: Boss_GustheadTentacleDamage+46   p  ; was: sub_3F62C
                                        ; Boss_GustheadTentacleDefeat+14   p ...
                move.w  $10(a5),d0
                sub.w   (dword_FFA410).w,d0
                bpl.s   loc_3F638
                neg.w   d0
loc_3F638:                              ; CODE XREF: Boss_GustheadTentacleRetract+8   j
                cmpi.w  #$10,d0
                bhi.s   loc_3F644
                clr.w   $50(a5)
                bra.s   loc_3F65A
; ---------------------------------------------------------------------------
loc_3F644:                              ; CODE XREF: Boss_GustheadTentacleRetract+10   j
                cmpi.w  #$120,(dword_FFA410).w
                bcc.s   loc_3F654
                move.w  #$160,$50(a5)
                bra.s   loc_3F65A
; ---------------------------------------------------------------------------
loc_3F654:                              ; CODE XREF: Boss_GustheadTentacleRetract+1E   j
                move.w  #$E0,$50(a5)
loc_3F65A:                              ; CODE XREF: Boss_GustheadTentacleRetract+16   j
                                        ; Boss_GustheadTentacleRetract+26   j
                tst.w   $50(a5)
                beq.s   loc_3F686
                move.w  $50(a5),d0
                sub.w   $10(a5),d0
                bne.s   loc_3F670
                clr.w   $50(a5)
                bra.s   loc_3F686
; ---------------------------------------------------------------------------
loc_3F670:                              ; CODE XREF: Boss_GustheadTentacleRetract+3C   j
                tst.w   d0
                bmi.s   loc_3F67E
                addi.l  #$8000,$10(a5)
                bra.s   loc_3F686
; ---------------------------------------------------------------------------
loc_3F67E:                              ; CODE XREF: Boss_GustheadTentacleRetract+46   j
                subi.l  #$8000,$10(a5)
loc_3F686:                              ; CODE XREF: Boss_GustheadTentacleRetract+32   j
                                        ; Boss_GustheadTentacleRetract+42   j ...
                tst.w   $52(a5)
                beq.s Boss_GustheadUpdateBounce
                move.w  $52(a5),d0
                sub.w   $14(a5),d0
                bne.s   loc_3F69C
                clr.w   $52(a5)
                bra.s Boss_GustheadUpdateBounce
; ---------------------------------------------------------------------------
loc_3F69C:                              ; CODE XREF: Boss_GustheadTentacleRetract+68   j
                tst.w   d0
                bmi.s   loc_3F6A8
                addi.w  #1,$14(a5)
                bra.s Boss_GustheadUpdateBounce
; ---------------------------------------------------------------------------
loc_3F6A8:                              ; CODE XREF: Boss_GustheadTentacleRetract+72   j
                subi.w  #1,$14(a5)
; End of function Boss_GustheadTentacleRetract
; Updates boss vertical bounce
Boss_GustheadUpdateBounce:                              ; CODE XREF: Boss_GustheadIntroReveal+50   p  ; was: sub_3F6AE
                                        ; Boss_GustheadBattleStart+28   p ...
                tst.l   $4C(a5)
                beq.s   locret_3F6D0
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                bpl.s   loc_3F6C4
                neg.l   d0
loc_3F6C4:                              ; CODE XREF: Boss_GustheadUpdateBounce+12   j
                cmpi.l  #$10000,d0
                bne.s   locret_3F6D0
                neg.l   $4C(a5)
locret_3F6D0:                           ; CODE XREF: Boss_GustheadUpdateBounce+4   j
                                        ; Boss_GustheadUpdateBounce+1C   j
                rts
; End of function Boss_GustheadUpdateBounce
; Main handler for boss core
Boss_GustheadCoreMain:                              ; CODE XREF: Boss_GustheadTentacleDefeat+10   p  ; was: sub_3F6D2
                                        ; Boss_GustheadDefeatPhase1+10   p ...
                move.l  (dword_FF941C).w,d0
                add.l   d0,(dword_FF9410).w
                move.l  (dword_FF9410).w,d0
                bpl.s   loc_3F6E2
                neg.l   d0
loc_3F6E2:                              ; CODE XREF: Boss_GustheadCoreMain+C   j
                cmpi.l  #$20000,d0
                bne.s   locret_3F6EE
                neg.l   (dword_FF941C).w
locret_3F6EE:                           ; CODE XREF: Boss_GustheadCoreMain+16   j
                rts
; End of function Boss_GustheadCoreMain
; Defeat phase 1 with tentacles
Boss_GustheadDefeatPhase1:                              ; DATA XREF: ROM:0003F264   o  ; was: sub_3F6F0
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadCoreMain
                bsr.w Boss_GustheadTentacleRetract
                bsr.w Boss_GustheadSpawnDebris
                tst.w   (dword_FF9404).w
                bne.s   locret_3F716
                addq.w  #2,4(a5)
locret_3F716:                           ; CODE XREF: Boss_GustheadDefeatPhase1+20   j
                rts
; End of function Boss_GustheadDefeatPhase1
; Defeat phase 2 delay loop
Boss_GustheadDefeatPhase2:                              ; DATA XREF: ROM:0003F266   o  ; was: sub_3F718
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadCoreMain
                bsr.w Boss_GustheadTentacleRetract
                tst.w   (dword_FF9404).w
                beq.s   locret_3F740
                subq.w  #1,$48(a5)
                beq.s   loc_3F742
                subq.w  #2,4(a5)
locret_3F740:                           ; CODE XREF: Boss_GustheadDefeatPhase2+1C   j
                rts
; ---------------------------------------------------------------------------
loc_3F742:                              ; CODE XREF: Boss_GustheadDefeatPhase2+22   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatPhase2
; Handles Gusthead boss defeat phase 3 with tentacle updates
Boss_GustheadDefeatPhase3:                              ; DATA XREF: ROM:0003F268   o  ; was: sub_3F748
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadCoreMain
                bsr.w Boss_GustheadTentacleRetract
                move.l  (dword_FF9418).w,d0
                sub.l   d0,(dword_FF940C).w
                bne.s   locret_3F77C
                addq.w  #2,4(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                beq.s   locret_3F77C
                neg.l   (dword_FF9418).w
locret_3F77C:                           ; CODE XREF: Boss_GustheadDefeatPhase3+20   j
                                        ; Boss_GustheadDefeatPhase3+2E   j
                rts
; End of function Boss_GustheadDefeatPhase3
; Handles Gusthead boss defeat phase 4 final state
Boss_GustheadDefeatPhase4:                              ; DATA XREF: ROM:0003F26A   o  ; was: sub_3F77E
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadTentacleRetract
                move.w  #$10,4(a5)
                rts
; End of function Boss_GustheadDefeatPhase4
; Initializes bouncing movement parameters for Gusthead boss
Boss_GustheadInitBounceMovement:                              ; CODE XREF: Boss_GustheadTentacleUpdate+3C   j  ; was: sub_3F79A
                                        ; DATA XREF: ROM:0003F26C   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF8240).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.l  #$80000,(dword_FF940C).w
                move.l  #$80000,(dword_FF9410).w
                move.l  #$80000,(dword_FF9414).w
                addq.w  #2,4(a5)
; Update tentacles and scroll during bounce initialization
Boss_GustheadInitBounceMovement_UpdateLoop:                              ; DATA XREF: ROM:0003F26E   o  ; was: loc_3F7E2
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                cmpi.w  #$40,(dword_FF9400).w ; '@'
                bne.s   loc_3F802
                clr.l   (dword_FF940C).w
loc_3F802:                              ; CODE XREF: Boss_GustheadInitBounceMovement+62   j
                cmpi.w  #0,(dword_FF9404).w
                bne.s   loc_3F80E
                clr.l   (dword_FF9410).w
loc_3F80E:                              ; CODE XREF: Boss_GustheadInitBounceMovement+6E   j
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_3F852
                clr.l   (dword_FF9414).w
                tst.l   (dword_FF9410).w
                bne.s   locret_3F852
                tst.l   (dword_FF940C).w
                bne.s   locret_3F852
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.l   $4C(a5)
                move.l  #0,(dword_FF940C).w
                move.l  #$100000,(dword_FF9410).w
                move.l  #$40000,(dword_FF9414).w
                clr.w   $56(a5)
                bsr.w Boss_GustheadUpdateTargetAngle
locret_3F852:                           ; CODE XREF: Boss_GustheadInitBounceMovement+7A   j
                                        ; Boss_GustheadInitBounceMovement+84   j ...
                rts
; End of function Boss_GustheadInitBounceMovement
; Main logic for Gusthead boss bouncing attack pattern
Boss_GustheadBounceAttackLogic:                              ; DATA XREF: ROM:0003F270   o  ; was: sub_3F854
                ori.b   #3,$4B(a5)
                bsr.w Boss_GustheadCalculateVelocity
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                cmpi.w  #$100,(dword_FF9408).w
                bne.s   loc_3F886
                cmpi.w  #$120,$14(a5)
                blt.s   loc_3F886
                bsr.w Boss_GustheadSpawnDebris4Way
                bsr.w Boss_GustheadFireRadialProjectiles
loc_3F886:                              ; CODE XREF: Boss_GustheadBounceAttackLogic+20   j
                                        ; Boss_GustheadBounceAttackLogic+28   j
                move.w  $54(a5),d0
                cmp.w   (dword_FF9408).w,d0
                bne.s   locret_3F896
                neg.l   (dword_FF9414).w
                bsr.s Boss_GustheadUpdateTargetAngle
locret_3F896:                           ; CODE XREF: Boss_GustheadBounceAttackLogic+3A   j
                rts
; End of function Boss_GustheadBounceAttackLogic
; Updates target angle sequence for Gusthead boss movement
Boss_GustheadUpdateTargetAngle:                              ; CODE XREF: Boss_GustheadInitBounceMovement+B4   p  ; was: sub_3F898
                                        ; Boss_GustheadBounceAttackLogic+40   p
                move.w  $56(a5),d0
                move.w  word_3F8B4(pc,d0.w),$54(a5)
                addq.w  #2,$56(a5)
                cmpi.w  #6,$56(a5)
                bls.s   locret_3F8B2
                addq.w  #2,4(a5)
locret_3F8B2:                           ; CODE XREF: Boss_GustheadUpdateTargetAngle+14   j
                rts
; End of function Boss_GustheadUpdateTargetAngle
; ---------------------------------------------------------------------------
word_3F8B4:     dc.w $180, $80, $80, $180
                                        ; DATA XREF: Boss_GustheadUpdateTargetAngle+4   r


; Fires radial projectile pattern from Gusthead boss
Boss_GustheadFireRadialProjectiles:                              ; CODE XREF: Boss_GustheadBounceAttackLogic+2E   p  ; was: sub_3F8BC
                move.w  #3,d7
                move.w  #$150,d6
loc_3F8C4:                              ; CODE XREF: Boss_GustheadFireRadialProjectiles+66   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3F930
                move.w  #$10,(a0)
                jsr (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$10,$14(a0)
                move.l  #off_1A0E96,8(a0)
                move.w  #$4000,$E(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                lea     (word_1B514).l,a1
                move.w  (a1,d6.w),d0
                move.w  -$80(a1,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #4,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                addi.w  #$20,d6 ; ' '
                dbf     d7,loc_3F8C4
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
locret_3F930:                           ; CODE XREF: Boss_GustheadFireRadialProjectiles+E   j
                rts
; End of function Boss_GustheadFireRadialProjectiles
; Retrieves first tentacle angle value for Gusthead boss
Boss_GustheadGetTentacleAngle1:
                move.w  (dword_FF9400).w,d0  ; was: sub_3F932
                bra.s   loc_3F942
; End of function Boss_GustheadGetTentacleAngle1
; Retrieves second tentacle angle value for Gusthead boss
Boss_GustheadGetTentacleAngle2:
                move.w  (dword_FF9404).w,d0  ; was: sub_3F938
                bra.s   loc_3F942
; End of function Boss_GustheadGetTentacleAngle2
; Calculates velocity components from angle for Gusthead boss
Boss_GustheadCalculateVelocity:                              ; CODE XREF: Boss_GustheadBounceAttackLogic+6   p  ; was: sub_3F93E
                move.w  (dword_FF9408).w,d0
loc_3F942:                              ; CODE XREF: Boss_GustheadGetTentacleAngle1+4   j
                                        ; Boss_GustheadGetTentacleAngle2+4   j
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a1
                moveq   #0,d1
                btst    #0,$4B(a5)
                beq.s   loc_3F95E
                move.w  (a1,d0.w),d1
                ext.l   d1
                add.l   d1,d1
loc_3F95E:                              ; CODE XREF: Boss_GustheadCalculateVelocity+16   j
                moveq   #0,d2
                btst    #1,$4B(a5)
                beq.s   loc_3F970
                move.w  -$80(a1,d0.w),d2
                ext.l   d2
                asl.l   #4,d2
loc_3F970:                              ; CODE XREF: Boss_GustheadCalculateVelocity+28   j
                move.l  d1,$18(a5)
                move.l  d2,$1C(a5)
                rts
; End of function Boss_GustheadCalculateVelocity
; Initializes falling movement parameters for Gusthead boss
Boss_GustheadInitFallMovement:                              ; DATA XREF: ROM:0003F272   o  ; was: sub_3F97A
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                cmpi.w  #$F0,$14(a5)
                bcs.s   locret_3F9DC
                move.l  #$F00000,$14(a5)
                clr.l   $18(a5)
                move.l  #$10000,$1C(a5)
                move.l  #$FFFFE000,$4C(a5)
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #8,(dword_FF940C).w
                move.w  #8,(dword_FF9410).w
                move.w  #8,(dword_FF9414).w
                addq.w  #2,4(a5)
locret_3F9DC:                           ; CODE XREF: Boss_GustheadInitFallMovement+16   j
                rts
; End of function Boss_GustheadInitFallMovement
; Handles Gusthead boss falling and bouncing behavior
Boss_GustheadFallBounceLogic:                              ; DATA XREF: ROM:0003F274   o  ; was: sub_3F9DE
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                cmpi.w  #$40,(dword_FF9400).w ; '@'
                bne.s   loc_3F9FE
                clr.l   (dword_FF940C).w
loc_3F9FE:                              ; CODE XREF: Boss_GustheadFallBounceLogic+1A   j
                cmpi.w  #$80,(dword_FF9404).w
                bne.s   loc_3FA0A
                clr.l   (dword_FF9410).w
loc_3FA0A:                              ; CODE XREF: Boss_GustheadFallBounceLogic+26   j
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_3FA28
                clr.w   (dword_FF9414).w
                tst.l   (dword_FF940C).w
                bne.s   locret_3FA28
                tst.l   (dword_FF9410).w
                bne.s   locret_3FA28
                move.w  #$10,4(a5)
locret_3FA28:                           ; CODE XREF: Boss_GustheadFallBounceLogic+32   j
                                        ; Boss_GustheadFallBounceLogic+3C   j ...
                rts
; End of function Boss_GustheadFallBounceLogic
; Initializes defeat bounce sequence for Gusthead boss
Boss_GustheadInitDefeatBounce:                              ; CODE XREF: Boss_GustheadTentacleUpdate+4C   j  ; was: sub_3FA2A
                                        ; DATA XREF: ROM:0003F276   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Execute rising bounce movement during defeat sequence
Boss_GustheadInitDefeatBounce_RiseLoop:                              ; DATA XREF: ROM:0003F278   o  ; was: loc_3FA42
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                addi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$100000,(dword_FF940C).w
                bne.s   locret_3FA7A
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                bra.s Boss_JetsripperFireProjectile
; ---------------------------------------------------------------------------
locret_3FA7A:                           ; CODE XREF: Boss_GustheadInitDefeatBounce+42   j
                rts
; End of function Boss_GustheadInitDefeatBounce
; Fires projectile from Jetstripper boss based on position relative to player
Boss_JetsripperFireProjectile:                              ; CODE XREF: Boss_GustheadInitDefeatBounce+4E   j  ; was: sub_3FA7C
                                        ; Boss_GustheadRiseAttack+4E   p
                tst.w   (word_FFFF0E).w
                beq.s   locret_3FAB0
                move.w  #2,d3
                move.w  $674(a5),d6
                move.w  $10(a5),d0
                sub.w   (word_FF8248).w,d0
                bmi.s   loc_3FAA2
                move.w  #$10,d4
                move.w  $670(a5),d5
                subi.w  #$34,d5 ; '4'
                bra.s   loc_3FAAA
; ---------------------------------------------------------------------------
loc_3FAA2:                              ; CODE XREF: Boss_JetsripperFireProjectile+16   j
                move.w  #0,d4
                move.w  $670(a5),d5
loc_3FAAA:                              ; CODE XREF: Boss_JetsripperFireProjectile+24   j
                jsr (Boss_JetsripperSpawnDirectionalProjectile).l
locret_3FAB0:                           ; CODE XREF: Boss_JetsripperFireProjectile+4   j
                rts
; End of function Boss_JetsripperFireProjectile
; Gusthead boss attack state: updates tentacles/bounce, flips sprite, advances to next state
Boss_GustheadAttackSequence1:                              ; DATA XREF: ROM:0003F27A   o  ; was: sub_3FAB2
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FAD6
                eori.w  #$8000,2(a5)
loc_3FAD6:                              ; CODE XREF: Boss_GustheadAttackSequence1+1C   j
                subq.w  #1,$48(a5)
                bne.s   locret_3FAEC
                move.w  #$20,$48(a5) ; ' '
                move.w  #$200,$14(a5)
                addq.w  #2,4(a5)
locret_3FAEC:                           ; CODE XREF: Boss_GustheadAttackSequence1+28   j
                rts
; End of function Boss_GustheadAttackSequence1
; Gusthead boss repositions horizontally based on player position before next attack
Boss_GustheadRepositionAttack:                              ; DATA XREF: ROM:0003F27C   o  ; was: sub_3FAEE
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FB2C
                addq.w  #2,4(a5)
                move.w  #$1190,d0
                move.w  (dword_FFFF08).w,d1
                andi.w  #$FF,d1
                subi.w  #$80,d1
                add.w   d1,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$F0,$14(a5)
locret_3FB2C:                           ; CODE XREF: Boss_GustheadRepositionAttack+18   j
                rts
; End of function Boss_GustheadRepositionAttack
; Gusthead boss scrolls camera upward while flipping sprite until scroll limit reached
Boss_GustheadScrollUp:                              ; DATA XREF: ROM:0003F27E   o  ; was: sub_3FB2E
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FB52
                eori.w  #$8000,2(a5)
loc_3FB52:                              ; CODE XREF: Boss_GustheadScrollUp+1C   j
                subi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$80000,(dword_FF940C).w
                bne.s   locret_3FB6E
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_3FB6E:                           ; CODE XREF: Boss_GustheadScrollUp+34   j
                rts
; End of function Boss_GustheadScrollUp
; Gusthead boss rapidly flips sprite horizontally for visual effect
Boss_GustheadFlipSprite:                              ; DATA XREF: ROM:0003F280   o  ; was: sub_3FB70
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3FBA0
                ori.w   #$8000,2(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_3FBA0:                           ; CODE XREF: Boss_GustheadFlipSprite+1E   j
                rts
; End of function Boss_GustheadFlipSprite
; Gusthead boss returns to idle state after attack sequence completes
Boss_GustheadReturnToIdle:                              ; DATA XREF: ROM:0003F282   o  ; was: sub_3FBA2
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FBC8
                move.b  #$50,$21(a5) ; 'P'
                move.w  #$10,4(a5)
locret_3FBC8:                           ; CODE XREF: Boss_GustheadReturnToIdle+18   j
                rts
; End of function Boss_GustheadReturnToIdle
; Gusthead boss defeat sequence start: reduces scroll velocities and begins death animation
Boss_GustheadDefeatStart:                              ; CODE XREF: Boss_GustheadTentacleRetractAlt+C   j  ; was: sub_3FBCA
                                        ; DATA XREF: ROM:0003F284   o
                move.l  (dword_FF940C).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF940C).w
                move.l  (dword_FF9410).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF9410).w
                move.l  (dword_FF9414).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF9414).w
                addq.w  #2,4(a5)
; Update tentacles and check for defeat state transition
Boss_GustheadDefeatStart_UpdateLoop:                              ; DATA XREF: ROM:0003F286   o  ; was: loc_3FBEC
                                        ; ROM:0003F288   o ...
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                addq.w  #2,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.s   locret_3FC18
                bclr    #6,$4A(a5)
                move.w  #$10,4(a5)
locret_3FC18:                           ; CODE XREF: Boss_GustheadDefeatStart+40   j
                rts
; End of function Boss_GustheadDefeatStart
; Gusthead boss rises upward while flipping sprite and fires projectile at peak
Boss_GustheadRiseAttack:                              ; CODE XREF: Boss_GustheadTentacleExtendStart+16   j  ; was: sub_3FC1A
                                        ; DATA XREF: ROM:0003F28C   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Execute rising attack pattern with bounce and projectile
Boss_GustheadRiseAttack_UpdateLoop:                              ; DATA XREF: ROM:0003F28E   o  ; was: loc_3FC32
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                addi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$100000,(dword_FF940C).w
                bne.s   locret_3FC6C
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                jsr Boss_JetsripperFireProjectile(pc)   ; (pc)
locret_3FC6C:                           ; CODE XREF: Boss_GustheadRiseAttack+42   j
                rts
; End of function Boss_GustheadRiseAttack
; Gusthead boss attack state: flips sprite, waits for timer, advances to next state
Boss_GustheadAttackSequence2:                              ; DATA XREF: ROM:0003F290   o  ; was: sub_3FC6E
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FC92
                eori.w  #$8000,2(a5)
loc_3FC92:                              ; CODE XREF: Boss_GustheadAttackSequence2+1C   j
                subq.w  #1,$48(a5)
                bne.s   locret_3FCA8
                move.w  #$80,$48(a5)
                move.w  #$200,$14(a5)
                addq.w  #2,4(a5)
locret_3FCA8:                           ; CODE XREF: Boss_GustheadAttackSequence2+28   j
                rts
; End of function Boss_GustheadAttackSequence2
; Gusthead boss moves to specific screen position and advances state
Boss_GustheadMoveToPosition:                              ; DATA XREF: ROM:0003F292   o  ; was: sub_3FCAA
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FCD4
                move.w  #$198,$10(a5)
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
locret_3FCD4:                           ; CODE XREF: Boss_GustheadMoveToPosition+18   j
                rts
; End of function Boss_GustheadMoveToPosition
; Gusthead boss scrolls camera downward while flipping sprite until scroll limit reached
Boss_GustheadScrollDown:                              ; DATA XREF: ROM:0003F294   o  ; was: sub_3FCD6
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FCFA
                eori.w  #$8000,2(a5)
loc_3FCFA:                              ; CODE XREF: Boss_GustheadScrollDown+1C   j
                subi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$80000,(dword_FF940C).w
                bne.s   locret_3FD16
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_3FD16:                           ; CODE XREF: Boss_GustheadScrollDown+34   j
                rts
; End of function Boss_GustheadScrollDown
; Gusthead boss rapidly flips sprite horizontally for visual effect variant
Boss_GustheadFlipSprite2:                              ; DATA XREF: ROM:0003F296   o  ; was: sub_3FD18
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3FD48
                ori.w   #$8000,2(a5)
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_3FD48:                           ; CODE XREF: Boss_GustheadFlipSprite2+1E   j
                rts
; End of function Boss_GustheadFlipSprite2
; Gusthead boss prepares for defeat sequence by setting health and animation values
Boss_GustheadPrepareDefeat:                              ; DATA XREF: ROM:0003F298   o  ; was: sub_3FD4A
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadUpdateScroll
                bsr.w Boss_GustheadCoreDefeat
                bsr.w Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FD74
                move.b  #$50,$21(a5) ; 'P'
                move.b  #$10,$23(a5)
                addq.w  #2,4(a5)
locret_3FD74:                           ; CODE XREF: Boss_GustheadPrepareDefeat+18   j
                rts
; End of function Boss_GustheadPrepareDefeat
; Gusthead boss defeat: resets scroll positions and camera values to initial state
Boss_GustheadDefeatScrollReset:                              ; DATA XREF: ROM:0003F29A   o  ; was: sub_3FD76
                move.w  #6,$5A(a5)
                move.w  #$50,4(a5) ; 'P'
                bra.w   *+4
; ---------------------------------------------------------------------------
; Resets velocity and scroll values for defeat sequence
Boss_GustheadDefeat_ResetPhysics:                              ; CODE XREF: Boss_GustheadDefeatScrollReset+C   j  ; was: loc_3FD86
                                        ; DATA XREF: ROM:0003F29C   o
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF8240).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #$F0,$14(a5)
                move.w  #$E,$24(a5)
; Retract tentacles while resetting scroll position
Boss_GustheadDefeatScrollReset_TentacleLoop:                              ; DATA XREF: ROM:0003F29E   o  ; was: loc_3FDCE
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w   loc_3F686
                subi.w  #8,(dword_FF9404).w
                andi.w  #$1F8,(dword_FF9404).w
                cmpi.w  #$1E0,(dword_FF9404).w
                bne.s   locret_3FDF2
                addq.w  #2,4(a5)
locret_3FDF2:                           ; CODE XREF: Boss_GustheadDefeatScrollReset+76   j
                rts
; End of function Boss_GustheadDefeatScrollReset
; Gusthead boss defeat: sinks downward while adjusting camera scroll and palette
Boss_GustheadDefeatSink:                              ; DATA XREF: ROM:0003F2A0   o  ; was: sub_3FDF4
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                cmpi.l  #$1D000,(dword_FFA960).w
                beq.s   loc_3FE16
                addi.l  #$200,(dword_FFA960).w
loc_3FE16:                              ; CODE XREF: Boss_GustheadDefeatSink+18   j
                move.b  #$88,$23(a5)
                subi.l  #$800,(dword_FF940C).w
                cmpi.l  #$FFF00000,(dword_FF940C).w
                bcs.s   locret_3FE3A
                move.l  #$FFF00000,(dword_FF940C).w
                addq.w  #2,4(a5)
locret_3FE3A:                           ; CODE XREF: Boss_GustheadDefeatSink+38   j
                rts
; End of function Boss_GustheadDefeatSink
; Gusthead boss defeat: waits for camera animation to complete before next state
Boss_GustheadDefeatWaitCamera:                              ; DATA XREF: ROM:0003F2A2   o  ; was: sub_3FE3C
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                cmpi.l  #$1D000,(dword_FFA960).w
                beq.s   loc_3FE60
                addi.l  #$200,(dword_FFA960).w
                rts
; ---------------------------------------------------------------------------
loc_3FE60:                              ; CODE XREF: Boss_GustheadDefeatWaitCamera+18   j
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatWaitCamera
; Gusthead boss rotates while firing projectiles based on camera rotation angle
Boss_GustheadRotateAttack:                              ; DATA XREF: ROM:0003F2A4   o  ; was: sub_3FE6C
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                move.w  (dword_FFA900).w,d1
                tst.w   (word_FFFF0E).w
                bne.s   loc_3FE8C
                addi.w  #$40,d1 ; '@'
                bra.s   loc_3FE90
; ---------------------------------------------------------------------------
loc_3FE8C:                              ; CODE XREF: Boss_GustheadRotateAttack+18   j
                subi.w  #$10,d1
loc_3FE90:                              ; CODE XREF: Boss_GustheadRotateAttack+1E   j
                move.w  d1,d0
                andi.w  #$7E,d0 ; '~'
                bne.s   locret_3FEAA
                addq.w  #2,4(a5)
                move.w  d1,d0
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                beq.s   locret_3FEAA
                bra.s   loc_3FEAC
; ---------------------------------------------------------------------------
locret_3FEAA:                           ; CODE XREF: Boss_GustheadRotateAttack+2A   j
                                        ; Boss_GustheadRotateAttack+3A   j
                rts
; ---------------------------------------------------------------------------
loc_3FEAC:                              ; CODE XREF: Boss_GustheadRotateAttack+3C   j
                move.w  #2,d3
                move.w  #$10,d4
                move.w  $670(a5),d5
                subi.w  #$34,d5 ; '4'
                move.w  $674(a5),d6
                jsr (Boss_JetsripperSpawnDirectionalProjectile).l
                andi.w  #$FEFF,2(a0)
                rts
; End of function Boss_GustheadRotateAttack
; Gusthead boss waits for rotation to reach specific angle before reversing state
Boss_GustheadRotateWait:                              ; DATA XREF: ROM:0003F2A6   o  ; was: sub_3FECE
                bsr.w Boss_GustheadUpdateTentacles
                bsr.w Boss_GustheadUpdateTentacleAngles
                bsr.w Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                andi.w  #$7E,d0 ; '~'
                beq.s   locret_3FEF0
                subq.w  #2,4(a5)
locret_3FEF0:                           ; CODE XREF: Boss_GustheadRotateWait+1C   j
                rts
; End of function Boss_GustheadRotateWait
; Initializes defeat phase
Boss_GustheadDefeatInitPhase:                              ; DATA XREF: ROM:0003F2A8   o  ; was: sub_3FEF2
                clr.b   $21(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatInitPhase
; Slows scroll during defeat
Boss_GustheadDefeatSlowScroll:                              ; DATA XREF: ROM:0003F2AA   o  ; was: sub_3FF00
                bsr.w Boss_SpawnExplosionDebris
                cmpi.l  #$E800,(dword_FFA960).w
                bmi.s   loc_3FF18
                subi.l  #$200,(dword_FFA960).w
                rts
; ---------------------------------------------------------------------------
loc_3FF18:                              ; CODE XREF: Boss_GustheadDefeatSlowScroll+C   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatSlowScroll
; Boss falling defeat animation
Boss_GustheadDefeatFall:                              ; DATA XREF: ROM:0003F2AC   o  ; was: sub_3FF1E
                addi.l  #$1000,$1C(a5)
                bsr.w Boss_SpawnExplosionDebris
                eori.w  #$8000,2(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_3FF44
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.w   $48(a5)
locret_3FF44:                           ; CODE XREF: Boss_GustheadDefeatFall+18   j
                rts
; End of function Boss_GustheadDefeatFall
; Spawns debris during boss explosion
Boss_SpawnExplosionDebris:                              ; CODE XREF: Boss_JetsripperDeathExplosion+12   p  ; was: sub_3FF46
                                        ; sub_3FF00   p ...
                jsr (Gfx_UpdatePaletteFade).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                jsr (Effect_PlayRandomExplosionSound).l
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_3FFC2
                jsr (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  #$FFFA,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0 ; '?'
                andi.w  #$1F,d1
                subi.w  #$24,d0 ; '$'
                subi.w  #$24,d1 ; '$'
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_3FFC4(pc,d0.w),8(a0)
locret_3FFC2:                           ; CODE XREF: Boss_SpawnExplosionDebris+1E   j
                rts
; End of function Boss_SpawnExplosionDebris
; ---------------------------------------------------------------------------
off_3FFC4:      dc.l off_E953C          ; DATA XREF: Boss_SpawnExplosionDebris+76   r
                dc.l off_E95A4
                dc.l off_E9560
                dc.l off_E95C0
                dc.l off_E9584
                dc.l off_E95DC
                dc.l off_E9584
                dc.l off_E9604


; Stops scroll for defeat
Boss_GustheadDefeatStopScroll:                              ; DATA XREF: ROM:0003F2AE   o  ; was: sub_3FFE4
                bsr.s Gfx_ApplyBossPaletteFade
                addq.w  #1,(dword_FF9424).w
                cmpi.w  #$F,(dword_FF9424).w
                bne.s   locret_3FFFC
                move.w  #4,(dword_FF9424+2).w
                addq.w  #2,4(a5)
locret_3FFFC:                           ; CODE XREF: Boss_GustheadDefeatStopScroll+C   j
                rts
; End of function Boss_GustheadDefeatStopScroll
; Applies palette fade effect to boss using specific fade parameters
Gfx_ApplyBossPaletteFade:                              ; CODE XREF: Boss_GustheadDefeatStopScroll   p  ; was: sub_3FFFE
                                        ; sub_40018   p ...
                move.w  (dword_FF9424).w,d0
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyBossPaletteFade
; Checks if defeat sequence complete
Boss_GustheadDefeatCheck:                              ; DATA XREF: ROM:0003F2B0   o  ; was: sub_40018
                bsr.s Gfx_ApplyBossPaletteFade
                subq.w  #1,(dword_FF9424+2).w
                bne.s   locret_40024
                addq.w  #2,4(a5)
locret_40024:                           ; CODE XREF: Boss_GustheadDefeatCheck+6   j
                rts
; End of function Boss_GustheadDefeatCheck
; Exits defeat sequence
Boss_GustheadDefeatExit:                              ; DATA XREF: ROM:0003F2B2   o  ; was: sub_40026
                bsr.s Gfx_ApplyBossPaletteFade
                subq.w  #1,(dword_FF9424).w
                bpl.s   locret_4003E
                addq.w  #2,4(a5)
                move.w  #$1B0,d0
                moveq   #0,d1
                jmp Sprite_ClearAllExcept
; ---------------------------------------------------------------------------
locret_4003E:                           ; CODE XREF: Boss_GustheadDefeatExit+6   j
                rts
; End of function Boss_GustheadDefeatExit
; Waits during defeat sequence
Boss_GustheadDefeatWait:                              ; DATA XREF: ROM:0003F2B4   o  ; was: sub_40040
                tst.l   (dword_FFA960).w
                beq.s   loc_40054
                move.w  (dword_FFA900).w,d0
                andi.w  #$7F,d0
                bne.s   locret_4005E
                clr.l   (dword_FFA960).w
loc_40054:                              ; CODE XREF: Boss_GustheadDefeatWait+4   j
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_4005E:                           ; CODE XREF: Boss_GustheadDefeatWait+E   j
                rts
; End of function Boss_GustheadDefeatWait
; Finalizes defeat and cleanup
Boss_GustheadDefeatFinalize:                              ; DATA XREF: ROM:0003F2B6   o  ; was: sub_40060
                subq.w  #1,$48(a5)
                bne.s   locret_4006E
                clr.w   (a5)
                bset    #4,2(a5)
locret_4006E:                           ; CODE XREF: Boss_GustheadDefeatFinalize+4   j
                rts
; End of function Boss_GustheadDefeatFinalize
; Completes boss defeat
Boss_GustheadDefeatComplete:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_40070
                btst    #7,(byte_FFC66A).w
                bne.w   loc_40118
                clr.w   d1
                clr.w   d2
                clr.w   d3
                move.w  (word_FFC622).w,d0
                andi.w  #$8000,d0
                andi.w  #$7FFF,2(a5)
                or.w    d0,2(a5)
                tst.b   $4A(a5)
                bne.s   loc_400C2
                move.b  $4B(a5),d1
                add.w   d1,d1
                add.w   (dword_FF9400).w,d1
                andi.w  #$1FF,d1
                move.w  d1,$4E(a5)
                asr.w   #1,d1
                move.w  (dword_FF9404).w,d2
                move.w  d2,$50(a5)
                asr.w   #1,d2
                move.w  (dword_FF9408).w,d3
                move.w  d3,$52(a5)
                asr.w   #1,d3
                bra.s   loc_400EC
; ---------------------------------------------------------------------------
loc_400C2:                              ; CODE XREF: Boss_GustheadDefeatComplete+26   j
                movea.w a5,a0
                lea     -$60(a0),a0
                move.b  $57(a0),d1
                move.w  d1,$4E(a5)
                move.b  $5B(a0),d2
                move.w  d2,$50(a5)
                move.b  $5F(a0),d3
                move.w  d3,$52(a5)
                add.w   d1,$4E(a5)
                add.w   d2,$50(a5)
                add.w   d3,$52(a5)
loc_400EC:                              ; CODE XREF: Boss_GustheadDefeatComplete+50   j
                lea     $54(a5),a1
                lea     $58(a5),a2
                lea     $5C(a5),a3
                move.w  #3,d7
loc_400FC:                              ; CODE XREF: Boss_GustheadDefeatComplete+9E   j
                move.b  (a1),d4
                move.b  d1,(a1)+
                move.b  d4,d1
                move.b  (a2),d5
                move.b  d2,(a2)+
                move.b  d5,d2
                move.b  (a3),d6
                move.b  d3,(a3)+
                move.b  d6,d3
                dbf     d7,loc_400FC
                bsr.w Boss_GustheadUpdateRotation
                rts
; ---------------------------------------------------------------------------
loc_40118:                              ; CODE XREF: Boss_GustheadDefeatComplete+6   j
                move.l  (dword_FFA960).w,d0
                add.l   d0,$10(a5)
                move.w  4(a5),d0
                lea     off_4012C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadDefeatComplete
; ---------------------------------------------------------------------------
off_4012C:      dc.w Boss_GustheadTentacleInit-*        ; DATA XREF: Boss_GustheadDefeatComplete+B4   o
                dc.w Boss_GustheadBounceTransition-*
                dc.w nullsub_81-*


; Initializes Gusthead tentacle projectile with calculated trajectory from sine table
Boss_GustheadTentacleInit:                              ; DATA XREF: ROM:off_4012C   o  ; was: sub_40132
                addq.w  #2,4(a5)
                ori.w   #$100,2(a5)
                lea     (word_1B514).l,a1
                move.w  $4E(a5),d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d1
                move.w  -$80(a1,d0.w),d2
                ext.l   d1
                lsl.l   #2,d1
                move.l  d1,$18(a5)
                ext.l   d2
                lsl.l   #3,d2
                tst.l   d2
                bmi.s   loc_40164
                neg.l   d2
loc_40164:                              ; CODE XREF: Boss_GustheadTentacleInit+2E   j
                move.l  d2,$1C(a5)
                rts
; End of function Boss_GustheadTentacleInit
; Updates vertical velocity and transitions boss state after reaching Y position threshold
Boss_GustheadBounceTransition:                              ; DATA XREF: ROM:0004012E   o  ; was: sub_4016A
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   locret_40196
                clr.l   $1C(a5)
                clr.l   $18(a5)
                jsr (Enemy_GetEntityAddress).l
                move.l  #off_1A0E96,8(a5)
                move.w  #$4000,$E(a5)
locret_40196:                           ; CODE XREF: Boss_GustheadBounceTransition+E   j
                rts
; End of function Boss_GustheadBounceTransition
nullsub_81:                             ; DATA XREF: ROM:00040130   o
                rts
; End of function nullsub_81


; Boss core defeat state
Boss_GustheadCoreDefeat:                              ; CODE XREF: Boss_GustheadTentacleDefeat+C   p  ; was: sub_4019A
                                        ; Boss_GustheadDefeatPhase1+C   p ...
                tst.l   (dword_FF9428).w
                beq.w   locret_4076C
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_4076C
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_4076C
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   loc_401CC
                move.w  #$D1,d0
                jsr (Sound_PlaySFX).l
loc_401CC:                              ; CODE XREF: Boss_GustheadCoreDefeat+26   j
                move.w  #$1E4,(a0)
                move.l  #word_E91FA,8(a0)
                move.w  #$480,$E(a0)
                move.w  #$CC40,2(a0)
                move.b  #$7C,$20(a0) ; '|'
                move.w  #$100,$48(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$F0,d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9428).w,d0
                add.l   d0,d0
                move.l  d0,$18(a0)
                move.l  #$FFFFF000,$1C(a0)
                btst    #7,(dword_FF9428).w
                beq.s   loc_40226
                move.w  #$1C4,$10(a0)
                rts
; ---------------------------------------------------------------------------
loc_40226:                              ; CODE XREF: Boss_GustheadCoreDefeat+82   j
                move.w  #$7C,$10(a0) ; '|'
                rts
; End of function Boss_GustheadCoreDefeat
; Main handler for Gusthead debris
Enemy_GustheadDebrisMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4022E
                subq.w  #1,$48(a5)
                bmi.s   loc_40286
                cmpi.w  #$60,$10(a5) ; '`'
                bcs.s   loc_40286
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_40286
                cmpi.w  #$60,$14(a5) ; '`'
                bcs.s   loc_40286
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_40286
                move.l  (dword_FF9428).w,d0
                beq.s   loc_40274
                addq.b  #1,$4A(a5)
                btst    #0,$4A(a5)
                beq.s   loc_4026A
                add.l   d0,$18(a5)
loc_4026A:                              ; CODE XREF: Enemy_GustheadDebrisMain+36   j
                addi.l  #$400,$1C(a5)
                bra.s   loc_4027C
; ---------------------------------------------------------------------------
loc_40274:                              ; CODE XREF: Enemy_GustheadDebrisMain+2A   j
                addi.l  #$2000,$1C(a5)
loc_4027C:                              ; CODE XREF: Enemy_GustheadDebrisMain+44   j
                move.l  $1C(a5),d0
                add.l   d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_40286:                              ; CODE XREF: Enemy_GustheadDebrisMain+4   j
                                        ; Enemy_GustheadDebrisMain+C   j ...
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisMain
; Spawns falling debris projectiles
Boss_GustheadSpawnDebris:                              ; CODE XREF: Boss_GustheadDefeatPhase1+18   p  ; was: sub_4028E
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_402EE
                tst.l   (dword_FF8240).w
                beq.s   locret_402EE
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_402EE
                move.w  #$1E8,(a0)
                move.w  #$ED00,2(a0)
                bsr.w Enemy_GustheadDebrisSetSprite
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #8,$26(a0)
                move.b  #$10,$20(a0)
                move.w  #$F0,$14(a0)
                tst.l   (dword_FF8240).w
                bmi.s   loc_402F0
                move.w  #$78,$10(a0) ; 'x'
locret_402EE:                           ; CODE XREF: Boss_GustheadSpawnDebris+8   j
                                        ; Boss_GustheadSpawnDebris+E   j ...
                rts
; ---------------------------------------------------------------------------
loc_402F0:                              ; CODE XREF: Boss_GustheadSpawnDebris+58   j
                move.w  #$1C8,$10(a0)
                rts
; End of function Boss_GustheadSpawnDebris
; Sets random debris sprite
Enemy_GustheadDebrisSetSprite:                              ; CODE XREF: Boss_GustheadSpawnDebris+22   p  ; was: sub_402F8
                                        ; Boss_GustheadSpawnDebris4Way+46   p
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_40318(pc,d0.w),8(a0)
                move.w  #$8000,$E(a0)
                rts
; End of function Enemy_GustheadDebrisSetSprite
; ---------------------------------------------------------------------------
off_40318:      dc.l off_1A0F1A         ; DATA XREF: Enemy_GustheadDebrisSetSprite+12   r
                dc.l off_1A0F42
                dc.l off_1A0F2E
                dc.l off_1A0F42


; Main physics handler for debris
Enemy_GustheadDebrisPhysicsMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_40328
                tst.w   $24(a5)
                bmi.s   loc_4033E
                bclr    #7,$22(a5)
                beq.s   loc_40358
                bclr    #4,$22(a5)
                beq.s   loc_40342
loc_4033E:                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+4   j
                bra.w Enemy_GustheadDebrisExplode
; ---------------------------------------------------------------------------
loc_40342:                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+14   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_40358:                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+C   j
                move.w  4(a5),d0
                lea     off_40364(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadDebrisPhysicsMain
; ---------------------------------------------------------------------------
off_40364:      dc.w Enemy_GustheadDebrisInit-*        ; DATA XREF: Enemy_GustheadDebrisPhysicsMain+34   o
                dc.w Enemy_GustheadDebrisUpdate-*
                dc.w nullsub_82-*


; Initializes debris with velocity
Enemy_GustheadDebrisInit:                              ; DATA XREF: ROM:off_40364   o  ; was: sub_4036A
                addq.w  #2,4(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,d0
                add.l   d0,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4037E
                add.l   d0,d0
loc_4037E:                              ; CODE XREF: Enemy_GustheadDebrisInit+10   j
                move.l  d0,$18(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FFF,d0
                subi.w  #$800,d0
                ext.l   d0
                move.l  d0,$4C(a5)
                rts
; End of function Enemy_GustheadDebrisInit
; Updates debris position with gravity
Enemy_GustheadDebrisUpdate:                              ; DATA XREF: ROM:00040366   o  ; was: sub_40396
                bsr.w Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5) ; '`'
                bcs.s   loc_403CE
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_403CE
                cmpi.w  #$60,$14(a5) ; '`'
                bcs.s   loc_403CE
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_403CE
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
                btst    #7,$1C(a5)
                beq.w Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
loc_403CE:                              ; CODE XREF: Enemy_GustheadDebrisUpdate+A   j
                                        ; Enemy_GustheadDebrisUpdate+12   j ...
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisUpdate
nullsub_82:                             ; DATA XREF: ROM:00040368   o
                rts
; End of function nullsub_82


; Flips debris sprite based on velocity
Enemy_GustheadDebrisFlip:                              ; CODE XREF: Enemy_GustheadDebrisUpdate   p  ; was: sub_403D8
                                        ; sub_4046C:loc_4049C   p
                btst    #7,$1C(a5)
                bne.s   loc_403E8
                ori.w   #$1000,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_403E8:                              ; CODE XREF: Enemy_GustheadDebrisFlip+6   j
                andi.w  #$EFFF,$E(a5)
                rts
; End of function Enemy_GustheadDebrisFlip
; Spawns 4 debris projectiles with trajectories from angle table
Boss_GustheadSpawnDebris4Way:                              ; CODE XREF: Boss_GustheadBounceAttackLogic+2A   p  ; was: sub_403F0
                lea     (word_1B514).l,a1
                move.w  #3,d7
                move.w  #$120,d6
loc_403FE:                              ; CODE XREF: Boss_GustheadSpawnDebris4Way+76   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_4046A
                move.w  (a1,d6.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a0)
                move.l  #$FFFA0000,$1C(a0)
                move.w  #$214,(a0)
                move.w  #$ED40,2(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                addi.w  #$10,$14(a0)
                bsr.w Enemy_GustheadDebrisSetSprite
                move.b  #$10,$20(a0)
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #$10,$26(a0)
                addi.w  #$40,d6 ; '@'
                dbf     d7,loc_403FE
locret_4046A:                           ; CODE XREF: Boss_GustheadSpawnDebris4Way+14   j
                rts
; End of function Boss_GustheadSpawnDebris4Way
; Updates debris physics with gravity, boundary checks, and collision detection
Boss_GustheadDebrisUpdate:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4046C
                tst.w   $24(a5)
                bmi.s   loc_40482
                bclr    #7,$22(a5)
                beq.s   loc_4049C
                bclr    #4,$22(a5)
                beq.s   loc_40486
loc_40482:                              ; CODE XREF: Boss_GustheadDebrisUpdate+4   j
                bra.w Enemy_GustheadDebrisExplode
; ---------------------------------------------------------------------------
loc_40486:                              ; CODE XREF: Boss_GustheadDebrisUpdate+14   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_4049C:                              ; CODE XREF: Boss_GustheadDebrisUpdate+C   j
                bsr.w Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5) ; '`'
                bcs.s   loc_404D4
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_404D4
                cmpi.w  #$60,$14(a5) ; '`'
                bcs.s   loc_404D4
                cmpi.w  #$180,$14(a5)
                bhi.s   loc_404D4
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                beq.w Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
loc_404D4:                              ; CODE XREF: Boss_GustheadDebrisUpdate+3A   j
                                        ; Boss_GustheadDebrisUpdate+42   j ...
                bset    #4,2(a5)
                rts
; End of function Boss_GustheadDebrisUpdate
; Clears debris velocity and resets animation state
Boss_GustheadDebrisReset:
                clr.l   $18(a5)  ; was: sub_404DC
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp Enemy_GetEntityAddress
; End of function Boss_GustheadDebrisReset
; Checks ground collision and applies upward bounce velocity to debris
Boss_GustheadDebrisGroundBounce:                              ; CODE XREF: Enemy_GustheadDebrisUpdate+32   j  ; was: sub_404F2
                                        ; Boss_GustheadDebrisUpdate+62   j
                cmpi.w  #$150,$14(a5)
                blt.s   locret_4051A
                move.l  #off_1A0E96,8(a5)
                jsr (Enemy_GetEntityAddress).l
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                clr.w   $18(a5)
locret_4051A:                           ; CODE XREF: Boss_GustheadDebrisGroundBounce+6   j
                rts
; End of function Boss_GustheadDebrisGroundBounce
; Updates boss rotation animation
Boss_GustheadUpdateRotation:                              ; CODE XREF: Boss_GustheadDefeatComplete+A2   p  ; was: sub_4051C
                movea.w a5,a0
                clr.w   d0
                move.b  $20(a0),d0
                addi.w  #2,d0
                andi.w  #$7F,d0
                subi.w  #$20,d0 ; ' '
                andi.w  #$3C,d0 ; '<'
                move.l  off_4054A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                lsr.w   #1,d0
                lea     (word_FF9502).w,a1
                addq.w  #1,(a1,d0.w)
                rts
; End of function Boss_GustheadUpdateRotation
; ---------------------------------------------------------------------------
off_4054A:      dc.l word_EC010         ; DATA XREF: Boss_GustheadUpdateRotation+18   r
                dc.l word_EC010
                dc.l word_EC010
                dc.l word_EC016
                dc.l word_EC016
                dc.l word_EC01C
                dc.l word_EC01C
                dc.l word_EC022
                dc.l word_EC022
                dc.l word_EC028
                dc.l word_EC028
                dc.l word_EC02E
                dc.l word_EC02E
                dc.l word_EC034
                dc.l word_EC034
                dc.l word_EC034


; Updates scroll based on boss movement
Boss_GustheadUpdateScroll:                              ; CODE XREF: Boss_GustheadTentacleDefeat+8   p  ; was: sub_4058A
                                        ; Boss_GustheadDefeatPhase1+8   p ...
                move.l  (dword_FF940C).w,d0
                bne.s   loc_40596
                move.l  (dword_FF9414).w,d0
                beq.s   loc_405A2
loc_40596:                              ; CODE XREF: Boss_GustheadUpdateScroll+4   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_405A0
                asr.l   #5,d0
                bra.s   loc_405A2
; ---------------------------------------------------------------------------
loc_405A0:                              ; CODE XREF: Boss_GustheadUpdateScroll+10   j
                asr.l   #4,d0
loc_405A2:                              ; CODE XREF: Boss_GustheadUpdateScroll+A   j
                                        ; Boss_GustheadUpdateScroll+14   j
                move.l  d0,(dword_FF8240).w
                rts
; End of function Boss_GustheadUpdateScroll
; Updates tentacle positions
Boss_GustheadUpdateTentacles:                              ; CODE XREF: Boss_GustheadIntroReveal+48   p  ; was: sub_405A8
                                        ; Boss_GustheadBattleStart+20   p ...
                tst.l   (dword_FF940C).w
                beq.s   loc_405BC
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
loc_405BC:                              ; CODE XREF: Boss_GustheadUpdateTentacles+4   j
                tst.l   (dword_FF9410).w
                beq.s   loc_405D0
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9404).w
                andi.w  #$1FF,(dword_FF9404).w
loc_405D0:                              ; CODE XREF: Boss_GustheadUpdateTentacles+18   j
                tst.l   (dword_FF9414).w
                beq.s   locret_405E4
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9408).w
                andi.w  #$1FF,(dword_FF9408).w
locret_405E4:                           ; CODE XREF: Boss_GustheadUpdateTentacles+2C   j
                rts
; End of function Boss_GustheadUpdateTentacles
; Sets tentacle sprite priority value to 0
Boss_GustheadTentaclesClearPriority:
                clr.w   d0  ; was: sub_405E6
                bra.s   loc_405EE
; End of function Boss_GustheadTentaclesClearPriority
; Sets sprite priority for all 4 tentacle segments
Boss_GustheadTentaclesSetPriority:
                move.w  #2,d0  ; was: sub_405EA
loc_405EE:                              ; CODE XREF: Boss_GustheadTentaclesClearPriority+2   j
                move.w  #3,d7
                movea.l (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
loc_405FA:                              ; CODE XREF: Boss_GustheadTentaclesSetPriority+18   j
                move.w  d0,4(a0)
                lea     $60(a0),a0
                dbf     d7,loc_405FA
                rts
; End of function Boss_GustheadTentaclesSetPriority
; Updates sine/cosine angle offsets for tentacle animation
Boss_GustheadTentaclesUpdateAngles:
                move.w  #3,d7  ; was: sub_40608
                movea.w (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
loc_40614:                              ; CODE XREF: Boss_GustheadTentaclesUpdateAngles+4C   j
                clr.w   d0
                move.b  $4B(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9400).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$4E(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9404).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$50(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9408).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$52(a0)
                lea     $60(a0),a0
                dbf     d7,loc_40614
                rts
; End of function Boss_GustheadTentaclesUpdateAngles
; Updates tentacle rotation angles
Boss_GustheadUpdateTentacleAngles:                              ; CODE XREF: Boss_GustheadIntroReveal+4C   p  ; was: sub_4065A
                                        ; Boss_GustheadBattleStart+24   p ...
                move.l  $10(a5),$670(a5)
                move.l  $14(a5),$674(a5)
                addi.w  #$1A,$670(a5)
                addi.w  #-6,$674(a5)
                move.w  #4,$5C(a5)
                movea.w a5,a0
                lea     $60(a0),a0
loc_4067E:                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+10E   j
                move.w  #3,d0
                movea.w a5,a1
loc_40684:                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+106   j
                lea     (word_1B514).l,a2
                move.w  $48(a0),d4
                move.w  $4E(a0),d5
                move.w  $50(a0),d6
                move.w  $52(a0),d7
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                move.w  -$80(a2,d5.w),d1
                muls.w  d4,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  (a2,d6.w),d2
                muls.w  d2,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                asr.w   #2,d1
                cmpi.w  #$3F,d1 ; '?'
                blt.s   loc_406CC
                move.w  #$3F,d1 ; '?'
                bra.s   loc_406D6
; ---------------------------------------------------------------------------
loc_406CC:                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+6A   j
                cmpi.w  #$FFC1,d1
                bgt.s   loc_406D6
                move.w  #$FFC1,d1
loc_406D6:                              ; CODE XREF: Boss_GustheadUpdateTentacleAngles+70   j
                                        ; Boss_GustheadUpdateTentacleAngles+76   j
                clr.w   d2
                move.b  $20(a1),d2
                add.w   d2,d1
                move.b  d1,$20(a0)
                move.w  (a2,d5.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  -$80(a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                sub.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $10(a1),d3
                move.l  d3,$10(a0)
                move.w  (a2,d5.w),d1
                move.w  -$80(a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  (a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                add.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $14(a1),d3
                move.l  d3,$14(a0)
                lea     (a0),a1
                lea     $60(a0),a0
                dbf     d0,loc_40684
                subq.w  #1,$5C(a5)
                bne.w   loc_4067E
locret_4076C:                           ; CODE XREF: Boss_GustheadInitBattle+4   j
                                        ; Boss_GustheadTentacleDamage+56   j ...
                rts
; End of function Boss_GustheadUpdateTentacleAngles
; Debris explosion with particle spawn
Enemy_GustheadDebrisExplode:                              ; CODE XREF: Enemy_GustheadDebrisPhysicsMain:loc_4033E   j  ; was: sub_4076E
                                        ; sub_4046C:loc_40482   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_40798
                jsr (Projectile_InitType88).l
                move.l  #off_E95DC,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_40798:                              ; CODE XREF: Enemy_GustheadDebrisExplode+E   j
                jmp Sprite_SetPointerClearD7
; End of function Enemy_GustheadDebrisExplode
; Main handler for Snake boss
Boss_SnakeMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4079E
                tst.w   4(a5)
                beq.w Boss_SnakeStateDispatch
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
                btst    #1,$4C(a5)
                bne.s   loc_407D4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_407D4
                tst.w   (word_FF8200).w
                bne.s   loc_407D4
                move.b  #2,(byte_FF80EC).w
                move.w  #$A,4(a5)
loc_407D4:                              ; CODE XREF: Boss_SnakeMain+1A   j
                                        ; Boss_SnakeMain+22   j ...
                jsr (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (dword_FF9420).w,a0
                move.w  #$16,d7
loc_407F0:                              ; CODE XREF: Boss_SnakeMain+62   j
                move.w  (dword_FF940C+2).w,d6
                subq.w  #1,d6
loc_407F6:                              ; CODE XREF: Boss_SnakeMain+5E   j
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d6,loc_407F6
                dbf     d7,loc_407F0
                move.w  #$16,d7
                lea     $60(a5),a0
                lea     (dword_FF9420).w,a1
                move.w  (dword_FF940C+2).w,d6
                add.w   d6,d6
                add.w   d6,d6
loc_40818:                              ; CODE XREF: Boss_SnakeMain+92   j
                lea     (a1,d6.w),a1
                move.w  (a1),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a0)
                move.w  2(a1),$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_40818
                bsr.w Boss_SnakeUpdateAnimation
; State machine dispatcher for Snake boss
Boss_SnakeStateDispatch:                              ; CODE XREF: Boss_SnakeMain+4   j  ; was: loc_40838
                move.w  4(a5),d0
                lea     off_40844(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SnakeMain
; ---------------------------------------------------------------------------
off_40844:      dc.w Boss_SnakeInit-*        ; DATA XREF: Boss_SnakeMain+9E   o
                dc.w Boss_SnakeStartBattle-*
                dc.w Boss_SnakeBattleActive-*
                dc.w Boss_SnakePhase1-*
                dc.w Boss_SnakePhase2-*
                dc.w Boss_SnakeSegmentDestroy-*
                dc.w Boss_SnakeSegmentDestroyLoop-*
                dc.w nullsub_83-*


; Initializes Snake boss with 23 segments
Boss_SnakeInit:                              ; DATA XREF: ROM:off_40844   o  ; was: sub_40854
                tst.b   (word_FFF720).w
                bmi.w   locret_40940
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #4,(dword_FF940C+2).w
                move.w  #$10,(dword_FF9408+2).w
                move.w  #$10,(dword_FF940C).w
                move.w  #$4000,(word_FF8202).w
                move.w  #$4000,(word_FF8200).w
                move.w  #$E300,$E(a5)
                move.w  #$CD00,2(a5)
                move.l  #stru_8630,8(a5)
                clr.w   $C(a5)
                clr.w   $54(a5)
                move.b  #$10,$20(a5)
                move.b  #$50,$21(a5) ; 'P'
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$24(a5) ; '('
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                move.w  #$16,d7
                clr.w   d6
                lea     $60(a5),a0
loc_408DE:                              ; CODE XREF: Boss_SnakeInit+E8   j
                move.w  #$29C,(a0)
                move.l  #stru_8630,8(a0)
                clr.w   $C(a0)
                move.w  #$E300,$E(a0)
                move.w  #$CD00,2(a0)
                move.w  #$80,$26(a0)
                move.b  #$10,$20(a0)
                move.w  #$14,$24(a0)
                btst    #0,d7
                bne.s Boss_SnakeSetSegmentAngle
                move.b  #$50,$21(a0) ; 'P'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                addi.w  #4,d6
                cmpi.w  #$1E,d6
                bls.s Boss_SnakeSetSegmentAngle
                clr.w   d6
; Sets angle offset for snake segments
Boss_SnakeSetSegmentAngle:                              ; CODE XREF: Boss_SnakeInit+BC   j  ; was: loc_40934
                                        ; Boss_SnakeInit+DC   j
                move.w  d6,$54(a0)
                lea     $60(a0),a0
                dbf     d7,loc_408DE
locret_40940:                           ; CODE XREF: Boss_SnakeInit+4   j
                rts
; End of function Boss_SnakeInit
; Starts Snake boss battle phase
Boss_SnakeStartBattle:                              ; DATA XREF: ROM:00040846   o  ; was: sub_40942
                bsr.w Boss_SnakeAI
                clr.b   (byte_FF80EC).w
                clr.w   $4A(a5)
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$120,(dword_FF9404+2).w
                move.w  #$100,(dword_FF9408).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SnakeStartBattle
; Active battle state for Snake boss
Boss_SnakeBattleActive:                              ; DATA XREF: ROM:00040848   o  ; was: sub_4096C
                bsr.w Boss_SnakeAI
                bsr.w Boss_SnakeUpdateHeadPosition
                bsr.w Boss_SnakeRandomizeSegments
                cmpi.w  #$56,(word_FF80C2).w ; 'V'
                bcs.s   locret_4098A
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4098A:                           ; CODE XREF: Boss_SnakeBattleActive+12   j
                rts
; End of function Boss_SnakeBattleActive
; Updates Snake head position with wave
Boss_SnakeUpdateHeadPosition:                              ; CODE XREF: Boss_SnakeBattleActive+4   p  ; was: sub_4098C
                move.w  (word_FFA000).w,d0
                andi.w  #$7F,d0
                bne.s Boss_SnakeHeadPattern
                addq.w  #1,$52(a5)
; Calculates head position pattern offset
Boss_SnakeHeadPattern:                              ; CODE XREF: Boss_SnakeUpdateHeadPosition+8   j  ; was: loc_4099A
                move.w  $52(a5),d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_409BC(pc,d0.w),d1
                move.w  (dword_FFA900).w,d2
                add.w   word_409DC(pc,d1.w),d2
                move.w  d2,(dword_FF9404+2).w
                move.w  word_409E6(pc,d1.w),(dword_FF9408).w
                rts
; End of function Boss_SnakeUpdateHeadPosition
; ---------------------------------------------------------------------------
word_409BC:     dc.w 2, 4, 2, 4, 8, 2, 4, 2, 6, 4, 0, 8, 0, 2, 4, 2
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+18   r
word_409DC:     dc.w $C0, $120, $180, $C0, $180
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+20   r
word_409E6:     dc.w $150, $140, $150, $140, $F0
                                        ; DATA XREF: Boss_SnakeUpdateHeadPosition+28   r


; Randomizes segment sizes
Boss_SnakeRandomizeSegments:                              ; CODE XREF: Boss_SnakeBattleActive+8   p  ; was: sub_409F0
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   locret_40A1E
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF9408+2).w
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF940C).w
locret_40A1E:                           ; CODE XREF: Boss_SnakeRandomizeSegments+8   j
                rts
; End of function Boss_SnakeRandomizeSegments
; Phase 1 behavior with countdown timer
Boss_SnakePhase1:                              ; DATA XREF: ROM:0004084A   o  ; was: sub_40A20
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$160,(dword_FF9404+2).w
                move.w  #$140,(dword_FF9408).w
                bsr.w Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40A46
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
locret_40A46:                           ; CODE XREF: Boss_SnakePhase1+1A   j
                rts
; End of function Boss_SnakePhase1
; Phase 2 behavior with final cleanup
Boss_SnakePhase2:                              ; DATA XREF: ROM:0004084C   o  ; was: sub_40A48
                move.w  (dword_FFA900).w,(dword_FF9404+2).w
                addi.w  #$120,(dword_FF9404+2).w
                move.w  #$200,(dword_FF9408).w
                bsr.w Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40A6C
                clr.w   (a5)
                move.w  #$1000,2(a5)
locret_40A6C:                           ; CODE XREF: Boss_SnakePhase2+1A   j
                rts
; End of function Boss_SnakePhase2
; Segment destroyed with explosion
Boss_SnakeSegmentDestroy:                              ; DATA XREF: ROM:0004084E   o  ; was: sub_40A6E
                bsr.w Boss_SnakeAI
                jsr (Projectile_ExplodeOnImpact).l
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                andi.w  #$7FFF,2(a5)
                move.w  #$10,$48(a5)
                move.w  a5,$4A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_40AB6
                moveq   #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_40AB6:                           ; CODE XREF: Boss_SnakeSegmentDestroy+32   j
                rts
; End of function Boss_SnakeSegmentDestroy
; Destroys snake segments sequentially
Boss_SnakeSegmentDestroyLoop:                              ; DATA XREF: ROM:00040850   o  ; was: sub_40AB8
                bsr.w Boss_SnakeAI
                subq.w  #1,$48(a5)
                bne.s   locret_40AE6
                movea.w $4A(a5),a0
                lea     $60(a0),a0
                clr.b   $21(a0)
                move.w  #1,$5E(a0)
                lea     $8A0(a5),a1
                cmpa.w  a1,a0
                bhi.s   loc_40AE8
                move.w  a0,$4A(a5)
                move.w  #8,$48(a5)
locret_40AE6:                           ; CODE XREF: Boss_SnakeSegmentDestroyLoop+8   j
                rts
; ---------------------------------------------------------------------------
loc_40AE8:                              ; CODE XREF: Boss_SnakeSegmentDestroyLoop+22   j
                move.w  #$1000,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_SnakeSegmentDestroyLoop
nullsub_83:                             ; DATA XREF: ROM:00040852   o
                rts
; End of function nullsub_83


; Main handler for Snake segment
Boss_SnakeSegmentMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_40AF6
                bsr.w Boss_SnakeUpdateAnimation
                tst.b   $21(a5)
                beq.s   loc_40B0A
                tst.w   (word_FF8200).w
                bne.s   loc_40B0A
                clr.b   $21(a5)
loc_40B0A:                              ; CODE XREF: Boss_SnakeSegmentMain+8   j
                                        ; Boss_SnakeSegmentMain+E   j
                cmpi.w  #4,4(a5)
                bcc.s Boss_SnakeSegmentDispatch
                tst.w   $5E(a5)
                beq.s Boss_SnakeSegmentDispatch
                move.w  #4,4(a5)
                jsr (Projectile_ExplodeOnImpact).l
                andi.w  #$7FFF,2(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s Boss_SnakeSegmentDispatch
                moveq   #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; State dispatcher for snake segments
Boss_SnakeSegmentDispatch:                              ; CODE XREF: Boss_SnakeSegmentMain+1A   j  ; was: loc_40B46
                                        ; Boss_SnakeSegmentMain+20   j ...
                move.w  4(a5),d0
                lea     off_40B52(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SnakeSegmentMain
; ---------------------------------------------------------------------------
off_40B52:      dc.w Boss_SnakeSegmentWait-*        ; DATA XREF: Boss_SnakeSegmentMain+54   o
                dc.w Boss_SnakeSegmentAttackDelay-*
                dc.w nullsub_84-*


; Segment waits to attack
Boss_SnakeSegmentWait:                              ; DATA XREF: ROM:off_40B52   o  ; was: sub_40B58
                cmpi.w  #$140,$14(a5)
                blt.s   locret_40B9A
                cmpi.w  #$160,$14(a5)
                bgt.s   locret_40B9A
                lea     (word_FFCF80).w,a0
                jsr     (loc_1C11C).l
                bne.s   locret_40B9A
                jsr (Projectile_InitType88).l
                bsr.s Boss_SnakeSetupProjectile
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_40B9A
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
locret_40B9A:                           ; CODE XREF: Boss_SnakeSegmentWait+6   j
                                        ; Boss_SnakeSegmentWait+E   j ...
                rts
; End of function Boss_SnakeSegmentWait
; Delay after segment attack
Boss_SnakeSegmentAttackDelay:                              ; DATA XREF: ROM:00040B54   o  ; was: sub_40B9C
                subq.w  #1,$48(a5)
                bne.s   locret_40BA6
                subq.w  #2,4(a5)
locret_40BA6:                           ; CODE XREF: Boss_SnakeSegmentAttackDelay+4   j
                rts
; End of function Boss_SnakeSegmentAttackDelay
nullsub_84:                             ; DATA XREF: ROM:00040B56   o
                rts
; End of function nullsub_84


; Sets up projectile from segment
Boss_SnakeSetupProjectile:                              ; CODE XREF: Boss_SnakeSegmentWait+22   p  ; was: sub_40BAA
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                subq.w  #4,d0
                move.w  d0,$18(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_40BEC(pc,d0.w),8(a0)
                move.w  #$C000,$E(a0)
                rts
; End of function Boss_SnakeSetupProjectile
; ---------------------------------------------------------------------------
off_40BEC:      dc.l off_1A0E96         ; DATA XREF: Boss_SnakeSetupProjectile+34   r
                dc.l off_1A0E86
                dc.l off_1A0E96
                dc.l off_1A0EA6


; Snake boss AI and movement control
Boss_SnakeAI:                              ; CODE XREF: Boss_SnakeStartBattle   p  ; was: sub_40BFC
                                        ; sub_4096C   p ...
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_40C48
                move.w  (dword_FF9404+2).w,d0
                sub.w   (dword_FFA900).w,d0
                move.w  (dword_FF9408).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  (dword_FF9400).w,d1
                addi.w  #$100,d1
                sub.w   d2,d1
                andi.w  #$1FF,d1
                cmpi.w  #$100,d1
                beq.s   loc_40C48
                cmpi.w  #$100,d1
                bcs.s   loc_40C42
                move.w  #8,(dword_FF9400+2).w
                bra.s   loc_40C48
; ---------------------------------------------------------------------------
loc_40C42:                              ; CODE XREF: Boss_SnakeAI+3C   j
                move.w  #$FFF8,(dword_FF9400+2).w
loc_40C48:                              ; CODE XREF: Boss_SnakeAI+8   j
                                        ; Boss_SnakeAI+36   j ...
                move.w  (dword_FF9400+2).w,d0
                add.w   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
                move.w  (dword_FF9400).w,d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                muls.w  (dword_FF9408+2).w,d0
                muls.w  (dword_FF940C).w,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Boss_SnakeAI
; Updates Snake animation frame
Boss_SnakeUpdateAnimation:                              ; CODE XREF: Boss_SnakeMain+96   p  ; was: sub_40C82
                                        ; sub_40AF6   p
                move.w  (word_FFA000).w,d7
                andi.w  #1,d7
                bne.s   locret_40CAE
                addq.w  #1,$54(a5)
                cmpi.w  #$1E,$54(a5)
                bne.s Boss_SnakeGetAnimFrame
                clr.w   $54(a5)
; Gets animation frame from table lookup
Boss_SnakeGetAnimFrame:                              ; CODE XREF: Boss_SnakeUpdateAnimation+14   j  ; was: loc_40C9C
                move.w  $54(a5),d0
                add.w   d0,d0
                move.w  word_40CB0(pc,d0.w),d1
                add.w   d1,d1
                jsr (Sprite_SetGraphicsPointer).l
locret_40CAE:                           ; CODE XREF: Boss_SnakeUpdateAnimation+8   j
                rts
; End of function Boss_SnakeUpdateAnimation
; ---------------------------------------------------------------------------
word_40CB0:     dc.w 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E
                                        ; DATA XREF: Boss_SnakeUpdateAnimation+20   r
                dc.w $F, $E, $D, $C, $B, $A, 9, 8, 7, 6, 5, 4, 3, 2, 1


nullsub_85:
                rts
; End of function nullsub_85


; Initializes palette fade and dispatches to state handler table
Boss_SunsetStingInitDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_40CEE
                moveq   #4,d7
                jsr (Gfx_InitPaletteFade).l
                move.w  4(a5),d0
                lea     off_40D02(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingInitDispatcher
; ---------------------------------------------------------------------------
off_40D02:      dc.w Boss_SunsetStingSetupArena-*        ; DATA XREF: Boss_SunsetStingInitDispatcher+C   o
                dc.w Boss_SunsetStingLoadGraphics-*
                dc.w Boss_SunsetStingCheckVictory-*
                dc.w Boss_SunsetStingIntroMovement-*
                dc.w Boss_SunsetStingIdleState-*
                dc.w Boss_SunsetStingIncrementCounter-*
                dc.w Boss_SunsetStingDashAttack-*
                dc.w Boss_SunsetStingDashAttack_MoveToward-*
                dc.w Boss_SunsetStingDashAttack_MoveAway-*
                dc.w Boss_SunsetStingDashAttack_MoveToward-*
                dc.w Boss_SunsetStingDashAttack_MoveAway-*
                dc.w Boss_SunsetStingResetForAttack-*
                dc.w Boss_SunsetStingPrepareDive-*
                dc.w Boss_SunsetStingTimerWait-*
                dc.w Boss_SunsetStingSerpentineAttack-*
                dc.w Boss_SunsetStingSerpentineAttack_MoveIn-*
                dc.w Boss_SunsetStingSerpentineAttack_MoveOut-*
                dc.w Boss_SunsetStingRotationDecelerate-*
                dc.w Boss_SunsetStingWobbleRotation-*
                dc.w Boss_SunsetStingSpawnDebrisField-*
                dc.w Boss_SunsetStingSpawnDebrisField_RiseLoop-*
                dc.w Boss_SunsetStingFadeOutAndDestroy-*
unused_8:	binclude	"data/other/unused_8.bin"


; Sets up battle arena parameters and clears sprite slots
Boss_SunsetStingSetupArena:                              ; DATA XREF: ROM:off_40D02   o  ; was: sub_40D34
                move.b  #6,(byte_FF80EC).w
                move.w  #$1C0,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (word_FFC67E).w
                rts
; End of function Boss_SunsetStingSetupArena
; Loads boss sprites, palette, tiles and initializes position/velocity
Boss_SunsetStingLoadGraphics:                              ; DATA XREF: ROM:00040D04   o  ; was: sub_40D56
                tst.w   (word_FFF720).w
                bmi.w   locret_40DC2
                addq.w  #2,4(a5)
                movea.l #word_1BD78,a1
                jsr (Sprite_InitFromPointerTable).l
                moveq   #6,d7
                jsr (Data_LoadPaletteTable).l
                move.w  (a5),-(sp)
                move.w  #$4300,$E(a5)
                lea     word_41568(pc),a1
                lea     (a5),a4
                jsr Boss_SunsetStingInitBodyParts(pc)   ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$D00,2(a5)
                move.l  #$2000000,$10(a5)
                move.l  #$1000000,$14(a5)
                move.l  #$FFFF0000,$18(a5)
                move.b  #0,$4A(a5)
                ori.w   #$800,$E(a5)
                movea.l #word_40DD6,a0
                jsr (Gfx_LoadCompressedTiles).l
locret_40DC2:                           ; CODE XREF: Boss_SunsetStingLoadGraphics+4   j
                rts
; End of function Boss_SunsetStingLoadGraphics
; ---------------------------------------------------------------------------
word_40DC4:     dc.w $E, $20, $1E, $26, $1A, $22, $16, $14, $12
                                        ; DATA XREF: Boss_SunsetStingUpdateGraphics+2A   o
word_40DD6:     dc.w $6100, $2000, $202, $494A, $4B4D, $4E4F, $5152, $FF, $6300, $2000, $101, $4D4E, $5152, $6300, $2000, $101
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+60   o
                dc.w $5455, $5658, $E, $10, $16, $1C, $12, 8, 6, 4, 2, $6100, $2000, $100, $494A, $6100
                dc.w $2000, $100, $4C53, $6100, $2000, $100, $5057


; Checks victory condition and advances to next state
Boss_SunsetStingCheckVictory:                              ; DATA XREF: ROM:00040D06   o  ; was: sub_40E24
                moveq   #5,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                bra.w   loc_40E48
; End of function Boss_SunsetStingCheckVictory
; Handles boss intro flight pattern until timer expires
Boss_SunsetStingIntroMovement:                              ; DATA XREF: ROM:00040D08   o  ; was: sub_40E34
                tst.w   (word_FF80C2).w
                bne.s   loc_40E48
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
loc_40E48:                              ; CODE XREF: Boss_SunsetStingCheckVictory+C   j
                                        ; Boss_SunsetStingIntroMovement+4   j
                subq.b  #1,$4B(a5)
                bsr.w Boss_SunsetStingCalculateVerticalVelocity
                cmpi.l  #$1600000,$10(a5)
                bhi.s   loc_40E5E
                clr.l   $18(a5)
loc_40E5E:                              ; CODE XREF: Boss_SunsetStingIntroMovement+24   j
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingIntroMovement
; Resets attack state and adjusts based on boss health
Boss_SunsetStingResetForAttack:                              ; CODE XREF: Boss_SunsetStingDashAttack+72   j  ; was: sub_40E62
                                        ; Boss_SunsetStingDashAttack+82   j ...
                move.w  #8,4(a5)
                move.b  #$40,$4B(a5) ; '@'
                clr.l   $18(a5)
                cmpi.w  #$100,(word_FF8234).w
                bgt.s   loc_40E86
                move.b  #$C0,$4B(a5)
                move.w  #$A,4(a5)
loc_40E86:                              ; CODE XREF: Boss_SunsetStingResetForAttack+16   j
                bsr.w Boss_SunsetStingDisableCollision
                bra.w Boss_SunsetStingUpdateGraphics
; End of function Boss_SunsetStingResetForAttack
; Increments global counter and calls angle calculation routine
Boss_SunsetStingIncrementCounter:                              ; DATA XREF: ROM:00040D0C   o  ; was: sub_40E8E
                addi.w  #2,(word_FF8234).w
                clr.w   d3
                bsr.w Boss_SunsetStingCalculateAngleAndFlip
; End of function Boss_SunsetStingIncrementCounter
; Handles idle behavior with animation and distance-based attack selection
Boss_SunsetStingIdleState:                              ; DATA XREF: ROM:00040D0A   o  ; was: sub_40E9A
                subq.b  #1,$4B(a5)
                beq.w   loc_40ECA
                bsr.w Boss_SunsetStingCalculateVerticalVelocity
                move.b  #0,6(a5)
                bsr.w Boss_SunsetStingInterpolateRotation
                move.b  #0,$4A(a5)
                btst    #4,$4B(a5)
                beq.w Boss_SunsetStingUpdateGraphics
                move.b  #4,$4A(a5)
                bra.w Boss_SunsetStingUpdateGraphics
; ---------------------------------------------------------------------------
loc_40ECA:                              ; CODE XREF: Boss_SunsetStingIdleState+4   j
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$80,d0
                bcs.s Boss_SunsetStingCloseRangeAttack
                lea     word_40EE0(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingIdleState
; ---------------------------------------------------------------------------
word_40EE0:     dc.w $7800              ; DATA XREF: Boss_SunsetStingIdleState+3C   o
                dc.w Boss_SunsetStingAttackSetup3-*
                dc.w $7000
                dc.w Boss_SunsetStingAttackSetup1-*
                dc.w $1000
                dc.w Boss_SunsetStingIdleSetup-*
                dc.w $800
                dc.w Boss_SunsetStingAttackRecover-*


; Selects random attack pattern when player is close
