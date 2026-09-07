Sys_ClearVDPCommandBuffer:                               ; CODE XREF: Sys_ClearGameBuffers   p  ; was: sub_3134
                lea     (VDPCommand).w,a0
                moveq   #0,d0
                move.w  #$C,d1
loc_313E:                               ; CODE XREF: Sys_ClearVDPCommandBuffer+12   j
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d1,loc_313E
                rts
; End of function Sys_ClearVDPCommandBuffer
; Clears all 64KB of VRAM to zero
Gfx_ClearFullVRAM:
                move    sr,-(sp)  ; was: sub_314C
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000000,(VDP_CTRL).l
                move.w  #$7FFF,d0
                move.w  #0,d1
loc_3172:                               ; CODE XREF: Gfx_ClearFullVRAM+28   j
                move.w  d1,(a0)
                dbf     d0,loc_3172
                move    (sp)+,sr
                rts
; End of function Gfx_ClearFullVRAM
; Clears entire VRAM with interrupts disabled
Gfx_ClearVRAM:                               ; CODE XREF: Gfx_InitVideoMode+4   p  ; was: sub_317C
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000000,(VDP_CTRL).l
                move.w  #$5FFF,d0
                move.w  #0,d1
loc_31A2:                               ; CODE XREF: Gfx_ClearVRAM+28   j
                move.w  d1,(a0)
                dbf     d0,loc_31A2
                move    (sp)+,sr
                rts
; End of function Gfx_ClearVRAM
; Clears first 24KB of VRAM to zero
Gfx_ClearVRAM24KB:
                move    sr,-(sp)  ; was: sub_31AC
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000000,(VDP_CTRL).l
                move.w  #$2FFF,d0
                move.w  #0,d1
loc_31D2:                               ; CODE XREF: Gfx_ClearVRAM24KB+28   j
                move.w  d1,(a0)
                dbf     d0,loc_31D2
                move    (sp)+,sr
                rts
; End of function Gfx_ClearVRAM24KB
; Clears Plane B VRAM at $6000 (24KB)
Gfx_ClearPlaneBVRAM:
                move    sr,-(sp)  ; was: sub_31DC
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000001,(VDP_CTRL).l
                move.w  #$2FFF,d0
                move.w  #0,d1
loc_3202:                               ; CODE XREF: Gfx_ClearPlaneBVRAM+28   j
                move.w  d1,(a0)
                dbf     d0,loc_3202
                move    (sp)+,sr
                rts
; End of function Gfx_ClearPlaneBVRAM
; Clears CRAM color RAM area
Gfx_ClearCRAM:                               ; CODE XREF: Sys_InitSubsystems   p  ; was: sub_320C
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$40000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_3232:                               ; CODE XREF: Gfx_ClearCRAM+28   j
                move.w  d1,(a0)
                dbf     d0,loc_3232
                move    (sp)+,sr
                rts
; End of function Gfx_ClearCRAM
; Clears VSRAM scroll table area
Gfx_ClearVScroll:
                move    sr,-(sp)  ; was: sub_323C
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$50000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_3262:                               ; CODE XREF: Gfx_ClearVScroll+28   j
                move.w  d1,(a0)
                dbf     d0,loc_3262
                move    (sp)+,sr
                rts
; End of function Gfx_ClearVScroll
; Clears VRAM plane data
Gfx_ClearVRAMPlane:                               ; CODE XREF: Sys_InitSubsystems+4   p  ; was: sub_326C
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$60000003,(VDP_CTRL).l
                move.w  #$7FF,d0
                move.w  #0,d1
loc_3292:                               ; CODE XREF: Gfx_ClearVRAMPlane+28   j
                move.w  d1,(a0)
                dbf     d0,loc_3292
                move    (sp)+,sr
                rts
; End of function Gfx_ClearVRAMPlane
; Clear VRAM plane
Boss_ZLeoClearVRAM:                               ; CODE XREF: Sys_InitSubsystems+14   p  ; was: sub_329C
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$70000003,(VDP_CTRL).l
                move.w  #$1FF,d0
                move.w  #0,d1
loc_32C2:                               ; CODE XREF: Boss_ZLeoClearVRAM+28   j
                move.w  d1,(a0)
                dbf     d0,loc_32C2
                move    (sp)+,sr
                rts
; End of function Boss_ZLeoClearVRAM
; Clears VDP data with status register disable
VDP_ClearData:                               ; CODE XREF: Sys_InitGraphicsChain+10   p  ; was: sub_32CC
                move    sr,-(sp)
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.w  #$8F02,(VDP_CTRL).l
                move.l  #$74000003,(VDP_CTRL).l
                move.w  #$13F,d0
                move.w  #0,d1
loc_32F2:                               ; CODE XREF: VDP_ClearData+28   j
                move.w  d1,(a0)
                dbf     d0,loc_32F2
                move    (sp)+,sr
                rts
; End of function VDP_ClearData
; Clears VRAM by writing zeros to VDP data port with interrupts disabled
Gfx_ClearVRAMData:                               ; CODE XREF: Sys_InitSubsystems+1C   j  ; was: sub_32FC
                move    #$2700,sr
                lea     (VDP_DATA).l,a0
                move.l  #$40000010,(VDP_CTRL).l
                move.w  #$13,d0
                moveq   #0,d1
loc_3316:                               ; CODE XREF: Gfx_ClearVRAMData+1C   j
                move.l  d1,(a0)
                dbf     d0,loc_3316
                move    #$2300,sr
                rts
; End of function Gfx_ClearVRAMData
; Clears CRAM (color RAM) by writing zeros with interrupts disabled
Gfx_ClearCRAMData:
                move    #$2700,sr  ; was: sub_3322
                lea     (VDP_DATA).l,a0
                move.l  #$C0000000,(VDP_CTRL).l
                move.w  #$1F,d0
                moveq   #0,d1
loc_333C:                               ; CODE XREF: Gfx_ClearCRAMData+1C   j
                move.l  d1,(a0)
                dbf     d0,loc_333C
                move    #$2300,sr
                rts
; End of function Gfx_ClearCRAMData
; Clears memory block by calling write routine seven times
Sys_ClearMemoryBlockX7:
                bsr.s Sys_WriteMemoryLongs  ; was: sub_3348
                bsr.s Sys_WriteMemoryLongs
                bsr.s Sys_WriteMemoryLongs
                bsr.s Sys_WriteMemoryLongs
                bsr.s Sys_WriteMemoryLongs
                bsr.s Sys_WriteMemoryLongs
                bsr.s Sys_WriteMemoryLongs
                nop
; End of function Sys_ClearMemoryBlockX7
; Writes 32 longwords (128 bytes) to memory pointed to by a1
Sys_WriteMemoryLongs:                               ; CODE XREF: Sys_ClearMemoryBlockX7   p  ; was: sub_3358
                                        ; Sys_ClearMemoryBlockX7+2   p ...
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                move.l  d1,(a1)+
                rts
; End of function Sys_WriteMemoryLongs
; Copies 16 bytes (4 longwords) from a1 to a2
Data_Copy16Bytes:
                move.l  (a1)+,(a2)+  ; was: sub_339A
                move.l  (a1)+,(a2)+
                move.l  (a1)+,(a2)+
                move.l  (a1)+,(a2)+
                rts
; End of function Data_Copy16Bytes
; Initializes controller input state clearing button flags
