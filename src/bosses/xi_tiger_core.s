Boss_XiTigerMain:                                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3D814
                tst.w   4(a5)
                beq.w   loc_3D878
                tst.w   8(a5)
                beq.s   loc_3D878
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3D85A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3D85A
                tst.w   (word_FF8200).w
                bne.s   loc_3D85A
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.b  #1,(byte_FF830E).w
                move.w  #$FFFF,(word_FF821E).w
                bra.w   Boss_XiTigerAttackPattern1
; ---------------------------------------------------------------------------
loc_3D85A:                                              ; CODE XREF: Boss_XiTigerMain+14   j
                                        ; Boss_XiTigerMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                move.w  #$13E,d0
                add.w   (dword_FFA904).w,d0
                move.w  d0,$23C(a5)
loc_3D878:                                              ; CODE XREF: Boss_XiTigerMain+4   j
                                        ; Boss_XiTigerMain+C   j
                move.w  4(a5),d0
                movea.w off_3D888(pc,d0.w),a0
                adda.l  #Boss_XiTigerInit,a0
                jmp     (a0)
; End of function Boss_XiTigerMain
; ---------------------------------------------------------------------------
off_3D888:      dc.w    Boss_XiTigerInit-Boss_XiTigerInit
                                        ; DATA XREF: Boss_XiTigerMain+68   r
                dc.w    Boss_XiTigerSetup-Boss_XiTigerInit
                dc.w    Boss_XiTigerFallingLanding-Boss_XiTigerInit
                dc.w    Boss_XiTigerBattleStart-Boss_XiTigerInit
                dc.w    Boss_XiTigerBattleActive-Boss_XiTigerInit
                dc.w    Boss_XiTigerMovementAI-Boss_XiTigerInit
                dc.w    Boss_XiTigerIdle_AttackDecision-Boss_XiTigerInit
                dc.w    Boss_XiTigerDash_Decelerate-Boss_XiTigerInit
                dc.w    Boss_XiTigerDashPrep-Boss_XiTigerInit
                dc.w    Boss_XiTigerDashDecelerate-Boss_XiTigerInit
                dc.w    Boss_XiTigerCloseRange_JumpPrep-Boss_XiTigerInit
                dc.w    Boss_XiTigerJumpRise-Boss_XiTigerInit
                dc.w    Boss_XiTigerJumpPeak-Boss_XiTigerInit
                dc.w    Boss_XiTigerLandedState-Boss_XiTigerInit
                dc.w    Boss_XiTigerAttackPattern2-Boss_XiTigerInit
                dc.w    Boss_XiTigerAttackPattern3-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatInit-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatUpdate-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatComplete-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatFinal-Boss_XiTigerInit
                dc.w    Boss_XiTigerCloseRangeAI-Boss_XiTigerInit

; Initializes Xi-Tiger boss clearing sprites
Boss_XiTigerInit:                                       ; DATA XREF: Boss_XiTigerMain+6C   o  ; was: sub_3D8B2
                                        ; ROM:off_3D888   o
                addq.w  #2,4(a5)
                move.w  #2,(word_FF821E).w
                move.w  #$114,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                addq.w  #1,8(a5)
locret_3D8CC:                                           ; CODE XREF: Boss_XiTigerSetup+4   j
                rts
; End of function Boss_XiTigerInit
; Complex setup with metasprite initialization
Boss_XiTigerSetup:                                      ; DATA XREF: ROM:0003D88A   o  ; was: sub_3D8CE
                tst.w   (word_FFF720).w
                bmi.s   locret_3D8CC
                movea.w a5,a4
                move.w  #$8280,(dword_FF8040).w
                moveq   #$18,d7
                movea.l #dword_34CF6,a0
                movea.l #word_34D5A,a1
                movea.l #word_34D74,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                bset    #0,2(a5)
                bset    #0,$6C2(a5)
                bset    #0,$902(a5)
                bset    #0,$482(a5)
                bset    #3,$482(a5)
                addq.w  #4,4(a5)
                move.w  #$114,(a5)
                move.w  #$D00,2(a5)
                clr.w   $54(a5)
                clr.w   $56(a5)
                movea.l #Boss_XiTigerObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #$C000,$242(a5)
                move.w  #$C000,$422(a5)
                move.l  #word_EBA68,$248(a5)
                move.l  #word_EBA68,$428(a5)
                move.w  #$2C,$266(a5)                   ; ','
                bclr    #7,$48E(a5)
                movea.l #$FFFF22C0,a0
                move.w  #$80,d0
                moveq   #9,d7
loc_3D96A:                                              ; CODE XREF: Boss_XiTigerSetup+AC   j
                moveq   #$F,d6
loc_3D96C:                                              ; CODE XREF: Boss_XiTigerSetup:loc_3D976   j
                move.w  (a0)+,d1
                beq.s   loc_3D976
                sub.w   d0,d1
                move.w  d1,-2(a0)
loc_3D976:                                              ; CODE XREF: Boss_XiTigerSetup+A0   j
                dbf     d6,loc_3D96C
                dbf     d7,loc_3D96A
                movea.l #word_3D9BE,a0
                jsr     (Gfx_LoadCompressedTiles).l
                bsr.w   Boss_XiTigerFlipDirection
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$E0,$490(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                lea     word_3E502(pc),a0
                nop
                bsr.w   Boss_XiTigerLoadAnimData
                bra.w   loc_3DA64
; End of function Boss_XiTigerSetup
; ---------------------------------------------------------------------------
word_3D9BE:     dc.w    $6100, $2000, $302, $1816, $1719, $1C1A, $1B1D, $1E, $1F00
                                        ; DATA XREF: Boss_XiTigerSetup+B0   o

; Xi-Tiger falling state with ground landing detection
Boss_XiTigerFallingLanding:                             ; DATA XREF: ROM:0003D88C   o  ; was: sub_3D9D0
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DA30
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DA30
                addq.w  #2,4(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  $23C(a5),$914(a5)
                move.w  #$CF20,$4A(a5)
                clr.l   $1C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_3DA64
; ---------------------------------------------------------------------------
loc_3DA30:                                              ; CODE XREF: Boss_XiTigerFallingLanding+10   j
                                        ; Boss_XiTigerFallingLanding+1A   j
                lea     word_3E456(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerFallingLanding
; Starts battle activating boss movement
Boss_XiTigerBattleStart:                                ; DATA XREF: ROM:0003D88E   o  ; was: sub_3DA3E
                tst.w   $58(a5)
                bpl.s   loc_3DA64
                addq.w  #2,4(a5)
                clr.l   $498(a5)
                clr.w   $17E(a5)
                addq.w  #1,$1DC(a5)
                addq.w  #1,$1DE(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_3DA86
; ---------------------------------------------------------------------------
loc_3DA64:                                              ; CODE XREF: Boss_XiTigerSetup+EC   j
                                        ; Boss_XiTigerFallingLanding+5E   j
                lea     word_3E478(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleStart
; Active battle state with AI update
Boss_XiTigerBattleActive:                               ; DATA XREF: ROM:0003D890   o  ; was: sub_3DA72
                cmpi.w  #$FFFC,$17E(a5)
                bne.s   loc_3DA86
                addq.w  #2,4(a5)
                moveq   #5,d0
                jsr     (UI_CheckVictoryCondition).l
loc_3DA86:                                              ; CODE XREF: Boss_XiTigerBattleStart+24   j
                                        ; Boss_XiTigerBattleActive+6   j
                lea     word_3E3D2(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleActive
; Movement AI with position tracking
Boss_XiTigerMovementAI:                                 ; DATA XREF: ROM:0003D892   o  ; was: sub_3DA94
                tst.w   (word_FF80C2).w
                bne.s   loc_3DA86
                clr.b   (byte_FF80EC).w
                addi.w  #$40,(word_FFA974).w            ; '@'
                bra.w   loc_3DB10
; End of function Boss_XiTigerMovementAI
; Check recovery conditions and transition Xi-Tiger state
Boss_XiTigerRecoveryCheck:
                tst.w   $58(a5)                         ; was: sub_3DAA8
                bpl.s   loc_3DABE
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3DABE:                                              ; CODE XREF: Boss_XiTigerRecoveryCheck+4   j
                move.w  a5,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$148,$914(a5)
                lea     word_3E3E8(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerRecoveryCheck
; Check button input to reverse Xi-Tiger state
Boss_XiTigerButtonCheck:
                btst    #6,(word_FFF708).w              ; was: sub_3DAE2
                beq.s   loc_3DAF8
                subq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFE,$C(a5)
loc_3DAF8:                                              ; CODE XREF: Boss_XiTigerButtonCheck+6   j
                lea     word_3E464(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerButtonCheck
; Xi-Tiger idle/waiting state with scroll and distance checks
Boss_XiTigerIdleState:                                  ; CODE XREF: Boss_XiTigerDashDecelerate+24   j  ; was: sub_3DB06
                                        ; Boss_XiTigerCloseRangeAI+E   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3DB10:                                              ; CODE XREF: Boss_XiTigerMovementAI+10   j
                move.w  #$C,4(a5)
                move.w  #$C,$17E(a5)
                move.l  #word_EBA2C,$68(a5)
                bclr    #6,$261(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                move.w  #1,$1DC(a5)
                move.w  #1,$1DE(a5)
; Xi-Tiger idle state with attack decision
Boss_XiTigerIdle_AttackDecision:                        ; DATA XREF: ROM:0003D894   o  ; was: loc_3DB48
                move.w  #2,(word_FF8246).w
                addi.w  #$10,(word_FF8234).w
                tst.w   $17E(a5)
                bpl.s   loc_3DB8A
                move.w  #$C,$17E(a5)
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   loc_3DB8A
                move.w  #$1E0,(word_FF8234).w
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$A0,d0
                bmi.w   loc_3DC7A
                btst    #0,(dword_FFFF08).w
                bne.w   loc_3DBA6
                bra.w   loc_3DD56
; ---------------------------------------------------------------------------
loc_3DB8A:                                              ; CODE XREF: Boss_XiTigerIdleState+52   j
                                        ; Boss_XiTigerIdleState+60   j
                lea     word_3E3D2(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                move.w  (word_FFA000).w,d5
                andi.w  #$F,d5
                beq.w   Boss_XiTigerSetFacingDirection
                rts
; ---------------------------------------------------------------------------
loc_3DBA6:                                              ; CODE XREF: Boss_XiTigerIdleState+7C   j
                                        ; Boss_XiTigerDashDecelerate+44   j
                move.w  #$10,4(a5)
                move.l  #word_EBA2C,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #0,$1DC(a5)
                move.w  #1,$1DE(a5)
                move.w  #3,$17E(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
; End of function Boss_XiTigerIdleState
; Xi-Tiger dash preparation with sound and rotation setup
Boss_XiTigerDashPrep:                                   ; DATA XREF: ROM:0003D898   o  ; was: sub_3DBE6
                tst.w   $17E(a5)
                bpl.s   loc_3DC24
                subi.w  #$A0,(word_FF8234).w
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                bset    #6,$261(a5)
                move.l  #$80000,$498(a5)
                tst.w   $54(a5)
                beq.s   loc_3DC24
                neg.l   $498(a5)
loc_3DC24:                                              ; CODE XREF: Boss_XiTigerDashPrep+4   j
                                        ; Boss_XiTigerDashPrep+38   j
                lea     word_3E42E(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerDashPrep
; Xi-Tiger dash deceleration and attack decision logic
Boss_XiTigerDashDecelerate:                             ; DATA XREF: ROM:0003D89A   o  ; was: sub_3DC32
                tst.l   $498(a5)
                beq.s   loc_3DC4C
                bmi.s   loc_3DC44
                subi.l  #$4000,$498(a5)
                bra.s   loc_3DC4C
; ---------------------------------------------------------------------------
loc_3DC44:                                              ; CODE XREF: Boss_XiTigerDashDecelerate+6   j
                addi.l  #$4000,$498(a5)
loc_3DC4C:                                              ; CODE XREF: Boss_XiTigerDashDecelerate+4   j
                                        ; Boss_XiTigerDashDecelerate+10   j
                tst.w   $58(a5)
                bpl.s   loc_3DC24
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerIdleState
                clr.l   $498(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$98,d0
                bmi.w   loc_3DC7A
                andi.w  #2,d5
                beq.w   loc_3DD56
                bra.w   loc_3DBA6
; ---------------------------------------------------------------------------
loc_3DC7A:                                              ; CODE XREF: Boss_XiTigerIdleState+72   j
                                        ; Boss_XiTigerDashDecelerate+38   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #1,$1DC(a5)
                move.w  #0,$1DE(a5)
; Xi-Tiger dash deceleration with animation
Boss_XiTigerDash_Decelerate:                            ; DATA XREF: ROM:0003D896   o  ; was: loc_3DCA8
                tst.w   $58(a5)
                bmi.s   loc_3DCBC
                lea     word_3E3F2(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
loc_3DCBC:                                              ; CODE XREF: Boss_XiTigerDashDecelerate+7A   j
                                        ; Boss_XiTigerCloseRangeAI+24   j
                move.w  #$28,4(a5)                      ; '('
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                addq.w  #4,d0
                move.w  d0,$17E(a5)
                bset    #6,$261(a5)
                move.w  #4,$58(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
; End of function Boss_XiTigerDashDecelerate
; Xi-Tiger close range attack AI decision logic
Boss_XiTigerCloseRangeAI:                               ; DATA XREF: ROM:0003D8B0   o  ; was: sub_3DCE6
                tst.w   $17E(a5)
                bpl.s   loc_3DD1A
                bsr.w   Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerIdleState
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$98,d0
                bpl.s   loc_3DD0E
                andi.w  #3,d5
                beq.w   loc_3DD56
                bra.w   loc_3DCBC
; ---------------------------------------------------------------------------
loc_3DD0E:                                              ; CODE XREF: Boss_XiTigerCloseRangeAI+1A   j
                andi.w  #1,d5
                beq.w   loc_3DD56
                bra.w   loc_3DBA6
; ---------------------------------------------------------------------------
loc_3DD1A:                                              ; CODE XREF: Boss_XiTigerCloseRangeAI+4   j
                lea     word_3E3FC(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                move.w  $58(a5),d0
                subq.w  #4,d0
                andi.w  #$C,d0
                cmpi.w  #8,d0
                bne.w   Boss_XiTigerUpdateSprites
                tst.w   $C(a5)
                bne.w   Boss_XiTigerUpdateSprites
                subi.w  #$30,(word_FF8234).w            ; '0'
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_XiTigerSetAnimationData
                bra.w   Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
loc_3DD56:                                              ; CODE XREF: Boss_XiTigerIdleState+80   j
                                        ; Boss_XiTigerDashDecelerate+40   j
                move.w  #$14,4(a5)
                clr.w   $17E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #word_EBA2C,$68(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; Xi-Tiger close range jump preparation
Boss_XiTigerCloseRange_JumpPrep:                        ; DATA XREF: ROM:0003D89C   o  ; was: loc_3DD8C
                cmpi.w  #$FFFD,$17E(a5)
                bne.s   loc_3DDB6
                addq.w  #2,4(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  #$20000,$498(a5)
                tst.w   $54(a5)
                beq.s   loc_3DDB6
                neg.l   $498(a5)
loc_3DDB6:                                              ; CODE XREF: Boss_XiTigerCloseRangeAI+AC   j
                                        ; Boss_XiTigerCloseRangeAI+CA   j
                lea     word_3E444(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerCloseRangeAI
; Xi-Tiger jump rising phase with gravity
Boss_XiTigerJumpRise:                                   ; DATA XREF: ROM:0003D89E   o  ; was: sub_3DDC4
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DDB6
                move.l  #word_EBA4A,$68(a5)
                addq.w  #2,4(a5)
                bset    #6,$261(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                subi.w  #$E0,(word_FF8234).w
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
loc_3DDFA:                                              ; CODE XREF: Boss_XiTigerJumpPeak+10   j
                lea     word_3E456(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpRise
; Xi-Tiger jump peak and landing detection
Boss_XiTigerJumpPeak:                                   ; DATA XREF: ROM:0003D8A0   o  ; was: sub_3DE08
                addi.l  #$4000,$1C(a5)
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DDFA
                addq.w  #2,4(a5)
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                move.b  #$A4,d0
                jsr     (Sound_PlaySFX).l
                bclr    #6,$261(a5)
                move.w  $23C(a5),$914(a5)
                move.w  #$CF20,$4A(a5)
                clr.l   $1C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3DE62:                                              ; CODE XREF: Boss_XiTigerLandedState+48   j
                lea     word_3E3E8(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpPeak
; Xi-Tiger landed state with AI decision logic
Boss_XiTigerLandedState:                                ; DATA XREF: ROM:0003D8A2   o  ; was: sub_3DE70
                tst.w   $58(a5)
                bpl.s   loc_3DE9E
                clr.l   $498(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerIdleState
                move.w  (dword_FFFF08).w,d5
                cmpi.w  #$A0,d0
                bpl.w   loc_3DBA6
                andi.w  #4,d5
                beq.w   loc_3DC7A
                bra.w   loc_3DD56
; ---------------------------------------------------------------------------
loc_3DE9E:                                              ; CODE XREF: Boss_XiTigerLandedState+4   j
                move.l  $498(a5),d0
                beq.s   loc_3DEB4
                bmi.s   loc_3DEAE
                subi.l  #$2000,d0
                bra.s   loc_3DEB4
; ---------------------------------------------------------------------------
loc_3DEAE:                                              ; CODE XREF: Boss_XiTigerLandedState+34   j
                addi.l  #$2000,d0
loc_3DEB4:                                              ; CODE XREF: Boss_XiTigerLandedState+32   j
                                        ; Boss_XiTigerLandedState+3C   j
                move.l  d0,$498(a5)
                bra.s   loc_3DE62
; End of function Boss_XiTigerLandedState
; Attack pattern 1 with claw strikes
Boss_XiTigerAttackPattern1:                             ; CODE XREF: Boss_XiTigerMain+42   j  ; was: sub_3DEBA
                move.w  #$1C,4(a5)
                move.w  #$30,(word_FF809E).w            ; '0'
                move.l  #word_EBA4A,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFB4000,$1C(a5)
                move.l  #$12000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$100,$BC(a5)
                bmi.s   loc_3DF06
                neg.l   $18(a5)
                clr.w   $54(a5)
loc_3DF06:                                              ; CODE XREF: Boss_XiTigerAttackPattern1+42   j
                bsr.w   Boss_XiTigerFlipDirection
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; End of function Boss_XiTigerAttackPattern1
; Attack pattern 2 with jumping
Boss_XiTigerAttackPattern2:                             ; DATA XREF: ROM:0003D8A4   o  ; was: sub_3DF12
                jsr     (Gfx_UpdatePaletteFade).l
                addi.l  #$4000,$1C(a5)
                bmi.s   loc_3DF6A
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   loc_3DF6A
                addq.w  #2,4(a5)
                move.w  #$C0,$11C(a5)
                move.w  #8,(word_FFA010).w
                move.w  #8,(word_FFA014).w
                move.l  #$C000,(dword_FFA91C).w
                move.w  #$FFFF,(dword_FFA960).w
                clr.l   $1C(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
loc_3DF6A:                                              ; CODE XREF: Boss_XiTigerAttackPattern2+E   j
                                        ; Boss_XiTigerAttackPattern2+18   j
                lea     word_3E464(pc),a1
                nop
                bsr.w   Boss_XiTigerProcessAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                bra.w   Boss_XiTigerSpawnProjectile
; End of function Boss_XiTigerAttackPattern2
; Attack pattern 3 with projectiles
Boss_XiTigerAttackPattern3:                             ; DATA XREF: ROM:0003D8A6   o  ; was: sub_3DF7C
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$11C(a5)
                bpl.s   loc_3DF9A
                addq.w  #2,4(a5)
                clr.w   6(a5)
                move.b  #$14,d0
                jsr     (Sound_PlaySFX).l
loc_3DF9A:                                              ; CODE XREF: Boss_XiTigerAttackPattern3+A   j
                tst.l   $18(a5)
                beq.s   loc_3DFB4
                bpl.s   loc_3DFAC
                addi.l  #$1000,$18(a5)
                bra.s   loc_3DFB4
; ---------------------------------------------------------------------------
loc_3DFAC:                                              ; CODE XREF: Boss_XiTigerAttackPattern3+24   j
                subi.l  #$1000,$18(a5)
loc_3DFB4:                                              ; CODE XREF: Boss_XiTigerAttackPattern3+22   j
                                        ; Boss_XiTigerAttackPattern3+2E   j
                lea     word_3E46E(pc),a1
                nop
loc_3DFBA:                                              ; CODE XREF: Boss_XiTigerDefeatInit+40   j
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                bsr.w   Boss_XiTigerProcessAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                bra.w   Boss_XiTigerSpawnProjectile
; End of function Boss_XiTigerAttackPattern3
; Initializes boss defeat sequence
Boss_XiTigerDefeatInit:                                 ; DATA XREF: ROM:0003D8A8   o  ; was: sub_3DFD2
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Gfx_QueueDMATransfer
                addq.w  #1,6(a5)
                cmpi.w  #$20,6(a5)                      ; ' '
                bmi.s   loc_3E00C
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   8(a5)
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$114,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
loc_3E00C:                                              ; CODE XREF: Boss_XiTigerDefeatInit+14   j
                lea     word_3E46E(pc),a1
                nop
                bra.s   loc_3DFBA
; End of function Boss_XiTigerDefeatInit
; Updates defeat animation and effects
Boss_XiTigerDefeatUpdate:                               ; DATA XREF: ROM:0003D8AA   o  ; was: sub_3E014
                subq.w  #1,$11C(a5)
                bpl.s   loc_3E02A
                addq.w  #2,4(a5)
                jsr     (Effect_InitPlayerSpawn).l
                addi.w  #$20,$14(a0)                    ; ' '
loc_3E02A:                                              ; CODE XREF: Boss_XiTigerDefeatUpdate+4   j
                bra.w   Gfx_QueueDMATransfer
; End of function Boss_XiTigerDefeatUpdate
; Completes defeat clearing boss entity
Boss_XiTigerDefeatComplete:                             ; DATA XREF: ROM:0003D8AC   o  ; was: sub_3E02E
                subq.w  #2,6(a5)
                bne.s   loc_3E03E
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
loc_3E03E:                                              ; CODE XREF: Boss_XiTigerDefeatComplete+4   j
                bra.w   Gfx_QueueDMATransfer
; End of function Boss_XiTigerDefeatComplete
; Final defeat state cleanup
Boss_XiTigerDefeatFinal:                                ; DATA XREF: ROM:0003D8AE   o  ; was: sub_3E042
                subq.w  #1,$11C(a5)
                bpl.s   locret_3E04E
                bset    #4,2(a5)
locret_3E04E:                                           ; CODE XREF: Boss_XiTigerDefeatFinal+4   j
                rts
; End of function Boss_XiTigerDefeatFinal
; Updates boss sprite rendering
Boss_XiTigerUpdateSprites:                              ; CODE XREF: Boss_XiTigerFallingLanding+6A   j  ; was: sub_3E050
                                        ; Boss_XiTigerBattleStart+30   j
                moveq   #$17,d7
                jsr     (Sprite_InitMetaspriteSimple).l
                bsr.w   Boss_XiTigerUpdateBody
                bsr.w   Boss_XiTigerUpdateClaws
                rts
; End of function Boss_XiTigerUpdateSprites
; Sets Xi-Tiger boss facing direction based on player position
Boss_XiTigerSetFacingDirection:                         ; CODE XREF: Boss_XiTigerIdleState+9A   j  ; was: sub_3E062
                                        ; Boss_XiTigerIdleState+DC   p
                clr.w   $54(a5)
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   Boss_XiTigerFlipDirection
                move.w  #$100,$54(a5)
; End of function Boss_XiTigerSetFacingDirection
; Flips boss sprite direction
Boss_XiTigerFlipDirection:                              ; CODE XREF: Boss_XiTigerSetup+BC   p  ; was: sub_3E076
                                        ; sub_3DEBA:loc_3DF06   p
                moveq   #3,d5
                tst.w   $54(a5)
                beq.s   loc_3E094
                bset    d5,$6E(a5)
                bset    d5,$2AE(a5)
                bset    d5,$5AE(a5)
                bclr    d5,$CE(a5)
                bclr    d5,$7EE(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E094:                                              ; CODE XREF: Boss_XiTigerFlipDirection+6   j
                bclr    d5,$6E(a5)
                bclr    d5,$2AE(a5)
                bclr    d5,$5AE(a5)
                bset    d5,$CE(a5)
                bset    d5,$7EE(a5)
                rts
; End of function Boss_XiTigerFlipDirection
; Updates Xi-Tiger boss palette values based on position comparison
Boss_XiTigerUpdatePalette:
                move.w  $6D4(a5),d0                     ; was: sub_3E0AA
                cmp.w   $914(a5),d0
                bpl.s   loc_3E0C8
                move.w  #$CF20,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E0C8:                                              ; CODE XREF: Boss_XiTigerUpdatePalette+8   j
                move.w  #$CCE0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                rts
; End of function Boss_XiTigerUpdatePalette
; Sets Xi-Tiger animation data pointer based on controller input
Boss_XiTigerSetAnimationData:                           ; CODE XREF: Boss_XiTigerCloseRangeAI+68   p  ; was: sub_3E0DC
                move.l  #word_EBA2C,$68(a5)
                btst    #3,(word_FFA000+1).w
                bne.s   locret_3E0F4
                move.l  #word_EBA4A,$68(a5)
locret_3E0F4:                                           ; CODE XREF: Boss_XiTigerSetAnimationData+E   j
                rts
; End of function Boss_XiTigerSetAnimationData
; Updates claw sprites based on state
Boss_XiTigerUpdateClaws:                                ; CODE XREF: Boss_XiTigerUpdateSprites+C   p  ; was: sub_3E0F6
                movea.w #(word_FFC860-M68K_RAM),a0
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
                tst.w   $1DE(a5)
                beq.s   loc_3E114
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
loc_3E114:                                              ; CODE XREF: Boss_XiTigerUpdateClaws+12   j
                bsr.s   Boss_XiTigerSetClawSprite
                movea.w #(word_FFCA40-M68K_RAM),a0
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
                tst.w   $1DC(a5)
                beq.s   Boss_XiTigerSetClawSprite
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
; End of function Boss_XiTigerUpdateClaws
; Sets claw sprite graphics pointer
Boss_XiTigerSetClawSprite:                              ; CODE XREF: Boss_XiTigerUpdateClaws:loc_3E114   p  ; was: sub_3E134
                                        ; Boss_XiTigerUpdateClaws+32   j
                move.w  $56(a0),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   loc_3E150
                eori.w  #$1800,$E(a0)
loc_3E150:                                              ; CODE XREF: Boss_XiTigerSetClawSprite+14   j
                tst.w   $54(a5)
                beq.s   loc_3E15C
                eori.w  #$800,$E(a0)
loc_3E15C:                                              ; CODE XREF: Boss_XiTigerSetClawSprite+20   j
                asr.w   #4,d0
                andi.w  #$C,d0
                add.w   d1,d0
                move.l  off_3E16C(pc,d0.w),8(a0)
                rts
; End of function Boss_XiTigerSetClawSprite
; ---------------------------------------------------------------------------
off_3E16C:      dc.l    word_EBA68                      ; DATA XREF: Boss_XiTigerSetClawSprite+30   r
                dc.l    word_EBA74
                dc.l    word_EBAA4
                dc.l    word_EBA86
                dc.l    word_EBB1C
                dc.l    word_EBA86
                dc.l    word_EBAA4
                dc.l    word_EBA74

; Updates boss body metasprite positions
Boss_XiTigerUpdateBody:                                 ; CODE XREF: Boss_XiTigerUpdateSprites+8   p  ; was: sub_3E18C
                move.w  #$C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_CheckScreenBounds
; End of function Boss_XiTigerUpdateBody
; Queues DMA transfer to VRAM
Gfx_QueueDMATransfer:                                   ; CODE XREF: Boss_ShellshogunChargeAttack+C   p  ; was: sub_3E1AA
                                        ; sub_3987C:loc_39898   j
                move.w  6(a5),d0
                asr.w   #1,d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_QueueDMATransfer
; Spawns boss projectile with trajectory
Boss_XiTigerSpawnProjectile:                            ; CODE XREF: Boss_XiTigerAttackPattern2+66   j  ; was: sub_3E1C0
                                        ; Boss_XiTigerAttackPattern3+52   j
                jsr     (Projectile_UpdateAfterGlobalDelay).l
                bne.s   locret_3E21A
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.w  #$FFFD,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$10,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_3E21A:                                           ; CODE XREF: Boss_XiTigerSpawnProjectile+6   j
                rts
; End of function Boss_XiTigerSpawnProjectile
; Processes boss animation with interpolation
Boss_XiTigerProcessAnimation:                           ; CODE XREF: Boss_XiTigerFallingLanding+66   p  ; was: sub_3E21C
                                        ; Boss_XiTigerBattleStart+2C   p
                clr.w   $29C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3E2A2
loc_3E226:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3E2B2
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3E248
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3E248:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3E258
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3E258:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3E268
                clr.w   $58(a5)
                clr.w   $A(a5)
                bra.s   loc_3E226
; ---------------------------------------------------------------------------
loc_3E268:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3E492,d0
                movea.l d0,a0
                bsr.w   Boss_XiTigerCalculateDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$A(a5)
                addq.w  #1,$29C(a5)
                subq.w  #1,$17E(a5)
                tst.w   $C(a5)
                bmi.s   loc_3E2B2
loc_3E2A2:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$F,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_3E2B2:                                              ; CODE XREF: Boss_XiTigerProcessAnimation+E   j
                                        ; Boss_XiTigerProcessAnimation+84   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  $3C(a0),d6
                asl.w   #1,d6
                move.w  d6,d0
                addi.w  #$80,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
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
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d6,d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d1
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d0,$3B6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$416(a5)
                move.w  d1,$476(a5)
                move.b  $2C(a0),d1
                asl.w   #1,d1
                add.w   d6,d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d1
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $34(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $38(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                rts
; End of function Boss_XiTigerProcessAnimation
; Calculates animation interpolation deltas
Boss_XiTigerCalculateDeltas:                            ; CODE XREF: Boss_XiTigerProcessAnimation+62   p  ; was: sub_3E3B0
                movea.l #word_34DA6,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$F,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_XiTigerCalculateDeltas
; Loads animation data from table
Boss_XiTigerLoadAnimData:                               ; CODE XREF: Boss_XiTigerSetup+E8   p  ; was: sub_3E3C6
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #$F,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_XiTigerLoadAnimData
; ---------------------------------------------------------------------------
word_3E3D2:     dc.w    $F510, 0, $15, 0, $80DC, $F510, $10, $15, $10, $80DC, $FFFF
                                        ; DATA XREF: Boss_XiTigerBattleActive:loc_3DA86   o
                                        ; sub_3DB06:loc_3DB8A   o
word_3E3E8:     dc.w    $F810, $70, $C, $70, $FFFE
                                        ; DATA XREF: Boss_XiTigerRecoveryCheck+2C   o
                                        ; sub_3DE08:loc_3DE62   o
word_3E3F2:     dc.w    $FC08                           ; DATA XREF: Boss_XiTigerDashDecelerate+7C   o
                dc.w    $20, $12, $20, $FFFE
word_3E3FC:     dc.w    $F810, $20, 3, $20, $F50E, $30, 4, $30, $F810, $20, 3, $20, $F511, $40, 4, $40
                                        ; DATA XREF: Boss_XiTigerCloseRangeAI:loc_3DD1A   o
                dc.w    $F810, $20, 3, $20, $F510, $50, 4, $50, $FFFF
word_3E42E:     dc.w    $F414, $80, $16, $80
                                        ; DATA XREF: Boss_XiTigerDashPrep:loc_3DC24   o
                dc.w    $8880, $90, $FE10, $90, $10, $90, $FFFE
word_3E444:     dc.w    $F410, $70, $18, $70, $FC0C, $A0, $C, $A0, $FFFE
                                        ; DATA XREF: Boss_XiTigerCloseRangeAI:loc_3DDB6   o
word_3E456:     dc.w    $CA40, $B0, $FE0C, $B0, 8, $B0, $FFFE
                                        ; DATA XREF: Boss_XiTigerFallingLanding:loc_3DA30   o
                                        ; sub_3DDC4:loc_3DDFA   o
word_3E464:     dc.w    $C, $A0, $C, $B0, $FFFF
                                        ; DATA XREF: Boss_XiTigerButtonCheck:loc_3DAF8   o
                                        ; sub_3DF12:loc_3DF6A   o
word_3E46E:     dc.w    $E220, $C0, $E120, $70, $FFFF
                                        ; DATA XREF: Boss_XiTigerAttackPattern3:loc_3DFB4   o
                                        ; sub_3DFD2:loc_3E00C   o
word_3E478:     dc.w    $F058, $D0, $38, $D0, $EC50, $C0, $D040, $C0, $ED18, $10, $14, $10, $FFFE
                                        ; DATA XREF: Boss_XiTigerBattleStart:loc_3DA64   o
word_3E492:     dc.w    $C8EC, $3860, $1038, $38F0, $8C50, $AC70, $6400, $E0FA, $D4F8, $3050, $1014, $1018, $9640, $9870, $50C0, $606
                                        ; DATA XREF: Boss_XiTigerProcessAnimation+5A   o
                dc.w    $C4E4, $B470, $1010, $4000, $9080, $3070, $6EF8, $D0FA, $D600, $2000, $800, $5000, $A090, $5070, $6EF0, $D00C
                dc.w    $D608, $3010, $1008, $4000, $A090, $6060, $6008, $D00C, $DA06, $1800, $F8F4, $6000, $9490, $4080, $70F8, $C00C
                dc.w    $CCE8, $2038, $808, $6000, $9688, $F060, $38D0, $20FC
word_3E502:     dc.w    $D0F8, $60, $10E0, $6000, $8880, $A070, $A0A0, 0, $D000, $6860, $1000, $1000, $8830, $C090, $A0A0, $F0
                                        ; DATA XREF: Boss_XiTigerSetup+E2   o
                dc.w    $C0E0, $C0C0, $1010, $4000, $8080, $A050, $6400, $E010, $C0D0, $C060, 0, $6030, $8070, $AC70, $5800, $D8F8
                dc.w    $D808, $2800, $1040, $40E0, $A0B0, $C070, $6010, $D80A, $C800, $40E0, $1030, $10, $8040, $2070, $5000, $F000
                dc.w    $C8F0, $5050, $1030, $10, $9030, $B070, $5000, $F000, $D0F6, $5450, $1830, $410, $8A2C, $B068, $50FC, $F000

; Main Deep Strider boss dispatcher
