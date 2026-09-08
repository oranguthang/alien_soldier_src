; Shared type-$3C4 Missiray falling shots and delayed rising-wave members
Projectile_InitMissirayFallingShot:                     ; CODE XREF: Orphaned_RisingShotPairFireFallingShot+32   p  ; was: sub_33956
                                        ; Segment_MissirayType1Fire+34   p
                move.b  #0,$47(a0)
                move.l  #word_EB3D8,8(a0)
                move.l  #$F010FE02,$2C(a0)
                move.l  #$F010F808,$28(a0)
                bra.s   Projectile_InitMissirayAndRisingShotCommon
; End of function Projectile_InitMissirayFallingShot
; Initializes a delayed rising-wave member
Projectile_InitRisingShotWaveMember:                    ; CODE XREF: Effect_RisingShotWaveLaunchPattern+46   p  ; was: sub_33976
                                        ; Orphaned_RisingShotPairLaunch+22   p
                move.b  #1,$47(a0)
                move.l  #word_EB3FC,8(a0)
                move.l  #$E020FE02,$2C(a0)
                move.l  #$E020F808,$28(a0)
                move.w  d4,$48(a0)
Projectile_InitMissirayAndRisingShotCommon:             ; CODE XREF: Projectile_InitMissirayFallingShot+1E   j  ; was: loc_33998
                move.w  #$3C4,(a0)
                move.w  #$400,$E(a0)
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   Projectile_InitMissirayAndRisingShotFinish
                ori.w   #$4000,$E(a0)
Projectile_InitMissirayAndRisingShotFinish:             ; CODE XREF: Projectile_InitRisingShotWaveMember+32   j  ; was: loc_339B0
                move.w  #$CC00,2(a0)
                move.w  #$28,$24(a0)                    ; '('
                move.w  #$64,$26(a0)                    ; 'd'
                move.b  #$40,$20(a0)                    ; '@'
                clr.w   $C(a0)
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$58(a0)
                move.l  d3,$5C(a0)
                rts
; End of function Projectile_InitRisingShotWaveMember
; Handles collision and dispatches the shared type-$3C4 projectile states
Projectile_MissirayAndRisingShotMain:                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_339DE
                tst.w   4(a5)
                beq.s   Projectile_MissirayAndRisingShotDispatchState
                cmpi.w  #$E,4(a5)
                bcc.s   Projectile_MissirayAndRisingShotDispatchState
                cmpi.w  #$3E0,(word_FFDB20).w
                bne.s   Projectile_MissirayAndRisingShotCheckCollision
                btst    #1,(byte_FF80EC).w
                bne.w   Projectile_MissirayAndRisingShotBeginImpact
                moveq   #0,d0
                move.b  $2C(a5),d0
                ext.w   d0
                add.w   $14(a5),d0
                cmp.w   (dword_FFDB34).w,d0
                bgt.s   Projectile_MissirayAndRisingShotCheckCollision
                bset    #6,(byte_FFDB42).w
                move.w  #$12,4(a5)
                clr.b   $21(a5)
                bra.s   Projectile_MissirayAndRisingShotDispatchState
; ---------------------------------------------------------------------------
Projectile_MissirayAndRisingShotCheckCollision:         ; CODE XREF: Projectile_MissirayAndRisingShotMain+14   j  ; was: loc_33A22
                                        ; Projectile_MissirayAndRisingShotMain+30   j
                bclr    #7,$22(a5)
                bne.s   Projectile_MissirayAndRisingShotBeginImpact
                tst.w   $24(a5)
                bpl.s   Projectile_MissirayAndRisingShotDispatchState
Projectile_MissirayAndRisingShotBeginImpact:            ; CODE XREF: Projectile_MissirayAndRisingShotMain+1C   j  ; was: loc_33A30
                                        ; Projectile_MissirayAndRisingShotMain+4A   j
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                move.w  #$E,4(a5)
                clr.b   $21(a5)
Projectile_MissirayAndRisingShotDispatchState:          ; CODE XREF: Projectile_MissirayAndRisingShotMain+4   j  ; was: loc_33A44
                                        ; Projectile_MissirayAndRisingShotMain+C   j
                move.w  4(a5),d0
                lea     Projectile_MissirayAndRisingShotStates(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_MissirayAndRisingShotMain
; ---------------------------------------------------------------------------
Projectile_MissirayAndRisingShotStates: dc.w    Projectile_MissirayAndRisingShotSelectVariant-*  ; DATA XREF: Projectile_MissirayAndRisingShotMain+6A   o  ; was: off_33A50
                dc.w    Projectile_MissirayFallingShotInitMotion-*
                dc.w    Projectile_MissirayFallingShotApplyGravity-*
                dc.w    Projectile_MissirayFallingShotDescend-*
                dc.w    Projectile_MissirayFallingShotDecelerate-*
                dc.w    Projectile_RisingShotWait-*
                dc.w    Projectile_RisingShotRiseAndEmit-*
                dc.w    Projectile_Stage24RisingShotInitArc-*
                dc.w    Projectile_Stage24RisingShotUpdateArc-*
                dc.w    Stage24_UpdateBackground-*
                dc.w    Stage24_UpdateForeground-*

; Selects the falling-shot or rising-wave state path
Projectile_MissirayAndRisingShotSelectVariant:          ; DATA XREF: ROM:Projectile_MissirayAndRisingShotStates   o  ; was: sub_33A66
                tst.b   $47(a5)
                bne.s   Projectile_MissirayAndRisingShotSelectRisingWave
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
Projectile_MissirayAndRisingShotSelectRisingWave:       ; CODE XREF: Projectile_MissirayAndRisingShotSelectVariant+4   j  ; was: loc_33A72
                move.w  #$A,4(a5)
                rts
; End of function Projectile_MissirayAndRisingShotSelectVariant
; Initializes falling state with velocity and collision parameters
Projectile_MissirayFallingShotInitMotion:               ; DATA XREF: ROM:00033A52   o  ; was: sub_33A7A
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.w  #$FFFC,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Projectile_MissirayFallingShotInitMotion
; Applies gravity until the falling shot reaches its transition velocity
Projectile_MissirayFallingShotApplyGravity:             ; DATA XREF: ROM:00033A54   o  ; was: sub_33A92
                addi.l  #$1800,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   Projectile_MissirayFallingShotGravityReturn
                cmpi.w  #2,$1C(a5)
                bcs.s   Projectile_MissirayFallingShotGravityReturn
                clr.l   $1C(a5)
                move.l  #off_EB492,8(a5)
                clr.w   $C(a5)
                ori.w   #$2000,2(a5)
                move.l  #$E020FE02,$2C(a5)
                move.l  #$E020F808,$28(a5)
                move.w  #$18,$48(a5)
                addq.w  #2,4(a5)
                bsr.w   Projectile_RisingShotEmitShot
Projectile_MissirayFallingShotGravityReturn:            ; CODE XREF: Projectile_MissirayFallingShotApplyGravity+E   j  ; was: locret_33ADE
                                        ; Projectile_MissirayFallingShotApplyGravity+16   j
                rts
; End of function Projectile_MissirayFallingShotApplyGravity
; Emits a type-$88 child every fourth frame
Projectile_RisingShotEmitOnInterval:                    ; CODE XREF: Projectile_MissirayFallingShotDescend   p  ; was: sub_33AE0
                                        ; Projectile_MissirayFallingShotDecelerate   p
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                beq.s   Projectile_RisingShotEmitShot
                rts
; End of function Projectile_RisingShotEmitOnInterval
; Unreferenced alternate emitter that strengthens the spawned shot's collision box
Orphaned_RisingShotEmitHomingShot:                      ; was: sub_33AEC
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                bne.s   Orphaned_RisingShotEmitHomingReturn
                bsr.s   Projectile_RisingShotEmitShot
                cmpi.w  #$88,(a0)
                bne.s   Orphaned_RisingShotEmitHomingReturn
                move.l  #$FE02F40C,$2C(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$32,$26(a0)                    ; '2'
Orphaned_RisingShotEmitHomingReturn:                    ; CODE XREF: Orphaned_RisingShotEmitHomingShot+8   j  ; was: locret_33B12
                                        ; Orphaned_RisingShotEmitHomingShot+10   j
                rts
; End of function Orphaned_RisingShotEmitHomingShot
; Spawns a type-$88 child at the current object's position
Projectile_RisingShotEmitShot:                          ; CODE XREF: Projectile_MissirayFallingShotApplyGravity+48   p  ; was: sub_33B14
                                        ; Projectile_RisingShotEmitOnInterval+8   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_RisingShotEmitReturn
                jsr     (Projectile_InitType88).l
                andi.w  #$FEFF,2(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.l  #off_E95DC,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $29(a5),d0
                andi.w  #$FF,d0
                add.w   d0,$14(a0)
Projectile_RisingShotEmitReturn:                        ; CODE XREF: Projectile_RisingShotEmitShot+6   j  ; was: locret_33B52
                rts
; End of function Projectile_RisingShotEmitShot
; Descends while emitting shots, then switches mapping and state
Projectile_MissirayFallingShotDescend:                  ; DATA XREF: ROM:00033A56   o  ; was: sub_33B54
                bsr.w   Projectile_RisingShotEmitOnInterval
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$80,$C(a5)
                bcs.s   Projectile_MissirayFallingShotDescendReturn
                move.l  #word_EB3FC,8(a5)
                clr.w   $C(a5)
                andi.w  #$DFFF,2(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
Projectile_MissirayFallingShotDescendReturn:            ; CODE XREF: Projectile_MissirayFallingShotDescend+12   j  ; was: locret_33B84
                rts
; End of function Projectile_MissirayFallingShotDescend
; Decelerates, then restores the saved vertical velocity
Projectile_MissirayFallingShotDecelerate:               ; DATA XREF: ROM:00033A58   o  ; was: sub_33B86
                bsr.w   Projectile_RisingShotEmitOnInterval
                addi.l  #-$800,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   Projectile_MissirayFallingShotDecelerateReturn
                move.l  $58(a5),$1C(a5)
                addq.w  #4,4(a5)
Projectile_MissirayFallingShotDecelerateReturn:         ; CODE XREF: Projectile_MissirayFallingShotDecelerate+10   j  ; was: locret_33BA2
                rts
; End of function Projectile_MissirayFallingShotDecelerate
; Waits for a rising-wave member's launch delay
Projectile_RisingShotWait:                              ; DATA XREF: ROM:00033A5A   o  ; was: sub_33BA4
                subq.w  #1,$48(a5)
                bmi.s   Projectile_RisingShotLaunch
                rts
; ---------------------------------------------------------------------------
Projectile_RisingShotLaunch:                            ; CODE XREF: Projectile_RisingShotWait+4   j  ; was: loc_33BAC
                clr.w   $48(a5)
                move.b  #$C0,$21(a5)
                move.b  #8,$23(a5)
                move.l  $58(a5),$1C(a5)
                addq.w  #2,4(a5)
                move.b  #$57,d0                         ; 'W'
                jsr     (Sound_PlaySFX).l
; End of function Projectile_RisingShotWait
; Moves a rising-wave member upward while emitting shots
Projectile_RisingShotRiseAndEmit:                       ; DATA XREF: ROM:00033A5C   o  ; was: sub_33BD0
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                bsr.w   Projectile_RisingShotEmitOnInterval
                cmpi.w  #$80,$14(a5)
                bgt.s   Projectile_RisingShotRiseReturn
                move.w  #$1000,2(a5)
Projectile_RisingShotRiseReturn:                        ; CODE XREF: Projectile_RisingShotRiseAndEmit+12   j  ; was: locret_33BEA
                rts
; End of function Projectile_RisingShotRiseAndEmit
; Initializes the Stage 24 arc selected by the global direction bit
Projectile_Stage24RisingShotInitArc:                    ; DATA XREF: ROM:00033A5E   o  ; was: sub_33BEC
                clr.l   $1C(a5)
                btst    #3,(word_FFA40E).w
                bne.s   Projectile_Stage24RisingShotMoveRight
                move.w  #$FFFE,$18(a5)
                bra.s   Projectile_Stage24RisingShotFinishArcInit
; ---------------------------------------------------------------------------
Projectile_Stage24RisingShotMoveRight:                  ; CODE XREF: Projectile_Stage24RisingShotInitArc+A   j  ; was: loc_33C00
                move.w  #2,$18(a5)
Projectile_Stage24RisingShotFinishArcInit:              ; CODE XREF: Projectile_Stage24RisingShotInitArc+12   j  ; was: loc_33C06
                addq.w  #2,4(a5)
                move.w  #$18,$48(a5)
                move.l  #$FFFE8000,$1C(a5)
                move.l  #$2000,$5C(a5)
                rts
; End of function Projectile_Stage24RisingShotInitArc
; Advances the Stage 24 arc and converts it to a type-$160 effect on expiry
Projectile_Stage24RisingShotUpdateArc:                  ; DATA XREF: ROM:00033A60   o  ; was: sub_33C22
                eori.w  #$8000,2(a5)
                bsr.w   Projectile_RisingShotEmitOnInterval
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   Projectile_Stage24RisingShotArcReturn
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
Projectile_Stage24RisingShotArcReturn:                  ; CODE XREF: Projectile_Stage24RisingShotUpdateArc+16   j  ; was: locret_33C48
                rts
; End of function Projectile_Stage24RisingShotUpdateArc
