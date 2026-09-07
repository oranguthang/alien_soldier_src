; Computes the muzzle position and dispatches the selected weapon handler
Weapon_UpdatePlayerFiring:                              ; CODE XREF: Player_PrepareSpriteRendering+42   j  ; was: sub_17ED8
                moveq   #0,d6
                move.b  $9E(a5),d6
                move.b  (a4,d6.w),d1
                move.b  8(a4,d6.w),d2
                ext.w   d1
                ext.w   d2
                btst    #3,$E(a5)
                beq.s   Weapon_UpdatePlayerFiring_ApplyMuzzleOffset
                neg.w   d1
Weapon_UpdatePlayerFiring_ApplyMuzzleOffset:            ; CODE XREF: Weapon_UpdatePlayerFiring+18   j  ; was: loc_17EF4
                add.w   $10(a5),d1
                add.w   $14(a5),d2
                move.b  Weapon_DirectionIndexTable(pc,d6.w),d6
                movea.w (word_FFA24E).w,a4
                adda.w  #$A250,a4
                tst.w   $10(a4)
                beq.s   Weapon_DispatchSelectedType
                bset    #2,(byte_FF8244).w
; Dispatches the handler selected by the current weapon type
Weapon_DispatchSelectedType:                            ; CODE XREF: Weapon_UpdatePlayerFiring+34   j  ; was: loc_17F14
                move.w  (word_FFA21C).w,d0
                movea.w Weapon_FireHandlerOffsets(pc,d0.w),a0
                adda.l  #Weapon_DirectionIndexTable,a0
                jmp     (a0)
; End of function Weapon_UpdatePlayerFiring
; ---------------------------------------------------------------------------
Weapon_FireHandlerOffsets:  dc.w    Weapon_FireNoOp-Weapon_DirectionIndexTable  ; was: off_17F24
                                        ; DATA XREF: Weapon_UpdatePlayerFiring+40   r
                dc.w    Weapon_FireProjectile-Weapon_DirectionIndexTable
                dc.w    Weapon_FireMultipleShots-Weapon_DirectionIndexTable
                dc.w    Weapon_FireBulletHandler-Weapon_DirectionIndexTable
                dc.w    Weapon_FireBeamWeapon-Weapon_DirectionIndexTable
                dc.w    Weapon_FireHomingShot-Weapon_DirectionIndexTable
                dc.w    Player_SpawnCircleAttack-Weapon_DirectionIndexTable
                dc.w    Weapon_FireNoOp-Weapon_DirectionIndexTable
                dc.w    Weapon_FireNoOp-Weapon_DirectionIndexTable
                dc.w    Weapon_FireNoOp-Weapon_DirectionIndexTable
                dc.w    Weapon_FireNoOp-Weapon_DirectionIndexTable
Weapon_DirectionIndexTable: dc.b    0, 1, 2, 3, 4, 5, 6, 7  ; was: byte_17F3A
                                        ; DATA XREF: Weapon_UpdatePlayerFiring+24   r
                                        ; Weapon_UpdatePlayerFiring+44   o

; Fires weapon projectile with damage calculation and ammo depletion
Weapon_FireProjectile:                                  ; DATA XREF: ROM:00017F26   o  ; was: sub_17F42
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.s   Weapon_FireProjectile_Return
                move.w  #2,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
Weapon_FireProjectile_FindSlot:                         ; CODE XREF: Weapon_FireProjectile+22   j  ; was: loc_17F5C
                tst.w   (a0)
                beq.s   Weapon_FireProjectile_Initialize
                lea     $60(a0),a0
                dbf     d7,Weapon_FireProjectile_FindSlot
Weapon_FireProjectile_Return:                           ; CODE XREF: Weapon_FireProjectile+C   j  ; was: locret_17F68
                rts
; ---------------------------------------------------------------------------
Weapon_FireProjectile_Initialize:                       ; CODE XREF: Weapon_FireProjectile+1C   j  ; was: loc_17F6A
                move.w  #$80,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   Weapon_FireProjectile_SelectAmmoCost
                subq.w  #2,$10(a4)
Weapon_FireProjectile_SelectAmmoCost:                   ; CODE XREF: Weapon_FireProjectile+3E   j  ; was: loc_17F86
                move.w  #2,d0
                tst.b   (word_FFFF0E).w
                bne.s   Weapon_FireProjectile_SubtractAmmo
                move.w  #1,d0
Weapon_FireProjectile_SubtractAmmo:                     ; CODE XREF: Weapon_FireProjectile+4C   j  ; was: loc_17F94
                sub.w   d0,$10(a4)
                bpl.s   Weapon_FireProjectile_SetupObject
                clr.w   $10(a4)
Weapon_FireProjectile_SetupObject:                      ; CODE XREF: Weapon_FireProjectile+56   j  ; was: loc_17F9E
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$268,(a0)
                move.l  #Weapon_InitProjectileSprite,$48(a0)
                move.l  #Weapon_ProjectileSpriteFrames,$54(a0)
                move.w  #$8C80,2(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_FireProjectile_SetDamageAndVelocity
                move.w  #4,$26(a0)
Weapon_FireProjectile_SetDamageAndVelocity:             ; CODE XREF: Weapon_FireProjectile+88   j  ; was: loc_17FD2
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  (dword_FF802C).w,$5E(a0)
                movea.l #Weapon_DirectionTableOffsets,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6                         ; '|'
                movea.l #dword_19812,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$4C(a0)
                move.l  (dword_FF8240).w,d0
                asl.l   #2,d0
                add.l   d0,d1
                move.l  d1,$50(a0)
                addq.w  #8,d6
                andi.w  #$70,d6                         ; 'p'
                asr.w   #3,d6
                move.w  d6,$5C(a0)
                move.b  #$B5,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Weapon_FireProjectile
; Initializes projectile sprite properties including tiles and velocity
Weapon_InitProjectileSprite:                            ; DATA XREF: Weapon_FireProjectile+68   o  ; was: sub_18026
                move.w  #$14,(a5)
                move.w  #$8C80,2(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.b  #1,$23(a5)
                move.w  $5C(a5),d6
                move.w  Weapon_ProjectileSpriteTiles(pc,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  Weapon_ProjectileSpriteSizes(pc,d6.w),8(a5)
                move.w  Weapon_ProjectileSpriteOffsets(pc,d6.w),$A(a5)
                bra.w   Weapon_InitProjectileCompanion
; End of function Weapon_InitProjectileSprite
; ---------------------------------------------------------------------------
Weapon_ProjectileSpriteTiles:   dc.w    $4DA8, $4DB0    ; DATA XREF: Weapon_InitProjectileSprite+1A   r  ; was: word_1805C
                                        ; sub_1898E:Effect_UpdateKnockbackParticle_InitImpact   o
                dc.w    $45A0, $45B0
                dc.w    $45A8, $55B0
                dc.w    $55A0, $5DB0
Weapon_ProjectileSpriteSizes:   dc.w    $D00, $A00      ; DATA XREF: Weapon_InitProjectileSprite+26   r  ; was: word_1806C
                dc.w    $700, $A00
                dc.w    $D00, $A00
                dc.w    $700, $A00
Weapon_ProjectileSpriteOffsets: dc.w    $F0F8, $F4F4    ; DATA XREF: Weapon_InitProjectileSprite+2C   r  ; was: word_1807C
                dc.w    $F8F0, $F4F4
                dc.w    $F0F8, $F4F4
                dc.w    $F8F0, $F4F4

; Spawns homing projectile effect
Weapon_SpawnHomingEffect:
                tst.w   (word_FF8238).w                 ; was: sub_1808C
                bpl.s   Weapon_SpawnHomingEffect_Return
                move.w  #2,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
Weapon_SpawnHomingEffect_FindSlot:                      ; CODE XREF: Weapon_SpawnHomingEffect+1A   j  ; was: loc_1809E
                move.w  (a0),d0
                beq.s   Weapon_SpawnHomingEffect_Initialize
                lea     $60(a0),a0
                dbf     d7,Weapon_SpawnHomingEffect_FindSlot
Weapon_SpawnHomingEffect_Return:                        ; CODE XREF: Weapon_SpawnHomingEffect+4   j  ; was: locret_180AA
                rts
; ---------------------------------------------------------------------------
Weapon_SpawnHomingEffect_Initialize:                    ; CODE XREF: Weapon_SpawnHomingEffect+14   j  ; was: loc_180AC
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d1
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$124,(a0)
                move.w  #$8C80,2(a0)
                move.w  #$16,$48(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$81,$23(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                movea.l #Weapon_DirectionTableOffsets,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6                         ; '|'
                lea     dword_19772(pc),a1
                nop
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                addq.w  #8,d6
                andi.w  #$70,d6                         ; 'p'
                asr.w   #3,d6
                lea     Weapon_HomingEffectSpriteData(pc),a1
                nop
                move.w  (a1,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.w  $10(a1,d6.w),8(a0)
                move.w  $20(a1,d6.w),$A(a0)
                movea.w #(byte_FFC2C0-M68K_RAM),a1
                moveq   #2,d7
Weapon_SpawnHomingEffect_FindCompanion:                 ; CODE XREF: Weapon_SpawnHomingEffect+BE   j  ; was: loc_18142
                tst.w   (a1)
                beq.s   Weapon_SpawnHomingEffect_InitializeCompanion
                lea     $60(a1),a1
                dbf     d7,Weapon_SpawnHomingEffect_FindCompanion
                rts
; ---------------------------------------------------------------------------
Weapon_SpawnHomingEffect_InitializeCompanion:           ; CODE XREF: Weapon_SpawnHomingEffect+B8   j  ; was: loc_18150
                move.l  $18(a0),d0
                asr.l   #2,d0
                move.l  d0,$18(a1)
                move.l  $1C(a0),d0
                asr.l   #2,d0
                move.l  d0,$1C(a1)
                move.l  #off_E9698,8(a1)
                move.w  $10(a0),$10(a1)
                move.w  $14(a0),$14(a1)
                movea.w a1,a0
                jsr     (Effect_SpawnExplosionType188).l
                move.w  #$EC00,2(a0)
                move.w  #8,$48(a0)
                rts
; End of function Weapon_SpawnHomingEffect
; ---------------------------------------------------------------------------
Weapon_HomingEffectSpriteData:  dc.w    $457E, $5580, $557C, $5D80, $4D7E, $4D80, $457C, $4580  ; was: word_1818E
                                        ; DATA XREF: Weapon_SpawnHomingEffect+92   o
                                        ; Weapon_HandleProjectileHit+44   o
                dc.w    $400, $500, $100, $500, $400, $500, $100, $500
                dc.w    $F8FC, $F8F8, $FCF8, $F8F8, $F8FC, $F8F8, $FCF8, $F8F8

; Fires multiple projectile shots in spread pattern
Weapon_FireMultipleShots:                               ; DATA XREF: ROM:00017F28   o  ; was: sub_181BE
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.w   Weapon_InitSpreadShot_Return
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                moveq   #0,d3
                moveq   #7,d7
Weapon_FireMultipleShots_ScanSlots:                     ; CODE XREF: Weapon_FireMultipleShots+28   j  ; was: loc_181DA
                tst.w   (a0)
                bne.s   Weapon_FireMultipleShots_NextSlot
                move.w  a0,(a1)+
                addq.w  #1,d3
Weapon_FireMultipleShots_NextSlot:                      ; CODE XREF: Weapon_FireMultipleShots+1E   j  ; was: loc_181E2
                lea     $60(a0),a0
                dbf     d7,Weapon_FireMultipleShots_ScanSlots
                tst.w   d3
                beq.w   Weapon_InitSpreadShot_Return
                move.b  #$BF,d0
                jsr     (Sound_PlaySFX).l
                movea.w #(dword_FFA100-M68K_RAM),a3
                lea     Weapon_DirectionTableOffsets(pc),a1
                nop
                lea     dword_19632(pc),a2
                nop
                move.b  (a1,d6.w),d6
                cmpi.w  #4,d3
                bpl.w   Weapon_FireFourShotSpread
                rts
; End of function Weapon_FireMultipleShots
; Consumes ammo for spread shot
Weapon_ConsumeAmmoForSpread:
                move.w  #$80,(word_FF8140).w            ; was: sub_18218
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                move.w  #2,(word_FF8238).w
                subi.w  #$12,$10(a4)
                bpl.s   Weapon_InitSpreadShot
                clr.w   $10(a4)
; End of function Weapon_ConsumeAmmoForSpread
; Initializes single shot in spread fire pattern with velocity
Weapon_InitSpreadShot:                                  ; CODE XREF: Weapon_ConsumeAmmoForSpread+1E   j  ; was: sub_1823C
                                        ; Weapon_FireFourShotSpread+48   p
                movea.w (a3)+,a0
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$268,(a0)
                move.l  #Weapon_InitSpreadProjectileState,$48(a0)
                move.l  #Weapon_SpreadShotInitialSpriteFrame,$54(a0)
                move.w  #$8C80,2(a0)
                clr.b   $21(a0)
                move.w  #1,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_InitSpreadShot_SetVelocity
                move.w  #2,$26(a0)
Weapon_InitSpreadShot_SetVelocity:                      ; CODE XREF: Weapon_InitSpreadShot+32   j  ; was: loc_18276
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.l  (a2,d6.w),d3
                move.l  $20(a2,d6.w),d4
                move.l  d3,$4C(a0)
                move.l  (dword_FF8240).w,d5
                asl.l   #2,d5
                add.l   d4,d5
                move.l  d5,$50(a0)
                asl.l   #1,d3
                asl.l   #1,d4
                add.l   d3,$14(a0)
                add.l   d4,$10(a0)
                neg.l   d3
                neg.l   d4
                asr.l   #3,d3
                asr.l   #3,d4
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.w  #$20,$5E(a0)                    ; ' '
Weapon_InitSpreadShot_Return:                           ; CODE XREF: Weapon_FireMultipleShots+C   j  ; was: locret_182BA
                                        ; Weapon_FireMultipleShots+2E   j
                rts
; End of function Weapon_InitSpreadShot
; Fires four projectiles in spread pattern with ammo depletion
Weapon_FireFourShotSpread:                              ; CODE XREF: Weapon_FireMultipleShots+54   j  ; was: sub_182BC
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   Weapon_FireFourShotSpread_SelectAmmoCost
                subq.w  #8,$10(a4)
Weapon_FireFourShotSpread_SelectAmmoCost:               ; CODE XREF: Weapon_FireFourShotSpread+16   j  ; was: loc_182D8
                move.w  #4,(word_FF8238).w
                move.w  #$14,d0
                tst.b   (word_FFFF0E).w
                bne.s   Weapon_FireFourShotSpread_SubtractAmmo
                move.w  #$12,d0
Weapon_FireFourShotSpread_SubtractAmmo:                 ; CODE XREF: Weapon_FireFourShotSpread+2A   j  ; was: loc_182EC
                sub.w   d0,$10(a4)
                bpl.s   Weapon_FireFourShotSpread_SetupLoop
                clr.w   $10(a4)
Weapon_FireFourShotSpread_SetupLoop:                    ; CODE XREF: Weapon_FireFourShotSpread+34   j  ; was: loc_182F6
                subi.w  #$14,d6
                moveq   #3,d7
Weapon_FireFourShotSpread_SpawnLoop:                    ; CODE XREF: Weapon_FireFourShotSpread+4C   j  ; was: loc_182FC
                addi.w  #8,d6
                andi.w  #$7C,d6                         ; '|'
                bsr.w   Weapon_InitSpreadShot
                dbf     d7,Weapon_FireFourShotSpread_SpawnLoop
                rts
; End of function Weapon_FireFourShotSpread
; Initializes the spread projectile object type and display state
Weapon_InitSpreadProjectileState:                       ; DATA XREF: Weapon_InitSpreadShot+E   o  ; was: sub_1830E
                move.w  #$22C,(a5)
                move.w  #$8C80,2(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.b  #1,$23(a5)
                rts
; End of function Weapon_InitSpreadProjectileState
Weapon_EmptySpreadProjectileHandler:                    ; was: nullsub_46
                rts
; End of function Weapon_EmptySpreadProjectileHandler

; Handles player bullet firing with ammo check
Weapon_FireBulletHandler:                               ; DATA XREF: ROM:00017F2A   o  ; was: sub_18328
                btst    #7,(byte_FF8245).w
                bne.w   Effect_SpawnRandomDebris
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #8,(byte_FF8143).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
Weapon_FireBulletHandler_FindSlot:                      ; CODE XREF: Weapon_FireBulletHandler+32   j  ; was: loc_18352
                move.w  (a0),d0
                beq.s   Weapon_FireBulletHandler_Initialize
                lea     $60(a0),a0
                dbf     d7,Weapon_FireBulletHandler_FindSlot
                rts
; ---------------------------------------------------------------------------
Weapon_FireBulletHandler_Initialize:                    ; CODE XREF: Weapon_FireBulletHandler+2C   j  ; was: loc_18360
                tst.w   (word_FFA22A).w
                bne.s   Weapon_FireBulletHandler_SelectAmmoCost
                subq.w  #2,$10(a4)
Weapon_FireBulletHandler_SelectAmmoCost:                ; CODE XREF: Weapon_FireBulletHandler+3C   j  ; was: loc_1836A
                move.w  #4,d0
                tst.b   (word_FFFF0E).w
                bne.s   Weapon_FireBulletHandler_SubtractAmmo
                move.w  #3,d0
Weapon_FireBulletHandler_SubtractAmmo:                  ; CODE XREF: Weapon_FireBulletHandler+4A   j  ; was: loc_18378
                sub.w   d0,$10(a4)
                bpl.s   Weapon_FireBulletHandler_SetupObject
                clr.w   $10(a4)
Weapon_FireBulletHandler_SetupObject:                   ; CODE XREF: Weapon_FireBulletHandler+54   j  ; was: loc_18382
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$18,(a0)
                move.w  #$8C80,2(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #8,$23(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_FireBulletHandler_SetDamage
                move.w  #4,$26(a0)
Weapon_FireBulletHandler_SetDamage:                     ; CODE XREF: Weapon_FireBulletHandler+82   j  ; was: loc_183B2
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$10,$48(a0)
                movea.l #Weapon_DirectionTableOffsets,a1
                moveq   #0,d5
                move.b  (a1,d6.w),d5
                movea.l (dword_FF802C).w,a1
                move.l  (a1,d5.w),d1
                move.l  $20(a1,d5.w),d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.w  d5,$56(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   Weapon_FireBulletHandler_Return
                move.b  #$EB,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Weapon_FireBulletHandler_Return:                        ; CODE XREF: Weapon_FireBulletHandler+C6   j  ; was: locret_183FA
                rts
; End of function Weapon_FireBulletHandler
Weapon_EmptyBulletCompanionHandler:                     ; was: nullsub_47
                rts
; End of function Weapon_EmptyBulletCompanionHandler

; Fires beam weapon with continuous fire and ammo consumption
Weapon_FireBeamWeapon:                                  ; DATA XREF: ROM:00017F2C   o  ; was: sub_183FE
                btst    #7,(byte_FF8245).w
                bne.w   Effect_SpawnRandomDebris
                tst.w   $10(a4)
                beq.w   Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #$C,(byte_FF8143).w
                tst.w   (word_FF8238).w
                bpl.w   Weapon_FireBeamWeapon_Return
                move.w  #1,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
Weapon_FireBeamWeapon_FindSlot:                         ; CODE XREF: Weapon_FireBeamWeapon+40   j  ; was: loc_18436
                move.w  (a0),d0
                beq.s   Weapon_FireBeamWeapon_Initialize
                lea     $60(a0),a0
                dbf     d7,Weapon_FireBeamWeapon_FindSlot
Weapon_FireBeamWeapon_Return:                           ; CODE XREF: Weapon_FireBeamWeapon+28   j  ; was: locret_18442
                rts
; ---------------------------------------------------------------------------
Weapon_FireBeamWeapon_Initialize:                       ; CODE XREF: Weapon_FireBeamWeapon+3A   j  ; was: loc_18444
                tst.w   (word_FFA22A).w
                bne.s   Weapon_FireBeamWeapon_SelectAmmoCost
                subq.w  #4,$10(a4)
Weapon_FireBeamWeapon_SelectAmmoCost:                   ; CODE XREF: Weapon_FireBeamWeapon+4A   j  ; was: loc_1844E
                move.w  #2,d0
                tst.b   (word_FFFF0E).w
                bne.s   Weapon_FireBeamWeapon_SubtractAmmo
                move.w  #1,d0
Weapon_FireBeamWeapon_SubtractAmmo:                     ; CODE XREF: Weapon_FireBeamWeapon+58   j  ; was: loc_1845C
                sub.w   d0,$10(a4)
                bpl.s   Weapon_FireBeamWeapon_SetupObject
                clr.w   $10(a4)
Weapon_FireBeamWeapon_SetupObject:                      ; CODE XREF: Weapon_FireBeamWeapon+62   j  ; was: loc_18466
                move.w  #$6C,(a0)                       ; 'l'
                move.w  #1,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   Weapon_SetBeamProjectileData
                move.w  #2,$26(a0)
; Sets beam projectile sprite properties and velocity data
Weapon_SetBeamProjectileData:                           ; CODE XREF: Weapon_FireBeamWeapon+76   j  ; was: loc_1847C
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                clr.w   4(a0)
                move.w  #$8C80,2(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$42,$23(a0)                    ; 'B'
                move.w  #4,$48(a0)
                clr.w   $56(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                move.b  Weapon_BeamJitterOffsets(pc,d0.w),d0
                add.b   Weapon_DirectionTableOffsets(pc,d6.w),d0
                move.b  d0,$57(a0)
                move.w  a0,d0
                btst    #5,d0
                beq.s   Weapon_FireNoOp
                move.b  #$BA,d0
                jmp     (Sound_PlaySFX).l
; End of function Weapon_FireBeamWeapon
; Shared no-op handler for weapon states that do not emit a projectile
Weapon_FireNoOp:                                        ; CODE XREF: Weapon_FireBeamWeapon+CC   j  ; was: nullsub_45
                                        ; Player_SpawnCircleAttack+C   j
                                        ; DATA XREF:
                rts
; End of function Weapon_FireNoOp
; ---------------------------------------------------------------------------
Weapon_DirectionTableOffsets:   dc.b    0, $10, $20, $30, $40, $50, $60, $70  ; was: byte_184D8
                                        ; DATA XREF: Weapon_FireProjectile+A0   o
                                        ; Weapon_SpawnHomingEffect+66   o
Weapon_BeamJitterOffsets:   dc.b    $FC, $F8, $FC, 0, 0, 4, 8, 4  ; was: byte_184E0
                                        ; DATA XREF: Weapon_FireBeamWeapon+BA   r

; Duplicates beam projectile
Weapon_CloneBeamProjectile:
                movea.w a0,a1                           ; was: sub_184E8
                adda.w  #$300,a1
                move.w  #$A0,(a1)
                move.w  #$8080,2(a1)
                move.w  #$500,8(a1)
                move.w  #$F8F8,$A(a1)
                move.w  $20(a0),$20(a1)
                move.w  $10(a0),$10(a1)
                move.w  $14(a0),$14(a1)
                move.w  $10(a0),$48(a1)
                move.w  $14(a0),$4A(a1)
                move.w  a1,d0
                andi.w  #$20,d0                         ; ' '
                move.w  d0,$4C(a1)
                rts
; End of function Weapon_CloneBeamProjectile
Weapon_EmptyBeamCompanionHandler:                       ; was: nullsub_48
                rts
; End of function Weapon_EmptyBeamCompanionHandler
