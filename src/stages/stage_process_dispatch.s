; Unreferenced helper that clears the high word of shared stage scratch $FFFFA960
UnreferencedClearStageScratchWord:
                clr.w   (dword_FFA960).w                ; was: sub_FF10
                rts
; End of function UnreferencedClearStageScratchWord
; Dispatches the selected stage process while gameplay updates are active
Stage_DispatchSelectedProcess:                          ; CODE XREF: Stage_UpdateGameplayEntry:Stage_EnterSelectedGameplayProcess   j  ; was: sub_FF16
                                        ; XiTigerStage_UpdateGameplayEntry+110   j
                tst.b   (byte_FF813E).w
                bpl.s   Stage_RunSelectedProcess
                rts
; ---------------------------------------------------------------------------
Stage_RunSelectedProcess:                               ; CODE XREF: Stage_DispatchSelectedProcess+4   j  ; was: loc_FF1E
                jsr     Scroll_PreparePlaneBuffersAndRegisterShadows(pc)  ; (pc)
                nop
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FFA950).w,d0
                move.w  (word_FFA206).w,d1
                movea.l Stage_ProcessHandlerTable(pc,d1.w),a0
                jmp     (a0)
; End of function Stage_DispatchSelectedProcess
; ---------------------------------------------------------------------------
Stage_ProcessHandlerTable:  dc.l    Stage_DispatchEarlyStageState  ; was: off_FF36
                dc.l    Stage_DispatchMidgameState
                dc.l    Stage_DispatchLateGameState
                dc.l    Stage_DispatchTransitionState
                dc.l    Stage_DispatchEarlyStageState

; Transitions stage to next phase or section
Stage_TransitionToNextPhase:                            ; CODE XREF: Stage_UpdateLogic+14   j  ; was: sub_FF4A
                                        ; Camera_AutoScrollCheck+10   j
                addq.w  #2,(word_FFA950).w
                move.w  #$56,(MessageSequenceState).w   ; 'V'
; Initializes shared boss health and combat-counter values for the next phase
Stage_InitializeBossHealthAndCounter:                   ; CODE XREF: Stage9_InitializeXiTigerEncounter   p  ; was: loc_FF54
                move.w  (StageTableIndex).w,d0
                lea     Stage_BossHealthDefaults(pc),a0
                nop
                lea     Stage_BossCombatCounterDefaults(pc),a1
                nop
                move.w  (a0,d0.w),(BossMaxHealth).w
                move.w  (a0,d0.w),(BossHealth).w
                move.w  (a1,d0.w),(word_FF8236).w
                move.w  (a1,d0.w),(word_FF8234).w
                rts
; End of function Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage_BossHealthDefaults:   dc.w    $7000, $7000        ; DATA XREF: Stage_TransitionToNextPhase+E   o  ; was: word_FF7E
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
                dc.w    $7000, $7000
Stage_BossCombatCounterDefaults:    dc.w    $1E0, $1E0  ; DATA XREF: Stage_TransitionToNextPhase+14   o  ; was: word_FFD2
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, 0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
                dc.w    $1E0, $1E0
