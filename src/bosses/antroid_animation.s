; Antroid pose interpolation, animation helpers, and command streams

; Interpolates animation values toward the next command target
Anim_InterpolateToTarget:                               ; CODE XREF: Boss_AntroidIdleState+6   p  ; was: sub_3811A
                                        ; Boss_AntroidReturnToNeutral+36   p
                clr.w   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_3819C
loc_38124:                                              ; CODE XREF: Anim_InterpolateToTarget+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_381AC
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_38146
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_38146:                                              ; CODE XREF: Anim_InterpolateToTarget+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_38156
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_38156:                                              ; CODE XREF: Anim_InterpolateToTarget+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_38166
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_38124
; ---------------------------------------------------------------------------
loc_38166:                                              ; CODE XREF: Anim_InterpolateToTarget+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_383F8,d0
                movea.l d0,a0
                bsr.w   Boss_AntroidResetAnimation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                addq.w  #1,$23E(a5)
                tst.w   $C(a5)
                bmi.s   loc_381AC
loc_3819C:                                              ; CODE XREF: Anim_InterpolateToTarget+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$E,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_381AC:                                              ; CODE XREF: Anim_InterpolateToTarget+E   j
                                        ; Anim_InterpolateToTarget+80   j
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
                move.b  8(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$176(a5)
                movea.w #(dword_FF940C-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                movea.w #(dword_FF9424-M68K_RAM),a2
                movea.w #(dword_FF9430-M68K_RAM),a3
                tst.w   6(a5)
                beq.s   loc_381F2
                exg     a0,a1
                exg     a2,a3
loc_381F2:                                              ; CODE XREF: Anim_InterpolateToTarget+D2   j
                move.b  (a0),d2
                asl.w   #1,d2
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$1D6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$236(a5)
                move.w  d1,$296(a5)
                move.b  8(a0),d2
                asl.w   #1,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$2F6(a5)
                move.w  d2,$356(a5)
                move.b  (a1),d2
                asl.w   #1,d2
                add.w   d0,d2
                and.w   d7,d2
                move.w  d2,$5F6(a5)
                move.b  4(a1),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  8(a1),d2
                asl.w   #1,d2
                add.w   d1,d2
                and.w   d7,d2
                move.w  d2,$716(a5)
                move.w  d2,$776(a5)
                move.b  (a2),d0
                asl.w   #1,d0
                add.w   d3,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  4(a2),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  8(a2),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.b  (a3),d0
                asl.w   #1,d0
                add.w   d3,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.w  d0,$896(a5)
                move.b  4(a3),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$8F6(a5)
                move.w  d1,$956(a5)
                move.b  8(a3),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Anim_InterpolateToTarget
; Resets boss animation to initial state
Boss_AntroidResetAnimation:                             ; CODE XREF: Anim_InterpolateToTarget+62   p  ; was: sub_382BC
                movea.l #Boss_AntroidNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$E,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_AntroidResetAnimation
; Loads animation frame delay data for 14 frames of Antroid animation
Boss_AntroidLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1     ; was: sub_382D2
                moveq   #$E,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_AntroidLoadFrameDelays
; Calculates vertical offset based on two sprite positions for composite rendering
Boss_AntroidCalculateYOffset:
                move.w  $974(a5),d0                     ; was: sub_382DE
                move.w  $554(a5),d1
                cmp.w   d0,d1
                bpl.s   loc_382EC
                move.w  d0,d1
loc_382EC:                                              ; CODE XREF: Boss_AntroidCalculateYOffset+A   j
                move.w  #$14C,d0
                sub.w   d1,d0
                add.w   d0,$14(a5)
                rts
; End of function Boss_AntroidCalculateYOffset
; Ends attack phase and returns to idle
Boss_AntroidEndAttack:                                  ; CODE XREF: Boss_AntroidLeapAttackA:Boss_AntroidLeapAttackAFinish   p  ; was: sub_382F8
                                        ; Boss_AntroidLeapAttackA+74   p
                eori.w  #2,6(a5)
                movea.w #(dword_FF940C-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                movea.w #(dword_FF9424-M68K_RAM),a2
                movea.w #(dword_FF9430-M68K_RAM),a3
                moveq   #2,d7
; Swaps palette buffers for boss color animation
Boss_AntroidSwapPaletteBuffers:                         ; CODE XREF: Boss_AntroidEndAttack+24   j  ; was: loc_38310
                move.l  (a0),d0
                move.l  (a1),(a0)+
                move.l  d0,(a1)+
                move.l  (a2),d0
                move.l  (a3),(a2)+
                move.l  d0,(a3)+
                dbf     d7,Boss_AntroidSwapPaletteBuffers
                rts
; End of function Boss_AntroidEndAttack
; ---------------------------------------------------------------------------
word_38322:     dc.w    $2020, $60, $2020, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidIdleState   o
word_3832C:     dc.w    $131B, $70, $FFFE               ; DATA XREF: Boss_AntroidReturnToNeutral+30   o
                                        ; sub_379AA:Boss_AntroidJumpAttackAnimateLandingArc   o
word_38332:     dc.w    $80C, $60, $808, $60, $80C, $70, $808, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidReturnToNeutral:Boss_AntroidUpdateDecisionAnimation   o
word_38344:     dc.w    $204, $60, $202, $60, $204, $70, $202, $70, $FFFF
                                        ; DATA XREF: Boss_AntroidReturnToNeutral+FC   o
word_38356:     dc.w    $214, $E0, $106, $60, $FFFF
                                        ; DATA XREF: Boss_AntroidHealthRecoveryState+E   o
word_38360:     dc.w    $1313, $30, $A1E, $40, $2828, $40, $FFFE
                                        ; DATA XREF: Boss_AntroidPrepareLeapAttackA:Boss_AntroidPrepareLeapAttackAAnimate   o
                                        ; sub_377F6:Boss_AntroidLeapAttackAAnimate   o
word_3836E:     dc.w    $1313, $50, $A1E, $20, $2828, $20, $FFFE
                                        ; DATA XREF: Boss_AntroidPrepareLeapAttackB:Boss_AntroidPrepareLeapAttackBAnimate   o
                                        ; sub_378BE:Boss_AntroidLeapAttackBAnimate   o
word_3837C:     dc.w    $910, $90, $D0D, $90, $80D0, $80B, $A0, $410, $A0, $1010, $B0, $FFFE
                                        ; DATA XREF: Boss_AntroidPrepareJumpAttack+8   o
                                        ; sub_379AA:Boss_AntroidJumpAttackAnimateAirborne   o
word_38394:     dc.w    $60A, $90, $505, $90, $80B, $A0
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+202   o
word_383A0:     dc.w    $910, $90, $F0F, $90, $410, $C0, $C0C, $C0, $1313, $E0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+8   o
                                        ; sub_37A94:Boss_AntroidJumpSlamAnimateFirstArc   o
word_383B6:     dc.w    $608, $F0, $E0E, $F0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack+104   o
word_383C0:     dc.w    $C0C, $D0, $606, $D0, $E0E, $E0, $FFFE
                                        ; DATA XREF: Boss_AntroidJumpSlamAttack:Boss_AntroidJumpSlamAnimateSecondArc   o
word_383CE:     dc.w    $808, $E0, $FFFE                ; DATA XREF: Boss_AntroidJumpSlamAttack+1D2   o
word_383D4:     dc.w    $181C, $100, $A0A, $100, $608, $110, $FFFE
                                        ; DATA XREF: Boss_AntroidWaitState+6   o
word_383E2:     dc.w    $203, $110, $130, $60, $80A9, $FFFF
                                        ; DATA XREF: Boss_AntroidWaitState+72   o
word_383EE:     dc.w    $808, 0, $808, $10, $FFFF
                                        ; DATA XREF: Boss_AntroidUpdateRamAttackPose+4   o
word_383F8:     binclude "data/other/word_383F8.bin"
word_383F8_End:

; Main Terobuster boss handler with state dispatch
