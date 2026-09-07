Input_ToggleDebugFlag:
                move.b  (byte_FFF705).w,d0              ; was: sub_1CB32
                bpl.w   locret_1CB58
                btst    #6,d0
                beq.w   locret_1CB58
                move.b  (word_FFF708).w,d0
                or.b    (word_FFF708+1).w,d0
                btst    #5,d0
                beq.w   locret_1CB58
                eori.b  #$80,(byte_FFF746).w
locret_1CB58:                                           ; CODE XREF: Input_ToggleDebugFlag+4   j
                                        ; Input_ToggleDebugFlag+C   j
                rts
; End of function Input_ToggleDebugFlag
; Updates screen shake effect by modifying scroll registers with decay timer
Effect_ScreenShakeUpdate:                               ; CODE XREF: Sys_GameplayMainLoop+16A   p  ; was: sub_1CB5A
                tst.b   (byte_FF813E).w
                bmi.s   locret_1CBB8
                move.w  (word_FFA012).w,(word_FF8086).w
                move.w  (word_FFA016).w,(word_FF8088).w
                move.w  (word_FFA000).w,d0
                tst.w   (word_FFA010).w
                bne.s   loc_1CB7C
loc_1CB76:                                              ; CODE XREF: Effect_ScreenShakeUpdate+26   j
                clr.w   (word_FFA012).w
                bra.s   loc_1CB94
; ---------------------------------------------------------------------------
loc_1CB7C:                                              ; CODE XREF: Effect_ScreenShakeUpdate+1A   j
                btst    #1,d0
                bne.s   loc_1CB76
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   loc_1CB8E
                subq.w  #1,(word_FFA010).w
loc_1CB8E:                                              ; CODE XREF: Effect_ScreenShakeUpdate+2E   j
                move.w  (word_FFA010).w,(word_FFA012).w
loc_1CB94:                                              ; CODE XREF: Effect_ScreenShakeUpdate+20   j
                tst.w   (word_FFA014).w
                bne.s   loc_1CBA0
loc_1CB9A:                                              ; CODE XREF: Effect_ScreenShakeUpdate+4A   j
                clr.w   (word_FFA016).w
                rts
; ---------------------------------------------------------------------------
loc_1CBA0:                                              ; CODE XREF: Effect_ScreenShakeUpdate+3E   j
                btst    #1,d0
                bne.s   loc_1CB9A
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   loc_1CBB2
                subq.w  #1,(word_FFA014).w
loc_1CBB2:                                              ; CODE XREF: Effect_ScreenShakeUpdate+52   j
                move.w  (word_FFA014).w,(word_FFA016).w
locret_1CBB8:                                           ; CODE XREF: Effect_ScreenShakeUpdate+4   j
                rts
; End of function Effect_ScreenShakeUpdate
; Debug Y-axis camera adjustment
Camera_DebugAdjustY:
                btst    #4,(word_FFF706+1).w            ; was: sub_1CBBA
                beq.w   locret_1CBE0
                btst    #0,(word_FFF708+1).w
                beq.w   loc_1CBD2
                addq.w  #1,(word_FFA00E).w
loc_1CBD2:                                              ; CODE XREF: Camera_DebugAdjustY+10   j
                btst    #1,(word_FFF708+1).w
                beq.w   locret_1CBE0
                subq.w  #1,(word_FFA00E).w
locret_1CBE0:                                           ; CODE XREF: Camera_DebugAdjustY+6   j
                                        ; Camera_DebugAdjustY+1E   j
                rts
; End of function Camera_DebugAdjustY
; Debug XY camera adjustment
Camera_DebugAdjustXY:
                btst    #4,(word_FFF706+1).w            ; was: sub_1CBE2
                bne.w   locret_1CC2C
                btst    #0,(word_FFF708+1).w
                beq.w   loc_1CBFC
                subi.w  #$20,(word_FFA00C).w            ; ' '
loc_1CBFC:                                              ; CODE XREF: Camera_DebugAdjustXY+10   j
                btst    #1,(word_FFF708+1).w
                beq.w   loc_1CC0C
                addi.w  #$20,(word_FFA00C).w            ; ' '
loc_1CC0C:                                              ; CODE XREF: Camera_DebugAdjustXY+20   j
                btst    #2,(word_FFF708+1).w
                beq.w   loc_1CC1C
                subi.w  #$20,(word_FFA00A).w            ; ' '
loc_1CC1C:                                              ; CODE XREF: Camera_DebugAdjustXY+30   j
                btst    #3,(word_FFF708+1).w
                beq.w   locret_1CC2C
                addi.w  #$20,(word_FFA00A).w            ; ' '
locret_1CC2C:                                           ; CODE XREF: Camera_DebugAdjustXY+6   j
                                        ; Camera_DebugAdjustXY+40   j
                rts
; End of function Camera_DebugAdjustXY
; Process debug movement inputs
Input_ProcessDebugMovement:
                clr.l   (dword_FFA9D0).w                ; was: sub_1CC2E
                clr.l   (dword_FFA9D4).w
                btst    #0,(word_FFF706+1).w
                beq.w   loc_1CC46
                move.w  #$FFFF,(dword_FFA9D4).w
loc_1CC46:                                              ; CODE XREF: Input_ProcessDebugMovement+E   j
                btst    #1,(word_FFF706+1).w
                beq.w   loc_1CC56
                move.w  #1,(dword_FFA9D4).w
loc_1CC56:                                              ; CODE XREF: Input_ProcessDebugMovement+1E   j
                btst    #2,(word_FFF706+1).w
                beq.w   loc_1CC66
                move.w  #$FFFF,(dword_FFA9D0).w
loc_1CC66:                                              ; CODE XREF: Input_ProcessDebugMovement+2E   j
                btst    #3,(word_FFF706+1).w
                beq.w   loc_1CC76
                move.w  #1,(dword_FFA9D0).w
loc_1CC76:                                              ; CODE XREF: Input_ProcessDebugMovement+3E   j
                btst    #6,(word_FFF708+1).w
                beq.w   loc_1CC86
                move.w  #1,(word_FFA9C0).w
loc_1CC86:                                              ; CODE XREF: Input_ProcessDebugMovement+4E   j
                btst    #4,(word_FFF708+1).w
                beq.w   locret_1CC96
                move.w  #1,(word_FFA980).w
locret_1CC96:                                           ; CODE XREF: Input_ProcessDebugMovement+5E   j
                rts
; End of function Input_ProcessDebugMovement
; Display debug marker sprites
Sprite_DisplayDebugMarker:
                lea     word_1CCA4(pc),a0               ; was: sub_1CC98
                nop
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Sprite_DisplayDebugMarker
; ---------------------------------------------------------------------------
word_1CCA4:     dc.w    $100, $F80, $4300, $100, $140, $F80, $8300, $140, $FFFF
                                        ; DATA XREF: Sprite_DisplayDebugMarker   o

; Copy object data to buffer
Object_CopyDataBlock:
                move.w  (word_FFA402).w,(word_FFA802).w  ; was: sub_1CCB6
                move.l  (dword_FFA408).w,(dword_FFA808).w
                move.w  (word_FFA40C).w,(word_FFA80C).w
                move.w  (word_FFA40E).w,(word_FFA80E).w
                move.w  #$120,(word_FFA810).w
                move.w  #$F0,(word_FFA814).w
                clr.w   (word_FFA812).w
                clr.w   (word_FFA816).w
                clr.l   (dword_FFA818).w
                clr.l   (dword_FFA81C).w
                rts
; End of function Object_CopyDataBlock
; Sets password confirmation flag and jumps to initialization
