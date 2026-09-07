Sys_GameplayMainLoop:                                   ; DATA XREF: Sys_DispatchGameState+66   o  ; was: sub_1C65C
                bsr.w   Sys_GameplayPreUpdateNoOp
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateCamera
                move.w  #$C7F0,(word_FF8110).w
                move.w  #$20,(word_FF8112).w            ; ' '
Sys_GameplayMainLoop_UpdateCamera:                      ; CODE XREF: Sys_GameplayMainLoop+8   j  ; was: loc_1C672
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_ApplyCameraMotion
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$822,(VDP_DATA).l
Sys_GameplayMainLoop_ApplyCameraMotion:                 ; CODE XREF: Sys_GameplayMainLoop+1A   j  ; was: loc_1C68A
                bsr.w   Object_ApplyCameraMotion
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateCollision
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateCollision:                   ; CODE XREF: Sys_GameplayMainLoop+36   j  ; was: loc_1C6A6
                jsr     (Collision_UpdateSystem).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdatePrimaryEffects
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
Sys_GameplayMainLoop_UpdatePrimaryEffects:              ; CODE XREF: Sys_GameplayMainLoop+54   j  ; was: loc_1C6C4
                jsr     (Sys_InitObjectPointers).l
                bsr.w   Sys_BeginVisibleObjectList
                bsr.w   UI_UpdateStageNumberBCD
                jsr     (Gfx_PrimaryEffectDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_BuildHUDSprites
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
Sys_GameplayMainLoop_BuildHUDSprites:                   ; CODE XREF: Sys_GameplayMainLoop+80   j  ; was: loc_1C6F0
                jsr     (UI_BuildHUDSpriteList).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdatePlayer
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E0,(VDP_DATA).l
Sys_GameplayMainLoop_UpdatePlayer:                      ; CODE XREF: Sys_GameplayMainLoop+9E   j  ; was: loc_1C70E
                jsr     (Player_Update).l
                jsr     (UI_UpdateWeaponDisplay).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateSpawner
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateSpawner:                     ; CODE XREF: Sys_GameplayMainLoop+C2   j  ; was: loc_1C732
                jsr     (Sys_UpdateObjectSpawner).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateProjectiles
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateProjectiles:                 ; CODE XREF: Sys_GameplayMainLoop+E0   j  ; was: loc_1C750
                jsr     (Sys_ProcessProjectiles).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateStageEffects
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateStageEffects:                ; CODE XREF: Sys_GameplayMainLoop+FE   j  ; was: loc_1C76E
                jsr     (Boss_JetsripperMoveLeft).l
                jsr     (Effect_PaletteDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateStage
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateStage:                       ; CODE XREF: Sys_GameplayMainLoop+122   j  ; was: loc_1C792
                jsr     (Stage_ProcessHandler).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateSecondaryEffects
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateSecondaryEffects:            ; CODE XREF: Sys_GameplayMainLoop+140   j  ; was: loc_1C7B0
                jsr     (Gfx_SecondaryEffectDispatcher).l
                bsr.w   Sys_UpdateObjectCount
                jsr     (Player_BehaviorDispatcher).l
                jsr     (UI_RenderHUDElement1).l
                bsr.w   Effect_ScreenShakeUpdate
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_ProcessObjects
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
Sys_GameplayMainLoop_ProcessObjects:                    ; CODE XREF: Sys_GameplayMainLoop+172   j  ; was: loc_1C7E2
                jsr     (Sys_ProcessObjectList).l
                tst.b   (byte_FFF746).w
                bpl.s   Sys_GameplayMainLoop_UpdateFade
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
Sys_GameplayMainLoop_UpdateFade:                        ; CODE XREF: Sys_GameplayMainLoop+190   j  ; was: loc_1C800
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   Sys_GameplayMainLoop_HandleTransition
Sys_GameplayMainLoop_RequestExit:                       ; CODE XREF: Sys_GameplayMainLoop+1C6   j  ; was: loc_1C80E
                move.b  #$41,(byte_FFF705).w            ; 'A'
                bra.s   Sys_GameplayMainLoop_UpdateFrameTiming
; ---------------------------------------------------------------------------
Sys_GameplayMainLoop_HandleTransition:                  ; CODE XREF: Sys_GameplayMainLoop+1B0   j  ; was: loc_1C816
                bclr    #1,(word_FF80F4).w
                beq.s   Sys_GameplayMainLoop_UpdateFrameTiming
                move.w  (word_FF8230).w,d0
                beq.s   Sys_GameplayMainLoop_RequestExit
                clr.w   (word_FFA21E).w
                cmpi.w  #1,d0
                bne.s   Sys_GameplayMainLoop_SelectMode34
                move.w  #$2C,(GameModeIndex).w          ; ','
                clr.w   (GameSubstateIndex).w
                move.b  #4,d0
                jsr     (Sound_PlaySFX).l
                bra.s   Sys_GameplayMainLoop_UpdateFrameTiming
; ---------------------------------------------------------------------------
Sys_GameplayMainLoop_SelectMode34:                      ; CODE XREF: Sys_GameplayMainLoop+1D0   j  ; was: loc_1C844
                cmpi.w  #3,d0
                bne.s   Sys_GameplayMainLoop_SelectMode68
                move.w  #$34,(GameModeIndex).w          ; '4'
                clr.w   (GameSubstateIndex).w
                bra.s   Sys_GameplayMainLoop_UpdateFrameTiming
; ---------------------------------------------------------------------------
Sys_GameplayMainLoop_SelectMode68:                      ; CODE XREF: Sys_GameplayMainLoop+1EC   j  ; was: loc_1C856
                move.w  #$68,(GameModeIndex).w          ; 'h'
                clr.w   (GameSubstateIndex).w
Sys_GameplayMainLoop_UpdateFrameTiming:                 ; CODE XREF: Sys_GameplayMainLoop+1B8   j  ; was: loc_1C860
                                        ; Sys_GameplayMainLoop+1C0   j
                tst.b   (byte_FFF705).w
                bmi.s   Sys_GameplayMainLoop_FinishFrame
                addq.w  #1,(word_FFA000).w
                subq.w  #1,(word_FF813C).w
                bpl.s   Sys_GameplayMainLoop_SetActiveFrame
                move.w  #$FFFF,(word_FF813C).w
                move.b  #0,d0
                bra.s   Sys_GameplayMainLoop_StoreFrameFlag
; ---------------------------------------------------------------------------
Sys_GameplayMainLoop_SetActiveFrame:                    ; CODE XREF: Sys_GameplayMainLoop+212   j  ; was: loc_1C87C
                move.b  #$80,d0
Sys_GameplayMainLoop_StoreFrameFlag:                    ; CODE XREF: Sys_GameplayMainLoop+21E   j  ; was: loc_1C880
                move.b  d0,(byte_FF813E).w
Sys_GameplayMainLoop_FinishFrame:                       ; CODE XREF: Sys_GameplayMainLoop+208   j  ; was: loc_1C884
                move.b  (byte_FFF705).w,d0
                or.b    d0,(byte_FF813E).w
                jmp     (Gfx_ClearBackgroundColor).l
; End of function Sys_GameplayMainLoop
; Set game state to $40
Sys_SetState40:
                move.w  #$40,(GameModeIndex).w          ; '@'  ; was: sub_1C892
                clr.w   (GameSubstateIndex).w
                rts
; End of function Sys_SetState40
; Set game state to $3C with input
Sys_SetState3CWithInput:
                move.w  #$3C,(GameModeIndex).w          ; '<'  ; was: sub_1C89E
                clr.w   (GameSubstateIndex).w
                move.b  #1,d0
                jmp     (Input_ProcessButtons).l
; End of function Sys_SetState3CWithInput
; Converts the stage table index to the BCD stage number used by results
UI_UpdateStageNumberBCD:                                ; CODE XREF: Sys_GameplayMainLoop+72   p  ; was: sub_1C8B2
                move.w  (StageTableIndex).w,d0
                asr.w   #1,d0
                move.b  UI_StageNumberBcdTable(pc,d0.w),(byte_FF8232).w
                rts
; End of function UI_UpdateStageNumberBCD
; ---------------------------------------------------------------------------
UI_StageNumberBcdTable: dc.b    1, 2, 3, 4, 5, 6, 7, 8, 9, $10  ; was: byte_1C8C0
                                        ; DATA XREF: UI_UpdateStageNumberBCD+6   r
                dc.b    $11, $12, $13, $14, $15, $16, $17, $18, $19, $20
                dc.b    $21, $22, $23, $24, $25, $26, $27, $28, $29, $30
                dc.b    $31, $32, $33, $34, $35, $36, $37, $38, $39, $40
                dc.b    $41, $42, $43, $44, $45, $46, $47, $48, $49, $50

; Initializes the visible-object list cursor when frame processing is active
Sys_BeginVisibleObjectList:                             ; CODE XREF: Sys_StoryScreenMainLoop+2C   p  ; was: sub_1C8F2
                                        ; UI_UpdateOptionsScreen+52   p
                tst.b   (byte_FF813E).w
                bmi.w   Sys_BeginVisibleObjectList_Return
                move.w  #$ED00,(word_FFF758).w
Sys_BeginVisibleObjectList_Return:                      ; CODE XREF: Sys_BeginVisibleObjectList+4   j  ; was: locret_1C900
                rts
; End of function Sys_BeginVisibleObjectList
; Calculates number of active visible objects from list pointer
Sys_UpdateObjectCount:                                  ; CODE XREF: Sys_StoryScreenMainLoop+44   p  ; was: sub_1C902
                                        ; UI_UpdateOptionsScreen+62   p
                tst.b   (byte_FF813E).w
                bmi.w   Sys_UpdateObjectCount_Return
                move.w  (word_FFF758).w,d0
                subi.w  #$ED00,d0
                lsr.w   #1,d0
                move.w  d0,(word_FFF75A).w
Sys_UpdateObjectCount_Return:                           ; CODE XREF: Sys_UpdateObjectCount+4   j  ; was: locret_1C918
                rts
; End of function Sys_UpdateObjectCount
; Display pause menu graphics
UI_DisplayPauseGraphics:
                move.b  (byte_FFF705).w,d0              ; was: sub_1C91A
                bpl.w   UI_DisplayPauseGraphics_Return
                btst    #6,d0
                beq.w   UI_DisplayPauseGraphics_Return
                move.b  (word_FFF706).w,d0
                or.b    (word_FFF706+1).w,d0
                andi.b  #$40,d0                         ; '@'
                bne.w   UI_DisplayPauseGraphics_Return
                btst    #4,(word_FFA280+1).w
                bne.w   UI_DisplayPauseGraphics_Render
UI_DisplayPauseGraphics_Return:                         ; CODE XREF: UI_DisplayPauseGraphics+4   j  ; was: locret_1C944
                                        ; UI_DisplayPauseGraphics+C   j
                rts
; ---------------------------------------------------------------------------
UI_DisplayPauseGraphics_Render:                         ; CODE XREF: UI_DisplayPauseGraphics+26   j  ; was: loc_1C946
                lea     (dword_FFA100).w,a0
                movea.w a0,a1
                move.l  #byte_A00C00,(a1)+
                move.w  #$C7EB,(a1)+
                move.w  #$C0,(a1)+
                move.l  #Z80_RAM,(a1)+
                move.w  #$C7EF,(a1)+
                move.w  #$E0,(a1)+
                move.w  #$FFFF,(a1)
                jmp     (Sprite_AddToOAMBuffer).l
; End of function UI_DisplayPauseGraphics
; ---------------------------------------------------------------------------
Object_CameraPriorityTable: dc.w    0, $800, $1800, $1000  ; was: word_1C972
                                        ; DATA XREF: Object_ApplyCameraMotion:Object_ApplyCameraMotion_Begin   o
                                        ; Boss_StateDispatcher+7C   o

; Applies camera deltas and shared motion biases to active objects
Object_ApplyCameraMotion:                               ; CODE XREF: Sys_StoryScreenMainLoop:loc_491C   p  ; was: sub_1C97A
                                        ; UI_UpdateOptionsScreen+46   p
                tst.b   (byte_FF813E).w
                bpl.s   Object_ApplyCameraMotion_Begin
                rts
; ---------------------------------------------------------------------------
Object_ApplyCameraMotion_Begin:                         ; CODE XREF: Object_ApplyCameraMotion+4   j  ; was: loc_1C982
                movea.l #Object_CameraPriorityTable,a0
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),(word_FF8092).w
                move.w  (dword_FFA900).w,d0
                sub.w   (word_FFA928).w,d0
                move.w  (dword_FFA904).w,d1
                sub.w   (word_FFA92C).w,d1
                move.w  d0,(dword_FFA910).w
                move.w  d1,(word_FFA914).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                btst    #6,(byte_FFA959).w
                beq.s   Object_ApplyCameraMotion_CheckVerticalDelta
                moveq   #0,d0
Object_ApplyCameraMotion_CheckVerticalDelta:            ; CODE XREF: Object_ApplyCameraMotion+48   j  ; was: loc_1C9C6
                btst    #7,(byte_FFA959).w
                beq.s   Object_ApplyCameraMotion_CheckMotion
                moveq   #0,d1
Object_ApplyCameraMotion_CheckMotion:                   ; CODE XREF: Object_ApplyCameraMotion+52   j  ; was: loc_1C9D0
                tst.w   d0
                bne.s   Object_ApplyCameraMotion_WithCameraDelta
                tst.w   d1
                beq.w   Object_ApplyCameraMotion_WithoutCameraDelta
Object_ApplyCameraMotion_WithCameraDelta:               ; CODE XREF: Object_ApplyCameraMotion+58   j  ; was: loc_1C9DA
                move.b  #3,d5
                move.b  #2,d6
                move.b  #0,d7
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   Object_ApplyCameraMotion_ScanVisible
                bsr.w   Physics_ApplyVelocityWithBounds
                bsr.w   Physics_ApplyPositionOffset
                bsr.w   Object_ClampToPlayfield
Object_ApplyCameraMotion_ScanVisible:                   ; CODE XREF: Object_ApplyCameraMotion+74   j  ; was: loc_1C9FC
                move.w  (word_FFF75A).w,d4
                beq.s   Object_ApplyCameraMotion_ReturnWithDelta
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
Object_ApplyCameraMotion_VisibleLoop:                   ; CODE XREF: Object_ApplyCameraMotion:Object_ApplyCameraMotion_NextVisible   j  ; was: loc_1CA08
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   Object_ApplyCameraMotion_NextVisible
                btst    d5,d2
                beq.s   Object_ApplyCameraMotion_ApplyHorizontalVelocity
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
Object_ApplyCameraMotion_ApplyHorizontalVelocity:       ; CODE XREF: Object_ApplyCameraMotion+98   j  ; was: loc_1CA1C
                btst    d6,d2
                beq.s   Object_ApplyCameraMotion_ApplyVerticalVelocity
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
Object_ApplyCameraMotion_ApplyVerticalVelocity:         ; CODE XREF: Object_ApplyCameraMotion+A4   j  ; was: loc_1CA28
                btst    d7,d2
                beq.s   Object_ApplyCameraMotion_NextVisible
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
Object_ApplyCameraMotion_NextVisible:                   ; CODE XREF: Object_ApplyCameraMotion+94   j  ; was: loc_1CA34
                                        ; Object_ApplyCameraMotion+B0   j
                dbf     d4,Object_ApplyCameraMotion_VisibleLoop
Object_ApplyCameraMotion_ReturnWithDelta:               ; CODE XREF: Object_ApplyCameraMotion+86   j  ; was: locret_1CA38
                rts
; ---------------------------------------------------------------------------
Object_ApplyCameraMotion_WithoutCameraDelta:            ; CODE XREF: Object_ApplyCameraMotion+5C   j  ; was: loc_1CA3A
                move.b  #3,d5
                move.b  #2,d6
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   Object_ApplyCameraMotion_ScanStationary
                bsr.w   Physics_ApplyVelocityWithBounds
                bsr.w   Object_ClampToPlayfield
Object_ApplyCameraMotion_ScanStationary:                ; CODE XREF: Object_ApplyCameraMotion+D0   j  ; was: loc_1CA54
                move.w  (word_FFF75A).w,d4
                beq.s   Object_ApplyCameraMotion_Return
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
Object_ApplyCameraMotion_StationaryLoop:                ; CODE XREF: Object_ApplyCameraMotion:Object_ApplyCameraMotion_NextStationary   j  ; was: loc_1CA60
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   Object_ApplyCameraMotion_NextStationary
                btst    d5,d2
                beq.s   Object_ApplyCameraMotion_ApplyStationaryHorizontalVelocity
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
Object_ApplyCameraMotion_ApplyStationaryHorizontalVelocity:  ; CODE XREF: Object_ApplyCameraMotion+F0   j  ; was: loc_1CA74
                btst    d6,d2
                beq.s   Object_ApplyCameraMotion_NextStationary
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
Object_ApplyCameraMotion_NextStationary:                ; CODE XREF: Object_ApplyCameraMotion+EC   j  ; was: loc_1CA80
                                        ; Object_ApplyCameraMotion+FC   j
                dbf     d4,Object_ApplyCameraMotion_StationaryLoop
Object_ApplyCameraMotion_Return:                        ; CODE XREF: Object_ApplyCameraMotion+DE   j  ; was: locret_1CA84
                rts
; End of function Object_ApplyCameraMotion
; Applies velocity with boundary clamping
Physics_ApplyVelocityWithBounds:                        ; CODE XREF: Object_ApplyCameraMotion+76   p  ; was: sub_1CA86
                                        ; Object_ApplyCameraMotion+D2   p
                btst    d5,d2
                beq.s   Physics_ApplyVelocityWithBounds_ProcessVertical
                move.l  $18(a5),d3
                move.l  (dword_FF8240).w,d4
                btst    #1,(byte_FF8244).w
                beq.s   Physics_ApplyVelocityWithBounds_AddHorizontalBias
                asr.l   #2,d4
Physics_ApplyVelocityWithBounds_AddHorizontalBias:      ; CODE XREF: Physics_ApplyVelocityWithBounds+12   j  ; was: loc_1CA9C
                add.l   d4,d3
                move.l  (dword_FFA938).w,d4
                tst.l   d3
                bmi.s   Physics_ApplyVelocityWithBounds_ClampNegativeHorizontal
                cmp.l   d4,d3
                bmi.s   Physics_ApplyVelocityWithBounds_ApplyHorizontal
                move.l  d4,d3
                bra.s   Physics_ApplyVelocityWithBounds_ApplyHorizontal
; ---------------------------------------------------------------------------
Physics_ApplyVelocityWithBounds_ClampNegativeHorizontal:  ; CODE XREF: Physics_ApplyVelocityWithBounds+1E   j  ; was: loc_1CAAE
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   Physics_ApplyVelocityWithBounds_ApplyHorizontal
                move.l  d4,d3
Physics_ApplyVelocityWithBounds_ApplyHorizontal:        ; CODE XREF: Physics_ApplyVelocityWithBounds+22   j  ; was: loc_1CAB6
                                        ; Physics_ApplyVelocityWithBounds+26   j
                add.l   d3,$10(a5)
Physics_ApplyVelocityWithBounds_ProcessVertical:        ; CODE XREF: Physics_ApplyVelocityWithBounds+2   j  ; was: loc_1CABA
                btst    d6,d2
                beq.s   Physics_ApplyVelocityWithBounds_Return
                move.l  $1C(a5),d3
                add.l   (dword_FF830A).w,d3
                move.l  (dword_FFA93C).w,d4
                tst.l   d3
                bmi.s   Physics_ApplyVelocityWithBounds_ClampNegativeVertical
                cmp.l   d4,d3
                bmi.s   Physics_ApplyVelocityWithBounds_ApplyVertical
                move.l  d4,d3
                bra.s   Physics_ApplyVelocityWithBounds_ApplyVertical
; ---------------------------------------------------------------------------
Physics_ApplyVelocityWithBounds_ClampNegativeVertical:  ; CODE XREF: Physics_ApplyVelocityWithBounds+46   j  ; was: loc_1CAD6
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   Physics_ApplyVelocityWithBounds_ApplyVertical
                move.l  d4,d3
Physics_ApplyVelocityWithBounds_ApplyVertical:          ; CODE XREF: Physics_ApplyVelocityWithBounds+4A   j  ; was: loc_1CADE
                                        ; Physics_ApplyVelocityWithBounds+4E   j
                add.l   d3,$14(a5)
Physics_ApplyVelocityWithBounds_Return:                 ; CODE XREF: Physics_ApplyVelocityWithBounds+36   j  ; was: locret_1CAE2
                rts
; End of function Physics_ApplyVelocityWithBounds
; Applies position offset based on direction flags
Physics_ApplyPositionOffset:                            ; CODE XREF: Object_ApplyCameraMotion+7A   p  ; was: sub_1CAE4
                btst    d7,d2
                beq.s   Physics_ApplyPositionOffset_Return
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
Physics_ApplyPositionOffset_Return:                     ; CODE XREF: Physics_ApplyPositionOffset+2   j  ; was: locret_1CAF0
                rts
; End of function Physics_ApplyPositionOffset
; Clamps an object's position to the enabled playfield bounds
Object_ClampToPlayfield:                                ; CODE XREF: Object_ApplyCameraMotion+7E   p  ; was: sub_1CAF2
                                        ; Object_ApplyCameraMotion+D6   p
                btst    #1,(byte_FF8245).w
                bne.s   Object_ClampToPlayfield_CheckTop
                cmpi.w  #$90,$10(a5)
                bpl.s   Object_ClampToPlayfield_CheckRight
                move.w  #$90,$10(a5)
                bra.s   Object_ClampToPlayfield_CheckTop
; ---------------------------------------------------------------------------
Object_ClampToPlayfield_CheckRight:                     ; CODE XREF: Object_ClampToPlayfield+E   j  ; was: loc_1CB0A
                cmpi.w  #$1B0,$10(a5)
                bmi.s   Object_ClampToPlayfield_CheckTop
                move.w  #$1AF,$10(a5)
Object_ClampToPlayfield_CheckTop:                       ; CODE XREF: Object_ClampToPlayfield+6   j  ; was: loc_1CB18
                                        ; Object_ClampToPlayfield+16   j
                btst    #2,(byte_FF8245).w
                bne.s   Object_ClampToPlayfield_Return
                cmpi.w  #$98,$14(a5)
                bpl.s   Object_ClampToPlayfield_Return
                move.w  #$98,$14(a5)
Object_ClampToPlayfield_Return:                         ; CODE XREF: Object_ClampToPlayfield+2C   j  ; was: locret_1CB2E
                                        ; Object_ClampToPlayfield+34   j
                rts
; End of function Object_ClampToPlayfield
Sys_GameplayPreUpdateNoOp:                              ; CODE XREF: Sys_GameplayMainLoop   p  ; was: nullsub_2
                rts
; End of function Sys_GameplayPreUpdateNoOp
