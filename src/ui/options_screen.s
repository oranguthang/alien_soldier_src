UI_InitOptionsScreen:                               ; DATA XREF: Sys_DispatchGameState+72   o  ; was: sub_95CA
                tst.w   (GameSubstateIndex).w
                bne.s   loc_9612
                jsr (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_9612:                               ; CODE XREF: UI_InitOptionsScreen+4   j
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_9728
                addq.w  #2,(GameSubstateIndex).w
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (word_B948).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                jsr (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.b   (dword_FF805E+3).w
                clr.b   (dword_FF8066).w
                clr.b   (dword_FF806A+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                lea     (byte_46A3).l,a0
                move.w  #$8300,d0
                move.w  #$4122,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4734).l,a0
                move.w  #$8300,d0
                move.w  #$4290,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4749).l,a0
                move.w  #$8300,d0
                move.w  #$4490,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4754).l,a0
                move.w  #$8300,d0
                move.w  #$4590,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_475F).l,a0
                move.w  #$8300,d0
                move.w  #$4710,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4768).l,a0
                move.w  #$8300,d0
                move.w  #$4810,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4771).l,a0
                move.w  #$8300,d0
                move.w  #$4910,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_477C).l,a0
                move.w  #$A300,d0
                move.w  #$4B14,d4
                jmp (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_9728:                               ; CODE XREF: UI_InitOptionsScreen+4E   j
                move.w  #$20,(GameModeIndex).w ; ' '
                clr.w   (GameSubstateIndex).w
                move.w  #$118,d0
                move.w  #$B3,d1
                move.l  #word_A36A,d2
                jsr (UI_InitCursorSprite).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
                clr.b   d5
                bsr.w UI_OptionsRenderRow1
                clr.b   d5
                bsr.w UI_OptionsRenderRow2
                clr.b   d5
                bsr.w UI_OptionsRenderRow3
                clr.b   d5
                bsr.w UI_OptionsUpdateButtons
                clr.b   d5
                bsr.w UI_OptionsSelectCharacter
                clr.b   d5
                bsr.w UI_OptionsSelectCharacter2
                rts
; End of function UI_InitOptionsScreen
; Updates options screen with input handling and object processing
UI_UpdateOptionsScreen:                               ; DATA XREF: Sys_DispatchGameState+76   o  ; was: sub_9774
                bclr    #1,(word_FF80F4).w
                beq.s   loc_978C
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; ---------------------------------------------------------------------------
loc_978C:                               ; CODE XREF: UI_UpdateOptionsScreen+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_97B4
                btst    #7,(word_FFF708).w
                beq.s   loc_97B4
                move.b  #2,(byte_FF830E).w
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_97B4:                               ; CODE XREF: UI_UpdateOptionsScreen+1C   j
                                        ; UI_UpdateOptionsScreen+24   j
                jsr Gfx_UpdateMenuPalette(pc)    ; (pc)
                nop
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w UI_HandleOptionsInput
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_UpdateOptionsScreen
; Processes directional input and button presses in options menu
UI_HandleOptionsInput:                               ; CODE XREF: UI_UpdateOptionsScreen+5E   p  ; was: sub_97EE
                bsr.w Gfx_UpdateCursorFlash
                btst    #0,(dword_FF805E+2).w
                bne.w UI_AnimateCursorToTarget
                btst    #0,(word_FFF708).w
                beq.s   loc_982C
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                subq.w  #2,(dword_FF8062).w
                bpl.s   loc_982C
                move.w  #$A,(dword_FF8062).w
loc_982C:                               ; CODE XREF: UI_HandleOptionsInput+14   j
                                        ; UI_HandleOptionsInput+36   j
                btst    #1,(word_FFF708).w
                beq.w   loc_9864
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                addq.w  #2,(dword_FF8062).w
                cmpi.w  #$C,(dword_FF8062).w
                bmi.s   locret_9862
                clr.w   (dword_FF8062).w
locret_9862:                            ; CODE XREF: UI_HandleOptionsInput+6E   j
                rts
; ---------------------------------------------------------------------------
loc_9864:                               ; CODE XREF: UI_HandleOptionsInput+44   j
                move.b  (word_FFF708).w,(dword_FF806A).w
                move.b  (word_FFF706).w,(dword_FF806A+1).w
                move.b  (word_FFF708).w,d5
                btst    #4,d5
                beq.s   loc_988A
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.b  #4,d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_988A:                               ; CODE XREF: UI_HandleOptionsInput+8A   j
                andi.b  #$60,d5 ; '`'
loc_988E:                               ; CODE XREF: UI_HandleOptionsNavigation+8A   j
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   loc_98A2
                move.b  #$AD,d0
                jsr (Input_ProcessButtons).l
loc_98A2:                               ; CODE XREF: UI_HandleOptionsInput+A8   j
                btst    #2,(word_FFF706).w
                bne.s   loc_98BA
                btst    #3,(word_FFF706).w
                bne.s   loc_98BA
                move.w  #$20,(dword_FF8066+2).w ; ' '
                bra.s   loc_98C4
; ---------------------------------------------------------------------------
loc_98BA:                               ; CODE XREF: UI_HandleOptionsInput+BA   j
                                        ; UI_HandleOptionsInput+C2   j
                tst.w   (dword_FF8066+2).w
                beq.s   loc_98C4
                subq.w  #1,(dword_FF8066+2).w
loc_98C4:                               ; CODE XREF: UI_HandleOptionsInput+CA   j
                                        ; UI_HandleOptionsInput+D0   j
                move.w  (dword_FF8062).w,d0
                movea.w off_98D4(pc,d0.w),a0
                adda.l  #UI_OptionsRenderRow1,a0
                jmp     (a0)
; End of function UI_HandleOptionsInput
; ---------------------------------------------------------------------------
off_98D4:       dc.w UI_OptionsRenderRow1-UI_OptionsRenderRow1
                dc.w UI_OptionsRenderRow2-UI_OptionsRenderRow1
                dc.w UI_OptionsRenderRow3-UI_OptionsRenderRow1
                dc.w UI_OptionsUpdateButtons-UI_OptionsRenderRow1
                dc.w UI_OptionsSelectCharacter-UI_OptionsRenderRow1
                dc.w UI_OptionsSelectCharacter2-UI_OptionsRenderRow1


; Renders first row of options with tile graphics
UI_OptionsRenderRow1:                               ; CODE XREF: UI_InitOptionsScreen+186   p  ; was: sub_98E0
                                        ; DATA XREF: UI_HandleOptionsInput+DE   o ...
                lea     word_A232(pc),a1
                nop
                lea     word_A248(pc),a2
                nop
                movea.w #(word_FFFF0E-M68K_RAM),a4
                move.w  #$429E,d6
                bra.w   loc_A050
; End of function UI_OptionsRenderRow1
; Updates button configuration display with input cycling
UI_OptionsUpdateButtons:                               ; CODE XREF: UI_InitOptionsScreen+198   p  ; was: sub_98F8
                                        ; DATA XREF: ROM:000098DA   o
                movea.l #word_998C,a1
                moveq   #0,d0
                move.b  (dword_FF805E+3).w,d0
                asl.w   #5,d0
                adda.l  d0,a1
                tst.b   d5
                beq.s   loc_991A
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.b  (a1),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_991A:                               ; CODE XREF: UI_OptionsUpdateButtons+12   j
                movea.w (word_FFF70E).w,a0
                adda.l  #2,a1
                movea.l a1,a2
                moveq   #$E,d7
loc_9928:                               ; CODE XREF: UI_OptionsUpdateButtons+32   j
                move.w  (a1)+,(a0)+
                dbf     d7,loc_9928
                moveq   #$E,d7
loc_9930:                               ; CODE XREF: UI_OptionsUpdateButtons+3E   j
                move.w  (a2)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d7,loc_9930
                move.b  (dword_FF805E+3).w,d0
                btst    #2,(dword_FF806A).w
                beq.s   loc_995A
                move.w  #$A,(dword_FF8062+2).w
                tst.b   d0
                bne.s   loc_9956
                move.b  #$14,d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_9956:                               ; CODE XREF: UI_OptionsUpdateButtons+56   j
                subq.b  #1,d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_995A:                               ; CODE XREF: UI_OptionsUpdateButtons+4C   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9974
                move.w  #$A,(dword_FF8062+2).w
                cmpi.b  #$14,d0
                bne.s   loc_9972
                clr.b   d0
                bra.s   loc_9974
; ---------------------------------------------------------------------------
loc_9972:                               ; CODE XREF: UI_OptionsUpdateButtons+74   j
                addq.b  #1,d0
loc_9974:                               ; CODE XREF: UI_OptionsUpdateButtons+5C   j
                                        ; UI_OptionsUpdateButtons+60   j ...
                move.b  d0,(dword_FF805E+3).w
                move.w  #$4726,d0
                moveq   #$F,d3
                bsr.w Gfx_QueueVRAMWrite
                move.w  #$47A6,d0
                moveq   #$F,d3
                bra.w Gfx_QueueVRAMWrite
; End of function UI_OptionsUpdateButtons
; ---------------------------------------------------------------------------
word_998C:	binclude	"data/other/word_998C.bin"
word_998C_End:


; Handles character selection in button configuration interface
UI_OptionsSelectCharacter:                               ; CODE XREF: UI_InitOptionsScreen+19E   p  ; was: sub_9C4C
                                        ; DATA XREF: ROM:000098DC   o
                move.b  (dword_FF8066).w,d0
                tst.b   d5
                beq.s   loc_9C64
                lea     LatinAlphabet(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_9C64:                               ; CODE XREF: UI_OptionsSelectCharacter+6   j
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   loc_9C86
                btst    #0,(word_FFA280+1).w
                bne.s   loc_9CE0
                btst    #2,(dword_FF806A+1).w
                bne.s   loc_9C94
                btst    #3,(dword_FF806A+1).w
                bne.s   loc_9CC2
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9C86:                               ; CODE XREF: UI_OptionsSelectCharacter+1E   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_9CB4
                move.w  #6,(dword_FF8062+2).w
loc_9C94:                               ; CODE XREF: UI_OptionsSelectCharacter+2E   j
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
                tst.b   d0
                bne.s   loc_9CB0
                move.b  #$98,d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CB0:                               ; CODE XREF: UI_OptionsSelectCharacter+5C   j
                subq.b  #1,d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CB4:                               ; CODE XREF: UI_OptionsSelectCharacter+40   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9CE0
                move.w  #6,(dword_FF8062+2).w
loc_9CC2:                               ; CODE XREF: UI_OptionsSelectCharacter+36   j
                movem.l d0,-(sp)
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
                cmpi.b  #$98,d0
                bne.s   loc_9CDE
                clr.b   d0
                bra.s   loc_9CE0
; ---------------------------------------------------------------------------
loc_9CDE:                               ; CODE XREF: UI_OptionsSelectCharacter+8C   j
                addq.b  #1,d0
loc_9CE0:                               ; CODE XREF: UI_OptionsSelectCharacter+26   j
                                        ; UI_OptionsSelectCharacter+38   j ...
                move.b  d0,(dword_FF8066).w
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$483C,d0
                bra.w Gfx_RenderDecimalDigits3
; End of function UI_OptionsSelectCharacter
; Handles secondary character selection in options menu
UI_OptionsSelectCharacter2:                               ; CODE XREF: UI_InitOptionsScreen+1A4   p  ; was: sub_9CFC
                                        ; DATA XREF: ROM:000098DE   o
                move.b  (dword_FF806A+2).w,d0
                tst.b   d5
                beq.s   loc_9D14
                lea     word_A284(pc),a0
                nop
                move.b  (a0,d0.w),d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
loc_9D14:                               ; CODE XREF: UI_OptionsSelectCharacter2+6   j
                moveq   #1,d1
                tst.w   (dword_FF8066+2).w
                bne.s   loc_9D36
                btst    #0,(word_FFA280+1).w
                bne.s   loc_9D6C
                btst    #2,(dword_FF806A+1).w
                bne.s   loc_9D44
                btst    #3,(dword_FF806A+1).w
                bne.s   loc_9D60
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D36:                               ; CODE XREF: UI_OptionsSelectCharacter2+1E   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_9D52
                move.w  #6,(dword_FF8062+2).w
loc_9D44:                               ; CODE XREF: UI_OptionsSelectCharacter2+2E   j
                tst.b   d0
                bne.s   loc_9D4E
                move.b  #$25,d0 ; '%'
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D4E:                               ; CODE XREF: UI_OptionsSelectCharacter2+4A   j
                subq.w  #1,d0
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D52:                               ; CODE XREF: UI_OptionsSelectCharacter2+40   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_9D6C
                move.w  #6,(dword_FF8062+2).w
loc_9D60:                               ; CODE XREF: UI_OptionsSelectCharacter2+36   j
                cmpi.b  #$25,d0 ; '%'
                bne.s   loc_9D6A
                clr.b   d0
                bra.s   loc_9D6C
; ---------------------------------------------------------------------------
loc_9D6A:                               ; CODE XREF: UI_OptionsSelectCharacter2+68   j
                addq.w  #1,d0
loc_9D6C:                               ; CODE XREF: UI_OptionsSelectCharacter2+26   j
                                        ; UI_OptionsSelectCharacter2+38   j ...
                move.b  d0,(dword_FF806A+2).w
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d1
                move.w  #$493E,d0
                bra.w Gfx_RenderDecimalDigits2
; End of function UI_OptionsSelectCharacter2
; Renders toggle tiles for options menu row
UI_RenderOptionsToggleRow:
                lea     word_A220(pc),a1  ; was: sub_9D88
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF2A-M68K_RAM),a4
                move.w  #$43B6,d6
                bra.w Gfx_RenderToggleTiles
; End of function UI_RenderOptionsToggleRow
; Renders second row of options with tile graphics
UI_OptionsRenderRow2:                               ; CODE XREF: UI_InitOptionsScreen+18C   p  ; was: sub_9DA0
                                        ; DATA XREF: ROM:000098D6   o
                lea     word_A220(pc),a1
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF38-M68K_RAM),a4
                move.w  #$44B6,d6
                bra.w   loc_A050
; End of function UI_OptionsRenderRow2
; Renders third row of options with tile graphics
UI_OptionsRenderRow3:                               ; CODE XREF: UI_InitOptionsScreen+192   p  ; was: sub_9DB8
                                        ; DATA XREF: ROM:000098D8   o
                lea     word_A220(pc),a1
                nop
                lea     word_A22A(pc),a2
                nop
                movea.w #(word_FFFF38-M68K_RAM),a4
                move.w  #$45B6,d6
                bra.w Gfx_RenderToggleTiles
; End of function UI_OptionsRenderRow3
; Initializes options menu with objects palettes and cursor
Sys_InitOptionsMenuState:                               ; DATA XREF: Sys_DispatchGameState+A2   o  ; was: sub_9DD0
                tst.w   (GameSubstateIndex).w
                bne.s   loc_9E12
                jsr (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_9E12:                               ; CODE XREF: Sys_InitOptionsMenuState+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$800,d0
                moveq   #0,d1
                jsr (Data_LoadPointerTable2).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                jsr (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FFF0,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr (Gfx_SetupScrollPlanes).l
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8062).w
                clr.w   (dword_FF805E).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                move.w  #$118,d0
                move.w  #$CA,d1
                move.l  #word_A36A,d2
                jsr (UI_InitCursorSprite).l
                clr.b   (dword_FF806A).w
                clr.b   (dword_FF806A+1).w
; End of function Sys_InitOptionsMenuState
; Main options menu loop handling input and updates
Sys_RunOptionsMenuLoop:                               ; DATA XREF: Sys_DispatchGameState+A6   o  ; was: sub_9E88
                bclr    #1,(word_FF80F4).w
                beq.s   loc_9EA0
                move.w  #$54,(GameModeIndex).w ; 'T'
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; ---------------------------------------------------------------------------
loc_9EA0:                               ; CODE XREF: Sys_RunOptionsMenuLoop+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_9EC2
                btst    #7,(word_FFF708).w
                beq.s   loc_9EC2
                move.b  #$C4,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_9EC2:                               ; CODE XREF: Sys_RunOptionsMenuLoop+1C   j
                                        ; Sys_RunOptionsMenuLoop+24   j
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w UI_HandleOptionsNavigation
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function Sys_RunOptionsMenuLoop
; Processes D-pad input for options menu cursor
UI_HandleOptionsNavigation:                               ; CODE XREF: Sys_RunOptionsMenuLoop+52   p  ; was: sub_9EF6
                bsr.w Gfx_UpdateCursorFlash
                btst    #0,(dword_FF805E+2).w
                bne.w UI_AnimateOptionsCursor
                move.w  (dword_FF805E).w,d0
                btst    #0,(word_FFF708).w
                beq.s   loc_9F28
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                subq.w  #2,d0
                bpl.s   loc_9F50
                moveq   #0,d0
loc_9F28:                               ; CODE XREF: UI_HandleOptionsNavigation+18   j
                btst    #1,(word_FFF708).w
                beq.w   loc_9F62
                bset    #0,(dword_FF805E+2).w
                move.w  #$10,(dword_FF8062+2).w
                move.w  #$20,(dword_FF8066+2).w ; ' '
                addq.w  #2,d0
                cmpi.w  #6,d0
                bmi.s   loc_9F50
                moveq   #6,d0
                bra.s   loc_9F62
; ---------------------------------------------------------------------------
loc_9F50:                               ; CODE XREF: UI_HandleOptionsNavigation+2E   j
                                        ; UI_HandleOptionsNavigation+54   j
                movem.l d0,-(sp)
                move.b  #$DB,d0
                jsr (Input_ProcessButtons).l
                movem.l (sp)+,d0
loc_9F62:                               ; CODE XREF: UI_HandleOptionsNavigation+38   j
                                        ; UI_HandleOptionsNavigation+58   j
                move.w  d0,(dword_FF805E).w
                move.w  word_9F84(pc,d0.w),(dword_FF8062).w
                move.b  (word_FFF708).w,(dword_FF806A).w
                move.b  (word_FFF706).w,(dword_FF806A+1).w
                move.b  (word_FFF708).w,d5
                andi.b  #$60,d5 ; '`'
                bra.w   loc_988E
; End of function UI_HandleOptionsNavigation
; ---------------------------------------------------------------------------
word_9F84:      dc.w 6, 8, $A, $C, $E


; Renders three decimal digits to VRAM for numeric display
Gfx_RenderDecimalDigits3:                               ; CODE XREF: UI_OptionsSelectCharacter+AC   j  ; was: sub_9F8E
                movea.w (word_FFF70E).w,a0
                move.b  d1,d2
                move.w  d1,d3
                asr.b   #4,d1
                asr.w   #8,d3
                andi.w  #$F,d1
                andi.w  #$F,d2
                andi.w  #1,d3
                asl.w   #1,d1
                asl.w   #1,d2
                asl.w   #1,d3
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                addi.w  #-$5CFE,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                addq.w  #1,d3
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #3,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d0
                moveq   #3,d3
                bra.w Gfx_QueueVRAMWrite
; End of function Gfx_RenderDecimalDigits3
; Renders two decimal digits to VRAM for numeric display
Gfx_RenderDecimalDigits2:                               ; CODE XREF: UI_OptionsSelectCharacter2+88   j  ; was: sub_9FDA
                movea.w (word_FFF70E).w,a0
                move.b  d1,d2
                asr.b   #4,d1
                andi.w  #$F,d1
                andi.w  #$F,d2
                asl.w   #1,d1
                asl.w   #1,d2
                addi.w  #-$5CFE,d1
                addi.w  #-$5CFE,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                addq.w  #1,d1
                addq.w  #1,d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                moveq   #2,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d0
                moveq   #2,d3
; End of function Gfx_RenderDecimalDigits2
; Queues VRAM write command with auto-increment for DMA transfer
Gfx_QueueVRAMWrite:                               ; CODE XREF: UI_OptionsUpdateButtons+86   p  ; was: sub_A00E
                                        ; UI_OptionsUpdateButtons+90   j ...
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  d0,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_QueueVRAMWrite
; Renders toggle option tiles with on/off state highlighting
Gfx_RenderToggleTiles:                               ; CODE XREF: UI_RenderOptionsToggleRow+14   j  ; was: sub_A04C
                                        ; UI_OptionsRenderRow3+14   j
                moveq   #2,d5
                bra.s   loc_A052
; ---------------------------------------------------------------------------
loc_A050:                               ; CODE XREF: UI_OptionsRenderRow1+14   j
                                        ; UI_OptionsRenderRow2+14   j
                moveq   #1,d5
loc_A052:                               ; CODE XREF: Gfx_RenderToggleTiles+2   j
                btst    #2,(dword_FF806A).w
                beq.s   loc_A060
                bclr    d5,1(a4)
                bra.s   loc_A06C
; ---------------------------------------------------------------------------
loc_A060:                               ; CODE XREF: Gfx_RenderToggleTiles+C   j
                btst    #3,(dword_FF806A).w
                beq.s   loc_A072
                bset    d5,1(a4)
loc_A06C:                               ; CODE XREF: Gfx_RenderToggleTiles+12   j
                move.w  #$A,(dword_FF8062+2).w
loc_A072:                               ; CODE XREF: Gfx_RenderToggleTiles+1A   j
                move.w  #$2000,d1
                move.w  #$4000,d2
                btst    d5,1(a4)
                beq.s   loc_A088
                move.w  #$2000,d2
                move.w  #$4000,d1
loc_A088:                               ; CODE XREF: Gfx_RenderToggleTiles+32   j
                movea.w (word_FFF70E).w,a0
                moveq   #0,d7
loc_A08E:                               ; CODE XREF: Gfx_RenderToggleTiles+50   j
                move.w  (a1)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   loc_A09E
                add.w   d1,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   loc_A08E
; ---------------------------------------------------------------------------
loc_A09E:                               ; CODE XREF: Gfx_RenderToggleTiles+48   j
                                        ; Gfx_RenderToggleTiles+60   j
                move.w  (a2)+,d0
                cmpi.w  #$FFFF,d0
                beq.s   loc_A0AE
                add.w   d2,d0
                move.w  d0,(a0)+
                addq.w  #1,d7
                bra.s   loc_A09E
; ---------------------------------------------------------------------------
loc_A0AE:                               ; CODE XREF: Gfx_RenderToggleTiles+58   j
                movea.w (word_FFF70E).w,a1
                move.w  d7,d3
loc_A0B4:                               ; CODE XREF: Gfx_RenderToggleTiles+6E   j
                move.w  (a1)+,d0
                addq.w  #1,d0
                move.w  d0,(a0)+
                dbf     d3,loc_A0B4
                move.w  d6,d0
                move.w  d7,d3
                bsr.w Gfx_QueueVRAMWrite
                addi.w  #$80,d6
                move.w  d6,d0
                move.w  d7,d3
                bra.w Gfx_QueueVRAMWrite
; End of function Gfx_RenderToggleTiles
; Animates cursor movement to target position with smooth scrolling
UI_AnimateCursorToTarget:                               ; CODE XREF: UI_HandleOptionsInput+A   j  ; was: sub_A0D2
                movea.l #word_A112,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF8062).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   loc_A0F8
                cmpi.w  #2,d1
                bmi.s   loc_A0FE
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
loc_A0F8:                               ; CODE XREF: UI_AnimateCursorToTarget+18   j
                cmpi.w  #$FFFE,d1
                bmi.s UI_DecrementCursorY
loc_A0FE:                               ; CODE XREF: UI_AnimateCursorToTarget+1E   j
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
; Decrements cursor Y position by 2 pixels for upward navigation
UI_DecrementCursorY:                               ; CODE XREF: UI_AnimateCursorToTarget+2A   j  ; was: loc_A10C
                subq.w  #2,$14(a1)
                rts
; End of function UI_AnimateCursorToTarget
; ---------------------------------------------------------------------------
word_A112:      dc.w $B3, $D3, $E3, $FB, $10B, $11B
                                        ; DATA XREF: UI_AnimateCursorToTarget   o


; Smoothly animates cursor to selected menu option
UI_AnimateOptionsCursor:                               ; CODE XREF: UI_HandleOptionsNavigation+A   j  ; was: sub_A11E
                lea     word_A15E(pc),a0
                nop
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF805E).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $14(a1),d1
                bmi.s   loc_A144
                cmpi.w  #2,d1
                bmi.s   loc_A14A
                addq.w  #2,$14(a1)
                rts
; ---------------------------------------------------------------------------
loc_A144:                               ; CODE XREF: UI_AnimateOptionsCursor+18   j
                cmpi.w  #$FFFE,d1
                bmi.s   loc_A158
loc_A14A:                               ; CODE XREF: UI_AnimateOptionsCursor+1E   j
                move.w  (a0,d0.w),$14(a1)
                bclr    #0,(dword_FF805E+2).w
                rts
; ---------------------------------------------------------------------------
loc_A158:                               ; CODE XREF: UI_AnimateOptionsCursor+2A   j
                subq.w  #2,$14(a1)
                rts
; End of function UI_AnimateOptionsCursor
; ---------------------------------------------------------------------------
word_A15E:      dc.w $CA, $DA, $EA, $FA, $10A
                                        ; DATA XREF: UI_AnimateOptionsCursor   o


; Updates cursor flash animation timer and palette
Gfx_UpdateCursorFlash:                               ; CODE XREF: UI_HandleOptionsInput   p  ; was: sub_A168
                                        ; sub_9EF6   p ...
                move.w  (dword_FF8062+2).w,d0
                beq.s   loc_A174
                subq.w  #2,d0
                move.w  d0,(dword_FF8062+2).w
loc_A174:                               ; CODE XREF: Gfx_UpdateCursorFlash+4   j
                andi.w  #$E,d0
                move.w  word_A180(pc,d0.w),(word_FFE35C).w
                rts
; End of function Gfx_UpdateCursorFlash
; ---------------------------------------------------------------------------
word_A180:      dc.w $200, $400, $620, $840, $A60, $C82, $EA4, $EC6


; Updates menu palette based on frame counter for color cycling
Gfx_UpdateMenuPalette:                               ; CODE XREF: UI_HandleTitleInput+110   p  ; was: sub_A190
                                        ; sub_9774:loc_97B4   p ...
                move.w  (word_FFA280).w,d1
                asl.w   #1,d1
                andi.w  #2,d1
                move.w  word_A1AE(pc,d1.w),d0
                move.w  d0,(word_FFE376).w
                addq.w  #4,d1
                move.w  word_A1AE(pc,d1.w),d0
                move.w  d0,(word_FFE37E).w
                rts
; End of function Gfx_UpdateMenuPalette
; ---------------------------------------------------------------------------
word_A1AE:      dc.w $E00, $E44, $4C4, $40
stru_A1B6:      dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitTitleScreen+12   o
                                        ; UI_InitializeSEGAScreen+1C   o
                dc.l byte_182F24        ; field_2
                dc.w 0                  ; field_6
                dc.w 3                  ; field_0
                dc.l byte_184378        ; field_2
                dc.w $2000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1814D4       ; field_2
                dc.w $3000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_182C9C        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_182CE2        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184590        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184688        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF
stru_A1F8:      dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitOptionsScreen+C   o
                                        ; Sys_InitOptionsMenuState+C   o ...
                dc.l byte_182F24        ; field_2
                dc.w $2000              ; field_6
                dc.w 3                  ; field_0
                dc.l byte_184378        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184590        ; field_2
                dc.w $6800              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184688        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
word_A220:      dc.w $8332, $8330, $8300, $8300, $FFFF
                                        ; DATA XREF: UI_RenderOptionsToggleRow   o
                                        ; sub_9DA0   o ...
word_A22A:      dc.w $8332, $8320, $8320, $FFFF
                                        ; DATA XREF: UI_RenderOptionsToggleRow+6   o
                                        ; UI_OptionsRenderRow2+6   o ...
word_A232:      dc.w $833A, $833E, $8334, $831E, $8338, $831E, $8316, $833A, $8346, $8300, $FFFF
                                        ; DATA XREF: UI_OptionsRenderRow1   o
word_A248:      dc.w $833A, $833E, $8334, $831E, $8338, $8324, $8316, $8338, $831C, $FFFF
                                        ; DATA XREF: UI_OptionsRenderRow1+6   o
                dc.w $8330, $8332, $8338, $832E, $8316, $832C, $8300, $FFFF, $831C, $8326
                dc.w $8338, $831E, $831A, $833C, $831E, $8338, $831A, $833E, $833C, $FFFF
word_A284:      dc.w $1011, $1213, $1415, $1617, $1819, $1A1B, $1C1D, $1E1F, $2023, $2425
                                        ; DATA XREF: UI_OptionsSelectCharacter2+8   o
                dc.w $2628, $2A2B, $2C2D, $2E2F, $3031, $3233, $3536, $3738, $393A
LatinAlphabet:  dc.b $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
                                        ; DATA XREF: UI_OptionsSelectCharacter+8   o
                dc.b $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
                dc.b $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
                dc.b $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
byte_A2EA:      dc.b $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
                dc.b $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
                dc.b $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
                dc.b $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
                dc.b $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
                dc.b $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FB, $FC, $FF


; Initializes cursor sprite with position and graphics pointer
UI_InitCursorSprite:                               ; CODE XREF: UI_InitOptionsScreen+176   p  ; was: sub_A346
                                        ; Sys_InitOptionsMenuState+AA   p ...
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$F8,(a0)
                move.w  #$CC00,2(a0)
                move.w  #0,$E(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,8(a0)
                rts
; End of function UI_InitCursorSprite
; Empty entity state handler in main dispatch table
Entity_EmptyState5:                              ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_5
                rts
; End of function Entity_EmptyState5
; ---------------------------------------------------------------------------
word_A36A:      dc.w $4101, $E00, $F400 ; DATA XREF: UI_InitOptionsScreen+170   o
                                        ; Sys_InitOptionsMenuState+A4   o
                dc.w $4101, $E00, $F420
                dc.w $4101, $E00, $F440
                dc.w $4101, $E00, $F460
                dc.w $4101, $E00, $F4E0
                dc.w $4101, $E00, $F4C0
                dc.w $C101, $E00, $F4A0
word_A394:      dc.w $C101, $600, $F4F8 ; DATA XREF: UI_HandlePasswordInput+5C   o
word_A39A:      dc.w $C101, $E00, $F4F0 ; DATA XREF: UI_HandlePasswordInput:loc_A716   o


; Initializes password entry screen with input fields
