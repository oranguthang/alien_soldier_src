; Main Antroid boss handler dispatching to state routines
Boss_AntroidMainHandler:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_374C6
                tst.w   4(a5)
                beq.w   Boss_AntroidStateDispatch
                tst.w   8(a5)
                beq.s   Boss_AntroidStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   loc_374EC
                btst    #1,(byte_FF80EC).w
                bne.s   loc_374EC
                tst.w   (word_FF8200).w
                beq.w   Boss_AntroidChargeAttack
loc_374EC:                                              ; CODE XREF: Boss_AntroidMainHandler+14   j
                                        ; Boss_AntroidMainHandler+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
; State dispatcher for Antroid boss using jump table
Boss_AntroidStateDispatch:                              ; CODE XREF: Boss_AntroidMainHandler+4   j  ; was: loc_374FE
                                        ; Boss_AntroidMainHandler+C   j
                move.w  4(a5),d0
                movea.w off_3750E(pc,d0.w),a0
                adda.l  #Boss_AntroidInitState,a0
                jmp     (a0)
; End of function Boss_AntroidMainHandler
; ---------------------------------------------------------------------------
off_3750E:      dc.w    Boss_AntroidInitState-Boss_AntroidInitState
                                        ; DATA XREF: Boss_AntroidMainHandler+3C   r
                dc.w    Boss_AntroidInitPhase-Boss_AntroidInitState
                dc.w    Boss_AntroidIdleUpdate-Boss_AntroidInitState
                dc.w    Boss_AntroidBattleDecision-Boss_AntroidInitState
                dc.w    Boss_AntroidAttackState1-Boss_AntroidInitState
                dc.w    Boss_AntroidFlyingAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidAttackState2-Boss_AntroidInitState
                dc.w    Boss_AntroidDivingAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpAttackState-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpApplyGravity-Boss_AntroidInitState
                dc.w    Boss_AntroidJump_FallCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidWaitState-Boss_AntroidInitState
                dc.w    Boss_AntroidWait_CountdownCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidInit_PhaseTimer-Boss_AntroidInitState
                dc.w    Boss_AntroidInit_CheckReady-Boss_AntroidInitState
                dc.w    Boss_AntroidRamAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidDeathFadeState-Boss_AntroidInitState
                dc.w    Boss_AntroidDeathTimer-Boss_AntroidInitState
                dc.w    Boss_AntroidIdleState-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlamAttack-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlamAttack_ApplyGravity-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_DecelerateX-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_AccelerateDown-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_TimerCheck-Boss_AntroidInitState
                dc.w    Boss_AntroidJumpSlam_WaitComplete-Boss_AntroidInitState
                dc.w    Boss_AntroidEarthquakeAttack-Boss_AntroidInitState

; Initializes boss state clearing objects
Boss_AntroidInitState:                                  ; DATA XREF: Boss_AntroidMainHandler+40   o  ; was: sub_37542
                                        ; ROM:off_3750E   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$30,d0                         ; '0'
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                rts
; End of function Boss_AntroidInitState
; Initializes Antroid boss phase with metasprite setup
Boss_AntroidInitPhase:                                  ; DATA XREF: ROM:00037510   o  ; was: sub_37558
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$E,d7
                movea.l #Boss_AntroidPrimaryMetaspriteDescriptors,a0
                movea.l #Boss_AntroidPrimaryPartRadii,a1
                movea.l #Boss_AntroidPrimaryPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                moveq   #$A,d7
                movea.l #Boss_AntroidSecondaryMetaspriteDescriptors,a0
                movea.l #Boss_AntroidSecondaryPartRadii,a1
                movea.l #Boss_AntroidSecondaryPartLinks,a2
                jsr     (Sprite_InitAdditionalMetaspriteGroup).l
                move.w  #$30,(a5)                       ; '0'
                move.w  #$8D00,2(a5)
                move.w  #$C100,$962(a5)
                move.w  #$C100,$542(a5)
                move.w  #$2C8,$550(a5)
                clr.w   6(a5)
                movea.l #Boss_AntroidObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #2,$1DE(a5)
                move.w  #$100,$54(a5)
                bsr.w   Boss_AntroidInitPhysics
                bra.w   Boss_AntroidSetIdleAnim
; ---------------------------------------------------------------------------
loc_375D8:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+62   j
                move.w  #$1A,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
; Phase initialization timer with state increment
Boss_AntroidInit_PhaseTimer:                            ; DATA XREF: ROM:00037528   o  ; was: loc_375E4
                subq.w  #1,$11C(a5)
                bmi.s   loc_375FA
                addq.w  #2,4(a5)
                moveq   #1,d0
                jsr     (UI_CheckVictoryCondition).l
                bra.w   loc_3773E
; ---------------------------------------------------------------------------
loc_375FA:                                              ; CODE XREF: Boss_AntroidInitPhase+90   j
                addq.w  #2,4(a5)
; Checks ready flag for battle transition
Boss_AntroidInit_CheckReady:                            ; DATA XREF: ROM:0003752A   o  ; was: loc_375FE
                tst.w   (word_FF80C2).w
                bne.s   loc_37622
                clr.b   (byte_FF80EC).w
                subi.w  #$40,(word_FFA970).w            ; '@'
                clr.w   $1DE(a5)
                move.w  #6,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
                bra.w   Boss_AntroidBattleDecision
; ---------------------------------------------------------------------------
loc_37622:                                              ; CODE XREF: Boss_AntroidInitPhase+AA   j
                bra.w   loc_3773E
; End of function Boss_AntroidInitPhase
; Initializes Antroid boss position and physics parameters at start of battle
Boss_AntroidInitPosition:
                move.w  #$24,4(a5)                      ; '$'  ; was: sub_37626
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$120,$10(a5)
                move.w  #$F0,$14(a5)
                clr.w   $54(a5)
                bsr.w   Boss_AntroidInitPhysics
; End of function Boss_AntroidInitPosition
; Updates Antroid boss idle animation and sprite rendering
Boss_AntroidIdleState:                                  ; DATA XREF: ROM:00037532   o  ; was: sub_37648
                lea     word_38322(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; End of function Boss_AntroidIdleState
; Transitions to idle state saving animation and loading table
Boss_AntroidTransitionToIdle:                           ; CODE XREF: Boss_AntroidJumpAttackState+CA   j  ; was: sub_37656
                move.w  $58(a5),(dword_FF8040).w
                move.w  $C(a5),(dword_FF8040+2).w
                moveq   #4,d0
                bsr.w   Boss_AntroidLoadAnimTable
                move.w  (dword_FF8040).w,$58(a5)
                move.w  (dword_FF8040+2).w,$C(a5)
                bra.s   loc_3767C
; ---------------------------------------------------------------------------
loc_37676:                                              ; CODE XREF: Boss_AntroidEarthquakeAttack+4   j
                                        ; Boss_AntroidFlyingAttack+54   j
                moveq   #4,d0
                bsr.w   Boss_AntroidLoadAnimTable
loc_3767C:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+1E   j
                clr.w   $23C(a5)
; Idle state update with animation interpolation and sprite render
Boss_AntroidIdleUpdate:                                 ; CODE XREF: Boss_AntroidWaitState+5E   j  ; was: loc_37680
                                        ; DATA XREF: ROM:00037512   o
                tst.w   $58(a5)
                bmi.s   loc_376A2
                lea     word_3832C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $11E(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_376A2:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+2E   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                move.w  a5,$48(a5)
                tst.w   $1DE(a5)
                bne.w   loc_375D8
                addq.w  #2,4(a5)
                move.w  #$1E0,d0
                sub.w   (word_FF8234).w,d0
                asr.w   #5,d0
                addq.w  #2,d0
                move.w  d0,$11C(a5)
; Battle decision logic choosing attack based on distance and random
Boss_AntroidBattleDecision:                             ; CODE XREF: Boss_AntroidInitPhase+C6   j  ; was: loc_376D0
                                        ; DATA XREF: ROM:00037514   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_3773E
                tst.w   $23E(a5)
                beq.s   loc_3773E
                tst.w   (word_FF8234).w
                beq.w   loc_3776E
                move.w  (dword_FFFF08).w,d7
                move.w  d7,d0
                andi.w  #$C800,d0
                beq.w   Boss_AntroidInitIdleState
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$A8,d0
                bpl.s   loc_3771E
                cmpi.w  #$3600,(word_FF8200).w
                bmi.w   Boss_AntroidStartAttackAnim
                btst    #0,d7
                bne.w   Boss_AntroidStartAttackAnim
                move.w  d7,d0
                andi.w  #$14,d0
                beq.w   Boss_AntroidInitJumpAttack
                bra.w   Boss_AntroidInitIdleState
; ---------------------------------------------------------------------------
loc_3771E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+A6   j
                cmpi.w  #$F8,d0
                bpl.s   loc_3772E
                move.w  d7,d0
                andi.w  #$70,d0                         ; 'p'
                beq.w   Boss_AntroidInitJumpAttack
loc_3772E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+CC   j
                move.w  d7,d0
                andi.w  #7,d0
                addq.w  #1,d0
                move.w  d0,$11C(a5)
                bra.w   Boss_AntroidStartAttack2Setup
; ---------------------------------------------------------------------------
loc_3773E:                                              ; CODE XREF: Boss_AntroidInitPhase+9E   j
                                        ; sub_37558:loc_37622   j
                lea     word_38332(pc),a1
                nop
                move.w  (word_FFA000).w,d0
                andi.w  #$FF,d0
                cmpi.w  #$E0,d0
                bmi.s   loc_37758
                lea     word_38344(pc),a1
                nop
loc_37758:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+FA   j
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $11E(a5),a0
                move.w  #$14E,$14(a0)
                bra.w   Boss_AntroidUpdateFlipDirection
; ---------------------------------------------------------------------------
loc_3776E:                                              ; CODE XREF: Boss_AntroidTransitionToIdle+8A   j
                move.w  #$32,4(a5)                      ; '2'
                move.w  #$B4,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
; End of function Boss_AntroidTransitionToIdle
; Executes Antroid boss earthquake attack with screen shake and ground slam animation
Boss_AntroidEarthquakeAttack:                           ; DATA XREF: ROM:00037540   o  ; was: sub_37788
                subq.w  #1,$11C(a5)
                bmi.w   loc_37676
                addi.w  #3,(word_FF8234).w
                lea     word_38356(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                move.l  #word_EB77A,$548(a5)
                move.w  #$14E,$554(a5)
                move.l  #word_EB77A,$968(a5)
                move.w  #$14E,$974(a5)
                bra.w   Boss_AntroidUpdateMetaspriteTable
; End of function Boss_AntroidEarthquakeAttack
; Sets boss to idle animation with parameter 8
Boss_AntroidSetIdleAnim:                                ; CODE XREF: Boss_AntroidInitPhase+7C   j  ; was: sub_377C4
                                        ; Boss_AntroidDivingAttack+3C   j
                moveq   #8,d0
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidSetIdleAnim
; Attack state checking phase and initializing attack
Boss_AntroidAttackState1:                               ; DATA XREF: ROM:00037516   o  ; was: sub_377CA
                cmpi.w  #2,$29C(a5)
                bne.s   loc_377D4
                bra.s   Boss_AntroidStartAttack1
; ---------------------------------------------------------------------------
loc_377D4:                                              ; CODE XREF: Boss_AntroidAttackState1+6   j
                lea     word_38360(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $48(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
; Starts attack state 1 with animation index setup
Boss_AntroidStartAttack1:                               ; CODE XREF: Boss_AntroidAttackState1+8   j  ; was: loc_377F0
                moveq   #$A,d0
                bsr.w   Boss_AntroidStartAnimation
; End of function Boss_AntroidAttackState1
; Flying attack state with gravity and proximity checks
Boss_AntroidFlyingAttack:                               ; DATA XREF: ROM:00037518   o  ; was: sub_377F6
                addi.l  #$5000,$1C(a5)
                bmi.s   loc_3787E
                movea.w #(byte_FFCB60-M68K_RAM),a1
                movea.w #(word_FFCF80-M68K_RAM),a0
                tst.w   6(a5)
                beq.s   loc_37810
                exg     a0,a1
loc_37810:                                              ; CODE XREF: Boss_AntroidFlyingAttack+16   j
                cmpi.w  #$14E,$14(a0)
                bmi.s   loc_3787E
                bsr.w   Boss_AntroidPlayAttackSFX
                bmi.s   loc_37846
                tst.w   $1DE(a5)
                beq.s   loc_37830
                cmpi.w  #$D60,$BC(a5)
                bmi.s   loc_37846
                bra.w   Boss_AntroidStartAttack2Setup
; ---------------------------------------------------------------------------
loc_37830:                                              ; CODE XREF: Boss_AntroidFlyingAttack+2C   j
                cmpi.w  #$C70,$BC(a5)
                bmi.s   loc_37846
                cmpi.w  #$D10,$BC(a5)
                bpl.s   loc_37846
                subq.w  #1,$11C(a5)
                bpl.s   loc_3784E
loc_37846:                                              ; CODE XREF: Boss_AntroidFlyingAttack+26   j
                                        ; Boss_AntroidFlyingAttack+34   j
                bsr.w   Boss_AntroidEndAttack
                bra.w   loc_37676
; ---------------------------------------------------------------------------
loc_3784E:                                              ; CODE XREF: Boss_AntroidFlyingAttack+4E   j
                move.w  #2,$23C(a5)
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$70,d0                         ; 'p'
                bpl.s   Boss_AntroidStartAttack2Setup
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1E,d0
                beq.s   Boss_AntroidStartAttack2Setup
                bsr.w   Boss_AntroidEndAttack
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                beq.w   Boss_AntroidStartAttackAnim
                bra.w   Boss_AntroidInitJumpAttack
; ---------------------------------------------------------------------------
loc_3787E:                                              ; CODE XREF: Boss_AntroidFlyingAttack+8   j
                                        ; Boss_AntroidFlyingAttack+20   j
                lea     word_38360(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; ---------------------------------------------------------------------------
; Sets up attack state 2 with animation index
Boss_AntroidStartAttack2Setup:                          ; CODE XREF: Boss_AntroidTransitionToIdle+E4   j  ; was: loc_3788C
                                        ; Boss_AntroidFlyingAttack+36   j
                moveq   #$C,d0
                bsr.w   Boss_AntroidSetAnimIndex
; End of function Boss_AntroidFlyingAttack
; Second attack state variant with different animation
Boss_AntroidAttackState2:                               ; DATA XREF: ROM:0003751A   o  ; was: sub_37892
                cmpi.w  #2,$29C(a5)
                bne.s   loc_3789C
                bra.s   Boss_AntroidStartAttack3
; ---------------------------------------------------------------------------
loc_3789C:                                              ; CODE XREF: Boss_AntroidAttackState2+6   j
                lea     word_3836E(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidUpdateSprite
                movea.w $48(a5),a0
                move.l  #word_EB77A,8(a0)
                rts
; ---------------------------------------------------------------------------
; Starts attack state 3 with animation setup
Boss_AntroidStartAttack3:                               ; CODE XREF: Boss_AntroidAttackState2+8   j  ; was: loc_378B8
                moveq   #$E,d0
                bsr.w   Boss_AntroidStartAnimation
; End of function Boss_AntroidAttackState2
; Diving attack state with vertical movement
Boss_AntroidDivingAttack:                               ; DATA XREF: ROM:0003751C   o  ; was: sub_378BE
                addi.l  #$5000,$1C(a5)
                bmi.w   loc_3794C
                movea.w #(byte_FFCB60-M68K_RAM),a0
                movea.w #(word_FFCF80-M68K_RAM),a1
                tst.w   6(a5)
                beq.s   loc_378DA
                exg     a0,a1
loc_378DA:                                              ; CODE XREF: Boss_AntroidDivingAttack+18   j
                cmpi.w  #$14E,$14(a0)
                bmi.s   loc_3794C
                bsr.w   Boss_AntroidPlayAttackSFX
                bmi.w   loc_37676
                tst.w   $1DE(a5)
                beq.s   loc_378FE
                cmpi.w  #$D60,$BC(a5)
                bmi.w   loc_37676
                bra.w   Boss_AntroidSetIdleAnim
; ---------------------------------------------------------------------------
loc_378FE:                                              ; CODE XREF: Boss_AntroidDivingAttack+30   j
                cmpi.w  #$C70,$BC(a5)
                bmi.w   loc_37676
                cmpi.w  #$D10,$BC(a5)
                bpl.w   loc_37676
                subq.w  #1,$11C(a5)
                bpl.s   loc_3791C
                bra.w   loc_37676
; ---------------------------------------------------------------------------
loc_3791C:                                              ; CODE XREF: Boss_AntroidDivingAttack+58   j
                move.w  #2,$23C(a5)
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$70,d0                         ; 'p'
                bpl.w   Boss_AntroidSetIdleAnim
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7800,d0
                beq.w   Boss_AntroidSetIdleAnim
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                beq.w   Boss_AntroidStartAttackAnim
                bra.w   Boss_AntroidInitJumpAttack
; ---------------------------------------------------------------------------
loc_3794C:                                              ; CODE XREF: Boss_AntroidDivingAttack+8   j
                                        ; Boss_AntroidDivingAttack+22   j
                lea     word_3836E(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidUpdateSprite
; End of function Boss_AntroidDivingAttack
; Starts boss animation sequence with parameter
Boss_AntroidStartAnimation:                             ; CODE XREF: Boss_AntroidAttackState1+28   p  ; was: sub_3795A
                                        ; Boss_AntroidAttackState2+28   p
                move.w  d0,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFFE4000,$1C(a5)
                move.l  #$40000,$18(a5)
                tst.w   $54(a5)
                beq.s   locret_37980
                neg.l   $18(a5)
locret_37980:                                           ; CODE XREF: Boss_AntroidStartAnimation+20   j
                rts
; End of function Boss_AntroidStartAnimation
; Plays attack sound and applies screen shake
Boss_AntroidPlayAttackSFX:                              ; CODE XREF: Boss_AntroidFlyingAttack+22   p  ; was: sub_37982
                                        ; Boss_AntroidDivingAttack+24   p
                move.b  #$AF,d0
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FFA010).w
                tst.w   $1DE(a5)
                bne.s   locret_3799E
                subi.w  #$A,(word_FF8234).w
locret_3799E:                                           ; CODE XREF: Boss_AntroidPlayAttackSFX+14   j
                rts
; End of function Boss_AntroidPlayAttackSFX
; Initializes jump attack updating flip and loading animation
Boss_AntroidInitJumpAttack:                             ; CODE XREF: Boss_AntroidTransitionToIdle+C0   j  ; was: sub_379A0
                                        ; Boss_AntroidTransitionToIdle+D4   j
                bsr.w   Boss_AntroidUpdateFlipDirection
                moveq   #$10,d0
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidInitJumpAttack
; Jump attack state with gravity physics and landing check
Boss_AntroidJumpAttackState:                            ; DATA XREF: ROM:0003751E   o  ; was: sub_379AA
                cmpi.w  #3,$29C(a5)
                beq.s   loc_379C4
                lea     word_3837C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bra.w   Boss_AntroidUpdateMetaspriteTable
; ---------------------------------------------------------------------------
loc_379C4:                                              ; CODE XREF: Boss_AntroidJumpAttackState+6   j
                subi.w  #$3C,(word_FF8234).w            ; '<'
                addq.w  #2,4(a5)
                move.w  #2,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF30000,$1C(a5)
                move.l  #$38000,$18(a5)
                tst.w   $23C(a5)
                bne.s   loc_379FA
                move.l  #$28000,$18(a5)
loc_379FA:                                              ; CODE XREF: Boss_AntroidJumpAttackState+46   j
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpApplyGravity
                neg.l   $18(a5)
; Applies gravity during jump and checks floor collision
Boss_AntroidJumpApplyGravity:                           ; CODE XREF: Boss_AntroidJumpAttackState+54   j  ; was: loc_37A04
                                        ; DATA XREF: ROM:00037520   o
                addi.l  #$C000,$1C(a5)
                bmi.s   loc_37A22
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$142,d0
                bmi.s   loc_37A22
                sub.w   d0,$14(a5)
                bra.s   loc_37A30
; ---------------------------------------------------------------------------
loc_37A22:                                              ; CODE XREF: Boss_AntroidJumpAttackState+62   j
                                        ; Boss_AntroidJumpAttackState+70   j
                lea     word_3837C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37A30:                                              ; CODE XREF: Boss_AntroidJumpAttackState+76   j
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                addq.w  #2,4(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
; Jump attack fall state with gravity application
Boss_AntroidJump_FallCheck:                             ; DATA XREF: ROM:00037522   o  ; was: loc_37A60
                addi.l  #$6000,$1C(a5)
                bmi.s   loc_37A78
                movea.w $17E(a5),a0
                cmpi.w  #$14E,$14(a0)
                bpl.w   Boss_AntroidTransitionToIdle
loc_37A78:                                              ; CODE XREF: Boss_AntroidJumpAttackState+BE   j
                lea     word_3832C(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bra.w   Boss_AntroidUpdateMetaspriteTable
; End of function Boss_AntroidJumpAttackState
; Updates boss flip direction and loads attack animation table
Boss_AntroidStartAttackAnim:                            ; CODE XREF: Boss_AntroidTransitionToIdle+AE   j  ; was: sub_37A8A
                                        ; Boss_AntroidTransitionToIdle+B6   j
                bsr.w   Boss_AntroidUpdateFlipDirection
                moveq   #$26,d0                         ; '&'
                bsr.w   Boss_AntroidLoadAnimTable
; End of function Boss_AntroidStartAttackAnim
; Complex jump slam attack with trajectory tracking, ground detection, and damage triggers
Boss_AntroidJumpSlamAttack:                             ; DATA XREF: ROM:00037534   o  ; was: sub_37A94
                cmpi.w  #3,$29C(a5)
                beq.s   loc_37AAA
                lea     word_383A0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37AAA:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+6   j
                                        ; Boss_AntroidJumpSlamAttack+1FE   j
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$28,4(a5)                      ; '('
                move.w  #2,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF78000,$1C(a5)
                move.l  #$FFFE1000,$18(a5)
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpSlamAttack_ApplyGravity
                neg.l   $18(a5)
; Applies gravity during jump slam descent phase
Boss_AntroidJumpSlamAttack_ApplyGravity:                ; CODE XREF: Boss_AntroidJumpSlamAttack+48   j  ; was: loc_37AE2
                                        ; DATA XREF: ROM:00037536   o
                subi.w  #$10,$56(a5)
                addi.l  #$8000,$1C(a5)
                bmi.s   loc_37B00
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$14A,d0
                bpl.s   loc_37B0E
loc_37B00:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+5C   j
                lea     word_383A0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37B0E:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+6A   j
                subi.w  #$58,(word_FF8234).w            ; 'X'
                bmi.s   loc_37B52
                tst.w   $54(a5)
                beq.s   loc_37B26
                cmpi.w  #$D38,$BC(a5)
                bpl.s   loc_37B52
                bra.s   loc_37B2E
; ---------------------------------------------------------------------------
loc_37B26:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+86   j
                cmpi.w  #$C48,$BC(a5)
                bmi.s   loc_37B52
loc_37B2E:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+90   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$380,d0
                beq.s   loc_37B52
                jsr     (Physics_GetPlayerDelta).l
                cmpi.w  #$88,d0
                bmi.w   loc_37C74
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$2A00,d0
                beq.w   loc_37C74
loc_37B52:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+80   j
                                        ; Boss_AntroidJumpSlamAttack+8E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #2,(word_FFA010).w
                clr.w   $56(a5)
                move.w  a5,$48(a5)
                movea.w $17E(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                clr.l   $1C(a5)
; Jump slam pre-impact horizontal deceleration
Boss_AntroidJumpSlam_DecelerateX:                       ; DATA XREF: ROM:00037538   o  ; was: loc_37B80
                tst.w   $58(a5)
                bmi.s   loc_37BA6
                move.l  #$1800,d0
                tst.l   $18(a5)
                bpl.s   loc_37B94
                neg.l   d0
loc_37B94:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+FC   j
                sub.l   d0,$18(a5)
                lea     word_383B6(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37BA6:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+F0   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                move.l  #word_EB720,$C8(a5)
                move.w  #5,(word_FFA010).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  #$FFF80000,$1C(a5)
                move.l  #$78000,$18(a5)
                tst.w   $54(a5)
                beq.s   Boss_AntroidJumpSlam_AccelerateDown
                neg.l   $18(a5)
; Accelerates boss downward during jump slam attack
Boss_AntroidJumpSlam_AccelerateDown:                    ; CODE XREF: Boss_AntroidJumpSlamAttack+154   j  ; was: loc_37BEE
                                        ; DATA XREF: ROM:0003753A   o
                addi.l  #$8000,$1C(a5)
                bmi.s   loc_37C06
                movea.w $17E(a5),a0
                move.w  $14(a0),d0
                subi.w  #$14C,d0
                bpl.s   loc_37C14
loc_37C06:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+162   j
                lea     word_383C0(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37C14:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+170   j
                move.b  #$A1,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #word_EB732,$C8(a5)
                clr.w   $56(a5)
                move.w  #$A,$17C(a5)
                move.w  a5,$48(a5)
                movea.w $17E(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                clr.l   $1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
; Jump slam timer check with animation interpolation
Boss_AntroidJumpSlam_TimerCheck:                        ; DATA XREF: ROM:0003753C   o  ; was: loc_37C5E
                subq.w  #1,$17C(a5)
                bmi.w   loc_37676
                lea     word_383CE(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37C74:                                              ; CODE XREF: Boss_AntroidJumpSlamAttack+AE   j
                                        ; Boss_AntroidJumpSlamAttack+BA   j
                moveq   #$30,d0                         ; '0'
                bsr.w   Boss_AntroidLoadAnimTable
                move.w  #3,(word_FFA010).w
                move.l  #word_EB720,$C8(a5)
                clr.w   $56(a5)
; Waits for animation frame 3 completion before next action
Boss_AntroidJumpSlam_WaitComplete:                      ; DATA XREF: ROM:0003753E   o  ; was: loc_37C8C
                cmpi.w  #3,$29C(a5)
                beq.w   loc_37AAA
                lea     word_38394(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; End of function Boss_AntroidJumpSlamAttack
; Sets idle animation index for Antroid boss
Boss_AntroidInitIdleState:                              ; CODE XREF: Boss_AntroidTransitionToIdle+98   j  ; was: sub_37CA4
                                        ; Boss_AntroidTransitionToIdle+C4   j
                moveq   #$16,d0
                bsr.w   Boss_AntroidSetAnimIndex
; End of function Boss_AntroidInitIdleState
; Wait state with timer countdown and projectile spawning
Boss_AntroidWaitState:                                  ; DATA XREF: ROM:00037524   o  ; was: sub_37CAA
                tst.w   $58(a5)
                bmi.s   loc_37CBE
                lea     word_383D4(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bra.w   Boss_AntroidSetupMetasprite
; ---------------------------------------------------------------------------
loc_37CBE:                                              ; CODE XREF: Boss_AntroidWaitState+4   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
; Wait state countdown with projectile spawning
Boss_AntroidWait_CountdownCheck:                        ; DATA XREF: ROM:00037526   o  ; was: loc_37CD6
                move.w  #1,(word_FFA010).w
                subq.w  #1,$11C(a5)
                bpl.s   loc_37D0C
                tst.w   $23E(a5)
                beq.s   loc_37D0C
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
                move.w  $4A(a5),$48(a5)
                clr.w   $29C(a5)
                bra.w   Boss_AntroidIdleUpdate
; ---------------------------------------------------------------------------
loc_37D0C:                                              ; CODE XREF: Boss_AntroidWaitState+36   j
                                        ; Boss_AntroidWaitState+3C   j
                btst    #1,(word_FFA000+1).w
                beq.s   loc_37D18
                subq.w  #1,(word_FF8234).w
loc_37D18:                                              ; CODE XREF: Boss_AntroidWaitState+68   j
                bsr.w   Boss_AntroidSpawnProjectile
                lea     word_383E2(pc),a1
                nop
                bsr.w   Anim_InterpolateToTarget
                bsr.w   Boss_AntroidSetupMetasprite
                bsr.w   Boss_AntroidUpdateMetaspriteTable
                movea.w $11E(a5),a0
                move.w  #$14E,$14(a0)
                rts
; End of function Boss_AntroidWaitState
; Boss charge attack with distance check
Boss_AntroidChargeAttack:                               ; CODE XREF: Boss_AntroidMainHandler+22   j  ; was: sub_37D3A
                move.w  #$1E,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #1,$11C(a5)
                clr.w   $56(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$FFFE0000,$1C(a5)
                move.l  #$20000,$18(a5)
                move.w  #$100,$54(a5)
                cmpi.w  #$CC0,$BC(a5)
                bmi.w   loc_37D96
                neg.l   $18(a5)
                clr.w   $54(a5)
loc_37D96:                                              ; CODE XREF: Boss_AntroidChargeAttack+50   j
                bsr.w   Boss_AntroidUpdateFlipDirection
; End of function Boss_AntroidChargeAttack
; Boss ram attack with collision
Boss_AntroidRamAttack:                                  ; DATA XREF: ROM:0003752C   o  ; was: sub_37D9A
                cmpi.w  #$180,$56(a5)
                beq.s   loc_37DAC
                subq.w  #8,$56(a5)
                andi.w  #$1FE,$56(a5)
loc_37DAC:                                              ; CODE XREF: Boss_AntroidRamAttack+6   j
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_AntroidUpdateMetaspriteFlipped
                addi.l  #$4000,$1C(a5)
                bmi.s   locret_37DF4
                cmpi.w  #$148,$14(a5)
                bmi.w   locret_37DF4
                move.w  #5,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                subq.w  #1,$11C(a5)
                bpl.w   loc_37DF6
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$148,$14(a5)
locret_37DF4:                                           ; CODE XREF: Boss_AntroidRamAttack+24   j
                                        ; Boss_AntroidRamAttack+2C   j
                rts
; ---------------------------------------------------------------------------
loc_37DF6:                                              ; CODE XREF: Boss_AntroidRamAttack+40   j
                move.l  #$FFFE0000,$1C(a5)
                rts
; End of function Boss_AntroidRamAttack
; Boss death state with palette fade and timer progression
Boss_AntroidDeathFadeState:                             ; DATA XREF: ROM:0003752E   o  ; was: sub_37E00
                jsr     (Gfx_UpdatePaletteFade).l
                addq.w  #1,$11C(a5)
                move.w  $11C(a5),d0
                cmpi.w  #$A0,d0
                bpl.s   Boss_AntroidEnterDefeatedState
                subi.w  #$90,d0
                bmi.s   loc_37E1E
                bsr.w   Gfx_SetFadeParamsThunk
loc_37E1E:                                              ; CODE XREF: Boss_AntroidDeathFadeState+18   j
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
; End of function Boss_AntroidDeathFadeState
; Updates boss metasprite with horizontal flip toggle
Boss_AntroidUpdateMetaspriteFlipped:                    ; CODE XREF: Boss_AntroidRamAttack+18   p  ; was: sub_37E2A
                bsr.w   Boss_AntroidSpawnDebris
                lea     word_383EE(pc),a1
                nop
                jsr     Anim_InterpolateToTarget(pc)    ; (pc)
                nop
                bsr.w   Boss_AntroidSetupMetasprite
                move.l  #word_EB720,$C8(a5)
                bset    #4,$CE(a5)
                eori.w  #$800,$CE(a5)
                rts
; End of function Boss_AntroidUpdateMetaspriteFlipped
; Transitions boss to defeated state clearing objects
Boss_AntroidEnterDefeatedState:                         ; CODE XREF: Boss_AntroidDeathFadeState+12   j  ; was: sub_37E54
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$14,6(a5)
                moveq   #$30,d0                         ; '0'
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
; End of function Boss_AntroidEnterDefeatedState
; Death sequence timer with fade effect
Boss_AntroidDeathTimer:                                 ; DATA XREF: ROM:00037530   o  ; was: sub_37E6C
                subq.w  #1,6(a5)
                move.w  6(a5),d0
                bpl.s   loc_37E7E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_37E7E:                                              ; CODE XREF: Boss_AntroidDeathTimer+8   j
                cmpi.w  #$10,d0
                bmi.w   Gfx_SetFadeParamsThunk
                moveq   #$10,d0
                bra.w   Gfx_SetFadeParamsThunk
; End of function Boss_AntroidDeathTimer
; Updates boss sprite graphics and animation
