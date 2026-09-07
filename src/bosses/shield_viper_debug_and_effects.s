Debug_ShieldViperUpdate:
                bsr.w   Debug_RotateSegmentWithDPad     ; was: sub_4F5D8
                bsr.w   Debug_AdjustRotationWithDPad
                bsr.w   Debug_MoveCursorWithDPad
                rts
; End of function Debug_ShieldViperUpdate
; Debug routine that checks if button 2 is pressed
Debug_CheckButton2:
                btst    #6,(word_FFF706).w              ; was: sub_4F5E6
                beq.w   Debug_DisableProjectilesAndMove
; End of function Debug_CheckButton2
; Spawns shield viper projectile with calculated angle based on segment rotation
Boss_ShieldViperSpawnProjectileWithAngle:               ; CODE XREF: Boss_ShieldViperPrepareMultiShot+8   p  ; was: sub_4F5F0
                bsr.w   Projectile_ShieldViperSpawnRotating
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                btst    #0,(word_FFA000+1).w
                bne.s   Boss_ShieldViperSpawnProjectileWithAngle_Return
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_ShieldViperSpawnProjectileWithAngle_Return
                jsr     Projectile_ShieldViperSpawnEffect(pc)  ; (pc)
                move.b  $20(a5),$20(a0)
                move.w  $970(a5),$10(a0)
                move.w  $974(a5),$14(a0)
                lea     (Math_SineTable).l,a3
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
Boss_ShieldViperSpawnProjectileWithAngle_Return:        ; CODE XREF: Boss_ShieldViperSpawnProjectileWithAngle+E   j  ; was: locret_4F64C
                                        ; Boss_ShieldViperSpawnProjectileWithAngle+16   j
                rts
; End of function Boss_ShieldViperSpawnProjectileWithAngle
; Debug routine to disable projectiles and perform wolf garopa movement
Debug_DisableProjectilesAndMove:                        ; CODE XREF: Boss_ShieldViperPrepareMultiShot+12   p  ; was: sub_4F64E
                                        ; Debug_CheckButton2+6   j
                bsr.w   Projectile_ShieldViperDisable
                bsr.w   Boss_WolfGaropaMovement1
                rts
; End of function Debug_DisableProjectilesAndMove
; Debug routine to move cursor position with D-pad input
Debug_MoveCursorWithDPad:                               ; CODE XREF: Debug_ShieldViperUpdate+8   p  ; was: sub_4F658
                btst    #5,(word_FFF706).w
                beq.w   Debug_MoveCursorWithDPad_Return
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   Debug_MoveCursorWithDPad_CheckRight
                subi.w  #4,$10(a0)
Debug_MoveCursorWithDPad_CheckRight:                    ; CODE XREF: Debug_MoveCursorWithDPad+18   j  ; was: loc_4F678
                btst    #3,(word_FFF706).w
                beq.s   Debug_MoveCursorWithDPad_CheckUp
                addi.w  #4,$10(a0)
Debug_MoveCursorWithDPad_CheckUp:                       ; CODE XREF: Debug_MoveCursorWithDPad+26   j  ; was: loc_4F686
                btst    #0,(word_FFF706).w
                beq.s   Debug_MoveCursorWithDPad_CheckDown
                subi.w  #4,$14(a1)
Debug_MoveCursorWithDPad_CheckDown:                     ; CODE XREF: Debug_MoveCursorWithDPad+34   j  ; was: loc_4F694
                btst    #1,(word_FFF706).w
                beq.s   Debug_MoveCursorWithDPad_Return
                addi.w  #4,$14(a1)
Debug_MoveCursorWithDPad_Return:                        ; CODE XREF: Debug_MoveCursorWithDPad+6   j  ; was: locret_4F6A2
                                        ; Debug_MoveCursorWithDPad+42   j
                rts
; End of function Debug_MoveCursorWithDPad
; Debug routine to rotate shield viper segment with D-pad left/right
Debug_RotateSegmentWithDPad:                            ; CODE XREF: Debug_ShieldViperUpdate   p  ; was: sub_4F6A4
                btst    #4,(word_FFF706).w
                beq.w   Debug_RotateSegmentWithDPad_Return
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   Debug_RotateSegmentWithDPad_CheckRight
                subq.w  #4,$56(a5)
Debug_RotateSegmentWithDPad_CheckRight:                 ; CODE XREF: Debug_RotateSegmentWithDPad+18   j  ; was: loc_4F6C2
                btst    #3,(word_FFF706).w
                beq.s   Debug_RotateSegmentWithDPad_Return
                addq.w  #4,$56(a5)
Debug_RotateSegmentWithDPad_Return:                     ; CODE XREF: Debug_RotateSegmentWithDPad+6   j  ; was: locret_4F6CE
                                        ; Debug_RotateSegmentWithDPad+24   j
                rts
; End of function Debug_RotateSegmentWithDPad
; Debug routine to adjust rotation delta with D-pad up/down
Debug_AdjustRotationWithDPad:                           ; CODE XREF: Debug_ShieldViperUpdate+4   p  ; was: sub_4F6D0
                btst    #4,(word_FFF706).w
                beq.w   Debug_AdjustRotationWithDPad_Return
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #0,(word_FFF706).w
                beq.s   Debug_AdjustRotationWithDPad_CheckDown
                addq.w  #1,(dword_FF9404).w
Debug_AdjustRotationWithDPad_CheckDown:                 ; CODE XREF: Debug_AdjustRotationWithDPad+18   j  ; was: loc_4F6EE
                btst    #1,(word_FFF706).w
                beq.s   Debug_AdjustRotationWithDPad_Return
                subq.w  #1,(dword_FF9404).w
Debug_AdjustRotationWithDPad_Return:                    ; CODE XREF: Debug_AdjustRotationWithDPad+6   j  ; was: locret_4F6FA
                                        ; Debug_AdjustRotationWithDPad+24   j
                rts
; End of function Debug_AdjustRotationWithDPad
; Debug routine to trigger shield viper attack state 2 with button press
Debug_TriggerAttackState:
                btst    #4,(word_FFF706).w              ; was: sub_4F6FC
                beq.w   Debug_TriggerAttackState_Return
                bsr.w   Boss_ShieldViperAttackState2
Debug_TriggerAttackState_Return:                        ; CODE XREF: Debug_TriggerAttackState+6   j  ; was: locret_4F70A
                rts
; End of function Debug_TriggerAttackState
; Updates Shield Viper state, color selection, and effect pattern output
Boss_ShieldViperMovement2:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4F70C
                btst    #0,(word_FFA000+1).w
                bne.w   Boss_ShieldViperMovement2_Return
                bsr.w   Boss_ShieldViperClearPatternBuffer
                bsr.w   Boss_ShieldViperUpdatePatternPhaseA
                btst    #6,(byte_FFC641).w
                beq.s   Boss_ShieldViperMovement2_UseRandomColor
                move.w  (word_FF945C).w,d0
                add.w   d0,d0
                andi.w  #$EE0,d0
                addi.w  #$660,d0
                bra.s   Boss_ShieldViperMovement2_StoreColor
; ---------------------------------------------------------------------------
Boss_ShieldViperMovement2_UseRandomColor:               ; CODE XREF: Boss_ShieldViperMovement2+18   j  ; was: loc_4F736
                move.w  (dword_FFFF08).w,d0
                andi.w  #$EEE,d0
Boss_ShieldViperMovement2_StoreColor:                   ; CODE XREF: Boss_ShieldViperMovement2+28   j  ; was: loc_4F73E
                move.w  d0,(word_FFE310).w
                bsr.s   Boss_ShieldViperUpdateSprites
                bsr.w   Boss_ShieldViperTransferPatternBuffer
Boss_ShieldViperMovement2_Return:                       ; CODE XREF: Boss_ShieldViperMovement2+6   j  ; was: locret_4F748
                rts
; End of function Boss_ShieldViperMovement2
; Updates boss sprites
Boss_ShieldViperUpdateSprites:                          ; CODE XREF: Boss_ShieldViperMovement2+36   p  ; was: sub_4F74A
                move.w  4(a5),d0
                lea     Boss_ShieldViperSpriteStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperUpdateSprites
; ---------------------------------------------------------------------------
Boss_ShieldViperSpriteStateHandlers:    dc.w    Boss_ShieldViperAnimationScript-*  ; DATA XREF: Boss_ShieldViperUpdateSprites+4   o  ; was: off_4F756
                dc.w    Boss_ShieldViper_AnimDelayLoop-*
                dc.w    Projectile_ShieldViperMain-*
                dc.w    Projectile_ShieldViperBullet-*

; Animation script interpreter
Boss_ShieldViperAnimationScript:                        ; DATA XREF: ROM:Boss_ShieldViperSpriteStateHandlers   o  ; was: sub_4F75E
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
; Decrements animation frame timer and advances state
Boss_ShieldViper_AnimDelayLoop:                         ; DATA XREF: ROM:0004F758   o  ; was: loc_4F768
                subq.w  #1,$48(a5)
                bne.s   Boss_ShieldViperAnimationScript_Return
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
Boss_ShieldViperAnimationScript_Return:                 ; CODE XREF: Boss_ShieldViperAnimationScript+E   j  ; was: locret_4F778
                rts
; End of function Boss_ShieldViperAnimationScript
; Projectile main handler
Projectile_ShieldViperMain:                             ; DATA XREF: ROM:0004F75A   o  ; was: sub_4F77A
                bsr.w   Boss_ShieldViperUpdatePatternPhaseB
                subq.w  #1,$48(a5)
                bne.s   Projectile_ShieldViperMain_Return
                addq.w  #2,4(a5)
Projectile_ShieldViperMain_Return:                      ; CODE XREF: Projectile_ShieldViperMain+8   j  ; was: locret_4F788
                rts
; End of function Projectile_ShieldViperMain
; Projectile bullet handler
Projectile_ShieldViperBullet:                           ; DATA XREF: ROM:0004F75C   o  ; was: sub_4F78A
                bsr.w   Boss_ShieldViperUpdatePatternPhaseB
                bsr.w   Boss_ShieldViperUpdatePatternPhaseC
                rts
; End of function Projectile_ShieldViperBullet
; Advances the first effect-pattern phase
Boss_ShieldViperUpdatePatternPhaseA:                    ; CODE XREF: Boss_ShieldViperMovement2+E   p  ; was: sub_4F794
                addi.l  #$2000,(dword_FF944E+2).w
                move.w  (dword_FF944E+2).w,d0
                add.w   d0,(word_FF945C).w
                move.w  (word_FF945C).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   Boss_ShieldViperUpdatePatternPhaseA_FillRange
                moveq   #0,d0
                move.l  d0,(dword_FF944E+2).w
                move.w  d0,(word_FF945C).w
Boss_ShieldViperUpdatePatternPhaseA_FillRange:          ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseA+18   j  ; was: loc_4F7B8
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperFillPatternRange
; End of function Boss_ShieldViperUpdatePatternPhaseA
; Advances the second effect-pattern phase while the boss remains active
Boss_ShieldViperUpdatePatternPhaseB:                    ; CODE XREF: Projectile_ShieldViperMain   p  ; was: sub_4F7C0
                                        ; sub_4F78A   p
                addi.l  #$2000,(dword_FF9452+2).w
                move.w  (dword_FF9452+2).w,d0
                add.w   d0,(word_FF945E).w
                move.w  (word_FF945E).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   Boss_ShieldViperUpdatePatternPhaseB_CheckActive
                moveq   #0,d0
                move.l  d0,(dword_FF9452+2).w
                move.w  d0,(word_FF945E).w
Boss_ShieldViperUpdatePatternPhaseB_CheckActive:        ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseB+18   j  ; was: loc_4F7E4
                btst    #6,(byte_FFC641).w
                bne.s   Boss_ShieldViperUpdatePatternPhaseB_Return
                btst    #7,(word_FFC622).w
                bne.s   Boss_ShieldViperUpdatePatternPhaseB_Return
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperFillPatternRange
; ---------------------------------------------------------------------------
Boss_ShieldViperUpdatePatternPhaseB_Return:             ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseB+2A   j  ; was: locret_4F7FC
                                        ; Boss_ShieldViperUpdatePatternPhaseB+32   j
                rts
; End of function Boss_ShieldViperUpdatePatternPhaseB
; Advances the third effect-pattern phase while the boss remains active
Boss_ShieldViperUpdatePatternPhaseC:                    ; CODE XREF: Projectile_ShieldViperBullet+4   p  ; was: sub_4F7FE
                addi.l  #$2000,(dword_FF9456+2).w
                move.w  (dword_FF9456+2).w,d0
                add.w   d0,(word_FF9460).w
                move.w  (word_FF9460).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   Boss_ShieldViperUpdatePatternPhaseC_CheckActive
                moveq   #0,d0
                move.l  d0,(dword_FF9456+2).w
                move.w  d0,(word_FF9460).w
Boss_ShieldViperUpdatePatternPhaseC_CheckActive:        ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseC+18   j  ; was: loc_4F822
                btst    #6,(byte_FFC641).w
                bne.s   Boss_ShieldViperUpdatePatternPhaseC_Return
                btst    #7,(word_FFC622).w
                bne.s   Boss_ShieldViperUpdatePatternPhaseC_Return
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperFillPatternRange
; ---------------------------------------------------------------------------
Boss_ShieldViperUpdatePatternPhaseC_Return:             ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseC+2A   j  ; was: locret_4F83A
                                        ; Boss_ShieldViperUpdatePatternPhaseC+32   j
                rts
; End of function Boss_ShieldViperUpdatePatternPhaseC
; Clears the 96-entry effect-pattern buffer
Boss_ShieldViperClearPatternBuffer:                     ; CODE XREF: Boss_ShieldViperMovement2+A   p  ; was: sub_4F83C
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
                moveq   #0,d0
Boss_ShieldViperClearPatternBuffer_Loop:                ; CODE XREF: Boss_ShieldViperClearPatternBuffer+C   j  ; was: loc_4F846
                move.l  d0,-(a1)
                dbf     d7,Boss_ShieldViperClearPatternBuffer_Loop
                rts
; End of function Boss_ShieldViperClearPatternBuffer
; Fills a selected range of the effect-pattern buffer
Boss_ShieldViperFillPatternRange:                       ; CODE XREF: Boss_ShieldViperUpdatePatternPhaseA+28   j  ; was: sub_4F84E
                                        ; Boss_ShieldViperUpdatePatternPhaseB+38   j
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
                move.l  #$8080808,d3
                moveq   #0,d4
                move.l  #$88888888,d5
                move.w  d0,d2
                add.w   d1,d2
Boss_ShieldViperFillPatternRange_Loop:                  ; CODE XREF: Boss_ShieldViperFillPatternRange+32   j  ; was: loc_4F868
                cmp.w   d0,d7
                bcs.s   Boss_ShieldViperFillPatternRange_Next
                cmp.w   d2,d7
                bhi.s   Boss_ShieldViperFillPatternRange_Next
                move.l  d3,(a1)
                move.l  d3,d5
                move.l  #$88888888,d3
                sub.l   d5,d3
Boss_ShieldViperFillPatternRange_Next:                  ; CODE XREF: Boss_ShieldViperFillPatternRange+1C   j  ; was: loc_4F87C
                                        ; Boss_ShieldViperFillPatternRange+20   j
                lea     -4(a1),a1
                dbf     d7,Boss_ShieldViperFillPatternRange_Loop
                rts
; End of function Boss_ShieldViperFillPatternRange
; Transfers the effect-pattern buffer to the rendering workspace
Boss_ShieldViperTransferPatternBuffer:                  ; CODE XREF: Boss_ShieldViperMovement2+38   p  ; was: sub_4F886
                lea     (word_FF9C00).w,a0
                move.w  #$3A80,d0
                move.w  #$8F02,d3
                move.l  #$940093C0,d4
                jmp     VDP_QueueCommand_Build
; End of function Boss_ShieldViperTransferPatternBuffer
; Applies gravity effect to 96 particle positions in memory
Effect_ApplyGravityToParticles:
                lea     (dword_FF9A00).w,a0             ; was: sub_4F89E
                move.w  #$5F,d7                         ; '_'
                moveq   #0,d0
Effect_ApplyGravityToParticles_UpdateLoop:              ; CODE XREF: Effect_ApplyGravityToParticles+12   j  ; was: loc_4F8A8
                subi.l  #$3E8,d0
                add.l   d0,(a0)+
                dbf     d7,Effect_ApplyGravityToParticles_UpdateLoop
                lea     (dword_FF9A00).w,a0
                movea.w #(byte_FFE602-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
Effect_ApplyGravityToParticles_CopyLoop:                ; CODE XREF: Effect_ApplyGravityToParticles+2C   j  ; was: loc_4F8C0
                move.w  (a0),(a1)
                lea     4(a0),a0
                lea     4(a1),a1
                dbf     d7,Effect_ApplyGravityToParticles_CopyLoop
                rts
; End of function Effect_ApplyGravityToParticles
; Updates particle effect counters based on frame parity
Effect_UpdateParticleCounters:
                movea.w #(byte_FFE370-M68K_RAM),a0      ; was: sub_4F8D0
                btst    #0,(word_FFA000+1).w
                bne.s   Effect_UpdateParticleCounters_Decrement
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)
                rts
; ---------------------------------------------------------------------------
Effect_UpdateParticleCounters_Decrement:                ; CODE XREF: Effect_UpdateParticleCounters+A   j  ; was: loc_4F8E6
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)
                rts
; End of function Effect_UpdateParticleCounters
