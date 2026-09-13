; Initialize a normal stage, stream its two tilemap planes, and enter gameplay
Stage_UpdateGameplayEntry:                              ; DATA XREF: Sys_DispatchGameState+62   o  ; was: sub_1C3FA
                tst.b   (DataLoaderControl).w
                bmi.s   Stage_UpdateGameplayEntry_Return
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   Stage_StreamGameplayEntrySecondaryPlane
                move.w  (GameSubstateIndex).w,d0
                bne.s   Stage_StreamGameplayEntryPrimaryPlane
                bclr    #6,(VDPReg1Shadow+1).w
                clr.b   (PaletteDMAHIntEnabled).w
                jsr     (Sys_InitGraphicsChain).l
                jsr     (Gfx_LoadVDPRegisters).l
                jsr     (Stage_DispatchVisualAssetLoader).l
                jsr     (Sys_InitStageState).l
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  (PrimaryCameraXPosition).w,(TilemapRowXOrFillWord).w
                move.w  (PrimaryCameraYPosition).w,(TilemapRowYPosition).w
Stage_UpdateGameplayEntry_Return:                       ; CODE XREF: Stage_UpdateGameplayEntry+4   j  ; was: locret_1C448
                                        ; Stage_UpdateGameplayEntry+8E   j
                rts
; ---------------------------------------------------------------------------
Stage_StreamGameplayEntryPrimaryPlane:                  ; CODE XREF: Stage_UpdateGameplayEntry+14   j  ; was: loc_1C44A
                move.w  (word_FF80AA).w,d0
                bne.s   Stage_StreamGameplayEntryPrimaryPlane_Rows
                clr.w   (TilemapRowXOrFillWord).w
                move.w  #$4000,(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                bmi.s   Stage_AdvanceGameplayEntryToSecondaryPlane
                rts
; ---------------------------------------------------------------------------
Stage_StreamGameplayEntryPrimaryPlane_Rows:             ; CODE XREF: Stage_StreamGameplayEntryPrimaryPlane+54   j  ; was: loc_1C46A
                bpl.s   Stage_StreamGameplayEntryPrimaryPlane_DirectRows
                andi.w  #$7FFF,d0
                lea     Stage_EntryPrimaryPlaneVRAMParameterPointers(pc),a0
                nop
                move.l  -4(a0,d0.w),(TilemapTransferBase).w
                jsr     (Tilemap_MirrorOffsetRowAndQueueScrollingRow).l
                jsr     (Tilemap_MirrorOffsetRowAndQueueScrollingRow).l
                bpl.w   Stage_UpdateGameplayEntry_Return
                bra.s   Stage_AdvanceGameplayEntryToSecondaryPlane
; ---------------------------------------------------------------------------
Stage_StreamGameplayEntryPrimaryPlane_DirectRows:       ; CODE XREF: Stage_StreamGameplayEntryPrimaryPlane_Rows   j  ; was: loc_1C48E
                lea     Stage_EntryPrimaryPlaneVRAMParameterPointers(pc),a0
                nop
                move.l  -4(a0,d0.w),(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.w   Stage_UpdateGameplayEntry_Return
Stage_AdvanceGameplayEntryToSecondaryPlane:             ; CODE XREF: Stage_StreamGameplayEntryPrimaryPlane+6C   j  ; was: loc_1C4AA
                                        ; Stage_StreamGameplayEntryPrimaryPlane_Rows+92   j
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  (SecondaryCameraXPos).w,(TilemapRowXOrFillWord).w
                move.w  (SecondaryCameraYPos).w,(TilemapRowYPosition).w
                rts
; ---------------------------------------------------------------------------
Stage_StreamGameplayEntrySecondaryPlane:                ; CODE XREF: Stage_UpdateGameplayEntry+C   j  ; was: loc_1C4C2
                move.w  (word_FF80AC).w,d0
                bne.s   Stage_StreamGameplayEntrySecondaryPlane_Rows
                clr.w   (TilemapRowXOrFillWord).w
                move.w  #$6000,(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                bmi.s   Stage_FinishGameplayEntry
                rts
; ---------------------------------------------------------------------------
Stage_StreamGameplayEntrySecondaryPlane_Rows:           ; CODE XREF: Stage_StreamGameplayEntrySecondaryPlane+CC   j  ; was: loc_1C4E2
                lea     Stage_EntrySecondaryPlaneVRAMParameterPointers(pc),a0
                nop
                move.l  -4(a0,d0.w),(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.w   Stage_UpdateGameplayEntry_Return
Stage_FinishGameplayEntry:                              ; CODE XREF: Stage_StreamGameplayEntrySecondaryPlane+E4   j  ; was: loc_1C4FE
                move.w  #4,(PaletteFadeMode).w
                move.w  #$FFF4,(PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                jsr     (Gfx_FadePaletteTransition).l
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
; Enter the selected stage-process handler after the normal setup completes
Stage_EnterSelectedGameplayProcess:                     ; DATA XREF: XiTigerStage_UpdateGameplayEntry+88   r  ; was: loc_1C530
                jmp     Stage_DispatchSelectedProcess
; End of function Stage_UpdateGameplayEntry
; ---------------------------------------------------------------------------
Stage_EntryPrimaryPlaneVRAMParameterPointers:
                dc.l    Gfx_TitleAndZLeoVRAMTransferParameters  ; DATA XREF: Stage_StreamGameplayEntryPrimaryPlane_Rows+76   o ; was: off_1C536
                                        ; Stage_StreamGameplayEntryPrimaryPlane_DirectRows   o
Stage_EntryPrimaryPlaneDefaultVRAMParameterPointer:
                dc.l    Gfx_DefaultVRAMTransferParameters  ; DATA XREF: XiTigerStage_StreamSecondaryPlane_Rows+DA   r ; was: off_1C53A
Stage_EntrySecondaryPlaneVRAMParameterPointers:
                dc.l    Gfx_FrontendAlternateVRAMTransferParameters  ; DATA XREF: Stage_StreamGameplayEntrySecondaryPlane_Rows   o ; was: off_1C53E
                                        ; XiTigerStage_StreamSecondaryPlane_Rows   o
                dc.l    Gfx_ScrollVRAMTransferParameters

; Initialize the Xi-Tiger stage path, stream both tilemap planes, and enter gameplay
XiTigerStage_UpdateGameplayEntry:                       ; DATA XREF: Sys_DispatchGameState+D6   o  ; was: sub_1C546
                tst.b   (DataLoaderControl).w
                bmi.s   XiTigerStage_UpdateGameplayEntry_Return
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   XiTigerStage_StreamSecondaryPlane
                move.w  (GameSubstateIndex).w,d0
                bne.s   XiTigerStage_StreamPrimaryPlane
                jsr     (Sys_InitGraphicsChain).l
                jsr     (Gfx_LoadVDPRegisters).l
                jsr     (Stage_InitializeXiTigerState).l
                move.w  #$8004,(PaletteFadeMode).w
                move.w  #$10,(PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                jsr     (Gfx_FadePaletteTransition).l
                bset    #6,(VDPReg1Shadow+1).w
                move.b  #$80,(PaletteDMAHIntEnabled).w
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  (PrimaryCameraXPosition).w,(TilemapRowXOrFillWord).w
                move.w  (PrimaryCameraYPosition).w,(TilemapRowYPosition).w
XiTigerStage_UpdateGameplayEntry_Return:                ; CODE XREF: XiTigerStage_UpdateGameplayEntry+4   j  ; was: locret_1C5A8
                                        ; XiTigerStage_UpdateGameplayEntry+9A   j
                rts
; ---------------------------------------------------------------------------
XiTigerStage_StreamPrimaryPlane:                        ; CODE XREF: XiTigerStage_UpdateGameplayEntry+14   j  ; was: loc_1C5AA
                move.w  (word_FF80AA).w,d0
                bne.s   XiTigerStage_StreamPrimaryPlane_Rows
                clr.w   (TilemapRowXOrFillWord).w
                move.w  #$4000,(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                bmi.s   XiTigerStage_AdvanceToSecondaryPlane
                rts
; ---------------------------------------------------------------------------
XiTigerStage_StreamPrimaryPlane_Rows:                   ; CODE XREF: XiTigerStage_StreamPrimaryPlane+68   j  ; was: loc_1C5CA
                lea     Stage_EntryPrimaryPlaneVRAMParameterPointers(pc),a0
                move.l  Stage_EntryPrimaryPlaneVRAMParameterPointers-4-Stage_EntryPrimaryPlaneVRAMParameterPointers(a0,d0.w),(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.w   XiTigerStage_UpdateGameplayEntry_Return
XiTigerStage_AdvanceToSecondaryPlane:                   ; CODE XREF: XiTigerStage_StreamPrimaryPlane+80   j  ; was: loc_1C5E4
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  (SecondaryCameraXPos).w,(TilemapRowXOrFillWord).w
                move.w  (SecondaryCameraYPos).w,(TilemapRowYPosition).w
                rts
; ---------------------------------------------------------------------------
XiTigerStage_StreamSecondaryPlane:                      ; CODE XREF: XiTigerStage_UpdateGameplayEntry+C   j  ; was: loc_1C5FC
                move.w  (word_FF80AC).w,d0
                bne.s   XiTigerStage_StreamSecondaryPlane_Rows
                clr.w   (TilemapRowXOrFillWord).w
                move.w  #$6000,(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                bmi.s   XiTigerStage_FinishGameplayEntry
                rts
; ---------------------------------------------------------------------------
XiTigerStage_StreamSecondaryPlane_Rows:                 ; CODE XREF: XiTigerStage_StreamSecondaryPlane+BA   j  ; was: loc_1C61C
                lea     Stage_EntrySecondaryPlaneVRAMParameterPointers(pc),a0
                move.l  Stage_EntryPrimaryPlaneDefaultVRAMParameterPointer-Stage_EntrySecondaryPlaneVRAMParameterPointers(a0,d0.w),(TilemapTransferBase).w
                jsr     (Tilemap_QueueNextScrollingRow).l
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.w   XiTigerStage_UpdateGameplayEntry_Return
XiTigerStage_FinishGameplayEntry:                       ; CODE XREF: XiTigerStage_StreamSecondaryPlane+D2   j  ; was: loc_1C636
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                move.w  #$8004,(PaletteFadeMode).w
                move.w  #$10,(PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                jmp     Stage_DispatchSelectedProcess
; End of function XiTigerStage_UpdateGameplayEntry
