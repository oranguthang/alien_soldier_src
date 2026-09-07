UI_RenderHUDElement1:                                   ; CODE XREF: Sys_GameplayMainLoop+164   p  ; was: sub_12B6A
                                        ; Cutscene_UpdateHUDAndXiTigerState+6   p
                clr.l   (dword_FF84A0).w
                clr.l   (dword_FF8500).w
                clr.l   (dword_FF8560).w
                bra.s   loc_12BDA
; ===============================================================================
; DEAD CODE: Unused Debug Input Handler (UNREFERENCED)
; ===============================================================================
; Status: This code is completely unreachable due to unconditional branch at
; line 23695 (bra.s loc_12BDA) which skips this entire block
;
; Description: Debug input handling routine that was disabled during development
; Tests word_FF8228 flag and processes controller button inputs
; by checking specific bits in word_FFF708 (controller state):
; - Bit 6: Calls Input_ProcessButtons with value from word_FF8228
; - Bit 4: Calls Input_ProcessButtons with parameter 1
; - Bit 5: Calls Input_ProcessButtons with parameter 4
;
; Purpose: Likely a developer testing/debug feature that allowed manual control
; or parameter manipulation during UI/HUD rendering. The code was
; disabled but not removed, suggesting it might have been kept for
; potential future use or debugging
;
; Controller Input Tested:
; word_FFF708 bit 6 - Unknown button (uses word_FF8228 value)
; word_FFF708 bit 4 - Button maps to parameter 1
; word_FFF708 bit 5 - Button maps to parameter 4
;
; Reason for Removal: Unknown - possibly:
; - Debug feature not needed in release build
; - Alternative input handling implemented
; - Functionality moved to different system
;
; Research Note: Found via unreferenced labels analysis (scripts/find_unreferenced_labels.py)
; This is the ONLY truly unreferenced function in the entire disassembly
; (out of 136 initially flagged labels, 135 were false positives)
; ===============================================================================
; Debug menu for testing input buttons
Debug_InputTestMenu:                                    ; UNREFERENCED DEBUG CODE (DEAD)  ; was: sub_12B78
                tst.w   (word_FF8228).w
                beq.s   loc_12BB8
                btst    #6,(word_FFF708+1).w
                beq.s   loc_12B92
                move.b  (word_FF8228).w,d0
                jsr     (Input_ProcessButtons).l
                bra.s   loc_12BB8
; ---------------------------------------------------------------------------
loc_12B92:                                              ; CODE XREF: UI_RenderHUDElement1+1A   j
                btst    #4,(word_FFF708+1).w
                beq.s   loc_12BA6
                move.b  #1,d0
                jsr     (Input_ProcessButtons).l
                bra.s   loc_12BB8
; ---------------------------------------------------------------------------
loc_12BA6:                                              ; CODE XREF: UI_RenderHUDElement1+2E   j
                btst    #5,(word_FFF708+1).w
                beq.s   loc_12BB8
                move.b  #4,d0
                jsr     (Input_ProcessButtons).l
loc_12BB8:                                              ; CODE XREF: UI_RenderHUDElement1+12   j
                                        ; UI_RenderHUDElement1+26   j
                tst.w   (word_FF8226).w
                bne.w   UI_RenderDebugMenu
                tst.b   (byte_FFF705).w
                bpl.s   loc_12BDA
                btst    #0,(byte_FFF705).w
                beq.s   loc_12BDA
                btst    #6,(word_FFF708).w
                beq.s   loc_12BDA
                addq.w  #2,(word_FF8226).w
loc_12BDA:                                              ; CODE XREF: UI_RenderHUDElement1+C   j
                                        ; UI_RenderHUDElement1+5A   j
                tst.b   (byte_FFF705).w
                bmi.s   loc_12C30
                btst    #0,(byte_FFA272).w
                bne.s   loc_12C30
                tst.w   (word_FFA270).w
                beq.s   loc_12C30
                tst.w   (word_FF813C).w
                bpl.s   loc_12C30
                subq.b  #1,(byte_FF8204).w
                bpl.s   loc_12C30
                move.b  #$3B,(byte_FF8204).w            ; ';'
                moveq   #1,d0
                move.b  (word_FFA270+1).w,d2
                sub.w   d4,d4
                sbcd    d0,d2
                cmpi.b  #$99,d2
                bne.s   loc_12C2C
                move.b  (word_FFA270).w,d2
                sub.w   d4,d4
                sbcd    d0,d2
                cmpi.b  #$99,d2
                bne.s   loc_12C24
                clr.w   (word_FFA270).w
                bra.s   loc_12C30
; ---------------------------------------------------------------------------
loc_12C24:                                              ; CODE XREF: UI_RenderHUDElement1+B2   j
                move.b  d2,(word_FFA270).w
                move.b  #$59,d2                         ; 'Y'
loc_12C2C:                                              ; CODE XREF: UI_RenderHUDElement1+A4   j
                move.b  d2,(word_FFA270+1).w
loc_12C30:                                              ; CODE XREF: UI_RenderHUDElement1+74   j
                                        ; UI_RenderHUDElement1+7C   j
                bclr    #0,(byte_FF8260).w
                move.w  (word_FF8234).w,d0
                beq.s   loc_12C56
                bpl.s   loc_12C44
                clr.w   (word_FF8234).w
                bra.s   loc_12C56
; ---------------------------------------------------------------------------
loc_12C44:                                              ; CODE XREF: UI_RenderHUDElement1+D2   j
                cmp.w   (word_FF8236).w,d0
                bmi.s   loc_12C56
                move.w  (word_FF8236).w,(word_FF8234).w
                bset    #0,(byte_FF8260).w
loc_12C56:                                              ; CODE XREF: UI_RenderHUDElement1+D0   j
                                        ; UI_RenderHUDElement1+D8   j
                bsr.w   UI_SetupScoreDMA
                tst.b   (byte_FFFF31).w
                bpl.s   loc_12C62
                rts
; ---------------------------------------------------------------------------
loc_12C62:                                              ; CODE XREF: UI_RenderHUDElement1+F4   j
                lea     (word_5A43E).l,a4
                btst    #0,(word_FFA280+1).w
                bne.w   UI_RenderHUDElement3
                bsr.w   UI_RenderHUDElement2
                tst.b   (byte_FFF705).w
                bpl.s   loc_12C90
                btst    #0,(byte_FFF705).w
                beq.s   loc_12C90
                btst    #4,(word_FFF706).w
                bne.s   loc_12C90
                bra.w   UI_RenderShipHealthDisplay
; ---------------------------------------------------------------------------
loc_12C90:                                              ; CODE XREF: UI_RenderHUDElement1+110   j
                                        ; UI_RenderHUDElement1+118   j
                movea.w #(byte_FF84B0-M68K_RAM),a0
                btst    #4,(byte_FFFF30).w
                beq.s   loc_12CAE
                move.w  #$C7E2,d0
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                move.w  d0,(a0)+
                bra.w   loc_12E16
; ---------------------------------------------------------------------------
loc_12CAE:                                              ; CODE XREF: UI_RenderHUDElement1+130   j
                subq.w  #1,(word_FF8268).w
                bpl.s   loc_12CBA
                move.w  #$FFFF,(word_FF8268).w
loc_12CBA:                                              ; CODE XREF: UI_RenderHUDElement1+148   j
                move.w  (word_FF820A).w,d0
                move.w  d0,d1
                sub.w   (word_FFA216).w,d0
                bpl.s   loc_12CD4
                cmpi.w  #$FFF0,d0
                bpl.s   loc_12CDA
                addi.w  #$10,(word_FF820A).w
                bra.s   loc_12CE8
; ---------------------------------------------------------------------------
loc_12CD4:                                              ; CODE XREF: UI_RenderHUDElement1+15A   j
                cmpi.w  #8,d0
                bpl.s   loc_12CE2
loc_12CDA:                                              ; CODE XREF: UI_RenderHUDElement1+160   j
                move.w  (word_FFA216).w,(word_FF820A).w
                bra.s   loc_12CE8
; ---------------------------------------------------------------------------
loc_12CE2:                                              ; CODE XREF: UI_RenderHUDElement1+16E   j
                subi.w  #8,(word_FF820A).w
loc_12CE8:                                              ; CODE XREF: UI_RenderHUDElement1+168   j
                                        ; UI_RenderHUDElement1+176   j
                moveq   #$13,d7
                cmpi.w  #2,(word_FFA216).w
                bpl.s   loc_12D10
                move.w  (word_FFA280).w,d1
                btst    #4,d1
                bne.s   loc_12D10
                andi.w  #3,d1
                bne.s   loc_12D10
                move.w  #$C7D1,d0
loc_12D06:                                              ; CODE XREF: UI_RenderHUDElement1+19E   j
                move.w  d0,(a0)+
                dbf     d7,loc_12D06
                bra.w   loc_12E2C
; ---------------------------------------------------------------------------
loc_12D10:                                              ; CODE XREF: UI_RenderHUDElement1+186   j
                                        ; UI_RenderHUDElement1+190   j
                tst.w   (word_FF8304).w
                bne.s   loc_12D2C
                btst    #1,(word_FFA280+1).w
                bne.s   loc_12D2C
                move.w  #$C551,d0
loc_12D22:                                              ; CODE XREF: UI_RenderHUDElement1+1BA   j
                move.w  d0,(a0)+
                dbf     d7,loc_12D22
                bra.w   loc_12E2C
; ---------------------------------------------------------------------------
loc_12D2C:                                              ; CODE XREF: UI_RenderHUDElement1+1AA   j
                                        ; UI_RenderHUDElement1+1B2   j
                btst    #0,(byte_FFFF30).w
                beq.s   loc_12D76
                move.w  #$C7B4,d5
                move.w  (word_FF820A).w,d0
                asl.w   #1,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                move.w  #$C7E0,(a0)+
                move.w  (word_FFA218).w,d0
                asl.w   #1,d0
                andi.w  #$FFFE,d0
                move.w  (a4,d0.w),(dword_FF8040).w
                movea.w #(dword_FF8040-M68K_RAM),a1
                moveq   #1,d7
                bsr.w   Scroll_ShipScrollPattern
                move.w  #$C7F8,(a0)+
                bra.s   loc_12DB4
; ---------------------------------------------------------------------------
loc_12D76:                                              ; CODE XREF: UI_RenderHUDElement1+1C8   j
                move.w  (word_FFA218).w,d7
                asr.w   #6,d7
                move.w  (word_FF820A).w,d0
                subq.w  #1,d0
                bmi.s   loc_12DA6
                move.w  d0,d1
                asr.w   #6,d0
                sub.w   d0,d7
                asr.w   #3,d1
                andi.w  #7,d1
                addi.w  #-$383C,d1
                subq.w  #1,d0
                bmi.s   loc_12DA2
                move.w  #$C7CB,d2
loc_12D9C:                                              ; CODE XREF: UI_RenderHUDElement1+234   j
                move.w  d2,(a0)+
                dbf     d0,loc_12D9C
loc_12DA2:                                              ; CODE XREF: UI_RenderHUDElement1+22C   j
                move.w  d1,(a0)+
                subq.w  #1,d7
loc_12DA6:                                              ; CODE XREF: UI_RenderHUDElement1+218   j
                subq.w  #1,d7
                bmi.s   loc_12DB4
                move.w  #$C7C3,d0
loc_12DAE:                                              ; CODE XREF: UI_RenderHUDElement1+246   j
                move.w  d0,(a0)+
                dbf     d7,loc_12DAE
loc_12DB4:                                              ; CODE XREF: UI_RenderHUDElement1+20A   j
                                        ; UI_RenderHUDElement1+23E   j
                tst.w   (word_FF8268).w
                bmi.s   loc_12E16
                move.w  (word_FF8268).w,d0
                cmpi.w  #$12,d0
                bmi.s   loc_12DCC
                btst    #2,(word_FFA280+1).w
                bne.s   loc_12E16
loc_12DCC:                                              ; CODE XREF: UI_RenderHUDElement1+258   j
                move.w  #$C7BF,d2
                move.w  (word_FF8262).w,d0
                bclr    #$F,d0
                bne.s   loc_12DDE
                move.w  #$C7E1,d2
loc_12DDE:                                              ; CODE XREF: UI_RenderHUDElement1+26E   j
                move.w  d2,(a0)+
                move.w  #$C7B4,d2
                asl.w   #1,d0
                move.b  (a4,d0.w),d1
                andi.w  #$F,d1
                beq.s   loc_12DF4
                add.w   d2,d1
                move.w  d1,(a0)+
loc_12DF4:                                              ; CODE XREF: UI_RenderHUDElement1+284   j
                move.w  (a4,d0.w),d3
                lsr.w   #4,d3
                andi.w  #$F,d3
                tst.w   d1
                bne.s   loc_12E06
                tst.w   d3
                beq.s   loc_12E0A
loc_12E06:                                              ; CODE XREF: UI_RenderHUDElement1+296   j
                add.w   d2,d3
                move.w  d3,(a0)+
loc_12E0A:                                              ; CODE XREF: UI_RenderHUDElement1+29A   j
                move.w  (a4,d0.w),d1
                andi.w  #$F,d1
                add.w   d2,d1
                move.w  d1,(a0)+
loc_12E16:                                              ; CODE XREF: UI_RenderHUDElement1+140   j
                                        ; UI_RenderHUDElement1+24E   j
                move.w  #$84D8,d7
                sub.w   a0,d7
                lsr.w   #1,d7
                subq.w  #1,d7
                bmi.s   loc_12E2C
                move.w  #$C7F8,d0
loc_12E26:                                              ; CODE XREF: UI_RenderHUDElement1+2BE   j
                move.w  d0,(a0)+
                dbf     d7,loc_12E26
loc_12E2C:                                              ; CODE XREF: UI_RenderHUDElement1+1A2   j
                                        ; UI_RenderHUDElement1+1BE   j
                movea.w #(byte_FF84B0-M68K_RAM),a5
                move.w  #$83,-(a5)
                move.w  #$508C,-(a5)
                move.w  #$9558,-(a5)
                move.w  #$96C2,-(a5)
                move.w  #$977F,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94009314,-(a5)
                rts
; End of function UI_RenderHUDElement1
; Renders HUD element variant 2
