Sound_SetFMFrequency:                                   ; CODE XREF: Sound_UpdateDriver+52   p  ; was: sub_84A70
                                        ; Sound_UpdateDriver+7C   p
                subq.b  #1,$E(a5)
                bne.s   Sound_PSGChannelIdle
                bclr    #4,(a5)
                jsr     Sound_ParseSequenceData(pc)     ; (pc)
                jsr     Sound_UpdatePSGFrequency(pc)    ; (pc)
                bra.w   loc_84B4E
; ---------------------------------------------------------------------------
; PSG channel idle processing
Sound_PSGChannelIdle:                                   ; CODE XREF: Sound_SetFMFrequency+4   j  ; was: loc_84A86
                jsr     Sound_HandleNoteTimer(pc)       ; (pc)
                jsr     Sound_ProcessFMModulation(pc)   ; (pc)
                jsr     Sound_ProcessVibrato(pc)        ; (pc)
                bra.w   loc_84B06
; End of function Sound_SetFMFrequency
; Parses sound sequence data processing note and command bytes
Sound_ParseSequenceData:                                ; CODE XREF: Sound_SetFMFrequency+A   p  ; was: sub_84A96
                                        ; DATA XREF: Sound_SetFMFrequency+A   o
                bclr    #1,(a5)
                movea.l 4(a5),a4
loc_84A9E:                                              ; CODE XREF: Sound_ParseSequenceData+16   j
                moveq   #0,d5
                move.b  (a4)+,d5
                cmpi.b  #$E0,d5
                bcs.s   loc_84AAE
                jsr     Sound_CommandDispatcher(pc)     ; (pc)
                bra.s   loc_84A9E
; ---------------------------------------------------------------------------
loc_84AAE:                                              ; CODE XREF: Sound_ParseSequenceData+10   j
                tst.b   d5
                bpl.s   Sound_ParseSequenceNote
                jsr     Sound_ProcessNoteData(pc)       ; (pc)
                move.b  (a4)+,d5
                tst.b   d5
                bpl.s   Sound_ParseSequenceNote
                subq.w  #1,a4
                bra.w   Sound_SaveChannelState
; ---------------------------------------------------------------------------
; Parses sequence note with duration
Sound_ParseSequenceNote:                                ; CODE XREF: Sound_ParseSequenceData+1A   j  ; was: loc_84AC2
                                        ; Sound_ParseSequenceData+24   j
                jsr     Sound_CalculateDuration(pc)     ; (pc)
                bra.w   Sound_SaveChannelState
; End of function Sound_ParseSequenceData
; Processes note data calculating pitch and duration
Sound_ProcessNoteData:                                  ; CODE XREF: Sound_ParseSequenceData+1C   p  ; was: sub_84ACA
                                        ; DATA XREF: Sound_ParseSequenceData+1C   o
                subi.b  #$81,d5
                bcs.s   loc_84AE8
                add.b   8(a5),d5
                andi.w  #$7F,d5
                lsl.w   #1,d5
                lea     word_84C18(pc),a0
                move.w  (a0,d5.w),$10(a5)
                bra.w   Sound_SaveChannelState
; ---------------------------------------------------------------------------
loc_84AE8:                                              ; CODE XREF: Sound_ProcessNoteData+4   j
                bset    #1,(a5)
                move.w  #$FFFF,$10(a5)
                jsr     Sound_SaveChannelState(pc)      ; (pc)
                bra.w   Sound_CheckPSGMute
; End of function Sound_ProcessNoteData
; Updates PSG channel frequency with pitch calculation
Sound_UpdatePSGFrequency:                               ; CODE XREF: Sound_SetFMFrequency+E   p  ; was: sub_84AFA
                                        ; DATA XREF: Sound_SetFMFrequency+E   o
                move.w  $10(a5),d6
                bpl.s   loc_84B0C
                bset    #1,(a5)
                rts
; ---------------------------------------------------------------------------
loc_84B06:                                              ; CODE XREF: Sound_SetFMFrequency+22   j
                tst.b   $A(a5)
                beq.s   locret_84B44
loc_84B0C:                                              ; CODE XREF: Sound_UpdatePSGFrequency+4   j
                btst    #1,(a5)
                bne.s   locret_84B44
                btst    #2,(a5)
                bne.s   locret_84B44
                jsr     Sound_ApplyPitchEffects(pc)     ; (pc)
                move.b  1(a5),d0
                cmpi.b  #$E0,d0
                bne.s   Sound_WritePSGFrequency
                move.b  #$C0,d0
; Writes frequency to PSG chip
Sound_WritePSGFrequency:                                ; CODE XREF: Sound_UpdatePSGFrequency+2A   j  ; was: loc_84B2A
                move.w  d6,d1
                andi.b  #$F,d1
                or.b    d1,d0
                lsr.w   #4,d6
                andi.b  #$3F,d6                         ; '?'
                move.b  d0,(VDP_PSG).l
                move.b  d6,(VDP_PSG).l
locret_84B44:                                           ; CODE XREF: Sound_UpdatePSGFrequency+10   j
                                        ; Sound_UpdatePSGFrequency+16   j
                rts
; End of function Sound_UpdatePSGFrequency
; Processes FM channel frequency modulation from envelope table
Sound_ProcessFMModulation:                              ; CODE XREF: Sound_SetFMFrequency+1A   p  ; was: sub_84B46
                                        ; DATA XREF: Sound_SetFMFrequency+1A   o
                tst.b   $B(a5)
                beq.w   locret_84BB8
loc_84B4E:                                              ; CODE XREF: Sound_SetFMFrequency+12   j
                move.b  9(a5),d6
                moveq   #0,d0
                move.b  $B(a5),d0
                beq.s   Sound_ApplyPSGVolume
                lea     PSGVolumeEnvelopePointerTable(pc),a0
                subq.w  #1,d0
                lsl.w   #2,d0
                movea.l (a0,d0.w),a0
loc_84B66:                                              ; CODE XREF: Sound_ReloadModCounter+6   j
                                        ; Sound_ClearModCounter+4   j
                moveq   #0,d0
                move.b  $C(a5),d0
                addq.b  #1,$C(a5)
                move.b  (a0,d0.w),d0
                bpl.s   loc_84B8E
                cmpi.b  #$83,d0
                beq.s   Sound_ProcessPSGModulation
                cmpi.b  #$81,d0
                beq.s   Sound_DecrementModCounter
                cmpi.b  #$82,d0
                beq.s   Sound_ReloadModCounter
                cmpi.b  #$80,d0
                beq.s   Sound_ClearModCounter
loc_84B8E:                                              ; CODE XREF: Sound_ProcessFMModulation+2E   j
                add.w   d0,d6
                cmpi.b  #$10,d6
                bcs.s   Sound_ApplyPSGVolume
                moveq   #$F,d6
; End of function Sound_ProcessFMModulation
; Applies volume to PSG channel with mute check
Sound_ApplyPSGVolume:                                   ; CODE XREF: Sound_InitializeChannels+60   p  ; was: sub_84B98
                                        ; Sound_ProcessVolumeFade+114   p
                btst    #1,(a5)
                bne.s   locret_84BB8
                btst    #2,(a5)
                bne.s   locret_84BB8
                btst    #4,(a5)
                bne.s   loc_84BBA
loc_84BAA:                                              ; CODE XREF: Sound_ApplyPSGVolume+26   j
                                        ; Sound_ApplyPSGVolume+2C   j
                or.b    1(a5),d6
                addi.b  #$10,d6
                move.b  d6,(VDP_PSG).l
locret_84BB8:                                           ; CODE XREF: Sound_ProcessFMModulation+4   j
                                        ; Sound_ApplyPSGVolume+4   j
                rts
; ---------------------------------------------------------------------------
loc_84BBA:                                              ; CODE XREF: Sound_ApplyPSGVolume+10   j
                tst.b   $13(a5)
                beq.s   loc_84BAA
                tst.b   $12(a5)
                bne.s   loc_84BAA
                rts
; End of function Sound_ApplyPSGVolume
; PSG modulation processing
Sound_ProcessPSGModulation:                             ; CODE XREF: Sound_ProcessFMModulation+34   j  ; was: sub_84BC8
                subq.b  #2,$C(a5)
                bset    #1,(a5)
                bra.w   Sound_CheckPSGMute
; End of function Sound_ProcessPSGModulation
; Decrements modulation counter at offset $C by 2 for modulation timing
Sound_DecrementModCounter:                              ; CODE XREF: Sound_ProcessFMModulation+3A   j  ; was: sub_84BD4
                subq.b  #2,$C(a5)
                rts
; End of function Sound_DecrementModCounter
; Reloads modulation counter from table and branches to modulation handler
Sound_ReloadModCounter:                                 ; CODE XREF: Sound_ProcessFMModulation+40   j  ; was: sub_84BDA
                move.b  1(a0,d0.w),$C(a5)
                bra.s   loc_84B66
; End of function Sound_ReloadModCounter
; Clears modulation counter at offset $C and branches to modulation handler
Sound_ClearModCounter:                                  ; CODE XREF: Sound_ProcessFMModulation+46   j  ; was: sub_84BE2
                clr.b   $C(a5)
                bra.w   loc_84B66
; End of function Sound_ClearModCounter
; Checks if PSG channel is muted before output
Sound_CheckPSGMute:                                     ; CODE XREF: Sound_HandleNoteTimer:loc_8266C   p  ; was: sub_84BEA
                                        ; sub_8278C:loc_8279A   j
                btst    #2,(a5)
                bne.s   locret_84BFE
; End of function Sound_CheckPSGMute
; Mutes PSG channel by setting maximum attenuation
Sound_MutePSGChannel:                                   ; CODE XREF: Sound_ProcessSpecialChannels+44   p  ; was: sub_84BF0
                move.b  1(a5),d0
                ori.b   #$1F,d0
                move.b  d0,(VDP_PSG).l
locret_84BFE:                                           ; CODE XREF: Sound_CheckPSGMute+4   j
                rts
; End of function Sound_MutePSGChannel
; Mutes all four PSG channels by writing $9F,$BF,$DF,$FF to PSG port
Sound_MuteAllPSGChannels:                               ; CODE XREF: Sound_HandleZ80BusRequest+74   j  ; was: sub_84C00
                                        ; Sound_UpdateFMEnvelope+20   j
                lea     (VDP_PSG).l,a0
                move.b  #$9F,(a0)
                move.b  #$BF,(a0)
                move.b  #$DF,(a0)
                move.b  #$FF,(a0)
                rts
; End of function Sound_MuteAllPSGChannels
; ---------------------------------------------------------------------------
