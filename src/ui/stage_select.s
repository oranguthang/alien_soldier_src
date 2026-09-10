UI_InitializeStageSelect:                               ; DATA XREF: Sys_DispatchGameState+82   o  ; was: sub_1D628
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1D69C
                tst.w   (word_FFF720).w
                bpl.s   loc_1D636
                rts
; ---------------------------------------------------------------------------
loc_1D636:                                              ; CODE XREF: UI_InitializeStageSelect+A   j
                jsr     (Sys_InitGameMode).l
                movea.l #stru_1D70A,a0
                jsr     (LoadObjData).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bset    #1,(byte_FFA209).w
                movea.w #(word_FFFF42-M68K_RAM),a0
                movea.w #(word_FF804A-M68K_RAM),a1
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                bcc.s   loc_1D688
                move.w  #$9999,(word_FFFF40).w
loc_1D688:                                              ; CODE XREF: UI_InitializeStageSelect+58   j
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueLargeFontDMACommand81
; ---------------------------------------------------------------------------
loc_1D69C:                                              ; CODE XREF: UI_InitializeStageSelect+4   j
                move.w  #$30,(GameModeIndex).w          ; '0'
                clr.w   (GameSubstateIndex).w
                lea     (StageSelectFullPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                jsr     (Gfx_FadePaletteTransition).l
                clr.w   (word_FF8014).w
                move.w  #$FFF2,(word_FF8016).w
                bsr.w   UI_FadePaletteColors
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FF00,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                move.w  #$FF00,(dword_FFA90C).w
                move.w  #$10,(dword_FFA908).w
                move.b  #4,(byte_FFA95B).w
                jsr     (Gfx_SetupScrollPlanes).l
; Resets stage select variables and frame counter
UI_ResetStageSelectVars:                                ; CODE XREF: Stage_InitializeStageSelect+86   j  ; was: loc_1D6F4
                move.b  #3,(word_FFF7E6+1).w
                move.b  #0,(word_FFF7F4+1).w
                bsr.w   Results_InitializeDisplay
                clr.w   (word_FFA000).w
                rts
; End of function UI_InitializeStageSelect
; ---------------------------------------------------------------------------
stru_1D70A:     dc.w    3                               ; field_0
                                        ; DATA XREF: UI_InitializeStageSelect+14   o
                                        ; Stage_InitializeStageSelect+C   o
                dc.l    byte_18C72C                     ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CC50                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18CD7C                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18454C                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Initializes stage select screen
Stage_InitializeStageSelect:                            ; DATA XREF: Sys_DispatchGameState+AA   o  ; was: sub_1D734
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1D778
                jsr     (Sys_InitGameMode).l
                movea.l #stru_1D70A,a0
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueSmallFontDMA
; ---------------------------------------------------------------------------
loc_1D778:                                              ; CODE XREF: Stage_InitializeStageSelect+4   j
                move.w  #$30,(GameModeIndex).w          ; '0'
                move.w  #6,(GameSubstateIndex).w
                lea     (StageSelectFullPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                jsr     (Gfx_FadePaletteTransition).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FF00,(dword_FFA90C).w
                move.w  #0,(dword_FFA908).w
                jsr     (Gfx_SetupScrollPlanes).l
                move.w  #2,(dword_FF8066+2).w
                bra.w   UI_ResetStageSelectVars
; End of function Stage_InitializeStageSelect
; Dispatches stage select state handler
UI_DispatchStageState:                                  ; DATA XREF: Sys_DispatchGameState+86   o  ; was: sub_1D7BE
                move.w  (GameSubstateIndex).w,d0
                movea.w off_1D7CE(pc,d0.w),a0
                adda.l  #UI_UpdateStageScroll,a0
                jmp     (a0)
; End of function UI_DispatchStageState
; ---------------------------------------------------------------------------
off_1D7CE:      dc.w    UI_UpdateStageScroll-UI_UpdateStageScroll
                                        ; DATA XREF: UI_DispatchStageState+4   r
                dc.w    UI_HandleStageFadeOut-UI_UpdateStageScroll
                dc.w    Results_UpdateAndDisplay-UI_UpdateStageScroll
                dc.w    Results_HandleCompletion-UI_UpdateStageScroll
                dc.w    Gfx_FadeOutResults-UI_UpdateStageScroll
                dc.w    UI_InitializeContinueScreen-UI_UpdateStageScroll
                dc.w    UI_UpdateContinueDisplay-UI_UpdateStageScroll
                dc.w    UI_HandleContinueInput-UI_UpdateStageScroll
                dc.w    UI_TransitionFromContinue-UI_UpdateStageScroll
                dc.w    UI_HandleGameOverTransition-UI_UpdateStageScroll

; Updates stage select scroll position and checks input
UI_UpdateStageScroll:                                   ; DATA XREF: UI_DispatchStageState+8   o  ; was: sub_1D7E2
                                        ; ROM:off_1D7CE   o
                addq.w  #1,(word_FFA000).w
                cmpi.w  #$20,(word_FFA000).w            ; ' '
                beq.s   loc_1D7F6
                cmpi.w  #$24,(word_FFA000).w            ; '$'
                bne.s   loc_1D800
loc_1D7F6:                                              ; CODE XREF: UI_UpdateStageScroll+A   j
                move.b  #$1D,d0
                jsr     (Input_ProcessButtons).l
loc_1D800:                                              ; CODE XREF: UI_UpdateStageScroll+12   j
                cmpi.w  #$3C0,(dword_FFA900).w
                bmi.s   loc_1D86A
                addq.w  #2,(GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                bra.s   loc_1D86A
; End of function UI_UpdateStageScroll
; Handles fade out effect for stage transition
UI_HandleStageFadeOut:                                  ; DATA XREF: ROM:0001D7D0   o  ; was: sub_1D81E
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1D86A
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (word_FFF7E6+1).w
                move.b  #$12,(word_FFF7F4+1).w
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jmp     VDP_SetupDMA
; ---------------------------------------------------------------------------
loc_1D86A:                                              ; CODE XREF: UI_UpdateStageScroll+24   j
                                        ; UI_UpdateStageScroll+3A   j
                jsr     (Gfx_FadePaletteTransition).l
                jsr     (Gfx_SetupScrollPlanes).l
                move.l  #$FFFF0000,d0
                bsr.w   Gfx_CalculateParallaxScroll
                addq.w  #8,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$1C0,d0
                move.w  (dword_FFA904).w,d1
                jsr     (Gfx_RenderTilemap).l
                addq.w  #4,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$1C0,d0
                move.w  (dword_FFA904).w,d1
                jmp     Gfx_RenderTilemap
; End of function UI_HandleStageFadeOut
; Calculates parallax scrolling for background
Gfx_CalculateParallaxScroll:                            ; CODE XREF: UI_HandleStageFadeOut+5E   p  ; was: sub_1D8AC
                movea.w #(word_FFE400-M68K_RAM),a0
                move.l  (dword_FFA900).w,d1
                neg.l   d1
                move.w  #$6F,d7                         ; 'o'
                move.l  d1,d2
                addi.l  #0,d2
                btst    #0,(word_FFA280+1).w
                bne.s   loc_1D8CC
                exg     d1,d2
loc_1D8CC:                                              ; CODE XREF: Gfx_CalculateParallaxScroll+1C   j
                swap    d1
                swap    d2
loc_1D8D0:                                              ; CODE XREF: Gfx_CalculateParallaxScroll+38   j
                move.w  d1,(a0)
                addq.w  #4,a0
                swap    d1
                add.l   d0,d1
                swap    d1
                move.w  d2,(a0)
                addq.w  #4,a0
                swap    d2
                add.l   d0,d2
                swap    d2
                dbf     d7,loc_1D8D0
                rts
; End of function Gfx_CalculateParallaxScroll
; Fades multiple palette color ranges
UI_FadePaletteColors:                                   ; CODE XREF: UI_InitializeStageSelect+9A   p  ; was: sub_1D8EA
                movea.w #(word_FFE386-M68K_RAM),a1
                movea.w #(word_FFE306-M68K_RAM),a2
                moveq   #3,d5
loc_1D8F4:                                              ; CODE XREF: UI_FadePaletteColors+20   j
                move.w  (a1)+,d6
                move.w  (word_FF8014).w,d0
                jsr     (Gfx_PrepareRGBComponents).l
                moveq   #$FFFFFFFF,d0
                jsr     (Gfx_AdjustSelectedColorChannels).l
                move.w  d6,(a2)+
                dbf     d5,loc_1D8F4
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                movea.w #(byte_FFE322-M68K_RAM),a2
                moveq   #4,d5
                bsr.s   UI_FadePaletteRange
                movea.w #(dword_FFE3C2-M68K_RAM),a1
                movea.w #(word_FFE342-M68K_RAM),a2
                moveq   #4,d5
                bsr.s   UI_FadePaletteRange
                movea.w #(word_FFE3E2-M68K_RAM),a1
                movea.w #(word_FFE362-M68K_RAM),a2
                moveq   #4,d5
; End of function UI_FadePaletteColors
; Fades single palette color range
UI_FadePaletteRange:                                    ; CODE XREF: UI_FadePaletteColors+2E   p  ; was: sub_1D930
                                        ; UI_FadePaletteColors+3A   p
                move.w  (a1)+,d6
                move.w  (word_FF8016).w,d0
                jsr     (Gfx_PrepareRGBComponents).l
                moveq   #$FFFFFFFF,d0
                jsr     (Gfx_AdjustSelectedColorChannels).l
                move.w  d6,(a2)+
                dbf     d5,UI_FadePaletteRange
                rts
; End of function UI_FadePaletteRange
; Updates results display
