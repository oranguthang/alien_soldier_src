Boss_JetsripperSpawnProjectile:                         ; CODE XREF: Boss_JetsripperUpdateMovement+6A   p  ; was: sub_362CE
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_36366
                move.w  #$1FC,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C400,$E(a0)
                move.w  #$F00,8(a0)
                move.w  #$F0F0,$A(a0)
                move.b  #$C0,$21(a0)
                move.b  #$10,$23(a0)
                move.l  #$F20EF20E,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$32,$26(a0)                    ; '2'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$20000,$4C(a0)
                move.l  #$40000,$54(a0)
                move.l  #$1000,$48(a0)
                move.l  #$2000,$50(a0)
                move.w  #9,$58(a0)
                move.w  (dword_FFA410).w,d0
                cmp.w   $10(a5),d0
                bpl.s   Boss_JetsripperSetProjectileVel
                neg.l   $48(a0)
                neg.l   $4C(a0)
; Sets projectile velocity based on boss position
Boss_JetsripperSetProjectileVel:                        ; CODE XREF: Boss_JetsripperSpawnProjectile+82   j  ; was: loc_3635A
                move.l  $4C(a0),$18(a0)
                move.l  $54(a0),$1C(a0)
locret_36366:                                           ; CODE XREF: Boss_JetsripperSpawnProjectile+6   j
                rts
; End of function Boss_JetsripperSpawnProjectile
; Updates projectile with bouncing logic
Boss_JetsripperProjectileUpdate:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_36368
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$8B0,d0
                bpl.s   loc_36382
                cmpi.w  #$6D0,d0
                bmi.s   loc_36382
                tst.w   (word_FF808C).w
                bmi.s   loc_3638A
loc_36382:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+C   j
                                        ; Boss_JetsripperProjectileUpdate+12   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_3638A:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+18   j
                bclr    #7,$22(a5)
                beq.s   loc_363C2
                bclr    #4,$22(a5)
                beq.s   loc_363B4
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_363B4
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (Effect_SpawnDestructionBlast).l
loc_363B4:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+30   j
                                        ; Boss_JetsripperProjectileUpdate+38   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
loc_363C2:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+28   j
                tst.w   $50(a5)
                bmi.s   loc_363EC
                cmpi.w  #$144,$14(a5)
                bmi.s   loc_363F4
loc_363D0:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+8A   j
                move.l  $4C(a5),$18(a5)
                neg.l   $54(a5)
                neg.l   $50(a5)
                move.l  $54(a5),$1C(a5)
                move.w  #9,$58(a5)
                bra.s   loc_363F4
; ---------------------------------------------------------------------------
loc_363EC:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+5E   j
                cmpi.w  #$CC,$14(a5)
                bmi.s   loc_363D0
loc_363F4:                                              ; CODE XREF: Boss_JetsripperProjectileUpdate+66   j
                                        ; Boss_JetsripperProjectileUpdate+82   j
                subq.w  #1,$58(a5)
                bmi.s   Boss_JetsripperProjectileFinal
                move.l  $48(a5),d0
                sub.l   d0,$18(a5)
                move.l  $50(a5),d0
                sub.l   d0,$1C(a5)
; Finalizes projectile update with palette masking
Boss_JetsripperProjectileFinal:                         ; CODE XREF: Boss_JetsripperProjectileUpdate+90   j  ; was: loc_3640A
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Boss_JetsripperProjectileUpdate
; Calculates distance to player for AI
Boss_CalculatePlayerDistance:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3641A
                move.w  (word_FFEC02).w,(word_FFEC04).w
                tst.w   4(a5)
                beq.s   loc_3648A
                tst.w   6(a5)
                beq.s   loc_3648A
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3644C
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3644C
                tst.w   (word_FF8200).w
                bne.s   loc_3644C
                bset    #0,(byte_FFA272).w
                bra.w   Boss_ShiperInitDefeat
; ---------------------------------------------------------------------------
loc_3644C:                                              ; CODE XREF: Boss_CalculatePlayerDistance+18   j
                                        ; Boss_CalculatePlayerDistance+20   j
                jsr     (Gfx_InitPaletteFade).l
                clr.b   $49(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$58(a5)
                addi.l  #$6000,$7C(a5)
                bmi.s   loc_3648A
                cmpi.w  #$150,$74(a5)
                bmi.s   loc_3648A
                clr.l   $7C(a5)
                move.w  #$150,$74(a5)
                tst.w   (word_FFA010).w
                bne.s   loc_3648A
                move.w  #1,(word_FFA010).w
loc_3648A:                                              ; CODE XREF: Boss_CalculatePlayerDistance+A   j
                                        ; Boss_CalculatePlayerDistance+10   j
                move.w  4(a5),d0
                movea.w off_3649A(pc,d0.w),a0
                adda.l  #Boss_CheckPlayerProximity,a0
                jmp     (a0)
; End of function Boss_CalculatePlayerDistance
; ---------------------------------------------------------------------------
off_3649A:      dc.w    Boss_CheckPlayerProximity-Boss_CheckPlayerProximity
                                        ; DATA XREF: Boss_CalculatePlayerDistance+74   r
                dc.w    Boss_ShiperInit-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperLoadGraphics-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperSetupState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperAttackDecision-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperAttackDecision_UpdateAndSpawn-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRiseState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperHoverState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDecelerateVertical-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRetreatLogic-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperRiseState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperHoverState-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperWaitDescend-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatWait-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDeathHandler-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperPhaseCheck-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatSequence-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperDefeatFadeOut-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperCheckHealthTransition-Boss_CheckPlayerProximity
                dc.w    Boss_ShiperCheckHealthTransition_WaitFade-Boss_CheckPlayerProximity

; Checks if player is within proximity range
Boss_CheckPlayerProximity:                              ; DATA XREF: Boss_CalculatePlayerDistance+78   o  ; was: sub_364C2
                                        ; ROM:off_3649A   o
                addq.w  #2,4(a5)
                addq.w  #1,6(a5)
                move.l  #word_364F4,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #0,(word_FFA948).w
                move.w  #$13,(word_FFA944).w
                move.w  #$24,d0                         ; '$'
                move.w  #$134,d1
                jmp     Object_ClearAllExceptTypes
; End of function Boss_CheckPlayerProximity
nullsub_77:
                rts
; End of function nullsub_77
; ---------------------------------------------------------------------------
word_364F4:     dc.w    $FFFF, $7000, $FFFF, $6800, $FFFF, $2000, 0, $4000
                                        ; DATA XREF: Boss_CheckPlayerProximity+8   o

; Initializes Shiper Honeyviper boss by processing pointer data and setting up trigonometric tables
