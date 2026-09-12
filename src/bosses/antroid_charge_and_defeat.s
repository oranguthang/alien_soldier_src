; Antroid charge, ram, and defeat states

; Initializes ram-attack state $1E and selects its horizontal direction
Boss_AntroidBeginRamAttack:                             ; CODE XREF: Boss_AntroidMainHandler+22   j  ; was: sub_37D3A
                move.w  #$1E,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #1,$11C(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$20000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$CC0,$BC(a5)
                bmi.w   Boss_AntroidBeginRamAttackUpdateFacing
                neg.l   $18(a5)
                clr.w   $54(a5)
Boss_AntroidBeginRamAttackUpdateFacing:                 ; CODE XREF: Boss_AntroidBeginRamAttack+50   j  ; was: loc_37D96
                bsr.w   Boss_AntroidFacePlayer
; End of function Boss_AntroidBeginRamAttack
; Boss ram attack with collision
Boss_AntroidRamAttack:                                  ; DATA XREF: ROM:0003752C   o  ; was: sub_37D9A
                cmpi.w  #$180,$56(a5)
                beq.s   Boss_AntroidRamAttackUpdate
                subq.w  #8,$56(a5)
                andi.w  #$1FE,$56(a5)
Boss_AntroidRamAttackUpdate:                            ; CODE XREF: Boss_AntroidRamAttack+6   j  ; was: loc_37DAC
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_AntroidUpdateRamAttackPose
                addi.l  #$4000,$1C(a5)
                bmi.s   Boss_AntroidRamAttackReturn
                cmpi.w  #$148,$14(a5)
                bmi.w   Boss_AntroidRamAttackReturn
                move.w  #5,(PlaneAShakeLevel).w
                move.w  #2,(PlaneBShakeLevel).w
                subq.w  #1,$11C(a5)
                bpl.w   Boss_AntroidRamAttackRebound
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$148,$14(a5)
Boss_AntroidRamAttackReturn:                            ; CODE XREF: Boss_AntroidRamAttack+24   j  ; was: locret_37DF4
                                        ; Boss_AntroidRamAttack+2C   j
                rts
; ---------------------------------------------------------------------------
Boss_AntroidRamAttackRebound:                           ; CODE XREF: Boss_AntroidRamAttack+40   j  ; was: loc_37DF6
                move.l  #$FFFE0000,$1C(a5)
                rts
; End of function Boss_AntroidRamAttack
; Boss death state with palette fade and timer progression
Boss_AntroidDeathFadeState:                             ; DATA XREF: ROM:0003752E   o  ; was: sub_37E00
                jsr     (Gfx_UpdatePaletteFade).l
                addq.w  #1,$11C(a5)
                move.w  $11C(a5),d0
                cmpi.w  #$A0,d0
                bpl.s   Boss_AntroidEnterDefeatedState
                subi.w  #$90,d0
                bmi.s   Boss_AntroidDeathFadeUpdateEffects
                bsr.w   Boss_AntroidSetDeathFadeParams
Boss_AntroidDeathFadeUpdateEffects:                     ; CODE XREF: Boss_AntroidDeathFadeState+18   j  ; was: loc_37E1E
                move.w  #4,(PlaneAShakeLevel).w
                move.w  #2,(PlaneBShakeLevel).w
; End of function Boss_AntroidDeathFadeState
; Updates the ram-attack pose, debris, and alternating sprite flip
Boss_AntroidUpdateRamAttackPose:                        ; CODE XREF: Boss_AntroidRamAttack+18   p  ; was: sub_37E2A
                bsr.w   Boss_AntroidSpawnRamDebris
                lea     Boss_AntroidRamPoseCommands(pc),a1
                nop
                jsr     Boss_AntroidUpdatePoseAnimation(pc)  ; (pc)
                nop
                bsr.w   Boss_AntroidRenderPose
                move.l  #Boss_AntroidSpriteMapping00,$C8(a5)
                bset    #4,$CE(a5)
                eori.w  #$800,$CE(a5)
                rts
; End of function Boss_AntroidUpdateRamAttackPose
; Transitions boss to defeated state clearing objects
Boss_AntroidEnterDefeatedState:                         ; CODE XREF: Boss_AntroidDeathFadeState+12   j  ; was: sub_37E54
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$14,6(a5)
                moveq   #$30,d0                         ; '0'
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
; Death sequence timer with fade effect
Boss_AntroidDeathTimer:                                 ; DATA XREF: ROM:00037530   o  ; was: sub_37E6C
                subq.w  #1,6(a5)
                move.w  6(a5),d0
                bpl.s   Boss_AntroidDeathTimerUpdateFade
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Boss_AntroidDeathTimerUpdateFade:                       ; CODE XREF: Boss_AntroidDeathTimer+8   j  ; was: loc_37E7E
                cmpi.w  #$10,d0
                bmi.w   Boss_AntroidSetDeathFadeParams
                moveq   #$10,d0
                bra.w   Boss_AntroidSetDeathFadeParams
; End of function Boss_AntroidDeathTimer
