UI_SelectionMenuDispatcher:                             ; CODE XREF: Credits_ScrollWithColorCycle   p  ; was: sub_21A5C
                                        ; sub_20C88   p
                move.w  (word_FF00EC).l,d0
                lea     off_21A6A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_SelectionMenuDispatcher
; ---------------------------------------------------------------------------
off_21A6A:      dc.w    UI_BuildSelectionMenu-*         ; DATA XREF: UI_SelectionMenuDispatcher+6   o
                dc.w    UI_BuildSelectionMenu_ProcessLoop-*
                dc.w    UI_WaitForMenuComplete-*
                dc.w    UI_MenuDelayTimer-*
                dc.w    nullsub_55-*

; Build selection menu with character icons
UI_BuildSelectionMenu:                                  ; DATA XREF: ROM:off_21A6A   o  ; was: sub_21A74
                move.w  #$222,(word_FFE302).w
                move.w  #$EEE,(word_FFE304).w
                move.l  #word_21BC0,(dword_FF00F8).l
                addq.w  #2,(word_FF00EC).l
; Main loop processing menu item data and initializing floating icons
UI_BuildSelectionMenu_ProcessLoop:                      ; DATA XREF: ROM:00021A6C   o  ; was: loc_21A90
                lea     (word_FFC740).w,a0
                movea.l (dword_FF00F8).l,a1
                moveq   #0,d0
                move.b  (a1)+,d0
                bmi.w   loc_21B88
                add.w   d0,d0
                move.w  d0,(word_FF00FC).l
                move.b  (a1)+,d0
                beq.w   loc_21B0C
                move.w  d0,d1
                subq.w  #1,d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  #$120,d3
                sub.w   d1,d3
                move.w  #$E4,d4
                move.w  d0,d1
                subq.w  #1,d1
                muls.w  #$10,d1
                move.w  #$180,d5
                sub.w   d1,d5
                move.w  d0,d7
                subq.w  #1,d7
loc_21AD4:                                              ; CODE XREF: UI_BuildSelectionMenu+94   j
                move.b  (a1)+,d0
                cmpi.b  #0,d0
                beq.s   loc_21AFE
                bsr.w   Effect_InitFloatingIcon
                add.w   d0,d0
                ori.w   #$8000,d0
                move.w  d0,$E(a0)
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                move.w  d5,$4C(a0)
                move.w  (word_FF00FC).l,$46(a0)
loc_21AFE:                                              ; CODE XREF: UI_BuildSelectionMenu+66   j
                addq.w  #8,d3
                addi.w  #$20,d5                         ; ' '
                lea     $60(a0),a0
                dbf     d7,loc_21AD4
loc_21B0C:                                              ; CODE XREF: UI_BuildSelectionMenu+38   j
                moveq   #0,d0
                move.b  (a1)+,d0
                add.w   d0,d0
                move.w  d0,(word_FF00FC).l
                move.b  (a1)+,d0
                beq.w   loc_21B7A
                move.w  d0,d1
                subq.w  #1,d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  #$120,d3
                sub.w   d1,d3
                move.w  #$FC,d4
                move.w  d0,d1
                subq.w  #1,d1
                muls.w  #$10,d1
                addi.w  #$80,d1
                move.w  d1,d5
                move.w  d0,d7
                subq.w  #1,d7
loc_21B42:                                              ; CODE XREF: UI_BuildSelectionMenu+102   j
                move.b  (a1)+,d0
                cmpi.b  #0,d0
                beq.s   loc_21B6C
                bsr.w   Effect_InitFloatingIcon
                add.w   d0,d0
                ori.w   #$8000,d0
                move.w  d0,$E(a0)
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                move.w  d5,$4C(a0)
                move.w  (word_FF00FC).l,$46(a0)
loc_21B6C:                                              ; CODE XREF: UI_BuildSelectionMenu+D4   j
                addq.w  #8,d3
                subi.w  #$20,d5                         ; ' '
                lea     $60(a0),a0
                dbf     d7,loc_21B42
loc_21B7A:                                              ; CODE XREF: UI_BuildSelectionMenu+A6   j
                move.l  a1,(dword_FF00F8).l
                addq.w  #2,(word_FF00EC).l
                rts
; ---------------------------------------------------------------------------
loc_21B88:                                              ; CODE XREF: UI_BuildSelectionMenu+2A   j
                move.w  #8,(word_FF00EC).l
                rts
; End of function UI_BuildSelectionMenu
; Wait for menu animation to complete
UI_WaitForMenuComplete:                                 ; DATA XREF: ROM:00021A6E   o  ; was: sub_21B92
                lea     (word_FFC740).w,a0
                cmpi.w  #$464,(a0)
                beq.s   locret_21BAA
                move.w  #$10,(word_FF00FC).l
                addq.w  #2,(word_FF00EC).l
locret_21BAA:                                           ; CODE XREF: UI_WaitForMenuComplete+8   j
                rts
; End of function UI_WaitForMenuComplete
; Delay timer for menu state transitions
UI_MenuDelayTimer:                                      ; DATA XREF: ROM:00021A70   o  ; was: sub_21BAC
                subq.w  #1,(word_FF00FC).l
                bpl.s   locret_21BBC
                move.w  #2,(word_FF00EC).l
locret_21BBC:                                           ; CODE XREF: UI_MenuDelayTimer+6   j
                rts
; End of function UI_MenuDelayTimer
nullsub_55:                                             ; DATA XREF: ROM:00021A72   o
                rts
; End of function nullsub_55
; ---------------------------------------------------------------------------
word_21BC0:     binclude "data/other/word_21BC0.bin"
word_21BC0_End:

; Initialize floating icon sprite properties
