; Finds a free sprite slot in the enemy projectile pool
Enemy_FindFreeSpriteSlot:                               ; CODE XREF: Enemy_FindSlotAndInit   p  ; was: sub_2AFBE
                movea.w #(byte_FFCC80-M68K_RAM),a0
                jmp     Projectile_FindFreePrimarySlot_CheckEnemyRange
; End of function Enemy_FindFreeSpriteSlot
; Finds free enemy sprite slot and initializes with homing projectile
Enemy_FindSlotAndInit:
                bsr.w   Enemy_FindFreeSpriteSlot        ; was: sub_2AFC8
                bne.s   locret_2AFD4
                movea.l off_2AFD6(pc,d1.w),a1
                jmp     (a1)
; ---------------------------------------------------------------------------
locret_2AFD4:                                           ; CODE XREF: Enemy_FindSlotAndInit+4   j
                rts
; End of function Enemy_FindSlotAndInit
; ---------------------------------------------------------------------------
off_2AFD6:      dc.l    Enemy_InitHomingProjectile      ; DATA XREF: Enemy_FindSlotAndInit+6   r
                dc.l    Boss_JetsripperSpawnBullet

; Spawns directional projectile in one of 8 directions with velocity
Projectile_SpawnDirectional8Way:                        ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+1E   p  ; was: sub_2AFDE
                move.w  #$50,(a0)                       ; 'P'
                move.w  d0,$48(a0)
                move.w  #1,$4A(a0)
                move.w  #$8100,2(a0)
                add.w   $10(a5),d1
                move.w  d1,$10(a0)
                add.w   $14(a5),d2
                move.w  d2,$14(a0)
                addq.w  #8,d0
                andi.w  #$70,d0                         ; 'p'
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
word_2B02A:     dc.w    $4CD6, $5CDF, $54E8, $54DF, $44D6, $44DF, $44E8, $4CDF
                                        ; DATA XREF: Projectile_SpawnDirectional8Way+2C   r

; Initializes directional projectile with animation, velocity from table
Projectile_DirectionalInitMain:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B03A
                subq.w  #1,$4A(a5)
                bpl.s   locret_2B09A
                move.w  #$4C,(a5)                       ; 'L'
                move.w  #$8D00,2(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$F808F808,$2C(a5)
                move.w  #$50,$26(a5)                    ; 'P'
                move.w  $48(a5),d0
                movea.l #dword_2B166,a0
                move.l  (a0,d0.w),$1C(a5)
                move.l  $20(a0,d0.w),$18(a5)
                addq.w  #4,d0
                andi.w  #$78,d0                         ; 'x'
                asr.w   #2,d0
                move.w  word_2B09C(pc,d0.w),$E(a5)
                move.w  #0,8(a5)
                move.w  #$FCFC,$A(a5)
                move.w  (word_FF808A).w,d0
                andi.w  #$8000,d0
                or.w    d0,$E(a5)
locret_2B09A:                                           ; CODE XREF: Projectile_DirectionalInitMain+4   j
                rts
; End of function Projectile_DirectionalInitMain
; ---------------------------------------------------------------------------
word_2B09C:     dc.w    $4CF1, $5CF2, $5CF3, $5CF4, $54F5, $54F4, $54F3, $54F2
                                        ; DATA XREF: Projectile_DirectionalInitMain+42   r
                dc.w    $44F1, $44F2, $44F3, $44F4, $44F5, $4CF4, $4CF3, $4CF2

; Checks bounds/collision, explodes projectile on wall impact
Projectile_ExplodeOnWall:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B0BC
                cmpi.w  #$88,$10(a5)
                bmi.s   loc_2B0DC
                cmpi.w  #$1B8,$10(a5)
                bpl.s   loc_2B0DC
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B0DC
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B0E4
loc_2B0DC:                                              ; CODE XREF: Projectile_ExplodeOnWall+6   j
                                        ; Projectile_ExplodeOnWall+E   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B0E4:                                              ; CODE XREF: Projectile_ExplodeOnWall+1E   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B0FA
                btst    #7,$22(a5)
                beq.s   loc_2B102
                btst    #4,$22(a5)
                beq.s   loc_2B114
loc_2B0FA:                                              ; CODE XREF: Projectile_ExplodeOnWall+2C   j
                jsr     (Pickup_SpawnSmallFromCurrentObject).l
                bra.s   loc_2B11A
; ---------------------------------------------------------------------------
loc_2B102:                                              ; CODE XREF: Projectile_ExplodeOnWall+34   j
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                jsr     (Collision_CheckTerrainTile).l
                bne.s   loc_2B114
locret_2B112:                                           ; CODE XREF: Projectile_ExplodeOnWall+64   j
                rts
; ---------------------------------------------------------------------------
loc_2B114:                                              ; CODE XREF: Projectile_ExplodeOnWall+3C   j
                                        ; Projectile_ExplodeOnWall+54   j
                bset    #4,2(a5)
loc_2B11A:                                              ; CODE XREF: Projectile_ExplodeOnWall+44   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_2B112
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3C,d0                         ; '<'
                add.w   $48(a5),d0
                subi.w  #$5C,d0                         ; '\'
                andi.w  #$7C,d0                         ; '|'
                movea.l #dword_2B166,a1
                move.l  (a1,d0.w),d1
                move.l  $20(a1,d0.w),d2
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movea.l #Effect_KnockbackImpactSpriteFrames,a1
                bra.w   Sprite_InitFromTable
; End of function Projectile_ExplodeOnWall
; ---------------------------------------------------------------------------
dword_2B166:    dc.l    0, $1C170                       ; DATA XREF: Projectile_DirectionalInitMain+28   o
                                        ; Projectile_ExplodeOnWall+86   o
                dc.l    $37194, $4FFF8
                dc.l    $65D24, $77B98
                dc.l    $85080, $8D3B4
                dc.l    $90000, $8D3B4
                dc.l    $85080, $77B98
                dc.l    $65D24, $4FFF8
                dc.l    $37194, $1C170
                dc.l    $FFFFFFDC, $FFFE3E90
                dc.l    $FFFC8E6C, $FFFB0008
                dc.l    $FFF9A2DC, $FFF88468
                dc.l    $FFF7AF80, $FFF72C4C
                dc.l    $FFF70000, $FFF72C4C
                dc.l    $FFF7AF80, $FFF88468
                dc.l    $FFF9A2DC, $FFFB0008
                dc.l    $FFFC8E6C, $FFFE3E90
                dc.l    0, $1C170
                dc.l    $37194, $4FFF8
                dc.l    $65D24, $77B98
                dc.l    $85080, $8D3B4

; Initializes homing projectile with trajectory calculation
Enemy_InitHomingProjectile:                             ; CODE XREF: Enemy_UpdateCircularMotionAndFire+5A   p  ; was: sub_2B206
                                        ; Enemy_FlyerState4+48   p
                moveq   #$A,d7
                tst.w   (word_FFFF0E).w
                beq.s   Enemy_SetProjectileDifficulty
                moveq   #$B,d7
; Initializes enemy homing projectile with velocity and angle
Enemy_SetProjectileDifficulty:                          ; CODE XREF: Enemy_InitHomingProjectile+6   j  ; was: loc_2B210
                                        ; Enemy_SpawnTrackedProjectile+32   j
                move.w  #$148,(a0)
                move.w  #$ED00,2(a0)
                clr.w   4(a0)
                move.w  #$32,$26(a0)                    ; '2'
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
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d6.w),d1
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
Enemy_HomingProjectileMain:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B298
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bmi.s   loc_2B2B8
                cmpi.w  #$1D0,$10(a5)
                bpl.s   loc_2B2B8
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B2B8
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B2C0
loc_2B2B8:                                              ; CODE XREF: Enemy_HomingProjectileMain+6   j
                                        ; Enemy_HomingProjectileMain+E   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B2C0:                                              ; CODE XREF: Enemy_HomingProjectileMain+1E   j
                tst.w   4(a5)
                bne.s   loc_2B2F0
                subq.w  #1,$48(a5)
                bpl.s   locret_2B2EE
                addq.w  #2,4(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #off_E9788,8(a5)
                clr.w   $C(a5)
                move.l  $50(a5),$18(a5)
                move.l  $54(a5),$1C(a5)
locret_2B2EE:                                           ; CODE XREF: Enemy_HomingProjectileMain+32   j
                                        ; Enemy_HomingProjectileMain+7C   j
                rts
; ---------------------------------------------------------------------------
loc_2B2F0:                                              ; CODE XREF: Enemy_HomingProjectileMain+2C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B306
                btst    #7,$22(a5)
                beq.s   loc_2B30E
                btst    #4,$22(a5)
                beq.s   loc_2B316
loc_2B306:                                              ; CODE XREF: Enemy_HomingProjectileMain+5C   j
                jsr     (Pickup_SpawnSmallFromCurrentObject).l
                bra.s   loc_2B31C
; ---------------------------------------------------------------------------
loc_2B30E:                                              ; CODE XREF: Enemy_HomingProjectileMain+64   j
                jsr     (Collision_CheckProjectileTile).l
                beq.s   locret_2B2EE
loc_2B316:                                              ; CODE XREF: Enemy_HomingProjectileMain+6C   j
                bset    #4,2(a5)
loc_2B31C:                                              ; CODE XREF: Enemy_HomingProjectileMain+74   j
                jsr     (Projectile_FindFreeSlot).l
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
                movea.l #Weapon_ImpactSpriteFrames,a1
                bra.w   Sprite_InitFromTable
; End of function Enemy_HomingProjectileMain
; Spawns bullet for Jetsripper boss with calculated velocity
Boss_JetsripperSpawnBullet:                             ; DATA XREF: ROM:0002AFDA   o  ; was: sub_2B352
                moveq   #9,d7
                tst.w   (word_FFFF0E).w
                beq.s   loc_2B35C
                moveq   #$A,d7
loc_2B35C:                                              ; CODE XREF: Boss_JetsripperSpawnBullet+6   j
                move.w  #$148,(a0)
                move.w  #$ED00,2(a0)
                clr.w   4(a0)
                move.w  #$32,$26(a0)                    ; '2'
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
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d6.w),d1
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
Projectile_BulletWithDelayedPhysics:                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B3E4
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bmi.s   loc_2B404
                cmpi.w  #$1D0,$10(a5)
                bpl.s   loc_2B404
                cmpi.w  #$A8,$14(a5)
                bmi.s   loc_2B404
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_2B40C
loc_2B404:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+6   j
                                        ; Projectile_BulletWithDelayedPhysics+E   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B40C:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+1E   j
                tst.w   4(a5)
                bne.s   loc_2B43C
                subq.w  #1,$48(a5)
                bpl.s   locret_2B43A
                addq.w  #2,4(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #off_E9788,8(a5)
                clr.w   $C(a5)
                move.l  $50(a5),$18(a5)
                move.l  $54(a5),$1C(a5)
locret_2B43A:                                           ; CODE XREF: Projectile_BulletWithDelayedPhysics+32   j
                                        ; Projectile_BulletWithDelayedPhysics+7C   j
                rts
; ---------------------------------------------------------------------------
loc_2B43C:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+2C   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B452
                btst    #7,$22(a5)
                beq.s   loc_2B45A
                btst    #4,$22(a5)
                beq.s   loc_2B462
loc_2B452:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+5C   j
                jsr     (Pickup_SpawnSmallFromCurrentObject).l
                bra.s   loc_2B468
; ---------------------------------------------------------------------------
loc_2B45A:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+64   j
                jsr     (Collision_CheckProjectileTile).l
                beq.s   locret_2B43A
loc_2B462:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+6C   j
                bset    #4,2(a5)
loc_2B468:                                              ; CODE XREF: Projectile_BulletWithDelayedPhysics+74   j
                jsr     (Projectile_FindFreeSlot).l
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
                movea.l #Weapon_ImpactSpriteFrames,a1
                bra.w   Sprite_InitFromTable
; End of function Projectile_BulletWithDelayedPhysics
; Updates boss sprite graphics
Boss_DestroyerMK2UpdateSprite:                          ; CODE XREF: Boss_DestroyerMK2PlaySFX+18   p  ; was: sub_2B49E
                                        ; Boss_DestroyerMK2DefeatLaserEffect+46   p
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_2B4B4
                move.w  d3,$10(a0)
                move.w  d4,$14(a0)
                movea.l off_2B4B6(pc,d1.w),a4
                bra.s   loc_2B4C4
; ---------------------------------------------------------------------------
locret_2B4B4:                                           ; CODE XREF: Boss_DestroyerMK2UpdateSprite+6   j
                rts
; End of function Boss_DestroyerMK2UpdateSprite
; ---------------------------------------------------------------------------
off_2B4B6:      dc.l    stru_2B526                      ; DATA XREF: Boss_DestroyerMK2UpdateSprite+10   r
                dc.l    stru_2B534

; Initializes projectile with angle calculation and directional velocity
Enemy_InitDirectionalProjectile:                        ; CODE XREF: Enemy_SpawnDifficultyProjectilePattern+1E   p  ; was: sub_2B4BE
                                        ; Enemy_BossProjectileMovement+3A   p
                lea     stru_2B526(pc),a4
                nop
loc_2B4C4:                                              ; CODE XREF: Boss_DestroyerMK2UpdateSprite+14   j
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
                jsr     (Math_CalculateAngleBetween).l
                move.w  d2,d6
loc_2B50A:                                              ; CODE XREF: Enemy_InitDirectionalProjectile+42   j
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d6.w),d0
                move.w  (a1,d6.w),d1
                muls.w  d7,d0
                muls.w  d7,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                rts
; End of function Enemy_InitDirectionalProjectile
; ---------------------------------------------------------------------------
stru_2B526:     dc.w    $37                             ; field_0
                                        ; DATA XREF: ROM:off_2B4B6   o
                                        ; sub_2B4BE   o
                dc.w    9                               ; field_2
                dc.l    off_E9604                       ; field_4
                dc.l    off_E96E0                       ; field_8
                dc.w    0                               ; field_C
stru_2B534:     dc.w    $38                             ; field_0
                                        ; DATA XREF: ROM:0002B4BA   o
                dc.w    $A                              ; field_2
                dc.l    off_E9604                       ; field_4
                dc.l    off_E96E0                       ; field_8
                dc.w    1                               ; field_C

; Bouncing enemy projectile with screen bounds check
Enemy_BouncingProjectile:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B542
                tst.w   4(a5)
                bne.s   loc_2B56C
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_2B56A
                addq.w  #2,4(a5)
                move.w  #$ED80,2(a5)
                move.l  $50(a5),8(a5)
                clr.w   $C(a5)
                move.b  #$40,$21(a5)                    ; '@'
locret_2B56A:                                           ; CODE XREF: Enemy_BouncingProjectile+C   j
                                        ; Enemy_BouncingProjectile+88   j
                rts
; ---------------------------------------------------------------------------
loc_2B56C:                                              ; CODE XREF: Enemy_BouncingProjectile+4   j
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
loc_2B59A:                                              ; CODE XREF: Enemy_BouncingProjectile+3C   j
                                        ; Enemy_BouncingProjectile+46   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B5A2:                                              ; CODE XREF: Enemy_BouncingProjectile+56   j
                tst.w   (word_FF808C).w
                bpl.s   loc_2B5B8
                btst    #7,$22(a5)
                beq.s   loc_2B5C0
                btst    #4,$22(a5)
                beq.s   loc_2B5CC
loc_2B5B8:                                              ; CODE XREF: Enemy_BouncingProjectile+64   j
                jsr     (Pickup_SpawnSmallFromCurrentObject).l
                bra.s   loc_2B5D2
; ---------------------------------------------------------------------------
loc_2B5C0:                                              ; CODE XREF: Enemy_BouncingProjectile+6C   j
                jsr     (Collision_GetEntityPosition).l
                cmpi.w  #4,d2
                bmi.s   locret_2B56A
loc_2B5CC:                                              ; CODE XREF: Enemy_BouncingProjectile+74   j
                bset    #4,2(a5)
loc_2B5D2:                                              ; CODE XREF: Enemy_BouncingProjectile+7C   j
                jsr     (Projectile_FindFreeSlot).l
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
                jmp     Sprite_InitType160
; End of function Enemy_BouncingProjectile
; Spawns animated projectile from enemy with random animation offset
Enemy_SpawnAnimatedProjectile:                          ; CODE XREF: Boss_TerobusterSpawnMultiDirectional+52   p  ; was: sub_2B60C
                move.w  #$54,(a0)                       ; 'T'
                move.w  #$8D40,2(a0)
                move.l  #Enemy_AnimatedProjectileSpriteFrames,$48(a0)
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
Projectile_BouncingWithGravity:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B652
                cmpi.w  #$80,$14(a5)
                bmi.s   loc_2B662
                cmpi.w  #$15C,$14(a5)
                bmi.s   loc_2B66A
loc_2B662:                                              ; CODE XREF: Projectile_BouncingWithGravity+6   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B66A:                                              ; CODE XREF: Projectile_BouncingWithGravity+E   j
                tst.w   $5E(a5)
                bne.s   loc_2B6A4
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                jsr     (Collision_CheckTerrainTile).l
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
loc_2B6A0:                                              ; CODE XREF: Projectile_BouncingWithGravity+4A   j
                move.l  d0,$18(a5)
loc_2B6A4:                                              ; CODE XREF: Projectile_BouncingWithGravity+1C   j
                                        ; Projectile_BouncingWithGravity+2C   j
                bsr.w   Anim_UpdateLoopingScript
                addi.l  #$8000,$1C(a5)
                rts
; End of function Projectile_BouncingWithGravity
; Laser projectile
