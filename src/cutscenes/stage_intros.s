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
