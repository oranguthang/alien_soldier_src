; Select one of four projectile mappings from the quantized launch angle
Projectile_SelectWolfGaropaDirectionMapping:            ; CODE XREF: Boss_WolfGaropaSpawnOrbProjectilePair+D4   j  ; was: sub_2B6B2
                addi.w  #$20,d2                         ; ' '
                andi.w  #$C0,d2
                asr.w   #4,d2
                move.l  off_2B6C4(pc,d2.w),8(a0)
                rts
; End of function Projectile_SelectWolfGaropaDirectionMapping
; ---------------------------------------------------------------------------
off_2B6C4:      dc.l    SharedCombatSpriteFrame10       ; DATA XREF: Projectile_SelectWolfGaropaDirectionMapping+A   r
                dc.l    SharedCombatSpriteFrame11
                dc.l    SharedCombatSpriteFrame09
                dc.l    SharedCombatSpriteFrame12

; Main update routine for Jetsripper boss
Boss_JetsripperMain:                                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B6D4
                tst.w   4(a5)
                bne.w   loc_2B70E
                move.w  $14(a5),$48(a5)
                addq.w  #2,4(a5)
                move.w  #$E300,2(a5)
                move.l  #SharedCombatSpriteAnimation22,8(a5)
                move.w  #$C80,d0
                btst    #1,$5F(a5)
                beq.s   loc_2B704
                bset    #$C,d0
loc_2B704:                                              ; CODE XREF: Boss_JetsripperMain+2A   j
                move.w  d0,$E(a5)
                move.b  #$10,$20(a5)
loc_2B70E:                                              ; CODE XREF: Boss_JetsripperMain+4   j
                btst    #0,$5F(a5)
                beq.s   loc_2B72E
                move.w  (word_FFA000).w,d0
                asr.w   #2,d0
                andi.w  #3,d0
                move.b  byte_2B778(pc,d0.w),d0
                ext.w   d0
                add.w   $48(a5),d0
                move.w  d0,$14(a5)
loc_2B72E:                                              ; CODE XREF: Boss_JetsripperMain+40   j
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$10,d0
                bpl.s   locret_2B776
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   Boss_SpawnPeriodicProjectile
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_SpawnPeriodicProjectile
                jsr     (Pickup_SpawnLarge).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; Spawns periodic projectile for boss with timer check
Boss_SpawnPeriodicProjectile:                           ; CODE XREF: Boss_JetsripperMain+6E   j  ; was: loc_2B75E
                                        ; Boss_JetsripperMain+76   j
                move.w  #$9C,$26(a5)
                jsr     (Boss_JetsripperInitC4Projectile).l
                btst    #0,$5F(a5)
                beq.s   locret_2B776
                clr.l   $1C(a5)
locret_2B776:                                           ; CODE XREF: Boss_JetsripperMain+64   j
                                        ; Boss_JetsripperMain+9C   j
                rts
; End of function Boss_JetsripperMain
; ---------------------------------------------------------------------------
byte_2B778:     dc.b    $FF, 0, 1, 0                    ; DATA XREF: Boss_JetsripperMain+4C   r

; Initializes enemy projectile type and flags
Enemy_InitProjectileType:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B77C
                tst.w   4(a5)
                bne.w   loc_2B7BA
                move.w  $14(a5),$48(a5)
                addq.w  #2,4(a5)
                move.w  #$8F00,2(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$FC04FC04,$2C(a5)
                move.w  #$C4C8,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.b  #$10,$20(a5)
loc_2B7BA:                                              ; CODE XREF: Enemy_InitProjectileType+4   j
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
                jmp     Projectile_FragmentBeginDeflectedFall
; ---------------------------------------------------------------------------
loc_2B7EA:                                              ; CODE XREF: Enemy_InitProjectileType+5C   j
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$C,d0
                bpl.s   locret_2B806
loc_2B7F6:                                              ; CODE XREF: Enemy_InitProjectileType+64   j
                move.w  #$64,$26(a5)                    ; 'd'
                jsr     (Effect_InitSharedExplosionFromCurrent).l
                clr.l   $1C(a5)
locret_2B806:                                           ; CODE XREF: Enemy_InitProjectileType+78   j
                rts
; End of function Enemy_InitProjectileType
; ---------------------------------------------------------------------------
byte_2B808:     dc.b    $FF, 0, 1, 0                    ; DATA XREF: Enemy_InitProjectileType+48   r

; Spawns projectile with trajectory calculation towards player position
Boss_SpawnTargetedProjectile:                           ; CODE XREF: Enemy_UpdatePeriodicShots+1E   p  ; was: sub_2B80C
                jsr     (Projectile_FindFreePrimarySlot).l
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
                move.b  #$20,$20(a0)                    ; ' '
                move.w  #$64,$26(a0)                    ; 'd'
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FC04FC04,$2C(a0)
                movea.w a0,a1
                jsr     (Physics_GetPlayerDelta).l
                moveq   #0,d0
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #8,d0
                swap    d0
                asr.l   #1,d0
                tst.w   d1
                bmi.s   Projectile_SetHorizontalVelocity
                neg.l   d0
; Sets projectile horizontal velocity based on angle calculation
Projectile_SetHorizontalVelocity:                       ; CODE XREF: Boss_SpawnTargetedProjectile+68   j  ; was: loc_2B878
                move.l  d0,$18(a1)
                move.w  #$FFFA,$1C(a1)
                move.w  (dword_FFFF08).w,$1E(a1)
locret_2B888:                                           ; CODE XREF: Boss_SpawnTargetedProjectile+6   j
                rts
; End of function Boss_SpawnTargetedProjectile
; Projectile with gravity physics deflection and ground bounce
Projectile_GravityBounce:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B88A
                addi.l  #$3000,$1C(a5)
                btst    #7,$22(a5)
                beq.s   loc_2B8AA
                btst    #4,$22(a5)
                beq.w   loc_2B8C0
                jmp     Projectile_FragmentBeginDeflectedFall
; ---------------------------------------------------------------------------
loc_2B8AA:                                              ; CODE XREF: Projectile_GravityBounce+E   j
                jsr     (Collision_GetEntityPosition).l
                beq.s   locret_2B8BE
                cmpi.w  #2,d2
                bne.s   loc_2B8C0
                tst.l   $1C(a5)
                bpl.s   loc_2B8C0
locret_2B8BE:                                           ; CODE XREF: Projectile_GravityBounce+26   j
                rts
; ---------------------------------------------------------------------------
loc_2B8C0:                                              ; CODE XREF: Projectile_GravityBounce+16   j
                                        ; Projectile_GravityBounce+2C   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  #$FFFEC000,$1C(a5)
                move.l  #SharedCombatSpriteAnimation00,8(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Projectile_GravityBounce
; Spawns falling debris projectile with gravity and horizontal velocity
Projectile_SpawnFallingDebris:                          ; CODE XREF: Enemy_ProjectileAttackGroundState:Enemy_ProjectileAttackGroundState_SpawnProjectile   p  ; was: sub_2B8E0
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2B93C
                add.w   $10(a5),d5
                add.w   $14(a5),d6
                move.w  d5,$10(a0)
                move.w  d6,$14(a0)
                move.w  #$1D0,(a0)
                move.w  #$EF00,2(a0)
                move.w  #$C80,$E(a0)
                move.l  #SharedCombatSpriteAnimation22,8(a0)
                move.b  #$3C,$20(a0)                    ; '<'
                move.w  #$18,$26(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$80,$23(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  d7,$18(a0)
                move.l  #$FFFFA000,$1C(a0)
locret_2B93C:                                           ; CODE XREF: Projectile_SpawnFallingDebris+6   j
                rts
; End of function Projectile_SpawnFallingDebris
; Spawns trailing explosion particles while projectile moves
Enemy_TrailingExplosionSpawner:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B93E
                addq.w  #1,$48(a5)
                move.w  $48(a5),d0
                andi.w  #3,d0
                bne.s   loc_2B990
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_2B990
                move.l  #SharedCombatSpriteAnimation08,8(a0)
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
                jsr     (Effect_SpawnExplosionType188).l
loc_2B990:                                              ; CODE XREF: Enemy_TrailingExplosionSpawner+C   j
                                        ; Enemy_TrailingExplosionSpawner+14   j
                addi.l  #$3800,$1C(a5)
                btst    #7,$22(a5)
                bne.s   loc_2B9AA
                jsr     (Collision_GetEntityPosition).l
                bne.s   loc_2B9AA
                rts
; ---------------------------------------------------------------------------
loc_2B9AA:                                              ; CODE XREF: Enemy_TrailingExplosionSpawner+60   j
                                        ; Enemy_TrailingExplosionSpawner+68   j
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #SharedCombatSpriteAnimation05,8(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Enemy_TrailingExplosionSpawner
; Spawns falling hazard projectiles from top of screen at intervals
Enemy_SpawnFallingHazard:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2B9C4
                tst.w   (word_FF808C).w
                bmi.s   loc_2B9D2
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_2B9D2:                                              ; CODE XREF: Enemy_SpawnFallingHazard+4   j
                subq.w  #1,$48(a5)
                bpl.s   locret_2BA56
                lea     word_2BA58(pc),a0
                nop
                move.w  (DifficultyMode).w,d1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                add.w   (a0,d1.w),d0
                move.w  d0,$48(a5)
                jsr     (Sprite_FindFreeEffectSlot).l
                bne.s   locret_2BA56
                move.w  #$108,(a0)
                move.w  #$8F80,2(a0)
                move.w  #$C4C8,$E(a0)
                move.w  #$500,8(a0)
                move.w  #$F8F8,$A(a0)
                move.b  #$10,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FC04FC04,$28(a0)
                move.w  #$64,$26(a0)                    ; 'd'
                move.l  #$FFFF6000,$18(a0)
                move.w  #3,$1C(a0)
                move.w  #$A0,$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                moveq   #0,d0
locret_2BA56:                                           ; CODE XREF: Enemy_SpawnFallingHazard+12   j
                                        ; Enemy_SpawnFallingHazard+34   j
                rts
; End of function Enemy_SpawnFallingHazard
; ---------------------------------------------------------------------------
word_2BA58:     dc.w    $40, $28, $10                   ; DATA XREF: Enemy_SpawnFallingHazard+14   o

; Handles projectile collision with terrain changing state or destroying
Projectile_TerrainCollision:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2BA5E
                tst.w   (word_FF808C).w
                bmi.s   loc_2BA7A
loc_2BA64:                                              ; CODE XREF: Projectile_TerrainCollision+4A   j
                move.l  #SharedCombatSpriteAnimation02,8(a5)
                move.l  #$FFFF0000,$1C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
loc_2BA7A:                                              ; CODE XREF: Projectile_TerrainCollision+4   j
                jsr     (Collision_GetEntityPosition).l
                beq.s   loc_2BA9A
                clr.l   $18(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.w  #$62,$26(a5)                    ; 'b'
                jmp     Effect_InitSharedExplosionFromCurrent
; ---------------------------------------------------------------------------
loc_2BA9A:                                              ; CODE XREF: Projectile_TerrainCollision+22   j
                btst    #7,$22(a5)
                beq.s   locret_2BAB2
                btst    #4,$22(a5)
                beq.w   loc_2BA64
                jmp     Projectile_FragmentBeginDeflectedFall
; ---------------------------------------------------------------------------
locret_2BAB2:                                           ; CODE XREF: Projectile_TerrainCollision+42   j
                rts
; End of function Projectile_TerrainCollision
; Initializes destruction particle sprite properties
