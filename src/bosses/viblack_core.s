Boss_SunsetStingMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_42A10
                lea     (word_FF9800).w,a4
                lea     (word_FFC680).w,a3
                bsr.s   Boss_SunsetStingDispatcher
                bsr.w   Boss_SunsetStingUpdateWaveScreen
                move.w  4(a5),d0
                andi.w  #$FF,d0
                cmpi.w  #$12,d0
                bcc.s   locret_42A8A
                jsr     (Gfx_InitPaletteFade).l
                tst.w   (word_FF8234).w
                bne.s   loc_42A54
                move.w  4(a5),d0
                andi.w  #$7FFF,d0
                cmpi.w  #$E,d0
                bcc.s   loc_42A54
                addi.b  #$20,$54(a5)                    ; ' '
                bne.s   loc_42A54
                move.w  #$E,4(a5)
loc_42A54:                                              ; CODE XREF: Boss_SunsetStingMain+26   j
                                        ; Boss_SunsetStingMain+34   j
                tst.w   (word_FF8200).w
                bne.s   loc_42A6A
                bset    #0,(byte_FFA272).w
                bset    #7,(a4)
                move.w  #$12,4(a5)
loc_42A6A:                                              ; CODE XREF: Boss_SunsetStingMain+48   j
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   locret_42A8A
                move.b  $48(a5),d0
                andi.w  #$F,d0
                movea.l off_42AB6(pc,d0.w),a0
                jsr     (Gfx_LoadCompressedTiles).l
                addq.b  #4,$48(a5)
locret_42A8A:                                           ; CODE XREF: Boss_SunsetStingMain+1A   j
                                        ; Boss_SunsetStingMain+62   j
                rts
; End of function Boss_SunsetStingMain
; State dispatcher for boss
Boss_SunsetStingDispatcher:                             ; CODE XREF: Boss_SunsetStingMain+8   p  ; was: sub_42A8C
                                        ; Boss_SunsetStingBattleActive+8C   j
                move.w  4(a5),d0
                andi.w  #$FF,d0
                lea     off_42A9C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingDispatcher
; ---------------------------------------------------------------------------
off_42A9C:      dc.w    Boss_SunsetStingInit-*          ; DATA XREF: Boss_SunsetStingDispatcher+8   o
                dc.w    Boss_SunsetStingIntro-*
                dc.w    Boss_SunsetStingBattleActive-*
                dc.w    Boss_ViblackDefeatStart-*
                dc.w    Boss_ViblackBattleMovement-*
                dc.w    Boss_SunsetStingSegmentAttack-*
                dc.w    Boss_SunsetStingSegmentAttackAlt-*
                dc.w    Boss_SunsetStingReturnToCenter-*
                dc.w    Boss_SunsetStingIntroOscillate-*
                dc.w    Boss_SunsetStingDefeatPhase-*
                dc.w    Boss_SunsetStingDefeatWobble-*
                dc.w    Boss_SunsetStingFinalDefeat-*
                dc.w    Boss_SunsetStingDefeatFadeOut-*
off_42AB6:      dc.l    word_42AC6                      ; DATA XREF: Boss_SunsetStingMain+6C   r
                dc.l    word_42ACE
                dc.l    word_42AD6
                dc.l    word_42ACE
word_42AC6:     dc.w    $625C, $2000, 0, $6700
                                        ; DATA XREF: ROM:off_42AB6   o
word_42ACE:     dc.w    $625C, $2000, 0, $6800
                                        ; DATA XREF: ROM:00042ABA   o
                                        ; ROM:00042AC2   o
word_42AD6:     dc.w    $625C, $2000, 0, $6B00
                                        ; DATA XREF: ROM:00042ABE   o

; Initializes Sunset Sting boss with 16 segments
Boss_SunsetStingInit:                                   ; DATA XREF: ROM:off_42A9C   o  ; was: sub_42ADE
                tst.w   (word_FFF720).w
                bmi.w   locret_432CE
                move.w  #$1EC,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #1,(byte_FF830E).w
                move.w  #$1E0,$10(a5)
                move.w  #$D8,$14(a5)
                move.w  #$8D00,2(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$84,$23(a5)
                move.w  #$14,$24(a5)
                move.w  #$95,$26(a5)
                move.l  #$F010F010,$28(a5)
                move.l  #$F20EF20E,$2C(a5)
                move.b  #$40,(byte_FFA420).w            ; '@'
                lea     $60(a5),a0
                move.w  #$20C,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$95,$26(a0)
                move.w  #$6300,$E(a0)
                moveq   #0,d0
                lea     word_42BCC(pc),a1
                moveq   #0,d2
                lea     $60(a0),a0
                bra.s   loc_42B66
; ---------------------------------------------------------------------------
loc_42B60:                                              ; CODE XREF: Boss_SunsetStingInit+C0   j
                moveq   #$40,d0                         ; '@'
                lea     word_42BD8(pc),a1
loc_42B66:                                              ; CODE XREF: Boss_SunsetStingInit+80   j
                moveq   #7,d7
loc_42B68:                                              ; CODE XREF: Boss_SunsetStingInit+B6   j
                move.w  #$6300,$E(a0)
                move.w  (a1),(a0)
                move.w  2(a1),$26(a0)
                move.l  4(a1),$28(a0)
                move.l  8(a1),$2C(a0)
                move.w  d0,6(a0)
                move.w  d2,$46(a0)
                addi.w  #$80,d0
                addq.w  #1,d2
                lea     $60(a0),a0
                dbf     d7,loc_42B68
                cmpa.l  #word_42BD8,a1
                bne.s   loc_42B60
                move.w  #8,4(a4)
                move.w  #2,(word_FF8640).w
                lea     word_42BBA(pc),a0
                jsr     (Gfx_LoadCompressedTiles).l
                bra.w   Boss_SunsetStingNextState
; End of function Boss_SunsetStingInit
; ---------------------------------------------------------------------------
word_42BBA:     dc.w    $6058, $2000, $105, $6C6F, $7073, $6566, $696A, $6D6E, $7172
                                        ; DATA XREF: Boss_SunsetStingInit+CE   o
word_42BCC:     dc.w    $1F0, $52, $F40C, $F40C, $FC04, $FC04
                                        ; DATA XREF: Boss_SunsetStingInit+76   o
word_42BD8:     dc.w    $1F4, $25, 0, 0, $FE02, $F808
                                        ; DATA XREF: Boss_SunsetStingInit+84   o
                                        ; Boss_SunsetStingInit+BA   o

; Boss intro sequence
Boss_SunsetStingIntro:                                  ; DATA XREF: ROM:00042A9E   o  ; was: sub_42BE4
                bset    #7,4(a5)
                bne.s   loc_42C34
                move.w  #$780,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  d0,$10(a3)
                move.w  #$10,$14(a5)
                move.w  #$90,$14(a3)
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w            ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.l  #$FFFFF000,$58(a5)
                move.w  #1,$1C(a5)
loc_42C34:                                              ; CODE XREF: Boss_SunsetStingIntro+6   j
                btst    #6,4(a5)
                bne.s   Boss_SunsetStingIntroMovementAlt
                cmpi.w  #$140,$14(a3)
                beq.s   loc_42C62
                addq.w  #2,$14(a3)
                cmpi.w  #$140,$14(a3)
                bne.s   loc_42C62
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #2,$1C(a5)
loc_42C62:                                              ; CODE XREF: Boss_SunsetStingIntro+5E   j
                                        ; Boss_SunsetStingIntro+6A   j
                cmpi.w  #$C0,$14(a5)
                bcs.w   locret_432CE
                bset    #6,4(a5)
                moveq   #3,d0
; End of function Boss_SunsetStingIntro
; Checks victory condition
Boss_SunsetStingVictoryCheck:
                jsr     (UI_CheckVictoryCondition).l    ; was: sub_42C74
                move.b  #$8A,d0
                jsr     (Input_CheckButtonMode).l
                rts
; End of function Boss_SunsetStingVictoryCheck
; Handles vertical oscillation during boss intro phase 2
Boss_SunsetStingIntroMovementAlt:                       ; CODE XREF: Boss_SunsetStingIntro+56   j  ; was: sub_42C86
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                moveq   #1,d7
                swap    d7
                tst.w   $58(a5)
                bpl.s   loc_42C9A
                neg.l   d7
loc_42C9A:                                              ; CODE XREF: Boss_SunsetStingIntroMovementAlt+10   j
                cmp.l   $1C(a5),d7
                bne.s   loc_42CA4
                neg.l   $58(a5)
loc_42CA4:                                              ; CODE XREF: Boss_SunsetStingIntroMovementAlt+18   j
                tst.w   (word_FF80C2).w
                bne.w   locret_432CE
                clr.b   (byte_FF80EC).w
                move.w  #$620,(word_FFA970).w
                move.w  #$6A0,(word_FFA974).w
                bra.w   Boss_SunsetStingNextState
; End of function Boss_SunsetStingIntroMovementAlt
; Active battle state
Boss_SunsetStingBattleActive:                           ; DATA XREF: ROM:00042AA0   o  ; was: sub_42CC0
                bsr.w   Physics_ClearVelocity
                btst    #0,(a4)
                bne.s   loc_42CE8
                clr.l   $4A(a5)
                moveq   #1,d7
                move.w  $14(a3),d0
                subi.w  #$71,d0                         ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_42D2C
                bpl.s   loc_42CE2
                neg.w   d7
loc_42CE2:                                              ; CODE XREF: Boss_SunsetStingBattleActive+1E   j
                add.w   d7,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_42CE8:                                              ; CODE XREF: Boss_SunsetStingBattleActive+8   j
                bset    #7,4(a5)
                bne.s   loc_42D12
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_42CFC
                neg.w   d0
loc_42CFC:                                              ; CODE XREF: Boss_SunsetStingBattleActive+38   j
                cmpi.w  #$80,d0
                bcc.s   loc_42D2C
                move.l  $58(a5),d0
                asr.l   #5,d0
                move.w  d0,$4A(a5)
                move.w  #$20,$4C(a5)                    ; ' '
loc_42D12:                                              ; CODE XREF: Boss_SunsetStingBattleActive+2E   j
                move.w  $4A(a5),d0
                ext.l   d0
                sub.l   d0,$58(a5)
                subq.w  #1,$4C(a5)
                bne.w   locret_42A8A
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_42D2C:                                              ; CODE XREF: Boss_SunsetStingBattleActive+1C   j
                                        ; Boss_SunsetStingBattleActive+40   j
                tst.w   $4C(a5)
                beq.s   loc_42D5C
                move.w  $4C(a5),d0
                bpl.s   loc_42D3A
                neg.w   d0
loc_42D3A:                                              ; CODE XREF: Boss_SunsetStingBattleActive+76   j
                cmpi.w  #$20,d0                         ; ' '
                bne.s   loc_42D50
                move.w  #$A,4(a5)
                move.w  #$200,$56(a5)
                bra.w   Boss_SunsetStingDispatcher
; ---------------------------------------------------------------------------
loc_42D50:                                              ; CODE XREF: Boss_SunsetStingBattleActive+7E   j
                clr.l   $4A(a5)
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_42D5C:                                              ; CODE XREF: Boss_SunsetStingBattleActive+70   j
                move.w  #$FFFF,2(a4)
                subi.w  #$50,(word_FF8234).w            ; 'P'
                moveq   #$A,d7
                jsr     (RandomNumber).l
                andi.w  #7,d0
                bne.s   loc_42D78
                addq.w  #2,d7
loc_42D78:                                              ; CODE XREF: Boss_SunsetStingBattleActive+B4   j
                move.w  d7,4(a5)
                move.w  #$200,$56(a5)
                clr.l   $4A(a5)
                rts
; End of function Boss_SunsetStingBattleActive
; Initiates defeat sequence with screen shake
Boss_ViblackDefeatStart:                                ; DATA XREF: ROM:00042AA2   o  ; was: sub_42D88
                bset    #7,4(a5)
                bne.s   loc_42DB4
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w            ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  #$14,$4A(a5)
loc_42DB4:                                              ; CODE XREF: Boss_ViblackDefeatStart+6   j
                addq.w  #2,$14(a5)
                subq.w  #1,$4A(a5)
                bne.w   locret_432CE
                move.l  #$FFFBC000,$1C(a5)
                move.l  #$1000,$4A(a5)
                addi.w  #$30,(word_FF8234).w            ; '0'
                bra.w   Boss_SunsetStingNextState
; End of function Boss_ViblackDefeatStart
; Controls Viblack vertical movement relative to player
Boss_ViblackBattleMovement:                             ; DATA XREF: ROM:00042AA4   o  ; was: sub_42DDA
                btst    #6,4(a5)
                bne.w   loc_42E86
                tst.l   $4A(a3)
                beq.s   loc_42E36
                move.l  $4A(a3),d0
                add.l   d0,$1C(a3)
                bmi.s   loc_42DFA
                move.w  #$102,$26(a3)
loc_42DFA:                                              ; CODE XREF: Boss_ViblackBattleMovement+18   j
                move.w  $10(a3),$10(a5)
                cmpi.w  #$140,$14(a3)
                bcs.w   loc_42E86
                move.w  #$95,$26(a3)
                move.w  #$140,$14(a3)
                move.w  #8,(word_FFA014).w
                clr.l   $18(a3)
                clr.l   $1C(a3)
                clr.l   $4A(a3)
                subi.w  #$50,(word_FF8234).w            ; 'P'
                bset    #6,4(a5)
                bra.s   loc_42E86
; ---------------------------------------------------------------------------
loc_42E36:                                              ; CODE XREF: Boss_ViblackBattleMovement+E   j
                move.w  $14(a3),d0
                sub.w   $14(a5),d0
                cmpi.w  #$A0,d0
                bcs.s   loc_42E86
                move.l  #$FFFA0000,$1C(a3)
                move.l  #$2000,$4A(a3)
                move.w  $10(a5),d0
                move.w  d0,d1
                add.w   (dword_FFA900).w,d0
                move.l  #$FFFF0000,d7
                subi.w  #$780,d0
                bpl.s   loc_42E6E
                neg.w   d0
                neg.l   d7
loc_42E6E:                                              ; CODE XREF: Boss_ViblackBattleMovement+8E   j
                subi.w  #$80,d0
                bcc.s   loc_42E82
                move.l  #$10000,d7
                cmp.w   (dword_FFA410).w,d1
                bpl.s   loc_42E82
                neg.l   d7
loc_42E82:                                              ; CODE XREF: Boss_ViblackBattleMovement+98   j
                                        ; Boss_ViblackBattleMovement+A4   j
                move.l  d7,$18(a3)
loc_42E86:                                              ; CODE XREF: Boss_ViblackBattleMovement+6   j
                                        ; Boss_ViblackBattleMovement+2C   j
                btst    #7,4(a5)
                bne.s   loc_42EAC
                move.l  $4A(a5),d0
                add.l   d0,$1C(a5)
                cmpi.l  #$44000,$1C(a5)
                bne.w   locret_432CE
                clr.l   $1C(a5)
                bset    #7,4(a5)
loc_42EAC:                                              ; CODE XREF: Boss_ViblackBattleMovement+B2   j
                move.w  $14(a3),d0
                subi.w  #$71,d0                         ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_42EC0
                subq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_42EC0:                                              ; CODE XREF: Boss_ViblackBattleMovement+DE   j
                move.w  #4,4(a5)
                rts
; End of function Boss_ViblackBattleMovement
; Segment attack state
Boss_SunsetStingSegmentAttack:                          ; DATA XREF: ROM:00042AA6   o  ; was: sub_42EC8
                bset    #7,4(a5)
                bne.s   loc_42F0C
                move.b  #4,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                andi.b  #$EF,(word_FFF7D0+1).w
                move.b  #3,(word_FFF7E6+1).w
                bset    #0,(a4)
                jsr     (RandomNumber).l
                andi.w  #$3F,d0                         ; '?'
                move.b  d0,$49(a5)
                tst.w   $4A(a5)
                bne.s   loc_42F0C
                move.w  #$FD00,$4A(a5)
                move.w  #$20,$4C(a5)                    ; ' '
loc_42F0C:                                              ; CODE XREF: Boss_SunsetStingSegmentAttack+6   j
                                        ; Boss_SunsetStingSegmentAttack+36   j
                subq.w  #1,$56(a5)
                bne.s   loc_42F18
                move.w  #4,4(a5)
loc_42F18:                                              ; CODE XREF: Boss_SunsetStingSegmentAttack+48   j
                bsr.s   Boss_SunsetStingSegmentWait
                move.w  #$300,d7
                bsr.s   Boss_SunsetStingSegmentRotate
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   loc_42F36
                cmpi.w  #8,4(a4)
                beq.s   loc_42F36
                addq.w  #1,4(a4)
loc_42F36:                                              ; CODE XREF: Boss_SunsetStingSegmentAttack+60   j
                                        ; Boss_SunsetStingSegmentAttack+68   j
                clr.w   2(a4)
                subq.b  #1,$49(a5)
                bne.w   locret_432CE
                jsr     (RandomNumber).l
                andi.b  #$3F,d0                         ; '?'
                tst.w   (word_FFFF0E).w
                beq.s   loc_42F54
                lsr.b   #1,d0
loc_42F54:                                              ; CODE XREF: Boss_SunsetStingSegmentAttack+88   j
                move.b  d0,$49(a5)
                swap    d0
                andi.w  #$F,d0
                bset    #3,d0
                moveq   #0,d1
                bset    d0,d1
                move.w  d1,2(a4)
                rts
; End of function Boss_SunsetStingSegmentAttack
; Segment wait state
Boss_SunsetStingSegmentWait:                            ; CODE XREF: Boss_SunsetStingSegmentAttack:loc_42F18   p  ; was: sub_42F6C
                                        ; sub_42FA6:loc_42FF6   p
                moveq   #1,d7
                ror.w   #3,d7
                move.w  $10(a5),d0
                cmp.w   (dword_FFA410).w,d0
                bpl.s   loc_42F7C
                neg.l   d7
loc_42F7C:                                              ; CODE XREF: Boss_SunsetStingSegmentWait+C   j
                sub.l   d7,$10(a3)
                rts
; End of function Boss_SunsetStingSegmentWait
; Segment rotation during attack
Boss_SunsetStingSegmentRotate:                          ; CODE XREF: Boss_SunsetStingSegmentAttack+56   p  ; was: sub_42F82
                                        ; Boss_SunsetStingSegmentAttackAlt+58   p
                move.w  $4C(a5),d0
                add.w   d0,$4A(a5)
                move.w  $4A(a5),d0
                ext.l   d0
                add.l   d0,$58(a5)
                tst.w   $4C(a5)
                bpl.s   loc_42F9C
                neg.w   d0
loc_42F9C:                                              ; CODE XREF: Boss_SunsetStingSegmentRotate+16   j
                cmp.w   d7,d0
                bne.s   locret_42FA4
                neg.w   $4C(a5)
locret_42FA4:                                           ; CODE XREF: Boss_SunsetStingSegmentRotate+1C   j
                rts
; End of function Boss_SunsetStingSegmentRotate
; Manages segment rotation attack with random timing
Boss_SunsetStingSegmentAttackAlt:                       ; DATA XREF: ROM:00042AA8   o  ; was: sub_42FA6
                bset    #7,4(a5)
                bne.s   loc_42FEA
                move.b  #4,(byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                andi.b  #$EF,(word_FFF7D0+1).w
                move.b  #3,(word_FFF7E6+1).w
                bset    #0,(a4)
                jsr     (RandomNumber).l
                andi.w  #$3F,d0                         ; '?'
                move.b  d0,$49(a5)
                tst.w   $4A(a5)
                bne.s   loc_42FEA
                move.w  #$F000,$4A(a5)
                move.w  #$200,$4C(a5)
loc_42FEA:                                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+6   j
                                        ; Boss_SunsetStingSegmentAttackAlt+36   j
                subq.w  #1,$56(a5)
                bne.s   loc_42FF6
                move.w  #4,4(a5)
loc_42FF6:                                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+48   j
                bsr.w   Boss_SunsetStingSegmentWait
                move.w  #$1000,d7
                bsr.s   Boss_SunsetStingSegmentRotate
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_43016
                cmpi.w  #$FFF8,4(a4)
                beq.s   loc_43016
                subq.w  #1,4(a4)
loc_43016:                                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+62   j
                                        ; Boss_SunsetStingSegmentAttackAlt+6A   j
                clr.w   2(a4)
                subq.b  #1,$49(a5)
                bne.w   locret_432CE
                jsr     (RandomNumber).l
                andi.b  #$7F,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_43034
                lsr.b   #1,d0
loc_43034:                                              ; CODE XREF: Boss_SunsetStingSegmentAttackAlt+8A   j
                move.b  d0,$49(a5)
                swap    d0
                andi.w  #7,d0
                moveq   #0,d1
                bset    d0,d1
                move.w  d1,2(a4)
                rts
; End of function Boss_SunsetStingSegmentAttackAlt
; Returns boss to center position and decelerates rotation
Boss_SunsetStingReturnToCenter:                         ; DATA XREF: ROM:00042AAA   o  ; was: sub_43048
                bsr.w   Physics_ClearVelocity
                btst    #0,(a4)
                bne.s   loc_43072
                clr.l   $4A(a5)
                moveq   #1,d7
                move.w  $14(a3),d0
                subi.w  #$71,d0                         ; 'q'
                cmp.w   $14(a5),d0
                beq.w   loc_432CA
                bpl.s   loc_4306C
                neg.w   d7
loc_4306C:                                              ; CODE XREF: Boss_SunsetStingReturnToCenter+20   j
                add.w   d7,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_43072:                                              ; CODE XREF: Boss_SunsetStingReturnToCenter+8   j
                bset    #7,4(a5)
                bne.s   loc_4308A
                move.l  $58(a5),d0
                asr.l   #5,d0
                move.w  d0,$4A(a5)
                move.w  #$20,$4C(a5)                    ; ' '
loc_4308A:                                              ; CODE XREF: Boss_SunsetStingReturnToCenter+30   j
                move.w  $4A(a5),d0
                ext.l   d0
                sub.l   d0,$58(a5)
                subq.w  #1,$4C(a5)
                beq.w   Boss_SunsetStingNextState
                rts
; End of function Boss_SunsetStingReturnToCenter
; Oscillates boss vertically during intro
Boss_SunsetStingIntroOscillate:                         ; DATA XREF: ROM:00042AAC   o  ; was: sub_4309E
                bset    #7,4(a5)
                bne.s   loc_430D8
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w            ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  #$14,$4A(a5)
                move.l  #$FFFFF000,$58(a5)
                move.w  #1,$1C(a5)
loc_430D8:                                              ; CODE XREF: Boss_SunsetStingIntroOscillate+6   j
                move.l  $58(a5),d0
                add.l   d0,$1C(a5)
                moveq   #1,d7
                swap    d7
                tst.w   $58(a5)
                bpl.s   loc_430EC
                neg.l   d7
loc_430EC:                                              ; CODE XREF: Boss_SunsetStingIntroOscillate+4A   j
                cmp.l   $1C(a5),d7
                bne.s   loc_430F6
                neg.l   $58(a5)
loc_430F6:                                              ; CODE XREF: Boss_SunsetStingIntroOscillate+52   j
                addq.w  #2,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.w   locret_432CE
                move.w  #4,4(a5)
                rts
; End of function Boss_SunsetStingIntroOscillate
; Defeat phase with screen clear
Boss_SunsetStingDefeatPhase:                            ; DATA XREF: ROM:00042AAE   o  ; was: sub_4310C
                move.b  #1,(byte_FF830E).w
                clr.b   $21(a5)
                clr.b   $23(a5)
                jsr     (Gfx_UpdatePaletteFade).l
                bset    #7,4(a5)
                bne.s   loc_4315C
                clr.b   (byte_FFA95A).w
                move.b  #1,(byte_FFA95B).w
                move.b  #0,(word_FFF7E6+1).w
                move.w  #$34,(word_FFF74A).w            ; '4'
                clr.w   (word_FFF74E).w
                bclr    #0,(a4)
                move.w  $10(a3),$10(a5)
                bsr.w   Physics_ClearVelocity
                move.l  d0,$18(a3)
                move.l  d0,$1C(a3)
                move.l  d0,$4A(a3)
loc_4315C:                                              ; CODE XREF: Boss_SunsetStingDefeatPhase+1A   j
                moveq   #0,d1
                move.w  $14(a3),d0
                cmpi.w  #$140,d0
                bcc.s   loc_4316E
                addq.w  #2,$14(a3)
                addq.w  #1,d1
loc_4316E:                                              ; CODE XREF: Boss_SunsetStingDefeatPhase+5A   j
                moveq   #1,d7
                subi.w  #$71,d0                         ; 'q'
                cmp.w   $14(a5),d0
                beq.s   loc_43184
                bpl.s   loc_4317E
                neg.w   d7
loc_4317E:                                              ; CODE XREF: Boss_SunsetStingDefeatPhase+6E   j
                add.w   d7,$14(a5)
                addq.w  #1,d1
loc_43184:                                              ; CODE XREF: Boss_SunsetStingDefeatPhase+6C   j
                tst.w   d1
                bne.w   locret_432CE
                move.w  #$100,$4A(a5)
                clr.l   $4C(a5)
                move.w  #$FFF8,$1C(a5)
                addi.w  #$20,$14(a5)                    ; ' '
                bra.w   Boss_SunsetStingNextState
; End of function Boss_SunsetStingDefeatPhase
; Wobble effect during defeat
Boss_SunsetStingDefeatWobble:                           ; DATA XREF: ROM:00042AB0   o  ; was: sub_431A4
                addi.b  #$40,$4C(a5)                    ; '@'
                bne.s   loc_431B0
                neg.l   $1C(a5)
loc_431B0:                                              ; CODE XREF: Boss_SunsetStingDefeatWobble+6   j
                bsr.s   Boss_SunsetStingSpawnDebrisRain
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$4A(a5)
                beq.w   Boss_SunsetStingNextState
                rts
; End of function Boss_SunsetStingDefeatWobble
; Spawns debris rain projectiles
Boss_SunsetStingSpawnDebrisRain:                        ; CODE XREF: Boss_SunsetStingDefeatWobble:loc_431B0   p  ; was: sub_431C2
                                        ; sub_43226:loc_43232   p
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_432CE
                jsr     (Projectile_InitType88).l
                move.w  (dword_FFFF08).w,d0
                move.w  (dword_FFFF08+2).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$20,d1                         ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  #off_E95DC,8(a0)
                move.b  #$30,$20(a0)                    ; '0'
                bset    #7,$E(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_432CE
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_SunsetStingSpawnDebrisRain
; Final defeat sequence
Boss_SunsetStingFinalDefeat:                            ; DATA XREF: ROM:00042AB2   o  ; was: sub_43226
                addi.b  #$40,$4C(a5)                    ; '@'
                bne.s   loc_43232
                neg.l   $1C(a5)
loc_43232:                                              ; CODE XREF: Boss_SunsetStingFinalDefeat+6   j
                bsr.s   Boss_SunsetStingSpawnDebrisRain
                bsr.s   Gfx_ApplyDefeatFade
                cmpi.w  #$1C,6(a5)
                bcs.s   loc_4328E
                beq.s   loc_43278
                addq.b  #8,$4A(a5)
                bne.w   locret_432CE
                move.w  #$1EC,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                jsr     (Effect_InitPlayerSpawn).l
                clr.w   (word_FF8640).w
                clr.l   $1C(a5)
                addi.w  #$38,$14(a0)                    ; '8'
                andi.w  #$FFFE,6(a5)
                move.w  #$FF00,$4A(a5)
                bra.w   Boss_SunsetStingNextState
; ---------------------------------------------------------------------------
loc_43278:                                              ; CODE XREF: Boss_SunsetStingFinalDefeat+18   j
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #4,(byte_FFA95A).w
                clr.w   2(a5)
                move.b  #$FF,(a4)
loc_4328E:                                              ; CODE XREF: Boss_SunsetStingFinalDefeat+16   j
                addq.w  #1,6(a5)
                rts
; End of function Boss_SunsetStingFinalDefeat
; Fade out after defeat
Boss_SunsetStingDefeatFadeOut:                          ; DATA XREF: ROM:00042AB4   o  ; was: sub_43294
                tst.w   6(a5)
                beq.s   loc_4329E
                subq.w  #2,6(a5)
loc_4329E:                                              ; CODE XREF: Boss_SunsetStingDefeatFadeOut+4   j
                bsr.s   Gfx_ApplyDefeatFade
                addq.w  #2,$4A(a5)
                bne.w   locret_432CE
                bset    #4,2(a5)
                rts
; End of function Boss_SunsetStingDefeatFadeOut
; Applies defeat palette fade
Gfx_ApplyDefeatFade:                                    ; CODE XREF: Boss_SunsetStingFinalDefeat+E   p  ; was: sub_432B0
                                        ; sub_43294:loc_4329E   p
                move.w  6(a5),d0
                asr.w   #1,d0
                lea     (word_FFE300).w,a0
                moveq   #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyDefeatFade
; Advances to next state
Boss_SunsetStingNextState:                              ; CODE XREF: Boss_SunsetStingInit+D8   j  ; was: sub_432C6
                                        ; Boss_SunsetStingIntroMovementAlt+36   j
                clr.b   4(a5)
loc_432CA:                                              ; CODE XREF: Boss_SunsetStingReturnToCenter+1C   j
                                        ; Boss_SunsetStingDefeatEnd+1C   j
                addq.w  #2,4(a5)
locret_432CE:                                           ; CODE XREF: Boss_SunsetStingInit+4   j
                                        ; Boss_SunsetStingIntro+84   j
                rts
; End of function Boss_SunsetStingNextState
; Updates segment sprite based on angle
Boss_SunsetStingUpdateSegmentSprite:                    ; CODE XREF: Boss_SunsetStingSegmentInit+42   p  ; was: sub_432D0
                                        ; Boss_SunsetStingSegmentMove+56   p
                addi.w  #$20,d0                         ; ' '
                lsr.w   #4,d0
                andi.w  #$3C,d0                         ; '<'
                bset    #3,$E(a5)
                bclr    #4,$E(a5)
                bclr    #5,d0
                beq.s   loc_432F2
                eori.b  #$18,$E(a5)
loc_432F2:                                              ; CODE XREF: Boss_SunsetStingUpdateSegmentSprite+1A   j
                move.l  (a0,d0.w),8(a5)
                rts
; End of function Boss_SunsetStingUpdateSegmentSprite
; ---------------------------------------------------------------------------
off_432FA:      dc.l    word_EBED0                      ; DATA XREF: Boss_SunsetStingSegmentInit+3E   o
                                        ; Boss_SunsetStingSegmentMove+52   o
                dc.l    word_EBEE2
                dc.l    word_EBEEE
                dc.l    word_EBEF4
                dc.l    word_EBEA6
                dc.l    word_EBEB2
                dc.l    word_EBEBE
                dc.l    word_EBEC4
off_4331A:      dc.l    word_EBF00                      ; DATA XREF: Boss_SunsetStingSegmentFall+3E   o
                                        ; Boss_SunsetStingDefeatStart+14   o
                dc.l    word_EBF06
                dc.l    word_EBF0C
                dc.l    word_EBF18
                dc.l    word_EBF1E
                dc.l    word_EBF24
                dc.l    word_EBF2A
                dc.l    word_EBF36

; Main segment handler
