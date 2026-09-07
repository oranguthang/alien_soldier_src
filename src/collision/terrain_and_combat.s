Collision_PlayerWeaponVsEnemy:                          ; CODE XREF: Boss_UpdateCollisionSystem+2A   p  ; was: sub_14190
                movea.w #(byte_FF8F80-M68K_RAM),a5
                move.w  (word_FF8D7E).w,d7
                bmi.w   locret_141F0
                moveq   #4,d5
loc_1419E:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+5C   j
                movea.w (a5)+,a3
                moveq   #$FFFFFFF8,d0
                add.w   $10(a3),d0
                moveq   #8,d1
                add.w   $10(a3),d1
                moveq   #$FFFFFFF8,d2
                add.w   $14(a3),d2
                moveq   #8,d3
                add.w   $14(a3),d3
                movea.w #(byte_FF8E00-M68K_RAM),a4
                move.w  (word_FF8D78).w,d6
                bmi.w   locret_141F0
loc_141C4:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy:loc_141E8   j
                movea.w (a4)+,a2
                cmp.w   $34(a2),d1
                bmi.s   loc_141E8
                cmp.w   $36(a2),d0
                bpl.s   loc_141E8
                cmp.w   $32(a2),d2
                bpl.s   loc_141E8
                cmp.w   $30(a2),d3
                bmi.s   loc_141E8
                btst    d5,$21(a2)
                bne.s   loc_141F2
                beq.w   loc_14278
loc_141E8:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+3A   j
                                        ; Collision_PlayerWeaponVsEnemy+40   j
                dbf     d6,loc_141C4
                dbf     d7,loc_1419E
locret_141F0:                                           ; CODE XREF: Collision_PlayerWeaponVsEnemy+8   j
                                        ; Collision_PlayerWeaponVsEnemy+30   j
                rts
; ---------------------------------------------------------------------------
loc_141F2:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+52   j
                btst    #2,(byte_FF80EC).w
                bne.s   loc_14202
                tst.w   (word_FF8200).w
                beq.w   loc_141E8
loc_14202:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+68   j
                bset    #7,$22(a3)
                btst    #1,(byte_FF80EC).w
                bne.s   loc_141E8
                btst    #4,$23(a2)
                bne.s   loc_141E8
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
                ori.b   #$40,(byte_FF8308).w            ; '@'
                bset    #0,(byte_FF80EC).w
                move.b  $21(a3),d4
                or.b    d4,$22(a2)
                move.w  $26(a3),d4
                move.w  $24(a2),(word_FF8210).w
                move.w  #$20,(word_FF809A).w            ; ' '
                mulu.w  $24(a2),d4
                sub.w   d4,(word_FF8200).w
                bpl.s   loc_141E8
                clr.w   (word_FF8200).w
                clr.w   (word_FF8202).w
                clr.b   (byte_FF80EC).w
                clr.w   (word_FF8234).w
                clr.w   (word_FF8236).w
                clr.b   (byte_FF8260).w
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_141E8
; ---------------------------------------------------------------------------
loc_14278:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+54   j
                tst.w   $24(a2)
                bmi.w   loc_141E8
                bset    #7,$22(a3)
                btst    #4,$23(a2)
                bne.w   loc_141E8
                ori.b   #$40,$22(a2)                    ; '@'
                movem.l d0,-(sp)
                move.b  #$AE,d0
                jsr     (Sound_PlaySFX).l
                movem.l (sp)+,d0
                move.w  $26(a3),d4
                sub.w   d4,$24(a2)
                bpl.w   loc_141E8
                btst    #6,$23(a2)
                beq.s   loc_142C6
                subq.w  #1,(word_FF829E).w
                bpl.s   loc_142C6
                clr.w   (word_FF829E).w
loc_142C6:                                              ; CODE XREF: Collision_PlayerWeaponVsEnemy+12A   j
                                        ; Collision_PlayerWeaponVsEnemy+130   j
                btst    #7,$23(a2)
                bne.w   loc_141E8
                bsr.w   UI_DecrementScoreBCD
                bra.w   loc_141E8
; End of function Collision_PlayerWeaponVsEnemy
; Loops through all active enemies checking collision with projectiles
Collision_CheckAllEnemies:                              ; CODE XREF: Player_ProcessAction+A   p  ; was: sub_142D8
                                        ; Player_UpdateTerrainCheck+A   p
                movea.w #(byte_FF8F00-M68K_RAM),a4
                move.w  (word_FF8D7C).w,d7
                bmi.s   locret_142EA
; Processes collision for each enemy in active list
Collision_ProcessEnemyLoop:                             ; CODE XREF: Collision_CheckAllEnemies+E   j  ; was: loc_142E2
                movea.w (a4)+,a2
                bsr.s   Collision_ShipCollisionDispatcher
                dbf     d7,Collision_ProcessEnemyLoop
locret_142EA:                                           ; CODE XREF: Collision_CheckAllEnemies+8   j
                                        ; DATA XREF: ROM:off_142FC   o
                rts
; End of function Collision_CheckAllEnemies
; Dispatcher for ship collision types
Collision_ShipCollisionDispatcher:                      ; CODE XREF: Collision_CheckAllEnemies+C   p  ; was: sub_142EC
                move.w  $46(a2),d0
                movea.w off_142FC(pc,d0.w),a0
                adda.l  #Collision_PlayerShipCollision,a0
                jmp     (a0)
; End of function Collision_ShipCollisionDispatcher
; ---------------------------------------------------------------------------
off_142FC:      dc.w    locret_142EA-Collision_PlayerShipCollision
                                        ; DATA XREF: Collision_ShipCollisionDispatcher+4   r
                dc.w    Collision_PlayerShipCollision-Collision_PlayerShipCollision
                dc.w    Enemy_Stage17Init-Collision_PlayerShipCollision
                dc.w    Boss_ZLeoPlayerCollision-Collision_PlayerShipCollision

; Player collision with ship platform
Collision_PlayerShipCollision:                          ; DATA XREF: Collision_ShipCollisionDispatcher+8   o  ; was: sub_14304
                                        ; ROM:off_142FC   o
                tst.w   $1C(a5)
                bmi.w   locret_14384
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_14384
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_14384
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1                         ; '&'
                cmp.w   d1,d0
                bpl.s   locret_14384
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_14384
                clr.l   $1C(a5)
                bset    #0,6(a5)
                bset    #0,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   (dword_FFA910).w,d5
                add.w   d5,$10(a5)
                move.w  $4A(a2),d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,$14(a5)
locret_14384:                                           ; CODE XREF: Collision_PlayerShipCollision+4   j
                                        ; Collision_PlayerShipCollision+18   j
                rts
; End of function Collision_PlayerShipCollision
; Player collision handler
Boss_ZLeoPlayerCollision:                               ; DATA XREF: ROM:00014302   o  ; was: sub_14386
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_14414
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_14414
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1                         ; '&'
                cmp.w   d1,d0
                bpl.s   locret_14414
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_14414
                tst.w   $1C(a5)
                bpl.s   loc_143EA
                move.w  $4A(a2),d0
                subi.w  #$20,d0                         ; ' '
                cmp.w   $14(a5),d0
                bpl.s   locret_14414
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_143EA:                                              ; CODE XREF: Boss_ZLeoPlayerCollision+4E   j
                move.w  $4A(a2),d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,$14(a5)
                clr.l   $1C(a5)
                bset    #0,6(a5)
                bset    #0,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   d5,$10(a5)
locret_14414:                                           ; CODE XREF: Boss_ZLeoPlayerCollision+10   j
                                        ; Boss_ZLeoPlayerCollision+24   j
                rts
; End of function Boss_ZLeoPlayerCollision
; Initializes Stage 17 enemies
Enemy_Stage17Init:                                      ; DATA XREF: ROM:00014300   o  ; was: sub_14416
                clr.w   6(a2)
                tst.l   $1C(a5)
                beq.s   loc_14424
                bpl.w   locret_144A4
loc_14424:                                              ; CODE XREF: Enemy_Stage17Init+8   j
                move.w  $28(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                addq.w  #8,d1
                cmp.w   d1,d0
                bpl.w   locret_144A4
                move.w  $2A(a2),d0
                add.w   $48(a2),d0
                move.w  $10(a5),d1
                subq.w  #8,d1
                cmp.w   d1,d0
                bmi.s   locret_144A4
                move.w  $4A(a2),d0
                subq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #$26,d1                         ; '&'
                cmp.w   d1,d0
                bpl.s   locret_144A4
                btst    #4,$E(a5)
                bne.s   loc_14476
                move.w  $4A(a2),d0
                addq.w  #6,d0
                move.w  $14(a5),d1
                addi.w  #-$1A,d1
                cmp.w   d1,d0
                bmi.s   locret_144A4
loc_14476:                                              ; CODE XREF: Enemy_Stage17Init+4C   j
                clr.l   $1C(a5)
                bset    #1,6(a5)
                bset    #1,6(a2)
                move.w  $4C(a2),d5
                sub.w   $48(a2),d5
                neg.w   d5
                add.w   (dword_FFA910).w,d5
                add.w   d5,$10(a5)
                move.w  $4A(a2),d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$14(a5)
locret_144A4:                                           ; CODE XREF: Enemy_Stage17Init+A   j
                                        ; Enemy_Stage17Init+1E   j
                rts
; End of function Enemy_Stage17Init
; Decrements score value using BCD arithmetic for display
UI_DecrementScoreBCD:                                   ; CODE XREF: Enemy_DetectPlayerCollision+122   p  ; was: sub_144A6
                                        ; Enemy_DetectPlayerCollision+196   p
                movem.l d1/a3-a4,-(sp)
                movea.w #(word_FFFF44-M68K_RAM),a3
                movea.w #(word_FF804A-M68K_RAM),a4
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a4),-(a3)
                abcd    -(a4),-(a3)
                bcc.s   loc_144C6
                move.w  #$9999,(word_FFFF42).w
loc_144C6:                                              ; CODE XREF: UI_DecrementScoreBCD+18   j
                movem.l (sp)+,d1/a3-a4
                rts
; End of function UI_DecrementScoreBCD
; Gets entity position coordinates for collision detection
Collision_GetEntityPosition:                            ; CODE XREF: Enemy_BouncingProjectile:loc_2B5C0   p  ; was: sub_144CC
                                        ; sub_2B88A:loc_2B8AA   p
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                bra.s   Collision_CheckTerrainTile
; End of function Collision_GetEntityPosition
; Checks if entity Y is within screen
Collision_CheckScreenBounds:
                add.w   $10(a5),d0                      ; was: sub_144D6
                add.w   $14(a5),d1
                cmpi.w  #$A0,d1
                bpl.s   Collision_CheckTerrainTile
                moveq   #0,d2
                moveq   #0,d3
                rts
; End of function Collision_CheckScreenBounds
; Adds offset to entity position for collision coordinate calculation
Physics_AddEntityOffset:                                ; CODE XREF: UI_DebugSpritePositionEditor+50   p  ; was: sub_144EA
                                        ; UI_DebugSpritePositionEditor+68   p
                add.w   $10(a5),d0
                add.w   $14(a5),d1
; End of function Physics_AddEntityOffset
; Checks collision with terrain by reading tilemap and height data
Collision_CheckTerrainTile:                             ; CODE XREF: Collision_GetEntityPosition+8   j  ; was: sub_144F2
                                        ; Collision_CheckScreenBounds+C   j
                movea.l #$FFFF0000,a0
                movea.l #$FFFF7800,a1
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d1,d3
                subi.w  #$80,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                rts
; End of function Collision_CheckTerrainTile
; Aligns entity Y position to terrain surface clearing velocity
Physics_AlignToTerrain:                                 ; CODE XREF: Player_InitHardLanding   p  ; was: sub_14534
                                        ; Enemy_UpdateTrajectory+52   p
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                andi.w  #7,d4
                sub.w   d4,$14(a5)
                clr.l   $1C(a5)
                rts
; End of function Physics_AlignToTerrain
; Aligns entity to terrain surface from above
Physics_AlignToTerrainTop:                              ; CODE XREF: Enemy_UpdateTrajectory+66   p  ; was: sub_14548
                move.w  d1,d4
                sub.w   (dword_FFA904).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$14(a5)
                clr.l   $1C(a5)
                rts
; End of function Physics_AlignToTerrainTop
; Aligns entity horizontally to wall
Physics_AlignToWallSurface:
                tst.w   $18(a5)                         ; was: sub_14560
                bmi.s   loc_14576
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                andi.w  #7,d4
                sub.w   d4,$10(a5)
                rts
; ---------------------------------------------------------------------------
loc_14576:                                              ; CODE XREF: Physics_AlignToWallSurface+4   j
                move.w  d0,d4
                add.w   (dword_FFA900).w,d4
                neg.w   d4
                subq.w  #1,d4
                andi.w  #7,d4
                add.w   d4,$10(a5)
                rts
; End of function Physics_AlignToWallSurface
; Initializes collision buffer pointers
Collision_InitBufferPointers:                           ; CODE XREF: Enemy_UpdateTrajectory:loc_2D0D6   p  ; was: sub_1458A
                                        ; Projectile_BouncingDebrisMain+22   p
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
; End of function Collision_InitBufferPointers
; Gets terrain tile data at specified position with screen offset
Physics_GetTerrainTileData:                             ; CODE XREF: Physics_EntityWallCheck+14   p  ; was: sub_1459A
                                        ; Physics_EntityWallCheck+2C   p
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                cmpi.w  #$A0,d1
                bpl.s   loc_145AE
                moveq   #0,d2
                moveq   #0,d3
                rts
; ---------------------------------------------------------------------------
loc_145AE:                                              ; CODE XREF: Physics_GetTerrainTileData+C   j
                move.w  d0,d2
                sub.w   d7,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d1,d3
                sub.w   d7,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                beq.s   locret_145F2
                btst    #$B,d3
                beq.s   loc_145E8
                addq.w  #8,d2
loc_145E8:                                              ; CODE XREF: Physics_GetTerrainTileData+4A   j
                btst    #$C,d3
                beq.s   locret_145F2
                addi.w  #$40,d2                         ; '@'
locret_145F2:                                           ; CODE XREF: Physics_GetTerrainTileData+44   j
                                        ; Physics_GetTerrainTileData+52   j
                rts
; End of function Physics_GetTerrainTileData
; Checks projectile collision with terrain tile map
Collision_CheckProjectileTile:                          ; CODE XREF: Enemy_HomingProjectileMain:loc_2B30E   p  ; was: sub_145F4
                                        ; sub_2B3E4:loc_2B45A   p
                move.w  $10(a5),d0
                move.w  $14(a5),d1
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  d0,d2
                subi.w  #$80,d2
                add.w   (dword_FFA900).w,d2
                asr.w   #2,d2
                andi.w  #$7E,d2                         ; '~'
                move.w  d1,d3
                subi.w  #$80,d3
                sub.w   (dword_FFA904).w,d3
                asl.w   #4,d3
                andi.w  #$1F80,d3
                add.w   d3,d2
                move.w  (a0,d2.w),d2
                move.w  d2,d3
                andi.w  #$7FF,d2
                move.b  (a1,d2.w),d2
                andi.w  #$FE,d2
                beq.s   locret_14646
                cmpi.w  #$80,d2
                bpl.s   locret_14646
                moveq   #0,d2
locret_14646:                                           ; CODE XREF: Collision_CheckProjectileTile+48   j
                                        ; Collision_CheckProjectileTile+4E   j
                rts
; End of function Collision_CheckProjectileTile
; Entity wall collision detection checking left and right sides
Physics_EntityWallCheck:                                ; CODE XREF: Physics_EntityTerrainWrapper+A   j  ; was: sub_14648
                                        ; sub_2CC34:loc_2CC54   p
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #0,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_14670
                bset    #2,7(a5)
                bsr.w   Physics_HandleWallCollision
loc_14670:                                              ; CODE XREF: Physics_EntityWallCheck+1C   j
                moveq   #8,d0
                moveq   #0,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   locret_14688
                bset    #3,7(a5)
                bsr.w   Sprite_UpdateBossAnimation
locret_14688:                                           ; CODE XREF: Physics_EntityWallCheck+34   j
                rts
; End of function Physics_EntityWallCheck
; Multi-point terrain collision check for boss with wall detection
Physics_BossTerrainCheck:                               ; CODE XREF: Physics_BossTerrainWrapper+A   j  ; was: sub_1468A
                                        ; sub_2C71E:loc_2C850   p
                moveq   #$18,d6
                tst.w   $1C(a5)
                bmi.s   loc_14694
                moveq   #$FFFFFFE8,d6
loc_14694:                                              ; CODE XREF: Physics_BossTerrainCheck+6   j
                                        ; Player_TerrainCheckFlipped+12   j
                lea     (M68K_RAM).l,a0
                lea     (dword_FF7800).l,a1
                move.w  #$80,d7
                moveq   #$FFFFFFF8,d0
                moveq   #0,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146BE
                bset    #2,7(a5)
                bsr.w   Physics_HandleWallCollision
                bra.s   loc_146D0
; ---------------------------------------------------------------------------
loc_146BE:                                              ; CODE XREF: Physics_BossTerrainCheck+26   j
                moveq   #$FFFFFFF8,d0
                move.w  d6,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146D0
                bsr.w   Physics_HandleWallCollision
loc_146D0:                                              ; CODE XREF: Physics_BossTerrainCheck+32   j
                                        ; Physics_BossTerrainCheck+40   j
                moveq   #8,d0
                moveq   #0,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   loc_146E8
                bset    #3,7(a5)
                bra.w   Sprite_UpdateBossAnimation
; ---------------------------------------------------------------------------
loc_146E8:                                              ; CODE XREF: Physics_BossTerrainCheck+52   j
                moveq   #8,d0
                move.w  d6,d1
                bsr.w   Physics_GetTerrainTileData
                cmpi.w  #$80,d2
                bmi.s   locret_146FA
                bra.w   Sprite_UpdateBossAnimation
; ---------------------------------------------------------------------------
locret_146FA:                                           ; CODE XREF: Physics_BossTerrainCheck+6A   j
                rts
; End of function Physics_BossTerrainCheck
; Dispatches player action handlers
