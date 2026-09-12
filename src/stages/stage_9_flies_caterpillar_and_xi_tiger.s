; Initialize the Stage 9 fly corridor, its raster layout, and camera state
Stage9_InitializeFlyCorridor:                           ; DATA XREF: ROM:0000C8AC   o  ; was: sub_D0B4
                move.w  #0,(PrimaryCameraXPosition).w
                move.w  #0,(PrimaryCameraYPosition).w
                move.w  #0,(SecondaryCameraXPos).w
                move.w  #0,(SecondaryCameraYPos).w
                move.w  (PrimaryCameraXPosition).w,(PreviousCameraXPosition).w
                move.w  (PrimaryCameraYPosition).w,(PreviousCameraYPosition).w
                bsr.w   Midgame_LoadFlyingNeoPaletteCommands
                move.w  #$2AC,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.l  #$FFFEE000,(dword_FF8240).w
                addq.w  #2,(StageStateOffset).w
                move.w  #1,(word_FF821E).w
                clr.w   (dword_FF8058).w
                clr.w   (dword_FFA960).w
                move.l  #$180000,(dword_FFA960+2).w
                clr.w   (CameraXLowerBound).w
                move.w  #$A0,(CameraXUpperBound).w
                move.b  #3,(VDPReg11Shadow+1).w
                move.b  #4,(byte_FFA95A).w
                move.b  #$30,(byte_FFA95B).w            ; '0'
                move.w  #$2C,(RasterEffectIndex).w      ; ','
                clr.w   (RasterEffectInitState).w
                move.w  #8,(word_FF8090).w
                clr.b   (byte_FF780C).l
                jmp     Stage_PrepareFourWordRangesWithD
; End of function Stage9_InitializeFlyCorridor
; Update the corridor until its vertical position reaches the ship transition
Stage9_UpdateFlyCorridor:                               ; DATA XREF: ROM:0000C8AE   o  ; was: sub_D140
                cmpi.w  #$B0,(dword_FFA960+2).w
                bmi.s   Stage9_UpdateFlyCorridorScroll
                lea     Stage9_CaterpillarTileAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                addq.w  #2,(StageStateOffset).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
                bra.s   Stage9_InitializeCaterpillarCamera
; End of function Stage9_UpdateFlyCorridor
; Build the corridor raster offsets while advancing the camera and reveal columns
Stage9_UpdateFlyCorridorScroll:                         ; CODE XREF: Stage9_UpdateFlyCorridor+6   j  ; was: sub_D166
                move.l  #Stage9_FlyCorridorLightningPaletteEntryLists,(PaletteEntryLists).w
                bsr.w   Midgame_UpdateRandomLightningEffect
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bsr.w   Stage9_WriteVerticalRasterOffsets
                bsr.w   Midgame_UpdateTrainAndFlyCorridorParallaxRows
                cmpi.w  #$60,(dword_FFA960+2).w         ; '`'
                bmi.s   Stage9_FlyCorridor_AdvanceVerticalPosition
                bsr.w   Stage9_UpdateFlyCorridorRevealColumns
Stage9_FlyCorridor_AdvanceVerticalPosition:             ; CODE XREF: Stage9_UpdateFlyCorridorScroll+22   j  ; was: loc_D18E
                addi.l  #$4000,(dword_FFA960+2).w
                movea.w #(word_FF9C00-M68K_RAM),a0
                moveq   #$60,d0                         ; '`'
                moveq   #$16,d7
Stage9_FlyCorridor_WriteAlternatingRowOffsets:          ; CODE XREF: Stage9_UpdateFlyCorridorScroll+40   j  ; was: loc_D19E
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                addq.w  #8,d0
                dbf     d7,Stage9_FlyCorridor_WriteAlternatingRowOffsets
                moveq   #3,d7
Stage9_FlyCorridor_ClearTrailingRowOffsets:             ; CODE XREF: Stage9_UpdateFlyCorridorScroll+4A   j  ; was: loc_D1AC
                move.w  #0,(a0)+
                dbf     d7,Stage9_FlyCorridor_ClearTrailingRowOffsets
                movea.w #(word_FF9C00-M68K_RAM),a0
                move.w  (dword_FFA960+2).w,d0
                move.w  d0,d1
                addi.w  #$50,d0                         ; 'P'
Stage9_FlyCorridor_CheckVisibleRowOffset:               ; CODE XREF: Stage9_UpdateFlyCorridorScroll+68   j  ; was: loc_D1C2
                subq.w  #8,d1
                bpl.s   Stage9_FlyCorridor_WriteVisibleRowOffset
                rts
; ---------------------------------------------------------------------------
Stage9_FlyCorridor_WriteVisibleRowOffset:               ; CODE XREF: Stage9_UpdateFlyCorridorScroll+5E   j  ; was: loc_D1C8
                neg.w   d0
                move.w  d0,(a0)+
                neg.w   d0
                bra.s   Stage9_FlyCorridor_CheckVisibleRowOffset
; End of function Stage9_UpdateFlyCorridorScroll
; ---------------------------------------------------------------------------
Stage9_CaterpillarTileAssetLoadList:    dc.w    7       ; field_0  ; was: stru_D1D0
                                        ; DATA XREF: Stage9_UpdateFlyCorridor+8   o
                dc.l    Stage9CaterpillarTileArt        ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Seed the secondary camera used by the Caterpillar ship traversal
Stage9_InitializeCaterpillarCamera:                     ; CODE XREF: Stage9_UpdateFlyCorridor+24   j  ; was: sub_D1DA
                                        ; DATA XREF: ROM:0000C8B0   o
                move.w  (PrimaryCameraXPosition).w,(SecondaryCameraXPos).w
                move.w  #$F900,(SecondaryCameraYPos).w
                bra.w   Stage9_InitializeCaterpillarEncounter
; End of function Stage9_InitializeCaterpillarCamera
; Unreferenced alternate entry into the Caterpillar scrolling path
UnreferencedStage9_UpdateCaterpillarScroll:
                move.l  #Stage9_FlyCorridorLightningPaletteEntryLists,(PaletteEntryLists).w  ; was: sub_D1EA
                bsr.w   Midgame_UpdateRandomLightningEffect
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Stage9_UpdateCaterpillarCameraAndScroll
; End of function UnreferencedStage9_UpdateCaterpillarScroll
; Reveal one column of the fly-corridor tilemap every eight frames
Stage9_UpdateFlyCorridorRevealColumns:                  ; CODE XREF: Stage9_UpdateFlyCorridorScroll+24   p  ; was: sub_D1FE
                cmpi.w  #$20,(dword_FF8058).w           ; ' '
                bne.s   Stage9_RevealNextFlyCorridorColumn
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
Stage9_RevealNextFlyCorridorColumn:                     ; CODE XREF: Stage9_UpdateFlyCorridorRevealColumns+6   j  ; was: loc_D20C
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FF8058).w,d0
                moveq   #$16,d7
Stage9_ClearFlyCorridorColumnRows:                      ; CODE XREF: Stage9_UpdateFlyCorridorRevealColumns+22   j  ; was: loc_D216
                move.b  #0,(a0,d0.w)
                adda.w  #$20,a0                         ; ' '
                dbf     d7,Stage9_ClearFlyCorridorColumnRows
                movea.w (VDPCommandQueueHead).w,a4
                move.w  #$80,-(a4)
                move.w  #$7AC0,-(a4)
                move.w  #$9500,-(a4)
                move.w  #$96CB,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  #$94019310,-(a4)
                move.w  a4,(VDPCommandQueueHead).w
                addi.l  #$200,(dword_FF8240).w
                bmi.s   Stage9_UpdateFlyCorridorRevealTimer
                clr.l   (dword_FF8240).w
Stage9_UpdateFlyCorridorRevealTimer:                    ; CODE XREF: Stage9_UpdateFlyCorridorRevealColumns+52   j  ; was: loc_D256
                move.w  (FrameCounter).w,d0
                andi.w  #7,d0
                bne.s   Stage9_UpdateFlyCorridorRevealColumns_Return
                addq.w  #1,(dword_FF8058).w
Stage9_UpdateFlyCorridorRevealColumns_Return:           ; CODE XREF: Stage9_UpdateFlyCorridorRevealColumns+60   j  ; was: locret_D264
                rts
; End of function Stage9_UpdateFlyCorridorRevealColumns
; ---------------------------------------------------------------------------
; Unreferenced 32-byte permutation containing each index from 0 through 31 once
UnreferencedStage9IndexPermutation: binclude "data/other/unreferenced_stage_9_index_permutation.bin"  ; was: unused_2

; Initialize the Caterpillar encounter and enter its scrolling update path
Stage9_InitializeCaterpillarEncounter:                  ; CODE XREF: Stage9_InitializeCaterpillarCamera+C   j  ; was: sub_D286
                                        ; DATA XREF: ROM:0000C8B2   o
                addq.w  #2,(StageStateOffset).w
                clr.w   (word_FF821E).w
                clr.l   (StageCameraYVelocity).w
                move.w  #$8000,(word_FF808A).w
                move.w  #$128,(Entity_ObjectPool).w
                move.w  #$C470,(HUDDynamicStripTileAttr).w
                clr.w   (HUDDynamicStripYOffset).w
                move.b  #9,(byte_FFA95A).w
                move.b  #$24,(byte_FFA95B).w            ; '$'
                bra.s   Stage9_UpdateCaterpillarShipTraversal_Camera
; End of function Stage9_InitializeCaterpillarEncounter
; Follow the player across the Caterpillar ship and stream its tilemap columns
Stage9_UpdateCaterpillarShipTraversal:                  ; DATA XREF: ROM:0000C8B4   o  ; was: sub_D2B6
                move.b  #6,(VDPReg11Shadow+1).w
Stage9_UpdateCaterpillarShipTraversal_Camera:           ; CODE XREF: Stage9_InitializeCaterpillarEncounter+2E   j  ; was: loc_D2BC
                tst.b   (word_FFF720).w
                bmi.s   Stage9_UpdateCaterpillarShipTraversal_Position
                cmpi.w  #$20,(HUDDynamicStripYOffset).w  ; ' '
                bpl.s   Stage9_UpdateCaterpillarShipTraversal_Position
                addq.w  #2,(HUDDynamicStripYOffset).w
Stage9_UpdateCaterpillarShipTraversal_Position:         ; CODE XREF: Stage9_UpdateCaterpillarShipTraversal+A   j  ; was: loc_D2CE
                                        ; Stage9_UpdateCaterpillarShipTraversal+12   j
                move.l  (PrimaryCameraXPosition).w,(dword_FF8040).w
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                move.l  (PrimaryCameraXPosition).w,d7
                sub.l   (dword_FF8040).w,d7
                addi.l  #$12000,d7
                add.l   d7,(SecondaryCameraXPos).w
                move.w  (SecondaryCameraXPos).w,d0
                addi.w  #$158,d0
                tst.l   d7
                bpl.s   Stage9_StreamCaterpillarShipColumn
                move.w  (SecondaryCameraXPos).w,d0
                subi.w  #$58,d0                         ; 'X'
Stage9_StreamCaterpillarShipColumn:                     ; CODE XREF: Stage9_UpdateCaterpillarShipTraversal+3E   j  ; was: loc_D2FE
                move.w  (SecondaryCameraYPos).w,d1
                lea     Stage9_CaterpillarShipColumnTransferDescriptor(pc),a0
                nop
                jsr     (Tilemap_QueueColumnFromDescriptor).l
                move.w  (SecondaryCameraXPos).w,(word_FF8048).w
                bsr.w   Stage9_UpdateCaterpillarOscillationAndRasterRows
                move.w  (word_FF8048).w,(SecondaryCameraXPos).w
                move.w  (SecondaryCameraXPos).w,d5
                add.w   (PrimaryCameraXPosition).w,d5
                cmpi.w  #$9F0,d5
                bmi.s   Stage9_CheckCaterpillarShipTransition
                move.b  #1,(byte_FF830E).w
Stage9_CheckCaterpillarShipTransition:                  ; CODE XREF: Stage9_UpdateCaterpillarShipTraversal+74   j  ; was: loc_D332
                cmpi.w  #$A00,d5
                bmi.s   Stage9_UpdateCaterpillarShipTraversal_Return
                bsr.w   Stage_TransitionToNextPhase
                move.b  #2,(VDPReg11Shadow+1).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                clr.w   (SecondaryCameraYPos).w
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$6000,(TilemapTransferBase).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  #0,(TilemapRowXOrFillWord).w
                lea     Stage9_XiTigerEntranceTileAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                move.w  #$460,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
                move.w  #$60,(dword_FF8128).w           ; '`'
Stage9_UpdateCaterpillarShipTraversal_Return:           ; CODE XREF: Stage9_UpdateCaterpillarShipTraversal+80   j  ; was: locret_D38A
                rts
; End of function Stage9_UpdateCaterpillarShipTraversal
; ---------------------------------------------------------------------------
Stage9_CaterpillarShipColumnTransferDescriptor: dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $6000  ; was: word_D38C
                                        ; DATA XREF: Stage9_UpdateCaterpillarShipTraversal+4C   o
Stage9_XiTigerEntranceTileAssetLoadList:    dc.w    7   ; field_0  ; was: stru_D39C
                                        ; DATA XREF: Stage9_UpdateCaterpillarShipTraversal+B8   o
                dc.l    Stage9XiTigerEntranceTileArt    ; field_2
                dc.w    $8000                           ; field_6
                dc.w    $FFFF

; Scroll the Caterpillar ship out, then select the Xi-Tiger transition route
Stage9_UpdateCaterpillarShipExit:                       ; DATA XREF: ROM:0000C8B6   o  ; was: sub_D3A6
                subq.w  #1,(HUDDynamicStripYOffset).w
                jsr     (Tilemap_QueueNextConstantRow).l
                addi.l  #-$10000,(PrimaryCameraXPosition).w
                bsr.w   Stage9_UpdateCaterpillarOscillationAndRasterRows
                tst.w   (PrimaryCameraXPosition).w
                bpl.s   Stage9_UpdateCaterpillarShipExit_Return
                clr.w   (PrimaryCameraXPosition).w
                clr.l   (CameraXDelta).w
                tst.w   (MessageSequenceState).w
                bne.s   Stage9_UpdateCaterpillarShipExit_Return
                tst.w   (TilemapRowCountdown).w
                bpl.s   Stage9_UpdateCaterpillarShipExit_Return
                subq.w  #1,(dword_FF8128).w
                bpl.s   Stage9_UpdateCaterpillarShipExit_Return
                addq.w  #2,(StageStateOffset).w
                clr.w   (CameraXLowerBound).w
                clr.w   (CameraXUpperBound).w
                move.w  #$8002,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                move.b  #$80,(byte_FFF705).w
                tst.b   (StageRouteFlags).w
                beq.s   Stage9_SelectXiTigerTransitionRoute
                move.b  #$82,d0
                jsr     (Sound_QueueBGMRequest).l
                bra.w   Stage9_LoadXiTigerEncounterAssets
; ---------------------------------------------------------------------------
Stage9_SelectXiTigerTransitionRoute:                    ; CODE XREF: Stage9_UpdateCaterpillarShipExit+5C   j  ; was: loc_D412
                move.w  #0,(SetupTransitionIndex).w
                move.w  #4,(word_FF8230).w
Stage9_UpdateCaterpillarShipExit_Return:                ; CODE XREF: Stage9_UpdateCaterpillarShipExit+1A   j  ; was: locret_D41E
                                        ; Stage9_UpdateCaterpillarShipExit+28   j
                rts
; End of function Stage9_UpdateCaterpillarShipExit
; Return while the Xi-Tiger entrance delay remains active
Stage9_XiTigerEntranceDelay_Return:                     ; CODE XREF: Stage9_UpdateXiTigerEntranceDelay+16   j  ; was: nullsub_23
                                        ; DATA XREF: ROM:0000C8B8   o
                rts
; End of function Stage9_XiTigerEntranceDelay_Return
; Initialize health, display state, and assets for the Xi-Tiger encounter
Stage9_InitializeXiTigerEncounter:                      ; DATA XREF: ROM:0000C8C0   o  ; was: sub_D422
                bsr.w   Stage_InitializeBossHealthAndCounter
                move.w  (BossHealth).w,(DisplayedBossHealth).w
                move.w  (PlayerHealth).w,(DisplayedPlayerHealth).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #$40,(byte_FFF705).w            ; '@'
                move.w  #$8000,(word_FF808A).w
                move.w  #$20,(PlayerScriptStateOffset).w  ; ' '
                move.w  #$40,(ScriptedInputStepTimer).w  ; '@'
Stage9_LoadXiTigerEncounterAssets:                      ; CODE XREF: Stage9_UpdateCaterpillarShipExit+68   j  ; was: loc_D450
                move.w  #$70,(StageStateOffset).w       ; 'p'
                move.w  #$10,(dword_FF8062).w
                lea     (Boss_XiTigerAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage9_InitializeXiTigerEncounter
; Count down before entering the Xi-Tiger entrance-object wait
Stage9_UpdateXiTigerEntranceDelay:                      ; DATA XREF: ROM:0000C8BA   o  ; was: sub_D468
                move.w  #$8004,(PaletteFadeMode).w
                move.w  #$10,(PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                subq.w  #1,(dword_FF8062).w
                bpl.w   Stage9_XiTigerEntranceDelay_Return
                move.b  #$41,(byte_FFF705).w            ; 'A'
                addq.w  #2,(StageStateOffset).w
                move.b  #2,(VDPReg11Shadow+1).w
                move.b  #1,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
; Wait until the Xi-Tiger entrance object leaves the primary object slot
Stage9_WaitForXiTigerEntranceObject:                    ; DATA XREF: ROM:0000C8BC   o  ; was: loc_D49E
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage9_UpdateCaterpillarCameraAndScroll
                addq.w  #2,(StageStateOffset).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.b  #1,(AlternateTimeBonusSound).w
                move.w  #$1C0,(word_FF806E).w
Stage9_UpdateCaterpillarCameraAndScroll:                ; CODE XREF: UnreferencedStage9_UpdateCaterpillarScroll+10   j  ; was: loc_D4BA
                                        ; Stage9_UpdateXiTigerEntranceDelay+3A   j
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage9_UpdateXiTigerEntranceDelay
; Oscillate the vertical camera offset and write the Stage 9 raster rows
Stage9_UpdateCaterpillarOscillationAndRasterRows:       ; CODE XREF: Stage9_UpdateCaterpillarShipTraversal+5E   p  ; was: sub_D4BE
                                        ; Stage9_UpdateCaterpillarShipExit+12   p
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                move.l  #Stage9_FlyCorridorLightningPaletteEntryLists,(PaletteEntryLists).w
                bsr.w   Midgame_UpdateRandomLightningEffect
                tst.w   (dword_FFA960).w
                bmi.s   Stage9_CheckCaterpillarVerticalBounce
                bne.s   Stage9_RaiseCaterpillarVerticalOffset
                subi.l  #$1000,(PrimaryCameraYPosition).w
                bpl.s   Stage9_CheckCaterpillarVerticalBounce
                addq.w  #1,(dword_FFA960).w
                bra.s   Stage9_CheckCaterpillarVerticalBounce
; ---------------------------------------------------------------------------
Stage9_RaiseCaterpillarVerticalOffset:                  ; CODE XREF: Stage9_UpdateCaterpillarOscillationAndRasterRows+16   j  ; was: loc_D4E6
                addi.l  #$1000,(PrimaryCameraYPosition).w
                cmpi.w  #$10,(PrimaryCameraYPosition).w
                bmi.s   Stage9_CheckCaterpillarVerticalBounce
                clr.w   (dword_FFA960).w
Stage9_CheckCaterpillarVerticalBounce:                  ; CODE XREF: Stage9_UpdateCaterpillarOscillationAndRasterRows+14   j  ; was: loc_D4FA
                                        ; Stage9_UpdateCaterpillarOscillationAndRasterRows+20   j
                tst.w   (dword_FFA960).w
                bpl.s   Stage9_WriteVerticalRasterOffsets
                move.l  (StageCameraYVelocity).w,d0
                bpl.s   Stage9_AccelerateCaterpillarVerticalBounce
                cmpi.l  #$FFFF8000,d0
                bmi.s   Stage9_ApplyCaterpillarVerticalBounce
Stage9_AccelerateCaterpillarVerticalBounce:             ; CODE XREF: Stage9_UpdateCaterpillarOscillationAndRasterRows+46   j  ; was: loc_D50E
                subi.l  #$800,d0
Stage9_ApplyCaterpillarVerticalBounce:                  ; CODE XREF: Stage9_UpdateCaterpillarOscillationAndRasterRows+4E   j  ; was: loc_D514
                move.l  d0,(StageCameraYVelocity).w
                add.l   d0,(PrimaryCameraYPosition).w
                bpl.s   Stage9_ClampCaterpillarVerticalOffset
                clr.l   (StageCameraYVelocity).w
                clr.l   (PrimaryCameraYPosition).w
                clr.w   (dword_FFA960).w
Stage9_ClampCaterpillarVerticalOffset:                  ; CODE XREF: Stage9_UpdateCaterpillarOscillationAndRasterRows+5E   j  ; was: loc_D52A
                cmpi.w  #$18,(PrimaryCameraYPosition).w
                bmi.s   Stage9_WriteVerticalRasterOffsets
                move.w  #$18,(PrimaryCameraYPosition).w
; End of function Stage9_UpdateCaterpillarOscillationAndRasterRows
; Write either sparse or dense Stage 9 vertical raster offsets
Stage9_WriteVerticalRasterOffsets:                      ; CODE XREF: Stage9_UpdateFlyCorridorScroll+14   p  ; was: sub_D538
                                        ; Stage9_UpdateCaterpillarOscillationAndRasterRows+40   j
                movea.w #(word_FFE480-M68K_RAM),a0
                addi.l  #$8000,(Stage9RasterScrollPhase).w
                move.l  (SecondaryCameraXPos).w,d0
                add.l   (Stage9RasterScrollPhase).w,d0
                swap    d0
                neg.w   d0
                cmpi.b  #3,(VDPReg11Shadow+1).w
                beq.s   Stage9_WriteDenseForegroundRasterOffsets
                moveq   #$20,d1                         ; ' '
                moveq   #$12,d7
Stage9_WriteSparseForegroundRasterOffsets:              ; CODE XREF: Stage9_WriteVerticalRasterOffsets+28   j  ; was: loc_D55C
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,Stage9_WriteSparseForegroundRasterOffsets
                move.w  (PrimaryCameraXPosition).w,d0
                neg.w   d0
                moveq   #4,d7
Stage9_WriteSparseCameraRasterOffsets:                  ; CODE XREF: Stage9_WriteVerticalRasterOffsets+38   j  ; was: loc_D56C
                move.w  d0,(a0)
                adda.w  d1,a0
                dbf     d7,Stage9_WriteSparseCameraRasterOffsets
                rts
; ---------------------------------------------------------------------------
Stage9_WriteDenseForegroundRasterOffsets:               ; CODE XREF: Stage9_WriteVerticalRasterOffsets+1E   j  ; was: loc_D576
                move.w  #$97,d7
Stage9_WriteDenseForegroundRasterOffsets_Loop:          ; CODE XREF: Stage9_WriteVerticalRasterOffsets+46   j  ; was: loc_D57A
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,Stage9_WriteDenseForegroundRasterOffsets_Loop
                move.w  (PrimaryCameraXPosition).w,d0
                neg.w   d0
                moveq   #$27,d7                         ; '''
Stage9_WriteDenseCameraRasterOffsets:                   ; CODE XREF: Stage9_WriteVerticalRasterOffsets+56   j  ; was: loc_D58A
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,Stage9_WriteDenseCameraRasterOffsets
                rts
; End of function Stage9_WriteVerticalRasterOffsets
; Wait for the post-Xi-Tiger delay and start the interstage message sequence
Stage9_UpdatePostXiTigerTransition:                     ; DATA XREF: ROM:0000C8BE   o  ; was: sub_D594
                bsr.w   Stage9_UpdateCaterpillarCameraAndScroll
                subq.w  #1,(word_FF806E).w
                bpl.s   Stage9_UpdatePostXiTigerTransition_Return
                tst.w   (word_FF8230).w
                bne.s   Stage9_UpdatePostXiTigerTransition_Return
                move.b  #$86,(PendingStageBGMRequest).w
                move.l  #StageTransitionMessageSequence_Shared,(StageMessageCursor).w
                tst.w   (MessageSequenceState).w
                beq.w   Stage_StartInterstageTransition
Stage9_UpdatePostXiTigerTransition_Return:              ; CODE XREF: Stage9_UpdatePostXiTigerTransition+8   j  ; was: locret_D5BA
                                        ; Stage9_UpdatePostXiTigerTransition+E   j
                rts
; End of function Stage9_UpdatePostXiTigerTransition
; Initializes projectile spawn position for Terobuster intro
