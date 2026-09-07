Boss_AntroidUpdateSprite:                               ; CODE XREF: Boss_AntroidIdleState+A   j  ; was: sub_37E8C
                                        ; Boss_AntroidTransitionToIdle+3A   p
                move.l  #word_EB732,$C8(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #$7F,d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   Boss_AntroidSetupMetasprite
                btst    #1,d0
                beq.s   Boss_AntroidSetupMetasprite
                move.l  #word_EB720,$C8(a5)
; End of function Boss_AntroidUpdateSprite
; Sets up boss metasprite rendering
Boss_AntroidSetupMetasprite:                            ; CODE XREF: Boss_AntroidEarthquakeAttack+18   p  ; was: sub_37EB0
                                        ; Boss_AntroidJumpAttackState+12   p
                moveq   #$18,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_AntroidSetupMetasprite
; Switches metasprite table based on frame counter for animation variety
Boss_AntroidUpdateMetaspriteTable:                      ; CODE XREF: Boss_AntroidEarthquakeAttack+38   j  ; was: sub_37EB8
                                        ; Boss_AntroidJumpAttackState+16   j
                move.l  #word_EB732,$C8(a5)
                btst    #1,(word_FFA000+1).w
                beq.s   locret_37ED0
                move.l  #word_EB720,$C8(a5)
locret_37ED0:                                           ; CODE XREF: Boss_AntroidUpdateMetaspriteTable+E   j
                rts
; End of function Boss_AntroidUpdateMetaspriteTable
; Loads animation table pointer for boss
Boss_AntroidLoadAnimTable:                              ; CODE XREF: Boss_AntroidTransitionToIdle+E   p  ; was: sub_37ED2
                                        ; Boss_AntroidTransitionToIdle+22   p
                movea.w #(byte_FFCB60-M68K_RAM),a0
                movea.w #(word_FFCF80-M68K_RAM),a1
                bra.s   loc_37EE4
; End of function Boss_AntroidLoadAnimTable
; Sets boss animation index from parameter
Boss_AntroidSetAnimIndex:                               ; CODE XREF: Boss_AntroidFlyingAttack+98   p  ; was: sub_37EDC
                                        ; Boss_AntroidInitIdleState+2   p
                movea.w #(byte_FFCB60-M68K_RAM),a1
                movea.w #(word_FFCF80-M68K_RAM),a0
loc_37EE4:                                              ; CODE XREF: Boss_AntroidLoadAnimTable+8   j
                move.w  d0,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                tst.w   6(a5)
                beq.s   loc_37F06
                exg     a0,a1
loc_37F06:                                              ; CODE XREF: Boss_AntroidSetAnimIndex+26   j
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                move.w  a1,$11E(a5)
                move.w  a0,$17E(a5)
                move.l  #word_EB732,$C8(a5)
                rts
; End of function Boss_AntroidSetAnimIndex
; Spawns debris projectiles at random offsets
Boss_AntroidSpawnDebris:                                ; CODE XREF: Boss_AntroidUpdateMetaspriteFlipped   p  ; was: sub_37F26
                btst    #0,(word_FFA000+1).w
                bne.s   locret_37F76
                jsr     (Projectile_InitTypeA4).l
                bne.s   locret_37F76
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Projectile_FindFreeSlotComplex).l
                move.b  #0,$20(a0)
                move.l  #$FFFE8000,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$F,d1
                subi.w  #$20,d0                         ; ' '
                subq.w  #8,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_37F76:                                           ; CODE XREF: Boss_AntroidSpawnDebris+6   j
                                        ; Boss_AntroidSpawnDebris+E   j
                rts
; End of function Boss_AntroidSpawnDebris
; Attributes: thunk
; Thunk wrapper that jumps to graphics fade parameter setting function
Gfx_SetFadeParamsThunk:                                 ; CODE XREF: Boss_AntroidDeathFadeState+1A   p  ; was: sub_37F78
                                        ; Boss_AntroidDeathTimer+16   j
                jmp     (Gfx_SetFadeParams).l
; End of function Gfx_SetFadeParamsThunk
; Updates boss flip direction based on player position
Boss_AntroidUpdateFlipDirection:                        ; CODE XREF: Boss_AntroidTransitionToIdle+114   j  ; was: sub_37F7E
                                        ; sub_379A0   p
                jsr     (Physics_CalculateDistanceTo).l
                move.w  $54(a5),d7
                move.w  #$100,$54(a5)
                tst.w   d1
                bmi.s   loc_37F98
                move.w  #0,$54(a5)
loc_37F98:                                              ; CODE XREF: Boss_AntroidUpdateFlipDirection+12   j
                cmp.w   $54(a5),d7
                beq.w   locret_37FEA
; End of function Boss_AntroidUpdateFlipDirection
; Initializes boss physics and movement parameters
Boss_AntroidInitPhysics:                                ; CODE XREF: Boss_AntroidInitPhase+78   p  ; was: sub_37FA0
                                        ; Boss_AntroidInitPosition+1E   p
                moveq   #3,d0
                tst.w   $54(a5)
                bne.s   loc_37FCA
                bset    d0,$E(a5)
                bset    d0,$6E(a5)
                bclr    d0,$CE(a5)
                bset    d0,$12E(a5)
                bset    d0,$18E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$42E(a5)
                bset    d0,$84E(a5)
                rts
; ---------------------------------------------------------------------------
loc_37FCA:                                              ; CODE XREF: Boss_AntroidInitPhysics+6   j
                bclr    d0,$E(a5)
                bclr    d0,$6E(a5)
                bset    d0,$CE(a5)
                bclr    d0,$12E(a5)
                bclr    d0,$18E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$42E(a5)
                bclr    d0,$84E(a5)
locret_37FEA:                                           ; CODE XREF: Boss_AntroidUpdateFlipDirection+1E   j
                rts
; End of function Boss_AntroidInitPhysics
; Spawns Antroid projectile with velocity calculation
Boss_AntroidSpawnProjectile:                            ; CODE XREF: Boss_AntroidWaitState:loc_37D18   p  ; was: sub_37FEC
                btst    #0,(word_FFA000+1).w
                bne.w   locret_380A2
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_380A2
                move.w  #$158,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$C3C3,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #8,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FA06FA06,$2C(a0)
                move.w  #$3A,$26(a0)                    ; ':'
                move.w  $D0(a5),$10(a0)
                move.w  $D4(a5),$14(a0)
                addq.w  #8,$10(a0)
                addq.w  #8,$14(a0)
                move.w  #5,$48(a0)
                clr.w   $4A(a0)
                move.l  #$1200,$4C(a0)
                moveq   #0,d0
                move.w  #$20,d1                         ; ' '
                sub.w   $11C(a5),d1
                addq.w  #2,d1
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                add.w   d1,d0
                swap    d0
                asr.l   #2,d0
                move.l  d0,$18(a0)
                moveq   #0,d0
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                swap    d0
                neg.l   d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                tst.w   $54(a5)
                beq.s   locret_380A2
                neg.l   $18(a0)
                neg.l   $4C(a0)
                subi.w  #$10,$10(a0)
locret_380A2:                                           ; CODE XREF: Boss_AntroidSpawnProjectile+6   j
                                        ; Boss_AntroidSpawnProjectile+10   j
                rts
; End of function Boss_AntroidSpawnProjectile
; Updates Antroid projectile with fade and collision
Boss_AntroidProjectileUpdate:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_380A4
                tst.w   (word_FF808C).w
                bpl.s   loc_380FA
                bclr    #7,$22(a5)
                beq.s   loc_380C4
                bclr    #4,$22(a5)
                beq.s   loc_380FA
                move.w  #3,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_380C4:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+C   j
                move.l  $4C(a5),d0
                sub.l   d0,$18(a5)
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_380EA
                cmpi.w  #$144,$14(a5)
                bmi.s   loc_380EA
                move.l  #$FFFD8000,$1C(a5)
                clr.b   $21(a5)
loc_380EA:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+30   j
                                        ; Boss_AntroidProjectileUpdate+38   j
                subq.w  #1,$48(a5)
                bpl.s   locret_38112
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bmi.s   Boss_AntroidProjectileFade
loc_380FA:                                              ; CODE XREF: Boss_AntroidProjectileUpdate+4   j
                                        ; Boss_AntroidProjectileUpdate+14   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Applies fade palette to projectile during animation
Boss_AntroidProjectileFade:                             ; CODE XREF: Boss_AntroidProjectileUpdate+54   j  ; was: loc_38102
                move.w  word_38114(pc,d0.w),$E(a5)
                move.w  #6,$48(a5)
                addq.w  #2,$4A(a5)
locret_38112:                                           ; CODE XREF: Boss_AntroidProjectileUpdate+4A   j
                rts
; End of function Boss_AntroidProjectileUpdate
; ---------------------------------------------------------------------------
word_38114:     dc.w    $C3C7, $C3CB, $C3CF
                                        ; DATA XREF: Boss_AntroidProjectileUpdate:loc_38102   r

; Interpolates animation values toward target state
