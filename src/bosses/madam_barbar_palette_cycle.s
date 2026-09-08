; Cycles the signed fade step applied to Madam Barbar's four-color palette
Boss_MadamBarbarPaletteCycle:
                move.w  8(a5),d0                        ; was: sub_3A0EA
                tst.w   $A(a5)
                beq.s   loc_3A102
                addq.w  #1,d0
                cmpi.w  #$E,d0
                bne.s   loc_3A10E
                clr.w   $A(a5)
                bra.s   loc_3A10E
; ---------------------------------------------------------------------------
loc_3A102:                                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+8   j
                subq.w  #1,d0
                cmpi.w  #$FFF2,d0
                bne.s   loc_3A10E
                addq.w  #1,$A(a5)
loc_3A10E:                                              ; CODE XREF: Boss_MadamBarbarPaletteCycle+10   j
                                        ; Boss_MadamBarbarPaletteCycle+16   j
                move.w  d0,8(a5)
                movea.w #(word_FFE318-M68K_RAM),a0
                moveq   #3,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_MadamBarbarPaletteCycle
