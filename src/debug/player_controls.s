Input_ToggleDebugFlag:
                move.b  (byte_FFF705).w,d0              ; was: sub_1CB32
                bpl.w   Input_ToggleDebugFlag_Return
                btst    #6,d0
                beq.w   Input_ToggleDebugFlag_Return
                move.b  (word_FFF708).w,d0
                or.b    (word_FFF708+1).w,d0
                btst    #5,d0
                beq.w   Input_ToggleDebugFlag_Return
                eori.b  #$80,(byte_FFF746).w
Input_ToggleDebugFlag_Return:                           ; CODE XREF: Input_ToggleDebugFlag+4   j  ; was: locret_1CB58
                                        ; Input_ToggleDebugFlag+C   j
                rts
; End of function Input_ToggleDebugFlag
; Updates screen shake effect by modifying scroll registers with decay timer
Effect_ScreenShakeUpdate:                               ; CODE XREF: Sys_GameplayMainLoop+16A   p  ; was: sub_1CB5A
                tst.b   (byte_FF813E).w
                bmi.s   Effect_ScreenShakeUpdate_Return
                move.w  (word_FFA012).w,(word_FF8086).w
                move.w  (word_FFA016).w,(word_FF8088).w
                move.w  (word_FFA000).w,d0
                tst.w   (word_FFA010).w
                bne.s   Effect_ScreenShakeUpdate_UpdateHorizontal
Effect_ScreenShakeUpdate_ClearHorizontal:               ; CODE XREF: Effect_ScreenShakeUpdate+26   j  ; was: loc_1CB76
                clr.w   (word_FFA012).w
                bra.s   Effect_ScreenShakeUpdate_CheckVertical
; ---------------------------------------------------------------------------
Effect_ScreenShakeUpdate_UpdateHorizontal:              ; CODE XREF: Effect_ScreenShakeUpdate+1A   j  ; was: loc_1CB7C
                btst    #1,d0
                bne.s   Effect_ScreenShakeUpdate_ClearHorizontal
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   Effect_ScreenShakeUpdate_StoreHorizontal
                subq.w  #1,(word_FFA010).w
Effect_ScreenShakeUpdate_StoreHorizontal:               ; CODE XREF: Effect_ScreenShakeUpdate+2E   j  ; was: loc_1CB8E
                move.w  (word_FFA010).w,(word_FFA012).w
Effect_ScreenShakeUpdate_CheckVertical:                 ; CODE XREF: Effect_ScreenShakeUpdate+20   j  ; was: loc_1CB94
                tst.w   (word_FFA014).w
                bne.s   Effect_ScreenShakeUpdate_UpdateVertical
Effect_ScreenShakeUpdate_ClearVertical:                 ; CODE XREF: Effect_ScreenShakeUpdate+4A   j  ; was: loc_1CB9A
                clr.w   (word_FFA016).w
                rts
; ---------------------------------------------------------------------------
Effect_ScreenShakeUpdate_UpdateVertical:                ; CODE XREF: Effect_ScreenShakeUpdate+3E   j  ; was: loc_1CBA0
                btst    #1,d0
                bne.s   Effect_ScreenShakeUpdate_ClearVertical
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   Effect_ScreenShakeUpdate_StoreVertical
                subq.w  #1,(word_FFA014).w
Effect_ScreenShakeUpdate_StoreVertical:                 ; CODE XREF: Effect_ScreenShakeUpdate+52   j  ; was: loc_1CBB2
                move.w  (word_FFA014).w,(word_FFA016).w
Effect_ScreenShakeUpdate_Return:                        ; CODE XREF: Effect_ScreenShakeUpdate+4   j  ; was: locret_1CBB8
                rts
; End of function Effect_ScreenShakeUpdate
; Debug Y-axis camera adjustment
Camera_DebugAdjustY:
                btst    #4,(word_FFF706+1).w            ; was: sub_1CBBA
                beq.w   Camera_DebugAdjustY_Return
                btst    #0,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustY_CheckDown
                addq.w  #1,(word_FFA00E).w
Camera_DebugAdjustY_CheckDown:                          ; CODE XREF: Camera_DebugAdjustY+10   j  ; was: loc_1CBD2
                btst    #1,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustY_Return
                subq.w  #1,(word_FFA00E).w
Camera_DebugAdjustY_Return:                             ; CODE XREF: Camera_DebugAdjustY+6   j  ; was: locret_1CBE0
                                        ; Camera_DebugAdjustY+1E   j
                rts
; End of function Camera_DebugAdjustY
; Debug XY camera adjustment
Camera_DebugAdjustXY:
                btst    #4,(word_FFF706+1).w            ; was: sub_1CBE2
                bne.w   Camera_DebugAdjustXY_Return
                btst    #0,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustXY_CheckDown
                subi.w  #$20,(word_FFA00C).w            ; ' '
Camera_DebugAdjustXY_CheckDown:                         ; CODE XREF: Camera_DebugAdjustXY+10   j  ; was: loc_1CBFC
                btst    #1,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustXY_CheckLeft
                addi.w  #$20,(word_FFA00C).w            ; ' '
Camera_DebugAdjustXY_CheckLeft:                         ; CODE XREF: Camera_DebugAdjustXY+20   j  ; was: loc_1CC0C
                btst    #2,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustXY_CheckRight
                subi.w  #$20,(word_FFA00A).w            ; ' '
Camera_DebugAdjustXY_CheckRight:                        ; CODE XREF: Camera_DebugAdjustXY+30   j  ; was: loc_1CC1C
                btst    #3,(word_FFF708+1).w
                beq.w   Camera_DebugAdjustXY_Return
                addi.w  #$20,(word_FFA00A).w            ; ' '
Camera_DebugAdjustXY_Return:                            ; CODE XREF: Camera_DebugAdjustXY+6   j  ; was: locret_1CC2C
                                        ; Camera_DebugAdjustXY+40   j
                rts
; End of function Camera_DebugAdjustXY
; Process debug movement inputs
Input_ProcessDebugMovement:
                clr.l   (dword_FFA9D0).w                ; was: sub_1CC2E
                clr.l   (dword_FFA9D4).w
                btst    #0,(word_FFF706+1).w
                beq.w   Input_ProcessDebugMovement_CheckDown
                move.w  #$FFFF,(dword_FFA9D4).w
Input_ProcessDebugMovement_CheckDown:                   ; CODE XREF: Input_ProcessDebugMovement+E   j  ; was: loc_1CC46
                btst    #1,(word_FFF706+1).w
                beq.w   Input_ProcessDebugMovement_CheckLeft
                move.w  #1,(dword_FFA9D4).w
Input_ProcessDebugMovement_CheckLeft:                   ; CODE XREF: Input_ProcessDebugMovement+1E   j  ; was: loc_1CC56
                btst    #2,(word_FFF706+1).w
                beq.w   Input_ProcessDebugMovement_CheckRight
                move.w  #$FFFF,(dword_FFA9D0).w
Input_ProcessDebugMovement_CheckRight:                  ; CODE XREF: Input_ProcessDebugMovement+2E   j  ; was: loc_1CC66
                btst    #3,(word_FFF706+1).w
                beq.w   Input_ProcessDebugMovement_CheckAttack
                move.w  #1,(dword_FFA9D0).w
Input_ProcessDebugMovement_CheckAttack:                 ; CODE XREF: Input_ProcessDebugMovement+3E   j  ; was: loc_1CC76
                btst    #6,(word_FFF708+1).w
                beq.w   Input_ProcessDebugMovement_CheckJump
                move.w  #1,(word_FFA9C0).w
Input_ProcessDebugMovement_CheckJump:                   ; CODE XREF: Input_ProcessDebugMovement+4E   j  ; was: loc_1CC86
                btst    #4,(word_FFF708+1).w
                beq.w   Input_ProcessDebugMovement_Return
                move.w  #1,(word_FFA980).w
Input_ProcessDebugMovement_Return:                      ; CODE XREF: Input_ProcessDebugMovement+5E   j  ; was: locret_1CC96
                rts
; End of function Input_ProcessDebugMovement
; Display debug marker sprites
Sprite_DisplayDebugMarker:
                lea     Sprite_DebugMarkerData(pc),a0   ; was: sub_1CC98
                nop
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Sprite_DisplayDebugMarker
; ---------------------------------------------------------------------------
Sprite_DebugMarkerData: dc.w    $100, $F80, $4300, $100, $140, $F80, $8300, $140, $FFFF  ; was: word_1CCA4
                                        ; DATA XREF: Sprite_DisplayDebugMarker   o
