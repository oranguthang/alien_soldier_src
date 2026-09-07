Boss_CheckVisibilityTimer:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A30E
                cmpi.w  #$80,$C(a5)
                bmi.s   loc_2A31E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A31E:                                              ; CODE XREF: Boss_CheckVisibilityTimer+6   j
                subq.w  #1,$48(a5)
                bpl.s   locret_2A328
                clr.b   $21(a5)
locret_2A328:                                           ; CODE XREF: Boss_CheckVisibilityTimer+14   j
                rts
; End of function Boss_CheckVisibilityTimer
; Spawns Jetsripper boss projectile with initial state
Boss_SpawnProjectile:                                   ; CODE XREF: Boss_JetsripperMain+90   p  ; was: sub_2A32A
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
; End of function Boss_SpawnProjectile
; Spawns projectile at specified position
Projectile_SpawnAtPosition:                             ; CODE XREF: Enemy_ShipSpawnDebrisProjectile   p  ; was: sub_2A390
                                        ; sub_3A122   p
                subq.w  #1,(word_FF809E).w
                bpl.s   loc_2A3C0
                move.w  #$FFFF,(word_FF809E).w
; End of function Projectile_SpawnAtPosition
; Initializes projectile type 0xA4
Projectile_InitTypeA4:                                  ; CODE XREF: Boss_ShiperSpawnDebris+6   p  ; was: sub_2A39C
                                        ; Boss_AntroidSpawnDebris+8   p
                move.w  (word_FFA000).w,d0
                move.w  d0,d1
                andi.w  #$1F,d1
                beq.s   loc_2A3B6
                andi.w  #7,d1
                bne.s   loc_2A3C0
                btst    #3,(dword_FFFF08).w
                beq.s   loc_2A3C0
loc_2A3B6:                                              ; CODE XREF: Projectile_InitTypeA4+A   j
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
loc_2A3C0:                                              ; CODE XREF: Projectile_SpawnAtPosition+4   j
                                        ; Projectile_InitTypeA4+10   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_2A3E4
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                move.w  (dword_FFFF08).w,d6
                move.w  d6,d1
                andi.w  #$300,d6
                bne.s   loc_2A3E2
                movea.l #Weapon_ImpactSpriteFrames,a1
loc_2A3E2:                                              ; CODE XREF: Projectile_InitTypeA4+3E   j
                moveq   #0,d0
locret_2A3E4:                                           ; CODE XREF: Projectile_InitTypeA4+2A   j
                rts
; End of function Projectile_InitTypeA4
; Plays random explosion sound effects with timer countdown
Effect_PlayRandomExplosionSound:                        ; CODE XREF: Boss_DestroyerProtoSpawnProjectile2+12   p  ; was: sub_2A3E6
                                        ; sub_3B602   p
                subq.w  #1,(word_FF809E).w
                bpl.s   loc_2A3C0
                move.w  #$FFFF,(word_FF809E).w
                move.w  (word_FFA000).w,d0
                move.w  d0,d1
                andi.w  #$1F,d1
                beq.s   loc_2A40C
                andi.w  #7,d1
                bne.s   locret_2A416
                btst    #3,(dword_FFFF08).w
                beq.s   locret_2A416
loc_2A40C:                                              ; CODE XREF: Effect_PlayRandomExplosionSound+16   j
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_2A416:                                           ; CODE XREF: Effect_PlayRandomExplosionSound+1C   j
                                        ; Effect_PlayRandomExplosionSound+24   j
                rts
; End of function Effect_PlayRandomExplosionSound
; Spawns explosion projectile with sound
Boss_CaterpillarSpawnExplosion:                         ; CODE XREF: Boss_CaterpillarPart2+4C   j  ; was: sub_2A418
                                        ; Boss_CaterpillarPart3+40   j
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
                movea.l #word_1B514,a4
                move.w  #$150,d6
                moveq   #3,d7
loc_2A45C:                                              ; CODE XREF: Projectile_SpawnFourDirectional+4A   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_2A49C
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                bsr.w   Sprite_InitWithDefaultState
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
                dbf     d7,loc_2A45C
locret_2A49C:                                           ; CODE XREF: Projectile_SpawnFourDirectional+14   j
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
Sys_SetScreenShake:
                move.w  #2,(word_FFA010).w              ; was: sub_2A4E0
                move.w  #2,(word_FFA014).w
                rts
; End of function Sys_SetScreenShake
; Spawns particle effects at intervals with random position offsets
Effect_SpawnParticleLoop:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A4EE
                subq.w  #1,$48(a5)
                bpl.s   locret_2A554
                move.w  #2,$48(a5)
                subq.w  #1,$4A(a5)
                bpl.s   loc_2A506
                bset    #4,2(a5)
loc_2A506:                                              ; CODE XREF: Effect_SpawnParticleLoop+10   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   locret_2A554
                movea.l #Effect_ParticleLoopSpriteFrames,a1
                bsr.w   Projectile_FindFreeSlotComplex
                move.b  (dword_FFFF08+1).w,d0
                move.b  (dword_FFFF08+2).w,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                btst    #0,(dword_FFFF08).w
                beq.s   loc_2A534
                neg.w   d0
loc_2A534:                                              ; CODE XREF: Effect_SpawnParticleLoop+42   j
                btst    #1,(dword_FFFF08).w
                beq.s   loc_2A53E
                neg.w   d1
loc_2A53E:                                              ; CODE XREF: Effect_SpawnParticleLoop+4C   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                jmp     (RandomNumber).l
; ---------------------------------------------------------------------------
locret_2A554:                                           ; CODE XREF: Effect_SpawnParticleLoop+4   j
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
Projectile_FallingSpawner:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A578
                addi.l  #$3000,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_2A5B4
                move.w  #2,$48(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2A5B4
                move.l  #off_E95C0,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFEE000,$1C(a0)
                bra.w   Projectile_InitType88
; ---------------------------------------------------------------------------
locret_2A5B4:                                           ; CODE XREF: Projectile_FallingSpawner+C   j
                                        ; Projectile_FallingSpawner+1A   j
                rts
; End of function Projectile_FallingSpawner
; Spawns 4 projectiles in pattern with sound
Enemy_SpawnQuadProjectiles:                             ; CODE XREF: Enemy_SpawnParticleHardMode:loc_2D664   j  ; was: sub_2A5B6
                                        ; Enemy_ClearAndSpawnQuadProjectiles+14   j
                movea.w a5,a0
                move.l  #off_E95DC,8(a5)
                bsr.w   Sprite_SetObjectPointer
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                lea     word_2A604(pc),a2
                nop
                moveq   #3,d7
; Updates quad projectile spawn with trajectory calculation
Projectile_UpdateQuadSpawn:                             ; CODE XREF: Enemy_SpawnQuadProjectiles+48   j  ; was: loc_2A5D6
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2A602
                move.l  #off_E95A4,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (a2)+,$18(a0)
                move.w  (a2)+,$1C(a0)
                bsr.w   Sprite_InitializeProperties
                dbf     d7,Projectile_UpdateQuadSpawn
locret_2A602:                                           ; CODE XREF: Enemy_SpawnQuadProjectiles+26   j
                rts
; End of function Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
word_2A604:     dc.w    $FFFF, $FFFF, 1, $FFFF, $FFFF, 1, 1, 1
                                        ; DATA XREF: Enemy_SpawnQuadProjectiles+18   o

; Passes object address from a5 to a0
Sys_PassObjectAddress:                                  ; CODE XREF: Sprite_HandleProjectileCollision+14   p  ; was: sub_2A614
                                        ; Weapon_UpdateBombProjectile+16   p
                movea.w a5,a0
; End of function Sys_PassObjectAddress
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
                bsr.w   Sys_PassObjectAddress           ; was: sub_2A642
                move.w  #$58,(a0)                       ; 'X'
                rts
; End of function Sprite_InitType58Default
; Initializes sprite from table pointer and sets default state value
Sprite_InitWithDefaultState:                            ; CODE XREF: Projectile_SpawnFourDirectional+1E   p  ; was: sub_2A64C
                                        ; Boss_ShiperSpawnDebris+E   p
                bsr.w   Sprite_InitFromTable
                move.w  #$58,(a0)                       ; 'X'
                rts
; End of function Sprite_InitWithDefaultState
; Initializes sprite type $68 using default address passing
Sprite_InitType68Default:
                bsr.w   Sys_PassObjectAddress           ; was: sub_2A656
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
                bsr.w   Sys_PassObjectAddress           ; was: sub_2A66A
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94Default
; Initializes sprite type $94 from initialization table
Sprite_InitType94FromTable:                             ; CODE XREF: Boss_ShiperSpawnAngledProjectile+16   p  ; was: sub_2A674
                bsr.w   Sprite_InitFromTable
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94FromTable
; Spawns effect object of specific type at current position
Effect_SpawnObjectType:                                 ; CODE XREF: Effect_SpawnKnockbackParticle+44   p  ; was: sub_2A67E
                                        ; Effect_SpawnKnockbackParticle+76   j
                bsr.w   Sys_PassObjectAddress
                move.w  #$A4,(a0)
                rts
; End of function Effect_SpawnObjectType
; Finds free projectile slot with complex checks
Projectile_FindFreeSlotComplex:                         ; CODE XREF: Sprite_SpawnParticleEffect:loc_18C8C   p  ; was: sub_2A688
                                        ; Effect_SpawnParticleLoop+28   p
                bsr.w   Sprite_InitFromTable
                move.w  #$A4,(a0)
                rts
; End of function Projectile_FindFreeSlotComplex
; Updates animation frame and swaps palette based on frame counter
Anim_UpdateWithPaletteSwap:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A692
                bsr.w   Anim_UpdateSpriteFrame
                andi.w  #$9FFF,$E(a5)
                btst    #1,(word_FFA000+1).w
                bne.s   loc_2A6AC
                ori.w   #$4000,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A6AC:                                              ; CODE XREF: Anim_UpdateWithPaletteSwap+10   j
                ori.w   #$6000,$E(a5)
                rts
; End of function Anim_UpdateWithPaletteSwap
; Initializes projectile from data table
Projectile_InitializeFromTable:                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A6B4
                bsr.w   Anim_UpdateSpriteFrame
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Projectile_InitializeFromTable
; Applies upward vertical velocity to sprite
Physics_SetUpwardVelocity:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A6C8
                subi.l  #$10000,$1C(a5)
; End of function Physics_SetUpwardVelocity
; Applies upward vertical velocity to entity for rising movement
Physics_ApplyUpwardVelocity:                            ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A6D0
                addi.l  #$8000,$1C(a5)
; End of function Physics_ApplyUpwardVelocity
; Updates sprite animation frame timer and data
Anim_UpdateSpriteFrame:                                 ; CODE XREF: Cutscene_XiTigerFadeOut+C   p  ; was: sub_2A6D8
                                        ; sub_2A692   p
                subq.w  #1,$4C(a5)
                bne.s   locret_2A700
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   Sprite_SetBossInactiveState
                move.w  (a0)+,$E(a5)
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
locret_2A700:                                           ; CODE XREF: Anim_UpdateSpriteFrame+4   j
                rts
; ---------------------------------------------------------------------------
; Sets boss sprite to inactive state with special tile pattern
Sprite_SetBossInactiveState:                            ; CODE XREF: Anim_UpdateSpriteFrame+E   j  ; was: loc_2A702
                move.w  #$1000,2(a5)
                rts
; End of function Anim_UpdateSpriteFrame
; Final phase boss handler
Boss_Epsilon1FinalPhase:                                ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A70A
                movea.l $54(a5),a0
                tst.w   (a0)+
                bmi.s   loc_2A72C
                move.w  (a0)+,$E(a5)
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$54(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A72C:                                              ; CODE XREF: Boss_Epsilon1FinalPhase+6   j
                movea.l $48(a5),a0
                move.l  $4C(a5),$1C(a5)
                move.l  $50(a5),$18(a5)
                jmp     (a0)
; End of function Boss_Epsilon1FinalPhase
; Animates sprite tile and size from script table, disables sprite on end marker
Gfx_AnimateSpriteTileAndDisable:
                subq.w  #1,$4C(a5)                      ; was: sub_2A73E
                bne.s   locret_2A764
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   loc_2A766
                move.w  (a0)+,d0
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
locret_2A764:                                           ; CODE XREF: Gfx_AnimateSpriteTileAndDisable+4   j
                rts
; ---------------------------------------------------------------------------
loc_2A766:                                              ; CODE XREF: Gfx_AnimateSpriteTileAndDisable+E   j
                andi.w  #$7FFF,2(a5)
                rts
; End of function Gfx_AnimateSpriteTileAndDisable
; Animates sprite tile and size from script table with loop support
Gfx_AnimateSpriteTileLoop:                              ; CODE XREF: Projectile_BouncingWithGravity:loc_2B6A4   p  ; was: sub_2A76E
                subq.w  #1,$4C(a5)
                bne.s   locret_2A794
loc_2A774:                                              ; CODE XREF: Gfx_AnimateSpriteTileLoop+2C   j
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   loc_2A796
                move.w  (a0)+,d0
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
locret_2A794:                                           ; CODE XREF: Gfx_AnimateSpriteTileLoop+4   j
                rts
; ---------------------------------------------------------------------------
loc_2A796:                                              ; CODE XREF: Gfx_AnimateSpriteTileLoop+E   j
                move.l  (a0)+,$48(a5)
                bra.s   loc_2A774
; End of function Gfx_AnimateSpriteTileLoop
; Returns entity address in register A0 for manipulation
Enemy_GetEntityAddress:                                 ; CODE XREF: Sprite_ShipDebrisUpdate+28   p  ; was: sub_2A79C
                                        ; Projectile_GravityBounce+50   j
                movea.w a5,a0
; End of function Enemy_GetEntityAddress
; Initializes projectile with type 0x88
Projectile_InitType88:                                  ; CODE XREF: Player_InitShotProjectile   p  ; was: sub_2A79E
                                        ; Boss_CaterpillarSpawnExplosion+2   p
                move.w  #$88,(a0)
                bra.s   Sprite_InitializeExplosionSprite
; End of function Projectile_InitType88
; Copies seeking missile object address to a0 register for processing
Weapon_CopySeekingMissileAddress:                       ; CODE XREF: Weapon_UpdateSeekingMissile+26   j  ; was: sub_2A7A4
                movea.w a5,a0
; End of function Weapon_CopySeekingMissileAddress
; Spawns explosion effect type 0x188 at current location
Effect_SpawnExplosionType188:                           ; CODE XREF: Weapon_SpawnHomingEffect+EE   p  ; was: sub_2A7A6
                                        ; Enemy_TrailingExplosionSpawner+4C   p
                move.w  #$188,(a0)
                bra.s   Sprite_InitializeExplosionSprite
; End of function Effect_SpawnExplosionType188
; Wrapper to copy a5 register to a0 for effect initialization
Effect_WrapperA5ToA0:
                movea.w a5,a0                           ; was: sub_2A7AC
; End of function Effect_WrapperA5ToA0
; Initializes projectile type 2A
Projectile_InitType2A:                                  ; CODE XREF: Projectile_SpawnQuadPattern+14   p  ; was: sub_2A7AE
                                        ; Enemy_SpawnProjectileAtAngle+8   p
                move.w  #$1A8,(a0)
                bra.s   Sprite_InitializeExplosionSprite
; End of function Projectile_InitType2A
; Spawns explosion effect with sprite type 1AC
Effect_SpawnExplosionType1AC:
                movea.w a5,a0                           ; was: sub_2A7B4
                move.w  #$1AC,(a0)
                bra.s   Sprite_InitializeExplosionSprite
; End of function Effect_SpawnExplosionType1AC
; Sets sprite object pointer from a5 to a0
Sprite_SetObjectPointer:                                ; CODE XREF: Enemy_SpawnQuadProjectiles+A   p  ; was: sub_2A7BC
                                        ; Projectile_FlyerUpdate4+20   j
                movea.w a5,a0
; End of function Sprite_SetObjectPointer
; Initializes sprite object properties at address
Sprite_InitializeProperties:                            ; CODE XREF: Effect_SpawnRandomDebris+3C   p  ; was: sub_2A7BE
                                        ; Sprite_InitProjectile+48   p
                move.w  #$160,(a0)
; Initializes explosion sprite with VDP pattern and attributes
Sprite_InitializeExplosionSprite:                       ; CODE XREF: Projectile_InitType88+4   j  ; was: loc_2A7C2
                                        ; Effect_SpawnExplosionType188+4   j
                move.w  #$ED40,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                rts
; End of function Sprite_InitializeProperties
; Applies gravity to vertical velocity
Physics_ApplyGravity:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A7DE
                addi.l  #$2000,$1C(a5)
; Checks if sprite has exceeded height boundary and sets inactive
Physics_CheckHeightBoundary:                            ; DATA XREF: ROM:off_5DC   o  ; was: loc_2A7E6
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A7F4
                move.w  #$1000,2(a5)
locret_2A7F4:                                           ; CODE XREF: Physics_ApplyGravity+E   j
                rts
; End of function Physics_ApplyGravity
; Hides enemy after delay timer
Enemy_DelayedHide:                                      ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A7F6
                subq.w  #1,$48(a5)
                bpl.s   locret_2A802
                move.w  #$1000,2(a5)
locret_2A802:                                           ; CODE XREF: Enemy_DelayedHide+4   j
                rts
; End of function Enemy_DelayedHide
; Projectile with gravity physics
Projectile_FallWithGravity:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A804
                addi.l  #$3000,$1C(a5)
; Updates projectile trajectory with gravity applied
Projectile_FallWithGravity_Update:                      ; DATA XREF: ROM:off_5DC   o  ; was: loc_2A80C
                bsr.w   Projectile_SetVelocityFromAngle
                bsr.w   Projectile_GetVelocityComponents
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A822
                move.w  #$1000,2(a5)
locret_2A822:                                           ; CODE XREF: Projectile_FallWithGravity+16   j
                rts
; End of function Projectile_FallWithGravity
; Sets velocity from angle table
Projectile_SetVelocityFromAngle:                        ; CODE XREF: Projectile_FallWithGravity:loc_2A80C   p  ; was: sub_2A824
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Projectile_SetVelocityFromAngle
; Gets X/Y velocity from angle
Projectile_GetVelocityComponents:                       ; CODE XREF: Projectile_FallWithGravity+C   p  ; was: sub_2A834
                move.w  a5,d0
                btst    #5,d0
                beq.s   loc_2A84C
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2A854
loc_2A844:                                              ; CODE XREF: Projectile_GetVelocityComponents+1E   j
                bset    #7,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A84C:                                              ; CODE XREF: Projectile_GetVelocityComponents+6   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2A844
loc_2A854:                                              ; CODE XREF: Projectile_GetVelocityComponents+E   j
                bclr    #7,2(a5)
                rts
; End of function Projectile_GetVelocityComponents
; Wrapper to copy a5 register to a0 for sprite operations
Sprite_WrapperA5ToA0:
                movea.w a5,a0                           ; was: sub_2A85C
; End of function Sprite_WrapperA5ToA0
; Initializes debris sprite with velocity from RNG
Effect_InitDebrisSprite:                                ; CODE XREF: Boss_JokerSpawnDebris+18   p  ; was: sub_2A85E
                                        ; Boss_BackStringerSpawnDebris+1C   p
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
Projectile_FallingDebris:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8A2
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A8B8
                move.w  #$1000,2(a5)
locret_2A8B8:                                           ; CODE XREF: Projectile_FallingDebris+E   j
                rts
; End of function Projectile_FallingDebris
; Clears sprites for inactive objects with specific IDs checking flags
Sprite_ClearInactiveObjects:                            ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8BA
                bset    #4,2(a5)
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$12C,d0
                move.w  #$134,d1
loc_2A8CC:                                              ; CODE XREF: Sprite_ClearInactiveObjects+30   j
                cmp.w   (a0),d0
                beq.s   loc_2A8D4
                cmp.w   (a0),d1
                bne.s   loc_2A8E2
loc_2A8D4:                                              ; CODE XREF: Sprite_ClearInactiveObjects+14   j
                btst    #1,2(a0)
                bne.s   loc_2A8E2
                jsr     (Sys_Clear96ByteBlock).l
loc_2A8E2:                                              ; CODE XREF: Sprite_ClearInactiveObjects+18   j
                                        ; Sprite_ClearInactiveObjects+20   j
                lea     $60(a0),a0
                cmpa.w  #$DCA0,a0
                bmi.s   loc_2A8CC
                rts
; End of function Sprite_ClearInactiveObjects
; Initializes enemy sprite graphics mode and animation pointer
Enemy_InitSpriteGraphics:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8EE
                tst.w   4(a5)
                bne.w   locret_2A922
                addq.w  #2,4(a5)
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   loc_2A910
                move.w  #$E100,2(a5)
loc_2A910:                                              ; CODE XREF: Enemy_InitSpriteGraphics+1A   j
                move.l  off_2A924(pc,d0.w),8(a5)
                move.w  dword_2A928(pc,d0.w),$E(a5)
                move.b  dword_2A928+1(pc,d0.w),$20(a5)
locret_2A922:                                           ; CODE XREF: Enemy_InitSpriteGraphics+4   j
                rts
; End of function Enemy_InitSpriteGraphics
; ---------------------------------------------------------------------------
off_2A924:      dc.l    off_19C4DE                      ; DATA XREF: Enemy_InitSpriteGraphics:loc_2A910   r
dword_2A928:    dc.l    $2DF6000                        ; DATA XREF: Enemy_InitSpriteGraphics+28   r
                dc.l    off_19C4F2
                dc.l    $2DF6000
                dc.l    off_19C506
                dc.l    $2DF6000
                dc.l    off_19C52E
                dc.l    $2DF6400
                dc.l    off_19C55E
                dc.l    $2DF6000

; Destroys projectile if offscreen
Projectile_DestroyOffscreen:                            ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A94C
                tst.w   4(a5)
                bne.w   locret_2A9D6
                move.w  $5E(a5),d0
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   loc_2A96E
                move.w  #$E100,2(a5)
loc_2A96E:                                              ; CODE XREF: Projectile_DestroyOffscreen+1A   j
                lea     off_2AA04(pc),a0
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
loc_2A99E:                                              ; CODE XREF: Projectile_DestroyOffscreen+88   j
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
                bne.s   loc_2A99E
locret_2A9D6:                                           ; CODE XREF: Projectile_DestroyOffscreen+4   j
                rts
; End of function Projectile_DestroyOffscreen
; ---------------------------------------------------------------------------
off_2A9D8:      dc.l    word_19C4A4                     ; DATA XREF: ROM:off_2AA04   o
                dc.l    $2D66000, $40FFE0
                dc.l    $FFE8, $FFF0
                dc.l    $FFF8, 0
                dc.l    8, $10
                dc.l    $18, $8000
off_2AA04:      dc.l    off_2A9D8                       ; DATA XREF: Projectile_DestroyOffscreen:loc_2A96E   o

; Debug sprite editor for adjusting tile, palette, flip, position interactively
