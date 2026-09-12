; Xi-Tiger controller, combat states, and movement helpers

Boss_XiTigerMain:                                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3D814
                tst.w   4(a5)
                beq.w   Boss_XiTigerDispatchState
                tst.w   8(a5)
                beq.s   Boss_XiTigerDispatchState
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_XiTigerUpdateStageRelativeCoordinates
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_XiTigerUpdateStageRelativeCoordinates
                tst.w   (BossHealth).w
                bne.s   Boss_XiTigerUpdateStageRelativeCoordinates
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.b  #1,(byte_FF830E).w
                move.w  #$FFFF,(word_FF821E).w
                bra.w   Boss_XiTigerBeginDefeatLeap
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateStageRelativeCoordinates:             ; CODE XREF: Boss_XiTigerMain+14   j  ; was: loc_3D85A
                                        ; Boss_XiTigerMain+1C   j
                jsr     (Gfx_ProcessDefaultColorFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                move.w  #$13E,d0
                add.w   (dword_FFA904).w,d0
                move.w  d0,$23C(a5)
Boss_XiTigerDispatchState:                              ; CODE XREF: Boss_XiTigerMain+4   j  ; was: loc_3D878
                                        ; Boss_XiTigerMain+C   j
                move.w  4(a5),d0
                movea.w Boss_XiTigerStateOffsets(pc,d0.w),a0
                adda.l  #Boss_XiTigerInit,a0
                jmp     (a0)
; End of function Boss_XiTigerMain
; ---------------------------------------------------------------------------
Boss_XiTigerStateOffsets:   dc.w    Boss_XiTigerInit-Boss_XiTigerInit  ; was: off_3D888
                                        ; DATA XREF: Boss_XiTigerMain+68   r
                dc.w    Boss_XiTigerSetup-Boss_XiTigerInit
                dc.w    Boss_XiTigerFallingLanding-Boss_XiTigerInit
                dc.w    Boss_XiTigerBattleStart-Boss_XiTigerInit
                dc.w    Boss_XiTigerBattleActive-Boss_XiTigerInit
                dc.w    Boss_XiTigerWaitForSequenceState-Boss_XiTigerInit
                dc.w    Boss_XiTigerIdleAttackDecisionState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDashRecoveryPoseState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDashPrep-Boss_XiTigerInit
                dc.w    Boss_XiTigerDashDecelerate-Boss_XiTigerInit
                dc.w    Boss_XiTigerCloseRangeJumpPreparationState-Boss_XiTigerInit
                dc.w    Boss_XiTigerJumpRise-Boss_XiTigerInit
                dc.w    Boss_XiTigerJumpPeak-Boss_XiTigerInit
                dc.w    Boss_XiTigerLandedState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatLeapState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatLandingDelayState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatFadeState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatSpawnDelayState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatCounterDrainState-Boss_XiTigerInit
                dc.w    Boss_XiTigerDefeatHideDelayState-Boss_XiTigerInit
                dc.w    Boss_XiTigerCloseRangeAI-Boss_XiTigerInit

; Initializes Xi-Tiger boss clearing sprites
Boss_XiTigerInit:                                       ; DATA XREF: Boss_XiTigerMain+6C   o  ; was: sub_3D8B2
                                        ; ROM:Boss_XiTigerStateOffsets   o
                addq.w  #2,4(a5)
                move.w  #2,(word_FF821E).w
                move.w  #$114,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                addq.w  #1,8(a5)
Boss_XiTigerInitReturn:                                 ; CODE XREF: Boss_XiTigerSetup+4   j  ; was: locret_3D8CC
                rts
; End of function Boss_XiTigerInit
; Complex setup with metasprite initialization
Boss_XiTigerSetup:                                      ; DATA XREF: ROM:0003D88A   o  ; was: sub_3D8CE
                tst.w   (word_FFF720).w
                bmi.s   Boss_XiTigerInitReturn
                movea.w a5,a4
                move.w  #$8280,(dword_FF8040).w
                moveq   #$18,d7
                movea.l #Boss_XiTigerMetaspriteDescriptors,a0
                movea.l #Boss_XiTigerPartRadii,a1
                movea.l #Boss_XiTigerPartLinks,a2
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
                move.l  #Boss_XiTigerClawMappingA,$248(a5)
                move.l  #Boss_XiTigerClawMappingA,$428(a5)
                move.w  #$2C,$266(a5)                   ; ','
                bclr    #7,$48E(a5)
                movea.l #$FFFF22C0,a0
                move.w  #$80,d0
                moveq   #9,d7
Boss_XiTigerAdjustNextPaletteBlock:                     ; CODE XREF: Boss_XiTigerSetup+AC   j  ; was: loc_3D96A
                moveq   #$F,d6
Boss_XiTigerAdjustNextPaletteWord:                      ; CODE XREF: Boss_XiTigerSetup:Boss_XiTigerAdvancePaletteAdjustment   j  ; was: loc_3D96C
                move.w  (a0)+,d1
                beq.s   Boss_XiTigerAdvancePaletteAdjustment
                sub.w   d0,d1
                move.w  d1,-2(a0)
Boss_XiTigerAdvancePaletteAdjustment:                   ; CODE XREF: Boss_XiTigerSetup+A0   j  ; was: loc_3D976
                dbf     d6,Boss_XiTigerAdjustNextPaletteWord
                dbf     d7,Boss_XiTigerAdjustNextPaletteBlock
                movea.l #Boss_XiTigerTileLoadCommand,a0
                jsr     (Tilemap_QueueIndexedRows).l
                bsr.w   Boss_XiTigerApplyFacingGraphics
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$E0,$490(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                lea     Boss_XiTigerInitialPoseChannels(pc),a0
                nop
                bsr.w   Boss_XiTigerInitializePoseChannels
                bra.w   Boss_XiTigerUpdateBattleStartPose
; End of function Boss_XiTigerSetup
; ---------------------------------------------------------------------------
Boss_XiTigerTileLoadCommand:    dc.w    $6100, $2000, $302, $1816, $1719, $1C1A, $1B1D, $1E, $1F00  ; was: word_3D9BE
                                        ; DATA XREF: Boss_XiTigerSetup+B0   o

; Xi-Tiger falling state with ground landing detection
Boss_XiTigerFallingLanding:                             ; DATA XREF: ROM:0003D88C   o  ; was: sub_3D9D0
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
                addi.l  #$4000,$1C(a5)
                bmi.s   Boss_XiTigerUpdateFallingPose
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   Boss_XiTigerUpdateFallingPose
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
                bra.s   Boss_XiTigerUpdateBattleStartPose
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateFallingPose:                          ; CODE XREF: Boss_XiTigerFallingLanding+10   j  ; was: loc_3DA30
                                        ; Boss_XiTigerFallingLanding+1A   j
                lea     Boss_XiTigerAirbornePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerFallingLanding
; Starts battle activating boss movement
Boss_XiTigerBattleStart:                                ; DATA XREF: ROM:0003D88E   o  ; was: sub_3DA3E
                tst.w   $58(a5)
                bpl.s   Boss_XiTigerUpdateBattleStartPose
                addq.w  #2,4(a5)
                clr.l   $498(a5)
                clr.w   $17E(a5)
                addq.w  #1,$1DC(a5)
                addq.w  #1,$1DE(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   Boss_XiTigerUpdateActiveBattlePose
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateBattleStartPose:                      ; CODE XREF: Boss_XiTigerSetup+EC   j  ; was: loc_3DA64
                                        ; Boss_XiTigerFallingLanding+5E   j
                lea     Boss_XiTigerBattleStartPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleStart
; Active battle state with AI update
Boss_XiTigerBattleActive:                               ; DATA XREF: ROM:0003D890   o  ; was: sub_3DA72
                cmpi.w  #$FFFC,$17E(a5)
                bne.s   Boss_XiTigerUpdateActiveBattlePose
                addq.w  #2,4(a5)
                moveq   #5,d0
                jsr     (BossMessage_Start).l
Boss_XiTigerUpdateActiveBattlePose:                     ; CODE XREF: Boss_XiTigerBattleStart+24   j  ; was: loc_3DA86
                                        ; Boss_XiTigerBattleActive+6   j
                lea     Boss_XiTigerIdlePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerBattleActive
; Waits for the player sequence to finish before entering the idle decision loop
Boss_XiTigerWaitForSequenceState:                       ; DATA XREF: ROM:0003D892   o  ; was: sub_3DA94
                tst.w   (MessageSequenceState).w
                bne.s   Boss_XiTigerUpdateActiveBattlePose
                clr.b   (byte_FF80EC).w
                addi.w  #$40,(word_FFA974).w            ; '@'
                bra.w   Boss_XiTigerSetIdleState
; End of function Boss_XiTigerWaitForSequenceState
; Check recovery conditions and transition Xi-Tiger state
Boss_XiTigerRecoveryCheck:
                tst.w   $58(a5)                         ; was: sub_3DAA8
                bpl.s   Boss_XiTigerUpdateRecoveryPose
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateRecoveryPose:                         ; CODE XREF: Boss_XiTigerRecoveryCheck+4   j  ; was: loc_3DABE
                move.w  a5,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$148,$914(a5)
                lea     Boss_XiTigerLandingRecoveryPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerRecoveryCheck
; Check button input to reverse Xi-Tiger state
Boss_XiTigerButtonCheck:
                btst    #6,(word_FFF708).w              ; was: sub_3DAE2
                beq.s   Boss_XiTigerUpdateButtonCheckPose
                subq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFE,$C(a5)
Boss_XiTigerUpdateButtonCheckPose:                      ; CODE XREF: Boss_XiTigerButtonCheck+6   j  ; was: loc_3DAF8
                lea     Boss_XiTigerLoopingAirbornePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerButtonCheck
; Enters the idle decision loop with a fresh pose-command cursor
Boss_XiTigerEnterIdleState:                             ; CODE XREF: Boss_XiTigerDashDecelerate+24   j  ; was: sub_3DB06
                                        ; Boss_XiTigerCloseRangeAI+E   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
Boss_XiTigerSetIdleState:                               ; CODE XREF: Boss_XiTigerWaitForSequenceState+10   j  ; was: loc_3DB10
                move.w  #$C,4(a5)
                move.w  #$C,$17E(a5)
                move.l  #Boss_XiTigerGroundedBodyMapping,$68(a5)
                bclr    #6,$261(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                move.w  #1,$1DC(a5)
                move.w  #1,$1DE(a5)
; Xi-Tiger idle state with attack decision
Boss_XiTigerIdleAttackDecisionState:                    ; DATA XREF: ROM:0003D894   o  ; was: loc_3DB48
                move.w  #2,(word_FF8246).w
                addi.w  #$10,(word_FF8234).w
                tst.w   $17E(a5)
                bpl.s   Boss_XiTigerUpdateIdlePose
                move.w  #$C,$17E(a5)
                cmpi.w  #$1E0,(word_FF8234).w
                bmi.s   Boss_XiTigerUpdateIdlePose
                move.w  #$1E0,(word_FF8234).w
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$A0,d0
                bmi.w   Boss_XiTigerBeginDashRecoveryPose
                btst    #0,(RandomNumberState).w
                bne.w   Boss_XiTigerBeginDashPreparation
                bra.w   Boss_XiTigerBeginCloseRangeJumpPreparation
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateIdlePose:                             ; CODE XREF: Boss_XiTigerEnterIdleState+52   j  ; was: loc_3DB8A
                                        ; Boss_XiTigerEnterIdleState+60   j
                lea     Boss_XiTigerIdlePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                move.w  (FrameCounter).w,d5
                andi.w  #$F,d5
                beq.w   Boss_XiTigerSetFacingDirection
                rts
; ---------------------------------------------------------------------------
Boss_XiTigerBeginDashPreparation:                       ; CODE XREF: Boss_XiTigerEnterIdleState+7C   j  ; was: loc_3DBA6
                                        ; Boss_XiTigerDashDecelerate+44   j
                move.w  #$10,4(a5)
                move.l  #Boss_XiTigerGroundedBodyMapping,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #0,$1DC(a5)
                move.w  #1,$1DE(a5)
                move.w  #3,$17E(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
; End of function Boss_XiTigerEnterIdleState
; Xi-Tiger dash preparation with sound and rotation setup
Boss_XiTigerDashPrep:                                   ; DATA XREF: ROM:0003D898   o  ; was: sub_3DBE6
                tst.w   $17E(a5)
                bpl.s   Boss_XiTigerUpdateDashPreparationPose
                subi.w  #$A0,(word_FF8234).w
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                bset    #6,$261(a5)
                move.l  #$80000,$498(a5)
                tst.w   $54(a5)
                beq.s   Boss_XiTigerUpdateDashPreparationPose
                neg.l   $498(a5)
Boss_XiTigerUpdateDashPreparationPose:                  ; CODE XREF: Boss_XiTigerDashPrep+4   j  ; was: loc_3DC24
                                        ; Boss_XiTigerDashPrep+38   j
                lea     Boss_XiTigerDashPreparationPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerDashPrep
; Xi-Tiger dash deceleration and attack decision logic
Boss_XiTigerDashDecelerate:                             ; DATA XREF: ROM:0003D89A   o  ; was: sub_3DC32
                tst.l   $498(a5)
                beq.s   Boss_XiTigerUpdatePostDashDecision
                bmi.s   Boss_XiTigerDecelerateNegativeDashVelocity
                subi.l  #$4000,$498(a5)
                bra.s   Boss_XiTigerUpdatePostDashDecision
; ---------------------------------------------------------------------------
Boss_XiTigerDecelerateNegativeDashVelocity:             ; CODE XREF: Boss_XiTigerDashDecelerate+6   j  ; was: loc_3DC44
                addi.l  #$4000,$498(a5)
Boss_XiTigerUpdatePostDashDecision:                     ; CODE XREF: Boss_XiTigerDashDecelerate+4   j  ; was: loc_3DC4C
                                        ; Boss_XiTigerDashDecelerate+10   j
                tst.w   $58(a5)
                bpl.s   Boss_XiTigerUpdateDashPreparationPose
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerEnterIdleState
                clr.l   $498(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
                move.w  (RandomNumberState).w,d5
                cmpi.w  #$98,d0
                bmi.w   Boss_XiTigerBeginDashRecoveryPose
                andi.w  #2,d5
                beq.w   Boss_XiTigerBeginCloseRangeJumpPreparation
                bra.w   Boss_XiTigerBeginDashPreparation
; ---------------------------------------------------------------------------
Boss_XiTigerBeginDashRecoveryPose:                      ; CODE XREF: Boss_XiTigerEnterIdleState+72   j  ; was: loc_3DC7A
                                        ; Boss_XiTigerDashDecelerate+38   j
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                move.w  #1,$1DC(a5)
                move.w  #0,$1DE(a5)
; Holds the recovery pose before entering close-range decision logic
Boss_XiTigerDashRecoveryPoseState:                      ; DATA XREF: ROM:0003D896   o  ; was: loc_3DCA8
                tst.w   $58(a5)
                bmi.s   Boss_XiTigerBeginCloseRangeDecisionState
                lea     Boss_XiTigerDashRecoveryPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
Boss_XiTigerBeginCloseRangeDecisionState:               ; CODE XREF: Boss_XiTigerDashDecelerate+7A   j  ; was: loc_3DCBC
                                        ; Boss_XiTigerCloseRangeAI+24   j
                move.w  #$28,4(a5)                      ; '('
                move.w  (RandomNumberState).w,d0
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
                bpl.s   Boss_XiTigerUpdateCloseRangeAttackPose
                bsr.w   Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerEnterIdleState
                move.w  (RandomNumberState).w,d5
                cmpi.w  #$98,d0
                bpl.s   Boss_XiTigerChooseDistantCloseRangeAttack
                andi.w  #3,d5
                beq.w   Boss_XiTigerBeginCloseRangeJumpPreparation
                bra.w   Boss_XiTigerBeginCloseRangeDecisionState
; ---------------------------------------------------------------------------
Boss_XiTigerChooseDistantCloseRangeAttack:              ; CODE XREF: Boss_XiTigerCloseRangeAI+1A   j  ; was: loc_3DD0E
                andi.w  #1,d5
                beq.w   Boss_XiTigerBeginCloseRangeJumpPreparation
                bra.w   Boss_XiTigerBeginDashPreparation
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateCloseRangeAttackPose:                 ; CODE XREF: Boss_XiTigerCloseRangeAI+4   j  ; was: loc_3DD1A
                lea     Boss_XiTigerCloseRangeAttackPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
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
                bsr.w   Boss_XiTigerSelectBodyMapping
                bra.w   Boss_XiTigerUpdateSprites
; ---------------------------------------------------------------------------
Boss_XiTigerBeginCloseRangeJumpPreparation:             ; CODE XREF: Boss_XiTigerEnterIdleState+80   j  ; was: loc_3DD56
                                        ; Boss_XiTigerDashDecelerate+40   j
                move.w  #$14,4(a5)
                clr.w   $17E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #Boss_XiTigerGroundedBodyMapping,$68(a5)
                move.w  #$CAA0,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; Waits for the close-range jump pose before launching
Boss_XiTigerCloseRangeJumpPreparationState:             ; DATA XREF: ROM:0003D89C   o  ; was: loc_3DD8C
                cmpi.w  #$FFFD,$17E(a5)
                bne.s   Boss_XiTigerUpdateCloseRangeJumpPreparationPose
                addq.w  #2,4(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  #$20000,$498(a5)
                tst.w   $54(a5)
                beq.s   Boss_XiTigerUpdateCloseRangeJumpPreparationPose
                neg.l   $498(a5)
Boss_XiTigerUpdateCloseRangeJumpPreparationPose:        ; CODE XREF: Boss_XiTigerCloseRangeAI+AC   j  ; was: loc_3DDB6
                                        ; Boss_XiTigerCloseRangeAI+CA   j
                lea     Boss_XiTigerCloseRangeJumpPreparationPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerCloseRangeJumpPreparationState
; Xi-Tiger jump rising phase with gravity
Boss_XiTigerJumpRise:                                   ; DATA XREF: ROM:0003D89E   o  ; was: sub_3DDC4
                addi.l  #$4000,$1C(a5)
                bmi.s   Boss_XiTigerUpdateCloseRangeJumpPreparationPose
                move.l  #Boss_XiTigerAirborneBodyMapping,$68(a5)
                addq.w  #2,4(a5)
                bset    #6,$261(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                subi.w  #$E0,(word_FF8234).w
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
Boss_XiTigerUpdateJumpAirbornePose:                     ; CODE XREF: Boss_XiTigerJumpPeak+10   j  ; was: loc_3DDFA
                lea     Boss_XiTigerAirbornePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpRise
; Xi-Tiger jump peak and landing detection
Boss_XiTigerJumpPeak:                                   ; DATA XREF: ROM:0003D8A0   o  ; was: sub_3DE08
                addi.l  #$4000,$1C(a5)
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   Boss_XiTigerUpdateJumpAirbornePose
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
Boss_XiTigerUpdateLandingRecoveryPose:                  ; CODE XREF: Boss_XiTigerLandedState+48   j  ; was: loc_3DE62
                lea     Boss_XiTigerLandingRecoveryPoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bra.w   Boss_XiTigerUpdateSprites
; End of function Boss_XiTigerJumpPeak
; Xi-Tiger landed state with AI decision logic
Boss_XiTigerLandedState:                                ; DATA XREF: ROM:0003D8A2   o  ; was: sub_3DE70
                tst.w   $58(a5)
                bpl.s   Boss_XiTigerDecelerateLandingVelocity
                clr.l   $498(a5)
                bsr.w   Boss_XiTigerSetFacingDirection
                tst.w   (word_FF8234).w
                bmi.w   Boss_XiTigerEnterIdleState
                move.w  (RandomNumberState).w,d5
                cmpi.w  #$A0,d0
                bpl.w   Boss_XiTigerBeginDashPreparation
                andi.w  #4,d5
                beq.w   Boss_XiTigerBeginDashRecoveryPose
                bra.w   Boss_XiTigerBeginCloseRangeJumpPreparation
; ---------------------------------------------------------------------------
Boss_XiTigerDecelerateLandingVelocity:                  ; CODE XREF: Boss_XiTigerLandedState+4   j  ; was: loc_3DE9E
                move.l  $498(a5),d0
                beq.s   Boss_XiTigerApplyLandingVelocity
                bmi.s   Boss_XiTigerDecelerateNegativeLandingVelocity
                subi.l  #$2000,d0
                bra.s   Boss_XiTigerApplyLandingVelocity
; ---------------------------------------------------------------------------
Boss_XiTigerDecelerateNegativeLandingVelocity:          ; CODE XREF: Boss_XiTigerLandedState+34   j  ; was: loc_3DEAE
                addi.l  #$2000,d0
Boss_XiTigerApplyLandingVelocity:                       ; CODE XREF: Boss_XiTigerLandedState+32   j  ; was: loc_3DEB4
                                        ; Boss_XiTigerLandedState+3C   j
                move.l  d0,$498(a5)
                bra.s   Boss_XiTigerUpdateLandingRecoveryPose
; End of function Boss_XiTigerLandedState
; Launches the boss into the scripted defeat leap
Boss_XiTigerBeginDefeatLeap:                            ; CODE XREF: Boss_XiTigerMain+42   j  ; was: sub_3DEBA
                move.w  #$1C,4(a5)
                move.w  #$30,(word_FF809E).w            ; '0'
                move.l  #Boss_XiTigerAirborneBodyMapping,$68(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFB4000,$1C(a5)
                move.l  #$12000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$100,$BC(a5)
                bmi.s   Boss_XiTigerApplyDefeatLeapFacing
                neg.l   $18(a5)
                clr.w   $54(a5)
Boss_XiTigerApplyDefeatLeapFacing:                      ; CODE XREF: Boss_XiTigerBeginDefeatLeap+42   j  ; was: loc_3DF06
                bsr.w   Boss_XiTigerApplyFacingGraphics
                clr.w   $1DC(a5)
                clr.w   $1DE(a5)
; End of function Boss_XiTigerBeginDefeatLeap
; Applies gravity until the scripted defeat leap reaches the floor
Boss_XiTigerDefeatLeapState:                            ; DATA XREF: ROM:0003D8A4   o  ; was: sub_3DF12
                jsr     (Gfx_UpdatePaletteFade).l
                addi.l  #$4000,$1C(a5)
                bmi.s   Boss_XiTigerUpdateDefeatLeapPose
                move.w  $914(a5),d0
                cmp.w   $23C(a5),d0
                bmi.s   Boss_XiTigerUpdateDefeatLeapPose
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
Boss_XiTigerUpdateDefeatLeapPose:                       ; CODE XREF: Boss_XiTigerDefeatLeapState+E   j  ; was: loc_3DF6A
                                        ; Boss_XiTigerDefeatLeapState+18   j
                lea     Boss_XiTigerLoopingAirbornePoseCommands(pc),a1
                nop
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                bra.w   Boss_XiTigerSpawnDefeatParticle
; End of function Boss_XiTigerDefeatLeapState
; Holds the landing pose, decelerates, and emits scripted projectiles
Boss_XiTigerDefeatLandingDelayState:                    ; DATA XREF: ROM:0003D8A6   o  ; was: sub_3DF7C
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$11C(a5)
                bpl.s   Boss_XiTigerDecelerateDefeatLanding
                addq.w  #2,4(a5)
                clr.w   6(a5)
                move.b  #$14,d0
                jsr     (Sound_PlaySFX).l
Boss_XiTigerDecelerateDefeatLanding:                    ; CODE XREF: Boss_XiTigerDefeatLandingDelayState+A   j  ; was: loc_3DF9A
                tst.l   $18(a5)
                beq.s   Boss_XiTigerUpdateDefeatLandingPose
                bpl.s   Boss_XiTigerDeceleratePositiveDefeatVelocity
                addi.l  #$1000,$18(a5)
                bra.s   Boss_XiTigerUpdateDefeatLandingPose
; ---------------------------------------------------------------------------
Boss_XiTigerDeceleratePositiveDefeatVelocity:           ; CODE XREF: Boss_XiTigerDefeatLandingDelayState+24   j  ; was: loc_3DFAC
                subi.l  #$1000,$18(a5)
Boss_XiTigerUpdateDefeatLandingPose:                    ; CODE XREF: Boss_XiTigerDefeatLandingDelayState+22   j  ; was: loc_3DFB4
                                        ; Boss_XiTigerDefeatLandingDelayState+2E   j
                lea     Boss_XiTigerDefeatPoseCommands(pc),a1
                nop
Boss_XiTigerUpdateDefeatPoseAndProjectile:              ; CODE XREF: Boss_XiTigerDefeatFadeState+40   j  ; was: loc_3DFBA
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                bsr.w   Boss_XiTigerUpdatePoseAnimation
                bsr.w   Boss_XiTigerUpdateSprites
                bra.w   Boss_XiTigerSpawnDefeatParticle
; End of function Boss_XiTigerDefeatLandingDelayState
; Fades the defeated boss for 32 frames before clearing stage objects
Boss_XiTigerDefeatFadeState:                            ; DATA XREF: ROM:0003D8A8   o  ; was: sub_3DFD2
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_ApplyDefeatPaletteFade
                addq.w  #1,6(a5)
                cmpi.w  #$20,6(a5)                      ; ' '
                bmi.s   Boss_XiTigerUpdateDefeatFadePose
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   8(a5)
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$114,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
Boss_XiTigerUpdateDefeatFadePose:                       ; CODE XREF: Boss_XiTigerDefeatFadeState+14   j  ; was: loc_3E00C
                lea     Boss_XiTigerDefeatPoseCommands(pc),a1
                nop
                bra.s   Boss_XiTigerUpdateDefeatPoseAndProjectile
; End of function Boss_XiTigerDefeatFadeState
; Counts down to the player-spawn effect while retaining the defeat-palette fade
Boss_XiTigerDefeatSpawnDelayState:                      ; DATA XREF: ROM:0003D8AA   o  ; was: sub_3E014
                subq.w  #1,$11C(a5)
                bpl.s   Boss_XiTigerApplyDefeatSpawnDelayPaletteFade
                addq.w  #2,4(a5)
                jsr     (TransitionEffect_SpawnAtOwner).l
                addi.w  #$20,$14(a0)                    ; ' '
Boss_XiTigerApplyDefeatSpawnDelayPaletteFade:           ; CODE XREF: Boss_XiTigerDefeatSpawnDelayState+4   j  ; was: loc_3E02A
                bra.w   Boss_ApplyDefeatPaletteFade
; End of function Boss_XiTigerDefeatSpawnDelayState
; Drains the defeat counter before starting the final hide delay
Boss_XiTigerDefeatCounterDrainState:                    ; DATA XREF: ROM:0003D8AC   o  ; was: sub_3E02E
                subq.w  #2,6(a5)
                bne.s   Boss_XiTigerApplyDefeatCounterDrainPaletteFade
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
Boss_XiTigerApplyDefeatCounterDrainPaletteFade:         ; CODE XREF: Boss_XiTigerDefeatCounterDrainState+4   j  ; was: loc_3E03E
                bra.w   Boss_ApplyDefeatPaletteFade
; End of function Boss_XiTigerDefeatCounterDrainState
; Hides the boss after the final defeat delay
Boss_XiTigerDefeatHideDelayState:                       ; DATA XREF: ROM:0003D8AE   o  ; was: sub_3E042
                subq.w  #1,$11C(a5)
                bpl.s   Boss_XiTigerDefeatHideDelayReturn
                bset    #4,2(a5)
Boss_XiTigerDefeatHideDelayReturn:                      ; CODE XREF: Boss_XiTigerDefeatHideDelayState+4   j  ; was: locret_3E04E
                rts
; End of function Boss_XiTigerDefeatHideDelayState
; Updates boss sprite rendering
Boss_XiTigerUpdateSprites:                              ; CODE XREF: Boss_XiTigerFallingLanding+6A   j  ; was: sub_3E050
                                        ; Boss_XiTigerBattleStart+30   j
                moveq   #$17,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                bsr.w   Boss_XiTigerUpdateBody
                bsr.w   Boss_XiTigerUpdateClaws
                rts
; End of function Boss_XiTigerUpdateSprites
; Sets Xi-Tiger boss facing direction based on player position
Boss_XiTigerSetFacingDirection:                         ; CODE XREF: Boss_XiTigerEnterIdleState+9A   j  ; was: sub_3E062
                                        ; Boss_XiTigerEnterIdleState+DC   p
                clr.w   $54(a5)
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   Boss_XiTigerApplyFacingGraphics
                move.w  #$100,$54(a5)
; End of function Boss_XiTigerSetFacingDirection
; Applies the current facing to the body and claw-part flip bits
Boss_XiTigerApplyFacingGraphics:                        ; CODE XREF: Boss_XiTigerSetup+BC   p  ; was: sub_3E076
                                        ; Boss_XiTigerBeginDefeatLeap:Boss_XiTigerApplyDefeatLeapFacing   p
                moveq   #3,d5
                tst.w   $54(a5)
                beq.s   Boss_XiTigerApplyZeroFacingGraphics
                bset    d5,$6E(a5)
                bset    d5,$2AE(a5)
                bset    d5,$5AE(a5)
                bclr    d5,$CE(a5)
                bclr    d5,$7EE(a5)
                rts
; ---------------------------------------------------------------------------
Boss_XiTigerApplyZeroFacingGraphics:                    ; CODE XREF: Boss_XiTigerApplyFacingGraphics+6   j  ; was: loc_3E094
                bclr    d5,$6E(a5)
                bclr    d5,$2AE(a5)
                bclr    d5,$5AE(a5)
                bset    d5,$CE(a5)
                bset    d5,$7EE(a5)
                rts
; End of function Boss_XiTigerApplyFacingGraphics
; Selects one of two body anchors from the relative claw-part heights
Boss_XiTigerSelectBodyAnchorByClawHeight:
                move.w  $6D4(a5),d0                     ; was: sub_3E0AA
                cmp.w   $914(a5),d0
                bpl.s   Boss_XiTigerSelectPrimaryBodyAnchor
                move.w  #$CF20,$48(a5)
                move.w  #$CF20,$4A(a5)
                move.w  $23C(a5),$914(a5)
                rts
; ---------------------------------------------------------------------------
Boss_XiTigerSelectPrimaryBodyAnchor:                    ; CODE XREF: Boss_XiTigerSelectBodyAnchorByClawHeight+8   j  ; was: loc_3E0C8
                move.w  #$CCE0,$48(a5)
                move.w  #$CCE0,$4A(a5)
                move.w  $23C(a5),$6D4(a5)
                rts
; End of function Boss_XiTigerSelectBodyAnchorByClawHeight
; Selects one of two body mappings from the global frame bit
Boss_XiTigerSelectBodyMapping:                          ; CODE XREF: Boss_XiTigerCloseRangeAI+68   p  ; was: sub_3E0DC
                move.l  #Boss_XiTigerGroundedBodyMapping,$68(a5)
                btst    #3,(FrameCounter+1).w
                bne.s   Boss_XiTigerSelectBodyMappingReturn
                move.l  #Boss_XiTigerAirborneBodyMapping,$68(a5)
Boss_XiTigerSelectBodyMappingReturn:                    ; CODE XREF: Boss_XiTigerSelectBodyMapping+E   j  ; was: locret_3E0F4
                rts
; End of function Boss_XiTigerSelectBodyMapping
; Updates claw sprites based on state
Boss_XiTigerUpdateClaws:                                ; CODE XREF: Boss_XiTigerUpdateSprites+C   p  ; was: sub_3E0F6
                movea.w #(word_FFC860-M68K_RAM),a0
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
                tst.w   $1DE(a5)
                beq.s   Boss_XiTigerConfigureSecondClaw
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
Boss_XiTigerConfigureSecondClaw:                        ; CODE XREF: Boss_XiTigerUpdateClaws+12   j  ; was: loc_3E114
                bsr.s   Boss_XiTigerUpdateClawMapping
                movea.w #(word_FFCA40-M68K_RAM),a0
                move.w  #$C280,$E(a0)
                move.w  #$10,d1
                tst.w   $1DC(a5)
                beq.s   Boss_XiTigerUpdateClawMapping
                move.w  #$CA80,$E(a0)
                move.w  #0,d1
; End of function Boss_XiTigerUpdateClaws
; Applies angle and facing flips, then selects the claw mapping
Boss_XiTigerUpdateClawMapping:                          ; CODE XREF: Boss_XiTigerUpdateClaws:Boss_XiTigerConfigureSecondClaw   p  ; was: sub_3E134
                                        ; Boss_XiTigerUpdateClaws+32   j
                move.w  $56(a0),d0
                add.w   $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                bmi.s   Boss_XiTigerApplyClawFacingFlip
                eori.w  #$1800,$E(a0)
Boss_XiTigerApplyClawFacingFlip:                        ; CODE XREF: Boss_XiTigerUpdateClawMapping+14   j  ; was: loc_3E150
                tst.w   $54(a5)
                beq.s   Boss_XiTigerSelectClawMapping
                eori.w  #$800,$E(a0)
Boss_XiTigerSelectClawMapping:                          ; CODE XREF: Boss_XiTigerUpdateClawMapping+20   j  ; was: loc_3E15C
                asr.w   #4,d0
                andi.w  #$C,d0
                add.w   d1,d0
                move.l  Boss_XiTigerClawMappings(pc,d0.w),8(a0)
                rts
; End of function Boss_XiTigerUpdateClawMapping
; ---------------------------------------------------------------------------
Boss_XiTigerClawMappings:   dc.l    Boss_XiTigerClawMappingA  ; DATA XREF: Boss_XiTigerUpdateClawMapping+30   r  ; was: off_3E16C
                dc.l    Boss_XiTigerClawMappingB
                dc.l    Boss_XiTigerClawMappingC
                dc.l    Boss_XiTigerClawMappingD
                dc.l    Boss_XiTigerClawMappingE
                dc.l    Boss_XiTigerClawMappingD
                dc.l    Boss_XiTigerClawMappingC
                dc.l    Boss_XiTigerClawMappingB

; Updates boss body metasprite positions
Boss_XiTigerUpdateBody:                                 ; CODE XREF: Boss_XiTigerUpdateSprites+8   p  ; was: sub_3E18C
                move.w  #$C0,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_XiTigerUpdateBody
; Applies the current boss defeat counter to the shared palette buffer
Boss_ApplyDefeatPaletteFade:                            ; CODE XREF: Boss_ShellshogunDefeatLaunchState+C   p  ; was: sub_3E1AA
                                        ; Boss_ShellshogunDefeatPaletteState:Boss_ShellshogunApplyDefeatPaletteFade   j
                move.w  6(a5),d0
                asr.w   #1,d0
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                moveq   #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_ApplyDefeatPaletteFade
; Spawns a randomized particle during the scripted defeat sequence
Boss_XiTigerSpawnDefeatParticle:                        ; CODE XREF: Boss_XiTigerDefeatLeapState+66   j  ; was: sub_3E1C0
                                        ; Boss_XiTigerDefeatLandingDelayState+52   j
                jsr     (Projectile_UpdateAfterGlobalDelay).l
                bne.s   Boss_XiTigerSpawnDefeatParticleReturn
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.w  #$FFFD,$1C(a0)
                move.w  (RandomNumberState+2).w,$1E(a0)
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d0                         ; ' '
                subi.w  #$10,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (RandomNumberState).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
Boss_XiTigerSpawnDefeatParticleReturn:                  ; CODE XREF: Boss_XiTigerSpawnDefeatParticle+6   j  ; was: locret_3E21A
                rts
; End of function Boss_XiTigerSpawnDefeatParticle
; Interprets pose commands, advances 16 interpolation channels, and applies their angles
Boss_XiTigerUpdatePoseAnimation:                        ; CODE XREF: Boss_XiTigerFallingLanding+66   p  ; was: sub_3E21C
                                        ; Boss_XiTigerBattleStart+2C   p
                clr.w   $29C(a5)
                tst.w   $C(a5)
                bpl.s   Boss_XiTigerAdvancePoseInterpolation
Boss_XiTigerReadPoseCommand:                            ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+4A   j  ; was: loc_3E226
                move.w  $58(a5),d0
                bmi.w   Boss_XiTigerApplyPoseAngles
                cmpi.b  #$80,(a1,d0.w)
                bne.s   Boss_XiTigerDecodePoseCommand
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
Boss_XiTigerDecodePoseCommand:                          ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+18   j  ; was: loc_3E248
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_XiTigerCheckPoseLoopCommand
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
Boss_XiTigerCheckPoseLoopCommand:                       ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+34   j  ; was: loc_3E258
                cmpi.w  #$FFFF,d3
                bne.s   Boss_XiTigerBeginPoseCommand
                clr.w   $58(a5)
                clr.w   $A(a5)
                bra.s   Boss_XiTigerReadPoseCommand
; ---------------------------------------------------------------------------
Boss_XiTigerBeginPoseCommand:                           ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+40   j  ; was: loc_3E268
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #Boss_XiTigerPoseTargets,d0
                movea.l d0,a0
                bsr.w   Boss_XiTigerBeginPoseInterpolation
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$A(a5)
                addq.w  #1,$29C(a5)
                subq.w  #1,$17E(a5)
                tst.w   $C(a5)
                bmi.s   Boss_XiTigerApplyPoseAngles
Boss_XiTigerAdvancePoseInterpolation:                   ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+8   j  ; was: loc_3E2A2
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$F,d7
                jsr     (Anim_ApplyInterpolationStep).l
Boss_XiTigerApplyPoseAngles:                            ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+E   j  ; was: loc_3E2B2
                                        ; Boss_XiTigerUpdatePoseAnimation+84   j
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
; End of function Boss_XiTigerUpdatePoseAnimation
; Begins interpolation from the current channels to the selected pose target
Boss_XiTigerBeginPoseInterpolation:                     ; CODE XREF: Boss_XiTigerUpdatePoseAnimation+62   p  ; was: sub_3E3B0
                movea.l #Boss_XiTigerNeutralPose,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$F,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_XiTigerBeginPoseInterpolation
; Initializes all 16 Xi-Tiger pose channels from bytes at a0
Boss_XiTigerInitializePoseChannels:                     ; CODE XREF: Boss_XiTigerSetup+E8   p  ; was: sub_3E3C6
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #$F,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_XiTigerInitializePoseChannels
; ---------------------------------------------------------------------------
Boss_XiTigerIdlePoseCommands:   dc.w    $F510, 0, $15, 0, $80DC, $F510, $10, $15, $10, $80DC, $FFFF  ; was: word_3E3D2
                                        ; DATA XREF: Boss_XiTigerBattleActive:loc_3DA86   o
                                        ; Boss_XiTigerEnterIdleState:Boss_XiTigerUpdateIdlePose   o
Boss_XiTigerLandingRecoveryPoseCommands:    dc.w    $F810, $70, $C, $70, $FFFE  ; was: word_3E3E8
                                        ; DATA XREF: Boss_XiTigerRecoveryCheck+2C   o
                                        ; Boss_XiTigerJumpPeak:Boss_XiTigerUpdateLandingRecoveryPose   o
Boss_XiTigerDashRecoveryPoseCommands:   dc.w    $FC08   ; DATA XREF: Boss_XiTigerDashDecelerate+7C   o  ; was: word_3E3F2
                dc.w    $20, $12, $20, $FFFE
Boss_XiTigerCloseRangeAttackPoseCommands:   dc.w    $F810, $20, 3, $20, $F50E, $30, 4, $30, $F810, $20, 3, $20, $F511, $40, 4, $40  ; was: word_3E3FC
                                        ; DATA XREF: Boss_XiTigerCloseRangeAI:Boss_XiTigerUpdateCloseRangeAttackPose   o
                dc.w    $F810, $20, 3, $20, $F510, $50, 4, $50, $FFFF
Boss_XiTigerDashPreparationPoseCommands:    dc.w    $F414, $80, $16, $80  ; was: word_3E42E
                                        ; DATA XREF: Boss_XiTigerDashPrep:Boss_XiTigerUpdateDashPreparationPose   o
                dc.w    $8880, $90, $FE10, $90, $10, $90, $FFFE
Boss_XiTigerCloseRangeJumpPreparationPoseCommands:  dc.w    $F410, $70, $18, $70, $FC0C, $A0, $C, $A0, $FFFE  ; was: word_3E444
                                        ; DATA XREF: Boss_XiTigerCloseRangeJumpPreparationState:Boss_XiTigerUpdateCloseRangeJumpPreparationPose   o
Boss_XiTigerAirbornePoseCommands:   dc.w    $CA40, $B0, $FE0C, $B0, 8, $B0, $FFFE  ; was: word_3E456
                                        ; DATA XREF: Boss_XiTigerFallingLanding:loc_3DA30   o
                                        ; Boss_XiTigerJumpRise:Boss_XiTigerUpdateJumpAirbornePose   o
Boss_XiTigerLoopingAirbornePoseCommands:    dc.w    $C, $A0, $C, $B0, $FFFF  ; was: word_3E464
                                        ; DATA XREF: Boss_XiTigerButtonCheck:Boss_XiTigerUpdateButtonCheckPose   o
                                        ; Boss_XiTigerDefeatLeapState:Boss_XiTigerUpdateDefeatLeapPose   o
Boss_XiTigerDefeatPoseCommands: dc.w    $E220, $C0, $E120, $70, $FFFF  ; was: word_3E46E
                                        ; DATA XREF: Boss_XiTigerDefeatLandingDelayState:Boss_XiTigerUpdateDefeatLandingPose   o
                                        ; Boss_XiTigerDefeatFadeState:Boss_XiTigerUpdateDefeatFadePose   o
Boss_XiTigerBattleStartPoseCommands:    dc.w    $F058, $D0, $38, $D0, $EC50, $C0, $D040, $C0, $ED18, $10, $14, $10, $FFFE  ; was: word_3E478
                                        ; DATA XREF: Boss_XiTigerBattleStart:loc_3DA64   o
Boss_XiTigerPoseTargets:    dc.w    $C8EC, $3860, $1038, $38F0, $8C50, $AC70, $6400, $E0FA, $D4F8, $3050, $1014, $1018, $9640, $9870, $50C0, $606  ; was: word_3E492
                                        ; DATA XREF: Boss_XiTigerUpdatePoseAnimation+5A   o
                dc.w    $C4E4, $B470, $1010, $4000, $9080, $3070, $6EF8, $D0FA, $D600, $2000, $800, $5000, $A090, $5070, $6EF0, $D00C
                dc.w    $D608, $3010, $1008, $4000, $A090, $6060, $6008, $D00C, $DA06, $1800, $F8F4, $6000, $9490, $4080, $70F8, $C00C
                dc.w    $CCE8, $2038, $808, $6000, $9688, $F060, $38D0, $20FC
Boss_XiTigerInitialPoseChannels:    dc.w    $D0F8, $60, $10E0, $6000, $8880, $A070, $A0A0, 0, $D000, $6860, $1000, $1000, $8830, $C090, $A0A0, $F0  ; was: word_3E502
                                        ; DATA XREF: Boss_XiTigerSetup+E2   o
                dc.w    $C0E0, $C0C0, $1010, $4000, $8080, $A050, $6400, $E010, $C0D0, $C060, 0, $6030, $8070, $AC70, $5800, $D8F8
                dc.w    $D808, $2800, $1040, $40E0, $A0B0, $C070, $6010, $D80A, $C800, $40E0, $1030, $10, $8040, $2070, $5000, $F000
                dc.w    $C8F0, $5050, $1030, $10, $9030, $B070, $5000, $F000, $D0F6, $5450, $1830, $410, $8A2C, $B068, $50FC, $F000
