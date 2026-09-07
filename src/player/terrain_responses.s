Physics_DispatchSlopeHandler:                           ; CODE XREF: Physics_MultiPointTerrainCheck+5E   j  ; was: sub_14C12
                                        ; Physics_TerrainCheckWithVelocity+70   j
                                        ; DATA XREF:
                cmpi.w  #$80,d2
                bmi.w   Physics_SetSolidTerrainFlag
                bset    #1,6(a5)
                andi.w  #$7E,d2                         ; '~'
                subi.w  #$40,d2                         ; '@'
                bmi.w   Physics_SnapToSurface
                movea.w off_14C38(pc,d2.w),a4
                adda.l  #Physics_TerrainEmptyHandler,a4
                jmp     (a4)
; End of function Physics_DispatchSlopeHandler
; ---------------------------------------------------------------------------
off_14C38:      dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                                        ; DATA XREF: Physics_DispatchSlopeHandler+1A   r
                dc.w    Physics_SnapToSurface-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_SnapToSurface-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_SnapAndSubtract4-Physics_TerrainEmptyHandler
                dc.w    Physics_PrepareVertical4Down-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Boss_DestroyerMK2EntryInit-Physics_TerrainEmptyHandler
                dc.w    Physics_SnapAndAdd4-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler
                dc.w    Physics_TerrainEmptyHandler-Physics_TerrainEmptyHandler

; Empty terrain angle physics handler
Physics_TerrainEmptyHandler:                            ; CODE XREF: Physics_ProcessTerrainAngle+4   j  ; was: nullsub_35
                                        ; Physics_ProcessTerrainAngle+1A   j
                rts
; End of function Physics_TerrainEmptyHandler
; Sets solid terrain collision flag (bit 2 in collision flags)
Physics_SetSolidTerrainFlag:                            ; CODE XREF: Physics_HandleCeilingCollision+4   j  ; was: sub_14C6A
                                        ; Physics_ApplyAcceleration+4   j
                bset    #2,6(a5)
                rts
; End of function Physics_SetSolidTerrainFlag
; Snaps player position to floor surface
Player_SnapToFloor:                                     ; CODE XREF: Player_HandleCollision+1A   j  ; was: sub_14C72
                                        ; Player_HandleFloorCollision+1A   j
                clr.l   $1C(a5)
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                andi.w  #7,d4
                sub.w   d4,$14(a5)
                rts
; End of function Player_SnapToFloor
; Snaps player position to terrain surface
Physics_SnapToSurface:                                  ; CODE XREF: Physics_HandleCeilingCollision+16   j  ; was: sub_14C86
                                        ; Physics_ApplyAcceleration+16   j
                clr.l   $1C(a5)
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$14(a5)
                rts
; End of function Physics_SnapToSurface
; Snaps to floor and subtracts 12 pixels
Physics_SnapFloorMinus12:                               ; DATA XREF: ROM:0001495C   o  ; was: sub_14C9E
                bsr.w   Physics_PrepareFloorOffset8
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorMinus12
; Snaps to floor and subtracts 4 pixels
Physics_SnapFloorMinus4:                                ; DATA XREF: ROM:000149CE   o  ; was: sub_14CAA
                                        ; ROM:00014A28   o
                bsr.s   Physics_PrepareFloorOffset8
                subq.w  #4,$14(a5)
                rts
; End of function Physics_SnapFloorMinus4
; Snaps to floor and adds 4 pixels
Physics_SnapAndAdd4:                                    ; DATA XREF: ROM:00014A82   o  ; was: sub_14CB2
                                        ; ROM:00014B44   o
                bsr.s   Physics_PrepareFloorOffset8
                addq.w  #4,$14(a5)
                rts
; End of function Physics_SnapAndAdd4
; Snaps to floor and adds 12 pixels
Physics_SnapFloorPlus12:                                ; DATA XREF: ROM:00014BA6   o  ; was: sub_14CBA
                bsr.s   Physics_PrepareFloorOffset8
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorPlus12
; Calculates floor offset minus 12 pixels
Physics_CalcFloorMinus12:                               ; DATA XREF: ROM:0001495E   o  ; was: sub_14CC4
                bsr.s   Physics_CalculateFloorOffset4
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_CalcFloorMinus12
; Calculates floor offset and subtracts 4
Physics_CalcFloorOffsetSubtract4:                       ; DATA XREF: ROM:000149D0   o  ; was: sub_14CCE
                                        ; ROM:00014A2A   o
                bsr.s   Physics_CalculateFloorOffset4
                subq.w  #4,$14(a5)
                rts
; End of function Physics_CalcFloorOffsetSubtract4
; Boss entry animation init
Boss_DestroyerMK2EntryInit:                             ; DATA XREF: ROM:00014A84   o  ; was: sub_14CD6
                                        ; ROM:00014B42   o
                bsr.s   Physics_CalculateFloorOffset4
                addq.w  #4,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryInit
; Calculates floor offset plus 12 pixels
Physics_CalcFloorPlus12:                                ; DATA XREF: ROM:00014BA4   o  ; was: sub_14CDE
                bsr.s   Physics_CalculateFloorOffset4
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_CalcFloorPlus12
; Prepares d3=8 for floor offset
Physics_PrepareFloorOffset8:                            ; CODE XREF: Physics_SnapFloorMinus12   p  ; was: sub_14CE8
                                        ; sub_14CAA   p
                moveq   #8,d3
                bra.s   Physics_AlignToFloorWithOffset
; End of function Physics_PrepareFloorOffset8
; Calculates floor offset d3=4 base
Physics_CalculateFloorOffset4:                          ; CODE XREF: Physics_CalcFloorMinus12   p  ; was: sub_14CEC
                                        ; sub_14CCE   p
                moveq   #4,d3
; Aligns entity to floor with calculated pixel offset
Physics_AlignToFloorWithOffset:                         ; CODE XREF: Physics_PrepareFloorOffset8+2   j  ; was: loc_14CEE
                bsr.w   Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #1,d4
                addq.w  #1,d4
                sub.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_CalculateFloorOffset4
; Applies vertical offset of 4 pixels
Physics_ApplyVerticalOffset4:                           ; DATA XREF: ROM:00014A30   o  ; was: sub_14D08
                                        ; ROM:00014B9E   o
                bsr.s   Physics_PrepareVerticalOffset
                addq.w  #4,$14(a5)
                rts
; End of function Physics_ApplyVerticalOffset4
; Prepares vertical offset 12 pixels down
Physics_PrepareVertical12Down:                          ; DATA XREF: ROM:000149D6   o  ; was: sub_14D10
                bsr.s   Physics_PrepareVerticalOffset
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_PrepareVertical12Down
; Prepares vertical offset 4 pixels down
Physics_PrepareVertical4Down:                           ; DATA XREF: ROM:00014964   o  ; was: sub_14D1A
                                        ; ROM:00014A8A   o
                bsr.s   Physics_PrepareVerticalOffset
                subq.w  #4,$14(a5)
                rts
; End of function Physics_PrepareVertical4Down
; Prepares vertical offset 12 pixels up
Physics_PrepareVertical12Up:                            ; DATA XREF: ROM:00014B3C   o  ; was: sub_14D22
                bsr.s   Physics_PrepareVerticalOffset
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_PrepareVertical12Up
; Snaps to floor and adds 4 pixels
Physics_SnapFloorAdd4:                                  ; DATA XREF: ROM:00014A32   o  ; was: sub_14D2C
                                        ; ROM:00014B9C   o
                bsr.s   Physics_SnapToFloorNoOffset
                addq.w  #4,$14(a5)
                rts
; End of function Physics_SnapFloorAdd4
; Snaps to floor and subtracts 12 pixels
Physics_SnapFloorSub12:                                 ; DATA XREF: ROM:000149D8   o  ; was: sub_14D34
                bsr.s   Physics_SnapToFloorNoOffset
                subi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorSub12
; Snaps to floor and subtracts 4 pixels
Physics_SnapAndSubtract4:                               ; DATA XREF: ROM:00014966   o  ; was: sub_14D3E
                                        ; ROM:00014A8C   o
                bsr.s   Physics_SnapToFloorNoOffset
                subq.w  #4,$14(a5)
                rts
; End of function Physics_SnapAndSubtract4
; Snaps to floor and adds 12 pixels
Physics_SnapFloorAdd12:                                 ; DATA XREF: ROM:00014B3A   o  ; was: sub_14D46
                bsr.s   Physics_SnapToFloorNoOffset
                addi.w  #$C,$14(a5)
                rts
; End of function Physics_SnapFloorAdd12
; Prepares d3=4 for vertical offset
Physics_PrepareVerticalOffset:                          ; CODE XREF: Physics_ApplyVerticalOffset4   p  ; was: sub_14D50
                                        ; sub_14D10   p
                moveq   #4,d3
                bra.s   loc_14D56
; End of function Physics_PrepareVerticalOffset
; Snaps entity to floor without offset
Physics_SnapToFloorNoOffset:                            ; CODE XREF: Physics_SnapFloorAdd4   p  ; was: sub_14D54
                                        ; sub_14D34   p
                moveq   #0,d3
loc_14D56:                                              ; CODE XREF: Physics_PrepareVerticalOffset+2   j
                bsr.w   Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #6,d4
                asr.w   #1,d4
                add.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_SnapToFloorNoOffset
; Prepares 8-pixel offset subtracts 10
Physics_Prepare8Sub10:                                  ; DATA XREF: ROM:0001496C   o  ; was: sub_14D6E
                bsr.w   Physics_PrepareVerticalOffset8
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Prepare8Sub10
; Prepares 8-pixel offset subtracts 6
Physics_Prepare8Sub6:                                   ; DATA XREF: ROM:000149DE   o  ; was: sub_14D7A
                bsr.s   Physics_PrepareVerticalOffset8
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Prepare8Sub6
; Prepares 8-pixel offset subtracts 2
Physics_Prepare8Sub2:                                   ; DATA XREF: ROM:00014A38   o  ; was: sub_14D82
                bsr.s   Physics_PrepareVerticalOffset8
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare8Sub2
; Snaps to floor and adds 2 pixels
Physics_SnapAndAdd2:                                    ; DATA XREF: ROM:00014A92   o  ; was: sub_14D8A
                bsr.s   Physics_PrepareVerticalOffset8
                addq.w  #2,$14(a5)
                rts
; End of function Physics_SnapAndAdd2
; Prepares 6-pixel offset subtracts 10
Physics_Prepare6Sub10:                                  ; DATA XREF: ROM:0001496E   o  ; was: sub_14D92
                bsr.s   Physics_PrepareVerticalOffset6
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Prepare6Sub10
; Prepares 6-pixel offset subtracts 6
Physics_Prepare6Sub6:                                   ; DATA XREF: ROM:000149E0   o  ; was: sub_14D9C
                bsr.s   Physics_PrepareVerticalOffset6
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Prepare6Sub6
; Prepares 6-pixel offset subtracts 2
Physics_Prepare6Sub2:                                   ; DATA XREF: ROM:00014A3A   o  ; was: sub_14DA4
                bsr.s   Physics_PrepareVerticalOffset6
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare6Sub2
; Prepares 6-pixel offset adds 2
Physics_Prepare6Add2:                                   ; DATA XREF: ROM:00014A94   o  ; was: sub_14DAC
                bsr.s   Physics_PrepareVerticalOffset6
                addq.w  #2,$14(a5)
                rts
; End of function Physics_Prepare6Add2
; Applies 4-pixel offset subtracts 10
Physics_Apply4Sub10:                                    ; DATA XREF: ROM:00014970   o  ; was: sub_14DB4
                bsr.s   Physics_ApplyFloorOffset4
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_Apply4Sub10
; Applies 4-pixel offset subtracts 6
Physics_Apply4Sub6:                                     ; DATA XREF: ROM:000149E2   o  ; was: sub_14DBE
                bsr.s   Physics_ApplyFloorOffset4
                subq.w  #6,$14(a5)
                rts
; End of function Physics_Apply4Sub6
; Applies 4-pixel offset subtracts 2
Physics_Apply4Sub2:                                     ; DATA XREF: ROM:00014A3C   o  ; was: sub_14DC6
                bsr.s   Physics_ApplyFloorOffset4
                subq.w  #2,$14(a5)
                rts
; End of function Physics_Apply4Sub2
; Applies 4-pixel offset adds 2
Physics_Apply4Add2:                                     ; DATA XREF: ROM:00014A96   o  ; was: sub_14DCE
                bsr.s   Physics_ApplyFloorOffset4
                addq.w  #2,$14(a5)
                rts
; End of function Physics_Apply4Add2
; Boss entry movement
Boss_DestroyerMK2EntryMove:                             ; DATA XREF: ROM:00014972   o  ; was: sub_14DD6
                bsr.s   Boss_DestroyerMK2BattleStart
                subi.w  #$A,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryMove
; Starts DestroyerMK2 battle moves 6 down
Boss_DestroyerMK2Sub6:                                  ; DATA XREF: ROM:000149E4   o  ; was: sub_14DE0
                bsr.s   Boss_DestroyerMK2BattleStart
                subq.w  #6,$14(a5)
                rts
; End of function Boss_DestroyerMK2Sub6
; Starts DestroyerMK2 battle moves 2 down
Boss_DestroyerMK2Sub2:                                  ; DATA XREF: ROM:00014A3E   o  ; was: sub_14DE8
                bsr.s   Boss_DestroyerMK2BattleStart
                subq.w  #2,$14(a5)
                rts
; End of function Boss_DestroyerMK2Sub2
; Boss entry stop position
Boss_DestroyerMK2EntryStop:                             ; DATA XREF: ROM:00014A98   o  ; was: sub_14DF0
                bsr.s   Boss_DestroyerMK2BattleStart
                addq.w  #2,$14(a5)
                rts
; End of function Boss_DestroyerMK2EntryStop
; Prepares d3=8 for vertical offset
Physics_PrepareVerticalOffset8:                         ; CODE XREF: Physics_Prepare8Sub10   p  ; was: sub_14DF8
                                        ; sub_14D7A   p
                moveq   #8,d3
                bra.s   loc_14E06
; End of function Physics_PrepareVerticalOffset8
; Prepares d3=6 for vertical offset
Physics_PrepareVerticalOffset6:                         ; CODE XREF: Physics_Prepare6Sub10   p  ; was: sub_14DFC
                                        ; sub_14D9C   p
                moveq   #6,d3
                bra.s   loc_14E06
; End of function Physics_PrepareVerticalOffset6
; Applies 4-pixel floor offset for terrain alignment
Physics_ApplyFloorOffset4:                              ; CODE XREF: Physics_Apply4Sub10   p  ; was: sub_14E00
                                        ; sub_14DBE   p
                moveq   #4,d3
                bra.s   loc_14E06
; End of function Physics_ApplyFloorOffset4
; Battle start initialization
Boss_DestroyerMK2BattleStart:                           ; CODE XREF: Boss_DestroyerMK2EntryMove   p  ; was: sub_14E04
                                        ; sub_14DE0   p
                moveq   #2,d3
loc_14E06:                                              ; CODE XREF: Physics_PrepareVerticalOffset8+2   j
                                        ; Physics_PrepareVerticalOffset6+2   j
                bsr.w   Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #2,d4
                addq.w  #1,d4
                sub.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Boss_DestroyerMK2BattleStart
; Applies vertical physics offset -6
Physics_ApplyOffset6Down:                               ; DATA XREF: ROM:00014974   o  ; was: sub_14E20
                bsr.w   Physics_PrepareVerticalOffset5
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset6Down
; Applies vertical physics offset -10
Physics_ApplyOffset10Down:                              ; DATA XREF: ROM:000149E6   o  ; was: sub_14E2A
                bsr.s   Physics_PrepareVerticalOffset5
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset10Down
; Prepares vertical offset 5 and adds 2 to Y position
Physics_ApplyOffset5Up:                                 ; DATA XREF: ROM:00014A40   o  ; was: sub_14E34
                bsr.s   Physics_PrepareVerticalOffset5
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset5Up
; Prepares vertical offset 5 and subtracts 2 from Y position
Physics_ApplyOffset5Down:                               ; DATA XREF: ROM:00014A9A   o  ; was: sub_14E3C
                bsr.s   Physics_PrepareVerticalOffset5
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset5Down
; Prepares vertical offset 3 and subtracts 6 from Y position
Physics_ApplyOffset3Down6:                              ; DATA XREF: ROM:00014976   o  ; was: sub_14E44
                bsr.s   Physics_PrepareVerticalOffset3
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down6
; Prepares vertical offset 3 and subtracts 10 from Y position
Physics_ApplyOffset3Down10:                             ; DATA XREF: ROM:000149E8   o  ; was: sub_14E4C
                bsr.s   Physics_PrepareVerticalOffset3
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down10
; Prepares vertical offset 3 and adds 2 to Y position
Physics_ApplyOffset3Up:                                 ; DATA XREF: ROM:00014A42   o  ; was: sub_14E56
                bsr.s   Physics_PrepareVerticalOffset3
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset3Up
; Prepares vertical offset 3 and subtracts 2 from Y position
Physics_ApplyOffset3Down:                               ; DATA XREF: ROM:00014A9C   o  ; was: sub_14E5E
                bsr.s   Physics_PrepareVerticalOffset3
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset3Down
; Prepares vertical offset 1 and subtracts 6 from Y position
Physics_ApplyOffset1Down6:                              ; DATA XREF: ROM:00014978   o  ; was: sub_14E66
                bsr.s   Physics_PrepareVerticalOffset1
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down6
; Prepares vertical offset 1 and subtracts 10 from Y position
Physics_ApplyOffset1Down10:                             ; DATA XREF: ROM:000149EA   o  ; was: sub_14E6E
                bsr.s   Physics_PrepareVerticalOffset1
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down10
; Prepares vertical offset 1 and adds 2 to Y position
Physics_ApplyOffset1Up:                                 ; DATA XREF: ROM:00014A44   o  ; was: sub_14E78
                bsr.s   Physics_PrepareVerticalOffset1
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset1Up
; Prepares vertical offset 1 and subtracts 2 from Y position
Physics_ApplyOffset1Down:                               ; DATA XREF: ROM:00014A9E   o  ; was: sub_14E80
                bsr.s   Physics_PrepareVerticalOffset1
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffset1Down
; Prepares negative offset and subtracts 6 from Y position
Physics_ApplyOffsetNegDown6:                            ; DATA XREF: ROM:0001497A   o  ; was: sub_14E88
                bsr.s   Physics_PrepareOffsetNeg
                subq.w  #6,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown6
; Prepares negative offset and subtracts 10 from Y position
Physics_ApplyOffsetNegDown10:                           ; DATA XREF: ROM:000149EC   o  ; was: sub_14E90
                bsr.s   Physics_PrepareOffsetNeg
                subi.w  #$A,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown10
; Prepares negative offset and adds 2 to Y position
Physics_ApplyOffsetNegUp:                               ; DATA XREF: ROM:00014A46   o  ; was: sub_14E9A
                bsr.s   Physics_PrepareOffsetNeg
                addq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegUp
; Prepares negative offset and subtracts 2 from Y position
Physics_ApplyOffsetNegDown:                             ; DATA XREF: ROM:00014AA0   o  ; was: sub_14EA2
                bsr.s   Physics_PrepareOffsetNeg
                subq.w  #2,$14(a5)
                rts
; End of function Physics_ApplyOffsetNegDown
; Prepares d3=5 for vertical offset
Physics_PrepareVerticalOffset5:                         ; CODE XREF: Physics_ApplyOffset6Down   p  ; was: sub_14EAA
                                        ; sub_14E2A   p
                moveq   #5,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset5
; Prepares d3=3 for vertical offset
Physics_PrepareVerticalOffset3:                         ; CODE XREF: Physics_ApplyOffset3Down6   p  ; was: sub_14EAE
                                        ; sub_14E4C   p
                moveq   #3,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset3
; Prepares d3=1 for vertical offset
Physics_PrepareVerticalOffset1:                         ; CODE XREF: Physics_ApplyOffset1Down6   p  ; was: sub_14EB2
                                        ; sub_14E6E   p
                moveq   #1,d3
                bra.s   loc_14EB8
; End of function Physics_PrepareVerticalOffset1
; Prepares negative vertical offset
Physics_PrepareOffsetNeg:                               ; CODE XREF: Physics_ApplyOffsetNegDown6   p  ; was: sub_14EB6
                                        ; sub_14E90   p
                moveq   #$FFFFFFFF,d3
loc_14EB8:                                              ; CODE XREF: Physics_PrepareVerticalOffset5+2   j
                                        ; Physics_PrepareVerticalOffset3+2   j
                bsr.w   Player_SnapToFloor
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                asr.w   #2,d4
                addq.w  #1,d4
                add.w   d4,d3
                add.w   d3,$14(a5)
                rts
; End of function Physics_PrepareOffsetNeg
; Updates boss sprite animation frame
Sprite_UpdateBossAnimation:                             ; CODE XREF: Physics_EntityWallCheck+3C   p  ; was: sub_14ED2
                                        ; Physics_BossTerrainCheck+5A   j
                bset    #1,7(a5)
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                addq.w  #1,d4
                sub.w   d4,$10(a5)
                rts
; End of function Sprite_UpdateBossAnimation
; Handles wall collision and adjusts position
Physics_HandleWallCollision:                            ; CODE XREF: Physics_EntityWallCheck+24   p  ; was: sub_14EEA
                                        ; Physics_BossTerrainCheck+2E   p
                bset    #0,7(a5)
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                addq.w  #1,d4
                add.w   d4,$10(a5)
                rts
; End of function Physics_HandleWallCollision
; Initializes player stats and parameters
