UI_InitializeWeaponSelect:                              ; DATA XREF: Sys_DispatchGameState+8A   o  ; was: sub_1E264
                tst.w   (GameSubstateIndex).w
                bne.s   UI_WeaponSelectTransition
                jsr     (Sys_InitGameMode).l
                jsr     (Sys_ClearEntityObjectPool).l
                bra.w   UI_QueuePendingBGMAndTransitionToStageLoad
; End of function UI_InitializeWeaponSelect
; Prepares weapon select graphics
UI_PrepareWeaponSelectGfx:
                bclr    #6,(VDPReg1Shadow+1).w          ; was: sub_1E27A
                clr.b   (PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$6000,(word_FF8146).w
                move.w  #$F,(word_FF8148).w
                move.w  #0,(word_FF814A).w
                lea     (stru_1E012).l,a0
                jmp     (Data_ProcessPointer).l
; End of function UI_PrepareWeaponSelectGfx
; Handles weapon select transition
UI_WeaponSelectTransition:                              ; CODE XREF: UI_InitializeWeaponSelect+4   j  ; was: sub_1E2A6
                cmpi.w  #4,(GameSubstateIndex).w
                beq.s   loc_1E2C6
                tst.b   (word_FFF720).w
                bmi.w   locret_1E40A
                jsr     (Gfx_QueueNextFontTileDMA).l
                bpl.w   locret_1E40A
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1E2C6:                                              ; CODE XREF: UI_WeaponSelectTransition+6   j
                move.w  #$38,(GameModeIndex).w          ; '8'
                clr.w   (GameSubstateIndex).w
                move.b  (byte_FFA230).w,d0
                beq.s   loc_1E2DC
                jsr     (Sound_QueueBGMOrStop).l
loc_1E2DC:                                              ; CODE XREF: UI_WeaponSelectTransition+2E   j
                lea     off_1E334(pc),a0
                nop
                jsr     (Palette_LoadFourOptionalBlocks).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr     (Gfx_FadePaletteTransition).l
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #0,(VDPReg18Shadow+1).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                bsr.w   UI_RenderMenuText
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jmp     Scroll_PreparePlaneBuffersAndRegisterShadows
; End of function UI_WeaponSelectTransition
; ---------------------------------------------------------------------------
off_1E334:      dc.l    dword_1E344                     ; DATA XREF: UI_WeaponSelectTransition:loc_1E2DC   o
                dc.l    dword_1E344
                dc.l    dword_1E344
                dc.l    dword_1E344
dword_1E344:    dc.l    0, $CAA0A88, $8660644, 0
                                        ; DATA XREF: ROM:off_1E334   o
                                        ; ROM:0001E338   o
                dc.l    0, $8660644, $4220000, 0

; Manages menu text and transition
UI_HandleMenuTextTransition:                            ; DATA XREF: Sys_DispatchGameState+8E   o  ; was: sub_1E364
                tst.b   (word_FFF720).w
                bmi.w   locret_1E3D4
                tst.w   (GameSubstateIndex).w
                beq.s   loc_1E38E
                btst    #7,(word_FFF708).w
                beq.s   loc_1E38E
                clr.w   (GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
loc_1E38E:                                              ; CODE XREF: UI_HandleMenuTextTransition+C   j
                                        ; UI_HandleMenuTextTransition+14   j
                move.l  (dword_FFA22C).w,d0
                beq.s   loc_1E3C2
                movea.l d0,a0
                moveq   #0,d4
                move.b  (a0)+,d4
                asl.w   #7,d4
                addi.w  #$400C,d4
                move.w  #$C300,d0
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                asr.w   #1,d3
                addq.w  #2,d3
                ext.l   d3
                add.l   d3,(dword_FFA22C).w
                movea.l (dword_FFA22C).w,a0
                cmpi.b  #$FD,(a0)
                bne.s   loc_1E3C2
                clr.l   (dword_FFA22C).w
loc_1E3C2:                                              ; CODE XREF: UI_HandleMenuTextTransition+2E   j
                                        ; UI_HandleMenuTextTransition+58   j
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1E3D6
                addq.w  #2,(GameSubstateIndex).w
locret_1E3D4:                                           ; CODE XREF: UI_HandleMenuTextTransition+4   j
                                        ; UI_HandleMenuTextTransition+78   j
                rts
; ---------------------------------------------------------------------------
loc_1E3D6:                                              ; CODE XREF: UI_HandleMenuTextTransition+6A   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1E3D4
; Transitions from menu to stage loading
UI_TransitionToStageLoad:                               ; CODE XREF: UI_QueuePendingBGMAndTransitionToStageLoad:UI_TransitionAfterOptionalStageBGM   j  ; was: loc_1E3DE
                                        ; Stage_HandleCreditsOrAdvance+32   j
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jsr     (Weapon_CommitStateTransition).l
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                move.w  (StageTableIndex).w,d0
                asr.b   #1,d0
                move.b  byte_1E40C(pc,d0.w),(dword_FF80C8).w
                clr.b   (byte_FFA272).w
                jsr     (Stage_LoadAssetsForCurrentTableIndex).l
locret_1E40A:                                           ; CODE XREF: UI_WeaponSelectTransition+C   j
                                        ; UI_WeaponSelectTransition+16   j
                rts
; End of function UI_HandleMenuTextTransition
; ---------------------------------------------------------------------------
byte_1E40C:     dc.b    $18, 0, 0                       ; DATA XREF: UI_HandleMenuTextTransition+96   r
                dc.b    0, $18, 0
                dc.b    0, $18, 0
                dc.b    $18, 0, 0
                dc.b    0, $18, 0
                dc.b    0, 0, $18
                dc.b    0, 0, 0
                dc.b    0, 0, 0
                dc.b    0, 0, 0
                dc.b    0, 0, 0
                dc.b    0, 0, 0
                dc.b    0, 0, 0

; Renders static menu text
UI_RenderMenuText:                                      ; CODE XREF: UI_WeaponSelectTransition+74   p  ; was: sub_1E430
                lea     (Text_PressStart).l,a0
                move.w  #$C100,d0
                move.w  #$4B9E,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; End of function UI_RenderMenuText
; ---------------------------------------------------------------------------
byte_1E444:     dc.b    3, $DA, 0, $58, $79, $42, $36, $3F, $34, $43, $39, 0, $3E, $3B, $42, $D8
                                        ; DATA XREF: Sys_UpdateGameplayLoop+7A   o
                dc.b    $D8, $D8, 0, $DA, $FF, 6, $31, $4E, $D8, $30, $31, $3C, $6F, $36, 0, $9E  ; text?
                dc.b    $84, $AB, $3D, $31, $63, $5C, $3F, $40, $5D, $30, $6E, $44, $31, $DB, $DB, $FF
                dc.b    8, $61, $37, $30, $37, $4A, $6B, $32, $48, $91, $A6, $A3, $8B, $92, $AE, $A4
                dc.b    $DA, $C2, $D8, $FF, $A, $DE, $7F, $94, $9D, $A4, $AD, $C5, $AB, $AE, $DF, $48
                dc.b    0, $67, $31, $3B, $5C, $54, $76, $37, $45, $FF, $C, $36, $78, $32, $4B, $43
                dc.b    $35, $44, $3B, $4F, $5D, 0, $39, $67, $4E, $3C, $55, $D8, $D8, $D8, $FF, $F
                dc.b    $36, $76, $41, $53, $48, $3E, $5C, $62, $31, $E2, 0, $59, $55, $3B, $42, $49
                dc.b    $34, $38, $44, $31, $DB, $DB, $FF, $11, $3A, $30, $82, $80, $A3, $7F, $AB, $8D
                dc.b    $A4, $B2, $C5, $DA, $DB, $DB, 0, $30, $6C, $56, $42, $39, $31, $DB, $DB, $FF
                dc.b    $FD
byte_1E4E5:     dc.b    3, $DA, 0, $3B, $48, $6D, $5A, $55, $6D, $78, $32, $4E, 0, $58, $5D, $42
                                        ; DATA XREF: Stage_CheckTransitionReady+E   o
                                        ; Stage_PostXiTigerTransition+16   o
                dc.b    $D8, $D8, $D8, 0, $DA, $FF, 6, $3F, $3F, $35, $31, $49, $D8, $9E, $84, $AB
                dc.b    $39, $37, $3A, $31, $37, $32, $39, $32, $4C, $43, $FF, 8, $3E, $48, $BD, $8E
                dc.b    $80, $E2, 0, $32, $41, $3C, $D9, $FF, $A, $82, $80, $A3, $7F, $AB, $8D, $A4
                dc.b    $B2, $C5, $DA, $5D, $D8, $40, $35, $64, $31, $42, $31, $55, $3F, $51, $FF, $C
                dc.b    $42, $36, $48, 0, $3F, $31, $3B, $78, $32, $DE, $AA, $AB, $B6, $BB, $DF, $5D
                dc.b    $D8, $4A, $39, $32, $36, $6A, $FF, $E, $B3, $A2, $35, $57, $32, $79, $42, 0
                dc.b    $98, $A2, $53, $3B, $31, $D9, $FF, $11, $DE, $A7, $A6, $81, $D8, $3E, $32, $49
                dc.b    $31, $35, $47, $33, $DB, $DB, $DF, $FF, $13, $3E, $48, $43, $36, $D8, $84, $A5
                dc.b    $48, $3D, $44, $35, $45, 0, $94, $BD, $31, $80, $8E, $9E, $5D, $D8, $D8, $D8
                dc.b    $FF, $FD
byte_1E587:     binclude "data/other/byte_1E587.bin"
byte_1E587_End:
byte_1E6C6:     dc.b    3, $DA, 0, $39, $32, $6B, $31, $40, $4E, $5C, $A0, $DA, $92, $A4, $48, 0
                                        ; DATA XREF: Stage_PostFlyingNeoTransition+E   o
                dc.b    $A7, $BF, $81, 0, $DA, $FF, 6, $3A, $7A, $D8, $48, $39, $55, $49, 0, $7F
                dc.b    $94, $9D, $A4, $AD, $C5, $AB, $AE, $48, $BA, $AB, $D8, $FF, 8, $AA, $AB, $B6
                dc.b    $BB, $E2, 0, $3F, $34, $3C, $67, $38, $DB, $DB, $FF, $B, $63, $6B, $32, $3E
                dc.b    $32, $63, $77, $32, $48, 0, $4A, $39, $32, $36, $48, 0, $32, $33, $49, $FF
                dc.b    $D, $3A, $50, $31, $5D, $D8, $AA, $AB, $B6, $BB, $43, $82, $80, $A3, $7F, $AB
                dc.b    $8D, $A4, $B2, $C5, $DA, $48, $FF, $F, $45, $53, $4F, $30, $31, $49, 0, $47
                dc.b    $79, $36, $9F, $AB, $9F, $AB, $67, $DB, $DB, $FF, $12, $3B, $35, $3B, $D8, $3E
                dc.b    $48, $32, $3B, $57, $35, $53, 0, $63, $76, $30, $37, $6A, $36, $78, $67, $31
                dc.b    $44, $FF, $14, $84, $AF, $5D, $D8, $40, $35, $64, $36, $41, $41, $30, $79, $3F
                dc.b    $D8, $D8, $D8, $FF, $FD, $FF

; Initializes stage transition fade
