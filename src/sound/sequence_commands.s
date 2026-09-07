Sound_CommandDispatcher:                                ; CODE XREF: Sound_PlayPSGSequence+1C   p  ; was: sub_83820
                                        ; Sound_ParseTrackData+12   p
                subi.w  #$E0,d5
                lsl.w   #2,d5
                jmp     loc_8382A(pc,d5.w)
; ---------------------------------------------------------------------------
loc_8382A:                                              ; CODE XREF: Sound_CommandDispatcher+6   j
                bra.w   Sound_SetPanAndAMS              ; E0: pan + AMS/FMS
; ---------------------------------------------------------------------------
                bra.w   Sound_SetDetune                 ; E1: detune
; ---------------------------------------------------------------------------
                bra.w   Sound_SetCommunication          ; E2: communication byte
; ---------------------------------------------------------------------------
                bra.w   Sound_MuteAndStop               ; E3: mute and stop track
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPanAnimation           ; E4: pan animation
; ---------------------------------------------------------------------------
                bra.w   Sound_AddPSGFMVolume            ; E5: PSG/FM volume pair
; ---------------------------------------------------------------------------
                bra.w   Sound_AddFMVolume               ; E6: FM volume
; ---------------------------------------------------------------------------
                bra.w   Sound_HoldNextNote              ; E7: hold next note
; ---------------------------------------------------------------------------
                bra.w   Sound_SetNoteStop               ; E8: note stop timeout
; ---------------------------------------------------------------------------
                bra.w   Sound_SetLFO                    ; E9: YM2612 LFO
; ---------------------------------------------------------------------------
                bra.w   Sound_SetTempo                  ; EA: tempo
; ---------------------------------------------------------------------------
                bra.w   Sound_QueueSoundCommand         ; EB: queue sound ID
; ---------------------------------------------------------------------------
                bra.w   Sound_AddPSGVolume              ; EC: PSG volume
; ---------------------------------------------------------------------------
                bra.w   Sound_WriteFMChannelRegister    ; ED: current FM channel register
; ---------------------------------------------------------------------------
                bra.w   Sound_WriteFM1Register          ; EE: FM1 register
; ---------------------------------------------------------------------------
                bra.w   Sound_SelectInstrument          ; EF: FM instrument
; ---------------------------------------------------------------------------
                bra.w   Sound_SetupModulation           ; F0: custom modulation
; ---------------------------------------------------------------------------
                bra.w   Sound_SetModulationEnvelopeByChannel  ; F1: PSG/FM modulation envelopes
; ---------------------------------------------------------------------------
                bra.w   Sound_StopChannel               ; F2: stop track
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPSGNoise               ; F3: PSG noise
; ---------------------------------------------------------------------------
                bra.w   Sound_SetModulationEnvelope     ; F4: modulation envelope
; ---------------------------------------------------------------------------
                bra.w   Sound_SetPSGInstrument          ; F5: PSG instrument
; ---------------------------------------------------------------------------
                bra.w   Sound_JumpRelative              ; F6: jump
; ---------------------------------------------------------------------------
                bra.w   Sound_LoopCounter               ; F7: loop
; ---------------------------------------------------------------------------
                bra.w   Sound_CallSequenceSubroutine    ; F8: call sequence subroutine
; ---------------------------------------------------------------------------
                bra.w   Sound_ReturnFromSequenceSubroutine  ; F9: return
; ---------------------------------------------------------------------------
                bra.w   Sound_SetTickMultiplier         ; FA: current tick multiplier
; ---------------------------------------------------------------------------
                bra.w   Sound_AddTranspose              ; FB: transpose
; ---------------------------------------------------------------------------
                bra.w   Sound_EnableModulationFlag      ; FC: enable modulation
; ---------------------------------------------------------------------------
                bra.w   Sound_DisableModulationFlag     ; FD: disable modulation
; ---------------------------------------------------------------------------
                bra.w   Sound_SetCH3SpecialMode         ; FE: YM2612 channel 3 special mode
; End of function Sound_CommandDispatcher
; Dispatches extended sound commands via jump table
Sound_ExtendedCommandDispatch:
                moveq   #0,d0                           ; was: sub_838A6
                move.b  (a4)+,d0
                lsl.w   #2,d0
                jmp     loc_838B0(pc,d0.w)
; ---------------------------------------------------------------------------
loc_838B0:                                              ; CODE XREF: Sound_ExtendedCommandDispatch+6   j
                                        ; DATA XREF: Sound_ExtendedCommandDispatch+6   o
                bra.w   Sound_SetSSGEG                  ; FF 00: SSG-EG setup
; ---------------------------------------------------------------------------
                bra.w   Sound_SetMusicPaused            ; FF 01: pause/resume music
; ---------------------------------------------------------------------------
                bra.w   Sound_SetAllTickMultipliers     ; FF 02: all tick multipliers
; ---------------------------------------------------------------------------
                bra.w   Sound_InitializeFadeParams      ; FF 03: special fade
; ---------------------------------------------------------------------------
                bra.w   Sound_CheckFadeComplete         ; FF 04: stop special fade
; End of function Sound_ExtendedCommandDispatch
; Sets channel panning and YM2612 AMS/FMS flags (E0)
Sound_SetPanAndAMS:                                     ; CODE XREF: Sound_CommandDispatcher:loc_8382A   j  ; was: sub_838C4
                move.b  (a4)+,d1
                tst.b   1(a5)
                bmi.s   locret_838DE
                move.b  $27(a5),d0
                andi.b  #$37,d0                         ; '7'
                or.b    d0,d1
                move.b  d1,$27(a5)
                jmp     Sound_SendPSGVolumeUpdate(pc)   ; (pc)
; ---------------------------------------------------------------------------
locret_838DE:                                           ; CODE XREF: Sound_SetPanAndAMS+6   j
                rts
; End of function Sound_SetPanAndAMS
; Sets channel detune (E1)
Sound_SetDetune:                                        ; CODE XREF: Sound_CommandDispatcher+E   j  ; was: sub_838E0
                move.b  (a4)+,$1E(a5)
                rts
; End of function Sound_SetDetune
; Sets the global communication byte (E2)
Sound_SetCommunication:                                 ; CODE XREF: Sound_CommandDispatcher+12   j  ; was: sub_838E6
                move.b  (a4)+,(byte_FFF803).w
                rts
; End of function Sound_SetCommunication
; Mutes all channels then stops the current channel
Sound_MuteAndStop:                                      ; CODE XREF: Sound_CommandDispatcher+16   j  ; was: sub_838EC
                jsr     Sound_MuteAllChannels(pc)       ; (pc)
                bra.w   Sound_StopChannel
; End of function Sound_MuteAndStop
; Configures or disables pan animation (E4)
Sound_SetPanAnimation:                                  ; CODE XREF: Sound_CommandDispatcher+1A   j  ; was: sub_838F4
                move.b  (a4)+,$1F(a5)
                beq.s   loc_83910
                move.b  (a4)+,$20(a5)
                move.b  (a4)+,$21(a5)
                move.b  (a4)+,$22(a5)
                move.b  (a4),$23(a5)
                move.b  (a4)+,$24(a5)
                rts
; ---------------------------------------------------------------------------
loc_83910:                                              ; CODE XREF: Sound_SetPanAnimation+4   j
                move.b  $27(a5),d1
                jmp     Sound_SendPSGVolumeUpdate(pc)   ; (pc)
; End of function Sound_SetPanAnimation
; Adds separate PSG/FM volume offsets, selecting by channel type (E5)
Sound_AddPSGFMVolume:                                   ; CODE XREF: Sound_CommandDispatcher+1E   j  ; was: sub_83918
                move.b  (a4)+,d0
                tst.b   1(a5)
                bpl.s   Sound_AddFMVolume
                add.b   d0,9(a5)
                addq.w  #1,a4
                rts
; ---------------------------------------------------------------------------
Sound_AddFMVolume:                                      ; CODE XREF: Sound_CommandDispatcher+22   j
                                        ; Sound_AddPSGFMVolume+6   j
                move.b  (a4)+,d0
                add.b   d0,9(a5)
                bra.w   Sound_ApplyVolume
; End of function Sound_AddPSGFMVolume
; Holds the next note without retriggering it (E7)
Sound_HoldNextNote:                                     ; CODE XREF: Sound_CommandDispatcher+26   j  ; was: sub_83932
                bset    #4,(a5)
                rts
; End of function Sound_HoldNextNote
; Sets the note stop timeout (E8)
Sound_SetNoteStop:                                      ; CODE XREF: Sound_CommandDispatcher+2A   j  ; was: sub_83938
                move.b  (a4),$12(a5)
                move.b  (a4)+,$13(a5)
                rts
; End of function Sound_SetNoteStop
; Configures the YM2612 LFO and channel AMS/FMS settings (E9)
Sound_SetLFO:                                           ; CODE XREF: Sound_CommandDispatcher+2E   j  ; was: sub_83942
                movea.l (dword_FFF820).w,a1
                beq.s   loc_8394C
                movea.l $20(a5),a1
loc_8394C:                                              ; CODE XREF: Sound_SetLFO+4   j
                move.b  (a4),d3
                adda.w  #9,a0
                lea     byte_8398C(pc),a2
                moveq   #3,d6
loc_83958:                                              ; CODE XREF: Sound_SetLFO+2A   j
                move.b  (a1)+,d1
                move.b  (a2)+,d0
                btst    #7,d3
                beq.s   loc_8396A
                bset    #7,d1
                jsr     Sound_CheckPauseFlag(pc)        ; (pc)
loc_8396A:                                              ; CODE XREF: Sound_SetLFO+1E   j
                lsl.w   #1,d3
                dbf     d6,loc_83958
                move.b  (a4)+,d1
                moveq   #$22,d0                         ; '"'
                jsr     Sound_WriteYM2612Wrapper(pc)    ; (pc)
                move.b  (a4)+,d1
                move.b  $27(a5),d0
                andi.b  #$C0,d0
                or.b    d0,d1
                move.b  d1,$27(a5)
                jmp     Sound_SendPSGVolumeUpdate(pc)   ; (pc)
; End of function Sound_SetLFO
; ---------------------------------------------------------------------------
byte_8398C:     dc.b    $60, $68, $64, $6C              ; DATA XREF: Sound_SetLFO+10   o

; Sets the music tempo and reload value (EA)
Sound_SetTempo:                                         ; CODE XREF: Sound_CommandDispatcher+32   j  ; was: sub_83990
                move.b  (a4),(byte_FFF802).w
                move.b  (a4)+,(byte_FFF801).w
                rts
; End of function Sound_SetTempo
; Queues a sound ID from sequence data (EB)
Sound_QueueSoundCommand:                                ; CODE XREF: Sound_CommandDispatcher+36   j  ; was: sub_8399A
                move.b  (a4)+,(dword_FFF80A).w
                rts
; End of function Sound_QueueSoundCommand
; Adds a PSG volume offset (EC)
Sound_AddPSGVolume:                                     ; CODE XREF: Sound_CommandDispatcher+3A   j  ; was: sub_839A0
                move.b  (a4)+,d0
                add.b   d0,9(a5)
                rts
; End of function Sound_AddPSGVolume
; Writes a register on the current FM channel (ED)
Sound_WriteFMChannelRegister:                           ; CODE XREF: Sound_CommandDispatcher+3E   j  ; was: sub_839A8
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                bra.w   Sound_CheckPauseFlag
; End of function Sound_WriteFMChannelRegister
; Writes a register on YM2612 port 0/FM1 (EE)
Sound_WriteFM1Register:                                 ; CODE XREF: Sound_CommandDispatcher+42   j  ; was: sub_839B0
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                bra.w   Sound_WriteYM2612Wrapper
; End of function Sound_WriteFM1Register
; Selects instrument for sound channel
Sound_SelectInstrument:                                 ; CODE XREF: Sound_CommandDispatcher+46   j  ; was: sub_839B8
                moveq   #0,d0
                move.b  (a4)+,d0
                move.b  d0,$B(a5)
                btst    #2,(a5)
                bne.w   locret_83A84
                movea.l (dword_FFF820).w,a1
                tst.b   (byte_FFF80E).w
                beq.s   Sound_SetFMInstrument
                movea.l $20(a5),a1
                bmi.s   Sound_SetFMInstrument
                movea.l (dword_FFF824).w,a1
; End of function Sound_SelectInstrument
; Sets FM channel instrument parameters registers and envelope data
Sound_SetFMInstrument:                                  ; CODE XREF: Sound_ProcessFM+5C   p  ; was: sub_839DC
                                        ; Sound_ProcessSpecialChannels+2E   p
                subq.w  #1,d0
                bmi.s   loc_839EA
                move.w  #$19,d1
loc_839E4:                                              ; CODE XREF: Sound_SetFMInstrument+A   j
                adda.w  d1,a1
                dbf     d0,loc_839E4
loc_839EA:                                              ; CODE XREF: Sound_SetFMInstrument+2   j
                move.b  (a1)+,d1
                move.b  d1,$25(a5)
                move.b  d1,d4
                move.b  #$B0,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                lea     byte_83AF2(pc),a2
                moveq   #$13,d3
loc_83A00:                                              ; CODE XREF: Sound_SetFMInstrument+2C   j
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                dbf     d3,loc_83A00
                moveq   #3,d5
                andi.w  #7,d4
                move.b  byte_83A86(pc,d4.w),d4
                move.b  9(a5),d3
loc_83A1A:                                              ; CODE XREF: Sound_SetFMInstrument+4C   j
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                lsr.b   #1,d4
                bcc.s   loc_83A24
                add.b   d3,d1
loc_83A24:                                              ; CODE XREF: Sound_SetFMInstrument+44   j
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                dbf     d5,loc_83A1A
                cmpi.b  #6,1(a5)
                bne.w   Sound_SetChannelPanning
                cmpa.l  #$40,a5                         ; '@'
                beq.w   locret_83A84
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_83A4E:                                              ; CODE XREF: Sound_SetFMInstrument+7A   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_83A4E
                move.b  (byte_A01FFD).l,d0
                beq.w   loc_83A6A
                move.b  $27(a5),(byte_A01FF8).l
loc_83A6A:                                              ; CODE XREF: Sound_SetFMInstrument+82   j
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.s   locret_83A84
; Sets FM channel panning register
Sound_SetChannelPanning:                                ; CODE XREF: Sound_SetFMInstrument+56   j  ; was: loc_83A78
                move.b  $27(a5),d1
                move.b  #$B4,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
locret_83A84:                                           ; CODE XREF: Sound_SelectInstrument+C   j
                                        ; Sound_SetFMInstrument+60   j
                rts
; End of function Sound_SetFMInstrument
; ---------------------------------------------------------------------------
byte_83A86:     dc.b    8, 8, 8, 8, $A, $E, $E, $F
                                        ; DATA XREF: Sound_SetFMInstrument+36   r
                                        ; Sound_ApplyVolume+42   r

; Applies volume and pan to sound channel
Sound_ApplyVolume:                                      ; CODE XREF: Sound_InitializeChannels:loc_833F4   p  ; was: sub_83A8E
                                        ; Sound_ProcessVolumeFade+EE   p
                btst    #2,(a5)
                bne.s   locret_83AF0
                moveq   #0,d0
                move.b  $B(a5),d0
                movea.l (dword_FFF820).w,a1
                tst.b   (byte_FFF80E).w
                beq.s   loc_83AB2
                movea.l $20(a5),a1
                tst.b   (byte_FFF80E).w
                bmi.s   loc_83AB2
                movea.l (dword_FFF824).w,a1
loc_83AB2:                                              ; CODE XREF: Sound_ApplyVolume+14   j
                                        ; Sound_ApplyVolume+1E   j
                subq.w  #1,d0
                bmi.s   loc_83AC0
                move.w  #$19,d1
loc_83ABA:                                              ; CODE XREF: Sound_ApplyVolume+2E   j
                adda.w  d1,a1
                dbf     d0,loc_83ABA
loc_83AC0:                                              ; CODE XREF: Sound_ApplyVolume+26   j
                adda.w  #$15,a1
                lea     byte_83B06(pc),a2
                move.b  $25(a5),d0
                andi.w  #7,d0
                move.b  byte_83A86(pc,d0.w),d4
                move.b  9(a5),d3
                bmi.s   locret_83AF0
                moveq   #3,d5
loc_83ADC:                                              ; CODE XREF: Sound_ApplyVolume:loc_83AEC   j
                move.b  (a2)+,d0
                move.b  (a1)+,d1
                lsr.b   #1,d4
                bcc.s   Sound_ApplyVolumeLoop
                add.b   d3,d1
                bcs.s   Sound_ApplyVolumeLoop
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
; Volume apply loop for operators
Sound_ApplyVolumeLoop:                                  ; CODE XREF: Sound_ApplyVolume+54   j  ; was: loc_83AEC
                                        ; Sound_ApplyVolume+58   j
                dbf     d5,loc_83ADC
locret_83AF0:                                           ; CODE XREF: Sound_ApplyVolume+4   j
                                        ; Sound_ApplyVolume+4A   j
                rts
; End of function Sound_ApplyVolume
; ---------------------------------------------------------------------------
byte_83AF2:     dc.b    $30, $38, $34, $3C, $50, $58, $54, $5C, $60, $68, $64, $6C, $70, $78, $74, $7C
                                        ; DATA XREF: Sound_SetFMInstrument+1E   o
                dc.b    $80, $88, $84, $8C
byte_83B06:     dc.b    $40, $48, $44, $4C              ; DATA XREF: Sound_ApplyVolume+36   o

; Sets up custom modulation parameters (F0)
Sound_SetupModulation:                                  ; CODE XREF: Sound_CommandDispatcher+4A   j  ; was: sub_83B0A
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
; End of function Sound_SetupModulation
; Selects separate PSG/FM modulation envelopes by channel type (F1)
Sound_SetModulationEnvelopeByChannel:                   ; CODE XREF: Sound_CommandDispatcher+4E   j  ; was: sub_83B2E
                move.b  (a4)+,d0
                tst.b   1(a5)
                bpl.w   Sound_SetModulationEnvelope
                move.b  d0,$A(a5)
                move.b  (a4)+,d0
                rts
; End of function Sound_SetModulationEnvelopeByChannel
; Stops sound channel clearing flags and sending key off commands
Sound_StopChannel:                                      ; CODE XREF: Sound_CommandDispatcher+52   j  ; was: sub_83B40
                                        ; Sound_MuteAndStop+4   j
                bclr    #7,(a5)
                bclr    #4,(a5)
                tst.b   1(a5)
                bmi.s   loc_83B5C
                tst.b   (byte_FFF808).w
                bmi.w   loc_83C00
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
                bra.s   loc_83B60
; ---------------------------------------------------------------------------
loc_83B5C:                                              ; CODE XREF: Sound_StopChannel+C   j
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
loc_83B60:                                              ; CODE XREF: Sound_StopChannel+1A   j
                tst.b   (byte_FFF80E).w
                bpl.w   loc_83C00
                clr.b   (byte_FFF800).w
                moveq   #0,d0
                move.b  1(a5),d0
                bmi.s   loc_83BCA
                lea     dword_83196(pc),a0
                movea.l a5,a3
                cmpi.b  #4,d0
                bne.s   loc_83B90
                tst.b   (word_FFFB40).w
                bpl.s   loc_83B90
                lea     (word_FFFB40).w,a5
                movea.l (dword_FFF824).w,a1
                bra.s   loc_83BA0
; ---------------------------------------------------------------------------
loc_83B90:                                              ; CODE XREF: Sound_StopChannel+3E   j
                                        ; Sound_StopChannel+44   j
                subq.b  #2,d0
                lsl.b   #2,d0
                movea.l (a0,d0.w),a5
                tst.b   (a5)
                bpl.s   loc_83BB0
                movea.l (dword_FFF820).w,a1
loc_83BA0:                                              ; CODE XREF: Sound_StopChannel+4E   j
                bclr    #2,(a5)
                bset    #1,(a5)
                move.b  $B(a5),d0
                jsr     Sound_SetFMInstrument(pc)       ; (pc)
loc_83BB0:                                              ; CODE XREF: Sound_StopChannel+5A   j
                movea.l a3,a5
                cmpi.b  #2,1(a5)
                bne.s   loc_83C00
                tst.b   (byte_FFF80F).w
                bne.s   loc_83C00
                moveq   #0,d1
                moveq   #$27,d0                         ; '''
                jsr     Sound_WriteYM2612Wrapper(pc)    ; (pc)
                bra.s   loc_83C00
; ---------------------------------------------------------------------------
loc_83BCA:                                              ; CODE XREF: Sound_StopChannel+32   j
                lea     (word_FFFB70).w,a0
                tst.b   (a0)
                bpl.s   loc_83BDE
                cmpi.b  #$E0,d0
                beq.s   loc_83BE8
                cmpi.b  #$C0,d0
                beq.s   loc_83BE8
loc_83BDE:                                              ; CODE XREF: Sound_StopChannel+90   j
                lea     dword_83196(pc),a0
                lsr.b   #3,d0
                movea.l (a0,d0.w),a0
loc_83BE8:                                              ; CODE XREF: Sound_StopChannel+96   j
                                        ; Sound_StopChannel+9C   j
                bclr    #2,(a0)
                bset    #1,(a0)
                cmpi.b  #$E0,1(a0)
                bne.s   loc_83C00
                move.b  $25(a0),(VDP_PSG).l
loc_83C00:                                              ; CODE XREF: Sound_StopChannel+12   j
                                        ; Sound_StopChannel+24   j
                addq.w  #8,sp
                rts
; End of function Sound_StopChannel
; Selects PSG noise mode and writes the PSG control byte (F3)
Sound_SetPSGNoise:                                      ; CODE XREF: Sound_CommandDispatcher+56   j  ; was: sub_83C04
                move.b  #$E0,1(a5)
                move.b  (a4)+,$25(a5)
                btst    #2,(a5)
                bne.s   locret_83C1C
                move.b  -1(a4),(VDP_PSG).l
locret_83C1C:                                           ; CODE XREF: Sound_SetPSGNoise+E   j
                rts
; End of function Sound_SetPSGNoise
; Selects a modulation envelope common to all channel types (F4)
Sound_SetModulationEnvelope:                            ; CODE XREF: Sound_CommandDispatcher+5A   j  ; was: sub_83C1E
                                        ; Sound_SetModulationEnvelopeByChannel+6   j
                move.b  (a4)+,$A(a5)
                rts
; End of function Sound_SetModulationEnvelope
; Selects a PSG instrument (F5)
Sound_SetPSGInstrument:                                 ; CODE XREF: Sound_CommandDispatcher+5E   j  ; was: sub_83C24
                move.b  (a4)+,$B(a5)
                rts
; End of function Sound_SetPSGInstrument
; Jumps relative offset in track data
Sound_JumpRelative:                                     ; CODE XREF: Sound_CommandDispatcher+62   j  ; was: sub_83C2A
                                        ; Sound_LoopCounter+14   j
                move.b  (a4)+,d0
                lsl.w   #8,d0
                move.b  (a4)+,d0
                adda.w  d0,a4
                subq.w  #1,a4
                rts
; End of function Sound_JumpRelative
; Loop counter with conditional jump
Sound_LoopCounter:                                      ; CODE XREF: Sound_CommandDispatcher+66   j  ; was: sub_83C36
                moveq   #0,d0
                move.b  (a4)+,d0
                move.b  (a4)+,d1
                tst.b   $28(a5,d0.w)
                bne.s   loc_83C46
                move.b  d1,$28(a5,d0.w)
loc_83C46:                                              ; CODE XREF: Sound_LoopCounter+A   j
                subq.b  #1,$28(a5,d0.w)
                bne.s   Sound_JumpRelative
                addq.w  #2,a4
                rts
; End of function Sound_LoopCounter
; Calls a relative sequence subroutine (F8)
Sound_CallSequenceSubroutine:                           ; CODE XREF: Sound_CommandDispatcher+6A   j  ; was: sub_83C50
                moveq   #0,d0
                move.b  $D(a5),d0
                subq.b  #4,d0
                move.l  a4,(a5,d0.w)
                move.b  d0,$D(a5)
                bra.s   Sound_JumpRelative
; End of function Sound_CallSequenceSubroutine
; Returns from a sequence subroutine (F9)
Sound_ReturnFromSequenceSubroutine:                     ; CODE XREF: Sound_CommandDispatcher+6E   j  ; was: sub_83C62
                moveq   #0,d0
                move.b  $D(a5),d0
                movea.l (a5,d0.w),a4
                addq.w  #2,a4
                addq.b  #4,d0
                move.b  d0,$D(a5)
                rts
; End of function Sound_ReturnFromSequenceSubroutine
; Sets the current channel tick multiplier (FA)
Sound_SetTickMultiplier:                                ; CODE XREF: Sound_CommandDispatcher+72   j  ; was: sub_83C76
                move.b  (a4)+,2(a5)
                rts
; End of function Sound_SetTickMultiplier
; Adds transpose value to sound channel pitch offset
Sound_AddTranspose:                                     ; CODE XREF: Sound_CommandDispatcher+76   j  ; was: sub_83C7C
                move.b  (a4)+,d0
                add.b   d0,8(a5)
                rts
; End of function Sound_AddTranspose
; Sets bit 7 of modulation control byte at offset $A to enable feature
Sound_EnableModulationFlag:                             ; CODE XREF: Sound_CommandDispatcher+7A   j  ; was: sub_83C84
                bset    #7,$A(a5)
                rts
; End of function Sound_EnableModulationFlag
; Clears bit 7 of modulation control byte at offset $A to disable feature
Sound_DisableModulationFlag:                            ; CODE XREF: Sound_CommandDispatcher+7E   j  ; was: sub_83C8C
                bclr    #7,$A(a5)
                rts
; End of function Sound_DisableModulationFlag
; Configures YM2612 CH3 special mode with frequency values for each operator
Sound_SetCH3SpecialMode:                                ; CODE XREF: Sound_CommandDispatcher+82   j  ; was: sub_83C94
                lea     (word_FFF818).w,a0
                tst.b   (byte_FFF80E).w
                bne.s   loc_83CA8
                lea     (word_FFF810).w,a0
                move.b  #$80,(byte_FFF80F).w
loc_83CA8:                                              ; CODE XREF: Sound_SetCH3SpecialMode+8   j
                moveq   #3,d0
loc_83CAA:                                              ; CODE XREF: Sound_SetCH3SpecialMode+20   j
                moveq   #0,d1
                move.b  (a4)+,d1
                lsl.w   #1,d1
                move.w  word_83CC2(pc,d1.w),(a0)+
                dbf     d0,loc_83CAA
                move.b  #$27,d0                         ; '''
                moveq   #$40,d1                         ; '@'
                bra.w   Sound_WriteYM2612Wrapper
; End of function Sound_SetCH3SpecialMode
; ---------------------------------------------------------------------------
word_83CC2:     dc.w    0, $180, $1F4, $260
                                        ; DATA XREF: Sound_SetCH3SpecialMode+1C   r

; Configures SSG-EG and forces full attack for all four FM operators (FF 00)
Sound_SetSSGEG:                                         ; CODE XREF: Sound_ExtendedCommandDispatch:loc_838B0   j  ; was: sub_83CCA
                lea     byte_83CE6(pc),a1
                moveq   #3,d3
loc_83CD0:                                              ; CODE XREF: Sound_SetSSGEG+16   j
                move.b  (a1)+,d0
                move.b  (a4)+,d1
                jsr     Sound_CheckPauseFlag(pc)        ; (pc)
                move.b  (a1)+,d0
                moveq   #$1F,d1
                jsr     Sound_CheckPauseFlag(pc)        ; (pc)
                dbf     d3,loc_83CD0
                rts
; End of function Sound_SetSSGEG
; ---------------------------------------------------------------------------
byte_83CE6:     dc.b    $90, $50, $98, $58, $94, $54, $9C, $5C
                                        ; DATA XREF: Sound_SetSSGEG   o

; Pauses or resumes all music channels (FF 01)
