UI_HandleTitleMenuInput:
                bsr.w   Gfx_RenderMenuSprites           ; was: sub_1F1B2
                bsr.w   Gfx_InterpolateScrollPosition
                bne.w   loc_1F5AE
                bsr.w   UI_UpdateMenuState
                move.w  (word_FFA22A).w,d1
                beq.s   loc_1F1D2
                btst    #2,(word_FFF708).w
                beq.s   loc_1F1D2
                moveq   #0,d1
loc_1F1D2:                                              ; CODE XREF: UI_HandleTitleMenuInput+14   j
                                        ; UI_HandleTitleMenuInput+1C   j
                tst.w   d1
                bne.s   loc_1F1E0
                btst    #3,(word_FFF708).w
                beq.s   loc_1F1E0
                moveq   #2,d1
loc_1F1E0:                                              ; CODE XREF: UI_HandleTitleMenuInput+22   j
                                        ; UI_HandleTitleMenuInput+2A   j
                cmp.w   (word_FFA22A).w,d1
                beq.s   loc_1F1F4
                move.w  d1,(word_FFA22A).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
loc_1F1F4:                                              ; CODE XREF: UI_HandleTitleMenuInput+32   j
                move.b  (word_FFF708).w,d0
                btst    #1,d0
                bne.s   loc_1F204
                andi.b  #$E0,d0
                beq.s   loc_1F21C
loc_1F204:                                              ; CODE XREF: UI_HandleTitleMenuInput+4A   j
                addq.w  #2,(word_FFA29C).w
                subi.w  #$10,(dword_FF8128+2).w
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
                bra.w   UI_RenderTitleMenuOptions
; ---------------------------------------------------------------------------
loc_1F21C:                                              ; CODE XREF: UI_HandleTitleMenuInput+50   j
                btst    #4,(word_FFF708).w
                beq.w   UI_RenderTitleMenuOptions
                subq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8128+2).w
                move.w  #$12,(word_FFA02A).w
                bra.w   UI_RenderTitleMenuOptions
; End of function UI_HandleTitleMenuInput
; Handles menu navigation with directional input
UI_HandleMenuNavigation:                                ; DATA XREF: ROM:0001F142   o  ; was: sub_1F238
                bsr.w   Gfx_RenderMenuSprites
                bsr.w   Gfx_UpdatePaletteIndices
                bsr.w   Gfx_InterpolateScrollPosition
                bne.w   locret_1F05C
                bsr.w   UI_UpdateMenuState
                move.w  (dword_FF812C).w,d1
                beq.s   loc_1F25C
                btst    #2,(word_FFF708).w
                beq.s   loc_1F25C
                subq.w  #1,d1
loc_1F25C:                                              ; CODE XREF: UI_HandleMenuNavigation+18   j
                                        ; UI_HandleMenuNavigation+20   j
                cmpi.w  #$19,d1
                bpl.s   loc_1F26C
                btst    #3,(word_FFF708).w
                beq.s   loc_1F26C
                addq.w  #1,d1
loc_1F26C:                                              ; CODE XREF: UI_HandleMenuNavigation+28   j
                                        ; UI_HandleMenuNavigation+30   j
                cmp.w   (dword_FF812C).w,d1
                beq.s   loc_1F280
                move.w  d1,(dword_FF812C).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
loc_1F280:                                              ; CODE XREF: UI_HandleMenuNavigation+38   j
                move.b  (word_FFF708).w,d0
                btst    #1,d0
                bne.s   loc_1F290
                andi.b  #$E0,d0
                beq.s   loc_1F2AE
loc_1F290:                                              ; CODE XREF: UI_HandleMenuNavigation+50   j
                move.w  #$E,(dword_FF8134).w
                addq.w  #2,(word_FFA29C).w
                subi.w  #$10,(dword_FF8128+2).w
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
                bra.w   UI_UpdateMenuCursor
; ---------------------------------------------------------------------------
loc_1F2AE:                                              ; CODE XREF: UI_HandleMenuNavigation+56   j
                btst    #0,(word_FFF708).w
                bne.s   UI_HandleMenuUpInput
                btst    #4,(word_FFF708).w
                beq.w   UI_UpdateMenuCursor
; Handles up direction input on menu
UI_HandleMenuUpInput:                                   ; CODE XREF: UI_HandleMenuNavigation+7C   j  ; was: loc_1F2C0
                move.w  #$E,(dword_FF8134).w
                subq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8128+2).w
                bra.w   UI_UpdateMenuCursor
; End of function UI_HandleMenuNavigation
; ---------------------------------------------------------------------------
off_1F2D2:      dc.l    byte_1FA82                      ; DATA XREF: UI_RenderSelectedDifficulty+10   o
                dc.l    byte_1FA8A
                dc.l    byte_1FA92
                dc.l    byte_1FA9A
                dc.l    byte_1FAA2
                dc.l    byte_1FAAA
                dc.l    byte_1FAB2
                dc.l    byte_1FABA
                dc.l    byte_1FAC2
                dc.l    byte_1FACA
                dc.l    byte_1FAD2
                dc.l    byte_1FADA
                dc.l    byte_1FAE2
                dc.l    byte_1FAEA
                dc.l    byte_1FAF2
                dc.l    byte_1FAFA
                dc.l    byte_1FB02
                dc.l    byte_1FB0A
                dc.l    byte_1FB12
                dc.l    byte_1FB1A
                dc.l    byte_1FB22
                dc.l    byte_1FB2A
                dc.l    byte_1FB32
                dc.l    byte_1FB3A
                dc.l    byte_1FB42
                dc.l    byte_1FB4A
byte_1F33A:     dc.b    0, 7, $38, 2, 4, 1, 6, 3
                                        ; DATA XREF: UI_MapDifficultyIndex   o
                                        ; UI_RenderSelectedDifficulty+4   o
                dc.b    5, $10, 8, $20, $18, $30, $28, $15
                dc.b    $B, $26, $19, $34, $2A, $24, $22, 9
                dc.b    $A, $14, $11, 0

; Handles weapon menu directional navigation
UI_HandleWeaponMenuNavigation:                          ; DATA XREF: ROM:0001F144   o  ; was: sub_1F356
                bsr.w   Gfx_RenderMenuSprites
                bsr.w   Gfx_UpdatePaletteIndices
                bsr.w   Gfx_InterpolateScrollPosition
                bne.w   locret_1F05C
                bsr.w   UI_UpdateMenuState
                move.b  (word_FFF708).w,d0
                andi.b  #$E0,d0
                beq.s   loc_1F392
                move.w  #$E,(dword_FF8134).w
                addq.w  #2,(word_FFA29C).w
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                bra.w   UI_UpdateWeaponCursor
; ---------------------------------------------------------------------------
loc_1F392:                                              ; CODE XREF: UI_HandleWeaponMenuNavigation+1C   j
                btst    #0,(word_FFF708).w
                bne.s   UI_HandleWeaponMenuUp
                btst    #4,(word_FFF708).w
                beq.w   UI_UpdateWeaponCursor
; Handles up direction on weapon selection menu
UI_HandleWeaponMenuUp:                                  ; CODE XREF: UI_HandleWeaponMenuNavigation+42   j  ; was: loc_1F3A4
                move.w  #$E,(dword_FF8134).w
                subq.w  #2,(word_FFA29C).w
                addi.w  #$10,(dword_FF8128+2).w
                bra.w   UI_UpdateWeaponCursor
; End of function UI_HandleWeaponMenuNavigation
; Executes sprite fade with DMA transfers
Sprite_ExecuteFadeTransition:                           ; DATA XREF: ROM:0001F146   o  ; was: sub_1F3B8
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.w   locret_1F05C
                addq.w  #2,(word_FFA29C).w
                clr.w   (word_FFA02A).w
                clr.w   (dword_FFA90C).w
                rts
; End of function Sprite_ExecuteFadeTransition
; Loads menu graphic elements in loop
Gfx_LoadMenuGraphics:                                   ; DATA XREF: ROM:0001F148   o  ; was: sub_1F3E6
                addq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8040).w
; Renders menu text strings in loop
Gfx_RenderMenuTextLoop:                                 ; CODE XREF: Gfx_LoadMenuGraphics+30   j  ; was: loc_1F3EE
                lea     stru_1F424(pc),a1
                nop
                move.w  (dword_FF8040).w,d1
                move.w  (a1,d1.w),d0
                move.w  2(a1,d1.w),d4
                movea.l 4(a1,d1.w),a0
                jsr     (UI_RenderTextStringWrapped).l
                addi.w  #8,(dword_FF8040).w
                cmpi.w  #$40,(dword_FF8040).w           ; '@'
                bne.s   Gfx_RenderMenuTextLoop
                lea     (TitleAndOptionsPaletteOffsetList).l,a4
                jmp     Gfx_LoadMultiplePalettes
; End of function Gfx_LoadMenuGraphics
; ---------------------------------------------------------------------------
stru_1F424:     dc.w    $8100                           ; field_0
                                        ; DATA XREF: Gfx_LoadMenuGraphics:loc_1F3EE   o
                dc.w    $629C                           ; field_2
                dc.l    byte_1FB57                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6410                           ; field_2
                dc.l    byte_1FB64                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6522                           ; field_2
                dc.l    byte_1FB77                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6622                           ; field_2
                dc.l    byte_1FB81                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6788                           ; field_2
                dc.l    byte_1FB8B                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6910                           ; field_2
                dc.l    byte_1FBA7                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6A10                           ; field_2
                dc.l    byte_1FBBF                      ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6B1A                           ; field_2
                dc.l    byte_1FBD7                      ; field_4

; Waits for button press before proceeding
UI_WaitForButtonPress:                                  ; DATA XREF: ROM:0001F14A   o  ; was: sub_1F464
                bsr.w   Gfx_RenderConfirmSprites
                btst    #7,(word_FFF708).w
                bne.s   UI_ConfirmMenuSelection
                rts
; ---------------------------------------------------------------------------
; Confirms menu selection and triggers fade
UI_ConfirmMenuSelection:                                ; CODE XREF: UI_WaitForButtonPress+A   j  ; was: loc_1F472
                addq.w  #2,(word_FFA29C).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                bra.w   UI_UpdateMenuState
; End of function UI_WaitForButtonPress
; Empty UI menu state handler
UI_MenuEmptyState:                                      ; DATA XREF: ROM:0001F14C   o  ; was: nullsub_53
                rts
; End of function UI_MenuEmptyState
; Handles option selection with directional controls
UI_HandleOptionSelection:                               ; CODE XREF: Stage_HandleTransition+1A   p  ; was: sub_1F496
                move.b  (word_FFF708).w,d0
                andi.b  #$E0,d0
                beq.s   loc_1F4D2
                move.w  #$E,(dword_FF8134).w
                move.b  #$DF,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(word_FFA24E).w
                cmpi.w  #8,(word_FFA24E).w
                bmi.s   loc_1F4D2
                move.w  #6,(word_FFA24E).w
                addq.w  #2,(word_FFA29C).w
                move.w  #$FFE0,(dword_FF8128+2).w
                move.w  #$14,(word_FFA02A).w
loc_1F4D2:                                              ; CODE XREF: UI_HandleOptionSelection+8   j
                                        ; UI_HandleOptionSelection+24   j
                tst.w   (word_FFA24E).w
                beq.s   loc_1F51A
                btst    #4,(word_FFF708).w
                beq.s   loc_1F51A
                move.w  #$E,(dword_FF8134).w
                move.b  #$DE,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #2,(word_FFA24E).w
                bpl.s   loc_1F4FA
                clr.w   (word_FFA24E).w
loc_1F4FA:                                              ; CODE XREF: UI_HandleOptionSelection+5E   j
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),(dword_FF8128).w
                move.w  (word_FFA24E).w,(word_FF803C).w
                clr.w   (word_FF8238).w
                jsr     (UI_IncrementWeaponSelection).l
                bra.w   loc_1F5AE
; ---------------------------------------------------------------------------
loc_1F51A:                                              ; CODE XREF: UI_HandleOptionSelection+40   j
                                        ; UI_HandleOptionSelection+48   j
                move.w  (word_FFA24E).w,(word_FF803C).w
                move.w  (dword_FF8128).w,d0
                andi.w  #$C,d0
                move.w  (dword_FF8128).w,d1
                andi.w  #2,d1
                moveq   #0,d2
                tst.w   d0
                beq.s   loc_1F542
                btst    #0,(word_FFF708).w
                beq.s   loc_1F542
                subq.w  #4,d0
                addq.w  #1,d2
loc_1F542:                                              ; CODE XREF: UI_HandleOptionSelection+9E   j
                                        ; UI_HandleOptionSelection+A6   j
                cmpi.w  #8,d0
                beq.s   loc_1F554
                btst    #1,(word_FFF708).w
                beq.s   loc_1F554
                addq.w  #4,d0
                addq.w  #1,d2
loc_1F554:                                              ; CODE XREF: UI_HandleOptionSelection+B0   j
                                        ; UI_HandleOptionSelection+B8   j
                tst.w   d1
                bne.s   loc_1F564
                btst    #3,(word_FFF708).w
                beq.s   loc_1F564
                addq.w  #2,d1
                addq.w  #1,d2
loc_1F564:                                              ; CODE XREF: UI_HandleOptionSelection+C0   j
                                        ; UI_HandleOptionSelection+C8   j
                tst.w   d1
                beq.s   loc_1F574
                btst    #2,(word_FFF708).w
                beq.s   loc_1F574
                subq.w  #2,d1
                addq.w  #1,d2
loc_1F574:                                              ; CODE XREF: UI_HandleOptionSelection+D0   j
                                        ; UI_HandleOptionSelection+D8   j
                add.w   d0,d1
                move.w  d1,(dword_FF8128).w
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (dword_FF8128).w,d0
                move.w  d0,(a0)
                move.w  d2,(dword_FF8040).w
                jsr     (Gfx_LoadPaletteData).l
                move.w  (dword_FF8040).w,d2
                tst.w   d2
                beq.s   loc_1F5AE
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
                clr.w   (word_FF8238).w
                jsr     (UI_IncrementWeaponSelection).l
loc_1F5AE:                                              ; CODE XREF: UI_HandleTitleMenuInput+8   j
                                        ; UI_HandleOptionSelection+80   j
                clr.w   (dword_FF8040).w
loc_1F5B2:                                              ; CODE XREF: UI_HandleOptionSelection+154   j
                move.w  (dword_FF8040).w,d1
                move.w  #$8100,d0
                tst.w   (word_FFA29C).w
                bne.s   UI_RenderOptionMenuText
                cmp.w   (dword_FF8128).w,d1
                bne.s   UI_RenderOptionMenuText
                move.w  #$E100,d0
; Renders option menu text strings using lookup table
UI_RenderOptionMenuText:                                ; CODE XREF: UI_HandleOptionSelection+128   j  ; was: loc_1F5CA
                                        ; UI_HandleOptionSelection+12E   j
                lea     word_1F5EE(pc),a1
                nop
                move.w  (a1,d1.w),d4
                asl.w   #1,d1
                movea.l $C(a1,d1.w),a0
                jsr     (UI_RenderTextStringWrapped).l
                addq.w  #2,(dword_FF8040).w
                cmpi.w  #$C,(dword_FF8040).w
                bne.s   loc_1F5B2
                rts
; End of function UI_HandleOptionSelection
; ---------------------------------------------------------------------------
word_1F5EE:     dc.w    $640C, $6430, $650C, $6530, $660C, $6630
                                        ; DATA XREF: Gfx_SetupWeaponSprites+10   o
                                        ; sub_1F496:loc_1F5CA   o
                dc.l    byte_1FA0F
                dc.l    byte_1FA1C
                dc.l    byte_1FA29
                dc.l    byte_1FA35
                dc.l    byte_1FA42
                dc.l    byte_1FA4E

; Renders difficulty selection text
UI_RenderDifficultyText:                                ; CODE XREF: Gfx_SetupWeaponSprites   p  ; was: sub_1F612
                move.w  #$A100,d0
                lea     byte_1F9FA(pc),a0
                nop
                move.w  #$6294,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderDifficultyText
; Renders title menu text options with highlight colors
UI_RenderTitleMenuOptions:                              ; CODE XREF: UI_HandleTitleMenuInput+66   j  ; was: sub_1F626
                                        ; UI_HandleTitleMenuInput+70   j
                move.w  #$8100,d0
                cmpi.w  #2,(word_FFA29C).w
                bne.s   loc_1F63A
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1F63E
loc_1F63A:                                              ; CODE XREF: UI_RenderTitleMenuOptions+A   j
                move.w  #$A100,d0
loc_1F63E:                                              ; CODE XREF: UI_RenderTitleMenuOptions+12   j
                lea     byte_1FA5B(pc),a0
                nop
                move.w  #$680E,d4
                jsr     (UI_RenderTextStringWrapped).l
                move.w  #$8100,d0
                tst.w   (word_FFA22A).w
                beq.s   loc_1F65C
                move.w  #$A100,d0
loc_1F65C:                                              ; CODE XREF: UI_RenderTitleMenuOptions+30   j
                lea     byte_1FA69(pc),a0
                nop
                move.w  #$6830,d4
                jsr     (UI_RenderTextStringWrapped).l
                move.w  #$8100,d0
                tst.w   (word_FFA22A).w
                bne.s   loc_1F67A
                move.w  #$A100,d0
loc_1F67A:                                              ; CODE XREF: UI_RenderTitleMenuOptions+4E   j
                lea     byte_1FA70(pc),a0
                nop
                move.w  #$6840,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleMenuOptions
; Updates menu cursor position display
UI_UpdateMenuCursor:                                    ; CODE XREF: UI_HandleMenuNavigation+72   j  ; was: sub_1F68A
                                        ; UI_HandleMenuNavigation+84   j
                move.w  #$E100,d0
                cmpi.w  #2,(word_FFA29C).w
                beq.s   loc_1F69A
; End of function UI_UpdateMenuCursor
; Renders control settings text
UI_RenderControlsText:                                  ; CODE XREF: Gfx_SetupWeaponSprites+8   p  ; was: sub_1F696
                move.w  #$8100,d0
loc_1F69A:                                              ; CODE XREF: UI_UpdateMenuCursor+A   j
                lea     byte_1FA74(pc),a0
                nop
                move.w  #$680E,d4
                jsr     (UI_RenderTextStringWrapped).l
                bra.s   UI_RenderSelectedDifficulty
; End of function UI_RenderControlsText
; Maps difficulty byte to menu index
UI_MapDifficultyIndex:                                  ; CODE XREF: Gfx_SetupWeaponSprites+4   p  ; was: sub_1F6AC
                lea     byte_1F33A(pc),a0
                move.b  (byte_FFFF30).w,d0
                moveq   #0,d1
                moveq   #$19,d7
loc_1F6B8:                                              ; CODE XREF: UI_MapDifficultyIndex+12   j
                cmp.b   (a0)+,d0
                beq.s   loc_1F6C8
                addq.w  #1,d1
                dbf     d7,loc_1F6B8
                move.b  #0,(byte_FFFF30).w
loc_1F6C8:                                              ; CODE XREF: UI_MapDifficultyIndex+E   j
                move.b  d1,(dword_FF812C+1).w
                rts
; End of function UI_MapDifficultyIndex
; Renders currently selected difficulty option
UI_RenderSelectedDifficulty:                            ; CODE XREF: UI_RenderControlsText+14   j  ; was: sub_1F6CE
                move.w  (dword_FF812C).w,d1
                lea     byte_1F33A(pc),a0
                move.b  (a0,d1.w),(byte_FFFF30).w
                asl.w   #2,d1
                lea     off_1F2D2(pc),a0
                movea.l (a0,d1.w),a0
                move.w  #$E100,d0
                cmpi.w  #2,(word_FFA29C).w
                beq.s   loc_1F6F6
                move.w  #$8100,d0
loc_1F6F6:                                              ; CODE XREF: UI_RenderSelectedDifficulty+22   j
                move.w  #$6830,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderSelectedDifficulty
; Updates weapon selection cursor position
UI_UpdateWeaponCursor:                                  ; CODE XREF: UI_HandleWeaponMenuNavigation+38   j  ; was: sub_1F700
                                        ; UI_HandleWeaponMenuNavigation+4A   j
                move.w  #$E100,d0
                cmpi.w  #4,(word_FFA29C).w
                beq.s   loc_1F710
; End of function UI_UpdateWeaponCursor
; Renders sound settings text
UI_RenderSoundText:                                     ; CODE XREF: Gfx_SetupWeaponSprites+C   p  ; was: sub_1F70C
                move.w  #$8100,d0
loc_1F710:                                              ; CODE XREF: UI_UpdateWeaponCursor+A   j
                lea     byte_1FB52(pc),a0
                nop
                move.w  #$690E,d4
                jmp     (UI_RenderTextStringWrapped).l
; End of function UI_RenderSoundText
; Smoothly interpolates scroll position to target
Gfx_InterpolateScrollPosition:                          ; CODE XREF: Stage_HandleTransition+8   p  ; was: sub_1F720
                                        ; UI_HandleTitleMenuInput+4   p
                move.w  (dword_FFA90C).w,d0
                cmp.w   (dword_FF8128+2).w,d0
                beq.s   locret_1F73A
                bmi.s   loc_1F734
                subq.w  #4,(dword_FFA90C).w
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_1F734:                                              ; CODE XREF: Gfx_InterpolateScrollPosition+A   j
                addq.w  #4,(dword_FFA90C).w
                moveq   #1,d0
locret_1F73A:                                           ; CODE XREF: Gfx_InterpolateScrollPosition+8   j
                rts
; End of function Gfx_InterpolateScrollPosition
; Renders menu sprite graphics conditionally
Gfx_RenderMenuSprites:                                  ; CODE XREF: Stage_HandleTransition   p  ; was: sub_1F73C
                                        ; sub_1F1B2   p
                btst    #3,(word_FFA000+1).w
                bne.s   loc_1F746
                rts
; ---------------------------------------------------------------------------
loc_1F746:                                              ; CODE XREF: Gfx_RenderMenuSprites+6   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D4,(a1)+
                move.w  #$158,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D8,(a1)+
                move.w  #$178,(a1)+
                move.w  d0,(a1)+
                move.w  #$400,(a1)+
                move.w  #$C2DC,(a1)+
                move.w  #$198,(a1)+
                move.w  #$FFFF,(a1)+
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderMenuSprites
; Renders confirmation button sprites
Gfx_RenderConfirmSprites:                               ; CODE XREF: UI_WaitForButtonPress   p  ; was: sub_1F784
                btst    #3,(word_FFA000+1).w
                bne.s   loc_1F78E
                rts
; ---------------------------------------------------------------------------
loc_1F78E:                                              ; CODE XREF: Gfx_RenderConfirmSprites+6   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2DE,(a1)+
                move.w  #$164,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2E2,(a1)+
                move.w  #$184,(a1)+
                move.w  #$FFFF,(a1)+
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderConfirmSprites
; Updates palette color indices for animation
Gfx_UpdatePaletteIndices:                               ; CODE XREF: Stage_HandleTransition+4   p  ; was: sub_1F7BE
                                        ; UI_HandleMenuNavigation+4   p
                move.w  (dword_FF8134).w,d0
                bne.s   loc_1F7D0
                btst    #0,(word_FFA280+1).w
                bne.s   Gfx_WritePaletteColors
                addq.w  #2,d0
                bra.s   Gfx_WritePaletteColors
; ---------------------------------------------------------------------------
loc_1F7D0:                                              ; CODE XREF: Gfx_UpdatePaletteIndices+4   j
                subq.w  #2,(dword_FF8134).w
; Writes calculated palette colors to RAM
Gfx_WritePaletteColors:                                 ; CODE XREF: Gfx_UpdatePaletteIndices+C   j  ; was: loc_1F7D4
                                        ; Gfx_UpdatePaletteIndices+10   j
                andi.w  #$E,d0
                move.w  word_1F7E6(pc,d0.w),(word_FFE362).w
                move.w  word_1F7F6(pc,d0.w),(word_FFE364).w
                rts
; End of function Gfx_UpdatePaletteIndices
; ---------------------------------------------------------------------------
word_1F7E6:     dc.w    $400, $400, $400, $400, $400, $200, 0, $600
                                        ; DATA XREF: Gfx_UpdatePaletteIndices+1A   r
word_1F7F6:     dc.w    $EEE, $EEC, $ECA, $CA8, $A86, $864, $642, $EEE
                                        ; DATA XREF: Gfx_UpdatePaletteIndices+20   r
word_1F806:     dc.w    $200, $400, $622, $844, $A66, $C88, $CAA, $ACC, $8EE, $6CE
                                        ; DATA XREF: Gfx_Update3DPlanetEffect+52   r
word_1F81A:     dc.w    $48E, $24E, $2C, $A, 8, 6, 4, 2, 0, 0
                                        ; DATA XREF: Gfx_Update3DPlanetEffect+4C   r

; Updates 3D planet rotation and parallax effect
