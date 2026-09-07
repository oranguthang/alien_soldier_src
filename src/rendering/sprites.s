Sys_InitObjectPointers:                                 ; CODE XREF: Sys_ProcessObjectList+8   p  ; was: sub_21F0
                                        ; Sys_StoryScreenMainLoop+26   p
                moveq   #$3F,d2                         ; '?'
                lea     (dword_FFBE04).w,a0
                move.l  #$BE0A,d0
loc_21FC:                                               ; CODE XREF: Sys_InitObjectPointers+10   j
                move.l  d0,(a0)+
                addq.w  #4,d0
                dbf     d2,loc_21FC
                move.w  (word_FFF756).w,d0
                bne.w   loc_220E
                moveq   #1,d0
loc_220E:                                               ; CODE XREF: Sys_InitObjectPointers+18   j
                move.b  d0,(byte_FFBE00).w
                asl.w   #3,d0
                addi.w  #-$2000,d0
                move.w  d0,(word_FFBE02).w
                move.b  #1,(byte_FFF744).w
                rts
; End of function Sys_InitObjectPointers
; Updates object list with new entries
Sys_UpdateObjectList:                                   ; CODE XREF: Sys_ProcessObjectList+5E   j  ; was: sub_2224
                move.b  #$50,d0                         ; 'P'
                sub.b   (byte_FFBE00).w,d0
                move.b  d0,(byte_FFBE01).w
                moveq   #$3F,d2                         ; '?'
                movea.w #(dword_FFBE04-M68K_RAM),a0
                move.w  (word_FFF756).w,d0
                bne.w   loc_2240
                moveq   #1,d0
loc_2240:                                               ; CODE XREF: Sys_UpdateObjectList+16   j
                asl.w   #3,d0
                addi.w  #-$2000,d0
                movea.w d0,a1
loc_2248:                                               ; CODE XREF: Sys_UpdateObjectList+30   j
                move.w  (a0)+,d0
                beq.s   loc_2252
                move.b  d0,-5(a1)
                movea.w (a0),a1
loc_2252:                                               ; CODE XREF: Sys_UpdateObjectList+26   j
                addq.w  #2,a0
                dbf     d2,loc_2248
                move.b  #0,-5(a1)
                clr.b   (byte_FFF744).w
                rts
; End of function Sys_UpdateObjectList
; Culls sprites outside visible screen area
Sprite_CullOffscreen:                                   ; CODE XREF: Sys_ProcessObjectList+3A   j  ; was: sub_2264
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   loc_22BE
                move.b  $B(a5),d6
                ext.w   d6
                add.w   $14(a5),d6
                tst.b   3(a5)
                bmi.s   loc_227E
                sub.w   (word_FF8086).w,d6
loc_227E:                                               ; CODE XREF: Sprite_CullOffscreen+14   j
                cmpi.w  #$200,d6
                bcc.s   loc_22BE
                move.b  $A(a5),d5
                ext.w   d5
                add.w   $10(a5),d5
                beq.s   loc_22BE
                cmpi.w  #$220,d5
                bcc.s   loc_22BE
                move.b  $20(a5),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a0
                move.b  d4,-5(a0)
                move.w  d6,(a3)+
                move.w  8(a5),d0
                addq.b  #1,d4
                move.b  d4,d0
                move.w  d0,(a3)+
                move.w  $E(a5),(a3)+
                move.w  d5,(a3)+
                move.w  a3,-$41FA(a1)
loc_22BE:                                               ; CODE XREF: Sprite_CullOffscreen+4   j
                                        ; Sprite_CullOffscreen+1E   j
                bra.w   loc_2068
; End of function Sprite_CullOffscreen
nullsub_11:                                             ; CODE XREF: Sprite_PrepareOAM+24   j
                                        ; Sprite_PrepareOAM+2A   j
                rts
; End of function nullsub_11

; Prepares sprite OAM entry with position and attributes
Sprite_PrepareOAM:                                      ; CODE XREF: Sys_ProcessObjectList+4C   p  ; was: sub_22C4
                                        ; Sprite_ProcessDMAQueue+24   j
                move.w  $E(a5),d7
                move.w  d7,d2
                andi.w  #$F800,d7
                andi.w  #$7FF,d2
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                tst.b   3(a5)
                bmi.s   loc_22E4
                sub.w   (word_FF8086).w,d6
loc_22E4:                                               ; CODE XREF: Sprite_PrepareOAM+1A   j
                cmpi.w  #$200,d6
                bcc.s   nullsub_11
                cmpi.w  #$220,d5
                bcc.s   nullsub_11
                move.b  $20(a5),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a0
                move.b  d4,-5(a0)
                btst    #$B,d7
                bne.s   Sprite_HandleLargeSprites
                lea     loc_2324(pc),a0
                bra.s   loc_233C
; ---------------------------------------------------------------------------
; Branch target for handling large sprites (8+ tiles) by jumping to tile rendering routine
Sprite_HandleLargeSprites:                              ; CODE XREF: Sprite_PrepareOAM+42   j  ; was: loc_230E
                lea     Sprite_RenderTiles(pc),a0
                subq.w  #7,d5
                bra.s   loc_233C
; End of function Sprite_PrepareOAM
; Renders sprite tiles with position calculation
Sprite_RenderTiles:                                     ; DATA XREF: Sprite_PrepareOAM:loc_230E   o  ; was: sub_2316
                neg.w   d0
                move.b  -4(a4),d1
                add.w   d1,d1
                andi.w  #$18,d1
                sub.w   d1,d0
loc_2324:                                               ; DATA XREF: Sprite_PrepareOAM+44   o
                add.w   d5,d0
                bmi.s   loc_232E
                andi.w  #$1FF,d0
                bne.s   loc_2330
loc_232E:                                               ; CODE XREF: Sprite_RenderTiles+10   j
                moveq   #1,d0
loc_2330:                                               ; CODE XREF: Sprite_RenderTiles+16   j
                move.w  d3,d1
                bmi.s   loc_2370
                eor.w   d7,d1
                add.w   d2,d1
                move.w  d1,(a3)+
                move.w  d0,(a3)+
loc_233C:                                               ; CODE XREF: Sprite_PrepareOAM+48   j
                                        ; Sprite_PrepareOAM+50   j
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   locret_2380
                move.w  (a4)+,d3
                move.w  (a4)+,d0
                move.w  d0,d1
                swap    d0
                move.b  (a4)+,d0
                ext.w   d0
                btst    #$C,d7
                beq.s   loc_2360
                neg.w   d0
                lsr.w   #5,d1
                andi.w  #$18,d1
                addq.w  #8,d1
                sub.w   d1,d0
loc_2360:                                               ; CODE XREF: Sprite_RenderTiles+3C   j
                add.w   d6,d0
                addq.b  #1,d4
                swap    d0
                move.b  d4,d0
                move.l  d0,(a3)+
                move.b  (a4)+,d0
                ext.w   d0
                jmp     (a0)
; ---------------------------------------------------------------------------
loc_2370:                                               ; CODE XREF: Sprite_RenderTiles+1C   j
                andi.w  #$7FFF,d1
                eor.w   d7,d1
                add.w   d2,d1
                move.w  d1,(a3)+
                move.w  d0,(a3)+
                move.w  a3,-$41FA(a1)
locret_2380:                                            ; CODE XREF: Sprite_RenderTiles+2A   j
                rts
; End of function Sprite_RenderTiles
nullsub_12:                                             ; CODE XREF: Sprite_CalculatePosition+24   j
                                        ; Sprite_CalculatePosition+2A   j
                rts
; End of function nullsub_12

; Calculates sprite screen position with bounds checking
Sprite_CalculatePosition:                               ; CODE XREF: Sprite_ProcessDMAQueue+30   j  ; was: sub_2384
                                        ; Sprite_ProcessDMAQueue+38   p
                move.w  $E(a5),d7
                move.w  d7,d2
                andi.w  #$F800,d7
                andi.w  #$7FF,d2
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                tst.b   3(a5)
                bmi.s   loc_23A4
                sub.w   (word_FF8086).w,d6
loc_23A4:                                               ; CODE XREF: Sprite_CalculatePosition+1A   j
                cmpi.w  #$200,d6
                bcc.s   nullsub_12
                cmpi.w  #$220,d5
                bcc.s   nullsub_12
                move.b  $20(a5),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a0
                move.b  d4,-5(a0)
                btst    #$B,d7
                bne.s   loc_23CE
                lea     loc_2428(pc),a0
                bra.s   loc_23D4
; ---------------------------------------------------------------------------
loc_23CE:                                               ; CODE XREF: Sprite_CalculatePosition+42   j
                lea     loc_241A(pc),a0
                subq.w  #8,d5
loc_23D4:                                               ; CODE XREF: Sprite_CalculatePosition+48   j
                                        ; Sprite_CalculatePosition+B4   j
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   locret_243E
                move.w  (a4)+,d3
                move.l  (a4)+,d0
                move.l  d0,(a2)+
                swap    d0
                move.b  d4,d0
                move.w  d0,d4
                move.b  (a4)+,d0
                ext.w   d0
                btst    #$C,d7
                beq.s   loc_2400
                neg.w   d0
                move.w  d4,d1
                lsr.w   #5,d1
                andi.w  #$18,d1
                addi.w  #9,d1
                sub.w   d1,d0
loc_2400:                                               ; CODE XREF: Sprite_CalculatePosition+6A   j
                add.w   d6,d0
                move.w  d0,(a3)+
                addq.b  #1,d4
                move.w  d4,(a3)+
                move.w  d3,d0
                andi.w  #$1FFF,d0
                eor.w   d7,d0
                add.w   d2,d0
                move.w  d0,(a3)+
                move.b  (a4)+,d0
                ext.w   d0
                jmp     (a0)
; ---------------------------------------------------------------------------
loc_241A:                                               ; DATA XREF: Sprite_CalculatePosition:loc_23CE   o
                neg.w   d0
                move.b  -6(a4),d1
                add.w   d1,d1
                andi.w  #$18,d1
                sub.w   d1,d0
loc_2428:                                               ; DATA XREF: Sprite_CalculatePosition+44   o
                add.w   d5,d0
                bmi.s   loc_2432
                andi.w  #$1FF,d0
                bne.s   loc_2434
loc_2432:                                               ; CODE XREF: Sprite_CalculatePosition+A6   j
                moveq   #1,d0
loc_2434:                                               ; CODE XREF: Sprite_CalculatePosition+AC   j
                move.w  d0,(a3)+
                add.w   d3,d3
                bcc.s   loc_23D4
                move.w  a3,-$41FA(a1)
locret_243E:                                            ; CODE XREF: Sprite_CalculatePosition+54   j
                rts
; End of function Sprite_CalculatePosition
nullsub_13:                                             ; CODE XREF: Sprite_CalculatePositionAlt+24   j
                                        ; Sprite_CalculatePositionAlt+2A   j
                rts
; End of function nullsub_13

; Alternative sprite position calculation with OAM building
Sprite_CalculatePositionAlt:                            ; CODE XREF: Sprite_ProcessDMAQueueAlt+42   j  ; was: sub_2442
                                        ; Sprite_ProcessDMAQueueAlt+4A   p
                move.w  $E(a5),d7
                move.w  d7,d2
                andi.w  #$F800,d7
                andi.w  #$7FF,d2
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                tst.b   3(a5)
                bmi.s   loc_2462
                sub.w   (word_FF8086).w,d6
loc_2462:                                               ; CODE XREF: Sprite_CalculatePositionAlt+1A   j
                cmpi.w  #$200,d6
                bcc.s   nullsub_13
                cmpi.w  #$220,d5
                bcc.s   nullsub_13
                move.b  $20(a5),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a0
                move.b  d4,-5(a0)
                btst    #$B,d7
                bne.s   loc_248C
                lea     loc_24E8(pc),a0
                bra.s   loc_2494
; ---------------------------------------------------------------------------
loc_248C:                                               ; CODE XREF: Sprite_CalculatePositionAlt+42   j
                lea     loc_24DA(pc),a0
                subi.w  #9,d5
loc_2494:                                               ; CODE XREF: Sprite_CalculatePositionAlt+48   j
                                        ; Sprite_CalculatePositionAlt+B6   j
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   locret_24FE
                move.w  (a4)+,d3
                move.l  (a4)+,d0
                move.l  d0,(a2)+
                swap    d0
                move.b  d4,d0
                move.w  d0,d4
                move.b  (a4)+,d0
                ext.w   d0
                btst    #$C,d7
                beq.s   loc_24C0
                neg.w   d0
                move.w  d4,d1
                lsr.w   #5,d1
                andi.w  #$18,d1
                addi.w  #9,d1
                sub.w   d1,d0
loc_24C0:                                               ; CODE XREF: Sprite_CalculatePositionAlt+6C   j
                add.w   d6,d0
                move.w  d0,(a3)+
                addq.b  #1,d4
                move.w  d4,(a3)+
                move.w  d3,d0
                andi.w  #$7FFF,d0
                eor.w   d7,d0
                add.w   d2,d0
                move.w  d0,(a3)+
                move.b  (a4)+,d0
                ext.w   d0
                jmp     (a0)
; ---------------------------------------------------------------------------
loc_24DA:                                               ; DATA XREF: Sprite_CalculatePositionAlt:loc_248C   o
                neg.w   d0
                move.b  -6(a4),d1
                add.w   d1,d1
                andi.w  #$18,d1
                sub.w   d1,d0
loc_24E8:                                               ; DATA XREF: Sprite_CalculatePositionAlt+44   o
                add.w   d5,d0
                bmi.s   loc_24F2
                andi.w  #$1FF,d0
                bne.s   loc_24F4
loc_24F2:                                               ; CODE XREF: Sprite_CalculatePositionAlt+A8   j
                moveq   #1,d0
loc_24F4:                                               ; CODE XREF: Sprite_CalculatePositionAlt+AE   j
                move.w  d0,(a3)+
                add.w   d3,d3
                bcc.s   loc_2494
                move.w  a3,-$41FA(a1)
locret_24FE:                                            ; CODE XREF: Sprite_CalculatePositionAlt+56   j
                rts
; End of function Sprite_CalculatePositionAlt
; Selects animation frame with horizontal flip attribute
Anim_SelectFrameWithFlip:
                move.b  9(a5),d0                        ; was: sub_2500
                beq.w   loc_2518
                addq.b  #1,d0
                beq.w   locret_2516
                subq.b  #1,9(a5)
                beq.w   loc_2526
locret_2516:                                            ; CODE XREF: Anim_SelectFrameWithFlip+A   j
                rts
; ---------------------------------------------------------------------------
loc_2518:                                               ; CODE XREF: Anim_SelectFrameWithFlip+4   j
                move.w  $C(a5),d0
                bra.w   loc_252C
; ---------------------------------------------------------------------------
loc_2520:                                               ; CODE XREF: Anim_SelectFrameWithFlip+30   j
                move.w  d1,d0
                bra.w   loc_252C
; ---------------------------------------------------------------------------
loc_2526:                                               ; CODE XREF: Anim_SelectFrameWithFlip+12   j
                move.w  $C(a5),d0
                addq.w  #6,d0
loc_252C:                                               ; CODE XREF: Anim_SelectFrameWithFlip+1C   j
                                        ; Anim_SelectFrameWithFlip+22   j
                move.l  (a0,d0.w),d1
                bmi.s   loc_2520
                move.l  d1,8(a5)
                move.w  4(a0,d0.w),d1
                andi.w  #$8000,$E(a5)
                eor.w   d1,$E(a5)
                move.w  d0,$C(a5)
                rts
; End of function Anim_SelectFrameWithFlip
; Selects animation frame without modifying flip attributes
Anim_SelectFrame:
                move.b  9(a5),d0                        ; was: sub_254A
                beq.w   loc_2562
                addq.b  #1,d0
                beq.w   locret_2560
                subq.b  #1,9(a5)
                beq.w   loc_2570
locret_2560:                                            ; CODE XREF: Anim_SelectFrame+A   j
                rts
; ---------------------------------------------------------------------------
loc_2562:                                               ; CODE XREF: Anim_SelectFrame+4   j
                move.w  $C(a5),d0
                bra.w   loc_2576
; ---------------------------------------------------------------------------
loc_256A:                                               ; CODE XREF: Anim_SelectFrame+30   j
                move.w  d1,d0
                bra.w   loc_2576
; ---------------------------------------------------------------------------
loc_2570:                                               ; CODE XREF: Anim_SelectFrame+12   j
                move.w  $C(a5),d0
                addq.w  #6,d0
loc_2576:                                               ; CODE XREF: Anim_SelectFrame+1C   j
                                        ; Anim_SelectFrame+22   j
                move.l  (a0,d0.w),d1
                bmi.s   loc_256A
                move.l  d1,8(a5)
                move.w  4(a0,d0.w),$E(a5)
                move.w  d0,$C(a5)
                rts
; End of function Anim_SelectFrame
; Adds sprite entries to OAM buffer with priority
Sprite_AddToOAMBuffer:                                  ; CODE XREF: Cutscene_PlanetScroll+6C   j  ; was: sub_258C
                                        ; Cutscene_RenderSpriteGrid+7C   j
                movea.l a0,a4
                move.b  (byte_FFBE00).w,d4
                movea.w (word_FFBE02).w,a3
                beq.w   locret_25CC
loc_259A:                                               ; CODE XREF: Sprite_AddToOAMBuffer+34   j
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   loc_25C2
                move.l  (a0)+,(a3)+
                move.b  -(a3),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a2
                move.b  d4,-5(a2)
                addq.b  #1,d4
                move.b  d4,(a3)+
                move.l  (a0)+,(a3)+
                move.w  a3,-$41FA(a1)
                cmpi.w  #$FFFF,(a0)
                bne.s   loc_259A
loc_25C2:                                               ; CODE XREF: Sprite_AddToOAMBuffer+12   j
                move.w  a3,(word_FFBE02).w
                move.b  d4,(byte_FFBE00).w
                movea.l a4,a0
locret_25CC:                                            ; CODE XREF: Sprite_AddToOAMBuffer+A   j
                rts
; End of function Sprite_AddToOAMBuffer
; Adds sprites to OAM buffer with scroll offset applied
Sprite_AddToOAMWithScroll:
                movea.l a0,a4                           ; was: sub_25CE
                move.b  (byte_FFBE00).w,d4
                movea.w (word_FFBE02).w,a3
loc_25D8:                                               ; CODE XREF: Sprite_AddToOAMWithScroll+62   j
                cmpi.b  #$50,d4                         ; 'P'
                bge.s   loc_2632
                move.b  3(a0),d0
                andi.w  #$FC,d0
                movea.w d0,a1
                movea.w -$41FA(a1),a2
                move.b  d4,-5(a2)
                move.w  (a0),d6
                sub.w   (word_FF8086).w,d6
                cmpi.w  #$200,d6
                bcs.s   loc_25FE
                clr.w   d6
loc_25FE:                                               ; CODE XREF: Sprite_AddToOAMWithScroll+2C   j
                move.w  d6,(a3)+
                move.w  2(a0),d0
                addq.b  #1,d4
                move.b  d4,d0
                move.w  d0,(a3)+
                move.w  4(a0),(a3)+
                move.w  6(a0),d5
                cmpi.w  #$220,d5
                bcs.s   loc_261C
                clr.w   -6(a3)
loc_261C:                                               ; CODE XREF: Sprite_AddToOAMWithScroll+48   j
                andi.w  #$1FF,d5
                bne.s   loc_2624
                addq.w  #1,d5
loc_2624:                                               ; CODE XREF: Sprite_AddToOAMWithScroll+52   j
                move.w  d5,(a3)+
                move.w  a3,-$41FA(a1)
                addq.w  #8,a0
                cmpi.w  #$FFFF,(a0)
                bne.s   loc_25D8
loc_2632:                                               ; CODE XREF: Sprite_AddToOAMWithScroll+E   j
                move.w  a3,(word_FFBE02).w
                move.b  d4,(byte_FFBE00).w
                movea.l a4,a0
                rts
; End of function Sprite_AddToOAMWithScroll
