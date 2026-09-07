Gfx_UpdateMultipleScrollLayers:                         ; CODE XREF: Boss_DestroyerMK2ComponentUpdateMovement:loc_4B678   p  ; was: sub_4B68C
                add.w   (word_FFE6E0).w,d0
                move.w  #6,d7
loc_4B694:                                              ; CODE XREF: Gfx_UpdateMultipleScrollLayers+1A   j
                move.w  d0,(a0)
                move.w  d0,4(a0)
                move.w  d0,8(a0)
                move.w  d0,$C(a0)
                lea     $10(a0),a0
                dbf     d7,loc_4B694
                rts
; End of function Gfx_UpdateMultipleScrollLayers
; Changes component animation after delay
Boss_DestroyerMK2ComponentSwitchAnimation:              ; DATA XREF: ROM:0004B4A8   o  ; was: sub_4B6AC
                subq.w  #1,$48(a5)
                bne.s   locret_4B6C4
                move.l  #word_EC2AA,8(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4B6C4:                                           ; CODE XREF: Boss_DestroyerMK2ComponentSwitchAnimation+4   j
                rts
; End of function Boss_DestroyerMK2ComponentSwitchAnimation
; Decrements timer and advances state when expired
Enemy_DecrementTimerAndAdvanceState:                    ; DATA XREF: ROM:0004B4AA   o  ; was: sub_4B6C6
                subq.w  #1,$48(a5)
                bne.s   locret_4B6D0
                addq.w  #2,4(a5)
locret_4B6D0:                                           ; CODE XREF: Enemy_DecrementTimerAndAdvanceState+4   j
                rts
; End of function Enemy_DecrementTimerAndAdvanceState
; Checks scroll flag and dispatches to handler
Enemy_CheckScrollFlagAndDispatch:                       ; DATA XREF: ROM:0004B4AC   o  ; was: sub_4B6D2
                tst.w   (word_FFF720).w
                bmi.w   nullsub_108
                addq.w  #2,4(a5)
                andi.w  #$7FFF,2(a5)
                move.w  $4E(a5),d0
                lea     off_4B6F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CheckScrollFlagAndDispatch
; ---------------------------------------------------------------------------
off_4B6F0:      dc.w    Gfx_UpdateStage14ScrollType1-*  ; DATA XREF: Enemy_CheckScrollFlagAndDispatch+16   o
                dc.w    Gfx_UpdateStage14ScrollType2-*
                dc.w    Gfx_UpdateStage14ScrollType3-*
                dc.w    Gfx_UpdateStage14ScrollType4-*

; Updates stage 14 scrolling type 1
Gfx_UpdateStage14ScrollType1:                           ; DATA XREF: ROM:off_4B6F0   o  ; was: sub_4B6F8
                move.l  #$448032C1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType1
; Updates stage 14 scrolling type 2
Gfx_UpdateStage14ScrollType2:                           ; DATA XREF: ROM:0004B6F2   o  ; was: sub_4B706
                move.l  #$449832A1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType2
; Updates stage 14 scrolling type 3
Gfx_UpdateStage14ScrollType3:                           ; DATA XREF: ROM:0004B6F4   o  ; was: sub_4B714
                move.l  #$4C8031C1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType3
; Updates stage 14 scrolling type 4
Gfx_UpdateStage14ScrollType4:                           ; DATA XREF: ROM:0004B6F6   o  ; was: sub_4B722
                move.l  #$4C9831A1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Gfx_UpdateStage14ScrollType4
; Resets state when scroll flag is valid
Enemy_ResetStateOnScrollCheck:                          ; DATA XREF: ROM:0004B4AE   o  ; was: sub_4B730
                tst.w   (word_FFF720).w
                bmi.s   locret_4B73A
                clr.w   4(a5)
locret_4B73A:                                           ; CODE XREF: Enemy_ResetStateOnScrollCheck+4   j
                rts
; End of function Enemy_ResetStateOnScrollCheck
; Plays roar sound
Boss_DestroyerMK2PlayRoar:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B73C
                move.w  $46(a5),d0
                lea     off_4B748(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2PlayRoar
; ---------------------------------------------------------------------------
off_4B748:      dc.w    Boss_DestroyerMK2PlayJump-*     ; DATA XREF: Boss_DestroyerMK2PlayRoar+4   o
                dc.w    Enemy_HandleWallCollisionDispatch-*
                dc.w    Enemy_HandleWallBounceWithFlag-*

; Plays jump sound
Boss_DestroyerMK2PlayJump:                              ; DATA XREF: ROM:off_4B748   o  ; was: sub_4B74E
                move.w  4(a5),d0
                lea     off_4B75A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2PlayJump
; ---------------------------------------------------------------------------
off_4B75A:      dc.w    Boss_DestroyerMK2PlayLand-*     ; DATA XREF: Boss_DestroyerMK2PlayJump+4   o
                dc.w    Boss_DestroyerMK2DefeatShake-*
                dc.w    nullsub_106-*

; Plays landing sound
Boss_DestroyerMK2PlayLand:                              ; DATA XREF: ROM:off_4B75A   o  ; was: sub_4B760
                cmpi.w  #$2A,(word_FFC624).w            ; '*'
                bcc.s   loc_4B76E
                tst.w   $24(a5)
                bpl.s   locret_4B79E
loc_4B76E:                                              ; CODE XREF: Boss_DestroyerMK2PlayLand+6   j
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,(dword_FF9410).w
                addq.w  #2,4(a5)
                move.w  #$FFFC,$1C(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4B798
                move.w  #$FFFE,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_4B798:                                              ; CODE XREF: Boss_DestroyerMK2PlayLand+2E   j
                move.w  #2,$18(a5)
locret_4B79E:                                           ; CODE XREF: Boss_DestroyerMK2PlayLand+C   j
                rts
; End of function Boss_DestroyerMK2PlayLand
; Screen shake during defeat
Boss_DestroyerMK2DefeatShake:                           ; DATA XREF: ROM:0004B75C   o  ; was: sub_4B7A0
                addi.l  #$4000,$1C(a5)
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1C0,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                ori.w   #$8000,$E(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_4B7FC
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_4B7FC
                move.l  #off_E95DC,8(a0)
                move.b  $20(a5),$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                jsr     (Projectile_InitType88).l
                subq.b  #4,$20(a0)
                ori.w   #$8000,$E(a0)
loc_4B7FC:                                              ; CODE XREF: Boss_DestroyerMK2DefeatShake+28   j
                                        ; Boss_DestroyerMK2DefeatShake+30   j
                cmpi.w  #$180,$14(a5)
                bcs.s   locret_4B80A
                move.w  #$1000,2(a5)
locret_4B80A:                                           ; CODE XREF: Boss_DestroyerMK2DefeatShake+62   j
                rts
; End of function Boss_DestroyerMK2DefeatShake
nullsub_106:                                            ; DATA XREF: ROM:0004B75E   o
                rts
; End of function nullsub_106

; Handles wall collision and dispatches
Enemy_HandleWallCollisionDispatch:                      ; DATA XREF: ROM:0004B74A   o  ; was: sub_4B80E
                cmpi.w  #8,4(a5)
                bcc.s   loc_4B83C
                bclr    #7,$22(a5)
                beq.s   loc_4B83C
                bclr    #4,$22(a5)
                beq.s   loc_4B82E
                move.l  #$FFFC0000,$1C(a5)
loc_4B82E:                                              ; CODE XREF: Enemy_HandleWallCollisionDispatch+16   j
                neg.l   $18(a5)
                clr.b   $21(a5)
                move.w  #8,4(a5)
loc_4B83C:                                              ; CODE XREF: Enemy_HandleWallCollisionDispatch+6   j
                                        ; Enemy_HandleWallCollisionDispatch+E   j
                move.w  4(a5),d0
                lea     off_4B848(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_HandleWallCollisionDispatch
; ---------------------------------------------------------------------------
off_4B848:      dc.w    Enemy_InitHorizontalMovement-*  ; DATA XREF: Enemy_HandleWallCollisionDispatch+32   o
                dc.w    Enemy_StopMovementAfterTimer-*
                dc.w    Enemy_RotateAndMoveWithAccel-*
                dc.w    Enemy_RotateUntilYThreshold-*
                dc.w    Enemy_RotateWithGravityUntilY-*

; Initializes horizontal movement with timer
Enemy_InitHorizontalMovement:                           ; DATA XREF: ROM:off_4B848   o  ; was: sub_4B852
                addq.w  #2,4(a5)
                move.w  #$14,$48(a5)
                move.w  #4,$18(a5)
                btst    #0,$45(a5)
                bne.s   loc_4B872
                move.w  #$FFFF,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4B872:                                              ; CODE XREF: Enemy_InitHorizontalMovement+16   j
                move.w  #1,$1C(a5)
                rts
; End of function Enemy_InitHorizontalMovement
; Stops movement after timer expires
Enemy_StopMovementAfterTimer:                           ; DATA XREF: ROM:0004B84A   o  ; was: sub_4B87A
                subq.w  #1,$48(a5)
                bne.s   locret_4B892
                clr.w   $18(a5)
                clr.w   $1C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4B892:                                           ; CODE XREF: Enemy_StopMovementAfterTimer+4   j
                rts
; End of function Enemy_StopMovementAfterTimer
; Rotates and moves with acceleration
Enemy_RotateAndMoveWithAccel:                           ; DATA XREF: ROM:0004B84C   o  ; was: sub_4B894
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                subq.w  #1,$48(a5)
                bne.s   locret_4B8B6
                move.w  #2,$18(a5)
                addq.w  #2,4(a5)
locret_4B8B6:                                           ; CODE XREF: Enemy_RotateAndMoveWithAccel+16   j
                rts
; End of function Enemy_RotateAndMoveWithAccel
; Rotates until Y position reaches threshold
Enemy_RotateUntilYThreshold:                            ; DATA XREF: ROM:0004B84E   o  ; was: sub_4B8B8
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                cmpi.w  #$1E0,$10(a5)
                bcs.s   locret_4B8D8
                move.w  #$1000,2(a5)
locret_4B8D8:                                           ; CODE XREF: Enemy_RotateUntilYThreshold+18   j
                rts
; End of function Enemy_RotateUntilYThreshold
; Rotates with gravity until Y position reached
Enemy_RotateWithGravityUntilY:                          ; DATA XREF: ROM:0004B850   o  ; was: sub_4B8DA
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4B902
                move.w  #$1000,2(a5)
locret_4B902:                                           ; CODE XREF: Enemy_RotateWithGravityUntilY+20   j
                rts
; End of function Enemy_RotateWithGravityUntilY
; Handles wall bounce with special flag check
Enemy_HandleWallBounceWithFlag:                         ; DATA XREF: ROM:0004B74C   o  ; was: sub_4B904
                cmpi.w  #8,4(a5)
                bcc.s   loc_4B946
                tst.w   (dword_FF941C+2).w
                beq.s   loc_4B91A
                move.w  $44(a5),$1C(a5)
                bra.s   loc_4B932
; ---------------------------------------------------------------------------
loc_4B91A:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+C   j
                bclr    #7,$22(a5)
                beq.s   loc_4B946
                bclr    #4,$22(a5)
                beq.s   loc_4B932
                move.l  #$FFFC0000,$1C(a5)
loc_4B932:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+14   j
                                        ; Enemy_HandleWallBounceWithFlag+24   j
                move.w  #1,(dword_FF941C+2).w
                neg.l   $18(a5)
                clr.b   $21(a5)
                move.w  #8,4(a5)
loc_4B946:                                              ; CODE XREF: Enemy_HandleWallBounceWithFlag+6   j
                                        ; Enemy_HandleWallBounceWithFlag+1C   j
                move.w  4(a5),d0
                lea     off_4B952(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_HandleWallBounceWithFlag
; ---------------------------------------------------------------------------
off_4B952:      dc.w    Enemy_InitMovementState-*       ; DATA XREF: Enemy_HandleWallBounceWithFlag+46   o
                dc.w    Enemy_WaitTimerThenStop-*
                dc.w    Enemy_RotateAndMoveVertical-*
                dc.w    Enemy_RotateUntilYBound-*
                dc.w    Enemy_RotateWithGravityFall-*

; Initializes movement state with timer
Enemy_InitMovementState:                                ; DATA XREF: ROM:off_4B952   o  ; was: sub_4B95C
                addq.w  #2,4(a5)
                move.w  #$14,$48(a5)
                move.w  #4,$18(a5)
                rts
; End of function Enemy_InitMovementState
; Waits for timer then clears speed
Enemy_WaitTimerThenStop:                                ; DATA XREF: ROM:0004B954   o  ; was: sub_4B96E
                subq.w  #1,$48(a5)
                bne.s   locret_4B982
                clr.w   $18(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4B982:                                           ; CODE XREF: Enemy_WaitTimerThenStop+4   j
                rts
; End of function Enemy_WaitTimerThenStop
; Rotates and moves vertically until timer
Enemy_RotateAndMoveVertical:                            ; DATA XREF: ROM:0004B956   o  ; was: sub_4B984
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                move.w  $44(a5),d0
                add.w   d0,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4B9AE
                move.w  #2,$18(a5)
                addq.w  #2,4(a5)
locret_4B9AE:                                           ; CODE XREF: Enemy_RotateAndMoveVertical+1E   j
                rts
; End of function Enemy_RotateAndMoveVertical
; Rotates until Y position exceeds boundary
Enemy_RotateUntilYBound:                                ; DATA XREF: ROM:0004B958   o  ; was: sub_4B9B0
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                cmpi.w  #$1E0,$10(a5)
                bcs.s   locret_4B9D0
                move.w  #$1000,2(a5)
locret_4B9D0:                                           ; CODE XREF: Enemy_RotateUntilYBound+18   j
                rts
; End of function Enemy_RotateUntilYBound
; Rotates with gravity until falling threshold
Enemy_RotateWithGravityFall:                            ; DATA XREF: ROM:0004B95A   o  ; was: sub_4B9D2
                addi.w  #$10,$4C(a5)
                move.w  $4C(a5),d2
                andi.w  #$1FE,d2
                bsr.w   Boss_DestroyerMK2CopyEntityAddress
                addi.l  #$4000,$1C(a5)
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4B9FA
                move.w  #$1000,2(a5)
locret_4B9FA:                                           ; CODE XREF: Enemy_RotateWithGravityFall+20   j
                rts
; End of function Enemy_RotateWithGravityFall
; Checks X position bounds before dispatching
Enemy_CheckBoundsAndDispatch:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_4B9FC
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$C10,d0
                bcs.s   Boss_DestroyerMK2SetEntityFlag
                cmpi.w  #$E70,d0
                bhi.s   Boss_DestroyerMK2SetEntityFlag
                move.w  4(a5),d0
                lea     off_4BA1C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_CheckBoundsAndDispatch
; ---------------------------------------------------------------------------
off_4BA1C:      dc.w    Enemy_FlickerAndPrepareMove-*   ; DATA XREF: Enemy_CheckBoundsAndDispatch+18   o
                dc.w    Enemy_AccelerateHorizontally-*

; Toggles visibility then sets movement speed
Enemy_FlickerAndPrepareMove:                            ; DATA XREF: ROM:off_4BA1C   o  ; was: sub_4BA20
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4BA3C
                ori.w   #$8000,2(a5)
                move.w  $4C(a5),$18(a5)
                addq.w  #2,4(a5)
locret_4BA3C:                                           ; CODE XREF: Enemy_FlickerAndPrepareMove+A   j
                rts
; End of function Enemy_FlickerAndPrepareMove
; Applies continuous horizontal acceleration
Enemy_AccelerateHorizontally:                           ; DATA XREF: ROM:0004BA1E   o  ; was: sub_4BA3E
                move.l  $50(a5),d0
                add.l   d0,$18(a5)
                rts
; End of function Enemy_AccelerateHorizontally
; Sets bit 4 in entity flags
Boss_DestroyerMK2SetEntityFlag:                         ; CODE XREF: Enemy_CheckBoundsAndDispatch+C   j  ; was: sub_4BA48
                                        ; Enemy_CheckBoundsAndDispatch+12   j
                bset    #4,2(a5)
                rts
; End of function Boss_DestroyerMK2SetEntityFlag
; Flash effect during defeat
Boss_DestroyerMK2DefeatFlash:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BA50
                move.w  4(a5),d0
                lea     off_4BA5C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatFlash
; ---------------------------------------------------------------------------
off_4BA5C:      dc.w    nullsub_107-*                   ; DATA XREF: Boss_DestroyerMK2DefeatFlash+4   o
                dc.w    Boss_DestroyerMK2DefeatBreakup-*
                dc.w    Effect_DestroyerMK2Spark-*
                dc.w    Effect_DestroyerMK2Debris-*

nullsub_107:                                            ; DATA XREF: ROM:off_4BA5C   o
                rts
; End of function nullsub_107

; Boss breaking up
Boss_DestroyerMK2DefeatBreakup:                         ; DATA XREF: ROM:0004BA5E   o  ; was: sub_4BA66
                addq.w  #2,4(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bmi.s   loc_4BA7E
                move.w  #$30,d1                         ; '0'
                move.w  #4,d2
                bra.s   loc_4BA86
; ---------------------------------------------------------------------------
loc_4BA7E:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+C   j
                move.w  #$FFD0,d1
                move.w  #$FFFC,d2
loc_4BA86:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+16   j
                sub.w   d1,d0
                bpl.s   loc_4BA8C
                neg.w   d0
loc_4BA8C:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+22   j
                lsr.w   #2,d0
                cmpi.w  #$110,(dword_FFA414).w
                bcs.s   loc_4BA9C
                move.w  #4,d3
                bra.s   loc_4BAA0
; ---------------------------------------------------------------------------
loc_4BA9C:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+2E   j
                move.w  #$FFFC,d3
loc_4BAA0:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+34   j
                movea.w #(byte_FFCC20-M68K_RAM),a0
                move.w  #7,d7
                clr.w   d6
loc_4BAAA:                                              ; CODE XREF: Boss_DestroyerMK2DefeatBreakup+9A   j
                move.w  #$260,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FF02FF02,$2C(a0)
                move.w  #$80,$26(a0)
                move.w  #$6D00,2(a0)
                move.l  #off_E9680,8(a0)
                move.w  #$8480,$E(a0)
                clr.w   $C(a0)
                move.l  $10(a5),$10(a0)
                add.w   d1,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  d6,$48(a0)
                move.w  d0,$4A(a0)
                move.w  d2,$4C(a0)
                move.w  d3,$50(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4BAAA
                move.w  #8,$52(a5)
                rts
; End of function Boss_DestroyerMK2DefeatBreakup
; Spark effect
Effect_DestroyerMK2Spark:                               ; DATA XREF: ROM:0004BA60   o  ; was: sub_4BB0C
                tst.w   $52(a5)
                bne.s   locret_4BB1C
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4BB1C:                                           ; CODE XREF: Effect_DestroyerMK2Spark+4   j
                rts
; End of function Effect_DestroyerMK2Spark
; Debris effect
Effect_DestroyerMK2Debris:                              ; DATA XREF: ROM:0004BA62   o  ; was: sub_4BB1E
                subq.w  #1,$48(a5)
                bne.s   locret_4BB28
                clr.w   4(a5)
locret_4BB28:                                           ; CODE XREF: Effect_DestroyerMK2Debris+4   j
                rts
; End of function Effect_DestroyerMK2Debris
; Spawns defeat debris
Boss_DestroyerMK2DefeatDebris:                          ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BB2A
                move.w  4(a5),d0
                lea     off_4BB36(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DefeatDebris
; ---------------------------------------------------------------------------
off_4BB36:      dc.w    Boss_DestroyerMK2DefeatSparks-*  ; DATA XREF: Boss_DestroyerMK2DefeatDebris+4   o
                dc.w    Boss_DestroyerMK2DefeatSmoke-*
                dc.w    Boss_DestroyerMK2DefeatCleanup-*
                dc.w    Effect_DestroyerMK2Smoke-*

; Spawns defeat sparks
Boss_DestroyerMK2DefeatSparks:                          ; DATA XREF: ROM:off_4BB36   o  ; was: sub_4BB3E
                subq.w  #1,$48(a5)
                bpl.s   locret_4BB54
                move.w  #$10,$48(a5)
                ori.w   #$8000,2(a5)
                addq.w  #2,4(a5)
locret_4BB54:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSparks+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSparks
; Spawns defeat smoke
Boss_DestroyerMK2DefeatSmoke:                           ; DATA XREF: ROM:0004BB38   o  ; was: sub_4BB56
                subq.w  #1,$48(a5)
                bpl.s   locret_4BB70
                move.l  $4C(a5),$18(a5)
                addq.w  #2,4(a5)
                move.b  #$E8,d0
                jsr     (Sound_PlaySFX).l
locret_4BB70:                                           ; CODE XREF: Boss_DestroyerMK2DefeatSmoke+4   j
                rts
; End of function Boss_DestroyerMK2DefeatSmoke
; Cleanup after defeat
Boss_DestroyerMK2DefeatCleanup:                         ; DATA XREF: ROM:0004BB3A   o  ; was: sub_4BB72
                subq.w  #1,$4A(a5)
                bpl.s   locret_4BB86
                clr.w   $18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_4BB86:                                           ; CODE XREF: Boss_DestroyerMK2DefeatCleanup+4   j
                rts
; End of function Boss_DestroyerMK2DefeatCleanup
; Smoke effect
Effect_DestroyerMK2Smoke:                               ; DATA XREF: ROM:0004BB3C   o  ; was: sub_4BB88
                cmpi.w  #$180,$14(a5)
                bcc.s   loc_4BBA8
                cmpi.w  #$80,$14(a5)
                bls.s   loc_4BBA8
                moveq   #0,d0
                move.w  d0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                bne.s   loc_4BBB4
                rts
; ---------------------------------------------------------------------------
loc_4BBA8:                                              ; CODE XREF: Effect_DestroyerMK2Smoke+6   j
                                        ; Effect_DestroyerMK2Smoke+E   j
                subq.w  #1,(word_FFC792).w
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4BBB4:                                              ; CODE XREF: Effect_DestroyerMK2Smoke+1C   j
                move.w  #$BC,d0
                jsr     (Sound_PlaySFX).l
                subq.w  #1,(word_FFC792).w
                clr.b   $21(a5)
                move.l  #off_E95DC,8(a5)
                jsr     (Enemy_GetEntityAddress).l
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a5)
                rts
; End of function Effect_DestroyerMK2Smoke
; Shooting pattern 2
Boss_DestroyerMK2ShootPattern2:                         ; CODE XREF: Boss_DestroyerMK2Main+5C   p  ; was: sub_4BBF0
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4BC1A
                move.w  (dword_FF9418).w,d0
                move.w  word_4BC1C(pc,d0.w),(word_FFE366).w
                move.w  word_4BC30(pc,d0.w),(word_FFE368).w
                addq.w  #2,(dword_FF9418).w
                cmpi.w  #$14,(dword_FF9418).w
                bne.s   locret_4BC1A
                clr.w   (dword_FF9418).w
locret_4BC1A:                                           ; CODE XREF: Boss_DestroyerMK2ShootPattern2+8   j
                                        ; Boss_DestroyerMK2ShootPattern2+24   j
                rts
; End of function Boss_DestroyerMK2ShootPattern2
; ---------------------------------------------------------------------------
word_4BC1C:     dc.w    $2C8, $A6, $84, $62, $40, $20, $40, $62, $84, $A6
                                        ; DATA XREF: Boss_DestroyerMK2ShootPattern2+E   r
word_4BC30:     dc.w    $64, $44, $42, $22, $20, 0, $20, $22, $42, $44
                                        ; DATA XREF: Boss_DestroyerMK2ShootPattern2+14   r

; Shooting pattern 3
Boss_DestroyerMK2ShootPattern3:                         ; CODE XREF: Boss_DestroyerMK2AttackState2+C   p  ; was: sub_4BC44
                                        ; sub_4ABC6   p
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                movea.w #(word_FFC740-M68K_RAM),a0
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  #3,d7
                movea.w #(word_FFC7A0-M68K_RAM),a0
loc_4BC8C:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+7E   j
                cmpi.w  #4,$4E(a0)
                bcc.s   loc_4BC9A
                lea     (word_FFE52C).w,a1
                bra.s   loc_4BC9E
; ---------------------------------------------------------------------------
loc_4BC9A:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+4E   j
                lea     (word_FFE720).w,a1
loc_4BC9E:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+54   j
                move.w  (a1),d0
                addi.w  #$C0,d0
                add.w   $4A(a0),d0
                add.w   $58(a0),d0
                move.w  d0,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4C(a0),d0
                add.w   d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4BC8C
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9408).w
                andi.w  #$1FF,(dword_FF9408).w
                clr.w   d3
                move.b  $20(a5),d3
                movea.w #(word_FFC920-M68K_RAM),a0
                move.w  (dword_FF9404).w,d5
                move.w  (dword_FF9408).w,d6
                lea     (word_1B514).l,a1
                move.w  #7,d7
loc_4BCF0:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+106   j
                tst.w   4(a0)
                bne.w   loc_4BD46
                move.w  $4C(a0),d0
                add.w   d6,d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d1
                move.w  $4A(a0),d2
                add.w   d5,d2
                muls.w  d2,d1
                add.l   $10(a5),d1
                move.l  d1,$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  d0,d2
                bsr.w   Boss_DestroyerMK2PlayIntroSFX
                move.w  -$80(a1,d0.w),d1
                muls.w  #$40,d1                         ; '@'
                swap    d1
                neg.w   d1
                tst.w   d1
                bpl.s   loc_4BD3A
                ori.w   #$8000,$E(a0)
                bra.s   loc_4BD40
; ---------------------------------------------------------------------------
loc_4BD3A:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+EC   j
                andi.w  #$7FFF,$E(a0)
loc_4BD40:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+F4   j
                add.w   d3,d1
                move.b  d1,$20(a0)
loc_4BD46:                                              ; CODE XREF: Boss_DestroyerMK2ShootPattern3+B0   j
                lea     $60(a0),a0
                dbf     d7,loc_4BCF0
                rts
; End of function Boss_DestroyerMK2ShootPattern3
; Copies entity address from a5 to a0
Boss_DestroyerMK2CopyEntityAddress:                     ; CODE XREF: Boss_DestroyerMK2DefeatShake+16   p  ; was: sub_4BD50
                                        ; Enemy_RotateAndMoveWithAccel+E   p
                movea.w a5,a0
; End of function Boss_DestroyerMK2CopyEntityAddress
; Plays boss intro sound
Boss_DestroyerMK2PlayIntroSFX:                          ; CODE XREF: Boss_DestroyerMK2ShootPattern3+DA   p  ; was: sub_4BD52
                addi.w  #$20,d2                         ; ' '
                andi.w  #$1C0,d2
                lsr.w   #4,d2
                move.l  off_4BD6C(pc,d2.w),8(a0)
                lsr.w   #1,d2
                move.w  word_4BD8C(pc,d2.w),$E(a0)
                rts
; End of function Boss_DestroyerMK2PlayIntroSFX
; ---------------------------------------------------------------------------
off_4BD6C:      dc.l    word_EC2C8                      ; DATA XREF: Boss_DestroyerMK2PlayIntroSFX+A   r
                dc.l    word_EC2CE
                dc.l    word_EC2D4
                dc.l    word_EC2CE
                dc.l    word_EC2C8
                dc.l    word_EC2DA
                dc.l    word_EC2E0
                dc.l    word_EC2DA
word_4BD8C:     dc.w    $6300, $6300, $6300, $6B00, $6300, $6B00, $6300, $6300, $838, 0, $F706, $6728, $838, 5, $F706, $670C
                                        ; DATA XREF: Boss_DestroyerMK2PlayIntroSFX+12   r

; Updates weapon cooldown timers
Boss_UpdateMultipleWeaponTimers:
                tst.w   (word_FFC804).w                 ; was: sub_4BDAC
                bne.s   loc_4BDB8
                move.w  #2,(word_FFC804).w
loc_4BDB8:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+4   j
                btst    #6,(word_FFF706).w
                beq.s   loc_4BDCC
                tst.w   (word_FFC7A4).w
                bne.s   loc_4BDCC
                move.w  #2,(word_FFC7A4).w
loc_4BDCC:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+12   j
                                        ; Boss_UpdateMultipleWeaponTimers+18   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4BDFC
                btst    #5,(word_FFF706).w
                beq.s   loc_4BDE8
                tst.w   (word_FFC8C4).w
                bne.s   loc_4BDE8
                move.w  #2,(word_FFC8C4).w
loc_4BDE8:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+2E   j
                                        ; Boss_UpdateMultipleWeaponTimers+34   j
                btst    #6,(word_FFF706).w
                beq.s   locret_4BDFC
                tst.w   (word_FFC864).w
                bne.s   locret_4BDFC
                move.w  #2,(word_FFC864).w
locret_4BDFC:                                           ; CODE XREF: Boss_UpdateMultipleWeaponTimers+26   j
                                        ; Boss_UpdateMultipleWeaponTimers+42   j
                rts
; End of function Boss_UpdateMultipleWeaponTimers
; Boss intro roar sound
Boss_DestroyerMK2IntroRoar:                             ; CODE XREF: Boss_DestroyerMK2Main+8   p  ; was: sub_4BDFE
                lea     (word_FFE480).w,a0
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                move.w  #$27,d7                         ; '''
loc_4BE0C:                                              ; CODE XREF: Boss_DestroyerMK2IntroRoar+12   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4BE0C
                rts
; End of function Boss_DestroyerMK2IntroRoar
; Debris projectile handler
Projectile_DestroyerMK2DebrisMain:                      ; CODE XREF: Effect_DestroyerMK2Explosion2   p  ; was: sub_4BE16
                                        ; DATA XREF: Effect_DestroyerMK2Explosion2   o
                jsr     (Gfx_UpdatePaletteFade).l
                jsr     (Effect_PlayRandomExplosionSound).l
                move.w  #2,(word_FFA014).w
                move.w  #4,(word_FFA010).w
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4BE98
                jsr     (Sprite_InitializeProperties).l
                clr.b   $20(a0)
                move.w  #6,$18(a0)
                move.w  (dword_FFFF08+2).w,$1A(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$1F,d0
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$24,d0                         ; '$'
                subi.w  #$24,d1                         ; '$'
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_4BE9A(pc,d0.w),8(a0)
                ori.w   #$8000,$E(a0)
locret_4BE98:                                           ; CODE XREF: Projectile_DestroyerMK2DebrisMain+1E   j
                rts
; End of function Projectile_DestroyerMK2DebrisMain
; ---------------------------------------------------------------------------
off_4BE9A:      dc.l    off_E953C                       ; DATA XREF: Projectile_DestroyerMK2DebrisMain+76   r
                dc.l    off_E95A4
                dc.l    off_E9560
                dc.l    off_E95C0
                dc.l    off_E9584
                dc.l    off_E95DC
                dc.l    off_E9584
                dc.l    off_E9604

nullsub_108:                                            ; CODE XREF: Boss_DestroyerMK2ComponentCheckDefeat+4   j
                                        ; Boss_DestroyerMK2ComponentCheckDefeat+14   j
                rts
; End of function nullsub_108

; Main handler for Bugmax boss
