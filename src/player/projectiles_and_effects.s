Player_SpawnProjectile:                                 ; CODE XREF: Player_PhoenixAttackUpdate+56   p  ; was: sub_173FA
                                        ; Player_InitiateDashAttack+80   p
                move.b  #$41,d0                         ; 'A'
                jsr     (Sound_PlaySFX).l
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w            ; ' '
                move.b  #2,(byte_FF8143).w
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0)                    ; 'T'
                move.w  #$4000,2(a0)
                move.l  #Player_TeleportDashProjectileSpriteMapping,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                tst.w   (DifficultyMode).w
                bne.s   Player_SpawnProjectile_UseAlternateParameters
                move.w  #$26,$26(a0)                    ; '&'
                subi.w  #$1E,(word_FFA216).w
                move.w  #$801E,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                rts
; ---------------------------------------------------------------------------
Player_SpawnProjectile_UseAlternateParameters:          ; CODE XREF: Player_SpawnProjectile+60   j  ; was: loc_17476
                move.w  #$23,$26(a0)                    ; '#'
                subi.w  #$32,(word_FFA216).w            ; '2'
                move.w  #$8032,(word_FF8262).w
                move.w  #$30,(word_FF8268).w            ; '0'
                rts
; End of function Player_SpawnProjectile
; Calculates weapon data table offset
Player_GetWeaponTableOffset:
                bne.s   Player_GetWeaponTableOffset_SelectFrame  ; was: sub_17490
                bset    #1,(byte_FF8244).w
Player_GetWeaponTableOffset_SelectFrame:                ; CODE XREF: Player_GetWeaponTableOffset   j  ; was: loc_17498
                movea.l $48(a5),a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #$C,d0
                rts
; End of function Player_GetWeaponTableOffset
; Expands two frame streams into the player's composite sprite-piece buffer
Player_BuildSpritePieces:                               ; CODE XREF: Player_HandleAirMovement+70   j  ; was: sub_174A8
                                        ; Player_HandleFallingState+D6   j
                movea.w #(byte_FF8780-M68K_RAM),a3
                move.l  a3,8(a5)
                clr.l   $DC(a5)
                moveq   #$F,d4
                ext.w   d5
                asl.w   #8,d6
Player_BuildSpritePieces_CopyPrimaryStream:             ; CODE XREF: Player_BuildSpritePieces+2C   j  ; was: loc_174BA
                move.w  (a1)+,d0
                bclr    d4,d0
                bne.s   Player_BuildSpritePieces_CopyFinalPrimaryPiece
                move.w  d0,(a3)+
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
                bra.s   Player_BuildSpritePieces_CopyPrimaryStream
; ---------------------------------------------------------------------------
Player_BuildSpritePieces_CopyFinalPrimaryPiece:         ; CODE XREF: Player_BuildSpritePieces+16   j  ; was: loc_174D6
                move.w  d0,(a3)+
                andi.w  #$3FF,d0
                moveq   #0,d1
                move.b  (a1),d1
                move.w  d1,d2
                andi.w  #3,d2
                addq.w  #1,d2
                lsr.w   #2,d1
                addq.w  #1,d1
                muls.w  d2,d1
                add.w   d1,d0
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
Player_BuildSpritePieces_CopySecondaryStream:           ; CODE XREF: Player_BuildSpritePieces+68   j  ; was: loc_17502
                move.w  (a2)+,d1
                move.w  d1,d2
                add.w   d0,d2
                move.w  d2,(a3)+
                move.l  (a2)+,(a3)+
                move.w  (a2)+,(a3)+
                btst    d4,d1
                beq.s   Player_BuildSpritePieces_CopySecondaryStream
                rts
; End of function Player_BuildSpritePieces
; Spawns particle effect with random velocity
Effect_SpawnParticle:                                   ; CODE XREF: Player_HandleJump+14   p  ; was: sub_17514
                                        ; Player_CeilingIdleState+16   p
                btst    #4,$69(a5)
                bne.w   Effect_SpawnParticle_Return
                move.w  (dword_FFFF08+2).w,d0
                andi.w  #$E000,d0
                bne.w   Effect_SpawnParticle_Return
                bsr.w   Sprite_AllocateSlot
                bne.w   Effect_SpawnParticle_Return
                lea     (Effect_SharedParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (Math_SineTable).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                asl.l   d0,d1
                move.w  (dword_FFFF08).w,d0
                asr.w   #1,d0
                andi.w  #3,d0
                asl.l   d0,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movem.l a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,a0
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                moveq   #$10,d1
                btst    #4,$E(a5)
                beq.s   Effect_SpawnParticle_SetPosition
                moveq   #$10,d1
Effect_SpawnParticle_SetPosition:                       ; CODE XREF: Effect_SpawnParticle+8C   j  ; was: loc_175A4
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                sub.w   d1,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
Effect_SpawnParticle_Return:                            ; CODE XREF: Effect_SpawnParticle+6   j  ; was: locret_175B6
                                        ; Effect_SpawnParticle+12   j
                rts
; End of function Effect_SpawnParticle
; Spawns Phoenix particle effects
Player_SpawnPhoenixParticles:
                subq.w  #1,$4A(a5)                      ; was: sub_175B8
                bpl.w   Player_SpawnPhoenixParticles_Return
                move.w  #$FFFF,$4A(a5)
                btst    #4,$69(a5)
                bne.w   Player_SpawnPhoenixParticles_Return
                subq.w  #2,(word_FF8304).w
                bpl.s   Player_SpawnPhoenixParticles_CheckSoundFrame
                clr.w   (word_FF8304).w
Player_SpawnPhoenixParticles_CheckSoundFrame:           ; CODE XREF: Player_SpawnPhoenixParticles+1C   j  ; was: loc_175DA
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   Player_SpawnPhoenixParticles_Allocate
                move.b  #$AC,d0
                jsr     (Sound_PlaySFX).l
Player_SpawnPhoenixParticles_Allocate:                  ; CODE XREF: Player_SpawnPhoenixParticles+2A   j  ; was: loc_175EE
                bsr.w   Sprite_AllocateSlot
                bne.w   Player_SpawnPhoenixParticles_Return
                lea     (Effect_SharedParticleSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (Math_SineTable).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                asl.l   #3,d1
                asl.l   #3,d2
                move.w  $14(a5),$14(a0)
                sub.l   d1,$14(a0)
                move.w  $10(a5),$10(a0)
                sub.l   d2,$10(a0)
Player_SpawnPhoenixParticles_Return:                    ; CODE XREF: Player_SpawnPhoenixParticles+4   j  ; was: locret_17640
                                        ; Player_SpawnPhoenixParticles+14   j
                rts
; End of function Player_SpawnPhoenixParticles
; Spawns three projectiles in spread pattern for special attack
Player_SpawnTripleShot:                                 ; CODE XREF: Player_InitSpecialAttack+56   j  ; was: sub_17642
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                move.w  $10(a5),d4
                moveq   #3,d5
                moveq   #2,d7
                btst    #3,$E(a5)
                beq.s   Player_SpawnTripleShot_FaceLeft
                move.w  #$C0,d6
                subq.w  #8,d4
                bra.s   Player_SpawnTripleShot_Loop
; ---------------------------------------------------------------------------
Player_SpawnTripleShot_FaceLeft:                        ; CODE XREF: Player_SpawnTripleShot+12   j  ; was: loc_1765E
                addq.w  #8,d4
                move.w  #$1E0,d6
Player_SpawnTripleShot_Loop:                            ; CODE XREF: Player_SpawnTripleShot+1A   j  ; was: loc_17664
                                        ; Player_SpawnTripleShot+30   j
                move.l  #SharedCombatSpriteAnimation01,8(a0)
                bsr.s   Player_InitShotProjectile
                addi.w  #$40,d6                         ; '@'
                dbf     d7,Player_SpawnTripleShot_Loop
                rts
; End of function Player_SpawnTripleShot
; Spawns 5 projectiles in radial spread
Player_SpawnRadialShot:
                moveq   #4,d5                           ; was: sub_17678
                move.w  #$FFC0,d6
                moveq   #4,d7
                btst    #3,$E(a5)
                beq.s   Player_SpawnRadialShot_Loop
                addi.w  #$80,d6
Player_SpawnRadialShot_Loop:                            ; CODE XREF: Player_SpawnRadialShot+E   j  ; was: loc_1768C
                                        ; Player_SpawnRadialShot+22   j
                move.l  #SharedCombatSpriteAnimation01,8(a0)
                bsr.s   Player_InitShotProjectile
                addi.w  #$40,d6                         ; '@'
                dbf     d7,Player_SpawnRadialShot_Loop
                rts
; End of function Player_SpawnRadialShot
; Initializes shot projectile with angle and velocity
Player_InitShotProjectile:                              ; CODE XREF: Player_SpawnTripleShot+2A   p  ; was: sub_176A0
                                        ; Player_SpawnRadialShot+1C   p
                jsr     (Projectile_InitType88).l
                move.b  $20(a5),$20(a0)
                lea     (Math_SineTable).l,a1
                andi.w  #$1FE,d6
                move.w  -$80(a1,d6.w),d1
                move.w  (a1,d6.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d5,d1
                asl.l   d5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.w  $14(a5),$14(a0)
                subq.w  #8,$14(a0)
                move.w  d4,$10(a0)
                lea     $60(a0),a0
                rts
; End of function Player_InitShotProjectile
; ---------------------------------------------------------------------------
Player_LowerTerrainAnimationIndices:    dc.w    0, 8, 4, 8, 0, $C, $10, $C  ; was: word_176E2
                                        ; DATA XREF: Player_PrepareSpriteRendering:Player_PrepareSpriteRendering_WithTables   o
Player_UpperTerrainAnimationIndices:    dc.w    0, $C, $10, $C, 0, 8, 4, 8  ; was: word_176F2
                                        ; DATA XREF: Player_PrepareSpriteRendering+14   o

; Renders a transient signed three-digit value as four OAM sprites
UI_RenderTransientValue:
                tst.w   (word_FF8262).w                 ; was: sub_17702
                beq.w   UI_RenderTransientValue_Return
                tst.b   (byte_FF813E).w
                bmi.s   UI_RenderTransientValue_BuildSprites
                subq.w  #1,(word_FF8268).w
                bpl.s   UI_RenderTransientValue_UpdatePosition
                clr.w   (word_FF8262).w
UI_RenderTransientValue_Return:                         ; CODE XREF: UI_RenderTransientValue+4   j  ; was: locret_1771A
                rts
; ---------------------------------------------------------------------------
UI_RenderTransientValue_UpdatePosition:                 ; CODE XREF: UI_RenderTransientValue+12   j  ; was: loc_1771C
                btst    #0,(word_FFA000+1).w
                bne.s   UI_RenderTransientValue_BuildSprites
                subq.w  #1,(word_FF8266).w
UI_RenderTransientValue_BuildSprites:                   ; CODE XREF: UI_RenderTransientValue+C   j  ; was: loc_17728
                                        ; UI_RenderTransientValue+20   j
                move.b  (word_FF8262).w,d0
                andi.w  #$10,d0
                addi.w  #-$3841,d0
                lea     (Math_PackedBCDLookup).l,a0
                move.w  (word_FF8262).w,d4
                andi.w  #$FFF,d4
                asl.w   #1,d4
                move.b  (a0,d4.w),d1
                andi.w  #$F,d1
                move.b  1(a0,d4.w),d2
                move.b  d2,d3
                asr.w   #4,d2
                andi.w  #$F,d2
                andi.w  #$F,d3
                addi.w  #-$383C,d1
                addi.w  #-$383C,d2
                addi.w  #-$383C,d3
                move.w  #0,d4
                move.w  (word_FF8264).w,d5
                move.w  (word_FF8266).w,d6
                cmpi.w  #$A0,d6
                bpl.s   UI_RenderTransientValue_UseClampedY
                move.w  #$A0,d6
UI_RenderTransientValue_UseClampedY:                    ; CODE XREF: UI_RenderTransientValue+76   j  ; was: loc_1777E
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d0,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d1,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d2,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d3,(a0)+
                move.w  d5,(a0)+
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp     (Sprite_AppendOAMEntries).l
; End of function UI_RenderTransientValue
; Creates visual dash trail effect behind player
Effect_CreateDashTrail:                                 ; CODE XREF: Player_DashAttackState+B8   j  ; was: sub_177B6
                                        ; Player_TeleportDash+C8   j
                tst.w   (word_FFC5C0).w
                beq.s   Effect_CreateDashTrail_AllocateObjects
                move.l  #Player_TeleportDashTrailSpriteMapping,8(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   Effect_CreateDashTrail_Return
                move.l  #Player_PhoenixAndTeleportDashSpriteMapping,8(a5)
                rts
; ---------------------------------------------------------------------------
Effect_CreateDashTrail_AllocateObjects:                 ; CODE XREF: Effect_CreateDashTrail+4   j  ; was: loc_177D8
                bsr.w   Effect_FindDashTrailSlot
                bne.w   Effect_CreateDashTrail_Return
                move.w  #$250,(a0)
                clr.b   $21(a0)
                move.w  #$C880,2(a0)
                move.l  #Player_DashTrailInitialSpriteMapping,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #3,$48(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $48(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                add.l   d0,$10(a0)
                move.l  d0,$4C(a0)
                bsr.w   Effect_FindDashTrailSlot
                bne.s   Effect_CreateDashTrail_Return
                lea     (Effect_DashTrailPrimarySpriteFrames).l,a1
                move.w  #$FFF4,$18(a0)
                tst.w   $48(a5)
                bpl.s   Effect_SetDashTrailProperties
                lea     (Effect_DashTrailSecondarySpriteFrames).l,a1
                neg.w   $18(a0)
; Sets sprite properties for dash trail effect including position and velocity
Effect_SetDashTrailProperties:                          ; CODE XREF: Effect_CreateDashTrail+90   j  ; was: loc_17852
                jsr     (Sprite_InitFromTable).l
                move.w  #$8880,2(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
Effect_CreateDashTrail_Return:                          ; CODE XREF: Effect_CreateDashTrail+14   j  ; was: locret_17882
                                        ; Effect_CreateDashTrail+26   j
                rts
; End of function Effect_CreateDashTrail
; Updates dash trail position with acceleration
Effect_UpdateDashTrail:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_17884
                btst    #4,(byte_FF8244).w
                bne.s   Effect_UpdateDashTrail_ApplyMotion
Effect_UpdateDashTrail_SetDisplayFlag:                  ; CODE XREF: Effect_UpdateDashTrail+14   j  ; was: loc_1788C
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
Effect_UpdateDashTrail_ApplyMotion:                     ; CODE XREF: Effect_UpdateDashTrail+6   j  ; was: loc_17894
                subq.w  #1,$48(a5)
                bmi.s   Effect_UpdateDashTrail_SetDisplayFlag
                move.l  $18(a5),d0
                add.l   $4C(a5),d0
                move.l  d0,$18(a5)
                bset    #7,2(a5)
                btst    #0,$49(a5)
                beq.s   Effect_UpdateDashTrail_Return
                bclr    #7,2(a5)
Effect_UpdateDashTrail_Return:                          ; CODE XREF: Effect_UpdateDashTrail+2E   j  ; was: locret_178BA
                rts
; End of function Effect_UpdateDashTrail
; Updates sprite facing flags
Effect_UpdateFacingFlags:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_178BC
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   Effect_UpdateFacingFlags_Return
                move.w  #$1000,2(a5)
Effect_UpdateFacingFlags_Return:                        ; CODE XREF: Effect_UpdateFacingFlags+14   j  ; was: locret_178D8
                rts
; End of function Effect_UpdateFacingFlags
; ---------------------------------------------------------------------------
Weapon_SlotAnimationStepDelays:     dc.w    0, 1, 3, 3, $12, 5  ; DATA XREF: Weapon_UpdateStateAndSlotAnimations+1E   o  ; was: word_178DA
WeaponSelect_SpriteFramePointers:   dc.l    word_E9964  ; DATA XREF: WeaponSelect_Initialize+8A   o  ; was: off_178E6
                                        ; sub_2BBC0:UI_UpdateWeaponSelectionObject_LoadAnimatedFrame   o
                dc.l    word_E9976
                dc.l    word_E9988
                dc.l    word_E999A
                dc.l    word_E99AC
                dc.l    word_E99BE
