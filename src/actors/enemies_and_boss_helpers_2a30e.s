Boss_CheckVisibilityTimer:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A30E
                cmpi.w  #$80,$C(a5)
                bmi.s   loc_2A31E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A31E:                              ; CODE XREF: Boss_CheckVisibilityTimer+6   j
                subq.w  #1,$48(a5)
                bpl.s   locret_2A328
                clr.b   $21(a5)
locret_2A328:                           ; CODE XREF: Boss_CheckVisibilityTimer+14   j
                rts
; End of function Boss_CheckVisibilityTimer
; Spawns Jetsripper boss projectile with initial state
Boss_SpawnProjectile:                              ; CODE XREF: Boss_JetsripperMain+90   p  ; was: sub_2A32A
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
                move.b  #$40,$21(a0) ; '@'
                move.l  #$F001F010,$2C(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_SpawnProjectile
; Spawns projectile at specified position
Projectile_SpawnAtPosition:                              ; CODE XREF: Enemy_ShipSpawnDebrisProjectile   p  ; was: sub_2A390
                                        ; sub_3A122   p ...
                subq.w  #1,(word_FF809E).w
                bpl.s   loc_2A3C0
                move.w  #$FFFF,(word_FF809E).w
; End of function Projectile_SpawnAtPosition
; Initializes projectile type 0xA4
Projectile_InitTypeA4:                              ; CODE XREF: Boss_ShiperSpawnDebris+6   p  ; was: sub_2A39C
                                        ; Boss_AntroidSpawnDebris+8   p ...
                move.w  (word_FFA000).w,d0
                move.w  d0,d1
                andi.w  #$1F,d1
                beq.s   loc_2A3B6
                andi.w  #7,d1
                bne.s   loc_2A3C0
                btst    #3,(dword_FFFF08).w
                beq.s   loc_2A3C0
loc_2A3B6:                              ; CODE XREF: Projectile_InitTypeA4+A   j
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
loc_2A3C0:                              ; CODE XREF: Projectile_SpawnAtPosition+4   j
                                        ; Projectile_InitTypeA4+10   j ...
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_2A3E4
                movea.l #dword_2ABF0,a1 ; make offsets?
                move.w  (dword_FFFF08).w,d6
                move.w  d6,d1
                andi.w  #$300,d6
                bne.s   loc_2A3E2
                movea.l #dword_2ACA6,a1
loc_2A3E2:                              ; CODE XREF: Projectile_InitTypeA4+3E   j
                moveq   #0,d0
locret_2A3E4:                           ; CODE XREF: Projectile_InitTypeA4+2A   j
                rts
; End of function Projectile_InitTypeA4
; Plays random explosion sound effects with timer countdown
Effect_PlayRandomExplosionSound:                              ; CODE XREF: Boss_DestroyerProtoSpawnProjectile2+12   p  ; was: sub_2A3E6
                                        ; sub_3B602   p ...
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
loc_2A40C:                              ; CODE XREF: Effect_PlayRandomExplosionSound+16   j
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_2A416:                           ; CODE XREF: Effect_PlayRandomExplosionSound+1C   j
                                        ; Effect_PlayRandomExplosionSound+24   j
                rts
; End of function Effect_PlayRandomExplosionSound
; Spawns explosion projectile with sound
Boss_CaterpillarSpawnExplosion:                              ; CODE XREF: Boss_CaterpillarPart2+4C   j  ; was: sub_2A418
                                        ; Boss_CaterpillarPart3+40   j ...
                movea.w a5,a0
                bsr.w Projectile_InitType88
                move.l  #off_E953C,8(a0)
                clr.l   $18(a0)
                move.l  #$FFFC0000,$1C(a0)
                move.b  #4,$20(a0)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$BC,d0
                jmp (Sound_PlaySFX).l
; End of function Boss_CaterpillarSpawnExplosion
; Spawns 4 projectiles in different directions using sine/cosine table
Projectile_SpawnFourDirectional:
                movea.w a0,a3  ; was: sub_2A44E
                movea.l #word_1B514,a4
                move.w  #$150,d6
                moveq   #3,d7
loc_2A45C:                              ; CODE XREF: Projectile_SpawnFourDirectional+4A   j
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_2A49C
                movea.l #dword_2ABF0,a1 ; make offsets?
                bsr.w Sprite_InitWithDefaultState
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
                addi.w  #$20,d6 ; ' '
                dbf     d7,loc_2A45C
locret_2A49C:                           ; CODE XREF: Projectile_SpawnFourDirectional+14   j
                rts
; End of function Projectile_SpawnFourDirectional
; ---------------------------------------------------------------------------
unused_7:	binclude	"data/other/unused_7.bin"


; Initializes small explosion effect sprite with sound effect $BB
Effect_InitSmallExplosion:
                movea.w a5,a0  ; was: sub_2A4BE
                move.w  #$A8,(a0)
                clr.w   2(a0)
                clr.b   $21(a0)
                clr.w   $48(a0)
                move.w  #4,$4A(a0)
                move.b  #$BB,d0
                jmp (Sound_PlaySFX).l
; End of function Effect_InitSmallExplosion
; Sets screen shake intensity values to 2
Sys_SetScreenShake:
                move.w  #2,(word_FFA010).w  ; was: sub_2A4E0
                move.w  #2,(word_FFA014).w
                rts
; End of function Sys_SetScreenShake
; Spawns particle effects at intervals with random position offsets
Effect_SpawnParticleLoop:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A4EE
                subq.w  #1,$48(a5)
                bpl.s   locret_2A554
                move.w  #2,$48(a5)
                subq.w  #1,$4A(a5)
                bpl.s   loc_2A506
                bset    #4,2(a5)
loc_2A506:                              ; CODE XREF: Effect_SpawnParticleLoop+10   j
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_2A554
                movea.l #dword_2AC74,a1
                bsr.w Projectile_FindFreeSlotComplex
                move.b  (dword_FFFF08+1).w,d0
                move.b  (dword_FFFF08+2).w,d1
                andi.w  #$F,d0
                andi.w  #$F,d1
                btst    #0,(dword_FFFF08).w
                beq.s   loc_2A534
                neg.w   d0
loc_2A534:                              ; CODE XREF: Effect_SpawnParticleLoop+42   j
                btst    #1,(dword_FFFF08).w
                beq.s   loc_2A53E
                neg.w   d1
loc_2A53E:                              ; CODE XREF: Effect_SpawnParticleLoop+4C   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                jmp     (RandomNumber).l
; ---------------------------------------------------------------------------
locret_2A554:                           ; CODE XREF: Effect_SpawnParticleLoop+4   j
                                        ; Effect_SpawnParticleLoop+1E   j
                rts
; End of function Effect_SpawnParticleLoop
; Initializes larger explosion effect type $180 with sound effect $BB
Effect_InitLargeExplosion:
                movea.w a5,a0  ; was: sub_2A556
                move.l  d0,$48(a0)
                move.w  #$180,(a0)
                move.w  #$FC0,2(a0)
                clr.b   $21(a0)
                clr.w   $48(a0)
                move.b  #$BB,d0
                jmp (Sound_PlaySFX).l
; End of function Effect_InitLargeExplosion
; Falling projectile that spawns child projectiles periodically
Projectile_FallingSpawner:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A578
                addi.l  #$3000,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_2A5B4
                move.w  #2,$48(a5)
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2A5B4
                move.l  #off_E95C0,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFEE000,$1C(a0)
                bra.w Projectile_InitType88
; ---------------------------------------------------------------------------
locret_2A5B4:                           ; CODE XREF: Projectile_FallingSpawner+C   j
                                        ; Projectile_FallingSpawner+1A   j
                rts
; End of function Projectile_FallingSpawner
; Spawns 4 projectiles in pattern with sound
Enemy_SpawnQuadProjectiles:                              ; CODE XREF: Enemy_SpawnParticleHardMode:loc_2D664   j  ; was: sub_2A5B6
                                        ; Enemy_ClearAndSpawnQuadProjectiles+14   j ...
                movea.w a5,a0
                move.l  #off_E95DC,8(a5)
                bsr.w Sprite_SetObjectPointer
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                lea     word_2A604(pc),a2
                nop
                moveq   #3,d7
; Updates quad projectile spawn with trajectory calculation
Projectile_UpdateQuadSpawn:                              ; CODE XREF: Enemy_SpawnQuadProjectiles+48   j  ; was: loc_2A5D6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2A602
                move.l  #off_E95A4,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (a2)+,$18(a0)
                move.w  (a2)+,$1C(a0)
                bsr.w Sprite_InitializeProperties
                dbf d7,Projectile_UpdateQuadSpawn
locret_2A602:                           ; CODE XREF: Enemy_SpawnQuadProjectiles+26   j
                rts
; End of function Enemy_SpawnQuadProjectiles
; ---------------------------------------------------------------------------
word_2A604:     dc.w $FFFF, $FFFF, 1, $FFFF, $FFFF, 1, 1, 1
                                        ; DATA XREF: Enemy_SpawnQuadProjectiles+18   o


; Passes object address from a5 to a0
Sys_PassObjectAddress:                              ; CODE XREF: Sprite_HandleProjectileCollision+14   p  ; was: sub_2A614
                                        ; Weapon_UpdateBombProjectile+16   p ...
                movea.w a5,a0
; End of function Sys_PassObjectAddress
; Initializes sprite object from data table
Sprite_InitFromTable:                              ; CODE XREF: Effect_SpawnStarParticle+10   p  ; was: sub_2A616
                                        ; Effect_SpawnParticle+24   p ...
                move.w  #$38,(a0) ; '8'
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
                bsr.w Sys_PassObjectAddress  ; was: sub_2A642
                move.w  #$58,(a0) ; 'X'
                rts
; End of function Sprite_InitType58Default
; Initializes sprite from table pointer and sets default state value
Sprite_InitWithDefaultState:                              ; CODE XREF: Projectile_SpawnFourDirectional+1E   p  ; was: sub_2A64C
                                        ; Boss_ShiperSpawnDebris+E   p
                bsr.w Sprite_InitFromTable
                move.w  #$58,(a0) ; 'X'
                rts
; End of function Sprite_InitWithDefaultState
; Initializes sprite type $68 using default address passing
Sprite_InitType68Default:
                bsr.w Sys_PassObjectAddress  ; was: sub_2A656
                move.w  #$68,(a0) ; 'h'
                rts
; End of function Sprite_InitType68Default
; Initializes sprite type $68 from initialization table
Sprite_InitType68FromTable:
                bsr.w Sprite_InitFromTable  ; was: sub_2A660
                move.w  #$68,(a0) ; 'h'
                rts
; End of function Sprite_InitType68FromTable
; Initializes sprite type $94 using default address passing
Sprite_InitType94Default:
                bsr.w Sys_PassObjectAddress  ; was: sub_2A66A
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94Default
; Initializes sprite type $94 from initialization table
Sprite_InitType94FromTable:                              ; CODE XREF: Boss_ShiperSpawnAngledProjectile+16   p  ; was: sub_2A674
                bsr.w Sprite_InitFromTable
                move.w  #$94,(a0)
                rts
; End of function Sprite_InitType94FromTable
; Spawns effect object of specific type at current position
Effect_SpawnObjectType:                              ; CODE XREF: Effect_SpawnKnockbackParticle+44   p  ; was: sub_2A67E
                                        ; Effect_SpawnKnockbackParticle+76   j ...
                bsr.w Sys_PassObjectAddress
                move.w  #$A4,(a0)
                rts
; End of function Effect_SpawnObjectType
; Finds free projectile slot with complex checks
Projectile_FindFreeSlotComplex:                              ; CODE XREF: Sprite_SpawnParticleEffect:loc_18C8C   p  ; was: sub_2A688
                                        ; Effect_SpawnParticleLoop+28   p ...
                bsr.w Sprite_InitFromTable
                move.w  #$A4,(a0)
                rts
; End of function Projectile_FindFreeSlotComplex
; Updates animation frame and swaps palette based on frame counter
Anim_UpdateWithPaletteSwap:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A692
                bsr.w Anim_UpdateSpriteFrame
                andi.w  #$9FFF,$E(a5)
                btst    #1,(word_FFA000+1).w
                bne.s   loc_2A6AC
                ori.w   #$4000,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A6AC:                              ; CODE XREF: Anim_UpdateWithPaletteSwap+10   j
                ori.w   #$6000,$E(a5)
                rts
; End of function Anim_UpdateWithPaletteSwap
; Initializes projectile from data table
Projectile_InitializeFromTable:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A6B4
                bsr.w Anim_UpdateSpriteFrame
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
Physics_ApplyUpwardVelocity:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A6D0
                addi.l  #$8000,$1C(a5)
; End of function Physics_ApplyUpwardVelocity
; Updates sprite animation frame timer and data
Anim_UpdateSpriteFrame:                              ; CODE XREF: Cutscene_XiTigerFadeOut+C   p  ; was: sub_2A6D8
                                        ; sub_2A692   p ...
                subq.w  #1,$4C(a5)
                bne.s   locret_2A700
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s Sprite_SetBossInactiveState
                move.w  (a0)+,$E(a5)
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
locret_2A700:                           ; CODE XREF: Anim_UpdateSpriteFrame+4   j
                rts
; ---------------------------------------------------------------------------
; Sets boss sprite to inactive state with special tile pattern
Sprite_SetBossInactiveState:                              ; CODE XREF: Anim_UpdateSpriteFrame+E   j  ; was: loc_2A702
                move.w  #$1000,2(a5)
                rts
; End of function Anim_UpdateSpriteFrame
; Final phase boss handler
Boss_Epsilon1FinalPhase:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A70A
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
loc_2A72C:                              ; CODE XREF: Boss_Epsilon1FinalPhase+6   j
                movea.l $48(a5),a0
                move.l  $4C(a5),$1C(a5)
                move.l  $50(a5),$18(a5)
                jmp     (a0)
; End of function Boss_Epsilon1FinalPhase
; Animates sprite tile and size from script table, disables sprite on end marker
Gfx_AnimateSpriteTileAndDisable:
                subq.w  #1,$4C(a5)  ; was: sub_2A73E
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
locret_2A764:                           ; CODE XREF: Gfx_AnimateSpriteTileAndDisable+4   j
                rts
; ---------------------------------------------------------------------------
loc_2A766:                              ; CODE XREF: Gfx_AnimateSpriteTileAndDisable+E   j
                andi.w  #$7FFF,2(a5)
                rts
; End of function Gfx_AnimateSpriteTileAndDisable
; Animates sprite tile and size from script table with loop support
Gfx_AnimateSpriteTileLoop:                              ; CODE XREF: Projectile_BouncingWithGravity:loc_2B6A4   p  ; was: sub_2A76E
                subq.w  #1,$4C(a5)
                bne.s   locret_2A794
loc_2A774:                              ; CODE XREF: Gfx_AnimateSpriteTileLoop+2C   j
                movea.l $48(a5),a0
                move.w  (a0)+,$4C(a5)
                bmi.s   loc_2A796
                move.w  (a0)+,d0
                move.w  (a0)+,8(a5)
                move.w  (a0)+,$A(a5)
                move.l  a0,$48(a5)
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
locret_2A794:                           ; CODE XREF: Gfx_AnimateSpriteTileLoop+4   j
                rts
; ---------------------------------------------------------------------------
loc_2A796:                              ; CODE XREF: Gfx_AnimateSpriteTileLoop+E   j
                move.l  (a0)+,$48(a5)
                bra.s   loc_2A774
; End of function Gfx_AnimateSpriteTileLoop
; Returns entity address in register A0 for manipulation
Enemy_GetEntityAddress:                              ; CODE XREF: Sprite_ShipDebrisUpdate+28   p  ; was: sub_2A79C
                                        ; Projectile_GravityBounce+50   j ...
                movea.w a5,a0
; End of function Enemy_GetEntityAddress
; Initializes projectile with type 0x88
Projectile_InitType88:                              ; CODE XREF: Player_InitShotProjectile   p  ; was: sub_2A79E
                                        ; Boss_CaterpillarSpawnExplosion+2   p ...
                move.w  #$88,(a0)
                bra.s Sprite_InitializeExplosionSprite
; End of function Projectile_InitType88
; Copies seeking missile object address to a0 register for processing
Weapon_CopySeekingMissileAddress:                              ; CODE XREF: Weapon_UpdateSeekingMissile+26   j  ; was: sub_2A7A4
                movea.w a5,a0
; End of function Weapon_CopySeekingMissileAddress
; Spawns explosion effect type 0x188 at current location
Effect_SpawnExplosionType188:                              ; CODE XREF: Weapon_SpawnHomingEffect+EE   p  ; was: sub_2A7A6
                                        ; Enemy_TrailingExplosionSpawner+4C   p ...
                move.w  #$188,(a0)
                bra.s Sprite_InitializeExplosionSprite
; End of function Effect_SpawnExplosionType188
; Wrapper to copy a5 register to a0 for effect initialization
Effect_WrapperA5ToA0:
                movea.w a5,a0  ; was: sub_2A7AC
; End of function Effect_WrapperA5ToA0
; Initializes projectile type 2A
Projectile_InitType2A:                              ; CODE XREF: Projectile_SpawnQuadPattern+14   p  ; was: sub_2A7AE
                                        ; Enemy_SpawnProjectileAtAngle+8   p ...
                move.w  #$1A8,(a0)
                bra.s Sprite_InitializeExplosionSprite
; End of function Projectile_InitType2A
; Spawns explosion effect with sprite type 1AC
Effect_SpawnExplosionType1AC:
                movea.w a5,a0  ; was: sub_2A7B4
                move.w  #$1AC,(a0)
                bra.s Sprite_InitializeExplosionSprite
; End of function Effect_SpawnExplosionType1AC
; Sets sprite object pointer from a5 to a0
Sprite_SetObjectPointer:                              ; CODE XREF: Enemy_SpawnQuadProjectiles+A   p  ; was: sub_2A7BC
                                        ; Projectile_FlyerUpdate4+20   j ...
                movea.w a5,a0
; End of function Sprite_SetObjectPointer
; Initializes sprite object properties at address
Sprite_InitializeProperties:                              ; CODE XREF: Effect_SpawnRandomDebris+3C   p  ; was: sub_2A7BE
                                        ; Sprite_InitProjectile+48   p ...
                move.w  #$160,(a0)
; Initializes explosion sprite with VDP pattern and attributes
Sprite_InitializeExplosionSprite:                              ; CODE XREF: Projectile_InitType88+4   j  ; was: loc_2A7C2
                                        ; Effect_SpawnExplosionType188+4   j ...
                move.w  #$ED40,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                rts
; End of function Sprite_InitializeProperties
; Applies gravity to vertical velocity
Physics_ApplyGravity:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A7DE
                addi.l  #$2000,$1C(a5)
; Checks if sprite has exceeded height boundary and sets inactive
Physics_CheckHeightBoundary:                              ; DATA XREF: ROM:off_5DC   o  ; was: loc_2A7E6
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A7F4
                move.w  #$1000,2(a5)
locret_2A7F4:                           ; CODE XREF: Physics_ApplyGravity+E   j
                rts
; End of function Physics_ApplyGravity
; Hides enemy after delay timer
Enemy_DelayedHide:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A7F6
                subq.w  #1,$48(a5)
                bpl.s   locret_2A802
                move.w  #$1000,2(a5)
locret_2A802:                           ; CODE XREF: Enemy_DelayedHide+4   j
                rts
; End of function Enemy_DelayedHide
; Projectile with gravity physics
Projectile_FallWithGravity:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A804
                addi.l  #$3000,$1C(a5)
; Updates projectile trajectory with gravity applied
Projectile_FallWithGravity_Update:                              ; DATA XREF: ROM:off_5DC   o  ; was: loc_2A80C
                bsr.w Projectile_SetVelocityFromAngle
                bsr.w Projectile_GetVelocityComponents
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A822
                move.w  #$1000,2(a5)
locret_2A822:                           ; CODE XREF: Projectile_FallWithGravity+16   j
                rts
; End of function Projectile_FallWithGravity
; Sets velocity from angle table
Projectile_SetVelocityFromAngle:                              ; CODE XREF: Projectile_FallWithGravity:loc_2A80C   p  ; was: sub_2A824
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Projectile_SetVelocityFromAngle
; Gets X/Y velocity from angle
Projectile_GetVelocityComponents:                              ; CODE XREF: Projectile_FallWithGravity+C   p  ; was: sub_2A834
                move.w  a5,d0
                btst    #5,d0
                beq.s   loc_2A84C
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2A854
loc_2A844:                              ; CODE XREF: Projectile_GetVelocityComponents+1E   j
                bset    #7,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2A84C:                              ; CODE XREF: Projectile_GetVelocityComponents+6   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2A844
loc_2A854:                              ; CODE XREF: Projectile_GetVelocityComponents+E   j
                bclr    #7,2(a5)
                rts
; End of function Projectile_GetVelocityComponents
; Wrapper to copy a5 register to a0 for sprite operations
Sprite_WrapperA5ToA0:
                movea.w a5,a0  ; was: sub_2A85C
; End of function Sprite_WrapperA5ToA0
; Initializes debris sprite with velocity from RNG
Effect_InitDebrisSprite:                              ; CODE XREF: Boss_JokerSpawnDebris+18   p  ; was: sub_2A85E
                                        ; Boss_BackStringerSpawnDebris+1C   p ...
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
Projectile_FallingDebris:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8A2
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2A8B8
                move.w  #$1000,2(a5)
locret_2A8B8:                           ; CODE XREF: Projectile_FallingDebris+E   j
                rts
; End of function Projectile_FallingDebris
; Clears sprites for inactive objects with specific IDs checking flags
Sprite_ClearInactiveObjects:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8BA
                bset    #4,2(a5)
                movea.w #(word_FFC620-M68K_RAM),a0
                move.w  #$12C,d0
                move.w  #$134,d1
loc_2A8CC:                              ; CODE XREF: Sprite_ClearInactiveObjects+30   j
                cmp.w   (a0),d0
                beq.s   loc_2A8D4
                cmp.w   (a0),d1
                bne.s   loc_2A8E2
loc_2A8D4:                              ; CODE XREF: Sprite_ClearInactiveObjects+14   j
                btst    #1,2(a0)
                bne.s   loc_2A8E2
                jsr (Sys_Clear96ByteBlock).l
loc_2A8E2:                              ; CODE XREF: Sprite_ClearInactiveObjects+18   j
                                        ; Sprite_ClearInactiveObjects+20   j
                lea     $60(a0),a0
                cmpa.w  #$DCA0,a0
                bmi.s   loc_2A8CC
                rts
; End of function Sprite_ClearInactiveObjects
; Initializes enemy sprite graphics mode and animation pointer
Enemy_InitSpriteGraphics:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A8EE
                tst.w   4(a5)
                bne.w   locret_2A922
                addq.w  #2,4(a5)
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   loc_2A910
                move.w  #$E100,2(a5)
loc_2A910:                              ; CODE XREF: Enemy_InitSpriteGraphics+1A   j
                move.l  off_2A924(pc,d0.w),8(a5)
                move.w  dword_2A928(pc,d0.w),$E(a5)
                move.b  dword_2A928+1(pc,d0.w),$20(a5)
locret_2A922:                           ; CODE XREF: Enemy_InitSpriteGraphics+4   j
                rts
; End of function Enemy_InitSpriteGraphics
; ---------------------------------------------------------------------------
off_2A924:      dc.l off_19C4DE         ; DATA XREF: Enemy_InitSpriteGraphics:loc_2A910   r
dword_2A928:    dc.l $2DF6000           ; DATA XREF: Enemy_InitSpriteGraphics+28   r
                dc.l off_19C4F2
                dc.l $2DF6000
                dc.l off_19C506
                dc.l $2DF6000
                dc.l off_19C52E
                dc.l $2DF6400
                dc.l off_19C55E
                dc.l $2DF6000


; Destroys projectile if offscreen
Projectile_DestroyOffscreen:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2A94C
                tst.w   4(a5)
                bne.w   locret_2A9D6
                move.w  $5E(a5),d0
                move.w  #$E300,2(a5)
                move.w  $5E(a5),d0
                bclr    #$F,d0
                beq.s   loc_2A96E
                move.w  #$E100,2(a5)
loc_2A96E:                              ; CODE XREF: Projectile_DestroyOffscreen+1A   j
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
loc_2A99E:                              ; CODE XREF: Projectile_DestroyOffscreen+88   j
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                add.w   $A(a0,d6.w),d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
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
locret_2A9D6:                           ; CODE XREF: Projectile_DestroyOffscreen+4   j
                rts
; End of function Projectile_DestroyOffscreen
; ---------------------------------------------------------------------------
off_2A9D8:      dc.l word_19C4A4        ; DATA XREF: ROM:off_2AA04   o
                dc.l $2D66000, $40FFE0
                dc.l $FFE8, $FFF0
                dc.l $FFF8, 0
                dc.l 8, $10
                dc.l $18, $8000
off_2AA04:      dc.l off_2A9D8          ; DATA XREF: Projectile_DestroyOffscreen:loc_2A96E   o


; Debug sprite editor for adjusting tile, palette, flip, position interactively
UI_DebugSpriteEditor:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2AA08
                btst    #7,(word_FFF706).w
                beq.w   loc_2AA1A
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2AA1A:                              ; CODE XREF: UI_DebugSpriteEditor+6   j
                move.w  #$8000,2(a5)
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                move.w  $E(a5),d0
                btst    #6,(word_FFF706).w
                beq.w   loc_2AA5A
                btst    #0,(word_FFF706).w
                beq.w   loc_2AA4A
                addq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA4A:                              ; CODE XREF: UI_DebugSpriteEditor+38   j
                btst    #1,(word_FFF706).w
                beq.w   loc_2AA8A
                subq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA5A:                              ; CODE XREF: UI_DebugSpriteEditor+2E   j
                btst    #4,(word_FFF706).w
                bne.w   loc_2AA8A
                btst    #5,(word_FFF706).w
                bne.w   loc_2AA8A
                btst    #0,(word_FFF708).w
                beq.w   loc_2AA7E
                addq.w  #1,d0
                bra.w   loc_2AA8A
; ---------------------------------------------------------------------------
loc_2AA7E:                              ; CODE XREF: UI_DebugSpriteEditor+6C   j
                btst    #1,(word_FFF708).w
                beq.w   loc_2AA8A
                subq.w  #1,d0
loc_2AA8A:                              ; CODE XREF: UI_DebugSpriteEditor+3E   j
                                        ; UI_DebugSpriteEditor+48   j ...
                andi.w  #$7FF,d0
                andi.w  #$9800,$E(a5)
                or.w    d0,$E(a5)
                btst    #4,(word_FFF706).w
                beq.w   loc_2AAE8
                btst    #0,(word_FFF708).w
                beq.w   loc_2AAB2
                addi.w  #$2000,$48(a5)
loc_2AAB2:                              ; CODE XREF: UI_DebugSpriteEditor+A0   j
                andi.w  #$6000,$48(a5)
                move.w  $48(a5),d0
                or.w    d0,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                btst    #1,(word_FFF708).w
                beq.w   loc_2AAD8
                eori.w  #$1000,$E(a5)
loc_2AAD8:                              ; CODE XREF: UI_DebugSpriteEditor+C6   j
                btst    #3,(word_FFF708).w
                beq.w   loc_2AAE8
                eori.w  #$800,$E(a5)
loc_2AAE8:                              ; CODE XREF: UI_DebugSpriteEditor+96   j
                                        ; UI_DebugSpriteEditor+D6   j
                btst    #5,(word_FFF706).w
                beq.w   locret_2AB48
                btst    #0,(word_FFF708).w
                beq.w   loc_2AB02
                addi.w  #$100,8(a5)
loc_2AB02:                              ; CODE XREF: UI_DebugSpriteEditor+F0   j
                andi.w  #$F00,8(a5)
                btst    #1,(word_FFF708).w
                beq.w   loc_2AB28
                move.w  $A(a5),d0
                andi.w  #$FF,$A(a5)
                addi.w  #$100,d0
                andi.w  #$FF00,d0
                or.w    d0,$A(a5)
loc_2AB28:                              ; CODE XREF: UI_DebugSpriteEditor+106   j
                btst    #3,(word_FFF708).w
                beq.w   locret_2AB48
                move.w  $A(a5),d0
                andi.w  #$FF00,$A(a5)
                addi.w  #1,d0
                andi.w  #$FF,d0
                or.w    d0,$A(a5)
locret_2AB48:                           ; CODE XREF: UI_DebugSpriteEditor+E6   j
                                        ; UI_DebugSpriteEditor+126   j
                rts
; End of function UI_DebugSpriteEditor
; Debug sprite position editor for moving sprites with collision detection
UI_DebugSpritePositionEditor:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2AB4A
                tst.w   4(a5)
                bne.w   loc_2AB66
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
loc_2AB66:                              ; CODE XREF: UI_DebugSpritePositionEditor+4   j
                ori.w   #$8000,2(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2AB88
                move.w  #$C4AC,$E(a5)
                bra.s   loc_2AB8E
; ---------------------------------------------------------------------------
loc_2AB88:                              ; CODE XREF: UI_DebugSpritePositionEditor+34   j
                move.w  #$C4B4,$E(a5)
loc_2AB8E:                              ; CODE XREF: UI_DebugSpritePositionEditor+3C   j
                btst    #0,(word_FFF706).w
                beq.s   loc_2ABA6
                moveq   #0,d0
                moveq   #$FFFFFFFC,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_2ABA6
                subq.w  #2,$14(a5)
loc_2ABA6:                              ; CODE XREF: UI_DebugSpritePositionEditor+4A   j
                                        ; UI_DebugSpritePositionEditor+56   j
                btst    #1,(word_FFF706).w
                beq.s   loc_2ABBE
                moveq   #0,d0
                moveq   #4,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_2ABBE
                addq.w  #2,$14(a5)
loc_2ABBE:                              ; CODE XREF: UI_DebugSpritePositionEditor+62   j
                                        ; UI_DebugSpritePositionEditor+6E   j
                btst    #2,(word_FFF706).w
                beq.s   loc_2ABD6
                moveq   #$FFFFFFFC,d0
                moveq   #0,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   loc_2ABD6
                subq.w  #2,$10(a5)
loc_2ABD6:                              ; CODE XREF: UI_DebugSpritePositionEditor+7A   j
                                        ; UI_DebugSpritePositionEditor+86   j
                btst    #3,(word_FFF706).w
                beq.s   locret_2ABEE
                moveq   #4,d0
                moveq   #0,d1
                jsr (Physics_AddEntityOffset).l
                bne.s   locret_2ABEE
                addq.w  #2,$10(a5)
locret_2ABEE:                           ; CODE XREF: UI_DebugSpritePositionEditor+92   j
                                        ; UI_DebugSpritePositionEditor+9E   j
                rts
; End of function UI_DebugSpritePositionEditor
; ---------------------------------------------------------------------------
dword_2ABF0:    dc.l $1454B, $F00F0F0   ; DATA XREF: Projectile_UpdateWithSpawning+24   o
                                        ; Projectile_UpdateWithSpawning+A4   o ...
                dc.l $1456C, $F00F0F0   ; make offsets?
                dc.l $14480, $A00F4F4
                dc.l $34489, $A00F4F4
                dc.l $34492, $A00F4F4
                dc.l $3449B, $A00F4F4
                dc.l $244A4, $500F8F8
                dc.l $144A8, $500F8F8
                dc.w $FFFF
dword_2AC32:    dc.l $1454B, $F00F0F0   ; DATA XREF: Boss_ArtemisSpawnReflectedProjectile+10   o
                dc.l $1456C, $F00F0F0
                dc.l $24480, $A00F4F4
                dc.l $24489, $A00F4F4
                dc.l $24492, $A00F4F4
                dc.l $2449B, $A00F4F4
                dc.l $144A4, $500F8F8
                dc.l $144A8, $500F8F8
                dc.w $FFFF
dword_2AC74:    dc.l $24480, $A00F4F4   ; DATA XREF: Effect_SpawnParticleLoop+22   o
                dc.l $24489, $A00F4F4
                dc.l $24492, $A00F4F4
                dc.l $2449B, $A00F4F4
                dc.l $244A4, $500F8F8
                dc.l $244A8, $500F8F8
                dc.w $FFFF
dword_2ACA6:    dc.l $244AC, $500F8F8   ; DATA XREF: Weapon_HandleProjectileHit+20   o
                                        ; Weapon_HandleExplosiveImpact+72   o ...
                dc.l $244B0, $500F8F8
                dc.l $244B4, $500F8F8
                dc.l $244B8, $500F8F8
                dc.l $144E8, $500F8F8
                dc.w $FFFF
dword_2ACD0:    dc.l $244F6, $FCFC      ; DATA XREF: Enemy_SpawnAnimatedProjectile+A   o
                dc.l $244F7, $FCFC
                dc.l $244F8, $FCFC
                dc.l $24CF7, $FCFC
                dc.l $24CF6, $FCFC
                dc.l $25CF7, $FCFC
                dc.l $254F8, $FCFC
                dc.l $254F7, $FCFC
                dc.l $FFFF0002
                dc.w $ACD0
dword_2AD16:    dc.l $244AC, $500F8F8   ; DATA XREF: Effect_SpawnKnockbackParticle+70   o
                                        ; Projectile_ExplodeOnWall+A0   o
                dc.l $244C4, $500F8F8
                dc.w $FFFF
dword_2AD28:    dc.l $364CC, $500F8F8   ; DATA XREF: Boss_TerobusterAttackPattern3+4A   o
                                        ; Boss_TerobusterSpawnProjectile+12   o
                dc.l $264D0, $500F8F8
                dc.l $264D4, $FCFC
                dc.l $264D5, $FCFC
                dc.w $FFFF
dword_2AD4A:    dc.l $344CC, $500F8F8   ; DATA XREF: Boss_ViblackProjectileAttack:loc_43CCE   o
                                        ; Boss_WolfGaropaCollision+20   o
                dc.l $244D0, $500F8F8
                dc.l $244D4, $FCFC
                dc.l $244D5, $FCFC
                dc.w $FFFF
dword_2AD6C:    dc.l $24480, $A00F4F4   ; DATA XREF: Enemy_HomingMissileUpdate+80   o
                                        ; Boss_TerobusterSpawnFallingRock+40   o
                dc.l $244CC, $500F8F8
                dc.l $244D0, $500F8F8
                dc.l $144D4, $FCFC
                dc.l $144D5, $FCFC
                dc.w $FFFF
                dc.l $244FA, $FCFC
                dc.l $244FB, $FCFC
                dc.l $244FA, $FCFC
                dc.l $244FB, $FCFC
                dc.l $144FC, $FCFC
                dc.l $144FD, $FCFC
                dc.w $FFFF
dword_2ADC8:    dc.l $24480, $A00F4F4   ; DATA XREF: Weapon_InitSpreadShot+16   o
                                        ; Projectile_Epsilon1SpreadSetup+16   o ...
dword_2ADD0:    dc.l $244D6, $A00F4F4   ; DATA XREF: Weapon_FireProjectile+70   o
                dc.l $244DF, $A00F4F4
                dc.l $244D6, $A00F4F4
                dc.l $244BC, $500F8F8
                dc.l $244C0, $500F8F8
                dc.w $FFFF
dword_2ADFA:    dc.l $24562, $FCFC      ; DATA XREF: Effect_CreateDashTrail+80   o
                dc.l $34561, $400F8FC
                dc.l $44560, $800F4FC
                dc.w $FFFF
dword_2AE14:    dc.l $24D62, $FCFC      ; DATA XREF: Effect_CreateDashTrail+92   o
                dc.l $34D61, $400F8FC
                dc.l $44D60, $800F4FC
                dc.w $FFFF
dword_2AE2E:    dc.l $4455D, $200FCF4   ; DATA XREF: Cutscene_XiTigerComplete+2A   o
                                        ; Boss_ViblackSpawnRandomProjectiles+34   o
                dc.l $4455E, $100FCF8
                dc.l $4455F, $FCFC
                dc.w $FFFF
dword_2AE48:    dc.l $244D6, $A00F4F4   ; DATA XREF: Cutscene_XiTigerSkipCheck+14   o
                dc.l $244DF, $A00F4F4
dword_2AE58:    dc.l $244BC, $500F8F8   ; DATA XREF: Effect_SpawnParticle+1E   o
                                        ; Player_SpawnPhoenixParticles+3E   o
                dc.l $244C0, $500F8F8
                dc.l $144F2, $FCFC
                dc.l $244F3, $FCFC
                dc.l $144F4, $FCFC
                dc.l $144F5, $FCFC
                dc.w $FFFF
dword_2AE8A:    dc.l $1454B, $F00F0F0   ; DATA XREF: Effect_SpawnKnockbackParticle+3E   o
                dc.l $1456C, $F00F0F0
                dc.l $24480, $A00F4F4
                dc.l $24489, $A00F4F4
                dc.l $14492, $A00F4F4
                dc.l $1449B, $A00F4F4
                dc.l $144A4, $500F8F8
                dc.l $144A8, $500F8F8
                dc.w $FFFF
dword_2AECC:    dc.l $144D6, $A00F4F4   ; DATA XREF: Sprite_HandleProjectileCollision+E   o
                dc.l $244DF, $A00F4F4
                dc.l $244D6, $A00F4F4
                dc.l $244DF, $A00F4F4
                dc.l $144BC, $500F8F8
                dc.l $144C0, $500F8F8
                dc.l $144BC, $500F8F8
                dc.l $144C0, $500F8F8
                dc.l $144F2, $FCFC
                dc.l $144F3, $FCFC
                dc.w $FFFF
dword_2AF1E:    dc.l $244D6, $A00F4F4   ; DATA XREF: Weapon_UpdateBombProjectile+10   o
                                        ; Boss_ArtemisSpawnRadialProjectile+12   o
                dc.l $244DF, $A00F4F4
                dc.l $144BC, $500F8F8
                dc.l $144C0, $500F8F8
                dc.l $144F3, $FCFC
                dc.w $FFFF
dword_2AF48:    dc.l $844F4, $FCFC      ; DATA XREF: Effect_SpawnStarParticle+A   o
                                        ; sub_18F58   o ...
                dc.l $844F5, $FCFC
                dc.w $FFFF
dword_2AF5A:    dc.l $24480, $A00F4F4   ; DATA XREF: Sprite_SpawnParticleEffect+26   o
                dc.l $24489, $A00F4F4
                dc.l $24492, $A00F4F4
                dc.l $2449B, $A00F4F4
                dc.l $244A4, $500F8F8
                dc.l $144A8, $500F8F8
                dc.w $FFFF
dword_2AF8C:    dc.l $24480, $A00F4F4   ; DATA XREF: Sprite_SpawnParticleEffect+34   o
                dc.l $34489, $A00F4F4
                dc.l $34492, $A00F4F4
                dc.l $2449B, $A00F4F4
                dc.l $244A4, $500F8F8
                dc.l $144A8, $500F8F8
                dc.w $FFFF


; Finds free sprite slot in RAM at FFCC80
Enemy_FindFreeSpriteSlot:                              ; CODE XREF: Enemy_FindSlotAndInit   p  ; was: sub_2AFBE
                movea.w #(byte_FFCC80-M68K_RAM),a0
                jmp     loc_1C11C
; End of function Enemy_FindFreeSpriteSlot
; Finds free enemy sprite slot and initializes with homing projectile
Enemy_FindSlotAndInit:
                bsr.w Enemy_FindFreeSpriteSlot  ; was: sub_2AFC8
                bne.s   locret_2AFD4
                movea.l off_2AFD6(pc,d1.w),a1
                jmp     (a1)
; ---------------------------------------------------------------------------
locret_2AFD4:                           ; CODE XREF: Enemy_FindSlotAndInit+4   j
                rts
; End of function Enemy_FindSlotAndInit
; ---------------------------------------------------------------------------
off_2AFD6:      dc.l Enemy_InitHomingProjectile          ; DATA XREF: Enemy_FindSlotAndInit+6   r
                dc.l Boss_JetsripperSpawnBullet


; Spawns directional projectile in one of 8 directions with velocity
Projectile_SpawnDirectional8Way:                              ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+1E   p  ; was: sub_2AFDE
                move.w  #$50,(a0) ; 'P'
                move.w  d0,$48(a0)
                move.w  #1,$4A(a0)
                move.w  #$8100,2(a0)
                add.w   $10(a5),d1
                move.w  d1,$10(a0)
                add.w   $14(a5),d2
                move.w  d2,$14(a0)
                addq.w  #8,d0
                andi.w  #$70,d0 ; 'p'
                asr.w   #3,d0
                move.w  word_2B02A(pc,d0.w),$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  (word_FF808A).w,d0
                andi.w  #$8000,d0
                or.w    d0,$E(a0)
                rts
; End of function Projectile_SpawnDirectional8Way
; ---------------------------------------------------------------------------
word_2B02A:     dc.w $4CD6, $5CDF, $54E8, $54DF, $44D6, $44DF, $44E8, $4CDF
                                        ; DATA XREF: Projectile_SpawnDirectional8Way+2C   r


; Initializes directional projectile with animation, velocity from table
Projectile_DirectionalInitMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B03A
                subq.w  #1,$4A(a5)
                bpl.s   locret_2B09A
                move.w  #$4C,(a5) ; 'L'
                move.w  #$8D00,2(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #$F808F808,$2C(a5)
                move.w  #$50,$26(a5) ; 'P'
                move.w  $48(a5),d0
                movea.l #dword_2B166,a0
                move.l  (a0,d0.w),$1C(a5)
                move.l  $20(a0,d0.w),$18(a5)
                addq.w  #4,d0
                andi.w  #$78,d0 ; 'x'
                asr.w   #2,d0
                move.w  word_2B09C(pc,d0.w),$E(a5)
                move.w  #0,8(a5)
                move.w  #$FCFC,$A(a5)
                move.w  (word_FF808A).w,d0
                andi.w  #$8000,d0
                or.w    d0,$E(a5)
locret_2B09A:                           ; CODE XREF: Projectile_DirectionalInitMain+4   j
                rts
; End of function Projectile_DirectionalInitMain
; ---------------------------------------------------------------------------
word_2B09C:     dc.w $4CF1, $5CF2, $5CF3, $5CF4, $54F5, $54F4, $54F3, $54F2
                                        ; DATA XREF: Projectile_DirectionalInitMain+42   r
                dc.w $44F1, $44F2, $44F3, $44F4, $44F5, $4CF4, $4CF3, $4CF2


; Checks bounds/collision, explodes projectile on wall impact
Projectile_ExplodeOnWall:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B0BC
                cmpi.w  #$88,$10(a5)
                bmi.s   loc_2B0DC
                cmpi.w  #$1B8,$10(a5)
                bpl.s   loc_2B0DC
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B0DC
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B0E4
loc_2B0DC:                              ; CODE XREF: Projectile_ExplodeOnWall+6   j
                                        ; Projectile_ExplodeOnWall+E   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B0E4:                              ; CODE XREF: Projectile_ExplodeOnWall+1E   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B0FA
                btst    #7,$22(a5)
                beq.s   loc_2B102
                btst    #4,$22(a5)
                beq.s   loc_2B114
loc_2B0FA:                              ; CODE XREF: Projectile_ExplodeOnWall+2C   j
                jsr (Sprite_SetPointerClearD7).l
                bra.s   loc_2B11A
; ---------------------------------------------------------------------------
loc_2B102:                              ; CODE XREF: Projectile_ExplodeOnWall+34   j
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                jsr (Collision_CheckTerrainTile).l
                bne.s   loc_2B114
locret_2B112:                           ; CODE XREF: Projectile_ExplodeOnWall+64   j
                rts
; ---------------------------------------------------------------------------
loc_2B114:                              ; CODE XREF: Projectile_ExplodeOnWall+3C   j
                                        ; Projectile_ExplodeOnWall+54   j
                bset    #4,2(a5)
loc_2B11A:                              ; CODE XREF: Projectile_ExplodeOnWall+44   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_2B112
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3C,d0 ; '<'
                add.w   $48(a5),d0
                subi.w  #$5C,d0 ; '\'
                andi.w  #$7C,d0 ; '|'
                movea.l #dword_2B166,a1
                move.l  (a1,d0.w),d1
                move.l  $20(a1,d0.w),d2
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movea.l #dword_2AD16,a1
                bra.w Sprite_InitFromTable
; End of function Projectile_ExplodeOnWall
; ---------------------------------------------------------------------------
dword_2B166:    dc.l 0, $1C170          ; DATA XREF: Projectile_DirectionalInitMain+28   o
                                        ; Projectile_ExplodeOnWall+86   o
                dc.l $37194, $4FFF8
                dc.l $65D24, $77B98
                dc.l $85080, $8D3B4
                dc.l $90000, $8D3B4
                dc.l $85080, $77B98
                dc.l $65D24, $4FFF8
                dc.l $37194, $1C170
                dc.l $FFFFFFDC, $FFFE3E90
                dc.l $FFFC8E6C, $FFFB0008
                dc.l $FFF9A2DC, $FFF88468
                dc.l $FFF7AF80, $FFF72C4C
                dc.l $FFF70000, $FFF72C4C
                dc.l $FFF7AF80, $FFF88468
                dc.l $FFF9A2DC, $FFFB0008
                dc.l $FFFC8E6C, $FFFE3E90
                dc.l 0, $1C170
                dc.l $37194, $4FFF8
                dc.l $65D24, $77B98
                dc.l $85080, $8D3B4


; Initializes homing projectile with trajectory calculation
Enemy_InitHomingProjectile:                              ; CODE XREF: Enemy_CircularHomingMotion+5A   p  ; was: sub_2B206
                                        ; Enemy_FlyerState4+48   p ...
                moveq   #$A,d7
                tst.w   (word_FFFF0E).w
                beq.s Enemy_SetProjectileDifficulty
                moveq   #$B,d7
; Initializes enemy homing projectile with velocity and angle
Enemy_SetProjectileDifficulty:                              ; CODE XREF: Enemy_InitHomingProjectile+6   j  ; was: loc_2B210
                                        ; Enemy_InitTrackedProjectile+32   j ...
                move.w  #$148,(a0)
                move.w  #$ED00,2(a0)
                clr.w   4(a0)
                move.w  #$32,$26(a0) ; '2'
                move.w  d2,d3
                andi.w  #$8000,d2
                andi.w  #$FF,d3
                addi.w  #$480,d2
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                move.l  #off_E9680,8(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                clr.b   $23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                add.w   d0,$10(a0)
                add.w   d1,$14(a0)
                move.w  #3,$48(a0)
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d6.w),d1
                move.w  (a1,d6.w),d2
                muls.w  d7,d1
                muls.w  d7,d2
                move.l  d1,$54(a0)
                move.l  d2,$50(a0)
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d2,$18(a0)
                move.l  d1,$1C(a0)
                rts
; End of function Enemy_InitHomingProjectile
; Main handler for homing projectile with reflect logic
Enemy_HomingProjectileMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B298
                cmpi.w  #$70,$10(a5) ; 'p'
                bmi.s   loc_2B2B8
                cmpi.w  #$1D0,$10(a5)
                bpl.s   loc_2B2B8
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B2B8
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B2C0
loc_2B2B8:                              ; CODE XREF: Enemy_HomingProjectileMain+6   j
                                        ; Enemy_HomingProjectileMain+E   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B2C0:                              ; CODE XREF: Enemy_HomingProjectileMain+1E   j
                tst.w   4(a5)
                bne.s   loc_2B2F0
                subq.w  #1,$48(a5)
                bpl.s   locret_2B2EE
                addq.w  #2,4(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #off_E9788,8(a5)
                clr.w   $C(a5)
                move.l  $50(a5),$18(a5)
                move.l  $54(a5),$1C(a5)
locret_2B2EE:                           ; CODE XREF: Enemy_HomingProjectileMain+32   j
                                        ; Enemy_HomingProjectileMain+7C   j ...
                rts
; ---------------------------------------------------------------------------
loc_2B2F0:                              ; CODE XREF: Enemy_HomingProjectileMain+2C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B306
                btst    #7,$22(a5)
                beq.s   loc_2B30E
                btst    #4,$22(a5)
                beq.s   loc_2B316
loc_2B306:                              ; CODE XREF: Enemy_HomingProjectileMain+5C   j
                jsr (Sprite_SetPointerClearD7).l
                bra.s   loc_2B31C
; ---------------------------------------------------------------------------
loc_2B30E:                              ; CODE XREF: Enemy_HomingProjectileMain+64   j
                jsr (Collision_CheckProjectileTile).l
                beq.s   locret_2B2EE
loc_2B316:                              ; CODE XREF: Enemy_HomingProjectileMain+6C   j
                bset    #4,2(a5)
loc_2B31C:                              ; CODE XREF: Enemy_HomingProjectileMain+74   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_2B2EE
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $1C(a5),d1
                move.l  $18(a5),d2
                asr.l   #1,d1
                asr.l   #1,d2
                neg.l   d1
                neg.l   d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movea.l #dword_2ACA6,a1
                bra.w Sprite_InitFromTable
; End of function Enemy_HomingProjectileMain
; Spawns bullet for Jetsripper boss with calculated velocity
Boss_JetsripperSpawnBullet:                              ; DATA XREF: ROM:0002AFDA   o  ; was: sub_2B352
                moveq   #9,d7
                tst.w   (word_FFFF0E).w
                beq.s   loc_2B35C
                moveq   #$A,d7
loc_2B35C:                              ; CODE XREF: Boss_JetsripperSpawnBullet+6   j
                move.w  #$148,(a0)
                move.w  #$ED00,2(a0)
                clr.w   4(a0)
                move.w  #$32,$26(a0) ; '2'
                move.w  d2,d3
                andi.w  #$8000,d2
                andi.w  #$FF,d3
                addi.w  #$480,d2
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                move.l  #off_E9680,8(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                clr.b   $23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                add.w   d0,$10(a0)
                add.w   d1,$14(a0)
                move.w  #3,$48(a0)
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d6.w),d1
                move.w  (a1,d6.w),d2
                muls.w  d7,d1
                muls.w  d7,d2
                move.l  d1,$54(a0)
                move.l  d2,$50(a0)
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d2,$18(a0)
                move.l  d1,$1C(a0)
                rts
; End of function Boss_JetsripperSpawnBullet
; Bullet projectile with delayed physics activation and wall collision
Projectile_BulletWithDelayedPhysics:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B3E4
                cmpi.w  #$70,$10(a5) ; 'p'
                bmi.s   loc_2B404
                cmpi.w  #$1D0,$10(a5)
                bpl.s   loc_2B404
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B404
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B40C
loc_2B404:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+6   j
                                        ; Projectile_BulletWithDelayedPhysics+E   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B40C:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+1E   j
                tst.w   4(a5)
                bne.s   loc_2B43C
                subq.w  #1,$48(a5)
                bpl.s   locret_2B43A
                addq.w  #2,4(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #off_E9788,8(a5)
                clr.w   $C(a5)
                move.l  $50(a5),$18(a5)
                move.l  $54(a5),$1C(a5)
locret_2B43A:                           ; CODE XREF: Projectile_BulletWithDelayedPhysics+32   j
                                        ; Projectile_BulletWithDelayedPhysics+7C   j ...
                rts
; ---------------------------------------------------------------------------
loc_2B43C:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+2C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B452
                btst    #7,$22(a5)
                beq.s   loc_2B45A
                btst    #4,$22(a5)
                beq.s   loc_2B462
loc_2B452:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+5C   j
                jsr (Sprite_SetPointerClearD7).l
                bra.s   loc_2B468
; ---------------------------------------------------------------------------
loc_2B45A:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+64   j
                jsr (Collision_CheckProjectileTile).l
                beq.s   locret_2B43A
loc_2B462:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+6C   j
                bset    #4,2(a5)
loc_2B468:                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+74   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_2B43A
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $1C(a5),d1
                move.l  $18(a5),d2
                asr.l   #1,d1
                asr.l   #1,d2
                neg.l   d1
                neg.l   d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movea.l #dword_2ACA6,a1
                bra.w Sprite_InitFromTable
; End of function Projectile_BulletWithDelayedPhysics
; Updates boss sprite graphics
Boss_DestroyerMK2UpdateSprite:                              ; CODE XREF: Boss_DestroyerMK2PlaySFX+18   p  ; was: sub_2B49E
                                        ; Boss_DestroyerMK2DefeatLaserEffect+46   p
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_2B4B4
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                movea.l off_2B4B6(pc,d1.w),a4
                bra.s   loc_2B4C4
; ---------------------------------------------------------------------------
locret_2B4B4:                           ; CODE XREF: Boss_DestroyerMK2UpdateSprite+6   j
                rts
; End of function Boss_DestroyerMK2UpdateSprite
; ---------------------------------------------------------------------------
off_2B4B6:      dc.l stru_2B526         ; DATA XREF: Boss_DestroyerMK2UpdateSprite+10   r
                dc.l stru_2B534


; Initializes projectile with angle calculation and directional velocity
Enemy_InitDirectionalProjectile:                              ; CODE XREF: Enemy_SpawnParticleHardMode+1E   p  ; was: sub_2B4BE
                                        ; Enemy_BossProjectileMovement+3A   p ...
                lea     stru_2B526(pc),a4
                nop
loc_2B4C4:                              ; CODE XREF: Boss_DestroyerMK2UpdateSprite+14   j
                move.w  (a4)+,$26(a0)
                move.w  (a4)+,d7
                move.l  (a4)+,8(a0)
                move.l  (a4)+,$50(a0)
                move.w  #$17C,(a0)
                move.w  #$E180,2(a0)
                move.w  d2,d3
                andi.w  #$8000,d2
                andi.w  #$FF,d3
                addi.w  #$480,d2
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                clr.w   $C(a0)
                clr.b   $21(a0)
                clr.b   $23(a0)
                tst.w   (a4)+
                bne.s   loc_2B50A
                jsr (Math_CalculateAngleBetween).l
                move.w  d2,d6
loc_2B50A:                              ; CODE XREF: Enemy_InitDirectionalProjectile+42   j
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d6.w),d0
                move.w  (a1,d6.w),d1
                muls.w  d7,d0
                muls.w  d7,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                rts
; End of function Enemy_InitDirectionalProjectile
; ---------------------------------------------------------------------------
stru_2B526:     dc.w $37                ; field_0
                                        ; DATA XREF: ROM:off_2B4B6   o
                                        ; sub_2B4BE   o
                dc.w 9                  ; field_2
                dc.l off_E9604          ; field_4
                dc.l off_E96E0          ; field_8
                dc.w 0                  ; field_C
stru_2B534:     dc.w $38                ; field_0
                                        ; DATA XREF: ROM:0002B4BA   o
                dc.w $A                 ; field_2
                dc.l off_E9604          ; field_4
                dc.l off_E96E0          ; field_8
                dc.w 1                  ; field_C


; Bouncing enemy projectile with screen bounds check
Enemy_BouncingProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B542
                tst.w   4(a5)
                bne.s   loc_2B56C
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2B56A
                addq.w  #2,4(a5)
                move.w  #$ED80,2(a5)
                move.l  $50(a5),8(a5)
                clr.w   $C(a5)
                move.b  #$40,$21(a5) ; '@'
locret_2B56A:                           ; CODE XREF: Enemy_BouncingProjectile+C   j
                                        ; Enemy_BouncingProjectile+88   j
                rts
; ---------------------------------------------------------------------------
loc_2B56C:                              ; CODE XREF: Enemy_BouncingProjectile+4   j
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,d1
                subi.w  #$80,d0
                cmp.w   (word_FFA970).w,d0
                bmi.s   loc_2B59A
                subi.w  #$1C0,d1
                cmp.w   (word_FFA974).w,d1
                bpl.s   loc_2B59A
                cmpi.w  #$A0,$14(a5)
                bmi.s   loc_2B59A
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B5A2
loc_2B59A:                              ; CODE XREF: Enemy_BouncingProjectile+3C   j
                                        ; Enemy_BouncingProjectile+46   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B5A2:                              ; CODE XREF: Enemy_BouncingProjectile+56   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B5B8
                btst    #7,$22(a5)
                beq.s   loc_2B5C0
                btst    #4,$22(a5)
                beq.s   loc_2B5CC
loc_2B5B8:                              ; CODE XREF: Enemy_BouncingProjectile+64   j
                jsr (Sprite_SetPointerClearD7).l
                bra.s   loc_2B5D2
; ---------------------------------------------------------------------------
loc_2B5C0:                              ; CODE XREF: Enemy_BouncingProjectile+6C   j
                jsr (Collision_GetEntityPosition).l
                cmpi.w  #4,d2
                bmi.s   locret_2B56A
loc_2B5CC:                              ; CODE XREF: Enemy_BouncingProjectile+74   j
                bset    #4,2(a5)
loc_2B5D2:                              ; CODE XREF: Enemy_BouncingProjectile+7C   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_2B59A
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                move.l  $1C(a5),d1
                neg.l   d0
                neg.l   d1
                asr.l   #2,d0
                asr.l   #2,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                move.l  #off_E9560,8(a0)
                jmp Sprite_InitializeProperties
; End of function Enemy_BouncingProjectile
; Spawns animated projectile from enemy with random animation offset
Enemy_SpawnAnimatedProjectile:                              ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+52   p  ; was: sub_2B60C
                move.w  #$54,(a0) ; 'T'
                move.w  #$8D40,2(a0)
                move.l  #dword_2ACD0,$48(a0)
                move.w  #1,$4C(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$18,d0
                add.l   d0,$48(a0)
                moveq   #0,d0
                move.w  d0,4(a0)
                move.b  d0,$21(a0)
                move.w  d0,$5E(a0)
                add.w   $10(a5),d1
                move.w  d1,$10(a0)
                add.w   $14(a5),d2
                move.w  d2,$14(a0)
                rts
; End of function Enemy_SpawnAnimatedProjectile
; Bouncing projectile with gravity and terrain collision detection
Projectile_BouncingWithGravity:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B652
                cmpi.w  #$80,$14(a5)
                bmi.s   loc_2B662
                cmpi.w  #$15C,$14(a5)
                bmi.s   loc_2B66A
loc_2B662:                              ; CODE XREF: Projectile_BouncingWithGravity+6   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B66A:                              ; CODE XREF: Projectile_BouncingWithGravity+E   j
                tst.w   $5E(a5)
                bne.s   loc_2B6A4
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                jsr (Collision_CheckTerrainTile).l
                beq.s   loc_2B6A4
                addq.w  #1,$5E(a5)
                clr.l   $1C(a5)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FFFC,d0
                subi.w  #$6000,d0
                asl.l   #2,d0
                tst.w   $18(a5)
                bpl.s   loc_2B6A0
                neg.l   d0
loc_2B6A0:                              ; CODE XREF: Projectile_BouncingWithGravity+4A   j
                move.l  d0,$18(a5)
loc_2B6A4:                              ; CODE XREF: Projectile_BouncingWithGravity+1C   j
                                        ; Projectile_BouncingWithGravity+2C   j
                bsr.w Gfx_AnimateSpriteTileLoop
                addi.l  #$8000,$1C(a5)
                rts
; End of function Projectile_BouncingWithGravity
; Laser projectile
Projectile_WolfGaropaLaser:                              ; CODE XREF: Projectile_WolfGaropaHoming+D4   j  ; was: sub_2B6B2
                addi.w  #$20,d2 ; ' '
                andi.w  #$C0,d2
                asr.w   #4,d2
                move.l  off_2B6C4(pc,d2.w),8(a0)
                rts
; End of function Projectile_WolfGaropaLaser
; ---------------------------------------------------------------------------
off_2B6C4:      dc.l word_E90DA         ; DATA XREF: Projectile_WolfGaropaLaser+A   r
                dc.l word_E90E0
                dc.l word_E90D4
                dc.l word_E90E6


; Main update routine for Jetsripper boss
Boss_JetsripperMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B6D4
                tst.w   4(a5)
                bne.w   loc_2B70E
                move.w  $14(a5),$48(a5)
                addq.w  #2,4(a5)
                move.w  #$E300,2(a5)
                move.l  #off_E975C,8(a5)
                move.w  #$C80,d0
                btst    #1,$5F(a5)
                beq.s   loc_2B704
                bset    #$C,d0
loc_2B704:                              ; CODE XREF: Boss_JetsripperMain+2A   j
                move.w  d0,$E(a5)
                move.b  #$10,$20(a5)
loc_2B70E:                              ; CODE XREF: Boss_JetsripperMain+4   j
                btst    #0,$5F(a5)
                beq.s   loc_2B72E
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #3,d0
                move.b  byte_2B778(pc,d0.w),d0
                ext.w   d0
                add.w   $48(a5),d0
                move.w  d0,$14(a5)
loc_2B72E:                              ; CODE XREF: Boss_JetsripperMain+40   j
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$10,d0
                bpl.s   locret_2B776
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s Boss_SpawnPeriodicProjectile
                jsr (Projectile_UpdateTrajectory).l
                bne.s Boss_SpawnPeriodicProjectile
                jsr (Effect_SpawnDestructionBlast).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; Spawns periodic projectile for boss with timer check
Boss_SpawnPeriodicProjectile:                              ; CODE XREF: Boss_JetsripperMain+6E   j  ; was: loc_2B75E
                                        ; Boss_JetsripperMain+76   j
                move.w  #$9C,$26(a5)
                jsr (Boss_SpawnProjectile).l
                btst    #0,$5F(a5)
                beq.s   locret_2B776
                clr.l   $1C(a5)
locret_2B776:                           ; CODE XREF: Boss_JetsripperMain+64   j
                                        ; Boss_JetsripperMain+9C   j
                rts
; End of function Boss_JetsripperMain
; ---------------------------------------------------------------------------
byte_2B778:     dc.b $FF, 0, 1, 0       ; DATA XREF: Boss_JetsripperMain+4C   r


; Initializes enemy projectile type and flags
Enemy_InitProjectileType:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B77C
                tst.w   4(a5)
                bne.w   loc_2B7BA
                move.w  $14(a5),$48(a5)
                addq.w  #2,4(a5)
                move.w  #$8F00,2(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #$FC04FC04,$2C(a5)
                move.w  #$C4C8,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.b  #$10,$20(a5)
loc_2B7BA:                              ; CODE XREF: Enemy_InitProjectileType+4   j
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #3,d0
                move.b  byte_2B808(pc,d0.w),d0
                ext.w   d0
                add.w   $48(a5),d0
                move.w  d0,$14(a5)
                btst    #7,$22(a5)
                beq.s   loc_2B7EA
                btst    #4,$22(a5)
                beq.w   loc_2B7F6
                jmp Projectile_DeflectBounce
; ---------------------------------------------------------------------------
loc_2B7EA:                              ; CODE XREF: Enemy_InitProjectileType+5C   j
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$C,d0
                bpl.s   locret_2B806
loc_2B7F6:                              ; CODE XREF: Enemy_InitProjectileType+64   j
                move.w  #$64,$26(a5) ; 'd'
                jsr (Projectile_CheckLifetime).l
                clr.l   $1C(a5)
locret_2B806:                           ; CODE XREF: Enemy_InitProjectileType+78   j
                rts
; End of function Enemy_InitProjectileType
; ---------------------------------------------------------------------------
byte_2B808:     dc.b $FF, 0, 1, 0       ; DATA XREF: Enemy_InitProjectileType+48   r


; Spawns projectile with trajectory calculation towards player position
Boss_SpawnTargetedProjectile:                              ; CODE XREF: Boss_SpawnPeriodicShots+1E   p  ; was: sub_2B80C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2B888
                add.w   $10(a5),d5
                add.w   $14(a5),d6
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.w  #$84,(a0)
                move.w  #$8F00,2(a0)
                move.w  #$C4C8,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #$20,$20(a0) ; ' '
                move.w  #$64,$26(a0) ; 'd'
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FC04FC04,$2C(a0)
                movea.w a0,a1
                jsr (Physics_CalculateDistanceTo).l
                moveq   #0,d0
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #8,d0
                swap    d0
                asr.l   #1,d0
                tst.w   d1
                bmi.s Projectile_SetHorizontalVelocity
                neg.l   d0
; Sets projectile horizontal velocity based on angle calculation
Projectile_SetHorizontalVelocity:                              ; CODE XREF: Boss_SpawnTargetedProjectile+68   j  ; was: loc_2B878
                move.l  d0,$18(a1)
                move.w  #$FFFA,$1C(a1)
                move.w  (dword_FFFF08).w,$1E(a1)
locret_2B888:                           ; CODE XREF: Boss_SpawnTargetedProjectile+6   j
                rts
; End of function Boss_SpawnTargetedProjectile
; Projectile with gravity physics deflection and ground bounce
Projectile_GravityBounce:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B88A
                addi.l  #$3000,$1C(a5)
                btst    #7,$22(a5)
                beq.s   loc_2B8AA
                btst    #4,$22(a5)
                beq.w   loc_2B8C0
                jmp Projectile_DeflectBounce
; ---------------------------------------------------------------------------
loc_2B8AA:                              ; CODE XREF: Projectile_GravityBounce+E   j
                jsr (Collision_GetEntityPosition).l
                beq.s   locret_2B8BE
                cmpi.w  #2,d2
                bne.s   loc_2B8C0
                tst.l   $1C(a5)
                bpl.s   loc_2B8C0
locret_2B8BE:                           ; CODE XREF: Projectile_GravityBounce+26   j
                rts
; ---------------------------------------------------------------------------
loc_2B8C0:                              ; CODE XREF: Projectile_GravityBounce+16   j
                                        ; Projectile_GravityBounce+2C   j ...
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  #$FFFEC000,$1C(a5)
                move.l  #off_E953C,8(a5)
                jmp Enemy_GetEntityAddress
; End of function Projectile_GravityBounce
; Spawns falling debris projectile with gravity and horizontal velocity
Projectile_SpawnFallingDebris:                              ; CODE XREF: Enemy_GroundWalkWithProjectile:loc_2CD90   p  ; was: sub_2B8E0
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2B93C
                add.w   $10(a5),d5
                add.w   $14(a5),d6
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.w  #$1D0,(a0)
                move.w  #$EF00,2(a0)
                move.w  #$C80,$E(a0)
                move.l  #off_E975C,8(a0)
                move.b  #$3C,$20(a0) ; '<'
                move.w  #$18,$26(a0)
                move.b  #$40,$21(a0) ; '@'
                move.b  #$80,$23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  d7,$18(a0)
                move.l  #$FFFFA000,$1C(a0)
locret_2B93C:                           ; CODE XREF: Projectile_SpawnFallingDebris+6   j
                rts
; End of function Projectile_SpawnFallingDebris
; Spawns trailing explosion particles while projectile moves
Enemy_TrailingExplosionSpawner:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B93E
                addq.w  #1,$48(a5)
                move.w  $48(a5),d0
                andi.w  #3,d0
                bne.s   loc_2B990
                jsr (Projectile_UpdateTrajectory).l
                bne.s   loc_2B990
                move.l  #off_E9638,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.b  #7,d0
                subq.w  #4,d0
                add.w   d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.b  #7,d0
                subq.w  #4,d0
                add.w   d0,$14(a0)
                move.w  #7,$48(a0)
                jsr (Effect_SpawnExplosionType188).l
loc_2B990:                              ; CODE XREF: Enemy_TrailingExplosionSpawner+C   j
                                        ; Enemy_TrailingExplosionSpawner+14   j
                addi.l  #$3800,$1C(a5)
                btst    #7,$22(a5)
                bne.s   loc_2B9AA
                jsr (Collision_GetEntityPosition).l
                bne.s   loc_2B9AA
                rts
; ---------------------------------------------------------------------------
loc_2B9AA:                              ; CODE XREF: Enemy_TrailingExplosionSpawner+60   j
                                        ; Enemy_TrailingExplosionSpawner+68   j
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp Enemy_GetEntityAddress
; End of function Enemy_TrailingExplosionSpawner
; Spawns falling hazard projectiles from top of screen at intervals
Enemy_SpawnFallingHazard:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2B9C4
                tst.w   (word_FF808C).w
                bmi.s   loc_2B9D2
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B9D2:                              ; CODE XREF: Enemy_SpawnFallingHazard+4   j
                subq.w  #1,$48(a5)
                bpl.s   locret_2BA56
                lea     word_2BA58(pc),a0
                nop
                move.w  (word_FFFF0E).w,d1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                add.w   (a0,d1.w),d0
                move.w  d0,$48(a5)
                jsr (Sprite_FindFreeEffectSlot).l
                bne.s   locret_2BA56
                move.w  #$108,(a0)
                move.w  #$8F80,2(a0)
                move.w  #$C4C8,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #$10,$20(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FC04FC04,$28(a0)
                move.w  #$64,$26(a0) ; 'd'
                move.l  #$FFFF6000,$18(a0)
                move.w  #3,$1C(a0)
                move.w  #$A0,$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                moveq   #0,d0
locret_2BA56:                           ; CODE XREF: Enemy_SpawnFallingHazard+12   j
                                        ; Enemy_SpawnFallingHazard+34   j
                rts
; End of function Enemy_SpawnFallingHazard
; ---------------------------------------------------------------------------
word_2BA58:     dc.w $40, $28, $10      ; DATA XREF: Enemy_SpawnFallingHazard+14   o


; Handles projectile collision with terrain changing state or destroying
Projectile_TerrainCollision:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BA5E
                tst.w   (word_FF808C).w
                bmi.s   loc_2BA7A
loc_2BA64:                              ; CODE XREF: Projectile_TerrainCollision+4A   j
                move.l  #off_E9584,8(a5)
                move.l  #$FFFF0000,$1C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2BA7A:                              ; CODE XREF: Projectile_TerrainCollision+4   j
                jsr (Collision_GetEntityPosition).l
                beq.s   loc_2BA9A
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.w  #$62,$26(a5) ; 'b'
                jmp Projectile_CheckLifetime
; ---------------------------------------------------------------------------
loc_2BA9A:                              ; CODE XREF: Projectile_TerrainCollision+22   j
                btst    #7,$22(a5)
                beq.s   locret_2BAB2
                btst    #4,$22(a5)
                beq.w   loc_2BA64
                jmp Projectile_DeflectBounce
; ---------------------------------------------------------------------------
locret_2BAB2:                           ; CODE XREF: Projectile_TerrainCollision+42   j
                rts
; End of function Projectile_TerrainCollision
; Initializes destruction particle sprite properties
Enemy_InitDestructionParticle:                              ; CODE XREF: Enemy_DestructionParticleMain+6   p  ; was: sub_2BAB4
                addq.w  #2,4(a5)
                move.w  #$E700,2(a5)
                move.l  #off_E97B8,8(a5)
                clr.w   $C(a5)
                move.w  #$480,$E(a5)
                clr.b   $20(a5)
                move.b  #$C0,$21(a5)
                move.b  #$30,$23(a5) ; '0'
                move.l  #$F808F808,$2C(a5)
                move.l  #$FC04FC04,$28(a5)
                rts
; End of function Enemy_InitDestructionParticle
; Destruction particle handler
Stage25_DestructionParticle:                              ; CODE XREF: Enemy_DestructionParticleMain:loc_2BB56   j  ; was: sub_2BAF2
                bclr    #7,$22(a5)
                beq.s Sprite_ClearHorizontalFlip
                bclr    #4,$22(a5)
                bne.s Sprite_ClearHorizontalFlip
                move.b  #$A7,d0
                jsr (Sound_PlaySFX).l
                tst.w   (word_FFA216).w
                beq.w   loc_2BB32
                bmi.w   loc_2BB32
                addi.w  #$20,(word_FFA218).w ; ' '
                cmpi.w  #$400,(word_FFA218).w
                bmi.s   loc_2BB2C
                move.w  #$400,(word_FFA218).w
loc_2BB2C:                              ; CODE XREF: Stage25_DestructionParticle+32   j
                move.w  (word_FFA218).w,(word_FFA216).w
loc_2BB32:                              ; CODE XREF: Stage25_DestructionParticle+1E   j
                                        ; Stage25_DestructionParticle+22   j
                move.w  #$32C,(a5)
                clr.b   $21(a5)
                rts
; ---------------------------------------------------------------------------
; Clears horizontal flip bit and applies screen flip direction
Sprite_ClearHorizontalFlip:                              ; CODE XREF: Stage25_DestructionParticle+6   j  ; was: loc_2BB3C
                                        ; Stage25_DestructionParticle+E   j
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                rts
; End of function Stage25_DestructionParticle
; Main handler for destruction particle effect
Enemy_DestructionParticleMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB4C
                tst.w   4(a5)
                bne.s Enemy_InitDestructionHandler
                bsr.w Enemy_InitDestructionParticle
; Initializes destruction particle handler if not yet initialized
Enemy_InitDestructionHandler:                              ; CODE XREF: Enemy_DestructionParticleMain+4   j  ; was: loc_2BB56
                bra.w Stage25_DestructionParticle
; End of function Enemy_DestructionParticleMain
; Screen shake effect
Stage25_ScreenShake:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB5A
                move.w  #$30,(word_FF813C).w ; '0'
                bset    #4,2(a5)
                move.b  #$1B,d0
                jmp (Sound_PlaySFX).l
; End of function Stage25_ScreenShake
; Plays enemy death sound and sets timer
Enemy_PlayDeathSound:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BB70
                move.w  #$30,(word_FF813C).w ; '0'
                bset    #4,2(a5)
                move.b  #$1C,d0
                jmp (Sound_PlaySFX).l
; End of function Enemy_PlayDeathSound
; Initializes enemy state flags and properties
Enemy_InitializeState:                              ; CODE XREF: Enemy_InitializeBoss+6   p  ; was: sub_2BB86
                addq.w  #2,4(a5)
                move.w  #$C700,2(a5)
                move.w  (word_FF808A).w,$E(a5)
                move.b  #$C0,$21(a5)
                move.b  #$30,$23(a5) ; '0'
                move.l  #$F808F808,$2C(a5)
                move.l  #$FC04FC04,$28(a5)
                move.w  (word_FFA000).w,$48(a5)
                move.w  #$FFFF,$4C(a5)
                rts
; End of function Enemy_InitializeState
; Updates boss AI with weapon cycling logic
Enemy_UpdateBossAI:                              ; CODE XREF: Enemy_InitializeBoss:loc_2BCF8   j  ; was: sub_2BBC0
                move.b  #$7C,$20(a5) ; '|'
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2BBD2
                clr.b   $20(a5)
loc_2BBD2:                              ; CODE XREF: Enemy_UpdateBossAI+C   j
                tst.w   $4C(a5)
                bmi.s   loc_2BBFE
                subq.w  #1,$4C(a5)
                btst    #0,$4D(a5)
                bne.s   loc_2BC02
                btst    #7,$22(a5)
                beq.s   loc_2BBF4
                btst    #4,$22(a5)
                beq.s   loc_2BC02
loc_2BBF4:                              ; CODE XREF: Enemy_UpdateBossAI+2A   j
                move.l  #word_E9952,8(a5)
                bra.s   loc_2BC24
; ---------------------------------------------------------------------------
loc_2BBFE:                              ; CODE XREF: Enemy_UpdateBossAI+16   j
                addq.w  #1,$48(a5)
loc_2BC02:                              ; CODE XREF: Enemy_UpdateBossAI+22   j
                                        ; Enemy_UpdateBossAI+32   j
                move.w  $48(a5),d1
                asr.w   #4,d1
                andi.w  #$1C,d1
                cmpi.w  #$18,d1
                bmi.s   loc_2BC18
                moveq   #0,d1
                move.w  d1,$48(a5)
loc_2BC18:                              ; CODE XREF: Enemy_UpdateBossAI+50   j
                lea     (off_178E6).l,a0
                move.l  (a0,d1.w),8(a5)
loc_2BC24:                              ; CODE XREF: Enemy_UpdateBossAI+3C   j
                bclr    #3,$22(a5)
                beq.s   loc_2BC54
                btst    #4,$22(a5)
                bne.w   loc_2BC54
                jsr (UI_GetWeaponIconData).l
                beq.s   loc_2BC54
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
                asl.w   #5,d0
                move.w  d0,$48(a5)
                move.w  #$18,$4C(a5)
loc_2BC54:                              ; CODE XREF: Enemy_UpdateBossAI+6A   j
                                        ; Enemy_UpdateBossAI+72   j ...
                bclr    #7,$22(a5)
                beq.w   loc_2BCE0
                bclr    #4,$22(a5)
                bne.w   loc_2BCE0
                move.b  #$A7,d0
                jsr (Sound_PlaySFX).l
                jsr (UI_GetWeaponIconData).l
                beq.s   loc_2BCE6
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  $48(a5),d1
                asr.w   #5,d1
                andi.w  #$E,d1
                cmpi.w  #$C,d1
                bmi.s   loc_2BC94
                moveq   #0,d1
loc_2BC94:                              ; CODE XREF: Enemy_UpdateBossAI+D0   j
                cmp.w   (a0),d1
                beq.s   loc_2BCBE
                move.w  d1,(a0)
                clr.w   8(a0)
                addq.w  #2,d1
                move.w  d1,(word_FFA21C).w
                asl.w   #1,d1
                move.w  d1,(word_FFA21E).w
                jsr (UI_ClearWeaponCounters).l
                jsr (Sys_ClearObjectBufferSmall).l
                jsr (Gfx_LoadPaletteData).l
                bra.s   loc_2BCD2
; ---------------------------------------------------------------------------
loc_2BCBE:                              ; CODE XREF: Enemy_UpdateBossAI+D6   j
                addi.w  #$FA,$18(a0)
                cmpi.w  #$7D0,$18(a0)
                bmi.s   loc_2BCD2
                move.w  #$7D0,$18(a0)
loc_2BCD2:                              ; CODE XREF: Enemy_UpdateBossAI+FC   j
                                        ; Enemy_UpdateBossAI+10A   j
                move.w  $18(a0),$10(a0)
                move.w  #$330,(a5)
                clr.b   $21(a5)
loc_2BCE0:                              ; CODE XREF: Enemy_UpdateBossAI+9A   j
                                        ; Enemy_UpdateBossAI+A4   j
                clr.b   $22(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BCE6:                              ; CODE XREF: Enemy_UpdateBossAI+B8   j
                bset    #4,2(a5)
                rts
; End of function Enemy_UpdateBossAI
; Initializes boss object and state
Enemy_InitializeBoss:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BCEE
                tst.w   4(a5)
                bne.s Enemy_InitializeBossHandler
                bsr.w Enemy_InitializeState
; Initializes boss enemy and branches to AI update
Enemy_InitializeBossHandler:                              ; CODE XREF: Enemy_InitializeBoss+4   j  ; was: loc_2BCF8
                bra.w Enemy_UpdateBossAI
; End of function Enemy_InitializeBoss
; Empty entity state handler in main dispatch table
Entity_EmptyState6:                              ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_6
                rts
; End of function Entity_EmptyState6
; Sets sprite pointer a0 from a5 and clears d7
Sprite_SetPointerClearD7:                              ; CODE XREF: Projectile_ExplodeOnWall:loc_2B0FA   p  ; was: sub_2BCFE
                                        ; sub_2B298:loc_2B306   p ...
                movea.w a5,a0
loc_2BD00:                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+1E   p
                                        ; Boss_ValkirieInitScreenPair+64   p ...
                moveq   #0,d7
                bra.w Sprite_SetFlagsAndReturn
; End of function Sprite_SetPointerClearD7
; Wrapper for Jetsripper boss attack pattern 2 with d7=0
Boss_JetsripperAttackWrapper0:
                movea.w a5,a0  ; was: sub_2BD06
                moveq   #0,d7
                bra.w Boss_JetsripperAttackPattern2
; End of function Boss_JetsripperAttackWrapper0
; Wrapper to copy a5 register to a0 for boss operations
Boss_WrapperA5ToA0:
                movea.w a5,a0  ; was: sub_2BD0E
; End of function Boss_WrapperA5ToA0
; Spawns destruction explosion effect
Effect_SpawnDestructionBlast:                              ; CODE XREF: Boss_JetsripperMain+78   p  ; was: sub_2BD10
                                        ; Boss_JetsripperProjectileUpdate+46   p ...
                moveq   #1,d7
                bra.w Sprite_SetFlagsAndReturn
; End of function Effect_SpawnDestructionBlast
; Wrapper for Jetsripper boss attack pattern 2 with d7=1
Boss_JetsripperAttackWrapper1:
                movea.w a5,a0  ; was: sub_2BD16
loc_2BD18:                              ; CODE XREF: Boss_JetsripperAttackPattern1+A   j
                                        ; Boss_ArtemisAnimationScript+EC   p
                moveq   #1,d7
                bra.w Boss_JetsripperAttackPattern2
; End of function Boss_JetsripperAttackWrapper1
; Jetsripper attack pattern state handler
Boss_JetsripperAttackPattern1:                              ; CODE XREF: Boss_SpawnMultipleShots+26   j  ; was: sub_2BD1E
                                        ; Enemy_ProcessObject+18   j ...
                movea.w a5,a0
loc_2BD20:                              ; CODE XREF: Boss_InitJetsripperSpread+36   p
                                        ; Boss_WolfGaropaAttackState2+2A   p ...
                moveq   #0,d7
                move.w  (dword_FFFF08).w,d1
                and.w   d0,d1
                beq.s   loc_2BD18
                bra.w   *+4
; End of function Boss_JetsripperAttackPattern1
; Attributes: thunk
; Jetsripper second attack pattern state
Boss_JetsripperAttackPattern2:                              ; CODE XREF: Boss_JetsripperAttackWrapper0+4   j  ; was: sub_2BD2E
                                        ; Boss_JetsripperAttackWrapper1+4   j ...
                bra.s Sprite_SetFlagsAndReturn
; End of function Boss_JetsripperAttackPattern2
; Spawns destruction blast effect if under sprite limit, handles parameters
Effect_CreateDestructionBlast:
                move.w  (word_FFA216).w,d0  ; was: sub_2BD30
                cmp.w   (word_FFA218).w,d0
                bne.s Sprite_SetFlagsAndReturn
loc_2BD3A:                              ; CODE XREF: Effect_CreateDestructionBlast+1C   j
                move.w  #$10,(a0)
                bset    #4,2(a0)
                rts
; ---------------------------------------------------------------------------
; Spawns destruction blast effect with proper sprite setup
Sprite_SetFlagsAndReturn:                              ; CODE XREF: Sprite_SetPointerClearD7+4   j  ; was: loc_2BD46
                                        ; Effect_SpawnDestructionBlast+2   j ...
                cmpi.w  #6,(word_FF8126).w
                bpl.s   loc_2BD3A
                move.w  #$194,(a0)
                move.w  #$E140,2(a0)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                clr.w   $C(a0)
                clr.b   $20(a0)
                move.b  #$40,$21(a0) ; '@'
                clr.b   $22(a0)
                move.b  #$20,$23(a0) ; ' '
                move.l  #$FA06FA06,$2C(a0)
                move.b  byte_2BDA2(pc,d7.w),$4C(a0)
                asl.w   #1,d7
                move.w  word_2BDA4(pc,d7.w),$48(a0)
                asl.w   #1,d7
                move.l  off_2BDA8(pc,d7.w),8(a0)
                move.w  #$A0,$4A(a0)
                rts
; End of function Effect_CreateDestructionBlast
; ---------------------------------------------------------------------------
byte_2BDA2:     dc.b $46, $47           ; DATA XREF: Effect_CreateDestructionBlast+54   r
word_2BDA4:     dc.w $1E, $64           ; DATA XREF: Effect_CreateDestructionBlast+5C   r
off_2BDA8:      dc.l off_E97E0          ; DATA XREF: Effect_CreateDestructionBlast+64   r
                dc.l off_E97D4


; Dispatches to boss state handler based on state index
Boss_StateDispatcher:                              ; CODE XREF: Boss_ValkirieScreenTimer:loc_50E36   j  ; was: sub_2BDB0
                                        ; DATA XREF: ROM:off_5DC   o
                subq.w  #1,$4A(a5)
                bmi.s   loc_2BE1E
                cmpi.w  #$20,$4A(a5) ; ' '
                bpl.s   loc_2BDD2
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2BDD2
                bclr    #7,2(a5)
loc_2BDD2:                              ; CODE XREF: Boss_StateDispatcher+C   j
                                        ; Boss_StateDispatcher+1A   j
                bclr    #7,$22(a5)
                beq.s   loc_2BE26
                bclr    #4,$22(a5)
                bne.s   loc_2BE26
                move.b  $4C(a5),d0
                jsr (Sound_PlaySFX).l
                move.l  #$500,d0
                jsr (UI_AddScoreBCD).l
                move.w  (word_FFA216).w,d0
                beq.s   loc_2BE0E
                bmi.s   loc_2BE0E
                add.w   $48(a5),d0
                cmp.w   (word_FFA218).w,d0
                bmi.s   loc_2BE0E
                move.w  (word_FFA218).w,d0
loc_2BE0E:                              ; CODE XREF: Boss_StateDispatcher+4C   j
                                        ; Boss_StateDispatcher+4E   j ...
                move.w  d0,(word_FFA216).w
                move.w  $48(a5),(word_FF8262).w
                move.w  #$30,(word_FF8268).w ; '0'
loc_2BE1E:                              ; CODE XREF: Boss_StateDispatcher+4   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BE26:                              ; CODE XREF: Boss_StateDispatcher+28   j
                                        ; Boss_StateDispatcher+30   j
                andi.w  #$E7FF,$E(a5)
                lea     (word_1C972).l,a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),d0
                or.w    d0,$E(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,$10(a5)
                move.l  (dword_FF830A).w,d0
                add.l   d0,$14(a5)
                rts
; End of function Boss_StateDispatcher
; Sets animation data pointer with d0=3 and pointer to off_E953C
Gfx_SetAnimationPointer:                              ; CODE XREF: Sprite_InitializeObject+78   p  ; was: sub_2BE56
                                        ; Sprite_InitializeObject+86   p
                move.w  #3,d0
                movea.l #off_E953C,a1
; End of function Gfx_SetAnimationPointer
; Spawns multiple projectiles in pattern
Projectile_SpawnMultiPattern:                              ; CODE XREF: Projectile_SnakeSpawn3Way+26   p  ; was: sub_2BE60
                                        ; Projectile_SnakeSpawn3Way+3C   p ...
                move.w  #1,d7
                lsl.w   d0,d7
                subq.w  #1,d7
                move.w  #$1FF,d6
                lsr.w   d0,d6
                andi.w  #$1FE,d6
loc_2BE72:                              ; CODE XREF: Projectile_SpawnMultiPattern:loc_2BEB6   j
                jsr (Projectile_UpdateTrajectory).l
                bne.w   loc_2BEB6
                andi.w  #$1FE,d2
                lea     (word_1B514).l,a2
                move.w  (a2,d2.w),d4
                move.w  -$80(a2,d2.w),d5
                ext.l   d4
                ext.l   d5
                asl.l   d1,d4
                asl.l   d1,d5
                move.l  d4,$18(a0)
                move.l  d5,$1C(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  a1,8(a0)
                jsr (Sprite_InitializeProperties).l
                add.w   d6,d2
loc_2BEB6:                              ; CODE XREF: Projectile_SpawnMultiPattern+18   j
                dbf     d7,loc_2BE72
                rts
; End of function Projectile_SpawnMultiPattern
; Projectile explosion creating sprite with sound effect playback
Projectile_ExplodeWithSound:                              ; CODE XREF: Boss_SpawnMultipleShots+E   p  ; was: sub_2BEBC
                                        ; Projectile_JetsripperFalling+E   p ...
                jsr (Projectile_UpdateTrajectory).l
                bne.w   nullsub_61
                move.l  #off_E953C,8(a0)
                move.w  #$1A0,(a0)
                move.w  #6,$4A(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$4C(a0)
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
                bra.s Effect_InitializeExplosionEffect
; End of function Projectile_ExplodeWithSound
; Explosion effect when projectile hits
Projectile_ExplodeOnImpact:                              ; CODE XREF: Enemy_ProcessObject+10   p  ; was: sub_2BEF0
                                        ; Projectile_BouncingDebrisMain+9A   p ...
                jsr (Projectile_UpdateTrajectory).l
                bne.w   nullsub_61
                move.w  #8,$4A(a0)
                move.w  #$1A4,(a0)
                move.l  #off_E9560,8(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$4C(a0)
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
; Initializes explosion effect at entity position with palette
Effect_InitializeExplosionEffect:                              ; CODE XREF: Projectile_ExplodeWithSound+32   j  ; was: loc_2BF22
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  #$ED40,2(a0)
                move.w  #$480,$E(a0)
                clr.w   $C(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                rts
; End of function Projectile_ExplodeOnImpact
; Updates enemy phase pattern based on timer
Enemy_UpdatePhasePattern:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2BF58
                cmpi.w  #$80,$C(a5)
                bcc.w Enemy_CheckHealthThreshold
                cmpi.w  #$80,$10(a5)
                bcs.w Enemy_CheckHealthThreshold
                cmpi.w  #$1C0,$10(a5)
                bhi.w Enemy_CheckHealthThreshold
                cmpi.w  #$80,$14(a5)
                bcs.w Enemy_CheckHealthThreshold
                cmpi.w  #$160,$14(a5)
                bhi.w Enemy_CheckHealthThreshold
                bsr.w Enemy_PhaseHandler
                move.w  $4C(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_2BF9E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_UpdatePhasePattern
; ---------------------------------------------------------------------------
off_2BF9E:      dc.w Projectile_SetFallVelocity-*        ; DATA XREF: Enemy_UpdatePhasePattern+3E   o
                dc.w Enemy_PhaseStateDispatcher-*
                dc.w Projectile_PhaseDispatcher-*
                dc.w Projectile_PhaseDispatcher-*


; Sets falling velocity based on flag
Projectile_SetFallVelocity:                              ; DATA XREF: ROM:off_2BF9E   o  ; was: sub_2BFA6
                tst.w   $4E(a5)
                bne.s   loc_2BFB6
                move.l  #$FFFC0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2BFB6:                              ; CODE XREF: Projectile_SetFallVelocity+4   j
                subi.l  #$4000,$1C(a5)
                rts
; End of function Projectile_SetFallVelocity
; Enemy phase state dispatcher using jump table for substates
Enemy_PhaseStateDispatcher:                              ; DATA XREF: ROM:0002BFA0   o  ; was: sub_2BFC0
                move.w  $4E(a5),d0
                lea     off_2BFCC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_PhaseStateDispatcher
; ---------------------------------------------------------------------------
off_2BFCC:      dc.w Enemy_TargetPlayer-*        ; DATA XREF: Enemy_PhaseStateDispatcher+4   o
                dc.w Physics_ApplyPositiveGravity-*


; Calculates angle to player and sets velocity with upward trajectory
Enemy_TargetPlayer:                              ; DATA XREF: ROM:off_2BFCC   o  ; was: sub_2BFD0
                jsr (Math_CalculateAngleToPlayer).l
                addi.w  #$100,d2
                andi.w  #$1FE,d2
                lea     (word_1B514).l,a1
                move.w  (a1,d2.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,$4E(a5)
                rts
; End of function Enemy_TargetPlayer
; Applies positive gravity acceleration to vertical velocity
Physics_ApplyPositiveGravity:                              ; DATA XREF: ROM:0002BFCE   o  ; was: sub_2BFFE
                addi.l  #$4000,$1C(a5)
                rts
; End of function Physics_ApplyPositiveGravity
; Projectile phase state dispatcher using jump table pattern
Projectile_PhaseDispatcher:                              ; DATA XREF: ROM:0002BFA2   o  ; was: sub_2C008
                                        ; ROM:0002BFA4   o
                move.w  $4E(a5),d0
                lea     off_2C014(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_PhaseDispatcher
; ---------------------------------------------------------------------------
off_2C014:      dc.w Projectile_RandomAngleInit-*        ; DATA XREF: Projectile_PhaseDispatcher+4   o
                dc.w Projectile_InitRandomAngle-*
                dc.w Projectile_SpiralMotion-*


; Initializes projectile with random angle from RNG table
Projectile_RandomAngleInit:                              ; DATA XREF: ROM:off_2C014   o  ; was: sub_2C01A
                move.w  (dword_FFFF08).w,$5E(a5)
                addq.w  #2,$4E(a5)
; Initializes projectile with random angle from RNG table
Projectile_InitRandomAngle:                              ; DATA XREF: ROM:0002C016   o  ; was: loc_2C024
                andi.w  #$1FE,$5E(a5)
                move.w  $5E(a5),d2
                lea     (word_1B514).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                asl.l   #4,d0
                ext.l   d1
                asl.l   #4,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  #4,$5A(a5)
                addq.w  #2,$4E(a5)
                rts
; End of function Projectile_RandomAngleInit
; Projectile spiral motion pattern decreasing angle each frame
Projectile_SpiralMotion:                              ; DATA XREF: ROM:0002C018   o  ; was: sub_2C058
                subq.w  #1,$5A(a5)
                bne.w   nullsub_61
                cmpi.w  #3,$4C(a5)
                beq.s Projectile_ClearStateTimer
                addi.w  #-$40,$5E(a5)
                subq.w  #2,$4E(a5)
                rts
; ---------------------------------------------------------------------------
; Clears projectile state timer when condition met
Projectile_ClearStateTimer:                              ; CODE XREF: Projectile_SpiralMotion+E   j  ; was: loc_2C074
                clr.w   $4E(a5)
                rts
; End of function Projectile_SpiralMotion
; Enemy phase handler dispatcher for multi-phase attack patterns
Enemy_PhaseHandler:                              ; CODE XREF: Enemy_UpdatePhasePattern+32   p  ; was: sub_2C07A
                move.w  4(a5),d0
                lea     off_2C086(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_PhaseHandler
; ---------------------------------------------------------------------------
off_2C086:      dc.w Enemy_SpawnHelperSprite-*        ; DATA XREF: Enemy_PhaseHandler+4   o
                dc.w Enemy_HelperTimer-*
                dc.w Enemy_CheckHealthThreshold-*


; Spawns helper sprite for enemy with position and state init
Enemy_SpawnHelperSprite:                              ; DATA XREF: ROM:off_2C086   o  ; was: sub_2C08C
                jsr (Projectile_UpdateTrajectory).l
                bne.w   nullsub_61
                move.l  #off_E9560,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_SpawnHelperSprite
; Helper sprite timer countdown looping or advancing phase
Enemy_HelperTimer:                              ; DATA XREF: ROM:0002C088   o  ; was: sub_2C0BC
                subq.w  #1,$48(a5)
                bne.w   nullsub_61
                subq.w  #1,$4A(a5)
                beq.s   loc_2C0D0
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C0D0:                              ; CODE XREF: Enemy_HelperTimer+C   j
                addq.w  #2,4(a5)
                rts
; End of function Enemy_HelperTimer
; Checks enemy health against threshold value
Enemy_CheckHealthThreshold:                              ; CODE XREF: Enemy_UpdatePhasePattern+6   j  ; was: sub_2C0D6
                                        ; Enemy_UpdatePhasePattern+10   j ...
                bset    #4,2(a5)
                rts
; End of function Enemy_CheckHealthThreshold
; Boss part state dispatcher using jump table
Enemy_BossPartDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C0DE
                cmpi.w  #$80,$C(a5)
                bcc.w Enemy_CheckHealthThreshold
                move.w  $4C(a5),d0
                add.w   d0,d0
                move.w  d0,d0
                lea     off_2C0F8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BossPartDispatcher
; ---------------------------------------------------------------------------
off_2C0F8:      dc.w Projectile_SnakeDispatcher-*        ; DATA XREF: Enemy_BossPartDispatcher+12   o
                dc.w Projectile_SnakeSpawn3Way-*
                dc.w Projectile_SnakeSpawn6Way-*
                dc.w Projectile_SnakeSpawn8Way-*


; State dispatcher for Snake projectile
Projectile_SnakeDispatcher:                              ; DATA XREF: ROM:off_2C0F8   o  ; was: sub_2C100
                move.w  4(a5),d0
                lea     off_2C10C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_SnakeDispatcher
; ---------------------------------------------------------------------------
off_2C10C:      dc.w Projectile_SnakeInit-*        ; DATA XREF: Projectile_SnakeDispatcher+4   o
                dc.w Projectile_SnakeWait-*
                dc.w Enemy_CheckHealthThreshold-*


; Initializes Snake projectile
Projectile_SnakeInit:                              ; DATA XREF: ROM:off_2C10C   o  ; was: sub_2C112
                jsr (Projectile_UpdateTrajectory).l
                bne.w   nullsub_61
                move.l  #off_E953C,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d1 ; '?'
                subi.w  #$20,d1 ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeInit
; Snake projectile wait state
Projectile_SnakeWait:                              ; DATA XREF: ROM:0002C10E   o  ; was: sub_2C15E
                subq.w  #1,$48(a5)
                bne.w   nullsub_61
                subq.w  #1,$4A(a5)
                bmi.w   loc_2C174
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C174:                              ; CODE XREF: Projectile_SnakeWait+C   j
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeWait
; Spawns 3-way projectile pattern
Projectile_SnakeSpawn3Way:                              ; DATA XREF: ROM:0002C0FA   o  ; was: sub_2C17A
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #1,d0
                move.w  #1,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                move.w  #1,d0
                move.w  #3,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                move.w  #1,d0
                move.w  #5,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn3Way
; Spawns 6-way projectile pattern
Projectile_SnakeSpawn6Way:                              ; DATA XREF: ROM:0002C0FC   o  ; was: sub_2C1D6
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #2,d0
                move.w  #3,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                move.w  #2,d0
                move.w  #5,d1
                move.w  $58(a5),d2
                addi.w  #$40,d2 ; '@'
                andi.w  #$1FE,d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn6Way
; Spawns 8-way projectile pattern
Projectile_SnakeSpawn8Way:                              ; DATA XREF: ROM:0002C0FE   o  ; was: sub_2C224
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #3,d0
                move.w  #4,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn8Way
; Initializes debris projectile with ID $348, sets velocity values and random timer
Projectile_InitDebris:
                movea.w a5,a0  ; was: sub_2C254
; Initializes debris projectile object with random timer
Projectile_InitDebrisObject:                              ; CODE XREF: Boss_BugmaxSpawnDebris+30   p  ; was: loc_2C256
                move.w  #$348,(a0)
                move.w  #$F40,2(a0)
                move.w  d0,$4A(a0)
                move.w  d1,$4C(a0)
                move.w  d2,$4E(a0)
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$48(a0)
                rts
; End of function Projectile_InitDebris
; Main Bugmax projectile handler
Projectile_BugmaxMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C280
                subq.w  #1,$4A(a5)
                bpl.s Projectile_DispatchBugmaxState
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
; Dispatches Bugmax projectile to appropriate state handler
Projectile_DispatchBugmaxState:                              ; CODE XREF: Projectile_BugmaxMain+4   j  ; was: loc_2C28E
                move.w  4(a5),d0
                lea     off_2C29A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxMain
; ---------------------------------------------------------------------------
off_2C29A:      dc.w Projectile_BugmaxWait-*        ; DATA XREF: Projectile_BugmaxMain+12   o
                dc.w Projectile_BugmaxSpawn-*
                dc.w Projectile_BugmaxWaitLoop-*


; Wait before spawning
Projectile_BugmaxWait:                              ; DATA XREF: ROM:off_2C29A   o  ; was: sub_2C2A0
                subq.w  #1,$48(a5)
                bpl.s   locret_2C2AA
                addq.w  #2,4(a5)
locret_2C2AA:                           ; CODE XREF: Projectile_BugmaxWait+4   j
                rts
; End of function Projectile_BugmaxWait
; Spawns child projectiles
Projectile_BugmaxSpawn:                              ; DATA XREF: ROM:0002C29C   o  ; was: sub_2C2AC
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2C32A
                jsr     (RandomNumber).l
                btst    #0,(dword_FFFF08).w
                beq.s   loc_2C2CC
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
loc_2C2CC:                              ; CODE XREF: Projectile_BugmaxSpawn+14   j
                jsr (Projectile_InitType88).l
                btst    #0,(dword_FFFF08+2).w
                beq.s   loc_2C2E4
                move.l  #off_E953C,8(a0)
                bra.s Projectile_SpawnAtRandomOffset
; ---------------------------------------------------------------------------
loc_2C2E4:                              ; CODE XREF: Projectile_BugmaxSpawn+2C   j
                move.l  #off_E95DC,8(a0)
; Spawns projectile at random offset from parent position
Projectile_SpawnAtRandomOffset:                              ; CODE XREF: Projectile_BugmaxSpawn+36   j  ; was: loc_2C2EC
                move.b  (dword_FFFF08).w,d0
                move.w  $4C(a5),d1
                move.w  d1,d2
                subq.w  #1,d1
                and.w   d1,d0
                lsr.w   #1,d2
                sub.w   d2,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                move.w  $4E(a5),d1
                move.w  d1,d2
                subq.w  #1,d1
                and.w   d2,d0
                lsr.w   #1,d2
                sub.w   d2,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.w  #8,$50(a5)
                addq.w  #2,4(a5)
locret_2C32A:                           ; CODE XREF: Projectile_BugmaxSpawn+6   j
                rts
; End of function Projectile_BugmaxSpawn
; Wait loop state
Projectile_BugmaxWaitLoop:                              ; DATA XREF: ROM:0002C29E   o  ; was: sub_2C32C
                subq.w  #1,$50(a5)
                bne.s   locret_2C336
                subq.w  #2,4(a5)
locret_2C336:                           ; CODE XREF: Projectile_BugmaxWaitLoop+4   j
                rts
; End of function Projectile_BugmaxWaitLoop
nullsub_61:                             ; CODE XREF: Projectile_ExplodeWithSound+6   j
                                        ; Projectile_ExplodeOnImpact+6   j ...
                rts
; End of function nullsub_61


; Moves Jetsripper boss left with animation
Boss_JetsripperMoveLeft:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C76E   p  ; was: sub_2C33A
                tst.b   (byte_FFF705).w
                bmi.s   locret_2C35E
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FF8114).w,d0
                movea.w off_2C354(pc,d0.w),a0
                adda.l  #Boss_ClearFlag,a0
                jmp     (a0)
; End of function Boss_JetsripperMoveLeft
; ---------------------------------------------------------------------------
off_2C354:      dc.w locret_2C35E-Boss_ClearFlag
                                        ; DATA XREF: Boss_JetsripperMoveLeft+E   r
                dc.w Boss_JetsripperMoveRight-Boss_ClearFlag
                dc.w Boss_JetsripperMoveRight_UpdateTimer-Boss_ClearFlag


; Clears word at FF8114 RAM address, used by Jetsripper boss movement
Boss_ClearFlag:                              ; DATA XREF: Boss_JetsripperMoveLeft+12   o  ; was: sub_2C35A
                                        ; ROM:off_2C354   o ...
                clr.w   (word_FF8114).w
locret_2C35E:                           ; CODE XREF: Boss_JetsripperMoveLeft+4   j
                                        ; Boss_JetsripperMoveRight+E   j ...
                rts
; End of function Boss_ClearFlag
; Moves Jetsripper boss right with animation
Boss_JetsripperMoveRight:                              ; DATA XREF: ROM:0002C356   o  ; was: sub_2C360
                addq.w  #2,(word_FF8114).w
                move.w  #$A0,(dword_FF8116).w
; Updates movement timer for Jetstripper boss moving right
Boss_JetsripperMoveRight_UpdateTimer:                              ; DATA XREF: ROM:0002C358   o  ; was: loc_2C36A
                subq.w  #1,(dword_FF8116).w
                bpl.w   locret_2C35E
                bsr.w Boss_UpdateMovementPhase
                bsr.w Boss_SetAnimationFrame
                bne.w   locret_2C35E
                bsr.w Boss_InitAttackSequence
                move.w  #$158,d1
                move.w  (dword_FFFF08).w,(dword_FF8040).w
                andi.w  #1,(dword_FF8040).w
                bsr.w Boss_UpdateAttackTimer
                bne.w   locret_2C35E
                move.w  #$1C,(a0)
                move.b  #$B,$5F(a0)
                bra.w Boss_AdjustPositionToPlayer
; End of function Boss_JetsripperMoveRight
; Clears four consecutive longwords starting at FF8116, likely movement/state buffers
Boss_ClearMovementBuffers:
                moveq   #0,d0  ; was: sub_2C3A8
                move.l  d0,(dword_FF8116).w
                move.l  d0,(dword_FF811A).w
                move.l  d0,(dword_FF811E).w
                move.l  d0,(dword_FF8122).w
                rts
; End of function Boss_ClearMovementBuffers
; Updates boss movement phase and direction
Boss_UpdateMovementPhase:                              ; CODE XREF: Boss_JetsripperMoveRight+12   p  ; was: sub_2C3BC
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,(dword_FF8116).w
                rts
; End of function Boss_UpdateMovementPhase
; Initializes boss attack sequence with timers
Boss_InitAttackSequence:                              ; CODE XREF: Boss_JetsripperMoveRight+1E   p  ; was: sub_2C3CE
                move.w  #$1D0,d0
                tst.w   (word_FFFF0E).w
                beq.s   locret_2C3F6
                cmpi.w  #2,(dword_FFA910).w
                bpl.s   locret_2C3F6
                cmpi.w  #$C0,(dword_FFA410).w
                bmi.s   locret_2C3F6
                move.b  (dword_FFFF08).w,d1
                andi.w  #3,d1
                bne.s   locret_2C3F6
                move.w  #$70,d0 ; 'p'
locret_2C3F6:                           ; CODE XREF: Boss_InitAttackSequence+8   j
                                        ; Boss_InitAttackSequence+10   j ...
                rts
; End of function Boss_InitAttackSequence
; Sets boss animation frame from lookup table
Boss_SetAnimationFrame:                              ; CODE XREF: Boss_JetsripperMoveRight+16   p  ; was: sub_2C3F8
                movea.w #(byte_FFCE00-M68K_RAM),a0
                moveq   #3,d7
loc_2C3FE:                              ; CODE XREF: Boss_SetAnimationFrame+E   j
                tst.w   (a0)
                beq.s   loc_2C40E
                lea     $60(a0),a0
                dbf     d7,loc_2C3FE
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_2C40E:                              ; CODE XREF: Boss_SetAnimationFrame+8   j
                jsr (Sys_Clear96ByteBlock).l
                suba.w  #$60,a0 ; '`'
                moveq   #0,d0
                rts
; End of function Boss_SetAnimationFrame
; Updates attack timer and transitions states
Boss_UpdateAttackTimer:                              ; CODE XREF: Boss_JetsripperMoveRight+32   p  ; was: sub_2C41C
                lea     (M68K_RAM).l,a2
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFFF,d6
                move.w  d0,d2
                addi.w  #$10,d2
                bsr.w Boss_CheckPlayerPosition
                move.w  d2,d3
                move.w  d0,d2
                subi.w  #$10,d2
                bsr.w Boss_CheckPlayerPosition
                moveq   #$17,d7
loc_2C446:                              ; CODE XREF: Boss_UpdateAttackTimer+7A   j
                move.w  (a2,d2.w),d4
                andi.w  #$7FF,d4
                move.b  (a1,d4.w),d4
                andi.b  #$FE,d4
                beq.s   loc_2C470
                move.w  (a2,d3.w),d4
                andi.w  #$7FF,d4
                move.b  (a1,d4.w),d4
                andi.b  #$FE,d4
                beq.s   loc_2C470
                moveq   #0,d6
                move.w  d1,d5
                bra.s   loc_2C484
; ---------------------------------------------------------------------------
loc_2C470:                              ; CODE XREF: Boss_UpdateAttackTimer+3A   j
                                        ; Boss_UpdateAttackTimer+4C   j
                tst.w   d6
                bmi.s   loc_2C484
                addq.w  #1,d6
                cmpi.w  #7,d6
                bmi.s   loc_2C484
                subq.w  #1,(dword_FF8040).w
                bmi.s   loc_2C49E
                moveq   #$FFFFFFFF,d6
loc_2C484:                              ; CODE XREF: Boss_UpdateAttackTimer+52   j
                                        ; Boss_UpdateAttackTimer+56   j ...
                subq.w  #8,d1
                subi.w  #$80,d2
                andi.w  #$1FFE,d2
                subi.w  #$80,d3
                andi.w  #$1FFE,d3
                dbf     d7,loc_2C446
                moveq   #1,d7
                rts
; ---------------------------------------------------------------------------
loc_2C49E:                              ; CODE XREF: Boss_UpdateAttackTimer+64   j
                moveq   #0,d7
                rts
; End of function Boss_UpdateAttackTimer
; Checks player position relative to boss
Boss_CheckPlayerPosition:                              ; CODE XREF: Boss_UpdateAttackTimer+18   p  ; was: sub_2C4A2
                                        ; Boss_UpdateAttackTimer+24   p
                sub.w   d7,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2 ; '~'
                move.w  d1,d4
                sub.w   d7,d4
                sub.w   (dword_FFA904).w,d4
                asl.w   #4,d4
                andi.w  #$1F80,d4
                add.w   d4,d2
                rts
; End of function Boss_CheckPlayerPosition
; Adjusts boss position based on player location
Boss_AdjustPositionToPlayer:                              ; CODE XREF: Boss_JetsripperMoveRight+44   j  ; was: sub_2C4C0
                move.w  d0,$10(a0)
                subi.w  #$20,d5 ; ' '
                move.w  d5,$14(a0)
                cmpi.w  #$120,$10(a0)
                bpl.s   locret_2C4DA
                bset    #7,$5F(a0)
locret_2C4DA:                           ; CODE XREF: Boss_AdjustPositionToPlayer+12   j
                rts
; End of function Boss_AdjustPositionToPlayer
; Sets up boss sprite properties and palette
Sprite_SetupBossSprite:                              ; CODE XREF: Enemy_MainStateMachine+2   p  ; was: sub_2C4DC
                                        ; Enemy_DestroyIfOffscreen+6   p ...
                move.w  #$EF00,2(a5)
                move.w  (word_FF826E).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                btst    #7,$5F(a5)
                beq.s Sprite_SetupBossAttributes
                bclr    #3,$E(a5)
; Sets up boss sprite attributes including palette and size
Sprite_SetupBossAttributes:                              ; CODE XREF: Sprite_SetupBossSprite+18   j  ; was: loc_2C4FC
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$E420E818,$28(a5)
                lea     byte_2C538(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Sprite_SetupBossSprite
; ---------------------------------------------------------------------------
byte_2C538:     dc.b $18, 4, $11, 0     ; DATA XREF: Sprite_SetupBossSprite+3C   o


; Updates animation pointer based on current state index
Anim_UpdateAnimationState:                              ; CODE XREF: Enemy_BehaviorController+52   j  ; was: sub_2C53C
                                        ; Enemy_AnimationWrapper+2   j ...
                move.w  $5C(a5),d0
                beq.s   locret_2C54E
                subq.w  #4,d0
                move.l  off_2C550(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2C54E:                           ; CODE XREF: Anim_UpdateAnimationState+4   j
                rts
; End of function Anim_UpdateAnimationState
; ---------------------------------------------------------------------------
off_2C550:      dc.l off_E9E1C          ; DATA XREF: Anim_UpdateAnimationState+8   r
                dc.l off_E9E08
                dc.l off_E9E40
                dc.l off_E9E68
                dc.l off_E9E80


; Applies horizontal acceleration with speed limits
Physics_AccelerateHorizontal:                              ; CODE XREF: Enemy_MainStateMachine:loc_2C814   p  ; was: sub_2C564
                btst    #3,$E(a5)
                bne.s   loc_2C590
                move.l  $18(a5),d0
                bmi.s   loc_2C584
                cmpi.l  #$20000,d0
                bmi.s   loc_2C584
                move.l  #$20000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C584:                              ; CODE XREF: Physics_AccelerateHorizontal+C   j
                                        ; Physics_AccelerateHorizontal+14   j
                addi.l  #$2000,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C590:                              ; CODE XREF: Physics_AccelerateHorizontal+6   j
                move.l  $18(a5),d0
                bpl.s   loc_2C5A8
                cmpi.l  #$FFFE0000,d0
                bpl.s   loc_2C5A8
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C5A8:                              ; CODE XREF: Physics_AccelerateHorizontal+30   j
                                        ; Physics_AccelerateHorizontal+38   j
                subi.l  #$2000,d0
                move.l  d0,$18(a5)
                rts
; End of function Physics_AccelerateHorizontal
; Applies horizontal deceleration and stops at threshold
Physics_DecelerateHorizontal:                              ; CODE XREF: Enemy_MainStateMachine+42   p  ; was: sub_2C5B4
                                        ; Enemy_MainStateMachine+17E   j ...
                move.l  $18(a5),d0
                beq.s   locret_2C5CE
                bmi.s   loc_2C5D0
                cmpi.l  #$3800,d0
                bmi.s   loc_2C5E4
                subi.l  #$3800,d0
                move.l  d0,$18(a5)
locret_2C5CE:                           ; CODE XREF: Physics_DecelerateHorizontal+4   j
                rts
; ---------------------------------------------------------------------------
loc_2C5D0:                              ; CODE XREF: Physics_DecelerateHorizontal+6   j
                cmpi.l  #$FFFFC800,d0
                bpl.s   loc_2C5E4
                addi.l  #$3800,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C5E4:                              ; CODE XREF: Physics_DecelerateHorizontal+E   j
                                        ; Physics_DecelerateHorizontal+22   j
                clr.l   $18(a5)
                rts
; End of function Physics_DecelerateHorizontal
; Initializes homing projectile that tracks player with angle calculation
Enemy_InitTrackedProjectile:                              ; CODE XREF: Enemy_MainStateMachine+1B6   j  ; was: sub_2C5EA
                jsr (Projectile_UpdateTrajectory).l
                beq.s   loc_2C5F4
                rts
; ---------------------------------------------------------------------------
loc_2C5F4:                              ; CODE XREF: Enemy_InitTrackedProjectile+6   j
                moveq   #$FFFFFFE8,d0
                moveq   #$FFFFFFFA,d1
                move.w  (word_FF808A).w,d2
                move.b  $20(a5),d2
                subq.w  #4,d2
                move.w  #$100,d6
                btst    #3,$E(a5)
                bne.s Enemy_CalculateHomingAngle
                moveq   #0,d6
                neg.w   d0
; Calculates homing angle for projectile targeting player
Enemy_CalculateHomingAngle:                              ; CODE XREF: Enemy_InitTrackedProjectile+22   j  ; was: loc_2C612
                move.w  (word_FFFF0E).w,d7
                asr.w   #1,d7
                addi.w  #9,d7
                jmp Enemy_SetProjectileDifficulty
; End of function Enemy_InitTrackedProjectile
; Fires projectiles in pattern based on attack state
Boss_FireProjectilePattern:                              ; CODE XREF: Enemy_BehaviorController+A   j  ; was: sub_2C622
                                        ; Enemy_BehaviorController+12   j ...
                move.w  #$1D4,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_E9E80,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                clr.w   $4A(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2C664
                neg.l   $18(a5)
locret_2C664:                           ; CODE XREF: Boss_FireProjectilePattern+3C   j
                rts
; End of function Boss_FireProjectilePattern
; Spawns multiple projectiles in sequence
Boss_SpawnMultipleShots:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C666
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s Boss_ToggleVisibilityBit
                jsr (Projectile_ExplodeWithSound).l
                tst.w   $4A(a5)
                beq.w   loc_2C68A
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C68A:                              ; CODE XREF: Boss_SpawnMultipleShots+18   j
                moveq   #7,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
; Toggles boss visibility bit based on animation frame
Boss_ToggleVisibilityBit:                              ; CODE XREF: Boss_SpawnMultipleShots+C   j  ; was: loc_2C692
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2C6A6
                bclr    #7,2(a5)
locret_2C6A6:                           ; CODE XREF: Boss_SpawnMultipleShots+38   j
                rts
; End of function Boss_SpawnMultipleShots
; Main AI controller for enemy behavior and state management
Enemy_BehaviorController:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C6A8
                tst.w   4(a5)
                beq.s Enemy_DispatchBehaviorState
                tst.w   $24(a5)
                bmi.w Boss_FireProjectilePattern
                tst.w   (word_FF808C).w
                bpl.w Boss_FireProjectilePattern
                btst    #7,$22(a5)
                beq.s   loc_2C6D8
                btst    #4,$22(a5)
                bne.s   loc_2C6D8
                bsr.w Boss_FireProjectilePattern
                addq.w  #1,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C6D8:                              ; CODE XREF: Enemy_BehaviorController+1C   j
                                        ; Enemy_BehaviorController+24   j
                cmpi.w  #$FF00,$5A(a5)
                bmi.w Boss_FireProjectilePattern
                subq.w  #1,$5A(a5)
                bpl.s   loc_2C6EE
                move.w  #$13,$5E(a5)
loc_2C6EE:                              ; CODE XREF: Enemy_BehaviorController+3E   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Dispatches enemy to behavior state handler and updates animation
Enemy_DispatchBehaviorState:                              ; CODE XREF: Enemy_BehaviorController+4   j  ; was: loc_2C6F8
                bsr.s Enemy_StateDispatcher
                bra.w Anim_UpdateAnimationState
; End of function Enemy_BehaviorController
; Dispatches enemy to appropriate state handler
Enemy_StateDispatcher:                              ; CODE XREF: Enemy_BehaviorController:loc_2C6F8   p  ; was: sub_2C6FE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C712(pc,d0.w),a0
                adda.l  #Enemy_MainStateMachine,a0
                jmp     (a0)
; End of function Enemy_StateDispatcher
; ---------------------------------------------------------------------------
off_2C712:      dc.w Enemy_MainStateMachine-Enemy_MainStateMachine
                                        ; DATA XREF: Enemy_StateDispatcher+8   r
                dc.w Enemy_MainStateMachine_UpdateState-Enemy_MainStateMachine
                dc.w Enemy_ExecuteMovementPattern-Enemy_MainStateMachine
                dc.w Enemy_MainStateMachine_TerrainCheck-Enemy_MainStateMachine
                dc.w Enemy_MainStateMachine_GroundedTimer-Enemy_MainStateMachine
                dc.w Enemy_MainStateMachine_AttackCooldown-Enemy_MainStateMachine


; Main enemy state machine with movement and attack patterns
Enemy_MainStateMachine:                              ; DATA XREF: Enemy_StateDispatcher+C   o  ; was: sub_2C71E
                                        ; ROM:off_2C712   o ...
                moveq   #0,d0
                bsr.w Sprite_SetupBossSprite
loc_2C724:                              ; CODE XREF: Enemy_MainStateMachine+B6   j
                                        ; Enemy_MainStateMachine+198   j
                btst    #0,$5F(a5)
                bne.w   loc_2C78C
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$3F,d1 ; '?'
                addi.w  #8,d1
                move.w  d1,$48(a5)
; Main enemy AI state machine update loop
Enemy_MainStateMachine_UpdateState:                              ; DATA XREF: ROM:0002C714   o  ; was: loc_2C74A
                subq.w  #1,$48(a5)
                bmi.w   loc_2C78C
                bsr.w Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bsr.w Physics_DecelerateHorizontal
loc_2C764:                              ; CODE XREF: Enemy_MainStateMachine+FA   j
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$78,d0 ; 'x'
                bpl.s   loc_2C77A
                btst    #2,$5F(a5)
                bne.w   loc_2C8A0
loc_2C77A:                              ; CODE XREF: Enemy_MainStateMachine+50   j
                cmpi.w  #$50,d0 ; 'P'
                bpl.s   locret_2C78A
                btst    #3,$5F(a5)
                bne.w   loc_2C830
locret_2C78A:                           ; CODE XREF: Enemy_MainStateMachine+60   j
                rts
; ---------------------------------------------------------------------------
loc_2C78C:                              ; CODE XREF: Enemy_MainStateMachine+C   j
                                        ; Enemy_MainStateMachine+30   j ...
                btst    #4,$5F(a5)
                bne.w   loc_2C79E
                bsr.w Enemy_FacePlayer
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_2C79E:                              ; CODE XREF: Enemy_MainStateMachine+74   j
                                        ; Enemy_MainStateMachine+7C   j
                move.w  #4,4(a5)
                move.w  #8,$5C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$7F,d1
                addi.w  #$80,d1
                move.w  d1,$48(a5)
                tst.w   $5A(a5)
                bpl.s Enemy_ExecuteMovementPattern
                bset    #3,$E(a5)
; Executes enemy movement pattern with terrain collision checks
Enemy_ExecuteMovementPattern:                              ; CODE XREF: Enemy_MainStateMachine+A0   j  ; was: loc_2C7C6
                                        ; DATA XREF: ROM:0002C716   o
                btst    #0,$5F(a5)
                bne.w   loc_2C7D8
                subq.w  #1,$48(a5)
                bmi.w   loc_2C724
loc_2C7D8:                              ; CODE XREF: Enemy_MainStateMachine+AE   j
                bsr.w Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                btst    #3,$E(a5)
                bne.s   loc_2C7F8
                btst    #1,7(a5)
                beq.s   loc_2C814
                bra.s   loc_2C800
; ---------------------------------------------------------------------------
loc_2C7F8:                              ; CODE XREF: Enemy_MainStateMachine+CE   j
                btst    #0,7(a5)
                beq.s   loc_2C814
loc_2C800:                              ; CODE XREF: Enemy_MainStateMachine+D8   j
                btst    #1,$5F(a5)
                bne.w   loc_2C830
                eori.w  #$800,$E(a5)
                clr.l   $18(a5)
loc_2C814:                              ; CODE XREF: Enemy_MainStateMachine+D6   j
                                        ; Enemy_MainStateMachine+E0   j
                bsr.w Physics_AccelerateHorizontal
                bra.w   loc_2C764
; ---------------------------------------------------------------------------
loc_2C81C:                              ; CODE XREF: Enemy_MainStateMachine+3E   j
                                        ; Enemy_MainStateMachine+C4   j ...
                move.l  #$FFFEE000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                bra.s   loc_2C844
; ---------------------------------------------------------------------------
loc_2C830:                              ; CODE XREF: Enemy_MainStateMachine+68   j
                                        ; Enemy_MainStateMachine+E8   j
                move.l  #$FFFA8000,$1C(a5)
                move.l  #$FFFE8000,$18(a5)
                bsr.w Physics_NegateVelocityIfFacingLeft
loc_2C844:                              ; CODE XREF: Enemy_MainStateMachine+110   j
                move.w  #6,4(a5)
                move.w  #$14,$5C(a5)
; Performs terrain collision check in enemy state machine
Enemy_MainStateMachine_TerrainCheck:                              ; DATA XREF: ROM:0002C718   o  ; was: loc_2C850
                jsr (Physics_BossTerrainCheck).l
                bsr.w Physics_AccelerateGravity
                bmi.s   loc_2C86E
                jsr (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_2C874
                rts
; ---------------------------------------------------------------------------
loc_2C86E:                              ; CODE XREF: Enemy_MainStateMachine+13C   j
                jmp Physics_TerrainCheckWithVelocity
; ---------------------------------------------------------------------------
loc_2C874:                              ; CODE XREF: Enemy_MainStateMachine+14A   j
                move.w  #8,4(a5)
                move.w  #$C,$5C(a5)
                move.w  #$14,$48(a5)
; Handles grounded state timer for enemy
Enemy_MainStateMachine_GroundedTimer:                              ; DATA XREF: ROM:0002C71A   o  ; was: loc_2C886
                subq.w  #1,$48(a5)
                bmi.w   loc_2C78C
                bsr.w Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bra.w Physics_DecelerateHorizontal
; ---------------------------------------------------------------------------
loc_2C8A0:                              ; CODE XREF: Enemy_MainStateMachine+58   j
                move.w  #$A,4(a5)
                move.w  #$10,$5C(a5)
                move.w  #$36,$48(a5) ; '6'
; Decrements attack timer and branches to attack init or face player timing
Enemy_MainStateMachine_AttackCooldown:                              ; DATA XREF: ROM:0002C71C   o  ; was: loc_2C8B2
                subq.w  #1,$48(a5)
                bmi.w   loc_2C724
                bsr.w Player_UpdatePhysics
                btst    #0,6(a5)
                beq.w   loc_2C81C
                bsr.w Physics_DecelerateHorizontal
                cmpi.w  #$1E,$48(a5)
                bne.s Enemy_CheckFacePlayerTiming
                bra.w Enemy_InitTrackedProjectile
; ---------------------------------------------------------------------------
; Checks if it's time to face player direction during movement
Enemy_CheckFacePlayerTiming:                              ; CODE XREF: Enemy_MainStateMachine+1B4   j  ; was: loc_2C8D8
                cmpi.w  #$10,$48(a5)
                bpl.w Enemy_FacePlayer
                rts
; End of function Enemy_MainStateMachine
; Wrapper calling visibility check and animation update
Enemy_AnimationWrapper:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C8E4
                bsr.s Enemy_CheckBoundsVisibility
                bra.w Anim_UpdateAnimationState
; End of function Enemy_AnimationWrapper
; Checks if enemy is within visible screen bounds
Enemy_CheckBoundsVisibility:                              ; CODE XREF: Enemy_AnimationWrapper   p  ; was: sub_2C8EA
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C8FE(pc,d0.w),a0
                adda.l  #Enemy_DestroyIfOffscreen,a0
                jmp     (a0)
; End of function Enemy_CheckBoundsVisibility
; ---------------------------------------------------------------------------
off_2C8FE:      dc.w Enemy_DestroyIfOffscreen-Enemy_DestroyIfOffscreen
                                        ; DATA XREF: Enemy_CheckBoundsVisibility+8   r
                dc.w Boss_SetupDestructionState-Enemy_DestroyIfOffscreen


; Marks enemy for destruction if beyond screen bounds
Enemy_DestroyIfOffscreen:                              ; DATA XREF: Enemy_CheckBoundsVisibility+C   o  ; was: sub_2C902
                                        ; ROM:off_2C8FE   o ...
                addq.w  #2,4(a5)
                moveq   #0,d0
                bsr.w Sprite_SetupBossSprite
                move.w  #$24,$48(a5) ; '$'
                clr.b   $21(a5)
                move.b  #$7C,$20(a5) ; '|'
                move.w  #4,$5C(a5)
                bclr    #7,$E(a5)
; Sets up boss destruction state with timer and animation
Boss_SetupDestructionState:                              ; DATA XREF: ROM:0002C900   o  ; was: loc_2C928
                subq.w  #1,$48(a5)
                bpl.s   locret_2C938
                move.w  #$1C,(a5)
                moveq   #0,d0
                bsr.w Sprite_SetupBossSprite
locret_2C938:                           ; CODE XREF: Enemy_DestroyIfOffscreen+2A   j
                rts
; End of function Enemy_DestroyIfOffscreen
; Initializes sprite properties for enemy object
Sprite_InitializeEnemySprite:                              ; CODE XREF: Enemy_InitializeWithHealth+6   p  ; was: sub_2C93A
                move.w  #$E300,2(a5)
                move.w  (word_FF8270).w,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.w  #$2A,$26(a5) ; '*'
                move.l  #$E818F010,$2C(a5)
                move.l  #$E21EE818,$28(a5)
                rts
; End of function Sprite_InitializeEnemySprite
; Updates enemy animation frame based on state
Anim_UpdateEnemyAnimation:                              ; CODE XREF: Enemy_ProcessObject+20   j  ; was: sub_2C970
                move.w  $5C(a5),d0
                beq.s   locret_2C982
                subq.w  #4,d0
                move.l  off_2C984(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2C982:                           ; CODE XREF: Anim_UpdateEnemyAnimation+4   j
                rts
; End of function Anim_UpdateEnemyAnimation
; ---------------------------------------------------------------------------
off_2C984:      dc.l off_EA00E          ; DATA XREF: Anim_UpdateEnemyAnimation+8   r
                dc.l off_EA04A
                dc.l off_EA036


; Main processing routine for enemy object
Enemy_ProcessObject:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C990
                tst.b   $21(a5)
                beq.s Enemy_RunBehaviorHandler
                clr.w   6(a5)
                tst.w   $24(a5)
                bpl.s Enemy_RunBehaviorHandler
                jsr (Projectile_ExplodeOnImpact).l
                moveq   #3,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
; Runs enemy behavior state handler and updates animation
Enemy_RunBehaviorHandler:                              ; CODE XREF: Enemy_ProcessObject+4   j  ; was: loc_2C9AE
                                        ; Enemy_ProcessObject+E   j
                bsr.s Enemy_RunStateHandler
                bra.w Anim_UpdateEnemyAnimation
; End of function Enemy_ProcessObject
; Executes current enemy state handler
Enemy_RunStateHandler:                              ; CODE XREF: Enemy_ProcessObject:loc_2C9AE   p  ; was: sub_2C9B4
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2C9C8(pc,d0.w),a0
                adda.l  #Enemy_InitializeWithHealth,a0
                jmp     (a0)
; End of function Enemy_RunStateHandler
; ---------------------------------------------------------------------------
off_2C9C8:      dc.w Enemy_InitializeWithHealth-Enemy_InitializeWithHealth
                                        ; DATA XREF: Enemy_RunStateHandler+8   r
                dc.w Enemy_InitializeWaitState-Enemy_InitializeWithHealth
                dc.w Boss_DeathSequence-Enemy_InitializeWithHealth
                dc.w Boss_SpawnPeriodicShots-Enemy_InitializeWithHealth


; Initializes enemy with health value and sprite setup
Enemy_InitializeWithHealth:                              ; DATA XREF: Enemy_RunStateHandler+C   o  ; was: sub_2C9D0
                                        ; ROM:off_2C9C8   o ...
                move.w  #$62,$24(a5) ; 'b'
                bsr.w Sprite_InitializeEnemySprite
                clr.w   $48(a5)
loc_2C9DE:                              ; CODE XREF: Boss_SpawnPeriodicShots+C   j
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
; Initializes enemy waiting state with timer values
Enemy_InitializeWaitState:                              ; DATA XREF: ROM:0002C9CA   o  ; was: loc_2C9EA
                subq.w  #1,$48(a5)
                bpl.s   locret_2CA00
                addq.w  #2,4(a5)
                move.w  #$28,$48(a5) ; '('
                move.w  #8,$5C(a5)
locret_2CA00:                           ; CODE XREF: Enemy_InitializeWithHealth+1E   j
                rts
; End of function Enemy_InitializeWithHealth
; Handles Jetsripper boss death animation and cleanup
Boss_DeathSequence:                              ; DATA XREF: ROM:0002C9CC   o  ; was: sub_2CA02
                subq.w  #1,$48(a5)
                bpl.s   locret_2CA18
                addq.w  #2,4(a5)
                move.w  #$180,$48(a5)
                move.w  #$C,$5C(a5)
locret_2CA18:                           ; CODE XREF: Boss_DeathSequence+4   j
                rts
; End of function Boss_DeathSequence
; Boss spawns periodic projectiles based on timer countdown
Boss_SpawnPeriodicShots:                              ; DATA XREF: ROM:0002C9CE   o  ; was: sub_2CA1A
                subq.w  #1,$48(a5)
                bpl.s Boss_SpawnPeriodicShot
                move.w  #$120,$48(a5)
                bra.w   loc_2C9DE
; ---------------------------------------------------------------------------
; Spawns periodic shot at regular intervals during boss pattern
Boss_SpawnPeriodicShot:                              ; CODE XREF: Boss_SpawnPeriodicShots+4   j  ; was: loc_2CA2A
                move.w  $48(a5),d0
                andi.w  #$1F,d0
                bne.s   locret_2CA3E
                moveq   #0,d5
                moveq   #$FFFFFFF0,d6
                jsr (Boss_SpawnTargetedProjectile).l
locret_2CA3E:                           ; CODE XREF: Boss_SpawnPeriodicShots+18   j
                rts
; End of function Boss_SpawnPeriodicShots
; Initializes sprite properties for projectile object
Sprite_InitializeProjectileSprite:                              ; CODE XREF: Enemy_ProjectileStateMachine+6   p  ; was: sub_2CA40
                                        ; Enemy_AltProjectileStateMachine+6   p
                move.w  #$EF00,2(a5)
                move.w  (word_FF8272).w,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.w  #$F,$26(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$E420F010,$28(a5)
                rts
; End of function Sprite_InitializeProjectileSprite
; Updates projectile animation frame
Anim_UpdateProjectileAnimation:                              ; CODE XREF: Enemy_ProcessProjectile+16   j  ; was: sub_2CA7C
                                        ; Enemy_ProcessAltProjectile+14   j
                move.w  $5C(a5),d0
                beq.s   locret_2CA8E
                subq.w  #4,d0
                move.l  off_2CA90(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2CA8E:                           ; CODE XREF: Anim_UpdateProjectileAnimation+4   j
                rts
; End of function Anim_UpdateProjectileAnimation
; ---------------------------------------------------------------------------
off_2CA90:      dc.l off_EA5DC          ; DATA XREF: Anim_UpdateProjectileAnimation+8   r
                dc.l off_EA5B8
                dc.l off_EA5F8
                dc.l off_EA61C
                dc.l off_EA634
                dc.l off_EA64C
                dc.l off_EA664
                dc.l off_EA67C
                dc.l off_EA69C
                dc.l off_EA6A8


; Sets horizontal velocity based on entity flip direction
Physics_SetHorizontalVelocityByFlip:                              ; CODE XREF: Enemy_ProjectileStateMachine+9E   j  ; was: sub_2CAB8
                                        ; Enemy_ProjectileStateMachine+B6   p
                btst    #3,$E(a5)
                bne.s   loc_2CACA
                move.l  #$30000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CACA:                              ; CODE XREF: Physics_SetHorizontalVelocityByFlip+6   j
                move.l  #$FFFD0000,$18(a5)
                rts
; End of function Physics_SetHorizontalVelocityByFlip
; Applies friction to horizontal velocity by decrementing/incrementing by $4000 toward zero
Physics_ApplyHorizontalFriction:                              ; CODE XREF: Enemy_ProjectileStateMachine:loc_2CC8C   j  ; was: sub_2CAD4
                                        ; sub_2CD54:loc_2CD96   p
                move.l  $18(a5),d0
                beq.s   locret_2CAEE
                bmi.s   loc_2CAF0
                cmpi.l  #$4000,d0
                bmi.s   loc_2CB04
                subi.l  #$4000,d0
                move.l  d0,$18(a5)
locret_2CAEE:                           ; CODE XREF: Physics_ApplyHorizontalFriction+4   j
                rts
; ---------------------------------------------------------------------------
loc_2CAF0:                              ; CODE XREF: Physics_ApplyHorizontalFriction+6   j
                cmpi.l  #$FFFFC000,d0
                bpl.s   loc_2CB04
                addi.l  #$4000,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CB04:                              ; CODE XREF: Physics_ApplyHorizontalFriction+E   j
                                        ; Physics_ApplyHorizontalFriction+22   j
                clr.l   $18(a5)
                rts
; End of function Physics_ApplyHorizontalFriction
; Calculates appropriate sprite and offsets based on angle to player
Enemy_CalculateDirectionalSprite:                              ; CODE XREF: Enemy_AltProjectileStateMachine+58   p  ; was: sub_2CB0A
                jsr (Math_CalculateAngleToPlayer).l
                move.w  d2,d5
                addi.w  #$20,d5 ; ' '
                lsr.w   #4,d5
                andi.w  #$1C,d5
                lea     off_2CB56(pc),a0
                nop
                move.l  (a0,d5.w),d0
                bclr    #3,$E(a5)
                bclr    #0,d0
                beq.s Sprite_SetDirectionalAnimation
                bset    #3,$E(a5)
; Sets directional animation sprite based on calculated angle
Sprite_SetDirectionalAnimation:                              ; CODE XREF: Enemy_CalculateDirectionalSprite+26   j  ; was: loc_2CB38
                move.l  d0,8(a5)
                clr.w   $C(a5)
                lea     word_2CB76(pc),a1
                nop
                lsr.w   #1,d5
                move.b  (a1,d5.w),d3
                move.b  1(a1,d5.w),d4
                ext.w   d3
                ext.w   d4
                rts
; End of function Enemy_CalculateDirectionalSprite
; ---------------------------------------------------------------------------
off_2CB56:      dc.l off_EA61C          ; DATA XREF: Enemy_CalculateDirectionalSprite+12   o
                dc.l off_EA664
                dc.l off_EA634
                dc.l off_EA664+1
                dc.l off_EA61C+1
                dc.l off_EA634+1
                dc.l off_EA64C
                dc.l off_EA634
word_2CB76:     dc.w $12F8, $C06, 0, $F406, $EEF8, $F4E8, $E4, $CE8
                                        ; DATA XREF: Enemy_CalculateDirectionalSprite+36   o


; Jetsripper idle state with hovering animation
Boss_JetsripperIdle:                              ; CODE XREF: Enemy_ProcessAltProjectile+E   j  ; was: sub_2CB86
                move.w  #$1D8,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_EA69C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2CBC4
                neg.l   $18(a5)
locret_2CBC4:                           ; CODE XREF: Boss_JetsripperIdle+38   j
                rts
; End of function Boss_JetsripperIdle
; Falling projectile handler
Projectile_JetsripperFalling:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2CBC6
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2CBE2
                jsr (Projectile_ExplodeWithSound).l
                moveq   #7,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2CBE2:                              ; CODE XREF: Projectile_JetsripperFalling+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2CBF6
                bclr    #7,2(a5)
locret_2CBF6:                           ; CODE XREF: Projectile_JetsripperFalling+28   j
                rts
; End of function Projectile_JetsripperFalling
; Main processing routine for projectile object
Enemy_ProcessProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2CBF8
                tst.w   4(a5)
                beq.s Enemy_ProcessProjectileState
                clr.w   6(a5)
                tst.w   $24(a5)
                bpl.s Enemy_ProcessProjectileState
                bsr.w Boss_JokerRecoilAttack
; Processes projectile-type enemy state with recoil attack check
Enemy_ProcessProjectileState:                              ; CODE XREF: Enemy_ProcessProjectile+4   j  ; was: loc_2CC0C
                                        ; Enemy_ProcessProjectile+E   j
                bsr.s Enemy_ProjectileStateHandler
                bra.w Anim_UpdateProjectileAnimation
; End of function Enemy_ProcessProjectile
; Dispatches projectile to state handler
Enemy_ProjectileStateHandler:                              ; CODE XREF: Enemy_ProcessProjectile:loc_2CC0C   p  ; was: sub_2CC12
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CC26(pc,d0.w),a0
                adda.l  #Enemy_ProjectileStateMachine,a0
                jmp     (a0)
; End of function Enemy_ProjectileStateHandler
; ---------------------------------------------------------------------------
off_2CC26:      dc.w Enemy_ProjectileStateMachine-Enemy_ProjectileStateMachine
                                        ; DATA XREF: Enemy_ProjectileStateHandler+8   r
                dc.w Enemy_ProjectileStateMachine_CheckWallBounce-Enemy_ProjectileStateMachine
                dc.w Enemy_ProjectileStateMachine_TrackPlayer-Enemy_ProjectileStateMachine
                dc.w Physics_BossGravityAndCollision-Enemy_ProjectileStateMachine
                dc.w Physics_BossGravityAndCollision-Enemy_ProjectileStateMachine
                dc.w Boss_RecoilFallPattern-Enemy_ProjectileStateMachine
                dc.w Enemy_GroundWalkWithProjectile-Enemy_ProjectileStateMachine


; State machine for projectile movement and collision
Enemy_ProjectileStateMachine:                              ; DATA XREF: Enemy_ProjectileStateHandler+C   o  ; was: sub_2CC34
                                        ; ROM:off_2CC26   o ...
                move.w  #$1E,$24(a5)
                bsr.w Sprite_InitializeProjectileSprite
loc_2CC3E:                              ; CODE XREF: Enemy_ProjectileStateMachine+86   j
                                        ; Physics_BossGravityAndCollision+30   j ...
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                move.w  #$60,$48(a5) ; '`'
                clr.l   $18(a5)
; Checks for wall collision and sets bounce state
Enemy_ProjectileStateMachine_CheckWallBounce:                              ; DATA XREF: ROM:0002CC28   o  ; was: loc_2CC54
                jsr (Physics_EntityWallCheck).l
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w Enemy_ProjectileBounceState
                subq.w  #1,$48(a5)
                bpl.s   loc_2CC8C
                move.w  #$FFFF,$48(a5)
                bsr.w Enemy_FacePlayer
                cmpi.w  #$60,d0 ; '`'
                bpl.s   loc_2CC84
                bra.w Enemy_SetWaitState
; ---------------------------------------------------------------------------
loc_2CC84:                              ; CODE XREF: Enemy_ProjectileStateMachine+4A   j
                tst.w   $48(a5)
                bmi.w   loc_2CC90
loc_2CC8C:                              ; CODE XREF: Enemy_ProjectileStateMachine+3A   j
                bra.w Physics_ApplyHorizontalFriction
; ---------------------------------------------------------------------------
loc_2CC90:                              ; CODE XREF: Enemy_ProjectileStateMachine+54   j
                move.w  #4,4(a5)
                move.w  #8,$5C(a5)
; Tracks player position and adjusts projectile direction
Enemy_ProjectileStateMachine_TrackPlayer:                              ; DATA XREF: ROM:0002CC2A   o  ; was: loc_2CC9C
                jsr (Physics_EntityWallCheck).l
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w Enemy_ProjectileBounceState
                bsr.w Enemy_FacePlayer
                cmpi.w  #$50,d0 ; 'P'
                bmi.w   loc_2CC3E
                btst    #1,7(a5)
                bne.w   loc_2CCD6
                btst    #0,7(a5)
                bne.w   loc_2CCD6
                bra.w Physics_SetHorizontalVelocityByFlip
; ---------------------------------------------------------------------------
loc_2CCD6:                              ; CODE XREF: Enemy_ProjectileStateMachine+90   j
                                        ; Enemy_ProjectileStateMachine+9A   j
                move.w  #8,4(a5)
                move.w  #$24,$5C(a5) ; '$'
                move.l  #$FFFA4000,$1C(a5)
                bsr.w Physics_SetHorizontalVelocityByFlip
; End of function Enemy_ProjectileStateMachine
; Applies gravity with max falling speed $7C000, checks terrain and player collision
Physics_BossGravityAndCollision:                              ; CODE XREF: Enemy_ProjectileBounceState+16   j  ; was: sub_2CCEE
                                        ; DATA XREF: ROM:0002CC2C   o ...
                jsr (Physics_BossTerrainCheck).l
                cmpi.l  #$7C000,$1C(a5)
                bmi.s   loc_2CD08
                move.l  #$7C000,$1C(a5)
                bra.s   loc_2CD12
; ---------------------------------------------------------------------------
loc_2CD08:                              ; CODE XREF: Physics_BossGravityAndCollision+E   j
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_2CD22
loc_2CD12:                              ; CODE XREF: Physics_BossGravityAndCollision+18   j
                jsr (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_2CC3E
loc_2CD22:                              ; CODE XREF: Physics_BossGravityAndCollision+22   j
                jmp Physics_TerrainCheckWithVelocity
; End of function Physics_BossGravityAndCollision
; Sets state 6, halves horizontal velocity, branches to gravity/collision routine
Enemy_ProjectileBounceState:                              ; CODE XREF: Enemy_ProjectileStateMachine+32   j  ; was: sub_2CD28
                                        ; Enemy_ProjectileStateMachine+7A   j ...
                move.w  #6,4(a5)
                move.w  #$28,$5C(a5) ; '('
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                bra.w Physics_BossGravityAndCollision
; End of function Enemy_ProjectileBounceState
; Sets enemy to waiting state with specific timer and animation values
Enemy_SetWaitState:                              ; CODE XREF: Enemy_ProjectileStateMachine+4C   j  ; was: sub_2CD42
                move.w  #$C,4(a5)
                move.w  #$10,$5C(a5)
                move.w  #$36,$48(a5) ; '6'
; End of function Enemy_SetWaitState
; Ground-based enemy movement with projectile spawning at specific timing
Enemy_GroundWalkWithProjectile:                              ; DATA XREF: ROM:0002CC32   o  ; was: sub_2CD54
                jsr (Physics_EntityWallCheck).l
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.w Enemy_ProjectileBounceState
                subq.w  #1,$48(a5)
                bmi.w   loc_2CC3E
                cmpi.w  #$1E,$48(a5)
                bne.s   loc_2CD96
                moveq   #$18,d5
                moveq   #$FFFFFFFA,d6
                move.l  #$38000,d7
                btst    #3,$E(a5)
                beq.s   loc_2CD90
                neg.w   d5
                neg.l   d7
loc_2CD90:                              ; CODE XREF: Enemy_GroundWalkWithProjectile+36   j
                jsr (Projectile_SpawnFallingDebris).l
loc_2CD96:                              ; CODE XREF: Enemy_GroundWalkWithProjectile+24   j
                bsr.w Physics_ApplyHorizontalFriction
                cmpi.w  #$10,$48(a5)
                bmi.s   locret_2CDA6
                bsr.w Enemy_FacePlayer
locret_2CDA6:                           ; CODE XREF: Enemy_GroundWalkWithProjectile+4C   j
                rts
; End of function Enemy_GroundWalkWithProjectile
; Boss recoil attack launching upward then spawning projectile
Boss_JokerRecoilAttack:                              ; CODE XREF: Enemy_ProcessProjectile+10   p  ; was: sub_2CDA8
                move.w  #$A,4(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.w  #$24,$5C(a5) ; '$'
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s Boss_RecoilFallPattern
                neg.l   $18(a5)
; Boss recoil and fall pattern with gravity and velocity changes
Boss_RecoilFallPattern:                              ; CODE XREF: Boss_JokerRecoilAttack+34   j  ; was: loc_2CDE2
                                        ; DATA XREF: ROM:0002CC30   o
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2CDFE
                jsr (Projectile_ExplodeWithSound).l
                moveq   #7,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2CDFE:                              ; CODE XREF: Boss_JokerRecoilAttack+46   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2CE12
                bclr    #7,2(a5)
locret_2CE12:                           ; CODE XREF: Boss_JokerRecoilAttack+62   j
                rts
; End of function Boss_JokerRecoilAttack
; ---------------------------------------------------------------------------
word_2CE14:     dc.w $98, $60           ; DATA XREF: Enemy_AltProjectileStateMachine+16   o
word_2CE18:     dc.w 1, 4               ; DATA XREF: Enemy_AltProjectileStateMachine+3A   o


; Processing routine for alternative projectile type
Enemy_ProcessAltProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2CE1C
                tst.w   4(a5)
                beq.s Enemy_ProcessAltState
                clr.w   6(a5)
                tst.w   $24(a5)
                bmi.w Boss_JetsripperIdle
; Processes alternative enemy/projectile state handler
Enemy_ProcessAltState:                              ; CODE XREF: Enemy_ProcessAltProjectile+4   j  ; was: loc_2CE2E
                bsr.s Enemy_AltProjectileStateHandler
                bra.w Anim_UpdateProjectileAnimation
; End of function Enemy_ProcessAltProjectile
; Dispatches alternative projectile to state handler
Enemy_AltProjectileStateHandler:                              ; CODE XREF: Enemy_ProcessAltProjectile:loc_2CE2E   p  ; was: sub_2CE34
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CE48(pc,d0.w),a0
                adda.l  #Enemy_AltProjectileStateMachine,a0
                jmp     (a0)
; End of function Enemy_AltProjectileStateHandler
; ---------------------------------------------------------------------------
off_2CE48:      dc.w Enemy_AltProjectileStateMachine-Enemy_AltProjectileStateMachine
                                        ; DATA XREF: Enemy_AltProjectileStateHandler+8   r
                dc.w Enemy_AltProjectileStateMachine_WaitTimer-Enemy_AltProjectileStateMachine
                dc.w Enemy_HomingProjectileLoop-Enemy_AltProjectileStateMachine


; State machine for alternative projectile with difficulty scaling
Enemy_AltProjectileStateMachine:                              ; DATA XREF: Enemy_AltProjectileStateHandler+C   o  ; was: sub_2CE4E
                                        ; ROM:off_2CE48   o ...
                move.w  #$A,$24(a5)
                bsr.w Sprite_InitializeProjectileSprite
loc_2CE58:                              ; CODE XREF: Enemy_AltProjectileStateMachine+54   j
                move.w  #2,4(a5)
                move.w  #4,$5C(a5)
                lea     word_2CE14(pc),a0
                move.w  (word_FFFF0E).w,d0
                move.w  (a0,d0.w),$48(a5)
; Waits for timer countdown before transitioning
Enemy_AltProjectileStateMachine_WaitTimer:                              ; DATA XREF: ROM:0002CE4A   o  ; was: loc_2CE72
                subq.w  #1,$48(a5)
                bmi.s   loc_2CE7A
                rts
; ---------------------------------------------------------------------------
loc_2CE7A:                              ; CODE XREF: Enemy_AltProjectileStateMachine+28   j
                addq.w  #2,4(a5)
                move.w  #$80,$C(a5)
                clr.w   $48(a5)
                lea     word_2CE18(pc),a0
                move.w  (word_FFFF0E).w,d0
                move.w  (a0,d0.w),$4A(a5)
; Main loop for homing projectile with angle updates and spawning
Enemy_HomingProjectileLoop:                              ; DATA XREF: ROM:0002CE4C   o  ; was: loc_2CE96
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2CEC8
                subq.w  #1,$4A(a5)
                bmi.w   loc_2CE58
                bsr.w Enemy_CalculateDirectionalSprite
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2CEC8
                move.w  d3,d0
                move.w  d4,d1
                move.w  d2,d6
                move.w  (word_FF808A).w,d2
                addi.w  #$40,d2 ; '@'
                moveq   #$A,d7
                jmp Enemy_SetProjectileDifficulty
; ---------------------------------------------------------------------------
locret_2CEC8:                           ; CODE XREF: Enemy_AltProjectileStateMachine+4E   j
                                        ; Enemy_AltProjectileStateMachine+62   j
                rts
; End of function Enemy_AltProjectileStateMachine
; State handler for ship boss
Enemy_ShipBossStateHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2CECA
                tst.w   4(a5)
                beq.s   loc_2CED8
                tst.w   $24(a5)
                bmi.w Boss_FireProjectilePattern
loc_2CED8:                              ; CODE XREF: Enemy_ShipBossStateHandler+4   j
                bsr.s Enemy_ShipBossDispatcher
                bra.w Anim_UpdateAnimationState
; End of function Enemy_ShipBossStateHandler
; State dispatcher for ship boss
Enemy_ShipBossDispatcher:                              ; CODE XREF: Enemy_ShipBossStateHandler:loc_2CED8   p  ; was: sub_2CEDE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                movea.w off_2CEF2(pc,d0.w),a0
                adda.l  #Enemy_ShipBossInit,a0
                jmp     (a0)
; End of function Enemy_ShipBossDispatcher
; ---------------------------------------------------------------------------
off_2CEF2:      dc.w Enemy_ShipBossInit-Enemy_ShipBossInit
                                        ; DATA XREF: Enemy_ShipBossDispatcher+8   r
                dc.w Enemy_ShipBossInit_UpdateTimer-Enemy_ShipBossInit


; Initializes ship boss sprite
Enemy_ShipBossInit:                              ; DATA XREF: Enemy_ShipBossDispatcher+C   o  ; was: sub_2CEF6
                                        ; ROM:off_2CEF2   o ...
                moveq   #0,d0
                bsr.w Sprite_SetupBossSprite
                addq.w  #2,4(a5)
                clr.w   $48(a5)
; Updates timer for boss ship initialization phase
Enemy_ShipBossInit_UpdateTimer:                              ; DATA XREF: ROM:0002CEF4   o  ; was: loc_2CF04
                subq.w  #1,$48(a5)
                bpl.s   locret_2CF16
                move.w  #$38,$48(a5) ; '8'
                move.w  #$10,$5C(a5)
locret_2CF16:                           ; CODE XREF: Enemy_ShipBossInit+12   j
                rts
; End of function Enemy_ShipBossInit
; Updates enemy facing direction to track player
Enemy_FacePlayer:                              ; CODE XREF: Enemy_MainStateMachine+78   p  ; was: sub_2CF18
                                        ; Enemy_MainStateMachine+1C0   j ...
                jsr (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_2CF2A
                bset    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF2A:                              ; CODE XREF: Enemy_FacePlayer+8   j
                bclr    #3,$E(a5)
                rts
; End of function Enemy_FacePlayer
; Negates horizontal velocity if entity is facing left
Physics_NegateVelocityIfFacingLeft:                              ; CODE XREF: Enemy_MainStateMachine+122   p  ; was: sub_2CF32
                btst    #3,$E(a5)
                bne.s   locret_2CF3E
                neg.l   $18(a5)
locret_2CF3E:                           ; CODE XREF: Physics_NegateVelocityIfFacingLeft+6   j
                rts
; End of function Physics_NegateVelocityIfFacingLeft
; Applies gravity acceleration to vertical velocity with terminal velocity
Physics_AccelerateGravity:                              ; CODE XREF: Enemy_MainStateMachine+138   p  ; was: sub_2CF40
                tst.l   $1C(a5)
                bmi.s   loc_2CF5A
                cmpi.l  #$7C000,$1C(a5)
                bmi.s   loc_2CF5A
                move.l  #$7C000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF5A:                              ; CODE XREF: Physics_AccelerateGravity+4   j
                                        ; Physics_AccelerateGravity+E   j
                addi.l  #$6000,$1C(a5)
                rts
; End of function Physics_AccelerateGravity
; Updates player physics and action state
Player_UpdatePhysics:                              ; CODE XREF: Enemy_MainStateMachine+34   p  ; was: sub_2CF64
                                        ; sub_2C71E:loc_2C7D8   p ...
                jsr (Physics_EntityWallCheck).l
                jmp Player_ActionDispatcher
; End of function Player_UpdatePhysics
; Toggles sprite visibility flag
Enemy_ToggleSpriteVisibility:                              ; CODE XREF: Projectile_BouncingDebrisMain   p  ; was: sub_2CF70
                                        ; sub_2DEFE   p
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                beq.s   loc_2CF82
                andi.w  #$7FFF,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2CF82:                              ; CODE XREF: Enemy_ToggleSpriteVisibility+8   j
                ori.w   #$8000,2(a5)
                rts
; End of function Enemy_ToggleSpriteVisibility
; Sets high bit in VDP control register
Enemy_SetVDPFlagHigh:                              ; CODE XREF: Enemy_Phase2Movement+2   p  ; was: sub_2CF8A
                move.w  #$EF00,2(a5)
                move.w  (word_FF8276).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                btst    #7,$5F(a5)
                beq.s   loc_2CFAA
                bclr    #4,$E(a5)
loc_2CFAA:                              ; CODE XREF: Enemy_SetVDPFlagHigh+18   j
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.b  #5,$23(a5)
                move.l  #$E020E818,$2C(a5)
                move.l  #$E020E818,$28(a5)
                lea     word_2CFEC(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_SetVDPFlagHigh
; ---------------------------------------------------------------------------
word_2CFEC:     dc.w $1864, $1100       ; DATA XREF: Enemy_SetVDPFlagHigh+42   o


; Sets animation pointer from table based on $5C value, clears animation frame counter
Enemy_SetAnimationFromIndex:                              ; CODE XREF: Enemy_Phase2StateHandler+22   j  ; was: sub_2CFF0
                move.w  $5C(a5),d0
                beq.s   locret_2D002
                subq.w  #4,d0
                move.l  off_2D004(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2D002:                           ; CODE XREF: Enemy_SetAnimationFromIndex+4   j
                rts
; End of function Enemy_SetAnimationFromIndex
; ---------------------------------------------------------------------------
off_2D004:      dc.l off_EADEA          ; DATA XREF: Enemy_SetAnimationFromIndex+8   r
                dc.l off_EADCA
                dc.l off_EADDA
                dc.l off_EAE06
                dc.l off_EAE3A
                dc.l off_EAE4A
                dc.l off_EAE5A


; Enemy phase 2 state handler checking conditions
Enemy_Phase2StateHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D020
                tst.w   4(a5)
                beq.s   loc_2D040
                tst.w   $24(a5)
                bmi.w Enemy_ResetToIdleState290
                tst.w   (word_FF808C).w
                bpl.w Enemy_ResetToIdleState290
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2D040:                              ; CODE XREF: Enemy_Phase2StateHandler+4   j
                bsr.s Enemy_InitPhase2Attack
                bra.w Enemy_SetAnimationFromIndex
; End of function Enemy_Phase2StateHandler
; Initializes phase 2 attack state with parameters
Enemy_InitPhase2Attack:                              ; CODE XREF: Enemy_Phase2StateHandler:loc_2D040   p  ; was: sub_2D046
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D056(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_InitPhase2Attack
; ---------------------------------------------------------------------------
off_2D056:      dc.w Enemy_Phase2Movement-*        ; DATA XREF: Enemy_InitPhase2Attack+8   o
                dc.w Enemy_Phase2Movement_WaitAndMove-*
                dc.w Enemy_UpdateTrajectory-*
                dc.w Enemy_TimerWaitAndSetParams1-*
                dc.w Enemy_TimerWaitAndSetParams2-*
                dc.w Enemy_TimerWaitAndSetParams3-*
                dc.w Enemy_TimerWaitAndSetParams4-*


; Phase 2 movement with velocity and gravity
Enemy_Phase2Movement:                              ; DATA XREF: ROM:off_2D056   o  ; was: sub_2D064
                moveq   #0,d0
                bsr.w Enemy_SetVDPFlagHigh
                move.w  #4,$5C(a5)
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
; Wait for timer countdown and check for movement trigger
Enemy_Phase2Movement_WaitAndMove:                              ; DATA XREF: ROM:0002D058   o  ; was: loc_2D07A
                subq.w  #1,$48(a5)
                beq.s   loc_2D09E
                btst    #5,(word_FFF708).w
                beq.s   locret_2D09C
                addq.w  #2,4(a5)
                btst    #4,$E(a5)
                bne.s   locret_2D09C
                move.l  #$FFFA0000,$1C(a5)
locret_2D09C:                           ; CODE XREF: Enemy_Phase2Movement+22   j
                                        ; Enemy_Phase2Movement+2E   j
                rts
; ---------------------------------------------------------------------------
loc_2D09E:                              ; CODE XREF: Enemy_Phase2Movement+1A   j
                move.w  #$20,$48(a5) ; ' '
                move.w  #6,4(a5)
                move.w  #$10,$5C(a5)
                rts
; End of function Enemy_Phase2Movement
; Updates enemy projectile trajectory
Enemy_UpdateTrajectory:                              ; DATA XREF: ROM:0002D05A   o  ; was: sub_2D0B2
                cmpi.l  #$80000,$1C(a5)
                bge.s   loc_2D0C4
                addi.l  #$4000,$1C(a5)
loc_2D0C4:                              ; CODE XREF: Enemy_UpdateTrajectory+8   j
                moveq   #0,d0
                tst.l   $1C(a5)
                bmi.s   loc_2D0D2
                move.w  #$20,d1 ; ' '
                bra.s   loc_2D0D6
; ---------------------------------------------------------------------------
loc_2D0D2:                              ; CODE XREF: Enemy_UpdateTrajectory+18   j
                move.w  #$FFE4,d1
loc_2D0D6:                              ; CODE XREF: Enemy_UpdateTrajectory+1E   j
                jsr (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_2D11E
                move.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                tst.l   $1C(a5)
                bmi.s   loc_2D10C
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1 ; ' '
                jsr (Physics_AlignToTerrain).l
                rts
; ---------------------------------------------------------------------------
loc_2D10C:                              ; CODE XREF: Enemy_UpdateTrajectory+44   j
                bset    #4,$E(a5)
                moveq   #0,d0
                move.w  #$FFE4,d1
                jsr (Physics_AlignToTerrainTop).l
locret_2D11E:                           ; CODE XREF: Enemy_UpdateTrajectory+2C   j
                rts
; End of function Enemy_UpdateTrajectory
; Decrements timer, when zero sets $5C=$14, resets timer=$20, advances state
Enemy_TimerWaitAndSetParams1:                              ; DATA XREF: ROM:0002D05C   o  ; was: sub_2D120
                subq.w  #1,$48(a5)
                bne.s   locret_2D136
                move.w  #$14,$5C(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_2D136:                           ; CODE XREF: Enemy_TimerWaitAndSetParams1+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams1
; Decrements timer, when zero sets $5C=$1C, velocity=$FFFF, timer=$20, advances state
Enemy_TimerWaitAndSetParams2:                              ; DATA XREF: ROM:0002D05E   o  ; was: sub_2D138
                subq.w  #1,$48(a5)
                bne.s   locret_2D154
                move.w  #$1C,$5C(a5)
                move.w  #$FFFF,$18(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_2D154:                           ; CODE XREF: Enemy_TimerWaitAndSetParams2+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams2
; Decrements timer, when zero clears velocity, sets $5C=$18, timer=$20, advances state
Enemy_TimerWaitAndSetParams3:                              ; DATA XREF: ROM:0002D060   o  ; was: sub_2D156
                subq.w  #1,$48(a5)
                bne.s   locret_2D170
                clr.w   $18(a5)
                move.w  #$18,$5C(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
locret_2D170:                           ; CODE XREF: Enemy_TimerWaitAndSetParams3+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams3
; Decrements timer, when zero sets timer=$100, $5C=4, state=2
Enemy_TimerWaitAndSetParams4:                              ; DATA XREF: ROM:0002D062   o  ; was: sub_2D172
                subq.w  #1,$48(a5)
                bne.s   locret_2D18A
                move.w  #$100,$48(a5)
                move.w  #4,$5C(a5)
                move.w  #2,4(a5)
locret_2D18A:                           ; CODE XREF: Enemy_TimerWaitAndSetParams4+4   j
                rts
; End of function Enemy_TimerWaitAndSetParams4
; Resets state to 0, sets ID $290, timer $40, clears velocity and flags
Enemy_ResetToIdleState290:                              ; CODE XREF: Enemy_Phase2StateHandler+A   j  ; was: sub_2D18C
                                        ; Enemy_Phase2StateHandler+12   j
                clr.w   4(a5)
                move.w  #$290,(a5)
                move.w  #$40,$48(a5) ; '@'
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                rts
; End of function Enemy_ResetToIdleState290
; Handles bouncing debris projectile with gravity, collision, spawns particles, plays sound
Projectile_BouncingDebrisMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D1AC
                bsr.w Enemy_ToggleSpriteVisibility
                tst.l   $1C(a5)
                beq.s   loc_2D1EA
                cmpi.l  #$80000,$1C(a5)
                bge.s   loc_2D1C8
                addi.l  #$4000,$1C(a5)
loc_2D1C8:                              ; CODE XREF: Projectile_BouncingDebrisMain+12   j
                moveq   #0,d0
                move.w  #$20,d1 ; ' '
                jsr (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   loc_2D1EA
                bclr    #4,$E(a5)
                moveq   #0,d0
                move.w  #$20,d1 ; ' '
                jsr (Physics_AlignToTerrain).l
loc_2D1EA:                              ; CODE XREF: Projectile_BouncingDebrisMain+8   j
                                        ; Projectile_BouncingDebrisMain+2A   j
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2D254
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_2D206
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
loc_2D206:                              ; CODE XREF: Projectile_BouncingDebrisMain+4E   j
                bsr.s Gfx_SetRandomAnimationPointer
                jsr (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                move.w  $10(a5),$10(a0)
                add.w   d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                move.w  $14(a5),$14(a0)
                add.w   d0,$14(a0)
                move.w  #$FFFE,$1C(a0)
                subq.w  #1,$48(a5)
                bne.s   locret_2D254
                jsr (Projectile_ExplodeOnImpact).l
                moveq   #3,d0
                jmp Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
locret_2D254:                           ; CODE XREF: Projectile_BouncingDebrisMain+44   j
                                        ; Projectile_BouncingDebrisMain+98   j
                rts
; End of function Projectile_BouncingDebrisMain
; Copies a5 register to a0, used for pointer manipulation
Sys_CopyA5ToA0:
                movea.w a5,a0  ; was: sub_2D256
; End of function Sys_CopyA5ToA0
; Sets random animation pointer from 4-entry table based on random number bits 0-1
Gfx_SetRandomAnimationPointer:                              ; CODE XREF: Projectile_BouncingDebrisMain:loc_2D206   p  ; was: sub_2D258
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_2D26C(pc,d0.w),8(a0)
                rts
; End of function Gfx_SetRandomAnimationPointer
; ---------------------------------------------------------------------------
off_2D26C:      dc.l off_E953C          ; DATA XREF: Gfx_SetRandomAnimationPointer+C   r
                dc.l off_E9560
                dc.l off_E9584
                dc.l off_E9560


; Initializes sprite VDP flags and hitbox from table
Enemy_InitSpriteParams:                              ; CODE XREF: Enemy_ApproachPlayerState+2   p  ; was: sub_2D27C
                                        ; Enemy_FlyInit+2   p ...
                move.w  #$ED00,2(a5)
                move.w  (word_FF827A).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FF01FF01,$2C(a5)
                move.l  #$F808F808,$28(a5)
                lea     word_2D2CA(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_InitSpriteParams
; ---------------------------------------------------------------------------
word_2D2CA:     dc.w $1802, $1100, $1802, $1100
                                        ; DATA XREF: Enemy_InitSpriteParams+2E   o


; Updates enemy sprite pattern based on state timer value
Enemy_UpdateSpritePattern:                              ; CODE XREF: Enemy_CircleMainHandler+2C   j  ; was: sub_2D2D2
                                        ; Enemy_FlyMain+2C   j ...
                move.w  $5C(a5),d0
                beq.s   locret_2D2EA
                move.w  #$ED00,2(a5)
                subq.w  #4,d0
                move.l  off_2D2EC(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2D2EA:                           ; CODE XREF: Enemy_UpdateSpritePattern+4   j
                rts
; End of function Enemy_UpdateSpritePattern
; ---------------------------------------------------------------------------
off_2D2EC:      dc.l off_EB320          ; DATA XREF: Enemy_UpdateSpritePattern+E   r


; Updates sprite graphics based on rotation angle
Enemy_UpdateRotationSprite:                              ; CODE XREF: Enemy_CircleAttackState+E   p  ; was: sub_2D2F0
                                        ; Enemy_DescendAttackState+C   p ...
                move.w  $4C(a5),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                move.l  off_2D326(pc,d0.w),8(a5)
                clr.w   $C(a5)
                lsr.w   #1,d0
                move.w  (word_FF827A).w,d1
                andi.w  #$F7FF,d1
                or.w    (word_FF808A).w,d1
                or.w    word_2D366(pc,d0.w),d1
                move.w  d1,$E(a5)
                move.w  #$CD00,2(a5)
                rts
; End of function Enemy_UpdateRotationSprite
; ---------------------------------------------------------------------------
off_2D326:      dc.l word_EB31A         ; DATA XREF: Enemy_UpdateRotationSprite+E   r
                dc.l word_EB314
                dc.l word_EB30E
                dc.l word_EB308
                dc.l word_EB302
                dc.l word_EB308
                dc.l word_EB30E
                dc.l word_EB314
                dc.l word_EB31A
                dc.l word_EB314
                dc.l word_EB30E
                dc.l word_EB308
                dc.l word_EB302
                dc.l word_EB308
                dc.l word_EB30E
                dc.l word_EB314
word_2D366:     dc.w $800, $1800, $1800, $1800, $1800, $1000, $1000, $1000
                                        ; DATA XREF: Enemy_UpdateRotationSprite+26   r
                dc.w 0, 0, 0, 0, $800, $800, $800, $800


; Circular motion with periodic homing missile spawn
Enemy_CircularHomingMotion:                              ; CODE XREF: Enemy_CircleAttackState+1A   p  ; was: sub_2D386
                                        ; Enemy_DescendAttackState+18   p ...
                move.w  $4C(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                muls.w  d2,d0
                muls.w  d3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                move.w  (word_FFA000).w,d0
                add.w   a5,d0
                andi.w  #$7F,d0
                bne.s   locret_2D3E6
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$20,d0 ; ' '
                bcs.s   locret_2D3E6
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2D3E6
                move.w  a0,$56(a5)
                jsr (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                clr.w   d0
                clr.w   d1
                move.w  #$8004,d2
                movea.w $56(a5),a0
                jsr (Enemy_InitHomingProjectile).l
locret_2D3E6:                           ; CODE XREF: Enemy_CircularHomingMotion+2C   j
                                        ; Enemy_CircularHomingMotion+38   j ...
                rts
; End of function Enemy_CircularHomingMotion
; Main update handler for circling enemy type
Enemy_CircleMainHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D3E8
                tst.w   4(a5)
                beq.s Enemy_ExecuteCirclePattern
                tst.w   $24(a5)
                bmi.w Enemy_ResetToIdleState
                bclr    #7,$22(a5)
                bne.w Enemy_ResetToIdleState
                tst.w   (word_FF808C).w
                bpl.w Enemy_ResetToIdleState
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Executes circular movement pattern and updates sprite
Enemy_ExecuteCirclePattern:                              ; CODE XREF: Enemy_CircleMainHandler+4   j  ; was: loc_2D412
                bsr.s Enemy_CircleStateDispatcher
                bra.w Enemy_UpdateSpritePattern
; End of function Enemy_CircleMainHandler
; Dispatches to circle enemy state handlers
Enemy_CircleStateDispatcher:                              ; CODE XREF: Enemy_CircleMainHandler:loc_2D412   p  ; was: sub_2D418
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D428(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CircleStateDispatcher
; ---------------------------------------------------------------------------
off_2D428:      dc.w Enemy_ApproachPlayerState-*        ; DATA XREF: Enemy_CircleStateDispatcher+8   o
                dc.w Enemy_ApproachPlayerState_CheckDistance-*
                dc.w Enemy_CircleAttackState-*
                dc.w Enemy_DescendAttackState-*
                dc.w nullsub_62-*


; Approach player until within distance threshold
Enemy_ApproachPlayerState:                              ; DATA XREF: ROM:off_2D428   o  ; was: sub_2D432
                moveq   #0,d0
                bsr.w Enemy_InitSpriteParams
                move.w  #4,$5C(a5)
                bsr.w Enemy_CalculateTrajectoryToPlayer
                addq.w  #2,4(a5)
; Calculate distance to player and determine next action
Enemy_ApproachPlayerState_CheckDistance:                              ; DATA XREF: ROM:0002D42A   o  ; was: loc_2D446
                jsr (Physics_CalculateDistanceTo).l
                cmpi.w  #$60,d0 ; '`'
                bcs.s   loc_2D456
                bra.w Enemy_Stage18ClearAll
; ---------------------------------------------------------------------------
loc_2D456:                              ; CODE XREF: Enemy_ApproachPlayerState+1E   j
                move.w  #$180,$4C(a5)
                move.w  #$10,$4A(a5)
                move.w  #$10,$48(a5)
                move.w  #$100,$50(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_ApproachPlayerState
; Calculates velocity vector from random angle toward player
Enemy_CalculateTrajectoryToPlayer:                              ; CODE XREF: Enemy_ApproachPlayerState+C   p  ; was: sub_2D474
                move.w  $10(a5),$52(a5)
                move.w  (dword_FFA900).w,d0
                add.w   d0,$52(a5)
                move.w  $14(a5),$54(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d0.w),d1
                move.w  (a1,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Enemy_CalculateTrajectoryToPlayer
; Clears all enemies before boss
Enemy_Stage18ClearAll:                              ; CODE XREF: Enemy_ApproachPlayerState+20   j  ; was: sub_2D4B2
                move.w  $52(a5),d0
                move.b  (dword_FFFF08).w,d7
                andi.w  #$3F,d7 ; '?'
                subi.w  #$20,d7 ; ' '
                add.w   d7,d0
                move.w  $10(a5),d1
                add.w   (dword_FFA900).w,d1
                sub.w   d1,d0
                beq.s   loc_2D50A
                tst.w   d0
                bpl.s   loc_2D4F0
                subi.l  #$4000,$18(a5)
                cmpi.l  #$FFFE0000,$18(a5)
                bge.s   loc_2D50A
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2D50A
; ---------------------------------------------------------------------------
loc_2D4F0:                              ; CODE XREF: Enemy_Stage18ClearAll+20   j
                addi.l  #$4000,$18(a5)
                cmpi.l  #$20000,$18(a5)
                ble.s   loc_2D50A
                move.l  #$20000,$18(a5)
loc_2D50A:                              ; CODE XREF: Enemy_Stage18ClearAll+1C   j
                                        ; Enemy_Stage18ClearAll+32   j ...
                move.w  $54(a5),d0
                move.b  (dword_FFFF08+1).w,d7
                andi.w  #$3F,d7 ; '?'
                subi.w  #$20,d7 ; ' '
                add.w   d7,d0
                sub.w   $14(a5),d0
                beq.s   locret_2D55C
                tst.w   d0
                bpl.s Physics_ClampVerticalVelocityUp
                subi.l  #$4000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bge.s   locret_2D55C
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Clamps vertical velocity to maximum upward speed
Physics_ClampVerticalVelocityUp:                              ; CODE XREF: Enemy_Stage18ClearAll+72   j  ; was: loc_2D542
                addi.l  #$4000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                ble.s   locret_2D55C
                move.l  #$20000,$1C(a5)
locret_2D55C:                           ; CODE XREF: Enemy_Stage18ClearAll+6E   j
                                        ; Enemy_Stage18ClearAll+84   j ...
                rts
; End of function Enemy_Stage18ClearAll
; Circles player with adaptive rotation speed
Enemy_CircleAttackState:                              ; DATA XREF: ROM:0002D42C   o  ; was: sub_2D55E
                move.w  $4A(a5),d0
                add.w   d0,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w Enemy_UpdateRotationSprite
                move.w  #$10,d2
                move.w  #$10,d3
                bsr.w Enemy_CircularHomingMotion
                subq.w  #1,$48(a5)
                bpl.s   loc_2D5CE
                addq.w  #1,$4E(a5)
                move.w  $4E(a5),d0
                andi.w  #3,d0
                bne.s   loc_2D59E
                move.w  #$10,$4A(a5)
                move.w  #$10,$48(a5)
                bra.s   loc_2D5CE
; ---------------------------------------------------------------------------
loc_2D59E:                              ; CODE XREF: Enemy_CircleAttackState+30   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$48(a5)
                jsr (Math_CalculateAngleToPlayer).l
                move.w  $4C(a5),d0
                sub.w   d2,d0
                andi.w  #$1FF,d0
                cmpi.w  #$100,d0
                bcs.s   loc_2D5C8
                move.w  #8,$4A(a5)
                bra.s   loc_2D5CE
; ---------------------------------------------------------------------------
loc_2D5C8:                              ; CODE XREF: Enemy_CircleAttackState+60   j
                move.w  #$FFF8,$4A(a5)
loc_2D5CE:                              ; CODE XREF: Enemy_CircleAttackState+22   j
                                        ; Enemy_CircleAttackState+3E   j ...
                subq.w  #1,$50(a5)
                beq.s   loc_2D5DE
                cmpi.w  #$140,$14(a5)
                bcc.s   loc_2D5DE
                rts
; ---------------------------------------------------------------------------
loc_2D5DE:                              ; CODE XREF: Enemy_CircleAttackState+74   j
                                        ; Enemy_CircleAttackState+7C   j
                move.w  #$CF00,2(a5)
                andi.w  #$1F0,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_CircleAttackState
; Descending attack state with rotation sprite update
Enemy_DescendAttackState:                              ; DATA XREF: ROM:0002D42E   o  ; was: sub_2D5F0
                addi.w  #$10,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w Enemy_UpdateRotationSprite
                move.w  #$10,d2
                move.w  #$10,d3
                bsr.w Enemy_CircularHomingMotion
                cmpi.w  #$1C0,$4C(a5)
                bne.s   locret_2D618
                addq.w  #2,4(a5)
locret_2D618:                           ; CODE XREF: Enemy_DescendAttackState+22   j
                rts
; End of function Enemy_DescendAttackState
nullsub_62:                             ; DATA XREF: ROM:0002D430   o
                rts
; End of function nullsub_62


; Resets enemy to idle state clearing velocities
Enemy_ResetToIdleState:                              ; CODE XREF: Enemy_CircleMainHandler+A   j  ; was: sub_2D61C
                                        ; Enemy_CircleMainHandler+14   j ...
                clr.w   4(a5)
                move.w  #$2A4,(a5)
                move.w  #$40,$48(a5) ; '@'
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Enemy_ResetToIdleState
; Spawns particle effect only on hard difficulty
Enemy_SpawnParticleHardMode:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D640
                tst.w   (word_FFFF0E).w
                beq.s Enemy_SpawnQuadProjectilesHard
                jsr (Projectile_UpdateTrajectory).l
                bne.s Enemy_SpawnQuadProjectilesHard
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$8004,d2
                jsr (Enemy_InitDirectionalProjectile).l
; Spawns quad projectiles on hard difficulty mode
Enemy_SpawnQuadProjectilesHard:                              ; CODE XREF: Enemy_SpawnParticleHardMode+4   j  ; was: loc_2D664
                                        ; Enemy_SpawnParticleHardMode+C   j
                jmp Enemy_SpawnQuadProjectiles
; End of function Enemy_SpawnParticleHardMode
nullsub_63:
                rts
; End of function nullsub_63


; Main fly enemy handler with spawn conditions
Enemy_FlyMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D66C
                tst.w   4(a5)
                beq.s   loc_2D696
                tst.w   $24(a5)
                bmi.w Enemy_ResetToIdleState
                bclr    #7,$22(a5)
                bne.w Enemy_ResetToIdleState
                tst.w   (word_FF808C).w
                bpl.w Enemy_ResetToIdleState
                jsr     (RandomNumber).l
                clr.w   6(a5)
loc_2D696:                              ; CODE XREF: Enemy_FlyMain+4   j
                bsr.s Enemy_FlyDispatcher
                bra.w Enemy_UpdateSpritePattern
; End of function Enemy_FlyMain
; Fly enemy state dispatcher using jump table
Enemy_FlyDispatcher:                              ; CODE XREF: Enemy_FlyMain:loc_2D696   p  ; was: sub_2D69C
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D6AC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyDispatcher
; ---------------------------------------------------------------------------
off_2D6AC:      dc.w Enemy_FlyInit-*        ; DATA XREF: Enemy_FlyDispatcher+8   o
                dc.w Enemy_FlyInit_RotateToTarget-*
                dc.w nullsub_64-*


; Initializes fly enemy with position and animation
Enemy_FlyInit:                              ; DATA XREF: ROM:off_2D6AC   o  ; was: sub_2D6B2
                moveq   #0,d0
                bsr.w Enemy_InitSpriteParams
                move.w  #4,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$50(a5)
                move.w  #$180,$4C(a5)
                move.w  #$80,$4E(a5)
                tst.w   $58(a5)
                bne.s   loc_2D6E2
                move.w  #8,$4A(a5)
                bra.s Enemy_FlyInit_RotateToTarget
; ---------------------------------------------------------------------------
loc_2D6E2:                              ; CODE XREF: Enemy_FlyInit+26   j
                move.w  #$FFF8,$4A(a5)
; Updates rotation angle and moves toward target angle using circular homing
Enemy_FlyInit_RotateToTarget:                              ; CODE XREF: Enemy_FlyInit+2E   j  ; was: loc_2D6E8
                                        ; DATA XREF: ROM:0002D6AE   o
                move.w  $4A(a5),d0
                add.w   d0,$4C(a5)
                andi.w  #$1FF,$4C(a5)
                bsr.w Enemy_UpdateRotationSprite
                move.w  $50(a5),d2
                move.w  $50(a5),d3
                bsr.w Enemy_CircularHomingMotion
                move.w  $4E(a5),d0
                cmp.w   $4C(a5),d0
                bne.s   locret_2D756
                move.w  $48(a5),d0
                tst.w   $58(a5)
                bne.s   loc_2D72E
                move.w  word_2D758(pc,d0.w),$4A(a5)
                move.w  word_2D75E(pc,d0.w),$4E(a5)
                move.w  word_2D764(pc,d0.w),$50(a5)
                bra.s   loc_2D740
; ---------------------------------------------------------------------------
loc_2D72E:                              ; CODE XREF: Enemy_FlyInit+66   j
                move.w  word_2D76A(pc,d0.w),$4A(a5)
                move.w  word_2D770(pc,d0.w),$4E(a5)
                move.w  word_2D776(pc,d0.w),$50(a5)
loc_2D740:                              ; CODE XREF: Enemy_FlyInit+7A   j
                addq.w  #2,$48(a5)
                cmpi.w  #8,$48(a5)
                bne.s   locret_2D756
                move.w  #$CF00,2(a5)
                addq.w  #2,4(a5)
locret_2D756:                           ; CODE XREF: Enemy_FlyInit+5C   j
                                        ; Enemy_FlyInit+98   j
                rts
; End of function Enemy_FlyInit
; ---------------------------------------------------------------------------
word_2D758:     dc.w 2, 4, 2            ; DATA XREF: Enemy_FlyInit+68   r
word_2D75E:     dc.w $100, $100, $160   ; DATA XREF: Enemy_FlyInit+6E   r
word_2D764:     dc.w $10, 8, $10        ; DATA XREF: Enemy_FlyInit+74   r
word_2D76A:     dc.w $FFFE, $FFFC, $FFFE
                                        ; DATA XREF: Enemy_FlyInit:loc_2D72E   r
word_2D770:     dc.w 0, 0, $1A0         ; DATA XREF: Enemy_FlyInit+82   r
word_2D776:     dc.w $10, 8, $10        ; DATA XREF: Enemy_FlyInit+88   r


nullsub_64:                             ; DATA XREF: ROM:0002D6B0   o
                rts
; End of function nullsub_64


; Stage 17 walker enemy main handler
Enemy_Stage17WalkerMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D77E
                tst.w   4(a5)
                beq.s Enemy_Stage17WalkerUpdate
                tst.w   $24(a5)
                bmi.w Enemy_ClearAndSpawnQuadProjectiles
                bclr    #7,$22(a5)
                bne.w Enemy_ClearAndSpawnQuadProjectiles
                tst.w   (word_FF808C).w
                bpl.w Enemy_ClearAndSpawnQuadProjectiles
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Updates Stage 17 walker enemy state and sprite
Enemy_Stage17WalkerUpdate:                              ; CODE XREF: Enemy_Stage17WalkerMain+4   j  ; was: loc_2D7A8
                bsr.s Enemy_Stage17WalkerInit
                bra.w Enemy_UpdateSpritePattern
; End of function Enemy_Stage17WalkerMain
; Initializes walker enemy
Enemy_Stage17WalkerInit:                              ; CODE XREF: Enemy_Stage17WalkerMain:loc_2D7A8   p  ; was: sub_2D7AE
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2D7BE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage17WalkerInit
; ---------------------------------------------------------------------------
off_2D7BE:      dc.w Enemy_Stage17WalkerWalk-*        ; DATA XREF: Enemy_Stage17WalkerInit+8   o
                dc.w Enemy_Stage17WalkerTurn-*
                dc.w Enemy_Stage17WalkerAttack-*
                dc.w Enemy_Stage17WalkerCheckEdge-*
                dc.w Enemy_Stage17WalkerDeath-*


; Walker walking state
Enemy_Stage17WalkerWalk:                              ; DATA XREF: ROM:off_2D7BE   o  ; was: sub_2D7C8
                moveq   #0,d0
                bsr.w Enemy_InitSpriteParams
                move.b  #2,$25(a5)
                move.w  #$80,$4C(a5)
                addq.w  #2,4(a5)
                bsr.w Enemy_UpdateRotationSprite
                move.w  #2,$1C(a5)
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_2D7FA
                move.w  #$FFF8,$4E(a5)
                rts
; ---------------------------------------------------------------------------
loc_2D7FA:                              ; CODE XREF: Enemy_Stage17WalkerWalk+28   j
                move.w  #8,$4E(a5)
                rts
; End of function Enemy_Stage17WalkerWalk
; Walker turning state
Enemy_Stage17WalkerTurn:                              ; DATA XREF: ROM:0002D7C0   o  ; was: sub_2D802
                move.w  $14(a5),d0
                sub.w   (word_FF824A).w,d0
                tst.w   d0
                bmi.s   locret_2D832
                cmpi.w  #$20,d0 ; ' '
                bcs.s   locret_2D832
                clr.w   $50(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage17WalkerTurn
; Waits for linked object (at $4A) to have state=0 and vertical velocity=0 before advancing
Enemy_WaitForLinkedObject:
                movea.w $4A(a5),a1  ; was: sub_2D81E
                tst.w   4(a1)
                beq.s   locret_2D832
                tst.w   $1C(a1)
                bne.s   locret_2D832
                addq.w  #2,4(a5)
locret_2D832:                           ; CODE XREF: Enemy_Stage17WalkerTurn+A   j
                                        ; Enemy_Stage17WalkerTurn+10   j ...
                rts
; End of function Enemy_WaitForLinkedObject
; Walker attack state
Enemy_Stage17WalkerAttack:                              ; DATA XREF: ROM:0002D7C2   o  ; was: sub_2D834
                clr.w   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$48(a5)
                rts
; End of function Enemy_Stage17WalkerAttack
; Checks if at edge
Enemy_Stage17WalkerCheckEdge:                              ; DATA XREF: ROM:0002D7C4   o  ; was: sub_2D844
                move.w  $4E(a5),d0
                add.w   d0,$4C(a5)
                bsr.w Enemy_UpdateRotationSprite
                subq.w  #1,$48(a5)
                bne.s   locret_2D872
                move.w  #$1C0,$48(a5)
                addq.w  #2,4(a5)
                move.w  #3,$18(a5)
                btst    #7,$4E(a5)
                bne.s   locret_2D872
                neg.w   $18(a5)
locret_2D872:                           ; CODE XREF: Enemy_Stage17WalkerCheckEdge+10   j
                                        ; Enemy_Stage17WalkerCheckEdge+28   j
                rts
; End of function Enemy_Stage17WalkerCheckEdge
; Walker death state
Enemy_Stage17WalkerDeath:                              ; DATA XREF: ROM:0002D7C6   o  ; was: sub_2D874
                bsr.w Enemy_Stage17WalkerUpdateSprite
                subq.w  #1,$48(a5)
                bne.s   locret_2D884
                bset    #4,2(a5)
locret_2D884:                           ; CODE XREF: Enemy_Stage17WalkerDeath+8   j
                rts
; End of function Enemy_Stage17WalkerDeath
; Updates walker sprite
Enemy_Stage17WalkerUpdateSprite:                              ; CODE XREF: Enemy_Stage17WalkerDeath   p  ; was: sub_2D886
                move.w  (word_FF824A).w,d0
                sub.w   $14(a5),d0
                beq.s   locret_2D8CA
                tst.w   d0
                bpl.s Physics_ClampVerticalVelocityDown
                subi.l  #$2000,$1C(a5)
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_2D8CA
                move.l  #$FFFE0000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Clamps vertical velocity to maximum downward speed
Physics_ClampVerticalVelocityDown:                              ; CODE XREF: Enemy_Stage17WalkerUpdateSprite+C   j  ; was: loc_2D8B0
                addi.l  #$2000,$1C(a5)
                cmpi.l  #$20000,$1C(a5)
                blt.s   locret_2D8CA
                move.l  #$20000,$1C(a5)
locret_2D8CA:                           ; CODE XREF: Enemy_Stage17WalkerUpdateSprite+8   j
                                        ; Enemy_Stage17WalkerUpdateSprite+1E   j ...
                rts
; End of function Enemy_Stage17WalkerUpdateSprite
; Clears state and spawns quad projectiles
Enemy_ClearAndSpawnQuadProjectiles:                              ; CODE XREF: Enemy_Stage17WalkerMain+A   j  ; was: sub_2D8CC
                                        ; Enemy_Stage17WalkerMain+14   j ...
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp Enemy_SpawnQuadProjectiles
; End of function Enemy_ClearAndSpawnQuadProjectiles
nullsub_65:
                rts
; End of function nullsub_65


; Fly enemy movement with wave pattern
Enemy_FlyMovement:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D8E8
                move.w  4(a5),d0
                lea     off_2D8F4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyMovement
; ---------------------------------------------------------------------------
off_2D8F4:      dc.w Enemy_FlyUpdateState-*        ; DATA XREF: Enemy_FlyMovement+4   o
                dc.w Enemy_FlyAttack-*
                dc.w Enemy_FlyReturnPattern-*
                dc.w Enemy_FlyDeath-*


; Updates fly state with animation transitions
Enemy_FlyUpdateState:                              ; DATA XREF: ROM:off_2D8F4   o  ; was: sub_2D8FC
                move.w  #$120,$10(a5)
                move.w  #$90,$14(a5)
                move.w  #$D00,2(a5)
                move.w  #$20,$48(a5) ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FlyUpdateState
; Fly attack behavior with velocity changes
Enemy_FlyAttack:                              ; DATA XREF: ROM:0002D8F6   o  ; was: sub_2D91A
                subq.w  #1,$48(a5)
                bne.s   locret_2D928
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
locret_2D928:                           ; CODE XREF: Enemy_FlyAttack+4   j
                rts
; End of function Enemy_FlyAttack
; Fly return pattern after attack
Enemy_FlyReturnPattern:                              ; DATA XREF: ROM:0002D8F8   o  ; was: sub_2D92A
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2D952
                move.w  #$10,(a0)
                lea     $4C(a5),a1
                move.w  $48(a5),d0
                move.w  a0,(a1,d0.w)
                addq.w  #2,$48(a5)
                cmpi.w  #$10,$48(a5)
                bne.s   locret_2D952
                addq.w  #2,4(a5)
locret_2D952:                           ; CODE XREF: Enemy_FlyReturnPattern+6   j
                                        ; Enemy_FlyReturnPattern+22   j
                rts
; End of function Enemy_FlyReturnPattern
; Fly death animation and cleanup
Enemy_FlyDeath:                              ; DATA XREF: ROM:0002D8FA   o  ; was: sub_2D954
                move.w  (word_FFA000).w,d7
                andi.w  #$F,d7
                bne.s   locret_2D99A
                subq.w  #2,$48(a5)
                bmi.s   loc_2D99C
                lea     $4C(a5),a1
                move.w  $48(a5),d0
                movea.w (a1,d0.w),a0
                move.w  #$2A8,(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $4A(a5),$58(a0)
                tst.w   $4A(a5)
                bne.s   loc_2D994
                addi.w  #$100,$10(a0)
                rts
; ---------------------------------------------------------------------------
loc_2D994:                              ; CODE XREF: Enemy_FlyDeath+36   j
                subi.w  #$80,$10(a0)
locret_2D99A:                           ; CODE XREF: Enemy_FlyDeath+8   j
                rts
; ---------------------------------------------------------------------------
loc_2D99C:                              ; CODE XREF: Enemy_FlyDeath+E   j
                tst.w   $4A(a5)
                bne.s   loc_2D9B2
                addq.w  #1,$4A(a5)
                move.w  #4,4(a5)
                clr.w   $48(a5)
                rts
; ---------------------------------------------------------------------------
loc_2D9B2:                              ; CODE XREF: Enemy_FlyDeath+4C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_FlyDeath
; Walker projectile handler
Projectile_Stage17WalkerShot:                              ; CODE XREF: Boss_ViblackSpawnWalkerShot+36   j  ; was: sub_2D9BA
                                        ; DATA XREF: ROM:off_5DC   o
                move.w  #$2F4,(a0)
                move.w  #$D80,2(a0)
                move.w  #$80,$14(a0)
                move.w  d0,$10(a0)
                rts
; End of function Projectile_Stage17WalkerShot
; State machine dispatcher using jump table indexed by state value in offset 4
Projectile_JumpTableDispatcher:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2D9D0
                move.w  4(a5),d0
                lea     off_2D9DC(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_JumpTableDispatcher
; ---------------------------------------------------------------------------
off_2D9DC:      dc.w Projectile_SpawnLinkedObject-*        ; DATA XREF: Projectile_JumpTableDispatcher+4   o
                dc.w Projectile_CounterLoopState-*


; Spawns linked object ID $2F4, copies position and link values, advances state
Projectile_SpawnLinkedObject:                              ; DATA XREF: ROM:off_2D9DC   o  ; was: sub_2D9E0
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_2DA18
                move.w  #$2F4,(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $4A(a5),$4A(a0)
                move.w  $5E(a5),$5E(a0)
                move.w  #$10,$50(a0)
                move.w  a0,$4A(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_2DA18:                           ; CODE XREF: Projectile_SpawnLinkedObject+6   j
                rts
; End of function Projectile_SpawnLinkedObject
; Decrements timer, increments counter $5E, loops back to state 0 until counter reaches 4
Projectile_CounterLoopState:                              ; DATA XREF: ROM:0002D9DE   o  ; was: sub_2DA1A
                subq.w  #1,$48(a5)
                bne.s   locret_2DA30
                addq.w  #1,$5E(a5)
                cmpi.w  #4,$5E(a5)
                beq.s   loc_2DA32
                subq.w  #2,4(a5)
locret_2DA30:                           ; CODE XREF: Projectile_CounterLoopState+4   j
                rts
; ---------------------------------------------------------------------------
loc_2DA32:                              ; CODE XREF: Projectile_CounterLoopState+10   j
                bset    #4,2(a5)
                rts
; End of function Projectile_CounterLoopState
; Initializes flying bird enemy sprite with graphics mode and collision parameters
Enemy_InitBirdSprite:                              ; CODE XREF: Enemy_BirdInit+2   p  ; was: sub_2DA3A
                move.w  #$6F00,2(a5)
                move.w  (word_FF8274).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5) ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2DA88(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_InitBirdSprite
; ---------------------------------------------------------------------------
word_2DA88:     dc.w $1806, $1100       ; DATA XREF: Enemy_InitBirdSprite+2E   o


; Updates bird enemy animation pointer based on state index
Enemy_UpdateBirdAnimation:                              ; CODE XREF: Enemy_BirdMain+58   p  ; was: sub_2DA8C
                                        ; Enemy_BirdBounceOff+32   j
                move.w  $5C(a5),d0
                beq.s   locret_2DA9E
                subq.w  #4,d0
                move.l  off_2DAA0(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2DA9E:                           ; CODE XREF: Enemy_UpdateBirdAnimation+4   j
                rts
; End of function Enemy_UpdateBirdAnimation
; ---------------------------------------------------------------------------
off_2DAA0:      dc.l off_EA7E0          ; DATA XREF: Enemy_UpdateBirdAnimation+8   r
                dc.l off_EA814
                dc.l off_EA848
                dc.l off_EA85C


; Updates sprite horizontal flip based on velocity
Enemy_UpdateSpriteFlip:                              ; CODE XREF: Enemy_BirdMain+5C   j  ; was: sub_2DAB0
                                        ; Enemy_Stage10WaspMain+5C   j ...
                tst.l   $18(a5)
                beq.s   locret_2DACC
                btst    #7,$18(a5)
                bne.s Sprite_SetHorizontalFlipBit
                andi.w  #$F7FF,$E(a5)
                rts
; ---------------------------------------------------------------------------
; Sets sprite horizontal flip bit based on velocity direction
Sprite_SetHorizontalFlipBit:                              ; CODE XREF: Enemy_UpdateSpriteFlip+C   j  ; was: loc_2DAC6
                ori.w   #$800,$E(a5)
locret_2DACC:                           ; CODE XREF: Enemy_UpdateSpriteFlip+4   j
                rts
; End of function Enemy_UpdateSpriteFlip
; Main bird enemy update checking defeat conditions and player collision
Enemy_BirdMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DACE
                tst.w   4(a5)
                beq.s Enemy_BirdMainLoop
                tst.w   $24(a5)
                bmi.w Enemy_BirdBounceOff
                tst.w   (word_FF808C).w
                bpl.w Enemy_BirdBounceOff
                bclr    #7,$22(a5)
                beq.s   loc_2DB1A
                btst    #4,$22(a5)
                bne.w Enemy_BirdBounceOff
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2DB1A:                              ; CODE XREF: Enemy_BirdMain+1C   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for bird enemy dispatching state and updating animation
Enemy_BirdMainLoop:                              ; CODE XREF: Enemy_BirdMain+4   j  ; was: loc_2DB24
                bsr.s Enemy_BirdStateDispatcher
                bsr.w Enemy_UpdateBirdAnimation
                bra.w Enemy_UpdateSpriteFlip
; End of function Enemy_BirdMain
; Bird enemy state machine dispatcher using jump table
Enemy_BirdStateDispatcher:                              ; CODE XREF: Enemy_BirdMain:loc_2DB24   p  ; was: sub_2DB2E
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2DB3E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BirdStateDispatcher
; ---------------------------------------------------------------------------
off_2DB3E:      dc.w Enemy_BirdInit-*        ; DATA XREF: Enemy_BirdStateDispatcher+8   o
                dc.w Enemy_BirdStartDive-*
                dc.w Enemy_BirdFireWrapper-*
                dc.w Enemy_BirdFlyState-*
                dc.w Enemy_BirdDiveAttack-*
                dc.w Enemy_BirdWaitState-*
                dc.w Enemy_BirdChasePlayer-*
                dc.w Enemy_BirdWaitTimer-*
                dc.w Enemy_BirdDescendToThreshold-*
                dc.w Enemy_BirdAccelerate-*
                dc.w Enemy_BirdDecelerate-*
                dc.w Enemy_BirdAttackState-*
                dc.w Enemy_BirdAscendToThreshold-*
                dc.w Enemy_BirdOscillateMovement-*


nullsub_66:
                rts
; End of function nullsub_66


; Initializes bird enemy position direction and movement state
Enemy_BirdInit:                              ; DATA XREF: ROM:off_2DB3E   o  ; was: sub_2DB5C
                moveq   #0,d0
                bsr.w Enemy_InitBirdSprite
                addq.w  #2,4(a5)
                btst    #0,$5F(a5)
                bne.s   loc_2DB7C
                move.w  #$1E0,$10(a5)
                ori.w   #$800,$E(a5)
                bra.s   loc_2DB88
; ---------------------------------------------------------------------------
loc_2DB7C:                              ; CODE XREF: Enemy_BirdInit+10   j
                move.w  #$70,$10(a5) ; 'p'
                andi.w  #$F7FF,$E(a5)
loc_2DB88:                              ; CODE XREF: Enemy_BirdInit+1E   j
                btst    #1,$5F(a5)
                bne.s Enemy_BirdSetWaitState
                move.w  #2,4(a5)
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   locret_2DBAC
                move.b  #2,$25(a5)
                rts
; ---------------------------------------------------------------------------
; Sets bird enemy to waiting state with timer
Enemy_BirdSetWaitState:                              ; CODE XREF: Enemy_BirdInit+32   j  ; was: loc_2DBA6
                move.w  #6,4(a5)
locret_2DBAC:                           ; CODE XREF: Enemy_BirdInit+40   j
                rts
; End of function Enemy_BirdInit
; Starts bird dive attack setting velocity and animation
Enemy_BirdStartDive:                              ; DATA XREF: ROM:0002DB40   o  ; was: sub_2DBAE
                addq.w  #2,4(a5)
                move.w  #4,$5C(a5)
                ori.w   #$8000,2(a5)
                btst    #0,$5F(a5)
                bne.s Enemy_BirdSetDiveVelocity
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
; Sets bird vertical velocity based on flip flag for dive attack
Enemy_BirdSetDiveVelocity:                              ; CODE XREF: Enemy_BirdStartDive+16   j  ; was: loc_2DBD0
                move.l  #$20000,$18(a5)
                rts
; End of function Enemy_BirdStartDive
; Wrapper for bird enemy projectile firing
