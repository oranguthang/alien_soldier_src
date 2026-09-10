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
                jsr     Sound_WriteCurrentFMRegisterIfNotOverridden(pc)  ; (pc)
                jsr     Sound_SendKeyOnIfAllowed(pc)    ; (pc)
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
                jsr     Sound_WriteYM2612Port1(pc)      ; (pc)
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
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
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
