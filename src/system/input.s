Input_InitControllerState:                              ; CODE XREF: Sys_ClearGameBuffers+C   p  ; was: sub_33A4
                clr.b   (byte_FFF705).w
                move.w  #$FFFF,(word_FFF706).w
                move.w  #0,(word_FFF708).w
                move.w  #0,(word_FFF70A).w
; End of function Input_InitControllerState
; Acquires Z80 bus for sound operations
Sound_AcquireZ80Bus:                                    ; CODE XREF: Sys_VBlankHandler+18   p  ; was: sub_33BA
                                        ; Sound_AcquireZ80Bus+8   j
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_AcquireZ80Bus
                bsr.w   Input_ReadController
                bsr.w   Input_ReadSecondaryController
loc_33CC:                                               ; CODE XREF: Sound_AcquireZ80Bus+1A   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_33CC
                rts
; End of function Sound_AcquireZ80Bus
; Reads controller input from I/O ports
Input_ReadController:                                   ; CODE XREF: Sound_AcquireZ80Bus+A   p  ; was: sub_33D8
                lea     (word_FFF706).w,a1
                lea     ((IO_CT1_DATA+1)).l,a2
                lea     (byte_FFFF20).w,a3
                bsr.w   Input_ReadControllerPort
                move.b  d0,(byte_FFFF06).w
                cmpi.b  #$D,d0
                beq.w   loc_3424
                bra.w   loc_3418
; End of function Input_ReadController
; Reads secondary controller port processing button states
Input_ReadSecondaryController:                          ; CODE XREF: Sound_AcquireZ80Bus+E   p  ; was: sub_33FA
                lea     ((word_FFF706+1)).w,a1
                lea     ((IO_CT2_DATA+1)).l,a2
                lea     (byte_FFFF21).w,a3
                bsr.w   Input_ReadControllerPort
                move.b  d0,(byte_FFFF07).w
                cmpi.b  #$D,d0
                beq.w   loc_3424
loc_3418:                                               ; CODE XREF: Input_ReadController+1E   j
                clr.b   (a1)
                clr.b   2(a1)
                clr.b   4(a1)
                rts
; ---------------------------------------------------------------------------
loc_3424:                                               ; CODE XREF: Input_ReadController+1A   j
                                        ; Input_ReadSecondaryController+1A   j
                move.b  #0,(a2)
                nop
                nop
                move.b  (a2),d0
                add.b   d0,d0
                add.b   d0,d0
                andi.b  #$C0,d0
                move.b  #$40,(a2)                       ; '@'
                nop
                nop
                move.b  (a2),d1
                andi.b  #$3F,d1                         ; '?'
                or.b    d1,d0
                not.b   d0
                bsr.w   Input_MapSecondaryButtons
                move.b  (a1),d1
                move.b  d1,d2
                eor.b   d0,d2
                move.b  d0,(a1)
                and.b   d2,d1
                move.b  d1,4(a1)
                and.b   d2,d0
                move.b  d0,2(a1)
                rts
; End of function Input_ReadSecondaryController
; Maps secondary controller button bits to standard input format
Input_MapSecondaryButtons:                              ; CODE XREF: Input_ReadSecondaryController+4E   p  ; was: sub_3462
                btst    #6,(byte_FFF705).w
                beq.w   locret_3498
                move.b  d0,d1
                move.b  #6,d2
                move.b  (a3),d3
                bsr.w   Input_TestAndSetBit
                move.b  #4,d2
                move.b  2(a3),d3
                bsr.w   Input_TestAndSetBit
                move.b  #5,d2
                move.b  4(a3),d3
; End of function Input_MapSecondaryButtons
; Tests input bit and sets or clears corresponding output bit
Input_TestAndSetBit:                                    ; CODE XREF: Input_MapSecondaryButtons+12   p  ; was: sub_348C
                                        ; Input_MapSecondaryButtons+1E   p
                btst    d3,d1
                beq.w   loc_3496
                bset    d2,d0
                rts
; ---------------------------------------------------------------------------
loc_3496:                                               ; CODE XREF: Input_TestAndSetBit+2   j
                bclr    d2,d0
locret_3498:                                            ; CODE XREF: Input_MapSecondaryButtons+6   j
                rts
; End of function Input_TestAndSetBit
; Low-level controller port bit reading
Input_ReadControllerPort:                               ; CODE XREF: Input_ReadController+E   p  ; was: sub_349A
                                        ; Input_ReadSecondaryController+E   p
                move.b  #$40,(a2)                       ; '@'
                nop
                nop
                move.b  (a2),d0
                move.b  d0,d1
                lsl.b   #1,d1
                or.b    d1,d0
                move.b  d0,d1
                andi.b  #8,d0
                lsl.b   #1,d1
                andi.b  #4,d1
                move.b  #0,(a2)
                nop
                nop
                move.b  (a2),d2
                move.b  d2,d3
                lsr.b   #1,d3
                or.b    d3,d2
                move.b  d2,d3
                lsr.b   #1,d2
                andi.b  #2,d2
                andi.b  #1,d3
                or.b    d1,d0
                or.b    d2,d0
                or.b    d3,d0
                rts
; End of function Input_ReadControllerPort
; Waits for VBlank interrupt
Sys_WaitVBlank:                                         ; CODE XREF: Cutscene_InitCreditsScreen+A0   p  ; was: sub_34DA
                                        ; Text_CompleteWithSound+14   p
                btst    #1,(word_FFFF38+1).w
                beq.s   Input_ProcessButtons
                rts
; End of function Sys_WaitVBlank
; Plays sound effect with ID parameter
Sound_PlaySFX:                                          ; CODE XREF: Gfx_AnimateLettersExpand+158   p  ; was: sub_34E4
                                        ; Gfx_AnimateLettersExpandLarge+10E   p
                btst    #2,(word_FFFF38+1).w
                beq.s   Input_ProcessButtons
                rts
; End of function Sound_PlaySFX
; Processes joypad button state
Input_ProcessButtons:                                   ; CODE XREF: RegionRestricted+E   p  ; was: sub_34EE
                                        ; Sys_VBlankEventHandler+1A   p
                tst.b   (dword_FFF80A).w
                bpl.w   loc_34FE
                cmp.b   (dword_FFF80A).w,d0
                bne.w   loc_3504
loc_34FE:                                               ; CODE XREF: Input_ProcessButtons+4   j
                move.b  d0,(dword_FFF80A).w
                rts
; ---------------------------------------------------------------------------
loc_3504:                                               ; CODE XREF: Input_ProcessButtons+C   j
                tst.b   (dword_FFF80A+1).w
                bpl.w   loc_3514
                cmp.b   (dword_FFF80A+1).w,d0
                bne.w   loc_351A
loc_3514:                                               ; CODE XREF: Input_ProcessButtons+1A   j
                move.b  d0,(dword_FFF80A+1).w
                rts
; ---------------------------------------------------------------------------
loc_351A:                                               ; CODE XREF: Input_ProcessButtons+22   j
                tst.b   (dword_FFF80A+2).w
                bpl.w   loc_352A
                cmp.b   (dword_FFF80A+2).w,d0
                bne.w   loc_3530
loc_352A:                                               ; CODE XREF: Input_ProcessButtons+30   j
                move.b  d0,(dword_FFF80A+2).w
                rts
; ---------------------------------------------------------------------------
loc_3530:                                               ; CODE XREF: Input_ProcessButtons+38   j
                tst.b   (dword_FFF80A+3).w
                bpl.w   loc_3540
                cmp.b   (dword_FFF80A+3).w,d0
                bne.w   loc_3546
loc_3540:                                               ; CODE XREF: Input_ProcessButtons+46   j
                move.b  d0,(dword_FFF80A+3).w
                rts
; ---------------------------------------------------------------------------
loc_3546:                                               ; CODE XREF: Input_ProcessButtons+4E   j
                clr.b   d0
                rts
; End of function Input_ProcessButtons
; Calculates angle from object to player center
