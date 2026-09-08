Boss_JokerRenderBody:                                   ; CODE XREF: Boss_JokerDefeatAnim+98   p  ; was: sub_3BA1A
                                        ; Boss_JokerFallingPhase2+30   j
                movea.w #(word_FFCD40-M68K_RAM),a0
                movea.w #(byte_FFCE00-M68K_RAM),a1
                movea.w #(word_FFCDA0-M68K_RAM),a2
                movea.w #(byte_FFCE60-M68K_RAM),a3
                tst.w   $54(a5)
                beq.s   loc_3BA34
                exg     a0,a1
                exg     a2,a3
loc_3BA34:                                              ; CODE XREF: Boss_JokerRenderBody+14   j
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                move.w  #$FFE4,$40(a0)
                move.w  #$10,$44(a0)
                move.w  #$1C,$40(a1)
                move.w  #$10,$44(a1)
                move.w  $1DC(a5),d5
                subi.w  #$40,d5                         ; '@'
                asr.w   #1,d5
                addi.w  #$24,d5                         ; '$'
                move.w  #$FFE3,$40(a2)
                move.w  d5,$44(a2)
                move.w  #$1D,$40(a3)
                move.w  d5,$44(a3)
                moveq   #$15,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                cmpi.w  #$60,$10(a5)                    ; '`'
                bmi.s   loc_3BA8E
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_3BA96
loc_3BA8E:                                              ; CODE XREF: Boss_JokerRenderBody+6A   j
                move.w  #$FE72,(dword_FFA908).w
                bra.s   loc_3BAA2
; ---------------------------------------------------------------------------
loc_3BA96:                                              ; CODE XREF: Boss_JokerRenderBody+72   j
                move.w  #$C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
loc_3BAA2:                                              ; CODE XREF: Boss_JokerRenderBody+7A   j
                move.w  #$80,d0
                move.w  #$5F,d7                         ; '_'
                movea.w #(byte_FF9520-M68K_RAM),a0
loc_3BAAE:                                              ; CODE XREF: Boss_JokerRenderBody+98   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_3BAAE
                moveq   #0,d5
                move.w  $1DC(a5),d5
                subi.w  #$40,d5                         ; '@'
                beq.s   loc_3BAD4
                ext.l   d5
                asl.l   #8,d5
                divs.w  $1DC(a5),d5
                swap    d5
                move.w  #0,d5
                asr.l   #8,d5
                asl.l   #1,d5
loc_3BAD4:                                              ; CODE XREF: Boss_JokerRenderBody+A6   j
                moveq   #0,d3
                move.w  #$1B0,d3
                sub.w   $14(a5),d3
                move.l  d3,d4
                move.w  $14(a5),d0
                subi.w  #$98,d0
                addi.w  #-$6AE0,d0
                bclr    #0,d0
                movea.w d0,a0
                movea.w d0,a1
                moveq   #$1E,d7
loc_3BAF6:                                              ; CODE XREF: Boss_JokerRenderBody+EC   j
                move.w  d3,-(a0)
                move.w  d4,(a1)+
                swap    d3
                add.l   d5,d3
                swap    d3
                swap    d4
                sub.l   d5,d4
                swap    d4
                dbf     d7,loc_3BAF6
                movea.w #(word_FF9600-M68K_RAM),a0
                movea.w #(dword_FF9610-M68K_RAM),a1
                lea     word_3BC1A(pc),a2
                nop
                move.w  (word_FFA000).w,d0
                andi.w  #$1C,d0
                move.w  (a2,d0.w),d1
                move.w  2(a2,d0.w),d2
                move.w  $20(a2,d0.w),d3
                move.w  $22(a2,d0.w),d4
                move.w  d1,8(a0)
                move.w  d2,$A(a0)
                addi.w  #$800,d1
                addi.w  #$800,d2
                move.w  d2,4(a0)
                move.w  d1,6(a0)
                move.w  d3,8(a1)
                move.w  d4,$A(a1)
                addi.w  #$800,d3
                addi.w  #$800,d4
                move.w  d4,4(a1)
                move.w  d3,6(a1)
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_3BB70
                eori.w  #1,$29E(a5)
loc_3BB70:                                              ; CODE XREF: Boss_JokerRenderBody+14E   j
                move.w  $29C(a5),d0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_3BB96
                tst.w   $29E(a5)
                bne.w   loc_3BB8C
                subq.w  #4,d0
                bpl.s   loc_3BB96
                moveq   #0,d0
                bra.s   loc_3BB96
; ---------------------------------------------------------------------------
loc_3BB8C:                                              ; CODE XREF: Boss_JokerRenderBody+166   j
                addq.w  #4,d0
                cmpi.w  #$10,d0
                bmi.s   loc_3BB96
                moveq   #$C,d0
loc_3BB96:                                              ; CODE XREF: Boss_JokerRenderBody+160   j
                                        ; Boss_JokerRenderBody+16C   j
                move.w  d0,$29C(a5)
                lea     word_3BC5A(pc),a2
                nop
                move.w  (a2,d0.w),d1
                move.w  2(a2,d0.w),d2
                move.w  $10(a2,d0.w),d3
                move.w  $12(a2,d0.w),d4
                move.w  d1,$C(a0)
                move.w  d2,$E(a0)
                addi.w  #$800,d1
                addi.w  #$800,d2
                move.w  d2,(a0)
                move.w  d1,2(a0)
                move.w  d3,$C(a1)
                move.w  d4,$E(a1)
                addi.w  #$800,d3
                addi.w  #$800,d4
                move.w  d4,(a1)
                move.w  d3,2(a1)
                move.l  #$8F02977F,d0
                move.l  #$94009308,d1
                movea.w (word_FFF70C).w,a4
                move.w  #$83,-(a4)
                move.w  #$6188,-(a4)
                move.w  #$9500,-(a4)
                move.w  #$96CB,-(a4)
                move.l  d0,-(a4)
                move.l  d1,-(a4)
                move.w  #$83,-(a4)
                move.w  #$6208,-(a4)
                move.w  #$9508,-(a4)
                move.w  #$96CB,-(a4)
                move.l  d0,-(a4)
                move.l  d1,-(a4)
                move.w  a4,(word_FFF70C).w
                rts
; End of function Boss_JokerRenderBody
; ---------------------------------------------------------------------------
word_3BC1A:     dc.w    $E302, $E303, $E32E, $E330, $E332, $E334, $E336, $E338
                                        ; DATA XREF: Boss_JokerRenderBody+F8   o
                dc.w    $E336, $E338, $E332, $E334, $E32E, $E330, $E302, $E303
                dc.w    $E306, $E307, $E32F, $E331, $E333, $E335, $E337, $E339
                dc.w    $E337, $E339, $E333, $E335, $E32F, $E331, $E306, $E307
word_3BC5A:     dc.w    $E342, $E344, $E33E, $E340, $E33A, $E33C, $E304, $E305
                                        ; DATA XREF: Boss_JokerRenderBody+180   o
                dc.w    $E343, $E345, $E33F, $E341, $E33B, $E33D, $E308, $E309

; Calculate Joker boss Y position based on horizontal offset
Boss_JokerCalculateYPosition:                           ; CODE XREF: Boss_JokerLandingImpact:loc_3B98A   p  ; was: sub_3BC7A
                                        ; Boss_JokerLandingImpact+A4   p
                move.w  $1DC(a5),d0
                subi.w  #$40,d0                         ; '@'
                asr.w   #1,d0
                addi.w  #$C8,d0
                move.w  d0,$14(a5)
                rts
; End of function Boss_JokerCalculateYPosition
; Slows Joker boss horizontal velocity towards zero with fixed rate
Boss_JokerSlowHorizontal:                               ; CODE XREF: Boss_JokerStretchState:loc_3B874   p  ; was: sub_3BC8E
                move.l  $18(a5),d0
                beq.s   locret_3BCA4
                bmi.s   loc_3BCA6
                subi.l  #$2000,d0
                bpl.s   loc_3BCA0
loc_3BC9E:                                              ; CODE XREF: Boss_JokerSlowHorizontal+1E   j
                moveq   #0,d0
loc_3BCA0:                                              ; CODE XREF: Boss_JokerSlowHorizontal+E   j
                move.l  d0,$18(a5)
locret_3BCA4:                                           ; CODE XREF: Boss_JokerSlowHorizontal+4   j
                rts
; ---------------------------------------------------------------------------
loc_3BCA6:                                              ; CODE XREF: Boss_JokerSlowHorizontal+6   j
                addi.l  #$2000,d0
                bpl.s   loc_3BC9E
                move.l  d0,$18(a5)
                rts
; End of function Boss_JokerSlowHorizontal
; Updates Joker boss animation with interpolation for body parts
Boss_JokerUpdateAnimation:                              ; CODE XREF: Boss_JokerDefeatAnim+36   p  ; was: sub_3BCB4
                                        ; Boss_JokerFallingPhase2+2C   p
                clr.w   $3BC(a5)
                tst.w   $C(a5)
                bpl.s   loc_3BD36
loc_3BCBE:                                              ; CODE XREF: Boss_JokerUpdateAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3BD46
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3BCE0
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3BCE0:                                              ; CODE XREF: Boss_JokerUpdateAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3BCF0
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3BCF0:                                              ; CODE XREF: Boss_JokerUpdateAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3BD00
                clr.w   $58(a5)
                clr.w   $35E(a5)
                bra.s   loc_3BCBE
; ---------------------------------------------------------------------------
loc_3BD00:                                              ; CODE XREF: Boss_JokerUpdateAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3BF88,d0
                movea.l d0,a0
                bsr.w   Boss_JokerCalcDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$35E(a5)
                addq.w  #1,$3BC(a5)
                tst.w   $C(a5)
                bmi.s   loc_3BD46
loc_3BD36:                                              ; CODE XREF: Boss_JokerUpdateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #9,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_3BD46:                                              ; CODE XREF: Boss_JokerUpdateAnimation+E   j
                                        ; Boss_JokerUpdateAnimation+80   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #1,d6
                move.w  #$1FE,d7
                move.b  (a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.w  d0,$116(a5)
                move.b  4(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  8(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $C(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  $10(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$2F6(a5)
                move.w  d1,$356(a5)
                move.b  $18(a0),d0
                asl.w   d6,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d0
                asl.w   d6,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $20(a0),d1
                asl.w   d6,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $24(a0),d0
                asl.w   d6,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                rts
; End of function Boss_JokerUpdateAnimation
; Calculates interpolation deltas for smooth boss animation transitions
Boss_JokerCalcDeltas:                                   ; CODE XREF: Boss_JokerUpdateAnimation+62   p  ; was: sub_3BDF4
                movea.l #Boss_JokerNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #9,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_JokerCalcDeltas
; Load animation frame delays for Joker boss
Boss_JokerLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1     ; was: sub_3BE0A
                moveq   #9,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_JokerLoadFrameDelays
; Spawns bomb projectile during special attack with damage value
Boss_JokerSpawnBomb:                                    ; CODE XREF: Boss_JokerSpinDive+42   p  ; was: sub_3BE16
                tst.w   $35C(a5)
                bne.s   locret_3BE82
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                bne.s   locret_3BE82
                subi.w  #$14,(word_FF8234).w
                move.w  #$198,(a0)
                move.w  #$8100,2(a0)
                move.w  #$436A,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #$20,$20(a0)                    ; ' '
                move.w  #$50,$24(a0)                    ; 'P'
                move.b  #$80,$21(a0)
                move.l  #$F808F808,$28(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #$26,$14(a0)                    ; '&'
                move.w  #$C0,$48(a0)
                move.w  #4,$4A(a0)
locret_3BE82:                                           ; CODE XREF: Boss_JokerSpawnBomb+4   j
                                        ; Boss_JokerSpawnBomb+10   j
                rts
; End of function Boss_JokerSpawnBomb
; Joker bomb projectile descending then firing directional shots
Projectile_JokerBomb:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3BE84
                tst.w   (word_FF808C).w
                bmi.s   loc_3BE92
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3BE92:                                              ; CODE XREF: Projectile_JokerBomb+4   j
                tst.w   $24(a5)
                bpl.s   loc_3BE9E
loc_3BE98:                                              ; CODE XREF: Projectile_JokerBomb+68   j
                jmp     Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
loc_3BE9E:                                              ; CODE XREF: Projectile_JokerBomb+12   j
                cmpi.w  #$148,$14(a5)
                bpl.s   loc_3BEB0
                addq.w  #2,$14(a5)
                move.w  (dword_FFC630).w,$10(a5)
loc_3BEB0:                                              ; CODE XREF: Projectile_JokerBomb+20   j
                subq.w  #1,$48(a5)
                bpl.s   loc_3BEF0
                movea.w #(byte_FFD400-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                bne.s   loc_3BEE8
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr     (Enemy_InitDirectionalProjectile).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,$48(a5)
loc_3BEE8:                                              ; CODE XREF: Projectile_JokerBomb+3C   j
                subq.w  #1,$4A(a5)
                bmi.s   loc_3BE98
locret_3BEEE:                                           ; CODE XREF: Projectile_JokerBomb+78   j
                                        ; Projectile_JokerBomb+86   j
                rts
; ---------------------------------------------------------------------------
loc_3BEF0:                                              ; CODE XREF: Projectile_JokerBomb+30   j
                move.w  #$F8F8,$A(a5)
                cmpi.w  #$30,$48(a5)                    ; '0'
                bpl.s   locret_3BEEE
                move.w  #$F7F8,$A(a5)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_3BEEE
                move.w  #$F9F8,$A(a5)
                rts
; End of function Projectile_JokerBomb
; ---------------------------------------------------------------------------
word_3BF14:     dc.w    $1818, 0, $814, $A, $1919, $A, $1818, 0, $814, $A, $1919, $A, $FFFF
                                        ; DATA XREF: Boss_JokerDefeatAnim:loc_3B464   o
word_3BF2E:     dc.w    $2020, $14, $2020, $1E, $FFFF
                                        ; DATA XREF: Boss_JokerInitTauntState+1C   o
word_3BF38:     dc.w    $1018, $28, $2424, $28, $FFFE
                                        ; DATA XREF: Boss_JokerDivePrep+6   o
                                        ; Boss_JokerLandingState+E   o
word_3BF42:     dc.w    $E12, $32, $1C1C, $32, $FFFE
                                        ; DATA XREF: Boss_JokerDivePrep+8A   o
word_3BF4C:     dc.w    $E38, $3C, $E0E, $3C, $FFFE
                                        ; DATA XREF: Boss_JokerSpinDive+A   o
                                        ; Boss_JokerGroundBounceAttack+1C   o
word_3BF56:     dc.w    $F0F, $32, $FFFE                ; DATA XREF: Boss_JokerLandingImpact+20   o
word_3BF5C:     dc.w    $80C, $3C, $2424, $3C, $FFFE
                                        ; DATA XREF: Boss_JokerLandingImpact+7A   o
word_3BF66:     dc.w    $6868, $32, $FFFE               ; DATA XREF: Boss_JokerLandingImpact+A8   o
word_3BF6C:     dc.w    $508, $28, $1616, $28, $810, $1E, $2020, $1E, $FFFE
                                        ; DATA XREF: Boss_JokerStretchState+2A   o
word_3BF7E:     dc.w    $E0E, $5A, $E0E, $64, $FFFF
                                        ; DATA XREF: Boss_JokerFallingPhase2:loc_3B5C6   o
word_3BF88:     dc.w    $40D8, $4028, $64F0, $301C, $10D0, $7000, $C060, $78FA
                                        ; DATA XREF: Boss_JokerUpdateAnimation+5A   o
                dc.w    $3CF0, $68A8, $40F0, $4010, $9098, $58F0, $68A8, $80B0
                dc.w    $50, $78B4, $5808, $4CA8, $9020, $F0E0, $A890, $48D8
                dc.w    $70B8, $2000, $6000, $30F8, $2050, $8E0, $9010, $F0F0
                dc.w    $70E0, $5810, $20A8, $40F0, $4010, $30F8, $5050, $8B0
                dc.w    $6810, $18F0, $8010, $2000, $F0E0, $A020, $2020, $9090
                dc.w    $58D0, $20A0, $60E0, $E0E0, $B0E0, $60F0, $7098

; Main Flying-Neo boss handler with state dispatch
