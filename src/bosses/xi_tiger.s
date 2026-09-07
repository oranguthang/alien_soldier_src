Boss_XiTigerAttackMain:
                bsr.w   Boss_HandleInputOffset          ; was: sub_2F1A2
                move.w  4(a5),d0
                lea     off_2F1B2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_XiTigerAttackMain
; ---------------------------------------------------------------------------
off_2F1B2:      dc.w    Boss_XiTigerAttackInit-*        ; DATA XREF: Boss_XiTigerAttackMain+8   o
                dc.w    Boss_XiTigerSpawnProjectiles-*

; Xi Tiger boss attack initialization with position setup
Boss_XiTigerAttackInit:                                 ; DATA XREF: ROM:off_2F1B2   o  ; was: sub_2F1B6
                move.w  #$C00,2(a5)
                move.w  #$18,$50(a5)
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_XiTigerAttackInit
; Xi Tiger spawns 8 projectiles with random trajectories using sine table
Boss_XiTigerSpawnProjectiles:                           ; DATA XREF: ROM:0002F1B4   o  ; was: sub_2F1D4
                move.w  #7,d7
loc_2F1D8:                                              ; CODE XREF: Boss_XiTigerSpawnProjectiles:loc_2F29C   j
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1FF,d0
                move.w  d0,$52(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                move.w  d0,$54(a5)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                move.w  d0,$56(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_2F2A0
                bsr.w   nullsub_69
                lea     (Math_SineTable).l,a4
                move.w  $52(a5),d0
                andi.w  #$1FE,d0
                move.w  (a4,d0.w),d2
                move.w  -$80(a4,d0.w),d3
                muls.w  $50(a5),d2
                muls.w  $50(a5),d3
                swap    d2
                swap    d3
                move.w  d2,$4C(a0)
                move.w  d3,$4E(a0)
                move.w  $54(a5),d0
                add.w   $4C(a5),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d2
                asl.l   #2,d2
                move.w  $56(a5),d0
                add.w   $4E(a5),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d3
                asl.l   #2,d3
                tst.l   d2
                bne.s   loc_2F278
                tst.l   d3
                bne.s   loc_2F278
                move.w  #$1000,2(a0)
                bra.w   loc_2F29C
; ---------------------------------------------------------------------------
loc_2F278:                                              ; CODE XREF: Boss_XiTigerSpawnProjectiles+94   j
                                        ; Boss_XiTigerSpawnProjectiles+98   j
                move.w  a5,$4A(a0)
                move.w  $54(a5),$58(a0)
                move.w  $56(a5),$5A(a0)
                move.l  d2,$18(a0)
                move.l  d3,$1C(a0)
                asr.l   #4,d2
                asr.l   #4,d3
                move.l  d2,$50(a0)
                move.l  d3,$54(a0)
loc_2F29C:                                              ; CODE XREF: Boss_XiTigerSpawnProjectiles+A0   j
                dbf     d7,loc_2F1D8
locret_2F2A0:                                           ; CODE XREF: Boss_XiTigerSpawnProjectiles+3C   j
                rts
; End of function Boss_XiTigerSpawnProjectiles
nullsub_69:                                             ; CODE XREF: Boss_XiTigerSpawnProjectiles+40   p
                rts
; End of function nullsub_69

; Initializes Xi Tiger projectile with position and animation
Boss_XiTigerProjectileInit:
                move.w  #$4E00,2(a0)                    ; was: sub_2F2A4
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  #$60,$20(a0)                    ; '`'
                move.w  #$480,$E(a0)
                move.l  #word_E91FA,8(a0)
                move.w  #8,$48(a0)
                rts
; End of function Boss_XiTigerProjectileInit
; Adjusts entity offset based on input bits 2 and 3
Boss_HandleInputOffset:                                 ; CODE XREF: Boss_XiTigerAttackMain   p  ; was: sub_2F2D2
                btst    #3,(word_FFF706).w
                beq.s   loc_2F2DE
                addq.w  #1,$50(a5)
loc_2F2DE:                                              ; CODE XREF: Boss_HandleInputOffset+6   j
                btst    #2,(word_FFF706).w
                beq.s   locret_2F2EA
                subq.w  #1,$50(a5)
locret_2F2EA:                                           ; CODE XREF: Boss_HandleInputOffset+12   j
                rts
; End of function Boss_HandleInputOffset
; Applies velocity to position and dispatches to state handler
Boss_ApplyVelocityDispatch:
                move.l  $50(a5),d0                      ; was: sub_2F2EC
                add.l   d0,$18(a5)
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                move.w  4(a5),d0
                lea     off_2F308(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ApplyVelocityDispatch
; ---------------------------------------------------------------------------
off_2F308:      dc.w    Boss_TimerAdvanceState-*        ; DATA XREF: Boss_ApplyVelocityDispatch+14   o
                dc.w    Boss_SyncPositionToParent-*

; Counts down timer and advances state when reaching zero
Boss_TimerAdvanceState:                                 ; DATA XREF: ROM:off_2F308   o  ; was: sub_2F30C
                subq.w  #1,$48(a5)
                bne.s   locret_2F322
                bset    #7,2(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_2F322:                                           ; CODE XREF: Boss_TimerAdvanceState+4   j
                rts
; End of function Boss_TimerAdvanceState
; Synchronizes position using sine table based on parent entity angles
Boss_SyncPositionToParent:                              ; DATA XREF: ROM:0002F30A   o  ; was: sub_2F324
                movea.w $4A(a5),a0
                move.w  $4C(a0),d0
                cmp.w   $5C(a5),d0
                beq.s   loc_2F356
                move.w  d0,$5C(a5)
                move.w  $4C(a5),d2
                move.w  $58(a5),d0
                add.w   $4C(a0),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d2
                asl.l   #2,d2
                move.l  d2,$18(a5)
                asr.l   #4,d2
                move.l  d2,$50(a5)
loc_2F356:                                              ; CODE XREF: Boss_SyncPositionToParent+C   j
                move.w  $4E(a0),d0
                cmp.w   $5E(a5),d0
                beq.w   loc_2F386
                move.w  d0,$5E(a5)
                move.w  $4E(a5),d3
                move.w  $5A(a5),d0
                add.w   $4E(a0),d0
                andi.w  #$1FE,d0
                muls.w  (a4,d0.w),d3
                asl.l   #2,d3
                move.l  d3,$1C(a5)
                asr.l   #4,d3
                move.l  d3,$54(a5)
loc_2F386:                                              ; CODE XREF: Boss_SyncPositionToParent+3A   j
                subq.w  #1,$48(a5)
                bne.s   locret_2F392
                move.w  #$1000,2(a5)
locret_2F392:                                           ; CODE XREF: Boss_SyncPositionToParent+66   j
                rts
; End of function Boss_SyncPositionToParent
nullsub_70:
                rts
; End of function nullsub_70

; Tiny wrapper calling state handler
