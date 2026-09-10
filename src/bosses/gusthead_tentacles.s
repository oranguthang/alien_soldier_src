Boss_GustheadDetachedSegmentInit:                       ; DATA XREF: ROM:Boss_GustheadDetachedSegmentStates   o  ; was: sub_40132
                addq.w  #2,4(a5)
                ori.w   #$100,2(a5)
                lea     (Math_SineTable).l,a1
                move.w  $4E(a5),d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d1
                move.w  -$80(a1,d0.w),d2
                ext.l   d1
                lsl.l   #2,d1
                move.l  d1,$18(a5)
                ext.l   d2
                lsl.l   #3,d2
                tst.l   d2
                bmi.s   Boss_GustheadStoreDetachedSegmentVerticalVelocity
                neg.l   d2
Boss_GustheadStoreDetachedSegmentVerticalVelocity:      ; CODE XREF: Boss_GustheadDetachedSegmentInit+2E   j  ; was: loc_40164
                move.l  d2,$1C(a5)
                rts
; End of function Boss_GustheadDetachedSegmentInit
; Applies gravity to a detached segment and converts it to the shared effect below the arena
Boss_GustheadDetachedSegmentFallState:                  ; DATA XREF: ROM:0004012E   o  ; was: sub_4016A
                addi.l  #$1000,$1C(a5)
                cmpi.w  #$150,$14(a5)
                blt.s   Boss_GustheadDetachedSegmentFallReturn
                clr.l   $1C(a5)
                clr.l   $18(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                move.l  #off_1A0E96,8(a5)
                move.w  #$4000,$E(a5)
Boss_GustheadDetachedSegmentFallReturn:                 ; CODE XREF: Boss_GustheadDetachedSegmentFallState+E   j  ; was: locret_40196
                rts
; End of function Boss_GustheadDetachedSegmentFallState
Boss_GustheadDetachedSegmentInactiveState:              ; DATA XREF: ROM:00040130   o  ; was: nullsub_81
                rts
; End of function Boss_GustheadDetachedSegmentInactiveState

; Spawns side debris while arena motion is active
Boss_GustheadSpawnScrollingDebris:                      ; CODE XREF: Boss_GustheadSweepOuterJointState+C   p  ; was: sub_4019A
                                        ; Boss_GustheadWaitForMiddleJointZeroState+C   p
                tst.l   (dword_FF9428).w
                beq.w   Boss_GustheadUpdateSegmentPositionsReturn
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   Boss_GustheadUpdateSegmentPositionsReturn
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Boss_GustheadUpdateSegmentPositionsReturn
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   Boss_GustheadSpawnScrollingDebrisObject
                move.w  #$D1,d0
                jsr     (Sound_PlaySFX).l
Boss_GustheadSpawnScrollingDebrisObject:                ; CODE XREF: Boss_GustheadSpawnScrollingDebris+26   j  ; was: loc_401CC
                move.w  #$1E4,(a0)
                move.l  #SharedCombatSpriteFrame35,8(a0)
                move.w  #$480,$E(a0)
                move.w  #$CC40,2(a0)
                move.b  #$7C,$20(a0)                    ; '|'
                move.w  #$100,$48(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                addi.w  #$F0,d0
                move.w  d0,$14(a0)
                move.l  (dword_FF9428).w,d0
                add.l   d0,d0
                move.l  d0,$18(a0)
                move.l  #$FFFFF000,$1C(a0)
                btst    #7,(dword_FF9428).w
                beq.s   Boss_GustheadUseLeftDebrisSpawnX
                move.w  #$1C4,$10(a0)
                rts
; ---------------------------------------------------------------------------
Boss_GustheadUseLeftDebrisSpawnX:                       ; CODE XREF: Boss_GustheadSpawnScrollingDebris+82   j  ; was: loc_40226
                move.w  #$7C,$10(a0)                    ; '|'
                rts
; End of function Boss_GustheadSpawnScrollingDebris
; Main handler for Gusthead debris
Enemy_GustheadDebrisMain:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4022E
                subq.w  #1,$48(a5)
                bmi.s   Enemy_GustheadDebrisRemove
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   Enemy_GustheadDebrisRemove
                cmpi.w  #$1E0,$10(a5)
                bhi.s   Enemy_GustheadDebrisRemove
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   Enemy_GustheadDebrisRemove
                cmpi.w  #$180,$14(a5)
                bhi.s   Enemy_GustheadDebrisRemove
                move.l  (dword_FF9428).w,d0
                beq.s   Enemy_GustheadDebrisApplyStrongGravity
                addq.b  #1,$4A(a5)
                btst    #0,$4A(a5)
                beq.s   Enemy_GustheadDebrisApplyDriftGravity
                add.l   d0,$18(a5)
Enemy_GustheadDebrisApplyDriftGravity:                  ; CODE XREF: Enemy_GustheadDebrisMain+36   j  ; was: loc_4026A
                addi.l  #$400,$1C(a5)
                bra.s   Enemy_GustheadDebrisStoreVerticalPosition
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisApplyStrongGravity:                 ; CODE XREF: Enemy_GustheadDebrisMain+2A   j  ; was: loc_40274
                addi.l  #$2000,$1C(a5)
Enemy_GustheadDebrisStoreVerticalPosition:              ; CODE XREF: Enemy_GustheadDebrisMain+44   j  ; was: loc_4027C
                move.l  $1C(a5),d0
                add.l   d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisRemove:                             ; CODE XREF: Enemy_GustheadDebrisMain+4   j  ; was: loc_40286
                                        ; Enemy_GustheadDebrisMain+C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisMain
; Spawns falling debris at the arena edge selected by scroll direction
Boss_GustheadSpawnEdgeDebris:                           ; CODE XREF: Boss_GustheadWaitForMiddleJointZeroState+18   p  ; was: sub_4028E
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   Boss_GustheadSpawnEdgeDebrisReturn
                tst.l   (dword_FF8240).w
                beq.s   Boss_GustheadSpawnEdgeDebrisReturn
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_GustheadSpawnEdgeDebrisReturn
                move.w  #$1E8,(a0)
                move.w  #$ED00,2(a0)
                bsr.w   Enemy_GustheadDebrisSetSprite
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #8,$26(a0)
                move.b  #$10,$20(a0)
                move.w  #$F0,$14(a0)
                tst.l   (dword_FF8240).w
                bmi.s   Boss_GustheadUseRightDebrisSpawnX
                move.w  #$78,$10(a0)                    ; 'x'
Boss_GustheadSpawnEdgeDebrisReturn:                     ; CODE XREF: Boss_GustheadSpawnEdgeDebris+8   j  ; was: locret_402EE
                                        ; Boss_GustheadSpawnEdgeDebris+E   j
                rts
; ---------------------------------------------------------------------------
Boss_GustheadUseRightDebrisSpawnX:                      ; CODE XREF: Boss_GustheadSpawnEdgeDebris+58   j  ; was: loc_402F0
                move.w  #$1C8,$10(a0)
                rts
; End of function Boss_GustheadSpawnEdgeDebris
; Sets random debris sprite
Enemy_GustheadDebrisSetSprite:                          ; CODE XREF: Boss_GustheadSpawnEdgeDebris+22   p  ; was: sub_402F8
                                        ; Boss_GustheadSpawnFourWayDebris+46   p
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  Enemy_GustheadDebrisMappings(pc,d0.w),8(a0)
                move.w  #$8000,$E(a0)
                rts
; End of function Enemy_GustheadDebrisSetSprite
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisMappings:   dc.l    off_1A0F1A      ; DATA XREF: Enemy_GustheadDebrisSetSprite+12   r  ; was: off_40318
                dc.l    off_1A0F42
                dc.l    off_1A0F2E
                dc.l    off_1A0F42

; Main physics handler for debris
Enemy_GustheadDebrisPhysicsMain:                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_40328
                tst.w   $24(a5)
                bmi.s   Enemy_GustheadDebrisBeginPickupRelease
                bclr    #7,$22(a5)
                beq.s   Enemy_GustheadDebrisDispatchState
                bclr    #4,$22(a5)
                beq.s   Enemy_GustheadDebrisConvertToEffect
Enemy_GustheadDebrisBeginPickupRelease:                 ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+4   j  ; was: loc_4033E
                bra.w   Enemy_GustheadDebrisReleasePickup
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisConvertToEffect:                    ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+14   j  ; was: loc_40342
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #SharedCombatSpriteAnimation05,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisDispatchState:                      ; CODE XREF: Enemy_GustheadDebrisPhysicsMain+C   j  ; was: loc_40358
                move.w  4(a5),d0
                lea     Enemy_GustheadDebrisStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_GustheadDebrisPhysicsMain
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisStates: dc.w    Enemy_GustheadDebrisInit-*  ; DATA XREF: Enemy_GustheadDebrisPhysicsMain+34   o  ; was: off_40364
                dc.w    Enemy_GustheadDebrisUpdate-*
                dc.w    Enemy_GustheadDebrisInactiveState-*

; Initializes debris with velocity
Enemy_GustheadDebrisInit:                               ; DATA XREF: ROM:Enemy_GustheadDebrisStates   o  ; was: sub_4036A
                addq.w  #2,4(a5)
                move.l  (dword_FF8240).w,d0
                add.l   d0,d0
                add.l   d0,d0
                tst.w   (word_FFFF0E).w
                bne.s   Enemy_GustheadDebrisStoreHorizontalDrift
                add.l   d0,d0
Enemy_GustheadDebrisStoreHorizontalDrift:               ; CODE XREF: Enemy_GustheadDebrisInit+10   j  ; was: loc_4037E
                move.l  d0,$18(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FFF,d0
                subi.w  #$800,d0
                ext.l   d0
                move.l  d0,$4C(a5)
                rts
; End of function Enemy_GustheadDebrisInit
; Updates debris position with gravity
Enemy_GustheadDebrisUpdate:                             ; DATA XREF: ROM:00040366   o  ; was: sub_40396
                bsr.w   Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   Enemy_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$1E0,$10(a5)
                bhi.s   Enemy_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   Enemy_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$180,$14(a5)
                bhi.s   Enemy_GustheadDebrisRemoveOutOfBounds
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
                btst    #7,$1C(a5)
                beq.w   Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisRemoveOutOfBounds:                  ; CODE XREF: Enemy_GustheadDebrisUpdate+A   j  ; was: loc_403CE
                                        ; Enemy_GustheadDebrisUpdate+12   j
                bset    #4,2(a5)
                rts
; End of function Enemy_GustheadDebrisUpdate
Enemy_GustheadDebrisInactiveState:                      ; DATA XREF: ROM:00040368   o  ; was: nullsub_82
                rts
; End of function Enemy_GustheadDebrisInactiveState

; Flips debris sprite based on velocity
Enemy_GustheadDebrisFlip:                               ; CODE XREF: Enemy_GustheadDebrisUpdate   p  ; was: sub_403D8
                                        ; sub_4046C:Boss_GustheadDebrisApplyPhysics   p
                btst    #7,$1C(a5)
                bne.s   Enemy_GustheadDebrisClearVerticalFlip
                ori.w   #$1000,$E(a5)
                rts
; ---------------------------------------------------------------------------
Enemy_GustheadDebrisClearVerticalFlip:                  ; CODE XREF: Enemy_GustheadDebrisFlip+6   j  ; was: loc_403E8
                andi.w  #$EFFF,$E(a5)
                rts
; End of function Enemy_GustheadDebrisFlip
; Spawns 4 debris projectiles with trajectories from angle table
Boss_GustheadSpawnFourWayDebris:                        ; CODE XREF: Boss_GustheadBouncePatternState+2A   p  ; was: sub_403F0
                lea     (Math_SineTable).l,a1
                move.w  #3,d7
                move.w  #$120,d6
Boss_GustheadFourWayDebrisLoop:                         ; CODE XREF: Boss_GustheadSpawnFourWayDebris+76   j  ; was: loc_403FE
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_GustheadFourWayDebrisReturn
                move.w  (a1,d6.w),d0
                ext.l   d0
                asl.l   #4,d0
                move.l  d0,$18(a0)
                move.l  #$FFFA0000,$1C(a0)
                move.w  #$214,(a0)
                move.w  #$ED40,2(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                addi.w  #$10,$14(a0)
                bsr.w   Enemy_GustheadDebrisSetSprite
                move.b  #$10,$20(a0)
                move.b  #$C0,$21(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.w  #$10,$26(a0)
                addi.w  #$40,d6                         ; '@'
                dbf     d7,Boss_GustheadFourWayDebrisLoop
Boss_GustheadFourWayDebrisReturn:                       ; CODE XREF: Boss_GustheadSpawnFourWayDebris+14   j  ; was: locret_4046A
                rts
; End of function Boss_GustheadSpawnFourWayDebris
; Updates debris physics with gravity, boundary checks, and collision detection
Boss_GustheadDebrisUpdate:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4046C
                tst.w   $24(a5)
                bmi.s   Boss_GustheadDebrisReleasePickup
                bclr    #7,$22(a5)
                beq.s   Boss_GustheadDebrisApplyPhysics
                bclr    #4,$22(a5)
                beq.s   Boss_GustheadDebrisConvertToEffect
Boss_GustheadDebrisReleasePickup:                       ; CODE XREF: Boss_GustheadDebrisUpdate+4   j  ; was: loc_40482
                bra.w   Enemy_GustheadDebrisReleasePickup
; ---------------------------------------------------------------------------
Boss_GustheadDebrisConvertToEffect:                     ; CODE XREF: Boss_GustheadDebrisUpdate+14   j  ; was: loc_40486
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #SharedCombatSpriteAnimation05,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
Boss_GustheadDebrisApplyPhysics:                        ; CODE XREF: Boss_GustheadDebrisUpdate+C   j  ; was: loc_4049C
                bsr.w   Enemy_GustheadDebrisFlip
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   Boss_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$1E0,$10(a5)
                bhi.s   Boss_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   Boss_GustheadDebrisRemoveOutOfBounds
                cmpi.w  #$180,$14(a5)
                bhi.s   Boss_GustheadDebrisRemoveOutOfBounds
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                beq.w   Boss_GustheadDebrisGroundBounce
                rts
; ---------------------------------------------------------------------------
Boss_GustheadDebrisRemoveOutOfBounds:                   ; CODE XREF: Boss_GustheadDebrisUpdate+3A   j  ; was: loc_404D4
                                        ; Boss_GustheadDebrisUpdate+42   j
                bset    #4,2(a5)
                rts
; End of function Boss_GustheadDebrisUpdate
; Clears debris velocity and resets animation state
Enemy_GustheadDebrisConvertCurrentToEffect:             ; was: sub_404DC
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #SharedCombatSpriteAnimation05,8(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Enemy_GustheadDebrisConvertCurrentToEffect
; Checks ground collision and applies upward bounce velocity to debris
Boss_GustheadDebrisGroundBounce:                        ; CODE XREF: Enemy_GustheadDebrisUpdate+32   j  ; was: sub_404F2
                                        ; Boss_GustheadDebrisUpdate+62   j
                cmpi.w  #$150,$14(a5)
                blt.s   Boss_GustheadDebrisGroundBounceReturn
                move.l  #off_1A0E96,8(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                move.w  #$C000,$E(a5)
                move.l  #$FFFD8000,$1C(a5)
                clr.w   $18(a5)
Boss_GustheadDebrisGroundBounceReturn:                  ; CODE XREF: Boss_GustheadDebrisGroundBounce+6   j  ; was: locret_4051A
                rts
; End of function Boss_GustheadDebrisGroundBounce
; Updates boss rotation animation
Boss_GustheadUpdateSegmentMapping:                      ; CODE XREF: Boss_GustheadSegmentMain+A2   p  ; was: sub_4051C
                movea.w a5,a0
                clr.w   d0
                move.b  $20(a0),d0
                addi.w  #2,d0
                andi.w  #$7F,d0
                subi.w  #$20,d0                         ; ' '
                andi.w  #$3C,d0                         ; '<'
                move.l  Boss_GustheadSegmentMappings(pc,d0.w),8(a0)
                clr.w   $C(a0)
                lsr.w   #1,d0
                lea     (word_FF9502).w,a1
                addq.w  #1,(a1,d0.w)
                rts
; End of function Boss_GustheadUpdateSegmentMapping
; ---------------------------------------------------------------------------
Boss_GustheadSegmentMappings:   dc.l    word_EC010      ; DATA XREF: Boss_GustheadUpdateSegmentMapping+18   r  ; was: off_4054A
                dc.l    word_EC010
                dc.l    word_EC010
                dc.l    word_EC016
                dc.l    word_EC016
                dc.l    word_EC01C
                dc.l    word_EC01C
                dc.l    word_EC022
                dc.l    word_EC022
                dc.l    word_EC028
                dc.l    word_EC028
                dc.l    word_EC02E
                dc.l    word_EC02E
                dc.l    word_EC034
                dc.l    word_EC034
                dc.l    word_EC034

; Derives arena scroll velocity from the active joint speed
Boss_GustheadUpdateArenaScrollVelocity:                 ; CODE XREF: Boss_GustheadSweepOuterJointState+8   p  ; was: sub_4058A
                                        ; Boss_GustheadWaitForMiddleJointZeroState+8   p
                move.l  (dword_FF940C).w,d0
                bne.s   Boss_GustheadScaleArenaScrollVelocity
                move.l  (dword_FF9414).w,d0
                beq.s   Boss_GustheadStoreArenaScrollVelocity
Boss_GustheadScaleArenaScrollVelocity:                  ; CODE XREF: Boss_GustheadUpdateArenaScrollVelocity+4   j  ; was: loc_40596
                tst.w   (word_FFFF0E).w
                bne.s   Boss_GustheadUseFullArenaScrollVelocity
                asr.l   #5,d0
                bra.s   Boss_GustheadStoreArenaScrollVelocity
; ---------------------------------------------------------------------------
Boss_GustheadUseFullArenaScrollVelocity:                ; CODE XREF: Boss_GustheadUpdateArenaScrollVelocity+10   j  ; was: loc_405A0
                asr.l   #4,d0
Boss_GustheadStoreArenaScrollVelocity:                  ; CODE XREF: Boss_GustheadUpdateArenaScrollVelocity+A   j  ; was: loc_405A2
                                        ; Boss_GustheadUpdateArenaScrollVelocity+14   j
                move.l  d0,(dword_FF8240).w
                rts
; End of function Boss_GustheadUpdateArenaScrollVelocity
; Advances the three shared fixed-point joint angles
Boss_GustheadAdvanceJointAngles:                        ; CODE XREF: Boss_GustheadIntroReveal+48   p  ; was: sub_405A8
                                        ; Boss_GustheadBattleStart+20   p
                tst.l   (dword_FF940C).w
                beq.s   Boss_GustheadAdvanceMiddleJoint
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9400).w
Boss_GustheadAdvanceMiddleJoint:                        ; CODE XREF: Boss_GustheadAdvanceJointAngles+4   j  ; was: loc_405BC
                tst.l   (dword_FF9410).w
                beq.s   Boss_GustheadAdvanceInnerJoint
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9404).w
                andi.w  #$1FF,(dword_FF9404).w
Boss_GustheadAdvanceInnerJoint:                         ; CODE XREF: Boss_GustheadAdvanceJointAngles+18   j  ; was: loc_405D0
                tst.l   (dword_FF9414).w
                beq.s   Boss_GustheadAdvanceJointAnglesReturn
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9408).w
                andi.w  #$1FF,(dword_FF9408).w
Boss_GustheadAdvanceJointAnglesReturn:                  ; CODE XREF: Boss_GustheadAdvanceJointAngles+2C   j  ; was: locret_405E4
                rts
; End of function Boss_GustheadAdvanceJointAngles
; Sets the first arm's four segment state words to zero
Boss_GustheadDisableFirstArmSegments:                   ; was: sub_405E6
                clr.w   d0
                bra.s   Boss_GustheadStoreFirstArmSegmentState
; End of function Boss_GustheadDisableFirstArmSegments
; Sets the first arm's four segment state words to two
Boss_GustheadEnableFirstArmSegments:                    ; was: sub_405EA
                move.w  #2,d0
Boss_GustheadStoreFirstArmSegmentState:                 ; CODE XREF: Boss_GustheadDisableFirstArmSegments+2   j  ; was: loc_405EE
                move.w  #3,d7
                movea.l (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
Boss_GustheadFirstArmSegmentStateLoop:                  ; CODE XREF: Boss_GustheadEnableFirstArmSegments+18   j  ; was: loc_405FA
                move.w  d0,4(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_GustheadFirstArmSegmentStateLoop
                rts
; End of function Boss_GustheadEnableFirstArmSegments
; Seeds the first arm's segment joint-angle fields from the shared angles
Boss_GustheadSeedFirstArmJointAngles:                   ; was: sub_40608
                move.w  #3,d7
                movea.w (Entity_ObjectPool).w,a0
                lea     $60(a0),a0
Boss_GustheadSeedFirstArmJointAngleLoop:                ; CODE XREF: Boss_GustheadSeedFirstArmJointAngles+4C   j  ; was: loc_40614
                clr.w   d0
                move.b  $4B(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9400).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$4E(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9404).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$50(a0)
                clr.w   d0
                move.b  $4C(a0),d0
                add.w   d0,d0
                add.w   (dword_FF9408).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$52(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_GustheadSeedFirstArmJointAngleLoop
                rts
; End of function Boss_GustheadSeedFirstArmJointAngles
; Recomputes all four arms of four linked segment positions
Boss_GustheadUpdateSegmentPositions:                    ; CODE XREF: Boss_GustheadIntroReveal+4C   p  ; was: sub_4065A
                                        ; Boss_GustheadBattleStart+24   p
                move.l  $10(a5),$670(a5)
                move.l  $14(a5),$674(a5)
                addi.w  #$1A,$670(a5)
                addi.w  #-6,$674(a5)
                move.w  #4,$5C(a5)
                movea.w a5,a0
                lea     $60(a0),a0
Boss_GustheadUpdateArmLoop:                             ; CODE XREF: Boss_GustheadUpdateSegmentPositions+10E   j  ; was: loc_4067E
                move.w  #3,d0
                movea.w a5,a1
Boss_GustheadUpdateSegmentLoop:                         ; CODE XREF: Boss_GustheadUpdateSegmentPositions+106   j  ; was: loc_40684
                lea     (Math_SineTable).l,a2
                move.w  $48(a0),d4
                move.w  $4E(a0),d5
                move.w  $50(a0),d6
                move.w  $52(a0),d7
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                move.w  -$80(a2,d5.w),d1
                muls.w  d4,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  (a2,d6.w),d2
                muls.w  d2,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                asr.w   #2,d1
                cmpi.w  #$3F,d1                         ; '?'
                blt.s   Boss_GustheadClampSegmentFrameMinimum
                move.w  #$3F,d1                         ; '?'
                bra.s   Boss_GustheadStoreSegmentFrame
; ---------------------------------------------------------------------------
Boss_GustheadClampSegmentFrameMinimum:                  ; CODE XREF: Boss_GustheadUpdateSegmentPositions+6A   j  ; was: loc_406CC
                cmpi.w  #$FFC1,d1
                bgt.s   Boss_GustheadStoreSegmentFrame
                move.w  #$FFC1,d1
Boss_GustheadStoreSegmentFrame:                         ; CODE XREF: Boss_GustheadUpdateSegmentPositions+70   j  ; was: loc_406D6
                                        ; Boss_GustheadUpdateSegmentPositions+76   j
                clr.w   d2
                move.b  $20(a1),d2
                add.w   d2,d1
                move.b  d1,$20(a0)
                move.w  (a2,d5.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  -$80(a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                sub.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $10(a1),d3
                move.l  d3,$10(a0)
                move.w  (a2,d5.w),d1
                move.w  -$80(a2,d7.w),d2
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                move.l  d2,d3
                move.w  -$80(a2,d5.w),d1
                move.w  -$80(a2,d6.w),d2
                muls.w  d1,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                move.w  (a2,d7.w),d1
                muls.w  d1,d2
                add.l   d2,d2
                add.l   d2,d2
                add.l   d2,d3
                swap    d3
                muls.w  d4,d3
                add.l   d3,d3
                add.l   d3,d3
                add.l   $14(a1),d3
                move.l  d3,$14(a0)
                lea     (a0),a1
                lea     $60(a0),a0
                dbf     d0,Boss_GustheadUpdateSegmentLoop
                subq.w  #1,$5C(a5)
                bne.w   Boss_GustheadUpdateArmLoop
Boss_GustheadUpdateSegmentPositionsReturn:              ; CODE XREF: Boss_GustheadInitBattle+4   j  ; was: locret_4076C
                                        ; Boss_GustheadBeginOscillationPattern+56   j
                rts
; End of function Boss_GustheadUpdateSegmentPositions
; Converts Gusthead debris to a pickup, optionally spawning a shared effect
Enemy_GustheadDebrisReleasePickup:                      ; CODE XREF: Enemy_GustheadDebrisPhysicsMain:Enemy_GustheadDebrisBeginPickupRelease   j  ; was: sub_4076E
                                        ; sub_4046C:Boss_GustheadDebrisReleasePickup   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Enemy_GustheadSpawnPickupFromDebris
                jsr     (Projectile_InitType88).l
                move.l  #SharedCombatSpriteAnimation05,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
Enemy_GustheadSpawnPickupFromDebris:                    ; CODE XREF: Enemy_GustheadDebrisReleasePickup+E   j  ; was: loc_40798
                jmp     Pickup_SpawnSmallFromCurrentObject
; End of function Enemy_GustheadDebrisReleasePickup
; Main handler for Snake boss
