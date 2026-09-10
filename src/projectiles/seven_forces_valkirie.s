; Initialize nine $60-byte sub-entities used by the two Valkirie anchors
Boss_ValkirieInitSubEntities:
                move.w  #8,d7                           ; was: sub_548EE
                lea     $360(a5),a0
Boss_ValkirieInitSubEntityLoop:                         ; CODE XREF: Boss_ValkirieInitSubEntities+28   j  ; was: loc_548F6
                move.w  #$10,(a0)
                move.l  #off_E9680,8(a0)
                clr.w   $C(a0)
                move.w  #$EC80,2(a0)
                move.w  #$8480,$E(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_ValkirieInitSubEntityLoop
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
                movea.w Entity_ValkirieProjectileStateOffsets(pc,d0.w),a0
                adda.l  #Entity_SevenForcesNoOpState,a0
                jmp     (a0)
; End of function Entity_ValkirieProjectileDispatcher
; ---------------------------------------------------------------------------
Entity_ValkirieProjectileStateOffsets:  dc.w    Entity_ValkirieProjectileInit-Entity_SevenForcesNoOpState  ; was: off_549F2
                                        ; DATA XREF: Entity_ValkirieProjectileDispatcher+4   r
                dc.w    Entity_ValkirieProjectileMove-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileDecelerate-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileGrowAnimation-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileWaitTimer-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileMoveLeft-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileShrinkAndLaunch-Entity_SevenForcesNoOpState
                dc.w    Entity_ValkirieProjectileCleanup-Entity_SevenForcesNoOpState

Entity_SevenForcesNoOpState:                            ; CODE XREF: Entity_ValkirieProjectileWaitTimer+4   j  ; was: nullsub_126
                                        ; Entity_ValkirieProjectileMoveLeft+A   j
                rts
; End of function Entity_SevenForcesNoOpState

; Initializes Valkirie projectile with velocity and sprite data
Entity_ValkirieProjectileInit:                          ; DATA XREF: ROM:Entity_ValkirieProjectileStateOffsets   o  ; was: sub_54A04
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
                bmi.s   Entity_ValkirieProjectileUpdateShadowPosition
                addq.w  #2,4(a5)
Entity_ValkirieProjectileUpdateShadowPosition:          ; CODE XREF: Entity_ValkirieProjectileMove+6   j  ; was: loc_54A3C
                                        ; Entity_ValkirieProjectileDecelerate:Entity_ValkirieProjectileContinueShadowSync   j
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
                bmi.s   Entity_ValkirieProjectileContinueShadowSync
                addq.w  #2,4(a5)
                move.w  #$130,$14(a5)
                clr.l   $1C(a5)
                move.w  #4,$48(a5)
Entity_ValkirieProjectileContinueShadowSync:            ; CODE XREF: Entity_ValkirieProjectileDecelerate+E   j  ; was: loc_54A7E
                bra.s   Entity_ValkirieProjectileUpdateShadowPosition
; End of function Entity_ValkirieProjectileDecelerate
; Grows projectile sprite by incrementing animation frame counter
Entity_ValkirieProjectileGrowAnimation:                 ; DATA XREF: ROM:000549F8   o  ; was: sub_54A80
                move.w  #$150,(word_FFDB94).w
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   Entity_ValkirieProjectileTransferGrowthFrame
                addq.w  #4,$48(a5)
                cmpi.w  #$10,$48(a5)
                bmi.s   Entity_ValkirieProjectileTransferGrowthFrame
                addq.w  #2,4(a5)
                move.w  #$28,$4A(a5)                    ; '('
Entity_ValkirieProjectileTransferGrowthFrame:           ; CODE XREF: Entity_ValkirieProjectileGrowAnimation+E   j  ; was: loc_54AA6
                                        ; Entity_ValkirieProjectileGrowAnimation+1A   j
                bra.w   Entity_ValkirieProjectileTransferAnimationTiles
; End of function Entity_ValkirieProjectileGrowAnimation
; Waits for timer countdown before changing animation
Entity_ValkirieProjectileWaitTimer:                     ; DATA XREF: ROM:000549FA   o  ; was: sub_54AAA
                subq.w  #1,$4A(a5)
                bpl.w   Entity_SevenForcesNoOpState
                addq.w  #2,4(a5)
                move.l  #off_ECE90,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_ValkirieProjectileWaitTimer
; Accelerate leftward until the projectile crosses X=$150
Entity_ValkirieProjectileMoveLeft:                      ; DATA XREF: ROM:000549FC   o  ; was: sub_54AC4
                bsr.w   Entity_ValkirieProjectileAccelerateLeft
                cmpi.w  #$150,$10(a5)
                bpl.w   Entity_SevenForcesNoOpState
                addq.w  #2,4(a5)
                rts
; End of function Entity_ValkirieProjectileMoveLeft
; Shrink the animation, then give the shadow a negative vertical velocity
Entity_ValkirieProjectileShrinkAndLaunch:               ; DATA XREF: ROM:000549FE   o  ; was: sub_54AD8
                bsr.w   Entity_ValkirieProjectileAccelerateLeft
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   Entity_ValkirieProjectileTransferShrinkFrame
                subq.w  #4,$48(a5)
                bne.s   Entity_ValkirieProjectileTransferShrinkFrame
                addq.w  #2,4(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.l  #$FFFE8000,$1C(a0)
                bset    #1,2(a0)
Entity_ValkirieProjectileTransferShrinkFrame:           ; CODE XREF: Entity_ValkirieProjectileShrinkAndLaunch+C   j  ; was: loc_54B02
                                        ; Entity_ValkirieProjectileShrinkAndLaunch+12   j
                bra.w   Entity_ValkirieProjectileTransferAnimationTiles
; End of function Entity_ValkirieProjectileShrinkAndLaunch
; Clears velocity and resets animation, sets completion flag
Entity_ValkirieProjectileCleanup:                       ; DATA XREF: ROM:00054A00   o  ; was: sub_54B06
                clr.l   $18(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                move.b  #1,(byte_FFA958).w
                rts
; End of function Entity_ValkirieProjectileCleanup
; Subtract from horizontal velocity until its integer part is below -1
Entity_ValkirieProjectileAccelerateLeft:                ; CODE XREF: Entity_ValkirieProjectileMoveLeft   p  ; was: sub_54B1E
                                        ; Entity_ValkirieProjectileShrinkAndLaunch   p
                cmpi.w  #$FFFF,$18(a5)
                bmi.s   Entity_ValkirieProjectileAccelerateLeftReturn
                subi.l  #$C00,$18(a5)
Entity_ValkirieProjectileAccelerateLeftReturn:          ; CODE XREF: Entity_ValkirieProjectileAccelerateLeft+6   j  ; was: locret_54B2E
                rts
; End of function Entity_ValkirieProjectileAccelerateLeft
; Select the current frame descriptor and transfer its tiles by DMA
Entity_ValkirieProjectileTransferAnimationTiles:        ; CODE XREF: Entity_ValkirieProjectileGrowAnimation:Entity_ValkirieProjectileTransferGrowthFrame   j  ; was: sub_54B30
                                        ; Entity_ValkirieProjectileShrinkAndLaunch:Entity_ValkirieProjectileTransferShrinkFrame   j
                move.w  $48(a5),d0
                movea.l Entity_ValkirieProjectileTileTransferDescriptors(pc,d0.w),a0
                jmp     Gfx_DMATransferTiles
; End of function Entity_ValkirieProjectileTransferAnimationTiles
; ---------------------------------------------------------------------------
Entity_ValkirieProjectileTileTransferDescriptors:   dc.l    Entity_ValkirieProjectileTileTransferFrame0  ; DATA XREF: Entity_ValkirieProjectileTransferAnimationTiles+4   r  ; was: off_54B3E
                dc.l    Entity_ValkirieProjectileTileTransferFrame1
                dc.l    Entity_ValkirieProjectileTileTransferFrame2
                dc.l    Entity_ValkirieProjectileTileTransferFrame3
                dc.l    Entity_ValkirieProjectileTileTransferFrame4
Entity_ValkirieProjectileTileTransferFrame0:    dc.b    $48, $F0, $40, 0, 0, 3, $65, $5A, $6E, $72  ; was: byte_54B52
                                        ; DATA XREF: ROM:Entity_ValkirieProjectileTileTransferDescriptors   o
Entity_ValkirieProjectileTileTransferFrame1:    dc.b    $48, $F0, $40, 0, 0, 3, $66, $6A, $6F, $73  ; was: byte_54B5C
                                        ; DATA XREF: ROM:00054B42   o
Entity_ValkirieProjectileTileTransferFrame2:    dc.b    $48, $F0, $40, 0, 0, 3, $67, $6B, $70, $74  ; was: byte_54B66
                                        ; DATA XREF: ROM:00054B46   o
Entity_ValkirieProjectileTileTransferFrame3:    dc.b    $48, $F0, $40, 0, 0, 3, $68, $6C, $71, $75  ; was: byte_54B70
                                        ; DATA XREF: ROM:00054B4A   o
Entity_ValkirieProjectileTileTransferFrame4:    dc.b    $48, $F0, $40, 0, 0, 3, $69, $6D, $6D, $76  ; was: byte_54B7A
                                        ; DATA XREF: ROM:00054B4E   o

; Seven Forces entity main handler
