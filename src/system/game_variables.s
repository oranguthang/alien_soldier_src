; Sets the password confirmation flag and continues shared initialization
UI_SetPasswordConfirmFlag:                              ; CODE XREF: UI_HandlePasswordInput+284   j  ; was: sub_1CCEC
                bset    #0,(byte_FFA209).w
                bra.s   UI_InitializeGameVariables_Common
; End of function UI_SetPasswordConfirmFlag
; Initializes game state variables for menu/title screen
UI_InitializeGameVariables:                             ; CODE XREF: UI_HandleTitleInput+8A   p  ; was: sub_1CCF4
                                        ; UI_HandleTitleInput+BA   j
                clr.w   (StageTableIndex).w
                move.w  #2,(ShootingMode).w
                clr.b   (byte_FFA209).w
UI_InitializeGameVariables_Common:                      ; CODE XREF: UI_SetPasswordConfirmFlag+6   j  ; was: loc_1CD02
                move.w  #$200,(word_FFA216).w
                move.w  #$200,(word_FFA218).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                move.w  #3,(word_FFA228).w
                clr.w   (word_FFFF40).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.w   Results_InitializeStageHistory
                bra.s   UI_ResetPaletteAndMessageMode_Clear
; End of function UI_InitializeGameVariables
; Initializes game state after continue, sets weapon ammo and clears menu flags
UI_InitGameStateFromContinue:                           ; CODE XREF: UI_TransitionFromContinue+28   j  ; was: sub_1CD3A
                                        ; UI_UpdatePasswordDisplay+12   j
                move.w  (word_FFA218).w,(word_FFA216).w
                tst.w   (DifficultyMode).w
                beq.s   UI_InitGameStateFromContinue_CopyAmmo
                move.w  #$3E8,d0
                move.w  d0,(word_FFA268).w
                move.w  d0,(word_FFA26A).w
                move.w  d0,(word_FFA26C).w
                move.w  d0,(word_FFA26E).w
UI_InitGameStateFromContinue_CopyAmmo:                  ; CODE XREF: UI_InitGameStateFromContinue+A   j  ; was: loc_1CD5A
                move.w  (word_FFA268).w,(word_FFA260).w
                move.w  (word_FFA26A).w,(word_FFA262).w
                move.w  (word_FFA26C).w,(word_FFA264).w
                move.w  (word_FFA26E).w,(word_FFA266).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (WeaponStateIndex).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.s   UI_ResetPaletteAndMessageMode
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.w  (StageTableIndex).w,d0
                asr.b   #1,d0
                move.b  UI_ContinueDisplayValueTable(pc,d0.w),(dword_FF80C8).w
                rts
; End of function UI_InitGameStateFromContinue
; Clears password input flags and menu state variables
UI_ClearPasswordFlags:                                  ; CODE XREF: Password_HandleInput+12   p  ; was: sub_1CDA8
                clr.w   (word_FF822A).w
                clr.w   (WeaponStateIndex).w
                clr.w   (word_FF8090).w
; End of function UI_ClearPasswordFlags
; Clears both 128-byte palette buffers and resets the message option to 4
UI_ResetPaletteAndMessageMode:                          ; CODE XREF: UI_InitGameStateFromContinue+58   p  ; was: sub_1CDB4
                bsr.w   Stage_LoadTimeLimit
UI_ResetPaletteAndMessageMode_Clear:                    ; CODE XREF: UI_UpdateOptionsScreen+12   j  ; was: loc_1CDB8
                                        ; UI_UpdateSecondaryOptionsMenu+12   j
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7                         ; '?'
; Clears 64 longwords spanning the active and shadow palette buffers
UI_ClearPaletteBuffers:                                 ; CODE XREF: UI_ResetPaletteAndMessageMode+E   j  ; was: loc_1CDC0
                move.l  d0,(a0)+
                dbf     d7,UI_ClearPaletteBuffers
                move.w  #4,(MessageMode).w
                rts
; End of function UI_ResetPaletteAndMessageMode
; ---------------------------------------------------------------------------
UI_ContinueDisplayValueTable:   dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, $18  ; was: byte_1CDCE
                                        ; DATA XREF: UI_InitGameStateFromContinue+66   r
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, 0
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, $18
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18

; Stores the remaining packed-BCD timer at the intermediate phase boundary
Results_StorePhaseSplitTime:                            ; CODE XREF: BattleBanner_StartFightLine+30   p  ; was: sub_1CDF4
                movea.w #(StagePhaseSplitTimes-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (StageTimeRemaining).w,(a0,d0.w)
                rts
; End of function Results_StorePhaseSplitTime
; Stores the remaining packed-BCD timer when the stage result is finalized
Results_StoreStageCompletionTime:                       ; CODE XREF: Results_FinishTimeBonusSpin:Results_StoreTimeBonus   p  ; was: sub_1CE04
                                        ; Boss_ZLeoRunPostDefeatDelay+2E   j
                movea.w #(StageCompletionTimes-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (StageTimeRemaining).w,(a0,d0.w)
                rts
; End of function Results_StoreStageCompletionTime
; Increments the current stage's result-visit count, saturating at 999
Results_IncrementStageVisitCount:                       ; CODE XREF: Results_UpdateAndDisplay+2A   p  ; was: sub_1CE14
                movea.w #(StageResultVisits-M68K_RAM),a0
                adda.w  (StageTableIndex).w,a0
                cmpi.w  #$3E7,(a0)
                bpl.s   Results_IncrementStageVisitCountReturn
                addq.w  #1,(a0)
Results_IncrementStageVisitCountReturn:                 ; CODE XREF: Results_IncrementStageVisitCount+C   j  ; was: locret_1CE24
                rts
; End of function Results_IncrementStageVisitCount
; Initializes the contiguous per-stage results history to missing values
Results_InitializeStageHistory:                         ; CODE XREF: UI_InitializeGameVariables+40   p  ; was: sub_1CE26
                movea.w #(StagePhaseSplitTimes-M68K_RAM),a0
                move.w  #$FFFF,d0
                move.w  #$BF,d7
; Fills the stage-history storage with the missing-value sentinel
Results_InitializeStageHistoryLoop:                     ; CODE XREF: Results_InitializeStageHistory+E   j  ; was: loc_1CE32
                move.w  d0,(a0)+
                dbf     d7,Results_InitializeStageHistoryLoop
                rts
; End of function Results_InitializeStageHistory
; Loads the current stage's packed-BCD time limit into the live timer
Stage_LoadTimeLimit:                                    ; CODE XREF: StageIntro_InitializeBanner+4   p  ; was: sub_1CE3A
                                        ; sub_1CDB4   p
                lea     StageTimeLimitTable(pc),a0
                nop
                move.w  (StageTableIndex).w,d0
                move.w  (a0,d0.w),(StageTimeRemaining).w
                rts
; End of function Stage_LoadTimeLimit
; ---------------------------------------------------------------------------
StageTimeLimitTable:    dc.w    $200, $240, $300, $330, $330  ; was: word_1CE4C
                                        ; DATA XREF: Stage_LoadTimeLimit   o
                                        ; Results_InitializeDataDisplay+4E   o
                dc.w    $210, $220, $300, $340, $300
                dc.w    $320, $410, $200, $200, $240
                dc.w    $340, $300, $400, $220, $950
                dc.w    $200, $200, $410, $220, $555

; Sets up results screen graphics and memory state
