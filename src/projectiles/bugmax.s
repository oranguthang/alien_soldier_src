Enemy_BugmaxDebrisFall:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D3C4
                addi.l  #$1000,$1C(a5)
                tst.w   $5C(a5)
                beq.s   loc_4D3D4
                rts
; ---------------------------------------------------------------------------
loc_4D3D4:                                              ; CODE XREF: Boss_BugmaxFallOffScreen+6   j
                                        ; Enemy_BugmaxDebrisFall+C   j
                move.w  a5,d7
                lsr.w   #4,d7
                add.w   (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4D43A
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D43A
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                andi.w  #$7FFF,$E(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   locret_4D43A
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #6,d0
                move.w  word_4D43C(pc,d0.w),d0
                andi.w  #$FF,d0
                jsr     (Sound_PlaySFX).l
locret_4D43A:                                           ; CODE XREF: Enemy_BugmaxDebrisFall+1C   j
                                        ; Enemy_BugmaxDebrisFall+24   j
                rts
; End of function Enemy_BugmaxDebrisFall
; ---------------------------------------------------------------------------
word_4D43C:     dc.w    $BB, $BC, $BB, $C1              ; DATA XREF: Enemy_BugmaxDebrisFall+68   r

; Bugmax debris handler
Enemy_BugmaxDebrisMain:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D444
                addi.l  #$2000,$1C(a5)
                bsr.w   Boss_BugmaxAnimateFlip
                move.w  4(a5),d0
                lea     off_4D45C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BugmaxDebrisMain
; ---------------------------------------------------------------------------
off_4D45C:      dc.w    Enemy_BugmaxDebrisInit-*        ; DATA XREF: Enemy_BugmaxDebrisMain+10   o
                dc.w    Enemy_BugmaxDebrisBounce-*
                dc.w    nullsub_109-*

; Initializes debris piece
Enemy_BugmaxDebrisInit:                                 ; DATA XREF: ROM:off_4D45C   o  ; was: sub_4D462
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   locret_4D47C
                ori.w   #$8000,$E(a5)
locret_4D47C:                                           ; CODE XREF: Enemy_BugmaxDebrisInit+12   j
                rts
; End of function Enemy_BugmaxDebrisInit
; Debris bouncing physics
Enemy_BugmaxDebrisBounce:                               ; DATA XREF: ROM:0004D45E   o  ; was: sub_4D47E
                tst.b   $5F(a5)
                beq.s   loc_4D490
                bclr    #7,$22(a5)
                bne.s   loc_4D4CE
                bsr.w   Enemy_BugmaxDebrisFlicker
loc_4D490:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+4   j
                btst    #7,$1C(a5)
                bne.s   locret_4D4CC
                cmpi.w  #$130,$14(a5)
                blt.s   locret_4D4CC
                move.w  #$130,$14(a5)
                tst.b   $5F(a5)
                bne.s   loc_4D4F2
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4D4CC
                addq.w  #2,4(a5)
locret_4D4CC:                                           ; CODE XREF: Enemy_BugmaxDebrisBounce+18   j
                                        ; Enemy_BugmaxDebrisBounce+20   j
                rts
; ---------------------------------------------------------------------------
loc_4D4CE:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+C   j
                bclr    #4,$22(a5)
                beq.s   loc_4D4DC
                jmp     Sprite_SetPointerClearD7
; ---------------------------------------------------------------------------
loc_4D4DC:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+56   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_4D4F2:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+2C   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$32,$26(a5)                    ; '2'
                jmp     Projectile_CheckLifetime
; End of function Enemy_BugmaxDebrisBounce
; Flickers debris sprite graphics
Enemy_BugmaxDebrisFlicker:                              ; CODE XREF: Enemy_BugmaxDebrisBounce+E   p  ; was: sub_4D506
                tst.b   $5F(a5)
                beq.s   locret_4D538
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                beq.s   locret_4D538
                cmpi.w  #1,d0
                beq.s   loc_4D532
                cmpi.w  #2,d0
                beq.s   loc_4D52A
                move.w  #$C4F7,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4D52A:                                              ; CODE XREF: Enemy_BugmaxDebrisFlicker+1A   j
                move.w  #$C4F6,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4D532:                                              ; CODE XREF: Enemy_BugmaxDebrisFlicker+14   j
                move.w  #$C4F1,$E(a5)
locret_4D538:                                           ; CODE XREF: Enemy_BugmaxDebrisFlicker+4   j
                                        ; Enemy_BugmaxDebrisFlicker+E   j
                rts
; End of function Enemy_BugmaxDebrisFlicker
nullsub_109:                                            ; DATA XREF: ROM:0004D460   o
                rts
; End of function nullsub_109

; Animates sprite flip
Boss_BugmaxAnimateFlip:                                 ; CODE XREF: Enemy_BugmaxDebrisMain+8   p  ; was: sub_4D53C
                                        ; sub_4D608   p
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4D55E
                addq.w  #1,$4A(a5)
                andi.w  #3,$4A(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                move.w  word_4D560(pc,d0.w),d0
                eor.w   d0,$E(a5)
locret_4D55E:                                           ; CODE XREF: Boss_BugmaxAnimateFlip+8   j
                rts
; End of function Boss_BugmaxAnimateFlip
; ---------------------------------------------------------------------------
word_4D560:     dc.w    $1000, $800, $1000, $800
                                        ; DATA XREF: Boss_BugmaxAnimateFlip+1A   r

; Initializes spread projectile with random offset
Projectile_InitBugmaxSpread:                            ; CODE XREF: Boss_BugmaxProjectileAttack+10   p  ; was: sub_4D568
                move.w  #$33C,(a0)
                move.w  #$EF80,2(a0)
                move.l  #off_ECBD0,8(a0)
                move.w  $E(a5),$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FE02FC04,$2C(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$14,$26(a0)
                move.w  #$18,$24(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$40,d0                         ; '@'
                add.w   d0,$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFF,$1C(a0)
                rts
; End of function Projectile_InitBugmaxSpread
; Main controller with screen shake and state machine
Projectile_BugmaxMainController:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D5C8
                tst.l   $1C(a5)
                beq.s   loc_4D5F2
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                beq.s   loc_4D5E6
                subi.w  #$20,$10(a5)                    ; ' '
                subi.w  #$20,$14(a5)                    ; ' '
                bra.s   loc_4D5F2
; ---------------------------------------------------------------------------
loc_4D5E6:                                              ; CODE XREF: Projectile_BugmaxMainController+E   j
                addi.w  #$20,$10(a5)                    ; ' '
                addi.w  #$20,$14(a5)                    ; ' '
loc_4D5F2:                                              ; CODE XREF: Projectile_BugmaxMainController+4   j
                                        ; Projectile_BugmaxMainController+1C   j
                move.w  4(a5),d0
                lea     off_4D5FE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxMainController
; ---------------------------------------------------------------------------
off_4D5FE:      dc.w    Projectile_BugmaxFlyingPhase-*  ; DATA XREF: Projectile_BugmaxMainController+2E   o
                dc.w    Projectile_BugmaxFadeToBlack-*
                dc.w    Projectile_BugmaxExplosionWait-*
                dc.w    Projectile_BugmaxFadeFromBlack-*
                dc.w    nullsub_110-*

; Handles flying phase with collision and explosion
Projectile_BugmaxFlyingPhase:                           ; DATA XREF: ROM:off_4D5FE   o  ; was: sub_4D608
                bsr.w   Boss_BugmaxAnimateFlip
                addi.l  #$800,$1C(a5)
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4D668
                bclr    #7,$22(a5)
                beq.s   loc_4D668
                clr.l   $1C(a5)
                move.w  #$4D80,2(a5)
                move.b  #1,(dword_FF9418+3).w
                clr.w   $5C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D690
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                rts
; ---------------------------------------------------------------------------
loc_4D668:                                              ; CODE XREF: Projectile_BugmaxFlyingPhase+10   j
                                        ; Projectile_BugmaxFlyingPhase+18   j
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                bne.s   loc_4D67C
                tst.w   (dword_FF9428+2).w
                beq.s   locret_4D690
loc_4D67C:                                              ; CODE XREF: Projectile_BugmaxFlyingPhase+6C   j
                move.l  #off_E95DC,8(a5)
                move.w  #$FFFE,$1C(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
locret_4D690:                                           ; CODE XREF: Projectile_BugmaxFlyingPhase+3C   j
                                        ; Projectile_BugmaxFlyingPhase+72   j
                rts
; End of function Projectile_BugmaxFlyingPhase
; Fades screen to black for impact effect
Projectile_BugmaxFadeToBlack:                           ; DATA XREF: ROM:0004D600   o  ; was: sub_4D692
                bsr.w   Gfx_ApplyDualPaletteFade
                subq.w  #2,$5C(a5)
                cmpi.w  #$FFF0,$5C(a5)
                bne.s   locret_4D6AC
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4D6AC:                                           ; CODE XREF: Projectile_BugmaxFadeToBlack+E   j
                rts
; End of function Projectile_BugmaxFadeToBlack
; Waits during explosion with timer countdown
Projectile_BugmaxExplosionWait:                         ; DATA XREF: ROM:0004D602   o  ; was: sub_4D6AE
                bsr.w   Gfx_ApplyDualPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_4D6BC
                addq.w  #2,4(a5)
locret_4D6BC:                                           ; CODE XREF: Projectile_BugmaxExplosionWait+8   j
                rts
; End of function Projectile_BugmaxExplosionWait
; Fades screen back from black after explosion
Projectile_BugmaxFadeFromBlack:                         ; DATA XREF: ROM:0004D604   o  ; was: sub_4D6BE
                bsr.w   Gfx_ApplyDualPaletteFade
                move.w  (word_FFA000).w,d7
                andi.w  #$1F,d7
                bne.s   locret_4D6E6
                addq.w  #2,$5C(a5)
                cmpi.w  #2,$5C(a5)
                bne.s   locret_4D6E6
                clr.b   (dword_FF9418+3).w
                bset    #4,2(a5)
                addq.w  #2,4(a5)
locret_4D6E6:                                           ; CODE XREF: Projectile_BugmaxFadeFromBlack+C   j
                                        ; Projectile_BugmaxFadeFromBlack+18   j
                rts
; End of function Projectile_BugmaxFadeFromBlack
nullsub_110:                                            ; DATA XREF: ROM:0004D606   o
                rts
; End of function nullsub_110

; Applies palette fade to two ranges simultaneously
Gfx_ApplyDualPaletteFade:                               ; CODE XREF: Projectile_BugmaxFadeToBlack   p  ; was: sub_4D6EA
                                        ; sub_4D6AE   p
                move.w  $5C(a5),d0
                move.w  #$1F,d5
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5C(a5),d0
                move.w  #$F,d5
                move.w  #$E000,d7
                lea     (word_FFE360).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_ApplyDualPaletteFade
; Initializes sine wave projectile with angular trajectory
Projectile_InitBugmaxSine:                              ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+10   p  ; was: sub_4D718
                move.w  #$340,(a0)
                move.w  #$EF80,2(a0)
                move.l  #off_ECBDC,8(a0)
                move.w  $E(a5),$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #$80,$23(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F408F408,$28(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #$14,$26(a0)
                move.w  #$FF,$24(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                addi.w  #$40,(dword_FF9428).w           ; '@'
                move.w  (dword_FF9428).w,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  (a2,d0.w),d0
                ext.l   d0
                asl.l   #1,d0
                move.l  d0,$18(a0)
                move.w  $14(a5),$14(a0)
                move.w  $1C(a5),d0
                add.w   d0,$14(a0)
                rts
; End of function Projectile_InitBugmaxSine
; Main controller with collision and bounce physics
Projectile_BugmaxSineController:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D79C
                addi.l  #$2000,$1C(a5)
                tst.w   (dword_FF9428+2).w
                bne.w   loc_4D82E
                bclr    #4,$22(a5)
                bne.w   Projectile_BugmaxSineDestroy
                bclr    #6,$22(a5)
                bne.w   Projectile_BugmaxSineDestroy
                bclr    #7,$22(a5)
                bne.w   loc_4D82E
                move.w  4(a5),d0
                lea     off_4D7D6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxSineController
; ---------------------------------------------------------------------------
off_4D7D6:      dc.w    Projectile_BugmaxSineBounce-*   ; DATA XREF: Projectile_BugmaxSineController+32   o
                dc.w    Projectile_BugmaxSineBounce_BounceLoop-*

; Handles bouncing physics with velocity reversal
Projectile_BugmaxSineBounce:                            ; DATA XREF: ROM:off_4D7D6   o  ; was: sub_4D7DA
                move.w  #3,$48(a5)
                addq.w  #2,4(a5)
; Check ground collision and execute sine bounce pattern
Projectile_BugmaxSineBounce_BounceLoop:                 ; DATA XREF: ROM:0004D7D8   o  ; was: loc_4D7E4
                btst    #7,$1C(a5)
                bne.s   locret_4D82C
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_4D82C
                subq.w  #1,$48(a5)
                beq.w   loc_4D82E
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                move.w  d0,$18(a5)
                move.b  #$E3,d0
                jsr     (Sound_PlaySFX).l
locret_4D82C:                                           ; CODE XREF: Projectile_BugmaxSineBounce+10   j
                                        ; Projectile_BugmaxSineBounce+1E   j
                rts
; ---------------------------------------------------------------------------
loc_4D82E:                                              ; CODE XREF: Projectile_BugmaxSineController+C   j
                                        ; Projectile_BugmaxSineController+2A   j
                move.b  #$E4,d0
                jsr     (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C8,$26(a5)
                move.l  #$FC04F808,$2C(a5)
                jmp     Projectile_CheckLifetime
; End of function Projectile_BugmaxSineBounce
; Destroys sine projectile using destruction pattern
Projectile_BugmaxSineDestroy:                           ; CODE XREF: Projectile_BugmaxSineController+16   j  ; was: sub_4D854
                                        ; Projectile_BugmaxSineController+20   j
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; End of function Projectile_BugmaxSineDestroy
nullsub_111:
                rts
; End of function nullsub_111

; Enables hitbox collision and sets damage values
Boss_BugmaxEnableHitbox:                                ; CODE XREF: Boss_BugmaxAngleCalculateAttack+3E   p  ; was: sub_4D85E
                movea.w #(byte_FFCB60-M68K_RAM),a0
                move.b  #2,$21(a0)
                move.l  #$FC04FC04,$2C(a0)
                clr.b   $22(a0)
                rts
; End of function Boss_BugmaxEnableHitbox
; Manages white flash effect when taking damage
Boss_BugmaxFlashEffect:                                 ; CODE XREF: Boss_BugmaxSpecialAttackUpdate+4   p  ; was: sub_4D876
                                        ; Boss_BugmaxSpecialAttackWait+4   p
                movea.w #(byte_FFCB60-M68K_RAM),a0
                tst.w   $5C(a0)
                bne.s   loc_4D894
                bclr    #1,$22(a0)
                beq.s   locret_4D8C0
                bset    #1,(byte_FF825C).w
                move.w  #2,$5C(a0)
loc_4D894:                                              ; CODE XREF: Boss_BugmaxFlashEffect+8   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_4D8A2
                clr.w   $5C(a0)
                rts
; ---------------------------------------------------------------------------
loc_4D8A2:                                              ; CODE XREF: Boss_BugmaxFlashEffect+24   j
                move.w  #$2BC,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $10(a0),(word_FF8250).w
                move.w  $14(a0),(word_FF8252).w
locret_4D8C0:                                           ; CODE XREF: Boss_BugmaxFlashEffect+10   j
                rts
; End of function Boss_BugmaxFlashEffect
; Disables flash when health drops below threshold
Boss_BugmaxDisableFlashEffect:                          ; CODE XREF: Boss_BugmaxSpecialAttackDecrement+4   p  ; was: sub_4D8C2
                movea.w #(byte_FFCB60-M68K_RAM),a0
                cmpi.w  #$FFF0,(dword_FF9410).w
                bgt.s   Boss_BugmaxFlashEffect
                clr.b   $21(a0)
                rts
; End of function Boss_BugmaxDisableFlashEffect
; Updates all boss parts
Boss_BugmaxUpdateAllParts:                              ; CODE XREF: Boss_BugmaxDefeatRise   p  ; was: sub_4D8D4
                                        ; sub_4C734   p
                movem.w a5,-(sp)
                bsr.w   Boss_BugmaxSpawnProjectile
                move.w  #6,d7
                movea.w #(word_FFC680-M68K_RAM),a5
loc_4D8E4:                                              ; CODE XREF: Boss_BugmaxUpdateAllParts+18   j
                bsr.w   Boss_BugmaxSpawnProjectile
                lea     $60(a5),a5
                dbf     d7,loc_4D8E4
                movem.w (sp)+,a5
                bra.w   Boss_BugmaxAI
; End of function Boss_BugmaxUpdateAllParts
nullsub_112:
                rts
; End of function nullsub_112

; Spawns projectile from boss
Boss_BugmaxSpawnProjectile:                             ; CODE XREF: Boss_BugmaxUpdateAllParts+4   p  ; was: sub_4D8FA
                                        ; sub_4D8D4:loc_4D8E4   p
                bclr    #6,$22(a5)
                beq.w   locret_4DA18
                move.w  #4,(word_FFA014).w
                btst    #7,(dword_FFC638).w
                beq.s   loc_4D92E
                addi.l  #-$4000,(dword_FFC638).w
                cmpi.l  #$FFFE0000,(dword_FFC638).w
                blt.s   loc_4D948
                move.l  #$FFFE0000,(dword_FFC638).w
                bra.s   loc_4D948
; ---------------------------------------------------------------------------
loc_4D92E:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+16   j
                addi.l  #$4000,(dword_FFC638).w
                cmpi.l  #$20000,(dword_FFC638).w
                blt.s   loc_4D948
                move.l  #$20000,(dword_FFC638).w
loc_4D948:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+28   j
                                        ; Boss_BugmaxSpawnProjectile+32   j
                lea     (word_FFCF80).w,a0
                jsr     (loc_1C0A4).l
                bne.w   locret_4DA18
                move.w  #$338,(a0)
                move.w  (dword_FFC630).w,$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #8,$20(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4D988
                andi.b  #7,d0
                bne.s   Boss_BugmaxSetupProjectile
                bra.s   loc_4D98E
; ---------------------------------------------------------------------------
loc_4D988:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+84   j
                andi.b  #3,d0
                bne.s   Boss_BugmaxSetupProjectile
loc_4D98E:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+8C   j
                move.b  #1,$5F(a0)
                move.w  #$8F80,2(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$14,$26(a0)
                move.w  #2,$24(a0)
                move.l  #$FFFC0000,$1C(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                addq.w  #1,d0
                neg.w   d0
                move.w  d0,$18(a0)
                rts
; ---------------------------------------------------------------------------
; Sets up projectile velocity and tile
Boss_BugmaxSetupProjectile:                             ; CODE XREF: Boss_BugmaxSpawnProjectile+8A   j  ; was: loc_4D9E0
                                        ; Boss_BugmaxSpawnProjectile+92   j
                move.w  #$CF80,2(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #1,d0
                lsl.w   #2,d0
                move.l  off_4DA1A(pc,d0.w),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                neg.w   d0
                move.w  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                move.w  d0,$1C(a0)
locret_4DA18:                                           ; CODE XREF: Boss_BugmaxSpawnProjectile+6   j
                                        ; Boss_BugmaxSpawnProjectile+58   j
                rts
; End of function Boss_BugmaxSpawnProjectile
; ---------------------------------------------------------------------------
off_4DA1A:      dc.l    word_ECB1C                      ; DATA XREF: Boss_BugmaxSpawnProjectile+F6   r
                dc.l    word_ECB22

; AI and movement control
