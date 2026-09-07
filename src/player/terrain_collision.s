Player_ActionDispatcher:                              ; CODE XREF: Player_ProcessAction+10   j  ; was: sub_146FC
                                        ; Player_DirectionDispatcher+16   j ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1471E
                bsr.w Physics_ProcessTerrainAngle
                bra.s   loc_1472E
; ---------------------------------------------------------------------------
loc_1471E:                              ; CODE XREF: Player_ActionDispatcher+1A   j
                moveq   #8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1472E
                bsr.w Player_TerrainAngleDispatcher
loc_1472E:                              ; CODE XREF: Player_ActionDispatcher+20   j
                                        ; Player_ActionDispatcher+2C   j
                moveq   #0,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1473E
                bra.w Player_HandleCollision
; ---------------------------------------------------------------------------
loc_1473E:                              ; CODE XREF: Player_ActionDispatcher+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1474E
                bra.w Player_HandleFloorCollision
; ---------------------------------------------------------------------------
loc_1474E:                              ; CODE XREF: Player_ActionDispatcher+4C   j
                moveq   #8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_1475E
                bra.w Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
locret_1475E:                           ; CODE XREF: Player_ActionDispatcher+5C   j
                rts
; End of function Player_ActionDispatcher
; Checks player collision with terrain
Player_CheckTerrainCollision:                              ; CODE XREF: Player_UpdateTerrainCheck+10   j  ; was: sub_14760
                                        ; Enemy_MainStateMachine+13E   p ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14782
                bsr.w Physics_ProcessTerrainAngle
                bra.s   loc_14792
; ---------------------------------------------------------------------------
loc_14782:                              ; CODE XREF: Player_CheckTerrainCollision+1A   j
                moveq   #8,d0
                moveq   #$18,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14792
                bsr.w Player_TerrainAngleDispatcher
loc_14792:                              ; CODE XREF: Player_CheckTerrainCollision+20   j
                                        ; Player_CheckTerrainCollision+2C   j
                moveq   #0,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147A8
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Player_HandleCollision
; ---------------------------------------------------------------------------
loc_147A8:                              ; CODE XREF: Player_CheckTerrainCollision+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147BE
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Player_HandleFloorCollision
; ---------------------------------------------------------------------------
loc_147BE:                              ; CODE XREF: Player_CheckTerrainCollision+52   j
                moveq   #8,d0
                moveq   #$20,d1 ; ' '
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_147D4
                tst.w   $1C(a5)
                bmi.s   locret_147D4
                bra.w Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
locret_147D4:                           ; CODE XREF: Player_CheckTerrainCollision+42   j
                                        ; Player_CheckTerrainCollision+58   j ...
                rts
; End of function Player_CheckTerrainCollision
; Performs terrain collision checks at multiple points
Physics_MultiPointTerrainCheck:                              ; CODE XREF: Player_TerrainCheckStandard+10   j  ; was: sub_147D6
                                        ; Player_DirectionDispatcher+1A   j
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_147F8
                bsr.w Physics_UpdateVelocity
                bra.s   loc_14808
; ---------------------------------------------------------------------------
loc_147F8:                              ; CODE XREF: Physics_MultiPointTerrainCheck+1A   j
                moveq   #8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14808
                bsr.w Physics_CheckAngleRange
loc_14808:                              ; CODE XREF: Physics_MultiPointTerrainCheck+20   j
                                        ; Physics_MultiPointTerrainCheck+2C   j
                moveq   #0,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14818
                bra.w Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
loc_14818:                              ; CODE XREF: Physics_MultiPointTerrainCheck+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14828
                bra.w Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
loc_14828:                              ; CODE XREF: Physics_MultiPointTerrainCheck+4C   j
                moveq   #8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_14838
                bra.w Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
locret_14838:                           ; CODE XREF: Physics_MultiPointTerrainCheck+5C   j
                rts
; End of function Physics_MultiPointTerrainCheck
; Terrain collision check with vertical velocity validation
Physics_TerrainCheckWithVelocity:                              ; CODE XREF: Player_TerrainCheckAlternate+10   j  ; was: sub_1483A
                                        ; sub_2C71E:loc_2C86E   j ...
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1485C
                bsr.w Physics_UpdateVelocity
                bra.s   loc_1486C
; ---------------------------------------------------------------------------
loc_1485C:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+1A   j
                moveq   #8,d0
                moveq   #$FFFFFFE8,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_1486C
                bsr.w Physics_CheckAngleRange
loc_1486C:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+20   j
                                        ; Physics_TerrainCheckWithVelocity+2C   j
                moveq   #0,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14882
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
loc_14882:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+3C   j
                moveq   #$FFFFFFF8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   loc_14898
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
loc_14898:                              ; CODE XREF: Physics_TerrainCheckWithVelocity+52   j
                moveq   #8,d0
                moveq   #$FFFFFFE0,d1
                bsr.w Physics_GetTerrainTileData
                move.w  d2,d2
                beq.s   locret_148AE
                tst.w   $1C(a5)
                bpl.s   locret_148AE
                bra.w Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
locret_148AE:                           ; CODE XREF: Physics_TerrainCheckWithVelocity+42   j
                                        ; Physics_TerrainCheckWithVelocity+58   j ...
                rts
; End of function Physics_TerrainCheckWithVelocity
; Handles player collision states
Player_HandleCollision:                              ; CODE XREF: Player_ActionDispatcher+3E   j  ; was: sub_148B0
                                        ; Player_CheckTerrainCollision+44   j
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_DispatchTerrainHandler
                bset    #2,6(a5)
; Dispatches to appropriate terrain angle handler based on tile type
Physics_DispatchTerrainHandler:                              ; CODE XREF: Player_HandleCollision+A   j  ; was: loc_148C2
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_148DA(pc,d2.w),a4
                adda.l  #Physics_ProcessTerrainAngle,a4
                jmp     (a4)
; End of function Player_HandleCollision
; ---------------------------------------------------------------------------
off_148DA:      dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                                        ; DATA XREF: Player_HandleCollision+1E   r
                dc.w Player_SnapToFloor-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Player_SnapToFloor-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareFloorOffset8-Physics_ProcessTerrainAngle
                dc.w Physics_CalculateFloorOffset4-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset-Physics_ProcessTerrainAngle
                dc.w Physics_SnapToFloorNoOffset-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_TerrainEmptyHandler-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset8-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset6-Physics_ProcessTerrainAngle
                dc.w Physics_ApplyFloorOffset4-Physics_ProcessTerrainAngle
                dc.w Boss_DestroyerMK2BattleStart-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset5-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset3-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareVerticalOffset1-Physics_ProcessTerrainAngle
                dc.w Physics_PrepareOffsetNeg-Physics_ProcessTerrainAngle


; Processes terrain collision based on surface angle
Physics_ProcessTerrainAngle:                              ; CODE XREF: Player_ActionDispatcher+1C   p  ; was: sub_1490A
                                        ; Player_CheckTerrainCollision+1C   p
                                        ; DATA XREF: ...
                cmpi.w  #$10,d2
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$C0,d2
                bpl.w Physics_HandleWallCollision
                move.w  d2,d3
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s Physics_DispatchAngleHandler
                bset    #0,6(a5)
                cmpi.w  #$80,d3
                bpl.s Physics_DispatchAngleHandler
                bset    #2,6(a5)
; Dispatches to terrain angle calculation handler
Physics_DispatchAngleHandler:                              ; CODE XREF: Physics_ProcessTerrainAngle+22   j  ; was: loc_14940
                                        ; Physics_ProcessTerrainAngle+2E   j
                movea.w off_1494C(pc,d2.w),a4
                adda.l  #Player_TerrainAngleDispatcher,a4
                jmp     (a4)
; End of function Physics_ProcessTerrainAngle
; ---------------------------------------------------------------------------
off_1494C:      dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                                        ; DATA XREF: Physics_ProcessTerrainAngle:loc_14940   r
                dc.w Physics_HandleWallCollision-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_HandleWallCollision-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_SnapFloorMinus12-Player_TerrainAngleDispatcher
                dc.w Physics_CalcFloorMinus12-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_PrepareVertical4Down-Player_TerrainAngleDispatcher
                dc.w Physics_SnapAndSubtract4-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_TerrainEmptyHandler-Player_TerrainAngleDispatcher
                dc.w Physics_Prepare8Sub10-Player_TerrainAngleDispatcher
                dc.w Physics_Prepare6Sub10-Player_TerrainAngleDispatcher
                dc.w Physics_Apply4Sub10-Player_TerrainAngleDispatcher
                dc.w Boss_DestroyerMK2EntryMove-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset6Down-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset3Down6-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffset1Down6-Player_TerrainAngleDispatcher
                dc.w Physics_ApplyOffsetNegDown6-Player_TerrainAngleDispatcher


; Dispatches player terrain collision handler based on angle range
Player_TerrainAngleDispatcher:                              ; CODE XREF: Player_ActionDispatcher+2E   p  ; was: sub_1497C
                                        ; Player_CheckTerrainCollision+2E   p
                                        ; DATA XREF: ...
                cmpi.w  #$10,d2
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$C0,d2
                bpl.w Sprite_UpdateBossAnimation
                move.w  d2,d3
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s Physics_DispatchFloorHandler
                bset    #0,6(a5)
                cmpi.w  #$80,d3
                bpl.s Physics_DispatchFloorHandler
                bset    #2,6(a5)
; Dispatches to floor collision handler based on tile type
Physics_DispatchFloorHandler:                              ; CODE XREF: Player_TerrainAngleDispatcher+22   j  ; was: loc_149B2
                                        ; Player_TerrainAngleDispatcher+2E   j
                movea.w off_149BE(pc,d2.w),a4
                adda.l  #Player_HandleFloorCollision,a4
                jmp     (a4)
; End of function Player_TerrainAngleDispatcher
; ---------------------------------------------------------------------------
off_149BE:      dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                                        ; DATA XREF: Player_TerrainAngleDispatcher:loc_149B2   r
                dc.w Sprite_UpdateBossAnimation-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Sprite_UpdateBossAnimation-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_SnapFloorMinus4-Player_HandleFloorCollision
                dc.w Physics_CalcFloorOffsetSubtract4-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_PrepareVertical12Down-Player_HandleFloorCollision
                dc.w Physics_SnapFloorSub12-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Player_HandleFloorCollision
                dc.w Physics_Prepare8Sub6-Player_HandleFloorCollision
                dc.w Physics_Prepare6Sub6-Player_HandleFloorCollision
                dc.w Physics_Apply4Sub6-Player_HandleFloorCollision
                dc.w Boss_DestroyerMK2Sub6-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset10Down-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset3Down10-Player_HandleFloorCollision
                dc.w Physics_ApplyOffset1Down10-Player_HandleFloorCollision
                dc.w Physics_ApplyOffsetNegDown10-Player_HandleFloorCollision


; Handles player collision with floor
Player_HandleFloorCollision:                              ; CODE XREF: Player_ActionDispatcher+4E   j  ; was: sub_149EE
                                        ; Player_CheckTerrainCollision+5A   j
                                        ; DATA XREF: ...
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_ProcessFloorTile
                bset    #2,6(a5)
; Processes floor tile collision and dispatches to angle handler
Physics_ProcessFloorTile:                              ; CODE XREF: Player_HandleFloorCollision+A   j  ; was: loc_14A00
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_14A18(pc,d2.w),a4
                adda.l  #Physics_HandleFloorCollision,a4
                jmp     (a4)
; End of function Player_HandleFloorCollision
; ---------------------------------------------------------------------------
off_14A18:      dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                                        ; DATA XREF: Player_HandleFloorCollision+1E   r
                dc.w Player_SnapToFloor-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Player_SnapToFloor-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_SnapFloorMinus4-Physics_HandleFloorCollision
                dc.w Physics_CalcFloorOffsetSubtract4-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_ApplyVerticalOffset4-Physics_HandleFloorCollision
                dc.w Physics_SnapFloorAdd4-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleFloorCollision
                dc.w Physics_Prepare8Sub2-Physics_HandleFloorCollision
                dc.w Physics_Prepare6Sub2-Physics_HandleFloorCollision
                dc.w Physics_Apply4Sub2-Physics_HandleFloorCollision
                dc.w Boss_DestroyerMK2Sub2-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset5Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset3Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffset1Up-Physics_HandleFloorCollision
                dc.w Physics_ApplyOffsetNegUp-Physics_HandleFloorCollision


; Handles floor collision and sets ground state
Physics_HandleFloorCollision:                              ; CODE XREF: Player_ActionDispatcher+5E   j  ; was: sub_14A48
                                        ; Player_CheckTerrainCollision+70   j
                                        ; DATA XREF: ...
                bset    #0,6(a5)
                cmpi.w  #$80,d2
                bpl.s Physics_ProcessCeilingTile
                bset    #2,6(a5)
; Processes ceiling tile collision and dispatches to angle handler
Physics_ProcessCeilingTile:                              ; CODE XREF: Physics_HandleFloorCollision+A   j  ; was: loc_14A5A
                andi.w  #$7E,d2 ; '~'
                cmpi.w  #$40,d2 ; '@'
                bpl.w Player_SnapToFloor
                movea.w off_14A72(pc,d2.w),a4
                adda.l  #Physics_HandleCeilingCollision,a4
                jmp     (a4)
; End of function Physics_HandleFloorCollision
; ---------------------------------------------------------------------------
off_14A72:      dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                                        ; DATA XREF: Physics_HandleFloorCollision+1E   r
                dc.w Player_SnapToFloor-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Player_SnapToFloor-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndAdd4-Physics_HandleCeilingCollision
                dc.w Boss_DestroyerMK2EntryInit-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_PrepareVertical4Down-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndSubtract4-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_TerrainEmptyHandler-Physics_HandleCeilingCollision
                dc.w Physics_SnapAndAdd2-Physics_HandleCeilingCollision
                dc.w Physics_Prepare6Add2-Physics_HandleCeilingCollision
                dc.w Physics_Apply4Add2-Physics_HandleCeilingCollision
                dc.w Boss_DestroyerMK2EntryStop-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset5Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset3Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffset1Down-Physics_HandleCeilingCollision
                dc.w Physics_ApplyOffsetNegDown-Physics_HandleCeilingCollision


; Handles ceiling collision based on angle
Physics_HandleCeilingCollision:                              ; CODE XREF: Physics_MultiPointTerrainCheck+3E   j  ; was: sub_14AA2
                                        ; Physics_TerrainCheckWithVelocity+44   j
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.w Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_SnapToSurface
                movea.w off_14AC8(pc,d2.w),a4
                adda.l  #Physics_UpdateVelocity,a4
                jmp     (a4)
; End of function Physics_HandleCeilingCollision
; ---------------------------------------------------------------------------
off_14AC8:      dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                                        ; DATA XREF: Physics_HandleCeilingCollision+1A   r
                dc.w Physics_SnapToSurface-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_SnapToSurface-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_SnapToFloorNoOffset-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_CalculateFloorOffset4-Physics_UpdateVelocity
                dc.w Physics_PrepareFloorOffset8-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_TerrainEmptyHandler-Physics_UpdateVelocity
                dc.w Physics_PrepareOffsetNeg-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset1-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset3-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset5-Physics_UpdateVelocity
                dc.w Boss_DestroyerMK2BattleStart-Physics_UpdateVelocity
                dc.w Physics_ApplyFloorOffset4-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset6-Physics_UpdateVelocity
                dc.w Physics_PrepareVerticalOffset8-Physics_UpdateVelocity


; Updates entity velocity with acceleration application
Physics_UpdateVelocity:                              ; CODE XREF: Physics_MultiPointTerrainCheck+1C   p  ; was: sub_14AF8
                                        ; Physics_TerrainCheckWithVelocity+1C   p
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.s   loc_14B06
                cmpi.w  #$C0,d2
                bmi.w Physics_HandleWallCollision
loc_14B06:                              ; CODE XREF: Physics_UpdateVelocity+4   j
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s   loc_14B1E
                bset    #1,6(a5)
loc_14B1E:                              ; CODE XREF: Physics_UpdateVelocity+1E   j
                movea.w off_14B2A(pc,d2.w),a4
                adda.l  #Physics_CheckAngleRange,a4
                jmp     (a4)
; End of function Physics_UpdateVelocity
; ---------------------------------------------------------------------------
off_14B2A:      dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                                        ; DATA XREF: Physics_UpdateVelocity:loc_14B1E   r
                dc.w Physics_HandleWallCollision-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_HandleWallCollision-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_SnapFloorAdd12-Physics_CheckAngleRange
                dc.w Physics_PrepareVertical12Up-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Boss_DestroyerMK2EntryInit-Physics_CheckAngleRange
                dc.w Physics_SnapAndAdd4-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange
                dc.w Physics_TerrainEmptyHandler-Physics_CheckAngleRange


; Checks angle range for terrain slope
Physics_CheckAngleRange:                              ; CODE XREF: Physics_MultiPointTerrainCheck+2E   p  ; was: sub_14B5A
                                        ; Physics_TerrainCheckWithVelocity+2E   p
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.s   loc_14B68
                cmpi.w  #$C0,d2
                bmi.w Sprite_UpdateBossAnimation
loc_14B68:                              ; CODE XREF: Physics_CheckAngleRange+4   j
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_TerrainEmptyHandler
                cmpi.w  #$10,d2
                bmi.s   loc_14B80
                bset    #1,6(a5)
loc_14B80:                              ; CODE XREF: Physics_CheckAngleRange+1E   j
                movea.w off_14B8C(pc,d2.w),a4
                adda.l  #Physics_ApplyAcceleration,a4
                jmp     (a4)
; End of function Physics_CheckAngleRange
; ---------------------------------------------------------------------------
off_14B8C:      dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                                        ; DATA XREF: Physics_CheckAngleRange:loc_14B80   r
                dc.w Sprite_UpdateBossAnimation-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Sprite_UpdateBossAnimation-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_SnapFloorAdd4-Physics_ApplyAcceleration
                dc.w Physics_ApplyVerticalOffset4-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_CalcFloorPlus12-Physics_ApplyAcceleration
                dc.w Physics_SnapFloorPlus12-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration
                dc.w Physics_TerrainEmptyHandler-Physics_ApplyAcceleration


; Applies acceleration to entity physics state
Physics_ApplyAcceleration:                              ; CODE XREF: Physics_MultiPointTerrainCheck+4E   j  ; was: sub_14BBC
                                        ; Physics_TerrainCheckWithVelocity+5A   j
                                        ; DATA XREF: ...
                cmpi.w  #$80,d2
                bmi.w Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2 ; '~'
                subi.w  #$40,d2 ; '@'
                bmi.w Physics_SnapToSurface
                movea.w off_14BE2(pc,d2.w),a4
                adda.l  #Physics_DispatchSlopeHandler,a4
                jmp     (a4)
; End of function Physics_ApplyAcceleration
; ---------------------------------------------------------------------------
off_14BE2:      dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                                        ; DATA XREF: Physics_ApplyAcceleration+1A   r
                dc.w Physics_SnapToSurface-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_SnapToSurface-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_SnapFloorAdd4-Physics_DispatchSlopeHandler
                dc.w Physics_ApplyVerticalOffset4-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_CalcFloorOffsetSubtract4-Physics_DispatchSlopeHandler
                dc.w Physics_SnapFloorMinus4-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler
                dc.w Physics_TerrainEmptyHandler-Physics_DispatchSlopeHandler


; Processes terrain collision angle for slope handling
