; Dormant dispatcher with no reconstructed static caller
UnreferencedDispatchStatusDisplayMode:                  ; was: sub_13488
                move.w  #$5200,d2
                move.w  (word_FF820C).w,d0
                movea.w UnreferencedStatusDisplayModeOffsets(pc,d0.w),a0
                adda.l  #UnreferencedStatusDisplayNoOp,a0
                jmp     (a0)
; End of function UnreferencedDispatchStatusDisplayMode
; ---------------------------------------------------------------------------
UnreferencedStatusDisplayModeOffsets:   dc.w    UnreferencedStatusDisplayNoOp-UnreferencedStatusDisplayNoOp  ; was: off_1349C
                dc.w    UnreferencedStatusDisplayNoOp-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedStatusDisplayNoOp-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedStatusDisplayNoOp-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp
                dc.w    UnreferencedCycleStatusDisplayMode-UnreferencedStatusDisplayNoOp

UnreferencedStatusDisplayNoOp:                          ; was: nullsub_34
                rts
; End of function UnreferencedStatusDisplayNoOp
; ---------------------------------------------------------------------------
UnreferencedStatusDisplayVDPCommands:   dc.w    $5200, $5280, $5300, $5380, $5210, $5290, $5310, $5390  ; was: word_134B6

UnreferencedCycleStatusDisplayMode:                     ; was: sub_134C6
                subq.w  #8,d0
                move.w  UnreferencedStatusDisplayVDPCommands(pc,d0.w),d2
                addq.w  #2,(word_FF820C).w
                andi.w  #6,d0
                addq.w  #2,d0
                cmpi.w  #8,d0
                bmi.s   UnreferencedCycleStatusDisplayMode_Return
                clr.w   (word_FF820C).w
UnreferencedCycleStatusDisplayMode_Return:              ; was: locret_134E0
                rts
; End of function UnreferencedCycleStatusDisplayMode
DebugMenu_UpdateAndDispatch:                            ; CODE XREF: Debug_HandleDormantSoundAndMenuInput+52   j  ; was: sub_134E2
                bsr.w   UI_QueuePendingWeaponStateIconTransfer
                movea.w #(byte_FFA108-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                bsr.w   UI_AppendHUDSpriteList
                move.b  (word_FFF708).w,d0
                andi.b  #$4F,d0                         ; 'O'
                cmp.b   (byte_FF866A).w,d0
                beq.s   DebugMenu_UpdateInputRepeatTimer
                move.b  d0,(byte_FF866A).w
                move.w  #$C,(word_FF866C).w
DebugMenu_UpdateInputRepeatTimer:                       ; was: loc_1350A
                subq.w  #1,(word_FF866C).w
                bpl.s   DebugMenu_DispatchState
                clr.w   (word_FF866C).w
DebugMenu_DispatchState:                                ; was: loc_13514
                move.w  (word_FF8226).w,d0
                movea.w DebugMenuStateOffsets(pc,d0.w),a0
                adda.l  #DebugMenu_Initialize,a0
                jmp     (a0)
; End of function DebugMenu_UpdateAndDispatch
; ---------------------------------------------------------------------------
DebugMenuStateOffsets:  dc.w    DebugMenu_Return-DebugMenu_Initialize  ; was: off_13524
                dc.w    DebugMenu_Initialize-DebugMenu_Initialize
                dc.w    DebugMenu_UpdateActive-DebugMenu_Initialize

DebugMenu_Initialize:                                   ; was: sub_1352A
                tst.w   (word_FFF720).w
                bmi.s   DebugMenu_Return
                clr.w   (word_FF8660).w
                clr.w   (word_FF8664).w
                clr.w   (word_FF8666).w
                clr.w   (word_FF8668).w
                move.w  #4,(word_FF8662).w
                move.w  (word_FFA216).w,d0
                asr.w   #4,d0
                move.b  d0,(byte_FF866B).w
                tst.w   (word_FF822A).w
                beq.s   DebugMenu_Activate
                move.b  #$FF,(byte_FF866B).w
DebugMenu_Activate:                                     ; was: loc_1355C
                addq.w  #2,(word_FF8226).w
                movea.l #DebugMenuInitialAssetLoadList,a0
                jmp     (LoadObjData).l
; ---------------------------------------------------------------------------
DebugMenu_Return:                                       ; was: locret_1356C
                rts
; End of function DebugMenu_Initialize
; ---------------------------------------------------------------------------
DebugMenuInitialAssetLoadList:  dc.w    3               ; was: stru_1356E
                dc.l    byte_18E36C                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    $FFFF
DebugMenuActiveAssetLoadList:   dc.w    3               ; was: stru_13578
                dc.l    byte_18DA38                     ; field_2
                dc.w    $F680                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    $FFFF

DebugMenu_UpdateActive:                                 ; was: sub_1358A
                tst.b   (byte_FFF705).w
                bmi.s   DebugMenu_UpdateActivePage
                clr.w   (word_FF8226).w
                move.b  (byte_FF866B).w,d0
                cmpi.b  #$FF,d0
                bne.s   DebugMenu_ApplySelectedPlayerHealth
                move.w  #$400,(word_FFA218).w
                move.w  #$400,(word_FFA216).w
                bra.s   DebugMenu_ReloadActiveAssetsAndWeaponIcons
; ---------------------------------------------------------------------------
DebugMenu_ApplySelectedPlayerHealth:                    ; was: loc_135AC
                asl.w   #4,d0
                move.w  d0,(word_FFA216).w
                move.w  d0,(word_FFA218).w
DebugMenu_ReloadActiveAssetsAndWeaponIcons:             ; was: loc_135B6
                movea.l #DebugMenuActiveAssetLoadList,a0
                jsr     (LoadObjData).l
                jmp     UI_QueueAllWeaponIconTransfers(pc)  ; (pc)
; ---------------------------------------------------------------------------
DebugMenu_UpdateActivePage:                             ; was: loc_135C6
                btst    #6,(word_FFF708).w
                beq.s   DebugMenu_RenderSelectedPageHalf
                addq.w  #2,(word_FF8660).w
                cmpi.w  #$A,(word_FF8660).w
                bmi.s   DebugMenu_RenderSelectedPageHalf
                clr.w   (word_FF8660).w
DebugMenu_RenderSelectedPageHalf:                       ; was: loc_135DE
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   DebugMenu_RenderSecondaryPage
                bsr.w   DebugMenu_CopyPrimaryTilemap
                bsr.w   UI_DispatchStatusUpdate
                bsr.w   UI_RenderStageNumber
                bsr.w   UI_LoadWeaponTiles
                bsr.w   UI_RenderColorCursor
                bra.w   DebugMenu_QueuePrimaryTilemapTransfer
; ---------------------------------------------------------------------------
DebugMenu_RenderSecondaryPage:                          ; was: loc_135FE
                bsr.w   DebugMenu_CopySecondaryTilemap
                bsr.w   UI_DispatchStatusUpdate
                bsr.w   UI_RenderWeaponType
                bsr.w   UI_RenderMenuSelection1
                bsr.w   UI_DecodeColorValue
                bsr.w   UI_RenderWeaponNumber
                bra.w   DebugMenu_QueueSecondaryTilemapTransfer
; End of function DebugMenu_UpdateActive
DebugMenu_CopyPrimaryTilemap:                           ; was: sub_1361A
                movea.l #DebugMenuPrimaryTilemap,a0
                movea.w #(byte_FF8510-M68K_RAM),a1
                moveq   #$13,d7
DebugMenu_CopyPrimaryTilemap_NextLong:                  ; was: loc_13626
                move.l  (a0)+,(a1)+
                dbf     d7,DebugMenu_CopyPrimaryTilemap_NextLong
                rts
; End of function DebugMenu_CopyPrimaryTilemap
DebugMenu_QueuePrimaryTilemapTransfer:                  ; was: sub_1362E
                movea.w #(byte_FF8510-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5080,-(a5)
                move.w  #$9588,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function DebugMenu_QueuePrimaryTilemapTransfer
; ---------------------------------------------------------------------------
DebugMenuPrimaryTilemap:    dc.w    $C7B5, $C7B5, $C7D4, $C7D5, $C7D6, $C7D7, $C7D8, $C7B5, $C7B5, $C7B5  ; was: word_13652
                dc.w    $C7DE, $C7DF, $C7E0, $C7E1, $C7B5, $C7B5, $C7B5, $C7B5, $C7B4, $C7B5
                dc.w    $C7B6, $C7B7, $C7B8, $C7B9, $C7BA, $C7BB, $C7BC, $C7BD, $C7BE, $C7BF
                dc.w    $C7C0, $C7C1, $C7C2, $C7C3, $C7B5, $C7EB, $C7EA, $C7E9, $C7B5, $C7B5

DebugMenu_CopySecondaryTilemap:                         ; was: sub_136A2
                movea.l #DebugMenuSecondaryTilemap,a0
                movea.w #(byte_FF8570-M68K_RAM),a1
                moveq   #$13,d7
DebugMenu_CopySecondaryTilemap_NextLong:                ; was: loc_136AE
                move.l  (a0)+,(a1)+
                dbf     d7,DebugMenu_CopySecondaryTilemap_NextLong
                rts
; End of function DebugMenu_CopySecondaryTilemap
DebugMenu_QueueSecondaryTilemapTransfer:                ; was: sub_136B6
                movea.w #(byte_FF8570-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$5100,-(a5)
                move.w  #$95B8,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009328,-(a5)
                rts
; End of function DebugMenu_QueueSecondaryTilemapTransfer
; ---------------------------------------------------------------------------
DebugMenuSecondaryTilemap:  dc.w    $C7B5, $C7B5, $C7D9, $C7DA, $C7DB, $C7DC, $C7DD, $C7B5, $C7B5, $C7B5  ; was: word_136DA
                dc.w    $C7E6, $C7E7, $C7E8, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7C4, $C7C5
                dc.w    $C7C6, $C7C7, $C7C8, $C7C9, $C7CA, $C7CB, $C7CC, $C7CD, $C7CE, $C7CF
                dc.w    $C7D0, $C7D1, $C7D2, $C7D3, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5, $C7B5

; Dispatches status update based on mode
