Boss_SunsetStingMainDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_418FC
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_41932
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                beq.s   loc_41924
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                move.b  d0,(byte_FFC73E).w
                move.b  d0,(dword_FFC6DC+1).w
                bra.s   loc_41932
; ---------------------------------------------------------------------------
loc_41924:                                              ; CODE XREF: Boss_SunsetStingMainDispatcher+12   j
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                move.b  d0,(dword_FFC6DC+1).w
loc_41932:                                              ; CODE XREF: Boss_SunsetStingMainDispatcher+8   j
                                        ; Boss_SunsetStingMainDispatcher+26   j
                moveq   #4,d7
                jsr     (Gfx_InitPaletteFade).l
                move.w  4(a5),d0
                lea     off_41946(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_SunsetStingMainDispatcher
; ---------------------------------------------------------------------------
off_41946:      dc.w    Boss_SunsetStingInitState-*     ; DATA XREF: Boss_SunsetStingMainDispatcher+42   o
                dc.w    Boss_SunsetStingLoadGraphicsAlt-*
                dc.w    Boss_SunsetStingCheckVictoryAlt-*
                dc.w    Boss_SunsetStingWaitTransition-*
                dc.w    Boss_SunsetStingSetAttackState-*
                dc.w    Boss_SunsetStingUpdateMovement-*
                dc.w    Boss_SunsetStingAnimateSequence2-*
                dc.w    Boss_SunsetStingAnimateSequence3-*
                dc.w    Boss_SunsetStingCheckHealthThreshold-*
                dc.w    Boss_SunsetStingAnimateSequence1-*
                dc.w    Boss_SunsetStingAnimateSequence3-*
                dc.w    Boss_SunsetStingCheckHealthThreshold-*
                dc.w    Boss_SunsetStingMoveAndShoot_AttackLoop-*
                dc.w    Boss_SunsetStingRotateAndMove-*
                dc.w    Boss_SunsetStingRiseAndSpawnRing-*
                dc.w    Boss_SunsetStingDescendAndActivate-*
                dc.w    Boss_SunsetStingWaitAndInitSegments-*
                dc.w    Boss_SunsetStingDescendToPosition-*
                dc.w    Boss_SunsetStingEndInvulnerability-*
word_4196C:     dc.w    $C82C, $D00, $F8F0              ; DATA XREF: ROM:off_4258E   o
                                        ; ROM:0004259A   o
word_41972:     dc.w    $C834, $500, $F8F8              ; DATA XREF: ROM:000425FA   o
                                        ; ROM:00042602   o
word_41978:     dc.w    $C851, 0, $FCFC                 ; DATA XREF: ROM:000425B6   o
                                        ; ROM:000425C6   o
word_4197E:     dc.w    $C852, 0, $FCFC                 ; DATA XREF: ROM:000425D6   o
                                        ; ROM:000425E6   o

; Initializes boss state, clears sprites, sets starting position
Boss_SunsetStingInitState:                              ; DATA XREF: ROM:off_41946   o  ; was: sub_41984
                clr.b   (dword_FFC6DC).w
                move.w  #$1C8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                addq.w  #2,4(a5)
                move.b  #$80,$4B(a5)
                clr.w   (word_FFC67E).w
                clr.w   (word_FFC678).w
                move.l  #$1C00000,$10(a5)
                move.l  #$2000000,$14(a5)
                rts
; End of function Boss_SunsetStingInitState
; Loads boss graphics tiles, palettes, and body parts
Boss_SunsetStingLoadGraphicsAlt:                        ; DATA XREF: ROM:00041948   o  ; was: sub_419B8
                tst.w   (word_FFF720).w
                bmi.w   locret_41A5E
                addq.w  #2,4(a5)
                movea.l #word_426DA,a1
                jsr     (Object_InitGroupFromTable).l
                moveq   #6,d7
                jsr     (Data_LoadPaletteTable).l
                move.w  (a5),-(sp)
                move.w  #$3300,$E(a5)
                lea     off_4258E(pc),a1                ; debug this
                lea     (a5),a4
                jsr     (Boss_SunsetStingInitBodyParts).l
                jsr     Boss_SunsetStingInitTrail(pc)   ; (pc)
                nop
                move.w  (sp)+,(a5)
                ori.w   #$100,$482(a5)
                ori.w   #$100,$6C2(a5)
                ori.w   #$100,$902(a5)
                ori.w   #$100,$B42(a5)
                move.w  #$D00,2(a5)
                lea     (a5),a1
                move.w  (word_FFC67C).w,d3
                subq.w  #1,d3
loc_41A1A:                                              ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+76   j
                move.l  #$1C00000,$10(a1)
                move.l  #$1C00000,$14(a1)
                adda.w  #$60,a1                         ; '`'
                dbf     d3,loc_41A1A
                move.l  #$FFFF0000,$18(a5)
                move.b  #$18,(byte_FFC79C).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                move.b  #$FF,(byte_FFC7FC).w
                move.w  #$180,$56(a5)
                movea.l #word_41A60,a0
                jsr     (Gfx_LoadCompressedTiles).l
locret_41A5E:                                           ; CODE XREF: Boss_SunsetStingLoadGraphicsAlt+4   j
                rts
; End of function Boss_SunsetStingLoadGraphicsAlt
; ---------------------------------------------------------------------------
word_41A60:     dc.w    $6100, $2000, $202, $595A, $5B5D, $5E5F, $6162, $63FF, $6306, $2000, 0, $5CFF, $6306, $2000, 0, $60FF
                                        ; DATA XREF: Boss_SunsetStingLoadGraphicsAlt+9A   o
                dc.w    $6306, $2000, 0, $64FF
word_41A88:     dc.w    $1E, $FFE6, $FFEC, $FFF2, $FFE8, $FFDE, $FFE4, $FFEA, $FFE0, $FFD6, $FFD4, $FFD2, $FFD0, $FFCE, $FFCC, $FFCA
                                        ; DATA XREF: Boss_SunsetStingMainUpdate+82   o
                dc.w    $FFC8

; Checks victory condition and advances to next state
Boss_SunsetStingCheckVictoryAlt:                        ; DATA XREF: ROM:0004194A   o  ; was: sub_41AAA
                tst.w   (word_FF80C2).w
                bne.w   loc_41AD0
                moveq   #5,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
                bra.w   loc_41AD0
; End of function Boss_SunsetStingCheckVictoryAlt
; Waits for transition to complete before advancing state
Boss_SunsetStingWaitTransition:                         ; DATA XREF: ROM:0004194C   o  ; was: sub_41AC2
                tst.w   (word_FF80C2).w
                bne.s   loc_41AD0
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
loc_41AD0:                                              ; CODE XREF: Boss_SunsetStingCheckVictoryAlt+4   j
                                        ; Boss_SunsetStingCheckVictoryAlt+14   j
                bra.w   loc_41B42
; End of function Boss_SunsetStingWaitTransition
; Sets boss to attack state mode and transitions to main loop
Boss_SunsetStingSetAttackState:                         ; DATA XREF: ROM:0004194E   o  ; was: sub_41AD4
                                        ; ROM:00041E44   o
                move.b  #4,$4B(a5)
                bra.w   loc_41AEA
; End of function Boss_SunsetStingSetAttackState
; Sets boss to idle state and initializes attack timer
Boss_SunsetStingSetIdleState:                           ; CODE XREF: Boss_SunsetStingMoveAndShoot+2A   j  ; was: sub_41ADE
                                        ; Boss_SunsetStingCheckPhaseTransition+8   j
                move.b  #$10,(byte_FFC79C).w
                move.b  #0,$4B(a5)
loc_41AEA:                                              ; CODE XREF: Boss_SunsetStingSetAttackState+6   j
                move.w  #$A,4(a5)
                clr.w   (word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                bra.w   loc_41C28
; End of function Boss_SunsetStingSetIdleState
; Updates boss vertical movement tracking player
Boss_SunsetStingUpdateMovement:                         ; DATA XREF: ROM:00041950   o  ; was: sub_41B02
                move.w  #$10,d2
                move.w  #$F0,d0
                sub.w   $14(a5),d0
                move.b  (byte_FFC7FC).w,d1
                asl.w   #8,d1
                eor.w   d0,d1
                bpl.s   loc_41B1A
                neg.w   d2
loc_41B1A:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+14   j
                tst.w   d0
                bpl.s   loc_41B20
                neg.w   d0
loc_41B20:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+1A   j
                cmpi.w  #$A,d0
                bcs.s   loc_41B42
                addi.w  #$100,d2
                lsr.w   #1,d2
                move.w  #1,d0
                move.w  $56(a5),d1
                lsr.w   #1,d1
                sub.b   d1,d2
                beq.s   loc_41B42
                bpl.s   loc_41B3E
                neg.w   d0
loc_41B3E:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+38   j
                add.w   d0,$56(a5)
loc_41B42:                                              ; CODE XREF: Boss_SunsetStingWaitTransition:loc_41AD0   j
                                        ; Boss_SunsetStingUpdateMovement+22   j
                tst.b   (byte_FFC7FC).w
                bpl.s   loc_41B64
                ori.w   #$800,$4EE(a5)
                ori.w   #$800,$72E(a5)
                andi.w  #$F7FF,$2AE(a5)
                andi.w  #$F7FF,$96E(a5)
                bra.w   loc_41B7C
; ---------------------------------------------------------------------------
loc_41B64:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+44   j
                ori.w   #$800,$2AE(a5)
                ori.w   #$800,$96E(a5)
                andi.w  #$F7FF,$4EE(a5)
                andi.w  #$F7FF,$72E(a5)
loc_41B7C:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+5E   j
                moveq   #$FFFFFFFF,d6
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                lea     word_41C3E(pc),a3
                bsr.w   Boss_SunsetStingUpdatePartRotation
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                lea     word_41C46(pc),a3
                bsr.w   Boss_SunsetStingUpdatePartRotation
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   loc_41BF6
                addq.b  #4,(word_FFC7F8).w
                andi.b  #$E,(word_FFC7F8).w
                move.b  (byte_FFC79C).w,(word_FFC7F8+1).w
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                cmpi.w  #$A0,d0
                bhi.s   loc_41BEE
                tst.b   $4B(a5)
                bne.w   loc_41BEA
                move.w  (word_FFC678).w,d0
                move.b  (byte_FFC7FC).w,d1
                andi.w  #4,d1
                eori.w  #4,d0
                eor.b   d0,d1
                andi.w  #4,d1
                bne.w   Boss_SunsetStingJumpRandomFunction
                move.b  #1,$4B(a5)
loc_41BEA:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+C4   j
                subq.b  #1,$4B(a5)
loc_41BEE:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+BE   j
                move.w  d6,-(sp)
                bsr.w   Boss_SunsetStingSpawnRandomProjectile
                move.w  (sp)+,d6
loc_41BF6:                                              ; CODE XREF: Boss_SunsetStingUpdateMovement+A4   j
                tst.w   d6
                bmi.s   loc_41C28
                cmp.w   (word_FFC678).w,d6
                beq.s   loc_41C28
                lea     word_41FA0(pc),a2
                movea.w (a2,d6.w),a4
                adda.w  a5,a4
                move.l  #word_EBEA0,$1E8(a4)
                move.w  (word_FFC678).w,d0
                move.w  d6,(word_FFC678).w
                movea.w (a2,d0.w),a4
                adda.w  a5,a4
                move.l  #word_EBE94,$1E8(a4)
loc_41C28:                                              ; CODE XREF: Boss_SunsetStingSetIdleState+20   j
                                        ; Boss_SunsetStingUpdateMovement+F6   j
                move.w  (word_FFC678).w,d6
                lea     word_41FA0(pc),a4
                movea.w (a4,d6.w),a4
                adda.l  a5,a4
                bsr.w   Boss_SunsetStingCalculateChainPosition
                bra.w   loc_422C0
; End of function Boss_SunsetStingUpdateMovement
; ---------------------------------------------------------------------------
word_41C3E:     dc.w    $2C, 0, $32, 0                  ; DATA XREF: Boss_SunsetStingUpdateMovement+84   o
word_41C46:     dc.w    $42, 0, $34, 0, 8, 0, $E, 0, $40, $FFC0, $FFC0, $FFC0, $FFC0, $FFE0, $FFE0, $FFE0
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+98   o
                dc.w    $FFE0, $FFE0, 0, $20, $20, $20, $20, $FF80, $80, $80, $80, $80, 0, $FFE0, $FFE0, $FFE0
                dc.w    $FFE0, $80, $FF80, $FF80, $FF80, $FF80, 0, $40, $40, $40, $40, $FFE0, $FFC0, $FFC0, $FFC0, $FFC0
word_41CA6:     dc.w    $1A, 0, $FFCA, 0                ; DATA XREF: Boss_SunsetStingAnimateSequence3   o
                                        ; sub_41F6A:loc_41F82   o
word_41CAE:     dc.w    8, 0, $E, 0, $60, $20, $20, $20, $20, $FFA0, $FFE0, $FFE0, $FFE0, $FFE0
                                        ; DATA XREF: Boss_SunsetStingAnimateSequence2   o
word_41CCA:     dc.w    $12, 0, 4, 0, $40, $60, $80, $A0, $C0, 0, 0, 0, 0, 0
                                        ; DATA XREF: Boss_SunsetStingAnimateSequence1   o

; Calculates target direction based on player position
Boss_SunsetStingCalculateTargetDirection:               ; CODE XREF: Boss_SunsetStingSetIdleState+1C   p  ; was: sub_41CE6
                                        ; Boss_SunsetStingUpdateMovement+B6   p
                jsr     (RandomNumber).l
                andi.w  #$1F,d0
                move.b  d0,(byte_FFC7FD).w
                move.w  $14(a5),d0
                cmpi.w  #$120,d0
                bhi.s   loc_41D1E
                lea     (word_FFA400).w,a4
                move.w  dword_FFA410-word_FFA400(a4),d0
                sub.w   $10(a5),d0
                ext.l   d0
                bpl.s   loc_41D10
                neg.w   d0
loc_41D10:                                              ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+26   j
                add.b   d0,(byte_FFC7FD).w
                swap    d0
                move.b  d0,(byte_FFC7FC).w
                swap    d0
                rts
; ---------------------------------------------------------------------------
loc_41D1E:                                              ; CODE XREF: Boss_SunsetStingCalculateTargetDirection+16   j
                move.w  $56(a5),d0
                lsr.w   #1,d0
                ext.w   d0
                lsr.w   #8,d0
                move.b  d0,(byte_FFC7FC).w
                move.w  #$1FF,d0
                move.b  d0,(byte_FFC7FD).w
                rts
; End of function Boss_SunsetStingCalculateTargetDirection
; Gets pointer to specific body part based on angle
Boss_SunsetStingGetBodyPartPointer:                     ; CODE XREF: Boss_SunsetStingUpdatePartRotation:loc_41D58   p  ; was: sub_41D36
                                        ; Boss_SunsetStingFlipAndAnimate+1E   p
                tst.b   (byte_FFC7FC).w
                bmi.s   loc_41D40
                eori.b  #$10,d0
loc_41D40:                                              ; CODE XREF: Boss_SunsetStingGetBodyPartPointer+4   j
                move.w  d0,d1
                lsr.w   #2,d0
                andi.w  #6,d0
                lea     word_41FA0(pc),a0
                movea.w (a0,d0.w),a4
                adda.l  a5,a4
                rts
; End of function Boss_SunsetStingGetBodyPartPointer
; Updates body part rotation angles with target tracking
Boss_SunsetStingUpdatePartRotation:                     ; CODE XREF: Boss_SunsetStingUpdateMovement+88   p  ; was: sub_41D54
                                        ; Boss_SunsetStingUpdateMovement+9C   p
                move.w  #$20,d2                         ; ' '
loc_41D58:                                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+14   p
                                        ; Boss_SunsetStingRiseAndSpawnRing+26   p
                bsr.s   Boss_SunsetStingGetBodyPartPointer
                move.w  d1,-(sp)
                asl.w   #5,d1
                sub.w   d3,d1
                andi.w  #$FF,d1
                addi.b  #$40,d1                         ; '@'
                btst    #7,d1
                beq.s   loc_41D70
                move.w  d0,d6
loc_41D70:                                              ; CODE XREF: Boss_SunsetStingUpdatePartRotation+18   j
                move.w  (sp)+,d1
                andi.w  #6,d1
                lea     (a3,d1.w),a0
                adda.w  (a0),a0
                bsr.w   Boss_SunsetStingAnimatePartSequence
                rts
; End of function Boss_SunsetStingUpdatePartRotation
; Animates sequence of connected body parts
Boss_SunsetStingAnimatePartSequence:                    ; CODE XREF: Boss_SunsetStingUpdatePartRotation+28   p  ; was: sub_41D82
                lea     $60(a4),a1
                move.w  #4,d4
loc_41D8A:                                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+36   j
                move.w  (a0)+,d0
                ; Original immediate is $B; memory BTST uses its low three bits
                dc.w    $082C, $000B, $000E             ; btst #$B,$E(a4)
                beq.s   loc_41D96
                neg.w   d0
loc_41D96:                                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+10   j
                sub.w   $56(a1),d0
                ext.l   d0
                divs.w  d3,d0
                add.w   d0,$56(a1)
                move.w  #1,d0
                cmp.w   $4C(a1),d2
                beq.s   loc_41DB4
                bpl.s   loc_41DB0
                neg.w   d0
loc_41DB0:                                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+2A   j
                add.w   d0,$4C(a1)
loc_41DB4:                                              ; CODE XREF: Boss_SunsetStingAnimatePartSequence+28   j
                adda.w  #$60,a1                         ; '`'
                dbf     d4,loc_41D8A
                rts
; End of function Boss_SunsetStingAnimatePartSequence
; Spawns projectiles at random positions using jump table
Boss_SunsetStingSpawnRandomProjectile:                  ; CODE XREF: Boss_SunsetStingUpdateMovement+EE   p  ; was: sub_41DBE
                tst.w   (word_FFFF0E).w
                beq.w   locret_41DFC
loc_41DC6:                                              ; CODE XREF: Boss_SunsetStingMoveAndShoot+26   p
                jsr     (RandomNumber).l
                andi.w  #6,d0
                movem.l a5,-(sp)
                lea     word_41FA0(pc),a2
                adda.w  d0,a2
                movea.w (a2)+,a5
                adda.l  (sp),a5
                adda.w  #$1E0,a5
                lea     (word_FFA400).w,a4
                jsr     (loc_427EC).l
                movem.l d2/a2,-(sp)
                bsr.w   Boss_SunsetStingInitHomingProjectile
                movem.l (sp)+,d2/a2
                movem.l (sp)+,a5
locret_41DFC:                                           ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+4   j
                rts
; End of function Boss_SunsetStingSpawnRandomProjectile
; Initializes homing projectile with angle offset
Boss_SunsetStingInitHomingProjectile:                   ; CODE XREF: Boss_SunsetStingSpawnRandomProjectile+32   p  ; was: sub_41DFE
                andi.w  #$FF,d0
                subi.b  #$40,d0                         ; '@'
                move.w  d0,-(sp)
                movea.w #(byte_FFD280-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckExtendedRange).l
                bne.s   locret_41E2A
                move.w  (sp)+,d6
                add.w   d6,d6
                move.w  #0,d0
                move.w  #0,d1
                move.w  #$8000,d2
                jsr     (Enemy_InitHomingProjectile).l
locret_41E2A:                                           ; CODE XREF: Boss_SunsetStingInitHomingProjectile+14   j
                rts
; End of function Boss_SunsetStingInitHomingProjectile
; Jumps to random function for boss pattern variation
Boss_SunsetStingJumpRandomFunction:                     ; CODE XREF: Boss_SunsetStingUpdateMovement+DE   j  ; was: sub_41E2C
                lea     word_41E36(pc),a0
                jmp     JumpRandomFunc
; End of function Boss_SunsetStingJumpRandomFunction
; ---------------------------------------------------------------------------
word_41E36:     dc.w    $2000                           ; DATA XREF: Boss_SunsetStingJumpRandomFunction   o
                dc.w    Boss_SunsetStingMoveAndShoot-*
                dc.w    $6000
                dc.w    Boss_SunsetStingFlipDirection-*
                dc.w    $6000
                dc.w    Boss_SunsetStingFlipAndAnimate-*
                dc.w    $6000
                dc.w    Boss_SunsetStingSetAttackState-*

; Moves boss based on player position and spawns projectiles
Boss_SunsetStingMoveAndShoot:                           ; DATA XREF: ROM:00041E38   o  ; was: sub_41E46
                move.w  #$18,4(a5)
                move.b  #$40,$4B(a5)                    ; '@'
; Calculate direction and rotate while attacking
Boss_SunsetStingMoveAndShoot_AttackLoop:                ; DATA XREF: ROM:0004195E   o  ; was: loc_41E52
                bsr.w   Boss_SunsetStingCalculateTargetDirection
                move.b  (byte_FFC7FC).w,d0
                ext.w   d0
                add.w   d0,d0
                addq.w  #1,d0
                add.w   d0,$56(a5)
                subq.b  #1,$4B(a5)
                bne.w   loc_41B42
                bsr.w   loc_41DC6
                bra.w   Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingMoveAndShoot
; Flips boss horizontal direction and updates animation
Boss_SunsetStingFlipDirection:                          ; DATA XREF: ROM:00041E3C   o  ; was: sub_41E74
                move.w  #$12,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
                not.b   (byte_FFC7FC).w
                bra.w   loc_41C28
; End of function Boss_SunsetStingFlipDirection
; Loads animation sequence data for pattern execution
Boss_SunsetStingAnimateSequence1:                       ; DATA XREF: ROM:00041958   o  ; was: sub_41E8E
                lea     word_41CCA(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   loc_41EDE
; End of function Boss_SunsetStingAnimateSequence1
; Flips direction, toggles sprite flip flag, updates animation
Boss_SunsetStingFlipAndAnimate:                         ; DATA XREF: ROM:00041E40   o  ; was: sub_41E9C
                move.w  #$C,4(a5)
                andi.b  #8,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
                not.b   (byte_FFC7FC).w
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w   Boss_SunsetStingGetBodyPartPointer
                eori.w  #$800,$E(a4)
                bra.w   loc_41C28
; End of function Boss_SunsetStingFlipAndAnimate
; Loads alternate animation sequence for different pattern
Boss_SunsetStingAnimateSequence2:                       ; DATA XREF: ROM:00041952   o  ; was: sub_41EC8
                lea     word_41CAE(pc),a3
                moveq   #0,d2
                move.b  (byte_FFC7FD).w,d2
                bra.w   loc_41EDE
; End of function Boss_SunsetStingAnimateSequence2
; Loads third animation sequence and updates frame
Boss_SunsetStingAnimateSequence3:                       ; DATA XREF: ROM:00041954   o  ; was: sub_41ED6
                                        ; ROM:0004195A   o
                lea     word_41CA6(pc),a3
                move.w  #$20,d2                         ; ' '
loc_41EDE:                                              ; CODE XREF: Boss_SunsetStingAnimateSequence1+A   j
                                        ; Boss_SunsetStingAnimateSequence2+A   j
                move.b  (word_FFC7F8+1).w,d3
                move.b  (word_FFC7F8).w,d0
                eori.b  #$14,d0
                bsr.w   loc_41D58
                ori.b   #$40,-$3F(a1)                   ; '@'
                subq.b  #1,(word_FFC7F8+1).w
                bne.s   loc_41F2A
                move.b  (word_FFC7F8).w,d0
                addq.b  #4,(word_FFC7F8).w
                move.b  (word_FFC7F8).w,d1
                eor.b   d0,d1
                andi.b  #8,d1
                beq.s   loc_41F1E
                eori.b  #8,(word_FFC7F8).w
                addq.w  #2,4(a5)
                subi.w  #$80,(word_FF8234).w
loc_41F1E:                                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+36   j
                andi.b  #$E,(word_FFC7F8).w
                move.b  #$20,(word_FFC7F8+1).w          ; ' '
loc_41F2A:                                              ; CODE XREF: Boss_SunsetStingAnimateSequence3+22   j
                bra.w   loc_41C28
; End of function Boss_SunsetStingAnimateSequence3
; Checks boss health threshold for behavior branch
Boss_SunsetStingCheckHealthThreshold:                   ; CODE XREF: Boss_SunsetStingEndInvulnerability+C   j  ; was: sub_41F2E
                                        ; DATA XREF: ROM:00041956   o
                andi.b  #$BF,$4A1(a5)
                andi.b  #$BF,$6E1(a5)
                andi.b  #$BF,$921(a5)
                andi.b  #$BF,$B61(a5)
                cmpi.w  #$C0,(word_FF8234).w
                bgt.s   Boss_SunsetStingCheckPhaseTransition
                bra.w   Boss_SunsetStingInitRecoveryState
; End of function Boss_SunsetStingCheckHealthThreshold
; Checks if boss should transition to next phase
Boss_SunsetStingCheckPhaseTransition:                   ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+1E   j  ; was: sub_41F52
                tst.b   (dword_FFC6DC).w
                bne.w   Boss_SunsetStingStartDeathSequence
                bra.w   Boss_SunsetStingSetIdleState
; End of function Boss_SunsetStingCheckPhaseTransition
; Initializes boss recovery state with timer
Boss_SunsetStingInitRecoveryState:                      ; CODE XREF: Boss_SunsetStingCheckHealthThreshold+20   j  ; was: sub_41F5E
                move.b  #$C0,$4B(a5)
                move.w  #$1C,4(a5)
; End of function Boss_SunsetStingInitRecoveryState
; Moves boss upward and spawns ring of projectiles
Boss_SunsetStingRiseAndSpawnRing:                       ; DATA XREF: ROM:00041962   o  ; was: sub_41F6A
                addi.w  #2,(word_FF8234).w
                cmpi.w  #$1E0,(word_FF8234).w
                bge.w   Boss_SunsetStingSetIdleState
                move.w  #0,d0
                move.w  #3,d7
loc_41F82:                                              ; CODE XREF: Boss_SunsetStingRiseAndSpawnRing+2E   j
                lea     word_41CA6(pc),a3
                move.w  #$30,d2                         ; '0'
                move.b  (word_FFC7F8+1).w,d3
                move.w  d0,-(sp)
                bsr.w   loc_41D58
                move.w  (sp)+,d0
                addq.w  #8,d0
                dbf     d7,loc_41F82
                bra.w   loc_41C28
; End of function Boss_SunsetStingRiseAndSpawnRing
; ---------------------------------------------------------------------------
word_41FA0:     dc.w    $2A0, $4E0, $720, $960
                                        ; DATA XREF: Boss_SunsetStingUpdateMovement+FE   o
                                        ; Boss_SunsetStingUpdateMovement+12A   o

; Calculates position using sine/cosine chain physics
Boss_SunsetStingCalculateChainPosition:                 ; CODE XREF: Boss_SunsetStingUpdateMovement+134   p  ; was: sub_41FA8
                move.w  #5,d7
                move.w  $56(a5),d6
                clr.l   d3
                clr.l   d4
                lea     (a4),a3
                movea.l #Math_SineTable,a2
loc_41FBC:                                              ; CODE XREF: Boss_SunsetStingCalculateChainPosition+38   j
                add.w   $56(a3),d6
                move.w  d6,d1
                andi.w  #$1FE,d1
                move.w  (a2,d1.w),d0
                move.w  -$80(a2,d1.w),d1
                neg.w   d0
                muls.w  $4C(a3),d0
                muls.w  $4C(a3),d1
                sub.l   d1,d3
                sub.l   d0,d4
                lea     $60(a3),a3
                dbf     d7,loc_41FBC
                add.l   -$50(a3),d3
                add.l   -$4C(a3),d4
                move.l  d3,$10(a5)
                move.l  #$E00000,d0
                cmp.l   d0,d4
                bhi.s   loc_41FFC
                move.l  d0,d4
loc_41FFC:                                              ; CODE XREF: Boss_SunsetStingCalculateChainPosition+50   j
                move.l  d4,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Boss_SunsetStingCalculateChainPosition
; Initiates boss death animation sequence
