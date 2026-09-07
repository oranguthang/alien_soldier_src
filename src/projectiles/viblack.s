Boss_BackStringerTimerState:                            ; DATA XREF: ROM:000439F6   o  ; was: sub_43EF0
                subq.w  #1,$48(a5)
                bpl.s   loc_43F10
                addq.w  #2,4(a5)
                bclr    #1,(byte_FF80F8).w
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (stru_114D0).l,a1
                jsr     (loc_116AC).l
loc_43F10:                                              ; CODE XREF: Boss_BackStringerTimerState+4   j
                move.w  $48(a5),d0
                cmpi.w  #$100,d0
                bne.s   loc_43F2C
                jsr     (Stage_TransitionToNextPhase).l
                subq.w  #2,(word_FFA950).w
                move.w  #$FFF0,$54(a5)
                bra.s   loc_43F4E
; ---------------------------------------------------------------------------
loc_43F2C:                                              ; CODE XREF: Boss_BackStringerTimerState+28   j
                bpl.s   loc_43F4A
                cmpi.w  #$E0,d0
                bpl.s   loc_43F4E
                cmpi.w  #$80,d0
                bne.s   loc_43F42
                move.w  #$FFE8,$54(a5)
                bra.s   loc_43F4E
; ---------------------------------------------------------------------------
loc_43F42:                                              ; CODE XREF: Boss_BackStringerTimerState+48   j
                bpl.s   loc_43F4A
                cmpi.w  #$40,d0                         ; '@'
                bpl.s   loc_43F4E
loc_43F4A:                                              ; CODE XREF: Boss_BackStringerTimerState:loc_43F2C   j
                                        ; sub_43EF0:loc_43F42   j
                clr.w   $4E(a5)
loc_43F4E:                                              ; CODE XREF: Boss_BackStringerTimerState+3A   j
                                        ; Boss_BackStringerTimerState+42   j
                bsr.w   Boss_ViblackUpdatePosAndPalette
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   locret_43F64
                bpl.w   loc_43E78
                bra.w   loc_43E58
; ---------------------------------------------------------------------------
locret_43F64:                                           ; CODE XREF: Boss_BackStringerTimerState+6A   j
                rts
; End of function Boss_BackStringerTimerState
; Sets downward velocity
Boss_BackStringerSetDownVelocity:                       ; DATA XREF: ROM:000439F8   o  ; was: sub_43F66
                move.w  #$FFB4,$54(a5)
                clr.w   $4E(a5)
                bra.w   Boss_ViblackUpdatePosAndPalette
; End of function Boss_BackStringerSetDownVelocity
; Final state transition with palette load
Boss_BackStringerTransitionFinish:                      ; DATA XREF: ROM:000439FA   o  ; was: sub_43F74
                bsr.w   Boss_BackStringerSpawnDebris
                bsr.w   loc_43FD8
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   loc_43F8E
                bpl.w   loc_43E78
                bra.w   loc_43E58
; ---------------------------------------------------------------------------
loc_43F8E:                                              ; CODE XREF: Boss_BackStringerTransitionFinish+10   j
                bsr.w   loc_43EB4
                move.w  #$1000,2(a5)
                move.l  #$60A45441,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                lea     (byte_C484).l,a0
                jmp     LoadPalette
; End of function Boss_BackStringerTransitionFinish
; Updates sprite and spawns projectiles
Boss_ViblackUpdateSpriteAndSpawn:                       ; CODE XREF: Boss_ViblackDefeatWait   p  ; was: sub_43FBC
                                        ; sub_43DC0   p
                bsr.w   Sound_ViblackPeriodic
                bsr.w   Boss_ViblackSpawnRandomProjectiles
; End of function Boss_ViblackUpdateSpriteAndSpawn
; Updates position, palette and spawns rings
Boss_ViblackUpdateAll:                                  ; CODE XREF: Boss_ViblackDefeatInit:loc_43D90   p  ; was: sub_43FC4
                bsr.s   Boss_ViblackUpdatePosition
                lea     word_43B0A(pc),a4
                jsr     (VBlank_UpdateSharpssteelPalette).l
                bra.w   Boss_ViblackSpawnRandomRings
; End of function Boss_ViblackUpdateAll
; Updates position and palette
Boss_ViblackUpdatePosAndPalette:                        ; CODE XREF: Boss_ViblackRopePhysics+4   p  ; was: sub_43FD4
                                        ; sub_43EF0:loc_43F4E   p
                bsr.w   Boss_ViblackSpawnRandomProjectile2
loc_43FD8:                                              ; CODE XREF: Boss_BackStringerTransitionFinish+4   p
                bsr.s   Boss_ViblackUpdatePosition
                lea     word_43B0A(pc),a4
                jmp     (VBlank_UpdateSharpssteelPalette).l
; End of function Boss_ViblackUpdatePosAndPalette
; Updates Viblack position
Boss_ViblackUpdatePosition:                             ; CODE XREF: Boss_ViblackDescend+4   p  ; was: sub_43FE4
                                        ; Boss_ViblackFallOffScreen+4   p
                bsr.s   Boss_ViblackUpdateAngle
                bra.w   Boss_ViblackSpawnRing
; End of function Boss_ViblackUpdatePosition
; Updates rotation angle
Boss_ViblackUpdateAngle:                                ; CODE XREF: Boss_ViblackInit+E0   j  ; was: sub_43FEA
                                        ; sub_43FE4   p
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(dword_FF8A00-M68K_RAM),a1
                moveq   #9,d7
loc_43FF4:                                              ; CODE XREF: Boss_ViblackUpdateAngle+C   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_43FF4
                movea.w #(word_FF9480-M68K_RAM),a0
                move.w  #0,d0
                moveq   #$13,d7
loc_44004:                                              ; CODE XREF: Boss_ViblackUpdateAngle+1C   j
                move.w  d0,(a0)+
                dbf     d7,loc_44004
                moveq   #0,d0
                move.w  #$120,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  #$168,d0
                add.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                neg.w   d0
                movea.w #(dword_FF9410-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                lea     dword_440B0(pc),a2
                nop
                move.w  $4E(a5),d1
                asl.w   #2,d1
                andi.w  #$1C,d1
                move.l  (a2,d1.w),d1
                moveq   #7,d7
loc_44044:                                              ; CODE XREF: Boss_ViblackUpdateAngle+64   j
                swap    d0
                add.l   d1,d0
                swap    d0
                move.w  d0,-(a0)
                move.w  d0,(a1)+
                dbf     d7,loc_44044
                movea.w #(dword_FF9410-M68K_RAM),a0
                movea.w #(dword_FF9418-M68K_RAM),a1
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d0
                neg.w   d0
                moveq   #1,d7
loc_44064:                                              ; CODE XREF: Boss_ViblackUpdateAngle+84   j
                swap    d0
                sub.l   d1,d0
                swap    d0
                move.w  d0,(a0)+
                move.w  d0,-(a1)
                dbf     d7,loc_44064
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a1
                moveq   #$13,d7
                move.w  (dword_FFA908).w,d0
                addi.w  #$F,d0
                move.w  d0,d1
                asr.w   #4,d1
                bpl.s   loc_4409A
                add.w   d1,d7
                bmi.s   locret_440AE
                move.w  d0,d1
                asr.w   #3,d1
                andi.w  #$FFFE,d1
                suba.w  d1,a1
                bra.s   Boss_ViblackCopyPalette
; ---------------------------------------------------------------------------
loc_4409A:                                              ; CODE XREF: Boss_ViblackUpdateAngle+9E   j
                sub.w   d1,d7
                bmi.s   locret_440AE
                move.w  d0,d1
                asr.w   #3,d1
                andi.w  #$FFFE,d1
                adda.w  d1,a0
; Copies palette data words in loop
Boss_ViblackCopyPalette:                                ; CODE XREF: Boss_ViblackUpdateAngle+AE   j  ; was: loc_440A8
                                        ; Boss_ViblackUpdateAngle+C0   j
                move.w  (a0)+,(a1)+
                dbf     d7,Boss_ViblackCopyPalette
locret_440AE:                                           ; CODE XREF: Boss_ViblackUpdateAngle+A2   j
                                        ; Boss_ViblackUpdateAngle+B2   j
                rts
; End of function Boss_ViblackUpdateAngle
; ---------------------------------------------------------------------------
dword_440B0:    dc.l    0, $FFFE8000, $FFFE0000, $FFFF0000
                                        ; DATA XREF: Boss_ViblackUpdateAngle+44   o
                dc.l    0, $18000, $20000, $10000

; Spawns ring projectile
Boss_ViblackSpawnRing:                                  ; CODE XREF: Boss_ViblackUpdatePosition+2   j  ; was: sub_440D0
                move.w  $10(a5),$10(a4)
                move.w  (dword_FFA410).w,d0
                subi.w  #$80,d0
                bmi.s   locret_440FE
                cmpi.w  #$140,d0
                bpl.s   locret_440FE
                asr.w   #3,d0
                andi.w  #$FFFE,d0
                addi.w  #-$6B80,d0
                movea.w d0,a0
                move.w  (a0),d0
                neg.w   d0
                subi.w  #$168,d0
                move.w  d0,$14(a4)
locret_440FE:                                           ; CODE XREF: Boss_ViblackSpawnRing+E   j
                                        ; Boss_ViblackSpawnRing+14   j
                rts
; End of function Boss_ViblackSpawnRing
; Sets random target position
Boss_ViblackSetRandomTarget:                            ; CODE XREF: Boss_ViblackAttackState+14   j  ; was: sub_44100
                move.w  #2,$50(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$740,d0
                move.w  d0,$52(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                addi.w  #$E0,d0
                move.w  d0,$54(a5)
                rts
; End of function Boss_ViblackSetRandomTarget
; Spawns ring projectiles at random positions
Boss_ViblackSpawnRandomRings:                           ; CODE XREF: Boss_ViblackUpdateAll+C   j  ; was: sub_44128
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4418C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_4418C
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E95DC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_44178
                move.l  #off_E953C,8(a0)
loc_44178:                                              ; CODE XREF: Boss_ViblackSpawnRandomRings+46   j
                jsr     (Projectile_InitType88).l
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                addq.w  #5,d0
                move.w  d0,$1C(a0)
locret_4418C:                                           ; CODE XREF: Boss_ViblackSpawnRandomRings+6   j
                                        ; Boss_ViblackSpawnRandomRings+E   j
                rts
; End of function Boss_ViblackSpawnRandomRings
; Spawns random projectiles
Boss_ViblackSpawnRandomProjectile2:                     ; CODE XREF: Boss_ViblackUpdatePosAndPalette   p  ; was: sub_4418E
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_441EA
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.l  #off_E96FC,8(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_441D6
                move.l  #off_E95C0,8(a0)
loc_441D6:                                              ; CODE XREF: Boss_ViblackSpawnRandomProjectile2+3E   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #1,d0
                subq.w  #3,d0
                move.w  d0,$1C(a0)
                jmp     Projectile_InitType88
; ---------------------------------------------------------------------------
locret_441EA:                                           ; CODE XREF: Boss_ViblackSpawnRandomProjectile2+6   j
                rts
; End of function Boss_ViblackSpawnRandomProjectile2
; Spawns random projectiles and debris
Boss_BackStringerSpawnDebris:                           ; CODE XREF: Boss_BackStringerTransitionFinish   p  ; was: sub_441EC
                btst    #0,(word_FFA000+1).w
                bne.w   locret_4427A
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_4427A
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_44212
                jsr     (Effect_InitDebrisSprite).l
                bra.w   loc_44246
; ---------------------------------------------------------------------------
loc_44212:                                              ; CODE XREF: Boss_BackStringerSpawnDebris+1A   j
                jsr     (Projectile_InitType88).l
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFD,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_44246
                move.l  #off_E96FC,8(a0)
                clr.w   $1C(a0)
loc_44246:                                              ; CODE XREF: Boss_BackStringerSpawnDebris+22   j
                                        ; Boss_BackStringerSpawnDebris+4C   j
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #8,d0
                addi.w  #$C,d0
                move.b  d0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$F,d0
                andi.w  #7,d1
                subq.w  #8,d0
                subq.w  #8,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_4427A:                                           ; CODE XREF: Boss_BackStringerSpawnDebris+6   j
                                        ; Boss_BackStringerSpawnDebris+10   j
                rts
; End of function Boss_BackStringerSpawnDebris
; Spawns random projectiles periodically
Boss_ViblackSpawnRandomProjectiles:                     ; CODE XREF: Boss_ViblackUpdateSpriteAndSpawn+4   p  ; was: sub_4427C
                btst    #0,(word_FFA000+1).w
                bne.w   locret_43C44
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_43C44
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$A0,d0
                move.w  d0,$14(a0)
                lea     (Cutscene_XiTigerCompletionSpriteFrames).l,a1
                move.w  #9,$1C(a0)
                jmp     Sprite_InitFromTable
; End of function Boss_ViblackSpawnRandomProjectiles
; Calculates movement toward target using arctan2
Boss_ViblackMoveToTarget:                               ; CODE XREF: Boss_ViblackDefeatCheck+8   p  ; was: sub_442C2
                                        ; Boss_ViblackStartAttackPhase+4   p
                move.w  $52(a5),d0
                move.w  $54(a5),d1
                sub.w   $5E(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_Arctan2Lookup).l
                asr.w   #7,d2
                andi.w  #$1FE,d2
                move.w  $50(a5),d3
                bmi.s   loc_442EA
                cmpi.w  #6,d3
                bpl.s   loc_442F0
loc_442EA:                                              ; CODE XREF: Boss_ViblackMoveToTarget+20   j
                addq.w  #2,d3
                move.w  d3,$50(a5)
loc_442F0:                                              ; CODE XREF: Boss_ViblackMoveToTarget+26   j
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  d3,d0
                muls.w  d3,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                move.w  $5E(a5),d2
                sub.w   $52(a5),d2
                bpl.s   loc_44316
                neg.w   d2
loc_44316:                                              ; CODE XREF: Boss_ViblackMoveToTarget+50   j
                cmpi.w  #2,d2
                beq.s   loc_4431E
                bpl.s   loc_44350
loc_4431E:                                              ; CODE XREF: Boss_ViblackMoveToTarget+58   j
                move.w  $14(a5),d2
                sub.w   $54(a5),d2
                bpl.s   loc_4432A
                neg.w   d2
loc_4432A:                                              ; CODE XREF: Boss_ViblackMoveToTarget+64   j
                cmpi.w  #2,d2
                beq.s   loc_44332
                bpl.s   loc_44350
loc_44332:                                              ; CODE XREF: Boss_ViblackMoveToTarget+6C   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  $52(a5),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  $54(a5),$14(a5)
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------
loc_44350:                                              ; CODE XREF: Boss_ViblackMoveToTarget+5A   j
                                        ; Boss_ViblackMoveToTarget+6E   j
                moveq   #1,d0
locret_44352:                                           ; CODE XREF: Sound_ViblackPeriodic+8   j
                rts
; End of function Boss_ViblackMoveToTarget
; Plays Viblack sound effect every 4 frames
Sound_ViblackPeriodic:                                  ; CODE XREF: Boss_ViblackDescend   p  ; was: sub_44354
                                        ; sub_43B84   p
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_44352
                move.b  #$CD,d0
                jmp     (Sound_PlaySFX).l
; End of function Sound_ViblackPeriodic
; Periodically spawns walker shot projectiles
Boss_ViblackSpawnWalkerShot:                            ; CODE XREF: Boss_ViblackDefeatCheck+4   p  ; was: sub_44368
                                        ; Boss_ViblackAttackState+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$FF,d0
                cmpi.w  #$2F,d0                         ; '/'
                bpl.w   locret_43C44
                andi.w  #$F,d0
                bne.w   locret_43C44
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_43C44
                move.w  #$6F0,d0
                btst    #0,(word_FFA000).w
                bne.s   loc_4439A
                move.w  #$810,d0
loc_4439A:                                              ; CODE XREF: Boss_ViblackSpawnWalkerShot+2C   j
                sub.w   (dword_FFA900).w,d0
                jmp     Projectile_Stage17WalkerShot
; End of function Boss_ViblackSpawnWalkerShot
; Spawns chain of connected projectiles
Boss_ViblackSpawnChain:                                 ; CODE XREF: Boss_ViblackDefeatCheck+42   p  ; was: sub_443A4
                cmpi.w  #$CE,$14(a5)
                bmi.w   locret_44482
                movea.w #(word_FFC6E0-M68K_RAM),a0
                tst.w   (a0)
                beq.s   loc_443C0
                movea.w #(word_FFC740-M68K_RAM),a0
                tst.w   (a0)
                bne.w   locret_44482
loc_443C0:                                              ; CODE XREF: Boss_ViblackSpawnChain+10   j
                move.b  #$CE,d0
                jsr     (Sound_PlaySFX).l
                movea.w #(dword_FFA100-M68K_RAM),a1
                move.w  a0,(a1)+
                moveq   #9,d6
loc_443D2:                                              ; CODE XREF: Boss_ViblackSpawnChain+44   j
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.w   locret_44482
                move.w  #$10,(a0)
                bset    #4,2(a0)
                move.w  a0,(a1)+
                dbf     d6,loc_443D2
                movea.w #(dword_FFA100-M68K_RAM),a3
                movea.w (a3)+,a0
                move.w  #$2EC,(a0)
                move.w  #$8D00,2(a0)
                move.w  #$2E,$24(a0)                    ; '.'
                move.w  #$80,$40(a0)
                move.w  #$10,$44(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #2,d0
                move.w  d0,$42(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7E,d0                         ; '~'
                addi.w  #$140,d0
                move.w  d0,6(a0)
                bsr.w   Boss_ViblackInitChainSegment
                movea.w a0,a1
                movea.w a0,a2
                adda.w  #$48,a1                         ; 'H'
                move.w  (dword_FFA900).w,d4
                add.w   $10(a5),d4
                move.w  $14(a5),d5
                moveq   #9,d6
loc_44444:                                              ; CODE XREF: Boss_ViblackSpawnChain+DA   j
                movea.w (a3)+,a0
                move.w  #$2F0,(a0)
                move.w  #$8000,2(a0)
                move.w  a0,(a1)+
                move.w  a2,6(a0)
                move.w  d4,$48(a0)
                move.w  d4,$4A(a0)
                move.w  d4,$4C(a0)
                move.w  d4,$4E(a0)
                move.w  d5,$50(a0)
                move.w  d5,$52(a0)
                move.w  d5,$54(a0)
                move.w  d5,$56(a0)
                bsr.s   Boss_ViblackInitChainSegment
                move.w  #$7000,$24(a0)
                dbf     d6,loc_44444
locret_44482:                                           ; CODE XREF: Boss_ViblackSpawnChain+6   j
                                        ; Boss_ViblackSpawnChain+18   j
                rts
; End of function Boss_ViblackSpawnChain
; Initializes chain segment object properties
Boss_ViblackInitChainSegment:                           ; CODE XREF: Boss_ViblackSpawnChain+86   p  ; was: sub_44484
                                        ; Boss_ViblackSpawnChain+D2   p
                clr.w   4(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #$7C,$20(a0)                    ; '|'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                clr.b   $21(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$4E,$26(a0)                    ; 'N'
                rts
; End of function Boss_ViblackInitChainSegment
; Chain projectile main handler
Projectile_ViblackChainMain:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_444C2
                tst.w   (word_FF808C).w
                bpl.s   loc_444CE
                tst.w   $24(a5)
                bpl.s   loc_44514
loc_444CE:                                              ; CODE XREF: Projectile_ViblackChainMain+4   j
                movea.w a5,a1
                adda.w  #$48,a1                         ; 'H'
                moveq   #2,d6
                moveq   #9,d7
loc_444D8:                                              ; CODE XREF: Projectile_ViblackChainMain+28   j
                movea.w (a1)+,a0
                clr.b   $21(a0)
                move.w  d6,6(a0)
                move.w  #4,4(a0)
                addq.w  #2,d6
                dbf     d7,loc_444D8
                clr.l   $18(a5)
                clr.l   $1C(a5)
loc_444F6:                                              ; CODE XREF: Projectile_ViblackChainSegment+1A   j
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                move.l  #$42000,$1C(a5)
                lea     (Projectile_SpawnSpriteFrames).l,a1  ; make offsets?
                jmp     Sprite_InitCurrentFromTable
; ---------------------------------------------------------------------------
loc_44514:                                              ; CODE XREF: Projectile_ViblackChainMain+A   j
                cmpi.w  #$200,$14(a5)
                bmi.s   loc_44538
                bset    #4,2(a5)
                movea.w a5,a1
                adda.w  #$48,a1                         ; 'H'
                moveq   #9,d7
loc_4452A:                                              ; CODE XREF: Projectile_ViblackChainMain+70   j
                movea.w (a1)+,a0
                move.w  #2,4(a0)
                dbf     d7,loc_4452A
                rts
; ---------------------------------------------------------------------------
loc_44538:                                              ; CODE XREF: Projectile_ViblackChainMain+58   j
                andi.w  #$1F8,6(a5)
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  $14(a5),d1
                move.w  6(a5),d3
                addi.w  #$20,d3                         ; ' '
                asr.w   #5,d3
                andi.w  #$E,d3
                moveq   #0,d7
                tst.w   $44(a5)
                bpl.s   loc_44570
                move.w  #$8000,d7
                move.b  #$10,$20(a5)
                move.b  #$C0,$21(a5)
loc_44570:                                              ; CODE XREF: Projectile_ViblackChainMain+9C   j
                lea     word_4469E(pc),a0
                nop
                move.w  (a0,d3.w),$E(a5)
                or.w    d7,$E(a5)
                or.w    d7,d3
                movea.w a5,a3
                adda.w  #$48,a3                         ; 'H'
                moveq   #9,d7
loc_4458A:                                              ; CODE XREF: Projectile_ViblackChainMain+F2   j
                movea.w (a3)+,a0
                movea.w a0,a1
                movea.w a0,a2
                adda.w  #$48,a0                         ; 'H'
                adda.w  #$50,a1                         ; 'P'
                adda.w  #$58,a2                         ; 'X'
                moveq   #3,d6
loc_4459E:                                              ; CODE XREF: Projectile_ViblackChainMain+EE   j
                move.w  (a0),d2
                move.w  d0,(a0)+
                move.w  d2,d0
                move.w  (a1),d2
                move.w  d1,(a1)+
                move.w  d2,d1
                move.w  (a2),d2
                move.w  d3,(a2)+
                move.w  d2,d3
                dbf     d6,loc_4459E
                dbf     d7,loc_4458A
                move.w  6(a5),d2
                moveq   #$14,d3
                tst.w   $44(a5)
                bpl.s   loc_445C6
                moveq   #$F,d3
loc_445C6:                                              ; CODE XREF: Projectile_ViblackChainMain+100   j
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                ext.l   d1
                muls.w  d3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a5)
                move.l  d1,$18(a5)
                subq.w  #1,$44(a5)
                bpl.s   locret_44622
                move.w  $40(a5),d2
                sub.w   6(a5),d2
                bmi.w   loc_44616
                bne.s   loc_44608
                eori.w  #2,$42(a5)
                move.w  $42(a5),d0
                move.w  word_44624(pc,d0.w),$40(a5)
                rts
; ---------------------------------------------------------------------------
loc_44608:                                              ; CODE XREF: Projectile_ViblackChainMain+132   j
                cmpi.w  #$100,d2
                bpl.w   Projectile_ViblackChainAdjustY
loc_44610:                                              ; CODE XREF: Projectile_ViblackChainMain+158   j
                addq.w  #8,6(a5)
                rts
; ---------------------------------------------------------------------------
loc_44616:                                              ; CODE XREF: Projectile_ViblackChainMain+12E   j
                cmpi.w  #$FF00,d2
                bmi.w   loc_44610
; Adjusts Y velocity for chain projectile
Projectile_ViblackChainAdjustY:                         ; CODE XREF: Projectile_ViblackChainMain+14A   j  ; was: loc_4461E
                subq.w  #8,6(a5)
locret_44622:                                           ; CODE XREF: Projectile_ViblackChainMain+124   j
                rts
; End of function Projectile_ViblackChainMain
; ---------------------------------------------------------------------------
word_44624:     dc.w    $10, $F0                        ; DATA XREF: Projectile_ViblackChainMain+13E   r

; Chain segment handler
Projectile_ViblackChainSegment:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_44628
                tst.w   4(a5)
                beq.s   loc_44648
                cmpi.w  #4,4(a5)
                beq.s   loc_4463E
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4463E:                                              ; CODE XREF: Projectile_ViblackChainSegment+C   j
                subq.w  #1,6(a5)
                bmi.w   loc_444F6
                rts
; ---------------------------------------------------------------------------
loc_44648:                                              ; CODE XREF: Projectile_ViblackChainSegment+4   j
                movea.w 6(a5),a0
                move.w  $4E(a5),d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  $56(a5),$14(a5)
                move.w  $5E(a5),d3
                moveq   #0,d0
                bclr    #$F,d3
                beq.s   Projectile_ViblackChainSetGraphics
                move.b  #$10,$20(a5)
                move.w  #$8000,d0
                move.b  #$C0,$21(a5)
; Sets graphics tile and priority for chain
Projectile_ViblackChainSetGraphics:                     ; CODE XREF: Projectile_ViblackChainSegment+40   j  ; was: loc_4467A
                lea     word_4469E(pc),a1
                nop
                move.w  (a1,d3.w),$E(a5)
                or.w    d0,$E(a5)
                move.w  #$7000,d0
                sub.w   $24(a5),d0
                sub.w   d0,$24(a0)
                move.w  #$7000,$24(a5)
                rts
; End of function Projectile_ViblackChainSegment
; ---------------------------------------------------------------------------
word_4469E:     dc.w    $6389, $7380, $7392, $7B80, $6B89, $6B80, $6392, $6380
                                        ; DATA XREF: Projectile_ViblackChainMain:loc_44570   o
                                        ; sub_44628:loc_4467A   o

; Main boss handler dispatcher
