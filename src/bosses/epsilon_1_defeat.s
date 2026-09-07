Boss_Epsilon1ResetScrollingPhase:                       ; DATA XREF: ROM:00045D3E   o  ; was: sub_467D8
                clr.w   (dword_FF9410).w
                move.w  #0,(dword_FF9414+2).w
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,(dword_FFC69C).w
                bclr    #0,(byte_FF8308).w
                bne.s   loc_467FE
                move.w  #6,(dword_FFC698).w
                rts
; ---------------------------------------------------------------------------
loc_467FE:                                              ; CODE XREF: Boss_Epsilon1ResetScrollingPhase+1C   j
                move.w  #$FFFA,(dword_FFC698).w
                rts
; End of function Boss_Epsilon1ResetScrollingPhase
; Executes attack pattern 2 and advances phase
Boss_Epsilon1AttackPattern2Transition:                  ; DATA XREF: ROM:00045D40   o  ; was: sub_46806
                bsr.w   Boss_Epsilon1AttackPattern2
                bne.s   locret_46816
                move.w  #$14,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_46816:                                           ; CODE XREF: Boss_Epsilon1AttackPattern2Transition+4   j
                rts
; End of function Boss_Epsilon1AttackPattern2Transition
; Checks Y position bounds and reverses velocity
Boss_Epsilon1BoundsCheckReverse:                        ; DATA XREF: ROM:00045D42   o  ; was: sub_46818
                cmpi.w  #$180,$4E(a5)
                bhi.s   loc_4682A
                cmpi.w  #$C0,$4E(a5)
                bcs.s   loc_4682A
                rts
; ---------------------------------------------------------------------------
loc_4682A:                                              ; CODE XREF: Boss_Epsilon1BoundsCheckReverse+6   j
                                        ; Boss_Epsilon1BoundsCheckReverse+E   j
                move.w  #8,(word_FFA010).w
                move.l  (dword_FFC698).w,d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,(dword_FFC698).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1BoundsCheckReverse
; Accelerates scrolling until threshold reached
Boss_Epsilon1ScrollAccelerationPhase:                   ; DATA XREF: ROM:00045D44   o  ; was: sub_46842
                addi.l  #$2000,(dword_FFC69C).w
                cmpi.w  #$100,(dword_FFC694).w
                bcs.s   locret_46864
                clr.l   (dword_FFC69C).w
                clr.l   (dword_FFC698).w
                move.w  #$60,$48(a5)                    ; '`'
                addq.w  #2,4(a5)
locret_46864:                                           ; CODE XREF: Boss_Epsilon1ScrollAccelerationPhase+E   j
                rts
; End of function Boss_Epsilon1ScrollAccelerationPhase
; Delays for timer countdown then advances phase
Boss_Epsilon1DelayTimer:                                ; DATA XREF: ROM:00045D46   o  ; was: sub_46866
                subq.w  #1,$48(a5)
                bne.s   locret_46876
                move.w  #0,$58(a5)
                addq.w  #2,4(a5)
locret_46876:                                           ; CODE XREF: Boss_Epsilon1DelayTimer+4   j
                rts
; End of function Boss_Epsilon1DelayTimer
; Advances when boss health drops below 64
Boss_Epsilon1WaitForLowHealth:                          ; DATA XREF: ROM:00045D48   o  ; was: sub_46878
                bsr.w   Boss_Epsilon1InitProjectileArray
                cmpi.w  #$40,(dword_FFC694).w           ; '@'
                bcc.w   locret_4688A
                addq.w  #2,4(a5)
locret_4688A:                                           ; CODE XREF: Boss_Epsilon1WaitForLowHealth+A   j
                rts
; End of function Boss_Epsilon1WaitForLowHealth
; Clears bit flags and returns to phase 18
Boss_Epsilon1ClearPhaseFlags:                           ; DATA XREF: ROM:00045D4A   o  ; was: sub_4688C
                bclr    #2,(byte_FF8308).w
                bclr    #2,$4C(a5)
                move.w  #$12,4(a5)
                rts
; End of function Boss_Epsilon1ClearPhaseFlags
; Defeat explosion effect 1
Boss_Epsilon1DefeatExplosion1:                          ; DATA XREF: ROM:00045D4C   o  ; was: sub_468A0
                clr.b   $21(a5)
                clr.b   (byte_FFC701).w
                clr.b   (byte_FFC761).w
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.b  #1,(byte_FF830E).w
                rts
; End of function Boss_Epsilon1DefeatExplosion1
; Defeat explosion effect 2
Boss_Epsilon1DefeatExplosion2:                          ; DATA XREF: ROM:00045D4E   o  ; was: sub_468BE
                subq.w  #1,$48(a5)
                bpl.s   locret_46910
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w #(word_FFC740-M68K_RAM),a1
                cmpi.w  #6,4(a0)
                bne.s   locret_46910
                cmpi.w  #6,4(a1)
                bne.s   locret_46910
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                move.w  d0,$48(a0)
                addq.w  #2,4(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$7F,d0
                move.w  d0,$48(a1)
                addq.w  #2,4(a1)
                addq.w  #2,4(a5)
                move.b  #$52,d0                         ; 'R'
                jsr     (Sound_PlaySFX).l
                move.w  #$40,$48(a5)                    ; '@'
locret_46910:                                           ; CODE XREF: Boss_Epsilon1DefeatExplosion2+4   j
                                        ; Boss_Epsilon1DefeatExplosion2+14   j
                rts
; End of function Boss_Epsilon1DefeatExplosion2
; Defeat explosion effect 3
Boss_Epsilon1DefeatExplosion3:                          ; DATA XREF: ROM:00045D50   o  ; was: sub_46912
                subq.w  #1,$48(a5)
                bpl.w   locret_46962
                addi.l  #$2000,$1C(a5)
                cmpi.w  #$148,$14(a5)
                bgt.s   loc_46964
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_46962
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_46962
                jsr     (Projectile_InitType88).l
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFF,$1C(a0)
                move.b  $20(a5),$20(a0)
locret_46962:                                           ; CODE XREF: Boss_Epsilon1DefeatExplosion3+4   j
                                        ; Boss_Epsilon1DefeatExplosion3+20   j
                rts
; ---------------------------------------------------------------------------
loc_46964:                                              ; CODE XREF: Boss_Epsilon1DefeatExplosion3+16   j
                move.l  #$1400000,$14(a5)
                clr.l   $1C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
                move.b  #$AC,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_Epsilon1DefeatExplosion3
; Screen shake during defeat
Boss_Epsilon1DefeatShake:                               ; DATA XREF: ROM:00045D52   o  ; was: sub_46986
                subq.w  #1,$48(a5)
                bpl.s   locret_469AE
                move.l  #off_E953C,8(a5)
                move.w  #$480,$E(a5)
                move.w  #$EC80,2(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_ExplodeOnImpact).l
locret_469AE:                                           ; CODE XREF: Boss_Epsilon1DefeatShake+4   j
                rts
; End of function Boss_Epsilon1DefeatShake
; Fade out during defeat
Boss_Epsilon1DefeatFade:                                ; DATA XREF: ROM:00045D54   o  ; was: sub_469B0
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_469D4
                move.w  #$C80,2(a5)
                move.w  (dword_FFC694).w,d0
                addi.w  #$10,d0
                move.w  d0,$14(a5)
                move.w  (dword_FFC690).w,$10(a5)
                addq.w  #2,4(a5)
locret_469D4:                                           ; CODE XREF: Boss_Epsilon1DefeatFade+6   j
                rts
; End of function Boss_Epsilon1DefeatFade
; Flash effect during defeat
Boss_Epsilon1DefeatFlash:                               ; DATA XREF: ROM:00045D56   o  ; was: sub_469D6
                move.w  #5,$4A(a5)
                addq.w  #2,4(a5)
; Palette fade loop during defeat flash sequence
Boss_Epsilon1Defeat_FlashLoop:                          ; DATA XREF: ROM:00045D58   o  ; was: loc_469E0
                jsr     (Gfx_UpdatePaletteFade).l
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     word_46A1E(pc),a0
                nop
                movea.w (a0,d0.w),a1
                movea.w $C(a0,d0.w),a2
                cmpi.w  #$C,4(a1)
                bne.s   locret_46A1C
                cmpi.w  #$C,4(a2)
                bne.s   locret_46A1C
                addq.w  #2,4(a1)
                addq.w  #2,4(a2)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_46A1C:                                           ; CODE XREF: Boss_Epsilon1DefeatFlash+2A   j
                                        ; Boss_Epsilon1DefeatFlash+32   j
                rts
; End of function Boss_Epsilon1DefeatFlash
; ---------------------------------------------------------------------------
word_46A1E:     dc.w    $C800, $C860, $C8C0, $C920, $C980, $C9E0, $CA40, $CAA0, $CB00, $CB60, $CBC0, $CC20
                                        ; DATA XREF: Boss_Epsilon1DefeatFlash+16   o
                                        ; Boss_Epsilon1PartDamageFlash+6   o

; Boss breakup animation
Boss_Epsilon1DefeatBreakup:                             ; DATA XREF: ROM:00045D5A   o  ; was: sub_46A36
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_46A52
                subq.w  #1,$4A(a5)
                bmi.s   loc_46A4E
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_46A4E:                                              ; CODE XREF: Boss_Epsilon1DefeatBreakup+10   j
                addq.w  #2,4(a5)
locret_46A52:                                           ; CODE XREF: Boss_Epsilon1DefeatBreakup+A   j
                rts
; End of function Boss_Epsilon1DefeatBreakup
; Part damage flash effect
Boss_Epsilon1PartDamageFlash:                           ; DATA XREF: ROM:00045D5C   o  ; was: sub_46A54
                jsr     (Gfx_UpdatePaletteFade).l
                lea     word_46A1E(pc),a0
                movea.w (a0),a1
                movea.w $C(a0),a2
                cmpi.w  #$12,4(a1)
                bne.s   locret_46A7E
                cmpi.w  #$12,4(a2)
                bne.s   locret_46A7E
                move.w  #$C0,$48(a5)
                addq.w  #2,4(a5)
locret_46A7E:                                           ; CODE XREF: Boss_Epsilon1PartDamageFlash+16   j
                                        ; Boss_Epsilon1PartDamageFlash+1E   j
                rts
; End of function Boss_Epsilon1PartDamageFlash
; Part invulnerability state
Boss_Epsilon1PartInvulnerable:                          ; DATA XREF: ROM:00045D5E   o  ; was: sub_46A80
                jsr     (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_46A90
                addq.w  #2,4(a5)
locret_46A90:                                           ; CODE XREF: Boss_Epsilon1PartInvulnerable+A   j
                rts
; End of function Boss_Epsilon1PartInvulnerable
; Checks if core is vulnerable
Boss_Epsilon1CoreVulnerableCheck:                       ; DATA XREF: ROM:00045D60   o  ; was: sub_46A92
                jsr     (Boss_SpawnExplosionDebris).l
                bsr.s   Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46ABA
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46ABA
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   locret_46ABA
                addq.w  #2,4(a5)
locret_46ABA:                                           ; CODE XREF: Boss_Epsilon1CoreVulnerableCheck+E   j
                                        ; Boss_Epsilon1CoreVulnerableCheck+16   j
                rts
; End of function Boss_Epsilon1CoreVulnerableCheck
; Updates health bar display
Boss_Epsilon1UpdateHealthDisplay:                       ; CODE XREF: Boss_Epsilon1BattleSetup   p  ; was: sub_46ABC
                                        ; Boss_Epsilon1CoreVulnerableCheck+6   p
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Boss_Epsilon1UpdateHealthDisplay
; Damage flash animation
Boss_Epsilon1DamageFlash:                               ; DATA XREF: ROM:00045D62   o  ; was: sub_46AD8
                bsr.s   Boss_Epsilon1UpdateHealthDisplay
                tst.b   (word_FFF720).w
                bmi.s   locret_46AF0
                move.w  #$264,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                addq.w  #2,4(a5)
locret_46AF0:                                           ; CODE XREF: Boss_Epsilon1DamageFlash+6   j
                rts
; End of function Boss_Epsilon1DamageFlash
; Health bar color calculation
Boss_Epsilon1HealthBarColor:                            ; DATA XREF: ROM:00045D64   o  ; was: sub_46AF2
                bsr.w   Boss_Epsilon1UpdateHealthDisplay
                btst    #0,(word_FFA000+1).w
                bne.s   locret_46B10
                btst    #1,(word_FFA000+1).w
                bne.s   locret_46B10
                subq.w  #1,$48(a5)
                bne.s   locret_46B10
                addq.w  #2,4(a5)
locret_46B10:                                           ; CODE XREF: Boss_Epsilon1HealthBarColor+A   j
                                        ; Boss_Epsilon1HealthBarColor+12   j
                rts
; End of function Boss_Epsilon1HealthBarColor
; Checks if part has shield
Boss_Epsilon1PartShieldCheck:                           ; DATA XREF: ROM:00045D66   o  ; was: sub_46B12
                tst.b   (word_FFF720).w
                bmi.s   locret_46B1C
                addq.w  #2,4(a5)
locret_46B1C:                                           ; CODE XREF: Boss_Epsilon1PartShieldCheck+4   j
                rts
; End of function Boss_Epsilon1PartShieldCheck
; Shield breaking animation
Boss_Epsilon1ShieldBreak:                               ; DATA XREF: ROM:00045D68   o  ; was: sub_46B1E
                tst.b   (word_FFF720).w
                bmi.s   locret_46B28
                addq.w  #2,4(a5)
locret_46B28:                                           ; CODE XREF: Boss_Epsilon1ShieldBreak+4   j
                rts
; End of function Boss_Epsilon1ShieldBreak
; Shield regeneration logic
Boss_Epsilon1ShieldRegenerate:                          ; DATA XREF: ROM:00045D6A   o  ; was: sub_46B2A
                move.b  #4,(byte_FFA95A).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_Epsilon1ShieldRegenerate
; Transition to final phase
Boss_Epsilon1FinalPhaseTransition:                      ; DATA XREF: ROM:00045D6C   o  ; was: sub_46B3C
                subq.w  #1,$48(a5)
                bne.s   locret_46B58
                move.w  #$2E,(word_FF80C2).w            ; '.'
                move.b  #1,(byte_FF80FA).w
                move.w  #$1E0,$48(a5)
                addq.w  #2,4(a5)
locret_46B58:                                           ; CODE XREF: Boss_Epsilon1FinalPhaseTransition+4   j
                rts
; End of function Boss_Epsilon1FinalPhaseTransition
; Planet fade in effect
Cutscene_PlanetFadeIn:                                  ; DATA XREF: ROM:00045D6E   o  ; was: sub_46B5A
                subq.w  #1,$48(a5)
                bne.s   locret_46B62
                clr.w   (a5)
locret_46B62:                                           ; CODE XREF: Cutscene_PlanetFadeIn+4   j
                rts
; End of function Cutscene_PlanetFadeIn
; Boss rotation state dispatcher
Boss_Epsilon1RotationDispatcher:                        ; CODE XREF: Boss_Epsilon1Main+124   p  ; was: sub_46B64
                move.w  (dword_FF9414+2).w,d0
                add.w   d0,d0
                lea     (word_FF9480).w,a0
                move.w  (a0,d0.w),$56(a5)
                move.w  (dword_FF9418+2).w,d0
                lea     off_46B80(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1RotationDispatcher
; ---------------------------------------------------------------------------
off_46B80:      dc.w    Boss_Epsilon1StartRotation-*    ; DATA XREF: Boss_Epsilon1RotationDispatcher+14   o
                dc.w    Boss_Epsilon1RotationEnd-*
                dc.w    Boss_Epsilon1RotateRight-*
                dc.w    Boss_Epsilon1RotateLeft-*
                dc.w    Boss_Epsilon1RotateReturn-*

; Starts rotation with sound
Boss_Epsilon1StartRotation:                             ; DATA XREF: ROM:off_46B80   o  ; was: sub_46B8A
                bclr    #6,$22(a5)
                bne.s   loc_46BD2
                move.w  (word_FFA000).w,d0
loc_46B96:
                move.w  d0,d1
                andi.w  #$FF,d0
                beq.s   loc_46BAA
                addi.w  #$10,d1
                andi.w  #$FF,d1
                beq.s   loc_46BAA
locret_46BA8:                                           ; CODE XREF: Boss_Epsilon1StartRotation+3A   j
                rts
; ---------------------------------------------------------------------------
loc_46BAA:                                              ; CODE XREF: Boss_Epsilon1StartRotation+12   j
                                        ; Boss_Epsilon1StartRotation+1C   j
                move.l  #word_EC05E,8(a5)
                move.w  #8,(dword_FF9420+2).w
                move.w  #2,(dword_FF9418+2).w
                cmpi.w  #$10,4(a5)
                bls.s   locret_46BA8
                move.b  #$51,d0                         ; 'Q'
                jsr     (Sound_PlaySFX).l
                rts
; ---------------------------------------------------------------------------
loc_46BD2:                                              ; CODE XREF: Boss_Epsilon1StartRotation+6   j
                move.l  #word_EC05E,8(a5)
                move.w  #2,(dword_FF9420+2).w
                move.w  #4,(dword_FF9418+2).w
                move.b  #$52,d0                         ; 'R'
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_Epsilon1StartRotation
; End rotation state
Boss_Epsilon1RotationEnd:                               ; DATA XREF: ROM:00046B82   o  ; was: sub_46BF2
                subq.w  #1,(dword_FF9420+2).w
                bne.s   locret_46C06
                move.l  #word_EC046,8(a5)
                move.w  #0,(dword_FF9418+2).w
locret_46C06:                                           ; CODE XREF: Boss_Epsilon1RotationEnd+4   j
                rts
; End of function Boss_Epsilon1RotationEnd
; Rotate right with increment
Boss_Epsilon1RotateRight:                               ; DATA XREF: ROM:00046B84   o  ; was: sub_46C08
                addq.w  #2,(word_FFC6CC).w
                cmpi.w  #8,(word_FFC6CC).w
                bne.s   locret_46C18
                addq.w  #2,(dword_FF9418+2).w
locret_46C18:                                           ; CODE XREF: Boss_Epsilon1RotateRight+A   j
                rts
; End of function Boss_Epsilon1RotateRight
; Rotate left with decrement
Boss_Epsilon1RotateLeft:                                ; DATA XREF: ROM:00046B86   o  ; was: sub_46C1A
                subq.w  #2,(word_FFC6CC).w
                cmpi.w  #$FFF8,(word_FFC6CC).w
                bne.s   locret_46C2A
                addq.w  #2,(dword_FF9418+2).w
locret_46C2A:                                           ; CODE XREF: Boss_Epsilon1RotateLeft+A   j
                rts
; End of function Boss_Epsilon1RotateLeft
; Return rotation to center
Boss_Epsilon1RotateReturn:                              ; DATA XREF: ROM:00046B88   o  ; was: sub_46C2C
                addq.w  #2,(word_FFC6CC).w
                cmpi.w  #0,(word_FFC6CC).w
                bne.s   locret_46C5A
                subq.w  #1,(dword_FF9420+2).w
                beq.s   loc_46C46
                move.w  #4,(dword_FF9418+2).w
                rts
; ---------------------------------------------------------------------------
loc_46C46:                                              ; CODE XREF: Boss_Epsilon1RotateReturn+10   j
                move.l  #word_EC046,8(a5)
                bclr    #6,$22(a5)
                move.w  #0,(dword_FF9418+2).w
locret_46C5A:                                           ; CODE XREF: Boss_Epsilon1RotateReturn+A   j
                rts
; End of function Boss_Epsilon1RotateReturn
; Boss part state handler
Boss_Epsilon1PartHandler:                               ; CODE XREF: Boss_Epsilon1Main+1CC   p  ; was: sub_46C5C
                                        ; Boss_Epsilon1Main+200   p
                btst    #0,(word_FFC66C).w
                beq.s   loc_46C72
                cmpi.w  #6,4(a1)
                bcc.s   loc_46C72
                move.w  #6,4(a1)
loc_46C72:                                              ; CODE XREF: Boss_Epsilon1PartHandler+6   j
                                        ; Boss_Epsilon1PartHandler+E   j
                move.w  4(a1),d0
                lea     off_46C7E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_Epsilon1PartHandler
; ---------------------------------------------------------------------------
off_46C7E:      dc.w    Boss_Epsilon1PartInit-*         ; DATA XREF: Boss_Epsilon1PartHandler+1A   o
                dc.w    Boss_Epsilon1PartUpdate-*
                dc.w    Boss_Epsilon1PartDestroy-*
                dc.w    nullsub_86-*
                dc.w    Boss_Epsilon1PartDeathInit-*
                dc.w    Boss_Epsilon1PartDeathFall-*
                dc.w    Boss_Epsilon1PartDeathExplode-*
                dc.w    Boss_Epsilon1PartDeathCleanup-*

; Part initialization state
Boss_Epsilon1PartInit:                                  ; DATA XREF: ROM:off_46C7E   o  ; was: sub_46C8E
                move.w  ((loc_46B96-*)).w,d0
                andi.w  #$1F,d0
                beq.s   loc_46CA0
                bclr    #3,$22(a1)
                beq.s   locret_46CA4
loc_46CA0:                                              ; CODE XREF: Boss_Epsilon1PartInit+8   j
                addq.w  #2,4(a1)
locret_46CA4:                                           ; CODE XREF: Boss_Epsilon1PartInit+10   j
                rts
; End of function Boss_Epsilon1PartInit
; Part update and movement
Boss_Epsilon1PartUpdate:                                ; DATA XREF: ROM:00046C80   o  ; was: sub_46CA6
                addq.w  #4,$50(a1)
                cmpi.w  #$20,$50(a1)                    ; ' '
                bne.s   locret_46CB6
                addq.w  #2,4(a1)
locret_46CB6:                                           ; CODE XREF: Boss_Epsilon1PartUpdate+A   j
                rts
; End of function Boss_Epsilon1PartUpdate
; Part destruction state
Boss_Epsilon1PartDestroy:                               ; DATA XREF: ROM:00046C82   o  ; was: sub_46CB8
                subq.w  #4,$50(a1)
                bne.s   locret_46CC8
                bclr    #6,$22(a1)
                clr.w   4(a1)
locret_46CC8:                                           ; CODE XREF: Boss_Epsilon1PartDestroy+4   j
                rts
; End of function Boss_Epsilon1PartDestroy
nullsub_86:                                             ; DATA XREF: ROM:00046C84   o
                rts
; End of function nullsub_86

; Part death initialization
Boss_Epsilon1PartDeathInit:                             ; DATA XREF: ROM:00046C86   o  ; was: sub_46CCC
                subq.w  #1,$48(a1)
                bpl.s   locret_46CEE
                move.w  #$EC80,2(a1)
                move.l  #off_E953C,8(a1)
                move.w  #$480,$E(a1)
                clr.w   $C(a1)
                addq.w  #2,4(a1)
locret_46CEE:                                           ; CODE XREF: Boss_Epsilon1PartDeathInit+4   j
                rts
; End of function Boss_Epsilon1PartDeathInit
; Part falling after death
Boss_Epsilon1PartDeathFall:                             ; DATA XREF: ROM:00046C88   o  ; was: sub_46CF0
                cmpi.w  #$80,$C(a1)
                bmi.s   locret_46D02
                andi.w  #$7FFF,2(a1)
                addq.w  #2,4(a1)
locret_46D02:                                           ; CODE XREF: Boss_Epsilon1PartDeathFall+6   j
                rts
; End of function Boss_Epsilon1PartDeathFall
; Part explosion effect
Boss_Epsilon1PartDeathExplode:                          ; DATA XREF: ROM:00046C8A   o  ; was: sub_46D04
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_46D5A
                move.l  #off_E95DC,8(a0)
                jsr     (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                move.w  #2,$48(a1)
                addq.w  #2,4(a1)
                move.b  (dword_FFFF08+1).w,d0
                add.w   a5,d0
                andi.w  #1,d0
                beq.s   loc_46D4E
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                rts
; ---------------------------------------------------------------------------
loc_46D4E:                                              ; CODE XREF: Boss_Epsilon1PartDeathExplode+3A   j
                move.w  (dword_FFC690).w,$10(a0)
                move.w  (dword_FFC694).w,$14(a0)
locret_46D5A:                                           ; CODE XREF: Boss_Epsilon1PartDeathExplode+6   j
                rts
; End of function Boss_Epsilon1PartDeathExplode
; Part cleanup after destruction
Boss_Epsilon1PartDeathCleanup:                          ; DATA XREF: ROM:00046C8C   o  ; was: sub_46D5C
                subq.w  #1,$48(a1)
                bne.s   locret_46D66
                subq.w  #2,4(a1)
locret_46D66:                                           ; CODE XREF: Boss_Epsilon1PartDeathCleanup+4   j
                rts
; End of function Boss_Epsilon1PartDeathCleanup
; Boss intro main handler
