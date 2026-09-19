; Queues a BGM request unless music playback is disabled in the options flags
Sound_QueueBGMRequest:                                  ; CODE XREF: EndingSequence_Initialize+A0   p  ; was: sub_34DA
                                        ; Results_WaitThenStoreTimeBonus+14   p
                btst    #1,(SoundDisableFlags+1).w
                beq.s   Sound_QueueRequest
                rts
; End of function Sound_QueueBGMRequest
; Queues an SFX request unless sound effects are disabled in the options flags
Sound_QueueSFXRequest:                                  ; CODE XREF: StoryTitle_RevealLogoCharacters+158   p  ; was: sub_34E4
                                        ; StoryTitle_ExpandCompletedLogo+10E   p
                btst    #2,(SoundDisableFlags+1).w
                beq.s   Sound_QueueRequest
                rts
; End of function Sound_QueueSFXRequest
; Adds one sound-driver request to the first empty slot, suppressing duplicates
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
