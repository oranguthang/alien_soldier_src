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
