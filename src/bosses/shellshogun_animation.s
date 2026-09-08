; Flash boss sprite when taking damage
Boss_ShellshogunFlashOnHit:                             ; CODE XREF: Boss_ShellshogunDefeatLaunchState:Boss_ShellshogunRenderDefeatLaunch   p  ; was: sub_3A122
                jsr     (Projectile_UpdateAfterGlobalDelay).l
                bne.s   locret_3A170
                jsr     (Sprite_InitTypeA4FromTable).l
                clr.b   $20(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                neg.l   $18(a0)
                neg.l   $1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$20,d1                         ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_3A170:                                           ; CODE XREF: Boss_ShellshogunFlashOnHit+6   j
                rts
; End of function Boss_ShellshogunFlashOnHit
; Updates boss animation frame and interpolation
Boss_ShellshogunAnimUpdate:                             ; CODE XREF: Boss_ShellshogunDefeatLaunchState+B0   p  ; was: sub_3A172
                                        ; Boss_ShellshogunDecisionState+7A   p
                clr.w   $17C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3A1D4
loc_3A17C:                                              ; CODE XREF: Boss_ShellshogunAnimUpdate+2A   j
                move.w  $58(a5),d0
                bmi.s   loc_3A1E4
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3A192
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3A192:                                              ; CODE XREF: Boss_ShellshogunAnimUpdate+18   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3A19E
                clr.w   $58(a5)
                bra.s   loc_3A17C
; ---------------------------------------------------------------------------
loc_3A19E:                                              ; CODE XREF: Boss_ShellshogunAnimUpdate+24   j
                addq.w  #4,$58(a5)
                subq.w  #1,$11E(a5)
                addq.w  #1,$17C(a5)
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3A38A,d0
                movea.l d0,a0
                bsr.w   Boss_ShellshogunCalculateAnimationDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                tst.w   $C(a5)
                bmi.s   loc_3A1E4
loc_3A1D4:                                              ; CODE XREF: Boss_ShellshogunAnimUpdate+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$E,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_3A1E4:                                              ; CODE XREF: Boss_ShellshogunAnimUpdate+E   j
                                        ; Boss_ShellshogunAnimUpdate+60   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
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
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d0,$3B6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$416(a5)
                move.w  d1,$476(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
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
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.w  d0,$7D6(a5)
                move.b  $34(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$836(a5)
                move.w  d1,$896(a5)
                move.b  $38(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$8F6(a5)
                rts
; End of function Boss_ShellshogunAnimUpdate
; Calculates per-channel deltas toward Shellshogun's neutral pose
Boss_ShellshogunCalculateAnimationDeltas:               ; CODE XREF: Boss_ShellshogunAnimUpdate+4E   p  ; was: sub_3A2CC
                movea.l #Boss_ShellshogunNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                subq.w  #1,$C(a5)
                moveq   #$E,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ShellshogunCalculateAnimationDeltas
; ---------------------------------------------------------------------------
word_3A2E6:     dc.w    $10, $F, $18, 0, $FFFF
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                                        ; Boss_ShellshogunDecisionState:Boss_ShellshogunUpdateDecisionPose   o
word_3A2F0:     dc.w    $F030, $1E, $70, $1E, $FFFE
                                        ; DATA XREF: Boss_ShellshogunDecisionState+CC   o
word_3A2FA:     dc.w    $EF11, $5A, $E830, $87, $E, $87, $9080, $96, $12, $96, $9080, $87, $FFFE
                                        ; DATA XREF: Boss_ShellshogunUpdateSlamAnimation   o
word_3A314:     dc.w    $17, $2D, $10, $3C, $1B, $4B, $21, $5A, $FFFF
                                        ; DATA XREF: Boss_ShellshogunUpdateSharedPose   o
word_3A326:     dc.w    $FE14, $69, 6, $69, $FE12, $78, 6, $78, $FFFF
                                        ; DATA XREF: Boss_ShellshogunJumpAttackWindupState:Boss_ShellshogunRenderJumpWindup   o
word_3A338:     dc.w    $FE28, $F, $FFFE                ; DATA XREF: Boss_ShellshogunJumpAttackAirState:Boss_ShellshogunRenderJumpAir   o
word_3A33E:     dc.w    $FC18, $A6, $FD18, $A6, $13, $A6, $FF0E, $B5, $A, $B5, $D840, $A6, $FFFE
                                        ; DATA XREF: Boss_ShellshogunDirectionalAttackWindupState:Boss_ShellshogunUpdateDirectionalAttackWindup   o
                                        ; Boss_ShellshogunDirectionalAttackMotionState:Boss_ShellshogunRenderDirectionalAttack   o
word_3A358:     dc.w    $FC18, $E2, $FD18, $E2, $FE0E, $D3, $FF0E, $C4, $18, $C4, $16, $E2, $FFFE
                                        ; DATA XREF: Boss_ShellshogunLeapWindupState+6   o
                                        ; Boss_ShellshogunLeapFlightState:Boss_ShellshogunRenderLeapFlight   o
word_3A372:     dc.w    $FC0C, $E2, $18, $E2, $FC0C, $F, $FFFE
                                        ; DATA XREF: Boss_ShellshogunLeapRecoveryState+28   o
word_3A380:     dc.w    $C, $C4, $C, $E2, $FFFF
                                        ; DATA XREF: Boss_ShellshogunDefeatLaunchState+AA   o
word_3A38A:     dc.w    $CCE8, $20E8, $2013, $FE2, $A870, $3060, $78B8, $4CC0, $E010, $F020, $1400, $F0A0, $7844, $6080, $BC40, $C0D0
                                        ; DATA XREF: Boss_ShellshogunAnimUpdate+46   o
                dc.w    $F0E0, $2020, $20C0, $B090, $2060, $60E0, $40CC, $E810, $F020, $F870, $F0A8, $7030, $5060, $F030, $D0E0, $20F8
                dc.w    $2010, $28C0, $B090, $5860, $70E8, $30CE, $E418, $FC20, $2840, $A0B8, $8018, $5090, $9010, $BCD4, $D0, $3030
                dc.w    $4090, $9C50, $1050, $50C0, $70C4, $D8C0, $C020, $848, $B4B8, $C040, $6078, $B84C, $BCE8, $5020, $3000, $44C0
                dc.w    $9828, $E050, $80BC, $40B0, $C0D0, $C000, $E070, $F090, $8020, $5050, $A090, $D800, $4000, $3010, $20C0, $B8A0
                dc.w    $6060, $6808, $1040, $B4D2, $5040, $2014, $F0, $9848, $A460, $78A8, $5CD8, $F000, $20, $1050, $A0B8, $A0D0
                dc.w    $6068, $810, $C0E0, $4040, $2020, $60C0, $A040, $C060, $60A0, $40C0, $D0D0, $F030, $3010, $C0B0, $B010, $5050
                dc.w    $F040, $C0E0, $20C0, $1000, $609C, $A060, $4070, $80A0, $64FF
