Boss_ValkirieInitScreenPair:                            ; CODE XREF: Boss_WolfGaropaBombCheck1+1C   p  ; was: sub_50CD4
                                        ; Boss_WolfGaropaBombCheck2+14   p
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$418,(a0)
                clr.w   2(a0)
                move.w  d0,$48(a0)
                clr.w   $4C(a0)
                move.w  d1,$14(a0)
                move.b  #$80,$21(a0)
                move.b  #$90,$23(a0)
                move.w  #4,$24(a0)
                move.w  #$115,$26(a0)
                move.l  #$7EF030,d1
                move.l  #$7EF030,d2
                move.w  #$120,d3
                tst.w   d0
                beq.s   loc_50D28
                move.l  #$8200F030,d1
                move.l  #$8200F030,d2
                move.w  #$B0,d3
loc_50D28:                                              ; CODE XREF: Boss_ValkirieInitScreenPair+42   j
                move.l  d1,$28(a0)
                move.l  d2,$2C(a0)
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  d3,$14(a0)
                jsr     (Pickup_SpawnSmall).l
                move.w  #$420,(a0)
                move.w  #$E000,2(a0)
                move.w  #$28,$1C(a0)                    ; '('
                rts
; End of function Boss_ValkirieInitScreenPair
; Forces player to ceiling during Valkirie encounter by adjusting vertical position and checking proximity to boss position
Boss_ValkirieForcePlayerToCeiling:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_50D50
                tst.b   (byte_FF9DBA).w
                beq.s   loc_50D7E
                btst    #4,$22(a5)
                beq.s   loc_50D86
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.w  #6,(word_FFA010).w
                cmpi.w  #$1F0,(dword_FFA900).w
                bpl.w   loc_50D7E
                jsr     (Gfx_LoadWolfGaropaTiles).l
loc_50D7E:                                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+4   j
                                        ; Boss_ValkirieForcePlayerToCeiling+24   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50D86:                                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+C   j
                move.w  #$1F0,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  (dword_FFA414).w,d0
                move.w  (dword_FFA410).w,d1
                tst.w   $48(a5)
                bne.s   loc_50DB4
                addi.w  #$18,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_50DC8
                cmp.w   $10(a5),d1
                bpl.w   loc_50DD6
                rts
; ---------------------------------------------------------------------------
loc_50DB4:                                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+4E   j
                subi.w  #$18,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_50DC8
                cmp.w   $10(a5),d1
                bpl.w   loc_50DD6
                rts
; ---------------------------------------------------------------------------
loc_50DC8:                                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+58   j
                                        ; Boss_ValkirieForcePlayerToCeiling+6C   j
                cmp.w   $10(a5),d1
                bmi.s   locret_50DD4
                move.w  #1,$4C(a5)
locret_50DD4:                                           ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+7C   j
                                        ; Boss_ValkirieForcePlayerToCeiling+8A   j
                rts
; ---------------------------------------------------------------------------
loc_50DD6:                                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+5E   j
                                        ; Boss_ValkirieForcePlayerToCeiling+72   j
                tst.w   $4C(a5)
                bne.s   locret_50DD4
                move.w  $10(a5),d0
                subq.w  #2,d0
                move.w  d0,(dword_FFA410).w
                clr.l   (dword_FFA418).w
                move.b  #1,(byte_FF8311).w
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   locret_50DD4
                bset    #6,$21(a5)
                tst.w   (word_FFDB20).w
                beq.s   locret_50E0A
                bset    #4,(word_FFDB22).w
locret_50E0A:                                           ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+B2   j
                rts
; End of function Boss_ValkirieForcePlayerToCeiling
; Manages timer-based screen positioning during Valkirie boss battle with vertical position updates
Boss_ValkirieScreenTimer:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_50E0C
                subq.w  #1,$1C(a5)
                bpl.s   loc_50E1A
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50E1A:                                              ; CODE XREF: Boss_ValkirieScreenTimer+4   j
                tst.w   (word_FFDC40).w
                beq.s   loc_50E2E
                move.w  (word_FFDC50).w,d0
                addi.w  #$30,d0                         ; '0'
                move.w  d0,$10(a5)
                bra.s   loc_50E36
; ---------------------------------------------------------------------------
loc_50E2E:                                              ; CODE XREF: Boss_ValkirieScreenTimer+12   j
                subi.l  #$A8000,$10(a5)
loc_50E36:                                              ; CODE XREF: Boss_ValkirieScreenTimer+20   j
                jmp     Pickup_Update
; End of function Boss_ValkirieScreenTimer
; Updates boss sprites
Boss_WolfGaropaUpdateSprites:                           ; CODE XREF: Boss_WolfGaropaMovement2+22   j  ; was: sub_50E3C
                move.w  #$40,6(a5)                      ; '@'
                clr.w   $26(a5)
                bset    #0,(byte_FFA272).w
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                jmp     Sprite_ClearObjectFlags
; End of function Boss_WolfGaropaUpdateSprites
; Boss damage handler
Boss_WolfGaropaDamage:                                  ; CODE XREF: Boss_WolfGaropaMovement2:loc_4F916   p  ; was: sub_50E5E
                tst.w   (word_FF8200).w
                beq.s   loc_50E66
                rts
; ---------------------------------------------------------------------------
loc_50E66:                                              ; CODE XREF: Boss_WolfGaropaDamage+4   j
                subq.w  #1,6(a5)
                bpl.s   loc_50E98
                move.w  #$10,4(a5)
                clr.w   8(a5)
                move.w  #$60,$11C(a5)                   ; '`'
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$3E8,d0
                move.w  #$41C,d1
                jsr     (Object_ClearAllExceptTypes).l
                moveq   #$1C,d0
                jmp     (Gfx_SetFadeParams).l
; ---------------------------------------------------------------------------
loc_50E98:                                              ; CODE XREF: Boss_WolfGaropaDamage+C   j
                cmpi.w  #$20,6(a5)                      ; ' '
                bpl.s   loc_50EBA
                addq.w  #1,$26(a5)
                move.w  $26(a5),d0
                cmpi.w  #$1C,d0
                bmi.s   loc_50EB0
                moveq   #$1C,d0
loc_50EB0:                                              ; CODE XREF: Boss_WolfGaropaDamage+4E   j
                jsr     (Gfx_SetFadeParams).l
                bra.w   loc_50EC0
; ---------------------------------------------------------------------------
loc_50EBA:                                              ; CODE XREF: Boss_WolfGaropaDamage+40   j
                jsr     (Gfx_UpdatePaletteFade).l
loc_50EC0:                                              ; CODE XREF: Boss_WolfGaropaDamage+58   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_50ED4
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
loc_50ED4:                                              ; CODE XREF: Boss_WolfGaropaDamage+6A   j
                btst    #0,(word_FFA000+1).w
                bne.s   locret_50F3C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_50F3C
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E96FC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_50F26
                move.l  #off_E953C,8(a0)
loc_50F26:                                              ; CODE XREF: Boss_WolfGaropaDamage+BE   j
                jsr     (Projectile_InitType88).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                subi.w  #8,d0
                move.w  d0,$18(a0)
locret_50F3C:                                           ; CODE XREF: Boss_WolfGaropaDamage+7C   j
                                        ; Boss_WolfGaropaDamage+84   j
                rts
; End of function Boss_WolfGaropaDamage
; Animation script interpreter
Boss_WolfGaropaAnimationScript:                         ; DATA XREF: Boss_WolfGaropaMovement2+50   o  ; was: sub_50F3E
                addq.w  #2,4(a5)
                move.w  #$A0,$11C(a5)
                move.b  #4,(byte_FFA95A).w
                jmp     Effect_InitPlayerSpawn
; End of function Boss_WolfGaropaAnimationScript
; Animation frame update
Boss_WolfGaropaAnimationUpdate:                         ; DATA XREF: Boss_WolfGaropaMovement2+52   o  ; was: sub_50F54
                cmpi.w  #$80,$11C(a5)
                bne.s   loc_50F62
                move.b  #1,(byte_FF830E).w
loc_50F62:                                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+6   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_50F70
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50F70:                                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+12   j
                subq.w  #2,$26(a5)
                move.w  $26(a5),d0
                bpl.s   loc_50F7C
                moveq   #0,d0
loc_50F7C:                                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+24   j
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_WolfGaropaAnimationUpdate
; Cleanup after defeat
Boss_WolfGaropaCleanup:                                 ; CODE XREF: Boss_WolfGaropaShootPattern5+C   p  ; was: sub_50F82
                move.w  $5FE(a5),d0
                bne.s   loc_50F8A
                rts
; ---------------------------------------------------------------------------
loc_50F8A:                                              ; CODE XREF: Boss_WolfGaropaCleanup+4   j
                bpl.s   loc_50F90
                addq.w  #1,d0
                bra.s   loc_50F92
; ---------------------------------------------------------------------------
loc_50F90:                                              ; CODE XREF: Boss_WolfGaropaCleanup:loc_50F8A   j
                subq.w  #1,d0
loc_50F92:                                              ; CODE XREF: Boss_WolfGaropaCleanup+C   j
                move.w  d0,$5FE(a5)
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$D,d5
                move.w  $65C(a5),d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_WolfGaropaCleanup
; State handler for Valkirie boss with palette fade initialization on state transitions
