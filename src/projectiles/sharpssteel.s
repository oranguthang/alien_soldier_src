; Sharpssteel falling shots, defeat fragments, and blade shots
; Emits two groups totalling ten type-$364 falling shots
Boss_SharpssteelSpawnTenFallingShots:                   ; CODE XREF: Boss_SharpssteelPostDiveDelayState+76   p  ; was: sub_48DA0
                lea     (Math_SineTable).l,a4
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$12,d4
                moveq   #5,d7
                bsr.s   Projectile_SharpssteelEmitFallingShotLoop
                moveq   #$10,d4
                moveq   #3,d7
; End of function Boss_SharpssteelSpawnTenFallingShots
; Emits one configured group using sine-derived velocities and fixed spawn offsets
Projectile_SharpssteelEmitFallingShotLoop:              ; CODE XREF: Boss_SharpssteelSpawnTenFallingShots+E   p  ; was: sub_48DB4
                                        ; Projectile_SharpssteelEmitFallingShotLoop+70   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Projectile_SharpssteelEmitFallingShotReturn
                move.w  #$364,(a0)
                move.w  #$EC00,2(a0)
                move.w  #0,$E(a0)
                move.l  #SharedFloaterDebrisProjectileAlternating5And4Animation,8(a0)
                move.b  #$20,$20(a0)                    ; ' '
                moveq   #0,d0
                move.b  Projectile_SharpssteelFallingShotAngleIndices(pc,d5.w),d0
                asl.w   #1,d0
                move.w  -$80(a4,d0.w),d1
                move.w  (a4,d0.w),d2
                ext.l   d1
                ext.l   d2
                muls.w  d4,d1
                muls.w  d4,d2
                move.l  d1,$1C(a0)
                asr.l   #1,d2
                move.l  d2,$18(a0)
                move.b  Projectile_SharpssteelFallingShotSpawnOffsets(pc,d6.w),d0
                ext.w   d0
                bpl.s   Projectile_SharpssteelSetFallingShotSpawnPosition
                ori.w   #$800,$E(a0)
Projectile_SharpssteelSetFallingShotSpawnPosition:      ; CODE XREF: Projectile_SharpssteelEmitFallingShotLoop+4E   j
                addi.w  #$120,d0
                move.w  d0,$10(a0)
                move.b  Projectile_SharpssteelFallingShotSpawnOffsets+1(pc,d6.w),d0
                ext.w   d0
                addi.w  #$160,d0
                move.w  d0,$14(a0)
                addq.w  #1,d5
                addq.w  #2,d6
                dbf     d7,Projectile_SharpssteelEmitFallingShotLoop
Projectile_SharpssteelEmitFallingShotReturn:            ; CODE XREF: Projectile_SharpssteelEmitFallingShotLoop+6   j
                rts
; End of function Projectile_SharpssteelEmitFallingShotLoop
; ---------------------------------------------------------------------------
Projectile_SharpssteelFallingShotAngleIndices:  dc.b    $B4, $B8, $BC, $C4, $C8, $CC, $B6, $BA, $C6, $CA
                                        ; DATA XREF: Projectile_SharpssteelEmitFallingShotLoop+28   r
Projectile_SharpssteelFallingShotSpawnOffsets:  dc.b    $D0, 0, $E0, $F8, $F0, $F0, $10, $F0, $20, $F8
                                        ; DATA XREF: Projectile_SharpssteelEmitFallingShotLoop+48   r
                                        ; Projectile_SharpssteelEmitFallingShotLoop+5E   r
                dc.b    $30, 0, $C0, $24, $D0, $20, $30, $20, $40, $24

; Type-$364 Sharpssteel shot: rises, arms while falling, and handles hits or bounds
Projectile_SharpssteelFallingShotMain:                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_48E48
                tst.w   (word_FF808C).w
                bpl.w   Projectile_SharpssteelConvertFallingShotToDebris
                addi.l  #$B00,$1C(a5)
                tst.w   4(a5)
                bne.s   Projectile_SharpssteelHandleFallingShotCollision
                tst.w   $1C(a5)
                bmi.s   Projectile_SharpssteelFallingShotReturn
                addq.w  #2,4(a5)
                bset    #4,$E(a5)
                bset    #7,$E(a5)
                move.b  #$C0,$21(a5)
                move.w  #1,$24(a5)
                move.w  #$64,$26(a5)                    ; 'd'
                move.l  #$F60AF60A,$28(a5)
                move.l  #$FC04FC04,$2C(a5)
Projectile_SharpssteelFallingShotReturn:                ; CODE XREF: Projectile_SharpssteelFallingShotMain+1A   j
                                        ; Projectile_SharpssteelFallingShotMain+D4   j
                rts
; ---------------------------------------------------------------------------
Projectile_SharpssteelHandleFallingShotCollision:       ; CODE XREF: Projectile_SharpssteelFallingShotMain+14   j
                bclr    #7,$22(a5)
                beq.s   Projectile_SharpssteelCheckFallingShotDurability
                bclr    #4,$22(a5)
                beq.s   Projectile_SharpssteelConvertFallingShotToDebris
                bra.s   Projectile_SharpssteelSpawnPickupFromFallingShot
; ---------------------------------------------------------------------------
Projectile_SharpssteelCheckFallingShotDurability:       ; CODE XREF: Projectile_SharpssteelFallingShotMain+56   j
                tst.w   $24(a5)
                bpl.s   Projectile_SharpssteelHandleFallingShotLowerBoundary
Projectile_SharpssteelSpawnPickupFromFallingShot:       ; CODE XREF: Projectile_SharpssteelFallingShotMain+60   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_SharpssteelConvertFallingShotToDebris
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                moveq   #$15,d0
                jsr     (Pickup_SelectRandomSize).l
                move.w  #$E440,2(a0)
                move.l  #$2000,$1C(a0)
Projectile_SharpssteelConvertFallingShotToDebris:       ; CODE XREF: Projectile_SharpssteelFallingShotMain+4   j
                                        ; Projectile_SharpssteelFallingShotMain+5E   j
                clr.l   $1C(a5)
                move.l  #SharedCombatSpriteAnimation03,8(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
Projectile_SharpssteelHandleFallingShotLowerBoundary:   ; CODE XREF: Projectile_SharpssteelFallingShotMain+66   j
                cmpi.w  #$150,$14(a5)
                bmi.s   Projectile_SharpssteelCheckFallingShotDeflectionRegion
                move.w  $E(a5),d0
                andi.w  #$8000,d0
                movem.l d0,-(sp)
                move.l  #$FFFC8000,$1C(a5)
                jsr     (Projectile_ConvertCurrentToSharedEffect).l
                movem.l (sp)+,d0
                or.w    d0,$E(a5)
                rts
; ---------------------------------------------------------------------------
Projectile_SharpssteelCheckFallingShotDeflectionRegion:  ; CODE XREF: Projectile_SharpssteelFallingShotMain+AA   j
                tst.w   $48(a5)
                bne.w   Projectile_SharpssteelFallingShotReturn
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  $10(a0),d0
                cmp.w   $10(a5),d0
                bpl.s   Projectile_SharpssteelCheckFallingShotDeflectionReturn
                addi.w  #$F0,d0
                cmp.w   $10(a5),d0
                bmi.s   Projectile_SharpssteelCheckFallingShotDeflectionReturn
                move.w  $14(a0),d0
                subi.w  #$A,d0
                cmp.w   $14(a5),d0
                bpl.s   Projectile_SharpssteelCheckFallingShotDeflectionReturn
                addi.w  #$10,d0
                cmp.w   $14(a5),d0
                bmi.s   Projectile_SharpssteelCheckFallingShotDeflectionReturn
                addq.w  #1,$48(a5)
                bclr    #4,$E(a5)
                move.w  #$FFFE,$1C(a5)
Projectile_SharpssteelCheckFallingShotDeflectionReturn:  ; CODE XREF: Projectile_SharpssteelFallingShotMain+E4   j
                                        ; Projectile_SharpssteelFallingShotMain+EE   j
                rts
; End of function Projectile_SharpssteelFallingShotMain
; Starts defeat presentation and initializes fourteen embedded type-$3BC fragments
Boss_SharpssteelBeginDefeatFragmentBurst:               ; CODE XREF: Boss_SharpssteelMain+22   j  ; was: sub_48F62
                move.b  #1,(byte_FF830E).w
                clr.w   8(a5)
                bset    #0,(byte_FFA272).w
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                clr.w   2(a5)
                move.w  #$80,$48(a5)
                movea.w a5,a0
                moveq   #0,d5
                moveq   #0,d6
                moveq   #$D,d7
Boss_SharpssteelInitializeDefeatFragmentLoop:           ; CODE XREF: Boss_SharpssteelBeginDefeatFragmentBurst+98   j
                movem.l d6-d7/a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,d6-d7/a0
                lea     $60(a0),a0
                move.w  #$3BC,(a0)
                bset    #1,2(a0)
                bset    #3,2(a0)
                bset    #2,2(a0)
                move.w  d5,$48(a0)
                move.b  (RandomNumberState).w,d0
                andi.w  #3,d0
                swap    d0
                asr.l   #1,d0
                addi.l  #$12000,d0
                move.l  d0,$18(a0)
                move.b  (RandomNumberState).w,d0
                andi.w  #$F,d0
                addq.w  #1,d6
                btst    #0,d6
                bne.s   Boss_SharpssteelApplyDefeatFragmentVerticalVelocity
                neg.w   d0
Boss_SharpssteelApplyDefeatFragmentVerticalVelocity:    ; CODE XREF: Boss_SharpssteelBeginDefeatFragmentBurst+8A   j
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                addq.w  #1,d5
                dbf     d7,Boss_SharpssteelInitializeDefeatFragmentLoop
                rts
; End of function Boss_SharpssteelBeginDefeatFragmentBurst
; Type-$3BC defeat fragment: flashes, emits debris, and curves as X velocity changes
Effect_SharpssteelDefeatFragmentMain:                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_49000
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                addq.w  #1,$48(a5)
                move.w  $48(a5),d0
                bset    #7,2(a5)
                btst    #0,d0
                beq.s   Effect_SharpssteelApplyDefeatFragmentFlashPhase
                bclr    #7,2(a5)
Effect_SharpssteelApplyDefeatFragmentFlashPhase:        ; CODE XREF: Effect_SharpssteelDefeatFragmentMain+1E   j
                andi.w  #7,d0
                bne.s   Effect_SharpssteelUpdateDefeatFragmentVelocity
                move.w  (FrameCounter).w,d0
                andi.w  #$F,d0
                bne.s   Effect_SharpssteelTryEmitDefeatFragmentDebris
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
Effect_SharpssteelTryEmitDefeatFragmentDebris:          ; CODE XREF: Effect_SharpssteelDefeatFragmentMain+34   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Effect_SharpssteelUpdateDefeatFragmentVelocity
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                neg.l   d0
                asr.l   #3,d0
                move.l  d0,$18(a0)
                move.l  #SharedCombatSpriteAnimation05,8(a0)
                jsr     (Projectile_InitType88).l
Effect_SharpssteelUpdateDefeatFragmentVelocity:         ; CODE XREF: Effect_SharpssteelDefeatFragmentMain+2A   j
                                        ; Effect_SharpssteelDefeatFragmentMain+46   j
                subi.l  #$4000,$18(a5)
                tst.w   $18(a5)
                bpl.s   Effect_SharpssteelAccelerateDefeatFragmentUpward
                addi.l  #$1000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
Effect_SharpssteelAccelerateDefeatFragmentUpward:       ; CODE XREF: Effect_SharpssteelDefeatFragmentMain+7A   j
                subi.l  #$1000,$1C(a5)
                rts
; End of function Effect_SharpssteelDefeatFragmentMain
; Emits six type-$414 shots from Sharpssteel's final blade part
Boss_SharpssteelSpawnSixBladeShots:                     ; CODE XREF: Boss_SharpssteelWaitForComplexAlignmentState+D2   p  ; was: sub_49090
                move.l  #$FFFA0000,d6
                moveq   #5,d7
Boss_SharpssteelSpawnSixBladeShotsLoop:                 ; CODE XREF: Boss_SharpssteelSpawnSixBladeShots+10   j
                bsr.s   Projectile_SharpssteelInitializeBladeShot
                addi.l  #$8000,d6
                dbf     d7,Boss_SharpssteelSpawnSixBladeShotsLoop
                rts
; End of function Boss_SharpssteelSpawnSixBladeShots
; Initializes one blade shot with the caller-provided vertical velocity
Projectile_SharpssteelInitializeBladeShot:              ; CODE XREF: Boss_SharpssteelSpawnSixBladeShots:Boss_SharpssteelSpawnSixBladeShotsLoop   p  ; was: sub_490A6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_SharpssteelInitializeBladeShotReturn
                move.w  #$414,(a0)
                move.w  #$C480,2(a0)
                move.b  #0,$20(a0)
                move.w  $4F0(a5),$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  $4E8(a5),8(a0)
                move.w  $4EE(a5),$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F010FA06,$2C(a0)
                move.w  #$56,$26(a0)                    ; 'V'
                move.l  d6,$1C(a0)
                move.w  d7,$48(a0)
                andi.w  #1,$48(a0)
                move.w  #$F,$4A(a0)
Projectile_SharpssteelInitializeBladeShotReturn:        ; CODE XREF: Projectile_SharpssteelInitializeBladeShot+6   j
                rts
; End of function Projectile_SharpssteelInitializeBladeShot
; Type-$414 blade shot: flashes for its configured lifetime, then removes itself
Projectile_SharpssteelBladeShotMain:                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_49100
                tst.w   (word_FF808C).w
                bpl.s   Projectile_SharpssteelMarkBladeShotForRemoval
                bset    #7,2(a5)
                move.w  $4A(a5),d0
                andi.w  #1,d0
                cmp.w   $48(a5),d0
                beq.s   Projectile_SharpssteelTickBladeShotLifetime
                bclr    #7,2(a5)
Projectile_SharpssteelTickBladeShotLifetime:            ; CODE XREF: Projectile_SharpssteelBladeShotMain+18   j
                subq.w  #1,$4A(a5)
                bpl.s   Projectile_SharpssteelBladeShotReturn
Projectile_SharpssteelMarkBladeShotForRemoval:          ; CODE XREF: Projectile_SharpssteelBladeShotMain+4   j
                bset    #4,2(a5)
Projectile_SharpssteelBladeShotReturn:                  ; CODE XREF: Projectile_SharpssteelBladeShotMain+24   j
                rts
; End of function Projectile_SharpssteelBladeShotMain
