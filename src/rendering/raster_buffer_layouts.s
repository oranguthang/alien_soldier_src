RasterBuffer_CopySelectedLayout:                        ; CODE XREF: Sys_VBlankHandler+24   p  ; was: sub_29E2E
                move.w  (RasterLayoutOffset).w,d0
                movea.w RasterBuffer_LayoutOffsets(pc,d0.w),a0
                adda.l  #RasterBuffer_CopyXiTigerOffsets,a0
                jmp     (a0)
; End of function RasterBuffer_CopySelectedLayout
; ---------------------------------------------------------------------------
RasterBuffer_LayoutOffsets: dc.w    RasterBuffer_Return-RasterBuffer_CopyXiTigerOffsets  ; was: off_29E3E
                                        ; DATA XREF: RasterBuffer_CopySelectedLayout+4   r
                dc.w    RasterBuffer_CopyXiTigerOffsets-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyTransitionLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyWeaponSetupLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyFliesLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyControlWord-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyFlyingNeoLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyBossTransitionWindow-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyStoryTransitionLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyGameOverLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyAlternateTransitionLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyStageTransitionLayout-RasterBuffer_CopyXiTigerOffsets
                dc.w    RasterBuffer_CopyZLeoControlBlock-RasterBuffer_CopyXiTigerOffsets

; Initializes VRAM layout for Xi-Tiger cutscene
RasterBuffer_CopyXiTigerOffsets:                        ; DATA XREF: RasterBuffer_CopySelectedLayout+8   o  ; was: sub_29E58
                                        ; ROM:RasterBuffer_LayoutOffsets   o
                movea.w #(CutsceneLineOffsetTable-M68K_RAM),a2
                movea.w #(XiTigerVScrollBuffer-M68K_RAM),a3
                moveq   #0,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyXiTigerOffsets
; Copies and expands the standard transition raster buffers
RasterBuffer_CopyTransitionLayout:                      ; DATA XREF: ROM:00029E42   o  ; was: sub_29E66
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #3,d7
                bsr.w   RasterBuffer_Copy64ByteBlocks
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(HScrollPlaneBRow2-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   RasterBuffer_CopyPairedRows
; End of function RasterBuffer_CopyTransitionLayout
; Copies and expands the alternate transition raster buffers
RasterBuffer_CopyAlternateTransitionLayout:             ; DATA XREF: ROM:00029E52   o  ; was: sub_29E82
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #1,d7
                bsr.w   RasterBuffer_Copy64ByteBlocks
                movea.w #(word_FF9600-M68K_RAM),a2
                movea.w #(HScrollPlaneBRow4-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   RasterBuffer_CopyRepeatedRows
; End of function RasterBuffer_CopyAlternateTransitionLayout
; Copies the story-transition raster layout
RasterBuffer_CopyStoryTransitionLayout:                 ; DATA XREF: ROM:00029E4E   o  ; was: sub_29E9E
                movea.w #(RasterStagingBuffer-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #7,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyStoryTransitionLayout
; Copies the weapon-setup raster layout
RasterBuffer_CopyWeaponSetupLayout:                     ; DATA XREF: ROM:00029E44   o  ; was: sub_29EAC
                movea.w #(RasterStagingBuffer-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #3,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyWeaponSetupLayout
; Copies the Flies-stage raster layout
RasterBuffer_CopyFliesLayout:                           ; DATA XREF: ROM:00029E46   o  ; was: sub_29EBA
                movea.w #(RasterStagingBuffer-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #1,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyFliesLayout
; Copies one raster control word into its active slot
RasterBuffer_CopyControlWord:                           ; DATA XREF: ROM:00029E48   o  ; was: sub_29EC8
                move.w  (ShiperRasterControl).w,(ActiveRasterBuffer).w
                rts
; End of function RasterBuffer_CopyControlWord
; Copies the Flying Neo raster layout
RasterBuffer_CopyFlyingNeoLayout:                       ; DATA XREF: ROM:00029E4A   o  ; was: sub_29ED0
                movea.w #(word_FF9500-M68K_RAM),a2
                movea.w #(ActiveRasterBuffer-M68K_RAM),a3
                moveq   #0,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyFlyingNeoLayout
; Copies the shared boss-transition raster window
RasterBuffer_CopyBossTransitionWindow:                  ; DATA XREF: ROM:00029E4C   o  ; was: sub_29EDE
                movea.w #(BossPerspectiveRows-M68K_RAM),a2
                movea.w #(BossTransitionRaster-M68K_RAM),a3
                moveq   #2,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyBossTransitionWindow
; Copies and expands the Game Over raster buffers
RasterBuffer_CopyGameOverLayout:                        ; DATA XREF: ROM:00029E50   o  ; was: sub_29EEC
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(RasterStagingBuffer-M68K_RAM),a3
                moveq   #6,d7
                bsr.w   RasterBuffer_Copy64ByteBlocks
                movea.w #(GameOverRasterBuffer-M68K_RAM),a2
                movea.w #(HScrollBuffer-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   RasterBuffer_Copy64ByteBlocks
; End of function RasterBuffer_CopyGameOverLayout
; Copies and expands the shared stage-transition raster buffers
RasterBuffer_CopyStageTransitionLayout:                 ; DATA XREF: ROM:00029E54   o  ; was: sub_29F08
                movea.w #(dword_FF9A00-M68K_RAM),a2
                movea.w #(RasterStagingBuffer-M68K_RAM),a3
                moveq   #3,d7
                bsr.w   RasterBuffer_Copy64ByteBlocks
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(HScrollBuffer-M68K_RAM),a3
                moveq   #$D,d7
                bra.w   RasterBuffer_CopyPairedRows
; End of function RasterBuffer_CopyStageTransitionLayout
; Copies the Z-Leo raster control block
RasterBuffer_CopyZLeoControlBlock:                      ; DATA XREF: ROM:00029E56   o  ; was: sub_29F24
                movea.w #(ZLeoRasterBuildBuffer-M68K_RAM),a0
                movea.w #(ZLeoRasterCommands-M68K_RAM),a1
                moveq   #7,d7
RasterBuffer_CopyZLeoControlBlock_Loop:                 ; CODE XREF: RasterBuffer_CopyZLeoControlBlock+C   j  ; was: loc_29F2E
                move.l  (a0)+,(a1)+
                dbf     d7,RasterBuffer_CopyZLeoControlBlock_Loop
                rts
; End of function RasterBuffer_CopyZLeoControlBlock
; Copies d7+1 blocks of 64 bytes from a2 to a3
RasterBuffer_Copy64ByteBlocks:                          ; CODE XREF: RasterBuffer_CopyXiTigerOffsets+A   j  ; was: sub_29F36
                                        ; RasterBuffer_CopyTransitionLayout+A   p
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                move.l  (a2)+,(a3)+
                dbf     d7,RasterBuffer_Copy64ByteBlocks
RasterBuffer_Return:                                    ; DATA XREF: ROM:RasterBuffer_LayoutOffsets   o  ; was: locret_29F5A
                rts
; End of function RasterBuffer_Copy64ByteBlocks
; Copies rows of data to interleaved destination offsets
RasterBuffer_CopyInterleavedRows:                       ; CODE XREF: RasterBuffer_CopyInterleavedRows+42   j  ; was: sub_29F5C
                move.w  (a2)+,(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2)+,8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2)+,$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2)+,$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2)+,$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2)+,$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2)+,$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2)+,$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,RasterBuffer_CopyInterleavedRows
                rts
; End of function RasterBuffer_CopyInterleavedRows
; Copies rows with each value repeated 4 times
RasterBuffer_CopyRepeatedRows:                          ; CODE XREF: RasterBuffer_CopyAlternateTransitionLayout+18   j  ; was: sub_29FA4
                                        ; RasterBuffer_CopyRepeatedRows+4A   j
                move.w  (a2)+,d0
                move.w  d0,(a3)
                move.w  d0,4(a3)
                move.w  d0,8(a3)
                move.w  d0,$C(a3)
                move.w  (a2)+,d0
                move.w  d0,$10(a3)
                move.w  d0,$14(a3)
                move.w  d0,$18(a3)
                move.w  d0,$1C(a3)
                move.w  (a2)+,d0
                move.w  d0,$20(a3)
                move.w  d0,$24(a3)
                move.w  d0,$28(a3)
                move.w  d0,$2C(a3)
                move.w  (a2)+,d0
                move.w  d0,$30(a3)
                move.w  d0,$34(a3)
                move.w  d0,$38(a3)
                move.w  d0,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,RasterBuffer_CopyRepeatedRows
                rts
; End of function RasterBuffer_CopyRepeatedRows
; Expands eight source words per row into paired strided destinations
RasterBuffer_CopyPairedRows:                            ; CODE XREF: RasterBuffer_CopyTransitionLayout+18   j  ; was: sub_29FF4
                                        ; RasterBuffer_CopyStageTransitionLayout+18   j
                move.w  (a2),(a3)
                move.w  (a2)+,4(a3)
                move.w  (a2),8(a3)
                move.w  (a2)+,$C(a3)
                move.w  (a2),$10(a3)
                move.w  (a2)+,$14(a3)
                move.w  (a2),$18(a3)
                move.w  (a2)+,$1C(a3)
                move.w  (a2),$20(a3)
                move.w  (a2)+,$24(a3)
                move.w  (a2),$28(a3)
                move.w  (a2)+,$2C(a3)
                move.w  (a2),$30(a3)
                move.w  (a2)+,$34(a3)
                move.w  (a2),$38(a3)
                move.w  (a2)+,$3C(a3)
                lea     $40(a3),a3
                dbf     d7,RasterBuffer_CopyPairedRows
                rts
; End of function RasterBuffer_CopyPairedRows
; Copies projectile data from source to Valkirie weapon object
