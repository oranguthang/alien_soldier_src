Boss_GustheadSpawnFragmentCluster:                      ; CODE XREF: Boss_GustheadInitDefeatBounce+4E   j  ; was: sub_3FA7C
                                        ; Boss_GustheadRiseAttack+4E   p
                tst.w   (word_FFFF0E).w
                beq.s   locret_3FAB0
                move.w  #2,d3
                move.w  $674(a5),d6
                move.w  $10(a5),d0
                sub.w   (word_FF8248).w,d0
                bmi.s   Boss_GustheadAimFragmentClusterRight
                move.w  #$10,d4
                move.w  $670(a5),d5
                subi.w  #$34,d5                         ; '4'
                bra.s   Boss_GustheadEmitFragmentCluster
; ---------------------------------------------------------------------------
Boss_GustheadAimFragmentClusterRight:
                move.w  #0,d4
                move.w  $670(a5),d5
Boss_GustheadEmitFragmentCluster:
                jsr     (Projectile_SpawnFragmentCluster).l
locret_3FAB0:                                           ; CODE XREF: Boss_GustheadSpawnFragmentCluster+4   j
                rts
; End of function Boss_GustheadSpawnFragmentCluster
; Gusthead boss attack state: updates tentacles/bounce, flips sprite, advances to next state
Boss_GustheadAttackSequence1:                           ; DATA XREF: ROM:0003F27A   o  ; was: sub_3FAB2
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FAD6
                eori.w  #$8000,2(a5)
loc_3FAD6:                                              ; CODE XREF: Boss_GustheadAttackSequence1+1C   j
                subq.w  #1,$48(a5)
                bne.s   locret_3FAEC
                move.w  #$20,$48(a5)                    ; ' '
                move.w  #$200,$14(a5)
                addq.w  #2,4(a5)
locret_3FAEC:                                           ; CODE XREF: Boss_GustheadAttackSequence1+28   j
                rts
; End of function Boss_GustheadAttackSequence1
; Gusthead boss repositions horizontally based on player position before next attack
Boss_GustheadRepositionAttack:                          ; DATA XREF: ROM:0003F27C   o  ; was: sub_3FAEE
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FB2C
                addq.w  #2,4(a5)
                move.w  #$1190,d0
                move.w  (dword_FFFF08).w,d1
                andi.w  #$FF,d1
                subi.w  #$80,d1
                add.w   d1,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$F0,$14(a5)
locret_3FB2C:                                           ; CODE XREF: Boss_GustheadRepositionAttack+18   j
                rts
; End of function Boss_GustheadRepositionAttack
; Gusthead boss scrolls camera upward while flipping sprite until scroll limit reached
Boss_GustheadScrollUp:                                  ; DATA XREF: ROM:0003F27E   o  ; was: sub_3FB2E
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FB52
                eori.w  #$8000,2(a5)
loc_3FB52:                                              ; CODE XREF: Boss_GustheadScrollUp+1C   j
                subi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$80000,(dword_FF940C).w
                bne.s   locret_3FB6E
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_3FB6E:                                           ; CODE XREF: Boss_GustheadScrollUp+34   j
                rts
; End of function Boss_GustheadScrollUp
; Gusthead boss rapidly flips sprite horizontally for visual effect
Boss_GustheadFlipSprite:                                ; DATA XREF: ROM:0003F280   o  ; was: sub_3FB70
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3FBA0
                ori.w   #$8000,2(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_3FBA0:                                           ; CODE XREF: Boss_GustheadFlipSprite+1E   j
                rts
; End of function Boss_GustheadFlipSprite
; Gusthead boss returns to idle state after attack sequence completes
Boss_GustheadReturnToIdle:                              ; DATA XREF: ROM:0003F282   o  ; was: sub_3FBA2
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FBC8
                move.b  #$50,$21(a5)                    ; 'P'
                move.w  #$10,4(a5)
locret_3FBC8:                                           ; CODE XREF: Boss_GustheadReturnToIdle+18   j
                rts
; End of function Boss_GustheadReturnToIdle
; Gusthead boss defeat sequence start: reduces scroll velocities and begins death animation
Boss_GustheadDefeatStart:                               ; CODE XREF: Boss_GustheadTentacleRetractAlt+C   j  ; was: sub_3FBCA
                                        ; DATA XREF: ROM:0003F284   o
                move.l  (dword_FF940C).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF940C).w
                move.l  (dword_FF9410).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF9410).w
                move.l  (dword_FF9414).w,d0
                asr.l   #2,d0
                move.l  d0,(dword_FF9414).w
                addq.w  #2,4(a5)
; Update tentacles and check for defeat state transition
Boss_GustheadDefeatStart_UpdateLoop:                    ; DATA XREF: ROM:0003F286   o  ; was: loc_3FBEC
                                        ; ROM:0003F288   o
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                addq.w  #2,(word_FF8234).w
                btst    #0,(byte_FF8260).w
                beq.s   locret_3FC18
                bclr    #6,$4A(a5)
                move.w  #$10,4(a5)
locret_3FC18:                                           ; CODE XREF: Boss_GustheadDefeatStart+40   j
                rts
; End of function Boss_GustheadDefeatStart
; Gusthead boss rises upward while flipping sprite and fires projectile at peak
Boss_GustheadRiseAttack:                                ; CODE XREF: Boss_GustheadTentacleExtendStart+16   j  ; was: sub_3FC1A
                                        ; DATA XREF: ROM:0003F28C   o
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Execute rising attack pattern with bounce and projectile
Boss_GustheadRiseAttack_UpdateLoop:                     ; DATA XREF: ROM:0003F28E   o  ; was: loc_3FC32
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                addi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$100000,(dword_FF940C).w
                bne.s   locret_3FC6C
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                jsr     Boss_GustheadSpawnFragmentCluster(pc)  ; (pc)
locret_3FC6C:                                           ; CODE XREF: Boss_GustheadRiseAttack+42   j
                rts
; End of function Boss_GustheadRiseAttack
; Gusthead boss attack state: flips sprite, waits for timer, advances to next state
Boss_GustheadAttackSequence2:                           ; DATA XREF: ROM:0003F290   o  ; was: sub_3FC6E
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FC92
                eori.w  #$8000,2(a5)
loc_3FC92:                                              ; CODE XREF: Boss_GustheadAttackSequence2+1C   j
                subq.w  #1,$48(a5)
                bne.s   locret_3FCA8
                move.w  #$80,$48(a5)
                move.w  #$200,$14(a5)
                addq.w  #2,4(a5)
locret_3FCA8:                                           ; CODE XREF: Boss_GustheadAttackSequence2+28   j
                rts
; End of function Boss_GustheadAttackSequence2
; Gusthead boss moves to specific screen position and advances state
Boss_GustheadMoveToPosition:                            ; DATA XREF: ROM:0003F292   o  ; was: sub_3FCAA
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FCD4
                move.w  #$198,$10(a5)
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
locret_3FCD4:                                           ; CODE XREF: Boss_GustheadMoveToPosition+18   j
                rts
; End of function Boss_GustheadMoveToPosition
; Gusthead boss scrolls camera downward while flipping sprite until scroll limit reached
Boss_GustheadScrollDown:                                ; DATA XREF: ROM:0003F294   o  ; was: sub_3FCD6
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3FCFA
                eori.w  #$8000,2(a5)
loc_3FCFA:                                              ; CODE XREF: Boss_GustheadScrollDown+1C   j
                subi.l  #$2000,(dword_FF940C).w
                cmpi.l  #$80000,(dword_FF940C).w
                bne.s   locret_3FD16
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_3FD16:                                           ; CODE XREF: Boss_GustheadScrollDown+34   j
                rts
; End of function Boss_GustheadScrollDown
; Gusthead boss rapidly flips sprite horizontally for visual effect variant
Boss_GustheadFlipSprite2:                               ; DATA XREF: ROM:0003F296   o  ; was: sub_3FD18
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_3FD48
                ori.w   #$8000,2(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_3FD48:                                           ; CODE XREF: Boss_GustheadFlipSprite2+1E   j
                rts
; End of function Boss_GustheadFlipSprite2
; Gusthead boss prepares for defeat sequence by setting health and animation values
Boss_GustheadPrepareDefeat:                             ; DATA XREF: ROM:0003F298   o  ; was: sub_3FD4A
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadUpdateScroll
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   Boss_GustheadUpdateBounce
                subq.w  #1,$48(a5)
                bne.s   locret_3FD74
                move.b  #$50,$21(a5)                    ; 'P'
                move.b  #$10,$23(a5)
                addq.w  #2,4(a5)
locret_3FD74:                                           ; CODE XREF: Boss_GustheadPrepareDefeat+18   j
                rts
; End of function Boss_GustheadPrepareDefeat
; Gusthead boss defeat: resets scroll positions and camera values to initial state
Boss_GustheadDefeatScrollReset:                         ; DATA XREF: ROM:0003F29A   o  ; was: sub_3FD76
                move.w  #6,$5A(a5)
                move.w  #$50,4(a5)                      ; 'P'
                bra.w   *+4
; ---------------------------------------------------------------------------
; Resets velocity and scroll values for defeat sequence
Boss_GustheadDefeat_ResetPhysics:                       ; CODE XREF: Boss_GustheadDefeatScrollReset+C   j  ; was: loc_3FD86
                                        ; DATA XREF: ROM:0003F29C   o
                addq.w  #2,4(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$4C(a5)
                clr.l   (dword_FF8240).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                andi.l  #$1F80000,(dword_FF9400).w
                andi.l  #$1F80000,(dword_FF9404).w
                andi.l  #$1F80000,(dword_FF9408).w
                move.w  #$F0,$14(a5)
                move.w  #$E,$24(a5)
; Retract tentacles while resetting scroll position
Boss_GustheadDefeatScrollReset_TentacleLoop:            ; DATA XREF: ROM:0003F29E   o  ; was: loc_3FDCE
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   loc_3F686
                subi.w  #8,(dword_FF9404).w
                andi.w  #$1F8,(dword_FF9404).w
                cmpi.w  #$1E0,(dword_FF9404).w
                bne.s   locret_3FDF2
                addq.w  #2,4(a5)
locret_3FDF2:                                           ; CODE XREF: Boss_GustheadDefeatScrollReset+76   j
                rts
; End of function Boss_GustheadDefeatScrollReset
; Gusthead boss defeat: sinks downward while adjusting camera scroll and palette
Boss_GustheadDefeatSink:                                ; DATA XREF: ROM:0003F2A0   o  ; was: sub_3FDF4
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                cmpi.l  #$1D000,(dword_FFA960).w
                beq.s   loc_3FE16
                addi.l  #$200,(dword_FFA960).w
loc_3FE16:                                              ; CODE XREF: Boss_GustheadDefeatSink+18   j
                move.b  #$88,$23(a5)
                subi.l  #$800,(dword_FF940C).w
                cmpi.l  #$FFF00000,(dword_FF940C).w
                bcs.s   locret_3FE3A
                move.l  #$FFF00000,(dword_FF940C).w
                addq.w  #2,4(a5)
locret_3FE3A:                                           ; CODE XREF: Boss_GustheadDefeatSink+38   j
                rts
; End of function Boss_GustheadDefeatSink
; Gusthead boss defeat: waits for camera animation to complete before next state
Boss_GustheadDefeatWaitCamera:                          ; DATA XREF: ROM:0003F2A2   o  ; was: sub_3FE3C
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                cmpi.l  #$1D000,(dword_FFA960).w
                beq.s   loc_3FE60
                addi.l  #$200,(dword_FFA960).w
                rts
; ---------------------------------------------------------------------------
loc_3FE60:                                              ; CODE XREF: Boss_GustheadDefeatWaitCamera+18   j
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatWaitCamera
; Gusthead boss rotates while firing projectiles based on camera rotation angle
Boss_GustheadRotateAttack:                              ; DATA XREF: ROM:0003F2A4   o  ; was: sub_3FE6C
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                move.w  (dword_FFA900).w,d1
                tst.w   (word_FFFF0E).w
                bne.s   loc_3FE8C
                addi.w  #$40,d1                         ; '@'
                bra.s   loc_3FE90
; ---------------------------------------------------------------------------
loc_3FE8C:                                              ; CODE XREF: Boss_GustheadRotateAttack+18   j
                subi.w  #$10,d1
loc_3FE90:                                              ; CODE XREF: Boss_GustheadRotateAttack+1E   j
                move.w  d1,d0
                andi.w  #$7E,d0                         ; '~'
                bne.s   locret_3FEAA
                addq.w  #2,4(a5)
                move.w  d1,d0
                andi.w  #$1FE,d0
                cmpi.w  #$100,d0
                beq.s   locret_3FEAA
                bra.s   loc_3FEAC
; ---------------------------------------------------------------------------
locret_3FEAA:                                           ; CODE XREF: Boss_GustheadRotateAttack+2A   j
                                        ; Boss_GustheadRotateAttack+3A   j
                rts
; ---------------------------------------------------------------------------
loc_3FEAC:                                              ; CODE XREF: Boss_GustheadRotateAttack+3C   j
                move.w  #2,d3
                move.w  #$10,d4
                move.w  $670(a5),d5
                subi.w  #$34,d5                         ; '4'
                move.w  $674(a5),d6
                jsr     (Projectile_SpawnFragmentCluster).l
                andi.w  #$FEFF,2(a0)
                rts
; End of function Boss_GustheadRotateAttack
; Gusthead boss waits for rotation to reach specific angle before reversing state
Boss_GustheadRotateWait:                                ; DATA XREF: ROM:0003F2A6   o  ; was: sub_3FECE
                bsr.w   Boss_GustheadUpdateTentacles
                bsr.w   Boss_GustheadUpdateTentacleAngles
                bsr.w   Boss_GustheadCoreDefeat
                bsr.w   loc_3F686
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                andi.w  #$7E,d0                         ; '~'
                beq.s   locret_3FEF0
                subq.w  #2,4(a5)
locret_3FEF0:                                           ; CODE XREF: Boss_GustheadRotateWait+1C   j
                rts
; End of function Boss_GustheadRotateWait
; Initializes defeat phase
Boss_GustheadDefeatInitPhase:                           ; DATA XREF: ROM:0003F2A8   o  ; was: sub_3FEF2
                clr.b   $21(a5)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatInitPhase
; Slows scroll during defeat
Boss_GustheadDefeatSlowScroll:                          ; DATA XREF: ROM:0003F2AA   o  ; was: sub_3FF00
                bsr.w   Boss_SpawnExplosionDebris
                cmpi.l  #$E800,(dword_FFA960).w
                bmi.s   loc_3FF18
                subi.l  #$200,(dword_FFA960).w
                rts
; ---------------------------------------------------------------------------
loc_3FF18:                                              ; CODE XREF: Boss_GustheadDefeatSlowScroll+C   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadDefeatSlowScroll
; Boss falling defeat animation
Boss_GustheadDefeatFall:                                ; DATA XREF: ROM:0003F2AC   o  ; was: sub_3FF1E
                addi.l  #$1000,$1C(a5)
                bsr.w   Boss_SpawnExplosionDebris
                eori.w  #$8000,2(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_3FF44
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.w   $48(a5)
locret_3FF44:                                           ; CODE XREF: Boss_GustheadDefeatFall+18   j
                rts
; End of function Boss_GustheadDefeatFall
; Spawns debris during boss explosion
Boss_SpawnExplosionDebris:                              ; CODE XREF: Boss_JetsripperDeathExplosion+12   p  ; was: sub_3FF46
                                        ; sub_3FF00   p
                jsr     (Gfx_UpdatePaletteFade).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                jsr     (Projectile_UpdateWithExplosionSound).l
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_3FFC2
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  #$FFFA,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$1F,d1
                subi.w  #$24,d0                         ; '$'
                subi.w  #$24,d1                         ; '$'
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_3FFC4(pc,d0.w),8(a0)
locret_3FFC2:                                           ; CODE XREF: Boss_SpawnExplosionDebris+1E   j
                rts
; End of function Boss_SpawnExplosionDebris
; ---------------------------------------------------------------------------
off_3FFC4:      dc.l    off_E953C                       ; DATA XREF: Boss_SpawnExplosionDebris+76   r
                dc.l    off_E95A4
                dc.l    off_E9560
                dc.l    off_E95C0
                dc.l    off_E9584
                dc.l    off_E95DC
                dc.l    off_E9584
                dc.l    off_E9604

; Stops scroll for defeat
Boss_GustheadDefeatStopScroll:                          ; DATA XREF: ROM:0003F2AE   o  ; was: sub_3FFE4
                bsr.s   Gfx_ApplyBossPaletteFade
                addq.w  #1,(dword_FF9424).w
                cmpi.w  #$F,(dword_FF9424).w
                bne.s   locret_3FFFC
                move.w  #4,(dword_FF9424+2).w
                addq.w  #2,4(a5)
locret_3FFFC:                                           ; CODE XREF: Boss_GustheadDefeatStopScroll+C   j
                rts
; End of function Boss_GustheadDefeatStopScroll
; Applies palette fade effect to boss using specific fade parameters
Gfx_ApplyBossPaletteFade:                               ; CODE XREF: Boss_GustheadDefeatStopScroll   p  ; was: sub_3FFFE
                                        ; sub_40018   p
                move.w  (dword_FF9424).w,d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Gfx_ApplyBossPaletteFade
; Checks if defeat sequence complete
Boss_GustheadDefeatCheck:                               ; DATA XREF: ROM:0003F2B0   o  ; was: sub_40018
                bsr.s   Gfx_ApplyBossPaletteFade
                subq.w  #1,(dword_FF9424+2).w
                bne.s   locret_40024
                addq.w  #2,4(a5)
locret_40024:                                           ; CODE XREF: Boss_GustheadDefeatCheck+6   j
                rts
; End of function Boss_GustheadDefeatCheck
; Exits defeat sequence
Boss_GustheadDefeatExit:                                ; DATA XREF: ROM:0003F2B2   o  ; was: sub_40026
                bsr.s   Gfx_ApplyBossPaletteFade
                subq.w  #1,(dword_FF9424).w
                bpl.s   locret_4003E
                addq.w  #2,4(a5)
                move.w  #$1B0,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
locret_4003E:                                           ; CODE XREF: Boss_GustheadDefeatExit+6   j
                rts
; End of function Boss_GustheadDefeatExit
; Waits during defeat sequence
Boss_GustheadDefeatWait:                                ; DATA XREF: ROM:0003F2B4   o  ; was: sub_40040
                tst.l   (dword_FFA960).w
                beq.s   loc_40054
                move.w  (dword_FFA900).w,d0
                andi.w  #$7F,d0
                bne.s   locret_4005E
                clr.l   (dword_FFA960).w
loc_40054:                                              ; CODE XREF: Boss_GustheadDefeatWait+4   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4005E:                                           ; CODE XREF: Boss_GustheadDefeatWait+E   j
                rts
; End of function Boss_GustheadDefeatWait
; Finalizes defeat and cleanup
Boss_GustheadDefeatFinalize:                            ; DATA XREF: ROM:0003F2B6   o  ; was: sub_40060
                subq.w  #1,$48(a5)
                bne.s   locret_4006E
                clr.w   (a5)
                bset    #4,2(a5)
locret_4006E:                                           ; CODE XREF: Boss_GustheadDefeatFinalize+4   j
                rts
; End of function Boss_GustheadDefeatFinalize
; Completes boss defeat
Boss_GustheadDefeatComplete:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40070
                btst    #7,(byte_FFC66A).w
                bne.w   loc_40118
                clr.w   d1
                clr.w   d2
                clr.w   d3
                move.w  (word_FFC622).w,d0
                andi.w  #$8000,d0
                andi.w  #$7FFF,2(a5)
                or.w    d0,2(a5)
                tst.b   $4A(a5)
                bne.s   loc_400C2
                move.b  $4B(a5),d1
                add.w   d1,d1
                add.w   (dword_FF9400).w,d1
                andi.w  #$1FF,d1
                move.w  d1,$4E(a5)
                asr.w   #1,d1
                move.w  (dword_FF9404).w,d2
                move.w  d2,$50(a5)
                asr.w   #1,d2
                move.w  (dword_FF9408).w,d3
                move.w  d3,$52(a5)
                asr.w   #1,d3
                bra.s   loc_400EC
; ---------------------------------------------------------------------------
loc_400C2:                                              ; CODE XREF: Boss_GustheadDefeatComplete+26   j
                movea.w a5,a0
                lea     -$60(a0),a0
                move.b  $57(a0),d1
                move.w  d1,$4E(a5)
                move.b  $5B(a0),d2
                move.w  d2,$50(a5)
                move.b  $5F(a0),d3
                move.w  d3,$52(a5)
                add.w   d1,$4E(a5)
                add.w   d2,$50(a5)
                add.w   d3,$52(a5)
loc_400EC:                                              ; CODE XREF: Boss_GustheadDefeatComplete+50   j
                lea     $54(a5),a1
                lea     $58(a5),a2
                lea     $5C(a5),a3
                move.w  #3,d7
loc_400FC:                                              ; CODE XREF: Boss_GustheadDefeatComplete+9E   j
                move.b  (a1),d4
                move.b  d1,(a1)+
                move.b  d4,d1
                move.b  (a2),d5
                move.b  d2,(a2)+
                move.b  d5,d2
                move.b  (a3),d6
                move.b  d3,(a3)+
                move.b  d6,d3
                dbf     d7,loc_400FC
                bsr.w   Boss_GustheadUpdateRotation
                rts
; ---------------------------------------------------------------------------
loc_40118:                                              ; CODE XREF: Boss_GustheadDefeatComplete+6   j
                move.l  (dword_FFA960).w,d0
                add.l   d0,$10(a5)
                move.w  4(a5),d0
                lea     off_4012C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadDefeatComplete
; ---------------------------------------------------------------------------
off_4012C:      dc.w    Boss_GustheadTentacleInit-*     ; DATA XREF: Boss_GustheadDefeatComplete+B4   o
                dc.w    Boss_GustheadBounceTransition-*
                dc.w    nullsub_81-*

; Initializes Gusthead tentacle projectile with calculated trajectory from sine table
