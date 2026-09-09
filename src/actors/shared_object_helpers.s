; Shared object, projectile, animation, and effect helpers
Object_UpdateVisibilityLifetime:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A30E
                cmpi.w  #$80,$C(a5)
                bmi.s   Object_UpdateVisibilityLifetime_Countdown
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Object_UpdateVisibilityLifetime_Countdown:              ; CODE XREF: Object_UpdateVisibilityLifetime+6   j  ; was: loc_2A31E
                subq.w  #1,$48(a5)
                bpl.s   Object_UpdateVisibilityLifetime_Return
                clr.b   $21(a5)
Object_UpdateVisibilityLifetime_Return:                 ; CODE XREF: Object_UpdateVisibilityLifetime+14   j  ; was: locret_2A328
                rts
; End of function Object_UpdateVisibilityLifetime
; Converts the current object into Jetsripper projectile type C4
Boss_JetsripperInitC4Projectile:                        ; CODE XREF: Boss_JetsripperMain+90   p  ; was: sub_2A32A
                movea.w a5,a0
                move.w  #$C4,(a0)
                clr.l   $18(a0)
                clr.l   $1C(a0)
                move.w  #$480,d0
                add.w   (word_FF808A).w,d0
                move.w  $E(a0),d1
                andi.w  #$1000,d1
                add.w   d1,d0
                move.w  d0,$E(a0)
                move.w  #$E100,2(a0)
                move.l  #off_E9870,8(a0)
                clr.w   $C(a0)
                move.b  #$10,$20(a0)
                move.w  #3,$48(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F001F010,$2C(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_JetsripperInitC4Projectile
; Waits on the shared delay counter, then enters the common projectile update
Projectile_UpdateAfterGlobalDelay:                      ; CODE XREF: Enemy_ShipSpawnDebrisProjectile   p  ; was: sub_2A390
                                        ; sub_3A122   p
                subq.w  #1,(word_FF809E).w
                bpl.s   Projectile_UpdateWithImpactFrames_Update
                move.w  #$FFFF,(word_FF809E).w
; End of function Projectile_UpdateAfterGlobalDelay
; Updates a projectile and selects one of two shared impact-frame tables
Projectile_UpdateWithImpactFrames:                      ; CODE XREF: Boss_ShiperSpawnDebris+6   p  ; was: sub_2A39C
                                        ; Boss_AntroidSpawnRamDebris+8   p
                move.w  (word_FFA000).w,d0
                move.w  d0,d1
                andi.w  #$1F,d1
                beq.s   Projectile_UpdateWithImpactFrames_PlaySound
                andi.w  #7,d1
                bne.s   Projectile_UpdateWithImpactFrames_Update
                btst    #3,(dword_FFFF08).w
                beq.s   Projectile_UpdateWithImpactFrames_Update
Projectile_UpdateWithImpactFrames_PlaySound:            ; CODE XREF: Projectile_UpdateWithImpactFrames+A   j  ; was: loc_2A3B6
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
Projectile_UpdateWithImpactFrames_Update:               ; CODE XREF: Projectile_UpdateAfterGlobalDelay+4   j  ; was: loc_2A3C0
                                        ; Projectile_UpdateWithImpactFrames+10   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Projectile_UpdateWithImpactFrames_Return
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                move.w  (dword_FFFF08).w,d6
                move.w  d6,d1
                andi.w  #$300,d6
                bne.s   Projectile_UpdateWithImpactFrames_UseSelectedFrames
                movea.l #Weapon_ImpactSpriteFrames,a1
Projectile_UpdateWithImpactFrames_UseSelectedFrames:    ; CODE XREF: Projectile_UpdateWithImpactFrames+3E   j  ; was: loc_2A3E2
                moveq   #0,d0
Projectile_UpdateWithImpactFrames_Return:               ; CODE XREF: Projectile_UpdateWithImpactFrames+2A   j  ; was: locret_2A3E4
                rts
; End of function Projectile_UpdateWithImpactFrames
; Updates a projectile while emitting randomized explosion sounds
Projectile_UpdateWithExplosionSound:                    ; CODE XREF: Boss_DestroyerProtoEmitDefeatParticle+12   p  ; was: sub_2A3E6
                                        ; Boss_JokerSpawnDefeatEffect   p
                subq.w  #1,(word_FF809E).w
                bpl.s   Projectile_UpdateWithImpactFrames_Update
                move.w  #$FFFF,(word_FF809E).w
                move.w  (word_FFA000).w,d0
                move.w  d0,d1
                andi.w  #$1F,d1
                beq.s   Projectile_UpdateWithExplosionSound_Play
                andi.w  #7,d1
                bne.s   Projectile_UpdateWithExplosionSound_Return
                btst    #3,(dword_FFFF08).w
                beq.s   Projectile_UpdateWithExplosionSound_Return
Projectile_UpdateWithExplosionSound_Play:               ; CODE XREF: Projectile_UpdateWithExplosionSound+16   j  ; was: loc_2A40C
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Projectile_UpdateWithExplosionSound_Return:             ; CODE XREF: Projectile_UpdateWithExplosionSound+1C   j  ; was: locret_2A416
                                        ; Projectile_UpdateWithExplosionSound+24   j
                rts
; End of function Projectile_UpdateWithExplosionSound
; Spawns explosion projectile with sound
Boss_CaterpillarSpawnExplosion:                         ; CODE XREF: Boss_CaterpillarHomingProjectileSegment+4C   j  ; was: sub_2A418
                                        ; Boss_CaterpillarFourPhaseSegment+40   j
                movea.w a5,a0
                bsr.w   Projectile_InitType88
                move.l  #off_E953C,8(a0)
                clr.l   $18(a0)
                move.l  #$FFFC0000,$1C(a0)
                move.b  #4,$20(a0)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_CaterpillarSpawnExplosion
; Spawns 4 projectiles in different directions using sine/cosine table
Projectile_SpawnFourDirectional:
                movea.w a0,a3                           ; was: sub_2A44E
                movea.l #Math_SineTable,a4
                move.w  #$150,d6
                moveq   #3,d7
Projectile_SpawnFourDirectional_Loop:                   ; CODE XREF: Projectile_SpawnFourDirectional+4A   j  ; was: loc_2A45C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Projectile_SpawnFourDirectional_Return
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                bsr.w   Sprite_InitType58FromTable
                move.w  $10(a3),$10(a0)
                move.w  $14(a3),$14(a0)
                move.w  -$80(a4,d6.w),d0
                move.w  (a4,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #1,d0
                asl.l   #5,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                addi.w  #$20,d6                         ; ' '
                dbf     d7,Projectile_SpawnFourDirectional_Loop
Projectile_SpawnFourDirectional_Return:                 ; CODE XREF: Projectile_SpawnFourDirectional+14   j  ; was: locret_2A49C
                rts
; End of function Projectile_SpawnFourDirectional
; ---------------------------------------------------------------------------
unused_7:       binclude "data/other/unused_7.bin"

; Initializes small explosion effect sprite with sound effect $BB
Effect_InitSmallExplosion:
                movea.w a5,a0                           ; was: sub_2A4BE
                move.w  #$A8,(a0)
                clr.w   2(a0)
                clr.b   $21(a0)
                clr.w   $48(a0)
                move.w  #4,$4A(a0)
                move.b  #$BB,d0
                jmp     (Sound_PlaySFX).l
; End of function Effect_InitSmallExplosion
; Sets screen shake intensity values to 2
Effect_SetScreenShake:
                move.w  #2,(word_FFA010).w              ; was: sub_2A4E0
                move.w  #2,(word_FFA014).w
                rts
; End of function Effect_SetScreenShake
; Spawns particle effects at intervals with random position offsets
Effect_SpawnParticleLoop:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A4EE
                subq.w  #1,$48(a5)
                bpl.s   Effect_SpawnParticleLoop_Return
                move.w  #2,$48(a5)
                subq.w  #1,$4A(a5)
                bpl.s   Effect_SpawnParticleLoop_Spawn
                bset    #4,2(a5)
Effect_SpawnParticleLoop_Spawn:                         ; CODE XREF: Effect_SpawnParticleLoop+10   j  ; was: loc_2A506
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Effect_SpawnParticleLoop_Return
                movea.l #Effect_ParticleLoopSpriteFrames,a1
                bsr.w   Sprite_InitTypeA4FromTable
                move.b  (dword_FFFF08+1).w,d0
                move.b  (dword_FFFF08+2).w,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                btst    #0,(dword_FFFF08).w
                beq.s   Effect_SpawnParticleLoop_CheckYSign
                neg.w   d0
Effect_SpawnParticleLoop_CheckYSign:                    ; CODE XREF: Effect_SpawnParticleLoop+42   j  ; was: loc_2A534
                btst    #1,(dword_FFFF08).w
                beq.s   Effect_SpawnParticleLoop_StorePosition
                neg.w   d1
Effect_SpawnParticleLoop_StorePosition:                 ; CODE XREF: Effect_SpawnParticleLoop+4C   j  ; was: loc_2A53E
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                jmp     (RandomNumber).l
; ---------------------------------------------------------------------------
Effect_SpawnParticleLoop_Return:                        ; CODE XREF: Effect_SpawnParticleLoop+4   j  ; was: locret_2A554
                                        ; Effect_SpawnParticleLoop+1E   j
                rts
; End of function Effect_SpawnParticleLoop
; Initializes larger explosion effect type $180 with sound effect $BB
Effect_InitLargeExplosion:
                movea.w a5,a0                           ; was: sub_2A556
                move.l  d0,$48(a0)
                move.w  #$180,(a0)
                move.w  #$FC0,2(a0)
                clr.b   $21(a0)
                clr.w   $48(a0)
                move.b  #$BB,d0
                jmp     (Sound_PlaySFX).l
; End of function Effect_InitLargeExplosion
; Falling projectile that spawns child projectiles periodically
Projectile_FallingSpawner:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A578
                addi.l  #$3000,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   Projectile_FallingSpawner_Return
                move.w  #2,$48(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_FallingSpawner_Return
                move.l  #off_E95C0,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFEE000,$1C(a0)
                bra.w   Projectile_InitType88
; ---------------------------------------------------------------------------
Projectile_FallingSpawner_Return:                       ; CODE XREF: Projectile_FallingSpawner+C   j  ; was: locret_2A5B4
                                        ; Projectile_FallingSpawner+1A   j
                rts
; End of function Projectile_FallingSpawner
; Spawns 4 projectiles in pattern with sound
Enemy_SpawnQuadProjectiles:                             ; CODE XREF: Enemy_SpawnDifficultyProjectilePattern:loc_2D664   j  ; was: sub_2A5B6
                                        ; Projectile_ViblackSideShotBeginBurst+14   j
                movea.w a5,a0
                move.l  #off_E95DC,8(a5)
                bsr.w   Sprite_InitType160FromCurrent
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                lea     Projectile_QuadVelocityComponents(pc),a2
                nop
                moveq   #3,d7
; Updates quad projectile spawn with trajectory calculation
Projectile_UpdateQuadSpawn:                             ; CODE XREF: Enemy_SpawnQuadProjectiles+48   j  ; was: loc_2A5D6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_SpawnQuadProjectiles_Return
                move.l  #off_E95A4,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (a2)+,$18(a0)
                move.w  (a2)+,$1C(a0)
                bsr.w   Sprite_InitType160
                dbf     d7,Projectile_UpdateQuadSpawn
Enemy_SpawnQuadProjectiles_Return:                      ; CODE XREF: Enemy_SpawnQuadProjectiles+26   j  ; was: locret_2A602
                rts
; End of function Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
Projectile_QuadVelocityComponents:  dc.w    $FFFF, $FFFF, 1, $FFFF, $FFFF, 1, 1, 1  ; was: word_2A604
                                        ; DATA XREF: Enemy_SpawnQuadProjectiles+18   o

; Initializes the current object from the table in a1
Sprite_InitCurrentFromTable:                            ; CODE XREF: Weapon_HandleSeekingProjectileCollision+14   p  ; was: sub_2A614
                                        ; Weapon_UpdateBombProjectile+16   p
                movea.w a5,a0
; End of function Sprite_InitCurrentFromTable
; Initializes sprite object from data table
Sprite_InitFromTable:                                   ; CODE XREF: Effect_SpawnStarParticle+10   p  ; was: sub_2A616
                                        ; Effect_SpawnParticle+24   p
                move.w  #$38,(a0)                       ; '8'
                move.w  #$8D40,2(a0)
                move.w  (a1)+,$4C(a0)
                move.w  (a1)+,$E(a0)
                move.w  (a1)+,8(a0)
                move.w  (a1)+,$A(a0)
                move.l  a1,$48(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                rts
; End of function Sprite_InitFromTable
; Initializes sprite type $58 using default address passing
Sprite_InitType58Default:
                bsr.w   Sprite_InitCurrentFromTable     ; was: sub_2A642
                move.w  #$58,(a0)                       ; 'X'
                rts
; End of function Sprite_InitType58Default
; Initializes object type 58 from the table in a1
Sprite_InitType58FromTable:                             ; CODE XREF: Projectile_SpawnFourDirectional+1E   p  ; was: sub_2A64C
                                        ; Boss_ShiperSpawnDebris+E   p
                bsr.w   Sprite_InitFromTable
                move.w  #$58,(a0)                       ; 'X'
                rts
; End of function Sprite_InitType58FromTable
; Initializes sprite type $68 using default address passing
Sprite_InitType68Default:
                bsr.w   Sprite_InitCurrentFromTable     ; was: sub_2A656
                move.w  #$68,(a0)                       ; 'h'
                rts
; End of function Sprite_InitType68Default
; Initializes sprite type $68 from initialization table
Sprite_InitType68FromTable:
                bsr.w   Sprite_InitFromTable            ; was: sub_2A660
                move.w  #$68,(a0)                       ; 'h'
                rts
; End of function Sprite_InitType68FromTable
; Initializes sprite type $94 using default address passing
Sprite_InitType94Default:
                bsr.w   Sprite_InitCurrentFromTable     ; was: sub_2A66A
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94Default
; Initializes sprite type $94 from initialization table
Sprite_InitType94FromTable:                             ; CODE XREF: Boss_ShiperSpawnAngledProjectile+16   p  ; was: sub_2A674
                bsr.w   Sprite_InitFromTable
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94FromTable
; Initializes the current object as type A4 from the table in a1
Sprite_InitTypeA4FromCurrentTable:                      ; CODE XREF: Effect_UpdateKnockbackParticle+44   p  ; was: sub_2A67E
                                        ; Effect_UpdateKnockbackParticle+76   j
                bsr.w   Sprite_InitCurrentFromTable
                move.w  #$A4,(a0)
                rts
; End of function Sprite_InitTypeA4FromCurrentTable
; Initializes the object in a0 as type A4 from the table in a1
Sprite_InitTypeA4FromTable:                             ; CODE XREF: Effect_UpdateImpactParticleSpawner:Effect_UpdateImpactParticleSpawner_InitChild   p  ; was: sub_2A688
                                        ; Effect_SpawnParticleLoop+28   p
                bsr.w   Sprite_InitFromTable
                move.w  #$A4,(a0)
                rts
; End of function Sprite_InitTypeA4FromTable
; Updates animation frame and swaps palette based on frame counter
Anim_UpdateWithPaletteSwap:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A692
                bsr.w   Anim_UpdateSpriteFrame
                andi.w  #$9FFF,$E(a5)
                btst    #1,(word_FFA000+1).w
                bne.s   Anim_UpdateWithPaletteSwap_UseAlternatePalette
                ori.w   #$4000,$E(a5)
                rts
; ---------------------------------------------------------------------------
Anim_UpdateWithPaletteSwap_UseAlternatePalette:         ; CODE XREF: Anim_UpdateWithPaletteSwap+10   j  ; was: loc_2A6AC
                ori.w   #$6000,$E(a5)
                rts
; End of function Anim_UpdateWithPaletteSwap
; Updates animation and applies the global stage attribute bits
Anim_UpdateWithGlobalAttributes:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A6B4
                bsr.w   Anim_UpdateSpriteFrame
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Anim_UpdateWithGlobalAttributes
; Applies a net upward acceleration through the following shared entry point
Physics_AccelerateUpward:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A6C8
                subi.l  #$10000,$1C(a5)
; End of function Physics_AccelerateUpward
; Applies downward acceleration to the current object
Physics_AccelerateDownward:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A6D0
                addi.l  #$8000,$1C(a5)
; End of function Physics_AccelerateDownward
; Updates sprite animation frame timer and data
Anim_UpdateSpriteFrame:                                 ; CODE XREF: Cutscene_XiTigerFadeOut+C   p  ; was: sub_2A6D8
                                        ; sub_2A692   p
                subq.w  #1,$4C(a5)
                bne.s   Anim_UpdateSpriteFrame_Return
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   Anim_HideOnScriptEnd
                move.w  (a0)+,$E(a5)
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
Anim_UpdateSpriteFrame_Return:                          ; CODE XREF: Anim_UpdateSpriteFrame+4   j  ; was: locret_2A700
                rts
; ---------------------------------------------------------------------------
; Hides the object when the frame script reaches its end marker
Anim_HideOnScriptEnd:                                   ; CODE XREF: Anim_UpdateSpriteFrame+E   j  ; was: loc_2A702
                move.w  #$1000,2(a5)
                rts
; End of function Anim_UpdateSpriteFrame
; Reads a frame script and invokes its stored callback at the end marker
Anim_RunCallbackScript:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A70A
                movea.l $54(a5),a0
                tst.w   (a0)+
                bmi.s   Anim_RunCallbackScript_InvokeCallback
                move.w  (a0)+,$E(a5)
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$54(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                rts
; ---------------------------------------------------------------------------
Anim_RunCallbackScript_InvokeCallback:                  ; CODE XREF: Anim_RunCallbackScript+6   j  ; was: loc_2A72C
                movea.l $48(a5),a0
                move.l  $4C(a5),$1C(a5)
                move.l  $50(a5),$18(a5)
                jmp     (a0)
; End of function Anim_RunCallbackScript
; Animates sprite tile and size from script table, disables sprite on end marker
Anim_UpdateScriptAndHide:
                subq.w  #1,$4C(a5)                      ; was: sub_2A73E
                bne.s   Anim_UpdateScriptAndHide_Return
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   Anim_UpdateScriptAndHide_Hide
                move.w  (a0)+,d0
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
Anim_UpdateScriptAndHide_Return:                        ; CODE XREF: Anim_UpdateScriptAndHide+4   j  ; was: locret_2A764
                rts
; ---------------------------------------------------------------------------
Anim_UpdateScriptAndHide_Hide:                          ; CODE XREF: Anim_UpdateScriptAndHide+E   j  ; was: loc_2A766
                andi.w  #$7FFF,2(a5)
                rts
; End of function Anim_UpdateScriptAndHide
; Animates sprite tile and size from script table with loop support
Anim_UpdateLoopingScript:                               ; CODE XREF: Projectile_BouncingWithGravity:loc_2B6A4   p  ; was: sub_2A76E
                subq.w  #1,$4C(a5)
                bne.s   Anim_UpdateLoopingScript_Return
Anim_UpdateLoopingScript_ReadFrame:                     ; CODE XREF: Anim_UpdateLoopingScript+2C   j  ; was: loc_2A774
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   Anim_UpdateLoopingScript_Restart
                move.w  (a0)+,d0
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
Anim_UpdateLoopingScript_Return:                        ; CODE XREF: Anim_UpdateLoopingScript+4   j  ; was: locret_2A794
                rts
; ---------------------------------------------------------------------------
Anim_UpdateLoopingScript_Restart:                       ; CODE XREF: Anim_UpdateLoopingScript+E   j  ; was: loc_2A796
                move.l  (a0)+,$48(a5)
                bra.s   Anim_UpdateLoopingScript_ReadFrame
; End of function Anim_UpdateLoopingScript
; Initializes the current object as projectile type 88
Projectile_InitType88FromCurrent:                       ; CODE XREF: Sprite_ShipDebrisUpdate+28   p  ; was: sub_2A79C
                                        ; Projectile_GravityBounce+50   j
                movea.w a5,a0
; End of function Projectile_InitType88FromCurrent
; Initializes projectile with type 0x88
Projectile_InitType88:                                  ; CODE XREF: Player_InitShotProjectile   p  ; was: sub_2A79E
                                        ; Boss_CaterpillarSpawnExplosion+2   p
                move.w  #$88,(a0)
                bra.s   Sprite_InitializeEffectGraphics
; End of function Projectile_InitType88
; Initializes the current object as effect type 188
Effect_InitType188FromCurrent:                          ; CODE XREF: Weapon_UpdateSeekingMissile+26   j  ; was: sub_2A7A4
                movea.w a5,a0
; End of function Effect_InitType188FromCurrent
; Spawns explosion effect type 0x188 at current location
Effect_SpawnExplosionType188:                           ; CODE XREF: Weapon_SpawnHomingEffect+EE   p  ; was: sub_2A7A6
                                        ; Enemy_TrailingExplosionSpawner+4C   p
                move.w  #$188,(a0)
                bra.s   Sprite_InitializeEffectGraphics
; End of function Effect_SpawnExplosionType188
; Initializes the current object as projectile type 1A8
Projectile_InitType1A8FromCurrent:
                movea.w a5,a0                           ; was: sub_2A7AC
; End of function Projectile_InitType1A8FromCurrent
; Initializes projectile type 1A8 in a0
Projectile_InitType1A8:                                 ; CODE XREF: Projectile_SpawnQuadPattern+14   p  ; was: sub_2A7AE
                                        ; Enemy_SpawnProjectileAtAngle+8   p
                move.w  #$1A8,(a0)
                bra.s   Sprite_InitializeEffectGraphics
; End of function Projectile_InitType1A8
; Spawns explosion effect with sprite type 1AC
Effect_SpawnExplosionType1AC:
                movea.w a5,a0                           ; was: sub_2A7B4
                move.w  #$1AC,(a0)
                bra.s   Sprite_InitializeEffectGraphics
; End of function Effect_SpawnExplosionType1AC
; Initializes the current object as type 160
Sprite_InitType160FromCurrent:                          ; CODE XREF: Enemy_SpawnQuadProjectiles+A   p  ; was: sub_2A7BC
                                        ; Projectile_Stage24RisingShotUpdateArc+20   j
                movea.w a5,a0
; End of function Sprite_InitType160FromCurrent
; Initializes object type 160 in a0
Sprite_InitType160:                                     ; CODE XREF: Effect_SpawnRandomDebris+3C   p  ; was: sub_2A7BE
                                        ; Effect_InitPlayerMotionProjectile+48   p
                move.w  #$160,(a0)
; Applies shared graphics attributes to an effect object
Sprite_InitializeEffectGraphics:                        ; CODE XREF: Projectile_InitType88+4   j  ; was: loc_2A7C2
                                        ; Effect_SpawnExplosionType188+4   j
                move.w  #$ED40,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                rts
; End of function Sprite_InitType160
; Applies gravity to vertical velocity
Physics_ApplyGravity:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A7DE
                addi.l  #$2000,$1C(a5)
; Checks if sprite has exceeded height boundary and sets inactive
Physics_CheckHeightBoundary:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: loc_2A7E6
                cmpi.w  #$80,$C(a5)
                bmi.s   Physics_ApplyGravity_Return
                move.w  #$1000,2(a5)
Physics_ApplyGravity_Return:                            ; CODE XREF: Physics_ApplyGravity+E   j  ; was: locret_2A7F4
                rts
; End of function Physics_ApplyGravity
; Hides enemy after delay timer
Enemy_DelayedHide:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A7F6
                subq.w  #1,$48(a5)
                bpl.s   Enemy_DelayedHide_Return
                move.w  #$1000,2(a5)
Enemy_DelayedHide_Return:                               ; CODE XREF: Enemy_DelayedHide+4   j  ; was: locret_2A802
                rts
; End of function Enemy_DelayedHide
; Projectile with gravity physics
Projectile_FallWithGravity:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A804
                addi.l  #$3000,$1C(a5)
; Updates projectile trajectory with gravity applied
Projectile_FallWithGravity_Update:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: loc_2A80C
                bsr.w   Projectile_ApplyGlobalAttributes
                bsr.w   Projectile_UpdatePriorityBySlot
                cmpi.w  #$80,$C(a5)
                bmi.s   Projectile_FallWithGravity_Return
                move.w  #$1000,2(a5)
Projectile_FallWithGravity_Return:                      ; CODE XREF: Projectile_FallWithGravity+16   j  ; was: locret_2A822
                rts
; End of function Projectile_FallWithGravity
; Applies global stage attribute bits to the projectile sprite
Projectile_ApplyGlobalAttributes:                       ; CODE XREF: Projectile_FallWithGravity:loc_2A80C   p  ; was: sub_2A824
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Projectile_ApplyGlobalAttributes
; Updates sprite priority according to object-slot and frame parity
Projectile_UpdatePriorityBySlot:                        ; CODE XREF: Projectile_FallWithGravity+C   p  ; was: sub_2A834
                move.w  a5,d0
                btst    #5,d0
                beq.s   Projectile_UpdatePriorityBySlot_CheckFrameParity
                btst    #0,(word_FFA000+1).w
                bne.s   Projectile_UpdatePriorityBySlot_ClearPriority
Projectile_UpdatePriorityBySlot_SetPriority:            ; CODE XREF: Projectile_UpdatePriorityBySlot+1E   j  ; was: loc_2A844
                bset    #7,2(a5)
                rts
; ---------------------------------------------------------------------------
Projectile_UpdatePriorityBySlot_CheckFrameParity:       ; CODE XREF: Projectile_UpdatePriorityBySlot+6   j  ; was: loc_2A84C
                btst    #0,(word_FFA000+1).w
                bne.s   Projectile_UpdatePriorityBySlot_SetPriority
Projectile_UpdatePriorityBySlot_ClearPriority:          ; CODE XREF: Projectile_UpdatePriorityBySlot+E   j  ; was: loc_2A854
                bclr    #7,2(a5)
                rts
; End of function Projectile_UpdatePriorityBySlot
; Initializes a debris effect in the current object
Effect_InitDebrisFromCurrent:
                movea.w a5,a0                           ; was: sub_2A85C
; End of function Effect_InitDebrisFromCurrent
; Initializes debris sprite with velocity from RNG
Effect_InitDebrisSprite:                                ; CODE XREF: Boss_JokerSpawnDefeatEffect+18   p  ; was: sub_2A85E
                                        ; Boss_ViblackSpawnTransitionDebris+1C   p
                move.w  #$174,(a0)
                move.w  #$EDC0,2(a0)
                move.w  #$480,$E(a0)
                move.l  #off_E95A4,8(a0)
                clr.w   $C(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                rts
; End of function Effect_InitDebrisSprite
; Falling debris projectile with gravity acceleration
Projectile_FallingDebris:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A8A2
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   Projectile_FallingDebris_Return
                move.w  #$1000,2(a5)
Projectile_FallingDebris_Return:                        ; CODE XREF: Projectile_FallingDebris+E   j  ; was: locret_2A8B8
                rts
; End of function Projectile_FallingDebris
; Clears inactive object types 12C and 134 from the shared pool
Object_ClearInactiveTypes12CAnd134:                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A8BA
                bset    #4,2(a5)
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$12C,d0
                move.w  #$134,d1
Object_ClearInactiveTypes12CAnd134_ScanLoop:            ; CODE XREF: Object_ClearInactiveTypes12CAnd134+30   j  ; was: loc_2A8CC
                cmp.w   (a0),d0
                beq.s   Object_ClearInactiveTypes12CAnd134_ClearMatch
                cmp.w   (a0),d1
                bne.s   Object_ClearInactiveTypes12CAnd134_NextObject
Object_ClearInactiveTypes12CAnd134_ClearMatch:          ; CODE XREF: Object_ClearInactiveTypes12CAnd134+14   j  ; was: loc_2A8D4
                btst    #1,2(a0)
                bne.s   Object_ClearInactiveTypes12CAnd134_NextObject
                jsr     (Sys_Clear96ByteBlock).l
Object_ClearInactiveTypes12CAnd134_NextObject:          ; CODE XREF: Object_ClearInactiveTypes12CAnd134+18   j  ; was: loc_2A8E2
                                        ; Object_ClearInactiveTypes12CAnd134+20   j
                lea     $60(a0),a0
                cmpa.w  #$DCA0,a0
                bmi.s   Object_ClearInactiveTypes12CAnd134_ScanLoop
                rts
; End of function Object_ClearInactiveTypes12CAnd134
; Initializes enemy sprite graphics mode and animation pointer
Enemy_InitSpriteGraphics:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A8EE
                tst.w   4(a5)
                bne.w   Enemy_InitSpriteGraphics_Return
                addq.w  #2,4(a5)
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   Enemy_InitSpriteGraphics_LoadTables
                move.w  #$E100,2(a5)
Enemy_InitSpriteGraphics_LoadTables:                    ; CODE XREF: Enemy_InitSpriteGraphics+1A   j  ; was: loc_2A910
                move.l  Enemy_SpriteMappingPointers(pc,d0.w),8(a5)
                move.w  Enemy_SpriteAttributesTable(pc,d0.w),$E(a5)
                move.b  Enemy_SpriteAttributesTable+1(pc,d0.w),$20(a5)
Enemy_InitSpriteGraphics_Return:                        ; CODE XREF: Enemy_InitSpriteGraphics+4   j  ; was: locret_2A922
                rts
; End of function Enemy_InitSpriteGraphics
; ---------------------------------------------------------------------------
Enemy_SpriteMappingPointers:    dc.l    off_19C4DE      ; DATA XREF: Enemy_InitSpriteGraphics:Enemy_InitSpriteGraphics_LoadTables   r  ; was: off_2A924
Enemy_SpriteAttributesTable:    dc.l    $2DF6000        ; DATA XREF: Enemy_InitSpriteGraphics+28   r  ; was: dword_2A928
                dc.l    off_19C4F2
                dc.l    $2DF6000
                dc.l    off_19C506
                dc.l    $2DF6000
                dc.l    off_19C52E
                dc.l    $2DF6400
                dc.l    off_19C55E
                dc.l    $2DF6000

; Loads object graphics attributes and stamps its pattern into the terrain map
Terrain_StampObjectPattern:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2A94C
                tst.w   4(a5)
                bne.w   Terrain_StampObjectPattern_Return
                move.w  $5E(a5),d0
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   Terrain_StampObjectPattern_Setup
                move.w  #$E100,2(a5)
Terrain_StampObjectPattern_Setup:                       ; CODE XREF: Terrain_StampObjectPattern+1A   j  ; was: loc_2A96E
                lea     Terrain_ObjectStampPatternPointers(pc),a0
                nop
                movea.l (a0,d0.w),a0
                moveq   #0,d6
                move.l  (a0,d6.w),8(a5)
                move.w  4(a0,d6.w),$E(a5)
                move.b  6(a0,d6.w),$20(a5)
                move.w  8(a0,d6.w),d7
                lea     (M68K_RAM).l,a1
                move.w  $10(a5),d0
                move.w  $14(a5),d1
Terrain_StampObjectPattern_WriteLoop:                   ; CODE XREF: Terrain_StampObjectPattern+88   j  ; was: loc_2A99E
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                add.w   $A(a0,d6.w),d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d1,d3
                subi.w  #$80,d3
                sub.w   (dword_FFA904).w,d3
                add.w   $C(a0,d6.w),d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  d7,(a1,d2.w)
                addq.w  #4,d6
                cmpi.w  #$8000,$A(a0,d6.w)
                bne.s   Terrain_StampObjectPattern_WriteLoop
Terrain_StampObjectPattern_Return:                      ; CODE XREF: Terrain_StampObjectPattern+4   j  ; was: locret_2A9D6
                rts
; End of function Terrain_StampObjectPattern
; ---------------------------------------------------------------------------
Terrain_ObjectStampPattern: dc.l    word_19C4A4         ; DATA XREF: ROM:Terrain_ObjectStampPatternPointers   o  ; was: off_2A9D8
                dc.l    $2D66000, $40FFE0
                dc.l    $FFE8, $FFF0
                dc.l    $FFF8, 0
                dc.l    8, $10
                dc.l    $18, $8000
Terrain_ObjectStampPatternPointers: dc.l    Terrain_ObjectStampPattern  ; DATA XREF: Terrain_StampObjectPattern:Terrain_StampObjectPattern_Setup   o  ; was: off_2AA04
