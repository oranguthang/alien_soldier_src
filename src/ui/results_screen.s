Results_InitializeDisplay:                              ; CODE XREF: UI_InitializeStageSelect+D8   p  ; was: sub_1DC4C
                bsr.w   Results_RenderAllStats
                rts
; End of function Results_InitializeDisplay
; Updates results screen with score and time display
Results_UpdateAndDisplay:                               ; DATA XREF: ROM:0001D7D2   o  ; was: sub_1DC52
                move.w  #$50,(dword_FFA90C).w           ; 'P'
                addq.w  #1,(word_FFA000).w
                bsr.w   Results_DisplayTime
                bsr.w   Results_DisplayScore
                jsr     (Gfx_SetupScrollPlanes).l
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DCB0
                addq.w  #2,(GameSubstateIndex).w
                jsr     (UI_IncrementScoreCounter).l
                lea     stru_1DCB2(pc),a0
                nop
                jsr     (LoadObjData).l
                movea.l #$FFFF2020,a0
                move.w  #$4000,d0
                moveq   #$F,d7
                jsr     (Gfx_AdjustTileIndices).l
                movea.l #byte_1DCC4,a0
                jsr     (Gfx_LoadCompressedTiles).l
                clr.w   (dword_FFA908).w
locret_1DCB0:                                           ; CODE XREF: Results_UpdateAndDisplay+24   j
                rts
; End of function Results_UpdateAndDisplay
; ---------------------------------------------------------------------------
stru_1DCB2:     dc.w    7                               ; field_0
                                        ; DATA XREF: Results_UpdateAndDisplay+30   o
                dc.l    tiles_1850C6                    ; field_2
                dc.w    $2000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_185268                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF
byte_1DCC4:     dc.b    $69, 0, $20, 0, $F, 0, 1, 2, 3, 4
                                        ; DATA XREF: Results_UpdateAndDisplay+4E   o
                dc.b    5, 6, 7, 8, 9, $A, $B, $C, $D, $E
                dc.b    $F, $10

; Handles results screen completion and button input
Results_HandleCompletion:                               ; DATA XREF: ROM:0001D7D4   o  ; was: sub_1DCDA
                addq.w  #1,(word_FFA000).w
                jsr     (Results_CheckSkipButton).l
                bsr.w   Results_DisplayTime
                bsr.w   Results_DisplayScore
                jsr     (Gfx_SetupScrollPlanes).l
                jsr     (Gfx_FadePaletteTransition).l
                btst    #7,(word_FFF708).w
                beq.s   locret_1DD14
                addq.w  #2,(GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
locret_1DD14:                                           ; CODE XREF: Results_HandleCompletion+24   j
                rts
; End of function Results_HandleCompletion
; Fades out results screen graphics
Gfx_FadeOutResults:                                     ; DATA XREF: ROM:0001D7D6   o  ; was: sub_1DD16
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1DD2C
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (word_FFF7F4+1).w
locret_1DD2C:                                           ; CODE XREF: Gfx_FadeOutResults+C   j
                rts
; End of function Gfx_FadeOutResults
; Initializes results screen
Results_InitializeScreen:                               ; DATA XREF: Sys_DispatchGameState+DA   o  ; was: sub_1DD2E
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1DD8A
                addq.w  #2,(GameSubstateIndex).w
                jsr     (Sys_InitGameMode).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                lea     stru_1DDC2(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                clr.w   (dword_FF84A0).w
                clr.w   (dword_FF8500).w
                clr.w   (dword_FF8560).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
locret_1DD88:                                           ; CODE XREF: Results_InitializeScreen+60   j
                rts
; ---------------------------------------------------------------------------
loc_1DD8A:                                              ; CODE XREF: Results_InitializeScreen+4   j
                tst.w   (word_FFF720).w
                bmi.s   locret_1DD88
                addq.w  #4,(GameModeIndex).w
                move.w  #2,(GameSubstateIndex).w
                lea     (word_B96E).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                bsr.w   Results_RenderAllStats
                move.b  #$12,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp     (Gfx_FadePaletteTransition).l
; End of function Results_InitializeScreen
; ---------------------------------------------------------------------------
stru_1DDC2:     dc.w    7                               ; field_0
                                        ; DATA XREF: Results_InitializeScreen+2E   o
                dc.l    byte_18140E                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Renders all statistics on results screen
Results_RenderAllStats:                                 ; CODE XREF: Results_InitializeDisplay   p  ; was: sub_1DDCC
                                        ; Results_InitializeScreen+78   p
                move.l  (dword_FFA212).w,d0
                cmp.l   (dword_FFFF2C).w,d0
                bmi.s   loc_1DDE0
                move.l  d0,(dword_FFFF2C).w
                move.w  #$FFFF,(word_FFA270).w
loc_1DDE0:                                              ; CODE XREF: Results_RenderAllStats+8   j
                bsr.w   Results_DisplayTime
                bsr.w   Results_DisplayScore
                bsr.w   Results_DisplayContinues
                bsr.w   Results_DisplayBonus
                lea     (byte_47FE).l,a0
                move.w  #$E300,d0
                move.w  #$5120,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4806).l,a0
                move.w  #$8300,d0
                move.w  #$528A,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_468C).l,a0
                move.w  #$A300,d0
                move.w  #$52AA,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4811).l,a0
                move.w  #$8300,d0
                move.w  #$538A,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_468C).l,a0
                move.w  #$A300,d0
                move.w  #$53AA,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4820).l,a0
                move.w  #$8300,d0
                move.w  #$558A,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4687).l,a0
                move.w  #$A300,d0
                move.w  #$55B8,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4832).l,a0
                move.w  #$8300,d0
                move.w  #$568A,d4
                jsr     (UI_RenderTextString).l
                lea     (byte_4687).l,a0
                move.w  #$A300,d0
                move.w  #$56B8,d4
                jmp     (UI_RenderTextString).l
; End of function Results_RenderAllStats
; Display completion time
Results_DisplayTime:                                    ; CODE XREF: Results_UpdateAndDisplay+A   p  ; was: sub_1DEA4
                                        ; Results_HandleCompletion+A   p
                move.l  (dword_FFFF2C).w,d0
                move.w  #$C302,d1
                move.w  #$52AA,d4
                moveq   #8,d7
                cmpi.w  #$FFFF,(word_FFA270).w
                bne.s   loc_1DEC6
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1DEC6
                move.w  #$8302,d1
loc_1DEC6:                                              ; CODE XREF: Results_DisplayTime+14   j
                                        ; Results_DisplayTime+1C   j
                jmp     (Results_UpdateNumbers).l
; End of function Results_DisplayTime
; Display score value
Results_DisplayScore:                                   ; CODE XREF: Results_UpdateAndDisplay+E   p  ; was: sub_1DECC
                                        ; Results_HandleCompletion+E   p
                move.l  (dword_FFA212).w,d0
                move.w  #$C302,d1
                move.w  #$53AA,d4
                moveq   #8,d7
                cmpi.w  #$FFFF,(word_FFA270).w
                bne.s   loc_1DEF2
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1DEF2
                move.w  #$8302,d1
                move.l  (dword_FFFF2C).w,d0
loc_1DEF2:                                              ; CODE XREF: Results_DisplayScore+14   j
                                        ; Results_DisplayScore+1C   j
                jmp     (Results_UpdateNumbers).l
; End of function Results_DisplayScore
; Displays stage bonus value
Results_DisplayStageBonus:
                moveq   #0,d0                           ; was: sub_1DEF8
                move.w  (word_FFFF40).w,d0
                move.w  #$C302,d1
                move.w  #$5538,d4
                moveq   #4,d7
                jmp     (Results_UpdateNumbers).l
; End of function Results_DisplayStageBonus
; Display continues used
Results_DisplayContinues:                               ; CODE XREF: Results_RenderAllStats+1C   p  ; was: sub_1DF0E
                moveq   #0,d0
                move.w  (word_FFFF42).w,d0
                move.w  #$C302,d1
                move.w  #$55B8,d4
                moveq   #4,d7
                jmp     (Results_UpdateNumbers).l
; End of function Results_DisplayContinues
; Display bonus points
Results_DisplayBonus:                                   ; CODE XREF: Results_RenderAllStats+20   p  ; was: sub_1DF24
                moveq   #0,d0
                move.w  (word_FFFF44).w,d0
                move.w  #$C302,d1
                move.w  #$56B8,d4
                moveq   #4,d7
                jmp     (Results_UpdateNumbers).l
; End of function Results_DisplayBonus
; Main loop for results screen
Results_MainLoop:                                       ; DATA XREF: Sys_DispatchGameState+DE   o  ; was: sub_1DF3A
                addq.w  #1,(word_FFA000).w
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1DF52
                jsr     (Results_CheckSkipButton).l
                bsr.w   Results_DisplayTime
                bsr.w   Results_DisplayScore
loc_1DF52:                                              ; CODE XREF: Results_MainLoop+8   j
                jsr     (Gfx_SetupScrollPlanes).l
                jsr     (Gfx_FadePaletteTransition).l
                cmpi.w  #2,(GameSubstateIndex).w
                bne.s   loc_1DF74
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DFB4
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DF74:                                              ; CODE XREF: Results_MainLoop+2A   j
                cmpi.w  #4,(GameSubstateIndex).w
                beq.s   loc_1DFA2
                btst    #7,(word_FFF708).w
                beq.s   locret_1DFB4
                tst.w   (GameSubstateIndex).w
                beq.s   loc_1DF90
                move.w  #4,(GameSubstateIndex).w
loc_1DF90:                                              ; CODE XREF: Results_MainLoop+4E   j
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                rts
; ---------------------------------------------------------------------------
loc_1DFA2:                                              ; CODE XREF: Results_MainLoop+40   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1DFB4
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_1DFB4:                                           ; CODE XREF: Results_MainLoop+32   j
                                        ; Results_MainLoop+48   j
                rts
; End of function Results_MainLoop
; Initializes password entry screen with graphics
