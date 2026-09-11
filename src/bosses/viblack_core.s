; Handles type-$210 Viblack missiles through their currently inert update path
Projectile_ViblackMissileMain:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_43930
                lea     (Entity_ObjectPool).w,a3
                lea     (word_FF9800).w,a4
                bsr.s   Projectile_ViblackMissileNoOp
                rts
; End of function Projectile_ViblackMissileMain
; ---------------------------------------------------------------------------
                dc.l    off_EBFC0
                dc.l    off_EBFCC

Projectile_ViblackMissileNoOp:                          ; CODE XREF: Projectile_ViblackMissileMain+8   p  ; was: nullsub_7
                rts
; End of function Projectile_ViblackMissileNoOp

; Dispatches the two equivalent states of the type-$210 missile spawner
Projectile_ViblackMissileSpawnerMain:
                movea.w 4(a5),a0                        ; was: sub_43946
                lea     Projectile_ViblackMissileSpawnerStates(pc,a0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_ViblackMissileSpawnerMain
; ---------------------------------------------------------------------------
Projectile_ViblackMissileSpawnerStates: dc.w    Projectile_SpawnViblackMissile-*  ; DATA XREF: Projectile_ViblackMissileSpawnerMain+4   o ; was: off_43952
                dc.w    Projectile_SpawnViblackMissile-*

; Spawns missile projectile at entity position
Projectile_SpawnViblackMissile:                         ; DATA XREF: ROM:Projectile_ViblackMissileSpawnerStates   o  ; was: sub_43956
                                        ; ROM:00043954   o
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Boss_SunsetStingReturn
                move.w  #$210,(a0)
                move.w  #$ED00,2(a0)
                move.w  #$6300,$E(a0)
                move.l  #off_EBFCC,8(a0)
                move.b  #$3C,$20(a0)                    ; '<'
                move.w  $10(a3),$10(a0)
                move.w  $14(a3),$14(a0)
                rts
; End of function Projectile_SpawnViblackMissile

; Main Viblack mini-boss handler
Boss_ViblackMain:                                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4398C
                tst.w   4(a5)
                beq.w   Boss_ViblackStateDispatch
                addq.w  #1,$4E(a5)
                lea     Boss_ViblackPaletteCycleEntries(pc),a2
                nop
                jsr     (Gfx_ProcessColorFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
                movea.w #(word_FFC680-M68K_RAM),a4
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_ViblackStateDispatch
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_ViblackStateDispatch
                tst.w   (word_FF8200).w
                beq.w   Boss_ViblackDefeatInit
; State machine dispatcher for Viblack boss
Boss_ViblackStateDispatch:                              ; CODE XREF: Boss_ViblackMain+4   j  ; was: loc_439CC
                                        ; Boss_ViblackMain+2E   j
                move.w  4(a5),d0
                movea.w Boss_ViblackStates(pc,d0.w),a0
                adda.l  #Boss_ViblackInit,a0
                jmp     (a0)
; End of function Boss_ViblackMain
; ---------------------------------------------------------------------------
Boss_ViblackStates: dc.w    Boss_ViblackInit-Boss_ViblackInit  ; was: off_439DC
                                        ; DATA XREF: Boss_ViblackMain+44   r
                dc.w    Boss_ViblackIntroSetup-Boss_ViblackInit
                dc.w    Boss_ViblackEntranceDescentState-Boss_ViblackInit
                dc.w    Boss_ViblackFinishEntranceMotionState-Boss_ViblackInit
                dc.w    Boss_ViblackMoveToAttackTargetState-Boss_ViblackInit
                dc.w    Boss_ViblackChainAttackWaitState-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatMoveToTargetState-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatWaitState-Boss_ViblackInit
                dc.w    Boss_ViblackMoveToProjectileAttackTargetState-Boss_ViblackInit
                dc.w    Boss_ViblackRadialShotAttackState-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatDescendState-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatRiseState-Boss_ViblackInit
                dc.w    Boss_ViblackTransitionOscillationState-Boss_ViblackInit
                dc.w    Boss_ViblackTransitionTimerState-Boss_ViblackInit
                dc.w    Boss_ViblackStartFinalTransitionMotionState-Boss_ViblackInit
                dc.w    Boss_ViblackFinishTransitionState-Boss_ViblackInit

; Initializes Viblack mini-boss
Boss_ViblackInit:                                       ; DATA XREF: Boss_ViblackMain+48   o  ; was: sub_439FC
                                        ; ROM:Boss_ViblackStates   o
                addq.w  #2,4(a5)
                move.w  #$C2F8,(word_FF8110).w
                move.w  #$20,(word_FF8112).w            ; ' '
                move.b  #4,(VDPReg11Shadow+1).w
                move.b  #8,(byte_FFA95A).w
                move.b  #$20,(byte_FFA95B).w            ; ' '
                move.w  #1,(word_FF8218).w
                move.w  #$30,$48(a5)                    ; '0'
                move.b  #6,(byte_FF80EC).w
; Sets up intro graphics and position
Boss_ViblackIntroSetup:                                 ; DATA XREF: ROM:000439DE   o  ; was: loc_43A30
                subq.w  #1,$48(a5)
                bpl.w   Boss_ViblackStateReturn
                addq.w  #2,4(a5)
                move.w  #$D00,2(a5)
                move.w  #$5000,(word_FF8200).w
                move.w  #$5000,(word_FF8202).w
                move.w  #$1C,$24(a5)
                move.b  #$10,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$F010F010,$28(a5)
                move.w  (dword_FFA410).w,$10(a5)
                move.w  #$7C,$14(a5)                    ; '|'
                move.w  #8,$1C(a5)
                move.w  #$10,(a4)
                clr.w   2(a4)
                move.b  #$20,$21(a4)                    ; ' '
                move.w  #4,$46(a4)
                move.l  #$FF770088,$28(a4)
                lea     (Boss_ViblackIntroPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                lea     Boss_ViblackPaletteCycleEntries(pc),a2
                nop
                jsr     (Gfx_ClearColorFadeState).l
                lea     Boss_ViblackTileLoadCommand(pc),a0
                nop
                move.w  #$8000,d0
                jsr     (Gfx_AdjustSelectedTileBlocks).l
                movea.l #$FFFF5520,a0
                move.w  #$2000,d0
                moveq   #$49,d7                         ; 'I'
                jsr     (Gfx_AdjustTileIndexRows).l
                lea     Boss_ViblackCompressedTileLoadCommand(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                bra.w   Boss_ViblackBuildScrollProfile
; End of function Boss_ViblackInit
; ---------------------------------------------------------------------------
Boss_ViblackTileLoadCommand:    dc.w    $4000, $8E8F, $9091, $9293, $9899, $9A9B, $9C9D, $A2FF  ; was: word_43AE0
                                        ; DATA XREF: Boss_ViblackInit+B2   o
Boss_ViblackCompressedTileLoadCommand:  dc.w    $6000, $4000, $901, $8E8F, $9091, $9293, $9899, $9A9B, 0, 0, $9C9D, 0, 0  ; was: word_43AF0
                                        ; DATA XREF: Boss_ViblackInit+D4   o
Boss_ViblackPaletteCycleEntries:    dc.w    $D, $E302, $E304, $E306, $E30C, $E30A, $E30C, $E30E, $E310, $E312, $E314, $E316, $E318, $E31A, $E31E  ; was: word_43B0A
                                        ; DATA XREF: Boss_ViblackMain+C   o
                                        ; Boss_ViblackInit+A6   o

; Descends toward the stage-surface threshold and prepares the active arena
Boss_ViblackEntranceDescentState:                       ; DATA XREF: ROM:000439E0   o  ; was: sub_43B28
                bsr.w   Sound_ViblackPeriodic
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                subi.l  #$2000,$1C(a5)
                move.w  (dword_FFA414).w,d0
                sub.w   $14(a5),d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   Boss_ViblackEntranceDescentReturn
                addq.w  #2,4(a5)
                move.l  #$30000,$1C(a5)
                move.w  #$30,(word_FFA02A).w            ; '0'
                bset    #5,(byte_FF8245).w
                bset    #4,(word_FFA40E).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$8000,(word_FF808A).w
                move.w  #4,(word_FFA010).w
                move.b  #$DA,d0
                jsr     (Sound_PlaySFX).l
                bra.s   Boss_ViblackUpdateStageSurfaceReference
; ---------------------------------------------------------------------------
Boss_ViblackEntranceDescentReturn:                      ; CODE XREF: Boss_ViblackEntranceDescentState+1C   j  ; was: locret_43B82
                rts
; End of function Boss_ViblackEntranceDescentState
; Continues entrance acceleration until the active battle state is ready
Boss_ViblackFinishEntranceMotionState:                  ; DATA XREF: ROM:000439E2   o  ; was: sub_43B84
                bsr.w   Sound_ViblackPeriodic
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                subi.l  #$2800,$1C(a5)
                bpl.s   Boss_ViblackUpdateStageSurfaceReference
                cmpi.w  #$FFFA,$1C(a5)
                bpl.s   Boss_ViblackUpdateStageSurfaceReference
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$C,$5A(a5)
                move.w  #$FFFF,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (word_FFA02A).w
                bclr    #5,(byte_FF8245).w
                addq.w  #2,(word_FFA404).w
Boss_ViblackUpdateStageSurfaceReference:                ; CODE XREF: Boss_ViblackEntranceDescentState+58   j  ; was: loc_43BD0
                                        ; Boss_ViblackFinishEntranceMotionState+10   j
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  $14(a4),d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                rts
; End of function Boss_ViblackFinishEntranceMotionState
; Moves to the next attack target and selects chain or radial-shot activity
Boss_ViblackMoveToAttackTargetState:                    ; DATA XREF: ROM:000439E4   o  ; was: sub_43BE2
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                bsr.w   Boss_ViblackSpawnSideShot
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   Boss_ViblackStateReturn
                move.w  (RandomNumberState).w,d0
                subq.w  #1,$5A(a5)
                bpl.s   Boss_ViblackStartChainAttack
                move.w  #$10,4(a5)
                andi.w  #$F,d0
                addi.w  #8,d0
                move.w  d0,$5A(a5)
                move.w  #2,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ViblackStartChainAttack:                           ; CODE XREF: Boss_ViblackMoveToAttackTargetState+16   j  ; was: loc_43C20
                addq.w  #2,4(a5)
                bsr.w   Boss_ViblackSpawnChain
                tst.w   (word_FFC740).w
                bne.s   Boss_ViblackSetRandomDelay
                move.w  #$60,$48(a5)                    ; '`'
                rts
; ---------------------------------------------------------------------------
; Sets random delay timer for actions
Boss_ViblackSetRandomDelay:                             ; CODE XREF: Boss_ViblackMoveToAttackTargetState+4A   j  ; was: loc_43C36
                move.w  (RandomNumberState).w,d0
                andi.w  #$40,d0                         ; '@'
                addq.w  #8,d0
                move.w  d0,$48(a5)
Boss_ViblackStateReturn:                                ; CODE XREF: Boss_ViblackInit+38   j  ; was: locret_43C44
                                        ; Boss_ViblackMoveToAttackTargetState+C   j
                rts
; End of function Boss_ViblackMoveToAttackTargetState
; Holds the chain-attack state until its delay expires
Boss_ViblackChainAttackWaitState:                       ; DATA XREF: ROM:000439E6   o  ; was: sub_43C46
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                bsr.w   Boss_ViblackSpawnSideShot
                subq.w  #1,$48(a5)
                bpl.s   Boss_ViblackChainAttackWaitReturn
Boss_ViblackSelectNextAttackTarget:                     ; CODE XREF: Boss_ViblackRadialShotAttackState+8   j  ; was: loc_43C54
                move.w  #8,4(a5)
                bra.w   Boss_ViblackSetRandomTarget
; ---------------------------------------------------------------------------
Boss_ViblackChainAttackWaitReturn:                      ; CODE XREF: Boss_ViblackChainAttackWaitState+C   j  ; was: locret_43C5E
                rts
; End of function Boss_ViblackChainAttackWaitState
; Moves to the fixed target used by the radial-shot phase
Boss_ViblackMoveToProjectileAttackTargetState:          ; DATA XREF: ROM:000439EC   o  ; was: sub_43C60
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   Boss_ViblackStateReturn
                addq.w  #2,4(a5)
                move.w  #$100,$48(a5)
                rts
; End of function Boss_ViblackMoveToProjectileAttackTargetState
; Emits mirrored shot pairs through the timer-indexed angle sequence
Boss_ViblackRadialShotAttackState:                      ; DATA XREF: ROM:000439EE   o  ; was: sub_43C76
                bsr.w   Boss_ViblackUpdateScrollAndCompanion
                subq.w  #1,$48(a5)
                bmi.w   Boss_ViblackSelectNextAttackTarget
                cmpi.w  #$20,$48(a5)                    ; ' '
                bmi.w   Boss_ViblackStateReturn
                btst    #0,(word_FFA000+1).w
                bne.w   Boss_ViblackStateReturn
                lea     Boss_ViblackShotAngleSequence(pc),a1
                nop
                move.w  $48(a5),d0
                andi.w  #$F,d0
                moveq   #0,d6
                move.b  (a1,d0.w),d6
                asl.w   #1,d6
                moveq   #1,d5
Boss_ViblackSpawnShotPairLoop:                          ; CODE XREF: Boss_ViblackRadialShotAttackState+CA   j  ; was: loc_43CAE
                                        ; Boss_ViblackRadialShotAttackState+D6   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   Boss_ViblackStateReturn
                cmpi.w  #$A0,$48(a5)
                bpl.s   Boss_ViblackInitializeStandardRadialShot
                move.w  #$8008,d2
                moveq   #$24,d7                         ; '$'
                jsr     (Enemy_SetProjectileDifficulty).l
                bra.s   Boss_ViblackPositionRadialShot
; ---------------------------------------------------------------------------
Boss_ViblackInitializeStandardRadialShot:               ; CODE XREF: Boss_ViblackRadialShotAttackState+48   j  ; was: loc_43CCE
                lea     (Boss_SharedCollisionProjectileSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d6.w),d0
                move.w  (a1,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
Boss_ViblackPositionRadialShot:                         ; CODE XREF: Boss_ViblackRadialShotAttackState+56   j  ; was: loc_43CF8
                move.w  $10(a5),d0
                tst.w   d5
                beq.s   Boss_ViblackPositionRightRadialShot
                subi.w  #$1C,d0
                move.w  d6,d1
                move.w  #$100,d6
                sub.w   d1,d6
                bra.s   Boss_ViblackPositionRadialShotOnSurface
; ---------------------------------------------------------------------------
Boss_ViblackPositionRightRadialShot:                    ; CODE XREF: Boss_ViblackRadialShotAttackState+88   j  ; was: loc_43D0E
                addi.w  #$1C,d0
                bset    #3,$E(a0)
Boss_ViblackPositionRadialShotOnSurface:                ; CODE XREF: Boss_ViblackRadialShotAttackState+96   j  ; was: loc_43D18
                move.w  d0,$10(a0)
                subi.w  #$80,d0
                bmi.s   Boss_ViblackDisableOutOfRangeRadialShot
                cmpi.w  #$140,d0
                bpl.s   Boss_ViblackDisableOutOfRangeRadialShot
                asr.w   #3,d0
                andi.w  #$FFFE,d0
                addi.w  #-$6B80,d0
                movea.w d0,a1
                move.w  (a1),d0
                neg.w   d0
                subi.w  #$160,d0
                move.w  d0,$14(a0)
                dbf     d5,Boss_ViblackSpawnShotPairLoop
                rts
; ---------------------------------------------------------------------------
Boss_ViblackDisableOutOfRangeRadialShot:                ; CODE XREF: Boss_ViblackRadialShotAttackState+AA   j  ; was: loc_43D46
                                        ; Boss_ViblackRadialShotAttackState+B0   j
                bset    #4,2(a0)
                dbf     d5,Boss_ViblackSpawnShotPairLoop
                rts
; End of function Boss_ViblackRadialShotAttackState
; ---------------------------------------------------------------------------
Boss_ViblackShotAngleSequence:  dc.b    $50, $4C, $48, $44, $40, $3C, $38, $34, $30, $34, $38, $3C, $40, $44, $48, $4C  ; was: byte_43D52
                                        ; DATA XREF: Boss_ViblackRadialShotAttackState+20   o

; Initializes defeat sequence
Boss_ViblackDefeatInit:                                 ; CODE XREF: Boss_ViblackMain+3C   j  ; was: sub_43D62
                move.b  #1,(byte_FF830E).w
                move.w  #$C,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                clr.b   $21(a5)
                move.w  #$80,(word_FF808C).w
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
; Moves Viblack to the fixed defeat-transition target
Boss_ViblackDefeatMoveToTargetState:                    ; DATA XREF: ROM:000439E8   o  ; was: loc_43D90
                bsr.w   Boss_ViblackUpdateDefeatEffectsAndParticles
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   Boss_ViblackDefeatMoveToTargetReturn
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$80,$48(a5)
Boss_ViblackDefeatMoveToTargetReturn:                   ; CODE XREF: Boss_ViblackDefeatInit+36   j  ; was: locret_43DA8
                rts
; End of function Boss_ViblackDefeatInit
; Waiting state with timer countdown
Boss_ViblackDefeatWaitState:                            ; DATA XREF: ROM:000439EA   o  ; was: sub_43DAA
                bsr.w   Boss_ViblackUpdateDefeatSoundAndParticles
                subq.w  #1,$48(a5)
                bpl.s   Boss_ViblackDefeatWaitReturn
                move.w  #$14,4(a5)
                clr.w   (word_FF8112).w
Boss_ViblackDefeatWaitReturn:                           ; CODE XREF: Boss_ViblackDefeatWaitState+8   j  ; was: locret_43DBE
                rts
; End of function Boss_ViblackDefeatWaitState
; Accelerates downward until Viblack reaches Y $100
Boss_ViblackDefeatDescendState:                         ; DATA XREF: ROM:000439F0   o  ; was: sub_43DC0
                bsr.w   Boss_ViblackUpdateDefeatSoundAndParticles
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$100,$14(a5)
                bmi.s   Boss_ViblackDefeatDescendReturn
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
Boss_ViblackDefeatDescendReturn:                        ; CODE XREF: Boss_ViblackDefeatDescendState+12   j  ; was: locret_43DDC
                rts
; End of function Boss_ViblackDefeatDescendState
; Accelerates upward to Y $C8 and prepares the transition companion
Boss_ViblackDefeatRiseState:                            ; DATA XREF: ROM:000439F2   o  ; was: sub_43DDE
                bsr.w   Boss_ViblackUpdateDefeatSoundAndParticles
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$C8,$14(a5)
                bpl.w   Boss_ViblackStateReturn
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.w   $52(a5)
                move.w  #$FFF0,$54(a5)
                btst    #4,(word_FFA40E).w
                beq.s   Boss_ViblackInitializeTransitionCompanion
                move.w  #$4C,(word_FFA404).w            ; 'L'
                move.w  #$FFF8,(dword_FFA41C).w
                jsr     (Sys_ClearObjectBlocks16).l
Boss_ViblackInitializeTransitionCompanion:              ; CODE XREF: Boss_ViblackDefeatRiseState+2E   j  ; was: loc_43E20
                move.w  #$320,(word_FFC680).w
                clr.w   (word_FFC682).w
                move.w  #2,(word_FFC6C6).w
                clr.l   (dword_FFC6DC).w
                move.b  #2,(byte_FFA95A).w
                move.b  #$4D,d0                         ; 'M'
                jmp     (Sound_PlaySFX).l
; End of function Boss_ViblackDefeatRiseState
; Oscillates transition displacement and writes paired transition offsets
Boss_ViblackTransitionOscillationState:                 ; DATA XREF: ROM:000439F4   o  ; was: sub_43E44
                clr.w   $4E(a5)
                bsr.w   Boss_ViblackUpdateTransitionEffects
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   Boss_ViblackHandleSettledTransitionMotion
                bpl.s   Boss_ViblackClampPositiveTransitionTarget
Boss_ViblackClampNegativeTransitionTarget:              ; CODE XREF: Boss_ViblackTransitionTimerState+70   j  ; was: loc_43E58
                                        ; Boss_ViblackFinishTransitionState+16   j
                cmpi.w  #$FFF0,d0
                bpl.s   Boss_ViblackCompareNegativeTransitionDisplacement
                moveq   #$FFFFFFF0,d0
Boss_ViblackCompareNegativeTransitionDisplacement:      ; CODE XREF: Boss_ViblackTransitionOscillationState+18   j  ; was: loc_43E60
                cmp.w   d1,d0
                beq.s   Boss_ViblackReverseNegativeTransitionMotion
                bpl.s   Boss_ViblackReverseNegativeTransitionMotion
                subq.w  #4,$52(a5)
                subq.w  #4,d1
                bra.s   Boss_ViblackWriteTransitionOffsetPairs
; ---------------------------------------------------------------------------
Boss_ViblackReverseNegativeTransitionMotion:            ; CODE XREF: Boss_ViblackTransitionOscillationState+1E   j  ; was: loc_43E6E
                                        ; Boss_ViblackTransitionOscillationState+20   j
                neg.w   $54(a5)
                subq.w  #2,$54(a5)
                bra.s   Boss_ViblackReloadTransitionDisplacement
; ---------------------------------------------------------------------------
Boss_ViblackClampPositiveTransitionTarget:              ; CODE XREF: Boss_ViblackTransitionOscillationState+12   j  ; was: loc_43E78
                                        ; Boss_ViblackTransitionTimerState+6C   j
                cmpi.w  #$10,d0
                bmi.s   Boss_ViblackComparePositiveTransitionDisplacement
                moveq   #$10,d0
Boss_ViblackComparePositiveTransitionDisplacement:      ; CODE XREF: Boss_ViblackTransitionOscillationState+38   j  ; was: loc_43E80
                cmp.w   d1,d0
                beq.s   Boss_ViblackReversePositiveTransitionMotion
                bmi.s   Boss_ViblackReversePositiveTransitionMotion
                addq.w  #4,$52(a5)
                addq.w  #4,d1
                bra.s   Boss_ViblackWriteTransitionOffsetPairs
; ---------------------------------------------------------------------------
Boss_ViblackReversePositiveTransitionMotion:            ; CODE XREF: Boss_ViblackTransitionOscillationState+3E   j  ; was: loc_43E8E
                                        ; Boss_ViblackTransitionOscillationState+40   j
                neg.w   $54(a5)
                addq.w  #2,$54(a5)
                bra.s   Boss_ViblackReloadTransitionDisplacement
; ---------------------------------------------------------------------------
Boss_ViblackHandleSettledTransitionMotion:              ; CODE XREF: Boss_ViblackTransitionOscillationState+10   j  ; was: loc_43E98
                tst.w   d1
                bpl.s   Boss_ViblackAdvanceToTransitionTimer
                clr.w   $52(a5)
                moveq   #0,d1
                bra.s   Boss_ViblackWriteTransitionOffsetPairs
; ---------------------------------------------------------------------------
Boss_ViblackAdvanceToTransitionTimer:                   ; CODE XREF: Boss_ViblackTransitionOscillationState+56   j  ; was: loc_43EA4
                addq.w  #2,4(a5)
                move.w  #$140,$48(a5)
                rts
; ---------------------------------------------------------------------------
Boss_ViblackReloadTransitionDisplacement:               ; CODE XREF: Boss_ViblackTransitionOscillationState+32   j  ; was: loc_43EB0
                                        ; Boss_ViblackTransitionOscillationState+52   j
                move.w  $52(a5),d1
Boss_ViblackWriteTransitionOffsetPairs:                 ; CODE XREF: Boss_ViblackTransitionOscillationState+28   j  ; was: loc_43EB4
                                        ; Boss_ViblackTransitionOscillationState+48   j
                asr.w   #1,d1
                addi.w  #$C7,d1
                move.w  d1,$14(a5)
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                moveq   #$18,d1
                move.w  $52(a5),d2
                neg.w   d2
                asl.w   #4,d2
                moveq   #9,d7
                movea.w #(word_FFEC24-M68K_RAM),a0
                movea.w #(word_FFEC28-M68K_RAM),a1
Boss_ViblackWriteTransitionOffsetPairsLoop:             ; CODE XREF: Boss_ViblackTransitionOscillationState+A6   j  ; was: loc_43ED8
                move.w  d2,d3
                ext.l   d3
                divs.w  d1,d3
                add.w   d0,d3
                move.w  d3,(a0)
                move.w  d3,(a1)
                subq.w  #4,a0
                addq.w  #4,a1
                addq.w  #3,d1
                dbf     d7,Boss_ViblackWriteTransitionOffsetPairsLoop
                rts
; End of function Boss_ViblackTransitionOscillationState
