Results_UpdateNumbers:                                  ; CODE XREF: Results_UpdateTimeDisplay+18   j  ; was: sub_4386
                                        ; Results_DisplayStageNumber+10   p
                movea.w (VDPStagingDataCursor).w,a0
                moveq   #0,d5
                move.l  d0,(dword_FF8040).w
                move.w  d7,d2
                subq.w  #1,d2
                beq.w   loc_4484
                subq.w  #1,d2
                beq.w   loc_4466
                subq.w  #1,d2
                beq.w   loc_444A
                subq.w  #1,d2
                beq.w   loc_442C
                subq.w  #1,d2
                beq.w   loc_4410
                subq.w  #1,d2
                beq.w   loc_43F2
                subq.w  #1,d2
                beq.w   loc_43D6
                move.b  (dword_FF8040).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_43CE
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_43D6
; ---------------------------------------------------------------------------
loc_43CE:                                               ; CODE XREF: Results_UpdateNumbers+40   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_43D6:                                               ; CODE XREF: Results_UpdateNumbers+32   j
                                        ; Results_UpdateNumbers+46   j
                move.b  (dword_FF8040).w,d2
                andi.w  #$F,d2
                bne.s   loc_43EA
                tst.w   d5
                bne.s   loc_43EA
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_43F2
; ---------------------------------------------------------------------------
loc_43EA:                                               ; CODE XREF: Results_UpdateNumbers+58   j
                                        ; Results_UpdateNumbers+5C   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_43F2:                                               ; CODE XREF: Results_UpdateNumbers+2C   j
                                        ; Results_UpdateNumbers+62   j
                move.b  (dword_FF8040+1).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_4408
                tst.w   d5
                bne.s   loc_4408
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4410
; ---------------------------------------------------------------------------
loc_4408:                                               ; CODE XREF: Results_UpdateNumbers+76   j
                                        ; Results_UpdateNumbers+7A   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4410:                                               ; CODE XREF: Results_UpdateNumbers+26   j
                                        ; Results_UpdateNumbers+80   j
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$F,d2
                bne.s   loc_4424
                tst.w   d5
                bne.s   loc_4424
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_442C
; ---------------------------------------------------------------------------
loc_4424:                                               ; CODE XREF: Results_UpdateNumbers+92   j
                                        ; Results_UpdateNumbers+96   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_442C:                                               ; CODE XREF: Results_UpdateNumbers+20   j
                                        ; Results_UpdateNumbers+9C   j
                move.b  (dword_FF8040+2).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_4442
                tst.w   d5
                bne.s   loc_4442
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_444A
; ---------------------------------------------------------------------------
loc_4442:                                               ; CODE XREF: Results_UpdateNumbers+B0   j
                                        ; Results_UpdateNumbers+B4   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_444A:                                               ; CODE XREF: Results_UpdateNumbers+1A   j
                                        ; Results_UpdateNumbers+BA   j
                move.b  (dword_FF8040+2).w,d2
                andi.w  #$F,d2
                bne.s   loc_445E
                tst.w   d5
                bne.s   loc_445E
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4466
; ---------------------------------------------------------------------------
loc_445E:                                               ; CODE XREF: Results_UpdateNumbers+CC   j
                                        ; Results_UpdateNumbers+D0   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4466:                                               ; CODE XREF: Results_UpdateNumbers+14   j
                                        ; Results_UpdateNumbers+D6   j
                move.b  (dword_FF8040+3).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                bne.s   loc_447C
                tst.w   d5
                bne.s   loc_447C
                subq.w  #1,d7
                addq.w  #2,d4
                bra.s   loc_4484
; ---------------------------------------------------------------------------
loc_447C:                                               ; CODE XREF: Results_UpdateNumbers+EA   j
                                        ; Results_UpdateNumbers+EE   j
                moveq   #1,d5
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
loc_4484:                                               ; CODE XREF: Results_UpdateNumbers+E   j
                                        ; Results_UpdateNumbers+F4   j
                move.b  (dword_FF8040+3).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                movea.w (VDPStagingDataCursor).w,a0
                movea.w a0,a1
                move.w  d7,d2
                asl.w   #1,d2
                adda.w  d2,a1
                move.w  d7,d2
                subq.w  #1,d2
loc_44A2:                                               ; CODE XREF: Results_UpdateNumbers+122   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d2,loc_44A2
                move.w  d7,d3
                bsr.w   Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d7,d3
                bra.w   Gfx_BuildVDPCommandList
; End of function Results_UpdateNumbers
; Converts 32-bit number to individual digit tiles for display
UI_ConvertNumberToDigits:
                movea.w (VDPStagingDataCursor).w,a0     ; was: sub_44BC
                movea.w (VDPStagingDataCursor).w,a1
                move.w  d7,d2
                asl.w   #1,d2
                adda.w  d2,a1
                move.l  d0,(dword_FF8040).w
                move.w  d7,d2
                subq.w  #1,d2
                beq.w   loc_4576
                subq.w  #1,d2
                beq.w   loc_4562
                subq.w  #1,d2
                beq.s   loc_4550
                subq.w  #1,d2
                beq.s   loc_453C
                subq.w  #1,d2
                beq.s   loc_452A
                subq.w  #1,d2
                beq.s   loc_4516
                subq.w  #1,d2
                beq.s   loc_4504
                move.b  (dword_FF8040).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4504:                                               ; CODE XREF: UI_ConvertNumberToDigits+32   j
                move.b  (dword_FF8040).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4516:                                               ; CODE XREF: UI_ConvertNumberToDigits+2E   j
                move.b  (dword_FF8040+1).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_452A:                                               ; CODE XREF: UI_ConvertNumberToDigits+2A   j
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_453C:                                               ; CODE XREF: UI_ConvertNumberToDigits+26   j
                move.b  (dword_FF8040+2).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4550:                                               ; CODE XREF: UI_ConvertNumberToDigits+22   j
                move.b  (dword_FF8040+2).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4562:                                               ; CODE XREF: UI_ConvertNumberToDigits+1C   j
                move.b  (dword_FF8040+3).w,d2
                asr.b   #4,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
loc_4576:                                               ; CODE XREF: UI_ConvertNumberToDigits+16   j
                move.b  (dword_FF8040+3).w,d2
                andi.w  #$F,d2
                asl.w   #1,d2
                add.w   d1,d2
                move.w  d2,(a0)+
                addq.w  #1,d2
                move.w  d2,(a1)+
                move.w  d7,d3
                bsr.w   Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d7,d3
; End of function UI_ConvertNumberToDigits
; Builds VDP command list for DMA operations in VRAM
