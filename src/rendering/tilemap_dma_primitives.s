; Mirrors one row at Y-$1000, then queues the next row of the active scrolling transfer
Tilemap_MirrorOffsetRowAndQueueScrollingRow:            ; CODE XREF: Stage_LoadBackgroundGraphics+82   p  ; was: sub_10D16
                                        ; Stage_LoadBackgroundGraphics+88   p
                movea.l (dword_FFA940).w,a0
                move.w  (word_FFA946).w,d0
                move.w  (word_FFA948).w,d1
                subi.w  #$1000,d1
                neg.w   d1
                moveq   #$F,d7
Tilemap_BuildOffsetMirrorRowLoop:                       ; CODE XREF: Tilemap_MirrorOffsetRowAndQueueScrollingRow+94   j  ; was: loc_10D2A
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
                lsr.w   #2,d2
                andi.w  #$78,d2                         ; 'x'
                movea.l (a0)+,a1
                move.w  d1,d3
                andi.w  #$18,d3
                add.w   d4,d3
                cmpi.w  #$FF,d5
                bne.s   Tilemap_WriteOffsetMirrorRowSegment
                moveq   #0,d3
Tilemap_WriteOffsetMirrorRowSegment:                    ; CODE XREF: Tilemap_MirrorOffsetRowAndQueueScrollingRow+62   j  ; was: loc_10D7C
                tst.w   (a0)+
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
                suba.l  #$E,a0
                addi.w  #$20,d0                         ; ' '
                dbf     d7,Tilemap_BuildOffsetMirrorRowLoop
                bra.w   Tilemap_QueueNextScrollingRow
; End of function Tilemap_MirrorOffsetRowAndQueueScrollingRow
; Queues the next 64-word tilemap row filled with one constant value
Tilemap_QueueNextConstantRow:                           ; CODE XREF: Stage_InitTerobusterBoss+10   p  ; was: sub_10DB2
                                        ; Stage_CaterpillarScrollHandler+4   p
                tst.w   (word_FFA944).w
                bmi.w   Tilemap_ConstantRowQueueReturn
                movea.w (VDPStagingDataCursor).w,a0
                move.w  (word_FFA946).w,d0
                moveq   #$3F,d7                         ; '?'
Tilemap_FillConstantRowLoop:                            ; CODE XREF: Tilemap_QueueNextConstantRow+14   j  ; was: loc_10DC4
                move.w  d0,(a0)+
                dbf     d7,Tilemap_FillConstantRowLoop
                movea.w (VDPCommandQueueHead).w,a1
                move.w  #$83,-(a1)
                moveq   #$1F,d0
                sub.w   (word_FFA944).w,d0
                asl.w   #7,d0
                add.w   (dword_FFA940).w,d0
                move.w  d0,-(a1)
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
                subq.w  #1,(word_FFA944).w
Tilemap_ConstantRowQueueReturn:                         ; CODE XREF: Tilemap_QueueNextConstantRow+4   j  ; was: locret_10E12
                rts
; End of function Tilemap_QueueNextConstantRow
; Fills all 2,048 words of a tilemap plane and transfers them directly to VRAM
Tilemap_FillPlaneDirectToVRAM:                          ; CODE XREF: StoryTitle_SetupLogoReveal+3E   p  ; was: sub_10E14
                                        ; StoryTitle_SetupLogoReveal+50   p
                move    sr,-(sp)
                move    #$2700,sr
Tilemap_WaitForPlaneFillZ80BusRequest:                  ; CODE XREF: Tilemap_FillPlaneDirectToVRAM+E   j  ; was: loc_10E1A
                bset    #0,(IO_Z80BUS).l
                bne.s   Tilemap_WaitForPlaneFillZ80BusRequest
                lea     (VDP_CTRL).l,a4
                move.w  (VDPReg1Shadow).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                movea.l #$FFFF2000,a0
                move.w  (word_FFA946).w,d0
                move.w  #$7FF,d7
Tilemap_FillPlaneStagingLoop:                           ; CODE XREF: Tilemap_FillPlaneDirectToVRAM+30   j  ; was: loc_10E42
                move.w  d0,(a0)+
                dbf     d7,Tilemap_FillPlaneStagingLoop
                move.w  #$8F02,(a4)
                move.l  #$93009408,(a4)
                move.w  #$9500,(a4)
                move.w  #$9690,(a4)
                move.w  #$977F,(a4)
                move.w  #$83,(VDPCommand).w
                move.w  (dword_FFA940).w,(a4)
                move.w  (VDPCommand).w,(a4)
                move.w  (VDPReg1Shadow).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
Tilemap_WaitForPlaneFillZ80BusRelease:                  ; CODE XREF: Tilemap_FillPlaneDirectToVRAM+6A   j  ; was: loc_10E76
                bclr    #0,(IO_Z80BUS).l
                beq.s   Tilemap_WaitForPlaneFillZ80BusRelease
                move    (sp)+,sr
                rts
; End of function Tilemap_FillPlaneDirectToVRAM
; Unreferenced helper that copies a 4x4 tilemap block in RAM and queues its four rows
UnreferencedTilemapCopy4x4BlockAndQueueRows:            ; was: sub_10E84
                move.l  d0,d1
                swap    d1
                ori.l   #$FFFF0000,d0
                ori.l   #$FFFF0000,d1
                movea.l d0,a0
                move.l  d1,d2
                andi.w  #$1FFF,d2
                movea.l d2,a1
                move.l  (a0)+,(a1)
                move.l  (a0)+,4(a1)
                move.l  (a0)+,$80(a1)
                move.l  (a0)+,$84(a1)
                move.l  (a0)+,$100(a1)
                move.l  (a0)+,$104(a1)
                move.l  (a0)+,$180(a1)
                move.l  (a0)+,$184(a1)
                bset    #0,d0
                andi.w  #$EFFE,d1
                bra.s   Tilemap_QueueFourRowsFromEncodedAddresses
; End of function UnreferencedTilemapCopy4x4BlockAndQueueRows
; Decodes packed source and destination addresses and queues four tilemap rows
Tilemap_QueueFourRowsFromPackedCommand:                 ; CODE XREF: Stage_ShipDestructionCheckInput+16   p  ; was: sub_10EC6
                                        ; Stage_ShipDestructionCheckInput+24   p
                move.l  d0,d1
                swap    d1
Tilemap_QueueFourRowsFromEncodedAddresses:              ; CODE XREF: UnreferencedTilemapCopy4x4BlockAndQueueRows+40   j  ; was: loc_10ECA
                movea.w (VDPCommandQueueHead).w,a0
                moveq   #3,d7
Tilemap_QueuePackedRowLoop:                             ; CODE XREF: Tilemap_QueueFourRowsFromPackedCommand+36   j  ; was: loc_10ED0
                move.w  #$83,-(a0)
                move.w  d1,-(a0)
                move.w  d0,d2
                ror.w   #1,d2
                move.b  d2,d3
                asr.w   #8,d2
                move.b  d3,-(a0)
                move.b  #$95,-(a0)
                move.b  d2,-(a0)
                move.b  #$96,-(a0)
                move.l  #$8F02977F,-(a0)
                move.l  #$94009304,-(a0)
                addq.w  #8,d0
                addi.w  #$80,d1
                dbf     d7,Tilemap_QueuePackedRowLoop
                move.w  a0,(VDPCommandQueueHead).w
                rts
; End of function Tilemap_QueueFourRowsFromPackedCommand
; Unreferenced variant that queues four rows from a full 68K source address
UnreferencedTilemapQueueFourRowsFromLongSource:         ; was: sub_10F06
                movea.w (VDPCommandQueueHead).w,a0
                moveq   #3,d7
Tilemap_QueueLongSourceRowLoop:                         ; CODE XREF: UnreferencedTilemapQueueFourRowsFromLongSource+3E   j  ; was: loc_10F0C
                move.w  #$83,-(a0)
                move.w  d1,-(a0)
                move.l  d0,d2
                lsr.l   #1,d2
                move.l  d2,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d3
                move.b  (dword_FF8040+1).w,d4
                move.b  d2,-(a0)
                move.b  #$95,-(a0)
                move.b  d3,-(a0)
                move.b  #$96,-(a0)
                move.b  d4,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  #$94009304,-(a0)
                addq.w  #8,d0
                addi.w  #$80,d1
                dbf     d7,Tilemap_QueueLongSourceRowLoop
                move.w  a0,(VDPCommandQueueHead).w
                rts
; End of function UnreferencedTilemapQueueFourRowsFromLongSource
; Stages indexed tile blocks by rows and queues their horizontal DMA transfers
Tilemap_QueueIndexedRows:                               ; CODE XREF: EndingSequence_FadeOutCredits+3C   p  ; was: sub_10F4E
                                        ; ShipSequence_LoadTileBatch1+6   p
                move.w  (VDPStagingDataCursor).w,(word_FF805C).w
                move.l  #$94009300,(dword_FF8058).w
                moveq   #0,d0
                move.b  4(a0),d0
                addq.w  #1,d0
                lsl.w   #2,d0
                move.b  d0,(dword_FF8058+3).w
                moveq   #0,d0
                move.b  4(a0),d0
                addq.w  #1,d0
                move.w  d0,(dword_FF805E).w
                movea.l a0,a1
                adda.l  #6,a1
                movea.w (VDPStagingDataCursor).w,a3
                movea.w (VDPCommandQueueHead).w,a4
                moveq   #0,d4
                moveq   #0,d7
                move.b  5(a0),d7
Tilemap_QueueIndexedRowGroupLoop:                       ; CODE XREF: Tilemap_QueueIndexedRows+AE   j  ; was: loc_10F8E
                moveq   #0,d1
                moveq   #3,d6
Tilemap_StageIndexedRowLoop:                            ; CODE XREF: Tilemap_QueueIndexedRows+A6   j  ; was: loc_10F92
                moveq   #0,d5
                move.b  4(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
Tilemap_CopyIndexedTilesIntoRowLoop:                    ; CODE XREF: Tilemap_QueueIndexedRows+68   j  ; was: loc_10F9C
                move.w  #0,d0
                move.b  (a1,d2.w),d0
                lsl.w   #5,d0
                add.w   2(a0),d0
                movea.l d0,a2
                move.l  (a2,d1.w),(a3)+
                move.l  4(a2,d1.w),(a3)+
                addq.w  #1,d2
                dbf     d5,Tilemap_CopyIndexedTilesIntoRowLoop
                move.w  #$83,-(a4)
                move.w  (a0),d2
                andi.w  #$EFFE,d2
                add.w   d4,d2
                move.w  d2,-(a4)
                move.b  (VDPStagingDataCursor).w,d2
                move.b  (VDPStagingDataCursor+1).w,d3
                asr.b   #1,d2
                roxr.b  #1,d3
                move.b  d3,-(a4)
                move.b  #$95,-(a4)
                move.b  d2,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F02977F,-(a4)
                move.l  (dword_FF8058).w,-(a4)
                move.w  a3,(VDPStagingDataCursor).w
                addq.w  #8,d1
                addi.w  #$80,d4
                dbf     d6,Tilemap_StageIndexedRowLoop
                adda.w  (dword_FF805E).w,a1
                dbf     d7,Tilemap_QueueIndexedRowGroupLoop
                move.w  a4,(VDPCommandQueueHead).w
                btst    #0,1(a0)
                beq.s   Tilemap_IndexedRowsReturn
                movea.w (word_FF805C).w,a1
                moveq   #0,d6
                move.b  5(a0),d6
                addq.w  #1,d6
                lsl.w   #2,d6
                subq.w  #1,d6
                moveq   #$FFFFFFFF,d0
                move.w  (a0),d0
                andi.w  #$1FFE,d0
                movea.l d0,a2
                moveq   #0,d5
                move.b  (dword_FF8058+3).w,d5
                subq.w  #1,d5
Tilemap_MirrorQueuedRowsLoop:                           ; CODE XREF: Tilemap_QueueIndexedRows+F2   j  ; was: loc_1102E
                moveq   #0,d0
                move.w  d5,d7
Tilemap_MirrorQueuedRowWordsLoop:                       ; CODE XREF: Tilemap_QueueIndexedRows+EA   j  ; was: loc_11032
                move.w  (a1)+,(a2,d0.w)
                addq.w  #2,d0
                dbf     d7,Tilemap_MirrorQueuedRowWordsLoop
                adda.w  #$80,a2
                dbf     d6,Tilemap_MirrorQueuedRowsLoop
Tilemap_IndexedRowsReturn:                              ; CODE XREF: Tilemap_QueueIndexedRows+BC   j  ; was: locret_11044
                rts
; End of function Tilemap_QueueIndexedRows
; Rewrites the high VDP command word in consecutive queued transfers
VDPQueue_SetCommandHighWord:                            ; CODE XREF: Stage_InitStage17Boss+98   p  ; was: sub_11046
                                        ; Boss_ZLeoLoadInitialTilesAndPatterns+12   j
                movea.w (VDPCommandQueueHead).w,a0
VDPQueue_SetCommandHighWordLoop:                        ; CODE XREF: VDPQueue_SetCommandHighWord+C   j  ; was: loc_1104A
                move.w  d0,$E(a0)
                lea     $10(a0),a0
                dbf     d7,VDPQueue_SetCommandHighWordLoop
                rts
; End of function VDPQueue_SetCommandHighWord
; Stages indexed tile blocks by columns and queues their vertical DMA transfers
Tilemap_QueueIndexedColumns:                            ; CODE XREF: Stage_FlyingNeoSpawn+24   j  ; was: sub_11058
                                        ; Gfx_LoadWolfGaropaTransitionTiles+6   p
                move.w  (VDPStagingDataCursor).w,(word_FF805C).w
                move.l  #$94009300,(dword_FF8058).w
                moveq   #0,d0
                move.b  5(a0),d0
                addq.w  #1,d0
                lsl.w   #2,d0
                move.b  d0,(dword_FF8058+3).w
                moveq   #0,d0
                move.b  4(a0),d0
                move.w  d0,(dword_FF805E).w
                movea.l a0,a1
                adda.l  #6,a1
                movea.w (VDPStagingDataCursor).w,a3
                movea.w (VDPCommandQueueHead).w,a4
                moveq   #0,d4
                moveq   #0,d7
                move.b  4(a0),d7
Tilemap_QueueIndexedColumnGroupLoop:                    ; CODE XREF: Tilemap_QueueIndexedColumns+B8   j  ; was: loc_11096
                moveq   #0,d1
                moveq   #3,d6
Tilemap_StageIndexedColumnLoop:                         ; CODE XREF: Tilemap_QueueIndexedColumns+B2   j  ; was: loc_1109A
                moveq   #0,d5
                move.b  5(a0),d5
                moveq   #$FFFFFFFF,d0
                moveq   #0,d2
                moveq   #0,d3
                move.b  4(a0),d3
                addq.w  #1,d3
Tilemap_CopyIndexedTilesIntoColumnLoop:                 ; CODE XREF: Tilemap_QueueIndexedColumns+76   j  ; was: loc_110AC
                move.w  #0,d0
                move.b  (a1,d2.w),d0
                lsl.w   #5,d0
                add.w   2(a0),d0
                movea.l d0,a2
                move.w  (a2,d1.w),(a3)+
                move.w  8(a2,d1.w),(a3)+
                move.w  $10(a2,d1.w),(a3)+
                move.w  $18(a2,d1.w),(a3)+
                add.w   d3,d2
                dbf     d5,Tilemap_CopyIndexedTilesIntoColumnLoop
                move.w  #$83,-(a4)
                move.w  (a0),d2
                andi.w  #$EFFE,d2
                add.w   d4,d2
                move.w  d2,-(a4)
                move.b  (VDPStagingDataCursor).w,d2
                move.b  (VDPStagingDataCursor+1).w,d3
                asr.b   #1,d2
                roxr.b  #1,d3
                move.b  d3,-(a4)
                move.b  #$95,-(a4)
                move.b  d2,-(a4)
                move.b  #$96,-(a4)
                move.l  #$8F80977F,-(a4)
                move.l  (dword_FF8058).w,-(a4)
                move.w  a3,(VDPStagingDataCursor).w
                addq.w  #2,d1
                addq.w  #2,d4
                dbf     d6,Tilemap_StageIndexedColumnLoop
                addq.w  #1,a1
                dbf     d7,Tilemap_QueueIndexedColumnGroupLoop
                move.w  a4,(VDPCommandQueueHead).w
                btst    #0,1(a0)
                beq.s   Tilemap_IndexedColumnsReturn
                movea.w (word_FF805C).w,a1
                moveq   #0,d6
                move.b  4(a0),d6
                addq.w  #1,d6
                lsl.w   #2,d6
                subq.w  #1,d6
                moveq   #$FFFFFFFF,d0
                move.w  (a0),d0
                andi.w  #$1FFE,d0
                movea.l d0,a2
                moveq   #0,d5
                move.b  (dword_FF8058+3).w,d5
                subq.w  #1,d5
Tilemap_MirrorQueuedColumnsLoop:                        ; CODE XREF: Tilemap_QueueIndexedColumns+FC   j  ; was: loc_11142
                moveq   #0,d0
                move.w  d5,d7
Tilemap_MirrorQueuedColumnWordsLoop:                    ; CODE XREF: Tilemap_QueueIndexedColumns+F6   j  ; was: loc_11146
                move.w  (a1)+,(a2,d0.w)
                addi.w  #$80,d0
                dbf     d7,Tilemap_MirrorQueuedColumnWordsLoop
                addq.w  #2,a2
                dbf     d6,Tilemap_MirrorQueuedColumnsLoop
Tilemap_IndexedColumnsReturn:                           ; CODE XREF: Tilemap_QueueIndexedColumns+C6   j  ; was: locret_11158
                rts
; End of function Tilemap_QueueIndexedColumns
; ---------------------------------------------------------------------------
; Unreferenced descriptor for a 4x4 indexed-column tilemap transfer
UnreferencedIndexedColumnTransferDescriptor:            ; was: unused_3
                binclude "data/other/unreferenced_indexed_column_transfer_descriptor.bin"
