Boss_WolfGaropaIdleState:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_32DFE
                move.w  4(a5),d0
                lea     off_32E0A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_WolfGaropaIdleState
; ---------------------------------------------------------------------------
off_32E0A:      dc.w    Boss_WolfGaropaAttackState1-*   ; DATA XREF: Boss_WolfGaropaIdleState+4   o
                dc.w    Boss_WolfGaropaAttackState2-*
                dc.w    Boss_WolfGaropaSpawnProjectiles-*

; Attack state 1 handler
Boss_WolfGaropaAttackState1:                            ; DATA XREF: ROM:off_32E0A   o  ; was: sub_32E10
                move.w  #$100,2(a5)
                move.w  #$A300,$E(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                cmpi.w  #$10,(StageTableIndex).w
                bne.w   locret_30BB8
                move.w  #$18,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_WolfGaropaAttackState1
; Attack state 2 handler
Boss_WolfGaropaAttackState2:                            ; DATA XREF: ROM:00032E0C   o  ; was: sub_32E3C
                move.w  #$1D0,$10(a5)
                move.w  #$120,$14(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                subq.w  #1,$48(a5)
                move.w  #$F,d0
                jsr     (loc_2BD20).l
                ori.w   #$800,2(a0)
                move.l  #$FFF78000,$18(a0)
                jsr     (RandomNumber).l
                andi.w  #$70,d0                         ; 'p'
                addi.w  #$D0,d0
                move.w  d0,$14(a0)
                move.w  #$1D0,$10(a0)
                tst.w   $48(a5)
                bne.w   locret_30BB8
loc_32E9A:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectiles+3A   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_WolfGaropaAttackState2
; Spawns random projectiles periodically during Wolf Garopa boss fight
Boss_WolfGaropaSpawnProjectiles:                        ; DATA XREF: ROM:00032E0E   o  ; was: sub_32EA2
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_32ED8
                move.w  #$F,d0
                jsr     (loc_2BD20).l
                jsr     (RandomNumber).l
                andi.w  #$70,d0                         ; 'p'
                addi.w  #$D0,d0
                move.w  d0,$14(a0)
                move.w  #$1D0,$10(a0)
loc_32ED8:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectiles+12   j
                subq.w  #1,$48(a5)
                beq.s   loc_32E9A
                rts
; End of function Boss_WolfGaropaSpawnProjectiles
; Tracker enemy main update with angle calculation and projectile
