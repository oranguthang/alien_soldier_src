Input_InitControllers:                                  ; CODE XREF: Reset+21E   p  ; was: sub_2E7E
                move.b  #0,(IO_CT1_SMODE+1).l
                move.b  #0,(IO_CT2_SMODE+1).l
                move.b  #0,(IO_EXT_SMODE+1).l
                move.b  #$40,(IO_CT1_CTRL+1).l          ; '@'
                move.b  #$40,(IO_CT2_CTRL+1).l          ; '@'
                move.b  #0,(IO_EXT_CTRL+1).l
                move.b  #$40,(IO_CT1_DATA+1).l          ; '@'
                clr.l   (SystemStateBlock).w
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
                lea     (GameplayStateBuffer).w,a0
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
                lea     (FrameCounter).w,a0
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
; Clears the 128-byte global gameplay-state block
Sys_ClearGameplayStateBlock:                            ; CODE XREF: Sys_InitFullGame+1C   p  ; was: sub_2F36
                lea     (GameplayStateBlock).w,a0
                moveq   #0,d0
                move.w  #7,d1
Sys_ClearGameplayStateBlock_Loop:                       ; CODE XREF: Sys_ClearGameplayStateBlock+12   j  ; was: loc_2F40
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearGameplayStateBlock_Loop
                rts
; End of function Sys_ClearGameplayStateBlock
; Clears the VBlank counter and the following timer/state buffer
Sys_ClearTimerBuffer:
                lea     (VBlankFrameCounter).w,a0       ; was: sub_2F4E
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
                lea     (PlayerObjectType).w,a0
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
                lea     (PlayerObjectType).w,a0         ; was: sub_2F7E
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
                lea     (PlayerObjectType).w,a0
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
                lea     (PrimaryCameraXPosition).w,a0
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
; Clears an otherwise unreferenced 512-byte work area
UnreferencedClearWorkBuffer512:
                lea     (ClearedWorkBuffer512).w,a0     ; was: sub_3024
                moveq   #0,d0
                move.w  #$1F,d1
UnreferencedClearWorkBuffer512_Loop:                    ; CODE XREF: UnreferencedClearWorkBuffer512+12   j  ; was: loc_302E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,UnreferencedClearWorkBuffer512_Loop
                rts
; End of function UnreferencedClearWorkBuffer512
; Clears the shared 1 KiB graphics staging buffer at $FFFFB400
Gfx_ClearGraphicsStagingBuffer:                         ; CODE XREF: Gfx_InitVideoMode   p  ; was: sub_303C
                lea     (GraphicsStagingBuffer).w,a0
                moveq   #0,d0
                move.w  #$3F,d1                         ; '?'
Gfx_ClearGraphicsStagingBuffer_Loop:                    ; CODE XREF: Gfx_ClearGraphicsStagingBuffer+12   j  ; was: loc_3046
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_ClearGraphicsStagingBuffer_Loop
                rts
; End of function Gfx_ClearGraphicsStagingBuffer
; Clears a 192-byte work area during game-buffer initialization
Sys_ClearWorkBuffer192:                                 ; CODE XREF: Sys_ClearGameBuffers+8   p  ; was: sub_3054
                lea     (ClearedWorkBuffer192).w,a0
                moveq   #0,d0
                move.w  #$B,d1
Sys_ClearWorkBuffer192_Loop:                            ; CODE XREF: Sys_ClearWorkBuffer192+12   j  ; was: loc_305E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearWorkBuffer192_Loop
                rts
; End of function Sys_ClearWorkBuffer192
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
                lea     (SharedEffectObjectPool).w,a0
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
; Clears the first eight 96-byte objects in the shared effect pool
Effect_ClearFirstEightObjects:
                lea     (SharedEffectObjectPool).w,a0   ; was: sub_30A4
                moveq   #0,d0
                move.w  #$2F,d1                         ; '/'
Effect_ClearFirstEightObjects_Loop:                     ; CODE XREF: Effect_ClearFirstEightObjects+12   j  ; was: loc_30AE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Effect_ClearFirstEightObjects_Loop
                rts
; End of function Effect_ClearFirstEightObjects
; Clears the 624-byte used prefix of the sprite table uploaded to VRAM $F400 each VBlank
Sprite_ClearOAMBuffer:                                  ; CODE XREF: Sys_InitGraphicsChain+C   p  ; was: sub_30BC
                lea     (SpriteOAMBuffer).w,a0
                moveq   #0,d0
                move.w  #$26,d1                         ; '&'
Sprite_ClearOAMBuffer_Loop:                             ; CODE XREF: Sprite_ClearOAMBuffer+12   j  ; was: loc_30C6
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sprite_ClearOAMBuffer_Loop
                rts
; End of function Sprite_ClearOAMBuffer
; Clears palette buffer to black
Palette_ClearBuffers:                                   ; CODE XREF: Sys_ClearPaletteBuffers   p  ; was: sub_30D4
                lea     (PaletteActiveBuffer).w,a0
                moveq   #0,d0
                move.w  #$F,d1
Palette_ClearBuffers_Loop:                              ; CODE XREF: Palette_ClearBuffers+12   j  ; was: loc_30DE
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Palette_ClearBuffers_Loop
                rts
; End of function Palette_ClearBuffers
; Clears the 2,048-byte horizontal-scroll workspace in 128 iterations
Gfx_ClearHScrollBuffer:                                 ; CODE XREF: Sys_InitSubsystems+10   p  ; was: sub_30EC
                lea     (HScrollBuffer).w,a0
                moveq   #0,d0
                move.w  #$7F,d1
Gfx_ClearHScrollBuffer_Loop:                            ; CODE XREF: Gfx_ClearHScrollBuffer+12   j  ; was: loc_30F6
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_ClearHScrollBuffer_Loop
                rts
; End of function Gfx_ClearHScrollBuffer
; Clears the 160-byte vertical-scroll workspace in ten iterations
Gfx_ClearVScrollBuffer:                                 ; CODE XREF: Sys_InitSubsystems+18   p  ; was: sub_3104
                lea     (VScrollBuffer).w,a0
                moveq   #0,d0
                move.w  #9,d1
Gfx_ClearVScrollBuffer_Loop:                            ; CODE XREF: Gfx_ClearVScrollBuffer+12   j  ; was: loc_310E
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Gfx_ClearVScrollBuffer_Loop
                rts
; End of function Gfx_ClearVScrollBuffer
; Clears the combined sprite and VDP-queue staging region through $FFFFF6FF
Sys_ClearSpriteVDPStagingBuffer:                        ; CODE XREF: Sys_ClearGameBuffers+4   p  ; was: sub_311C
                lea     (SpriteVDPStagingBuffer).w,a0
                moveq   #0,d0
                move.w  #$6F,d1                         ; 'o'
Sys_ClearSpriteVDPStagingBuffer_Loop:                   ; CODE XREF: Sys_ClearSpriteVDPStagingBuffer+12   j  ; was: loc_3126
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,Sys_ClearSpriteVDPStagingBuffer_Loop
                rts
; End of function Sys_ClearSpriteVDPStagingBuffer
; Clears VDP command queue buffer for DMA operations
