Boss_SylpheedJumpRising:                                ; DATA XREF: ROM:0005944C   o  ; was: sub_59866
                tst.w   $58(a5)
                bmi.w   loc_59888
                subi.l  #$1C00,$18(a5)
                subi.l  #$E00,$1C(a5)
                lea     word_59C6C(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59888:                                              ; CODE XREF: Boss_SylpheedJumpRising+4   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedJumpRising
; Handles Sylpheed falling after jump, accelerates downward until landing
Boss_SylpheedJumpFalling:                               ; DATA XREF: ROM:0005944E   o  ; was: sub_598A4
                tst.w   $58(a5)
                bmi.w   Boss_SylpheedIdleWait
                addi.l  #$1E00,$18(a5)
                addi.l  #$1600,$1C(a5)
                lea     word_59C76(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedJumpFalling
; Sets up dive attack parameters with velocity and plays dive sound effect
Boss_SylpheedDiveSetup:                                 ; CODE XREF: Boss_SylpheedIdleWait+78   j  ; was: sub_598C6
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$18000,$18(a5)
                move.l  #$FFFF4000,$1C(a5)
                move.b  #$DC,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedDiveSetup
; Handles dive recovery phase with upward velocity adjustment
Boss_SylpheedDiveRecovery:                              ; DATA XREF: ROM:00059450   o  ; was: sub_598F0
                tst.w   $58(a5)
                bmi.w   loc_59912
                subi.l  #$1C00,$18(a5)
                addi.l  #$1200,$1C(a5)
                lea     word_59C84(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59912:                                              ; CODE XREF: Boss_SylpheedDiveRecovery+4   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_SylpheedDiveRecovery
; Handles climbing pattern with velocity changes and attack state transitions
Boss_SylpheedClimbPattern:                              ; DATA XREF: ROM:00059452   o  ; was: sub_5992E
                tst.w   $58(a5)
                bmi.w   Boss_SylpheedIdleWait
                addi.l  #$1E00,$18(a5)
                subi.l  #$1600,$1C(a5)
                lea     word_59C8E(pc),a1
                nop
                bra.w   Boss_SylpheedAttackState2
; End of function Boss_SylpheedClimbPattern
; Defeat sequence initialization
Boss_SylpheedDefeatInit:                                ; CODE XREF: Boss_SylpheedIdleWait:loc_597B4   p  ; was: sub_59950
                                        ; sub_59818:loc_5982E   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   Boss_SylpheedAnimationUpdate
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  d0,$41E(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  d0,$41C(a5)
; End of function Boss_SylpheedDefeatInit
; Animation frame update
Boss_SylpheedAnimationUpdate:                           ; CODE XREF: Boss_SylpheedAnimationScript:loc_5972A   p  ; was: sub_5997A
                                        ; Boss_SylpheedDefeatInit+8   j
                move.w  $3BE(a5),d1
                add.w   $41E(a5),d1
                move.w  $14(a5),d0
                cmp.w   d1,d0
                bmi.s   loc_599A4
                tst.w   $1C(a5)
                bpl.s   loc_5999A
                cmpi.l  #$FFFF0000,$1C(a5)
                bmi.s   Boss_SylpheedAttackState1
loc_5999A:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+14   j
                subi.l  #$1000,$1C(a5)
                bra.s   Boss_SylpheedAttackState1
; ---------------------------------------------------------------------------
loc_599A4:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+E   j
                tst.w   $1C(a5)
                bmi.s   loc_599B4
                cmpi.l  #$10000,$1C(a5)
                bpl.s   Boss_SylpheedAttackState1
loc_599B4:                                              ; CODE XREF: Boss_SylpheedAnimationUpdate+2E   j
                addi.l  #$1000,$1C(a5)
; End of function Boss_SylpheedAnimationUpdate
; Attack state 1 handler
Boss_SylpheedAttackState1:                              ; CODE XREF: Boss_SylpheedIdleState+4C   p  ; was: sub_599BC
                                        ; Boss_SylpheedAnimationUpdate+1E   j
                move.w  $3BC(a5),d1
                add.w   $41C(a5),d1
                move.w  $10(a5),d0
                cmp.w   d1,d0
                bmi.s   loc_599E6
                tst.w   $18(a5)
                bpl.s   loc_599DC
                cmpi.l  #$FFFF0000,$18(a5)
                bmi.s   locret_599E4
loc_599DC:                                              ; CODE XREF: Boss_SylpheedAttackState1+14   j
                subi.l  #$800,$18(a5)
locret_599E4:                                           ; CODE XREF: Boss_SylpheedAttackState1+1E   j
                                        ; Boss_SylpheedAttackState1+38   j
                rts
; ---------------------------------------------------------------------------
loc_599E6:                                              ; CODE XREF: Boss_SylpheedAttackState1+E   j
                tst.w   $18(a5)
                bmi.s   loc_599F6
                cmpi.l  #$10000,$18(a5)
                bpl.s   locret_599E4
loc_599F6:                                              ; CODE XREF: Boss_SylpheedAttackState1+2E   j
                addi.l  #$800,$18(a5)
                rts
; End of function Boss_SylpheedAttackState1
; Attack state 2 handler
Boss_SylpheedAttackState2:                              ; CODE XREF: Boss_SylpheedState2+6   j  ; was: sub_59A00
                                        ; Boss_SylpheedIdleState+56   j
                bsr.w   Boss_SylpheedMovePattern1
                bsr.w   Boss_SylpheedAttackState3
                moveq   #$19,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_SylpheedAttackState2
; Attack state 3 handler
Boss_SylpheedAttackState3:                              ; CODE XREF: Boss_SylpheedAttackState2+4   p  ; was: sub_59A10
                move.w  #$100,$416(a5)
                moveq   #0,d0
                move.b  (a0),d0
                asl.w   #1,d0
                moveq   #0,d1
                move.w  $20(a0),d1
                asl.l   #8,d1
                asl.l   #1,d1
                and.w   d7,d0
                move.w  d0,$B6(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                moveq   #0,d0
                move.b  4(a0),d0
                asl.w   #1,d0
                moveq   #0,d1
                move.w  $24(a0),d1
                asl.l   #8,d1
                asl.l   #1,d1
                and.w   d7,d0
                move.w  d0,$236(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                swap    d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$476(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                moveq   #0,d0
                move.b  $10(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                moveq   #0,d2
                move.w  $28(a0),d2
                asl.l   #8,d2
                asl.l   #1,d2
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$656(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$7D6(a5)
                move.w  d1,$836(a5)
                moveq   #0,d0
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                moveq   #0,d2
                move.w  $2C(a0),d2
                asl.l   #8,d2
                asl.l   #1,d2
                and.w   d7,d0
                move.w  d0,$A16(a5)
                addi.w  #$100,d0
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$896(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$8F6(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                swap    d0
                add.l   d2,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Boss_SylpheedAttackState3
; Movement pattern 1
Boss_SylpheedMovePattern1:                              ; CODE XREF: Boss_SylpheedAttackState2   p  ; was: sub_59B72
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_59BEC
loc_59B7C:                                              ; CODE XREF: Boss_SylpheedMovePattern1+24   j
                                        ; Boss_SylpheedMovePattern2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_59BFC
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_59B98
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_59B7C
; ---------------------------------------------------------------------------
loc_59B98:                                              ; CODE XREF: Boss_SylpheedMovePattern1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_SylpheedMovePattern2
                move.w  d3,$58(a5)
                bra.w   loc_59BFC
; End of function Boss_SylpheedMovePattern1
nullsub_135:
                rts
; End of function nullsub_135

; Movement pattern 2
Boss_SylpheedMovePattern2:                              ; CODE XREF: Boss_SylpheedMovePattern1+2E   j  ; was: sub_59BAC
                cmpi.w  #$FFFF,d3
                bne.s   loc_59BBC
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_59B7C
; ---------------------------------------------------------------------------
loc_59BBC:                                              ; CODE XREF: Boss_SylpheedMovePattern2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_SylpheedMovePattern3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_59BFC
loc_59BEC:                                              ; CODE XREF: Boss_SylpheedMovePattern1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_59BFC:                                              ; CODE XREF: Boss_SylpheedMovePattern1+E   j
                                        ; Boss_SylpheedMovePattern1+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_SylpheedMovePattern2
; Movement pattern 3
Boss_SylpheedMovePattern3:                              ; CODE XREF: Boss_SylpheedMovePattern2+24   p  ; was: sub_59C06
                movea.l $2FC(a5),a1
                moveq   #$B,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_SylpheedMovePattern3
; Loads animation frame delays from RAM buffer for boss animation sequence
Boss_SylpheedLoadAnimDelays:
                moveq   #$B,d7                          ; was: sub_59C1A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_SylpheedLoadAnimDelays
; ---------------------------------------------------------------------------
word_59C26:     dc.w    $2020, $18, $2020, $24, $FFFF
                                        ; DATA XREF: Boss_SylpheedState2   o
word_59C30:     dc.w    $810, 0, $808, 0, $810, $C, $808, $C
                                        ; DATA XREF: Boss_SylpheedIdleState+50   o
                                        ; Boss_SylpheedIdleState+8E   o
                dc.w    $FFFF
word_59C42:     dc.w    $1060, $18, $3030, $18, $1060, $24, $3030, $24
                                        ; DATA XREF: Boss_SylpheedAnimationScript+4E   o
                                        ; Boss_SylpheedAnimationScript+98   o
                dc.w    $FFFF
word_59C54:     dc.w    $1060, $30, $3030, $30, $1060, $3C, $3030, $3C
                                        ; DATA XREF: Boss_SylpheedIdleWait+80   o
                dc.w    $FFFF
word_59C66:     dc.w    $808, $18, $FFFE                ; DATA XREF: Boss_SylpheedIdleWait+B2   o
word_59C6C:     dc.w    $810, $48, $2020, $48, $FFFE
                                        ; DATA XREF: Boss_SylpheedJumpRising+18   o
word_59C76:     dc.w    $640, $54, $C0E, $54, $E0E, $54, $FFFE
                                        ; DATA XREF: Boss_SylpheedJumpFalling+18   o
word_59C84:     dc.w    $810, $60, $2020, $60, $FFFE
                                        ; DATA XREF: Boss_SylpheedDiveRecovery+18   o
word_59C8E:     dc.w    $640, $6C, $C0E, $6C, $E0E, $6C, $FFFE
                                        ; DATA XREF: Boss_SylpheedClimbPattern+18   o
word_59C9C:     dc.w    $70F0, $50F8, $C0D0, $F840, $1010, $8F8, $9010, $3008
                                        ; DATA XREF: Boss_SylpheedBattleStart+30   o
                dc.w    $C0B0, $840, $F0F0, $8F8, $B020, $60F8, $A0A0, $860
                dc.w    $E014, $14EC, $A034, $5010, $A0B0, $F060, $E010, $EF2
                dc.w    $9000, $3810, $A0C8, $F060, $F012, $10F0, $8010, $40F0
                dc.w    $C0C0, $1040, $FE04, $8F8, $A840, $60A0, $A0E0, $6060
                dc.w    $E0E8, $18E8, $58F0, $E0D0, $C060, $E050, $E00C, $10F8
                dc.w    $5000, $20C8, $A098, $4060, $10F0, $12E8, $E048, $A402
                dc.w    $C000, $3838, $E0EC, $8F2, $8010, $7030, $B890, $D048
                dc.w    $D008, $10F0, $9020, $20E0, $C0E0, $2040, $F820, $4FC

; Sets sprite graphics pointer based on difficulty flag
Boss_SylpheedSetGraphics:
                move.w  #$C4D6,$E(a5)                   ; was: sub_59D2C
                btst    #0,(word_FFA000+1).w
                beq.s   locret_59D40
                move.w  #$C4DF,$E(a5)
locret_59D40:                                           ; CODE XREF: Boss_SylpheedSetGraphics+C   j
                rts
; End of function Boss_SylpheedSetGraphics
; ---------------------------------------------------------------------------
off_59D42:      dc.l    word_ECC86                      ; DATA XREF: ROM:00059EB8   o
                                        ; ROM:00059EE4   o
                dc.l    word_ECC92
                dc.l    word_ECC98
                dc.l    word_ECCA4
                dc.l    word_ECCAA
                dc.l    word_ECCB6
                dc.l    word_ECCBC
                dc.l    word_ECCC8
off_59D62:      dc.l    word_ECCC8                      ; DATA XREF: ROM:00059EA4   o
                                        ; ROM:00059ECC   o
                dc.l    word_ECCBC
                dc.l    word_ECCB6
                dc.l    word_ECCAA
                dc.l    word_ECCA4
                dc.l    word_ECC98
                dc.l    word_ECC92
                dc.l    word_ECC86
                dc.l    word_ECCDA
                dc.l    word_ECCE0
                dc.l    word_ECCE6
                dc.l    word_ECCF2
                dc.l    word_ECCF8
                dc.l    word_ECCFE
                dc.l    word_ECD04
                dc.l    word_ECD10
off_59DA2:      dc.l    word_ECD10                      ; DATA XREF: ROM:00059EA0   o
                                        ; ROM:0005A034   o
                dc.l    word_ECD04
                dc.l    word_ECCFE
                dc.l    word_ECCF8
                dc.l    word_ECCF2
                dc.l    word_ECCE6
                dc.l    word_ECCE0
                dc.l    word_ECCDA
off_59DC2:      dc.l    word_ECD16                      ; DATA XREF: ROM:00059EF4   o
                                        ; ROM:00059F6E   o
                dc.l    word_ECD1C
                dc.l    word_ECD22
                dc.l    word_ECD28
                dc.l    word_ECD2E
                dc.l    word_ECD34
                dc.l    word_ECD3A
                dc.l    word_ECD40
off_59DE2:      dc.l    word_ECD40                      ; DATA XREF: ROM:00059EDC   o
                                        ; ROM:00059F66   o
                dc.l    word_ECD3A
                dc.l    word_ECD34
                dc.l    word_ECD2E
                dc.l    word_ECD28
                dc.l    word_ECD22
                dc.l    word_ECD1C
                dc.l    word_ECD16
off_59E02:      dc.l    word_ECD46                      ; DATA XREF: ROM:00059EC4   o
                                        ; ROM:00059EEC   o
                dc.l    word_ECD4C
                dc.l    word_ECD58
                dc.l    word_ECD64
                dc.l    word_ECD70
                dc.l    word_ECD76
                dc.l    word_ECD82
                dc.l    word_ECD8E
off_59E22:      dc.l    word_ECD8E                      ; DATA XREF: ROM:00059EB0   o
                                        ; ROM:00059ED4   o
                dc.l    word_ECD82
                dc.l    word_ECD76
                dc.l    word_ECD70
                dc.l    word_ECD64
                dc.l    word_ECD58
                dc.l    word_ECD4C
                dc.l    word_ECD46
off_59E42:      dc.l    word_ECD9A                      ; DATA XREF: ROM:00059EB4   o
                dc.l    word_ECDA0
                dc.l    word_ECDA6
                dc.l    word_ECDAC
                dc.l    word_ECDB2
                dc.l    word_ECDB8
                dc.l    word_ECDBE
                dc.l    word_ECDC4
off_59E62:      dc.l    word_ECDC4                      ; DATA XREF: ROM:00059EC8   o
                dc.l    word_ECDBE
                dc.l    word_ECDB8
                dc.l    word_ECDB2
                dc.l    word_ECDAC
                dc.l    word_ECDA6
                dc.l    word_ECDA0
                dc.l    word_ECD9A
word_59E82:     dc.w    $42D, $F00, $F0F0               ; DATA XREF: ROM:00059E98   o
                                        ; ROM:0005A038   o
word_59E88:     dc.w    $43D, $A00, $F4F4               ; DATA XREF: ROM:00059E9C   o
                                        ; ROM:off_59F5E   o
word_59E8E:     dc.w    $446, $500, $F8F8               ; DATA XREF: ROM:00059EAC   o
                                        ; ROM:00059EC0   o
off_59E94:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_ValkirieIntroStop+10   o
                dc.l    word_59E82+1
                dc.l    word_59E88+1
                dc.l    off_59DA2-$40000000
                dc.l    off_59D62
                dc.l    0
                dc.l    word_59E8E+1
                dc.l    off_59E22
                dc.l    off_59E42+$8000000
                dc.l    off_59D42+$18000000
                dc.l    0
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59E62
                dc.l    off_59D62
                dc.l    word_59E8E+1
                dc.l    off_59E22
                dc.l    0
                dc.l    off_59DE2
                dc.l    word_59E8E+1
                dc.l    off_59D42+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    0
                dc.l    off_59DC2+$18000000
                dc.l    word_59E8E+1
word_59EFC:     dc.w    $12, $E15, $1F09                ; DATA XREF: Boss_ValkirieIntroStop+16   o
                dc.w    $1212, $251F, $912
                dc.w    $1225, $192C, $1426
                dc.w    $E04, $192C, $1426
                dc.w    $E04
word_59F16:     dc.w    $C004, $C004, $C064
                                        ; DATA XREF: Boss_ValkirieIntroStop+1C   o
                dc.w    $C002, $C002, $C182
                dc.w    $C182, $C241, $C240
                dc.w    $C002, $C362, $C362
                dc.w    $C421, $C420, $C0C6
                dc.w    $C0C6, $C5A6, $C5A5
                dc.w    $C664, $C665, $C0C6
                dc.w    $C0C6, $C7E6, $C7E5
                dc.w    $C8A4, $C8A5
word_59F4A:     dc.w    $C080, $4000, $8080
                                        ; DATA XREF: Boss_ValkirieIntroStop+28   o
                dc.w    $8080, $80E0, $8080
                dc.w    $80A0, $8080, $8080
                dc.w    $8080
off_59F5E:      dc.l    word_59E88+1                    ; DATA XREF: Boss_ValkirieMovePattern1+1E   o
                dc.l    off_59D62
                dc.l    off_59DE2
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    0
word_59F76:     dc.w    $14, $2C14, $2C18               ; DATA XREF: Boss_ValkirieMovePattern1+24   o
word_59F7C:     dc.w    $C000, $C001, $C001
                                        ; DATA XREF: Boss_ValkirieMovePattern1+2A   o
                dc.w    $C001, $C001, 0
off_59F88:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_MedusaAttackState2+1C   o
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E88+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59DC2+$18000000
word_59FDC:     dc.w    $18, $1010, $100F               ; DATA XREF: Boss_MedusaAttackState2+22   o
                dc.w    $1810, $1010, $F18
                dc.w    $1010, $100F, $1810
                dc.w    $1010, $F00
word_59FF2:     dc.w    $C005, $C003, $C064
                                        ; DATA XREF: Boss_MedusaAttackState2+28   o
                dc.w    $C0C4, $C124, $C184
                dc.w    $C003, $C244, $C2A4
                dc.w    $C304, $C364, $C003
                dc.w    $C424, $C484, $C4E4
                dc.w    $C544, $C003, $C604
                dc.w    $C664, $C6C4, $C724
word_5A01C:     dc.w    $8080, $8080, $8080
                                        ; DATA XREF: Boss_MedusaAttackState2+34   o
                dc.w    $8000
off_5A024:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_SylpheedBattleStart+10   o
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    off_59DA2
                dc.l    word_59E82+1
                dc.l    off_59D42+$18000000
                dc.l    off_59D42+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E88+1
                dc.l    off_59DE2
                dc.l    word_59E82+1
                dc.l    off_59E22
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59D62-$80000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DE2
                dc.l    off_59D62
                dc.l    word_59E82+1
                dc.l    off_59E22
                dc.l    word_59E88+1
                dc.l    off_59D42-$68000000
                dc.l    off_59D42-$68000000
                dc.l    off_59D42-$68000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59D42+$18000000
word_5A090:     dc.w    $1A, $E0E, $E18                 ; DATA XREF: Boss_SylpheedBattleStart+16   o
                dc.w    $1613, $1318, $1416
                dc.w    $121D, $1212, $1212
                dc.w    $1216, $121D, $1212
                dc.w    $1212, $1200
word_5A0AC:     dc.w    $C00A, $C009, $C068
                                        ; DATA XREF: Boss_SylpheedBattleStart+1C   o
                dc.w    $C0C8, $C128, $C00A
                dc.w    $C1EA, $C24A, $C2AA
                dc.w    $C309, $C36B, $C007
                dc.w    $C426, $C485, $C4E4
                dc.w    $C543, $C5A2, $C602
                dc.w    $C4E6, $C00D, $C72C
                dc.w    $C78D, $C7ED, $C84D
                dc.w    $C8AD, $C90D, $C7ED
word_5A0E2:     dc.w    $80, $C080, $4040               ; DATA XREF: Boss_SylpheedBattleStart+28   o
                dc.w    $80C0, $8080, $8080
off_5A0EE:      dc.l    word_59E82+1                    ; DATA XREF: Boss_ArtemisBattleStart+10   o
                dc.l    word_ECDCA+$400000
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59DA2
                dc.l    off_59D42-$38000000
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59E22
                dc.l    off_59D62
                dc.l    off_59DC2+$18000000
word_5A166:     dc.w    $1C, $141A, $120A               ; DATA XREF: Boss_ArtemisBattleStart+16   o
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2208, $1010
                dc.w    $1022, $812, $1212
word_5A184:     dc.w    $C008, $C007, $C007
                                        ; DATA XREF: Boss_ArtemisBattleStart+1C   o
                dc.w    $C067, $C126, $C061
                dc.w    $C1E3, $C1E2, $C2A3
                dc.w    $C2A1, $C361, $C060
                dc.w    $C429, $C42A, $C4E9
                dc.w    $C4E8, $C5A8, $C0C6
                dc.w    $C666, $C6C6, $C6C4
                dc.w    $C784, $C0CB, $C84C
                dc.w    $C8AB, $C8AA, $C96A
                dc.w    $C0C8, $CA27, $CA87
word_5A1C0:     dc.w    $80, $C0, $C080                 ; DATA XREF: Boss_ArtemisBattleStart+28   o
                dc.w    $80C0, $C080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $80F0
off_5A1D4:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_SireneIntroStop+10   o
                dc.l    word_59E82+1
                dc.l    off_59DA2-$40000000
                dc.l    0
                dc.l    off_59D62
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    off_59D42+$18000000
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E8E+1
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    0
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59DC2+$18000000
word_5A244:     dc.w    $8098, $9598, $8494
                                        ; DATA XREF: Boss_SireneIntroStop+16   o
                dc.w    $9090, $9097, $9797
                dc.w    $9798, $8494, $9090
                dc.w    $9097, $9797, $9794
                dc.w    $8EA0, $9898
word_5A260:     dc.w    $C008, $C008, $C007
                                        ; DATA XREF: Boss_SireneIntroStop+1C   o
                dc.w    $C000, $C125, $C124
                dc.w    $C1E4, $C244, $C2A2
                dc.w    $C303, $C303, $C303
                dc.w    $C303, $C000, $C4E5
                dc.w    $C4E4, $C5A4, $C604
                dc.w    $C662, $C6C3, $C6C3
                dc.w    $C6C3, $C6C3, $C068
                dc.w    $68, $C908, $C968
                dc.w    $C9C8
word_5A298:     dc.w    $2080, $60, $8080               ; DATA XREF: Boss_SireneIntroStop+28   o
                dc.w    $C080, $4080
off_5A2A2:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_ValkirieInitAlt+10   o
                dc.l    word_59E82+1
                dc.l    off_59DE2
                dc.l    off_59E22
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59D62+$10000000
                dc.l    off_59DE2+$10000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59D42+$8000000
                dc.l    off_59DC2+$8000000
                dc.l    word_59E88+1
                dc.l    off_59E22
                dc.l    off_59DE2
                dc.l    word_59E88+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2+$18000000
                dc.l    word_59E82+1
                dc.l    off_59DE2
                dc.l    word_59E82+1
                dc.l    off_59DC2+$18000000
word_5A302:     dc.w    $1A, $1814, $1D15               ; DATA XREF: Boss_ValkirieInitAlt+16   o
                dc.w    $1515, $151D, $1515
                dc.w    $1515, $1428, $1014
                dc.w    $2810, $1412, $1412
word_5A31A:     dc.w    $C002, $C003, $C001
                                        ; DATA XREF: Boss_ValkirieInitAlt+1C   o
                dc.w    $C068, $C002, $C182
                dc.w    $C1E2, $C242, $C2A2
                dc.w    $C002, $C362, $C3C2
                dc.w    $C422, $C482, $C063
                dc.w    $C063, $C5A2, $C063
                dc.w    $C063, $C6C2, $C004
                dc.w    $C784, $C004, $C844
word_5A34A:     dc.w    0, 0, $C0                       ; DATA XREF: Boss_ValkirieInitAlt+28   o
                dc.w    $E0C0, $20C0, $8080
off_5A356:      dc.l    word_ECDCA+$400000              ; DATA XREF: Boss_Unknown1InitMetasprite+10   o
                dc.l    word_59E82+1
                dc.l    word_59E88+1
                dc.l    off_59D62-$80000000
                dc.l    off_59DA2
                dc.l    off_59D42-$38000000
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2-$48000000
                dc.l    off_59DC2+$18000000
                dc.l    0
                dc.l    word_59E88+1
                dc.l    word_59E8E+1
                dc.l    off_59E02+$18000000
                dc.l    off_59DC2-$48000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62-$80000000
                dc.l    off_59DC2+$18000000
                dc.l    off_59E02+$18000000
                dc.l    word_59E8E+1
                dc.l    off_59DC2-$68000000
                dc.l    off_59D62
                dc.l    off_59D62
                dc.l    off_59DC2+$28000000
word_5A3CE:     dc.w    $1C, $141A, $120A               ; DATA XREF: Boss_Unknown1InitMetasprite+16   o
                dc.w    $1020, $1020, $808
                dc.w    $1020, $1020, $810
                dc.w    $1010, $2008, $1010
                dc.w    $1020, $812, $1212
word_5A3EC:     dc.w    $C007, $C008, $C067
                                        ; DATA XREF: Boss_Unknown1InitMetasprite+1C   o
                dc.w    $C007, $C126, $C001
                dc.w    $C1E3, $C1E2, $C2A3
                dc.w    $C2A1, $C361, $C000
                dc.w    $C429, $C42A, $C4E9
                dc.w    $C4E8, $C5A8, $C0C6
                dc.w    $C665, $C6C6, $C6C4
                dc.w    $C784, $C0CB, $C84C
                dc.w    $C8AB, $C8AA, $C96A
                dc.w    $C0C7, $CA27, $CA87
word_5A428:     dc.w    $8080, $C0, $8080               ; DATA XREF: Boss_Unknown1InitMetasprite+28   o
                dc.w    $80C0, $8080, $80A0
                dc.w    $8080, $A080, $8080
                dc.w    $8080

; Empty entity state handler in main dispatch table
Entity_EmptyState3:                                     ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_3
                rts
; End of function Entity_EmptyState3
; ---------------------------------------------------------------------------
word_5A43E:     binclude "data/other/word_5A43E.bin"
word_5A43E_End:
                ; dc.b [$257B2]$FF
                org     $82324

; Attributes: thunk
; Thunk to main sound driver update
