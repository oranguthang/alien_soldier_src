Boss_JampanAIController:                                ; CODE XREF: Enemy_JampanMinion   p  ; was: sub_4A07E
                                        ; sub_498F2   p
                bsr.s   Boss_JampanUpdateFacing
                tst.w   (word_FFFF0E).w
                beq.s   locret_4A088
                bsr.s   Boss_JampanUpdateFacing
locret_4A088:                                           ; CODE XREF: Boss_JampanAIController+6   j
                rts
; End of function Boss_JampanAIController
; Updates boss facing direction
Boss_JampanUpdateFacing:                                ; CODE XREF: Boss_JampanAIController   p  ; was: sub_4A08A
                                        ; Boss_JampanAIController+8   p
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                beq.s   locret_4A0A6
                tst.w   d0
                bmi.s   loc_4A09E
                move.w  #1,d1
                bra.s   loc_4A0A2
; ---------------------------------------------------------------------------
loc_4A09E:                                              ; CODE XREF: Boss_JampanUpdateFacing+C   j
                move.w  #$FFFF,d1
loc_4A0A2:                                              ; CODE XREF: Boss_JampanUpdateFacing+12   j
                add.w   d1,$10(a5)
locret_4A0A6:                                           ; CODE XREF: Boss_JampanUpdateFacing+8   j
                rts
; End of function Boss_JampanUpdateFacing
; Adjusts Y position to track player
Boss_JampanTrackPlayerY:                                ; CODE XREF: Boss_JampanDefeatWait+8   p  ; was: sub_4A0A8
                move.w  (dword_FFA414).w,d0
                sub.w   $14(a5),d0
                beq.s   locret_4A0C4
                tst.w   d0
                bmi.s   loc_4A0BC
                move.w  #1,d1
                bra.s   loc_4A0C0
; ---------------------------------------------------------------------------
loc_4A0BC:                                              ; CODE XREF: Boss_JampanTrackPlayerY+C   j
                move.w  #$FFFF,d1
loc_4A0C0:                                              ; CODE XREF: Boss_JampanTrackPlayerY+12   j
                add.w   d1,$14(a5)
locret_4A0C4:                                           ; CODE XREF: Boss_JampanTrackPlayerY+8   j
                rts
; End of function Boss_JampanTrackPlayerY
; Calculates angle and aims at player
Boss_JampanAimAtPlayer:                                 ; CODE XREF: Enemy_JampanMinion+4   p  ; was: sub_4A0C6
                                        ; sub_49992   p
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                andi.w  #$FF,d0
                subi.w  #$80,d0
                asr.w   #2,d0
                cmpi.w  #$100,d2
                bcc.s   loc_4A0E0
                neg.w   d0
loc_4A0E0:                                              ; CODE XREF: Boss_JampanAimAtPlayer+16   j
                move.w  (dword_FF9424+2).w,d1
                sub.w   d1,d0
                beq.s   locret_4A0F6
                tst.w   d0
                bmi.s   loc_4A0F2
                addq.w  #1,(dword_FF9424+2).w
                bra.s   locret_4A0F6
; ---------------------------------------------------------------------------
loc_4A0F2:                                              ; CODE XREF: Boss_JampanAimAtPlayer+24   j
                subq.w  #1,(dword_FF9424+2).w
locret_4A0F6:                                           ; CODE XREF: Boss_JampanAimAtPlayer+20   j
                                        ; Boss_JampanAimAtPlayer+2A   j
                rts
; End of function Boss_JampanAimAtPlayer
; Teleport attack init
Boss_JampanTeleportInit:                                ; CODE XREF: Boss_JampanSpawnMinion   p  ; was: sub_4A0F8
                                        ; sub_49666   p
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                sub.w   (dword_FF9428).w,d0
                beq.s   locret_4A114
                tst.w   d0
                bmi.s   loc_4A110
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_4A110:                                              ; CODE XREF: Boss_JampanTeleportInit+10   j
                subq.w  #1,(dword_FF9428).w
locret_4A114:                                           ; CODE XREF: Boss_JampanTeleportInit+C   j
                rts
; End of function Boss_JampanTeleportInit
nullsub_97:                                             ; CODE XREF: Enemy_JampanMinion+C   p
                rts
; End of function nullsub_97

; Enables all 6 shield entities
Boss_JampanEnableShields:                               ; CODE XREF: Boss_JampanPreAttackDelay+12   p  ; was: sub_4A118
                                        ; Boss_JampanDefeatTransition+10   p
                move.w  #5,d7
                movea.w #(byte_FFCE60-M68K_RAM),a0
loc_4A120:                                              ; CODE XREF: Boss_JampanEnableShields+12   j
                ori.w   #$8000,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A120
                move.b  #$40,(byte_FFCE81).w            ; '@'
                move.w  #$A0,(word_FFCE86).w
                move.l  #$F808F808,(dword_FFCE8C).w
                rts
; End of function Boss_JampanEnableShields
; Disables all 6 shield entities
Boss_JampanDisableShields:                              ; CODE XREF: Boss_JampanAttackFinish+1A   p  ; was: sub_4A144
                                        ; Boss_JampanDebrisFadeout+12   p
                move.w  #5,d7
                movea.w #(byte_FFCE60-M68K_RAM),a0
loc_4A14C:                                              ; CODE XREF: Boss_JampanDisableShields+12   j
                andi.w  #$7FFF,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A14C
                clr.b   (byte_FFCE81).w
                rts
; End of function Boss_JampanDisableShields
; Spawns defeat debris
Boss_JampanDefeatDebris:                                ; CODE XREF: Boss_JampanPreAttackDelay+16   p  ; was: sub_4A160
                                        ; Boss_JampanAttackWarmup+C   p
                move.w  (dword_FF942C).w,d4
                move.w  (word_FFC8AA).w,d5
                move.w  (word_FFC8AC).w,d6
                move.w  (word_FFC8AE).w,d7
                add.w   (dword_FF9400).w,d5
                add.w   (dword_FF9404).w,d6
                add.w   (dword_FF9408).w,d7
                add.w   (dword_FF9424+2).w,d5
                add.w   (dword_FF9428).w,d6
                add.w   (dword_FF9428+2).w,d7
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                movea.w #(word_FFC860-M68K_RAM),a1
                movea.w #(byte_FFD040-M68K_RAM),a0
                bsr.w   Boss_JampanFlashOnDamage
                movea.w a0,a1
                lea     -$60(a0),a0
                move.w  #4,d0
loc_4A1AA:                                              ; CODE XREF: Boss_JampanDefeatDebris+60   j
                bsr.w   Boss_JampanFlashOnDamage
                move.w  (word_FFD04E).w,$E(a0)
                move.b  (byte_FFD060).w,$20(a0)
                movea.w a0,a1
                lea     -$60(a0),a0
                dbf     d0,loc_4A1AA
                cmpi.w  #$52,4(a5)                      ; 'R'
                bcc.s   loc_4A1D6
                move.w  (word_FFCE6E).w,d0
                andi.w  #$8000,d0
                bne.s   loc_4A1DC
loc_4A1D6:                                              ; CODE XREF: Boss_JampanDefeatDebris+6A   j
                clr.b   (byte_FFCE81).w
                rts
; ---------------------------------------------------------------------------
loc_4A1DC:                                              ; CODE XREF: Boss_JampanDefeatDebris+74   j
                move.b  #$40,(byte_FFCE81).w            ; '@'
                rts
; End of function Boss_JampanDefeatDebris
; Main AI for Jampan shield entity
Enemy_JampanShieldMain:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A1E4
                cmpi.w  #$52,(word_FFC624).w            ; 'R'
                bcc.w   loc_4A2F0
                cmpi.w  #$180,$14(a5)
                bcs.s   loc_4A1FE
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A1FE:                                              ; CODE XREF: Enemy_JampanShieldMain+10   j
                tst.l   $4C(a5)
                beq.s   loc_4A20C
                move.l  $4C(a5),d0
                add.l   d0,$1C(a5)
loc_4A20C:                                              ; CODE XREF: Enemy_JampanShieldMain+1E   j
                move.w  4(a5),d0
                lea     off_4A218(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_JampanShieldMain
; ---------------------------------------------------------------------------
off_4A218:      dc.w    Enemy_JampanShieldInit-*        ; DATA XREF: Enemy_JampanShieldMain+2C   o
                dc.w    Enemy_JampanShieldBounce-*
                dc.w    Enemy_JampanShieldAttack-*
                dc.w    Enemy_JampanShieldFire-*
                dc.w    nullsub_102-*

; Initializes shield with fall speed
Enemy_JampanShieldInit:                                 ; DATA XREF: ROM:off_4A218   o  ; was: sub_4A222
                move.l  #$2000,$4C(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_JampanShieldInit
; Handles shield bouncing at Y=$128
Enemy_JampanShieldBounce:                               ; DATA XREF: ROM:0004A21A   o  ; was: sub_4A236
                cmpi.w  #$128,$14(a5)
                bcs.s   locret_4A26E
                move.w  #$128,$14(a5)
                subq.w  #1,$48(a5)
                beq.s   loc_4A25C
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                tst.w   $1C(a5)
                bne.s   locret_4A26E
loc_4A25C:                                              ; CODE XREF: Enemy_JampanShieldBounce+12   j
                clr.l   $1C(a5)
                clr.l   $4C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4A26E:                                           ; CODE XREF: Enemy_JampanShieldBounce+6   j
                                        ; Enemy_JampanShieldBounce+24   j
                rts
; End of function Enemy_JampanShieldBounce
; Initiates shield attack with SFX
Enemy_JampanShieldAttack:                               ; DATA XREF: ROM:0004A21C   o  ; was: sub_4A270
                subq.w  #1,$48(a5)
                bne.s   locret_4A2B0
                move.w  #$BB,d0
                jsr     (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$E020E020,$2C(a5)
                move.w  #$FFFA,$1C(a5)
                move.w  #2,$48(a5)
                move.w  #4,$4A(a5)
                addq.w  #2,4(a5)
locret_4A2B0:                                           ; CODE XREF: Enemy_JampanShieldAttack+4   j
                rts
; End of function Enemy_JampanShieldAttack
; Spawns projectile from shield
Enemy_JampanShieldFire:                                 ; DATA XREF: ROM:0004A21E   o  ; was: sub_4A2B2
                subq.w  #1,$48(a5)
                bne.s   locret_4A2EE
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_4A2E8
                move.l  #off_E95A4,8(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
                move.l  #$4000,$1C(a0)
                jsr     (Projectile_InitType88).l
                subq.w  #1,$4A(a5)
                beq.s   loc_4A2F0
loc_4A2E8:                                              ; CODE XREF: Enemy_JampanShieldFire+C   j
                move.w  #2,$48(a5)
locret_4A2EE:                                           ; CODE XREF: Enemy_JampanShieldFire+4   j
                rts
; ---------------------------------------------------------------------------
loc_4A2F0:                                              ; CODE XREF: Enemy_JampanShieldMain+6   j
                                        ; Enemy_JampanShieldFire+34   j
                move.l  #off_E953C,8(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Enemy_JampanShieldFire
nullsub_102:                                            ; DATA XREF: ROM:0004A220   o
                rts
; End of function nullsub_102

; Shadow effect main handler
Boss_JampanShadowMain:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A300
                bsr.s   Boss_JampanShadowDispatcher
                tst.w   $54(a5)
                beq.s   locret_4A314
                move.w  $54(a5),d0
                addi.w  #-$20,d0
                move.w  d0,$4C(a5)
locret_4A314:                                           ; CODE XREF: Boss_JampanShadowMain+6   j
                rts
; End of function Boss_JampanShadowMain
; Shadow effect dispatcher
Boss_JampanShadowDispatcher:                            ; CODE XREF: Boss_JampanShadowMain   p  ; was: sub_4A316
                move.w  4(a5),d0
                lea     off_4A322(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanShadowDispatcher
; ---------------------------------------------------------------------------
off_4A322:      dc.w    Boss_JampanShadowInit-*         ; DATA XREF: Boss_JampanShadowDispatcher+4   o
                dc.w    Boss_JampanShadowAnimate-*
                dc.w    nullsub_103-*

; Shadow effect initialization
Boss_JampanShadowInit:                                  ; DATA XREF: ROM:off_4A322   o  ; was: sub_4A328
                tst.w   $52(a5)
                beq.s   locret_4A33E
                move.w  #8,$50(a5)
                addq.w  #2,4(a5)
                move.w  #4,$56(a5)
locret_4A33E:                                           ; CODE XREF: Boss_JampanShadowInit+4   j
                rts
; End of function Boss_JampanShadowInit
; Shadow animation handler
Boss_JampanShadowAnimate:                               ; DATA XREF: ROM:0004A324   o  ; was: sub_4A340
                move.w  $56(a5),d0
                add.w   d0,$54(a5)
                tst.w   $54(a5)
                beq.s   loc_4A360
                subq.w  #1,$50(a5)
                bne.s   locret_4A35E
                move.w  #$10,$50(a5)
                neg.w   $56(a5)
locret_4A35E:                                           ; CODE XREF: Boss_JampanShadowAnimate+12   j
                rts
; ---------------------------------------------------------------------------
loc_4A360:                                              ; CODE XREF: Boss_JampanShadowAnimate+C   j
                subq.w  #2,4(a5)
                rts
; End of function Boss_JampanShadowAnimate
nullsub_103:                                            ; DATA XREF: ROM:0004A326   o
                rts
; End of function nullsub_103

; Updates boss position
Boss_JampanUpdatePosition:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A368
                bsr.s   Boss_JampanUpdateAnimation
                movea.w $50(a5),a1
                move.b  $20(a1),$20(a5)
                lea     (Math_SineTable).l,a2
                move.w  $4A(a5),d2
                move.w  $48(a5),d3
                move.w  (a2,d2.w),d0
                move.w  -$80(a2,d2.w),d1
                muls.w  d3,d0
                muls.w  d3,d1
                add.l   $10(a1),d0
                add.l   $14(a1),d1
                move.l  d0,$10(a5)
                move.l  d1,$14(a5)
                move.b  $20(a5),d0
                cmp.b   (byte_FFC640).w,d0
                bhi.s   loc_4A3B0
                ori.w   #$8000,$E(a5)
                bra.s   locret_4A3B6
; ---------------------------------------------------------------------------
loc_4A3B0:                                              ; CODE XREF: Boss_JampanUpdatePosition+3E   j
                andi.w  #$7FFF,$E(a5)
locret_4A3B6:                                           ; CODE XREF: Boss_JampanUpdatePosition+46   j
                rts
; End of function Boss_JampanUpdatePosition
; Updates boss animation
Boss_JampanUpdateAnimation:                             ; CODE XREF: Boss_JampanUpdatePosition   p  ; was: sub_4A3B8
                move.w  4(a5),d0
                lea     off_4A3C4(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanUpdateAnimation
; ---------------------------------------------------------------------------
off_4A3C4:      dc.w    Boss_JampanUpdateSprite-*       ; DATA XREF: Boss_JampanUpdateAnimation+4   o
                dc.w    Boss_JampanUpdatePalette-*
                dc.w    Boss_JampanAimTracking-*

; Updates boss sprite
Boss_JampanUpdateSprite:                                ; DATA XREF: ROM:off_4A3C4   o  ; was: sub_4A3CA
                tst.w   $52(a5)
                beq.w   locret_4A3D6
                addq.w  #2,4(a5)
locret_4A3D6:                                           ; CODE XREF: Boss_JampanUpdateSprite+4   j
                rts
; End of function Boss_JampanUpdateSprite
; Updates boss palette
Boss_JampanUpdatePalette:                               ; DATA XREF: ROM:0004A3C6   o  ; was: sub_4A3D8
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                sub.w   $4A(a5),d0
                bpl.s   loc_4A3E8
                neg.w   d0
loc_4A3E8:                                              ; CODE XREF: Boss_JampanUpdatePalette+C   j
                cmpi.w  #4,d0
                bls.s   loc_4A3F2
                move.w  d2,$4A(a5)
loc_4A3F2:                                              ; CODE XREF: Boss_JampanUpdatePalette+14   j
                cmpi.w  #$1C,$48(a5)
                beq.s   loc_4A3FE
                addq.w  #2,$48(a5)
loc_4A3FE:                                              ; CODE XREF: Boss_JampanUpdatePalette+20   j
                tst.w   $52(a5)
                bne.w   locret_4A40A
                addq.w  #2,4(a5)
locret_4A40A:                                           ; CODE XREF: Boss_JampanUpdatePalette+2A   j
                rts
; End of function Boss_JampanUpdatePalette
; Smooth aim tracking at player
Boss_JampanAimTracking:                                 ; DATA XREF: ROM:0004A3C8   o  ; was: sub_4A40C
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d0
                sub.w   $4A(a5),d0
                bpl.s   loc_4A41C
                neg.w   d0
loc_4A41C:                                              ; CODE XREF: Boss_JampanAimTracking+C   j
                cmpi.w  #4,d0
                bls.s   loc_4A426
                move.w  d2,$4A(a5)
loc_4A426:                                              ; CODE XREF: Boss_JampanAimTracking+14   j
                subq.w  #2,$48(a5)
                bne.s   locret_4A430
                clr.w   4(a5)
locret_4A430:                                           ; CODE XREF: Boss_JampanAimTracking+1E   j
                rts
; End of function Boss_JampanAimTracking
; Teleport fade out
Boss_JampanTeleportFadeOut:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A432
                bsr.s   Boss_JampanTeleportMove
                movea.w $50(a5),a1
                move.b  $20(a1),$20(a5)
                move.l  $10(a1),$10(a5)
                move.l  $14(a1),$14(a5)
                move.b  $20(a5),d0
                cmp.b   (byte_FFC640).w,d0
                bhi.s   loc_4A45C
                ori.w   #$8000,$E(a5)
                bra.s   locret_4A462
; ---------------------------------------------------------------------------
loc_4A45C:                                              ; CODE XREF: Boss_JampanTeleportFadeOut+20   j
                andi.w  #$7FFF,$E(a5)
locret_4A462:                                           ; CODE XREF: Boss_JampanTeleportFadeOut+28   j
                rts
; End of function Boss_JampanTeleportFadeOut
; Teleport movement
Boss_JampanTeleportMove:                                ; CODE XREF: Boss_JampanTeleportFadeOut   p  ; was: sub_4A464
                move.w  4(a5),d0
                lea     off_4A470(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanTeleportMove
; ---------------------------------------------------------------------------
off_4A470:      dc.w    Boss_JampanTeleportFadeIn-*     ; DATA XREF: Boss_JampanTeleportMove+4   o
                dc.w    Boss_JampanTeleportComplete-*
                dc.w    Boss_JampanComboAttack-*
                dc.w    Boss_JampanSpecialAttack-*

; Teleport fade in
Boss_JampanTeleportFadeIn:                              ; DATA XREF: ROM:off_4A470   o  ; was: sub_4A478
                tst.w   $52(a5)
                beq.s   locret_4A488
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4A488:                                           ; CODE XREF: Boss_JampanTeleportFadeIn+4   j
                rts
; End of function Boss_JampanTeleportFadeIn
; Teleport completion
Boss_JampanTeleportComplete:                            ; DATA XREF: ROM:0004A472   o  ; was: sub_4A48A
                subq.w  #1,$48(a5)
                bne.s   locret_4A4A0
                ori.w   #$8000,2(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4A4A0:                                           ; CODE XREF: Boss_JampanTeleportComplete+4   j
                rts
; End of function Boss_JampanTeleportComplete
; Combo attack sequence
Boss_JampanComboAttack:                                 ; DATA XREF: ROM:0004A474   o  ; was: sub_4A4A2
                subq.w  #1,$48(a5)
                bne.s   locret_4A4F2
                move.w  #4,$48(a5)
                move.w  $4A(a5),d0
                move.l  off_4A4F4(pc,d0.w),8(a5)
                addq.w  #4,$4A(a5)
                tst.w   $52(a5)
                bpl.s   loc_4A4E6
                cmpi.w  #$FFFE,$52(a5)
                bne.s   loc_4A4D4
                cmpi.w  #$C,$4A(a5)
                beq.s   loc_4A4DC
                bra.s   loc_4A4E6
; ---------------------------------------------------------------------------
loc_4A4D4:                                              ; CODE XREF: Boss_JampanComboAttack+26   j
                cmpi.w  #8,$4A(a5)
                bne.s   loc_4A4E6
loc_4A4DC:                                              ; CODE XREF: Boss_JampanComboAttack+2E   j
                clr.w   $52(a5)
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A4E6:                                              ; CODE XREF: Boss_JampanComboAttack+1E   j
                                        ; Boss_JampanComboAttack+30   j
                cmpi.w  #$18,$4A(a5)
                bne.s   locret_4A4F2
                addq.w  #2,4(a5)
locret_4A4F2:                                           ; CODE XREF: Boss_JampanComboAttack+4   j
                                        ; Boss_JampanComboAttack+4A   j
                rts
; End of function Boss_JampanComboAttack
; ---------------------------------------------------------------------------
off_4A4F4:      dc.l    word_EC268                      ; DATA XREF: Boss_JampanComboAttack+10   r
                dc.l    word_EC274
                dc.l    word_EC280
                dc.l    word_EC274
                dc.l    word_EC268
                dc.l    word_EC25C

; Special attack pattern
Boss_JampanSpecialAttack:                               ; DATA XREF: ROM:0004A476   o  ; was: sub_4A50C
                subq.w  #1,$48(a5)
                beq.s   locret_4A538
                clr.w   $4A(a5)
                andi.w  #$7FFF,2(a5)
                tst.w   $52(a5)
                bmi.s   loc_4A528
                subq.w  #1,$52(a5)
                beq.s   loc_4A534
loc_4A528:                                              ; CODE XREF: Boss_JampanSpecialAttack+14   j
                move.w  #4,$48(a5)
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4A534:                                              ; CODE XREF: Boss_JampanSpecialAttack+1A   j
                clr.w   4(a5)
locret_4A538:                                           ; CODE XREF: Boss_JampanSpecialAttack+4   j
                rts
; End of function Boss_JampanSpecialAttack
; Formation attack main handler
Boss_JampanFormationMain:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A53A
                move.w  4(a5),d0
                lea     off_4A546(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanFormationMain
; ---------------------------------------------------------------------------
off_4A546:      dc.w    Boss_JampanFormationInit-*      ; DATA XREF: Boss_JampanFormationMain+4   o
                dc.w    Boss_JampanFormationWait-*
                dc.w    Boss_JampanFormationUpdate-*
                dc.w    Boss_JampanDefeatExplosion-*

; Formation attack initialization
Boss_JampanFormationInit:                               ; DATA XREF: ROM:off_4A546   o  ; was: sub_4A54E
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
loc_4A556:                                              ; CODE XREF: Boss_JampanFormationInit+14   j
                move.l  #$200000,$54(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4A556
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanFormationInit
; Formation wait for trigger
Boss_JampanFormationWait:                               ; DATA XREF: ROM:0004A548   o  ; was: sub_4A56C
                tst.w   $52(a5)
                beq.s   locret_4A57C
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4A57C:                                           ; CODE XREF: Boss_JampanFormationWait+4   j
                rts
; End of function Boss_JampanFormationWait
; Updates formation positions
Boss_JampanFormationUpdate:                             ; DATA XREF: ROM:0004A54A   o  ; was: sub_4A57E
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
                clr.w   d6
loc_4A588:                                              ; CODE XREF: Boss_JampanFormationUpdate+28   j
                move.l  dword_4A5BC(pc,d6.w),d0
                add.l   d0,$54(a0)
                add.l   d0,$54(a0)
                move.w  $54(a0),$4C(a0)
                andi.w  #$1FF,$4C(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4A588
                subq.w  #1,$48(a5)
                bne.s   locret_4A5BA
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4A5BA:                                           ; CODE XREF: Boss_JampanFormationUpdate+30   j
                rts
; End of function Boss_JampanFormationUpdate
; ---------------------------------------------------------------------------
dword_4A5BC:    dc.l    $FFFFF800, $FFFFF000, $FFFFE000, $FFFFE000, $FFFFE000, $FFFFF000, $FFFFF800
                                        ; DATA XREF: Boss_JampanFormationUpdate:loc_4A588   r
                dc.l    $4000, $8000, $C000, $C000, $8000, $4000

; Defeat explosion effect
