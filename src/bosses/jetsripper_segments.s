; Updates an oscillating angle in eight-unit steps
Boss_UpdateOscillatingAngle:
                move.w  $56(a5),d0                      ; was: sub_35E1E
                tst.w   $4C(a5)
                beq.s   Boss_UpdateOscillatingAngleIncrease
                subq.w  #8,d0
                andi.w  #$1F8,d0
                cmpi.w  #$1A8,d0
                bne.s   Boss_UpdateOscillatingAngleStore
                move.w  #$1B0,d0
                cmpi.w  #$128,$14(a5)
                bmi.s   Boss_UpdateOscillatingAngleStore
                clr.w   $4C(a5)
                bra.s   Boss_UpdateOscillatingAngleStore
; ---------------------------------------------------------------------------
Boss_UpdateOscillatingAngleIncrease:                    ; CODE XREF: Boss_UpdateOscillatingAngle+8   j  ; was: loc_35E46
                addq.w  #8,d0
                andi.w  #$1F8,d0
                cmpi.w  #$58,d0                         ; 'X'
                bne.s   Boss_UpdateOscillatingAngleStore
                addq.w  #1,$4C(a5)
Boss_UpdateOscillatingAngleStore:                       ; CODE XREF: Boss_UpdateOscillatingAngle+14   j  ; was: loc_35E56
                                        ; Boss_UpdateOscillatingAngle+20   j
                move.w  d0,$56(a5)
                rts
; End of function Boss_UpdateOscillatingAngle
; Finds sprite segment with lowest Y position in chain
Boss_FindLowestSegment:
                movea.w #(SecondaryEntityType-M68K_RAM),a0  ; was: sub_35E5C
                movea.w a5,a1
                move.l  $44(a5),d1
                moveq   #$10,d7
Boss_FindLowestSegmentNextCandidate:                    ; CODE XREF: Boss_FindLowestSegment+1C   j  ; was: loc_35E68
                cmp.l   $44(a0),d1
                bpl.s   Boss_FindLowestSegmentAdvance
                move.l  $44(a0),d1
                movea.w a0,a1
Boss_FindLowestSegmentAdvance:                          ; CODE XREF: Boss_FindLowestSegment+10   j  ; was: loc_35E74
                lea     $60(a0),a0
                dbf     d7,Boss_FindLowestSegmentNextCandidate
                move.w  a1,$48(a5)
                move.w  a1,$4A(a5)
                move.w  #$144,$14(a1)
                rts
; End of function Boss_FindLowestSegment
; Selects the visually lowest segment (largest Y coordinate) for targeting
Boss_JetsripperFindLowestSegment:                       ; CODE XREF: Boss_JetsripperRotateState+34   p  ; was: sub_35E8C
                                        ; Boss_JetsripperUpdateMovement+92   p
                movea.w #(word_FFC920-M68K_RAM),a0
                movea.w #(word_FFC8C0-M68K_RAM),a1
                move.l  $44(a1),d1
                moveq   #3,d7
Boss_JetsripperFindLowestSegmentNextCandidate:          ; CODE XREF: Boss_JetsripperFindLowestSegment+1E   j  ; was: loc_35E9A
                cmp.l   $44(a0),d1
                bpl.s   Boss_JetsripperFindLowestSegmentAdvance
                move.l  $44(a0),d1
                movea.w a0,a1
Boss_JetsripperFindLowestSegmentAdvance:                ; CODE XREF: Boss_JetsripperFindLowestSegment+12   j  ; was: loc_35EA6
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperFindLowestSegmentNextCandidate
                move.w  a1,$48(a5)
                move.w  a1,$4A(a5)
                move.w  #$144,$14(a1)
                rts
; End of function Boss_JetsripperFindLowestSegment
; Updates sprites for all body segments
Boss_JetsripperUpdateAllSprites:                        ; CODE XREF: Boss_JetsripperRotateState+48   p  ; was: sub_35EBE
                                        ; Boss_JetsripperUpdateMovement+A6   p
                movea.w a5,a0
                movea.l #Boss_JetsripperHeadFrames,a1
                moveq   #0,d7
                bsr.s   Boss_JetsripperUpdateEndSprite
                movea.l #Boss_JetsripperBodyDirectionFrames,a1
                moveq   #$F,d7
                bsr.s   Boss_JetsripperUpdateBodySprite
                movea.l #Boss_JetsripperTailFrames,a1
                moveq   #0,d7
; End of function Boss_JetsripperUpdateAllSprites
; Updates a head or tail sprite with four-direction facing
Boss_JetsripperUpdateEndSprite:                         ; CODE XREF: Boss_JetsripperUpdateAllSprites+A   p  ; was: sub_35EDC
                                        ; Boss_JetsripperUpdateEndSprite+4A   j
                move.w  $56(a0),d0
                add.w   $5A(a5),d0
                andi.w  #$1FE,d0
                bset    #4,$E(a0)
                cmpi.w  #$100,d0
                bmi.s   Boss_JetsripperUpdateEndSpriteSetVerticalFlip
                bclr    #4,$E(a0)
Boss_JetsripperUpdateEndSpriteSetVerticalFlip:          ; CODE XREF: Boss_JetsripperUpdateEndSprite+16   j  ; was: loc_35EFA
                bset    #3,$E(a0)
                cmpi.w  #$180,d0
                bpl.s   Boss_JetsripperUpdateEndSpriteSelectFrame
                cmpi.w  #$80,d0
                bmi.s   Boss_JetsripperUpdateEndSpriteSelectFrame
                bclr    #3,$E(a0)
Boss_JetsripperUpdateEndSpriteSelectFrame:              ; CODE XREF: Boss_JetsripperUpdateEndSprite+28   j  ; was: loc_35F12
                                        ; Boss_JetsripperUpdateEndSprite+2E   j
                addi.w  #$20,d0                         ; ' '
                andi.w  #$C0,d0
                asr.w   #4,d0
                move.l  (a1,d0.w),8(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperUpdateEndSprite
                rts
; End of function Boss_JetsripperUpdateEndSprite
; Updates body segment sprites with 16-direction facing
Boss_JetsripperUpdateBodySprite:                        ; CODE XREF: Boss_JetsripperUpdateAllSprites+14   p  ; was: sub_35F2C
                                        ; Boss_JetsripperUpdateBodySprite+38   j
                move.w  $56(a0),d0
                add.w   $5A(a5),d0
                andi.w  #$1FE,d0
                bset    #3,$E(a0)
                cmpi.w  #$180,d0
                bpl.s   Boss_JetsripperUpdateBodyFrame
                cmpi.w  #$80,d0
                bmi.s   Boss_JetsripperUpdateBodyFrame
                bclr    #3,$E(a0)
; Updates body sprite frame based on calculated angle
Boss_JetsripperUpdateBodyFrame:                         ; CODE XREF: Boss_JetsripperUpdateBodySprite+16   j  ; was: loc_35F50
                                        ; Boss_JetsripperUpdateBodySprite+1C   j
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                asr.w   #3,d0
                move.l  (a1,d0.w),8(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperUpdateBodySprite
                rts
; End of function Boss_JetsripperUpdateBodySprite
; ---------------------------------------------------------------------------
Boss_JetsripperHeadFrames:  dc.l    Boss_JetsripperSpriteMapping00  ; DATA XREF: Boss_JetsripperDeathInit+3E   o  ; was: off_35F6A
                                        ; Boss_JetsripperUpdateAllSprites+2   o
                dc.l    Boss_JetsripperSpriteMapping01
                dc.l    Boss_JetsripperSpriteMapping02
                dc.l    Boss_JetsripperSpriteMapping01
Boss_JetsripperBodyDirectionFrames: dc.l    Boss_JetsripperSpriteMapping03  ; DATA XREF: Boss_JetsripperDeathInit+66   o  ; was: off_35F7A
                                        ; Boss_JetsripperUpdateAllSprites+C   o
                dc.l    Boss_JetsripperSpriteMapping12
                dc.l    Boss_JetsripperSpriteMapping13
                dc.l    Boss_JetsripperSpriteMapping14
                dc.l    Boss_JetsripperSpriteMapping15
                dc.l    Boss_JetsripperSpriteMapping14
                dc.l    Boss_JetsripperSpriteMapping13
                dc.l    Boss_JetsripperSpriteMapping12
                dc.l    Boss_JetsripperSpriteMapping03
                dc.l    Boss_JetsripperSpriteMapping10
                dc.l    Boss_JetsripperSpriteMapping04
                dc.l    Boss_JetsripperSpriteMapping11
                dc.l    Boss_JetsripperSpriteMapping05
                dc.l    Boss_JetsripperSpriteMapping11
                dc.l    Boss_JetsripperSpriteMapping04
                dc.l    Boss_JetsripperSpriteMapping10
Boss_JetsripperTailFrames:  dc.l    Boss_JetsripperSpriteMapping07  ; DATA XREF: Boss_JetsripperDeathInit+7E   o  ; was: off_35FBA
                                        ; Boss_JetsripperUpdateAllSprites+16   o
                dc.l    Boss_JetsripperSpriteMapping08
                dc.l    Boss_JetsripperSpriteMapping09
                dc.l    Boss_JetsripperSpriteMapping08

; Fills angle buffer with constant value for segments
Boss_JetsripperFillAngleBuffer:                         ; CODE XREF: Boss_JetsripperInitBody+B6   j  ; was: sub_35FCA
                                        ; Boss_JetsripperDiveExecute+76   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$47,d7                         ; 'G'
Boss_JetsripperFillAngleBufferNextWord:                 ; CODE XREF: Boss_JetsripperFillAngleBuffer+A   j  ; was: loc_35FD2
                move.w  d0,(a0)+
                dbf     d7,Boss_JetsripperFillAngleBufferNextWord
                rts
; End of function Boss_JetsripperFillAngleBuffer
; Fills angle buffer with gradient values for wave motion
Boss_JetsripperFillAngleGradient:                       ; CODE XREF: Boss_JetsripperSwingAttack+B2   p  ; was: sub_35FDA
                                        ; Boss_JetsripperSwingAttack+C6   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  $56(a5),d0
                move.w  #$1FE,d2
                move.w  #$47,d7                         ; 'G'
Boss_JetsripperFillAngleGradientNextWord:               ; CODE XREF: Boss_JetsripperFillAngleGradient+16   j  ; was: loc_35FEA
                move.w  d0,(a0)+
                add.w   d1,d0
                and.w   d2,d0
                dbf     d7,Boss_JetsripperFillAngleGradientNextWord
                rts
; End of function Boss_JetsripperFillAngleGradient
; Converts the current chain radius into per-segment radial distances
Boss_JetsripperAssignSegmentRadii:                      ; CODE XREF: Boss_JetsripperRotateState:Boss_JetsripperUpdateSegmentDisplay   p  ; was: sub_35FF6
                                        ; Boss_JetsripperMovementUpdateSegmentDisplay   p
                moveq   #$19,d1
                move.w  $54(a5),d0
                bpl.s   Boss_JetsripperAssignSegmentRadiiDeriveCount
                moveq   #0,d0
                move.w  d0,$54(a5)
Boss_JetsripperAssignSegmentRadiiDeriveCount:           ; CODE XREF: Boss_JetsripperAssignSegmentRadii+6   j  ; was: loc_36004
                                        ; Boss_JetsripperAssignSegmentRadii+14   j
                subq.w  #1,d1
                subi.w  #$11,d0
                bpl.s   Boss_JetsripperAssignSegmentRadiiDeriveCount
                addi.w  #$11,d0
                movea.w #(SecondaryEntityType-M68K_RAM),a0
                moveq   #$10,d7
Boss_JetsripperAssignSegmentRadiiNextSegment:           ; CODE XREF: Boss_JetsripperAssignSegmentRadii+28   j  ; was: loc_36016
                move.w  d1,$54(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_JetsripperAssignSegmentRadiiNextSegment
                movea.w #(SecondaryEntityType-M68K_RAM),a0
Boss_JetsripperAssignSegmentRadiiReduceLeadingSegment:  ; CODE XREF: Boss_JetsripperAssignSegmentRadii+38   j  ; was: loc_36026
                subq.w  #1,$54(a0)
                lea     $60(a0),a0
                dbf     d0,Boss_JetsripperAssignSegmentRadiiReduceLeadingSegment
                rts
; End of function Boss_JetsripperAssignSegmentRadii
; Sets the current object's horizontal velocity from its angle
Boss_SetHorizontalVelocityFromAngle:
                move.w  #3,d3                           ; was: sub_36034
                movea.l #Math_SineTable,a0
                move.w  $56(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d2
                muls.w  d3,d2
                asl.l   #2,d2
                move.l  d2,$18(a5)
                rts
; End of function Boss_SetHorizontalVelocityFromAngle
; Returns Jetsripper's scaled sine velocity in d2
Boss_JetsripperCalculateAngleVelocity:                  ; CODE XREF: Boss_JetsripperOscillate+3C   p  ; was: sub_36058
                                        ; Boss_JetsripperDivePrep+C   p
                moveq   #$C,d3
                movea.l #Math_SineTable,a0
                move.w  $176(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  (a0,d0.w),d2
                muls.w  d3,d2
                rts
; End of function Boss_JetsripperCalculateAngleVelocity
; Updates positions of sprite segment chain based on velocity deltas
Boss_UpdateSegmentChainPositions:
                movea.w #(word_FFC980-M68K_RAM),a0      ; was: sub_36074
                movea.w a0,a1
                lea     -$60(a0),a0
                moveq   #0,d0
                moveq   #0,d1
                move.w  $4C(a5),d0
                move.w  $4E(a5),d1
                swap    d0
                swap    d1
                asr.l   #8,d0
                asr.l   #8,d1
                moveq   #0,d2
                moveq   #0,d3
                moveq   #8,d7
Boss_UpdateSegmentChainPositionsNextAnglePair:          ; CODE XREF: Boss_UpdateSegmentChainPositions+38   j  ; was: loc_36098
                add.l   d0,d2
                add.l   d1,d3
                add.l   d2,$56(a0)
                add.l   d3,$56(a1)
                lea     -$60(a0),a0
                lea     $60(a1),a1
                dbf     d7,Boss_UpdateSegmentChainPositionsNextAnglePair
                movea.w a5,a0
                bclr    #0,2(a5)
                movea.w #(SecondaryEntityType-M68K_RAM),a1
                movea.l #Math_SineTable,a2
                move.w  $5A(a5),d1
                move.w  #$1FE,d2
                moveq   #$10,d7
Boss_UpdateSegmentChainPositionsNextSegment:            ; CODE XREF: Boss_UpdateSegmentChainPositions+94   j  ; was: loc_360CC
                move.w  $56(a1),d3
                and.w   d2,d3
                move.w  -$80(a2,d3.w),d4
                add.w   d1,d3
                and.w   d2,d3
                move.w  (a2,d3.w),d5
                move.w  $54(a1),d3
                muls.w  d3,d4
                muls.w  d3,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $44(a0),d4
                move.l  d4,$44(a1)
                add.l   $40(a0),d5
                move.l  d5,$40(a1)
                bclr    #0,2(a1)
                lea     $60(a0),a0
                lea     $60(a1),a1
                dbf     d7,Boss_UpdateSegmentChainPositionsNextSegment
                rts
; End of function Boss_UpdateSegmentChainPositions
; Updates all segment positions with wave motion
Boss_JetsripperUpdateSegments:                          ; CODE XREF: Boss_JetsripperRotateState+30   p  ; was: sub_3610E
                                        ; Boss_JetsripperUpdateMovement+8E   p
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  $56(a5),d0
                move.w  #$47,d7                         ; 'G'
Boss_JetsripperShiftAngleBufferNextWord:                ; CODE XREF: Boss_JetsripperUpdateSegments+12   j  ; was: loc_3611A
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,Boss_JetsripperShiftAngleBufferNextWord
                movea.w a5,a0
                bclr    #0,2(a0)
                clr.w   $58(a0)
                movea.w #(SecondaryEntityType-M68K_RAM),a1
                movea.w #(byte_FF9808-M68K_RAM),a2
                movea.l #Math_SineTable,a3
                move.w  $5A(a5),d1
                move.w  #$1FE,d2
                moveq   #0,d6
                moveq   #$10,d7
Boss_JetsripperUpdateSegmentsNextSegment:               ; CODE XREF: Boss_JetsripperUpdateSegments+88   j  ; was: loc_3614A
                move.w  (a2),d3
                add.w   d6,d3
                and.w   d2,d3
                move.w  d3,$56(a1)
                move.w  -$80(a3,d3.w),d4
                add.w   d1,d3
                and.w   d2,d3
                move.w  (a3,d3.w),d5
                move.w  $54(a1),d3
                muls.w  d3,d4
                muls.w  d3,d5
                asl.l   #2,d4
                asl.l   #2,d5
                add.l   $44(a0),d4
                move.l  d4,$44(a1)
                add.l   $40(a0),d5
                move.l  d5,$40(a1)
                bclr    #0,2(a1)
                clr.w   $58(a1)
                lea     $60(a0),a0
                lea     $60(a1),a1
                lea     8(a2),a2
                add.w   $BE(a5),d6
                dbf     d7,Boss_JetsripperUpdateSegmentsNextSegment
                rts
; End of function Boss_JetsripperUpdateSegments
; Updates palette colors for glow effect
Boss_JetsripperUpdatePalette:                           ; CODE XREF: Boss_JetsripperUpdateState:Boss_JetsripperUpdateActiveState   p  ; was: sub_3619C
                movea.w #(word_FFE37A-M68K_RAM),a0
                moveq   #0,d0
                btst    #1,(FrameCounter+1).w
                bne.s   Boss_JetsripperUpdatePaletteSelectFlash
                moveq   #8,d0
Boss_JetsripperUpdatePaletteSelectFlash:                ; CODE XREF: Boss_JetsripperUpdatePalette+C   j  ; was: loc_361AC
                move.w  (RandomNumberState).w,d1
                andi.w  #$F0,d1
                bne.s   Boss_JetsripperWritePalette
                moveq   #$10,d0
; Writes palette colors from lookup table for damage flash
Boss_JetsripperWritePalette:                            ; CODE XREF: Boss_JetsripperUpdatePalette+18   j  ; was: loc_361B8
                move.w  Boss_JetsripperPaletteFrames(pc,d0.w),(a0)+
                move.w  Boss_JetsripperPaletteFrames+2(pc,d0.w),(a0)+
                move.w  Boss_JetsripperPaletteFrames+4(pc,d0.w),(a0)+
                rts
; End of function Boss_JetsripperUpdatePalette
; ---------------------------------------------------------------------------
Boss_JetsripperPaletteFrames:   dc.w    $46, $28A, $4CE, 0, 2, 6, $2A, 0, $AAA, $CCC, $EEE, 0  ; was: word_361C6
                                        ; DATA XREF: Boss_JetsripperWritePalette   r
                                        ; Boss_JetsripperUpdatePalette+20   r

; Clamps segment Y position to maximum 0x144
Boss_JetsripperClampY:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_361DE
                cmpi.w  #$144,$14(a5)
                bmi.s   Boss_JetsripperClampYReturn
                move.w  #$144,$14(a5)
Boss_JetsripperClampYReturn:                            ; CODE XREF: Boss_JetsripperClampY+6   j  ; was: locret_361EC
                rts
; End of function Boss_JetsripperClampY
; Updates body segment with gravity physics
Boss_JetsripperSegmentPhysics:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_361EE
                tst.w   4(a5)
                beq.w   Boss_JetsripperSegmentPhysicsBeginFall
                addi.l  #$4000,$1C(a5)
                movea.l $4C(a5),a1
                move.w  $56(a5),d0
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1E0,d0
                move.w  d0,$56(a5)
                cmpi.l  #Boss_JetsripperBodyDirectionFrames,$4C(a5)
                beq.s   Boss_JetsripperSegmentPhysicsOrientBodyFrame
                bset    #3,$E(a5)
                cmpi.w  #$180,d0
                bpl.s   Boss_JetsripperSegmentPhysicsOrientEndFrame
                cmpi.w  #$80,d0
                bmi.s   Boss_JetsripperSegmentPhysicsOrientEndFrame
                bclr    #3,$E(a5)
Boss_JetsripperSegmentPhysicsOrientEndFrame:            ; CODE XREF: Boss_JetsripperSegmentPhysics+38   j  ; was: loc_36234
                                        ; Boss_JetsripperSegmentPhysics+3E   j
                bset    #4,$E(a5)
                cmpi.w  #$100,d0
                bmi.s   Boss_JetsripperSegmentPhysicsSelectEndFrame
                bclr    #4,$E(a5)
Boss_JetsripperSegmentPhysicsSelectEndFrame:            ; CODE XREF: Boss_JetsripperSegmentPhysics+50   j  ; was: loc_36246
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  (a1,d0.w),8(a5)
                rts
; ---------------------------------------------------------------------------
Boss_JetsripperSegmentPhysicsOrientBodyFrame:           ; CODE XREF: Boss_JetsripperSegmentPhysics+2C   j  ; was: loc_36254
                bset    #3,$E(a5)
                cmpi.w  #$180,d0
                bpl.s   Boss_JetsripperSegmentPhysicsSelectBodyFrame
                cmpi.w  #$80,d0
                bmi.s   Boss_JetsripperSegmentPhysicsSelectBodyFrame
                bclr    #3,$E(a5)
Boss_JetsripperSegmentPhysicsSelectBodyFrame:           ; CODE XREF: Boss_JetsripperSegmentPhysics+70   j  ; was: loc_3626C
                                        ; Boss_JetsripperSegmentPhysics+76   j
                asr.w   #3,d0
                move.l  (a1,d0.w),8(a5)
                rts
; ---------------------------------------------------------------------------
Boss_JetsripperSegmentPhysicsBeginFall:                 ; CODE XREF: Boss_JetsripperSegmentPhysics+4   j  ; was: loc_36276
                subq.w  #1,$48(a5)
                bpl.s   Boss_JetsripperSegmentPhysicsReturn
                addq.w  #1,4(a5)
                move.w  #$CF00,2(a5)
                move.w  #4,(PlaneAShakeLevel).w
                move.l  #$FFFC0000,$1C(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_JetsripperSegmentPhysicsReturn
                move.l  #SharedCombatSpriteAnimation01,8(a0)
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFE0000,$1C(a0)
                move.b  #$C1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
Boss_JetsripperSegmentPhysicsReturn:                    ; CODE XREF: Boss_JetsripperSegmentPhysics+8C   j  ; was: locret_362CC
                                        ; Boss_JetsripperSegmentPhysics+AC   j
                rts
; End of function Boss_JetsripperSegmentPhysics
