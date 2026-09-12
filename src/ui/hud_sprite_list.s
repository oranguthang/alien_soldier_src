; Builds the shared HUD sprite list and optional diagnostic markers
UI_BuildHUDSpriteList:                                  ; CODE XREF: Sys_GameplayMainLoop:Sys_GameplayMainLoop_BuildHUDSprites   p  ; was: sub_13278
                                        ; sub_1E8F6   p
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
UI_AppendHUDSpriteList:                                 ; CODE XREF: DebugMenu_UpdateAndDispatch+C   p  ; was: loc_13280
                tst.b   (byte_FFF705).w
                bpl.w   UI_AppendHUDSpriteList_AppendBaseIndicator
                btst    #0,(byte_FFF705).w
                beq.w   UI_AppendHUDSpriteList_AppendBaseIndicator
                btst    #4,(word_FFF706).w
                bne.w   UI_AppendHUDSpriteList_AppendBaseIndicator
                tst.w   (DifficultyMode).w
                bne.s   UI_AppendHUDSpriteList_SelectModeEntries
                btst    #2,(word_FFF708).w
                beq.s   UI_AppendHUDSpriteList_CheckFrameSkipIncrease
                subq.w  #1,(word_FFFF3E).w
                bpl.s   UI_AppendHUDSpriteList_SelectModeEntries
                clr.w   (word_FFFF3E).w
UI_AppendHUDSpriteList_CheckFrameSkipIncrease:          ; CODE XREF: UI_BuildHUDSpriteList+30   j  ; was: loc_132B4
                btst    #3,(word_FFF708).w
                beq.s   UI_AppendHUDSpriteList_SelectModeEntries
                addq.w  #1,(word_FFFF3E).w
                cmpi.w  #4,(word_FFFF3E).w
                bmi.s   UI_AppendHUDSpriteList_SelectModeEntries
                move.w  #3,(word_FFFF3E).w
UI_AppendHUDSpriteList_SelectModeEntries:               ; CODE XREF: UI_BuildHUDSpriteList+28   j  ; was: loc_132CE
                                        ; UI_BuildHUDSpriteList+36   j
                btst    #1,(VBlankFrameCounter+1).w
                bne.w   UI_AppendHUDSpriteList_AppendAlternateModeEntries
                move.w  #$A2,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7F9,(a1)+
                move.w  #$194,(a1)+
                move.w  #$A2,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7FD,(a1)+
                move.w  #$1B4,(a1)+
                bra.s   UI_AppendHUDSpriteList_AppendBaseIndicator
; ---------------------------------------------------------------------------
UI_AppendHUDSpriteList_AppendAlternateModeEntries:      ; CODE XREF: UI_BuildHUDSpriteList+5C   j  ; was: loc_132FA
                tst.w   (DifficultyMode).w
                bne.s   UI_AppendHUDSpriteList_AppendBaseIndicator
                move.w  #$150,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7D8,(a1)+
                move.w  #$10C,(a1)+
                move.w  (word_FFFF3E).w,d1
                andi.w  #3,d1
                subq.w  #1,d1
                bmi.s   UI_AppendHUDSpriteList_AppendBaseIndicator
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$12C,(a1)+
                subq.w  #1,d1
                bmi.s   UI_AppendHUDSpriteList_AppendBaseIndicator
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$134,(a1)+
                subq.w  #1,d1
                bmi.s   UI_AppendHUDSpriteList_AppendBaseIndicator
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$13C,(a1)+
UI_AppendHUDSpriteList_AppendBaseIndicator:             ; CODE XREF: UI_BuildHUDSpriteList+C   j  ; was: loc_13350
                                        ; UI_BuildHUDSpriteList+16   j
                move.w  #$80,(a1)+
                move.w  #$B00,(a1)+
                move.w  #$C6F0,(a1)+
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   UI_AppendHUDSpriteList_UseFixedIndicatorValue
                tst.b   (MessageDisplayFlags).w
                beq.s   UI_AppendHUDSpriteList_UseSelectedIndicatorValue
UI_AppendHUDSpriteList_UseFixedIndicatorValue:          ; CODE XREF: UI_BuildHUDSpriteList+EA   j  ; was: loc_1336A
                move.w  #1,(a1)+
                bra.s   UI_AppendHUDSpriteList_AppendCommonEntry
; ---------------------------------------------------------------------------
UI_AppendHUDSpriteList_UseSelectedIndicatorValue:       ; CODE XREF: UI_BuildHUDSpriteList+F0   j  ; was: loc_13370
                lea     UI_WeaponIndicatorXTable(pc),a2
                nop
                move.w  (WeaponSlotOffset).w,d1
                move.w  (a2,d1.w),(a1)+
UI_AppendHUDSpriteList_AppendCommonEntry:               ; CODE XREF: UI_BuildHUDSpriteList+F6   j  ; was: loc_1337E
                move.w  #$80,(a1)+
                move.w  #$300,(a1)+
                move.w  d0,(a1)+
                clr.w   (a1)+
                move.w  (HUDDynamicStripTileAttr).w,d2
                beq.s   UI_SubmitHUDSpriteList
                tst.w   (HUDDynamicStripYOffset).w
                bpl.s   UI_AppendHUDSpriteList_AppendDynamicStrip
                clr.w   (HUDDynamicStripTileAttr).w
                clr.w   (HUDDynamicStripYOffset).w
                bra.s   UI_SubmitHUDSpriteList
; ---------------------------------------------------------------------------
UI_AppendHUDSpriteList_AppendDynamicStrip:              ; CODE XREF: UI_BuildHUDSpriteList+11C   j  ; was: loc_133A0
                move.w  #$A0,d0
                move.w  #$700,d1
                move.w  #$60,d3                         ; '`'
                add.w   (HUDDynamicStripYOffset).w,d3
                moveq   #5,d7
UI_AppendHUDSpriteList_DynamicStripLoop:                ; CODE XREF: UI_BuildHUDSpriteList+146   j  ; was: loc_133B2
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                move.w  d2,(a1)+
                move.w  d3,(a1)+
                addi.w  #$20,d0                         ; ' '
                dbf     d7,UI_AppendHUDSpriteList_DynamicStripLoop
; Terminates and submits the HUD sprite list
UI_SubmitHUDSpriteList:                                 ; CODE XREF: UI_BuildHUDSpriteList+116   j  ; was: loc_133C2
                                        ; UI_BuildHUDSpriteList+126   j
                move.w  #$FFFF,(a1)
                jmp     (Sprite_AppendOAMEntries).l
; End of function UI_BuildHUDSpriteList
; ---------------------------------------------------------------------------
UI_WeaponIndicatorXTable:   dc.w    $160, $178, $190, $1A8  ; was: word_133CC
                                        ; DATA XREF: UI_BuildHUDSpriteList:UI_AppendHUDSpriteList_UseSelectedIndicatorValue   o
