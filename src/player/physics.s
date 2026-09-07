Physics_ApplyFriction:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C6F0   p  ; was: sub_13278
                                        ; sub_1E8F6   p ...
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
loc_13280:                              ; CODE XREF: UI_RenderDebugMenu+C   p
                tst.b   (byte_FFF705).w
                bpl.w   loc_13350
                btst    #0,(byte_FFF705).w
                beq.w   loc_13350
                btst    #4,(word_FFF706).w
                bne.w   loc_13350
                tst.w   (word_FFFF0E).w
                bne.s   loc_132CE
                btst    #2,(word_FFF708).w
                beq.s   loc_132B4
                subq.w  #1,(word_FFFF3E).w
                bpl.s   loc_132CE
                clr.w   (word_FFFF3E).w
loc_132B4:                              ; CODE XREF: Physics_ApplyFriction+30   j
                btst    #3,(word_FFF708).w
                beq.s   loc_132CE
                addq.w  #1,(word_FFFF3E).w
                cmpi.w  #4,(word_FFFF3E).w
                bmi.s   loc_132CE
                move.w  #3,(word_FFFF3E).w
loc_132CE:                              ; CODE XREF: Physics_ApplyFriction+28   j
                                        ; Physics_ApplyFriction+36   j ...
                btst    #1,(word_FFA280+1).w
                bne.w   loc_132FA
                move.w  #$A2,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7F9,(a1)+
                move.w  #$194,(a1)+
                move.w  #$A2,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7FD,(a1)+
                move.w  #$1B4,(a1)+
                bra.s   loc_13350
; ---------------------------------------------------------------------------
loc_132FA:                              ; CODE XREF: Physics_ApplyFriction+5C   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_13350
                move.w  #$150,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C7D8,(a1)+
                move.w  #$10C,(a1)+
                move.w  (word_FFFF3E).w,d1
                andi.w  #3,d1
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$12C,(a1)+
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$134,(a1)+
                subq.w  #1,d1
                bmi.s   loc_13350
                move.w  d0,(a1)+
                move.w  #0,(a1)+
                move.w  #$C7DB,(a1)+
                move.w  #$13C,(a1)+
loc_13350:                              ; CODE XREF: Physics_ApplyFriction+C   j
                                        ; Physics_ApplyFriction+16   j ...
                move.w  #$80,(a1)+
                move.w  #$B00,(a1)+
                move.w  #$C6F0,(a1)+
                btst    #0,(word_FFA280+1).w
                bne.s   loc_1336A
                tst.b   (byte_FFFF31).w
                beq.s   loc_13370
loc_1336A:                              ; CODE XREF: Physics_ApplyFriction+EA   j
                move.w  #1,(a1)+
                bra.s   loc_1337E
; ---------------------------------------------------------------------------
loc_13370:                              ; CODE XREF: Physics_ApplyFriction+F0   j
                lea     word_133CC(pc),a2
                nop
                move.w  (word_FFA24E).w,d1
                move.w  (a2,d1.w),(a1)+
loc_1337E:                              ; CODE XREF: Physics_ApplyFriction+F6   j
                move.w  #$80,(a1)+
                move.w  #$300,(a1)+
                move.w  d0,(a1)+
                clr.w   (a1)+
                move.w  (word_FF8110).w,d2
                beq.s Sprite_FinalizeOAMBuffer
                tst.w   (word_FF8112).w
                bpl.s   loc_133A0
                clr.w   (word_FF8110).w
                clr.w   (word_FF8112).w
                bra.s Sprite_FinalizeOAMBuffer
; ---------------------------------------------------------------------------
loc_133A0:                              ; CODE XREF: Physics_ApplyFriction+11C   j
                move.w  #$A0,d0
                move.w  #$700,d1
                move.w  #$60,d3 ; '`'
                add.w   (word_FF8112).w,d3
                moveq   #5,d7
loc_133B2:                              ; CODE XREF: Physics_ApplyFriction+146   j
                move.w  d0,(a1)+
                move.w  d1,(a1)+
                move.w  d2,(a1)+
                move.w  d3,(a1)+
                addi.w  #$20,d0 ; ' '
                dbf     d7,loc_133B2
; Finalizes OAM buffer with end marker and adds to sprite list
Sprite_FinalizeOAMBuffer:                              ; CODE XREF: Physics_ApplyFriction+116   j  ; was: loc_133C2
                                        ; Physics_ApplyFriction+126   j
                move.w  #$FFFF,(a1)
                jmp (Sprite_AddToOAMBuffer).l
; End of function Physics_ApplyFriction
; ---------------------------------------------------------------------------
word_133CC:     dc.w $160, $178, $190, $1A8
                                        ; DATA XREF: Physics_ApplyFriction:loc_13370   o


; Sets up DMA transfer for score display rendering to VDP
