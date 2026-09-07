Effect_InitFloatingIcon:                                ; CODE XREF: UI_BuildSelectionMenu+68   p  ; was: sub_21F2A
                                        ; UI_BuildSelectionMenu+D6   p
                move.w  #$464,(a0)
                move.w  #$4000,2(a0)
                clr.b   $20(a0)
                move.l  #byte_21F4A,8(a0)
                clr.l   $18(a0)
                clr.l   $1C(a0)
                rts
; End of function Effect_InitFloatingIcon
; ---------------------------------------------------------------------------
byte_21F4A:     dc.b    $83, 0, 1, 0, $F8, $FC
                                        ; DATA XREF: Effect_InitFloatingIcon+E   o

; Dispatcher for floating icon animation states
Effect_FloatingIconDispatcher:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_21F50
                move.w  4(a5),d0
                lea     off_21F5C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Effect_FloatingIconDispatcher
; ---------------------------------------------------------------------------
off_21F5C:      dc.w    Effect_FloatingIconInit-*       ; DATA XREF: Effect_FloatingIconDispatcher+4   o
                dc.w    Effect_FloatingIconFloat-*
                dc.w    Effect_FloatingIconReturn-*
                dc.w    Effect_MoveUpAndSetTarget-*
                dc.w    Effect_WaitAndSetFallGravity-*
                dc.w    Physics_DecreaseGravity-*

; Initialize floating icon trajectory and velocity
Effect_FloatingIconInit:                                ; DATA XREF: ROM:off_21F5C   o  ; was: sub_21F68
                addq.w  #2,4(a5)
                move.l  $10(a5),$50(a5)
                move.l  $14(a5),$54(a5)
                move.w  #8,$4A(a5)
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a4
                move.w  word_1B494-word_1B514(a4,d0.w),d1
                move.w  (a4,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  (word_FFA280).w,d0
                add.w   d0,$4C(a5)
                andi.w  #$1FE,$4C(a5)
                rts
; End of function Effect_FloatingIconInit
; Animate floating icon with circular motion
Effect_FloatingIconFloat:                               ; CODE XREF: Effect_FloatingIconFloat+24   j  ; was: sub_21FB4
                                        ; DATA XREF: ROM:00021F5E   o
                addq.w  #1,$48(a5)
                addi.w  #4,$4C(a5)
                addi.w  #2,$4E(a5)
                move.l  $18(a5),d0
                add.l   d0,$50(a5)
                move.l  $1C(a5),d0
                add.l   d0,$54(a5)
                subq.w  #1,$4A(a5)
                bne.s   Effect_FloatingIconFloat
                cmpi.w  #$5C,$48(a5)                    ; '\'
                bcc.s   loc_21FEA
                move.w  #8,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_21FEA:                                              ; CODE XREF: Effect_FloatingIconFloat+2C   j
                bsr.w   Math_CalculateIconPosition
                neg.l   $18(a5)
                neg.l   $1C(a5)
                bset    #7,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Effect_FloatingIconFloat
; Calculate icon position using sine/cosine tables
Math_CalculateIconPosition:                             ; CODE XREF: Effect_FloatingIconFloat:loc_21FEA   p  ; was: sub_22002
                                        ; Effect_FloatingIconReturn+16   p
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a4
                move.w  word_1B494-word_1B514(a4,d0.w),d1
                move.w  (a4,d0.w),d0
                muls.w  $4E(a5),d0
                muls.w  $4E(a5),d1
                asr.l   #1,d1
                add.l   $50(a5),d0
                add.l   $54(a5),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                rts
; End of function Math_CalculateIconPosition
; Return floating icon to original position
Effect_FloatingIconReturn:                              ; DATA XREF: ROM:00021F60   o  ; was: sub_22034
                subi.w  #4,$4C(a5)
                move.l  $18(a5),d0
                add.l   d0,$50(a5)
                move.l  $1C(a5),d0
                add.l   d0,$54(a5)
                bsr.w   Math_CalculateIconPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2205E
                andi.w  #$FFFE,$4E(a5)
                addq.w  #2,4(a5)
locret_2205E:                                           ; CODE XREF: Effect_FloatingIconReturn+1E   j
                rts
; End of function Effect_FloatingIconReturn
; Update palette color based on icon animation frame
Gfx_UpdateIconPalette:
                cmpa.w  #$C740,a5                       ; was: sub_22060
                bne.s   locret_22074
                move.w  $48(a5),d0
                lsr.w   #4,d0
                add.w   d0,d0
                move.w  word_22076(pc,d0.w),(word_FFE302).w
locret_22074:                                           ; CODE XREF: Gfx_UpdateIconPalette+4   j
                rts
; End of function Gfx_UpdateIconPalette
; ---------------------------------------------------------------------------
word_22076:     dc.w    $222, $444, $666, $888, $AAA, $CCC, $EEE
                                        ; DATA XREF: Gfx_UpdateIconPalette+E   r

; Moves object up by decrementing Y position, waits for timer, then sets target Y offset
Effect_MoveUpAndSetTarget:                              ; DATA XREF: ROM:00021F62   o  ; was: sub_22084
                subi.w  #$10,$4C(a5)
                bsr.w   Math_CalculateIconPosition
                subq.w  #2,$4E(a5)
                bpl.s   locret_220A4
                move.w  $46(a5),d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$48(a5)
                addq.w  #2,4(a5)
locret_220A4:                                           ; CODE XREF: Effect_MoveUpAndSetTarget+E   j
                rts
; End of function Effect_MoveUpAndSetTarget
; Waits for timer, then sets object to falling state with gravity value
Effect_WaitAndSetFallGravity:                           ; DATA XREF: ROM:00021F64   o  ; was: sub_220A6
                subq.w  #1,$48(a5)
                bne.s   locret_220C4
                bset    #1,2(a5)
                bset    #2,2(a5)
                move.l  #$10000,$1C(a5)
                addq.w  #2,4(a5)
locret_220C4:                                           ; CODE XREF: Effect_WaitAndSetFallGravity+4   j
                rts
; End of function Effect_WaitAndSetFallGravity
; Decreases gravity/velocity by subtracting from long word at offset 0x1C
Physics_DecreaseGravity:                                ; DATA XREF: ROM:00021F66   o  ; was: sub_220C6
                subi.l  #$800,$1C(a5)
                rts
; End of function Physics_DecreaseGravity
; Main controller for Z-Leo boss fight, handles palette updates and state dispatch
