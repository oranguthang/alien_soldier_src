Boss_CaterpillarMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D0AE
                move.w  4(a5),d0
                movea.w off_3D0BE(pc,d0.w),a0
                adda.l  #Boss_CaterpillarInit,a0
                jmp     (a0)
; End of function Boss_CaterpillarMain
; ---------------------------------------------------------------------------
off_3D0BE:      dc.w    Boss_CaterpillarInit-Boss_CaterpillarInit
                                        ; DATA XREF: Boss_CaterpillarMain+4   r
                dc.w    Boss_CaterpillarAnimateWave-Boss_CaterpillarInit

; Initializes caterpillar boss entity
Boss_CaterpillarInit:                                   ; DATA XREF: Boss_CaterpillarMain+8   o  ; was: sub_3D0C2
                                        ; ROM:off_3D0BE   o
                addq.w  #2,4(a5)
                bra.w   Boss_CaterpillarInitSegments
; End of function Boss_CaterpillarInit
; Animates wave pattern for caterpillar movement
Boss_CaterpillarAnimateWave:                            ; DATA XREF: ROM:0003D0C0   o  ; was: sub_3D0CA
                addq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                move.w  $56(a5),d0
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$FFDA,d1
                moveq   #$A,d7
loc_3D0E2:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+1C   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                dbf     d7,loc_3D0E2
                subi.w  #$10,d0
                moveq   #3,d7
loc_3D0F0:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+28   j
                move.w  d0,(a0)+
                dbf     d7,loc_3D0F0
                add.w   d1,d0
                moveq   #$17,d7
loc_3D0FA:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+40   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                dbf     d7,loc_3D0FA
                moveq   #9,d7
loc_3D110:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+4A   j
                move.w  d0,(a0)+
                addq.w  #6,d0
                dbf     d7,loc_3D110
                move.w  (dword_FFA908).w,d0
                subi.w  #$200,d0
                subq.w  #1,d0
                andi.w  #$FFF0,d0
                asr.w   #3,d0
                addi.w  #-$6800,d0
                movea.w d0,a0
                movea.w #(dword_FF8A00-M68K_RAM),a1
                lea     (word_1B514).l,a2
                move.w  #$1FE,d2
                move.w  #$10,d3
                moveq   #$13,d7
loc_3D142:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+8A   j
                move.w  (a0)+,d0
                and.w   d2,d0
                move.w  (a2,d0.w),d1
                ext.l   d1
                asl.l   #6,d1
                swap    d1
                sub.w   d3,d1
                move.w  d1,(a1)+
                dbf     d7,loc_3D142
                rts
; End of function Boss_CaterpillarAnimateWave
; Initializes caterpillar body segments from table
Boss_CaterpillarInitSegments:                           ; CODE XREF: Boss_CaterpillarInit+4   j  ; was: sub_3D15A
                movea.w a5,a0
                lea     word_3D19A(pc),a1
                nop
                moveq   #0,d7
                bsr.s   Boss_CaterpillarInitSegment
                lea     $2A0(a0),a0
                moveq   #$D,d7
; End of function Boss_CaterpillarInitSegments
; Initializes single segment with sprite parameters
Boss_CaterpillarInitSegment:                            ; CODE XREF: Boss_CaterpillarInitSegments+A   p  ; was: sub_3D16C
                                        ; Boss_CaterpillarInitSegment+28   j
                lea     $60(a0),a0
                move.w  #$C300,$E(a0)
                clr.w   4(a0)
                move.w  #$4080,2(a0)
                clr.b   $21(a0)
                move.b  #$20,$20(a0)                    ; ' '
                move.w  (a1)+,(a0)
                move.w  (a1)+,$58(a0)
                move.w  (a1)+,$5A(a0)
                dbf     d7,Boss_CaterpillarInitSegment
                rts
; End of function Boss_CaterpillarInitSegment
; ---------------------------------------------------------------------------
word_3D19A:     dc.w    $288, $3D8, $28                 ; DATA XREF: Boss_CaterpillarInitSegments+2   o
                dc.w    $13C, $4D8, $48
                dc.w    $144, $518, $50
                dc.w    $13C, $558, $58
                dc.w    $13C, $5D8, $68
                dc.w    $13C, $658, $78
                dc.w    $144, $6D8, $88
                dc.w    $13C, $758, $98
                dc.w    $140, $7D8, $A8
                dc.w    $144, $818, $B0
                dc.w    $13C, $858, $B8
                dc.w    $144, $898, $C0
                dc.w    $140, $8D8, $C8
                dc.w    $144, $918, $D0
                dc.w    $140, $958, $D8

; Caterpillar part 2 with projectile firing
Boss_CaterpillarPart2:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D1F4
                tst.w   4(a5)
                bne.s   loc_3D23A
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.l  #word_EB5E6,8(a5)
                move.w  #$43,$24(a5)                    ; 'C'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #3,$4A(a5)
                clr.w   $4C(a5)
                clr.w   $54(a5)
loc_3D23A:                                              ; CODE XREF: Boss_CaterpillarPart2+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D246
                jmp     Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D246:                                              ; CODE XREF: Boss_CaterpillarPart2+4A   j
                bsr.w   Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0                         ; 'p'
                bpl.s   loc_3D260
                bset    #4,2(a5)
locret_3D25E:                                           ; CODE XREF: Boss_CaterpillarPart2+70   j
                                        ; Boss_CaterpillarPart2+76   j
                rts
; ---------------------------------------------------------------------------
loc_3D260:                                              ; CODE XREF: Boss_CaterpillarPart2+62   j
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
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$48(a5)
                move.w  #3,$4A(a5)
                move.w  #$FFF8,$54(a5)
                rts
; ---------------------------------------------------------------------------
loc_3D29C:                                              ; CODE XREF: Boss_CaterpillarPart2+88   j
                bsr.w   Boss_CaterpillarCheckFreeSlot
                bne.s   locret_3D25E
                move.w  $54(a5),d7
                addq.w  #8,d7
                andi.w  #$18,d7
                cmpi.w  #$18,d7
                bne.s   loc_3D2B4
                moveq   #8,d7
loc_3D2B4:                                              ; CODE XREF: Boss_CaterpillarPart2+BC   j
                move.w  d7,$54(a5)
                move.w  word_3D2E0(pc,d7.w),d6
                move.w  word_3D2E0+2(pc,d7.w),d0
                move.w  word_3D2E0+4(pc,d7.w),d1
                move.w  #$8000,d2
                jsr     (Enemy_InitHomingProjectile).l
                move.l  #$FFFEE000,$18(a0)
                subi.l  #$12000,$50(a0)
                rts
; End of function Boss_CaterpillarPart2
; ---------------------------------------------------------------------------
word_3D2E0:     dc.w    $C0, $FFF0, $E, 0, $80, 0, $10, 0, $40, $10, $E, 0
                                        ; DATA XREF: Boss_CaterpillarPart2+C4   r
                                        ; Boss_CaterpillarPart2+C8   r

; Caterpillar part 3 with attack patterns
Boss_CaterpillarPart3:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D2F8
                tst.w   4(a5)
                bne.s   loc_3D332
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$58,$24(a5)                    ; 'X'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #8,$4A(a5)
                clr.w   $4C(a5)
loc_3D332:                                              ; CODE XREF: Boss_CaterpillarPart3+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D33E
                jmp     Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D33E:                                              ; CODE XREF: Boss_CaterpillarPart3+3E   j
                bsr.w   Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0                         ; 'p'
                bpl.s   loc_3D358
                bset    #4,2(a5)
locret_3D356:                                           ; CODE XREF: Boss_CaterpillarPart3+64   j
                rts
; ---------------------------------------------------------------------------
loc_3D358:                                              ; CODE XREF: Boss_CaterpillarPart3+56   j
                tst.b   $21(a5)
                beq.s   locret_3D356
                subq.w  #1,$48(a5)
                bpl.s   loc_3D36A
                move.w  #$80,$48(a5)
loc_3D36A:                                              ; CODE XREF: Boss_CaterpillarPart3+6A   j
                move.w  (word_FFA000).w,d0
                andi.w  #$C,d0
                move.l  off_3D37A(pc,d0.w),8(a5)
                rts
; End of function Boss_CaterpillarPart3
; ---------------------------------------------------------------------------
off_3D37A:      dc.l    word_EB5B6                      ; DATA XREF: Boss_CaterpillarPart3+7A   r
                dc.l    word_EB5CE
                dc.l    word_EB5F2
                dc.l    word_EB5CE

; Caterpillar part 4 with animation states
Boss_CaterpillarPart4:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D38A
                tst.w   4(a5)
                bne.s   loc_3D3C4
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$6E,$24(a5)                    ; 'n'
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                move.w  d0,$48(a5)
                move.w  #8,$4A(a5)
                clr.w   $4C(a5)
loc_3D3C4:                                              ; CODE XREF: Boss_CaterpillarPart4+4   j
                tst.w   $24(a5)
                bpl.s   loc_3D3D0
                jmp     Boss_CaterpillarSpawnExplosion
; ---------------------------------------------------------------------------
loc_3D3D0:                                              ; CODE XREF: Boss_CaterpillarPart4+3E   j
                bsr.w   Boss_CaterpillarUpdateSegmentPos
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$70,d0                         ; 'p'
                bpl.s   loc_3D3EA
                bset    #4,2(a5)
locret_3D3E8:                                           ; CODE XREF: Boss_CaterpillarPart4+64   j
                rts
; ---------------------------------------------------------------------------
loc_3D3EA:                                              ; CODE XREF: Boss_CaterpillarPart4+56   j
                tst.b   $21(a5)
                beq.s   locret_3D3E8
                subq.w  #1,$48(a5)
                bpl.s   loc_3D3F8
                nop
loc_3D3F8:                                              ; CODE XREF: Boss_CaterpillarPart4+6A   j
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #4,d0
                move.l  off_3D40A(pc,d0.w),8(a5)
                rts
; End of function Boss_CaterpillarPart4
; ---------------------------------------------------------------------------
off_3D40A:      dc.l    word_EB60A                      ; DATA XREF: Boss_CaterpillarPart4+78   r
                dc.l    word_EB616

; Caterpillar part 1 entity with timer
Boss_CaterpillarPart1:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D412
                tst.w   4(a5)
                bne.s   loc_3D43E
                addq.w  #2,4(a5)
                move.b  #$80,$4E(a5)
                move.b  #$10,$23(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$1FF,$5C(a5)
                move.l  #word_EB622,8(a5)
loc_3D43E:                                              ; CODE XREF: Boss_CaterpillarPart1+4   j
                subq.w  #1,$5C(a5)
                bpl.w   Boss_CaterpillarUpdateSegmentPos
                move.w  #$294,(a5)
                clr.w   4(a5)
                rts
; End of function Boss_CaterpillarPart1
; Updates segment position with sine wave calculation
Boss_CaterpillarUpdateSegmentPos:                       ; CODE XREF: Boss_CaterpillarPart2:loc_3D246   p  ; was: sub_3D450
                                        ; sub_3D2F8:loc_3D33E   p
                move.w  $58(a5),d0
                sub.w   (dword_FFA908).w,d0
                move.w  d0,$10(a5)
                bset    #7,2(a5)
                move.b  $4E(a5),$21(a5)
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bmi.s   loc_3D478
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_3D482
loc_3D478:                                              ; CODE XREF: Boss_CaterpillarUpdateSegmentPos+1E   j
                bclr    #7,2(a5)
                clr.b   $21(a5)
loc_3D482:                                              ; CODE XREF: Boss_CaterpillarUpdateSegmentPos+26   j
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
Boss_CaterpillarCheckFreeSlot:                          ; CODE XREF: Boss_CaterpillarPart2:loc_3D29C   p  ; was: sub_3D4AC
                movea.w #(byte_FFD280-M68K_RAM),a0
                jmp     loc_1C0A4
; End of function Boss_CaterpillarCheckFreeSlot
; Shooting star entity with state machine
Boss_CaterpillarShootingStar:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D4B6
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
loc_3D4EC:                                              ; CODE XREF: Boss_CaterpillarShootingStar+1A   j
                                        ; Boss_CaterpillarShootingStar+22   j
                lea     (dword_FF9420).w,a0
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                move.w  #6,d7
loc_3D502:                                              ; CODE XREF: Boss_CaterpillarShootingStar+5C   j
                move.w  (dword_FF940C+2).w,d6
                subq.w  #1,d6
loc_3D508:                                              ; CODE XREF: Boss_CaterpillarShootingStar+58   j
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
loc_3D52A:                                              ; CODE XREF: Boss_CaterpillarShootingStar+8C   j
                lea     (a1,d6.w),a1
                move.w  (a1),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a0)
                move.w  2(a1),$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3D52A
loc_3D546:                                              ; CODE XREF: Boss_CaterpillarShootingStar+4   j
                move.w  4(a5),d0
                lea     off_3D552(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_CaterpillarShootingStar
; ---------------------------------------------------------------------------
off_3D552:      dc.w    Boss_CaterpillarShipInit-*      ; DATA XREF: Boss_CaterpillarShootingStar+94   o
                dc.w    Boss_CaterpillarShipState1-*
                dc.w    Boss_CaterpillarShipState2-*
                dc.w    Boss_CaterpillarRotateAndWait-*
                dc.w    Boss_CaterpillarRotationOnly-*
                dc.w    Boss_CaterpillarShipState3-*
                dc.w    Boss_CaterpillarShipState4-*
                dc.w    nullsub_79-*

; Initializes caterpillar ship with body parts
Boss_CaterpillarShipInit:                               ; DATA XREF: ROM:off_3D552   o  ; was: sub_3D562
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
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$10,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$24(a5)                    ; '('
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.w  #6,d7
                lea     $60(a5),a0
loc_3D5D4:                                              ; CODE XREF: Boss_CaterpillarShipInit+C8   j
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
                move.b  #$50,$21(a0)                    ; 'P'
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
loc_3D626:                                              ; CODE XREF: Boss_CaterpillarShipInit+AC   j
                lea     $60(a0),a0
                dbf     d7,loc_3D5D4
locret_3D62E:                                           ; CODE XREF: Boss_CaterpillarShipInit+4   j
                rts
; End of function Boss_CaterpillarShipInit
; Ship state 1 with rotation initialization
Boss_CaterpillarShipState1:                             ; DATA XREF: ROM:0003D554   o  ; was: sub_3D630
                bsr.w   Boss_CaterpillarUpdateRotation
                move.b  #$80,$23(a5)
                clr.b   (byte_FF80EC).w
                clr.w   $4A(a5)
                move.w  #$220,(dword_FF9408).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_CaterpillarShipState1
; Ship state 2 with altitude oscillation
Boss_CaterpillarShipState2:                             ; DATA XREF: ROM:0003D556   o  ; was: sub_3D654
                bsr.w   Boss_CaterpillarUpdateRotation
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
loc_3D67C:                                              ; CODE XREF: Boss_CaterpillarShipState2+18   j
                move.w  #$100,$48(a5)
                move.w  #$220,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_3D68A:                                              ; CODE XREF: Boss_CaterpillarShipState2+A   j
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   $21(a5)
                move.w  #$120,(dword_FF9408).w
                move.w  #$F0,(dword_FF9408+2).w
                bset    #1,$4C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_3D6B2:                                           ; CODE XREF: Boss_CaterpillarShipState2+10   j
                rts
; End of function Boss_CaterpillarShipState2
; Caterpillar boss rotation with timer-based state transition
Boss_CaterpillarRotateAndWait:                          ; DATA XREF: ROM:0003D558   o  ; was: sub_3D6B4
                bsr.w   Boss_CaterpillarUpdateRotation
                subq.w  #1,$48(a5)
                bne.s   locret_3D6D2
                move.w  #$40,(dword_FF9408).w           ; '@'
                move.w  #$80,(dword_FF9408+2).w
                addq.w  #2,4(a5)
                addq.w  #3,(dword_FF940C).w
locret_3D6D2:                                           ; CODE XREF: Boss_CaterpillarRotateAndWait+8   j
                rts
; End of function Boss_CaterpillarRotateAndWait
; Update only rotation for Caterpillar boss
Boss_CaterpillarRotationOnly:                           ; DATA XREF: ROM:0003D55A   o  ; was: sub_3D6D4
                bsr.w   Boss_CaterpillarUpdateRotation
                rts
; End of function Boss_CaterpillarRotationOnly
; Ship state 3 defeating boss sequence
Boss_CaterpillarShipState3:                             ; DATA XREF: ROM:0003D55C   o  ; was: sub_3D6DA
                bsr.w   Boss_CaterpillarUpdateRotation
                jsr     (Projectile_ExplodeOnImpact).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                andi.w  #$7FFF,2(a5)
                move.w  #$10,$48(a5)
                move.w  a5,$4A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_3D724
                move.w  #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_3D724:                                           ; CODE XREF: Boss_CaterpillarShipState3+32   j
                rts
; End of function Boss_CaterpillarShipState3
; Ship state 4 final defeat cleanup
Boss_CaterpillarShipState4:                             ; DATA XREF: ROM:0003D55E   o  ; was: sub_3D726
                bsr.w   Boss_CaterpillarUpdateRotation
                subq.w  #1,$48(a5)
                bne.s   locret_3D782
                movea.w $4A(a5),a0
                lea     $60(a0),a0
                move.l  #off_E953C,8(a0)
                jsr     (Projectile_InitType88).l
                lea     $2A0(a5),a1
                cmpa.w  a1,a0
                bhi.s   loc_3D784
                move.w  a0,$4A(a5)
                move.w  #$A,$48(a5)
                movea.w a0,a4
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_3D782
                move.w  #3,d0
                jsr     (loc_2BD20).l
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
locret_3D782:                                           ; CODE XREF: Boss_CaterpillarShipState4+8   j
                                        ; Boss_CaterpillarShipState4+3A   j
                rts
; ---------------------------------------------------------------------------
loc_3D784:                                              ; CODE XREF: Boss_CaterpillarShipState4+26   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_CaterpillarShipState4
nullsub_79:                                             ; DATA XREF: ROM:0003D560   o
                rts
; End of function nullsub_79

; Updates ship rotation with sine calculation
Boss_CaterpillarUpdateRotation:                         ; CODE XREF: Boss_CaterpillarShipState1   p  ; was: sub_3D78C
                                        ; sub_3D654   p
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3D7D8
                move.w  (dword_FF9408).w,d0
                sub.w   (dword_FFA900).w,d0
                move.w  (dword_FF9408+2).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
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
loc_3D7D2:                                              ; CODE XREF: Boss_CaterpillarUpdateRotation+3C   j
                move.w  #$FFF8,(dword_FF9400+2).w
loc_3D7D8:                                              ; CODE XREF: Boss_CaterpillarUpdateRotation+8   j
                                        ; Boss_CaterpillarUpdateRotation+36   j
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
