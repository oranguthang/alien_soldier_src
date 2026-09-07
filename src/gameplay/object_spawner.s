Sys_UpdateObjectSpawner:                                ; CODE XREF: Sys_GameplayMainLoop:loc_1C732   p  ; was: sub_1A280
                                        ; Stage_UpdateGameplay+C   p
                tst.b   (byte_FF813E).w
                bpl.w   loc_1A28A
                rts
; ---------------------------------------------------------------------------
loc_1A28A:                                              ; CODE XREF: Sys_UpdateObjectSpawner+4   j
                move.w  (word_FF808C).w,d0
                bmi.w   loc_1A296
                subq.w  #1,(word_FF808C).w
loc_1A296:                                              ; CODE XREF: Sys_UpdateObjectSpawner+E   j
                jsr     Sys_ProcessSpawnList(pc)        ; (pc)
                nop
; End of function Sys_UpdateObjectSpawner
; Processes all objects with screen bounds culling
Sys_ProcessVisibleObjects:                              ; CODE XREF: Sys_StoryScreenMainLoop+32   p  ; was: sub_1A29C
                                        ; UI_UpdateOptionsScreen+58   p
                lea     (Entity_ObjectPool).w,a5
loc_1A2A0:                                              ; CODE XREF: Sys_ProcessVisibleObjects+5A   j
                move.w  (a5),d0
                beq.s   Sys_AdvanceObjectPointer
                cmpi.w  #$10,d0
                beq.s   loc_1A2B2
                movea.w d0,a0
                movea.l off_5DC(a0),a0
                jsr     (a0)
loc_1A2B2:                                              ; CODE XREF: Sys_ProcessVisibleObjects+C   j
                btst    #4,2(a5)
                bne.s   loc_1A2DE
                btst    #1,2(a5)
                beq.s   loc_1A2E4
                move.w  $10(a5),d0
                subi.w  #$60,d0                         ; '`'
                cmpi.w  #$180,d0
                bhi.s   loc_1A2DE
                move.w  $14(a5),d0
                subi.w  #$40,d0                         ; '@'
                cmpi.w  #$130,d0
                bls.s   loc_1A2E4
loc_1A2DE:                                              ; CODE XREF: Sys_ProcessVisibleObjects+1C   j
                                        ; Sys_ProcessVisibleObjects+32   j
                bsr.w   Sys_ClearObjectSlot
                bra.s   Sys_AdvanceObjectPointer
; ---------------------------------------------------------------------------
loc_1A2E4:                                              ; CODE XREF: Sys_ProcessVisibleObjects+24   j
                                        ; Sys_ProcessVisibleObjects+40   j
                movea.w (word_FFF758).w,a0
                move.w  a5,(a0)+
                move.w  a0,(word_FFF758).w
; Advances object array pointer to next slot in processing loop
Sys_AdvanceObjectPointer:                               ; CODE XREF: Sys_ProcessVisibleObjects+6   j  ; was: loc_1A2EE
                                        ; Sys_ProcessVisibleObjects+46   j
                lea     $60(a5),a5
                cmpa.w  #$DCA0,a5
                bcs.s   loc_1A2A0
                rts
; End of function Sys_ProcessVisibleObjects
; Processes object spawn list based on scroll
Sys_ProcessSpawnList:                                   ; CODE XREF: Sys_UpdateObjectSpawner:loc_1A296   p  ; was: sub_1A2FA
                                        ; DATA XREF: Sys_UpdateObjectSpawner:loc_1A296   o
                move.l  (dword_FFA20E).w,d0
                bmi.s   locret_1A322
                tst.w   (dword_FFA910).w
                bmi.s   locret_1A322
                movea.l d0,a4
loc_1A308:                                              ; CODE XREF: Sys_ProcessSpawnList+22   j
                move.w  (dword_FFA900).w,d7
                addi.w  #$140,d7
                cmp.w   (a4),d7
                blt.s   loc_1A31E
                bsr.w   Sys_SpawnObject
                lea     $C(a4),a4
                bra.s   loc_1A308
; ---------------------------------------------------------------------------
loc_1A31E:                                              ; CODE XREF: Sys_ProcessSpawnList+18   j
                move.l  a4,(dword_FFA20E).w
locret_1A322:                                           ; CODE XREF: Sys_ProcessSpawnList+4   j
                                        ; Sys_ProcessSpawnList+A   j
                rts
; End of function Sys_ProcessSpawnList
; Spawns object from spawn table entry
Sys_SpawnObject:                                        ; CODE XREF: Sys_ProcessSpawnList+1A   p  ; was: sub_1A324
                movea.w 8(a4),a5
                movea.w $A(a4),a0
                bsr.w   Sys_FindSlotInRange
                beq.s   loc_1A33C
                movea.w 8(a4),a5
                bsr.w   Gfx_LoadDestroyerMK2Palette
                beq.s   locret_1A388
loc_1A33C:                                              ; CODE XREF: Sys_SpawnObject+C   j
                bsr.w   Sys_ClearObjectSlot
                move.w  4(a4),d0
                bclr    #0,d0
                beq.s   loc_1A352
                tst.w   (word_FFFF0E).w
                bne.s   loc_1A35E
locret_1A350:                                           ; CODE XREF: Sys_SpawnObject+38   j
                rts
; ---------------------------------------------------------------------------
loc_1A352:                                              ; CODE XREF: Sys_SpawnObject+24   j
                bclr    #1,d0
                beq.s   loc_1A35E
                tst.w   (word_FFFF0E).w
                bne.s   locret_1A350
loc_1A35E:                                              ; CODE XREF: Sys_SpawnObject+2A   j
                                        ; Sys_SpawnObject+32   j
                move.w  d0,(a5)
                move.w  6(a4),$5E(a5)
                move.w  (a4),d0
                sub.w   (dword_FFA900).w,d0
                addi.w  #$80,d0
                move.w  d0,$10(a5)
                clr.w   $12(a5)
                move.w  2(a4),d1
                add.w   (dword_FFA904).w,d1
                move.w  d1,$14(a5)
                clr.w   $16(a5)
locret_1A388:                                           ; CODE XREF: Sys_SpawnObject+16   j
                rts
; End of function Sys_SpawnObject
; Finds free slot in object array range
Sys_FindSlotInRange:                                    ; CODE XREF: Sys_SpawnObject+8   p  ; was: sub_1A38A
                                        ; Sys_FindSlotInRange+A   j
                tst.w   (a5)
                beq.s   locret_1A39A
                lea     $60(a5),a5
                cmpa.l  a0,a5
                bcs.s   Sys_FindSlotInRange
                andi    #$FB,ccr
locret_1A39A:                                           ; CODE XREF: Sys_FindSlotInRange+2   j
                rts
; End of function Sys_FindSlotInRange
; Loads Destroyer-MK2 palette
Gfx_LoadDestroyerMK2Palette:                            ; CODE XREF: Sys_SpawnObject+12   p  ; was: sub_1A39C
                                        ; Gfx_LoadDestroyerMK2Palette+E   j
                btst    #6,3(a5)
                bne.s   locret_1A3AE
                lea     $60(a5),a5
                cmpa.l  a0,a5
                bcs.s   Gfx_LoadDestroyerMK2Palette
                moveq   #0,d0
locret_1A3AE:                                           ; CODE XREF: Gfx_LoadDestroyerMK2Palette+6   j
                rts
; End of function Gfx_LoadDestroyerMK2Palette
; Clears 96 bytes of object RAM
Sys_ClearObjectSlot:                                    ; CODE XREF: Sys_ProcessProjectiles:loc_199D6   p  ; was: sub_1A3B0
                                        ; sub_1A29C:loc_1A2DE   p
                movea.l a5,a0
; Clears 96-byte object memory block (24 long-words) to zero
Sys_Clear96ByteBlock:                                   ; CODE XREF: Sprite_ClearInactiveObjects+22   p  ; was: loc_1A3B2
                                        ; sub_2C3F8:loc_2C40E   p
                moveq   #0,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                rts
; End of function Sys_ClearObjectSlot
; ---------------------------------------------------------------------------
word_1A3E6:     dc.w    $7FFF                           ; DATA XREF: ROM:stru_12910   o
                                        ; ROM:stru_1296A   o
                                        ; UNUSED: Intro cutscene sprite graphics
                                        ; See stru_12910 for complete structure (line 23283)
word_1A3E8:     dc.w    $1A0, $130, $1C, $10, $C680, $CF80
                                        ; DATA XREF: ROM:stru_127A8   o
                dc.w    $200, $130, $1D, $11, $C680, $CF80
                dc.w    $280, $D0, $1C, $15, $C680, $CF80
                dc.w    $2C0, $130, $1D, $18, $C680, $CF80
                dc.w    $300, $110, $44, 4, $C680, $CF80
                dc.w    $340, $130, $1C, $10, $C680, $CF80
                dc.w    $3A0, $130, $1D, $10, $C680, $CF80
                dc.w    $400, $130, $8C, 0, $C680, $CF80
                dc.w    $410, $EC, $24C, 0, $C680, $CF80
                dc.w    $440, $D0, $44, 0, $C680, $CF80
                dc.w    $470, $130, $1E0, 0, $C680, $CF80
                dc.w    $4A0, $D0, $1C, 0, $C680, $CF80
                dc.w    $633, $130, $44, 0, $C680, $CF80
                dc.w    $658, $C4, $24C, 0, $C680, $CF80
                dc.w    $6C0, $14C, $48, 0, $C680, $CF80
                dc.w    $6F0, $14C, $49, 0, $C680, $CF80
                dc.w    $720, $14C, $48, 0, $C680, $CF80
                dc.w    $750, $14C, $49, 0, $C680, $CF80
                dc.w    $780, $130, $1D, 0, $C680, $CF80
                dc.w    $7C0, $110, $1E0, 0, $C680, $CF80
word_1A4D8:     binclude "data/other/word_1A4D8.bin"
word_1A4D8_End:
word_1A6B8:     dc.w    $D10, $130, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_127E4   o
                dc.w    $D30, $130, $1C, 0, $C680, $CF80
                dc.w    $D40, $130, $28C, 0, $C680, $CF80
                dc.w    $D80, $130, $1D, $11, $C680, $CF80
                dc.w    $E20, $C0, $FC, 8, $C680, $CF80
                dc.w    $ED0, $C0, $100, $A, $C680, $CF80
                dc.w    $F60, $C0, $FC, $C, $C680, $CF80
                dc.w    $FC0, $E4, $24C, 0, $C680, $CF80
                dc.w    $1010, $C0, $100, $E, $C680, $CF80
                dc.w    $10D0, $130, $1C, 0, $C680, $CF80
                dc.w    $110A, $AC, $22, 0, $C680, $CF80
                dc.w    $11E0, $130, $1C, 0, $C680, $CF80
                dc.w    $1240, $130, $1C, 0, $C680, $CF80
word_1A754:     binclude "data/other/word_1A754.bin"
word_1A754_End:
word_1A882:     binclude "data/other/word_1A882.bin"
word_1A882_End:
word_1A9B0:     dc.w    $4D4, $108, $12C, 8, $DB20, $DCA0
                                        ; DATA XREF: ROM:stru_1283E   o
                dc.w    $550, $108, $12C, $18, $DB20, $DCA0
                dc.w    $5B8, $108, $12C, $10, $DB20, $DCA0
word_1A9D4:     binclude "data/other/word_1A9D4.bin"
word_1A9D4_End:
word_1AB24:     dc.w    $C10, $130, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1285C   o
                dc.w    $C30, $130, $1D, $11, $C680, $CF80
                dc.w    $C50, $130, $1C, 0, $C680, $CF80
                dc.w    $C80, $110, $8C, 0, $C680, $CF80
                dc.w    $D40, $110, $3B4, $500, $C680, $CF80
                dc.w    $DC0, $110, $3B4, $402, $C680, $CF80
                dc.w    $E40, $C0, $3B4, $304, $C680, $CF80
                dc.w    $EC0, $140, $3B4, $206, $C680, $CF80
                dc.w    $EE0, $B0, $24C, 0, $C680, $CF80
                dc.w    $F00, $F0, $3B4, $402, $C680, $CF80
                dc.w    $FA0, $130, $3B4, $506, $C680, $CF80
                dc.w    $1070, $130, $8C, 0, $C680, $CF80
                dc.w    $10E2, $118, $12C, $8020, $DB20, $DCA0
                dc.w    $7FFF
word_1ABC2:     dc.w    $980, $120, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1287A   o
                dc.w    $A20, $120, $1D, $11, $C680, $CF80
                dc.w    $AC0, $120, $1C, 0, $C680, $CF80
                dc.w    $B40, $120, $1C, 0, $C680, $CF80
                dc.w    $BC0, $120, $1C, 0, $C680, $CF80
                dc.w    $C40, $120, $1C, 0, $C680, $CF80
                dc.w    $C58, $120, $24C, 0, $C680, $CF80
                dc.w    $CC0, $120, $1C, 0, $C680, $CF80
                dc.w    $D40, $120, $1C, 0, $C680, $CF80
                dc.w    $DC0, $120, $1C, 0, $C680, $CF80
                dc.w    $E40, $120, $1C, 0, $C680, $CF80
                dc.w    $EC0, $120, $1C, 0, $C680, $CF80
                dc.w    $F40, $120, $1C, 0, $C680, $CF80
                dc.w    $7FFF
word_1AC60:     dc.w    $7FFF                           ; DATA XREF: ROM:stru_12898   o
word_1AC62:     binclude "data/other/word_1AC62.bin"
word_1AC62_End:
word_1AD8E:     binclude "data/other/word_1AD8E.bin"
word_1AD8E_End:
word_1AE96:     binclude "data/other/word_1AE96.bin"    ; UNUSED: Unknown graphics (314 bytes)
                                        ; See stru_128F2 for structure (line 23266)
word_1AE96_End:
word_1AFD0:     dc.w    $160, $1FD8, $20, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1292E   o
                dc.w    $1E0, $2028, $24C, 0, $C680, $CF80
                dc.w    $200, $2010, $1C, 0, $C680, $CF80
                dc.w    $2C0, $2010, $1C, 0, $C680, $CF80
                dc.w    $380, $2010, $1C, 0, $C680, $CF80
word_1B00C:     dc.w    $720, $2000, $380, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1294C   o
                dc.w    $720, $2000, $39C, 0, $C680, $CF80
                dc.w    $740, $2028, $24C, 0, $C680, $CF80
                dc.w    $764, $2028, $20, 0, $C680, $CF80
                dc.w    $7FFF
word_1B03E:     binclude "data/other/word_1B03E.bin"
word_1B03E_End:
word_1B2BA:     binclude "data/other/word_1B2BA.bin"
word_1B2BA_End:
word_1B3F4:     dc.w    $7FFF                           ; DATA XREF: ROM:stru_12AB4   o
word_1B3F6:     dc.w    $270, $2D0, $20, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_12B2C   o
                dc.w    $7FFF

; Looks up cosine value from trigonometry table
