UI_SetupScoreDMA:                                       ; CODE XREF: UI_RenderHUDElement1:loc_12C56   p  ; was: sub_133D4
                                        ; sub_134E2   p
                move.w  (word_FFA21E).w,d0
                beq.s   locret_13428
                cmpi.w  #1,d0
                beq.s   locret_13428
                move.w  #1,(word_FFA21E).w
                movea.w #(byte_FF8488-M68K_RAM),a5
                move.w  #$82,-(a5)
                move.w  #$7400,-(a5)
                lea     off_1342A(pc),a0
                nop
                subq.w  #4,d0
                move.l  (a0,d0.w),d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.b  d2,-(a5)
                move.b  #$97,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94029300,-(a5)
locret_13428:                                           ; CODE XREF: UI_SetupScoreDMA+4   j
                                        ; UI_SetupScoreDMA+A   j
                rts
; End of function UI_SetupScoreDMA
; ---------------------------------------------------------------------------
off_1342A:      dc.l    sprite_FD30E                    ; DATA XREF: UI_SetupScoreDMA+1E   o
                dc.l    sprite_FD62E
                dc.l    sprite_FE78E
                dc.l    sprite_FE78E
                dc.l    sprite_FD86E
                dc.l    sprite_FD86E
                dc.l    sprite_FD86E
                dc.l    sprite_FD86E

; Sets up VDP DMA transfer registers
Gfx_SetupVDPDMA:                                        ; CODE XREF: Weapon_UpdateState12Icon+4C   j  ; was: sub_1344A
                move.w  #1,(word_FFA21E).w
                movea.w #(byte_FF8488-M68K_RAM),a0
                move.w  #$82,-(a0)
                move.w  #$7400,-(a0)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a0)
                move.b  #$95,-(a0)
                move.b  d2,-(a0)
                move.b  #$96,-(a0)
                move.b  d3,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  d1,-(a0)
                rts
; End of function Gfx_SetupVDPDMA
; Updates status display based on current mode
UI_UpdateStatusDisplay:
                move.w  #$5200,d2                       ; was: sub_13488
                move.w  (word_FF820C).w,d0
                movea.w off_1349C(pc,d0.w),a0
                adda.l  #UI_StatusEmptyHandler,a0
                jmp     (a0)
; End of function UI_UpdateStatusDisplay
; ---------------------------------------------------------------------------
off_1349C:      dc.w    UI_StatusEmptyHandler-UI_StatusEmptyHandler
                                        ; DATA XREF: UI_UpdateStatusDisplay+8   r
                dc.w    UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w    UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w    UI_StatusEmptyHandler-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler
                dc.w    UI_CycleDisplayMode-UI_StatusEmptyHandler

; Empty UI status display handler
UI_StatusEmptyHandler:                                  ; DATA XREF: UI_UpdateStatusDisplay+C   o  ; was: nullsub_34
                                        ; ROM:off_1349C   o
                rts
; End of function UI_StatusEmptyHandler
; ---------------------------------------------------------------------------
word_134B6:     dc.w    $5200, $5280, $5300, $5380, $5210, $5290, $5310, $5390
                                        ; DATA XREF: UI_CycleDisplayMode+2   r

; Cycles through display modes and updates VDP
UI_CycleDisplayMode:                                    ; DATA XREF: ROM:000134A4   o  ; was: sub_134C6
                                        ; ROM:000134A6   o
                subq.w  #8,d0
                move.w  word_134B6(pc,d0.w),d2
                addq.w  #2,(word_FF820C).w
                andi.w  #6,d0
                addq.w  #2,d0
                cmpi.w  #8,d0
                bmi.s   locret_134E0
                clr.w   (word_FF820C).w
locret_134E0:                                           ; CODE XREF: UI_CycleDisplayMode+14   j
                rts
; End of function UI_CycleDisplayMode
; Renders debug menu with score display
UI_RenderDebugMenu:                                     ; CODE XREF: UI_RenderHUDElement1+52   j  ; was: sub_134E2
                bsr.w   UI_SetupScoreDMA
                movea.w #(byte_FFA108-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                bsr.w   UI_AppendHUDSpriteList
                move.b  (word_FFF708).w,d0
                andi.b  #$4F,d0                         ; 'O'
                cmp.b   (byte_FF866A).w,d0
                beq.s   loc_1350A
                move.b  d0,(byte_FF866A).w
                move.w  #$C,(word_FF866C).w
loc_1350A:                                              ; CODE XREF: UI_RenderDebugMenu+1C   j
                subq.w  #1,(word_FF866C).w
                bpl.s   loc_13514
                clr.w   (word_FF866C).w
loc_13514:                                              ; CODE XREF: UI_RenderDebugMenu+2C   j
                move.w  (word_FF8226).w,d0
                movea.w off_13524(pc,d0.w),a0
                adda.l  #UI_InitDebugMenuState,a0
                jmp     (a0)
; End of function UI_RenderDebugMenu
; ---------------------------------------------------------------------------
off_13524:      dc.w    locret_1356C-UI_InitDebugMenuState
                                        ; DATA XREF: UI_RenderDebugMenu+36   r
                dc.w    UI_InitDebugMenuState-UI_InitDebugMenuState
                dc.w    UI_UpdateDebugMenu-UI_InitDebugMenuState

; Initializes debug menu state and loads data
UI_InitDebugMenuState:                                  ; DATA XREF: UI_RenderDebugMenu+3A   o  ; was: sub_1352A
                                        ; ROM:off_13524   o
                tst.w   (word_FFF720).w
                bmi.s   locret_1356C
                clr.w   (word_FF8660).w
                clr.w   (word_FF8664).w
                clr.w   (word_FF8666).w
                clr.w   (word_FF8668).w
                move.w  #4,(word_FF8662).w
                move.w  (word_FFA216).w,d0
                asr.w   #4,d0
                move.b  d0,(byte_FF866B).w
                tst.w   (word_FF822A).w
                beq.s   loc_1355C
                move.b  #$FF,(byte_FF866B).w
loc_1355C:                                              ; CODE XREF: UI_InitDebugMenuState+2A   j
                addq.w  #2,(word_FF8226).w
                movea.l #stru_1356E,a0
                jmp     (LoadObjData).l
; ---------------------------------------------------------------------------
locret_1356C:                                           ; CODE XREF: UI_InitDebugMenuState+4   j
                                        ; DATA XREF: ROM:off_13524   o
                rts
; End of function UI_InitDebugMenuState
; ---------------------------------------------------------------------------
stru_1356E:     dc.w    3                               ; field_0
                                        ; DATA XREF: UI_InitDebugMenuState+36   o
                dc.l    byte_18E36C                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    $FFFF
stru_13578:     dc.w    3                               ; field_0
                                        ; DATA XREF: UI_UpdateDebugMenu:loc_135B6   o
                dc.l    byte_18DA38                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

; Updates debug menu state based on mode
UI_UpdateDebugMenu:                                     ; DATA XREF: ROM:00013528   o  ; was: sub_1358A
                tst.b   (byte_FFF705).w
                bmi.s   loc_135C6
                clr.w   (word_FF8226).w
                move.b  (byte_FF866B).w,d0
                cmpi.b  #$FF,d0
                bne.s   loc_135AC
                move.w  #$400,(word_FFA218).w
                move.w  #$400,(word_FFA216).w
                bra.s   loc_135B6
; ---------------------------------------------------------------------------
loc_135AC:                                              ; CODE XREF: UI_UpdateDebugMenu+12   j
                asl.w   #4,d0
                move.w  d0,(word_FFA216).w
                move.w  d0,(word_FFA218).w
loc_135B6:                                              ; CODE XREF: UI_UpdateDebugMenu+20   j
                movea.l #stru_13578,a0
                jsr     (LoadObjData).l
                jmp     Gfx_ProcessPaletteSlots(pc)     ; (pc)
; ---------------------------------------------------------------------------
loc_135C6:                                              ; CODE XREF: UI_UpdateDebugMenu+4   j
                btst    #6,(word_FFF708).w
                beq.s   loc_135DE
                addq.w  #2,(word_FF8660).w
                cmpi.w  #$A,(word_FF8660).w
                bmi.s   loc_135DE
                clr.w   (word_FF8660).w
loc_135DE:                                              ; CODE XREF: UI_UpdateDebugMenu+42   j
                                        ; UI_UpdateDebugMenu+4E   j
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   loc_135FE
                bsr.w   UI_LoadStatusTileMap1
                bsr.w   UI_DispatchStatusUpdate
                bsr.w   UI_RenderStageNumber
                bsr.w   UI_LoadWeaponTiles
                bsr.w   UI_RenderColorCursor
                bra.w   UI_SetupStatusVDP1
; ---------------------------------------------------------------------------
loc_135FE:                                              ; CODE XREF: UI_UpdateDebugMenu+5A   j
                bsr.w   UI_LoadStatusTileMap2
                bsr.w   UI_DispatchStatusUpdate
                bsr.w   UI_RenderWeaponType
                bsr.w   UI_RenderMenuSelection1
                bsr.w   UI_DecodeColorValue
                bsr.w   UI_RenderWeaponNumber
                bra.w   UI_SetupStatusVDP2
; End of function UI_UpdateDebugMenu
; Loads status display tilemap for mode 1
UI_LoadStatusTileMap1:                                  ; CODE XREF: UI_UpdateDebugMenu+5C   p  ; was: sub_1361A
                movea.l #word_13652,a0
                movea.w #(byte_FF8510-M68K_RAM),a1
                moveq   #$13,d7
loc_13626:                                              ; CODE XREF: UI_LoadStatusTileMap1+E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_13626
                rts
; End of function UI_LoadStatusTileMap1
; Sets up VDP registers for status mode 1
UI_SetupStatusVDP1:                                     ; CODE XREF: UI_UpdateDebugMenu+70   j  ; was: sub_1362E
                movea.w #(byte_FF8510-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5080,-(a5)
                move.w  #$9588,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function UI_SetupStatusVDP1
; ---------------------------------------------------------------------------
word_13652:     dc.w    $C7B5, $C7B5, $C7D4, $C7D5, $C7D6, $C7D7, $C7D8, $C7B5, $C7B5, $C7B5
                                        ; DATA XREF: UI_LoadStatusTileMap1   o
                dc.w    $C7DE, $C7DF, $C7E0, $C7E1, $C7B5, $C7B5, $C7B5, $C7B5, $C7B4, $C7B5
                dc.w    $C7B6, $C7B7, $C7B8, $C7B9, $C7BA, $C7BB, $C7BC, $C7BD, $C7BE, $C7BF
                dc.w    $C7C0, $C7C1, $C7C2, $C7C3, $C7B5, $C7EB, $C7EA, $C7E9, $C7B5, $C7B5

; Loads status display tilemap for mode 2
UI_LoadStatusTileMap2:                                  ; CODE XREF: UI_UpdateDebugMenu:loc_135FE   p  ; was: sub_136A2
                movea.l #word_136DA,a0
                movea.w #(byte_FF8570-M68K_RAM),a1
                moveq   #$13,d7
loc_136AE:                                              ; CODE XREF: UI_LoadStatusTileMap2+E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_136AE
                rts
; End of function UI_LoadStatusTileMap2
; Sets up VDP registers for status mode 2
UI_SetupStatusVDP2:                                     ; CODE XREF: UI_UpdateDebugMenu+8C   j  ; was: sub_136B6
                movea.w #(byte_FF8570-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5100,-(a5)
                move.w  #$95B8,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function UI_SetupStatusVDP2
; ---------------------------------------------------------------------------
word_136DA:     dc.w    $C7B5, $C7B5, $C7D9, $C7DA, $C7DB, $C7DC, $C7DD, $C7B5, $C7B5, $C7B5
                                        ; DATA XREF: UI_LoadStatusTileMap2   o
                dc.w    $C7E6, $C7E7, $C7E8, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7C4, $C7C5
                dc.w    $C7C6, $C7C7, $C7C8, $C7C9, $C7CA, $C7CB, $C7CC, $C7CD, $C7CE, $C7CF
                dc.w    $C7D0, $C7D1, $C7D2, $C7D3, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5

; Dispatches status update based on mode
