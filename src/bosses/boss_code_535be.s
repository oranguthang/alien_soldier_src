Boss_ValkirieForceAnimUpdate:                              ; CODE XREF: Boss_ValkirieForceInit:loc_535B2   p  ; was: sub_535BE
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_53636
loc_535C8:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+24   j
                                        ; Boss_ValkirieForceAnimUpdate+44   j
                move.w  $58(a5),d0
                bmi.w   loc_53646
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_535E4
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_535C8
; ---------------------------------------------------------------------------
loc_535E4:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_535F4
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_535F4:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_53604
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_535C8
; ---------------------------------------------------------------------------
loc_53604:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_53784,d0
                movea.l d0,a0
                bsr.w Anim_ValkirieForceCalculateDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_53646
loc_53636:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_53646:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+E   j
                                        ; Boss_ValkirieForceAnimUpdate+76   j
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
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Boss_ValkirieForceAnimUpdate
; Calculates animation interpolation deltas for Valkirie Force transformations
Anim_ValkirieForceCalculateDeltas:                              ; CODE XREF: Boss_ValkirieForceAnimUpdate+5C   p  ; was: sub_53758
                lea     (dword_355A4).l,a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Anim_ValkirieForceCalculateDeltas
; Loads frame delay data for Valkirie Force animations
Anim_ValkirieForceLoadDelays:
                moveq   #$12,d7  ; was: sub_5376E
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Anim_ValkirieForceLoadDelays
; ---------------------------------------------------------------------------
word_5377A:     dc.w $2020, 0, $2020, $12, $FFFF
                                        ; DATA XREF: Boss_ValkirieForceInit+80   o
word_53784:     dc.w $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000, $4000, $C094, $C010, $EC40, $F060, $F020, $2020
                                        ; DATA XREF: Boss_ValkirieForceAnimUpdate+54   o
                dc.w $10E0, $E000
word_537A8:     dc.w $C680, $C6E0, $C740, $C7A0, $C800, $C860, $C8C0, $C920
                                        ; DATA XREF: Boss_MissiraySegmentsSeparate+1A   o
                                        ; Boss_MissirayShootPattern2+A   o ...


; Main boss handler
Boss_MissirayMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_537B8
                tst.w   4(a5)
                beq.w   loc_538AE
                jsr (Gfx_InitPaletteFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4C(a5)
                btst    #2,(byte_FF80EC).w
                bne.s   loc_537FC
                btst    #1,(byte_FF80EC).w
                bne.w   loc_53826
                tst.w   (word_FF8200).w
                bne.s   loc_537FC
                move.b  #2,(byte_FF80EC).w
                move.w  #$1A,4(a5)
                bset    #0,(byte_FFA272).w
loc_537FC:                              ; CODE XREF: Boss_MissirayMain+20   j
                                        ; Boss_MissirayMain+30   j
                move.w  #7,d7
                lea     $60(a5),a0
                move.w  $4E(a5),d0
                tst.w   (dword_FF9404).w
                bne.s   loc_53812
                addq.w  #8,d0
                bra.s   loc_53814
; ---------------------------------------------------------------------------
loc_53812:                              ; CODE XREF: Boss_MissirayMain+54   j
                subq.w  #8,d0
loc_53814:                              ; CODE XREF: Boss_MissirayMain+58   j
                                        ; Boss_MissirayMain+6A   j
                move.w  $4C(a0),$14(a0)
                add.w   d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53814
loc_53826:                              ; CODE XREF: Boss_MissirayMain+28   j
                movea.l #$FFFFEC02,a1
                move.w  $14(a5),d1
                move.w  #3,d7
                lea     $60(a5),a0
loc_53838:                              ; CODE XREF: Boss_MissirayMain+A2   j
                move.w  (dword_FF9408).w,d0
                sub.w   $14(a0),d0
                cmpi.w  #$FF40,d0
                blt.s   loc_53852
                cmpi.w  #$30,d0 ; '0'
                bgt.s   loc_53852
                move.w  d0,(a1)
                move.w  d0,4(a1)
loc_53852:                              ; CODE XREF: Boss_MissirayMain+8C   j
                                        ; Boss_MissirayMain+92   j
                lea     8(a1),a1
                lea     $60(a0),a0
                dbf     d7,loc_53838
                move.w  (dword_FF9404+2).w,d0
                sub.w   $14(a5),d0
                cmpi.w  #$FF20,d0
                blt.s   loc_53880
                cmpi.w  #$30,d0 ; '0'
                bgt.s   loc_53880
                move.w  d0,(a1)
                move.w  d0,4(a1)
                move.w  d0,8(a1)
                move.w  d0,$C(a1)
loc_53880:                              ; CODE XREF: Boss_MissirayMain+B2   j
                                        ; Boss_MissirayMain+B8   j
                lea     $10(a1),a1
                move.w  #3,d7
loc_53888:                              ; CODE XREF: Boss_MissirayMain+F2   j
                move.w  (dword_FF9408).w,d0
                sub.w   $14(a0),d0
                cmpi.w  #$FF40,d0
                blt.s   loc_538A2
                cmpi.w  #$30,d0 ; '0'
                bgt.s   loc_538A2
                move.w  d0,(a1)
                move.w  d0,4(a1)
loc_538A2:                              ; CODE XREF: Boss_MissirayMain+DC   j
                                        ; Boss_MissirayMain+E2   j
                lea     8(a1),a1
                lea     $60(a0),a0
                dbf     d7,loc_53888
loc_538AE:                              ; CODE XREF: Boss_MissirayMain+4   j
                move.w  4(a5),d0
                lea     off_538BA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayMain
; ---------------------------------------------------------------------------
off_538BA:      dc.w Boss_MissirayDispatcher-*        ; DATA XREF: Boss_MissirayMain+FA   o
                dc.w Boss_MissirayIntroInit-*
                dc.w Boss_MissirayIntroMove-*
                dc.w Boss_MissirayIntroStop-*
                dc.w Boss_MissirayAttackState1-*
                dc.w Boss_MissirayAttackState2-*
                dc.w Boss_MissiraySegmentsInit-*
                dc.w Boss_MissiraySegmentsCheck-*
                dc.w Boss_MissirayCheckVictory-*
                dc.w Boss_MissirayWaitDefeatCheck-*
                dc.w Boss_MissirayResetCounters-*
                dc.w Boss_MissirayMainAttackLoop-*
                dc.w Boss_MissirayLoopAttacks-*
                dc.w Boss_MissirayDefeatInit-*
                dc.w Boss_MissirayDefeatExplosions-*
                dc.w Boss_MissirayGraphicsUpdate1-*
                dc.w Boss_MissirayGraphicsUpdate2-*
                dc.w Boss_MissirayGraphicsUpdate4-*
                dc.w Boss_MissirayGraphicsUpdate5-*
                dc.w Boss_MissirayGraphicsUpdate6-*
                dc.w Boss_MissirayGraphicsUpdate7-*
                dc.w Boss_MissirayCleanup-*


; Boss state dispatcher
Boss_MissirayDispatcher:                              ; DATA XREF: ROM:off_538BA   o  ; was: sub_538E6
                tst.b   (word_FFF720).w
                bmi.w   locret_53A18
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #$3D0,d0
                move.w  #$3E0,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #2,(byte_FFA95B).w
                clr.w   (dword_FF9404).w
                move.w  #$A0,(dword_FF9404+2).w
                move.w  #$B8,(dword_FF9408).w
                move.w  #$80,(dword_FF940C).w
                move.w  #$13,d7
                lea     (word_FFEC02).w,a0
                move.w  #$FF40,d0
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  d0,$10(a0)
                move.w  d0,$14(a0)
                move.w  d0,$18(a0)
                move.w  d0,$1C(a0)
                move.w  d0,$20(a0)
                move.w  d0,$24(a0)
                move.w  d0,$28(a0)
                move.w  d0,$2C(a0)
                move.w  d0,$30(a0)
                move.w  d0,$34(a0)
                move.w  d0,$38(a0)
                move.w  d0,$3C(a0)
                move.w  d0,$40(a0)
                move.w  d0,$44(a0)
                move.w  d0,$48(a0)
                move.w  d0,$4C(a0)
                move.w  #$120,$10(a5)
                move.w  #$170,$14(a5)
                move.w  $14(a5),$4E(a5)
                move.w  #$C80,2(a5)
                move.b  #$D0,$21(a5)
                move.b  #$88,$23(a5)
                move.w  #$C8,$26(a5)
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
                lea     (word_FFEC02).w,a1
loc_539CA:                              ; CODE XREF: Boss_MissirayDispatcher+12E   j
                move.w  #$3D4,(a0)
                move.w  #$C80,2(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$FE02F40C,$2C(a0)
                move.l  #$E818E818,$28(a0)
                move.w  #$64,$26(a0) ; 'd'
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.w   word_53A1A(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.w  word_53A2A(pc,d6.w),$4C(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_539CA
locret_53A18:                           ; CODE XREF: Boss_MissirayDispatcher+4   j
                rts
; End of function Boss_MissirayDispatcher
; ---------------------------------------------------------------------------
word_53A1A:     dc.w $FF70, $FF90, $FFB0, $FFD0, $30, $50, $70, $90
                                        ; DATA XREF: Boss_MissirayDispatcher+11A   r
word_53A2A:     dc.w $40, $30, $20, $10, $10, $20, $30, $40
                                        ; DATA XREF: Boss_MissirayDispatcher+122   r


; Loads first tile set for Missiray boss via DMA transfer
Gfx_MissirayLoadTilesSet1:                              ; CODE XREF: Boss_MissirayAttackPattern4Wait1+E   j  ; was: sub_53A3A
                lea     word_53A46(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Gfx_MissirayLoadTilesSet1
; ---------------------------------------------------------------------------
word_53A46:     dc.w $6020, $2000, $102, $6162, $6566, $696A
                                        ; DATA XREF: Gfx_MissirayLoadTilesSet1   o


; Loads second tile set for Missiray boss via DMA transfer
Gfx_MissirayLoadTilesSet2:                              ; CODE XREF: Boss_MissirayAttackPattern5Wait1+E   j  ; was: sub_53A52
                lea     word_53A5E(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Gfx_MissirayLoadTilesSet2
; ---------------------------------------------------------------------------
word_53A5E:     dc.w $6020, $2000, $102, $6D6E, $7172, $7576
                                        ; DATA XREF: Gfx_MissirayLoadTilesSet2   o


; Load boss tiles 1
Boss_MissirayLoadTiles1:                              ; CODE XREF: Boss_MissirayGraphicsUpdate4+A   p  ; was: sub_53A6A
                lea     word_53A76(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Boss_MissirayLoadTiles1
; ---------------------------------------------------------------------------
word_53A76:     dc.w $6020, $2000, $102, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles1   o


; Intro animation init
Boss_MissirayIntroInit:                              ; DATA XREF: ROM:000538BC   o  ; was: sub_53A82
                tst.b   (word_FFF720).w
                bmi.s   locret_53A8E
                addq.w  #2,4(a5)
                bsr.s Boss_MissirayBattleStart
locret_53A8E:                           ; CODE XREF: Boss_MissirayIntroInit+4   j
                rts
; End of function Boss_MissirayIntroInit
; Battle start initialization
Boss_MissirayBattleStart:                              ; CODE XREF: Boss_MissirayIntroInit+A   p  ; was: sub_53A90
                                        ; Boss_MissirayAttackPattern4Wait2+E   j
                lea     word_53A9C(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_MissirayBattleStart
; ---------------------------------------------------------------------------
word_53A9C:     dc.w $6200, $2000, $301, $6060, $6060, $6464, $6464
                                        ; DATA XREF: Boss_MissirayBattleStart   o


; Loads first compressed tile set for Missiray boss battle start
Gfx_MissirayLoadCompressedSet1:                              ; CODE XREF: Boss_MissirayAttackPattern5Wait2+E   j  ; was: sub_53AAA
                lea     word_53AB6(pc),a0
                nop
; End of function Gfx_MissirayLoadCompressedSet1
; Attributes: thunk
; Thunk function that jumps to compressed tile loader
Gfx_LoadCompressedTilesThunk:
                jmp Gfx_LoadCompressedTiles  ; was: sub_53AB0
; End of function Gfx_LoadCompressedTilesThunk
; ---------------------------------------------------------------------------
word_53AB6:     dc.w $6200, $2000, $301, $6868, $6868, $6C6C, $6C6C
                                        ; DATA XREF: Gfx_MissirayLoadCompressedSet1   o


; Load boss tiles 2
Boss_MissirayLoadTiles2:                              ; CODE XREF: Boss_MissirayGraphicsUpdate5+A   p  ; was: sub_53AC4
                lea     word_53AD0(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_MissirayLoadTiles2
; ---------------------------------------------------------------------------
word_53AD0:     dc.w $6200, $2000, $301, 0, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles2   o


; Intro movement
Boss_MissirayIntroMove:                              ; DATA XREF: ROM:000538BE   o  ; was: sub_53ADE
                tst.b   (word_FFF720).w
                bmi.s   locret_53AEA
                addq.w  #2,4(a5)
                bsr.s Boss_MissirayIdleState
locret_53AEA:                           ; CODE XREF: Boss_MissirayIntroMove+4   j
                rts
; End of function Boss_MissirayIntroMove
; Idle state handler
Boss_MissirayIdleState:                              ; CODE XREF: Boss_MissirayIntroMove+A   p  ; was: sub_53AEC
                                        ; Boss_MissirayAttackPattern4Wait3+E   p
                lea     word_53AF8(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_MissirayIdleState
; ---------------------------------------------------------------------------
word_53AF8:     dc.w $6230, $2000, $301, $6363, $6363, $6767, $6767
                                        ; DATA XREF: Boss_MissirayIdleState   o


; Loads second compressed tile set for Missiray idle state
Gfx_MissirayLoadCompressedSet2:                              ; CODE XREF: Boss_MissirayAttackPattern5Wait3+E   p  ; was: sub_53B06
                lea     word_53B12(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_MissirayLoadCompressedSet2
; ---------------------------------------------------------------------------
word_53B12:     dc.w $6230, $2000, $301, $6B6B, $6B6B, $6F6F, $6F6F
                                        ; DATA XREF: Gfx_MissirayLoadCompressedSet2   o


; Load boss tiles 3
Boss_MissirayLoadTiles3:                              ; CODE XREF: Boss_MissirayGraphicsUpdate6+A   p  ; was: sub_53B20
                lea     word_53B2C(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_MissirayLoadTiles3
; ---------------------------------------------------------------------------
word_53B2C:     dc.w $6230, $2000, $301, 0, 0, 0, 0
                                        ; DATA XREF: Boss_MissirayLoadTiles3   o


; Intro stop position
Boss_MissirayIntroStop:                              ; DATA XREF: ROM:000538C0   o  ; was: sub_53B3A
                tst.b   (word_FFF720).w
                bmi.s   locret_53B5A
                addq.w  #2,4(a5)
                lea     word_53B50(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
word_53B50:     dc.w $6020, $2000, $101, $6162, $6566
                                        ; DATA XREF: Boss_MissirayIntroStop+A   o
; ---------------------------------------------------------------------------
locret_53B5A:                           ; CODE XREF: Boss_MissirayIntroStop+4   j
                rts
; End of function Boss_MissirayIntroStop
; Attack state 1 handler
Boss_MissirayAttackState1:                              ; DATA XREF: ROM:000538C2   o  ; was: sub_53B5C
                subq.w  #1,$14(a5)
                move.w  $14(a5),$4E(a5)
                cmpi.w  #$178,$14(a5)
                bgt.s   locret_53B86
                addq.w  #2,4(a5)
                lea     word_53B7E(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_53B7E:     dc.w $6420, $2000, $100, $696A
                                        ; DATA XREF: Boss_MissirayAttackState1+16   o
; ---------------------------------------------------------------------------
locret_53B86:                           ; CODE XREF: Boss_MissirayAttackState1+10   j
                rts
; End of function Boss_MissirayAttackState1
; Attack state 2 handler
Boss_MissirayAttackState2:                              ; DATA XREF: ROM:000538C4   o  ; was: sub_53B88
                subq.w  #1,$14(a5)
                move.w  $14(a5),$4E(a5)
                cmpi.w  #$150,$14(a5)
                bhi.s   locret_53BB0
                move.w  #$150,$14(a5)
                move.w  #4,$4A(a5)
                move.w  #1,$48(a5)
                addq.w  #2,4(a5)
locret_53BB0:                           ; CODE XREF: Boss_MissirayAttackState2+10   j
                rts
; End of function Boss_MissirayAttackState2
; Initialize 8 segments
Boss_MissiraySegmentsInit:                              ; DATA XREF: ROM:000538C6   o  ; was: sub_53BB2
                move.w  #7,d7
                lea     $60(a5),a0
loc_53BBA:                              ; CODE XREF: Boss_MissiraySegmentsInit+1A   j
                clr.w   $4E(a0)
                move.b  #1,$50(a0)
                addq.w  #2,4(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53BBA
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissiraySegmentsInit
; Separates Missiray boss segments with timed delays between each segment pair
Boss_MissiraySegmentsSeparate:
                subq.w  #1,$48(a5)  ; was: sub_53BD6
                bne.s   locret_53C2E
                subq.w  #1,$4A(a5)
                bmi.s   loc_53C2A
                move.w  $4A(a5),d5
                lsl.w   #2,d5
                move.w  word_53C30(pc,d5.w),d0
                move.w  word_53C30+2(pc,d5.w),d1
                lea     word_537A8(pc),a1
                movea.w (a1,d0.w),a2
                movea.w (a1,d1.w),a3
                move.w  $14(a5),d0
                move.w  $4E(a5),d1
                sub.w   d1,d0
                move.w  d0,$4E(a2)
                move.b  #1,$50(a2)
                addq.w  #2,4(a2)
                move.w  d0,$4E(a3)
                move.b  #1,$50(a3)
                addq.w  #2,4(a3)
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_53C2A:                              ; CODE XREF: Boss_MissiraySegmentsSeparate+A   j
                addq.w  #2,4(a5)
locret_53C2E:                           ; CODE XREF: Boss_MissiraySegmentsSeparate+4   j
                rts
; End of function Boss_MissiraySegmentsSeparate
; ---------------------------------------------------------------------------
word_53C30:     dc.w 0, $E, 2, $C, 4, $A, 6, 8
                                        ; DATA XREF: Boss_MissiraySegmentsSeparate+12   r
                                        ; Boss_MissiraySegmentsSeparate+16   r


; Check segments ready
Boss_MissiraySegmentsCheck:                              ; DATA XREF: ROM:000538C8   o  ; was: sub_53C40
                move.w  #7,d7
                lea     $60(a5),a0
loc_53C48:                              ; CODE XREF: Boss_MissiraySegmentsCheck+12   j
                tst.b   $52(a0)
                bne.s   locret_53C78
                lea     $60(a0),a0
                dbf     d7,loc_53C48
                move.w  #7,d7
                lea     $60(a5),a0
loc_53C5E:                              ; CODE XREF: Boss_MissiraySegmentsCheck+2A   j
                clr.w   $4C(a0)
                clr.w   $4E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_53C5E
                move.w  $14(a5),$4E(a5)
                addq.w  #2,4(a5)
locret_53C78:                           ; CODE XREF: Boss_MissiraySegmentsCheck+C   j
                rts
; End of function Boss_MissiraySegmentsCheck
; Check victory condition
Boss_MissirayCheckVictory:                              ; DATA XREF: ROM:000538CA   o  ; was: sub_53C7A
                move.w  #3,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissirayCheckVictory
; Wait for defeat check
Boss_MissirayWaitDefeatCheck:                              ; DATA XREF: ROM:000538CC   o  ; was: sub_53C8A
                tst.w   (word_FF80C2).w
                bne.s   locret_53C98
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
locret_53C98:                           ; CODE XREF: Boss_MissirayWaitDefeatCheck+4   j
                rts
; End of function Boss_MissirayWaitDefeatCheck
; Reset attack counters
Boss_MissirayResetCounters:                              ; DATA XREF: ROM:000538CE   o  ; was: sub_53C9A
                clr.w   (dword_FF9400).w
                addq.w  #2,4(a5)
                move.w  #0,(dword_FF9400+2).w
                rts
; End of function Boss_MissirayResetCounters
; Main attack loop handler
Boss_MissirayMainAttackLoop:                              ; DATA XREF: ROM:000538D0   o  ; was: sub_53CAA
                bsr.w Boss_MissirayCheckPlayerProximity
                move.w  (dword_FF9400+2).w,d0
                lea     off_53CBA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayMainAttackLoop
; ---------------------------------------------------------------------------
off_53CBA:      dc.w Boss_MissirayUpdatePalette-*        ; DATA XREF: Boss_MissirayMainAttackLoop+8   o
                dc.w Boss_MissirayAttackPattern3-*
                dc.w Boss_MissirayAttack1Dispatcher-*
                dc.w Boss_MissirayAttack2Dispatcher-*
                dc.w Boss_MissirayAttackPattern5Dispatcher-*
                dc.w Boss_MissirayUpdatePalette-*
                dc.w Boss_MissirayUpdatePalette-*
                dc.w Boss_MissirayAttack2Dispatcher-*
                dc.w Boss_MissirayAttackPattern4Dispatcher-*


; Loop through attacks
Boss_MissirayLoopAttacks:                              ; DATA XREF: ROM:000538D2   o  ; was: sub_53CCC
                subq.w  #2,4(a5)
                addq.w  #2,(dword_FF9400+2).w
                cmpi.w  #$12,(dword_FF9400+2).w
                bne.s   locret_53CE0
                clr.w   (dword_FF9400+2).w
locret_53CE0:                           ; CODE XREF: Boss_MissirayLoopAttacks+E   j
                rts
; End of function Boss_MissirayLoopAttacks
; Defeat sequence init
Boss_MissirayDefeatInit:                              ; DATA XREF: ROM:000538D4   o  ; was: sub_53CE2
                clr.b   $21(a5)
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
loc_53CF0:                              ; CODE XREF: Boss_MissirayDefeatInit+28   j
                clr.b   $21(a0)
                clr.w   4(a0)
                move.b  #2,$50(a0)
                move.w  word_53D1A(pc,d6.w),$48(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_53CF0
                addq.w  #2,4(a5)
                move.w  #$50,$48(a5) ; 'P'
                rts
; End of function Boss_MissirayDefeatInit
; ---------------------------------------------------------------------------
word_53D1A:     dc.w $40, $30, $20, $10, $10, $20, $30, $40
                                        ; DATA XREF: Boss_MissirayDefeatInit+1C   r


; Defeat explosion effects
Boss_MissirayDefeatExplosions:                              ; DATA XREF: ROM:000538D6   o  ; was: sub_53D2A
                jsr (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_53D4E
                addq.w  #2,4(a5)
                tst.w   (dword_FF9404).w
                bne.s   locret_53D4E
                tst.w   (dword_FF9408+2).w
                bne.s   locret_53D4E
                move.l  #$FFFE0000,$1C(a5)
locret_53D4E:                           ; CODE XREF: Boss_MissirayDefeatExplosions+A   j
                                        ; Boss_MissirayDefeatExplosions+14   j ...
                rts
; End of function Boss_MissirayDefeatExplosions
; Graphics update handler 1
Boss_MissirayGraphicsUpdate1:                              ; DATA XREF: ROM:000538D8   o  ; was: sub_53D50
                jsr (Boss_SpawnExplosionDebris).l
                addi.l  #$800,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_53D78
                cmpi.l  #$10000,$1C(a5)
                blt.s   locret_53D78
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_53D78:                           ; CODE XREF: Boss_MissirayGraphicsUpdate1+14   j
                                        ; Boss_MissirayGraphicsUpdate1+1E   j
                rts
; End of function Boss_MissirayGraphicsUpdate1
; Graphics update handler 2
Boss_MissirayGraphicsUpdate2:                              ; DATA XREF: ROM:000538DA   o  ; was: sub_53D7A
                jsr (Boss_SpawnExplosionDebris).l
                bsr.s Boss_MissirayGraphicsUpdate3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_53DB6
                btst    #1,(word_FFA000+1).w
                bne.s   locret_53DB6
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_53DB6
                move.w  #$3D0,d0
                move.w  #$3E0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
locret_53DB6:                           ; CODE XREF: Boss_MissirayGraphicsUpdate2+E   j
                                        ; Boss_MissirayGraphicsUpdate2+16   j ...
                rts
; End of function Boss_MissirayGraphicsUpdate2
; Graphics update handler 3
Boss_MissirayGraphicsUpdate3:                              ; CODE XREF: Boss_MissirayGraphicsUpdate2+6   p  ; was: sub_53DB8
                                        ; sub_53DD4   p ...
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_MissirayGraphicsUpdate3
; Graphics update handler 4
Boss_MissirayGraphicsUpdate4:                              ; DATA XREF: ROM:000538DC   o  ; was: sub_53DD4
                bsr.w Boss_MissirayGraphicsUpdate3
                subq.w  #1,$4A(a5)
                bne.s   locret_53DE6
                bsr.w Boss_MissirayLoadTiles1
                addq.w  #2,4(a5)
locret_53DE6:                           ; CODE XREF: Boss_MissirayGraphicsUpdate4+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate4
; Graphics update handler 5
Boss_MissirayGraphicsUpdate5:                              ; DATA XREF: ROM:000538DE   o  ; was: sub_53DE8
                bsr.w Boss_MissirayGraphicsUpdate3
                tst.b   (word_FFF720).w
                bmi.s   locret_53DFA
                bsr.w Boss_MissirayLoadTiles2
                addq.w  #2,4(a5)
locret_53DFA:                           ; CODE XREF: Boss_MissirayGraphicsUpdate5+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate5
; Graphics update handler 6
Boss_MissirayGraphicsUpdate6:                              ; DATA XREF: ROM:000538E0   o  ; was: sub_53DFC
                bsr.w Boss_MissirayGraphicsUpdate3
                tst.b   (word_FFF720).w
                bmi.s   locret_53E0E
                bsr.w Boss_MissirayLoadTiles3
                addq.w  #2,4(a5)
locret_53E0E:                           ; CODE XREF: Boss_MissirayGraphicsUpdate6+8   j
                rts
; End of function Boss_MissirayGraphicsUpdate6
; Graphics update handler 7
Boss_MissirayGraphicsUpdate7:                              ; DATA XREF: ROM:000538E2   o  ; was: sub_53E10
                bsr.s Boss_MissirayGraphicsUpdate3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_53E30
                btst    #1,(word_FFA000+1).w
                bne.s   locret_53E30
                subq.w  #1,$48(a5)
                tst.w   $48(a5)
                bne.s   locret_53E30
                addq.w  #2,4(a5)
locret_53E30:                           ; CODE XREF: Boss_MissirayGraphicsUpdate7+8   j
                                        ; Boss_MissirayGraphicsUpdate7+10   j ...
                rts
; End of function Boss_MissirayGraphicsUpdate7
; Cleanup after defeat
Boss_MissirayCleanup:                              ; DATA XREF: ROM:000538E4   o  ; was: sub_53E32
                move.w  #$1000,2(a5)
                clr.w   (a5)
                rts
; End of function Boss_MissirayCleanup
; Reset attack state
Boss_MissirayResetAttackState:                              ; CODE XREF: Boss_MissirayAttackDelay:loc_53F58   j  ; was: sub_53E3C
                                        ; sub_53F70:loc_53F86   j ...
                clr.w   (dword_FF9400).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_MissirayResetAttackState
; Update boss palette
Boss_MissirayUpdatePalette:                              ; DATA XREF: ROM:off_53CBA   o  ; was: sub_53E46
                                        ; ROM:00053CC4   o ...
                bsr.s Boss_MissirayAttackDispatcher
                tst.w   (dword_FF9404).w
                beq.s   locret_53E5E
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                move.w  word_53E60(pc,d0.w),(word_FFE37E).w
locret_53E5E:                           ; CODE XREF: Boss_MissirayUpdatePalette+6   j
                rts
; End of function Boss_MissirayUpdatePalette
; ---------------------------------------------------------------------------
word_53E60:     dc.w $EEE, $E0E, $EEE, $E0
                                        ; DATA XREF: Boss_MissirayUpdatePalette+12   r


; Attack pattern dispatcher
Boss_MissirayAttackDispatcher:                              ; CODE XREF: Boss_MissirayUpdatePalette   p  ; was: sub_53E68
                move.w  (dword_FF9400).w,d0
                lea     off_53E74(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackDispatcher
; ---------------------------------------------------------------------------
off_53E74:      dc.w Boss_MissirayWaitSegmentsReady-*        ; DATA XREF: Boss_MissirayAttackDispatcher+4   o
                dc.w Boss_MissirayShootPattern1-*
                dc.w Boss_MissirayShootPattern2-*
                dc.w Boss_MissirayAttackDelay-*


; Wait for segments ready
Boss_MissirayWaitSegmentsReady:                              ; DATA XREF: ROM:off_53E74   o  ; was: sub_53E7C
                move.w  #7,d7
                lea     $60(a5),a0
                movea.w #(dword_FF9414-M68K_RAM),a1
loc_53E88:                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+16   j
                tst.b   $52(a0)
                bne.s   locret_53EBC
                lea     $60(a0),a0
                dbf     d7,loc_53E88
                addq.w  #2,(dword_FF9400).w
                tst.w   (dword_FF9404).w
                bne.s   loc_53EA8
                move.w  #8,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_53EA8:                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+22   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_53EB6
                move.w  #4,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_53EB6:                              ; CODE XREF: Boss_MissirayWaitSegmentsReady+30   j
                move.w  #8,$4A(a5)
locret_53EBC:                           ; CODE XREF: Boss_MissirayWaitSegmentsReady+10   j
                rts
; End of function Boss_MissirayWaitSegmentsReady
; Shooting pattern 1
Boss_MissirayShootPattern1:                              ; DATA XREF: ROM:00053E76   o  ; was: sub_53EBE
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_53ED4
                move.w  #$10,(a0)
                move.w  a0,(dword_FF9414).w
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_53ED4:                              ; CODE XREF: Boss_MissirayShootPattern1+6   j
                addq.w  #4,(dword_FF9400).w
                move.w  #8,$48(a5)
                rts
; End of function Boss_MissirayShootPattern1
; Shooting pattern 2
Boss_MissirayShootPattern2:                              ; DATA XREF: ROM:00053E78   o  ; was: sub_53EE0
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                lea     word_537A8(pc),a2
                movea.w (a2,d0.w),a0
                tst.b   $52(a0)
                bne.s   locret_53F42
                tst.w   (dword_FF9404).w
                bne.s   loc_53F10
                move.b  #0,$51(a0)
                clr.w   $48(a0)
                move.w  #$20,$48(a5) ; ' '
                bra.s   loc_53F2E
; ---------------------------------------------------------------------------
loc_53F10:                              ; CODE XREF: Boss_MissirayShootPattern2+1C   j
                move.b  #1,$51(a0)
                clr.w   $48(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_53F28
                move.w  #$60,$48(a5) ; '`'
                bra.s   loc_53F2E
; ---------------------------------------------------------------------------
loc_53F28:                              ; CODE XREF: Boss_MissirayShootPattern2+3E   j
                move.w  #$30,$48(a5) ; '0'
loc_53F2E:                              ; CODE XREF: Boss_MissirayShootPattern2+2E   j
                                        ; Boss_MissirayShootPattern2+46   j
                move.b  #0,$50(a0)
                move.w  (dword_FF9414).w,$54(a0)
                addq.w  #2,4(a0)
                addq.w  #2,(dword_FF9400).w
locret_53F42:                           ; CODE XREF: Boss_MissirayShootPattern2+16   j
                rts
; End of function Boss_MissirayShootPattern2
; Attack delay timer
Boss_MissirayAttackDelay:                              ; DATA XREF: ROM:00053E7A   o  ; was: sub_53F44
                subq.w  #1,$48(a5)
                bne.s   locret_53F56
                subq.w  #1,$4A(a5)
                beq.w   loc_53F58
                subq.w  #4,(dword_FF9400).w
locret_53F56:                           ; CODE XREF: Boss_MissirayAttackDelay+4   j
                rts
; ---------------------------------------------------------------------------
loc_53F58:                              ; CODE XREF: Boss_MissirayAttackDelay+A   j
                bra.w Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackDelay
; Attack pattern 3 dispatcher
Boss_MissirayAttackPattern3:                              ; DATA XREF: ROM:00053CBC   o  ; was: sub_53F5C
                move.w  (dword_FF9400).w,d0
                lea     off_53F68(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern3
; ---------------------------------------------------------------------------
off_53F68:      dc.w Boss_MissirayAttackPattern3Init-*        ; DATA XREF: Boss_MissirayAttackPattern3+4   o
                dc.w Boss_MissirayAttackPattern3Init_SpawnRing-*
                dc.w Boss_MissirayAttackPattern3Fire-*
                dc.w Boss_MissirayAttackPattern3Delay-*


; Attack pattern 3 init
Boss_MissirayAttackPattern3Init:                              ; DATA XREF: ROM:off_53F68   o  ; was: sub_53F70
                move.w  #3,$4A(a5)
                addq.w  #2,(dword_FF9400).w
; Spawn bullet ring and advance attack state
Boss_MissirayAttackPattern3Init_SpawnRing:                              ; DATA XREF: ROM:00053F6A   o  ; was: loc_53F7A
                bsr.w Boss_MissiraySpawnBulletRing
                bne.s   loc_53F86
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_53F86:                              ; CODE XREF: Boss_MissirayAttackPattern3Init+E   j
                bra.w Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackPattern3Init
nullsub_123:
                rts
; End of function nullsub_123


; Attack pattern 3 fire
Boss_MissirayAttackPattern3Fire:                              ; DATA XREF: ROM:00053F6C   o  ; was: sub_53F8C
                move.w  $4A(a5),d5
                lsl.w   #2,d5
                move.w  word_53FF6(pc,d5.w),d0
                move.w  word_53FF6+2(pc,d5.w),d1
                lea     word_537A8(pc),a1
                movea.w (a1,d0.w),a2
                tst.b   $52(a2)
                bne.s   locret_53FF4
                movea.w (a1,d1.w),a3
                tst.b   $52(a3)
                bne.s   locret_53FF4
                lea     (dword_FF9414).w,a0
                move.b  #0,$50(a2)
                move.b  #0,$51(a2)
                clr.w   $48(a2)
                move.w  (a0,d5.w),$54(a2)
                addq.w  #2,4(a2)
                move.b  #0,$50(a3)
                move.b  #0,$51(a3)
                clr.w   $48(a3)
                move.w  2(a0,d5.w),$54(a3)
                addq.w  #2,4(a3)
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,(dword_FF9400).w
locret_53FF4:                           ; CODE XREF: Boss_MissirayAttackPattern3Fire+1A   j
                                        ; Boss_MissirayAttackPattern3Fire+24   j
                rts
; End of function Boss_MissirayAttackPattern3Fire
; ---------------------------------------------------------------------------
word_53FF6:     dc.w 0, 4, $A, $E, 2, 6, 8, $C
                                        ; DATA XREF: Boss_MissirayAttackPattern3Fire+6   r
                                        ; Boss_MissirayAttackPattern3Fire+A   r


; Attack pattern 3 delay
Boss_MissirayAttackPattern3Delay:                              ; DATA XREF: ROM:00053F6E   o  ; was: sub_54006
                subq.w  #1,$48(a5)
                bne.s   locret_54016
                subq.w  #1,$4A(a5)
                bmi.s   loc_54018
                subq.w  #2,(dword_FF9400).w
locret_54016:                           ; CODE XREF: Boss_MissirayAttackPattern3Delay+4   j
                rts
; ---------------------------------------------------------------------------
loc_54018:                              ; CODE XREF: Boss_MissirayAttackPattern3Delay+A   j
                bra.w Boss_MissirayResetAttackState
; End of function Boss_MissirayAttackPattern3Delay
nullsub_124:
                rts
; End of function nullsub_124


; Dispatcher for Missiray bullet ring attack pattern state machine
Boss_MissirayAttack1Dispatcher:                              ; DATA XREF: ROM:00053CBE   o  ; was: sub_5401E
                move.w  (dword_FF9400).w,d0
                lea     off_5402A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttack1Dispatcher
; ---------------------------------------------------------------------------
off_5402A:      dc.w Boss_MissirayAttack1Init-*        ; DATA XREF: Boss_MissirayAttack1Dispatcher+4   o
                dc.w Boss_MissirayAttack1Init_SpawnBullets-*
                dc.w Boss_MissirayAttack1WaitBullets-*
                dc.w Boss_MissirayAttack1SetupDelays-*
                dc.w Boss_MissirayAttack1SetWaitTimer-*
                dc.w Boss_MissirayAttack1WaitTimer-*
                dc.w Boss_MissirayAttack1Loop-*


; Initializes bullet ring attack and spawns first ring of projectiles
Boss_MissirayAttack1Init:                              ; DATA XREF: ROM:off_5402A   o  ; was: sub_54038
                move.w  #1,$4A(a5)
                addq.w  #2,(dword_FF9400).w
; Spawn bullet ring for attack pattern 1
Boss_MissirayAttack1Init_SpawnBullets:                              ; DATA XREF: ROM:0005402C   o  ; was: loc_54042
                bsr.w Boss_MissiraySpawnBulletRing
                bne.s   loc_5404E
                addq.w  #2,(dword_FF9400).w
                rts
; ---------------------------------------------------------------------------
loc_5404E:                              ; CODE XREF: Boss_MissirayAttack1Init+E   j
                addi.w  #$A,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1Init
; Waits for all 8 bullet segments to become inactive before proceeding
Boss_MissirayAttack1WaitBullets:                              ; DATA XREF: ROM:0005402E   o  ; was: sub_54056
                move.w  #7,d7
                lea     $60(a5),a0
                movea.w #(dword_FF9414-M68K_RAM),a1
loc_54062:                              ; CODE XREF: Boss_MissirayAttack1WaitBullets+16   j
                tst.b   $52(a0)
                bne.s   locret_54074
                lea     $60(a0),a0
                dbf     d7,loc_54062
                addq.w  #2,(dword_FF9400).w
locret_54074:                           ; CODE XREF: Boss_MissirayAttack1WaitBullets+10   j
                rts
; End of function Boss_MissirayAttack1WaitBullets
; Sets up randomized delay timers for 8 bullet segments to fire
Boss_MissirayAttack1SetupDelays:                              ; DATA XREF: ROM:00054030   o  ; was: sub_54076
                movea.w #(dword_FF9414-M68K_RAM),a1
                lea     word_540C2(pc),a2
                nop
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                lsl.w   #4,d0
                lea     (a2,d0.w),a2
                move.w  #7,d7
                moveq   #0,d6
                lea     $60(a5),a0
loc_54098:                              ; CODE XREF: Boss_MissirayAttack1SetupDelays+42   j
                move.b  #0,$50(a0)
                move.b  #0,$51(a0)
                move.w  (a2,d6.w),$48(a0)
                move.w  (a1)+,$54(a0)
                addq.w  #2,4(a0)
                addq.w  #2,d6
                lea     $60(a0),a0
                dbf     d7,loc_54098
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1SetupDelays
; ---------------------------------------------------------------------------
word_540C2:     dc.w 0, $10, $20, $30, $40, $50, $60, $70, $70, $60, $50, $40, $30, $20, $10, 0
                                        ; DATA XREF: Boss_MissirayAttack1SetupDelays+4   o
                dc.w 0, $20, $40, $60, $60, $40, $20, 0, $60, $40, $20, 0, 0, $20, $40, $60


; Sets wait timer to $80 frames before bullet firing sequence
Boss_MissirayAttack1SetWaitTimer:                              ; DATA XREF: ROM:00054032   o  ; was: sub_54102
                move.w  #$80,$48(a5)
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1SetWaitTimer
; Waits for timer countdown then advances to next attack state
Boss_MissirayAttack1WaitTimer:                              ; DATA XREF: ROM:00054034   o  ; was: sub_5410E
                subq.w  #1,$48(a5)
                bne.s   locret_54118
                addq.w  #2,(dword_FF9400).w
locret_54118:                           ; CODE XREF: Boss_MissirayAttack1WaitTimer+4   j
                rts
; End of function Boss_MissirayAttack1WaitTimer
; Decrements attack repetition counter and loops or resets attack state
Boss_MissirayAttack1Loop:                              ; DATA XREF: ROM:00054036   o  ; was: sub_5411A
                subq.w  #1,$4A(a5)
                beq.w Boss_MissirayResetAttackState
                move.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttack1Loop
; Dispatcher for Missiray wave attack pattern state machine
Boss_MissirayAttack2Dispatcher:                              ; DATA XREF: ROM:00053CC0   o  ; was: sub_5412A
                                        ; ROM:00053CC8   o
                move.w  (dword_FF9400).w,d0
                lea     off_54136(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttack2Dispatcher
; ---------------------------------------------------------------------------
off_54136:      dc.w Boss_MissirayAttack2Init-*        ; DATA XREF: Boss_MissirayAttack2Dispatcher+4   o
                dc.w Boss_MissirayAttack2Init_FadeLoop-*
                dc.w Boss_MissirayShuffleSegmentOrder-*
                dc.w Boss_MissirayActivateNextSegment-*
                dc.w Boss_MissiraySegmentActivationDelay-*
                dc.w Boss_MissirayMoveHorizontal-*
                dc.w Boss_MissirayFinishSegmentPattern-*


; Initializes wave attack with rotating segment setup and angle initialization
Boss_MissirayAttack2Init:                              ; DATA XREF: ROM:off_54136   o  ; was: sub_54144
                bset    #4,$23(a5)
                clr.w   (dword_FF940C+2).w
                move.w  #$8000,(dword_FF9410+2).w
                addq.w  #2,(dword_FF9400).w
; Execute palette fade during attack 2 initialization
Boss_MissirayAttack2Init_FadeLoop:                              ; DATA XREF: ROM:00054138   o  ; was: loc_54158
                bsr.w Gfx_ApplyPaletteFadeWrapper
                addq.w  #1,(dword_FF940C+2).w
                cmpi.w  #$E,(dword_FF940C+2).w
                bne.w   locret_54192
                lea     (dword_FF9414).w,a1
                move.w  #$C680,(a1)+
                move.w  #$C6E0,(a1)+
                move.w  #$C740,(a1)+
                move.w  #$C7A0,(a1)+
                move.w  #$C800,(a1)+
                move.w  #$C860,(a1)+
                move.w  #$C8C0,(a1)+
                move.w  #$C920,(a1)+
                addq.w  #2,(dword_FF9400).w
locret_54192:                           ; CODE XREF: Boss_MissirayAttack2Init+22   j
                rts
; End of function Boss_MissirayAttack2Init
; Randomizes order of 8 segment pointers in array for attack sequence
Boss_MissirayShuffleSegmentOrder:                              ; DATA XREF: ROM:0005413A   o  ; was: sub_54194
                bsr.w Boss_MissirayUpdateGraphicsFrame
                lea     (dword_FF9414).w,a1
                move.w  #7,d6
loc_541A0:                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+3C   j
                move.w  #7,d7
loc_541A4:                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+38   j
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #7,d1
                add.w   d1,d1
                move.w  (a1,d0.w),d2
                move.w  (a1,d1.w),(a1,d0.w)
                move.w  d2,(a1,d1.w)
                dbf     d7,loc_541A4
                dbf     d6,loc_541A0
                addq.w  #2,(dword_FF9400).w
                clr.w   $4A(a5)
                tst.w   (dword_FF9404).w
                beq.s   loc_541F6
                move.w  #$B8,(dword_FF9408).w
                addi.w  #-$10,$4E(a5)
                move.w  #$B8,$50(a5)
                rts
; ---------------------------------------------------------------------------
loc_541F6:                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder+4C   j
                move.w  #$C8,(dword_FF9408).w
                addi.w  #$10,$4E(a5)
                move.w  #$FF48,$50(a5)
                rts
; End of function Boss_MissirayShuffleSegmentOrder
; Activates next segment from shuffled array for attack pattern
Boss_MissirayActivateNextSegment:                              ; DATA XREF: ROM:0005413C   o  ; was: sub_5420A
                bsr.w Boss_MissirayUpdateGraphicsFrame
                lea     (dword_FF9414).w,a1
                move.w  $4A(a5),d0
                movea.w (a1,d0.w),a0
                tst.b   $52(a0)
                bne.s   locret_5423A
                addq.w  #2,4(a0)
                move.b  #1,$50(a0)
                move.w  $50(a5),$4E(a0)
                move.w  #$18,$48(a5)
                addq.w  #2,(dword_FF9400).w
locret_5423A:                           ; CODE XREF: Boss_MissirayActivateNextSegment+14   j
                rts
; End of function Boss_MissirayActivateNextSegment
; Delays between segment activations, plays sound when all ready
Boss_MissiraySegmentActivationDelay:                              ; DATA XREF: ROM:0005413E   o  ; was: sub_5423C
                bsr.w Boss_MissirayUpdateGraphicsFrame
                subq.w  #1,$48(a5)
                bne.s   locret_54256
                addq.w  #2,$4A(a5)
                cmpi.w  #$10,$4A(a5)
                beq.s   loc_54258
                subq.w  #2,(dword_FF9400).w
locret_54256:                           ; CODE XREF: Boss_MissiraySegmentActivationDelay+8   j
                rts
; ---------------------------------------------------------------------------
loc_54258:                              ; CODE XREF: Boss_MissiraySegmentActivationDelay+14   j
                move.w  #$50,$48(a5) ; 'P'
                addq.w  #2,(dword_FF9400).w
                move.b  #$57,d0 ; 'W'
                jsr (Sound_PlaySFX).l
                btst    #7,$50(a5)
                bne.s   loc_5427C
                move.w  #2,(dword_FF9408+2).w
                rts
; ---------------------------------------------------------------------------
loc_5427C:                              ; CODE XREF: Boss_MissiraySegmentActivationDelay+36   j
                move.w  #$FFFE,(dword_FF9408+2).w
                rts
; End of function Boss_MissiraySegmentActivationDelay
; Moves boss horizontally and initializes segment positions
Boss_MissirayMoveHorizontal:                              ; DATA XREF: ROM:00054140   o  ; was: sub_54284
                bsr.w Boss_MissirayUpdateGraphicsFrame
                move.w  (dword_FF9408+2).w,d0
                add.w   d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_542BE
                clr.w   (dword_FF9408+2).w
                addq.w  #2,(dword_FF9400).w
                move.w  $14(a5),$4E(a5)
                moveq   #0,d0
                move.w  #7,d7
                lea     $60(a5),a0
loc_542AE:                              ; CODE XREF: Boss_MissirayMoveHorizontal+36   j
                move.w  d0,$4C(a0)
                move.w  d0,$4E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_542AE
locret_542BE:                           ; CODE XREF: Boss_MissirayMoveHorizontal+10   j
                rts
; End of function Boss_MissirayMoveHorizontal
; Clears attack flag and resets to idle state after pattern
Boss_MissirayFinishSegmentPattern:                              ; DATA XREF: ROM:00054142   o  ; was: sub_542C0
                bclr    #4,$23(a5)
                bsr.w Boss_MissirayUpdateGraphicsFrame
                bra.w Boss_MissirayResetAttackState
; End of function Boss_MissirayFinishSegmentPattern
; Dispatcher for attack pattern 4 (facing right attack)
Boss_MissirayAttackPattern4Dispatcher:                              ; DATA XREF: ROM:00053CCA   o  ; was: sub_542CE
                move.w  (dword_FF9400).w,d0
                lea     off_542DA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern4Dispatcher
; ---------------------------------------------------------------------------
off_542DA:      dc.w Boss_MissirayAttackPattern4Init-*        ; DATA XREF: Boss_MissirayAttackPattern4Dispatcher+4   o
                dc.w Boss_MissirayAttackPattern4Wait1-*
                dc.w Boss_MissirayAttackPattern4Wait2-*
                dc.w Boss_MissirayAttackPattern4Wait3-*
                dc.w Boss_MissirayAttackPattern4Loop-*


; Initializes attack pattern 4 with graphics and direction
Boss_MissirayAttackPattern4Init:                              ; DATA XREF: ROM:off_542DA   o  ; was: sub_542E4
                bsr.w Boss_MissirayUpdateGraphicsFrame
                move.w  #0,(dword_FF9404).w
                move.w  #$A0,(dword_FF9404+2).w
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttackPattern4Init
; Waits for screen fade completion before continuing pattern
Boss_MissirayAttackPattern4Wait1:                              ; DATA XREF: ROM:000542DC   o  ; was: sub_5430A
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_5431C
                addq.w  #2,(dword_FF9400).w
                bra.w Gfx_MissirayLoadTilesSet1
; ---------------------------------------------------------------------------
locret_5431C:                           ; CODE XREF: Boss_MissirayAttackPattern4Wait1+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait1
; Waits for fade and triggers battle start for pattern 4
Boss_MissirayAttackPattern4Wait2:                              ; DATA XREF: ROM:000542DE   o  ; was: sub_5431E
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_54330
                addq.w  #2,(dword_FF9400).w
                bra.w Boss_MissirayBattleStart
; ---------------------------------------------------------------------------
locret_54330:                           ; CODE XREF: Boss_MissirayAttackPattern4Wait2+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait2
; Waits for fade, sets idle state and timer for pattern 4
Boss_MissirayAttackPattern4Wait3:                              ; DATA XREF: ROM:000542E0   o  ; was: sub_54332
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_5434A
                addq.w  #2,(dword_FF9400).w
                bsr.w Boss_MissirayIdleState
                move.w  #$E,(dword_FF940C+2).w
locret_5434A:                           ; CODE XREF: Boss_MissirayAttackPattern4Wait3+8   j
                rts
; End of function Boss_MissirayAttackPattern4Wait3
; Updates graphics animation during attack pattern 4
Boss_MissirayAttackPattern4Loop:                              ; DATA XREF: ROM:000542E2   o  ; was: sub_5434C
                bsr.w Gfx_ApplyPaletteFadeWrapper
                subq.w  #1,(dword_FF940C+2).w
                bpl.s   locret_5435A
                bra.w Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_5435A:                           ; CODE XREF: Boss_MissirayAttackPattern4Loop+8   j
                rts
; End of function Boss_MissirayAttackPattern4Loop
; Dispatcher for attack pattern 5 (facing left attack)
Boss_MissirayAttackPattern5Dispatcher:                              ; DATA XREF: ROM:00053CC2   o  ; was: sub_5435C
                move.w  (dword_FF9400).w,d0
                lea     off_54368(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayAttackPattern5Dispatcher
; ---------------------------------------------------------------------------
off_54368:      dc.w Boss_MissirayAttackPattern5Init-*        ; DATA XREF: Boss_MissirayAttackPattern5Dispatcher+4   o
                dc.w Boss_MissirayAttackPattern5Wait1-*
                dc.w Boss_MissirayAttackPattern5Wait2-*
                dc.w Boss_MissirayAttackPattern5Wait3-*
                dc.w Boss_MissirayAttackPattern5Loop-*


; Initializes attack pattern 5 with graphics and direction
Boss_MissirayAttackPattern5Init:                              ; DATA XREF: ROM:off_54368   o  ; was: sub_54372
                move.w  #1,(dword_FF9404).w
                move.l  #$F40CE41C,$2C(a5)
                move.l  #$F010E41C,$28(a5)
                move.w  #$C0,(dword_FF9404+2).w
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_MissirayAttackPattern5Init
; Waits for screen fade completion before continuing pattern
Boss_MissirayAttackPattern5Wait1:                              ; DATA XREF: ROM:0005436A   o  ; was: sub_54394
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543A6
                addq.w  #2,(dword_FF9400).w
                bra.w Gfx_MissirayLoadTilesSet2
; ---------------------------------------------------------------------------
locret_543A6:                           ; CODE XREF: Boss_MissirayAttackPattern5Wait1+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait1
; Waits for fade before next phase of pattern 5
Boss_MissirayAttackPattern5Wait2:                              ; DATA XREF: ROM:0005436C   o  ; was: sub_543A8
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543BA
                addq.w  #2,(dword_FF9400).w
                bra.w Gfx_MissirayLoadCompressedSet1
; ---------------------------------------------------------------------------
locret_543BA:                           ; CODE XREF: Boss_MissirayAttackPattern5Wait2+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait2
; Waits for fade, sets up idle state and timer for pattern 5
Boss_MissirayAttackPattern5Wait3:                              ; DATA XREF: ROM:0005436E   o  ; was: sub_543BC
                bsr.w Boss_MissirayUpdateGraphicsFrame
                tst.b   (word_FFF720).w
                bmi.s   locret_543D4
                addq.w  #2,(dword_FF9400).w
                bsr.w Gfx_MissirayLoadCompressedSet2
                move.w  #$E,(dword_FF940C+2).w
locret_543D4:                           ; CODE XREF: Boss_MissirayAttackPattern5Wait3+8   j
                rts
; End of function Boss_MissirayAttackPattern5Wait3
; Updates graphics animation during attack pattern 5
Boss_MissirayAttackPattern5Loop:                              ; DATA XREF: ROM:00054370   o  ; was: sub_543D6
                bsr.w Gfx_ApplyPaletteFadeWrapper
                subq.w  #1,(dword_FF940C+2).w
                bpl.s   locret_543E4
                bra.w Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_543E4:                           ; CODE XREF: Boss_MissirayAttackPattern5Loop+8   j
                rts
; End of function Boss_MissirayAttackPattern5Loop
; Dispatcher for idle delay state between attacks
Boss_MissirayIdleDelayDispatcher:
                move.w  (dword_FF9400).w,d0  ; was: sub_543E6
                lea     off_543F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_MissirayIdleDelayDispatcher
; ---------------------------------------------------------------------------
off_543F2:      dc.w Boss_MissirayIdleDelayCountdown-*        ; DATA XREF: Boss_MissirayIdleDelayDispatcher+4   o
                dc.w Boss_MissirayIdleDelayCountdown_WaitLoop-*


; Counts down idle timer and returns to attack state
Boss_MissirayIdleDelayCountdown:                              ; DATA XREF: ROM:off_543F2   o  ; was: sub_543F6
                move.w  #$80,$48(a5)
                addq.w  #2,(dword_FF9400).w
; Countdown timer during idle delay before reset
Boss_MissirayIdleDelayCountdown_WaitLoop:                              ; DATA XREF: ROM:000543F4   o  ; was: loc_54400
                subq.w  #1,$48(a5)
                bne.s   locret_5440A
                bra.w Boss_MissirayResetAttackState
; ---------------------------------------------------------------------------
locret_5440A:                           ; CODE XREF: Boss_MissirayIdleDelayCountdown+E   j
                rts
; End of function Boss_MissirayIdleDelayCountdown
; Spawn ring of bullets
Boss_MissiraySpawnBulletRing:                              ; CODE XREF: Boss_MissirayAttackPattern3Init:loc_53F7A   p  ; was: sub_5440C
                                        ; sub_54038:loc_54042   p
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
                moveq   #0,d0
loc_54416:                              ; CODE XREF: Boss_MissiraySpawnBulletRing+C   j
                move.w  d0,(a3)+
                dbf     d7,loc_54416
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
loc_54424:                              ; CODE XREF: Boss_MissiraySpawnBulletRing+26   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_5443C
                move.w  #$10,(a0)
                move.w  a0,(a3)+
                dbf     d7,loc_54424
                move.w  #0,d0
                rts
; ---------------------------------------------------------------------------
loc_5443C:                              ; CODE XREF: Boss_MissiraySpawnBulletRing+1E   j
                move.w  #7,d7
                lea     (dword_FF9414).w,a3
loc_54444:                              ; CODE XREF: Boss_MissiraySpawnBulletRing+42   j
                movea.w (a3)+,a0
                beq.s   locret_54456
                move.w  #$1000,2(a0)
                dbf     d7,loc_54444
                move.w  #1,d0
locret_54456:                           ; CODE XREF: Boss_MissiraySpawnBulletRing+3A   j
                rts
; End of function Boss_MissiraySpawnBulletRing
; Segment part main handler
Segment_MissirayPartMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_54458
                move.b  $50(a5),d0
                andi.w  #3,d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_5446C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayPartMain
; ---------------------------------------------------------------------------
off_5446C:      dc.w Segment_MissirayType1Main-*        ; DATA XREF: Segment_MissirayPartMain+C   o
                dc.w Segment_MissirayPartDispatcher-*
                dc.w Segment_MissirayType2Main-*


; Segment part dispatcher
Segment_MissirayPartDispatcher:                              ; DATA XREF: ROM:0005446E   o  ; was: sub_54472
                move.w  4(a5),d0
                lea     off_5447E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayPartDispatcher
; ---------------------------------------------------------------------------
off_5447E:      dc.w Segment_MissirayPartInit-*        ; DATA XREF: Segment_MissirayPartDispatcher+4   o
                dc.w Segment_MissirayPartRotate-*
                dc.w Segment_MissirayPartRetract-*


; Segment part init
Segment_MissirayPartInit:                              ; DATA XREF: ROM:off_5447E   o  ; was: sub_54484
                clr.b   $52(a5)
                rts
; End of function Segment_MissirayPartInit
; Segment part rotation
Segment_MissirayPartRotate:                              ; DATA XREF: ROM:00054480   o  ; was: sub_5448A
                move.b  #1,$52(a5)
                cmpi.w  #$10,(word_FFC624).w
                bcs.s   loc_544B4
                addi.w  #$10,$48(a5)
                move.w  #$40,d0 ; '@'
                bsr.w Segment_MissirayCalculateAngle
                andi.w  #$3F0,$48(a5)
                cmpi.w  #$200,$48(a5)
                bne.s   locret_544C8
loc_544B4:                              ; CODE XREF: Segment_MissirayPartRotate+C   j
                bset    #6,$21(a5)
                addq.w  #2,4(a5)
                move.b  #$57,d0 ; 'W'
                jsr (Sound_PlaySFX).l
locret_544C8:                           ; CODE XREF: Segment_MissirayPartRotate+28   j
                rts
; End of function Segment_MissirayPartRotate
; Segment part retract
Segment_MissirayPartRetract:                              ; DATA XREF: ROM:00054482   o  ; was: sub_544CA
                bsr.s Segment_MissirayPartMoveToTarget
                cmpi.w  #$10,(word_FFC624).w
                bcs.s   loc_544DA
                bsr.s Segment_MissirayPartMoveToTarget
                bsr.s Segment_MissirayPartMoveToTarget
                bsr.s Segment_MissirayPartMoveToTarget
loc_544DA:                              ; CODE XREF: Segment_MissirayPartRetract+8   j
                move.w  $4C(a5),d0
                cmp.w   $4E(a5),d0
                bne.s   locret_544F2
                bclr    #6,$21(a5)
                clr.w   $4E(a5)
                clr.w   4(a5)
locret_544F2:                           ; CODE XREF: Segment_MissirayPartRetract+18   j
                rts
; End of function Segment_MissirayPartRetract
; Move segment to target
Segment_MissirayPartMoveToTarget:                              ; CODE XREF: Segment_MissirayPartRetract   p  ; was: sub_544F4
                                        ; Segment_MissirayPartRetract+A   p ...
                move.w  $4E(a5),d0
                sub.w   $4C(a5),d0
                beq.s   locret_5450C
                tst.w   d0
                bpl.s   loc_54508
                subq.w  #1,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_54508:                              ; CODE XREF: Segment_MissirayPartMoveToTarget+C   j
                addq.w  #1,$4C(a5)
locret_5450C:                           ; CODE XREF: Segment_MissirayPartMoveToTarget+8   j
                rts
; End of function Segment_MissirayPartMoveToTarget
; Cycles through 16 graphics frames for body animation
Boss_MissirayUpdateGraphicsFrame:                              ; CODE XREF: Boss_MissirayShuffleSegmentOrder   p  ; was: sub_5450E
                                        ; sub_5420A   p ...
                addq.w  #2,(dword_FF9410).w
                cmpi.w  #$1E,(dword_FF9410).w
                bne.s   loc_5451E
                clr.w   (dword_FF9410).w
loc_5451E:                              ; CODE XREF: Boss_MissirayUpdateGraphicsFrame+A   j
                move.w  (dword_FF9410).w,d0
                move.w  word_54542(pc,d0.w),(dword_FF940C+2).w
; End of function Boss_MissirayUpdateGraphicsFrame
; Applies palette fade effect using word_FFE360 palette data
Gfx_ApplyPaletteFadeWrapper:                              ; CODE XREF: Boss_MissirayAttack2Init:loc_54158   p  ; was: sub_54528
                                        ; sub_5434C   p ...
                move.w  (dword_FF940C+2).w,d0
                andi.w  #$E,d0
                move.w  #$F,d5
                lea     (word_FFE360).w,a0
                move.w  (dword_FF9410+2).w,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyPaletteFadeWrapper
; ---------------------------------------------------------------------------
word_54542:     dc.w $E, $C, $A, 8, 6, 4, 2, 0, 2, 4, 6, 8, $A, $C, $E
                                        ; DATA XREF: Boss_MissirayUpdateGraphicsFrame+14   r


; Segment type 1 main
Segment_MissirayType1Main:                              ; DATA XREF: ROM:off_5446C   o  ; was: sub_54560
                move.w  4(a5),d0
                lea     off_5456C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayType1Main
; ---------------------------------------------------------------------------
off_5456C:      dc.w Segment_MissirayType1Idle-*        ; DATA XREF: Segment_MissirayType1Main+4   o
                dc.w Segment_MissirayType1Fire-*
                dc.w Segment_MissirayType1Rotate1-*
                dc.w Segment_MissirayType1Rotate2-*
                dc.w Segment_MissirayType1WaitEnd-*


; Segment type 1 idle
Segment_MissirayType1Idle:                              ; DATA XREF: ROM:off_5456C   o  ; was: sub_54576
                clr.b   $52(a5)
                rts
; End of function Segment_MissirayType1Idle
; Segment type 1 fire
Segment_MissirayType1Fire:                              ; DATA XREF: ROM:0005456E   o  ; was: sub_5457C
                move.b  #1,$52(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_545D6
                clr.w   $48(a5)
                addq.w  #2,4(a5)
                cmpi.b  #1,$51(a5)
                beq.s   loc_545B8
                movea.w $54(a5),a0
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.l  #$FFFF0000,d2
                move.l  #$FFFFE000,d3
                jsr (Projectile_MissirayBulletInit).l
                rts
; ---------------------------------------------------------------------------
loc_545B8:                              ; CODE XREF: Segment_MissirayType1Fire+1A   j
                movea.w $54(a5),a0
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.l  #$2800,d2
                move.l  #$1000,d3
                jsr (Projectile_InitMissirayBullet).l
locret_545D6:                           ; CODE XREF: Segment_MissirayType1Fire+A   j
                rts
; End of function Segment_MissirayType1Fire
; Segment type 1 rotate 1
Segment_MissirayType1Rotate1:                              ; DATA XREF: ROM:00054570   o  ; was: sub_545D8
                addi.w  #$10,$48(a5)
                move.w  #$40,d0 ; '@'
                bsr.w Segment_MissirayCalculateAngle
                andi.w  #$1F0,$48(a5)
                cmpi.w  #$100,$48(a5)
                bne.s   locret_545F8
                addq.w  #2,4(a5)
locret_545F8:                           ; CODE XREF: Segment_MissirayType1Rotate1+1A   j
                rts
; End of function Segment_MissirayType1Rotate1
; Calculate angle from sine
Segment_MissirayCalculateAngle:                              ; CODE XREF: Segment_MissirayPartRotate+18   p  ; was: sub_545FA
                                        ; Segment_MissirayType1Rotate1+A   p ...
                move.w  $48(a5),d1
                andi.w  #$1FE,d1
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d1.w),d1
                muls.w  d0,d1
                swap    d1
                move.w  d1,$4C(a5)
                rts
; End of function Segment_MissirayCalculateAngle
; Segment type 1 rotate 2
Segment_MissirayType1Rotate2:                              ; DATA XREF: ROM:00054572   o  ; was: sub_54616
                addi.w  #$10,$48(a5)
                move.w  #$20,d0 ; ' '
                bsr.w Segment_MissirayCalculateAngle
                andi.w  #$1F0,$48(a5)
                cmpi.w  #0,$48(a5)
                bne.s   locret_5463C
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_5463C:                           ; CODE XREF: Segment_MissirayType1Rotate2+1A   j
                rts
; End of function Segment_MissirayType1Rotate2
; Segment type 1 wait end
Segment_MissirayType1WaitEnd:                              ; DATA XREF: ROM:00054574   o  ; was: sub_5463E
                subq.w  #1,$48(a5)
                bne.s   locret_54648
                clr.w   4(a5)
locret_54648:                           ; CODE XREF: Segment_MissirayType1WaitEnd+4   j
                rts
; End of function Segment_MissirayType1WaitEnd
; Segment type 2 main
Segment_MissirayType2Main:                              ; DATA XREF: ROM:00054470   o  ; was: sub_5464A
                move.w  4(a5),d0
                lea     off_54656(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Segment_MissirayType2Main
; ---------------------------------------------------------------------------
off_54656:      dc.w Segment_MissirayType2Delay-*        ; DATA XREF: Segment_MissirayType2Main+4   o
                dc.w Segment_MissirayType2Rise-*
                dc.w nullsub_125-*


; Segment type 2 delay
Segment_MissirayType2Delay:                              ; DATA XREF: ROM:off_54656   o  ; was: sub_5465C
                subq.w  #1,$48(a5)
                bne.s   locret_5467A
                addq.w  #2,4(a5)
                tst.w   (dword_FF9404).w
                bne.s   locret_5467A
                tst.w   (dword_FF9408+2).w
                bne.s   locret_5467A
                move.l  #$FFFC0000,$1C(a5)
locret_5467A:                           ; CODE XREF: Segment_MissirayType2Delay+4   j
                                        ; Segment_MissirayType2Delay+E   j ...
                rts
; End of function Segment_MissirayType2Delay
; Segment type 2 rise up
Segment_MissirayType2Rise:                              ; DATA XREF: ROM:00054658   o  ; was: sub_5467C
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bgt.s   loc_5469E
                subq.w  #1,$48(a5)
                bpl.s   locret_5469C
                bsr.w Segment_MissirayType2SpawnDebris
                move.w  #6,$48(a5)
locret_5469C:                           ; CODE XREF: Segment_MissirayType2Rise+14   j
                rts
; ---------------------------------------------------------------------------
loc_5469E:                              ; CODE XREF: Segment_MissirayType2Rise+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Segment_MissirayType2Rise
; Segment type 2 spawn debris
Segment_MissirayType2SpawnDebris:                              ; CODE XREF: Segment_MissirayType2Rise+16   p  ; was: sub_546A6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_546DC
                jsr     (RandomNumber).l
                jsr (Sprite_InitializeProperties).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                lsl.w   #2,d0
                move.l  off_546DE(pc,d0.w),8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                ori.w   #$8000,$E(a0)
locret_546DC:                           ; CODE XREF: Segment_MissirayType2SpawnDebris+6   j
                rts
; End of function Segment_MissirayType2SpawnDebris
; ---------------------------------------------------------------------------
off_546DE:      dc.l off_E953C          ; DATA XREF: Segment_MissirayType2SpawnDebris+1E   r
                dc.l off_E95A4
                dc.l off_E95DC
                dc.l off_E96FC
                dc.l off_E953C
                dc.l off_E9710
                dc.l off_E95DC
                dc.l off_E9724


nullsub_125:                            ; DATA XREF: ROM:0005465A   o
                rts
; End of function nullsub_125


; Handles directional input for Valkirie boss horizontal movement
Boss_ValkirieInputControl:
                btst    #6,(word_FFF706).w  ; was: sub_54700
                beq.s   locret_5472C
                btst    #0,(word_FFF706).w
                beq.s   loc_5471A
                subq.w  #2,$14(a5)
                move.w  $14(a5),$4E(a5)
loc_5471A:                              ; CODE XREF: Boss_ValkirieInputControl+E   j
                btst    #1,(word_FFF706).w
                beq.s   locret_5472C
                addq.w  #2,$14(a5)
                move.w  $14(a5),$4E(a5)
locret_5472C:                           ; CODE XREF: Boss_ValkirieInputControl+6   j
                                        ; Boss_ValkirieInputControl+20   j
                rts
; End of function Boss_ValkirieInputControl
; Check player proximity
Boss_MissirayCheckPlayerProximity:                              ; CODE XREF: Boss_MissirayMainAttackLoop   p  ; was: sub_5472E
                tst.w   (dword_FF9408+2).w
                bne.w   locret_547D6
                tst.w   (dword_FF940C).w
                bmi.s   loc_5475A
                jsr (Physics_CalculateDistanceTo).l
                move.w  #$20,d1 ; ' '
                tst.w   (word_FFFF0E).w
                beq.s   loc_5474E
                add.w   d1,d1
loc_5474E:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+1C   j
                cmp.w   d1,d0
                bhi.w   locret_547D6
                subq.w  #1,(dword_FF940C).w
                rts
; ---------------------------------------------------------------------------
loc_5475A:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+C   j
                tst.w   (dword_FF9404).w
                beq.s   loc_54768
                move.w  #$40,(dword_FF940C).w ; '@'
                bra.s   loc_5476E
; ---------------------------------------------------------------------------
loc_54768:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+30   j
                move.w  #$80,(dword_FF940C).w
loc_5476E:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+38   j
                move.w  #$C,d5
                add.w   $10(a5),d5
                move.l  #$F010F804,d3
                tst.w   (dword_FF9404).w
                bne.s   loc_54790
                move.w  #$FFE0,d6
                add.w   $14(a5),d6
                move.w  #$18,d4
                bra.s   loc_5479C
; ---------------------------------------------------------------------------
loc_54790:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+52   j
                move.w  #$20,d6 ; ' '
                add.w   $14(a5),d6
                move.w  #8,d4
loc_5479C:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+60   j
                jsr Boss_MissiraySpawnMissile(pc)   ; (pc)
                nop
                move.w  #$FFF4,d5
                add.w   $10(a5),d5
                move.l  #$F010FC08,d3
                tst.w   (dword_FF9404).w
                bne.s   loc_547C4
                move.w  #$FFE0,d6
                add.w   $14(a5),d6
                move.w  #$18,d4
                bra.s   loc_547D0
; ---------------------------------------------------------------------------
loc_547C4:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+86   j
                move.w  #$20,d6 ; ' '
                add.w   $14(a5),d6
                move.w  #8,d4
loc_547D0:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity+94   j
                jsr Boss_MissiraySpawnMissile(pc)   ; (pc)
                nop
locret_547D6:                           ; CODE XREF: Boss_MissirayCheckPlayerProximity+4   j
                                        ; Boss_MissirayCheckPlayerProximity+22   j
                rts
; End of function Boss_MissirayCheckPlayerProximity
; Spawn missile projectile
Boss_MissiraySpawnMissile:                              ; CODE XREF: Boss_MissirayCheckPlayerProximity:loc_5479C   p  ; was: sub_547D8
                                        ; sub_5472E:loc_547D0   p
                                        ; DATA XREF: ...
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_54830
                move.w  #$404,(a0)
                move.w  #$EC00,2(a0)
                move.l  #off_E9680,8(a0)
                move.w  #$8480,$E(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                clr.w   4(a0)
                move.w  #$20,$46(a0) ; ' '
                sub.w   $10(a5),d5
                move.w  d5,$4A(a0)
                sub.w   $14(a5),d6
                move.w  d6,$4C(a0)
                move.w  d4,$50(a0)
                move.l  d3,$54(a0)
                move.w  a5,$48(a0)
                move.b  #$CE,d0
                jsr (Sound_PlaySFX).l
locret_54830:                           ; CODE XREF: Boss_MissiraySpawnMissile+6   j
                rts
; End of function Boss_MissiraySpawnMissile
; Missile projectile main
Projectile_MissirayMissileMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_54832
                move.w  4(a5),d0
                lea     off_5483E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_MissirayMissileMain
; ---------------------------------------------------------------------------
off_5483E:      dc.w Projectile_MissirayMissileTrack-*        ; DATA XREF: Projectile_MissirayMissileMain+4   o
                dc.w Projectile_MissirayMissileFly-*


; Missile tracking state
Projectile_MissirayMissileTrack:                              ; DATA XREF: ROM:off_5483E   o  ; was: sub_54842
                movea.w $48(a5),a4
                move.w  $10(a4),d0
                add.w   $4A(a5),d0
                move.w  d0,$10(a5)
                move.w  $14(a4),d0
                add.w   $4C(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$46(a5)
                bne.s   locret_548E2
                move.w  #$1000,2(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_548E2
                move.w  #$404,(a0)
                move.w  #$8E00,2(a0)
                move.w  #2,4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$4344,$E(a0)
                move.w  #$300,8(a0)
                move.w  #$FCF0,$A(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  $54(a5),$2C(a0)
                move.w  #$96,$26(a0)
                cmpi.w  #$18,$50(a5)
                beq.s   loc_548D2
                move.l  #$4650,$1C(a0)
                move.l  #$2000,$48(a0)
                ori.w   #$1000,$E(a0)
                rts
; ---------------------------------------------------------------------------
loc_548D2:                              ; CODE XREF: Projectile_MissirayMissileTrack+76   j
                move.l  #$FFFFB9B0,$1C(a0)
                move.l  #$FFFFE000,$48(a0)
locret_548E2:                           ; CODE XREF: Projectile_MissirayMissileTrack+20   j
                                        ; Projectile_MissirayMissileTrack+2E   j
                rts
; End of function Projectile_MissirayMissileTrack
; Missile flying state
Projectile_MissirayMissileFly:                              ; DATA XREF: ROM:00054840   o  ; was: sub_548E4
                move.l  $48(a5),d0
                add.l   d0,$1C(a5)
                rts
; End of function Projectile_MissirayMissileFly
; Initializes 9 sub-entities at offset $360 with sprite and tile data
Boss_ValkirieInitSubEntities:
                move.w  #8,d7  ; was: sub_548EE
                lea     $360(a5),a0
loc_548F6:                              ; CODE XREF: Boss_ValkirieInitSubEntities+28   j
                move.w  #$10,(a0)
                move.l  #off_E9680,8(a0)
                clr.w   $C(a0)
                move.w  #$EC80,2(a0)
                move.w  #$8480,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_548F6
                rts
; End of function Boss_ValkirieInitSubEntities
; Updates positions of sub-entities relative to main boss and $180 offset entity
Boss_ValkirieUpdateSubPositions:
                lea     $360(a5),a0  ; was: sub_5491C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                lea     $60(a0),a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                add.b   $2C(a5),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                add.b   $2D(a5),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.b   $2E(a5),d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.b   $2F(a5),d0
                move.w  d0,$10(a0)
                lea     $180(a5),a1
                lea     $60(a0),a0
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),d0
                add.b   $2C(a1),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),d0
                add.b   $2D(a1),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $14(a1),$14(a0)
                move.w  $10(a1),d0
                add.b   $2E(a1),d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                move.w  $14(a1),$14(a0)
                move.w  $10(a1),d0
                add.b   $2F(a1),d0
                move.w  d0,$10(a0)
                rts
; End of function Boss_ValkirieUpdateSubPositions
; Dispatcher for Valkirie projectile entity state machine
Entity_ValkirieProjectileDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_549E2
                move.w  4(a5),d0
                movea.w off_549F2(pc,d0.w),a0
                adda.l  #nullsub_126,a0
                jmp     (a0)
; End of function Entity_ValkirieProjectileDispatcher
; ---------------------------------------------------------------------------
off_549F2:      dc.w Entity_ValkirieProjectileInit-nullsub_126
                                        ; DATA XREF: Entity_ValkirieProjectileDispatcher+4   r
                dc.w Entity_ValkirieProjectileMove-nullsub_126
                dc.w Entity_ValkirieProjectileDecelerate-nullsub_126
                dc.w Entity_ValkirieProjectileGrowAnimation-nullsub_126
                dc.w Entity_ValkirieProjectileWaitTimer-nullsub_126
                dc.w Entity_ValkirieProjectileMoveLeft-nullsub_126
                dc.w Entity_ValkirieProjectileShrinkAndLaunch-nullsub_126
                dc.w Entity_ValkirieProjectileCleanup-nullsub_126


nullsub_126:                            ; CODE XREF: Entity_ValkirieProjectileWaitTimer+4   j
                                        ; Entity_ValkirieProjectileMoveLeft+A   j ...
                rts
; End of function nullsub_126


; Initializes Valkirie projectile with velocity and sprite data
Entity_ValkirieProjectileInit:                              ; DATA XREF: ROM:off_549F2   o  ; was: sub_54A04
                addq.w  #2,4(a5)
                move.w  #$ED00,2(a5)
                move.w  #$2B00,$E(a5)
                move.b  #$14,$20(a5)
                move.l  #$10000,$1C(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_ValkirieProjectileInit
; Moves projectile and updates shadow entity position
Entity_ValkirieProjectileMove:                              ; DATA XREF: ROM:000549F4   o  ; was: sub_54A30
                cmpi.w  #$120,$14(a5)
                bmi.s   loc_54A3C
                addq.w  #2,4(a5)
loc_54A3C:                              ; CODE XREF: Entity_ValkirieProjectileMove+6   j
                                        ; sub_54A5A:loc_54A7E   j
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  $14(a5),d0
                addi.w  #$10,d0
                move.w  d0,$14(a0)
                move.w  $10(a5),d0
                addi.w  #$B,d0
                move.w  d0,$10(a0)
                rts
; End of function Entity_ValkirieProjectileMove
; Decelerates projectile until reaching Y position $140
Entity_ValkirieProjectileDecelerate:                              ; DATA XREF: ROM:000549F6   o  ; was: sub_54A5A
                subi.l  #$200,$1C(a5)
                cmpi.w  #$140,$14(a5)
                bmi.s   loc_54A7E
                addq.w  #2,4(a5)
                move.w  #$130,$14(a5)
                clr.l   $1C(a5)
                move.w  #4,$48(a5)
loc_54A7E:                              ; CODE XREF: Entity_ValkirieProjectileDecelerate+E   j
                bra.s   loc_54A3C
; End of function Entity_ValkirieProjectileDecelerate
; Grows projectile sprite by incrementing animation frame counter
Entity_ValkirieProjectileGrowAnimation:                              ; DATA XREF: ROM:000549F8   o  ; was: sub_54A80
                move.w  #$150,(word_FFDB94).w
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_54AA6
                addq.w  #4,$48(a5)
                cmpi.w  #$10,$48(a5)
                bmi.s   loc_54AA6
                addq.w  #2,4(a5)
                move.w  #$28,$4A(a5) ; '('
loc_54AA6:                              ; CODE XREF: Entity_ValkirieProjectileGrowAnimation+E   j
                                        ; Entity_ValkirieProjectileGrowAnimation+1A   j
                bra.w Boss_ValkirieDMATransferTable
; End of function Entity_ValkirieProjectileGrowAnimation
; Waits for timer countdown before changing animation
Entity_ValkirieProjectileWaitTimer:                              ; DATA XREF: ROM:000549FA   o  ; was: sub_54AAA
                subq.w  #1,$4A(a5)
                bpl.w   nullsub_126
                addq.w  #2,4(a5)
                move.l  #off_ECE90,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_ValkirieProjectileWaitTimer
; Applies gravity and moves projectile leftward until X reaches $150
Entity_ValkirieProjectileMoveLeft:                              ; DATA XREF: ROM:000549FC   o  ; was: sub_54AC4
                bsr.w Boss_ValkirieApplyGravity
                cmpi.w  #$150,$10(a5)
                bpl.w   nullsub_126
                addq.w  #2,4(a5)
                rts
; End of function Entity_ValkirieProjectileMoveLeft
; Shrinks projectile animation and launches shadow downward
Entity_ValkirieProjectileShrinkAndLaunch:                              ; DATA XREF: ROM:000549FE   o  ; was: sub_54AD8
                bsr.w Boss_ValkirieApplyGravity
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_54B02
                subq.w  #4,$48(a5)
                bne.s   loc_54B02
                addq.w  #2,4(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.l  #$FFFE8000,$1C(a0)
                bset    #1,2(a0)
loc_54B02:                              ; CODE XREF: Entity_ValkirieProjectileShrinkAndLaunch+C   j
                                        ; Entity_ValkirieProjectileShrinkAndLaunch+12   j
                bra.w Boss_ValkirieDMATransferTable
; End of function Entity_ValkirieProjectileShrinkAndLaunch
; Clears velocity and resets animation, sets completion flag
Entity_ValkirieProjectileCleanup:                              ; DATA XREF: ROM:00054A00   o  ; was: sub_54B06
                clr.l   $18(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                move.b  #1,(byte_FFA958).w
                rts
; End of function Entity_ValkirieProjectileCleanup
; Applies gravity deceleration to Y velocity if not already falling
Boss_ValkirieApplyGravity:                              ; CODE XREF: Entity_ValkirieProjectileMoveLeft   p  ; was: sub_54B1E
                                        ; sub_54AD8   p
                cmpi.w  #$FFFF,$18(a5)
                bmi.s   locret_54B2E
                subi.l  #$C00,$18(a5)
locret_54B2E:                           ; CODE XREF: Boss_ValkirieApplyGravity+6   j
                rts
; End of function Boss_ValkirieApplyGravity
; Performs DMA transfer based on animation frame index
Boss_ValkirieDMATransferTable:                              ; CODE XREF: Entity_ValkirieProjectileGrowAnimation:loc_54AA6   j  ; was: sub_54B30
                                        ; sub_54AD8:loc_54B02   j
                move.w  $48(a5),d0
                movea.l off_54B3E(pc,d0.w),a0
                jmp Gfx_DMATransferTiles
; End of function Boss_ValkirieDMATransferTable
; ---------------------------------------------------------------------------
off_54B3E:      dc.l byte_54B52         ; DATA XREF: Boss_ValkirieDMATransferTable+4   r
                dc.l byte_54B5C
                dc.l byte_54B66
                dc.l byte_54B70
                dc.l byte_54B7A
byte_54B52:     dc.b $48, $F0, $40, 0, 0, 3, $65, $5A, $6E, $72
                                        ; DATA XREF: ROM:off_54B3E   o
byte_54B5C:     dc.b $48, $F0, $40, 0, 0, 3, $66, $6A, $6F, $73
                                        ; DATA XREF: ROM:00054B42   o
byte_54B66:     dc.b $48, $F0, $40, 0, 0, 3, $67, $6B, $70, $74
                                        ; DATA XREF: ROM:00054B46   o
byte_54B70:     dc.b $48, $F0, $40, 0, 0, 3, $68, $6C, $71, $75
                                        ; DATA XREF: ROM:00054B4A   o
byte_54B7A:     dc.b $48, $F0, $40, 0, 0, 3, $69, $6D, $6D, $76
                                        ; DATA XREF: ROM:00054B4E   o


; Seven Forces entity main handler
Entity_SevenForcesMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_54B84
                move.w  4(a5),d0
                beq.w   nullsub_126
                movea.w off_54B98(pc,d0.w),a0
                adda.l  #Entity_SevenForcesDispatcher,a0
                jmp     (a0)
; End of function Entity_SevenForcesMain
; ---------------------------------------------------------------------------
off_54B98:      dc.w Entity_SevenForcesDispatcher-Entity_SevenForcesDispatcher
                                        ; DATA XREF: Entity_SevenForcesMain+8   r
                dc.w Entity_SevenForcesDispatcher-Entity_SevenForcesDispatcher
                dc.w Entity_SevenForcesIntroMove-Entity_SevenForcesDispatcher
                dc.w Entity_SevenForcesTextInit-Entity_SevenForcesDispatcher
                dc.w Entity_SevenForcesTextUpdate-Entity_SevenForcesDispatcher
                dc.w Entity_SevenForcesTransform-Entity_SevenForcesDispatcher
                dc.w Boss_ValkirieMain-Entity_SevenForcesDispatcher
                dc.w Boss_ValkirieDispatcher-Entity_SevenForcesDispatcher
                dc.w Boss_MedusaMain-Entity_SevenForcesDispatcher
                dc.w Boss_Medusa_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w Boss_MedusaDispatcher-Entity_SevenForcesDispatcher
                dc.w Boss_MedusaUpdateSprites-Entity_SevenForcesDispatcher
                dc.w Boss_SylpheedMain-Entity_SevenForcesDispatcher
                dc.w Boss_Sylpheed_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w Boss_SylpheedDispatcher-Entity_SevenForcesDispatcher
                dc.w Boss_SylpheedIntroInit-Entity_SevenForcesDispatcher
                dc.w Boss_SylpheedUpdateSprites-Entity_SevenForcesDispatcher
                dc.w Boss_ArtemisMain-Entity_SevenForcesDispatcher
                dc.w Boss_Artemis_IntroRiseLoop-Entity_SevenForcesDispatcher
                dc.w Boss_SevenForcesWaitIntroComplete-Entity_SevenForcesDispatcher
                dc.w Boss_ArtemisDispatcher-Entity_SevenForcesDispatcher
                dc.w Stage_SireneTransition-Entity_SevenForcesDispatcher
                dc.w Boss_Sirene_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w Boss_SireneMain-Entity_SevenForcesDispatcher
                dc.w Boss_SireneShootPattern3-Entity_SevenForcesDispatcher
                dc.w Boss_SireneDeathFlash1-Entity_SevenForcesDispatcher
                dc.w Boss_SireneDeathFlash2-Entity_SevenForcesDispatcher
                dc.w Cutscene_SevenForcesExplosions-Entity_SevenForcesDispatcher
                dc.w Cutscene_SevenForcesWaitState-Entity_SevenForcesDispatcher
                dc.w Cutscene_SevenForcesEffect1-Entity_SevenForcesDispatcher
                dc.w Cutscene_SevenForcesEffect2-Entity_SevenForcesDispatcher
                dc.w Cutscene_SevenForcesEffect3-Entity_SevenForcesDispatcher


; Seven Forces dispatcher
Entity_SevenForcesDispatcher:                              ; DATA XREF: Entity_SevenForcesMain+C   o  ; was: sub_54BD8
                                        ; ROM:off_54B98   o ...
                bra.w Entity_SevenForcesIntro
; End of function Entity_SevenForcesDispatcher
; Initializes Seven Forces boss encounter with VDP and DMA setup
Boss_SevenForcesInit:
                move.w  #4,4(a5)  ; was: sub_54BDC
                move.b  #6,(word_FFF7E6+1).w
                move.b  #$8A,(word_FFF7F2+1).w
                move.b  #3,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                move.w  #$58,(word_FFF74A).w ; 'X'
                clr.w   (word_FFF74E).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #1,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #2,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #$5000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                rts
; End of function Boss_SevenForcesInit
; Seven Forces intro animation
Entity_SevenForcesIntro:                              ; CODE XREF: Entity_SevenForcesDispatcher   j  ; was: sub_54C3C
                move.w  #4,4(a5)
                move.w  #$E900,2(a5)
                move.w  #$2300,$E(a5)
                move.b  #$14,$20(a5)
                move.l  #off_ECE90,8(a5)
                clr.w   $C(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #$60,$10(a5) ; '`'
                move.w  #$128,$14(a5)
                lea     (byte_C81E).l,a0
                jmp     LoadPalette
; End of function Entity_SevenForcesIntro
; Seven Forces intro movement
Entity_SevenForcesIntroMove:                              ; DATA XREF: ROM:00054B9C   o  ; was: sub_54C7E
                bra.w Entity_SevenForcesTextDisplay
; End of function Entity_SevenForcesIntroMove
; Debug mode parallax scroll test with directional input and reset
Debug_SevenForcesScrollTest:
                btst    #6,(word_FFF706).w  ; was: sub_54C82
                beq.s   loc_54CEA
                btst    #0,(word_FFF706).w
                beq.s   loc_54CA2
                subi.l  #$800,(dword_FF9404).w
                subi.l  #$400,(dword_FF940C).w
loc_54CA2:                              ; CODE XREF: Debug_SevenForcesScrollTest+E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_54CBA
                addi.l  #$800,(dword_FF9404).w
                addi.l  #$400,(dword_FF940C).w
loc_54CBA:                              ; CODE XREF: Debug_SevenForcesScrollTest+26   j
                btst    #3,(word_FFF706).w
                beq.s   loc_54CD2
                addi.l  #$800,(dword_FF9400).w
                addi.l  #$400,(dword_FF9408).w
loc_54CD2:                              ; CODE XREF: Debug_SevenForcesScrollTest+3E   j
                btst    #2,(word_FFF706).w
                beq.s   loc_54CEA
                subi.l  #$800,(dword_FF9400).w
                subi.l  #$400,(dword_FF9408).w
loc_54CEA:                              ; CODE XREF: Debug_SevenForcesScrollTest+6   j
                                        ; Debug_SevenForcesScrollTest+56   j
                btst    #4,(word_FFF706).w
                beq.s   loc_54D52
                btst    #0,(word_FFF706).w
                beq.s   loc_54D0A
                subi.l  #$800,(dword_FF9414).w
                subi.l  #$400,(dword_FF941C).w
loc_54D0A:                              ; CODE XREF: Debug_SevenForcesScrollTest+76   j
                btst    #1,(word_FFF706).w
                beq.s   loc_54D22
                addi.l  #$800,(dword_FF9414).w
                addi.l  #$400,(dword_FF941C).w
loc_54D22:                              ; CODE XREF: Debug_SevenForcesScrollTest+8E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_54D3A
                addi.l  #$800,(dword_FF9410).w
                addi.l  #$400,(dword_FF9418).w
loc_54D3A:                              ; CODE XREF: Debug_SevenForcesScrollTest+A6   j
                btst    #2,(word_FFF706).w
                beq.s   loc_54D52
                subi.l  #$800,(dword_FF9410).w
                subi.l  #$400,(dword_FF9418).w
loc_54D52:                              ; CODE XREF: Debug_SevenForcesScrollTest+6E   j
                                        ; Debug_SevenForcesScrollTest+BE   j
                btst    #5,(word_FFF706).w
                beq.s   loc_54D9A
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9418).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9414).w
                clr.l   (dword_FF941C).w
                clr.l   (dword_FF9420).w
                clr.l   (dword_FF9428).w
                clr.l   (dword_FF9430).w
                clr.l   (dword_FF9438).w
                clr.l   (dword_FF9424).w
                clr.l   (dword_FF942C).w
                clr.l   (dword_FF9434).w
                clr.l   (dword_FF943C).w
loc_54D9A:                              ; CODE XREF: Debug_SevenForcesScrollTest+D6   j
                move.l  (dword_FF9400).w,d0
                add.l   d0,(dword_FF9420).w
                move.l  (dword_FF9408).w,d0
                add.l   d0,(dword_FF9428).w
                move.l  (dword_FF9404).w,d0
                add.l   d0,(dword_FF9424).w
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF942C).w
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9430).w
                move.l  (dword_FF9418).w,d0
                add.l   d0,(dword_FF9438).w
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9434).w
                move.l  (dword_FF941C).w,d0
                add.l   d0,(dword_FF943C).w
                move.l  (dword_FF9420).w,d3
                move.l  (dword_FF9430).w,d4
                move.l  (dword_FF9424).w,d5
                move.l  (dword_FF9434).w,d6
                btst    #0,(word_FFA000+1).w
                bne.s   loc_54E02
                move.l  (dword_FF9428).w,d3
                move.l  (dword_FF9438).w,d4
                move.l  (dword_FF942C).w,d5
                move.l  (dword_FF943C).w,d6
loc_54E02:                              ; CODE XREF: Debug_SevenForcesScrollTest+16E   j
                movea.w #(word_FFE400-M68K_RAM),a0
                movea.w #(byte_FFE800-M68K_RAM),a1
                moveq   #$F,d7
                moveq   #0,d1
                moveq   #0,d2
loc_54E10:                              ; CODE XREF: Debug_SevenForcesScrollTest+1B6   j
                lea     -$20(a1),a1
                swap    d1
                move.w  d1,(a0)
                neg.w   d1
                move.w  d1,(a1)
                neg.w   d1
                swap    d1
                add.l   d3,d1
                swap    d2
                move.w  d2,2(a0)
                neg.w   d2
                move.w  d2,2(a1)
                neg.w   d2
                swap    d2
                add.l   d4,d2
                lea     $20(a0),a0
                dbf     d7,loc_54E10
                movea.w #(word_FFEC00-M68K_RAM),a0
                movea.w #(byte_FFEC50-M68K_RAM),a1
                moveq   #9,d7
                moveq   #0,d1
                moveq   #0,d2
loc_54E4A:                              ; CODE XREF: Debug_SevenForcesScrollTest+1E4   j
                swap    d1
                swap    d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                neg.w   d2
                move.w  d2,-(a1)
                neg.w   d2
                neg.w   d1
                move.w  d1,-(a1)
                neg.w   d1
                swap    d1
                swap    d2
                add.l   d5,d1
                add.l   d6,d2
                dbf     d7,loc_54E4A
                movea.w #(word_FF9600-M68K_RAM),a0
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  #$20,d0 ; ' '
                move.w  #$8F02,d3
                move.l  #$94009320,d4
                jsr     (loc_1B78C).l
                move.w  #0,(word_FFE318).w
                btst    #0,(word_FFA000+1).w
                bne.s   loc_54EF2
                move.w  #$FCCC,(word_FF9608).w
                move.w  #$ECCC,(word_FF961A).w
                move.w  #$2CCC,(word_FF9628).w
                move.w  #$1CCC,(word_FF963A).w
                move.w  #$E0,(word_FFE31C).w
                move.w  #$E0,(word_FFE31E).w
                move.w  #$E0,(word_FFE302).w
                move.w  #$E0,(word_FFE304).w
                rts
; ---------------------------------------------------------------------------
loc_54EF2:                              ; CODE XREF: Debug_SevenForcesScrollTest+23C   j
                move.w  #$CCEC,(dword_FF9610).w
                move.w  #$CCFC,(word_FF9602).w
                move.w  #$CC2C,(word_FF9630).w
                move.w  #$CC1C,(word_FF9622).w
                move.w  #$E0,(word_FFE31C).w
                move.w  #$E0,(word_FFE31E).w
                move.w  #$E0,(word_FFE302).w
                move.w  #$E0,(word_FFE304).w
                rts
; End of function Debug_SevenForcesScrollTest
; Text display handler
Entity_SevenForcesTextDisplay:                              ; CODE XREF: Entity_SevenForcesIntroMove   j  ; was: sub_54F24
                subq.w  #1,$48(a5)
                bpl.s   locret_54F46
                addq.w  #2,4(a5)
                move.l  #$10000,$18(a5)
                bset    #0,(byte_FFA272).w
                jsr (Stage_TransitionToNextPhase).l
                subq.w  #2,(word_FFA950).w
locret_54F46:                           ; CODE XREF: Entity_SevenForcesTextDisplay+4   j
                rts
; End of function Entity_SevenForcesTextDisplay
; Text initialization
Entity_SevenForcesTextInit:                              ; DATA XREF: ROM:00054B9E   o  ; was: sub_54F48
                cmpi.w  #$E0,$10(a5)
                bmi.s   locret_54F6A
                addq.w  #2,4(a5)
                move.w  #8,$48(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                clr.l   $18(a5)
locret_54F6A:                           ; CODE XREF: Entity_SevenForcesTextInit+6   j
                rts
; End of function Entity_SevenForcesTextInit
; Text update handler
Entity_SevenForcesTextUpdate:                              ; DATA XREF: ROM:00054BA0   o  ; was: sub_54F6C
                tst.w   (word_FF80C2).w
                bne.s   locret_54F7C
                subq.w  #1,$48(a5)
                bpl.s   locret_54F7C
                addq.w  #2,4(a5)
locret_54F7C:                           ; CODE XREF: Entity_SevenForcesTextUpdate+4   j
                                        ; Entity_SevenForcesTextUpdate+A   j
                rts
; End of function Entity_SevenForcesTextUpdate
; Transformation sequence
Entity_SevenForcesTransform:                              ; DATA XREF: ROM:00054BA2   o  ; was: sub_54F7E
                tst.w   (word_FF80C2).w
                bne.s   locret_54F9C
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                clr.w   $5E(a5)
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
locret_54F9C:                           ; CODE XREF: Entity_SevenForcesTransform+4   j
                rts
; End of function Entity_SevenForcesTransform
; Main boss handler
Boss_ValkirieMain:                              ; DATA XREF: ROM:00054BA4   o  ; was: sub_54F9E
                subq.w  #1,$48(a5)
                bpl.w   nullsub_126
                addq.w  #1,$5E(a5)
                cmpi.w  #$E,$5E(a5)
                bmi.s   loc_54FE0
                addq.w  #2,4(a5)
                move.w  #$34,$48(a5) ; '4'
                clr.w   2(a5)
                move.b  #$96,d0
                jsr (Sys_WaitVBlank).l
                move.b  #$23,d0 ; '#'
                jsr (Sound_PlaySFX).l
                lea     (stru_11658).l,a1
                jsr (Gfx_UpdateBossPalette).l
loc_54FE0:                              ; CODE XREF: Boss_ValkirieMain+12   j
                bra.w Boss_ValkirieIntroInit
; End of function Boss_ValkirieMain
; Boss state dispatcher
Boss_ValkirieDispatcher:                              ; DATA XREF: ROM:00054BA6   o  ; was: sub_54FE4
                subq.w  #1,$48(a5)
                bpl.w Boss_ValkirieIntroInit
                subq.w  #1,$5E(a5)
                bpl.w Boss_ValkirieIntroInit
loc_54FF4:                              ; CODE XREF: Boss_MedusaUpdateSprites+16   j
                                        ; Boss_SylpheedUpdateSprites+16   j ...
                clr.w   4(a5)
                rts
; End of function Boss_ValkirieDispatcher
; Main boss handler
Boss_MedusaMain:                              ; DATA XREF: ROM:00054BA8   o  ; was: sub_54FFA
                addq.w  #2,4(a5)
                move.l  #$FFFCC000,$1C(a5)
                move.l  #$12000,$18(a5)
                cmpi.w  #$150,$10(a5)
                bmi.s Boss_Medusa_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Medusa intro applies gravity and checks landing
Boss_Medusa_IntroFallLoop:                              ; CODE XREF: Boss_MedusaMain+1A   j  ; was: loc_5501A
                                        ; DATA XREF: ROM:00054BAA   o
                addi.l  #$2800,$1C(a5)
                bmi.s   loc_55056
                cmpi.w  #$F0,$14(a5)
                bmi.s   loc_55056
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5) ; '@'
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                lea     (stru_1166C).l,a1
                jsr (Gfx_UpdateBossPalette).l
                move.b  #1,(byte_FFA958).w
loc_55056:                              ; CODE XREF: Boss_MedusaMain+28   j
                                        ; Boss_MedusaMain+30   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_MedusaMain
; Boss state dispatcher
Boss_MedusaDispatcher:                              ; DATA XREF: ROM:00054BAC   o  ; was: sub_5505A
                subq.w  #1,$48(a5)
                bpl.s   loc_55064
                addq.w  #2,4(a5)
loc_55064:                              ; CODE XREF: Boss_MedusaDispatcher+4   j
                cmpi.w  #$38,$48(a5) ; '8'
                bne.s   loc_55076
                move.b  #$25,d0 ; '%'
                jsr (Sound_PlaySFX).l
loc_55076:                              ; CODE XREF: Boss_MedusaDispatcher+10   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_MedusaDispatcher
; Updates boss sprites
Boss_MedusaUpdateSprites:                              ; DATA XREF: ROM:00054BAE   o  ; was: sub_5507A
                btst    #0,(word_FFA000+1).w
                beq.w Boss_MedusaIntroInit
                addq.w  #1,$5E(a5)
                beq.w Boss_MedusaIntroInit
                bmi.w Boss_MedusaIntroInit
                bra.w   loc_54FF4
; End of function Boss_MedusaUpdateSprites
; Main boss handler
Boss_SylpheedMain:                              ; DATA XREF: ROM:00054BB0   o  ; was: sub_55094
                move.b  #1,(byte_FFA958).w
                addq.w  #2,4(a5)
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$18000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s Boss_Sylpheed_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Sylpheed intro applies gravity and checks landing
Boss_Sylpheed_IntroFallLoop:                              ; CODE XREF: Boss_SylpheedMain+20   j  ; was: loc_550BA
                                        ; DATA XREF: ROM:00054BB2   o
                addi.l  #$2800,$1C(a5)
                bmi.s   loc_550F0
                cmpi.w  #$F0,$14(a5)
                bmi.s   loc_550F0
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$48(a5) ; ' '
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                lea     (stru_1169E).l,a1
                jsr (Gfx_UpdateBossPalette).l
loc_550F0:                              ; CODE XREF: Boss_SylpheedMain+2E   j
                                        ; Boss_SylpheedMain+36   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_SylpheedMain
; Boss state dispatcher
Boss_SylpheedDispatcher:                              ; DATA XREF: ROM:00054BB4   o  ; was: sub_550F4
                subq.w  #1,$48(a5)
                bpl.s   loc_55108
                addq.w  #2,4(a5)
                move.b  #$24,d0 ; '$'
                jsr (Sound_PlaySFX).l
loc_55108:                              ; CODE XREF: Boss_SylpheedDispatcher+4   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_SylpheedDispatcher
; Intro animation init
Boss_SylpheedIntroInit:                              ; DATA XREF: ROM:00054BB6   o  ; was: sub_5510C
                cmpi.w  #$F760,(dword_FFA904).w
                bpl.s   loc_55118
                addq.w  #2,4(a5)
loc_55118:                              ; CODE XREF: Boss_SylpheedIntroInit+6   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_SylpheedIntroInit
; Updates boss sprites
Boss_SylpheedUpdateSprites:                              ; DATA XREF: ROM:00054BB8   o  ; was: sub_5511C
                btst    #0,(word_FFA000+1).w
                beq.w Boss_MedusaIntroInit
                addq.w  #1,$5E(a5)
                beq.w Boss_MedusaIntroInit
                bmi.w Boss_MedusaIntroInit
                bra.w   loc_54FF4
; End of function Boss_SylpheedUpdateSprites
; Main boss handler
Boss_ArtemisMain:                              ; DATA XREF: ROM:00054BBA   o  ; was: sub_55136
                addq.w  #2,4(a5)
                bclr    #0,(byte_FF8144).w
                bclr    #4,(word_FFA40E).w
                move.w  #$58,(word_FFA404).w ; 'X'
                clr.l   (dword_FFA418).w
                clr.l   (dword_FFA41C).w
                move.w  #$34,(word_FFA02A).w ; '4'
                bset    #2,(byte_FF8245).w
                jsr (Memory_ClearBlock).l
                move.l  #$38000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s Boss_Artemis_IntroRiseLoop
                neg.l   $18(a5)
; Seven Forces Artemis intro applies upward momentum
Boss_Artemis_IntroRiseLoop:                              ; CODE XREF: Boss_ArtemisMain+46   j  ; was: loc_55182
                                        ; DATA XREF: ROM:00054BBC   o
                subi.l  #$1000,(dword_FFA41C).w
                subi.l  #$2000,$1C(a5)
                bpl.s   loc_551BA
                cmpi.w  #$100,$14(a5)
                bpl.s   loc_551BA
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                lea     (stru_11680).l,a1
                jsr (Gfx_UpdateBossPalette).l
loc_551BA:                              ; CODE XREF: Boss_ArtemisMain+5C   j
                                        ; Boss_ArtemisMain+64   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_ArtemisMain
; Waits for intro animation complete flag, then initializes Medusa phase
Boss_SevenForcesWaitIntroComplete:                              ; DATA XREF: ROM:00054BBE   o  ; was: sub_551BE
                subi.l  #$1000,(dword_FFA41C).w
                tst.b   (byte_FFA958).w
                bne.s   loc_551F2
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5) ; '@'
                move.w  #$10,$4A(a5)
                clr.w   (word_FFA404).w
                move.w  #$FF84,(dword_FFA414).w
                move.w  #$D0,(dword_FFA410).w
                bset    #0,(word_FFA402).w
loc_551F2:                              ; CODE XREF: Boss_SevenForcesWaitIntroComplete+C   j
                bra.w Boss_MedusaIntroInit
; End of function Boss_SevenForcesWaitIntroComplete
; Boss state dispatcher
Boss_ArtemisDispatcher:                              ; DATA XREF: ROM:00054BC0   o  ; was: sub_551F6
                tst.w   $48(a5)
                bmi.s   loc_55210
                subq.w  #1,$48(a5)
                bpl.w Boss_ArtemisIntroInit
                move.b  #1,(byte_FFA958).w
                bclr    #2,(byte_FF8245).w
loc_55210:                              ; CODE XREF: Boss_ArtemisDispatcher+4   j
                subq.w  #1,$4A(a5)
                bne.s   loc_5521E
                jsr (Gfx_ArtemisPaletteUpdate).l
                bra.s   loc_55222
; ---------------------------------------------------------------------------
loc_5521E:                              ; CODE XREF: Boss_ArtemisDispatcher+1E   j
                bpl.w Boss_ArtemisIntroInit
loc_55222:                              ; CODE XREF: Boss_ArtemisDispatcher+26   j
                btst    #0,(word_FFA000+1).w
                beq.w Boss_ArtemisIntroInit
                addq.w  #1,$5E(a5)
                beq.w Boss_ArtemisIntroInit
                bmi.w Boss_ArtemisIntroInit
                bra.w   loc_54FF4
; End of function Boss_ArtemisDispatcher
; Transition to Sirene form
Stage_SireneTransition:                              ; DATA XREF: ROM:00054BC2   o  ; was: sub_5523C
                addq.w  #2,4(a5)
                move.w  #$34,(word_FFA02A).w ; '4'
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s Boss_Sirene_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Sirene intro applies downward momentum
Boss_Sirene_IntroFallLoop:                              ; CODE XREF: Stage_SireneTransition+20   j  ; was: loc_55262
                                        ; DATA XREF: ROM:00054BC4   o
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_55282
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_55282
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5) ; '@'
loc_55282:                              ; CODE XREF: Stage_SireneTransition+2E   j
                                        ; Stage_SireneTransition+36   j
                bra.w Boss_ArtemisIntroInit
; End of function Stage_SireneTransition
; Main boss handler
Boss_SireneMain:                              ; DATA XREF: ROM:00054BC6   o  ; was: sub_55286
                subq.w  #1,$48(a5)
                bpl.s   loc_552AC
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5) ; ' '
                move.b  #$28,d0 ; '('
                jsr (Sound_PlaySFX).l
                lea     (stru_11676).l,a1
                jsr (Gfx_UpdateBossPalette).l
loc_552AC:                              ; CODE XREF: Boss_SireneMain+4   j
                addq.w  #1,$5E(a5)
                beq.w Boss_ArtemisIntroInit
                bmi.w Boss_ArtemisIntroInit
                rts
; End of function Boss_SireneMain
; Attributes: thunk
; Shooting pattern 3
Boss_SireneShootPattern3:                              ; DATA XREF: ROM:00054BC8   o  ; was: sub_552BA
                bra.w   loc_54FF4
; End of function Boss_SireneShootPattern3
; Plays death sound effects and updates palette at frame $9C
Boss_SireneDeathFlash1:                              ; DATA XREF: ROM:00054BCA   o  ; was: sub_552BE
                cmpi.w  #$9C,(word_FFA950).w
                bne.s   locret_552EA
                move.b  #$27,d0 ; '''
                jsr (Sound_PlaySFX).l
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                lea     (stru_11694).l,a1
                jsr (Gfx_UpdateBossPalette).l
                bra.w   loc_54FF4
; ---------------------------------------------------------------------------
locret_552EA:                           ; CODE XREF: Boss_SireneDeathFlash1+6   j
                rts
; End of function Boss_SireneDeathFlash1
; Plays death sound effects and updates palette at frame $A6
Boss_SireneDeathFlash2:                              ; DATA XREF: ROM:00054BCC   o  ; was: sub_552EC
                cmpi.w  #$A6,(word_FFA950).w
                bne.s   locret_55318
                move.b  #$26,d0 ; '&'
                jsr (Sound_PlaySFX).l
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                lea     (stru_1168A).l,a1
                jsr (Gfx_UpdateBossPalette).l
                bra.w   loc_54FF4
; ---------------------------------------------------------------------------
locret_55318:                           ; CODE XREF: Boss_SireneDeathFlash2+6   j
                rts
; End of function Boss_SireneDeathFlash2
; Spawns explosion effects
Cutscene_SevenForcesExplosions:                              ; DATA XREF: ROM:00054BCE   o  ; was: sub_5531A
                addq.w  #1,$48(a5)
                cmpi.w  #2,$48(a5)
                bne.s   loc_55330
                move.b  #3,d0
                jsr (Sound_PlaySFX).l
loc_55330:                              ; CODE XREF: Cutscene_SevenForcesExplosions+A   j
                bsr.w Boss_ArtemisIntroInit
                cmpi.w  #$98,(word_FFA950).w
                bne.s   loc_55352
                addq.w  #2,4(a5)
                move.w  #$200,$48(a5)
                move.b  #1,(byte_FF830E).w
                move.w  #$C0,(word_FF809E).w
loc_55352:                              ; CODE XREF: Cutscene_SevenForcesExplosions+20   j
                                        ; sub_553CC:loc_553DC   p
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                jsr (Effect_PlayRandomExplosionSound).l
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_553CA
                jsr (Sprite_InitializeProperties).l
                move.l  #off_E953C,8(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_5538A
                move.l  #off_E9560,8(a0)
loc_5538A:                              ; CODE XREF: Cutscene_SevenForcesExplosions+66   j
                move.b  #0,$20(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.w   #1,d0
                addi.l  #$80000,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$FF,d1
                subi.w  #$80,d0
                subi.w  #$80,d1
                addi.w  #$120,d0
                addi.w  #$F0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_553CA:                           ; CODE XREF: Cutscene_SevenForcesExplosions+50   j
                rts
; End of function Cutscene_SevenForcesExplosions
; Wait state with timer
Cutscene_SevenForcesWaitState:                              ; DATA XREF: ROM:00054BD0   o  ; was: sub_553CC
                subq.w  #1,$48(a5)
                bpl.s   loc_553DC
                addq.w  #2,4(a5)
                move.b  #1,(byte_FFA958).w
loc_553DC:                              ; CODE XREF: Cutscene_SevenForcesWaitState+4   j
                bsr.w   loc_55352
                addq.w  #1,$5E(a5)
                beq.w Boss_ArtemisIntroInit
                bmi.w Boss_ArtemisIntroInit
                rts
; End of function Cutscene_SevenForcesWaitState
; Visual effect handler 1
Cutscene_SevenForcesEffect1:                              ; DATA XREF: ROM:00054BD2   o  ; was: sub_553EE
                cmpi.w  #$A2,(word_FFA950).w
                bne.s   locret_5540A
                addq.w  #2,4(a5)
                clr.w   $5E(a5)
                move.w  #$2E,(word_FF80C2).w ; '.'
                move.b  #1,(byte_FF80FA).w
locret_5540A:                           ; CODE XREF: Cutscene_SevenForcesEffect1+6   j
                rts
; End of function Cutscene_SevenForcesEffect1
; Visual effect handler 2
Cutscene_SevenForcesEffect2:                              ; DATA XREF: ROM:00054BD4   o  ; was: sub_5540C
                bsr.w Cutscene_SevenForcesEffect4
                subq.w  #1,$5E(a5)
                cmpi.w  #$FFF2,$5E(a5)
                bpl.s   loc_55426
                addq.w  #2,4(a5)
                move.w  #$210,$48(a5)
loc_55426:                              ; CODE XREF: Cutscene_SevenForcesEffect2+E   j
                move.w  $5E(a5),d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Cutscene_SevenForcesEffect2
; Visual effect handler 3
Cutscene_SevenForcesEffect3:                              ; DATA XREF: ROM:00054BD6   o  ; was: sub_5543A
                bsr.w Cutscene_SevenForcesEffect4
                subq.w  #1,$48(a5)
                bpl.s   locret_5545E
                tst.w   (word_FF8230).w
                bne.s   locret_5545E
                move.b  #$93,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                jmp Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_5545E:                           ; CODE XREF: Cutscene_SevenForcesEffect3+8   j
                                        ; Cutscene_SevenForcesEffect3+E   j
                rts
; End of function Cutscene_SevenForcesEffect3
; Intro animation init
Boss_ValkirieIntroInit:                              ; CODE XREF: Boss_ValkirieMain:loc_54FE0   j  ; was: sub_55460
                                        ; Boss_ValkirieDispatcher+4   j ...
                move.w  $5E(a5),d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$3F,d5 ; '?'
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                rts
; End of function Boss_ValkirieIntroInit
; Intro animation init
Boss_MedusaIntroInit:                              ; CODE XREF: Boss_MedusaMain:loc_55056   j  ; was: sub_5547C
                                        ; sub_5505A:loc_55076   j ...
                movea.w #(word_FFE320-M68K_RAM),a0
                moveq   #$F,d5
                move.w  $5E(a5),d0
                neg.w   d0
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                move.w  $5E(a5),d0
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_MedusaIntroInit
; Intro animation init
Boss_ArtemisIntroInit:                              ; CODE XREF: Boss_ArtemisDispatcher+A   j  ; was: sub_554C0
                                        ; sub_551F6:loc_5521E   j ...
                move.w  $5E(a5),d0
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(word_FFE32A-M68K_RAM),a0
                moveq   #7,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                neg.w   d0
                movea.w #(word_FFE320-M68K_RAM),a0
                moveq   #4,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                move.w  $5E(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_ArtemisIntroInit
; Intro movement
Boss_MedusaIntroMove:                              ; CODE XREF: Boss_MedusaIdleState+6   p  ; was: sub_55518
                                        ; Boss_SylpheedIntroMove+6   p ...
                move.b  #$14,$20(a5)
                clr.w   $C(a5)
                move.w  #$CD00,2(a5)
                move.l  #word_ECDCA,8(a5)
                move.w  #$6300,$E(a5)
                move.w  (dword_FFC630).w,$10(a5)
                move.w  (dword_FFC634).w,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Boss_MedusaIntroMove
; Visual effect handler 4
Cutscene_SevenForcesEffect4:                              ; CODE XREF: Cutscene_SevenForcesEffect2   p  ; was: sub_5554C
                                        ; sub_5543A   p
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_555C6
                move.w  #$188,(a0)
                move.w  #$8400,2(a0)
                move.w  #$10,$48(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addq.w  #8,d0
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                move.l  d0,$18(a0)
                move.b  #$70,$20(a0) ; 'p'
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$7F,d1
                subi.w  #$80,d0
                addi.w  #$120,d0
                addi.w  #$A0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  #$44F4,$E(a0)
                btst    #0,(dword_FFFF08).w
                bne.s   loc_555BA
                move.w  #$44F5,$E(a0)
loc_555BA:                              ; CODE XREF: Cutscene_SevenForcesEffect4+66   j
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
locret_555C6:                           ; CODE XREF: Cutscene_SevenForcesEffect4+6   j
                rts
; End of function Cutscene_SevenForcesEffect4
; Intro stop position
Boss_MedusaIntroStop:                              ; CODE XREF: Boss_ValkirieIntroMove+26   j  ; was: sub_555C8
                                        ; Boss_MedusaAttackState1+26   j ...
                bset    #0,(byte_FFA272).w
                movea.w #(word_FFDC40-M68K_RAM),a5
                bsr.s Boss_MedusaBattleStart
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_MedusaIntroStop
; Battle start initialization
Boss_MedusaBattleStart:                              ; CODE XREF: Boss_MedusaIntroStop+A   p  ; was: sub_555DA
                movea.w off_555E6(pc,d0.w),a1
                adda.l  #Boss_MedusaResetState,a1
                jmp     (a1)
; End of function Boss_MedusaBattleStart
; ---------------------------------------------------------------------------
off_555E6:      dc.w Boss_MedusaResetState-Boss_MedusaResetState
                                        ; DATA XREF: Boss_MedusaBattleStart   r
                dc.w Boss_MedusaIdleState-Boss_MedusaResetState
                dc.w Boss_SylpheedIntroMove-Boss_MedusaResetState
                dc.w Boss_ArtemisIntroMove-Boss_MedusaResetState
                dc.w Boss_SireneDispatcher-Boss_MedusaResetState
                dc.w Boss_SireneEndBattle1-Boss_MedusaResetState
                dc.w Boss_SireneEndBattle2-Boss_MedusaResetState
                dc.w Cutscene_SevenForcesTransition-Boss_MedusaResetState
                dc.w Cutscene_SevenForcesEmptyTransition-Boss_MedusaResetState


; Resets boss state word at offset 4 to 0, called from Medusa battle start
Boss_MedusaResetState:                              ; DATA XREF: Boss_MedusaBattleStart+4   o  ; was: sub_555F8
                                        ; ROM:off_555E6   o ...
                move.w  #0,4(a5)
                rts
; End of function Boss_MedusaResetState
; Idle state handler
Boss_MedusaIdleState:                              ; DATA XREF: ROM:000555E8   o  ; was: sub_55600
                move.w  #$10,4(a5)
                bsr.w Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$FFF4,$5E(a5)
                bsr.w Boss_MedusaIntroInit
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_MedusaIdleState
; Intro movement
Boss_SylpheedIntroMove:                              ; DATA XREF: ROM:000555EA   o  ; was: sub_5562A
                move.w  #$18,4(a5)
                bsr.w Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                lea     (byte_C00C).l,a0
                jsr     (LoadPalette).l
                move.w  #$FFF2,$5E(a5)
                bsr.w Boss_MedusaIntroInit
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_SylpheedIntroMove
; Intro movement
Boss_ArtemisIntroMove:                              ; DATA XREF: ROM:000555EC   o  ; was: sub_5566C
                move.b  #1,(byte_FFA958).w
                move.w  #$22,4(a5) ; '"'
                bsr.w Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                lea     (byte_C01C).l,a0
                jsr     (LoadPalette).l
                move.w  #$FFF2,$5E(a5)
                bsr.w Boss_MedusaIntroInit
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_ArtemisIntroMove
; Boss state dispatcher
Boss_SireneDispatcher:                              ; DATA XREF: ROM:000555EE   o  ; was: sub_556A8
                move.w  #$2A,4(a5) ; '*'
                bsr.w Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$FFF2,$5E(a5)
                bsr.w Boss_MedusaIntroInit
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_SireneDispatcher
; Sets state to $24, flags transition, clears sprites except $428, plays sound $30
Boss_SireneEndBattle1:                              ; DATA XREF: ROM:000555F0   o  ; was: sub_556D2
                move.w  #$24,4(a5) ; '$'
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_SireneEndBattle1
; Sets state to $26, flags transition, clears sprites except $428, plays sound $30
Boss_SireneEndBattle2:                              ; DATA XREF: ROM:000555F2   o  ; was: sub_556F4
                move.w  #$26,4(a5) ; '&'
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.b  #$30,d0 ; '0'
                jmp (Sound_PlaySFX).l
; End of function Boss_SireneEndBattle2
; Transition after victory
Cutscene_SevenForcesTransition:                              ; DATA XREF: ROM:000555F4   o  ; was: sub_55716
                move.w  #$36,4(a5) ; '6'
                bclr    #0,(word_FFA402).w
                bset    #0,(byte_FF8144).w
                bclr    #2,(byte_FF8144).w
                clr.w   $48(a5)
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$FFF2,$5E(a5)
                bsr.w Boss_MedusaIntroInit
                rts
; End of function Cutscene_SevenForcesTransition
; Empty Seven Forces cutscene transition
Cutscene_SevenForcesEmptyTransition:                            ; DATA XREF: ROM:000555F6   o  ; was: nullsub_127
                rts
; End of function Cutscene_SevenForcesEmptyTransition
; Intro movement
Boss_ValkirieIntroMove:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_5575E
                tst.w   4(a5)
                beq.w   loc_557AA
                tst.w   8(a5)
                beq.s   loc_557AA
                btst    #2,(byte_FF80EC).w
                bne.s   loc_5578A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_5578A
                tst.w   (word_FF8200).w
                bne.s   loc_5578A
                moveq   #2,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_5578A:                              ; CODE XREF: Boss_ValkirieIntroMove+14   j
                                        ; Boss_ValkirieIntroMove+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #0,d0
                jsr Boss_ValkirieUpdatePalette(pc)   ; (pc)
                nop
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$BC(a5)
loc_557AA:                              ; CODE XREF: Boss_ValkirieIntroMove+4   j
                                        ; Boss_ValkirieIntroMove+C   j
                move.w  4(a5),d0
                movea.w off_557BA(pc,d0.w),a0
                adda.l  #Boss_ValkirieIntroStop,a0
                jmp     (a0)
; End of function Boss_ValkirieIntroMove
; ---------------------------------------------------------------------------
off_557BA:      dc.w Boss_ValkirieIntroStop-Boss_ValkirieIntroStop
                                        ; DATA XREF: Boss_ValkirieIntroMove+50   r
                dc.w Boss_ValkirieInitParts-Boss_ValkirieIntroStop
                dc.w Camera_BossMode_State2-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieAttackState1-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieShootPattern1-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieAttackDecision-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieRisingAttack-Boss_ValkirieIntroStop
                dc.w Boss_Valkirie_ChargeApplyGravity-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieChargeUpdate-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieUpdateHealth-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieDamageCheck-Boss_ValkirieIntroStop
                dc.w Boss_Valkirie_ChargeApplyGravity-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieShootPattern3-Boss_ValkirieIntroStop
                dc.w Camera_BossMode_State6-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieSpawnProjectile3-Boss_ValkirieIntroStop
                dc.w Camera_BossMode_State7-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieSpawnProjectile4-Boss_ValkirieIntroStop
                dc.w Boss_ValkirieHealthCheckAttack-Boss_ValkirieIntroStop
                dc.w Camera_BossMode_State8-Boss_ValkirieIntroStop


; Intro stop position
Boss_ValkirieIntroStop:                              ; DATA XREF: Boss_ValkirieIntroMove+54   o  ; was: sub_557E0
                                        ; ROM:off_557BA   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #off_59E94,a0
                movea.l #word_59EFC,a1
                movea.l #word_59F16,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_59F4A,$2FC(a5)
                move.l  #word_563E6,$35C(a5)
                move.w  #$42C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #word_1BEC4,a1
                jsr (Sprite_InitFromPointerTable).l
                bsr.w Boss_ValkirieMovePattern1
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w Boss_ValkirieIdleState
; End of function Boss_ValkirieIntroStop
; Initializes Valkirie boss position ($120,$E0), facing, velocities, and part pointers
Boss_ValkirieInitState:
                move.w  #2,4(a5)  ; was: sub_5584A
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$CEC0,$4A(a5)
                move.w  #$140,$8B4(a5)
; End of function Boss_ValkirieInitState
; Initializes Valkirie body parts at offsets $4A/$8B4/$674 based on flags in $23E
Boss_ValkirieInitParts:                              ; DATA XREF: ROM:000557BC   o  ; was: sub_55882
                bclr    #0,$23E(a5)
                beq.s   loc_55896
                move.w  #$CEC0,$4A(a5)
                move.w  #$140,$8B4(a5)
loc_55896:                              ; CODE XREF: Boss_ValkirieInitParts+6   j
                bclr    #1,$23E(a5)
                beq.s   loc_558AA
                move.w  #$CC80,$4A(a5)
                move.w  #$140,$674(a5)
loc_558AA:                              ; CODE XREF: Boss_ValkirieInitParts+1A   j
                lea     word_56244(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; End of function Boss_ValkirieInitParts
; Idle state handler
Boss_ValkirieIdleState:                              ; CODE XREF: Boss_ValkirieIntroStop+66   j  ; was: sub_558B4
                move.w  #4,4(a5)
                move.w  #$100,$54(a5)
                move.w  #$C0,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  $10(a5),$70(a5)
                move.w  #$C680,$48(a5)
                move.w  #$CC80,$4A(a5)
                bset    #0,$62(a5)
                move.w  #$140,$674(a5)
; Camera state 2 for boss battle focus
Camera_BossMode_State2:                              ; DATA XREF: ROM:000557BE   o  ; was: loc_558EE
                subq.w  #1,$11C(a5)
                bpl.s   loc_55900
                addq.w  #2,4(a5)
                moveq   #8,d0
                jsr (UI_CheckVictoryCondition).l
loc_55900:                              ; CODE XREF: Boss_ValkirieIdleState+3E   j
                lea     word_56262(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; End of function Boss_ValkirieIdleState
; Attack state 1 handler
Boss_ValkirieAttackState1:                              ; DATA XREF: ROM:000557C0   o  ; was: sub_5590A
                tst.w   (word_FF80C2).w
                bne.s   loc_55926
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (word_FFA02A).w
                subi.w  #$58,(word_FFA970).w ; 'X'
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55926:                              ; CODE XREF: Boss_ValkirieAttackState1+4   j
                lea     word_56262(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55930:                              ; CODE XREF: Boss_ValkirieAttackState1+18   j
                                        ; Boss_ValkirieAttackDecision+6   j ...
                move.w  #8,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieAttackState1
; Shooting pattern 1
Boss_ValkirieShootPattern1:                              ; DATA XREF: ROM:000557C2   o  ; was: sub_5594E
                bclr    #0,$23E(a5)
                beq.s   loc_559AA
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$80,d0
                bpl.s   loc_55966
                bra.w Boss_ValkirieCollisionCheck
; ---------------------------------------------------------------------------
loc_55966:                              ; CODE XREF: Boss_ValkirieShootPattern1+12   j
                cmpi.w  #$700,$BC(a5)
                bmi.s   loc_5598E
                cmpi.w  #$840,$BC(a5)
                bpl.s   loc_5598E
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w   loc_55CAC
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.w Boss_ValkirieShootPattern2
loc_5598E:                              ; CODE XREF: Boss_ValkirieShootPattern1+1E   j
                                        ; Boss_ValkirieShootPattern1+26   j
                cmpi.w  #$720,$BC(a5)
                bmi.s   loc_559A6
                cmpi.w  #$820,$BC(a5)
                bpl.s   loc_559A6
                cmpi.w  #$F8,d0
                bpl.w Boss_ValkirieSpawnDualShot
loc_559A6:                              ; CODE XREF: Boss_ValkirieShootPattern1+46   j
                                        ; Boss_ValkirieShootPattern1+4E   j
                bra.w   loc_559B8
; ---------------------------------------------------------------------------
loc_559AA:                              ; CODE XREF: Boss_ValkirieShootPattern1+6   j
                bsr.w Boss_ValkirieSetFacing
                lea     word_56262(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_559B8:                              ; CODE XREF: Boss_ValkirieShootPattern1:loc_559A6   j
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                move.w  #$CC80,d0
                move.w  #$CC80,d1
                bsr.w Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieShootPattern1
; Checks facing and distance to player, decides between projectile attacks or melee charge
Boss_ValkirieAttackDecision:                              ; CODE XREF: Boss_ValkirieRisingAttack+42   j  ; was: sub_559D8
                                        ; DATA XREF: ROM:000557C4   o
                tst.w   $58(a5)
                bpl.s   loc_559E2
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_559E2:                              ; CODE XREF: Boss_ValkirieAttackDecision+4   j
                bclr    #0,$23E(a5)
                beq.s   loc_55A32
                jsr Boss_ValkirieCheckFacing(pc)   ; (pc)
                nop
                bmi.s   loc_55A30
                cmpi.w  #$30,d0 ; '0'
                bmi.s   loc_55A30
                cmpi.w  #$A0,d0
                bpl.s   loc_55A30
                move.w  d0,d1
                cmpi.w  #$46,d1 ; 'F'
                bpl.s   loc_55A0E
                move.l  #$8000,d0
                bra.s   loc_55A28
; ---------------------------------------------------------------------------
loc_55A0E:                              ; CODE XREF: Boss_ValkirieAttackDecision+2C   j
                move.l  #$FFFE8000,d0
                cmpi.w  #$70,d1 ; 'p'
                bpl.s   loc_55A1C
                bra.s   loc_55A28
; ---------------------------------------------------------------------------
loc_55A1C:                              ; CODE XREF: Boss_ValkirieAttackDecision+40   j
                tst.w   (word_FFFF0E).w
                beq.s   loc_55A28
                move.l  #$FFFDC000,d0
loc_55A28:                              ; CODE XREF: Boss_ValkirieAttackDecision+34   j
                                        ; Boss_ValkirieAttackDecision+42   j ...
                bsr.w Boss_ValkirieSetVelocityFacing
                bra.w Boss_ValkirieChargeAttack
; ---------------------------------------------------------------------------
loc_55A30:                              ; CODE XREF: Boss_ValkirieAttackDecision+18   j
                                        ; Boss_ValkirieAttackDecision+1E   j ...
                bra.s   loc_55A3C
; ---------------------------------------------------------------------------
loc_55A32:                              ; CODE XREF: Boss_ValkirieAttackDecision+10   j
                lea     word_5628E(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55A3C:                              ; CODE XREF: Boss_ValkirieAttackDecision:loc_55A30   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                move.w  a5,d0
                move.w  a5,d1
                bsr.w Boss_ValkirieSpawnProjectile2
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$FFFE0000,d0
                bsr.w Boss_ValkirieSetVelocityFacing
                move.b  #$5A,d0 ; 'Z'
                jsr (Sound_PlaySFX).l
; End of function Boss_ValkirieAttackDecision
; Rises upward with vertical velocity, spawns projectiles when flag set, transitions states
Boss_ValkirieRisingAttack:                              ; DATA XREF: ROM:000557C6   o  ; was: sub_55A68
                addi.l  #$2000,$1C(a5)
                bclr    #0,$23E(a5)
                bne.s   loc_55A82
                lea     word_5628E(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55A82:                              ; CODE XREF: Boss_ValkirieRisingAttack+E   j
                move.w  #$A,4(a5)
                clr.b   $23E(a5)
                move.w  #$CEC0,d0
                move.w  #$CC80,d1
                bsr.w Boss_ValkirieSpawnProjectile1
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$5A,d0 ; 'Z'
                jsr (Sound_PlaySFX).l
                bra.w Boss_ValkirieAttackDecision
; End of function Boss_ValkirieRisingAttack
; Sets state $22, spawns two projectiles at $CEC0 positions, clears state flags
Boss_ValkirieSpawnDualShot:                              ; CODE XREF: Boss_ValkirieShootPattern1+54   j  ; was: sub_55AAE
                move.w  #$22,4(a5) ; '"'
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieSpawnDualShot
; Checks health thresholds ($810/$730) and spawns projectiles based on part status
Boss_ValkirieHealthCheckAttack:                              ; DATA XREF: ROM:000557DC   o  ; was: sub_55ACE
                bclr    #7,$23E(a5)
                beq.s   loc_55AF2
                tst.w   $54(a5)
                bne.s   loc_55AE8
                cmpi.w  #$810,$BC(a5)
                bmi.s   loc_55AF2
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55AE8:                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+C   j
                cmpi.w  #$730,$BC(a5)
                bmi.w   loc_55930
loc_55AF2:                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+6   j
                                        ; Boss_ValkirieHealthCheckAttack+14   j
                bclr    #0,$23E(a5)
                beq.s   loc_55B08
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
                bra.s   loc_55B1C
; ---------------------------------------------------------------------------
loc_55B08:                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+2A   j
                bclr    #1,$23E(a5)
                beq.s   loc_55B1C
                move.w  #$CC80,d0
                move.w  #$CC80,d1
                bsr.w Boss_ValkirieSpawnProjectile1
loc_55B1C:                              ; CODE XREF: Boss_ValkirieHealthCheckAttack+38   j
                                        ; Boss_ValkirieHealthCheckAttack+40   j
                lea     word_562A4(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; End of function Boss_ValkirieHealthCheckAttack
; Charges with velocity, spawns projectile, selects movement pattern based on player position
Boss_ValkirieChargeAttack:                              ; CODE XREF: Boss_ValkirieAttackDecision+54   j  ; was: sub_55B26
                move.w  #$E,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  a5,d0
                move.w  a5,d1
                bsr.w Boss_ValkirieSpawnProjectile2
                move.b  #$5A,d0 ; 'Z'
                jsr (Sound_PlaySFX).l
                cmpi.w  #$120,(dword_FFA414).w
                bmi.s   loc_55B6C
                tst.w   (dword_FFA41C).w
                bmi.s   loc_55B82
loc_55B62:                              ; CODE XREF: Boss_ValkirieChargeAttack+6E   j
                move.l  #word_56330,$41C(a5)
                bra.s Boss_Valkirie_ChargeApplyGravity
; ---------------------------------------------------------------------------
loc_55B6C:                              ; CODE XREF: Boss_ValkirieChargeAttack+34   j
                cmpi.w  #$E0,(dword_FFA414).w
                bmi.s   loc_55B8C
                btst    #1,(word_FFA000+1).w
                bne.s   loc_55B82
                tst.w   (dword_FFA41C).w
                bmi.s   loc_55B96
loc_55B82:                              ; CODE XREF: Boss_ValkirieChargeAttack+3A   j
                                        ; Boss_ValkirieChargeAttack+54   j
                move.l  #word_56350,$41C(a5)
                bra.s Boss_Valkirie_ChargeApplyGravity
; ---------------------------------------------------------------------------
loc_55B8C:                              ; CODE XREF: Boss_ValkirieChargeAttack+4C   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_55B62
loc_55B96:                              ; CODE XREF: Boss_ValkirieChargeAttack+5A   j
                move.l  #word_56370,$41C(a5)
; Applies gravity during charge attack and spawns bullets
Boss_Valkirie_ChargeApplyGravity:                              ; CODE XREF: Boss_ValkirieChargeAttack+44   j  ; was: loc_55B9E
                                        ; Boss_ValkirieChargeAttack+64   j
                                        ; DATA XREF: ...
                addi.l  #$2000,$1C(a5)
                bclr    #0,$23E(a5)
                bne.s   loc_55BBA
                bsr.w Projectile_ValkirieBullet
                movea.l $41C(a5),a1
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55BBA:                              ; CODE XREF: Boss_ValkirieChargeAttack+86   j
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$858(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CE60,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
                lea     word_55C64(pc),a0
                nop
                bsr.w Boss_ValkirieUpdateParts
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ValkirieChargeAttack
; Updates charge velocity, handles part destruction flag, checks collision conditions
Boss_ValkirieChargeUpdate:                              ; DATA XREF: ROM:000557CA   o  ; was: sub_55BF0
                tst.w   $58(a5)
                bpl.s   loc_55C02
                clr.l   $8B8(a5)
                bsr.w Boss_ValkirieSpawnEffect
                bra.w   loc_55930
; ---------------------------------------------------------------------------
loc_55C02:                              ; CODE XREF: Boss_ValkirieChargeUpdate+4   j
                tst.l   $8B8(a5)
                beq.s   loc_55C28
                bpl.s   loc_55C1A
                addi.l  #$1000,$8B8(a5)
                bmi.s   loc_55C28
                clr.l   $8B8(a5)
                bra.s   loc_55C28
; ---------------------------------------------------------------------------
loc_55C1A:                              ; CODE XREF: Boss_ValkirieChargeUpdate+18   j
                subi.l  #$1000,$8B8(a5)
                bpl.s   loc_55C28
                clr.l   $8B8(a5)
loc_55C28:                              ; CODE XREF: Boss_ValkirieChargeUpdate+16   j
                                        ; Boss_ValkirieChargeUpdate+22   j ...
                bclr    #2,$23E(a5)
                beq.s   loc_55C3A
                lea     word_55C82(pc),a0
                nop
                bsr.w Boss_ValkirieDestroyParts
loc_55C3A:                              ; CODE XREF: Boss_ValkirieChargeUpdate+3E   j
                bclr    #3,$23E(a5)
                beq.s   loc_55C58
                tst.w   (word_FFFF0E).w
                beq.s   loc_55C58
                bsr.w Boss_ValkirieCheckFacing
                bmi.s   loc_55C58
                cmpi.w  #$80,d0
                bpl.s   loc_55C58
                bra.w Boss_ValkirieCollisionCheck
; ---------------------------------------------------------------------------
loc_55C58:                              ; CODE XREF: Boss_ValkirieChargeUpdate+50   j
                                        ; Boss_ValkirieChargeUpdate+56   j ...
                bsr.w Projectile_ValkirieBullet
                movea.l $41C(a5),a1
                bra.w Boss_ValkirieBattleStart
; End of function Boss_ValkirieChargeUpdate
; ---------------------------------------------------------------------------
word_55C64:     dc.w $4D, $7840, $CB60, $F808, $F808, $CBC0, $FA06, $FA06, $CC20, $FA06, $FA06, $CCE0, $FC04, $FC04, 0
                                        ; DATA XREF: Boss_ValkirieChargeAttack+B6   o
word_55C82:     dc.w $BF00, $540, $600, $6C0, 0
                                        ; DATA XREF: Boss_ValkirieChargeUpdate+40   o


; Bullet projectile handler
Projectile_ValkirieBullet:                              ; CODE XREF: Boss_ValkirieChargeAttack+88   p  ; was: sub_55C8C
                                        ; sub_55BF0:loc_55C58   p ...
                movea.w #(byte_FFCCE0-M68K_RAM),a1
                moveq   #$18,d3
                btst    #0,(word_FFA000+1).w
                bne.s   locret_55CA2
                jsr (Projectile_FindFreeSlot).l
                beq.s   loc_55CA4
locret_55CA2:                           ; CODE XREF: Projectile_ValkirieBullet+C   j
                rts
; ---------------------------------------------------------------------------
loc_55CA4:                              ; CODE XREF: Projectile_ValkirieBullet+14   j
                moveq   #0,d4
                jmp Projectile_CopyValkirieData
; ---------------------------------------------------------------------------
loc_55CAC:                              ; CODE XREF: Boss_ValkirieShootPattern1+30   j
                move.w  #$14,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CC20,d0
                move.w  #$CC80,d1
                bsr.w Boss_ValkirieSpawnProjectile1
                move.w  #$53,$11C(a5) ; 'S'
                bsr.w Boss_ValkirieMovePattern1
; End of function Projectile_ValkirieBullet
; Checks if boss takes damage
Boss_ValkirieDamageCheck:                              ; DATA XREF: ROM:000557CE   o  ; was: sub_55CD6
                tst.w   $58(a5)
                bmi.w   loc_55D1A
                bclr    #3,$23E(a5)
                beq.s   loc_55CF2
                move.w  #$CC80,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
loc_55CF2:                              ; CODE XREF: Boss_ValkirieDamageCheck+E   j
                bclr    #0,$23E(a5)
                beq.s   loc_55D04
                move.b  #$4F,d0 ; 'O'
                jsr (Sound_PlaySFX).l
loc_55D04:                              ; CODE XREF: Boss_ValkirieDamageCheck+22   j
                subq.w  #1,$11C(a5)
                bne.s   loc_55D10
                bset    #4,(byte_FFC9DE).w
loc_55D10:                              ; CODE XREF: Boss_ValkirieDamageCheck+32   j
                lea     word_562CA(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55D1A:                              ; CODE XREF: Boss_ValkirieDamageCheck+4   j
                bset    #7,(byte_FFC9DE).w
                move.w  #$24,4(a5) ; '$'
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Camera state 8 for boss battle tracking
Camera_BossMode_State8:                              ; DATA XREF: ROM:000557DE   o  ; was: loc_55D34
                moveq   #0,d1
                move.w  (word_FFD1D0).w,d0
                sub.w   $4F0(a5),d0
                bpl.s   loc_55D42
                neg.w   d0
loc_55D42:                              ; CODE XREF: Boss_ValkirieDamageCheck+68   j
                cmpi.w  #$10,d0
                bpl.s   loc_55D4A
                addq.w  #1,d1
loc_55D4A:                              ; CODE XREF: Boss_ValkirieDamageCheck+70   j
                move.w  (word_FFD1D4).w,d0
                sub.w   $4F4(a5),d0
                bpl.s   loc_55D56
                neg.w   d0
loc_55D56:                              ; CODE XREF: Boss_ValkirieDamageCheck+7C   j
                cmpi.w  #$10,d0
                bpl.s   loc_55D60
                tst.w   d1
                bne.s   loc_55D6A
loc_55D60:                              ; CODE XREF: Boss_ValkirieDamageCheck+84   j
                lea     word_562F0(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55D6A:                              ; CODE XREF: Boss_ValkirieDamageCheck+88   j
                bset    #5,(byte_FFC9DE).w
                bra.w   loc_55930
; End of function Boss_ValkirieDamageCheck
; Collision detection with player
Boss_ValkirieCollisionCheck:                              ; CODE XREF: Boss_ValkirieShootPattern1+14   j  ; was: sub_55D74
                                        ; Boss_ValkirieChargeUpdate+64   j
                move.w  #$12,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #4,d0
                move.w  d0,$11C(a5)
                lea     word_55E5E(pc),a0
                nop
                bsr.w Boss_ValkirieDestroyParts
                clr.w   $54(a5)
                tst.w   d1
                bmi.s   loc_55DAE
                move.w  #$100,$54(a5)
loc_55DAE:                              ; CODE XREF: Boss_ValkirieCollisionCheck+32   j
                move.w  #$C6E0,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile1
                lea     word_56390(pc),a1
                nop
                bsr.w Boss_ValkirieBattleStart
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bra.w Boss_ValkirieSpawnProjectile1
; End of function Boss_ValkirieCollisionCheck
; Updates boss health
Boss_ValkirieUpdateHealth:                              ; DATA XREF: ROM:000557CC   o  ; was: sub_55DD0
                bclr    #0,$23E(a5)
                beq.s   loc_55DEC
                lea     word_55E40(pc),a0
                nop
                bsr.w Boss_ValkirieUpdateParts
                move.b  #$C6,d0
                jsr (Sound_PlaySFX).l
loc_55DEC:                              ; CODE XREF: Boss_ValkirieUpdateHealth+6   j
                bclr    #1,$23E(a5)
                beq.s   loc_55E20
                subq.w  #1,$11C(a5)
                bmi.w   loc_55E2E
                jsr Boss_ValkirieCheckFacing(pc)   ; (pc)
                nop
                bmi.w   loc_55E2E
                cmpi.w  #$80,d0
                bmi.s   loc_55E20
                btst    #0,(dword_FFFF08+1).w
                beq.w   loc_55E2E
                lea     word_55E5E(pc),a0
                nop
                bsr.w Boss_ValkirieDestroyParts
loc_55E20:                              ; CODE XREF: Boss_ValkirieUpdateHealth+22   j
                                        ; Boss_ValkirieUpdateHealth+3A   j
                bsr.w Projectile_ValkirieBullet
                lea     word_56390(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55E2E:                              ; CODE XREF: Boss_ValkirieUpdateHealth+28   j
                                        ; Boss_ValkirieUpdateHealth+32   j ...
                lea     word_55E5E(pc),a0
                nop
                bsr.w Boss_ValkirieDestroyParts
                bsr.w Boss_ValkirieSpawnEffect
                bra.w   loc_55930
; End of function Boss_ValkirieUpdateHealth
; ---------------------------------------------------------------------------
word_55E40:     dc.w 7, $3242, $CB60, $F808, $F808, $CBC0, $FA06, $FA06, $CC20, $FA06, $FA06, $CCE0, $FC04, $FC04, 0
                                        ; DATA XREF: Boss_ValkirieUpdateHealth+8   o
word_55E5E:     dc.w $BD00, $540, $600, $6C0, 0
                                        ; DATA XREF: Boss_ValkirieCollisionCheck+22   o
                                        ; Boss_ValkirieUpdateHealth+46   o ...


; Checks damage flicker flag (bit 6 of $23E) and timing for visual effect
Boss_ValkirieFlickerCheck:
                tst.w   (word_FFFF0E).w  ; was: sub_55E68
                beq.s   locret_55E7C
                bclr    #6,$23E(a5)
                beq.s   locret_55E7C
                btst    #0,(dword_FFFF08).w
locret_55E7C:                           ; CODE XREF: Boss_ValkirieFlickerCheck+4   j
                                        ; Boss_ValkirieFlickerCheck+C   j
                rts
; End of function Boss_ValkirieFlickerCheck
; Spawns visual effect sprite from pointer table at $1BEFC
Boss_ValkirieSpawnEffect:                              ; CODE XREF: Boss_ValkirieChargeUpdate+A   p  ; was: sub_55E7E
                                        ; Boss_ValkirieUpdateHealth+68   p
                lea     (word_1BEFC).l,a1
                jmp Sprite_InitFromPointerTable
; End of function Boss_ValkirieSpawnEffect
; Updates multiple Valkirie body parts with animation IDs, velocities, and flags from table
Boss_ValkirieUpdateParts:                              ; CODE XREF: Boss_ValkirieChargeAttack+BC   p  ; was: sub_55E8A
                                        ; Boss_ValkirieUpdateHealth+E   p ...
                move.w  (a0)+,d1
                moveq   #0,d2
                move.b  (a0)+,d2
                move.b  (a0)+,d3
                ext.w   d2
                swap    d2
                asr.l   #4,d2
                tst.w   $54(a5)
                bne.s   loc_55EA0
                neg.l   d2
loc_55EA0:                              ; CODE XREF: Boss_ValkirieUpdateParts+12   j
                                        ; Boss_ValkirieUpdateParts+2C   j
                move.w  (a0)+,d0
                beq.s   locret_55EB8
                movea.w d0,a1
                move.w  d1,$26(a1)
                move.l  d2,$18(a1)
                or.b    d3,$21(a1)
                move.l  (a0)+,$2C(a1)
                bra.s   loc_55EA0
; ---------------------------------------------------------------------------
locret_55EB8:                           ; CODE XREF: Boss_ValkirieUpdateParts+18   j
                rts
; End of function Boss_ValkirieUpdateParts
; Destroys boss parts on defeat
Boss_ValkirieDestroyParts:                              ; CODE XREF: Boss_ValkirieChargeUpdate+46   p  ; was: sub_55EBA
                                        ; Boss_ValkirieCollisionCheck+28   p ...
                move.b  (a0)+,d1
                move.b  (a0)+,d2
loc_55EBE:                              ; CODE XREF: Boss_ValkirieDestroyParts+12   j
                move.w  (a0)+,d0
                beq.s   locret_55ECE
                movea.w d0,a1
                and.b   d1,-$39BF(a1)
                clr.l   -$39C8(a1)
                bra.s   loc_55EBE
; ---------------------------------------------------------------------------
locret_55ECE:                           ; CODE XREF: Boss_ValkirieDestroyParts+6   j
                rts
; End of function Boss_ValkirieDestroyParts
; Shooting pattern 2
Boss_ValkirieShootPattern2:                              ; CODE XREF: Boss_ValkirieShootPattern1+3C   j  ; was: sub_55ED0
                move.w  #$18,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CEC0,d0
                move.w  #$CEC0,d1
                bsr.w Boss_ValkirieSpawnProjectile2
; End of function Boss_ValkirieShootPattern2
; Shooting pattern 3
Boss_ValkirieShootPattern3:                              ; DATA XREF: ROM:000557D2   o  ; was: sub_55EF0
                bclr    #0,$23E(a5)
                bne.s   loc_55F02
                lea     word_562FA(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F02:                              ; CODE XREF: Boss_ValkirieShootPattern3+6   j
                addq.w  #2,4(a5)
; Camera state 6 for boss battle positioning
Camera_BossMode_State6:                              ; DATA XREF: ROM:000557D4   o  ; was: loc_55F06
                bclr    #0,$23E(a5)
                bne.s   loc_55F18
                lea     word_562FA(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F18:                              ; CODE XREF: Boss_ValkirieShootPattern3+1C   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.w  #3,(word_FFA010).w
                move.b  #$A0,d0
                jsr (Sound_PlaySFX).l
                bsr.w Boss_ValkirieSetPartFlash
; End of function Boss_ValkirieShootPattern3
; Spawns projectile type 3
Boss_ValkirieSpawnProjectile3:                              ; DATA XREF: ROM:000557D6   o  ; was: sub_55F34
                bclr    #0,$23E(a5)
                bne.s   loc_55F4E
                addq.w  #6,$11C(a5)
                bsr.w Boss_ValkirieUpdatePartOffsets
                lea     word_562FA(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F4E:                              ; CODE XREF: Boss_ValkirieSpawnProjectile3+6   j
                addq.w  #2,4(a5)
                bclr    #6,$2C1(a5)
; Camera state 7 for boss battle adjustment
Camera_BossMode_State7:                              ; DATA XREF: ROM:000557D8   o  ; was: loc_55F58
                subi.w  #$A,$11C(a5)
                bmi.s   loc_55F6E
                bsr.w Boss_ValkirieUpdatePartOffsets
                lea     word_562FA(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; ---------------------------------------------------------------------------
loc_55F6E:                              ; CODE XREF: Boss_ValkirieSpawnProjectile3+2A   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  $2F2(a5),$2F4(a5)
                move.w  $352(a5),$354(a5)
                move.b  #$F1,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ValkirieSpawnProjectile3
; Spawns projectile type 4
Boss_ValkirieSpawnProjectile4:                              ; DATA XREF: ROM:000557DA   o  ; was: sub_55F96
                tst.w   $58(a5)
                bmi.w   loc_55930
                lea     word_56322(pc),a1
                nop
                bra.w Boss_ValkirieBattleStart
; End of function Boss_ValkirieSpawnProjectile4
; Updates Y-offsets of parts at $2F4 and $354 based on base offset $11C
Boss_ValkirieUpdatePartOffsets:                              ; CODE XREF: Boss_ValkirieSpawnProjectile3+C   p  ; was: sub_55FA8
                                        ; Boss_ValkirieSpawnProjectile3+2C   p
                move.w  $11C(a5),d0
                move.w  $2F2(a5),d1
                add.w   d0,d1
                move.w  d1,$2F4(a5)
                move.w  $352(a5),d1
                add.w   d0,d1
                move.w  d1,$354(a5)
                rts
; End of function Boss_ValkirieUpdatePartOffsets
; Sets part flash effect flag, duration ($64 frames), and velocity values
Boss_ValkirieSetPartFlash:                              ; CODE XREF: Boss_ValkirieShootPattern3+40   p  ; was: sub_55FC2
                bset    #6,$2C1(a5)
                move.w  #$64,$2C6(a5) ; 'd'
                move.l  #$F808F808,$2CC(a5)
                rts
; End of function Boss_ValkirieSetPartFlash
; Sets X-velocity from d0, negates if facing flag ($54) indicates left direction
Boss_ValkirieSetVelocityFacing:                              ; CODE XREF: Boss_ValkirieAttackDecision:loc_55A28   p  ; was: sub_55FD8
                                        ; Boss_ValkirieAttackDecision+82   p
                tst.w   $54(a5)
                beq.s   loc_55FE0
                neg.l   d0
loc_55FE0:                              ; CODE XREF: Boss_ValkirieSetVelocityFacing+4   j
                move.l  d0,$18(a5)
                rts
; End of function Boss_ValkirieSetVelocityFacing
; Spawns projectile type 1
Boss_ValkirieSpawnProjectile1:                              ; CODE XREF: Boss_ValkirieAttackState1+40   p  ; was: sub_55FE6
                                        ; Boss_ValkirieShootPattern1+86   p ...
                move.w  #$140,d4
                bsr.s Boss_ValkirieSpawnProjectile2
                move.w  d4,$14(a0)
                rts
; End of function Boss_ValkirieSpawnProjectile1
; Spawns projectile type 2
Boss_ValkirieSpawnProjectile2:                              ; CODE XREF: Boss_ValkirieAttackDecision+70   p  ; was: sub_55FF2
                                        ; Boss_ValkirieChargeAttack+20   p ...
                moveq   #0,d2
                movea.w $48(a5),a0
                bclr    d2,2(a0)
                movea.w $4A(a5),a0
                bclr    d2,2(a0)
                move.w  d0,$48(a5)
                move.w  d1,$4A(a5)
                movea.w d0,a0
                bset    d2,2(a0)
                movea.w d1,a0
                bset    d2,2(a0)
                rts
; End of function Boss_ValkirieSpawnProjectile2
; Checks player facing direction
Boss_ValkirieCheckFacing:                              ; CODE XREF: Boss_ValkirieAttackDecision+12   p  ; was: sub_5601A
                                        ; Boss_ValkirieChargeUpdate+58   p ...
                jsr (Physics_CalculateDistanceTo).l
                tst.w   $54(a5)
                beq.s   loc_5602E
                tst.w   d1
                bmi.s   loc_56032
loc_5602A:                              ; CODE XREF: Boss_ValkirieCheckFacing+16   j
                moveq   #1,d3
                rts
; ---------------------------------------------------------------------------
loc_5602E:                              ; CODE XREF: Boss_ValkirieCheckFacing+A   j
                tst.w   d1
                bmi.s   loc_5602A
loc_56032:                              ; CODE XREF: Boss_ValkirieCheckFacing+E   j
                moveq   #$FFFFFFFF,d3
                rts
; End of function Boss_ValkirieCheckFacing
; Sets boss facing direction
Boss_ValkirieSetFacing:                              ; CODE XREF: Boss_ValkirieShootPattern1:loc_559AA   p  ; was: sub_56036
                                        ; Boss_ArtemisSpawnProjectile6+6   p
                jsr (Physics_CalculateDistanceTo).l
                clr.w   $54(a5)
                tst.w   d1
                bmi.s   locret_5604A
                move.w  #$100,$54(a5)
locret_5604A:                           ; CODE XREF: Boss_ValkirieSetFacing+C   j
                rts
; End of function Boss_ValkirieSetFacing
; Battle start initialization
Boss_ValkirieBattleStart:                              ; CODE XREF: Boss_ValkirieInitParts+2E   j  ; was: sub_5604C
                                        ; Boss_ValkirieIdleState+52   j ...
                bsr.w Boss_ValkirieAnimationScript
                bsr.w Boss_ValkirieUpdateSprites
                moveq   #$18,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieBattleStart
; Updates boss sprites
Boss_ValkirieUpdateSprites:                              ; CODE XREF: Boss_ValkirieBattleStart+4   p  ; was: sub_5605C
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                move.b  $44(a0),d1
                ext.w   d1
                move.w  $B2(a5),d0
                add.w   d1,d0
                move.w  d0,$B4(a5)
                move.w  $112(a5),d0
                add.w   d1,d0
                move.w  d0,$114(a5)
                move.b  $48(a0),d1
                ext.w   d1
                move.w  $172(a5),d0
                add.w   d1,d0
                move.w  d0,$174(a5)
                rts
; End of function Boss_ValkirieUpdateSprites
; Animation script interpreter
Boss_ValkirieAnimationScript:                              ; CODE XREF: Boss_ValkirieBattleStart   p  ; was: sub_56190
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_5620A
loc_5619A:                              ; CODE XREF: Boss_ValkirieAnimationScript+24   j
                                        ; Boss_ValkirieAnimationLoop+E   j
                move.w  $58(a5),d0
                bmi.w   loc_5621A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_561B6
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_5619A
; ---------------------------------------------------------------------------
loc_561B6:                              ; CODE XREF: Boss_ValkirieAnimationScript+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_ValkirieAnimationLoop
                move.w  d3,$58(a5)
                bra.w   loc_5621A
; End of function Boss_ValkirieAnimationScript
nullsub_128:
                rts
; End of function nullsub_128


; Animation loop handler
Boss_ValkirieAnimationLoop:                              ; CODE XREF: Boss_ValkirieAnimationScript+2E   j  ; was: sub_561CA
                cmpi.w  #$FFFF,d3
                bne.s   loc_561DA
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_5619A
; ---------------------------------------------------------------------------
loc_561DA:                              ; CODE XREF: Boss_ValkirieAnimationLoop+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_ValkirieAnimationUpdate
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5621A
loc_5620A:                              ; CODE XREF: Boss_ValkirieAnimationScript+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_5621A:                              ; CODE XREF: Boss_ValkirieAnimationScript+E   j
                                        ; Boss_ValkirieAnimationScript+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationLoop
; Animation frame update
Boss_ValkirieAnimationUpdate:                              ; CODE XREF: Boss_ValkirieAnimationLoop+24   p  ; was: sub_56224
                movea.l $2FC(a5),a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieAnimationUpdate
; Loads 18 animation frame delays into RAM buffer at $FF9400
Anim_ValkirieLoadFrames:
                moveq   #$12,d7  ; was: sub_56238
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Anim_ValkirieLoadFrames
; ---------------------------------------------------------------------------
word_56244:     dc.w $A0F, $190, $606, $190, $1C1C, $1A4, $8002, $A0F, $1B8, $606, $1B8, $1C1C, $1CC, $8001, $FFFF
                                        ; DATA XREF: Boss_ValkirieInitParts:loc_558AA   o
word_56262:     dc.w $810, 0, $1010, 0, $8001, $810, $14, $1010, $14, $8001, $FFFF, $810, $140, $1010, $140, $8001
                                        ; DATA XREF: Boss_ValkirieIdleState:loc_55900   o
                                        ; sub_5590A:loc_55926   o ...
                dc.w $810, $168, $1010, $168, $8001, $FFFF
word_5628E:     dc.w $E12, $154, $8001, $808, $154, $E12, $17C, $8001, $707, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieAttackDecision:loc_55A32   o
                                        ; Boss_ValkirieRisingAttack+10   o
word_562A4:     dc.w $101C, $1CC, $808, $1CC, $8081, $50C, $190, $808, $190, $101C, $1A4, $707, $1A4, $8082, $80C, $1B8
                                        ; DATA XREF: Boss_ValkirieHealthCheckAttack:loc_55B1C   o
                dc.w $606, $1B8, $FFFF
word_562CA:     dc.w $840, $28, $1018, $1E0, $1818, $1E0, $840, $1F4, $8001, $A0E, $1F4, $606, $1F4, $8008, $507, $208
                                        ; DATA XREF: Boss_ValkirieDamageCheck:loc_55D10   o
                dc.w $808, $208, $FFFE
word_562F0:     dc.w $4058, $21C, $7070, $21C, $FFFF
                                        ; DATA XREF: Boss_ValkirieDamageCheck:loc_55D60   o
word_562FA:     dc.w $1020, $F0, $712, $244, $A0A, $244, $8001, $1258, $258, $608, $258, $8001, $3838, $258, $1870, $26C
                                        ; DATA XREF: Boss_ValkirieShootPattern3+8   o
                                        ; Boss_ValkirieShootPattern3+1E   o ...
                dc.w $8001, $3232, $26C, $FFFE
word_56322:     dc.w $A10, $280, $1313, $280, $815, $26C, $FFFE
                                        ; DATA XREF: Boss_ValkirieSpawnProjectile4+8   o
word_56330:     dc.w $1010, $3C, $210, $50, $8003, $204, $50, $505, $50, $8004, $1418, $3C, $8008, $1818, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B62   o
word_56350:     dc.w $1010, $3C, $210, $64, $8003, $204, $64, $404, $64, $8004, $1418, $3C, $8008, $1818, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B82   o
word_56370:     dc.w $1A1A, $78, $420, $8C, $8003, $508, $8C, $808, $8C, $8004, $101A, $78, $8008, $1212, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B96   o
word_56390:     dc.w $408, $F0, $204, $F0, $303, $F0, $106, $12C, $8001, $204, $12C, $303, $12C, $8002, $306, $F0
                                        ; DATA XREF: Boss_ValkirieCollisionCheck+46   o
                                        ; Boss_ValkirieUpdateHealth+54   o
                dc.w $204, $F0, $202, $F0, $106, $104, $8001, $204, $104, $303, $104, $8002, $106, $F0, $103, $F0
                dc.w $202, $F0, $106, $104, $8001, $204, $118, $303, $118, $8002, $FFFF
word_563E6:	binclude	"data/other/word_563E6.bin"
word_563E6_End:


; Movement pattern 1
Boss_ValkirieMovePattern1:                              ; CODE XREF: Boss_ValkirieIntroStop+52   p  ; was: sub_566B6
                                        ; Projectile_ValkirieBullet+46   p
                movea.w #(byte_FFCFE0-M68K_RAM),a0
                moveq   #5,d7
loc_566BC:                              ; CODE XREF: Boss_ValkirieMovePattern1+C   j
                jsr (Object_Clear96Bytes).l
                dbf     d7,loc_566BC
                movea.w #(byte_FFCFE0-M68K_RAM),a5
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #5,d7
                movea.l #off_59F5E,a0
                movea.l #word_59F76,a1
                movea.l #word_59F7C,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$47C,(a5)
                move.w  #$8C00,2(a5)
                move.w  #$65,$206(a5) ; 'e'
                move.l  #$F808F808,$20C(a5)
                move.l  #$F010F010,$208(a5)
                move.b  #3,(byte_FFC9DE).w
                movea.w a5,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_ValkirieMovePattern1
; Movement pattern 2
Boss_ValkirieMovePattern2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_5671A
                btst    #1,(byte_FFC9DE).w
                beq.w   loc_56804
                bclr    #4,(byte_FFC9DE).w
                beq.s   loc_56770
                bclr    #1,(byte_FFC9DE).w
                move.w  #$D00,$1E2(a5)
                move.b  #$C0,$201(a5)
                move.b  #$10,$203(a5)
                move.w  #$D1C0,$48(a5)
                move.w  #$D1C0,$4A(a5)
                move.l  #$48000,d0
                clr.w   $23C(a5)
                tst.w   $54(a5)
                bne.s   loc_56768
                neg.l   d0
                move.w  #$100,$23C(a5)
loc_56768:                              ; CODE XREF: Boss_ValkirieMovePattern2+44   j
                move.l  d0,$1F8(a5)
                bra.w Boss_ValkirieMovePattern3
; ---------------------------------------------------------------------------
loc_56770:                              ; CODE XREF: Boss_ValkirieMovePattern2+10   j
                                        ; Boss_ValkirieMovePattern2+108   j
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  $54(a0),$54(a5)
                move.w  #$D160,$48(a5)
                move.w  #$D160,$4A(a5)
                move.w  $4F0(a0),$190(a5)
                move.w  $4F4(a0),$194(a5)
                move.w  $536(a0),$56(a5)
                bsr.w Boss_ValkirieMovePattern3
                moveq   #8,d5
                move.w  #$1F8,d6
                btst    #0,(byte_FFC9DE).w
                bne.s   loc_567D2
                cmpi.w  #$100,$B6(a5)
                beq.w   locret_568E2
                sub.w   d5,$B6(a5)
                and.w   d6,$B6(a5)
                move.w  $B6(a5),$116(a5)
                add.w   d5,$176(a5)
                and.w   d6,$176(a5)
                move.w  $176(a5),$1D6(a5)
                rts
; ---------------------------------------------------------------------------
loc_567D2:                              ; CODE XREF: Boss_ValkirieMovePattern2+8E   j
                cmpi.w  #$140,$B6(a5)
                beq.w   locret_568E2
                add.w   d5,$B6(a5)
                and.w   d6,$B6(a5)
                move.w  $B6(a5),$116(a5)
                sub.w   d5,$176(a5)
                and.w   d6,$176(a5)
                move.w  $176(a5),$1D6(a5)
                cmpi.w  #$140,$B6(a5)
                bne.w   locret_568E2
                rts
; ---------------------------------------------------------------------------
loc_56804:                              ; CODE XREF: Boss_ValkirieMovePattern2+6   j
                bclr    #5,(byte_FFC9DE).w
                beq.s   loc_56826
                bset    #1,(byte_FFC9DE).w
                clr.w   $1E2(a5)
                move.b  #$80,$201(a5)
                move.b  #$10,$203(a5)
                bra.w   loc_56770
; ---------------------------------------------------------------------------
loc_56826:                              ; CODE XREF: Boss_ValkirieMovePattern2+F0   j
                move.w  $56(a5),d1
                addi.w  #$20,d1 ; ' '
                andi.w  #$1E0,d1
                move.w  d1,$56(a5)
                bne.s   loc_56842
                move.b  #$C6,d0
                jsr (Sound_PlaySFX).l
loc_56842:                              ; CODE XREF: Boss_ValkirieMovePattern2+11C   j
                move.w  #$100,d1
                move.w  d1,$236(a5)
                subq.w  #1,$5C(a5)
                bne.s   loc_56858
                bset    #6,$21(a5)
                bra.s   loc_56860
; ---------------------------------------------------------------------------
loc_56858:                              ; CODE XREF: Boss_ValkirieMovePattern2+134   j
                bpl.s   loc_56860
                move.w  #$FFFF,$5C(a5)
loc_56860:                              ; CODE XREF: Boss_ValkirieMovePattern2+13C   j
                                        ; sub_5671A:loc_56858   j
                bsr.w Boss_ValkirieMovePattern3
                move.w  (dword_FFA900).w,d1
                add.w   $10(a5),d1
                move.w  $23C(a5),d2
                btst    #7,(byte_FFC9DE).w
                beq.s   loc_5687C
                bsr.w Boss_ValkirieCalculateAngleToPlayer
loc_5687C:                              ; CODE XREF: Boss_ValkirieMovePattern2+15C   j
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d2.w),d0
                move.w  (a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                move.l  d0,d2
                move.l  d1,d3
                asl.l   #3,d2
                asl.l   #3,d3
                tst.l   d2
                bmi.s   loc_568AC
                add.l   d0,$1FC(a5)
                bmi.s   loc_568BC
                cmp.l   $1FC(a5),d2
                bpl.s   loc_568BC
                move.l  d2,$1FC(a5)
                bra.s   loc_568BC
; ---------------------------------------------------------------------------
loc_568AC:                              ; CODE XREF: Boss_ValkirieMovePattern2+17E   j
                add.l   d0,$1FC(a5)
                bpl.s   loc_568BC
                cmp.l   $1FC(a5),d2
                bmi.s   loc_568BC
                move.l  d2,$1FC(a5)
loc_568BC:                              ; CODE XREF: Boss_ValkirieMovePattern2+184   j
                                        ; Boss_ValkirieMovePattern2+18A   j ...
                tst.l   d3
                bmi.s   loc_568D2
                add.l   d1,$1F8(a5)
                bmi.s   locret_568E2
                cmp.l   $1F8(a5),d3
                bpl.s   locret_568E2
                move.l  d3,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_568D2:                              ; CODE XREF: Boss_ValkirieMovePattern2+1A4   j
                add.l   d1,$1F8(a5)
                bpl.s   locret_568E2
                cmp.l   $1F8(a5),d3
                bmi.s   locret_568E2
                move.l  d3,$1F8(a5)
locret_568E2:                           ; CODE XREF: Boss_ValkirieMovePattern2+96   j
                                        ; Boss_ValkirieMovePattern2+BE   j ...
                rts
; End of function Boss_ValkirieMovePattern2
; Sets part Y-velocity to $2C000 or $FFFD4000 based on flag in $23E
Boss_ValkirieSetPartVelocity1:
                tst.w   $23E(a5)  ; was: sub_568E4
                beq.s   loc_568F4
                move.l  #$2C000,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_568F4:                              ; CODE XREF: Boss_ValkirieSetPartVelocity1+4   j
                move.l  #$FFFD4000,$1F8(a5)
                rts
; End of function Boss_ValkirieSetPartVelocity1
; Clears flip flag, sets render depth, sets Y-velocity based on $23E flag
Boss_ValkirieSetPartVelocity2:
                bclr    #6,$21(a5)  ; was: sub_568FE
                move.w  #4,$5C(a5)
                tst.w   $23E(a5)
                beq.s   loc_5691A
                move.l  #$12000,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_5691A:                              ; CODE XREF: Boss_ValkirieSetPartVelocity2+10   j
                move.l  #$FFFEE000,$1F8(a5)
                rts
; End of function Boss_ValkirieSetPartVelocity2
; Movement pattern 3
Boss_ValkirieMovePattern3:                              ; CODE XREF: Boss_ValkirieMovePattern2+52   j  ; was: sub_56924
                                        ; Boss_ValkirieMovePattern2+7E   p ...
                moveq   #4,d7
                jmp Boss_ValkiriePlayIntroSFX
; End of function Boss_ValkirieMovePattern3
; Calculates angle from boss to player position for targeting
Boss_ValkirieCalculateAngleToPlayer:                              ; CODE XREF: Boss_ValkirieMovePattern2+15E   p  ; was: sub_5692C
                move.w  (word_FFCB10).w,d0
                move.w  (word_FFCB14).w,d1
                sub.w   $1F0(a5),d0
                sub.w   $1F4(a5),d1
                jmp     (loc_355A).l
; End of function Boss_ValkirieCalculateAngleToPlayer
; Updates boss palette colors
Boss_ValkirieUpdatePalette:                              ; CODE XREF: Boss_ValkirieIntroMove+3A   p  ; was: sub_56942
                                        ; Boss_MedusaAttackState1+3A   p ...
                btst    #0,(word_FFA000+1).w
                bne.s   loc_5695E
                move.w  (word_FFE3FA).w,(word_FFE37A).w
                move.w  (word_FFE3FC).w,(word_FFE37C).w
                move.w  (word_FFE3FE).w,(word_FFE37E).w
                rts
; ---------------------------------------------------------------------------
loc_5695E:                              ; CODE XREF: Boss_ValkirieUpdatePalette+6   j
                move.w  word_56972(pc,d0.w),(word_FFE37A).w
                move.w  word_56972+2(pc,d0.w),(word_FFE37C).w
                move.w  word_56972+4(pc,d0.w),(word_FFE37E).w
                rts
; End of function Boss_ValkirieUpdatePalette
; ---------------------------------------------------------------------------
word_56972:     dc.w $28A, $8EE, $CEE, $28A, $8EE, $CEE, $68
                                        ; DATA XREF: Boss_ValkirieUpdatePalette:loc_5695E   r
                                        ; Boss_ValkirieUpdatePalette+22   r ...
                dc.w $4CE, $6EC, $A8, $6E, $8AC, $28A, $8EE
                dc.w $CEE, $28A, $8EE, $CEE, $28A, $8EE, $CEE


; Attack state 1 handler
Boss_MedusaAttackState1:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_5699C
                tst.w   4(a5)
                beq.w   loc_569E0
                tst.w   8(a5)
                beq.s   loc_569E0
                btst    #2,(byte_FF80EC).w
                bne.s   loc_569C8
                btst    #1,(byte_FF80EC).w
                bne.s   loc_569C8
                tst.w   (word_FF8200).w
                bne.s   loc_569C8
                moveq   #4,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_569C8:                              ; CODE XREF: Boss_MedusaAttackState1+14   j
                                        ; Boss_MedusaAttackState1+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #6,d0
                jsr (Boss_ValkirieUpdatePalette).l
                bsr.w Boss_MedusaFlashDamage
loc_569E0:                              ; CODE XREF: Boss_MedusaAttackState1+4   j
                                        ; Boss_MedusaAttackState1+C   j
                move.w  4(a5),d0
                movea.w off_569F0(pc,d0.w),a0
                adda.l  #Boss_MedusaAttackState2,a0
                jmp     (a0)
; End of function Boss_MedusaAttackState1
; ---------------------------------------------------------------------------
off_569F0:      dc.w Boss_MedusaAttackState2-Boss_MedusaAttackState2
                                        ; DATA XREF: Boss_MedusaAttackState1+48   r
                dc.w Boss_MedusaPlayerInputControl-Boss_MedusaAttackState2
                dc.w Boss_MedusaMovePattern2-Boss_MedusaAttackState2
                dc.w Boss_MedusaAnimationScript-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State4-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State5-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State6-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State7-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State8-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State9-Boss_MedusaAttackState2
                dc.w Boss_Valkirie_Behavior_State10-Boss_MedusaAttackState2


; Attack state 2 handler
Boss_MedusaAttackState2:                              ; DATA XREF: Boss_MedusaAttackState1+4C   o  ; was: sub_56A06
                                        ; ROM:off_569F0   o ...
                move.w  #1,8(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #off_59F88,a0
                movea.l #word_59FDC,a1
                movea.l #word_59FF2,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A01C,$2FC(a5)
                move.l  #word_57132,$35C(a5)
                move.w  #$430,(a5)
                move.w  #$CC00,2(a5)
                clr.w   (word_FF9804).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$450,(a0)
                clr.w   4(a0)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.l  $18(a0),$18(a5)
                move.l  $1C(a0),$1C(a5)
                move.w  #2,$1DE(a5)
                bra.w Boss_MedusaMovePattern1
; End of function Boss_MedusaAttackState2
; Initializes Medusa boss position and state parameters
Boss_MedusaInitPositionState:
                move.w  #2,4(a5)  ; was: sub_56A8A
                clr.w   (word_FFA02A).w
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_MedusaInitPositionState
; Processes player directional input to control Medusa during fight
Boss_MedusaPlayerInputControl:                              ; DATA XREF: ROM:000569F2   o  ; was: sub_56ABA
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
                btst    #2,(word_FFF706).w
                beq.s   loc_56ACE
                subq.w  #4,$10(a5)
loc_56ACE:                              ; CODE XREF: Boss_MedusaPlayerInputControl+E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_56ADA
                addq.w  #4,$10(a5)
loc_56ADA:                              ; CODE XREF: Boss_MedusaPlayerInputControl+1A   j
                lea     word_570F8(pc),a1
                nop
                bra.w Boss_MedusaShootPattern1
; End of function Boss_MedusaPlayerInputControl
; Movement pattern 1
Boss_MedusaMovePattern1:                              ; CODE XREF: Boss_MedusaAttackState2+80   j  ; was: sub_56AE4
                move.w  #4,4(a5)
                bclr    #3,2(a5)
                bclr    #2,2(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$100,$50(a5)
                move.w  #$100,$47C(a5)
                lea     word_57172(pc),a0
                nop
                bsr.w Boss_MedusaSpawnProjectile4
; End of function Boss_MedusaMovePattern1
; Movement pattern 2
Boss_MedusaMovePattern2:                              ; DATA XREF: ROM:000569F4   o  ; was: sub_56B16
                tst.w   $58(a5)
                bmi.s   loc_56B32
                lea     word_570FE(pc),a1
                nop
                bsr.w Boss_MedusaShootPattern1
                move.b  (dword_FF9410).w,d0
                ext.w   d0
                move.w  d0,$50(a5)
                rts
; ---------------------------------------------------------------------------
loc_56B32:                              ; CODE XREF: Boss_MedusaMovePattern2+4   j
                addq.w  #2,4(a5)
                clr.w   $50(a5)
                bset    #3,2(a5)
                bset    #2,2(a5)
                bset    #0,2(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F0,d0
                jsr (Sound_PlaySFX).l
                movea.l #word_1BF1A,a1
                jsr (Sprite_InitFromPointerTable).l
; End of function Boss_MedusaMovePattern2
; Animation script interpreter
Boss_MedusaAnimationScript:                              ; DATA XREF: ROM:000569F6   o  ; was: sub_56B6C
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56B80
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_56B8A
loc_56B80:                              ; CODE XREF: Boss_MedusaAnimationScript+8   j
                lea     word_57114(pc),a1
                nop
                bra.w Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56B8A:                              ; CODE XREF: Boss_MedusaAnimationScript+12   j
                addq.w  #2,4(a5)
                move.l  $18(a5),d0
                asr.l   #3,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.w  #1,$4DC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 4 attack pattern
Boss_Valkirie_Behavior_State4:                              ; DATA XREF: ROM:000569F8   o  ; was: loc_56BB0
                tst.w   $4DC(a5)
                beq.s   loc_56BD6
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56BE6
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56BE6
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   $4DC(a5)
loc_56BD6:                              ; CODE XREF: Boss_MedusaAnimationScript+48   j
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
                cmpi.w  #$1C0,$10(a5)
                bpl.s   loc_56BF0
loc_56BE6:                              ; CODE XREF: Boss_MedusaAnimationScript+52   j
                                        ; Boss_MedusaAnimationScript+5C   j
                lea     word_57120(pc),a1
                nop
                bra.w Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56BF0:                              ; CODE XREF: Boss_MedusaAnimationScript+78   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5) ; '@'
; Valkirie AI state 5 movement pattern
Boss_Valkirie_Behavior_State5:                              ; DATA XREF: ROM:000569FA   o  ; was: loc_56C04
                subq.w  #1,$11C(a5)
                bpl.s   loc_56C36
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                move.w  #1,(word_FF9804).w
                move.l  #word_573E6,$59C(a5)
                move.w  #$10,(word_FF9800).w
                move.w  #$18C,$11E(a5)
                clr.w   $4DC(a5)
                bra.w   loc_56C56
; ---------------------------------------------------------------------------
loc_56C36:                              ; CODE XREF: Boss_MedusaAnimationScript+9C   j
                move.w  #$180,d0
                bsr.w Boss_MedusaAnimationUpdate
                lea     word_57108(pc),a1
                nop
                bra.w Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56C48:                              ; CODE XREF: Boss_MedusaAnimationScript+206   j
                                        ; Boss_MedusaAnimationScript+288   j ...
                clr.w   $47E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_56C56:                              ; CODE XREF: Boss_MedusaAnimationScript+C6   j
                                        ; Boss_MedusaAnimationScript+1D8   j
                move.w  #$C,4(a5)
; Valkirie AI state 6 combo attack
Boss_Valkirie_Behavior_State6:                              ; DATA XREF: ROM:000569FC   o  ; was: loc_56C5C
                move.l  #word_57108,$53C(a5)
                tst.b   (byte_FFDB76).w
                beq.w   loc_56CE4
                tst.w   $4DC(a5)
                beq.s   loc_56C94
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56C9C
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56C9C
                move.w  #1,(word_FFA010).w
                clr.w   $4DC(a5)
                clr.l   $1C(a5)
loc_56C94:                              ; CODE XREF: Boss_MedusaAnimationScript+104   j
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
loc_56C9C:                              ; CODE XREF: Boss_MedusaAnimationScript+10E   j
                                        ; Boss_MedusaAnimationScript+118   j
                cmpi.w  #4,$47E(a5)
                bne.s   loc_56CB0
                clr.w   $47E(a5)
                move.w  $5E(a5),$11E(a5)
                bra.s   loc_56CCE
; ---------------------------------------------------------------------------
loc_56CB0:                              ; CODE XREF: Boss_MedusaAnimationScript+136   j
                cmpi.w  #2,$47E(a5)
                beq.w   loc_56DC0
                cmpi.w  #6,$47E(a5)
                beq.w   loc_56D50
                cmpi.w  #8,$47E(a5)
                beq.w   loc_56E22
loc_56CCE:                              ; CODE XREF: Boss_MedusaAnimationScript+142   j
                bsr.w Boss_MedusaAnimationLoop
                move.b  #$D8,d0
                bsr.w Boss_MedusaPlaySFXEvery8Frames
                lea     word_57108(pc),a1
                nop
                bra.w Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56CE4:                              ; CODE XREF: Boss_MedusaAnimationScript+FC   j
                                        ; Boss_MedusaAnimationScript+270   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 7 special behavior
Boss_Valkirie_Behavior_State7:                              ; DATA XREF: ROM:000569FE   o  ; was: loc_56CF4
                cmpi.l  #$68000,$1C(a5)
                bpl.s   loc_56D08
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_56D48
loc_56D08:                              ; CODE XREF: Boss_MedusaAnimationScript+190   j
                tst.b   (byte_FFDB76).w
                beq.s   loc_56D48
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_56D48
                addq.w  #2,4(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  #1,$4DC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$48,d0 ; 'H'
                jsr (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                bra.w   loc_56C56
; ---------------------------------------------------------------------------
loc_56D48:                              ; CODE XREF: Boss_MedusaAnimationScript+19A   j
                                        ; Boss_MedusaAnimationScript+1A0   j ...
                movea.l $53C(a5),a1
                bra.w Boss_MedusaShootPattern1
; ---------------------------------------------------------------------------
loc_56D50:                              ; CODE XREF: Boss_MedusaAnimationScript+154   j
                move.w  #$12,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 9 advanced pattern
Boss_Valkirie_Behavior_State9:                              ; DATA XREF: ROM:00056A02   o  ; was: loc_56D60
                cmpi.w  #4,$47E(a5)
                bne.s   loc_56D76
                clr.w   $47E(a5)
                move.w  $5E(a5),$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56D76:                              ; CODE XREF: Boss_MedusaAnimationScript+1FA   j
                cmpi.w  #2,$47E(a5)
                beq.w   loc_56DC0
                cmpi.w  #8,$47E(a5)
                beq.w   loc_56E22
                tst.l   $18(a5)
                beq.s   loc_56DB6
                bmi.s   loc_56D9E
                subi.l  #$2000,$18(a5)
                bmi.s   loc_56DA8
                bra.s   loc_56DAC
; ---------------------------------------------------------------------------
loc_56D9E:                              ; CODE XREF: Boss_MedusaAnimationScript+224   j
                addi.l  #$2000,$18(a5)
                bmi.s   loc_56DAC
loc_56DA8:                              ; CODE XREF: Boss_MedusaAnimationScript+22E   j
                clr.l   $18(a5)
loc_56DAC:                              ; CODE XREF: Boss_MedusaAnimationScript+230   j
                                        ; Boss_MedusaAnimationScript+23A   j
                lea     word_57114(pc),a1
                nop
                bra.w Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56DB6:                              ; CODE XREF: Boss_MedusaAnimationScript+222   j
                lea     word_57120(pc),a1
                nop
                bra.w Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56DC0:                              ; CODE XREF: Boss_MedusaAnimationScript+14A   j
                                        ; Boss_MedusaAnimationScript+210   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 8 transition phase
Boss_Valkirie_Behavior_State8:                              ; DATA XREF: ROM:00056A00   o  ; was: loc_56DD0
                move.l  #word_5711A,$53C(a5)
                tst.b   (byte_FFDB76).w
                beq.w   loc_56CE4
                move.w  #1,(word_FFA010).w
                cmpi.w  #$D0,$10(a5)
                bpl.s   loc_56DF8
                move.w  #$B0,$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56DF8:                              ; CODE XREF: Boss_MedusaAnimationScript+280   j
                tst.l   $18(a5)
                bpl.s   loc_56E08
                cmpi.l  #$FFFB0000,$18(a5)
                bmi.s   loc_56E10
loc_56E08:                              ; CODE XREF: Boss_MedusaAnimationScript+290   j
                subi.l  #$800,$18(a5)
loc_56E10:                              ; CODE XREF: Boss_MedusaAnimationScript+29A   j
                move.b  #$F2,d0
                bsr.w Boss_MedusaPlaySFXEvery4Frames
                lea     word_5711A(pc),a1
                nop
                bra.w Boss_MedusaCollisionCheck
; ---------------------------------------------------------------------------
loc_56E22:                              ; CODE XREF: Boss_MedusaAnimationScript+15E   j
                                        ; Boss_MedusaAnimationScript+21A   j
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Valkirie AI state 10 final pattern
Boss_Valkirie_Behavior_State10:                              ; DATA XREF: ROM:00056A04   o  ; was: loc_56E32
                cmpi.w  #$180,$10(a5)
                bmi.s   loc_56E44
                move.w  #$18C,$11E(a5)
                bra.w   loc_56C48
; ---------------------------------------------------------------------------
loc_56E44:                              ; CODE XREF: Boss_MedusaAnimationScript+2CC   j
                tst.l   $18(a5)
                bpl.s   loc_56E54
                cmpi.l  #$24000,$18(a5)
                bpl.s   loc_56E5C
loc_56E54:                              ; CODE XREF: Boss_MedusaAnimationScript+2DC   j
                addi.l  #$800,$18(a5)
loc_56E5C:                              ; CODE XREF: Boss_MedusaAnimationScript+2E6   j
                move.b  #$F3,d0
                bsr.w Boss_MedusaPlaySFXEvery4Frames
                lea     word_5710E(pc),a1
                nop
                bra.w Boss_MedusaCollisionCheck
; End of function Boss_MedusaAnimationScript
; Animation loop handler
Boss_MedusaAnimationLoop:                              ; CODE XREF: Boss_MedusaAnimationScript:loc_56CCE   p  ; was: sub_56E6E
                move.w  $11E(a5),d0
; End of function Boss_MedusaAnimationLoop
; Animation frame update
Boss_MedusaAnimationUpdate:                              ; CODE XREF: Boss_MedusaAnimationScript+CE   p  ; was: sub_56E72
                cmp.w   $10(a5),d0
                bpl.s   loc_56E92
                tst.l   $18(a5)
                bpl.s   loc_56E88
                cmpi.l  #$FFFDC000,$18(a5)
                bmi.s   locret_56E90
loc_56E88:                              ; CODE XREF: Boss_MedusaAnimationUpdate+A   j
                subi.l  #$2000,$18(a5)
locret_56E90:                           ; CODE XREF: Boss_MedusaAnimationUpdate+14   j
                                        ; Boss_MedusaAnimationUpdate+2E   j
                rts
; ---------------------------------------------------------------------------
loc_56E92:                              ; CODE XREF: Boss_MedusaAnimationUpdate+4   j
                tst.l   $18(a5)
                bmi.s   loc_56EA2
                cmpi.l  #$12000,$18(a5)
                bpl.s   locret_56E90
loc_56EA2:                              ; CODE XREF: Boss_MedusaAnimationUpdate+24   j
                addi.l  #$2000,$18(a5)
                rts
; End of function Boss_MedusaAnimationUpdate
; Collision detection with player
Boss_MedusaCollisionCheck:                              ; CODE XREF: Boss_MedusaAnimationScript+D8   j  ; was: sub_56EAC
                                        ; Boss_MedusaAnimationScript+246   j ...
                move.w  (dword_FFDB34).w,d0
                move.w  d0,$14(a5)
; End of function Boss_MedusaCollisionCheck
; Shooting pattern 1
Boss_MedusaShootPattern1:                              ; CODE XREF: Boss_MedusaPlayerInputControl+26   j  ; was: sub_56EB4
                                        ; Boss_MedusaMovePattern2+C   p ...
                bsr.w Boss_MedusaSpawnProjectile1
                bsr.w Boss_MedusaShootPattern2
                moveq   #$13,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_MedusaShootPattern1
; Shooting pattern 2
Boss_MedusaShootPattern2:                              ; CODE XREF: Boss_MedusaShootPattern1+4   p  ; was: sub_56EC4
                move.w  #$80,d6
                move.w  #0,$B6(a5)
                move.w  #$80,$296(a5)
                move.w  #$100,$476(a5)
                move.w  #$180,$656(a5)
                move.b  (a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$116(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$176(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                add.w   d2,d0
                move.w  d0,d2
                and.w   d7,d0
                move.w  d0,$236(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.b  $10(a0),d1
                ext.w   d1
                move.w  d1,d2
                asr.w   #1,d2
                move.w  $B2(a5),d0
                add.w   d2,d0
                move.w  d0,$B4(a5)
                move.w  $292(a5),d0
                add.w   d2,d0
                move.w  d0,$294(a5)
                move.w  $472(a5),d0
                add.w   d2,d0
                move.w  d0,$474(a5)
                move.w  $652(a5),d0
                add.w   d2,d0
                move.w  d0,$654(a5)
                movea.w #(word_FFC680-M68K_RAM),a1
                bsr.w Boss_MedusaShootPattern3
                movea.w #(word_FFC860-M68K_RAM),a1
                bsr.w Boss_MedusaShootPattern3
                movea.w #(word_FFCA40-M68K_RAM),a1
                bsr.w Boss_MedusaShootPattern3
                movea.w #(byte_FFCC20-M68K_RAM),a1
                bsr.w Boss_MedusaShootPattern3
                move.b  $14(a0),d1
                ext.w   d1
                ext.l   d1
                swap    d1
                asr.l   #2,d1
                add.l   d1,$3BC(a5)
                move.w  $3BC(a5),$56(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   $47C(a5),d1
                and.w   d7,d1
                move.w  d1,$54(a5)
                rts
; End of function Boss_MedusaShootPattern2
; Shooting pattern 3
Boss_MedusaShootPattern3:                              ; CODE XREF: Boss_MedusaShootPattern2+EE   p  ; was: sub_56FF6
                                        ; Boss_MedusaShootPattern2+F6   p ...
                move.w  $B2(a1),d0
                add.w   d1,d0
                move.w  d0,$B4(a1)
                move.w  $112(a1),d0
                add.w   d1,d0
                move.w  d0,$114(a1)
                move.w  $172(a1),d0
                add.w   d1,d0
                move.w  d0,$174(a1)
                move.w  $1D2(a1),d0
                add.w   d1,d0
                move.w  d0,$1D4(a1)
                rts
; End of function Boss_MedusaShootPattern3
; Plays sound effect every 4th frame during animation
Boss_MedusaPlaySFXEvery4Frames:                              ; CODE XREF: Boss_MedusaAnimationScript+2A8   p  ; was: sub_57020
                                        ; Boss_MedusaAnimationScript+2F4   p
                move.w  (word_FFA000).w,d1
                andi.w  #3,d1
                bne.s   locret_57030
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_57030:                           ; CODE XREF: Boss_MedusaPlaySFXEvery4Frames+8   j
                rts
; End of function Boss_MedusaPlaySFXEvery4Frames
; Plays sound effect every 8th frame during animation
Boss_MedusaPlaySFXEvery8Frames:                              ; CODE XREF: Boss_MedusaAnimationScript+16A   p  ; was: sub_57032
                move.w  (word_FFA000).w,d1
                andi.w  #7,d1
                bne.s   locret_57042
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_57042:                           ; CODE XREF: Boss_MedusaPlaySFXEvery8Frames+8   j
                rts
; End of function Boss_MedusaPlaySFXEvery8Frames
; Spawns projectile type 1
Boss_MedusaSpawnProjectile1:                              ; CODE XREF: Boss_MedusaShootPattern1   p  ; was: sub_57044
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_570BE
loc_5704E:                              ; CODE XREF: Boss_MedusaSpawnProjectile1+24   j
                                        ; Boss_MedusaSpawnProjectile2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_570CE
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_5706A
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_5704E
; ---------------------------------------------------------------------------
loc_5706A:                              ; CODE XREF: Boss_MedusaSpawnProjectile1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_MedusaSpawnProjectile2
                move.w  d3,$58(a5)
                bra.w   loc_570CE
; End of function Boss_MedusaSpawnProjectile1
nullsub_129:
                rts
; End of function nullsub_129


; Spawns projectile type 2
Boss_MedusaSpawnProjectile2:                              ; CODE XREF: Boss_MedusaSpawnProjectile1+2E   j  ; was: sub_5707E
                cmpi.w  #$FFFF,d3
                bne.s   loc_5708E
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_5704E
; ---------------------------------------------------------------------------
loc_5708E:                              ; CODE XREF: Boss_MedusaSpawnProjectile2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_MedusaSpawnProjectile3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_570CE
loc_570BE:                              ; CODE XREF: Boss_MedusaSpawnProjectile1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #7,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_570CE:                              ; CODE XREF: Boss_MedusaSpawnProjectile1+E   j
                                        ; Boss_MedusaSpawnProjectile1+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_MedusaSpawnProjectile2
; Spawns projectile type 3
Boss_MedusaSpawnProjectile3:                              ; CODE XREF: Boss_MedusaSpawnProjectile2+24   p  ; was: sub_570D8
                movea.l $2FC(a5),a1
                moveq   #7,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_MedusaSpawnProjectile3
; Spawns projectile type 4
