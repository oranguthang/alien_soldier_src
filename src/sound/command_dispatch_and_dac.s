Sound_SelectPendingRequest:                             ; CODE XREF: Sound_UpdateDriver+1E   p  ; was: sub_829AA
                                        ; DATA XREF: Sound_UpdateDriver+1E   o
                lea     Sound_RequestPriorityTable(pc),a0
                lea     (byte_FFF80E).w,a1
                move.b  (byte_FFF800).w,d3
                moveq   #3,d4
Sound_ScanNextPendingRequestSlot:                       ; CODE XREF: Sound_SelectPendingRequest:Sound_ContinuePendingRequestScan   j  ; was: loc_829B8
                move.b  -(a1),d0
                move.b  d0,d1
                clr.b   (a1)
                subq.b  #1,d0
                bcs.s   Sound_ContinuePendingRequestScan
                andi.w  #$FF,d0
                move.b  (a0,d0.w),d2
                cmpi.b  #$FF,d2
                beq.w   Sound_SelectPriorityBypassRequest
                move.b  d2,d5
                andi.b  #$7F,d5
                move.b  d3,d6
                andi.b  #$7F,d6
                cmp.b   d6,d5
                bcs.s   Sound_ContinuePendingRequestScan
                move.b  d2,d3
                move.b  d1,(byte_FFF809).w
Sound_ContinuePendingRequestScan:                       ; CODE XREF: Sound_SelectPendingRequest+16   j  ; was: loc_829E8
                                        ; Sound_SelectPendingRequest+36   j
                dbf     d4,Sound_ScanNextPendingRequestSlot
                tst.b   d3
                bmi.s   Sound_SelectPendingRequestReturn
                move.b  d3,(byte_FFF800).w
Sound_SelectPendingRequestReturn:                       ; CODE XREF: Sound_SelectPendingRequest+44   j  ; was: locret_829F4
                rts
; ---------------------------------------------------------------------------
Sound_SelectPriorityBypassRequest:                      ; CODE XREF: Sound_SelectPendingRequest+24   j  ; was: loc_829F6
                move.b  d1,(byte_FFF809).w
                bra.s   Sound_ContinuePendingRequestClearLoop
; ---------------------------------------------------------------------------
Sound_ClearNextPendingRequestSlot:                      ; CODE XREF: Sound_SelectPendingRequest:Sound_ContinuePendingRequestClearLoop   j  ; was: loc_829FC
                move.b  -(a1),d0
                subq.b  #1,d0
                bcs.s   Sound_ClearCurrentPendingRequestSlot
                andi.w  #$FF,d0
                move.b  (a0,d0.w),d2
                cmpi.b  #$FF,d2
                beq.w   Sound_ContinuePendingRequestClearLoop
Sound_ClearCurrentPendingRequestSlot:                   ; CODE XREF: Sound_SelectPendingRequest+56   j  ; was: loc_82A12
                clr.b   (a1)
Sound_ContinuePendingRequestClearLoop:                  ; CODE XREF: Sound_SelectPendingRequest+50   j  ; was: loc_82A14
                                        ; Sound_SelectPendingRequest+64   j
                dbf     d4,Sound_ClearNextPendingRequestSlot
                rts
; End of function Sound_SelectPendingRequest
; Dispatch the selected driver-control, DAC, music, or SFX request by ID range
Sound_DispatchPendingRequest:                           ; CODE XREF: Sound_UpdateDriver:Sound_UpdateActiveChannels   p  ; was: sub_82A1A
                                        ; DATA XREF: Sound_UpdateDriver:Sound_UpdateActiveChannels   o
                moveq   #0,d7
                move.b  (byte_FFF809).w,d7
                move.b  #$FF,(byte_FFF809).w
                tst.b   d7
                beq.w   Sound_LoadZ80Driver
                cmpi.b  #$FF,d7
                beq.s   Sound_DispatchPendingRequestReturn
                cmpi.b  #1,d7
                bcs.w   Sound_StopAllPlayback
                cmpi.b  #$10,d7
                bcs.w   Sound_ValidateControlRequest
                cmpi.b  #$40,d7                         ; '@'
                bcs.w   Sound_ValidateVoiceDACRequest
                cmpi.b  #$81,d7
                bcs.w   Sound_LoadSFX
                cmpi.b  #$A0,d7
                bcs.w   Sound_LoadBGMRequest
                cmpi.b  #$F9,d7
                bcs.w   Sound_ValidateHighRangeSFXRequest
                cmpi.b  #$FD,d7
                bcs.w   Sound_LoadSpecialSFX
Sound_DispatchPendingRequestReturn:                     ; CODE XREF: Sound_DispatchPendingRequest+16   j  ; was: locret_82A6A
                rts
; ---------------------------------------------------------------------------
Sound_ValidateControlRequest:                           ; CODE XREF: Sound_DispatchPendingRequest+24   j  ; was: loc_82A6C
                cmpi.b  #5,d7
                bcs.w   Sound_DispatchControlRequest
                rts
; ---------------------------------------------------------------------------
Sound_DispatchControlRequest:                           ; CODE XREF: Sound_DispatchPendingRequest+56   j  ; was: loc_82A76
                subq.b  #1,d7
                lsl.w   #2,d7
                jmp     Sound_ControlRequestBranches(pc,d7.w)
; ---------------------------------------------------------------------------
Sound_ControlRequestBranches:                           ; CODE XREF: Sound_DispatchPendingRequest+60   j  ; was: loc_82A7E
                bra.w   Sound_StartMusicFadeOut
; ---------------------------------------------------------------------------
                bra.w   Sound_StopSFXAndRestoreBGMChannels
; ---------------------------------------------------------------------------
                bra.w   Sound_StopSpecialSFXAndRestoreBGMChannels
; ---------------------------------------------------------------------------
                bra.w   Sound_StopAllPlayback
; ---------------------------------------------------------------------------
Sound_ValidateVoiceDACRequest:                          ; CODE XREF: Sound_DispatchPendingRequest+2C   j  ; was: loc_82A8E
                cmpi.b  #$3F,d7                         ; '?'
                bcs.w   Sound_ProcessVoiceDACRequest
                rts
; ---------------------------------------------------------------------------
Sound_ProcessVoiceDACRequest:                           ; CODE XREF: Sound_DispatchPendingRequest+78   j  ; was: loc_82A98
                subi.b  #$10,d7
                ext.w   d7
                asl.w   #3,d7
                lea     (Sound_VoiceDACDescriptors).l,a0  ; 980 - PCMPart1
                                        ; A00 - PCMPart2
                                        ; A80 - PCMPart3
                                        ; B00 - PCMPart4
                                        ; B80 - PCMPart5
                                        ; C00 - PCMPart6
                                        ; C80 - PCMPart7
                                        ; D00 - PCMPart8
                                        ; D80 - PCMPart9
                lea     (a0,d7.w),a0
                btst    #0,5(a0)
                bne.w   Sound_SelectVoiceDACPlaybackSlot
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForVoiceDACStatusZ80Bus:                      ; CODE XREF: Sound_DispatchPendingRequest+B0   j  ; was: loc_82AC2
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForVoiceDACStatusZ80Bus
                move.b  (byte_A01FFC).l,d1
                move.b  (byte_A01F87).l,d2
                move.b  (byte_A01FA7).l,d3
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                move.b  d1,d6
                move.b  5(a0),d0
                andi.b  #$C0,d0
                btst    #0,d1
                bne.w   Sound_CompareActiveVoiceDACSlots
                andi.b  #$C0,d1
                cmp.b   d1,d0
                bcc.w   Sound_SubmitImmediateVoiceDACRequest
                rts
; ---------------------------------------------------------------------------
Sound_CompareActiveVoiceDACSlots:                       ; CODE XREF: Sound_DispatchPendingRequest+DC   j  ; was: loc_82B06
                andi.b  #$C0,d2
                andi.b  #$C0,d3
                cmp.b   d2,d0
                bcs.w   Sound_ProcessVoiceDACRequestReturn
                cmp.b   d3,d0
                bcc.w   Sound_SubmitImmediateVoiceDACRequest
                rts
; ---------------------------------------------------------------------------
Sound_SubmitImmediateVoiceDACRequest:                   ; CODE XREF: Sound_DispatchPendingRequest+E6   j  ; was: loc_82B1C
                                        ; Sound_DispatchPendingRequest+FC   j
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForImmediateVoiceDACZ80Bus:                   ; CODE XREF: Sound_DispatchPendingRequest+118   j  ; was: loc_82B2A
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForImmediateVoiceDACZ80Bus
                move.b  #$80,(byte_A01FFD).l
                move.b  0.w(a0),(byte_A01FE8).l
                move.b  1(a0),(byte_A01FE9).l
                move.b  2(a0),(byte_A01FE6).l
                move.b  3(a0),(byte_A01FE7).l
                move.b  4(a0),(byte_A01FFE).l
                move.b  5(a0),(byte_A01FFB).l
                move.b  6(a0),(byte_A01FFA).l
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                btst    #5,5(a0)
                beq.w   Sound_ProcessVoiceDACRequestReturn
                btst    #5,d6
                bne.w   Sound_ProcessVoiceDACRequestReturn
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   Sound_ProcessVoiceDACRequestReturn
                move.b  #1,(byte_FFF82B).w
Sound_ProcessVoiceDACRequestReturn:                     ; CODE XREF: Sound_DispatchPendingRequest+F6   j  ; was: locret_82BA0
                                        ; Sound_DispatchPendingRequest+16A   j
                rts
; ---------------------------------------------------------------------------
Sound_SelectVoiceDACPlaybackSlot:                       ; CODE XREF: Sound_DispatchPendingRequest+96   j  ; was: loc_82BA2
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForVoiceDACSlotStatusZ80Bus:                  ; CODE XREF: Sound_DispatchPendingRequest+19E   j  ; was: loc_82BB0
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForVoiceDACSlotStatusZ80Bus
                move.b  (byte_A01FFC).l,d1
                move.b  (byte_A01F87).l,d2
                move.b  (byte_A01FA7).l,d3
                move.b  (byte_A01F86).l,d4
                move.b  (byte_A01FA6).l,d5
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                move.b  d1,d6
                move.b  5(a0),d0
                andi.b  #$C0,d0
                btst    #0,d1
                bne.w   Sound_EvaluateVoiceDACSlotSelection
                andi.b  #$C0,d1
                cmp.b   d1,d0
                bcs.w   Sound_RejectVoiceDACSlotRequest
Sound_EvaluateVoiceDACSlotSelection:                    ; CODE XREF: Sound_DispatchPendingRequest+1D6   j  ; was: loc_82BFE
                andi.b  #$C0,d2
                andi.b  #$C0,d3
                move.b  6(a0),d1
                andi.b  #$C0,d1
                beq.w   Sound_SelectAvailableVoiceDACSlot
                cmpi.b  #$C0,d1
                beq.w   Sound_SelectAvailableVoiceDACSlot
                tst.b   d1
                bpl.w   Sound_CompareSecondaryVoiceDACPriority
                cmp.b   d2,d0
                bcc.w   Sound_StartPrimaryVoiceDACSlot
                rts
; ---------------------------------------------------------------------------
Sound_CompareSecondaryVoiceDACPriority:                 ; CODE XREF: Sound_DispatchPendingRequest+202   j  ; was: loc_82C28
                cmp.b   d3,d0
                bcc.w   Sound_StartSecondaryVoiceDACSlot
Sound_RejectVoiceDACSlotRequest:                        ; CODE XREF: Sound_DispatchPendingRequest+1E0   j  ; was: locret_82C2E
                rts
; ---------------------------------------------------------------------------
Sound_SelectAvailableVoiceDACSlot:                      ; CODE XREF: Sound_DispatchPendingRequest+1F4   j  ; was: loc_82C30
                                        ; Sound_DispatchPendingRequest+1FC   j
                tst.b   d4
                beq.w   Sound_StartPrimaryVoiceDACSlot
                tst.b   d5
                beq.w   Sound_StartSecondaryVoiceDACSlot
                btst    #0,(byte_FFF82C).w
                bne.w   Sound_SelectVoiceDACSlotByToggle
                cmp.b   d2,d0
                bcc.w   Sound_StartPrimaryVoiceDACSlot
                cmp.b   d3,d0
                bcc.w   Sound_StartSecondaryVoiceDACSlot
                rts
; ---------------------------------------------------------------------------
Sound_SelectVoiceDACSlotByToggle:                       ; CODE XREF: Sound_DispatchPendingRequest+228   j  ; was: loc_82C54
                cmp.b   d3,d0
                bcc.w   Sound_StartSecondaryVoiceDACSlot
                cmp.b   d2,d0
                bcc.w   Sound_StartPrimaryVoiceDACSlot
                rts
; ---------------------------------------------------------------------------
Sound_StartPrimaryVoiceDACSlot:                         ; CODE XREF: Sound_DispatchPendingRequest+208   j  ; was: loc_82C62
                                        ; Sound_DispatchPendingRequest+218   j
                bset    #0,(byte_FFF82C).w
                bsr.w   Sound_ReadDACSampleHeader
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForPrimaryVoiceDACZ80Bus:                     ; CODE XREF: Sound_DispatchPendingRequest+268   j  ; was: loc_82C7A
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForPrimaryVoiceDACZ80Bus
                btst    #0,d6
                bne.w   Sound_WritePrimaryVoiceDACMailbox
                move.b  #$80,(byte_A01FFE).l
                move.b  #$80,(byte_A01FFD).l
Sound_WritePrimaryVoiceDACMailbox:                      ; CODE XREF: Sound_DispatchPendingRequest+26E   j  ; was: loc_82C9C
                move.b  #$80,(byte_A01F86).l
                move.b  0.w(a0),(byte_A01F80).l
                move.b  1(a0),(byte_A01F81).l
                move.b  d2,(byte_A01F82).l
                move.b  d3,(byte_A01F83).l
                move.b  d4,(byte_A01F84).l
                move.b  d5,(byte_A01F85).l
                move.b  5(a0),(byte_A01FFB).l
                move.b  5(a0),(byte_A01F87).l
                move.b  #$C0,(byte_A01FFA).l
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                btst    #5,5(a0)
                beq.w   Sound_StartPrimaryVoiceDACSlotReturn
                btst    #5,d6
                bne.w   Sound_StartPrimaryVoiceDACSlotReturn
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   Sound_StartPrimaryVoiceDACSlotReturn
                move.b  #1,(byte_FFF82B).w
Sound_StartPrimaryVoiceDACSlotReturn:                   ; CODE XREF: Sound_DispatchPendingRequest+2DA   j  ; was: locret_82D10
                                        ; Sound_DispatchPendingRequest+2E2   j
                rts
; ---------------------------------------------------------------------------
Sound_StartSecondaryVoiceDACSlot:                       ; CODE XREF: Sound_DispatchPendingRequest+210   j  ; was: loc_82D12
                                        ; Sound_DispatchPendingRequest+21E   j
                bclr    #0,(byte_FFF82C).w
                bsr.w   Sound_ReadDACSampleHeader
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForSecondaryVoiceDACZ80Bus:                   ; CODE XREF: Sound_DispatchPendingRequest+318   j  ; was: loc_82D2A
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForSecondaryVoiceDACZ80Bus
                btst    #0,d6
                bne.w   Sound_WriteSecondaryVoiceDACMailbox
                move.b  #$80,(byte_A01FFE).l
                move.b  #$80,(byte_A01FFD).l
; Write the selected sample header and descriptor fields to the secondary Z80 DAC mailbox
Sound_WriteSecondaryVoiceDACMailbox:                    ; CODE XREF: Sound_DispatchPendingRequest+31E   j  ; was: loc_82D4C
                move.b  #$80,(byte_A01FA6).l
                move.b  0.w(a0),(byte_A01FA0).l
                move.b  1(a0),(byte_A01FA1).l
                move.b  d2,(byte_A01FA2).l
                move.b  d3,(byte_A01FA3).l
                move.b  d4,(byte_A01FA4).l
                move.b  d5,(byte_A01FA5).l
                move.b  5(a0),(byte_A01FFB).l
                move.b  5(a0),(byte_A01FA7).l
                move.b  #$C0,(byte_A01FFA).l
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                btst    #5,5(a0)
                beq.w   Sound_StartSecondaryVoiceDACSlotReturn
                btst    #5,d6
                bne.w   Sound_StartSecondaryVoiceDACSlotReturn
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   Sound_StartSecondaryVoiceDACSlotReturn
                move.b  #1,(byte_FFF82B).w
Sound_StartSecondaryVoiceDACSlotReturn:                 ; CODE XREF: Sound_DispatchPendingRequest+38A   j  ; was: locret_82DC0
                                        ; Sound_DispatchPendingRequest+392   j
                rts
; End of function Sound_DispatchPendingRequest
; Resolve the packed sample pointer and read the four-byte DPCM sample header
Sound_ReadDACSampleHeader:                              ; CODE XREF: Sound_DispatchPendingRequest+24E   p  ; was: sub_82DC2
                                        ; Sound_DispatchPendingRequest+2FE   p
                moveq   #0,d0
                move.w  0.w(a0),d0
                lsl.l   #8,d0
                movea.l d0,a2
                move.b  3(a0),d0
                lsl.w   #8,d0
                move.b  2(a0),d0
                andi.w  #$7FFF,d0
                move.b  (a2,d0.w),d2
                move.b  1(a2,d0.w),d3
                move.b  2(a2,d0.w),d4
                move.b  3(a2,d0.w),d5
                rts
; End of function Sound_ReadDACSampleHeader
; ---------------------------------------------------------------------------
Sound_VoiceDACDescriptors:  dc.w    (PCMPart3 >> $8)    ; DATA XREF: Sound_DispatchPendingRequest+86   o  ; was: word_82DEC
                                        ; 980 - PCMPart1
                                        ; A00 - PCMPart2
                                        ; A80 - PCMPart3
                                        ; B00 - PCMPart4
                                        ; B80 - PCMPart5
                                        ; C00 - PCMPart6
                                        ; C80 - PCMPart7
                                        ; D00 - PCMPart8
                                        ; D80 - PCMPart9
                dc.w    $880, $380, $C000
                dc.w    (PCMPart3 >> $8)
                dc.w    $80, $1380, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $880, $180, $C000
                dc.w    (PCMPart3 >> $8)
                dc.w    $80, $1B80, $C000
                dc.w    (PCMPart3 >> $8)
                dc.w    $480, $4580, $C000
                dc.w    (PCMPart5 >> $8)
                dc.w    $880, $1381, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $480, $1381, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $880, $1381, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $1480, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $1880, $2081, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $1080, $13A1, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $480, $13A1, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $1880, $1381, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $2480, $4080, $C000
                dc.w    (PCMPart3 >> $8)
                dc.w    $1080, $13C1, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $80, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $2080, $1381, $C000
                dc.w    (PCMPart7 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart5 >> $8)
                dc.w    $480, $280, $C000
                dc.w    (PCMPart6 >> $8)
                dc.w    $80, $280, $C000
                dc.w    (PCMPart5 >> $8)
                dc.w    $1080, $280, $C000
                dc.w    (PCMPart6 >> $8)
                dc.w    $880, $280, $C000
                dc.w    (PCMPart7 >> $8)
                dc.w    $480, $280, $C000
                dc.w    (PCMPart7 >> $8)
                dc.w    $880, $280, $C000
                dc.w    (PCMPart6 >> $8)
                dc.w    $480, $280, $C000
                dc.w    (PCMPart5 >> $8)
                dc.w    $80, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $480, $380, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $2480, $1A80, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $2480, $2780, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $2880, $1381, $C000
                dc.w    (PCMPart5 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $80, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $880, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $2080, $1880, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $2880, $1381, $C000
                dc.w    (PCMPart6 >> $8)
                dc.w    $C80, $1381, $C000
                dc.w    (PCMPart7 >> $8)
                dc.w    $1080, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $1080, $1381, $C000
                dc.w    (PCMPart8 >> $8)
                dc.w    $1480, $1381, $C000
                dc.w    (PCMPart9 >> $8)
                dc.w    $80, $1A80, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $1C80, $180, $C000
                dc.w    (PCMPart7 >> $8)
                dc.w    $80, $280, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $1C80, $1381, $C000
                dc.w    (PCMPart4 >> $8)
                dc.w    $2080, $1381, $C000
                dc.w    (PCMPart2 >> $8)
                dc.w    $1C80, $180, $C000

; End of pending-request dispatch and voice DAC data
