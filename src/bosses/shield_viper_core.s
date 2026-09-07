Boss_ShieldViperMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_4DDD2
                tst.w   4(a5)
                beq.w   loc_4DFDA
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5A(a5)
                bsr.w   Boss_ShieldViperSegmentUpdate
                jsr     (Gfx_InitPaletteFade).l
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4DE16
                tst.w   (word_FF8200).w
                bne.s   loc_4DE16
                move.b  #2,(byte_FF80EC).w
                move.w  #$70,4(a5)                      ; 'p'
                bset    #0,$58(a5)
                bset    #0,(byte_FFA272).w
loc_4DE16:                                              ; CODE XREF: Boss_ShieldViperMain+24   j
                                        ; Boss_ShieldViperMain+2A   j
                btst    #0,$58(a5)
                bne.w   loc_4DFDA
                lea     (word_1B514).l,a3
                move.w  (dword_FF9410).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                move.w  -$80(a3,d0.w),d0
                ext.l   d0
                asl.l   #4,d0
                swap    d0
                move.w  d0,(dword_FF9418+2).w
                move.w  (dword_FF9410+2).w,d0
                add.w   d0,(dword_FF9410).w
                movea.w a5,a0
                bsr.w   Boss_ShieldViperCollision
                btst    #0,(dword_FF9414+1).w
                beq.w   loc_4DF72
                moveq   #0,d5
                moveq   #0,d6
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4DE62:                                              ; CODE XREF: Boss_ShieldViperMain+BC   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   d0,d5
                add.l   d1,d6
                move.l  d5,$48(a0)
                move.l  d6,$4C(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DE62
                movea.w (dword_FF9408).w,a0
                cmpa.w  a5,a0
                beq.s   loc_4DEA6
                move.l  $10(a0),d0
                sub.l   $48(a0),d0
                move.l  d0,$10(a5)
loc_4DEA6:                                              ; CODE XREF: Boss_ShieldViperMain+C6   j
                movea.w (dword_FF9408+2).w,a0
                cmpa.w  a5,a0
                beq.s   loc_4DEBA
                move.l  $14(a0),d0
                sub.l   $4C(a0),d0
                move.l  d0,$14(a5)
loc_4DEBA:                                              ; CODE XREF: Boss_ShieldViperMain+DA   j
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4DEC2:                                              ; CODE XREF: Boss_ShieldViperMain+10C   j
                move.l  $48(a0),d0
                add.l   $10(a5),d0
                move.l  d0,$10(a0)
                move.l  $4C(a0),d0
                add.l   $14(a5),d0
                move.l  d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DEC2
                move.w  $4D6(a5),d0
                move.w  #$10,d7
                lea     (a5),a0
loc_4DEEC:                                              ; CODE XREF: Boss_ShieldViperMain+122   j
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DEEC
                move.w  #7,d7
                lea     $600(a5),a1
                lea     $660(a5),a0
loc_4DF04:                                              ; CODE XREF: Boss_ShieldViperMain+160   j
                move.w  $56(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a1),d0
                add.l   $14(a1),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4DF04
                move.w  $656(a5),d0
                add.w   $652(a5),d0
                lea     (word_FF9620).w,a0
                move.w  #$40,d7                         ; '@'
loc_4DF46:                                              ; CODE XREF: Boss_ShieldViperMain+17A   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_4DF46
                lea     (word_FF9620).w,a1
                lea     $660(a5),a0
                moveq   #0,d6
                move.w  #7,d7
loc_4DF5E:                                              ; CODE XREF: Boss_ShieldViperMain+198   j
                lea     $10(a1),a1
                move.w  (a1),$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DF5E
                bra.w   loc_4DFD6
; ---------------------------------------------------------------------------
loc_4DF72:                                              ; CODE XREF: Boss_ShieldViperMain+80   j
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
                move.w  $56(a5),d0
                move.w  $10(a5),d2
                swap    d2
                move.w  $14(a5),d2
                cmp.l   (dword_FF940C).w,d2
                beq.s   loc_4DFA6
                move.l  d2,(dword_FF940C).w
                move.w  #$60,d7                         ; '`'
loc_4DF96:                                              ; CODE XREF: Boss_ShieldViperMain+1D0   j
                move.w  (a1),d1
                move.w  d0,(a1)+
                move.w  d1,d0
                move.l  (a2),d3
                move.l  d2,(a2)+
                move.l  d3,d2
                dbf     d7,loc_4DF96
loc_4DFA6:                                              ; CODE XREF: Boss_ShieldViperMain+1BA   j
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
                lea     $60(a5),a0
                move.w  #$17,d7
loc_4DFB6:                                              ; CODE XREF: Boss_ShieldViperMain+200   j
                lea     8(a1),a1
                move.w  (a1),$56(a0)
                lea     $10(a2),a2
                move.l  (a2),d0
                move.w  d0,$14(a0)
                swap    d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DFB6
loc_4DFD6:                                              ; CODE XREF: Boss_ShieldViperMain+19C   j
                bsr.w   Boss_ShieldViperIdleState
loc_4DFDA:                                              ; CODE XREF: Boss_ShieldViperMain+4   j
                                        ; Boss_ShieldViperMain+4A   j
                move.w  4(a5),d0
                lea     off_4DFE6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperMain
; ---------------------------------------------------------------------------
off_4DFE6:      dc.w    Boss_ShieldViperDispatcher-*    ; DATA XREF: Boss_ShieldViperMain+20C   o
                dc.w    Boss_ShieldViperIntroMove-*
                dc.w    Boss_ShieldViper_IntroDelayLoop-*
                dc.w    Boss_ShieldViperIntroStop-*
                dc.w    Boss_ShieldViperBattleStart-*
                dc.w    nullsub_113-*
                dc.w    nullsub_114-*
                dc.w    nullsub_114-*
                dc.w    nullsub_114-*
                dc.w    Boss_ShieldViperInitAttackCycle-*
                dc.w    Boss_ShieldViperWaitForApproach-*
                dc.w    Boss_ShieldViperWaitForAngleMatch-*
                dc.w    Boss_ShieldViperWaitFor90DegRotation-*
                dc.w    Boss_ShieldViperInitRotationSpeed-*
                dc.w    Boss_ShieldViperWaitForRotationSync-*
                dc.w    Boss_ShieldViperMultiPhaseAttack-*
                dc.w    Boss_ShieldViperMultiPhaseAttack_InitRotation-*
                dc.w    Boss_ShieldViperAttackCycleCounter-*
                dc.w    Boss_ShieldViperSetRotationSpeed-*
                dc.w    Boss_ShieldViperWaitForRotationComplete-*
                dc.w    Boss_ShieldViperInitSpinAttack-*
                dc.w    Boss_ShieldViperSpinAttackTimer-*
                dc.w    Boss_ShieldViperSpinAttackUpdate-*
                dc.w    Boss_ShieldViperTransitionState-*
                dc.w    Boss_ShieldViperAdvanceState-*
                dc.w    Boss_ShieldViperSpawnProjectile1-*
                dc.w    Boss_ShieldViperSpawnProjectile1_InitTimers-*
                dc.w    Boss_ShieldViperSpawnProjectile1_AttackLoop-*
                dc.w    Boss_ShieldViperDifficultySetup-*
                dc.w    Boss_ShieldViperWaitAngleMatch-*
                dc.w    Boss_ShieldViperCheckVerticalPosition-*
                dc.w    Boss_ShieldViperRepositionSetup-*
                dc.w    Boss_ShieldViperWaitVerticalThreshold-*
                dc.w    Boss_ShieldViperAccelerateRotation-*
                dc.w    Boss_ShieldViperDelayBeforeFlip-*
                dc.w    Boss_ShieldViperFlipDelay-*
                dc.w    Boss_ShieldViperPrepareMultiShot-*
                dc.w    Boss_ShieldViperWaitRotation180-*
                dc.w    Boss_ShieldViperAscendCheck-*
                dc.w    Boss_ShieldViperDelayRotateUpdate-*
                dc.w    Boss_ShieldViperDelayRotateUpdate_WaitLoop-*
                dc.w    Boss_ShieldViperFlipWaitDelay-*
                dc.w    Boss_ShieldViperSpawnLinkedProjectiles-*
                dc.w    Boss_ShieldViperWaitTransition-*
                dc.w    Boss_ShieldViperSpawnScatteredProjectiles-*
                dc.w    Boss_ShieldViperWaitTimer-*
                dc.w    Boss_ShieldViperQuickTransition-*
                dc.w    Boss_ShieldViperRotateAndAccelerate-*
                dc.w    Boss_ShieldViperDoubleStateAdvance-*
                dc.w    Boss_ShieldViperDoubleStateAdvance_Second-*
                dc.w    Boss_ShieldViperSingleStateAdvance-*
                dc.w    Boss_ShieldViperInitChildEntityTimer-*
                dc.w    Boss_ShieldViperSpawnChildEntityArray-*
                dc.w    Boss_ShieldViperSpawnChildSequentially-*
                dc.w    Boss_ShieldViperChildMovementInit-*
                dc.w    Boss_ShieldViperHalveSpeedAndReset-*
                dc.w    Boss_ShieldViperDefeatInit-*
                dc.w    Projectile_ShieldViperUpdate1-*
                dc.w    Projectile_ShieldViperUpdate2-*
                dc.w    Projectile_ShieldViperExplode-*
                dc.w    Boss_ShieldViperTransitionOut-*

; Boss state dispatcher
Boss_ShieldViperDispatcher:                             ; DATA XREF: ROM:off_4DFE6   o  ; was: sub_4E060
                tst.b   (word_FFF720).w
                bmi.w   locret_4E1DE
                addq.w  #2,4(a5)
                move.w  #$34C,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                clr.w   (dword_FF9404).w
                move.b  #4,(byte_FFA420).w
                move.w  #$50,(dword_FF9418).w           ; 'P'
                move.w  #$14,(dword_FF941C).w
                move.w  a5,(dword_FF9408).w
                move.w  a5,(dword_FF9408+2).w
                move.w  #$160,$10(a5)
                move.w  #$180,$14(a5)
                move.w  #$A300,$E(a5)
                move.w  #$4C00,2(a5)
                move.l  #word_ECF8E,8(a5)
                clr.w   $C(a5)
                move.b  #$10,$20(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                moveq   #0,d6
                move.w  #$17,d7
                clr.w   d6
                lea     $60(a5),a0
                lea     stru_4E1E0(pc),a1
                nop
loc_4E100:                                              ; CODE XREF: Boss_ShieldViperDispatcher+116   j
                move.w  #$A300,$E(a0)
                move.w  #$CC00,2(a0)
                move.w  #$80,$26(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #$14,$24(a0)
                move.w  #$370,(a0)
                move.w  (a1),$50(a0)
                move.b  3(a1),$5E(a0)
                move.l  4(a1),8(a0)
                clr.w   $C(a0)
                lea     8(a1),a1
                cmpi.w  #6,d7
                bmi.s   loc_4E172
                btst    #0,d7
                bne.s   loc_4E16E
                move.b  #$D0,$21(a0)
                move.b  #4,$23(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$10,$24(a0)
                bra.s   loc_4E172
; ---------------------------------------------------------------------------
loc_4E16E:                                              ; CODE XREF: Boss_ShieldViperDispatcher+E8   j
                clr.l   $2C(a0)
loc_4E172:                                              ; CODE XREF: Boss_ShieldViperDispatcher+E2   j
                                        ; Boss_ShieldViperDispatcher+10C   j
                lea     $60(a0),a0
                dbf     d7,loc_4E100
                move.w  #$4C00,2(a0)
                move.w  #$10,(a0)
                move.l  #word_ECFFA,8(a0)
                move.w  #$8300,$E(a0)
                move.w  #$60,$50(a0)                    ; '`'
; End of function Boss_ShieldViperDispatcher
; Intro animation init
Boss_ShieldViperIntroInit:
                lea     $60(a0),a0                      ; was: sub_4E198
                move.w  #$3A8,(a0)
                move.w  #$C00,2(a0)
                move.w  #$18,d7
                move.w  #$80,d0
                movea.w a5,a0
loc_4E1B0:                                              ; CODE XREF: Boss_ShieldViperIntroInit+20   j
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4E1B0
                lea     (word_FF94A0).w,a1
                move.w  #$1F,d7
                move.l  #$800080,d0
loc_4E1CA:                                              ; CODE XREF: Boss_ShieldViperIntroInit+34   j
                move.l  d0,(a1)+
                dbf     d7,loc_4E1CA
                lea     (word_FF9620).w,a1
                move.w  #$1F,d7
loc_4E1D8:                                              ; CODE XREF: Boss_ShieldViperIntroInit+42   j
                move.l  d0,(a1)+
                dbf     d7,loc_4E1D8
locret_4E1DE:                                           ; CODE XREF: Boss_ShieldViperDispatcher+4   j
                rts
; End of function Boss_ShieldViperIntroInit
; ---------------------------------------------------------------------------
stru_4E1E0:     dc.w    $50                             ; field_0
                                        ; DATA XREF: Boss_ShieldViperDispatcher+9A   o
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE2                      ; field_4
                dc.w    $38                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE2                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE8                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE8                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFEE                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFEE                      ; field_4

; Intro movement
Boss_ShieldViperIntroMove:                              ; DATA XREF: ROM:0004DFE8   o  ; was: sub_4E2A0
                addq.w  #2,4(a5)
                move.w  #$180,$10(a5)
                move.w  #$1A0,$14(a5)
                move.w  #$80,$56(a5)
                move.w  #$80,$48(a5)
; Decrements intro delay counter until ready to advance state
Boss_ShieldViper_IntroDelayLoop:                        ; DATA XREF: ROM:0004DFEA   o  ; was: loc_4E2BC
                subq.w  #1,$48(a5)
                bne.s   locret_4E2CC
                bset    #7,2(a5)
                addq.w  #2,4(a5)
locret_4E2CC:                                           ; CODE XREF: Boss_ShieldViperIntroMove+20   j
                rts
; End of function Boss_ShieldViperIntroMove
; Intro stop position
Boss_ShieldViperIntroStop:                              ; DATA XREF: ROM:0004DFEC   o  ; was: sub_4E2CE
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$E0,$14(a5)
                bgt.s   locret_4E2EE
                addq.w  #2,4(a5)
                move.w  #$FFF8,(dword_FF9400).w
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
locret_4E2EE:                                           ; CODE XREF: Boss_ShieldViperIntroStop+A   j
                rts
; End of function Boss_ShieldViperIntroStop
; Battle start initialization
Boss_ShieldViperBattleStart:                            ; DATA XREF: ROM:0004DFEE   o  ; was: sub_4E2F0
                bsr.w   Boss_ShieldViperAttackState1
                tst.w   (word_FF80C2).w
                bne.s   locret_4E304
                clr.b   (byte_FF80EC).w
                move.w  #$32,4(a5)                      ; '2'
locret_4E304:                                           ; CODE XREF: Boss_ShieldViperBattleStart+8   j
                rts
; End of function Boss_ShieldViperBattleStart
nullsub_113:                                            ; DATA XREF: ROM:0004DFF0   o
                rts
; End of function nullsub_113

nullsub_114:                                            ; DATA XREF: ROM:0004DFF2   o
                                        ; ROM:0004DFF4   o
                rts
; End of function nullsub_114

; Initializes attack cycle with alternating patterns
Boss_ShieldViperInitAttackCycle:                        ; DATA XREF: ROM:0004DFF8   o  ; was: sub_4E30A
                move.w  #$14,(dword_FF941C).w
                addq.w  #2,4(a5)
                move.w  #$180,$14(a5)
                move.w  #$80,$56(a5)
                addq.b  #1,(dword_FF9414+2).w
                btst    #0,(dword_FF9414+2).w
                beq.s   loc_4E340
                move.w  #$180,$10(a5)
                move.w  #$FFFC,(dword_FF9400).w
                move.w  #$100,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_4E340:                                              ; CODE XREF: Boss_ShieldViperInitAttackCycle+20   j
                move.w  #$C0,$10(a5)
                move.w  #4,(dword_FF9400).w
                move.w  #0,$4A(a5)
                rts
; End of function Boss_ShieldViperInitAttackCycle
; Waits for approach to target Y position
Boss_ShieldViperWaitForApproach:                        ; DATA XREF: ROM:0004DFFA   o  ; was: sub_4E354
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$140,$14(a5)
                bgt.s   locret_4E36A
                addq.w  #2,4(a5)
locret_4E36A:                                           ; CODE XREF: Boss_ShieldViperWaitForApproach+10   j
                rts
; End of function Boss_ShieldViperWaitForApproach
; Waits for rotation angle to match target
Boss_ShieldViperWaitForAngleMatch:                      ; DATA XREF: ROM:0004DFFC   o  ; was: sub_4E36C
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmp.w   $4A(a5),d0
                bne.s   locret_4E388
                addq.w  #2,4(a5)
locret_4E388:                                           ; CODE XREF: Boss_ShieldViperWaitForAngleMatch+16   j
                rts
; End of function Boss_ShieldViperWaitForAngleMatch
; Waits for 90 degree rotation and spawns projectile
Boss_ShieldViperWaitFor90DegRotation:                   ; DATA XREF: ROM:0004DFFE   o  ; was: sub_4E38A
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $4D6(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$80,d0
                bne.w   locret_4E3C0
                addq.w  #2,4(a5)
                move.w  d0,$4D6(a5)
                bsr.w   Boss_ShieldViperUpdateSegmentAngles
                lea     $480(a5),a0
                lea     $480(a5),a1
                move.w  a0,(dword_FF9408).w
                move.w  a1,(dword_FF9408+2).w
locret_4E3C0:                                           ; CODE XREF: Boss_ShieldViperWaitFor90DegRotation+16   j
                rts
; End of function Boss_ShieldViperWaitFor90DegRotation
; Initializes rotation speed based on attack direction
Boss_ShieldViperInitRotationSpeed:                      ; DATA XREF: ROM:0004E000   o  ; was: sub_4E3C2
                move.w  #$14,(dword_FF941C).w
                addq.w  #2,4(a5)
                move.w  #$18,(dword_FF9404).w
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E3DE
                neg.w   (dword_FF9404).w
loc_4E3DE:                                              ; CODE XREF: Boss_ShieldViperInitRotationSpeed+16   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                rts
; End of function Boss_ShieldViperInitRotationSpeed
; Waits for rotation to synchronize with target
Boss_ShieldViperWaitForRotationSync:                    ; DATA XREF: ROM:0004E002   o  ; was: sub_4E3E4
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E3FC
                addq.w  #2,4(a5)
locret_4E3FC:                                           ; CODE XREF: Boss_ShieldViperWaitForRotationSync+12   j
                rts
; End of function Boss_ShieldViperWaitForRotationSync
; Executes multi-phase rotating attack
Boss_ShieldViperMultiPhaseAttack:                       ; DATA XREF: ROM:0004E004   o  ; was: sub_4E3FE
                move.w  #$14,(dword_FF941C).w
                move.w  a5,(dword_FF9408).w
                addq.w  #2,4(a5)
                move.w  #$10,(dword_FF9410+2).w
                move.w  #$28,(dword_FF9404).w           ; '('
                move.w  #3,$4A(a5)
; Initialize rotation parameters for multi-phase attack
Boss_ShieldViperMultiPhaseAttack_InitRotation:          ; DATA XREF: ROM:0004E006   o  ; was: loc_4E41E
                move.w  #$14,(dword_FF941C).w
                move.w  #3,d0
                sub.w   $4A(a5),d0
                add.w   d0,d0
                move.w  word_4E44A(pc,d0.w),(dword_FF9404).w
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E440
                neg.w   (dword_FF9404).w
loc_4E440:                                              ; CODE XREF: Boss_ShieldViperMultiPhaseAttack+3C   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperMultiPhaseAttack
; ---------------------------------------------------------------------------
word_4E44A:     dc.w    $20, $3C, $20, $3C, $20
                                        ; DATA XREF: Boss_ShieldViperMultiPhaseAttack+30   r

; Counts remaining attack cycles and loops
Boss_ShieldViperAttackCycleCounter:                     ; DATA XREF: ROM:0004E008   o  ; was: sub_4E454
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E472
                subq.w  #1,$4A(a5)
                beq.s   loc_4E474
                subq.w  #2,4(a5)
locret_4E472:                                           ; CODE XREF: Boss_ShieldViperAttackCycleCounter+12   j
                rts
; ---------------------------------------------------------------------------
loc_4E474:                                              ; CODE XREF: Boss_ShieldViperAttackCycleCounter+18   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperAttackCycleCounter
; Sets rotation speed for next attack phase
Boss_ShieldViperSetRotationSpeed:                       ; DATA XREF: ROM:0004E00A   o  ; was: sub_4E47A
                move.w  #$14,(dword_FF941C).w
                move.w  #$20,(dword_FF9404).w           ; ' '
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E492
                neg.w   (dword_FF9404).w
loc_4E492:                                              ; CODE XREF: Boss_ShieldViperSetRotationSpeed+12   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSetRotationSpeed
; Waits for current rotation cycle to complete
Boss_ShieldViperWaitForRotationComplete:                ; DATA XREF: ROM:0004E00C   o  ; was: sub_4E49C
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E4B4
                addq.w  #2,4(a5)
locret_4E4B4:                                           ; CODE XREF: Boss_ShieldViperWaitForRotationComplete+12   j
                rts
; End of function Boss_ShieldViperWaitForRotationComplete
; Initializes spin attack with 64-frame timer
Boss_ShieldViperInitSpinAttack:                         ; DATA XREF: ROM:0004E00E   o  ; was: sub_4E4B6
                move.w  #$14,(dword_FF941C).w
                move.w  #$40,$48(a5)                    ; '@'
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperInitSpinAttack
; Counts down spin attack timer
Boss_ShieldViperSpinAttackTimer:                        ; DATA XREF: ROM:0004E010   o  ; was: sub_4E4CC
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E4E6
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
locret_4E4E6:                                           ; CODE XREF: Boss_ShieldViperSpinAttackTimer+E   j
                rts
; End of function Boss_ShieldViperSpinAttackTimer
; Spawns rotating projectile from boss angle
Projectile_ShieldViperSpawnRotating:                    ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+6   p  ; was: sub_4E4E8
                                        ; sub_4F5F0   p
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$120,d0
                andi.w  #$1C0,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                lea     $960(a5),a0
                eori.w  #$8000,2(a0)
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a5),d0
                add.l   $14(a5),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                rts
; End of function Projectile_ShieldViperSpawnRotating
; Disables projectile by clearing sprite attribute
Projectile_ShieldViperDisable:                          ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+80   p  ; was: sub_4E52A
                                        ; sub_4F64E   p
                andi.w  #$7FFF,$962(a5)
                rts
; End of function Projectile_ShieldViperDisable
; Updates spin attack and spawns projectiles
Boss_ShieldViperSpinAttackUpdate:                       ; DATA XREF: ROM:0004E012   o  ; was: sub_4E532
                move.w  #$14,(dword_FF941C).w
                bsr.w   Projectile_ShieldViperSpawnRotating
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bpl.s   locret_4E5BE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4E5BE
                jsr     Projectile_ShieldViperSpawnEffect(pc)  ; (pc)
                nop
                move.b  $20(a5),$20(a0)
                move.w  $970(a5),$10(a0)
                move.w  $974(a5),$14(a0)
                lea     (word_1B514).l,a3
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$120,d0
                andi.w  #$1C0,d0
                add.w   (dword_FF9418+2).w,d0
                add.w   (dword_FF9418+2).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                move.w  #2,$48(a5)
                addi.w  #4,$56(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_4E5BE
                bsr.w   Projectile_ShieldViperDisable
                bsr.w   Boss_WolfGaropaMovement1
                addq.w  #2,4(a5)
locret_4E5BE:                                           ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+12   j
                                        ; Boss_ShieldViperSpinAttackUpdate+1A   j
                rts
; End of function Boss_ShieldViperSpinAttackUpdate
; Updates sprite flip based on player position
