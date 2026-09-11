Scroll_CalculateOffsets2:
                move.w  (dword_FFA908).w,d0             ; was: sub_109A8
                subi.w  #$60,d0                         ; '`'
                move.w  (dword_FFA90C).w,d1
                lea     Gfx_FrontendAlternateVRAMTransferParameters(pc),a0
                nop
                bra.s   loc_109E0
; End of function Scroll_CalculateOffsets2
; Adjusts camera position for Stage 21
Scroll_Stage21CameraOffset:
                move.w  (dword_FFA900).w,d0             ; was: sub_109BC
                subi.w  #$60,d0                         ; '`'
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                bra.s   loc_109DA
; End of function Scroll_Stage21CameraOffset
; Renders multi-layer Sylpheed stage background using tile lookups
Gfx_RenderSylpheedBackground:                           ; CODE XREF: Stage_Stage17Transition+24   p  ; was: sub_109CE
                                        ; Scroll_RenderSylpheedWithUpdate+4   j
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0                         ; '`'
                move.w  (dword_FFA904).w,d1
loc_109DA:                                              ; CODE XREF: Scroll_Stage21CameraOffset+10   j
                lea     Gfx_TitleAndZLeoVRAMTransferParameters(pc),a0
                nop
loc_109E0:                                              ; CODE XREF: Stage_SylpheedCameraLock+4A   j
                                        ; Gfx_LoadSylpheedTiles+20   j
                neg.w   d1
                moveq   #$F,d7
                move.w  d1,d2
                lsr.w   #3,d2
                andi.w  #$3E0,d2
                move.w  d2,(dword_FF8058).w
                move.w  d1,d2
                lsr.w   #2,d2
                andi.w  #$38,d2                         ; '8'
                move.w  d2,(dword_FF8058+2).w
                move.w  d1,d2
                andi.w  #$18,d2
                move.w  d2,(word_FF805C).w
                moveq   #$FFFFFFFF,d2
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$1F80,d2
                move.l  d2,(dword_FF805E).w
loc_10A14:                                              ; CODE XREF: Gfx_RenderSylpheedBackground+C4   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  (dword_FF8058).w,d3
                lsr.w   #8,d2
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  (dword_FF8058+2).w,d3
                lsr.w   #5,d2
                andi.w  #7,d2
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.w  (VDPStagingDataCursor).w,d3
                lsr.w   #2,d2
                andi.w  #$78,d2                         ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  (word_FF805C).w,d3
                add.w   d4,d3
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10A88
                move.l  (dword_FF805E).w,d4
                add.w   d4,d2
                movea.l d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10A88:                                              ; CODE XREF: Gfx_RenderSylpheedBackground+9E   j
                suba.l  #$E,a0
                addi.w  #$20,d0                         ; ' '
                dbf     d7,loc_10A14
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$83,-(a1)
                add.w   $E(a0),d2
                move.w  d2,-(a1)
                move.b  (VDPStagingDataCursor).w,d1
                move.b  (VDPStagingDataCursor+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(VDPCommandQueueHead).w
                addi.w  #$80,(VDPStagingDataCursor).w
                rts
; End of function Gfx_RenderSylpheedBackground
; Gets background scroll position
Scroll_GetBackgroundPosition:                           ; CODE XREF: Cutscene_XiTigerScrollSetup+72   j  ; was: sub_10ADC
                move.w  (dword_FFA908).w,d0
                move.w  (dword_FFA90C).w,d1
; End of function Scroll_GetBackgroundPosition
; Loads pointer to data table 1
Data_LoadPointerTable1:                                 ; CODE XREF: UI_InitializeResultsScreen+50   p  ; was: sub_10AE4
                lea     Gfx_FrontendAlternateVRAMTransferParameters(pc),a0
                nop
                bra.s   Gfx_DirectVRAMTransfer
; End of function Data_LoadPointerTable1
; Gets foreground scroll position
Scroll_GetForegroundPosition:                           ; CODE XREF: Cutscene_XiTigerScrollSetup+66   p  ; was: sub_10AEC
                                        ; Stage_InitPlayerAndScroll+3C   p
                move.w  (dword_FFA900).w,d0
                move.w  (dword_FFA904).w,d1
; End of function Scroll_GetForegroundPosition
; Loads pointer to data table 2
Data_LoadPointerTable2:                                 ; CODE XREF: UI_InitSecondaryOptionsMenu+50   p  ; was: sub_10AF4
                                        ; UI_InitPasswordScreen+5A   p
                lea     Gfx_TitleAndZLeoVRAMTransferParameters(pc),a0
                nop
; End of function Data_LoadPointerTable2
; Performs direct VRAM transfer with Z80 bus control and DMA setup
Gfx_DirectVRAMTransfer:                                 ; CODE XREF: Cutscene_InitCreditsScreen+58   p  ; was: sub_10AFA
                                        ; UI_InitTitleScreen+90   p
                move    sr,-(sp)
                move    #$2700,sr
loc_10B00:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+E   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_10B00
                lea     (VDP_CTRL).l,a4
                move.w  (VDPReg1Shadow).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                neg.w   d1
                moveq   #$1F,d6
loc_10B1E:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+102   j
                moveq   #$F,d7
loc_10B20:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+C4   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #8,d2
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                move.w  d4,d5
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #5,d2
                lsr.w   #2,d3
                andi.w  #7,d2
                andi.w  #$38,d3                         ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.l  #$FFFFA980,d3
                lsr.w   #2,d2
                andi.w  #$78,d2                         ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10B7C
                moveq   #0,d3
loc_10B7C:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+7E   j
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10BB4
                movea.l #$FFFF0000,a2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                adda.w  d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10BB4:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+94   j
                suba.l  #$E,a0
                addi.w  #$20,d0                         ; ' '
                dbf     d7,loc_10B20
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                move.w  #$8F02,(a4)
                move.l  #$93409400,(a4)
                move.w  #$95C0,(a4)
                move.w  #$96D4,(a4)
                move.w  #$977F,(a4)
                add.w   $E(a0),d2
                move.w  d2,(VDPCommand+2).w
                move.w  #$83,(VDPCommand).w
                move.w  (VDPCommand+2).w,(a4)
                move.w  (VDPCommand).w,(a4)
                subi.w  #$200,d0
                addq.w  #8,d1
                dbf     d6,loc_10B1E
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_10C0A:                                              ; CODE XREF: Gfx_DirectVRAMTransfer+118   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_10C0A
                move    (sp)+,sr
                rts
; End of function Gfx_DirectVRAMTransfer
; Renders scrolling background tiles with double buffering
Gfx_RenderScrollingBackground:                          ; CODE XREF: StoryScreen_WaitForScrollAndLoadPalette+16   p  ; was: sub_10C18
                                        ; StoryScreen_WaitForScrollAndLoadPalette+1C   p
                movea.l (dword_FFA940).w,a0
                move.w  (word_FFA946).w,d0
                move.w  (word_FFA948).w,d1
                neg.w   d1
                moveq   #$F,d7
loc_10C28:                                              ; CODE XREF: Gfx_RenderScrollingBackground+AC   j
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #8,d2
                lsr.w   #3,d3
                andi.w  #$3E0,d3
                add.w   d3,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                move.w  d4,d5
                lsl.w   #6,d4
                movea.l (a0)+,a1
                move.w  d0,d2
                move.w  d1,d3
                lsr.w   #5,d2
                lsr.w   #2,d3
                andi.w  #7,d2
                andi.w  #$38,d3                         ; '8'
                add.w   d3,d2
                add.w   d4,d2
                moveq   #0,d4
                move.b  (a1,d2.w),d4
                lsl.w   #5,d4
                move.w  d0,d2
                move.w  (VDPStagingDataCursor).w,d3
                lsr.w   #2,d2
                andi.w  #$78,d2                         ; 'x'
                add.w   d2,d3
                movea.w d3,a2
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   loc_10C82
                moveq   #0,d3
loc_10C82:                                              ; CODE XREF: Gfx_RenderScrollingBackground+66   j
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
                tst.w   (a0)+
                beq.w   loc_10CBA
                movea.l #$FFFF0000,a2
                move.w  d1,d4
                lsl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                adda.w  d2,a2
                move.w  (a1,d3.w),(a2)+
                move.w  2(a1,d3.w),(a2)+
                move.w  4(a1,d3.w),(a2)+
                move.w  6(a1,d3.w),(a2)+
loc_10CBA:                                              ; CODE XREF: Gfx_RenderScrollingBackground+7C   j
                suba.l  #$E,a0
                addi.w  #$20,d0                         ; ' '
                dbf     d7,loc_10C28
                move.w  d1,d2
                lsl.w   #4,d2
                andi.w  #$F80,d2
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$83,-(a1)
                add.w   $E(a0),d2
                move.w  d2,-(a1)
                move.b  (VDPStagingDataCursor).w,d1
                move.b  (VDPStagingDataCursor+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009340,-(a1)
                move.w  a1,(VDPCommandQueueHead).w
                addi.w  #$80,(VDPStagingDataCursor).w
                subq.w  #8,(word_FFA948).w
                subq.w  #1,(word_FFA944).w
                rts
; End of function Gfx_RenderScrollingBackground
; Renders multi-layer background using tilemaps
