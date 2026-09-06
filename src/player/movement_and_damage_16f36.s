Boss_AnimateDeathSequence:                              ; CODE XREF: Boss_UpdateHealthBar+60   j  ; was: sub_16F36
                                        ; Sound_PlayBossHitSound+62   j
                bclr    #3,$E(a5)
                btst    #2,$69(a5)
                bne.s   loc_16F4A
                bset    #3,$E(a5)
loc_16F4A:                              ; CODE XREF: Boss_AnimateDeathSequence+C   j
                subq.w  #1,$C(a5)
                bmi.s   loc_16F52
                rts
; ---------------------------------------------------------------------------
loc_16F52:                              ; CODE XREF: Boss_AnimateDeathSequence+18   j
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                move.w  $48(a5),d1
                cmpi.w  #$10,d1
                beq.s   loc_16F72
                cmpi.w  #0,d1
                bne.s Boss_SetupDeathSequence
loc_16F72:                              ; CODE XREF: Boss_AnimateDeathSequence+34   j
                move.b  #$D6,d0
                jsr (Sound_PlaySFX).l
; Sets up boss death sequence animation with sound effect and defeat handler
Boss_SetupDeathSequence:                              ; CODE XREF: Boss_AnimateDeathSequence+3A   j  ; was: loc_16F7C
                movea.l off_16F8C(pc,d1.w),a1
                movea.l off_16FAC(pc,d1.w),a2
                moveq   #0,d5
                moveq   #0,d6
                bra.w Stage_HandleBossDefeat
; End of function Boss_AnimateDeathSequence
; ---------------------------------------------------------------------------
off_16F8C:      dc.l word_E86FA         ; DATA XREF: Boss_AnimateDeathSequence:loc_16F7C   r
                dc.l word_E871A
                dc.l word_E873A
                dc.l word_E8762
                dc.l word_E8782
                dc.l word_E87A2
                dc.l word_E87C2
                dc.l word_E86E2
off_16FAC:      dc.l word_E8812         ; DATA XREF: Boss_AnimateDeathSequence+4A   r
                                        ; sub_1717A:loc_171AA   o
                dc.l word_E8842
                dc.l word_E886A
                dc.l word_E889A
                dc.l word_E88C2
                dc.l word_E88EA
                dc.l word_E891A
                dc.l word_E87EA


; Renders player weapon sprite with animation update
Player_RenderWeaponSprite:                              ; CODE XREF: Player_AirControlState+40   p  ; was: sub_16FCC
                bsr.s Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198F2).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_RenderWeaponSprite
; Prepares player weapon sprite for rendering with animation data
Player_PrepareWeaponSprite:                              ; CODE XREF: Player_AirAttackState+34   p  ; was: sub_16FDC
                bsr.s Player_UpdateWeaponAnim
                moveq   #1,d5
                addq.w  #3,d6
                lea     (word_198B2).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_PrepareWeaponSprite
; Updates player weapon animation cycle with sound effects on key frames
Player_UpdateWeaponAnim:                              ; CODE XREF: Player_RenderWeaponSprite   p  ; was: sub_16FEC
                                        ; sub_16FDC   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s Player_SetWeaponAnimationData
                move.w  #4,$C(a5)
                addq.w  #4,$48(a5)
                cmpi.w  #$18,$48(a5)
                bmi.s   loc_1700C
                clr.w   $48(a5)
loc_1700C:                              ; CODE XREF: Player_UpdateWeaponAnim+1A   j
                cmpi.w  #0,d1
                beq.s   loc_17018
                cmpi.w  #$C,d1
                bne.s Player_SetWeaponAnimationData
loc_17018:                              ; CODE XREF: Player_UpdateWeaponAnim+24   j
                move.b  #$D6,d0
                jsr (Sound_PlaySFX).l
; Sets weapon animation frame data and sprite parameters
Player_SetWeaponAnimationData:                              ; CODE XREF: Player_UpdateWeaponAnim+8   j  ; was: loc_17022
                                        ; Player_UpdateWeaponAnim+2A   j
                movea.l off_1703A(pc,d1.w),a2
                asr.w   #1,d1
                move.w  word_1702E(pc,d1.w),d6
                rts
; End of function Player_UpdateWeaponAnim
; ---------------------------------------------------------------------------
word_1702E:     dc.w $FFFF, $FFFF, 0, $FFFF, $FFFF, 0
                                        ; DATA XREF: Player_UpdateWeaponAnim+3C   r
off_1703A:      dc.l word_E8CC2         ; DATA XREF: Player_UpdateWeaponAnim:loc_17022   r
                dc.l word_E8CDA
                dc.l word_E8CEA
                dc.l word_E8D12
                dc.l word_E8D2A
                dc.l word_E8992


; Updates player dash sprite
Player_UpdateDashSprite:                              ; CODE XREF: Player_HandleDashState+66   j  ; was: sub_17052
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
loc_17072:                              ; CODE XREF: Player_UpdateDashSprite+4   j
                lea     (word_19912).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w Sprite_PrepareRendering
; End of function Player_UpdateDashSprite
; Renders player special weapon sprite with conditional positioning
Player_RenderSpecialWeapon:                              ; CODE XREF: Player_HandleJump+64   j  ; was: sub_17086
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
loc_170A6:                              ; CODE XREF: Player_RenderSpecialWeapon+4   j
                lea     (word_198D2).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #4,d6
                movea.l #word_E8992,a2
                bra.w Sprite_PrepareRendering
; End of function Player_RenderSpecialWeapon
; Renders player sprite with weapon state and metasprite selection
Player_RenderWithWeapon:                              ; CODE XREF: Player_ProcessAirState+74   j  ; was: sub_170BA
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
loc_170E2:                              ; CODE XREF: Player_RenderWithWeapon+C   j
                lea     (word_19922).l,a4
                moveq   #$FFFFFFFF,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w Sprite_PrepareRendering
; ---------------------------------------------------------------------------
loc_170F6:                              ; CODE XREF: Player_HandleAirState+62   j
                                        ; Player_HandleLandingState+7A   j
                tst.w   $48(a5)
                bpl.w Player_RenderFallingSprite
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
loc_1711E:                              ; CODE XREF: Player_RenderWithWeapon+48   j
                lea     (word_198E2).l,a4
                moveq   #0,d5
                moveq   #$13,d6
                movea.l #word_E89F2,a2
                bra.w Sprite_PrepareRendering
; ---------------------------------------------------------------------------
loc_17132:                              ; CODE XREF: Player_HandleCrouchState+5E   j
                                        ; Player_RenderWithWeapon+4   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_19912).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_RenderWithWeapon
; Prepares player falling/airborne sprite for rendering
Player_RenderFallingSprite:                              ; CODE XREF: Player_HandleAirMovement+5C   j  ; was: sub_17146
                                        ; Player_RenderWithWeapon+40   j
                movea.l #word_E89C2,a2
                moveq   #0,d5
                moveq   #$C,d6
                lea     (word_198D2).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_RenderFallingSprite
; Renders player dash animation sprite with cycling animation
Player_RenderDashSprite:                              ; CODE XREF: Sound_PlayBossHitSound+78   j  ; was: sub_1715A
                                        ; Sound_PlayBossHitSound+86   j
                bsr.s Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_19912).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_RenderDashSprite
; Renders player dash sprite with offset and table
Player_RenderDashEffect:                              ; CODE XREF: Boss_UpdateHealthBar+76   j  ; was: sub_1716A
                                        ; Boss_UpdateHealthBar+84   j
                bsr.s Player_CycleDashAnimation
                moveq   #$FFFFFFFF,d5
                addq.w  #3,d6
                lea     (word_198D2).l,a4
                bra.w Sprite_PrepareRendering
; End of function Player_RenderDashEffect
; Cycles dash animation frames with sound effects
Player_CycleDashAnimation:                              ; CODE XREF: Player_RenderDashSprite   p  ; was: sub_1717A
                                        ; sub_1716A   p
                move.w  $48(a5),d1
                subq.w  #1,$C(a5)
                bpl.s Player_SetDashAnimationData
                move.w  #3,$C(a5)
                addq.w  #4,$48(a5)
                andi.w  #$1C,$48(a5)
                cmpi.w  #$10,d1
                beq.s   loc_171A0
                cmpi.w  #0,d1
                bne.s Player_SetDashAnimationData
loc_171A0:                              ; CODE XREF: Player_CycleDashAnimation+1E   j
                move.b  #$D6,d0
                jsr (Sound_PlaySFX).l
; Sets dash animation frame data and sprite tile parameters
Player_SetDashAnimationData:                              ; CODE XREF: Player_CycleDashAnimation+8   j  ; was: loc_171AA
                                        ; Player_CycleDashAnimation+24   j
                lea     off_16FAC(pc),a2
                movea.l (a2,d1.w),a2
                asr.w   #1,d1
                move.w  word_171BA(pc,d1.w),d6
                rts
; End of function Player_CycleDashAnimation
; ---------------------------------------------------------------------------
word_171BA:     dc.w $FFFE, $FFFF, 0, $FFFF, $FFFE, $FFFF, 0, $FFFF
                                        ; DATA XREF: Player_CycleDashAnimation+3A   r


; Updates player animation state and frame data
Player_UpdateAnimationState:                              ; CODE XREF: Player_HandleFallingState+C6   j  ; was: sub_171CA
                                        ; Boss_ArtemisSpawnProjectile2+2   j ...
                bsr.s Anim_SelectFrameData
                tst.w   $52(a5)
                beq.w Player_AutoFlipDirection
                rts
; End of function Player_UpdateAnimationState
; Selects animation frame data from table
Anim_SelectFrameData:                              ; CODE XREF: Player_HandleBounceState+4A   j  ; was: sub_171D6
                                        ; Player_HandleCutsceneControl+50   j ...
                move.w  $52(a5),d0
                add.w   d1,d0
                move.w  d0,$52(a5)
                andi.w  #$1C,d0
                move.l  off_171EC(pc,d0.w),8(a5)
                rts
; End of function Anim_SelectFrameData
; ---------------------------------------------------------------------------
off_171EC:      dc.l word_E8A1A         ; DATA XREF: Anim_SelectFrameData+E   r
                dc.l word_E8A4A
                dc.l word_E8A82
                dc.l word_E8ABA
                dc.l word_E8AE2
                dc.l word_E8B12
                dc.l word_E8B4A
                dc.l word_E8B82


; Renders multiple death particle sprites during player death sequence
Player_RenderDeathParticles:                              ; CODE XREF: Player_HandleDeathSequence:loc_15182   j  ; was: sub_1720C
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  $48(a5),d0
                move.w  $10(a5),d1
                addi.w  #-$10,d1
; Loop that creates individual death particle sprites with positioning
Player_DeathParticleLoop:                              ; CODE XREF: Player_RenderDeathParticles+18   j  ; was: loc_1721E
                bsr.w Sprite_CreateDeathParticle
                subq.w  #1,d0
                bpl.s Player_DeathParticleLoop
                move.w  #$FFFF,(a1)+
                jsr (Sprite_AddToOAMBuffer).l
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  off_17242(pc,d0.w),8(a5)
                rts
; End of function Player_RenderDeathParticles
; ---------------------------------------------------------------------------
off_17242:      dc.l word_E8F9A         ; DATA XREF: Player_RenderDeathParticles+2E   r
                dc.l word_E8FC2
                dc.l word_E8FEA
                dc.l word_E9012
                dc.l word_E903A
                dc.l word_E904A
                dc.l word_E905A
                dc.l word_E906A


; Creates single death particle sprite with tile and position data
Sprite_CreateDeathParticle:                              ; CODE XREF: Player_RenderDeathParticles:loc_1721E   p  ; was: sub_17262
                move.w  #$138,(a1)+
                move.w  #0,(a1)+
                move.w  #$CFDB,(a1)+
                move.w  d1,(a1)+
                addq.w  #8,d1
                rts
; End of function Sprite_CreateDeathParticle
; Prepares player sprite for rendering with palette
Sprite_PrepareRendering:                              ; CODE XREF: Player_HandleFallingState+158   j  ; was: sub_17274
                                        ; Player_RenderWeaponSprite+C   j ...
                lea     off_172BC(pc),a0
                nop
loc_1727A:                              ; CODE XREF: Player_HandleSpecialAttack+D2   j
                                        ; Player_CheckSpecialAttack+40   j ...
                lea     word_176E2(pc),a1
                nop
                btst    #4,$E(a5)
                beq.s Sprite_GetPlayerAnimation
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
                bsr.w Stage_HandleBossDefeat
                jmp Sprite_RenderPlayer
; End of function Sprite_PrepareRendering
; ---------------------------------------------------------------------------
off_172BC:      dc.l word_E8D92         ; DATA XREF: Sprite_PrepareRendering   o
                dc.l word_E8DC2
                dc.l word_E8DAA
                dc.l word_E8D72
                dc.l word_E8D52
                dc.w $FDFF, $FDFE, $FDFD, $FDFE, $FEFF, $FD00, $FC01, $FD00
                dc.w $FEFE, $FDFF, $FC01, $FDFF, $FAFD, $FBFE, $FC00, $FBFE
                dc.w $FAFE, $FBFF, $FC00, $FBFF
off_172F8:      dc.l word_E8E12         ; DATA XREF: Player_HandleSpecialAttack+CC   o
                                        ; Player_CheckSpecialAttack+3A   o ...
                dc.l word_E8E4A
                dc.l word_E8E32
                dc.l word_E8DF2
                dc.l word_E8DDA
                dc.w $FC02, $FC01, $FD00, $FC01, $FFFE, $FDFE, $FCFF, $FDFE
                dc.w $FEFF, $FD00, $FC01, $FD00, $FBFF, $FC00, $FD01, $FC00
                dc.w $FB00, $FC00, $FD01, $FC00


; Animates player defeat sprite cycling through death animation frames
Player_AnimateDefeatSprite:                              ; CODE XREF: Physics_ApplyBossVelocity+2E   j  ; was: sub_17334
                                        ; Player_DefeatGroundedState+26   j ...
                subq.w  #1,$C(a5)
                bpl.s Player_UpdateDefeatAnimation
                move.w  #2,$C(a5)
                addq.w  #4,$48(a5)
; Updates player defeat animation frame with timer-based progression
Player_UpdateDefeatAnimation:                              ; CODE XREF: Player_AnimateDefeatSprite+4   j  ; was: loc_17344
                move.w  $48(a5),d0
                movea.l off_1735E(pc,d0.w),a1
                movea.l off_1736E(pc,d0.w),a2
                asr.w   #1,d0
                move.b  byte_1737E(pc,d0.w),d5
                move.b  byte_1737E+1(pc,d0.w),d6
                bra.w Stage_HandleBossDefeat
; End of function Player_AnimateDefeatSprite
; ---------------------------------------------------------------------------
off_1735E:      dc.l word_E8BC2         ; DATA XREF: Player_AnimateDefeatSprite+14   r
                dc.l word_E8BE2
                dc.l word_E8BFA
                dc.l word_E8C0A
off_1736E:      dc.l word_E8942         ; DATA XREF: Player_AnimateDefeatSprite+18   r
                dc.l word_E89C2
                dc.l word_E89C2
                dc.l word_E89C2
byte_1737E:     dc.b 0, 0, 0, 5, 0, 5, 4, 5
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
                move.b  #$50,$21(a0) ; 'P'
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
loc_173DC:                              ; CODE XREF: Boss_CheckDefeatCondition+50   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$18(a0)
                move.b  #$43,d0 ; 'C'
                jmp (Sound_PlaySFX).l
; End of function Boss_CheckDefeatCondition
; Spawns player projectile with velocity and properties
Player_SpawnProjectile:                              ; CODE XREF: Player_PhoenixAttackUpdate+56   p  ; was: sub_173FA
                                        ; Player_InitiateDashAttack+80   p ...
                move.b  #$41,d0 ; 'A'
                jsr (Sound_PlaySFX).l
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #2,(byte_FF8143).w
                movea.w #(word_FFC5C0-M68K_RAM),a0
                move.w  #$230,(a0)
                move.b  #$54,$21(a0) ; 'T'
                move.w  #$4000,2(a0)
                move.l  #word_E8F22,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                eori.w  #$1000,$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_17476
                move.w  #$26,$26(a0) ; '&'
                subi.w  #$1E,(word_FFA216).w
                move.w  #$801E,(word_FF8262).w
                move.w  #$30,(word_FF8268).w ; '0'
                rts
; ---------------------------------------------------------------------------
loc_17476:                              ; CODE XREF: Player_SpawnProjectile+60   j
                move.w  #$23,$26(a0) ; '#'
                subi.w  #$32,(word_FFA216).w ; '2'
                move.w  #$8032,(word_FF8262).w
                move.w  #$30,(word_FF8268).w ; '0'
                rts
; End of function Player_SpawnProjectile
; Calculates weapon data table offset
Player_GetWeaponTableOffset:
                bne.s   loc_17498  ; was: sub_17490
                bset    #1,(byte_FF8244).w
loc_17498:                              ; CODE XREF: Player_GetWeaponTableOffset   j
                movea.l $48(a5),a0
                move.w  (word_FFA000).w,d0
                asr.w   #1,d0
                andi.w  #$C,d0
                rts
; End of function Player_GetWeaponTableOffset
; Handles stage progression after boss defeat
Stage_HandleBossDefeat:                              ; CODE XREF: Player_HandleAirMovement+70   j  ; was: sub_174A8
                                        ; Player_HandleFallingState+D6   j ...
                movea.w #(byte_FF8780-M68K_RAM),a3
                move.l  a3,8(a5)
                clr.l   $DC(a5)
                moveq   #$F,d4
                ext.w   d5
                asl.w   #8,d6
loc_174BA:                              ; CODE XREF: Stage_HandleBossDefeat+2C   j
                move.w  (a1)+,d0
                bclr    d4,d0
                bne.s   loc_174D6
                move.w  d0,(a3)+
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
                bra.s   loc_174BA
; ---------------------------------------------------------------------------
loc_174D6:                              ; CODE XREF: Stage_HandleBossDefeat+16   j
                move.w  d0,(a3)+
                andi.w  #$3FF,d0
                moveq   #0,d1
                move.b  (a1),d1
                move.w  d1,d2
                andi.w  #3,d2
                addq.w  #1,d2
                lsr.w   #2,d1
                addq.w  #1,d1
                muls.w  d2,d1
                add.w   d1,d0
                move.l  (a1)+,(a3)+
                move.w  (a1)+,d1
                move.w  d1,d2
                andi.w  #$FF00,d2
                add.w   d6,d2
                add.b   d5,d1
                move.b  d1,d2
                move.w  d2,(a3)+
loc_17502:                              ; CODE XREF: Stage_HandleBossDefeat+68   j
                move.w  (a2)+,d1
                move.w  d1,d2
                add.w   d0,d2
                move.w  d2,(a3)+
                move.l  (a2)+,(a3)+
                move.w  (a2)+,(a3)+
                btst    d4,d1
                beq.s   loc_17502
                rts
; End of function Stage_HandleBossDefeat
; Spawns particle effect with random velocity
Effect_SpawnParticle:                              ; CODE XREF: Player_HandleJump+14   p  ; was: sub_17514
                                        ; Player_HandleDashState+16   p ...
                btst    #4,$69(a5)
                bne.w   locret_175B6
                move.w  (dword_FFFF08+2).w,d0
                andi.w  #$E000,d0
                bne.w   locret_175B6
                bsr.w Sprite_AllocateSlot
                bne.w   locret_175B6
                lea     (dword_2AE58).l,a1
                jsr (Sprite_InitFromTable).l
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                asl.l   d0,d1
                move.w  (dword_FFFF08).w,d0
                asr.w   #1,d0
                andi.w  #3,d0
                asl.l   d0,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                movem.l a0,-(sp)
                jsr     (RandomNumber).l
                movem.l (sp)+,a0
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                moveq   #$10,d1
                btst    #4,$E(a5)
                beq.s   loc_175A4
                moveq   #$10,d1
loc_175A4:                              ; CODE XREF: Effect_SpawnParticle+8C   j
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                sub.w   d1,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_175B6:                           ; CODE XREF: Effect_SpawnParticle+6   j
                                        ; Effect_SpawnParticle+12   j ...
                rts
; End of function Effect_SpawnParticle
; Spawns Phoenix particle effects
Player_SpawnPhoenixParticles:
                subq.w  #1,$4A(a5)  ; was: sub_175B8
                bpl.w   locret_17640
                move.w  #$FFFF,$4A(a5)
                btst    #4,$69(a5)
                bne.w   locret_17640
                subq.w  #2,(word_FF8304).w
                bpl.s   loc_175DA
                clr.w   (word_FF8304).w
loc_175DA:                              ; CODE XREF: Player_SpawnPhoenixParticles+1C   j
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_175EE
                move.b  #$AC,d0
                jsr (Sound_PlaySFX).l
loc_175EE:                              ; CODE XREF: Player_SpawnPhoenixParticles+2A   j
                bsr.w Sprite_AllocateSlot
                bne.w   locret_17640
                lea     (dword_2AE58).l,a1
                jsr (Sprite_InitFromTable).l
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                asl.l   #3,d1
                asl.l   #3,d2
                move.w  $14(a5),$14(a0)
                sub.l   d1,$14(a0)
                move.w  $10(a5),$10(a0)
                sub.l   d2,$10(a0)
locret_17640:                           ; CODE XREF: Player_SpawnPhoenixParticles+4   j
                                        ; Player_SpawnPhoenixParticles+14   j ...
                rts
; End of function Player_SpawnPhoenixParticles
; Spawns three projectiles in spread pattern for special attack
Player_SpawnTripleShot:                              ; CODE XREF: Player_InitSpecialAttack+56   j  ; was: sub_17642
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                move.w  $10(a5),d4
                moveq   #3,d5
                moveq   #2,d7
                btst    #3,$E(a5)
                beq.s   loc_1765E
                move.w  #$C0,d6
                subq.w  #8,d4
                bra.s   loc_17664
; ---------------------------------------------------------------------------
loc_1765E:                              ; CODE XREF: Player_SpawnTripleShot+12   j
                addq.w  #8,d4
                move.w  #$1E0,d6
loc_17664:                              ; CODE XREF: Player_SpawnTripleShot+1A   j
                                        ; Player_SpawnTripleShot+30   j
                move.l  #off_E9560,8(a0)
                bsr.s Player_InitShotProjectile
                addi.w  #$40,d6 ; '@'
                dbf     d7,loc_17664
                rts
; End of function Player_SpawnTripleShot
; Spawns 5 projectiles in radial spread
Player_SpawnRadialShot:
                moveq   #4,d5  ; was: sub_17678
                move.w  #$FFC0,d6
                moveq   #4,d7
                btst    #3,$E(a5)
                beq.s   loc_1768C
                addi.w  #$80,d6
loc_1768C:                              ; CODE XREF: Player_SpawnRadialShot+E   j
                                        ; Player_SpawnRadialShot+22   j
                move.l  #off_E9560,8(a0)
                bsr.s Player_InitShotProjectile
                addi.w  #$40,d6 ; '@'
                dbf     d7,loc_1768C
                rts
; End of function Player_SpawnRadialShot
; Initializes shot projectile with angle and velocity
Player_InitShotProjectile:                              ; CODE XREF: Player_SpawnTripleShot+2A   p  ; was: sub_176A0
                                        ; Player_SpawnRadialShot+1C   p
                jsr (Projectile_InitType88).l
                move.b  $20(a5),$20(a0)
                lea     (word_1B514).l,a1
                andi.w  #$1FE,d6
                move.w  -$80(a1,d6.w),d1
                move.w  (a1,d6.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d5,d1
                asl.l   d5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.w  $14(a5),$14(a0)
                subq.w  #8,$14(a0)
                move.w  d4,$10(a0)
                lea     $60(a0),a0
                rts
; End of function Player_InitShotProjectile
; ---------------------------------------------------------------------------
word_176E2:     dc.w 0, 8, 4, 8, 0, $C, $10, $C
                                        ; DATA XREF: Sprite_PrepareRendering:loc_1727A   o
word_176F2:     dc.w 0, $C, $10, $C, 0, 8, 4, 8
                                        ; DATA XREF: Sprite_PrepareRendering+14   o


; Updates screen pulse/shake effect
Effect_UpdateScreenPulse:
                tst.w   (word_FF8262).w  ; was: sub_17702
                beq.w   locret_1771A
                tst.b   (byte_FF813E).w
                bmi.s   loc_17728
                subq.w  #1,(word_FF8268).w
                bpl.s   loc_1771C
                clr.w   (word_FF8262).w
locret_1771A:                           ; CODE XREF: Effect_UpdateScreenPulse+4   j
                rts
; ---------------------------------------------------------------------------
loc_1771C:                              ; CODE XREF: Effect_UpdateScreenPulse+12   j
                btst    #0,(word_FFA000+1).w
                bne.s   loc_17728
                subq.w  #1,(word_FF8266).w
loc_17728:                              ; CODE XREF: Effect_UpdateScreenPulse+C   j
                                        ; Effect_UpdateScreenPulse+20   j
                move.b  (word_FF8262).w,d0
                andi.w  #$10,d0
                addi.w  #-$3841,d0
                lea     (word_5A43E).l,a0
                move.w  (word_FF8262).w,d4
                andi.w  #$FFF,d4
                asl.w   #1,d4
                move.b  (a0,d4.w),d1
                andi.w  #$F,d1
                move.b  1(a0,d4.w),d2
                move.b  d2,d3
                asr.w   #4,d2
                andi.w  #$F,d2
                andi.w  #$F,d3
                addi.w  #-$383C,d1
                addi.w  #-$383C,d2
                addi.w  #-$383C,d3
                move.w  #0,d4
                move.w  (word_FF8264).w,d5
                move.w  (word_FF8266).w,d6
                cmpi.w  #$A0,d6
                bpl.s   loc_1777E
                move.w  #$A0,d6
loc_1777E:                              ; CODE XREF: Effect_UpdateScreenPulse+76   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d0,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d1,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d2,(a0)+
                move.w  d5,(a0)+
                addq.w  #8,d5
                move.w  d6,(a0)+
                move.w  d4,(a0)+
                move.w  d3,(a0)+
                move.w  d5,(a0)+
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Effect_UpdateScreenPulse
; Creates visual dash trail effect behind player
Effect_CreateDashTrail:                              ; CODE XREF: Player_HandleDashCancel+B8   j  ; was: sub_177B6
                                        ; Player_TeleportDash+C8   j ...
                tst.w   (word_FFC5C0).w
                beq.s   loc_177D8
                move.l  #word_E8EBA,8(a5)
                btst    #0,(word_FFA000+1).w
                bne.w   locret_17882
                move.l  #word_E8E6A,8(a5)
                rts
; ---------------------------------------------------------------------------
loc_177D8:                              ; CODE XREF: Effect_CreateDashTrail+4   j
                bsr.w Effect_FindDashTrailSlot
                bne.w   locret_17882
                move.w  #$250,(a0)
                clr.b   $21(a0)
                move.w  #$C880,2(a0)
                move.l  #word_E8680,8(a0)
                move.w  $E(a5),d0
                andi.w  #$FFFF,d0
                move.w  d0,$E(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #3,$48(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $48(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                add.l   d0,$10(a0)
                move.l  d0,$4C(a0)
                bsr.w Effect_FindDashTrailSlot
                bne.s   locret_17882
                lea     (dword_2ADFA).l,a1
                move.w  #$FFF4,$18(a0)
                tst.w   $48(a5)
                bpl.s Effect_SetDashTrailProperties
                lea     (dword_2AE14).l,a1
                neg.w   $18(a0)
; Sets sprite properties for dash trail effect including position and velocity
Effect_SetDashTrailProperties:                              ; CODE XREF: Effect_CreateDashTrail+90   j  ; was: loc_17852
                jsr (Sprite_InitFromTable).l
                move.w  #$8880,2(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
locret_17882:                           ; CODE XREF: Effect_CreateDashTrail+14   j
                                        ; Effect_CreateDashTrail+26   j ...
                rts
; End of function Effect_CreateDashTrail
; Updates dash trail position with acceleration
Effect_UpdateDashTrail:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_17884
                btst    #4,(byte_FF8244).w
                bne.s   loc_17894
loc_1788C:                              ; CODE XREF: Effect_UpdateDashTrail+14   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_17894:                              ; CODE XREF: Effect_UpdateDashTrail+6   j
                subq.w  #1,$48(a5)
                bmi.s   loc_1788C
                move.l  $18(a5),d0
                add.l   $4C(a5),d0
                move.l  d0,$18(a5)
                bset    #7,2(a5)
                btst    #0,$49(a5)
                beq.s   locret_178BA
                bclr    #7,2(a5)
locret_178BA:                           ; CODE XREF: Effect_UpdateDashTrail+2E   j
                rts
; End of function Effect_UpdateDashTrail
; Updates sprite facing flags
Effect_UpdateFacingFlags:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_178BC
                andi.w  #$E7FF,$E(a5)
                move.w  (word_FF8092).w,d0
                or.w    d0,$E(a5)
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_178D8
                move.w  #$1000,2(a5)
locret_178D8:                           ; CODE XREF: Effect_UpdateFacingFlags+14   j
                rts
; End of function Effect_UpdateFacingFlags
; ---------------------------------------------------------------------------
word_178DA:     dc.w 0, 1, 3, 3, $12, 5 ; DATA XREF: UI_UpdateWeaponDisplay+1E   o
off_178E6:      dc.l word_E9964         ; DATA XREF: UI_InitWeaponSelectScreen+8A   o
                                        ; sub_2BBC0:loc_2BC18   o
                dc.l word_E9976
                dc.l word_E9988
                dc.l word_E999A
                dc.l word_E99AC
                dc.l word_E99BE


; Updates weapon selection display counters
UI_UpdateWeaponDisplay:                              ; CODE XREF: Sys_GameplayMainLoop+B8   p  ; was: sub_178FE
                                        ; Sys_UpdateGameplayLoop+2A   p
                tst.b   (byte_FF813E).w
                bmi.w UI_UpdateWeaponDisplay_Return
                bsr.w UI_ProcessWeaponState
                move.w  (word_FFA24E).w,d0
                cmpi.w  #$12,(word_FFA21C).w
                bmi.s   loc_17918
                moveq   #8,d0
loc_17918:                              ; CODE XREF: UI_UpdateWeaponDisplay+16   j
                movea.w #(word_FFA250-M68K_RAM),a0
                lea     word_178DA(pc),a1
                moveq   #0,d1
                moveq   #3,d7
loc_17924:                              ; CODE XREF: UI_UpdateWeaponDisplay+4E   j
                cmp.w   d0,d1
                beq.s UI_UpdateWeaponIconLoop
                move.w  (a0),d2
                subq.w  #1,8(a0)
                bpl.s UI_UpdateWeaponIconLoop
                move.w  (a1,d2.w),8(a0)
                addq.w  #2,$10(a0)
                move.w  $18(a0),d2
                cmp.w   $10(a0),d2
                bpl.s UI_UpdateWeaponIconLoop
                move.w  d2,$10(a0)
; Updates weapon icon display positions with interpolation loop
UI_UpdateWeaponIconLoop:                              ; CODE XREF: UI_UpdateWeaponDisplay+28   j  ; was: loc_17948
                                        ; UI_UpdateWeaponDisplay+30   j ...
                addq.w  #2,a0
                addq.w  #2,d1
                dbf     d7,loc_17924
; Return after updating weapon display loop
UI_UpdateWeaponDisplay_Return:                           ; CODE XREF: UI_UpdateWeaponDisplay+4   j  ; was: locret_17950
                                        ; DATA XREF: ROM:off_17984   o ...
                rts
; End of function UI_UpdateWeaponDisplay
; Processes weapon display state dispatcher
UI_ProcessWeaponState:                              ; CODE XREF: UI_UpdateWeaponDisplay+8   p  ; was: sub_17952
                movea.w (word_FFA24E).w,a1
                adda.w  #$A250,a1
                lea     off_1938E(pc),a2
                nop
                tst.w   (word_FF8238).w
                bmi.s   loc_1796A
                subq.w  #1,(word_FF8238).w
loc_1796A:                              ; CODE XREF: UI_ProcessWeaponState+12   j
                tst.w   (word_FF8038).w
                bmi.s UI_DispatchWeaponHandler
                subq.w  #1,(word_FF8038).w
; Dispatches to weapon handler routine using jump table with UI_GetWeaponIconData as base
UI_DispatchWeaponHandler:                              ; CODE XREF: UI_ProcessWeaponState+1C   j  ; was: loc_17974
                move.w  (word_FFA21C).w,d0
                movea.w off_17984(pc,d0.w),a0
                adda.l  #UI_GetWeaponIconData,a0
                jmp     (a0)
; End of function UI_ProcessWeaponState
; ---------------------------------------------------------------------------
off_17984:      dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                                        ; DATA XREF: UI_ProcessWeaponState+26   r
                dc.w UI_CalculateHealthBarSegments-UI_GetWeaponIconData
                dc.w UI_InitHealthBarSprites-UI_GetWeaponIconData
                dc.w Enemy_CalculateVelocityFromPlayer-UI_GetWeaponIconData
                dc.w UI_ProcessTargetingSystem-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponGaugeSprite-UI_GetWeaponIconData
                dc.w Gfx_LoadWeaponIcon-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                dc.w UI_InitWeaponSelectScreen-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponSelect-UI_GetWeaponIconData


; Gets weapon icon data from table
UI_GetWeaponIconData:                              ; CODE XREF: Enemy_UpdateBossAI+76   p  ; was: sub_1799A
                                        ; Enemy_UpdateBossAI+B2   p
                                        ; DATA XREF: ...
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (word_FFA21C).w,d0
                move.w  word_179AC(pc,d0.w),d0
                rts
; End of function UI_GetWeaponIconData
; ---------------------------------------------------------------------------
word_179AC:     dc.w 0, 2, 4, 6, 8, $A, $C, $E, $10, 0, 0
                                        ; DATA XREF: UI_GetWeaponIconData+C   r


; Initializes weapon select UI with sprites and animation tables
UI_InitWeaponSelectScreen:                              ; DATA XREF: ROM:00017996   o  ; was: sub_179C2
                movea.w #(byte_FFA258-M68K_RAM),a0
                move.w  (word_FFA24E).w,d0
                move.w  #$258,(a0,d0.w)
                move.w  (word_FFA24E).w,d0
                move.w  d0,(word_FF803C).w
                addq.w  #2,(word_FFA21C).w
                bsr.w UI_ClearWeaponCounters
                move.w  #$14,(word_FFA21E).w
                lea     word_17AA4(pc),a0
                nop
                move.w  (word_FF803C).w,d1
                move.w  (a0,d1.w),d1
                addi.w  #$100,d1
                andi.w  #$1FF,d1
                move.w  d1,(word_FF8036).w
                move.w  #$A0,(word_FF8030).w
                move.w  d0,(word_FF8238).w
                bsr.w Memory_ClearBlock
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.l  #off_E968C,8(a0)
                move.w  #$E080,2(a0)
                move.w  #$80,$10(a0)
                move.w  #$80,$14(a0)
                move.w  #$C80,$E(a0)
                move.w  (word_FF808A).w,d6
                or.w    d6,$E(a0)
                movea.w #(byte_FFC320-M68K_RAM),a0
                movea.w #(word_FFA250-M68K_RAM),a1
                lea     word_17A9C(pc),a3
                nop
                lea     off_178E6(pc),a4
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FF808A).w,d3
                moveq   #0,d4
                moveq   #3,d7
; Initializes weapon selection screen slot data in loop
UI_InitWeaponSlotLoop:                              ; CODE XREF: UI_InitWeaponSelectScreen+CC   j  ; was: loc_17A5C
                move.w  #$3C,(a0) ; '<'
                move.w  #$C080,2(a0)
                move.w  $10(a2),$10(a0)
                move.w  $14(a2),$14(a0)
                move.w  d3,$E(a0)
                move.w  (a1)+,d0
                asl.w   #1,d0
                move.l  (a4,d0.w),8(a0)
                move.w  d4,$48(a0)
                move.w  (a3)+,$50(a0)
                addq.w  #2,d4
                lea     $60(a0),a0
                dbf d7,UI_InitWeaponSlotLoop
                move.b  #$C0,d0
                jmp (Sound_PlaySFX).l
; End of function UI_InitWeaponSelectScreen
; ---------------------------------------------------------------------------
word_17A9C:     dc.w $180, 0, $80, $100 ; DATA XREF: UI_InitWeaponSelectScreen+84   o
word_17AA4:     dc.w 0, $180, $100, $80 ; DATA XREF: UI_InitWeaponSelectScreen+24   o
                                        ; UI_HandleWeaponSelectInput+8   r


; Handles rotation input on weapon select screen with sound
UI_HandleWeaponSelectInput:                              ; CODE XREF: UI_UpdateWeaponSelect:loc_17BD6   p  ; was: sub_17AAC
                move.w  (word_FF8036).w,d0
                move.w  (word_FF803C).w,d1
                cmp.w   word_17AA4(pc,d1.w),d0
                beq.s   loc_17AC8
                add.w   (word_FF803A).w,d0
                andi.w  #$1F0,d0
                move.w  d0,(word_FF8036).w
                rts
; ---------------------------------------------------------------------------
loc_17AC8:                              ; CODE XREF: UI_HandleWeaponSelectInput+C   j
                btst    #3,(byte_FFA46A).w
                beq.s   loc_17AEA
                move.w  #$FFF0,(word_FF803A).w
                addq.w  #2,(word_FF803C).w
                andi.w  #6,(word_FF803C).w
                move.b  #$A8,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_17AEA:                              ; CODE XREF: UI_HandleWeaponSelectInput+22   j
                btst    #2,(byte_FFA46A).w
                beq.s   locret_17B0C
                move.w  #$10,(word_FF803A).w
                subq.w  #2,(word_FF803C).w
                andi.w  #6,(word_FF803C).w
                move.b  #$A8,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_17B0C:                           ; CODE XREF: UI_HandleWeaponSelectInput+44   j
                rts
; End of function UI_HandleWeaponSelectInput
; Handles D-pad weapon selection
UI_HandleDPadWeaponSelect:
                move.b  (byte_FFA46A).w,d0  ; was: sub_17B0E
                andi.b  #$F,d0
                beq.s   locret_17B32
                move.b  #$A8,d0
                jsr (Sound_PlaySFX).l
                move.b  (byte_FFA46A).w,d0
                btst    #0,d0
                beq.s   loc_17B34
                move.w  #0,(word_FF803C).w
locret_17B32:                           ; CODE XREF: UI_HandleDPadWeaponSelect+8   j
                                        ; UI_HandleDPadWeaponSelect+46   j
                rts
; ---------------------------------------------------------------------------
loc_17B34:                              ; CODE XREF: UI_HandleDPadWeaponSelect+1C   j
                btst    #1,d0
                beq.s   loc_17B42
                move.w  #4,(word_FF803C).w
                rts
; ---------------------------------------------------------------------------
loc_17B42:                              ; CODE XREF: UI_HandleDPadWeaponSelect+2A   j
                btst    #3,d0
                beq.s   loc_17B50
                move.w  #2,(word_FF803C).w
                rts
; ---------------------------------------------------------------------------
loc_17B50:                              ; CODE XREF: UI_HandleDPadWeaponSelect+38   j
                btst    #2,d0
                beq.s   locret_17B32
                move.w  #6,(word_FF803C).w
                rts
; End of function UI_HandleDPadWeaponSelect
; Clears weapon use counters
UI_ClearWeaponCounters:                              ; CODE XREF: UI_InitWeaponSelectScreen+1A   p  ; was: sub_17B5E
                                        ; UI_IncrementWeaponSelection+16   p ...
                moveq   #0,d0
                move.w  d0,(word_FF801C).w
                move.w  d0,(word_FF801E).w
                move.w  d0,(dword_FF8020).w
                move.w  d0,(dword_FF8020+2).w
                move.w  d0,(dword_FF8024).w
                move.w  d0,(dword_FF8024+2).w
                move.w  d0,(dword_FF8028).w
                move.w  d0,(dword_FF8028+2).w
                move.w  d0,(dword_FF802C).w
                move.w  d0,(dword_FF802C+2).w
                rts
; End of function UI_ClearWeaponCounters
; Main update loop for weapon select screen with collision check
UI_UpdateWeaponSelect:                              ; DATA XREF: ROM:00017998   o  ; was: sub_17B8A
                bsr.w UI_SaveWeaponIndex
                tst.w   (word_FF80E6).w
                bne.w   loc_17BEC
                btst    #6,(byte_FF8244).w
                bne.s   loc_17BA8
                btst    #0,(byte_FF8244).w
                bne.w UI_UpdateWeaponSelection
loc_17BA8:                              ; CODE XREF: UI_UpdateWeaponSelect+12   j
                tst.w   (word_FFA02A).w
                bne.w UI_UpdateWeaponSelection
                subi.w  #8,(word_FF8030).w
                cmpi.w  #$20,(word_FF8030).w ; ' '
                bmi.s   loc_17BD6
                moveq   #$10,d0
                btst    #3,(word_FFA40E).w
                bne.s   loc_17BCA
                moveq   #$FFFFFFF0,d0
loc_17BCA:                              ; CODE XREF: UI_UpdateWeaponSelect+3C   j
                add.w   d0,(word_FF8036).w
                andi.w  #$1F8,(word_FF8036).w
                rts
; ---------------------------------------------------------------------------
loc_17BD6:                              ; CODE XREF: UI_UpdateWeaponSelect+32   j
                bsr.w UI_HandleWeaponSelectInput
                move.w  #$20,(word_FF8030).w ; ' '
                move.b  (byte_FFA46A).w,d0
                andi.b  #$70,d0 ; 'p'
                bne.s   loc_17BEC
                rts
; ---------------------------------------------------------------------------
loc_17BEC:                              ; CODE XREF: UI_UpdateWeaponSelect+8   j
                                        ; UI_UpdateWeaponSelect+5E   j
                move.b  #$A7,d0
                jsr (Sound_PlaySFX).l
                move.w  #8,(word_FF8038).w
; End of function UI_UpdateWeaponSelect
; Increments weapon selection index
UI_IncrementWeaponSelection:                              ; CODE XREF: Player_InitializeStats+76   j  ; was: sub_17BFC
                                        ; UI_HandleOptionSelection+7A   p ...
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(word_FFA21C).w
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bsr.w UI_ClearWeaponCounters
                bra.w Sys_ClearObjectBufferSmall
; End of function UI_IncrementWeaponSelection
; Updates weapon selection index and clears object buffer
UI_UpdateWeaponSelection:                              ; CODE XREF: UI_UpdateWeaponSelect+1A   j  ; was: sub_17C1A
                                        ; UI_UpdateWeaponSelect+22   j ...
                move.w  (word_FFA21C).w,d0
                bne.s   loc_17C26
                clr.w   (word_FFA220).w
                bra.s   loc_17C2C
; ---------------------------------------------------------------------------
loc_17C26:                              ; CODE XREF: UI_UpdateWeaponSelection+4   j
                cmpi.w  #$12,d0
                bmi.s   loc_17C40
loc_17C2C:                              ; CODE XREF: UI_UpdateWeaponSelection+A   j
                movea.w (word_FFA220).w,a0
                move.w  a0,(word_FFA24E).w
                adda.w  #$A250,a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(word_FFA21C).w
loc_17C40:                              ; CODE XREF: UI_UpdateWeaponSelection+10   j
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                clr.w   (word_FF8038).w
                bra.w Sys_ClearObjectBufferSmall
; End of function UI_UpdateWeaponSelection
; Saves current weapon selection index to RAM
UI_SaveWeaponIndex:                              ; CODE XREF: UI_UpdateWeaponSelect   p  ; was: sub_17C4E
                move.w  (word_FF803C).w,(word_FFA24E).w
                rts
; End of function UI_SaveWeaponIndex
; Calculates number of health bar segments to display based on player health value
UI_CalculateHealthBarSegments:                              ; DATA XREF: ROM:00017986   o  ; was: sub_17C56
                moveq   #$E,d0
                move.w  $10(a1),d1
                cmpi.w  #$708,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
                cmpi.w  #$3E8,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
                cmpi.w  #$320,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
loc_17C74:                              ; CODE XREF: UI_CalculateHealthBarSegments+A   j
                                        ; UI_CalculateHealthBarSegments+12   j ...
                move.w  d0,(dword_FF802C).w
                bra.w UI_RenderTargetingReticle
; End of function UI_CalculateHealthBarSegments
; Initializes health bar sprite objects with properties and positions
UI_InitHealthBarSprites:                              ; DATA XREF: ROM:00017988   o  ; was: sub_17C7C
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #3,d7
loc_17C82:                              ; CODE XREF: UI_InitHealthBarSprites+1E   j
                tst.w   (a0)
                bne.s   loc_17C96
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$22C,$48(a0)
loc_17C96:                              ; CODE XREF: UI_InitHealthBarSprites+8   j
                lea     $C0(a0),a0
                dbf     d7,loc_17C82
                clr.w   (dword_FF802C).w
                move.w  $10(a1),d0
                cmpi.w  #$320,d0
                bmi.s UI_SetHealthBarFlag
                addq.w  #1,(dword_FF802C).w
; Sets health bar display flag based on player health threshold
UI_SetHealthBarFlag:                              ; CODE XREF: UI_InitHealthBarSprites+2E   j  ; was: loc_17CB0
                bra.w UI_RenderTargetingReticle
; End of function UI_InitHealthBarSprites
; Calculates projectile velocity based on player X position
Enemy_CalculateVelocityFromPlayer:                              ; DATA XREF: ROM:0001798A   o  ; was: sub_17CB4
                move.w  (word_FFA000).w,d0
                btst    #7,d0
                bne.s   loc_17CD4
                andi.w  #$7F,d0
                cmpi.w  #$40,d0 ; '@'
                bmi.s   loc_17CD4
                move.w  (dword_FFFF08).w,d3
                andi.w  #1,d3
                addq.w  #3,d3
                bra.s   loc_17CEA
; ---------------------------------------------------------------------------
loc_17CD4:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+8   j
                                        ; Enemy_CalculateVelocityFromPlayer+12   j
                move.w  $10(a1),d0
                moveq   #2,d3
                cmpi.w  #$3E8,d0
                bmi.s   loc_17CEA
                moveq   #3,d3
                cmpi.w  #$708,d0
                bmi.s   loc_17CEA
                moveq   #4,d3
loc_17CEA:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+1E   j
                                        ; Enemy_CalculateVelocityFromPlayer+2A   j ...
                movea.l #word_1B514,a0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d3,d2
                move.l  d1,(dword_FF8024).w
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                add.l   d0,d2
                move.l  d2,(dword_FF8028).w
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$7D0,d0
                bmi.s   loc_17D2E
                move.l  #dword_19812,(dword_FF802C).w
                rts
; ---------------------------------------------------------------------------
loc_17D2E:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+6E   j
                subq.w  #8,d0
                bpl.s   loc_17D34
                moveq   #0,d0
loc_17D34:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+7C   j
                divs.w  #$FA,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  (a2,d0.w),(dword_FF802C).w
                rts
; End of function Enemy_CalculateVelocityFromPlayer
; Processes targeting reticle system with enemy detection and sprite management
UI_ProcessTargetingSystem:                              ; DATA XREF: ROM:0001798C   o  ; was: sub_17D46
                move.w  #0,(dword_FF8028+2).w
                moveq   #0,d0
                move.w  $10(a1),d0
                bne.s   loc_17D5A
                move.w  #1,(dword_FF8028+2).w
loc_17D5A:                              ; CODE XREF: UI_ProcessTargetingSystem+C   j
                cmpi.w  #$3E8,d0
                bmi.s   loc_17D64
                moveq   #$1C,d0
                bra.s   loc_17D74
; ---------------------------------------------------------------------------
loc_17D64:                              ; CODE XREF: UI_ProcessTargetingSystem+18   j
                subq.w  #8,d0
                bpl.s   loc_17D6A
                moveq   #0,d0
loc_17D6A:                              ; CODE XREF: UI_ProcessTargetingSystem+20   j
                divs.w  #$7D,d0 ; '}'
                asl.w   #2,d0
                andi.w  #$1C,d0
loc_17D74:                              ; CODE XREF: UI_ProcessTargetingSystem+1C   j
                move.l  -$C(a2,d0.w),(dword_FF802C).w
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #3,d7
loc_17D80:                              ; CODE XREF: UI_ProcessTargetingSystem+52   j
                tst.w   (a0)
                bne.s   loc_17D94
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$6C,$48(a0) ; 'l'
loc_17D94:                              ; CODE XREF: UI_ProcessTargetingSystem+3C   j
                lea     $C0(a0),a0
                dbf     d7,loc_17D80
                clr.w   (word_FF801C).w
                move.w  (word_FF8D7A).w,d7
                bmi.s   loc_17DCE
                movea.w #(byte_FF8E80-M68K_RAM),a1
loc_17DAA:                              ; CODE XREF: UI_ProcessTargetingSystem+6E   j
                movea.w (a1)+,a0
                btst    #7,$23(a0)
                bne.s   loc_17DBA
                dbf     d7,loc_17DAA
                rts
; ---------------------------------------------------------------------------
loc_17DBA:                              ; CODE XREF: UI_ProcessTargetingSystem+6C   j
                move.w  a0,(word_FF801C).w
                btst    #4,(word_FFF706).w
                beq.w   loc_19298
                moveq   #1,d6
                bra.w UI_CalculateReticlePosition
; ---------------------------------------------------------------------------
loc_17DCE:                              ; CODE XREF: UI_ProcessTargetingSystem+5E   j
                move.w  (word_FF8D78).w,d7
                bmi.s   locret_17DE6
                movea.w #(byte_FF8E00-M68K_RAM),a0
                movea.w (a0)+,a1
                move.w  $24(a1),d0
loc_17DDE:                              ; CODE XREF: UI_ProcessTargetingSystem+A8   j
                                        ; UI_ProcessTargetingSystem+AA   j ...
                dbf     d7,loc_17DE8
                move.w  a1,(word_FF801C).w
locret_17DE6:                           ; CODE XREF: UI_ProcessTargetingSystem+8C   j
                rts
; ---------------------------------------------------------------------------
loc_17DE8:                              ; CODE XREF: UI_ProcessTargetingSystem:loc_17DDE   j
                movea.w (a0)+,a2
                cmp.w   $24(a2),d0
                beq.s   loc_17DDE
                bmi.s   loc_17DDE
                movea.w a2,a1
                move.w  $24(a1),d0
                bra.s   loc_17DDE
; End of function UI_ProcessTargetingSystem
; Updates weapon gauge sprite color and animation based on charge level
UI_UpdateWeaponGaugeSprite:                              ; DATA XREF: ROM:0001798E   o  ; was: sub_17DFA
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$3E8,d0
                bmi.s   loc_17E10
                move.l  #dword_19772,(dword_FF802C).w
                bra.s UI_UpdateWeaponGaugePalette
; ---------------------------------------------------------------------------
loc_17E10:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+A   j
                subq.w  #8,d0
                bpl.s   loc_17E16
                moveq   #0,d0
loc_17E16:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+18   j
                divs.w  #$80,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  -8(a2,d0.w),(dword_FF802C).w
; Updates weapon gauge palette colors with animation cycling
UI_UpdateWeaponGaugePalette:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+14   j  ; was: loc_17E26
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_17E3E(pc,d0.w),(word_FFE36C).w
                move.w  word_17E3E(pc,d0.w),(word_FFE3EC).w
                rts
; End of function UI_UpdateWeaponGaugeSprite
; ---------------------------------------------------------------------------
word_17E3E:     dc.w $EEE, $EA6, $ECC, $E44
                                        ; DATA XREF: UI_UpdateWeaponGaugeSprite+36   r
                                        ; UI_UpdateWeaponGaugeSprite+3C   r


; Loads weapon icon graphics via DMA
Gfx_LoadWeaponIcon:                              ; DATA XREF: ROM:00017990   o  ; was: sub_17E46
                tst.l   (dword_FF8020).w
                bne.s   loc_17E4E
locret_17E4C:                           ; CODE XREF: Gfx_LoadWeaponIcon+10   j
                rts
; ---------------------------------------------------------------------------
loc_17E4E:                              ; CODE XREF: Gfx_LoadWeaponIcon+4   j
                move.w  (word_FF801C).w,d0
                cmpi.w  #$20,d0 ; ' '
                bpl.s   locret_17E4C
                addq.w  #2,(word_FF801C).w
                andi.w  #$1E,d0
                tst.w   (word_FFA22A).w
                beq.s Gfx_LoadWeaponIconTiles
                addi.w  #$20,d0 ; ' '
; Loads weapon icon tile graphics to VRAM using DMA transfer
Gfx_LoadWeaponIconTiles:                              ; CODE XREF: Gfx_LoadWeaponIcon+1E   j  ; was: loc_17E6A
                move.w  word_17E98(pc,d0.w),(word_FFE36C).w
                move.w  word_17E98(pc,d0.w),(word_FFE3EC).w
                lsr.w   #1,d0
                andi.w  #$E,d0
                movea.l (dword_FF8020).w,a0
                move.w  $20(a0,d0.w),(word_FF801E).w
                asl.w   #1,d0
                move.l  (a0,d0.w),d0
                move.l  #$94009340,d1
                jmp Gfx_SetupVDPDMA
; End of function Gfx_LoadWeaponIcon
; ---------------------------------------------------------------------------
word_17E98:     dc.w $EEE, $CEE, $AEE, $8EC, $6EC, $4EA, $2EA, $2E8, $2E8, $E6, $E6, $E4, $E4, $E2, $E2, $C0
                                        ; DATA XREF: Gfx_LoadWeaponIcon:loc_17E6A   r
                                        ; Gfx_LoadWeaponIcon+2A   r
                dc.w $EEE, $EEC, $EEA, $8CE, $6CE, $4AE, $2AE, $28E, $28E, $6E, $6E, $4E, $4E, $2E, $2E, $C


; Renders player sprite with position adjustments
Sprite_RenderPlayer:                              ; CODE XREF: Sprite_PrepareRendering+42   j  ; was: sub_17ED8
                moveq   #0,d6
                move.b  $9E(a5),d6
                move.b  (a4,d6.w),d1
                move.b  8(a4,d6.w),d2
                ext.w   d1
                ext.w   d2
                btst    #3,$E(a5)
                beq.s   loc_17EF4
                neg.w   d1
loc_17EF4:                              ; CODE XREF: Sprite_RenderPlayer+18   j
                add.w   $10(a5),d1
                add.w   $14(a5),d2
                move.b  byte_17F3A(pc,d6.w),d6
                movea.w (word_FFA24E).w,a4
                adda.w  #$A250,a4
                tst.w   $10(a4)
                beq.s Sprite_CheckWeaponFireEffect
                bset    #2,(byte_FF8244).w
; Checks if weapon fire effect should be displayed based on ammo
Sprite_CheckWeaponFireEffect:                              ; CODE XREF: Sprite_RenderPlayer+34   j  ; was: loc_17F14
                move.w  (word_FFA21C).w,d0
                movea.w off_17F24(pc,d0.w),a0
                adda.l  #byte_17F3A,a0
                jmp     (a0)
; End of function Sprite_RenderPlayer
; ---------------------------------------------------------------------------
off_17F24:      dc.w Weapon_BeamFireEmptyExit-byte_17F3A
                                        ; DATA XREF: Sprite_RenderPlayer+40   r
                dc.w Weapon_FireProjectile-byte_17F3A
                dc.w Weapon_FireMultipleShots-byte_17F3A
                dc.w Weapon_FireBulletHandler-byte_17F3A
                dc.w Weapon_FireBeamWeapon-byte_17F3A
                dc.w Weapon_FireHomingShot-byte_17F3A
                dc.w Player_SpawnCircleAttack-byte_17F3A
                dc.w Weapon_BeamFireEmptyExit-byte_17F3A
                dc.w Weapon_BeamFireEmptyExit-byte_17F3A
                dc.w Weapon_BeamFireEmptyExit-byte_17F3A
                dc.w Weapon_BeamFireEmptyExit-byte_17F3A
byte_17F3A:     dc.b 0, 1, 2, 3, 4, 5, 6, 7
                                        ; DATA XREF: Sprite_RenderPlayer+24   r
                                        ; Sprite_RenderPlayer+44   o ...


; Fires weapon projectile with damage calculation and ammo depletion
Weapon_FireProjectile:                              ; DATA XREF: ROM:00017F26   o  ; was: sub_17F42
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.s   locret_17F68
                move.w  #2,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_17F5C:                              ; CODE XREF: Weapon_FireProjectile+22   j
                tst.w   (a0)
                beq.s   loc_17F6A
                lea     $60(a0),a0
                dbf     d7,loc_17F5C
locret_17F68:                           ; CODE XREF: Weapon_FireProjectile+C   j
                rts
; ---------------------------------------------------------------------------
loc_17F6A:                              ; CODE XREF: Weapon_FireProjectile+1C   j
                move.w  #$80,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   loc_17F86
                subq.w  #2,$10(a4)
loc_17F86:                              ; CODE XREF: Weapon_FireProjectile+3E   j
                move.w  #2,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_17F94
                move.w  #1,d0
loc_17F94:                              ; CODE XREF: Weapon_FireProjectile+4C   j
                sub.w   d0,$10(a4)
                bpl.s   loc_17F9E
                clr.w   $10(a4)
loc_17F9E:                              ; CODE XREF: Weapon_FireProjectile+56   j
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$268,(a0)
                move.l  #Weapon_InitProjectileSprite,$48(a0)
                move.l  #dword_2ADD0,$54(a0)
                move.w  #$8C80,2(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_17FD2
                move.w  #4,$26(a0)
loc_17FD2:                              ; CODE XREF: Weapon_FireProjectile+88   j
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  (dword_FF802C).w,$5E(a0)
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6 ; '|'
                movea.l #dword_19812,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$4C(a0)
                move.l  (dword_FF8240).w,d0
                asl.l   #2,d0
                add.l   d0,d1
                move.l  d1,$50(a0)
                addq.w  #8,d6
                andi.w  #$70,d6 ; 'p'
                asr.w   #3,d6
                move.w  d6,$5C(a0)
                move.b  #$B5,d0
                jsr (Sound_PlaySFX).l
                rts
; End of function Weapon_FireProjectile
; Initializes projectile sprite properties including tiles and velocity
Weapon_InitProjectileSprite:                              ; DATA XREF: Weapon_FireProjectile+68   o  ; was: sub_18026
                move.w  #$14,(a5)
                move.w  #$8C80,2(a5)
                move.b  #$40,$21(a5) ; '@'
                move.b  #1,$23(a5)
                move.w  $5C(a5),d6
                move.w  word_1805C(pc,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  word_1806C(pc,d6.w),8(a5)
                move.w  word_1807C(pc,d6.w),$A(a5)
                bra.w   loc_18F46
; End of function Weapon_InitProjectileSprite
; ---------------------------------------------------------------------------
word_1805C:     dc.w $4DA8, $4DB0       ; DATA XREF: Weapon_InitProjectileSprite+1A   r
                                        ; sub_1898E:loc_18A0C   o
                dc.w $45A0, $45B0
                dc.w $45A8, $55B0
                dc.w $55A0, $5DB0
word_1806C:     dc.w $D00, $A00         ; DATA XREF: Weapon_InitProjectileSprite+26   r
                dc.w $700, $A00
                dc.w $D00, $A00
                dc.w $700, $A00
word_1807C:     dc.w $F0F8, $F4F4       ; DATA XREF: Weapon_InitProjectileSprite+2C   r
                dc.w $F8F0, $F4F4
                dc.w $F0F8, $F4F4
                dc.w $F8F0, $F4F4


; Spawns homing projectile effect
Weapon_SpawnHomingEffect:
                tst.w   (word_FF8238).w  ; was: sub_1808C
                bpl.s   locret_180AA
                move.w  #2,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_1809E:                              ; CODE XREF: Weapon_SpawnHomingEffect+1A   j
                move.w  (a0),d0
                beq.s   loc_180AC
                lea     $60(a0),a0
                dbf     d7,loc_1809E
locret_180AA:                           ; CODE XREF: Weapon_SpawnHomingEffect+4   j
                rts
; ---------------------------------------------------------------------------
loc_180AC:                              ; CODE XREF: Weapon_SpawnHomingEffect+14   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d1
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$124,(a0)
                move.w  #$8C80,2(a0)
                move.w  #$16,$48(a0)
                move.b  #$40,$21(a0) ; '@'
                move.b  #$81,$23(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6 ; '|'
                lea     dword_19772(pc),a1
                nop
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                addq.w  #8,d6
                andi.w  #$70,d6 ; 'p'
                asr.w   #3,d6
                lea     word_1818E(pc),a1
                nop
                move.w  (a1,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.w  $10(a1,d6.w),8(a0)
                move.w  $20(a1,d6.w),$A(a0)
                movea.w #(byte_FFC2C0-M68K_RAM),a1
                moveq   #2,d7
loc_18142:                              ; CODE XREF: Weapon_SpawnHomingEffect+BE   j
                tst.w   (a1)
                beq.s   loc_18150
                lea     $60(a1),a1
                dbf     d7,loc_18142
                rts
; ---------------------------------------------------------------------------
loc_18150:                              ; CODE XREF: Weapon_SpawnHomingEffect+B8   j
                move.l  $18(a0),d0
                asr.l   #2,d0
                move.l  d0,$18(a1)
                move.l  $1C(a0),d0
                asr.l   #2,d0
                move.l  d0,$1C(a1)
                move.l  #off_E9698,8(a1)
                move.w  $10(a0),$10(a1)
                move.w  $14(a0),$14(a1)
                movea.w a1,a0
                jsr (Effect_SpawnExplosionType188).l
                move.w  #$EC00,2(a0)
                move.w  #8,$48(a0)
                rts
; End of function Weapon_SpawnHomingEffect
; ---------------------------------------------------------------------------
word_1818E:     dc.w $457E, $5580, $557C, $5D80, $4D7E, $4D80, $457C, $4580
                                        ; DATA XREF: Weapon_SpawnHomingEffect+92   o
                                        ; Weapon_HandleProjectileHit+44   o ...
                dc.w $400, $500, $100, $500, $400, $500, $100, $500
                dc.w $F8FC, $F8F8, $FCF8, $F8F8, $F8FC, $F8F8, $FCF8, $F8F8


; Fires multiple projectile shots in spread pattern
Weapon_FireMultipleShots:                              ; DATA XREF: ROM:00017F28   o  ; was: sub_181BE
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.w   locret_182BA
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                movea.w #(dword_FFA100-M68K_RAM),a1
                moveq   #0,d3
                moveq   #7,d7
loc_181DA:                              ; CODE XREF: Weapon_FireMultipleShots+28   j
                tst.w   (a0)
                bne.s   loc_181E2
                move.w  a0,(a1)+
                addq.w  #1,d3
loc_181E2:                              ; CODE XREF: Weapon_FireMultipleShots+1E   j
                lea     $60(a0),a0
                dbf     d7,loc_181DA
                tst.w   d3
                beq.w   locret_182BA
                move.b  #$BF,d0
                jsr (Sound_PlaySFX).l
                movea.w #(dword_FFA100-M68K_RAM),a3
                lea     byte_184D8(pc),a1
                nop
                lea     dword_19632(pc),a2
                nop
                move.b  (a1,d6.w),d6
                cmpi.w  #4,d3
                bpl.w Weapon_FireFourShotSpread
                rts
; End of function Weapon_FireMultipleShots
; Consumes ammo for spread shot
Weapon_ConsumeAmmoForSpread:
                move.w  #$80,(word_FF8140).w  ; was: sub_18218
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                move.w  #2,(word_FF8238).w
                subi.w  #$12,$10(a4)
                bpl.s Weapon_InitSpreadShot
                clr.w   $10(a4)
; End of function Weapon_ConsumeAmmoForSpread
; Initializes single shot in spread fire pattern with velocity
Weapon_InitSpreadShot:                              ; CODE XREF: Weapon_ConsumeAmmoForSpread+1E   j  ; was: sub_1823C
                                        ; Weapon_FireFourShotSpread+48   p
                movea.w (a3)+,a0
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$268,(a0)
                move.l  #Weapon_SetProjectileAnimation,$48(a0)
                move.l  #dword_2ADC8,$54(a0)
                move.w  #$8C80,2(a0)
                clr.b   $21(a0)
                move.w  #1,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_18276
                move.w  #2,$26(a0)
loc_18276:                              ; CODE XREF: Weapon_InitSpreadShot+32   j
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.l  (a2,d6.w),d3
                move.l  $20(a2,d6.w),d4
                move.l  d3,$4C(a0)
                move.l  (dword_FF8240).w,d5
                asl.l   #2,d5
                add.l   d4,d5
                move.l  d5,$50(a0)
                asl.l   #1,d3
                asl.l   #1,d4
                add.l   d3,$14(a0)
                add.l   d4,$10(a0)
                neg.l   d3
                neg.l   d4
                asr.l   #3,d3
                asr.l   #3,d4
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.w  #$20,$5E(a0) ; ' '
locret_182BA:                           ; CODE XREF: Weapon_FireMultipleShots+C   j
                                        ; Weapon_FireMultipleShots+2E   j
                rts
; End of function Weapon_InitSpreadShot
; Fires four projectiles in spread pattern with ammo depletion
Weapon_FireFourShotSpread:                              ; CODE XREF: Weapon_FireMultipleShots+54   j  ; was: sub_182BC
                move.w  #$E0,(word_FF8140).w
                move.b  #$E0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   loc_182D8
                subq.w  #8,$10(a4)
loc_182D8:                              ; CODE XREF: Weapon_FireFourShotSpread+16   j
                move.w  #4,(word_FF8238).w
                move.w  #$14,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_182EC
                move.w  #$12,d0
loc_182EC:                              ; CODE XREF: Weapon_FireFourShotSpread+2A   j
                sub.w   d0,$10(a4)
                bpl.s   loc_182F6
                clr.w   $10(a4)
loc_182F6:                              ; CODE XREF: Weapon_FireFourShotSpread+34   j
                subi.w  #$14,d6
                moveq   #3,d7
loc_182FC:                              ; CODE XREF: Weapon_FireFourShotSpread+4C   j
                addi.w  #8,d6
                andi.w  #$7C,d6 ; '|'
                bsr.w Weapon_InitSpreadShot
                dbf     d7,loc_182FC
                rts
; End of function Weapon_FireFourShotSpread
; Sets projectile sprite animation properties and frame data
Weapon_SetProjectileAnimation:                              ; DATA XREF: Weapon_InitSpreadShot+E   o  ; was: sub_1830E
                move.w  #$22C,(a5)
                move.w  #$8C80,2(a5)
                move.b  #$40,$21(a5) ; '@'
                move.b  #1,$23(a5)
                rts
; End of function Weapon_SetProjectileAnimation
nullsub_46:
                rts
; End of function nullsub_46


; Handles player bullet firing with ammo check
Weapon_FireBulletHandler:                              ; DATA XREF: ROM:00017F2A   o  ; was: sub_18328
                btst    #7,(byte_FF8245).w
                bne.w Effect_SpawnRandomDebris
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #8,(byte_FF8143).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_18352:                              ; CODE XREF: Weapon_FireBulletHandler+32   j
                move.w  (a0),d0
                beq.s   loc_18360
                lea     $60(a0),a0
                dbf     d7,loc_18352
                rts
; ---------------------------------------------------------------------------
loc_18360:                              ; CODE XREF: Weapon_FireBulletHandler+2C   j
                tst.w   (word_FFA22A).w
                bne.s   loc_1836A
                subq.w  #2,$10(a4)
loc_1836A:                              ; CODE XREF: Weapon_FireBulletHandler+3C   j
                move.w  #4,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_18378
                move.w  #3,d0
loc_18378:                              ; CODE XREF: Weapon_FireBulletHandler+4A   j
                sub.w   d0,$10(a4)
                bpl.s   loc_18382
                clr.w   $10(a4)
loc_18382:                              ; CODE XREF: Weapon_FireBulletHandler+54   j
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  #$18,(a0)
                move.w  #$8C80,2(a0)
                move.b  #$40,$21(a0) ; '@'
                move.b  #8,$23(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_183B2
                move.w  #4,$26(a0)
loc_183B2:                              ; CODE XREF: Weapon_FireBulletHandler+82   j
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$10,$48(a0)
                movea.l #byte_184D8,a1
                moveq   #0,d5
                move.b  (a1,d6.w),d5
                movea.l (dword_FF802C).w,a1
                move.l  (a1,d5.w),d1
                move.l  $20(a1,d5.w),d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                move.w  d5,$56(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_183FA
                move.b  #$EB,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_183FA:                           ; CODE XREF: Weapon_FireBulletHandler+C6   j
                rts
; End of function Weapon_FireBulletHandler
nullsub_47:
                rts
; End of function nullsub_47


; Fires beam weapon with continuous fire and ammo consumption
Weapon_FireBeamWeapon:                              ; DATA XREF: ROM:00017F2C   o  ; was: sub_183FE
                btst    #7,(byte_FF8245).w
                bne.w Effect_SpawnRandomDebris
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$20,(byte_FF8142).w ; ' '
                move.b  #$C,(byte_FF8143).w
                tst.w   (word_FF8238).w
                bpl.w   locret_18442
                move.w  #1,(word_FF8238).w
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_18436:                              ; CODE XREF: Weapon_FireBeamWeapon+40   j
                move.w  (a0),d0
                beq.s   loc_18444
                lea     $60(a0),a0
                dbf     d7,loc_18436
locret_18442:                           ; CODE XREF: Weapon_FireBeamWeapon+28   j
                rts
; ---------------------------------------------------------------------------
loc_18444:                              ; CODE XREF: Weapon_FireBeamWeapon+3A   j
                tst.w   (word_FFA22A).w
                bne.s   loc_1844E
                subq.w  #4,$10(a4)
loc_1844E:                              ; CODE XREF: Weapon_FireBeamWeapon+4A   j
                move.w  #2,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_1845C
                move.w  #1,d0
loc_1845C:                              ; CODE XREF: Weapon_FireBeamWeapon+58   j
                sub.w   d0,$10(a4)
                bpl.s   loc_18466
                clr.w   $10(a4)
loc_18466:                              ; CODE XREF: Weapon_FireBeamWeapon+62   j
                move.w  #$6C,(a0) ; 'l'
                move.w  #1,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s Weapon_SetBeamProjectileData
                move.w  #2,$26(a0)
; Sets beam projectile sprite properties and velocity data
Weapon_SetBeamProjectileData:                              ; CODE XREF: Weapon_FireBeamWeapon+76   j  ; was: loc_1847C
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                clr.w   4(a0)
                move.w  #$8C80,2(a0)
                move.b  #$40,$21(a0) ; '@'
                move.b  #$42,$23(a0) ; 'B'
                move.w  #4,$48(a0)
                clr.w   $56(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                move.b  byte_184E0(pc,d0.w),d0
                add.b   byte_184D8(pc,d6.w),d0
                move.b  d0,$57(a0)
                move.w  a0,d0
                btst    #5,d0
                beq.s Weapon_BeamFireEmptyExit
                move.b  #$BA,d0
                jmp (Sound_PlaySFX).l
; End of function Weapon_FireBeamWeapon
; Empty exit point after beam weapon fire
Weapon_BeamFireEmptyExit:                             ; CODE XREF: Weapon_FireBeamWeapon+CC   j  ; was: nullsub_45
                                        ; Player_SpawnCircleAttack+C   j
                                        ; DATA XREF: ...
                rts
; End of function Weapon_BeamFireEmptyExit
; ---------------------------------------------------------------------------
byte_184D8:     dc.b 0, $10, $20, $30, $40, $50, $60, $70
                                        ; DATA XREF: Weapon_FireProjectile+A0   o
                                        ; Weapon_SpawnHomingEffect+66   o ...
byte_184E0:     dc.b $FC, $F8, $FC, 0, 0, 4, 8, 4
                                        ; DATA XREF: Weapon_FireBeamWeapon+BA   r


; Duplicates beam projectile
Weapon_CloneBeamProjectile:
                movea.w a0,a1  ; was: sub_184E8
                adda.w  #$300,a1
                move.w  #$A0,(a1)
                move.w  #$8080,2(a1)
                move.w  #$500,8(a1)
                move.w  #$F8F8,$A(a1)
                move.w  $20(a0),$20(a1)
                move.w  $10(a0),$10(a1)
                move.w  $14(a0),$14(a1)
                move.w  $10(a0),$48(a1)
                move.w  $14(a0),$4A(a1)
                move.w  a1,d0
                andi.w  #$20,d0 ; ' '
                move.w  d0,$4C(a1)
                rts
; End of function Weapon_CloneBeamProjectile
nullsub_48:
                rts
; End of function nullsub_48


; Spawns 8 projectiles in circular pattern
Player_SpawnCircleAttack:                              ; DATA XREF: ROM:00017F30   o  ; was: sub_18530
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                tst.w   (word_FF8238).w
                bpl.w Weapon_BeamFireEmptyExit
                move.w  #$38,(word_FF8238).w ; '8'
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_1854C:                              ; CODE XREF: Player_SpawnCircleAttack+26   j
                move.w  (a0),d0
                bne.w   locret_1869E
                lea     $60(a0),a0
                dbf     d7,loc_1854C
                move.w  #$E0,(word_FF8140).w
                move.b  #$C0,(byte_FF8142).w
                move.b  #4,(byte_FF8143).w
                tst.w   (word_FFA22A).w
                bne.s   loc_18578
                subi.w  #$A,$10(a4)
loc_18578:                              ; CODE XREF: Player_SpawnCircleAttack+40   j
                move.w  #$8C,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_18586
                move.w  #$8C,d0
loc_18586:                              ; CODE XREF: Player_SpawnCircleAttack+50   j
                sub.w   d0,$10(a4)
                bpl.s   loc_18590
                clr.w   $10(a4)
loc_18590:                              ; CODE XREF: Player_SpawnCircleAttack+5A   j
                moveq   #0,d5
                movea.l #byte_184D8,a0
                move.b  (a0,d6.w),d5
                move.w  d5,d7
                asl.w   #2,d5
                movea.l #word_1B514,a0
                move.w  -$80(a0,d5.w),d3
                move.w  (a0,d5.w),d4
                muls.w  #$27,d3 ; '''
                muls.w  #$27,d4 ; '''
                move.l  d3,(dword_FF8040).w
                move.l  d4,(dword_FF8044).w
                move.w  d1,d3
                move.w  d2,d4
                sub.w   $10(a5),d3
                sub.w   $14(a5),d4
                move.w  d3,(word_FF8048).w
                move.w  d4,(word_FF804A).w
                movea.l #dword_19632,a0
                move.l  (a0,d7.w),d3
                move.l  $20(a0,d7.w),d4
                move.w  d7,d6
                addq.w  #8,d6
                andi.w  #$70,d6 ; 'p'
                asr.w   #3,d6
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
                movea.l #word_186B0,a2
                moveq   #1,d5
                move.w  (word_FF808A).w,d0
                andi.w  #$8000,d0
loc_18600:                              ; CODE XREF: Player_SpawnCircleAttack+150   j
                move.w  #$60,(a0) ; '`'
                move.w  #$8E80,2(a0)
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                move.w  (word_FF8048).w,$58(a0)
                move.w  (word_FF804A).w,$5A(a0)
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.l  (dword_FF8040).w,$48(a0)
                move.l  (dword_FF8044).w,$4C(a0)
                clr.l   $50(a0)
                clr.l   $54(a0)
                move.w  (a2,d6.w),$E(a0)
                move.w  $10(a2,d6.w),8(a0)
                move.w  $20(a2,d6.w),$A(a0)
                or.w    d0,$E(a0)
                clr.b   $21(a0)
                move.b  #4,$23(a0)
                move.w  #$D,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s Weapon_SetCircleAttackProperties
                move.w  #$E,$26(a0)
; Sets sprite properties for circular attack pattern projectiles
Weapon_SetCircleAttackProperties:                              ; CODE XREF: Player_SpawnCircleAttack+134   j  ; was: loc_1866C
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  d5,$5E(a0)
                addq.w  #3,d5
                lea     $60(a0),a0
                dbf     d7,loc_18600
                andi.w  #6,d6
                asl.w   #1,d6
                move.l  off_186A0(pc,d6.w),(dword_FF8020).w
                clr.w   (word_FF801C).w
                move.b  #$B4,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_1869E:                           ; CODE XREF: Player_SpawnCircleAttack+1E   j
                rts
; End of function Player_SpawnCircleAttack
; ---------------------------------------------------------------------------
off_186A0:      dc.l off_19932          ; DATA XREF: Player_SpawnCircleAttack+15A   r
                dc.l off_19972
                dc.l off_19952
                dc.l off_19972
word_186B0:     dc.w $65A0, $75A0, $75A0, $7DA0, $6DA0, $6DA0, $65A0, $65A0
                                        ; DATA XREF: Player_SpawnCircleAttack+C0   o
                dc.w $C00, $500, $300, $500, $C00, $500, $300, $500
                dc.w $F0FC, $F8F8, $FCF0, $F8F8, $F0FC, $F8F8, $FCF0, $F8F8


nullsub_49:
                rts
; End of function nullsub_49


; Fires homing projectile that tracks player position
Weapon_FireHomingShot:                              ; DATA XREF: ROM:00017F2E   o  ; was: sub_186E2
                tst.w   $10(a4)
                beq.w Effect_SpawnRandomDebris
                move.w  #$E0,(word_FF8140).w
                move.b  #$80,(byte_FF8142).w
                move.b  #8,(byte_FF8143).w
                btst    #0,(word_FFA000+1).w
                bne.s   locret_18716
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_1870A:                              ; CODE XREF: Weapon_FireHomingShot+30   j
                move.w  (a0),d0
                beq.s   loc_18718
                lea     $60(a0),a0
                dbf     d7,loc_1870A
locret_18716:                           ; CODE XREF: Weapon_FireHomingShot+20   j
                rts
; ---------------------------------------------------------------------------
loc_18718:                              ; CODE XREF: Weapon_FireHomingShot+2A   j
                tst.w   (word_FFA22A).w
                bne.s   loc_18722
                subq.w  #2,$10(a4)
loc_18722:                              ; CODE XREF: Weapon_FireHomingShot+3A   j
                move.w  #3,d0
                tst.b   (word_FFFF0E).w
                bne.s   loc_18730
                move.w  #2,d0
loc_18730:                              ; CODE XREF: Weapon_FireHomingShot+48   j
                sub.w   d0,$10(a4)
                bpl.s   loc_1873A
                clr.w   $10(a4)
loc_1873A:                              ; CODE XREF: Weapon_FireHomingShot+52   j
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                sub.w   $10(a5),d1
                sub.w   $14(a5),d2
                move.w  d1,$58(a0)
                move.w  d2,$5A(a0)
                clr.l   $50(a5)
                clr.l   $54(a5)
                move.w  #$74,(a0) ; 't'
                move.b  #$40,$21(a0) ; '@'
                move.b  #4,$23(a0)
                move.w  #3,$26(a0)
                tst.w   (word_FFFF0E).w
                bne.s Weapon_SetHomingProjectileData
                move.w  #4,$26(a0)
; Sets homing projectile velocity and sprite animation data
Weapon_SetHomingProjectileData:                              ; CODE XREF: Weapon_FireHomingShot+92   j  ; was: loc_1877C
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$12,$5E(a0)
                lea     byte_184D8(pc),a1
                moveq   #0,d5
                move.b  (a1,d6.w),d5
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                movea.l (dword_FF802C).w,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                andi.w  #$70,d6 ; 'p'
                asr.w   #3,d6
                movea.l #word_187EC,a1
                move.w  (a1,d6.w),d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a0)
                move.w  $10(a1,d6.w),8(a0)
                move.w  $20(a1,d6.w),$A(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_187EA
                move.b  #$B3,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_187EA:                           ; CODE XREF: Weapon_FireHomingShot+FC   j
                rts
; End of function Weapon_FireHomingShot
; ---------------------------------------------------------------------------
word_187EC:     dc.w $65A3, $75A6, $75A0, $7DA6, $6DA3, $6DA6, $65A0, $65A6
                                        ; DATA XREF: Weapon_FireHomingShot+D8   o
                dc.w $800, $A00, $200, $A00, $800, $A00, $200, $A00
                dc.w $F4FC, $F4F4, $FCF4, $F4F4, $F4FC, $F4F4, $FCF4, $F4F4


nullsub_50:
                rts
; End of function nullsub_50


; Calculates projectile spawn position
Weapon_CalculateOffsetPosition:
                move.b  (a4,d6.w),d0  ; was: sub_1881E
                move.b  8(a4,d6.w),d1
                ext.w   d0
                ext.w   d1
                btst    #3,$E(a5)
                beq.s   loc_18834
                neg.w   d0
loc_18834:                              ; CODE XREF: Weapon_CalculateOffsetPosition+12   j
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                rts
; End of function Weapon_CalculateOffsetPosition
; Spawns random debris particle with velocity
Effect_SpawnRandomDebris:                              ; CODE XREF: Weapon_FireProjectile+4   j  ; was: sub_18846
                                        ; Weapon_FireMultipleShots+4   j ...
                btst    #0,(word_FFA000+1).w
                bne.s   locret_18860
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_18854:                              ; CODE XREF: Effect_SpawnRandomDebris+16   j
                tst.w   (a0)
                beq.s Effect_CreateDebrisParticle
                lea     $60(a0),a0
                dbf     d7,loc_18854
locret_18860:                           ; CODE XREF: Effect_SpawnRandomDebris+6   j
                rts
; ---------------------------------------------------------------------------
; Creates random debris particle effect with velocity
Effect_CreateDebrisParticle:                              ; CODE XREF: Effect_SpawnRandomDebris+10   j  ; was: loc_18862
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d1
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   d0,d2
                move.w  d1,$10(a0)
                move.w  d2,$14(a0)
                jsr (Sprite_InitializeProperties).l
                move.w  #$334,(a0)
                move.l  #off_E9738,8(a0)
                move.b  #$40,$21(a0) ; '@'
                clr.b   $23(a0)
                move.w  #1,$26(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                movea.l #byte_184D8,a1
                move.b  (a1,d6.w),d6
                andi.w  #$7C,d6 ; '|'
                movea.l #dword_193B2,a1
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$1C(a0)
                add.l   (dword_FF8240).w,d1
                move.l  d1,$18(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_188EC
                move.b  #$D3,d0
                jsr (Sound_PlaySFX).l
locret_188EC:                           ; CODE XREF: Effect_SpawnRandomDebris+9A   j
                rts
; End of function Effect_SpawnRandomDebris
; Checks if enemy damage exceeds threshold
Enemy_CheckDamageThreshold:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_188EE
                bclr    #7,$22(a5)
                bne.s Enemy_SetFlashOnDamage
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_18904
; Sets enemy sprite flash flag when damage threshold exceeded
Enemy_SetFlashOnDamage:                              ; CODE XREF: Enemy_CheckDamageThreshold+6   j  ; was: loc_188FE
                bset    #4,2(a5)
locret_18904:                           ; CODE XREF: Enemy_CheckDamageThreshold+E   j
                rts
; End of function Enemy_CheckDamageThreshold
; Updates target sight position
Player_UpdateTargetSight:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18906
                movea.w #(word_FFA400-M68K_RAM),a0
                clr.w   $56(a5)
                move.w  $10(a0),d5
                move.w  $14(a0),d6
                add.w   (word_FF8032).w,d5
                add.w   (word_FF8034).w,d6
                move.w  (word_FF8030).w,d0
                move.w  (word_FF8036).w,d7
                add.w   $50(a5),d7
                andi.w  #$1FE,d7
                movea.l #word_1B514,a2
                move.w  -$80(a2,d7.w),d1
                move.w  (a2,d7.w),d2
                muls.w  d0,d1
                muls.w  d0,d2
                asl.l   #2,d1
                asl.l   #2,d2
                swap    d1
                swap    d2
                add.w   d6,d1
                add.w   d5,d2
                move.w  d1,$14(a5)
                move.w  d2,$10(a5)
                move.w  (word_FF803C).w,d0
                cmp.w   $48(a5),d0
                bne.s   locret_18984
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_18972
                bclr    #7,2(a0)
                rts
; ---------------------------------------------------------------------------
loc_18972:                              ; CODE XREF: Player_UpdateTargetSight+62   j
                bset    #7,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
locret_18984:                           ; CODE XREF: Player_UpdateTargetSight+56   j
                rts
; End of function Player_UpdateTargetSight
; Marks sprite object for removal by setting deactivation flag
Sprite_MarkForRemoval:                              ; CODE XREF: Weapon_UpdateRotatingProjectile+30   j  ; was: sub_18986
                                        ; Weapon_UpdateRotatingProjectile+3A   j ...
                bset    #4,2(a5)
                rts
; End of function Sprite_MarkForRemoval
; Spawns particle effect when enemy takes knockback damage
Effect_SpawnKnockbackParticle:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_1898E
                bclr    #7,$22(a5)
                bne.s   loc_189A6
                bclr    #6,$23(a5)
                beq.s   loc_189E0
                bclr    #4,$23(a5)
                bne.s   loc_18A0C
loc_189A6:                              ; CODE XREF: Effect_SpawnKnockbackParticle+6   j
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #4,d1
                asl.l   #4,d2
                move.l  d1,$1C(a5)
                move.l  d2,$18(a5)
                lea     (dword_2AE8A).l,a1
                jsr (Effect_SpawnObjectType).l
                move.w  #$8C80,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_189E0:                              ; CODE XREF: Effect_SpawnKnockbackParticle+E   j
                subq.w  #1,$5E(a5)
                bpl.s   locret_18A0A
                clr.b   $21(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                lea     (dword_2AD16).l,a1
                jmp Effect_SpawnObjectType
; ---------------------------------------------------------------------------
locret_18A0A:                           ; CODE XREF: Effect_SpawnKnockbackParticle+56   j
                rts
; ---------------------------------------------------------------------------
loc_18A0C:                              ; CODE XREF: Effect_SpawnKnockbackParticle+16   j
                move.l  #word_1805C,$4A(a5)
                move.w  #$456C,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$F00,8(a5)
                move.w  #$F0F0,$A(a5)
loc_18A2C:                              ; CODE XREF: Weapon_HandleProjectileHit+4C   j
                                        ; Weapon_HandleExplosiveImpact+9E   j
                move.w  #$18C,(a5)
                move.w  #$8C80,2(a5)
                clr.b   $21(a5)
                lea     dword_19632(pc),a1
                nop
                move.w  (dword_FFFF08).w,d6
                andi.w  #$7C,d6 ; '|'
                move.l  (a1,d6.w),d0
                move.l  $20(a1,d6.w),d1
                asr.l   #1,d0
                asr.l   #1,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                move.b  #$C8,d0
                jmp (Sound_PlaySFX).l
; End of function Effect_SpawnKnockbackParticle
; Updates rotating projectile animation and boundary checking
Weapon_UpdateRotatingProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18A66
                move.w  $48(a5),d0
                addq.w  #2,d0
                andi.w  #$E,d0
                move.w  d0,$48(a5)
                movea.l $4A(a5),a0
                move.w  (a0,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  $10(a0,d0.w),8(a5)
                move.w  $20(a0,d0.w),$A(a5)
                cmpi.w  #$80,$10(a5)
                bmi.w Sprite_MarkForRemoval
                cmpi.w  #$1C0,$10(a5)
                bpl.w Sprite_MarkForRemoval
                cmpi.w  #$A0,$14(a5)
                bmi.w Sprite_MarkForRemoval
                cmpi.w  #$160,$14(a5)
                bpl.w Sprite_MarkForRemoval
                btst    #0,(byte_FF8144).w
                bne.s   locret_18AC8
                addi.l  #$4000,$1C(a5)
locret_18AC8:                           ; CODE XREF: Weapon_UpdateRotatingProjectile+58   j
                rts
; End of function Weapon_UpdateRotatingProjectile
; Handles projectile collision
Weapon_HandleProjectileHit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18ACA
                bclr    #7,$22(a5)
                bne.s   loc_18AE2
                bclr    #6,$23(a5)
                beq.s Weapon_TickLifetimeTimer
                bclr    #4,$23(a5)
                bne.s   loc_18AF6
loc_18AE2:                              ; CODE XREF: Weapon_HandleProjectileHit+6   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (dword_2ACA6).l,a1
                jmp Effect_SpawnObjectType
; ---------------------------------------------------------------------------
loc_18AF6:                              ; CODE XREF: Weapon_HandleProjectileHit+16   j
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #word_1818E,$4A(a5)
                bra.w   loc_18A2C
; End of function Weapon_HandleProjectileHit
; Attributes: thunk
; Thunk to Effect_SpawnObjectType
Effect_SpawnObjectThunk1:
                jmp Effect_SpawnObjectType  ; was: sub_18B1A
; End of function Effect_SpawnObjectThunk1
; Decrements projectile lifetime
Weapon_TickLifetimeTimer:                              ; CODE XREF: Weapon_HandleProjectileHit+E   j  ; was: sub_18B20
                subq.w  #1,$48(a5)
                bmi.w Sprite_MarkForRemoval
                rts
; End of function Weapon_TickLifetimeTimer
; Handles explosive projectile impact with particle spawn
Weapon_HandleExplosiveImpact:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18B2A
                bclr    #7,$22(a5)
                bne.s   loc_18B44
                bclr    #6,$23(a5)
                beq.w Weapon_AnimateExplosionFade
                bclr    #4,$23(a5)
                bne.s   loc_18BA8
loc_18B44:                              ; CODE XREF: Weapon_HandleExplosiveImpact+6   j
                tst.w   (dword_FF802C).w
                beq.s   loc_18B94
                move.l  $18(a5),d0
                asr.l   #3,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #3,d0
                move.l  d0,$1C(a5)
                move.w  #$400,(a5)
                move.w  #$EC00,2(a5)
                move.w  #$480,d0
                or.w    (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.l  #off_E9560,8(a5)
                clr.w   $C(a5)
                move.w  #5,$26(a5)
                tst.w   (word_FFFF0E).w
                bne.s   locret_18B92
                move.w  #6,$26(a5)
locret_18B92:                           ; CODE XREF: Weapon_HandleExplosiveImpact+60   j
                rts
; ---------------------------------------------------------------------------
loc_18B94:                              ; CODE XREF: Weapon_HandleExplosiveImpact+1E   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                lea     (dword_2ACA6).l,a1
                jmp Effect_SpawnObjectType
; ---------------------------------------------------------------------------
loc_18BA8:                              ; CODE XREF: Weapon_HandleExplosiveImpact+18   j
                move.w  #$44D6,d0
                add.w   (word_FF808A).w,d0
                move.w  d0,$E(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.l  #word_1818E,$4A(a5)
                bra.w   loc_18A2C
; End of function Weapon_HandleExplosiveImpact
; Attributes: thunk
; Thunk to Effect_SpawnObjectType
Effect_SpawnObjectThunk2:
                jmp Effect_SpawnObjectType  ; was: sub_18BCC
; End of function Effect_SpawnObjectThunk2
; Animates explosion sprite fading sequence
Weapon_AnimateExplosionFade:                              ; CODE XREF: Weapon_HandleExplosiveImpact+E   j  ; was: sub_18BD2
                subq.w  #2,$5E(a5)
                bmi.w Sprite_MarkForRemoval
                move.w  $5E(a5),d0
                asr.w   #2,d0
                cmpi.w  #6,d0
                bmi.s Weapon_GetExplosionFrameData
                moveq   #6,d0
; Gets explosion animation frame data based on timer
Weapon_GetExplosionFrameData:                              ; CODE XREF: Weapon_AnimateExplosionFade+12   j  ; was: loc_18BE8
                andi.w  #6,d0
                move.w  word_18C06(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.w  word_18C0E(pc,d0.w),8(a5)
                move.w  word_18C16(pc,d0.w),$A(a5)
                rts
; End of function Weapon_AnimateExplosionFade
; ---------------------------------------------------------------------------
word_18C06:     dc.w $45A9, $45A5, $45A1, $45A0
                                        ; DATA XREF: Weapon_AnimateExplosionFade+1A   r
word_18C0E:     dc.w $A00, $500, $500, 0
                                        ; DATA XREF: Weapon_AnimateExplosionFade+26   r
word_18C16:     dc.w $F4F4, $F8F8, $F8F8, $FCFC
                                        ; DATA XREF: Weapon_AnimateExplosionFade+2C   r


; Sets high priority bit on sprite
Sprite_SetPriorityHigh:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C1E
                bset    #4,2(a5)
                rts
; End of function Sprite_SetPriorityHigh
; Processes projectile hit effects including screen shake and palette change
Weapon_ProcessProjectileHit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C26
                move.w  #$A0,(word_FF8140).w
                move.b  #$60,(byte_FF8142).w ; '`'
                move.b  #4,(byte_FF8143).w
                tst.w   $26(a5)
                bpl.s Weapon_CheckProjectileDamage
                clr.b   $21(a5)
; Checks projectile damage threshold and sets transparency flag
Weapon_CheckProjectileDamage:                              ; CODE XREF: Weapon_ProcessProjectileHit+16   j  ; was: loc_18C42
                cmpi.w  #$80,$C(a5)
                bmi.s   locret_18C50
                move.w  #$1000,2(a5)
locret_18C50:                           ; CODE XREF: Weapon_ProcessProjectileHit+22   j
                rts
; End of function Weapon_ProcessProjectileHit
; Spawns particle effect at sprite position with trajectory
Sprite_SpawnParticleEffect:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18C52
                bclr    #6,$23(a5)
                bne.s   loc_18C64
                bclr    #7,$22(a5)
                beq.w Sprite_UpdateParticleAnimation
loc_18C64:                              ; CODE XREF: Sprite_SpawnParticleEffect+6   j
                move.w  a5,d0
                btst    #5,d0
                bne.w   loc_18CEE
                jsr (Sprite_AllocateSlot).l
                bne.w   loc_18CEE
                lea     (dword_2AF5A).l,a1
                btst    #7,(dword_FFFF08).w
                bne.s   loc_18C8C
                lea     (dword_2AF8C).l,a1
loc_18C8C:                              ; CODE XREF: Sprite_SpawnParticleEffect+32   j
                jsr (Projectile_FindFreeSlotComplex).l
                move.w  #$8C80,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                bpl.s   loc_18CB4
                clr.b   $20(a0)
loc_18CB4:                              ; CODE XREF: Sprite_SpawnParticleEffect+5C   j
                move.w  $56(a5),d5
                addi.w  #$20,d5 ; ' '
                andi.w  #$7C,d5 ; '|'
                lea     dword_19772(pc),a1
                nop
                move.l  (a1,d5.w),d0
                move.l  $20(a1,d5.w),d1
                btst    #1,(word_FFA000+1).w
                bne.s   loc_18CDA
                neg.l   d0
                neg.l   d1
loc_18CDA:                              ; CODE XREF: Sprite_SpawnParticleEffect+82   j
                asr.l   #2,d0
                asr.l   #2,d1
                add.l   (dword_FF8024).w,d0
                add.l   (dword_FF8028).w,d1
                move.l  d1,$18(a0)
                move.l  d0,$1C(a0)
loc_18CEE:                              ; CODE XREF: Sprite_SpawnParticleEffect+18   j
                                        ; Sprite_SpawnParticleEffect+22   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Updates particle effect sprite animation with gravity and fading
Sprite_UpdateParticleAnimation:                              ; CODE XREF: Sprite_SpawnParticleEffect+E   j  ; was: loc_18CF6
                move.l  (dword_FF8024).w,d0
                move.l  (dword_FF8028).w,d1
                add.l   d1,$18(a5)
                add.l   d0,$1C(a5)
                subq.w  #2,$48(a5)
                bmi.s   loc_18CEE
                move.w  $48(a5),d0
                move.w  word_18D2E(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                move.w  word_18D3E(pc,d0.w),8(a5)
                move.w  word_18D4E(pc,d0.w),$A(a5)
                rts
; End of function Sprite_SpawnParticleEffect
; ---------------------------------------------------------------------------
word_18D2E:     dc.w $452B, $451B, $450B, $451B, $452B, $4492, $449B, $44A4
                                        ; DATA XREF: Sprite_SpawnParticleEffect+BE   r
word_18D3E:     dc.w $F00, $F00, $F00, $F00, $F00, $A00, $A00, $500
                                        ; DATA XREF: Sprite_SpawnParticleEffect+CE   r
word_18D4E:     dc.w $F0F0, $F0F0, $F0F0, $F0F0, $F0F0, $F4F4, $F4F4, $F8F8
                                        ; DATA XREF: Sprite_SpawnParticleEffect+D4   r


; Updates seeking missile projectile with target tracking and rotation
Weapon_UpdateSeekingMissile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18D5E
                bclr    #7,$22(a5)
                bne.s   loc_18D6E
                bclr    #4,$23(a5)
                beq.s   loc_18D8A
loc_18D6E:                              ; CODE XREF: Weapon_UpdateSeekingMissile+6   j
                move.w  #3,$48(a5)
                move.l  #off_E9680,8(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                jmp Weapon_CopySeekingMissileAddress
; ---------------------------------------------------------------------------
loc_18D8A:                              ; CODE XREF: Weapon_UpdateSeekingMissile+E   j
                subq.w  #1,$48(a5)
                bpl.w   loc_18E18
                cmpi.w  #$FFF1,$48(a5)
                bpl.s   loc_18DA2
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_18DA2:                              ; CODE XREF: Weapon_UpdateSeekingMissile+3A   j
                move.w  a5,d0
                btst    #0,(word_FFA000+1).w
                bne.w   loc_18DB6
                btst    #5,d0
                beq.s   loc_18DBC
                bra.s   loc_18E18
; ---------------------------------------------------------------------------
loc_18DB6:                              ; CODE XREF: Weapon_UpdateSeekingMissile+4C   j
                btst    #5,d0
                beq.s   loc_18E18
loc_18DBC:                              ; CODE XREF: Weapon_UpdateSeekingMissile+54   j
                move.w  (word_FF801C).w,d0
                bne.s   loc_18DC8
                move.w  (dword_FFFF08).w,d2
                bra.s   loc_18DEE
; ---------------------------------------------------------------------------
loc_18DC8:                              ; CODE XREF: Weapon_UpdateSeekingMissile+62   j
                bclr    #0,d0
                movea.w d0,a0
                move.w  $10(a0),d0
                move.w  $14(a0),d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #1,d2
                move.w  d2,(dword_FF8040).w
                move.b  (dword_FF8040).w,d2
loc_18DEE:                              ; CODE XREF: Weapon_UpdateSeekingMissile+68   j
                andi.w  #$7C,d2 ; '|'
                move.w  (dword_FFFF08).w,d0
                andi.w  #6,d0
                addq.w  #6,d0
                sub.w   $56(a5),d2
                bmi.s   loc_18E0E
                cmpi.w  #$40,d2 ; '@'
                bpl.s   loc_18E14
loc_18E08:                              ; CODE XREF: Weapon_UpdateSeekingMissile+B4   j
                add.w   d0,$56(a5)
                bra.s   loc_18E18
; ---------------------------------------------------------------------------
loc_18E0E:                              ; CODE XREF: Weapon_UpdateSeekingMissile+A2   j
                cmpi.w  #$FFC0,d2
                bmi.s   loc_18E08
loc_18E14:                              ; CODE XREF: Weapon_UpdateSeekingMissile+A8   j
                sub.w   d0,$56(a5)
loc_18E18:                              ; CODE XREF: Weapon_UpdateSeekingMissile+30   j
                                        ; Weapon_UpdateSeekingMissile+56   j ...
                move.w  $56(a5),d2
                andi.w  #$7E,d2 ; '~'
                move.w  d2,$56(a5)
                andi.w  #$7C,d2 ; '|'
                movea.l (dword_FF802C).w,a0
                move.l  (a0,d2.w),d1
                move.l  $20(a0,d2.w),d0
                move.w  (dword_FF8028+2).w,d2
                asr.l   d2,d1
                asr.l   d2,d0
                move.l  d1,$1C(a5)
                move.l  d0,$18(a5)
                move.w  $48(a5),d0
                bmi.s   loc_18E4C
                moveq   #4,d0
loc_18E4C:                              ; CODE XREF: Weapon_UpdateSeekingMissile+EA   j
                andi.w  #$E,d0
                move.w  word_18E82(pc,d0.w),d1
                or.w    (word_FF808A).w,d1
                or.w    (word_FF8092).w,d1
                move.w  d1,$E(a5)
                cmpi.w  #4,d0
                bmi.s Weapon_SetMissileSize
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                rts
; ---------------------------------------------------------------------------
; Sets seeking missile sprite size based on distance from player
Weapon_SetMissileSize:                              ; CODE XREF: Weapon_UpdateSeekingMissile+106   j  ; was: loc_18E74
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                rts
; End of function Weapon_UpdateSeekingMissile
; ---------------------------------------------------------------------------
word_18E82:     dc.w $45A0, $45A0, $45A4, $45AD, $45AD, $45B6, $45B6, $45AD
                                        ; DATA XREF: Weapon_UpdateSeekingMissile+F2   r


; Matches sprite position and properties to parent sprite
Sprite_MatchParentPosition:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18E92
                movea.w a5,a0
                btst    #0,(word_FFA000+1).w
                bne.s   loc_18EA2
                suba.w  #$300,a0
                bra.s   loc_18EA6
; ---------------------------------------------------------------------------
loc_18EA2:                              ; CODE XREF: Sprite_MatchParentPosition+8   j
                suba.w  #$360,a0
loc_18EA6:                              ; CODE XREF: Sprite_MatchParentPosition+E   j
                move.w  $48(a5),d0
                cmp.w   (a0),d0
                beq.s Sprite_CopyParentTransform
                move.w  #$40,$10(a5) ; '@'
                rts
; ---------------------------------------------------------------------------
; Copies parent sprite transform data including position and tiles
Sprite_CopyParentTransform:                              ; CODE XREF: Sprite_MatchParentPosition+1A   j  ; was: loc_18EB6
                move.w  $10(a0),d0
                sub.w   $18(a0),d0
                move.w  d0,$10(a5)
                move.w  $14(a0),d0
                sub.w   $1C(a0),d0
                move.w  d0,$14(a5)
                move.w  $E(a0),$E(a5)
                move.w  8(a0),8(a5)
                move.w  $A(a0),$A(a5)
                move.b  $20(a0),$20(a5)
                rts
; End of function Sprite_MatchParentPosition
; Updates projectile seeking movement
Sprite_UpdateSeekingProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18EE8
                subq.w  #1,$5E(a5)
                bmi.s Sprite_HandleProjectileCollision
                bne.s Sprite_UpdateSeekingMotion
                move.b  #$40,$21(a5) ; '@'
; Updates sprite seeking motion with velocity subtraction
Sprite_UpdateSeekingMotion:                              ; CODE XREF: Sprite_UpdateSeekingProjectile+6   j  ; was: loc_18EF6
                move.l  $48(a5),d0
                move.l  $4C(a5),d1
                sub.l   d0,$14(a5)
                sub.l   d1,$10(a5)
; End of function Sprite_UpdateSeekingProjectile
; Handles projectile collision and destruction
Sprite_HandleProjectileCollision:                              ; CODE XREF: Sprite_UpdateSeekingProjectile+4   j  ; was: sub_18F06
                                        ; DATA XREF: ROM:off_5DC   o
                btst    #6,$23(a5)
                bne.s   loc_18F30
                tst.w   $26(a5)
                bpl.s   locret_18F2E
                lea     (dword_2AECC).l,a1
                jsr (Sys_PassObjectAddress).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
locret_18F2E:                           ; CODE XREF: Sprite_HandleProjectileCollision+C   j
                rts
; ---------------------------------------------------------------------------
loc_18F30:                              ; CODE XREF: Sprite_HandleProjectileCollision+6   j
                btst    #4,$23(a5)
                beq.s   loc_18F42
                move.b  #$C8,d0
                jsr (Sound_PlaySFX).l
loc_18F42:                              ; CODE XREF: Sprite_HandleProjectileCollision+30   j
                movea.w a5,a0
                bsr.s   Effect_SpawnExplosion
loc_18F46:                              ; CODE XREF: Weapon_InitProjectileSprite+32   j
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Sprite_HandleProjectileCollision
; Spawns explosion effect with random velocity
Effect_SpawnExplosion:                              ; CODE XREF: Sprite_HandleProjectileCollision+3E   p  ; was: sub_18F58
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (dword_FFFF08).w,d3
                move.b  (dword_FFFF08+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #3,d3
                addq.w  #3,d4
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnExplosion
; Updates bomb projectile with gravity and collision detection
Weapon_UpdateBombProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_18FA6
                btst    #6,$23(a5)
                bne.w   loc_1905C
                tst.w   $26(a5)
                bpl.s   loc_18FD2
                lea     (dword_2AF1E).l,a1
                jsr (Sys_PassObjectAddress).l
                move.w  #$8080,2(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_18FD2:                              ; CODE XREF: Weapon_UpdateBombProjectile+E   j
                subq.w  #1,$5E(a5)
                bpl.s   loc_1901C
                bset    #4,2(a5)
                clr.b   $21(a5)
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                rts
; ---------------------------------------------------------------------------
loc_1901C:                              ; CODE XREF: Weapon_UpdateBombProjectile+30   j
                move.w  #$8080,2(a5)
                move.w  $58(a5),d0
                add.w   (dword_FFA410).w,d0
                move.l  $50(a5),d1
                add.l   $18(a5),d1
                move.l  d1,$50(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$10(a5)
                move.w  $5A(a5),d0
                add.w   (dword_FFA414).w,d0
                move.l  $54(a5),d1
                add.l   $1C(a5),d1
                move.l  d1,$54(a5)
                swap    d1
                add.w   d1,d0
                move.w  d0,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_1905C:                              ; CODE XREF: Weapon_UpdateBombProjectile+6   j
                btst    #4,$23(a5)
                beq.s   loc_1906E
                move.b  #$C8,d0
                jsr (Sound_PlaySFX).l
loc_1906E:                              ; CODE XREF: Weapon_UpdateBombProjectile+BC   j
                movea.w a5,a0
                bsr.s Effect_CreateExplosionDebris
                movea.w a5,a0
                adda.w  #$300,a0
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
; End of function Weapon_UpdateBombProjectile
; Creates explosion debris particles with random velocity
Effect_CreateExplosionDebris:                              ; CODE XREF: Weapon_UpdateBombProjectile+CA   p  ; was: sub_19084
                lea     (dword_2AF48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$8C80,2(a0)
                move.b  (dword_FFFF08).w,d3
                move.b  (dword_FFFF08+1).w,d4
                andi.w  #1,d3
                andi.w  #1,d4
                addq.w  #2,d3
                addq.w  #2,d4
                movea.l #word_1B514,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (a1,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d4,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_CreateExplosionDebris
; Spawns spark particle during player death sequence
Effect_SpawnPlayerDeathSpark:                              ; CODE XREF: Player_HandleInvulnerabilityTimer:loc_16AFC   j  ; was: sub_190D2
                                        ; DATA XREF: ROM:off_5DC   o
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$F,d7
loc_190D8:                              ; CODE XREF: Effect_SpawnPlayerDeathSpark+E   j
                tst.w   (a0)
                beq.s   loc_190E6
                lea     $60(a0),a0
                dbf     d7,loc_190D8
                rts
; ---------------------------------------------------------------------------
loc_190E6:                              ; CODE XREF: Effect_SpawnPlayerDeathSpark+8   j
                move.w  #$7C,(a0) ; '|'
                move.w  #$EC00,2(a0)
                clr.b   $21(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$480,$E(a0)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a0)
                move.l  #off_E9560,8(a0)
                clr.w   $C(a0)
                lea     (word_1B514).l,a1
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  (a1,d0.w),d2
                move.w  d1,$4E(a0)
                move.w  d2,$50(a0)
                ext.l   d1
                ext.l   d2
                asl.l   #5,d1
                asl.l   #5,d2
                move.l  d1,$1C(a0)
                move.l  d2,$18(a0)
                rts
; End of function Effect_SpawnPlayerDeathSpark
; Updates death spark particle motion with deceleration
Effect_UpdateDeathSparkMotion:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19154
                cmpi.w  #$80,$C(a5)
                bmi.s Effect_ApplySparkDeceleration
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
; Applies deceleration to spark particle velocity
Effect_ApplySparkDeceleration:                              ; CODE XREF: Effect_UpdateDeathSparkMotion+6   j  ; was: loc_19164
                move.w  $4E(a5),d0
                move.w  $50(a5),d1
                ext.l   d0
                ext.l   d1
                sub.l   d0,$1C(a5)
                sub.l   d1,$18(a5)
                rts
; End of function Effect_UpdateDeathSparkMotion
; Destroys sprite when timer expires
Sprite_DestroyOnTimeout:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_1917A
                subq.w  #1,$48(a5)
                bpl.s   locret_19186
                bset    #4,2(a5)
locret_19186:                           ; CODE XREF: Sprite_DestroyOnTimeout+4   j
                rts
; End of function Sprite_DestroyOnTimeout
; Initializes projectile sprite with position and velocity
Sprite_InitProjectile:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19188
                bset    #7,2(a5)
                cmpi.l  #word_E8EBA,(dword_FFA408).w
                beq.s   loc_1919E
                bclr    #7,2(a5)
loc_1919E:                              ; CODE XREF: Sprite_InitProjectile+E   j
                move.w  (dword_FFA410).w,$10(a5)
                move.w  (dword_FFA414).w,$14(a5)
                bclr    #7,$22(a5)
                beq.s   loc_191B8
                move.w  #4,(word_FF813C).w
loc_191B8:                              ; CODE XREF: Sprite_InitProjectile+28   j
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$B,d7
                jsr (Sys_FindFreeObjectSlot).l
                bne.w   locret_19230
                move.l  #off_E9584,8(a0)
                jsr (Sprite_InitializeProperties).l
                move.b  $20(a5),$20(a0)
                lea     (word_1B514).l,a1
                move.w  (word_FFA000).w,d0
                asl.w   #5,d0
                andi.w  #$1FE,d0
                move.w  -$80(a1,d0.w),d1
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a0)
                swap    d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_19208
                neg.w   d1
                neg.l   $1C(a0)
loc_19208:                              ; CODE XREF: Sprite_InitProjectile+78   j
                add.w   $14(a5),d1
                move.w  d1,$14(a0)
                move.w  $10(a5),$10(a0)
                tst.w   (word_FFA448).w
                bmi.s   loc_19226
                move.l  #$FFF60000,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_19226:                              ; CODE XREF: Sprite_InitProjectile+92   j
                move.l  #$A0000,$18(a0)
                rts
; ---------------------------------------------------------------------------
locret_19230:                           ; CODE XREF: Sprite_InitProjectile+3C   j
                rts
; End of function Sprite_InitProjectile
; Increments frame and checks lifetime
Sprite_AnimateAndExpire:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_19232
                addq.w  #1,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   locret_19242
                bset    #4,2(a5)
locret_19242:                           ; CODE XREF: Sprite_AnimateAndExpire+8   j
                rts
; End of function Sprite_AnimateAndExpire
; Clears memory block for system reset operations
Memory_ClearBlock:                              ; CODE XREF: Player_HandleDeathSequence+16   p  ; was: sub_19244
                                        ; Player_InitKnockbackState+12   p ...
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$10,d7
                bra.s Sys_ClearMemoryBlock
; End of function Memory_ClearBlock
; Clears object buffer at FFBFC0 with 16 iterations
Sys_ClearObjectBufferSmall:                              ; CODE XREF: Player_HandleJump+72   p  ; was: sub_1924C
                                        ; Player_InitDeathKnockback+A   p ...
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$F,d7
                bra.s Sys_ClearMemoryBlock
; End of function Sys_ClearObjectBufferSmall
; Clears 8 projectile slots
Sys_ClearProjectileBuffer:
                movea.w #(dword_FFBFC0-M68K_RAM),a0  ; was: sub_19254
                moveq   #7,d7
; End of function Sys_ClearProjectileBuffer
; Clears memory block with unrolled 96-byte loop per iteration
Sys_ClearMemoryBlock:                              ; CODE XREF: Player_InitSpecialAttack+46   p  ; was: sub_1925A
                                        ; Memory_ClearBlock+6   j ...
                moveq   #0,d0
loc_1925C:                              ; CODE XREF: Sys_ClearMemoryBlock+32   j
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                dbf     d7,loc_1925C
                rts
; End of function Sys_ClearMemoryBlock
; Renders targeting reticle sprite over locked enemy target
UI_RenderTargetingReticle:                              ; CODE XREF: UI_CalculateHealthBarSegments+22   j  ; was: sub_19292
                                        ; sub_17C7C:loc_17CB0   j
                subq.w  #1,(word_FF8642).w
                bpl.s   locret_192CE
loc_19298:                              ; CODE XREF: UI_ProcessTargetingSystem+7E   j
                clr.w   (word_FF8642).w
                moveq   #0,d6
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #7,d7
loc_192A4:                              ; CODE XREF: UI_RenderTargetingReticle+1A   j
                tst.w   (a0)
                bne.s   loc_192C8
                lea     $60(a0),a0
                dbf     d7,loc_192A4
                move.w  (word_FF8D7A).w,d7
                bmi.s   locret_192CE
                movea.w #(byte_FF8E80-M68K_RAM),a1
loc_192BA:                              ; CODE XREF: UI_RenderTargetingReticle+32   j
                movea.w (a1)+,a0
                btst    #7,$23(a0)
                bne.s UI_CalculateReticlePosition
                dbf     d7,loc_192BA
loc_192C8:                              ; CODE XREF: UI_RenderTargetingReticle+14   j
                move.w  #$80,(word_FF8642).w
locret_192CE:                           ; CODE XREF: UI_RenderTargetingReticle+4   j
                                        ; UI_RenderTargetingReticle+22   j ...
                rts
; ---------------------------------------------------------------------------
; Calculates targeting reticle sprite position from enemy hitbox
UI_CalculateReticlePosition:                              ; CODE XREF: UI_ProcessTargetingSystem+84   j  ; was: loc_192D0
                                        ; UI_RenderTargetingReticle+30   j
                cmpi.w  #$160,$14(a0)
                bpl.w   locret_192CE
                cmpi.w  #$A0,$14(a0)
                bmi.w   locret_192CE
                cmpi.w  #$1C0,$10(a0)
                bpl.w   locret_192CE
                cmpi.w  #$80,$10(a0)
                bmi.w   locret_192CE
                move.b  $28(a0),d0
                ext.w   d0
                move.b  $29(a0),d1
                ext.w   d1
                add.w   d1,d0
                add.w   $14(a0),d0
                move.w  d0,d1
                move.b  $2A(a0),d2
                ext.w   d2
                move.b  $2B(a0),d3
                ext.w   d3
                add.w   d3,d2
                add.w   $10(a0),d2
                move.w  d2,d3
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  (word_FFA000).w,d4
                andi.w  #7,d4
                asl.w   #1,d4
                neg.w   d4
                addi.w  #$1A,d4
                add.w   d4,d0
                subq.w  #8,d0
                sub.w   d4,d1
                subq.w  #8,d1
                add.w   d4,d2
                subq.w  #8,d2
                sub.w   d4,d3
                subq.w  #8,d3
                move.w  #$500,d4
                move.w  d1,(a1)+
                move.w  d4,(a1)+
                move.w  #$C6FC,(a1)+
                move.w  d3,(a1)+
                move.w  d0,(a1)+
                move.w  d4,(a1)+
                move.w  #$DEFC,(a1)+
                move.w  d2,(a1)+
                move.w  d1,(a1)+
                move.w  d4,(a1)+
                move.w  #$CEFC,(a1)+
                move.w  d2,(a1)+
                move.w  d0,(a1)+
                move.w  d4,(a1)+
                move.w  #$D6FC,(a1)+
                move.w  d3,(a1)+
                move.w  #$FFFF,(a1)+
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function UI_RenderTargetingReticle
; ---------------------------------------------------------------------------
                dc.l dword_193B2
                dc.l dword_193B2
                dc.l dword_193B2
                dc.l dword_193B2
off_1938E:      dc.l dword_193B2        ; DATA XREF: UI_ProcessWeaponState+8   o
                dc.l dword_19452
                dc.l dword_194F2
                dc.l dword_19592
                dc.l dword_19632
                dc.l dword_196D2
                dc.l dword_19772
                dc.l dword_19812
                dc.l dword_19812
dword_193B2:    dc.l 0, $12BA0, $24BB8, $35550, $43E18
                                        ; DATA XREF: Effect_SpawnRandomDebris+76   o
                                        ; ROM:0001937E   o ...
                dc.l $4FD10, $58B00, $5E278, $60000, $5E278
                dc.l $58B00, $4FD10, $43E18, $35550, $24BB8
                dc.l $12BA0, $FFFFFFE8, $FFFED460, $FFFDB448, $FFFCAAB0
                dc.l $FFFBC1E8, $FFFB02F0, $FFFA7500, $FFFA1D88, $FFFA0000
                dc.l $FFFA1D88, $FFFA7500, $FFFB02F0, $FFFBC1E8, $FFFCAAB0
                dc.l $FFFDB448, $FFFED460, 0, $12BA0, $24BB8
                dc.l $35550, $43E18, $4FD10, $58B00, $5E278
dword_19452:    dc.l 0, $15D90, $2ADAC, $3E388, $4F31C
                                        ; DATA XREF: ROM:00019392   o
                dc.l $5D1E8, $67780, $6DD8C, $70000, $6DD8C
                dc.l $67780, $5D1E8, $4F31C, $3E388, $2ADAC
                dc.l $15D90, $FFFFFFE4, $FFFEA270, $FFFD5254, $FFFC1C78
                dc.l $FFFB0CE4, $FFFA2E18, $FFF98880, $FFF92274, $FFF90000
                dc.l $FFF92274, $FFF98880, $FFFA2E18, $FFFB0CE4, $FFFC1C78
                dc.l $FFFD5254, $FFFEA270, 0, $15D90, $2ADAC
                dc.l $3E388, $4F31C, $5D1E8, $67780, $6DD8C
dword_194F2:    dc.l 0, $18F80, $30FA0, $471C0, $5A820
                                        ; DATA XREF: ROM:00019396   o
                dc.l $6A6C0, $76400, $7D8A0, $80000, $7D8A0
                dc.l $76400, $6A6C0, $5A820, $471C0, $30FA0
                dc.l $18F80, $FFFFFFE0, $FFFE7080, $FFFCF060, $FFFB8E40
                dc.l $FFFA57E0, $FFF95940, $FFF89C00, $FFF82760, $FFF80000
                dc.l $FFF82760, $FFF89C00, $FFF95940, $FFFA57E0, $FFFB8E40
                dc.l $FFFCF060, $FFFE7080, 0, $18F80, $30FA0
                dc.l $471C0, $5A820, $6A6C0, $76400, $7D8A0
dword_19592:    dc.l 0, $1C170, $37194, $4FFF8, $65D24
                                        ; DATA XREF: ROM:0001939A   o
                dc.l $77B98, $85080, $8D3B4, $90000, $8D3B4
                dc.l $85080, $77B98, $65D24, $4FFF8, $37194
                dc.l $1C170, $FFFFFFDC, $FFFE3E90, $FFFC8E6C, $FFFB0008
                dc.l $FFF9A2DC, $FFF88468, $FFF7AF80, $FFF72C4C, $FFF70000
                dc.l $FFF72C4C, $FFF7AF80, $FFF88468, $FFF9A2DC, $FFFB0008
                dc.l $FFFC8E6C, $FFFE3E90, 0, $1C170, $37194
                dc.l $4FFF8, $65D24, $77B98, $85080, $8D3B4
dword_19632:    dc.l 0, $1F360, $3D388, $58E30, $71228
                                        ; DATA XREF: Weapon_FireMultipleShots+46   o
                                        ; Player_SpawnCircleAttack+A2   o ...
                dc.l $85070, $93D00, $9CEC8, $A0000, $9CEC8
                dc.l $93D00, $85070, $71228, $58E30, $3D388
                dc.l $1F360, $FFFFFFD8, $FFFE0CA0, $FFFC2C78, $FFFA71D0
                dc.l $FFF8EDD8, $FFF7AF90, $FFF6C300, $FFF63138, $FFF60000
                dc.l $FFF63138, $FFF6C300, $FFF7AF90, $FFF8EDD8, $FFFA71D0
                dc.l $FFFC2C78, $FFFE0CA0, 0, $1F360, $3D388
                dc.l $58E30, $71228, $85070, $93D00, $9CEC8
dword_196D2:    dc.l 0, $22550, $4357C, $61C68, $7C72C
                                        ; DATA XREF: ROM:000193A2   o
                dc.l $92548, $A2980, $AC9DC, $B0000, $AC9DC
                dc.l $A2980, $92548, $7C72C, $61C68, $4357C
                dc.l $22550, $FFFFFFD4, $FFFDDAB0, $FFFBCA84, $FFF9E398
                dc.l $FFF838D4, $FFF6DAB8, $FFF5D680, $FFF53624, $FFF50000
                dc.l $FFF53624, $FFF5D680, $FFF6DAB8, $FFF838D4, $FFF9E398
                dc.l $FFFBCA84, $FFFDDAB0, 0, $22550, $4357C
                dc.l $61C68, $7C72C, $92548, $A2980, $AC9DC
dword_19772:    dc.l 0, $25740, $49770, $6AAA0, $87C30
                                        ; DATA XREF: UI_UpdateWeaponGaugeSprite+C   o
                                        ; Weapon_SpawnHomingEffect+74   o ...
                dc.l $9FA20, $B1600, $BC4F0, $C0000, $BC4F0
                dc.l $B1600, $9FA20, $87C30, $6AAA0, $49770
                dc.l $25740, $FFFFFFD0, $FFFDA8C0, $FFFB6890, $FFF95560
                dc.l $FFF783D0, $FFF605E0, $FFF4EA00, $FFF43B10, $FFF40000
                dc.l $FFF43B10, $FFF4EA00, $FFF605E0, $FFF783D0, $FFF95560
                dc.l $FFFB6890, $FFFDA8C0, 0, $25740, $49770
                dc.l $6AAA0, $87C30, $9FA20, $B1600, $BC4F0
dword_19812:    dc.l 0, $28930, $4F964, $738D8, $93134
                                        ; DATA XREF: Enemy_CalculateVelocityFromPlayer+70   o
                                        ; Weapon_FireProjectile+AE   o ...
                dc.l $ACEF8, $C0280, $CC004, $D0000, $CC004
                dc.l $C0280, $ACEF8, $93134, $738D8, $4F964
                dc.l $28930, $FFFFFFCC, $FFFD76D0, $FFFB069C, $FFF8C728
                dc.l $FFF6CECC, $FFF53108, $FFF3FD80, $FFF33FFC, $FFF30000
                dc.l $FFF33FFC, $FFF3FD80, $FFF53108, $FFF6CECC, $FFF8C728
                dc.l $FFFB069C, $FFFD76D0, 0, $28930, $4F964
                dc.l $738D8, $93134, $ACEF8, $C0280, $CC004
word_198B2:     dc.w $E2E8, $F4E8, $E2E6, $FCE6, $ECFC, $1FC, $ECDA, $D2DA
                                        ; DATA XREF: Player_HandleSpecialAttack:loc_16086   o
                                        ; sub_16116:loc_16146   o ...
word_198C2:     dc.w $E2E8, $F4E8, $E2E6, $FCE6, $FD0D, $120D, $FDEB, $E3EB
                                        ; DATA XREF: Player_RenderWithWeapon+4A   o
word_198D2:     dc.w $E6F2, $FAF2, $E6EC, $FCEC, $ECFC, $1FC, $ECDA, $D2DA
                                        ; DATA XREF: Player_HandleFallingState+14E   o
                                        ; sub_17086:loc_170A6   o ...
word_198E2:     dc.w $E6F2, $FAF2, $E6EC, $FCEC, $FD0D, $120D, $FDEB, $E3EB
                                        ; DATA XREF: Player_RenderWithWeapon:loc_1711E   o
word_198F2:     dc.w $E2E6, $FCE6, $E2E8, $F4E8, $1226, $2E26, $1204, 4
                                        ; DATA XREF: Player_RenderWeaponSprite+6   o
                                        ; Player_UpdateDashSprite+6   o
word_19902:     dc.w $E2E6, $FCE6, $E2E8, $F4E8, $115, $1D15, $1F3, $EFF3
                                        ; DATA XREF: Player_RenderWithWeapon+E   o
word_19912:     dc.w $E6EC, $FCEC, $E6F2, $FAF2, $1226, $2E26, $1204, 4
                                        ; DATA XREF: Player_UpdateDashSprite:loc_17072   o
                                        ; Player_RenderWithWeapon+82   o ...
word_19922:     dc.w $E6EC, $FCEC, $E6F2, $FAF2, $115, $1D15, $1F3, $EFF3
                                        ; DATA XREF: Player_RenderWithWeapon:loc_170E2   o
off_19932:      dc.l sprite_FDF0E         ; DATA XREF: ROM:off_186A0   o
                dc.l sprite_FDE8E
                dc.l sprite_FDE0E
                dc.l sprite_FDD8E
                dc.l sprite_FDD0E
                dc.l sprite_FDC8E
                dc.l sprite_FDC0E
                dc.l sprite_FDB8E
off_19952:      dc.l sprite_FE30E         ; DATA XREF: ROM:000186A8   o
                dc.l sprite_FE28E
                dc.l sprite_FE20E
                dc.l sprite_FE18E
                dc.l sprite_FE10E
                dc.l sprite_FE08E
                dc.l sprite_FE00E
                dc.l sprite_FDF8E
off_19972:      dc.l sprite_FE70E         ; DATA XREF: ROM:000186A4   o
                                        ; ROM:000186AC   o
                dc.l sprite_FE68E
                dc.l sprite_FE60E
                dc.l sprite_FE58E
                dc.l sprite_FE50E
                dc.l sprite_FE48E
                dc.l sprite_FE40E
                dc.l sprite_FE38E


; Processes all active projectile objects
Sys_ProcessProjectiles:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C750   p  ; was: sub_19992
                                        ; Stage_UpdateGameplay+12   p ...
                tst.b   (byte_FF813E).w
                bmi.w   locret_199F2
                lea     (dword_FFBFC0).w,a5
loc_1999E:                              ; CODE XREF: Sys_ProcessProjectiles+5E   j
                move.w  (a5),d0
                beq.s Sys_AdvanceProjectilePointer
                movea.w d0,a0
                movea.l off_5DC(a0),a0
                jsr     (a0)
                btst    #4,2(a5)
                bne.s   loc_199D6
                btst    #1,2(a5)
                beq.s   loc_199DE
                move.w  $10(a5),d0
                subi.w  #$70,d0 ; 'p'
                cmpi.w  #$160,d0
                bhi.s   loc_199D6
                move.w  $14(a5),d0
                subi.w  #$40,d0 ; '@'
                cmpi.w  #$130,d0
                bls.s   loc_199DE
loc_199D6:                              ; CODE XREF: Sys_ProcessProjectiles+1E   j
                                        ; Sys_ProcessProjectiles+34   j
                jsr (Sys_ClearObjectSlot).l
                bra.s Sys_AdvanceProjectilePointer
; ---------------------------------------------------------------------------
loc_199DE:                              ; CODE XREF: Sys_ProcessProjectiles+26   j
                                        ; Sys_ProcessProjectiles+42   j
                movea.w (word_FFF758).w,a0
                move.w  a5,(a0)+
                move.w  a0,(word_FFF758).w
; Advances projectile array pointer to next slot in loop
Sys_AdvanceProjectilePointer:                              ; CODE XREF: Sys_ProcessProjectiles+E   j  ; was: loc_199E8
                                        ; Sys_ProcessProjectiles+4A   j
                lea     $60(a5),a5
                cmpa.w  #$C620,a5
                bcs.s   loc_1999E
locret_199F2:                           ; CODE XREF: Sys_ProcessProjectiles+4   j
                rts
; End of function Sys_ProcessProjectiles
; Merges button state from buffer into main register
Input_MergeButtonState:                              ; CODE XREF: Player_Update+14   p  ; was: sub_199F4
                bsr.s Input_ClearAndDispatch
                move.b  $6A(a5),d0
                or.b    d0,$69(a5)
                subq.w  #1,(word_FF813A).w
                bpl.s   locret_19A0E
                move.w  #$FFFF,(word_FF813A).w
                clr.w   (word_FF8138).w
locret_19A0E:                           ; CODE XREF: Input_MergeButtonState+E   j
                rts
; End of function Input_MergeButtonState
; Clears button state and dispatches input handler
Input_ClearAndDispatch:                              ; CODE XREF: Input_MergeButtonState   p  ; was: sub_19A10
                clr.b   $69(a5)
                clr.b   $6A(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,(word_FF8652).w
                move.w  (word_FFA02A).w,d0
                movea.w off_19A34(pc,d0.w),a0
                adda.l  #Stage_InitCutscene,a0
                jmp     (a0)
; End of function Input_ClearAndDispatch
; ---------------------------------------------------------------------------
off_19A34:      dc.w Stage_CutsceneWaitStart_Return-Stage_InitCutscene
                                        ; DATA XREF: Input_ClearAndDispatch+18   r
                dc.w Stage_InitCutscene-Stage_InitCutscene
                dc.w Cutscene_InitializeParams-Stage_InitCutscene
                dc.w Stage_CutsceneWaitStart-Stage_InitCutscene
                dc.w Stage_CutsceneTimerWait-Stage_InitCutscene
                dc.w Stage_CutsceneCheckPosition-Stage_InitCutscene
                dc.w Stage_CutscenePlayAnim-Stage_InitCutscene
                dc.w Stage_CutsceneReachPosition-Stage_InitCutscene
                dc.w Cutscene_InitStagePause-Stage_InitCutscene
                dc.w Input_SetButtonFlag-Stage_InitCutscene
                dc.w Stage_CutsceneWaitStart_Return-Stage_InitCutscene
                dc.w Player_FlyingNeoIntro-Stage_InitCutscene
                dc.w Player_CheckBossIntroCondition-Stage_InitCutscene
                dc.w Cutscene_FlyingNeoIntro-Stage_InitCutscene
                dc.w Cutscene_FlyingNeoIntro_ScrollDown-Stage_InitCutscene
                dc.w Cutscene_ScrollCameraLeft-Stage_InitCutscene
                dc.w Player_XiTigerBossIntro-Stage_InitCutscene
                dc.w Enemy_Stage14DebrisMain-Stage_InitCutscene
                dc.w Stage_CutsceneWaitStart-Stage_InitCutscene
                dc.w Stage_CutsceneTimerWait-Stage_InitCutscene
                dc.w Enemy_Stage14DebrisInit-Stage_InitCutscene
                dc.w Enemy_Stage14DebrisAnimate-Stage_InitCutscene
                dc.w Cutscene_InitFastPause-Stage_InitCutscene
                dc.w Cutscene_CheckBossFlag-Stage_InitCutscene
                dc.w Player_ViblackIntro-Stage_InitCutscene
                dc.w Cutscene_JampanInitParams-Stage_InitCutscene
                dc.w Boss_SireneShootPattern2-Stage_InitCutscene
                dc.w Cutscene_Stage20ClearFlag-Stage_InitCutscene


; Initializes stage cutscene setting player position and state
Stage_InitCutscene:                              ; DATA XREF: Input_ClearAndDispatch+1C   o  ; was: sub_19A6C
                                        ; ROM:off_19A34   o ...
                move.w  #$1BF8,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                rts
; End of function Stage_InitCutscene
; Initializes cutscene parameters for transition
Cutscene_InitializeParams:                              ; DATA XREF: ROM:00019A38   o  ; was: sub_19A90
                move.w  #$12C0,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                rts
; End of function Cutscene_InitializeParams
; Cutscene parameter initialization
Cutscene_JampanInitParams:                              ; DATA XREF: ROM:00019A66   o  ; was: sub_19AB4
                move.w  #$1640,(word_FF8646).w
                move.w  #$16,(word_FF8648).w
                move.w  #6,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function Cutscene_JampanInitParams
; Stage 14 debris handler
Enemy_Stage14DebrisMain:                              ; DATA XREF: ROM:00019A56   o  ; was: sub_19AE4
                move.w  #$690,(word_FF8646).w
                addq.w  #2,(word_FFA02A).w
                clr.b   (byte_FFF705).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                rts
; End of function Enemy_Stage14DebrisMain
; Sets player state timer to 32
Player_SetStateTimer:                              ; CODE XREF: Stage_CutsceneWaitStart+6   j  ; was: sub_19B0C
                                        ; Player_FlyingNeoIntro+2A   j
                move.b  #$20,$6A(a5) ; ' '
                rts
; End of function Player_SetStateTimer
; Waits for button press then advances cutscene state
Stage_CutsceneWaitStart:                              ; DATA XREF: ROM:00019A3A   o  ; was: sub_19B14
                                        ; ROM:00019A58   o
                btst    #6,(byte_FF8244).w
                bne.s Player_SetStateTimer
                tst.b   (byte_FF8244).w
                bne.s Stage_CutsceneWaitStart_Return
                addq.w  #2,(word_FFA02A).w
                move.w  #$20,(word_FF8644).w ; ' '
                bset    #3,$E(a5)
; Return from cutscene wait start
Stage_CutsceneWaitStart_Return:                           ; CODE XREF: Stage_CutsceneWaitStart+C   j  ; was: locret_19B32
                                        ; Player_FlyingNeoIntro+36   j ...
                rts
; End of function Stage_CutsceneWaitStart
; Waits for timer countdown before cutscene continuation
Stage_CutsceneTimerWait:                              ; DATA XREF: ROM:00019A3C   o  ; was: sub_19B34
                                        ; ROM:00019A5A   o
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19B3E
                addq.w  #2,(word_FFA02A).w
locret_19B3E:                           ; CODE XREF: Stage_CutsceneTimerWait+4   j
                rts
; End of function Stage_CutsceneTimerWait
; Checks player position against scroll target for cutscene advance
Stage_CutsceneCheckPosition:                              ; DATA XREF: ROM:00019A3E   o  ; was: sub_19B40
                btst    #1,(byte_FFA407).w
                beq.s   loc_19B56
                move.w  #$10,(word_FFA02A).w
                move.b  #$20,$6A(a5) ; ' '
                rts
; ---------------------------------------------------------------------------
loc_19B56:                              ; CODE XREF: Stage_CutsceneCheckPosition+6   j
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   locret_19B7E
                move.w  (word_FF8646).w,d0
                cmp.w   (word_FF8652).w,d0
                bpl.s   locret_19B7E
                addq.w  #2,(word_FFA02A).w
                move.b  #$20,$6A(a5) ; ' '
                move.w  (word_FF8648).w,(word_FF8644).w
locret_19B7E:                           ; CODE XREF: Stage_CutsceneCheckPosition+22   j
                                        ; Stage_CutsceneCheckPosition+2C   j
                rts
; End of function Stage_CutsceneCheckPosition
; Plays cutscene animation setting sprite states and flags
Stage_CutscenePlayAnim:                              ; DATA XREF: ROM:00019A40   o  ; was: sub_19B80
                move.b  #$28,$69(a5) ; '('
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19BAE
                addq.w  #2,(word_FFA02A).w
                move.b  #$2A,$69(a5) ; '*'
                move.b  #$20,$6A(a5) ; ' '
                bset    #1,(byte_FF8245).w
                bset    #0,(byte_FF8245).w
                bset    #7,(byte_FF8245).w
locret_19BAE:                           ; CODE XREF: Stage_CutscenePlayAnim+A   j
                rts
; End of function Stage_CutscenePlayAnim
; Handles player reaching target position in cutscene
Stage_CutsceneReachPosition:                              ; DATA XREF: ROM:00019A42   o  ; was: sub_19BB0
                bclr    #5,$6A(a5)
                move.b  #$28,$69(a5) ; '('
                cmpi.w  #$200,$10(a5)
                bmi.s   locret_19BD2
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (word_FF8138).w
locret_19BD2:                           ; CODE XREF: Stage_CutsceneReachPosition+12   j
                rts
; End of function Stage_CutsceneReachPosition
; Initializes cutscene timers
Cutscene_InitStagePause:                              ; DATA XREF: ROM:00019A44   o  ; was: sub_19BD4
                move.b  #$28,$69(a5) ; '('
                btst    #6,(byte_FF8244).w
                beq.s   loc_19BE8
                move.b  #$28,$6A(a5) ; '('
loc_19BE8:                              ; CODE XREF: Cutscene_InitStagePause+C   j
                tst.b   (byte_FF8244).w
                bne.s   locret_19BF4
                move.w  #$A,(word_FFA02A).w
locret_19BF4:                           ; CODE XREF: Cutscene_InitStagePause+18   j
                rts
; End of function Cutscene_InitStagePause
; Initializes debris
Enemy_Stage14DebrisInit:                              ; DATA XREF: ROM:00019A5C   o  ; was: sub_19BF6
                btst    #1,(byte_FFA407).w
                beq.s   loc_19C0C
                move.w  #$2C,(word_FFA02A).w ; ','
                move.b  #$20,$6A(a5) ; ' '
                rts
; ---------------------------------------------------------------------------
loc_19C0C:                              ; CODE XREF: Enemy_Stage14DebrisInit+6   j
                move.b  #8,$69(a5)
                btst    #0,(byte_FF8244).w
                bne.s   locret_19C2E
                move.w  (word_FF8646).w,d0
                cmp.w   (word_FF8652).w,d0
                bpl.s   locret_19C2E
                addq.w  #2,(word_FFA02A).w
                move.b  #$22,$6A(a5) ; '"'
locret_19C2E:                           ; CODE XREF: Enemy_Stage14DebrisInit+22   j
                                        ; Enemy_Stage14DebrisInit+2C   j
                rts
; End of function Enemy_Stage14DebrisInit
; Animates debris
Enemy_Stage14DebrisAnimate:                              ; DATA XREF: ROM:00019A5E   o  ; was: sub_19C30
                cmpi.w  #$200,$10(a5)
                bmi.s   locret_19C46
                move.w  #$200,$10(a5)
                clr.w   2(a5)
                clr.w   (word_FF8138).w
locret_19C46:                           ; CODE XREF: Enemy_Stage14DebrisAnimate+6   j
                rts
; End of function Enemy_Stage14DebrisAnimate
; Sets short timer for fast transition
Cutscene_InitFastPause:                              ; DATA XREF: ROM:00019A60   o  ; was: sub_19C48
                move.b  #$28,$69(a5) ; '('
                btst    #0,(byte_FF8244).w
                bne.s   locret_19C5C
                move.w  #$28,(word_FFA02A).w ; '('
locret_19C5C:                           ; CODE XREF: Cutscene_InitFastPause+C   j
                rts
; End of function Cutscene_InitFastPause
; Player intro state for Flying-Neo boss battle
Player_FlyingNeoIntro:                              ; DATA XREF: ROM:00019A4A   o  ; was: sub_19C5E
                addq.w  #2,(word_FFA02A).w
                move.w  #2,(word_FF8138).w
                move.w  #$100,(word_FF813A).w
                bset    #4,(byte_FF8245).w
                btst    #4,$E(a5)
                beq.s Player_CheckBossIntroCondition
                move.b  #$20,$6A(a5) ; ' '
; Checks boss intro cutscene trigger conditions
Player_CheckBossIntroCondition:                              ; CODE XREF: Player_FlyingNeoIntro+1C   j  ; was: loc_19C82
                                        ; DATA XREF: ROM:00019A4C   o
                btst    #6,(byte_FF8244).w
                bne.w Player_SetStateTimer
                move.w  #$1040,d0
                bsr.w Player_CheckHorizontalDistance
                bne.w Stage_CutsceneWaitStart_Return
                tst.b   (byte_FF8244).w
                bne.w Stage_CutsceneWaitStart_Return
                clr.w   (word_FF8138).w
                rts
; End of function Player_FlyingNeoIntro
; Cutscene parameters for Flying-Neo boss intro
Cutscene_FlyingNeoIntro:                              ; DATA XREF: ROM:00019A4E   o  ; was: sub_19CA6
                addq.w  #2,(word_FFA02A).w
                move.w  #2,(word_FF8138).w
                move.w  #$200,(word_FF813A).w
                bset    #0,(byte_FF8245).w
                bset    #5,(byte_FF8245).w
                move.w  #$148,$10(a5)
                bclr    #3,$E(a5)
                move.w  #$8000,(word_FF808A).w
                bset    #3,$E(a5)
                move.b  #$20,$6A(a5) ; ' '
                bclr    #0,2(a5)
                move.w  #$E,(word_FF8648).w
; Scrolls camera down during Flying Neo intro cutscene
Cutscene_FlyingNeoIntro_ScrollDown:                              ; DATA XREF: ROM:00019A50   o  ; was: loc_19CEC
                subi.l  #$28000,$10(a5)
                move.b  #$20,$69(a5) ; ' '
                subq.w  #1,(word_FF8648).w
                bmi.s   loc_19D0A
                move.l  #$FFF90000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_19D0A:                              ; CODE XREF: Cutscene_FlyingNeoIntro+58   j
                tst.l   $1C(a5)
                bmi.w Stage_CutsceneWaitStart_Return
                bset    #0,2(a5)
                addq.w  #2,(word_FFA02A).w
                clr.b   (byte_FF8245).w
; Scrolls camera horizontally during boss intro cutscene
Cutscene_ScrollCameraLeft:                              ; DATA XREF: ROM:00019A52   o  ; was: loc_19D20
                subi.l  #$28000,$10(a5)
                tst.b   (byte_FF8244).w
                bne.w Stage_CutsceneWaitStart_Return
                clr.w   (word_FFA02A).w
                clr.w   (word_FF8138).w
                move.l  #$FFFEE000,(dword_FF8240).w
                rts
; End of function Cutscene_FlyingNeoIntro
; Player intro state for Xi-Tiger boss
Player_XiTigerBossIntro:                              ; DATA XREF: ROM:00019A54   o  ; was: sub_19D42
                subq.w  #1,(word_FF8644).w
                bpl.s   locret_19D4C
                clr.w   (word_FFA02A).w
locret_19D4C:                           ; CODE XREF: Player_XiTigerBossIntro+4   j
                rts
; End of function Player_XiTigerBossIntro
; Player setup for Viblack intro
Player_ViblackIntro:                              ; DATA XREF: ROM:00019A64   o  ; was: sub_19D4E
                tst.w   (word_FF80E6).w
                bne.s   locret_19D5A
                move.w  #$48,(word_FFA404).w ; 'H'
locret_19D5A:                           ; CODE XREF: Player_ViblackIntro+4   j
                rts
; End of function Player_ViblackIntro
; Sets specific button flag in state register
Input_SetButtonFlag:                              ; DATA XREF: ROM:00019A46   o  ; was: sub_19D5C
                move.b  #$10,$69(a5)
                rts
; End of function Input_SetButtonFlag
; Shooting pattern 2
Boss_SireneShootPattern2:                              ; DATA XREF: ROM:00019A68   o  ; was: sub_19D64
                bset    #3,$E(a5)
                bra.s Cutscene_CheckBossFlag
; End of function Boss_SireneShootPattern2
; Clears cutscene flag
Cutscene_Stage20ClearFlag:                              ; DATA XREF: ROM:00019A6A   o  ; was: sub_19D6C
                bclr    #3,$E(a5)
; End of function Cutscene_Stage20ClearFlag
; Checks boss flag and sets timer
Cutscene_CheckBossFlag:                              ; CODE XREF: Boss_SireneShootPattern2+6   j  ; was: sub_19D72
                                        ; DATA XREF: ROM:00019A62   o
                btst    #6,(byte_FF8244).w
                beq.s   locret_19D80
                move.b  #$21,$6A(a5) ; '!'
locret_19D80:                           ; CODE XREF: Cutscene_CheckBossFlag+6   j
                rts
; End of function Cutscene_CheckBossFlag
; Checks horizontal distance setting movement direction
Player_CheckHorizontalDistance:                              ; CODE XREF: Player_FlyingNeoIntro+32   p  ; was: sub_19D82
                sub.w   (word_FF8652).w,d0
                move.w  d0,d1
                bpl.s   loc_19D8C
                neg.w   d0
loc_19D8C:                              ; CODE XREF: Player_CheckHorizontalDistance+6   j
                cmpi.w  #6,d0
                bpl.s   loc_19D96
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_19D96:                              ; CODE XREF: Player_CheckHorizontalDistance+E   j
                move.w  d1,d1
                bmi.s   loc_19DA4
                bset    #3,$69(a5)
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_19DA4:                              ; CODE XREF: Player_CheckHorizontalDistance+16   j
                bset    #2,$69(a5)
                moveq   #1,d0
                rts
; End of function Player_CheckHorizontalDistance
; Spawns projectile type 1
Boss_SylpheedSpawnProjectile1:                              ; CODE XREF: Player_Update+46   j  ; was: sub_19DAE
                                        ; sub_1A274   p
                jsr (Gfx_LoadPlayerPaletteData).l
                jsr (Input_ProcessDirectionInput).l
                bclr    #6,$22(a5)
                beq.s   loc_19DC8
                bsr.w Boss_DestroyerProtoDefeatInit
                bra.s   loc_19DD2
; ---------------------------------------------------------------------------
loc_19DC8:                              ; CODE XREF: Boss_SylpheedSpawnProjectile1+12   j
                jsr (Player_UpdateWeaponSwitchTimer).l
                bsr.w Boss_SylpheedSpawnProjectile2
loc_19DD2:                              ; CODE XREF: Boss_SylpheedSpawnProjectile1+18   j
                tst.w   $1C(a5)
                bmi.s   loc_19DE4
                cmpi.w  #$158,$14(a5)
                bmi.s   loc_19DE4
                clr.l   $1C(a5)
loc_19DE4:                              ; CODE XREF: Boss_SylpheedSpawnProjectile1+28   j
                                        ; Boss_SylpheedSpawnProjectile1+30   j
                jsr (Player_UpdateDirectionBit).l
                move.b  $69(a5),$6B(a5)
                jsr (Player_UpdateInvulnerabilityTimer).l
                jsr (Player_SetHitbox).l
                clr.b   (byte_FF8311).w
                jmp Player_CalculateCenterPosition
; End of function Boss_SylpheedSpawnProjectile1
; Spawns projectile type 2
Boss_SylpheedSpawnProjectile2:                              ; CODE XREF: Boss_SylpheedSpawnProjectile1+20   p  ; was: sub_19E06
                move.w  4(a5),d0
                movea.w off_19E16(pc,d0.w),a0
                adda.l  #Boss_SylpheedSpawnProjectile3,a0
                jmp     (a0)
; End of function Boss_SylpheedSpawnProjectile2
; ---------------------------------------------------------------------------
off_19E16:      dc.w Boss_SylpheedSpawnProjectile4-Boss_SylpheedSpawnProjectile3
                                        ; DATA XREF: Boss_SylpheedSpawnProjectile2+4   r
                dc.w Projectile_SylpheedBullet2-Boss_SylpheedSpawnProjectile3
                dc.w Boss_SylpheedCollisionCheck-Boss_SylpheedSpawnProjectile3
                dc.w Gfx_LoadArtemisPalette-Boss_SylpheedSpawnProjectile3
                dc.w Boss_SylpheedUpdateHealth-Boss_SylpheedSpawnProjectile3
                dc.w Boss_DestroyerProtoDefeatAnim-Boss_SylpheedSpawnProjectile3
                dc.w Boss_SylpheedSpawnProjectile3-Boss_SylpheedSpawnProjectile3


; Spawns projectile type 3
Boss_SylpheedSpawnProjectile3:                              ; CODE XREF: Boss_SylpheedCollisionCheck+6   j  ; was: sub_19E24
                                        ; Projectile_SylpheedBullet2+22   j ...
                move.b  #$7F,(byte_FF830F).w
                bclr    #0,(byte_FF826C).w
                clr.w   (word_FF8224).w
                move.w  #0,4(a5)
                clr.l   $18(a5)
                clr.w   $48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                jmp Player_AutoFlipDirection
; End of function Boss_SylpheedSpawnProjectile3
nullsub_51:                             ; CODE XREF: Boss_SylpheedSpawnProjectile4+14   j
                                        ; Boss_SylpheedSpawnProjectile4+1A   j
                rts
; End of function nullsub_51


; Spawns projectile type 4
Boss_SylpheedSpawnProjectile4:                              ; DATA XREF: ROM:off_19E16   o  ; was: sub_19E56
                move.w  #$1C,$5C(a5)
                bsr.w Projectile_SylpheedHoming
                jsr (Effect_SpawnParticle).l
                bsr.w Boss_SylpheedSpawnProjectile5
                bne.s   nullsub_51
                bsr.w Gfx_LoadArtemisTiles
                bne.s   nullsub_51
                btst    #0,(byte_FF826C).w
                bne.w Boss_SylpheedDamageCheck
                btst    #4,$69(a5)
                beq.s   loc_19E8A
                tst.w   (word_FFA22A).w
                bne.s   loc_19E96
loc_19E8A:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+2C   j
                move.b  $69(a5),d0
                andi.b  #$F,d0
                bne.w Projectile_SylpheedBullet1
loc_19E96:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+32   j
                bra.w Projectile_SylpheedWave
; End of function Boss_SylpheedSpawnProjectile4
; Spawns projectile type 5
Boss_SylpheedSpawnProjectile5:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+10   p  ; was: sub_19E9A
                                        ; sub_19F36   p
                btst    #6,$6A(a5)
                beq.s   loc_19EB2
                btst    #1,$69(a5)
                bne.w Cutscene_SevenForcesSoundEffect
                tst.w   (word_FF8038).w
                bmi.s   loc_19EB6
loc_19EB2:                              ; CODE XREF: Boss_SylpheedSpawnProjectile5+6   j
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_19EB6:                              ; CODE XREF: Boss_SylpheedSpawnProjectile5+16   j
                move.w  (word_FFA24E).w,(word_FFA220).w
                move.w  #$12,(word_FFA21C).w
                move.b  #$7F,(byte_FF830F).w
                move.w  #0,(word_FF8032).w
                move.w  #$FFEE,(word_FF8034).w
                move.w  #4,4(a5)
                move.w  #$1C,$5C(a5)
                moveq   #1,d0
                rts
; End of function Boss_SylpheedSpawnProjectile5
; Collision detection with player
Boss_SylpheedCollisionCheck:                              ; DATA XREF: ROM:00019E1A   o  ; was: sub_19EE4
                cmpi.w  #$12,(word_FFA21C).w
                bmi.w Boss_SylpheedSpawnProjectile3
                bsr.w Projectile_SylpheedHoming
                bra.w Boss_SireneAnimationScript
; End of function Boss_SylpheedCollisionCheck
; Plays victory sound effect
Cutscene_SevenForcesSoundEffect:                              ; CODE XREF: Boss_SylpheedSpawnProjectile5+E   j  ; was: sub_19EF6
                move.b  #$7F,(byte_FF830F).w
                eori.w  #2,(word_FFA22A).w
                move.b  #$A3,d0
                jsr (Sound_PlaySFX).l
                moveq   #0,d0
                rts
; End of function Cutscene_SevenForcesSoundEffect
; Bullet projectile type 1
Projectile_SylpheedBullet1:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+3C   j  ; was: sub_19F10
                move.b  #$7F,(byte_FF830F).w
                move.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                jmp Player_AutoFlipDirection
; End of function Projectile_SylpheedBullet1
nullsub_52:                             ; CODE XREF: Projectile_SylpheedBullet2+4   j
                                        ; Projectile_SylpheedBullet2+A   j
                rts
; End of function nullsub_52


; Bullet projectile type 2
Projectile_SylpheedBullet2:                              ; DATA XREF: ROM:00019E18   o  ; was: sub_19F36
                bsr.w Boss_SylpheedSpawnProjectile5
                bne.s   nullsub_52
                bsr.w Gfx_LoadArtemisTiles
                bne.s   nullsub_52
                btst    #0,(byte_FF826C).w
                bne.w Boss_SylpheedDamageCheck
                btst    #4,$69(a5)
                beq.s   loc_19F5C
                tst.w   (word_FFA22A).w
                bne.w Boss_SylpheedSpawnProjectile3
loc_19F5C:                              ; CODE XREF: Projectile_SylpheedBullet2+1C   j
                move.b  $69(a5),d0
                andi.b  #$F,d0
                beq.w Boss_SylpheedSpawnProjectile3
                bsr.w Projectile_SylpheedLaser
                bra.w Projectile_SylpheedWave
; End of function Projectile_SylpheedBullet2
; Loads Artemis tiles
Gfx_LoadArtemisTiles:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+16   p  ; was: sub_19F70
                                        ; Projectile_SylpheedBullet2+6   p
                btst    #5,$6A(a5)
                beq.w   locret_1A01A
                move.w  #6,4(a5)
                move.b  #$73,(byte_FF830F).w ; 's'
                jsr (Sys_ClearObjectBufferSmall).l
                move.b  #$A6,d0
                jsr (Sound_PlaySFX).l
                move.b  #1,(word_FF8224).w
                move.w  #$C,$50(a5)
                clr.w   $12(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                btst    #2,$69(a5)
                bne.s   loc_19FC6
                btst    #3,$69(a5)
                bne.s   loc_19FD6
                btst    #3,$E(a5)
                bne.s   loc_19FD6
loc_19FC6:                              ; CODE XREF: Gfx_LoadArtemisTiles+44   j
                move.l  #$FFF88000,$48(a5)
                bclr    #3,$E(a5)
                bra.s   loc_19FE4
; ---------------------------------------------------------------------------
loc_19FD6:                              ; CODE XREF: Gfx_LoadArtemisTiles+4C   j
                                        ; Gfx_LoadArtemisTiles+54   j
                move.l  #$78000,$48(a5)
                bset    #3,$E(a5)
loc_19FE4:                              ; CODE XREF: Gfx_LoadArtemisTiles+64   j
                tst.w   (word_FF8304).w
                bne.s   loc_1A00A
                btst    #7,(byte_FF8245).w
                bne.s   loc_1A00A
                jsr (Player_SpawnProjectile).l
                move.l  #word_E8E6A,8(a5)
                move.w  #$78,(word_FF8304).w ; 'x'
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_1A00A:                              ; CODE XREF: Gfx_LoadArtemisTiles+78   j
                                        ; Gfx_LoadArtemisTiles+80   j
                move.l  #word_E86AA,8(a5)
                move.w  #$78,(word_FF8304).w ; 'x'
                moveq   #1,d0
locret_1A01A:                           ; CODE XREF: Gfx_LoadArtemisTiles+6   j
                rts
; End of function Gfx_LoadArtemisTiles
; Loads Artemis palette
Gfx_LoadArtemisPalette:                              ; DATA XREF: ROM:00019E1C   o  ; was: sub_1A01C
                tst.b   (byte_FF8311).w
                bne.s   loc_1A028
                subq.w  #1,$50(a5)
                bpl.s   loc_1A046
loc_1A028:                              ; CODE XREF: Gfx_LoadArtemisPalette+4   j
                clr.w   (word_FFC5C0).w
                bclr    #0,(byte_FF826C).w
                bclr    #6,$21(a5)
                bclr    #4,$23(a5)
                clr.w   (word_FF8224).w
                bra.w Boss_SylpheedSpawnProjectile3
; ---------------------------------------------------------------------------
loc_1A046:                              ; CODE XREF: Gfx_LoadArtemisPalette+A   j
                move.w  #1,(word_FF809C).w
                bset    #6,$21(a5)
                bset    #4,$23(a5)
                bsr.s Gfx_UpdateTrackerSprites
                bsr.s Gfx_UpdateTrackerSprites
                bsr.s Gfx_UpdateTrackerSprites
                bset    #4,(byte_FF8244).w
                jmp Effect_CreateDashTrail
; End of function Gfx_LoadArtemisPalette
; Updates tracker sprites
Gfx_UpdateTrackerSprites:                              ; CODE XREF: Gfx_LoadArtemisPalette+3C   p  ; was: sub_1A06A
                                        ; Gfx_LoadArtemisPalette+3E   p ...
                move.l  $48(a5),d0
                add.l   d0,$10(a5)
                rts
; End of function Gfx_UpdateTrackerSprites
; Checks if boss takes damage
Boss_SylpheedDamageCheck:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+22   j  ; was: sub_1A074
                                        ; Projectile_SylpheedBullet2+12   j
                jsr (Boss_FlashOnHit).l
                move.b  #$7F,(byte_FF830F).w
                jsr (Sys_ClearObjectBufferSmall).l
                move.w  #8,4(a5)
                move.w  #$FFFC,$48(a5)
                move.w  #$A,$4A(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$1C,$5C(a5)
                move.l  #$FFFE0000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_1A0B8
                neg.l   $18(a5)
locret_1A0B8:                           ; CODE XREF: Boss_SylpheedDamageCheck+3E   j
                rts
; End of function Boss_SylpheedDamageCheck
; Updates boss health
Boss_SylpheedUpdateHealth:                              ; DATA XREF: ROM:00019E1E   o  ; was: sub_1A0BA
                subq.w  #1,$4A(a5)
                bmi.w Boss_SylpheedSpawnProjectile3
                jmp Player_AnimateDefeatSprite
; End of function Boss_SylpheedUpdateHealth
; Defeat sequence init
Boss_DestroyerProtoDefeatInit:                              ; CODE XREF: Boss_SylpheedSpawnProjectile1+14   p  ; was: sub_1A0C8
                move.b  #$19,d0
                jsr (Sound_PlaySFX).l
                move.b  #$7F,(byte_FF830F).w
                move.w  #$8000,(word_FF80E6).w
                jsr (Memory_ClearBlock).l
                move.w  #$A,4(a5)
                move.w  #$10,$48(a5)
                tst.w   (dword_FF8300).w
                beq.s   loc_1A10C
                bmi.s   loc_1A102
                move.l  #$38000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A102:                              ; CODE XREF: Boss_DestroyerProtoDefeatInit+2E   j
                move.l  #$FFFC8000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A10C:                              ; CODE XREF: Boss_DestroyerProtoDefeatInit+2C   j
                move.l  #$FFFC8000,$18(a5)
                btst    #3,$E(a5)
                bne.s   locret_1A120
                neg.l   $18(a5)
locret_1A120:                           ; CODE XREF: Boss_DestroyerProtoDefeatInit+52   j
                                        ; Boss_DestroyerProtoDefeatAnim+1A   j
                rts
; End of function Boss_DestroyerProtoDefeatInit
; Defeat animation handler
Boss_DestroyerProtoDefeatAnim:                              ; DATA XREF: ROM:00019E20   o  ; was: sub_1A122
                movea.l #word_E8BAA,a1
                movea.l #word_E89C2,a2
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFF,d6
                jsr (Stage_HandleBossDefeat).l
                subq.w  #1,$48(a5)
                bpl.s   locret_1A120
                clr.w   (word_FF80E6).w
                move.w  #$CC00,2(a5)
                move.b  #$80,$21(a5)
                bra.w Boss_SylpheedSpawnProjectile3
; End of function Boss_DestroyerProtoDefeatAnim
; Laser projectile handler
Projectile_SylpheedLaser:                              ; CODE XREF: Projectile_SylpheedBullet2+32   p  ; was: sub_1A152
                lea     word_1A1E2(pc),a0
                nop
                move.b  $69(a5),d0
                andi.w  #$F,d0
                move.b  (a0,d0.w),d0
                asl.w   #1,d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                move.w  d1,d3
                move.w  d2,d4
                muls.w  #$E,d3
                muls.w  #$12,d4
                ext.l   d1
                ext.l   d2
                asl.l   #1,d1
                asl.l   #1,d2
                add.l   $1C(a5),d1
                bpl.s   loc_1A1A6
                tst.l   d3
                beq.s   loc_1A1AE
                bpl.s   loc_1A19A
                cmp.l   d1,d3
                bpl.s   loc_1A1AE
                bra.s   loc_1A1B0
; ---------------------------------------------------------------------------
loc_1A19A:                              ; CODE XREF: Projectile_SylpheedLaser+40   j
                                        ; Projectile_SylpheedLaser+56   j
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                bra.s   loc_1A1B4
; ---------------------------------------------------------------------------
loc_1A1A6:                              ; CODE XREF: Projectile_SylpheedLaser+3A   j
                tst.l   d3
                bmi.s   loc_1A19A
                cmp.l   d1,d3
                bpl.s   loc_1A1B0
loc_1A1AE:                              ; CODE XREF: Projectile_SylpheedLaser+3E   j
                                        ; Projectile_SylpheedLaser+44   j
                move.l  d3,d1
loc_1A1B0:                              ; CODE XREF: Projectile_SylpheedLaser+46   j
                                        ; Projectile_SylpheedLaser+5A   j
                move.l  d1,$1C(a5)
loc_1A1B4:                              ; CODE XREF: Projectile_SylpheedLaser+52   j
                add.l   $18(a5),d2
                bpl.s   loc_1A1D2
                tst.l   d4
                beq.s   loc_1A1DA
                bpl.s   loc_1A1C6
                cmp.l   d2,d4
                bpl.s   loc_1A1DA
                bra.s   loc_1A1DC
; ---------------------------------------------------------------------------
loc_1A1C6:                              ; CODE XREF: Projectile_SylpheedLaser+6C   j
                                        ; Projectile_SylpheedLaser+82   j
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_1A1D2:                              ; CODE XREF: Projectile_SylpheedLaser+66   j
                tst.l   d4
                bmi.s   loc_1A1C6
                cmp.l   d2,d4
                bpl.s   loc_1A1DC
loc_1A1DA:                              ; CODE XREF: Projectile_SylpheedLaser+6A   j
                                        ; Projectile_SylpheedLaser+70   j
                move.l  d4,d2
loc_1A1DC:                              ; CODE XREF: Projectile_SylpheedLaser+72   j
                                        ; Projectile_SylpheedLaser+86   j
                move.l  d2,$18(a5)
                rts
; End of function Projectile_SylpheedLaser
; ---------------------------------------------------------------------------
word_1A1E2:     dc.w $C0, $4000, $80A0, $6000, $E0, $2000, 0, 0
                                        ; DATA XREF: Projectile_SylpheedLaser   o


; Homing projectile handler
Projectile_SylpheedHoming:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4+6   p  ; was: sub_1A1F2
                                        ; Boss_SylpheedCollisionCheck+A   p
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                rts
; End of function Projectile_SylpheedHoming
; Wave projectile handler
Projectile_SylpheedWave:                              ; CODE XREF: Boss_SylpheedSpawnProjectile4:loc_19E96   j  ; was: sub_1A208
                                        ; Projectile_SylpheedBullet2+36   j
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1A21C
                movea.l #word_E8F6A,a2
loc_1A21C:                              ; CODE XREF: Projectile_SylpheedWave+C   j
                btst    #4,$69(a5)
                bne.s   loc_1A23A
                jsr (Player_UpdateHorizontalFacing).l
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp Stage_HandleBossDefeat
; ---------------------------------------------------------------------------
loc_1A23A:                              ; CODE XREF: Projectile_SylpheedWave+1A   j
                lea     (word_198B2).l,a4
                moveq   #0,d5
                moveq   #$FFFFFFFF,d6
                lea     (off_172F8).l,a0
                jmp     loc_1727A
; End of function Projectile_SylpheedWave
; Animation script interpreter
Boss_SireneAnimationScript:                              ; CODE XREF: Boss_SylpheedCollisionCheck+E   j  ; was: sub_1A250
                movea.l #word_E8F3A,a2
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1A264
                movea.l #word_E8F6A,a2
loc_1A264:                              ; CODE XREF: Boss_SireneAnimationScript+C   j
                movea.l #word_E8972,a1
                moveq   #$FFFFFFFF,d5
                moveq   #$FFFFFFFE,d6
                jmp Stage_HandleBossDefeat
; End of function Boss_SireneAnimationScript
; Background graphics setup
Gfx_SireneBackground:                              ; CODE XREF: Player_Update+50   j  ; was: sub_1A274
                bsr.w Boss_SylpheedSpawnProjectile1
                bset    #0,2(a5)
                rts
; End of function Gfx_SireneBackground
; Updates object spawner state and triggers
Sys_UpdateObjectSpawner:                              ; CODE XREF: Sys_GameplayMainLoop:loc_1C732   p  ; was: sub_1A280
                                        ; Stage_UpdateGameplay+C   p
                tst.b   (byte_FF813E).w
                bpl.w   loc_1A28A
                rts
; ---------------------------------------------------------------------------
loc_1A28A:                              ; CODE XREF: Sys_UpdateObjectSpawner+4   j
                move.w  (word_FF808C).w,d0
                bmi.w   loc_1A296
                subq.w  #1,(word_FF808C).w
loc_1A296:                              ; CODE XREF: Sys_UpdateObjectSpawner+E   j
                jsr Sys_ProcessSpawnList(pc)   ; (pc)
                nop
; End of function Sys_UpdateObjectSpawner
; Processes all objects with screen bounds culling
Sys_ProcessVisibleObjects:                              ; CODE XREF: Sys_StoryScreenMainLoop+32   p  ; was: sub_1A29C
                                        ; UI_UpdateOptionsScreen+58   p ...
                lea     (word_FFC620).w,a5
loc_1A2A0:                              ; CODE XREF: Sys_ProcessVisibleObjects+5A   j
                move.w  (a5),d0
                beq.s Sys_AdvanceObjectPointer
                cmpi.w  #$10,d0
                beq.s   loc_1A2B2
                movea.w d0,a0
                movea.l off_5DC(a0),a0
                jsr     (a0)
loc_1A2B2:                              ; CODE XREF: Sys_ProcessVisibleObjects+C   j
                btst    #4,2(a5)
                bne.s   loc_1A2DE
                btst    #1,2(a5)
                beq.s   loc_1A2E4
                move.w  $10(a5),d0
                subi.w  #$60,d0 ; '`'
                cmpi.w  #$180,d0
                bhi.s   loc_1A2DE
                move.w  $14(a5),d0
                subi.w  #$40,d0 ; '@'
                cmpi.w  #$130,d0
                bls.s   loc_1A2E4
loc_1A2DE:                              ; CODE XREF: Sys_ProcessVisibleObjects+1C   j
                                        ; Sys_ProcessVisibleObjects+32   j
                bsr.w Sys_ClearObjectSlot
                bra.s Sys_AdvanceObjectPointer
; ---------------------------------------------------------------------------
loc_1A2E4:                              ; CODE XREF: Sys_ProcessVisibleObjects+24   j
                                        ; Sys_ProcessVisibleObjects+40   j
                movea.w (word_FFF758).w,a0
                move.w  a5,(a0)+
                move.w  a0,(word_FFF758).w
; Advances object array pointer to next slot in processing loop
Sys_AdvanceObjectPointer:                              ; CODE XREF: Sys_ProcessVisibleObjects+6   j  ; was: loc_1A2EE
                                        ; Sys_ProcessVisibleObjects+46   j
                lea     $60(a5),a5
                cmpa.w  #$DCA0,a5
                bcs.s   loc_1A2A0
                rts
; End of function Sys_ProcessVisibleObjects
; Processes object spawn list based on scroll
Sys_ProcessSpawnList:                              ; CODE XREF: Sys_UpdateObjectSpawner:loc_1A296   p  ; was: sub_1A2FA
                                        ; DATA XREF: Sys_UpdateObjectSpawner:loc_1A296   o
                move.l  (dword_FFA20E).w,d0
                bmi.s   locret_1A322
                tst.w   (dword_FFA910).w
                bmi.s   locret_1A322
                movea.l d0,a4
loc_1A308:                              ; CODE XREF: Sys_ProcessSpawnList+22   j
                move.w  (dword_FFA900).w,d7
                addi.w  #$140,d7
                cmp.w   (a4),d7
                blt.s   loc_1A31E
                bsr.w Sys_SpawnObject
                lea     $C(a4),a4
                bra.s   loc_1A308
; ---------------------------------------------------------------------------
loc_1A31E:                              ; CODE XREF: Sys_ProcessSpawnList+18   j
                move.l  a4,(dword_FFA20E).w
locret_1A322:                           ; CODE XREF: Sys_ProcessSpawnList+4   j
                                        ; Sys_ProcessSpawnList+A   j
                rts
; End of function Sys_ProcessSpawnList
; Spawns object from spawn table entry
Sys_SpawnObject:                              ; CODE XREF: Sys_ProcessSpawnList+1A   p  ; was: sub_1A324
                movea.w 8(a4),a5
                movea.w $A(a4),a0
                bsr.w Sys_FindSlotInRange
                beq.s   loc_1A33C
                movea.w 8(a4),a5
                bsr.w Gfx_LoadDestroyerMK2Palette
                beq.s   locret_1A388
loc_1A33C:                              ; CODE XREF: Sys_SpawnObject+C   j
                bsr.w Sys_ClearObjectSlot
                move.w  4(a4),d0
                bclr    #0,d0
                beq.s   loc_1A352
                tst.w   (word_FFFF0E).w
                bne.s   loc_1A35E
locret_1A350:                           ; CODE XREF: Sys_SpawnObject+38   j
                rts
; ---------------------------------------------------------------------------
loc_1A352:                              ; CODE XREF: Sys_SpawnObject+24   j
                bclr    #1,d0
                beq.s   loc_1A35E
                tst.w   (word_FFFF0E).w
                bne.s   locret_1A350
loc_1A35E:                              ; CODE XREF: Sys_SpawnObject+2A   j
                                        ; Sys_SpawnObject+32   j
                move.w  d0,(a5)
                move.w  6(a4),$5E(a5)
                move.w  (a4),d0
                sub.w   (dword_FFA900).w,d0
                addi.w  #$80,d0
                move.w  d0,$10(a5)
                clr.w   $12(a5)
                move.w  2(a4),d1
                add.w   (dword_FFA904).w,d1
                move.w  d1,$14(a5)
                clr.w   $16(a5)
locret_1A388:                           ; CODE XREF: Sys_SpawnObject+16   j
                rts
; End of function Sys_SpawnObject
; Finds free slot in object array range
Sys_FindSlotInRange:                              ; CODE XREF: Sys_SpawnObject+8   p  ; was: sub_1A38A
                                        ; Sys_FindSlotInRange+A   j
                tst.w   (a5)
                beq.s   locret_1A39A
                lea     $60(a5),a5
                cmpa.l  a0,a5
                bcs.s Sys_FindSlotInRange
                andi    #$FB,ccr
locret_1A39A:                           ; CODE XREF: Sys_FindSlotInRange+2   j
                rts
; End of function Sys_FindSlotInRange
; Loads Destroyer-MK2 palette
Gfx_LoadDestroyerMK2Palette:                              ; CODE XREF: Sys_SpawnObject+12   p  ; was: sub_1A39C
                                        ; Gfx_LoadDestroyerMK2Palette+E   j
                btst    #6,3(a5)
                bne.s   locret_1A3AE
                lea     $60(a5),a5
                cmpa.l  a0,a5
                bcs.s Gfx_LoadDestroyerMK2Palette
                moveq   #0,d0
locret_1A3AE:                           ; CODE XREF: Gfx_LoadDestroyerMK2Palette+6   j
                rts
; End of function Gfx_LoadDestroyerMK2Palette
; Clears 96 bytes of object RAM
Sys_ClearObjectSlot:                              ; CODE XREF: Sys_ProcessProjectiles:loc_199D6   p  ; was: sub_1A3B0
                                        ; sub_1A29C:loc_1A2DE   p ...
                movea.l a5,a0
; Clears 96-byte object memory block (24 long-words) to zero
Sys_Clear96ByteBlock:                              ; CODE XREF: Sprite_ClearInactiveObjects+22   p  ; was: loc_1A3B2
                                        ; sub_2C3F8:loc_2C40E   p
                moveq   #0,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                rts
; End of function Sys_ClearObjectSlot
; ---------------------------------------------------------------------------
word_1A3E6:     dc.w $7FFF              ; DATA XREF: ROM:stru_12910   o
                                        ; ROM:stru_1296A   o ...
                                        ; UNUSED: Intro cutscene sprite graphics
                                        ; See stru_12910 for complete structure (line 23283)
word_1A3E8:     dc.w $1A0, $130, $1C, $10, $C680, $CF80
                                        ; DATA XREF: ROM:stru_127A8   o
                dc.w $200, $130, $1D, $11, $C680, $CF80
                dc.w $280, $D0, $1C, $15, $C680, $CF80
                dc.w $2C0, $130, $1D, $18, $C680, $CF80
                dc.w $300, $110, $44, 4, $C680, $CF80
                dc.w $340, $130, $1C, $10, $C680, $CF80
                dc.w $3A0, $130, $1D, $10, $C680, $CF80
                dc.w $400, $130, $8C, 0, $C680, $CF80
                dc.w $410, $EC, $24C, 0, $C680, $CF80
                dc.w $440, $D0, $44, 0, $C680, $CF80
                dc.w $470, $130, $1E0, 0, $C680, $CF80
                dc.w $4A0, $D0, $1C, 0, $C680, $CF80
                dc.w $633, $130, $44, 0, $C680, $CF80
                dc.w $658, $C4, $24C, 0, $C680, $CF80
                dc.w $6C0, $14C, $48, 0, $C680, $CF80
                dc.w $6F0, $14C, $49, 0, $C680, $CF80
                dc.w $720, $14C, $48, 0, $C680, $CF80
                dc.w $750, $14C, $49, 0, $C680, $CF80
                dc.w $780, $130, $1D, 0, $C680, $CF80
                dc.w $7C0, $110, $1E0, 0, $C680, $CF80
word_1A4D8:	binclude	"data/other/word_1A4D8.bin"
word_1A4D8_End:
word_1A6B8:     dc.w $D10, $130, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_127E4   o
                dc.w $D30, $130, $1C, 0, $C680, $CF80
                dc.w $D40, $130, $28C, 0, $C680, $CF80
                dc.w $D80, $130, $1D, $11, $C680, $CF80
                dc.w $E20, $C0, $FC, 8, $C680, $CF80
                dc.w $ED0, $C0, $100, $A, $C680, $CF80
                dc.w $F60, $C0, $FC, $C, $C680, $CF80
                dc.w $FC0, $E4, $24C, 0, $C680, $CF80
                dc.w $1010, $C0, $100, $E, $C680, $CF80
                dc.w $10D0, $130, $1C, 0, $C680, $CF80
                dc.w $110A, $AC, $22, 0, $C680, $CF80
                dc.w $11E0, $130, $1C, 0, $C680, $CF80
                dc.w $1240, $130, $1C, 0, $C680, $CF80
word_1A754:	binclude	"data/other/word_1A754.bin"
word_1A754_End:
word_1A882:	binclude	"data/other/word_1A882.bin"
word_1A882_End:
word_1A9B0:     dc.w $4D4, $108, $12C, 8, $DB20, $DCA0
                                        ; DATA XREF: ROM:stru_1283E   o
                dc.w $550, $108, $12C, $18, $DB20, $DCA0
                dc.w $5B8, $108, $12C, $10, $DB20, $DCA0
word_1A9D4:	binclude	"data/other/word_1A9D4.bin"
word_1A9D4_End:
word_1AB24:     dc.w $C10, $130, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1285C   o
                dc.w $C30, $130, $1D, $11, $C680, $CF80
                dc.w $C50, $130, $1C, 0, $C680, $CF80
                dc.w $C80, $110, $8C, 0, $C680, $CF80
                dc.w $D40, $110, $3B4, $500, $C680, $CF80
                dc.w $DC0, $110, $3B4, $402, $C680, $CF80
                dc.w $E40, $C0, $3B4, $304, $C680, $CF80
                dc.w $EC0, $140, $3B4, $206, $C680, $CF80
                dc.w $EE0, $B0, $24C, 0, $C680, $CF80
                dc.w $F00, $F0, $3B4, $402, $C680, $CF80
                dc.w $FA0, $130, $3B4, $506, $C680, $CF80
                dc.w $1070, $130, $8C, 0, $C680, $CF80
                dc.w $10E2, $118, $12C, $8020, $DB20, $DCA0
                dc.w $7FFF
word_1ABC2:     dc.w $980, $120, $1C, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1287A   o
                dc.w $A20, $120, $1D, $11, $C680, $CF80
                dc.w $AC0, $120, $1C, 0, $C680, $CF80
                dc.w $B40, $120, $1C, 0, $C680, $CF80
                dc.w $BC0, $120, $1C, 0, $C680, $CF80
                dc.w $C40, $120, $1C, 0, $C680, $CF80
                dc.w $C58, $120, $24C, 0, $C680, $CF80
                dc.w $CC0, $120, $1C, 0, $C680, $CF80
                dc.w $D40, $120, $1C, 0, $C680, $CF80
                dc.w $DC0, $120, $1C, 0, $C680, $CF80
                dc.w $E40, $120, $1C, 0, $C680, $CF80
                dc.w $EC0, $120, $1C, 0, $C680, $CF80
                dc.w $F40, $120, $1C, 0, $C680, $CF80
                dc.w $7FFF
word_1AC60:     dc.w $7FFF              ; DATA XREF: ROM:stru_12898   o
word_1AC62:	binclude	"data/other/word_1AC62.bin"
word_1AC62_End:
word_1AD8E:	binclude	"data/other/word_1AD8E.bin"
word_1AD8E_End:
word_1AE96:	binclude	"data/other/word_1AE96.bin"	; UNUSED: Unknown graphics (314 bytes)
                                        ; See stru_128F2 for structure (line 23266)
word_1AE96_End:
word_1AFD0:     dc.w $160, $1FD8, $20, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1292E   o
                dc.w $1E0, $2028, $24C, 0, $C680, $CF80
                dc.w $200, $2010, $1C, 0, $C680, $CF80
                dc.w $2C0, $2010, $1C, 0, $C680, $CF80
                dc.w $380, $2010, $1C, 0, $C680, $CF80
word_1B00C:     dc.w $720, $2000, $380, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_1294C   o
                dc.w $720, $2000, $39C, 0, $C680, $CF80
                dc.w $740, $2028, $24C, 0, $C680, $CF80
                dc.w $764, $2028, $20, 0, $C680, $CF80
                dc.w $7FFF
word_1B03E:	binclude	"data/other/word_1B03E.bin"
word_1B03E_End:
word_1B2BA:	binclude	"data/other/word_1B2BA.bin"
word_1B2BA_End:
word_1B3F4:     dc.w $7FFF              ; DATA XREF: ROM:stru_12AB4   o
word_1B3F6:     dc.w $270, $2D0, $20, 0, $C680, $CF80
                                        ; DATA XREF: ROM:stru_12B2C   o
                dc.w $7FFF


; Looks up cosine value from trigonometry table
Math_LookupCosineValue:                              ; CODE XREF: Results_RenderScoreValues+1C   p  ; was: sub_1B404
                lea     (word_5A43E).l,a0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_LookupCosineValue
; Calculates distance between two objects using position differences
Physics_CalculateDistanceTo:                              ; CODE XREF: Boss_JetsripperMain:loc_2B72E   p  ; was: sub_1B410
                                        ; sub_2B77C:loc_2B7EA   p ...
                movea.w #(word_FFA400-M68K_RAM),a0
                move.w  $10(a0),d1
                sub.w   $10(a5),d1
                move.w  d1,d0
                bpl.s   loc_1B422
                neg.w   d0
loc_1B422:                              ; CODE XREF: Physics_CalculateDistanceTo+E   j
                move.w  $14(a0),d2
                sub.w   $14(a5),d2
                moveq   #1,d3
                rts
; End of function Physics_CalculateDistanceTo
; Calculates angle using arctan2
Math_CalcAngleBetweenObjs:
                move.w  $10(a0),d0  ; was: sub_1B42E
                move.w  $14(a0),d1
                sub.w   $10(a1),d0
                sub.w   $14(a1),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                andi.w  #$1FE,d2
                rts
; End of function Math_CalcAngleBetweenObjs
; Calculates sine/cosine values in all four quadrants and stores in lookup tables
Math_CalculateSineCosineTable:                              ; CODE XREF: Boss_ShiperInit+26   j  ; was: sub_1B44C
                                        ; Boss_FlyingNeoInit+1C   p
                movea.w a0,a1
                adda.w  #$200,a1
                movea.w a1,a2
                addq.w  #4,a1
                movea.w a0,a3
                adda.w  #$400,a3
                movea.w a3,a4
                addq.w  #4,a3
                move.w  a5,(dword_FF8040).w
                movea.l #word_1B494,a5
                asl.w   #2,d0
                move.w  #$3F,d7 ; '?'
; Populates sine/cosine lookup table with calculated values
Math_PopulateTrigTable:                              ; CODE XREF: Math_CalculateSineCosineTable+34   j  ; was: loc_1B470
                move.w  (a5)+,d1
                muls.w  d0,d1
                move.l  d1,(a0)+
                move.l  d1,-(a1)
                move.l  d1,(a4)+
                neg.l   d1
                move.l  d1,(a2)+
                move.l  d1,-(a3)
                dbf d7,Math_PopulateTrigTable
                move.w  (a5)+,d1
                muls.w  d0,d1
                move.l  d1,(a0)+
                neg.l   d1
                move.l  d1,(a2)+
                movea.w (dword_FF8040).w,a5
                rts
; End of function Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
word_1B494:     dc.w 0, $192, $323, $4B5, $645, $7D5, $964, $AF1
                                        ; DATA XREF: Math_LookupSineTable   o
                                        ; Enemy_SpawnProjectileAtAngle+3A   r ...
                dc.w $C7C, $E05, $F8C, $1111, $1294, $1413, $158F, $1708
                dc.w $187D, $19EF, $1B5D, $1CC6, $1E2B, $1F8B, $20E7, $223D
                dc.w $238E, $24DA, $261F, $275F, $2899, $29CD, $2AFA, $2C21
                dc.w $2D41, $2E5A, $2F6B, $3076, $3179, $3274, $3367, $3453
                dc.w $3536, $3612, $36E5, $37AF, $3871, $392A, $39DA, $3A82
                dc.w $3B20, $3BB6, $3C42, $3CC5, $3D3E, $3DAE, $3E14, $3E71
                dc.w $3EC5, $3F0E, $3F4E, $3F84, $3FB1, $3FD3, $3FEC, $3FFB
word_1B514:	binclude	"data/other/word_1B514.bin"
word_1B514_End:


; Loop clearing table entries
Data_ClearTableLoop:                              ; CODE XREF: Data_ClearTableLoop+C   j  ; was: sub_1B714
                bsr.w Data_CheckAndResetEntry
                lea     $60(a0),a0
                cmpa.w  #$DCA0,a0
                bmi.w Data_ClearTableLoop
                rts
; End of function Data_ClearTableLoop
; Check and reset table entry
Data_CheckAndResetEntry:                              ; CODE XREF: Data_ClearTableLoop   p  ; was: sub_1B726
                cmpi.w  #0,(a0)
                beq.w   locret_1B744
                cmp.w   (a0),d0
                beq.w   locret_1B744
                cmp.w   (a0),d1
                beq.w   locret_1B744
                move.w  #$10,(a0)
                move.w  #$1000,2(a0)
locret_1B744:                           ; CODE XREF: Data_CheckAndResetEntry+4   j
                                        ; Data_CheckAndResetEntry+A   j ...
                rts
; End of function Data_CheckAndResetEntry
; Clears boss entity data buffer with zero fill
Sys_ClearBossDataBuffer:                              ; CODE XREF: Cutscene_InitCreditsScreen+44   p  ; was: sub_1B746
                                        ; Cutscene_SegaScreenFadeOut+44   p ...
                moveq   #0,d0
                movea.w #(word_FFC620-M68K_RAM),a0
loc_1B74C:                              ; CODE XREF: Sys_ClearBossDataBuffer+3A   j
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                cmpa.w  #$DCA0,a0
                bmi.s   loc_1B74C
                rts
; End of function Sys_ClearBossDataBuffer
; Queues VDP command for DMA
VDP_QueueCommand:                              ; CODE XREF: Scroll_UpdateSnakeBackground+64   p  ; was: sub_1B784
                move.w  #$8F02,d3
                movea.w (word_FFF70E).w,a0
loc_1B78C:                              ; CODE XREF: Boss_ShieldViperRenderBackground+32   j
                                        ; Gfx_Update3DPlanetEffect+190   j ...
                movea.w (word_FFF70C).w,a1
                move.w  d0,d1
                moveq   #0,d2
                roxl.w  #1,d0
                roxl.w  #1,d2
                roxl.w  #1,d0
                roxl.w  #1,d2
                ori.w   #$80,d2
                move.w  d2,-(a1)
                andi.w  #$3FFF,d1
                addi.w  #$4000,d1
                move.w  d1,-(a1)
                move.l  a0,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                andi.b  #$7F,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  d3,-(a1)
                move.l  d4,-(a1)
                move.w  a1,(word_FFF70C).w
                rts
; End of function VDP_QueueCommand
; Graphics update 2
Stage22_GraphicsUpdate2:                              ; CODE XREF: Stage_LoadTiles2+54   j  ; was: sub_1B7DC
                move.w  #$8F02,d3
                move    sr,-(sp)
                move    #$2700,sr
loc_1B7E6:                              ; CODE XREF: Stage22_GraphicsUpdate2+12   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_1B7E6
                lea     (VDP_CTRL).l,a4
                move.w  (word_FFF7D2).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                move.w  d3,(a4)
                move.l  d4,(a4)
                move.l  a0,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$FF,d0
                andi.w  #$FF,d1
                andi.w  #$7F,d2
                addi.w  #-$6B00,d0
                addi.w  #-$6A00,d1
                addi.w  #-$6900,d2
                move.w  d0,(a4)
                move.w  d1,(a4)
                move.w  d2,(a4)
                move.w  d5,d1
                moveq   #0,d2
                roxl.w  #1,d5
                roxl.w  #1,d2
                roxl.w  #1,d5
                roxl.w  #1,d2
                ori.w   #$80,d2
                move.w  d2,(VDPCommand).w
                andi.w  #$3FFF,d1
                addi.w  #$4000,d1
                move.w  d1,(VDPCommand+2).w
                move.w  (VDPCommand+2).w,(a4)
                move.w  (VDPCommand).w,(a4)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_1B864:                              ; CODE XREF: Stage22_GraphicsUpdate2+90   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_1B864
                move    (sp)+,sr
                rts
; End of function Stage22_GraphicsUpdate2
; Calculate tile offset mask $1C0
Math_CalcTileOffset1:
                asr.w   #7,d2  ; was: sub_1B872
                andi.w  #$1FE,d2
                move.w  d2,d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$1C0,d0
                rts
; End of function Math_CalcTileOffset1
; Calculate tile offset mask $1E0
Math_CalcTileOffset2:
                asr.w   #7,d2  ; was: sub_1B884
                andi.w  #$1FE,d2
                move.w  d2,d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                rts
; End of function Math_CalcTileOffset2
; Calculate tile offset mask $1F0
Math_CalcTileOffset3:
                asr.w   #7,d2  ; was: sub_1B896
                andi.w  #$1FE,d2
                move.w  d2,d0
                addq.w  #8,d0
                andi.w  #$1F0,d0
                rts
; End of function Math_CalcTileOffset3
; Clear 8KB RAM buffer at FF8000
Sys_ClearRAMBuffer8K:
                movea.w #(dword_FF8000-M68K_RAM),a0  ; was: sub_1B8A6
                moveq   #0,d0
                move.w  #$7FF,d7
loc_1B8B0:                              ; CODE XREF: Sys_ClearRAMBuffer8K+C   j
                move.l  d0,(a0)+
                dbf     d7,loc_1B8B0
                rts
; End of function Sys_ClearRAMBuffer8K
; Checks button mode flag before processing input buttons
Input_CheckButtonMode:                              ; CODE XREF: Stage_SnakeTransition+24   p  ; was: sub_1B8B8
                                        ; Stage_BugmaxTransitionCheck+1C   p ...
                btst    #1,(word_FFFF38+1).w
                beq.s   loc_1B8C4
                move.b  #4,d0
loc_1B8C4:                              ; CODE XREF: Input_CheckButtonMode+6   j
                jmp (Input_ProcessButtons).l
; End of function Input_CheckButtonMode
; Maps button input based on game state
Input_GetMappedButton:                              ; CODE XREF: UI_InitializePasswordScreen+56   j  ; was: sub_1B8CA
                                        ; Password_HandleInput+22   j ...
                btst    #1,(word_FFFF38+1).w
                beq.s Input_GetAttackButton
                move.b  #4,d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
; Gets mapped attack button input based on control configuration
Input_GetAttackButton:                              ; CODE XREF: Input_GetMappedButton+6   j  ; was: loc_1B8DC
                move.w  (word_FFA204).w,d0
                asr.w   #1,d0
                move.b  byte_1B8EC(pc,d0.w),d0
                jmp (Input_ProcessButtons).l
; End of function Input_GetMappedButton
; ---------------------------------------------------------------------------
byte_1B8EC:     dc.b $81, $81, $81, $81, $81, $81, $81, $89, $89, $86
                                        ; DATA XREF: Input_GetMappedButton+18   r
                dc.b $86, $86, $89, $92, $92, $8B, $8B, $97, $97, 0
                dc.b $93, $93, $89, $8F, $9F, 0


; Initialize object with random params
Effect_InitRandomizedObject:
                bra.w   *+4  ; was: sub_1B906
; ---------------------------------------------------------------------------
loc_1B90A:                              ; CODE XREF: Effect_InitRandomizedObject   j
                bne.w   locret_1B96E
                move.l  d7,$48(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.w  #1,$18(a0)
                move.l  #$FFFFE000,$58(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$C,d0
                move.l  dword_1B970(pc,d0.w),$1C(a0)
                move.l  #$800,$5C(a0)
                cmpi.w  #8,d0
                bmi.w   locret_1B96E
                move.l  #$FFFFF800,$5C(a0)
locret_1B96E:                           ; CODE XREF: Effect_InitRandomizedObject:loc_1B90A   j
                                        ; Effect_InitRandomizedObject+5C   j
                rts
; End of function Effect_InitRandomizedObject
; ---------------------------------------------------------------------------
dword_1B970:    dc.l $FFFE8000, $FFFF8000, $8000, $18000
                                        ; DATA XREF: Effect_InitRandomizedObject+4A   r


; Clears specific flags from object buffer
Sprite_ClearObjectFlags:                              ; CODE XREF: Boss_JetsripperDeathInit+A   p  ; was: sub_1B980
                                        ; Boss_ShiperInitDefeat+6   p ...
                movea.w #(word_FFC620-M68K_RAM),a0
                moveq   #$3C,d7 ; '<'
                move.b  #$92,d0
loc_1B98A:                              ; CODE XREF: Sprite_ClearObjectFlags+1A   j
                move.b  $21(a0),d1
                and.b   d0,d1
                beq.s   loc_1B996
                clr.b   $21(a0)
loc_1B996:                              ; CODE XREF: Sprite_ClearObjectFlags+10   j
                lea     $60(a0),a0
                dbf     d7,loc_1B98A
                rts
; End of function Sprite_ClearObjectFlags
; Initializes sprite from pointer table with offsets
Sprite_InitFromPointerTable:                              ; CODE XREF: Sprite_InitFromPointerTable+42   j  ; was: sub_1B9A0
                                        ; Boss_ShiperSetupState+136   p ...
                move.w  (a1)+,d0
                cmpi.w  #$FFFE,d0
                bne.s   loc_1B9AA
                rts
; ---------------------------------------------------------------------------
loc_1B9AA:                              ; CODE XREF: Sprite_InitFromPointerTable+6   j
                movea.w d0,a0
                move.b  (a1)+,$21(a0)
                clr.b   $23(a0)
                move.b  (a1)+,d0
                bclr    #0,d0
                beq.s Sprite_SetFlipFlag
                move.b  #$10,$23(a0)
; Sets horizontal flip flag in sprite properties byte
Sprite_SetFlipFlag:                              ; CODE XREF: Sprite_InitFromPointerTable+1A   j  ; was: loc_1B9C2
                lsr.b   #1,d0
                move.b  d0,$25(a0)
                clr.b   $24(a0)
                move.l  (a1)+,$28(a0)
                move.l  (a1)+,$2C(a0)
                moveq   #0,d0
                move.b  (a1)+,d0
                asl.w   #1,d0
                move.w  d0,$26(a0)
                move.b  (a1)+,$23(a0)
                bra.s Sprite_InitFromPointerTable
; End of function Sprite_InitFromPointerTable
; ---------------------------------------------------------------------------
word_1B9E4:     dc.w $C620, $1050, $F010, $F010, 0, 0, $80
                                        ; DATA XREF: Boss_AntroidInitPhase+60   o
                dc.w $C680, $5028, $F010, $F010, $F808, $F808, $2A00
                dc.w $C6E0, $103C, $F808, $F808, 0, 0, 4
                dc.w $C9E0, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w $CA40, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w $CDA0, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w $CE60, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w $FFFE
word_1BA48:     dc.w $C620, $5014, $E61A, $E61A, $E818, $E818, $5B0D
                                        ; DATA XREF: Boss_ShellshogunSetupPhase+128   o
                dc.w $C680, $1038, $F00C, $F40C, 0, 0, $80
                dc.w $C920, $5020, $F808, $F808, $F808, $F808, $5005
                dc.w $C9E0, $1020, $F808, $F808, 0, 0, 5
                dc.w $CD40, $5020, $F808, $F808, $F808, $F808, $5005
                dc.w $CE00, $1020, $F808, $F808, 0, 0, 5
                dc.w $FFFE
word_1BA9E:     dc.w $C620, $5008, $C808, $E214, $C808, $E214, $3C00
                                        ; DATA XREF: Boss_ShiperSetupState+130   o
                dc.w $C680, $5008, $C000, $D81C, $C000, $D81C, $3C00
                dc.w $CB60, $5020, $F40C, $F40C, $FA06, $FA06, $7F05
                dc.w $CAA0, $5020, $F40C, $F40C, $F808, $F808, $7F05
                dc.w $C9E0, $1020, $F40C, $F40C, $F60A, $F60A, $7F05
                dc.w $CBC0, $1030, $F010, $F808, 0, 0, $80
                dc.w $FFFE
word_1BAF4:     dc.w $C620, $5024, $E820, $E020, $EC18, $EC18, $A080
                                        ; DATA XREF: Boss_MadamBarbarSetup+AA   o
                dc.w $C6E0, $1010, $F20E, $F20E, 0, 0, 5
                dc.w $C7A0, $5010, $F20E, $F20E, $F40C, $F40C, $4305
                dc.w $C920, $1010, $F20E, $F20E, 0, 0, 5
                dc.w $C9E0, $5010, $F20E, $F20E, $F40C, $F40C, $4305
                dc.w $FFFE
word_1BB3C:     dc.w $C620, $5038, $E830, $E020, $E830, $E020, $6E80
                                        ; DATA XREF: Boss_JokerSetup+70   o
                dc.w $FFFE
word_1BB4C:     dc.w $C620, $5040, $D40C, $B80C, $D40C, $B80C, $3C88
                                        ; DATA XREF: Boss_TerobusterSetup+A4   o
                dc.w $C6E0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w $C7A0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w $C8C0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w $C980, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w $FFFE
word_1BB94:     dc.w $C620, $5038, 0, 0, 0, 0, $4204
                                        ; DATA XREF: Boss_FlyingNeoSetup+C4   o
                dc.w $C9E0, $5050, $F808, $F20E, $F808, $F20E, $4280
                dc.w $C800, $5008, $F812, $F808, $F812, $F808, $4204
                dc.w $C980, $5008, $F812, $F808, $F812, $F808, $4204
                dc.w $FFFE
word_1BBCE:     dc.w $C620, $5030, $E826, $E020, $E826, $E020, $6C80
                                        ; DATA XREF: Boss_XiTigerSetup+5C   o
                dc.w $C6E0, $1018, $F010, $F010, 0, 0, 5
                dc.w $C7A0, $1018, $F010, $F010, 0, 0, 5
                dc.w $C860, $5000, $EE12, $EE12, $F010, $F010, $B810
                dc.w $C8C0, $1018, $F010, $F010, 0, 0, 5
                dc.w $C980, $1018, $F010, $F010, 0, 0, 5
                dc.w $CA40, $5000, $EE12, $EE12, $F010, $F010, $B810
                dc.w $CB60, $5018, $F010, $F010, $F40C, $F40C, $6C04
                dc.w $CC20, $1018, $F40C, $F40C, 0, 0, 4
                dc.w $CDA0, $5018, $F010, $F010, $F40C, $F40C, $6C04
                dc.w $CE60, $1018, $F40C, $F40C, 0, 0, 4
                dc.w $FFFE
word_1BC6A:     dc.w $C740, $103C, $F010, $F010, $FD0C, $F40C, 0
                                        ; DATA XREF: Boss_DeepStriderIntroRise+36   o
                dc.w $C680, $103C, $F010, $F010, 0, 0, $80
                dc.w $C7A0, $103C, $F40C, $F40C, 0, 0, 0
                dc.w $C860, $1008, $F808, $F808, 0, 0, 0
                dc.w $C8C0, $1008, $FC04, $FC04, 0, 0, 0
                dc.w $FFFE
word_1BCB2:     dc.w $C620, $1014, $F010, $F010, $F010, $F010, $4700
                                        ; DATA XREF: Boss_SharpssteelInit+4A   o
                dc.w $C680, $1014, $E41C, $E41C, $F010, $F010, $4700
                dc.w $C6E0, $1028, $EC14, $EC14, $F010, $F010, $4780
                dc.w $C740, $1014, $F010, $F010, $F010, $F010, $4700
                dc.w $C7A0, $1014, $F010, $F010, $F010, $F010, 0
                dc.w $C800, $1014, $F010, $F010, $F010, $F010, 0
                dc.w $C920, 0, $F010, $F010, $F808, $F808, 0
                dc.w $C980, 0, $F010, $F010, $F010, $F010, 0
                dc.w $CAA0, 0, $F010, $F010, $FA06, $FA06, 0
                dc.w $CB00, 0, $F010, $F010, $FA06, $FA06, 0
                dc.w $CB60, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w $CBC0, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w $CC20, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w $CC80, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w $FFFE
word_1BD78:     dc.w $C620, $502C, $E41C, $E41C, $E41C, $E41C, $3280
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+C   o
                dc.w $C860, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w $CA40, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w $CC20, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w $D400, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w $FFFE
word_1BDC0:     dc.w $C6E0, $1020, $F010, $F010, $F808, $F808, $2204
                                        ; DATA XREF: Boss_BackStringerSpawn+68   o
                dc.w $C740, $1020, $F010, $F010, $F808, $F808, $2204
                dc.w $C7A0, $1038, $EC14, $EC14, $F808, $F808, $2280
                dc.w $FFFE
word_1BDEC:     dc.w $C620, $5004, $E004, $E040, $E0F8, $E030, $4309
                                        ; DATA XREF: Boss_WolfGaropaMovement3+106   o
                dc.w $C8C0, 4, $F010, $F010, $FC04, $FC04, 9
                dc.w $CC80, 4, $F010, $F010, $FC04, $FC04, 9
                dc.w $C800, 4, $F010, $F010, 0, 0, 9
                dc.w $CBC0, 4, $F010, $F010, 0, 0, 9
                dc.w $D0A0, $1008, $F010, $F010, 0, 0, 9
                dc.w $D100, $5028, $F20E, $E818, $FC04, $F80E, $4309
                dc.w $CF80, 8, $F010, $FF24, $F010, $FC04, $2A04
                dc.w $CFE0, $1038, $FC2C, $F010, 0, 0, $84
                dc.w $FFFE
word_1BE6C:     dc.w $C620, $501C, $D010, $F010, $D808, $F808, $6909
                                        ; DATA XREF: Boss_ValkirieInit+F6   o
                dc.w $CB60, $5004, $F010, $F010, $FC04, $FC04, $7D09
                dc.w $CCE0, $5004, $F010, $F010, $FC04, $FC04, $7D09
                dc.w $CC20, $5004, $E41C, $F010, $F808, $FE02, $7D09
                dc.w $CDA0, $5004, $E41C, $F010, $F808, $FE02, $7D09
                dc.w $FFFE
word_1BEB4:     dc.w $C620, $1018, $CC02, $EC14, 0, 0, $8F
                                        ; DATA XREF: Boss_ZLeoIntroInit+192   o
                dc.w $FFFE
word_1BEC4:     dc.w $C620, $5038, $F010, $F010, $EC14, $EC14, $6488
                                        ; DATA XREF: Boss_ValkirieIntroStop+46   o
                dc.w $C6E0, $500C, $F010, $F010, $F010, $F010, $6408
                dc.w $C7A0, $5000, $F60A, $F60A, $F010, $F010, $6410
                dc.w $C980, $5000, $F60A, $F60A, $F010, $F010, $6410
word_1BEFC:     dc.w $CBC0, $5004, $F010, $F010, $FA06, $FA06, $640C
                                        ; DATA XREF: Boss_ValkirieSpawnEffect   o
                dc.w $CE00, $5004, $F010, $F010, $FA06, $FA06, $640C
                dc.w $FFFE
word_1BF1A:     dc.w $C620, $5018, $E020, $E020, $E818, $E41C, $8088
                                        ; DATA XREF: Boss_MedusaMovePattern2+4A   o
                dc.w $FFFE
word_1BF2A:     dc.w $C620, $5040, $EC14, $EC14, $EC14, $EC14, $3888
                                        ; DATA XREF: Boss_SireneShootPattern1+B4   o
                dc.w $C920, $5000, $F010, $F010, $F010, $F010, $3810
                dc.w $CCE0, $5000, $F010, $F010, $F010, $F010, $3810
                dc.w $FFFE
byte_1BF56:     dc.b $D1, 0, $10, $40, $F8, 8, $F8
                                        ; DATA XREF: Boss_ArtemisAttackState1+BA   o
                dc.b 8, 0, 0, 0, 0, 0, $88
word_1BF64:     dc.w $C680, $5004, $F010, $F010, $EC14, $EC14, $2908
                                        ; DATA XREF: Projectile_ArtemisInitSprite1   o
                dc.w $C6E0, $5004, $F010, $F010, $EC14, $EC14, $2908
                dc.w $C7A0, $501C, $F808, $F808, $FA06, $FA06, $2905
                dc.w $FFFE
word_1BF90:     dc.w $C620, $5044, $EC14, $EC14, $EC14, $EC14, $5B08
                                        ; DATA XREF: Boss_Unknown1InitMetasprite+46   o
                dc.w $FFFE
word_1BFA0:     dc.w $C620, $5044, $EC14, $EC14, $EC14, $EC14, $5B08
                                        ; DATA XREF: Boss_ValkirieInitAlt+46   o
                dc.w $FFFE
word_1BFB0:     dc.w $C620, $5040, $EC14, $EC14, $EC14, $EC14, $5B88
                                        ; DATA XREF: Boss_SylpheedAnimationScript+68   o
                dc.w $CB60, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w $CC20, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w $CCE0, $5000, $E41C, $E41C, $FC04, $FC04, $3710
                dc.w $CE60, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w $CF20, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w $CFE0, $5000, $E41C, $E41C, $FC04, $FC04, $3710
                dc.w $FFFE


; Finds free enemy object slot with wraparound search
Sprite_FindFreeEnemySlot:                              ; CODE XREF: Enemy_DestroyOnContact+14   p  ; was: sub_1C014
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$F,d7
loc_1C01A:                              ; CODE XREF: Sprite_FindFreeEnemySlot+E   j
                move.w  (a0),d0
                beq.s   locret_1C026
                lea     $60(a0),a0
                dbf     d7,loc_1C01A
locret_1C026:                           ; CODE XREF: Sprite_FindFreeEnemySlot+8   j
                rts
; End of function Sprite_FindFreeEnemySlot
; Searches for free sprite slot in effect pool for explosions
Sprite_FindFreeEffectSlot:                              ; CODE XREF: Enemy_SpawnFallingHazard+2E   p  ; was: sub_1C028
                movea.w #(word_FFDB20-M68K_RAM),a0
                moveq   #3,d7
loc_1C02E:                              ; CODE XREF: Sprite_FindFreeEffectSlot+E   j
                move.w  (a0),d0
                beq.s   locret_1C03A
                lea     $60(a0),a0
                dbf     d7,loc_1C02E
locret_1C03A:                           ; CODE XREF: Sprite_FindFreeEffectSlot+8   j
                rts
; End of function Sprite_FindFreeEffectSlot
; Allocates free sprite slot with buffer search
Sprite_AllocateSlot:                              ; CODE XREF: Effect_SpawnParticle+16   p  ; was: sub_1C03C
                                        ; sub_175B8:loc_175EE   p ...
                movea.w #(byte_FFC320-M68K_RAM),a0
                moveq   #6,d7
; End of function Sprite_AllocateSlot
; Finds free slot in object array
Sys_FindFreeObjectSlot:                              ; CODE XREF: Effect_FindDashTrailSlot+6   j  ; was: sub_1C042
                                        ; Sprite_InitProjectile+36   p ...
                move.w  (a0),d0
                beq.s   locret_1C04E
                lea     $60(a0),a0
                dbf d7,Sys_FindFreeObjectSlot
locret_1C04E:                           ; CODE XREF: Sys_FindFreeObjectSlot+2   j
                rts
; End of function Sys_FindFreeObjectSlot
; Updates projectile trajectory and rotation
Projectile_UpdateTrajectory:                              ; CODE XREF: Effect_SpawnStarParticle   p  ; was: sub_1C050
                                        ; Projectile_FindFreeSlotAndClear+4   p ...
                movea.w #(word_FFCF80-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C0A4:                              ; CODE XREF: Boss_CaterpillarCheckFreeSlot+4   j
                                        ; Boss_SunsetStingInitHomingProjectile+E   p ...
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C11C:                              ; CODE XREF: Stage_SpawnIntroProjectile+C   p
                                        ; Enemy_FindFreeSpriteSlot+4   j ...
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
loc_1C144:                              ; CODE XREF: Boss_ShiperSpawnProjectile+16   p
                                        ; Boss_TerobusterSpawnHomingMissile+22   p ...
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C168
                lea     $60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
locret_1C168:                           ; CODE XREF: Projectile_UpdateTrajectory+6   j
                                        ; Projectile_UpdateTrajectory+10   j ...
                rts
; End of function Projectile_UpdateTrajectory
; Finds free slot in projectile buffer unrolled search
