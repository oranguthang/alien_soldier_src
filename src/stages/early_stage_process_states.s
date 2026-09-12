Stage_DispatchEarlyStageState:                          ; DATA XREF: ROM:Stage_ProcessHandlerTable   o  ; was: sub_C83E
                                        ; ROM:0000FF46   o
                movea.w EarlyStage_StateHandlerOffsets(pc,d0.w),a0
                adda.l  #Stage1_InitializeScrollState,a0
                jmp     (a0)
; End of function Stage_DispatchEarlyStageState
; ---------------------------------------------------------------------------
EarlyStage_StateHandlerOffsets: dc.w    Stage1_InitializeScrollState-Stage1_InitializeScrollState  ; was: off_C84A
                dc.w    Stage1_UpdateScrollToJetsripper-Stage1_InitializeScrollState
                dc.w    Stage1_InitializeJetsripperEncounter-Stage1_InitializeScrollState
                dc.w    Stage1_UpdateJetsripperEncounter-Stage1_InitializeScrollState
                dc.w    Stage1_StartPostJetsripperTransition-Stage1_InitializeScrollState
                dc.w    Stage2_UpdateScrollToAntroid-Stage1_InitializeScrollState
                dc.w    Stage2_InitializeAntroidEncounter-Stage1_InitializeScrollState
                dc.w    Stage2_UpdateAntroidEncounter-Stage1_InitializeScrollState
                dc.w    Stage2_StartPostAntroidTransition-Stage1_InitializeScrollState
                dc.w    Stage3_InitializeIntroProjectileSlots-Stage1_InitializeScrollState
                dc.w    Stage3_UpdateScrollToIntroProjectile-Stage1_InitializeScrollState
                dc.w    Stage3_WaitForIntroProjectile-Stage1_InitializeScrollState
                dc.w    Stage3_UpdateScrollToShellshogun-Stage1_InitializeScrollState
                dc.w    Stage3_InitializeShellshogunEncounter-Stage1_InitializeScrollState
                dc.w    Stage3_InitializePostShellshogunTransition-Stage1_InitializeScrollState
                dc.w    Stage3_WaitForPostShellshogunRows-Stage1_InitializeScrollState
                dc.w    Stage3_EnterStage4-Stage1_InitializeScrollState
                dc.w    Stage4_UpdateScrollToShiper-Stage1_InitializeScrollState
                dc.w    Stage4_InitializeShiperEncounter-Stage1_InitializeScrollState
                dc.w    Stage4_InitializeShiperRasterRows-Stage1_InitializeScrollState
                dc.w    Stage4_UpdateShiperEncounter-Stage1_InitializeScrollState
                dc.w    Stage4_WaitForShiperMessage-Stage1_InitializeScrollState
                dc.w    Stage4_CheckShiperTransitionReady-Stage1_InitializeScrollState
                dc.w    Stage5_InitializeScrollState-Stage1_InitializeScrollState
                dc.w    Stage5_UpdateScrollToMadamBarbar-Stage1_InitializeScrollState
                dc.w    Stage5_InitializeMadamBarbarEncounter-Stage1_InitializeScrollState
                dc.w    Stage5_UpdatePostMadamBarbar-Stage1_InitializeScrollState
                dc.w    Stage5_StartPostMadamBarbarTransition-Stage1_InitializeScrollState
                dc.w    Stage6_UpdateScrollToJoker-Stage1_InitializeScrollState
                dc.w    Stage6_InitializeJokerEncounter-Stage1_InitializeScrollState
                dc.w    Stage6_UpdatePostJoker-Stage1_InitializeScrollState
                dc.w    Stage6_StartPostJokerTransition-Stage1_InitializeScrollState
                dc.w    Stage7_InitializeScrollState-Stage1_InitializeScrollState
                dc.w    Stage7_UpdateScrollToTerobuster-Stage1_InitializeScrollState
                dc.w    Stage7_InitializeTerobusterEncounter-Stage1_InitializeScrollState
                dc.w    Stage7_UpdatePostTerobusterIntro-Stage1_InitializeScrollState
                dc.w    Stage7_UpdatePostTerobusterTransition-Stage1_InitializeScrollState
                dc.w    Stage7_UpdateScrollToStage8-Stage1_InitializeScrollState
                dc.w    Stage7_WaitForPlayerStage8Trigger-Stage1_InitializeScrollState
                dc.w    Stage7_StartTransitionToStage8-Stage1_InitializeScrollState
                dc.w    Stage8_InitializeTrainSequence-Stage1_InitializeScrollState
                dc.w    Stage8_UpdateTrainSequence-Stage1_InitializeScrollState
                dc.w    Stage8_InitializeFlyingNeoApproach-Stage1_InitializeScrollState
                dc.w    Stage8_UpdateFlyingNeoApproachDelay-Stage1_InitializeScrollState
                dc.w    Stage8_AccelerateFlyingNeoVerticalScroll-Stage1_InitializeScrollState
                dc.w    Stage8_DecelerateFlyingNeoVerticalScroll-Stage1_InitializeScrollState
                dc.w    Stage8_InitializeFlyingNeoEncounter-Stage1_InitializeScrollState
                dc.w    Stage8_UpdateFlyingNeoEncounter-Stage1_InitializeScrollState
                dc.w    Stage8_StartPostFlyingNeoTransition-Stage1_InitializeScrollState
                dc.w    Stage9_InitializeFlyCorridor-Stage1_InitializeScrollState
                dc.w    Stage9_UpdateFlyCorridor-Stage1_InitializeScrollState
                dc.w    Stage9_InitializeCaterpillarCamera-Stage1_InitializeScrollState
                dc.w    Stage9_InitializeCaterpillarEncounter-Stage1_InitializeScrollState
                dc.w    Stage9_UpdateCaterpillarShipTraversal-Stage1_InitializeScrollState
                dc.w    Stage9_UpdateCaterpillarShipExit-Stage1_InitializeScrollState
                dc.w    Stage9_XiTigerEntranceDelay_Return-Stage1_InitializeScrollState
                dc.w    Stage9_UpdateXiTigerEntranceDelay-Stage1_InitializeScrollState
                dc.w    Stage9_WaitForXiTigerEntranceObject-Stage1_InitializeScrollState
                dc.w    Stage9_UpdatePostXiTigerTransition-Stage1_InitializeScrollState
                dc.w    Stage9_InitializeXiTigerEncounter-Stage1_InitializeScrollState

; Updates stage logic and scroll
Stage1_InitializeScrollState:                           ; DATA XREF: Stage_DispatchEarlyStageState+4   o  ; was: sub_C8C2
                                        ; ROM:off_C84A   o
                addq.w  #2,(word_FFA950).w
; Updates stage scroll position and checks for phase transition at specific coordinate
Stage1_UpdateScrollToJetsripper:                        ; DATA XREF: ROM:0000C84C   o  ; was: loc_C8C6
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$668,(PrimaryCameraXPosition).w
                bmi.s   Stage1_UpdateScrollToJetsripper_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage1_UpdateScrollToJetsripper_Return:                 ; CODE XREF: Stage1_InitializeScrollState+12   j  ; was: locret_C8DA
                                        ; Stage_InitBossIntro+E   j
                rts
; End of function Stage1_InitializeScrollState
; Initializes boss introduction sequence
Stage1_InitializeJetsripperEncounter:                   ; DATA XREF: ROM:0000C84E   o  ; was: sub_C8DC
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$6E8,(PrimaryCameraXPosition).w
                bmi.s   Stage1_UpdateScrollToJetsripper_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$6E8,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_JetsripperAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage1_InitializeJetsripperEncounter
; Camera handler checking boss presence
Stage1_UpdateJetsripperEncounter:                       ; DATA XREF: ROM:0000C850   o  ; was: sub_C910
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage1_UpdateJetsripperCamera
                bsr.w   Stage_StartTimeBonusAndPreloadNextPhase
; Updates camera position during boss battle phase
Stage1_UpdateJetsripperCamera:                          ; CODE XREF: Stage1_UpdateJetsripperEncounter+4   j  ; was: loc_C91A
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Stage1_UpdateJetsripperEncounter
; Stage 2 camera with transition check
Stage1_StartPostJetsripperTransition:                   ; DATA XREF: ROM:0000C852   o  ; was: sub_C922
                bsr.w   Stage_StartNextPhaseBanner
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Stage1_StartPostJetsripperTransition
; Camera with auto-scroll and phase transition
Stage2_UpdateScrollToAntroid:                           ; DATA XREF: ROM:0000C854   o  ; was: sub_C92E
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$B40,(PrimaryCameraXPosition).w
                bmi.s   Stage2_UpdateScrollToAntroid_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage2_UpdateScrollToAntroid_Return:                    ; CODE XREF: Stage2_UpdateScrollToAntroid+E   j  ; was: locret_C942
                                        ; Camera_TransitionToBossArena+E   j
                rts
; End of function Stage2_UpdateScrollToAntroid
; Transitions camera to boss arena with position lock
Stage2_InitializeAntroidEncounter:                      ; DATA XREF: ROM:0000C856   o  ; was: sub_C944
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$BC0,(PrimaryCameraXPosition).w
                bmi.s   Stage2_UpdateScrollToAntroid_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$BC0,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_AntroidAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage2_InitializeAntroidEncounter
; Initializes camera for Antroid boss fight
Stage2_UpdateAntroidEncounter:                          ; DATA XREF: ROM:0000C858   o  ; was: sub_C978
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage2_UpdateAntroidCamera
                clr.w   (SecondaryCameraYPos).w
                bsr.w   Stage_StartPostBannerDelayAndPreloadNextPhase
; Updates camera for Antroid boss with score timer initialization
Stage2_UpdateAntroidCamera:                             ; CODE XREF: Stage2_UpdateAntroidEncounter+4   j  ; was: loc_C986
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Stage2_UpdateAntroidEncounter
; Stage 3 camera with section transition
Stage2_StartPostAntroidTransition:                      ; DATA XREF: ROM:0000C85A   o  ; was: sub_C98E
                bsr.w   Stage_StartNextPhaseBanner
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Scroll_UpdateQuarterHorizontalPosition
; End of function Stage2_StartPostAntroidTransition
; Stage 3 camera with scroll update and position limit
Stage3_InitializeIntroProjectileSlots:                  ; DATA XREF: ROM:0000C85C   o  ; was: sub_C99A
                addq.w  #2,(word_FFA950).w
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #7,d7
Stage3_InitializeIntroProjectileSlots_Loop:             ; CODE XREF: Stage3_InitializeIntroProjectileSlots+12   j  ; was: loc_C9A4
                move.w  #$10,(a0)
                lea     $60(a0),a0
                dbf     d7,Stage3_InitializeIntroProjectileSlots_Loop
; Updates scroll and camera transitions at position $FC0
Stage3_UpdateScrollToIntroProjectile:                   ; DATA XREF: ROM:0000C85E   o  ; was: loc_C9B0
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$FC0,(PrimaryCameraXPosition).w
                bmi.w   Stage3_UpdateScrollToIntroProjectile_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$FC0,(PrimaryCameraXPosition).w
                move.w  #$190,(Entity_ObjectPool).w
Stage3_UpdateScrollToIntroProjectile_Return:            ; CODE XREF: Stage3_InitializeIntroProjectileSlots+24   j  ; was: locret_C9D2
                rts
; End of function Stage3_InitializeIntroProjectileSlots
; Sets up camera for Stage 3 boss encounter
Stage3_WaitForIntroProjectile:                          ; DATA XREF: ROM:0000C860   o  ; was: sub_C9D4
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage3_WaitForIntroProjectile_Return
                addq.w  #2,(word_FFA950).w
Stage3_WaitForIntroProjectile_Return:                   ; CODE XREF: Stage3_WaitForIntroProjectile+4   j  ; was: locret_C9DE
                rts
; End of function Stage3_WaitForIntroProjectile
; Updates camera position during boss fight
Stage3_UpdateScrollToShellshogun:                       ; DATA XREF: ROM:0000C862   o  ; was: sub_C9E0
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1168,(PrimaryCameraXPosition).w
                bmi.w   Stage3_UpdateScrollToShellshogun_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage3_UpdateScrollToShellshogun_Return:                ; CODE XREF: Stage3_UpdateScrollToShellshogun+E   j  ; was: locret_C9F6
                                        ; Camera_LockToBossArena+E   j
                rts
; End of function Stage3_UpdateScrollToShellshogun
; Locks camera to boss arena boundaries
Stage3_InitializeShellshogunEncounter:                  ; DATA XREF: ROM:0000C864   o  ; was: sub_C9F8
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$11E8,(PrimaryCameraXPosition).w
                bmi.s   Stage3_UpdateScrollToShellshogun_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$11E8,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                lea     (Boss_ShellshogunAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage3_InitializeShellshogunEncounter
; Initializes camera for Shellshogun boss fight
Stage3_InitializePostShellshogunTransition:             ; DATA XREF: ROM:0000C866   o  ; was: sub_CA2C
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage3_InitializePostShellshogunTransition_UpdateCamera
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.w  #$8000,(word_FF808A).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                clr.w   (SecondaryCameraYPos).w
                lea     (Boss_ShellshogunAssetLoadList).l,a0
                jsr     (Data_ProcessPointer).l
                move.w  #4,(PalettePrimaryIndex).w
                lea     (ShellshogunStagePaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.l  #Stage3_PostShellshogunRowSourceData,(TilemapTransferBase).w
                clr.w   (TilemapRowXOrFillWord).w
                clr.w   (TilemapRowYPosition).w
                move.w  #$1F,(TilemapRowCountdown).w
Stage3_InitializePostShellshogunTransition_UpdateCamera:  ; CODE XREF: Stage3_InitializePostShellshogunTransition+4   j  ; was: loc_CA86
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage3_InitializePostShellshogunTransition
; ---------------------------------------------------------------------------
Stage3_PostShellshogunRowSourceData:    dc.l    $FFFF7000, $FFFF6800, $FFFF2000, $6000  ; was: dword_CA8A
                                        ; DATA XREF: Camera_ShellshogunBossInit+44   o

; Locks camera to fixed position
Stage3_WaitForPostShellshogunRows:                      ; DATA XREF: ROM:0000C868   o  ; was: sub_CA9A
                tst.w   (word_FFF720).w
                bmi.s   Stage3_WaitForPostShellshogunRows_UpdateCamera
                tst.w   (TilemapRowCountdown).w
                bmi.s   Stage3_StartPostShellshogunBanner
                bsr.w   Tilemap_QueueNextScrollingRow
                bra.s   Stage3_WaitForPostShellshogunRows_UpdateCamera
; ---------------------------------------------------------------------------
Stage3_StartPostShellshogunBanner:                      ; CODE XREF: Stage3_WaitForPostShellshogunRows+A   j  ; was: loc_CAAC
                bsr.w   Stage_StartNextPhaseBanner
Stage3_WaitForPostShellshogunRows_UpdateCamera:         ; CODE XREF: Stage3_WaitForPostShellshogunRows+4   j  ; was: loc_CAB0
                                        ; Camera_LockPosition+10   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage3_WaitForPostShellshogunRows
; Updates camera with smooth interpolation
Stage3_EnterStage4:                                     ; DATA XREF: ROM:0000C86A   o  ; was: sub_CAB4
                move.b  #$81,d0
                jsr     (Sound_QueueBGMRequest).l
                addq.w  #2,(word_FFA950).w
                jsr     (Stage_DispatchVisualAssetLoader).l
                bra.w   *+4
; ---------------------------------------------------------------------------
; Updates smooth scrolling camera transitions at $1A78
Stage4_UpdateScrollToShiper:                            ; CODE XREF: Stage3_EnterStage4+14   j  ; was: loc_CACC
                                        ; DATA XREF: ROM:0000C86C   o
                bsr.w   Camera_UpdateAndRenderStageTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1A78,(PrimaryCameraXPosition).w
                bmi.s   Stage4_UpdateScrollToShiper_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage4_UpdateScrollToShiper_Return:                     ; CODE XREF: Stage3_EnterStage4+26   j  ; was: locret_CAE0
                rts
; End of function Stage3_EnterStage4
; Camera following target with offset
Stage4_InitializeShiperEncounter:                       ; DATA XREF: ROM:0000C86E   o  ; was: sub_CAE2
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                cmpi.w  #$1AF8,(PrimaryCameraXPosition).w
                bmi.s   Stage4_InitializeShiperEncounter_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$1AF8,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.b  #$10,(byte_FFA95A).w
                move.b  #4,(byte_FFA95B).w
                lea     (Boss_ShiperAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                bsr.s   Stage4_FillShiperHorizontalRasterOffsets
Stage4_InitializeShiperEncounter_Return:                ; CODE XREF: Stage4_InitializeShiperEncounter+E   j  ; was: locret_CB24
                rts
; End of function Stage4_InitializeShiperEncounter
; Sets camera boundary limits
Stage4_InitializeShiperRasterRows:                      ; DATA XREF: ROM:0000C870   o  ; was: sub_CB26
                move.b  #3,(VDPReg11Shadow+1).w
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bra.s   Stage4_FillShiperHorizontalRasterOffsets
; End of function Stage4_InitializeShiperRasterRows
; Handles camera logic during stage transition checking boss state
Stage4_UpdateShiperEncounter:                           ; DATA XREF: ROM:0000C872   o  ; was: sub_CB32
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage4_UpdateShiperEncounterCamera
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                bra.s   Stage4_WaitForShiperMessage
; ---------------------------------------------------------------------------
Stage4_UpdateShiperEncounterCamera:                     ; CODE XREF: Stage4_UpdateShiperEncounter+4   j  ; was: loc_CB44
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bsr.s   Stage4_FillShiperHorizontalRasterOffsets
                move.w  #$C0,(SecondaryCameraXPos).w
                rts
; End of function Stage4_UpdateShiperEncounter
; Clamps camera position to boundaries
Stage4_FillShiperHorizontalRasterOffsets:               ; CODE XREF: Stage4_InitializeShiperEncounter+40   p  ; was: sub_CB56
                                        ; Camera_SetBounds+A   j
                movea.w #(HorizontalScrollProfile-M68K_RAM),a0
                move.w  (SecondaryCameraXPos).w,d0
                neg.w   d0
                moveq   #$7F,d7
Stage4_FillShiperSecondaryRasterOffsets:                ; CODE XREF: Stage4_FillShiperHorizontalRasterOffsets+E   j  ; was: loc_CB62
                move.w  d0,(a0)+
                dbf     d7,Stage4_FillShiperSecondaryRasterOffsets
                move.w  (PrimaryCameraXPosition).w,d0
                neg.w   d0
                moveq   #$47,d7                         ; 'G'
Stage4_FillShiperPrimaryRasterOffsets:                  ; CODE XREF: Stage4_FillShiperHorizontalRasterOffsets+1C   j  ; was: loc_CB70
                move.w  d0,(a0)+
                dbf     d7,Stage4_FillShiperPrimaryRasterOffsets
                rts
; End of function Stage4_FillShiperHorizontalRasterOffsets
; Waits for scroll position then advances stage phase
Stage4_WaitForShiperMessage:                            ; CODE XREF: Stage4_UpdateShiperEncounter+10   j  ; was: sub_CB78
                                        ; DATA XREF: ROM:0000C874   o
                bsr.s   Stage4_UpdateShiperCameraAndRasterRows
                tst.w   (MessageSequenceState).w
                bne.s   Stage4_WaitForShiperMessage_Return
                addq.w  #2,(word_FFA950).w
                move.w  #2,(PlayerScriptStateOffset).w
Stage4_WaitForShiperMessage_Return:                     ; CODE XREF: Stage4_WaitForShiperMessage+6   j  ; was: locret_CB8A
                rts
; End of function Stage4_WaitForShiperMessage
; Updates camera position and calculates scroll registers
Stage4_UpdateShiperCameraAndRasterRows:                 ; CODE XREF: Stage4_WaitForShiperMessage   p  ; was: sub_CB8C
                                        ; sub_CB9E   p
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                bsr.s   Stage4_FillShiperHorizontalRasterOffsets
                move.w  #$C0,(SecondaryCameraXPos).w
                rts
; End of function Stage4_UpdateShiperCameraAndRasterRows
; Checks if stage transition is ready based on enemy and boss state
Stage4_CheckShiperTransitionReady:                      ; DATA XREF: ROM:0000C876   o  ; was: sub_CB9E
                bsr.s   Stage4_UpdateShiperCameraAndRasterRows
                tst.w   (word_FF8230).w
                bne.s   Stage4_CheckShiperTransitionReady_Return
                tst.w   (ScriptedInputActive).w
                bne.s   Stage4_CheckShiperTransitionReady_Return
                move.l  #StageTransitionMessageSequence_Shared,(StageMessageCursor).w
                bra.w   Stage_StartInterstageTransition
; ---------------------------------------------------------------------------
Stage4_CheckShiperTransitionReady_Return:               ; CODE XREF: Stage4_CheckShiperTransitionReady+6   j  ; was: locret_CBB8
                                        ; Stage_CheckTransitionReady+C   j
                rts
; End of function Stage4_CheckShiperTransitionReady
; Updates automatic stage scrolling and checks for phase transition
Stage5_InitializeScrollState:                           ; DATA XREF: ROM:0000C878   o  ; was: sub_CBBA
                addq.w  #2,(word_FFA950).w
; Updates automatic scrolling and checks for transition
Stage5_UpdateScrollToMadamBarbar:                       ; DATA XREF: ROM:0000C87A   o  ; was: loc_CBBE
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$400,(PrimaryCameraXPosition).w
                bmi.s   Stage5_UpdateScrollToMadamBarbar_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage5_UpdateScrollToMadamBarbar_Return:                ; CODE XREF: Stage5_InitializeScrollState+E   j  ; was: locret_CBCE
                                        ; Boss_MadamBarbarScrollInit+A   j
                rts
; End of function Stage5_InitializeScrollState
; Initializes Madam Barbar boss scroll position and palette
Stage5_InitializeMadamBarbarEncounter:                  ; DATA XREF: ROM:0000C87C   o  ; was: sub_CBD0
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                cmpi.w  #$480,(PrimaryCameraXPosition).w
                bmi.s   Stage5_UpdateScrollToMadamBarbar_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$480,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_MadamBarbarAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage5_InitializeMadamBarbarEncounter
; Initializes stage after boss defeat with score timer and camera
Stage5_UpdatePostMadamBarbar:                           ; DATA XREF: ROM:0000C87E   o  ; was: sub_CC06
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage5_UpdatePostMadamBarbarCamera
                clr.w   (SecondaryCameraYPos).w
                move.l  #PostBossRuntimeSpawnList,(StageObjectSpawnCursor).w
                bsr.w   Stage_StartPostBannerDelayAndPreloadNextPhase
Stage5_UpdatePostMadamBarbarCamera:                     ; CODE XREF: Stage5_UpdatePostMadamBarbar+4   j  ; was: loc_CC1C
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage5_UpdatePostMadamBarbar
; Start a section change and request the default BGM when no delay is active
Stage5_StartPostMadamBarbarTransition:                  ; DATA XREF: ROM:0000C880   o  ; was: sub_CC20
                tst.w   (MessageSequenceState).w
                bne.s   Stage5_StartPostMadamBarbarTransition_Continue
                move.b  #$81,d0
                jsr     (Sound_QueueBGMRequest).l
Stage5_StartPostMadamBarbarTransition_Continue:         ; CODE XREF: Stage5_StartPostMadamBarbarTransition+4   j  ; was: loc_CC30
                clr.w   (word_FF808A).w
                bsr.w   Stage_StartNextPhaseBanner
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage5_StartPostMadamBarbarTransition
; Checks scroll position for stage phase transition trigger
Stage6_UpdateScrollToJoker:                             ; DATA XREF: ROM:0000C882   o  ; was: sub_CC3C
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$9E0,(PrimaryCameraXPosition).w
                bmi.s   Stage6_UpdateScrollToJoker_Return
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage6_UpdateScrollToJoker_Return:                      ; CODE XREF: Stage6_UpdateScrollToJoker+A   j  ; was: locret_CC4C
                                        ; Stage_InitJokerBoss+A   j
                rts
; End of function Stage6_UpdateScrollToJoker
; Initializes Joker boss fight with scroll check and palette update
Stage6_InitializeJokerEncounter:                        ; DATA XREF: ROM:0000C884   o  ; was: sub_CC4E
                bsr.w   Camera_UpdateBossApproachAndRenderTilemap
                cmpi.w  #$A60,(PrimaryCameraXPosition).w
                bmi.s   Stage6_UpdateScrollToJoker_Return
                addq.w  #2,(word_FFA950).w
                clr.l   (CameraXDelta).w
                move.w  #$A60,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_JokerAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage6_InitializeJokerEncounter
; Post-boss initialization triggering stage phase transition
Stage6_UpdatePostJoker:                                 ; DATA XREF: ROM:0000C886   o  ; was: sub_CC84
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage6_UpdatePostJokerCamera
                clr.w   (SecondaryCameraYPos).w
                bsr.w   Stage_StartTimeBonusAndPreloadNextPhase
Stage6_UpdatePostJokerCamera:                           ; CODE XREF: Stage6_UpdatePostJoker+4   j  ; was: loc_CC92
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage6_UpdatePostJoker
; Post-Joker transition clearing flags and updating camera
Stage6_StartPostJokerTransition:                        ; DATA XREF: ROM:0000C888   o  ; was: sub_CC96
                clr.w   (word_FF808A).w
                bsr.w   Stage_StartNextPhaseBanner
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage6_StartPostJokerTransition
; Initializes Stage 7 with scroll setup and palette loading
Stage7_InitializeScrollState:                           ; DATA XREF: ROM:0000C88A   o  ; was: sub_CCA2
                tst.w   (word_FFF720).w
                bmi.s   Stage7_UpdateScrollToTerobuster
                bsr.w   Stage7_InitializeTerobusterIntroProjectiles
                addq.w  #2,(word_FFA950).w
                lea     Stage7_InitialTileAssetLoadList(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                bra.s   Stage7_UpdateScrollToTerobuster
; End of function Stage7_InitializeScrollState
; ---------------------------------------------------------------------------
Stage7_InitialTileAssetLoadList:    dc.w    7           ; field_0  ; was: stru_CCBE
                                        ; DATA XREF: Stage_InitStage7+E   o
                dc.l    Stage7InitialTileArt            ; field_2
                dc.w    $5BE0                           ; field_6
                dc.w    $FFFF

; Updates Stage 7 scroll checking transition boundaries
Stage7_UpdateScrollToTerobuster:                        ; CODE XREF: Stage7_InitializeScrollState+4   j  ; was: sub_CCC8
                                        ; Stage_InitStage7+1A   j
                                        ; DATA XREF:
                bsr.w   Camera_UpdateAndRenderStageTilemap
                move.w  (PrimaryCameraXPosition).w,d0
                add.w   (PlayerXPosition).w,d0
                cmpi.w  #$1098,(PrimaryCameraXPosition).w
                bpl.s   Stage7_BeginTerobusterApproach
                cmpi.w  #$1116,d0
                bmi.s   Stage7_CheckIntroProjectileTrigger
Stage7_BeginTerobusterApproach:                         ; CODE XREF: Stage7_UpdateScrollToTerobuster+12   j  ; was: loc_CCE2
                move.w  #$6000,(TilemapTransferBase).w
                move.w  #$1F,(TilemapRowCountdown).w
                move.w  #0,(TilemapRowXOrFillWord).w
                move.w  #$C0,(dword_FF8062).w
                bra.w   Stage_TransitionToNextPhase
; ---------------------------------------------------------------------------
Stage7_UpdateScrollToTerobuster_Return:                 ; CODE XREF: Stage7_UpdateScrollToTerobuster+3C   j  ; was: locret_CCFE
                                        ; Stage_InitTerobusterBoss+2A   j
                rts
; ---------------------------------------------------------------------------
Stage7_CheckIntroProjectileTrigger:                     ; CODE XREF: Stage7_UpdateScrollToTerobuster+18   j  ; was: loc_CD00
                cmpi.w  #$10B6,d0
                bmi.s   Stage7_UpdateScrollToTerobuster_Return
                bra.w   Stage7_SpawnTerobusterIntroProjectile
; End of function Stage7_UpdateScrollToTerobuster
; Initializes Terobuster boss with scroll and graphics loading
Stage7_InitializeTerobusterEncounter:                   ; DATA XREF: ROM:0000C88E   o  ; was: sub_CD0A
                bsr.w   Stage7_SpawnTerobusterIntroProjectile
                subq.w  #1,(dword_FF8062).w
                bsr.w   Stage7_UpdateTerobusterIntroFade
                bsr.w   Stage7_UpdateTerobusterIntroTileRows
                jsr     (Tilemap_QueueNextConstantRow).l
                addi.l  #$C000,(PrimaryCameraXPosition).w
                jsr     (Tilemap_QueuePrimaryCameraColumnOffset158).l
                cmpi.w  #$10A0,(PrimaryCameraXPosition).w
                bmi.s   Stage7_UpdateScrollToTerobuster_Return
                clr.l   (CameraXDelta).w
                move.w  #$10A0,d0
                move.w  d0,(PrimaryCameraXPosition).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
                tst.w   (dword_FF8062).w
                bpl.s   Stage7_UpdateScrollToTerobuster_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$8000,(word_FF808A).w
                lea     (Boss_TerobusterAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Stage7_InitializeTerobusterEncounter
; Updates stage scroll offset with directional calculation
Stage7_UpdateTerobusterIntroFade:                       ; CODE XREF: Stage7_InitializeTerobusterEncounter+8   p  ; was: sub_CD66
                move.w  (dword_FF8062).w,d0
                bmi.s   Stage7_UpdateScrollToTerobuster_Return
                bne.s   Stage7_CalculateTerobusterFadeParameters
                moveq   #0,d2
                bra.s   Stage7_ApplyTerobusterFadeParameters
; ---------------------------------------------------------------------------
Stage7_CalculateTerobusterFadeParameters:               ; CODE XREF: Stage7_UpdateTerobusterIntroFade+6   j  ; was: loc_CD72
                moveq   #2,d2
                asr.w   #1,d0
                andi.w  #$E,d0
                sub.w   d0,d2
Stage7_ApplyTerobusterFadeParameters:                   ; CODE XREF: Stage7_UpdateTerobusterIntroFade+A   j  ; was: loc_CD7C
                move.w  d2,d3
                lea     (PaletteFade_StageScrollEntryOffsets).l,a2
                moveq   #0,d1
                asl.w   #4,d2
                asl.w   #8,d3
                jmp     (Gfx_FadeRGBColor_LoadEntryCount).l
; End of function Stage7_UpdateTerobusterIntroFade
; Post-intro transition clearing flags and advancing phase
Stage7_UpdatePostTerobusterIntro:                       ; DATA XREF: ROM:0000C890   o  ; was: sub_CD90
                bsr.w   Stage7_SpawnTerobusterIntroProjectile
                bsr.w   Stage7_UpdateTerobusterIntroTileRows
                tst.w   (Entity_ObjectPool).w
                bne.s   Stage7_UpdatePostTerobusterIntroCamera
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                clr.w   (SecondaryCameraYPos).w
Stage7_UpdatePostTerobusterIntroCamera:                 ; CODE XREF: Stage7_UpdatePostTerobusterIntro+C   j  ; was: loc_CDB8
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage7_UpdatePostTerobusterIntro
; Post-Terobuster transition clearing flags and advancing
Stage7_UpdatePostTerobusterTransition:                  ; DATA XREF: ROM:0000C892   o  ; was: sub_CDBC
                tst.w   (MessageSequenceState).w
                bne.s   Stage7_UpdatePostTerobusterTransitionCamera
                move.b  #1,(byte_FF830E).w
                move.w  #4,(PlayerScriptStateOffset).w
                addq.w  #2,(word_FFA950).w
                lea     Stage7_TerobusterIndexedRowCommandF0F1(pc),a0
                nop
                jsr     (Tilemap_QueueIndexedRows).l
Stage7_UpdatePostTerobusterTransitionCamera:            ; CODE XREF: Stage7_UpdatePostTerobusterTransition+4   j  ; was: loc_CDDE
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage7_UpdatePostTerobusterTransition
; Stage 7 to 8 transition with scroll boundary check
Stage7_UpdateScrollToStage8:                            ; DATA XREF: ROM:0000C894   o  ; was: sub_CDE2
                bsr.w   Camera_UpdateAndRenderStageTilemap
                cmpi.w  #$1200,(PrimaryCameraXPosition).w
                bmi.s   Stage7_UpdateScrollToStage8_Return
                addq.w  #2,(word_FFA950).w
                move.w  #$1200,(PrimaryCameraXPosition).w
Stage7_UpdateScrollToStage8_Return:                     ; CODE XREF: Stage7_UpdateScrollToStage8+A   j  ; was: locret_CDF8
                rts
; End of function Stage7_UpdateScrollToStage8
; Checks player X position to trigger stage transition
