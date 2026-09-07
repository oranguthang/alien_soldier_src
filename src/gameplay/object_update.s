Sys_ProcessObjectList:                                  ; CODE XREF: Sys_StoryScreenMainLoop+4A   p  ; was: sub_2016
                                        ; UI_UpdateOptionsScreen+68   p
                tst.b   (byte_FFF744).w
                bne.w   Sys_ProcessObjectList_Begin
                bsr.w   Sys_InitObjectPointers
Sys_ProcessObjectList_Begin:                            ; CODE XREF: Sys_ProcessObjectList+4   j  ; was: loc_2022
                move.b  (byte_FF813E).w,d3
                ror.l   #8,d3
                move.b  (byte_FFBE00).w,d4
                movea.w (word_FFBE02).w,a3
                lea     (word_FFA400).w,a5
                bsr.w   Sprite_ProcessDMAQueue
                move.w  (word_FFF75A).w,d2
                beq.w   Sys_ProcessObjectList_Finalize
                subq.w  #1,d2
                lea     (word_FFED00).w,a2
Sys_ProcessObjectList_ObjectLoop:                       ; CODE XREF: Sys_ProcessObjectList:Sys_ProcessObjectList_NextObject   j  ; was: loc_2046
                movea.w (a2)+,a5
                move.b  2(a5),d7
                bpl.s   Sys_ProcessObjectList_HandleAlternateFlags
                add.b   d7,d7
                bpl.w   Sprite_CullOffscreen
                movea.l 8(a5),a4
                add.b   d7,d7
                bpl.s   Sys_ProcessObjectList_PrepareOam
                bsr.w   Anim_UpdateFrame
Sys_ProcessObjectList_PrepareOam:                       ; CODE XREF: Sys_ProcessObjectList+44   j  ; was: loc_2060
                swap    d2
                bsr.w   Sprite_PrepareOAM
                swap    d2
Sys_ProcessObjectList_NextObject:                       ; CODE XREF: Sys_ProcessObjectList:Sys_ProcessObjectList_HandleAlternateFlags   j  ; was: loc_2068
                                        ; Sys_ProcessObjectList+66   j
                dbf     d2,Sys_ProcessObjectList_ObjectLoop
Sys_ProcessObjectList_Finalize:                         ; CODE XREF: Sys_ProcessObjectList+26   j  ; was: loc_206C
                move.b  d4,(byte_FFBE00).w
                move.w  a3,(word_FFBE02).w
                bra.w   Sys_UpdateObjectList
; ---------------------------------------------------------------------------
Sys_ProcessObjectList_HandleAlternateFlags:             ; CODE XREF: Sys_ProcessObjectList+36   j  ; was: loc_2078
                beq.s   Sys_ProcessObjectList_NextObject
                add.b   d7,d7
                bpl.s   Sys_ProcessObjectList_NextObject
                add.b   d7,d7
                bpl.s   Sys_ProcessObjectList_NextObject
                movea.l 8(a5),a4
                pea     Sys_ProcessObjectList_NextObject(pc)
                bra.w   Anim_UpdateFrame
; End of function Sys_ProcessObjectList
; Processes sprite DMA queue for batch transfers
Sprite_ProcessDMAQueue:                                 ; CODE XREF: Sys_ProcessObjectList+1E   p  ; was: sub_208E
                move.w  2(a5),d7
                bmi.w   Sprite_ProcessDMAQueue_ProcessActive
                beq.s   Sprite_ProcessDMAQueue_Return
                movea.l 8(a5),a4
                bra.w   Sprite_GetAnimPointer
; ---------------------------------------------------------------------------
Sprite_ProcessDMAQueue_ProcessActive:                   ; CODE XREF: Sprite_ProcessDMAQueue+4   j  ; was: loc_20A0
                move.l  8(a5),d0
                beq.w   Sprite_ProcessDMAQueue_Return
                movea.l d0,a4
                bsr.w   Sprite_GetAnimPointer
                btst    #5,d7
                bne.w   Sprite_PrepareOAM
                lea     $E0(a5),a2
                cmpa.l  $DC(a5),a4
                beq.w   Sprite_CalculatePosition
                move.l  a4,$DC(a5)
                bsr.w   Sprite_CalculatePosition
                lea     $E0(a5),a4
                cmpa.w  a4,a2
                beq.w   Sprite_ProcessDMAQueue_Return
                movea.w (word_FFF70C).w,a0
                move.w  $DA(a5),d0
Sprite_ProcessDMAQueue_TransferLoop:                    ; CODE XREF: Sprite_ProcessDMAQueue+58   j  ; was: loc_20DC
                movea.l (a4)+,a1
                jsr     (Gfx_SetupDMATransfer).l
                cmpa.w  a4,a2
                bhi.s   Sprite_ProcessDMAQueue_TransferLoop
                move.w  a0,(word_FFF70C).w
Sprite_ProcessDMAQueue_Return:                          ; CODE XREF: Sprite_ProcessDMAQueue+8   j  ; was: locret_20EC
                                        ; Sprite_ProcessDMAQueue+16   j
                rts
; End of function Sprite_ProcessDMAQueue
; Alternative sprite DMA queue processing with animation
Sprite_ProcessDMAQueueAlt:
                move.b  2(a5),d7                        ; was: sub_20EE
                bmi.w   Sprite_ProcessDMAQueueAlt_ProcessActive
                beq.w   Sprite_ProcessDMAQueueAlt_Return
                add.b   d7,d7
                bpl.w   Sprite_ProcessDMAQueueAlt_Return
                add.b   d7,d7
                bpl.w   Sprite_ProcessDMAQueueAlt_Return
                movea.l 8(a5),a4
                bra.w   Sprite_GetAnimPointer
; ---------------------------------------------------------------------------
Sprite_ProcessDMAQueueAlt_ProcessActive:                ; CODE XREF: Sprite_ProcessDMAQueueAlt+4   j  ; was: loc_210E
                move.l  8(a5),d0
                beq.w   Sprite_ProcessDMAQueueAlt_Return
                movea.l d0,a4
                btst    #5,d7
                beq.w   Sprite_ProcessDMAQueueAlt_UpdateCache
                movea.l 8(a5),a4
                bsr.w   Sprite_GetAnimPointer
Sprite_ProcessDMAQueueAlt_UpdateCache:                  ; CODE XREF: Sprite_ProcessDMAQueueAlt+2E   j  ; was: loc_2128
                lea     $E0(a5),a2
                cmpa.l  $DC(a5),a4
                beq.w   Sprite_CalculatePositionAlt
                move.l  a4,$DC(a5)
                bsr.w   Sprite_CalculatePositionAlt
                lea     $E0(a5),a4
                cmpa.w  a4,a2
                beq.w   Sprite_ProcessDMAQueueAlt_Return
                movea.w (word_FFF70C).w,a0
                move.w  $DA(a5),d0
Sprite_ProcessDMAQueueAlt_TransferLoop:                 ; CODE XREF: Sprite_ProcessDMAQueueAlt+6A   j  ; was: loc_214E
                movea.l (a4)+,a1
                jsr     (Gfx_SetupDMATransfer).l
                cmpa.w  a4,a2
                bhi.s   Sprite_ProcessDMAQueueAlt_TransferLoop
                move.w  a0,(word_FFF70C).w
Sprite_ProcessDMAQueueAlt_Return:                       ; CODE XREF: Sprite_ProcessDMAQueueAlt+8   j  ; was: locret_215E
                                        ; Sprite_ProcessDMAQueueAlt+E   j
                rts
; End of function Sprite_ProcessDMAQueueAlt
; Updates animation frame with timer and pointer management
Anim_UpdateFrame:                                       ; CODE XREF: Sys_ProcessObjectList+46   p  ; was: sub_2160
                                        ; Sys_ProcessObjectList+74   j
                move.w  $C(a5),d0
                tst.b   d0
                bmi.s   Anim_UpdateFrame_ResolveFrame
                beq.s   Anim_UpdateFrame_LoadInitial
                tst.l   d3
                bmi.s   Anim_UpdateFrame_Tick
                subq.w  #1,d0
Anim_UpdateFrame_Tick:                                  ; CODE XREF: Anim_UpdateFrame+C   j  ; was: loc_2170
                bne.s   Anim_UpdateFrame_StoreTimer
                addq.w  #4,a4
                move.w  2(a4),d0
                bne.s   Anim_UpdateFrame_StorePointer
                adda.w  (a4),a4
Anim_UpdateFrame_LoadInitial:                           ; CODE XREF: Anim_UpdateFrame+8   j  ; was: loc_217C
                move.w  2(a4),d0
Anim_UpdateFrame_StorePointer:                          ; CODE XREF: Anim_UpdateFrame+18   j  ; was: loc_2180
                move.l  a4,8(a5)
Anim_UpdateFrame_StoreTimer:                            ; CODE XREF: Anim_UpdateFrame:Anim_UpdateFrame_Tick   j  ; was: loc_2184
                move.w  d0,$C(a5)
Anim_UpdateFrame_ResolveFrame:                          ; CODE XREF: Anim_UpdateFrame+6   j  ; was: loc_2188
                adda.w  (a4),a4
                rts
; End of function Anim_UpdateFrame
; Returns sprite animation data pointer from entity structure
Sprite_GetAnimPointer:                                  ; CODE XREF: Sprite_ProcessDMAQueue+E   j  ; was: sub_218C
                                        ; Sprite_ProcessDMAQueue+1C   p
                movea.l 8(a5),a4
                rts
; End of function Sprite_GetAnimPointer
; Advances animation frame using offset-based timing
Anim_AdvanceFrameOffset:
                move.b  $D(a5),d0                       ; was: sub_2192
                bmi.s   Anim_AdvanceFrameOffset_LoadPaused
                bne.s   Anim_AdvanceFrameOffset_LoadCurrent
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
                move.b  3(a4),d0
                bra.w   Anim_AdvanceFrameOffset_Tick
; ---------------------------------------------------------------------------
Anim_AdvanceFrameOffset_LoadCurrent:                    ; CODE XREF: Anim_AdvanceFrameOffset+6   j  ; was: loc_21AA
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
                tst.b   (byte_FF813E).w
                bmi.s   Anim_AdvanceFrameOffset_ResolveFrame
Anim_AdvanceFrameOffset_Tick:                           ; CODE XREF: Anim_AdvanceFrameOffset+14   j  ; was: loc_21B8
                subq.b  #1,d0
                move.b  d0,$D(a5)
                bne.w   Anim_AdvanceFrameOffset_ResolveFrame
                movea.l a4,a2
                addq.w  #4,a2
                addq.w  #4,d1
Anim_AdvanceFrameOffset_ScanEntries:                    ; CODE XREF: Anim_AdvanceFrameOffset+50   j  ; was: loc_21C8
                move.b  3(a2),d0
                beq.w   Anim_AdvanceFrameOffset_FollowJump
                move.b  d0,$D(a5)
                move.b  d1,$C(a5)
                adda.w  (a4),a4
                rts
; ---------------------------------------------------------------------------
Anim_AdvanceFrameOffset_FollowJump:                     ; CODE XREF: Anim_AdvanceFrameOffset+3A   j  ; was: loc_21DC
                move.w  (a2),d0
                adda.w  d0,a2
                add.w   d0,d1
                bra.s   Anim_AdvanceFrameOffset_ScanEntries
; ---------------------------------------------------------------------------
Anim_AdvanceFrameOffset_LoadPaused:                     ; CODE XREF: Anim_AdvanceFrameOffset+4   j  ; was: loc_21E4
                move.b  $C(a5),d1
                ext.w   d1
                adda.w  d1,a4
Anim_AdvanceFrameOffset_ResolveFrame:                   ; CODE XREF: Anim_AdvanceFrameOffset+24   j  ; was: loc_21EC
                                        ; Anim_AdvanceFrameOffset+2C   j
                adda.w  (a4),a4
                rts
; End of function Anim_AdvanceFrameOffset
