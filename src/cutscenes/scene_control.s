Sys_TransitionToStoryScreen:                            ; DATA XREF: ROM:0001D298   o  ; was: sub_1D3C8
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #$24,(GameModeIndex).w          ; '$'
                clr.w   (GameSubstateIndex).w
locret_1D3D8:                                           ; CODE XREF: Effect_FadeOutPlanet+14   j
                                        ; Sys_WaitForFrameDelay+4   j
                rts
; End of function Sys_TransitionToStoryScreen
; Initializes stage transition
Stage_InitializeTransition:                             ; DATA XREF: ROM:0001CF7A   o  ; was: sub_1D3DA
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                movea.l #stru_1D420,a0
                jsr     (LoadObjData).l
                movea.l #StageTransitionPaletteOffsetLists,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  #$400,d0
                move.w  #0,d1
                jsr     (Data_LoadPointerTable2).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_SetupScrollPlanes
; End of function Stage_InitializeTransition
; ---------------------------------------------------------------------------
stru_1D420:     dc.w    7                               ; field_0
                                        ; DATA XREF: Stage_InitializeTransition+A   o
                dc.l    byte_18140E                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_184590                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_184688                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18454C                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    $FFFF

; Attributes: thunk
; Thunk to Gfx_SetupScrollPlanes
Stage_SetupScrollPlanesThunk:                           ; DATA XREF: ROM:0001CF7C   o  ; was: sub_1D44A
                jmp     Gfx_SetupScrollPlanes
; End of function Stage_SetupScrollPlanesThunk
; Initializes cutscene with data loading
Cutscene_InitializeScene:                               ; DATA XREF: ROM:0001CF7E   o  ; was: sub_1D450
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                clr.b   (word_FFF7F2+1).w
                clr.b   (word_FFF7F4+1).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                movea.l #stru_1D492,a0
                jsr     (LoadObjData).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jsr     (Gfx_DecompressCutsceneData).l
                jmp     Gfx_SetupScrollPlanes
; End of function Cutscene_InitializeScene
; ---------------------------------------------------------------------------
stru_1D492:     dc.w    7                               ; field_0
                                        ; DATA XREF: Cutscene_InitializeScene+1A   o
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $C000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18140E                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Handles input for cutscene scrolling
Cutscene_HandleScrollInput:                             ; DATA XREF: ROM:0001CF80   o  ; was: sub_1D4B4
                btst    #0,(word_FFF706).w
                beq.s   loc_1D4C4
                addi.l  #$1000,(dword_FF9408).w
loc_1D4C4:                                              ; CODE XREF: Cutscene_HandleScrollInput+6   j
                btst    #1,(word_FFF706).w
                beq.s   loc_1D4D4
                subi.l  #$1000,(dword_FF9408).w
loc_1D4D4:                                              ; CODE XREF: Cutscene_HandleScrollInput+16   j
                move.l  (dword_FF9408).w,d0
                cmpi.l  #$20000,d0
                bmi.s   loc_1D4E6
                move.l  #$20000,d0
loc_1D4E6:                                              ; CODE XREF: Cutscene_HandleScrollInput+2A   j
                tst.l   d0
                bpl.s   loc_1D4F0
                move.l  #$20000,d0
loc_1D4F0:                                              ; CODE XREF: Cutscene_HandleScrollInput+34   j
                move.l  d0,(dword_FF9408).w
                asr.l   #8,d0
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  Cutscene_UpdateAndSetupPlanes(pc,d0.w),(dword_FF9400).w
                jmp     Gfx_LoadCutsceneFrame
; End of function Cutscene_HandleScrollInput
; Updates cutscene and scroll planes
Cutscene_UpdateAndSetupPlanes:                          ; DATA XREF: Cutscene_HandleScrollInput+48   r  ; was: sub_1D508
                bsr.w   Cutscene_AnimateScroll
                jmp     Gfx_SetupScrollPlanes
; End of function Cutscene_UpdateAndSetupPlanes
; Animates cutscene scrolling
Cutscene_AnimateScroll:                                 ; CODE XREF: Cutscene_UpdateAndSetupPlanes   p  ; was: sub_1D512
                cmpi.w  #$E00,(dword_FFA900).w
                bmi.s   loc_1D520
                subi.w  #$D00,(dword_FFA900).w
loc_1D520:                                              ; CODE XREF: Cutscene_AnimateScroll+6   j
                addi.l  #$10000,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                asr.w   #2,d0
                move.w  d0,(dword_FFA908).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$180,d0
                move.w  (dword_FFA904).w,d1
                jmp     Gfx_RenderTilemap
; End of function Cutscene_AnimateScroll
; ---------------------------------------------------------------------------
unused_4:       binclude "data/other/unused_4.bin"
word_1D5E0:     dc.w    $316, $100, $B8, $32C, $100, $C4, $326, $100
                                        ; DATA XREF: UI_InitializeGameScreen+2E   o
                dc.w    $D0, $31E, $100, $DC, $330, $100, $E8, $33A
                dc.w    $100, 0, $332, $100, $C, $32C, $100, $18
                dc.w    $31C, $100, $24, $326, $100, $30, $31E, $100
                dc.w    $3C, $8338, $100, $48

; Initializes stage select screen with graphics setup
