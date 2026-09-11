Weapon_UpdateRotatingProjectile:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18A66
                move.w  $48(a5),d0
                addq.w  #2,d0
                andi.w  #$E,d0
                move.w  d0,$48(a5)
                movea.l $4A(a5),a0
                move.w  (a0,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  $10(a0,d0.w),8(a5)
                move.w  $20(a0,d0.w),$A(a5)
                cmpi.w  #$80,$10(a5)
                bmi.w   Object_MarkInactive
                cmpi.w  #$1C0,$10(a5)
                bpl.w   Object_MarkInactive
                cmpi.w  #$A0,$14(a5)
                bmi.w   Object_MarkInactive
                cmpi.w  #$160,$14(a5)
                bpl.w   Object_MarkInactive
                btst    #0,(byte_FF8144).w
                bne.s   Weapon_UpdateRotatingProjectile_Return
                addi.l  #$4000,$1C(a5)
Weapon_UpdateRotatingProjectile_Return:                 ; CODE XREF: Weapon_UpdateRotatingProjectile+58   j  ; was: locret_18AC8
                rts
; End of function Weapon_UpdateRotatingProjectile
; Handles projectile collision
Weapon_HandleProjectileHit:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18ACA
                bclr    #7,$22(a5)
                bne.s   Weapon_HandleProjectileHit_InitImpact
                bclr    #6,$23(a5)
                beq.s   Weapon_TickLifetimeTimer
                bclr    #4,$23(a5)
                bne.s   Weapon_HandleProjectileHit_InitBurst
Weapon_HandleProjectileHit_InitImpact:                  ; CODE XREF: Weapon_HandleProjectileHit+6   j  ; was: loc_18AE2
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (Weapon_ImpactSpriteFrames).l,a1
                jmp     Sprite_InitTypeA4FromCurrentTable
; ---------------------------------------------------------------------------
Weapon_HandleProjectileHit_InitBurst:                   ; CODE XREF: Weapon_HandleProjectileHit+16   j  ; was: loc_18AF6
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #Weapon_HomingEffectSpriteData,$4A(a5)
                bra.w   Effect_InitSharedImpactMotion
; End of function Weapon_HandleProjectileHit
; Attributes: thunk
; Thunk to Sprite_InitTypeA4FromCurrentTable
Effect_InitImpactObjectFromCurrent:
                jmp     Sprite_InitTypeA4FromCurrentTable  ; was: sub_18B1A
; End of function Effect_InitImpactObjectFromCurrent
; Decrements projectile lifetime
Weapon_TickLifetimeTimer:                               ; CODE XREF: Weapon_HandleProjectileHit+E   j  ; was: sub_18B20
                subq.w  #1,$48(a5)
                bmi.w   Object_MarkInactive
                rts
; End of function Weapon_TickLifetimeTimer
; Handles explosive projectile impact with particle spawn
Weapon_HandleExplosiveImpact:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18B2A
                bclr    #7,$22(a5)
                bne.s   Weapon_HandleExplosiveImpact_InitExplosion
                bclr    #6,$23(a5)
                beq.w   Weapon_AnimateExplosionFade
                bclr    #4,$23(a5)
                bne.s   Weapon_HandleExplosiveImpact_InitBurst
Weapon_HandleExplosiveImpact_InitExplosion:             ; CODE XREF: Weapon_HandleExplosiveImpact+6   j  ; was: loc_18B44
                tst.w   (dword_FF802C).w
                beq.s   Weapon_HandleExplosiveImpact_InitImpact
                move.l  $18(a5),d0
                asr.l   #3,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #3,d0
                move.l  d0,$1C(a5)
                move.w  #$400,(a5)
                move.w  #$EC00,2(a5)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.l  #SharedCombatSpriteAnimation01,8(a5)
                clr.w   $C(a5)
                move.w  #5,$26(a5)
                tst.w   (DifficultyMode).w
                bne.s   Weapon_HandleExplosiveImpact_Return
                move.w  #6,$26(a5)
Weapon_HandleExplosiveImpact_Return:                    ; CODE XREF: Weapon_HandleExplosiveImpact+60   j  ; was: locret_18B92
                rts
; ---------------------------------------------------------------------------
Weapon_HandleExplosiveImpact_InitImpact:                ; CODE XREF: Weapon_HandleExplosiveImpact+1E   j  ; was: loc_18B94
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (Weapon_ImpactSpriteFrames).l,a1
                jmp     Sprite_InitTypeA4FromCurrentTable
; ---------------------------------------------------------------------------
Weapon_HandleExplosiveImpact_InitBurst:                 ; CODE XREF: Weapon_HandleExplosiveImpact+18   j  ; was: loc_18BA8
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #Weapon_HomingEffectSpriteData,$4A(a5)
                bra.w   Effect_InitSharedImpactMotion
; End of function Weapon_HandleExplosiveImpact
; Attributes: thunk
; Thunk to Sprite_InitTypeA4FromCurrentTable
Effect_InitExplosiveImpactFromCurrent:
                jmp     Sprite_InitTypeA4FromCurrentTable  ; was: sub_18BCC
; End of function Effect_InitExplosiveImpactFromCurrent
; Animates explosion sprite fading sequence
Weapon_AnimateExplosionFade:                            ; CODE XREF: Weapon_HandleExplosiveImpact+E   j  ; was: sub_18BD2
                subq.w  #2,$5E(a5)
                bmi.w   Object_MarkInactive
                move.w  $5E(a5),d0
                asr.w   #2,d0
                cmpi.w  #6,d0
                bmi.s   Weapon_GetExplosionFrameData
                moveq   #6,d0
; Gets explosion animation frame data based on timer
Weapon_GetExplosionFrameData:                           ; CODE XREF: Weapon_AnimateExplosionFade+12   j  ; was: loc_18BE8
                andi.w  #6,d0
                move.w  Weapon_ExplosionFadeTiles(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  Weapon_ExplosionFadeSizes(pc,d0.w),8(a5)
                move.w  Weapon_ExplosionFadeOffsets(pc,d0.w),$A(a5)
                rts
; End of function Weapon_AnimateExplosionFade
; ---------------------------------------------------------------------------
Weapon_ExplosionFadeTiles:  dc.w    $45A9, $45A5, $45A1, $45A0  ; was: word_18C06
                                        ; DATA XREF: Weapon_AnimateExplosionFade+1A   r
Weapon_ExplosionFadeSizes:  dc.w    $A00, $500, $500, 0  ; was: word_18C0E
                                        ; DATA XREF: Weapon_AnimateExplosionFade+26   r
Weapon_ExplosionFadeOffsets:    dc.w    $F4F4, $F8F8, $F8F8, $FCFC  ; was: word_18C16
                                        ; DATA XREF: Weapon_AnimateExplosionFade+2C   r

; Marks the current object inactive without additional cleanup
Object_MarkInactiveDirect:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18C1E
                bset    #4,2(a5)
                rts
; End of function Object_MarkInactiveDirect
; Processes projectile hit effects including screen shake and palette change
Weapon_ProcessProjectileHit:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18C26
                move.w  #$A0,(word_FF8140).w
                move.b  #$60,(byte_FF8142).w            ; '`'
                move.b  #4,(byte_FF8143).w
                tst.w   $26(a5)
                bpl.s   Weapon_HideHitEffectWhenFinished
                clr.b   $21(a5)
; Hides the hit effect after its animation reaches the terminal frame
Weapon_HideHitEffectWhenFinished:                       ; CODE XREF: Weapon_ProcessProjectileHit+16   j  ; was: loc_18C42
                cmpi.w  #$80,$C(a5)
                bmi.s   Weapon_ProcessProjectileHit_Return
                move.w  #$1000,2(a5)
Weapon_ProcessProjectileHit_Return:                     ; CODE XREF: Weapon_ProcessProjectileHit+22   j  ; was: locret_18C50
                rts
; End of function Weapon_ProcessProjectileHit
; Updates an impact particle or spawns its child effect
Effect_UpdateImpactParticleSpawner:                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18C52
                bclr    #6,$23(a5)
                bne.s   Effect_UpdateImpactParticleSpawner_SpawnChild
                bclr    #7,$22(a5)
                beq.w   Effect_UpdateImpactParticleAnimation
Effect_UpdateImpactParticleSpawner_SpawnChild:          ; CODE XREF: Effect_UpdateImpactParticleSpawner+6   j  ; was: loc_18C64
                move.w  a5,d0
                btst    #5,d0
                bne.w   Effect_UpdateImpactParticleSpawner_Deactivate
                jsr     (Sprite_AllocateSlot).l
                bne.w   Effect_UpdateImpactParticleSpawner_Deactivate
                lea     (Effect_ParticlePrimarySpriteFrames).l,a1
                btst    #7,(RandomNumberState).w
                bne.s   Effect_UpdateImpactParticleSpawner_InitChild
                lea     (Effect_ParticleSecondarySpriteFrames).l,a1
Effect_UpdateImpactParticleSpawner_InitChild:           ; CODE XREF: Effect_UpdateImpactParticleSpawner+32   j  ; was: loc_18C8C
                jsr     (Sprite_InitTypeA4FromTable).l
                move.w  #$8C80,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                bpl.s   Effect_UpdateImpactParticleSpawner_SetVelocity
                clr.b   $20(a0)
Effect_UpdateImpactParticleSpawner_SetVelocity:         ; CODE XREF: Effect_UpdateImpactParticleSpawner+5C   j  ; was: loc_18CB4
                move.w  $56(a5),d5
                addi.w  #$20,d5                         ; ' '
                andi.w  #$7C,d5                         ; '|'
                lea     dword_19772(pc),a1
                nop
                move.l  (a1,d5.w),d0
                move.l  $20(a1,d5.w),d1
                btst    #1,(word_FFA000+1).w
                bne.s   Effect_UpdateImpactParticleSpawner_ApplyDirection
                neg.l   d0
                neg.l   d1
Effect_UpdateImpactParticleSpawner_ApplyDirection:      ; CODE XREF: Effect_UpdateImpactParticleSpawner+82   j  ; was: loc_18CDA
                asr.l   #2,d0
                asr.l   #2,d1
                add.l   (dword_FF8024).w,d0
                add.l   (dword_FF8028).w,d1
                move.l  d1,$18(a0)
                move.l  d0,$1C(a0)
Effect_UpdateImpactParticleSpawner_Deactivate:          ; CODE XREF: Effect_UpdateImpactParticleSpawner+18   j  ; was: loc_18CEE
                                        ; Effect_UpdateImpactParticleSpawner+22   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Updates particle effect sprite animation with gravity and fading
Effect_UpdateImpactParticleAnimation:                   ; CODE XREF: Effect_UpdateImpactParticleSpawner+E   j  ; was: loc_18CF6
                move.l  (dword_FF8024).w,d0
                move.l  (dword_FF8028).w,d1
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.w  #2,$48(a5)
                bmi.s   Effect_UpdateImpactParticleSpawner_Deactivate
                move.w  $48(a5),d0
                move.w  Effect_ImpactParticleTiles(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                move.w  Effect_ImpactParticleSizes(pc,d0.w),8(a5)
                move.w  Effect_ImpactParticleOffsets(pc,d0.w),$A(a5)
                rts
; End of function Effect_UpdateImpactParticleSpawner
; ---------------------------------------------------------------------------
Effect_ImpactParticleTiles: dc.w    $452B, $451B, $450B, $451B, $452B, $4492, $449B, $44A4  ; was: word_18D2E
                                        ; DATA XREF: Effect_UpdateImpactParticleSpawner+BE   r
Effect_ImpactParticleSizes: dc.w    $F00, $F00, $F00, $F00, $F00, $A00, $A00, $500  ; was: word_18D3E
                                        ; DATA XREF: Effect_UpdateImpactParticleSpawner+CE   r
Effect_ImpactParticleOffsets:   dc.w    $F0F0, $F0F0, $F0F0, $F0F0, $F0F0, $F4F4, $F4F4, $F8F8  ; was: word_18D4E
                                        ; DATA XREF: Effect_UpdateImpactParticleSpawner+D4   r

; Updates seeking missile projectile with target tracking and rotation
Weapon_UpdateSeekingMissile:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18D5E
                bclr    #7,$22(a5)
                bne.s   Weapon_UpdateSeekingMissile_InitImpact
                bclr    #4,$23(a5)
                beq.s   Weapon_UpdateSeekingMissile_TickLifetime
Weapon_UpdateSeekingMissile_InitImpact:                 ; CODE XREF: Weapon_UpdateSeekingMissile+6   j  ; was: loc_18D6E
                move.w  #3,$48(a5)
                move.l  #SharedCombatSpriteAnimation12,8(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp     Effect_InitType188FromCurrent
; ---------------------------------------------------------------------------
Weapon_UpdateSeekingMissile_TickLifetime:               ; CODE XREF: Weapon_UpdateSeekingMissile+E   j  ; was: loc_18D8A
                subq.w  #1,$48(a5)
                bpl.w   Weapon_UpdateSeekingMissile_ApplyVelocity
                cmpi.w  #$FFF1,$48(a5)
                bpl.s   Weapon_UpdateSeekingMissile_SelectTrackingSlot
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Weapon_UpdateSeekingMissile_SelectTrackingSlot:         ; CODE XREF: Weapon_UpdateSeekingMissile+3A   j  ; was: loc_18DA2
                move.w  a5,d0
                btst    #0,(word_FFA000+1).w
                bne.w   Weapon_UpdateSeekingMissile_CheckAlternateSlot
                btst    #5,d0
                beq.s   Weapon_UpdateSeekingMissile_SelectTargetAngle
                bra.s   Weapon_UpdateSeekingMissile_ApplyVelocity
; ---------------------------------------------------------------------------
Weapon_UpdateSeekingMissile_CheckAlternateSlot:         ; CODE XREF: Weapon_UpdateSeekingMissile+4C   j  ; was: loc_18DB6
                btst    #5,d0
                beq.s   Weapon_UpdateSeekingMissile_ApplyVelocity
Weapon_UpdateSeekingMissile_SelectTargetAngle:          ; CODE XREF: Weapon_UpdateSeekingMissile+54   j  ; was: loc_18DBC
                move.w  (word_FF801C).w,d0
                bne.s   Weapon_UpdateSeekingMissile_ComputeTargetAngle
                move.w  (RandomNumberState).w,d2
                bra.s   Weapon_UpdateSeekingMissile_AdjustHeading
; ---------------------------------------------------------------------------
Weapon_UpdateSeekingMissile_ComputeTargetAngle:         ; CODE XREF: Weapon_UpdateSeekingMissile+62   j  ; was: loc_18DC8
                bclr    #0,d0
                movea.w d0,a0
                move.w  $10(a0),d0
                move.w  $14(a0),d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_Arctan2Lookup).l
                asr.w   #1,d2
                move.w  d2,(dword_FF8040).w
                move.b  (dword_FF8040).w,d2
Weapon_UpdateSeekingMissile_AdjustHeading:              ; CODE XREF: Weapon_UpdateSeekingMissile+68   j  ; was: loc_18DEE
                andi.w  #$7C,d2                         ; '|'
                move.w  (RandomNumberState).w,d0
                andi.w  #6,d0
                addq.w  #6,d0
                sub.w   $56(a5),d2
                bmi.s   Weapon_UpdateSeekingMissile_CheckAngleWrap
                cmpi.w  #$40,d2                         ; '@'
                bpl.s   Weapon_UpdateSeekingMissile_DecreaseHeading
Weapon_UpdateSeekingMissile_IncreaseHeading:            ; CODE XREF: Weapon_UpdateSeekingMissile+B4   j  ; was: loc_18E08
                add.w   d0,$56(a5)
                bra.s   Weapon_UpdateSeekingMissile_ApplyVelocity
; ---------------------------------------------------------------------------
Weapon_UpdateSeekingMissile_CheckAngleWrap:             ; CODE XREF: Weapon_UpdateSeekingMissile+A2   j  ; was: loc_18E0E
                cmpi.w  #$FFC0,d2
                bmi.s   Weapon_UpdateSeekingMissile_IncreaseHeading
Weapon_UpdateSeekingMissile_DecreaseHeading:            ; CODE XREF: Weapon_UpdateSeekingMissile+A8   j  ; was: loc_18E14
                sub.w   d0,$56(a5)
Weapon_UpdateSeekingMissile_ApplyVelocity:              ; CODE XREF: Weapon_UpdateSeekingMissile+30   j  ; was: loc_18E18
                                        ; Weapon_UpdateSeekingMissile+56   j
                move.w  $56(a5),d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d2,$56(a5)
                andi.w  #$7C,d2                         ; '|'
                movea.l (dword_FF802C).w,a0
                move.l  (a0,d2.w),d1
                move.l  $20(a0,d2.w),d0
                move.w  (dword_FF8028+2).w,d2
                asr.l   d2,d1
                asr.l   d2,d0
                move.l  d1,$1C(a5)
                move.l  d0,$18(a5)
                move.w  $48(a5),d0
                bmi.s   Weapon_UpdateSeekingMissile_SelectFrame
                moveq   #4,d0
Weapon_UpdateSeekingMissile_SelectFrame:                ; CODE XREF: Weapon_UpdateSeekingMissile+EA   j  ; was: loc_18E4C
                andi.w  #$E,d0
                move.w  Weapon_SeekingMissileTiles(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                cmpi.w  #4,d0
                bmi.s   Weapon_SetMissileSize
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                rts
; ---------------------------------------------------------------------------
; Sets seeking missile sprite size based on distance from player
Weapon_SetMissileSize:                                  ; CODE XREF: Weapon_UpdateSeekingMissile+106   j  ; was: loc_18E74
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                rts
; End of function Weapon_UpdateSeekingMissile
; ---------------------------------------------------------------------------
Weapon_SeekingMissileTiles: dc.w    $45A0, $45A0, $45A4, $45AD, $45AD, $45B6, $45B6, $45AD  ; was: word_18E82
                                        ; DATA XREF: Weapon_UpdateSeekingMissile+F2   r

; Matches sprite position and properties to parent sprite
Effect_UpdateCompanionFromParent:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18E92
                movea.w a5,a0
                btst    #0,(word_FFA000+1).w
                bne.s   Effect_UpdateCompanionFromAlternateParent
                suba.w  #$300,a0
                bra.s   Effect_UpdateCompanion_CheckParent
; ---------------------------------------------------------------------------
Effect_UpdateCompanionFromAlternateParent:              ; CODE XREF: Effect_UpdateCompanionFromParent+8   j  ; was: loc_18EA2
                suba.w  #$360,a0
Effect_UpdateCompanion_CheckParent:                     ; CODE XREF: Effect_UpdateCompanionFromParent+E   j  ; was: loc_18EA6
                move.w  $48(a5),d0
                cmp.w   (a0),d0
                beq.s   Effect_CopyParentTransform
                move.w  #$40,$10(a5)                    ; '@'
                rts
; ---------------------------------------------------------------------------
; Copies parent sprite transform data including position and tiles
Effect_CopyParentTransform:                             ; CODE XREF: Effect_UpdateCompanionFromParent+1A   j  ; was: loc_18EB6
                move.w  $10(a0),d0
                sub.w   $18(a0),d0
                move.w  d0,$10(a5)
                move.w  $14(a0),d0
                sub.w   $1C(a0),d0
                move.w  d0,$14(a5)
                move.w  $E(a0),$E(a5)
                move.w  8(a0),8(a5)
                move.w  $A(a0),$A(a5)
                move.b  $20(a0),$20(a5)
                rts
; End of function Effect_UpdateCompanionFromParent
; Updates projectile seeking movement
Weapon_UpdateSeekingProjectile:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18EE8
                subq.w  #1,$5E(a5)
                bmi.s   Weapon_HandleSeekingProjectileCollision
                bne.s   Weapon_ApplySeekingProjectileMotion
                move.b  #$40,$21(a5)                    ; '@'
; Updates sprite seeking motion with velocity subtraction
Weapon_ApplySeekingProjectileMotion:                    ; CODE XREF: Weapon_UpdateSeekingProjectile+6   j  ; was: loc_18EF6
                move.l  $48(a5),d0
                move.l  $4C(a5),d1
                sub.l   d0,$14(a5)
                sub.l   d1,$10(a5)
; End of function Weapon_UpdateSeekingProjectile
; Handles projectile collision and destruction
Weapon_HandleSeekingProjectileCollision:                ; CODE XREF: Weapon_UpdateSeekingProjectile+4   j  ; was: sub_18F06
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                btst    #6,$23(a5)
                bne.s   Weapon_HandleSeekingProjectileCollision_Explode
                tst.w   $26(a5)
                bpl.s   Weapon_HandleSeekingProjectileCollision_Return
                lea     (Projectile_CollisionSpriteFrames).l,a1
                jsr     (Sprite_InitCurrentFromTable).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
Weapon_HandleSeekingProjectileCollision_Return:         ; CODE XREF: Weapon_HandleSeekingProjectileCollision+C   j  ; was: locret_18F2E
                rts
; ---------------------------------------------------------------------------
Weapon_HandleSeekingProjectileCollision_Explode:        ; CODE XREF: Weapon_HandleSeekingProjectileCollision+6   j  ; was: loc_18F30
                btst    #4,$23(a5)
                beq.s   Weapon_HandleSeekingProjectileCollision_SpawnEffect
                move.b  #$C8,d0
                jsr     (Sound_PlaySFX).l
Weapon_HandleSeekingProjectileCollision_SpawnEffect:    ; CODE XREF: Weapon_HandleSeekingProjectileCollision+30   j  ; was: loc_18F42
                movea.w a5,a0
                bsr.s   Effect_SpawnExplosion
Weapon_InitProjectileCompanion:                         ; CODE XREF: Weapon_InitProjectileSprite+32   j  ; was: loc_18F46
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Weapon_HandleSeekingProjectileCollision
; Spawns explosion effect with random velocity
Effect_SpawnExplosion:                                  ; CODE XREF: Weapon_HandleSeekingProjectileCollision+3E   p  ; was: sub_18F58
                lea     (Effect_StarParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (RandomNumberState).w,d3
                move.b  (RandomNumberState+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #3,d3
                addq.w  #3,d4
                movea.l #Math_SineTable,a1
                move.w  (RandomNumberState).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnExplosion
; Updates bomb projectile with gravity and collision detection
Weapon_UpdateBombProjectile:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_18FA6
                btst    #6,$23(a5)
                bne.w   Weapon_UpdateBombProjectile_Explode
                tst.w   $26(a5)
                bpl.s   Weapon_UpdateBombProjectile_TickLifetime
                lea     (Projectile_BombAndRadialSpriteFrames).l,a1
                jsr     (Sprite_InitCurrentFromTable).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; ---------------------------------------------------------------------------
Weapon_UpdateBombProjectile_TickLifetime:               ; CODE XREF: Weapon_UpdateBombProjectile+E   j  ; was: loc_18FD2
                subq.w  #1,$5E(a5)
                bpl.s   Weapon_UpdateBombProjectile_ApplyMotion
                bset    #4,2(a5)
                clr.b   $21(a5)
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                lea     (Effect_StarParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                rts
; ---------------------------------------------------------------------------
Weapon_UpdateBombProjectile_ApplyMotion:                ; CODE XREF: Weapon_UpdateBombProjectile+30   j  ; was: loc_1901C
                move.w  #$8080,2(a5)
                move.w  $58(a5),d0
                add.w   (dword_FFA410).w,d0
                move.l  $50(a5),d1
                add.l   $18(a5),d1
                move.l  d1,$50(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$10(a5)
                move.w  $5A(a5),d0
                add.w   (dword_FFA414).w,d0
                move.l  $54(a5),d1
                add.l   $1C(a5),d1
                move.l  d1,$54(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
Weapon_UpdateBombProjectile_Explode:                    ; CODE XREF: Weapon_UpdateBombProjectile+6   j  ; was: loc_1905C
                btst    #4,$23(a5)
                beq.s   Weapon_UpdateBombProjectile_SpawnDebris
                move.b  #$C8,d0
                jsr     (Sound_PlaySFX).l
Weapon_UpdateBombProjectile_SpawnDebris:                ; CODE XREF: Weapon_UpdateBombProjectile+BC   j  ; was: loc_1906E
                movea.w a5,a0
                bsr.s   Effect_CreateExplosionDebris
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Weapon_UpdateBombProjectile
; Creates explosion debris particles with random velocity
Effect_CreateExplosionDebris:                           ; CODE XREF: Weapon_UpdateBombProjectile+CA   p  ; was: sub_19084
                lea     (Effect_StarParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (RandomNumberState).w,d3
                move.b  (RandomNumberState+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #2,d3
                addq.w  #2,d4
                movea.l #Math_SineTable,a1
                move.w  (RandomNumberState).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_CreateExplosionDebris
; Spawns spark particle during player death sequence
Effect_SpawnPlayerDeathSpark:                           ; CODE XREF: Player_HandleInvulnerabilityTimer:Player_HandleInvulnerabilityTimer_SpawnSpark   j  ; was: sub_190D2
                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$F,d7
Effect_SpawnPlayerDeathSpark_FindSlot:                  ; CODE XREF: Effect_SpawnPlayerDeathSpark+E   j  ; was: loc_190D8
                tst.w   (a0)
                beq.s   Effect_SpawnPlayerDeathSpark_Initialize
                lea     $60(a0),a0
                dbf     d7,Effect_SpawnPlayerDeathSpark_FindSlot
                rts
; ---------------------------------------------------------------------------
Effect_SpawnPlayerDeathSpark_Initialize:                ; CODE XREF: Effect_SpawnPlayerDeathSpark+8   j  ; was: loc_190E6
                move.w  #$7C,(a0)                       ; '|'
                move.w  #$EC00,2(a0)
                clr.b   $21(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$480,$E(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                move.l  #SharedCombatSpriteAnimation01,8(a0)
                clr.w   $C(a0)
                lea     (Math_SineTable).l,a1
                move.w  (RandomNumberState).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d2
                move.w  d1,$4E(a0)
                move.w  d2,$50(a0)
                ext.l   d1
                ext.l   d2
                asl.l   #5,d1
                asl.l   #5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnPlayerDeathSpark
; Updates death spark particle motion with deceleration
Effect_UpdateDeathSparkMotion:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_19154
                cmpi.w  #$80,$C(a5)
                bmi.s   Effect_ApplySparkDeceleration
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Applies deceleration to spark particle velocity
Effect_ApplySparkDeceleration:                          ; CODE XREF: Effect_UpdateDeathSparkMotion+6   j  ; was: loc_19164
                move.w  $4E(a5),d0
                move.w  $50(a5),d1
                ext.l   d0
                ext.l   d1
                sub.l   d0,$1C(a5)
                sub.l   d1,$18(a5)
                rts
; End of function Effect_UpdateDeathSparkMotion
; Destroys sprite when timer expires
Object_UpdateRemovalTimer:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_1917A
                subq.w  #1,$48(a5)
                bpl.s   Object_UpdateRemovalTimer_Return
                bset    #4,2(a5)
Object_UpdateRemovalTimer_Return:                       ; CODE XREF: Object_UpdateRemovalTimer+4   j  ; was: locret_19186
                rts
; End of function Object_UpdateRemovalTimer
; Initializes projectile sprite with position and velocity
Effect_InitPlayerMotionProjectile:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_19188
                bset    #7,2(a5)
                cmpi.l  #Player_TeleportDashTrailSpriteMapping,(dword_FFA408).w
                beq.s   Effect_InitPlayerMotionProjectile_CopyPosition
                bclr    #7,2(a5)
Effect_InitPlayerMotionProjectile_CopyPosition:         ; CODE XREF: Effect_InitPlayerMotionProjectile+E   j  ; was: loc_1919E
                move.w  (dword_FFA410).w,$10(a5)
                move.w  (dword_FFA414).w,$14(a5)
                bclr    #7,$22(a5)
                beq.s   Effect_InitPlayerMotionProjectile_SpawnChild
                move.w  #4,(word_FF813C).w
Effect_InitPlayerMotionProjectile_SpawnChild:           ; CODE XREF: Effect_InitPlayerMotionProjectile+28   j  ; was: loc_191B8
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$B,d7
                jsr     (Sys_FindFreeObjectSlot).l
                bne.w   Effect_InitPlayerMotionProjectile_Return
                move.l  #SharedCombatSpriteAnimation02,8(a0)
                jsr     (Sprite_InitType160).l
                move.b  $20(a5),$20(a0)
                lea     (Math_SineTable).l,a1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a0)
                swap    d1
                btst    #0,(word_FFA000+1).w
                bne.s   Effect_InitPlayerMotionProjectile_ApplyFacing
                neg.w   d1
                neg.l   $1C(a0)
Effect_InitPlayerMotionProjectile_ApplyFacing:          ; CODE XREF: Effect_InitPlayerMotionProjectile+78   j  ; was: loc_19208
                add.w   $14(a5),d1
                move.w  d1,$14(a0)
                move.w  $10(a5),$10(a0)
                tst.w   (word_FFA448).w
                bmi.s   Effect_InitPlayerMotionProjectile_MoveRight
                move.l  #$FFF60000,$18(a0)
                rts
; ---------------------------------------------------------------------------
Effect_InitPlayerMotionProjectile_MoveRight:            ; CODE XREF: Effect_InitPlayerMotionProjectile+92   j  ; was: loc_19226
                move.l  #$A0000,$18(a0)
                rts
; ---------------------------------------------------------------------------
Effect_InitPlayerMotionProjectile_Return:               ; CODE XREF: Effect_InitPlayerMotionProjectile+3C   j  ; was: locret_19230
                rts
; End of function Effect_InitPlayerMotionProjectile
; Increments frame and checks lifetime
Effect_AnimateAndExpire:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_19232
                addq.w  #1,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   Effect_AnimateAndExpire_Return
                bset    #4,2(a5)
Effect_AnimateAndExpire_Return:                         ; CODE XREF: Effect_AnimateAndExpire+8   j  ; was: locret_19242
                rts
; End of function Effect_AnimateAndExpire
