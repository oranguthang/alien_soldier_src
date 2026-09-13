; Handles shooting-mode input on the weapon-setup screen
WeaponSetup_HandleShootingModeInput:                    ; was: sub_1F1B2
                bsr.w   WeaponSetup_RenderSlotSprites
                bsr.w   WeaponSetup_UpdateHorizontalScroll
                bne.w   WeaponSetup_RenderLoadout
                bsr.w   WeaponSetup_RefillAmmo
                move.w  (ShootingMode).w,d1
                beq.s   WeaponSetup_CheckFixedShootingModeInput
                btst    #2,(ControllerPressedState).w
                beq.s   WeaponSetup_CheckFixedShootingModeInput
                moveq   #0,d1
WeaponSetup_CheckFixedShootingModeInput:                ; CODE XREF: WeaponSetup_HandleShootingModeInput+14   j  ; was: loc_1F1D2
                                        ; WeaponSetup_HandleShootingModeInput+1C   j
                tst.w   d1
                bne.s   WeaponSetup_CommitShootingModeInput
                btst    #3,(ControllerPressedState).w
                beq.s   WeaponSetup_CommitShootingModeInput
                moveq   #2,d1
WeaponSetup_CommitShootingModeInput:                    ; CODE XREF: WeaponSetup_HandleShootingModeInput+22   j  ; was: loc_1F1E0
                                        ; WeaponSetup_HandleShootingModeInput+2A   j
                cmp.w   (ShootingMode).w,d1
                beq.s   WeaponSetup_CheckShootingModeAdvance
                move.w  d1,(ShootingMode).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
WeaponSetup_CheckShootingModeAdvance:                   ; CODE XREF: WeaponSetup_HandleShootingModeInput+32   j  ; was: loc_1F1F4
                move.b  (ControllerPressedState).w,d0
                btst    #1,d0
                bne.s   WeaponSetup_AdvanceFromShootingMode
                andi.b  #$E0,d0
                beq.s   WeaponSetup_CheckShootingModeReturn
WeaponSetup_AdvanceFromShootingMode:                    ; CODE XREF: WeaponSetup_HandleShootingModeInput+4A   j  ; was: loc_1F204
                addq.w  #2,(SetupTransitionIndex).w
                subi.w  #$10,(WeaponSetupScrollTarget).w
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
                bra.w   WeaponSetup_RenderShootingModeOptions
; ---------------------------------------------------------------------------
WeaponSetup_CheckShootingModeReturn:                    ; CODE XREF: WeaponSetup_HandleShootingModeInput+50   j  ; was: loc_1F21C
                btst    #4,(ControllerPressedState).w
                beq.w   WeaponSetup_RenderShootingModeOptions
                subq.w  #2,(SetupTransitionIndex).w
                clr.w   (WeaponSetupScrollTarget).w
                move.w  #$12,(PlayerScriptStateOffset).w
                bra.w   WeaponSetup_RenderShootingModeOptions
; End of function WeaponSetup_HandleShootingModeInput
; Selects one of the 26 controller layouts and handles page navigation
WeaponSetup_HandleControlTypeInput:                     ; DATA XREF: ROM:0001F142   o  ; was: sub_1F238
                bsr.w   WeaponSetup_RenderSlotSprites
                bsr.w   WeaponSetup_UpdateHighlightPalette
                bsr.w   WeaponSetup_UpdateHorizontalScroll
                bne.w   WeaponSetup_StateWaitReturn
                bsr.w   WeaponSetup_RefillAmmo
                move.w  (WeaponSetupControlIndex).w,d1
                beq.s   WeaponSetup_CheckNextControlTypeInput
                btst    #2,(ControllerPressedState).w
                beq.s   WeaponSetup_CheckNextControlTypeInput
                subq.w  #1,d1
WeaponSetup_CheckNextControlTypeInput:                  ; CODE XREF: WeaponSetup_HandleControlTypeInput+18   j  ; was: loc_1F25C
                                        ; WeaponSetup_HandleControlTypeInput+20   j
                cmpi.w  #$19,d1
                bpl.s   WeaponSetup_CommitControlTypeInput
                btst    #3,(ControllerPressedState).w
                beq.s   WeaponSetup_CommitControlTypeInput
                addq.w  #1,d1
WeaponSetup_CommitControlTypeInput:                     ; CODE XREF: WeaponSetup_HandleControlTypeInput+28   j  ; was: loc_1F26C
                                        ; WeaponSetup_HandleControlTypeInput+30   j
                cmp.w   (WeaponSetupControlIndex).w,d1
                beq.s   WeaponSetup_CheckControlTypeAdvance
                move.w  d1,(WeaponSetupControlIndex).w
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
WeaponSetup_CheckControlTypeAdvance:                    ; CODE XREF: WeaponSetup_HandleControlTypeInput+38   j  ; was: loc_1F280
                move.b  (ControllerPressedState).w,d0
                btst    #1,d0
                bne.s   WeaponSetup_AdvanceFromControlType
                andi.b  #$E0,d0
                beq.s   WeaponSetup_CheckControlTypeReturn
WeaponSetup_AdvanceFromControlType:                     ; CODE XREF: WeaponSetup_HandleControlTypeInput+50   j  ; was: loc_1F290
                move.w  #$E,(WeaponSetupHighlight).w
                addq.w  #2,(SetupTransitionIndex).w
                subi.w  #$10,(WeaponSetupScrollTarget).w
                move.b  #$AD,d0
                jsr     (Sound_PlaySFX).l
                bra.w   WeaponSetup_RenderControlTypePage
; ---------------------------------------------------------------------------
WeaponSetup_CheckControlTypeReturn:                     ; CODE XREF: WeaponSetup_HandleControlTypeInput+56   j  ; was: loc_1F2AE
                btst    #0,(ControllerPressedState).w
                bne.s   WeaponSetup_ReturnFromControlType
                btst    #4,(ControllerPressedState).w
                beq.w   WeaponSetup_RenderControlTypePage
; Returns from the controller-layout page to the previous setup page
WeaponSetup_ReturnFromControlType:                      ; CODE XREF: WeaponSetup_HandleControlTypeInput+7C   j  ; was: loc_1F2C0
                move.w  #$E,(WeaponSetupHighlight).w
                subq.w  #2,(SetupTransitionIndex).w
                clr.w   (WeaponSetupScrollTarget).w
                bra.w   WeaponSetup_RenderControlTypePage
; End of function WeaponSetup_HandleControlTypeInput
; ---------------------------------------------------------------------------
WeaponSetup_ControlTypeTextPointers:    dc.l    WeaponSetup_ControlType01Text  ; DATA XREF: WeaponSetup_RenderSelectedControlType+10   o  ; was: off_1F2D2
                dc.l    WeaponSetup_ControlType02Text
                dc.l    WeaponSetup_ControlType03Text
                dc.l    WeaponSetup_ControlType04Text
                dc.l    WeaponSetup_ControlType05Text
                dc.l    WeaponSetup_ControlType06Text
                dc.l    WeaponSetup_ControlType07Text
                dc.l    WeaponSetup_ControlType08Text
                dc.l    WeaponSetup_ControlType09Text
                dc.l    WeaponSetup_ControlType10Text
                dc.l    WeaponSetup_ControlType11Text
                dc.l    WeaponSetup_ControlType12Text
                dc.l    WeaponSetup_ControlType13Text
                dc.l    WeaponSetup_ControlType14Text
                dc.l    WeaponSetup_ControlType15Text
                dc.l    WeaponSetup_ControlType16Text
                dc.l    WeaponSetup_ControlType17Text
                dc.l    WeaponSetup_ControlType18Text
                dc.l    WeaponSetup_ControlType19Text
                dc.l    WeaponSetup_ControlType20Text
                dc.l    WeaponSetup_ControlType21Text
                dc.l    WeaponSetup_ControlType22Text
                dc.l    WeaponSetup_ControlType23Text
                dc.l    WeaponSetup_ControlType24Text
                dc.l    WeaponSetup_ControlType25Text
                dc.l    WeaponSetup_ControlType26Text
WeaponSetup_ControlTypeValues:  dc.b    0, 7, $38, 2, 4, 1, 6, 3  ; was: byte_1F33A
                                        ; DATA XREF: WeaponSetup_FindControlTypeIndex   o
                                        ; WeaponSetup_RenderSelectedControlType+4   o
                dc.b    5, $10, 8, $20, $18, $30, $28, $15
                dc.b    $B, $26, $19, $34, $2A, $24, $22, 9
                dc.b    $A, $14, $11, 0

; Handles advance and return input on the exit page
WeaponSetup_HandleExitInput:                            ; DATA XREF: ROM:0001F144   o  ; was: sub_1F356
                bsr.w   WeaponSetup_RenderSlotSprites
                bsr.w   WeaponSetup_UpdateHighlightPalette
                bsr.w   WeaponSetup_UpdateHorizontalScroll
                bne.w   WeaponSetup_StateWaitReturn
                bsr.w   WeaponSetup_RefillAmmo
                move.b  (ControllerPressedState).w,d0
                andi.b  #$E0,d0
                beq.s   WeaponSetup_CheckExitReturn
                move.w  #$E,(WeaponSetupHighlight).w
                addq.w  #2,(SetupTransitionIndex).w
                move.w  #$6000,(TilemapTransferBase).w
                move.w  #$1F,(TilemapRowCountdown).w
                clr.w   (TilemapRowXOrFillWord).w
                bra.w   WeaponSetup_RenderExitOption
; ---------------------------------------------------------------------------
WeaponSetup_CheckExitReturn:                            ; CODE XREF: WeaponSetup_HandleExitInput+1C   j  ; was: loc_1F392
                btst    #0,(ControllerPressedState).w
                bne.s   WeaponSetup_ReturnFromExit
                btst    #4,(ControllerPressedState).w
                beq.w   WeaponSetup_RenderExitOption
; Returns from the exit page to the controller-layout page
WeaponSetup_ReturnFromExit:                             ; CODE XREF: WeaponSetup_HandleExitInput+42   j  ; was: loc_1F3A4
                move.w  #$E,(WeaponSetupHighlight).w
                subq.w  #2,(SetupTransitionIndex).w
                addi.w  #$10,(WeaponSetupScrollTarget).w
                bra.w   WeaponSetup_RenderExitOption
; End of function WeaponSetup_HandleExitInput
; Updates the four loadout-slot sprites until their fade completes
WeaponSetup_UpdateSlotFade:                             ; DATA XREF: ROM:0001F146   o  ; was: sub_1F3B8
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                jsr     (Tilemap_QueueNextConstantRow).l
                tst.w   (TilemapRowCountdown).w
                bpl.w   WeaponSetup_StateWaitReturn
                addq.w  #2,(SetupTransitionIndex).w
                clr.w   (PlayerScriptStateOffset).w
                clr.w   (SecondaryCameraYPos).w
                rts
; End of function WeaponSetup_UpdateSlotFade
; Renders the control-test instructions and loads their palette
WeaponSetup_LoadControlTestText:                        ; DATA XREF: ROM:0001F148   o  ; was: sub_1F3E6
                addq.w  #2,(SetupTransitionIndex).w
                clr.w   (dword_FF8040).w
; Renders the eight control-test instruction rows
WeaponSetup_RenderControlTestTextLoop:                  ; CODE XREF: WeaponSetup_LoadControlTestText+30   j  ; was: loc_1F3EE
                lea     WeaponSetup_ControlTestTextLayout(pc),a1
                nop
                move.w  (dword_FF8040).w,d1
                move.w  (a1,d1.w),d0
                move.w  2(a1,d1.w),d4
                movea.l 4(a1,d1.w),a0
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                addi.w  #8,(dword_FF8040).w
                cmpi.w  #$40,(dword_FF8040).w           ; '@'
                bne.s   WeaponSetup_RenderControlTestTextLoop
                lea     (WeaponSetupControlTestPaletteOffsetList).l,a4
                jmp     Gfx_LoadMultiplePalettes
; End of function WeaponSetup_LoadControlTestText
; ---------------------------------------------------------------------------
WeaponSetup_ControlTestTextLayout:  dc.w    $8100       ; field_0  ; was: stru_1F424
                                        ; DATA XREF: WeaponSetup_LoadControlTestText:WeaponSetup_RenderControlTestTextLoop   o
                dc.w    $629C                           ; field_2
                dc.l    WeaponSetup_ControlTestText     ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6410                           ; field_2
                dc.l    WeaponSetup_WeaponSelectControlText  ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6522                           ; field_2
                dc.l    WeaponSetup_ShotControlText     ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6622                           ; field_2
                dc.l    WeaponSetup_JumpControlText     ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6788                           ; field_2
                dc.l    WeaponSetup_ShootingModeChangeControlText  ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6910                           ; field_2
                dc.l    WeaponSetup_ZeroTeleportControlText  ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6A10                           ; field_2
                dc.l    WeaponSetup_CounterForceControlText  ; field_4
                dc.w    $A100                           ; field_0
                dc.w    $6B1A                           ; field_2
                dc.l    WeaponSetup_HoveringControlText  ; field_4

; Waits for confirmation before leaving the weapon-setup screen
WeaponSetup_WaitForConfirmInput:                        ; DATA XREF: ROM:0001F14A   o  ; was: sub_1F464
                bsr.w   WeaponSetup_RenderConfirmPromptSprites
                btst    #7,(ControllerPressedState).w
                bne.s   WeaponSetup_ConfirmAndBeginFade
                rts
; ---------------------------------------------------------------------------
; Confirms the setup and starts the screen fade
WeaponSetup_ConfirmAndBeginFade:                        ; CODE XREF: WeaponSetup_WaitForConfirmInput+A   j  ; was: loc_1F472
                addq.w  #2,(SetupTransitionIndex).w
                move.w  #2,(PaletteFadeMode).w
                clr.w   (PaletteFadeColorOffset).w
                move.w  #$E000,(PaletteFadeMaskStatus).w
                move.b  #1,d0
                jsr     (Sound_QueueRequest).l
                bra.w   WeaponSetup_RefillAmmo
; End of function WeaponSetup_WaitForConfirmInput
; Empty UI menu state handler
WeaponSetup_IdleState:                                  ; DATA XREF: ROM:0001F14C   o  ; was: nullsub_53
                rts
; End of function WeaponSetup_IdleState
; Handles four-slot loadout selection and each slot's force direction
WeaponSetup_HandleLoadoutInput:                         ; CODE XREF: WeaponSetup_HandleLoadoutState+1A   p  ; was: sub_1F496
                move.b  (ControllerPressedState).w,d0
                andi.b  #$E0,d0
                beq.s   WeaponSetup_CheckPreviousSlotInput
                move.w  #$E,(WeaponSetupHighlight).w
                move.b  #$DF,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(WeaponSlotOffset).w
                cmpi.w  #8,(WeaponSlotOffset).w
                bmi.s   WeaponSetup_CheckPreviousSlotInput
                move.w  #6,(WeaponSlotOffset).w
                addq.w  #2,(SetupTransitionIndex).w
                move.w  #$FFE0,(WeaponSetupScrollTarget).w
                move.w  #$14,(PlayerScriptStateOffset).w
WeaponSetup_CheckPreviousSlotInput:                     ; CODE XREF: WeaponSetup_HandleLoadoutInput+8   j  ; was: loc_1F4D2
                                        ; WeaponSetup_HandleLoadoutInput+24   j
                tst.w   (WeaponSlotOffset).w
                beq.s   WeaponSetup_HandleForceDirectionInput
                btst    #4,(ControllerPressedState).w
                beq.s   WeaponSetup_HandleForceDirectionInput
                move.w  #$E,(WeaponSetupHighlight).w
                move.b  #$DE,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #2,(WeaponSlotOffset).w
                bpl.s   WeaponSetup_LoadPreviousSlotSelection
                clr.w   (WeaponSlotOffset).w
WeaponSetup_LoadPreviousSlotSelection:                  ; CODE XREF: WeaponSetup_HandleLoadoutInput+5E   j  ; was: loc_1F4FA
                movea.w (WeaponSlotOffset).w,a0
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a0
                move.w  (a0),(WeaponSetupForceIndex).w
                move.w  (WeaponSlotOffset).w,(WeaponMenuSlotOffset).w
                clr.w   (WeaponFireCooldown).w
                jsr     (Weapon_AdvanceCurrentState).l
                bra.w   WeaponSetup_RenderLoadout
; ---------------------------------------------------------------------------
WeaponSetup_HandleForceDirectionInput:                  ; CODE XREF: WeaponSetup_HandleLoadoutInput+40   j  ; was: loc_1F51A
                                        ; WeaponSetup_HandleLoadoutInput+48   j
                move.w  (WeaponSlotOffset).w,(WeaponMenuSlotOffset).w
                move.w  (WeaponSetupForceIndex).w,d0
                andi.w  #$C,d0
                move.w  (WeaponSetupForceIndex).w,d1
                andi.w  #2,d1
                moveq   #0,d2
                tst.w   d0
                beq.s   WeaponSetup_CheckForceDownInput
                btst    #0,(ControllerPressedState).w
                beq.s   WeaponSetup_CheckForceDownInput
                subq.w  #4,d0
                addq.w  #1,d2
WeaponSetup_CheckForceDownInput:                        ; CODE XREF: WeaponSetup_HandleLoadoutInput+9E   j  ; was: loc_1F542
                                        ; WeaponSetup_HandleLoadoutInput+A6   j
                cmpi.w  #8,d0
                beq.s   WeaponSetup_CheckForceRightInput
                btst    #1,(ControllerPressedState).w
                beq.s   WeaponSetup_CheckForceRightInput
                addq.w  #4,d0
                addq.w  #1,d2
WeaponSetup_CheckForceRightInput:                       ; CODE XREF: WeaponSetup_HandleLoadoutInput+B0   j  ; was: loc_1F554
                                        ; WeaponSetup_HandleLoadoutInput+B8   j
                tst.w   d1
                bne.s   WeaponSetup_CheckForceLeftInput
                btst    #3,(ControllerPressedState).w
                beq.s   WeaponSetup_CheckForceLeftInput
                addq.w  #2,d1
                addq.w  #1,d2
WeaponSetup_CheckForceLeftInput:                        ; CODE XREF: WeaponSetup_HandleLoadoutInput+C0   j  ; was: loc_1F564
                                        ; WeaponSetup_HandleLoadoutInput+C8   j
                tst.w   d1
                beq.s   WeaponSetup_CommitForceSelection
                btst    #2,(ControllerPressedState).w
                beq.s   WeaponSetup_CommitForceSelection
                subq.w  #2,d1
                addq.w  #1,d2
WeaponSetup_CommitForceSelection:                       ; CODE XREF: WeaponSetup_HandleLoadoutInput+D0   j  ; was: loc_1F574
                                        ; WeaponSetup_HandleLoadoutInput+D8   j
                add.w   d0,d1
                move.w  d1,(WeaponSetupForceIndex).w
                movea.w (WeaponSlotOffset).w,a0
                adda.w  #(WeaponSlotConfig0-M68K_RAM),a0
                move.w  (WeaponSetupForceIndex).w,d0
                move.w  d0,(a0)
                move.w  d2,(dword_FF8040).w
                jsr     (UI_QueueSelectedWeaponIconTransfer).l
                move.w  (dword_FF8040).w,d2
                tst.w   d2
                beq.s   WeaponSetup_RenderLoadout
                move.b  #$DB,d0
                jsr     (Sound_PlaySFX).l
                clr.w   (WeaponFireCooldown).w
                jsr     (Weapon_AdvanceCurrentState).l
WeaponSetup_RenderLoadout:                              ; CODE XREF: WeaponSetup_HandleShootingModeInput+8   j  ; was: loc_1F5AE
                                        ; WeaponSetup_HandleLoadoutInput+80   j
                clr.w   (dword_FF8040).w
WeaponSetup_RenderForceNameLoop:                        ; CODE XREF: WeaponSetup_HandleLoadoutInput+154   j  ; was: loc_1F5B2
                move.w  (dword_FF8040).w,d1
                move.w  #$8100,d0
                tst.w   (SetupTransitionIndex).w
                bne.s   WeaponSetup_RenderForceName
                cmp.w   (WeaponSetupForceIndex).w,d1
                bne.s   WeaponSetup_RenderForceName
                move.w  #$E100,d0
; Renders one of the six force names in the loadout grid
WeaponSetup_RenderForceName:                            ; CODE XREF: WeaponSetup_HandleLoadoutInput+128   j  ; was: loc_1F5CA
                                        ; WeaponSetup_HandleLoadoutInput+12E   j
                lea     WeaponSetup_ForceTextLayout(pc),a1
                nop
                move.w  (a1,d1.w),d4
                asl.w   #1,d1
                movea.l $C(a1,d1.w),a0
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                addq.w  #2,(dword_FF8040).w
                cmpi.w  #$C,(dword_FF8040).w
                bne.s   WeaponSetup_RenderForceNameLoop
                rts
; End of function WeaponSetup_HandleLoadoutInput
; ---------------------------------------------------------------------------
WeaponSetup_ForceTextLayout:    dc.w    $640C, $6430, $650C, $6530, $660C, $6630  ; was: word_1F5EE
                                        ; DATA XREF: WeaponSetup_InitializeTextAndTiles+10   o
                                        ; WeaponSetup_HandleLoadoutInput:WeaponSetup_RenderForceName   o
                dc.l    WeaponSetup_BusterForceText
                dc.l    WeaponSetup_RangerForceText
                dc.l    WeaponSetup_FlameForceText
                dc.l    WeaponSetup_HomingForceText
                dc.l    WeaponSetup_SwordForceText
                dc.l    WeaponSetup_LancerForceText

; Renders the SETUP YOUR WEAPONS heading
WeaponSetup_RenderHeading:                              ; CODE XREF: WeaponSetup_InitializeTextAndTiles   p  ; was: sub_1F612
                move.w  #$A100,d0
                lea     WeaponSetup_HeadingText(pc),a0
                nop
                move.w  #$6294,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; End of function WeaponSetup_RenderHeading
; Renders and highlights the MOVING/FIX shooting-mode options
WeaponSetup_RenderShootingModeOptions:                  ; CODE XREF: WeaponSetup_HandleShootingModeInput+66   j  ; was: sub_1F626
                                        ; WeaponSetup_HandleShootingModeInput+70   j
                move.w  #$8100,d0
                cmpi.w  #2,(SetupTransitionIndex).w
                bne.s   WeaponSetup_SelectShootingModeLabelColor
                btst    #1,(FrameCounter+1).w
                bne.s   WeaponSetup_RenderShootingModeLabel
WeaponSetup_SelectShootingModeLabelColor:               ; CODE XREF: WeaponSetup_RenderShootingModeOptions+A   j  ; was: loc_1F63A
                move.w  #$A100,d0
WeaponSetup_RenderShootingModeLabel:                    ; CODE XREF: WeaponSetup_RenderShootingModeOptions+12   j  ; was: loc_1F63E
                lea     WeaponSetup_ShootingModeText(pc),a0
                nop
                move.w  #$680E,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                move.w  #$8100,d0
                tst.w   (ShootingMode).w
                beq.s   WeaponSetup_RenderMovingModeOption
                move.w  #$A100,d0
WeaponSetup_RenderMovingModeOption:                     ; CODE XREF: WeaponSetup_RenderShootingModeOptions+30   j  ; was: loc_1F65C
                lea     WeaponSetup_MovingModeText(pc),a0
                nop
                move.w  #$6830,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                move.w  #$8100,d0
                tst.w   (ShootingMode).w
                bne.s   WeaponSetup_RenderFixedModeOption
                move.w  #$A100,d0
WeaponSetup_RenderFixedModeOption:                      ; CODE XREF: WeaponSetup_RenderShootingModeOptions+4E   j  ; was: loc_1F67A
                lea     WeaponSetup_FixedModeText(pc),a0
                nop
                move.w  #$6840,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; End of function WeaponSetup_RenderShootingModeOptions
; Begins the controller-layout page with its selected highlight color
WeaponSetup_RenderControlTypePage:                      ; CODE XREF: WeaponSetup_HandleControlTypeInput+72   j  ; was: sub_1F68A
                                        ; WeaponSetup_HandleControlTypeInput+84   j
                move.w  #$E100,d0
                cmpi.w  #2,(SetupTransitionIndex).w
                beq.s   WeaponSetup_RenderStatusWindowLabelWithColor
; End of function WeaponSetup_RenderControlTypePage
; Renders the STATUS WINDOW label and selected controller type
WeaponSetup_RenderStatusWindowLabel:                    ; CODE XREF: WeaponSetup_InitializeTextAndTiles+8   p  ; was: sub_1F696
                move.w  #$8100,d0
WeaponSetup_RenderStatusWindowLabelWithColor:           ; CODE XREF: WeaponSetup_RenderControlTypePage+A   j  ; was: loc_1F69A
                lea     WeaponSetup_StatusWindowText(pc),a0
                nop
                move.w  #$680E,d4
                jsr     (Text_QueueDoubleHeightStringWrapped).l
                bra.s   WeaponSetup_RenderSelectedControlType
; End of function WeaponSetup_RenderStatusWindowLabel
; Maps stored controller-layout flags to one of the 26 displayed types
WeaponSetup_FindControlTypeIndex:                       ; CODE XREF: WeaponSetup_InitializeTextAndTiles+4   p  ; was: sub_1F6AC
                lea     WeaponSetup_ControlTypeValues(pc),a0
                move.b  (ControlLayoutFlags).w,d0
                moveq   #0,d1
                moveq   #$19,d7
WeaponSetup_FindControlTypeIndexLoop:                   ; CODE XREF: WeaponSetup_FindControlTypeIndex+12   j  ; was: loc_1F6B8
                cmp.b   (a0)+,d0
                beq.s   WeaponSetup_StoreControlTypeIndex
                addq.w  #1,d1
                dbf     d7,WeaponSetup_FindControlTypeIndexLoop
                move.b  #0,(ControlLayoutFlags).w
WeaponSetup_StoreControlTypeIndex:                      ; CODE XREF: WeaponSetup_FindControlTypeIndex+E   j  ; was: loc_1F6C8
                move.b  d1,(WeaponSetupControlIndex+1).w
                rts
; End of function WeaponSetup_FindControlTypeIndex
; Renders the currently selected TYPE 1--26 controller layout
WeaponSetup_RenderSelectedControlType:                  ; CODE XREF: WeaponSetup_RenderStatusWindowLabel+14   j  ; was: sub_1F6CE
                move.w  (WeaponSetupControlIndex).w,d1
                lea     WeaponSetup_ControlTypeValues(pc),a0
                move.b  (a0,d1.w),(ControlLayoutFlags).w
                asl.w   #2,d1
                lea     WeaponSetup_ControlTypeTextPointers(pc),a0
                movea.l (a0,d1.w),a0
                move.w  #$E100,d0
                cmpi.w  #2,(SetupTransitionIndex).w
                beq.s   WeaponSetup_RenderSelectedControlTypeWithColor
                move.w  #$8100,d0
WeaponSetup_RenderSelectedControlTypeWithColor:         ; CODE XREF: WeaponSetup_RenderSelectedControlType+22   j  ; was: loc_1F6F6
                move.w  #$6830,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; End of function WeaponSetup_RenderSelectedControlType
; Begins the exit page with its selected highlight color
WeaponSetup_RenderExitOption:                           ; CODE XREF: WeaponSetup_HandleExitInput+38   j  ; was: sub_1F700
                                        ; WeaponSetup_HandleExitInput+4A   j
                move.w  #$E100,d0
                cmpi.w  #4,(SetupTransitionIndex).w
                beq.s   WeaponSetup_RenderExitTextWithColor
; End of function WeaponSetup_RenderExitOption
; Renders the EXIT option
WeaponSetup_RenderExitText:                             ; CODE XREF: WeaponSetup_InitializeTextAndTiles+C   p  ; was: sub_1F70C
                move.w  #$8100,d0
WeaponSetup_RenderExitTextWithColor:                    ; CODE XREF: WeaponSetup_RenderExitOption+A   j  ; was: loc_1F710
                lea     WeaponSetup_ExitText(pc),a0
                nop
                move.w  #$690E,d4
                jmp     (Text_QueueDoubleHeightStringWrapped).l
; End of function WeaponSetup_RenderExitText
; Moves the weapon-setup screen toward its target horizontal scroll
WeaponSetup_UpdateHorizontalScroll:                     ; CODE XREF: WeaponSetup_HandleLoadoutState+8   p  ; was: sub_1F720
                                        ; WeaponSetup_HandleShootingModeInput+4   p
                move.w  (SecondaryCameraYPos).w,d0
                cmp.w   (WeaponSetupScrollTarget).w,d0
                beq.s   WeaponSetup_UpdateHorizontalScrollReturn
                bmi.s   WeaponSetup_ApplyHorizontalScrollStep
                subq.w  #4,(SecondaryCameraYPos).w
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
WeaponSetup_ApplyHorizontalScrollStep:                  ; CODE XREF: WeaponSetup_UpdateHorizontalScroll+A   j  ; was: loc_1F734
                addq.w  #4,(SecondaryCameraYPos).w
                moveq   #1,d0
WeaponSetup_UpdateHorizontalScrollReturn:               ; CODE XREF: WeaponSetup_UpdateHorizontalScroll+8   j  ; was: locret_1F73A
                rts
; End of function WeaponSetup_UpdateHorizontalScroll
; Renders the four loadout-slot sprites while their display flag is set
WeaponSetup_RenderSlotSprites:                          ; CODE XREF: WeaponSetup_HandleLoadoutState   p  ; was: sub_1F73C
                                        ; WeaponSetup_HandleShootingModeInput   p
                btst    #3,(FrameCounter+1).w
                bne.s   WeaponSetup_RenderSlotSpriteLoop
                rts
; ---------------------------------------------------------------------------
WeaponSetup_RenderSlotSpriteLoop:                       ; CODE XREF: WeaponSetup_RenderSlotSprites+6   j  ; was: loc_1F746
                movea.w #(SharedSpriteScratch-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D4,(a1)+
                move.w  #$158,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D8,(a1)+
                move.w  #$178,(a1)+
                move.w  d0,(a1)+
                move.w  #$400,(a1)+
                move.w  #$C2DC,(a1)+
                move.w  #$198,(a1)+
                move.w  #$FFFF,(a1)+
                jmp     (Sprite_AppendOAMEntries).l
; End of function WeaponSetup_RenderSlotSprites
; Renders the two-sprite confirmation prompt while its input flag is set
WeaponSetup_RenderConfirmPromptSprites:                 ; CODE XREF: WeaponSetup_WaitForConfirmInput   p  ; was: sub_1F784
                btst    #3,(FrameCounter+1).w
                bne.s   WeaponSetup_BuildConfirmPromptSprites
                rts
; ---------------------------------------------------------------------------
WeaponSetup_BuildConfirmPromptSprites:                  ; CODE XREF: WeaponSetup_RenderConfirmPromptSprites+6   j  ; was: loc_1F78E
                movea.w #(SharedSpriteScratch-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2DE,(a1)+
                move.w  #$164,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2E2,(a1)+
                move.w  #$184,(a1)+
                move.w  #$FFFF,(a1)+
                jmp     (Sprite_AppendOAMEntries).l
; End of function WeaponSetup_RenderConfirmPromptSprites
; Advances the weapon-setup highlight palette cycle
WeaponSetup_UpdateHighlightPalette:                     ; CODE XREF: WeaponSetup_HandleLoadoutState+4   p  ; was: sub_1F7BE
                                        ; WeaponSetup_HandleControlTypeInput+4   p
                move.w  (WeaponSetupHighlight).w,d0
                bne.s   WeaponSetup_AdvanceHighlightPaletteCycle
                btst    #0,(VBlankFrameCounter+1).w
                bne.s   WeaponSetup_WriteHighlightPaletteColors
                addq.w  #2,d0
                bra.s   WeaponSetup_WriteHighlightPaletteColors
; ---------------------------------------------------------------------------
WeaponSetup_AdvanceHighlightPaletteCycle:               ; CODE XREF: WeaponSetup_UpdateHighlightPalette+4   j  ; was: loc_1F7D0
                subq.w  #2,(WeaponSetupHighlight).w
; Writes the selected highlight colors to the palette buffer
WeaponSetup_WriteHighlightPaletteColors:                ; CODE XREF: WeaponSetup_UpdateHighlightPalette+C   j  ; was: loc_1F7D4
                                        ; WeaponSetup_UpdateHighlightPalette+10   j
                andi.w  #$E,d0
                move.w  WeaponSetup_HighlightPaletteColor1Cycle(pc,d0.w),(PaletteActiveColor49).w
                move.w  WeaponSetup_HighlightPaletteColor2Cycle(pc,d0.w),(PaletteActiveColor50).w
                rts
; End of function WeaponSetup_UpdateHighlightPalette
; ---------------------------------------------------------------------------
WeaponSetup_HighlightPaletteColor1Cycle:    dc.w    $400, $400, $400, $400, $400, $200, 0, $600  ; was: word_1F7E6
                                        ; DATA XREF: WeaponSetup_UpdateHighlightPalette+1A   r
WeaponSetup_HighlightPaletteColor2Cycle:    dc.w    $EEE, $EEC, $ECA, $CA8, $A86, $864, $642, $EEE  ; was: word_1F7F6
                                        ; DATA XREF: WeaponSetup_UpdateHighlightPalette+20   r
WeaponSetup_BackgroundPaletteColor2Cycle:   dc.w    $200, $400, $622, $844, $A66, $C88, $CAA, $ACC, $8EE, $6CE  ; was: word_1F806
                                        ; DATA XREF: WeaponSetup_UpdateBackgroundEffect+52   r
WeaponSetup_BackgroundPaletteColor1Cycle:   dc.w    $48E, $24E, $2C, $A, 8, 6, 4, 2, 0, 0  ; was: word_1F81A
                                        ; DATA XREF: WeaponSetup_UpdateBackgroundEffect+4C   r
