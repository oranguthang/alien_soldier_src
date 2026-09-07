Sys_ProcessObjectList:                               ; CODE XREF: Sys_StoryScreenMainLoop+4A   p  ; was: sub_2016
                                        ; UI_UpdateOptionsScreen+68   p ...
                tst.b   (byte_FFF744).w
                bne.w   loc_2022
                bsr.w Sys_InitObjectPointers
loc_2022:                               ; CODE XREF: Sys_ProcessObjectList+4   j
                move.b  (byte_FF813E).w,d3
                ror.l   #8,d3
                move.b  (byte_FFBE00).w,d4
                movea.w (word_FFBE02).w,a3
                lea     (word_FFA400).w,a5
                bsr.w Sprite_ProcessDMAQueue
                move.w  (word_FFF75A).w,d2
                beq.w   loc_206C
                subq.w  #1,d2
                lea     (word_FFED00).w,a2
loc_2046:                               ; CODE XREF: Sys_ProcessObjectList:loc_2068   j
                movea.w (a2)+,a5
                move.b  2(a5),d7
                bpl.s   loc_2078
                add.b   d7,d7
                bpl.w Sprite_CullOffscreen
                movea.l 8(a5),a4
                add.b   d7,d7
                bpl.s   loc_2060
                bsr.w Anim_UpdateFrame
loc_2060:                               ; CODE XREF: Sys_ProcessObjectList+44   j
                swap    d2
                bsr.w Sprite_PrepareOAM
                swap    d2
loc_2068:                               ; CODE XREF: Sys_ProcessObjectList:loc_2078   j
                                        ; Sys_ProcessObjectList+66   j ...
                dbf     d2,loc_2046
loc_206C:                               ; CODE XREF: Sys_ProcessObjectList+26   j
                move.b  d4,(byte_FFBE00).w
                move.w  a3,(word_FFBE02).w
                bra.w Sys_UpdateObjectList
; ---------------------------------------------------------------------------
loc_2078:                               ; CODE XREF: Sys_ProcessObjectList+36   j
                beq.s   loc_2068
                add.b   d7,d7
                bpl.s   loc_2068
                add.b   d7,d7
                bpl.s   loc_2068
                movea.l 8(a5),a4
                pea     loc_2068(pc)
                bra.w Anim_UpdateFrame
; End of function Sys_ProcessObjectList
; Processes sprite DMA queue for batch transfers
Sprite_ProcessDMAQueue:                               ; CODE XREF: Sys_ProcessObjectList+1E   p  ; was: sub_208E
                move.w  2(a5),d7
                bmi.w   loc_20A0
                beq.s   locret_20EC
                movea.l 8(a5),a4
                bra.w Sprite_GetAnimPointer
; ---------------------------------------------------------------------------
loc_20A0:                               ; CODE XREF: Sprite_ProcessDMAQueue+4   j
                move.l  8(a5),d0
                beq.w   locret_20EC
                movea.l d0,a4
                bsr.w Sprite_GetAnimPointer
                btst    #5,d7
                bne.w Sprite_PrepareOAM
                lea     $E0(a5),a2
                cmpa.l  $DC(a5),a4
                beq.w Sprite_CalculatePosition
                move.l  a4,$DC(a5)
                bsr.w Sprite_CalculatePosition
                lea     $E0(a5),a4
                cmpa.w  a4,a2
                beq.w   locret_20EC
                movea.w (word_FFF70C).w,a0
                move.w  $DA(a5),d0
loc_20DC:                               ; CODE XREF: Sprite_ProcessDMAQueue+58   j
                movea.l (a4)+,a1
                jsr (Gfx_SetupDMATransfer).l
                cmpa.w  a4,a2
                bhi.s   loc_20DC
                move.w  a0,(word_FFF70C).w
locret_20EC:                            ; CODE XREF: Sprite_ProcessDMAQueue+8   j
                                        ; Sprite_ProcessDMAQueue+16   j ...
                rts
; End of function Sprite_ProcessDMAQueue
; Alternative sprite DMA queue processing with animation
Sprite_ProcessDMAQueueAlt:
                move.b  2(a5),d7  ; was: sub_20EE
                bmi.w   loc_210E
                beq.w   locret_215E
                add.b   d7,d7
                bpl.w   locret_215E
                add.b   d7,d7
                bpl.w   locret_215E
                movea.l 8(a5),a4
                bra.w Sprite_GetAnimPointer
; ---------------------------------------------------------------------------
loc_210E:                               ; CODE XREF: Sprite_ProcessDMAQueueAlt+4   j
                move.l  8(a5),d0
                beq.w   locret_215E
                movea.l d0,a4
                btst    #5,d7
                beq.w   loc_2128
                movea.l 8(a5),a4
                bsr.w Sprite_GetAnimPointer
loc_2128:                               ; CODE XREF: Sprite_ProcessDMAQueueAlt+2E   j
                lea     $E0(a5),a2
                cmpa.l  $DC(a5),a4
                beq.w Sprite_CalculatePositionAlt
                move.l  a4,$DC(a5)
                bsr.w Sprite_CalculatePositionAlt
                lea     $E0(a5),a4
                cmpa.w  a4,a2
                beq.w   locret_215E
                movea.w (word_FFF70C).w,a0
                move.w  $DA(a5),d0
loc_214E:                               ; CODE XREF: Sprite_ProcessDMAQueueAlt+6A   j
                movea.l (a4)+,a1
                jsr (Gfx_SetupDMATransfer).l
                cmpa.w  a4,a2
                bhi.s   loc_214E
                move.w  a0,(word_FFF70C).w
locret_215E:                            ; CODE XREF: Sprite_ProcessDMAQueueAlt+8   j
                                        ; Sprite_ProcessDMAQueueAlt+E   j ...
                rts
; End of function Sprite_ProcessDMAQueueAlt
; Updates animation frame with timer and pointer management
Anim_UpdateFrame:                               ; CODE XREF: Sys_ProcessObjectList+46   p  ; was: sub_2160
                                        ; Sys_ProcessObjectList+74   j
                move.w  $C(a5),d0
                tst.b   d0
                bmi.s   loc_2188
                beq.s   loc_217C
                tst.l   d3
                bmi.s   loc_2170
                subq.w  #1,d0
loc_2170:                               ; CODE XREF: Anim_UpdateFrame+C   j
                bne.s   loc_2184
                addq.w  #4,a4
                move.w  2(a4),d0
                bne.s   loc_2180
                adda.w  (a4),a4
loc_217C:                               ; CODE XREF: Anim_UpdateFrame+8   j
                move.w  2(a4),d0
loc_2180:                               ; CODE XREF: Anim_UpdateFrame+18   j
                move.l  a4,8(a5)
loc_2184:                               ; CODE XREF: Anim_UpdateFrame:loc_2170   j
                move.w  d0,$C(a5)
loc_2188:                               ; CODE XREF: Anim_UpdateFrame+6   j
                adda.w  (a4),a4
                rts
; End of function Anim_UpdateFrame
; Returns sprite animation data pointer from entity structure
Sprite_GetAnimPointer:                               ; CODE XREF: Sprite_ProcessDMAQueue+E   j  ; was: sub_218C
                                        ; Sprite_ProcessDMAQueue+1C   p ...
                movea.l 8(a5),a4
                rts
; End of function Sprite_GetAnimPointer
; Advances animation frame using offset-based timing
Anim_AdvanceFrameOffset:
                move.b  $D(a5),d0  ; was: sub_2192
                bmi.s   loc_21E4
                bne.s   loc_21AA
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
                move.b  3(a4),d0
                bra.w   loc_21B8
; ---------------------------------------------------------------------------
loc_21AA:                               ; CODE XREF: Anim_AdvanceFrameOffset+6   j
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
                tst.b   (byte_FF813E).w
                bmi.s   loc_21EC
loc_21B8:                               ; CODE XREF: Anim_AdvanceFrameOffset+14   j
                subq.b  #1,d0
                move.b  d0,$D(a5)
                bne.w   loc_21EC
                movea.l a4,a2
                addq.w  #4,a2
                addq.w  #4,d1
loc_21C8:                               ; CODE XREF: Anim_AdvanceFrameOffset+50   j
                move.b  3(a2),d0
                beq.w   loc_21DC
                move.b  d0,$D(a5)
                move.b  d1,$C(a5)
                adda.w  (a4),a4
                rts
; ---------------------------------------------------------------------------
loc_21DC:                               ; CODE XREF: Anim_AdvanceFrameOffset+3A   j
                move.w  (a2),d0
                adda.w  d0,a2
                add.w   d0,d1
                bra.s   loc_21C8
; ---------------------------------------------------------------------------
loc_21E4:                               ; CODE XREF: Anim_AdvanceFrameOffset+4   j
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
loc_21EC:                               ; CODE XREF: Anim_AdvanceFrameOffset+24   j
                                        ; Anim_AdvanceFrameOffset+2C   j
                adda.w  (a4),a4
                rts
; End of function Anim_AdvanceFrameOffset
; Initializes object pointer table in RAM
