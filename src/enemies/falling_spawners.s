Enemy_FallingObjectDispatch:                            ; DATA XREF: ROM:off_5DC   o  ; was: sub_304E4
                move.w  4(a5),d0
                lea     off_304F0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FallingObjectDispatch
; ---------------------------------------------------------------------------
off_304F0:      dc.w    Enemy_FallingObjectInit-*       ; DATA XREF: Enemy_FallingObjectDispatch+4   o
                dc.w    Enemy_CheckSpawnTimer-*

; Initializes falling object with graphics and spawn data pointer
Enemy_FallingObjectInit:                                ; DATA XREF: ROM:off_304F0   o  ; was: sub_304F4
                move.w  #$6000,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                move.l  #word_3055C,$40(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_FallingObjectInit
; Checks camera position against spawn table timer
Enemy_CheckSpawnTimer:                                  ; DATA XREF: ROM:000304F2   o  ; was: sub_30516
                move.w  (dword_FFA904).w,d0
                movea.l $40(a5),a4
; End of function Enemy_CheckSpawnTimer
; Spawns enemy at position from table when camera reaches Y coordinate
Enemy_SpawnFromTable:                                   ; DATA XREF: ROM:0002FC48   o  ; was: sub_3051E
                cmp.w   (a4),d0
; Checks camera Y position and spawns enemy from table
Enemy_SpawnFromTable_CheckSpawn:                        ; DATA XREF: ROM:0002FC4A   o  ; was: loc_30520
                bcs.w   locret_30BB8
                jsr     (Projectile_FindFreeSlotAndClear).l
                bne.s   loc_30554
                move.w  #$CD00,2(a0)
                move.w  #$3A0,(a0)
                move.w  (a4)+,d0
                sub.w   (dword_FFA904).w,d0
                neg.w   d0
                addi.w  #$C0,d0
                move.w  d0,$14(a0)
                move.w  (a4)+,$10(a0)
                clr.w   4(a0)
                move.l  a4,$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_30554:                                              ; CODE XREF: Enemy_SpawnFromTable+C   j
                addq.w  #4,a4
                move.l  a4,$40(a5)
                rts
; End of function Enemy_SpawnFromTable
; ---------------------------------------------------------------------------
word_3055C:     dc.w    $E190, $200, $E1F0, $40, $E230, $200, $E290, $40, $E2E0, $40, $E320, $200, $E360, $200, $FFFF
                                        ; DATA XREF: Enemy_FallingObjectInit+14   o

; State dispatcher for flying enemy with multiple phases
Enemy_FlyingEnemyDispatch:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_3057A
                move.w  4(a5),d0
                lea     off_30586(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_FlyingEnemyDispatch
; ---------------------------------------------------------------------------
off_30586:      dc.w    Boss_JetsripperWeaponInit-*     ; DATA XREF: Enemy_FlyingEnemyDispatch+4   o
                dc.w    Boss_JetsripperWeaponWaitAndMove-*
                dc.w    Boss_JetsripperWeaponMoveAndSpawn-*
                dc.w    Boss_JetsripperWeaponDelayDestroy-*

; Initialize Jetsripper boss weapon properties and state
