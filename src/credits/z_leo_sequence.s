Boss_ZLeoMainController:                                ; CODE XREF: Stage_UpdateGameplay+6   p  ; was: sub_220D0
                tst.w   (dword_FF9400).w
                beq.w   Boss_ZLeoMainController_DispatchState
                bsr.w   Boss_ZLeoUpdateScroll
                bsr.w   Boss_ZLeoUpdateCameraBounds
Boss_ZLeoMainController_DispatchState:                  ; CODE XREF: Boss_ZLeoMainController+4   j  ; was: loc_220E0
                move.w  (dword_FF9400).w,d0
                lea     Boss_ZLeoStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ZLeoMainController
; ---------------------------------------------------------------------------
Boss_ZLeoStateHandlers: dc.w    Boss_ZLeoIntroSequence-*  ; DATA XREF: Boss_ZLeoMainController+14   o  ; was: off_220EC
                dc.w    Boss_ZLeoIntroSequence_PaletteWait-*
                dc.w    Boss_ZLeoWaitCameraPosition-*
                dc.w    Boss_ZLeoWaitTimer-*
                dc.w    Boss_ZLeoCameraScroll-*
                dc.w    Boss_ZLeoWaitForScrollThreshold-*
                dc.w    Boss_ZLeoConfigureParticleBurst-*
                dc.w    Boss_ZLeoWaitParticleBurst-*
                dc.w    Boss_ZLeoStartReverseScroll-*
                dc.w    Boss_ZLeoWaitForScrollSignChange-*
                dc.w    Boss_ZLeoWaitForCameraEnd-*
                dc.w    Boss_ZLeoSetParticleMode4-*
                dc.w    Boss_ZLeoWaitParticleMode4-*
                dc.w    Boss_ZLeoStartFinalDelay-*
                dc.w    Boss_ZLeoWaitFinalDelay-*
                dc.w    Boss_ZLeoFadeToEnding-*
                dc.w    Boss_ZLeoPrepareEndingExit-*
                dc.w    Boss_ZLeoWaitEndingExit-*
                dc.w    Boss_ZLeoSequenceIdle-*

; Initializes the Z-Leo ending sequence, camera, and particle emitter
Boss_ZLeoIntroSequence:                                 ; DATA XREF: ROM:Boss_ZLeoStateHandlers   o  ; was: sub_22112
                addq.w  #2,(dword_FF9400).w
                clr.w   (word_FFA45E).w
                lea     (Entity_ObjectPool).w,a0
                move.w  #$10,(a0)
                move.w  #$C00,2(a0)
                clr.w   $C(a0)
                move.w  #$40,$10(a0)                    ; '@'
                move.w  #$F0,$14(a0)
                move.w  #1,(dword_FF9410).w
                move.w  #$A0,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$1F,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoSpawnParticles
                move.w  #$40,(dword_FF9400+2).w         ; '@'
; Emits particles while the Z-Leo intro countdown runs
Boss_ZLeoIntroSequence_PaletteWait:                     ; DATA XREF: ROM:000220EE   o  ; was: loc_22166
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoIntroSequence_Return
                move.w  #4,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                bsr.w   Boss_ZLeoSpawnImpactObject
Boss_ZLeoIntroSequence_Return:                          ; CODE XREF: Boss_ZLeoIntroSequence+5C   j  ; was: locret_2217E
                rts
; End of function Boss_ZLeoIntroSequence
; Waits for camera Y position to reach 0x1E0 before advancing state
Boss_ZLeoWaitCameraPosition:                            ; DATA XREF: ROM:000220F0   o  ; was: sub_22180
                bsr.w   Boss_ZLeoSpawnParticles
                cmpi.w  #$1E0,(dword_FFC630).w
                bcs.s   Boss_ZLeoWaitCameraPosition_Return
                clr.w   (dword_FFC638).w
                move.w  #$40,(dword_FF9400+2).w         ; '@'
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitCameraPosition_Return:                     ; CODE XREF: Boss_ZLeoWaitCameraPosition+A   j  ; was: locret_2219A
                rts
; End of function Boss_ZLeoWaitCameraPosition
; Emits particles while waiting for the state timer
Boss_ZLeoWaitTimer:                                     ; DATA XREF: ROM:000220F2   o  ; was: sub_2219C
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoWaitTimer_Return
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitTimer_Return:                              ; CODE XREF: Boss_ZLeoWaitTimer+8   j  ; was: locret_221AA
                rts
; End of function Boss_ZLeoWaitTimer
; Scrolls camera upward with acceleration until reaching final position
Boss_ZLeoCameraScroll:                                  ; DATA XREF: ROM:000220F4   o  ; was: sub_221AC
                cmpi.w  #$60,(dword_FF9410+2).w         ; '`'
                blt.s   Boss_ZLeoCameraScroll_ConfigureParticles
                move.w  (dword_FF9408+2).w,d0
                sub.w   d0,(dword_FF9410+2).w
                bsr.w   Boss_ZLeoSpawnParticles
                bra.s   Boss_ZLeoCameraScroll_Accelerate
; ---------------------------------------------------------------------------
Boss_ZLeoCameraScroll_ConfigureParticles:               ; CODE XREF: Boss_ZLeoCameraScroll+6   j  ; was: loc_221C2
                move.w  #1,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoSpawnParticles
Boss_ZLeoCameraScroll_Accelerate:                       ; CODE XREF: Boss_ZLeoCameraScroll+14   j  ; was: loc_221EA
                addi.l  #$800,(dword_FF9408+2).w
                cmpi.l  #$80000,(dword_FF9408+2).w
                bne.s   Boss_ZLeoCameraScroll_Return
                bset    #0,(word_FFC622).w
                move.l  #$78000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$160,(dword_FF9410+2).w
Boss_ZLeoCameraScroll_Return:                           ; CODE XREF: Boss_ZLeoCameraScroll+4E   j  ; was: locret_22214
                rts
; End of function Boss_ZLeoCameraScroll
; Waits for the camera scroll to cross the next threshold
Boss_ZLeoWaitForScrollThreshold:                        ; DATA XREF: ROM:000220F6   o  ; was: sub_22216
                bsr.w   Boss_ZLeoSpawnParticles
                cmpi.w  #$120,(dword_FFC630).w
                bgt.s   Boss_ZLeoWaitForScrollThreshold_Return
                move.l  (dword_FF9408+2).w,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitForScrollThreshold_Return:                 ; CODE XREF: Boss_ZLeoWaitForScrollThreshold+A   j  ; was: locret_2222C
                rts
; End of function Boss_ZLeoWaitForScrollThreshold
; Configures a two-particle burst
Boss_ZLeoConfigureParticleBurst:                        ; DATA XREF: ROM:000220F8   o  ; was: sub_2222E
                move.w  #2,(dword_FF9410).w
                move.w  #$160,(dword_FF9410+2).w
                move.w  #$F0,(dword_FF9414).w
                move.w  #$FF,(dword_FF9414+2).w
                move.w  #$7F,(dword_FF9418).w
                move.w  #7,(dword_FF941C).w
                bsr.w   Boss_ZLeoSpawnParticles
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
                rts
; End of function Boss_ZLeoConfigureParticleBurst
; Emits the configured burst until its timer expires
Boss_ZLeoWaitParticleBurst:                             ; DATA XREF: ROM:000220FA   o  ; was: sub_22262
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoWaitParticleBurst_Return
                move.w  #$80,(dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitParticleBurst_Return:                      ; CODE XREF: Boss_ZLeoWaitParticleBurst+8   j  ; was: locret_22276
                rts
; End of function Boss_ZLeoWaitParticleBurst
; Starts the reverse camera scroll
Boss_ZLeoStartReverseScroll:                            ; DATA XREF: ROM:000220FC   o  ; was: sub_22278
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoStartReverseScroll_Return
                bclr    #0,(word_FFC622).w
                move.l  #$FFFE0000,(dword_FFC638).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoStartReverseScroll_Return:                     ; CODE XREF: Boss_ZLeoStartReverseScroll+8   j  ; was: locret_22294
                rts
; End of function Boss_ZLeoStartReverseScroll
; Waits for the reverse scroll velocity to change sign
Boss_ZLeoWaitForScrollSignChange:                       ; DATA XREF: ROM:000220FE   o  ; was: sub_22296
                bsr.w   Boss_ZLeoSpawnParticles
                addi.l  #$1000,(dword_FFC638).w
                btst    #7,(dword_FFC638).w
                bne.s   Boss_ZLeoWaitForScrollSignChange_Return
                move.b  #$D5,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitForScrollSignChange_Return:                ; CODE XREF: Boss_ZLeoWaitForScrollSignChange+12   j  ; was: locret_222B8
                rts
; End of function Boss_ZLeoWaitForScrollSignChange
; Waits for the camera to reach the ending position
Boss_ZLeoWaitForCameraEnd:                              ; DATA XREF: ROM:00022100   o  ; was: sub_222BA
                bsr.w   Boss_ZLeoSpawnParticles
                addi.l  #$1000,(dword_FFC638).w
                cmpi.w  #$1E0,(dword_FFC630).w
                blt.s   Boss_ZLeoWaitForCameraEnd_Return
                addq.w  #1,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
                move.w  #$80,(dword_FF9400+2).w
Boss_ZLeoWaitForCameraEnd_Return:                       ; CODE XREF: Boss_ZLeoWaitForCameraEnd+12   j  ; was: locret_222DC
                rts
; End of function Boss_ZLeoWaitForCameraEnd
; Selects four particles per update after a delay
Boss_ZLeoSetParticleMode4:                              ; DATA XREF: ROM:00022102   o  ; was: sub_222DE
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoSetParticleMode4_Return
                move.w  #$80,(dword_FF9400+2).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoSetParticleMode4_Return:                       ; CODE XREF: Boss_ZLeoSetParticleMode4+8   j  ; was: locret_222F8
                rts
; End of function Boss_ZLeoSetParticleMode4
; Emits four particles per update until the timer expires
Boss_ZLeoWaitParticleMode4:                             ; DATA XREF: ROM:00022104   o  ; was: sub_222FA
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoWaitParticleMode4_Return
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitParticleMode4_Return:                      ; CODE XREF: Boss_ZLeoWaitParticleMode4+8   j  ; was: locret_22308
                rts
; End of function Boss_ZLeoWaitParticleMode4
; Starts the final ending delay
Boss_ZLeoStartFinalDelay:                               ; DATA XREF: ROM:00022106   o  ; was: sub_2230A
                bsr.w   Boss_ZLeoSpawnParticles
                move.w  #$40,(dword_FF9400+2).w         ; '@'
                addq.w  #2,(dword_FF9400).w
                rts
; End of function Boss_ZLeoStartFinalDelay
; Waits for the final ending delay
Boss_ZLeoWaitFinalDelay:                                ; DATA XREF: ROM:00022108   o  ; was: sub_2231A
                bsr.w   Boss_ZLeoSpawnParticles
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoWaitFinalDelay_Return
                clr.w   (dword_FF9400+2).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitFinalDelay_Return:                         ; CODE XREF: Boss_ZLeoWaitFinalDelay+8   j  ; was: locret_2232C
                rts
; End of function Boss_ZLeoWaitFinalDelay
; Fades the Z-Leo scene and clears its palette buffer
Boss_ZLeoFadeToEnding:                                  ; DATA XREF: ROM:0002210A   o  ; was: sub_2232E
                move.w  (dword_FF9400+2).w,d0
                bsr.w   Credits_ApplyFadeStep
                btst    #0,(word_FFA280+1).w
                bne.s   Boss_ZLeoFadeToEnding_UpdateParticles
                btst    #1,(word_FFA280+1).w
                bne.s   Boss_ZLeoFadeToEnding_UpdateParticles
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$E,(dword_FF9400+2).w
                bls.s   Boss_ZLeoFadeToEnding_Return
                addq.w  #2,(dword_FF9400).w
                lea     (PaletteShadowBuffer).w,a0
                move.w  #$1F,d7
                moveq   #0,d0
Boss_ZLeoFadeToEnding_ClearPaletteBufferLoop:           ; CODE XREF: Boss_ZLeoFadeToEnding+34   j  ; was: loc_22360
                move.l  d0,(a0)+
                dbf     d7,Boss_ZLeoFadeToEnding_ClearPaletteBufferLoop
                move.w  #$80,(dword_FF9400+2).w
                move.b  #$C1,d0
                jsr     (Sound_PlaySFX).l
Boss_ZLeoFadeToEnding_Return:                           ; CODE XREF: Boss_ZLeoFadeToEnding+22   j  ; was: locret_22376
                rts
; ---------------------------------------------------------------------------
Boss_ZLeoFadeToEnding_UpdateParticles:                  ; CODE XREF: Boss_ZLeoFadeToEnding+E   j  ; was: loc_22378
                                        ; Boss_ZLeoFadeToEnding+16   j
                bsr.w   Boss_ZLeoSpawnParticles
                rts
; End of function Boss_ZLeoFadeToEnding
; Prepares the final fade before leaving the Z-Leo sequence
Boss_ZLeoPrepareEndingExit:                             ; DATA XREF: ROM:0002210C   o  ; was: sub_2237E
                move.w  #$E,d0
                bsr.w   Credits_ApplyFadeStep
                subq.w  #1,(dword_FF9400+2).w
                bne.s   Boss_ZLeoPrepareEndingExit_Return
                move.w  #$E,(dword_FF9400+2).w
                clr.l   (dword_FF9408+2).w
                clr.w   (dword_FF9410).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoPrepareEndingExit_Return:                      ; CODE XREF: Boss_ZLeoPrepareEndingExit+C   j  ; was: locret_2239E
                rts
; End of function Boss_ZLeoPrepareEndingExit
; Finishes the fade and advances to the post-Z-Leo game mode
Boss_ZLeoWaitEndingExit:                                ; DATA XREF: ROM:0002210E   o  ; was: sub_223A0
                move.w  (dword_FF9400+2).w,d0
                bsr.w   Credits_ApplyFadeStep
                btst    #0,(word_FFA280+1).w
                bne.s   Boss_ZLeoWaitEndingExit_Return
                btst    #1,(word_FFA280+1).w
                bne.s   Boss_ZLeoWaitEndingExit_Return
                subq.w  #1,(dword_FF9400+2).w
                bpl.s   Boss_ZLeoWaitEndingExit_Return
                move.w  #$8C,(GameModeIndex).w
                addq.w  #2,(dword_FF9400).w
Boss_ZLeoWaitEndingExit_Return:                         ; CODE XREF: Boss_ZLeoWaitEndingExit+E   j  ; was: locret_223C8
                                        ; Boss_ZLeoWaitEndingExit+16   j
                rts
; End of function Boss_ZLeoWaitEndingExit
Boss_ZLeoSequenceIdle:                                  ; DATA XREF: ROM:00022110   o  ; was: nullsub_56
                rts
; End of function Boss_ZLeoSequenceIdle

; Applies one indexed fade step to the ending palette
Credits_ApplyFadeStep:                                  ; CODE XREF: Boss_ZLeoFadeToEnding+4   p  ; was: sub_223CC
                                        ; Boss_ZLeoPrepareEndingExit+4   p
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (PaletteActiveBuffer).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Credits_ApplyFadeStep
; Integrates the Z-Leo scroll velocity
Boss_ZLeoUpdateScroll:                                  ; CODE XREF: Boss_ZLeoMainController+8   p  ; was: sub_223E2
                move.l  (dword_FF9408+2).w,d0
                add.l   d0,(dword_FFA900).w
                rts
; End of function Boss_ZLeoUpdateScroll
; Debug function for manual camera control using directional inputs
Debug_CameraManualControl:
                btst    #2,(word_FFF706).w              ; was: sub_223EC
                beq.s   Debug_CameraManualControl_CheckRight
                subq.w  #4,(dword_FFA410).w
Debug_CameraManualControl_CheckRight:                   ; CODE XREF: Debug_CameraManualControl+6   j  ; was: loc_223F8
                btst    #3,(word_FFF706).w
                beq.s   Debug_CameraManualControl_CheckUp
                addq.w  #4,(dword_FFA410).w
Debug_CameraManualControl_CheckUp:                      ; CODE XREF: Debug_CameraManualControl+12   j  ; was: loc_22404
                btst    #0,(word_FFF706).w
                beq.s   Debug_CameraManualControl_CheckDown
                subq.w  #4,(dword_FFA414).w
Debug_CameraManualControl_CheckDown:                    ; CODE XREF: Debug_CameraManualControl+1E   j  ; was: loc_22410
                btst    #1,(word_FFF706).w
                beq.s   Debug_CameraManualControl_Return
                addq.w  #4,(dword_FFA414).w
Debug_CameraManualControl_Return:                       ; CODE XREF: Debug_CameraManualControl+2A   j  ; was: locret_2241C
                rts
; End of function Debug_CameraManualControl
; Updates the camera orbit from the shared sine table
Boss_ZLeoUpdateCameraOrbit:
                lea     (Math_SineTable).l,a4           ; was: sub_2241E
                addi.w  #4,(dword_FF9404).w
                addi.w  #2,(dword_FF9404+2).w
                move.w  (dword_FF9404).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$40,d0                         ; '@'
                addi.l  #$1200000,d0
                move.l  d0,(dword_FFA410).w
                move.w  (dword_FF9404+2).w,d0
                addi.w  #$1FE,d0
                move.w  (a4,d0.w),d0
                muls.w  #$20,d0                         ; ' '
                addi.l  #$F00000,d0
                move.l  d0,(dword_FFA414).w
                rts
; End of function Boss_ZLeoUpdateCameraOrbit
; Uses the Z-Leo camera position while it remains inside the active bounds
Boss_ZLeoUpdateCameraBounds:                            ; CODE XREF: Boss_ZLeoMainController+C   p  ; was: sub_22466
                cmpi.w  #$80,(dword_FFC630).w
                blt.s   Boss_ZLeoUpdateCameraBounds_Reset
                cmpi.w  #$1C0,(dword_FFC630).w
                bgt.s   Boss_ZLeoUpdateCameraBounds_Reset
                bset    #7,(word_FFA402).w
                move.l  (dword_FFC630).w,(dword_FFA410).w
                move.l  (dword_FFC634).w,(dword_FFA414).w
                rts
; ---------------------------------------------------------------------------
Boss_ZLeoUpdateCameraBounds_Reset:                      ; CODE XREF: Boss_ZLeoUpdateCameraBounds+6   j  ; was: loc_2248A
                                        ; Boss_ZLeoUpdateCameraBounds+E   j
                move.l  #$60,(dword_FFA410).w           ; '`'
                bclr    #7,(word_FFA402).w
                rts
; End of function Boss_ZLeoUpdateCameraBounds
; Spawns randomized Z-Leo ending particles and their periodic sound
Boss_ZLeoSpawnParticles:                                ; CODE XREF: Boss_ZLeoIntroSequence+4A   p  ; was: sub_2249A
                                        ; sub_22112:loc_22166   p
                move.w  (dword_FF9410).w,d7
                subq.w  #1,d7
                bmi.w   Boss_ZLeoSpawnParticles_Return
Boss_ZLeoSpawnParticles_Loop:                           ; CODE XREF: Boss_ZLeoSpawnParticles+84   j  ; was: loc_224A4
                jsr     (RandomNumber).l
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Boss_ZLeoSpawnParticles_Return
                jsr     (Sprite_InitType160).l
                move.b  #$60,$20(a0)                    ; '`'
                move.b  (dword_FFFF08+2).w,d6
                andi.w  #3,d6
                add.w   d6,d6
                move.b  (dword_FFFF08).w,d0
                move.w  (dword_FF9414+2).w,d1
                and.w   d1,d0
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9410+2).w,d0
                add.w   Boss_ZLeoParticleXOffsets(pc,d6.w),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                move.w  (dword_FF9418).w,d1
                and.w   d1,d0
                addq.w  #1,d1
                lsr.w   #1,d1
                sub.w   d1,d0
                add.w   (dword_FF9414).w,d0
                add.w   Boss_ZLeoParticleYOffsets(pc,d6.w),d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9408+2).w,d0
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                lsl.w   #2,d0
                move.l  Boss_ZLeoParticleSpritePointers(pc,d0.w),8(a0)
                dbf     d7,Boss_ZLeoSpawnParticles_Loop
                tst.w   (dword_FF941C).w
                beq.s   Boss_ZLeoSpawnParticles_Return
                move.w  (dword_FFFF08).w,d0
                and.w   (dword_FF941C).w,d0
                bne.s   Boss_ZLeoSpawnParticles_Return
                cmpi.w  #$18,(dword_FF9400).w
                bcc.s   Boss_ZLeoSpawnParticles_SelectFinalSfx
                move.b  #$30,d0                         ; '0'
                bra.s   Boss_ZLeoSpawnParticles_PlaySfx
; ---------------------------------------------------------------------------
Boss_ZLeoSpawnParticles_SelectFinalSfx:                 ; CODE XREF: Boss_ZLeoSpawnParticles+9E   j  ; was: loc_22540
                move.b  #$2F,d0                         ; '/'
Boss_ZLeoSpawnParticles_PlaySfx:                        ; CODE XREF: Boss_ZLeoSpawnParticles+A4   j  ; was: loc_22544
                jsr     (Sound_PlaySFX).l
Boss_ZLeoSpawnParticles_Return:                         ; CODE XREF: Boss_ZLeoSpawnParticles+6   j  ; was: locret_2254A
                                        ; Boss_ZLeoSpawnParticles+16   j
                rts
; End of function Boss_ZLeoSpawnParticles
; ---------------------------------------------------------------------------
Boss_ZLeoParticleXOffsets:          dc.w    $20, 0, $FFE0, 0  ; DATA XREF: Boss_ZLeoSpawnParticles+46   r  ; was: word_2254C
Boss_ZLeoParticleYOffsets:          dc.w    0, $A, $FFF0, 0  ; DATA XREF: Boss_ZLeoSpawnParticles+62   r  ; was: word_22554
Boss_ZLeoParticleSpritePointers:    dc.l    SharedCombatSpriteAnimation00  ; DATA XREF: Boss_ZLeoSpawnParticles+7E   r  ; was: off_2255C
                dc.l    SharedCombatSpriteAnimation01
                dc.l    SharedCombatSpriteAnimation02
                dc.l    SharedCombatSpriteAnimation03
                dc.l    SharedCombatSpriteAnimation03
                dc.l    SharedCombatSpriteAnimation05
                dc.l    SharedCombatSpriteAnimation02
                dc.l    SharedCombatSpriteAnimation00

; Spawns the impact object that starts the Z-Leo ending transition
Boss_ZLeoSpawnImpactObject:                             ; CODE XREF: Boss_ZLeoIntroSequence+68   p  ; was: sub_2257C
                lea     (word_FFA400).w,a5
                move.b  #$41,d0                         ; 'A'
                jsr     (Sound_PlaySFX).l
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
                rts
; End of function Boss_ZLeoSpawnImpactObject
; ---------------------------------------------------------------------------
Credits_UnidentifiedTrailingData:   binclude "data/other/unused_5.bin"  ; was: unused_5
Credits_UnidentifiedTrailingData_End:                   ; was: unused_5_End

; Demo playback system with input recording and VDP state management
