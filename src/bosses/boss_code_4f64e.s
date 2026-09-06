Debug_DisableProjectilesAndMove:                              ; CODE XREF: Boss_ShieldViperPrepareMultiShot+12   p  ; was: sub_4F64E
                                        ; Debug_CheckButton2+6   j
                bsr.w Projectile_ShieldViperDisable
                bsr.w Boss_WolfGaropaMovement1
                rts
; End of function Debug_DisableProjectilesAndMove
; Debug routine to move cursor position with D-pad input
Debug_MoveCursorWithDPad:                              ; CODE XREF: Debug_ShieldViperUpdate+8   p  ; was: sub_4F658
                btst    #5,(word_FFF706).w
                beq.w   locret_4F6A2
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   loc_4F678
                subi.w  #4,$10(a0)
loc_4F678:                              ; CODE XREF: Debug_MoveCursorWithDPad+18   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4F686
                addi.w  #4,$10(a0)
loc_4F686:                              ; CODE XREF: Debug_MoveCursorWithDPad+26   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4F694
                subi.w  #4,$14(a1)
loc_4F694:                              ; CODE XREF: Debug_MoveCursorWithDPad+34   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4F6A2
                addi.w  #4,$14(a1)
locret_4F6A2:                           ; CODE XREF: Debug_MoveCursorWithDPad+6   j
                                        ; Debug_MoveCursorWithDPad+42   j
                rts
; End of function Debug_MoveCursorWithDPad
; Debug routine to rotate shield viper segment with D-pad left/right
Debug_RotateSegmentWithDPad:                              ; CODE XREF: Debug_ShieldViperUpdate   p  ; was: sub_4F6A4
                btst    #4,(word_FFF706).w
                beq.w   locret_4F6CE
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #2,(word_FFF706).w
                beq.s   loc_4F6C2
                subq.w  #4,$56(a5)
loc_4F6C2:                              ; CODE XREF: Debug_RotateSegmentWithDPad+18   j
                btst    #3,(word_FFF706).w
                beq.s   locret_4F6CE
                addq.w  #4,$56(a5)
locret_4F6CE:                           ; CODE XREF: Debug_RotateSegmentWithDPad+6   j
                                        ; Debug_RotateSegmentWithDPad+24   j
                rts
; End of function Debug_RotateSegmentWithDPad
; Debug routine to adjust rotation delta with D-pad up/down
Debug_AdjustRotationWithDPad:                              ; CODE XREF: Debug_ShieldViperUpdate+4   p  ; was: sub_4F6D0
                btst    #4,(word_FFF706).w
                beq.w   locret_4F6FA
                movea.w (dword_FF9408).w,a0
                movea.w (dword_FF9408+2).w,a1
                btst    #0,(word_FFF706).w
                beq.s   loc_4F6EE
                addq.w  #1,(dword_FF9404).w
loc_4F6EE:                              ; CODE XREF: Debug_AdjustRotationWithDPad+18   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4F6FA
                subq.w  #1,(dword_FF9404).w
locret_4F6FA:                           ; CODE XREF: Debug_AdjustRotationWithDPad+6   j
                                        ; Debug_AdjustRotationWithDPad+24   j
                rts
; End of function Debug_AdjustRotationWithDPad
; Debug routine to trigger shield viper attack state 2 with button press
Debug_TriggerAttackState:
                btst    #4,(word_FFF706).w  ; was: sub_4F6FC
                beq.w   locret_4F70A
                bsr.w Boss_ShieldViperAttackState2
locret_4F70A:                           ; CODE XREF: Debug_TriggerAttackState+6   j
                rts
; End of function Debug_TriggerAttackState
; Movement pattern 2
Boss_ShieldViperMovement2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F70C
                btst    #0,(word_FFA000+1).w
                bne.w   locret_4F748
                bsr.w Boss_ShieldViperShootPattern1
                bsr.w Boss_ShieldViperMovement3
                btst    #6,(byte_FFC641).w
                beq.s   loc_4F736
                move.w  (word_FF945C).w,d0
                add.w   d0,d0
                andi.w  #$EE0,d0
                addi.w  #$660,d0
                bra.s   loc_4F73E
; ---------------------------------------------------------------------------
loc_4F736:                              ; CODE XREF: Boss_ShieldViperMovement2+18   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$EEE,d0
loc_4F73E:                              ; CODE XREF: Boss_ShieldViperMovement2+28   j
                move.w  d0,(word_FFE310).w
                bsr.s Boss_ShieldViperUpdateSprites
                bsr.w Boss_ShieldViperShootPattern3
locret_4F748:                           ; CODE XREF: Boss_ShieldViperMovement2+6   j
                rts
; End of function Boss_ShieldViperMovement2
; Updates boss sprites
Boss_ShieldViperUpdateSprites:                              ; CODE XREF: Boss_ShieldViperMovement2+36   p  ; was: sub_4F74A
                move.w  4(a5),d0
                lea     off_4F756(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperUpdateSprites
; ---------------------------------------------------------------------------
off_4F756:      dc.w Boss_ShieldViperAnimationScript-*        ; DATA XREF: Boss_ShieldViperUpdateSprites+4   o
                dc.w Boss_ShieldViper_AnimDelayLoop-*
                dc.w Projectile_ShieldViperMain-*
                dc.w Projectile_ShieldViperBullet-*


; Animation script interpreter
Boss_ShieldViperAnimationScript:                              ; DATA XREF: ROM:off_4F756   o  ; was: sub_4F75E
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
; Decrements animation frame timer and advances state
Boss_ShieldViper_AnimDelayLoop:                              ; DATA XREF: ROM:0004F758   o  ; was: loc_4F768
                subq.w  #1,$48(a5)
                bne.s   locret_4F778
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
locret_4F778:                           ; CODE XREF: Boss_ShieldViperAnimationScript+E   j
                rts
; End of function Boss_ShieldViperAnimationScript
; Projectile main handler
Projectile_ShieldViperMain:                              ; DATA XREF: ROM:0004F75A   o  ; was: sub_4F77A
                bsr.w Boss_ShieldViperPaletteUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4F788
                addq.w  #2,4(a5)
locret_4F788:                           ; CODE XREF: Projectile_ShieldViperMain+8   j
                rts
; End of function Projectile_ShieldViperMain
; Projectile bullet handler
Projectile_ShieldViperBullet:                              ; DATA XREF: ROM:0004F75C   o  ; was: sub_4F78A
                bsr.w Boss_ShieldViperPaletteUpdate
                bsr.w Boss_ShieldViperCleanup
                rts
; End of function Projectile_ShieldViperBullet
; Movement pattern 3
Boss_ShieldViperMovement3:                              ; CODE XREF: Boss_ShieldViperMovement2+E   p  ; was: sub_4F794
                addi.l  #$2000,(dword_FF944E+2).w
                move.w  (dword_FF944E+2).w,d0
                add.w   d0,(word_FF945C).w
                move.w  (word_FF945C).w,d0
                cmpi.w  #$30,d0 ; '0'
                blt.s   loc_4F7B8
                moveq   #0,d0
                move.l  d0,(dword_FF944E+2).w
                move.w  d0,(word_FF945C).w
loc_4F7B8:                              ; CODE XREF: Boss_ShieldViperMovement3+18   j
                move.w  d0,d1
                add.w   d0,d0
                bra.w Boss_ShieldViperShootPattern2
; End of function Boss_ShieldViperMovement3
; Palette update handler
Boss_ShieldViperPaletteUpdate:                              ; CODE XREF: Projectile_ShieldViperMain   p  ; was: sub_4F7C0
                                        ; sub_4F78A   p
                addi.l  #$2000,(dword_FF9452+2).w
                move.w  (dword_FF9452+2).w,d0
                add.w   d0,(word_FF945E).w
                move.w  (word_FF945E).w,d0
                cmpi.w  #$30,d0 ; '0'
                blt.s   loc_4F7E4
                moveq   #0,d0
                move.l  d0,(dword_FF9452+2).w
                move.w  d0,(word_FF945E).w
loc_4F7E4:                              ; CODE XREF: Boss_ShieldViperPaletteUpdate+18   j
                btst    #6,(byte_FFC641).w
                bne.s   locret_4F7FC
                btst    #7,(word_FFC622).w
                bne.s   locret_4F7FC
                move.w  d0,d1
                add.w   d0,d0
                bra.w Boss_ShieldViperShootPattern2
; ---------------------------------------------------------------------------
locret_4F7FC:                           ; CODE XREF: Boss_ShieldViperPaletteUpdate+2A   j
                                        ; Boss_ShieldViperPaletteUpdate+32   j
                rts
; End of function Boss_ShieldViperPaletteUpdate
; Cleanup after defeat
Boss_ShieldViperCleanup:                              ; CODE XREF: Projectile_ShieldViperBullet+4   p  ; was: sub_4F7FE
                addi.l  #$2000,(dword_FF9456+2).w
                move.w  (dword_FF9456+2).w,d0
                add.w   d0,(word_FF9460).w
                move.w  (word_FF9460).w,d0
                cmpi.w  #$30,d0 ; '0'
                blt.s   loc_4F822
                moveq   #0,d0
                move.l  d0,(dword_FF9456+2).w
                move.w  d0,(word_FF9460).w
loc_4F822:                              ; CODE XREF: Boss_ShieldViperCleanup+18   j
                btst    #6,(byte_FFC641).w
                bne.s   locret_4F83A
                btst    #7,(word_FFC622).w
                bne.s   locret_4F83A
                move.w  d0,d1
                add.w   d0,d0
                bra.w Boss_ShieldViperShootPattern2
; ---------------------------------------------------------------------------
locret_4F83A:                           ; CODE XREF: Boss_ShieldViperCleanup+2A   j
                                        ; Boss_ShieldViperCleanup+32   j
                rts
; End of function Boss_ShieldViperCleanup
; Shooting pattern 1
Boss_ShieldViperShootPattern1:                              ; CODE XREF: Boss_ShieldViperMovement2+A   p  ; was: sub_4F83C
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7 ; '_'
                moveq   #0,d0
loc_4F846:                              ; CODE XREF: Boss_ShieldViperShootPattern1+C   j
                move.l  d0,-(a1)
                dbf     d7,loc_4F846
                rts
; End of function Boss_ShieldViperShootPattern1
; Shooting pattern 2
Boss_ShieldViperShootPattern2:                              ; CODE XREF: Boss_ShieldViperMovement3+28   j  ; was: sub_4F84E
                                        ; Boss_ShieldViperPaletteUpdate+38   j ...
                movea.w #(byte_FF9D80-M68K_RAM),a1
                move.w  #$5F,d7 ; '_'
                move.l  #$8080808,d3
                moveq   #0,d4
                move.l  #$88888888,d5
                move.w  d0,d2
                add.w   d1,d2
loc_4F868:                              ; CODE XREF: Boss_ShieldViperShootPattern2+32   j
                cmp.w   d0,d7
                bcs.s   loc_4F87C
                cmp.w   d2,d7
                bhi.s   loc_4F87C
                move.l  d3,(a1)
                move.l  d3,d5
                move.l  #$88888888,d3
                sub.l   d5,d3
loc_4F87C:                              ; CODE XREF: Boss_ShieldViperShootPattern2+1C   j
                                        ; Boss_ShieldViperShootPattern2+20   j
                lea     -4(a1),a1
                dbf     d7,loc_4F868
                rts
; End of function Boss_ShieldViperShootPattern2
; Shooting pattern 3
Boss_ShieldViperShootPattern3:                              ; CODE XREF: Boss_ShieldViperMovement2+38   p  ; was: sub_4F886
                lea     (word_FF9C00).w,a0
                move.w  #$3A80,d0
                move.w  #$8F02,d3
                move.l  #$940093C0,d4
                jmp     loc_1B78C
; End of function Boss_ShieldViperShootPattern3
; Applies gravity effect to 96 particle positions in memory
Effect_ApplyGravityToParticles:
                lea     (dword_FF9A00).w,a0  ; was: sub_4F89E
                move.w  #$5F,d7 ; '_'
                moveq   #0,d0
loc_4F8A8:                              ; CODE XREF: Effect_ApplyGravityToParticles+12   j
                subi.l  #$3E8,d0
                add.l   d0,(a0)+
                dbf     d7,loc_4F8A8
                lea     (dword_FF9A00).w,a0
                movea.w #(byte_FFE602-M68K_RAM),a1
                move.w  #$5F,d7 ; '_'
loc_4F8C0:                              ; CODE XREF: Effect_ApplyGravityToParticles+2C   j
                move.w  (a0),(a1)
                lea     4(a0),a0
                lea     4(a1),a1
                dbf     d7,loc_4F8C0
                rts
; End of function Effect_ApplyGravityToParticles
; Updates particle effect counters based on frame parity
Effect_UpdateParticleCounters:
                movea.w #(byte_FFE370-M68K_RAM),a0  ; was: sub_4F8D0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_4F8E6
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)+
                addq.w  #1,(a0)
                rts
; ---------------------------------------------------------------------------
loc_4F8E6:                              ; CODE XREF: Effect_UpdateParticleCounters+A   j
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)+
                subq.w  #1,(a0)
                rts
; End of function Effect_UpdateParticleCounters
; Movement pattern 2
Boss_WolfGaropaMovement2:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F8F0
                tst.w   4(a5)
                beq.w   loc_4F920
                tst.w   8(a5)
                beq.s   loc_4F920
                btst    #2,(byte_FF80EC).w
                bne.s   loc_4F916
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4F916
                tst.w   (word_FF8200).w
                beq.w Boss_WolfGaropaUpdateSprites
loc_4F916:                              ; CODE XREF: Boss_WolfGaropaMovement2+14   j
                                        ; Boss_WolfGaropaMovement2+1C   j
                bsr.w Boss_WolfGaropaDamage
                jsr (Gfx_InitPaletteFade).l
loc_4F920:                              ; CODE XREF: Boss_WolfGaropaMovement2+4   j
                                        ; Boss_WolfGaropaMovement2+C   j
                move.w  4(a5),d0
                movea.w off_4F930(pc,d0.w),a0
                adda.l  #Boss_WolfGaropaMovement3,a0
                jmp     (a0)
; ---------------------------------------------------------------------------
off_4F930:      dc.w Boss_WolfGaropaMovement3-Boss_WolfGaropaMovement3
                                        ; DATA XREF: Boss_WolfGaropaMovement2+34   r
                dc.w Boss_WolfGaropaInitMultiPattern-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaDashAttack-Boss_WolfGaropaMovement3
                dc.w Projectile_WolfGaropaBullet1-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaMovement_Pattern1-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaDiveLoop-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaMovement_Pattern3-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaDiveActive-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAnimationScript-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAnimationUpdate-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaMovement_Pattern4-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaShootAndAdvance-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAttack1-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAttack2-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAttack3-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAttack4-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaAttack4_Return-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaEmptyState-Boss_WolfGaropaMovement3
                dc.w Boss_WolfGaropaEmptyState-Boss_WolfGaropaMovement3
; End of function Boss_WolfGaropaMovement2
; Movement pattern 3
Boss_WolfGaropaMovement3:                              ; DATA XREF: Boss_WolfGaropaMovement2+38   o  ; was: sub_4F956
                                        ; sub_4F8F0:off_4F930   o ...
                tst.w   (word_FFF720).w
                bmi.w   locret_4FA94
                move.b  #$18,(byte_FFA420).w
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$288,(dword_FF8040).w
                moveq   #$18,d7
                movea.l #dword_3530C,a0
                movea.l #word_35370,a1
                movea.l #word_3538A,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$3E8,(a5)
                move.w  #$C00,2(a5)
                move.w  #$1F8,$B6(a5)
                move.w  #$1F8,$116(a5)
                move.w  #$120,$176(a5)
                move.w  #$120,$1D6(a5)
                moveq   #3,d0
                bset    d0,$36E(a5)
                bset    d0,$54E(a5)
                bset    d0,$72E(a5)
                bset    d0,$90E(a5)
                move.w  #$10,d0
                move.w  #$C000,d1
                move.w  #$AA88,d2
                moveq   #$18,d3
                move.w  d0,$960(a5)
                clr.w   $962(a5)
                move.w  d0,$9C0(a5)
                move.w  d1,$9C2(a5)
                move.w  d2,$9CE(a5)
                move.b  d3,$9E0(a5)
                addq.b  #4,$9E0(a5)
                move.l  #word_ED172,$9C8(a5)
                move.w  d0,$A20(a5)
                move.w  d1,$A22(a5)
                move.w  d2,$A2E(a5)
                move.b  #8,$A40(a5)
                move.l  #word_ED190,$A28(a5)
                move.w  #$2A88,d2
                move.w  d0,$A80(a5)
                move.w  d1,$A82(a5)
                move.w  d2,$A8E(a5)
                move.b  d3,$AA0(a5)
                addq.b  #4,$AA0(a5)
                move.l  #word_ED33A,$A88(a5)
                move.w  d0,$AE0(a5)
                move.w  d1,$AE2(a5)
                move.w  d2,$AEE(a5)
                move.b  d3,$B00(a5)
                move.l  #word_ED328,$AE8(a5)
                move.w  #$10,$B40(a5)
                move.w  #$8000,$B42(a5)
                move.w  #0,$B50(a5)
                move.w  #$500,$B48(a5)
                movea.l #word_1BDEC,a1
                jsr (Sprite_InitFromPointerTable).l
                movea.l #$FFFF2020,a0
                move.w  #$E000,d0
                move.w  #$1E0,d1
                moveq   #$10,d7
                jsr (Gfx_UpdateTilemapIndices).l
                lea     word_4FA96(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #2,$1DE(a5)
                bra.w Boss_WolfGaropaJumpAttack
; ---------------------------------------------------------------------------
locret_4FA94:                           ; CODE XREF: Boss_WolfGaropaMovement3+4   j
                                        ; DATA XREF: ROM:off_4FE72   o
                rts
; End of function Boss_WolfGaropaMovement3
; ---------------------------------------------------------------------------
word_4FA96:     dc.w $6220, $2000, $302, 1, $200, $304, $506, $708, $90A
                                        ; DATA XREF: Boss_WolfGaropaMovement3+128   o


; Initializes wolf garopa boss state 2 with position and attack pattern
Boss_WolfGaropaInitState2:
                move.w  #2,4(a5)  ; was: sub_4FAA8
                move.w  #$100,$10(a5)
                move.w  #$100,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bsr.w Boss_WolfGaropaShootPattern2
; End of function Boss_WolfGaropaInitState2
; Initializes wolf garopa with combined shoot patterns 6 and 5
Boss_WolfGaropaInitMultiPattern:                              ; DATA XREF: Boss_WolfGaropaMovement2+42   o  ; was: sub_4FAD8
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                lea     word_50874(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                bra.w Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaInitMultiPattern
; Jump attack pattern
Boss_WolfGaropaJumpAttack:                              ; CODE XREF: Boss_WolfGaropaMovement3+13A   j  ; was: sub_4FAEE
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$10(a5)
                move.w  #$110,$14(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$E0,$47C(a5)
                bsr.w Boss_WolfGaropaShootPattern2
; End of function Boss_WolfGaropaJumpAttack
; Dash attack pattern
Boss_WolfGaropaDashAttack:                              ; DATA XREF: Boss_WolfGaropaMovement2+44   o  ; was: sub_4FB1C
                btst    #0,$41C(a5)
                beq.s   loc_4FB4C
                btst    #3,$23E(a5)
                beq.s   loc_4FB4C
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr (UI_CheckVictoryCondition).l
                bra.s   loc_4FB4C
; End of function Boss_WolfGaropaDashAttack
; Bullet projectile 1
Projectile_WolfGaropaBullet1:                              ; DATA XREF: Boss_WolfGaropaMovement2+46   o  ; was: sub_4FB3A
                tst.w   (word_FF80C2).w
                bne.s   loc_4FB4C
                addq.w  #2,4(a5)
                clr.b   (byte_FF80EC).w
                bra.w   loc_4FB82
; ---------------------------------------------------------------------------
loc_4FB4C:                              ; CODE XREF: Boss_WolfGaropaDashAttack+6   j
                                        ; Boss_WolfGaropaDashAttack+E   j ...
                bsr.w Boss_WolfGaropaShootPattern1
loc_4FB50:                              ; CODE XREF: Projectile_WolfGaropaBullet1+BA   j
                                        ; Boss_WolfGaropaDiveLoop+2E   j ...
                btst    #2,$23E(a5)
                beq.s   loc_4FB5E
                move.w  #$1C,$53C(a5)
loc_4FB5E:                              ; CODE XREF: Projectile_WolfGaropaBullet1+1C   j
                move.b  (dword_FFFF08).w,d2
                andi.w  #$E,d2
                addi.w  #$1A0,d2
                move.w  d2,$53E(a5)
                move.w  (dword_FFFF08).w,d2
                andi.w  #$E,d2
                addi.w  #$170,d2
                moveq   #0,d3
                moveq   #4,d7
                bra.w Boss_WolfGaropaSpawnProjectile4
; ---------------------------------------------------------------------------
loc_4FB82:                              ; CODE XREF: Projectile_WolfGaropaBullet1+E   j
                                        ; Boss_WolfGaropaDiveLoop+46   j ...
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1C0,d0
                addi.w  #$100,d0
                move.w  d0,$11C(a5)
                move.w  #$80,$4DC(a5)
                move.w  #8,4(a5)
                clr.w   $11E(a5)
; Wolf Garopa movement pattern 1
Boss_WolfGaropaMovement_Pattern1:                              ; DATA XREF: Boss_WolfGaropaMovement2+48   o  ; was: loc_4FBA2
                tst.w   (word_FF8200).w
                beq.s   loc_4FBC6
                subq.w  #1,$11C(a5)
                bpl.s   loc_4FBC6
                tst.w   $4DE(a5)
                bpl.s   loc_4FBC6
                tst.w   $6BC(a5)
                bne.s   loc_4FBC6
                clr.b   $65E(a5)
                clr.w   $6BC(a5)
                bra.w   loc_4FC88
; ---------------------------------------------------------------------------
loc_4FBC6:                              ; CODE XREF: Projectile_WolfGaropaBullet1+6C   j
                                        ; Projectile_WolfGaropaBullet1+72   j ...
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FBE8
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                move.w  d0,$11E(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$C8,d0
                move.w  d0,$47C(a5)
loc_4FBE8:                              ; CODE XREF: Projectile_WolfGaropaBullet1+90   j
                bsr.w Boss_WolfGaropaShootPattern1
                bsr.w Boss_WolfGaropaGraphicsUpdate
                tst.w   (word_FF8200).w
                beq.w   loc_4FB50
                bsr.w Projectile_WolfGaropaBullet2
                move.w  $A76(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  d0,$53E(a5)
                tst.w   $4DC(a5)
                bmi.s   loc_4FC48
                subq.w  #1,$4DC(a5)
                bpl.s   loc_4FC20
                move.w  #$14,$4DE(a5)
locret_4FC1E:                           ; CODE XREF: Projectile_WolfGaropaBullet1+F0   j
                                        ; Projectile_WolfGaropaBullet1+12C   j
                rts
; ---------------------------------------------------------------------------
loc_4FC20:                              ; CODE XREF: Projectile_WolfGaropaBullet1+DC   j
                cmpi.w  #$40,$4DC(a5) ; '@'
                bmi.w Boss_WolfGaropaDefeatInit
                bne.s   locret_4FC1E
                move.w  #$18,$5FE(a5)
                move.w  #$2000,$65C(a5)
                move.b  #8,$65E(a5)
                move.b  #$ED,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_4FC48:                              ; CODE XREF: Projectile_WolfGaropaBullet1+D6   j
                cmpi.w  #$14,$4DE(a5)
                bne.s   loc_4FC5E
                tst.w   d3
                beq.w Boss_WolfGaropaDefeatInit
                clr.b   $65E(a5)
                clr.w   $6BC(a5)
loc_4FC5E:                              ; CODE XREF: Projectile_WolfGaropaBullet1+114   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4FC1E
                subq.w  #1,$4DE(a5)
                bpl.w Projectile_WolfGaropaHoming
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$80,d0
                move.w  d0,$4DC(a5)
                move.w  #$3F,$5FC(a5) ; '?'
                rts
; ---------------------------------------------------------------------------
loc_4FC88:                              ; CODE XREF: Projectile_WolfGaropaBullet1+88   j
                move.w  #$14,4(a5)
                bset    #3,$9CE(a5)
                move.w  #$12C,$47C(a5)
; Wolf Garopa dash attack
Boss_WolfGaropaMovement_Pattern4:                              ; DATA XREF: Boss_WolfGaropaMovement2+54   o  ; was: loc_4FC9A
                bsr.w Boss_WolfGaropaShootPattern1
                move.w  #$140,d2
                moveq   #0,d3
                moveq   #8,d7
                bsr.w Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FCB8
                addq.w  #2,4(a5)
                move.w  #$20,$11E(a5) ; ' '
locret_4FCB8:                           ; CODE XREF: Projectile_WolfGaropaBullet1+172   j
                rts
; End of function Projectile_WolfGaropaBullet1
; Wolf garopa shoots pattern 1 and advances state after timer expires
Boss_WolfGaropaShootAndAdvance:                              ; DATA XREF: Boss_WolfGaropaMovement2+56   o  ; was: sub_4FCBA
                bsr.w Boss_WolfGaropaShootPattern1
                subq.w  #1,$11E(a5)
                bpl.s   locret_4FCCE
                addq.w  #2,4(a5)
                move.w  #1,$11E(a5)
locret_4FCCE:                           ; CODE XREF: Boss_WolfGaropaShootAndAdvance+8   j
                rts
; End of function Boss_WolfGaropaShootAndAdvance
; Wolf Garopa attack state 1: shoot pattern and spawn projectile at angle $C0
Boss_WolfGaropaAttack1:                              ; DATA XREF: Boss_WolfGaropaMovement2+58   o  ; was: sub_4FCD0
                bsr.w Boss_WolfGaropaShootPattern1
                move.w  #$C0,d2
                moveq   #0,d3
                moveq   #$16,d7
                bsr.w Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD0C
                move.b  #$35,d0 ; '5'
                jsr (Sound_PlaySFX).l
                jsr Projectile_SpawnWolfGaropaBomb(pc)   ; (pc)
                nop
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FD08
                addq.w  #4,4(a5)
                bclr    #3,$AEE(a5)
                bra.w Boss_WolfGaropaSetPattern1
; ---------------------------------------------------------------------------
loc_4FD08:                              ; CODE XREF: Boss_WolfGaropaAttack1+28   j
                addq.w  #2,4(a5)
locret_4FD0C:                           ; CODE XREF: Boss_WolfGaropaAttack1+12   j
                rts
; End of function Boss_WolfGaropaAttack1
; Wolf Garopa attack state 2: shoot pattern and spawn projectile at angle $140
Boss_WolfGaropaAttack2:                              ; DATA XREF: Boss_WolfGaropaMovement2+5A   o  ; was: sub_4FD0E
                bsr.w Boss_WolfGaropaShootPattern1
                bsr.w Boss_WolfGaropaSetPattern1
                move.w  #$140,d2
                moveq   #0,d3
                moveq   #$10,d7
                bsr.w Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD2A
                subq.w  #2,4(a5)
locret_4FD2A:                           ; CODE XREF: Boss_WolfGaropaAttack2+16   j
                rts
; End of function Boss_WolfGaropaAttack2
; Wolf Garopa attack state 3: shoot pattern and spawn projectile at angle $180
Boss_WolfGaropaAttack3:                              ; DATA XREF: Boss_WolfGaropaMovement2+5C   o  ; was: sub_4FD2C
                bsr.w Boss_WolfGaropaShootPattern1
                bsr.w Boss_WolfGaropaSetPattern1
                move.w  #$180,d2
                moveq   #0,d3
                moveq   #$C,d7
                bsr.w Boss_WolfGaropaSpawnProjectile4
                tst.w   d3
                beq.s   locret_4FD4E
                addq.w  #2,4(a5)
                move.w  #$30,$11E(a5) ; '0'
locret_4FD4E:                           ; CODE XREF: Boss_WolfGaropaAttack3+16   j
                rts
; End of function Boss_WolfGaropaAttack3
; Wolf Garopa attack state 4: manage countdown timer and transition to dive or retreat
Boss_WolfGaropaAttack4:                              ; DATA XREF: Boss_WolfGaropaMovement2+5E   o  ; was: sub_4FD50
                bsr.w Boss_WolfGaropaShootPattern1
                bsr.w Boss_WolfGaropaSetPattern1
                subq.w  #1,$11E(a5)
                bpl.s Boss_WolfGaropaAttack4_Return
                bset    #3,$AEE(a5)
                btst    #0,(dword_FFFF08+1).w
                bne.w Boss_WolfGaropaDiveInit2
                bra.w Boss_WolfGaropaDiveInit1
; ---------------------------------------------------------------------------
; Return from Wolf Garopa attack pattern 4
Boss_WolfGaropaAttack4_Return:                           ; CODE XREF: Boss_WolfGaropaAttack4+C   j  ; was: locret_4FD72
                                        ; DATA XREF: Boss_WolfGaropaMovement2+60   o
                rts
; End of function Boss_WolfGaropaAttack4
; Empty Wolf Garopa boss movement state
Boss_WolfGaropaEmptyState:                            ; DATA XREF: Boss_WolfGaropaMovement2+62   o  ; was: nullsub_118
                                        ; Boss_WolfGaropaMovement2+64   o
                rts
; End of function Boss_WolfGaropaEmptyState
; Set Wolf Garopa animation pattern pointer to word_ED310
Boss_WolfGaropaSetPattern1:                              ; CODE XREF: Boss_WolfGaropaAttack1+34   j  ; was: sub_4FD76
                                        ; Boss_WolfGaropaAttack2+4   p ...
                move.l  #word_ED310,$AE8(a5)
                rts
; End of function Boss_WolfGaropaSetPattern1
; Initialize Wolf Garopa dive attack: spawn projectile type 424 and set dive state
Boss_WolfGaropaDiveInit1:                              ; CODE XREF: Boss_WolfGaropaAttack4+1E   j  ; was: sub_4FD80
                tst.w   (word_FFFF0E).w
                bne.s   loc_4FD9A
                jsr (Projectile_InitType424).l
                bne.s   loc_4FD9A
                move.w  #$1A8,$10(a0)
                move.w  #$C8,$14(a0)
loc_4FD9A:                              ; CODE XREF: Boss_WolfGaropaDiveInit1+4   j
                                        ; Boss_WolfGaropaDiveInit1+C   j
                move.w  #$A,4(a5)
                bset    #1,$41C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #2,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                move.w  #$40,$11E(a5) ; '@'
                move.w  #$140,$47C(a5)
                bset    #3,$9CE(a5)
; End of function Boss_WolfGaropaDiveInit1
; Wolf Garopa dive attack loop: manage bomb state and attack cycles
Boss_WolfGaropaDiveLoop:                              ; DATA XREF: Boss_WolfGaropaMovement2+4A   o  ; was: sub_4FDC6
                tst.b   (byte_FF9DBA).w
                bne.s   loc_4FDF0
                tst.w   $11C(a5)
                bmi.w   loc_4FDF8
                subq.w  #1,$11E(a5)
                bpl.s   loc_4FDF0
                tst.w   (word_FF8200).w
                beq.w   loc_4FDF8
                bsr.w Boss_WolfGaropaBombTrigger
                tst.b   (byte_FF9DBA).w
                beq.s   loc_4FDF0
                subq.w  #1,$11C(a5)
loc_4FDF0:                              ; CODE XREF: Boss_WolfGaropaDiveLoop+4   j
                                        ; Boss_WolfGaropaDiveLoop+12   j ...
                bsr.w Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; ---------------------------------------------------------------------------
loc_4FDF8:                              ; CODE XREF: Boss_WolfGaropaDiveLoop+A   j
                                        ; Boss_WolfGaropaDiveLoop+18   j
                addq.w  #2,4(a5)
                bclr    #1,$41C(a5)
                move.w  #$40,$11C(a5) ; '@'
; Wolf Garopa charge movement
Boss_WolfGaropaMovement_Pattern3:                              ; DATA XREF: Boss_WolfGaropaMovement2+4C   o  ; was: loc_4FE08
                subq.w  #1,$11C(a5)
                bmi.w   loc_4FB82
                bsr.w Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; End of function Boss_WolfGaropaDiveLoop
; Initialize Wolf Garopa alternate dive attack with different projectile position
Boss_WolfGaropaDiveInit2:                              ; CODE XREF: Boss_WolfGaropaAttack4+1A   j  ; was: sub_4FE18
                tst.w   (word_FFFF0E).w
                bne.s   loc_4FE32
                jsr (Projectile_InitType424).l
                bne.s   loc_4FE32
                move.w  #$1A8,$10(a0)
                move.w  #$130,$14(a0)
loc_4FE32:                              ; CODE XREF: Boss_WolfGaropaDiveInit2+4   j
                                        ; Boss_WolfGaropaDiveInit2+C   j
                move.w  #$E,4(a5)
                bset    #2,$41C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$11C(a5)
                bset    #3,$9CE(a5)
; End of function Boss_WolfGaropaDiveInit2
; Wolf Garopa dive attack active state: check flag and shoot pattern
Boss_WolfGaropaDiveActive:                              ; DATA XREF: Boss_WolfGaropaMovement2+4E   o  ; was: sub_4FE50
                btst    #2,$41C(a5)
                beq.w   loc_4FB82
                bsr.w Boss_WolfGaropaShootPattern1
                bra.w   loc_4FB50
; End of function Boss_WolfGaropaDiveActive
; Shooting pattern 1
Boss_WolfGaropaShootPattern1:                              ; CODE XREF: Projectile_WolfGaropaBullet1:loc_4FB4C   p  ; was: sub_4FE62
                                        ; sub_4FB3A:loc_4FBE8   p ...
                move.w  $35C(a5),d0
                movea.w off_4FE72(pc,d0.w),a0
                adda.l  #Boss_WolfGaropaShootPattern2,a0
                jmp     (a0)
; End of function Boss_WolfGaropaShootPattern1
; ---------------------------------------------------------------------------
off_4FE72:      dc.w locret_4FA94-Boss_WolfGaropaShootPattern2
                                        ; DATA XREF: Boss_WolfGaropaShootPattern1+4   r
                dc.w Boss_WolfGaropaShootPattern3-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropaShootPattern4-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropaFalling-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropa_JumpState-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropaFalling2-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropaLaunch-Boss_WolfGaropaShootPattern2
                dc.w Boss_WolfGaropaRising-Boss_WolfGaropaShootPattern2


; Shooting pattern 2
Boss_WolfGaropaShootPattern2:                              ; CODE XREF: Boss_WolfGaropaInitState2+2C   p  ; was: sub_4FE82
                                        ; Boss_WolfGaropaJumpAttack+2A   p
                                        ; DATA XREF: ...
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                rts
; End of function Boss_WolfGaropaShootPattern2
; Shooting pattern 3
Boss_WolfGaropaShootPattern3:                              ; DATA XREF: ROM:0004FE74   o  ; was: sub_4FE94
                bclr    #0,$41C(a5)
                move.w  $47C(a5),d0
                sub.w   $10(a5),d0
                bpl.s   loc_4FED8
                cmpi.w  #$FFFC,d0
                bmi.s   loc_4FEB8
                bset    #0,$41C(a5)
                lea     word_507EA(pc),a1
                nop
                bra.s   loc_4FECE
; ---------------------------------------------------------------------------
loc_4FEB8:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+14   j
                lea     word_50814(pc),a1
                nop
                tst.l   $18(a5)
                bpl.s   loc_4FECE
                cmpi.l  #$FFFFA000,$18(a5)
                bmi.s   loc_4FF0A
loc_4FECE:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+22   j
                                        ; Boss_WolfGaropaShootPattern3+2E   j ...
                subi.l  #$1000,$18(a5)
                bra.s   loc_4FF0A
; ---------------------------------------------------------------------------
loc_4FED8:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+E   j
                cmpi.w  #4,d0
                bpl.s   loc_4FEEC
                bset    #0,$41C(a5)
                lea     word_507EA(pc),a1
                nop
                bra.s   loc_4FECE
; ---------------------------------------------------------------------------
loc_4FEEC:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+48   j
                lea     word_507EA(pc),a1
                nop
                tst.l   $18(a5)
                bmi.s   loc_4FF02
                cmpi.l  #$4000,$18(a5)
                bpl.s   loc_4FF0A
loc_4FF02:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+62   j
                addi.l  #$1000,$18(a5)
loc_4FF0A:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+38   j
                                        ; Boss_WolfGaropaShootPattern3+42   j ...
                move.l  a1,$2FC(a5)
                bsr.w Boss_WolfGaropaShootPattern6
                btst    #2,$23E(a5)
                beq.w   loc_4FF64
                move.w  a5,$4A(a5)
                btst    #1,$41C(a5)
                bne.s   loc_4FF40
                addq.w  #2,$35C(a5)
                addi.l  #$C000,$18(a5)
                move.l  #$FFFD0000,$1C(a5)
                bra.w Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF40:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+92   j
                move.w  #6,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                addi.l  #$10000,$18(a5)
                move.l  #$FFFFE800,$1C(a5)
                bra.w Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF64:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+84   j
                btst    #3,$23E(a5)
                beq.s   loc_4FF9A
loc_4FF6C:                              ; CODE XREF: Boss_WolfGaropaFalling+EE   j
                                        ; Boss_WolfGaropaLaunch+1C   j
                move.b  $23E(a5),d0
                andi.w  #3,d0
                asl.w   #1,d0
                movea.w word_4FFA8(pc,d0.w),a0
loc_4FF7A:                              ; CODE XREF: Boss_WolfGaropaShootPattern4+42   j
                                        ; Boss_WolfGaropaShootPattern4+50   j ...
                move.w  a0,$4A(a5)
                move.w  #$148,$14(a0)
                btst    #7,$23E(a5)
                beq.s   loc_4FF9A
                move.b  #$CF,d0
                jsr (Sound_PlaySFX).l
                bra.w Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_4FF9A:                              ; CODE XREF: Boss_WolfGaropaShootPattern3+D6   j
                                        ; Boss_WolfGaropaShootPattern3+F6   j ...
                movea.w $4A(a5),a0
                move.w  #$148,$14(a0)
                bra.w Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaShootPattern3
; ---------------------------------------------------------------------------
word_4FFA8:     dc.w $CF20, $CD40, $CB60, $C980
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3+E2   r


; Shooting pattern 4
Boss_WolfGaropaShootPattern4:                              ; DATA XREF: ROM:0004FE76   o  ; was: sub_4FFB0
                subi.l  #$800,$18(a5)
                addi.l  #$3800,$1C(a5)
                movea.l $2FC(a5),a1
                bsr.w Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w Boss_WolfGaropaShootPattern5
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                btst    #2,$41C(a5)
                bne.s   loc_4FFF6
                move.w  #2,$35C(a5)
                bra.w   loc_4FF7A
; ---------------------------------------------------------------------------
loc_4FFF6:                              ; CODE XREF: Boss_WolfGaropaShootPattern4+3A   j
                move.w  #$C,$35C(a5)
                clr.w   $11E(a5)
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaShootPattern4
; Wolf Garopa falling physics with gravity and horizontal tracking
Boss_WolfGaropaFalling:                              ; DATA XREF: ROM:0004FE78   o  ; was: sub_50004
                subi.l  #$400,$18(a5)
                addi.l  #$4000,$1C(a5)
                tst.w   $58(a5)
                bmi.s   loc_5003A
                bclr    #6,$23E(a5)
                beq.s   loc_5002C
                move.b  #$EE,d0
                jsr (Sound_PlaySFX).l
loc_5002C:                              ; CODE XREF: Boss_WolfGaropaFalling+1C   j
                lea     word_5083E(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                bra.w Boss_WolfGaropaShootPattern5
; ---------------------------------------------------------------------------
loc_5003A:                              ; CODE XREF: Boss_WolfGaropaFalling+14   j
                addq.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CD40,$4A(a5)
                move.w  #$148,$734(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
; Wolf Garopa jump attack state
Boss_WolfGaropa_JumpState:                              ; DATA XREF: ROM:0004FE7A   o  ; was: loc_50060
                move.w  $47C(a5),d0
                sub.w   $10(a5),d0
                bpl.s   loc_5008A
                cmpi.w  #$FFFC,d0
                bpl.s   loc_500A8
                tst.l   $18(a5)
                bpl.s   loc_50080
                cmpi.l  #$FFFF0000,$18(a5)
                bmi.s   loc_500A8
loc_50080:                              ; CODE XREF: Boss_WolfGaropaFalling+70   j
                subi.l  #$1400,$18(a5)
                bra.s   loc_500A8
; ---------------------------------------------------------------------------
loc_5008A:                              ; CODE XREF: Boss_WolfGaropaFalling+64   j
                cmpi.w  #4,d0
                bmi.s   loc_500A8
                tst.l   $18(a5)
                bmi.s   loc_500A0
                cmpi.l  #$E000,$18(a5)
                bpl.s   loc_500A8
loc_500A0:                              ; CODE XREF: Boss_WolfGaropaFalling+90   j
                addi.l  #$1400,$18(a5)
loc_500A8:                              ; CODE XREF: Boss_WolfGaropaFalling+6A   j
                                        ; Boss_WolfGaropaFalling+7A   j ...
                lea     word_50850(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                btst    #3,$23E(a5)
                beq.w   loc_500E8
                move.b  $23E(a5),d0
                andi.w  #3,d0
                move.l  #$4000,d1
                cmpi.w  #2,d0
                bpl.s   loc_500D6
                move.l  #$2000,d1
loc_500D6:                              ; CODE XREF: Boss_WolfGaropaFalling+CA   j
                add.l   d1,$18(a5)
                cmpi.w  #2,d0
                bne.s   loc_500E8
                btst    #1,$41C(a5)
                beq.s   loc_500F6
loc_500E8:                              ; CODE XREF: Boss_WolfGaropaFalling+B4   j
                                        ; Boss_WolfGaropaFalling+DA   j
                btst    #3,$23E(a5)
                beq.w   loc_4FF9A
                bra.w   loc_4FF6C
; ---------------------------------------------------------------------------
loc_500F6:                              ; CODE XREF: Boss_WolfGaropaFalling+E2   j
                addq.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                addi.l  #$10000,$18(a5)
                move.l  #$FFFA0000,$1C(a5)
                bra.w Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaFalling
; Wolf Garopa falling physics variant with different gravity values
Boss_WolfGaropaFalling2:                              ; DATA XREF: ROM:0004FE7C   o  ; was: sub_50120
                subi.l  #$800,$18(a5)
                addi.l  #$3800,$1C(a5)
                lea     word_5086A(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w Boss_WolfGaropaShootPattern5
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaFalling2
; Wolf Garopa launch upward with high velocity after ground hit
Boss_WolfGaropaLaunch:                              ; DATA XREF: ROM:0004FE7E   o  ; was: sub_50160
                lea     word_50874(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                btst    #6,$23E(a5)
                bne.s   loc_50180
                btst    #3,$23E(a5)
                beq.w   loc_4FF9A
                bra.w   loc_4FF6C
; ---------------------------------------------------------------------------
loc_50180:                              ; CODE XREF: Boss_WolfGaropaLaunch+10   j
                addq.w  #2,$35C(a5)
                move.w  a5,$4A(a5)
                move.l  #$14000,$18(a5)
                move.l  #$FFF80000,$1C(a5)
                move.b  #$2A,d0 ; '*'
                jsr (Sound_PlaySFX).l
                bra.w Boss_WolfGaropaShootPattern5
; End of function Boss_WolfGaropaLaunch
; Wolf Garopa rising state: call bomb check and manage linked object physics
Boss_WolfGaropaRising:                              ; DATA XREF: ROM:0004FE80   o  ; was: sub_501A6
                tst.w   $11E(a5)
                bne.s   loc_501BA
                bsr.w Boss_WolfGaropaBombCheck1
                tst.b   (byte_FF9DBA).w
                beq.s   loc_501BA
                addq.w  #1,$11E(a5)
loc_501BA:                              ; CODE XREF: Boss_WolfGaropaRising+4   j
                                        ; Boss_WolfGaropaRising+E   j
                movea.w $48(a5),a0
                subi.l  #$800,$18(a0)
                addi.l  #$6800,$1C(a5)
                lea     word_50874(pc),a1
                nop
                bsr.w Boss_WolfGaropaShootPattern6
                tst.w   $58(a5)
                bpl.w Boss_WolfGaropaShootPattern5
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                tst.w   (word_FF8200).w
                beq.s   loc_501F8
                subq.w  #1,$11C(a5)
                bpl.s   loc_501FE
loc_501F8:                              ; CODE XREF: Boss_WolfGaropaRising+4A   j
                bclr    #2,$41C(a5)
loc_501FE:                              ; CODE XREF: Boss_WolfGaropaRising+50   j
                move.w  #2,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #7,$23E(a5)
                movea.w #(byte_FFCF20-M68K_RAM),a0
                bra.w   loc_4FF7A
; End of function Boss_WolfGaropaRising
; Simple wrapper to call Boss_WolfGaropaShootPattern6
Boss_WolfGaropaShootOnly:
                bsr.w Boss_WolfGaropaShootPattern6  ; was: sub_5021C
; End of function Boss_WolfGaropaShootOnly
; Shooting pattern 5
Boss_WolfGaropaShootPattern5:                              ; CODE XREF: Boss_WolfGaropaInitMultiPattern+12   j  ; was: sub_50220
                                        ; Boss_WolfGaropaShootPattern3+A8   j ...
                moveq   #$18,d7
                jsr (Sprite_InitMetaspriteSimple).l
                bsr.w Boss_WolfGaropaCollision
                bsr.w Boss_WolfGaropaCleanup
                move.w  $10(a5),$35E(a5)
                move.w  $14(a5),$3BC(a5)
                move.w  #$130,d0
                sub.w   $35E(a5),d0
                move.w  $3BC(a5),d1
                addi.w  #$10,d1
                move.w  d0,(dword_FFA908).w
                add.w   (word_FFA016).w,d0
                move.w  d1,(dword_FFA90C).w
                move.w  (dword_FFA908).w,d0
                bmi.s   loc_5026C
                cmpi.w  #$108,d0
                bmi.s   loc_50272
loc_50264:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+50   j
                move.w  #$FEF6,(dword_FFA908).w
                bra.s   loc_50272
; ---------------------------------------------------------------------------
loc_5026C:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+3C   j
                cmpi.w  #$FEF6,d0
                bmi.s   loc_50264
loc_50272:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+42   j
                                        ; Boss_WolfGaropaShootPattern5+4A   j
                move.w  $35E(a5),d0
                addi.w  #-$A,d0
                move.w  d0,$970(a5)
                move.w  $3BC(a5),d0
                addi.w  #-$34,d0
                move.w  d0,$974(a5)
                move.w  $53E(a5),d2
                sub.w   $A16(a5),d2
                bmi.w   loc_502B0
                cmpi.w  #4,d2
                bmi.s   loc_502C8
                cmpi.w  #$100,d2
                bpl.w   loc_502BE
loc_502A4:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+9A   j
                addq.w  #2,$A16(a5)
                andi.w  #$1FE,$A16(a5)
                bra.s   loc_502C8
; ---------------------------------------------------------------------------
loc_502B0:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+72   j
                cmpi.w  #$FFFC,d2
                bpl.s   loc_502C8
                cmpi.w  #$FF00,d2
                bmi.w   loc_502A4
loc_502BE:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+80   j
                subq.w  #2,$A16(a5)
                andi.w  #$1FE,$A16(a5)
loc_502C8:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+7A   j
                                        ; Boss_WolfGaropaShootPattern5+8E   j ...
                move.w  $A16(a5),d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #3,d1
                asl.l   #4,d2
                swap    d1
                swap    d2
                move.w  $53C(a5),d0
                asr.w   #3,d0
                add.w   d0,d1
                add.w   $35E(a5),d2
                addi.w  #$12,d2
                move.w  d2,$9D0(a5)
                add.w   $3BC(a5),d1
                addi.w  #-$47,d1
                move.w  d1,$9D4(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  $3C(a0),d5
                ext.w   d5
                move.b  $40(a0),d6
                ext.w   d6
                move.w  $35E(a5),d2
                addi.w  #$38,d2 ; '8'
                add.w   d5,d2
                move.w  d2,$A90(a5)
                move.w  $3BC(a5),d3
                addi.w  #-$1C,d3
                add.w   d6,d3
                move.w  d3,$A94(a5)
                moveq   #0,d7
                move.b  $38(a0),d7
                cmpi.w  #$30,d7 ; '0'
                bmi.s   loc_5034E
                move.l  #word_ED352,d1
                addi.w  #$24,d2 ; '$'
                addi.w  #-6,d3
                bra.s   loc_5035C
; ---------------------------------------------------------------------------
loc_5034E:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+11C   j
                move.l  #word_ED33A,d1
                addi.w  #$1E,d2
                addi.w  #-$12,d3
loc_5035C:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+12C   j
                move.l  d1,$A88(a5)
                move.l  #word_ED310,d1
                cmpi.w  #$40,d7 ; '@'
                bpl.s   loc_50372
                move.l  #word_ED328,d1
loc_50372:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+14A   j
                move.l  d1,$AE8(a5)
                move.b  $44(a0),d6
                ext.w   d6
                move.w  d2,$AF0(a5)
                add.w   d6,d3
                move.w  d3,$AF4(a5)
                tst.w   (word_FF8200).w
                bne.s   loc_5038E
                bra.s   loc_503A4
; ---------------------------------------------------------------------------
loc_5038E:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+16A   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_503A4
                addi.w  #$20,(word_FFE37E).w ; ' '
                andi.w  #$EE,(word_FFE37E).w
loc_503A4:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+16C   j
                                        ; Boss_WolfGaropaShootPattern5+176   j
                bsr.w Boss_WolfGaropaSpawnProjectile3
                bra.w Projectile_WolfGaropaMain
; End of function Boss_WolfGaropaShootPattern5
; Graphics update handler
Boss_WolfGaropaGraphicsUpdate:                              ; CODE XREF: Projectile_WolfGaropaBullet1+B2   p  ; was: sub_503AC
                move.w  (word_FF8248).w,d0
                sub.w   $9D0(a5),d0
                move.w  d0,d1
                bpl.s   loc_503BA
                neg.w   d0
loc_503BA:                              ; CODE XREF: Boss_WolfGaropaGraphicsUpdate+A   j
                cmpi.w  #6,d0
                bmi.s   locret_503D0
                bset    #3,$9CE(a5)
                tst.w   d1
                bpl.s   locret_503D0
                bclr    #3,$9CE(a5)
locret_503D0:                           ; CODE XREF: Boss_WolfGaropaGraphicsUpdate+12   j
                                        ; Boss_WolfGaropaGraphicsUpdate+1C   j
                rts
; End of function Boss_WolfGaropaGraphicsUpdate
; Check if bomb spawning conditions met and load bomb graphics tiles
Boss_WolfGaropaBombCheck1:                              ; CODE XREF: Boss_WolfGaropaRising+6   p  ; was: sub_503D2
                tst.b   (byte_FF9DBA).w
                beq.s   loc_503DA
locret_503D8:                           ; CODE XREF: Boss_WolfGaropaBombCheck1+E   j
                rts
; ---------------------------------------------------------------------------
loc_503DA:                              ; CODE XREF: Boss_WolfGaropaBombCheck1+4   j
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_503D8
                move.b  #1,(byte_FF9DBA).w
                moveq   #0,d0
                move.w  #$E2,d1
                bsr.w Boss_ValkirieInitScreenPair
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
                lea     word_50414(pc),a0
                nop
                jsr (Gfx_DMATransferTiles).l
                lea     word_50420(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck1
; ---------------------------------------------------------------------------
word_50414:     dc.w $4658, $4000, $102, $2A2B, $2C2D, $2E2F
                                        ; DATA XREF: Boss_WolfGaropaBombCheck1+2A   o
word_50420:     dc.w $4C50, $4000, $401, $3031, $3233, $2634, $3536, $3738
                                        ; DATA XREF: Boss_WolfGaropaBombCheck1+36   o


; Trigger bomb spawn check by calling bomb initialization
Boss_WolfGaropaBombTrigger:                              ; CODE XREF: Boss_WolfGaropaDiveLoop+1C   p  ; was: sub_50430
                tst.b   (byte_FF9DBA).w
                beq.s Boss_WolfGaropaBombCheck2
locret_50436:                           ; CODE XREF: Boss_WolfGaropaBombCheck2+6   j
                rts
; End of function Boss_WolfGaropaBombTrigger
; Second bomb check variant: load different compressed tile set
Boss_WolfGaropaBombCheck2:                              ; CODE XREF: Boss_WolfGaropaBombTrigger+4   j  ; was: sub_50438
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_50436
                move.b  #1,(byte_FF9DBA).w
                moveq   #1,d0
                move.w  #$DE,d1
                bsr.w Boss_ValkirieInitScreenPair
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
                lea     word_50466(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck2
; ---------------------------------------------------------------------------
word_50466:     dc.w $4458, $4000, $101, $3C3B, $3D3F
                                        ; DATA XREF: Boss_WolfGaropaBombCheck2+22   o


; Third bomb check variant: load additional compressed tile set
Boss_WolfGaropaBombCheck3:
                tst.b   (byte_FF9DBA).w  ; was: sub_50470
                beq.s   loc_50478
locret_50476:                           ; CODE XREF: Boss_WolfGaropaBombCheck3+E   j
                rts
; ---------------------------------------------------------------------------
loc_50478:                              ; CODE XREF: Boss_WolfGaropaBombCheck3+4   j
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_50476
                move.b  #1,(byte_FF9DBA).w
                lea     word_50492(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck3
; ---------------------------------------------------------------------------
word_50492:     dc.w $4C50, $4000, $301, $4243, $4445, $4647, $4849
                                        ; DATA XREF: Boss_WolfGaropaBombCheck3+16   o


; Spawns projectile type 3
Boss_WolfGaropaSpawnProjectile3:                              ; CODE XREF: Boss_WolfGaropaShootPattern5:loc_503A4   p  ; was: sub_504A0
                subq.w  #4,$53C(a5)
                bpl.s   loc_504AA
                clr.w   $53C(a5)
loc_504AA:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+4   j
                move.w  $A76(a5),d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                moveq   #$20,d3 ; ' '
                moveq   #$36,d4 ; '6'
                sub.w   $53C(a5),d3
                sub.w   $53C(a5),d4
                muls.w  d3,d1
                muls.w  d4,d2
                swap    d1
                swap    d2
                cmpi.w  #$120,d0
                bmi.s   loc_504DC
                cmpi.w  #$1E0,d0
                bmi.s   loc_504DE
loc_504DC:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+34   j
                addq.w  #6,d1
loc_504DE:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+3A   j
                add.w   $974(a5),d1
                add.w   $970(a5),d2
                move.w  d1,$A34(a5)
                move.w  d2,$A30(a5)
                lea     off_50586(pc),a1
                nop
                movea.w #(byte_FFD040-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jsr (Sprite_UpdateBossBladeSprite).l
                movea.w #(byte_FFD160-M68K_RAM),a0
                jsr     (loc_2A128).l
                move.w  $6BC(a5),d0
                btst    #3,$65E(a5)
                beq.s   loc_5052A
                addi.w  #$C,d0
                cmpi.w  #$180,d0
                bmi.s   loc_5053A
                move.w  #$180,d0
                bra.s   loc_5053A
; ---------------------------------------------------------------------------
loc_5052A:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+78   j
                subq.w  #2,d0
                bpl.s   loc_5053A
                bclr    #7,$B42(a5)
                clr.w   $6BC(a5)
                rts
; ---------------------------------------------------------------------------
loc_5053A:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+82   j
                                        ; Boss_WolfGaropaSpawnProjectile3+88   j ...
                move.w  d0,$6BC(a5)
                bset    #7,$B42(a5)
                btst    #1,$65E(a5)
                beq.s   loc_5055A
                btst    #2,(word_FFA000+1).w
                beq.s   loc_5055A
                bclr    #7,$B42(a5)
loc_5055A:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+AA   j
                                        ; Boss_WolfGaropaSpawnProjectile3+B2   j
                move.w  $A76(a5),d3
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d3.w),d1
                move.w  (a0,d3.w),d2
                muls.w  d0,d1
                muls.w  d0,d2
                swap    d1
                swap    d2
                add.w   $A34(a5),d1
                add.w   $A30(a5),d2
                move.w  d1,$B54(a5)
                move.w  d2,$B50(a5)
                rts
; End of function Boss_WolfGaropaSpawnProjectile3
; ---------------------------------------------------------------------------
off_50586:      dc.l word_ED190         ; DATA XREF: Boss_WolfGaropaSpawnProjectile3+4E   o
                dc.l word_ED19C
                dc.l word_ED1AE
                dc.l word_ED1BA


; Projectile main handler
Projectile_WolfGaropaMain:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+188   j  ; was: sub_50596
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #$C,d0
                movea.l off_505AA(pc,d0.w),a0
                jmp Gfx_LoadCompressedTiles
; End of function Projectile_WolfGaropaMain
; ---------------------------------------------------------------------------
off_505AA:      dc.l byte_505BA         ; DATA XREF: Projectile_WolfGaropaMain+A   r
                dc.l byte_505C2
                dc.l byte_505CA
                dc.l byte_505C2
byte_505BA:     dc.b $64, $92, $20, 0, 1, 0, $C, $D
                                        ; DATA XREF: ROM:off_505AA   o
byte_505C2:     dc.b $64, $92, $20, 0, 1, 0, $E, $F
                                        ; DATA XREF: ROM:000505AE   o
                                        ; ROM:000505B6   o
byte_505CA:     dc.b $64, $92, $20, 0, 1, 0, $10, $11
                                        ; DATA XREF: ROM:000505B2   o


; Shooting pattern 6
Boss_WolfGaropaShootPattern6:                              ; CODE XREF: Boss_WolfGaropaInitMultiPattern+E   p  ; was: sub_505D2
                                        ; Boss_WolfGaropaShootPattern3+7A   p ...
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_5064A
loc_505DC:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+24   j
                                        ; Boss_WolfGaropaShootPattern6+44   j
                move.w  $58(a5),d0
                bmi.w   loc_5065A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_505F8
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_505DC
; ---------------------------------------------------------------------------
loc_505F8:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_50608
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_50608:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_50618
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_505DC
; ---------------------------------------------------------------------------
loc_50618:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_508A2,d0
                movea.l d0,a0
                bsr.w Boss_WolfGaropaSpawnProjectile1
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5065A
loc_5064A:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_5065A:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+E   j
                                        ; Boss_WolfGaropaShootPattern6+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #word_ED304,d5
                move.l  #word_ED30A,d6
                move.b  (a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $B2(a5),d0
                move.w  d0,$B4(a5)
                add.w   $112(a5),d1
                move.w  d1,$114(a5)
                move.b  4(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $172(a5),d0
                move.w  d0,$174(a5)
                add.w   $1D2(a5),d1
                move.w  d1,$1D4(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$2F6(a5)
                move.w  d1,$356(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                and.w   d7,d2
                move.l  d5,$368(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_506E4
                cmpi.w  #$100,d2
                bpl.s   loc_506E4
                move.l  d6,$368(a5)
loc_506E4:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+106   j
                                        ; Boss_WolfGaropaShootPattern6+10C   j
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                and.w   d7,d2
                move.l  d5,$548(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_5072C
                cmpi.w  #$100,d2
                bpl.s   loc_5072C
                move.l  d6,$548(a5)
loc_5072C:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+14E   j
                                        ; Boss_WolfGaropaShootPattern6+154   j
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                move.w  d0,$656(a5)
                move.b  $24(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$6B6(a5)
                move.w  d1,$716(a5)
                move.b  $28(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                addi.w  #$10,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                and.w   d7,d2
                move.l  d5,$728(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_50778
                cmpi.w  #$100,d2
                bpl.s   loc_50778
                move.l  d6,$728(a5)
loc_50778:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+19A   j
                                        ; Boss_WolfGaropaShootPattern6+1A0   j
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                addi.w  #$10,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                and.w   d7,d2
                move.l  d5,$908(a5)
                cmpi.w  #$10,d2
                bmi.s   locret_507C4
                cmpi.w  #$100,d2
                bpl.s   locret_507C4
                move.l  d6,$908(a5)
locret_507C4:                           ; CODE XREF: Boss_WolfGaropaShootPattern6+1E6   j
                                        ; Boss_WolfGaropaShootPattern6+1EC   j
                rts
; End of function Boss_WolfGaropaShootPattern6
; Spawns projectile type 1
Boss_WolfGaropaSpawnProjectile1:                              ; CODE XREF: Boss_WolfGaropaShootPattern6+5C   p  ; was: sub_507C6
                lea     word_508A2(pc),a1
                nop
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_WolfGaropaSpawnProjectile1
; Load Wolf Garopa animation frame delays with count $12
Anim_WolfGaropaLoadFrames:
                moveq   #$12,d7  ; was: sub_507DC
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Anim_WolfGaropaLoadFrames
; ---------------------------------------------------------------------------
                dc.b $FF, $FF
word_507EA:     dc.w $506, $36, $8089, $303, $48, $808A, $605, $5A, $808B, $205, $6C, $8004, $303, $6C, $80D, $12
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3+1C   o
                                        ; Boss_WolfGaropaShootPattern3+50   o ...
                dc.w $505, $12, $808, $24, $FFFE
word_50814:     dc.w $90A, $36, $8089, $404, $48, $808A, $807, $5A, $808B, $306, $6C, $8004, $303, $6C, $80D, $12
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3:loc_4FEB8   o
                dc.w $505, $12, $808, $24, $FFFE
word_5083E:     dc.w $810, $B4, $606, $B4, $8040, $606, $B4, $8089, $FFFE
                                        ; DATA XREF: Boss_WolfGaropaFalling:loc_5002C   o
word_50850:     dc.w $C0C, $7E, $808B, $A0A, $90, $8088, $C0C, $A2, $808A, $A0A, $B4, $8089, $FFFF
                                        ; DATA XREF: Boss_WolfGaropaFalling:loc_500A8   o
word_5086A:     dc.w $408, $24, $808, $24, $FFFE
                                        ; DATA XREF: Boss_WolfGaropaFalling2+10   o
word_50874:     dc.w $506, $36, $8089, $203, $48, $808A, $405, $5A, $808B, $104, $FC, $8044, $304, $FC, $A12, $C6
                                        ; DATA XREF: Boss_WolfGaropaInitMultiPattern+8   o
                                        ; sub_50160   o ...
                dc.w $A0A, $C6, $606, $D8, $606, $EA, $FFFE
word_508A2:	binclude	"data/other/word_508A2.bin"
word_508A2_End:


; Bullet projectile 2
Projectile_WolfGaropaBullet2:                              ; CODE XREF: Projectile_WolfGaropaBullet1+BE   p  ; was: sub_509B0
                movea.w #(byte_FFD040-M68K_RAM),a5
                jsr (Math_CalculateAngleToPlayer).l
                movea.w #(word_FFC620-M68K_RAM),a5
                moveq   #0,d3
                moveq   #4,d7
                cmpi.w  #$14,$4DE(a5)
                beq.s Boss_WolfGaropaSpawnProjectile4
                tst.w   $4DE(a5)
                bmi.s Boss_WolfGaropaSpawnProjectile4
                moveq   #2,d7
; End of function Projectile_WolfGaropaBullet2
; Spawns projectile type 4
Boss_WolfGaropaSpawnProjectile4:                              ; CODE XREF: Projectile_WolfGaropaBullet1+44   j  ; was: sub_509D2
                                        ; Projectile_WolfGaropaBullet1+16C   p ...
                sub.w   $A76(a5),d2
                bmi.w   loc_509F6
                cmpi.w  #$C,d2
                bmi.w   loc_50A10
                cmpi.w  #$100,d2
                bpl.w   loc_50A04
loc_509EA:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+2E   j
                add.w   d7,$A76(a5)
                andi.w  #$1FE,$A76(a5)
                rts
; ---------------------------------------------------------------------------
loc_509F6:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+4   j
                cmpi.w  #$FFF4,d2
                bpl.s   loc_50A10
                cmpi.w  #$FF00,d2
                bmi.w   loc_509EA
loc_50A04:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+14   j
                sub.w   d7,$A76(a5)
                andi.w  #$1FE,$A76(a5)
                rts
; ---------------------------------------------------------------------------
loc_50A10:                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+C   j
                                        ; Boss_WolfGaropaSpawnProjectile4+28   j
                addq.w  #1,d3
                rts
; End of function Boss_WolfGaropaSpawnProjectile4
; Homing projectile
Projectile_WolfGaropaHoming:                              ; CODE XREF: Projectile_WolfGaropaBullet1+132   j  ; was: sub_50A14
                move.w  #1,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_50AEE
                movea.l #dword_2ADC8,a1
                jsr (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8040,2(a0)
                movea.w a0,a3
                move.w  #$1C,$53C(a5)
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_50AEE
                move.b  #$36,d0 ; '6'
                jsr (Sound_PlaySFX).l
                move.w  #$408,(a0)
                move.w  #$CC00,2(a0)
                move.b  #$42,$21(a0) ; 'B'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #4,$26(a0)
                move.b  #8,$20(a0)
                move.w  $A76(a5),d0
                move.w  d0,d2
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                muls.w  #$80,d3
                muls.w  #$80,d4
                move.l  d3,d5
                move.l  d4,d6
                swap    d5
                swap    d6
                add.w   $A34(a5),d5
                add.w   $A30(a5),d6
                move.w  d5,$14(a0)
                move.w  d6,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d5
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d6
                move.w  d5,$14(a3)
                move.w  d6,$10(a3)
                asr.l   #2,d3
                asr.l   #2,d4
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.w  #$8480,$E(a0)
                jmp Projectile_WolfGaropaLaser
; ---------------------------------------------------------------------------
locret_50AEE:                           ; CODE XREF: Projectile_WolfGaropaHoming+12   j
                                        ; Projectile_WolfGaropaHoming+3C   j
                rts
; End of function Projectile_WolfGaropaHoming
; Wave projectile
Projectile_WolfGaropaWave:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_50AF0
                tst.w   (word_FF808C).w
                bpl.s   loc_50B06
                btst    #7,$22(a5)
                beq.s   loc_50B3A
                btst    #4,$22(a5)
                beq.s   loc_50B24
loc_50B06:                              ; CODE XREF: Projectile_WolfGaropaWave+4   j
                btst    #0,(dword_FFFF08+1).w
                bne.s   loc_50B44
                jsr (Sprite_SetPointerClearD7).l
                ori.w   #$A00,2(a5)
                move.l  #$FFFA8000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_50B24:                              ; CODE XREF: Projectile_WolfGaropaWave+14   j
                neg.l   $18(a5)
loc_50B28:                              ; CODE XREF: Projectile_WolfGaropaWave+8C   j
                neg.l   $1C(a5)
                move.l  #off_E95A4,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_50B3A:                              ; CODE XREF: Projectile_WolfGaropaWave+C   j
                move.w  $10(a5),d0
                cmpi.w  #$78,d0 ; 'x'
                bpl.s   loc_50B4C
loc_50B44:                              ; CODE XREF: Projectile_WolfGaropaWave+1C   j
                                        ; Projectile_WolfGaropaWave+60   j ...
                bset    #4,2(a5)
locret_50B4A:                           ; CODE XREF: Projectile_WolfGaropaWave+70   j
                rts
; ---------------------------------------------------------------------------
loc_50B4C:                              ; CODE XREF: Projectile_WolfGaropaWave+52   j
                cmpi.w  #$288,d0
                bpl.s   loc_50B44
                cmpi.w  #$98,$14(a5)
                bmi.s   loc_50B44
                cmpi.w  #$150,$14(a5)
                bmi.s   locret_50B4A
                move.b  #$37,d0 ; '7'
                jsr (Sound_PlaySFX).l
                move.l  $18(a5),d0
                asr.l   #2,d0
                subi.l  #$28000,d0
                move.l  d0,$18(a5)
                bra.s   loc_50B28
; End of function Projectile_WolfGaropaWave
; Defeat sequence init
Boss_WolfGaropaDefeatInit:                              ; CODE XREF: Projectile_WolfGaropaBullet1+EC   j  ; was: sub_50B7E
                                        ; Projectile_WolfGaropaBullet1+118   j
                btst    #0,(word_FFA000+1).w
                bne.w   locret_50BEA
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_50BEA
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8C40,2(a0)
                bsr.w Boss_WolfGaropaDefeatAnim
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.l  d1,d5
                move.l  d2,d6
                asl.l   #6,d1
                asl.l   #6,d2
                swap    d1
                swap    d2
                add.w   d1,d3
                add.w   d2,d4
                move.w  d3,$14(a0)
                move.w  d4,$10(a0)
                neg.l   d5
                neg.l   d6
                asl.l   #2,d5
                asl.l   #2,d6
                move.l  d5,$1C(a0)
                move.l  d6,$18(a0)
locret_50BEA:                           ; CODE XREF: Boss_WolfGaropaDefeatInit+6   j
                                        ; Boss_WolfGaropaDefeatInit+10   j
                rts
; End of function Boss_WolfGaropaDefeatInit
; Boss collision handler
Boss_WolfGaropaCollision:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+8   p  ; was: sub_50BEC
                tst.w   $5FC(a5)
                bmi.w   locret_50C5A
                subq.w  #1,$5FC(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_50C5A
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_50C5A
                lea     (dword_2AD4A).l,a1
                jsr (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8C00,2(a0)
                bsr.w Boss_WolfGaropaDefeatAnim
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d3
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d4
                move.w  d3,$14(a0)
                move.w  d4,$10(a0)
                asl.l   #2,d5
                asl.l   #2,d6
                move.l  d5,$1C(a0)
                subi.l  #$30000,d6
                move.l  d6,$18(a0)
locret_50C5A:                           ; CODE XREF: Boss_WolfGaropaCollision+4   j
                                        ; Boss_WolfGaropaCollision+12   j ...
                rts
; End of function Boss_WolfGaropaCollision
; Defeat animation
Boss_WolfGaropaDefeatAnim:                              ; CODE XREF: Boss_WolfGaropaDefeatInit+2C   p  ; was: sub_50C5C
                                        ; Boss_WolfGaropaCollision+38   p
                lea     (word_1B514).l,a2
                move.w  $A76(a5),d0
                move.w  -$80(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                ext.l   d3
                ext.l   d4
                move.l  d3,d5
                move.l  d4,d6
                asl.l   #7,d3
                asl.l   #7,d4
                swap    d3
                swap    d4
                add.w   $A34(a5),d3
                add.w   $A30(a5),d4
                rts
; End of function Boss_WolfGaropaDefeatAnim
; Spawn Wolf Garopa bomb projectile with explosion effect type 188
Projectile_SpawnWolfGaropaBomb:                              ; CODE XREF: Boss_WolfGaropaAttack1+1E   p  ; was: sub_50C88
                                        ; DATA XREF: Boss_WolfGaropaAttack1+1E   o
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_50CD2
                move.l  #off_E962C,8(a0)
                jsr (Effect_SpawnExplosionType188).l
                move.b  #4,$20(a0)
                move.w  #$EC00,2(a0)
                move.w  #$FFFE,$18(a0)
                move.w  #$FFFE,$1C(a0)
                move.w  #$10,$48(a0)
                move.w  $A30(a5),d0
                move.w  $A34(a5),d1
                subq.w  #8,d0
                addq.w  #8,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_50CD2:                           ; CODE XREF: Projectile_SpawnWolfGaropaBomb+6   j
                rts
; End of function Projectile_SpawnWolfGaropaBomb
; Initializes pair of screen objects for Valkirie boss with different parameters based on direction flag
Boss_ValkirieInitScreenPair:                              ; CODE XREF: Boss_WolfGaropaBombCheck1+1C   p  ; was: sub_50CD4
                                        ; Boss_WolfGaropaBombCheck2+14   p
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$418,(a0)
                clr.w   2(a0)
                move.w  d0,$48(a0)
                clr.w   $4C(a0)
                move.w  d1,$14(a0)
                move.b  #$80,$21(a0)
                move.b  #$90,$23(a0)
                move.w  #4,$24(a0)
                move.w  #$115,$26(a0)
                move.l  #$7EF030,d1
                move.l  #$7EF030,d2
                move.w  #$120,d3
                tst.w   d0
                beq.s   loc_50D28
                move.l  #$8200F030,d1
                move.l  #$8200F030,d2
                move.w  #$B0,d3
loc_50D28:                              ; CODE XREF: Boss_ValkirieInitScreenPair+42   j
                move.l  d1,$28(a0)
                move.l  d2,$2C(a0)
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  d3,$14(a0)
                jsr     (loc_2BD00).l
                move.w  #$420,(a0)
                move.w  #$E000,2(a0)
                move.w  #$28,$1C(a0) ; '('
                rts
; End of function Boss_ValkirieInitScreenPair
; Forces player to ceiling during Valkirie encounter by adjusting vertical position and checking proximity to boss position
Boss_ValkirieForcePlayerToCeiling:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_50D50
                tst.b   (byte_FF9DBA).w
                beq.s   loc_50D7E
                btst    #4,$22(a5)
                beq.s   loc_50D86
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.w  #6,(word_FFA010).w
                cmpi.w  #$1F0,(dword_FFA900).w
                bpl.w   loc_50D7E
                jsr (Gfx_LoadWolfGaropaTiles).l
loc_50D7E:                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+4   j
                                        ; Boss_ValkirieForcePlayerToCeiling+24   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50D86:                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+C   j
                move.w  #$1F0,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  (dword_FFA414).w,d0
                move.w  (dword_FFA410).w,d1
                tst.w   $48(a5)
                bne.s   loc_50DB4
                addi.w  #$18,d0
                cmp.w   $14(a5),d0
                bmi.s   loc_50DC8
                cmp.w   $10(a5),d1
                bpl.w   loc_50DD6
                rts
; ---------------------------------------------------------------------------
loc_50DB4:                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+4E   j
                subi.w  #$18,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_50DC8
                cmp.w   $10(a5),d1
                bpl.w   loc_50DD6
                rts
; ---------------------------------------------------------------------------
loc_50DC8:                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+58   j
                                        ; Boss_ValkirieForcePlayerToCeiling+6C   j
                cmp.w   $10(a5),d1
                bmi.s   locret_50DD4
                move.w  #1,$4C(a5)
locret_50DD4:                           ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+7C   j
                                        ; Boss_ValkirieForcePlayerToCeiling+8A   j ...
                rts
; ---------------------------------------------------------------------------
loc_50DD6:                              ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+5E   j
                                        ; Boss_ValkirieForcePlayerToCeiling+72   j
                tst.w   $4C(a5)
                bne.s   locret_50DD4
                move.w  $10(a5),d0
                subq.w  #2,d0
                move.w  d0,(dword_FFA410).w
                clr.l   (dword_FFA418).w
                move.b  #1,(byte_FF8311).w
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   locret_50DD4
                bset    #6,$21(a5)
                tst.w   (word_FFDB20).w
                beq.s   locret_50E0A
                bset    #4,(word_FFDB22).w
locret_50E0A:                           ; CODE XREF: Boss_ValkirieForcePlayerToCeiling+B2   j
                rts
; End of function Boss_ValkirieForcePlayerToCeiling
; Manages timer-based screen positioning during Valkirie boss battle with vertical position updates
Boss_ValkirieScreenTimer:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_50E0C
                subq.w  #1,$1C(a5)
                bpl.s   loc_50E1A
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50E1A:                              ; CODE XREF: Boss_ValkirieScreenTimer+4   j
                tst.w   (word_FFDC40).w
                beq.s   loc_50E2E
                move.w  (word_FFDC50).w,d0
                addi.w  #$30,d0 ; '0'
                move.w  d0,$10(a5)
                bra.s   loc_50E36
; ---------------------------------------------------------------------------
loc_50E2E:                              ; CODE XREF: Boss_ValkirieScreenTimer+12   j
                subi.l  #$A8000,$10(a5)
loc_50E36:                              ; CODE XREF: Boss_ValkirieScreenTimer+20   j
                jmp Boss_StateDispatcher
; End of function Boss_ValkirieScreenTimer
; Updates boss sprites
Boss_WolfGaropaUpdateSprites:                              ; CODE XREF: Boss_WolfGaropaMovement2+22   j  ; was: sub_50E3C
                move.w  #$40,6(a5) ; '@'
                clr.w   $26(a5)
                bset    #0,(byte_FFA272).w
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                jmp Sprite_ClearObjectFlags
; End of function Boss_WolfGaropaUpdateSprites
; Boss damage handler
Boss_WolfGaropaDamage:                              ; CODE XREF: Boss_WolfGaropaMovement2:loc_4F916   p  ; was: sub_50E5E
                tst.w   (word_FF8200).w
                beq.s   loc_50E66
                rts
; ---------------------------------------------------------------------------
loc_50E66:                              ; CODE XREF: Boss_WolfGaropaDamage+4   j
                subq.w  #1,6(a5)
                bpl.s   loc_50E98
                move.w  #$10,4(a5)
                clr.w   8(a5)
                move.w  #$60,$11C(a5) ; '`'
                move.w  #$FEB0,(dword_FFA908).w
                move.w  #$3E8,d0
                move.w  #$41C,d1
                jsr (Sprite_ClearAllExcept).l
                moveq   #$1C,d0
                jmp (Gfx_SetFadeParams).l
; ---------------------------------------------------------------------------
loc_50E98:                              ; CODE XREF: Boss_WolfGaropaDamage+C   j
                cmpi.w  #$20,6(a5) ; ' '
                bpl.s   loc_50EBA
                addq.w  #1,$26(a5)
                move.w  $26(a5),d0
                cmpi.w  #$1C,d0
                bmi.s   loc_50EB0
                moveq   #$1C,d0
loc_50EB0:                              ; CODE XREF: Boss_WolfGaropaDamage+4E   j
                jsr (Gfx_SetFadeParams).l
                bra.w   loc_50EC0
; ---------------------------------------------------------------------------
loc_50EBA:                              ; CODE XREF: Boss_WolfGaropaDamage+40   j
                jsr (Gfx_UpdatePaletteFade).l
loc_50EC0:                              ; CODE XREF: Boss_WolfGaropaDamage+58   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_50ED4
                move.b  #$BB,d0
                jsr (Sound_PlaySFX).l
loc_50ED4:                              ; CODE XREF: Boss_WolfGaropaDamage+6A   j
                btst    #0,(word_FFA000+1).w
                bne.s   locret_50F3C
                jsr (Projectile_UpdateTrajectory).l
                bne.s   locret_50F3C
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0 ; '?'
                subi.w  #$20,d0 ; ' '
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E96FC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_50F26
                move.l  #off_E953C,8(a0)
loc_50F26:                              ; CODE XREF: Boss_WolfGaropaDamage+BE   j
                jsr (Projectile_InitType88).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                subi.w  #8,d0
                move.w  d0,$18(a0)
locret_50F3C:                           ; CODE XREF: Boss_WolfGaropaDamage+7C   j
                                        ; Boss_WolfGaropaDamage+84   j
                rts
; End of function Boss_WolfGaropaDamage
; Animation script interpreter
Boss_WolfGaropaAnimationScript:                              ; DATA XREF: Boss_WolfGaropaMovement2+50   o  ; was: sub_50F3E
                addq.w  #2,4(a5)
                move.w  #$A0,$11C(a5)
                move.b  #4,(byte_FFA95A).w
                jmp Effect_InitPlayerSpawn
; End of function Boss_WolfGaropaAnimationScript
; Animation frame update
Boss_WolfGaropaAnimationUpdate:                              ; DATA XREF: Boss_WolfGaropaMovement2+52   o  ; was: sub_50F54
                cmpi.w  #$80,$11C(a5)
                bne.s   loc_50F62
                move.b  #1,(byte_FF830E).w
loc_50F62:                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+6   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_50F70
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_50F70:                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+12   j
                subq.w  #2,$26(a5)
                move.w  $26(a5),d0
                bpl.s   loc_50F7C
                moveq   #0,d0
loc_50F7C:                              ; CODE XREF: Boss_WolfGaropaAnimationUpdate+24   j
                jmp (Gfx_SetFadeParams).l
; End of function Boss_WolfGaropaAnimationUpdate
; Cleanup after defeat
Boss_WolfGaropaCleanup:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+C   p  ; was: sub_50F82
                move.w  $5FE(a5),d0
                bne.s   loc_50F8A
                rts
; ---------------------------------------------------------------------------
loc_50F8A:                              ; CODE XREF: Boss_WolfGaropaCleanup+4   j
                bpl.s   loc_50F90
                addq.w  #1,d0
                bra.s   loc_50F92
; ---------------------------------------------------------------------------
loc_50F90:                              ; CODE XREF: Boss_WolfGaropaCleanup:loc_50F8A   j
                subq.w  #1,d0
loc_50F92:                              ; CODE XREF: Boss_WolfGaropaCleanup+C   j
                move.w  d0,$5FE(a5)
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$D,d5
                move.w  $65C(a5),d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_WolfGaropaCleanup
; State handler for Valkirie boss with palette fade initialization on state transitions
Boss_ValkirieStateHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_50FA6
                tst.w   4(a5)
                beq.w   loc_50FBA
                tst.w   8(a5)
                beq.s   loc_50FBA
                jsr (Gfx_InitPaletteFade).l
loc_50FBA:                              ; CODE XREF: Boss_ValkirieStateHandler+4   j
                                        ; Boss_ValkirieStateHandler+C   j
                move.w  4(a5),d0
                movea.w off_50FCA(pc,d0.w),a0
                adda.l  #nullsub_119,a0
                jmp     (a0)
; End of function Boss_ValkirieStateHandler
; ---------------------------------------------------------------------------
off_50FCA:      dc.w Boss_ValkirieInit-nullsub_119
                                        ; DATA XREF: Boss_ValkirieStateHandler+18   r
                dc.w Boss_ValkirieForce_StateInit-nullsub_119


nullsub_119:                            ; CODE XREF: Boss_ValkirieInit+4   j
                                        ; Boss_ValkirieFlipLeft+4   j ...
                rts
; End of function nullsub_119


; Initializes Valkirie boss entity with metasprites, animation data, positions, and multiple sprite components
Boss_ValkirieInit:                              ; DATA XREF: ROM:off_50FCA   o  ; was: sub_50FD0
                tst.w   (word_FFF720).w
                bmi.w   nullsub_119
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #off_3541C,a0
                movea.l #word_35470,a1
                movea.l #word_35486,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$3EC,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #0,$176(a5)
                move.w  #$100,$356(a5)
                move.w  #$10,d0
                move.w  #$4300,d1
                move.w  #$C000,d2
                move.w  d0,$7E0(a5)
                move.w  d2,$7E2(a5)
                move.w  d1,$7EE(a5)
                move.b  #$20,$800(a5) ; ' '
                move.l  #word_EC7C2,$7E8(a5)
                move.w  d0,$840(a5)
                move.w  d2,$842(a5)
                move.w  d1,$84E(a5)
                move.b  #$1C,$860(a5)
                move.l  #word_EC7CE,$848(a5)
                move.w  d0,$8A0(a5)
                move.w  d2,$8A2(a5)
                move.w  d1,$8AE(a5)
                move.b  #$28,$8C0(a5) ; '('
                move.l  #word_EC7C2,$8A8(a5)
                move.w  d0,$900(a5)
                move.w  d2,$902(a5)
                move.w  d1,$90E(a5)
                move.b  #$24,$920(a5) ; '$'
                move.l  #word_EC7CE,$908(a5)
                move.w  #$C300,d1
                move.w  d0,$960(a5)
                move.w  d2,$962(a5)
                move.w  d1,$96E(a5)
                move.b  #$18,$980(a5)
                move.l  #word_EC6F0,$968(a5)
                move.w  d0,$9C0(a5)
                move.w  d2,$9C2(a5)
                move.w  d1,$9CE(a5)
                move.b  #$18,$9E0(a5)
                move.l  #word_EC792,$9C8(a5)
                movea.l #word_1BE6C,a1
                jsr (Sprite_InitFromPointerTable).l
                bsr.w Boss_ValkirieDMALeftTiles
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_510DA:                              ; CODE XREF: Boss_ValkirieInit+106   j
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CD40,$48(a5)
                move.w  #$120,$730(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$148,$914(a5)
; Valkirie Force boss initialization
Boss_ValkirieForce_StateInit:                              ; DATA XREF: ROM:00050FCC   o  ; was: loc_51116
                tst.w   (word_FF80C2).w
                bne.s   loc_51122
                move.b  #1,(byte_FFA958).w
loc_51122:                              ; CODE XREF: Boss_ValkirieInit+14A   j
                btst    #6,(word_FFF706).w
                beq.s   loc_5112E
                bsr.w Boss_ValkirieFlipLeft
loc_5112E:                              ; CODE XREF: Boss_ValkirieInit+158   j
                btst    #5,(word_FFF706).w
                beq.s   loc_5113A
                bsr.w Boss_ValkirieFlipRight
loc_5113A:                              ; CODE XREF: Boss_ValkirieInit+164   j
                btst    #2,(word_FFF706).w
                beq.s   loc_51146
                addq.b  #1,$29F(a5)
loc_51146:                              ; CODE XREF: Boss_ValkirieInit+170   j
                btst    #3,(word_FFF706).w
                beq.s   loc_51152
                subq.b  #1,$29F(a5)
loc_51152:                              ; CODE XREF: Boss_ValkirieInit+17C   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51546(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_51162:                              ; CODE XREF: Boss_ValkirieInit+18E   j
                bsr.w Boss_ValkirieAnimationController
                moveq   #$14,d7
                jsr (Sprite_InitMetaspritePointers).l
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$FFF3,d7
                tst.w   $54(a5)
                beq.s   loc_5117E
                neg.w   d7
loc_5117E:                              ; CODE XREF: Boss_ValkirieInit+1AA   j
                move.w  d7,d0
                add.w   $640(a5),d0
                move.w  d0,$820(a5)
                move.w  d0,$880(a5)
                move.l  #word_EC7C2,$7E8(a5)
                move.b  $38(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   loc_511A8
                move.l  #word_EC7C8,$7E8(a5)
loc_511A8:                              ; CODE XREF: Boss_ValkirieInit+1CE   j
                add.w   $644(a5),d0
                addi.w  #$28,d0 ; '('
                move.w  d0,$824(a5)
                move.w  d0,$884(a5)
                move.w  d7,d0
                add.w   $7C0(a5),d0
                move.w  d0,$8E0(a5)
                move.w  d0,$940(a5)
                move.l  #word_EC7C2,$8A8(a5)
                move.b  $3C(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   loc_511E2
                move.l  #word_EC7C8,$8A8(a5)
loc_511E2:                              ; CODE XREF: Boss_ValkirieInit+208   j
                add.w   $7C4(a5),d0
                addi.w  #$28,d0 ; '('
                move.w  d0,$8E4(a5)
                move.w  d0,$944(a5)
                moveq   #$18,d7
                jsr (Sprite_UpdateLinkedPositions).l
                bclr    #4,$54E(a5)
                bclr    #4,$6CE(a5)
                moveq   #6,d5
                tst.w   $54(a5)
                beq.s   loc_51210
                neg.w   d5
loc_51210:                              ; CODE XREF: Boss_ValkirieInit+23C   j
                add.w   $D0(a5),d5
                move.w  $D4(a5),d6
                addi.w  #-8,d6
                move.b  $29F(a5),d3
                cmpi.b  #$70,d3 ; 'p'
                bmi.s   loc_5123E
                addi.w  #2,d5
                addi.w  #-6,d6
                move.w  d5,$970(a5)
                move.w  d6,$974(a5)
                bsr.w Boss_ValkirieUpdateGunSprite
                bra.w   loc_5129E
; ---------------------------------------------------------------------------
loc_5123E:                              ; CODE XREF: Boss_ValkirieInit+254   j
                lea     (word_1B514).l,a0
                move.l  #word_EC792,$9C8(a5)
                bset    #3,$9CE(a5)
                move.w  #$1A0,d7
                tst.w   $54(a5)
                beq.s   loc_51266
                bclr    #3,$9CE(a5)
                move.w  #$160,d7
loc_51266:                              ; CODE XREF: Boss_ValkirieInit+28A   j
                move.w  -$80(a0,d7.w),d1
                move.w  (a0,d7.w),d2
                ext.w   d3
                muls.w  d3,d1
                muls.w  d3,d2
                move.l  d1,$9D4(a5)
                move.l  d2,$9D0(a5)
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d1,$974(a5)
                move.l  d2,$970(a5)
                add.w   d5,$970(a5)
                add.w   d6,$974(a5)
                addq.w  #4,d5
                addi.w  #-$C,d6
                add.w   d5,$9D0(a5)
                add.w   d6,$9D4(a5)
loc_5129E:                              ; CODE XREF: Boss_ValkirieInit+26A   j
                move.w  #$A7,d0
                tst.w   $54(a5)
                beq.s   loc_512AC
                move.w  #$97,d0
loc_512AC:                              ; CODE XREF: Boss_ValkirieInit+2D6   j
                sub.w   $70(a5),d0
                move.w  $74(a5),d1
                addi.w  #$3C,d1 ; '<'
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Boss_CheckScreenBounds).l
                rts
; End of function Boss_ValkirieInit
; Flips Valkirie boss to face left by clearing horizontal flip bits on all sprite components and loading left-facing tiles
Boss_ValkirieFlipLeft:                              ; CODE XREF: Boss_ValkirieInit+15A   p  ; was: sub_512C8
                tst.w   $54(a5)
                beq.w   nullsub_119
                clr.w   $54(a5)
                moveq   #3,d0
                bclr    d0,$E(a5)
                bclr    d0,$CE(a5)
                bclr    d0,$60E(a5)
                bclr    d0,$78E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$72E(a5)
                bclr    d0,$7EE(a5)
                bclr    d0,$84E(a5)
                bclr    d0,$8AE(a5)
                bclr    d0,$90E(a5)
                bclr    d0,$96E(a5)
                bra.w Boss_ValkirieDMALeftTiles
; End of function Boss_ValkirieFlipLeft
; Flips Valkirie boss to face right by setting horizontal flip bits on all sprite components and loading right-facing tiles
Boss_ValkirieFlipRight:                              ; CODE XREF: Boss_ValkirieInit+166   p  ; was: sub_51306
                tst.w   $54(a5)
                bne.w   nullsub_119
                move.w  #$100,$54(a5)
                moveq   #3,d0
                bset    d0,$E(a5)
                bset    d0,$CE(a5)
                bset    d0,$60E(a5)
                bset    d0,$78E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$72E(a5)
                bset    d0,$7EE(a5)
                bset    d0,$84E(a5)
                bset    d0,$8AE(a5)
                bset    d0,$90E(a5)
                bset    d0,$96E(a5)
                lea     word_5135A(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Boss_ValkirieFlipRight
; Performs DMA transfer to load left-facing tile graphics for Valkirie boss
Boss_ValkirieDMALeftTiles:                              ; CODE XREF: Boss_ValkirieInit+102   p  ; was: sub_5134E
                                        ; Boss_ValkirieFlipLeft+3A   j
                lea     word_51366(pc),a0
                nop
                jmp Gfx_DMATransferTiles
; End of function Boss_ValkirieDMALeftTiles
; ---------------------------------------------------------------------------
word_5135A:     dc.w $6100, $2000, $102, $2829, $2A2B, $2C2D
                                        ; DATA XREF: Boss_ValkirieFlipRight+3C   o
word_51366:     dc.w $6100, $2000, $102, $8A89, $8C8B, $8E8D
                                        ; DATA XREF: Boss_ValkirieDMALeftTiles   o


; Updates gun sprite animation frame and position for Valkirie boss based on aiming angle
Boss_ValkirieUpdateGunSprite:                              ; CODE XREF: Boss_ValkirieInit+266   p  ; was: sub_51372
                move.w  $2B0(a5),$9D0(a5)
                move.w  $2B4(a5),$9D4(a5)
                move.w  $2AE(a5),$9CE(a5)
                move.w  $2F6(a5),d0
                addi.w  #$10,d0
                asr.w   #3,d0
                andi.w  #$1C,d0
                move.l  off_5139A(pc,d0.w),$9C8(a5)
                rts
; End of function Boss_ValkirieUpdateGunSprite
; ---------------------------------------------------------------------------
off_5139A:      dc.l word_EC7E6         ; DATA XREF: Boss_ValkirieUpdateGunSprite+20   r
                dc.l word_EC7EC
                dc.l word_EC7F2
                dc.l word_EC7FE
                dc.l word_EC80A
                dc.l word_EC810
                dc.l word_EC816
                dc.l word_EC822


; Main animation controller that processes animation frames, interpolation, and updates sprite tile indices for all Valkirie body parts
Boss_ValkirieAnimationController:                              ; CODE XREF: Boss_ValkirieInit:loc_51162   p  ; was: sub_513BA
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_51432
loc_513C4:                              ; CODE XREF: Boss_ValkirieAnimationController+24   j
                                        ; Boss_ValkirieAnimationController+44   j
                move.w  $58(a5),d0
                bmi.w   loc_51442
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_513E0
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_513C4
; ---------------------------------------------------------------------------
loc_513E0:                              ; CODE XREF: Boss_ValkirieAnimationController+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_513F0
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_513F0:                              ; CODE XREF: Boss_ValkirieAnimationController+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_51400
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_513C4
; ---------------------------------------------------------------------------
loc_51400:                              ; CODE XREF: Boss_ValkirieAnimationController+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #byte_5156E,d0
                movea.l d0,a0
                bsr.w Boss_ValkirieSetupInterpolation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_51442
loc_51432:                              ; CODE XREF: Boss_ValkirieAnimationController+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$10,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_51442:                              ; CODE XREF: Boss_ValkirieAnimationController+E   j
                                        ; Boss_ValkirieAnimationController+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  8(a0),d0
                ext.w   d0
                addq.w  #6,d0
                move.w  d0,$B4(a5)
                move.b  $C(a0),d0
                ext.w   d0
                addi.w  #8,d0
                move.w  d0,$114(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  d0,$236(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$296(a5)
                move.w  d1,$2F6(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.w  d0,$416(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$476(a5)
                move.w  d1,$4D6(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.w  d0,$656(a5)
                move.b  $28(a0),d0
                ext.w   d0
                move.w  d0,$654(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.w  d0,$776(a5)
                move.w  d0,$7D6(a5)
                move.b  $34(a0),d0
                ext.w   d0
                move.w  d0,$7D4(a5)
                rts
; End of function Boss_ValkirieAnimationController
; Sets up animation interpolation parameters for smooth transitions between Valkirie animation frames
Boss_ValkirieSetupInterpolation:                              ; CODE XREF: Boss_ValkirieAnimationController+5C   p  ; was: sub_51514
                lea     byte_51536(pc),a1
                nop
                moveq   #$10,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolation
; Loads frame timing delays for Valkirie boss animation sequences
Boss_ValkirieLoadFrameTiming:
                moveq   #$10,d7  ; was: sub_5152A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameTiming
; ---------------------------------------------------------------------------
byte_51536:     dc.b $40, $C0, $80, $80, $A0, $80, $A0, $80, $80, $A0, $80, 0, $A0, $80, $80, $80
                                        ; DATA XREF: Boss_ValkirieSetupInterpolation   o
byte_51546:     dc.b $10, $18, 0, 0, $10, $10, 0, 0, $10, $18, 0, $10, $20, $20, 0, $10
                                        ; DATA XREF: Boss_ValkirieInit+188   o
                dc.b $FF, $FF, 8, $C, 0, $20, $12, $12, 0, $20, 2, 4, 0, $30, 9, 9
                dc.b 0, $30, $10, $30, 0, $20, $FF, $FE
byte_5156E:     dc.b $BC, $4A, $11, $F, $2C, $98, $78, $A8, $E8, $36, 3, $90, $54, 4, 2, 3
                                        ; DATA XREF: Boss_ValkirieAnimationController+54   o
                dc.b $CA, $41, $E, $12, $30, $96, $78, $AC, $D8, $1A, $FC, $A0, $3A, $FC, $A, 0
                dc.b $C0, $46, $10, $12, 8, $F8, $50, $18, $E0, $50, 4, $A0, $20, 4, 0, 4
                dc.b $B8, $3C, $11, $F, $F8, $C8, $48, 8, $C0, $40, $FC, $A0, $14, 4, 0, 6


; State handler for Valkirie miniboss variant with palette fade support
Boss_ValkirieMinibossHandler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_515AE
                tst.w   4(a5)
                beq.w   loc_515C2
                tst.w   8(a5)
                beq.s   loc_515C2
                jsr (Gfx_InitPaletteFade).l
loc_515C2:                              ; CODE XREF: Boss_ValkirieMinibossHandler+4   j
                                        ; Boss_ValkirieMinibossHandler+C   j
                move.w  4(a5),d0
                movea.w off_515D2(pc,d0.w),a0
                adda.l  #Boss_ValkirieMinibossInit,a0
                jmp     (a0)
; End of function Boss_ValkirieMinibossHandler
; ---------------------------------------------------------------------------
off_515D2:      dc.w Boss_ValkirieMinibossInit-Boss_ValkirieMinibossInit
                                        ; DATA XREF: Boss_ValkirieMinibossHandler+18   r
                dc.w Boss_ValkirieForce_State20-Boss_ValkirieMinibossInit


; Initializes simplified Valkirie miniboss entity with basic parameters and position
Boss_ValkirieMinibossInit:                              ; DATA XREF: Boss_ValkirieMinibossHandler+1C   o  ; was: sub_515D6
                                        ; ROM:off_515D2   o ...
                move.w  #1,8(a5)
                move.w  #$3F0,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Valkirie Force attack phase
Boss_ValkirieForce_State20:                              ; DATA XREF: ROM:000515D4   o  ; was: loc_51616
                tst.w   (word_FF80C2).w
                bne.s   locret_51622
                move.b  #1,(byte_FFA958).w
locret_51622:                           ; CODE XREF: Boss_ValkirieMinibossInit+44   j
                rts
; End of function Boss_ValkirieMinibossInit
; Processes debug input for rotating Valkirie miniboss and updates metasprite display
Boss_ValkirieMinibossInput:
                btst    #2,(word_FFF706).w  ; was: sub_51624
                beq.s   loc_51630
                addq.w  #2,$56(a5)
loc_51630:                              ; CODE XREF: Boss_ValkirieMinibossInput+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_5163C
                subq.w  #2,$56(a5)
loc_5163C:                              ; CODE XREF: Boss_ValkirieMinibossInput+12   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51814(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_5164C:                              ; CODE XREF: Boss_ValkirieMinibossInput+24   j
                bsr.w Boss_ValkirieMinibossAnimController
                moveq   #$19,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieMinibossInput
; Animation controller for Valkirie miniboss that processes frames and updates all sprite component tile indices
Boss_ValkirieMinibossAnimController:                              ; CODE XREF: Boss_ValkirieMinibossInput:loc_5164C   p  ; was: sub_51658
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_516D0
loc_51662:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+24   j
                                        ; Boss_ValkirieMinibossAnimController+44   j
                move.w  $58(a5),d0
                bmi.w   loc_516E0
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_5167E
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_51662
; ---------------------------------------------------------------------------
loc_5167E:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_5168E
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_5168E:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_5169E
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_51662
; ---------------------------------------------------------------------------
loc_5169E:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_5181E,d0
                movea.l d0,a0
                bsr.w Boss_ValkirieMinibossSetupInterp
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_516E0
loc_516D0:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_516E0:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+E   j
                                        ; Boss_ValkirieMinibossAnimController+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Boss_ValkirieMinibossAnimController
; Sets up animation interpolation for Valkirie miniboss smooth frame transitions
Boss_ValkirieMinibossSetupInterp:                              ; CODE XREF: Boss_ValkirieMinibossAnimController+5C   p  ; was: sub_517F2
                lea     word_5181E(pc),a1
                nop
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieMinibossSetupInterp
; Loads frame timing delays for Valkirie miniboss animations
Boss_ValkirieMinibossLoadTiming:
                moveq   #$12,d7  ; was: sub_51808
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ValkirieMinibossLoadTiming
; ---------------------------------------------------------------------------
byte_51814:     dc.b $20, $20, 0, 0, $20, $20, 0, $12, $FF, $FF
                                        ; DATA XREF: Boss_ValkirieMinibossInput+1E   o
word_5181E:     dc.w $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000
                                        ; DATA XREF: Boss_ValkirieMinibossAnimController+54   o
                                        ; sub_517F2   o
                dc.w $4000, $C094, $C010, $EC40, $F060, $F020, $2020, $10E0, $E000


; State handler for third Valkirie boss part/component with palette fade initialization
Boss_ValkiriePart3Handler:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_51842
                tst.w   4(a5)
                beq.w   loc_51856
                tst.w   8(a5)
                beq.s   loc_51856
                jsr (Gfx_InitPaletteFade).l
loc_51856:                              ; CODE XREF: Boss_ValkiriePart3Handler+4   j
                                        ; Boss_ValkiriePart3Handler+C   j
                move.w  4(a5),d0
                movea.w off_51866(pc,d0.w),a0
                adda.l  #Boss_ValkiriePart3Init,a0
                jmp     (a0)
; End of function Boss_ValkiriePart3Handler
; ---------------------------------------------------------------------------
off_51866:      dc.w Boss_ValkiriePart3Init-Boss_ValkiriePart3Init
                                        ; DATA XREF: Boss_ValkiriePart3Handler+18   r
                dc.w Boss_ValkirieForce_State34-Boss_ValkiriePart3Init


; Initializes third Valkirie boss component with basic entity parameters and screen position
Boss_ValkiriePart3Init:                              ; DATA XREF: Boss_ValkiriePart3Handler+1C   o  ; was: sub_5186A
                                        ; ROM:off_51866   o ...
                move.w  #1,8(a5)
                move.w  #$3F4,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Valkirie Force advanced pattern
Boss_ValkirieForce_State34:                              ; DATA XREF: ROM:00051868   o  ; was: loc_518AA
                tst.w   (word_FF80C2).w
                bne.s   locret_518B6
                move.b  #1,(byte_FFA958).w
locret_518B6:                           ; CODE XREF: Boss_ValkiriePart3Init+44   j
                rts
; End of function Boss_ValkiriePart3Init
; Debug mode handler for Valkirie boss - allows manual angle control using controller inputs (buttons 2/3)
Boss_ValkirieDebugAngleControl:
                btst    #2,(word_FFF706).w  ; was: sub_518B8
                beq.s   loc_518C4
                addq.w  #2,$56(a5)
loc_518C4:                              ; CODE XREF: Boss_ValkirieDebugAngleControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_518D0
                subq.w  #2,$56(a5)
loc_518D0:                              ; CODE XREF: Boss_ValkirieDebugAngleControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     byte_51AA8(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_518E0:                              ; CODE XREF: Boss_ValkirieDebugAngleControl+24   j
                bsr.w Boss_ValkirieAnimationSequencer
                moveq   #$19,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieDebugAngleControl
; Processes animation sequence data from table, handles frame interpolation, and updates multiple sprite angles ($B6-$9B6 offsets)
Boss_ValkirieAnimationSequencer:                              ; CODE XREF: Boss_ValkirieDebugAngleControl:loc_518E0   p  ; was: sub_518EC
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_51964
loc_518F6:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+24   j
                                        ; Boss_ValkirieAnimationSequencer+44   j
                move.w  $58(a5),d0
                bmi.w   loc_51974
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_51912
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_518F6
; ---------------------------------------------------------------------------
loc_51912:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_51922
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_51922:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_51932
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_518F6
; ---------------------------------------------------------------------------
loc_51932:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #byte_51AB2,d0
                movea.l d0,a0
                bsr.w Boss_ValkirieAnimationCalc
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_51974
loc_51964:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_51974:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+E   j
                                        ; Boss_ValkirieAnimationSequencer+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                rts
; End of function Boss_ValkirieAnimationSequencer
; Calculates animation interpolation deltas for 18 animation channels using frame data
Boss_ValkirieAnimationCalc:                              ; CODE XREF: Boss_ValkirieAnimationSequencer+5C   p  ; was: sub_51A86
                lea     (off_354B0).l,a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieAnimationCalc
; Loads animation frame delay data into RAM buffer for 18 animation channels
Boss_ValkirieAnimationLoadDelays:
                moveq   #$12,d7  ; was: sub_51A9C
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ValkirieAnimationLoadDelays
; ---------------------------------------------------------------------------
byte_51AA8:     dc.b $20, $20, 0, 0, $20, $20, 0, $12, $FF, $FF
                                        ; DATA XREF: Boss_ValkirieDebugAngleControl+1E   o
byte_51AB2:     dc.b $40, 0, $C0, $94, $C0, $10, $EC, $40, $F0, $60, $F0, $20, $20, $20, $10, $E0
                                        ; DATA XREF: Boss_ValkirieAnimationSequencer+54   o
                dc.b $E0, 0, $40, 0, $C0, $94, $C0, $10, $EC, $40, $F0, $60, $F0, $20, $20, $20
                dc.b $10, $E0, $E0, 0


; Main boss handler
Boss_ZLeoMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_51AD6
                tst.w   4(a5)
                beq.w   loc_51B6A
                tst.w   8(a5)
                beq.w   loc_51B6A
                btst    #2,(byte_FF80EC).w
                bne.s   loc_51AFE
                btst    #1,(byte_FF80EC).w
                bne.s   loc_51AFE
                tst.w   (word_FF8200).w
                beq.w Boss_ZLeoAttackPattern2
loc_51AFE:                              ; CODE XREF: Boss_ZLeoMain+16   j
                                        ; Boss_ZLeoMain+1E   j
                move.w  $4DC(a5),d0
                beq.s   loc_51B20
                bpl.s   loc_51B0A
                addq.w  #1,d0
                bra.s   loc_51B0C
; ---------------------------------------------------------------------------
loc_51B0A:                              ; CODE XREF: Boss_ZLeoMain+2E   j
                subq.w  #1,d0
loc_51B0C:                              ; CODE XREF: Boss_ZLeoMain+32   j
                move.w  d0,$4DC(a5)
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $4DE(a5),d7
                jsr (Gfx_ApplyPaletteFade).l
loc_51B20:                              ; CODE XREF: Boss_ZLeoMain+2C   j
                move.w  $53C(a5),d0
                beq.s   loc_51B42
                bpl.s   loc_51B2C
                addq.w  #1,d0
                bra.s   loc_51B2E
; ---------------------------------------------------------------------------
loc_51B2C:                              ; CODE XREF: Boss_ZLeoMain+50   j
                subq.w  #1,d0
loc_51B2E:                              ; CODE XREF: Boss_ZLeoMain+54   j
                move.w  d0,$53C(a5)
                movea.w #(byte_FFE322-M68K_RAM),a0
                moveq   #$1E,d5
                move.w  $53E(a5),d7
                jsr (Gfx_ApplyPaletteFade).l
loc_51B42:                              ; CODE XREF: Boss_ZLeoMain+4E   j
                move.w  $59C(a5),d0
                beq.s   loc_51B64
                bpl.s   loc_51B4E
                addq.w  #1,d0
                bra.s   loc_51B50
; ---------------------------------------------------------------------------
loc_51B4E:                              ; CODE XREF: Boss_ZLeoMain+72   j
                subq.w  #1,d0
loc_51B50:                              ; CODE XREF: Boss_ZLeoMain+76   j
                move.w  d0,$59C(a5)
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $59E(a5),d7
                jsr (Gfx_ApplyPaletteFade).l
loc_51B64:                              ; CODE XREF: Boss_ZLeoMain+70   j
                jsr (Gfx_InitPaletteFade).l
loc_51B6A:                              ; CODE XREF: Boss_ZLeoMain+4   j
                                        ; Boss_ZLeoMain+C   j
                bsr.s Boss_ZLeoDispatcher
                clr.w   (word_FF9500).w
                rts
; End of function Boss_ZLeoMain
; Boss state dispatcher
Boss_ZLeoDispatcher:                              ; CODE XREF: Boss_ZLeoMain:loc_51B6A   p  ; was: sub_51B72
                move.w  4(a5),d0
                movea.w off_51B82(pc,d0.w),a0
                adda.l  #nullsub_120,a0
                jmp     (a0)
; End of function Boss_ZLeoDispatcher
; ---------------------------------------------------------------------------
off_51B82:      dc.w Boss_ZLeoInit-nullsub_120
                                        ; DATA XREF: Boss_ZLeoDispatcher+4   r
                dc.w Boss_ZLeoIntroInit-nullsub_120
                dc.w Boss_ZLeoAttack_State8-nullsub_120
                dc.w Boss_ZLeoAttack_State10-nullsub_120
                dc.w Boss_ZLeoAttack_State12-nullsub_120
                dc.w Boss_ZLeoDefeatedFadeout-nullsub_120
                dc.w Boss_ZLeoDefeatedDelay-nullsub_120
                dc.w Boss_ZLeoEmptyState-nullsub_120
                dc.w Boss_ZLeoIntroMove-nullsub_120
                dc.w Boss_ZLeoBattleStart-nullsub_120
                dc.w Boss_ZLeoAttack_State14-nullsub_120
                dc.w Boss_ZLeoBattleState1-nullsub_120
                dc.w Boss_ZLeoBattleState2-nullsub_120
                dc.w Boss_ZLeoAttack_State20-nullsub_120
                dc.w Boss_ZLeoDefeatCheck-nullsub_120
                dc.w Boss_ZLeo_AttackPattern1_WaitLoop-nullsub_120
                dc.w Boss_ZLeoAttackState1-nullsub_120
                dc.w Boss_ZLeoAttack_State28-nullsub_120
                dc.w Boss_ZLeoAttack_State30-nullsub_120
                dc.w Boss_ZLeoAttack_State32-nullsub_120
                dc.w Boss_ZLeoAttackSequence-nullsub_120
                dc.w Boss_ZLeoAttack_State38-nullsub_120
                dc.w Boss_ZLeoAttack_State40-nullsub_120
                dc.w Boss_ZLeoAttack_State42-nullsub_120
                dc.w Boss_ZLeoAttack_State44-nullsub_120
                dc.w Boss_ZLeoAttack_State46-nullsub_120
                dc.w Boss_ZLeoAttack_State48-nullsub_120
                dc.w Boss_ZLeoAttack_State50-nullsub_120
                dc.w Boss_ZLeoAttack_State36-nullsub_120


nullsub_120:                            ; CODE XREF: Boss_ZLeoIntroInit+E   j
                                        ; Boss_ZLeoTileUpdate+16   j ...
                rts
; End of function nullsub_120


; Boss initialization
Boss_ZLeoInit:                              ; DATA XREF: ROM:off_51B82   o  ; was: sub_51BBE
                tst.w   (word_FF80C2).w
                bne.w   locret_51C30
                addq.w  #2,4(a5)
                bset    #0,(byte_FF8245).w
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                move.w  #$54,(word_FFF74A).w ; 'T'
                clr.w   (word_FFF74E).w
                move.w  #$18,(word_FF8090).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                movea.l #$FFFF4520,a0
                move.w  #$A000,d0
                moveq   #5,d7
                jsr (Gfx_AdjustTileIndices).l
                bsr.w Boss_ZLeoGraphicsInit1
                bsr.w Boss_ZLeoGraphicsInit2
                bsr.w Boss_ZLeoGraphicsInit3
                move.l  #dword_11316,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #$F600,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
locret_51C30:                           ; CODE XREF: Boss_ZLeoInit+4   j
                rts
; End of function Boss_ZLeoInit
; Intro sequence init
Boss_ZLeoIntroInit:                              ; DATA XREF: ROM:00051B84   o  ; was: sub_51C32
                bsr.w Boss_ZLeoGraphicsInit2
                jsr (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   nullsub_120
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$380,(dword_FF8040).w
                moveq   #$F,d7
                movea.l #dword_355A4,a0
                movea.l #word_355E4,a1
                movea.l #word_355F4,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$3F8,(a5)
                move.w  #$C00,2(a5)
                movea.l #$FFFF2020,a0
                move.w  #$6000,d0
                move.w  #$280,d1
                moveq   #$1F,d7
                jsr (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF2080,a0
                move.w  #$E000,d0
                moveq   #3,d7
                jsr (Gfx_AdjustTileIndices).l
                move.w  #$7FFF,d0
                lea     (byte_FF2080).l,a0
                and.w   d0,(a0)
                and.w   d0,2(a0)
                and.w   d0,8(a0)
                and.w   d0,$A(a0)
                and.w   d0,$10(a0)
                and.w   d0,$12(a0)
                and.w   d0,$18(a0)
                and.w   d0,$1A(a0)
                lea     (word_FF20E0).l,a0
                and.w   d0,word_FF20E4-word_FF20E0(a0)
                and.w   d0,6(a0)
                and.w   d0,$C(a0)
                and.w   d0,$E(a0)
                and.w   d0,$14(a0)
                and.w   d0,$16(a0)
                and.w   d0,$1C(a0)
                and.w   d0,$1E(a0)
                clr.w   (word_FF9600).w
                clr.w   (dword_FFA900).w
                move.w  #$100,(dword_FFA904).w
                move.w  #$100,(word_FF9602).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                move.w  #$10,d0
                move.w  #$C000,d1
                move.w  #$4B80,d2
                movea.w #(word_FFCDA0-M68K_RAM),a0
                moveq   #2,d7
loc_51D1E:                              ; CODE XREF: Boss_ZLeoIntroInit+110   j
                moveq   #$10,d3
                moveq   #2,d6
loc_51D22:                              ; CODE XREF: Boss_ZLeoIntroInit+10C   j
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                subq.w  #4,d3
                move.l  #word_ED3B8,8(a0)
                lea     $60(a0),a0
                dbf     d6,loc_51D22
                dbf     d7,loc_51D1E
                move.l  #word_ED3BE,d4
                move.l  d4,$848(a5)
                move.l  d4,$968(a5)
                move.l  d4,$A88(a5)
                movea.w #(byte_FFD100-M68K_RAM),a0
                moveq   #$50,d3 ; 'P'
                moveq   #5,d7
loc_51D60:                              ; CODE XREF: Boss_ZLeoIntroInit+140   j
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                lea     $60(a0),a0
                dbf     d7,loc_51D60
                move.l  #word_ED478,$AE8(a5)
                move.l  #word_ED39A,$B48(a5)
                move.l  #word_ED394,$BA8(a5)
                move.l  #word_ED478,$C08(a5)
                move.l  #word_ED39A,$C68(a5)
                move.l  #word_ED394,$CC8(a5)
                bclr    #3,$AEE(a5)
                bclr    #3,$B4E(a5)
                bclr    #3,$BAE(a5)
                move.b  #$4C,$B60(a5) ; 'L'
                move.b  #$4C,$C80(a5) ; 'L'
                movea.l #word_1BEB4,a1
                jsr (Sprite_InitFromPointerTable).l
                clr.l   $2FC(a5)
                clr.l   $35C(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_51E82
; End of function Boss_ZLeoIntroInit
; Initializes Z-Leo boss intro sequence - sets position ($120,$1A0), clears state, animates Y position down to $E8
Boss_ZLeoIntroSetup:
                move.w  #$120,$2FC(a5)  ; was: sub_51DE2
                move.w  #$1A0,$35C(a5)
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Z-Leo boss movement state
Boss_ZLeoAttack_State8:                              ; DATA XREF: ROM:00051B86   o  ; was: loc_51E0E
                subq.w  #1,$35C(a5)
                cmpi.w  #$E8,$35C(a5)
                bpl.s   loc_51E24
                move.w  #$E8,$35C(a5)
                clr.b   (byte_FF80EC).w
loc_51E24:                              ; CODE XREF: Boss_ZLeoIntroSetup+36   j
                move.w  $5B4(a5),d0
                addi.w  #0,d0
                move.w  d0,(dword_FFDB34).w
                lea     word_52C56(pc),a1
                nop
                bra.w   loc_5262E
; End of function Boss_ZLeoIntroSetup
; Debug controller handler for Z-Leo - allows manual position and angle adjustments via controller buttons
Boss_ZLeoDebugControl:
                btst    #2,(word_FFF706).w  ; was: sub_51E3A
                beq.s   loc_51E46
                subq.w  #3,$10(a5)
loc_51E46:                              ; CODE XREF: Boss_ZLeoDebugControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_51E52
                addq.w  #3,$10(a5)
loc_51E52:                              ; CODE XREF: Boss_ZLeoDebugControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_51E5E
                subq.w  #2,$14(a5)
loc_51E5E:                              ; CODE XREF: Boss_ZLeoDebugControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_51E6A
                addq.w  #2,$14(a5)
loc_51E6A:                              ; CODE XREF: Boss_ZLeoDebugControl+2A   j
                btst    #6,(word_FFF706).w
                beq.s   loc_51E76
                addq.w  #2,(dword_FFDB34).w
loc_51E76:                              ; CODE XREF: Boss_ZLeoDebugControl+36   j
                btst    #4,(word_FFF706).w
                beq.s   loc_51E82
                subq.w  #2,(dword_FFDB34).w
loc_51E82:                              ; CODE XREF: Boss_ZLeoIntroInit+1AC   j
                                        ; Boss_ZLeoDebugControl+42   j
                move.w  #$10,4(a5)
                move.w  #$1C0,$11C(a5)
                move.w  #$120,$2FC(a5)
                move.w  #$1E0,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.b  #$95,d0
                jsr (Sys_WaitVBlank).l
; End of function Boss_ZLeoDebugControl
; Intro movement sequence
Boss_ZLeoIntroMove:                              ; DATA XREF: ROM:00051B92   o  ; was: sub_51EB6
                cmpi.w  #$1B8,$11C(a5)
                bne.s   loc_51EC8
                move.b  #$F7,d0
                jsr (Sound_PlaySFX).l
loc_51EC8:                              ; CODE XREF: Boss_ZLeoIntroMove+6   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_51EDE
                move.w  #2,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51EDE:                              ; CODE XREF: Boss_ZLeoIntroMove+16   j
                addq.w  #2,4(a5)
                move.w  #$E000,$59E(a5)
                move.w  #$FFF6,$11C(a5)
                clr.w   $11E(a5)
                lea     stru_51F50(pc),a0
                nop
                jsr (Data_ProcessPointer).l
; End of function Boss_ZLeoIntroMove
; Battle start handler
Boss_ZLeoBattleStart:                              ; DATA XREF: ROM:00051B94   o  ; was: sub_51EFE
                subi.l  #$8000,$35C(a5)
                cmpi.w  #$F0,$35C(a5)
                bmi.s   loc_51F5A
                tst.w   $11E(a5)
                bne.s   loc_51F20
                cmpi.w  #$144,$35C(a5)
                bpl.s   loc_51F34
                addq.w  #1,$11E(a5)
loc_51F20:                              ; CODE XREF: Boss_ZLeoBattleStart+14   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_51F34
                addq.w  #1,$11C(a5)
                bmi.s   loc_51F34
                clr.w   $11C(a5)
loc_51F34:                              ; CODE XREF: Boss_ZLeoBattleStart+1C   j
                                        ; Boss_ZLeoBattleStart+2A   j ...
                move.w  $11C(a5),$59C(a5)
                move.w  #3,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
stru_51F50:     dc.w 6                  ; field_0
                                        ; DATA XREF: Boss_ZLeoIntroMove+3C   o
                dc.l byte_1C8CB4        ; field_2
                dc.w $4020              ; field_6
                dc.w $FFFF
; ---------------------------------------------------------------------------
loc_51F5A:                              ; CODE XREF: Boss_ZLeoBattleStart+E   j
                addq.w  #2,4(a5)
                move.w  #$F0,$35C(a5)
                move.w  #$20,$11C(a5) ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
; Z-Leo boss attack pattern
Boss_ZLeoAttack_State14:                              ; DATA XREF: ROM:00051B96   o  ; was: loc_51F76
                subq.w  #1,$11C(a5)
                bmi.s   loc_51F86
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51F86:                              ; CODE XREF: Boss_ZLeoBattleStart+7C   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5) ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                bsr.w Boss_ZLeoAnimationUpdate1
; End of function Boss_ZLeoBattleStart
; Battle state 1 handler
Boss_ZLeoBattleState1:                              ; DATA XREF: ROM:00051B98   o  ; was: sub_51FAA
                tst.w   $58(a5)
                bmi.s   loc_51FC6
                bclr    #0,$23E(a5)
                beq.s   loc_51FBC
                bsr.w Boss_ZLeoEnableParts
loc_51FBC:                              ; CODE XREF: Boss_ZLeoBattleState1+C   j
                lea     word_52C8C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51FC6:                              ; CODE XREF: Boss_ZLeoBattleState1+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$60,$11C(a5) ; '`'
                bsr.w Boss_ZLeoLoadDefeatTiles
                move.b  #$EC,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ZLeoBattleState1
; Battle state 2 handler
Boss_ZLeoBattleState2:                              ; DATA XREF: ROM:00051B9A   o  ; was: sub_51FE8
                subq.w  #1,$11C(a5)
                bmi.s   loc_51FF8
                lea     word_52C9C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_51FF8:                              ; CODE XREF: Boss_ZLeoBattleState2+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5) ; '@'
; Z-Leo boss combo phase
Boss_ZLeoAttack_State20:                              ; DATA XREF: ROM:00051B9C   o  ; was: loc_5200C
                subq.w  #1,$11C(a5)
                bmi.s   loc_5201C
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5201C:                              ; CODE XREF: Boss_ZLeoBattleState2+28   j
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr (UI_CheckVictoryCondition).l
; End of function Boss_ZLeoBattleState2
; Check defeat condition
Boss_ZLeoDefeatCheck:                              ; DATA XREF: ROM:00051B9E   o  ; was: sub_52028
                tst.w   (word_FF80C2).w
                bne.s   loc_5203C
                move.w  #$1E,4(a5)
                clr.b   (byte_FF80EC).w
                bra.w Boss_ZLeo_AttackPattern1_WaitLoop
; ---------------------------------------------------------------------------
loc_5203C:                              ; CODE XREF: Boss_ZLeoDefeatCheck+4   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoDefeatCheck
; Attack pattern 2 handler
Boss_ZLeoAttackPattern2:                              ; CODE XREF: Boss_ZLeoMain+24   j  ; was: sub_52046
                move.w  #6,4(a5)
                move.b  #$40,(byte_FFF705).w ; '@'
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                clr.b   $21(a5)
                move.w  #$34,(word_FFA02A).w ; '4'
                bset    #2,(word_FFDB22).w
                move.l  #$FFFF0000,(dword_FFDB3C).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C0,$11C(a5)
                bsr.w Boss_ZLeoAnimationUpdate1
                move.b  #1,(byte_FF830E).w
; Z-Leo boss transition state
Boss_ZLeoAttack_State10:                              ; DATA XREF: ROM:00051B88   o  ; was: loc_52096
                subq.w  #1,$11C(a5)
                bmi.s   loc_520C0
                move.w  #4,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr (Gfx_UpdatePaletteFade).l
                bsr.w Boss_ZLeoAnimationUpdate2
                bsr.w Boss_ZLeoAnimationUpdate3
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_520C0:                              ; CODE XREF: Boss_ZLeoAttackPattern2+54   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
; Z-Leo boss special move
Boss_ZLeoAttack_State12:                              ; DATA XREF: ROM:00051B8A   o  ; was: loc_520C8
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_520DE
                addq.w  #1,$11C(a5)
                cmpi.w  #8,$11C(a5)
                beq.s   loc_520F0
loc_520DE:                              ; CODE XREF: Boss_ZLeoAttackPattern2+8A   j
                bsr.w Boss_ZLeoFadeoutPalette
                bsr.w Boss_ZLeoAnimationUpdate2
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_520F0:                              ; CODE XREF: Boss_ZLeoAttackPattern2+96   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  #$354,(a0)
                clr.w   4(a0)
                move.w  #$120,$10(a0)
                move.w  #$F0,$14(a0)
                movea.l #$FFFF2080,a0
                move.w  #$6000,d0
                moveq   #3,d7
                jsr (Gfx_AdjustTileIndices).l
                lea     word_52154(pc),a0
                nop
                jsr (Gfx_LoadCompressedTiles).l
                move.b  #$14,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackPattern2
; Z-Leo defeat sequence - increments timer to $11, triggers sprite clearing and palette fade to white ($EEE)
Boss_ZLeoDefeatedFadeout:                              ; DATA XREF: ROM:00051B8C   o  ; was: sub_52138
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_5214E
                addq.w  #1,$11C(a5)
                cmpi.w  #$11,$11C(a5)
                beq.s   loc_5215E
loc_5214E:                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+8   j
                bsr.w Boss_ZLeoFadeoutPalette
                rts
; ---------------------------------------------------------------------------
word_52154:     dc.w $4618, $2000, $300, $405, $607
                                        ; DATA XREF: Boss_ZLeoAttackPattern2+DC   o
; ---------------------------------------------------------------------------
loc_5215E:                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+14   j
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$120,$48(a5)
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr (Sprite_ClearAllExcept).l
                movea.w #(word_FFE380-M68K_RAM),a0
                move.w  #$EEE,d0
                moveq   #$3F,d7 ; '?'
loc_52182:                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+50   j
                move.w  d0,-$80(a0)
                move.w  d0,(a0)+
                dbf     d7,loc_52182
; End of function Boss_ZLeoDefeatedFadeout
; Delay state after Z-Leo defeat - waits for timer, then initializes battle UI and weapon display
Boss_ZLeoDefeatedDelay:                              ; DATA XREF: ROM:00051B8E   o  ; was: sub_5218C
                subq.w  #1,$48(a5)
                bmi.s   loc_52194
                rts
; ---------------------------------------------------------------------------
loc_52194:                              ; CODE XREF: Boss_ZLeoDefeatedDelay+4   j
                addq.w  #2,4(a5)
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                move.w  #2,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
                jmp UI_StoreWeaponToBuffer
; End of function Boss_ZLeoDefeatedDelay
; Empty Z-Leo boss state handler
Boss_ZLeoEmptyState:                            ; DATA XREF: ROM:00051B90   o  ; was: nullsub_121
                rts
; End of function Boss_ZLeoEmptyState
; Attack pattern 1 handler
Boss_ZLeoAttackPattern1:                              ; CODE XREF: Boss_ZLeoAttackState1+5E   j  ; was: sub_521C2
                                        ; Boss_ZLeoRisingAttack+C6   j
                move.w  #$1E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $47C(a5)
; Main attack pattern state with timer and laser spawning
Boss_ZLeo_AttackPattern1_WaitLoop:                              ; CODE XREF: Boss_ZLeoDefeatCheck+10   j  ; was: loc_521D6
                                        ; DATA XREF: ROM:00051BA0   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_52200
                cmpi.w  #$4200,(word_FF8200).w
                bpl.s   loc_521F8
                moveq   #3,d1
                cmpi.w  #$2500,(word_FF8200).w
                bpl.s   loc_521F0
                moveq   #1,d1
loc_521F0:                              ; CODE XREF: Boss_ZLeoAttackPattern1+2A   j
                move.w  (dword_FFFF08).w,d0
                and.w   d1,d0
                beq.s   loc_521FC
loc_521F8:                              ; CODE XREF: Boss_ZLeoAttackPattern1+20   j
                bra.w   loc_5220A
; ---------------------------------------------------------------------------
loc_521FC:                              ; CODE XREF: Boss_ZLeoAttackPattern1+34   j
                bra.w Boss_ZLeoAttackInit
; ---------------------------------------------------------------------------
loc_52200:                              ; CODE XREF: Boss_ZLeoAttackPattern1+18   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5220A:                              ; CODE XREF: Boss_ZLeoAttackPattern1:loc_521F8   j
                move.w  #$38,4(a5) ; '8'
                bsr.w Boss_ZLeoAnimationUpdate1
                move.w  #$80,$11C(a5)
                bsr.w Boss_ZLeoSpawnLaser
                move.w  #4,$B28(a5)
                move.w  #4,$C48(a5)
; Z-Leo boss advanced attack
Boss_ZLeoAttack_State36:                              ; DATA XREF: ROM:00051BBA   o  ; was: loc_5222A
                cmpi.w  #$60,$11C(a5) ; '`'
                bne.s   loc_52236
                bsr.w Boss_ZLeoLoadDefeatTiles
loc_52236:                              ; CODE XREF: Boss_ZLeoAttackPattern1+6E   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_52252
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.w  d0,$47E(a5)
                move.l  off_5225C(pc,d0.w),$3BC(a5)
                bra.w   loc_5226C
; ---------------------------------------------------------------------------
loc_52252:                              ; CODE XREF: Boss_ZLeoAttackPattern1+78   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
off_5225C:      dc.l word_52CCC         ; DATA XREF: Boss_ZLeoAttackPattern1+86   r
                dc.l word_52CE0
                dc.l word_52CF4
                dc.l word_52D08
; ---------------------------------------------------------------------------
loc_5226C:                              ; CODE XREF: Boss_ZLeoAttackPattern1+8C   j
                move.w  #$20,4(a5) ; ' '
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                move.b  #$D1,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackPattern1
; Attack state 1 handler
Boss_ZLeoAttackState1:                              ; DATA XREF: ROM:00051BA2   o  ; was: sub_5228A
                bclr    #0,$23E(a5)
                bne.s   loc_5229A
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5229A:                              ; CODE XREF: Boss_ZLeoAttackState1+6   j
                addq.w  #2,4(a5)
; Z-Leo boss mid phase
Boss_ZLeoAttack_State28:                              ; DATA XREF: ROM:00051BA4   o  ; was: loc_5229E
                tst.w   $58(a5)
                bmi.s   loc_522B0
                bsr.w Boss_ZLeoSpawnOrb
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_522B0:                              ; CODE XREF: Boss_ZLeoAttackState1+18   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$11C(a5)
; Z-Leo boss rapid attack
Boss_ZLeoAttack_State30:                              ; DATA XREF: ROM:00051BA6   o  ; was: loc_522C4
                subq.w  #1,$11C(a5)
                bne.s   loc_522DC
                cmpi.w  #8,$47E(a5)
                bne.s   loc_522DC
                move.b  #$3A,d0 ; ':'
                jsr (Sound_PlaySFX).l
loc_522DC:                              ; CODE XREF: Boss_ZLeoAttackState1+3E   j
                                        ; Boss_ZLeoAttackState1+46   j
                tst.w   $58(a5)
                bpl.s   loc_522EC
                move.w  #$40,$11C(a5) ; '@'
                bra.w Boss_ZLeoAttackPattern1
; ---------------------------------------------------------------------------
loc_522EC:                              ; CODE XREF: Boss_ZLeoAttackState1+56   j
                lea     word_52CC2(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoAttackState1
; Initializes Z-Leo attack state - sets state $26, clears animation, enables screen effects and attack flags
Boss_ZLeoAttackInit:                              ; CODE XREF: Boss_ZLeoAttackPattern1:loc_521FC   j  ; was: sub_522F6
                move.w  #$26,4(a5) ; '&'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                bset    #1,(byte_FF80EC).w
                clr.b   $21(a5)
                bset    #0,(byte_FFA272).w
; Z-Leo boss ultimate move
Boss_ZLeoAttack_State32:                              ; DATA XREF: ROM:00051BA8   o  ; was: loc_5231A
                bclr    #0,$23E(a5)
                bne.s   loc_5232C
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5232C:                              ; CODE XREF: Boss_ZLeoAttackInit+2A   j
                addq.w  #2,4(a5)
                bset    #2,(byte_FF8245).w
                bset    #2,(word_FFDB22).w
                move.l  #$FFF00000,(dword_FFDB3C).w
                move.b  #$4F,d0 ; 'O'
                jsr (Sound_PlaySFX).l
                bsr.w Boss_ZLeoAnimationUpdate1
                move.w  #$E000,$59E(a5)
                move.w  #$FFF8,$59C(a5)
                move.b  #$13,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackInit
; Z-Leo main attack sequence - handles laser spawning, vertical movement phases, screen scrolling, and palette cycling
Boss_ZLeoAttackSequence:                              ; DATA XREF: ROM:00051BAA   o  ; was: sub_52368
                tst.w   $58(a5)
                bmi.s   loc_52396
                cmpi.w  #$40,(dword_FFDB34).w ; '@'
                bpl.s   loc_5238C
                move.w  #$34,(word_FFA02A).w ; '4'
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0 ; ' '
                move.w  d0,(dword_FFA414).w
                clr.l   (dword_FFDB3C).w
loc_5238C:                              ; CODE XREF: Boss_ZLeoAttackSequence+C   j
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52396:                              ; CODE XREF: Boss_ZLeoAttackSequence+4   j
                addq.w  #2,4(a5)
                move.w  #3,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Z-Leo boss final phase entry
Boss_ZLeoAttack_State38:                              ; DATA XREF: ROM:00051BAC   o  ; was: loc_523AA
                bclr    #0,$23E(a5)
                beq.s   loc_523D2
                movea.w #(byte_FFD100-M68K_RAM),a4
                btst    #0,$11D(a5)
                bne.s   loc_523C2
                movea.w #(byte_FFD220-M68K_RAM),a4
loc_523C2:                              ; CODE XREF: Boss_ZLeoAttackSequence+54   j
                move.w  #9,$48(a4)
                bsr.w Projectile_ZLeoSpawnLasers
                subq.w  #1,$11C(a5)
                bmi.s   loc_523EC
loc_523D2:                              ; CODE XREF: Boss_ZLeoAttackSequence+48   j
                tst.w   $58(a5)
                bpl.s   loc_523E2
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_523E2:                              ; CODE XREF: Boss_ZLeoAttackSequence+6E   j
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_523EC:                              ; CODE XREF: Boss_ZLeoAttackSequence+68   j
                addq.w  #2,4(a5)
                move.b  #1,$47C(a5)
                clr.l   $41C(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 1
Boss_ZLeoAttack_State40:                              ; DATA XREF: ROM:00051BAE   o  ; was: loc_52400
                subq.w  #1,$11C(a5)
                bmi.s   loc_52446
                addi.l  #$4000,$41C(a5)
                cmpi.l  #$78000,$41C(a5)
                bmi.s   loc_52420
                move.l  #$78000,$41C(a5)
loc_52420:                              ; CODE XREF: Boss_ZLeoAttackSequence+AE   j
                move.l  $41C(a5),d0
                asl.l   #2,d0
                add.l   d0,$35C(a5)
                cmpi.w  #$180,$35C(a5)
                bmi.s   loc_52438
                move.w  #$180,$35C(a5)
loc_52438:                              ; CODE XREF: Boss_ZLeoAttackSequence+C8   j
                bsr.w Boss_ZLeoScrollUpdate
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52446:                              ; CODE XREF: Boss_ZLeoAttackSequence+9C   j
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 2
Boss_ZLeoAttack_State42:                              ; DATA XREF: ROM:00051BB0   o  ; was: loc_52450
                subq.w  #1,$11C(a5)
                bmi.s   loc_52462
loc_52456:                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_5250E   j
                bsr.w Boss_ZLeoScrollUpdate
                bsr.w Boss_ZLeoTileUpdate
                bra.w Boss_ZLeoGraphicsInit2
; ---------------------------------------------------------------------------
loc_52462:                              ; CODE XREF: Boss_ZLeoAttackSequence+EC   j
                addq.w  #2,4(a5)
                move.l  #$FFC00000,(dword_FFDB34).w
                move.l  #$50000,(dword_FFDB3C).w
                move.w  #$120,(dword_FFA410).w
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0 ; ' '
                move.w  d0,(dword_FFA414).w
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 3
Boss_ZLeoAttack_State44:                              ; DATA XREF: ROM:00051BB2   o  ; was: loc_5248E
                tst.w   (word_FFA02A).w
                beq.s   loc_524AC
                cmpi.w  #$C0,(dword_FFDB34).w
                bmi.s   loc_524AC
                clr.w   (word_FFA02A).w
                bclr    #2,(byte_FF8245).w
                bclr    #0,(byte_FFA272).w
loc_524AC:                              ; CODE XREF: Boss_ZLeoAttackSequence+12A   j
                                        ; Boss_ZLeoAttackSequence+132   j
                btst    #2,(word_FFDB22).w
                beq.s   loc_524C8
                subi.l  #$880,(dword_FFDB3C).w
                bpl.s   loc_524CE
                bclr    #2,(word_FFDB22).w
                clr.l   (dword_FFDB3C).w
loc_524C8:                              ; CODE XREF: Boss_ZLeoAttackSequence+14A   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_524EA
loc_524CE:                              ; CODE XREF: Boss_ZLeoAttackSequence+154   j
                subi.l  #$2000,$41C(a5)
                cmpi.l  #$FFF88000,$41C(a5)
                bpl.s   loc_524E8
                move.l  #$FFF88000,$41C(a5)
loc_524E8:                              ; CODE XREF: Boss_ZLeoAttackSequence+176   j
                bra.s   loc_524F6
; ---------------------------------------------------------------------------
loc_524EA:                              ; CODE XREF: Boss_ZLeoAttackSequence+164   j
                addq.w  #2,4(a5)
; Z-Leo boss final attack 4
Boss_ZLeoAttack_State46:                              ; DATA XREF: ROM:00051BB4   o  ; was: loc_524EE
                cmpi.w  #$240,(dword_FFA90C).w
                bmi.s Boss_ZLeoRisingAttack
loc_524F6:                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_524E8   j
                bsr.w Boss_ZLeoPaletteRotate
                tst.w   (word_FFA02A).w
                bne.s   loc_5250E
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_5250E
                bsr.w Projectile_ZLeoSpawnDropProjectile
loc_5250E:                              ; CODE XREF: Boss_ZLeoAttackSequence+196   j
                                        ; Boss_ZLeoAttackSequence+1A0   j
                bra.w   loc_52456
; End of function Boss_ZLeoAttackSequence
; Cycles Z-Leo palette colors based on frame counter - rotates 3 palette entries in 4 different patterns
Boss_ZLeoPaletteRotate:                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_524F6   p  ; was: sub_52512
                                        ; Boss_ZLeoRisingAttack+60   p
                move.w  (word_FFA000).w,d0
                asl.w   #3,d0
                andi.w  #$18,d0
                move.w  word_52530(pc,d0.w),(word_FFE364).w
                move.w  word_52530+2(pc,d0.w),(word_FFE37C).w
                move.w  word_52530+4(pc,d0.w),(word_FFE37E).w
                rts
; End of function Boss_ZLeoPaletteRotate
; ---------------------------------------------------------------------------
word_52530:     dc.w $2A2, $EEE, $6C6, 0, $AEC, $40, $4E8, 0, $EEC, $62, $6EC, 0, $EEE, $AEA, $EEC, 0
                                        ; DATA XREF: Boss_ZLeoPaletteRotate+A   r
                                        ; Boss_ZLeoPaletteRotate+10   r ...


; Z-Leo rising attack phase - moves boss upward while tracking player position and spawning projectiles
Boss_ZLeoRisingAttack:                              ; CODE XREF: Boss_ZLeoAttackSequence+18C   j  ; was: sub_52550
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$2400000,d0
                move.l  d0,$35C(a5)
                addi.w  #$F0,$35C(a5)
                move.w  #$E000,$59E(a5)
                clr.w   $11C(a5)
                move.w  #$200,$5B4(a5)
; Z-Leo boss final attack 5
Boss_ZLeoAttack_State48:                              ; DATA XREF: ROM:00051BB6   o  ; was: loc_5257E
                move.l  $41C(a5),d0
                add.l   d0,$35C(a5)
                bsr.w Boss_ZLeoScrollUpdate
                tst.w   $11C(a5)
                beq.w   loc_525A4
loc_52592:                              ; CODE XREF: Boss_ZLeoRisingAttack+88   j
                cmpi.w  #$F0,$35C(a5)
                bmi.s   loc_525E4
                lea     word_52D5E(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_525A4:                              ; CODE XREF: Boss_ZLeoRisingAttack+3E   j
                move.w  #$FFF6,$59C(a5)
                tst.w   (word_FF9500).w
                beq.s   loc_525B4
                bsr.w Boss_ZLeoPaletteRotate
loc_525B4:                              ; CODE XREF: Boss_ZLeoRisingAttack+5E   j
                move.w  $5B4(a5),d0
                addq.w  #4,d0
                cmp.w   (dword_FFDB34).w,d0
                bpl.s   loc_525DA
                move.b  #$F0,d0
                jsr (Sound_PlaySFX).l
                addq.w  #1,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_52592
; ---------------------------------------------------------------------------
loc_525DA:                              ; CODE XREF: Boss_ZLeoRisingAttack+6E   j
                lea     word_52D58(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_525E4:                              ; CODE XREF: Boss_ZLeoRisingAttack+48   j
                addq.w  #2,4(a5)
                move.l  #$100000,(dword_FFA90C).w
                move.l  #$F00000,$35C(a5)
                move.w  #$20,$11C(a5) ; ' '
                bclr    #1,(byte_FF80EC).w
                move.b  #$10,$21(a5)
; Z-Leo boss ultimate finale
Boss_ZLeoAttack_State50:                              ; DATA XREF: ROM:00051BB8   o  ; was: loc_5260A
                subq.w  #1,$11C(a5)
                bpl.s   loc_5261A
                move.w  #$80,$11C(a5)
                bra.w Boss_ZLeoAttackPattern1
; ---------------------------------------------------------------------------
loc_5261A:                              ; CODE XREF: Boss_ZLeoRisingAttack+BE   j
                lea     word_52D5E(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_52624:                              ; CODE XREF: Boss_ZLeoBattleState2+C   j
                                        ; Boss_ZLeoBattleState2+30   j ...
                move.w  $5B4(a5),d0
                addq.w  #4,d0
                move.w  d0,(dword_FFDB34).w
loc_5262E:                              ; CODE XREF: Boss_ZLeoIntroSetup+54   j
                                        ; Boss_ZLeoIntroMove+24   j ...
                bsr.w Boss_ZLeoUpdateSegments
                moveq   #$F,d7
                jsr (Sprite_InitMetaspriteSimple).l
                move.w  #$120,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA900).w
                move.w  $14(a5),d0
                addi.w  #-$104,d0
                sub.w   (word_FFA012).w,d0
                move.w  d0,(dword_FFA904).w
                bsr.w Boss_ZLeoUpdateBladeSprite
                bsr.w Boss_ZLeoUpdateWingSprites
                bsr.w Boss_ZLeoSpriteUpdate
                bsr.w Boss_ZLeoTileUpdate
                bsr.w Boss_ZLeoGraphicsInit2
                btst    #1,(word_FFA000+1).w
                bne.s   loc_5267A
                move.w  #$8C,(word_FFE37E).w
                rts
; ---------------------------------------------------------------------------
loc_5267A:                              ; CODE XREF: Boss_ZLeoRisingAttack+120   j
                move.w  #$2EE,(word_FFE37E).w
                rts
; End of function Boss_ZLeoRisingAttack
; Tile update handler
Boss_ZLeoTileUpdate:                              ; CODE XREF: Boss_ZLeoAttackSequence+F2   p  ; was: sub_52682
                                        ; Boss_ZLeoRisingAttack+112   p
                movea.w #(byte_FF9604-M68K_RAM),a3
                lea     word_5271E(pc),a4
                nop
                move.w  (word_FF9600).w,d7
                move.w  (dword_FFA904).w,d0
                addi.w  #$20,d0 ; ' '
                bmi.w   nullsub_120
                move.w  (word_FF9602).w,d1
                move.w  d0,(word_FF9602).w
                cmp.w   d1,d0
                beq.w   nullsub_120
                lea     word_5270E(pc),a0
                nop
                bpl.s   loc_526E2
                cmp.w   2(a0,d7.w),d0
                bpl.w   nullsub_120
                addq.w  #2,(word_FF9600).w
                move.w  (a4,d7.w),(a3)+
                move.w  #$2000,(a3)+
                move.b  #5,(a3)+
                move.b  #0,(a3)+
                lea     off_5272A(pc),a1
                nop
                asl.w   #1,d7
                movea.l (a1,d7.w),a1
                move.l  (a1)+,(a3)+
                move.w  (a1)+,(a3)+
                bra.w   loc_52704
; ---------------------------------------------------------------------------
loc_526E2:                              ; CODE XREF: Boss_ZLeoTileUpdate+2E   j
                cmp.w   (a0,d7.w),d0
                bmi.w   nullsub_120
                subq.w  #2,(word_FF9600).w
                move.w  -2(a4,d7.w),(a3)+
                move.w  #$2000,(a3)+
                move.b  #5,(a3)+
                move.b  #0,(a3)+
                moveq   #0,d0
                move.l  d0,(a3)+
                move.w  d0,(a3)+
loc_52704:                              ; CODE XREF: Boss_ZLeoTileUpdate+5C   j
                movea.w #(byte_FF9604-M68K_RAM),a0
                jmp Gfx_LoadCompressedTiles
; End of function Boss_ZLeoTileUpdate
; ---------------------------------------------------------------------------
word_5270E:     dc.w $7FFF, $C0, $A0, $80, $60, $40, $20, 0
                                        ; DATA XREF: Boss_ZLeoTileUpdate+28   o
word_5271E:     dc.w $4410, $4610, $4810, $4A10, $4C10, $4E10
                                        ; DATA XREF: Boss_ZLeoTileUpdate+4   o
off_5272A:      dc.l byte_52742         ; DATA XREF: Boss_ZLeoTileUpdate+4C   o
                dc.l byte_52748
                dc.l byte_5274E
                dc.l byte_52754
                dc.l byte_5275A
                dc.l byte_52760
byte_52742:     dc.b 0, 0, 1, 2, 0, 0   ; DATA XREF: ROM:off_5272A   o
byte_52748:     dc.b 3, 4, 5, 6, 7, 8   ; DATA XREF: ROM:0005272E   o
byte_5274E:     dc.b 9, $A, $B, $C, $D, $E
                                        ; DATA XREF: ROM:00052732   o
byte_52754:     dc.b 0, $F, $10, $11, $12, 0
                                        ; DATA XREF: ROM:00052736   o
byte_5275A:     dc.b 0, $13, $14, $15, $16, 0
                                        ; DATA XREF: ROM:0005273A   o
byte_52760:     dc.b $17, $18, $19, $1A, $1B, $1C
                                        ; DATA XREF: ROM:0005273E   o


; Enable boss parts flags
Boss_ZLeoEnableParts:                              ; CODE XREF: Boss_ZLeoBattleState1+E   p  ; was: sub_52766
                moveq   #7,d0
                bset    d0,$7EE(a5)
                bset    d0,$90E(a5)
                bset    d0,$A2E(a5)
                bset    d0,$84E(a5)
                bset    d0,$96E(a5)
                bset    d0,$A8E(a5)
                rts
; End of function Boss_ZLeoEnableParts
; Disables all 6 Z-Leo body part sprites by clearing bit 7 in their control bytes
Boss_ZLeoDisableParts:
                moveq   #7,d0  ; was: sub_52782
                bclr    d0,$7EE(a5)
                bclr    d0,$90E(a5)
                bclr    d0,$A2E(a5)
                bclr    d0,$84E(a5)
                bclr    d0,$96E(a5)
                bclr    d0,$A8E(a5)
                rts
; End of function Boss_ZLeoDisableParts
; Graphics init handler 1
Boss_ZLeoGraphicsInit1:                              ; CODE XREF: Boss_ZLeoInit+4C   p  ; was: sub_5279E
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$40C,(a0)
                move.w  #$400,2(a0)
                clr.w   $56(a0)
                move.b  #$20,$21(a0) ; ' '
                move.w  #6,$46(a0)
                move.l  #$FF000100,$28(a0)
                move.w  #$150,d6
                move.w  #$120,d7
                move.w  d6,$10(a0)
                move.w  d7,$14(a0)
                move.w  d6,$48(a0)
                move.w  d7,$4C(a0)
                rts
; End of function Boss_ZLeoGraphicsInit1
; Load defeat tiles
Boss_ZLeoLoadDefeatTiles:                              ; CODE XREF: Boss_ZLeoBattleState1+30   p  ; was: sub_527DE
                                        ; Boss_ZLeoAttackPattern1+70   p
                lea     word_527EA(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_ZLeoLoadDefeatTiles
; ---------------------------------------------------------------------------
word_527EA:     dc.w $4820, $2000, $100, $B0C
                                        ; DATA XREF: Boss_ZLeoLoadDefeatTiles   o


; Animation update handler 1
Boss_ZLeoAnimationUpdate1:                              ; CODE XREF: Boss_ZLeoBattleStart+A8   p  ; was: sub_527F2
                                        ; Boss_ZLeoAttackPattern2+46   p ...
                lea     word_527FE(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Boss_ZLeoAnimationUpdate1
; ---------------------------------------------------------------------------
word_527FE:     dc.w $4820, $2000, $100, $1F20
                                        ; DATA XREF: Boss_ZLeoAnimationUpdate1   o


; Graphics init handler 2
Boss_ZLeoGraphicsInit2:                              ; CODE XREF: Boss_ZLeoInit+50   p  ; was: sub_52806
                                        ; sub_51C32   p ...
                movea.w #(word_FF9E00-M68K_RAM),a0
                move.w  (dword_FFA904).w,d7
                neg.w   d7
                move.w  (dword_FFDB34).w,d0
                subi.w  #$8B,d0
                beq.s   loc_52822
                bmi.s   loc_52822
                cmpi.w  #$DE,d0
                bmi.s   loc_52826
loc_52822:                              ; CODE XREF: Boss_ZLeoGraphicsInit2+12   j
                                        ; Boss_ZLeoGraphicsInit2+14   j
                move.w  #$FF,d0
loc_52826:                              ; CODE XREF: Boss_ZLeoGraphicsInit2+1A   j
                ori.w   #$8A00,d0
                move.w  d0,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                move.w  #$8A1F,d2
                cmpi.w  #$148,(dword_FFDB34).w
                bmi.s   loc_52846
                move.w  #$8AFF,d2
loc_52846:                              ; CODE XREF: Boss_ZLeoGraphicsInit2+3A   j
                move.w  d2,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                move.w  #$8AFF,(a0)+
                move.w  (dword_FFDB34).w,d1
                addi.w  #$98,d1
                neg.w   d1
                move.w  d1,(a0)+
                move.w  #$8B02,(a0)+
                move.w  #$8210,(a0)+
                move.w  #$8AFF,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                rts
; End of function Boss_ZLeoGraphicsInit2
; Graphics init handler 3
Boss_ZLeoGraphicsInit3:                              ; CODE XREF: Boss_ZLeoInit+54   p  ; was: sub_5287A
                movea.l #word_52892,a0
                jsr (Gfx_LoadCompressedTiles).l
                move.w  #$81,d0
                moveq   #3,d7
                jmp Gfx_SetSpritePattern
; End of function Boss_ZLeoGraphicsInit3
; ---------------------------------------------------------------------------
word_52892:     dc.w $4E00, $4000, $900, $2A2B, $2A2B, $2A2B, $2A2B, $2A2B, $4E00, $4000, $900, $2D2E, $2D2E, $2D2E, $2D2E, $2D2E
                                        ; DATA XREF: Boss_ZLeoGraphicsInit3   o


; Update blade sprite
Boss_ZLeoUpdateBladeSprite:                              ; CODE XREF: Boss_ZLeoRisingAttack+106   p  ; was: sub_528B2
                lea     off_528C8(pc),a1
                nop
                movea.w #(word_FFC860-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jmp Sprite_UpdateBossBladeSprite
; End of function Boss_ZLeoUpdateBladeSprite
; ---------------------------------------------------------------------------
off_528C8:      dc.l word_ED3F4         ; DATA XREF: Boss_ZLeoUpdateBladeSprite   o
                dc.l word_ED40C
                dc.l word_ED424
                dc.l word_ED43C


; Update wing sprites
Boss_ZLeoUpdateWingSprites:                              ; CODE XREF: Boss_ZLeoRisingAttack+10A   p  ; was: sub_528D8
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  $34(a0),d2
                ext.w   d2
                movea.w #(word_FFCDA0-M68K_RAM),a0
                moveq   #$FFFFFFFE,d0
                moveq   #$FFFFFFF6,d1
                bsr.s Boss_ZLeoUpdateWingPositions
                movea.w #(word_FFCEC0-M68K_RAM),a0
                moveq   #0,d0
                moveq   #0,d1
                bsr.s Boss_ZLeoUpdateWingPositions
                movea.w #(byte_FFCFE0-M68K_RAM),a0
                moveq   #2,d0
                moveq   #$A,d1
; End of function Boss_ZLeoUpdateWingSprites
; Calculate wing positions
Boss_ZLeoUpdateWingPositions:                              ; CODE XREF: Boss_ZLeoUpdateWingSprites+12   p  ; was: sub_528FE
                                        ; Boss_ZLeoUpdateWingSprites+1C   p
                add.w   $5B0(a5),d1
                move.w  d1,$10(a0)
                add.w   d0,d1
                move.w  d1,$70(a0)
                add.w   d0,d1
                move.w  d1,$D0(a0)
                moveq   #$FFFFFFF4,d0
                move.w  $5B4(a5),d4
                move.w  d2,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$D4(a0)
                move.w  d2,d3
                asr.w   #1,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$74(a0)
                move.w  d2,d3
                asr.w   #2,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$14(a0)
                rts
; End of function Boss_ZLeoUpdateWingPositions
; Sprite update handler
Boss_ZLeoSpriteUpdate:                              ; CODE XREF: Boss_ZLeoRisingAttack+10E   p  ; was: sub_5293C
                movea.w #(byte_FFD100-M68K_RAM),a0
                move.w  #$FFDE,d0
                bsr.s Boss_ZLeoUpdateHeadPosition
                movea.w #(byte_FFD220-M68K_RAM),a0
                move.w  #$22,d0 ; '"'
; End of function Boss_ZLeoSpriteUpdate
; Update head sprite positions
Boss_ZLeoUpdateHeadPosition:                              ; CODE XREF: Boss_ZLeoSpriteUpdate+8   p  ; was: sub_5294E
                move.w  #$FFD7,d1
                move.w  $48(a0),d2
                beq.s   loc_5295E
                subq.w  #1,d2
                move.w  d2,$48(a0)
loc_5295E:                              ; CODE XREF: Boss_ZLeoUpdateHeadPosition+8   j
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.w  d0,$70(a0)
                move.w  d0,$D0(a0)
                add.w   $14(a5),d1
                add.w   d2,d1
                move.w  d1,$14(a0)
                asr.w   #1,d2
                addi.w  #-$20,d1
                add.w   d2,d1
                move.w  d1,$74(a0)
                addi.w  #-$1C,d1
                add.w   d2,d1
                move.w  d1,$D4(a0)
                rts
; End of function Boss_ZLeoUpdateHeadPosition
; Applies palette fade effect to Z-Leo colors - fades palettes at $FFE302 and $FFE342 towards black ($E000)
Boss_ZLeoFadeoutPalette:                              ; CODE XREF: Boss_ZLeoAttackPattern2:loc_520DE   p  ; was: sub_52990
                                        ; sub_52138:loc_5214E   p
                move.w  #6,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.w  $11C(a5),d0
                asl.w   #1,d0
                cmpi.w  #$E,d0
                bmi.s   loc_529AA
                moveq   #$E,d0
loc_529AA:                              ; CODE XREF: Boss_ZLeoFadeoutPalette+16   j
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$F,d5
                move.w  #$E000,d7
                jsr (Gfx_ApplyPaletteFade).l
                move.w  $11C(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1E,d5
                move.w  #$E000,d7
                jmp (Gfx_ApplyPaletteFade).l
; End of function Boss_ZLeoFadeoutPalette
; Animation update handler 2
Boss_ZLeoAnimationUpdate2:                              ; CODE XREF: Boss_ZLeoAttackPattern2+68   p  ; was: sub_529CE
                                        ; Boss_ZLeoAttackPattern2+9C   p
                jsr (Effect_PlayRandomExplosionSound).l
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_52A52
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_529F0
                jsr (Effect_InitDebrisSprite).l
                bra.w   loc_52A24
; ---------------------------------------------------------------------------
loc_529F0:                              ; CODE XREF: Boss_ZLeoAnimationUpdate2+16   j
                jsr (Sprite_InitializeProperties).l
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_52A24
                move.l  #off_E9560,8(a0)
                clr.w   $1C(a0)
loc_52A24:                              ; CODE XREF: Boss_ZLeoAnimationUpdate2+1E   j
                                        ; Boss_ZLeoAnimationUpdate2+48   j
                move.b  #0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$7F,d0
                andi.w  #$7F,d1
                subi.w  #$40,d0 ; '@'
                subi.w  #$20,d1 ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_52A52:                           ; CODE XREF: Boss_ZLeoAnimationUpdate2+C   j
                rts
; End of function Boss_ZLeoAnimationUpdate2
; Animation update handler 3
Boss_ZLeoAnimationUpdate3:                              ; CODE XREF: Boss_ZLeoAttackPattern2+6C   p  ; was: sub_52A54
                tst.w   (word_FFF74A).w
                beq.s   locret_52A7E
                cmpi.w  #$200,(dword_FFDB34).w
                bmi.s   loc_52A76
                clr.l   $1C(a5)
                move.w  #$200,(dword_FFDB34).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                rts
; ---------------------------------------------------------------------------
loc_52A76:                              ; CODE XREF: Boss_ZLeoAnimationUpdate3+C   j
                addi.l  #$800,(dword_FFDB3C).w
locret_52A7E:                           ; CODE XREF: Boss_ZLeoAnimationUpdate3+4   j
                rts
; End of function Boss_ZLeoAnimationUpdate3
; Update boss segments
Boss_ZLeoUpdateSegments:                              ; CODE XREF: Boss_ZLeoRisingAttack:loc_5262E   p  ; was: sub_52A80
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_52AF8
loc_52A8A:                              ; CODE XREF: Boss_ZLeoUpdateSegments+24   j
                                        ; Boss_ZLeoUpdateSegments+44   j
                move.w  $58(a5),d0
                bmi.w   loc_52B08
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_52AA6
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_52A8A
; ---------------------------------------------------------------------------
loc_52AA6:                              ; CODE XREF: Boss_ZLeoUpdateSegments+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_52AB6
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_52AB6:                              ; CODE XREF: Boss_ZLeoUpdateSegments+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_52AC6
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_52A8A
; ---------------------------------------------------------------------------
loc_52AC6:                              ; CODE XREF: Boss_ZLeoUpdateSegments+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_52D68,d0
                movea.l d0,a0
                bsr.w Boss_ZLeoAnimationCalc
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_52B08
loc_52AF8:                              ; CODE XREF: Boss_ZLeoUpdateSegments+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$D,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_52B08:                              ; CODE XREF: Boss_ZLeoUpdateSegments+E   j
                                        ; Boss_ZLeoUpdateSegments+76   j
                moveq   #7,d6
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                moveq   #0,d2
                move.w  8(a0),d2
                swap    d2
                asr.l   d6,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$176(a5)
                swap    d2
                moveq   #0,d1
                move.w  $C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$1D6(a5)
                swap    d1
                moveq   #0,d2
                move.w  $10(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$236(a5)
                swap    d2
                moveq   #0,d1
                move.w  $14(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$296(a5)
                moveq   #0,d2
                move.w  $18(a0),d2
                swap    d2
                asr.l   d6,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$2F6(a5)
                move.w  d2,$356(a5)
                swap    d2
                moveq   #0,d1
                move.w  $1C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$3B6(a5)
                move.w  d1,$416(a5)
                swap    d1
                moveq   #0,d2
                move.w  $20(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$476(a5)
                move.w  d2,$4D6(a5)
                swap    d2
                moveq   #0,d1
                move.w  $24(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.w  d1,$596(a5)
                swap    d1
                moveq   #0,d2
                move.w  $28(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$5F6(a5)
                move.b  $2C(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $2FC(a5),d0
                move.w  d0,$10(a5)
                asr.w   #2,d1
                addi.w  #$20,d1 ; ' '
                move.w  d1,(dword_FFA908).w
                move.b  $30(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $35C(a5),d0
                move.w  d0,$14(a5)
                tst.b   $47C(a5)
                bne.s   locret_52C32
                asr.w   #2,d1
                move.w  #$20,d0 ; ' '
                sub.w   d1,d0
                move.w  d0,(dword_FFA90C).w
locret_52C32:                           ; CODE XREF: Boss_ZLeoUpdateSegments+1A4   j
                rts
; End of function Boss_ZLeoUpdateSegments
; Animation calculation
Boss_ZLeoAnimationCalc:                              ; CODE XREF: Boss_ZLeoUpdateSegments+5C   p  ; was: sub_52C34
                lea     word_52D68(pc),a1
                nop
                moveq   #$D,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ZLeoAnimationCalc
; Loads animation frame delay data for Z-Leo using 13 animation channels
Boss_ZLeoAnimationLoadDelays:
                moveq   #$D,d7  ; was: sub_52C4A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ZLeoAnimationLoadDelays
; ---------------------------------------------------------------------------
word_52C56:     dc.w $810, $E, $1010, $E, $810, $1C, $1010, $1C, $FFFF
                                        ; DATA XREF: Boss_ZLeoIntroSetup+4E   o
word_52C68:     dc.w $3030, $62, $C18, $70, $3030, $70, $C18, $62, $FFFF
                                        ; DATA XREF: Boss_ZLeoAttackPattern2+70   o
                                        ; Boss_ZLeoAttackPattern2+A0   o
word_52C7A:     dc.w $810, $E, $1010, $E, $810, $1C, $1010, $1C, $FFFF
                                        ; DATA XREF: Boss_ZLeoIntroMove+1E   o
                                        ; Boss_ZLeoBattleStart+48   o ...
word_52C8C:     dc.w $1818, $2A, $8001, $1010, $38, $2020, $46, $FFFE
                                        ; DATA XREF: Boss_ZLeoBattleState1:loc_51FBC   o
word_52C9C:     dc.w $218, $46, $278, $54, $FFFF, $2020, $54, $1010, $54, $FFFF
                                        ; DATA XREF: Boss_ZLeoBattleState2+6   o
word_52CB0:     dc.w $1020, $7E, $2020, $7E, $1020, $8C, $2020, $8C, $FFFF
                                        ; DATA XREF: Boss_ZLeoBattleState2+2A   o
                                        ; sub_52028:loc_5203C   o ...
word_52CC2:     dc.w $1020, $8C, $2020, $8C, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackState1:loc_522EC   o
word_52CCC:     dc.w $2830, $9A, $3030, $9A, $8001, $5060, $A8, $4040, $A8, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1:off_5225C   o
word_52CE0:     dc.w $2830, $B6, $3030, $B6, $8001, $5060, $C4, $4040, $C4, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+9E   o
word_52CF4:     dc.w $2830, $D2, $3030, $D2, $8001, $5060, $E0, $4040, $E0, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+A2   o
word_52D08:     dc.w $2830, $EE, $3030, $EE, $8001, $5060, $FC, $4040, $FC, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+A6   o
word_52D1C:     dc.w $1218, $10A, $707, $10A, $1014, $118, $1A1A, $118, $340, $126, $8001, $90E, $126, $1A1A, $126, $1818
                                        ; DATA XREF: Boss_ZLeoAttackInit+2C   o
                                        ; sub_52368:loc_5238C   o
                dc.w $134, $343C, $142, $FFFE
word_52D44:     dc.w $60A, $142, $A0A, $142, $8001, $103, $150, $303, $150, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackSequence:loc_523E2   o
                                        ; Boss_ZLeoAttackSequence+D4   o
word_52D58:     dc.w $404, $15E, $FFFE  ; DATA XREF: Boss_ZLeoRisingAttack:loc_525DA   o
word_52D5E:     dc.w $810, $16C, $3030, $16C, $FFFE
                                        ; DATA XREF: Boss_ZLeoRisingAttack+4A   o
                                        ; sub_52550:loc_5261A   o
word_52D68:	binclude	"data/other/word_52D68.bin"
word_52D68_End:


; Empty entity state handler in main dispatch table
Entity_EmptyState8:                              ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_8
                rts
; End of function Entity_EmptyState8
; Updates Z-Leo vertical scroll position based on velocity, handles screen wrap-around boundary checks
Boss_ZLeoScrollUpdate:                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_52438   p  ; was: sub_52EE4
                                        ; sub_52368:loc_52456   p ...
                move.l  $41C(a5),d0
                bmi.s   loc_52EFE
                add.l   d0,(dword_FFA90C).w
                move.w  (dword_FFA90C).w,d1
                subi.w  #8,d1
                bmi.s   loc_52F14
                addi.w  #-$1FFF,d1
                bra.s   loc_52F14
; ---------------------------------------------------------------------------
loc_52EFE:                              ; CODE XREF: Boss_ZLeoScrollUpdate+4   j
                add.l   d0,(dword_FFA90C).w
                move.w  (dword_FFA90C).w,d1
                subi.w  #$E8,d1
                cmpi.w  #$E001,d1
                bpl.s   loc_52F14
                subi.w  #$E000,d1
loc_52F14:                              ; CODE XREF: Boss_ZLeoScrollUpdate+12   j
                                        ; Boss_ZLeoScrollUpdate+18   j ...
                lea     word_52F22(pc),a0
                nop
                moveq   #0,d0
                jmp     loc_109E0
; End of function Boss_ZLeoScrollUpdate
; ---------------------------------------------------------------------------
word_52F22:     dc.w $FFFF, $7000, $FFFF, $6800, $FFFF, $4000, 0, $6000
                                        ; DATA XREF: Boss_ZLeoScrollUpdate:loc_52F14   o


; Spawn orb projectile
Boss_ZLeoSpawnOrb:                              ; CODE XREF: Boss_ZLeoAttackState1+1A   p  ; was: sub_52F32
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.w   locret_53038
                move.w  #4,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_53038
                move.w  #$C000,$59E(a5)
                btst    #0,(dword_FFFF08).w
                bne.s   loc_52F68
                move.w  #$8000,$59E(a5)
loc_52F68:                              ; CODE XREF: Boss_ZLeoSpawnOrb+2E   j
                move.w  #3,$59C(a5)
                movea.l #dword_2ADC8,a1
                jsr (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8040,2(a0)
                movea.w a0,a3
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_53038
                move.b  #$36,d0 ; '6'
                jsr (Sound_PlaySFX).l
                move.w  #$468,(a0)
                move.w  #$8C80,2(a0)
                move.b  #$42,$21(a0) ; 'B'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$A,$26(a0)
                move.b  #8,$20(a0)
                move.w  $296(a5),d0
                move.w  d0,d2
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                muls.w  #$28,d3 ; '('
                muls.w  #$28,d4 ; '('
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                addi.w  #$20,d0 ; ' '
                asr.w   #4,d0
                andi.w  #$1C,d0
                move.w  word_5303A(pc,d0.w),d5
                move.w  word_5303A+2(pc,d0.w),d6
                add.w   $254(a5),d5
                add.w   $250(a5),d6
                move.w  d5,$14(a0)
                move.w  d6,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d5
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d6
                move.w  d5,$14(a3)
                move.w  d6,$10(a3)
                move.w  #$C489,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
locret_53038:                           ; CODE XREF: Boss_ZLeoSpawnOrb+8   j
                                        ; Boss_ZLeoSpawnOrb+1E   j ...
                rts
; End of function Boss_ZLeoSpawnOrb
; ---------------------------------------------------------------------------
word_5303A:     dc.w 0, $20, $18, $18, $20, 0, $18, $FFE8, 0, $FFE0, $FFE8, $FFE8, $FFE0, 0, $FFE8, $18
                                        ; DATA XREF: Boss_ZLeoSpawnOrb+BC   r
                                        ; Boss_ZLeoSpawnOrb+C0   r


; Orb projectile main
Projectile_ZLeoOrbMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_5305A
                tst.w   (word_FF808C).w
                bpl.s   loc_53070
                btst    #7,$22(a5)
                beq.s   loc_53096
                btst    #4,$22(a5)
                beq.s   loc_53080
loc_53070:                              ; CODE XREF: Projectile_ZLeoOrbMain+4   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   loc_530AE
                jmp Sprite_SetPointerClearD7
; ---------------------------------------------------------------------------
loc_53080:                              ; CODE XREF: Projectile_ZLeoOrbMain+14   j
                neg.l   $18(a5)
                neg.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_53096:                              ; CODE XREF: Projectile_ZLeoOrbMain+C   j
                cmpi.w  #$1C0,$10(a5)
                bpl.s   loc_530AE
                cmpi.w  #$80,$10(a5)
                bmi.s   loc_530AE
                cmpi.w  #$70,$14(a5) ; 'p'
                bpl.s   loc_530B6
loc_530AE:                              ; CODE XREF: Projectile_ZLeoOrbMain+1E   j
                                        ; Projectile_ZLeoOrbMain+42   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_530B6:                              ; CODE XREF: Projectile_ZLeoOrbMain+52   j
                move.w  (dword_FFDB34).w,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_530D4
                tst.w   $1C(a5)
                bmi.s   loc_530D4
                move.b  #$37,d0 ; '7'
                jsr (Sound_PlaySFX).l
                neg.l   $1C(a5)
loc_530D4:                              ; CODE XREF: Projectile_ZLeoOrbMain+64   j
                                        ; Projectile_ZLeoOrbMain+6A   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_530E4
                move.w  #$E489,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_530E4:                              ; CODE XREF: Projectile_ZLeoOrbMain+80   j
                move.w  #$C489,$E(a5)
                rts
; End of function Projectile_ZLeoOrbMain
nullsub_122:
                rts
; End of function nullsub_122


; Spawn laser projectile
Boss_ZLeoSpawnLaser:                              ; CODE XREF: Boss_ZLeoAttackPattern1+58   p  ; was: sub_530EE
                move.w  (dword_FFFF08).w,d7
                andi.w  #$100,d7
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_53180
                move.w  #8,$4DC(a5)
                move.w  #$8000,$4DE(a5)
                move.w  #$C,$53C(a5)
                move.w  #$8000,$53E(a5)
                move.w  #$E,$59C(a5)
                move.w  #$8000,$59E(a5)
                move.b  #$CB,d0
                jsr (Sound_PlaySFX).l
                move.w  #$46C,(a0)
                move.w  #$8000,2(a0)
                move.w  #$F00,8(a0)
                move.w  #$F0F0,$A(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addi.w  #0,$14(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FA06FA06,$2C(a0)
                move.w  #$F3,$26(a0)
                move.w  #$10,$48(a0)
                move.w  #4,$50(a0)
                move.w  d7,$56(a0)
locret_53180:                           ; CODE XREF: Boss_ZLeoSpawnLaser+E   j
                rts
; End of function Boss_ZLeoSpawnLaser
; Laser projectile main
Projectile_ZLeoLaserMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_53182
                cmpi.w  #$180,$14(a5)
                bpl.s   loc_53192
                cmpi.w  #$80,$14(a5)
                bpl.s   loc_5319A
loc_53192:                              ; CODE XREF: Projectile_ZLeoLaserMain+6   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_5319A:                              ; CODE XREF: Projectile_ZLeoLaserMain+E   j
                tst.w   (word_FF808C).w
                bpl.s   loc_531B2
                bclr    #7,$22(a5)
                beq.s   loc_531C6
                bclr    #4,$22(a5)
                bne.w   loc_53242
loc_531B2:                              ; CODE XREF: Projectile_ZLeoLaserMain+1C   j
                move.w  #3,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_531C6:                              ; CODE XREF: Projectile_ZLeoLaserMain+24   j
                addi.w  #6,$56(a5)
                addq.w  #5,$50(a5)
                lea     (word_1B514).l,a0
                move.w  $56(a5),d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d3
                move.w  (a0,d0.w),d4
                ext.l   d3
                ext.l   d4
                asl.l   #5,d3
                asl.l   #4,d4
                move.l  d3,$1C(a5)
                move.l  d4,$18(a5)
                move.w  $50(a5),d0
                muls.w  d0,d1
                muls.w  d0,d2
                add.l   (dword_FFC634).w,d1
                add.l   (dword_FFC630).w,d2
                move.l  d1,$14(a5)
                move.l  d2,$10(a5)
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_5323A(pc,d0.w),$E(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   loc_532BA
                rts
; ---------------------------------------------------------------------------
word_5323A:     dc.w $C56C, $C50B, $C54B, $C51B
                                        ; DATA XREF: Projectile_ZLeoLaserMain+A6   r
; ---------------------------------------------------------------------------
loc_53242:                              ; CODE XREF: Projectile_ZLeoLaserMain+2C   j
                move.b  #$7C,d0 ; '|'
                jsr (Sound_PlaySFX).l
                move.w  #$498,(a5)
                move.w  #$8E00,2(a5)
                move.b  #1,$21(a5)
                clr.b   $22(a5)
                clr.b   $23(a5)
                move.w  #$154,$26(a5)
                clr.l   $1C(a5)
                move.l  #$100000,$18(a5)
                btst    #3,(word_FFA40E).w
                bne.s Projectile_ZLeoLaser_CollisionCheck
                neg.l   $18(a5)
; Handles laser projectile collision and spawns particle effects
Projectile_ZLeoLaser_CollisionCheck:                              ; CODE XREF: Projectile_ZLeoLaserMain+FA   j  ; was: loc_53282
                                        ; DATA XREF: ROM:off_5DC   o
                bclr    #7,$22(a5)
                beq.s   loc_532B0
                move.b  #$BC,d0
                jsr (Sound_PlaySFX).l
                move.w  #3,(word_FFA010).w
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E9850,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_532B0:                              ; CODE XREF: Projectile_ZLeoLaserMain+106   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_53316
loc_532BA:                              ; CODE XREF: Projectile_ZLeoLaserMain+B2   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_53316
                move.l  #off_E953C,8(a0)
                jsr (Projectile_InitType88).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  $18(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                neg.l   d0
                move.l  d0,$1C(a0)
locret_53316:                           ; CODE XREF: Projectile_ZLeoLaserMain+136   j
                                        ; Projectile_ZLeoLaserMain+13E   j
                rts
; End of function Projectile_ZLeoLaserMain
; Spawns two Z-Leo laser projectiles at different positions with velocities and angles
Projectile_ZLeoSpawnLasers:                              ; CODE XREF: Boss_ZLeoAttackSequence+60   p  ; was: sub_53318
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_533BC
                move.w  #$188,(a0)
                move.w  #$C480,2(a0)
                move.w  #$C380,$E(a0)
                move.l  #word_ED382,8(a0)
                move.b  #0,$20(a0)
                move.l  #$FFFE8000,$1C(a0)
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                addi.w  #-$40,$14(a0)
                move.w  #2,$48(a0)
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_533BC
                move.w  #$470,(a0)
                move.w  #$C480,2(a0)
                move.w  #$C380,$E(a0)
                move.l  #word_ED47E,8(a0)
                move.b  #$60,$20(a0) ; '`'
                move.l  #$FFF00000,$1C(a0)
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
                addi.w  #-$68,$14(a0)
                move.w  #$10,$48(a0)
                move.w  #$4000,$59E(a5)
                move.w  #7,$59C(a5)
                move.b  #$EA,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_533BC:                           ; CODE XREF: Projectile_ZLeoSpawnLasers+6   j
                                        ; Projectile_ZLeoSpawnLasers+4E   j
                rts
; End of function Projectile_ZLeoSpawnLasers
; Z-Leo laser projectile falling behavior - decrements timer, applies downward velocity, destroys on timeout
Projectile_ZLeoLaserFall:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_533BE
                subq.w  #1,$48(a5)
                bpl.s   loc_533CC
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_533CC:                              ; CODE XREF: Projectile_ZLeoLaserFall+4   j
                subi.l  #$80000,$1C(a5)
                rts
; End of function Projectile_ZLeoLaserFall
; Spawns falling projectile with graphics setup and horizontal velocity based on screen position
Projectile_ZLeoSpawnDropProjectile:                              ; CODE XREF: Boss_ZLeoAttackSequence+1A2   p  ; was: sub_533D6
                                        ; DATA XREF: ROM:off_5DC   o
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_534AA
                move.w  #$6000,$4DE(a5)
                move.w  #3,$4DC(a5)
                move.w  #$6000,$53E(a5)
                move.w  #3,$53C(a5)
                move.b  #$59,d0 ; 'Y'
                jsr (Sound_PlaySFX).l
                move.w  #$478,(a0)
                move.w  #$C080,2(a0)
                move.w  #$6380,$E(a0)
                move.l  #word_ED47E,8(a0)
                move.b  #8,$20(a0)
                clr.b   $21(a0)
                move.w  #$C8,$26(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$9070F808,$2C(a0)
                move.w  #$4E0,$14(a0)
                movea.w a0,a3
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_534AA
                move.w  #$424,(a0)
                move.w  #$8080,2(a0)
                move.b  #4,$20(a0)
                jsr (Gfx_SetupTileGraphics).l
                move.w  #$20,$48(a0) ; ' '
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E000,d0
                ext.l   d0
                move.l  d0,$56(a3)
                move.w  #$14C,$14(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$70,d0 ; 'p'
                subi.w  #$38,d0 ; '8'
                add.w   (dword_FFA410).w,d0
                move.w  d0,$10(a0)
                move.w  d0,$10(a3)
                cmpi.w  #$120,d0
                bpl.s   loc_534A2
                move.l  #$60000,$18(a3)
                rts
; ---------------------------------------------------------------------------
loc_534A2:                              ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+C0   j
                move.l  #$FFFA0000,$18(a3)
locret_534AA:                           ; CODE XREF: Projectile_ZLeoSpawnDropProjectile+6   j
                                        ; Projectile_ZLeoSpawnDropProjectile+70   j
                rts
; End of function Projectile_ZLeoSpawnDropProjectile
; Z-Leo drop projectile main logic - moves horizontally, rises to Y=$F0, delays, then falls offscreen
Projectile_ZLeoDropProjectileMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_534AC
                move.w  #1,(word_FF9500).w
                move.l  $56(a5),d0
                add.l   d0,$10(a5)
                move.w  4(a5),d0
                bne.s   loc_534E0
                subi.w  #$20,$14(a5) ; ' '
                cmpi.w  #$F0,$14(a5)
                bpl.s   locret_534FE
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
                move.w  #$10,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_534E0:                              ; CODE XREF: Projectile_ZLeoDropProjectileMain+12   j
                cmpi.w  #4,d0
                beq.s   loc_534F0
                subq.w  #1,$4A(a5)
                bpl.s   locret_534FE
                addq.w  #2,4(a5)
loc_534F0:                              ; CODE XREF: Projectile_ZLeoDropProjectileMain+38   j
                subi.w  #$20,$14(a5) ; ' '
                bpl.s   locret_534FE
                bset    #4,2(a5)
locret_534FE:                           ; CODE XREF: Projectile_ZLeoDropProjectileMain+20   j
                                        ; Projectile_ZLeoDropProjectileMain+3E   j ...
                rts
; End of function Projectile_ZLeoDropProjectileMain
; Main dispatcher for Valkirie Force boss using state-based jumptable
Boss_ValkirieForceMain:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_53500
                tst.w   4(a5)
                beq.w   loc_53514
                tst.w   8(a5)
                beq.s   loc_53514
                jsr (Gfx_InitPaletteFade).l
loc_53514:                              ; CODE XREF: Boss_ValkirieForceMain+4   j
                                        ; Boss_ValkirieForceMain+C   j
                move.w  4(a5),d0
                movea.w off_53524(pc,d0.w),a0
                adda.l  #Boss_ValkirieForceInit,a0
                jmp     (a0)
; End of function Boss_ValkirieForceMain
; ---------------------------------------------------------------------------
off_53524:      dc.w Boss_ValkirieForceInit-Boss_ValkirieForceInit
                                        ; DATA XREF: Boss_ValkirieForceMain+18   r
                dc.w Boss_Sirene_State2-Boss_ValkirieForceInit


; Initializes Valkirie Force boss with metasprite setup and handles player rotation input
Boss_ValkirieForceInit:                              ; DATA XREF: Boss_ValkirieForceMain+1C   o  ; was: sub_53528
                                        ; ROM:off_53524   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #dword_355A4,a0
                movea.l #dword_355A4,a1
                movea.l #dword_355A4,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.w  #$3FC,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Sirene boss aiming phase
Boss_Sirene_State2:                              ; DATA XREF: ROM:00053526   o  ; was: loc_5358A
                btst    #2,(word_FFF706).w
                beq.s   loc_53596
                addq.w  #2,$56(a5)
loc_53596:                              ; CODE XREF: Boss_ValkirieForceInit+68   j
                btst    #3,(word_FFF706).w
                beq.s   loc_535A2
                subq.w  #2,$56(a5)
loc_535A2:                              ; CODE XREF: Boss_ValkirieForceInit+74   j
                andi.w  #$1FE,$56(a5)
                lea     word_5377A(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_535B2:                              ; CODE XREF: Boss_ValkirieForceInit+86   j
                bsr.w Boss_ValkirieForceAnimUpdate
                moveq   #$19,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieForceInit
; Updates boss animation sequence with interpolation and applies rotation angles to all segments
