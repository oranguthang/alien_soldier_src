Boss_BackStringerUpdateRender:                          ; CODE XREF: Boss_Epsilon1PlayerControl+4C   j  ; was: sub_44F50
                                        ; Boss_BackStringerAttackStateMachine+30   j
                bsr.w   Boss_BackStringerUpdatePalette
                bsr.w   Boss_BackStringerUpdateArms
                moveq   #$14,d7
                jmp     Boss_BackStringerUpdateMetasprite
; End of function Boss_BackStringerUpdateRender
; Updates palette cycling
Boss_BackStringerUpdatePalette:                         ; CODE XREF: Boss_BackStringerUpdateRender   p  ; was: sub_44F60
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #$E,d0
                movea.w #(byte_FFE374-M68K_RAM),a0
                move.w  word_44F8E(pc,d0.w),$80(a0)
                move.w  word_44F8E(pc,d0.w),(a0)+
                move.w  word_44F9E(pc,d0.w),$80(a0)
                move.w  word_44F9E(pc,d0.w),(a0)+
                move.w  word_44FAE(pc,d0.w),$80(a0)
                move.w  word_44FAE(pc,d0.w),(a0)+
                rts
; End of function Boss_BackStringerUpdatePalette
; ---------------------------------------------------------------------------
word_44F8E:     dc.w    $AEA, $4C, $2A, 8, 6, 8, $2A, $4C
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+E   r
                                        ; Boss_BackStringerUpdatePalette+14   r
word_44F9E:     dc.w    $8C8, $A, 8, 6, 4, 6, 8, $A
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+18   r
                                        ; Boss_BackStringerUpdatePalette+1E   r
word_44FAE:     dc.w    $6A6, 4, 2, 0, 0, 0, 2, 4
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+22   r
                                        ; Boss_BackStringerUpdatePalette+28   r

; Updates arm sprite orientation
Boss_BackStringerUpdateArms:                            ; CODE XREF: Boss_BackStringerUpdateRender+4   p  ; was: sub_44FBE
                movea.w a5,a0
                lea     $60(a0),a0
                move.w  #$8300,$E(a0)
                moveq   #0,d1
                bsr.s   Boss_BackStringerCalcSpriteAngle
                lea     $60(a0),a0
                move.w  #$9B00,$E(a0)
                moveq   #$10,d1
; End of function Boss_BackStringerUpdateArms
; Calculates sprite angle and graphics
Boss_BackStringerCalcSpriteAngle:                       ; CODE XREF: Boss_BackStringerUpdateArms+E   p  ; was: sub_44FDA
                move.w  $56(a0),d0
                add.w   $56(a5),d0
loc_44FE2:                                              ; CODE XREF: Projectile_BackStringerChainFalling+36   j
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_44FF6
                eori.w  #$1800,$E(a0)
loc_44FF6:                                              ; CODE XREF: Boss_BackStringerCalcSpriteAngle+14   j
                tst.w   $54(a5)
                bne.s   loc_45002
                eori.w  #$800,$E(a0)
loc_45002:                                              ; CODE XREF: Boss_BackStringerCalcSpriteAngle+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                add.w   d1,d0
                move.l  off_45012(pc,d0.w),8(a0)
                rts
; End of function Boss_BackStringerCalcSpriteAngle
; ---------------------------------------------------------------------------
off_45012:      dc.l    word_EC346                      ; DATA XREF: Boss_BackStringerCalcSpriteAngle+30   r
                dc.l    word_EC352
                dc.l    word_EC36A
                dc.l    word_EC376
                dc.l    word_EC2E6
                dc.l    word_EC2FE
                dc.l    word_EC316
                dc.l    word_EC32E

; Updates BackStringer palette with custom colors
Gfx_BackStringerUpdatePalette:                          ; CODE XREF: Boss_BackStringerAttackStateMachine:loc_44B54   p  ; was: sub_45032
                movea.w #(byte_FFE322-M68K_RAM),a0
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                moveq   #$B,d7
loc_4503C:                                              ; CODE XREF: Gfx_BackStringerUpdatePalette+C   j
                move.w  (a1)+,(a0)+
                dbf     d7,loc_4503C
                movea.w #(byte_FFE322-M68K_RAM),a0
                move.w  $4DC(a5),d0
                andi.w  #$FFFE,d0
                cmpi.w  #2,d0
                bmi.s   loc_4505A
                move.w  #$ECC,(a0,d0.w)
loc_4505A:                                              ; CODE XREF: Gfx_BackStringerUpdatePalette+20   j
                cmpi.w  #$16,d0
                bpl.s   locret_4506C
                cmpi.w  #$C,d0
                bmi.s   locret_4506C
                move.w  #$A40,2(a0,d0.w)
locret_4506C:                                           ; CODE XREF: Gfx_BackStringerUpdatePalette+2C   j
                                        ; Gfx_BackStringerUpdatePalette+32   j
                rts
; End of function Gfx_BackStringerUpdatePalette
; Initializes projectile slots
Boss_BackStringerInitProjectileSlots:                   ; CODE XREF: Boss_BackStringerSpawn+64   p  ; was: sub_4506E
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_45074:                                              ; CODE XREF: Boss_BackStringerInitProjectileSlots+18   j
                move.w  #$10,(a0)
                clr.w   2(a0)
                move.w  #$C3E7,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_45074
                move.w  #$10,(a0)
                clr.w   2(a0)
                move.w  #$C3EB,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                clr.b   $21(a0)
                move.l  #$818FA06,$2C(a0)
                rts
; End of function Boss_BackStringerInitProjectileSlots
; Initializes six body segment positions
Boss_BackStringerResetBodySegments:                     ; CODE XREF: Boss_Epsilon1Initialize+1E   j  ; was: sub_450B2
                                        ; Boss_BackStringerAttackStateMachine+3EE   p
                clr.l   $2FC(a5)
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_450BC:                                              ; CODE XREF: Boss_BackStringerResetBodySegments+36   j
                move.w  #$10,(a0)
                move.w  #$8080,2(a0)
                move.w  #$300,8(a0)
                move.w  #$FCF0,$A(a0)
                move.b  #$14,$20(a0)
                move.w  $D0(a5),$10(a0)
                move.w  $D4(a5),$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_450BC
                tst.w   $29E(a5)
                bmi.s   locret_4510C
                move.w  $D0(a5),$10(a0)
                move.w  $D4(a5),$14(a0)
                clr.w   $29E(a5)
                move.b  #2,$21(a0)
                clr.b   $22(a0)
locret_4510C:                                           ; CODE XREF: Boss_BackStringerResetBodySegments+3E   j
                rts
; End of function Boss_BackStringerResetBodySegments
; Updates body segment vertical positions
Boss_BackStringerUpdateSegmentPositions:                ; CODE XREF: Boss_Epsilon1PlayerControl:loc_44832   p  ; was: sub_4510E
                                        ; sub_44C3C:loc_44C5A   p
                move.l  $2FC(a5),d0
                move.l  d0,d1
                add.l   $D4(a5),d1
                moveq   #3,d3
                btst    #0,(word_FFA000+1).w
                bne.s   loc_45124
                moveq   #0,d3
loc_45124:                                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+12   j
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_4512A:                                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+30   j
                andi.w  #$F7FF,$E(a0)
                bset    d3,$E(a0)
                move.l  d1,$14(a0)
                add.l   d0,d1
                lea     $60(a0),a0
                dbf     d7,loc_4512A
                move.w  -$4C(a0),d1
                subi.w  #$10,d1
                move.w  d1,$14(a0)
                tst.w   $29E(a5)
                bmi.s   locret_451A8
                bne.s   loc_45176
                bclr    #1,$22(a0)
                beq.s   locret_451A8
                move.w  #$8080,2(a0)
                bset    #1,(byte_FF825C).w
                move.w  #2,$29E(a5)
                bset    #4,(word_FFA40E).w
loc_45176:                                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+46   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_45184
                clr.w   $29E(a5)
                bra.s   locret_451A8
; ---------------------------------------------------------------------------
loc_45184:                                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+6E   j
                bset    #7,(word_FFA40E).w
                move.w  #$C8,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $10(a0),(word_FF8250).w
                move.w  $14(a0),(word_FF8252).w
locret_451A8:                                           ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+44   j
                                        ; Boss_BackStringerUpdateSegmentPositions+4E   j
                rts
; End of function Boss_BackStringerUpdateSegmentPositions
; Retracts body segments by setting decay timers
Boss_BackStringerRetractSegments:                       ; CODE XREF: Boss_Epsilon1PlayerControl+14   p  ; was: sub_451AA
                                        ; Boss_BackStringerDiveAttack+7A   p
                move.w  #$324,d0
                moveq   #$FFFFFFFF,d1
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_451B6:                                              ; CODE XREF: Boss_BackStringerRetractSegments+24   j
                move.w  d0,(a0)
                move.w  #$8480,2(a0)
                move.w  #6,$48(a0)
                move.w  d1,$1C(a0)
                subq.w  #1,d1
                lea     $60(a0),a0
                dbf     d7,loc_451B6
                clr.w   $29E(a5)
                clr.w   2(a0)
                clr.b   $21(a0)
                bclr    #4,(word_FFA40E).w
                rts
; End of function Boss_BackStringerRetractSegments
; Flashing effect for destroyed BackStringer segment
Effect_BackStringerSegmentFlash:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_451E6
                subq.w  #1,$48(a5)
                bpl.s   loc_451F6
                move.w  #$10,(a5)
                clr.w   2(a5)
                rts
; ---------------------------------------------------------------------------
loc_451F6:                                              ; CODE XREF: Effect_BackStringerSegmentFlash+4   j
                bset    #3,$E(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4520A
                bclr    #3,$E(a5)
loc_4520A:                                              ; CODE XREF: Effect_BackStringerSegmentFlash+1C   j
                move.w  $48(a5),d0
                andi.w  #6,d0
                move.w  word_45220(pc,d0.w),8(a5)
                move.w  word_45226(pc,d0.w),$A(a5)
                rts
; End of function Effect_BackStringerSegmentFlash
; ---------------------------------------------------------------------------
word_45220:     dc.w    0, $100, $200                   ; DATA XREF: Effect_BackStringerSegmentFlash+2C   r
word_45226:     dc.w    $FCFC, $FCF8, $FCF4
                                        ; DATA XREF: Effect_BackStringerSegmentFlash+32   r

; Applies circular motion
Boss_BackStringerApplyCircularMotion:                   ; CODE XREF: Boss_BackStringerAttackStateMachine+2C   p  ; was: sub_4522C
                                        ; Boss_BackStringerAttackStateMachine+DA   p
                tst.w   $23E(a5)
                beq.s   loc_45238
                move.w  #$3C,$3BC(a5)                   ; '<'
loc_45238:                                              ; CODE XREF: Boss_BackStringerApplyCircularMotion+4   j
                subi.w  #4,$3BC(a5)
                move.w  $56(a5),d0
                subi.w  #$80,d0
                andi.w  #$1FE,d0
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                move.w  $3BC(a5),d0
                asr.w   #2,d0
                muls.w  d0,d1
                muls.w  d0,d2
                add.l   d1,$14(a5)
                add.l   d2,$10(a5)
                rts
; End of function Boss_BackStringerApplyCircularMotion
; Animates boss pose from script
Boss_BackStringerAnimatePose:                           ; CODE XREF: Boss_Epsilon1PlayerControl+42   p  ; was: sub_4526C
                                        ; Boss_BackStringerAttackStateMachine+28   p
                clr.w   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_452EE
loc_45276:                                              ; CODE XREF: Boss_BackStringerAnimatePose+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_452FE
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_45298
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_45298:                                              ; CODE XREF: Boss_BackStringerAnimatePose+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_452A8
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_452A8:                                              ; CODE XREF: Boss_BackStringerAnimatePose+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_452B8
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_45276
; ---------------------------------------------------------------------------
loc_452B8:                                              ; CODE XREF: Boss_BackStringerAnimatePose+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_454F2,d0
                movea.l d0,a0
                bsr.w   Anim_BackStringerCalcInterpolation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                addq.w  #1,$23E(a5)
                tst.w   $C(a5)
                bmi.s   loc_452FE
loc_452EE:                                              ; CODE XREF: Boss_BackStringerAnimatePose+8   j
                subq.w  #1,$C(a5)
                movea.w #(word_FF9600-M68K_RAM),a0
                moveq   #$13,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_452FE:                                              ; CODE XREF: Boss_BackStringerAnimatePose+E   j
                                        ; Boss_BackStringerAnimatePose+80   j
                move.w  #$1FE,d7
                movea.w #(word_FF9600-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                movea.w #(word_FF9608-M68K_RAM),a0
                move.b  (a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$176(a5)
                move.b  4(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$1D6(a5)
                move.b  8(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$236(a5)
                move.b  $C(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$296(a5)
                move.b  $10(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$2F6(a5)
                move.b  $14(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$356(a5)
                move.b  $18(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$3B6(a5)
                move.b  $1C(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$416(a5)
                move.b  $20(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$476(a5)
                move.b  $24(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$4D6(a5)
                move.b  $28(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$536(a5)
                move.b  $2C(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$596(a5)
                move.b  $30(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$5F6(a5)
                move.b  $34(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$656(a5)
                move.b  $38(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$6B6(a5)
                move.b  $3C(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$716(a5)
                move.b  $40(a0),d3
                asl.w   #1,d3
                add.w   d2,d3
                and.w   d7,d3
                move.w  d3,$776(a5)
                move.b  $44(a0),d2
                asl.w   #1,d2
                add.w   d3,d2
                and.w   d7,d2
                move.w  d2,$7D6(a5)
                rts
; End of function Boss_BackStringerAnimatePose
; Calculates animation interpolation
Anim_BackStringerCalcInterpolation:                     ; CODE XREF: Boss_BackStringerAnimatePose+62   p  ; was: sub_45410
                movea.l #word_35200,a1
                movea.w #(word_FF9600-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$13,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Anim_BackStringerCalcInterpolation
; Loads animation frame delay data
Anim_BackStringerLoadFrameDelays:
                movea.w #(word_FF9600-M68K_RAM),a1      ; was: sub_45426
                moveq   #$13,d7
                jmp     Anim_LoadFrameDelays
; End of function Anim_BackStringerLoadFrameDelays
; ---------------------------------------------------------------------------
word_45432:     dc.w    $2020, 0, $2020, $14, $FFFF
                                        ; DATA XREF: Boss_Epsilon1PlayerControl+3C   o
word_4543C:     dc.w    $2828, $28, $607, 0, $2828, $14, $607, 0, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_449FE   o
word_4544E:     dc.w    $708, $3C, $708, $50, $708, $64, $708, $78, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_4486C   o
                                        ; Boss_BackStringerTrackingAttack+40   o
word_45460:     dc.w    $305, $8C, $305, $A0, $305, $B4, $305, $C8, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_4491A   o
                                        ; Boss_BackStringerCheckRotationStart+1A   o
word_45472:     dc.w    $305, $DC, $305, $F0, $305, $104, $305, $118, $FFFF
                                        ; DATA XREF: Boss_BackStringerCheckRotationStart+24   o
                                        ; Boss_BackStringerTrackingAttack+122   o
word_45484:     dc.w    $306, $12C, $606, $12C, $418, $64, $306, $140, $606, $140, $418, $3C, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine+74   o
word_4549E:     dc.w    $808, 0, $418, $154, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine+A2   o
                                        ; sub_4484A:loc_449F0   o
word_454A8:     dc.w    $404, 0, $20C, $154, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44C0C   o
word_454B2:     dc.w    $408, $190, $408, $190, $C0E, $154, $3030, 0, $FFFE
                                        ; DATA XREF: Boss_BackStringerDiveAttack+22   o
word_454C4:     dc.w    $80C, $154, $C0C, $154, $80C, 0, $C0C, 0, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44B22   o
word_454D6:     dc.w    $1010, $154, $E10, $17C, $707, $17C, $80D9, $C0E, $190, $404, $190, $1010, $154, $FFFE
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44BB6   o
word_454F2:     binclude "data/other/word_454F2.bin"
word_454F2_End:

; Rope/chain segment handler
