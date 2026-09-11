Input_InitControllers:                                  ; CODE XREF: Reset+21E   p  ; was: sub_2E7E
                move.b  #0,(IO_CT1_SMODE+1).l
                move.b  #0,(IO_CT2_SMODE+1).l
                move.b  #0,(IO_EXT_SMODE+1).l
                move.b  #$40,(IO_CT1_CTRL+1).l          ; '@'
                move.b  #$40,(IO_CT2_CTRL+1).l          ; '@'
                move.b  #0,(IO_EXT_CTRL+1).l
                move.b  #$40,(IO_CT1_DATA+1).l          ; '@'
                clr.l   (dword_FFFF00).w
                rts
; End of function Input_InitControllers
; Clears 32KB RAM block to zero
Sys_ClearRAM:                                           ; CODE XREF: Sys_InitSubsystems+8   p  ; was: sub_2EBC
                lea     (M68K_RAM).l,a0
                moveq   #0,d0
                move.w  #$7FF,d1
Sys_ClearRAM_Loop:                                      ; CODE XREF: Sys_ClearRAM+14   j  ; was: loc_2EC8
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearRAM_Loop
                rts
; End of function Sys_ClearRAM
; Clears first 8KB of RAM (partial clear)
Sys_ClearRAMPartial:
                lea     (M68K_RAM).l,a0                 ; was: sub_2ED6
                moveq   #0,d0
                move.w  #$1FF,d1
Sys_ClearRAMPartial_Loop:                               ; CODE XREF: Sys_ClearRAMPartial+14   j  ; was: loc_2EE2
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearRAMPartial_Loop
                rts
; End of function Sys_ClearRAMPartial
; Clears object RAM area at FF8000
Sys_ClearObjectRAM:                                     ; CODE XREF: Sys_InitFullGame+24   p  ; was: sub_2EF0
                                        ; Sys_InitGameMode+20   p
                lea     (dword_FF8000).w,a0
                moveq   #0,d0
                move.w  #$1FF,d1
Sys_ClearObjectRAM_Loop:                                ; CODE XREF: Sys_ClearObjectRAM+12   j  ; was: loc_2EFA
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearObjectRAM_Loop
                rts
; End of function Sys_ClearObjectRAM
; Clears sprite buffer areas
Sys_ClearSpriteBuffers:                                 ; CODE XREF: Sys_InitFullGame+20   p  ; was: sub_2F08
                                        ; Sys_InitGameMode+1C   p
                lea     (word_FFA000).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Sys_ClearSpriteBuffers_FirstLoop:                       ; CODE XREF: Sys_ClearSpriteBuffers+12   j  ; was: loc_2F12
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearSpriteBuffers_FirstLoop
                lea     (dword_FFA100).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Sys_ClearSpriteBuffers_SecondLoop:                      ; CODE XREF: Sys_ClearSpriteBuffers+28   j  ; was: loc_2F28
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearSpriteBuffers_SecondLoop
                rts
; End of function Sys_ClearSpriteBuffers
; Clears FFA200 buffer area (128 bytes)
Sys_ClearBufferFFA200:                                  ; CODE XREF: Sys_InitFullGame+1C   p  ; was: sub_2F36
                lea     (dword_FFA200).w,a0
                moveq   #0,d0
                move.w  #7,d1
Sys_ClearBufferFFA200_Loop:                             ; CODE XREF: Sys_ClearBufferFFA200+12   j  ; was: loc_2F40
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFA200_Loop
                rts
; End of function Sys_ClearBufferFFA200
; Clears FFA280 timer/state buffer area
Sys_ClearTimerBuffer:
                lea     (word_FFA280).w,a0              ; was: sub_2F4E
                moveq   #0,d0
                move.w  #7,d1
Sys_ClearTimerBuffer_Loop:                              ; CODE XREF: Sys_ClearTimerBuffer+12   j  ; was: loc_2F58
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearTimerBuffer_Loop
                rts
; End of function Sys_ClearTimerBuffer
; Clears main object data buffer with zero fill
Sys_ClearObjectBuffer:                                  ; CODE XREF: Sys_InitFullGame+28   j  ; was: sub_2F66
                                        ; Sys_InitGameMode+24   j
                lea     (word_FFA400).w,a0
                moveq   #0,d0
                move.w  #$3F,d1                         ; '?'
Sys_ClearObjectBuffer_Loop:                             ; CODE XREF: Sys_ClearObjectBuffer+12   j  ; was: loc_2F70
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearObjectBuffer_Loop
                rts
; End of function Sys_ClearObjectBuffer
; Clears first half of object buffer at FFA400
Sys_ClearObjectBufferHalf:
                lea     (word_FFA400).w,a0              ; was: sub_2F7E
                moveq   #0,d0
                move.w  #$1F,d1
Sys_ClearObjectBufferHalf_Loop:                         ; CODE XREF: Sys_ClearObjectBufferHalf+12   j  ; was: loc_2F88
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearObjectBufferHalf_Loop
                rts
; End of function Sys_ClearObjectBufferHalf
; Clears FFA600 buffer area (512 bytes)
Sys_ClearBufferFFA600:
                lea     (dword_FFA600).w,a0             ; was: sub_2F96
                moveq   #0,d0
                move.w  #$1F,d1
Sys_ClearBufferFFA600_Loop:                             ; CODE XREF: Sys_ClearBufferFFA600+12   j  ; was: loc_2FA0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFA600_Loop
                rts
; End of function Sys_ClearBufferFFA600
; Clears FFA400 and FFA600 buffers (96 bytes each)
Sys_ClearDualObjectBuffers:                             ; CODE XREF: Gfx_InitializeChain   p  ; was: sub_2FAE
                lea     (word_FFA400).w,a0
                moveq   #0,d0
                move.w  #5,d1
Sys_ClearDualObjectBuffers_FirstLoop:                   ; CODE XREF: Sys_ClearDualObjectBuffers+12   j  ; was: loc_2FB8
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearDualObjectBuffers_FirstLoop
                lea     (dword_FFA600).w,a0
                moveq   #0,d0
                move.w  #5,d1
Sys_ClearDualObjectBuffers_SecondLoop:                  ; CODE XREF: Sys_ClearDualObjectBuffers+28   j  ; was: loc_2FCE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearDualObjectBuffers_SecondLoop
                rts
; End of function Sys_ClearDualObjectBuffers
; Clears FFA800 buffer area (256 bytes)
Sys_ClearBufferFFA800:                                  ; CODE XREF: Sys_InitGraphicsChain+4   p  ; was: sub_2FDC
                lea     (word_FFA800).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Sys_ClearBufferFFA800_Loop:                             ; CODE XREF: Sys_ClearBufferFFA800+12   j  ; was: loc_2FE6
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFA800_Loop
                rts
; End of function Sys_ClearBufferFFA800
; Clears first 96 bytes of FFA800 buffer
Sys_ClearBufferFFA800Partial:                           ; CODE XREF: Gfx_InitializeChain+4   p  ; was: sub_2FF4
                lea     (word_FFA800).w,a0
                moveq   #0,d0
                move.w  #5,d1
Sys_ClearBufferFFA800Partial_Loop:                      ; CODE XREF: Sys_ClearBufferFFA800Partial+12   j  ; was: loc_2FFE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFA800Partial_Loop
                rts
; End of function Sys_ClearBufferFFA800Partial
; Clears scroll position buffer for stage initialization
Sys_ClearScrollBuffer:                                  ; CODE XREF: Sys_InitSubsystems+C   p  ; was: sub_300C
                lea     (dword_FFA900).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Sys_ClearScrollBuffer_Loop:                             ; CODE XREF: Sys_ClearScrollBuffer+12   j  ; was: loc_3016
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearScrollBuffer_Loop
                rts
; End of function Sys_ClearScrollBuffer
; Clears FFB200 buffer area (512 bytes)
Sys_ClearBufferFFB200:
                lea     (dword_FFB200).w,a0             ; was: sub_3024
                moveq   #0,d0
                move.w  #$1F,d1
Sys_ClearBufferFFB200_Loop:                             ; CODE XREF: Sys_ClearBufferFFB200+12   j  ; was: loc_302E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFB200_Loop
                rts
; End of function Sys_ClearBufferFFB200
; Clears tile processing buffer at $FFB400 by writing zeros for $40 iterations (256 bytes)
Gfx_ClearTileBuffer:                                    ; CODE XREF: Gfx_InitVideoMode   p  ; was: sub_303C
                lea     (dword_FFB400).w,a0
                moveq   #0,d0
                move.w  #$3F,d1                         ; '?'
Gfx_ClearTileBuffer_Loop:                               ; CODE XREF: Gfx_ClearTileBuffer+12   j  ; was: loc_3046
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_ClearTileBuffer_Loop
                rts
; End of function Gfx_ClearTileBuffer
; Clears FFB800 buffer area (192 bytes)
Sys_ClearBufferFFB800:                                  ; CODE XREF: Sys_ClearGameBuffers+8   p  ; was: sub_3054
                lea     (dword_FFB800).w,a0
                moveq   #0,d0
                move.w  #$B,d1
Sys_ClearBufferFFB800_Loop:                             ; CODE XREF: Sys_ClearBufferFFB800+12   j  ; was: loc_305E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFB800_Loop
                rts
; End of function Sys_ClearBufferFFB800
; Clears the OAM-build counters and priority-bucket workspace at $FFBE00-$FFBFBF
Sprite_ClearOAMBuildState:                              ; CODE XREF: Sys_InitGraphicsChain+8   p  ; was: sub_306C
                lea     (SpriteOAMEntryCount).w,a0
                moveq   #0,d0
                move.w  #$1B,d1
Sprite_ClearOAMBuildState_Loop:                         ; CODE XREF: Sprite_ClearOAMBuildState+12   j  ; was: loc_3076
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sprite_ClearOAMBuildState_Loop
                rts
; End of function Sprite_ClearOAMBuildState
; Initializes graphics chain with RAM clear operations
Gfx_InitializeChain:                                    ; CODE XREF: Sys_InitGraphicsChain   p  ; was: sub_3084
                bsr.w   Sys_ClearDualObjectBuffers
                bsr.w   Sys_ClearBufferFFA800Partial
                lea     (dword_FFBFC0).w,a0
                moveq   #0,d0
                move.w  #$1CD,d1
Gfx_InitializeChain_Loop:                               ; CODE XREF: Gfx_InitializeChain+1A   j  ; was: loc_3096
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_InitializeChain_Loop
                rts
; End of function Gfx_InitializeChain
; Clears FFBFC0 buffer area (768 bytes)
Sys_ClearBufferFFBFC0:
                lea     (dword_FFBFC0).w,a0             ; was: sub_30A4
                moveq   #0,d0
                move.w  #$2F,d1                         ; '/'
Sys_ClearBufferFFBFC0_Loop:                             ; CODE XREF: Sys_ClearBufferFFBFC0+12   j  ; was: loc_30AE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearBufferFFBFC0_Loop
                rts
; End of function Sys_ClearBufferFFBFC0
; Clears graphics processing chain buffer at $FFE000 by writing zeros for $27 iterations
Gfx_ClearGraphicsChain:                                 ; CODE XREF: Sys_InitGraphicsChain+C   p  ; was: sub_30BC
                lea     (dword_FFE000).w,a0
                moveq   #0,d0
                move.w  #$26,d1                         ; '&'
Gfx_ClearGraphicsChain_Loop:                            ; CODE XREF: Gfx_ClearGraphicsChain+12   j  ; was: loc_30C6
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_ClearGraphicsChain_Loop
                rts
; End of function Gfx_ClearGraphicsChain
; Clears palette buffer to black
Palette_ClearBuffer:                                    ; CODE XREF: Sys_ClearPaletteBuffer   p  ; was: sub_30D4
                lea     (word_FFE300).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Palette_ClearBuffer_Loop:                               ; CODE XREF: Palette_ClearBuffer+12   j  ; was: loc_30DE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Palette_ClearBuffer_Loop
                rts
; End of function Palette_ClearBuffer
; Clears screen buffer at $FFE400 by writing zeros for $80 iterations (512 bytes)
Sys_ClearScreenBuffer:                                  ; CODE XREF: Sys_InitSubsystems+10   p  ; was: sub_30EC
                lea     (word_FFE400).w,a0
                moveq   #0,d0
                move.w  #$7F,d1
Sys_ClearScreenBuffer_Loop:                             ; CODE XREF: Sys_ClearScreenBuffer+12   j  ; was: loc_30F6
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearScreenBuffer_Loop
                rts
; End of function Sys_ClearScreenBuffer
; Clears enemy entity buffer resetting all slots
Sys_ClearEnemyBuffer:                                   ; CODE XREF: Sys_InitSubsystems+18   p  ; was: sub_3104
                lea     (word_FFEC00).w,a0
                moveq   #0,d0
                move.w  #9,d1
Sys_ClearEnemyBuffer_Loop:                              ; CODE XREF: Sys_ClearEnemyBuffer+12   j  ; was: loc_310E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearEnemyBuffer_Loop
                rts
; End of function Sys_ClearEnemyBuffer
; Clears sprite metasprite buffer for new stage
Sys_ClearSpriteBuffer:                                  ; CODE XREF: Sys_ClearGameBuffers+4   p  ; was: sub_311C
                lea     (dword_FFF000).w,a0
                moveq   #0,d0
                move.w  #$6F,d1                         ; 'o'
Sys_ClearSpriteBuffer_Loop:                             ; CODE XREF: Sys_ClearSpriteBuffer+12   j  ; was: loc_3126
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearSpriteBuffer_Loop
                rts
; End of function Sys_ClearSpriteBuffer
; Clears VDP command queue buffer for DMA operations
