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
                bne.s   locret_4F64C
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4F64C
                jsr     Projectile_ShieldViperSpawnEffect(pc)  ; (pc)
                move.b  $20(a5),$20(a0)
                move.w  $970(a5),$10(a0)
                move.w  $974(a5),$14(a0)
                lea     (word_1B514).l,a3
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
locret_4F64C:                                           ; CODE XREF: Boss_ShieldViperSpawnProjectileWithAngle+E   j
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
                beq.w   locret_4F6A2
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   loc_4F678
                subi.w  #4,$10(a0)
loc_4F678:                                              ; CODE XREF: Debug_MoveCursorWithDPad+18   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4F686
                addi.w  #4,$10(a0)
loc_4F686:                                              ; CODE XREF: Debug_MoveCursorWithDPad+26   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4F694
                subi.w  #4,$14(a1)
loc_4F694:                                              ; CODE XREF: Debug_MoveCursorWithDPad+34   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4F6A2
                addi.w  #4,$14(a1)
locret_4F6A2:                                           ; CODE XREF: Debug_MoveCursorWithDPad+6   j
                                        ; Debug_MoveCursorWithDPad+42   j
                rts
; End of function Debug_MoveCursorWithDPad
; Debug routine to rotate shield viper segment with D-pad left/right
Debug_RotateSegmentWithDPad:                            ; CODE XREF: Debug_ShieldViperUpdate   p  ; was: sub_4F6A4
                btst    #4,(word_FFF706).w
                beq.w   locret_4F6CE
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   loc_4F6C2
                subq.w  #4,$56(a5)
loc_4F6C2:                                              ; CODE XREF: Debug_RotateSegmentWithDPad+18   j
                btst    #3,(word_FFF706).w
                beq.s   locret_4F6CE
                addq.w  #4,$56(a5)
locret_4F6CE:                                           ; CODE XREF: Debug_RotateSegmentWithDPad+6   j
                                        ; Debug_RotateSegmentWithDPad+24   j
                rts
; End of function Debug_RotateSegmentWithDPad
; Debug routine to adjust rotation delta with D-pad up/down
Debug_AdjustRotationWithDPad:                           ; CODE XREF: Debug_ShieldViperUpdate+4   p  ; was: sub_4F6D0
                btst    #4,(word_FFF706).w
                beq.w   locret_4F6FA
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #0,(word_FFF706).w
                beq.s   loc_4F6EE
                addq.w  #1,(dword_FF9404).w
loc_4F6EE:                                              ; CODE XREF: Debug_AdjustRotationWithDPad+18   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4F6FA
                subq.w  #1,(dword_FF9404).w
locret_4F6FA:                                           ; CODE XREF: Debug_AdjustRotationWithDPad+6   j
                                        ; Debug_AdjustRotationWithDPad+24   j
                rts
; End of function Debug_AdjustRotationWithDPad
; Debug routine to trigger shield viper attack state 2 with button press
Debug_TriggerAttackState:
                btst    #4,(word_FFF706).w              ; was: sub_4F6FC
                beq.w   locret_4F70A
                bsr.w   Boss_ShieldViperAttackState2
locret_4F70A:                                           ; CODE XREF: Debug_TriggerAttackState+6   j
                rts
; End of function Debug_TriggerAttackState
; Movement pattern 2
Boss_ShieldViperMovement2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F70C
                btst    #0,(word_FFA000+1).w
                bne.w   locret_4F748
                bsr.w   Boss_ShieldViperShootPattern1
                bsr.w   Boss_ShieldViperMovement3
                btst    #6,(byte_FFC641).w
                beq.s   loc_4F736
                move.w  (word_FF945C).w,d0
                add.w   d0,d0
                andi.w  #$EE0,d0
                addi.w  #$660,d0
                bra.s   loc_4F73E
; ---------------------------------------------------------------------------
loc_4F736:                                              ; CODE XREF: Boss_ShieldViperMovement2+18   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$EEE,d0
loc_4F73E:                                              ; CODE XREF: Boss_ShieldViperMovement2+28   j
                move.w  d0,(word_FFE310).w
                bsr.s   Boss_ShieldViperUpdateSprites
                bsr.w   Boss_ShieldViperShootPattern3
locret_4F748:                                           ; CODE XREF: Boss_ShieldViperMovement2+6   j
                rts
; End of function Boss_ShieldViperMovement2
; Updates boss sprites
Boss_ShieldViperUpdateSprites:                          ; CODE XREF: Boss_ShieldViperMovement2+36   p  ; was: sub_4F74A
                move.w  4(a5),d0
                lea     off_4F756(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperUpdateSprites
; ---------------------------------------------------------------------------
off_4F756:      dc.w    Boss_ShieldViperAnimationScript-*  ; DATA XREF: Boss_ShieldViperUpdateSprites+4   o
                dc.w    Boss_ShieldViper_AnimDelayLoop-*
                dc.w    Projectile_ShieldViperMain-*
                dc.w    Projectile_ShieldViperBullet-*

; Animation script interpreter
Boss_ShieldViperAnimationScript:                        ; DATA XREF: ROM:off_4F756   o  ; was: sub_4F75E
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
; Decrements animation frame timer and advances state
Boss_ShieldViper_AnimDelayLoop:                         ; DATA XREF: ROM:0004F758   o  ; was: loc_4F768
                subq.w  #1,$48(a5)
                bne.s   locret_4F778
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
locret_4F778:                                           ; CODE XREF: Boss_ShieldViperAnimationScript+E   j
                rts
; End of function Boss_ShieldViperAnimationScript
; Projectile main handler
Projectile_ShieldViperMain:                             ; DATA XREF: ROM:0004F75A   o  ; was: sub_4F77A
                bsr.w   Boss_ShieldViperPaletteUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4F788
                addq.w  #2,4(a5)
locret_4F788:                                           ; CODE XREF: Projectile_ShieldViperMain+8   j
                rts
; End of function Projectile_ShieldViperMain
; Projectile bullet handler
Projectile_ShieldViperBullet:                           ; DATA XREF: ROM:0004F75C   o  ; was: sub_4F78A
                bsr.w   Boss_ShieldViperPaletteUpdate
                bsr.w   Boss_ShieldViperCleanup
                rts
; End of function Projectile_ShieldViperBullet
; Movement pattern 3
Boss_ShieldViperMovement3:                              ; CODE XREF: Boss_ShieldViperMovement2+E   p  ; was: sub_4F794
                addi.l  #$2000,(dword_FF944E+2).w
                move.w  (dword_FF944E+2).w,d0
                add.w   d0,(word_FF945C).w
                move.w  (word_FF945C).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   loc_4F7B8
                moveq   #0,d0
                move.l  d0,(dword_FF944E+2).w
                move.w  d0,(word_FF945C).w
loc_4F7B8:                                              ; CODE XREF: Boss_ShieldViperMovement3+18   j
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperShootPattern2
; End of function Boss_ShieldViperMovement3
; Palette update handler
Boss_ShieldViperPaletteUpdate:                          ; CODE XREF: Projectile_ShieldViperMain   p  ; was: sub_4F7C0
                                        ; sub_4F78A   p
                addi.l  #$2000,(dword_FF9452+2).w
                move.w  (dword_FF9452+2).w,d0
                add.w   d0,(word_FF945E).w
                move.w  (word_FF945E).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   loc_4F7E4
                moveq   #0,d0
                move.l  d0,(dword_FF9452+2).w
                move.w  d0,(word_FF945E).w
loc_4F7E4:                                              ; CODE XREF: Boss_ShieldViperPaletteUpdate+18   j
                btst    #6,(byte_FFC641).w
                bne.s   locret_4F7FC
                btst    #7,(word_FFC622).w
                bne.s   locret_4F7FC
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperShootPattern2
; ---------------------------------------------------------------------------
locret_4F7FC:                                           ; CODE XREF: Boss_ShieldViperPaletteUpdate+2A   j
                                        ; Boss_ShieldViperPaletteUpdate+32   j
                rts
; End of function Boss_ShieldViperPaletteUpdate
; Cleanup after defeat
Boss_ShieldViperCleanup:                                ; CODE XREF: Projectile_ShieldViperBullet+4   p  ; was: sub_4F7FE
                addi.l  #$2000,(dword_FF9456+2).w
                move.w  (dword_FF9456+2).w,d0
                add.w   d0,(word_FF9460).w
                move.w  (word_FF9460).w,d0
                cmpi.w  #$30,d0                         ; '0'
                blt.s   loc_4F822
                moveq   #0,d0
                move.l  d0,(dword_FF9456+2).w
                move.w  d0,(word_FF9460).w
loc_4F822:                                              ; CODE XREF: Boss_ShieldViperCleanup+18   j
                btst    #6,(byte_FFC641).w
                bne.s   locret_4F83A
                btst    #7,(word_FFC622).w
                bne.s   locret_4F83A
                move.w  d0,d1
                add.w   d0,d0
                bra.w   Boss_ShieldViperShootPattern2
; ---------------------------------------------------------------------------
locret_4F83A:                                           ; CODE XREF: Boss_ShieldViperCleanup+2A   j
                                        ; Boss_ShieldViperCleanup+32   j
                rts
; End of function Boss_ShieldViperCleanup
; Shooting pattern 1
Boss_ShieldViperShootPattern1:                          ; CODE XREF: Boss_ShieldViperMovement2+A   p  ; was: sub_4F83C
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
                moveq   #0,d0
loc_4F846:                                              ; CODE XREF: Boss_ShieldViperShootPattern1+C   j
                move.l  d0,-(a1)
                dbf     d7,loc_4F846
                rts
; End of function Boss_ShieldViperShootPattern1
; Shooting pattern 2
Boss_ShieldViperShootPattern2:                          ; CODE XREF: Boss_ShieldViperMovement3+28   j  ; was: sub_4F84E
                                        ; Boss_ShieldViperPaletteUpdate+38   j
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
                move.l  #$8080808,d3
                moveq   #0,d4
                move.l  #$88888888,d5
                move.w  d0,d2
                add.w   d1,d2
loc_4F868:                                              ; CODE XREF: Boss_ShieldViperShootPattern2+32   j
                cmp.w   d0,d7
                bcs.s   loc_4F87C
                cmp.w   d2,d7
                bhi.s   loc_4F87C
                move.l  d3,(a1)
                move.l  d3,d5
                move.l  #$88888888,d3
                sub.l   d5,d3
loc_4F87C:                                              ; CODE XREF: Boss_ShieldViperShootPattern2+1C   j
                                        ; Boss_ShieldViperShootPattern2+20   j
                lea     -4(a1),a1
                dbf     d7,loc_4F868
                rts
; End of function Boss_ShieldViperShootPattern2
; Shooting pattern 3
Boss_ShieldViperShootPattern3:                          ; CODE XREF: Boss_ShieldViperMovement2+38   p  ; was: sub_4F886
                lea     (word_FF9C00).w,a0
                move.w  #$3A80,d0
                move.w  #$8F02,d3
                move.l  #$940093C0,d4
                jmp     loc_1B78C
; End of function Boss_ShieldViperShootPattern3
; Applies gravity effect to 96 particle positions in memory
Effect_ApplyGravityToParticles:
                lea     (dword_FF9A00).w,a0             ; was: sub_4F89E
                move.w  #$5F,d7                         ; '_'
                moveq   #0,d0
loc_4F8A8:                                              ; CODE XREF: Effect_ApplyGravityToParticles+12   j
                subi.l  #$3E8,d0
                add.l   d0,(a0)+
                dbf     d7,loc_4F8A8
                lea     (dword_FF9A00).w,a0
                movea.w #(byte_FFE602-M68K_RAM),a1
                move.w  #$5F,d7                         ; '_'
loc_4F8C0:                                              ; CODE XREF: Effect_ApplyGravityToParticles+2C   j
                move.w  (a0),(a1)
                lea     4(a0),a0
                lea     4(a1),a1
                dbf     d7,loc_4F8C0
                rts
; End of function Effect_ApplyGravityToParticles
; Updates particle effect counters based on frame parity
Effect_UpdateParticleCounters:
                movea.w #(byte_FFE370-M68K_RAM),a0      ; was: sub_4F8D0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4F8E6
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)
                rts
; ---------------------------------------------------------------------------
loc_4F8E6:                                              ; CODE XREF: Effect_UpdateParticleCounters+A   j
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)
                rts
; End of function Effect_UpdateParticleCounters
; Movement pattern 2
