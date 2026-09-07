Boss_SunsetStingUpdateCore:                             ; CODE XREF: Boss_SunsetStingSegmentMove:loc_434C8   p  ; was: sub_428B4
                                        ; sub_43738:loc_43754   p
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                subi.w  #$780,d0
                bpl.s   loc_428C4
                neg.w   d0
loc_428C4:                                              ; CODE XREF: Boss_SunsetStingUpdateCore+C   j
                cmpi.w  #$100,d0
                bcc.s   loc_428DC
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                bpl.s   loc_428D6
                neg.w   d0
loc_428D6:                                              ; CODE XREF: Boss_SunsetStingUpdateCore+1E   j
                cmpi.w  #$A0,d0
                bcs.s   locret_428DE
loc_428DC:                                              ; CODE XREF: Boss_SunsetStingUpdateCore+14   j
                moveq   #0,d0
locret_428DE:                                           ; CODE XREF: Boss_SunsetStingUpdateCore+26   j
                rts
; End of function Boss_SunsetStingUpdateCore
; Updates wave distortion screen effect
Boss_SunsetStingUpdateWaveScreen:                       ; CODE XREF: Boss_SunsetStingMain+A   p  ; was: sub_428E0
                cmpi.b  #$FF,(a4)
                bne.s   loc_428EE
                move.w  #$60,(word_FFE400).w            ; '`'
                rts
; ---------------------------------------------------------------------------
loc_428EE:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+4   j
                move.l  $10(a3),d0
                btst    #0,(a4)
                beq.w   loc_42996
                lea     (dword_FF99A0).w,a0
                moveq   #$A,d7
loc_42900:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+28   j
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                move.l  d0,-(a0)
                dbf     d7,loc_42900
                moveq   #$1B,d7
                move.l  $58(a5),d1
                move.l  d1,d2
                asr.l   #4,d2
loc_42916:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+42   j
                move.l  d0,-(a0)
                add.l   d1,d0
                add.l   d2,d1
                move.l  d0,-(a0)
                add.l   d1,d0
                add.l   d2,d1
                dbf     d7,loc_42916
                move.l  d0,$10(a5)
                lea     (word_FFE400).w,a0
                move.w  $14(a5),d0
                move.w  d0,d1
                subi.w  #$AC,d1
                move.w  d1,(dword_FFA90C).w
                subi.w  #$94,d0
                lsl.w   #2,d0
                adda.w  d0,a0
                move.w  $10(a5),d0
                moveq   #9,d7
loc_4294A:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+7C   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                lea     $10(a0),a0
                dbf     d7,loc_4294A
                lea     (word_FF9810).w,a1
                moveq   #$18,d7
loc_42966:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+B0   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                move.w  (a1),(a0)
                move.w  4(a1),4(a0)
                move.w  8(a1),8(a0)
                move.w  $C(a1),$C(a0)
                lea     $10(a0),a0
                lea     $10(a1),a1
                dbf     d7,loc_42966
                rts
; ---------------------------------------------------------------------------
loc_42996:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+16   j
                swap    d0
                move.w  d0,(word_FFE400).w
                lea     (word_FF9CE0).w,a0
                moveq   #0,d0
                move.w  #$158,d7
                sub.w   $14(a3),d7
                lsr.w   #1,d7
                move.w  #$1E0,d2
loc_429B0:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+D4   j
                move.w  d2,-(a0)
                addq.w  #2,d2
                dbf     d7,loc_429B0
                move.w  $14(a3),d0
                subi.w  #$71,d0                         ; 'q'
                move.l  d0,d1
                subi.w  #$AC,d0
                neg.w   d0
                move.w  $14(a5),d2
                sub.w   d2,d1
                beq.s   loc_42A04
                move.w  d1,d7
                addi.w  #$48,d7                         ; 'H'
                asr.w   #1,d7
                subq.w  #1,d7
                tst.w   d1
                bpl.s   loc_429E2
                neg.w   d1
                moveq   #0,d2
loc_429E2:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+FC   j
                asl.w   #8,d1
                divs.w  d7,d1
                ext.l   d1
                tst.w   d2
                bne.s   loc_429EE
                neg.l   d1
loc_429EE:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+10A   j
                asl.l   #8,d1
loc_429F0:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+120   j
                swap    d0
                add.l   d1,d0
                swap    d0
                move.w  d0,-(a0)
                cmpa.l  #$FFFF9C00,a0
                ble.s   locret_42A0E
                dbf     d7,loc_429F0
loc_42A04:                                              ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+EE   j
                                        ; Boss_SunsetStingUpdateWaveScreen+12C   j
                move.w  d0,-(a0)
                cmpa.l  #$FFFF9C00,a0
                bne.s   loc_42A04
locret_42A0E:                                           ; CODE XREF: Boss_SunsetStingUpdateWaveScreen+11E   j
                rts
; End of function Boss_SunsetStingUpdateWaveScreen
; Main Sunset Sting boss handler
