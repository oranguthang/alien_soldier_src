Boss_ValkirieInitSubEntities:
                move.w  #8,d7                           ; was: sub_548EE
                lea     $360(a5),a0
loc_548F6:                                              ; CODE XREF: Boss_ValkirieInitSubEntities+28   j
                move.w  #$10,(a0)
                move.l  #off_E9680,8(a0)
                clr.w   $C(a0)
                move.w  #$EC80,2(a0)
                move.w  #$8480,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_548F6
                rts
; End of function Boss_ValkirieInitSubEntities
; Updates positions of sub-entities relative to main boss and $180 offset entity
Boss_ValkirieUpdateSubPositions:
                lea     $360(a5),a0                     ; was: sub_5491C
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                lea     $60(a0),a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                add.b   $2C(a5),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                add.b   $2D(a5),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.b   $2E(a5),d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                move.w  $14(a5),$14(a0)
                move.w  $10(a5),d0
                add.b   $2F(a5),d0
                move.w  d0,$10(a0)
                lea     $180(a5),a1
                lea     $60(a0),a0
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),d0
                add.b   $2C(a1),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),d0
                add.b   $2D(a1),d0
                move.w  d0,$14(a0)
                lea     $60(a0),a0
                move.w  $14(a1),$14(a0)
                move.w  $10(a1),d0
                add.b   $2E(a1),d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                move.w  $14(a1),$14(a0)
                move.w  $10(a1),d0
                add.b   $2F(a1),d0
                move.w  d0,$10(a0)
                rts
; End of function Boss_ValkirieUpdateSubPositions
; Dispatcher for Valkirie projectile entity state machine
Entity_ValkirieProjectileDispatcher:                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_549E2
                move.w  4(a5),d0
                movea.w off_549F2(pc,d0.w),a0
                adda.l  #nullsub_126,a0
                jmp     (a0)
; End of function Entity_ValkirieProjectileDispatcher
; ---------------------------------------------------------------------------
off_549F2:      dc.w    Entity_ValkirieProjectileInit-nullsub_126
                                        ; DATA XREF: Entity_ValkirieProjectileDispatcher+4   r
                dc.w    Entity_ValkirieProjectileMove-nullsub_126
                dc.w    Entity_ValkirieProjectileDecelerate-nullsub_126
                dc.w    Entity_ValkirieProjectileGrowAnimation-nullsub_126
                dc.w    Entity_ValkirieProjectileWaitTimer-nullsub_126
                dc.w    Entity_ValkirieProjectileMoveLeft-nullsub_126
                dc.w    Entity_ValkirieProjectileShrinkAndLaunch-nullsub_126
                dc.w    Entity_ValkirieProjectileCleanup-nullsub_126

nullsub_126:                                            ; CODE XREF: Entity_ValkirieProjectileWaitTimer+4   j
                                        ; Entity_ValkirieProjectileMoveLeft+A   j
                rts
; End of function nullsub_126

; Initializes Valkirie projectile with velocity and sprite data
Entity_ValkirieProjectileInit:                          ; DATA XREF: ROM:off_549F2   o  ; was: sub_54A04
                addq.w  #2,4(a5)
                move.w  #$ED00,2(a5)
                move.w  #$2B00,$E(a5)
                move.b  #$14,$20(a5)
                move.l  #$10000,$1C(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_ValkirieProjectileInit
; Moves projectile and updates shadow entity position
Entity_ValkirieProjectileMove:                          ; DATA XREF: ROM:000549F4   o  ; was: sub_54A30
                cmpi.w  #$120,$14(a5)
                bmi.s   loc_54A3C
                addq.w  #2,4(a5)
loc_54A3C:                                              ; CODE XREF: Entity_ValkirieProjectileMove+6   j
                                        ; sub_54A5A:loc_54A7E   j
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  $14(a5),d0
                addi.w  #$10,d0
                move.w  d0,$14(a0)
                move.w  $10(a5),d0
                addi.w  #$B,d0
                move.w  d0,$10(a0)
                rts
; End of function Entity_ValkirieProjectileMove
; Decelerates projectile until reaching Y position $140
Entity_ValkirieProjectileDecelerate:                    ; DATA XREF: ROM:000549F6   o  ; was: sub_54A5A
                subi.l  #$200,$1C(a5)
                cmpi.w  #$140,$14(a5)
                bmi.s   loc_54A7E
                addq.w  #2,4(a5)
                move.w  #$130,$14(a5)
                clr.l   $1C(a5)
                move.w  #4,$48(a5)
loc_54A7E:                                              ; CODE XREF: Entity_ValkirieProjectileDecelerate+E   j
                bra.s   loc_54A3C
; End of function Entity_ValkirieProjectileDecelerate
; Grows projectile sprite by incrementing animation frame counter
Entity_ValkirieProjectileGrowAnimation:                 ; DATA XREF: ROM:000549F8   o  ; was: sub_54A80
                move.w  #$150,(word_FFDB94).w
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_54AA6
                addq.w  #4,$48(a5)
                cmpi.w  #$10,$48(a5)
                bmi.s   loc_54AA6
                addq.w  #2,4(a5)
                move.w  #$28,$4A(a5)                    ; '('
loc_54AA6:                                              ; CODE XREF: Entity_ValkirieProjectileGrowAnimation+E   j
                                        ; Entity_ValkirieProjectileGrowAnimation+1A   j
                bra.w   Boss_ValkirieDMATransferTable
; End of function Entity_ValkirieProjectileGrowAnimation
; Waits for timer countdown before changing animation
Entity_ValkirieProjectileWaitTimer:                     ; DATA XREF: ROM:000549FA   o  ; was: sub_54AAA
                subq.w  #1,$4A(a5)
                bpl.w   nullsub_126
                addq.w  #2,4(a5)
                move.l  #off_ECE90,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_ValkirieProjectileWaitTimer
; Applies gravity and moves projectile leftward until X reaches $150
Entity_ValkirieProjectileMoveLeft:                      ; DATA XREF: ROM:000549FC   o  ; was: sub_54AC4
                bsr.w   Boss_ValkirieApplyGravity
                cmpi.w  #$150,$10(a5)
                bpl.w   nullsub_126
                addq.w  #2,4(a5)
                rts
; End of function Entity_ValkirieProjectileMoveLeft
; Shrinks projectile animation and launches shadow downward
Entity_ValkirieProjectileShrinkAndLaunch:               ; DATA XREF: ROM:000549FE   o  ; was: sub_54AD8
                bsr.w   Boss_ValkirieApplyGravity
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_54B02
                subq.w  #4,$48(a5)
                bne.s   loc_54B02
                addq.w  #2,4(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.l  #$FFFE8000,$1C(a0)
                bset    #1,2(a0)
loc_54B02:                                              ; CODE XREF: Entity_ValkirieProjectileShrinkAndLaunch+C   j
                                        ; Entity_ValkirieProjectileShrinkAndLaunch+12   j
                bra.w   Boss_ValkirieDMATransferTable
; End of function Entity_ValkirieProjectileShrinkAndLaunch
; Clears velocity and resets animation, sets completion flag
Entity_ValkirieProjectileCleanup:                       ; DATA XREF: ROM:00054A00   o  ; was: sub_54B06
                clr.l   $18(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                move.b  #1,(byte_FFA958).w
                rts
; End of function Entity_ValkirieProjectileCleanup
; Applies gravity deceleration to Y velocity if not already falling
Boss_ValkirieApplyGravity:                              ; CODE XREF: Entity_ValkirieProjectileMoveLeft   p  ; was: sub_54B1E
                                        ; sub_54AD8   p
                cmpi.w  #$FFFF,$18(a5)
                bmi.s   locret_54B2E
                subi.l  #$C00,$18(a5)
locret_54B2E:                                           ; CODE XREF: Boss_ValkirieApplyGravity+6   j
                rts
; End of function Boss_ValkirieApplyGravity
; Performs DMA transfer based on animation frame index
Boss_ValkirieDMATransferTable:                          ; CODE XREF: Entity_ValkirieProjectileGrowAnimation:loc_54AA6   j  ; was: sub_54B30
                                        ; sub_54AD8:loc_54B02   j
                move.w  $48(a5),d0
                movea.l off_54B3E(pc,d0.w),a0
                jmp     Gfx_DMATransferTiles
; End of function Boss_ValkirieDMATransferTable
; ---------------------------------------------------------------------------
off_54B3E:      dc.l    byte_54B52                      ; DATA XREF: Boss_ValkirieDMATransferTable+4   r
                dc.l    byte_54B5C
                dc.l    byte_54B66
                dc.l    byte_54B70
                dc.l    byte_54B7A
byte_54B52:     dc.b    $48, $F0, $40, 0, 0, 3, $65, $5A, $6E, $72
                                        ; DATA XREF: ROM:off_54B3E   o
byte_54B5C:     dc.b    $48, $F0, $40, 0, 0, 3, $66, $6A, $6F, $73
                                        ; DATA XREF: ROM:00054B42   o
byte_54B66:     dc.b    $48, $F0, $40, 0, 0, 3, $67, $6B, $70, $74
                                        ; DATA XREF: ROM:00054B46   o
byte_54B70:     dc.b    $48, $F0, $40, 0, 0, 3, $68, $6C, $71, $75
                                        ; DATA XREF: ROM:00054B4A   o
byte_54B7A:     dc.b    $48, $F0, $40, 0, 0, 3, $69, $6D, $6D, $76
                                        ; DATA XREF: ROM:00054B4E   o

; Seven Forces entity main handler
