UI_DebugSpriteEditor:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_2AA08
                btst    #7,(word_FFF706).w
                beq.w   loc_2AA1A
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2AA1A:                                              ; CODE XREF: UI_DebugSpriteEditor+6   j
                move.w  #$8000,2(a5)
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                move.w  $E(a5),d0
                btst    #6,(word_FFF706).w
                beq.w   loc_2AA5A
                btst    #0,(word_FFF706).w
                beq.w   loc_2AA4A
                addq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA4A:                                              ; CODE XREF: UI_DebugSpriteEditor+38   j
                btst    #1,(word_FFF706).w
                beq.w   loc_2AA8A
                subq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA5A:                                              ; CODE XREF: UI_DebugSpriteEditor+2E   j
                btst    #4,(word_FFF706).w
                bne.w   loc_2AA8A
                btst    #5,(word_FFF706).w
                bne.w   loc_2AA8A
                btst    #0,(word_FFF708).w
                beq.w   loc_2AA7E
                addq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA7E:                                              ; CODE XREF: UI_DebugSpriteEditor+6C   j
                btst    #1,(word_FFF708).w
                beq.w   loc_2AA8A
                subq.w  #1,d0
loc_2AA8A:                                              ; CODE XREF: UI_DebugSpriteEditor+3E   j
                                        ; UI_DebugSpriteEditor+48   j
                andi.w  #$7FF,d0
                andi.w  #$9800,$E(a5)
                or.w    d0,$E(a5)
                btst    #4,(word_FFF706).w
                beq.w   loc_2AAE8
                btst    #0,(word_FFF708).w
                beq.w   loc_2AAB2
                addi.w  #$2000,$48(a5)
loc_2AAB2:                                              ; CODE XREF: UI_DebugSpriteEditor+A0   j
                andi.w  #$6000,$48(a5)
                move.w  $48(a5),d0
                or.w    d0,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                btst    #1,(word_FFF708).w
                beq.w   loc_2AAD8
                eori.w  #$1000,$E(a5)
loc_2AAD8:                                              ; CODE XREF: UI_DebugSpriteEditor+C6   j
                btst    #3,(word_FFF708).w
                beq.w   loc_2AAE8
                eori.w  #$800,$E(a5)
loc_2AAE8:                                              ; CODE XREF: UI_DebugSpriteEditor+96   j
                                        ; UI_DebugSpriteEditor+D6   j
                btst    #5,(word_FFF706).w
                beq.w   locret_2AB48
                btst    #0,(word_FFF708).w
                beq.w   loc_2AB02
                addi.w  #$100,8(a5)
loc_2AB02:                                              ; CODE XREF: UI_DebugSpriteEditor+F0   j
                andi.w  #$F00,8(a5)
                btst    #1,(word_FFF708).w
                beq.w   loc_2AB28
                move.w  $A(a5),d0
                andi.w  #$FF,$A(a5)
                addi.w  #$100,d0
                andi.w  #$FF00,d0
                or.w    d0,$A(a5)
loc_2AB28:                                              ; CODE XREF: UI_DebugSpriteEditor+106   j
                btst    #3,(word_FFF708).w
                beq.w   locret_2AB48
                move.w  $A(a5),d0
                andi.w  #$FF00,$A(a5)
                addi.w  #1,d0
                andi.w  #$FF,d0
                or.w    d0,$A(a5)
locret_2AB48:                                           ; CODE XREF: UI_DebugSpriteEditor+E6   j
                                        ; UI_DebugSpriteEditor+126   j
                rts
; End of function UI_DebugSpriteEditor
; Debug sprite position editor for moving sprites with collision detection
UI_DebugSpritePositionEditor:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_2AB4A
                tst.w   4(a5)
                bne.w   loc_2AB66
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
loc_2AB66:                                              ; CODE XREF: UI_DebugSpritePositionEditor+4   j
                ori.w   #$8000,2(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2AB88
                move.w  #$C4AC,$E(a5)
                bra.s   loc_2AB8E
; ---------------------------------------------------------------------------
loc_2AB88:                                              ; CODE XREF: UI_DebugSpritePositionEditor+34   j
                move.w  #$C4B4,$E(a5)
loc_2AB8E:                                              ; CODE XREF: UI_DebugSpritePositionEditor+3C   j
                btst    #0,(word_FFF706).w
                beq.s   loc_2ABA6
                moveq   #0,d0
                moveq   #$FFFFFFFC,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_2ABA6
                subq.w  #2,$14(a5)
loc_2ABA6:                                              ; CODE XREF: UI_DebugSpritePositionEditor+4A   j
                                        ; UI_DebugSpritePositionEditor+56   j
                btst    #1,(word_FFF706).w
                beq.s   loc_2ABBE
                moveq   #0,d0
                moveq   #4,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_2ABBE
                addq.w  #2,$14(a5)
loc_2ABBE:                                              ; CODE XREF: UI_DebugSpritePositionEditor+62   j
                                        ; UI_DebugSpritePositionEditor+6E   j
                btst    #2,(word_FFF706).w
                beq.s   loc_2ABD6
                moveq   #$FFFFFFFC,d0
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_2ABD6
                subq.w  #2,$10(a5)
loc_2ABD6:                                              ; CODE XREF: UI_DebugSpritePositionEditor+7A   j
                                        ; UI_DebugSpritePositionEditor+86   j
                btst    #3,(word_FFF706).w
                beq.s   locret_2ABEE
                moveq   #4,d0
                moveq   #0,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   locret_2ABEE
                addq.w  #2,$10(a5)
locret_2ABEE:                                           ; CODE XREF: UI_DebugSpritePositionEditor+92   j
                                        ; UI_DebugSpritePositionEditor+9E   j
                rts
; End of function UI_DebugSpritePositionEditor
; ---------------------------------------------------------------------------
