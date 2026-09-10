Sound_ResetDriver:                                      ; CODE XREF: Sound_LoadBGMRequest+12   p  ; was: sub_834D2
                                        ; DATA XREF: Sound_LoadBGMRequest+12   o
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
                                        ; Sound_DispatchPendingRequest+E   j
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
                bra.w   Sound_StopAllPlayback
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
Sound_SendKeyOn:                                        ; CODE XREF: Sound_StopSpecialSFXAndRestoreBGMChannels+12   p  ; was: sub_8358A
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
Sound_WriteYM2612Wrapper:                               ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+8   p  ; was: sub_835A0
                                        ; Sound_StopAllPlayback+4   p
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
Sound_WriteYM2612Register:                              ; CODE XREF: Sound_ProcessPauseTransition+A4   p  ; was: sub_83618
                                        ; Sound_SetAllFMOperatorLevelsMaximum+E   p
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
Sound_DelayNOP:                                         ; CODE XREF: Sound_ProcessPauseTransition+40   p  ; was: sub_8367E
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
