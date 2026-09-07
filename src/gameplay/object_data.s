LoadObjData:                                            ; CODE XREF: Effect_InitLettersEffect+20   p
                                        ; Effect_InitStage2DemoEffect+1E   p
                move.w  (a0)+,d0
                bmi.w   locret_264E
                lsl.w   #2,d0
                movea.l off_2650(pc,d0.w),a1
                jsr     (a1)
                bra.s   LoadObjData
; ---------------------------------------------------------------------------
locret_264E:                                            ; CODE XREF: LoadObjData+2   j
                rts
; End of function LoadObjData
; ---------------------------------------------------------------------------
off_2650:       dc.l    LoadFuncToRAM
                dc.l    Gfx_LoadDataToVRAM
                dc.l    Gfx_LoadAndDecompTiles
                dc.l    Gfx_LoadCompressedGfx
                dc.l    LoadFuncToRAM
                dc.l    Gfx_LoadDataToVRAM
                dc.l    LoadCompressedTiles
                dc.l    LoadCompressedMappings

LoadFuncToRAM:                                          ; DATA XREF: ROM:off_2650   o
                                        ; ROM:00002660   o
                movea.l (a0)+,a1
                moveq   #$FFFFFFFF,d2
                move.w  (a0)+,d2
                movea.l d2,a2
                move.w  (a1)+,d1
                lsr.w   #2,d1
                subq.w  #1,d1
; Loop that copies function code from ROM to RAM 4 bytes at a time for dynamic code execution
Data_CopyFunctionLoop:                                  ; CODE XREF: LoadFuncToRAM+10   j  ; was: loc_267E
                move.l  (a1)+,(a2)+
                dbf     d1,Data_CopyFunctionLoop
                rts
; End of function LoadFuncToRAM

; Loads graphics data to VRAM
Gfx_LoadDataToVRAM:                                     ; DATA XREF: ROM:00002654   o  ; was: sub_2686
                                        ; ROM:00002664   o
                movea.l (a0)+,a1
                moveq   #0,d1
                move.w  (a0)+,d1
                movea.l d1,a3
                move.w  (a1)+,d0
loc_2690:                                               ; CODE XREF: Gfx_LoadDataToVRAM+4A   j
                move.w  #$200,d1
                cmp.w   d1,d0
                bge.w   loc_269C
                move.w  d0,d1
loc_269C:                                               ; CODE XREF: Gfx_LoadDataToVRAM+10   j
                sub.w   d1,d0
                lsr.w   #2,d1
                subq.w  #1,d1
                lea     (VDP_CTRL).l,a5
                move    sr,-(sp)
                move    #$2700,sr
                move.w  #$8F02,(a5)
                move.l  a3,d7
                lsl.l   #2,d7
                lsr.w   #2,d7
                ori.w   #$4000,d7
                swap    d7
                move.l  d7,(a5)
                lea     (VDP_DATA).l,a5
loc_26C6:                                               ; CODE XREF: Gfx_LoadDataToVRAM+42   j
                move.l  (a1)+,(a5)
                dbf     d1,loc_26C6
                move    (sp)+,sr
                tst.w   d0
                bne.s   loc_2690
                rts
; End of function Gfx_LoadDataToVRAM
; Loads and decompresses tile data to destination buffer
Gfx_LoadAndDecompTiles:                                 ; DATA XREF: ROM:00002658   o  ; was: sub_26D4
                movea.l (a0)+,a1
                moveq   #$FFFFFFFF,d1
                move.w  (a0)+,d1
                movea.l d1,a2
                moveq   #0,d1
                move.b  (a1),d1
                move.w  (a1)+,d3
                moveq   #8,d2
                ror.w   d2,d3
                move.w  d2,(dword_FFF730).w
                move.w  d3,(dword_FFF730+2).w
                bsr.w   Sys_ClearDMABuffer
loc_26F2:                                               ; CODE XREF: Gfx_LoadAndDecompTiles+26   j
                bsr.w   Gfx_ProcessTileData
                bsr.w   Gfx_PackTileData
                dbf     d1,loc_26F2
                rts
; End of function Gfx_LoadAndDecompTiles
; Loads and decompresses graphics data by processing header info and calling decompression subroutines
Gfx_LoadCompressedGfx:                                  ; DATA XREF: ROM:0000265C   o  ; was: sub_2700
                movea.l (a0)+,a1
                moveq   #$FFFFFFFF,d1
                move.w  (a0)+,d1
                movea.l d1,a3
                moveq   #0,d1
                move.b  (a1),d1
                move.w  (a1)+,d3
                moveq   #8,d2
                ror.w   d2,d3
                move.w  d2,(dword_FFF730).w
                move.w  d3,(dword_FFF730+2).w
                bsr.w   Sys_ClearDMABuffer
; Loop that repeatedly calls decompression functions to process graphics data tiles
Gfx_DecompLoop:                                         ; CODE XREF: Gfx_LoadCompressedGfx+26   j  ; was: loc_271E
                bsr.w   Gfx_ProcessTileData
                bsr.w   Gfx_WriteTilesToVRAM
                dbf     d1,Gfx_DecompLoop
                rts
; End of function Gfx_LoadCompressedGfx
LoadCompressedTiles:                                    ; DATA XREF: ROM:00002668   o
                movea.l (a0)+,a1
                moveq   #0,d0
                move.w  (a1)+,d0
                movea.l a1,a4
                adda.l  d0,a4
                moveq   #$FFFFFFFF,d0
                move.w  (a0)+,d0
                movea.l d0,a2
; Loop that decompresses multiple LZSS-compressed data blocks sequentially until reaching end address
Data_LZSSDecompLoop:                                    ; CODE XREF: LoadCompressedTiles+16   j  ; was: loc_273C
                bsr.w   LZSSDecomp
                cmpa.l  a4,a1
                bcs.s   Data_LZSSDecompLoop
                rts
; End of function LoadCompressedTiles

LoadCompressedMappings:                                 ; DATA XREF: ROM:0000266C   o
                movea.l (a0)+,a1
                moveq   #0,d0
                move.w  (a1)+,d0
                movea.l a1,a4
                adda.l  d0,a4
                moveq   #0,d0
                move.w  (a0)+,d0
                movea.l d0,a3
loc_2756:                                               ; CODE XREF: LoadCompressedMappings+56   j
                lea     (dword_FFB400).w,a2
                bsr.w   LZSSDecomp
                cmpa.l  a4,a1
                bcc.w   loc_279E
                move.w  #$FF,d1
                lea     (dword_FFB400).w,a2
                lea     (VDP_CTRL).l,a5
                move    sr,-(sp)
                move    #$2700,sr
                move.w  #$8F02,(a5)
                move.l  a3,d2
                lsl.l   #2,d2
                lsr.w   #2,d2
                ori.w   #$4000,d2
                swap    d2
                move.l  d2,(a5)
                lea     (VDP_DATA).l,a5
loc_2790:                                               ; CODE XREF: LoadCompressedMappings+4C   j
                move.l  (a2)+,(a5)
                dbf     d1,loc_2790
                move    (sp)+,sr
                lea     $400(a3),a3
                bra.s   loc_2756
; ---------------------------------------------------------------------------
loc_279E:                                               ; CODE XREF: LoadCompressedMappings+1A   j
                move.w  a2,d1
                subi.w  #$B400,d1
                lsr.w   #1,d1
                lea     (dword_FFB400).w,a2
                lea     (VDP_CTRL).l,a5
                move    sr,-(sp)
                move    #$2700,sr
                move.w  #$8F02,(a5)
                move.l  a3,d2
                lsl.l   #2,d2
                lsr.w   #2,d2
                ori.w   #$4000,d2
                swap    d2
                move.l  d2,(a5)
                lea     (VDP_DATA).l,a5
loc_27CE:                                               ; CODE XREF: LoadCompressedMappings+8A   j
                move.w  (a2)+,(a5)
                dbf     d1,loc_27CE
                move    (sp)+,sr
                rts
; End of function LoadCompressedMappings

; Processes data pointers with state bits
Data_ProcessPointer:                                    ; CODE XREF: Sys_DispatchDataLoader+16   p  ; was: sub_27D8
                                        ; Gfx_FadeOutToDark+3C   p
                move.w  (a0)+,d0
                bmi.w   locret_2864
                bset    #$F,d0
                move.w  d0,(word_FFF720).w
                movea.l (a0)+,a1
                btst    #0,d0
                bne.w   loc_282E
                moveq   #$FFFFFFFF,d1
                move.w  (a0)+,d1
                move.l  d1,(dword_FFF72C).w
                move.l  a0,(dword_FFF724).w
                btst    #1,d0
                beq.w   loc_284C
                btst    #2,d0
                bne.w   loc_2856
loc_280C:                                               ; CODE XREF: Data_ProcessPointer+6E   j
                moveq   #0,d1
                move.b  (a1),d1
                addq.w  #1,d1
                move.w  d1,(word_FFF722).w
                move.w  #8,d2
                move.w  d2,(dword_FFF730).w
                move.w  (a1)+,d3
                ror.w   d2,d3
                move.w  d3,(dword_FFF730+2).w
                move.l  a1,(dword_FFF728).w
                bra.w   Sys_ClearDMABuffer
; ---------------------------------------------------------------------------
loc_282E:                                               ; CODE XREF: Data_ProcessPointer+14   j
                moveq   #0,d1
                move.w  (a0)+,d1
                move.l  d1,(dword_FFF72C).w
                move.l  a0,(dword_FFF724).w
                btst    #1,d0
                beq.w   loc_284C
                btst    #2,d0
                beq.s   loc_280C
                bra.w   loc_2856
; ---------------------------------------------------------------------------
loc_284C:                                               ; CODE XREF: Data_ProcessPointer+28   j
                                        ; Data_ProcessPointer+66   j
                move.w  (a1)+,(word_FFF722).w
                move.l  a1,(dword_FFF728).w
                rts
; ---------------------------------------------------------------------------
loc_2856:                                               ; CODE XREF: Data_ProcessPointer+30   j
                                        ; Data_ProcessPointer+70   j
                moveq   #0,d1
                move.w  (a1)+,d1
                move.l  a1,(dword_FFF728).w
                adda.l  d1,a1
                move.l  a1,(dword_FFF730).w
locret_2864:                                            ; CODE XREF: Data_ProcessPointer+2   j
                rts
; End of function Data_ProcessPointer
; Dispatches data loading operations by calling function pointers from jump table until $FFFF terminator
Sys_DispatchDataLoader:                                 ; CODE XREF: Reset+266   p  ; was: sub_2866
                move.w  (word_FFF720).w,d0
                beq.w   locret_288A
                movea.l (dword_FFF724).w,a0
loc_2872:                                               ; CODE XREF: Sys_DispatchDataLoader+1E   j
                add.w   d0,d0
                add.w   d0,d0
                movea.l off_288C(pc,d0.w),a3
                jsr     (a3)
                bsr.w   Data_ProcessPointer
                cmpi.w  #$FFFF,d0
                bne.s   loc_2872
                clr.w   (word_FFF720).w
locret_288A:                                            ; CODE XREF: Sys_DispatchDataLoader+4   j
                rts
; End of function Sys_DispatchDataLoader
; ---------------------------------------------------------------------------
off_288C:       dc.l    Data_CopyToRAM
                dc.l    Gfx_DMATransferWithWait
                dc.l    Gfx_DecompTilesToRAM
                dc.l    Gfx_DecompTilesToVRAMBatched
                dc.l    Data_CopyToRAM
                dc.l    Gfx_DMATransferWithWait
                dc.l    Gfx_DecompressLZSS
                dc.l    Data_DecompressLZSS

; Copies data from source to destination in RAM
Data_CopyToRAM:                                         ; DATA XREF: ROM:off_288C   o  ; was: sub_28AC
                                        ; ROM:0000289C   o
                movea.l (dword_FFF728).w,a1
                movea.l (dword_FFF72C).w,a2
                move.w  (word_FFF722).w,d1
loc_28B8:                                               ; CODE XREF: Data_CopyToRAM+12   j
                move.l  (a1)+,(a2)+
                move.l  (a1)+,(a2)+
                subq.w  #8,d1
                bhi.s   loc_28B8
                rts
; End of function Data_CopyToRAM
; Performs DMA transfer with VBlank wait loop
Gfx_DMATransferWithWait:                                ; DATA XREF: ROM:00002890   o  ; was: sub_28C2
                                        ; ROM:000028A0   o
                movea.l (dword_FFF728).w,a2
                movea.w (dword_FFF72C).w,a3
                move.w  (word_FFF722).w,d0
loc_28CE:                                               ; CODE XREF: Gfx_DMATransferWithWait+24   j
                move.w  #$200,d1
                cmp.w   d1,d0
                bge.w   loc_28DA
                move.w  d0,d1
loc_28DA:                                               ; CODE XREF: Gfx_DMATransferWithWait+12   j
                bsr.w   Gfx_ExecuteDMATransfer
loc_28DE:                                               ; CODE XREF: Gfx_DMATransferWithWait+20   j
                tst.b   (byte_FFF754).w
                bne.s   loc_28DE
                sub.w   d1,d0
                bne.s   loc_28CE
                rts
; End of function Gfx_DMATransferWithWait
; Decompresses tiles to RAM buffer
Gfx_DecompTilesToRAM:                                   ; DATA XREF: ROM:00002894   o  ; was: sub_28EA
                movea.l (dword_FFF728).w,a1
                movea.l (dword_FFF72C).w,a2
                move.w  (word_FFF722).w,d0
                subq.w  #1,d0
loc_28F8:                                               ; CODE XREF: Gfx_DecompTilesToRAM+16   j
                bsr.w   Gfx_ProcessTileData
                bsr.w   Gfx_PackTileData
                dbf     d0,loc_28F8
                rts
; End of function Gfx_DecompTilesToRAM
; Decompresses tiles to VRAM in batched DMA transfers
Gfx_DecompTilesToVRAMBatched:                           ; DATA XREF: ROM:00002898   o  ; was: sub_2906
                movea.l (dword_FFF728).w,a1
                movea.l (dword_FFF72C).w,a3
                move.w  (word_FFF722).w,d0
loc_2912:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+44   j
                lea     (dword_FFB600).w,a2
                move.w  #$10,d2
                cmp.w   d2,d0
                bge.w   loc_2922
                move.w  d0,d2
loc_2922:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+16   j
                move.w  d2,d1
                asl.w   #5,d1
                sub.w   d2,d0
                subq.w  #1,d2
loc_292A:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+2C   j
                bsr.w   Gfx_ProcessTileData
                bsr.w   Gfx_PackTileData
                dbf     d2,loc_292A
                tst.w   d0
                beq.w   loc_294C
                lea     (dword_FFB600).w,a2
                bsr.w   Gfx_ExecuteDMATransfer
loc_2944:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+42   j
                tst.b   (byte_FFF754).w
                bne.s   loc_2944
                bra.s   loc_2912
; ---------------------------------------------------------------------------
loc_294C:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+32   j
                lea     (dword_FFB600).w,a2
                bsr.w   Gfx_ExecuteDMATransfer
loc_2954:                                               ; CODE XREF: Gfx_DecompTilesToVRAMBatched+52   j
                tst.b   (byte_FFF754).w
                bne.s   loc_2954
                rts
; End of function Gfx_DecompTilesToVRAMBatched
; Decompresses LZSS data to VRAM in loop
Gfx_DecompressLZSS:                                     ; DATA XREF: ROM:000028A4   o  ; was: sub_295C
                movea.l (dword_FFF728).w,a1
                movea.l (dword_FFF72C).w,a2
                movea.l (dword_FFF730).w,a4
; Loop that repeatedly decompresses LZSS data directly to VRAM until reaching target address
Gfx_LZSSToVRAMLoop:                                     ; CODE XREF: Gfx_DecompressLZSS+12   j  ; was: loc_2968
                bsr.w   LZSSDecomp
                cmpa.l  a4,a1
                bcs.s   Gfx_LZSSToVRAMLoop
                rts
; End of function Gfx_DecompressLZSS
; Decompresses LZSS data to RAM buffer
Data_DecompressLZSS:                                    ; DATA XREF: ROM:000028A8   o  ; was: sub_2972
                movea.l (dword_FFF728).w,a1
                movea.l (dword_FFF72C).w,a3
                movea.l (dword_FFF730).w,a4
loc_297E:                                               ; CODE XREF: Data_DecompressLZSS+2C   j
                lea     (dword_FFB400).w,a2
                bsr.w   LZSSDecomp
                cmpa.l  a4,a1
                bcc.w   loc_29A0
                move.w  #$400,d1
                lea     (dword_FFB400).w,a2
                bsr.w   Gfx_ExecuteDMATransfer
loc_2998:                                               ; CODE XREF: Data_DecompressLZSS+2A   j
                tst.b   (byte_FFF754).w
                bne.s   loc_2998
                bra.s   loc_297E
; ---------------------------------------------------------------------------
loc_29A0:                                               ; CODE XREF: Data_DecompressLZSS+16   j
                move.w  a2,d1
                subi.w  #$B400,d1
                lea     (dword_FFB400).w,a2
                bsr.w   Gfx_ExecuteDMATransfer
loc_29AE:                                               ; CODE XREF: Data_DecompressLZSS+40   j
                tst.b   (byte_FFF754).w
                bne.s   loc_29AE
                rts
; End of function Data_DecompressLZSS
LZSSDecomp:                                             ; CODE XREF: LoadCompressedTiles:loc_273C   p
                                        ; LoadCompressedMappings+14   p
                movem.l d4-d7/a5,-(sp)
                move.w  a2,d4
                addi.w  #$400,d4
loc_29C0:                                               ; CODE XREF: LZSSDecomp+16   j
                bsr.w   Data_LZSSDecodeBlock
                cmpa.l  a4,a1
                bcc.w   loc_29CE
                cmp.w   a2,d4
                bhi.s   loc_29C0
loc_29CE:                                               ; CODE XREF: LZSSDecomp+10   j
                movem.l (sp)+,d4-d7/a5
                rts
; End of function LZSSDecomp

; LZSS decoder that handles various compression block types including literal runs RLE and backreferences
Data_LZSSDecodeBlock:                                   ; CODE XREF: LZSSDecomp:loc_29C0   p  ; was: sub_29D4
                move.b  (a1)+,d5
                bmi.w   loc_2A2C
                btst    #5,d5
                bne.w   loc_29EE
                btst    #6,d5
                beq.w   loc_2A4C
                bra.w   loc_2A06
; ---------------------------------------------------------------------------
loc_29EE:                                               ; CODE XREF: Data_LZSSDecodeBlock+A   j
                btst    #6,d5
                bne.w   loc_2A1A
                andi.w  #$1F,d5
                addq.w  #1,d5
                move.b  (a1)+,d6
loc_29FE:                                               ; CODE XREF: Data_LZSSDecodeBlock+2C   j
                move.b  d6,(a2)+
                dbf     d5,loc_29FE
                rts
; ---------------------------------------------------------------------------
loc_2A06:                                               ; CODE XREF: Data_LZSSDecodeBlock+16   j
                andi.w  #$1F,d5
                addq.w  #1,d5
                move.b  (a1)+,d6
                move.b  (a1)+,d7
loc_2A10:                                               ; CODE XREF: Data_LZSSDecodeBlock+40   j
                move.b  d6,(a2)+
                move.b  d7,(a2)+
                dbf     d5,loc_2A10
                rts
; ---------------------------------------------------------------------------
loc_2A1A:                                               ; CODE XREF: Data_LZSSDecodeBlock+1E   j
                andi.w  #$1F,d5
                addq.w  #1,d5
                move.b  (a1)+,d6
loc_2A22:                                               ; CODE XREF: Data_LZSSDecodeBlock+52   j
                move.b  d6,(a2)+
                move.b  (a1)+,(a2)+
                dbf     d5,loc_2A22
                rts
; ---------------------------------------------------------------------------
loc_2A2C:                                               ; CODE XREF: Data_LZSSDecodeBlock+2   j
                move.b  d5,d6
                lsr.b   #2,d5
                andi.w  #$1F,d5
                addq.w  #1,d5
                lsl.w   #8,d6
                move.b  (a1)+,d6
                andi.w  #$3FF,d6
                addq.w  #1,d6
                movea.l a2,a5
                suba.w  d6,a5
loc_2A44:                                               ; CODE XREF: Data_LZSSDecodeBlock+72   j
                move.b  (a5)+,(a2)+
                dbf     d5,loc_2A44
                rts
; ---------------------------------------------------------------------------
loc_2A4C:                                               ; CODE XREF: Data_LZSSDecodeBlock+12   j
                andi.w  #$1F,d5
loc_2A50:                                               ; CODE XREF: Data_LZSSDecodeBlock+7E   j
                move.b  (a1)+,(a2)+
                dbf     d5,loc_2A50
                rts
; End of function Data_LZSSDecodeBlock
; Clears DMA buffer at FFB400
