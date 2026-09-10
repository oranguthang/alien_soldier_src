UI_InitializePasswordScreen:                            ; DATA XREF: Sys_DispatchGameState+92   o  ; was: sub_1DFB6
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr     (Sys_InitGameMode).l
                jsr     (Gfx_QueueSmallFontDMACommand83).l
                jsr     (Stage_DispatchObjectLoader).l
                movea.l #stru_1E012,a0
                jsr     (LoadObjData).l
                addq.w  #4,(GameModeIndex).w
                move.w  #$40,(GameSubstateIndex).w      ; '@'
                jsr     (Gfx_QueueSmallFontDMACommand83).l
                lea     (PasswordEntryPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp     Sound_QueueStageBGMOrStop
; End of function UI_InitializePasswordScreen
; ---------------------------------------------------------------------------
stru_1E012:     dc.w    3                               ; field_0
                                        ; DATA XREF: UI_InitializePasswordScreen+1C   o
                                        ; Password_HandleInput+18   o
                dc.l    byte_18DA38                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F276E                     ; field_2
                dc.w    $DE00                           ; field_6
                dc.w    $FFFF

; Updates password display with blinking cursor
UI_UpdatePasswordDisplay:                               ; DATA XREF: Sys_DispatchGameState+96   o  ; was: sub_1E024
                move.w  (GameSubstateIndex).w,d0
                subq.w  #1,d0
                bpl.s   loc_1E03C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     UI_InitGameStateFromContinue
; ---------------------------------------------------------------------------
loc_1E03C:                                              ; CODE XREF: UI_UpdatePasswordDisplay+6   j
                move.w  d0,(GameSubstateIndex).w
                andi.w  #8,d0
                bne.s   loc_1E05A
                movea.l #byte_4660,a0
                move.w  #$C6A0,d0
                move.w  #$46A0,d4
                jmp     (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_1E05A:                                              ; CODE XREF: UI_UpdatePasswordDisplay+20   j
                movea.l #byte_4671,a0
                move.w  #$C6A0,d0
                move.w  #$46A0,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_UpdatePasswordDisplay
; Initializes password screen
Password_InitializeScreen:                              ; DATA XREF: Sys_DispatchGameState+AE   o  ; was: sub_1E06E
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1E0C4
                addq.w  #2,(GameSubstateIndex).w
                jsr     (Sys_InitGameMode).l
                jsr     (Stage_DispatchObjectLoader).l
                jsr     (Sys_ClearEntityObjectPool).l
                lea     (StageSelectFullPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #0,(word_FFF7F4+1).w
                jmp     Gfx_QueueLargeFontDMACommand81
; ---------------------------------------------------------------------------
loc_1E0C4:                                              ; CODE XREF: Password_InitializeScreen+4   j
                addq.w  #4,(GameModeIndex).w
                jsr     (Gfx_FadePaletteTransition).l
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                jsr     (Gfx_SetupScrollPlanes).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                lea     (byte_47D1).l,a0
                move.w  #$C300,d0
                move.w  #$4198,d4
                jsr     (UI_RenderTextStringWrapped).l
                lea     (byte_47E6).l,a0
                move.w  #$C300,d0
                move.w  #$448A,d4
                jsr     (UI_RenderTextStringWrapped).l
                lea     (byte_47F2).l,a0
                move.w  #$C300,d0
                move.w  #$4A9C,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function Password_InitializeScreen
; Handles password screen input
Password_HandleInput:                                   ; DATA XREF: Sys_DispatchGameState+B2   o  ; was: sub_1E124
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1E14C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jsr     (UI_ClearPasswordFlags).l
                lea     stru_1E012(pc),a0
                jsr     (LoadObjData).l
                jmp     Sound_QueueStageBGMOrStop
; ---------------------------------------------------------------------------
loc_1E14C:                                              ; CODE XREF: Password_HandleInput+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_1E164
                btst    #7,(word_FFF708).w
                beq.s   loc_1E164
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_1E164:                                              ; CODE XREF: Password_HandleInput+2C   j
                                        ; Password_HandleInput+34   j
                jsr     (Gfx_FadePaletteTransition).l
                rts
; End of function Password_HandleInput
; Initializes credits screen
