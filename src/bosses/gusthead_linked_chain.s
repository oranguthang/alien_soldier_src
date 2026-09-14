; Gusthead's linked eight-segment attack object
; Type $390 owns the chain, type $394 updates ordinary segments, and type $398
; updates the damageable terminal segment and scatters the chain when it is hit
Boss_GustheadLinkedChainControllerMain:                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_310E6
                bsr.w   Boss_GustheadLinkedChainCullAtLeftEdge
                move.w  4(a5),d0
                lea     Boss_GustheadLinkedChainControllerStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadLinkedChainControllerMain
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainControllerStates:   dc.w    Boss_GustheadLinkedChainControllerInit-*  ; DATA XREF: Boss_GustheadLinkedChainControllerMain+8   o  ; was: off_310F6
                dc.w    Boss_GustheadLinkedChainSpawnSegments-*
                dc.w    Boss_GustheadLinkedChainControllerIdle-*

; Initializes the invisible chain controller
Boss_GustheadLinkedChainControllerInit:                 ; DATA XREF: ROM:Boss_GustheadLinkedChainControllerStates   o  ; was: sub_310FC
                move.w  #$D00,2(a5)
                move.b  #$50,$20(a5)                    ; 'P'
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainControllerInit
; Allocates and links eight segments, promoting the last one to type $398
Boss_GustheadLinkedChainSpawnSegments:                  ; DATA XREF: ROM:000310F8   o  ; was: sub_3110E
                cmpi.w  #$180,$10(a5)
                bcc.w   Entity_UpdateReturn
                move.w  #7,d7
                move.w  a5,$44(a5)
Boss_GustheadLinkedChainSpawnNextSegment:               ; CODE XREF: Boss_GustheadLinkedChainSpawnSegments+44   j  ; was: loc_31120
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   Boss_GustheadLinkedChainHandleAllocationFailure
                movea.w $44(a5),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                move.w  #$394,(a0)
                move.w  d7,d1
                lsl.w   #3,d1
                addq.w  #1,d1
                move.w  d1,$46(a0)
                clr.w   4(a0)
                move.w  a1,$44(a0)
                move.w  a0,$44(a5)
                dbf     d7,Boss_GustheadLinkedChainSpawnNextSegment
                move.w  #$398,(a0)
                move.w  a5,$48(a0)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainHandleAllocationFailure:        ; CODE XREF: Boss_GustheadLinkedChainSpawnSegments+18   j  ; was: loc_31164
                move.w  #$1000,2(a5)
                rts
; End of function Boss_GustheadLinkedChainSpawnSegments
Boss_GustheadLinkedChainControllerIdle:                 ; DATA XREF: ROM:000310FA   o  ; was: nullsub_74
                rts
; End of function Boss_GustheadLinkedChainControllerIdle

; Marks every linked segment for removal after the controller crosses the left edge
Boss_GustheadLinkedChainCullAtLeftEdge:                 ; CODE XREF: Boss_GustheadLinkedChainControllerMain   p  ; was: sub_3116E
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcc.w   Entity_UpdateReturn
                movea.w a5,a4
                move.w  #7,d7
Boss_GustheadLinkedChainCullNextSegment:                ; CODE XREF: Boss_GustheadLinkedChainCullAtLeftEdge:Boss_GustheadLinkedChainContinueCull   j  ; was: loc_3117E
                tst.w   $44(a4)
                beq.s   Boss_GustheadLinkedChainContinueCull
                movea.w $44(a4),a4
                move.w  #$1000,2(a4)
Boss_GustheadLinkedChainContinueCull:                   ; CODE XREF: Boss_GustheadLinkedChainCullAtLeftEdge+14   j  ; was: loc_3118E
                dbf     d7,Boss_GustheadLinkedChainCullNextSegment
                rts
; End of function Boss_GustheadLinkedChainCullAtLeftEdge
; Dispatches an ordinary type-$394 chain segment
Boss_GustheadLinkedChainSegmentMain:                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_31194
                move.w  4(a5),d0
                lea     Boss_GustheadLinkedChainSegmentStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadLinkedChainSegmentMain
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainSegmentStates:  dc.w    Boss_GustheadLinkedChainSegmentInit-*  ; DATA XREF: Boss_GustheadLinkedChainSegmentMain+4   o  ; was: off_311A0
                dc.w    Boss_GustheadLinkedChainBeginAttackCycle-*
                dc.w    Boss_GustheadLinkedChainExpandRadiusAndFire-*
                dc.w    Boss_GustheadLinkedChainSweepAngleBackward-*
                dc.w    Boss_GustheadLinkedChainSweepAngleForward-*
                dc.w    Boss_GustheadLinkedChainRetractRadius-*
                dc.w    Boss_GustheadLinkedChainSegmentFallAndFire-*

; Initializes an ordinary chain segment
Boss_GustheadLinkedChainSegmentInit:                    ; DATA XREF: ROM:Boss_GustheadLinkedChainSegmentStates   o  ; was: sub_311AE
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #Boss_GustheadLinkedChainSegmentMapping,8(a5)
                move.b  #$60,$20(a5)                    ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainSegmentInit
; Counts down the segment delay, then begins its polar attack cycle
Boss_GustheadLinkedChainBeginAttackCycle:               ; DATA XREF: ROM:000311A2   o  ; was: sub_311CE
                bsr.w   Entity_UpdatePolarPositionFromParent
                subq.w  #1,$46(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.w  #4,4(a5)
Boss_GustheadLinkedChainFireRandomShot:                 ; CODE XREF: Boss_GustheadLinkedChainTerminalBeginAttackCycle+26   j  ; was: loc_311EA
                                        ; Boss_GustheadLinkedChainTryRandomShot+8   j
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                move.w  d0,d4
                move.w  $10(a5),d5
                move.w  #$148,d6
                jmp     Projectile_SpawnType1A8AtAngle
; End of function Boss_GustheadLinkedChainBeginAttackCycle
; Starts the terminal segment's attack cycle and plays its cue
Boss_GustheadLinkedChainTerminalBeginAttackCycle:       ; DATA XREF: ROM:000313B6   o  ; was: sub_31208
                bsr.w   Entity_UpdatePolarPositionFromParent
                subq.w  #1,$46(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$180,$40(a5)
                clr.w   $42(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                move.w  #4,4(a5)
                bra.w   Boss_GustheadLinkedChainFireRandomShot
; End of function Boss_GustheadLinkedChainTerminalBeginAttackCycle
; Expands the polar radius while periodically firing a random-angle shot
Boss_GustheadLinkedChainExpandRadiusAndFire:            ; DATA XREF: ROM:000311A4   o  ; was: sub_31232
                                        ; ROM:000313B8   o
                bsr.w   Entity_UpdatePolarPositionFromParent
                bsr.w   Boss_GustheadLinkedChainTryRandomShot
                addq.w  #8,$42(a5)
                cmpi.w  #$40,$42(a5)                    ; '@'
                bne.w   Entity_UpdateReturn
                move.w  #3,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainExpandRadiusAndFire
; Sweeps the polar angle backward from $180 to just below $140
Boss_GustheadLinkedChainSweepAngleBackward:             ; DATA XREF: ROM:000311A6   o  ; was: sub_31254
                                        ; ROM:000313BA   o
                bsr.w   Entity_UpdatePolarPositionFromParent
                subq.w  #2,$40(a5)
                cmpi.w  #$140,$40(a5)
                bcc.w   Entity_UpdateReturn
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainSweepAngleBackward
; Emits a fragment cluster when the polar angle reaches $19E
Boss_GustheadLinkedChainEmitFragmentClusterAtAngle:     ; was: sub_3126C
                cmpi.w  #$19E,$40(a5)
                bne.w   Entity_UpdateReturn
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                move.w  #2,d3
                move.w  (PlayerXPosition).w,d0
                cmp.w   $10(a5),d0
                bcs.s   Boss_GustheadLinkedChainAimFragmentClusterLeft
                clr.w   d4
                bra.w   Projectile_SpawnFragmentCluster
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainAimFragmentClusterLeft:         ; was: loc_31292
                move.w  #$10,d4
                bra.w   Projectile_SpawnFragmentCluster
; End of function Boss_GustheadLinkedChainEmitFragmentClusterAtAngle
; Runs the terminal segment's angle-gated fragment attack, then falls through
Boss_GustheadLinkedChainTerminalFragmentAttack:         ; DATA XREF: ROM:000313BC   o  ; was: sub_3129A
                bsr.w   Boss_GustheadLinkedChainEmitFragmentClusterAtAngle
; End of function Boss_GustheadLinkedChainTerminalFragmentAttack
; Sweeps the polar angle forward to $1A0, repeating the attack three times
Boss_GustheadLinkedChainSweepAngleForward:              ; DATA XREF: ROM:000311A8   o  ; was: sub_3129E
                bsr.w   Entity_UpdatePolarPositionFromParent
                addq.w  #2,$40(a5)
                cmpi.w  #$1A0,$40(a5)
                bcs.w   Entity_UpdateReturn
                subq.w  #1,$46(a5)
                beq.s   Boss_GustheadLinkedChainAdvanceAfterOrbit
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainAdvanceAfterOrbit:              ; CODE XREF: Boss_GustheadLinkedChainSweepAngleForward+16   j  ; was: loc_312BC
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainSweepAngleForward
; Retracts an ordinary segment's polar radius through its parent position
Boss_GustheadLinkedChainRetractRadius:                  ; DATA XREF: ROM:000311AA   o  ; was: sub_312C2
                bsr.w   Entity_UpdatePolarPositionFromParent
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   Entity_UpdateReturn
                move.w  #$C0,$46(a5)
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainRetractRadius
; Retracts the terminal segment while firing, then plays its cue
Boss_GustheadLinkedChainTerminalRetractAndFire:         ; DATA XREF: ROM:000313BE   o  ; was: sub_312E2
                bsr.w   Entity_UpdatePolarPositionFromParent
                bsr.w   Boss_GustheadLinkedChainTryRandomShot
                subq.w  #8,$42(a5)
                cmpi.w  #$FFF8,$42(a5)
                bne.w   Entity_UpdateReturn
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                move.w  #$C0,$46(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainTerminalRetractAndFire
; Fires the shared random-angle shot on one frame out of four
Boss_GustheadLinkedChainTryRandomShot:                  ; CODE XREF: Boss_GustheadLinkedChainExpandRadiusAndFire+4   p  ; was: sub_3130E
                                        ; Boss_GustheadLinkedChainTerminalRetractAndFire+4   p
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #3,d0
                beq.w   Boss_GustheadLinkedChainFireRandomShot
                rts
; End of function Boss_GustheadLinkedChainTryRandomShot
; Holds the terminal segment in place and fires until its timer reaches $A0
Boss_GustheadLinkedChainTerminalWaitAndFire:            ; DATA XREF: ROM:000313C0   o  ; was: sub_3131C
                bsr.w   Entity_UpdatePolarPositionFromParent
                bsr.w   Boss_GustheadLinkedChainTryRandomShot
                subq.w  #1,$46(a5)
                cmpi.w  #$A0,$46(a5)
                bne.w   Entity_UpdateReturn
                move.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainTerminalWaitAndFire
; Duplicate of Math_LookupSineCosinePair used by later enemy code
; In: d0.w = even angle-table offset. Out: d0.w = cosine, d1.w = sine
Math_LookupSineCosinePairDuplicate:                     ; CODE XREF: Stage18_SegmentedWormEmitParticle+42   p  ; was: sub_3133A
                                        ; Stage18_SegmentedWormGetRandomScatterVelocity+E   p
                lea     (Math_QuarterSineTable).l,a0
                move.w  (a0,d0.w),d1
                addi.w  #$80,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_LookupSineCosinePairDuplicate
; Updates the damageable terminal segment and scatters the chain when hit
Boss_GustheadLinkedChainTerminalMain:                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_31352
                cmpi.w  #$E,4(a5)
                bcc.w   Boss_GustheadLinkedChainDispatchTerminalState
                tst.w   $24(a5)
                bpl.w   Boss_GustheadLinkedChainDispatchTerminalState
                movea.w $48(a5),a4
                move.w  #7,d7
Boss_GustheadLinkedChainScatterNextSegment:             ; CODE XREF: Boss_GustheadLinkedChainTerminalMain+4A   j  ; was: loc_3136C
                movea.w $44(a4),a4
                move.w  #$C,4(a4)
                jsr     (RandomNumber).l
                andi.w  #$7E,d0                         ; '~'
                addi.w  #$140,d0
                bsr.w   Math_LookupSineCosinePairDuplicate
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                clr.b   $21(a4)
                dbf     d7,Boss_GustheadLinkedChainScatterNextSegment
                move.w  #$E,4(a5)
                rts
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainDispatchTerminalState:          ; CODE XREF: Boss_GustheadLinkedChainTerminalMain+6   j  ; was: loc_313A8
                                        ; Boss_GustheadLinkedChainTerminalMain+E   j
                move.w  4(a5),d0
                lea     Boss_GustheadLinkedChainTerminalStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_GustheadLinkedChainTerminalMain
; ---------------------------------------------------------------------------
Boss_GustheadLinkedChainTerminalStates: dc.w    Boss_GustheadLinkedChainTerminalInit-*  ; DATA XREF: Boss_GustheadLinkedChainTerminalMain+5A   o  ; was: off_313B4
                dc.w    Boss_GustheadLinkedChainTerminalBeginAttackCycle-*
                dc.w    Boss_GustheadLinkedChainExpandRadiusAndFire-*
                dc.w    Boss_GustheadLinkedChainSweepAngleBackward-*
                dc.w    Boss_GustheadLinkedChainTerminalFragmentAttack-*
                dc.w    Boss_GustheadLinkedChainTerminalRetractAndFire-*
                dc.w    Boss_GustheadLinkedChainTerminalWaitAndFire-*
                dc.w    Boss_GustheadLinkedChainTerminalFallAndFire-*

; Initializes the damageable terminal segment
Boss_GustheadLinkedChainTerminalInit:                   ; DATA XREF: ROM:Boss_GustheadLinkedChainTerminalStates   o  ; was: sub_313C4
                move.w  #$CD00,2(a5)
                move.w  #$1B9,$E(a5)
                move.l  #Boss_GustheadLinkedChainTerminalMapping,8(a5)
                move.b  #$5C,$20(a5)                    ; '\'
                move.w  #$64,$24(a5)                    ; 'd'
                move.b  #$C0,$21(a5)
                move.l  #$F010F010,$2C(a5)
                move.l  #$E818E818,$28(a5)
                clr.b   $22(a5)
                move.b  #5,$23(a5)
                move.w  #$28,$26(a5)                    ; '('
                addq.w  #2,4(a5)
                rts
; End of function Boss_GustheadLinkedChainTerminalInit
; Accelerates downward and spawns doubled-velocity projectiles every 4 frames until Y >= 1A0h
Boss_GustheadLinkedChainTerminalFallAndFire:            ; DATA XREF: ROM:000313C2   o  ; was: sub_31410
                addi.l  #$1800,$1C(a5)
                cmpi.w  #$1A0,$14(a5)
                bcc.w   Boss_GustheadLinkedChainRemoveSegment
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #3,d0
                bne.w   Entity_UpdateReturn
                jsr     (Projectile_FindFreeSlot).l
                bne.w   Entity_UpdateReturn
                bsr.w   Projectile_SpawnRandomAngleShot
                asl     $18(a4)
                asl     $1C(a4)
                rts
; End of function Boss_GustheadLinkedChainTerminalFallAndFire
; Accelerates downward slowly and spawns projectiles every 8 frames until Y >= 180h
Boss_GustheadLinkedChainSegmentFallAndFire:             ; DATA XREF: ROM:000311AC   o  ; was: sub_31446
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                bcc.s   Boss_GustheadLinkedChainRemoveSegment
                move.w  (VBlankFrameCounter).w,d0
                andi.w  #7,d0
                bne.w   Entity_UpdateReturn
                jsr     (Projectile_FindFreeSlot).l
                bne.w   Entity_UpdateReturn
; End of function Boss_GustheadLinkedChainSegmentFallAndFire
; Spawns projectile with sound BBh at calculated angle toward player with offset positioning
Projectile_SpawnRandomAngleShot:                        ; was: sub_3146C
                                        ; Boss_GustheadLinkedChainTerminalFallAndFire+28   p
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                move.l  #SharedCombatSpriteAnimation05,8(a0)
                jsr     (Projectile_InitType88).l
                movea.w a0,a4
                jsr     (RandomNumber).l
                andi.w  #$1FE,d0
                bsr.w   Math_LookupSineCosinePairDuplicate
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                asl.l   #2,d0
                add.l   $10(a5),d0
                move.l  d0,$10(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                asl.l   #2,d1
                add.l   $14(a5),d1
                move.l  d1,$14(a4)
                rts
; End of function Projectile_SpawnRandomAngleShot
; Marks a falling segment for removal
Boss_GustheadLinkedChainRemoveSegment:                  ; CODE XREF: Boss_GustheadLinkedChainTerminalFallAndFire+E   j  ; was: sub_314BA
                                        ; Boss_GustheadLinkedChainSegmentFallAndFire+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_GustheadLinkedChainRemoveSegment
