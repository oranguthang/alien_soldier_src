; Load a BGM sequence from IDs $81-$9F
Sound_LoadBGMRequest:                                   ; CODE XREF: Sound_DispatchPendingRequest+3C   j  ; was: sub_82F6C
                cmpi.b  #$A0,d7
                bcs.w   Sound_InitializeBGM
                rts
; ---------------------------------------------------------------------------
Sound_InitializeBGM:                                    ; CODE XREF: Sound_LoadBGMRequest+4   j
                jsr     Sound_StopSFXAndRestoreBGMChannels(pc)  ; (pc)
                jsr     Sound_StopSpecialSFXAndRestoreBGMChannels(pc)  ; (pc)
                jsr     Sound_ResetPlaybackState(pc)    ; (pc)
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
                beq.s   Sound_InitializeBGMPSGChannels
                subq.b  #1,d7
                move.b  #$C0,d1
                move.b  #$80,d3
                move.b  4(a3),d4
                moveq   #$30,d6                         ; '0'
                move.b  #1,d5
                lea     (byte_FFF840).w,a1
                lea     Sound_BGMFMChannelTypes(pc),a2
Sound_InitializeNextBGMFMChannel:                       ; CODE XREF: Sound_LoadBGMRequest+8A   j  ; was: loc_82FD0
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
                dbf     d7,Sound_InitializeNextBGMFMChannel
Sound_InitializeBGMPSGChannels:                         ; CODE XREF: Sound_LoadBGMRequest+46   j  ; was: loc_82FFA
                moveq   #0,d7
                move.b  3(a3),d7
                beq.s   Sound_MarkBGMChannelsOverriddenBySFX
                subq.b  #1,d7
                lea     (byte_FFF990).w,a1
                lea     Sound_BGMPSGChannelTypes(pc),a2
Sound_InitializeNextBGMPSGChannel:                      ; CODE XREF: Sound_LoadBGMRequest+CA   j  ; was: loc_8300C
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
                dbf     d7,Sound_InitializeNextBGMPSGChannel
Sound_MarkBGMChannelsOverriddenBySFX:                   ; CODE XREF: Sound_LoadBGMRequest+94   j  ; was: loc_8303A
                lea     (byte_FFFA20).w,a1
                moveq   #5,d7
Sound_CheckNextActiveSFXChannel:                        ; CODE XREF: Sound_LoadBGMRequest+F8   j  ; was: loc_83040
                tst.b   (a1)
                bpl.w   Sound_ContinueActiveSFXChannelScan
                moveq   #0,d0
                move.b  1(a1),d0
                bmi.s   Sound_MapPSGSFXChannelIndex
                subq.b  #2,d0
                lsl.b   #2,d0
                bra.s   Sound_MarkBGMChannelOverridden
; ---------------------------------------------------------------------------
Sound_MapPSGSFXChannelIndex:                            ; CODE XREF: Sound_LoadBGMRequest+E0   j  ; was: loc_83054
                lsr.b   #3,d0
Sound_MarkBGMChannelOverridden:                         ; CODE XREF: Sound_LoadBGMRequest+E6   j  ; was: loc_83056
                lea     Sound_BGMChannelRecordPointers(pc),a0
                movea.l (a0,d0.w),a0
                bset    #2,(a0)
Sound_ContinueActiveSFXChannelScan:                     ; CODE XREF: Sound_LoadBGMRequest+D6   j  ; was: loc_83062
                adda.w  d6,a1
                dbf     d7,Sound_CheckNextActiveSFXChannel
                tst.w   (word_FFFB40).w
                bpl.s   Sound_MarkSpecialFMOverrideForBGM
                bset    #2,(byte_FFF900).w
Sound_MarkSpecialFMOverrideForBGM:                      ; CODE XREF: Sound_LoadBGMRequest+100   j  ; was: loc_83074
                tst.w   (word_FFFB70).w
                bpl.s   Sound_RefreshBGMFMChannels
                bset    #2,(byte_FFF9F0).w
Sound_RefreshBGMFMChannels:                             ; CODE XREF: Sound_LoadBGMRequest+10C   j  ; was: loc_83080
                lea     (word_FFF870).w,a5
                moveq   #5,d4
Sound_RefreshNextBGMFMChannel:                          ; CODE XREF: Sound_LoadBGMRequest+120   j  ; was: loc_83086
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
                adda.w  d6,a5
                dbf     d4,Sound_RefreshNextBGMFMChannel
                moveq   #2,d4
Sound_RefreshBGMPSGChannels:                            ; CODE XREF: Sound_LoadBGMRequest+12C   j  ; was: loc_83092
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
                adda.w  d6,a5
                dbf     d4,Sound_RefreshBGMPSGChannels
                btst    #2,(byte_FFF9F0).w
                bne.s   Sound_FinishBGMInitialization
                move.b  #$FF,(VDP_PSG).l
; Discard the caller's BGM-load return address and finish initialization
Sound_FinishBGMInitialization:                          ; CODE XREF: Sound_LoadBGMRequest+136   j  ; was: loc_830AC
                addq.w  #4,sp
                rts
; End of function Sound_LoadBGMRequest
; ---------------------------------------------------------------------------
Sound_BGMFMChannelTypes:    dc.b    6, 0, 1, 2, 4, 5, 6, 0  ; was: byte_830B0
                                        ; DATA XREF: Sound_LoadBGMRequest+60   o
Sound_BGMPSGChannelTypes:   dc.b    $80, $A0, $C0, 0    ; DATA XREF: Sound_LoadBGMRequest+9C   o  ; was: byte_830B8

; Loads regular SFX IDs $40-$7F and $A0-$F8 into the sound channels
Sound_LoadSFX:                                          ; CODE XREF: Sound_DispatchPendingRequest+34   j  ; was: sub_830BC
                cmpi.b  #$80,d7
                bcs.w   Sound_SelectLowRangeSFXPointerTable
                rts
; ---------------------------------------------------------------------------
Sound_SelectLowRangeSFXPointerTable:                    ; CODE XREF: Sound_LoadSFX+4   j  ; was: loc_830C6
                lea     SFX_PointerTable(pc),a0
                addi.w  #$1D,d7
                bra.w   Sound_ResolveSFXHeader
; ---------------------------------------------------------------------------
Sound_ValidateHighRangeSFXRequest:                      ; CODE XREF: Sound_DispatchPendingRequest+44   j  ; was: loc_830D2
                cmpi.b  #$F9,d7
                bcs.w   Sound_SelectHighRangeSFXPointerTable
                rts
; ---------------------------------------------------------------------------
Sound_SelectHighRangeSFXPointerTable:                   ; CODE XREF: Sound_LoadSFX+1A   j  ; was: loc_830DC
                lea     SFX_PointerTable(pc),a0
                subi.b  #$A0,d7
Sound_ResolveSFXHeader:                                 ; CODE XREF: Sound_LoadSFX+12   j  ; was: loc_830E4
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
Sound_InitializeNextSFXChannel:                         ; CODE XREF: Sound_LoadSFX:Sound_ContinueSFXChannelInitialization   j  ; was: loc_830FC
                moveq   #0,d3
                move.b  1(a1),d3
                move.b  d3,d4
                bmi.s   Sound_MapSFXPSGChannel
                subq.w  #2,d3
                lsl.w   #2,d3
                lea     Sound_BGMChannelRecordPointers(pc),a5
                movea.l (a5,d3.w),a5
                bset    #2,(a5)
                bra.s   Sound_ClearAndInitializeSFXChannel
; ---------------------------------------------------------------------------
Sound_MapSFXPSGChannel:                                 ; CODE XREF: Sound_LoadSFX+48   j  ; was: loc_83118
                lsr.w   #3,d3
                movea.l Sound_BGMChannelRecordPointers(pc,d3.w),a5
                bset    #2,(a5)
                cmpi.b  #$C0,d4
                bne.s   Sound_ClearAndInitializeSFXChannel
                move.b  d4,d0
                ori.b   #$1F,d0
                move.b  d0,(VDP_PSG).l
                bchg    #5,d0
                move.b  d0,(VDP_PSG).l
Sound_ClearAndInitializeSFXChannel:                     ; CODE XREF: Sound_LoadSFX+5A   j  ; was: loc_8313E
                                        ; Sound_LoadSFX+6A   j
                movea.l Sound_SFXChannelRecordPointers(pc,d3.w),a5
                movea.l a5,a2
                moveq   #$B,d0
Sound_ClearSFXChannelRecordLoop:                        ; CODE XREF: Sound_LoadSFX+8C   j  ; was: loc_83146
                clr.l   (a2)+
                dbf     d0,Sound_ClearSFXChannelRecordLoop
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
                bmi.s   Sound_ContinueSFXChannelInitialization
                move.b  #$C0,$27(a5)
Sound_ContinueSFXChannelInitialization:                 ; CODE XREF: Sound_LoadSFX+B4   j  ; was: loc_83178
                dbf     d7,Sound_InitializeNextSFXChannel
                tst.b   (byte_FFFA50).w
                bpl.s   Sound_MarkSpecialFMChannelOverridden
                bset    #2,(word_FFFB40).w
Sound_MarkSpecialFMChannelOverridden:                   ; CODE XREF: Sound_LoadSFX+C4   j  ; was: loc_83188
                tst.b   (byte_FFFB10).w
                bpl.s   Sound_LoadSFXReturn
                bset    #2,(word_FFFB70).w
Sound_LoadSFXReturn:                                    ; CODE XREF: Sound_LoadSFX+D0   j  ; was: locret_83194
                rts
; End of function Sound_LoadSFX
; ---------------------------------------------------------------------------
Sound_BGMChannelRecordPointers: dc.l    $FFFFF8D0, 0    ; DATA XREF: Sound_LoadBGMRequest:Sound_MarkBGMChannelOverridden   o  ; was: dword_83196
                                        ; Sound_LoadSFX+4E   o
                dc.l    $FFFFF900, $FFFFF930
                dc.l    $FFFFF990, $FFFFF9C0
                dc.l    $FFFFF9F0, $FFFFF9F0
Sound_SFXChannelRecordPointers: dc.l    $FFFFFA20, 0    ; DATA XREF: Sound_LoadSFX:Sound_ClearAndInitializeSFXChannel   r  ; was: dword_831B6
                dc.l    $FFFFFA50, $FFFFFA80
                dc.l    $FFFFFAB0, $FFFFFAE0
                dc.l    $FFFFFB10, $FFFFFB10

; Loads special SFX IDs $F9-$FC into the dedicated override channels
Sound_LoadSpecialSFX:                                   ; CODE XREF: Sound_DispatchPendingRequest+4C   j  ; was: sub_831D6
                cmpi.b  #$FD,d7
                bcs.w   Sound_ResolveSpecialSFXHeader
                rts
; ---------------------------------------------------------------------------
Sound_ResolveSpecialSFXHeader:                          ; CODE XREF: Sound_LoadSpecialSFX+4   j  ; was: loc_831E0
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
Sound_InitializeNextSpecialSFXChannel:                  ; CODE XREF: Sound_LoadSpecialSFX:Sound_ContinueSpecialSFXChannelInitialization   j  ; was: loc_83204
                move.b  1(a1),d4
                bmi.s   Sound_SelectSpecialSFXPSGChannel
                bset    #2,(byte_FFF900).w
                lea     (word_FFFB40).w,a5
                bra.s   Sound_ClearAndInitializeSpecialSFXChannel
; ---------------------------------------------------------------------------
Sound_SelectSpecialSFXPSGChannel:                       ; CODE XREF: Sound_LoadSpecialSFX+32   j  ; was: loc_83216
                bset    #2,(byte_FFF9F0).w
                lea     (word_FFFB70).w,a5
Sound_ClearAndInitializeSpecialSFXChannel:              ; CODE XREF: Sound_LoadSpecialSFX+3E   j  ; was: loc_83220
                movea.l a5,a2
                moveq   #$B,d0
Sound_ClearSpecialSFXChannelRecordLoop:                 ; CODE XREF: Sound_LoadSpecialSFX+50   j  ; was: loc_83224
                clr.l   (a2)+
                dbf     d0,Sound_ClearSpecialSFXChannelRecordLoop
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
                bmi.s   Sound_ContinueSpecialSFXChannelInitialization
                move.b  #$C0,$27(a5)
Sound_ContinueSpecialSFXChannelInitialization:          ; CODE XREF: Sound_LoadSpecialSFX+74   j  ; was: loc_83252
                dbf     d7,Sound_InitializeNextSpecialSFXChannel
                tst.b   (byte_FFFA50).w
                bpl.s   Sound_MarkSpecialPSGChannelOverridden
                bset    #2,(word_FFFB40).w
Sound_MarkSpecialPSGChannelOverridden:                  ; CODE XREF: Sound_LoadSpecialSFX+84   j  ; was: loc_83262
                tst.b   (byte_FFFB10).w
                bpl.s   Sound_LoadSpecialSFXReturn
                bset    #2,(word_FFFB70).w
                ori.b   #$1F,d4
                move.b  d4,(VDP_PSG).l
                bchg    #5,d4
                move.b  d4,(VDP_PSG).l
Sound_LoadSpecialSFXReturn:                             ; CODE XREF: Sound_LoadSpecialSFX+90   j  ; was: locret_83282
                rts
; End of function Sound_LoadSpecialSFX
; ---------------------------------------------------------------------------
Sound_UnreferencedSFXChannelPointers:   binclude "data/other/unused_10.bin"  ; was: unused_10

; Stop ordinary SFX channels and restore any BGM channels they displaced
Sound_StopSFXAndRestoreBGMChannels:                     ; CODE XREF: Sound_DispatchPendingRequest+68   j  ; was: sub_8329C
                                        ; Sound_LoadBGMRequest:Sound_InitializeBGM   p
                                        ; DATA XREF:
                clr.b   (byte_FFF800).w
                moveq   #$27,d0                         ; '''
                moveq   #0,d1
                jsr     Sound_WriteYM2612Port0Thunk(pc)  ; (pc)
                lea     (byte_FFFA20).w,a5
                moveq   #5,d6
Sound_StopNextSFXChannel:                               ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+9E   j  ; was: loc_832AE
                tst.b   (a5)
                bpl.w   Sound_ContinueSFXChannelStopLoop
                bclr    #7,(a5)
                moveq   #0,d3
                move.b  1(a5),d3
                bmi.s   Sound_RestoreBGMPSGChannel
                jsr     Sound_SendFMKeyOffIfAllowed(pc)  ; (pc)
                cmpi.b  #4,d3
                bne.s   Sound_SelectOverriddenBGMFMChannel
                tst.b   (word_FFFB40).w
                bpl.s   Sound_SelectOverriddenBGMFMChannel
                lea     (word_FFFB40).w,a5
                movea.l (dword_FFF824).w,a1
                bra.s   Sound_RestoreBGMFMChannel
; ---------------------------------------------------------------------------
Sound_SelectOverriddenBGMFMChannel:                     ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+2C   j  ; was: loc_832DA
                                        ; Sound_StopSFXAndRestoreBGMChannels+32   j
                subq.b  #2,d3
                lsl.b   #2,d3
                lea     Sound_BGMChannelRecordPointers(pc),a0
                movea.l a5,a3
                movea.l (a0,d3.w),a5
                movea.l (dword_FFF820).w,a1
Sound_RestoreBGMFMChannel:                              ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+3C   j  ; was: loc_832EC
                bclr    #2,(a5)
                bset    #1,(a5)
                move.b  $B(a5),d0
                jsr     Sound_ProgramFMInstrument(pc)   ; (pc)
                movea.l a3,a5
                bra.s   Sound_ContinueSFXChannelStopLoop
; ---------------------------------------------------------------------------
Sound_RestoreBGMPSGChannel:                             ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+22   j  ; was: loc_83300
                jsr     Sound_CheckPSGMute(pc)          ; (pc)
                lea     (word_FFFB70).w,a0
                cmpi.b  #$E0,d3
                beq.s   Sound_MarkBGMPSGChannelRestored
                cmpi.b  #$C0,d3
                beq.s   Sound_MarkBGMPSGChannelRestored
                lsr.b   #3,d3
                lea     Sound_BGMChannelRecordPointers(pc),a0
                movea.l (a0,d3.w),a0
Sound_MarkBGMPSGChannelRestored:                        ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+70   j  ; was: loc_8331E
                                        ; Sound_StopSFXAndRestoreBGMChannels+76   j
                bclr    #2,(a0)
                bset    #1,(a0)
                cmpi.b  #$E0,1(a0)
                bne.s   Sound_ContinueSFXChannelStopLoop
                move.b  $25(a0),(VDP_PSG).l
Sound_ContinueSFXChannelStopLoop:                       ; CODE XREF: Sound_StopSFXAndRestoreBGMChannels+14   j  ; was: loc_83336
                                        ; Sound_StopSFXAndRestoreBGMChannels+62   j
                adda.w  #$30,a5                         ; '0'
                dbf     d6,Sound_StopNextSFXChannel
                rts
; End of function Sound_StopSFXAndRestoreBGMChannels
; Stop the dedicated override channels and restore their displaced BGM channels
Sound_StopSpecialSFXAndRestoreBGMChannels:              ; CODE XREF: Sound_DispatchPendingRequest+6C   j  ; was: sub_83340
                                        ; Sound_LoadBGMRequest+E   p
                                        ; DATA XREF:
                lea     (word_FFFB40).w,a5
                tst.b   (a5)
                bpl.s   Sound_StopSpecialSFXPSGChannel
                bclr    #7,(a5)
                btst    #2,(a5)
                bne.s   Sound_StopSpecialSFXPSGChannel
                jsr     Sound_SendFMKeyOff(pc)          ; (pc)
                lea     (byte_FFF900).w,a5
                bclr    #2,(a5)
                bset    #1,(a5)
                tst.b   (a5)
                bpl.s   Sound_StopSpecialSFXPSGChannel
                movea.l (dword_FFF820).w,a1
                move.b  $B(a5),d0
                jsr     Sound_ProgramFMInstrument(pc)   ; (pc)
Sound_StopSpecialSFXPSGChannel:                         ; CODE XREF: Sound_StopSpecialSFXAndRestoreBGMChannels+6   j  ; was: loc_83372
                                        ; Sound_StopSpecialSFXAndRestoreBGMChannels+10   j
                lea     (word_FFFB70).w,a5
                tst.b   (a5)
                bpl.s   Sound_StopSpecialSFXAndRestoreBGMReturn
                bclr    #7,(a5)
                btst    #2,(a5)
                bne.s   Sound_StopSpecialSFXAndRestoreBGMReturn
                jsr     Sound_MutePSGChannel(pc)        ; (pc)
                lea     (byte_FFF9F0).w,a5
                bclr    #2,(a5)
                bset    #1,(a5)
                tst.b   (a5)
                bpl.s   Sound_StopSpecialSFXAndRestoreBGMReturn
                cmpi.b  #$E0,1(a5)
                bne.s   Sound_StopSpecialSFXAndRestoreBGMReturn
                move.b  $25(a5),(VDP_PSG).l
Sound_StopSpecialSFXAndRestoreBGMReturn:                ; CODE XREF: Sound_StopSpecialSFXAndRestoreBGMChannels+38   j  ; was: locret_833A8
                                        ; Sound_StopSpecialSFXAndRestoreBGMChannels+42   j
                rts
; End of function Sound_StopSpecialSFXAndRestoreBGMChannels
; Start the 40-step music fade-out at one volume step every four frames
Sound_StartMusicFadeOut:                                ; CODE XREF: Sound_DispatchPendingRequest:Sound_ControlRequestBranches   j  ; was: sub_833AA
                move.b  #3,(byte_FFF806).w
                move.b  #$28,(byte_FFF804).w            ; '('
                clr.b   (byte_FFF840).w
                rts
; End of function Sound_StartMusicFadeOut
; Advance the active music fade-out timer and channel attenuation
Sound_UpdateMusicFadeOut:                               ; CODE XREF: Sound_UpdateDriver+14   p  ; was: sub_833BC
                                        ; DATA XREF: Sound_UpdateDriver+14   o
                moveq   #0,d0
                move.b  (byte_FFF804).w,d0
                beq.s   Sound_UpdateMusicFadeOutReturn
                move.b  (byte_FFF806).w,d0
                beq.s   Sound_AdvanceMusicFadeOutStep
                subq.b  #1,(byte_FFF806).w
Sound_UpdateMusicFadeOutReturn:                         ; CODE XREF: Sound_UpdateMusicFadeOut+6   j  ; was: locret_833CE
                rts
; ---------------------------------------------------------------------------
Sound_AdvanceMusicFadeOutStep:                          ; CODE XREF: Sound_UpdateMusicFadeOut+C   j  ; was: loc_833D0
                subq.b  #1,(byte_FFF804).w
                beq.w   Sound_StopAllPlayback
                move.b  #3,(byte_FFF806).w
                lea     (word_FFF870).w,a5
                moveq   #5,d7
Sound_FadeNextBGMFMChannel:                             ; CODE XREF: Sound_UpdateMusicFadeOut+40   j  ; was: loc_833E4
                tst.b   (a5)
                bpl.s   Sound_ContinueBGMFMFadeLoop
                addq.b  #1,9(a5)
                bpl.s   Sound_ApplyBGMFMFadeVolume
                bclr    #7,(a5)
                bra.s   Sound_ContinueBGMFMFadeLoop
; ---------------------------------------------------------------------------
Sound_ApplyBGMFMFadeVolume:                             ; CODE XREF: Sound_UpdateMusicFadeOut+30   j  ; was: loc_833F4
                jsr     Sound_ApplyFMVolumeOffset(pc)   ; (pc)
Sound_ContinueBGMFMFadeLoop:                            ; CODE XREF: Sound_UpdateMusicFadeOut+2A   j  ; was: loc_833F8
                                        ; Sound_UpdateMusicFadeOut+36   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,Sound_FadeNextBGMFMChannel
                moveq   #2,d7
Sound_FadeNextBGMPSGChannel:                            ; CODE XREF: Sound_UpdateMusicFadeOut+68   j  ; was: loc_83402
                tst.b   (a5)
                bpl.s   Sound_ContinueBGMPSGFadeLoop
                addq.b  #1,9(a5)
                cmpi.b  #$10,9(a5)
                bcs.s   Sound_ApplyBGMPSGFadeVolume
                bclr    #7,(a5)
                bra.s   Sound_ContinueBGMPSGFadeLoop
; ---------------------------------------------------------------------------
Sound_ApplyBGMPSGFadeVolume:                            ; CODE XREF: Sound_UpdateMusicFadeOut+54   j  ; was: loc_83418
                move.b  9(a5),d6
                jsr     Sound_ApplyPSGVolume(pc)        ; (pc)
; Continue the PSG fade-out channel loop
Sound_ContinueBGMPSGFadeLoop:                           ; CODE XREF: Sound_UpdateMusicFadeOut+48   j  ; was: loc_83420
                                        ; Sound_UpdateMusicFadeOut+5A   j
                adda.w  #$30,a5                         ; '0'
                dbf     d7,Sound_FadeNextBGMPSGChannel
                rts
; End of function Sound_UpdateMusicFadeOut
; Processes sound tempo tick and increments channel timers
Sound_ProcessTempoTick:                                 ; CODE XREF: Sound_UpdateDriver+10   p  ; was: sub_8342A
                                        ; DATA XREF: Sound_UpdateDriver+10   o
                tst.b   (byte_FFF802).w
                beq.s   Sound_ProcessTempoTickReturn
                subq.b  #1,(byte_FFF801).w
                bne.s   Sound_ProcessTempoTickReturn
                move.b  (byte_FFF802).w,(byte_FFF801).w
                lea     (byte_FFF840).w,a0
                moveq   #$30,d0                         ; '0'
                moveq   #9,d1
Sound_AdvanceNextChannelTempoTimer:                     ; CODE XREF: Sound_ProcessTempoTick+24   j  ; was: loc_83444
                tst.b   (a0)
                bpl.s   Sound_ContinueChannelTempoLoop
                addq.b  #1,$E(a0)
Sound_ContinueChannelTempoLoop:                         ; CODE XREF: Sound_ProcessTempoTick+1C   j  ; was: loc_8344C
                adda.w  d0,a0
                dbf     d1,Sound_AdvanceNextChannelTempoTimer
Sound_ProcessTempoTickReturn:                           ; CODE XREF: Sound_ProcessTempoTick+4   j  ; was: locret_83452
                                        ; Sound_ProcessTempoTick+A   j
                rts
; End of function Sound_ProcessTempoTick
; Maximize total level and release rate for all operators of the current FM channel
Sound_SilenceCurrentFMOperators:                        ; CODE XREF: Sound_SilenceFMOperatorsAndStopChannel   p  ; was: sub_83454
                moveq   #3,d4
                moveq   #$40,d3                         ; '@'
                moveq   #$7F,d1
Sound_SetNextFMOperatorTotalLevel:                      ; CODE XREF: Sound_SilenceCurrentFMOperators+E   j  ; was: loc_8345A
                move.b  d3,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                addq.b  #4,d3
                dbf     d4,Sound_SetNextFMOperatorTotalLevel
                moveq   #3,d4
                move.b  #$80,d3
                moveq   #$F,d1
Sound_SetNextFMOperatorReleaseRate:                     ; CODE XREF: Sound_SilenceCurrentFMOperators+22   j  ; was: loc_8346E
                move.b  d3,d0
                jsr     Sound_WriteCurrentFMChannelRegister(pc)  ; (pc)
                addq.b  #4,d3
                dbf     d4,Sound_SetNextFMOperatorReleaseRate
                rts
; End of function Sound_SilenceCurrentFMOperators
; Sends key-off to all FM channels
Sound_KeyOffAllFMChannels:                              ; CODE XREF: Sound_StopAllPlayback+1C   p  ; was: sub_8347C
                                        ; DATA XREF: Sound_StopAllPlayback+1C   o
                moveq   #2,d2
                moveq   #$28,d0                         ; '('
Sound_KeyOffNextFMChannelPair:                          ; CODE XREF: Sound_KeyOffAllFMChannels+10   j  ; was: loc_83480
                move.b  d2,d1
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                addq.b  #4,d1
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                dbf     d2,Sound_KeyOffNextFMChannelPair
; End of function Sound_KeyOffAllFMChannels
; Set maximum attenuation on every operator of all six FM channels
Sound_SetAllFMOperatorLevelsMaximum:                    ; CODE XREF: Sound_ProcessPauseTransition+5C   p  ; was: sub_83490
                moveq   #$7F,d1
                moveq   #2,d2
Sound_SetNextFMChannelOperatorLevels:                   ; CODE XREF: Sound_SetAllFMOperatorLevelsMaximum+18   j  ; was: loc_83494
                moveq   #$40,d0                         ; '@'
                add.w   d2,d0
                moveq   #3,d3
Sound_SetNextFMOperatorLevelMaximum:                    ; CODE XREF: Sound_SetAllFMOperatorLevelsMaximum+14   j  ; was: loc_8349A
                jsr     Sound_WriteYM2612Port0(pc)      ; (pc)
                jsr     Sound_WriteYM2612Port1(pc)      ; (pc)
                addq.w  #4,d0
                dbf     d3,Sound_SetNextFMOperatorLevelMaximum
                dbf     d2,Sound_SetNextFMChannelOperatorLevels
                rts
; End of function Sound_SetAllFMOperatorLevelsMaximum
; Clear playback state and silence every FM and PSG channel
Sound_StopAllPlayback:                                  ; CODE XREF: Sound_DispatchPendingRequest+1C   j  ; was: sub_834AE
                                        ; Sound_DispatchPendingRequest+70   j
                moveq   #$27,d0                         ; '''
                moveq   #0,d1
                jsr     Sound_WriteYM2612Port0Thunk(pc)  ; (pc)
                lea     (byte_FFF800).w,a0
                move.w  #$E3,d0
; Clear the playback-state region in longwords
Sound_ClearPlaybackRAMLoop:                             ; CODE XREF: Sound_StopAllPlayback+12   j  ; was: loc_834BE
                clr.l   (a0)+
                dbf     d0,Sound_ClearPlaybackRAMLoop
                move.b  #$FF,(byte_FFF809).w
                jsr     Sound_KeyOffAllFMChannels(pc)   ; (pc)
                bra.w   Sound_MuteAllPSGChannels
; End of function Sound_StopAllPlayback
; Resets sound driver state and clears RAM
