; Initializes stage transition state with cutscene parameters
Stage_InitTransitionState:                              ; CODE XREF: Stage_CheckTransitionReady+16   j  ; was: sub_10390
                                        ; Stage_WaitAndTransition+1C   j
                move.w  #3,(word_FF8230).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                bra.w   loc_103C0
; End of function Stage_InitTransitionState
; Initializes transition between stage sections
Stage_InitSectionChange:                                ; CODE XREF: Camera_Stage2PhaseHandler   p  ; was: sub_103B0
                                        ; sub_C98E   p
                tst.w   (MessageSequenceState).w
                bne.s   locret_103D2
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
loc_103C0:                                              ; CODE XREF: Stage_InitTransitionState+1C   j
                clr.w   (word_FF820C).w
                addq.w  #2,(StageTableIndex).w
                bclr    #7,(dword_FFA20E).w
                clr.b   (byte_FFA209).w
locret_103D2:                                           ; CODE XREF: Stage_InitSectionChange+4   j
                rts
; End of function Stage_InitSectionChange
; Initializes score display timer to 0x5C
UI_InitScoreTimer:                                      ; CODE XREF: Camera_AntroidBossInit+A   p  ; was: sub_103D4
                                        ; Stage_InitPostBoss+12   p
                move.w  #$5C,(MessageSequenceState).w   ; '\'
                bra.s   loc_103E2
; End of function UI_InitScoreTimer
; Triggers transition to next stage phase
Stage_TriggerPhaseTransition:                           ; CODE XREF: Camera_BossPhaseHandler+6   p  ; was: sub_103DC
                                        ; Stage_PostJokerBoss+A   p
                move.w  #$2E,(MessageSequenceState).w   ; '.'
loc_103E2:                                              ; CODE XREF: UI_InitScoreTimer+6   j
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA209).w
                addq.w  #2,(StageTableIndex).w
                jsr     (Stage_StateDispatcher).l
                subq.w  #2,(StageTableIndex).w
                rts
; End of function Stage_TriggerPhaseTransition
