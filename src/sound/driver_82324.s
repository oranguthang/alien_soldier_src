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
                clr.b   (byte_FFF80E).w
                tst.b   (byte_FFF807).w
                bne.w   Sound_HandleZ80BusRequest
                jsr     Sound_ProcessVolumeFade(pc)     ; (pc)
                jsr     Sound_ProcessTempoTick(pc)      ; (pc)
                jsr     Sound_InitializeChannels(pc)    ; (pc)
                tst.l   (dword_FFF80A).w
                beq.s   loc_8234E
                jsr     Sound_ProcessFade(pc)           ; (pc)
loc_8234E:                                              ; CODE XREF: Sound_UpdateDriver+1C   j
                jsr     Sound_UpdateEnvelope(pc)        ; (pc)
                lea     (byte_FFF840).w,a5
                tst.b   (a5)
                bpl.s   loc_8235E
                jsr     Sound_PlayPSGSequence(pc)       ; (pc)
loc_8235E:                                              ; CODE XREF: Sound_UpdateDriver+2C   j
                clr.b   (byte_FFF808).w
                moveq   #5,d7
loc_82364:                                              ; CODE XREF: Sound_UpdateDriver:loc_82370   j
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   loc_82370
                jsr     Sound_ProcessChannel(pc)        ; (pc)
loc_82370:                                              ; CODE XREF: Sound_UpdateDriver+3E   j
                dbf     d7,loc_82364
                moveq   #2,d7
loc_82376:                                              ; CODE XREF: Sound_UpdateDriver:loc_82382   j
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   loc_82382
                jsr     Sound_SetFMFrequency(pc)        ; (pc)
loc_82382:                                              ; CODE XREF: Sound_UpdateDriver+50   j
                dbf     d7,loc_82376
                move.b  #$80,(byte_FFF80E).w
                moveq   #2,d7
loc_8238E:                                              ; CODE XREF: Sound_UpdateDriver:loc_8239A   j
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   loc_8239A
                jsr     Sound_ProcessChannel(pc)        ; (pc)
loc_8239A:                                              ; CODE XREF: Sound_UpdateDriver+68   j
                dbf     d7,loc_8238E
                moveq   #2,d7
loc_823A0:                                              ; CODE XREF: Sound_UpdateDriver:loc_823AC   j
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   loc_823AC
                jsr     Sound_SetFMFrequency(pc)        ; (pc)
loc_823AC:                                              ; CODE XREF: Sound_UpdateDriver+7A   j
                dbf     d7,loc_823A0
                move.b  #$40,(byte_FFF80E).w            ; '@'
                moveq   #1,d7
loc_823B8:                                              ; CODE XREF: Sound_UpdateDriver:loc_823D0   j
                adda.w  #$30,a5                         ; '0'
                tst.b   (a5)
                bpl.s   Sound_UpdateDriverLoop
                tst.b   1(a5)
                bmi.s   loc_823CC
                jsr     Sound_ProcessChannel(pc)        ; (pc)
                bra.s   Sound_UpdateDriverLoop
; ---------------------------------------------------------------------------
loc_823CC:                                              ; CODE XREF: Sound_UpdateDriver+98   j
                jsr     Sound_SetFMFrequency(pc)        ; (pc)
; Main driver update loop iteration
Sound_UpdateDriverLoop:                                 ; CODE XREF: Sound_UpdateDriver+92   j  ; was: loc_823D0
                                        ; Sound_UpdateDriver+9E   j
                dbf     d7,loc_823B8
                rts
; End of function Sound_UpdateDriver
; Plays PSG sequence with Z80 bus arbitration and priority checking
Sound_PlayPSGSequence:                                  ; CODE XREF: Sound_UpdateDriver+2E   p  ; was: sub_823D6
                                        ; DATA XREF: Sound_UpdateDriver+2E   o
                subq.b  #1,$E(a5)
                bne.w   locret_824A0
                move.b  #$80,(byte_FFF808).w
                movea.l 4(a5),a4
loc_823E8:                                              ; CODE XREF: Sound_PlayPSGSequence+20   j
                moveq   #0,d5
                move.b  (a4)+,d5
                cmpi.b  #$E0,d5
                bcs.s   loc_823F8
                jsr     Sound_CommandDispatcher(pc)     ; (pc)
                bra.s   loc_823E8
; ---------------------------------------------------------------------------
loc_823F8:                                              ; CODE XREF: Sound_PlayPSGSequence+1A   j
                tst.b   d5
                bpl.s   loc_8240E
                move.b  d5,$10(a5)
                move.b  (a4)+,d5
                bpl.s   loc_8240E
                subq.w  #1,a4
                move.b  $F(a5),$E(a5)
                bra.s   loc_82412
; ---------------------------------------------------------------------------
loc_8240E:                                              ; CODE XREF: Sound_PlayPSGSequence+24   j
                                        ; Sound_PlayPSGSequence+2C   j
                jsr     Sound_CalculateDuration(pc)     ; (pc)
loc_82412:                                              ; CODE XREF: Sound_PlayPSGSequence+36   j
                move.l  a4,4(a5)
                moveq   #0,d0
                move.b  $10(a5),d0
                subi.b  #$81,d0
                bcs.s   locret_824A0
                ext.w   d0
                asl.w   #3,d0
                lea     word_824A2(pc,d0.w),a3
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82438:                                              ; CODE XREF: Sound_PlayPSGSequence+6A   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82438
                tst.b   (byte_A01FFD).l
                bmi.s   loc_82496
                move.b  (byte_A01FFC).l,d0
                andi.b  #$C0,d0
                move.b  5(a3),d1
                andi.b  #$C0,d1
                cmp.b   d0,d1
                bcs.w   loc_82496
                move.b  #1,(byte_A01FFD).l
                move.b  (a3)+,(byte_A01FE8).l
                move.b  (a3)+,(byte_A01FE9).l
                move.b  (a3)+,(byte_A01FE6).l
                move.b  (a3)+,(byte_A01FE7).l
                move.b  (a3)+,(byte_A01FFE).l
                move.b  (a3)+,(byte_A01FFB).l
                move.b  $27(a5),(byte_A01FF9).l
loc_82496:                                              ; CODE XREF: Sound_PlayPSGSequence+72   j
                                        ; Sound_PlayPSGSequence+88   j
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
locret_824A0:                                           ; CODE XREF: Sound_PlayPSGSequence+4   j
                                        ; Sound_PlayPSGSequence+4A   j
                rts
; End of function Sound_PlayPSGSequence
; ---------------------------------------------------------------------------
word_824A2:     dc.w    (PCMPart1 >> $8)                ; DATA XREF: Sound_PlayPSGSequence+50   o
                dc.w    $80, $500, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $480, $200, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $880, $100, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $C80, $700, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1080, $700, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1480, $100, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1880, $D00, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1C80, $100, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1080, $300, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1080, $900, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $1080, $F00, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2080, $A00, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $1700, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $800, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $1000, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $D00, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $600, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2880, $100, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2C80, $100, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $3080, $500, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $800, 0
                dc.w    (PCMPart1 >> $8)
                dc.w    $2480, $E00, 0

; Processes individual sound channel state
Sound_ProcessChannel:                                   ; CODE XREF: Sound_UpdateDriver+40   p  ; was: sub_82552
                                        ; Sound_UpdateDriver+6A   p
                subq.b  #1,$E(a5)
                bne.s   Sound_ProcessChannelIdle
                bclr    #4,(a5)
                jsr     Sound_ParseTrackData(pc)        ; (pc)
                jsr     Sound_UpdateChannelFrequency(pc)  ; (pc)
                jsr     Sound_ProcessChannelCommand(pc)  ; (pc)
                bra.w   Sound_SendKeyOff
; ---------------------------------------------------------------------------
; Processes channel when idle
Sound_ProcessChannelIdle:                               ; CODE XREF: Sound_ProcessChannel+4   j  ; was: loc_8256C
                jsr     Sound_HandleNoteTimer(pc)       ; (pc)
                jsr     Sound_ProcessModulation(pc)     ; (pc)
                jsr     Sound_ProcessVibrato(pc)        ; (pc)
                bra.w   loc_826D0
; End of function Sound_ProcessChannel
; Parses and interprets sound track data
Sound_ParseTrackData:                                   ; CODE XREF: Sound_ProcessChannel+A   p  ; was: sub_8257C
                                        ; DATA XREF: Sound_ProcessChannel+A   o
                movea.l 4(a5),a4
                bclr    #1,(a5)
loc_82584:                                              ; CODE XREF: Sound_ParseTrackData+16   j
                moveq   #0,d5
                move.b  (a4)+,d5
                cmpi.b  #$E0,d5
                bcs.s   loc_82594
                jsr     Sound_CommandDispatcher(pc)     ; (pc)
                bra.s   loc_82584
; ---------------------------------------------------------------------------
loc_82594:                                              ; CODE XREF: Sound_ParseTrackData+10   j
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
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
                beq.s   Sound_ClearChannelState
                add.b   8(a5),d5
                andi.l  #$7F,d5
                divu.w  #$C,d5
                swap    d5
                lsl.w   #1,d5
                lea     word_83808(pc),a0
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
Sound_CalculateDuration:                                ; CODE XREF: Sound_PlayPSGSequence:loc_8240E   p  ; was: sub_825E4
                                        ; sub_8257C:loc_825AA   p
                move.b  d5,d0
                move.b  2(a5),d1
loc_825EA:                                              ; CODE XREF: Sound_CalculateDuration+C   j
                subq.b  #1,d1
                beq.s   loc_825F2
                add.b   d5,d0
                bra.s   loc_825EA
; ---------------------------------------------------------------------------
loc_825F2:                                              ; CODE XREF: Sound_CalculateDuration+8   j
                move.b  d0,$F(a5)
                move.b  d0,$E(a5)
                rts
; End of function Sound_CalculateDuration
; Clears sound channel state by setting flags and clearing registers
Sound_ClearChannelState:                                ; CODE XREF: Sound_CalculatePitch+4   j  ; was: sub_825FC
                bset    #1,(a5)
                clr.w   $10(a5)
; End of function Sound_ClearChannelState
; Saves channel state and envelope data
Sound_SaveChannelState:                                 ; CODE XREF: Sound_ParseTrackData+2A   j  ; was: sub_82604
                                        ; Sound_ParseTrackData+32   j
                move.l  a4,4(a5)
                move.b  $F(a5),$E(a5)
                btst    #4,(a5)
                bne.s   locret_8264A
                move.b  $13(a5),$12(a5)
                clr.b   $C(a5)
                clr.b   $26(a5)
                clr.b   3(a5)
                btst    #7,$A(a5)
                beq.s   locret_8264A
                movea.l $14(a5),a0
                move.b  (a0)+,$18(a5)
                move.b  (a0)+,$19(a5)
                move.b  (a0)+,$1A(a5)
                move.b  (a0)+,d0
                lsr.b   #1,d0
                move.b  d0,$1B(a5)
                clr.w   $1C(a5)
locret_8264A:                                           ; CODE XREF: Sound_SaveChannelState+E   j
                                        ; Sound_SaveChannelState+28   j
                rts
; End of function Sound_SaveChannelState
; Handles sound channel note timer countdown and restarts playback
Sound_HandleNoteTimer:                                  ; CODE XREF: Sound_ProcessChannel:loc_8256C   p  ; was: sub_8264C
                                        ; sub_84A70:loc_84A86   p
                                        ; DATA XREF:
                tst.b   $12(a5)
                beq.s   locret_82672
                subq.b  #1,$12(a5)
                bne.s   locret_82672
                bset    #1,(a5)
                tst.b   1(a5)
                bmi.w   loc_8266C
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
                addq.w  #4,sp
                rts
; ---------------------------------------------------------------------------
loc_8266C:                                              ; CODE XREF: Sound_HandleNoteTimer+14   j
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
                addq.w  #4,sp
locret_82672:                                           ; CODE XREF: Sound_HandleNoteTimer+4   j
                                        ; Sound_HandleNoteTimer+A   j
                rts
; End of function Sound_HandleNoteTimer
; Processes sound vibrato effect modulating pitch with oscillation
Sound_ProcessVibrato:                                   ; CODE XREF: Sound_ProcessChannel+22   p  ; was: sub_82674
                                        ; Sound_SetFMFrequency+1E   p
                                        ; DATA XREF:
                btst    #7,$A(a5)
                beq.s   locret_826C2
                tst.b   $18(a5)
                beq.s   loc_82688
                subq.b  #1,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_82688:                                              ; CODE XREF: Sound_ProcessVibrato+C   j
                subq.b  #1,$19(a5)
                beq.s   loc_82690
                rts
; ---------------------------------------------------------------------------
loc_82690:                                              ; CODE XREF: Sound_ProcessVibrato+18   j
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
locret_826C2:                                           ; CODE XREF: Sound_ProcessVibrato+6   j
                rts
; End of function Sound_ProcessVibrato
; Updates FM channel frequency registers with calculated pitch
Sound_UpdateChannelFrequency:                           ; CODE XREF: Sound_ProcessChannel+E   p  ; was: sub_826C4
                                        ; DATA XREF: Sound_ProcessChannel+E   o
                move.w  $10(a5),d6
                bne.s   loc_826D8
                bset    #1,(a5)
                rts
; ---------------------------------------------------------------------------
loc_826D0:                                              ; CODE XREF: Sound_ProcessChannel+26   j
                tst.b   $A(a5)
                beq.w   locret_82712
loc_826D8:                                              ; CODE XREF: Sound_UpdateChannelFrequency+4   j
                btst    #1,(a5)
                bne.w   locret_82712
                btst    #2,(a5)
                bne.w   locret_82712
                jsr     Sound_ApplyPitchEffects(pc)     ; (pc)
                tst.b   (byte_FFF80F).w
                beq.s   Sound_WriteFrequencyBytes
                cmpi.b  #2,1(a5)
                beq.w   Sound_UpdateFMOperators
; Writes frequency bytes to YM2612
Sound_WriteFrequencyBytes:                              ; CODE XREF: Sound_UpdateChannelFrequency+2C   j  ; was: loc_826FC
                move.w  d6,d1
                lsr.w   #8,d1
                move.b  #$A4,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                move.b  d6,d1
                move.b  #$A0,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
locret_82712:                                           ; CODE XREF: Sound_UpdateChannelFrequency+10   j
                                        ; Sound_UpdateChannelFrequency+18   j
                rts
; End of function Sound_UpdateChannelFrequency
; Applies pitch effects including detune transpose and modulation to frequency
Sound_ApplyPitchEffects:                                ; CODE XREF: Sound_UpdateChannelFrequency+24   p  ; was: sub_82714
                                        ; Sound_UpdatePSGFrequency+1E   p
                                        ; DATA XREF:
                moveq   #0,d6
                move.b  $A(a5),d0
                andi.w  #$7F,d0
                beq.s   loc_82764
                lea     ModulationEnvelopePointerTable(pc),a0
                subq.w  #1,d0
                lsl.w   #2,d0
                movea.l (a0,d0.w),a0
loc_8272C:                                              ; CODE XREF: Sound_ClearPitchFlag+4   j
                                        ; Sound_DecrementPitchCounter+4   j
                moveq   #0,d0
                move.b  $26(a5),d0
                addq.b  #1,$26(a5)
                move.b  (a0,d0.w),d6
                bpl.s   loc_8275A
                cmpi.b  #$80,d6
                beq.s   Sound_ClearPitchFlag
                cmpi.b  #$81,d6
                beq.s   Sound_DecrementPitchCounter
                cmpi.b  #$83,d6
                beq.s   Sound_SetRestFlag
                cmpi.b  #$82,d6
                beq.s   Sound_LoadPitchValue
                cmpi.b  #$84,d6
                beq.s   Sound_AddTransposeAlt
loc_8275A:                                              ; CODE XREF: Sound_ApplyPitchEffects+26   j
                ext.w   d6
                move.b  3(a5),d0
                ext.w   d0
                mulu.w  d0,d6
loc_82764:                                              ; CODE XREF: Sound_ApplyPitchEffects+A   j
                move.b  $1E(a5),d0
                ext.w   d0
                add.w   d0,d6
                add.w   $10(a5),d6
                tst.b   $A(a5)
                bpl.s   locret_8277A
                add.w   $1C(a5),d6
locret_8277A:                                           ; CODE XREF: Sound_ApplyPitchEffects+60   j
                rts
; End of function Sound_ApplyPitchEffects
; Adjusts stack pointer to skip return address in pitch effect processing
Sound_SkipPitchReturn:
                addq.w  #4,sp                           ; was: sub_8277C
                rts
; End of function Sound_SkipPitchReturn
; Clears pitch effect flag and continues sound processing
Sound_ClearPitchFlag:                                   ; CODE XREF: Sound_ApplyPitchEffects+2C   j  ; was: sub_82780
                clr.b   $26(a5)
                bra.s   loc_8272C
; End of function Sound_ClearPitchFlag
; Decrements pitch counter by 2 and continues processing
Sound_DecrementPitchCounter:                            ; CODE XREF: Sound_ApplyPitchEffects+32   j  ; was: sub_82786
                subq.b  #2,$26(a5)
                bra.s   loc_8272C
; End of function Sound_DecrementPitchCounter
; Sets rest flag and branches to appropriate channel check
Sound_SetRestFlag:                                      ; CODE XREF: Sound_ApplyPitchEffects+38   j  ; was: sub_8278C
                bset    #1,(a5)
                tst.b   1(a5)
                bmi.s   loc_8279A
                bra.w   Sound_CheckChannelFlags
; ---------------------------------------------------------------------------
loc_8279A:                                              ; CODE XREF: Sound_SetRestFlag+8   j
                bra.w   Sound_CheckPSGMute
; End of function Sound_SetRestFlag
; Loads pitch effect value from track data into channel structure
Sound_LoadPitchValue:                                   ; CODE XREF: Sound_ApplyPitchEffects+3E   j  ; was: sub_8279E
                move.b  1(a0,d0.w),$26(a5)
                bra.s   loc_8272C
; End of function Sound_LoadPitchValue
; Adds transpose value from track data to channel transpose parameter
Sound_AddTransposeAlt:                                  ; CODE XREF: Sound_ApplyPitchEffects+44   j  ; was: sub_827A6
                move.b  1(a0,d0.w),d0
                add.b   d0,3(a5)
                addq.b  #1,$26(a5)
                bra.w   loc_8272C
; End of function Sound_AddTransposeAlt
; Updates YM2612 frequency registers for all 4 FM operators per channel
Sound_UpdateFMOperators:                                ; CODE XREF: Sound_UpdateChannelFrequency+34   j  ; was: sub_827B6
                lea     byte_827E8(pc),a1
                lea     (word_FFF810).w,a2
                tst.b   (byte_FFF80E).w
                beq.s   loc_827C8
                lea     (word_FFF818).w,a2
loc_827C8:                                              ; CODE XREF: Sound_UpdateFMOperators+C   j
                moveq   #3,d5
loc_827CA:                                              ; CODE XREF: Sound_UpdateFMOperators+2C   j
                move.w  d6,d1
                move.w  (a2)+,d0
                add.w   d0,d1
                move.w  d1,d3
                lsr.w   #8,d1
                move.b  (a1)+,d0
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                move.b  d3,d1
                move.b  (a1)+,d0
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                dbf     d5,loc_827CA
                rts
; End of function Sound_UpdateFMOperators
; ---------------------------------------------------------------------------
byte_827E8:     dc.b    $AD, $A9, $AC, $A8, $AE, $AA, $A6, $A2
                                        ; DATA XREF: Sound_UpdateFMOperators   o

; Processes sound channel command
Sound_ProcessChannelCommand:                            ; CODE XREF: Sound_ProcessChannel+12   p  ; was: sub_827F0
                                        ; DATA XREF: Sound_ProcessChannel+12   o
                btst    #1,(a5)
                bne.s   JumpTable1
                moveq   #0,d0
                move.b  $1F(a5),d0
                lsl.w   #1,d0
                jmp     JumpTable1(pc,d0.w)
; End of function Sound_ProcessChannelCommand
JumpTable1:                                             ; CODE XREF: Sound_ProcessChannelCommand+4   j
                                        ; Sound_ProcessChannelCommand+E   j
                                        ; DATA XREF:
                rts
; ---------------------------------------------------------------------------
                bra.s   loc_8282E
; ---------------------------------------------------------------------------
                bra.s   Sound_ProcessTremolo
; ---------------------------------------------------------------------------
                bra.s   Sound_ProcessTremolo
; End of function JumpTable1

; Processes sound modulation effects using jump table dispatcher
Sound_ProcessModulation:                                ; CODE XREF: Sound_ProcessChannel+1E   p  ; was: sub_8280A
                                        ; DATA XREF: Sound_ProcessChannel+1E   o
                btst    #1,(a5)
                bne.s   JumpTable2
                moveq   #0,d0
                move.b  $1F(a5),d0
                lsl.w   #1,d0
                jmp     JumpTable2(pc,d0.w)
; ---------------------------------------------------------------------------
JumpTable2:                                             ; CODE XREF: Sound_ProcessModulation+4   j
                                        ; Sound_ProcessModulation+E   j
                                        ; DATA XREF:
                rts
; ---------------------------------------------------------------------------
                rts
; ---------------------------------------------------------------------------
                bra.s   loc_8282E
; ---------------------------------------------------------------------------
                bra.s   loc_8282E
; End of function Sound_ProcessModulation
; Processes sound tremolo effect with volume oscillation
Sound_ProcessTremolo:                                   ; CODE XREF: JumpTable1+4   j  ; was: sub_82824
                                        ; JumpTable1+6   j
                move.b  $23(a5),$24(a5)
                clr.b   $21(a5)
loc_8282E:                                              ; CODE XREF: JumpTable1+2   j
                                        ; Sound_ProcessModulation+16   j
                move.b  $24(a5),d0
                cmp.b   $23(a5),d0
                bne.s   Sound_ProcessTremoloEnvelope
                move.b  $22(a5),d3
                cmp.b   $21(a5),d3
                bpl.s   loc_8284E
                cmpi.b  #2,$1F(a5)
                beq.s   locret_82882
                clr.b   $21(a5)
loc_8284E:                                              ; CODE XREF: Sound_ProcessTremolo+1C   j
                clr.b   $24(a5)
                addq.b  #1,$21(a5)
; Processes tremolo envelope lookup
Sound_ProcessTremoloEnvelope:                           ; CODE XREF: Sound_ProcessTremolo+12   j  ; was: loc_82856
                moveq   #0,d0
                move.b  $20(a5),d0
                subq.w  #1,d0
                lsl.w   #2,d0
                movea.l PanAnimationPointerTable(pc,d0.w),a0
                moveq   #0,d0
                move.b  $21(a5),d0
                subq.w  #1,d0
                move.b  (a0,d0.w),d1
                move.b  $27(a5),d0
                andi.b  #$37,d0                         ; '7'
                or.b    d0,d1
                jsr     Sound_SendPSGVolumeUpdate(pc)   ; (pc)
                addq.b  #1,$24(a5)
locret_82882:                                           ; CODE XREF: Sound_ProcessTremolo+24   j
                rts
; End of function Sound_ProcessTremolo
; ---------------------------------------------------------------------------
PanAnimationPointerTable:   dc.l    PanAnimation_1      ; DATA XREF: Sound_ProcessTremolo+3C   r
                dc.l    PanAnimation_2
                dc.l    PanAnimation_3
PanAnimation_1: dc.b    $40, $80                        ; DATA XREF: ROM:PanAnimationPointerTable   o
PanAnimation_2: dc.b    $40, $C0, $80                   ; DATA XREF: ROM:00082888   o
PanAnimation_3: dc.b    $C0, $80, $C0, $40, 0
                                        ; DATA XREF: ROM:0008288C   o

; Sends PSG volume update via Z80 bus with arbitration
Sound_SendPSGVolumeUpdate:                              ; CODE XREF: Sound_ProcessTremolo+56   p  ; was: sub_8289A
                                        ; Sound_SetPanAndAMS+16   j
                btst    #2,(a5)
                bne.s   locret_828F4
                cmpi.b  #6,1(a5)
                bne.w   loc_828EC
                cmpa.l  #$40,a5                         ; '@'
                beq.w   locret_828F4
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_828C2:                                              ; CODE XREF: Sound_SendPSGVolumeUpdate+30   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_828C2
                move.b  (byte_A01FFD).l,d0
                beq.w   loc_828DE
                move.b  $27(a5),(byte_A01FF8).l
loc_828DE:                                              ; CODE XREF: Sound_SendPSGVolumeUpdate+38   j
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.s   locret_828F4
loc_828EC:                                              ; CODE XREF: Sound_SendPSGVolumeUpdate+C   j
                move.b  #$B4,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
locret_828F4:                                           ; CODE XREF: Sound_SendPSGVolumeUpdate+4   j
                                        ; Sound_SendPSGVolumeUpdate+16   j
                rts
; End of function Sound_SendPSGVolumeUpdate
; Manages Z80 bus arbitration and sound RAM backup/restore during conflicts
Sound_HandleZ80BusRequest:                              ; CODE XREF: Sound_UpdateDriver+8   j  ; was: sub_828F6
                cmpi.b  #$FF,(byte_FFF807).w
                bne.w   loc_82902
                rts
; ---------------------------------------------------------------------------
loc_82902:                                              ; CODE XREF: Sound_HandleZ80BusRequest+6   j
                tst.b   (byte_FFF807).w
                bmi.s   loc_8296E
                move.b  #$FF,(byte_FFF807).w
                move    sr,-(sp)
                ori     #$700,sr
loc_82914:                                              ; CODE XREF: Sound_HandleZ80BusRequest+44   j
                move.w  #$100,(IO_Z80BUS).l
loc_8291C:                                              ; CODE XREF: Sound_HandleZ80BusRequest+2E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_8291C
                tst.b   (byte_A01F2A).l
                beq.s   loc_8293C
                move.w  #0,(IO_Z80BUS).l
                bsr.w   Sound_DelayNOP
                bra.s   loc_82914
; ---------------------------------------------------------------------------
loc_8293C:                                              ; CODE XREF: Sound_HandleZ80BusRequest+36   j
                move    (sp)+,sr
                lea     (dword_FFFBE0).w,a1
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                move.l  (a1)+,-(sp)
                jsr     Sound_SetMaxVolume(pc)          ; (pc)
                lea     (dword_FFFC00).w,a1
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
loc_8296E:                                              ; CODE XREF: Sound_HandleZ80BusRequest+10   j
                clr.b   (byte_FFF807).w
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                lea     (byte_FFFBA0).w,a1
                moveq   #2,d2
loc_82988:                                              ; CODE XREF: Sound_HandleZ80BusRequest+AE   j
                moveq   #$40,d0                         ; '@'
                add.w   d2,d0
                moveq   #3,d3
loc_8298E:                                              ; CODE XREF: Sound_HandleZ80BusRequest+AA   j
                move.b  (a1,d0.w),d1
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                move.b  $10(a1,d0.w),d1
                jsr     Sound_WriteYM2612Register(pc)   ; (pc)
                addq.w  #4,d0
                dbf     d3,loc_8298E
                dbf     d2,loc_82988
                rts
; End of function Sound_HandleZ80BusRequest
; Processes sound fade and volume changes
Sound_ProcessFade:                                      ; CODE XREF: Sound_UpdateDriver+1E   p  ; was: sub_829AA
                                        ; DATA XREF: Sound_UpdateDriver+1E   o
                lea     SoundPriorityTable(pc),a0
                lea     (byte_FFF80E).w,a1
                move.b  (byte_FFF800).w,d3
                moveq   #3,d4
loc_829B8:                                              ; CODE XREF: Sound_ProcessFade:loc_829E8   j
                move.b  -(a1),d0
                move.b  d0,d1
                clr.b   (a1)
                subq.b  #1,d0
                bcs.s   loc_829E8
                andi.w  #$FF,d0
                move.b  (a0,d0.w),d2
                cmpi.b  #$FF,d2
                beq.w   loc_829F6
                move.b  d2,d5
                andi.b  #$7F,d5
                move.b  d3,d6
                andi.b  #$7F,d6
                cmp.b   d6,d5
                bcs.s   loc_829E8
                move.b  d2,d3
                move.b  d1,(byte_FFF809).w
loc_829E8:                                              ; CODE XREF: Sound_ProcessFade+16   j
                                        ; Sound_ProcessFade+36   j
                dbf     d4,loc_829B8
                tst.b   d3
                bmi.s   locret_829F4
                move.b  d3,(byte_FFF800).w
locret_829F4:                                           ; CODE XREF: Sound_ProcessFade+44   j
                rts
; ---------------------------------------------------------------------------
loc_829F6:                                              ; CODE XREF: Sound_ProcessFade+24   j
                move.b  d1,(byte_FFF809).w
                bra.s   loc_82A14
; ---------------------------------------------------------------------------
loc_829FC:                                              ; CODE XREF: Sound_ProcessFade:loc_82A14   j
                move.b  -(a1),d0
                subq.b  #1,d0
                bcs.s   loc_82A12
                andi.w  #$FF,d0
                move.b  (a0,d0.w),d2
                cmpi.b  #$FF,d2
                beq.w   loc_82A14
loc_82A12:                                              ; CODE XREF: Sound_ProcessFade+56   j
                clr.b   (a1)
loc_82A14:                                              ; CODE XREF: Sound_ProcessFade+50   j
                                        ; Sound_ProcessFade+64   j
                dbf     d4,loc_829FC
                rts
; End of function Sound_ProcessFade
; Updates sound envelope parameters
Sound_UpdateEnvelope:                                   ; CODE XREF: Sound_UpdateDriver:loc_8234E   p  ; was: sub_82A1A
                                        ; DATA XREF: Sound_UpdateDriver:loc_8234E   o
                moveq   #0,d7
                move.b  (byte_FFF809).w,d7
                move.b  #$FF,(byte_FFF809).w
                tst.b   d7
                beq.w   Sound_LoadZ80Driver
                cmpi.b  #$FF,d7
                beq.s   locret_82A6A
                cmpi.b  #1,d7
                bcs.w   Sound_UpdateFMEnvelope
                cmpi.b  #$10,d7
                bcs.w   loc_82A6C
                cmpi.b  #$40,d7                         ; '@'
                bcs.w   loc_82A8E
                cmpi.b  #$81,d7
                bcs.w   Sound_LoadSFX
                cmpi.b  #$A0,d7
                bcs.w   Sound_ProcessDAC
                cmpi.b  #$F9,d7
                bcs.w   loc_830D2
                cmpi.b  #$FD,d7
                bcs.w   Sound_LoadSpecialSFX
locret_82A6A:                                           ; CODE XREF: Sound_UpdateEnvelope+16   j
                rts
; ---------------------------------------------------------------------------
loc_82A6C:                                              ; CODE XREF: Sound_UpdateEnvelope+24   j
                cmpi.b  #5,d7
                bcs.w   loc_82A76
                rts
; ---------------------------------------------------------------------------
loc_82A76:                                              ; CODE XREF: Sound_UpdateEnvelope+56   j
                subq.b  #1,d7
                lsl.w   #2,d7
                jmp     loc_82A7E(pc,d7.w)
; ---------------------------------------------------------------------------
loc_82A7E:                                              ; CODE XREF: Sound_UpdateEnvelope+60   j
                bra.w   Sound_WriteRegister
; ---------------------------------------------------------------------------
                bra.w   Sound_ProcessFM
; ---------------------------------------------------------------------------
                bra.w   Sound_ProcessSpecialChannels
; ---------------------------------------------------------------------------
                bra.w   Sound_UpdateFMEnvelope
; ---------------------------------------------------------------------------
loc_82A8E:                                              ; CODE XREF: Sound_UpdateEnvelope+2C   j
                cmpi.b  #$3F,d7                         ; '?'
                bcs.w   loc_82A98
                rts
; ---------------------------------------------------------------------------
loc_82A98:                                              ; CODE XREF: Sound_UpdateEnvelope+78   j
                subi.b  #$10,d7
                ext.w   d7
                asl.w   #3,d7
                lea     (word_82DEC).l,a0               ; 980 - PCMPart1
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
                bne.w   loc_82BA2
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82AC2:                                              ; CODE XREF: Sound_UpdateEnvelope+B0   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82AC2
                move.b  (byte_A01FFC).l,d1
                move.b  (byte_A01F87).l,d2
                move.b  (byte_A01FA7).l,d3
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                move.b  d1,d6
                move.b  5(a0),d0
                andi.b  #$C0,d0
                btst    #0,d1
                bne.w   loc_82B06
                andi.b  #$C0,d1
                cmp.b   d1,d0
                bcc.w   loc_82B1C
                rts
; ---------------------------------------------------------------------------
loc_82B06:                                              ; CODE XREF: Sound_UpdateEnvelope+DC   j
                andi.b  #$C0,d2
                andi.b  #$C0,d3
                cmp.b   d2,d0
                bcs.w   locret_82BA0
                cmp.b   d3,d0
                bcc.w   loc_82B1C
                rts
; ---------------------------------------------------------------------------
loc_82B1C:                                              ; CODE XREF: Sound_UpdateEnvelope+E6   j
                                        ; Sound_UpdateEnvelope+FC   j
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82B2A:                                              ; CODE XREF: Sound_UpdateEnvelope+118   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82B2A
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
                beq.w   locret_82BA0
                btst    #5,d6
                bne.w   locret_82BA0
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   locret_82BA0
                move.b  #1,(byte_FFF82B).w
locret_82BA0:                                           ; CODE XREF: Sound_UpdateEnvelope+F6   j
                                        ; Sound_UpdateEnvelope+16A   j
                rts
; ---------------------------------------------------------------------------
loc_82BA2:                                              ; CODE XREF: Sound_UpdateEnvelope+96   j
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82BB0:                                              ; CODE XREF: Sound_UpdateEnvelope+19E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82BB0
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
                bne.w   loc_82BFE
                andi.b  #$C0,d1
                cmp.b   d1,d0
                bcs.w   locret_82C2E
loc_82BFE:                                              ; CODE XREF: Sound_UpdateEnvelope+1D6   j
                andi.b  #$C0,d2
                andi.b  #$C0,d3
                move.b  6(a0),d1
                andi.b  #$C0,d1
                beq.w   loc_82C30
                cmpi.b  #$C0,d1
                beq.w   loc_82C30
                tst.b   d1
                bpl.w   loc_82C28
                cmp.b   d2,d0
                bcc.w   loc_82C62
                rts
; ---------------------------------------------------------------------------
loc_82C28:                                              ; CODE XREF: Sound_UpdateEnvelope+202   j
                cmp.b   d3,d0
                bcc.w   loc_82D12
locret_82C2E:                                           ; CODE XREF: Sound_UpdateEnvelope+1E0   j
                rts
; ---------------------------------------------------------------------------
loc_82C30:                                              ; CODE XREF: Sound_UpdateEnvelope+1F4   j
                                        ; Sound_UpdateEnvelope+1FC   j
                tst.b   d4
                beq.w   loc_82C62
                tst.b   d5
                beq.w   loc_82D12
                btst    #0,(byte_FFF82C).w
                bne.w   loc_82C54
                cmp.b   d2,d0
                bcc.w   loc_82C62
                cmp.b   d3,d0
                bcc.w   loc_82D12
                rts
; ---------------------------------------------------------------------------
loc_82C54:                                              ; CODE XREF: Sound_UpdateEnvelope+228   j
                cmp.b   d3,d0
                bcc.w   loc_82D12
                cmp.b   d2,d0
                bcc.w   loc_82C62
                rts
; ---------------------------------------------------------------------------
loc_82C62:                                              ; CODE XREF: Sound_UpdateEnvelope+208   j
                                        ; Sound_UpdateEnvelope+218   j
                bset    #0,(byte_FFF82C).w
                bsr.w   Sound_ReadEnvelopeData
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82C7A:                                              ; CODE XREF: Sound_UpdateEnvelope+268   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82C7A
                btst    #0,d6
                bne.w   loc_82C9C
                move.b  #$80,(byte_A01FFE).l
                move.b  #$80,(byte_A01FFD).l
loc_82C9C:                                              ; CODE XREF: Sound_UpdateEnvelope+26E   j
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
                beq.w   locret_82D10
                btst    #5,d6
                bne.w   locret_82D10
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   locret_82D10
                move.b  #1,(byte_FFF82B).w
locret_82D10:                                           ; CODE XREF: Sound_UpdateEnvelope+2DA   j
                                        ; Sound_UpdateEnvelope+2E2   j
                rts
; ---------------------------------------------------------------------------
loc_82D12:                                              ; CODE XREF: Sound_UpdateEnvelope+210   j
                                        ; Sound_UpdateEnvelope+21E   j
                bclr    #0,(byte_FFF82C).w
                bsr.w   Sound_ReadEnvelopeData
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_82D2A:                                              ; CODE XREF: Sound_UpdateEnvelope+318   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_82D2A
                btst    #0,d6
                bne.w   Sound_WriteZ80DACSample
                move.b  #$80,(byte_A01FFE).l
                move.b  #$80,(byte_A01FFD).l
; Writes DAC sample data to Z80 RAM
Sound_WriteZ80DACSample:                                ; CODE XREF: Sound_UpdateEnvelope+31E   j  ; was: loc_82D4C
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
                beq.w   locret_82DC0
                btst    #5,d6
                bne.w   locret_82DC0
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   locret_82DC0
                move.b  #1,(byte_FFF82B).w
locret_82DC0:                                           ; CODE XREF: Sound_UpdateEnvelope+38A   j
                                        ; Sound_UpdateEnvelope+392   j
                rts
; End of function Sound_UpdateEnvelope
; Reads sound envelope data bytes from memory pointer into registers
Sound_ReadEnvelopeData:                                 ; CODE XREF: Sound_UpdateEnvelope+24E   p  ; was: sub_82DC2
                                        ; Sound_UpdateEnvelope+2FE   p
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
; End of function Sound_ReadEnvelopeData
; ---------------------------------------------------------------------------
word_82DEC:     dc.w    (PCMPart3 >> $8)                ; DATA XREF: Sound_UpdateEnvelope+86   o
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

; Processes DAC digital audio channel
Sound_ProcessDAC:                                       ; CODE XREF: Sound_UpdateEnvelope+3C   j  ; was: sub_82F6C
                cmpi.b  #$A0,d7
                bcs.w   Sound_BGM
                rts
; ---------------------------------------------------------------------------
Sound_BGM:                                              ; CODE XREF: Sound_ProcessDAC+4   j
                jsr     Sound_ProcessFM(pc)             ; (pc)
                jsr     Sound_ProcessSpecialChannels(pc)  ; (pc)
                jsr     Sound_ResetDriver(pc)           ; (pc)
                lea     BGM_PointerTable(pc),a4
                subi.b  #$81,d7
                lsl.w   #2,d7
                movea.l (a4,d7.w),a4
                moveq   #0,d0
                move.w  (a4),d0
                add.l   a4,d0
                move.l  d0,(dword_FFF820).w
                move.b  5(a4),(byte_FFF802).w
                move.b  5(a4),(byte_FFF801).w
                moveq   #0,d1
                movea.l a4,a3
                addq.w  #6,a4
                moveq   #0,d7
                move.b  2(a3),d7
                beq.s   loc_82FFA
                subq.b  #1,d7
                move.b  #$C0,d1
                move.b  #$80,d3
                move.b  4(a3),d4
                moveq   #$30,d6                         ; '0'
                move.b  #1,d5
                lea     (byte_FFF840).w,a1
                lea     byte_830B0(pc),a2
loc_82FD0:                                              ; CODE XREF: Sound_ProcessDAC+8A   j
                move.b  d3,(a1)
                move.b  (a2)+,1(a1)
                move.b  d4,2(a1)
                move.b  d6,$D(a1)
                move.b  d1,$27(a1)
                move.b  d5,$E(a1)
                moveq   #0,d0
                move.w  (a4)+,d0
                add.l   a3,d0
                move.l  d0,4(a1)
                move.w  (a4)+,8(a1)
                adda.w  d6,a1
                dbf     d7,loc_82FD0
loc_82FFA:                                              ; CODE XREF: Sound_ProcessDAC+46   j
                moveq   #0,d7
                move.b  3(a3),d7
                beq.s   loc_8303A
                subq.b  #1,d7
                lea     (byte_FFF990).w,a1
                lea     byte_830B8(pc),a2
loc_8300C:                                              ; CODE XREF: Sound_ProcessDAC+CA   j
                move.b  d3,(a1)
                move.b  (a2)+,1(a1)
                move.b  d4,2(a1)
                move.b  d6,$D(a1)
                move.b  d5,$E(a1)
                moveq   #0,d0
                move.w  (a4)+,d0
                add.l   a3,d0
                move.l  d0,4(a1)
                move.w  (a4)+,8(a1)
                move.b  (a4)+,$A(a1)
                move.b  (a4)+,$B(a1)
                adda.w  d6,a1
                dbf     d7,loc_8300C
loc_8303A:                                              ; CODE XREF: Sound_ProcessDAC+94   j
                lea     (byte_FFFA20).w,a1
                moveq   #5,d7
loc_83040:                                              ; CODE XREF: Sound_ProcessDAC+F8   j
                tst.b   (a1)
                bpl.w   loc_83062
                moveq   #0,d0
                move.b  1(a1),d0
                bmi.s   loc_83054
                subq.b  #2,d0
                lsl.b   #2,d0
                bra.s   loc_83056
; ---------------------------------------------------------------------------
loc_83054:                                              ; CODE XREF: Sound_ProcessDAC+E0   j
                lsr.b   #3,d0
loc_83056:                                              ; CODE XREF: Sound_ProcessDAC+E6   j
                lea     dword_83196(pc),a0
                movea.l (a0,d0.w),a0
                bset    #2,(a0)
loc_83062:                                              ; CODE XREF: Sound_ProcessDAC+D6   j
                adda.w  d6,a1
                dbf     d7,loc_83040
                tst.w   (word_FFFB40).w
                bpl.s   loc_83074
                bset    #2,(byte_FFF900).w
loc_83074:                                              ; CODE XREF: Sound_ProcessDAC+100   j
                tst.w   (word_FFFB70).w
                bpl.s   loc_83080
                bset    #2,(byte_FFF9F0).w
loc_83080:                                              ; CODE XREF: Sound_ProcessDAC+10C   j
                lea     (word_FFF870).w,a5
                moveq   #5,d4
loc_83086:                                              ; CODE XREF: Sound_ProcessDAC+120   j
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
                adda.w  d6,a5
                dbf     d4,loc_83086
                moveq   #2,d4
loc_83092:                                              ; CODE XREF: Sound_ProcessDAC+12C   j
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
                adda.w  d6,a5
                dbf     d4,loc_83092
                btst    #2,(byte_FFF9F0).w
                bne.s   Sound_DACProcessEnd
                move.b  #$FF,(VDP_PSG).l
; Ends DAC processing and returns
Sound_DACProcessEnd:                                    ; CODE XREF: Sound_ProcessDAC+136   j  ; was: loc_830AC
                addq.w  #4,sp
                rts
; End of function Sound_ProcessDAC
; ---------------------------------------------------------------------------
byte_830B0:     dc.b    6, 0, 1, 2, 4, 5, 6, 0
                                        ; DATA XREF: Sound_ProcessDAC+60   o
byte_830B8:     dc.b    $80, $A0, $C0, 0                ; DATA XREF: Sound_ProcessDAC+9C   o

; Loads regular SFX IDs $40-$7F and $A0-$F8 into the sound channels
Sound_LoadSFX:                                          ; CODE XREF: Sound_UpdateEnvelope+34   j  ; was: sub_830BC
                cmpi.b  #$80,d7
                bcs.w   loc_830C6
                rts
; ---------------------------------------------------------------------------
loc_830C6:                                              ; CODE XREF: Sound_LoadSFX+4   j
                lea     SFX_PointerTable(pc),a0
                addi.w  #$1D,d7
                bra.w   loc_830E4
; ---------------------------------------------------------------------------
loc_830D2:                                              ; CODE XREF: Sound_UpdateEnvelope+44   j
                cmpi.b  #$F9,d7
                bcs.w   loc_830DC
                rts
; ---------------------------------------------------------------------------
loc_830DC:                                              ; CODE XREF: Sound_LoadSFX+1A   j
                lea     SFX_PointerTable(pc),a0
                subi.b  #$A0,d7
loc_830E4:                                              ; CODE XREF: Sound_LoadSFX+12   j
                lsl.w   #2,d7
                movea.l (a0,d7.w),a3
                movea.l a3,a1
                moveq   #0,d1
                move.w  (a1)+,d1
                add.l   a3,d1
                move.b  (a1)+,d5
                moveq   #0,d7
                move.b  (a1)+,d7
                subq.w  #1,d7
                moveq   #$30,d6                         ; '0'
loc_830FC:                                              ; CODE XREF: Sound_LoadSFX:loc_83178   j
                moveq   #0,d3
                move.b  1(a1),d3
                move.b  d3,d4
                bmi.s   loc_83118
                subq.w  #2,d3
                lsl.w   #2,d3
                lea     dword_83196(pc),a5
                movea.l (a5,d3.w),a5
                bset    #2,(a5)
                bra.s   loc_8313E
; ---------------------------------------------------------------------------
loc_83118:                                              ; CODE XREF: Sound_LoadSFX+48   j
                lsr.w   #3,d3
                movea.l dword_83196(pc,d3.w),a5
                bset    #2,(a5)
                cmpi.b  #$C0,d4
                bne.s   loc_8313E
                move.b  d4,d0
                ori.b   #$1F,d0
                move.b  d0,(VDP_PSG).l
                bchg    #5,d0
                move.b  d0,(VDP_PSG).l
loc_8313E:                                              ; CODE XREF: Sound_LoadSFX+5A   j
                                        ; Sound_LoadSFX+6A   j
                movea.l dword_831B6(pc,d3.w),a5
                movea.l a5,a2
                moveq   #$B,d0
loc_83146:                                              ; CODE XREF: Sound_LoadSFX+8C   j
                clr.l   (a2)+
                dbf     d0,loc_83146
                move.l  d1,$20(a5)
                move.w  (a1)+,(a5)
                move.b  d5,2(a5)
                moveq   #0,d0
                move.w  (a1)+,d0
                add.l   a3,d0
                move.l  d0,4(a5)
                move.w  (a1)+,8(a5)
                move.b  #1,$E(a5)
                move.b  d6,$D(a5)
                tst.b   d4
                bmi.s   loc_83178
                move.b  #$C0,$27(a5)
loc_83178:                                              ; CODE XREF: Sound_LoadSFX+B4   j
                dbf     d7,loc_830FC
                tst.b   (byte_FFFA50).w
                bpl.s   loc_83188
                bset    #2,(word_FFFB40).w
loc_83188:                                              ; CODE XREF: Sound_LoadSFX+C4   j
                tst.b   (byte_FFFB10).w
                bpl.s   locret_83194
                bset    #2,(word_FFFB70).w
locret_83194:                                           ; CODE XREF: Sound_LoadSFX+D0   j
                rts
; End of function Sound_LoadSFX
; ---------------------------------------------------------------------------
dword_83196:    dc.l    $FFFFF8D0, 0                    ; DATA XREF: Sound_ProcessDAC:loc_83056   o
                                        ; Sound_LoadSFX+4E   o
                dc.l    $FFFFF900, $FFFFF930
                dc.l    $FFFFF990, $FFFFF9C0
                dc.l    $FFFFF9F0, $FFFFF9F0
dword_831B6:    dc.l    $FFFFFA20, 0                    ; DATA XREF: Sound_LoadSFX:loc_8313E   r
                dc.l    $FFFFFA50, $FFFFFA80
                dc.l    $FFFFFAB0, $FFFFFAE0
                dc.l    $FFFFFB10, $FFFFFB10

; Loads special SFX IDs $F9-$FC into the dedicated override channels
Sound_LoadSpecialSFX:                                   ; CODE XREF: Sound_UpdateEnvelope+4C   j  ; was: sub_831D6
                cmpi.b  #$FD,d7
                bcs.w   loc_831E0
                rts
; ---------------------------------------------------------------------------
loc_831E0:                                              ; CODE XREF: Sound_LoadSpecialSFX+4   j
                lea     SpecialSFX_PointerTable(pc),a0
                subi.b  #$F9,d7
                lsl.w   #2,d7
                movea.l (a0,d7.w),a3
                movea.l a3,a1
                moveq   #0,d0
                move.w  (a1)+,d0
                add.l   a3,d0
                move.l  d0,(dword_FFF824).w
                move.b  (a1)+,d5
                moveq   #0,d7
                move.b  (a1)+,d7
                subq.w  #1,d7
                moveq   #$30,d6                         ; '0'
loc_83204:                                              ; CODE XREF: Sound_LoadSpecialSFX:loc_83252   j
                move.b  1(a1),d4
                bmi.s   loc_83216
                bset    #2,(byte_FFF900).w
                lea     (word_FFFB40).w,a5
                bra.s   loc_83220
; ---------------------------------------------------------------------------
loc_83216:                                              ; CODE XREF: Sound_LoadSpecialSFX+32   j
                bset    #2,(byte_FFF9F0).w
                lea     (word_FFFB70).w,a5
loc_83220:                                              ; CODE XREF: Sound_LoadSpecialSFX+3E   j
                movea.l a5,a2
                moveq   #$B,d0
loc_83224:                                              ; CODE XREF: Sound_LoadSpecialSFX+50   j
                clr.l   (a2)+
                dbf     d0,loc_83224
                move.w  (a1)+,(a5)
                move.b  d5,2(a5)
                moveq   #0,d0
                move.w  (a1)+,d0
                add.l   a3,d0
                move.l  d0,4(a5)
                move.w  (a1)+,8(a5)
                move.b  #1,$E(a5)
                move.b  d6,$D(a5)
                tst.b   d4
                bmi.s   loc_83252
                move.b  #$C0,$27(a5)
loc_83252:                                              ; CODE XREF: Sound_LoadSpecialSFX+74   j
                dbf     d7,loc_83204
                tst.b   (byte_FFFA50).w
                bpl.s   loc_83262
                bset    #2,(word_FFFB40).w
loc_83262:                                              ; CODE XREF: Sound_LoadSpecialSFX+84   j
                tst.b   (byte_FFFB10).w
                bpl.s   locret_83282
                bset    #2,(word_FFFB70).w
                ori.b   #$1F,d4
                move.b  d4,(VDP_PSG).l
                bchg    #5,d4
                move.b  d4,(VDP_PSG).l
locret_83282:                                           ; CODE XREF: Sound_LoadSpecialSFX+90   j
                rts
; End of function Sound_LoadSpecialSFX
; ---------------------------------------------------------------------------
unused_10:      binclude "data/other/unused_10.bin"

; Processes FM synthesis channels
Sound_ProcessFM:                                        ; CODE XREF: Sound_UpdateEnvelope+68   j  ; was: sub_8329C
                                        ; sub_82F6C:Sound_BGM   p
                                        ; DATA XREF:
                clr.b   (byte_FFF800).w
                moveq   #$27,d0                         ; '''
                moveq   #0,d1
                jsr     Sound_WriteYM2612Wrapper(pc)    ; (pc)
                lea     (byte_FFFA20).w,a5
                moveq   #5,d6
loc_832AE:                                              ; CODE XREF: Sound_ProcessFM+9E   j
                tst.b   (a5)
                bpl.w   loc_83336
                bclr    #7,(a5)
                moveq   #0,d3
                move.b  1(a5),d3
                bmi.s   loc_83300
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
                cmpi.b  #4,d3
                bne.s   loc_832DA
                tst.b   (word_FFFB40).w
                bpl.s   loc_832DA
                lea     (word_FFFB40).w,a5
                movea.l (dword_FFF824).w,a1
                bra.s   loc_832EC
; ---------------------------------------------------------------------------
loc_832DA:                                              ; CODE XREF: Sound_ProcessFM+2C   j
                                        ; Sound_ProcessFM+32   j
                subq.b  #2,d3
                lsl.b   #2,d3
                lea     dword_83196(pc),a0
                movea.l a5,a3
                movea.l (a0,d3.w),a5
                movea.l (dword_FFF820).w,a1
loc_832EC:                                              ; CODE XREF: Sound_ProcessFM+3C   j
                bclr    #2,(a5)
                bset    #1,(a5)
                move.b  $B(a5),d0
                jsr     Sound_SetFMInstrument(pc)       ; (pc)
                movea.l a3,a5
                bra.s   loc_83336
; ---------------------------------------------------------------------------
loc_83300:                                              ; CODE XREF: Sound_ProcessFM+22   j
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
                lea     (word_FFFB70).w,a0
                cmpi.b  #$E0,d3
                beq.s   loc_8331E
                cmpi.b  #$C0,d3
                beq.s   loc_8331E
                lsr.b   #3,d3
                lea     dword_83196(pc),a0
                movea.l (a0,d3.w),a0
loc_8331E:                                              ; CODE XREF: Sound_ProcessFM+70   j
                                        ; Sound_ProcessFM+76   j
                bclr    #2,(a0)
                bset    #1,(a0)
                cmpi.b  #$E0,1(a0)
                bne.s   loc_83336
                move.b  $25(a0),(VDP_PSG).l
loc_83336:                                              ; CODE XREF: Sound_ProcessFM+14   j
                                        ; Sound_ProcessFM+62   j
                adda.w  #$30,a5                         ; '0'
                dbf     d6,loc_832AE
                rts
; End of function Sound_ProcessFM
; Handles DAC and PSG special channel initialization and instrument setup
Sound_ProcessSpecialChannels:                           ; CODE XREF: Sound_UpdateEnvelope+6C   j  ; was: sub_83340
                                        ; Sound_ProcessDAC+E   p
                                        ; DATA XREF:
                lea     (word_FFFB40).w,a5
                tst.b   (a5)
                bpl.s   loc_83372
                bclr    #7,(a5)
                btst    #2,(a5)
                bne.s   loc_83372
                jsr     Sound_SendKeyOn(pc)             ; (pc)
                lea     (byte_FFF900).w,a5
                bclr    #2,(a5)
                bset    #1,(a5)
                tst.b   (a5)
                bpl.s   loc_83372
                movea.l (dword_FFF820).w,a1
                move.b  $B(a5),d0
                jsr     Sound_SetFMInstrument(pc)       ; (pc)
loc_83372:                                              ; CODE XREF: Sound_ProcessSpecialChannels+6   j
                                        ; Sound_ProcessSpecialChannels+10   j
                lea     (word_FFFB70).w,a5
                tst.b   (a5)
                bpl.s   locret_833A8
                bclr    #7,(a5)
                btst    #2,(a5)
                bne.s   locret_833A8
                jsr     Sound_MutePSGChannel(pc)        ; (pc)
                lea     (byte_FFF9F0).w,a5
                bclr    #2,(a5)
                bset    #1,(a5)
                tst.b   (a5)
                bpl.s   locret_833A8
                cmpi.b  #$E0,1(a5)
                bne.s   locret_833A8
                move.b  $25(a5),(VDP_PSG).l
locret_833A8:                                           ; CODE XREF: Sound_ProcessSpecialChannels+38   j
                                        ; Sound_ProcessSpecialChannels+42   j
                rts
; End of function Sound_ProcessSpecialChannels
; Writes data to sound chip registers
Sound_WriteRegister:                                    ; CODE XREF: Sound_UpdateEnvelope:loc_82A7E   j  ; was: sub_833AA
                move.b  #3,(byte_FFF806).w
                move.b  #$28,(byte_FFF804).w            ; '('
                clr.b   (byte_FFF840).w
                rts
; End of function Sound_WriteRegister
; Initializes sound channel structures
Sound_InitializeChannels:                               ; CODE XREF: Sound_UpdateDriver+14   p  ; was: sub_833BC
                                        ; DATA XREF: Sound_UpdateDriver+14   o
                moveq   #0,d0
                move.b  (byte_FFF804).w,d0
                beq.s   locret_833CE
                move.b  (byte_FFF806).w,d0
                beq.s   loc_833D0
                subq.b  #1,(byte_FFF806).w
locret_833CE:                                           ; CODE XREF: Sound_InitializeChannels+6   j
                rts
; ---------------------------------------------------------------------------
loc_833D0:                                              ; CODE XREF: Sound_InitializeChannels+C   j
                subq.b  #1,(byte_FFF804).w
                beq.w   Sound_UpdateFMEnvelope
                move.b  #3,(byte_FFF806).w
                lea     (word_FFF870).w,a5
                moveq   #5,d7
loc_833E4:                                              ; CODE XREF: Sound_InitializeChannels+40   j
                tst.b   (a5)
                bpl.s   loc_833F8
                addq.b  #1,9(a5)
                bpl.s   loc_833F4
                bclr    #7,(a5)
                bra.s   loc_833F8
; ---------------------------------------------------------------------------
loc_833F4:                                              ; CODE XREF: Sound_InitializeChannels+30   j
                jsr     Sound_ApplyVolume(pc)           ; (pc)
loc_833F8:                                              ; CODE XREF: Sound_InitializeChannels+2A   j
                                        ; Sound_InitializeChannels+36   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_833E4
                moveq   #2,d7
loc_83402:                                              ; CODE XREF: Sound_InitializeChannels+68   j
                tst.b   (a5)
                bpl.s   Sound_ChannelInitLoop
                addq.b  #1,9(a5)
                cmpi.b  #$10,9(a5)
                bcs.s   loc_83418
                bclr    #7,(a5)
                bra.s   Sound_ChannelInitLoop
; ---------------------------------------------------------------------------
loc_83418:                                              ; CODE XREF: Sound_InitializeChannels+54   j
                move.b  9(a5),d6
                jsr     Sound_ApplyPSGVolume(pc)        ; (pc)
; Channel initialization loop iteration
Sound_ChannelInitLoop:                                  ; CODE XREF: Sound_InitializeChannels+48   j  ; was: loc_83420
                                        ; Sound_InitializeChannels+5A   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_83402
                rts
; End of function Sound_InitializeChannels
; Processes sound tempo tick and increments channel timers
Sound_ProcessTempoTick:                                 ; CODE XREF: Sound_UpdateDriver+10   p  ; was: sub_8342A
                                        ; DATA XREF: Sound_UpdateDriver+10   o
                tst.b   (byte_FFF802).w
                beq.s   locret_83452
                subq.b  #1,(byte_FFF801).w
                bne.s   locret_83452
                move.b  (byte_FFF802).w,(byte_FFF801).w
                lea     (byte_FFF840).w,a0
                moveq   #$30,d0                         ; '0'
                moveq   #9,d1
loc_83444:                                              ; CODE XREF: Sound_ProcessTempoTick+24   j
                tst.b   (a0)
                bpl.s   loc_8344C
                addq.b  #1,$E(a0)
loc_8344C:                                              ; CODE XREF: Sound_ProcessTempoTick+1C   j
                adda.w  d0,a0
                dbf     d1,loc_83444
locret_83452:                                           ; CODE XREF: Sound_ProcessTempoTick+4   j
                                        ; Sound_ProcessTempoTick+A   j
                rts
; End of function Sound_ProcessTempoTick
; Mutes all FM and PSG channels by sending key-off/mute commands
Sound_MuteAllChannels:                                  ; CODE XREF: Sound_MuteAndStop   p  ; was: sub_83454
                moveq   #3,d4
                moveq   #$40,d3                         ; '@'
                moveq   #$7F,d1
loc_8345A:                                              ; CODE XREF: Sound_MuteAllChannels+E   j
                move.b  d3,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                addq.b  #4,d3
                dbf     d4,loc_8345A
                moveq   #3,d4
                move.b  #$80,d3
                moveq   #$F,d1
loc_8346E:                                              ; CODE XREF: Sound_MuteAllChannels+22   j
                move.b  d3,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
                addq.b  #4,d3
                dbf     d4,loc_8346E
                rts
; End of function Sound_MuteAllChannels
; Sends key-off to all FM channels
Sound_KeyOffAllChannels:                                ; CODE XREF: Sound_UpdateFMEnvelope+1C   p  ; was: sub_8347C
                                        ; DATA XREF: Sound_UpdateFMEnvelope+1C   o
                moveq   #2,d2
                moveq   #$28,d0                         ; '('
loc_83480:                                              ; CODE XREF: Sound_KeyOffAllChannels+10   j
                move.b  d2,d1
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                addq.b  #4,d1
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                dbf     d2,loc_83480
; End of function Sound_KeyOffAllChannels
; Sets maximum volume on all operators
Sound_SetMaxVolume:                                     ; CODE XREF: Sound_HandleZ80BusRequest+5C   p  ; was: sub_83490
                moveq   #$7F,d1
                moveq   #2,d2
loc_83494:                                              ; CODE XREF: Sound_SetMaxVolume+18   j
                moveq   #$40,d0                         ; '@'
                add.w   d2,d0
                moveq   #3,d3
loc_8349A:                                              ; CODE XREF: Sound_SetMaxVolume+14   j
                jsr     Sound_WriteYM2612(pc)           ; (pc)
                jsr     Sound_WriteYM2612Register(pc)   ; (pc)
                addq.w  #4,d0
                dbf     d3,loc_8349A
                dbf     d2,loc_83494
                rts
; End of function Sound_SetMaxVolume
; Updates FM synthesis envelope parameters
Sound_UpdateFMEnvelope:                                 ; CODE XREF: Sound_UpdateEnvelope+1C   j  ; was: sub_834AE
                                        ; Sound_UpdateEnvelope+70   j
                moveq   #$27,d0                         ; '''
                moveq   #0,d1
                jsr     Sound_WriteYM2612Wrapper(pc)    ; (pc)
                lea     (byte_FFF800).w,a0
                move.w  #$E3,d0
; Clears sound driver RAM in loop
Sound_ClearRAMLoop:                                     ; CODE XREF: Sound_UpdateFMEnvelope+12   j  ; was: loc_834BE
                clr.l   (a0)+
                dbf     d0,Sound_ClearRAMLoop
                move.b  #$FF,(byte_FFF809).w
                jsr     Sound_KeyOffAllChannels(pc)     ; (pc)
                bra.w   Sound_MuteAllPSGChannels
; End of function Sound_UpdateFMEnvelope
; Resets sound driver state and clears RAM
Sound_ResetDriver:                                      ; CODE XREF: Sound_ProcessDAC+12   p  ; was: sub_834D2
                                        ; DATA XREF: Sound_ProcessDAC+12   o
                moveq   #$27,d0                         ; '''
                moveq   #0,d1
                jsr     Sound_WriteYM2612Wrapper(pc)    ; (pc)
                move.b  (byte_FFF800).w,d0
                move.w  d0,-(sp)
                lea     (byte_FFF800).w,a0
                move.w  #$87,d0
; Resets sound RAM preserving settings
Sound_ResetRAMLoop:                                     ; CODE XREF: Sound_ResetDriver+18   j  ; was: loc_834E8
                clr.l   (a0)+
                dbf     d0,Sound_ResetRAMLoop
                move.w  (sp)+,d0
                move.b  d0,(byte_FFF800).w
                move.b  #$FF,(byte_FFF809).w
                rts
; End of function Sound_ResetDriver
; Loads Z80 sound driver code with bus request and reset sequence
Sound_LoadZ80Driver:                                    ; CODE XREF: Sound_InitDriverThunk   j  ; was: sub_834FC
                                        ; Sound_UpdateEnvelope+E   j
                                        ; DATA XREF:
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_8350A:                                              ; CODE XREF: Sound_LoadZ80Driver+16   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_8350A
                lea     z80_data(pc),a0
                lea     (Z80_RAM).l,a1
                move.w  #$BFF,d0
loc_83522:                                              ; CODE XREF: Sound_LoadZ80Driver+28   j
                move.b  (a0)+,(a1)+
                dbf     d0,loc_83522
                move.w  #0,(IO_Z80RES).l
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                move.w  #$100,(IO_Z80RES).l
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                bra.w   Sound_UpdateFMEnvelope
; End of function Sound_LoadZ80Driver
; Sends key off command to FM channel stopping note
Sound_SendKeyOff:                                       ; CODE XREF: Sound_ProcessChannel+16   j  ; was: sub_83562
                btst    #1,(a5)
                bne.s   locret_8357C
                btst    #2,(a5)
                bne.s   locret_8357C
                moveq   #$28,d0                         ; '('
                move.b  1(a5),d1
                ori.b   #$F0,d1
                bra.w   Sound_WriteYM2612Wrapper
; ---------------------------------------------------------------------------
locret_8357C:                                           ; CODE XREF: Sound_SendKeyOff+4   j
                                        ; Sound_SendKeyOff+A   j
                rts
; End of function Sound_SendKeyOff
; Checks sound channel flags before processing operations
Sound_CheckChannelFlags:                                ; CODE XREF: Sound_ParseTrackData:loc_82594   p  ; was: sub_8357E
                                        ; Sound_HandleNoteTimer+18   p
                btst    #4,(a5)
                bne.s   nullsub_137
                btst    #2,(a5)
                bne.s   nullsub_137
; End of function Sound_CheckChannelFlags
; Sends key on command to FM channel starting note
Sound_SendKeyOn:                                        ; CODE XREF: Sound_ProcessSpecialChannels+12   p  ; was: sub_8358A
                moveq   #$28,d0                         ; '('
                move.b  1(a5),d1
                bra.w   Sound_WriteYM2612Wrapper
; End of function Sound_SendKeyOn
nullsub_137:                                            ; CODE XREF: Sound_CheckChannelFlags+4   j
                                        ; Sound_CheckChannelFlags+A   j
                rts
; End of function nullsub_137

; Checks if channel is paused before processing channel bits
Sound_CheckPauseFlag:                                   ; CODE XREF: Sound_SetLFO+24   p  ; was: sub_83596
                                        ; Sound_WriteFMChannelRegister+4   j
                btst    #2,(a5)
                beq.w   Sound_ProcessChannelBits
                rts
; End of function Sound_CheckPauseFlag
; Attributes: thunk
; Wrapper function redirecting to YM2612 register write
Sound_WriteYM2612Wrapper:                               ; CODE XREF: Sound_ProcessFM+8   p  ; was: sub_835A0
                                        ; Sound_UpdateFMEnvelope+4   p
                bra.w   Sound_WriteYM2612
; End of function Sound_WriteYM2612Wrapper
; Processes YM2612 sound chip channel bit flags
Sound_ProcessChannelBits:                               ; CODE XREF: Sound_UpdateChannelFrequency+40   p  ; was: sub_835A4
                                        ; Sound_UpdateChannelFrequency+4A   p
                move.b  1(a5),d2
                bclr    #2,d2
                bne.s   Sound_AddChannelOffset
                add.b   d2,d0
; End of function Sound_ProcessChannelBits
; Writes data to YM2612 FM chip registers
Sound_WriteYM2612:                                      ; CODE XREF: Sound_UpdateFMOperators+20   p  ; was: sub_835B0
                                        ; Sound_UpdateFMOperators+28   p
                cmpi.b  #$50,d0                         ; 'P'
                bcc.w   loc_835CC
                cmpi.b  #$40,d0                         ; '@'
                bcs.w   loc_835CC
                andi.w  #$FF,d0
                lea     (byte_FFFBA0).w,a0
                move.b  d1,(a0,d0.w)
loc_835CC:                                              ; CODE XREF: Sound_WriteYM2612+4   j
                                        ; Sound_WriteYM2612+C   j
                lea     (Z80_YM2612).l,a0
loc_835D2:                                              ; CODE XREF: Sound_WriteYM2612+48   j
                move.w  #$100,(IO_Z80BUS).l
loc_835DA:                                              ; CODE XREF: Sound_WriteYM2612+32   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_835DA
                tst.b   (byte_A01F2A).l
                beq.s   loc_835FA
                move.w  #0,(IO_Z80BUS).l
                bsr.w   Sound_DelayNOP
                bra.s   loc_835D2
; ---------------------------------------------------------------------------
loc_835FA:                                              ; CODE XREF: Sound_WriteYM2612+3A   j
                                        ; Sound_WriteYM2612+4C   j
                tst.b   (a0)
                bmi.s   loc_835FA
                move.b  d0,0.w(a0)
                nop
loc_83604:                                              ; CODE XREF: Sound_WriteYM2612+56   j
                tst.b   (a0)
                bmi.s   loc_83604
                move.b  d1,1(a0)
                move.w  #0,(IO_Z80BUS).l
                rts
; End of function Sound_WriteYM2612
; Adds channel offset to register address for FM operators
Sound_AddChannelOffset:                                 ; CODE XREF: Sound_ProcessChannelBits+8   j  ; was: sub_83616
                add.b   d2,d0
; End of function Sound_AddChannelOffset
; Writes data to YM2612 FM chip via Z80 bus with sync
Sound_WriteYM2612Register:                              ; CODE XREF: Sound_HandleZ80BusRequest+A4   p  ; was: sub_83618
                                        ; Sound_SetMaxVolume+E   p
                cmpi.b  #$50,d0                         ; 'P'
                bcc.w   loc_83634
                cmpi.b  #$40,d0                         ; '@'
                bcs.w   loc_83634
                andi.w  #$FF,d0
                lea     (byte_FFFBA0).w,a0
                move.b  d1,byte_FFFBB0-byte_FFFBA0(a0,d0.w)
loc_83634:                                              ; CODE XREF: Sound_WriteYM2612Register+4   j
                                        ; Sound_WriteYM2612Register+C   j
                lea     (Z80_YM2612).l,a0
loc_8363A:                                              ; CODE XREF: Sound_WriteYM2612Register+48   j
                move.w  #$100,(IO_Z80BUS).l
loc_83642:                                              ; CODE XREF: Sound_WriteYM2612Register+32   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_83642
                tst.b   (byte_A01F2A).l
                beq.s   loc_83662
                move.w  #0,(IO_Z80BUS).l
                bsr.w   Sound_DelayNOP
                bra.s   loc_8363A
; ---------------------------------------------------------------------------
loc_83662:                                              ; CODE XREF: Sound_WriteYM2612Register+3A   j
                                        ; Sound_WriteYM2612Register+4C   j
                tst.b   (a0)
                bmi.s   loc_83662
                move.b  d0,2(a0)
                nop
; Writes data byte to YM2612 with wait
Sound_WriteYM2612DataLoop:                              ; CODE XREF: Sound_WriteYM2612Register+56   j  ; was: loc_8366C
                tst.b   (a0)
                bmi.s   Sound_WriteYM2612DataLoop
                move.b  d1,3(a0)
                move.w  #0,(IO_Z80BUS).l
                rts
; End of function Sound_WriteYM2612Register
; Delay function with NOP instructions for timing
Sound_DelayNOP:                                         ; CODE XREF: Sound_HandleZ80BusRequest+40   p  ; was: sub_8367E
                                        ; Sound_WriteYM2612+44   p
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                rts
; End of function Sound_DelayNOP
; Processes music volume fade in/out with Z80 sync and envelope control
Sound_ProcessVolumeFade:                                ; CODE XREF: Sound_UpdateDriver+C   p  ; was: sub_836A0
                                        ; DATA XREF: Sound_UpdateDriver+C   o
                cmpi.b  #2,(byte_FFF82B).w
                beq.w   loc_836D2
                move.b  (byte_FFF828).w,d0
                beq.w   loc_836D2
                bmi.w   loc_836C8
                cmpi.b  #1,d0
                bne.w   loc_836D2
                move.b  #2,(byte_FFF828).w
                bra.w   loc_8377A
; ---------------------------------------------------------------------------
loc_836C8:                                              ; CODE XREF: Sound_ProcessVolumeFade+12   j
                move.b  #0,(byte_FFF828).w
                bra.w   loc_837C2
; ---------------------------------------------------------------------------
loc_836D2:                                              ; CODE XREF: Sound_ProcessVolumeFade+6   j
                                        ; Sound_ProcessVolumeFade+E   j
                cmpi.b  #2,(byte_FFF828).w
                beq.w   locret_83778
                move.b  (byte_FFF82B).w,d0
                beq.w   locret_83778
                cmpi.b  #1,d0
                bne.w   loc_8373E
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_836FA:                                              ; CODE XREF: Sound_ProcessVolumeFade+62   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_836FA
                move.b  (byte_A01FFC).l,d7
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                btst    #5,d7
                beq.w   locret_83778
                move.b  #2,(byte_FFF82B).w
                move.b  (byte_FFF829).w,d0
                or.b    (byte_FFF82A).w,d0
                bne.w   loc_8377A
                move.b  #$A,(byte_FFF829).w
                move.b  #2,(byte_FFF82A).w
                bra.w   loc_8377A
; ---------------------------------------------------------------------------
loc_8373E:                                              ; CODE XREF: Sound_ProcessVolumeFade+48   j
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_8374C:                                              ; CODE XREF: Sound_ProcessVolumeFade+B4   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_8374C
                move.b  (byte_A01FFC).l,d7
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                btst    #5,d7
                bne.w   locret_83778
                move.b  #0,(byte_FFF82B).w
                bra.w   loc_837C2
; ---------------------------------------------------------------------------
locret_83778:                                           ; CODE XREF: Sound_ProcessVolumeFade+38   j
                                        ; Sound_ProcessVolumeFade+40   j
                rts
; ---------------------------------------------------------------------------
loc_8377A:                                              ; CODE XREF: Sound_ProcessVolumeFade+24   j
                                        ; Sound_ProcessVolumeFade+8A   j
                move.b  (byte_FFF829).w,d6
                lea     (word_FFF870).w,a5
                moveq   #5,d7
loc_83784:                                              ; CODE XREF: Sound_ProcessVolumeFade+F6   j
                tst.b   (a5)
                bpl.s   loc_83792
                add.b   d6,9(a5)
                bmi.s   loc_83792
                jsr     Sound_ApplyVolume(pc)           ; (pc)
loc_83792:                                              ; CODE XREF: Sound_ProcessVolumeFade+E6   j
                                        ; Sound_ProcessVolumeFade+EC   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_83784
                move.b  (byte_FFF82A).w,d5
                moveq   #2,d7
loc_837A0:                                              ; CODE XREF: Sound_ProcessVolumeFade+11C   j
                tst.b   (a5)
                bpl.s   loc_837B8
                add.b   d5,9(a5)
                cmpi.b  #$10,9(a5)
                bcc.s   loc_837B8
                move.b  9(a5),d6
                jsr     Sound_ApplyPSGVolume(pc)        ; (pc)
loc_837B8:                                              ; CODE XREF: Sound_ProcessVolumeFade+102   j
                                        ; Sound_ProcessVolumeFade+10E   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_837A0
                rts
; ---------------------------------------------------------------------------
loc_837C2:                                              ; CODE XREF: Sound_ProcessVolumeFade+2E   j
                                        ; Sound_ProcessVolumeFade+D4   j
                move.b  (byte_FFF829).w,d6
                lea     (word_FFF870).w,a5
                moveq   #5,d7
loc_837CC:                                              ; CODE XREF: Sound_ProcessVolumeFade+13C   j
                tst.b   (a5)
                bpl.s   loc_837D8
                sub.b   d6,9(a5)
                jsr     Sound_ApplyVolume(pc)           ; (pc)
loc_837D8:                                              ; CODE XREF: Sound_ProcessVolumeFade+12E   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_837CC
                move.b  (byte_FFF82A).w,d5
                moveq   #2,d7
loc_837E6:                                              ; CODE XREF: Sound_ProcessVolumeFade+15A   j
                tst.b   (a5)
                bpl.s   loc_837F6
                sub.b   d5,9(a5)
                move.b  9(a5),d6
                jsr     Sound_ApplyPSGVolume(pc)        ; (pc)
loc_837F6:                                              ; CODE XREF: Sound_ProcessVolumeFade+148   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,loc_837E6
                clr.b   (byte_FFF829).w
                clr.b   (byte_FFF82A).w
                rts
; End of function Sound_ProcessVolumeFade
; ---------------------------------------------------------------------------
word_83808:     dc.w    $25E, $284, $2AB, $2D3, $2FE, $32D, $35C, $38F, $3C5, $3FF, $43C, $47C
                                        ; DATA XREF: Sound_CalculatePitch+18   o

; Dispatches sound commands via jump table
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
Sound_SetMusicPaused:                                   ; CODE XREF: Sound_ExtendedCommandDispatch+E   j  ; was: sub_83CEE
                moveq   #$30,d3                         ; '0'
                move.b  (a4)+,d0
                beq.s   loc_83D4A
                movea.l a5,a3
                lea     (byte_FFF840).w,a5
                btst    #7,(a5)
                beq.s   loc_83D08
                bclr    #7,(a5)
                bset    #0,(a5)
loc_83D08:                                              ; CODE XREF: Sound_SetMusicPaused+10   j
                moveq   #5,d4
loc_83D0A:                                              ; CODE XREF: Sound_SetMusicPaused:loc_83D28   j
                adda.w  d3,a5
                btst    #7,(a5)
                beq.s   loc_83D28
                bclr    #7,(a5)
                bset    #0,(a5)
                move.b  #$B4,d0
                moveq   #0,d1
                jsr     Sound_CheckPauseFlag(pc)        ; (pc)
                jsr     Sound_CheckChannelFlags(pc)     ; (pc)
loc_83D28:                                              ; CODE XREF: Sound_SetMusicPaused+22   j
                dbf     d4,loc_83D0A
                moveq   #2,d4
loc_83D2E:                                              ; CODE XREF: Sound_SetMusicPaused:loc_83D42   j
                adda.w  d3,a5
                btst    #7,(a5)
                beq.s   loc_83D42
                bclr    #7,(a5)
                bset    #0,(a5)
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
loc_83D42:                                              ; CODE XREF: Sound_SetMusicPaused+46   j
                dbf     d4,loc_83D2E
                movea.l a3,a5
                rts
; ---------------------------------------------------------------------------
loc_83D4A:                                              ; CODE XREF: Sound_SetMusicPaused+4   j
                movea.l a5,a3
                lea     (byte_FFF840).w,a5
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_83D5E:                                              ; CODE XREF: Sound_SetMusicPaused+78   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_83D5E
                move.b  (byte_A01FFD).l,d0
                move.b  (byte_A01FF9).l,d1
                move.b  (byte_A01FFA).l,d2
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                beq.w   loc_83D98
                bpl.w   loc_83D90
                move.b  d2,d1
loc_83D90:                                              ; CODE XREF: Sound_SetMusicPaused+9C   j
                move.b  #$B6,d0
                jsr     Sound_WriteYM2612Register(pc)   ; (pc)
loc_83D98:                                              ; CODE XREF: Sound_SetMusicPaused+98   j
                btst    #0,(a5)
                beq.s   loc_83DA6
                bset    #7,(a5)
                bclr    #0,(a5)
loc_83DA6:                                              ; CODE XREF: Sound_SetMusicPaused+AE   j
                moveq   #5,d4
loc_83DA8:                                              ; CODE XREF: Sound_SetMusicPaused:loc_83E02   j
                adda.w  d3,a5
                btst    #0,(a5)
                beq.s   loc_83E02
                bset    #7,(a5)
                bclr    #0,(a5)
                btst    #2,(a5)
                bne.s   loc_83E02
                move.b  $27(a5),d1
                cmpi.b  #6,1(a5)
                bne.w   loc_83DFA
                move    sr,-(sp)
                ori     #$700,sr
                move.w  #$100,(IO_Z80BUS).l
loc_83DDA:                                              ; CODE XREF: Sound_SetMusicPaused+F4   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_83DDA
                move.b  (byte_A01FFD).l,d0
                move.w  #0,(IO_Z80BUS).l
                move    (sp)+,sr
                tst.b   d0
                bne.w   loc_83E02
loc_83DFA:                                              ; CODE XREF: Sound_SetMusicPaused+DA   j
                move.b  #$B4,d0
                jsr     Sound_ProcessChannelBits(pc)    ; (pc)
loc_83E02:                                              ; CODE XREF: Sound_SetMusicPaused+C0   j
                                        ; Sound_SetMusicPaused+CE   j
                dbf     d4,loc_83DA8
                moveq   #2,d4
loc_83E08:                                              ; CODE XREF: Sound_SetMusicPaused:loc_83E18   j
                adda.w  d3,a5
                btst    #0,(a5)
                beq.s   loc_83E18
                bset    #7,(a5)
                bclr    #0,(a5)
loc_83E18:                                              ; CODE XREF: Sound_SetMusicPaused+120   j
                dbf     d4,loc_83E08
                movea.l a3,a5
                rts
; End of function Sound_SetMusicPaused
; Sets the tick multiplier for all ten sound channels (FF 02)
Sound_SetAllTickMultipliers:                            ; CODE XREF: Sound_ExtendedCommandDispatch+12   j  ; was: sub_83E20
                lea     (byte_FFF840).w,a0
                move.b  (a4)+,d0
                moveq   #$30,d1                         ; '0'
                moveq   #9,d2
loc_83E2A:                                              ; CODE XREF: Sound_SetAllTickMultipliers+10   j
                move.b  d0,2(a0)
                adda.w  d1,a0
                dbf     d2,loc_83E2A
                rts
; End of function Sound_SetAllTickMultipliers
; Initializes fade parameters if not already active, stores fade in/out values
Sound_InitializeFadeParams:                             ; CODE XREF: Sound_ExtendedCommandDispatch+16   j  ; was: sub_83E36
                tst.b   (byte_FFF828).w
                beq.w   loc_83E42
                addq.w  #2,a4
                rts
; ---------------------------------------------------------------------------
loc_83E42:                                              ; CODE XREF: Sound_InitializeFadeParams+4   j
                move.b  #1,(byte_FFF828).w
                move.b  (byte_FFF829).w,d0
                or.b    (byte_FFF82A).w,d0
                bne.w   locret_83E5C
                move.b  (a4)+,(byte_FFF829).w
                move.b  (a4)+,(byte_FFF82A).w
locret_83E5C:                                           ; CODE XREF: Sound_InitializeFadeParams+1A   j
                rts
; End of function Sound_InitializeFadeParams
; Checks if fade state is 2 and sets to $80 to mark completion
Sound_CheckFadeComplete:                                ; CODE XREF: Sound_ExtendedCommandDispatch+1A   j  ; was: sub_83E5E
                cmpi.b  #2,(byte_FFF828).w
                bne.w   locret_83E6E
                move.b  #$80,(byte_FFF828).w
locret_83E6E:                                           ; CODE XREF: Sound_CheckFadeComplete+6   j
                rts
; End of function Sound_CheckFadeComplete
; ---------------------------------------------------------------------------
z80_data:       binclude "data/sound/z80_data.bin"
z80_data_End:

; Sets FM synthesis frequency for channel
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
word_84C18:     dc.w    $356, $326, $2F9                ; DATA XREF: Sound_ProcessNoteData+10   o
                dc.w    $2CE, $2A5, $280
                dc.w    $25C, $23A, $21A
                dc.w    $1FB, $1DF, $1C4
                dc.w    $1AB, $193, $17D
                dc.w    $167, $153, $140
                dc.w    $12E, $11D, $10D
                dc.w    $FE, $EF, $E2
                dc.w    $D6, $C9, $BE
                dc.w    $B4, $A9, $A0
                dc.w    $97, $8F, $87
                dc.w    $7F, $78, $71
                dc.w    $6B, $65, $5F
                dc.w    $5A, $55, $50
                dc.w    $4B, $47, $43
                dc.w    $40, $3C, $39
                dc.w    $36, $33, $30
                dc.w    $2D, $2B, $28
                dc.w    $26, $24, $22
                dc.w    $20, $1F, $1D
                dc.w    $1B, $1A, $18
                dc.w    $17, $16, $15
                dc.w    $13, $12, $11
                dc.w    0
SoundDataPointerTable:
                dc.l    SoundPriorityTable
                dc.l    SpecialSFX_PointerTable
                dc.l    BGM_PointerTable
                dc.l    SFX_PointerTable
                dc.l    ModulationEnvelopePointerTable
                dc.l    PSGVolumeEnvelopePointerTable
                dc.l    $A0
                dc.l    Sound_UpdateDriver              ; debug this
                dc.l    SFX_40_7F_PointerTable
ModulationEnvelopePointerTable: dc.l    ModulationEnvelope_1  ; DATA XREF: Sound_ApplyPitchEffects+C   o
                                        ; ROM:00084CB4   o
                dc.l    ModulationEnvelope_2
                dc.l    ModulationEnvelope_3
                dc.l    ModulationEnvelope_4
                dc.l    ModulationEnvelope_5
                dc.l    ModulationEnvelope_6
                dc.l    ModulationEnvelope_7
                dc.l    ModulationEnvelope_8
ModulationEnvelope_1:   dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E, $F
                                        ; DATA XREF: ROM:ModulationEnvelopePointerTable   o
                dc.b    $10, $11, $12, $13, $14, $83
ModulationEnvelope_2:   dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E, $F
                                        ; DATA XREF: ROM:00084CCC   o
                dc.b    $10, $11, $12, $13, $14, $80
ModulationEnvelope_3:   dc.b    $D8, $E2, $EC, $F6, 0, $A, $14, $1E, $28, $83
                                        ; DATA XREF: ROM:00084CD0   o
ModulationEnvelope_4:   dc.b    $D8, $E2, $EC, $F6, 0, $A, $14, $1E, $28, $80
                                        ; DATA XREF: ROM:00084CD4   o
ModulationEnvelope_6:   dc.b    4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084CDC   o
ModulationEnvelope_5:   dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084CD8   o
                dc.b    1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
                dc.b    3, 3, 3, 3, 3, 3, 3, 3, 4, $83
ModulationEnvelope_7:   dc.b    2, $83                  ; DATA XREF: ROM:00084CE0   o
ModulationEnvelope_8:   dc.b    0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2
                                        ; DATA XREF: ROM:00084CE4   o
                dc.b    3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6
                dc.b    6, 6, 6, 6, 7, 7, 7, $83
PSGVolumeEnvelopePointerTable:  dc.l    PSGVolumeEnvelope_1  ; DATA XREF: Sound_ProcessFMModulation+14   o
                                        ; ROM:00084CB8   o
                dc.l    PSGVolumeEnvelope_2
                dc.l    PSGVolumeEnvelope_3
                dc.l    PSGVolumeEnvelope_4
                dc.l    PSGVolumeEnvelope_5
                dc.l    PSGVolumeEnvelope_6
                dc.l    PSGVolumeEnvelope_7
                dc.l    PSGVolumeEnvelope_8
                dc.l    PSGVolumeEnvelope_9
                dc.l    PSGVolumeEnvelope_10
PSGVolumeEnvelope_1:    dc.b    0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5
                                        ; DATA XREF: ROM:PSGVolumeEnvelopePointerTable   o
                dc.b    5, 5, 6, 6, 6, 7, $83
PSGVolumeEnvelope_2:    dc.b    0, 2, 4, 6, 8, $10, $83
                                        ; DATA XREF: ROM:00084D90   o
PSGVolumeEnvelope_3:    dc.b    0, 0, 1, 1, 3, 3, 4, 5, $83
                                        ; DATA XREF: ROM:00084D94   o
PSGVolumeEnvelope_4:    dc.b    0, 0, 2, 3, 4, 4, 5, 5, 5, 6, $83
                                        ; DATA XREF: ROM:00084D98   o
PSGVolumeEnvelope_6:    dc.b    4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084DA0   o
PSGVolumeEnvelope_5:    dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084D9C   o
                dc.b    1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
                dc.b    3, 3, 3, 3, 3, 3, 3, 3, 4, $83
PSGVolumeEnvelope_7:    dc.b    2, $83                  ; DATA XREF: ROM:00084DA4   o
PSGVolumeEnvelope_8:    dc.b    0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2
                                        ; DATA XREF: ROM:00084DA8   o
                dc.b    3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6
                dc.b    6, 6, 6, 6, 7, 7, 7, $83
PSGVolumeEnvelope_9:    dc.b    8, 8, 7, 7, 7, 7, 6, 6, 6, 6, 5, 5, 5, 5, 4, 4
                                        ; DATA XREF: ROM:00084DAC   o
                dc.b    4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 0, $81
PSGVolumeEnvelope_10:   dc.b    8, 7, 6, 5, 4, 3, 3, 2, 2, 1, 1, 0, $81, 0
                                        ; DATA XREF: ROM:00084DB0   o
BGM_PointerTable:   dc.l    runnerad2025                ; DATA XREF: Sound_ProcessDAC+16   o
                                        ; ROM:00084CAC   o
                dc.l    blacksheep
                dc.l    over
                dc.l    fromobjectornointro
                dc.l    withtreasure
                dc.l    shade
                dc.l    sidelimits
                dc.l    flashback
                dc.l    soltype
                dc.l    fromobjector
                dc.l    epsilonsally
                dc.l    lurk
                dc.l    perfectthing
                dc.l    slapup
                dc.l    xages
                dc.l    theend
                dc.l    titletheme
                dc.l    silent
                dc.l    galaxydesert
                dc.l    soldierssong
                dc.l    alonezvariation
                dc.l    seventhforce
                dc.l    threeprayers
                dc.l    alonez
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    runnerad2025
                dc.l    specialsfxtrack
SoundPriorityTable: dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                                        ; DATA XREF: Sound_ProcessFade   o
                                        ; ROM:00084CA4   o
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $55, $5A, $52, $53, $4E, $5B, $5B, $5A, $53, $54, $53, $5A, $5A, $53, $5B, $5A
                dc.b    $54, $5B, $50, $50, $5C, $5A, $53, $53, $5A, $53, $60, $50, $50, $50, $50, $50
                dc.b    $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50
                dc.b    $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $5B, $50, $50, $50, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $55
                dc.b    $5A, $50, $5A, $54, $55, $52, $59, $52, $53, $55, $5A, $5A, $4F, $52, $50, $4F
                dc.b    $40, $53, $45, $45, $45, $45, $54, $60, $4E, $45, $5B, $5B, $5A, $5A, $45, $52
                dc.b    $60, $52, $53, $5A, $50, $53, $50, $51, $50, $60, $54, $53, $50, $53, $50, $53
                dc.b    $53, $60, $45, $60, $5A, $40, $5A, $45, $54, $5A, $45, $50, $50, $46, $46, $5B
                dc.b    $59, $54, $54, $5B, $5B, $5A, $5A, $54, $54, $54, $45, $52, $53, $53, $50, $5B
                dc.b    $55, $55, $55, $5B, $5B, $5B, $5B, $5B, $FF, $FF, $FF, $FF, $FF, $FF
SFX_PointerTable:   dc.l    SFX_A0                      ; DATA XREF: Sound_LoadSFX:loc_830C6   o
                                        ; sub_830BC:loc_830DC   o
                dc.l    SFX_A1
                dc.l    SFX_A2
                dc.l    SFX_A3
                dc.l    SFX_A4
                dc.l    SFX_A5
                dc.l    SFX_A6
                dc.l    SFX_A7
                dc.l    SFX_A8
                dc.l    SFX_A9
                dc.l    SFX_AA
                dc.l    SFX_AB
                dc.l    SFX_AC
                dc.l    SFX_AD
                dc.l    SFX_AE
                dc.l    SFX_AF
                dc.l    SFX_B0
                dc.l    SFX_B1
                dc.l    SFX_B2
                dc.l    SFX_B3
                dc.l    SFX_B4
                dc.l    SFX_B5
                dc.l    SFX_B6
                dc.l    SFX_B7
                dc.l    SFX_B8
                dc.l    SFX_B9
                dc.l    SFX_BA
                dc.l    SFX_BB
                dc.l    SFX_BC
                dc.l    SFX_BD
                dc.l    SFX_BE
                dc.l    SFX_BF
                dc.l    SFX_C0
                dc.l    SFX_C1
                dc.l    SFX_C2
                dc.l    SFX_C3
                dc.l    SFX_C4
                dc.l    SFX_C5
                dc.l    SFX_C6
                dc.l    SFX_C7
                dc.l    SFX_C8
                dc.l    SFX_C9
                dc.l    SFX_CA
                dc.l    SFX_CB
                dc.l    SFX_CC
                dc.l    SFX_CD
                dc.l    SFX_CE
                dc.l    SFX_CF
                dc.l    SFX_D0
                dc.l    SFX_D1
                dc.l    SFX_D2
                dc.l    SFX_D3
                dc.l    SFX_D4
                dc.l    SFX_D5
                dc.l    SFX_D6
                dc.l    SFX_D7
                dc.l    SFX_D8
                dc.l    SFX_D9
                dc.l    SFX_DA
                dc.l    SFX_DB
                dc.l    SFX_DC
                dc.l    SFX_DD
                dc.l    SFX_DE
                dc.l    SFX_DF
                dc.l    SFX_E0
                dc.l    SFX_E1
                dc.l    SFX_E2
                dc.l    SFX_E3
                dc.l    SFX_E4
                dc.l    SFX_E5
                dc.l    SFX_E6
                dc.l    SFX_E7
                dc.l    SFX_E8
                dc.l    SFX_E9
                dc.l    SFX_EA
                dc.l    SFX_EB
                dc.l    SFX_EC
                dc.l    SFX_ED
                dc.l    SFX_EE
                dc.l    SFX_EF
                dc.l    SFX_F0
                dc.l    SFX_F1
                dc.l    SFX_F2
                dc.l    SFX_F3
                dc.l    SFX_F4
                dc.l    SFX_F5
                dc.l    SFX_F6
                dc.l    SFX_F7
                dc.l    SFX_F8
SpecialSFX_PointerTable:    dc.l    SFX_F9              ; DATA XREF: Sound_LoadSpecialSFX:loc_831E0   o
                                        ; ROM:00084CA8   o
                dc.l    SFX_FA
                dc.l    SFX_FB
                dc.l    SFX_FC
SFX_40_7F_PointerTable: dc.l    SFX_40                  ; DATA XREF: ROM:00084CC4   o
                dc.l    SFX_41
                dc.l    SFX_42
                dc.l    SFX_43
                dc.l    SFX_44
                dc.l    SFX_45
                dc.l    SFX_46
                dc.l    SFX_47
                dc.l    SFX_48
                dc.l    SFX_49
                dc.l    SFX_4A
                dc.l    SFX_4B
                dc.l    SFX_4C
                dc.l    SFX_4D
                dc.l    SFX_4E
                dc.l    SFX_4F
                dc.l    SFX_50
                dc.l    SFX_51
                dc.l    SFX_52
                dc.l    SFX_53
                dc.l    SFX_54
                dc.l    SFX_55
                dc.l    SFX_56
                dc.l    SFX_57
                dc.l    SFX_58
                dc.l    SFX_59
                dc.l    SFX_5A
                dc.l    SFX_5B
                dc.l    SFX_5C
                dc.l    SFX_5D
                dc.l    SFX_5E
                dc.l    SFX_5F
                dc.l    SFX_60
                dc.l    SFX_61
                dc.l    SFX_62
                dc.l    SFX_63
                dc.l    SFX_64
                dc.l    SFX_65
                dc.l    SFX_66
                dc.l    SFX_67
                dc.l    SFX_68
                dc.l    SFX_69
                dc.l    SFX_6A
                dc.l    SFX_6B
                dc.l    SFX_6C
                dc.l    SFX_6D
                dc.l    SFX_6E
                dc.l    SFX_6F
                dc.l    SFX_70
                dc.l    SFX_71
                dc.l    SFX_72
                dc.l    SFX_73
                dc.l    SFX_74
                dc.l    SFX_75
                dc.l    SFX_76
                dc.l    SFX_77
                dc.l    SFX_78
                dc.l    SFX_79
                dc.l    SFX_7A
                dc.l    SFX_7B
                dc.l    SFX_7C
                dc.l    SFX_7D
                dc.l    SFX_7E
                dc.l    SFX_7F
runnerad2025:           binclude "data/sound/runnerad2025.bin"
runnerad2025_End:
blacksheep:             binclude "data/sound/blacksheep.bin"
blacksheep_End:
over:                   binclude "data/sound/over.bin"
over_End:
fromobjectornointro:    binclude "data/sound/fromobjectornointro.bin"
fromobjectornointro_End:
withtreasure:           binclude "data/sound/withtreasure.bin"
withtreasure_End:
shade:                  binclude "data/sound/shade.bin"
shade_End:
sidelimits:             binclude "data/sound/sidelimits.bin"
sidelimits_End:
flashback:              binclude "data/sound/flashback.bin"
flashback_End:
soltype:                binclude "data/sound/soltype.bin"
soltype_End:
fromobjector:           binclude "data/sound/fromobjector.bin"
fromobjector_End:
epsilonsally:           binclude "data/sound/epsilonsally.bin"
epsilonsally_End:
lurk:                   binclude "data/sound/lurk.bin"
lurk_End:
perfectthing:           binclude "data/sound/perfectthing.bin"
perfectthing_End:
slapup:                 binclude "data/sound/slapup.bin"
slapup_End:
xages:                  binclude "data/sound/xages.bin"
xages_End:
theend:                 binclude "data/sound/theend.bin"
theend_End:
titletheme:             binclude "data/sound/titletheme.bin"
titletheme_End:
silent:                 binclude "data/sound/silent.bin"
silent_End:
galaxydesert:           binclude "data/sound/galaxydesert.bin"
galaxydesert_End:
soldierssong:           binclude "data/sound/soldierssong.bin"
soldierssong_End:
alonezvariation:        binclude "data/sound/alonezvariation.bin"
alonezvariation_End:
seventhforce:           binclude "data/sound/seventhforce.bin"
seventhforce_End:
threeprayers:           binclude "data/sound/threeprayers.bin"
threeprayers_End:
alonez:                 binclude "data/sound/alonez.bin"
alonez_End:
specialsfxtrack:        binclude "data/sound/specialsfxtrack.bin"
specialsfxtrack_End:
SFX_A0:                 dc.b    0, $34, 1, 2, $80, 4, 0, $10, 0, 0, $80, $C0, 0, $22, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $FC, $FF, $96, 3, $80, 1, $EF, 1, $85
                                        ; DATA XREF: ROM:SFX_PointerTable   o
                dc.b    $40, $F2, $80, 1, $F5, 0, $F3, $E7, $F0, 0, 1, 1, $FF, $96, 3, $80, 1, $C0, $40, $F2, $35, 1, $40, 0, 0, $1F, $1F, $1E, $1F, $F, $1F, $1F
                dc.b    $1F, $1F, $C, 0, 0, $1F, $F, $F, $F, 6, $80, $80, $80, $39, $2D, $41, $17, $7F, $1F, $1F, $1E, $1F, $1F, $1F, $1F, $A, $D, $10, $D, $D, $1F, $F
                dc.b    $F, $3F, 3, 9, 5, $80
SFX_A1:         dc.b    0, $32, 1, 2, $80, 5, 0, $10, $FD, 1, $80, 4, 0, $21, 0, 2, $EF, 0, $F0, 0, 2, $93, $FF, $A1, $A, $E6, 4, $F7, 0, 8, $FF, $F8
                                        ; DATA XREF: ROM:00084FF6   o
                dc.b    $F2, $EF, 1, $F0, 0, 1, $35, 5, $98, $A, $E6, 5, $F7, 0, 8, $FF, $F8, $F2, $3A, 5, $73, $B, 1, $1F, $1F, $1F, $1F, $12, $1F, $1F, $1F, $A
                dc.b    $D, 0, 0, $1F, $F, $F, $F, $C, $10, 2, $80, $38, $41, $31, $63, $32, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0, $10, $15, 0, $3F, $1F, $F, $F
                dc.b    $1B, 0, 0, $80
SFX_A2:         dc.b    0, $11, 1, 1, $80, 5, 0, $A, $1A, $E, $EF, 0, $A7, 1, $B1, $C, $F2, $1C, $3A, $31, $7A, $71, $14, $1F, $1F, $1E, $1F, $C, $1A, $C, $1E, $14
                                        ; DATA XREF: ROM:00084FFA   o
                dc.b    $12, $14, $17, $1F, $19, $1F, $20, $80, $16, $80
SFX_A3:         dc.b    0, $2D, 1, 1, $80, 5, 0, $A, 0, 3, $EF, 0, $D1, 2, $E7, $BC, $A5, 1, $AC, $A9, $AC, $E6, 1, $FB, 4, $F7, 0, 6, $FF, $F3, $A5, 1
                                        ; DATA XREF: ROM:00084FFE   o
                dc.b    $AC, $A9, $AC, $E6, 2, $FB, 4, $F7, 0, 6, $FF, $F3, $F2, $3A, 4, $31, $71, 3, $1F, $1F, $1F, $1F, $1E, $17, $16, $1F, 0, $E, 0, 0, $1F, $2F
                dc.b    $1F, $F, $1D, $24, $18, 0
SFX_A4:         dc.b    0, $32, 1, 2, $80, 4, 0, $10, 0, 0, $80, $C0, 0, $21, 0, 0, $EF, 0, $F0, 0, 1, $35, 5, $98, $A, $E6, 5, $F7, 0, 8, $FF, $F8
                                        ; DATA XREF: ROM:00085002   o
                dc.b    $F2, $F3, $E7, $F0, 0, 4, 4, $FF, $B7, $A, $EC, 1, $F7, 0, 8, $FF, $F8, $F2, $38, $41, $31, $63, $32, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0
                dc.b    0, $14, 0, $1F, $1F, $F, $F, $1B, 0, 0, $80, 0
SFX_A5:         dc.b    0, $3F, 1, 2, $80, 5, 0, $10, 0, 1, $80, 4, 0, $21, 0, 1, $EF, 0, $F0, 0, 1, $C0, $FF, $90, 3, $80, 1, $EF, 1, $FD, $C0, $7F
                                        ; DATA XREF: ROM:00085006   o
                dc.b    $F2, $EF, 0, $E1, $1E, $F0, 0, 1, $C0, $FF, $90, 3, $80, 1, $EF, 2, $F0, 0, 1, $10, $FF, $A0, $10, $E6, 5, $F7, 0, 8, $FF, $F3, $F2, $39
                dc.b    0, $11, 0, $F, $1F, $1F, $1F, $1F, $1F, 1, $18, $1C, $13, 0, 0, 2, $6F, $1F, $F, $D, $B, 9, 0, $80, $39, $79, $31, 1, $3F, $1F, $1F, $E
                dc.b    $1F, $1F, 1, $18, 6, 7, $D, 8, $A, $7F, $1F, $F, $1D, $2B, $27, $10, $80, $39, $73, $31, $33, $4F, $1F, $1F, $1F, $1F, $1F, 1, $18, 6, 7, $D
                dc.b    0, $A, $7F, $F, $F, $1D, $B, $17, 0, $80
SFX_A6:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 3, $EF, 0, $B4, 1, $F0, 0, 1, $49, $FF, $B1, $10, $E6, $11, $F7, 0, 2, $FF, $F8, $F2, $38, 0, 3
                                        ; DATA XREF: ROM:0008500A   o
                dc.b    $10, $70, $12, $12, $1F, $1F, $15, $16, $19, $1F, $16, 9, 2, 5, $11, $F, $1F, $F, $1B, $1D, 0, $80
SFX_A7:         dc.b    0, $2B, 1, 2, $80, 5, 0, $10, 0, 7, $80, $C0, 0, $28, 0, 7, $EF, 1, $F0, 0, 1, $30, $FF, $BA, 1, $C6, 2, $BB, 3, $C7, 4, $BC
                                        ; DATA XREF: ROM:0008500E   o
                dc.b    5, $C8, 6, $BD, 7, $C9, $F, $F2, $80, $2B, $F2, $3C, $54, $77, $12, $21, $1F, $1F, $1F, $1F, $1F, $1F, $15, $13, $F, 7, $11, 7, $56, $19, $11, $19
                dc.b    $F, $80, $28, $80, $3C, $5F, $71, $1D, $22, $1F, $1F, $1F, $1F, $1F, $1F, $15, $13, $C, 0, $11, 2, $B6, $19, $11, $19, $13, $80, $14, $80, 0
SFX_A8:         dc.b    0, $21, 1, 1, $80, 5, 0, $A, 0, 4, $EF, 0, $F0, 0, 1, $A, $FF, $B9, 2, $80, 2, $EF, 1, $B9, 7, $E6, $30, $F7, 0, 2, $FF, $F2
                                        ; DATA XREF: ROM:00085012   o
                dc.b    $F2, 0, $3B, 0, 0, $72, $1F, $1F, $1F, $1F, $F, $1F, $1F, $F, 5, $13, 6, $A, $2F, $F, $F, $1F, $2E, 7, $11, $80, $39, $40, $B, 0, $76, $1F
                dc.b    $F, $1F, $1F, $1F, $1F, $1F, $1F, $17, 1, $D, $B, $2F, $1F, $F, $F, $15, $14, $A, $80, 0
SFX_A9:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 4, $80, 1, $EF, 0, $F0, 0, 1, $1D, $FF, $8C, $12, $E6, $1A, $F7, 0, 2, $FF, $F8, $F2, $3A, $21, $31
                                        ; DATA XREF: ROM:00085016   o
                dc.b    $10, $30, $1B, $11, $1C, $16, $14, $1F, $1F, $1F, 2, $E, 6, 0, $3F, $1A, 9, $F, $15, 0, $12, $80
SFX_AA:         binclude "data/sound/SFX_AA.bin"
SFX_AA_End:
SFX_AB:         dc.b    0, $37, 1, 2, $80, 5, 0, $10, $F0, $A, $80, $C0, 0, $2B, 0, 0, $EF, 0, $F0, 0, 1, $AB, $FF, $CA, 9, $80, 1, $F0, 0, 1, $3C, $FF
                                        ; DATA XREF: ROM:0008501E   o
                dc.b    $C7, $A, $E7, $F0, 0, 2, $3C, $FF, $D0, $20, $F2, $F3, $E7, $80, $A, $F0, 0, 1, 3, $FF, $B4, $2C, $F2, $3B, $30, 0, 0, $7F, $11, $1F, $1F, $1F
                dc.b    $12, $1E, $1E, $1F, $15, 8, 0, 0, $1F, $F, $F, $F, $B, 3, $D, $80, $3B, $30, 0, 0, $7F, $11, $1F, $1F, $1F, $12, $1E, $1E, $1F, $15, 6, 0
                dc.b    0, $1F, $F, $F, $F, $D, 8, $D, $80, 0
SFX_AC:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $8C, 6, $89, $20, $F2, $3A, $B, $12, 0, $2F, $11, $15, $1C, $1F, $1F
                                        ; DATA XREF: ROM:00085022   o
                dc.b    $1F, $E, 7, $B, 8, 0, $C, $F, $F, 2, $1F, $16, $1D, $10, $80, 0
SFX_AD:         dc.b    0, $1C, 1, 1, $80, 5, 0, $A, 3, $C, $80, 1, $EF, 0, $B8, 1, $EF, 1, $BA, 5, $E6, $25, $F7, 0, 2, $FF, $F0, $F2, $39, 1, 1, 1
                                        ; DATA XREF: ROM:00085026   o
                dc.b    1, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0, 0, 0, 0, $F, $F, $F, $F, $20, $10, $20, $80, $3C, $32, $72, $78, $32, $1F, $1F, $1F, $1F, $1F, $1F
                dc.b    $1F, $1F, $10, 0, 0, 0, $1F, $F, $F, $F, $1D, $80, $23, $80
SFX_AE:         dc.b    0, $24, 1, 1, $80, 5, 0, $A, 0, 4, $EF, 0, $F0, 0, 1, $7D, $FF, $96, 5, $EF, 1, $F0, 0, 1, $CD, $FF, $A4, 9, $E6, $21, $F7, 0
                                        ; DATA XREF: ROM:0008502A   o
                dc.b    2, $FF, $F8, $F2, $3B, $31, 0, $12, $22, $1E, $1F, $1F, $1B, $1F, $1E, $19, $1F, $13, $A, 0, 0, $3F, $1F, $F, $F, 4, 0, $18, $80, $38, $3C, $50
                dc.b    $60, $19, $1F, $1F, $1F, $1F, $1F, $1E, $19, $1F, $10, 0, 0, 0, $1F, $F, $1F, $F, $19, $F, $10, $80
SFX_AF:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 6, $F0, 0, 1, $96, $FF, $EF, 0, $A0, 3, $EF, 1, $90, 3, $F7, 0, 3, $FF, $FA, $F2, 8, 1, $64
                                        ; DATA XREF: ROM:0008502E   o
                dc.b    $17, $42, $1F, $1F, $1F, $1F, $18, $1F, $14, $1F, $1B, $14, $13, 0, $1F, $15, $18, $F, $15, $13, 4, $80, 8, 2, $62, 0, $4A, $1F, $1F, $1F, $1F, $18
                dc.b    $1F, $14, $1F, $15, $16, 1, 0, $6F, $15, 8, $F, 5, $10, 0, $80, 8, 2, $60, $10, $41, $1F, $1F, $1F, $1F, $18, $1F, $14, $1F, $12, $14, 0, 0
                dc.b    $1F, $15, $28, $F, $15, $13, 0, $80
SFX_B0:         dc.b    0, $1C, 1, 1, $80, 5, 0, $A, 0, 1, $80, 1, $EF, 0, $F0, 0, 1, $F1, $FF, $96, 3, $80, 1, $EF, 1, $84, $20, $F2, $35, 1, $40, 0
                                        ; DATA XREF: ROM:00085032   o
                dc.b    0, $1F, $1F, $1E, $1F, $F, $1F, $1F, $1F, $1F, $C, 0, 0, $1F, $F, $F, $F, 6, $80, $80, $80, $39, $26, $30, $12, $78, $1F, $1F, $17, $1F, $1F, $F
                dc.b    $F, $B, $E, 0, $E, 8, $F, $1F, $F, $1F, $D, $19, 0, $80
SFX_B1:         dc.b    0, $19, 1, 1, $80, 5, 0, $A, 0, 7, $EF, 0, $9D, 2, $80, 2, $A9, 4, $80, 1, $E6, $1C, $A9, 5, $F2, $38, 4, 1, 2, $17, $1F, $1F
                                        ; DATA XREF: ROM:00085036   o
                dc.b    $1F, $1F, $1F, $1F, $11, $F, $11, $11, 0, $B, $1F, $1F, $4F, $1F, $21, $E, 1, $80, $38, 2, 0, 1, 6, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $15, $B
                dc.b    $10, $12, $B, $1F, $2F, $2F, $1F, $12, $C, 0, $80, 0
SFX_B2:         dc.b    0, $1E, 1, 1, $80, 5, 0, $A, 0, 0, $80, 4, $EF, 0, $A8, 7, $80, 1, $EF, 1, $B5, 8, $E6, 6, $F7, 0, 4, $FF, $F8, $F2, $3D, $79
                                        ; DATA XREF: ROM:0008503A   o
                dc.b    $33, 1, 9, $1E, $F, $F, $F, $D, $1F, $17, $1F, 4, 0, 0, 0, $1F, $F, $F, $F, $D, $80, $80, $80, $38, $71, $10, 8, $3F, $1F, $1F, $1F, $1F
                dc.b    $1C, $1F, $17, $1B, 1, 1, 8, 0, $12, 2, 2, 8, $10, $26, $F, $80
SFX_B3:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, $FD, $B, $EF, 0, $C6, 1, $CC, 6, $E6, $20, 4, $F2, $1B, $24, 1, 1, $1A, $1F, $1F, $1F, $1F, $1F, $1F, $1E
                                        ; DATA XREF: ROM:0008503E   o
                dc.b    $1F, 0, 6, $10, 0, $12, $12, 2, $F, $10, $2D, 0, $80, 0
SFX_B4:         dc.b    0, $1B, 1, 1, $80, 5, 0, $A, $C, 6, $EF, 0, $F0, 0, 0, $20, 4, $AB, $12, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $38, $70, 0, 0, $3F
                                        ; DATA XREF: ROM:00085042   o
                dc.b    $18, $1F, $1F, $1F, $1C, $1E, $1F, $1F, $10, 0, 4, 0, $1F, $F, $F, $F, $1D, $12, 0, $80, $38, $10, 5, $7F, $3F, $16, $1F, $1F, $1F, $1C, $1E, $1F
                dc.b    $1F, $14, $F, 7, 0, $1F, $F, $F, $F, $3E, $E, 6, $80, $38, $70, 0, 1, $3F, $10, $1F, $1F, $1F, $1C, $E, $17, $1F, $10, $10, 0, 0, $1F, $1F
                dc.b    $1F, $F, $20, $15, 6, $80
SFX_B5:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, 9, $EF, 0, $F0, 0, 1, $D4, $FF, $9D, 4, $F2, $3A, $70, $31, $10, 2, $1F, $1F, $1F, $1F, $19, $1F, $1F
                                        ; DATA XREF: ROM:00085046   o
                dc.b    $1F, $18, $12, 2, 3, $F, $F, $F, $F, $31, $13, $D, $80, $3A, $70, $30, $13, 2, $1F, $1F, $1F, $1F, $19, $1F, $1F, $1F, 8, 3, $14, 3, $F, $F
                dc.b    $F, $F, $21, $10, 0, $80, $3B, $71, $31, $10, 7, $1F, $1F, $12, $1F, $19, $1F, $1F, $1F, $D, 1, $12, 6, $1F, $1F, $1F, $F, $16, 8, 5, $80, 0
SFX_B6:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, $A, $EF, 0, $F0, 0, 2, $8E, $FF, $98, 5, $F2, $38, 2, 2, 1, $37, $1F, $1F, $10, $16, $18, $19, $13
                                        ; DATA XREF: ROM:0008504A   o
                dc.b    $1F, $1A, 0, $15, 2, $1F, $F, $1F, $F, $10, $16, 6, $80, 0
SFX_B7:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 2, $80, 1, $EF, 0, $F0, 1, 1, $70, 1, $88, $1C, $80, 2, $F2, $3A, $61, $10, $6F, $10, $F, $1F, $1F
                                        ; DATA XREF: ROM:0008504E   o
                dc.b    $F, $1F, $1F, $19, 9, $10, 0, 0, $C, $1F, $F, $1F, $F, $10, 1, 0, $80, 0
SFX_B8:         dc.b    0, $5B, 1, 3, $80, 4, 0, $16, 0, 0, $80, 5, 0, $2D, 0, 0, $80, $C0, 0, $3D, 0, 0, $EF, 1, $83, 6, $80, 2, $EF, 0, $F0, 0
                                        ; DATA XREF: ROM:00085052   o
                dc.b    0, $C1, $FF, $8E, 6, $E6, 3, $F7, 0, $10, $FF, $F8, $F2, $EB, $2F, $83, 6, $80, 2, $80, $12, $E6, 6, $F7, 0, 5, $FF, $F8, $F2, $F3, $E7, $A3
                dc.b    6, $80, 2, $F0, 0, 4, 4, $FF, $C2, 6, $E7, $F7, 0, $A, $FF, $F9, $EC, 1, $C2, $10, $E7, $F7, 0, 5, $FF, $F7, $F2, $40, 3, 0, $11, $31
                dc.b    $1F, $1F, $1F, $1F, $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30, $F, $F, $12, $13, $10, $80, $42, $70, 2, $10, $5F, $1F, $1F, $1F, $1F, $1E, $10, $1D
                dc.b    $1A, $1D, $B, $12, $11, $1F, $2F, $F, $9F, $15, $18, $17, $80, $40, 2, 0, $14, $35, $1F, $1F, $1F, $1F, $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30
                dc.b    $F, $F, $12, $13, $10, $80
SFX_B9:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 4, $EF, 0, $F0, 1, 1, $28, $2C, $9C, 7, $80, 1, $EF, 1, $A0, 7, $E6, $1C, 6, $F2, $3A, $71, $77
                                        ; DATA XREF: ROM:00085056   o
                dc.b    $30, $30, $1F, $13, $1A, $1F, $1F, $1F, $1F, $1F, $10, $15, 4, $C, $1F, $1F, $F, $F, $1F, $10, $18, $80, $3A, $71, $10, 1, $32, $1F, $12, $10, $1F, $1F
                dc.b    $1F, $1F, $1F, $12, 9, $10, 0, $1F, $F, $F, $F, $1D, $24, 5, $80, 0
SFX_BA:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, $C, $EF, 0, $F0, 0, 2, $8E, $FF, $98, 5, $F2, $38, 0, 2, 0, $31, $F, $F, $F, $16, $18, $19, 0
                                        ; DATA XREF: ROM:0008505A   o
                dc.b    $1F, $A, 0, 0, 2, $3F, $1F, $1F, $F, $22, $14, $10, $80, 0
SFX_BB:         dc.b    0, $42, 1, 2, $80, 4, 0, $10, 0, 0, $80, $C0, 0, $2C, 0, 1, $EF, 0, $F0, 0, 1, $9B, $FF, $A8, 3, $80, 1, $EF, 1, $F0, 0, 1
                                        ; DATA XREF: ROM:0008505E   o
                dc.b    $93, $FF, $94, 5, $E6, 5, $F7, 0, 9, $FF, $F8, $F2, $F3, $E7, $F0, 0, 2, 2, $FF, $B1, 3, $80, 1, $BA, 8, $E7, $EC, 1, $F7, 0, 6, $FF
                dc.b    $F7, $F2, $38, 0, 0, 0, $33, $1F, $1F, $1F, $1F, $15, $19, $1B, $1F, $10, $12, 0, 0, $1F, $3F, $F, $F, $27, $10, 8, $80, $28, $71, 1, $52, $59
                dc.b    $1F, $1F, $1F, $1F, $1E, $1B, $1F, $1F, 9, $10, 0, 0, $1F, $2F, $3F, $F, 0, $11, 0, $80
SFX_BC:         dc.b    0, $45, 1, 2, $80, 4, 0, $10, 0, 0, $80, $C0, 0, $27, 0, 0, $EF, 1, $83, 6, $80, 2, $EF, 0, $F0, 0, 0, $C1, $FF, $8E, $12, $E6
                                        ; DATA XREF: ROM:00085062   o
                dc.b    6, $F7, 0, 5, $FF, $F8, $F2, $F3, $E7, $A3, 6, $80, 2, $F0, 0, 4, 4, $FF, $C2, 6, $E7, $F7, 0, $A, $FF, $F9, $EC, 1, $C2, 6, $E7, $F7
                dc.b    0, 5, $FF, $F7, $F2, $40, 3, 0, $11, $31, $1F, $1F, $1F, $1F, $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30, $F, $F, $12, $13, $10, $80, $40, $72
                dc.b    2, $11, $5A, $1F, $1F, $1A, $1F, $1E, $10, $1D, $1F, 2, $1B, 2, 0, $1F, $2F, $1F, $F, $13, 8, $10, $80, $40, 2, 0, $14, $35, $1F, $1F, $1F, $1F
                dc.b    $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30, $F, $F, $12, $13, $10, $80
SFX_BD:         dc.b    0, $1A, 1, 1, $80, 4, 0, $A, 0, 3, $EF, 0, $F0, 0, 1, $33, $FF, $BB, 1, $80, 1, $EF, 1, $C0, 5, $F2, $34, $70, $24, $60, $77, $1F
                                        ; DATA XREF: ROM:00085066   o
                dc.b    $1F, $1F, $1F, $1F, $10, $10, $E, $1F, $E, $10, 2, $1E, $1F, 8, $1F, $18, $80, 0, $80, $30, $70, 0, 0, $70, $1F, $1F, $1F, $1F, $1F, $10, $16, $1F
                dc.b    $10, $11, $E, 8, $1E, $1F, $17, $1F, $10, $16, $10, $80
SFX_BE:         dc.b    0, $36, 1, 2, $80, 5, 0, $10, 0, 1, $80, 4, 0, $30, 0, $A, $EF, 0, $F0, 0, 1, $C8, $FF, $AB, 1, $80, 1, $EF, 1, $F0, 0, 1
                                        ; DATA XREF: ROM:0008506A   o
                dc.b    8, $FF, $A5, $1A, $EF, 2, $B0, 4, $E6, 4, $F7, 0, 9, $FF, $F8, $F2, $E1, $FF, $F6, $FF, $DC, $F2, $3B, $70, $11, $11, $6F, $1F, $1F, $1F, $1F, $10
                dc.b    $18, $14, $1F, $10, 4, 9, 0, $13, $1D, $1F, $E, $14, 2, $10, $85, $1A, $71, $F, $20, $5F, $1F, $E, $1B, $F, $10, $18, $17, $1F, $11, $B, $A, 0
                dc.b    $13, $1D, $1F, $E, 7, $11, $10, $85, $3A, $30, 0, $6F, $7F, $1F, $1F, $1F, $1F, $11, $1D, 7, $1F, $14, 2, $10, 0, $36, $2E, $F, $F, $17, $10, $1A
                dc.b    $81, 0
SFX_BF:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 6, $EF, 0, $F0, 0, 1, $C6, $FF, $A0, $A, $EF, 1, $88, $10, $F2, $38, 1, $61, 0, 4, $1F, $1F, $1F
                                        ; DATA XREF: ROM:0008506E   o
                dc.b    $1F, $18, $1F, $14, $1F, $12, $14, 0, 0, $1F, $15, $28, $F, $25, 3, 0, $80, $3A, 5, $64, 3, 2, $1F, $1F, $1F, $1F, $18, $1F, $14, $1F, 2, 4
                dc.b    0, 9, $1F, $15, $18, $F, $15, $13, $10, $80
SFX_C0:         dc.b    0, $23, 1, 1, $80, 5, 0, $A, 0, 7, $80, 1, $EF, 0, $F0, 0, 1, $F0, $FF, $CA, $1A, $80, 1, $EF, 1, $BA, 5, $E6, $1A, $F7, 0, 1
                                        ; DATA XREF: ROM:00085072   o
                dc.b    $FF, $F8, $F2, $3D, 0, $12, $6E, $14, $19, $D, $F, $D, $1B, $1E, $1F, $1F, 0, 0, 0, 2, $B, $F, $F, $F, $12, $80, $80, $80, $3C, 2, $4F, $23
                dc.b    $1E, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $F, 0, $12, 0, $1C, $F, $F, $F, 5, $80, $13, $80, 0
SFX_C1:         dc.b    0, $6E, 1, 3, $80, 5, 0, $16, 0, 0, $80, 4, 0, $32, 0, 0, $80, $C0, 0, $4E, 0, 2, $EF, 2, $F0, 0, 1, $C6, $FF, $8A, 4, $80
                                        ; DATA XREF: ROM:00085076   o
                dc.b    1, $EF, 1, $F0, 0, 1, $D4, $FF, $93, 8, $E6, 4, $F7, 0, $C, $FF, $F8, $F2, $EF, 2, $F0, 0, 1, $A6, $FF, $83, 4, $80, 1, $EF, 0, $F0
                dc.b    0, 1, $C4, $FF, $91, $A, $E6, 4, $F7, 0, $C, $FF, $F8, $F2, $F3, $E7, $F0, 0, 2, 1, $FF, $A5, 4, $80, 1, $C5, $B, $E7, $EC, 0, $F7, 0
                dc.b    9, $FF, $F7, $C5, $B, $E7, $EC, 1, $F7, 0, 3, $FF, $F7, $F2, $3D, 3, 3, 3, 3, $1F, $1F, $1F, $1E, $1E, $1B, $1F, $1F, 4, 0, 0, 0, $19
                dc.b    $1A, 9, $F, 9, $80, $80, $80, $3D, 0, $50, $31, $75, $1F, $1F, $1F, $1F, $10, $1D, $1F, $1F, 0, 0, 0, 0, $1F, $F, $F, $F, 5, $80, $80, $80
                dc.b    $38, $27, $72, $11, $53, $1F, $1F, $1F, $1F, $1C, $1D, $1F, $1F, $18, $10, 2, 0, $19, $2F, $F, $F, $C, $12, 0, $80, 0
SFX_C2:         dc.b    0, $1F, 1, 1, $80, 5, 0, $A, $11, 0, $EF, 0, $F0, 0, 1, $D9, $FF, $86, 6, $80, 4, $EF, 1, $F0, 0, 1, $90, $FF, $95, 6, $F2, $30
                                        ; DATA XREF: ROM:0008507A   o
                dc.b    0, $12, $11, $70, $11, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $11, 1, $10, 0, $F, $F, $F, $F, 6, $20, $C, $84, $36, 2, $31, $72, 1, $1F, $1F, $F
                dc.b    $1F, $10, $16, $F, $F, 2, 0, 0, 0, $11, $F, $F, $F, 1, $80, $80, $80, 0
SFX_C3:         dc.b    0, $12, 1, 1, $80, 5, 0, $A, 0, 2, $EF, 0, $DB, 4, $D6, $D9, $20, $F2, $14, $3A, $72, $72, $34, $1F, $1F, $1F, $1F, $1E, $1F, $1F, $F, $C
                                        ; DATA XREF: ROM:0008507E   o
                dc.b    $D, 0, $D, $1F, $1F, $1F, $1F, $1C, $80, $11, $80, 0
SFX_C4:         dc.b    0, $4B, 1, 3, $80, 5, 0, $16, $A, 2, $80, 4, 0, $35, $A, 7, $80, $C0, 0, $3D, $F9, 1, $E1, $F6, $80, 1, $EF, 0, $AE, 3, $EF, 1
                                        ; DATA XREF: ROM:00085082   o
                dc.b    $BA, 2, $E7, $E0, $80, 3, $E7, $E0, $40, 3, $E7, $E0, $C0, $E6, $A, $F7, 0, 5, $FF, $E5, $F2, $E1, $FF, $F6, $FF, $DD, $80, $3C, $F2, $80, 1, $AE
                dc.b    3, $BA, 8, $EC, 2, $F7, 0, 5, $FF, $F4, $F2, $3C, 6, 2, 4, 1, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 2, 0, $15, 0, $F, $F, $1F, $F
                dc.b    $30, $85, $21, $85, $3C, $74, $31, $36, $7F, $1F, $1F, $1F, $1F, $1F, $D, $F, $D, $1A, $D, $F, $D, $1F, $1F, $1F, $1F, $10, $80, $1A, $80, $3C, $C, $F
                dc.b    1, 4, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 2, 0, $15, 0, $F, $F, $1F, $F, $20, $80, $11, $80, $3C, $7C, $33, $36, $79, $1F, $1F, $1F, $1F, $1F
                dc.b    $D, $1F, $D, 0, $D, 0, $D, $1F, $1F, $1F, $1F, $1B, $80, $14, $80, 0
SFX_C5:         dc.b    0, $1E, 1, 1, $80, 4, 0, $A, $10, 3, $80, 1, $EF, 0, $87, 6, $80, 1, $9E, 6, $80, 1, $E6, $F, $F7, 0, 3, $FF, $F6, $F2, $3A, $7F
                                        ; DATA XREF: ROM:00085086   o
                dc.b    $32, 0, $3F, $1D, $15, $1F, $1F, $1F, $1C, $A, $1F, 7, $10, $10, 0, $1F, $F, $F, $F, $1A, $19, $10, $80, 0
SFX_C6:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 7, $80, 1, $EF, 0, $F0, 0, 1, $39, $FF, $99, 7, $E6, $19, $F7, 0, 2, $FF, $F8, $F2, $3C, $75, 8
                                        ; DATA XREF: ROM:0008508A   o
                dc.b    4, 1, $F, $11, $10, $11, $15, $1F, $19, $1F, $10, 0, $10, 0, $F, $F, $1F, $E, 0, $80, 0, $80
SFX_C7:         dc.b    0, $13, 1, 1, $80, 5, 0, $A, 0, 2, $EF, 0, $A9, 2, $EF, 1, $AC, $B, $F2, $3B, $70, 7, 4, $F, $15, $18, $11, $11, $15, $1F, $19, $1F
                                        ; DATA XREF: ROM:0008508E   o
                dc.b    $11, 0, $F, 0, $F, $F, $1F, $1F, $1F, $10, $D, $80, $38, $70, $20, 8, $1F, $1F, $1F, $1F, $1F, $15, $1F, $19, $1F, $C, 0, $10, 0, $1F, $F, $F
                dc.b    $F, $12, $2A, 6, $80, $3B, $70, 2, 2, $A, $15, $18, $11, $11, $15, $1F, $19, $1F, $11, 0, $C, 0, $1F, $F, $1F, $1F, $2F, 2, $1D, $80, $38, $7B
                dc.b    $23, $C, $1F, $1F, $1F, $1F, $1F, $15, $1F, $19, $1F, $1C, 0, 0, 0, $1F, $F, $F, $F, $A, $19, 6, $80, 0
SFX_C8:         dc.b    0, $15, 1, 1, $80, 5, 0, $A, 0, 5, $EF, 1, $B1, 1, $80, 1, $EF, 0, $C4, $15, $F2, $3D, 0, $36, $79, 9, $19, $1F, $1F, $1F, $11, $1F
                                        ; DATA XREF: ROM:00085092   o
                dc.b    $1F, $1F, $A, $D, $D, $D, $1D, $F, $F, $F, $C, $80, $80, $80, $3A, 1, $31, 1, $66, $1F, $1F, $1F, $1F, $11, $1F, 5, $1F, $13, $13, $19, 0, $1D
                dc.b    $2F, $8F, $F, $1D, $10, $1A, $83, 0
SFX_C9:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, $F6, 3, $80, 1, $EF, 0, $F0, 0, 1, $E9, $FF, $99, 5, $FD, $EF, 1, $9B, $7F, $E7, $50, $F2, $3B, $71, 3
                                        ; DATA XREF: ROM:00085096   o
                dc.b    $11, 3, $15, $18, $11, $1A, $15, $1F, $19, $1F, $10, $10, 0, 0, $1F, $F, $1F, $F, $21, $10, $30, $80, $3D, 9, $3E, $32, $75, $15, $1C, $13, $17, $E
                dc.b    $1F, $1F, $1F, $10, 5, 5, 5, $F, $F, $1F, $1F, 5, $81, $80, $80, 0
SFX_CA:         dc.b    0, $35, 1, 3, $80, 4, 0, $16, $F3, 2, $80, 5, 0, $24, 0, 1, $80, $C0, 0, $32, 0, 5, $EF, 0, $F0, 0, 1, $F5, $FF, $9A, 3, $80
                                        ; DATA XREF: ROM:0008509A   o
                dc.b    1, $BA, $5E, $F2, $EF, 1, $F0, 0, 1, $F8, $FF, $AA, 3, $80, 1, $95, $5E, $F2, $80, $62, $F2, $38, 3, $62, 5, $F, $1F, $1F, $1F, $1F, $1F, $12
                dc.b    $1F, $1F, $10, $B, 6, 7, $1F, $3F, $F, $F, $11, $16, $14, $80, $38, 0, $77, 0, $A, $1F, $1F, $1F, $1F, $1F, $12, $1F, $1F, $11, 9, 8, 0, $1F
                dc.b    $1F, $F, $F, $17, $11, 7, $80, 0
SFX_CB:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 1, 0, $80, 1, $EF, 0, $F0, 0, 1, $F4, $FF, $87, $35, $F2, $B, $72, 0, $1C, $3F, $16, $1D, $1D, $12, $1F
                                        ; DATA XREF: ROM:0008509E   o
                dc.b    $1A, $A, 8, 6, 9, 2, $B, 7, 0, 9, $1F, $10, $10, $10, $80, 0
SFX_CC:         dc.b    0, $1C, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $EE, $FF, $81, 4, $80, 1, $EF, 1, $82, 8, $F2, $3A, 0, $70, 0
                                        ; DATA XREF: ROM:000850A2   o
                dc.b    $F, $1C, $1B, $10, $1F, $1F, $1F, $1F, $1F, $1B, 0, $10, 0, $F, $1F, $1F, $F, $11, $17, 0, $80, $38, $31, $20, $31, $26, $1F, $1F, $14, $1F, $F, $1F
                dc.b    $1F, $1F, $10, 0, 0, 0, $2F, $F, $F, $F, $1C, 7, $10, $80
SFX_CD:         dc.b    0, $17, 1, 1, $80, 5, 0, $A, $F, $C, $EF, 0, $F0, 0, 1, $13, $FF, $96, 5, $E6, $19, 5, $F2, $3A, $7F, 1, $F, $3A, $1C, $1F, $1F, $1C
                                        ; DATA XREF: ROM:000850A6   o
                dc.b    $1F, $1F, $1F, $F, $B, 0, 0, 6, $1F, $F, $E, $F, $24, 6, 9, $80
SFX_CE:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 6, 4, $80, 1, $EF, 0, $BB, $24, $E6, $19, $15, $F2, $38, 0, $40, 0, $F, $C, $F, $E, $F, $1F, $1F, $1F
                                        ; DATA XREF: ROM:000850AA   o
                dc.b    $F, 2, $C, 0, $A, $1F, $1F, $F, $F, $1F, 3, $A, $80, 0
SFX_CF:         dc.b    0, $20, 1, 1, $80, 5, 0, $A, $5D, 1, $EF, 0, $F0, 0, 1, $41, $FF, $9E, 1, $94, 2, $80, 2, $E6, $10, $9E, 1, $94, 2, $80, 2, $F2
                                        ; DATA XREF: ROM:000850AE   o
                dc.b    $3B, $70, 0, 0, $35, $1C, $1F, $1F, $1F, $1F, $1C, $1F, $D, $15, $11, 4, 7, $4F, $F, $1F, $1F, 2, 0, $10, $80, 0
SFX_D0:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $44, $FF, $81, $10, $E6, 9, $F7, 0, 3, $FF, $F8, $F2, $3B, $27, $70
                                        ; DATA XREF: ROM:000850B2   o
                dc.b    $5D, $18, $1F, $1F, $F, $12, $1F, $1F, $12, $17, 3, 0, 0, 0, $1F, $1F, $F, $F, $1F, $14, 0, $80
SFX_D1:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $39, $FF, $91, 7, $E6, $C, $F7, 0, 4, $FF, $F8, $F2, $3C, $75, 3
                                        ; DATA XREF: ROM:000850B6   o
                dc.b    4, 1, $F, $11, $10, $12, $15, $1F, $19, $1F, $10, 0, $10, 0, $F, $F, $1F, $E, 0, $80, 0, $80
SFX_D2:         dc.b    0, $4B, 1, 3, $80, 4, 0, $16, $F6, 8, $80, 5, 0, $2C, $F6, $10, $80, $C0, 0, $46, 0, $10, $80, 1, $EF, 0, $F0, 0, 1, $D, $FF, $AD
                                        ; DATA XREF: ROM:000850BA   o
                dc.b    $37, $AD, $AD, $37, $E6, 6, $F7, 0, 3, $FF, $F8, $F2, $80, 6, $EF, 0, $E1, 2, $F0, 0, 1, $D, $FF, $AD, $37, $AD, $AD, $37, $E6, 6, $F7, 0
                dc.b    2, $FF, $F8, $AD, $32, $F2, $80, $7F, $7F, $16, $F2, $3A, $79, $33, 6, $33, $1F, $1F, $F, $15, $1F, $1F, $12, $17, 6, 0, 0, 0, $1F, $1F, $F, $F
                dc.b    $26, $15, $10, $80, $3A, $79, $33, 3, $36, $1F, $1F, $F, $15, $1F, $1F, $12, $17, 6, 0, 0, 0, $1F, $1F, $F, $F, $16, $1D, $20, $80, 0
SFX_D3:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, 3, $EF, 0, $F0, 0, 1, $D0, $FF, $91, 5, $F2, 8, $A, $13, $14, $73, $1F, $1F, $1F, $1F, $15, $16, $19
                                        ; DATA XREF: ROM:000850BE   o
                dc.b    $11, $1A, 1, 0, $16, $11, $F, $3F, $2F, $10, 2, $10, $80, 0
SFX_D4:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 1, 1, 8, $FF, $88, $7F, $F2, $31, $10, $30, $45, $41, $1B, $1A, 7, $B, $14
                                        ; DATA XREF: ROM:000850C2   o
                dc.b    $10, $12, $1D, 1, 4, 2, 5, $1F, $1F, $F, $1F, $1A, 4, 0, $80, 0
SFX_D5:         dc.b    0, $41, 1, 3, $80, 5, 0, $16, 0, 0, $80, 4, 0, $2A, $C0, 0, $80, $C0, 0, $33, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, 2, $FF, $A1
                                        ; DATA XREF: ROM:000850C6   o
                dc.b    $7F, $F0, 0, 1, 2, $FF, $E7, $A5, $40, $F2, $80, 1, $EF, 1, $A1, $7F, $E7, $40, $F2, $F5, 9, $F3, $E7, $F0, 0, 4, $FF, $FF, $B3, $7F, $E7, $40
                dc.b    $F2, $D, $2F, 0, $3F, $7F, $1B, 9, 9, 9, $1C, 5, 5, 5, 6, $A, $A, $A, $F, $1F, $1F, $1F, 5, $85, $85, $85, $A, $20, 7, $26, $75, $1F
                dc.b    $1F, $1F, 9, $1F, 5, 5, 5, 0, 0, 0, $A, $F, $F, $F, $1F, $15, $10, $16, $85, 0
SFX_D6:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, $F8, 5, $EF, 0, $F0, 0, 1, 1, $FF, $9E, 1, $B4, 2, $F2, $39, $70, $21, 0, $32, $1F, $12, $1F, $1F, $10
                                        ; DATA XREF: ROM:000850CA   o
                dc.b    $17, $1F, $11, $D, $1F, 1, $17, $1F, $1F, $1F, $2F, $1D, $10, 0, $80, 0
SFX_D7:         dc.b    0, $2F, 1, 2, $80, 5, 0, $10, 0, 1, $80, 4, 0, $2C, 0, $10, $80, 1, $EF, 0, $F0, 0, 1, $C0, $FF, $95, 4, $80, 1, $F0, 0, 1
                                        ; DATA XREF: ROM:000850CE   o
                dc.b    $E0, $FF, $83, $14, $E6, 8, $F7, 0, 3, $FF, $F8, $F2, $80, $42, $F2, $3B, $1E, $61, $3F, $A, $F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0, 0, 0, 0
                dc.b    $F, $F, $F, $F, $17, $10, $20, $80, $3B, $1F, $74, $31, 4, $F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0, 0, 0, 0, $F, $F, $F, $F, $17, 0, $20
                dc.b    $80, 0
SFX_D8:         dc.b    0, $16, 1, 1, $80, 4, 0, $A, 0, 5, $80, 2, $EF, 0, $F0, 0, 1, $C0, $FF, $81, 6, $F2, $3B, $32, 2, $10, $1E, $10, $1F, $1F, $12, $16
                                        ; DATA XREF: ROM:000850D2   o
                dc.b    $1E, $19, $1F, 3, $B, 0, 0, $F, $D, $F, $E, $18, 1, 0, $80, 0
SFX_D9:         dc.b    0, $1F, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $1B, $66, $83, $18, $EF, 1, $F0, 0, 1, $F3, $66, $90, $2E, $F2, $3A
                                        ; DATA XREF: ROM:000850D6   o
                dc.b    $F, $10, 0, $2F, $11, $15, $1C, $10, $1F, $1F, $A, $1F, 1, 0, $C, 1, $1F, $F, 2, $F, $1A, $11, $C, $82, $3A, 3, 0, 0, $3A, $11, $15, $1F
                dc.b    $1F, $1F, $1C, $A, $1F, $A, $B, $10, 1, $1F, $F, $12, $F, $10, 7, 0, $80, 0
SFX_DA:         dc.b    0, $2D, 1, 2, $80, 5, 0, $10, 5, 4, $80, 4, 0, $1C, 0, 0, $EF, 0, $A7, $14, $E6, 6, $F7, 0, 3, $FF, $F8, $F2, $EF, 1, $F0, 0
                                        ; DATA XREF: ROM:000850DA   o
                dc.b    1, $D8, $FF, $94, $A, $E6, 6, $F7, 0, 6, $FF, $F8, $F2, $30, $4C, $10, $29, $6C, $1F, $1F, $1E, $1F, $1F, $1F, $1F, $1F, $19, $E, 4, 0, $1B, $1A
                dc.b    $1C, $F, $1F, 1, $11, $80, $30, 1, $61, $61, $40, $1F, $1F, $1F, $1F, $1C, $1F, $1F, $1F, $10, 8, $C, 0, $1B, $1A, $C, $F, $10, $10, $10, $80, 0
SFX_DB:         dc.b    0, $19, 1, 1, $80, 4, 0, $A, 0, 0, $80, 2, $EF, 0, $D0, $A, $E6, 3, $E7, $F7, 0, 2, $FF, $F7, $F2, $C, $22, $31, $7E, $73, $E, $D
                                        ; DATA XREF: ROM:000850DE   o
                dc.b    $F, $E, $19, $1F, $1F, $1F, 0, $E, 2, $E, $1F, $F, $F, $F, $1F, $80, $20, $80, $C, $32, $31, $7E, $73, $E, $D, $F, $E, $19, $1F, $1F, $1F, 0
                dc.b    $E, 2, $E, $15, $A, 5, $A, $1F, $80, $20, $80, $C, $31, $31, $71, $7F, $F, $D, $F, $E, $19, $1F, $1F, $1F, $10, $E, 2, $E, $15, 9, 5, 9
                dc.b    $1E, $80, $1B, $80
SFX_DC:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 2, $80, 1, $EF, 0, $F0, 0, 1, $26, $FF, $8D, $B, $E6, $A, $F7, 0, 3, $FF, $F8, $F2, $3A, $7B, $30
                                        ; DATA XREF: ROM:000850E2   o
                dc.b    $30, $75, $E, $F, $E, $12, $1F, $12, $1F, $1F, 0, 0, 7, 0, $1F, $F, $1F, $F, $1A, $1C, 5, $80
SFX_DD:         dc.b    0, $54, 1, 2, $80, 5, 0, $10, 0, $E, $80, 4, 0, $30, 0, $1A, $80, 1, $EF, 0, $E9, $2F, $3F, $F0, 1, 1, $A0, $FF, $C0, 2, $80, 1
                                        ; DATA XREF: ROM:000850E6   o
                dc.b    $F0, 1, 1, $7F, $FF, $C8, 8, $E7, $F0, 4, 1, $A3, $FF, $D6, 7, $F2, $80, 6, $80, 1, $E1, 6, $EF, 0, $E9, $27, $3F, $F0, 1, 1, $A0, $FF
                dc.b    $C0, 2, $80, 1, $F0, 1, 1, $7F, $FF, $C8, 8, $E7, $F0, 4, 1, $A3, $FF, $D6, $C, $F2, $3C, $70, $31, $30, $70, $1F, $13, $1F, $13, $F, $1F, $1F
                dc.b    $1F, 0, 0, $10, 0, $12, $F, $12, $F, $1E, $80, $10, $80, 0
SFX_DE:         dc.b    0, $16, 1, 1, $80, 4, 0, $A, 0, 1, $80, 1, $EF, 0, $F0, 1, 1, $51, $FF, $B1, $C, $F2, $39, $36, $74, $C, 2, $1F, $1E, $F, $12, $14
                                        ; DATA XREF: ROM:000850EA   o
                dc.b    $1F, $1F, $1F, $10, $E, $10, $F, $19, 9, 9, $A, $11, $13, $21, $80, 0
SFX_DF:         dc.b    0, $1C, 1, 1, $80, 4, 0, $A, 0, 4, $80, 1, $EF, 0, $CB, 1, $BD, 4, $C0, 7, $E6, $B, $F7, 0, 3, $FF, $F8, $F2, 0, $5A, $F, $75
                                        ; DATA XREF: ROM:000850EE   o
                dc.b    $3F, $1F, $1F, $1F, $1F, $11, $1F, $D, $1F, $18, $11, $F, 0, $1F, $30, $9F, $F, $33, $29, $E, $80, 0, $59, $43, $7F, $3F, $1F, $1E, $1A, $1F, $11, $1F
                dc.b    $D, $1F, $18, $E, 9, 0, $1F, $30, $9F, $F, $2C, $16, $20, $80
SFX_E0:         dc.b    0, $38, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $2C, 0, 2, $EF, 0, $F0, 0, 2, $F5, $FF, $90, $75, $80, $10, $EF, 1, $F0, 0, 1
                                        ; DATA XREF: ROM:000850F2   o
                dc.b    $25, $11, $A4, 5, $E6, 7, $F7, 0, 2, $FF, $F8, $F2, $F3, $E7, $F0, 1, 2, 1, $FF, $C2, $7F, $E7, $A, $F2, $39, $10, 2, $63, $19, $1F, $1F, $12
                dc.b    $1A, $17, $1F, $1F, $1F, 1, 5, $B, 7, $2F, $2F, $1F, $F, $19, $F, 3, $80, $39, $1F, 0, $60, $1B, $1F, $1F, $12, $F, $14, $1F, $1F, $1F, 6, 0
                dc.b    7, $C, $5F, $2F, $1F, $F, 9, 7, 0, $84
SFX_E1:         dc.b    0, $34, 1, 2, $80, 4, 0, $10, 0, 0, $80, $C0, 0, $22, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $F1, $FF, $96, 3, $80, 1, $EF, 1, $85
                                        ; DATA XREF: ROM:000850F6   o
                dc.b    $20, $F2, $80, 1, $F5, 5, $F3, $E7, $F0, 0, 1, 1, $FF, $C6, 3, $80, 1, $C0, $20, $F2, $35, 1, $41, 1, 1, $1F, $1F, $1E, $1F, $F, $1F, $1F
                dc.b    $1F, $F, $C, 0, 0, $F, $F, $F, $F, 8, $8A, $8A, $8A, $39, $31, $42, 3, $71, $1F, $1F, $1E, $1F, $1F, $1F, $1F, $A, $C, $F, $D, $D, $4F, $F
                dc.b    $F, $3F, 0, $18, $1A, $80
SFX_E2:         dc.b    0, $1B, 1, 1, $80, 5, 0, $A, $1D, 3, $80, 1, $EF, 0, $F0, 0, 1, $4B, $FF, $89, 7, $87, $12, $E6, $1A, $E, $F2, $B, 0, $7F, $2F, $3F
                                        ; DATA XREF: ROM:000850FA   o
                dc.b    $D, $11, $F, $F, $F, $1A, $A, $C, 1, 3, $B, $D, $F, $F, $F, $1F, $26, $18, $1E, $80
SFX_E3:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 3, $80, 1, $EF, 0, $F0, 0, 1, $73, $FF, $84, 2, $81, 6, $F2, $2C, $70, $31, $20, $7B, $12, $14, $14
                                        ; DATA XREF: ROM:000850FE   o
                dc.b    $15, $15, $1F, $19, $1F, $1F, 0, 0, 0, $F, $F, $2F, $E, $F, $80, 0, $80, 0
SFX_E4:         dc.b    0, $18, 1, 1, $80, 4, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $55, 2, $9A, $55, $80, 1, $F2, $3A, $7F, 0, $30, $F, $1D, $15, $12
                                        ; DATA XREF: ROM:00085102   o
                dc.b    $12, $1F, $1C, $19, $D, 8, 4, 8, 9, $1F, $1F, $1F, $1F, $D, $D, 1, $80, 0
SFX_E5:         binclude "data/sound/SFX_E5.bin"
SFX_E5_End:
SFX_E6:         dc.b    0, $45, 1, 2, $80, 5, 0, $10, 0, 2, $80, 4, 0, $2D, $10, 1, $EF, 2, $80, $3D, $B0, 4, $FB, 2, $E6, 1, $F7, 0, $18, $FF, $F6, $A5
                                        ; DATA XREF: ROM:0008510A   o
                dc.b    4, $FB, 2, $E6, 6, $F7, 0, 6, $FF, $F6, $80, 3, $F2, $EF, 0, $FB, $1A, $80, 1, $87, 4, $F7, 0, $C, $FF, $F8, $FB, $E6, $80, 1, $EF, 1
                dc.b    $AA, $77, $80, 3, $F2, $3A, $70, $30, 4, $3F, $1D, $15, $1E, $1F, $1F, $1C, $A, $1F, 1, 6, $10, 0, $35, 5, $15, $B, $1A, $10, 0, $82, $3A, $2F
                dc.b    $F, $F, $6F, $1D, $15, $10, 7, $F, $C, $19, $1F, 2, 0, 6, 4, $15, $15, $15, $A, $10, $D, 8, $80, $3C, $30, $70, $30, $70, $1F, 8, $F, 8
                dc.b    $1E, $1F, $1F, $1F, 2, 3, $1F, 6, $1F, $1F, $3F, $F, $A, $80, 4, $80
SFX_E7:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 5, $80, 1, $EF, 0, $F0, 0, 1, $1C, 1, $A5, $15, $80, 3, $F2, $3A, $F, $F, 0, $3F, $F, $10, $12
                                        ; DATA XREF: ROM:0008510E   o
                dc.b    $F, $1F, $1F, $1F, $17, $E, 2, 0, 0, 5, 5, $15, $A, $2D, $1B, $16, $80, 0
SFX_E8:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 6, $80, 1, $EF, 0, $AA, $19, $E6, $1B, $15, $80, 1, $F2, $3A, $70, $11, $35, $F, $1D, $14, $1D, $1C, $1F
                                        ; DATA XREF: ROM:00085112   o
                dc.b    $1C, $19, $D, 8, $F, $19, 0, $F, $1F, $F, $F, $10, $11, 8, $80, 0
SFX_E9:         dc.b    0, $1B, 1, 1, $80, 5, 0, $A, 0, 3, $80, 1, $EF, 0, $F0, 0, 1, $11, $FF, $8A, $10, $E6, $12, $A, $80, 1, $F2, $3A, $7E, 1, $30, $F
                                        ; DATA XREF: ROM:00085116   o
                dc.b    $1D, $14, $1F, $1F, $1F, $1C, $19, $D, 0, 0, $10, 0, $1F, $F, $3F, $F, $1B, $10, 0, $80
SFX_EA:         dc.b    0, $1C, 1, 1, $80, 5, 0, $A, 0, 4, $80, 1, $EF, 0, $B5, $B, $E6, 5, $EF, 1, $BA, $1C, $E6, $1B, $A, $80, 1, $F2, $38, 0, $40, 0
                                        ; DATA XREF: ROM:0008511A   o
                dc.b    $F, $C, $F, $E, $F, $1F, $1F, $1F, $F, 2, $C, 0, $A, $1F, $1F, $F, $F, $1F, 3, $A, $80, $3A, $7F, $19, $30, $F, $1D, $14, $1D, $1C, $1F, $1C
                dc.b    $19, $D, 0, 0, 0, 0, $F, $F, $F, $F, $20, $30, $20, $80
SFX_EB:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, $C, $EF, 0, $F0, 0, 2, $8E, $FF, $98, 5, $F2, $38, 0, 2, 1, $42, $F, $F, $F, $16, $18, $19, 0
                                        ; DATA XREF: ROM:0008511E   o
                dc.b    $1F, $1A, 0, 0, 2, $1F, $1F, $1F, $F, $10, $1A, $10, $80, 0
SFX_EC:         dc.b    0, $1F, 1, 1, $80, 5, 0, $A, $10, 0, $EF, 0, $F0, 0, 1, $E3, $FF, $81, 4, $80, 1, $85, 8, $E6, $C, $F7, 0, 4, $FF, $F8, $F2, $3A
                                        ; DATA XREF: ROM:00085122   o
                dc.b    $30, $10, $10, 3, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $F, $11, 0, 4, $F, $F, $F, $F, 0, $27, $20, $80
SFX_ED:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 2, $EF, 0, $A6, $C, $E6, 6, $F7, 0, 5, $FF, $F8, $F2, $1A, $75, $30, $20, $6F, $1F, $1F, $1B, $1F, $1F
                                        ; DATA XREF: ROM:00085126   o
                dc.b    $1C, $1A, $1F, 8, $10, 9, 0, $17, $F, $E, $F, 7, $16, $10, $80, 0
SFX_EE:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 1, $80, 1, $EF, 0, $F0, 0, 1, $F4, $FF, $87, $32, $F2, $B, $70, 7, $11, $3F, $16, $D, $D, $E, $1F
                                        ; DATA XREF: ROM:0008512A   o
                dc.b    $1A, $A, $1F, 6, $19, 0, 0, 7, 0, 9, $F, $10, $13, 0, $80, 0
SFX_EF:         dc.b    0, $F, 1, 1, $80, 5, 0, $A, 0, 7, $EF, 0, $C7, 6, $F2, $3C, $E, 0, 0, $4F, $1D, $11, $E, $F, $F, $1A, $A, 6, 0, 0, 0, 0
                                        ; DATA XREF: ROM:0008512E   o
                dc.b    $F, $F, $F, $1F, $1C, 3, $20, $80, $C, $F, 1, 3, $F, $1D, $F, $E, $F, $F, $1A, $A, 6, 0, 0, 0, 0, $F, $F, $F, $1F, 0, $15, $2C
                dc.b    $80, $C, $F, 0, 3, $F, $1D, $F, $E, $F, $F, $1A, $A, 6, 0, 0, 0, 0, $1F, $F, $F, $1F, $30, $15, $30, $80
SFX_40:         dc.b    0, $1A, 1, 1, $80, $A0, 0, $A, $E5, 0, $F5, 1, $C0, 5, $BD, $A, $EC, 2, $F7, 0, 4, $FF, $F8, $EC, $F8, $F2
                                        ; DATA XREF: ROM:SFX_40_7F_PointerTable   o
SFX_41:         dc.b    0, $1A, 1, 1, $80, 5, 0, $A, 0, 3, $80, 1, $EF, 0, $F0, 0, 1, $EE, $FF, $98, 4, $EF, 1, $97, $1E, $F2, $38, $34, $31, $70, $13, $1F
                                        ; DATA XREF: ROM:0008516A   o
                dc.b    $1F, $F, $1F, $1F, $1F, $1F, $1F, 0, 0, 0, 0, $2F, $F, $F, $F, $1C, $17, 0, $80, $3A, $F, $71, 0, 7, $C, $12, $12, $1F, $F, $1F, $1F, $1F
                dc.b    $D, 0, $C, 4, $12, $12, 2, 8, $21, $10, 0, $80
SFX_42:         dc.b    0, $35, 1, 3, $80, 4, 0, $16, 0, 3, $80, 5, 0, $2D, 0, 3, $80, $C0, 0, $31, 0, $A, $EF, 0, $F0, 0, 1, $E1, $FF, $97, 2, $EF
                                        ; DATA XREF: ROM:0008516E   o
                dc.b    1, $81, 4, $FB, 1, $F7, 0, $2D, $FF, $F8, $80, 7, $F2, $80, $7F, $3E, $F2, $80, $7F, $3E, $F2, $3A, $71, 1, 4, $24, $1F, $1F, $1F, $1F, $1F, 0
                dc.b    $1D, $1F, $13, 0, $D, 0, $A, $E, $1E, $E, $17, 1, $16, $80, $3B, $76, $7E, $30, $37, $1F, $1F, $1F, $5F, $1F, $1F, $1D, $1F, $A, 0, 0, 2, $12
                dc.b    2, 2, 9, $10, $17, $1D, $80, 0
SFX_43:         dc.b    0, $21, 1, 1, $80, 5, 0, $A, $10, 3, $EF, 0, $F0, 0, 1, $43, $FF, $8A, 1, $80, 1, $95, 8, $80, 1, $E6, 8, $F7, 0, 3, $FF, $F6
                                        ; DATA XREF: ROM:00085172   o
                dc.b    $F2, $39, $30, $70, 0, 6, $F, $18, $1D, $1A, $F, $1F, $1F, $1F, 4, 0, $A, 0, $2F, $F, $1F, $F, $1F, $10, $1D, $80, $39, $1F, $30, $77, 5, $1D
                dc.b    $18, $16, $1A, $1F, $1F, $1F, $1F, $1F, $16, 1, 0, $5F, $F, $F, $F, $24, $10, $11, $80, $3E, $1D, $1F, $6C, $1F, $10, $12, $12, $12, $1F, $1F, $1F, $1F
                dc.b    0, 0, 0, 0, $F, $F, $F, $F, $13, $80, $80, $80, $3E, $1C, $1F, $6C, $1F, $12, $10, $10, $10, $1F, $1F, $1F, $1F, $10, 0, 0, 0, $1F, $F, $F
                dc.b    $F, $10, $80, $80, $80, $3D, $2D, $1C, $7D, 1, $D, $18, $16, $1A, $1F, $1F, $1F, $1F, $F, 6, 7, 7, $1F, $F, $F, $F, $14, $80, $80, $80, $3D, $2F
                dc.b    $11, $87, $F, $1D, $18, $16, $1A, $1F, $1F, $1F, $1F, $F, 6, 7, 7, $1F, $F, $F, $F, $14, $80, $80, $80, $3D, $3F, $1B, $80, $A, $1D, $18, $16, $1A
                dc.b    $1F, $1F, $1F, $1F, $1F, 6, 7, 7, $1F, $F, $F, $F, $10, $80, $80, $80
SFX_44:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 5, $EF, 0, $F0, 0, 1, $80, $FF, $9F, 2, $80, 1, $F0, 4, 1, $55, 3, $A0, $3A, $F2, $38, $31, 2
                                        ; DATA XREF: ROM:00085176   o
                dc.b    3, $71, $F, $1F, $F, $1F, $1F, $E, $1F, 7, 7, 0, $A, $E, $F, $1F, $F, $1F, $17, $1E, $C, $80
SFX_45:         dc.b    0, $21, 1, 1, $80, 5, 0, $A, 4, $A, $EF, 0, $F0, 0, 1, $20, $FF, $A2, 5, $E7, $F0, 0, 1, $CC, $FF, $AA, 2, $F7, 0, $D, $FF, $FA
                                        ; DATA XREF: ROM:0008517A   o
                dc.b    $F2, $38, 4, $11, 3, $E, $1F, $1F, $1F, $1F, $14, $1F, $1F, $1F, 1, 1, 0, 0, $12, $12, 2, $A, $1B, $18, $A, $80
SFX_46:         dc.b    0, $27, 1, 2, $80, 5, 0, $10, $A, 7, $80, $C0, 0, $24, $A, 7, $EF, 0, $F0, 0, 1, $50, $FF, $B5, 2, $BC, $C1, 5, $E6, 6, $F7, 0
                                        ; DATA XREF: ROM:0008517E   o
                dc.b    5, $FF, $F8, $F2, $80, $1B, $F2, $38, $33, $13, $76, 1, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, 0, $10, 0, $B, $1F, $2F, $F, $F, $22, $17, $2F, $80
SFX_47:         dc.b    0, $27, 1, 2, $80, 5, 0, $10, 0, 3, $80, $C0, 0, $24, 0, 6, $EF, 0, $F0, 0, 2, $70, $F, $B5, 3, $BC, $C1, $A, $E6, 6, $F7, 0
                                        ; DATA XREF: ROM:00085182   o
                dc.b    5, $FF, $F8, $F2, $80, $38, $F2, $B, $41, $11, $71, $11, $1F, $1F, $1F, $1F, $1F, $1F, $F, $1F, $11, 0, 0, $B, $1F, $1F, $F, $F, $1A, $1A, $1F, $80
SFX_48:         dc.b    0, $37, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $27, 0, 1, $EF, 0, $F0, 0, 1, $C1, $FF, $9F, 3, $80, 1, $EF, 1, $81, 7, $E6
                                        ; DATA XREF: ROM:00085186   o
                dc.b    5, $F7, 0, 6, $FF, $F8, $F2, $F3, $E7, $A6, 3, $80, 1, $B3, 7, $EC, 1, $F7, 0, 6, $FF, $F8, $F2, $38, $32, 0, 1, $52, $1B, $1F, $1F, $17
                dc.b    $1F, $15, $1D, $1F, $13, 0, $10, 0, $F, $1F, $1F, $F, $31, 8, $10, $85, $3D, $2C, 1, 1, 1, $1F, $1F, $1F, $1F, $F, $15, $1D, $1F, 0, 0, 0
                dc.b    0, $1F, $F, $1F, $F, $11, $80, $80, $80, 0
SFX_49:         dc.b    0, $1A, 1, 1, $80, 5, 0, $A, 0, 1, $EF, 0, $88, 5, $EF, 1, $98, $A, $E6, 6, $F7, 0, 6, $FF, $F8, $F2, $30, 1, $60, $61, $41, $1F
                                        ; DATA XREF: ROM:0008518A   o
                dc.b    $1F, $1F, $1F, $1C, $1F, $1F, $10, $10, 8, $C, 0, $1B, $1A, $C, $1F, $10, 0, $1B, $80, $30, $4C, $16, $20, $6F, $1F, $1F, $1E, $1F, $1F, $1F, $1F, $1F
                dc.b    9, $E, $A, 0, $1B, $1A, $1C, $F, $1F, $1A, $C, $80
SFX_4A:         dc.b    0, $28, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $1A, 0, 0, $EF, 0, $F0, 0, 2, $EA, $FF, $90, $38, $F2, $81, 2, $80, 1, $F3, $E7
                                        ; DATA XREF: ROM:0008518E   o
                dc.b    $F0, 1, 1, $F7, $18, $A5, $30, $F2, $38, $16, 8, $60, $31, $1F, $1F, $1F, $1F, $17, $1F, $1F, $1F, 1, $A, $B, $A, $2F, $2F, $F, $F, 9, $F, $F
                dc.b    $80, 0
SFX_4B:         dc.b    0, $35, 1, 1, $80, 5, 0, $A, 0, 4, $EF, 0, $F0, 0, 1, $31, $FF, $97, 2, $EF, 1, $90, 3, $FB, 1, $F7, 0, $1A, $FF, $F8, $FB, $E8
                                        ; DATA XREF: ROM:00085192   o
                dc.b    $EF, 2, $F0, 0, 1, $C0, $FF, $84, 3, $80, 1, $EF, 3, $F0, 0, 1, $F6, $FF, $A7, $35, $F2, $3A, $72, 1, 4, $24, $1F, $1F, $1F, $1F, $1F, 0
                dc.b    $1D, $1F, $13, 0, $D, 0, $A, $E, $1E, $E, $17, 1, $16, $80, $3C, $71, $75, $31, $35, $11, $5F, $13, $5F, $1F, $1F, $1D, $1F, 0, 0, 7, 2, $32
                dc.b    8, 2, 8, $20, $80, $1C, $80, $3C, $70, $34, $30, $70, $16, $D, $D, $E, $1F, $1A, $A, $1F, 6, 9, 0, 0, 7, $A, 9, $A, $2D, $83, 7, $80
                dc.b    $3C, $70, $34, $30, $70, $16, $D, $D, $E, $1F, $1A, $A, $1F, 6, 9, 0, 0, 7, $A, 9, $A, $2D, $83, 7, $80, 0
SFX_4C:         dc.b    0, $37, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $25, 0, 0, $EF, 0, $F0, 0, 1, $E3, $FF, $8A, 4, $80, 1, $85, $13, $E6, $A, $F7
                                        ; DATA XREF: ROM:00085196   o
                dc.b    0, 3, $FF, $F8, $F2, $F3, $E7, $F5, 0, $BA, 4, $80, 1, $C6, $13, $EC, 2, $F7, 0, 3, $FF, $F8, $F2, $38, $30, $13, $83, $A, $1F, $1F, $11, $1F
                dc.b    $1F, $1F, $1F, $1F, 0, 0, 0, 4, $F, $F, $F, $F, 0, $10, 0, $80
SFX_4D:         dc.b    0, $37, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $25, 0, 0, $EF, 0, $F0, 0, 1, $E3, $FF, $8A, 4, $80, 1, $85, $13, $E6, $A, $F7
                                        ; DATA XREF: ROM:0008519A   o
                dc.b    0, 3, $FF, $F8, $F2, $F3, $E7, $F5, 0, $BA, 4, $80, 1, $C0, $13, $EC, 2, $F7, 0, 3, $FF, $F8, $F2, $38, $30, $10, $72, $E, $1F, $1F, $11, $1F
                dc.b    $1F, $1F, $1F, $1F, 0, 0, 0, 4, $F, $F, $F, $F, 0, $C, 0, $80
SFX_4E:         dc.b    0, $1A, 1, 1, $80, 5, 0, $A, 0, 9, $80, 1, $EF, 0, $F0, 0, 1, $43, $FF, $91, 6, $E7, $FD, $97, $18, $F2, $32, $61, $32, $2E, $7F, $18
                                        ; DATA XREF: ROM:0008519E   o
                dc.b    $1A, $1B, $12, $1F, $1F, $1F, $1F, 9, $10, 0, 0, $F, $1F, $F, $F, $15, 0, $15, $80, 0
SFX_4F:         dc.b    0, $1F, 1, 1, $80, 5, 0, $A, $E0, 0, $80, 1, $EF, 0, $F0, 2, 1, $C2, $FF, $A5, 9, $AB, $C, $E6, 6, $F7, 0, 5, $FF, $F8, $F2, $34
                                        ; DATA XREF: ROM:000851A2   o
                dc.b    9, $4F, 2, 6, $F, $10, $F, $10, $10, 0, $1D, $F, $10, 4, $10, 4, 1, $F, $F, $F, 0, $80, 0, $80, $34, $F, $41, 9, $A, $F, $10, $F
                dc.b    $10, $10, 0, $1D, $F, 0, 4, 0, 4, 1, $F, $F, $F, 6, $80, $10, $80, $34, $C, $4D, 7, $F, $F, $F, $F, $F, $10, 0, $1D, $F, $A, 4
                dc.b    0, 4, 1, $F, $F, $F, $13, $80, 0, $80, $34, $D, $43, 6, 1, $F, $F, $F, $F, $10, 0, $1D, $F, 0, 4, 0, 4, 1, $F, $F, $F, $13
                dc.b    $80, $E, $80, $3D, $F, $65, $15, $15, $F, $F, $F, $F, $10, $10, $1D, $F, $A, $E, $E, $E, $21, $1F, $F, $1F, 7, $80, $80, $80, $3D, $F, $66, $16
                dc.b    $16, $1F, $F, $F, $F, $10, $10, $1D, $F, $A, $E, $E, $E, $21, $1F, $F, $1F, 0, $80, $80, $80, 0
SFX_50:         dc.b    0, $21, 1, 1, $80, 5, 0, $A, 0, 5, $80, 1, $EF, 0, $F0, 1, 1, $22, $FF, $B9, 4, $EF, 1, $AB, $C, $E6, 9, $F7, 0, 3, $FF, $F8
                                        ; DATA XREF: ROM:000851A6   o
                dc.b    $F2, $3B, $30, 0, 0, $7F, $11, $1F, $1F, $1F, $12, $1E, $1E, $1F, $15, 8, 0, 0, $1F, $F, $F, $F, $B, 3, $D, $81, $32, 0, $30, $11, $F, $1B
                dc.b    $1F, $1F, $1F, $1E, $1F, $1D, $1F, $11, $E, 0, 0, $31, $1F, $F, $F, 1, $A, 0, $80, 0
SFX_51:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, $10, 4, $80, 1, $EF, 0, $F0, 0, 2, $F3, $D, $87, $1D, $E6, $18, $F7, 0, 2, $FF, $F8, $F2, $3A, $71, 0
                                        ; DATA XREF: ROM:000851AA   o
                dc.b    $7F, $3F, $10, $13, $F, $12, $1F, $1C, $19, $1F, 4, $C, 7, 0, $17, $10, $19, $F, $1D, $F, $C, $80
SFX_52:         dc.b    0, $25, 1, 1, $80, 5, 0, $A, $1D, 7, $80, 1, $EF, 0, $F0, 0, 1, $E3, $D, $85, 5, $80, 1, $90, 5, $80, 1, $FB, $FF, $E6, 1, $F7
                                        ; DATA XREF: ROM:000851AE   o
                dc.b    0, 7, $FF, $F4, $F2, $3A, $71, $30, $7E, $3F, $10, $D, $19, $12, $1F, $1C, $19, $1F, 5, $15, 1, 0, $12, $12, $12, $E, $20, $11, $12, $80, $3A, $70
                dc.b    $30, $7F, $3F, $10, $10, $19, $12, $1F, $1C, $19, $1F, $15, $15, 1, 0, $1F, $1F, $1F, $F, $1F, 8, $11, $80, $3A, $71, 0, $7F, $3F, $10, $13, $F, $12
                dc.b    $1F, $1C, $19, $1F, 4, $C, 7, 0, $17, $10, $19, $F, $1D, $F, $C, $80, $3A, $72, 0, $7F, $3F, $10, $13, $F, $12, $1F, $1C, $19, $1F, 4, $C, 7
                dc.b    0, $17, $10, $19, $F, $1D, $1F, $C, $80, $3A, $7E, 1, $7E, $3F, $10, $F, $12, $12, $1F, $1C, $19, $1F, $B, $A, 7, 0, $1F, $1F, $1F, $F, $12, $15
                dc.b    $12, $80
SFX_53:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, $E5, 0, $80, 1, $EF, 0, $F0, 0, 1, $1C, 1, $A5, 4, $80, 1, $B0, 4, $E6, $15, 7, $F2, $39, 0, 4
                                        ; DATA XREF: ROM:000851B2   o
                dc.b    0, $3F, $1B, $15, $1F, $1F, $1F, $1F, $1F, $17, $17, 3, 0, 0, $27, $1C, $1F, $F, $1F, $15, $15, $80
SFX_54:         dc.b    0, $15, 1, 1, $80, 5, 0, $A, $E0, 8, $EF, 0, $E7, $F0, 0, 1, $13, $13, $AB, $25, $F2, $32, $36, 0, $76, $D, $1B, $1F, $F, $F, $1E, $1F
                                        ; DATA XREF: ROM:000851B6   o
                dc.b    $1D, $1F, 0, 0, 0, 0, 1, $1F, $F, $F, $25, $17, $2F, $80
SFX_55:         dc.b    0, $30, 1, 1, $80, 4, 0, $A, $E9, 3, $FB, $17, $EF, 0, $F0, 1, 1, $22, $FF, $81, 4, 4, $FB, 1, $F7, 0, $16, $FF, $F7, $FB, $ED, $94
                                        ; DATA XREF: ROM:000851BA   o
                dc.b    4, $F7, 0, $30, $FF, $FA, $94, 4, $E6, 1, $F7, 0, $15, $FF, $F8, $F2, $34, 1, $30, $11, 6, $1B, $1F, $1F, $12, $E, $1F, $E, $1F, 1, 0, 9
                dc.b    0, 1, $1F, $1F, $F, 6, $10, 9, $80, 0
SFX_56:         dc.b    0, $2B, 1, 1, $80, 5, 0, $A, 0, 5, $80, 1, $F0, 0, 1, $20, $FF, $EF, 0, $91, 3, $EF, 1, $91, 3, $EF, 0, $91, 3, $EF, 1, $91
                                        ; DATA XREF: ROM:000851BE   o
                dc.b    3, $EF, 2, $91, 3, $F7, 0, $A, $FF, $E8, $F2, $39, $6C, $E, 1, $1F, $1F, $1F, $1F, $1F, $1F, 0, $1D, $1F, $D, 0, 0, 0, 5, 5, 5, $A
                dc.b    $20, $20, $28, $85, $A, $7F, 0, 1, $3F, $1F, $1F, $1F, $1F, $1F, 0, $1D, $1F, 3, $10, $D, 0, $15, 5, 5, $A, $20, $1E, $13, $80, $3A, $70, 0
                dc.b    $1C, $21, $1F, $1F, $1F, $1F, $1F, 0, $1D, $1F, $11, 1, 9, 0, $15, 5, 5, $A, $21, $11, $1F, $80
SFX_57:         dc.b    0, $16, 1, 1, $80, $C0, 0, $A, 0, 0, $F5, $A, $F3, $E7, $F0, 4, 4, $FF, $FF, $B8, $48, $F2
                                        ; DATA XREF: ROM:000851C2   o
SFX_58:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 3, $80, 1, $EF, 0, $F0, 0, 1, $DD, $FF, $81, 7, $80, 2, $F2, 8, $50, $10, 7, $5F, $1F, $1F, $C
                                        ; DATA XREF: ROM:000851C6   o
                dc.b    $F, $1F, $1F, $1F, $1F, 0, $E, $E, 0, 7, 7, $16, $A, 0, $3F, 0, $80, 0
SFX_59:         dc.b    0, $19, 1, 1, $80, 5, 0, $A, 0, 5, $80, 1, $EF, 0, $F0, 0, 1, $1C, 1, $A5, $15, $E6, $15, 7, $F2, $3A, $D, $F, 0, $3F, $1B, $15
                                        ; DATA XREF: ROM:000851CA   o
                dc.b    $1F, $1F, $1F, $1F, $1F, $17, $1E, 2, 0, 0, 7, $C, $19, $F, $1D, $1B, $16, $80
SFX_5A:         dc.b    0, $1C, 1, 1, $80, 4, 0, $A, 0, 0, $EF, 0, $8B, 4, $80, 1, $EF, 1, $81, 7, $E6, $E, $F7, 0, 3, $FF, $F8, $F2, $32, $33, $6F, $10
                                        ; DATA XREF: ROM:000851CE   o
                dc.b    3, $1F, $1F, $1F, $1F, $1F, $1C, $1F, $11, $12, $13, $D, 0, $1F, $2F, $1F, $A, 0, 9, $18, $80, $12, 1, $77, $40, $F, $1E, $1F, $1F, $1F, $F, $C
                dc.b    $F, $1F, $1B, $1B, 5, 0, $F, $1F, $F, $F, $1C, $1B, $10, $80
SFX_5B:         dc.b    0, $13, 1, 1, $80, 4, 0, $A, $50, 5, $80, 3, $EF, 0, $81, $7F, $E7, $30, $F2, $D, $7E, $37, $17, 7, 6, $D, $D, $E, $1F, $1A, $A, $1F
                                        ; DATA XREF: ROM:000851D2   o
                dc.b    1, 6, 6, 6, 7, 9, 9, 9, 0, $80, $80, $80
SFX_5C:         dc.b    0, $1B, 1, 1, $80, 4, 0, $A, 0, 3, $EF, 0, $F0, 1, 2, $E3, $66, $87, $1D, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $72, 0, $E, $21
                                        ; DATA XREF: ROM:000851D6   o
                dc.b    $12, $18, $16, $18, $1F, $C, $1A, $1F, $B, 9, 8, 0, $17, $10, 9, $F, $17, $13, 7, $80
SFX_5D:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $F3, $66, $90, $2E, $F2, $3A, 3, 0, 0, $3A, $11, $15, $1F, $1F, $1F
                                        ; DATA XREF: ROM:000851DA   o
                dc.b    $1C, $A, $1F, $A, $B, $10, 1, $1F, $F, $12, $F, $10, 7, 0, $80, 0
SFX_5E:         dc.b    0, $1A, 1, 1, $80, 5, 0, $A, $EA, 0, $80, 1, $EF, 0, $F0, 0, 1, $3C, 5, $A5, 4, $80, 1, $B0, $14, $F2, $39, $31, $72, 0, 4, $1B
                                        ; DATA XREF: ROM:000851DE   o
                dc.b    $15, $1F, $1F, $1F, $1F, $1F, $17, 5, $D, 8, 0, $17, $1C, $F, $F, $1F, $11, $1C, $80, 0
SFX_5F:         dc.b    0, $1B, 1, 1, $80, 5, 0, $A, $F, 0, $EF, 0, $F0, 1, 1, $D, $46, $87, $1D, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $7F, 0, 1, $1F
                                        ; DATA XREF: ROM:000851E2   o
                dc.b    $1D, $1F, $1F, $1F, $1F, $1C, $A, $1F, 0, 0, $D, 0, $17, 0, 9, $F, $1D, $10, $13, $80
SFX_60:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, $A, 3, $80, 1, $EF, 0, $F0, 1, 2, $E3, $66, $87, $1D, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $7E, 2
                                        ; DATA XREF: ROM:000851E6   o
                dc.b    0, $2F, $1D, $15, $1F, $1F, $1F, $1C, $A, $1F, 4, 9, 8, 5, $1F, $F, $F, $F, $19, $10, $15, $80
SFX_61:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, 0, 8, $EF, 0, $BA, $B, $E6, $1B, $A, $80, 1, $F2, $3A, $7F, $19, $30, $F, $1D, $14, $1D, $1C, $1F, $1C, $19
                                        ; DATA XREF: ROM:000851EA   o
                dc.b    $D, 0, 0, 0, 0, $F, $F, $F, $F, $20, $30, $20, $80, 0
SFX_62:         dc.b    0, $1B, 1, 1, $80, 5, 0, $A, 5, 0, $EF, 0, $F0, 1, 2, $E3, $66, $87, $1D, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $75, 5, 4, $25
                                        ; DATA XREF: ROM:000851EE   o
                dc.b    $D, $10, $12, $11, $1F, $1C, $A, $1F, 4, 9, 8, 0, $17, 0, 9, $F, $17, 5, $18, $80
SFX_63:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $AA, $1E, $E6, $1B, $15, $80, 1, $F2, $3A, $71, $10, $41, 7, $1D, $14, $D, $C, $1F
                                        ; DATA XREF: ROM:000851F2   o
                dc.b    $1C, $19, $D, $1F, $10, 1, 0, $1F, $1F, $1F, $F, $1B, 0, $16, $80, 0
SFX_64:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $AA, $1E, $E6, $1B, $15, $80, 1, $F2, $3A, $71, $10, $41, 7, $1D, $14, $D, $C, $1F
                                        ; DATA XREF: ROM:000851F6   o
                dc.b    $1C, $19, $D, $1F, $10, $11, 0, $1F, $1F, $1F, $F, $1B, 0, $16, $80, 0
SFX_65:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 0, 5, $80, 1, $EF, 0, $BA, 6, $E6, $12, 5, $80, 1, $F2, $3A, $71, 1, $30, 9, $1D, $14, $1F, $1F, $1F
                                        ; DATA XREF: ROM:000851FA   o
                dc.b    $1C, $19, $D, $1F, 0, 0, 0, $1F, $1F, $3F, $F, $2B, $20, $14, $80, 0
SFX_66:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $F4, $FF, $87, $38, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $B, $70, 2
                                        ; DATA XREF: ROM:000851FE   o
                dc.b    $16, $3E, $16, $D, $D, $E, $1F, $1A, $A, $1F, 6, 9, 0, 0, 7, 0, 9, $F, $20, $10, 0, $80
SFX_67:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 2, $80, 1, $EF, 0, $F0, 0, 1, $75, 1, $9A, $40, $80, 1, $F2, $39, $71, 0, $30, 1, $1D, $15, $12
                                        ; DATA XREF: ROM:00085202   o
                dc.b    $12, $1F, $1C, $19, $D, 6, $E, 4, 7, $1F, $2F, $F, $F, $1A, 5, 0, $80, 0
SFX_68:         dc.b    0, $1F, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 1, 1, $22, $FF, $8C, 4, $8B, 6, $E6, 1, $F7, 0, $C, $FF, $F8, $F2, $33
                                        ; DATA XREF: ROM:00085206   o
                dc.b    0, $11, 0, $F, $1B, $1F, $1F, $12, $10, $1F, $1D, $1F, $14, $19, 0, 0, $11, $F, $F, $F, $16, 0, 1, $80, $33, 9, $11, 0, $F, $1B, $1F, $1F
                dc.b    $12, $10, $1F, $1D, $1F, $14, $19, 0, 0, $11, $F, $F, $F, $16, 0, 1, $80, 0
SFX_69:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $55, 2, $9A, $74, $80, 1, $F2, $3A, $7F, 0, $31, $E, $1D, $15, $12
                                        ; DATA XREF: ROM:0008520A   o
                dc.b    $12, $1F, $1C, $19, 7, 0, 0, 0, 0, $1F, $1F, $1F, $1F, $26, $1D, $11, $80, 0
SFX_6A:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $55, 4, $9A, $54, $80, 1, $F2, $3A, $6F, 0, $30, $2D, $1D, $15, $12
                                        ; DATA XREF: ROM:0008520E   o
                dc.b    $12, $1F, $1C, $19, 7, 0, 0, 0, 9, $1F, $1F, $1F, $1F, $16, $D, $B, $80, 0
SFX_6B:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, $10, 2, $80, 1, $EF, 0, $F0, 0, 1, $15, 4, $9A, $54, $80, 1, $F2, $3A, $6F, $1F, $30, $28, $1D, $15, $10
                                        ; DATA XREF: ROM:00085212   o
                dc.b    $17, $1F, $1C, $19, $1F, 6, 0, 5, 4, $1F, $1F, $1F, $F, $1E, $1D, $1B, $80, 0
SFX_6C:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 4, $80, 1, $EF, 0, $F0, 0, 1, $E9, $FF, $9A, $14, $80, 1, $F2, $3A, $6F, 8, $38, $2F, $1D, $16, $10
                                        ; DATA XREF: ROM:00085216   o
                dc.b    $1F, $1F, $1C, $19, $1F, 0, 0, $10, 6, $1F, $1F, $1F, $F, $1B, $1A, 0, $80, 0
SFX_6D:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 4, $80, 1, $EF, 0, $F0, 0, 1, $F9, $FF, $9A, $30, $80, 1, $F2, $3A, $6F, 0, $33, $1F, $1D, $16, $10
                                        ; DATA XREF: ROM:0008521A   o
                dc.b    $1F, $1F, $1C, $19, $1F, 0, 0, $10, 6, $1F, $1F, $1F, $F, $B, $1A, 0, $80, 0
SFX_6E:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 4, $80, 1, $EF, 0, $F0, 0, 2, $19, $FF, $9A, $30, $80, 1, $F2, $3A, $78, 1, $3F, $1F, $1D, $16, $10
                                        ; DATA XREF: ROM:0008521E   o
                dc.b    $1F, $1F, $1C, $19, $1F, 4, $1C, $B, 0, $1F, $1F, $1F, $F, $B, $C, 0, $80, 0
SFX_6F:         dc.b    0, $25, 1, 1, $80, 5, 0, $A, 9, 4, $80, 1, $EF, 0, $9A, 4, $80, 1, $F7, 0, 4, $FF, $F8, $80, 1, $9A, 8, $80, 1, $E6, $1D, $F7
                                        ; DATA XREF: ROM:00085222   o
                dc.b    0, 2, $FF, $F6, $F2, $3A, $7F, 0, $32, $1F, $1D, $16, $1C, $1F, $1F, $1C, $19, $1F, 4, 0, $1D, 0, $1F, $1F, $1F, $F, $2A, $1B, $10, $80
SFX_70:         dc.b    0, $1E, 1, 1, $80, 5, 0, $A, $37, 0, $80, 1, $EF, 0, $95, $C, $80, 1, $9E, 8, $80, 1, $E6, $1D, $F7, 0, 2, $FF, $F6, $F2, $3A, $7F
                                        ; DATA XREF: ROM:00085226   o
                dc.b    8, $33, $1F, $1D, $16, $F, $1F, $1F, $1C, $1A, $1F, $10, $12, $D, 0, $1F, $1F, $2F, $F, $1D, $10, 0, $80, 0
SFX_71:         dc.b    0, $1E, 1, 1, $80, 5, 0, $A, 0, 3, $80, 1, $EF, 0, $90, 6, $80, 1, $9E, 6, $80, 1, $E6, 1, $F7, 0, $A, $FF, $F6, $F2, $3A, $78
                                        ; DATA XREF: ROM:0008522A   o
                dc.b    $D, $30, $F, $1D, $16, $F, $1F, $1F, $1C, $1A, $1F, 2, $10, $10, 0, $1F, $F, $1F, $F, $1D, $2E, $10, $80, 0
SFX_72:         dc.b    0, $19, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $6C, 4, $9B, $C, $E6, $20, 7, $F2, $3A, $F, 2, 1, $2F, $11, $15
                                        ; DATA XREF: ROM:0008522E   o
                dc.b    $1C, $1F, $1F, $1F, $F, 7, $B, $10, $10, 7, 7, $C, 9, $1D, $16, $1D, 4, $80
SFX_73:         dc.b    0, $20, 1, 1, $80, 5, 0, $A, $10, 3, $80, 1, $EF, 0, $87, 6, $80, 1, $8E, 6, $80, 1, $91, 6, $80, 1, $F7, 0, 3, $FF, $F0, $F2
                                        ; DATA XREF: ROM:00085232   o
                dc.b    $3A, $7F, $30, 8, $34, $1D, $15, $1F, $12, $1F, $1C, $A, $1F, 0, 0, 0, 0, $1F, $F, $F, $F, $16, $11, $20, $80, 0
SFX_74:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, $23, 3, $80, 1, $EF, 0, $87, 4, $80, 2, $F7, 0, 4, $FF, $F8, $F2, $3A, $7F, $F, $3F, $F, $1F, $1F, $1F
                                        ; DATA XREF: ROM:00085236   o
                dc.b    $1F, $11, $13, $10, $1F, 0, 0, $B, 0, $1F, $9F, $1F, $F, $18, $21, $15, $80, 0
SFX_75:         dc.b    0, $14, 1, 1, $80, 5, 0, $A, $20, 3, $80, 1, $EF, 0, $87, $7D, $E6, $20, $12, $F2, $3A, $7F, $3F, $F, $3F, $1D, $15, $1F, $1F, $1F, $1C, $A
                                        ; DATA XREF: ROM:0008523A   o
                dc.b    $1F, 1, 6, 0, 0, $1F, $F, $F, $F, $16, $10, $10, $80, 0
SFX_76:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, $A, 0, $80, 1, $EF, 0, $F0, 0, 1, $10, $66, $87, $7F, $F2, $3A, $23, 3, $4E, $30, $1D, $15, $17, $10, $1F
                                        ; DATA XREF: ROM:0008523E   o
                dc.b    $1C, $A, $1F, 4, 0, 8, 0, $19, 9, 7, $F, $24, $30, $1D, $80, 0
SFX_77:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, $A, 0, $80, 1, $EF, 0, $87, $23, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $7D, 8, $D, $2F, $1D, $15, $12
                                        ; DATA XREF: ROM:00085242   o
                dc.b    $17, $1F, $1C, $A, $1F, 0, 0, 8, 0, $1F, $F, $F, $F, $19, $2F, $1F, $80, 0
SFX_78:         dc.b    0, $16, 1, 1, $80, 5, 0, $A, 1, 0, $80, 1, $EF, 0, $F0, 0, 1, $F4, $FF, $87, $38, $F2, $B, $72, 0, $1C, $3F, $16, $1D, $1D, $12, $1F
                                        ; DATA XREF: ROM:00085246   o
                dc.b    $1A, $A, $1F, 6, 9, 2, 0, 7, 0, 9, $F, $10, $10, $10, $80, 0
SFX_79:         dc.b    0, $1D, 1, 1, $80, 5, 0, $A, $A, 4, $80, 1, $EF, 0, $F0, 1, 2, $33, $66, $87, $1D, $E6, $20, $F7, 0, 2, $FF, $F8, $F2, $3A, $75, 4
                                        ; DATA XREF: ROM:0008524A   o
                dc.b    $32, $F, $1D, $15, $1F, $1F, $1F, $1C, $A, $1F, 4, 9, 8, 0, $1F, $F, $F, $F, $11, 0, $20, $80
SFX_7A:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, $E0, 5, $EF, 0, $B4, 1, $F0, 0, 1, $10, $FF, $B1, $1D, $80, 3, $F2, $C, $11, $69, $1D, $70, $18, $12, $12
                                        ; DATA XREF: ROM:0008524E   o
                dc.b    $12, $F, $16, $18, $1F, 0, 0, 0, 0, 3, 9, 9, 9, $10, $80, $20, $80, 0
SFX_7B:         dc.b    0, $45, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $27, 0, 0, $EF, 1, $83, 6, $80, 2, $EF, 0, $F0, 0, 0, $C1, $FF, $8E, $12, $E6
                                        ; DATA XREF: ROM:00085252   o
                dc.b    6, $F7, 0, 5, $FF, $F8, $F2, $F3, $E7, $A3, 6, $80, 2, $F0, 0, 4, 4, $FF, $C2, 6, $E7, $F7, 0, $A, $FF, $F9, $EC, 1, $C2, 6, $E7, $F7
                dc.b    0, 5, $FF, $F7, $F2, $40, 3, 0, $11, $31, $1F, $1F, $1F, $1F, $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30, $F, $F, $12, $13, $10, $80, $40, $72
                dc.b    2, $11, $5A, $1F, $1F, $1A, $1F, $1E, $10, $1D, $1F, 2, $1B, 2, 0, $1F, $2F, $1F, $F, $13, 8, $10, $80, $40, 2, 0, $14, $35, $1F, $1F, $1F, $1F
                dc.b    $10, $1F, $D, $1F, $10, 0, 0, 0, $1F, $30, $F, $F, $12, $13, $10, $80
SFX_7C:         dc.b    0, $41, 1, 2, $80, 5, 0, $10, $10, 0, $80, $C0, 0, $29, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $C5, $FF, $83, 4, $80, 1, $EF, 1, $A0
                                        ; DATA XREF: ROM:00085256   o
                dc.b    8, $E6, 6, $F7, 0, 7, $FF, $F8, $F2, $80, 1, $F3, $E7, $F0, 0, 1, 4, $FF, $A9, 4, $80, 1, $C0, 8, $EC, 1, $E7, $F7, 0, 7, $FF, $F7
                dc.b    $F2, $32, 2, $10, $11, 9, $1B, $1F, $1F, $1F, $1E, $1F, $1D, $1F, 1, 4, 0, 0, $21, $1F, $F, $F, $11, $10, 0, $80, $35, 0, $30, 1, $10, $1B
                dc.b    $1F, $1F, $1F, $1E, $1F, $1D, $1F, 0, 0, 0, 0, 0, $F, $F, $F, $C, $80, $80, $80, $35, 2, $36, 1, $11, $1B, $1F, $1F, $1F, $1E, $1F, $1D, $1F
                dc.b    0, 0, 0, 0, 0, $F, $F, $F, $C, $80, $80, $80
SFX_7D:         dc.b    0, $41, 1, 2, $80, 5, 0, $10, 0, 0, $80, $C0, 0, $29, 0, 0, $80, 1, $EF, 0, $F0, 0, 1, $C5, $FF, $95, 4, $80, 1, $EF, 1, $90
                                        ; DATA XREF: ROM:0008525A   o
                dc.b    6, $E6, 4, $F7, 0, 9, $FF, $F8, $F2, $80, 1, $F3, $E7, $F0, 0, 1, 3, $FF, $A9, 4, $80, 1, $C6, 8, $EC, 1, $E7, $F7, 0, 7, $FF, $F7
                dc.b    $F2, $32, 1, $11, $10, 5, $1F, $1F, $1F, $1F, $1E, $1F, $1D, $1F, $11, $14, 0, 0, $21, $1F, $F, $F, $1D, 0, $10, $80, $32, 0, $32, 9, $17, $1F
                dc.b    $1F, $1F, $1F, $E, $1F, $1D, $1F, 0, 0, 0, 0, 0, $F, $F, $F, $11, $11, $10, $80, 0
SFX_7E:         dc.b    0, $3E, 1, 2, $80, 5, 0, $10, 0, 1, $80, $C0, 0, $28, 0, 0, $EF, 0, $8F, 3, $80, 2, $90, 5, $E6, 1, $99, $C, $E6, 5, $99, $A
                                        ; DATA XREF: ROM:0008525E   o
                dc.b    $F7, 0, 5, $FF, $F8, $80, 5, $F2, $80, 3, $F0, 0, 3, 3, $FF, $F3, $E7, $B5, $C, $E7, $C6, $1C, $EC, 1, $F7, 0, 3, $FF, $F7, $F2, $38, $71
                dc.b    0, 1, $60, $1F, $1F, $1F, $1F, $10, $18, $17, $1F, $11, $C, 0, 0, $13, $1D, $1F, $E, $17, 1, $10, $80, $3A, 3, $70, $30, 4, $1F, $1F, $1F, $1F
                dc.b    $18, $D, $15, $12, 7, $C, 0, 8, 3, 5, 9, $E, $E, $10, $10, $80
SFX_7F:         dc.b    0, $18, 1, 1, $80, 5, 0, $A, 0, 0, $80, 1, $EF, 0, $F0, 1, 1, $70, 1, $86, $36, $80, 2, $F2, $3A, $7F, $10, $20, $F, $1F, $1F, $1F
                                        ; DATA XREF: ROM:00085262   o
                dc.b    $1F, $1F, $1C, $19, 7, $C, 9, 0, 7, $1F, $1F, $1F, $1F, $14, 6, 0, $80, 0
SFX_F0:         dc.b    0, $52, 1, 3, $80, 4, 0, $16, $7A, 4, $80, 5, 0, $2D, 0, 4, $80, $C0, 0, $3D, 0, 0, $EF, 0, $B6, 3, $80, 1, $EF, 1, $F0, 1
                                        ; DATA XREF: ROM:00085132   o
                dc.b    1, $E, $FF, $A6, $B, $E6, 4, $F7, 0, 8, $FF, $F8, $F2, $EF, 2, $86, 3, $80, 1, $8D, $B, $E6, 4, $F7, 0, 8, $FF, $F8, $F2, $F3, $E7, $A5
                dc.b    3, $80, 1, $F0, 0, 2, $FE, $FF, $C4, $B, $EC, 1, $F7, 0, 8, $FF, $F8, $F2, $3D, $1E, $7D, $3F, $C, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $10
                dc.b    0, 0, 0, $E, $F, $F, $F, $E, $87, $88, $88, $3C, $75, $24, $19, $30, $1F, $1F, $1F, $1F, $1F, $1F, $15, $1F, $F, 0, 1, 0, $F, $F, $2F, $F
                dc.b    8, $80, $10, $80, $38, 2, $20, $22, $64, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1B, $10, $10, 0, $F, $F, $F, $F, $1D, $10, 2, $80, 0
SFX_F1:         dc.b    0, $2E, 1, 2, $80, 5, 0, $10, 0, 3, $80, 4, 0, $25, 0, 2, $80, 1, $EF, 1, $F0, 0, 1, $D2, $FF, $85, 4, $9A, 9, $E6, 8, $F7
                                        ; DATA XREF: ROM:00085136   o
                dc.b    0, 3, $FF, $F8, $F2, $80, 1, $EF, 0, $85, 4, $9A, $1B, $F2, $33, $F, $20, 3, $E, $1F, $1F, $1F, $1F, $10, $1F, $1D, $C, 1, 0, $11, $D, $11
                dc.b    $F, $F, $1F, $1A, $1C, 0, $80, $33, 0, $14, $E, $F, $1B, $1F, $1F, $12, $10, $1F, $1D, $1F, $15, $10, 0, 0, $11, $1F, $F, $F, $16, $10, 0, $80
SFX_F2:         dc.b    0, $13, 1, 1, $80, 4, 0, $A, 0, 2, $EF, 0, $A9, 2, $EF, 1, $AC, 7, $F2, $3B, $76, 6, 0, $1F, $15, $18, $11, $11, $15, $1F, $19, $1F
                                        ; DATA XREF: ROM:0008513A   o
                dc.b    1, 0, $F, 0, $F, $F, $1F, $1F, $E, $10, $D, $80, $2B, $70, $23, $F, $1F, $1F, $1F, $1F, $1F, $15, $1F, $19, $1F, 1, 0, 0, 0, $14, 5, 1
                dc.b    $B, 2, $16, $11, $80, 0
SFX_F3:         dc.b    0, $13, 1, 1, $80, 4, 0, $A, 0, 2, $EF, 0, $C9, 3, $EF, 1, $CC, $B, $F2, $3B, $70, 0, 2, $F, $15, $18, $11, $11, $15, $1F, $19, $1F
                                        ; DATA XREF: ROM:0008513E   o
                dc.b    $11, 0, $C, 0, $1F, $F, $1F, $1F, $F, $12, $1D, $80, $38, $70, $20, $F, $1F, $1F, $1F, $1F, $1F, $15, $1F, $19, $1F, $C, $10, 0, 0, $1F, $F, $F
                dc.b    $F, $1A, $14, 6, $80, 0
SFX_F4:         binclude "data/sound/SFX_F4.bin"
SFX_F4_End:
SFX_F5:         dc.b    0, $80, 1, 3, $80, 5, 0, $16, 0, 0, $80, 4, 0, $3D, 0, 0, $80, $C0, 0, $5F, 0, 6, $EF, 2, $81, 6, $F7, 0, $10, $FF, $FA, $EF
                                        ; DATA XREF: ROM:00085146   o
                dc.b    0, $F0, 0, 1, $D4, $FF, $FB, $FE, $81, 6, 6, 6, $FB, $FF, $F7, 0, $11, $FF, $F6, $81, 6, 6, 6, $F7, 0, $22, $FF, $F8, $F2, $EF, 3, $86
                dc.b    $60, $EF, 1, $F0, 0, 1, $F4, 8, $86, $60, $E7, $60, $E7, $60, $E7, $12, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $24, $F2, $F3
                dc.b    $E7, $F5, 0, $E7, $BF, $60, $E7, $BF, $20, $E7, $40, $E7, $60, $E7, $60, $E7, $12, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $60, $E7, $24, $F2
                dc.b    $3B, $10, $70, 2, 5, $1A, $1F, $1B, $1A, $1F, $1A, $A, $1F, $12, 0, 0, 0, $1F, $F, $F, $F, 8, 0, $1D, $82, $3D, 1, $70, $10, $10, $16, $1C
                dc.b    $1B, $1A, $1F, $1A, $A, $1F, 0, 0, 0, 0, $F, $F, $F, $F, $F, $80, $80, $80, $3B, $10, $70, 2, 5, $1A, $1F, $1B, $1A, $1F, $1A, $A, $1F, $12
                dc.b    0, 0, 0, $1F, $F, $F, $F, 8, 0, $1D, $80, $3D, 1, $70, $10, $10, $16, $1C, $1B, $1A, $1F, $1A, $A, $1F, 0, 0, 0, 0, $F, $F, $F, $F
                dc.b    $F, $80, $80, $80
SFX_F6:         dc.b    0, $6E, 1, 3, $80, 5, 0, $16, 0, 0, $80, 4, 0, $3C, 0, 0, $80, $C0, 0, $56, 0, 6, $EF, 0, $F0, 0, 1, $D4, $FF, $81, 6, 6
                                        ; DATA XREF: ROM:0008514A   o
                dc.b    6, $FB, 1, $F7, 0, $13, $FF, $F6, $81, 6, 6, 6, $F7, 0, 3, $FF, $F8, 6, 6, $E6, 8, 6, $F7, 0, 3, $FF, $F9, $F2, $EF, 1, $F0, 0
                dc.b    1, $F4, 8, $86, $60, $E7, $60, $E7, $60, $E7, $72, $E6, 2, $E7, $86, 2, $F7, 0, 9, $FF, $F7, $F2, $F3, $E7, $F5, 0, $BF, $20, $E7, $40, $E7, $60
                dc.b    $E7, $60, $E7, $72, $EC, 1, $E7, 3, $F7, 0, 6, $FF, $F8, $F2, $3B, $10, $70, 2, 5, $1A, $1F, $1B, $1A, $1F, $1A, $A, $1F, $12, 0, 0, 0, $1F
                dc.b    $F, $F, $F, 8, 0, $1D, $82, $3D, 1, $70, $10, $10, $16, $1C, $1B, $1A, $1F, $1A, $A, $1F, 0, 0, 0, 0, $F, $F, $F, $F, $F, $80, $80, $80
SFX_F7:         binclude "data/sound/SFX_F7.bin"
SFX_F7_End:
SFX_F8:         dc.b    0, $1C, 1, 1, $80, 5, 0, $A, 0, 2, $80, 1, $EF, 0, $F0, $45, 5, $F9, $FF, $B0, 7, $EF, 1, $AB, $7F, $E7, $60, $F2, $32, 2, $30, $11
                                        ; DATA XREF: ROM:00085152   o
                dc.b    $F, $1B, $1F, $1F, 6, $1E, $1F, $1D, $F, 1, $E, 0, $10, $31, $1F, $F, $1F, $21, $10, 0, $80, $31, $F, $2F, $20, $F, $1B, $1F, $1F, 4, $1E, $1F
                dc.b    $1D, $F, 6, 0, 7, 5, 1, $1F, $F, $1F, $20, $17, $16, $80
SFX_F9:         dc.b    0, $1C, 1, 1, $80, 4, 0, $A, $18, $D, $80, 1, $EF, 0, $F0, 0, 1, $1C, 1, $87, 7, $E7, $8C, 7, $F6, $FF, $F9, $F2, $32, 8, $10, $70
                                        ; DATA XREF: ROM:SpecialSFX_PointerTable   o
                dc.b    $2E, $1B, $F, $F, $D, $1F, $F, $1F, $1F, 0, $C, 0, 8, $1F, $F, $F, $F, $29, $10, $1A, $80, 0
SFX_FA:         dc.b    0, $19, 1, 1, $80, 4, 0, $A, $A, 6, $80, 1, $EF, 0, $F0, 1, 1, $22, $FF, $88, 7, $F6, $FF, $FC, $F2, $30, 2, $31, 1, 2, $1B, $1F
                                        ; DATA XREF: ROM:0008515A   o
                dc.b    $1F, $12, $1E, $1F, $1E, $1F, 1, $10, 9, 0, 1, $1F, $F, $F, $30, $20, $B, $80
SFX_FB:         dc.b    0, $32, 1, 1, $80, 4, 0, $A, $E9, 3, $FB, $17, $EF, 0, $F0, 1, 1, $22, $FF, $81, 4, 4, $FB, 1, $F7, 0, $16, $FF, $F7, $FB, $ED, $94
                                        ; DATA XREF: ROM:0008515E   o
                dc.b    4, $F7, 0, $30, $FF, $FA, $94, 4, $E6, 1, $F7, 0, $15, $FF, $F8, $EB, 3, $F2, $34, 1, $30, $11, 6, $1B, $1F, $1F, $12, $E, $1F, $E, $1F, 1
                dc.b    0, 9, 0, 1, $1F, $1F, $F, 6, $10, 9, $80, 0
SFX_FC:         dc.b    0, $19, 1, 1, $80, 4, 0, $A, $E0, $A, $EF, 0, $E7, $F0, 0, 1, $15, $15, $AB, $2C, $E7, $F6, $FF, $FB, $F2, $32, $36, 0, $76, $D, $1B, $1F
                                        ; DATA XREF: ROM:word_82DEC   t
                                        ; ROM:00085162   o
                dc.b    $F, $F, $1E, $1F, $1D, $1F, 0, 0, 0, 0, 1, $1F, $F, $F, $25, $17, $2F, $80
                align   $8000                           ; PCM data must be 32KB aligned for Z80 bank switching
PCMPart1:       binclude "data/sound/PCMPart1.bin"
PCMPart1_End:
PCMPart2:       binclude "data/sound/PCMPart2.bin"
PCMPart2_End:
PCMPart3:       binclude "data/sound/PCMPart3.bin"
PCMPart3_End:
PCMPart4:       binclude "data/sound/PCMPart4.bin"
PCMPart4_End:
PCMPart5:       binclude "data/sound/PCMPart5.bin"
PCMPart5_End:
PCMPart6:       binclude "data/sound/PCMPart6.bin"
PCMPart6_End:
PCMPart7:       binclude "data/sound/PCMPart7.bin"
PCMPart7_End:
PCMPart8:       binclude "data/sound/PCMPart8.bin"
PCMPart8_End:
PCMPart9:       binclude "data/sound/PCMPart9.bin"
PCMPart9_End:
                ; dc.b [$E5A2]$FF
                org     $E8000
