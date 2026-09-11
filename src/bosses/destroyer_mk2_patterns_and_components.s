; Projectile-pattern substates selected by the main controller's state $24
Boss_DestroyerMK2LinkedActivationPatternDispatch:       ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState:Boss_DestroyerMK2PositiveTimerPatternHandlers   o  ; was: sub_4B04C
                                        ; Boss_DestroyerMK2DispatchProjectilePatternState+24   o
                move.w  (dword_FF941C).w,d0
                lea     Boss_DestroyerMK2LinkedActivationPatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2LinkedActivationPatternDispatch
; ---------------------------------------------------------------------------
Boss_DestroyerMK2LinkedActivationPatternHandlers:   dc.w    Boss_DestroyerMK2ActivateNearLinkedPart-*  ; DATA XREF: Boss_DestroyerMK2LinkedActivationPatternDispatch+4   o  ; was: off_4B058
                dc.w    Boss_DestroyerMK2WaitThenActivateFarLinkedPart-*
                dc.w    Boss_DestroyerMK2WaitThenActivateLinkedPair-*
                dc.w    Boss_DestroyerMK2AdvanceMainState-*

; Activate the nearer linked part on the player's side
Boss_DestroyerMK2ActivateNearLinkedPart:                ; DATA XREF: ROM:Boss_DestroyerMK2LinkedActivationPatternHandlers   o  ; was: sub_4B060
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   Boss_DestroyerMK2SelectRightNearLinkedPart
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bra.s   Boss_DestroyerMK2ActivateSelectedNearLinkedPart
; ---------------------------------------------------------------------------
Boss_DestroyerMK2SelectRightNearLinkedPart:             ; CODE XREF: Boss_DestroyerMK2ActivateNearLinkedPart+C   j  ; was: loc_4B074
                movea.w #(word_FFC800-M68K_RAM),a0
Boss_DestroyerMK2ActivateSelectedNearLinkedPart:        ; CODE XREF: Boss_DestroyerMK2ActivateNearLinkedPart+12   j  ; was: loc_4B078
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
                move.w  #$20,$48(a5)                    ; ' '
                rts
; End of function Boss_DestroyerMK2ActivateNearLinkedPart
; After a delay, activate the farther linked part on the player's side
Boss_DestroyerMK2WaitThenActivateFarLinkedPart:         ; DATA XREF: ROM:0004B05A   o  ; was: sub_4B084
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2FarLinkedActivationReturn
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   Boss_DestroyerMK2SelectRightFarLinkedPart
                movea.w #(word_FFC860-M68K_RAM),a0
                bra.s   Boss_DestroyerMK2ActivateSelectedFarLinkedPart
; ---------------------------------------------------------------------------
Boss_DestroyerMK2SelectRightFarLinkedPart:              ; CODE XREF: Boss_DestroyerMK2WaitThenActivateFarLinkedPart+12   j  ; was: loc_4B09E
                movea.w #(word_FFC8C0-M68K_RAM),a0
Boss_DestroyerMK2ActivateSelectedFarLinkedPart:         ; CODE XREF: Boss_DestroyerMK2WaitThenActivateFarLinkedPart+18   j  ; was: loc_4B0A2
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
                move.w  #$40,$48(a5)                    ; '@'
Boss_DestroyerMK2FarLinkedActivationReturn:             ; CODE XREF: Boss_DestroyerMK2WaitThenActivateFarLinkedPart+4   j  ; was: locret_4B0AC
                rts
; End of function Boss_DestroyerMK2WaitThenActivateFarLinkedPart
; After a delay, activate the two linked parts on the player's side
Boss_DestroyerMK2WaitThenActivateLinkedPair:            ; DATA XREF: ROM:0004B05C   o  ; was: sub_4B0AE
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2LinkedPairActivationReturn
                addq.w  #2,(dword_FF941C).w
                move.w  (word_FF8248).w,d0
                cmp.w   $10(a5),d0
                bgt.s   Boss_DestroyerMK2SelectRightLinkedPair
                movea.w #(word_FFC7A0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
                movea.w #(word_FFC860-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
                rts
; ---------------------------------------------------------------------------
Boss_DestroyerMK2SelectRightLinkedPair:                 ; CODE XREF: Boss_DestroyerMK2WaitThenActivateLinkedPair+12   j  ; was: loc_4B0D4
                movea.w #(word_FFC800-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
                movea.w #(word_FFC8C0-M68K_RAM),a0
                bsr.w   Boss_DestroyerMK2ActivateLinkedPartIfIdle
Boss_DestroyerMK2LinkedPairActivationReturn:            ; CODE XREF: Boss_DestroyerMK2WaitThenActivateLinkedPair+4   j  ; was: locret_4B0E4
                rts
; End of function Boss_DestroyerMK2WaitThenActivateLinkedPair
; Short pattern which activates the central linked part, then exits
Boss_DestroyerMK2SingleLinkedActivationDispatch:        ; DATA XREF: ROM:0004B02A   o  ; was: sub_4B0E6
                                        ; ROM:0004B032   o
                move.w  (dword_FF941C).w,d0
                lea     Boss_DestroyerMK2SingleLinkedActivationHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2SingleLinkedActivationDispatch
; ---------------------------------------------------------------------------
Boss_DestroyerMK2SingleLinkedActivationHandlers:    dc.w    Boss_DestroyerMK2ActivateCentralLinkedPart-*  ; DATA XREF: Boss_DestroyerMK2SingleLinkedActivationDispatch+4   o  ; was: off_4B0F2
                dc.w    Boss_DestroyerMK2AdvancePatternPhase-*
                dc.w    Boss_DestroyerMK2AdvanceMainState-*

; Activate the central linked part and advance the nested pattern phase
Boss_DestroyerMK2ActivateCentralLinkedPart:             ; DATA XREF: ROM:Boss_DestroyerMK2SingleLinkedActivationHandlers   o  ; was: sub_4B0F8
                bsr.w   Boss_DestroyerMK2SelectCentralLinkedPart
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2ActivateCentralLinkedPart
; Advance the nested projectile-pattern phase
Boss_DestroyerMK2AdvancePatternPhase:                   ; DATA XREF: ROM:0004B0F4   o  ; was: sub_4B102
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2AdvancePatternPhase
; Two-state projected-effect sweep selected by the projectile-pattern table
Boss_DestroyerMK2ProjectedSweepPatternDispatch:         ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState+1C   o  ; was: sub_4B108
                                        ; Boss_DestroyerMK2DispatchProjectilePatternState+1E   o
                move.w  (dword_FF941C).w,d0
                lea     Boss_DestroyerMK2ProjectedSweepPatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ProjectedSweepPatternDispatch
; ---------------------------------------------------------------------------
Boss_DestroyerMK2ProjectedSweepPatternHandlers: dc.w    Boss_DestroyerMK2InitializeProjectedSweep-*  ; DATA XREF: Boss_DestroyerMK2ProjectedSweepPatternDispatch+4   o  ; was: off_4B114
                dc.w    Boss_DestroyerMK2UpdateProjectedSweep-*

; Initialize sweep origin, direction, angle, and four-step counter
Boss_DestroyerMK2InitializeProjectedSweep:              ; DATA XREF: ROM:Boss_DestroyerMK2ProjectedSweepPatternHandlers   o  ; was: sub_4B118
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                bmi.s   Boss_DestroyerMK2InitializeLeftwardProjectedSweep
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1E0,$5A(a5)
                bra.s   Boss_DestroyerMK2FinishProjectedSweepSetup
; ---------------------------------------------------------------------------
Boss_DestroyerMK2InitializeLeftwardProjectedSweep:      ; CODE XREF: Boss_DestroyerMK2InitializeProjectedSweep+8   j  ; was: loc_4B130
                move.w  #$FFD0,$58(a5)
                move.w  #$120,$5A(a5)
Boss_DestroyerMK2FinishProjectedSweepSetup:             ; CODE XREF: Boss_DestroyerMK2InitializeProjectedSweep+16   j  ; was: loc_4B13C
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #5,$5C(a5)
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2InitializeProjectedSweep
; Project one effect per frame, then play its completion sound and exit
Boss_DestroyerMK2UpdateProjectedSweep:                  ; DATA XREF: ROM:0004B116   o  ; was: sub_4B150
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                andi.w  #$1FE,d6
                jsr     (Boss_DestroyerMK2SpawnProjectedShot).l
                btst    #7,$58(a5)
                bmi.s   Boss_DestroyerMK2AdvanceSweepAngleBackward
                addi.w  #$10,$5A(a5)
                bra.s   Boss_DestroyerMK2TickProjectedSweep
; ---------------------------------------------------------------------------
Boss_DestroyerMK2AdvanceSweepAngleBackward:             ; CODE XREF: Boss_DestroyerMK2UpdateProjectedSweep+24   j  ; was: loc_4B17E
                addi.w  #-$10,$5A(a5)
Boss_DestroyerMK2TickProjectedSweep:                    ; CODE XREF: Boss_DestroyerMK2UpdateProjectedSweep+2C   j  ; was: loc_4B184
                subq.w  #1,$5C(a5)
                bne.s   Boss_DestroyerMK2ProjectedSweepReturn
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                bra.w   Boss_DestroyerMK2AdvanceMainState
; ---------------------------------------------------------------------------
Boss_DestroyerMK2ProjectedSweepReturn:                  ; CODE XREF: Boss_DestroyerMK2UpdateProjectedSweep+38   j  ; was: locret_4B198
                rts
; End of function Boss_DestroyerMK2UpdateProjectedSweep
; Three-state pattern which emits three type-$258 projectiles
Boss_DestroyerMK2TripleProjectilePatternDispatch:       ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState+20   o  ; was: sub_4B19A
                                        ; Boss_DestroyerMK2DispatchProjectilePatternState+2C   o
                move.w  (dword_FF941C).w,d0
                lea     Boss_DestroyerMK2TripleProjectilePatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2TripleProjectilePatternDispatch
; ---------------------------------------------------------------------------
Boss_DestroyerMK2TripleProjectilePatternHandlers:   dc.w    Boss_DestroyerMK2InitializeTripleProjectilePattern-*  ; DATA XREF: Boss_DestroyerMK2TripleProjectilePatternDispatch+4   o  ; was: off_4B1A6
                dc.w    Boss_DestroyerMK2SpawnNextTripleProjectile-*
                dc.w    Boss_DestroyerMK2WaitBetweenTripleProjectiles-*

; Initialize the three-projectile repetition counter
Boss_DestroyerMK2InitializeTripleProjectilePattern:     ; DATA XREF: ROM:Boss_DestroyerMK2TripleProjectilePatternHandlers   o  ; was: sub_4B1AC
                move.w  #3,$4A(a5)
                addq.w  #2,(dword_FF941C).w
; Allocate and initialize the next type-$258 projectile
Boss_DestroyerMK2SpawnNextTripleProjectile:             ; DATA XREF: ROM:0004B1A8   o  ; was: loc_4B1B6
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Boss_DestroyerMK2FinishTripleProjectileSpawn
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #2,$46(a0)
                move.w  $4A(a5),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
Boss_DestroyerMK2FinishTripleProjectileSpawn:           ; CODE XREF: Boss_DestroyerMK2InitializeTripleProjectilePattern+10   j  ; was: loc_4B21E
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2InitializeTripleProjectilePattern
; Wait before repeating the three-projectile pattern
Boss_DestroyerMK2WaitBetweenTripleProjectiles:          ; DATA XREF: ROM:0004B1AA   o  ; was: sub_4B22A
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2TripleProjectileDelayReturn
                subq.w  #1,$4A(a5)
                beq.w   Boss_DestroyerMK2AdvanceMainState
                subq.w  #2,(dword_FF941C).w
Boss_DestroyerMK2TripleProjectileDelayReturn:           ; CODE XREF: Boss_DestroyerMK2WaitBetweenTripleProjectiles+4   j  ; was: locret_4B23C
                rts
; End of function Boss_DestroyerMK2WaitBetweenTripleProjectiles
; Two-state ten-projectile spread pattern
Boss_DestroyerMK2ProjectileSpreadPatternDispatch:       ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState+26   o  ; was: sub_4B23E
                                        ; Boss_DestroyerMK2DispatchProjectilePatternState+30   o
                move.w  (dword_FF941C).w,d0
                lea     Boss_DestroyerMK2ProjectileSpreadPatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2ProjectileSpreadPatternDispatch
; ---------------------------------------------------------------------------
Boss_DestroyerMK2ProjectileSpreadPatternHandlers:   dc.w    Boss_DestroyerMK2SpawnTenProjectileSpread-*  ; DATA XREF: Boss_DestroyerMK2ProjectileSpreadPatternDispatch+4   o  ; was: off_4B24A
                dc.w    Boss_DestroyerMK2AdvanceMainState-*

; Allocate ten type-$258 projectiles using the parameter table below
Boss_DestroyerMK2SpawnTenProjectileSpread:              ; DATA XREF: ROM:Boss_DestroyerMK2ProjectileSpreadPatternHandlers   o  ; was: sub_4B24E
                move.w  #(Boss_DestroyerMK2InitializeProjectileSpreadLoop-*),d7
Boss_DestroyerMK2InitializeProjectileSpreadLoop:        ; DATA XREF: Boss_DestroyerMK2SpawnTenProjectileSpread   o  ; was: loc_4B252
                moveq   #0,d6
Boss_DestroyerMK2ProjectileSpreadSpawnLoop:             ; CODE XREF: Boss_DestroyerMK2SpawnTenProjectileSpread:Boss_DestroyerMK2AdvanceProjectileSpreadLoop   j  ; was: loc_4B254
                jsr     (Projectile_FindFreeSlot).l
                bne.s   Boss_DestroyerMK2AdvanceProjectileSpreadLoop
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.b  #$C0,$21(a0)
                move.l  #$F808FE02,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                clr.w   $4C(a0)
                move.w  #4,$46(a0)
                move.w  Boss_DestroyerMK2ProjectileSpreadParameterTable(pc,d6.w),$44(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                move.w  d0,$14(a0)
                addq.w  #2,d6
Boss_DestroyerMK2AdvanceProjectileSpreadLoop:           ; CODE XREF: Boss_DestroyerMK2SpawnTenProjectileSpread+C   j  ; was: loc_4B2C0
                dbf     d7,Boss_DestroyerMK2ProjectileSpreadSpawnLoop
                clr.w   (dword_FF941C+2).w
                addq.w  #2,(dword_FF941C).w
                rts
; End of function Boss_DestroyerMK2SpawnTenProjectileSpread
; ---------------------------------------------------------------------------
Boss_DestroyerMK2ProjectileSpreadParameterTable:    dc.w    0, $FFFE, 2, $FFFC, 4, 0, $FFE0, $20, $FFC0, $40  ; was: word_4B2CE
                                        ; DATA XREF: Boss_DestroyerMK2SpawnTenProjectileSpread+5C   r

; Enter the recurring projectile-pattern state and start its delay
Boss_DestroyerMK2EnterProjectilePatternCycle:           ; DATA XREF: ROM:0004A926   o  ; was: sub_4B2E2
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2EnterProjectilePatternCycle
; Wait for the pattern delay, then return to main state $22
Boss_DestroyerMK2WaitThenRepeatProjectilePatterns:      ; DATA XREF: ROM:0004A928   o  ; was: sub_4B2F2
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2ProjectilePatternCycleReturn
                move.w  #$22,4(a5)                      ; '"'
Boss_DestroyerMK2ProjectilePatternCycleReturn:          ; CODE XREF: Boss_DestroyerMK2WaitThenRepeatProjectilePatterns+8   j  ; was: locret_4B302
                rts
; End of function Boss_DestroyerMK2WaitThenRepeatProjectilePatterns
; Wait for five linked parts to become idle before disabling collision
Boss_DestroyerMK2WaitForLinkedPartsToDeactivate:        ; DATA XREF: ROM:0004A92A   o  ; was: sub_4B304
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                tst.w   (word_FFC7A4).w
                bne.s   Boss_DestroyerMK2LinkedPartWaitReturn
                tst.w   (word_FFC804).w
                bne.s   Boss_DestroyerMK2LinkedPartWaitReturn
                tst.w   (word_FFC864).w
                bne.s   Boss_DestroyerMK2LinkedPartWaitReturn
                tst.w   (word_FFC8C4).w
                bne.s   Boss_DestroyerMK2LinkedPartWaitReturn
                tst.w   (word_FFC744).w
                bne.s   Boss_DestroyerMK2LinkedPartWaitReturn
                bsr.w   Boss_DestroyerMK2ClearLinkedCollisionFields
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2LinkedPartWaitReturn:                  ; CODE XREF: Boss_DestroyerMK2WaitForLinkedPartsToDeactivate+8   j  ; was: locret_4B334
                                        ; Boss_DestroyerMK2WaitForLinkedPartsToDeactivate+E   j
                rts
; End of function Boss_DestroyerMK2WaitForLinkedPartsToDeactivate
; Run the debris helper until the final-transition timer expires
Boss_DestroyerMK2RunDebrisTransitionTimer:              ; DATA XREF: ROM:0004A92C   o  ; was: sub_4B336
                jsr     Projectile_DestroyerMK2DebrisMain(pc)  ; (pc)
                nop
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2DebrisTransitionReturn
                addq.w  #2,4(a5)
Boss_DestroyerMK2DebrisTransitionReturn:                ; CODE XREF: Boss_DestroyerMK2RunDebrisTransitionTimer+A   j  ; was: locret_4B346
                rts
; End of function Boss_DestroyerMK2RunDebrisTransitionTimer
; Fade the transition palette, then load the first replacement tile set
Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles:        ; DATA XREF: ROM:0004A92E   o  ; was: sub_4B348
                bsr.s   Gfx_DestroyerMK2ApplyTransitionPaletteFade
                addq.w  #1,$48(a5)
                cmpi.w  #$F,$48(a5)
                bne.s   Gfx_DestroyerMK2FirstTransitionTileLoadReturn
                addq.w  #2,4(a5)
                lea     Gfx_DestroyerMK2FirstTransitionTileLoadDescriptor(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; ---------------------------------------------------------------------------
Gfx_DestroyerMK2FirstTransitionTileLoadDescriptor:  dc.w    $4480, $4000, $104, 0, 0, 0, 0, 0  ; was: word_4B366
                                        ; DATA XREF: Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles+12   o
; ---------------------------------------------------------------------------
Gfx_DestroyerMK2FirstTransitionTileLoadReturn:          ; CODE XREF: Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles+C   j  ; was: locret_4B376
                rts
; End of function Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles
; Apply one step of the final-transition palette fade
Gfx_DestroyerMK2ApplyTransitionPaletteFade:             ; CODE XREF: Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles   p  ; was: sub_4B378
                                        ; sub_4B394   p
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (PaletteActiveBuffer).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_DestroyerMK2ApplyTransitionPaletteFade
; Apply the last fade step and load the second replacement tile set
Gfx_DestroyerMK2FadeAndLoadSecondTransitionTiles:       ; DATA XREF: ROM:0004A930   o  ; was: sub_4B394
                bsr.s   Gfx_DestroyerMK2ApplyTransitionPaletteFade
                addq.w  #2,4(a5)
                lea     Gfx_DestroyerMK2SecondTransitionTileLoadDescriptor(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_DestroyerMK2FadeAndLoadSecondTransitionTiles
; ---------------------------------------------------------------------------
Gfx_DestroyerMK2SecondTransitionTileLoadDescriptor: dc.w    $4490, $4000, $104, 0, 0, 0, 0, 0  ; was: word_4B3A6
                                        ; DATA XREF: Gfx_DestroyerMK2FadeAndLoadSecondTransitionTiles+6   o

; Release transition input/display flags and advance the main state
Boss_DestroyerMK2ClearTransitionControlFlags:           ; DATA XREF: ROM:0004A932   o  ; was: sub_4B3B6
                bsr.s   Gfx_DestroyerMK2ApplyTransitionPaletteFade
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                bclr    #3,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2ClearTransitionControlFlags
; Preserve types $240 and $3DC while clearing the remaining object pool
Boss_DestroyerMK2ClearObjectsForNextEncounter:          ; DATA XREF: ROM:0004A934   o  ; was: sub_4B3D0
                bsr.s   Gfx_DestroyerMK2ApplyTransitionPaletteFade
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #4,(byte_FFA95A).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2ClearObjectsForNextEncounter
; Count the transition fade back down, remove this entity, and advance
Boss_DestroyerMK2FinishTransitionPaletteFade:           ; DATA XREF: ROM:0004A936   o  ; was: sub_4B3EC
                bsr.s   Gfx_DestroyerMK2ApplyTransitionPaletteFade
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2TransitionPaletteFadeReturn
                clr.w   (a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2TransitionPaletteFadeReturn:           ; CODE XREF: Boss_DestroyerMK2FinishTransitionPaletteFade+6   j  ; was: locret_4B3FA
                rts
; End of function Boss_DestroyerMK2FinishTransitionPaletteFade
; Select the central linked part for the shared activation helper
Boss_DestroyerMK2SelectCentralLinkedPart:               ; CODE XREF: Boss_DestroyerMK2ActivateCentralLinkedPart   p  ; was: sub_4B3FC
                movea.w #(word_FFC740-M68K_RAM),a0
; End of function Boss_DestroyerMK2SelectCentralLinkedPart
; Advance a selected linked part only when it is idle
Boss_DestroyerMK2ActivateLinkedPartIfIdle:              ; CODE XREF: Boss_DestroyerMK2ActivateNearLinkedPart:Boss_DestroyerMK2ActivateSelectedNearLinkedPart   p  ; was: sub_4B400
                                        ; sub_4B084:Boss_DestroyerMK2ActivateSelectedFarLinkedPart   p
                tst.w   4(a0)
                bne.s   Boss_DestroyerMK2LinkedPartActivationReturn
                addq.w  #2,4(a0)
Boss_DestroyerMK2LinkedPartActivationReturn:            ; CODE XREF: Boss_DestroyerMK2ActivateLinkedPartIfIdle+4   j  ; was: locret_4B40A
                rts
; End of function Boss_DestroyerMK2ActivateLinkedPartIfIdle
; Project four effects at successive angles and play sound $E9
Boss_DestroyerMK2EmitFourProjectedEffects:
                move.w  (word_FF8248).w,d0              ; was: sub_4B40C
                sub.w   $10(a5),d0
                bmi.s   Boss_DestroyerMK2InitializeLeftwardEffectProjection
                move.w  #$30,$58(a5)                    ; '0'
                move.w  #$1D0,$5A(a5)
                bra.s   Boss_DestroyerMK2FinishEffectProjectionSetup
; ---------------------------------------------------------------------------
Boss_DestroyerMK2InitializeLeftwardEffectProjection:    ; CODE XREF: Boss_DestroyerMK2EmitFourProjectedEffects+8   j  ; was: loc_4B424
                move.w  #$FFD0,$58(a5)
                move.w  #$D0,$5A(a5)
Boss_DestroyerMK2FinishEffectProjectionSetup:           ; CODE XREF: Boss_DestroyerMK2EmitFourProjectedEffects+16   j  ; was: loc_4B430
                move.w  $10(a5),d0
                add.w   d0,$58(a5)
                move.w  #4,$5C(a5)
Boss_DestroyerMK2ProjectedEffectLoop:                   ; CODE XREF: Boss_DestroyerMK2EmitFourProjectedEffects+56   j  ; was: loc_4B43E
                move.w  #4,d1
                move.w  #$8004,d2
                move.w  $58(a5),d3
                move.w  $14(a5),d4
                move.w  $5A(a5),d6
                jsr     (Boss_DestroyerMK2SpawnProjectedShot).l
                addi.w  #$20,$5A(a5)                    ; ' '
                subq.w  #1,$5C(a5)
                bne.s   Boss_DestroyerMK2ProjectedEffectLoop
                move.b  #$E9,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Boss_DestroyerMK2EmitFourProjectedEffects
; Adds a uniform offset to all 255 scroll rows until the first row reaches $110
Gfx_DestroyerMK2ApplyUniformScrollOffset:               ; CODE XREF: Boss_DestroyerMK2ApplySineScrollWaveState:Boss_DestroyerMK2ApplySineWaveRowOffset   p  ; was: sub_4B470
                cmpi.w  #$110,(word_FF9820).w
                bge.s   Gfx_DestroyerMK2ReportScrollOffsetLimit
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
Gfx_DestroyerMK2ApplyUniformScrollOffsetLoop:           ; CODE XREF: Gfx_DestroyerMK2ApplyUniformScrollOffset+12   j  ; was: loc_4B480
                add.w   d0,(a0)+
                dbf     d7,Gfx_DestroyerMK2ApplyUniformScrollOffsetLoop
                clr.w   d0
                rts
; ---------------------------------------------------------------------------
Gfx_DestroyerMK2ReportScrollOffsetLimit:                ; CODE XREF: Gfx_DestroyerMK2ApplyUniformScrollOffset+6   j  ; was: loc_4B48A
                move.w  #1,d0
                rts
; End of function Gfx_DestroyerMK2ApplyUniformScrollOffset
; Entity type $248 component and component-projectile state dispatcher
Object_DestroyerMK2ComponentMain:                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4B490
                move.w  4(a5),d0
                lea     Object_DestroyerMK2ComponentStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Object_DestroyerMK2ComponentMain
; ---------------------------------------------------------------------------
Object_DestroyerMK2ComponentStateHandlers:  dc.w    Object_DestroyerMK2ComponentIdle-*  ; DATA XREF: Object_DestroyerMK2ComponentMain+4   o  ; was: off_4B49C
                dc.w    Object_DestroyerMK2ActivateFromLinkedState-*
                dc.w    Object_DestroyerMK2InitializeProjectile-*
                dc.w    Object_DestroyerMK2SpawnProjectile-*
                dc.w    Object_DestroyerMK2InitializeMovement-*
                dc.w    Object_DestroyerMK2UpdateMovement-*
                dc.w    Object_DestroyerMK2SwitchComponentMapping-*
                dc.w    Object_DestroyerMK2WaitThenAdvanceState-*
                dc.w    Object_DestroyerMK2DeactivateAndApplyScrollPreset-*
                dc.w    Object_DestroyerMK2ResetAfterStageGate-*

Object_DestroyerMK2ComponentIdle:                       ; DATA XREF: ROM:Object_DestroyerMK2ComponentStateHandlers   o  ; was: nullsub_105
                rts
; End of function Object_DestroyerMK2ComponentIdle

; Activate after the referenced linked part becomes idle
Object_DestroyerMK2ActivateFromLinkedState:             ; DATA XREF: ROM:0004B49E   o  ; was: sub_4B4B2
                tst.w   (word_FFF720).w
                bmi.w   Object_DestroyerMK2StageGateReturn
                move.w  $4E(a5),d0
                movea.w Object_DestroyerMK2LinkedObjectAddressTable(pc,d0.w),a0
                tst.w   4(a0)
                bne.w   Object_DestroyerMK2StageGateReturn
                addq.w  #2,4(a5)
                ori.w   #$8000,2(a5)
                lea     Object_DestroyerMK2ActivationScrollHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Object_DestroyerMK2ActivateFromLinkedState
; ---------------------------------------------------------------------------
Object_DestroyerMK2ActivationScrollHandlers:    dc.w    Object_DestroyerMK2ApplyScrollPresetA-*  ; DATA XREF: Object_DestroyerMK2ActivateFromLinkedState+22   o  ; was: off_4B4DC
                dc.w    Object_DestroyerMK2ApplyScrollPresetB-*
                dc.w    Object_DestroyerMK2ApplyScrollPresetC-*
                dc.w    Object_DestroyerMK2ApplyScrollPresetD-*

; Apply stage-14 component scroll preset A
Object_DestroyerMK2ApplyScrollPresetA:                  ; DATA XREF: ROM:Object_DestroyerMK2ActivationScrollHandlers   o  ; was: sub_4B4E4
                move.l  #$44804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Object_DestroyerMK2ApplyScrollPresetA
; Apply stage-14 component scroll preset B
Object_DestroyerMK2ApplyScrollPresetB:                  ; DATA XREF: ROM:0004B4DE   o  ; was: sub_4B4F2
                move.l  #$44984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Object_DestroyerMK2ApplyScrollPresetB
; Apply stage-14 component scroll preset C
Object_DestroyerMK2ApplyScrollPresetC:                  ; DATA XREF: ROM:0004B4E0   o  ; was: sub_4B500
                move.l  #$4C804001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Object_DestroyerMK2ApplyScrollPresetC
; Apply stage-14 component scroll preset D
Object_DestroyerMK2ApplyScrollPresetD:                  ; DATA XREF: ROM:0004B4E2   o  ; was: sub_4B50E
                move.l  #$4C984001,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Object_DestroyerMK2ApplyScrollPresetD
; ---------------------------------------------------------------------------
Object_DestroyerMK2LinkedObjectAddressTable:    dc.w    $C800, $C7A0, $C8C0, $C860  ; was: word_4B51C
                                        ; DATA XREF: Object_DestroyerMK2ActivateFromLinkedState+C   r

; Initialize a component's mapping and projectile delay
Object_DestroyerMK2InitializeProjectile:                ; DATA XREF: ROM:0004B4A0   o  ; was: sub_4B524
                tst.w   (word_FFF720).w
                bmi.w   Object_DestroyerMK2StageGateReturn
                move.l  #word_EC2B6,8(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Object_DestroyerMK2InitializeProjectile
; Spawn a type-$248 projectile using the component-index tables
Object_DestroyerMK2SpawnProjectile:                     ; DATA XREF: ROM:0004B4A2   o  ; was: sub_4B540
                subq.w  #1,$48(a5)
                bpl.w   Object_DestroyerMK2ProjectileSpawnReturn
                addq.w  #2,4(a5)
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Object_DestroyerMK2ProjectileSpawnReturn
                move.w  #$248,(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.b  #$10,$23(a0)
                move.l  #$FC04D42C,$2C(a0)
                move.w  #$100,$26(a0)
                move.w  #$CD00,2(a0)
                move.l  #word_EC292,8(a0)
                move.w  #$4300,$E(a0)
                move.b  $20(a5),$20(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.w  $4E(a5),d0
                move.w  Object_DestroyerMK2ProjectileXOffsetTable(pc,d0.w),d1
                add.w   d1,$10(a0)
                move.w  Object_DestroyerMK2ProjectileYOffsetTable(pc,d0.w),d1
                add.w   d1,$14(a0)
                move.w  Object_DestroyerMK2ProjectileDirectionTable(pc,d0.w),$4C(a0)
                add.w   d0,d0
                move.l  Object_DestroyerMK2ProjectileVelocityTable(pc,d0.w),$50(a0)
                tst.w   (DifficultyMode).w
                beq.s   Object_DestroyerMK2SetNormalProjectileDelay
                move.w  #$C,$48(a5)
                move.w  #$C,$48(a0)
                rts
; ---------------------------------------------------------------------------
Object_DestroyerMK2SetNormalProjectileDelay:            ; CODE XREF: Object_DestroyerMK2SpawnProjectile+80   j  ; was: loc_4B5D0
                move.w  #$18,$48(a5)
                move.w  #$18,$48(a0)
Object_DestroyerMK2ProjectileSpawnReturn:               ; CODE XREF: Object_DestroyerMK2SpawnProjectile+4   j  ; was: locret_4B5DC
                                        ; Object_DestroyerMK2SpawnProjectile+12   j
                rts
; End of function Object_DestroyerMK2SpawnProjectile
; ---------------------------------------------------------------------------
Object_DestroyerMK2ProjectileXOffsetTable:  dc.w    $18, $FFE8  ; DATA XREF: Object_DestroyerMK2SpawnProjectile+5E   r  ; was: word_4B5DE
                dc.w    $18, $FFE8
Object_DestroyerMK2ProjectileYOffsetTable:  dc.w    1, 1  ; DATA XREF: Object_DestroyerMK2SpawnProjectile+66   r  ; was: word_4B5E6
                dc.w    $FFFF, $FFFF
Object_DestroyerMK2ProjectileDirectionTable:    dc.w    $FFFF, 1  ; DATA XREF: Object_DestroyerMK2SpawnProjectile+6E   r  ; was: word_4B5EE
                dc.w    $FFFF, 1
Object_DestroyerMK2ProjectileVelocityTable: dc.l    $FFFFE000, $2000  ; DATA XREF: Object_DestroyerMK2SpawnProjectile+76   r  ; was: dword_4B5F6
                dc.l    $FFFFE000, $2000

; Initialize velocity and acceleration selected by component index
Object_DestroyerMK2InitializeMovement:                  ; DATA XREF: ROM:0004B4A4   o  ; was: sub_4B606
                subq.w  #1,$48(a5)
                bne.s   Object_DestroyerMK2MovementInitReturn
                move.w  $4E(a5),d0
                clr.l   $58(a5)
                add.w   d0,d0
                move.l  Object_DestroyerMK2InitialVelocityTable(pc,d0.w),$50(a5)
                move.l  Object_DestroyerMK2AccelerationTable(pc,d0.w),$54(a5)
                addq.w  #2,4(a5)
                move.b  #$E7,d0
                jsr     (Sound_PlaySFX).l
Object_DestroyerMK2MovementInitReturn:                  ; CODE XREF: Object_DestroyerMK2InitializeMovement+4   j  ; was: locret_4B630
                rts
; End of function Object_DestroyerMK2InitializeMovement
; ---------------------------------------------------------------------------
Object_DestroyerMK2InitialVelocityTable:    dc.l    $20000, $FFFE0000  ; DATA XREF: Object_DestroyerMK2InitializeMovement+10   r  ; was: dword_4B632
                dc.l    $20000, $FFFE0000
Object_DestroyerMK2AccelerationTable:   dc.l    $FFFFE000, $2000  ; DATA XREF: Object_DestroyerMK2InitializeMovement+16   r  ; was: dword_4B642
                dc.l    $FFFFE000, $2000

; Integrate component motion and apply its offset to seven scroll layers
Object_DestroyerMK2UpdateMovement:                      ; DATA XREF: ROM:0004B4A6   o  ; was: sub_4B652
                move.l  $54(a5),d0
                add.l   d0,$50(a5)
                move.l  $50(a5),d0
                add.l   d0,$58(a5)
                move.w  $58(a5),d0
                cmpi.w  #4,$4E(a5)
                bcc.s   Object_DestroyerMK2SelectLowerScrollLayerGroup
                lea     (word_FFE52C).w,a0
                bra.s   Object_DestroyerMK2ApplyMovementToScrollLayers
; ---------------------------------------------------------------------------
Object_DestroyerMK2SelectLowerScrollLayerGroup:         ; CODE XREF: Object_DestroyerMK2UpdateMovement+1A   j  ; was: loc_4B674
                lea     (word_FFE720).w,a0
Object_DestroyerMK2ApplyMovementToScrollLayers:         ; CODE XREF: Object_DestroyerMK2UpdateMovement+20   j  ; was: loc_4B678
                bsr.s   Gfx_UpdateMultipleScrollLayers
                tst.l   $58(a5)
                bne.s   Object_DestroyerMK2MovementUpdateReturn
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
Object_DestroyerMK2MovementUpdateReturn:                ; CODE XREF: Object_DestroyerMK2UpdateMovement+2C   j  ; was: locret_4B68A
                rts
; End of function Object_DestroyerMK2UpdateMovement
