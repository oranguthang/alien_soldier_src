Effect_InitStage25DestructionParticle:                  ; CODE XREF: Effect_RunStage25DestructionParticle+6   p  ; was: sub_2BAB4
                addq.w  #2,4(a5)
                move.w  #$E700,2(a5)
                move.l  #SharedCombatSpriteAnimation26,8(a5)
                clr.w   $C(a5)
                move.w  #$480,$E(a5)
                clr.b   $20(a5)
                move.b  #$C0,$21(a5)
                move.b  #$30,$23(a5)                    ; '0'
                move.l  #$F808F808,$2C(a5)
                move.l  #$FC04FC04,$28(a5)
                rts
; End of function Effect_InitStage25DestructionParticle
; Destruction particle handler
Effect_UpdateStage25DestructionParticle:                ; CODE XREF: Effect_RunStage25DestructionParticle:loc_2BB56   j  ; was: sub_2BAF2
                bclr    #7,$22(a5)
                beq.s   Effect_ApplyStage25ParticleOrientation
                bclr    #4,$22(a5)
                bne.s   Effect_ApplyStage25ParticleOrientation
                move.b  #$A7,d0
                jsr     (Sound_PlaySFX).l
                tst.w   (PlayerHealth).w
                beq.w   Effect_UpdateStage25DestructionParticle_ConvertObject
                bmi.w   Effect_UpdateStage25DestructionParticle_ConvertObject
                addi.w  #$20,(PlayerMaxHealth).w        ; ' '
                cmpi.w  #$400,(PlayerMaxHealth).w
                bmi.s   Effect_UpdateStage25DestructionParticle_ApplyShake
                move.w  #$400,(PlayerMaxHealth).w
Effect_UpdateStage25DestructionParticle_ApplyShake:     ; CODE XREF: Effect_UpdateStage25DestructionParticle+32   j  ; was: loc_2BB2C
                move.w  (PlayerMaxHealth).w,(PlayerHealth).w
Effect_UpdateStage25DestructionParticle_ConvertObject:  ; CODE XREF: Effect_UpdateStage25DestructionParticle+1E   j  ; was: loc_2BB32
                                        ; Effect_UpdateStage25DestructionParticle+22   j
                move.w  #$32C,(a5)
                clr.b   $21(a5)
                rts
; ---------------------------------------------------------------------------
; Clears horizontal flip bit and applies screen flip direction
Effect_ApplyStage25ParticleOrientation:                 ; CODE XREF: Effect_UpdateStage25DestructionParticle+6   j  ; was: loc_2BB3C
                                        ; Effect_UpdateStage25DestructionParticle+E   j
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Effect_UpdateStage25DestructionParticle
; Main handler for destruction particle effect
Effect_RunStage25DestructionParticle:                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BB4C
                tst.w   4(a5)
                bne.s   Effect_RunStage25DestructionParticle_Update
                bsr.w   Effect_InitStage25DestructionParticle
; Initializes destruction particle handler if not yet initialized
Effect_RunStage25DestructionParticle_Update:            ; CODE XREF: Effect_RunStage25DestructionParticle+4   j  ; was: loc_2BB56
                bra.w   Effect_UpdateStage25DestructionParticle
; End of function Effect_RunStage25DestructionParticle
; Screen shake effect
Effect_TriggerStage25Shake:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BB5A
                move.w  #$30,(word_FF813C).w            ; '0'
                bset    #4,2(a5)
                move.b  #$1B,d0
                jmp     (Sound_PlaySFX).l
; End of function Effect_TriggerStage25Shake
; Triggers the Stage 25 death shake and sound, then retires the object
Effect_TriggerStage25DeathSound:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BB70
                move.w  #$30,(word_FF813C).w            ; '0'
                bset    #4,2(a5)
                move.b  #$1C,d0
                jmp     (Sound_PlaySFX).l
; End of function Effect_TriggerStage25DeathSound
