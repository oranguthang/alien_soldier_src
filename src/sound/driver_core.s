Sound_UpdateThunk:                                      ; CODE XREF: Reset+252   p  ; was: sub_82324
                                        ; Sys_VBlankEventHandler+36   p
                jmp     Sound_UpdateDriver(pc)          ; (pc)
; End of function Sound_UpdateThunk
; Attributes: thunk
; Sound driver initialization thunk jumping to Z80 loader
Sound_InitDriverThunk:                                  ; CODE XREF: Reset+246   p  ; was: sub_82328
                jmp     Sound_LoadZ80Driver(pc)         ; (pc)
; End of function Sound_InitDriverThunk
; Main sound driver update loop
Sound_UpdateDriver:                                     ; CODE XREF: Sound_UpdateThunk   j  ; was: sub_8232C
                                        ; DATA XREF: Sound_UpdateThunk   o
                clr.b   (SoundChannelGroupFlags).w
                tst.b   (SoundPauseState).w
                bne.w   Sound_ProcessPauseTransition
                jsr     Sound_UpdateBGMVolumeTransitions(pc)  ; (pc)
                jsr     Sound_ProcessTempoTick(pc)      ; (pc)
                jsr     Sound_UpdateMusicFadeOut(pc)    ; (pc)
                tst.l   (SoundRequestQueue).w
                beq.s   Sound_UpdateActiveChannels
                jsr     Sound_SelectPendingRequest(pc)  ; (pc)
Sound_UpdateActiveChannels:                             ; CODE XREF: Sound_UpdateDriver+1C   j  ; was: loc_8234E
                jsr     Sound_DispatchPendingRequest(pc)  ; (pc)
                lea     (SoundPCMChannelRecord).w,a5
                tst.b   (a5)
                bpl.s   Sound_ProcessBGMFMChannels
                jsr     Sound_ProcessPCMSequence(pc)    ; (pc)
Sound_ProcessBGMFMChannels:                             ; CODE XREF: Sound_UpdateDriver+2C   j  ; was: loc_8235E
                clr.b   (SoundPCMEventFlag).w
                moveq   #5,d7
Sound_ProcessNextBGMFMChannel:                          ; CODE XREF: Sound_UpdateDriver:Sound_ContinueBGMFMChannelLoop   j  ; was: loc_82364
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_ContinueBGMFMChannelLoop
                jsr     Sound_ProcessChannel(pc)        ; (pc)
Sound_ContinueBGMFMChannelLoop:                         ; CODE XREF: Sound_UpdateDriver+3E   j  ; was: loc_82370
                dbf     d7,Sound_ProcessNextBGMFMChannel
                moveq   #2,d7
Sound_ProcessBGMPSGChannels:                            ; CODE XREF: Sound_UpdateDriver:Sound_ContinueBGMPSGChannelLoop   j  ; was: loc_82376
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_ContinueBGMPSGChannelLoop
                jsr     Sound_ProcessPSGChannel(pc)     ; (pc)
Sound_ContinueBGMPSGChannelLoop:                        ; CODE XREF: Sound_UpdateDriver+50   j  ; was: loc_82382
                dbf     d7,Sound_ProcessBGMPSGChannels
                move.b  #$80,(SoundChannelGroupFlags).w
                moveq   #2,d7
Sound_ProcessSFXFMChannels:                             ; CODE XREF: Sound_UpdateDriver:Sound_ContinueSFXFMChannelLoop   j  ; was: loc_8238E
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_ContinueSFXFMChannelLoop
                jsr     Sound_ProcessChannel(pc)        ; (pc)
Sound_ContinueSFXFMChannelLoop:                         ; CODE XREF: Sound_UpdateDriver+68   j  ; was: loc_8239A
                dbf     d7,Sound_ProcessSFXFMChannels
                moveq   #2,d7
Sound_ProcessSFXPSGChannels:                            ; CODE XREF: Sound_UpdateDriver:Sound_ContinueSFXPSGChannelLoop   j  ; was: loc_823A0
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_ContinueSFXPSGChannelLoop
                jsr     Sound_ProcessPSGChannel(pc)     ; (pc)
Sound_ContinueSFXPSGChannelLoop:                        ; CODE XREF: Sound_UpdateDriver+7A   j  ; was: loc_823AC
                dbf     d7,Sound_ProcessSFXPSGChannels
                move.b  #$40,(SoundChannelGroupFlags).w  ; '@'
                moveq   #1,d7
Sound_ProcessSpecialSFXChannels:                        ; CODE XREF: Sound_UpdateDriver:Sound_ContinueSpecialSFXChannelLoop   j  ; was: loc_823B8
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_ContinueSpecialSFXChannelLoop
                tst.b   1(a5)
                bmi.s   Sound_ProcessSpecialSFXPSGChannel
                jsr     Sound_ProcessChannel(pc)        ; (pc)
                bra.s   Sound_ContinueSpecialSFXChannelLoop
; ---------------------------------------------------------------------------
Sound_ProcessSpecialSFXPSGChannel:                      ; CODE XREF: Sound_UpdateDriver+98   j  ; was: loc_823CC
                jsr     Sound_ProcessPSGChannel(pc)     ; (pc)
; Main driver update loop iteration
Sound_ContinueSpecialSFXChannelLoop:                    ; CODE XREF: Sound_UpdateDriver+92   j  ; was: loc_823D0
                                        ; Sound_UpdateDriver+9E   j
                dbf     d7,Sound_ProcessSpecialSFXChannels
                rts
; End of function Sound_UpdateDriver
; Process the DAC/PCM sequence and submit eligible samples to the Z80 driver
Sound_ProcessPCMSequence:                               ; CODE XREF: Sound_UpdateDriver+2E   p  ; was: sub_823D6
                                        ; DATA XREF: Sound_UpdateDriver+2E   o
                subq.b  #1,$E(a5)
                bne.w   Sound_ProcessPCMSequenceReturn
                move.b  #$80,(SoundPCMEventFlag).w
                movea.l 4(a5),a4
Sound_ReadPCMSequenceCommand:                           ; CODE XREF: Sound_ProcessPCMSequence+20   j  ; was: loc_823E8
                moveq   #0,d5
                move.b  (a4)+,d5
                cmpi.b  #$E0,d5
                bcs.s   Sound_DecodePCMSequenceEvent
                jsr     Sound_DispatchSequenceCommand(pc)  ; (pc)
                bra.s   Sound_ReadPCMSequenceCommand
; ---------------------------------------------------------------------------
Sound_DecodePCMSequenceEvent:                           ; CODE XREF: Sound_ProcessPCMSequence+1A   j  ; was: loc_823F8
                tst.b   d5
                bpl.s   Sound_CalculatePCMSequenceDuration
                move.b  d5,$10(a5)
                move.b  (a4)+,d5
                bpl.s   Sound_CalculatePCMSequenceDuration
                subq.w  #1,a4
                move.b  $F(a5),$E(a5)
                bra.s   Sound_SavePCMSequencePosition
; ---------------------------------------------------------------------------
Sound_CalculatePCMSequenceDuration:                     ; CODE XREF: Sound_ProcessPCMSequence+24   j  ; was: loc_8240E
                                        ; Sound_ProcessPCMSequence+2C   j
                jsr     Sound_CalculateDuration(pc)     ; (pc)
Sound_SavePCMSequencePosition:                          ; CODE XREF: Sound_ProcessPCMSequence+36   j  ; was: loc_82412
                move.l  a4,4(a5)
                moveq   #0,d0
                move.b  $10(a5),d0
                subi.b  #$81,d0
                bcs.s   Sound_ProcessPCMSequenceReturn
                ext.w   d0
                asl.w   #3,d0
                lea     Sound_PCMSampleDescriptors(pc,d0.w),a3
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForPCMZ80Bus:                                 ; CODE XREF: Sound_ProcessPCMSequence+6A   j  ; was: loc_82438
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForPCMZ80Bus
                tst.b   (Z80DACRequestState).l
                bmi.s   Sound_ReleasePCMZ80Bus
                move.b  (Z80DACStatus).l,d0
                andi.b  #$C0,d0
                move.b  5(a3),d1
                andi.b  #$C0,d1
                cmp.b   d0,d1
                bcs.w   Sound_ReleasePCMZ80Bus
                move.b  #1,(Z80DACRequestState).l
                move.b  (a3)+,(Z80DACCommandByte0).l
                move.b  (a3)+,(Z80DACCommandByte1).l
                move.b  (a3)+,(Z80DACCommandByte2).l
                move.b  (a3)+,(Z80DACCommandByte3).l
                move.b  (a3)+,(Z80DACCommandByte4).l
                move.b  (a3)+,(Z80DACCommandByte5).l
                move.b  $27(a5),(Z80DACPanning).l
Sound_ReleasePCMZ80Bus:                                 ; CODE XREF: Sound_ProcessPCMSequence+72   j  ; was: loc_82496
                                        ; Sound_ProcessPCMSequence+88   j
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
Sound_ProcessPCMSequenceReturn:                         ; CODE XREF: Sound_ProcessPCMSequence+4   j  ; was: locret_824A0
                                        ; Sound_ProcessPCMSequence+4A   j
                rts
; End of function Sound_ProcessPCMSequence
; ---------------------------------------------------------------------------
Sound_PCMSampleDescriptors: dc.w    (Sound_PCMBank1 >> $8)  ; DATA XREF: Sound_ProcessPCMSequence+50   o  ; was: word_824A2
                dc.w    $80, $500, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $480, $200, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $880, $100, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $C80, $700, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1080, $700, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1480, $100, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1880, $D00, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1C80, $100, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1080, $300, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1080, $900, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $1080, $F00, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2080, $A00, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $1700, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $800, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $1000, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $D00, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $600, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2880, $100, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2C80, $100, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $3080, $500, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $800, 0
                dc.w    (Sound_PCMBank1 >> $8)
                dc.w    $2480, $E00, 0

; Processes individual sound channel state
Sound_ProcessChannel:                                   ; CODE XREF: Sound_UpdateDriver+40   p  ; was: sub_82552
                                        ; Sound_UpdateDriver+6A   p
                subq.b  #1,$E(a5)
                bne.s   Sound_UpdateFMChannelEffects
                bclr    #4,(a5)
                jsr     Sound_ParseTrackData(pc)        ; (pc)
                jsr     Sound_UpdateChannelFrequency(pc)  ; (pc)
                jsr     Sound_TriggerPanAnimationForNote(pc)  ; (pc)
                bra.w   Sound_SendFMKeyOn
; ---------------------------------------------------------------------------
; Update note timeout, pan animation, and vibrato between FM sequence events
Sound_UpdateFMChannelEffects:                           ; CODE XREF: Sound_ProcessChannel+4   j  ; was: loc_8256C
                jsr     Sound_HandleNoteTimer(pc)       ; (pc)
                jsr     Sound_UpdatePanAnimation(pc)    ; (pc)
                jsr     Sound_ProcessVibrato(pc)        ; (pc)
                bra.w   Sound_UpdateSustainedFMFrequency
; End of function Sound_ProcessChannel
; Parses and interprets sound track data
Sound_ParseTrackData:                                   ; CODE XREF: Sound_ProcessChannel+A   p  ; was: sub_8257C
                                        ; DATA XREF: Sound_ProcessChannel+A   o
                movea.l 4(a5),a4
                bclr    #1,(a5)
Sound_ReadFMSequenceCommand:                            ; CODE XREF: Sound_ParseTrackData+16   j  ; was: loc_82584
                moveq   #0,d5
                move.b  (a4)+,d5
                cmpi.b  #$E0,d5
                bcs.s   Sound_DecodeFMSequenceEvent
                jsr     Sound_DispatchSequenceCommand(pc)  ; (pc)
                bra.s   Sound_ReadFMSequenceCommand
; ---------------------------------------------------------------------------
Sound_DecodeFMSequenceEvent:                            ; CODE XREF: Sound_ParseTrackData+10   j  ; was: loc_82594
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
                tst.b   d5
                bpl.s   Sound_ParseNoteData
                jsr     Sound_CalculatePitch(pc)        ; (pc)
                move.b  (a4)+,d5
                bpl.s   Sound_ParseNoteData
                subq.w  #1,a4
                bra.w   Sound_SaveChannelState
; ---------------------------------------------------------------------------
; Parses note data and calculates duration
Sound_ParseNoteData:                                    ; CODE XREF: Sound_ParseTrackData+1E   j  ; was: loc_825AA
                                        ; Sound_ParseTrackData+26   j
                jsr     Sound_CalculateDuration(pc)     ; (pc)
                bra.w   Sound_SaveChannelState
; End of function Sound_ParseTrackData
; Calculates note pitch and frequency
Sound_CalculatePitch:                                   ; CODE XREF: Sound_ParseTrackData+20   p  ; was: sub_825B2
                                        ; DATA XREF: Sound_ParseTrackData+20   o
                subi.b  #$80,d5
                beq.s   Sound_MarkFMChannelRest
                add.b   8(a5),d5
                andi.l  #$7F,d5
                divu.w  #$C,d5
                swap    d5
                lsl.w   #1,d5
                lea     Sound_FMNoteFrequencyTable(pc),a0
                move.w  (a0,d5.w),d6
                swap    d5
                andi.w  #7,d5
                moveq   #$B,d0
                lsl.w   d0,d5
                or.w    d5,d6
                move.w  d6,$10(a5)
                rts
; End of function Sound_CalculatePitch
; Calculates note duration timing
Sound_CalculateDuration:                                ; CODE XREF: Sound_ProcessPCMSequence:Sound_CalculatePCMSequenceDuration   p  ; was: sub_825E4
                                        ; sub_8257C:loc_825AA   p
                move.b  d5,d0
                move.b  2(a5),d1
Sound_MultiplyDurationByTickScale:                      ; CODE XREF: Sound_CalculateDuration+C   j  ; was: loc_825EA
                subq.b  #1,d1
                beq.s   Sound_StoreChannelDuration
                add.b   d5,d0
                bra.s   Sound_MultiplyDurationByTickScale
; ---------------------------------------------------------------------------
Sound_StoreChannelDuration:                             ; CODE XREF: Sound_CalculateDuration+8   j  ; was: loc_825F2
                move.b  d0,$F(a5)
                move.b  d0,$E(a5)
                rts
; End of function Sound_CalculateDuration
; Mark a rest event and clear the FM pitch word
Sound_MarkFMChannelRest:                                ; CODE XREF: Sound_CalculatePitch+4   j  ; was: sub_825FC
                bset    #1,(a5)
                clr.w   $10(a5)
; End of function Sound_MarkFMChannelRest
; Saves channel state and envelope data
Sound_SaveChannelState:                                 ; CODE XREF: Sound_ParseTrackData+2A   j  ; was: sub_82604
                                        ; Sound_ParseTrackData+32   j
                move.l  a4,4(a5)
                move.b  $F(a5),$E(a5)
                btst    #4,(a5)
                bne.s   Sound_SaveChannelStateReturn
                move.b  $13(a5),$12(a5)
                clr.b   $C(a5)
                clr.b   $26(a5)
                clr.b   3(a5)
                btst    #7,$A(a5)
                beq.s   Sound_SaveChannelStateReturn
                movea.l $14(a5),a0
                move.b  (a0)+,$18(a5)
                move.b  (a0)+,$19(a5)
                move.b  (a0)+,$1A(a5)
                move.b  (a0)+,d0
                lsr.b   #1,d0
                move.b  d0,$1B(a5)
                clr.w   $1C(a5)
Sound_SaveChannelStateReturn:                           ; CODE XREF: Sound_SaveChannelState+E   j  ; was: locret_8264A
                                        ; Sound_SaveChannelState+28   j
                rts
; End of function Sound_SaveChannelState
; Handles sound channel note timer countdown and restarts playback
Sound_HandleNoteTimer:                                  ; CODE XREF: Sound_ProcessChannel:Sound_UpdateFMChannelEffects   p  ; was: sub_8264C
                                        ; sub_84A70:loc_84A86   p
                                        ; DATA XREF:
                tst.b   $12(a5)
                beq.s   Sound_HandleNoteTimerReturn
                subq.b  #1,$12(a5)
                bne.s   Sound_HandleNoteTimerReturn
                bset    #1,(a5)
                tst.b   1(a5)
                bmi.w   Sound_HandlePSGNoteTimeout
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
                addq.w  #4,sp
                rts
; ---------------------------------------------------------------------------
Sound_HandlePSGNoteTimeout:                             ; CODE XREF: Sound_HandleNoteTimer+14   j  ; was: loc_8266C
                jsr     Sound_MutePSGIfNotOverridden(pc)  ; (pc)
                addq.w  #4,sp
Sound_HandleNoteTimerReturn:                            ; CODE XREF: Sound_HandleNoteTimer+4   j  ; was: locret_82672
                                        ; Sound_HandleNoteTimer+A   j
                rts
; End of function Sound_HandleNoteTimer
; Processes sound vibrato effect modulating pitch with oscillation
Sound_ProcessVibrato:                                   ; CODE XREF: Sound_ProcessChannel+22   p  ; was: sub_82674
                                        ; Sound_ProcessPSGChannel+1E   p
                                        ; DATA XREF:
                btst    #7,$A(a5)
                beq.s   Sound_ProcessVibratoReturn
                tst.b   $18(a5)
                beq.s   Sound_CountDownVibratoStepDelay
                subq.b  #1,$18(a5)
                rts
; ---------------------------------------------------------------------------
Sound_CountDownVibratoStepDelay:                        ; CODE XREF: Sound_ProcessVibrato+C   j  ; was: loc_82688
                subq.b  #1,$19(a5)
                beq.s   Sound_ReloadVibratoStep
                rts
; ---------------------------------------------------------------------------
Sound_ReloadVibratoStep:                                ; CODE XREF: Sound_ProcessVibrato+18   j  ; was: loc_82690
                movea.l $14(a5),a0
                move.b  1(a0),$19(a5)
                tst.b   $1B(a5)
                bne.s   Sound_ApplyVibratoOffset
                move.b  3(a0),$1B(a5)
                neg.b   $1A(a5)
                rts
; ---------------------------------------------------------------------------
; Applies vibrato offset to frequency
Sound_ApplyVibratoOffset:                               ; CODE XREF: Sound_ProcessVibrato+2A   j  ; was: loc_826AC
                subq.b  #1,$1B(a5)
                move.b  $1A(a5),d6
                ext.w   d6
                add.w   $1C(a5),d6
                move.w  d6,$1C(a5)
                add.w   $10(a5),d6
Sound_ProcessVibratoReturn:                             ; CODE XREF: Sound_ProcessVibrato+6   j  ; was: locret_826C2
                rts
; End of function Sound_ProcessVibrato
; Updates FM channel frequency registers with calculated pitch
Sound_UpdateChannelFrequency:                           ; CODE XREF: Sound_ProcessChannel+E   p  ; was: sub_826C4
                                        ; DATA XREF: Sound_ProcessChannel+E   o
                move.w  $10(a5),d6
                bne.s   Sound_CheckFMFrequencyWriteFlags
                bset    #1,(a5)
                rts
; ---------------------------------------------------------------------------
Sound_UpdateSustainedFMFrequency:                       ; CODE XREF: Sound_ProcessChannel+26   j  ; was: loc_826D0
                tst.b   $A(a5)
                beq.w   Sound_UpdateChannelFrequencyReturn
Sound_CheckFMFrequencyWriteFlags:                       ; CODE XREF: Sound_UpdateChannelFrequency+4   j  ; was: loc_826D8
                btst    #1,(a5)
                bne.w   Sound_UpdateChannelFrequencyReturn
                btst    #2,(a5)
                bne.w   Sound_UpdateChannelFrequencyReturn
                jsr     Sound_ApplyPitchEffects(pc)     ; (pc)
                tst.b   (SoundFM3SpecialMode).w
                beq.s   Sound_WriteFrequencyBytes
                cmpi.b  #2,1(a5)
                beq.w   Sound_UpdateFMOperators
; Writes frequency bytes to YM2612
Sound_WriteFrequencyBytes:                              ; CODE XREF: Sound_UpdateChannelFrequency+2C   j  ; was: loc_826FC
                move.w  d6,d1
                lsr.w   #8,d1
                move.b  #$A4,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                move.b  d6,d1
                move.b  #$A0,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
Sound_UpdateChannelFrequencyReturn:                     ; CODE XREF: Sound_UpdateChannelFrequency+10   j  ; was: locret_82712
                                        ; Sound_UpdateChannelFrequency+18   j
                rts
; End of function Sound_UpdateChannelFrequency
; Applies pitch effects including detune transpose and modulation to frequency
Sound_ApplyPitchEffects:                                ; CODE XREF: Sound_UpdateChannelFrequency+24   p  ; was: sub_82714
                                        ; Sound_UpdatePSGChannelFrequency+1E   p
                                        ; DATA XREF:
                moveq   #0,d6
                move.b  $A(a5),d0
                andi.w  #$7F,d0
                beq.s   Sound_ApplyDetuneAndBasePitch
                lea     Sound_PitchEnvelopePointerTable(pc),a0
                subq.w  #1,d0
                lsl.w   #2,d0
                movea.l (a0,d0.w),a0
Sound_ReadPitchEnvelopeCommand:                         ; CODE XREF: Sound_RestartPitchEnvelope+4   j  ; was: loc_8272C
                                        ; Sound_RepeatPitchEnvelopeValue+4   j
                moveq   #0,d0
                move.b  $26(a5),d0
                addq.b  #1,$26(a5)
                move.b  (a0,d0.w),d6
                bpl.s   Sound_ScalePitchEnvelopeValue
                cmpi.b  #$80,d6
                beq.s   Sound_RestartPitchEnvelope
                cmpi.b  #$81,d6
                beq.s   Sound_RepeatPitchEnvelopeValue
                cmpi.b  #$83,d6
                beq.s   Sound_EndPitchEnvelopeWithRest
                cmpi.b  #$82,d6
                beq.s   Sound_JumpPitchEnvelope
                cmpi.b  #$84,d6
                beq.s   Sound_AddPitchEnvelopeTranspose
Sound_ScalePitchEnvelopeValue:                          ; CODE XREF: Sound_ApplyPitchEffects+26   j  ; was: loc_8275A
                ext.w   d6
                move.b  3(a5),d0
                ext.w   d0
                mulu.w  d0,d6
Sound_ApplyDetuneAndBasePitch:                          ; CODE XREF: Sound_ApplyPitchEffects+A   j  ; was: loc_82764
                move.b  $1E(a5),d0
                ext.w   d0
                add.w   d0,d6
                add.w   $10(a5),d6
                tst.b   $A(a5)
                bpl.s   Sound_ApplyPitchEffectsReturn
                add.w   $1C(a5),d6
Sound_ApplyPitchEffectsReturn:                          ; CODE XREF: Sound_ApplyPitchEffects+60   j  ; was: locret_8277A
                rts
; End of function Sound_ApplyPitchEffects
; Statically unreferenced stack-skip helper between pitch-envelope commands
; UNKNOWN CODE-005: no static entry path; see docs/unknowns.md
Sound_PitchEnvelopeUnreferencedSkipReturn:              ; was: sub_8277C
                addq.w  #4,sp
                rts
; End of function Sound_PitchEnvelopeUnreferencedSkipReturn
; Restart the pitch-envelope cursor after command $80
Sound_RestartPitchEnvelope:                             ; CODE XREF: Sound_ApplyPitchEffects+2C   j  ; was: sub_82780
                clr.b   $26(a5)
                bra.s   Sound_ReadPitchEnvelopeCommand
; End of function Sound_RestartPitchEnvelope
; Repeat the preceding pitch-envelope value after command $81
Sound_RepeatPitchEnvelopeValue:                         ; CODE XREF: Sound_ApplyPitchEffects+32   j  ; was: sub_82786
                subq.b  #2,$26(a5)
                bra.s   Sound_ReadPitchEnvelopeCommand
; End of function Sound_RepeatPitchEnvelopeValue
; End a pitch envelope with a rest after command $83
Sound_EndPitchEnvelopeWithRest:                         ; CODE XREF: Sound_ApplyPitchEffects+38   j  ; was: sub_8278C
                bset    #1,(a5)
                tst.b   1(a5)
                bmi.s   Sound_EndPSGPitchEnvelopeWithRest
                bra.w   Sound_SendFMKeyOffIfAllowed
; ---------------------------------------------------------------------------
Sound_EndPSGPitchEnvelopeWithRest:                      ; CODE XREF: Sound_EndPitchEnvelopeWithRest+8   j  ; was: loc_8279A
                bra.w   Sound_MutePSGIfNotOverridden
; End of function Sound_EndPitchEnvelopeWithRest
; Jump the pitch-envelope cursor after command $82
Sound_JumpPitchEnvelope:                                ; CODE XREF: Sound_ApplyPitchEffects+3E   j  ; was: sub_8279E
                move.b  1(a0,d0.w),$26(a5)
                bra.s   Sound_ReadPitchEnvelopeCommand
; End of function Sound_JumpPitchEnvelope
; Add pitch-envelope transposition after command $84
Sound_AddPitchEnvelopeTranspose:                        ; CODE XREF: Sound_ApplyPitchEffects+44   j  ; was: sub_827A6
                move.b  1(a0,d0.w),d0
                add.b   d0,3(a5)
                addq.b  #1,$26(a5)
                bra.w   Sound_ReadPitchEnvelopeCommand
; End of function Sound_AddPitchEnvelopeTranspose
; Updates YM2612 frequency registers for all 4 FM operators per channel
Sound_UpdateFMOperators:                                ; CODE XREF: Sound_UpdateChannelFrequency+34   j  ; was: sub_827B6
                lea     Sound_FM3OperatorFrequencyRegisters(pc),a1
                lea     (SoundBGMFM3Offsets).w,a2
                tst.b   (SoundChannelGroupFlags).w
                beq.s   Sound_SelectFM3FrequencyShadowBank
                lea     (SoundSFXFM3Offsets).w,a2
Sound_SelectFM3FrequencyShadowBank:                     ; CODE XREF: Sound_UpdateFMOperators+C   j  ; was: loc_827C8
                moveq   #3,d5
Sound_WriteNextFM3OperatorFrequency:                    ; CODE XREF: Sound_UpdateFMOperators+2C   j  ; was: loc_827CA
                move.w  d6,d1
                move.w  (a2)+,d0
                add.w   d0,d1
                move.w  d1,d3
                lsr.w   #8,d1
                move.b  (a1)+,d0
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                move.b  d3,d1
                move.b  (a1)+,d0
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                dbf     d5,Sound_WriteNextFM3OperatorFrequency
                rts
; End of function Sound_UpdateFMOperators
; ---------------------------------------------------------------------------
Sound_FM3OperatorFrequencyRegisters:    dc.b    $AD, $A9, $AC, $A8, $AE, $AA, $A6, $A2  ; was: byte_827E8
                                        ; DATA XREF: Sound_UpdateFMOperators   o

; Dispatch the note-trigger behavior for the configured pan-animation mode
Sound_TriggerPanAnimationForNote:                       ; CODE XREF: Sound_ProcessChannel+12   p  ; was: sub_827F0
                                        ; DATA XREF: Sound_ProcessChannel+12   o
                btst    #1,(a5)
                bne.s   Sound_PanAnimationNoteModeDispatch
                moveq   #0,d0
                move.b  $1F(a5),d0
                lsl.w   #1,d0
                jmp     Sound_PanAnimationNoteModeDispatch(pc,d0.w)
; End of function Sound_TriggerPanAnimationForNote
Sound_PanAnimationNoteModeDispatch:                     ; CODE XREF: Sound_TriggerPanAnimationForNote+4   j
                                        ; Sound_TriggerPanAnimationForNote+E   j
                                        ; DATA XREF:
                rts
; ---------------------------------------------------------------------------
                bra.s   Sound_UpdatePanAnimationStepTimer
; ---------------------------------------------------------------------------
                bra.s   Sound_RestartPanAnimation
; ---------------------------------------------------------------------------
                bra.s   Sound_RestartPanAnimation
; End of function Sound_PanAnimationNoteModeDispatch

; Dispatch the per-tick behavior for the configured pan-animation mode
Sound_UpdatePanAnimation:                               ; CODE XREF: Sound_ProcessChannel+1E   p  ; was: sub_8280A
                                        ; DATA XREF: Sound_ProcessChannel+1E   o
                btst    #1,(a5)
                bne.s   Sound_PanAnimationTickModeDispatch
                moveq   #0,d0
                move.b  $1F(a5),d0
                lsl.w   #1,d0
                jmp     Sound_PanAnimationTickModeDispatch(pc,d0.w)
; ---------------------------------------------------------------------------
Sound_PanAnimationTickModeDispatch:                     ; CODE XREF: Sound_UpdatePanAnimation+4   j
                                        ; Sound_UpdatePanAnimation+E   j
                                        ; DATA XREF:
                rts
; ---------------------------------------------------------------------------
                rts
; ---------------------------------------------------------------------------
                bra.s   Sound_UpdatePanAnimationStepTimer
; ---------------------------------------------------------------------------
                bra.s   Sound_UpdatePanAnimationStepTimer
; End of function Sound_UpdatePanAnimation
; Restart a pan animation and immediately evaluate its first frame
Sound_RestartPanAnimation:                              ; CODE XREF: Sound_PanAnimationNoteModeDispatch+4   j  ; was: sub_82824
                                        ; Sound_PanAnimationNoteModeDispatch+6   j
                move.b  $23(a5),$24(a5)
                clr.b   $21(a5)
Sound_UpdatePanAnimationStepTimer:                      ; CODE XREF: Sound_PanAnimationNoteModeDispatch+2   j  ; was: loc_8282E
                                        ; Sound_UpdatePanAnimation+16   j
                move.b  $24(a5),d0
                cmp.b   $23(a5),d0
                bne.s   Sound_ApplyPanAnimationFrame
                move.b  $22(a5),d3
                cmp.b   $21(a5),d3
                bpl.s   Sound_AdvancePanAnimationStep
                cmpi.b  #2,$1F(a5)
                beq.s   Sound_UpdatePanAnimationReturn
                clr.b   $21(a5)
Sound_AdvancePanAnimationStep:                          ; CODE XREF: Sound_RestartPanAnimation+1C   j  ; was: loc_8284E
                clr.b   $24(a5)
                addq.b  #1,$21(a5)
; Resolve and apply the current pan-animation frame
Sound_ApplyPanAnimationFrame:                           ; CODE XREF: Sound_RestartPanAnimation+12   j  ; was: loc_82856
                moveq   #0,d0
                move.b  $20(a5),d0
                subq.w  #1,d0
                lsl.w   #2,d0
                movea.l Sound_PanAnimationPointerTable(pc,d0.w),a0
                moveq   #0,d0
                move.b  $21(a5),d0
                subq.w  #1,d0
                move.b  (a0,d0.w),d1
                move.b  $27(a5),d0
                andi.b  #$37,d0                         ; '7'
                or.b    d0,d1
                jsr     Sound_WriteChannelPanAndAMS(pc)  ; (pc)
                addq.b  #1,$24(a5)
Sound_UpdatePanAnimationReturn:                         ; CODE XREF: Sound_RestartPanAnimation+24   j  ; was: locret_82882
                rts
; End of function Sound_RestartPanAnimation
; ---------------------------------------------------------------------------
Sound_PanAnimationPointerTable: dc.l    Sound_PanAnimationSequence1  ; DATA XREF: Sound_RestartPanAnimation+3C   r
                dc.l    Sound_PanAnimationSequence2
                dc.l    Sound_PanAnimationSequence3
Sound_PanAnimationSequence1:    dc.b    $40, $80        ; DATA XREF: ROM:Sound_PanAnimationPointerTable   o
Sound_PanAnimationSequence2:    dc.b    $40, $C0, $80   ; DATA XREF: ROM:00082888   o
Sound_PanAnimationSequence3:    dc.b    $C0, $80, $C0, $40, 0
                                        ; DATA XREF: ROM:0008288C   o

; Write pan/AMS state to the PCM mailbox or the current FM channel
Sound_WriteChannelPanAndAMS:                            ; CODE XREF: Sound_RestartPanAnimation+56   p  ; was: sub_8289A
                                        ; Sound_SetSequencePanning+16   j
                btst    #2,(a5)
                bne.s   Sound_WriteChannelPanAndAMSReturn
                cmpi.b  #6,1(a5)
                bne.w   Sound_WriteFMChannelPanAndAMS
                cmpa.l  #$40,a5                         ; '@'
                beq.w   Sound_WriteChannelPanAndAMSReturn
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForPanUpdateZ80Bus:                           ; CODE XREF: Sound_WriteChannelPanAndAMS+30   j  ; was: loc_828C2
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForPanUpdateZ80Bus
                move.b  (Z80DACRequestState).l,d0
                beq.w   Sound_ReleasePanUpdateZ80Bus
                move.b  $27(a5),(Z80DACPanningUpdate).l
Sound_ReleasePanUpdateZ80Bus:                           ; CODE XREF: Sound_WriteChannelPanAndAMS+38   j  ; was: loc_828DE
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.s   Sound_WriteChannelPanAndAMSReturn
Sound_WriteFMChannelPanAndAMS:                          ; CODE XREF: Sound_WriteChannelPanAndAMS+C   j  ; was: loc_828EC
                move.b  #$B4,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
Sound_WriteChannelPanAndAMSReturn:                      ; CODE XREF: Sound_WriteChannelPanAndAMS+4   j  ; was: locret_828F4
                                        ; Sound_WriteChannelPanAndAMS+16   j
                rts
; End of function Sound_WriteChannelPanAndAMS
; Apply pause or resume transitions requested by the input/VBlank path
Sound_ProcessPauseTransition:                           ; CODE XREF: Sound_UpdateDriver+8   j  ; was: sub_828F6
                cmpi.b  #$FF,(SoundPauseState).w
                bne.w   Sound_BeginPauseTransition
                rts
; ---------------------------------------------------------------------------
Sound_BeginPauseTransition:                             ; CODE XREF: Sound_ProcessPauseTransition+6   j  ; was: loc_82902
                tst.b   (SoundPauseState).w
                bmi.s   Sound_ResumeFromPause
                move.b  #$FF,(SoundPauseState).w
                move    sr,-(sp)
                ori     #$700,sr
Sound_RequestZ80BusForPause:                            ; CODE XREF: Sound_ProcessPauseTransition+44   j  ; was: loc_82914
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForZ80BusForPause:                            ; CODE XREF: Sound_ProcessPauseTransition+2E   j  ; was: loc_8291C
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForZ80BusForPause
                tst.b   (Z80DriverBusy).l
                beq.s   Sound_MuteChannelsForPause
                move.w  #0,(IO_Z80BUS).l
                bsr.w   Sound_DelayForZ80BusRetry
                bra.s   Sound_RequestZ80BusForPause
; ---------------------------------------------------------------------------
Sound_MuteChannelsForPause:                             ; CODE XREF: Sound_ProcessPauseTransition+36   j  ; was: loc_8293C
                move    (sp)+,sr
                lea     (SoundFMLevelShadows).w,a1
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                jsr     Sound_SetAllFMOperatorLevelsMaximum(pc)  ; (pc)
                lea     (SoundFMShadowsEnd).w,a1
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                move.l  (sp)+,-(a1)
                bra.w   Sound_MuteAllPSGChannels
; ---------------------------------------------------------------------------
Sound_ResumeFromPause:                                  ; CODE XREF: Sound_ProcessPauseTransition+10   j  ; was: loc_8296E
                clr.b   (SoundPauseState).w
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                lea     (SoundFMShadowIndexBase).w,a1
                moveq   #2,d2
Sound_RestoreFMRegisterBankLoop:                        ; CODE XREF: Sound_ProcessPauseTransition+AE   j  ; was: loc_82988
                moveq   #$40,d0                         ; '@'
                add.w   d2,d0
                moveq   #3,d3
Sound_RestoreFMOperatorRegistersLoop:                   ; CODE XREF: Sound_ProcessPauseTransition+AA   j  ; was: loc_8298E
                move.b  (a1,d0.w),d1
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                move.b  $10(a1,d0.w),d1
                jsr     Sound_WriteYM2612Port1(pc)      ; (pc)
                addq.w  #4,d0
                dbf     d3,Sound_RestoreFMOperatorRegistersLoop
                dbf     d2,Sound_RestoreFMRegisterBankLoop
                rts
; End of function Sound_ProcessPauseTransition
; End of sound driver core
