Boss_ViblackMain:                                       ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4398C
                tst.w   4(a5)
                beq.w   Boss_ViblackStateDispatch
                addq.w  #1,$4E(a5)
                lea     word_43B0A(pc),a2
                nop
                jsr     (Gfx_ProcessColorFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$5E(a5)
                movea.w #(word_FFC680-M68K_RAM),a4
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_ViblackStateDispatch
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_ViblackStateDispatch
                tst.w   (word_FF8200).w
                beq.w   Boss_ViblackDefeatInit
; State machine dispatcher for Viblack boss
Boss_ViblackStateDispatch:                              ; CODE XREF: Boss_ViblackMain+4   j  ; was: loc_439CC
                                        ; Boss_ViblackMain+2E   j
                move.w  4(a5),d0
                movea.w off_439DC(pc,d0.w),a0
                adda.l  #Boss_ViblackInit,a0
                jmp     (a0)
; End of function Boss_ViblackMain
; ---------------------------------------------------------------------------
off_439DC:      dc.w    Boss_ViblackInit-Boss_ViblackInit
                                        ; DATA XREF: Boss_ViblackMain+44   r
                dc.w    Boss_ViblackIntroSetup-Boss_ViblackInit
                dc.w    Boss_ViblackDescend-Boss_ViblackInit
                dc.w    Boss_ViblackFallOffScreen-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatCheck-Boss_ViblackInit
                dc.w    Boss_ViblackAttackState-Boss_ViblackInit
                dc.w    Boss_ViblackDefeat_MoveToTarget-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatWait-Boss_ViblackInit
                dc.w    Boss_ViblackStartAttackPhase-Boss_ViblackInit
                dc.w    Boss_ViblackProjectileAttack-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatMoveUp-Boss_ViblackInit
                dc.w    Boss_ViblackDefeatMoveDown-Boss_ViblackInit
                dc.w    Boss_ViblackRopePhysics-Boss_ViblackInit
                dc.w    Boss_BackStringerTimerState-Boss_ViblackInit
                dc.w    Boss_BackStringerSetDownVelocity-Boss_ViblackInit
                dc.w    Boss_BackStringerTransitionFinish-Boss_ViblackInit

; Initializes Viblack mini-boss
Boss_ViblackInit:                                       ; DATA XREF: Boss_ViblackMain+48   o  ; was: sub_439FC
                                        ; ROM:off_439DC   o
                addq.w  #2,4(a5)
                move.w  #$C2F8,(word_FF8110).w
                move.w  #$20,(word_FF8112).w            ; ' '
                move.b  #4,(word_FFF7E6+1).w
                move.b  #8,(byte_FFA95A).w
                move.b  #$20,(byte_FFA95B).w            ; ' '
                move.w  #1,(word_FF8218).w
                move.w  #$30,$48(a5)                    ; '0'
                move.b  #6,(byte_FF80EC).w
; Sets up intro graphics and position
Boss_ViblackIntroSetup:                                 ; DATA XREF: ROM:000439DE   o  ; was: loc_43A30
                subq.w  #1,$48(a5)
                bpl.w   locret_43C44
                addq.w  #2,4(a5)
                move.w  #$D00,2(a5)
                move.w  #$5000,(word_FF8200).w
                move.w  #$5000,(word_FF8202).w
                move.w  #$1C,$24(a5)
                move.b  #$10,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$F010F010,$28(a5)
                move.w  (dword_FFA410).w,$10(a5)
                move.w  #$7C,$14(a5)                    ; '|'
                move.w  #8,$1C(a5)
                move.w  #$10,(a4)
                clr.w   2(a4)
                move.b  #$20,$21(a4)                    ; ' '
                move.w  #4,$46(a4)
                move.l  #$FF770088,$28(a4)
                lea     (byte_C464).l,a0
                jsr     (LoadPalette).l
                lea     word_43B0A(pc),a2
                nop
                jsr     (Gfx_ClearColorFadeState).l
                lea     word_43AE0(pc),a0
                nop
                move.w  #$8000,d0
                jsr     (Stage_LoadShipGraphics).l
                movea.l #$FFFF5520,a0
                move.w  #$2000,d0
                moveq   #$49,d7                         ; 'I'
                jsr     (Gfx_AdjustTileIndices).l
                lea     word_43AF0(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                bra.w   Boss_ViblackUpdateAngle
; End of function Boss_ViblackInit
; ---------------------------------------------------------------------------
word_43AE0:     dc.w    $4000, $8E8F, $9091, $9293, $9899, $9A9B, $9C9D, $A2FF
                                        ; DATA XREF: Boss_ViblackInit+B2   o
word_43AF0:     dc.w    $6000, $4000, $901, $8E8F, $9091, $9293, $9899, $9A9B, 0, 0, $9C9D, 0, 0
                                        ; DATA XREF: Boss_ViblackInit+D4   o
word_43B0A:     dc.w    $D, $E302, $E304, $E306, $E30C, $E30A, $E30C, $E30E, $E310, $E312, $E314, $E316, $E318, $E31A, $E31E
                                        ; DATA XREF: Boss_ViblackMain+C   o
                                        ; Boss_ViblackInit+A6   o

; Viblack descends from top
Boss_ViblackDescend:                                    ; DATA XREF: ROM:000439E0   o  ; was: sub_43B28
                bsr.w   Sound_ViblackPeriodic
                bsr.w   Boss_ViblackUpdatePosition
                subi.l  #$2000,$1C(a5)
                move.w  (dword_FFA414).w,d0
                sub.w   $14(a5),d0
                cmpi.w  #$20,d0                         ; ' '
                bpl.s   locret_43B82
                addq.w  #2,4(a5)
                move.l  #$30000,$1C(a5)
                move.w  #$30,(word_FFA02A).w            ; '0'
                bset    #5,(byte_FF8245).w
                bset    #4,(word_FFA40E).w
                jsr     (Sys_ClearObjectBlocks16).l
                move.w  #$8000,(word_FF808A).w
                move.w  #4,(word_FFA010).w
                move.b  #$DA,d0
                jsr     (Sound_PlaySFX).l
                bra.s   loc_43BD0
; ---------------------------------------------------------------------------
locret_43B82:                                           ; CODE XREF: Boss_ViblackDescend+1C   j
                rts
; End of function Boss_ViblackDescend
; Viblack falls off screen
Boss_ViblackFallOffScreen:                              ; DATA XREF: ROM:000439E2   o  ; was: sub_43B84
                bsr.w   Sound_ViblackPeriodic
                bsr.w   Boss_ViblackUpdatePosition
                subi.l  #$2800,$1C(a5)
                bpl.s   loc_43BD0
                cmpi.w  #$FFFA,$1C(a5)
                bpl.s   loc_43BD0
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$C,$5A(a5)
                move.w  #$FFFF,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (word_FFA02A).w
                bclr    #5,(byte_FF8245).w
                addq.w  #2,(word_FFA404).w
loc_43BD0:                                              ; CODE XREF: Boss_ViblackDescend+58   j
                                        ; Boss_ViblackFallOffScreen+10   j
                movea.w #(word_FFC680-M68K_RAM),a4
                move.w  $14(a4),d0
                addi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                rts
; End of function Boss_ViblackFallOffScreen
; Checks defeat condition
Boss_ViblackDefeatCheck:                                ; DATA XREF: ROM:000439E4   o  ; was: sub_43BE2
                bsr.w   Boss_ViblackUpdatePosition
                bsr.w   Boss_ViblackSpawnWalkerShot
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   locret_43C44
                move.w  (dword_FFFF08).w,d0
                subq.w  #1,$5A(a5)
                bpl.s   loc_43C20
                move.w  #$10,4(a5)
                andi.w  #$F,d0
                addi.w  #8,d0
                move.w  d0,$5A(a5)
                move.w  #2,$50(a5)
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
                rts
; ---------------------------------------------------------------------------
loc_43C20:                                              ; CODE XREF: Boss_ViblackDefeatCheck+16   j
                addq.w  #2,4(a5)
                bsr.w   Boss_ViblackSpawnChain
                tst.w   (word_FFC740).w
                bne.s   Boss_ViblackSetRandomDelay
                move.w  #$60,$48(a5)                    ; '`'
                rts
; ---------------------------------------------------------------------------
; Sets random delay timer for actions
Boss_ViblackSetRandomDelay:                             ; CODE XREF: Boss_ViblackDefeatCheck+4A   j  ; was: loc_43C36
                move.w  (dword_FFFF08).w,d0
                andi.w  #$40,d0                         ; '@'
                addq.w  #8,d0
                move.w  d0,$48(a5)
locret_43C44:                                           ; CODE XREF: Boss_ViblackInit+38   j
                                        ; Boss_ViblackDefeatCheck+C   j
                rts
; End of function Boss_ViblackDefeatCheck
; Attack state with timer and projectile spawning
Boss_ViblackAttackState:                                ; DATA XREF: ROM:000439E6   o  ; was: sub_43C46
                bsr.w   Boss_ViblackUpdatePosition
                bsr.w   Boss_ViblackSpawnWalkerShot
                subq.w  #1,$48(a5)
                bpl.s   locret_43C5E
loc_43C54:                                              ; CODE XREF: Boss_ViblackProjectileAttack+8   j
                move.w  #8,4(a5)
                bra.w   Boss_ViblackSetRandomTarget
; ---------------------------------------------------------------------------
locret_43C5E:                                           ; CODE XREF: Boss_ViblackAttackState+C   j
                rts
; End of function Boss_ViblackAttackState
; Sets up Viblack boss attack phase with timer
Boss_ViblackStartAttackPhase:                           ; DATA XREF: ROM:000439EC   o  ; was: sub_43C60
                bsr.w   Boss_ViblackUpdatePosition
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   locret_43C44
                addq.w  #2,4(a5)
                move.w  #$100,$48(a5)
                rts
; End of function Boss_ViblackStartAttackPhase
; Spawns projectiles with angle-based trajectory
Boss_ViblackProjectileAttack:                           ; DATA XREF: ROM:000439EE   o  ; was: sub_43C76
                bsr.w   Boss_ViblackUpdatePosition
                subq.w  #1,$48(a5)
                bmi.w   loc_43C54
                cmpi.w  #$20,$48(a5)                    ; ' '
                bmi.w   locret_43C44
                btst    #0,(word_FFA000+1).w
                bne.w   locret_43C44
                lea     byte_43D52(pc),a1
                nop
                move.w  $48(a5),d0
                andi.w  #$F,d0
                moveq   #0,d6
                move.b  (a1,d0.w),d6
                asl.w   #1,d6
                moveq   #1,d5
loc_43CAE:                                              ; CODE XREF: Boss_ViblackProjectileAttack+CA   j
                                        ; Boss_ViblackProjectileAttack+D6   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_43C44
                cmpi.w  #$A0,$48(a5)
                bpl.s   loc_43CCE
                move.w  #$8008,d2
                moveq   #$24,d7                         ; '$'
                jsr     (Enemy_SetProjectileDifficulty).l
                bra.s   loc_43CF8
; ---------------------------------------------------------------------------
loc_43CCE:                                              ; CODE XREF: Boss_ViblackProjectileAttack+48   j
                lea     (Boss_SharedCollisionProjectileSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d6.w),d0
                move.w  (a1,d6.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #3,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
loc_43CF8:                                              ; CODE XREF: Boss_ViblackProjectileAttack+56   j
                move.w  $10(a5),d0
                tst.w   d5
                beq.s   loc_43D0E
                subi.w  #$1C,d0
                move.w  d6,d1
                move.w  #$100,d6
                sub.w   d1,d6
                bra.s   loc_43D18
; ---------------------------------------------------------------------------
loc_43D0E:                                              ; CODE XREF: Boss_ViblackProjectileAttack+88   j
                addi.w  #$1C,d0
                bset    #3,$E(a0)
loc_43D18:                                              ; CODE XREF: Boss_ViblackProjectileAttack+96   j
                move.w  d0,$10(a0)
                subi.w  #$80,d0
                bmi.s   loc_43D46
                cmpi.w  #$140,d0
                bpl.s   loc_43D46
                asr.w   #3,d0
                andi.w  #$FFFE,d0
                addi.w  #-$6B80,d0
                movea.w d0,a1
                move.w  (a1),d0
                neg.w   d0
                subi.w  #$160,d0
                move.w  d0,$14(a0)
                dbf     d5,loc_43CAE
                rts
; ---------------------------------------------------------------------------
loc_43D46:                                              ; CODE XREF: Boss_ViblackProjectileAttack+AA   j
                                        ; Boss_ViblackProjectileAttack+B0   j
                bset    #4,2(a0)
                dbf     d5,loc_43CAE
                rts
; End of function Boss_ViblackProjectileAttack
; ---------------------------------------------------------------------------
byte_43D52:     dc.b    $50, $4C, $48, $44, $40, $3C, $38, $34, $30, $34, $38, $3C, $40, $44, $48, $4C
                                        ; DATA XREF: Boss_ViblackProjectileAttack+20   o

; Initializes defeat sequence
Boss_ViblackDefeatInit:                                 ; CODE XREF: Boss_ViblackMain+3C   j  ; was: sub_43D62
                move.b  #1,(byte_FF830E).w
                move.w  #$C,4(a5)
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                clr.b   $21(a5)
                move.w  #$80,(word_FF808C).w
                move.w  #$780,$52(a5)
                move.w  #$C8,$54(a5)
; Moves boss to target position during defeat
Boss_ViblackDefeat_MoveToTarget:                        ; DATA XREF: ROM:000439E8   o  ; was: loc_43D90
                bsr.w   Boss_ViblackUpdateAll
                bsr.w   Boss_ViblackMoveToTarget
                bne.s   locret_43DA8
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
                move.w  #$80,$48(a5)
locret_43DA8:                                           ; CODE XREF: Boss_ViblackDefeatInit+36   j
                rts
; End of function Boss_ViblackDefeatInit
; Waiting state with timer countdown
Boss_ViblackDefeatWait:                                 ; DATA XREF: ROM:000439EA   o  ; was: sub_43DAA
                bsr.w   Boss_ViblackUpdateSpriteAndSpawn
                subq.w  #1,$48(a5)
                bpl.s   locret_43DBE
                move.w  #$14,4(a5)
                clr.w   (word_FF8112).w
locret_43DBE:                                           ; CODE XREF: Boss_ViblackDefeatWait+8   j
                rts
; End of function Boss_ViblackDefeatWait
; Move up state with acceleration
Boss_ViblackDefeatMoveUp:                               ; DATA XREF: ROM:000439F0   o  ; was: sub_43DC0
                bsr.w   Boss_ViblackUpdateSpriteAndSpawn
                addi.l  #$3000,$1C(a5)
                cmpi.w  #$100,$14(a5)
                bmi.s   locret_43DDC
                addq.w  #2,4(a5)
                addq.w  #2,(word_FFA950).w
locret_43DDC:                                           ; CODE XREF: Boss_ViblackDefeatMoveUp+12   j
                rts
; End of function Boss_ViblackDefeatMoveUp
; Move down with deceleration and stage setup
Boss_ViblackDefeatMoveDown:                             ; DATA XREF: ROM:000439F2   o  ; was: sub_43DDE
                bsr.w   Boss_ViblackUpdateSpriteAndSpawn
                subi.l  #$3000,$1C(a5)
                cmpi.w  #$C8,$14(a5)
                bpl.w   locret_43C44
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                clr.w   $52(a5)
                move.w  #$FFF0,$54(a5)
                btst    #4,(word_FFA40E).w
                beq.s   loc_43E20
                move.w  #$4C,(word_FFA404).w            ; 'L'
                move.w  #$FFF8,(dword_FFA41C).w
                jsr     (Sys_ClearObjectBlocks16).l
loc_43E20:                                              ; CODE XREF: Boss_ViblackDefeatMoveDown+2E   j
                move.w  #$320,(word_FFC680).w
                clr.w   (word_FFC682).w
                move.w  #2,(word_FFC6C6).w
                clr.l   (dword_FFC6DC).w
                move.b  #2,(byte_FFA95A).w
                move.b  #$4D,d0                         ; 'M'
                jmp     (Sound_PlaySFX).l
; End of function Boss_ViblackDefeatMoveDown
; Boss rope/tentacle physics calculation
Boss_ViblackRopePhysics:                                ; DATA XREF: ROM:000439F4   o  ; was: sub_43E44
                clr.w   $4E(a5)
                bsr.w   Boss_ViblackUpdatePosAndPalette
                move.w  $52(a5),d1
                move.w  $54(a5),d0
                beq.s   loc_43E98
                bpl.s   loc_43E78
loc_43E58:                                              ; CODE XREF: Boss_BackStringerTimerState+70   j
                                        ; Boss_BackStringerTransitionFinish+16   j
                cmpi.w  #$FFF0,d0
                bpl.s   loc_43E60
                moveq   #$FFFFFFF0,d0
loc_43E60:                                              ; CODE XREF: Boss_ViblackRopePhysics+18   j
                cmp.w   d1,d0
                beq.s   loc_43E6E
                bpl.s   loc_43E6E
                subq.w  #4,$52(a5)
                subq.w  #4,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43E6E:                                              ; CODE XREF: Boss_ViblackRopePhysics+1E   j
                                        ; Boss_ViblackRopePhysics+20   j
                neg.w   $54(a5)
                subq.w  #2,$54(a5)
                bra.s   loc_43EB0
; ---------------------------------------------------------------------------
loc_43E78:                                              ; CODE XREF: Boss_ViblackRopePhysics+12   j
                                        ; Boss_BackStringerTimerState+6C   j
                cmpi.w  #$10,d0
                bmi.s   loc_43E80
                moveq   #$10,d0
loc_43E80:                                              ; CODE XREF: Boss_ViblackRopePhysics+38   j
                cmp.w   d1,d0
                beq.s   loc_43E8E
                bmi.s   loc_43E8E
                addq.w  #4,$52(a5)
                addq.w  #4,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43E8E:                                              ; CODE XREF: Boss_ViblackRopePhysics+3E   j
                                        ; Boss_ViblackRopePhysics+40   j
                neg.w   $54(a5)
                addq.w  #2,$54(a5)
                bra.s   loc_43EB0
; ---------------------------------------------------------------------------
loc_43E98:                                              ; CODE XREF: Boss_ViblackRopePhysics+10   j
                tst.w   d1
                bpl.s   loc_43EA4
                clr.w   $52(a5)
                moveq   #0,d1
                bra.s   loc_43EB4
; ---------------------------------------------------------------------------
loc_43EA4:                                              ; CODE XREF: Boss_ViblackRopePhysics+56   j
                addq.w  #2,4(a5)
                move.w  #$140,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_43EB0:                                              ; CODE XREF: Boss_ViblackRopePhysics+32   j
                                        ; Boss_ViblackRopePhysics+52   j
                move.w  $52(a5),d1
loc_43EB4:                                              ; CODE XREF: Boss_ViblackRopePhysics+28   j
                                        ; Boss_ViblackRopePhysics+48   j
                asr.w   #1,d1
                addi.w  #$C7,d1
                move.w  d1,$14(a5)
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                moveq   #$18,d1
                move.w  $52(a5),d2
                neg.w   d2
                asl.w   #4,d2
                moveq   #9,d7
                movea.w #(word_FFEC24-M68K_RAM),a0
                movea.w #(word_FFEC28-M68K_RAM),a1
loc_43ED8:                                              ; CODE XREF: Boss_ViblackRopePhysics+A6   j
                move.w  d2,d3
                ext.l   d3
                divs.w  d1,d3
                add.w   d0,d3
                move.w  d3,(a0)
                move.w  d3,(a1)
                subq.w  #4,a0
                addq.w  #4,a1
                addq.w  #3,d1
                dbf     d7,loc_43ED8
                rts
; End of function Boss_ViblackRopePhysics
; Timer-based state with stage transition
