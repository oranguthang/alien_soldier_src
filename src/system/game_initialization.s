Sys_InitFullGame:                                       ; CODE XREF: RegionRestricted+4   p  ; was: sub_2D40
                clr.w   (word_FFFF3E).w
                bsr.w   Gfx_LoadVDPRegistersAlt
                bsr.w   Sys_InitSubsystems
                bsr.w   Sys_InitGraphicsChain
                bsr.w   Sys_ClearPaletteBuffers
                bsr.w   Gfx_InitVideoMode
                bsr.w   Sys_ClearGameBuffers
                bsr.w   Sys_ClearBufferFFA200
                bsr.w   Sys_ClearSpriteBuffers
                bsr.w   Sys_ClearObjectRAM
                bra.w   Sys_ClearObjectBuffer
; End of function Sys_InitFullGame
; Full game mode initialization sequence
Sys_InitGameMode:                                       ; CODE XREF: Cutscene_InitCreditsScreen+A   p  ; was: sub_2D6C
                                        ; UI_InitTitleScreen+6   p
                clr.w   (word_FFFF3E).w
                bsr.w   Gfx_LoadVDPRegisters
                bsr.w   Sys_InitSubsystems
                bsr.w   Sys_InitGraphicsChain
                bsr.w   Sys_ClearPaletteBuffers
                bsr.w   Gfx_InitVideoMode
                bsr.w   Sys_ClearGameBuffers
                bsr.w   Sys_ClearSpriteBuffers
                bsr.w   Sys_ClearObjectRAM
                bra.w   Sys_ClearObjectBuffer
; End of function Sys_InitGameMode
; Initializes core subsystems and memory structures
Sys_InitSubsystems:                                     ; CODE XREF: Sys_InitFullGame+8   p  ; was: sub_2D94
                                        ; Sys_InitGameMode+8   p
                bsr.w   Gfx_ClearCRAM
                bsr.w   Gfx_ClearVRAMPlane
                bsr.w   Sys_ClearRAM
                bsr.w   Sys_ClearScrollBuffer
                bsr.w   Gfx_ClearHScrollBuffer
                bsr.w   Boss_ZLeoClearVRAM
                bsr.w   Gfx_ClearVScrollBuffer
                bra.w   Gfx_ClearVRAMData
; End of function Sys_InitSubsystems
; Initializes graphics subsystem chain
Sys_InitGraphicsChain:                                  ; CODE XREF: Sys_InitFullGame+C   p  ; was: sub_2DB4
                                        ; Sys_InitGameMode+C   p
                bsr.w   Gfx_InitializeChain
                bsr.w   Sys_ClearBufferFFA800
                bsr.w   Sprite_ClearOAMBuildState
                bsr.w   Sprite_ClearOAMBuffer
                bsr.w   VDP_ClearData
                rts
; End of function Sys_InitGraphicsChain
; Wrapper to clear palette buffer
Sys_ClearPaletteBuffers:                                ; CODE XREF: Sys_InitFullGame+10   p  ; was: sub_2DCA
                                        ; Sys_InitGameMode+10   p
                bsr.w   Palette_ClearBuffers
                rts
; End of function Sys_ClearPaletteBuffers
; Clears multiple game buffers including VDP command buffer sprite buffer and input state
Sys_ClearGameBuffers:                                   ; CODE XREF: Reset+224   p  ; was: sub_2DD0
                                        ; Sys_InitFullGame+18   p
                bsr.w   Sys_ClearVDPCommandBuffer
                bsr.w   Sys_ClearSpriteBuffer
                bsr.w   Sys_ClearBufferFFB800
                bsr.w   Input_InitControllerState
                move.w  #$F400,(VDPCommandQueueHead).w
                move.w  #$F400,(VDPStagingDataCursor).w
                move.l  #$FFFFE400,(HScrollDMASource).w
                move.l  #$FFFFEC00,(VScrollDMASource).w
                rts
; End of function Sys_ClearGameBuffers
; Initializes video mode and clears VRAM
Gfx_InitVideoMode:                                      ; CODE XREF: Sys_InitFullGame+14   p  ; was: sub_2DFE
                                        ; Sys_InitGameMode+14   p
                bsr.w   Gfx_ClearGraphicsStagingBuffer
                bsr.w   Gfx_ClearVRAM
                rts
; End of function Gfx_InitVideoMode
; Initializes all VDP registers by loading values from lookup table and storing them to VDP_CTRL and RAM
Gfx_InitVDPRegisters:                                   ; CODE XREF: Reset+218   p  ; was: sub_2E08
                                        ; ShowRedScreen   p
                lea     Gfx_InitialVDPRegisterValues(pc),a0
                lea     (VDPReg0Shadow).w,a1
                move.w  #$8000,d0
                moveq   #$17,d7
Gfx_InitVDPRegisters_Loop:                              ; CODE XREF: Gfx_InitVDPRegisters+1C   j  ; was: loc_2E16
                move.b  (a0)+,d0
                move.w  d0,(VDP_CTRL).l
                move.w  d0,(a1)+
                addi.w  #$100,d0
                dbf     d7,Gfx_InitVDPRegisters_Loop
                rts
; End of function Gfx_InitVDPRegisters
; Loads alternative VDP register table for boot
Gfx_LoadVDPRegistersAlt:                                ; CODE XREF: Sys_InitFullGame+4   p  ; was: sub_2E2A
                lea     Gfx_InitialVDPRegisterValues(pc),a0
                bra.w   Gfx_LoadVDPRegisters_Setup
; End of function Gfx_LoadVDPRegistersAlt
; Loads VDP register values from table
Gfx_LoadVDPRegisters:                                   ; CODE XREF: Sys_InitGameMode+4   p  ; was: sub_2E32
                                        ; Stage_LoadBackgroundGraphics+26   p
                lea     Gfx_GameVDPRegisterValues(pc),a0
Gfx_LoadVDPRegisters_Setup:                             ; CODE XREF: Gfx_LoadVDPRegistersAlt+4   j  ; was: loc_2E36
                lea     (VDPReg0Shadow).w,a1
                move.w  #$8000,d0
                moveq   #23,d7
; Loop that loads VDP register values from table incrementing register number for each write
Gfx_LoadVDPLoop:                                        ; CODE XREF: Gfx_LoadVDPRegisters+16   j  ; was: loc_2E40
                move.b  (a0)+,d0
                move.w  d0,(a1)+
                addi.w  #$100,d0
                dbf     d7,Gfx_LoadVDPLoop
                rts
; End of function Gfx_LoadVDPRegisters
; ---------------------------------------------------------------------------
Gfx_InitialVDPRegisterValues:   dc.b    4, $24, $30, $34, 7, $7A, 0, 0  ; was: byte_2E4E
                                        ; DATA XREF: Gfx_InitVDPRegisters   o
                                        ; sub_2E2A   o
                dc.b    0, 0, 0, 0, $81, $3C, 0, 2
                dc.b    1, 0, 0, 0, 0, 0, 0
                align0  2
Gfx_GameVDPRegisterValues:  dc.b    4, $24, $30, $34, 7, $7A, 0, $10  ; was: byte_2E66
                                        ; DATA XREF: Gfx_LoadVDPRegisters   o
                dc.b    0, 0, 0, 0, $81, $3C, 0, 2
                dc.b    1, 0, 4, 0, 0, 0, 0
                align0  2

; Initializes controller I/O ports and modes
