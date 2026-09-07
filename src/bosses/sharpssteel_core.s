Boss_SharpssteelMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_47C1C
                tst.w   4(a5)
                beq.w   loc_47C4C
                tst.w   8(a5)
                beq.s   loc_47C4C
                btst    #2,(byte_FF80EC).w
                bne.s   loc_47C42
                btst    #1,(byte_FF80EC).w
                bne.s   loc_47C42
                tst.w   (word_FF8200).w
                beq.w   Boss_SharpssteelSpawnDebris
loc_47C42:                                              ; CODE XREF: Boss_SharpssteelMain+14   j
                                        ; Boss_SharpssteelMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                bsr.w   Boss_SharpssteelUpdateCore
loc_47C4C:                                              ; CODE XREF: Boss_SharpssteelMain+4   j
                                        ; Boss_SharpssteelMain+C   j
                move.w  4(a5),d0
                movea.w off_47C5C(pc,d0.w),a0
                adda.l  #nullsub_95,a0
                jmp     (a0)
; End of function Boss_SharpssteelMain
; ---------------------------------------------------------------------------
off_47C5C:      dc.w    Boss_SharpssteelWaitPlayerReady-nullsub_95
                                        ; DATA XREF: Boss_SharpssteelMain+34   r
                dc.w    Boss_SharpssteelInit-nullsub_95
                dc.w    Boss_SharpssteelInputHandler-nullsub_95
                dc.w    Boss_SharpssteelMultiPhaseAttack-nullsub_95
                dc.w    Boss_Sharpssteel_State13-nullsub_95
                dc.w    Boss_Sharpssteel_State15-nullsub_95
                dc.w    Boss_SharpssteelUpdateBlades-nullsub_95
                dc.w    Boss_SharpssteelSpawnBlades-nullsub_95
                dc.w    Boss_Jampan_State1-nullsub_95
                dc.w    Boss_SharpssteelInitBattle-nullsub_95
                dc.w    Boss_Jampan_State3-nullsub_95
                dc.w    Boss_SharpssteelSetRotation-nullsub_95
                dc.w    Boss_Jampan_State5-nullsub_95
                dc.w    Boss_Jampan_State6-nullsub_95
                dc.w    Boss_SharpssteelAttackPattern1-nullsub_95
                dc.w    Boss_SharpssteelDefeatFade-nullsub_95
                dc.w    Boss_SharpssteelAttackPattern2Alt-nullsub_95
                dc.w    Boss_SharpssteelRisingAttack-nullsub_95
                dc.w    Boss_SharpssteelTimerCountdown-nullsub_95
                dc.w    Boss_SharpssteelDefeatCounter-nullsub_95
                dc.w    Boss_Sharpssteel_State21-nullsub_95
                dc.w    Boss_Jampan_State13-nullsub_95
                dc.w    Boss_SharpssteelComplexPhase-nullsub_95
                dc.w    Boss_Sharpssteel_AccelerateDown-nullsub_95
                dc.w    Boss_Sharpssteel_State27-nullsub_95
                dc.w    Boss_Sharpssteel_State28-nullsub_95
                dc.w    Boss_Sharpssteel_State29-nullsub_95
                dc.w    Boss_SharpssteelBladeDefeat-nullsub_95

nullsub_95:                                             ; CODE XREF: Boss_SharpssteelTimerCountdown+4   j
                                        ; DATA XREF: Boss_SharpssteelMain+38   o
                rts
; End of function nullsub_95

; Waits for player ready
Boss_SharpssteelWaitPlayerReady:                        ; DATA XREF: ROM:off_47C5C   o  ; was: sub_47C96
                tst.w   (word_FF80C2).w
                bne.s   locret_47CA4
                addq.w  #2,4(a5)
                clr.w   8(a5)
locret_47CA4:                                           ; CODE XREF: Boss_SharpssteelWaitPlayerReady+4   j
                rts
; End of function Boss_SharpssteelWaitPlayerReady
; Initializes Sharpsteel boss parts
Boss_SharpssteelInit:                                   ; DATA XREF: ROM:00047C5E   o  ; was: sub_47CA6
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$11,d7
                movea.l #off_35220,a0
                movea.l #word_35268,a1
                movea.l #word_3527A,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$C300,$36E(a5)
                move.w  #$C300,$4EE(a5)
                move.w  #$21C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #$CC00,$C2(a5)
                bsr.w   Boss_SharpssteelCoreDispatcher
                movea.l #Boss_SharpssteelObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #2,$1DE(a5)
                bra.w   Boss_SharpssteelBattleActive
; End of function Boss_SharpssteelInit
; Initializes boss state with velocity limits
Boss_SharpssteelInitState:
                move.w  #4,4(a5)                        ; was: sub_47D06
                move.w  #$120,$10(a5)
                move.w  #$100,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                moveq   #4,d0
                bsr.w   Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelInitState
; Handles player input for boss rotation control
Boss_SharpssteelInputHandler:                           ; DATA XREF: ROM:00047C60   o  ; was: sub_47D3C
                btst    #5,(word_FFF708).w
                beq.s   loc_47D48
                bsr.w   Boss_SharpssteelCoreDispatcher
loc_47D48:                                              ; CODE XREF: Boss_SharpssteelInputHandler+6   j
                btst    #4,(word_FFF708).w
                beq.s   loc_47D54
                bsr.w   Boss_SharpssteelCoreActive
loc_47D54:                                              ; CODE XREF: Boss_SharpssteelInputHandler+12   j
                btst    #2,(word_FFF706).w
                beq.s   loc_47D60
                addq.w  #2,$56(a5)
loc_47D60:                                              ; CODE XREF: Boss_SharpssteelInputHandler+1E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_47D6C
                subq.w  #2,$56(a5)
loc_47D6C:                                              ; CODE XREF: Boss_SharpssteelInputHandler+2A   j
                andi.w  #$1FE,$56(a5)
                lea     byte_48BA6(pc),a1
                nop
                bsr.w   Boss_SharpssteelCoreInit
                bra.w   loc_48694
; End of function Boss_SharpssteelInputHandler
; Palette fade during defeat sequence
Boss_SharpssteelDefeatFade:                             ; DATA XREF: ROM:00047C7A   o  ; was: sub_47D80
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bpl.s   locret_47D92
                bset    #4,2(a5)
locret_47D92:                                           ; CODE XREF: Boss_SharpssteelDefeatFade+A   j
                rts
; End of function Boss_SharpssteelDefeatFade
; Active battle state
Boss_SharpssteelBattleActive:                           ; CODE XREF: Boss_SharpssteelInit+5C   j  ; was: sub_47D94
                move.w  #$C,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #3,$182(a5)
                move.w  #$FFE0,$190(a5)
                move.w  #$168,$3D4(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C9E0,$4A(a5)
                move.w  #$80,$56(a5)
                move.w  #1,$11C(a5)
                move.w  #$120,$11E(a5)
                move.w  #$A0,$17C(a5)
                bsr.w   Boss_SharpssteelCoreDispatcher
                bsr.w   Boss_SharpssteelEnableMultipleHitboxes
                moveq   #$C,d0
                bsr.w   Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelBattleActive
; Updates all blade positions
Boss_SharpssteelUpdateBlades:                           ; DATA XREF: ROM:00047C68   o  ; was: sub_47DE8
                subq.w  #1,$17C(a5)
                bmi.s   loc_47DF6
                bsr.w   Boss_SharpssteelHorizontalMovement
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47DF6:                                              ; CODE XREF: Boss_SharpssteelUpdateBlades+4   j
                addq.w  #2,4(a5)
                moveq   #4,d0
                jsr     (UI_CheckVictoryCondition).l
; End of function Boss_SharpssteelUpdateBlades
; Spawns blade entities
Boss_SharpssteelSpawnBlades:                            ; DATA XREF: ROM:00047C6A   o  ; was: sub_47E02
                tst.w   (word_FF80C2).w
                beq.s   loc_47E10
                bsr.w   Boss_SharpssteelHorizontalMovement
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E10:                                              ; CODE XREF: Boss_SharpssteelSpawnBlades+4   j
                addq.w  #2,4(a5)
; Jampan boss entry state
Boss_Jampan_State1:                                     ; DATA XREF: ROM:00047C6C   o  ; was: loc_47E14
                addq.w  #1,$3D4(a5)
                cmpi.w  #$1C0,$3D4(a5)
                bpl.s   loc_47E28
                bsr.w   Boss_SharpssteelHorizontalMovement
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E28:                                              ; CODE XREF: Boss_SharpssteelSpawnBlades+1C   j
                bclr    #3,$182(a5)
                addq.w  #2,4(a5)
                bsr.w   Boss_SharpssteelUpdateRotation
; End of function Boss_SharpssteelSpawnBlades
; Initializes battle phase
Boss_SharpssteelInitBattle:                             ; DATA XREF: ROM:00047C6E   o  ; was: sub_47E36
                subi.l  #$22000,$2FC(a5)
                bmi.s   loc_47E54
                move.w  (word_FF9600).w,$190(a5)
                bsr.w   Boss_SharpssteelIncreaseSpeed
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E54:                                              ; CODE XREF: Boss_SharpssteelInitBattle+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.b  #$10,$E1(a5)
; Jampan boss attack phase
Boss_Jampan_State3:                                     ; DATA XREF: ROM:00047C70   o  ; was: loc_47E64
                subq.w  #1,$11C(a5)
                bmi.s   loc_47E7E
                move.w  (word_FF9600).w,$190(a5)
                bsr.w   Boss_SharpssteelIncreaseSpeed
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47E7E:                                              ; CODE XREF: Boss_SharpssteelInitBattle+32   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $29C(a5)
                bsr.w   Boss_SharpssteelBladeCheckHit
                bsr.w   Boss_SharpssteelBladeUpdate
; End of function Boss_SharpssteelInitBattle
; Sets rotation parameters
Boss_SharpssteelSetRotation:                            ; DATA XREF: ROM:00047C72   o  ; was: sub_47E98
                cmpi.w  #2,$29C(a5)
                bpl.s   loc_47EB4
loc_47EA0:                                              ; CODE XREF: Boss_SharpssteelSetRotation+30   j
                                        ; Boss_SharpssteelSetRotation+50   j
                move.w  (word_FF9600).w,$190(a5)
                bsr.w   Boss_SharpssteelIncreaseSpeed
                lea     byte_48BE8(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_47EB4:                                              ; CODE XREF: Boss_SharpssteelSetRotation+6   j
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFDBE4).w
; Jampan boss movement state
Boss_Jampan_State5:                                     ; DATA XREF: ROM:00047C74   o  ; was: loc_47EBC
                cmpi.w  #7,$29C(a5)
                bpl.s   loc_47ECA
                bsr.w   Boss_SharpssteelAttackPattern2
                bra.s   loc_47EA0
; ---------------------------------------------------------------------------
loc_47ECA:                                              ; CODE XREF: Boss_SharpssteelSetRotation+2A   j
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFDBE4).w
                move.l  #$FFFD8000,(dword_FFDBF8).w
                move.l  #$FFFD0000,(dword_FFDBFC).w
; Jampan boss combo state
Boss_Jampan_State6:                                     ; DATA XREF: ROM:00047C76   o  ; was: loc_47EE2
                tst.w   $58(a5)
                bmi.s   loc_47EEA
                bra.s   loc_47EA0
; ---------------------------------------------------------------------------
loc_47EEA:                                              ; CODE XREF: Boss_SharpssteelSetRotation+4E   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                bsr.w   Boss_SharpssteelUpdateTargets
; End of function Boss_SharpssteelSetRotation
; Attack pattern 1
Boss_SharpssteelAttackPattern1:                         ; DATA XREF: ROM:00047C78   o  ; was: sub_47F02
                subq.w  #1,$11C(a5)
                bpl.s   loc_47F16
                clr.b   (byte_FF80EC).w
                move.w  #$B,$35C(a5)
                bra.w   loc_480E0
; ---------------------------------------------------------------------------
loc_47F16:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1+4   j
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelAttackPattern1
; Attack pattern 2
Boss_SharpssteelAttackPattern2:                         ; CODE XREF: Boss_SharpssteelSetRotation+2C   p  ; was: sub_47F24
                move.w  $370(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FFDBF0).w
                move.w  $374(a5),d0
                addi.w  #-$10,d0
                move.w  d0,(word_FFDBF4).w
                rts
; End of function Boss_SharpssteelAttackPattern2
; Updates rotation speed
Boss_SharpssteelUpdateRotation:                         ; CODE XREF: Boss_SharpssteelSpawnBlades+30   p  ; was: sub_47F3E
                                        ; Boss_SharpssteelMultiPhaseAttack+F0   p
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C7A0,$48(a5)
                move.w  #$C7A0,$4A(a5)
                move.w  #$120,$194(a5)
                move.w  #$120,$190(a5)
                move.b  #$10,(byte_FFA420).w
                move.l  #$E00000,$2FC(a5)
                bsr.w   Boss_SharpssteelCoreDamage
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
                clr.w   $56(a5)
                bsr.w   Boss_SharpssteelCoreActive
                bsr.w   Boss_SharpssteelBladeInit
                moveq   #$18,d0
                bsr.w   Boss_SharpssteelCoreIdle
                moveq   #$18,d0
                bra.w   loc_48946
; End of function Boss_SharpssteelUpdateRotation
; Starts defeat sequence
Boss_SharpssteelDefeatStart:                            ; CODE XREF: Boss_SharpssteelAttackPattern1:loc_47F16   p  ; was: sub_47F9C
                                        ; Boss_SharpssteelAttackPattern1Alt+10   p
                move.w  (word_FF960A).w,$190(a5)
; End of function Boss_SharpssteelDefeatStart
; Increases rotation speed
Boss_SharpssteelIncreaseSpeed:                          ; CODE XREF: Boss_SharpssteelInitBattle+10   p  ; was: sub_47FA2
                                        ; Boss_SharpssteelInitBattle+3A   p
                move.w  (dword_FFDB34).w,d0
                add.w   $2FC(a5),d0
                addi.w  #-$C,d0
                move.w  d0,$194(a5)
                rts
; End of function Boss_SharpssteelIncreaseSpeed
; Updates six target addresses with calculated value
Boss_SharpssteelUpdateTargets:                          ; CODE XREF: Boss_SharpssteelSetRotation+66   p  ; was: sub_47FB4
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FFDB30).w,d1
                addi.w  #$74,d1                         ; 't'
                moveq   #5,d7
loc_47FC2:                                              ; CODE XREF: Boss_SharpssteelUpdateTargets+10   j
                move.w  d1,(a0)+
                dbf     d7,loc_47FC2
                rts
; End of function Boss_SharpssteelUpdateTargets
; Updates core position
Boss_SharpssteelUpdateCore:                             ; CODE XREF: Boss_SharpssteelMain+2C   p  ; was: sub_47FCA
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  (dword_FFDB30).w,d1
                addi.w  #$74,d1                         ; 't'
                moveq   #5,d7
loc_47FD8:                                              ; CODE XREF: Boss_SharpssteelUpdateCore+14   j
                move.w  (a0),d0
                move.w  d1,(a0)+
                move.w  d0,d1
                dbf     d7,loc_47FD8
                rts
; End of function Boss_SharpssteelUpdateCore
; Controls horizontal movement with target tracking
Boss_SharpssteelHorizontalMovement:                     ; CODE XREF: Boss_SharpssteelUpdateBlades+6   p  ; was: sub_47FE4
                                        ; Boss_SharpssteelSpawnBlades+6   p
                btst    #0,$23E(a5)
                beq.s   loc_47FF6
                moveq   #2,d7
                move.w  $2B0(a5),d5
                bsr.w   Boss_SharpssteelSpawnAngleProjectiles
loc_47FF6:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+6   j
                move.w  $10(a5),d0
                move.l  $198(a5),d1
                tst.w   $11C(a5)
                bmi.s   loc_48050
                cmp.w   $11E(a5),d0
                bmi.s   loc_48032
                move.w  #$FFFF,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addq.w  #8,d0
                neg.w   d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$B0,d0
                bpl.s   loc_48088
                move.w  #$B0,$11E(a5)
                bra.s   loc_48088
; ---------------------------------------------------------------------------
loc_48032:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+24   j
                tst.l   d1
                bmi.s   loc_4803E
                cmpi.l  #$10000,d1
                bpl.s   loc_48092
loc_4803E:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+50   j
                                        ; Boss_SharpssteelHorizontalMovement+8E   j
                addi.l  #$E00,d1
                move.l  d1,$198(a5)
                lea     byte_48BCC(pc),a1
                nop
                rts
; ---------------------------------------------------------------------------
loc_48050:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+1E   j
                cmp.w   $11E(a5),d0
                bpl.s   loc_4807C
                move.w  #1,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addq.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$11E(a5)
                cmpi.w  #$160,d0
                bmi.s   loc_4803E
                move.w  #$160,$11E(a5)
                bra.s   loc_4803E
; ---------------------------------------------------------------------------
loc_4807C:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+70   j
                tst.l   d1
                bpl.s   loc_48088
                cmpi.l  #$FFFE2000,d1
                bmi.s   loc_48092
loc_48088:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+44   j
                                        ; Boss_SharpssteelHorizontalMovement+4C   j
                subi.l  #$2000,d1
                move.l  d1,$198(a5)
loc_48092:                                              ; CODE XREF: Boss_SharpssteelHorizontalMovement+58   j
                                        ; Boss_SharpssteelHorizontalMovement+A2   j
                lea     byte_48BB0(pc),a1
                nop
                rts
; End of function Boss_SharpssteelHorizontalMovement
; Spawns projectiles at calculated angles
Boss_SharpssteelSpawnAngleProjectiles:                  ; CODE XREF: Boss_SharpssteelHorizontalMovement+E   p  ; was: sub_4809A
                move.w  #$150,d6
                movea.w #(dword_FFFF08-M68K_RAM),a4
loc_480A2:                                              ; CODE XREF: Boss_SharpssteelSpawnAngleProjectiles+1A   j
                move.b  (a4)+,d4
                andi.w  #$3E,d4                         ; '>'
                addi.w  #$120,d4
                jsr     (Enemy_SpawnProjectileAtAngle).l
                bne.s   loc_480B8
                dbf     d7,loc_480A2
loc_480B8:                                              ; CODE XREF: Boss_SharpssteelSpawnAngleProjectiles+18   j
                move.b  #$4C,d0                         ; 'L'
                jmp     (Sound_PlaySFX).l
; End of function Boss_SharpssteelSpawnAngleProjectiles
; Attack pattern with distance check and blade init
Boss_SharpssteelAttackPattern1Alt:                      ; CODE XREF: Boss_SharpssteelDefeatCounter+38   j  ; was: sub_480C2
                move.w  #$2A,4(a5)                      ; '*'
                clr.w   $23E(a5)
; Jampan boss advanced phase
Boss_Jampan_State13:                                    ; DATA XREF: ROM:00047C86   o  ; was: loc_480CC
                tst.w   $23E(a5)
                bne.s   loc_480E0
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_480E0:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1+10   j
                                        ; Boss_SharpssteelAttackPattern1Alt+E   j
                subq.w  #1,$35C(a5)
                bpl.s   loc_48108
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,$11C(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                move.w  d0,$35C(a5)
                bra.w   Boss_SharpssteelAttackPattern3
; ---------------------------------------------------------------------------
loc_48108:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+22   j
                jsr     (Physics_GetPlayerDelta).l
                move.b  (dword_FFFF08).w,d2
                clr.w   $54(a5)
                tst.w   d1
                bmi.w   loc_48122
                move.w  #$100,$54(a5)
loc_48122:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+56   j
                cmpi.w  #$3C,d0                         ; '<'
                bpl.s   loc_4812C
                bra.w   loc_4818E
; ---------------------------------------------------------------------------
loc_4812C:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+64   j
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_48130:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt:loc_4812C   j
                move.w  #$20,4(a5)                      ; ' '
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w   Boss_SharpssteelBladeInit
                moveq   #$40,d0                         ; '@'
                bsr.w   Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelAttackPattern1Alt
; Attack pattern with blade update and core flash
Boss_SharpssteelAttackPattern2Alt:                      ; DATA XREF: ROM:00047C7C   o  ; was: sub_4814E
                tst.w   $58(a5)
                bmi.w   loc_480E0
                btst    #0,$23E(a5)
                beq.s   loc_48174
                bsr.w   Boss_SharpssteelBladeUpdate
                move.w  #$A7,d1
                bsr.w   Boss_SharpssteelEnableHitboxSet2
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
loc_48174:                                              ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+E   j
                btst    #1,$23E(a5)
                beq.s   loc_48180
                bsr.w   Boss_SharpssteelCoreFlash
loc_48180:                                              ; CODE XREF: Boss_SharpssteelAttackPattern2Alt+2C   j
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C4C(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4818E:                                              ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+66   j
                move.w  #$36,4(a5)                      ; '6'
                clr.w   $58(a5)
                clr.w   $23E(a5)
                move.w  #$FFFF,$C(a5)
                bsr.w   Boss_SharpssteelBladeInit
                moveq   #$10,d0
                bsr.w   Boss_SharpssteelCoreIdle
; End of function Boss_SharpssteelAttackPattern2Alt
; Blade defeat state
Boss_SharpssteelBladeDefeat:                            ; DATA XREF: ROM:00047C92   o  ; was: sub_481AC
                tst.w   $58(a5)
                bmi.w   loc_480E0
                btst    #0,$23E(a5)
                beq.s   loc_481D2
                bsr.w   Boss_SharpssteelBladeUpdate
                move.w  #$82,d1
                bsr.w   Boss_SharpssteelEnableHitboxSet2
                move.b  #$DC,d0
                jsr     (Sound_PlaySFX).l
loc_481D2:                                              ; CODE XREF: Boss_SharpssteelBladeDefeat+E   j
                btst    #1,$23E(a5)
                beq.s   loc_481E2
                bsr.w   Boss_SharpssteelCoreFlash
                bsr.w   Boss_SharpssteelPaletteFadeSetup
loc_481E2:                                              ; CODE XREF: Boss_SharpssteelBladeDefeat+2C   j
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C6E(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelBladeDefeat
; Complex attack with rotation and subsystem calls
Boss_SharpssteelAttackPattern3:                         ; CODE XREF: Boss_SharpssteelAttackPattern1Alt+42   j  ; was: sub_481F0
                move.w  #$22,4(a5)                      ; '"'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                clr.w   $54(a5)
                move.w  #6,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #2,$3BE(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFFDC000,$DC(a5)
                bsr.w   Boss_SharpssteelCoreDamage
                bsr.w   Boss_SharpssteelDisableHitboxGroup1
                bsr.w   Boss_SharpssteelDisableHitboxGroup2
                bsr.w   Boss_SharpssteelBladeInit
                bsr.w   Boss_SharpssteelPaletteFadeSetup
; End of function Boss_SharpssteelAttackPattern3
; Rising attack with velocity increase
Boss_SharpssteelRisingAttack:                           ; DATA XREF: ROM:00047C7E   o  ; was: sub_48246
                cmpi.w  #$200,$14(a5)
                bpl.w   loc_482A8
                addi.l  #$4000,$DC(a5)
                tst.w   $11E(a5)
                bne.s   loc_4828E
                cmpi.w  #$160,$14(a5)
                bmi.s   loc_4828E
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                moveq   #$60,d3                         ; '`'
                clr.w   (word_FF808A).w
                jsr     (loc_E28A).l
                move.w  #$8000,(word_FF808A).w
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
loc_4828E:                                              ; CODE XREF: Boss_SharpssteelRisingAttack+16   j
                                        ; Boss_SharpssteelRisingAttack+1E   j
                lea     byte_48C90(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelRisingAttack
; Sets random timer for next attack phase
Boss_SharpssteelSetTimer:                               ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+DC   j  ; was: sub_48298
                move.w  (dword_FFFF08).w,d0
                move.w  #$F,d0
                addi.w  #$10,d0
                move.w  d0,$11C(a5)
loc_482A8:                                              ; CODE XREF: Boss_SharpssteelRisingAttack+6   j
                move.w  #$24,4(a5)                      ; '$'
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                bsr.w   Boss_SharpssteelCoreDamage
; End of function Boss_SharpssteelSetTimer
; Countdown timer branching to attack patterns
Boss_SharpssteelTimerCountdown:                         ; DATA XREF: ROM:00047C80   o  ; was: sub_482C2
                subq.w  #1,$11C(a5)
                bpl.w   nullsub_95
loc_482CA:                                              ; CODE XREF: Boss_SharpssteelComplexPhase+112   j
                subq.w  #1,$35C(a5)
                bpl.s   loc_482E2
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                addq.w  #6,d0
                move.w  d0,$35C(a5)
                bra.w   loc_48430
; ---------------------------------------------------------------------------
loc_482E2:                                              ; CODE XREF: Boss_SharpssteelTimerCountdown+C   j
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$120,$D0(a5)
                move.w  #$190,$D4(a5)
                clr.w   $56(a5)
                move.w  #$C6E0,$48(a5)
                move.w  #$C6E0,$4A(a5)
                clr.l   $D8(a5)
                move.l  #$FFF80000,$DC(a5)
                move.w  #$FFE4,$35E(a5)
                move.w  #1,$3BC(a5)
                move.w  #1,$3BE(a5)
                bsr.w   Boss_SharpssteelCoreActive
                bsr.w   Boss_SharpssteelBladeInit
                bsr.w   Boss_SharpssteelPaletteFadeSetup
                bsr.w   Boss_SharpssteelSpawnProjectileWave
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
; End of function Boss_SharpssteelTimerCountdown
; Multi-phase attack with velocity changes
Boss_SharpssteelMultiPhaseAttack:                       ; DATA XREF: ROM:00047C62   o  ; was: sub_48346
                addi.l  #$1400,$DC(a5)
                bpl.s   loc_4835A
                lea     byte_48C1E(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4835A:                                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+8   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$100,$56(a5)
                bsr.w   Boss_SharpssteelCoreActive
                bsr.w   Boss_SharpssteelEnableMultipleHitboxes
                bsr.w   Boss_SharpssteelEnableObjectFlags
; Sharpssteel boss transformation
Boss_Sharpssteel_State13:                               ; DATA XREF: ROM:00047C64   o  ; was: loc_4837A
                addi.l  #$2000,$DC(a5)
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0                         ; ' '
                cmp.w   $D4(a5),d0
                bmi.s   loc_4839A
                lea     byte_48C2C(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4839A:                                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+48   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   $11E(a5)
                move.w  #8,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                move.b  #$2F,d0                         ; '/'
                jsr     (Sound_PlaySFX).l
                move.l  #$20000,(dword_FFDB3C).w
                move.w  #2,(word_FFDB78).w
                moveq   #0,d0
                move.w  #$B0,d0
                sub.w   (dword_FFDB30).w,d0
                swap    d0
                asr.l   #5,d0
                move.l  d0,$D8(a5)
                move.l  #$FFFD8000,$DC(a5)
; Sharpssteel boss attack mode
Boss_Sharpssteel_State15:                               ; DATA XREF: ROM:00047C66   o  ; was: loc_483EA
                addi.l  #$3A00,$DC(a5)
                tst.w   $11E(a5)
                bne.s   loc_4841C
                cmpi.w  #$160,$D4(a5)
                bmi.s   loc_4841C
                addq.w  #1,$11E(a5)
                move.w  $10(a5),d5
                move.w  #$150,d6
                jsr     (Projectile_SpawnQuadPattern).l
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
loc_4841C:                                              ; CODE XREF: Boss_SharpssteelMultiPhaseAttack+B0   j
                                        ; Boss_SharpssteelMultiPhaseAttack+B8   j
                cmpi.w  #$240,$D4(a5)
                bpl.w   Boss_SharpssteelSetTimer
                lea     byte_48C3A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_48430:                                              ; CODE XREF: Boss_SharpssteelTimerCountdown+1C   j
                move.w  #$26,4(a5)                      ; '&'
                bsr.w   Boss_SharpssteelUpdateRotation
; End of function Boss_SharpssteelMultiPhaseAttack
; Defeat sequence with flashing and counter
Boss_SharpssteelDefeatCounter:                          ; DATA XREF: ROM:00047C82   o  ; was: sub_4843A
                subi.l  #$22000,$2FC(a5)
                bmi.s   loc_4845E
                cmpi.w  #$60,$2FC(a5)                   ; '`'
                bmi.s   loc_48450
                bsr.w   nullsub_96
loc_48450:                                              ; CODE XREF: Boss_SharpssteelDefeatCounter+10   j
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; ---------------------------------------------------------------------------
loc_4845E:                                              ; CODE XREF: Boss_SharpssteelDefeatCounter+8   j
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.b  #$10,$E1(a5)
; Sharpssteel boss final phase
Boss_Sharpssteel_State21:                               ; DATA XREF: ROM:00047C84   o  ; was: loc_4846E
                subq.w  #1,$11C(a5)
                bmi.w   Boss_SharpssteelAttackPattern1Alt
                bsr.w   Boss_SharpssteelDefeatStart
                lea     byte_48C0A(pc),a1
                nop
                bra.w   Boss_SharpssteelBladeMain
; End of function Boss_SharpssteelDefeatCounter
nullsub_96:                                             ; CODE XREF: Boss_SharpssteelDefeatCounter+12   p
                rts
; End of function nullsub_96

; Resets boss to center with initial velocity
Boss_SharpssteelResetPosition:
                move.w  #$2C,4(a5)                      ; ','  ; was: sub_48486
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFDB30).w,d0
                addi.w  #$74,d0                         ; 't'
                move.w  d0,$10(a5)
                move.w  #$200,$14(a5)
                clr.w   $56(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                clr.l   $18(a5)
                move.l  #$FFFD0000,$1C(a5)
                bsr.w   Boss_SharpssteelCoreActive
                bsr.w   Boss_SharpssteelEnableMultipleHitboxes
                movea.l #byte_48D78,a0
                bsr.w   Boss_SharpssteelLoadAnimDelays
                move.w  #$FFD8,$35E(a5)
                move.w  #0,$3BC(a5)
                move.w  #1,$3BE(a5)
; End of function Boss_SharpssteelResetPosition
; Complex behavior with screen shake and projectiles
