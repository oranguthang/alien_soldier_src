Input_InitControllerState:                              ; CODE XREF: Sys_ClearGameBuffers+C   p  ; was: sub_33A4
                clr.b   (byte_FFF705).w
                move.w  #$FFFF,(ControllerHeldState).w
                move.w  #0,(ControllerPressedState).w
                move.w  #0,(ControllerReleasedState).w
; End of function Input_InitControllerState
; Acquires Z80 bus for sound operations
Sound_AcquireZ80Bus:                                    ; CODE XREF: Sys_VBlankHandler+18   p  ; was: sub_33BA
                                        ; Sound_AcquireZ80Bus+8   j
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_AcquireZ80Bus
                bsr.w   Input_ReadController
                bsr.w   Input_ReadSecondaryController
Sound_AcquireZ80Bus_ReleaseWait:                        ; CODE XREF: Sound_AcquireZ80Bus+1A   j  ; was: loc_33CC
                bclr    #0,(IO_Z80BUS).l
                beq.s   Sound_AcquireZ80Bus_ReleaseWait
                rts
; End of function Sound_AcquireZ80Bus
; Reads controller input from I/O ports
Input_ReadController:                                   ; CODE XREF: Sound_AcquireZ80Bus+A   p  ; was: sub_33D8
                lea     (ControllerHeldState).w,a1
                lea     ((IO_CT1_DATA+1)).l,a2
                lea     (P1ButtonASourceBit).w,a3
                bsr.w   Input_ReadControllerPort
                move.b  d0,(Controller1TypeID).w
                cmpi.b  #$D,d0
                beq.w   Input_ReadController_ReadButtons
                bra.w   Input_ReadController_Disconnected
; End of function Input_ReadController
; Reads secondary controller port processing button states
Input_ReadSecondaryController:                          ; CODE XREF: Sound_AcquireZ80Bus+E   p  ; was: sub_33FA
                lea     ((ControllerHeldState+1)).w,a1
                lea     ((IO_CT2_DATA+1)).l,a2
                lea     (P2ButtonASourceBit).w,a3
                bsr.w   Input_ReadControllerPort
                move.b  d0,(Controller2TypeID).w
                cmpi.b  #$D,d0
                beq.w   Input_ReadController_ReadButtons
Input_ReadController_Disconnected:                      ; CODE XREF: Input_ReadController+1E   j  ; was: loc_3418
                clr.b   (a1)
                clr.b   2(a1)
                clr.b   4(a1)
                rts
; ---------------------------------------------------------------------------
Input_ReadController_ReadButtons:                       ; CODE XREF: Input_ReadController+1A   j  ; was: loc_3424
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
                beq.w   Input_MapSecondaryButtons_Return
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
                beq.w   Input_TestAndSetBit_Clear
                bset    d2,d0
                rts
; ---------------------------------------------------------------------------
Input_TestAndSetBit_Clear:                              ; CODE XREF: Input_TestAndSetBit+2   j  ; was: loc_3496
                bclr    d2,d0
Input_MapSecondaryButtons_Return:                       ; CODE XREF: Input_MapSecondaryButtons+6   j  ; was: locret_3498
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
; Queue a BGM request unless music playback is disabled in the options flags
Sound_QueueBGMRequest:                                  ; CODE XREF: EndingSequence_Initialize+A0   p  ; was: sub_34DA
                                        ; Results_FinishTimeBonusSpin+14   p
                btst    #1,(SoundDisableFlags+1).w
                beq.s   Sound_QueueRequest
                rts
; End of function Sound_QueueBGMRequest
; Plays sound effect with ID parameter
Sound_PlaySFX:                                          ; CODE XREF: StoryTitle_RevealLogoCharacters+158   p  ; was: sub_34E4
                                        ; StoryTitle_ExpandCompletedLogo+10E   p
                btst    #2,(SoundDisableFlags+1).w
                beq.s   Sound_QueueRequest
                rts
; End of function Sound_PlaySFX
; Add one sound-driver request to the first empty slot, suppressing duplicates
Sound_QueueRequest:                                     ; CODE XREF: RegionRestricted+E   p  ; was: sub_34EE
                                        ; Sys_VBlankEventHandler+1A   p
                tst.b   (SoundRequestQueue).w
                bpl.w   Sound_QueueRequestStoreSlot0
                cmp.b   (SoundRequestQueue).w,d0
                bne.w   Sound_QueueRequestCheckSlot1
Sound_QueueRequestStoreSlot0:                           ; CODE XREF: Sound_QueueRequest+4   j  ; was: loc_34FE
                move.b  d0,(SoundRequestQueue).w
                rts
; ---------------------------------------------------------------------------
Sound_QueueRequestCheckSlot1:                           ; CODE XREF: Sound_QueueRequest+C   j  ; was: loc_3504
                tst.b   (SoundRequestQueue+1).w
                bpl.w   Sound_QueueRequestStoreSlot1
                cmp.b   (SoundRequestQueue+1).w,d0
                bne.w   Sound_QueueRequestCheckSlot2
Sound_QueueRequestStoreSlot1:                           ; CODE XREF: Sound_QueueRequest+1A   j  ; was: loc_3514
                move.b  d0,(SoundRequestQueue+1).w
                rts
; ---------------------------------------------------------------------------
Sound_QueueRequestCheckSlot2:                           ; CODE XREF: Sound_QueueRequest+22   j  ; was: loc_351A
                tst.b   (SoundRequestQueue+2).w
                bpl.w   Sound_QueueRequestStoreSlot2
                cmp.b   (SoundRequestQueue+2).w,d0
                bne.w   Sound_QueueRequestCheckSlot3
Sound_QueueRequestStoreSlot2:                           ; CODE XREF: Sound_QueueRequest+30   j  ; was: loc_352A
                move.b  d0,(SoundRequestQueue+2).w
                rts
; ---------------------------------------------------------------------------
Sound_QueueRequestCheckSlot3:                           ; CODE XREF: Sound_QueueRequest+38   j  ; was: loc_3530
                tst.b   (SoundRequestQueue+3).w
                bpl.w   Sound_QueueRequestStoreSlot3
                cmp.b   (SoundRequestQueue+3).w,d0
                bne.w   Sound_QueueRequestNoFreeSlot
Sound_QueueRequestStoreSlot3:                           ; CODE XREF: Sound_QueueRequest+46   j  ; was: loc_3540
                move.b  d0,(SoundRequestQueue+3).w
                rts
; ---------------------------------------------------------------------------
Sound_QueueRequestNoFreeSlot:                           ; CODE XREF: Sound_QueueRequest+4E   j  ; was: loc_3546
                clr.b   d0
                rts
; End of function Sound_QueueRequest
; Calculates angle from object to player center
