Weapon_UpdateTargetingReticle:                          ; CODE XREF: Weapon_ConfigureState2Damage+22   j  ; was: sub_19292
                                        ; sub_17C7C:loc_17CB0   j
                subq.w  #1,(TargetReticleScanDelay).w
                bpl.s   Weapon_UpdateTargetingReticle_Return
Weapon_UpdateTargetingReticle_Scan:                     ; CODE XREF: Weapon_ConfigureState8Targeting+7E   j  ; was: loc_19298
                clr.w   (TargetReticleScanDelay).w
                moveq   #0,d6
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
Weapon_UpdateTargetingReticle_CheckProjectileSlot:      ; CODE XREF: Weapon_UpdateTargetingReticle+1A   j  ; was: loc_192A4
                tst.w   (a0)
                bne.s   Weapon_UpdateTargetingReticle_ResetDelay
                lea     $60(a0),a0
                dbf     d7,Weapon_UpdateTargetingReticle_CheckProjectileSlot
                move.w  (word_FF8D7A).w,d7
                bmi.s   Weapon_UpdateTargetingReticle_Return
                movea.w #(byte_FF8E80-M68K_RAM),a1
Weapon_UpdateTargetingReticle_CheckLockOnTarget:        ; CODE XREF: Weapon_UpdateTargetingReticle+32   j  ; was: loc_192BA
                movea.w (a1)+,a0
                btst    #7,$23(a0)
                bne.s   Weapon_AppendTargetingReticleForObject
                dbf     d7,Weapon_UpdateTargetingReticle_CheckLockOnTarget
Weapon_UpdateTargetingReticle_ResetDelay:               ; CODE XREF: Weapon_UpdateTargetingReticle+14   j  ; was: loc_192C8
                move.w  #$80,(TargetReticleScanDelay).w
Weapon_UpdateTargetingReticle_Return:                   ; CODE XREF: Weapon_UpdateTargetingReticle+4   j  ; was: locret_192CE
                                        ; Weapon_UpdateTargetingReticle+22   j
                rts
; ---------------------------------------------------------------------------
; Calculates targeting reticle sprite position from enemy hitbox
Weapon_AppendTargetingReticleForObject:                 ; CODE XREF: Weapon_ConfigureState8Targeting+84   j  ; was: loc_192D0
                                        ; Weapon_UpdateTargetingReticle+30   j
                cmpi.w  #$160,$14(a0)
                bpl.w   Weapon_UpdateTargetingReticle_Return
                cmpi.w  #$A0,$14(a0)
                bmi.w   Weapon_UpdateTargetingReticle_Return
                cmpi.w  #$1C0,$10(a0)
                bpl.w   Weapon_UpdateTargetingReticle_Return
                cmpi.w  #$80,$10(a0)
                bmi.w   Weapon_UpdateTargetingReticle_Return
                move.b  $28(a0),d0
                ext.w   d0
                move.b  $29(a0),d1
                ext.w   d1
                add.w   d1,d0
                add.w   $14(a0),d0
                move.w  d0,d1
                move.b  $2A(a0),d2
                ext.w   d2
                move.b  $2B(a0),d3
                ext.w   d3
                add.w   d3,d2
                add.w   $10(a0),d2
                move.w  d2,d3
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  (FrameCounter).w,d4
                andi.w  #7,d4
                asl.w   #1,d4
                neg.w   d4
                addi.w  #$1A,d4
                add.w   d4,d0
                subq.w  #8,d0
                sub.w   d4,d1
                subq.w  #8,d1
                add.w   d4,d2
                subq.w  #8,d2
                sub.w   d4,d3
                subq.w  #8,d3
                move.w  #$500,d4
                move.w  d1,(a1)+
                move.w  d4,(a1)+
                move.w  #$C6FC,(a1)+
                move.w  d3,(a1)+
                move.w  d0,(a1)+
                move.w  d4,(a1)+
                move.w  #$DEFC,(a1)+
                move.w  d2,(a1)+
                move.w  d1,(a1)+
                move.w  d4,(a1)+
                move.w  #$CEFC,(a1)+
                move.w  d2,(a1)+
                move.w  d0,(a1)+
                move.w  d4,(a1)+
                move.w  #$D6FC,(a1)+
                move.w  d3,(a1)+
                move.w  #$FFFF,(a1)+
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function Weapon_UpdateTargetingReticle
; ---------------------------------------------------------------------------
Weapon_DirectionVectorTablePointers:    dc.l    Weapon_DirectionVectorsSpeed6
                dc.l    Weapon_DirectionVectorsSpeed6
                dc.l    Weapon_DirectionVectorsSpeed6
                dc.l    Weapon_DirectionVectorsSpeed6
Weapon_DirectionVectorPointerBias:  dc.l    Weapon_DirectionVectorsSpeed6  ; DATA XREF: Weapon_UpdateCurrentState+8   o  ; was: off_1938E
                dc.l    Weapon_DirectionVectorsSpeed7
                dc.l    Weapon_DirectionVectorsSpeed8
                dc.l    Weapon_DirectionVectorsSpeed9
                dc.l    Weapon_DirectionVectorsSpeed10
                dc.l    Weapon_DirectionVectorsSpeed11
                dc.l    Weapon_DirectionVectorsSpeed12
                dc.l    Weapon_DirectionVectorsSpeed13
                dc.l    Weapon_DirectionVectorsSpeed13
Weapon_DirectionVectorsSpeed6:  dc.l    0, $12BA0, $24BB8, $35550, $43E18  ; was: dword_193B2
                                        ; DATA XREF: Effect_SpawnRandomDebris+76   o
                                        ; ROM:0001937E   o
                dc.l    $4FD10, $58B00, $5E278, $60000, $5E278
                dc.l    $58B00, $4FD10, $43E18, $35550, $24BB8
                dc.l    $12BA0, $FFFFFFE8, $FFFED460, $FFFDB448, $FFFCAAB0
                dc.l    $FFFBC1E8, $FFFB02F0, $FFFA7500, $FFFA1D88, $FFFA0000
                dc.l    $FFFA1D88, $FFFA7500, $FFFB02F0, $FFFBC1E8, $FFFCAAB0
                dc.l    $FFFDB448, $FFFED460, 0, $12BA0, $24BB8
                dc.l    $35550, $43E18, $4FD10, $58B00, $5E278
Weapon_DirectionVectorsSpeed7:  dc.l    0, $15D90, $2ADAC, $3E388, $4F31C  ; was: dword_19452
                                        ; DATA XREF: ROM:00019392   o
                dc.l    $5D1E8, $67780, $6DD8C, $70000, $6DD8C
                dc.l    $67780, $5D1E8, $4F31C, $3E388, $2ADAC
                dc.l    $15D90, $FFFFFFE4, $FFFEA270, $FFFD5254, $FFFC1C78
                dc.l    $FFFB0CE4, $FFFA2E18, $FFF98880, $FFF92274, $FFF90000
                dc.l    $FFF92274, $FFF98880, $FFFA2E18, $FFFB0CE4, $FFFC1C78
                dc.l    $FFFD5254, $FFFEA270, 0, $15D90, $2ADAC
                dc.l    $3E388, $4F31C, $5D1E8, $67780, $6DD8C
Weapon_DirectionVectorsSpeed8:  dc.l    0, $18F80, $30FA0, $471C0, $5A820  ; was: dword_194F2
                                        ; DATA XREF: ROM:00019396   o
                dc.l    $6A6C0, $76400, $7D8A0, $80000, $7D8A0
                dc.l    $76400, $6A6C0, $5A820, $471C0, $30FA0
                dc.l    $18F80, $FFFFFFE0, $FFFE7080, $FFFCF060, $FFFB8E40
                dc.l    $FFFA57E0, $FFF95940, $FFF89C00, $FFF82760, $FFF80000
                dc.l    $FFF82760, $FFF89C00, $FFF95940, $FFFA57E0, $FFFB8E40
                dc.l    $FFFCF060, $FFFE7080, 0, $18F80, $30FA0
                dc.l    $471C0, $5A820, $6A6C0, $76400, $7D8A0
Weapon_DirectionVectorsSpeed9:  dc.l    0, $1C170, $37194, $4FFF8, $65D24  ; was: dword_19592
                                        ; DATA XREF: ROM:0001939A   o
                dc.l    $77B98, $85080, $8D3B4, $90000, $8D3B4
                dc.l    $85080, $77B98, $65D24, $4FFF8, $37194
                dc.l    $1C170, $FFFFFFDC, $FFFE3E90, $FFFC8E6C, $FFFB0008
                dc.l    $FFF9A2DC, $FFF88468, $FFF7AF80, $FFF72C4C, $FFF70000
                dc.l    $FFF72C4C, $FFF7AF80, $FFF88468, $FFF9A2DC, $FFFB0008
                dc.l    $FFFC8E6C, $FFFE3E90, 0, $1C170, $37194
                dc.l    $4FFF8, $65D24, $77B98, $85080, $8D3B4
Weapon_DirectionVectorsSpeed10: dc.l    0, $1F360, $3D388, $58E30, $71228  ; was: dword_19632
                                        ; DATA XREF: Weapon_FireMultipleShots+46   o
                                        ; Player_SpawnCircleAttack+A2   o
                dc.l    $85070, $93D00, $9CEC8, $A0000, $9CEC8
                dc.l    $93D00, $85070, $71228, $58E30, $3D388
                dc.l    $1F360, $FFFFFFD8, $FFFE0CA0, $FFFC2C78, $FFFA71D0
                dc.l    $FFF8EDD8, $FFF7AF90, $FFF6C300, $FFF63138, $FFF60000
                dc.l    $FFF63138, $FFF6C300, $FFF7AF90, $FFF8EDD8, $FFFA71D0
                dc.l    $FFFC2C78, $FFFE0CA0, 0, $1F360, $3D388
                dc.l    $58E30, $71228, $85070, $93D00, $9CEC8
Weapon_DirectionVectorsSpeed11: dc.l    0, $22550, $4357C, $61C68, $7C72C  ; was: dword_196D2
                                        ; DATA XREF: ROM:000193A2   o
                dc.l    $92548, $A2980, $AC9DC, $B0000, $AC9DC
                dc.l    $A2980, $92548, $7C72C, $61C68, $4357C
                dc.l    $22550, $FFFFFFD4, $FFFDDAB0, $FFFBCA84, $FFF9E398
                dc.l    $FFF838D4, $FFF6DAB8, $FFF5D680, $FFF53624, $FFF50000
                dc.l    $FFF53624, $FFF5D680, $FFF6DAB8, $FFF838D4, $FFF9E398
                dc.l    $FFFBCA84, $FFFDDAB0, 0, $22550, $4357C
                dc.l    $61C68, $7C72C, $92548, $A2980, $AC9DC
Weapon_DirectionVectorsSpeed12: dc.l    0, $25740, $49770, $6AAA0, $87C30  ; was: dword_19772
                                        ; DATA XREF: Weapon_ConfigureState10Gauge+C   o
                                        ; Weapon_SpawnHomingEffect+74   o
                dc.l    $9FA20, $B1600, $BC4F0, $C0000, $BC4F0
                dc.l    $B1600, $9FA20, $87C30, $6AAA0, $49770
                dc.l    $25740, $FFFFFFD0, $FFFDA8C0, $FFFB6890, $FFF95560
                dc.l    $FFF783D0, $FFF605E0, $FFF4EA00, $FFF43B10, $FFF40000
                dc.l    $FFF43B10, $FFF4EA00, $FFF605E0, $FFF783D0, $FFF95560
                dc.l    $FFFB6890, $FFFDA8C0, 0, $25740, $49770
                dc.l    $6AAA0, $87C30, $9FA20, $B1600, $BC4F0
Weapon_DirectionVectorsSpeed13: dc.l    0, $28930, $4F964, $738D8, $93134  ; was: dword_19812
                                        ; DATA XREF: Weapon_ConfigureState6Motion+70   o
                                        ; Weapon_FireProjectile+AE   o
                dc.l    $ACEF8, $C0280, $CC004, $D0000, $CC004
                dc.l    $C0280, $ACEF8, $93134, $738D8, $4F964
                dc.l    $28930, $FFFFFFCC, $FFFD76D0, $FFFB069C, $FFF8C728
                dc.l    $FFF6CECC, $FFF53108, $FFF3FD80, $FFF33FFC, $FFF30000
                dc.l    $FFF33FFC, $FFF3FD80, $FFF53108, $FFF6CECC, $FFF8C728
                dc.l    $FFFB069C, $FFFD76D0, 0, $28930, $4F964
                dc.l    $738D8, $93134, $ACEF8, $C0280, $CC004
Player_AlternateLayoutMuzzleOffsets0:   dc.w    $E2E8, $F4E8, $E2E6, $FCE6, $ECFC, $1FC, $ECDA, $D2DA  ; was: word_198B2
                                        ; DATA XREF: Player_HandleSpecialAttack:loc_16086   o
                                        ; sub_16116:Player_RenderSpecialMoveRecovery_WithWeapon   o
Player_AlternateLayoutMuzzleOffsets1:   dc.w    $E2E8, $F4E8, $E2E6, $FCE6, $FD0D, $120D, $FDEB, $E3EB  ; was: word_198C2
                                        ; DATA XREF: Player_RenderWithWeapon+4A   o
Player_PrimaryLayoutMuzzleOffsets0: dc.w    $E6F2, $FAF2, $E6EC, $FCEC, $ECFC, $1FC, $ECDA, $D2DA  ; was: word_198D2
                                        ; DATA XREF: Player_HandleFallingState+14E   o
                                        ; sub_17086:Player_RenderSpecialWeapon_UseDefaultVariant   o
Player_PrimaryLayoutMuzzleOffsets1: dc.w    $E6F2, $FAF2, $E6EC, $FCEC, $FD0D, $120D, $FDEB, $E3EB  ; was: word_198E2
                                        ; DATA XREF: Player_RenderWithWeapon:Player_RenderAirborneWithWeapon_UseDefaultVariant   o
Player_AlternateLayoutMuzzleOffsets2:   dc.w    $E2E6, $FCE6, $E2E8, $F4E8, $1226, $2E26, $1204, 4  ; was: word_198F2
                                        ; DATA XREF: Player_RenderWeaponSprite+6   o
                                        ; Player_UpdateDashSprite+6   o
Player_AlternateLayoutMuzzleOffsets3:   dc.w    $E2E6, $FCE6, $E2E8, $F4E8, $115, $1D15, $1F3, $EFF3  ; was: word_19902
                                        ; DATA XREF: Player_RenderWithWeapon+E   o
Player_PrimaryLayoutMuzzleOffsets2: dc.w    $E6EC, $FCEC, $E6F2, $FAF2, $1226, $2E26, $1204, 4  ; was: word_19912
                                        ; DATA XREF: Player_UpdateDashSprite:Player_UpdateDashSprite_UseDefaultVariant   o
                                        ; Player_RenderWithWeapon+82   o
Player_PrimaryLayoutMuzzleOffsets3: dc.w    $E6EC, $FCEC, $E6F2, $FAF2, $115, $1D15, $1F3, $EFF3  ; was: word_19922
                                        ; DATA XREF: Player_RenderWithWeapon:Player_RenderWithWeapon_UseDefaultVariant   o
Weapon_CircleAttackDirectionalFrames0:  dc.l    Weapon_CircleAttackSpriteArtSet0Direction0  ; DATA XREF: ROM:Weapon_CircleAttackAnimationPointers   o  ; was: off_19932
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction1
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction2
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction3
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction4
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction5
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction6
                dc.l    Weapon_CircleAttackSpriteArtSet0Direction7
Weapon_CircleAttackDirectionalFrames1:  dc.l    Weapon_CircleAttackSpriteArtSet1Direction0  ; DATA XREF: ROM:000186A8   o  ; was: off_19952
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction1
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction2
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction3
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction4
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction5
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction6
                dc.l    Weapon_CircleAttackSpriteArtSet1Direction7
Weapon_CircleAttackDirectionalFrames2:  dc.l    Weapon_CircleAttackSpriteArtSet2Direction0  ; DATA XREF: ROM:000186A4   o  ; was: off_19972
                                        ; ROM:000186AC   o
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction1
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction2
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction3
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction4
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction5
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction6
                dc.l    Weapon_CircleAttackSpriteArtSet2Direction7

; Processes all active projectile objects
Projectile_ProcessVisiblePool:                          ; CODE XREF: Sys_GameplayMainLoop:Sys_GameplayMainLoop_UpdateProjectiles   p  ; was: sub_19992
                                        ; ZLeoEnding_UpdateScene+12   p
                tst.b   (FrameControlFlags).w
                bmi.w   Projectile_ProcessVisiblePool_Return
                lea     (dword_FFBFC0).w,a5
Projectile_ProcessVisiblePool_Loop:                     ; CODE XREF: Projectile_ProcessVisiblePool+5E   j  ; was: loc_1999E
                move.w  (a5),d0
                beq.s   Projectile_AdvancePoolPointer
                movea.w d0,a0
                movea.l Entity_UpdateHandlerTable(a0),a0
                jsr     (a0)
                btst    #4,2(a5)
                bne.s   Projectile_ProcessVisiblePool_Clear
                btst    #1,2(a5)
                beq.s   Projectile_ProcessVisiblePool_Queue
                move.w  $10(a5),d0
                subi.w  #$70,d0                         ; 'p'
                cmpi.w  #$160,d0
                bhi.s   Projectile_ProcessVisiblePool_Clear
                move.w  $14(a5),d0
                subi.w  #$40,d0                         ; '@'
                cmpi.w  #$130,d0
                bls.s   Projectile_ProcessVisiblePool_Queue
Projectile_ProcessVisiblePool_Clear:                    ; CODE XREF: Projectile_ProcessVisiblePool+1E   j  ; was: loc_199D6
                                        ; Projectile_ProcessVisiblePool+34   j
                jsr     (Sys_ClearObjectSlot).l
                bra.s   Projectile_AdvancePoolPointer
; ---------------------------------------------------------------------------
Projectile_ProcessVisiblePool_Queue:                    ; CODE XREF: Projectile_ProcessVisiblePool+26   j  ; was: loc_199DE
                                        ; Projectile_ProcessVisiblePool+42   j
                movea.w (word_FFF758).w,a0
                move.w  a5,(a0)+
                move.w  a0,(word_FFF758).w
; Advances projectile array pointer to next slot in loop
Projectile_AdvancePoolPointer:                          ; CODE XREF: Projectile_ProcessVisiblePool+E   j  ; was: loc_199E8
                                        ; Projectile_ProcessVisiblePool+4A   j
                lea     $60(a5),a5
                cmpa.w  #$C620,a5
                bcs.s   Projectile_ProcessVisiblePool_Loop
Projectile_ProcessVisiblePool_Return:                   ; CODE XREF: Projectile_ProcessVisiblePool+4   j  ; was: locret_199F2
                rts
; End of function Projectile_ProcessVisiblePool
