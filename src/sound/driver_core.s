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
