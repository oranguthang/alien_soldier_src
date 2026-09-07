Enemy_InitDestructionParticle:                          ; CODE XREF: Enemy_DestructionParticleMain+6   p  ; was: sub_2BAB4
                addq.w  #2,4(a5)
                move.w  #$E700,2(a5)
                move.l  #off_E97B8,8(a5)
                clr.w   $C(a5)
                move.w  #$480,$E(a5)
                clr.b   $20(a5)
                move.b  #$C0,$21(a5)
                move.b  #$30,$23(a5)                    ; '0'
                move.l  #$F808F808,$2C(a5)
                move.l  #$FC04FC04,$28(a5)
                rts
; End of function Enemy_InitDestructionParticle
; Destruction particle handler
Stage25_DestructionParticle:                            ; CODE XREF: Enemy_DestructionParticleMain:loc_2BB56   j  ; was: sub_2BAF2
                bclr    #7,$22(a5)
                beq.s   Sprite_ClearHorizontalFlip
                bclr    #4,$22(a5)
                bne.s   Sprite_ClearHorizontalFlip
                move.b  #$A7,d0
                jsr     (Sound_PlaySFX).l
                tst.w   (word_FFA216).w
                beq.w   loc_2BB32
                bmi.w   loc_2BB32
                addi.w  #$20,(word_FFA218).w            ; ' '
                cmpi.w  #$400,(word_FFA218).w
                bmi.s   loc_2BB2C
                move.w  #$400,(word_FFA218).w
loc_2BB2C:                                              ; CODE XREF: Stage25_DestructionParticle+32   j
                move.w  (word_FFA218).w,(word_FFA216).w
loc_2BB32:                                              ; CODE XREF: Stage25_DestructionParticle+1E   j
                                        ; Stage25_DestructionParticle+22   j
                move.w  #$32C,(a5)
                clr.b   $21(a5)
                rts
; ---------------------------------------------------------------------------
; Clears horizontal flip bit and applies screen flip direction
Sprite_ClearHorizontalFlip:                             ; CODE XREF: Stage25_DestructionParticle+6   j  ; was: loc_2BB3C
                                        ; Stage25_DestructionParticle+E   j
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Stage25_DestructionParticle
; Main handler for destruction particle effect
Enemy_DestructionParticleMain:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB4C
                tst.w   4(a5)
                bne.s   Enemy_InitDestructionHandler
                bsr.w   Enemy_InitDestructionParticle
; Initializes destruction particle handler if not yet initialized
Enemy_InitDestructionHandler:                           ; CODE XREF: Enemy_DestructionParticleMain+4   j  ; was: loc_2BB56
                bra.w   Stage25_DestructionParticle
; End of function Enemy_DestructionParticleMain
; Screen shake effect
Stage25_ScreenShake:                                    ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB5A
                move.w  #$30,(word_FF813C).w            ; '0'
                bset    #4,2(a5)
                move.b  #$1B,d0
                jmp     (Sound_PlaySFX).l
; End of function Stage25_ScreenShake
; Plays enemy death sound and sets timer
Enemy_PlayDeathSound:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB70
                move.w  #$30,(word_FF813C).w            ; '0'
                bset    #4,2(a5)
                move.b  #$1C,d0
                jmp     (Sound_PlaySFX).l
; End of function Enemy_PlayDeathSound
; Initializes enemy state flags and properties
