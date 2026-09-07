Boss_AnimateDeathSequence:                              ; CODE XREF: Boss_UpdateHealthBar+60   j  ; was: sub_16F36
                                        ; Sound_PlayBossHitSound+62   j
                bclr    #3,$E(a5)
                btst    #2,$69(a5)
                bne.s   loc_16F4A
                bset    #3,$E(a5)
loc_16F4A:                                              ; CODE XREF: Boss_AnimateDeathSequence+C   j
                subq.w  #1,$C(a5)
                bmi.s   loc_16F52
                rts
; ---------------------------------------------------------------------------
loc_16F52:                                              ; CODE XREF: Boss_AnimateDeathSequence+18   j
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                move.w  $48(a5),d1
                cmpi.w  #$10,d1
                beq.s   loc_16F72
                cmpi.w  #0,d1
                bne.s   Boss_SetupDeathSequence
loc_16F72:                                              ; CODE XREF: Boss_AnimateDeathSequence+34   j
                move.b  #$D6,d0
                jsr     (Sound_PlaySFX).l
; Sets up boss death sequence animation with sound effect and defeat handler
Boss_SetupDeathSequence:                                ; CODE XREF: Boss_AnimateDeathSequence+3A   j  ; was: loc_16F7C
                movea.l off_16F8C(pc,d1.w),a1
                movea.l off_16FAC(pc,d1.w),a2
                moveq   #0,d5
                moveq   #0,d6
                bra.w   Stage_HandleBossDefeat
; End of function Boss_AnimateDeathSequence
; ---------------------------------------------------------------------------
off_16F8C:      dc.l    word_E86FA                      ; DATA XREF: Boss_AnimateDeathSequence:loc_16F7C   r
                dc.l    word_E871A
                dc.l    word_E873A
                dc.l    word_E8762
                dc.l    word_E8782
                dc.l    word_E87A2
                dc.l    word_E87C2
                dc.l    word_E86E2
off_16FAC:      dc.l    word_E8812                      ; DATA XREF: Boss_AnimateDeathSequence+4A   r
                                        ; sub_1717A:loc_171AA   o
                dc.l    word_E8842
                dc.l    word_E886A
                dc.l    word_E889A
                dc.l    word_E88C2
                dc.l    word_E88EA
                dc.l    word_E891A
                dc.l    word_E87EA

; Renders player weapon sprite with animation update
Player_RenderWeaponSprite:                              ; CODE XREF: Player_AirControlState+40   p  ; was: sub_16FCC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198F2).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderWeaponSprite
; Prepares player weapon sprite for rendering with animation data
Player_PrepareWeaponSprite:                             ; CODE XREF: Player_AirAttackState+34   p  ; was: sub_16FDC
                bsr.s   Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198B2).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_PrepareWeaponSprite
; Updates player weapon animation cycle with sound effects on key frames
Player_UpdateWeaponAnim:                                ; CODE XREF: Player_RenderWeaponSprite   p  ; was: sub_16FEC
                                        ; sub_16FDC   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s   Player_SetWeaponAnimationData
                move.w  #4,$C(a5)
                addq.w  #4,$48(a5)
                cmpi.w  #$18,$48(a5)
                bmi.s   loc_1700C
                clr.w   $48(a5)
loc_1700C:                                              ; CODE XREF: Player_UpdateWeaponAnim+1A   j
                cmpi.w  #0,d1
                beq.s   loc_17018
                cmpi.w  #$C,d1
                bne.s   Player_SetWeaponAnimationData
loc_17018:                                              ; CODE XREF: Player_UpdateWeaponAnim+24   j
                move.b  #$D6,d0
                jsr     (Sound_PlaySFX).l
; Sets weapon animation frame data and sprite parameters
Player_SetWeaponAnimationData:                          ; CODE XREF: Player_UpdateWeaponAnim+8   j  ; was: loc_17022
                                        ; Player_UpdateWeaponAnim+2A   j
                movea.l off_1703A(pc,d1.w),a2
                asr.w   #1,d1
                move.w  word_1702E(pc,d1.w),d6
                rts
; End of function Player_UpdateWeaponAnim
; ---------------------------------------------------------------------------
word_1702E:     dc.w    $FFFF, $FFFF, 0, $FFFF, $FFFF, 0
                                        ; DATA XREF: Player_UpdateWeaponAnim+3C   r
off_1703A:      dc.l    word_E8CC2                      ; DATA XREF: Player_UpdateWeaponAnim:loc_17022   r
                dc.l    word_E8CDA
                dc.l    word_E8CEA
                dc.l    word_E8D12
                dc.l    word_E8D2A
                dc.l    word_E8992

; Updates player dash sprite
Player_UpdateDashSprite:                                ; CODE XREF: Player_HandleDashState+66   j  ; was: sub_17052
                tst.w   (word_FFA22A).w
                beq.s   loc_17072
                lea     (word_198F2).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     off_172F8(pc),a0
                nop
                movea.l #word_E8942,a2
                bra.w   loc_1727A
; ---------------------------------------------------------------------------
loc_17072:                                              ; CODE XREF: Player_UpdateDashSprite+4   j
                lea     (word_19912).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w   Sprite_PrepareRendering
; End of function Player_UpdateDashSprite
; Renders player special weapon sprite with conditional positioning
Player_RenderSpecialWeapon:                             ; CODE XREF: Player_HandleJump+64   j  ; was: sub_17086
                tst.w   (word_FFA22A).w
                beq.s   loc_170A6
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #0,d6
                lea     off_172F8(pc),a0
                nop
                movea.l #word_E8942,a2
                bra.w   loc_1727A
; ---------------------------------------------------------------------------
loc_170A6:                                              ; CODE XREF: Player_RenderSpecialWeapon+4   j
                lea     (word_198D2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderSpecialWeapon
; Renders player sprite with weapon state and metasprite selection
Player_RenderWithWeapon:                                ; CODE XREF: Player_ProcessAirState+74   j  ; was: sub_170BA
                                        ; Player_ProcessJumpState+76   j
                tst.w   $48(a5)
                bpl.w   loc_17132
                tst.w   (word_FFA22A).w
                beq.s   loc_170E2
                lea     (word_19902).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     off_172F8(pc),a0
                nop
                movea.l #word_E8F0A,a2
                bra.w   loc_1727A
; ---------------------------------------------------------------------------
loc_170E2:                                              ; CODE XREF: Player_RenderWithWeapon+C   j
                lea     (word_19922).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w   Sprite_PrepareRendering
; ---------------------------------------------------------------------------
loc_170F6:                                              ; CODE XREF: Player_HandleAirState+62   j
                                        ; Player_HandleLandingState+7A   j
                tst.w   $48(a5)
                bpl.w   Player_RenderFallingSprite
                tst.w   (word_FFA22A).w
                beq.s   loc_1711E
                lea     (word_198C2).l,a4
                moveq   #0,d5
                moveq   #$11,d6
                lea     off_172F8(pc),a0
                nop
                movea.l #word_E8F0A,a2
                bra.w   loc_1727A
; ---------------------------------------------------------------------------
loc_1711E:                                              ; CODE XREF: Player_RenderWithWeapon+48   j
                lea     (word_198E2).l,a4
                moveq   #0,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w   Sprite_PrepareRendering
; ---------------------------------------------------------------------------
loc_17132:                                              ; CODE XREF: Player_HandleCrouchState+5E   j
                                        ; Player_RenderWithWeapon+4   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_19912).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderWithWeapon
; Prepares player falling/airborne sprite for rendering
Player_RenderFallingSprite:                             ; CODE XREF: Player_HandleAirMovement+5C   j  ; was: sub_17146
                                        ; Player_RenderWithWeapon+40   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_198D2).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderFallingSprite
; Renders player dash animation sprite with cycling animation
Player_RenderDashSprite:                                ; CODE XREF: Sound_PlayBossHitSound+78   j  ; was: sub_1715A
                                        ; Sound_PlayBossHitSound+86   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_19912).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderDashSprite
; Renders player dash sprite with offset and table
Player_RenderDashEffect:                                ; CODE XREF: Boss_UpdateHealthBar+76   j  ; was: sub_1716A
                                        ; Boss_UpdateHealthBar+84   j
                bsr.s   Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_198D2).l,a4
                bra.w   Sprite_PrepareRendering
; End of function Player_RenderDashEffect
; Cycles dash animation frames with sound effects
Player_CycleDashAnimation:                              ; CODE XREF: Player_RenderDashSprite   p  ; was: sub_1717A
                                        ; sub_1716A   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s   Player_SetDashAnimationData
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                cmpi.w  #$10,d1
                beq.s   loc_171A0
                cmpi.w  #0,d1
                bne.s   Player_SetDashAnimationData
loc_171A0:                                              ; CODE XREF: Player_CycleDashAnimation+1E   j
                move.b  #$D6,d0
                jsr     (Sound_PlaySFX).l
; Sets dash animation frame data and sprite tile parameters
Player_SetDashAnimationData:                            ; CODE XREF: Player_CycleDashAnimation+8   j  ; was: loc_171AA
                                        ; Player_CycleDashAnimation+24   j
                lea     off_16FAC(pc),a2
                movea.l (a2,d1.w),a2
                asr.w   #1,d1
                move.w  word_171BA(pc,d1.w),d6
                rts
; End of function Player_CycleDashAnimation
; ---------------------------------------------------------------------------
word_171BA:     dc.w    $FFFE, $FFFF, 0, $FFFF, $FFFE, $FFFF, 0, $FFFF
                                        ; DATA XREF: Player_CycleDashAnimation+3A   r

; Updates player animation state and frame data
Player_UpdateAnimationState:                            ; CODE XREF: Player_HandleFallingState+C6   j  ; was: sub_171CA
                                        ; Boss_ArtemisSpawnProjectile2+2   j
                bsr.s   Anim_SelectFrameData
                tst.w   $52(a5)
                beq.w   Player_AutoFlipDirection
                rts
; End of function Player_UpdateAnimationState
; Selects animation frame data from table
Anim_SelectFrameData:                                   ; CODE XREF: Player_HandleBounceState+4A   j  ; was: sub_171D6
                                        ; Player_HandleCutsceneControl+50   j
                move.w  $52(a5),d0
                add.w   d1,d0
                move.w  d0,$52(a5)
                andi.w  #$1C,d0
                move.l  off_171EC(pc,d0.w),8(a5)
                rts
; End of function Anim_SelectFrameData
; ---------------------------------------------------------------------------
off_171EC:      dc.l    word_E8A1A                      ; DATA XREF: Anim_SelectFrameData+E   r
                dc.l    word_E8A4A
                dc.l    word_E8A82
                dc.l    word_E8ABA
                dc.l    word_E8AE2
                dc.l    word_E8B12
                dc.l    word_E8B4A
                dc.l    word_E8B82

; Renders multiple death particle sprites during player death sequence
Player_RenderDeathParticles:                            ; CODE XREF: Player_HandleDeathSequence:loc_15182   j  ; was: sub_1720C
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  $48(a5),d0
                move.w  $10(a5),d1
                addi.w  #-$10,d1
; Loop that creates individual death particle sprites with positioning
Player_DeathParticleLoop:                               ; CODE XREF: Player_RenderDeathParticles+18   j  ; was: loc_1721E
                bsr.w   Sprite_CreateDeathParticle
                subq.w  #1,d0
                bpl.s   Player_DeathParticleLoop
                move.w  #$FFFF,(a1)+
                jsr     (Sprite_AddToOAMBuffer).l
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  off_17242(pc,d0.w),8(a5)
                rts
; End of function Player_RenderDeathParticles
; ---------------------------------------------------------------------------
off_17242:      dc.l    word_E8F9A                      ; DATA XREF: Player_RenderDeathParticles+2E   r
                dc.l    word_E8FC2
                dc.l    word_E8FEA
                dc.l    word_E9012
                dc.l    word_E903A
                dc.l    word_E904A
                dc.l    word_E905A
                dc.l    word_E906A

; Creates single death particle sprite with tile and position data
Sprite_CreateDeathParticle:                             ; CODE XREF: Player_RenderDeathParticles:loc_1721E   p  ; was: sub_17262
                move.w  #$138,(a1)+
                move.w  #0,(a1)+
                move.w  #$CFDB,(a1)+
                move.w  d1,(a1)+
                addq.w  #8,d1
                rts
; End of function Sprite_CreateDeathParticle
; Prepares player sprite for rendering with palette
Sprite_PrepareRendering:                                ; CODE XREF: Player_HandleFallingState+158   j  ; was: sub_17274
                                        ; Player_RenderWeaponSprite+C   j
                lea     off_172BC(pc),a0
                nop
loc_1727A:                                              ; CODE XREF: Player_HandleSpecialAttack+D2   j
                                        ; Player_CheckSpecialAttack+40   j
                lea     word_176E2(pc),a1
                nop
                btst    #4,$E(a5)
                beq.s   Sprite_GetPlayerAnimation
                lea     word_176F2(pc),a1
                nop
; Gets player sprite animation data based on facing direction and animation state
Sprite_GetPlayerAnimation:                              ; CODE XREF: Sprite_PrepareRendering+12   j  ; was: loc_1728E
                moveq   #0,d1
                move.b  $9E(a5),d1
                asl.w   #1,d1
                move.w  (a1,d1.w),d0
                movea.l (a0,d0.w),a1
                asl.w   #1,d0
                move.w  (word_FFA000).w,d1
                andi.w  #6,d1
                add.w   d1,d0
                add.b   $14(a0,d0.w),d6
                add.b   $15(a0,d0.w),d5
                bsr.w   Stage_HandleBossDefeat
                jmp     Sprite_RenderPlayer
; End of function Sprite_PrepareRendering
; ---------------------------------------------------------------------------
off_172BC:      dc.l    word_E8D92                      ; DATA XREF: Sprite_PrepareRendering   o
                dc.l    word_E8DC2
                dc.l    word_E8DAA
                dc.l    word_E8D72
                dc.l    word_E8D52
                dc.w    $FDFF, $FDFE, $FDFD, $FDFE, $FEFF, $FD00, $FC01, $FD00
                dc.w    $FEFE, $FDFF, $FC01, $FDFF, $FAFD, $FBFE, $FC00, $FBFE
                dc.w    $FAFE, $FBFF, $FC00, $FBFF
off_172F8:      dc.l    word_E8E12                      ; DATA XREF: Player_HandleSpecialAttack+CC   o
                                        ; Player_CheckSpecialAttack+3A   o
                dc.l    word_E8E4A
                dc.l    word_E8E32
                dc.l    word_E8DF2
                dc.l    word_E8DDA
                dc.w    $FC02, $FC01, $FD00, $FC01, $FFFE, $FDFE, $FCFF, $FDFE
                dc.w    $FEFF, $FD00, $FC01, $FD00, $FBFF, $FC00, $FD01, $FC00
                dc.w    $FB00, $FC00, $FD01, $FC00

; Animates player defeat sprite cycling through death animation frames
Player_AnimateDefeatSprite:                             ; CODE XREF: Physics_ApplyBossVelocity+2E   j  ; was: sub_17334
                                        ; Player_DefeatGroundedState+26   j
                subq.w  #1,$C(a5)
                bpl.s   Player_UpdateDefeatAnimation
                move.w  #2,$C(a5)
                addq.w  #4,$48(a5)
; Updates player defeat animation frame with timer-based progression
Player_UpdateDefeatAnimation:                           ; CODE XREF: Player_AnimateDefeatSprite+4   j  ; was: loc_17344
                move.w  $48(a5),d0
                movea.l off_1735E(pc,d0.w),a1
                movea.l off_1736E(pc,d0.w),a2
                asr.w   #1,d0
                move.b  byte_1737E(pc,d0.w),d5
                move.b  byte_1737E+1(pc,d0.w),d6
                bra.w   Stage_HandleBossDefeat
; End of function Player_AnimateDefeatSprite
; ---------------------------------------------------------------------------
off_1735E:      dc.l    word_E8BC2                      ; DATA XREF: Player_AnimateDefeatSprite+14   r
                dc.l    word_E8BE2
                dc.l    word_E8BFA
                dc.l    word_E8C0A
off_1736E:      dc.l    word_E8942                      ; DATA XREF: Player_AnimateDefeatSprite+18   r
                dc.l    word_E89C2
                dc.l    word_E89C2
                dc.l    word_E89C2
byte_1737E:     dc.b    0, 0, 0, 5, 0, 5, 4, 5
                                        ; DATA XREF: Player_AnimateDefeatSprite+1E   r
                                        ; Player_AnimateDefeatSprite+22   r

; Checks if boss is defeated (health depleted)
Boss_CheckDefeatCondition:                              ; CODE XREF: Boss_FlashOnHit:loc_153D0   j  ; was: sub_17386
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$1CC,(a0)
                move.w  #$E900,2(a0)
                move.b  #$50,$21(a0)                    ; 'P'
                move.w  #8,$48(a0)
                move.l  #off_E9800,8(a0)
                move.w  $E(a5),d7
                andi.w  #$8000,d7
                addi.w  #$480,d7
                move.w  d7,$E(a0)
                move.w  #2,$26(a0)
                btst    #3,$E(a5)
                beq.s   loc_173DC
                neg.w   d0
                neg.l   d2
loc_173DC:                                              ; CODE XREF: Boss_CheckDefeatCondition+50   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$18(a0)
                move.b  #$43,d0                         ; 'C'
                jmp     (Sound_PlaySFX).l
; End of function Boss_CheckDefeatCondition
; Spawns player projectile with velocity and properties
