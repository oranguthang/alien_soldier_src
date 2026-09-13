Weapon_UpdateStateAndAmmoRegen:                         ; CODE XREF: Sys_GameplayMainLoop+B8   p  ; was: sub_178FE
                                        ; WeaponSetup_UpdateScreen+2A   p
                tst.b   (FrameControlFlags).w
                bmi.w   Weapon_UpdateStateAndAmmoRegenReturn
                bsr.w   Weapon_UpdateCurrentState
                move.w  (WeaponSlotOffset).w,d0
                cmpi.w  #$12,(WeaponStateIndex).w
                bmi.s   Weapon_SelectAmmoRegenSkipSlot
                moveq   #8,d0
Weapon_SelectAmmoRegenSkipSlot:                         ; CODE XREF: Weapon_UpdateStateAndAmmoRegen+16   j  ; was: loc_17918
                movea.w #(WeaponSlotConfig0-M68K_RAM),a0
                lea     Weapon_AmmoRegenStepDelays(pc),a1
                moveq   #0,d1
                moveq   #3,d7
Weapon_UpdateSlotAmmoRegenLoop:                         ; CODE XREF: Weapon_UpdateStateAndAmmoRegen+4E   j  ; was: loc_17924
                cmp.w   d0,d1
                beq.s   Weapon_AdvanceAmmoRegenSlot
                move.w  (a0),d2
                subq.w  #1,8(a0)
                bpl.s   Weapon_AdvanceAmmoRegenSlot
                move.w  (a1,d2.w),8(a0)
                addq.w  #2,$10(a0)
                move.w  $18(a0),d2
                cmp.w   $10(a0),d2
                bpl.s   Weapon_AdvanceAmmoRegenSlot
                move.w  d2,$10(a0)
; Advances to the next weapon slot in the ammunition-regeneration pass
Weapon_AdvanceAmmoRegenSlot:                            ; CODE XREF: Weapon_UpdateStateAndAmmoRegen+28   j  ; was: loc_17948
                                        ; Weapon_UpdateStateAndAmmoRegen+30   j
                addq.w  #2,a0
                addq.w  #2,d1
                dbf     d7,Weapon_UpdateSlotAmmoRegenLoop
; Return after updating weapon state and inactive-slot ammunition regeneration
Weapon_UpdateStateAndAmmoRegenReturn:                   ; CODE XREF: Weapon_UpdateStateAndAmmoRegen+4   j  ; was: locret_17950
                                        ; DATA XREF: ROM:Weapon_StateHandlerOffsets   o
                rts
; End of function Weapon_UpdateStateAndAmmoRegen
; Updates shared cooldowns and dispatches the current weapon state
Weapon_UpdateCurrentState:                              ; CODE XREF: Weapon_UpdateStateAndAmmoRegen+8   p  ; was: sub_17952
                movea.w (WeaponSlotOffset).w,a1
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a1
                lea     Weapon_DirectionVectorPointerBias(pc),a2
                nop
                tst.w   (WeaponFireCooldown).w
                bmi.s   Weapon_UpdateStateCooldown
                subq.w  #1,(WeaponFireCooldown).w
Weapon_UpdateStateCooldown:                             ; CODE XREF: Weapon_UpdateCurrentState+12   j  ; was: loc_1796A
                tst.w   (WeaponStateCooldown).w
                bmi.s   Weapon_DispatchCurrentState
                subq.w  #1,(WeaponStateCooldown).w
; Dispatches the handler selected by WeaponStateIndex
Weapon_DispatchCurrentState:                            ; CODE XREF: Weapon_UpdateCurrentState+1C   j  ; was: loc_17974
                move.w  (WeaponStateIndex).w,d0
                movea.w Weapon_StateHandlerOffsets(pc,d0.w),a0
                adda.l  #Weapon_GetStateDisplayIndex,a0
                jmp     (a0)
; End of function Weapon_UpdateCurrentState
; ---------------------------------------------------------------------------
Weapon_StateHandlerOffsets: dc.w    Weapon_UpdateStateAndAmmoRegenReturn-Weapon_GetStateDisplayIndex  ; was: off_17984
                                        ; DATA XREF: Weapon_UpdateCurrentState+26   r
                dc.w    Weapon_ConfigureState2Damage-Weapon_GetStateDisplayIndex
                dc.w    Weapon_ConfigureState4Indicators-Weapon_GetStateDisplayIndex
                dc.w    Weapon_ConfigureState6Motion-Weapon_GetStateDisplayIndex
                dc.w    Weapon_ConfigureState8Targeting-Weapon_GetStateDisplayIndex
                dc.w    Weapon_ConfigureState10Gauge-Weapon_GetStateDisplayIndex
                dc.w    Weapon_UpdateState12Icon-Weapon_GetStateDisplayIndex
                dc.w    Weapon_UpdateStateAndAmmoRegenReturn-Weapon_GetStateDisplayIndex
                dc.w    Weapon_UpdateStateAndAmmoRegenReturn-Weapon_GetStateDisplayIndex
                dc.w    WeaponSelect_Initialize-Weapon_GetStateDisplayIndex
                dc.w    WeaponSelect_Update-Weapon_GetStateDisplayIndex

; Returns the display index associated with WeaponStateIndex
Weapon_GetStateDisplayIndex:                            ; CODE XREF: UI_UpdateWeaponSelectionObject+76   p  ; was: sub_1799A
                                        ; UI_UpdateWeaponSelectionObject+B2   p
                                        ; DATA XREF:
                movea.w (WeaponSlotOffset).w,a0
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a0
                move.w  (WeaponStateIndex).w,d0
                move.w  Weapon_StateDisplayIndexTable(pc,d0.w),d0
                rts
; End of function Weapon_GetStateDisplayIndex
; ---------------------------------------------------------------------------
Weapon_StateDisplayIndexTable:  dc.w    0, 2, 4, 6, 8, $A, $C, $E, $10, 0, 0  ; was: word_179AC
                                        ; DATA XREF: Weapon_GetStateDisplayIndex+C   r

; Initializes the circular four-slot weapon-selection overlay
WeaponSelect_Initialize:                                ; DATA XREF: ROM:00017996   o  ; was: sub_179C2
                movea.w #(WeaponAmmoRegenTimers-M68K_RAM),a0
                move.w  (WeaponSlotOffset).w,d0
                move.w  #$258,(a0,d0.w)
                move.w  (WeaponSlotOffset).w,d0
                move.w  d0,(WeaponMenuSlotOffset).w
                addq.w  #2,(WeaponStateIndex).w
                bsr.w   Weapon_ClearRuntimeParameters
                move.w  #$14,(WeaponIconTransferState).w
                lea     WeaponSelect_TargetAngles(pc),a0
                nop
                move.w  (WeaponMenuSlotOffset).w,d1
                move.w  (a0,d1.w),d1
                addi.w  #$100,d1
                andi.w  #$1FF,d1
                move.w  d1,(WeaponMenuAngle).w
                move.w  #$A0,(WeaponMenuRadius).w
                move.w  d0,(WeaponFireCooldown).w
                bsr.w   Sys_ClearObjectBlocks17
                movea.w #(PlayerEffectObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.l  #SharedCombatSpriteAnimation13,8(a0)
                move.w  #$E080,2(a0)
                move.w  #$80,$10(a0)
                move.w  #$80,$14(a0)
                move.w  #$C80,$E(a0)
                move.w  (GlobalSpritePriorityBit).w,d6
                or.w    d6,$E(a0)
                movea.w #(PlayerEffectAllocStart-M68K_RAM),a0
                movea.w #(WeaponSlotConfig0-M68K_RAM),a1
                lea     WeaponSelect_SlotInitialAngles(pc),a3
                nop
                lea     WeaponSelect_SpriteFramePointers(pc),a4
                movea.w #(PlayerObjectType-M68K_RAM),a5
                move.w  (GlobalSpritePriorityBit).w,d3
                moveq   #0,d4
                moveq   #3,d7
; Initializes all four weapon-selection slot objects
WeaponSelect_InitializeSlotLoop:                        ; CODE XREF: WeaponSelect_Initialize+CC   j  ; was: loc_17A5C
                move.w  #$3C,(a0)                       ; '<'
                move.w  #$C080,2(a0)
                move.w  $10(a2),$10(a0)
                move.w  $14(a2),$14(a0)
                move.w  d3,$E(a0)
                move.w  (a1)+,d0
                asl.w   #1,d0
                move.l  (a4,d0.w),8(a0)
                move.w  d4,$48(a0)
                move.w  (a3)+,$50(a0)
                addq.w  #2,d4
                lea     $60(a0),a0
                dbf     d7,WeaponSelect_InitializeSlotLoop
                move.b  #$C0,d0
                jmp     (Sound_PlaySFX).l
; End of function WeaponSelect_Initialize
; ---------------------------------------------------------------------------
WeaponSelect_SlotInitialAngles: dc.w    $180, 0, $80, $100  ; DATA XREF: WeaponSelect_Initialize+84   o  ; was: word_17A9C
WeaponSelect_TargetAngles:      dc.w    0, $180, $100, $80  ; DATA XREF: WeaponSelect_Initialize+24   o  ; was: word_17AA4
                                        ; WeaponSelect_UpdateRotationInput+8   r

; Rotates the overlay toward the currently selected slot
WeaponSelect_UpdateRotationInput:                       ; CODE XREF: WeaponSelect_Update:WeaponSelect_HandleOpenInput   p  ; was: sub_17AAC
                move.w  (WeaponMenuAngle).w,d0
                move.w  (WeaponMenuSlotOffset).w,d1
                cmp.w   WeaponSelect_TargetAngles(pc,d1.w),d0
                beq.s   WeaponSelect_CheckInputBit3
                add.w   (WeaponMenuAngularStep).w,d0
                andi.w  #$1F0,d0
                move.w  d0,(WeaponMenuAngle).w
                rts
; ---------------------------------------------------------------------------
WeaponSelect_CheckInputBit3:                            ; CODE XREF: WeaponSelect_UpdateRotationInput+C   j  ; was: loc_17AC8
                btst    #3,(PlayerPressedInput).w
                beq.s   WeaponSelect_CheckInputBit2
                move.w  #$FFF0,(WeaponMenuAngularStep).w
                addq.w  #2,(WeaponMenuSlotOffset).w
                andi.w  #6,(WeaponMenuSlotOffset).w
                move.b  #$A8,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
WeaponSelect_CheckInputBit2:                            ; CODE XREF: WeaponSelect_UpdateRotationInput+22   j  ; was: loc_17AEA
                btst    #2,(PlayerPressedInput).w
                beq.s   WeaponSelect_RotationInputReturn
                move.w  #$10,(WeaponMenuAngularStep).w
                subq.w  #2,(WeaponMenuSlotOffset).w
                andi.w  #6,(WeaponMenuSlotOffset).w
                move.b  #$A8,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
WeaponSelect_RotationInputReturn:                       ; CODE XREF: WeaponSelect_UpdateRotationInput+44   j  ; was: locret_17B0C
                rts
; End of function WeaponSelect_UpdateRotationInput
; Maps directional input bits to one of the four weapon slots
WeaponSelect_HandleDirectionalInput:                    ; was: sub_17B0E
                move.b  (PlayerPressedInput).w,d0
                andi.b  #$F,d0
                beq.s   WeaponSelect_DirectionalInputReturn
                move.b  #$A8,d0
                jsr     (Sound_PlaySFX).l
                move.b  (PlayerPressedInput).w,d0
                btst    #0,d0
                beq.s   WeaponSelect_CheckInputBit1
                move.w  #0,(WeaponMenuSlotOffset).w
WeaponSelect_DirectionalInputReturn:                    ; CODE XREF: WeaponSelect_HandleDirectionalInput+8   j  ; was: locret_17B32
                                        ; WeaponSelect_HandleDirectionalInput+46   j
                rts
; ---------------------------------------------------------------------------
WeaponSelect_CheckInputBit1:                            ; CODE XREF: WeaponSelect_HandleDirectionalInput+1C   j  ; was: loc_17B34
                btst    #1,d0
                beq.s   WeaponSelect_CheckDirectionalBit3
                move.w  #4,(WeaponMenuSlotOffset).w
                rts
; ---------------------------------------------------------------------------
WeaponSelect_CheckDirectionalBit3:                      ; CODE XREF: WeaponSelect_HandleDirectionalInput+2A   j  ; was: loc_17B42
                btst    #3,d0
                beq.s   WeaponSelect_CheckDirectionalBit2
                move.w  #2,(WeaponMenuSlotOffset).w
                rts
; ---------------------------------------------------------------------------
WeaponSelect_CheckDirectionalBit2:                      ; CODE XREF: WeaponSelect_HandleDirectionalInput+38   j  ; was: loc_17B50
                btst    #2,d0
                beq.s   WeaponSelect_DirectionalInputReturn
                move.w  #6,(WeaponMenuSlotOffset).w
                rts
; End of function WeaponSelect_HandleDirectionalInput
; Clears shared weapon damage, motion, targeting, and icon parameters
Weapon_ClearRuntimeParameters:                          ; CODE XREF: WeaponSelect_Initialize+1A   p  ; was: sub_17B5E
                                        ; Weapon_AdvanceCurrentState+16   p
                moveq   #0,d0
                move.w  d0,(WeaponTargetOrFrame).w
                move.w  d0,(WeaponIconFrameTile).w
                move.w  d0,(WeaponAnimationDataPtr).w
                move.w  d0,(WeaponAnimationDataPtr+2).w
                move.w  d0,(WeaponYMotionParameter).w
                move.w  d0,(WeaponYMotionParameter+2).w
                move.w  d0,(WeaponXMotionParameter).w
                move.w  d0,(WeaponXMotionParameter+2).w
                move.w  d0,(WeaponModeParameter).w
                move.w  d0,(WeaponModeParameter+2).w
                rts
; End of function Weapon_ClearRuntimeParameters
; Updates the weapon-selection overlay and handles its close transition
WeaponSelect_Update:                                    ; DATA XREF: ROM:00017998   o  ; was: sub_17B8A
                bsr.w   WeaponSelect_CommitSelectedSlot
                tst.w   (PlayerDefeatPhase).w
                bne.w   WeaponSelect_StartCloseDelay
                btst    #6,(byte_FF8244).w
                bne.s   WeaponSelect_UpdateOpenState
                btst    #0,(byte_FF8244).w
                bne.w   Weapon_CommitStateTransition
WeaponSelect_UpdateOpenState:                           ; CODE XREF: WeaponSelect_Update+12   j  ; was: loc_17BA8
                tst.w   (PlayerScriptStateOffset).w
                bne.w   Weapon_CommitStateTransition
                subi.w  #8,(WeaponMenuRadius).w
                cmpi.w  #$20,(WeaponMenuRadius).w       ; ' '
                bmi.s   WeaponSelect_HandleOpenInput
                moveq   #$10,d0
                btst    #3,(PlayerSpriteAttributes).w
                bne.s   WeaponSelect_ApplyFacingRotationStep
                moveq   #$FFFFFFF0,d0
WeaponSelect_ApplyFacingRotationStep:                   ; CODE XREF: WeaponSelect_Update+3C   j  ; was: loc_17BCA
                add.w   d0,(WeaponMenuAngle).w
                andi.w  #$1F8,(WeaponMenuAngle).w
                rts
; ---------------------------------------------------------------------------
WeaponSelect_HandleOpenInput:                           ; CODE XREF: WeaponSelect_Update+32   j  ; was: loc_17BD6
                bsr.w   WeaponSelect_UpdateRotationInput
                move.w  #$20,(WeaponMenuRadius).w       ; ' '
                move.b  (PlayerPressedInput).w,d0
                andi.b  #$70,d0                         ; 'p'
                bne.s   WeaponSelect_StartCloseDelay
                rts
; ---------------------------------------------------------------------------
WeaponSelect_StartCloseDelay:                           ; CODE XREF: WeaponSelect_Update+8   j  ; was: loc_17BEC
                                        ; WeaponSelect_Update+5E   j
                move.b  #$A7,d0
                jsr     (Sound_PlaySFX).l
                move.w  #8,(WeaponStateCooldown).w
; End of function WeaponSelect_Update
; Advances the selected slot's weapon state and clears transient state
Weapon_AdvanceCurrentState:                             ; CODE XREF: Player_InitializeStats+76   j  ; was: sub_17BFC
                                        ; WeaponSetup_HandleLoadoutInput+7A   p
                movea.w (WeaponSlotOffset).w,a0
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(WeaponStateIndex).w
                asl.w   #1,d0
                move.w  d0,(WeaponIconTransferState).w
                bsr.w   Weapon_ClearRuntimeParameters
                bra.w   Sys_ClearObjectBlocks16
; End of function Weapon_AdvanceCurrentState
; Commits a state transition, restoring the saved slot when required
Weapon_CommitStateTransition:                           ; CODE XREF: WeaponSelect_Update+1A   j  ; was: sub_17C1A
                                        ; WeaponSelect_Update+22   j
                move.w  (WeaponStateIndex).w,d0
                bne.s   Weapon_CheckRestoreSavedSlot
                clr.w   (WeaponSavedSlotOffset).w
                bra.s   Weapon_RestoreSavedSlot
; ---------------------------------------------------------------------------
Weapon_CheckRestoreSavedSlot:                           ; CODE XREF: Weapon_CommitStateTransition+4   j  ; was: loc_17C26
                cmpi.w  #$12,d0
                bmi.s   Weapon_CommitStateIndex
Weapon_RestoreSavedSlot:                                ; CODE XREF: Weapon_CommitStateTransition+A   j  ; was: loc_17C2C
                movea.w (WeaponSavedSlotOffset).w,a0
                move.w  a0,(WeaponSlotOffset).w
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(WeaponStateIndex).w
Weapon_CommitStateIndex:                                ; CODE XREF: Weapon_CommitStateTransition+10   j  ; was: loc_17C40
                asl.w   #1,d0
                move.w  d0,(WeaponIconTransferState).w
                clr.w   (WeaponStateCooldown).w
                bra.w   Sys_ClearObjectBlocks16
; End of function Weapon_CommitStateTransition
; Commits the menu slot offset as the active weapon slot
WeaponSelect_CommitSelectedSlot:                        ; CODE XREF: WeaponSelect_Update   p  ; was: sub_17C4E
                move.w  (WeaponMenuSlotOffset).w,(WeaponSlotOffset).w
                rts
; End of function WeaponSelect_CommitSelectedSlot
; Selects state-two projectile damage from the active slot's remaining ammo
Weapon_ConfigureState2Damage:                           ; DATA XREF: ROM:00017986   o  ; was: sub_17C56
                moveq   #$E,d0
                move.w  $10(a1),d1
                cmpi.w  #$708,d1
                bpl.s   Weapon_StoreState2Damage
                subq.w  #2,d0
                cmpi.w  #$3E8,d1
                bpl.s   Weapon_StoreState2Damage
                subq.w  #2,d0
                cmpi.w  #$320,d1
                bpl.s   Weapon_StoreState2Damage
                subq.w  #2,d0
Weapon_StoreState2Damage:                               ; CODE XREF: Weapon_ConfigureState2Damage+A   j  ; was: loc_17C74
                                        ; Weapon_ConfigureState2Damage+12   j
                move.w  d0,(WeaponModeParameter).w
                bra.w   Weapon_UpdateTargetingReticle
; End of function Weapon_ConfigureState2Damage
; Initializes four state-four indicator objects and their threshold flag
Weapon_ConfigureState4Indicators:                       ; DATA XREF: ROM:00017988   o  ; was: sub_17C7C
                movea.w #(PlayerEffectObjectPool-M68K_RAM),a0
                moveq   #3,d7
Weapon_State4IndicatorInitLoop:                         ; CODE XREF: Weapon_ConfigureState4Indicators+1E   j  ; was: loc_17C82
                tst.w   (a0)
                bne.s   Weapon_State4NextIndicator
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$22C,$48(a0)
Weapon_State4NextIndicator:                             ; CODE XREF: Weapon_ConfigureState4Indicators+8   j  ; was: loc_17C96
                lea     $C0(a0),a0
                dbf     d7,Weapon_State4IndicatorInitLoop
                clr.w   (WeaponModeParameter).w
                move.w  $10(a1),d0
                cmpi.w  #$320,d0
                bmi.s   Weapon_FinishState4Indicators
                addq.w  #1,(WeaponModeParameter).w
; Continues state-four processing through the targeting reticle update
Weapon_FinishState4Indicators:                          ; CODE XREF: Weapon_ConfigureState4Indicators+2E   j  ; was: loc_17CB0
                bra.w   Weapon_UpdateTargetingReticle
; End of function Weapon_ConfigureState4Indicators
; Configures state-six velocity and its ammo-indexed motion table
Weapon_ConfigureState6Motion:                           ; DATA XREF: ROM:0001798A   o  ; was: sub_17CB4
                move.w  (FrameCounter).w,d0
                btst    #7,d0
                bne.s   Weapon_State6SelectSpeedFromAmmo
                andi.w  #$7F,d0
                cmpi.w  #$40,d0                         ; '@'
                bmi.s   Weapon_State6SelectSpeedFromAmmo
                move.w  (RandomNumberState).w,d3
                andi.w  #1,d3
                addq.w  #3,d3
                bra.s   Weapon_State6CalculateVelocity
; ---------------------------------------------------------------------------
Weapon_State6SelectSpeedFromAmmo:                       ; CODE XREF: Weapon_ConfigureState6Motion+8   j  ; was: loc_17CD4
                                        ; Weapon_ConfigureState6Motion+12   j
                move.w  $10(a1),d0
                moveq   #2,d3
                cmpi.w  #$3E8,d0
                bmi.s   Weapon_State6CalculateVelocity
                moveq   #3,d3
                cmpi.w  #$708,d0
                bmi.s   Weapon_State6CalculateVelocity
                moveq   #4,d3
Weapon_State6CalculateVelocity:                         ; CODE XREF: Weapon_ConfigureState6Motion+1E   j  ; was: loc_17CEA
                                        ; Weapon_ConfigureState6Motion+2A   j
                movea.l #Math_SineTable,a0
                move.w  (RandomNumberState).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d3,d2
                move.l  d1,(WeaponYMotionParameter).w
                move.l  (StageMotionXDelta).w,d0
                asl.l   #1,d0
                add.l   d0,d2
                move.l  d2,(WeaponXMotionParameter).w
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$7D0,d0
                bmi.s   Weapon_State6SelectMotionTable
                move.l  #Weapon_DirectionVectorsSpeed13,(WeaponModeParameter).w
                rts
; ---------------------------------------------------------------------------
Weapon_State6SelectMotionTable:                         ; CODE XREF: Weapon_ConfigureState6Motion+6E   j  ; was: loc_17D2E
                subq.w  #8,d0
                bpl.s   Weapon_State6ClampMotionIndex
                moveq   #0,d0
Weapon_State6ClampMotionIndex:                          ; CODE XREF: Weapon_ConfigureState6Motion+7C   j  ; was: loc_17D34
                divs.w  #$FA,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  (a2,d0.w),(WeaponModeParameter).w
                rts
; End of function Weapon_ConfigureState6Motion
; Configures state-eight motion data and selects an eligible target
Weapon_ConfigureState8Targeting:                        ; DATA XREF: ROM:0001798C   o  ; was: sub_17D46
                move.w  #0,(WeaponXMotionParameter+2).w
                moveq   #0,d0
                move.w  $10(a1),d0
                bne.s   Weapon_State8SelectMotionTable
                move.w  #1,(WeaponXMotionParameter+2).w
Weapon_State8SelectMotionTable:                         ; CODE XREF: Weapon_ConfigureState8Targeting+C   j  ; was: loc_17D5A
                cmpi.w  #$3E8,d0
                bmi.s   Weapon_State8CalculateMotionIndex
                moveq   #$1C,d0
                bra.s   Weapon_State8StoreMotionTable
; ---------------------------------------------------------------------------
Weapon_State8CalculateMotionIndex:                      ; CODE XREF: Weapon_ConfigureState8Targeting+18   j  ; was: loc_17D64
                subq.w  #8,d0
                bpl.s   Weapon_State8ClampMotionIndex
                moveq   #0,d0
Weapon_State8ClampMotionIndex:                          ; CODE XREF: Weapon_ConfigureState8Targeting+20   j  ; was: loc_17D6A
                divs.w  #$7D,d0                         ; '}'
                asl.w   #2,d0
                andi.w  #$1C,d0
Weapon_State8StoreMotionTable:                          ; CODE XREF: Weapon_ConfigureState8Targeting+1C   j  ; was: loc_17D74
                move.l  -$C(a2,d0.w),(WeaponModeParameter).w
                movea.w #(PlayerEffectObjectPool-M68K_RAM),a0
                moveq   #3,d7
Weapon_State8IndicatorInitLoop:                         ; CODE XREF: Weapon_ConfigureState8Targeting+52   j  ; was: loc_17D80
                tst.w   (a0)
                bne.s   Weapon_State8NextIndicator
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$6C,$48(a0)                    ; 'l'
Weapon_State8NextIndicator:                             ; CODE XREF: Weapon_ConfigureState8Targeting+3C   j  ; was: loc_17D94
                lea     $C0(a0),a0
                dbf     d7,Weapon_State8IndicatorInitLoop
                clr.w   (WeaponTargetOrFrame).w
                move.w  (LockOnListCountMinus1).w,d7
                bmi.s   Weapon_State8SelectLowestValueTarget
                movea.w #(LockOnTargetList-M68K_RAM),a1
Weapon_State8FindFlaggedTarget:                         ; CODE XREF: Weapon_ConfigureState8Targeting+6E   j  ; was: loc_17DAA
                movea.w (a1)+,a0
                btst    #7,$23(a0)
                bne.s   Weapon_State8UseFlaggedTarget
                dbf     d7,Weapon_State8FindFlaggedTarget
                rts
; ---------------------------------------------------------------------------
Weapon_State8UseFlaggedTarget:                          ; CODE XREF: Weapon_ConfigureState8Targeting+6C   j  ; was: loc_17DBA
                move.w  a0,(WeaponTargetOrFrame).w
                btst    #4,(ControllerHeldState).w
                beq.w   Weapon_UpdateTargetingReticle_Scan
                moveq   #1,d6
                bra.w   Weapon_AppendTargetingReticleForObject
; ---------------------------------------------------------------------------
Weapon_State8SelectLowestValueTarget:                   ; CODE XREF: Weapon_ConfigureState8Targeting+5E   j  ; was: loc_17DCE
                move.w  (TargetListCountMinus1).w,d7
                bmi.s   Weapon_State8TargetSelectionReturn
                movea.w #(CollisionTargetList-M68K_RAM),a0
                movea.w (a0)+,a1
                move.w  $24(a1),d0
Weapon_State8CompareTargetValue:                        ; CODE XREF: Weapon_ConfigureState8Targeting+A8   j  ; was: loc_17DDE
                                        ; Weapon_ConfigureState8Targeting+AA   j
                dbf     d7,Weapon_State8CheckNextTarget
                move.w  a1,(WeaponTargetOrFrame).w
Weapon_State8TargetSelectionReturn:                     ; CODE XREF: Weapon_ConfigureState8Targeting+8C   j  ; was: locret_17DE6
                rts
; ---------------------------------------------------------------------------
Weapon_State8CheckNextTarget:                           ; CODE XREF: Weapon_ConfigureState8Targeting:Weapon_State8CompareTargetValue   j  ; was: loc_17DE8
                movea.w (a0)+,a2
                cmp.w   $24(a2),d0
                beq.s   Weapon_State8CompareTargetValue
                bmi.s   Weapon_State8CompareTargetValue
                movea.w a2,a1
                move.w  $24(a1),d0
                bra.s   Weapon_State8CompareTargetValue
; End of function Weapon_ConfigureState8Targeting
; Configures state-ten motion data and its animated gauge palette
Weapon_ConfigureState10Gauge:                           ; DATA XREF: ROM:0001798E   o  ; was: sub_17DFA
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$3E8,d0
                bmi.s   Weapon_State10CalculateGaugeLevel
                move.l  #Weapon_DirectionVectorsSpeed12,(WeaponModeParameter).w
                bra.s   Weapon_UpdateState10GaugePalette
; ---------------------------------------------------------------------------
Weapon_State10CalculateGaugeLevel:                      ; CODE XREF: Weapon_ConfigureState10Gauge+A   j  ; was: loc_17E10
                subq.w  #8,d0
                bpl.s   Weapon_State10ClampGaugeLevel
                moveq   #0,d0
Weapon_State10ClampGaugeLevel:                          ; CODE XREF: Weapon_ConfigureState10Gauge+18   j  ; was: loc_17E16
                divs.w  #$80,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  -8(a2,d0.w),(WeaponModeParameter).w
; Writes the state-ten gauge color to both palette buffers
Weapon_UpdateState10GaugePalette:                       ; CODE XREF: Weapon_ConfigureState10Gauge+14   j  ; was: loc_17E26
                move.w  (FrameCounter).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  Weapon_State10GaugePaletteCycle(pc,d0.w),(PaletteActiveColor54).w
                move.w  Weapon_State10GaugePaletteCycle(pc,d0.w),(PaletteShadowColor54).w
                rts
; End of function Weapon_ConfigureState10Gauge
; ---------------------------------------------------------------------------
Weapon_State10GaugePaletteCycle:    dc.w    $EEE, $EA6, $ECC, $E44  ; was: word_17E3E
                                        ; DATA XREF: Weapon_ConfigureState10Gauge+36   r
                                        ; Weapon_ConfigureState10Gauge+3C   r

; Advances the state-twelve icon animation and queues its DMA transfer
Weapon_UpdateState12Icon:                               ; DATA XREF: ROM:00017990   o  ; was: sub_17E46
                tst.l   (WeaponAnimationDataPtr).w
                bne.s   Weapon_State12AdvanceIconFrame
Weapon_State12IconReturn:                               ; CODE XREF: Weapon_UpdateState12Icon+10   j  ; was: locret_17E4C
                rts
; ---------------------------------------------------------------------------
Weapon_State12AdvanceIconFrame:                         ; CODE XREF: Weapon_UpdateState12Icon+4   j  ; was: loc_17E4E
                move.w  (WeaponTargetOrFrame).w,d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   Weapon_State12IconReturn
                addq.w  #2,(WeaponTargetOrFrame).w
                andi.w  #$1E,d0
                tst.w   (ShootingMode).w
                beq.s   Weapon_LoadState12IconFrame
                addi.w  #$20,d0                         ; ' '
; Selects the state-twelve palette/frame and queues its DMA transfer
Weapon_LoadState12IconFrame:                            ; CODE XREF: Weapon_UpdateState12Icon+1E   j  ; was: loc_17E6A
                move.w  Weapon_State12IconPaletteRamp(pc,d0.w),(PaletteActiveColor54).w
                move.w  Weapon_State12IconPaletteRamp(pc,d0.w),(PaletteShadowColor54).w
                lsr.w   #1,d0
                andi.w  #$E,d0
                movea.l (WeaponAnimationDataPtr).w,a0
                move.w  $20(a0,d0.w),(WeaponIconFrameTile).w
                asl.w   #1,d0
                move.l  (a0,d0.w),d0
                move.l  #$94009340,d1
                jmp     UI_QueueWeaponStateIconTransferFromSource
; End of function Weapon_UpdateState12Icon
; ---------------------------------------------------------------------------
Weapon_State12IconPaletteRamp:  dc.w    $EEE, $CEE, $AEE, $8EC, $6EC, $4EA, $2EA, $2E8, $2E8, $E6, $E6, $E4, $E4, $E2, $E2, $C0  ; was: word_17E98
                                        ; DATA XREF: Weapon_UpdateState12Icon:loc_17E6A   r
                                        ; Weapon_UpdateState12Icon+2A   r
                dc.w    $EEE, $EEC, $EEA, $8CE, $6CE, $4AE, $2AE, $28E, $28E, $6E, $6E, $4E, $4E, $2E, $2E, $C
