Stage_InitScrollEffect1:
                move.w  #2,(word_FF8100).w              ; was: sub_2626C
                move.w  #0,(word_FF8102).w
                move.w  #0,(word_FF8104).w
                move.w  #$70,(word_FFEC02).w            ; 'p'
                rts
; End of function Stage_InitScrollEffect1
; Stops scrolling effect by resetting state variables and counters
Stage_StopScrollEffect:
                move.b  #4,(word_FFF7D0+1).w            ; was: sub_26286
                move.b  #$30,(word_FFF7D4+1).w          ; '0'
                move.w  #0,(word_FF8100).w
                move.w  #0,(word_FFEC02).w
                rts
; End of function Stage_StopScrollEffect
; Main controller for wave/distortion effect, dispatches to state handlers
Effect_WaveController:
                bsr.w   Memory_ClearBuffer              ; was: sub_262A0
                movea.w (word_FF8104).w,a0
                movea.l off_262AE(pc,a0.w),a0
                jmp     (a0)
; End of function Effect_WaveController
; ---------------------------------------------------------------------------
off_262AE:      dc.l    Effect_WaveInitialize           ; DATA XREF: Effect_WaveController+8   r
                dc.l    Effect_WaveHoldState
                dc.l    Effect_WaveFadeOut
                dc.l    Effect_WaveLoopOrEnd
                dc.l    Gfx_UpdateScrollEffect
                dc.l    Gfx_ScrollEffectEmptyState

; Initializes wave effect by setting up buffer and incrementing counter
Effect_WaveInitialize:                                  ; DATA XREF: ROM:off_262AE   o  ; was: sub_262C6
                movea.l #$FFFF9E40,a6
                bsr.w   Gfx_GenerateWaveDeformation
                bsr.w   nullsub_57
                addq.w  #2,(word_FF8102).w
                cmpi.w  #$1C,(word_FF8102).w
                bne.w   locret_262EC
                addq.w  #4,(word_FF8104).w
                move.w  #$78,(dword_FF8040).w           ; 'x'
locret_262EC:                                           ; CODE XREF: Effect_WaveInitialize+18   j
                rts
; End of function Effect_WaveInitialize
; Holds wave effect active state while waiting for timer countdown
Effect_WaveHoldState:                                   ; DATA XREF: ROM:000262B2   o  ; was: sub_262EE
                movea.l #$FFFF9E40,a6
                bsr.w   Gfx_GenerateWaveDeformation
                subq.w  #1,(dword_FF8040).w
                bne.w   locret_2630A
                addq.w  #4,(word_FF8104).w
                move.w  #1,(dword_FF8040).w
locret_2630A:                                           ; CODE XREF: Effect_WaveHoldState+E   j
                rts
; End of function Effect_WaveHoldState
; Fades out wave effect by decrementing counter back to minimum value
Effect_WaveFadeOut:                                     ; DATA XREF: ROM:000262B6   o  ; was: sub_2630C
                movea.l #$FFFF9E80,a6
                bsr.w   Gfx_GenerateWaveDeformation
                subq.w  #2,(word_FF8102).w
                cmpi.w  #6,(word_FF8102).w
                bne.w   locret_26328
                addq.w  #4,(word_FF8104).w
locret_26328:                                           ; CODE XREF: Effect_WaveFadeOut+14   j
                rts
; End of function Effect_WaveFadeOut
; Loops wave effect or ends it based on remaining iteration counter
Effect_WaveLoopOrEnd:                                   ; DATA XREF: ROM:000262BA   o  ; was: sub_2632A
                movea.l #$FFFF9E00,a6
                bsr.w   Gfx_GenerateWaveDeformation
                addq.w  #2,(word_FF8102).w
                cmpi.w  #$1C,(word_FF8102).w
                bne.w   locret_26354
                subq.w  #1,(dword_FF8040).w
                bpl.w   loc_26350
                addq.w  #4,(word_FF8104).w
                rts
; ---------------------------------------------------------------------------
loc_26350:                                              ; CODE XREF: Effect_WaveLoopOrEnd+1C   j
                subq.w  #4,(word_FF8104).w
locret_26354:                                           ; CODE XREF: Effect_WaveLoopOrEnd+14   j
                rts
; End of function Effect_WaveLoopOrEnd
; Updates scroll effect with timing control and state increments
Gfx_UpdateScrollEffect:                                 ; DATA XREF: ROM:000262BE   o  ; was: sub_26356
                movea.l #$FFFF9E00,a6
                bsr.w   Gfx_GenerateWaveDeformation
                bsr.w   nullsub_57
                subq.w  #2,(word_FF8102).w
                bne.w   locret_26370
                addq.w  #4,(word_FF8104).w
locret_26370:                                           ; CODE XREF: Gfx_UpdateScrollEffect+12   j
                rts
; End of function Gfx_UpdateScrollEffect
; Empty scroll effect graphics state
Gfx_ScrollEffectEmptyState:                             ; DATA XREF: ROM:000262C2   o  ; was: nullsub_58
                rts
; End of function Gfx_ScrollEffectEmptyState
nullsub_59:
                rts
; End of function nullsub_59

; Clears 0x50 dwords in RAM buffer starting at $FFFF9800
Memory_ClearBuffer:                                     ; CODE XREF: Effect_WaveController   p  ; was: sub_26376
                movea.l #$FFFF9800,a0
                moveq   #0,d0
                move.w  #$50,d7                         ; 'P'
loc_26382:                                              ; CODE XREF: Memory_ClearBuffer+E   j
                move.l  d0,(a0)+
                dbf     d7,loc_26382
                rts
; End of function Memory_ClearBuffer
; Generates sine wave deformation tables for screen warping effect
Gfx_GenerateWaveDeformation:                            ; CODE XREF: Effect_WaveInitialize+6   p  ; was: sub_2638A
                                        ; Effect_WaveHoldState+6   p
                move.b  #$14,(word_FFF7D0+1).w
                move.b  #0,(word_FFF7E4+1).w
                move.b  #$38,(word_FFF7D4+1).w          ; '8'
                move.w  (word_FF8102).w,d0
                movea.l #word_26434,a0
                move.w  (a0,d0.w),d0
                moveq   #0,d1
                moveq   #0,d2
                movea.l #$FFFF9F00,a0
                movea.l #$FFFF9F00,a1
                move.w  #$7F,d7
loc_263BE:                                              ; CODE XREF: Gfx_GenerateWaveDeformation+4C   j
                suba.w  #2,a0
                add.w   d0,d1
                move.w  d1,d6
                lsr.w   #8,d6
                move.w  d6,(a0)
                adda.w  #2,a1
                sub.w   d0,d2
                move.w  d2,d6
                lsr.w   #8,d6
                move.w  d6,(a1)
                dbf     d7,loc_263BE
                move.w  (word_FF8102).w,d0
                movea.l #word_26416,a0
                move.w  (a0,d0.w),d7
                movea.l #$FFFF9800,a0
                adda.w  d0,a0
                movea.l a0,a1
                move.w  #$1C,d1
                sub.w   d0,d1
                addi.w  #$B,d1
                move.w  #3,d3
loc_26400:                                              ; CODE XREF: Gfx_GenerateWaveDeformation+86   j
                move.w  d1,d2
loc_26402:                                              ; CODE XREF: Gfx_GenerateWaveDeformation+7C   j
                move.w  d7,(a0)+
                addq.w  #1,d7
                dbf     d2,loc_26402
                adda.w  #$50,a1                         ; 'P'
                movea.l a1,a0
                dbf     d3,loc_26400
                rts
; End of function Gfx_GenerateWaveDeformation
; ---------------------------------------------------------------------------
word_26416:     dc.w    $85B8, $8520, $8490, $8408, $8388, $8310, $82A0, $8238, $81D8, $8180, $8130, $80E8, $80A8, $8070, $8040
                                        ; DATA XREF: Gfx_GenerateWaveDeformation+54   o
word_26434:     dc.w    $E0, $D0, $C0, $B0, $A0, $90, $80, $70, $60, $50, $40, $30, $20, $10, 0
                                        ; DATA XREF: Gfx_GenerateWaveDeformation+16   o

; Calculates two tile coordinate pairs from wave deformation data
Gfx_CalculateTileCoordinates:                           ; CODE XREF: Gfx_RenderTilemapToVRAM:loc_261E4   p  ; was: sub_26452
                bsr.w   Math_WaveToTileIndex
                move.w  d0,d2
                bsr.w   Math_WaveToTileIndex
                move.w  d0,d3
                rts
; End of function Gfx_CalculateTileCoordinates
; Converts wave accumulator value to tile index with masking
Math_WaveToTileIndex:                                   ; CODE XREF: Gfx_CalculateTileCoordinates   p  ; was: sub_26460
                                        ; Gfx_CalculateTileCoordinates+6   p
                add.w   d6,d5
                move.w  d5,d0
                move.w  d5,d1
                asr.w   #8,d0
                andi.w  #7,d0
                asr.w   #8,d1
                andi.w  #$FFF8,d1
                or.w    d1,d0
                rts
; End of function Math_WaveToTileIndex
; Calculates tile buffer addresses and pixel offset from coordinates
Gfx_PrepareTilePointers:                                ; CODE XREF: Gfx_RenderTilemapToVRAM+10   p  ; was: sub_26476
                asr.w   #1,d2
                bcs.w   loc_26482
                moveq   #0,d0
                bra.w   loc_26484
; ---------------------------------------------------------------------------
loc_26482:                                              ; CODE XREF: Gfx_PrepareTilePointers+2   j
                moveq   #4,d0
loc_26484:                                              ; CODE XREF: Gfx_PrepareTilePointers+8   j
                move.w  d2,d1
                andi.l  #3,d2
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d2
                addi.l  #sega_tiles,d2
                movea.l d2,a0
                asr.w   #1,d3
                bcs.w   loc_264A4
                addq.w  #8,d0
loc_264A4:                                              ; CODE XREF: Gfx_PrepareTilePointers+28   j
                move.w  d3,d1
                andi.l  #3,d3
                asl.w   #3,d1
                andi.w  #$FFE0,d1
                or.w    d1,d3
                addi.l  #sega_tiles,d3
                movea.l d3,a1
                rts
; End of function Gfx_PrepareTilePointers
; Dispatches to pixel blending routine based on alignment offset
Gfx_PixelBlendDispatcher:                               ; CODE XREF: Gfx_RenderTilemapToVRAM+14   p  ; was: sub_264BE
                move.w  #3,d2
                movea.w d0,a3
                movea.l off_264CA(pc,a3.w),a3
                jmp     (a3)
; End of function Gfx_PixelBlendDispatcher
; ---------------------------------------------------------------------------
off_264CA:      dc.l    Gfx_BlendPixelsHighNibble       ; DATA XREF: Gfx_PixelBlendDispatcher+6   r
                dc.l    Gfx_BlendPixelsShiftedHigh
                dc.l    Gfx_BlendPixelsHighAndShifted
                dc.l    Gfx_BlendPixelsFullyShifted

; Blends pixels preserving high nibble from first source
Gfx_BlendPixelsHighNibble:                              ; CODE XREF: Gfx_BlendPixelsHighNibble+32   j  ; was: sub_264DA
                                        ; DATA XREF: ROM:off_264CA   o
                move.w  #7,d3
loc_264DE:                                              ; CODE XREF: Gfx_BlendPixelsHighNibble+20   j
                move.b  (a0),d0
                andi.w  #$F0,d0
                move.b  (a1),d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_264DE
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf     d2,Gfx_BlendPixelsHighNibble
                rts
; End of function Gfx_BlendPixelsHighNibble
; Blends pixels with first source shifted to high nibble
Gfx_BlendPixelsShiftedHigh:                             ; CODE XREF: Gfx_BlendPixelsShiftedHigh+30   j  ; was: sub_26512
                                        ; DATA XREF: ROM:000264CE   o
                move.w  #7,d3
loc_26516:                                              ; CODE XREF: Gfx_BlendPixelsShiftedHigh+1E   j
                move.b  (a0),d0
                asl.w   #4,d0
                move.b  (a1),d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_26516
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf     d2,Gfx_BlendPixelsShiftedHigh
                rts
; End of function Gfx_BlendPixelsShiftedHigh
; Blends pixels with high nibble and shifted low nibble
Gfx_BlendPixelsHighAndShifted:                          ; CODE XREF: Gfx_BlendPixelsHighAndShifted+34   j  ; was: sub_26548
                                        ; DATA XREF: ROM:000264D2   o
                move.w  #7,d3
loc_2654C:                                              ; CODE XREF: Gfx_BlendPixelsHighAndShifted+22   j
                move.b  (a0),d0
                andi.w  #$F0,d0
                move.b  (a1),d1
                lsr.w   #4,d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_2654C
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf     d2,Gfx_BlendPixelsHighAndShifted
                rts
; End of function Gfx_BlendPixelsHighAndShifted
; Blends pixels with both sources shifted and combined
Gfx_BlendPixelsFullyShifted:                            ; CODE XREF: Gfx_BlendPixelsFullyShifted+32   j  ; was: sub_26582
                                        ; DATA XREF: ROM:000264D6   o
                move.w  #7,d3
loc_26586:                                              ; CODE XREF: Gfx_BlendPixelsFullyShifted+20   j
                move.b  (a0),d0
                asl.w   #4,d0
                move.b  (a1),d1
                lsr.w   #4,d1
                andi.w  #$F,d1
                or.w    d1,d0
                move.b  d0,(a2)
                lea     4(a0),a0
                lea     4(a1),a1
                lea     4(a2),a2
                dbf     d3,loc_26586
                adda.l  #$160,a0
                adda.l  #$160,a1
                adda.w  d4,a2
                dbf     d2,Gfx_BlendPixelsFullyShifted
                rts
; End of function Gfx_BlendPixelsFullyShifted
; Initializes wave deformation parameters from lookup tables
Gfx_InitializeWaveParameters:                           ; CODE XREF: Gfx_RenderTilemapToVRAM+8   p  ; was: sub_265BA
                move.w  (word_FF8102).w,d0
                moveq   #0,d5
                movea.l #$FFFF0000,a2
                movea.w #0,a4
                movea.l #word_265EC,a0
                move.w  (a0,d0.w),d6
                sub.w   d6,d5
                movea.l #word_26608,a0
                move.w  (a0,d0.w),d4
                movea.l #word_26624,a0
                move.w  (a0,d0.w),d7
                rts
; End of function Gfx_InitializeWaveParameters
; ---------------------------------------------------------------------------
word_265EC:     dc.w    $DB, $C0, $AA, $99, $8B, $80, $76, $6D, $66, $60, $5A, $55, $50, $4C
                                        ; DATA XREF: Gfx_InitializeWaveParameters+10   o
word_26608:     dc.w    $1A0, $1E0, $220, $260, $2A0, $2E0, $320, $360, $3A0, $3E0, $420, $460, $4A0, $4E0
                                        ; DATA XREF: Gfx_InitializeWaveParameters+1C   o
word_26624:     dc.w    $37, $3F, $47, $4F, $57, $5F, $67, $6F, $77, $7F, $87, $8F, $97, $9F
                                        ; DATA XREF: Gfx_InitializeWaveParameters+26   o
word_26640:     dc.w    $E00, $1500, $1D00, $2600, $3000, $3B00, $4700, $5400, $6200, $7100, $8100, $9200, $A400, $B700
                                        ; DATA XREF: Gfx_RenderTilemapToVRAM+3E   o

nullsub_57:                                             ; CODE XREF: Effect_WaveInitialize+A   p
                                        ; Gfx_UpdateScrollEffect+A   p
                rts
; End of function nullsub_57
; ---------------------------------------------------------------------------
unused_6:       binclude "data/other/unused_6.bin"

; Main loop for loading tiles to VRAM
Gfx_LoadTilesLoop:                                      ; CODE XREF: Cutscene_InitCreditsScreen+3E   p  ; was: sub_2667C
                                        ; Stage_LoadTeleportGraphics+2C   j
                move.w  #1,(a0)
                move.w  #$20,(dword_FF8040).w           ; ' '
loc_26686:                                              ; CODE XREF: Gfx_LoadTilesLoop+48   j
                movea.w #(word_FF9800-M68K_RAM),a5
                move.l  #$8000,d0
                divs.w  (dword_FF8040).w,d0
                andi.l  #$FFFF,d0
                asl.l   #5,d0
                move.l  d0,d1
                asl.l   #3,d1
                clr.l   d2
                bsr.w   Memory_ClearTileBuffer
loc_266A6:                                              ; CODE XREF: Gfx_LoadTilesLoop+34   j
                bsr.w   Gfx_InterpolateCompressedTiles
                cmpi.l  #$100000,d2
                bmi.w   loc_266A6
                bsr.w   Gfx_TileLoadDispatcher
                move.w  (dword_FF8044+2).w,d7
                sub.w   d7,(dword_FF8040).w
                subq.w  #1,(word_FF804A).w
                bpl.w   loc_26686
                rts
; End of function Gfx_LoadTilesLoop
; Decompresses and loads tiles with interpolation into tile buffer
Gfx_DecompressTilesInterpolated:
                move.w  #1,(a0)                         ; was: sub_266CA
                movea.w #(word_FF9800-M68K_RAM),a5
                move.l  #$8000,d0
                divs.w  (dword_FF8040).w,d0
                andi.l  #$FFFF,d0
                asl.l   #5,d0
                move.l  d0,d1
                asl.l   #3,d1
                clr.l   d2
                bsr.w   Memory_ClearTileBuffer
loc_266EE:                                              ; CODE XREF: Gfx_DecompressTilesInterpolated+2E   j
                bsr.w   Gfx_InterpolateCompressedTiles
                cmpi.l  #$100000,d2
                bmi.w   loc_266EE
                bra.w   Gfx_TileLoadDispatcher
; End of function Gfx_DecompressTilesInterpolated
; Interpolates between two compressed tile patterns for morphing effects
Gfx_InterpolateCompressedTiles:                         ; CODE XREF: Gfx_LoadTilesLoop:loc_266A6   p  ; was: sub_26700
                                        ; sub_266CA:loc_266EE   p
                movea.w a1,a2
                movea.w a1,a3
                movea.w a5,a4
                addq.w  #2,a4
                clr.l   d5
                clr.w   d7
                cmpi.w  #$8000,d2
                bmi.w   loc_26716
                addq.w  #1,d7
loc_26716:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+10   j
                move.l  d2,d6
                swap    d6
                andi.w  #$FFFC,d6
                asl.w   #5,d6
                adda.w  d6,a2
                move.w  a2,(dword_FF8040+2).w
                move.l  d2,d3
                swap    d3
                andi.w  #3,d3
                add.l   d0,d2
                cmpi.l  #$100000,d2
                bmi.w   loc_26740
                move.l  #$FFFFF,d2
loc_26740:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+36   j
                cmpi.w  #$8000,d2
                bpl.w   loc_2674A
                addq.w  #2,d7
loc_2674A:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+44   j
                move.l  d2,d6
                swap    d6
                andi.w  #$FFFC,d6
                asl.w   #5,d6
                adda.w  d6,a3
                move.w  a3,(dword_FF8044).w
                move.l  d2,d4
                swap    d4
                andi.w  #3,d4
                add.l   d0,d2
                movem.l d0-d2,-(sp)
loc_26768:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+AE   j
                move.b  (a2,d3.w),d0
                btst    #0,d7
                beq.w   loc_26776
                asl.b   #4,d0
loc_26776:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+70   j
                andi.b  #$F0,d0
                move.b  (a3,d4.w),d2
                btst    #1,d7
                beq.w   loc_26788
                asr.b   #4,d2
loc_26788:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+82   j
                andi.b  #$F,d2
                or.b    d0,d2
                move.b  d2,(a4)
                add.l   d1,d5
                move.l  d5,d0
                swap    d0
                andi.w  #$FFFC,d0
                movea.w d0,a2
                movea.w d0,a3
                adda.w  (dword_FF8040+2).w,a2
                adda.w  (dword_FF8044).w,a3
                addq.w  #4,a4
                cmpi.l  #$800000,d5
                bmi.w   loc_26768
                addq.w  #1,a5
                move.w  a5,d7
                andi.w  #3,d7
                bne.w   loc_267C4
                subq.w  #4,a5
                adda.w  #$80,a5
loc_267C4:                                              ; CODE XREF: Gfx_InterpolateCompressedTiles+BA   j
                movem.l (sp)+,d0-d2
                rts
; End of function Gfx_InterpolateCompressedTiles
; Dispatches tile loading based on count
Gfx_TileLoadDispatcher:                                 ; CODE XREF: Gfx_LoadTilesLoop+38   p  ; was: sub_267CA
                                        ; Gfx_DecompressTilesInterpolated+32   j
                cmpi.w  #$19,(dword_FF8040).w
                bpl.w   loc_268B4
                cmpi.w  #$11,(dword_FF8040).w
                bpl.w   loc_26854
                cmpi.w  #9,(dword_FF8040).w
                bpl.w   loc_26810
                move.w  #$20,(word_FF9800).w            ; ' '
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$20,(word_FF8048).w            ; ' '
                bra.w   Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_26810:                                              ; CODE XREF: Gfx_TileLoadDispatcher+1A   j
                move.w  #$40,(word_FF9800).w            ; '@'
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$40,(word_FF8048).w            ; '@'
                bsr.w   Gfx_LoadObjectData
                move.w  #$40,(word_FF9880).w            ; '@'
                move.w  #$9880,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$40,(word_FF8048).w            ; '@'
                bra.w   Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_26854:                                              ; CODE XREF: Gfx_TileLoadDispatcher+10   j
                move.w  #$60,(word_FF9800).w            ; '`'
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$60,(word_FF8048).w            ; '`'
                bsr.w   Gfx_LoadObjectData
                move.w  #$60,(word_FF9880).w            ; '`'
                move.w  #$9880,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$60,(word_FF8048).w            ; '`'
                bsr.w   Gfx_LoadObjectData
                move.w  #$60,(word_FF9900).w            ; '`'
                move.w  #$9900,4(a0)
                move.w  (word_FF8048).w,6(a0)
                addi.w  #$60,(word_FF8048).w            ; '`'
                bra.w   Gfx_LoadObjectData
; ---------------------------------------------------------------------------
loc_268B4:                                              ; CODE XREF: Gfx_TileLoadDispatcher+6   j
                move.w  #$200,(word_FF9800).w
                move.w  #$FFFF,2(a0)
                move.w  #$9800,4(a0)
                move.w  (word_FF8048).w,6(a0)
                move.w  #$FFFF,8(a0)
                addi.w  #$200,(word_FF8048).w
; End of function Gfx_TileLoadDispatcher
; Loads object data wrapper
Gfx_LoadObjectData:                                     ; CODE XREF: Gfx_TileLoadDispatcher+42   j  ; was: sub_268D8
                                        ; Gfx_TileLoadDispatcher+6A   p
                movem.l d0-d2/a0-a5,-(sp)
                jsr     (LoadObjData).l
                movem.l (sp)+,d0-d2/a0-a5
                rts
; End of function Gfx_LoadObjectData
; Clears tile buffer in RAM
Memory_ClearTileBuffer:                                 ; CODE XREF: Gfx_LoadTilesLoop+26   p  ; was: sub_268E8
                                        ; Gfx_DecompressTilesInterpolated+20   p
                movea.w #(word_FF9800-M68K_RAM),a3
                moveq   #0,d6
                move.w  #$7F,d7
loc_268F2:                                              ; CODE XREF: Memory_ClearTileBuffer+C   j
                move.l  d6,(a3)+
                dbf     d7,loc_268F2
                rts
; End of function Memory_ClearTileBuffer
; Clears sprites except $150 entries for screen transition
