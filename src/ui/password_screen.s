UI_InitPasswordScreen:                                  ; DATA XREF: Sys_DispatchGameState+9A   o  ; was: sub_A3A0
                tst.w   (GameSubstateIndex).w
                bne.s   UI_InitPasswordDisplay
                jsr     (Sys_InitGameMode).l
                movea.l #stru_A1F8,a0
                jsr     (LoadObjData).l
                jsr     (Sys_ClearEntityObjectPool).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp     Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
; Initializes password screen display with graphics data and palette loading
UI_InitPasswordDisplay:                                 ; CODE XREF: UI_InitPasswordScreen+4   j  ; was: loc_A3EA
                move.w  #$48,(GameModeIndex).w          ; 'H'
                clr.w   (GameSubstateIndex).w
                move.w  #$400,d0
                moveq   #0,d1
                jsr     (Data_LoadPointerTable2).l
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr     (Gfx_DirectVRAMTransfer).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                lea     word_A4AC(pc),a0
                nop
                movea.w #(byte_FFE322-M68K_RAM),a1
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                move.w  (a0),(a1)+
                move.w  (a0)+,(a2)+
                jsr     (Gfx_FadePaletteTransition).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                jsr     (Gfx_SetupScrollPlanes).l
                move.w  #$F4,d0
                move.w  #$DA,d1
                move.l  #$A394,d2
                bsr.w   UI_InitCursorSprite
                clr.w   (dword_FF8062+2).w
                clr.w   (dword_FF8066+2).w
                move.b  #$F,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
                clr.w   (word_FF806E).w
                lea     (byte_477C).l,a0
                move.w  #$A300,d0
                move.w  #$4A14,d4
                jsr     (UI_RenderTextStringWrapped).l
                rts
; End of function UI_InitPasswordScreen
; ---------------------------------------------------------------------------
word_A4AC:      dc.w    $20, $AEC, $8CA, $6A8, $486
                                        ; DATA XREF: UI_InitPasswordScreen+88   o

; Updates password screen with input processing and text rendering
UI_UpdatePasswordScreen:                                ; DATA XREF: Sys_DispatchGameState+9E   o  ; was: sub_A4B6
                bclr    #1,(word_FF80F4).w
                beq.s   loc_A4CE
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp     UI_ResetMenuBufferAndState_Clear
; ---------------------------------------------------------------------------
loc_A4CE:                                               ; CODE XREF: UI_UpdatePasswordScreen+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_A4EC
                btst    #7,(word_FFF708).w
                beq.s   loc_A4EC
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
loc_A4EC:                                               ; CODE XREF: UI_UpdatePasswordScreen+1C   j
                                        ; UI_UpdatePasswordScreen+24   j
                jsr     (Gfx_UpdateCursorFlash).l
                jsr     (Gfx_UpdateMenuPalette).l
                jsr     (Object_ApplyCameraMotion).l
                jsr     (Sys_InitObjectPointers).l
                jsr     (Sys_BeginVisibleObjectList).l
                bsr.w   UI_HandlePasswordInput
                movea.w #(word_FF9900-M68K_RAM),a0
                move.w  #$8300,d0
                move.w  #$4714,d4
                jsr     (UI_RenderTextStringWrapped).l
                movea.w #(byte_FF9980-M68K_RAM),a0
                move.w  #$8300,d0
                move.w  #$4814,d4
                jsr     (UI_RenderTextStringWrapped).l
                jsr     (Sys_ProcessVisibleObjects).l
                jsr     (Sys_UpdateObjectCount).l
                jsr     (Sys_ProcessObjectList).l
                jsr     (Gfx_FadePaletteTransition).l
                jmp     Gfx_SetupScrollPlanes
; End of function UI_UpdatePasswordScreen
; Handles password digit input and validation logic
UI_HandlePasswordInput:                                 ; CODE XREF: UI_UpdatePasswordScreen+54   p  ; was: sub_A550
                tst.w   (word_FF806E).w
                bne.w   loc_A6CE
                move.w  (dword_FF8066+2).w,d0
                moveq   #0,d1
                btst    #2,(word_FFF708).w
                beq.s   loc_A576
                moveq   #2,d1
                move.w  #$10,(dword_FF8062+2).w
                subq.w  #2,d0
                bpl.s   loc_A592
                moveq   #0,d0
                bra.s   loc_A5A4
; ---------------------------------------------------------------------------
loc_A576:                                               ; CODE XREF: UI_HandlePasswordInput+14   j
                btst    #3,(word_FFF708).w
                beq.s   loc_A5A4
                moveq   #2,d1
                move.w  #$10,(dword_FF8062+2).w
                addq.w  #2,d0
                cmpi.w  #$A,d0
                bmi.s   loc_A592
                moveq   #8,d0
                bra.s   loc_A5A4
; ---------------------------------------------------------------------------
loc_A592:                                               ; CODE XREF: UI_HandlePasswordInput+20   j
                                        ; UI_HandlePasswordInput+3C   j
                movem.l d0-d1,-(sp)
                move.b  #$DB,d0
                jsr     (Input_ProcessButtons).l
                movem.l (sp)+,d0-d1
loc_A5A4:                                               ; CODE XREF: UI_HandlePasswordInput+24   j
                                        ; UI_HandlePasswordInput+2C   j
                move.w  d0,(dword_FF8066+2).w
                move.w  d1,(word_FF806E).w
                move.l  #word_A394,(dword_FFC628).w
                cmpi.w  #8,d0
                beq.w   loc_A716
                lea     byte_A8F6(pc),a0
                nop
                bsr.w   UI_SetPasswordRow1Buffer
                bsr.w   UI_RenderPasswordText
                move.b  (word_FFF706).w,d0
                andi.b  #$F,d0
                cmp.b   (dword_FF806A).w,d0
                bne.s   loc_A5DE
                subq.w  #1,(dword_FF806A+2).w
                bra.s   loc_A5E8
; ---------------------------------------------------------------------------
loc_A5DE:                                               ; CODE XREF: UI_HandlePasswordInput+86   j
                move.b  d0,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
loc_A5E8:                                               ; CODE XREF: UI_HandlePasswordInput+8C   j
                moveq   #0,d0
                movea.w #(word_FFF708-M68K_RAM),a1
                tst.w   (dword_FF806A+2).w
                bpl.s   loc_A606
                move.w  #$FFFF,(dword_FF806A+2).w
                movea.w #(word_FFF706-M68K_RAM),a1
                btst    #0,(word_FFA280+1).w
                beq.s   loc_A630
loc_A606:                                               ; CODE XREF: UI_HandlePasswordInput+A2   j
                btst    #0,(a1)
                beq.s   loc_A61C
                moveq   #$FFFFFFFF,d0
                cmpa.w  #$F708,a1
                bne.s   loc_A630
                move.w  #$A,(dword_FF8062+2).w
                bra.s   loc_A630
; ---------------------------------------------------------------------------
loc_A61C:                                               ; CODE XREF: UI_HandlePasswordInput+BA   j
                btst    #1,(a1)
                beq.s   loc_A630
                moveq   #1,d0
                cmpa.w  #$F708,a1
                bne.s   loc_A630
                move.w  #$A,(dword_FF8062+2).w
loc_A630:                                               ; CODE XREF: UI_HandlePasswordInput+B4   j
                                        ; UI_HandlePasswordInput+C2   j
                move.w  (dword_FF8066+2).w,d4
                movea.w #(word_FFFF38+1-M68K_RAM),a0
loc_A638:                                               ; CODE XREF: UI_HandlePasswordInput+EC   j
                addq.w  #1,a0
                subq.w  #2,d4
                bpl.s   loc_A638
                move.b  (a0),d1
                add.w   d0,d1
                move.b  d1,(a0)
                movea.w #(dword_FFFF3A-M68K_RAM),a0
                move.b  (a0),d0
                bne.s   loc_A64E
                moveq   #1,d0
loc_A64E:                                               ; CODE XREF: UI_HandlePasswordInput+FA   j
                cmpi.b  #$A,d0
                bmi.s   loc_A656
                moveq   #$A,d0
loc_A656:                                               ; CODE XREF: UI_HandlePasswordInput+102   j
                move.b  d0,(a0)+
                move.b  (a0),d1
                bne.s   loc_A65E
                moveq   #1,d1
loc_A65E:                                               ; CODE XREF: UI_HandlePasswordInput+10A   j
                cmpi.b  #$A,d1
                bmi.s   loc_A666
                moveq   #$A,d1
loc_A666:                                               ; CODE XREF: UI_HandlePasswordInput+112   j
                move.b  d1,(a0)+
                move.b  (a0),d2
                bne.s   loc_A66E
                moveq   #1,d2
loc_A66E:                                               ; CODE XREF: UI_HandlePasswordInput+11A   j
                cmpi.b  #$A,d2
                bmi.s   loc_A676
                moveq   #$A,d2
loc_A676:                                               ; CODE XREF: UI_HandlePasswordInput+122   j
                move.b  d2,(a0)+
                move.b  (a0),d3
                bne.s   loc_A67E
                moveq   #1,d3
loc_A67E:                                               ; CODE XREF: UI_HandlePasswordInput+12A   j
                cmpi.b  #$A,d3
                bmi.s   loc_A686
                moveq   #$A,d3
loc_A686:                                               ; CODE XREF: UI_HandlePasswordInput+132   j
                move.b  d3,(a0)+
                movea.w #(word_FF9800-M68K_RAM),a0
                move.b  d0,(a0)+
                move.b  #0,(a0)+
                move.b  d1,(a0)+
                move.b  #0,(a0)+
                move.b  d2,(a0)+
                move.b  #0,(a0)+
                move.b  d3,(a0)+
                move.b  #0,(a0)+
                move.b  #$2E,(a0)+                      ; '.'
                move.b  #0,(a0)+
                move.b  #$1D,(a0)+
                move.b  #$F,(a0)+
                move.b  #$1E,(a0)+
                move.b  #$FF,(a0)+
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$A300,d0
                move.w  #$451C,d4
                jmp     (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_A6CE:                                               ; CODE XREF: UI_HandlePasswordInput+4   j
                movea.l #word_A70C,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a1
                move.w  (dword_FF8066+2).w,d0
                clr.w   d2
                move.w  (a0,d0.w),d1
                sub.w   $10(a1),d1
                bmi.s   loc_A6F4
                cmpi.w  #4,d1
                bmi.s   loc_A6FA
                addq.w  #4,$10(a1)
                rts
; ---------------------------------------------------------------------------
loc_A6F4:                                               ; CODE XREF: UI_HandlePasswordInput+196   j
                cmpi.w  #$FFFC,d1
                bmi.s   loc_A706
loc_A6FA:                                               ; CODE XREF: UI_HandlePasswordInput+19C   j
                move.w  (a0,d0.w),$10(a1)
                clr.w   (word_FF806E).w
                rts
; ---------------------------------------------------------------------------
loc_A706:                                               ; CODE XREF: UI_HandlePasswordInput+1A8   j
                subq.w  #4,$10(a1)
locret_A70A:                                            ; CODE XREF: UI_HandlePasswordInput+1DE   j
                rts
; ---------------------------------------------------------------------------
word_A70C:      dc.w    $F4, $104, $114, $124, $14C
                                        ; DATA XREF: UI_HandlePasswordInput:loc_A6CE   o
; ---------------------------------------------------------------------------
loc_A716:                                               ; CODE XREF: UI_HandlePasswordInput+68   j
                move.l  #word_A39A,(dword_FFC628).w
                move.b  #$F,(dword_FF806A).w
                move.w  #$18,(dword_FF806A+2).w
                tst.w   (word_FF806E).w
                bne.s   locret_A70A
                move.l  (dword_FFFF3A).w,d0
                moveq   #0,d4
                moveq   #1,d5
                lea     word_A82A(pc),a0
                nop
loc_A73E:                                               ; CODE XREF: UI_HandlePasswordInput+204   j
                addq.b  #1,d4
                cmpi.w  #$FFFF,(a0)
                beq.w   loc_A7DC
                moveq   #0,d3
                cmp.l   (a0)+,d0
                beq.s   loc_A756
                moveq   #2,d3
                cmp.l   (a0)+,d0
                beq.s   loc_A756
                bne.s   loc_A73E
loc_A756:                                               ; CODE XREF: UI_HandlePasswordInput+1FC   j
                                        ; UI_HandlePasswordInput+202   j
                move.w  d3,(word_FF805C).w
                move.w  d4,(dword_FF805E).w
                lea     byte_A91C(pc),a0
                nop
                move.w  (word_FF805C).w,d0
                beq.s   loc_A770
                lea     byte_A95A(pc),a0
                nop
loc_A770:                                               ; CODE XREF: UI_HandlePasswordInput+218   j
                bsr.w   UI_SetPasswordRow1Buffer
                lea     byte_A932(pc),a0
                nop
                bsr.w   UI_RenderPasswordText
                move.w  (dword_FF805E).w,d0
                lea     (word_5A43E).l,a0
                asl.w   #1,d0
                move.w  (a0,d0.w),d0
                move.b  d0,d1
                asr.b   #4,d1
                addq.w  #1,d0
                addq.w  #1,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                move.b  d0,(byte_FF9907).w
                move.b  d1,(byte_FF9906).w
                btst    #5,(word_FFF708).w
                beq.s   locret_A7DA
                move.w  (dword_FF805E).w,d0
                subq.w  #1,d0
                asl.w   #1,d0
                move.w  d0,(StageTableIndex).w
                move.w  (word_FF805C).w,(word_FFFF0E).w
                move.b  #$AD,d0
                jsr     (Input_ProcessButtons).l
                move.w  #$70,(GameModeIndex).w          ; 'p'
                clr.w   (GameSubstateIndex).w
                jmp     UI_SetPasswordConfirmFlag
; ---------------------------------------------------------------------------
locret_A7DA:                                            ; CODE XREF: UI_HandlePasswordInput+25C   j
                                        ; UI_HandlePasswordInput+2A0   j
                rts
; ---------------------------------------------------------------------------
loc_A7DC:                                               ; CODE XREF: UI_HandlePasswordInput+1F4   j
                lea     byte_A909(pc),a0
                nop
                bsr.w   UI_SetPasswordRow1Buffer
                bsr.w   UI_RenderPasswordText
                btst    #5,(word_FFF708).w
                beq.s   locret_A7DA
                move.b  #$BB,d0
                jmp     (Input_ProcessButtons).l
; End of function UI_HandlePasswordInput
; Sets text buffer pointer to first password display row
UI_SetPasswordRow1Buffer:                               ; CODE XREF: UI_HandlePasswordInput+72   p  ; was: sub_A7FC
                                        ; sub_A550:loc_A770   p
                movea.w #(word_FF9900-M68K_RAM),a1
                bra.s   loc_A806
; End of function UI_SetPasswordRow1Buffer
; Renders password text string to specified buffer
UI_RenderPasswordText:                                  ; CODE XREF: UI_HandlePasswordInput+76   p  ; was: sub_A802
                                        ; UI_HandlePasswordInput+22A   p
                movea.w #(byte_FF9980-M68K_RAM),a1
loc_A806:                                               ; CODE XREF: UI_SetPasswordRow1Buffer+4   j
                movea.w a1,a2
                moveq   #0,d0
                moveq   #$17,d7
loc_A80C:                                               ; CODE XREF: UI_RenderPasswordText+C   j
                move.b  d0,(a2)+
                dbf     d7,loc_A80C
                move.b  #$FF,(a2)
                moveq   #0,d0
                move.b  (a0)+,d0
                adda.w  d0,a1
; Parses next character from password string until FF terminator
UI_ParsePasswordChar:                                   ; CODE XREF: UI_RenderPasswordText+24   j  ; was: loc_A81C
                move.b  (a0)+,d0
                cmpi.b  #$FF,d0
                beq.s   locret_A828
                move.b  d0,(a1)+
                bra.s   UI_ParsePasswordChar
; ---------------------------------------------------------------------------
locret_A828:                                            ; CODE XREF: UI_RenderPasswordText+20   j
                rts
; End of function UI_RenderPasswordText
; ---------------------------------------------------------------------------
word_A82A:      dc.w    $20A, $906, $20A, $906, $407, $A09, $407, $A09, $103, $608
                                        ; DATA XREF: UI_HandlePasswordInput+1E8   o
                                        ; UI_RenderContinueText+1A   o
                dc.w    $103, $608, $408, $506, $408, $506, $806, $602, $806, $602
                dc.w    $908, $A01, $908, $A01, $602, $A07, $602, $A07, $506, $70A
                dc.w    $506, $70A, $901, $A02, $901, $A02, $904, $207, $904, $207
                dc.w    $705, $103, $705, $103, $A09, $805, $A09, $805, $20A, $401
                dc.w    $20A, $401, $307, $304, $307, $304, $704, $906, $704, $906
                dc.w    $808, $50A, $808, $50A, $403, $809, $403, $809, $201, $40A
                dc.w    $201, $40A, $A01, $103, $A01, $103, $309, $809, $309, $809
                dc.w    $409, $A05, $409, $A05, $50A, $204, $50A, $204, $309, $603
                dc.w    $309, $603, $805, $107, $805, $107, $603, $90A, $603, $90A
                dc.w    $FFFF, $FFFF
byte_A8F6:      dc.b    3, $13, $18, $1A, $1F, $1E, 0, $1A, $B
                                        ; DATA XREF: UI_HandlePasswordInput+6C   o
                dc.b    $1D, $1D, $21, $19, $1C, $E, $FF, 3, 0
                dc.b    $FF
byte_A909:      dc.b    3, $1A, $B, $1D, $1D, $21, $19, $1C, $E
                                        ; DATA XREF: UI_HandlePasswordInput:loc_A7DC   o
                dc.b    0, $F, $1C, $1C, $19, $1C, $FF, 0, 0
                dc.b    $FF
byte_A91C:      dc.b    0, $1D, $1E, $B, $11, $F, $2E, 0, 0
                                        ; DATA XREF: UI_HandlePasswordInput+20E   o
                dc.b    0, 0, $16, $F, $20, $F, $16, $2E, $F
                dc.b    $B, $1D, $23, $FF
byte_A932:      dc.b    3, $1A, $1C, $F, $1D, $1D, 0, $D, 0, $C
                                        ; DATA XREF: UI_HandlePasswordInput+224   o
                dc.b    $1F, $1E, $1E, $19, $18, $FF, 0, $1D, $1E, $B
                dc.b    $11, $F, $2E, 0, 0, 0, 0, $16, $F, $20
                dc.b    $F, $16, $2E, $18, $19, $1C, $17, $B, $16, $FF
byte_A95A:      dc.b    0, $1D, $1E, $B, $11, $F, $2E, 0, 0
                                        ; DATA XREF: UI_HandlePasswordInput+21A   o
                dc.b    0, 0, $16, $F, $20, $F, $16, $2E, $12
                dc.b    $B, $1C, $E, $FF

; Player behavior state dispatcher
