Boss_JampanTeleportAttempt:                             ; DATA XREF: ROM:000491FE   o  ; was: sub_49A14
                eori.w  #$8000,(word_FFC862).w
                bsr.w   Boss_JampanTeleportInit
                bsr.w   Boss_JampanDamageHandler
                move.w  $5A(a5),d0
                move.w  d0,d1
                add.w   $58(a5),d0
                cmpi.w  #$1440,d0
                bhi.s   loc_49A66
                cmpi.w  #$1300,d0
                bcs.s   loc_49A66
                add.w   d1,$10(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_49A78
                ori.w   #$8000,(word_FFC862).w
                move.w  #1,(word_FFC8B2).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                tst.w   (word_FF8234).w
                ble.s   loc_49A66
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_49A66:                                              ; CODE XREF: Boss_JampanTeleportAttempt+1C   j
                                        ; Boss_JampanTeleportAttempt+22   j
                ori.w   #$8000,(word_FFC862).w
                bset    #1,$4C(a5)
                move.w  #$12,4(a5)
locret_49A78:                                           ; CODE XREF: Boss_JampanTeleportAttempt+2C   j
                rts
; End of function Boss_JampanTeleportAttempt
nullsub_98:                                             ; DATA XREF: ROM:00049200   o
                rts
; End of function nullsub_98

nullsub_99:                                             ; DATA XREF: ROM:00049202   o
                rts
; End of function nullsub_99

; Waits for velocity dampening to complete
Boss_JampanWaitVelocityStop:                            ; DATA XREF: ROM:00049204   o  ; was: sub_49A7E
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9428).w
                beq.s   loc_49AA2
                tst.w   (dword_FF9428).w
                bmi.s   loc_49A9C
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49A9C:                                              ; CODE XREF: Boss_JampanWaitVelocityStop+16   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49AA2:                                              ; CODE XREF: Boss_JampanWaitVelocityStop+10   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanWaitVelocityStop
; Delays before attack while spawning debris
Boss_JampanPreAttackDelay:                              ; DATA XREF: ROM:00049206   o  ; was: sub_49AAE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49ACC
                bsr.w   Boss_JampanEnableShields
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #2,4(a5)
locret_49ACC:                                           ; CODE XREF: Boss_JampanPreAttackDelay+10   j
                rts
; End of function Boss_JampanPreAttackDelay
; Warms up attack by incrementing counter
Boss_JampanAttackWarmup:                                ; DATA XREF: ROM:00049208   o  ; was: sub_49ACE
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #1,(dword_FF942C).w
                cmpi.w  #$18,(dword_FF942C).w
                bne.s   locret_49AF4
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_49AF4:                                           ; CODE XREF: Boss_JampanAttackWarmup+1A   j
                rts
; End of function Boss_JampanAttackWarmup
; Prepares attack with delay and sound
Boss_JampanAttackPrepare:                               ; DATA XREF: ROM:0004920A   o  ; was: sub_49AF6
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49B28
                move.w  #$14,$48(a5)
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                move.w  #$D1,d0
                jsr     (Sound_PlaySFX).l
locret_49B28:                                           ; CODE XREF: Boss_JampanAttackPrepare+14   j
                rts
; End of function Boss_JampanAttackPrepare
; Moves boss upward during attack
Boss_JampanAttackRiseUp:                                ; DATA XREF: ROM:0004920C   o  ; was: sub_49B2A
                addq.w  #4,(dword_FF9404).w
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49B62
                move.w  #$14,$48(a5)
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.w  #$A1,d0
                jsr     (Sound_PlaySFX).l
locret_49B62:                                           ; CODE XREF: Boss_JampanAttackRiseUp+14   j
                rts
; End of function Boss_JampanAttackRiseUp
; Moves boss downward with player alignment
Boss_JampanAttackDescend:                               ; DATA XREF: ROM:0004920E   o  ; was: sub_49B64
                subq.w  #4,(dword_FF9404).w
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,$48(a5)
                bne.w   locret_49BBA
                bset    #1,$4C(a5)
                tst.w   (word_FF8234).w
                ble.s   loc_49BA6
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   loc_49B94
                neg.w   d0
loc_49B94:                                              ; CODE XREF: Boss_JampanAttackDescend+2C   j
                cmpi.w  #$80,d0
                bcc.s   loc_49BA6
                move.w  #$10,$48(a5)
                subq.w  #4,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_49BA6:                                              ; CODE XREF: Boss_JampanAttackDescend+22   j
                                        ; Boss_JampanAttackDescend+34   j
                move.w  #2,(word_FFC6D2).w
                move.w  #2,(word_FFC792).w
                clr.b   (byte_FFCE81).w
                addq.w  #2,4(a5)
locret_49BBA:                                           ; CODE XREF: Boss_JampanAttackDescend+14   j
                rts
; End of function Boss_JampanAttackDescend
; Finishes attack by hiding minions
Boss_JampanAttackFinish:                                ; DATA XREF: ROM:00049210   o  ; was: sub_49BBC
                bsr.w   Boss_JampanAimAtPlayer
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #1,(dword_FF942C).w
                bne.s   locret_49BE4
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                bsr.w   Boss_JampanDisableShields
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_49BE4:                                           ; CODE XREF: Boss_JampanAttackFinish+10   j
                rts
; End of function Boss_JampanAttackFinish
; Delays after attack before returning to idle
Boss_JampanPostAttackDelay:                             ; DATA XREF: ROM:00049212   o  ; was: sub_49BE6
                bsr.w   Boss_JampanDamageHandler
                subq.w  #1,$48(a5)
                bne.s   locret_49C02
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #$12,4(a5)
locret_49C02:                                           ; CODE XREF: Boss_JampanPostAttackDelay+8   j
                rts
; End of function Boss_JampanPostAttackDelay
; Resets velocities and minion states
Boss_JampanResetFromAttack:                             ; DATA XREF: ROM:00049214   o  ; was: sub_49C04
                bsr.w   Boss_JampanDamageHandler
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49C1E
                tst.w   (dword_FF9424+2).w
                bmi.s   loc_49C1A
                subq.w  #1,(dword_FF9424+2).w
                bra.s   loc_49C1E
; ---------------------------------------------------------------------------
loc_49C1A:                                              ; CODE XREF: Boss_JampanResetFromAttack+E   j
                addq.w  #1,(dword_FF9424+2).w
loc_49C1E:                                              ; CODE XREF: Boss_JampanResetFromAttack+8   j
                                        ; Boss_JampanResetFromAttack+14   j
                tst.w   (dword_FF9428).w
                beq.s   loc_49C36
                tst.w   (dword_FF9428).w
                bmi.s   loc_49C30
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49C30:                                              ; CODE XREF: Boss_JampanResetFromAttack+24   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49C36:                                              ; CODE XREF: Boss_JampanResetFromAttack+1E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_49C70
                bclr    #2,$4C(a5)
                clr.l   $1C(a5)
                clr.l   $54(a5)
                clr.w   (word_FFC8B2).w
                move.w  #3,(word_FFC6D2).w
                move.w  #3,(word_FFC792).w
                andi.w  #$1FC,(dword_FF9408).w
                move.w  #4,(dword_FF9414).w
                move.w  #4,(dword_FF9410).w
                addq.w  #2,4(a5)
locret_49C70:                                           ; CODE XREF: Boss_JampanResetFromAttack+36   j
                rts
; End of function Boss_JampanResetFromAttack
; Handles defeat transition at rotation $180
Boss_JampanDefeatTransition:                            ; DATA XREF: ROM:00049216   o  ; was: sub_49C72
                bsr.w   Boss_JampanDamageHandler
                cmpi.w  #$180,(dword_FF9408).w
                bne.s   locret_49C8E
                clr.w   (dword_FF9414).w
                bsr.w   Boss_JampanEnableShields
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #2,4(a5)
locret_49C8E:                                           ; CODE XREF: Boss_JampanDefeatTransition+A   j
                rts
; End of function Boss_JampanDefeatTransition
; Increments counter during defeat fade
Boss_JampanDefeatFadeout:                               ; DATA XREF: ROM:00049218   o  ; was: sub_49C90
                cmpi.l  #$80000,(dword_FF9410).w
                beq.s   loc_49CA2
                addi.l  #$4000,(dword_FF9410).w
loc_49CA2:                                              ; CODE XREF: Boss_JampanDefeatFadeout+8   j
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                addq.w  #1,(dword_FF942C).w
                cmpi.w  #$18,(dword_FF942C).w
                bcs.s   locret_49CC6
                move.w  #$18,(dword_FF942C).w
                move.w  #$A0,(word_FFCE86).w
                addq.w  #2,4(a5)
locret_49CC6:                                           ; CODE XREF: Boss_JampanDefeatFadeout+24   j
                rts
; End of function Boss_JampanDefeatFadeout
; Initializes defeat sequence with timer
Boss_JampanDefeatInitAlt:                               ; DATA XREF: ROM:0004921A   o  ; was: sub_49CC8
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                move.w  #$100,$48(a5)
                addq.w  #2,4(a5)
                bclr    #1,$4C(a5)
                rts
; End of function Boss_JampanDefeatInitAlt
; Waits during defeat, decrements timer
Boss_JampanDefeatWait:                                  ; DATA XREF: ROM:0004921C   o  ; was: sub_49CE2
                cmpi.w  #$C0,$48(a5)
                bcs.s   loc_49CEE
                bsr.w   Boss_JampanTrackPlayerY
loc_49CEE:                                              ; CODE XREF: Boss_JampanDefeatWait+6   j
                bsr.w   Boss_JampanAIController
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                tst.w   (word_FF8234).w
                ble.s   loc_49D06
                subq.w  #1,$48(a5)
                bne.s   locret_49D10
loc_49D06:                                              ; CODE XREF: Boss_JampanDefeatWait+1C   j
                bset    #1,$4C(a5)
                addq.w  #2,4(a5)
locret_49D10:                                           ; CODE XREF: Boss_JampanDefeatWait+22   j
                rts
; End of function Boss_JampanDefeatWait
; Returns boss Y position to center
Boss_JampanReturnToCenter:                              ; DATA XREF: ROM:0004921E   o  ; was: sub_49D12
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                move.w  $14(a5),d0
                subi.w  #$F0,d0
                beq.s   loc_49D34
                tst.w   d0
                bpl.s   loc_49D2E
                addq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_49D2E:                                              ; CODE XREF: Boss_JampanReturnToCenter+14   j
                subq.w  #1,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_49D34:                                              ; CODE XREF: Boss_JampanReturnToCenter+10   j
                bset    #2,$4C(a5)
                move.l  #$FFFF0000,$1C(a5)
                move.l  #$2000,$54(a5)
                andi.w  #$1F8,(dword_FF9404).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanReturnToCenter
; Waits for rotation angle to reach $100
Boss_JampanWaitRotation:                                ; DATA XREF: ROM:00049220   o  ; was: sub_49D56
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                cmpi.w  #$100,(dword_FF9404).w
                bne.s   locret_49D6E
                clr.w   (dword_FF9410).w
                addq.w  #2,4(a5)
locret_49D6E:                                           ; CODE XREF: Boss_JampanWaitRotation+E   j
                rts
; End of function Boss_JampanWaitRotation
; Decrements debris counter during fadeout
Boss_JampanDebrisFadeout:                               ; DATA XREF: ROM:00049222   o  ; was: sub_49D70
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                subq.w  #4,(dword_FF942C).w
                bhi.s   locret_49D90
                clr.w   (dword_FF942C).w
                bsr.w   Boss_JampanDisableShields
                andi.w  #$1F8,(dword_FF9408).w
                addq.w  #2,4(a5)
locret_49D90:                                           ; CODE XREF: Boss_JampanDebrisFadeout+C   j
                rts
; End of function Boss_JampanDebrisFadeout
; Rotates angle by 8 per frame until $100
Boss_JampanRotateToCenter:                              ; DATA XREF: ROM:00049224   o  ; was: sub_49D92
                bsr.w   Boss_JampanDamageHandler
                addq.w  #8,(dword_FF9408).w
                andi.w  #$1F8,(dword_FF9408).w
                cmpi.w  #$100,(dword_FF9408).w
                bne.s   locret_49DAE
                move.w  #$12,4(a5)
locret_49DAE:                                           ; CODE XREF: Boss_JampanRotateToCenter+14   j
                rts
; End of function Boss_JampanRotateToCenter
nullsub_100:                                            ; DATA XREF: ROM:00049226   o
                rts
; End of function nullsub_100

; Flash effect during defeat
Boss_JampanDefeatFlash:                                 ; DATA XREF: ROM:00049228   o  ; was: sub_49DB2
                bsr.w   Boss_JampanDamageHandler
                bsr.w   Boss_JampanDefeatDebris
                tst.w   (dword_FF942C).w
                beq.s   loc_49DC6
                subq.w  #1,(dword_FF942C).w
                rts
; ---------------------------------------------------------------------------
loc_49DC6:                                              ; CODE XREF: Boss_JampanDefeatFlash+C   j
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49DDC
                tst.w   (dword_FF9424+2).w
                bmi.s   loc_49DD8
                subq.w  #1,(dword_FF9424+2).w
                bra.s   loc_49DDC
; ---------------------------------------------------------------------------
loc_49DD8:                                              ; CODE XREF: Boss_JampanDefeatFlash+1E   j
                addq.w  #1,(dword_FF9424+2).w
loc_49DDC:                                              ; CODE XREF: Boss_JampanDefeatFlash+18   j
                                        ; Boss_JampanDefeatFlash+24   j
                tst.w   (dword_FF9424+2).w
                beq.s   loc_49DF4
                tst.w   (dword_FF9428).w
                bmi.s   loc_49DEE
                subq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49DEE:                                              ; CODE XREF: Boss_JampanDefeatFlash+34   j
                addq.w  #1,(dword_FF9428).w
                rts
; ---------------------------------------------------------------------------
loc_49DF4:                                              ; CODE XREF: Boss_JampanDefeatFlash+2E   j
                tst.w   (dword_FF9424+2).w
                bne.s   locret_49E24
                bclr    #2,$4C(a5)
                clr.l   $1C(a5)
                clr.l   $54(a5)
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9414).w
                ori.w   #$8000,(word_FFC862).w
                clr.b   $21(a5)
                move.b  #1,(byte_FF830E).w
                addq.w  #2,4(a5)
locret_49E24:                                           ; CODE XREF: Boss_JampanDefeatFlash+46   j
                rts
; End of function Boss_JampanDefeatFlash
; Screen shake during defeat
Boss_JampanDefeatShake:                                 ; DATA XREF: ROM:0004922A   o  ; was: sub_49E26
                addi.l  #$200,$1C(a5)
                bsr.w   Boss_JampanDefeatDebris
                bsr.w   Boss_JampanDamageHandler
                jsr     (Boss_SpawnExplosionDebris).l
                cmpi.w  #$110,$14(a5)
                bcs.s   locret_49E62
                bsr.w   Boss_JampanDisableShields
                clr.l   $1C(a5)
                move.w  #$110,$14(a5)
                andi.w  #$1FE,(dword_FF9408).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_49E62:                                           ; CODE XREF: Boss_JampanDefeatShake+1C   j
                rts
; End of function Boss_JampanDefeatShake
; Boss breaking up animation
Boss_JampanDefeatBreakup:                               ; DATA XREF: ROM:0004922C   o  ; was: sub_49E64
                bsr.w   Boss_JampanDamageHandler
                jsr     (Boss_SpawnExplosionDebris).l
                subq.w  #1,$48(a5)
                bne.s   locret_49E98
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                movea.w #(byte_FFD0A0-M68K_RAM),a0
                move.w  #$23C,(a0)
                move.w  #$D00,2(a0)
                move.l  $10(a5),$10(a0)
                move.l  $14(a5),$14(a0)
locret_49E98:                                           ; CODE XREF: Boss_JampanDefeatBreakup+E   j
                rts
; End of function Boss_JampanDefeatBreakup
; Defeat spark initialization
Boss_JampanDefeatSparkInit:                             ; DATA XREF: ROM:0004922E   o  ; was: sub_49E9A
                jsr     (Boss_SpawnExplosionDebris).l
                cmpi.w  #$60,(word_FFD0B4).w            ; '`'
                bcc.s   locret_49EB0
                clr.l   (dword_FFD0BC).w
                addq.w  #2,4(a5)
locret_49EB0:                                           ; CODE XREF: Boss_JampanDefeatSparkInit+C   j
                rts
; End of function Boss_JampanDefeatSparkInit
; Defeat spark movement
Boss_JampanDefeatSparkMove:                             ; DATA XREF: ROM:00049230   o  ; was: sub_49EB2
                bsr.s   Boss_JampanDefeatSparkUpdate
                addq.w  #1,$5C(a5)
                cmpi.w  #$F,$5C(a5)
                bne.s   locret_49ED0
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                clr.b   (word_FFF7E6+1).w
                addq.w  #2,4(a5)
locret_49ED0:                                           ; CODE XREF: Boss_JampanDefeatSparkMove+C   j
                rts
; End of function Boss_JampanDefeatSparkMove
; Defeat spark update
Boss_JampanDefeatSparkUpdate:                           ; CODE XREF: Boss_JampanDefeatSparkMove   p  ; was: sub_49ED2
                                        ; sub_49EEC   p
                move.w  $5C(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_JampanDefeatSparkUpdate
; Defeat spark fade effect
Boss_JampanDefeatSparkFade:                             ; DATA XREF: ROM:00049232   o  ; was: sub_49EEC
                bsr.s   Boss_JampanDefeatSparkUpdate
                move.w  #$218,d0
                move.w  #$23C,d1
                jsr     (Sprite_ClearAllExcept).l
                jsr     (Effect_InitPlayerSpawn).l
                move.b  #4,(byte_FFA95A).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatSparkFade
; Defeat spark wait timer
Boss_JampanDefeatSparkWait:                             ; DATA XREF: ROM:00049234   o  ; was: sub_49F0E
                bsr.s   Boss_JampanDefeatSparkUpdate
                subq.w  #1,$5C(a5)
                cmpi.w  #0,$5C(a5)
                bne.s   locret_49F20
                addq.w  #2,4(a5)
locret_49F20:                                           ; CODE XREF: Boss_JampanDefeatSparkWait+C   j
                rts
; End of function Boss_JampanDefeatSparkWait
; End of defeat initialization
Boss_JampanDefeatEndInit:                               ; DATA XREF: ROM:00049236   o  ; was: sub_49F22
                move.w  (word_FFD0B0).w,$10(a5)
                move.w  (word_FFD0B4).w,$14(a5)
                bset    #4,(byte_FFD0A2).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatEndInit
; End fade to white
Boss_JampanDefeatEndFade:                               ; DATA XREF: ROM:00049238   o  ; was: sub_49F40
                subq.w  #1,$48(a5)
                bne.s   locret_49F86
                lea     (byte_C55E).l,a0
                jsr     (Gfx_SyncPaletteBuffers).l
                bsr.w   loc_492F4
                bsr.w   Boss_JampanDamageHandler
                move.w  #$FFF8,(dword_FF9424).w
                move.w  #$100,(dword_FF9404).w
                move.w  #$100,(dword_FF9408).w
                move.w  #1,(word_FFC732).w
                move.w  #1,(word_FFC7F2).w
                move.w  #1,(word_FFC852).w
                addq.w  #2,4(a5)
                bsr.w   Boss_JampanDefeatEndWait
locret_49F86:                                           ; CODE XREF: Boss_JampanDefeatEndFade+4   j
                rts
; End of function Boss_JampanDefeatEndFade
; Cleanup initialization
Boss_JampanDefeatCleanupInit:                           ; DATA XREF: ROM:0004923A   o  ; was: sub_49F88
                bsr.w   Boss_JampanDefeatTimerCheck
                move.w  #1,(word_FFC6D2).w
                move.w  #1,(word_FFC792).w
                bsr.w   Boss_JampanDebugController
                bsr.w   Boss_JampanDamageHandler
                addq.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$40,d0                         ; '@'
                move.w  d0,$48(a5)
                jsr     (Math_CalculateAngleToPlayer).l
                lea     (word_1B514).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                move.l  d0,d2
                move.l  d1,d3
                neg.l   d2
                neg.l   d3
                asr.l   #4,d2
                asr.l   #4,d3
                move.l  d2,$50(a5)
                move.l  d3,$54(a5)
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                rts
; End of function Boss_JampanDefeatCleanupInit
; Cleanup wait timer
Boss_JampanDefeatCleanupWait:                           ; DATA XREF: ROM:0004923C   o  ; was: sub_49FEE
                bsr.w   Boss_JampanDefeatTimerCheck
                bsr.w   Boss_JampanDebugController
                bsr.w   Boss_JampanDamageHandler
                move.l  $50(a5),d0
                add.l   d0,$18(a5)
                move.l  $54(a5),d0
                add.l   d0,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4A014
                subq.w  #2,4(a5)
locret_4A014:                                           ; CODE XREF: Boss_JampanDefeatCleanupWait+20   j
                rts
; End of function Boss_JampanDefeatCleanupWait
nullsub_101:                                            ; DATA XREF: ROM:0004923E   o
                rts
; End of function nullsub_101

; Wait before transition
Boss_JampanDefeatEndWait:                               ; CODE XREF: Boss_JampanDefeatEndFade+42   p  ; was: sub_4A018
                move.w  #$100,(dword_FF942C+2).w
                move.w  #$2E,(word_FF80C2).w            ; '.'
                rts
; End of function Boss_JampanDefeatEndWait
; Defeat timer countdown check
Boss_JampanDefeatTimerCheck:                            ; CODE XREF: Boss_JampanDefeatCleanupInit   p  ; was: sub_4A026
                                        ; sub_49FEE   p
                subq.w  #1,(dword_FF942C+2).w
                bne.s   locret_4A032
                move.b  #1,(byte_FFA958).w
locret_4A032:                                           ; CODE XREF: Boss_JampanDefeatTimerCheck+4   j
                rts
; End of function Boss_JampanDefeatTimerCheck
; Final defeat phase main
Boss_JampanDefeatFinalMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_4A034
                move.w  4(a5),d0
                lea     off_4A040(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_JampanDefeatFinalMain
; ---------------------------------------------------------------------------
off_4A040:      dc.w    Boss_JampanDefeatFinalInit-*    ; DATA XREF: Boss_JampanDefeatFinalMain+4   o
                dc.w    Boss_JampanDefeatFinalLoop-*

; Final defeat phase init
Boss_JampanDefeatFinalInit:                             ; DATA XREF: ROM:off_4A040   o  ; was: sub_4A044
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #1,(word_FFC6D2).w
                move.w  #1,(word_FFC792).w
                clr.w   (word_FFC732).w
                clr.w   (word_FFC7F2).w
                clr.w   (word_FFC8B2).w
                clr.w   (word_FFC852).w
                bsr.w   Boss_JampanDamageHandler
                move.l  #$FFFE0000,$1C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_JampanDefeatFinalInit
; Final defeat phase loop
Boss_JampanDefeatFinalLoop:                             ; DATA XREF: ROM:0004A042   o  ; was: sub_4A078
                bsr.w   Boss_JampanDamageHandler
                rts
; End of function Boss_JampanDefeatFinalLoop
; Boss AI controller
