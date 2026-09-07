Boss_ShiperUpdateMain:                                  ; CODE XREF: Boss_ShiperAttackDecision:loc_3671E   p  ; was: sub_36A1A
                                        ; sub_367B6:loc_367CC   p
                bsr.w   Boss_ShiperScrollUpdate
                bsr.w   Boss_ShiperPositionUpdate
                bsr.w   Boss_ShiperStateDispatcher
                bra.w   Boss_ShiperPhysicsHandler
; End of function Boss_ShiperUpdateMain
; Boss state dispatcher using jump table for movement mode selection
Boss_ShiperStateDispatcher:                             ; CODE XREF: Boss_ShiperUpdateMain+8   p  ; was: sub_36A2A
                move.w  $5C(a5),d0
                movea.w off_36A3A(pc,d0.w),a0
                adda.l  #Boss_ShiperToggleDirection,a0
                jmp     (a0)
; End of function Boss_ShiperStateDispatcher
; ---------------------------------------------------------------------------
off_36A3A:      dc.w    Boss_ShiperToggleDirection-Boss_ShiperToggleDirection
                                        ; DATA XREF: Boss_ShiperStateDispatcher+4   r
                dc.w    Boss_ShiperMoveHorizontalA-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperMoveHorizontalB-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperToggleDirection-Boss_ShiperToggleDirection
                dc.w    Boss_ShiperMoveHorizontal_Return-Boss_ShiperToggleDirection

; Toggles boss horizontal movement direction flag when landing
Boss_ShiperToggleDirection:                             ; DATA XREF: Boss_ShiperStateDispatcher+8   o  ; was: sub_36A44
                                        ; ROM:off_36A3A   o
                btst    #0,$5E(a5)
                beq.s   loc_36A52
                eori.b  #2,$5E(a5)
loc_36A52:                                              ; CODE XREF: Boss_ShiperToggleDirection+6   j
                btst    #1,$5E(a5)
                bne.s   Boss_ShiperMoveHorizontalB
; End of function Boss_ShiperToggleDirection
; Boss horizontal movement handler applying velocity when grounded
Boss_ShiperMoveHorizontalA:                             ; DATA XREF: ROM:00036A3C   o  ; was: sub_36A5A
                btst    #0,$5E(a5)
                beq.s   loc_36A6A
                move.l  #$10000,$4C(a5)
loc_36A6A:                                              ; CODE XREF: Boss_ShiperMoveHorizontalA+6   j
                tst.w   $54(a5)
                bmi.s   loc_36A7A
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_36A7A:                                              ; CODE XREF: Boss_ShiperMoveHorizontalA+14   j
                subi.l  #$D000,$4C(a5)
                rts
; End of function Boss_ShiperMoveHorizontalA
; Boss horizontal movement in opposite direction when airborne
Boss_ShiperMoveHorizontalB:                             ; CODE XREF: Boss_ShiperToggleDirection+14   j  ; was: sub_36A84
                                        ; DATA XREF: ROM:00036A3E   o
                btst    #0,$5E(a5)
                beq.s   loc_36A94
                move.l  #$FFFF0000,$4C(a5)
loc_36A94:                                              ; CODE XREF: Boss_ShiperMoveHorizontalB+6   j
                tst.w   $54(a5)
                bpl.s   loc_36AA4
                addi.l  #$D000,$4C(a5)
                rts
; ---------------------------------------------------------------------------
loc_36AA4:                                              ; CODE XREF: Boss_ShiperMoveHorizontalB+14   j
                subi.l  #$D000,$4C(a5)
; Return from Shiper horizontal movement
Boss_ShiperMoveHorizontal_Return:                       ; DATA XREF: ROM:00036A42   o  ; was: locret_36AAC
                rts
; End of function Boss_ShiperMoveHorizontalB
; Boss physics handler managing velocity accumulation and state transitions
Boss_ShiperPhysicsHandler:                              ; CODE XREF: Boss_ShiperUpdateMain+C   j  ; was: sub_36AAE
                move.l  $178(a5),d0
                add.l   d0,$16C(a5)
                tst.w   $16C(a5)
                bpl.s   loc_36AC0
                clr.l   $16C(a5)
loc_36AC0:                                              ; CODE XREF: Boss_ShiperPhysicsHandler+C   j
                move.w  $174(a5),d0
                movea.w off_36AD0(pc,d0.w),a0
                adda.l  #Boss_ShiperRotationInit,a0
                jmp     (a0)
; End of function Boss_ShiperPhysicsHandler
; ---------------------------------------------------------------------------
off_36AD0:      dc.w    Boss_ShiperRotationInit-Boss_ShiperRotationInit
                                        ; DATA XREF: Boss_ShiperPhysicsHandler+16   r
                dc.w    Boss_ShiperRotation_State0-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationAccel-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotation_State1-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationLogic-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotationAccelAlt-Boss_ShiperRotationInit
                dc.w    Boss_ShiperRotation_State2-Boss_ShiperRotationInit
                dc.w    Boss_ShiperSpinAttack-Boss_ShiperRotationInit
                dc.w    Boss_ShiperSpinAttack_Spin-Boss_ShiperRotationInit

; Initializes boss rotation state and manages continuous angle updates
Boss_ShiperRotationInit:                                ; CODE XREF: Boss_ShiperSpinAttack+60   j  ; was: sub_36AE2
                                        ; DATA XREF: Boss_ShiperPhysicsHandler+1A   o
                addq.w  #2,$174(a5)
                clr.l   $178(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Initial rotation state with acceleration
Boss_ShiperRotation_State0:                             ; DATA XREF: ROM:00036AD2   o  ; was: loc_36AF2
                addi.l  #$3800,$178(a5)
                cmpi.w  #$C,$16C(a5)
                bmi.s   loc_36B0A
                move.l  #$FFFE4000,$178(a5)
loc_36B0A:                                              ; CODE XREF: Boss_ShiperRotationInit+1E   j
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (dword_FFFF08).w,d4
                andi.w  #$1F,d4
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #4,d0
loc_36B24:                                              ; CODE XREF: Boss_ShiperRotationAccelAlt+3E   j
                move.w  $170(a5),d1
                move.w  #$3FF,d2
                tst.w   $17C(a5)
                bne.s   loc_36B50
                add.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bpl.s   loc_36B68
                cmpi.w  #$20,d1                         ; ' '
                bmi.s   loc_36B68
                move.w  d3,d3
                bpl.s   loc_36B68
                addq.w  #1,$17C(a5)
                move.w  d4,$17E(a5)
                bra.s   loc_36B68
; ---------------------------------------------------------------------------
loc_36B50:                                              ; CODE XREF: Boss_ShiperRotationInit+4E   j
                sub.w   d0,d1
                and.w   d2,d1
                cmpi.w  #$1FF,d1
                bmi.s   loc_36B68
                cmpi.w  #$3FF,d1
                bpl.s   loc_36B68
                clr.w   $17C(a5)
                move.w  d4,$17E(a5)
loc_36B68:                                              ; CODE XREF: Boss_ShiperRotationInit+58   j
                                        ; Boss_ShiperRotationInit+5E   j
                move.w  d1,$170(a5)
                rts
; End of function Boss_ShiperRotationInit
; Boss rotation/angle acceleration with velocity increase and upper limit
Boss_ShiperRotationAccel:                               ; DATA XREF: ROM:00036AD4   o  ; was: sub_36B6E
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Rotation state 1 with velocity limit check
Boss_ShiperRotation_State1:                             ; DATA XREF: ROM:00036AD6   o  ; was: loc_36B7A
                addi.l  #$4000,$178(a5)
                moveq   #8,d0
                move.w  $170(a5),d1
                beq.s   loc_36B9C
                cmpi.w  #$1FF,d1
                bpl.s   loc_36B92
                moveq   #$FFFFFFF8,d0
loc_36B92:                                              ; CODE XREF: Boss_ShiperRotationAccel+20   j
                add.w   d0,d1
                andi.w  #$3F8,d1
                move.w  d1,$170(a5)
loc_36B9C:                                              ; CODE XREF: Boss_ShiperRotationAccel+1A   j
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   locret_36BAE
                move.w  #$40,$16C(a5)                   ; '@'
                addq.w  #2,$174(a5)
locret_36BAE:                                           ; CODE XREF: Boss_ShiperRotationAccel+34   j
                rts
; End of function Boss_ShiperRotationAccel
; Complex boss rotation logic with timer-based direction changes and limits
Boss_ShiperRotationLogic:                               ; DATA XREF: ROM:00036AD8   o  ; was: sub_36BB0
                moveq   #4,d3
                move.w  $17E(a5),d2
                subq.w  #1,d2
                move.w  $170(a5),d1
                move.l  $178(a5),d0
                bpl.s   loc_36BCC
                cmpi.w  #$7A,d2                         ; 'z'
                bpl.s   loc_36BD6
                add.w   d3,d1
                bra.s   loc_36BD6
; ---------------------------------------------------------------------------
loc_36BCC:                                              ; CODE XREF: Boss_ShiperRotationLogic+10   j
                sub.w   d3,d1
                cmpi.w  #$52,d2                         ; 'R'
                bpl.s   loc_36BD6
                add.w   d3,d1
loc_36BD6:                                              ; CODE XREF: Boss_ShiperRotationLogic+16   j
                                        ; Boss_ShiperRotationLogic+1A   j
                addi.l  #$3800,d0
                cmpi.w  #$40,$16C(a5)                   ; '@'
                bmi.s   loc_36BFC
                move.w  #$40,$16C(a5)                   ; '@'
                move.l  #$FFFA8000,d0
                moveq   #0,d1
                move.w  #$80,d2
                eori.w  #1,$17C(a5)
loc_36BFC:                                              ; CODE XREF: Boss_ShiperRotationLogic+32   j
                move.l  d0,$178(a5)
                move.w  d1,$170(a5)
                move.w  d2,$17E(a5)
                rts
; End of function Boss_ShiperRotationLogic
; Alternative rotation acceleration mode with higher velocity limits
Boss_ShiperRotationAccelAlt:                            ; DATA XREF: ROM:00036ADA   o  ; was: sub_36C0A
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
                clr.w   $17E(a5)
; Faster rotation acceleration state
Boss_ShiperRotation_State2:                             ; DATA XREF: ROM:00036ADC   o  ; was: loc_36C16
                addi.l  #$6000,$178(a5)
                cmpi.w  #$10,$16C(a5)
                bmi.s   loc_36C2E
                move.l  #$FFFCC000,$178(a5)
loc_36C2E:                                              ; CODE XREF: Boss_ShiperRotationAccelAlt+1A   j
                subq.w  #1,$17E(a5)
                move.w  $17E(a5),d3
                move.b  (dword_FFFF08).w,d4
                andi.w  #7,d4
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                bra.w   loc_36B24
; End of function Boss_ShiperRotationAccelAlt
; Boss spin attack with rotation acceleration screen shake and damage
Boss_ShiperSpinAttack:                                  ; DATA XREF: ROM:00036ADE   o  ; was: sub_36C4C
                addq.w  #2,$174(a5)
                clr.w   $17C(a5)
; Spin attack execution with deceleration
Boss_ShiperSpinAttack_Spin:                             ; DATA XREF: ROM:00036AE0   o  ; was: loc_36C54
                subi.l  #$3000,$178(a5)
                tst.w   $17C(a5)
                bne.s   loc_36C7A
                addq.w  #4,$170(a5)
                andi.w  #$3FC,$170(a5)
                cmpi.w  #$110,$170(a5)
                bne.s   locret_36C78
                addq.w  #1,$17C(a5)
locret_36C78:                                           ; CODE XREF: Boss_ShiperSpinAttack+26   j
                                        ; Boss_ShiperSpinAttack+40   j
                rts
; ---------------------------------------------------------------------------
loc_36C7A:                                              ; CODE XREF: Boss_ShiperSpinAttack+14   j
                subi.w  #$10,$170(a5)
                andi.w  #$3F0,$170(a5)
                cmpi.w  #$3A0,$170(a5)
                bne.s   locret_36C78
                move.w  #8,(word_FFA010).w
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_ShiperSpawnCircleShot
                subi.w  #$12C,(word_FF8234).w
                clr.w   $174(a5)
                bra.w   Boss_ShiperRotationInit
; End of function Boss_ShiperSpinAttack
; Updates boss position handling collision detection and sprite positioning
Boss_ShiperPositionUpdate:                              ; CODE XREF: Boss_ShiperUpdateMain+4   p  ; was: sub_36CB0
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                movea.w #(word_FFC680-M68K_RAM),a1
                move.w  $10(a1),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$10(a0)
                move.w  $14(a1),d0
                addi.w  #-$28,d0
                move.w  d0,$14(a0)
                move.l  #$1400,d2
                move.l  #$FFFE8000,d3
                move.l  #$FFFE0000,d4
                cmpi.w  #6,$5C(a5)
                bne.s   loc_36CFC
                move.l  #$C000,d2
                move.l  #$FFFB8000,d3
                move.l  #$FFFE4000,d4
loc_36CFC:                                              ; CODE XREF: Boss_ShiperPositionUpdate+38   j
                bclr    #0,$5E(a5)
                move.l  $54(a5),d0
                add.l   d2,d0
                move.l  $50(a5),d1
                bmi.s   loc_36D2E
                move.l  d3,d0
                moveq   #0,d1
                move.l  d4,$7C(a5)
                bset    #0,$5E(a5)
                movem.l d0,-(sp)
                move.b  #$B9,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
loc_36D2E:                                              ; CODE XREF: Boss_ShiperPositionUpdate+5C   j
                add.l   d0,d1
                move.l  d0,$54(a5)
                move.l  d1,$50(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-5,d0
                addi.w  #-$33,d1
                move.b  (dword_FFFF08).w,d2
                andi.w  #3,d2
                add.w   d2,d0
                btst    #4,(word_FFA000+1).w
                bne.s   loc_36D5C
                addq.w  #1,d1
loc_36D5C:                                              ; CODE XREF: Boss_ShiperPositionUpdate+A8   j
                move.w  d0,$D0(a5)
                move.w  d1,$D4(a5)
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addi.w  #-$D,d0
                addi.w  #-$27,d1
                move.w  d1,d7
                btst    #2,(word_FFA000+1).w
                bne.s   loc_36D80
                addq.w  #1,d1
loc_36D80:                                              ; CODE XREF: Boss_ShiperPositionUpdate+CC   j
                move.w  d0,$190(a5)
                btst    #3,(word_FFA000+1).w
                beq.s   loc_36D8E
                addq.w  #2,d0
loc_36D8E:                                              ; CODE XREF: Boss_ShiperPositionUpdate+DA   j
                move.w  d0,$130(a5)
                move.w  d1,$194(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  $16A(a5),d1
                tst.w   $168(a5)
                bne.s   loc_36DB4
                sub.w   d0,d1
                bpl.s   loc_36DC4
                clr.w   d1
                addq.w  #1,$168(a5)
                bra.s   loc_36DC4
; ---------------------------------------------------------------------------
loc_36DB4:                                              ; CODE XREF: Boss_ShiperPositionUpdate+F6   j
                add.w   d0,d1
                cmpi.w  #4,d1
                bmi.s   loc_36DC4
                move.w  #4,d1
                clr.w   $168(a5)
loc_36DC4:                                              ; CODE XREF: Boss_ShiperPositionUpdate+FA   j
                                        ; Boss_ShiperPositionUpdate+102   j
                move.w  d1,$16A(a5)
                add.w   d7,d1
                addq.w  #4,d1
                move.w  d1,$134(a5)
; End of function Boss_ShiperPositionUpdate
; Calculates and positions boss tentacle appendages using trigonometric sine/cosine tables
Boss_ShiperTentaclePosition:                            ; CODE XREF: Boss_ShiperSetupState+13C   p  ; was: sub_36DD0
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #1,d0
                move.w  #$1FE,d1
                move.w  $228(a5),d2
                btst    #0,$22C(a5)
                bne.s   loc_36DFC
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   loc_36E06
loc_36DF4:                                              ; CODE XREF: Boss_ShiperTentaclePosition+34   j
                eori.b  #1,$22C(a5)
                bra.s   loc_36E06
; ---------------------------------------------------------------------------
loc_36DFC:                                              ; CODE XREF: Boss_ShiperTentaclePosition+18   j
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$60,d2                         ; '`'
                bmi.s   loc_36DF4
loc_36E06:                                              ; CODE XREF: Boss_ShiperTentaclePosition+22   j
                                        ; Boss_ShiperTentaclePosition+2A   j
                move.w  d2,$228(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #3,d0
                move.w  $22A(a5),d2
                btst    #1,$22C(a5)
                bne.s   loc_36E32
                add.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$1A8,d2
                bmi.s   loc_36E3C
loc_36E2A:                                              ; CODE XREF: Boss_ShiperTentaclePosition+6A   j
                eori.b  #2,$22C(a5)
                bra.s   loc_36E3C
; ---------------------------------------------------------------------------
loc_36E32:                                              ; CODE XREF: Boss_ShiperTentaclePosition+4E   j
                sub.w   d0,d2
                and.w   d1,d2
                cmpi.w  #$E0,d2
                bmi.s   loc_36E2A
loc_36E3C:                                              ; CODE XREF: Boss_ShiperTentaclePosition+58   j
                                        ; Boss_ShiperTentaclePosition+60   j
                move.w  d2,$22A(a5)
                movea.l #word_1B514,a0
                movea.l #off_36FCE,a1
                move.w  #$D300,$1EE(a5)
                move.w  #$D300,$2AE(a5)
                moveq   #0,d0
                moveq   #0,d1
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                addq.w  #5,d0
                addi.w  #-$20,d1
                swap    d0
                swap    d1
                move.w  $228(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   loc_36E92
                move.w  #$CB00,$1EE(a5)
loc_36E92:                                              ; CODE XREF: Boss_ShiperTentaclePosition+BA   j
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$1E8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d5
                move.l  d4,d6
                asl.l   #1,d5
                asl.l   #1,d6
                add.l   d1,d3
                add.l   d0,d4
                add.l   d1,d5
                add.l   d0,d6
                move.l  d3,$1F4(a5)
                move.l  d4,$1F0(a5)
                move.l  d5,$254(a5)
                move.l  d6,$250(a5)
                move.w  $22A(a5),d2
                andi.w  #$1FE,d2
                move.w  -$80(a0,d2.w),d3
                move.w  (a0,d2.w),d4
                addi.w  #$10,d2
                andi.w  #$1E0,d2
                cmpi.w  #$100,d2
                bmi.s   loc_36EEA
                move.w  #$CB00,$2AE(a5)
loc_36EEA:                                              ; CODE XREF: Boss_ShiperTentaclePosition+112   j
                andi.w  #$E0,d2
                asr.w   #3,d2
                move.l  (a1,d2.w),$2A8(a5)
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #5,d4
                move.l  d3,d0
                move.l  d4,d1
                asl.l   #1,d0
                asl.l   #1,d1
                add.l   d5,d3
                add.l   d6,d4
                add.l   d5,d0
                add.l   d6,d1
                move.l  d3,$2B4(a5)
                move.l  d4,$2B0(a5)
                move.l  d0,$314(a5)
                move.l  d1,$310(a5)
                movea.w #(dword_FF9A00-M68K_RAM),a0
                move.w  $170(a5),d0
                moveq   #4,d7
loc_36F28:                                              ; CODE XREF: Boss_ShiperTentaclePosition+15E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_36F28
                movea.w #(word_FFC980-M68K_RAM),a0
                move.l  $70(a5),d0
                move.l  $74(a5),d1
                swap    d0
                swap    d1
                addi.w  #-$2C,d0
                addi.w  #-$14,d1
                swap    d0
                swap    d1
                add.l   $16C(a5),d0
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(word_FFC9E0-M68K_RAM),a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                movea.w #(word_FF9500-M68K_RAM),a3
                movea.w #(dword_FF9A00-M68K_RAM),a4
                move.w  #$200,d3
                moveq   #$B,d0
                moveq   #1,d5
                move.w  #$3FC,d6
                moveq   #4,d7
loc_36F78:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1F8   j
                move.w  (a4),d4
                muls.w  d5,d4
                add.w   d3,d4
                and.w   d6,d4
                move.l  (a2,d4.w),d1
                move.l  (a3,d4.w),d2
                add.l   $14(a0),d1
                add.l   $10(a0),d2
                move.l  d1,$14(a1)
                move.l  d2,$10(a1)
                cmpi.w  #$144,$14(a1)
                bmi.s   loc_36FA6
                move.w  #$144,$14(a1)
loc_36FA6:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1CE   j
                bset    #7,$E(a1)
                cmp.w   $16C(a5),d0
                bpl.s   loc_36FB8
                bclr    #7,$E(a1)
loc_36FB8:                                              ; CODE XREF: Boss_ShiperTentaclePosition+1E0   j
                movea.w a1,a0
                lea     $60(a1),a1
                lea     2(a4),a4
                addi.w  #$10,d0
                addq.w  #1,d5
                dbf     d7,loc_36F78
                rts
; End of function Boss_ShiperTentaclePosition
; ---------------------------------------------------------------------------
off_36FCE:      dc.l    word_EBA02                      ; DATA XREF: Boss_ShiperTentaclePosition+76   o
                dc.l    word_EB9FC
                dc.l    word_EB9F6
                dc.l    word_EB9F0
                dc.l    word_EB9EA
                dc.l    word_EBA14
                dc.l    word_EBA0E
                dc.l    word_EBA08

; Spawns random debris particle sprites during boss destruction
