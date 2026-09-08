Boss_ShellshogunRenderSprites:                          ; CODE XREF: Boss_ShellshogunUpdateSlamAnimation+A   p  ; was: sub_39E5E
                                        ; Boss_ShellshogunDirectionalAttackWindupState+2A   p
                moveq   #$16,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                bsr.w   Boss_ShellshogunPublishScreenPosition
                bsr.w   Boss_ShellshogunUpdateRotatingPart
                bsr.w   Boss_ShellshogunSelectBodyFrameMapping
                bra.w   Boss_ShellshogunUpdateOrbitingParts
; End of function Boss_ShellshogunRenderSprites
; Updates facing and the zero-facing linked-part flag arrangement
Boss_ShellshogunUpdateFacingPartFlags:                  ; CODE XREF: Boss_ShellshogunDecisionState+A   p  ; was: sub_39E76
                                        ; Boss_ShellshogunJumpAttackWindupState+6   p
                jsr     (Physics_GetPlayerDelta).l
                clr.w   $54(a5)
                tst.w   d1
                bpl.s   Boss_ShellshogunApplyFacingPartFlags
                move.w  #$100,$54(a5)
Boss_ShellshogunApplyFacingPartFlags:                   ; CODE XREF: Boss_ShellshogunUpdateFacingPartFlags+C   j  ; was: loc_39E8A
                tst.w   $54(a5)
                beq.s   Boss_ShellshogunSetZeroFacingPartFlags
; End of function Boss_ShellshogunUpdateFacingPartFlags
; Initializes the linked-part flag arrangement used during setup
Boss_ShellshogunInitializePartFlags:                    ; CODE XREF: Boss_ShellshogunSetupPhase+140   p  ; was: sub_39E90
                moveq   #3,d7
                bset    d7,$6E(a5)
                bset    d7,$CE(a5)
                bclr    d7,$4EE(a5)
                bset    d7,$36E(a5)
                bclr    d7,$78E(a5)
                rts
; End of function Boss_ShellshogunInitializePartFlags
; Installs the linked-part flag arrangement used when facing is zero
Boss_ShellshogunSetZeroFacingPartFlags:                 ; CODE XREF: Boss_ShellshogunUpdateFacingPartFlags+18   j  ; was: sub_39EA8
                moveq   #3,d7
                bclr    d7,$6E(a5)
                bclr    d7,$CE(a5)
                bset    d7,$4EE(a5)
                bclr    d7,$36E(a5)
                bset    d7,$78E(a5)
                rts
; End of function Boss_ShellshogunSetZeroFacingPartFlags
; Enables flag bit seven on eight linked-part records
Boss_ShellshogunEnableLinkedPartFlag7:                  ; CODE XREF: Boss_ShellshogunSetupPhase+66   p  ; was: sub_39EC0
                moveq   #7,d0
                bset    d0,$12E(a5)
                bset    d0,$18E(a5)
                bset    d0,$1EE(a5)
                bset    d0,$24E(a5)
                bset    d0,$54E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$60E(a5)
                bset    d0,$66E(a5)
                rts
; End of function Boss_ShellshogunEnableLinkedPartFlag7
; Update Shellshogun sprite flipping based on rotation angle
Boss_ShellshogunUpdateSpriteFlip:                       ; CODE XREF: Boss_ShellshogunDirectionalAttackMotionState+A0   j  ; was: sub_39EE4
                lea     (Boss_ShellshogunRotationFramesF).l,a0
                move.w  $29C(a5),d0
                subi.w  #$110,d0
                move.w  d0,d1
                asr.w   #3,d0
                andi.w  #$1C,d0
                move.l  (a0,d0.w),$248(a5)
                andi.w  #$E7FF,$E(a5)
                add.w   $54(a5),d1
                add.w   $56(a5),d1
                andi.w  #$1FE,d1
                cmpi.w  #$100,d1
                bmi.s   Boss_ShellshogunUpdateSpriteFlipReturn
                ori.w   #$1800,$E(a5)
Boss_ShellshogunUpdateSpriteFlipReturn:                 ; CODE XREF: Boss_ShellshogunUpdateSpriteFlip+32   j  ; was: locret_39F1E
                rts
; End of function Boss_ShellshogunUpdateSpriteFlip
; Selects the alternating Shellshogun body frame mapping
Boss_ShellshogunSelectBodyFrameMapping:                 ; CODE XREF: Boss_ShellshogunRenderSprites+10   p  ; was: sub_39F20
                move.l  #word_EB876,$68(a5)
                btst    #3,(word_FFA000+1).w
                bne.s   Boss_ShellshogunSelectBodyFrameMappingReturn
                move.l  #word_EB888,$68(a5)
Boss_ShellshogunSelectBodyFrameMappingReturn:           ; CODE XREF: Boss_ShellshogunSelectBodyFrameMapping+E   j  ; was: locret_39F38
                rts
; End of function Boss_ShellshogunSelectBodyFrameMapping
; Publishes and clamps the boss-relative shared screen position
Boss_ShellshogunPublishScreenPosition:                  ; CODE XREF: Boss_ShellshogunRenderSprites+8   p  ; was: sub_39F3A
                move.w  #$BC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_ShellshogunPublishScreenPosition
; Advances the phase and positions three orbiting auxiliary parts
Boss_ShellshogunUpdateOrbitingParts:                    ; CODE XREF: Boss_ShellshogunRenderSprites+14   j  ; was: sub_39F58
                move.w  $1DE(a5),d0
                move.w  $23C(a5),d1
                tst.w   $1DC(a5)
                bne.s   Boss_ShellshogunReverseOrbitPhase
                addq.w  #4,d0
                addq.w  #1,d1
                andi.w  #$1FC,d0
                cmpi.w  #$50,d0                         ; 'P'
                bne.s   Boss_ShellshogunStoreOrbitPhase
                addq.w  #1,$1DC(a5)
                bra.s   Boss_ShellshogunStoreOrbitPhase
; ---------------------------------------------------------------------------
Boss_ShellshogunReverseOrbitPhase:                      ; CODE XREF: Boss_ShellshogunUpdateOrbitingParts+C   j  ; was: loc_39F7A
                subq.w  #4,d0
                subq.w  #1,d1
                andi.w  #$1FC,d0
                cmpi.w  #$1B0,d0
                bne.s   Boss_ShellshogunStoreOrbitPhase
                clr.w   $1DC(a5)
Boss_ShellshogunStoreOrbitPhase:                        ; CODE XREF: Boss_ShellshogunUpdateOrbitingParts+1A   j  ; was: loc_39F8C
                                        ; Boss_ShellshogunUpdateOrbitingParts+20   j
                move.w  d0,$1DE(a5)
                move.w  d1,$23C(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                movea.l #Math_SineTable,a1
                movea.l #Boss_ShellshogunOrbitingPartSourcesAndRadii,a2
                move.w  $56(a5),d0
                addi.w  #$80,d0
                add.w   $23C(a5),d0
                move.w  $1DE(a5),d2
                move.w  #$1FE,d1
                moveq   #2,d7
Boss_ShellshogunUpdateNextOrbitingPart:                 ; CODE XREF: Boss_ShellshogunUpdateOrbitingParts+8C   j  ; was: loc_39FBA
                and.w   d1,d0
                movea.w (a2)+,a3
                move.w  -$80(a1,d0.w),d4
                move.w  (a1,d0.w),d5
                muls.w  (a2),d4
                muls.w  (a2)+,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $14(a3),d4
                add.l   $10(a3),d5
                move.l  d4,$14(a0)
                move.l  d5,$10(a0)
                add.w   d2,d0
                lea     $60(a0),a0
                dbf     d7,Boss_ShellshogunUpdateNextOrbitingPart
                rts
; End of function Boss_ShellshogunUpdateOrbitingParts
; ---------------------------------------------------------------------------
Boss_ShellshogunOrbitingPartSourcesAndRadii:    dc.w    $C620, $20, $CF20, 8, $CF80, 6  ; was: word_39FEA
                                        ; DATA XREF: Boss_ShellshogunUpdateOrbitingParts+46   o

; Selects the linked part and derives its wrapped rotation from the pose
Boss_ShellshogunUpdateLinkedPartRotation:               ; CODE XREF: Boss_ShellshogunSlamAttackInit:loc_39A8A   p  ; was: sub_39FF6
                                        ; sub_39E5A   p
                move.w  #$C860,$23E(a5)
                move.w  $296(a5),d0
                subi.w  #$80,d0
                move.w  d0,$29C(a5)
                andi.w  #$1FE,$29C(a5)
                rts
; End of function Boss_ShellshogunUpdateLinkedPartRotation
; Updates the rotating part's frame, flips, anchor, and optional trailing parts
Boss_ShellshogunUpdateRotatingPart:                     ; CODE XREF: Boss_ShellshogunRenderSprites+C   p  ; was: sub_3A010
                move.w  $29C(a5),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1FE,d0
                bclr    #4,$A2E(a5)
                cmpi.w  #$100,d0
                bpl.s   Boss_ShellshogunUpdateRotatingPartVerticalFlip
                bset    #4,$A2E(a5)
Boss_ShellshogunUpdateRotatingPartVerticalFlip:         ; CODE XREF: Boss_ShellshogunUpdateRotatingPart+1A   j  ; was: loc_3A032
                bset    #3,$A2E(a5)
                cmpi.w  #$180,d0
                bpl.s   Boss_ShellshogunApplyRotatingPartFacing
                cmpi.w  #$80,d0
                bmi.s   Boss_ShellshogunApplyRotatingPartFacing
                bclr    #3,$A2E(a5)
Boss_ShellshogunApplyRotatingPartFacing:                ; CODE XREF: Boss_ShellshogunUpdateRotatingPart+2C   j  ; was: loc_3A04A
                                        ; Boss_ShellshogunUpdateRotatingPart+32   j
                tst.w   $54(a5)
                beq.s   Boss_ShellshogunSelectRotatingPartFrame
                eori.w  #$800,$A2E(a5)
Boss_ShellshogunSelectRotatingPartFrame:                ; CODE XREF: Boss_ShellshogunUpdateRotatingPart+3E   j  ; was: loc_3A056
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  Boss_ShellshogunRotatingPartFrameTable(pc,d0.w),$A28(a5)
                movea.w $23E(a5),a0
                move.w  $10(a0),$A30(a5)
                move.w  $14(a0),$A34(a5)
                tst.b   $A41(a5)
                bne.s   Boss_ShellshogunPositionTrailingParts
                clr.b   $AA1(a5)
                clr.b   $B01(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ShellshogunPositionTrailingParts:                  ; CODE XREF: Boss_ShellshogunUpdateRotatingPart+66   j  ; was: loc_3A082
                move.b  #$C0,$AA1(a5)
                move.b  #$C0,$B01(a5)
                lea     (Math_SineTable).l,a1
                move.w  $29C(a5),d0
                addi.w  #$80,d0
                tst.w   $54(a5)
                bne.s   Boss_ShellshogunCalculateTrailingPartOffsets
                neg.w   d0
Boss_ShellshogunCalculateTrailingPartOffsets:           ; CODE XREF: Boss_ShellshogunUpdateRotatingPart+90   j  ; was: loc_3A0A4
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #7,d1
                asl.l   #7,d2
                move.l  $10(a0),d3
                move.l  $14(a0),d4
                sub.l   d1,d3
                sub.l   d2,d4
                move.l  d3,$A90(a5)
                move.l  d4,$A94(a5)
                sub.l   d1,d3
                sub.l   d2,d4
                move.l  d3,$AF0(a5)
                move.l  d4,$AF4(a5)
                rts
; End of function Boss_ShellshogunUpdateRotatingPart
; ---------------------------------------------------------------------------
Boss_ShellshogunRotatingPartFrameTable: dc.l    word_EB9BA  ; DATA XREF: Boss_ShellshogunUpdateRotatingPart+4C   r  ; was: off_3A0DA
                dc.l    word_EB9A2
                dc.l    word_EB98A
                dc.l    word_EB9A2

; Cycle palette fade values for Madam Barbar boss
Boss_MadamBarbarPaletteCycle:
                move.w  8(a5),d0                        ; was: sub_3A0EA
                tst.w   $A(a5)
                beq.s   loc_3A102
                addq.w  #1,d0
                cmpi.w  #$E,d0
                bne.s   loc_3A10E
                clr.w   $A(a5)
                bra.s   loc_3A10E
; ---------------------------------------------------------------------------
loc_3A102:                                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+8   j
                subq.w  #1,d0
                cmpi.w  #$FFF2,d0
                bne.s   loc_3A10E
                addq.w  #1,$A(a5)
loc_3A10E:                                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+10   j
                                        ; Boss_MadamBarbarPaletteCycle+16   j
                move.w  d0,8(a5)
                movea.w #(word_FFE318-M68K_RAM),a0
                moveq   #3,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_MadamBarbarPaletteCycle
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

; Main Madam Barbar boss handler checking defeat and state dispatch
