Gfx_DecompressCutsceneData:                             ; CODE XREF: Cutscene_InitializeScene+36   p  ; was: sub_260A2
                                        ; Cutscene_LoadInitialAssets+34   j
                move.l  #$1FFFE,(dword_FF9F08).w
                move.w  #$1E,(word_FF9F10).w
                move.w  #$B,(word_FF9F12).w
                move.w  #0,(word_FF9F14).w
                move.w  #8,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.w  #2,(word_FF8090).w
                rts
; End of function Gfx_DecompressCutsceneData
; Loads cutscene frame to video memory
Gfx_LoadCutsceneFrame:                                  ; CODE XREF: Cutscene_HandleScrollInput+4E   j  ; was: sub_260CE
                                        ; Cutscene_XiTigerWaitComplete+44   j
                movea.l #$FFFF0400,a0
                move.w  #$9400,(dword_FF8040).w
                move.w  #$C400,(dword_FF8040+2).w
                move.l  (dword_FF9F08).w,d0
                move.l  d0,(dword_FF9F0C).w
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_260EC:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+1A   j
                moveq   #0,d3
                moveq   #0,d4
                moveq   #$13,d6
loc_260F2:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+64   j
                movea.w (dword_FF8040).w,a1
                movea.w (dword_FF8040).w,a2
                lea     $26(a1),a1
                lea     $28(a2),a2
                suba.w  d3,a1
                adda.w  d3,a2
                add.l   d0,d4
                move.l  d4,d1
                swap    d1
                andi.w  #$FFFE,d1
                move.w  d1,d2
                neg.w   d1
                move.w  #$80,d5
                move.w  (word_FF9F12).w,d7
loc_2611C:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+5E   j
                move.w  $26(a0,d1.w),(a1)
                move.w  $28(a0,d2.w),(a2)
                add.w   d5,d1
                add.w   d5,d2
                adda.w  d5,a1
                adda.w  d5,a2
                dbf     d7,loc_2611C
                addq.w  #2,d3
                dbf     d6,loc_260F2
                movea.w (VDPCommandQueueHead).w,a4
                move.w  (dword_FF8040+2).w,d0
                move.w  (word_FF9F12).w,d7
loc_26142:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+B2   j
                move.w  #$83,-(a4)
                move.w  d0,d4
                andi.w  #$3FFE,d4
                ori.w   #$4000,d4
                move.w  d4,-(a4)
                move.b  (dword_FF8040).w,d4
                move.b  (dword_FF8040+1).w,d5
                asr.b   #1,d4
                roxr.b  #1,d5
                move.b  d5,-(a4)
                move.b  #$95,-(a4)
                move.b  d4,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  #$94009328,-(a4)
                addi.w  #$80,d0
                addi.w  #$80,(dword_FF8040).w
                dbf     d7,loc_26142
                move.w  a4,(VDPCommandQueueHead).w
                moveq   #$F,d0
                move.l  (dword_FF9F0C).w,d1
                movea.w #(byte_FF9F80-M68K_RAM),a1
                adda.w  (word_FF9F10).w,a1
                movea.w a1,a2
                subi.l  #$20000,d1
                asl.l   #2,d1
                move.w  #$FFFF,d4
                move.w  (word_FF9F14).w,d5
                moveq   #0,d6
                moveq   #0,d7
                sub.l   d1,d7
loc_261AE:                                              ; CODE XREF: Gfx_LoadCutsceneFrame:loc_261D2   j
                cmpa.w  #$9F80,a1
                bmi.s   loc_261C0
                sub.l   d1,d6
                move.l  d6,d3
                swap    d3
                and.w   d4,d3
                add.w   d5,d3
                move.w  d3,-(a1)
loc_261C0:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+E4   j
                cmpa.w  #$9FC0,a2
                bpl.s   loc_261D2
                add.l   d1,d7
                move.l  d7,d3
                swap    d3
                and.w   d4,d3
                add.w   d5,d3
                move.w  d3,(a2)+
loc_261D2:                                              ; CODE XREF: Gfx_LoadCutsceneFrame+F6   j
                dbf     d0,loc_261AE
                rts
; End of function Gfx_LoadCutsceneFrame
; Renders processed tilemap data to VRAM with VDP setup and DMA transfer
Gfx_RenderTilemapToVRAM:
                tst.w   (word_FFF720).w                 ; was: sub_261D8
                bne.w   locret_2626A
                bsr.w   Gfx_InitializeWaveParameters
loc_261E4:                                              ; CODE XREF: Gfx_RenderTilemapToVRAM+3A   j
                bsr.w   Gfx_CalculateTileCoordinates
                bsr.w   Gfx_PrepareTilePointers
                bsr.w   Gfx_PixelBlendDispatcher
                lea     1(a4),a4
                move.w  a4,d0
                move.w  d0,d1
                andi.w  #3,d0
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d0
                andi.l  #$FFFF,d0
                addi.l  #-$10000,d0
                movea.l d0,a2
                dbf     d7,loc_261E4
                movea.l #Gfx_WaveParameterTableD,a0
                move.w  (word_FF8102).w,d0
                move.w  (a0,d0.w),d0
                move.w  #$1400,d1
                move.w  d0,d2
                rol.w   #2,d2
                andi.w  #3,d2
                swap    d0
                andi.l  #$3FFF0000,d0
                ori.l   #$40000000,d0
                move.w  d2,d0
                move    #$2700,sr
                lea     (VDP_DATA).l,a1
                lea     (VDP_CTRL).l,a2
                move.w  #$8F02,(a2)
                movea.l #$FFFF0000,a0
                move.l  d0,(a2)
loc_2625C:                                              ; CODE XREF: Gfx_RenderTilemapToVRAM+86   j
                move.l  (a0)+,(a1)
                dbf     d1,loc_2625C
                move    #$2300,sr
                addq.w  #2,(word_FF8102).w
locret_2626A:                                           ; CODE XREF: Gfx_RenderTilemapToVRAM+4   j
                rts
; End of function Gfx_RenderTilemapToVRAM
; Initializes scrolling effect parameters for stage background layer
