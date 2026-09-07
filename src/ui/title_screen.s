UI_InitTitleScreen:                               ; DATA XREF: Sys_DispatchGameState+6A   o  ; was: sub_9322
                tst.w   (GameSubstateIndex).w
                bne.s   loc_936C
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                lea     stru_A1B6(pc),a0
                nop
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_936C:                               ; CODE XREF: UI_InitTitleScreen+4   j
                move.w  #$18,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                movea.l #$FFFF4020,a0
                move.w  #$C180,d0
                moveq   #$26,d7 ; '&'
                jsr (Gfx_AdjustTileIndices).l
                movea.l #$FFFF2020,a0
                move.w  #$6000,d0
                move.w  #$FF00,d1
                move.w  #$BF,d7
                jsr (Gfx_UpdateTilemapIndices).l
                lea     (dword_11316).l,a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  d0,(dword_FFA900).w
                move.w  d1,(dword_FFA904).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                move.b  #0,(word_FFF7F4+1).w
                move.w  #2,(dword_FF8066+2).w
                move.b  #$91,d0
                jsr (Input_ProcessButtons).l
                jsr (Gfx_SetupScrollPlanes).l
                lea     (byte_46B4).l,a0
                move.w  #$A300,d0
                move.w  #$4086,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_46D9).l,a0
                move.w  #$A300,d0
                move.w  #$4202,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4701).l,a0
                move.w  #$8300,d0
                move.w  #$4892,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4718).l,a0
                move.w  #$A300,d0
                move.w  #$4C0C,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp (Gfx_FadePaletteTransition).l
; End of function UI_InitTitleScreen
; ---------------------------------------------------------------------------
unused_1:	binclude	"data/other/unused_1.bin"


; Handles title screen navigation and button input for menu selection
UI_HandleTitleInput:                               ; DATA XREF: Sys_DispatchGameState+6E   o  ; was: sub_9478
                tst.w   (word_FF80F0).w
                bne.w   loc_9538
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   loc_9494
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
loc_9494:                               ; CODE XREF: UI_HandleTitleInput+10   j
                move.w  (dword_FF8066+2).w,d0
                btst    #2,(word_FFF708).w
                beq.s   loc_94A6
                subq.w  #2,d0
                bpl.s   loc_94B8
                moveq   #0,d0
loc_94A6:                               ; CODE XREF: UI_HandleTitleInput+26   j
                btst    #3,(word_FFF708).w
                beq.s   loc_94B8
                addq.w  #2,d0
                cmpi.w  #6,d0
                bmi.s   loc_94B8
                moveq   #4,d0
loc_94B8:                               ; CODE XREF: UI_HandleTitleInput+2A   j
                                        ; UI_HandleTitleInput+34   j ...
                andi.w  #6,d0
                move.w  d0,(dword_FF8066+2).w
                cmpi.w  #$780,(word_FFA000).w
                cmpi.w  #$700,(word_FFA000).w
                bne.s   loc_94DA
                move.w  #1,(word_FFFF5A).w
                clr.w   (word_FFFF5C).w
                rts
; ---------------------------------------------------------------------------
loc_94DA:                               ; CODE XREF: UI_HandleTitleInput+54   j
                btst    #7,(word_FFF708).w
                beq.s   loc_9538
                move.b  #2,(byte_FF830E).w
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                clr.w   (GameSubstateIndex).w
                tst.w   (word_FFFF5A).w
                beq.s   loc_9510
                move.w  #$70,(GameModeIndex).w ; 'p'
                jsr (UI_InitializeGameVariables).l
                move.w  (word_FFFF64).w,(StageTableIndex).w
                rts
; ---------------------------------------------------------------------------
loc_9510:                               ; CODE XREF: UI_HandleTitleInput+82   j
                move.w  (dword_FF8066+2).w,d0
                beq.s   loc_9524
                beq.s   loc_9538
                subq.w  #2,d0
                beq.s   loc_952C
                move.w  #$1C,(GameModeIndex).w
                rts
; ---------------------------------------------------------------------------
loc_9524:                               ; CODE XREF: UI_HandleTitleInput+9C   j
                move.w  #$44,(GameModeIndex).w ; 'D'
                rts
; ---------------------------------------------------------------------------
loc_952C:                               ; CODE XREF: UI_HandleTitleInput+A2   j
                move.w  #$70,(GameModeIndex).w ; 'p'
                jmp UI_InitializeGameVariables
; ---------------------------------------------------------------------------
loc_9538:                               ; CODE XREF: UI_HandleTitleInput+4   j
                                        ; UI_HandleTitleInput+68   j ...
                addq.w  #1,(word_FFA000).w
                cmpi.w  #$200,(word_FFA000).w
                bne.s   loc_954E
                move.b  #$10,d0
                jsr (Input_ProcessButtons).l
loc_954E:                               ; CODE XREF: UI_HandleTitleInput+CA   j
                move.w  #$A300,d0
                cmpi.w  #2,(dword_FF8066+2).w
                beq.s   loc_955E
                move.w  #$C300,d0
loc_955E:                               ; CODE XREF: UI_HandleTitleInput+E0   j
                bsr.w UI_RenderTitleOption1
                move.w  #$A300,d0
                cmpi.w  #4,(dword_FF8066+2).w
                beq.s   loc_9572
                move.w  #$C300,d0
loc_9572:                               ; CODE XREF: UI_HandleTitleInput+F4   j
                bsr.w UI_RenderTitleOption2
                move.w  #$A300,d0
                tst.w   (dword_FF8066+2).w
                beq.s   loc_9584
                move.w  #$C300,d0
loc_9584:                               ; CODE XREF: UI_HandleTitleInput+106   j
                bsr.w UI_RenderTitleOption3
                jsr Gfx_UpdateMenuPalette(pc)    ; (pc)
                nop
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_HandleTitleInput
; Renders first menu option text on title screen
UI_RenderTitleOption1:                               ; CODE XREF: UI_HandleTitleInput:loc_955E   p  ; was: sub_959A
                movea.l #byte_4698,a0
                move.w  #$4A9E,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption1
; Renders second menu option text on title screen
UI_RenderTitleOption2:                               ; CODE XREF: UI_HandleTitleInput:loc_9572   p  ; was: sub_95AA
                movea.l #byte_46A3,a0
                move.w  #$4ABA,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption2
; Renders third menu option text on title screen
UI_RenderTitleOption3:                               ; CODE XREF: UI_HandleTitleInput:loc_9584   p  ; was: sub_95BA
                movea.l #byte_46AB,a0
                move.w  #$4A86,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleOption3
; Initializes options screen with objects and text elements
