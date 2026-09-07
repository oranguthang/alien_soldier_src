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
