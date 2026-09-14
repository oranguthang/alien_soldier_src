; Antroid pose rendering, linked-part state setup, and facing

; Selects the blinking part descriptors, then renders the current pose
Boss_AntroidRenderBlinkingPose:                         ; CODE XREF: Boss_AntroidIdleState+A   j  ; was: sub_37E8C
                                        ; Boss_AntroidReturnToNeutral+3A   p
                move.l  #Boss_AntroidSpriteMapping01,$C8(a5)
                move.w  (FrameCounter).w,d0
                andi.w  #$7F,d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   Boss_AntroidRenderPose
                btst    #1,d0
                beq.s   Boss_AntroidRenderPose
                move.l  #Boss_AntroidSpriteMapping00,$C8(a5)
; End of function Boss_AntroidRenderBlinkingPose
; Traverses the 25 Antroid metasprite parts for the pose in a1
Boss_AntroidRenderPose:                                 ; CODE XREF: Boss_AntroidHealthRecoveryState+18   p  ; was: sub_37EB0
                                        ; Boss_AntroidPrepareJumpAttack+12   p
                moveq   #$18,d7
                jmp     Sprite_BeginMetaspritePartTraversal
; End of function Boss_AntroidRenderPose
; Selects alternate part descriptors on every other frame
Boss_AntroidSelectBlinkMetasprite:                      ; CODE XREF: Boss_AntroidHealthRecoveryState+38   j  ; was: sub_37EB8
                                        ; Boss_AntroidPrepareJumpAttack+16   j
                move.l  #Boss_AntroidSpriteMapping01,$C8(a5)
                btst    #1,(FrameCounter+1).w
                beq.s   Boss_AntroidSelectBlinkMetaspriteReturn
                move.l  #Boss_AntroidSpriteMapping00,$C8(a5)
Boss_AntroidSelectBlinkMetaspriteReturn:                ; CODE XREF: Boss_AntroidSelectBlinkMetasprite+E   j  ; was: locret_37ED0
                rts
; End of function Boss_AntroidSelectBlinkMetasprite
; Enters state d0 with the first fixed part slot selected initially
Boss_AntroidEnterStateWithFirstPartSlot:                ; CODE XREF: Boss_AntroidReturnToNeutral+E   p  ; was: sub_37ED2
                                        ; Boss_AntroidReturnToNeutral+22   p
                movea.w #(FifteenthEntityType-M68K_RAM),a0
                movea.w #(TwentySixthEntityType-M68K_RAM),a1
                bra.s   Boss_AntroidEnterState
; End of function Boss_AntroidEnterStateWithFirstPartSlot
; Enters state d0 with the second fixed part slot selected initially
Boss_AntroidEnterStateWithSecondPartSlot:               ; CODE XREF: Boss_AntroidLeapAttackA+98   p  ; was: sub_37EDC
                                        ; Boss_AntroidEnterWaitState+2   p
                movea.w #(FifteenthEntityType-M68K_RAM),a1
                movea.w #(TwentySixthEntityType-M68K_RAM),a0
Boss_AntroidEnterState:                                 ; CODE XREF: Boss_AntroidEnterStateWithFirstPartSlot+8   j  ; was: loc_37EE4
                move.w  d0,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                tst.w   6(a5)
                beq.s   Boss_AntroidEnterStateBindParts
                exg     a0,a1
Boss_AntroidEnterStateBindParts:                        ; CODE XREF: Boss_AntroidEnterStateWithSecondPartSlot+26   j  ; was: loc_37F06
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                move.w  #$14E,$14(a0)
                move.w  a1,$11E(a5)
                move.w  a0,$17E(a5)
                move.l  #Boss_AntroidSpriteMapping01,$C8(a5)
                rts
; End of function Boss_AntroidEnterStateWithSecondPartSlot
; Spawns a ram-impact particle at a random offset from Antroid
Boss_AntroidSpawnRamDebris:                             ; CODE XREF: Boss_AntroidUpdateRamAttackPose   p  ; was: sub_37F26
                btst    #0,(FrameCounter+1).w
                bne.s   Boss_AntroidSpawnRamDebrisReturn
                jsr     (Projectile_UpdateWithImpactFrames).l
                bne.s   Boss_AntroidSpawnRamDebrisReturn
                movea.l #Projectile_SpawnSpriteFrames,a1  ; make offsets?
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.l  #$FFFE8000,$1C(a0)
                move.b  (RandomNumberState).w,d0
                move.b  (RandomNumberState+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$F,d1
                subi.w  #$20,d0                         ; ' '
                subq.w  #8,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
Boss_AntroidSpawnRamDebrisReturn:                       ; CODE XREF: Boss_AntroidSpawnRamDebris+6   j  ; was: locret_37F76
                                        ; Boss_AntroidSpawnRamDebris+E   j
                rts
; End of function Boss_AntroidSpawnRamDebris
; Attributes: thunk
; Applies Antroid's defeat-sequence fade value in d0
Boss_AntroidSetDefeatFadeParameters:                    ; CODE XREF: Boss_AntroidDefeatFadeState+1A   p  ; was: sub_37F78
                                        ; Boss_AntroidDefeatDelayState+16   j
                jmp     (Gfx_SetFadeParams).l
; End of function Boss_AntroidSetDefeatFadeParameters
; Faces Antroid toward the player and updates its parts when facing changes
Boss_AntroidFacePlayer:                                 ; CODE XREF: Boss_AntroidReturnToNeutral+114   j  ; was: sub_37F7E
                                        ; sub_379A0   p
                jsr     (Physics_GetPlayerDelta).l
                move.w  $54(a5),d7
                move.w  #$100,$54(a5)
                tst.w   d1
                bmi.s   Boss_AntroidFacePlayerCompare
                move.w  #0,$54(a5)
Boss_AntroidFacePlayerCompare:                          ; CODE XREF: Boss_AntroidFacePlayer+12   j  ; was: loc_37F98
                cmp.w   $54(a5),d7
                beq.w   Boss_AntroidFacingUpdateReturn
; Facing changes fall through so all part attributes are updated immediately
; Applies Antroid's facing bit to each linked metasprite part
Boss_AntroidApplyFacingToParts:                         ; CODE XREF: Boss_AntroidInitPhase+78   p  ; was: sub_37FA0
                                        ; Boss_AntroidInitPosition+1E   p
                moveq   #3,d0
                tst.w   $54(a5)
                bne.s   Boss_AntroidApplyMirroredFacing
                bset    d0,$E(a5)
                bset    d0,$6E(a5)
                bclr    d0,$CE(a5)
                bset    d0,$12E(a5)
                bset    d0,$18E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$42E(a5)
                bset    d0,$84E(a5)
                rts
; ---------------------------------------------------------------------------
Boss_AntroidApplyMirroredFacing:                        ; CODE XREF: Boss_AntroidApplyFacingToParts+6   j  ; was: loc_37FCA
                bclr    d0,$E(a5)
                bclr    d0,$6E(a5)
                bset    d0,$CE(a5)
                bclr    d0,$12E(a5)
                bclr    d0,$18E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$42E(a5)
                bclr    d0,$84E(a5)
Boss_AntroidFacingUpdateReturn:                         ; CODE XREF: Boss_AntroidFacePlayer+1E   j  ; was: locret_37FEA
                rts
; End of function Boss_AntroidApplyFacingToParts
