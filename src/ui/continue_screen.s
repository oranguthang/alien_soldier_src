UI_UpdateResultsDisplay:                                ; CODE XREF: UI_TransitionFromContinue   p  ; was: sub_1D94C
                btst    #1,(word_FFA280+1).w
                bne.s   Results_UpdateTimeDisplay
                move.w  #$2302,d1
                bra.s   loc_1D95E
; End of function UI_UpdateResultsDisplay
; Updates time display on results screen
Results_UpdateTimeDisplay:                              ; CODE XREF: UI_UpdateResultsDisplay+6   j  ; was: sub_1D95A
                                        ; UI_UpdateContinueDisplay+C   p
                move.w  #$4302,d1
loc_1D95E:                                              ; CODE XREF: UI_UpdateResultsDisplay+C   j
                tst.w   (DifficultyMode).w
                bne.s   loc_1D966
                rts
; ---------------------------------------------------------------------------
loc_1D966:                                              ; CODE XREF: Results_UpdateTimeDisplay+8   j
                moveq   #0,d0
                move.w  (word_FFA228).w,d0
                move.w  #$6B42,d4
                moveq   #2,d7
                jmp     (Results_UpdateNumbers).l
; End of function Results_UpdateTimeDisplay
; Renders text headers for results screen
UI_RenderResultsHeaders:                                ; CODE XREF: UI_InitializeContinueScreen+90   j  ; was: sub_1D978
                lea     (byte_47B2).l,a0
                move.w  #$2300,d0
                move.w  #$6B34,d4
                jsr     (UI_RenderTextStringWrapped).l
                lea     (byte_4689).l,a0
                move.w  #$300,d0
                move.w  #$6B42,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderResultsHeaders
; Renders continue prompt text on screen
UI_RenderContinuePrompt:                                ; CODE XREF: UI_InitializeContinueScreen+4C   p  ; was: sub_1D9A0
                move.w  #$6300,d0
                movea.l #byte_4790,a0
                move.w  #$669E,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderContinuePrompt
; Displays current stage number on results
Results_DisplayStageNumber:                             ; CODE XREF: UI_HandleContinueInput+4   p  ; was: sub_1D9B4
                moveq   #0,d0
                move.w  (dword_FF8066+2).w,d0
                move.w  #$4302,d1
                move.w  #$66B0,d4
                moveq   #1,d7
                jsr     (Results_UpdateNumbers).l
; End of function Results_DisplayStageNumber
; Renders score values and labels on results
Results_RenderScoreValues:                              ; CODE XREF: UI_InitializeContinueScreen+50   p  ; was: sub_1D9CA
                lea     (byte_47A1).l,a0
                move.w  #$2300,d0
                move.w  #$6B06,d4
                jsr     (UI_RenderTextStringWrapped).l
                moveq   #0,d0
                move.w  (StageTableIndex).w,d0
                addq.w  #2,d0
                jsr     (Math_LookupPackedBCDWord).l
                move.w  #$4302,d1
                move.w  #$6B12,d4
                moveq   #2,d7
                jsr     (Results_UpdateNumbers).l
                lea     (byte_4689).l,a0
                move.w  #$300,d0
                move.w  #$6B12,d4
                jsr     (UI_RenderTextStringWrapped).l
                lea     (byte_47BA).l,a0
                move.w  #$2300,d0
                move.w  #$6B1A,d4
                jsr     (UI_RenderTextStringWrapped).l
                lea     (byte_47C1).l,a0
                tst.w   (DifficultyMode).w
                beq.s   loc_1DA36
                lea     (byte_47C6).l,a0
loc_1DA36:                                              ; CODE XREF: Results_RenderScoreValues+64   j
                move.w  #$4300,d0
                move.w  #$6B26,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function Results_RenderScoreValues
; Renders continue text with stage name
UI_RenderContinueText:                                  ; CODE XREF: UI_InitializeContinueScreen:loc_1DB24   j  ; was: sub_1DA44
                lea     (byte_47A8).l,a0
                move.w  #$2300,d0
                move.w  #$6B32,d4
                jsr     (UI_RenderTextStringWrapped).l
                move.w  (StageTableIndex).w,d0
                asl.w   #2,d0
                addi.l  #word_A82A,d0
                moveq   #0,d1
                move.w  (DifficultyMode).w,d1
                asl.w   #1,d1
                add.l   d1,d0
                movea.l d0,a0
                movea.w #(byte_FF9980-M68K_RAM),a1
                move.l  (a0),(a1)+
                move.l  (a0),(dword_FFFF3A).w
                move.b  #$FF,(a1)
                movea.w #(byte_FF9980-M68K_RAM),a0
                move.w  #$4300,d0
                move.w  #$6B44,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderContinueText
; Initializes continue screen with palettes and graphics
UI_InitializeContinueScreen:                            ; DATA XREF: ROM:0001D7D8   o  ; was: sub_1DA90
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                clr.l   (dword_FFA900).w
                clr.l   (dword_FFA904).w
                clr.l   (dword_FFA908).w
                clr.l   (dword_FFA90C).w
                tst.w   (word_FFA228).w
                bne.s   loc_1DABC
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DABC:                                              ; CODE XREF: UI_InitializeContinueScreen+1E   j
                addq.w  #2,(GameSubstateIndex).w
                move.l  #$A0000,(dword_FF8066+2).w
                subi.l  #$200,(dword_FF8066+2).w
                lea     (ContinueScreenPaletteOffsetLists).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                bsr.w   UI_RenderContinuePrompt
                bsr.w   Results_RenderScoreValues
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                tst.w   (DifficultyMode).w
                beq.s   loc_1DB24
                bra.w   UI_RenderResultsHeaders
; ---------------------------------------------------------------------------
loc_1DB24:                                              ; CODE XREF: UI_InitializeContinueScreen+8E   j
                bra.w   UI_RenderContinueText
; End of function UI_InitializeContinueScreen
; Updates continue screen display with fade effects
UI_UpdateContinueDisplay:                               ; DATA XREF: ROM:0001D7DA   o  ; was: sub_1DB28
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                bsr.w   Results_UpdateTimeDisplay
                jsr     (Gfx_SetupScrollPlanes).l
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DB5A
                addq.w  #2,(GameSubstateIndex).w
                move.b  #$94,d0
                jsr     (Sound_QueueBGMRequest).l
locret_1DB5A:                                           ; CODE XREF: UI_UpdateContinueDisplay+22   j
                rts
; End of function UI_UpdateContinueDisplay
; Handles player input on continue screen
UI_HandleContinueInput:                                 ; DATA XREF: ROM:0001D7DC   o  ; was: sub_1DB5C
                bsr.w   Results_UpdateTimeDisplay
                bsr.w   Results_DisplayStageNumber
                move.b  (word_FFF708).w,d0
                andi.b  #$70,d0                         ; 'p'
                beq.s   loc_1DB80
                move.b  #$A2,d0
                jsr     (Sound_QueueRequest).l
                subq.w  #1,(dword_FF8066+2).w
                bmi.s   loc_1DB8E
                bra.s   loc_1DBC0
; ---------------------------------------------------------------------------
loc_1DB80:                                              ; CODE XREF: UI_HandleContinueInput+10   j
                move.w  (dword_FF8066+2).w,d0
                subi.l  #$200,(dword_FF8066+2).w
                bpl.s   loc_1DBB0
loc_1DB8E:                                              ; CODE XREF: UI_HandleContinueInput+20   j
                addq.w  #4,(GameSubstateIndex).w
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                bra.w   loc_1DBFA
; ---------------------------------------------------------------------------
loc_1DBB0:                                              ; CODE XREF: UI_HandleContinueInput+30   j
                cmp.w   (dword_FF8066+2).w,d0
                beq.s   loc_1DBC0
                move.b  #$A2,d0
                jsr     (Sound_QueueRequest).l
loc_1DBC0:                                              ; CODE XREF: UI_HandleContinueInput+22   j
                                        ; UI_HandleContinueInput+58   j
                btst    #7,(word_FFF708).w
                beq.s   loc_1DBFA
                addq.w  #2,(GameSubstateIndex).w
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                tst.w   (DifficultyMode).w
                beq.s   loc_1DBFA
                sub.w   d0,d0
                move.b  (word_FFA228+1).w,d0
                moveq   #1,d1
                sbcd    d1,d0
                move.b  d0,(word_FFA228+1).w
loc_1DBFA:                                              ; CODE XREF: UI_HandleContinueInput+50   j
                                        ; UI_HandleContinueInput+6A   j
                jsr     (Gfx_FadePaletteTransition).l
                jmp     Gfx_SetupScrollPlanes
; End of function UI_HandleContinueInput
; Transitions away from continue screen based on choice
UI_TransitionFromContinue:                              ; DATA XREF: ROM:0001D7DE   o  ; was: sub_1DC06
                bsr.w   UI_UpdateResultsDisplay
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1DBFA
                tst.w   (DifficultyMode).w
                beq.s   loc_1DC24
                move.w  #$3C,(GameModeIndex).w          ; '<'
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DC24:                                              ; CODE XREF: UI_TransitionFromContinue+10   j
                move.w  #$70,(GameModeIndex).w          ; 'p'
                clr.w   (GameSubstateIndex).w
                jmp     UI_InitGameStateFromContinue
; End of function UI_TransitionFromContinue
; Handles game over screen fade transition
UI_HandleGameOverTransition:                            ; DATA XREF: ROM:0001D7E0   o  ; was: sub_1DC34
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1DBFA
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function UI_HandleGameOverTransition
; Initializes results display by calling render functions
