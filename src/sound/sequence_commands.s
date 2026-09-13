; Dispatch sequence commands $E0-$FE through the ROM-ordered handler table
Sound_DispatchSequenceCommand:                          ; CODE XREF: Sound_ProcessPCMSequence+1C   p  ; was: sub_83820
                                        ; Sound_ParseTrackData+12   p
                subi.w  #$E0,d5
                lsl.w   #2,d5
                jmp     Sound_SequenceCommandJumpTable(pc,d5.w)
; ---------------------------------------------------------------------------
Sound_SequenceCommandJumpTable:                         ; CODE XREF: Sound_DispatchSequenceCommand+6   j  ; was: loc_8382A
                bra.w   Sound_SetSequencePanning        ; E0: panning bits
; ---------------------------------------------------------------------------
                bra.w   Sound_SetChannelDetune          ; E1: detune
; ---------------------------------------------------------------------------
                bra.w   Sound_SetCommunicationByte      ; E2: communication byte
; ---------------------------------------------------------------------------
                bra.w   Sound_SilenceFMOperatorsAndStopChannel  ; E3: silence FM operators and stop track
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPanAnimation           ; E4: pan animation
; ---------------------------------------------------------------------------
                bra.w   Sound_AddChannelTypeVolumeOffset  ; E5: PSG/FM volume pair
; ---------------------------------------------------------------------------
                bra.w   Sound_AddFMVolumeOffset         ; E6: FM volume
; ---------------------------------------------------------------------------
                bra.w   Sound_HoldNextNote              ; E7: hold next note
; ---------------------------------------------------------------------------
                bra.w   Sound_SetNoteStopTimeout        ; E8: note stop timeout
; ---------------------------------------------------------------------------
                bra.w   Sound_ConfigureFMLFOAndAmplitudeModulation  ; E9: YM2612 LFO and AM
; ---------------------------------------------------------------------------
                bra.w   Sound_SetTempoReload            ; EA: tempo
; ---------------------------------------------------------------------------
                bra.w   Sound_QueueSequenceSoundRequest  ; EB: queue sound ID
; ---------------------------------------------------------------------------
                bra.w   Sound_AddPSGVolumeOffset        ; EC: PSG volume
; ---------------------------------------------------------------------------
                bra.w   Sound_WriteCurrentFMRegisterFromSequence  ; ED: current FM channel register
; ---------------------------------------------------------------------------
                bra.w   Sound_WriteYM2612Port0RegisterFromSequence  ; EE: YM2612 port 0 register
; ---------------------------------------------------------------------------
                bra.w   Sound_SelectFMInstrument        ; EF: FM instrument
; ---------------------------------------------------------------------------
                bra.w   Sound_ConfigureVibrato          ; F0: custom vibrato
; ---------------------------------------------------------------------------
                bra.w   Sound_SetChannelTypePitchEnvelope  ; F1: separate PSG/FM pitch envelopes
; ---------------------------------------------------------------------------
                bra.w   Sound_StopSequenceChannel       ; F2: stop track
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPSGNoiseMode           ; F3: PSG noise
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPitchEnvelope          ; F4: pitch envelope
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPSGVolumeEnvelope      ; F5: PSG volume envelope
; ---------------------------------------------------------------------------
                bra.w   Sound_JumpSequenceRelative      ; F6: jump
; ---------------------------------------------------------------------------
                bra.w   Sound_RepeatSequenceBlock       ; F7: loop
; ---------------------------------------------------------------------------
                bra.w   Sound_CallRelativeSequenceSubroutine  ; F8: call sequence subroutine
; ---------------------------------------------------------------------------
                bra.w   Sound_ReturnFromSequenceSubroutine  ; F9: return
; ---------------------------------------------------------------------------
                bra.w   Sound_SetChannelTickMultiplier  ; FA: current tick multiplier
; ---------------------------------------------------------------------------
                bra.w   Sound_AddChannelTranspose       ; FB: transpose
; ---------------------------------------------------------------------------
                bra.w   Sound_EnableVibrato             ; FC: enable vibrato
; ---------------------------------------------------------------------------
                bra.w   Sound_DisableVibrato            ; FD: disable vibrato
; ---------------------------------------------------------------------------
                bra.w   Sound_SetFM3SpecialMode         ; FE: YM2612 channel 3 special mode
; End of function Sound_DispatchSequenceCommand
; Dispatch extended sequence commands following prefix $FF
Sound_DispatchExtendedSequenceCommand:
                moveq   #0,d0                           ; was: sub_838A6
                move.b  (a4)+,d0
                lsl.w   #2,d0
                jmp     Sound_ExtendedSequenceCommandJumpTable(pc,d0.w)
; ---------------------------------------------------------------------------
Sound_ExtendedSequenceCommandJumpTable:                 ; CODE XREF: Sound_DispatchExtendedSequenceCommand+6   j  ; was: loc_838B0
                                        ; DATA XREF: Sound_DispatchExtendedSequenceCommand+6   o
                bra.w   Sound_ConfigureFMSSGEG          ; FF 00: SSG-EG setup
; ---------------------------------------------------------------------------
                bra.w   Sound_SetBGMPlaybackPaused      ; FF 01: pause/resume music
; ---------------------------------------------------------------------------
                bra.w   Sound_SetAllBGMChannelTickMultipliers  ; FF 02: all tick multipliers
; ---------------------------------------------------------------------------
                bra.w   Sound_RequestBGMVolumeAttenuation  ; FF 03: attenuate BGM
; ---------------------------------------------------------------------------
                bra.w   Sound_RequestBGMVolumeRestore   ; FF 04: restore BGM volume
; End of function Sound_DispatchExtendedSequenceCommand
; Replace the channel panning bits while preserving its stored AMS/FMS bits (E0)
Sound_SetSequencePanning:                               ; CODE XREF: Sound_DispatchSequenceCommand:Sound_SequenceCommandJumpTable   j  ; was: sub_838C4
                move.b  (a4)+,d1
                tst.b   1(a5)
                bmi.s   Sound_SetSequencePanningReturn
                move.b  $27(a5),d0
                andi.b  #$37,d0                         ; '7'
                or.b    d0,d1
                move.b  d1,$27(a5)
                jmp     Sound_WriteChannelPanAndAMS(pc)  ; (pc)
; ---------------------------------------------------------------------------
Sound_SetSequencePanningReturn:                         ; CODE XREF: Sound_SetSequencePanning+6   j  ; was: locret_838DE
                rts
; End of function Sound_SetSequencePanning
; Sets channel detune (E1)
Sound_SetChannelDetune:                                 ; CODE XREF: Sound_DispatchSequenceCommand+E   j  ; was: sub_838E0
                move.b  (a4)+,$1E(a5)
                rts
; End of function Sound_SetChannelDetune
; Sets the global communication byte (E2)
Sound_SetCommunicationByte:                             ; CODE XREF: Sound_DispatchSequenceCommand+12   j  ; was: sub_838E6
                move.b  (a4)+,(SoundCommunicationByte).w
                rts
; End of function Sound_SetCommunicationByte
; Silence the current FM operators before stopping its sequence channel (E3)
Sound_SilenceFMOperatorsAndStopChannel:                 ; CODE XREF: Sound_DispatchSequenceCommand+16   j  ; was: sub_838EC
                jsr     Sound_SilenceCurrentFMOperators(pc)  ; (pc)
                bra.w   Sound_StopSequenceChannel
; End of function Sound_SilenceFMOperatorsAndStopChannel
; Configures or disables pan animation (E4)
Sound_SetPanAnimation:                                  ; CODE XREF: Sound_DispatchSequenceCommand+1A   j  ; was: sub_838F4
                move.b  (a4)+,$1F(a5)
                beq.s   Sound_DisablePanAnimationAndRestorePanning
                move.b  (a4)+,$20(a5)
                move.b  (a4)+,$21(a5)
                move.b  (a4)+,$22(a5)
                move.b  (a4),$23(a5)
                move.b  (a4)+,$24(a5)
                rts
; ---------------------------------------------------------------------------
Sound_DisablePanAnimationAndRestorePanning:             ; CODE XREF: Sound_SetPanAnimation+4   j  ; was: loc_83910
                move.b  $27(a5),d1
                jmp     Sound_WriteChannelPanAndAMS(pc)  ; (pc)
; End of function Sound_SetPanAnimation
; Adds separate PSG/FM volume offsets, selecting by channel type (E5)
Sound_AddChannelTypeVolumeOffset:                       ; CODE XREF: Sound_DispatchSequenceCommand+1E   j  ; was: sub_83918
                move.b  (a4)+,d0
                tst.b   1(a5)
                bpl.s   Sound_AddFMVolumeOffset
                add.b   d0,9(a5)
                addq.w  #1,a4
                rts
; ---------------------------------------------------------------------------
Sound_AddFMVolumeOffset:                                ; CODE XREF: Sound_DispatchSequenceCommand+22   j  ; was: loc_83928
                                        ; Sound_AddChannelTypeVolumeOffset+6   j
                move.b  (a4)+,d0
                add.b   d0,9(a5)
                bra.w   Sound_ApplyFMVolumeOffset
; End of function Sound_AddChannelTypeVolumeOffset
; Holds the next note without retriggering it (E7)
Sound_HoldNextNote:                                     ; CODE XREF: Sound_DispatchSequenceCommand+26   j  ; was: sub_83932
                bset    #4,(a5)
                rts
; End of function Sound_HoldNextNote
; Sets the note stop timeout (E8)
Sound_SetNoteStopTimeout:                               ; CODE XREF: Sound_DispatchSequenceCommand+2A   j  ; was: sub_83938
                move.b  (a4),$12(a5)
                move.b  (a4)+,$13(a5)
                rts
; End of function Sound_SetNoteStopTimeout
; Configure the YM2612 LFO, operator AM flags, and channel AMS/FMS bits (E9)
Sound_ConfigureFMLFOAndAmplitudeModulation:             ; CODE XREF: Sound_DispatchSequenceCommand+2E   j  ; was: sub_83942
                movea.l (SoundBGMDataPtr).w,a1
                beq.s   Sound_ConfigureFMOperatorAmplitudeModulation
                movea.l $20(a5),a1
Sound_ConfigureFMOperatorAmplitudeModulation:           ; CODE XREF: Sound_ConfigureFMLFOAndAmplitudeModulation+4   j  ; was: loc_8394C
                move.b  (a4),d3
                adda.w  #9,a0
                lea     Sound_FMOperatorDecayAndAMRegisters(pc),a2
                moveq   #3,d6
Sound_ConfigureNextFMOperatorAmplitudeModulation:       ; CODE XREF: Sound_ConfigureFMLFOAndAmplitudeModulation+2A   j  ; was: loc_83958
                move.b  (a1)+,d1
                move.b  (a2)+,d0
                btst    #7,d3
                beq.s   Sound_AdvanceFMOperatorAmplitudeMask
                bset    #7,d1
                jsr     Sound_WriteCurrentFMRegisterIfNotOverridden(pc)  ; (pc)
Sound_AdvanceFMOperatorAmplitudeMask:                   ; CODE XREF: Sound_ConfigureFMLFOAndAmplitudeModulation+1E   j  ; was: loc_8396A
                lsl.w   #1,d3
                dbf     d6,Sound_ConfigureNextFMOperatorAmplitudeModulation
                move.b  (a4)+,d1
                moveq   #$22,d0                         ; '"'
                jsr     Sound_WriteYM2612Port0Thunk(pc)  ; (pc)
                move.b  (a4)+,d1
                move.b  $27(a5),d0
                andi.b  #$C0,d0
                or.b    d0,d1
                move.b  d1,$27(a5)
                jmp     Sound_WriteChannelPanAndAMS(pc)  ; (pc)
; End of function Sound_ConfigureFMLFOAndAmplitudeModulation
; ---------------------------------------------------------------------------
Sound_FMOperatorDecayAndAMRegisters:    dc.b    $60, $68, $64, $6C  ; DATA XREF: Sound_ConfigureFMLFOAndAmplitudeModulation+10   o  ; was: byte_8398C

; Sets the music tempo and reload value (EA)
Sound_SetTempoReload:                                   ; CODE XREF: Sound_DispatchSequenceCommand+32   j  ; was: sub_83990
                move.b  (a4),(SoundTempoReload).w
                move.b  (a4)+,(SoundTempoCounter).w
                rts
; End of function Sound_SetTempoReload
; Queues a sound ID from sequence data (EB)
Sound_QueueSequenceSoundRequest:                        ; CODE XREF: Sound_DispatchSequenceCommand+36   j  ; was: sub_8399A
                move.b  (a4)+,(SoundRequestQueue).w
                rts
; End of function Sound_QueueSequenceSoundRequest
; Adds a PSG volume offset (EC)
Sound_AddPSGVolumeOffset:                               ; CODE XREF: Sound_DispatchSequenceCommand+3A   j  ; was: sub_839A0
                move.b  (a4)+,d0
                add.b   d0,9(a5)
                rts
; End of function Sound_AddPSGVolumeOffset
; Writes a register on the current FM channel (ED)
Sound_WriteCurrentFMRegisterFromSequence:               ; CODE XREF: Sound_DispatchSequenceCommand+3E   j  ; was: sub_839A8
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                bra.w   Sound_WriteCurrentFMRegisterIfNotOverridden
; End of function Sound_WriteCurrentFMRegisterFromSequence
; Writes an address/data pair directly to YM2612 port 0 (EE)
Sound_WriteYM2612Port0RegisterFromSequence:             ; CODE XREF: Sound_DispatchSequenceCommand+42   j  ; was: sub_839B0
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                bra.w   Sound_WriteYM2612Port0Thunk
; End of function Sound_WriteYM2612Port0RegisterFromSequence
; Select and program the channel's FM instrument (EF)
Sound_SelectFMInstrument:                               ; CODE XREF: Sound_DispatchSequenceCommand+46   j  ; was: sub_839B8
                moveq   #0,d0
                move.b  (a4)+,d0
                move.b  d0,$B(a5)
                btst    #2,(a5)
                bne.w   Sound_FMInstrumentUpdateReturn
                movea.l (SoundBGMDataPtr).w,a1
                tst.b   (SoundChannelGroupFlags).w
                beq.s   Sound_ProgramFMInstrument
                movea.l $20(a5),a1
                bmi.s   Sound_ProgramFMInstrument
                movea.l (SoundSpecialSFXDataPtr).w,a1
; End of function Sound_SelectFMInstrument
; Program the selected FM instrument and apply its current channel volume
Sound_ProgramFMInstrument:                              ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+5C   p  ; was: sub_839DC
                                        ; Sound_StopSpecialSFXAndRestoreBGMChannels+2E   p
                subq.w  #1,d0
                bmi.s   Sound_LoadFMInstrumentParameters
                move.w  #$19,d1
Sound_AdvanceToSelectedFMInstrument:                    ; CODE XREF: Sound_ProgramFMInstrument+A   j  ; was: loc_839E4
                adda.w  d1,a1
                dbf     d0,Sound_AdvanceToSelectedFMInstrument
Sound_LoadFMInstrumentParameters:                       ; CODE XREF: Sound_ProgramFMInstrument+2   j  ; was: loc_839EA
                move.b  (a1)+,d1
                move.b  d1,$25(a5)
                move.b  d1,d4
                move.b  #$B0,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                lea     Sound_FMInstrumentParameterRegisters(pc),a2
                moveq   #$13,d3
Sound_WriteNextFMInstrumentParameter:                   ; CODE XREF: Sound_ProgramFMInstrument+2C   j  ; was: loc_83A00
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                dbf     d3,Sound_WriteNextFMInstrumentParameter
                moveq   #3,d5
                andi.w  #7,d4
                move.b  Sound_FMAlgorithmCarrierMasks(pc,d4.w),d4
                move.b  9(a5),d3
Sound_WriteNextFMOperatorLevel:                         ; CODE XREF: Sound_ProgramFMInstrument+4C   j  ; was: loc_83A1A
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                lsr.b   #1,d4
                bcc.s   Sound_WriteFMOperatorLevel
                add.b   d3,d1
Sound_WriteFMOperatorLevel:                             ; CODE XREF: Sound_ProgramFMInstrument+44   j  ; was: loc_83A24
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                dbf     d5,Sound_WriteNextFMOperatorLevel
                cmpi.b  #6,1(a5)
                bne.w   Sound_WriteStoredFMChannelPanning
                cmpa.l  #$40,a5                         ; '@'
                beq.w   Sound_FMInstrumentUpdateReturn
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForZ80BusToShareDACChannelPanning:            ; CODE XREF: Sound_ProgramFMInstrument+7A   j  ; was: loc_83A4E
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForZ80BusToShareDACChannelPanning
                move.b  (Z80DACRequestState).l,d0
                beq.w   Sound_ReleaseZ80BusAfterDACChannelPanning
                move.b  $27(a5),(Z80DACPanningUpdate).l
Sound_ReleaseZ80BusAfterDACChannelPanning:              ; CODE XREF: Sound_ProgramFMInstrument+82   j  ; was: loc_83A6A
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.s   Sound_FMInstrumentUpdateReturn
; Write the stored channel panning/AMS/FMS byte to YM2612 register B4
Sound_WriteStoredFMChannelPanning:                      ; CODE XREF: Sound_ProgramFMInstrument+56   j  ; was: loc_83A78
                move.b  $27(a5),d1
                move.b  #$B4,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
Sound_FMInstrumentUpdateReturn:                         ; CODE XREF: Sound_SelectFMInstrument+C   j  ; was: locret_83A84
                                        ; Sound_ProgramFMInstrument+60   j
                rts
; End of function Sound_ProgramFMInstrument
; ---------------------------------------------------------------------------
Sound_FMAlgorithmCarrierMasks:  dc.b    8, 8, 8, 8, $A, $E, $E, $F  ; was: byte_83A86
                                        ; DATA XREF: Sound_ProgramFMInstrument+36   r
                                        ; Sound_ApplyFMVolumeOffset+42   r

; Apply the channel volume offset to the carrier operators of its FM instrument
Sound_ApplyFMVolumeOffset:                              ; CODE XREF: Sound_UpdateMusicFadeOut:Sound_ApplyBGMFMFadeVolume   p  ; was: sub_83A8E
                                        ; Sound_UpdateBGMVolumeTransitions+EE   p
                btst    #2,(a5)
                bne.s   Sound_ApplyFMVolumeOffsetReturn
                moveq   #0,d0
                move.b  $B(a5),d0
                movea.l (SoundBGMDataPtr).w,a1
                tst.b   (SoundChannelGroupFlags).w
                beq.s   Sound_SelectFMInstrumentForVolumeUpdate
                movea.l $20(a5),a1
                tst.b   (SoundChannelGroupFlags).w
                bmi.s   Sound_SelectFMInstrumentForVolumeUpdate
                movea.l (SoundSpecialSFXDataPtr).w,a1
Sound_SelectFMInstrumentForVolumeUpdate:                ; CODE XREF: Sound_ApplyFMVolumeOffset+14   j  ; was: loc_83AB2
                                        ; Sound_ApplyFMVolumeOffset+1E   j
                subq.w  #1,d0
                bmi.s   Sound_SelectFMOperatorLevelParameters
                move.w  #$19,d1
Sound_AdvanceToCurrentFMInstrument:                     ; CODE XREF: Sound_ApplyFMVolumeOffset+2E   j  ; was: loc_83ABA
                adda.w  d1,a1
                dbf     d0,Sound_AdvanceToCurrentFMInstrument
Sound_SelectFMOperatorLevelParameters:                  ; CODE XREF: Sound_ApplyFMVolumeOffset+26   j  ; was: loc_83AC0
                adda.w  #$15,a1
                lea     Sound_FMOperatorLevelRegisters(pc),a2
                move.b  $25(a5),d0
                andi.w  #7,d0
                move.b  Sound_FMAlgorithmCarrierMasks(pc,d0.w),d4
                move.b  9(a5),d3
                bmi.s   Sound_ApplyFMVolumeOffsetReturn
                moveq   #3,d5
Sound_ApplyNextFMOperatorLevel:                         ; CODE XREF: Sound_ApplyFMVolumeOffset:Sound_ContinueFMOperatorLevelLoop   j  ; was: loc_83ADC
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                lsr.b   #1,d4
                bcc.s   Sound_ContinueFMOperatorLevelLoop
                add.b   d3,d1
                bcs.s   Sound_ContinueFMOperatorLevelLoop
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
Sound_ContinueFMOperatorLevelLoop:                      ; CODE XREF: Sound_ApplyFMVolumeOffset+54   j  ; was: loc_83AEC
                                        ; Sound_ApplyFMVolumeOffset+58   j
                dbf     d5,Sound_ApplyNextFMOperatorLevel
Sound_ApplyFMVolumeOffsetReturn:                        ; CODE XREF: Sound_ApplyFMVolumeOffset+4   j  ; was: locret_83AF0
                                        ; Sound_ApplyFMVolumeOffset+4A   j
                rts
; End of function Sound_ApplyFMVolumeOffset
; ---------------------------------------------------------------------------
Sound_FMInstrumentParameterRegisters:   dc.b    $30, $38, $34, $3C, $50, $58, $54, $5C, $60, $68, $64, $6C, $70, $78, $74, $7C  ; was: byte_83AF2
                                        ; DATA XREF: Sound_ProgramFMInstrument+1E   o
                dc.b    $80, $88, $84, $8C
Sound_FMOperatorLevelRegisters: dc.b    $40, $48, $44, $4C  ; DATA XREF: Sound_ApplyFMVolumeOffset+36   o  ; was: byte_83B06

; Configure the channel's custom vibrato parameters (F0)
Sound_ConfigureVibrato:                                 ; CODE XREF: Sound_DispatchSequenceCommand+4A   j  ; was: sub_83B0A
                bset    #7,$A(a5)
                move.l  a4,$14(a5)
                move.b  (a4)+,$18(a5)
                move.b  (a4)+,$19(a5)
                move.b  (a4)+,$1A(a5)
                move.b  (a4)+,d0
                lsr.b   #1,d0
                move.b  d0,$1B(a5)
                clr.w   $1C(a5)
                rts
; End of function Sound_ConfigureVibrato
; Select separate PSG/FM pitch-envelope IDs by channel type (F1)
Sound_SetChannelTypePitchEnvelope:                      ; CODE XREF: Sound_DispatchSequenceCommand+4E   j  ; was: sub_83B2E
                move.b  (a4)+,d0
                tst.b   1(a5)
                bpl.w   Sound_SetPitchEnvelope
                move.b  d0,$A(a5)
                move.b  (a4)+,d0
                rts
; End of function Sound_SetChannelTypePitchEnvelope
; Stop the current sequence channel and restore any BGM channel it overrode (F2)
Sound_StopSequenceChannel:                              ; CODE XREF: Sound_DispatchSequenceCommand+52   j  ; was: sub_83B40
                                        ; Sound_SilenceFMOperatorsAndStopChannel+4   j
                bclr    #7,(a5)
                bclr    #4,(a5)
                tst.b   1(a5)
                bmi.s   Sound_MuteStoppedPSGChannel
                tst.b   (SoundPCMEventFlag).w
                bmi.w   Sound_ExitStoppedSequenceChannel
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
                bra.s   Sound_CheckStoppedSFXChannelRestore
; ---------------------------------------------------------------------------
Sound_MuteStoppedPSGChannel:                            ; CODE XREF: Sound_StopSequenceChannel+C   j  ; was: loc_83B5C
                jsr     Sound_MutePSGIfNotOverridden(pc)  ; (pc)
Sound_CheckStoppedSFXChannelRestore:                    ; CODE XREF: Sound_StopSequenceChannel+1A   j  ; was: loc_83B60
                tst.b   (SoundChannelGroupFlags).w
                bpl.w   Sound_ExitStoppedSequenceChannel
                clr.b   (SoundCurrentPriority).w
                moveq   #0,d0
                move.b  1(a5),d0
                bmi.s   Sound_SelectStoppedSequenceBGMPSGChannel
                lea     Sound_BGMChannelRecordPointers(pc),a0
                movea.l a5,a3
                cmpi.b  #4,d0
                bne.s   Sound_SelectStoppedSequenceBGMFMChannel
                tst.b   (SoundSpecialSFXFM).w
                bpl.s   Sound_SelectStoppedSequenceBGMFMChannel
                lea     (SoundSpecialSFXFM).w,a5
                movea.l (SoundSpecialSFXDataPtr).w,a1
                bra.s   Sound_RestoreStoppedSequenceBGMFMChannel
; ---------------------------------------------------------------------------
Sound_SelectStoppedSequenceBGMFMChannel:                ; CODE XREF: Sound_StopSequenceChannel+3E   j  ; was: loc_83B90
                                        ; Sound_StopSequenceChannel+44   j
                subq.b  #2,d0
                lsl.b   #2,d0
                movea.l (a0,d0.w),a5
                tst.b   (a5)
                bpl.s   Sound_CheckStoppedFM3SpecialMode
                movea.l (SoundBGMDataPtr).w,a1
Sound_RestoreStoppedSequenceBGMFMChannel:               ; CODE XREF: Sound_StopSequenceChannel+4E   j  ; was: loc_83BA0
                bclr    #2,(a5)
                bset    #1,(a5)
                move.b  $B(a5),d0
                jsr     Sound_ProgramFMInstrument(pc)   ; (pc)
Sound_CheckStoppedFM3SpecialMode:                       ; CODE XREF: Sound_StopSequenceChannel+5A   j  ; was: loc_83BB0
                movea.l a3,a5
                cmpi.b  #2,1(a5)
                bne.s   Sound_ExitStoppedSequenceChannel
                tst.b   (SoundFM3SpecialMode).w
                bne.s   Sound_ExitStoppedSequenceChannel
                moveq   #0,d1
                moveq   #$27,d0                         ; '''
                jsr     Sound_WriteYM2612Port0Thunk(pc)  ; (pc)
                bra.s   Sound_ExitStoppedSequenceChannel
; ---------------------------------------------------------------------------
Sound_SelectStoppedSequenceBGMPSGChannel:               ; CODE XREF: Sound_StopSequenceChannel+32   j  ; was: loc_83BCA
                lea     (SoundSpecialSFXPSG).w,a0
                tst.b   (a0)
                bpl.s   Sound_MapStoppedSequenceBGMPSGChannel
                cmpi.b  #$E0,d0
                beq.s   Sound_RestoreStoppedSequenceBGMPSGChannel
                cmpi.b  #$C0,d0
                beq.s   Sound_RestoreStoppedSequenceBGMPSGChannel
Sound_MapStoppedSequenceBGMPSGChannel:                  ; CODE XREF: Sound_StopSequenceChannel+90   j  ; was: loc_83BDE
                lea     Sound_BGMChannelRecordPointers(pc),a0
                lsr.b   #3,d0
                movea.l (a0,d0.w),a0
Sound_RestoreStoppedSequenceBGMPSGChannel:              ; CODE XREF: Sound_StopSequenceChannel+96   j  ; was: loc_83BE8
                                        ; Sound_StopSequenceChannel+9C   j
                bclr    #2,(a0)
                bset    #1,(a0)
                cmpi.b  #$E0,1(a0)
                bne.s   Sound_ExitStoppedSequenceChannel
                move.b  $25(a0),(VDP_PSG).l
Sound_ExitStoppedSequenceChannel:                       ; CODE XREF: Sound_StopSequenceChannel+12   j  ; was: loc_83C00
                                        ; Sound_StopSequenceChannel+24   j
                addq.w  #8,sp
                rts
; End of function Sound_StopSequenceChannel
; Selects PSG noise mode and writes the PSG control byte (F3)
Sound_SetPSGNoiseMode:                                  ; CODE XREF: Sound_DispatchSequenceCommand+56   j  ; was: sub_83C04
                move.b  #$E0,1(a5)
                move.b  (a4)+,$25(a5)
                btst    #2,(a5)
                bne.s   Sound_SetPSGNoiseModeReturn
                move.b  -1(a4),(VDP_PSG).l
Sound_SetPSGNoiseModeReturn:                            ; CODE XREF: Sound_SetPSGNoiseMode+E   j  ; was: locret_83C1C
                rts
; End of function Sound_SetPSGNoiseMode
; Select a pitch-envelope ID common to all channel types (F4)
Sound_SetPitchEnvelope:                                 ; CODE XREF: Sound_DispatchSequenceCommand+5A   j  ; was: sub_83C1E
                                        ; Sound_SetChannelTypePitchEnvelope+6   j
                move.b  (a4)+,$A(a5)
                rts
; End of function Sound_SetPitchEnvelope
; Select a PSG volume-envelope ID (F5)
Sound_SetPSGVolumeEnvelope:                             ; CODE XREF: Sound_DispatchSequenceCommand+5E   j  ; was: sub_83C24
                move.b  (a4)+,$B(a5)
                rts
; End of function Sound_SetPSGVolumeEnvelope
; Jumps relative offset in track data
Sound_JumpSequenceRelative:                             ; CODE XREF: Sound_DispatchSequenceCommand+62   j  ; was: sub_83C2A
                                        ; Sound_RepeatSequenceBlock+14   j
                move.b  (a4)+,d0
                lsl.w   #8,d0
                move.b  (a4)+,d0
                adda.w  d0,a4
                subq.w  #1,a4
                rts
; End of function Sound_JumpSequenceRelative
; Loop counter with conditional jump
Sound_RepeatSequenceBlock:                              ; CODE XREF: Sound_DispatchSequenceCommand+66   j  ; was: sub_83C36
                moveq   #0,d0
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                tst.b   $28(a5,d0.w)
                bne.s   Sound_DecrementSequenceLoopCounter
                move.b  d1,$28(a5,d0.w)
Sound_DecrementSequenceLoopCounter:                     ; CODE XREF: Sound_RepeatSequenceBlock+A   j  ; was: loc_83C46
                subq.b  #1,$28(a5,d0.w)
                bne.s   Sound_JumpSequenceRelative
                addq.w  #2,a4
                rts
; End of function Sound_RepeatSequenceBlock
; Calls a relative sequence subroutine (F8)
Sound_CallRelativeSequenceSubroutine:                   ; CODE XREF: Sound_DispatchSequenceCommand+6A   j  ; was: sub_83C50
                moveq   #0,d0
                move.b  $D(a5),d0
                subq.b  #4,d0
                move.l  a4,(a5,d0.w)
                move.b  d0,$D(a5)
                bra.s   Sound_JumpSequenceRelative
; End of function Sound_CallRelativeSequenceSubroutine
; Returns from a sequence subroutine (F9)
Sound_ReturnFromSequenceSubroutine:                     ; CODE XREF: Sound_DispatchSequenceCommand+6E   j  ; was: sub_83C62
                moveq   #0,d0
                move.b  $D(a5),d0
                movea.l (a5,d0.w),a4
                addq.w  #2,a4
                addq.b  #4,d0
                move.b  d0,$D(a5)
                rts
; End of function Sound_ReturnFromSequenceSubroutine
; Sets the current channel tick multiplier (FA)
Sound_SetChannelTickMultiplier:                         ; CODE XREF: Sound_DispatchSequenceCommand+72   j  ; was: sub_83C76
                move.b  (a4)+,2(a5)
                rts
; End of function Sound_SetChannelTickMultiplier
; Adds transpose value to sound channel pitch offset
Sound_AddChannelTranspose:                              ; CODE XREF: Sound_DispatchSequenceCommand+76   j  ; was: sub_83C7C
                move.b  (a4)+,d0
                add.b   d0,8(a5)
                rts
; End of function Sound_AddChannelTranspose
; Enable the custom vibrato state stored in the channel record (FC)
Sound_EnableVibrato:                                    ; CODE XREF: Sound_DispatchSequenceCommand+7A   j  ; was: sub_83C84
                bset    #7,$A(a5)
                rts
; End of function Sound_EnableVibrato
; Disable the channel's custom vibrato state (FD)
Sound_DisableVibrato:                                   ; CODE XREF: Sound_DispatchSequenceCommand+7E   j  ; was: sub_83C8C
                bclr    #7,$A(a5)
                rts
; End of function Sound_DisableVibrato
; Configures YM2612 CH3 special mode with frequency values for each operator
Sound_SetFM3SpecialMode:                                ; CODE XREF: Sound_DispatchSequenceCommand+82   j  ; was: sub_83C94
                lea     (SoundSFXFM3Offsets).w,a0
                tst.b   (SoundChannelGroupFlags).w
                bne.s   Sound_SelectFM3SpecialFrequencyOffsetSlots
                lea     (SoundBGMFM3Offsets).w,a0
                move.b  #$80,(SoundFM3SpecialMode).w
Sound_SelectFM3SpecialFrequencyOffsetSlots:             ; CODE XREF: Sound_SetFM3SpecialMode+8   j  ; was: loc_83CA8
                moveq   #3,d0
Sound_SetNextFM3SpecialFrequencyOffset:                 ; CODE XREF: Sound_SetFM3SpecialMode+20   j  ; was: loc_83CAA
                moveq   #0,d1
                move.b  (a4)+,d1
                lsl.w   #1,d1
                move.w  Sound_FM3SpecialFrequencyOffsetTable(pc,d1.w),(a0)+
                dbf     d0,Sound_SetNextFM3SpecialFrequencyOffset
                move.b  #$27,d0                         ; '''
                moveq   #$40,d1                         ; '@'
                bra.w   Sound_WriteYM2612Port0Thunk
; End of function Sound_SetFM3SpecialMode
; ---------------------------------------------------------------------------
Sound_FM3SpecialFrequencyOffsetTable:   dc.w    0, $180, $1F4, $260  ; was: word_83CC2
                                        ; DATA XREF: Sound_SetFM3SpecialMode+1C   r

; Configures SSG-EG and forces full attack for all four FM operators (FF 00)
Sound_ConfigureFMSSGEG:                                 ; CODE XREF: Sound_DispatchExtendedSequenceCommand:Sound_ExtendedSequenceCommandJumpTable   j  ; was: sub_83CCA
                lea     Sound_FMOperatorSSGEGAndAttackRateRegisters(pc),a1
                moveq   #3,d3
Sound_ConfigureNextFMOperatorSSGEG:                     ; CODE XREF: Sound_ConfigureFMSSGEG+16   j  ; was: loc_83CD0
                move.b  (a1)+,d0
                move.b  (a4)+,d1
                jsr     Sound_WriteCurrentFMRegisterIfNotOverridden(pc)  ; (pc)
                move.b  (a1)+,d0
                moveq   #$1F,d1
                jsr     Sound_WriteCurrentFMRegisterIfNotOverridden(pc)  ; (pc)
                dbf     d3,Sound_ConfigureNextFMOperatorSSGEG
                rts
; End of function Sound_ConfigureFMSSGEG
; ---------------------------------------------------------------------------
Sound_FMOperatorSSGEGAndAttackRateRegisters:    dc.b    $90, $50, $98, $58, $94, $54, $9C, $5C  ; was: byte_83CE6
                                        ; DATA XREF: Sound_ConfigureFMSSGEG   o

; Pause or resume the ten BGM playback records (FF 01)
Sound_SetBGMPlaybackPaused:                             ; CODE XREF: Sound_DispatchExtendedSequenceCommand+E   j  ; was: sub_83CEE
                moveq   #$30,d3                         ; '0'
                move.b  (a4)+,d0
                beq.s   Sound_ResumeBGMPlayback
                movea.l a5,a3
                lea     (SoundPCMChannelRecord).w,a5
                btst    #7,(a5)
                beq.s   Sound_PrepareBGMFMPauseLoop
                bclr    #7,(a5)
                bset    #0,(a5)
Sound_PrepareBGMFMPauseLoop:                            ; CODE XREF: Sound_SetBGMPlaybackPaused+10   j  ; was: loc_83D08
                moveq   #5,d4
Sound_PauseNextBGMFMChannel:                            ; CODE XREF: Sound_SetBGMPlaybackPaused:Sound_ContinueBGMFMPauseLoop   j  ; was: loc_83D0A
                adda.w  d3,a5
                btst    #7,(a5)
                beq.s   Sound_ContinueBGMFMPauseLoop
                bclr    #7,(a5)
                bset    #0,(a5)
                move.b  #$B4,d0
                moveq   #0,d1
                jsr     Sound_WriteCurrentFMRegisterIfNotOverridden(pc)  ; (pc)
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
Sound_ContinueBGMFMPauseLoop:                           ; CODE XREF: Sound_SetBGMPlaybackPaused+22   j  ; was: loc_83D28
                dbf     d4,Sound_PauseNextBGMFMChannel
                moveq   #2,d4
Sound_PauseNextBGMPSGChannel:                           ; CODE XREF: Sound_SetBGMPlaybackPaused:Sound_ContinueBGMPSGPauseLoop   j  ; was: loc_83D2E
                adda.w  d3,a5
                btst    #7,(a5)
                beq.s   Sound_ContinueBGMPSGPauseLoop
                bclr    #7,(a5)
                bset    #0,(a5)
                jsr     Sound_MutePSGIfNotOverridden(pc)  ; (pc)
Sound_ContinueBGMPSGPauseLoop:                          ; CODE XREF: Sound_SetBGMPlaybackPaused+46   j  ; was: loc_83D42
                dbf     d4,Sound_PauseNextBGMPSGChannel
                movea.l a3,a5
                rts
; ---------------------------------------------------------------------------
Sound_ResumeBGMPlayback:                                ; CODE XREF: Sound_SetBGMPlaybackPaused+4   j  ; was: loc_83D4A
                movea.l a5,a3
                lea     (SoundPCMChannelRecord).w,a5
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForZ80BusToReadDACPanning:                    ; CODE XREF: Sound_SetBGMPlaybackPaused+78   j  ; was: loc_83D5E
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForZ80BusToReadDACPanning
                move.b  (Z80DACRequestState).l,d0
                move.b  (Z80DACPanning).l,d1
                move.b  (Z80DACCommandByte6).l,d2
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                beq.w   Sound_ResumeBGMPCMChannel
                bpl.w   Sound_RestoreActiveDACPanning
                move.b  d2,d1
Sound_RestoreActiveDACPanning:                          ; CODE XREF: Sound_SetBGMPlaybackPaused+9C   j  ; was: loc_83D90
                move.b  #$B6,d0
                jsr     Sound_WriteYM2612Port1(pc)      ; (pc)
Sound_ResumeBGMPCMChannel:                              ; CODE XREF: Sound_SetBGMPlaybackPaused+98   j  ; was: loc_83D98
                btst    #0,(a5)
                beq.s   Sound_PrepareBGMFMResumeLoop
                bset    #7,(a5)
                bclr    #0,(a5)
Sound_PrepareBGMFMResumeLoop:                           ; CODE XREF: Sound_SetBGMPlaybackPaused+AE   j  ; was: loc_83DA6
                moveq   #5,d4
Sound_ResumeNextBGMFMChannel:                           ; CODE XREF: Sound_SetBGMPlaybackPaused:Sound_ContinueBGMFMResumeLoop   j  ; was: loc_83DA8
                adda.w  d3,a5
                btst    #0,(a5)
                beq.s   Sound_ContinueBGMFMResumeLoop
                bset    #7,(a5)
                bclr    #0,(a5)
                btst    #2,(a5)
                bne.s   Sound_ContinueBGMFMResumeLoop
                move.b  $27(a5),d1
                cmpi.b  #6,1(a5)
                bne.w   Sound_RestoreBGMFMChannelPanning
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
Sound_WaitForZ80BusBeforeFM6PanningRestore:             ; CODE XREF: Sound_SetBGMPlaybackPaused+F4   j  ; was: loc_83DDA
                bset    #0,(IO_Z80BUS).l
                bne.s   Sound_WaitForZ80BusBeforeFM6PanningRestore
                move.b  (Z80DACRequestState).l,d0
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.w   Sound_ContinueBGMFMResumeLoop
Sound_RestoreBGMFMChannelPanning:                       ; CODE XREF: Sound_SetBGMPlaybackPaused+DA   j  ; was: loc_83DFA
                move.b  #$B4,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
Sound_ContinueBGMFMResumeLoop:                          ; CODE XREF: Sound_SetBGMPlaybackPaused+C0   j  ; was: loc_83E02
                                        ; Sound_SetBGMPlaybackPaused+CE   j
                dbf     d4,Sound_ResumeNextBGMFMChannel
                moveq   #2,d4
Sound_ResumeNextBGMPSGChannel:                          ; CODE XREF: Sound_SetBGMPlaybackPaused:Sound_ContinueBGMPSGResumeLoop   j  ; was: loc_83E08
                adda.w  d3,a5
                btst    #0,(a5)
                beq.s   Sound_ContinueBGMPSGResumeLoop
                bset    #7,(a5)
                bclr    #0,(a5)
Sound_ContinueBGMPSGResumeLoop:                         ; CODE XREF: Sound_SetBGMPlaybackPaused+120   j  ; was: loc_83E18
                dbf     d4,Sound_ResumeNextBGMPSGChannel
                movea.l a3,a5
                rts
; End of function Sound_SetBGMPlaybackPaused
; Sets the tick multiplier for all ten sound channels (FF 02)
Sound_SetAllBGMChannelTickMultipliers:                  ; CODE XREF: Sound_DispatchExtendedSequenceCommand+12   j  ; was: sub_83E20
                lea     (SoundPCMChannelRecord).w,a0
                move.b  (a4)+,d0
                moveq   #$30,d1                         ; '0'
                moveq   #9,d2
Sound_SetNextBGMChannelTickMultiplier:                  ; CODE XREF: Sound_SetAllBGMChannelTickMultipliers+10   j  ; was: loc_83E2A
                move.b  d0,2(a0)
                adda.w  d1,a0
                dbf     d2,Sound_SetNextBGMChannelTickMultiplier
                rts
; End of function Sound_SetAllBGMChannelTickMultipliers
; Request one BGM attenuation step, installing its FM/PSG amounts if idle (FF 03)
Sound_RequestBGMVolumeAttenuation:                      ; CODE XREF: Sound_DispatchExtendedSequenceCommand+16   j  ; was: sub_83E36
                tst.b   (SoundManualVolumeState).w
                beq.w   Sound_StartBGMVolumeAttenuationRequest
                addq.w  #2,a4
                rts
; ---------------------------------------------------------------------------
Sound_StartBGMVolumeAttenuationRequest:                 ; CODE XREF: Sound_RequestBGMVolumeAttenuation+4   j  ; was: loc_83E42
                move.b  #1,(SoundManualVolumeState).w
                move.b  (SoundFMVolumeStep).w,d0
                or.b    (SoundPSGVolumeStep).w,d0
                bne.w   Sound_RequestBGMVolumeAttenuationReturn
                move.b  (a4)+,(SoundFMVolumeStep).w
                move.b  (a4)+,(SoundPSGVolumeStep).w
Sound_RequestBGMVolumeAttenuationReturn:                ; CODE XREF: Sound_RequestBGMVolumeAttenuation+1A   j  ; was: locret_83E5C
                rts
; End of function Sound_RequestBGMVolumeAttenuation
; Request restoration after the pending BGM attenuation has been applied (FF 04)
Sound_RequestBGMVolumeRestore:                          ; CODE XREF: Sound_DispatchExtendedSequenceCommand+1A   j  ; was: sub_83E5E
                cmpi.b  #2,(SoundManualVolumeState).w
                bne.w   Sound_RequestBGMVolumeRestoreReturn
                move.b  #$80,(SoundManualVolumeState).w
Sound_RequestBGMVolumeRestoreReturn:                    ; CODE XREF: Sound_RequestBGMVolumeRestore+6   j  ; was: locret_83E6E
                rts
; End of function Sound_RequestBGMVolumeRestore
; ---------------------------------------------------------------------------
