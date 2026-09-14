; Unreferenced P2 up/down adjustment of the fine Y value
UnreferencedAdjustP2FineY:
                btst    #4,(ControllerHeldState+1).w    ; was: sub_1CBBA
                beq.w   UnreferencedAdjustP2FineY_Return
                btst    #0,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2FineY_CheckDecrease
                addq.w  #1,(P2DebugFineYValue).w
UnreferencedAdjustP2FineY_CheckDecrease:                ; CODE XREF: UnreferencedAdjustP2FineY+10   j  ; was: loc_1CBD2
                btst    #1,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2FineY_Return
                subq.w  #1,(P2DebugFineYValue).w
UnreferencedAdjustP2FineY_Return:                       ; CODE XREF: UnreferencedAdjustP2FineY+6   j  ; was: locret_1CBE0
                                        ; UnreferencedAdjustP2FineY+1E   j
                rts
; End of function UnreferencedAdjustP2FineY
; Unreferenced P2 directional adjustment of the coarse X/Y values
UnreferencedAdjustP2CoarseXY:
                btst    #4,(ControllerHeldState+1).w    ; was: sub_1CBE2
                bne.w   UnreferencedAdjustP2CoarseXY_Return
                btst    #0,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2CoarseXY_CheckDown
                subi.w  #$20,(P2DebugCoarseYValue).w    ; ' '
UnreferencedAdjustP2CoarseXY_CheckDown:                 ; CODE XREF: UnreferencedAdjustP2CoarseXY+10   j  ; was: loc_1CBFC
                btst    #1,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2CoarseXY_CheckLeft
                addi.w  #$20,(P2DebugCoarseYValue).w    ; ' '
UnreferencedAdjustP2CoarseXY_CheckLeft:                 ; CODE XREF: UnreferencedAdjustP2CoarseXY+20   j  ; was: loc_1CC0C
                btst    #2,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2CoarseXY_CheckRight
                subi.w  #$20,(P2DebugCoarseXValue).w    ; ' '
UnreferencedAdjustP2CoarseXY_CheckRight:                ; CODE XREF: UnreferencedAdjustP2CoarseXY+30   j  ; was: loc_1CC1C
                btst    #3,(ControllerPressedState+1).w
                beq.w   UnreferencedAdjustP2CoarseXY_Return
                addi.w  #$20,(P2DebugCoarseXValue).w    ; ' '
UnreferencedAdjustP2CoarseXY_Return:                    ; CODE XREF: UnreferencedAdjustP2CoarseXY+6   j  ; was: locret_1CC2C
                                        ; UnreferencedAdjustP2CoarseXY+40   j
                rts
; End of function UnreferencedAdjustP2CoarseXY
; Build second-controller debug movement, attack, and jump commands
Debug_BuildControllerCommands:
                clr.l   (DebugInputXDirection).w        ; was: sub_1CC2E
                clr.l   (DebugInputYDirection).w
                btst    #0,(ControllerHeldState+1).w
                beq.w   Debug_BuildControllerCommands_CheckDown
                move.w  #$FFFF,(DebugInputYDirection).w
Debug_BuildControllerCommands_CheckDown:                ; CODE XREF: Debug_BuildControllerCommands+E   j  ; was: loc_1CC46
                btst    #1,(ControllerHeldState+1).w
                beq.w   Debug_BuildControllerCommands_CheckLeft
                move.w  #1,(DebugInputYDirection).w
Debug_BuildControllerCommands_CheckLeft:                ; CODE XREF: Debug_BuildControllerCommands+1E   j  ; was: loc_1CC56
                btst    #2,(ControllerHeldState+1).w
                beq.w   Debug_BuildControllerCommands_CheckRight
                move.w  #$FFFF,(DebugInputXDirection).w
Debug_BuildControllerCommands_CheckRight:               ; CODE XREF: Debug_BuildControllerCommands+2E   j  ; was: loc_1CC66
                btst    #3,(ControllerHeldState+1).w
                beq.w   Debug_BuildControllerCommands_CheckAttack
                move.w  #1,(DebugInputXDirection).w
Debug_BuildControllerCommands_CheckAttack:              ; CODE XREF: Debug_BuildControllerCommands+3E   j  ; was: loc_1CC76
                btst    #6,(ControllerPressedState+1).w
                beq.w   Debug_BuildControllerCommands_CheckJump
                move.w  #1,(DebugAttackInput).w
Debug_BuildControllerCommands_CheckJump:                ; CODE XREF: Debug_BuildControllerCommands+4E   j  ; was: loc_1CC86
                btst    #4,(ControllerPressedState+1).w
                beq.w   Debug_BuildControllerCommands_Return
                move.w  #1,(DebugJumpInput).w
Debug_BuildControllerCommands_Return:                   ; CODE XREF: Debug_BuildControllerCommands+5E   j  ; was: locret_1CC96
                rts
; End of function Debug_BuildControllerCommands
; Appends two fixed, unreferenced OAM entries
UnreferencedAppendFixedOAMEntries:
                lea     UnreferencedFixedOAMEntries(pc),a0  ; was: sub_1CC98
                nop
                jmp     (Sprite_AppendOAMEntries).l
; End of function UnreferencedAppendFixedOAMEntries
; ---------------------------------------------------------------------------
UnreferencedFixedOAMEntries:    dc.w    $100, $F80, $4300, $100, $140, $F80, $8300, $140, $FFFF  ; was: word_1CCA4
                                        ; DATA XREF: UnreferencedAppendFixedOAMEntries   o
