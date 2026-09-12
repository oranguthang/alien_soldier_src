Stage_SevenForcesInitializeStage20:                     ; DATA XREF: ROM:0000E4A8   o  ; was: sub_E7D8
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                bset    #1,(PaletteFadeControlFlags).w
                move.w  #$36,(PlayerScriptStateOffset).w  ; '6'
                bsr.w   Gfx_FillStage20PlaneBuffers
                move.w  #$6A0,(PrimaryCameraXPosition).w
                move.w  (PrimaryCameraXPosition).w,(CameraXLowerBound).w
                move.w  (PrimaryCameraXPosition).w,(CameraXUpperBound).w
                move.w  (PrimaryCameraXPosition).w,(PreviousCameraXPosition).w
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$428,(a0)
                move.w  #2,4(a0)
                move.b  #2,(VDPReg11Shadow+1).w
                move.b  #4,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                rts
; End of function Stage_SevenForcesInitializeStage20
; Update the Stage 20 camera and parallax until the next transition is ready
Stage_SevenForcesUpdateStage20Scroll:                   ; DATA XREF: ROM:0000E4AA   o  ; was: sub_E830
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesStage20UpdateCamera
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesStage20UpdateCamera:                   ; CODE XREF: Stage_SevenForcesUpdateStage20Scroll+4   j ; was: loc_E83E
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                bra.w   Gfx_UpdateSevenForcesParallaxRows
; End of function Stage_SevenForcesUpdateStage20Scroll
; Transition to Medusa form
Stage_SevenForcesAdvanceToMedusa:                       ; DATA XREF: ROM:0000E4AC   o  ; was: sub_E846
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesUpdateMedusaCamera
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesUpdateMedusaCamera:                    ; CODE XREF: Stage_SevenForcesAdvanceToMedusa+4   j ; was: loc_E854
                bra.w   Stage_SevenForcesUpdateMedusaCameraAndParallax
; End of function Stage_SevenForcesAdvanceToMedusa
; Brake the Medusa scroll before initializing the Sylpheed transition
Stage_SevenForcesFinishMedusaScroll:                    ; DATA XREF: ROM:0000E4AE   o  ; was: sub_E858
                subi.l  #$1400,(dword_FF9610).w
                bpl.s   Stage_SevenForcesApplyMedusaScroll
                addq.w  #2,(StageStateOffset).w
                clr.l   (dword_FF9610).w
Stage_SevenForcesApplyMedusaScroll:                     ; CODE XREF: Stage_SevenForcesFinishMedusaScroll+8   j ; was: loc_E86A
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(PrimaryCameraXPosition).w
                bra.w   Stage_SevenForcesWrapVerticalCamera
; End of function Stage_SevenForcesFinishMedusaScroll
; Initialize the Sylpheed scroll velocities and plane modes
Stage_SevenForcesInitializeSylpheedScroll:              ; DATA XREF: ROM:0000E4B0   o  ; was: sub_E876
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesInitializeSylpheedScrollReturn
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                bsr.w   Gfx_ClearSylpheedPlaneModes
Stage_SevenForcesInitializeSylpheedScrollReturn:        ; CODE XREF: Stage_SevenForcesInitializeSylpheedScroll+4   j ; was: locret_E890
                rts
; End of function Stage_SevenForcesInitializeSylpheedScroll
; Update both Sylpheed scrolling planes and wait for completion
Stage_SevenForcesUpdateSylpheedScroll:                  ; DATA XREF: ROM:0000E4B2   o  ; was: sub_E892
                bsr.w   Stage_SevenForcesUpdateSylpheedPrimaryPlane
                bsr.w   Stage_SevenForcesUpdateSylpheedSecondaryPlane
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesUpdateSylpheedScrollReturn
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesUpdateSylpheedScrollReturn:            ; CODE XREF: Stage_SevenForcesUpdateSylpheedScroll+C   j ; was: locret_E8A8
                rts
; End of function Stage_SevenForcesUpdateSylpheedScroll
; Advance the Sylpheed scroll and continue its foreground update
Stage_SevenForcesAdvanceSylpheedForeground:             ; DATA XREF: ROM:0000E4B4   o  ; was: sub_E8AA
                bsr.w   Stage_SevenForcesUpdateSylpheedSecondaryPlane
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesUpdateSylpheedForeground
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesUpdateSylpheedForeground:              ; CODE XREF: Stage_SevenForcesAdvanceSylpheedForeground+8   j ; was: loc_E8BC
                                        ; Stage_SevenForcesFinishSylpheedForeground+18   j
                bra.w   Stage_SevenForcesUpdateSylpheedForegroundScroll
; End of function Stage_SevenForcesAdvanceSylpheedForeground
; Finish the Sylpheed foreground transition or continue scrolling it
Stage_SevenForcesFinishSylpheedForeground:              ; DATA XREF: ROM:0000E4B6   o  ; was: sub_E8C0
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesContinueSylpheedForeground
                addq.w  #2,(StageStateOffset).w
                move.w  #$20,(dword_FFA960).w           ; ' '
                bra.w   Stage_SevenForcesInitializeArtemisCameraAndAssets
; ---------------------------------------------------------------------------
Stage_SevenForcesContinueSylpheedForeground:            ; CODE XREF: Stage_SevenForcesFinishSylpheedForeground+4   j ; was: loc_E8D4
                bsr.w   Stage_SevenForcesAdvanceSylpheedSecondaryScroll
                bra.w   Stage_SevenForcesUpdateSylpheedForeground
; End of function Stage_SevenForcesFinishSylpheedForeground
; Transition to Artemis form
Stage_SevenForcesBeginArtemisTransition:                ; DATA XREF: ROM:0000E4B8   o  ; was: sub_E8DC
                bsr.w   Gfx_ArtemisInitializeTilemap
                bsr.w   Stage_SevenForcesDampenHorizontalVelocity
                subq.w  #1,(dword_FFA960).w
                bpl.s   Stage_SevenForcesBeginArtemisTransitionReturn
                tst.w   (word_FFF720).w
                bmi.s   Stage_SevenForcesBeginArtemisTransitionReturn
                addq.w  #2,(StageStateOffset).w
                clr.l   (dword_FF8240).w
Stage_SevenForcesBeginArtemisTransitionReturn:          ; CODE XREF: Stage_SevenForcesBeginArtemisTransition+C   j ; was: locret_E8F8
                                        ; Stage_SevenForcesBeginArtemisTransition+12   j
                rts
; End of function Stage_SevenForcesBeginArtemisTransition
; Wait for the Artemis background renderer to report completion
Stage_SevenForcesWaitForArtemisBackground:              ; DATA XREF: ROM:0000E4BA   o  ; was: sub_E8FA
                bsr.w   Gfx_ArtemisUpdateBackground
                bpl.s   Stage_SevenForcesWaitForArtemisBackgroundReturn
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesWaitForArtemisBackgroundReturn:        ; CODE XREF: Stage_SevenForcesWaitForArtemisBackground+4   j ; was: locret_E908
                rts
; End of function Stage_SevenForcesWaitForArtemisBackground
; Wait for the shared trigger before advancing the Artemis transition
Stage_SevenForcesWaitForArtemisTrigger:                 ; DATA XREF: ROM:0000E4BC   o  ; was: sub_E90A
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesWaitForArtemisTriggerReturn
                addq.w  #2,(StageStateOffset).w
Stage_SevenForcesWaitForArtemisTriggerReturn:           ; CODE XREF: Stage_SevenForcesWaitForArtemisTrigger+4   j ; was: locret_E914
                rts
; End of function Stage_SevenForcesWaitForArtemisTrigger
; Scroll the Artemis background to its target position
Stage_SevenForcesScrollArtemisBackground:               ; DATA XREF: ROM:0000E4BE   o  ; was: sub_E916
                bsr.w   Stage_SevenForcesUpdateArtemisBackgroundPlane
                cmpi.w  #$E200,(PrimaryCameraYPosition).w
                bne.s   Stage_SevenForcesScrollArtemisBackgroundReturn
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                clr.w   (dword_FF8066).w
Stage_SevenForcesScrollArtemisBackgroundReturn:         ; CODE XREF: Stage_SevenForcesScrollArtemisBackground+A   j ; was: locret_E92E
                rts
; End of function Stage_SevenForcesScrollArtemisBackground
; Scroll the Artemis foreground and prepare the Sirene transition
Stage_SevenForcesScrollArtemisForeground:               ; DATA XREF: ROM:0000E4C0   o  ; was: sub_E930
                bsr.w   Stage_SevenForcesUpdateArtemisForegroundMotion
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesScrollArtemisForegroundReturn
                addq.w  #2,(StageStateOffset).w
                move.w  #$40,(dword_FFA960).w           ; '@'
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                move.b  #$F4,d0
                jsr     (Sound_PlaySFX).l
Stage_SevenForcesScrollArtemisForegroundReturn:         ; CODE XREF: Stage_SevenForcesScrollArtemisForeground+C   j ; was: locret_E95A
                rts
; End of function Stage_SevenForcesScrollArtemisForeground
; Begin the Sirene transition with its countdown, sound, and camera shake
Stage_SevenForcesBeginSireneTransition:                 ; DATA XREF: ROM:0000E4C2   o  ; was: sub_E95C
                move.w  #2,(PlaneAShakeLevel).w
                subq.w  #1,(dword_FFA960).w
                bpl.s   Stage_SevenForcesUpdateSireneCamera
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                move.b  #$F5,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$E400,(PrimaryCameraYPosition).w
                move.w  #$E400,(PreviousCameraYPosition).w
Stage_SevenForcesUpdateSireneShake:                     ; CODE XREF: Stage_SevenForcesAdvanceSireneTransition:Stage_SevenForcesAdvanceSireneShake   j ; was: loc_E98A
                                        ; Stage_SevenForcesFinishSireneTransition:Stage_SevenForcesFinishSireneShake   j
                move.w  (RandomNumberState).w,d0
                andi.w  #3,d0
                addq.w  #4,d0
                move.w  d0,(PlaneAShakeLevel).w
                move.w  #1,(PlaneBShakeLevel).w
Stage_SevenForcesUpdateSireneCamera:                    ; CODE XREF: Stage_SevenForcesBeginSireneTransition+A   j ; was: loc_E99E
                                        ; Stage_SevenForcesWaitBeforeVictory+14   j
                bra.w   Camera_UpdateHorizontalTowardsPlayer
; End of function Stage_SevenForcesBeginSireneTransition
; Center the Sirene camera and close its split offsets
Stage_SevenForcesCenterSireneCamera:                    ; CODE XREF: Stage_SevenForcesAdvanceSireneTransition   p  ; was: sub_E9A2
                                        ; Stage_SevenForcesFinishSireneTransition   p
                move.w  #$60,d0                         ; '`'
                cmp.w   (PrimaryCameraXPosition).w,d0
                beq.s   Stage_SevenForcesUpdateSireneSplitOffsets
                bpl.s   Stage_SevenForcesMoveSireneCameraRight
                subq.w  #1,(PrimaryCameraXPosition).w
                bra.s   Stage_SevenForcesUpdateSireneSplitOffsets
; ---------------------------------------------------------------------------
Stage_SevenForcesMoveSireneCameraRight:                 ; CODE XREF: Stage_SevenForcesCenterSireneCamera+A   j ; was: loc_E9B4
                addq.w  #1,(PrimaryCameraXPosition).w
Stage_SevenForcesUpdateSireneSplitOffsets:              ; CODE XREF: Stage_SevenForcesCenterSireneCamera+8   j ; was: loc_E9B8
                                        ; Stage_SevenForcesCenterSireneCamera+10   j
                addq.w  #1,(CameraXLowerBound).w
                subq.w  #1,(CameraXUpperBound).w
                cmp.w   (CameraXLowerBound).w,d0
                bpl.s   Stage_SevenForcesCenterSireneCameraReturn
                move.w  d0,(CameraXLowerBound).w
                move.w  d0,(CameraXUpperBound).w
Stage_SevenForcesCenterSireneCameraReturn:              ; CODE XREF: Stage_SevenForcesCenterSireneCamera+22   j ; was: locret_E9CE
                rts
; End of function Stage_SevenForcesCenterSireneCamera
; Advance the first Sirene scrolling phase and start its linked object
Stage_SevenForcesAdvanceSireneTransition:               ; DATA XREF: ROM:0000E4C4   o  ; was: sub_E9D0
                bsr.s   Stage_SevenForcesCenterSireneCamera
                bsr.w   Stage_SevenForcesUpdateSireneSecondaryScroll
                bsr.w   Stage_SevenForcesUpdateSirenePrimaryPlane
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesAdvanceSireneShake
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                move.b  #$F6,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$D0,(PlayerXPosition).w
                move.w  #$188,(PlayerYPosition).w
                addq.w  #2,(PrimaryEntityState).w
Stage_SevenForcesAdvanceSireneShake:                    ; CODE XREF: Stage_SevenForcesAdvanceSireneTransition+E   j ; was: loc_EA02
                bra.w   Stage_SevenForcesUpdateSireneShake
; End of function Stage_SevenForcesAdvanceSireneTransition
; Finish the Sirene scrolling phase and install the pre-victory timer
Stage_SevenForcesFinishSireneTransition:                ; DATA XREF: ROM:0000E4C6   o  ; was: sub_EA06
                bsr.s   Stage_SevenForcesCenterSireneCamera
                bsr.w   Stage_SevenForcesUpdateSireneSecondaryScroll
                bsr.w   Stage_SevenForcesRenderSireneSecondaryPlane
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesFinishSireneShake
                addq.w  #2,(StageStateOffset).w
                move.w  #$40,(dword_FFA960).w           ; '@'
Stage_SevenForcesFinishSireneShake:                     ; CODE XREF: Stage_SevenForcesFinishSireneTransition+E   j ; was: loc_EA20
                bra.w   Stage_SevenForcesUpdateSireneShake
; End of function Stage_SevenForcesFinishSireneTransition
; Count down the final Sirene hold before the victory sequence
Stage_SevenForcesWaitBeforeVictory:                     ; DATA XREF: ROM:0000E4C8   o  ; was: sub_EA24
                subq.w  #1,(dword_FFA960).w
                bpl.s   Stage_SevenForcesWaitBeforeVictoryUpdateCamera
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
Stage_SevenForcesWaitBeforeVictoryUpdateCamera:         ; CODE XREF: Stage_SevenForcesWaitBeforeVictory+4   j ; was: loc_EA32
                move.w  #2,(PlaneAShakeLevel).w
                bra.w   Stage_SevenForcesUpdateSireneCamera
; Initialize the tilemap and timer for the Seven Forces victory sequence
Stage_SevenForcesInitializeVictoryTransition:           ; DATA XREF: ROM:0000E4CA   o  ; was: sub_EA3C
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   Stage_SevenForcesInitializeVictoryTransitionReturn
                addq.w  #2,(StageStateOffset).w
                clr.b   (byte_FFA958).w
                move.w  #$40,(dword_FFA960+2).w         ; '@'
                clr.w   (SecondaryCameraXPos).w
                movea.l #$FFFF2020,a0
                move.w  #$A000,d0
                move.w  #0,d1
                moveq   #$7E,d7                         ; '~'
                jsr     (Gfx_UpdateTilemapIndices).l
                move.w  #$8000,(word_FF808A).w
Stage_SevenForcesInitializeVictoryTransitionReturn:     ; CODE XREF: Stage_SevenForcesInitializeVictoryTransition+8   j ; was: locret_EA74
                rts
; End of function Stage_SevenForcesInitializeVictoryTransition
