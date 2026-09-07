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
                jsr     (Sound_PlaySFX).l
; Selects both frame streams and submits their sprite pieces
Player_RenderDirectionalMovement_SubmitFrame:           ; CODE XREF: Player_RenderDirectionalMovement+3A   j  ; was: loc_16F7C
                movea.l Player_DirectionalMovementPrimaryFrames(pc,d1.w),a1
                movea.l Player_DirectionalMovementSecondaryFrames(pc,d1.w),a2
                moveq   #0,d5
                moveq   #0,d6
                bra.w   Player_BuildSpritePieces
; End of function Player_RenderDirectionalMovement
; ---------------------------------------------------------------------------
Player_DirectionalMovementPrimaryFrames:    dc.l    word_E86FA  ; DATA XREF: Player_RenderDirectionalMovement:Player_RenderDirectionalMovement_SubmitFrame   r  ; was: off_16F8C
                dc.l    word_E871A
                dc.l    word_E873A
                dc.l    word_E8762
                dc.l    word_E8782
                dc.l    word_E87A2
                dc.l    word_E87C2
                dc.l    word_E86E2
Player_DirectionalMovementSecondaryFrames:  dc.l    word_E8812  ; DATA XREF: Player_RenderDirectionalMovement+4A   r  ; was: off_16FAC
                                        ; Player_CycleDashAnimation:Player_SetDashAnimationData   o
                dc.l    word_E8842
                dc.l    word_E886A
                dc.l    word_E889A
                dc.l    word_E88C2
                dc.l    word_E88EA
                dc.l    word_E891A
                dc.l    word_E87EA

; Renders player weapon sprite with animation update
Player_RenderWeaponSprite:                              ; CODE XREF: Player_CeilingAirControlState+40   p  ; was: sub_16FCC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198F2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderWeaponSprite
; Prepares player weapon sprite for rendering with animation data
Player_PrepareWeaponSprite:                             ; CODE XREF: Player_AirAttackState+34   p  ; was: sub_16FDC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198B2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_PrepareWeaponSprite
; Updates player weapon animation cycle with sound effects on key frames
Player_UpdateWeaponAnim:                                ; CODE XREF: Player_RenderWeaponSprite   p  ; was: sub_16FEC
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
                jsr     (Sound_PlaySFX).l
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
Player_WeaponAnimationFrames:   dc.l    word_E8CC2      ; DATA XREF: Player_UpdateWeaponAnim:loc_17022   r  ; was: off_1703A
                dc.l    word_E8CDA
                dc.l    word_E8CEA
                dc.l    word_E8D12
                dc.l    word_E8D2A
                dc.l    word_E8992

; Updates player dash sprite
Player_UpdateDashSprite:                                ; CODE XREF: Player_CeilingIdleState+66   j  ; was: sub_17052
                tst.w   (word_FFA22A).w
                beq.s   Player_UpdateDashSprite_UseDefaultVariant
                lea     (word_198F2).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #word_E8942,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_UpdateDashSprite_UseDefaultVariant:              ; CODE XREF: Player_UpdateDashSprite+4   j  ; was: loc_17072
                lea     (word_19912).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w   Player_PrepareSpriteRendering
; End of function Player_UpdateDashSprite
; Renders player special weapon sprite with conditional positioning
Player_RenderSpecialWeapon:                             ; CODE XREF: Player_HandleJump+64   j  ; was: sub_17086
                tst.w   (word_FFA22A).w
                beq.s   Player_RenderSpecialWeapon_UseDefaultVariant
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #word_E8942,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderSpecialWeapon_UseDefaultVariant:           ; CODE XREF: Player_RenderSpecialWeapon+4   j  ; was: loc_170A6
                lea     (word_198D2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderSpecialWeapon
; Renders player sprite with weapon state and metasprite selection
Player_RenderWithWeapon:                                ; CODE XREF: Player_CeilingDashState+74   j  ; was: sub_170BA
                                        ; Player_CeilingLandingState+76   j
                tst.w   $48(a5)
                bpl.w   Player_RenderGroundedFrame
                tst.w   (word_FFA22A).w
                beq.s   Player_RenderWithWeapon_UseDefaultVariant
                lea     (word_19902).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #word_E8F0A,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderWithWeapon_UseDefaultVariant:              ; CODE XREF: Player_RenderWithWeapon+C   j  ; was: loc_170E2
                lea     (word_19922).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w   Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_RenderAirborneWithWeapon:                        ; CODE XREF: Player_HandleAirState+62   j  ; was: loc_170F6
                                        ; Player_HandleLandingState+7A   j
                tst.w   $48(a5)
                bpl.w   Player_RenderFallingSprite
                tst.w   (word_FFA22A).w
                beq.s   Player_RenderAirborneWithWeapon_UseDefaultVariant
                lea     (word_198C2).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                movea.l #word_E8F0A,a2
                bra.w   Player_PrepareSpriteRendering_WithTables
; ---------------------------------------------------------------------------
Player_RenderAirborneWithWeapon_UseDefaultVariant:      ; CODE XREF: Player_RenderWithWeapon+48   j  ; was: loc_1711E
                lea     (word_198E2).l,a4
                moveq   #0,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w   Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_RenderGroundedFrame:                             ; CODE XREF: Player_HandleCrouchState+5E   j  ; was: loc_17132
                                        ; Player_RenderWithWeapon+4   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_19912).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderWithWeapon
; Prepares player falling/airborne sprite for rendering
Player_RenderFallingSprite:                             ; CODE XREF: Player_HandleAirMovement+5C   j  ; was: sub_17146
                                        ; Player_RenderWithWeapon+40   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_198D2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderFallingSprite
; Renders player dash animation sprite with cycling animation
Player_RenderDashSprite:                                ; CODE XREF: Player_CeilingMovementState+78   j  ; was: sub_1715A
                                        ; Player_CeilingMovementState+86   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_19912).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderDashSprite
; Renders player dash sprite with offset and table
Player_RenderDashEffect:                                ; CODE XREF: Player_GroundedMovementState+76   j  ; was: sub_1716A
                                        ; Player_GroundedMovementState+84   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_198D2).l,a4
                bra.w   Player_PrepareSpriteRendering
; End of function Player_RenderDashEffect
; Cycles dash animation frames with sound effects
Player_CycleDashAnimation:                              ; CODE XREF: Player_RenderDashSprite   p  ; was: sub_1717A
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
                jsr     (Sound_PlaySFX).l
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
                                        ; Player_HandleCutsceneControl+50   j
                move.w  $52(a5),d0
                add.w   d1,d0
                move.w  d0,$52(a5)
                andi.w  #$1C,d0
                move.l  Player_AnimationFrameTable(pc,d0.w),8(a5)
                rts
; End of function Player_AdvanceAnimationFrame
; ---------------------------------------------------------------------------
Player_AnimationFrameTable: dc.l    word_E8A1A          ; DATA XREF: Player_AdvanceAnimationFrame+E   r  ; was: off_171EC
                dc.l    word_E8A4A
                dc.l    word_E8A82
                dc.l    word_E8ABA
                dc.l    word_E8AE2
                dc.l    word_E8B12
                dc.l    word_E8B4A
                dc.l    word_E8B82

; Renders multiple death particle sprites during player death sequence
Player_RenderDeathParticles:                            ; CODE XREF: Player_HandleDeathSequence:Player_HandleDeathSequence_RenderParticles   j  ; was: sub_1720C
                movea.w #(dword_FFA100-M68K_RAM),a0
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
                jsr     (Sprite_AddToOAMBuffer).l
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  Player_DeathParticleAnimationFrames(pc,d0.w),8(a5)
                rts
; End of function Player_RenderDeathParticles
; ---------------------------------------------------------------------------
Player_DeathParticleAnimationFrames:    dc.l    word_E8F9A  ; DATA XREF: Player_RenderDeathParticles+2E   r  ; was: off_17242
                dc.l    word_E8FC2
                dc.l    word_E8FEA
                dc.l    word_E9012
                dc.l    word_E903A
                dc.l    word_E904A
                dc.l    word_E905A
                dc.l    word_E906A

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
                                        ; Player_RenderWeaponSprite+C   j
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
                move.w  (word_FFA000).w,d1
                andi.w  #6,d1
                add.w   d1,d0
                add.b   $14(a0,d0.w),d6
                add.b   $15(a0,d0.w),d5
                bsr.w   Player_BuildSpritePieces
                jmp     Weapon_UpdatePlayerFiring
; End of function Player_PrepareSpriteRendering
; ---------------------------------------------------------------------------
Player_PrimaryAnimationLayoutTable: dc.l    word_E8D92  ; DATA XREF: Player_PrepareSpriteRendering   o  ; was: off_172BC
                dc.l    word_E8DC2
                dc.l    word_E8DAA
                dc.l    word_E8D72
                dc.l    word_E8D52
                dc.w    $FDFF, $FDFE, $FDFD, $FDFE, $FEFF, $FD00, $FC01, $FD00
                dc.w    $FEFE, $FDFF, $FC01, $FDFF, $FAFD, $FBFE, $FC00, $FBFE
                dc.w    $FAFE, $FBFF, $FC00, $FBFF
Player_AlternateAnimationLayoutTable:   dc.l    word_E8E12  ; DATA XREF: Player_HandleSpecialAttack+CC   o  ; was: off_172F8
                                        ; Player_RenderSpecialMoveRecovery+3A   o
                dc.l    word_E8E4A
                dc.l    word_E8E32
                dc.l    word_E8DF2
                dc.l    word_E8DDA
                dc.w    $FC02, $FC01, $FD00, $FC01, $FFFE, $FDFE, $FCFF, $FDFE
                dc.w    $FEFF, $FD00, $FC01, $FD00, $FBFF, $FC00, $FD01, $FC00
                dc.w    $FB00, $FC00, $FD01, $FC00

; Animates player defeat sprite cycling through death animation frames
Player_AnimateDefeatSprite:                             ; CODE XREF: Player_GroundedDamageState+2E   j  ; was: sub_17334
                                        ; Player_DamageLandingRecoveryState+26   j
                subq.w  #1,$C(a5)
                bpl.s   Player_UpdateDefeatAnimation
                move.w  #2,$C(a5)
                addq.w  #4,$48(a5)
; Updates player defeat animation frame with timer-based progression
Player_UpdateDefeatAnimation:                           ; CODE XREF: Player_AnimateDefeatSprite+4   j  ; was: loc_17344
                move.w  $48(a5),d0
                movea.l Player_DefeatPrimaryFrameTable(pc,d0.w),a1
                movea.l Player_DefeatSecondaryFrameTable(pc,d0.w),a2
                asr.w   #1,d0
                move.b  Player_DefeatFrameOffsets(pc,d0.w),d5
                move.b  Player_DefeatFrameOffsets+1(pc,d0.w),d6
                bra.w   Player_BuildSpritePieces
; End of function Player_AnimateDefeatSprite
; ---------------------------------------------------------------------------
Player_DefeatPrimaryFrameTable: dc.l    word_E8BC2      ; DATA XREF: Player_AnimateDefeatSprite+14   r  ; was: off_1735E
                dc.l    word_E8BE2
                dc.l    word_E8BFA
                dc.l    word_E8C0A
Player_DefeatSecondaryFrameTable:   dc.l    word_E8942  ; DATA XREF: Player_AnimateDefeatSprite+18   r  ; was: off_1736E
                dc.l    word_E89C2
                dc.l    word_E89C2
                dc.l    word_E89C2
Player_DefeatFrameOffsets:  dc.b    0, 0, 0, 5, 0, 5, 4, 5  ; was: byte_1737E
                                        ; DATA XREF: Player_AnimateDefeatSprite+1E   r
                                        ; Player_AnimateDefeatSprite+22   r

; Creates the fixed-slot impact object used when the player takes damage
Player_CreateDamageImpactObject:                        ; CODE XREF: Player_SpawnDamageImpactEffect:Player_SpawnDamageImpactEffect_Create   j  ; was: sub_17386
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$1CC,(a0)
                move.w  #$E900,2(a0)
                move.b  #$50,$21(a0)                    ; 'P'
                move.w  #8,$48(a0)
                move.l  #off_E9800,8(a0)
                move.w  $E(a5),d7
                andi.w  #$8000,d7
                addi.w  #$480,d7
                move.w  d7,$E(a0)
                move.w  #2,$26(a0)
                btst    #3,$E(a5)
                beq.s   Player_CreateDamageImpactObject_ApplyPosition
                neg.w   d0
                neg.l   d2
Player_CreateDamageImpactObject_ApplyPosition:          ; CODE XREF: Player_CreateDamageImpactObject+50   j  ; was: loc_173DC
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$18(a0)
                move.b  #$43,d0                         ; 'C'
                jmp     (Sound_PlaySFX).l
; End of function Player_CreateDamageImpactObject
