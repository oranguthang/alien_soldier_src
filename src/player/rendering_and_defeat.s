; Advances and renders the directional movement animation
Player_RenderDirectionalMovement:                       ; CODE XREF: Player_GroundedMovementState+60   j  ; was: sub_16F36
                                        ; Player_CeilingMovementState+62   j
                bclr    #3,$E(a5)
                btst    #2,$69(a5)
                bne.s   Player_RenderDirectionalMovement_UpdateTimer
                bset    #3,$E(a5)
Player_RenderDirectionalMovement_UpdateTimer:           ; CODE XREF: Player_RenderDirectionalMovement+C   j  ; was: loc_16F4A
                subq.w  #1,$C(a5)
                bmi.s   Player_RenderDirectionalMovement_AdvanceFrame
                rts
; ---------------------------------------------------------------------------
Player_RenderDirectionalMovement_AdvanceFrame:          ; CODE XREF: Player_RenderDirectionalMovement+18   j  ; was: loc_16F52
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                move.w  $48(a5),d1
                cmpi.w  #$10,d1
                beq.s   Player_RenderDirectionalMovement_PlayStepSound
                cmpi.w  #0,d1
                bne.s   Player_RenderDirectionalMovement_SubmitFrame
Player_RenderDirectionalMovement_PlayStepSound:         ; CODE XREF: Player_RenderDirectionalMovement+34   j  ; was: loc_16F72
                move.b  #$D6,d0
                jsr     (Sound_QueueSFXRequest).l
; Selects both frame streams and submits their sprite pieces
Player_RenderDirectionalMovement_SubmitFrame:           ; CODE XREF: Player_RenderDirectionalMovement+3A   j  ; was: loc_16F7C
                movea.l Player_DirectionalMovementPrimaryFrames(pc,d1.w),a1
                movea.l Player_DirectionalMovementSecondaryFrames(pc,d1.w),a2
                moveq   #0,d5
                moveq   #0,d6
                bra.w   Player_BuildSpritePieces
; End of function Player_RenderDirectionalMovement
; ---------------------------------------------------------------------------
Player_DirectionalMovementPrimaryFrames:    dc.l    Player_DirectionalPrimarySpriteMapping00  ; was: off_16F8C
                                        ; DATA XREF: Player_RenderDirectionalMovement:Player_RenderDirectionalMovement_SubmitFrame   r
                dc.l    Player_DirectionalPrimarySpriteMapping01
                dc.l    Player_DirectionalPrimarySpriteMapping02
                dc.l    Player_DirectionalPrimarySpriteMapping03
                dc.l    Player_DirectionalPrimarySpriteMapping04
                dc.l    Player_DirectionalPrimarySpriteMapping05
                dc.l    Player_DirectionalPrimarySpriteMapping06
                dc.l    Player_DirectionalPrimarySpriteMapping07
Player_DirectionalMovementSecondaryFrames:  dc.l    Player_DirectionalSecondarySpriteMapping00  ; was: off_16FAC
                                        ; DATA XREF: Player_RenderDirectionalMovement+4A   r
                                        ; Player_CycleDashAnimation:Player_SetDashAnimationData   o
                dc.l    Player_DirectionalSecondarySpriteMapping01
                dc.l    Player_DirectionalSecondarySpriteMapping02
                dc.l    Player_DirectionalSecondarySpriteMapping03
                dc.l    Player_DirectionalSecondarySpriteMapping04
                dc.l    Player_DirectionalSecondarySpriteMapping05
                dc.l    Player_DirectionalSecondarySpriteMapping06
                dc.l    Player_DirectionalSecondarySpriteMapping07

; Renders the armed weapon pose for ceiling states, using muzzle offset set 2
Player_RenderCeilingWeaponPose:                         ; CODE XREF: Player_CeilingAirControlState+40   p  ; was: sub_16FCC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (Player_AlternateLayoutMuzzleOffsets2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderCeilingWeaponPose
; Renders the same armed weapon pose for ground states, using muzzle offset set 0
Player_RenderGroundWeaponPose:                          ; CODE XREF: Player_GroundWeaponState+34   p  ; was: sub_16FDC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (Player_AlternateLayoutMuzzleOffsets0).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderGroundWeaponPose
; Updates player weapon animation cycle with sound effects on key frames
Player_UpdateWeaponAnim:                                ; CODE XREF: Player_RenderCeilingWeaponPose   p  ; was: sub_16FEC
                                        ; sub_16FDC   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s   Player_SetWeaponAnimationData
                move.w  #4,$C(a5)
                addq.w  #4,$48(a5)
                cmpi.w  #$18,$48(a5)
                bmi.s   Player_UpdateWeaponAnim_CheckSoundFrame
                clr.w   $48(a5)
Player_UpdateWeaponAnim_CheckSoundFrame:                ; CODE XREF: Player_UpdateWeaponAnim+1A   j  ; was: loc_1700C
                cmpi.w  #0,d1
                beq.s   Player_UpdateWeaponAnim_PlayFrameSound
                cmpi.w  #$C,d1
                bne.s   Player_SetWeaponAnimationData
Player_UpdateWeaponAnim_PlayFrameSound:                 ; CODE XREF: Player_UpdateWeaponAnim+24   j  ; was: loc_17018
                move.b  #$D6,d0
                jsr     (Sound_QueueSFXRequest).l
; Sets weapon animation frame data and sprite parameters
Player_SetWeaponAnimationData:                          ; CODE XREF: Player_UpdateWeaponAnim+8   j  ; was: loc_17022
                                        ; Player_UpdateWeaponAnim+2A   j
                movea.l Player_WeaponAnimationFrames(pc,d1.w),a2
                asr.w   #1,d1
                move.w  Player_WeaponAnimationTileOffsets(pc,d1.w),d6
                rts
; End of function Player_UpdateWeaponAnim
; ---------------------------------------------------------------------------
Player_WeaponAnimationTileOffsets:  dc.w    $FFFF, $FFFF, 0, $FFFF, $FFFF, 0  ; was: word_1702E
                                        ; DATA XREF: Player_UpdateWeaponAnim+3C   r
Player_WeaponAnimationFrames:   dc.l    Player_WeaponAnimationSpriteMapping00  ; DATA XREF: Player_UpdateWeaponAnim:loc_17022   r  ; was: off_1703A
                dc.l    Player_WeaponAnimationSpriteMapping01
                dc.l    Player_WeaponAnimationSpriteMapping02
                dc.l    Player_WeaponAnimationSpriteMapping03
                dc.l    Player_WeaponAnimationSpriteMapping04
                dc.l    Player_DashSecondarySpriteMapping

; Renders the armed idle pose for the ceiling idle state, offset set 2
Player_RenderCeilingArmedIdle:                          ; CODE XREF: Player_CeilingIdleState+66   j  ; was: sub_17052
                tst.w   (ShootingMode).w
                beq.s   Player_RenderCeilingArmedIdle_UseDefaultVariant
                lea     (Player_AlternateLayoutMuzzleOffsets2).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #Player_IdleSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderCeilingArmedIdle_UseDefaultVariant:        ; CODE XREF: Player_RenderCeilingArmedIdle+4   j  ; was: loc_17072
                lea     (Player_PrimaryLayoutMuzzleOffsets2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #Player_DashSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderCeilingArmedIdle
; Renders the armed idle pose for the ground idle state, offset set 0
Player_RenderGroundArmedIdle:                           ; CODE XREF: Player_GroundIdleState+64   j  ; was: sub_17086
                tst.w   (ShootingMode).w
                beq.s   Player_RenderGroundArmedIdle_UseDefaultVariant
                lea     (Player_AlternateLayoutMuzzleOffsets0).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #Player_IdleSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderGroundArmedIdle_UseDefaultVariant:         ; CODE XREF: Player_RenderGroundArmedIdle+4   j  ; was: loc_170A6
                lea     (Player_PrimaryLayoutMuzzleOffsets0).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #Player_DashSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderGroundArmedIdle
; Renders the armed motion pose for ceiling states, offset set 3
Player_RenderCeilingMotionWithWeapon:                   ; CODE XREF: Player_CeilingDashState+74   j  ; was: sub_170BA
                                        ; Player_CeilingLandingState+76   j
                tst.w   $48(a5)
                bpl.w   Player_RenderCeilingMotionFrame
                tst.w   (ShootingMode).w
                beq.s   Player_RenderCeilingMotionWithWeapon_UseDefaultVariant
                lea     (Player_AlternateLayoutMuzzleOffsets3).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #Player_MotionPoseSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderCeilingMotionWithWeapon_UseDefaultVariant:  ; CODE XREF: Player_RenderCeilingMotionWithWeapon+C   j  ; was: loc_170E2
                lea     (Player_PrimaryLayoutMuzzleOffsets3).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #$13,d6
                movea.l #Player_WeaponSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_RenderGroundMotionWithWeapon:                    ; CODE XREF: Player_GroundCrouchState+62   j  ; was: loc_170F6
                                        ; Player_HandleLandingState+7A   j
                tst.w   $48(a5)
                bpl.w   Player_RenderGroundMotionFrame
                tst.w   (ShootingMode).w
                beq.s   Player_RenderGroundMotionWithWeapon_UseDefaultVariant
                lea     (Player_AlternateLayoutMuzzleOffsets1).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #Player_MotionPoseSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderGroundMotionWithWeapon_UseDefaultVariant:  ; CODE XREF: Player_RenderCeilingMotionWithWeapon+48   j  ; was: loc_1711E
                lea     (Player_PrimaryLayoutMuzzleOffsets1).l,a4
                moveq   #0,d5
                moveq   #$13,d6
                movea.l #Player_WeaponSecondarySpriteMapping,a2
                bra.w   Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_RenderCeilingMotionFrame:                        ; CODE XREF: Player_CeilingDecelerateState+5E   j  ; was: loc_17132
                                        ; Player_RenderCeilingMotionWithWeapon+4   j
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (Player_PrimaryLayoutMuzzleOffsets2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderCeilingMotionWithWeapon
; Unarmed motion frame for ground states, offset set 0
Player_RenderGroundMotionFrame:                         ; CODE XREF: Player_GroundDecelerateState+5C   j  ; was: sub_17146
                                        ; Player_RenderCeilingMotionWithWeapon+40   j
                movea.l #Player_CommonMovementSecondarySpriteMapping,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (Player_PrimaryLayoutMuzzleOffsets0).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderGroundMotionFrame
; Renders the cycling dash pose for ceiling movement, offset set 2
Player_RenderCeilingDashPose:                           ; CODE XREF: Player_CeilingMovementState+78   j  ; was: sub_1715A
                                        ; Player_CeilingMovementState+86   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (Player_PrimaryLayoutMuzzleOffsets2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderCeilingDashPose
; Renders the cycling dash pose for ground movement, offset set 0
Player_RenderGroundDashPose:                            ; CODE XREF: Player_GroundedMovementState+76   j  ; was: sub_1716A
                                        ; Player_GroundedMovementState+84   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (Player_PrimaryLayoutMuzzleOffsets0).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderGroundDashPose
; Cycles dash animation frames with sound effects
Player_CycleDashAnimation:                              ; CODE XREF: Player_RenderCeilingDashPose   p  ; was: sub_1717A
                                        ; sub_1716A   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s   Player_SetDashAnimationData
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                cmpi.w  #$10,d1
                beq.s   Player_CycleDashAnimation_PlayFrameSound
                cmpi.w  #0,d1
                bne.s   Player_SetDashAnimationData
Player_CycleDashAnimation_PlayFrameSound:               ; CODE XREF: Player_CycleDashAnimation+1E   j  ; was: loc_171A0
                move.b  #$D6,d0
                jsr     (Sound_QueueSFXRequest).l
; Sets dash animation frame data and sprite tile parameters
Player_SetDashAnimationData:                            ; CODE XREF: Player_CycleDashAnimation+8   j  ; was: loc_171AA
                                        ; Player_CycleDashAnimation+24   j
                lea     Player_DirectionalMovementSecondaryFrames(pc),a2
                movea.l (a2,d1.w),a2
                asr.w   #1,d1
                move.w  Player_DashAnimationTileOffsets(pc,d1.w),d6
                rts
; End of function Player_CycleDashAnimation
; ---------------------------------------------------------------------------
Player_DashAnimationTileOffsets:    dc.w    $FFFE, $FFFF, 0, $FFFF, $FFFE, $FFFF, 0, $FFFF  ; was: word_171BA
                                        ; DATA XREF: Player_CycleDashAnimation+3A   r

; Updates player animation state and frame data
Player_UpdateAnimationState:                            ; CODE XREF: Player_HandleFallingState+C6   j  ; was: sub_171CA
                                        ; Player_UpdateAnimStatePlus4+2   j
                bsr.s   Player_AdvanceAnimationFrame
                tst.w   $52(a5)
                beq.w   Player_AutoFlipDirection
                rts
; End of function Player_UpdateAnimationState
; Selects animation frame data from table
Player_AdvanceAnimationFrame:                           ; CODE XREF: Player_HandleBounceState+4A   j  ; was: sub_171D6
                                        ; Player_HandleForcedPositionState+50   j
                move.w  $52(a5),d0
                add.w   d1,d0
                move.w  d0,$52(a5)
                andi.w  #$1C,d0
                move.l  Player_AnimationFrameTable(pc,d0.w),8(a5)
                rts
; End of function Player_AdvanceAnimationFrame
; ---------------------------------------------------------------------------
Player_AnimationFrameTable: dc.l    Player_StateAnimationSpriteMapping00  ; DATA XREF: Player_AdvanceAnimationFrame+E   r  ; was: off_171EC
                dc.l    Player_StateAnimationSpriteMapping01
                dc.l    Player_StateAnimationSpriteMapping02
                dc.l    Player_StateAnimationSpriteMapping03
                dc.l    Player_StateAnimationSpriteMapping04
                dc.l    Player_StateAnimationSpriteMapping05
                dc.l    Player_StateAnimationSpriteMapping06
                dc.l    Player_StateAnimationSpriteMapping07

; Renders multiple death particle sprites during player death sequence
Player_RenderDeathParticles:                            ; CODE XREF: Player_HandleDeathSequence:Player_HandleDeathSequence_RenderParticles   j  ; was: sub_1720C
                movea.w #(SharedSpriteScratch-M68K_RAM),a0
                movea.w a0,a1
                move.w  $48(a5),d0
                move.w  $10(a5),d1
                addi.w  #-$10,d1
; Loop that creates individual death particle sprites with positioning
Player_DeathParticleLoop:                               ; CODE XREF: Player_RenderDeathParticles+18   j  ; was: loc_1721E
                bsr.w   Player_WriteDeathParticleSprite
                subq.w  #1,d0
                bpl.s   Player_DeathParticleLoop
                move.w  #$FFFF,(a1)+
                jsr     (Sprite_AppendOAMEntries).l
                move.w  (FrameCounter).w,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  Player_DeathParticleAnimationFrames(pc,d0.w),8(a5)
                rts
; End of function Player_RenderDeathParticles
; ---------------------------------------------------------------------------
Player_DeathParticleAnimationFrames:    dc.l    Player_DeathParticleSpriteMapping00  ; DATA XREF: Player_RenderDeathParticles+2E   r  ; was: off_17242
                dc.l    Player_DeathParticleSpriteMapping01
                dc.l    Player_DeathParticleSpriteMapping02
                dc.l    Player_DeathParticleSpriteMapping03
                dc.l    Player_DeathParticleSpriteMapping04
                dc.l    Player_DeathParticleSpriteMapping05
                dc.l    Player_DeathParticleSpriteMapping06
                dc.l    Player_DeathParticleSpriteMapping07

; Creates single death particle sprite with tile and position data
Player_WriteDeathParticleSprite:                        ; CODE XREF: Player_RenderDeathParticles:Player_DeathParticleLoop   p  ; was: sub_17262
                move.w  #$138,(a1)+
                move.w  #0,(a1)+
                move.w  #$CFDB,(a1)+
                move.w  d1,(a1)+
                addq.w  #8,d1
                rts
; End of function Player_WriteDeathParticleSprite
; Prepares player sprite for rendering with palette
Player_PrepareSpriteRendering:                          ; CODE XREF: Player_HandleFallingState+158   j  ; was: sub_17274
                                        ; Player_RenderCeilingWeaponPose+C   j
                lea     Player_PrimaryAnimationLayoutTable(pc),a0
                nop
Player_PrepareSpriteRendering_WithTables:               ; CODE XREF: Player_HandleSpecialAttack+D2   j  ; was: loc_1727A
                                        ; Player_RenderSpecialMoveRecovery+40   j
                lea     Player_LowerTerrainAnimationIndices(pc),a1
                nop
                btst    #4,$E(a5)
                beq.s   Player_PrepareSpriteRendering_SelectFrame
                lea     Player_UpperTerrainAnimationIndices(pc),a1
                nop
; Gets player sprite animation data based on facing direction and animation state
Player_PrepareSpriteRendering_SelectFrame:              ; CODE XREF: Player_PrepareSpriteRendering+12   j  ; was: loc_1728E
                moveq   #0,d1
                move.b  $9E(a5),d1
                asl.w   #1,d1
                move.w  (a1,d1.w),d0
                movea.l (a0,d0.w),a1
                asl.w   #1,d0
                move.w  (FrameCounter).w,d1
                andi.w  #6,d1
                add.w   d1,d0
                add.b   $14(a0,d0.w),d6
                add.b   $15(a0,d0.w),d5
                bsr.w   Player_BuildSpritePieces
                jmp     Weapon_UpdatePlayerFiring
; End of function Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_PrimaryAnimationLayoutTable: dc.l    Player_PrimaryLayoutSpriteMapping00  ; DATA XREF: Player_PrepareSpriteRendering   o  ; was: off_172BC
                dc.l    Player_PrimaryLayoutSpriteMapping01
                dc.l    Player_PrimaryLayoutSpriteMapping02
                dc.l    Player_PrimaryLayoutSpriteMapping03
                dc.l    Player_PrimaryLayoutSpriteMapping04
                dc.w    $FDFF, $FDFE, $FDFD, $FDFE, $FEFF, $FD00, $FC01, $FD00
                dc.w    $FEFE, $FDFF, $FC01, $FDFF, $FAFD, $FBFE, $FC00, $FBFE
                dc.w    $FAFE, $FBFF, $FC00, $FBFF
Player_AlternateAnimationLayoutTable:   dc.l    Player_AlternateLayoutSpriteMapping00  ; DATA XREF: Player_HandleSpecialAttack+CC   o  ; was: off_172F8
                                        ; Player_RenderSpecialMoveRecovery+3A   o
                dc.l    Player_AlternateLayoutSpriteMapping01
                dc.l    Player_AlternateLayoutSpriteMapping02
                dc.l    Player_AlternateLayoutSpriteMapping03
                dc.l    Player_AlternateLayoutSpriteMapping04
                dc.w    $FC02, $FC01, $FD00, $FC01, $FFFE, $FDFE, $FCFF, $FDFE
                dc.w    $FEFF, $FD00, $FC01, $FD00, $FBFF, $FC00, $FD01, $FC00
                dc.w    $FB00, $FC00, $FD01, $FC00

; Advances and renders the four-frame Counter Force pose
Player_UpdateCounterForceAnimation:                     ; CODE XREF: Player_GroundCounterForceState+2E   j  ; was: sub_17334
                                        ; Player_UnusedCounterForceTerrainState+26   j
                subq.w  #1,$C(a5)
                bpl.s   Player_RenderCounterForceFrame
                move.w  #2,$C(a5)
                addq.w  #4,$48(a5)
; Selects and renders the current Counter Force frame
Player_RenderCounterForceFrame:                         ; CODE XREF: Player_UpdateCounterForceAnimation+4   j  ; was: loc_17344
                move.w  $48(a5),d0
                movea.l Player_CounterForcePrimaryFrameTable(pc,d0.w),a1
                movea.l Player_CounterForceSecondaryFrameTable(pc,d0.w),a2
                asr.w   #1,d0
                move.b  Player_CounterForceFrameOffsets(pc,d0.w),d5
                move.b  Player_CounterForceFrameOffsets+1(pc,d0.w),d6
                bra.w   Player_BuildSpritePieces
; End of function Player_UpdateCounterForceAnimation
; ---------------------------------------------------------------------------
Player_CounterForcePrimaryFrameTable:   dc.l    Player_CounterForcePrimarySpriteMapping00  ; DATA XREF: Player_UpdateCounterForceAnimation+14   r  ; was: off_1735E
                dc.l    Player_CounterForcePrimarySpriteMapping01
                dc.l    Player_CounterForcePrimarySpriteMapping02
                dc.l    Player_CounterForcePrimarySpriteMapping03
Player_CounterForceSecondaryFrameTable: dc.l    Player_IdleSecondarySpriteMapping  ; DATA XREF: Player_UpdateCounterForceAnimation+18   r  ; was: off_1736E
                dc.l    Player_CommonMovementSecondarySpriteMapping
                dc.l    Player_CommonMovementSecondarySpriteMapping
                dc.l    Player_CommonMovementSecondarySpriteMapping
Player_CounterForceFrameOffsets:    dc.b    0, 0, 0, 5, 0, 5, 4, 5  ; was: byte_1737E
                                        ; DATA XREF: Player_UpdateCounterForceAnimation+1E   r
                                        ; Player_UpdateCounterForceAnimation+22   r

; Creates the fixed-slot Counter Force visual effect
Player_CreateCounterForceEffect:                        ; CODE XREF: Player_SpawnCounterForceEffect:Player_SpawnCounterForceEffect_Create   j  ; was: sub_17386
                move.w  #$E0,(PaletteRGBAdjustLevel).w
                move.b  #$E0,(PaletteRGBChannelMask).w
                move.b  #8,(PaletteRGBAdjustStep).w
                movea.w #(PlayerSpecialObjectSlot-M68K_RAM),a0
                move.w  #$1CC,(a0)
                move.w  #$E900,2(a0)
                move.b  #$50,$21(a0)                    ; 'P'
                move.w  #8,$48(a0)
                move.l  #Player_CounterForceEffectAnimation,8(a0)
                move.w  $E(a5),d7
                andi.w  #$8000,d7
                addi.w  #$480,d7
                move.w  d7,$E(a0)
                move.w  #2,$26(a0)
                btst    #3,$E(a5)
                beq.s   Player_CreateCounterForceEffect_ApplyPosition
                neg.w   d0
                neg.l   d2
Player_CreateCounterForceEffect_ApplyPosition:          ; CODE XREF: Player_CreateCounterForceEffect+50   j  ; was: loc_173DC
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$18(a0)
                move.b  #$43,d0                         ; 'C'
                jmp     (Sound_QueueSFXRequest).l
; End of function Player_CreateCounterForceEffect
