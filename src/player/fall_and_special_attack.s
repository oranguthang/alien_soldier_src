; Ends the dash state and applies its exit vertical velocity
Player_EndDashWithVerticalVelocity:                     ; CODE XREF: Player_CheckDashInput+12   j  ; was: sub_15C66
                bsr.s   Player_EndDashState
                move.l  #$20000,$1C(a5)
                rts
; End of function Player_EndDashWithVerticalVelocity
; Ends dash attack and transitions to air state
Player_EndDashState:                                    ; CODE XREF: Player_EndDashWithVerticalVelocity   p  ; was: sub_15C72
                                        ; Player_CeilingIdleState+12   j
                clr.w   (PlayerAirMoveUsedFlags).w
                clr.w   $52(a5)
; Initializes end of air dash with gravity and velocity setup
Player_InitAirDashEnd:                                  ; CODE XREF: Player_DashAttackState+62   j  ; was: loc_15C7A
                bclr    #0,(CounterForceTriggerFlag).w
                move.w  #$28,4(a5)                      ; '('
                bclr    #4,$E(a5)
                move.w  #$C,$5C(a5)
                move.l  #$12000,$1C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.b  #$7F,(PlayerInputMask).w
                rts
; End of function Player_EndDashState
; Initializes a timed transition into the common falling state
Player_InitFallingTransition:                           ; CODE XREF: Player_CheckSpecialMoveActivation+32   p  ; was: sub_15CAC
                bclr    #0,(CounterForceTriggerFlag).w
                move.w  #$FFE0,$52(a5)
                move.w  #$14,4(a5)
                move.l  #$3A000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                move.w  #4,$4A(a5)
                clr.w   (PlayerAirMoveUsedFlags).w
                move.b  #$7F,(PlayerInputMask).w
                rts
; End of function Player_InitFallingTransition
; Handles player falling state with gravity
Player_HandleFallingState:                              ; CODE XREF: Player_KnockbackState+2E   j  ; was: sub_15CE4
                                        ; DATA XREF: ROM:00015068   o
                bset    #0,(byte_FF8244).w
                btst    #5,$69(a5)
                bne.s   Player_HandleFallingState_UpdateTimer
                move.w  #$FFFF,$48(a5)
Player_HandleFallingState_UpdateTimer:                  ; CODE XREF: Player_HandleFallingState+C   j  ; was: loc_15CF8
                tst.w   $48(a5)
                bmi.s   Player_HandleFallingState_ApplyGravity
                subq.w  #1,$48(a5)
                tst.l   $1C(a5)
                bmi.s   Player_HandleFallingState_CheckUpperTerrain
                bpl.s   Player_HandleFallingState_UpdateLandingDelay
Player_HandleFallingState_ApplyGravity:                 ; CODE XREF: Player_HandleFallingState+18   j  ; was: loc_15D0A
                addi.l  #$8800,$1C(a5)
Player_HandleFallingState_UpdateTerrain:                ; CODE XREF: Player_HandleDeathSequence+11C   j  ; was: loc_15D12
                                        ; Player_HandleDeathSequence+128   j
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   Player_HandleFallingState_CheckUpperTerrain
Player_HandleFallingState_UpdateLandingDelay:           ; CODE XREF: Player_HandleFallingState+24   j  ; was: loc_15D1E
                tst.w   $4A(a5)
                bmi.s   Player_HandleFallingState_CheckLowerTerrain
                subq.w  #1,$4A(a5)
                bra.s   Player_HandleFallingState_ProcessInput
; ---------------------------------------------------------------------------
Player_HandleFallingState_CheckLowerTerrain:            ; CODE XREF: Player_HandleFallingState+3E   j  ; was: loc_15D2A
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   Player_HandleFallingState_ProcessInput
; ---------------------------------------------------------------------------
Player_HandleFallingState_CheckUpperTerrain:            ; CODE XREF: Player_HandleFallingState+22   j  ; was: loc_15D3A
                                        ; Player_HandleFallingState+38   j
                clr.b   6(a5)
                jsr     Physics_RisingTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                bne.w   Player_InitCeilingLandingState
                btst    #2,6(a5)
                beq.s   Player_HandleFallingState_ProcessInput
                btst    #0,$69(a5)
                bne.w   Player_InitHardLanding
Player_HandleFallingState_ProcessInput:                 ; CODE XREF: Player_HandleFallingState+44   j  ; was: loc_15D60
                                        ; Player_HandleFallingState+54   j
                btst    #0,(CounterForceTriggerFlag).w
                bne.w   Player_StartAirCounterForce
                btst    #5,$6A(a5)
                beq.s   Player_HandleFallingState_SelectControl
                btst    #1,$69(a5)
                bne.s   Player_HandleFallingState_TryDashAttack
                tst.b   (PlayerAirShotUsedFlag).w
                bne.s   Player_HandleFallingState_SelectControl
                bra.w   Player_InitSpecialAttack
; ---------------------------------------------------------------------------
Player_HandleFallingState_TryDashAttack:                ; CODE XREF: Player_HandleFallingState+94   j  ; was: loc_15D84
                tst.b   (PlayerAirDashUsedFlag).w
                bne.s   Player_HandleFallingState_SelectControl
                bra.w   Player_InitiateDashAttack_UseGroundState
; ---------------------------------------------------------------------------
Player_HandleFallingState_SelectControl:                ; CODE XREF: Player_HandleFallingState+8C   j  ; was: loc_15D8E
                                        ; Player_HandleFallingState+9A   j
                tst.w   $52(a5)
                bne.s   Player_HandleFallingState_ApplyAirControl
                btst    #4,$69(a5)
                bne.w   Player_HandleFallingState_ApplyManualControl
Player_HandleFallingState_ApplyAirControl:              ; CODE XREF: Player_HandleFallingState+AE   j  ; was: loc_15D9E
                bsr.w   Player_ApplyAirControl
                move.w  #2,d1
                tst.w   $52(a5)
                bne.w   Player_UpdateAnimationState
                bsr.w   Player_SelectFallPrimaryFrame
                bsr.w   Player_SelectFallAnimation
                moveq   #0,d5
                moveq   #0,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
Player_HandleFallingState_ApplyManualControl:           ; CODE XREF: Player_HandleFallingState+B6   j  ; was: loc_15DBE
                btst    #2,$69(a5)
                beq.s   Player_HandleFallingState_CheckRightInput
Player_HandleFallingState_AccelerateLeft:               ; CODE XREF: Player_HandleFallingState+144   j  ; was: loc_15DC6
                move.l  #$FFFC8000,d1
                btst    #3,$E(a5)
                beq.s   Player_HandleFallingState_ClampLeftVelocity
                move.l  #$FFFD4000,d1
Player_HandleFallingState_ClampLeftVelocity:            ; CODE XREF: Player_HandleFallingState+EE   j  ; was: loc_15DDA
                move.l  $18(a5),d0
                bpl.s   Player_HandleFallingState_StepLeftVelocity
                cmp.l   d1,d0
                bpl.s   Player_HandleFallingState_StepLeftVelocity
                move.l  d1,d0
                bra.s   Player_HandleFallingState_StoreVelocityAndRender
; ---------------------------------------------------------------------------
Player_HandleFallingState_StepLeftVelocity:             ; CODE XREF: Player_HandleFallingState+FA   j  ; was: loc_15DE8
                                        ; Player_HandleFallingState+FE   j
                subi.l  #$7777,d0
                bra.s   Player_HandleFallingState_StoreVelocityAndRender
; ---------------------------------------------------------------------------
Player_HandleFallingState_CheckRightInput:              ; CODE XREF: Player_HandleFallingState+E0   j  ; was: loc_15DF0
                btst    #3,$69(a5)
                beq.s   Player_HandleFallingState_CheckNeutralVelocity
Player_HandleFallingState_AccelerateRight:              ; CODE XREF: Player_HandleFallingState+142   j  ; was: loc_15DF8
                move.l  #$38000,d1
                btst    #3,$E(a5)
                bne.s   Player_HandleFallingState_ClampRightVelocity
                move.l  #$2C000,d1
Player_HandleFallingState_ClampRightVelocity:           ; CODE XREF: Player_HandleFallingState+120   j  ; was: loc_15E0C
                move.l  $18(a5),d0
                bmi.s   Player_HandleFallingState_StepRightVelocity
                cmp.l   d1,d0
                bmi.s   Player_HandleFallingState_StepRightVelocity
                move.l  d1,d0
                bra.s   Player_HandleFallingState_StoreVelocityAndRender
; ---------------------------------------------------------------------------
Player_HandleFallingState_StepRightVelocity:            ; CODE XREF: Player_HandleFallingState+12C   j  ; was: loc_15E1A
                                        ; Player_HandleFallingState+130   j
                addi.l  #$7777,d0
                bra.s   Player_HandleFallingState_StoreVelocityAndRender
; ---------------------------------------------------------------------------
Player_HandleFallingState_CheckNeutralVelocity:         ; CODE XREF: Player_HandleFallingState+112   j  ; was: loc_15E22
                move.l  $18(a5),d0
                bmi.s   Player_HandleFallingState_AccelerateRight
                bne.s   Player_HandleFallingState_AccelerateLeft
Player_HandleFallingState_StoreVelocityAndRender:       ; CODE XREF: Player_HandleFallingState+102   j  ; was: loc_15E2A
                                        ; Player_HandleFallingState+10A   j
                move.l  d0,$18(a5)
                bsr.w   Player_SelectFallAnimation
                lea     (Player_PrimaryLayoutMuzzleOffsets0).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #3,d6
                bra.w   Player_PrepareSpriteRendering
; End of function Player_HandleFallingState
; Selects the primary fall-animation frame from vertical velocity
Player_SelectFallPrimaryFrame:                          ; CODE XREF: Player_HandleFallingState+CA   p  ; was: sub_15E40
                tst.w   $1C(a5)
                bmi.s   Player_SelectFallPrimaryFrame_UseDefault
                cmpi.w  #3,$1C(a5)
                bmi.s   Player_SelectFallPrimaryFrame_UseDefault
                movea.l #Player_FastFallPrimarySpriteMapping,a1
                rts
; ---------------------------------------------------------------------------
Player_SelectFallPrimaryFrame_UseDefault:               ; CODE XREF: Player_SelectFallPrimaryFrame+4   j  ; was: loc_15E56
                                        ; Player_SelectFallPrimaryFrame+C   j
                movea.l #Player_FallPrimarySpriteMapping,a1
                rts
; End of function Player_SelectFallPrimaryFrame
; Selects animation based on falling velocity
Player_SelectFallAnimation:                             ; CODE XREF: Player_HandleFallingState+CE   p  ; was: sub_15E5E
                                        ; Player_HandleFallingState+14A   p
                move.w  $1C(a5),d0
                bpl.s   Player_SelectFallAnimation_UseAbsoluteSpeed
                neg.w   d0
Player_SelectFallAnimation_UseAbsoluteSpeed:            ; CODE XREF: Player_SelectFallAnimation+4   j  ; was: loc_15E66
                cmpi.w  #7,d0
                bpl.s   Player_SelectFallAnimation_UseFastFrame
                cmpi.w  #2,d0
                bmi.s   Player_SelectFallAnimation_UseFastFrame
                tst.w   $1C(a5)
                bmi.s   Player_SelectFallAnimation_UseRisingFrame
                movea.l #Player_FallingSecondarySpriteMapping,a2
                rts
; ---------------------------------------------------------------------------
Player_SelectFallAnimation_UseFastFrame:                ; CODE XREF: Player_SelectFallAnimation+C   j  ; was: loc_15E80
                                        ; Player_SelectFallAnimation+12   j
                movea.l #Player_FastVerticalSecondarySpriteMapping,a2
                rts
; ---------------------------------------------------------------------------
Player_SelectFallAnimation_UseRisingFrame:              ; CODE XREF: Player_SelectFallAnimation+18   j  ; was: loc_15E88
                movea.l #Player_RisingSecondarySpriteMapping,a2
                rts
; End of function Player_SelectFallAnimation
; Initializes hard landing state with terrain alignment and downward velocity
Player_InitHardLanding:                                 ; CODE XREF: Player_HandleFallingState+78   j  ; was: sub_15E90
                jsr     (Physics_AlignToTerrain).l
                move.w  #$12,4(a5)
                move.l  #$FFF86000,$1C(a5)
                clr.l   $18(a5)
                move.w  #6,$52(a5)
                move.b  #$7F,(PlayerInputMask).w
                rts
; End of function Player_InitHardLanding
; Handles bounce state with gravity and terrain collision checks
Player_HandleBounceState:                               ; DATA XREF: ROM:00015074   o  ; was: sub_15EB6
                bset    #0,(byte_FF8244).w
                addi.l  #$8800,$1C(a5)
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                tst.w   $1C(a5)
                bmi.s   Player_HandleBounceState_CheckUpperTerrain
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   Player_HandleBounceState_AdvanceAnimation
; ---------------------------------------------------------------------------
Player_HandleBounceState_CheckUpperTerrain:             ; CODE XREF: Player_HandleBounceState+18   j  ; was: loc_15EE0
                clr.b   6(a5)
                jsr     Physics_RisingTerrainCheckWrapper(pc)  ; (pc)
                nop
                btst    #1,6(a5)
                bne.w   Player_InitCeilingLandingState
Player_HandleBounceState_AdvanceAnimation:              ; CODE XREF: Player_HandleBounceState+28   j  ; was: loc_15EF4
                cmpi.w  #$38,$52(a5)                    ; '8'
                bpl.w   Player_InitFallState
                moveq   #2,d1
                bra.w   Player_AdvanceAnimationFrame
; End of function Player_HandleBounceState
; Applies horizontal air control input
Player_ApplyAirControl:                                 ; CODE XREF: Player_HandleFallingState:Player_HandleFallingState_ApplyAirControl   p  ; was: sub_15F04
                btst    #2,$69(a5)
                beq.s   Player_ApplyAirControl_CheckRight
                bclr    #3,$E(a5)
                move.l  $18(a5),d0
                bpl.s   Player_ApplyAirControl_AccelerateLeft
                cmpi.l  #$FFFC8000,d0
                bpl.s   Player_ApplyAirControl_AccelerateLeft
                move.l  #$FFFC8000,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
Player_ApplyAirControl_AccelerateLeft:                  ; CODE XREF: Player_ApplyAirControl+12   j  ; was: loc_15F28
                                        ; Player_ApplyAirControl+1A   j
                subi.l  #$7777,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
Player_ApplyAirControl_CheckRight:                      ; CODE XREF: Player_ApplyAirControl+6   j  ; was: loc_15F30
                btst    #3,$69(a5)
                beq.s   Player_ApplyAirControl_HandleNeutral
                bset    #3,$E(a5)
                move.l  $18(a5),d0
                bmi.s   Player_ApplyAirControl_AccelerateRight
                cmpi.l  #$38000,d0
                bmi.s   Player_ApplyAirControl_AccelerateRight
                move.l  #$38000,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
Player_ApplyAirControl_AccelerateRight:                 ; CODE XREF: Player_ApplyAirControl+3E   j  ; was: loc_15F54
                                        ; Player_ApplyAirControl+46   j
                addi.l  #$7777,d0
                bra.s   Player_ApplyHorizontalVelocity
; ---------------------------------------------------------------------------
Player_ApplyAirControl_HandleNeutral:                   ; CODE XREF: Player_ApplyAirControl+32   j  ; was: loc_15F5C
                move.l  $18(a5),d0
                bmi.s   Player_ApplyAirControl_AccelerateRight
                bne.s   Player_ApplyAirControl_AccelerateLeft
; Stores the calculated horizontal velocity
Player_ApplyHorizontalVelocity:                         ; CODE XREF: Player_ApplyAirControl+22   j  ; was: loc_15F64
                                        ; Player_ApplyAirControl+2A   j
                move.l  d0,$18(a5)
                rts
; End of function Player_ApplyAirControl
; Initializes special attack state
Player_InitSpecialAttack:                               ; CODE XREF: Player_HandleFallingState+9C   j  ; was: sub_15F6A
                bclr    #0,(CounterForceTriggerFlag).w
                move.b  #$7F,(PlayerInputMask).w
                move.w  #$4E,4(a5)                      ; 'N'
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.w  #$C,$5C(a5)
                move.w  #$FFFF,$48(a5)
                clr.w   $4A(a5)
                move.w  #5,$4C(a5)
                move.b  #1,(PlayerAirShotUsedFlag).w
                movea.w #(PlayerEffectObjectPool-M68K_RAM),a0
                moveq   #7,d7
                jsr     (Sys_ClearObjectBlocks96).l
                move.b  #$B0,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Player_SpawnTripleShot
; End of function Player_InitSpecialAttack
; Handles special attack state logic
Player_HandleSpecialAttack:                             ; DATA XREF: ROM:000150B0   o  ; was: sub_15FC4
                subq.w  #1,$4C(a5)
                bpl.s   Player_HandleSpecialAttack_UpdateActive
                move.w  #$46,4(a5)                      ; 'F'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                bsr.w   Player_AutoFlipDirection
                bra.w   Player_SpecialMoveRecoveryState
; ---------------------------------------------------------------------------
Player_HandleSpecialAttack_UpdateActive:                ; CODE XREF: Player_HandleSpecialAttack+4   j  ; was: loc_15FE0
                bset    #0,(byte_FF8244).w
                bset    #6,(byte_FF8244).w
                jsr     Physics_ExtendedWallCheckWrapper(pc)  ; (pc)
                nop
                addi.l  #$C000,$1C(a5)
                bmi.s   Player_HandleSpecialAttack_CheckUpperTerrain
                clr.b   6(a5)
                bsr.w   Physics_DescendingTerrainCheckWrapper
                btst    #0,6(a5)
                bne.w   Player_InitLandingState
                bra.s   Player_HandleSpecialAttack_ProcessInput
; ---------------------------------------------------------------------------
Player_HandleSpecialAttack_CheckUpperTerrain:           ; CODE XREF: Player_HandleSpecialAttack+36   j  ; was: loc_16010
                clr.b   6(a5)
                bsr.w   Physics_RisingTerrainCheckWrapper
                btst    #1,6(a5)
                bne.w   Player_InitCeilingLandingState
Player_HandleSpecialAttack_ProcessInput:                ; CODE XREF: Player_HandleSpecialAttack+4A   j  ; was: loc_16022
                btst    #0,(CounterForceTriggerFlag).w
                bne.w   Player_StartAirCounterForce
                btst    #5,$6A(a5)
                beq.s   Player_HandleSpecialAttack_SelectFrame
                tst.b   (PlayerAirDashUsedFlag).w
                bne.s   Player_HandleSpecialAttack_CancelToFall
                btst    #1,$69(a5)
                bne.w   Player_InitiateDashAttack_UseGroundState
Player_HandleSpecialAttack_CancelToFall:                ; CODE XREF: Player_HandleSpecialAttack+74   j  ; was: loc_16044
                move.l  #$FFF80000,$1C(a5)
                move.w  #$FFE0,$52(a5)
                bra.w   Player_InitFallState_Finish
; ---------------------------------------------------------------------------
Player_HandleSpecialAttack_SelectFrame:                 ; CODE XREF: Player_HandleSpecialAttack+6E   j  ; was: loc_16056
                movea.l #Player_SpecialAttackSecondarySpriteMappingA,a2
                btst    #0,(FrameCounter+1).w
                bne.s   Player_HandleSpecialAttack_Render
                movea.l #Player_SpecialAttackSecondarySpriteMappingB,a2
Player_HandleSpecialAttack_Render:                      ; CODE XREF: Player_HandleSpecialAttack+9E   j  ; was: loc_1606A
                btst    #4,$69(a5)
                bne.w   Player_RenderSpecialAttackWithWeapon
                bsr.w   Player_UpdateHorizontalFacing
                movea.l #Player_CommonPrimarySpriteMapping,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                bra.w   Player_BuildSpritePieces
; ---------------------------------------------------------------------------
; Renders the armed special-attack animation branch
Player_RenderSpecialAttackWithWeapon:                   ; CODE XREF: Player_HandleSpecialAttack+AC   j  ; was: loc_16086
                lea     (Player_AlternateLayoutMuzzleOffsets0).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     Player_AlternateAnimationLayoutTable(pc),a0
                nop
                bra.w   Player_PrepareSpriteRendering_WithTables
; End of function Player_HandleSpecialAttack
