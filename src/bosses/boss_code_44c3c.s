Boss_BackStringerDiveAttack:                              ; DATA XREF: ROM:00044730   o  ; was: sub_44C3C
                bsr.w Projectile_BackStringerSpawnDrops
                subi.l  #$16000,$2FC(a5)
                cmpi.w  #$FFE0,$2FC(a5)
                bpl.s   loc_44C5A
                tst.w   $29E(a5)
                bne.s   loc_44C6C
                bra.w   loc_44C96
; ---------------------------------------------------------------------------
loc_44C5A:                              ; CODE XREF: Boss_BackStringerDiveAttack+12   j
                                        ; Boss_BackStringerDiveAttack+50   j ...
                bsr.w Boss_BackStringerUpdateSegmentPositions
                lea     word_454B2(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44C6C:                              ; CODE XREF: Boss_BackStringerDiveAttack+18   j
                addq.w  #2,4(a5)
                move.w  #$13E,$14(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Back Stringer boss ultimate attack
Boss_BackStringer_State19:                              ; DATA XREF: ROM:00044732   o  ; was: loc_44C84
                addi.l  #$10000,$2FC(a5)
                bmi.s   loc_44C5A
                cmpi.w  #$12,$2FC(a5)
                bmi.s   loc_44C5A
loc_44C96:                              ; CODE XREF: Boss_BackStringerDiveAttack+1A   j
                move.w  #$22,4(a5) ; '"'
                move.w  #$13E,$14(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,$17C(a5)
                bsr.w Boss_BackStringerRetractSegments
; End of function Boss_BackStringerDiveAttack
; Timer-based delay for BackStringer dive sequence
Boss_BackStringerDiveDelay:                              ; DATA XREF: ROM:00044734   o  ; was: sub_44CBA
                subq.w  #1,$17C(a5)
                bmi.w   loc_44988
                bra.w   loc_449F0
; End of function Boss_BackStringerDiveDelay
; Initiates BackStringer left rotation attack
Boss_BackStringerRotateLeft:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+156   j  ; was: sub_44CC6
                move.w  #$26,4(a5) ; '&'
                bsr.s Boss_BackStringerSetRotationDirection
                bra.s Boss_BackStringerCheckRotationStart
; End of function Boss_BackStringerRotateLeft
; Initiates BackStringer right rotation attack
Boss_BackStringerRotateRight:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+15A   j  ; was: sub_44CD0
                move.w  #$24,4(a5) ; '$'
                bsr.s Boss_BackStringerSetRotationDirection
                bra.s Boss_BackStringerCheckRotationComplete
; End of function Boss_BackStringerRotateRight
; Determines rotation direction based on position
Boss_BackStringerSetRotationDirection:                              ; CODE XREF: Boss_BackStringerRotateLeft+6   p  ; was: sub_44CDA
                                        ; Boss_BackStringerRotateRight+6   p
                moveq   #8,d0
                cmpi.w  #$120,$10(a5)
                bpl.s   loc_44CE6
                moveq   #$FFFFFFF8,d0
loc_44CE6:                              ; CODE XREF: Boss_BackStringerSetRotationDirection+8   j
                move.w  d0,$11C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; End of function Boss_BackStringerSetRotationDirection
; Checks if rotation reached 256 degrees
Boss_BackStringerCheckRotationComplete:                              ; CODE XREF: Boss_BackStringerRotateRight+8   j  ; was: sub_44CFE
                                        ; DATA XREF: ROM:00044736   o
                cmpi.w  #$100,$56(a5)
                beq.w   loc_44988
                bra.s   loc_44D12
; End of function Boss_BackStringerCheckRotationComplete
; Checks if rotation returned to zero
Boss_BackStringerCheckRotationStart:                              ; CODE XREF: Boss_BackStringerRotateLeft+8   j  ; was: sub_44D0A
                                        ; DATA XREF: ROM:00044738   o
                tst.w   $56(a5)
                beq.w   loc_44988
loc_44D12:                              ; CODE XREF: Boss_BackStringerCheckRotationComplete+A   j
                bsr.w Projectile_BackStringerSpawnDrops
                move.w  $11C(a5),d1
                add.w   d1,$56(a5)
                andi.w  #$1F8,$56(a5)
                lea     word_45460(pc),a1
                nop
                tst.w   d1
                bpl.s   loc_44D34
                lea     word_45472(pc),a1
                nop
loc_44D34:                              ; CODE XREF: Boss_BackStringerCheckRotationStart+22   j
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; End of function Boss_BackStringerCheckRotationStart
; Complex tracking attack aiming at player position
Boss_BackStringerTrackingAttack:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+196   j  ; was: sub_44D3C
                                        ; Boss_BackStringerAttackStateMachine+1A0   j
                move.w  #$2A,4(a5) ; '*'
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.w   $58(a5)
                clr.w   $29C(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$180,$11C(a5)
                move.w  #$10,$11E(a5)
                move.w  #$40,$17C(a5) ; '@'
; Back Stringer boss closing pattern
Boss_BackStringer_State23:                              ; DATA XREF: ROM:0004473C   o  ; was: loc_44D6A
                subq.w  #1,$17C(a5)
                bmi.s   loc_44D8A
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                lea     word_4544E(pc),a1
                nop
                bsr.w Boss_BackStringerAnimatePose
                bra.w Boss_BackStringerUpdateRender
; ---------------------------------------------------------------------------
loc_44D8A:                              ; CODE XREF: Boss_BackStringerTrackingAttack+32   j
                addq.w  #2,4(a5)
                move.b  #$50,$81(a5) ; 'P'
                move.b  #$50,$E1(a5) ; 'P'
; Back Stringer boss final stand
Boss_BackStringer_State24:                              ; DATA XREF: ROM:0004473E   o  ; was: loc_44D9A
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.w  $11C(a5),d2
                sub.w   $56(a5),d2
                bmi.w   loc_44E52
                bne.w   loc_44E3E
                lea     word_4544E(pc),a1
                nop
                move.w  #$180,d1
                cmpi.w  #$1A0,$10(a5)
                bpl.s   loc_44DEC
                move.w  #$80,d1
                cmpi.w  #$A0,$10(a5)
                bmi.s   loc_44DEC
                move.w  #0,d1
                cmpi.w  #$140,$14(a5)
                bpl.s   loc_44DEC
                move.w  #$100,d1
                cmpi.w  #$B0,$14(a5)
                bpl.s   loc_44DF8
loc_44DEC:                              ; CODE XREF: Boss_BackStringerTrackingAttack+8A   j
                                        ; Boss_BackStringerTrackingAttack+96   j ...
                move.w  #$FFFF,$11E(a5)
                move.w  d1,$11C(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44DF8:                              ; CODE XREF: Boss_BackStringerTrackingAttack+AE   j
                subq.w  #1,$11E(a5)
                bpl.w   loc_44E64
                btst    #0,(dword_FFFF08+1).w
                beq.s   loc_44E22
                jsr (Math_CalculateAngleToPlayer).l
                addi.w  #$80,d2
                andi.w  #$1F8,d2
                move.w  d2,$11C(a5)
                move.w  #$80,$11E(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E22:                              ; CODE XREF: Boss_BackStringerTrackingAttack+CA   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F8,d0
                move.w  d0,$11C(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                move.w  d0,$11E(a5)
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E3E:                              ; CODE XREF: Boss_BackStringerTrackingAttack+76   j
                cmpi.w  #$100,d2
                bpl.w   loc_44E5A
loc_44E46:                              ; CODE XREF: Boss_BackStringerTrackingAttack+11A   j
                addq.w  #8,$56(a5)
                lea     word_45460(pc),a1
                nop
                bra.s   loc_44E64
; ---------------------------------------------------------------------------
loc_44E52:                              ; CODE XREF: Boss_BackStringerTrackingAttack+72   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_44E46
loc_44E5A:                              ; CODE XREF: Boss_BackStringerTrackingAttack+106   j
                subq.w  #8,$56(a5)
                lea     word_45472(pc),a1
                nop
loc_44E64:                              ; CODE XREF: Boss_BackStringerTrackingAttack+BA   j
                                        ; Boss_BackStringerTrackingAttack+C0   j ...
                andi.w  #$1F8,$56(a5)
                bra.w   loc_44920
; End of function Boss_BackStringerTrackingAttack
; Defeat sequence initialization
Boss_BackStringerDefeatInit:                              ; CODE XREF: Boss_BackStringerMain+22   j  ; was: sub_44E6E
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                move.w  #8,(word_FF808C).w
                clr.w   8(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.w  #$28,4(a5) ; '('
                clr.w   2(a5)
                clr.b   $21(a5)
                move.w  #$280,$48(a5)
                move.w  #0,$AA(a5)
                move.w  #$10,$10A(a5)
                movea.w #(word_FFC740-M68K_RAM),a0
                lea     (word_1B514).l,a1
                moveq   #$20,d4 ; ' '
                moveq   #0,d0
                moveq   #1,d7
                bsr.s Boss_BackStringerInitChainSegments
                moveq   #2,d0
                moveq   #$11,d7
; End of function Boss_BackStringerDefeatInit
; Initializes chain segments with velocity
Boss_BackStringerInitChainSegments:                              ; CODE XREF: Boss_BackStringerDefeatInit+58   p  ; was: sub_44ECC
                                        ; Boss_BackStringerInitChainSegments+40   j
                move.w  #$358,(a0)
                move.w  #$CC00,2(a0)
                clr.b   $21(a0)
                move.w  d0,$48(a0)
                move.w  $56(a0),d1
                move.w  -$80(a1,d1.w),d2
                move.w  (a1,d1.w),d3
                ext.l   d2
                ext.l   d3
                asl.l   #3,d2
                asl.l   #4,d3
                move.l  d2,$1C(a0)
                move.l  d3,$18(a0)
                addi.l  #-$30000,$1C(a0)
                neg.w   d4
                move.w  d4,$5C(a0)
                lea     $60(a0),a0
                dbf d7,Boss_BackStringerInitChainSegments
                rts
; End of function Boss_BackStringerInitChainSegments
; Defeat fade out with timer
Boss_BackStringerDefeatFadeOut:                              ; DATA XREF: ROM:0004473A   o  ; was: sub_44F12
                subq.w  #1,$48(a5)
                cmpi.w  #$100,$48(a5)
                bmi.s   loc_44F44
                cmpi.w  #$27E,$48(a5)
                bne.s   loc_44F30
                move.b  #$B8,d0
                jsr (Sound_PlaySFX).l
loc_44F30:                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+12   j
                cmpi.w  #$1E0,$48(a5)
                bne.s   loc_44F3E
                move.w  #$2E,(word_FF80C2).w ; '.'
loc_44F3E:                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+24   j
                jmp (Gfx_UpdatePaletteFade).l
; ---------------------------------------------------------------------------
loc_44F44:                              ; CODE XREF: Boss_BackStringerDefeatFadeOut+A   j
                bset    #4,2(a5)
                addq.w  #2,(word_FFA950).w
                rts
; End of function Boss_BackStringerDefeatFadeOut
; Updates boss rendering
Boss_BackStringerUpdateRender:                              ; CODE XREF: Boss_Epsilon1PlayerControl+4C   j  ; was: sub_44F50
                                        ; Boss_BackStringerAttackStateMachine+30   j ...
                bsr.w Boss_BackStringerUpdatePalette
                bsr.w Boss_BackStringerUpdateArms
                moveq   #$14,d7
                jmp Boss_BackStringerUpdateMetasprite
; End of function Boss_BackStringerUpdateRender
; Updates palette cycling
Boss_BackStringerUpdatePalette:                              ; CODE XREF: Boss_BackStringerUpdateRender   p  ; was: sub_44F60
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
word_44F8E:     dc.w $AEA, $4C, $2A, 8, 6, 8, $2A, $4C
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+E   r
                                        ; Boss_BackStringerUpdatePalette+14   r
word_44F9E:     dc.w $8C8, $A, 8, 6, 4, 6, 8, $A
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+18   r
                                        ; Boss_BackStringerUpdatePalette+1E   r
word_44FAE:     dc.w $6A6, 4, 2, 0, 0, 0, 2, 4
                                        ; DATA XREF: Boss_BackStringerUpdatePalette+22   r
                                        ; Boss_BackStringerUpdatePalette+28   r


; Updates arm sprite orientation
Boss_BackStringerUpdateArms:                              ; CODE XREF: Boss_BackStringerUpdateRender+4   p  ; was: sub_44FBE
                movea.w a5,a0
                lea     $60(a0),a0
                move.w  #$8300,$E(a0)
                moveq   #0,d1
                bsr.s Boss_BackStringerCalcSpriteAngle
                lea     $60(a0),a0
                move.w  #$9B00,$E(a0)
                moveq   #$10,d1
; End of function Boss_BackStringerUpdateArms
; Calculates sprite angle and graphics
Boss_BackStringerCalcSpriteAngle:                              ; CODE XREF: Boss_BackStringerUpdateArms+E   p  ; was: sub_44FDA
                move.w  $56(a0),d0
                add.w   $56(a5),d0
loc_44FE2:                              ; CODE XREF: Projectile_BackStringerChainFalling+36   j
                addi.w  #$20,d0 ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_44FF6
                eori.w  #$1800,$E(a0)
loc_44FF6:                              ; CODE XREF: Boss_BackStringerCalcSpriteAngle+14   j
                tst.w   $54(a5)
                bne.s   loc_45002
                eori.w  #$800,$E(a0)
loc_45002:                              ; CODE XREF: Boss_BackStringerCalcSpriteAngle+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                add.w   d1,d0
                move.l  off_45012(pc,d0.w),8(a0)
                rts
; End of function Boss_BackStringerCalcSpriteAngle
; ---------------------------------------------------------------------------
off_45012:      dc.l word_EC346         ; DATA XREF: Boss_BackStringerCalcSpriteAngle+30   r
                dc.l word_EC352
                dc.l word_EC36A
                dc.l word_EC376
                dc.l word_EC2E6
                dc.l word_EC2FE
                dc.l word_EC316
                dc.l word_EC32E


; Updates BackStringer palette with custom colors
Gfx_BackStringerUpdatePalette:                              ; CODE XREF: Boss_BackStringerAttackStateMachine:loc_44B54   p  ; was: sub_45032
                movea.w #(byte_FFE322-M68K_RAM),a0
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                moveq   #$B,d7
loc_4503C:                              ; CODE XREF: Gfx_BackStringerUpdatePalette+C   j
                move.w  (a1)+,(a0)+
                dbf     d7,loc_4503C
                movea.w #(byte_FFE322-M68K_RAM),a0
                move.w  $4DC(a5),d0
                andi.w  #$FFFE,d0
                cmpi.w  #2,d0
                bmi.s   loc_4505A
                move.w  #$ECC,(a0,d0.w)
loc_4505A:                              ; CODE XREF: Gfx_BackStringerUpdatePalette+20   j
                cmpi.w  #$16,d0
                bpl.s   locret_4506C
                cmpi.w  #$C,d0
                bmi.s   locret_4506C
                move.w  #$A40,2(a0,d0.w)
locret_4506C:                           ; CODE XREF: Gfx_BackStringerUpdatePalette+2C   j
                                        ; Gfx_BackStringerUpdatePalette+32   j
                rts
; End of function Gfx_BackStringerUpdatePalette
; Initializes projectile slots
Boss_BackStringerInitProjectileSlots:                              ; CODE XREF: Boss_BackStringerSpawn+64   p  ; was: sub_4506E
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_45074:                              ; CODE XREF: Boss_BackStringerInitProjectileSlots+18   j
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
Boss_BackStringerResetBodySegments:                              ; CODE XREF: Boss_Epsilon1Initialize+1E   j  ; was: sub_450B2
                                        ; Boss_BackStringerAttackStateMachine+3EE   p
                clr.l   $2FC(a5)
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_450BC:                              ; CODE XREF: Boss_BackStringerResetBodySegments+36   j
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
locret_4510C:                           ; CODE XREF: Boss_BackStringerResetBodySegments+3E   j
                rts
; End of function Boss_BackStringerResetBodySegments
; Updates body segment vertical positions
Boss_BackStringerUpdateSegmentPositions:                              ; CODE XREF: Boss_Epsilon1PlayerControl:loc_44832   p  ; was: sub_4510E
                                        ; sub_44C3C:loc_44C5A   p
                move.l  $2FC(a5),d0
                move.l  d0,d1
                add.l   $D4(a5),d1
                moveq   #3,d3
                btst    #0,(word_FFA000+1).w
                bne.s   loc_45124
                moveq   #0,d3
loc_45124:                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+12   j
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_4512A:                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+30   j
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
loc_45176:                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+46   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_45184
                clr.w   $29E(a5)
                bra.s   locret_451A8
; ---------------------------------------------------------------------------
loc_45184:                              ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+6E   j
                bset    #7,(word_FFA40E).w
                move.w  #$C8,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $10(a0),(word_FF8250).w
                move.w  $14(a0),(word_FF8252).w
locret_451A8:                           ; CODE XREF: Boss_BackStringerUpdateSegmentPositions+44   j
                                        ; Boss_BackStringerUpdateSegmentPositions+4E   j ...
                rts
; End of function Boss_BackStringerUpdateSegmentPositions
; Retracts body segments by setting decay timers
Boss_BackStringerRetractSegments:                              ; CODE XREF: Boss_Epsilon1PlayerControl+14   p  ; was: sub_451AA
                                        ; Boss_BackStringerDiveAttack+7A   p
                move.w  #$324,d0
                moveq   #$FFFFFFFF,d1
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                moveq   #5,d7
loc_451B6:                              ; CODE XREF: Boss_BackStringerRetractSegments+24   j
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
Effect_BackStringerSegmentFlash:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_451E6
                subq.w  #1,$48(a5)
                bpl.s   loc_451F6
                move.w  #$10,(a5)
                clr.w   2(a5)
                rts
; ---------------------------------------------------------------------------
loc_451F6:                              ; CODE XREF: Effect_BackStringerSegmentFlash+4   j
                bset    #3,$E(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4520A
                bclr    #3,$E(a5)
loc_4520A:                              ; CODE XREF: Effect_BackStringerSegmentFlash+1C   j
                move.w  $48(a5),d0
                andi.w  #6,d0
                move.w  word_45220(pc,d0.w),8(a5)
                move.w  word_45226(pc,d0.w),$A(a5)
                rts
; End of function Effect_BackStringerSegmentFlash
; ---------------------------------------------------------------------------
word_45220:     dc.w 0, $100, $200      ; DATA XREF: Effect_BackStringerSegmentFlash+2C   r
word_45226:     dc.w $FCFC, $FCF8, $FCF4
                                        ; DATA XREF: Effect_BackStringerSegmentFlash+32   r


; Applies circular motion
Boss_BackStringerApplyCircularMotion:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+2C   p  ; was: sub_4522C
                                        ; Boss_BackStringerAttackStateMachine+DA   p
                tst.w   $23E(a5)
                beq.s   loc_45238
                move.w  #$3C,$3BC(a5) ; '<'
loc_45238:                              ; CODE XREF: Boss_BackStringerApplyCircularMotion+4   j
                subi.w  #4,$3BC(a5)
                move.w  $56(a5),d0
                subi.w  #$80,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d1
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
Boss_BackStringerAnimatePose:                              ; CODE XREF: Boss_Epsilon1PlayerControl+42   p  ; was: sub_4526C
                                        ; Boss_BackStringerAttackStateMachine+28   p ...
                clr.w   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_452EE
loc_45276:                              ; CODE XREF: Boss_BackStringerAnimatePose+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_452FE
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_45298
                move.b  1(a1,d0.w),d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_45298:                              ; CODE XREF: Boss_BackStringerAnimatePose+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_452A8
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_452A8:                              ; CODE XREF: Boss_BackStringerAnimatePose+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_452B8
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_45276
; ---------------------------------------------------------------------------
loc_452B8:                              ; CODE XREF: Boss_BackStringerAnimatePose+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_454F2,d0
                movea.l d0,a0
                bsr.w Anim_BackStringerCalcInterpolation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                addq.w  #1,$23E(a5)
                tst.w   $C(a5)
                bmi.s   loc_452FE
loc_452EE:                              ; CODE XREF: Boss_BackStringerAnimatePose+8   j
                subq.w  #1,$C(a5)
                movea.w #(word_FF9600-M68K_RAM),a0
                moveq   #$13,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_452FE:                              ; CODE XREF: Boss_BackStringerAnimatePose+E   j
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
Anim_BackStringerCalcInterpolation:                              ; CODE XREF: Boss_BackStringerAnimatePose+62   p  ; was: sub_45410
                movea.l #word_35200,a1
                movea.w #(word_FF9600-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$13,d7
                jmp Anim_CalculateInterpolationDeltas
; End of function Anim_BackStringerCalcInterpolation
; Loads animation frame delay data
Anim_BackStringerLoadFrameDelays:
                movea.w #(word_FF9600-M68K_RAM),a1  ; was: sub_45426
                moveq   #$13,d7
                jmp Anim_LoadFrameDelays
; End of function Anim_BackStringerLoadFrameDelays
; ---------------------------------------------------------------------------
word_45432:     dc.w $2020, 0, $2020, $14, $FFFF
                                        ; DATA XREF: Boss_Epsilon1PlayerControl+3C   o
word_4543C:     dc.w $2828, $28, $607, 0, $2828, $14, $607, 0, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_449FE   o
word_4544E:     dc.w $708, $3C, $708, $50, $708, $64, $708, $78, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_4486C   o
                                        ; Boss_BackStringerTrackingAttack+40   o ...
word_45460:     dc.w $305, $8C, $305, $A0, $305, $B4, $305, $C8, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_4491A   o
                                        ; Boss_BackStringerCheckRotationStart+1A   o ...
word_45472:     dc.w $305, $DC, $305, $F0, $305, $104, $305, $118, $FFFF
                                        ; DATA XREF: Boss_BackStringerCheckRotationStart+24   o
                                        ; Boss_BackStringerTrackingAttack+122   o
word_45484:     dc.w $306, $12C, $606, $12C, $418, $64, $306, $140, $606, $140, $418, $3C, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine+74   o
word_4549E:     dc.w $808, 0, $418, $154, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine+A2   o
                                        ; sub_4484A:loc_449F0   o
word_454A8:     dc.w $404, 0, $20C, $154, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44C0C   o
word_454B2:     dc.w $408, $190, $408, $190, $C0E, $154, $3030, 0, $FFFE
                                        ; DATA XREF: Boss_BackStringerDiveAttack+22   o
word_454C4:     dc.w $80C, $154, $C0C, $154, $80C, 0, $C0C, 0, $FFFF
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44B22   o
word_454D6:     dc.w $1010, $154, $E10, $17C, $707, $17C, $80D9, $C0E, $190, $404, $190, $1010, $154, $FFFE
                                        ; DATA XREF: Boss_BackStringerAttackStateMachine:loc_44BB6   o
word_454F2:	binclude	"data/other/word_454F2.bin"
word_454F2_End:


; Rope/chain segment handler
Projectile_BackStringerRopeSegment:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_45696
                bclr    #0,$5E(a5)
                beq.s   loc_456CA
                move.w  #$1000,d0
                muls.w  $5C(a5),d0
                add.l   d0,$14(a5)
                clr.w   $5C(a5)
                move.w  #2,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_456CA
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_456CA:                              ; CODE XREF: Projectile_BackStringerRopeSegment+6   j
                                        ; Projectile_BackStringerRopeSegment+2A   j
                move.w  #$168,d0
                add.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                clr.l   $1C(a5)
                move.w  (dword_FFA414).w,d0
                cmp.w   $14(a5),d0
                bpl.s   locret_456EA
                bclr    #7,(word_FFA40E).w
locret_456EA:                           ; CODE XREF: Projectile_BackStringerRopeSegment+4C   j
                rts
; End of function Projectile_BackStringerRopeSegment
; Spawns falling projectiles periodically
Projectile_BackStringerSpawnDrops:                              ; CODE XREF: Boss_BackStringerAttackStateMachine:loc_449D0   p  ; was: sub_456EC
                                        ; sub_4484A:loc_44A80   p ...
                tst.w   (word_FFC680).w
                beq.w   locret_4577A
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_4577A
                tst.w   $47C(a5)
                bpl.s   loc_45716
                subq.w  #1,$47E(a5)
                bpl.s   locret_4577A
                move.w  #7,$47C(a5)
                move.w  #$B,$47E(a5)
loc_45716:                              ; CODE XREF: Projectile_BackStringerSpawnDrops+16   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_4577A
                subq.w  #1,$47C(a5)
                move.w  #$318,(a0)
                move.w  #$CD00,2(a0)
                move.w  #$8300,$E(a0)
                move.l  #word_EC406,8(a0)
                move.b  #4,$20(a0)
                move.b  #$80,$21(a0)
                move.l  #$F404FC04,$28(a0)
                move.w  #2,$24(a0)
                move.w  #$14F,$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                move.w  $10(a0),$5C(a0)
                move.w  $10(a0),$5E(a0)
locret_4577A:                           ; CODE XREF: Projectile_BackStringerSpawnDrops+4   j
                                        ; Projectile_BackStringerSpawnDrops+10   j ...
                rts
; End of function Projectile_BackStringerSpawnDrops
; Projectile that bounces off ground and tracks player
Boss_Epsilon1BounceProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4577C
                tst.w   (word_FFC680).w
                beq.s   loc_4578A
                cmpi.w  #$17C,$14(a5)
                bmi.s   loc_45792
loc_4578A:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+4   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45792:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_4579E
                tst.w   $24(a5)
                bpl.s   loc_457C2
loc_4579E:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+1A   j
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                clr.b   $21(a5)
                clr.w   $24(a5)
                eori.w  #$1000,$E(a5)
                move.l  #$FFFD0000,$1C(a5)
                bsr.w Boss_Epsilon1CalculateHorizontalVelocity
loc_457C2:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+20   j
                bset    #3,$E(a5)
                addq.w  #1,$48(a5)
                btst    #2,$49(a5)
                bne.s   loc_457DA
                bclr    #3,$E(a5)
loc_457DA:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+56   j
                tst.b   $21(a5)
                beq.w   loc_458A2
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  4(a5),d0
                bne.w   loc_4588A
                move.w  $48(a5),d0
                andi.w  #7,d0
                bne.s   loc_4580A
                move.w  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   $5C(a5),d0
                move.w  d0,$5E(a5)
loc_4580A:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+7A   j
                move.w  $5E(a5),d0
                cmp.w   $10(a5),d0
                bpl.s   loc_4582C
                tst.w   $18(a5)
                bpl.s   loc_45822
                cmpi.w  #$FFFE,$18(a5)
                bmi.s   loc_45842
loc_45822:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+9C   j
                subi.l  #$1000,$18(a5)
                bra.s   loc_45842
; ---------------------------------------------------------------------------
loc_4582C:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+96   j
                tst.w   $18(a5)
                bmi.s   loc_4583A
                cmpi.w  #2,$18(a5)
                bpl.s   loc_45842
loc_4583A:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+B4   j
                addi.l  #$1000,$18(a5)
loc_45842:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+A4   j
                                        ; Boss_Epsilon1BounceProjectile+AE   j ...
                addi.l  #$1800,$1C(a5)
                cmpi.w  #$FFFF,$1C(a5)
                bmi.s   loc_4585A
                move.l  #$FFFDC000,$1C(a5)
loc_4585A:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+D4   j
                move.w  $14(a5),d0
                subi.w  #$A,d0
                cmp.w   $14(a4),d0
                bpl.s   locret_45888
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                move.l  #$4000,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$20,d0 ; ' '
                move.w  d0,$48(a5)
locret_45888:                           ; CODE XREF: Boss_Epsilon1BounceProjectile+EA   j
                rts
; ---------------------------------------------------------------------------
loc_4588A:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+6E   j
                bset    #0,$5E(a4)
                addq.w  #1,$5C(a4)
                move.w  $14(a4),d0
                addi.w  #$A,d0
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_458A2:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+62   j
                addi.l  #$4000,$1C(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_458BE
                bclr    #7,2(a5)
locret_458BE:                           ; CODE XREF: Boss_Epsilon1BounceProjectile+13A   j
                rts
; End of function Boss_Epsilon1BounceProjectile
; Calculates horizontal velocity from random value
Boss_Epsilon1CalculateHorizontalVelocity:                              ; CODE XREF: Boss_Epsilon1BounceProjectile+42   p  ; was: sub_458C0
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                btst    #1,(word_FFA000+1).w
                bne.s   loc_458D2
                neg.l   d0
loc_458D2:                              ; CODE XREF: Boss_Epsilon1CalculateHorizontalVelocity+E   j
                move.l  d0,$18(a5)
                rts
; End of function Boss_Epsilon1CalculateHorizontalVelocity
; Spawns two projectiles at different angles
Boss_Epsilon1SpawnDualProjectiles:                              ; CODE XREF: Boss_BackStringerAttackStateMachine+34E   p  ; was: sub_458D8
                move.w  $70(a5),d5
                move.w  $74(a5),d6
                subi.w  #$10,d6
                moveq   #2,d3
                move.w  #$180,d4
                moveq   #8,d7
                bsr.s Projectile_SpawnAngled
                moveq   #$FFFFFFFE,d3
                move.w  #$80,d4
                moveq   #$FFFFFFF8,d7
; End of function Boss_Epsilon1SpawnDualProjectiles
; Spawns angled projectile with trajectory parameters
Projectile_SpawnAngled:                              ; CODE XREF: Boss_Epsilon1SpawnDualProjectiles+14   p  ; was: sub_458F6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_45944
                move.w  #$328,(a0)
                move.w  #$CC80,2(a0)
                move.l  #word_EC412,8(a0)
                move.w  #$A300,$E(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$88,$26(a0)
                move.w  #1,$1C(a0)
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.w  d7,$48(a0)
                move.w  d3,$4E(a0)
                move.w  d4,$56(a0)
locret_45944:                           ; CODE XREF: Projectile_SpawnAngled+6   j
                rts
; End of function Projectile_SpawnAngled
; Handles debris bouncing physics
Boss_Epsilon1DebrisPhysics:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_45946
                tst.w   (word_FF808C).w
                bpl.s   loc_45976
                bclr    #7,$22(a5)
                beq.s   loc_4599C
                bclr    #4,$22(a5)
                beq.s   loc_45976
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_45976
                jsr (Effect_SpawnDestructionBlast).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
loc_45976:                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+4   j
                                        ; Boss_Epsilon1DebrisPhysics+14   j ...
                move.l  $18(a5),d0
                asr.l   #3,d0
                neg.l   d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #3,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                move.l  #off_E9584,8(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_4599C:                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+C   j
                subi.l  #$1000,$1C(a5)
                cmpi.w  #$90,$14(a5)
                bpl.s   loc_459B4
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_459B4:                              ; CODE XREF: Boss_Epsilon1DebrisPhysics+64   j
                move.w  $4C(a5),d0
                add.w   $4E(a5),d0
                andi.w  #6,d0
                move.w  d0,$4C(a5)
                andi.w  #$E7FF,$E(a5)
                lea     (word_1C972).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                move.w  $56(a5),d0
                add.w   $48(a5),d0
                andi.w  #$1FE,d0
                move.w  d0,$56(a5)
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_45A58
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_45A58
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                move.l  $1C(a5),d1
                neg.l   d0
                neg.l   d1
                asl.l   #1,d0
                asl.l   #1,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                add.l   d0,$10(a0)
                add.l   d1,$14(a0)
                move.w  #$360,(a0)
                move.w  #$EC80,2(a0)
                move.w  #$A300,$E(a0)
                move.l  #off_EC42A,8(a0)
                move.w  $4E(a5),$4A(a0)
                clr.b   $20(a0)
locret_45A58:                           ; CODE XREF: Boss_Epsilon1DebrisPhysics+BA   j
                                        ; Boss_Epsilon1DebrisPhysics+C2   j
                rts
; End of function Boss_Epsilon1DebrisPhysics
; Updates projectile rotation based on spin direction
Boss_Epsilon1ProjectileRotation:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_45A5A
                cmpi.w  #$80,$C(a5)
                bmi.s   loc_45A6A
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45A6A:                              ; CODE XREF: Boss_Epsilon1ProjectileRotation+6   j
                move.w  $48(a5),d0
                add.w   $4A(a5),d0
                andi.w  #6,d0
                move.w  d0,$48(a5)
                andi.w  #$E7FF,$E(a5)
                lea     (word_1C972).l,a0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                rts
; End of function Boss_Epsilon1ProjectileRotation
; Chain segment falling state
Projectile_BackStringerChainFalling:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_45A90
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_45AA0
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_45AA0:                              ; CODE XREF: Projectile_BackStringerChainFalling+6   j
                addi.l  #$2000,$1C(a5)
                move.w  $5C(a5),d0
                add.w   d0,$56(a5)
                tst.w   $48(a5)
                bne.s   loc_45ACA
                movea.w a5,a0
                move.w  $56(a5),d0
                move.w  #$8300,$E(a5)
                move.w  $4A(a5),d1
                bra.w   loc_44FE2
; ---------------------------------------------------------------------------
loc_45ACA:                              ; CODE XREF: Projectile_BackStringerChainFalling+24   j
                jmp Sprite_UpdateRotatedFrame
; End of function Projectile_BackStringerChainFalling
; Main boss handler
Boss_Epsilon1Main:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_45AD0
                cmpi.w  #6,4(a5)
                bls.w   loc_45CD4
                btst    #6,(byte_FF8244).w
                bne.s   loc_45AEE
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$C,d0
                bhi.s   loc_45B14
loc_45AEE:                              ; CODE XREF: Boss_Epsilon1Main+10   j
                tst.w   (word_FF9474).w
                bne.s   loc_45B14
                addq.w  #1,(word_FF9472).w
                tst.w   (word_FFFF0E).w
                bne.s   loc_45B04
                move.w  #$80,d0
                bra.s   loc_45B08
; ---------------------------------------------------------------------------
loc_45B04:                              ; CODE XREF: Boss_Epsilon1Main+2C   j
                move.w  #$40,d0 ; '@'
loc_45B08:                              ; CODE XREF: Boss_Epsilon1Main+32   j
                cmp.w   (word_FF9472).w,d0
                bhi.s   loc_45B14
                move.w  #1,(word_FF9474).w
loc_45B14:                              ; CODE XREF: Boss_Epsilon1Main+1C   j
                                        ; Boss_Epsilon1Main+22   j ...
                btst    #1,$4C(a5)
                bne.s   loc_45B30
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_45B30
                move.w  $50(a5),d0
                beq.s   loc_45B30
                sub.w   d0,(word_FF8234).w
loc_45B30:                              ; CODE XREF: Boss_Epsilon1Main+4A   j
                                        ; Boss_Epsilon1Main+54   j ...
                jsr (Gfx_InitPaletteFade).l
                move.w  (dword_FFC690).w,d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
                move.w  (dword_FF9414).w,d0
                lea     (word_1B514).l,a2
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d0
                ext.l   d0
                asl.l   #5,d0
                swap    d0
                add.w   (dword_FFC694).w,d0
                move.w  d0,(dword_FF940C+2).w
                move.w  (dword_FFC690).w,(dword_FF940C).w
                move.w  #$180,d0
                sub.w   (dword_FF940C).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1C8,d0
                sub.w   (dword_FF940C+2).w,d0
                move.w  d0,(dword_FFA90C).w
                bsr.w Boss_Epsilon1UpdateRotationMatrix
                bsr.w Boss_Epsilon1PhaseTransition
                btst    #2,(byte_FF80EC).w
                bne.s   loc_45BC4
                btst    #1,(byte_FF80EC).w
                bne.w   loc_45C5E
                tst.w   (word_FF8200).w
                bne.s   loc_45BC4
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                move.w  #$5C,4(a5) ; '\'
                clr.l   (dword_FFC698).w
                clr.l   (dword_FFC69C).w
                bset    #0,(byte_FFA272).w
                bra.w   loc_45C5E
; ---------------------------------------------------------------------------
loc_45BC4:                              ; CODE XREF: Boss_Epsilon1Main+BE   j
                                        ; Boss_Epsilon1Main+CE   j
                move.w  (dword_FF940C).w,d2
                move.w  (dword_FF940C+2).w,d3
                move.w  d2,$10(a5)
                move.w  d3,$14(a5)
                move.w  $56(a5),d0
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d1
                muls.w  $54(a5),d1
                swap    d1
                move.w  (word_FFC6CC).w,d0
                add.w   d0,$10(a5)
                add.w   d1,$14(a5)
                bsr.w Boss_Epsilon1RotationDispatcher
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FE,d0
                lea     (word_FF9480).w,a0
                move.w  #$2F,d7 ; '/'
loc_45C08:                              ; CODE XREF: Boss_Epsilon1Main+13E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_45C08
                lea     (word_FF9480).w,a0
                lea     (dword_FF9400).w,a1
                move.w  #5,d7
loc_45C1E:                              ; CODE XREF: Boss_Epsilon1Main+15A   j
                move.w  (dword_FF9414+2).w,d6
loc_45C22:                              ; CODE XREF: Boss_Epsilon1Main+154   j
                move.w  (a0)+,d0
                dbf     d6,loc_45C22
                move.w  d0,(a1)+
                dbf     d7,loc_45C1E
                move.w  (dword_FF9410).w,d0
                add.w   d0,(dword_FF9414).w
                cmpi.w  #$12,4(a5)
                bcs.s   loc_45C42
                bsr.w Boss_Epsilon1BerserkCheck
loc_45C42:                              ; CODE XREF: Boss_Epsilon1Main+16C   j
                bclr    #2,(byte_FF8308).w
                beq.s   loc_45C5E
                btst    #2,$4C(a5)
                bne.s   loc_45C5E
                bset    #2,$4C(a5)
                move.w  #$4E,4(a5) ; 'N'
loc_45C5E:                              ; CODE XREF: Boss_Epsilon1Main+C6   j
                                        ; Boss_Epsilon1Main+F0   j ...
                lea     (word_1B514).l,a2
                move.w  (dword_FF940C).w,d2
                move.w  (dword_FF940C+2).w,d3
                movea.w #(word_FFC6E0-M68K_RAM),a1
                move.w  $52(a1),d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  $50(a1),d0
                muls.w  $50(a1),d1
                swap    d0
                swap    d1
                add.w   d2,d0
                add.w   d3,d1
                add.w   $4C(a1),d0
                add.w   $4E(a1),d1
                move.w  d0,$10(a1)
                move.w  d1,$14(a1)
                bsr.w Boss_Epsilon1PartHandler
                movea.w #(word_FFC740-M68K_RAM),a1
                move.w  $52(a1),d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  $50(a1),d0
                muls.w  $50(a1),d1
                swap    d0
                swap    d1
                add.w   d2,d0
                add.w   d3,d1
                add.w   $4C(a1),d0
                add.w   $4E(a1),d1
                move.w  d0,$10(a1)
                move.w  d1,$14(a1)
                bsr.w Boss_Epsilon1PartHandler
loc_45CD4:                              ; CODE XREF: Boss_Epsilon1Main+6   j
                bsr.w Boss_Epsilon1Dispatcher
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                move.w  d0,(word_FFE400).w
                rts
; End of function Boss_Epsilon1Main
; Boss state dispatcher
Boss_Epsilon1Dispatcher:                              ; CODE XREF: Boss_Epsilon1Main:loc_45CD4   p  ; was: sub_45CE4
                move.w  4(a5),d0
                lea     off_45CF0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1Dispatcher
; ---------------------------------------------------------------------------
off_45CF0:      dc.w Boss_Epsilon1BattleInit-*        ; DATA XREF: Boss_Epsilon1Dispatcher+4   o
                dc.w Boss_Epsilon1InitTimer-*
                dc.w Boss_Epsilon1BattleSetup-*
                dc.w Boss_Epsilon1IntroTransition-*
                dc.w Boss_Epsilon1AttackPhase1Init-*
                dc.w Boss_Epsilon1RotationSetup-*
                dc.w Boss_Epsilon1FadeWithButtonCheck-*
                dc.w Boss_Epsilon1VictoryCheck-*
                dc.w Boss_Epsilon1AttackState1-*
                dc.w Boss_Epsilon1AttackState2-*
                dc.w Boss_Epsilon1AttackPhase1Setup-*
                dc.w Boss_Epsilon1AttackPhase2Wait-*
                dc.w Boss_Epsilon1AttackPhase3Setup-*
                dc.w Boss_Epsilon1AttackPhase4Scale-*
                dc.w Boss_Epsilon1AttackPhase5Init-*
                dc.w Boss_Epsilon1AttackPhase6RingWait-*
                dc.w Boss_Epsilon1AttackPhase7SpawnEntity-*
                dc.w Boss_Epsilon1ProjectileRingAndUpdate-*
                dc.w Boss_Epsilon1DualProjectileAim-*
                dc.w Boss_Epsilon1SpawnProjectile1-*
                dc.w Boss_Epsilon1SpawnProjectile2-*
                dc.w Boss_Epsilon1SpawnProjectile3-*
                dc.w Boss_Epsilon1SpawnProjectile4-*
                dc.w Boss_Epsilon1SpawnProjectile5-*
                dc.w Boss_Epsilon1AttackPattern1-*
                dc.w Projectile_Epsilon1Type1Main-*
                dc.w Projectile_Epsilon1Type2Main-*
                dc.w Projectile_Epsilon1Type3Main-*
                dc.w Projectile_Epsilon1Type4Main-*
                dc.w Projectile_Epsilon1Type5Main-*
                dc.w Projectile_Epsilon1HomingInit-*
                dc.w Projectile_Epsilon1HomingUpdate-*
                dc.w Projectile_Epsilon1SpiralInit-*
                dc.w Projectile_Epsilon1SpiralUpdate-*
                dc.w Projectile_Epsilon1WaveUpdate-*
                dc.w Projectile_Epsilon1BounceInit-*
                dc.w Projectile_Epsilon1BounceUpdate-*
                dc.w Projectile_Epsilon1LaserInit-*
                dc.w Projectile_Epsilon1LaserUpdate-*
                dc.w Boss_Epsilon1ResetScrollingPhase-*
                dc.w Boss_Epsilon1AttackPattern2Transition-*
                dc.w Boss_Epsilon1BoundsCheckReverse-*
                dc.w Boss_Epsilon1ScrollAccelerationPhase-*
                dc.w Boss_Epsilon1DelayTimer-*
                dc.w Boss_Epsilon1WaitForLowHealth-*
                dc.w Boss_Epsilon1ClearPhaseFlags-*
                dc.w Boss_Epsilon1DefeatExplosion1-*
                dc.w Boss_Epsilon1DefeatExplosion2-*
                dc.w Boss_Epsilon1DefeatExplosion3-*
                dc.w Boss_Epsilon1DefeatShake-*
                dc.w Boss_Epsilon1DefeatFade-*
                dc.w Boss_Epsilon1DefeatFlash-*
                dc.w Boss_Epsilon1Defeat_FlashLoop-*
                dc.w Boss_Epsilon1DefeatBreakup-*
                dc.w Boss_Epsilon1PartDamageFlash-*
                dc.w Boss_Epsilon1PartInvulnerable-*
                dc.w Boss_Epsilon1CoreVulnerableCheck-*
                dc.w Boss_Epsilon1DamageFlash-*
                dc.w Boss_Epsilon1HealthBarColor-*
                dc.w Boss_Epsilon1PartShieldCheck-*
                dc.w Boss_Epsilon1ShieldBreak-*
                dc.w Boss_Epsilon1ShieldRegenerate-*
                dc.w Boss_Epsilon1FinalPhaseTransition-*
                dc.w Cutscene_PlanetFadeIn-*


; Battle start state
Boss_Epsilon1BattleInit:                              ; DATA XREF: ROM:off_45CF0   o  ; was: sub_45D70
                tst.b   (word_FFF720).w
                bmi.w   locret_45D8C
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.b  #1,d0
                jsr (Sound_PlaySFX).l
locret_45D8C:                           ; CODE XREF: Boss_Epsilon1BattleInit+4   j
                rts
; End of function Boss_Epsilon1BattleInit
; Initial timer countdown
Boss_Epsilon1InitTimer:                              ; DATA XREF: ROM:00045CF2   o  ; was: sub_45D8E
                subq.w  #1,$48(a5)
                bne.s   locret_45D98
                addq.w  #2,4(a5)
locret_45D98:                           ; CODE XREF: Boss_Epsilon1InitTimer+4   j
                rts
; End of function Boss_Epsilon1InitTimer
; Complete battle setup with all objects
Boss_Epsilon1BattleSetup:                              ; DATA XREF: ROM:00045CF4   o  ; was: sub_45D9A
                bsr.w Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.w   locret_46014
                btst    #1,(word_FFA000+1).w
                bne.w   locret_46014
                btst    #2,(word_FFA000+1).w
                bne.w   locret_46014
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.w   locret_46014
                addq.w  #2,4(a5)
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF944E).w
                clr.l   (dword_FF9452).w
                clr.l   (dword_FF9456).w
                clr.l   (dword_FF9466).w
                clr.l   (dword_FF946A).w
                clr.l   (dword_FF946E).w
                clr.l   (dword_FF9478).w
                moveq   #0,d0
                lea     (word_FF9480).w,a0
                move.w  #5,d7
loc_45E00:                              ; CODE XREF: Boss_Epsilon1BattleSetup+70   j
                move.w  (dword_FF9414+2).w,d6
loc_45E04:                              ; CODE XREF: Boss_Epsilon1BattleSetup+6C   j
                move.w  d0,(a0)+
                dbf     d6,loc_45E04
                dbf     d7,loc_45E00
                clr.w   (dword_FF9418+2).w
                move.b  #4,(byte_FFA420).w
                move.w  #$264,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                move.w  $10(a5),(dword_FF940C).w
                move.w  $14(a5),(dword_FF940C+2).w
                move.w  #2,$48(a5)
                move.b  #$40,$20(a5) ; '@'
                move.l  #word_EC046,8(a5)
                move.w  #$4300,$E(a5)
                move.w  #$CC80,2(a5)
                move.b  #$90,$21(a5)
                move.b  #$88,$23(a5)
                move.w  #$C8,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$16,$24(a5)
                move.w  #$18,$54(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.w  #$C80,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.l  #word_EC082,8(a0)
                move.w  #$4B00,$E(a0)
                move.w  #$CC80,2(a0)
                move.l  #$F404F40A,$28(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.w  #$FFE6,$4C(a0)
                move.w  #$36,$4E(a0) ; '6'
                move.w  #$1C0,$52(a0)
                move.w  #0,$50(a0)
                movea.w #(word_FFC740-M68K_RAM),a0
                move.w  #$10,(a0)
                move.b  $20(a5),$20(a0)
                move.l  #word_EC082,8(a0)
                move.w  #$4300,$E(a0)
                move.w  #$CC80,2(a0)
                move.l  #$F404F60C,$28(a0)
                move.b  #$80,$21(a0)
                move.b  #$10,$23(a0)
                move.w  #$1A,$4C(a0)
                move.w  #$36,$4E(a0) ; '6'
                move.w  #$140,$52(a0)
                move.w  #0,$50(a0)
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$278,(a0)
                move.w  #$C3C0,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$C80,2(a0)
                movea.w #(word_FFC800-M68K_RAM),a0
                movea.w #(word_FFCA40-M68K_RAM),a1
                clr.w   d6
                move.w  #$FFB0,d4
                move.w  #$50,d5 ; 'P'
                move.w  #5,d7
loc_45F7C:                              ; CODE XREF: Boss_Epsilon1BattleSetup+276   j
                move.w  #$284,(a0)
                move.w  #$C80,2(a0)
                move.w  #$4308,$E(a0)
                move.w  #$700,8(a0)
                move.w  #$F8F0,$A(a0)
                move.b  #$10,$23(a0)
                move.l  #$FC04F010,$2C(a0)
                move.w  #$C8,$26(a0)
                move.w  #4,$20(a0)
                move.w  d6,$4A(a0)
                move.w  d4,$4C(a0)
                move.w  #$284,(a1)
                move.w  #$C80,2(a1)
                move.w  #$4308,$E(a1)
                move.w  #$700,8(a1)
                move.w  #$F8F0,$A(a1)
                move.b  #$10,$23(a1)
                move.l  #$FC04F010,$2C(a1)
                move.w  #$C8,$26(a1)
                move.w  #4,$20(a1)
                move.w  d6,$4A(a1)
                addi.w  #6,$4A(a1)
                move.w  d5,$4C(a1)
                addi.w  #-$20,d4
                addi.w  #$20,d5 ; ' '
                addq.w  #1,d6
                lea     $60(a0),a0
                lea     $60(a1),a1
                dbf     d7,loc_45F7C
locret_46014:                           ; CODE XREF: Boss_Epsilon1BattleSetup+A   j
                                        ; Boss_Epsilon1BattleSetup+14   j ...
                rts
; End of function Boss_Epsilon1BattleSetup
; Applies palette fade effect
Boss_Epsilon1ApplyPaletteFade:                              ; CODE XREF: Boss_Epsilon1IntroTransition   p  ; was: sub_46016
                                        ; sub_461A6   p ...
                move.w  #$E,d0
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_Epsilon1ApplyPaletteFade
; Intro transition with timer states
Boss_Epsilon1IntroTransition:                              ; DATA XREF: ROM:00045CF6   o  ; was: sub_46032
                bsr.w Boss_Epsilon1ApplyPaletteFade
                tst.w   (word_FFF720).w
                bmi.s   locret_46060
                subq.w  #1,$48(a5)
                bmi.s   loc_46056
                move.w  $48(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_46052(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_46052:      dc.w Gfx_LoadEpsilon1AllTiles-*        ; DATA XREF: Boss_Epsilon1IntroTransition+18   o
                dc.w Gfx_LoadEpsilon1CompressedTiles-*
; ---------------------------------------------------------------------------
loc_46056:                              ; CODE XREF: Boss_Epsilon1IntroTransition+E   j
                tst.w   (word_FFF720).w
                bmi.s   locret_46060
                addq.w  #2,4(a5)
locret_46060:                           ; CODE XREF: Boss_Epsilon1IntroTransition+8   j
                                        ; Boss_Epsilon1IntroTransition+28   j
                rts
; End of function Boss_Epsilon1IntroTransition
; Loads all four tile sets for Epsilon1 graphics
Gfx_LoadEpsilon1AllTiles:                              ; DATA XREF: Boss_Epsilon1IntroTransition:off_46052   o  ; was: sub_46062
                bsr.w Gfx_LoadEpsilon1Tiles4
                bsr.w Gfx_LoadEpsilon1Tiles3
                bsr.w Gfx_LoadEpsilon1Tiles2
                bsr.w Gfx_LoadEpsilon1Tiles1
                rts
; End of function Gfx_LoadEpsilon1AllTiles
; Loads compressed tile data for Epsilon1
Gfx_LoadEpsilon1CompressedTiles:                              ; DATA XREF: Boss_Epsilon1IntroTransition+22   o  ; was: sub_46074
                bsr.w Gfx_LoadEpsilon1TilesSet3
                bsr.w Gfx_LoadEpsilon1TilesSet1
                rts
; End of function Gfx_LoadEpsilon1CompressedTiles
; Loads compressed tiles set 1
Gfx_LoadEpsilon1Tiles1:                              ; CODE XREF: Gfx_LoadEpsilon1AllTiles+C   p  ; was: sub_4607E
                                        ; Boss_Epsilon1PhaseTransition+58   p
                lea     word_4608A(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles1
; ---------------------------------------------------------------------------
word_4608A:     dc.w $4130, $2000, $300, $A1A2, $A3A8
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles1   o


; Loads graphics for phase 2
Boss_Epsilon1LoadGraphicsPhase2:                              ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47A6C   p  ; was: sub_46094
                                        ; sub_47A0E:loc_47AC0   p
                lea     word_460A0(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase2
; ---------------------------------------------------------------------------
word_460A0:     dc.w $4130, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase2   o


; Loads compressed tiles set 2
Gfx_LoadEpsilon1Tiles2:                              ; CODE XREF: Gfx_LoadEpsilon1AllTiles+8   p  ; was: sub_460AA
                                        ; Boss_Epsilon1PhaseTransition+72   p
                lea     word_460B6(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles2
; ---------------------------------------------------------------------------
word_460B6:     dc.w $4330, $2000, $300, $A5A6, $A7AC
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles2   o


; Loads graphics for phase 3
Boss_Epsilon1LoadGraphicsPhase3:                              ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47A86   p  ; was: sub_460C0
                                        ; Boss_Epsilon1PhaseTransition+B6   p
                lea     word_460CC(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase3
; ---------------------------------------------------------------------------
word_460CC:     dc.w $4330, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase3   o


; Loads compressed tiles set 3
Gfx_LoadEpsilon1Tiles3:                              ; CODE XREF: Gfx_LoadEpsilon1AllTiles+4   p  ; was: sub_460D6
                                        ; Boss_Epsilon1PhaseTransition+8C   p
                lea     word_460E2(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles3
; ---------------------------------------------------------------------------
word_460E2:     dc.w $4530, $2000, $300, $A9AA, $ABAD
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles3   o


; Loads graphics for phase 4
Boss_Epsilon1LoadGraphicsPhase4:                              ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47AA0   p  ; was: sub_460EC
                                        ; Boss_Epsilon1PhaseTransition+BA   p
                lea     word_460F8(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase4
; ---------------------------------------------------------------------------
word_460F8:     dc.w $4530, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase4   o


; Loads compressed tiles set 4
Gfx_LoadEpsilon1Tiles4:                              ; CODE XREF: Gfx_LoadEpsilon1AllTiles   p  ; was: sub_46102
                                        ; Boss_Epsilon1PhaseTransition+A6   p
                lea     word_4610E(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1Tiles4
; ---------------------------------------------------------------------------
word_4610E:     dc.w $4730, $2000, $300, $AE, $AF00
                                        ; DATA XREF: Gfx_LoadEpsilon1Tiles4   o


; Loads graphics for phase 5
Boss_Epsilon1LoadGraphicsPhase5:                              ; CODE XREF: Boss_Epsilon1PhaseTransition:loc_47ABA   p  ; was: sub_46118
                                        ; Boss_Epsilon1PhaseTransition+BE   p
                lea     word_46124(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_Epsilon1LoadGraphicsPhase5
; ---------------------------------------------------------------------------
word_46124:     dc.w $4730, $2000, $300, 0, 0
                                        ; DATA XREF: Boss_Epsilon1LoadGraphicsPhase5   o


; Loads first compressed tile set to VRAM
Gfx_LoadEpsilon1TilesSet1:                              ; CODE XREF: Gfx_LoadEpsilon1CompressedTiles+4   p  ; was: sub_4612E
                lea     word_4613A(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet1
; ---------------------------------------------------------------------------
word_4613A:     dc.w $4180, $2000, $501, $9A9A, $9A9A, $9A9A, $9E9E, $9E9E, $9E9E
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet1   o


; Loads second compressed tile set
Gfx_LoadEpsilon1TilesSet2:
                lea     word_46158(pc),a0  ; was: sub_4614C
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet2
; ---------------------------------------------------------------------------
word_46158:     dc.w $4180, $2000, $501, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet2   o


; Loads third compressed tile set
Gfx_LoadEpsilon1TilesSet3:                              ; CODE XREF: Gfx_LoadEpsilon1CompressedTiles   p  ; was: sub_4616A
                lea     word_46176(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet3
; ---------------------------------------------------------------------------
word_46176:     dc.w $41D0, $2000, $501, $9A9A, $9A9A, $9A9A, $9E9E, $9E9E, $9E9E
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet3   o


; Loads fourth compressed tile set
Gfx_LoadEpsilon1TilesSet4:
                lea     word_46194(pc),a0  ; was: sub_46188
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Gfx_LoadEpsilon1TilesSet4
; ---------------------------------------------------------------------------
word_46194:     dc.w $41D0, $2000, $501, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_LoadEpsilon1TilesSet4   o


; Attack phase 1 initialization
Boss_Epsilon1AttackPhase1Init:                              ; DATA XREF: ROM:00045CF8   o  ; was: sub_461A6
                bsr.w Boss_Epsilon1ApplyPaletteFade
                move.w  #$20,$48(a5) ; ' '
                move.b  #$21,(byte_FFA95A).w ; '!'
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1AttackPhase1Init
; Sets up rotation parameters
Boss_Epsilon1RotationSetup:                              ; DATA XREF: ROM:00045CFA   o  ; was: sub_461BC
                bsr.w Boss_Epsilon1ApplyPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_461DC
                move.w  #4,(dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #$E,$48(a5)
                addq.w  #2,4(a5)
locret_461DC:                           ; CODE XREF: Boss_Epsilon1RotationSetup+8   j
                rts
; End of function Boss_Epsilon1RotationSetup
; Debug mode directional control for positioning
Boss_Epsilon1DebugControl:
                btst    #5,(word_FFF706).w  ; was: sub_461DE
                beq.s   locret_46216
                btst    #2,(word_FFF706).w
                beq.s   loc_461F2
                subq.w  #2,(dword_FFC690).w
loc_461F2:                              ; CODE XREF: Boss_Epsilon1DebugControl+E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_461FE
                addq.w  #2,(dword_FFC690).w
loc_461FE:                              ; CODE XREF: Boss_Epsilon1DebugControl+1A   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4620A
                subq.w  #2,(dword_FFC694).w
loc_4620A:                              ; CODE XREF: Boss_Epsilon1DebugControl+26   j
                btst    #1,(word_FFF706).w
                beq.s   locret_46216
                addq.w  #2,(dword_FFC694).w
locret_46216:                           ; CODE XREF: Boss_Epsilon1DebugControl+6   j
                                        ; Boss_Epsilon1DebugControl+32   j
                rts
; End of function Boss_Epsilon1DebugControl
; Palette fade with button check
Boss_Epsilon1FadeWithButtonCheck:                              ; DATA XREF: ROM:00045CFC   o  ; was: sub_46218
                move.w  $48(a5),d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                movea.w #(word_FFE300-M68K_RAM),a0
                jsr (Gfx_ApplyPaletteFade).l
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46248
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46248
                subq.w  #1,$48(a5)
                bge.s   locret_46248
                addq.w  #2,4(a5)
locret_46248:                           ; CODE XREF: Boss_Epsilon1FadeWithButtonCheck+1C   j
                                        ; Boss_Epsilon1FadeWithButtonCheck+24   j ...
                rts
; End of function Boss_Epsilon1FadeWithButtonCheck
; Checks victory condition
Boss_Epsilon1VictoryCheck:                              ; DATA XREF: ROM:00045CFE   o  ; was: sub_4624A
                move.w  #3,d0
                jsr (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                move.b  #$8D,d0
                jsr (Sys_WaitVBlank).l
                rts
; End of function Boss_Epsilon1VictoryCheck
; Attack state 1 handler
Boss_Epsilon1AttackState1:                              ; DATA XREF: ROM:00045D00   o  ; was: sub_46264
                tst.w   (word_FF80C2).w
                bne.s   locret_46278
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                move.w  #$40,$48(a5) ; '@'
locret_46278:                           ; CODE XREF: Boss_Epsilon1AttackState1+4   j
                rts
; End of function Boss_Epsilon1AttackState1
; Attack state 2 handler
Boss_Epsilon1AttackState2:                              ; DATA XREF: ROM:00045D02   o  ; was: sub_4627A
                clr.l   (dword_FFC698).w
                tst.w   (word_FFC7A4).w
                bne.s   locret_462AA
                tst.w   (word_FF9474).w
                bne.s   loc_462A4
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                beq.s   loc_4629C
                move.w  #$14,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4629C:                              ; CODE XREF: Boss_Epsilon1AttackState2+18   j
                move.w  #$26,4(a5) ; '&'
                rts
; ---------------------------------------------------------------------------
loc_462A4:                              ; CODE XREF: Boss_Epsilon1AttackState2+E   j
                move.w  #$32,4(a5) ; '2'
locret_462AA:                           ; CODE XREF: Boss_Epsilon1AttackState2+8   j
                rts
; End of function Boss_Epsilon1AttackState2
; Initializes first attack phase with projectile ring
Boss_Epsilon1AttackPhase1Setup:                              ; DATA XREF: ROM:00045D04   o  ; was: sub_462AC
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1AttackPhase1Setup
; Waits for timer before advancing phase
Boss_Epsilon1AttackPhase2Wait:                              ; DATA XREF: ROM:00045D06   o  ; was: sub_462BC
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0 ; '`'
                bcc.s   locret_462D2
                addq.w  #2,4(a5)
locret_462D2:                           ; CODE XREF: Boss_Epsilon1AttackPhase2Wait+10   j
                rts
; End of function Boss_Epsilon1AttackPhase2Wait
; Sets up third attack phase with scaling
Boss_Epsilon1AttackPhase3Setup:                              ; DATA XREF: ROM:00045D08   o  ; was: sub_462D4
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_462FA
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_462FA:                           ; CODE XREF: Boss_Epsilon1AttackPhase3Setup+10   j
                rts
; End of function Boss_Epsilon1AttackPhase3Setup
; Handles boss scaling animation
Boss_Epsilon1AttackPhase4Scale:                              ; DATA XREF: ROM:00045D0A   o  ; was: sub_462FC
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_4631E
                clr.l   (dword_FFC69C).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_4631E:                           ; CODE XREF: Boss_Epsilon1AttackPhase4Scale+C   j
                rts
; End of function Boss_Epsilon1AttackPhase4Scale
; Initializes fifth attack phase
Boss_Epsilon1AttackPhase5Init:                              ; DATA XREF: ROM:00045D0C   o  ; was: sub_46320
                tst.w   (word_FFC7A4).w
                bne.s   locret_46336
                move.w  #0,(word_FFC7FE).w
                nop
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_46336:                           ; CODE XREF: Boss_Epsilon1AttackPhase5Init+4   j
                rts
; End of function Boss_Epsilon1AttackPhase5Init
; Spawns projectile rings and waits
Boss_Epsilon1AttackPhase6RingWait:                              ; DATA XREF: ROM:00045D0E   o  ; was: sub_46338
                bsr.w Boss_Epsilon1SpawnProjectileRing
                cmpi.w  #$A,(word_FFC7A4).w
                bne.s   locret_4634C
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_4634C:                           ; CODE XREF: Boss_Epsilon1AttackPhase6RingWait+A   j
                rts
; End of function Boss_Epsilon1AttackPhase6RingWait
; Spawns special entity during attack
Boss_Epsilon1AttackPhase7SpawnEntity:                              ; DATA XREF: ROM:00045D10   o  ; was: sub_4634E
                bsr.w Boss_Epsilon1SpawnProjectileRing
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_46366
                move.w  #$10,(a0)
                move.w  a0,(dword_FF941C).w
                addq.w  #2,4(a5)
locret_46366:                           ; CODE XREF: Boss_Epsilon1AttackPhase7SpawnEntity+A   j
                rts
; End of function Boss_Epsilon1AttackPhase7SpawnEntity
; Spawns projectile ring and updates trajectory
Boss_Epsilon1ProjectileRingAndUpdate:                              ; DATA XREF: ROM:00045D12   o  ; was: sub_46368
                bsr.w Boss_Epsilon1SpawnProjectileRing
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_46380
                move.w  #$10,(a0)
                move.w  a0,(dword_FF941C+2).w
                addq.w  #2,4(a5)
locret_46380:                           ; CODE XREF: Boss_Epsilon1ProjectileRingAndUpdate+A   j
                rts
; End of function Boss_Epsilon1ProjectileRingAndUpdate
; Calculates angle and spawns dual spread projectiles
Boss_Epsilon1DualProjectileAim:                              ; DATA XREF: ROM:00045D14   o  ; was: sub_46382
                movea.w (dword_FF9420).w,a0
                move.w  $10(a0),d0
                move.w  $14(a0),d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  $10(a5),d0
                addq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C).w,a0
                bsr.s Projectile_Epsilon1SpreadSetup
                move.w  $10(a5),d0
                subq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C+2).w,a0
                bsr.s Projectile_Epsilon1SpreadSetup
                tst.w   (word_FFC7A4).w
                beq.s   loc_463CA
                move.w  #$1E,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_463CA:                              ; CODE XREF: Boss_Epsilon1DualProjectileAim+3E   j
                move.w  #$12,4(a5)
                rts
; End of function Boss_Epsilon1DualProjectileAim
; Defeat sequence initialization
Boss_Epsilon1DefeatInit:                              ; CODE XREF: Projectile_Epsilon1WaveUpdate+30   p  ; was: sub_463D2
                                        ; Projectile_Epsilon1WaveUpdate+46   p
                move.l  #Projectile_Epsilon1SpreadInit,$48(a0)
                bra.s   loc_463E4
; End of function Boss_Epsilon1DefeatInit
; Initializes spread projectile with trajectory data
Projectile_Epsilon1SpreadSetup:                              ; CODE XREF: Boss_Epsilon1DualProjectileAim+28   p  ; was: sub_463DC
                                        ; Boss_Epsilon1DualProjectileAim+38   p
                move.l  #Projectile_Epsilon1SpreadExpanding,$48(a0)
loc_463E4:                              ; CODE XREF: Boss_Epsilon1DefeatInit+8   j
                move.l  (dword_FFC69C).w,$1C(a0)
                move.w  d2,$58(a0)
                move.w  #$268,(a0)
                move.l  #dword_2ADC8,$54(a0)
                move.w  #$8C80,2(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Projectile_Epsilon1SpreadSetup
; Spawns projectile type 1
Boss_Epsilon1SpawnProjectile1:                              ; DATA XREF: ROM:00045D16   o  ; was: sub_4640A
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1SpawnProjectile1
; Spawns projectile type 2
Boss_Epsilon1SpawnProjectile2:                              ; DATA XREF: ROM:00045D18   o  ; was: sub_4641A
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0 ; '`'
                bcc.s   locret_46430
                addq.w  #2,4(a5)
locret_46430:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile2+10   j
                rts
; End of function Boss_Epsilon1SpawnProjectile2
; Spawns projectile type 3
Boss_Epsilon1SpawnProjectile3:                              ; DATA XREF: ROM:00045D1A   o  ; was: sub_46432
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_46458
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_46458:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile3+10   j
                rts
; End of function Boss_Epsilon1SpawnProjectile3
; Spawns projectile type 4
Boss_Epsilon1SpawnProjectile4:                              ; DATA XREF: ROM:00045D1C   o  ; was: sub_4645A
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_4647C
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_4647C:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile4+C   j
                rts
; End of function Boss_Epsilon1SpawnProjectile4
; Spawns projectile type 5
Boss_Epsilon1SpawnProjectile5:                              ; DATA XREF: ROM:00045D1E   o  ; was: sub_4647E
                tst.w   (word_FFC7A4).w
                bne.s   locret_46494
                move.w  #1,(word_FFC7FE).w
                nop
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_46494:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile5+4   j
                rts
; End of function Boss_Epsilon1SpawnProjectile5
; Attack pattern 1 with spawn
Boss_Epsilon1AttackPattern1:                              ; DATA XREF: ROM:00045D20   o  ; was: sub_46496
                bsr.w Boss_Epsilon1SpawnProjectileRing
                cmpi.w  #$C,(word_FFC7A4).w
                bne.s   locret_464AC
                addq.w  #2,(word_FFC7A4).w
                move.w  #$12,4(a5)
locret_464AC:                           ; CODE XREF: Boss_Epsilon1AttackPattern1+A   j
                rts
; End of function Boss_Epsilon1AttackPattern1
; Projectile type 1 main handler
Projectile_Epsilon1Type1Main:                              ; DATA XREF: ROM:00045D22   o  ; was: sub_464AE
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  #8,(dword_FF9410).w
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Epsilon1Type1Main
; Projectile type 2 main handler
Projectile_Epsilon1Type2Main:                              ; DATA XREF: ROM:00045D24   o  ; was: sub_464BE
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$60,d0 ; '`'
                bcc.s   locret_464D4
                addq.w  #2,4(a5)
locret_464D4:                           ; CODE XREF: Projectile_Epsilon1Type2Main+10   j
                rts
; End of function Projectile_Epsilon1Type2Main
; Projectile type 3 main handler
Projectile_Epsilon1Type3Main:                              ; DATA XREF: ROM:00045D26   o  ; was: sub_464D6
                bsr.w Boss_Epsilon1SpawnProjectileRing
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FF,d0
                cmpi.w  #$80,d0
                bcs.s   locret_464FC
                clr.w   (dword_FF9410).w
                move.w  #4,(dword_FF9414+2).w
                move.w  #1,(dword_FFC69C).w
                addq.w  #2,4(a5)
locret_464FC:                           ; CODE XREF: Projectile_Epsilon1Type3Main+10   j
                rts
; End of function Projectile_Epsilon1Type3Main
; Projectile type 4 main handler
Projectile_Epsilon1Type4Main:                              ; DATA XREF: ROM:00045D28   o  ; was: sub_464FE
                addi.l  #-$400,(dword_FFC69C).w
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_4652C
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$10,(dword_FF9410).w
                move.w  #0,$58(a5)
                bset    #4,$23(a5)
                addq.w  #2,4(a5)
locret_4652C:                           ; CODE XREF: Projectile_Epsilon1Type4Main+C   j
                rts
; End of function Projectile_Epsilon1Type4Main
; Projectile type 5 main handler
Projectile_Epsilon1Type5Main:                              ; DATA XREF: ROM:00045D2A   o  ; was: sub_4652E
                bsr.w Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w ; '@'
                bgt.s   locret_4655E
                clr.l   (dword_FFC69C).w
                move.l  #$400000,(dword_FFC694).w
                move.w  #$60,(dword_FF9414).w ; '`'
                move.w  #7,(dword_FF9414+2).w
                clr.w   (dword_FF9410).w
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4655E:                           ; CODE XREF: Projectile_Epsilon1Type5Main+A   j
                rts
; End of function Projectile_Epsilon1Type5Main
; Homing projectile initialization
Projectile_Epsilon1HomingInit:                              ; DATA XREF: ROM:00045D2C   o  ; was: sub_46560
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_4658E
                move.w  #$10,(a0)
                lea     (dword_FF941C).w,a1
                move.w  $48(a5),d0
                add.w   d0,d0
                move.w  a0,(a1,d0.w)
                addq.w  #1,$48(a5)
                cmpi.w  #2,$48(a5)
                bne.s   locret_4658E
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4658E:                           ; CODE XREF: Projectile_Epsilon1HomingInit+6   j
                                        ; Projectile_Epsilon1HomingInit+24   j
                rts
; End of function Projectile_Epsilon1HomingInit
; Homing projectile tracking update
Projectile_Epsilon1HomingUpdate:                              ; DATA XREF: ROM:00045D2E   o  ; was: sub_46590
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_465DE
                move.w  $48(a5),d0
                add.w   d0,d0
                lea     word_46616(pc),a1
                nop
                movea.w (a1,d0.w),a1
                move.w  a0,$4E(a1)
                move.w  #$10,(a0)
                move.w  #$CC0,2(a0)
                move.w  #$4300,$E(a0)
                move.w  #$700,8(a0)
                move.w  #$F8F0,$A(a0)
                move.w  #4,$20(a0)
                addq.w  #1,$48(a5)
                cmpi.w  #$C,$48(a5)
                bne.s   locret_465DE
                addq.w  #2,4(a5)
locret_465DE:                           ; CODE XREF: Projectile_Epsilon1HomingUpdate+6   j
                                        ; Projectile_Epsilon1HomingUpdate+48   j
                rts
; End of function Projectile_Epsilon1HomingUpdate
; Spiral projectile initialization
Projectile_Epsilon1SpiralInit:                              ; DATA XREF: ROM:00045D30   o  ; was: sub_465E0
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a2
                nop
loc_465EC:                              ; CODE XREF: Projectile_Epsilon1SpiralInit+26   j
                movea.w (a2,d0.w),a0
                movea.w $C(a2,d0.w),a1
                tst.w   4(a0)
                bne.w   locret_46614
                tst.w   4(a1)
                bne.w   locret_46614
                addq.w  #2,d0
                dbf     d7,loc_465EC
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
locret_46614:                           ; CODE XREF: Projectile_Epsilon1SpiralInit+18   j
                                        ; Projectile_Epsilon1SpiralInit+20   j
                rts
; End of function Projectile_Epsilon1SpiralInit
; ---------------------------------------------------------------------------
word_46616:     dc.w $C800, $C860, $C8C0, $C920, $C980, $C9E0, $CA40, $CAA0, $CB00, $CB60, $CBC0, $CC20
                                        ; DATA XREF: Projectile_Epsilon1HomingUpdate+E   o
                                        ; Projectile_Epsilon1SpiralInit+6   o ...


; Spiral projectile movement
Projectile_Epsilon1SpiralUpdate:                              ; DATA XREF: ROM:00045D32   o  ; was: sub_4662E
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_46672
                addq.w  #2,4(a5)
                move.l  #$20000,(dword_FFC69C).w
                move.l  #$4000,(dword_FF9478).w
                move.w  #$120,(dword_FFC690).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   locret_46672
                cmpi.w  #1,d0
                beq.s   locret_46672
                cmpi.w  #2,d0
                beq.s   loc_4666C
                addi.w  #-$40,(dword_FFC690).w
                bra.s   locret_46672
; ---------------------------------------------------------------------------
loc_4666C:                              ; CODE XREF: Projectile_Epsilon1SpiralUpdate+34   j
                addi.w  #$40,(dword_FFC690).w ; '@'
locret_46672:                           ; CODE XREF: Projectile_Epsilon1SpiralUpdate+4   j
                                        ; Projectile_Epsilon1SpiralUpdate+28   j ...
                rts
; End of function Projectile_Epsilon1SpiralUpdate
; Attack pattern 2 with timing
Boss_Epsilon1AttackPattern2:                              ; CODE XREF: Boss_Epsilon1AttackPhase4Scale+8   p  ; was: sub_46674
                                        ; Boss_Epsilon1SpawnProjectile4+8   p ...
                move.w  (dword_FF9414).w,d0
                andi.w  #$1FE,d0
                lea     (dword_FF9400).w,a0
                move.w  #5,d7
loc_46684:                              ; CODE XREF: Boss_Epsilon1AttackPattern2+14   j
                cmp.w   (a0)+,d0
                bne.s   loc_4668C
                dbf     d7,loc_46684
loc_4668C:                              ; CODE XREF: Boss_Epsilon1AttackPattern2+12   j
                addq.w  #1,d7
                move.w  d7,d0
                rts
; End of function Boss_Epsilon1AttackPattern2
; Wave projectile initialization
Projectile_Epsilon1WaveInit:                              ; CODE XREF: Projectile_Epsilon1WaveUpdate   p  ; was: sub_46692
                                        ; Projectile_Epsilon1BounceInit+A   p ...
                move.l  (dword_FF9478).w,d0
                add.l   d0,(dword_FFC69C).w
                rts
; End of function Projectile_Epsilon1WaveInit
; Wave projectile sine movement
Projectile_Epsilon1WaveUpdate:                              ; DATA XREF: ROM:00045D34   o  ; was: sub_4669C
                bsr.s Projectile_Epsilon1WaveInit
                cmpi.w  #$90,(dword_FFC694).w
                bcs.s   locret_4670E
                bclr    #4,$23(a5)
                move.l  #$FFFFC000,(dword_FF9478).w
                move.w  #6,(dword_FF9410).w
                move.w  $10(a5),d0
                addq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C).w,a0
                move.w  #$7C,d2 ; '|'
                bsr.w Boss_Epsilon1DefeatInit
                move.w  $10(a5),d0
                subq.w  #8,d0
                move.w  $14(a5),d1
                movea.w (dword_FF941C+2).w,a0
                move.w  #$84,d2
                bsr.w Boss_Epsilon1DefeatInit
                clr.w   $48(a5)
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a2
loc_466F4:                              ; CODE XREF: Projectile_Epsilon1WaveUpdate+6A   j
                movea.w (a2,d0.w),a0
                movea.w $C(a2,d0.w),a1
                addq.w  #2,4(a0)
                addq.w  #2,4(a1)
                addq.w  #2,d0
                dbf     d7,loc_466F4
                addq.w  #2,4(a5)
locret_4670E:                           ; CODE XREF: Projectile_Epsilon1WaveUpdate+8   j
                rts
; End of function Projectile_Epsilon1WaveUpdate
; Bounce projectile initialization
Projectile_Epsilon1BounceInit:                              ; DATA XREF: ROM:00045D36   o  ; was: sub_46710
                cmpi.l  #$FFFE0000,(dword_FFC69C).w
                blt.s   loc_4671E
                bsr.w Projectile_Epsilon1WaveInit
loc_4671E:                              ; CODE XREF: Projectile_Epsilon1BounceInit+8   j
                cmpi.w  #$180,(dword_FF9414).w
                bcs.s   locret_4673C
                move.w  #6,(dword_FF9414+2).w
                clr.w   (dword_FF9410).w
                move.l  #$800,(dword_FF9478).w
                addq.w  #2,4(a5)
locret_4673C:                           ; CODE XREF: Projectile_Epsilon1BounceInit+14   j
                rts
; End of function Projectile_Epsilon1BounceInit
; Bounce projectile physics
Projectile_Epsilon1BounceUpdate:                              ; DATA XREF: ROM:00045D38   o  ; was: sub_4673E
                bsr.w Projectile_Epsilon1WaveInit
                clr.w   d0
                move.w  #5,d7
                lea     word_46616(pc),a0
loc_4674C:                              ; CODE XREF: Projectile_Epsilon1BounceUpdate+24   j
                movea.w (a0,d0.w),a1
                movea.w $C(a0,d0.w),a2
                tst.w   4(a1)
                bne.s   locret_4676A
                tst.w   4(a2)
                bne.s   locret_4676A
                addq.w  #2,d0
                dbf     d7,loc_4674C
                addq.w  #2,4(a5)
locret_4676A:                           ; CODE XREF: Projectile_Epsilon1BounceUpdate+1A   j
                                        ; Projectile_Epsilon1BounceUpdate+20   j
                rts
; End of function Projectile_Epsilon1BounceUpdate
; Laser projectile initialization
Projectile_Epsilon1LaserInit:                              ; DATA XREF: ROM:00045D3A   o  ; was: sub_4676C
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_4679A
                clr.l   (dword_FFC69C).w
                move.w  #1,(dword_FF9414+2).w
                move.w  #$10,(dword_FF9410).w
                move.w  #0,$58(a5)
                move.l  #$3000,(dword_FF9478).w
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_4679A:                           ; CODE XREF: Projectile_Epsilon1LaserInit+4   j
                rts
; End of function Projectile_Epsilon1LaserInit
; Laser projectile beam update
Projectile_Epsilon1LaserUpdate:                              ; DATA XREF: ROM:00045D3C   o  ; was: sub_4679C
                tst.w   $48(a5)
                bmi.s   loc_467B0
                bsr.w Projectile_Epsilon1WaveInit
                subq.w  #1,$48(a5)
                bpl.s   loc_467B0
                clr.l   (dword_FFC69C).w
loc_467B0:                              ; CODE XREF: Projectile_Epsilon1LaserUpdate+4   j
                                        ; Projectile_Epsilon1LaserUpdate+E   j
                bsr.w Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w ; '@'
                bgt.s   locret_467D6
                move.w  #4,(dword_FF9414+2).w
                move.w  #4,(dword_FF9410).w
                clr.w   (word_FF9474).w
                clr.w   (word_FF9472).w
                move.w  #$12,4(a5)
locret_467D6:                           ; CODE XREF: Projectile_Epsilon1LaserUpdate+1E   j
                rts
; End of function Projectile_Epsilon1LaserUpdate
; Clears projectile pointers and initializes scrolling
Boss_Epsilon1ResetScrollingPhase:                              ; DATA XREF: ROM:00045D3E   o  ; was: sub_467D8
                clr.w   (dword_FF9410).w
                move.w  #0,(dword_FF9414+2).w
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,(dword_FFC69C).w
                bclr    #0,(byte_FF8308).w
                bne.s   loc_467FE
                move.w  #6,(dword_FFC698).w
                rts
; ---------------------------------------------------------------------------
loc_467FE:                              ; CODE XREF: Boss_Epsilon1ResetScrollingPhase+1C   j
                move.w  #$FFFA,(dword_FFC698).w
                rts
; End of function Boss_Epsilon1ResetScrollingPhase
; Executes attack pattern 2 and advances phase
Boss_Epsilon1AttackPattern2Transition:                              ; DATA XREF: ROM:00045D40   o  ; was: sub_46806
                bsr.w Boss_Epsilon1AttackPattern2
                bne.s   locret_46816
                move.w  #$14,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_46816:                           ; CODE XREF: Boss_Epsilon1AttackPattern2Transition+4   j
                rts
; End of function Boss_Epsilon1AttackPattern2Transition
; Checks Y position bounds and reverses velocity
Boss_Epsilon1BoundsCheckReverse:                              ; DATA XREF: ROM:00045D42   o  ; was: sub_46818
                cmpi.w  #$180,$4E(a5)
                bhi.s   loc_4682A
                cmpi.w  #$C0,$4E(a5)
                bcs.s   loc_4682A
                rts
; ---------------------------------------------------------------------------
loc_4682A:                              ; CODE XREF: Boss_Epsilon1BoundsCheckReverse+6   j
                                        ; Boss_Epsilon1BoundsCheckReverse+E   j
                move.w  #8,(word_FFA010).w
                move.l  (dword_FFC698).w,d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,(dword_FFC698).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1BoundsCheckReverse
; Accelerates scrolling until threshold reached
Boss_Epsilon1ScrollAccelerationPhase:                              ; DATA XREF: ROM:00045D44   o  ; was: sub_46842
                addi.l  #$2000,(dword_FFC69C).w
                cmpi.w  #$100,(dword_FFC694).w
                bcs.s   locret_46864
                clr.l   (dword_FFC69C).w
                clr.l   (dword_FFC698).w
                move.w  #$60,$48(a5) ; '`'
                addq.w  #2,4(a5)
locret_46864:                           ; CODE XREF: Boss_Epsilon1ScrollAccelerationPhase+E   j
                rts
; End of function Boss_Epsilon1ScrollAccelerationPhase
; Delays for timer countdown then advances phase
Boss_Epsilon1DelayTimer:                              ; DATA XREF: ROM:00045D46   o  ; was: sub_46866
                subq.w  #1,$48(a5)
                bne.s   locret_46876
                move.w  #0,$58(a5)
                addq.w  #2,4(a5)
locret_46876:                           ; CODE XREF: Boss_Epsilon1DelayTimer+4   j
                rts
; End of function Boss_Epsilon1DelayTimer
; Advances when boss health drops below 64
Boss_Epsilon1WaitForLowHealth:                              ; DATA XREF: ROM:00045D48   o  ; was: sub_46878
                bsr.w Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w ; '@'
                bcc.w   locret_4688A
                addq.w  #2,4(a5)
locret_4688A:                           ; CODE XREF: Boss_Epsilon1WaitForLowHealth+A   j
                rts
; End of function Boss_Epsilon1WaitForLowHealth
; Clears bit flags and returns to phase 18
Boss_Epsilon1ClearPhaseFlags:                              ; DATA XREF: ROM:00045D4A   o  ; was: sub_4688C
                bclr    #2,(byte_FF8308).w
                bclr    #2,$4C(a5)
                move.w  #$12,4(a5)
                rts
; End of function Boss_Epsilon1ClearPhaseFlags
; Defeat explosion effect 1
Boss_Epsilon1DefeatExplosion1:                              ; DATA XREF: ROM:00045D4C   o  ; was: sub_468A0
                clr.b   $21(a5)
                clr.b   (byte_FFC701).w
                clr.b   (byte_FFC761).w
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.b  #1,(byte_FF830E).w
                rts
; End of function Boss_Epsilon1DefeatExplosion1
; Defeat explosion effect 2
Boss_Epsilon1DefeatExplosion2:                              ; DATA XREF: ROM:00045D4E   o  ; was: sub_468BE
                subq.w  #1,$48(a5)
                bpl.s   locret_46910
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w #(word_FFC740-M68K_RAM),a1
                cmpi.w  #6,4(a0)
                bne.s   locret_46910
                cmpi.w  #6,4(a1)
                bne.s   locret_46910
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                move.w  d0,$48(a0)
                addq.w  #2,4(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$7F,d0
                move.w  d0,$48(a1)
                addq.w  #2,4(a1)
                addq.w  #2,4(a5)
                move.b  #$52,d0 ; 'R'
                jsr (Sound_PlaySFX).l
                move.w  #$40,$48(a5) ; '@'
locret_46910:                           ; CODE XREF: Boss_Epsilon1DefeatExplosion2+4   j
                                        ; Boss_Epsilon1DefeatExplosion2+14   j ...
                rts
; End of function Boss_Epsilon1DefeatExplosion2
; Defeat explosion effect 3
Boss_Epsilon1DefeatExplosion3:                              ; DATA XREF: ROM:00045D50   o  ; was: sub_46912
                subq.w  #1,$48(a5)
                bpl.w   locret_46962
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$148,$14(a5)
                bgt.s   loc_46964
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_46962
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_46962
                jsr (Projectile_InitType88).l
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFF,$1C(a0)
                move.b  $20(a5),$20(a0)
locret_46962:                           ; CODE XREF: Boss_Epsilon1DefeatExplosion3+4   j
                                        ; Boss_Epsilon1DefeatExplosion3+20   j ...
                rts
; ---------------------------------------------------------------------------
loc_46964:                              ; CODE XREF: Boss_Epsilon1DefeatExplosion3+16   j
                move.l  #$1400000,$14(a5)
                clr.l   $1C(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
                move.b  #$AC,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Boss_Epsilon1DefeatExplosion3
; Screen shake during defeat
Boss_Epsilon1DefeatShake:                              ; DATA XREF: ROM:00045D52   o  ; was: sub_46986
                subq.w  #1,$48(a5)
                bpl.s   locret_469AE
                move.l  #off_E953C,8(a5)
                move.w  #$480,$E(a5)
                move.w  #$EC80,2(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
                jsr (Projectile_ExplodeOnImpact).l
locret_469AE:                           ; CODE XREF: Boss_Epsilon1DefeatShake+4   j
                rts
; End of function Boss_Epsilon1DefeatShake
; Fade out during defeat
Boss_Epsilon1DefeatFade:                              ; DATA XREF: ROM:00045D54   o  ; was: sub_469B0
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_469D4
                move.w  #$C80,2(a5)
                move.w  (dword_FFC694).w,d0
                addi.w  #$10,d0
                move.w  d0,$14(a5)
                move.w  (dword_FFC690).w,$10(a5)
                addq.w  #2,4(a5)
locret_469D4:                           ; CODE XREF: Boss_Epsilon1DefeatFade+6   j
                rts
; End of function Boss_Epsilon1DefeatFade
; Flash effect during defeat
Boss_Epsilon1DefeatFlash:                              ; DATA XREF: ROM:00045D56   o  ; was: sub_469D6
                move.w  #5,$4A(a5)
                addq.w  #2,4(a5)
; Palette fade loop during defeat flash sequence
Boss_Epsilon1Defeat_FlashLoop:                              ; DATA XREF: ROM:00045D58   o  ; was: loc_469E0
                jsr (Gfx_UpdatePaletteFade).l
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     word_46A1E(pc),a0
                nop
                movea.w (a0,d0.w),a1
                movea.w $C(a0,d0.w),a2
                cmpi.w  #$C,4(a1)
                bne.s   locret_46A1C
                cmpi.w  #$C,4(a2)
                bne.s   locret_46A1C
                addq.w  #2,4(a1)
                addq.w  #2,4(a2)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_46A1C:                           ; CODE XREF: Boss_Epsilon1DefeatFlash+2A   j
                                        ; Boss_Epsilon1DefeatFlash+32   j
                rts
; End of function Boss_Epsilon1DefeatFlash
; ---------------------------------------------------------------------------
word_46A1E:     dc.w $C800, $C860, $C8C0, $C920, $C980, $C9E0, $CA40, $CAA0, $CB00, $CB60, $CBC0, $CC20
                                        ; DATA XREF: Boss_Epsilon1DefeatFlash+16   o
                                        ; Boss_Epsilon1PartDamageFlash+6   o


; Boss breakup animation
Boss_Epsilon1DefeatBreakup:                              ; DATA XREF: ROM:00045D5A   o  ; was: sub_46A36
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_46A52
                subq.w  #1,$4A(a5)
                bmi.s   loc_46A4E
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_46A4E:                              ; CODE XREF: Boss_Epsilon1DefeatBreakup+10   j
                addq.w  #2,4(a5)
locret_46A52:                           ; CODE XREF: Boss_Epsilon1DefeatBreakup+A   j
                rts
; End of function Boss_Epsilon1DefeatBreakup
; Part damage flash effect
Boss_Epsilon1PartDamageFlash:                              ; DATA XREF: ROM:00045D5C   o  ; was: sub_46A54
                jsr (Gfx_UpdatePaletteFade).l
                lea     word_46A1E(pc),a0
                movea.w (a0),a1
                movea.w $C(a0),a2
                cmpi.w  #$12,4(a1)
                bne.s   locret_46A7E
                cmpi.w  #$12,4(a2)
                bne.s   locret_46A7E
                move.w  #$C0,$48(a5)
                addq.w  #2,4(a5)
locret_46A7E:                           ; CODE XREF: Boss_Epsilon1PartDamageFlash+16   j
                                        ; Boss_Epsilon1PartDamageFlash+1E   j
                rts
; End of function Boss_Epsilon1PartDamageFlash
; Part invulnerability state
Boss_Epsilon1PartInvulnerable:                              ; DATA XREF: ROM:00045D5E   o  ; was: sub_46A80
                jsr (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_46A90
                addq.w  #2,4(a5)
locret_46A90:                           ; CODE XREF: Boss_Epsilon1PartInvulnerable+A   j
                rts
; End of function Boss_Epsilon1PartInvulnerable
; Checks if core is vulnerable
Boss_Epsilon1CoreVulnerableCheck:                              ; DATA XREF: ROM:00045D60   o  ; was: sub_46A92
                jsr (Boss_SpawnExplosionDebris).l
                bsr.s Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46ABA
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46ABA
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_46ABA
                addq.w  #2,4(a5)
locret_46ABA:                           ; CODE XREF: Boss_Epsilon1CoreVulnerableCheck+E   j
                                        ; Boss_Epsilon1CoreVulnerableCheck+16   j ...
                rts
; End of function Boss_Epsilon1CoreVulnerableCheck
; Updates health bar display
Boss_Epsilon1UpdateHealthDisplay:                              ; CODE XREF: Boss_Epsilon1BattleSetup   p  ; was: sub_46ABC
                                        ; Boss_Epsilon1CoreVulnerableCheck+6   p ...
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5 ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_Epsilon1UpdateHealthDisplay
; Damage flash animation
Boss_Epsilon1DamageFlash:                              ; DATA XREF: ROM:00045D62   o  ; was: sub_46AD8
                bsr.s Boss_Epsilon1UpdateHealthDisplay
                tst.b   (word_FFF720).w
                bmi.s   locret_46AF0
                move.w  #$264,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                addq.w  #2,4(a5)
locret_46AF0:                           ; CODE XREF: Boss_Epsilon1DamageFlash+6   j
                rts
; End of function Boss_Epsilon1DamageFlash
; Health bar color calculation
Boss_Epsilon1HealthBarColor:                              ; DATA XREF: ROM:00045D64   o  ; was: sub_46AF2
                bsr.w Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46B10
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46B10
                subq.w  #1,$48(a5)
                bne.s   locret_46B10
                addq.w  #2,4(a5)
locret_46B10:                           ; CODE XREF: Boss_Epsilon1HealthBarColor+A   j
                                        ; Boss_Epsilon1HealthBarColor+12   j ...
                rts
; End of function Boss_Epsilon1HealthBarColor
; Checks if part has shield
Boss_Epsilon1PartShieldCheck:                              ; DATA XREF: ROM:00045D66   o  ; was: sub_46B12
                tst.b   (word_FFF720).w
                bmi.s   locret_46B1C
                addq.w  #2,4(a5)
locret_46B1C:                           ; CODE XREF: Boss_Epsilon1PartShieldCheck+4   j
                rts
; End of function Boss_Epsilon1PartShieldCheck
; Shield breaking animation
Boss_Epsilon1ShieldBreak:                              ; DATA XREF: ROM:00045D68   o  ; was: sub_46B1E
                tst.b   (word_FFF720).w
                bmi.s   locret_46B28
                addq.w  #2,4(a5)
locret_46B28:                           ; CODE XREF: Boss_Epsilon1ShieldBreak+4   j
                rts
; End of function Boss_Epsilon1ShieldBreak
; Shield regeneration logic
Boss_Epsilon1ShieldRegenerate:                              ; DATA XREF: ROM:00045D6A   o  ; was: sub_46B2A
                move.b  #4,(byte_FFA95A).w
                move.w  #$40,$48(a5) ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1ShieldRegenerate
; Transition to final phase
Boss_Epsilon1FinalPhaseTransition:                              ; DATA XREF: ROM:00045D6C   o  ; was: sub_46B3C
                subq.w  #1,$48(a5)
                bne.s   locret_46B58
                move.w  #$2E,(word_FF80C2).w ; '.'
                move.b  #1,(byte_FF80FA).w
                move.w  #$1E0,$48(a5)
                addq.w  #2,4(a5)
locret_46B58:                           ; CODE XREF: Boss_Epsilon1FinalPhaseTransition+4   j
                rts
; End of function Boss_Epsilon1FinalPhaseTransition
; Planet fade in effect
Cutscene_PlanetFadeIn:                              ; DATA XREF: ROM:00045D6E   o  ; was: sub_46B5A
                subq.w  #1,$48(a5)
                bne.s   locret_46B62
                clr.w   (a5)
locret_46B62:                           ; CODE XREF: Cutscene_PlanetFadeIn+4   j
                rts
; End of function Cutscene_PlanetFadeIn
; Boss rotation state dispatcher
Boss_Epsilon1RotationDispatcher:                              ; CODE XREF: Boss_Epsilon1Main+124   p  ; was: sub_46B64
                move.w  (dword_FF9414+2).w,d0
                add.w   d0,d0
                lea     (word_FF9480).w,a0
                move.w  (a0,d0.w),$56(a5)
                move.w  (dword_FF9418+2).w,d0
                lea     off_46B80(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1RotationDispatcher
; ---------------------------------------------------------------------------
off_46B80:      dc.w Boss_Epsilon1StartRotation-*        ; DATA XREF: Boss_Epsilon1RotationDispatcher+14   o
                dc.w Boss_Epsilon1RotationEnd-*
                dc.w Boss_Epsilon1RotateRight-*
                dc.w Boss_Epsilon1RotateLeft-*
                dc.w Boss_Epsilon1RotateReturn-*


; Starts rotation with sound
Boss_Epsilon1StartRotation:                              ; DATA XREF: ROM:off_46B80   o  ; was: sub_46B8A
                bclr    #6,$22(a5)
                bne.s   loc_46BD2
                move.w  (word_FFA000).w,d0
loc_46B96:
                move.w  d0,d1
                andi.w  #$FF,d0
                beq.s   loc_46BAA
                addi.w  #$10,d1
                andi.w  #$FF,d1
                beq.s   loc_46BAA
locret_46BA8:                           ; CODE XREF: Boss_Epsilon1StartRotation+3A   j
                rts
; ---------------------------------------------------------------------------
loc_46BAA:                              ; CODE XREF: Boss_Epsilon1StartRotation+12   j
                                        ; Boss_Epsilon1StartRotation+1C   j
                move.l  #word_EC05E,8(a5)
                move.w  #8,(dword_FF9420+2).w
                move.w  #2,(dword_FF9418+2).w
                cmpi.w  #$10,4(a5)
                bls.s   locret_46BA8
                move.b  #$51,d0 ; 'Q'
                jsr (Sound_PlaySFX).l
                rts
; ---------------------------------------------------------------------------
loc_46BD2:                              ; CODE XREF: Boss_Epsilon1StartRotation+6   j
                move.l  #word_EC05E,8(a5)
                move.w  #2,(dword_FF9420+2).w
                move.w  #4,(dword_FF9418+2).w
                move.b  #$52,d0 ; 'R'
                jsr (Sound_PlaySFX).l
                rts
; End of function Boss_Epsilon1StartRotation
; End rotation state
Boss_Epsilon1RotationEnd:                              ; DATA XREF: ROM:00046B82   o  ; was: sub_46BF2
                subq.w  #1,(dword_FF9420+2).w
                bne.s   locret_46C06
                move.l  #word_EC046,8(a5)
                move.w  #0,(dword_FF9418+2).w
locret_46C06:                           ; CODE XREF: Boss_Epsilon1RotationEnd+4   j
                rts
; End of function Boss_Epsilon1RotationEnd
; Rotate right with increment
Boss_Epsilon1RotateRight:                              ; DATA XREF: ROM:00046B84   o  ; was: sub_46C08
                addq.w  #2,(word_FFC6CC).w
                cmpi.w  #8,(word_FFC6CC).w
                bne.s   locret_46C18
                addq.w  #2,(dword_FF9418+2).w
locret_46C18:                           ; CODE XREF: Boss_Epsilon1RotateRight+A   j
                rts
; End of function Boss_Epsilon1RotateRight
; Rotate left with decrement
Boss_Epsilon1RotateLeft:                              ; DATA XREF: ROM:00046B86   o  ; was: sub_46C1A
                subq.w  #2,(word_FFC6CC).w
                cmpi.w  #$FFF8,(word_FFC6CC).w
                bne.s   locret_46C2A
                addq.w  #2,(dword_FF9418+2).w
locret_46C2A:                           ; CODE XREF: Boss_Epsilon1RotateLeft+A   j
                rts
; End of function Boss_Epsilon1RotateLeft
; Return rotation to center
Boss_Epsilon1RotateReturn:                              ; DATA XREF: ROM:00046B88   o  ; was: sub_46C2C
                addq.w  #2,(word_FFC6CC).w
                cmpi.w  #0,(word_FFC6CC).w
                bne.s   locret_46C5A
                subq.w  #1,(dword_FF9420+2).w
                beq.s   loc_46C46
                move.w  #4,(dword_FF9418+2).w
                rts
; ---------------------------------------------------------------------------
loc_46C46:                              ; CODE XREF: Boss_Epsilon1RotateReturn+10   j
                move.l  #word_EC046,8(a5)
                bclr    #6,$22(a5)
                move.w  #0,(dword_FF9418+2).w
locret_46C5A:                           ; CODE XREF: Boss_Epsilon1RotateReturn+A   j
                rts
; End of function Boss_Epsilon1RotateReturn
; Boss part state handler
Boss_Epsilon1PartHandler:                              ; CODE XREF: Boss_Epsilon1Main+1CC   p  ; was: sub_46C5C
                                        ; Boss_Epsilon1Main+200   p
                btst    #0,(word_FFC66C).w
                beq.s   loc_46C72
                cmpi.w  #6,4(a1)
                bcc.s   loc_46C72
                move.w  #6,4(a1)
loc_46C72:                              ; CODE XREF: Boss_Epsilon1PartHandler+6   j
                                        ; Boss_Epsilon1PartHandler+E   j
                move.w  4(a1),d0
                lea     off_46C7E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1PartHandler
; ---------------------------------------------------------------------------
off_46C7E:      dc.w Boss_Epsilon1PartInit-*        ; DATA XREF: Boss_Epsilon1PartHandler+1A   o
                dc.w Boss_Epsilon1PartUpdate-*
                dc.w Boss_Epsilon1PartDestroy-*
                dc.w nullsub_86-*
                dc.w Boss_Epsilon1PartDeathInit-*
                dc.w Boss_Epsilon1PartDeathFall-*
                dc.w Boss_Epsilon1PartDeathExplode-*
                dc.w Boss_Epsilon1PartDeathCleanup-*


; Part initialization state
Boss_Epsilon1PartInit:                              ; DATA XREF: ROM:off_46C7E   o  ; was: sub_46C8E
                move.w  ((loc_46B96-*)).w,d0
                andi.w  #$1F,d0
                beq.s   loc_46CA0
                bclr    #3,$22(a1)
                beq.s   locret_46CA4
loc_46CA0:                              ; CODE XREF: Boss_Epsilon1PartInit+8   j
                addq.w  #2,4(a1)
locret_46CA4:                           ; CODE XREF: Boss_Epsilon1PartInit+10   j
                rts
; End of function Boss_Epsilon1PartInit
; Part update and movement
Boss_Epsilon1PartUpdate:                              ; DATA XREF: ROM:00046C80   o  ; was: sub_46CA6
                addq.w  #4,$50(a1)
                cmpi.w  #$20,$50(a1) ; ' '
                bne.s   locret_46CB6
                addq.w  #2,4(a1)
locret_46CB6:                           ; CODE XREF: Boss_Epsilon1PartUpdate+A   j
                rts
; End of function Boss_Epsilon1PartUpdate
; Part destruction state
Boss_Epsilon1PartDestroy:                              ; DATA XREF: ROM:00046C82   o  ; was: sub_46CB8
                subq.w  #4,$50(a1)
                bne.s   locret_46CC8
                bclr    #6,$22(a1)
                clr.w   4(a1)
locret_46CC8:                           ; CODE XREF: Boss_Epsilon1PartDestroy+4   j
                rts
; End of function Boss_Epsilon1PartDestroy
nullsub_86:                             ; DATA XREF: ROM:00046C84   o
                rts
; End of function nullsub_86


; Part death initialization
Boss_Epsilon1PartDeathInit:                              ; DATA XREF: ROM:00046C86   o  ; was: sub_46CCC
                subq.w  #1,$48(a1)
                bpl.s   locret_46CEE
                move.w  #$EC80,2(a1)
                move.l  #off_E953C,8(a1)
                move.w  #$480,$E(a1)
                clr.w   $C(a1)
                addq.w  #2,4(a1)
locret_46CEE:                           ; CODE XREF: Boss_Epsilon1PartDeathInit+4   j
                rts
; End of function Boss_Epsilon1PartDeathInit
; Part falling after death
Boss_Epsilon1PartDeathFall:                              ; DATA XREF: ROM:00046C88   o  ; was: sub_46CF0
                cmpi.w  #$80,$C(a1)
                bmi.s   locret_46D02
                andi.w  #$7FFF,2(a1)
                addq.w  #2,4(a1)
locret_46D02:                           ; CODE XREF: Boss_Epsilon1PartDeathFall+6   j
                rts
; End of function Boss_Epsilon1PartDeathFall
; Part explosion effect
Boss_Epsilon1PartDeathExplode:                              ; DATA XREF: ROM:00046C8A   o  ; was: sub_46D04
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_46D5A
                move.l  #off_E95DC,8(a0)
                jsr (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                move.w  #2,$48(a1)
                addq.w  #2,4(a1)
                move.b  (dword_FFFF08+1).w,d0
                add.w   a5,d0
                andi.w  #1,d0
                beq.s   loc_46D4E
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                rts
; ---------------------------------------------------------------------------
loc_46D4E:                              ; CODE XREF: Boss_Epsilon1PartDeathExplode+3A   j
                move.w  (dword_FFC690).w,$10(a0)
                move.w  (dword_FFC694).w,$14(a0)
locret_46D5A:                           ; CODE XREF: Boss_Epsilon1PartDeathExplode+6   j
                rts
; End of function Boss_Epsilon1PartDeathExplode
; Part cleanup after destruction
Boss_Epsilon1PartDeathCleanup:                              ; DATA XREF: ROM:00046C8C   o  ; was: sub_46D5C
                subq.w  #1,$48(a1)
                bne.s   locret_46D66
                subq.w  #2,4(a1)
locret_46D66:                           ; CODE XREF: Boss_Epsilon1PartDeathCleanup+4   j
                rts
; End of function Boss_Epsilon1PartDeathCleanup
; Boss intro main handler
Boss_Epsilon1IntroMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_46D68
                btst    #0,(word_FFC66C).w
                bne.s   loc_46D78
                btst    #2,(word_FFC66C).w
                beq.s   loc_46D98
loc_46D78:                              ; CODE XREF: Boss_Epsilon1IntroMain+6   j
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
                tst.w   (dword_FF9420).w
                beq.s   loc_46D98
                movea.w (dword_FF9420).w,a0
                bset    #4,2(a0)
                clr.w   (dword_FF9420).w
                rts
; ---------------------------------------------------------------------------
loc_46D98:                              ; CODE XREF: Boss_Epsilon1IntroMain+E   j
                                        ; Boss_Epsilon1IntroMain+1E   j
                tst.w   $5E(a5)
                bne.w Boss_Epsilon1IntroDispatcher
                move.w  4(a5),d0
                lea     off_46DAC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroMain
; ---------------------------------------------------------------------------
off_46DAC:      dc.w nullsub_87-*       ; DATA XREF: Boss_Epsilon1IntroMain+3C   o
                dc.w Boss_Epsilon1MinibossInit-*
                dc.w Boss_Epsilon1MinibossTrackPlayer-*
                dc.w Boss_Epsilon1MinibossSpawnProjectile-*
                dc.w Boss_Epsilon1MinibossSlowdown-*
                dc.w nullsub_88-*
                dc.w Boss_Epsilon1MinibossLoopOrEnd-*


nullsub_87:                             ; DATA XREF: ROM:off_46DAC   o
                rts
; End of function nullsub_87


; Initializes Epsilon1 miniboss mirroring main boss
Boss_Epsilon1MinibossInit:                              ; DATA XREF: ROM:00046DAE   o  ; was: sub_46DBC
                addq.w  #2,4(a5)
                ori.w   #$8000,2(a5)
                move.w  (dword_FFC630).w,$10(a5)
                move.w  (dword_FFC634).w,$14(a5)
                move.w  #4,$4A(a5)
                move.w  #$FFFF,$4E(a5)
                move.w  #$40,$48(a5) ; '@'
                rts
; End of function Boss_Epsilon1MinibossInit
; Tracks player within distance thresholds
Boss_Epsilon1MinibossTrackPlayer:                              ; DATA XREF: ROM:00046DB0   o  ; was: sub_46DE6
                bsr.w Physics_CalculateAngleAndVelocity
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_46DF6
                neg.w   d0
loc_46DF6:                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+C   j
                cmpi.w  #$10,d0
                bcc.s   loc_46E10
                move.w  (word_FF824A).w,d0
                sub.w   $14(a5),d0
                bpl.s   loc_46E08
                neg.w   d0
loc_46E08:                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+1E   j
                cmpi.w  #$18,d0
                bcc.s   loc_46E10
                bra.s   loc_46E16
; ---------------------------------------------------------------------------
loc_46E10:                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+14   j
                                        ; Boss_Epsilon1MinibossTrackPlayer+26   j
                subq.w  #1,$48(a5)
                bpl.s   locret_46E2E
loc_46E16:                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+28   j
                tst.w   (dword_FF9420).w
                bne.s   locret_46E2E
                move.w  #$10,$48(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_46E2E:                           ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer+2E   j
                                        ; Boss_Epsilon1MinibossTrackPlayer+34   j
                rts
; End of function Boss_Epsilon1MinibossTrackPlayer
; Calculates angle and sets velocity from sine/cosine
Physics_CalculateAngleAndVelocity:                              ; CODE XREF: Boss_Epsilon1MinibossTrackPlayer   p  ; was: sub_46E30
                                        ; sub_46F1E   p
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_46E6C
                jsr (Math_CalculateAngleToPlayer).l
                tst.w   $4E(a5)
                bpl.s   loc_46E4C
                move.w  d2,$4E(a5)
                bra.s   loc_46E6C
; ---------------------------------------------------------------------------
loc_46E4C:                              ; CODE XREF: Physics_CalculateAngleAndVelocity+14   j
                move.w  $4E(a5),d1
                sub.w   d2,d1
                andi.w  #$1FF,d1
                beq.s   loc_46E6C
                cmpi.w  #$100,d1
                bcs.s   loc_46E66
                move.w  #$10,$4C(a5)
                bra.s   loc_46E6C
; ---------------------------------------------------------------------------
loc_46E66:                              ; CODE XREF: Physics_CalculateAngleAndVelocity+2C   j
                move.w  #$FFF0,$4C(a5)
loc_46E6C:                              ; CODE XREF: Physics_CalculateAngleAndVelocity+8   j
                                        ; Physics_CalculateAngleAndVelocity+1A   j ...
                move.w  $4C(a5),d0
                add.w   d0,$4E(a5)
                andi.w  #$1FF,$4E(a5)
                move.w  $4E(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #4,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Physics_CalculateAngleAndVelocity
; Flips sprite and spawns projectile on timer
Boss_Epsilon1MinibossSpawnProjectile:                              ; DATA XREF: ROM:00046DB2   o  ; was: sub_46EA2
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bpl.w   locret_46F1C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_46F1C
                move.w  a0,(dword_FF9420).w
                move.w  #$10,(a0)
                move.w  #$C3C9,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$8080,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #2,4(a5)
                tst.w   (word_FF9474).w
                bne.s   loc_46F02
                subq.w  #1,$4A(a5)
                beq.w   loc_46F02
                clr.w   $4C(a5)
                ori.w   #$8000,2(a5)
                bra.s   loc_46F08
; ---------------------------------------------------------------------------
loc_46F02:                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+4A   j
                                        ; Boss_Epsilon1MinibossSpawnProjectile+50   j
                andi.w  #$7FFF,2(a5)
loc_46F08:                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+5E   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_46F16
                move.w  #$10,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_46F16:                              ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+6A   j
                move.w  #8,$48(a5)
locret_46F1C:                           ; CODE XREF: Boss_Epsilon1MinibossSpawnProjectile+A   j
                                        ; Boss_Epsilon1MinibossSpawnProjectile+14   j
                rts
; End of function Boss_Epsilon1MinibossSpawnProjectile
; Tracks player angle while decrementing timer
Boss_Epsilon1MinibossSlowdown:                              ; DATA XREF: ROM:00046DB4   o  ; was: sub_46F1E
                bsr.w Physics_CalculateAngleAndVelocity
                subq.w  #1,$48(a5)
                bpl.w   locret_46F36
                clr.l   $18(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_46F36:                           ; CODE XREF: Boss_Epsilon1MinibossSlowdown+8   j
                rts
; End of function Boss_Epsilon1MinibossSlowdown
nullsub_88:                             ; DATA XREF: ROM:00046DB6   o
                rts
; End of function nullsub_88


; Loops attack or clears sprite and terminates
Boss_Epsilon1MinibossLoopOrEnd:                              ; DATA XREF: ROM:00046DB8   o  ; was: sub_46F3A
                tst.w   (word_FF9474).w
                bne.s   loc_46F56
                tst.w   $4A(a5)
                beq.w   loc_46F56
                move.w  #$40,$48(a5) ; '@'
                move.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_46F56:                              ; CODE XREF: Boss_Epsilon1MinibossLoopOrEnd+4   j
                                        ; Boss_Epsilon1MinibossLoopOrEnd+A   j
                bclr    #7,2(a5)
                clr.w   4(a5)
                rts
; End of function Boss_Epsilon1MinibossLoopOrEnd
; Boss intro state dispatcher
Boss_Epsilon1IntroDispatcher:                              ; CODE XREF: Boss_Epsilon1IntroMain+34   j  ; was: sub_46F62
                move.w  4(a5),d0
                lea     off_46F6E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroDispatcher
; ---------------------------------------------------------------------------
off_46F6E:      dc.w nullsub_89-*       ; DATA XREF: Boss_Epsilon1IntroDispatcher+4   o
                dc.w Boss_Epsilon1ShuffleArray-*
                dc.w Boss_Epsilon1Intro_ShuffleArray-*
                dc.w Boss_Epsilon1SpawnProjectile-*
                dc.w Boss_Epsilon1Intro_SpawnDelay-*
                dc.w Boss_Epsilon1InitProjectileSprite-*
                dc.w nullsub_90-*
                dc.w Boss_Epsilon1ResetIntro-*


nullsub_89:                             ; DATA XREF: ROM:off_46F6E   o
                rts
; End of function nullsub_89


; Shuffles array elements
Boss_Epsilon1ShuffleArray:                              ; DATA XREF: ROM:00046F70   o  ; was: sub_46F80
                move.w  #8,$4A(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  #7,d7
                moveq   #0,d0
                lea     $50(a5),a0
loc_46F9A:                              ; CODE XREF: Boss_Epsilon1ShuffleArray+1E   j
                move.b  d0,(a0)+
                addq.b  #1,d0
                dbf     d7,loc_46F9A
; Shuffles attack pattern array during intro
Boss_Epsilon1Intro_ShuffleArray:                              ; DATA XREF: ROM:00046F72   o  ; was: loc_46FA2
                lea     $50(a5),a0
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #7,d0
                andi.w  #7,d1
                cmp.w   d0,d1
                beq.s   locret_46FDE
                move.b  (a0,d0.w),d2
                move.b  (a0,d1.w),(a0,d0.w)
                move.b  d2,(a0,d1.w)
                subq.w  #1,$48(a5)
                bne.s   locret_46FDE
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$4E(a5)
                addq.w  #2,4(a5)
locret_46FDE:                           ; CODE XREF: Boss_Epsilon1ShuffleArray+38   j
                                        ; Boss_Epsilon1ShuffleArray+4C   j
                rts
; End of function Boss_Epsilon1ShuffleArray
; Spawns projectile and calculates position
Boss_Epsilon1SpawnProjectile:                              ; DATA XREF: ROM:00046F74   o  ; was: sub_46FE0
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_472A8
                move.w  #$10,(a0)
                move.w  a0,$4C(a5)
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_47004
                move.w  #$28,$48(a5) ; '('
                bra.s Boss_Epsilon1Intro_SpawnDelay
; ---------------------------------------------------------------------------
loc_47004:                              ; CODE XREF: Boss_Epsilon1SpawnProjectile+1A   j
                move.w  #$20,$48(a5) ; ' '
; Delay timer before spawning projectile
Boss_Epsilon1Intro_SpawnDelay:                              ; CODE XREF: Boss_Epsilon1SpawnProjectile+22   j  ; was: loc_4700A
                                        ; DATA XREF: ROM:00046F76   o
                subq.w  #1,$48(a5)
                bne.s   locret_4704E
                ori.w   #$8000,2(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
                move.w  $4A(a5),d0
                subq.w  #1,d0
                lea     $50(a5),a0
                move.b  (a0,d0.w),d0
                andi.w  #$F,d0
                add.w   d0,d0
                move.w  word_47050(pc,d0.w),d0
                addi.w  #$120,d0
                sub.w   (dword_FFA900).w,d0
                add.w   $4E(a5),d0
                move.w  d0,$10(a5)
                move.w  (word_FF824A).w,$14(a5)
locret_4704E:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile+2E   j
                rts
; End of function Boss_Epsilon1SpawnProjectile
; ---------------------------------------------------------------------------
word_47050:     dc.w $FF80, $FFA0, $FFC0, $FFE0, 0, $20, $40, $60, $C0, $E0, $100, $120
                                        ; DATA XREF: Boss_Epsilon1SpawnProjectile+54   r


; Initializes projectile sprite
Boss_Epsilon1InitProjectileSprite:                              ; DATA XREF: ROM:00046F78   o  ; was: sub_47068
                subq.w  #1,$48(a5)
                bne.s   locret_470B8
                andi.w  #$7FFF,2(a5)
                movea.w $4C(a5),a0
                move.w  #$2E8,(a0)
                move.w  #$C3C9,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$8080,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                tst.w   (word_FF9474).w
                bne.s   loc_470B4
                subq.w  #1,$4A(a5)
                beq.s   loc_470B4
                move.w  #6,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_470B4:                              ; CODE XREF: Boss_Epsilon1InitProjectileSprite+3C   j
                                        ; Boss_Epsilon1InitProjectileSprite+42   j
                addq.w  #2,4(a5)
locret_470B8:                           ; CODE XREF: Boss_Epsilon1InitProjectileSprite+4   j
                rts
; End of function Boss_Epsilon1InitProjectileSprite
nullsub_90:                             ; DATA XREF: ROM:00046F7A   o
                rts
; End of function nullsub_90


; Resets boss intro state
Boss_Epsilon1ResetIntro:                              ; DATA XREF: ROM:00046F7C   o  ; was: sub_470BC
                clr.w   4(a5)
                rts
; End of function Boss_Epsilon1ResetIntro
; Spread shot initialization
Projectile_Epsilon1SpreadInit:                              ; DATA XREF: Boss_Epsilon1DefeatInit   o  ; was: sub_470C2
                movea.w a5,a0
                move.w  #5,$4A(a0)
                bra.s   loc_470D4
; End of function Projectile_Epsilon1SpreadInit
; Expanding spread projectile with deceleration
Projectile_Epsilon1SpreadExpanding:                              ; DATA XREF: Projectile_Epsilon1SpreadSetup   o  ; was: sub_470CC
                movea.w a5,a0
                move.w  #$B,$4A(a0)
loc_470D4:                              ; CODE XREF: Projectile_Epsilon1SpreadInit+8   j
                move.w  #$27C,(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$8C80,2(a0)
                move.w  #$C8,$26(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FC04FC04,$2C(a0)
                move.w  #2,$48(a0)
                lea     (word_1B514).l,a2
                move.w  $58(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #6,d0
                asl.l   #6,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                neg.l   d0
                neg.l   d1
                move.l  d0,$4C(a0)
                move.l  d1,$50(a0)
                move.l  d0,$54(a0)
                move.l  d1,$58(a0)
                rts
; End of function Projectile_Epsilon1SpreadExpanding
; Defeat debris projectiles
Projectile_Epsilon1DefeatDebris:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_47146
                bsr.w Boss_Epsilon1CheckVulnerable
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5C(a5)
                cmpi.w  #$150,$14(a5)
                bcc.w Projectile_Epsilon1SpreadUpdate
                cmpi.w  #$20,$14(a5) ; ' '
                bls.w Projectile_Epsilon1SetFlag
                cmpi.w  #$1D0,$5C(a5)
                bhi.w Projectile_Epsilon1SetFlag
                cmpi.w  #$70,$5C(a5) ; 'p'
                bcs.w Projectile_Epsilon1SetFlag
                tst.w   $5E(a5)
                beq.w   loc_4718C
                move.w  #4,4(a5)
loc_4718C:                              ; CODE XREF: Projectile_Epsilon1DefeatDebris+3C   j
                move.w  4(a5),d0
                lea     off_47198(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1DefeatDebris
; ---------------------------------------------------------------------------
off_47198:      dc.w Projectile_Epsilon1SpreadDelayTimer-*        ; DATA XREF: Projectile_Epsilon1DefeatDebris+4A   o
                dc.w Projectile_Epsilon1SpreadSpawn-*
                dc.w Gfx_Epsilon1SpreadAnimateCycle-*


; Decrements timer and advances when expired
Projectile_Epsilon1SpreadDelayTimer:                              ; DATA XREF: ROM:off_47198   o  ; was: sub_4719E
                subq.w  #1,$48(a5)
                bne.s   locret_471A8
                addq.w  #2,4(a5)
locret_471A8:                           ; CODE XREF: Projectile_Epsilon1SpreadDelayTimer+4   j
                rts
; End of function Projectile_Epsilon1SpreadDelayTimer
; Spawns spread projectile with position offset
Projectile_Epsilon1SpreadSpawn:                              ; DATA XREF: ROM:0004719A   o  ; was: sub_471AA
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_4721E
                move.w  #1,$5E(a0)
                move.w  #$27C,(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$8CC0,2(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                move.l  $4C(a5),d0
                add.l   d0,$10(a0)
                move.l  $50(a5),d1
                add.l   d1,$14(a0)
                move.l  $54(a5),d0
                add.l   d0,$4C(a5)
                move.l  $58(a5),d1
                add.l   d1,$50(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_4721E
                addq.w  #2,4(a5)
locret_4721E:                           ; CODE XREF: Projectile_Epsilon1SpreadSpawn+6   j
                                        ; Projectile_Epsilon1SpreadSpawn+6E   j
                rts
; End of function Projectile_Epsilon1SpreadSpawn
; Cycles through animation frames modulo 4
Gfx_Epsilon1SpreadAnimateCycle:                              ; DATA XREF: ROM:0004719C   o  ; was: sub_47220
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                beq.s   locret_4724C
                cmpi.w  #1,d0
                beq.s   loc_47246
                cmpi.w  #2,d0
                beq.s   loc_4723E
                move.w  #$44F7,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4723E:                              ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+14   j
                move.w  #$44F6,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_47246:                              ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+E   j
                move.w  #$44F1,$E(a5)
locret_4724C:                           ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+8   j
                rts
; End of function Gfx_Epsilon1SpreadAnimateCycle
; Spread shot pattern movement
Projectile_Epsilon1SpreadUpdate:                              ; CODE XREF: Projectile_Epsilon1DefeatDebris+16   j  ; was: sub_4724E
                clr.b   $21(a5)
                move.l  #off_E95DC,8(a5)
                jsr (Enemy_GetEntityAddress).l
                clr.l   $18(a5)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,$18(a5)
                bsr.s Projectile_Epsilon1CheckFlag
                tst.w   $5E(a5)
                bne.s   locret_4729E
                addq.w  #2,(word_FFA010).w
                tst.w   $5E(a5)
                bne.w   locret_4729E
                move.b  #$E1,d0
                jsr (Sound_PlaySFX).l
locret_4729E:                           ; CODE XREF: Projectile_Epsilon1SpreadUpdate+38   j
                                        ; Projectile_Epsilon1SpreadUpdate+42   j
                rts
; End of function Projectile_Epsilon1SpreadUpdate
; Sets flag $1000 in projectile flags and chains to handler
Projectile_Epsilon1SetFlag:                              ; CODE XREF: Projectile_Epsilon1DefeatDebris+20   j  ; was: sub_472A0
                                        ; Projectile_Epsilon1DefeatDebris+2A   j ...
                move.w  #$1000,2(a5)
                bsr.s Projectile_Epsilon1CheckFlag
locret_472A8:                           ; CODE XREF: Boss_Epsilon1SpawnProjectile+6   j
                rts
; End of function Projectile_Epsilon1SetFlag
; Tests and clears projectile flag bit #4 in entity
Projectile_Epsilon1CheckFlag:                              ; CODE XREF: Projectile_Epsilon1SpreadUpdate+32   p  ; was: sub_472AA
                                        ; Projectile_Epsilon1SetFlag+6   p
                tst.w   (dword_FF9420).w
                beq.s   locret_472BE
                movea.w (dword_FF9420).w,a0
                bset    #4,2(a0)
                clr.w   (dword_FF9420).w
locret_472BE:                           ; CODE XREF: Projectile_Epsilon1CheckFlag+4   j
                rts
; End of function Projectile_Epsilon1CheckFlag
; Projectile main handler
Projectile_Epsilon1IntroMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_472C0
                bsr.w Boss_Epsilon1CheckVulnerable
                move.w  4(a5),d0
                lea     off_472D0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1IntroMain
; ---------------------------------------------------------------------------
off_472D0:      dc.w Projectile_Epsilon1SetTimer-*        ; DATA XREF: Projectile_Epsilon1IntroMain+8   o
                dc.w Projectile_Epsilon1CountdownTimer-*
                dc.w Projectile_Epsilon1SpawnPattern-*
                dc.w Projectile_Epsilon1Cleanup-*


; Sets initial timer
Projectile_Epsilon1SetTimer:                              ; DATA XREF: ROM:off_472D0   o  ; was: sub_472D8
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Epsilon1SetTimer
; Counts down timer
Projectile_Epsilon1CountdownTimer:                              ; DATA XREF: ROM:000472D2   o  ; was: sub_472E4
                subq.w  #1,$48(a5)
                bne.s   locret_472F4
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_472F4:                           ; CODE XREF: Projectile_Epsilon1CountdownTimer+4   j
                rts
; End of function Projectile_Epsilon1CountdownTimer
; Spawns multiple projectiles in pattern
Projectile_Epsilon1SpawnPattern:                              ; DATA XREF: ROM:000472D4   o  ; was: sub_472F6
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_47348
                move.w  #7,d7
                move.w  #$60,d6 ; '`'
                clr.w   d5
loc_4730C:                              ; CODE XREF: Projectile_Epsilon1SpawnPattern+34   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_4732E
                bsr.s Projectile_Epsilon1InitProperties
                move.w  $10(a5),$10(a0)
                move.w  d6,$14(a0)
                move.w  d5,$5E(a0)
                addq.w  #1,d5
                subi.w  #$20,d6 ; ' '
                dbf     d7,loc_4730C
loc_4732E:                              ; CODE XREF: Projectile_Epsilon1SpawnPattern+1C   j
                move.w  #$10,$48(a5)
                ori.w   #$8000,2(a5)
                addq.w  #2,4(a5)
                move.b  #$AB,d0
                jsr (Sound_PlaySFX).l
locret_47348:                           ; CODE XREF: Projectile_Epsilon1SpawnPattern+A   j
                rts
; End of function Projectile_Epsilon1SpawnPattern
; Initializes projectile properties
Projectile_Epsilon1InitProperties:                              ; CODE XREF: Projectile_Epsilon1SpawnPattern+1E   p  ; was: sub_4734A
                move.w  #$280,(a0)
                move.w  #$8D80,2(a0)
                move.w  #$43D2,$E(a0)
                move.w  #$300,8(a0)
                move.w  #$FCF0,$A(a0)
                move.w  #$C,$1C(a0)
                move.w  #$14,$48(a0)
                rts
; End of function Projectile_Epsilon1InitProperties
; Timer countdown with cleanup
Projectile_Epsilon1Cleanup:                              ; DATA XREF: ROM:000472D6   o  ; was: sub_47374
                subq.w  #1,$48(a5)
                bne.s   locret_47380
                bset    #4,2(a5)
locret_47380:                           ; CODE XREF: Projectile_Epsilon1Cleanup+4   j
                rts
; End of function Projectile_Epsilon1Cleanup
; Projectile state handler
Projectile_Epsilon1StateHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_47382
                cmpi.w  #$150,$14(a5)
                bgt.w Projectile_Epsilon1OffscreenHandler
                move.w  4(a5),d0
                lea     off_47398(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1StateHandler
; ---------------------------------------------------------------------------
off_47398:      dc.w Projectile_Epsilon1DescentState-*        ; DATA XREF: Projectile_Epsilon1StateHandler+E   o
                dc.w Projectile_Epsilon1AnimationState-*
                dc.w nullsub_91-*


; Projectile descent state
Projectile_Epsilon1DescentState:                              ; DATA XREF: ROM:off_47398   o  ; was: sub_4739E
                subq.w  #1,$48(a5)
                bne.s   locret_473C6
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #$F808F010,$2C(a5)
                move.w  #$C8,$26(a5)
locret_473C6:                           ; CODE XREF: Projectile_Epsilon1DescentState+4   j
                rts
; End of function Projectile_Epsilon1DescentState
; Projectile animation state
Projectile_Epsilon1AnimationState:                              ; DATA XREF: ROM:0004739A   o  ; was: sub_473C8
                subq.w  #1,$48(a5)
                bne.s   locret_47406
                move.w  #2,$48(a5)
                addq.w  #2,$5C(a5)
                cmpi.w  #$10,$5C(a5)
                bls.s   loc_473F0
                clr.b   $21(a5)
                move.w  #$10,$1C(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_473F0:                              ; CODE XREF: Projectile_Epsilon1AnimationState+16   j
                move.w  $5C(a5),d0
                move.w  word_47408(pc,d0.w),$E(a5)
                move.w  word_4741A(pc,d0.w),8(a5)
                move.w  word_4742C(pc,d0.w),$A(a5)
locret_47406:                           ; CODE XREF: Projectile_Epsilon1AnimationState+4   j
                rts
; End of function Projectile_Epsilon1AnimationState
; ---------------------------------------------------------------------------
word_47408:     dc.w $43D2, $43D6, $43DA, $43EA, $43E2, $43EA, $43DA, $43D6, $43D2
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+2C   r
word_4741A:     dc.w $300, $300, $700, $700, $700, $700, $700, $300, $300
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+32   r
word_4742C:     dc.w $FCF0, $FCF0, $F8F0, $F8F0, $F8F0, $F8F0, $F8F0, $FCF0, $FCF0
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+38   r


nullsub_91:                             ; DATA XREF: ROM:0004739C   o
                rts
; End of function nullsub_91


; Projectile offscreen handler
Projectile_Epsilon1OffscreenHandler:                              ; CODE XREF: Projectile_Epsilon1StateHandler+6   j  ; was: sub_47440
                move.l  #off_E95DC,8(a5)
                jsr (Enemy_GetEntityAddress).l
                clr.l   $18(a5)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,$18(a5)
                tst.w   $5E(a5)
                bne.s   locret_47484
                move.w  #2,(word_FFA010).w
                move.b  #$E1,d0
                jsr (Sound_PlaySFX).l
locret_47484:                           ; CODE XREF: Projectile_Epsilon1OffscreenHandler+32   j
                rts
; End of function Projectile_Epsilon1OffscreenHandler
; Chain projectile initialization
Projectile_Epsilon1ChainInit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_47486
                btst    #0,(word_FFC66C).w
                bne.s   loc_4749C
                btst    #2,(word_FFC66C).w
                beq.s   loc_474E6
                clr.w   4(a5)
                bra.s   loc_474AA
; ---------------------------------------------------------------------------
loc_4749C:                              ; CODE XREF: Projectile_Epsilon1ChainInit+6   j
                cmpi.w  #$C,4(a5)
                bcc.s   loc_474E6
                move.w  #$C,4(a5)
loc_474AA:                              ; CODE XREF: Projectile_Epsilon1ChainInit+14   j
                andi.w  #$7FFF,2(a5)
                tst.w   $4E(a5)
                movea.w $4E(a5),a0
                beq.s   loc_474E6
                jsr (Projectile_InitType88).l
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  2(a5),d0
                andi.w  #$8000,d0
                andi.w  #$7FFF,2(a0)
                or.w    d0,2(a0)
loc_474E6:                              ; CODE XREF: Projectile_Epsilon1ChainInit+E   j
                                        ; Projectile_Epsilon1ChainInit+1C   j ...
                move.w  4(a5),d0
                lea     off_474F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1ChainInit
; ---------------------------------------------------------------------------
off_474F2:      dc.w nullsub_92-*       ; DATA XREF: Projectile_Epsilon1ChainInit+64   o
                dc.w Projectile_Epsilon1ChainSegment-*
                dc.w Projectile_Epsilon1RingInit-*
                dc.w Projectile_Epsilon1BurstInit-*
                dc.w Projectile_Epsilon1TrackingInit-*
                dc.w Projectile_Epsilon1TrackingUpdate-*
                dc.w nullsub_93-*
                dc.w Effect_Epsilon1DefeatSpark2-*
                dc.w Effect_Epsilon1DefeatSpark4-*
                dc.w Projectile_Epsilon1Despawn-*


nullsub_92:                             ; DATA XREF: ROM:off_474F2   o
                rts
; End of function nullsub_92


; Chain segment physics
Projectile_Epsilon1ChainSegment:                              ; DATA XREF: ROM:000474F4   o  ; was: sub_47508
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bcs.s   loc_47514
                subq.w  #6,d0
loc_47514:                              ; CODE XREF: Projectile_Epsilon1ChainSegment+8   j
                add.w   d0,d0
                lea     (dword_FF9400).w,a0
                move.w  (a0,d0.w),d1
                cmpi.w  #$80,d1
                bcs.s   locret_47530
                move.w  #$80,d0
                bsr.w Effect_Epsilon1DefeatSpark1
                addq.w  #2,4(a5)
locret_47530:                           ; CODE XREF: Projectile_Epsilon1ChainSegment+1A   j
                rts
; End of function Projectile_Epsilon1ChainSegment
; Ring projectile initialization
Projectile_Epsilon1RingInit:                              ; DATA XREF: ROM:000474F6   o  ; was: sub_47532
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bcs.s   loc_4753E
                subq.w  #6,d0
loc_4753E:                              ; CODE XREF: Projectile_Epsilon1RingInit+8   j
                add.w   d0,d0
                lea     (dword_FF9400).w,a0
                move.w  (a0,d0.w),d1
                cmpi.w  #$120,d1
                bcs.w   locret_475C2
                cmpi.w  #$180,d1
                bcc.w   locret_475C2
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                bsr.w Projectile_Epsilon1RingExpand
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_475C2
                jsr (Sprite_InitializeProperties).l
                move.l  #off_E95C0,8(a0)
                move.w  #$480,$E(a0)
                move.w  $10(a5),$10(a0)
                addi.w  #8,$10(a0)
                move.w  $14(a5),$14(a0)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_475C2
                jsr (Sprite_InitializeProperties).l
                move.l  #off_E95C0,8(a0)
                move.w  #$480,$E(a0)
                move.w  $10(a5),$10(a0)
                addi.w  #-8,$10(a0)
                move.w  $14(a5),$14(a0)
locret_475C2:                           ; CODE XREF: Projectile_Epsilon1RingInit+1A   j
                                        ; Projectile_Epsilon1RingInit+22   j ...
                rts
; End of function Projectile_Epsilon1RingInit
; Ring expansion animation
Projectile_Epsilon1RingExpand:                              ; CODE XREF: Projectile_Epsilon1RingInit+30   p  ; was: sub_475C4
                                        ; Projectile_Epsilon1BurstInit+6   p
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a1
                move.w  (a1,d0.w),d0
                move.w  (dword_FFC690).w,d0
                add.w   $4C(a5),d0
                move.w  d0,$10(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a0
                move.w  #$1E0,d1
                sub.w   (a0,d0.w),d1
                subi.w  #$20,d1 ; ' '
                move.w  d1,$14(a5)
                rts
; End of function Projectile_Epsilon1RingExpand
; Burst projectile initialization
Projectile_Epsilon1BurstInit:                              ; DATA XREF: ROM:000474F8   o  ; was: sub_475FA
                subq.w  #1,$48(a5)
                bne.s   locret_47644
                bsr.w Projectile_Epsilon1RingExpand
                move.w  #9,$1C(a5)
                ori.w   #$8000,2(a5)
                move.b  #$40,$21(a5) ; '@'
                clr.w   $50(a5)
                movea.w $4E(a5),a0
                ori.w   #$8000,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                move.b  #$50,d0 ; 'P'
                jsr (Sound_PlaySFX).l
locret_47644:                           ; CODE XREF: Projectile_Epsilon1BurstInit+4   j
                rts
; End of function Projectile_Epsilon1BurstInit
; Clears projectile state flags and velocity
Projectile_Epsilon1CleanupState:
                movea.w $4E(a5),a0  ; was: sub_47646
                bset    #4,2(a0)
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
; End of function Projectile_Epsilon1CleanupState
; Burst explosion effect
Projectile_Epsilon1BurstExplode:                              ; CODE XREF: Projectile_Epsilon1TrackingUpdate   p  ; was: sub_4765A
                moveq   #0,d0
; End of function Projectile_Epsilon1BurstExplode
; Defeat spark effect 1
Effect_Epsilon1DefeatSpark1:                              ; CODE XREF: Projectile_Epsilon1ChainSegment+20   p  ; was: sub_4765C
                                        ; Projectile_Epsilon1TrackingInit+C   p ...
                lea     (dword_FF944E).w,a1
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  d0,(a1,d1.w)
                rts
; End of function Effect_Epsilon1DefeatSpark1
; Tracking projectile initialization
Projectile_Epsilon1TrackingInit:                              ; DATA XREF: ROM:000474FA   o  ; was: sub_4766C
                cmpi.w  #$120,$48(a5)
                beq.s   loc_47682
                move.w  $48(a5),d0
                bsr.w Effect_Epsilon1DefeatSpark1
                addi.w  #$10,$48(a5)
loc_47682:                              ; CODE XREF: Projectile_Epsilon1TrackingInit+6   j
                cmpi.w  #$20,$50(a5) ; ' '
                beq.s   loc_4768E
                addq.w  #4,$50(a5)
loc_4768E:                              ; CODE XREF: Projectile_Epsilon1TrackingInit+1C   j
                movea.w $4E(a5),a0
                ori.w   #$8000,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $50(a5),d0
                sub.w   d0,$14(a0)
                cmpi.w  #$150,$14(a5)
                bcs.w   locret_476F2
                andi.w  #$7FFF,2(a5)
                clr.b   $21(a5)
                movea.w $4E(a5),a0
                jsr (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #2,d0
                move.w  d0,$1C(a0)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_476F2:                           ; CODE XREF: Projectile_Epsilon1TrackingInit+46   j
                rts
; End of function Projectile_Epsilon1TrackingInit
; Tracking projectile AI
Projectile_Epsilon1TrackingUpdate:                              ; DATA XREF: ROM:000474FC   o  ; was: sub_476F4
                bsr.w Projectile_Epsilon1BurstExplode
                clr.w   4(a5)
                rts
; End of function Projectile_Epsilon1TrackingUpdate
nullsub_93:                             ; DATA XREF: ROM:000474FE   o
                rts
; End of function nullsub_93


; Defeat spark effect 2
Effect_Epsilon1DefeatSpark2:                              ; DATA XREF: ROM:00047500   o  ; was: sub_47700
                bsr.s Effect_Epsilon1DefeatSpark3
                cmpi.w  #$140,$14(a5)
                blt.s   loc_47710
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_47710:                              ; CODE XREF: Effect_Epsilon1DefeatSpark2+8   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_47752
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_47752
                jsr (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFE,$1C(a0)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                move.l  #off_E95DC,8(a0)
locret_47752:                           ; CODE XREF: Effect_Epsilon1DefeatSpark2+18   j
                                        ; Effect_Epsilon1DefeatSpark2+20   j
                rts
; End of function Effect_Epsilon1DefeatSpark2
; Defeat spark effect 3
Effect_Epsilon1DefeatSpark3:                              ; CODE XREF: Effect_Epsilon1DefeatSpark2   p  ; was: sub_47754
                addi.w  #$20,$50(a5) ; ' '
                move.w  $50(a5),d0
                bsr.w Effect_Epsilon1DefeatSpark1
                move.w  (dword_FFC690).w,d0
                add.w   $4C(a5),d0
                move.w  d0,$10(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a0
                move.w  #$1E0,d1
                sub.w   (a0,d0.w),d1
                subi.w  #$20,d1 ; ' '
                move.w  d1,$14(a5)
                cmpi.w  #$C,d0
                bcs.s   loc_47792
                subi.w  #$C,d0
loc_47792:                              ; CODE XREF: Effect_Epsilon1DefeatSpark3+38   j
                lea     (dword_FF9466).w,a1
                addi.w  #-2,(a1,d0.w)
                rts
; End of function Effect_Epsilon1DefeatSpark3
; Defeat spark effect 4
Effect_Epsilon1DefeatSpark4:                              ; DATA XREF: ROM:00047502   o  ; was: sub_4779E
                jsr (Projectile_ExplodeWithSound).l
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF9466).w,a1
                move.w  #$FF00,(a1,d0.w)
                addq.w  #2,4(a5)
                move.l  #off_E953C,8(a5)
                move.w  #$FFFF,$1C(a5)
                jmp Enemy_GetEntityAddress
; End of function Effect_Epsilon1DefeatSpark4
nullsub_94:
                rts
; End of function nullsub_94


; Clears projectile entity and unsets bit #4
Projectile_Epsilon1Despawn:                              ; DATA XREF: ROM:00047504   o  ; was: sub_477CE
                clr.w   (a5)
                bclr    #4,2(a5)
                rts
; End of function Projectile_Epsilon1Despawn
; Checks if boss part is vulnerable
Boss_Epsilon1CheckVulnerable:                              ; CODE XREF: Projectile_Epsilon1DefeatDebris   p  ; was: sub_477D8
                                        ; sub_472C0   p
                btst    #0,(word_FFC66C).w
                bne.s   loc_477E8
                btst    #2,(word_FFC66C).w
                beq.s   locret_477F6
loc_477E8:                              ; CODE XREF: Boss_Epsilon1CheckVulnerable+6   j
                move.l  #off_E95DC,8(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
locret_477F6:                           ; CODE XREF: Boss_Epsilon1CheckVulnerable+E   j
                rts
; End of function Boss_Epsilon1CheckVulnerable
; Initializes projectile array
Boss_Epsilon1InitProjectileArray:                              ; CODE XREF: Projectile_Epsilon1Type5Main   p  ; was: sub_477F8
                                        ; sub_4679C:loc_467B0   p ...
                move.w  (dword_FF9414).w,d0
                addi.w  #$40,d0 ; '@'
                andi.w  #$180,d0
                lsr.w   #6,d0
                move.w  word_4782A(pc,d0.w),d0
                move.w  (dword_FF9410).w,d1
                muls.w  d0,d1
                cmpi.w  #0,$58(a5)
                bne.s   loc_4781E
                tst.w   d0
                bpl.s   locret_47822
                bra.s   loc_47824
; ---------------------------------------------------------------------------
loc_4781E:                              ; CODE XREF: Boss_Epsilon1InitProjectileArray+1E   j
                tst.w   d0
                bpl.s   loc_47824
locret_47822:                           ; CODE XREF: Boss_Epsilon1InitProjectileArray+22   j
                rts
; ---------------------------------------------------------------------------
loc_47824:                              ; CODE XREF: Boss_Epsilon1InitProjectileArray+24   j
                                        ; Boss_Epsilon1InitProjectileArray+28   j
                add.l   d1,(dword_FFC694).w
                rts
; End of function Boss_Epsilon1InitProjectileArray
; ---------------------------------------------------------------------------
word_4782A:     dc.w $4000, $4000, $C000, $C000
                                        ; DATA XREF: Boss_Epsilon1InitProjectileArray+E   r


; Spawns ring of projectiles
Boss_Epsilon1SpawnProjectileRing:                              ; CODE XREF: Boss_Epsilon1AttackPhase1Setup   p  ; was: sub_47832
                                        ; sub_462BC   p ...
                cmpi.w  #$80,(dword_FFC694).w
                bcs.s   loc_47856
                cmpi.w  #$E0,(dword_FFC694).w
                bhi.s   loc_4785E
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                bne.s   loc_47864
                move.b  (dword_FFFF08+1).w,d0
                andi.b  #1,d0
                beq.s   loc_4785E
loc_47856:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+6   j
                move.w  #1,$58(a5)
                bra.s   loc_47864
; ---------------------------------------------------------------------------
loc_4785E:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+E   j
                                        ; Boss_Epsilon1SpawnProjectileRing+22   j
                move.w  #0,$58(a5)
loc_47864:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+18   j
                                        ; Boss_Epsilon1SpawnProjectileRing+2A   j
                bsr.w Boss_Epsilon1InitProjectileArray
                cmpi.w  #0,$58(a5)
                beq.w   loc_4787C
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                bne.s   loc_4789C
loc_4787C:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+3C   j
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d0
                beq.s   loc_4789C
                tst.w   d1
                bpl.s   loc_47894
loc_4788A:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+78   j
                move.l  #$FFFFC000,(dword_FFC6DC).w
                bra.s   loc_4789C
; ---------------------------------------------------------------------------
loc_47894:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+56   j
                                        ; Boss_Epsilon1SpawnProjectileRing+80   j
                move.l  #$4000,(dword_FFC6DC).w
loc_4789C:                              ; CODE XREF: Boss_Epsilon1SpawnProjectileRing+48   j
                                        ; Boss_Epsilon1SpawnProjectileRing+52   j ...
                move.l  (dword_FFC6DC).w,d0
                add.l   (dword_FFC6D8).w,d0
                cmpi.l  #$20000,d0
                bge.s   loc_4788A
                cmpi.l  #$FFFE0000,d0
                ble.s   loc_47894
                move.l  d0,(dword_FFC6D8).w
                move.l  (dword_FFC6D8).w,d0
                add.l   d0,(dword_FFC690).w
                rts
; End of function Boss_Epsilon1SpawnProjectileRing
; Checks if boss enters berserk mode
Boss_Epsilon1BerserkCheck:                              ; CODE XREF: Boss_Epsilon1Main+16E   p  ; was: sub_478C2
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_478E8
                move.w  $52(a5),d0
                add.w   d0,d0
                move.w  word_478EA(pc,d0.w),(word_FFE37C).w
                addq.w  #1,$52(a5)
                cmpi.w  #$E,$52(a5)
                bne.s   locret_478E8
                clr.w   $52(a5)
locret_478E8:                           ; CODE XREF: Boss_Epsilon1BerserkCheck+8   j
                                        ; Boss_Epsilon1BerserkCheck+20   j
                rts
; End of function Boss_Epsilon1BerserkCheck
; ---------------------------------------------------------------------------
word_478EA:     dc.w $E, $C, $A, 8, 6, 4, 2, 0, 2, 4, 6, 8, $A, $C
                                        ; DATA XREF: Boss_Epsilon1BerserkCheck+10   r


; Updates rotation transformation matrix
Boss_Epsilon1UpdateRotationMatrix:                              ; CODE XREF: Boss_Epsilon1Main+B0   p  ; was: sub_47906
                lea     (dword_FF8A00).w,a1
                move.w  #$13,d7
                move.w  #$30,d0 ; '0'
loc_47912:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+E   j
                move.w  d0,(a1)+
                dbf     d7,loc_47912
                move.w  (dword_FFA90C).w,d2
                lea     (dword_FF8A00).w,a1
                lea     (word_1B514).l,a2
                lea     (dword_FF942C).w,a3
                lea     (dword_FF9466).w,a4
                move.w  (dword_FFC690).w,d6
                subi.w  #$40,d6 ; '@'
                move.w  #7,d7
loc_4793A:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+50   j
                move.w  d6,d1
                subi.w  #$80,d1
                bmi.s   loc_47952
                cmpi.w  #$140,d1
                bhi.s   loc_47952
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d2,(a1,d1.w)
loc_47952:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+3A   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+40   j
                addi.w  #$10,d6
                dbf     d7,loc_4793A
                move.w  d2,d3
                subq.w  #8,d3
                move.w  #5,d7
                lea     (dword_FF9400).w,a0
                move.w  (dword_FFC690).w,d5
                move.w  d5,d6
                subi.w  #$60,d5 ; '`'
                addi.w  #$40,d6 ; '@'
loc_47974:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+102   j
                move.w  (a0)+,d0
                move.w  -$80(a2,d0.w),d0
                ext.l   d0
                asl.l   #6,d0
                swap    d0
                add.w   d0,d3
                add.w   (a4)+,d3
                cmpi.w  #$120,d3
                bgt.s   loc_479F8
                cmpi.w  #$48,d3 ; 'H'
                blt.s   loc_479F8
                move.w  d5,d1
                subi.w  #$80,d1
                bmi.s   loc_479A8
                cmpi.w  #$140,d1
                bgt.s   loc_479A8
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479A8:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+90   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+96   j
                move.w  d5,d1
                addi.w  #$10,d1
                subi.w  #$80,d1
                bmi.s   loc_479C4
                cmpi.w  #$140,d1
                bgt.s   loc_479C4
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479C4:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+AC   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+B2   j
                move.w  d6,d1
                subi.w  #$80,d1
                bmi.s   loc_479DC
                cmpi.w  #$140,d1
                bgt.s   loc_479DC
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479DC:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+C4   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+CA   j
                move.w  d6,d1
                addi.w  #$10,d1
                subi.w  #$80,d1
                bmi.s   loc_479F8
                cmpi.w  #$140,d1
                bgt.s   loc_479F8
                andi.w  #$1F0,d1
                lsr.w   #3,d1
                move.w  d3,(a1,d1.w)
loc_479F8:                              ; CODE XREF: Boss_Epsilon1UpdateRotationMatrix+82   j
                                        ; Boss_Epsilon1UpdateRotationMatrix+88   j ...
                subi.w  #$20,d5 ; ' '
                addi.w  #$20,d6 ; ' '
                move.w  d3,(a3)
                move.w  d3,$C(a3)
                addq.w  #2,a3
                dbf     d7,loc_47974
                rts
; End of function Boss_Epsilon1UpdateRotationMatrix
; Phase transition with graphics load
Boss_Epsilon1PhaseTransition:                              ; CODE XREF: Boss_Epsilon1Main+B4   p  ; was: sub_47A0E
                tst.b   (word_FFF720).w
                bmi.w   locret_47B06
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                tst.w   d0
                beq.s   loc_47A44
                cmpi.w  #$70,4(a5) ; 'p'
                bcc.w   locret_47B06
                cmpi.w  #1,d0
                beq.w   loc_47AD2
                cmpi.w  #2,d0
                beq.w   loc_47ADA
                cmpi.w  #3,d0
                beq.w   loc_47AE2
loc_47A44:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+12   j
                cmpi.w  #$180,(dword_FFA908).w
                bgt.s   loc_47AC0
                cmpi.w  #$FF80,(dword_FFA908).w
                blt.w   loc_47AC0
                cmpi.w  #$20,(dword_FFA90C).w ; ' '
                blt.s   loc_47A6C
                cmpi.w  #$120,(dword_FFA90C).w
                bgt.s   loc_47A6C
                bsr.w Gfx_LoadEpsilon1Tiles1
                bra.s   loc_47A70
; ---------------------------------------------------------------------------
loc_47A6C:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+4E   j
                                        ; Boss_Epsilon1PhaseTransition+56   j
                bsr.w Boss_Epsilon1LoadGraphicsPhase2
loc_47A70:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+5C   j
                cmpi.w  #$40,(dword_FFA90C).w ; '@'
                blt.s   loc_47A86
                cmpi.w  #$140,(dword_FFA90C).w
                bgt.s   loc_47A86
                bsr.w Gfx_LoadEpsilon1Tiles2
                bra.s   loc_47A8A
; ---------------------------------------------------------------------------
loc_47A86:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+68   j
                                        ; Boss_Epsilon1PhaseTransition+70   j
                bsr.w Boss_Epsilon1LoadGraphicsPhase3
loc_47A8A:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+76   j
                cmpi.w  #$60,(dword_FFA90C).w ; '`'
                blt.s   loc_47AA0
                cmpi.w  #$160,(dword_FFA90C).w
                bgt.s   loc_47AA0
                bsr.w Gfx_LoadEpsilon1Tiles3
                bra.s   loc_47AA4
; ---------------------------------------------------------------------------
loc_47AA0:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+82   j
                                        ; Boss_Epsilon1PhaseTransition+8A   j
                bsr.w Boss_Epsilon1LoadGraphicsPhase4
loc_47AA4:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+90   j
                cmpi.w  #$80,(dword_FFA90C).w
                blt.s   loc_47ABA
                cmpi.w  #$180,(dword_FFA90C).w
                bgt.s   loc_47ABA
                bsr.w Gfx_LoadEpsilon1Tiles4
                rts
; ---------------------------------------------------------------------------
loc_47ABA:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+9C   j
                                        ; Boss_Epsilon1PhaseTransition+A4   j
                bsr.w Boss_Epsilon1LoadGraphicsPhase5
                rts
; ---------------------------------------------------------------------------
loc_47AC0:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+3C   j
                                        ; Boss_Epsilon1PhaseTransition+44   j
                bsr.w Boss_Epsilon1LoadGraphicsPhase2
                bsr.w Boss_Epsilon1LoadGraphicsPhase3
                bsr.w Boss_Epsilon1LoadGraphicsPhase4
                bsr.w Boss_Epsilon1LoadGraphicsPhase5
                rts
; ---------------------------------------------------------------------------
loc_47AD2:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+22   j
                move.w  #0,(word_FF9444).w
                bra.s   loc_47AE8
; ---------------------------------------------------------------------------
loc_47ADA:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+2A   j
                move.w  #2,(word_FF9444).w
                bra.s   loc_47AE8
; ---------------------------------------------------------------------------
loc_47AE2:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+32   j
                move.w  #4,(word_FF9444).w
loc_47AE8:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+CA   j
                                        ; Boss_Epsilon1PhaseTransition+D2   j
                move.w  #2,(dword_FF9418).w
loc_47AEE:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+F6   j
                move.w  (word_FF9444).w,d0
                bsr.s Boss_Epsilon1UpdatePaletteAnim
                move.w  (word_FF9444).w,d0
                addq.w  #6,d0
                bsr.s Boss_Epsilon1UpdatePaletteAnim
                addq.w  #1,(word_FF9444).w
                subq.w  #1,(dword_FF9418).w
                bne.s   loc_47AEE
locret_47B06:                           ; CODE XREF: Boss_Epsilon1PhaseTransition+4   j
                                        ; Boss_Epsilon1PhaseTransition+1A   j
                rts
; End of function Boss_Epsilon1PhaseTransition
; Updates palette animation
Boss_Epsilon1UpdatePaletteAnim:                              ; CODE XREF: Boss_Epsilon1PhaseTransition+E4   p  ; was: sub_47B08
                                        ; Boss_Epsilon1PhaseTransition+EC   p
                lea     (word_FF9446).w,a0
                add.w   d0,d0
                move.w  #$4000,d1
                add.w   word_47B56(pc,d0.w),d1
                move.w  d1,(a0)
                move.w  #$2000,2(a0)
                move.w  #1,4(a0)
                lea     (dword_FF944E).w,a1
                move.w  (a1,d0.w),d1
                bne.s   loc_47B40
                cmpi.w  #$C,d0
                bcs.s   loc_47B38
                subi.w  #$C,d0
loc_47B38:                              ; CODE XREF: Boss_Epsilon1UpdatePaletteAnim+2A   j
                lea     (dword_FF9400).w,a1
                move.w  (a1,d0.w),d1
loc_47B40:                              ; CODE XREF: Boss_Epsilon1UpdatePaletteAnim+24   j
                addi.w  #$10,d1
                andi.w  #$1E0,d1
                lsr.w   #4,d1
                move.w  word_47B6E(pc,d1.w),6(a0)
                jmp Gfx_DMATransferTiles
; End of function Boss_Epsilon1UpdatePaletteAnim
; ---------------------------------------------------------------------------
word_47B56:     dc.w $1A8, $1A0, $198, $190, $188, $180, $1D0, $1D8, $1E0, $1E8, $1F0, $1F8
                                        ; DATA XREF: Boss_Epsilon1UpdatePaletteAnim+A   r
word_47B6E:     dc.w $989C, $999D, $9A9E, $9B9F, $A0A4, $A0A4, $A0A4, $A0A4, $A0A4, $9B9F, $9A9E, $999D, $989C, $989C, $989C, $989C
                                        ; DATA XREF: Boss_Epsilon1UpdatePaletteAnim+42   r


; Intro controller state dispatcher
Boss_Epsilon1IntroController:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_47B8E
                move.w  4(a5),d0
                lea     off_47B9A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1IntroController
; ---------------------------------------------------------------------------
off_47B9A:      dc.w Boss_Epsilon1SpawnIntroProjectile-*        ; DATA XREF: Boss_Epsilon1IntroController+4   o
                dc.w Boss_Epsilon1WaitForProjectile-*
                dc.w Boss_Epsilon1RepeatIntro-*
                dc.w Boss_Epsilon1IntroFadeOut-*


; Spawns boss intro projectile
Boss_Epsilon1SpawnIntroProjectile:                              ; DATA XREF: ROM:off_47B9A   o  ; was: sub_47BA2
                tst.b   (word_FF80C2).w
                bne.s   locret_47BD2
                addq.w  #2,4(a5)
                move.w  #2,$4A(a5)
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$278,(a0)
                move.w  #$C3C0,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  #$C80,2(a0)
locret_47BD2:                           ; CODE XREF: Boss_Epsilon1SpawnIntroProjectile+4   j
                rts
; End of function Boss_Epsilon1SpawnIntroProjectile
; Waits for projectile completion
Boss_Epsilon1WaitForProjectile:                              ; DATA XREF: ROM:00047B9C   o  ; was: sub_47BD4
                tst.w   (word_FFC7A4).w
                bne.s   locret_47BE8
                move.w  #1,(word_FFC7FE).w
                addq.w  #2,(word_FFC7A4).w
                addq.w  #2,4(a5)
locret_47BE8:                           ; CODE XREF: Boss_Epsilon1WaitForProjectile+4   j
                rts
; End of function Boss_Epsilon1WaitForProjectile
; Repeats intro sequence
Boss_Epsilon1RepeatIntro:                              ; DATA XREF: ROM:00047B9E   o  ; was: sub_47BEA
                cmpi.w  #$C,(word_FFC7A4).w
                bne.s   locret_47C00
                addq.w  #2,(word_FFC7A4).w
                subq.w  #1,$4A(a5)
                beq.s   loc_47C02
                subq.w  #2,4(a5)
locret_47C00:                           ; CODE XREF: Boss_Epsilon1RepeatIntro+6   j
                rts
; ---------------------------------------------------------------------------
loc_47C02:                              ; CODE XREF: Boss_Epsilon1RepeatIntro+10   j
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1RepeatIntro
; Timer countdown with fade out
Boss_Epsilon1IntroFadeOut:                              ; DATA XREF: ROM:00047BA0   o  ; was: sub_47C0E
                subq.w  #1,$48(a5)
                bne.s   locret_47C1A
                move.w  #$1000,2(a5)
locret_47C1A:                           ; CODE XREF: Boss_Epsilon1IntroFadeOut+4   j
                rts
; End of function Boss_Epsilon1IntroFadeOut
; Main Sharpsteel boss handler
Boss_SharpssteelMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_47C1C
                tst.w   4(a5)
                beq.w   loc_47C4C
                tst.w   8(a5)
                beq.s   loc_47C4C
                btst    #2,(byte_FF80EC).w
                bne.s   loc_47C42
                btst    #1,(byte_FF80EC).w
                bne.s   loc_47C42
                tst.w   (word_FF8200).w
                beq.w Boss_SharpssteelSpawnDebris
loc_47C42:                              ; CODE XREF: Boss_SharpssteelMain+14   j
                                        ; Boss_SharpssteelMain+1C   j
                jsr (Gfx_InitPaletteFade).l
                bsr.w Boss_SharpssteelUpdateCore
loc_47C4C:                              ; CODE XREF: Boss_SharpssteelMain+4   j
                                        ; Boss_SharpssteelMain+C   j
                move.w  4(a5),d0
                movea.w off_47C5C(pc,d0.w),a0
                adda.l  #nullsub_95,a0
                jmp     (a0)
; End of function Boss_SharpssteelMain
; ---------------------------------------------------------------------------
off_47C5C:      dc.w Boss_SharpssteelWaitPlayerReady-nullsub_95
                                        ; DATA XREF: Boss_SharpssteelMain+34   r
                dc.w Boss_SharpssteelInit-nullsub_95
                dc.w Boss_SharpssteelInputHandler-nullsub_95
                dc.w Boss_SharpssteelMultiPhaseAttack-nullsub_95
                dc.w Boss_Sharpssteel_State13-nullsub_95
                dc.w Boss_Sharpssteel_State15-nullsub_95
                dc.w Boss_SharpssteelUpdateBlades-nullsub_95
                dc.w Boss_SharpssteelSpawnBlades-nullsub_95
                dc.w Boss_Jampan_State1-nullsub_95
                dc.w Boss_SharpssteelInitBattle-nullsub_95
                dc.w Boss_Jampan_State3-nullsub_95
                dc.w Boss_SharpssteelSetRotation-nullsub_95
                dc.w Boss_Jampan_State5-nullsub_95
                dc.w Boss_Jampan_State6-nullsub_95
                dc.w Boss_SharpssteelAttackPattern1-nullsub_95
                dc.w Boss_SharpssteelDefeatFade-nullsub_95
                dc.w Boss_SharpssteelAttackPattern2Alt-nullsub_95
                dc.w Boss_SharpssteelRisingAttack-nullsub_95
                dc.w Boss_SharpssteelTimerCountdown-nullsub_95
                dc.w Boss_SharpssteelDefeatCounter-nullsub_95
                dc.w Boss_Sharpssteel_State21-nullsub_95
                dc.w Boss_Jampan_State13-nullsub_95
                dc.w Boss_SharpssteelComplexPhase-nullsub_95
                dc.w Boss_Sharpssteel_AccelerateDown-nullsub_95
                dc.w Boss_Sharpssteel_State27-nullsub_95
                dc.w Boss_Sharpssteel_State28-nullsub_95
                dc.w Boss_Sharpssteel_State29-nullsub_95
                dc.w Boss_SharpssteelBladeDefeat-nullsub_95


nullsub_95:                             ; CODE XREF: Boss_SharpssteelTimerCountdown+4   j
                                        ; DATA XREF: Boss_SharpssteelMain+38   o ...
                rts
; End of function nullsub_95


; Waits for player ready
Boss_SharpssteelWaitPlayerReady:                              ; DATA XREF: ROM:off_47C5C   o  ; was: sub_47C96
                tst.w   (word_FF80C2).w
                bne.s   locret_47CA4
                addq.w  #2,4(a5)
                clr.w   8(a5)
locret_47CA4:                           ; CODE XREF: Boss_SharpssteelWaitPlayerReady+4   j
                rts
; End of function Boss_SharpssteelWaitPlayerReady
; Initializes Sharpsteel boss parts
Boss_SharpssteelInit:                              ; DATA XREF: ROM:00047C5E   o  ; was: sub_47CA6
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$11,d7
                movea.l #off_35220,a0
                movea.l #word_35268,a1
                movea.l #word_3527A,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$C300,$36E(a5)
                move.w  #$C300,$4EE(a5)
                move.w  #$21C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #$CC00,$C2(a5)
                bsr.w Boss_SharpssteelCoreDispatcher
                movea.l #word_1BCB2,a1
                jsr (Sprite_InitFromPointerTable).l
                move.w  #2,$1DE(a5)
                bra.w Boss_SharpssteelBattleActive
; End of function Boss_SharpssteelInit
; Initializes boss state with velocity limits
Boss_SharpssteelInitState:
                move.w  #4,4(a5)  ; was: sub_47D06
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                moveq   #4,d0
                bsr.w Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelInitState
; Handles player input for boss rotation control
Boss_SharpssteelInputHandler:                              ; DATA XREF: ROM:00047C60   o  ; was: sub_47D3C
                btst    #5,(word_FFF708).w
                beq.s   loc_47D48
                bsr.w Boss_SharpssteelCoreDispatcher
loc_47D48:                              ; CODE XREF: Boss_SharpssteelInputHandler+6   j
                btst    #4,(word_FFF708).w
                beq.s   loc_47D54
                bsr.w Boss_SharpssteelCoreActive
loc_47D54:                              ; CODE XREF: Boss_SharpssteelInputHandler+12   j
                btst    #2,(word_FFF706).w
                beq.s   loc_47D60
                addq.w  #2,$56(a5)
loc_47D60:                              ; CODE XREF: Boss_SharpssteelInputHandler+1E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_47D6C
                subq.w  #2,$56(a5)
loc_47D6C:                              ; CODE XREF: Boss_SharpssteelInputHandler+2A   j
                andi.w  #$1FE,$56(a5)
                lea     byte_48BA6(pc),a1
                nop
                bsr.w Boss_SharpssteelCoreInit
                bra.w   loc_48694
; End of function Boss_SharpssteelInputHandler
; Palette fade during defeat sequence
Boss_SharpssteelDefeatFade:                              ; DATA XREF: ROM:00047C7A   o  ; was: sub_47D80
                jsr (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bpl.s   locret_47D92
                bset    #4,2(a5)
locret_47D92:                           ; CODE XREF: Boss_SharpssteelDefeatFade+A   j
                rts
; End of function Boss_SharpssteelDefeatFade
; Active battle state
Boss_SharpssteelBattleActive:                              ; CODE XREF: Boss_SharpssteelInit+5C   j  ; was: sub_47D94
                move.w  #$C,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #3,$182(a5)
                move.w  #$FFE0,$190(a5)
                move.w  #$168,$3D4(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C9E0,$4A(a5)
                move.w  #$80,$56(a5)
                move.w  #1,$11C(a5)
                move.w  #$120,$11E(a5)
                move.w  #$A0,$17C(a5)
                bsr.w Boss_SharpssteelCoreDispatcher
                bsr.w Boss_SharpssteelEnableMultipleHitboxes
                moveq   #$C,d0
                bsr.w Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelBattleActive
; Updates all blade positions
Boss_SharpssteelUpdateBlades:                              ; DATA XREF: ROM:00047C68   o  ; was: sub_47DE8
                subq.w  #1,$17C(a5)
                bmi.s   loc_47DF6
                bsr.w Boss_SharpssteelHorizontalMovement
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47DF6:                              ; CODE XREF: Boss_SharpssteelUpdateBlades+4   j
                addq.w  #2,4(a5)
                moveq   #4,d0
                jsr (UI_CheckVictoryCondition).l
; End of function Boss_SharpssteelUpdateBlades
; Spawns blade entities
Boss_SharpssteelSpawnBlades:                              ; DATA XREF: ROM:00047C6A   o  ; was: sub_47E02
                tst.w   (word_FF80C2).w
                beq.s   loc_47E10
                bsr.w Boss_SharpssteelHorizontalMovement
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E10:                              ; CODE XREF: Boss_SharpssteelSpawnBlades+4   j
                addq.w  #2,4(a5)
; Jampan boss entry state
Boss_Jampan_State1:                              ; DATA XREF: ROM:00047C6C   o  ; was: loc_47E14
                addq.w  #1,$3D4(a5)
                cmpi.w  #$1C0,$3D4(a5)
                bpl.s   loc_47E28
                bsr.w Boss_SharpssteelHorizontalMovement
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E28:                              ; CODE XREF: Boss_SharpssteelSpawnBlades+1C   j
                bclr    #3,$182(a5)
                addq.w  #2,4(a5)
                bsr.w Boss_SharpssteelUpdateRotation
; End of function Boss_SharpssteelSpawnBlades
; Initializes battle phase
Boss_SharpssteelInitBattle:                              ; DATA XREF: ROM:00047C6E   o  ; was: sub_47E36
                subi.l  #$22000,$2FC(a5)
                bmi.s   loc_47E54
                move.w  (word_FF9600).w,$190(a5)
                bsr.w Boss_SharpssteelIncreaseSpeed
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E54:                              ; CODE XREF: Boss_SharpssteelInitBattle+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5) ; ' '
                move.b  #$10,$E1(a5)
; Jampan boss attack phase
Boss_Jampan_State3:                              ; DATA XREF: ROM:00047C70   o  ; was: loc_47E64
                subq.w  #1,$11C(a5)
                bmi.s   loc_47E7E
                move.w  (word_FF9600).w,$190(a5)
                bsr.w Boss_SharpssteelIncreaseSpeed
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E7E:                              ; CODE XREF: Boss_SharpssteelInitBattle+32   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                bsr.w Boss_SharpssteelBladeCheckHit
                bsr.w Boss_SharpssteelBladeUpdate
; End of function Boss_SharpssteelInitBattle
; Sets rotation parameters
Boss_SharpssteelSetRotation:                              ; DATA XREF: ROM:00047C72   o  ; was: sub_47E98
                cmpi.w  #2,$29C(a5)
                bpl.s   loc_47EB4
loc_47EA0:                              ; CODE XREF: Boss_SharpssteelSetRotation+30   j
                                        ; Boss_SharpssteelSetRotation+50   j
                move.w  (word_FF9600).w,$190(a5)
                bsr.w Boss_SharpssteelIncreaseSpeed
                lea     byte_48BE8(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47EB4:                              ; CODE XREF: Boss_SharpssteelSetRotation+6   j
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFDBE4).w
; Jampan boss movement state
Boss_Jampan_State5:                              ; DATA XREF: ROM:00047C74   o  ; was: loc_47EBC
                cmpi.w  #7,$29C(a5)
                bpl.s   loc_47ECA
                bsr.w Boss_SharpssteelAttackPattern2
                bra.s   loc_47EA0
; ---------------------------------------------------------------------------
loc_47ECA:                              ; CODE XREF: Boss_SharpssteelSetRotation+2A   j
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFDBE4).w
                move.l  #$FFFD8000,(dword_FFDBF8).w
                move.l  #$FFFD0000,(dword_FFDBFC).w
; Jampan boss combo state
Boss_Jampan_State6:                              ; DATA XREF: ROM:00047C76   o  ; was: loc_47EE2
                tst.w   $58(a5)
                bmi.s   loc_47EEA
                bra.s   loc_47EA0
; ---------------------------------------------------------------------------
loc_47EEA:                              ; CODE XREF: Boss_SharpssteelSetRotation+4E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5) ; ' '
                bsr.w Boss_SharpssteelUpdateTargets
; End of function Boss_SharpssteelSetRotation
; Attack pattern 1
Boss_SharpssteelAttackPattern1:                              ; DATA XREF: ROM:00047C78   o  ; was: sub_47F02
                subq.w  #1,$11C(a5)
                bpl.s   loc_47F16
                clr.b   (byte_FF80EC).w
                move.w  #$B,$35C(a5)
                bra.w   loc_480E0
; ---------------------------------------------------------------------------
loc_47F16:                              ; CODE XREF: Boss_SharpssteelAttackPattern1+4   j
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelAttackPattern1
; Attack pattern 2
Boss_SharpssteelAttackPattern2:                              ; CODE XREF: Boss_SharpssteelSetRotation+2C   p  ; was: sub_47F24
                move.w  $370(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FFDBF0).w
                move.w  $374(a5),d0
                addi.w  #-$10,d0
                move.w  d0,(word_FFDBF4).w
                rts
; End of function Boss_SharpssteelAttackPattern2
; Updates rotation speed
Boss_SharpssteelUpdateRotation:                              ; CODE XREF: Boss_SharpssteelSpawnBlades+30   p  ; was: sub_47F3E
                                        ; Boss_SharpssteelMultiPhaseAttack+F0   p
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C7A0,$4A(a5)
                move.w  #$120,$194(a5)
                move.w  #$120,$190(a5)
                move.b  #$10,(byte_FFA420).w
                move.l  #$E00000,$2FC(a5)
                bsr.w Boss_SharpssteelCoreDamage
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
                clr.w   $56(a5)
                bsr.w Boss_SharpssteelCoreActive
                bsr.w Boss_SharpssteelBladeInit
                moveq   #$18,d0
                bsr.w Boss_SharpssteelCoreIdle
                moveq   #$18,d0
                bra.w   loc_48946
; End of function Boss_SharpssteelUpdateRotation
; Starts defeat sequence
Boss_SharpssteelDefeatStart:                              ; CODE XREF: Boss_SharpssteelAttackPattern1:loc_47F16   p  ; was: sub_47F9C
                                        ; Boss_SharpssteelAttackPattern1Alt+10   p ...
                move.w  (word_FF960A).w,$190(a5)
; End of function Boss_SharpssteelDefeatStart
; Increases rotation speed
Boss_SharpssteelIncreaseSpeed:                              ; CODE XREF: Boss_SharpssteelInitBattle+10   p  ; was: sub_47FA2
                                        ; Boss_SharpssteelInitBattle+3A   p ...
                move.w  (dword_FFDB34).w,d0
                add.w   $2FC(a5),d0
                addi.w  #-$C,d0
                move.w  d0,$194(a5)
                rts
; End of function Boss_SharpssteelIncreaseSpeed
; Updates six target addresses with calculated value
Boss_SharpssteelUpdateTargets:                              ; CODE XREF: Boss_SharpssteelSetRotation+66   p  ; was: sub_47FB4
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FFDB30).w,d1
                addi.w  #$74,d1 ; 't'
                moveq   #5,d7
loc_47FC2:                              ; CODE XREF: Boss_SharpssteelUpdateTargets+10   j
                move.w  d1,(a0)+
                dbf     d7,loc_47FC2
                rts
; End of function Boss_SharpssteelUpdateTargets
; Updates core position
Boss_SharpssteelUpdateCore:                              ; CODE XREF: Boss_SharpssteelMain+2C   p  ; was: sub_47FCA
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FFDB30).w,d1
                addi.w  #$74,d1 ; 't'
                moveq   #5,d7
loc_47FD8:                              ; CODE XREF: Boss_SharpssteelUpdateCore+14   j
                move.w  (a0),d0
                move.w  d1,(a0)+
                move.w  d0,d1
                dbf     d7,loc_47FD8
                rts
; End of function Boss_SharpssteelUpdateCore
; Controls horizontal movement with target tracking
Boss_SharpssteelHorizontalMovement:                              ; CODE XREF: Boss_SharpssteelUpdateBlades+6   p  ; was: sub_47FE4
                                        ; Boss_SharpssteelSpawnBlades+6   p ...
                btst    #0,$23E(a5)
                beq.s   loc_47FF6
                moveq   #2,d7
                move.w  $2B0(a5),d5
                bsr.w Boss_SharpssteelSpawnAngleProjectiles
loc_47FF6:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+6   j
                move.w  $10(a5),d0
                move.l  $198(a5),d1
                tst.w   $11C(a5)
                bmi.s   loc_48050
                cmp.w   $11E(a5),d0
                bmi.s   loc_48032
                move.w  #$FFFF,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addq.w  #8,d0
                neg.w   d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$B0,d0
                bpl.s   loc_48088
                move.w  #$B0,$11E(a5)
                bra.s   loc_48088
; ---------------------------------------------------------------------------
loc_48032:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+24   j
                tst.l   d1
                bmi.s   loc_4803E
                cmpi.l  #$10000,d1
                bpl.s   loc_48092
loc_4803E:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+50   j
                                        ; Boss_SharpssteelHorizontalMovement+8E   j ...
                addi.l  #$E00,d1
                move.l  d1,$198(a5)
                lea     byte_48BCC(pc),a1
                nop
                rts
; ---------------------------------------------------------------------------
loc_48050:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+1E   j
                cmp.w   $11E(a5),d0
                bpl.s   loc_4807C
                move.w  #1,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addq.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$160,d0
                bmi.s   loc_4803E
                move.w  #$160,$11E(a5)
                bra.s   loc_4803E
; ---------------------------------------------------------------------------
loc_4807C:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+70   j
                tst.l   d1
                bpl.s   loc_48088
                cmpi.l  #$FFFE2000,d1
                bmi.s   loc_48092
loc_48088:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+44   j
                                        ; Boss_SharpssteelHorizontalMovement+4C   j ...
                subi.l  #$2000,d1
                move.l  d1,$198(a5)
loc_48092:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+58   j
                                        ; Boss_SharpssteelHorizontalMovement+A2   j
                lea     byte_48BB0(pc),a1
                nop
                rts
; End of function Boss_SharpssteelHorizontalMovement
; Spawns projectiles at calculated angles
Boss_SharpssteelSpawnAngleProjectiles:                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+E   p  ; was: sub_4809A
                move.w  #$150,d6
                movea.w #(dword_FFFF08-M68K_RAM),a4
loc_480A2:                              ; CODE XREF: Boss_SharpssteelSpawnAngleProjectiles+1A   j
                move.b  (a4)+,d4
                andi.w  #$3E,d4 ; '>'
                addi.w  #$120,d4
                jsr (Enemy_SpawnProjectileAtAngle).l
                bne.s   loc_480B8
                dbf     d7,loc_480A2
loc_480B8:                              ; CODE XREF: Boss_SharpssteelSpawnAngleProjectiles+18   j
                move.b  #$4C,d0 ; 'L'
                jmp (Sound_PlaySFX).l
; End of function Boss_SharpssteelSpawnAngleProjectiles
; Attack pattern with distance check and blade init
Boss_SharpssteelAttackPattern1Alt:                              ; CODE XREF: Boss_SharpssteelDefeatCounter+38   j  ; was: sub_480C2
                move.w  #$2A,4(a5) ; '*'
                clr.w   $23E(a5)
; Jampan boss advanced phase
Boss_Jampan_State13:                              ; DATA XREF: ROM:00047C86   o  ; was: loc_480CC
                tst.w   $23E(a5)
                bne.s   loc_480E0
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_480E0:                              ; CODE XREF: Boss_SharpssteelAttackPattern1+10   j
                                        ; Boss_SharpssteelAttackPattern1Alt+E   j ...
                subq.w  #1,$35C(a5)
                bpl.s   loc_48108
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,$11C(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                move.w  d0,$35C(a5)
                bra.w Boss_SharpssteelAttackPattern3
; ---------------------------------------------------------------------------
loc_48108:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+22   j
                jsr (Physics_CalculateDistanceTo).l
                move.b  (dword_FFFF08).w,d2
                clr.w   $54(a5)
                tst.w   d1
                bmi.w   loc_48122
                move.w  #$100,$54(a5)
loc_48122:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+56   j
                cmpi.w  #$3C,d0 ; '<'
                bpl.s   loc_4812C
                bra.w   loc_4818E
; ---------------------------------------------------------------------------
loc_4812C:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+64   j
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_48130:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt:loc_4812C   j
                move.w  #$20,4(a5) ; ' '
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w Boss_SharpssteelBladeInit
                moveq   #$40,d0 ; '@'
                bsr.w Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelAttackPattern1Alt
; Attack pattern with blade update and core flash
Boss_SharpssteelAttackPattern2Alt:                              ; DATA XREF: ROM:00047C7C   o  ; was: sub_4814E
                tst.w   $58(a5)
                bmi.w   loc_480E0
                btst    #0,$23E(a5)
                beq.s   loc_48174
                bsr.w Boss_SharpssteelBladeUpdate
                move.w  #$A7,d1
                bsr.w Boss_SharpssteelEnableHitboxSet2
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
loc_48174:                              ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+E   j
                btst    #1,$23E(a5)
                beq.s   loc_48180
                bsr.w Boss_SharpssteelCoreFlash
loc_48180:                              ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+2C   j
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C4C(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4818E:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+66   j
                move.w  #$36,4(a5) ; '6'
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w Boss_SharpssteelBladeInit
                moveq   #$10,d0
                bsr.w Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelAttackPattern2Alt
; Blade defeat state
Boss_SharpssteelBladeDefeat:                              ; DATA XREF: ROM:00047C92   o  ; was: sub_481AC
                tst.w   $58(a5)
                bmi.w   loc_480E0
                btst    #0,$23E(a5)
                beq.s   loc_481D2
                bsr.w Boss_SharpssteelBladeUpdate
                move.w  #$82,d1
                bsr.w Boss_SharpssteelEnableHitboxSet2
                move.b  #$DC,d0
                jsr (Sound_PlaySFX).l
loc_481D2:                              ; CODE XREF: Boss_SharpssteelBladeDefeat+E   j
                btst    #1,$23E(a5)
                beq.s   loc_481E2
                bsr.w Boss_SharpssteelCoreFlash
                bsr.w Boss_SharpssteelPaletteFadeSetup
loc_481E2:                              ; CODE XREF: Boss_SharpssteelBladeDefeat+2C   j
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C6E(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelBladeDefeat
; Complex attack with rotation and subsystem calls
Boss_SharpssteelAttackPattern3:                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+42   j  ; was: sub_481F0
                move.w  #$22,4(a5) ; '"'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                clr.w   $54(a5)
                move.w  #6,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #2,$3BE(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFFDC000,$DC(a5)
                bsr.w Boss_SharpssteelCoreDamage
                bsr.w Boss_SharpssteelDisableHitboxGroup1
                bsr.w Boss_SharpssteelDisableHitboxGroup2
                bsr.w Boss_SharpssteelBladeInit
                bsr.w Boss_SharpssteelPaletteFadeSetup
; End of function Boss_SharpssteelAttackPattern3
; Rising attack with velocity increase
Boss_SharpssteelRisingAttack:                              ; DATA XREF: ROM:00047C7E   o  ; was: sub_48246
                cmpi.w  #$200,$14(a5)
                bpl.w   loc_482A8
                addi.l  #$4000,$DC(a5)
                tst.w   $11E(a5)
                bne.s   loc_4828E
                cmpi.w  #$160,$14(a5)
                bmi.s   loc_4828E
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                moveq   #$60,d3 ; '`'
                clr.w   (word_FF808A).w
                jsr     (loc_E28A).l
                move.w  #$8000,(word_FF808A).w
                move.b  #$4D,d0 ; 'M'
                jsr (Sound_PlaySFX).l
loc_4828E:                              ; CODE XREF: Boss_SharpssteelRisingAttack+16   j
                                        ; Boss_SharpssteelRisingAttack+1E   j
                lea     byte_48C90(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelRisingAttack
; Sets random timer for next attack phase
Boss_SharpssteelSetTimer:                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+DC   j  ; was: sub_48298
                move.w  (dword_FFFF08).w,d0
                move.w  #$F,d0
                addi.w  #$10,d0
                move.w  d0,$11C(a5)
loc_482A8:                              ; CODE XREF: Boss_SharpssteelRisingAttack+6   j
                move.w  #$24,4(a5) ; '$'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bsr.w Boss_SharpssteelCoreDamage
; End of function Boss_SharpssteelSetTimer
; Countdown timer branching to attack patterns
Boss_SharpssteelTimerCountdown:                              ; DATA XREF: ROM:00047C80   o  ; was: sub_482C2
                subq.w  #1,$11C(a5)
                bpl.w   nullsub_95
loc_482CA:                              ; CODE XREF: Boss_SharpssteelComplexPhase+112   j
                subq.w  #1,$35C(a5)
                bpl.s   loc_482E2
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #6,d0
                move.w  d0,$35C(a5)
                bra.w   loc_48430
; ---------------------------------------------------------------------------
loc_482E2:                              ; CODE XREF: Boss_SharpssteelTimerCountdown+C   j
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$120,$D0(a5)
                move.w  #$190,$D4(a5)
                clr.w   $56(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFF80000,$DC(a5)
                move.w  #$FFE4,$35E(a5)
                move.w  #1,$3BC(a5)
                move.w  #1,$3BE(a5)
                bsr.w Boss_SharpssteelCoreActive
                bsr.w Boss_SharpssteelBladeInit
                bsr.w Boss_SharpssteelPaletteFadeSetup
                bsr.w Boss_SharpssteelSpawnProjectileWave
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
; End of function Boss_SharpssteelTimerCountdown
; Multi-phase attack with velocity changes
Boss_SharpssteelMultiPhaseAttack:                              ; DATA XREF: ROM:00047C62   o  ; was: sub_48346
                addi.l  #$1400,$DC(a5)
                bpl.s   loc_4835A
                lea     byte_48C1E(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4835A:                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+8   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$100,$56(a5)
                bsr.w Boss_SharpssteelCoreActive
                bsr.w Boss_SharpssteelEnableMultipleHitboxes
                bsr.w Boss_SharpssteelEnableObjectFlags
; Sharpssteel boss transformation
Boss_Sharpssteel_State13:                              ; DATA XREF: ROM:00047C64   o  ; was: loc_4837A
                addi.l  #$2000,$DC(a5)
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0 ; ' '
                cmp.w   $D4(a5),d0
                bmi.s   loc_4839A
                lea     byte_48C2C(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4839A:                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+48   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                move.w  #8,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$2F,d0 ; '/'
                jsr (Sound_PlaySFX).l
                move.l  #$20000,(dword_FFDB3C).w
                move.w  #2,(word_FFDB78).w
                moveq   #0,d0
                move.w  #$B0,d0
                sub.w   (dword_FFDB30).w,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$D8(a5)
                move.l  #$FFFD8000,$DC(a5)
; Sharpssteel boss attack mode
Boss_Sharpssteel_State15:                              ; DATA XREF: ROM:00047C66   o  ; was: loc_483EA
                addi.l  #$3A00,$DC(a5)
                tst.w   $11E(a5)
                bne.s   loc_4841C
                cmpi.w  #$160,$D4(a5)
                bmi.s   loc_4841C
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                jsr (Projectile_SpawnQuadPattern).l
                move.b  #$4C,d0 ; 'L'
                jsr (Sound_PlaySFX).l
loc_4841C:                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+B0   j
                                        ; Boss_SharpssteelMultiPhaseAttack+B8   j
                cmpi.w  #$240,$D4(a5)
                bpl.w Boss_SharpssteelSetTimer
                lea     byte_48C3A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_48430:                              ; CODE XREF: Boss_SharpssteelTimerCountdown+1C   j
                move.w  #$26,4(a5) ; '&'
                bsr.w Boss_SharpssteelUpdateRotation
; End of function Boss_SharpssteelMultiPhaseAttack
; Defeat sequence with flashing and counter
Boss_SharpssteelDefeatCounter:                              ; DATA XREF: ROM:00047C82   o  ; was: sub_4843A
                subi.l  #$22000,$2FC(a5)
                bmi.s   loc_4845E
                cmpi.w  #$60,$2FC(a5) ; '`'
                bmi.s   loc_48450
                bsr.w   nullsub_96
loc_48450:                              ; CODE XREF: Boss_SharpssteelDefeatCounter+10   j
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4845E:                              ; CODE XREF: Boss_SharpssteelDefeatCounter+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5) ; ' '
                move.b  #$10,$E1(a5)
; Sharpssteel boss final phase
Boss_Sharpssteel_State21:                              ; DATA XREF: ROM:00047C84   o  ; was: loc_4846E
                subq.w  #1,$11C(a5)
                bmi.w Boss_SharpssteelAttackPattern1Alt
                bsr.w Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelDefeatCounter
nullsub_96:                             ; CODE XREF: Boss_SharpssteelDefeatCounter+12   p
                rts
; End of function nullsub_96


; Resets boss to center with initial velocity
Boss_SharpssteelResetPosition:
                move.w  #$2C,4(a5) ; ','  ; was: sub_48486
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFDB30).w,d0
                addi.w  #$74,d0 ; 't'
                move.w  d0,$10(a5)
                move.w  #$200,$14(a5)
                clr.w   $56(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.l   $18(a5)
                move.l  #$FFFD0000,$1C(a5)
                bsr.w Boss_SharpssteelCoreActive
                bsr.w Boss_SharpssteelEnableMultipleHitboxes
                movea.l #byte_48D78,a0
                bsr.w Boss_SharpssteelLoadAnimDelays
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
; End of function Boss_SharpssteelResetPosition
; Complex behavior with screen shake and projectiles
