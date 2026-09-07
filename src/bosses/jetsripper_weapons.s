Boss_JetsripperWeaponInit:                              ; DATA XREF: ROM:off_30586   o  ; was: sub_3058E
                move.w  #$CD00,2(a5)
                move.w  #$A300,$E(a5)
                move.l  #word_EB386,8(a5)
                move.b  #$3C,$20(a5)                    ; '<'
                move.w  #$64,$24(a5)                    ; 'd'
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5)                    ; '('
                move.w  #$80,$40(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponInit
; Wait for timer then move horizontally based on position
Boss_JetsripperWeaponWaitAndMove:                       ; DATA XREF: ROM:00030588   o  ; was: sub_305D6
                cmpi.w  #$100,$14(a5)
                bcs.w   locret_30BB8
                tst.w   $40(a5)
                beq.s   loc_305EC
                subq.w  #1,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_305EC:                                              ; CODE XREF: Boss_JetsripperWeaponWaitAndMove+E   j
                move.l  #$12000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bcs.s   loc_30606
                ori.w   #$800,$E(a5)
                neg.l   $18(a5)
loc_30606:                                              ; CODE XREF: Boss_JetsripperWeaponWaitAndMove+24   j
                move.w  #$50,$40(a5)                    ; 'P'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponWaitAndMove
; Move weapon and spawn projectiles before reversing direction
Boss_JetsripperWeaponMoveAndSpawn:                      ; DATA XREF: ROM:0003058A   o  ; was: sub_30612
                subq.w  #1,$40(a5)
                beq.s   loc_30650
                cmpi.w  #$10,$40(a5)
                bne.w   locret_30BB8
                move.w  $10(a5),d5
                move.w  $14(a5),d6
                move.w  #4,d3
                cmpi.w  #$120,$10(a5)
                bcc.s   loc_30642
                addi.w  #$20,d5                         ; ' '
                clr.w   d4
                bsr.w   Boss_JetsripperSpawnDirectionalProjectile
                rts
; ---------------------------------------------------------------------------
loc_30642:                                              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+22   j
                subi.w  #$20,d5                         ; ' '
                move.w  #$10,d4
                bsr.w   Boss_JetsripperSpawnDirectionalProjectile
                rts
; ---------------------------------------------------------------------------
loc_30650:                                              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+4   j
                neg.l   $18(a5)
                move.w  #$60,$40(a5)                    ; '`'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperWeaponMoveAndSpawn
; Wait for timer countdown then destroy weapon entity
Boss_JetsripperWeaponDelayDestroy:                      ; DATA XREF: ROM:0003058C   o  ; was: sub_30660
                subq.w  #1,$40(a5)
                bne.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperWeaponDelayDestroy
; Spawn projectile with directional offset and sound effect
Boss_JetsripperSpawnDirectionalProjectile:              ; CODE XREF: Boss_JetsripperWeaponMoveAndSpawn+2A   p  ; was: sub_30670
                                        ; Boss_JetsripperWeaponMoveAndSpawn+38   p
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  #$ED00,2(a0)
                move.l  #off_E968C,8(a0)
                move.w  #$3A4,(a0)
                move.w  d3,$4E(a0)
                move.w  d4,$50(a0)
                move.w  a5,$48(a0)
                move.w  d5,$10(a0)
                sub.w   $10(a5),d5
                move.w  d5,$4A(a0)
                move.w  d6,$14(a0)
                sub.w   $14(a5),d6
                move.w  d6,$4C(a0)
                move.b  #0,$20(a0)
                move.w  d4,d0
                lsr.w   #1,d0
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                lea     word_30834(pc),a1
                nop
                or.w    (a1,d0.w),d1
                move.w  d1,$E(a0)
                move.w  #$3A4,(a0)
                clr.w   4(a0)
                move.w  #$10,$46(a0)
                move.b  #$CE,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_JetsripperSpawnDirectionalProjectile
; Projectile state dispatcher using jump table for behavior selection
Projectile_StateDispatcher:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_306EA
                move.w  4(a5),d0
                lea     off_306F6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_StateDispatcher
; ---------------------------------------------------------------------------
off_306F6:      dc.w    Boss_JetsripperProjectileTrackAndSplit-*  ; DATA XREF: Projectile_StateDispatcher+4   o
                dc.w    Boss_JetsripperFragmentDelayMove-*
                dc.w    Boss_JetsripperSpawnFragmentSpread-*
                dc.w    Boss_JetsripperFragmentHandleHit-*
                dc.w    Projectile_CheckAnimThreshold-*
                dc.w    Projectile_ApplyGravity-*

; Track parent entity position then split into fragment spread
Boss_JetsripperProjectileTrackAndSplit:                 ; DATA XREF: ROM:off_306F6   o  ; was: sub_30702
                movea.w $48(a5),a4
                move.w  $10(a4),d0
                add.w   $4A(a5),d0
                move.w  d0,$10(a5)
                move.w  $14(a4),d0
                add.w   $4C(a5),d0
                move.w  d0,$14(a5)
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.w  2(a5),d5
                andi.w  #$DFFF,d5
                move.w  #$1000,2(a5)
                lea     $54(a5),a3
                move.w  $50(a5),d4
                move.w  $4E(a5),d3
loc_30740:                                              ; CODE XREF: Boss_JetsripperProjectileTrackAndSplit+C8   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  d5,2(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  d4,$50(a0)
                move.b  #0,$20(a0)
                move.w  $E(a5),$E(a0)
                move.w  #$3A4,(a0)
                move.w  #2,4(a0)
                move.w  d3,d0
                lsl.w   #1,d0
                move.w  d0,d1
                lsl.w   #1,d0
                add.w   d1,d0
                addq.w  #1,d0
                move.w  d0,$46(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  d4,d0
                move.l  off_30814(pc,d0.w),8(a0)
                move.l  dword_307D4(pc,d0.w),$48(a0)
                move.l  dword_307F4(pc,d0.w),$4C(a0)
                move.l  $48(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$10(a0)
                move.l  $4C(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$14(a0)
                move.w  a0,(a3)+
                dbf     d3,loc_30740
                bsr.w   Boss_JetsripperCopyFragmentReferences
                rts
; End of function Boss_JetsripperProjectileTrackAndSplit
; ---------------------------------------------------------------------------
dword_307D4:    dc.l    $40000, $2D414                  ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+9A   r
                                        ; Boss_JetsripperSpawnFragmentSpread+8C   o
                dc.l    0, $FFFD2BEC
                dc.l    $FFFC0000, $FFFD2BEC
                dc.l    0, $2D414
dword_307F4:    dc.l    0, $2D414                       ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+A0   r
                                        ; Boss_JetsripperSpawnFragmentSpread+96   o
                dc.l    $40000, $2D414
                dc.l    0, $FFFD2BEC
                dc.l    $FFFC0000, $FFFD2BEC
off_30814:      dc.l    word_E9530                      ; DATA XREF: Boss_JetsripperProjectileTrackAndSplit+94   r
                                        ; Boss_JetsripperSpawnFragmentSpread+82   o
                dc.l    word_E9536
                dc.l    word_E952A
                dc.l    word_E9536
                dc.l    word_E9530
                dc.l    word_E9536
                dc.l    word_E952A
                dc.l    word_E9536
word_30834:     dc.w    $800, $1800, $1800, $1000, 0, 0, $800, $800
                                        ; DATA XREF: Boss_JetsripperSpawnDirectionalProjectile+52   o
                                        ; Boss_JetsripperSpawnFragmentSpread+AA   o

; Copy fragment entity references between parent and child
Boss_JetsripperCopyFragmentReferences:                  ; CODE XREF: Boss_JetsripperProjectileTrackAndSplit+CC   p  ; was: sub_30844
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$28,$26(a0)                    ; '('
                lea     $54(a5),a3
                lea     $54(a0),a4
                move.w  $4E(a5),d3
                move.w  d3,$52(a0)
loc_30860:                                              ; CODE XREF: Boss_JetsripperCopyFragmentReferences+1E   j
                move.w  (a3)+,(a4)+
                dbf     d3,loc_30860
                rts
; End of function Boss_JetsripperCopyFragmentReferences
; Calculate 8-way directional index from player position flags
Boss_JetsripperGetDirectionIndex:                       ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+34   p  ; was: sub_30868
                btst    #3,(word_FFF706).w
                bne.s   loc_30894
                btst    #3,(word_FFF706).w
                bne.s   loc_308A6
                btst    #0,(word_FFF706).w
                bne.s   loc_308DC
                btst    #1,(word_FFF706).w
                bne.s   loc_308C4
                move.w  (word_FFA40E).w,d0
                andi.w  #$800,d0
                bne.s   loc_308B8
                bra.s   loc_308D0
; ---------------------------------------------------------------------------
loc_30894:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+6   j
                btst    #0,(word_FFF706).w
                bne.s   loc_308E2
                btst    #1,(word_FFF706).w
                bne.s   loc_308BE
                bra.s   loc_308B8
; ---------------------------------------------------------------------------
loc_308A6:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+E   j
                btst    #0,(word_FFF706).w
                bne.s   loc_308D6
                btst    #1,(word_FFF706).w
                bne.s   loc_308CA
                bra.s   loc_308D0
; ---------------------------------------------------------------------------
loc_308B8:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+28   j
                                        ; Boss_JetsripperGetDirectionIndex+3C   j
                move.w  #$10,d4
                rts
; ---------------------------------------------------------------------------
loc_308BE:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+3A   j
                move.w  #$14,d4
                rts
; ---------------------------------------------------------------------------
loc_308C4:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+1E   j
                move.w  #$18,d4
                rts
; ---------------------------------------------------------------------------
loc_308CA:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+4C   j
                move.w  #$1C,d4
                rts
; ---------------------------------------------------------------------------
loc_308D0:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+2A   j
                                        ; Boss_JetsripperGetDirectionIndex+4E   j
                move.w  #0,d4
                rts
; ---------------------------------------------------------------------------
loc_308D6:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+44   j
                move.w  #4,d4
                rts
; ---------------------------------------------------------------------------
loc_308DC:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+16   j
                move.w  #8,d4
                rts
; ---------------------------------------------------------------------------
loc_308E2:                                              ; CODE XREF: Boss_JetsripperGetDirectionIndex+32   j
                move.w  #$C,d4
                rts
; End of function Boss_JetsripperGetDirectionIndex
; Wait for timer then apply stored velocity to fragment
Boss_JetsripperFragmentDelayMove:                       ; DATA XREF: ROM:000306F8   o  ; was: sub_308E8
                subq.w  #1,$46(a5)
                bne.w   locret_30BB8
                move.l  $48(a5),$18(a5)
                move.l  $4C(a5),$1C(a5)
                move.w  #$40,$46(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperFragmentDelayMove
; Spawn circular spread of fragments when hit by player
Boss_JetsripperSpawnFragmentSpread:                     ; DATA XREF: ROM:000306FA   o  ; was: sub_30908
                subq.w  #1,$46(a5)
                beq.w   loc_309EA
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                bclr    #4,$22(a5)
                beq.w   locret_30BB8
                move.w  2(a5),d5
                lea     $54(a5),a3
                move.w  $52(a5),d3
loc_30930:                                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+30   j
                movea.w (a3)+,a4
                move.w  #$1000,2(a4)
                dbf     d3,loc_30930
                bsr.w   Boss_JetsripperGetDirectionIndex
                move.w  $52(a5),d3
loc_30944:                                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+DC   j
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.w  d5,2(a0)
                clr.b   $22(a0)
                move.b  #1,$21(a0)
                bsr.w   Boss_JetsripperSetDifficultyHP2
                move.w  #$3A4,(a0)
                move.b  #0,$20(a0)
                move.w  #6,4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  d3,d0
                lsl.w   #4,d0
                move.w  d4,d1
                lsr.w   #1,d1
                add.w   d1,d0
                move.w  word_309F2(pc,d0.w),d0
                lea     off_30814(pc),a1
                move.l  (a1,d0.w),8(a0)
                lea     dword_307D4(pc),a1
                move.l  (a1,d0.w),$18(a0)
                lea     dword_307F4(pc),a1
                move.l  (a1,d0.w),$1C(a0)
                lsr.w   #1,d0
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                lea     word_30834(pc),a1
                or.w    (a1,d0.w),d1
                move.w  d1,$E(a0)
                move.l  $18(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$10(a0)
                move.l  $1C(a0),d0
                move.l  d0,d1
                lsl.l   #1,d0
                add.l   d1,d0
                swap    d0
                add.w   d0,$14(a0)
                move.w  #$40,$46(a0)                    ; '@'
                dbf     d3,loc_30944
                rts
; ---------------------------------------------------------------------------
loc_309EA:                                              ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+4   j
                                        ; Boss_JetsripperFragmentHandleHit+8   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_JetsripperSpawnFragmentSpread
; ---------------------------------------------------------------------------
word_309F2:     dc.w    $10, $14, $18, $1C, 0, 4, 8, $C, $14, $18, $1C, 0, 4, 8, $C, $10, $C
                                        ; DATA XREF: Boss_JetsripperSpawnFragmentSpread+7E   r
                dc.w    $10, $14, $18, $1C, 0, 4, 8, $18, $1C, 0, 4, 8, $C, $10, $14, 8, $C
                dc.w    $10, $14, $18, $1C, 0, 4

; Handle fragment collision and destroy after timer expires
Boss_JetsripperFragmentHandleHit:                       ; DATA XREF: ROM:000306FC   o  ; was: sub_30A42
                bsr.w   Projectile_HandleHit
                subq.w  #1,$46(a5)
                beq.s   loc_309EA
                rts
; End of function Boss_JetsripperFragmentHandleHit
; Checks if animation frame counter exceeds threshold for state change
Projectile_CheckAnimThreshold:                          ; DATA XREF: ROM:000306FE   o  ; was: sub_30A4E
                cmpi.w  #$80,$C(a5)
                bcs.w   locret_30BB8
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_CheckAnimThreshold
; Applies gravity to projectile with hit detection and lifetime check
Projectile_ApplyGravity:                                ; DATA XREF: ROM:00030700   o  ; was: sub_30A60
                addi.l  #$2000,$1C(a5)
                bsr.w   Projectile_HandleHit
                subq.w  #1,$46(a5)
                beq.w   loc_309EA
                rts
; End of function Projectile_ApplyGravity
; Handles projectile hit changing sprite state and clearing collision flags
Projectile_HandleHit:                                   ; CODE XREF: Boss_JetsripperFragmentHandleHit   p  ; was: sub_30A76
                                        ; Projectile_ApplyGravity+8   p
                bclr    #7,$22(a5)
                beq.w   locret_30BB8
                clr.b   $22(a5)
                move.w  #$8480,$E(a5)
                move.w  #$EC00,2(a5)
                move.l  #off_E9850,8(a5)
                clr.w   $C(a5)
                clr.b   $21(a5)
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #8,4(a5)
                rts
; End of function Projectile_HandleHit
; Handles projectile deflection and bounce with directional velocity
Projectile_DeflectBounce:                               ; CODE XREF: Enemy_InitProjectileType+68   j  ; was: sub_30ABA
                                        ; Projectile_GravityBounce+1A   j
                clr.b   $22(a5)
                move.w  #$3A4,(a5)
                move.w  #$80,$46(a5)
                move.w  #$A,4(a5)
                move.b  #1,$21(a5)
                bsr.w   Boss_JetsripperSetDifficultyHP1
                move.l  #$FFFE0000,$1C(a5)
                btst    #3,(word_FFF706).w
                bne.s   loc_30B04
                btst    #3,(word_FFF706).w
                bne.s   loc_30AFA
                move.w  (word_FFA40E).w,d0
                andi.w  #$800,d0
                bne.s   loc_30B04
loc_30AFA:                                              ; CODE XREF: Projectile_DeflectBounce+34   j
                move.l  #$FFFA0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_30B04:                                              ; CODE XREF: Projectile_DeflectBounce+2C   j
                                        ; Projectile_DeflectBounce+3E   j
                move.l  #$60000,$18(a5)
                rts
; End of function Projectile_DeflectBounce
; Set entity HP value based on difficulty level check
Boss_JetsripperSetDifficultyHP1:                        ; CODE XREF: Projectile_DeflectBounce+1A   p  ; was: sub_30B0E
                tst.w   (word_FFFF0E).w
                beq.s   loc_30B1C
                move.w  #$64,$26(a5)                    ; 'd'
                rts
; ---------------------------------------------------------------------------
loc_30B1C:                                              ; CODE XREF: Boss_JetsripperSetDifficultyHP1+4   j
                move.w  #$C8,$26(a5)
                rts
; End of function Boss_JetsripperSetDifficultyHP1
; Set entity HP value based on difficulty level check
Boss_JetsripperSetDifficultyHP2:                        ; CODE XREF: Boss_JetsripperSpawnFragmentSpread+54   p  ; was: sub_30B24
                tst.w   (word_FFFF0E).w
                beq.s   loc_30B32
                move.w  #$64,$26(a0)                    ; 'd'
                rts
; ---------------------------------------------------------------------------
loc_30B32:                                              ; CODE XREF: Boss_JetsripperSetDifficultyHP2+4   j
                move.w  #$C8,$26(a0)
                rts
; End of function Boss_JetsripperSetDifficultyHP2
; Dispatch to spawner state handler via jump table
