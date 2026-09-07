Enemy_FloatingOscillator:                               ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2FCF6
                tst.w   4(a5)
                bne.s   loc_2FD4A
                addq.w  #2,4(a5)
                move.b  #$20,$21(a5)                    ; ' '
                move.w  #2,$46(a5)
                move.w  #$C500,2(a5)
                move.w  #$480,$E(a5)
                move.l  #word_E907A,8(a5)
                move.w  #$A050,$2A(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
                clr.w   $50(a5)
                clr.w   $52(a5)
                clr.w   $54(a5)
                move.w  #$160,$10(a5)
                move.w  #$110,$14(a5)
loc_2FD4A:                                              ; CODE XREF: Enemy_FloatingOscillator+4   j
                subq.w  #1,$54(a5)
                bpl.s   loc_2FD5C
                move.w  #9,$54(a5)
                eori.w  #1,$52(a5)
loc_2FD5C:                                              ; CODE XREF: Enemy_FloatingOscillator+58   j
                tst.w   $52(a5)
                bne.s   loc_2FD6C
                subi.l  #$12000,$10(a5)
                bra.s   loc_2FD74
; ---------------------------------------------------------------------------
loc_2FD6C:                                              ; CODE XREF: Enemy_FloatingOscillator+6A   j
                addi.l  #$12000,$10(a5)
loc_2FD74:                                              ; CODE XREF: Enemy_FloatingOscillator+74   j
                tst.w   $50(a5)
                bne.s   loc_2FD92
                move.l  #$FFFEDD00,$1C(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   locret_2FDA8
                eori.w  #1,$50(a5)
                bra.s   locret_2FDA8
; ---------------------------------------------------------------------------
loc_2FD92:                                              ; CODE XREF: Enemy_FloatingOscillator+82   j
                move.l  #$12300,$1C(a5)
                cmpi.w  #$140,$14(a5)
                bmi.s   locret_2FDA8
                eori.w  #1,$50(a5)
locret_2FDA8:                                           ; CODE XREF: Enemy_FloatingOscillator+92   j
                                        ; Enemy_FloatingOscillator+9A   j
                rts
; End of function Enemy_FloatingOscillator
; Boss spawn and initialization
Boss_DestroyerMK2Spawn:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2FDAA
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
                tst.w   4(a5)
                bne.w   loc_2FE14
                addq.w  #2,4(a5)
                move.w  #$CD00,2(a5)
                move.l  #word_1B1090,8(a5)
                move.w  #$4470,$E(a5)
                cmpi.w  #$18,(StageTableIndex).w
                bcc.s   loc_2FDEE
                move.l  #word_1A0CD0,8(a5)
                move.w  #$4000,$E(a5)
loc_2FDEE:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+34   j
                move.b  #$20,$21(a5)                    ; ' '
                move.w  #2,$46(a5)
                move.l  #$FFE00020,$28(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
                move.w  $4E(a5),$52(a5)
loc_2FE14:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+12   j
                bclr    #0,6(a5)
                bne.s   loc_2FE28
                subq.w  #1,$50(a5)
                bpl.s   loc_2FE34
                clr.w   $50(a5)
                bra.s   loc_2FE34
; ---------------------------------------------------------------------------
loc_2FE28:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+70   j
                cmpi.w  #6,$50(a5)
                bpl.s   loc_2FE34
                addq.w  #1,$50(a5)
loc_2FE34:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+76   j
                                        ; Boss_DestroyerMK2Spawn+7C   j
                move.w  $50(a5),d0
                add.w   $52(a5),d0
                move.w  d0,$14(a5)
                btst    #0,$5F(a5)
                bne.w   loc_2FEC4
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                move.w  d0,d5
                bpl.s   loc_2FE58
                neg.w   d0
loc_2FE58:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+AA   j
                cmpi.w  #$10,d0
                bpl.s   loc_2FE7C
                move.l  $18(a5),d0
                move.l  d0,d1
                bpl.s   loc_2FE68
                neg.l   d0
loc_2FE68:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+BA   j
                cmpi.l  #$2000,d0
                bpl.s   loc_2FE76
                clr.l   $18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FE76:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+C4   j
                tst.l   d1
                bmi.s   loc_2FE98
                bpl.s   loc_2FEBA
loc_2FE7C:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+B2   j
                tst.w   d5
                bmi.s   loc_2FEA2
                tst.w   $18(a5)
                bmi.s   loc_2FE98
                cmpi.w  #2,$18(a5)
                bmi.s   loc_2FE98
                move.l  #$20000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FE98:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+CE   j
                                        ; Boss_DestroyerMK2Spawn+DA   j
                addi.l  #$1200,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEA2:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+D4   j
                tst.w   $18(a5)
                bpl.s   loc_2FEBA
                cmpi.w  #$FFFE,$18(a5)
                bpl.s   loc_2FEBA
                move.l  #$FFFE0000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEBA:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+D0   j
                                        ; Boss_DestroyerMK2Spawn+FC   j
                subi.l  #$1200,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_2FEC4:                                              ; CODE XREF: Boss_DestroyerMK2Spawn+9C   j
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bpl.s   locret_2FED2
                bset    #4,2(a5)
locret_2FED2:                                           ; CODE XREF: Boss_DestroyerMK2Spawn+120   j
                rts
; End of function Boss_DestroyerMK2Spawn
; Initializes Stage 18 enemies
Enemy_Stage18Init:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2FED4
                tst.w   $50(a5)
                bne.w   Projectile_Stage18Bullet
                cmpi.w  #2,4(a5)
                bne.s   loc_2FF08
                move.w  $24(a5),d1
                movea.w $44(a5),a0
                move.w  #$B,d0
loc_2FEF0:                                              ; CODE XREF: Enemy_Stage18Init+24   j
                add.w   $24(a0),d1
                movea.w $44(a0),a0
                dbf     d0,loc_2FEF0
                cmpi.w  #$CE0,d1
                bcc.s   loc_2FF08
                move.w  #4,4(a5)
loc_2FF08:                                              ; CODE XREF: Enemy_Stage18Init+E   j
                                        ; Enemy_Stage18Init+2C   j
                move.w  4(a5),d0
                lea     off_2FF14(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage18Init
; ---------------------------------------------------------------------------
off_2FF14:      dc.w    Enemy_Stage18SpawnerMain-*      ; DATA XREF: Enemy_Stage18Init+38   o
                dc.w    Enemy_Stage18FloaterAttack-*
                dc.w    Boss_InitJetsripperSpread-*
                dc.w    Boss_UpdateFallingSpawner-*

; Enemy spawner main handler
Enemy_Stage18SpawnerMain:                               ; DATA XREF: ROM:off_2FF14   o  ; was: sub_2FF1C
                bsr.w   Enemy_Stage18FloaterMain
                move.w  #$D00,2(a5)
                clr.b   $21(a5)
                clr.w   $5A(a5)
                tst.w   $5E(a5)
                beq.s   loc_2FF4A
                move.w  $10(a5),d0
                addi.w  #$20,d0                         ; ' '
                cmp.w   (dword_FFA410).w,d0
                bcc.w   locret_30BB8
                move.w  #1,$5A(a5)
loc_2FF4A:                                              ; CODE XREF: Enemy_Stage18SpawnerMain+16   j
                lea     off_30028(pc),a4
                nop
                lea     dword_30058(pc),a3
                nop
                movea.w a5,a1
                move.w  #$1000,2(a5)
                move.w  #$B,d7
loc_2FF62:                                              ; CODE XREF: Enemy_Stage18SpawnerMain+8E   j
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.w   locret_30BB8
                move.w  #$1000,2(a0)
                move.w  #$448,(a0)
                move.w  #1,$50(a0)
                move.w  #$100,$24(a0)
                move.w  a0,$44(a1)
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                clr.w   4(a0)
                move.w  d7,d0
                lsl.w   #1,d0
                move.l  (a3,d0.w),$54(a0)
                lsl.w   #1,d0
                move.l  (a4,d0.w),8(a0)
                movea.w a0,a1
                dbf     d7,loc_2FF62
                move.w  #$D00,2(a5)
                movea.w a5,a0
                move.w  #$B,d7
loc_2FFBA:                                              ; CODE XREF: Enemy_Stage18SpawnerMain+A8   j
                movea.w $44(a0),a0
                move.w  #$CD00,2(a0)
                dbf     d7,loc_2FFBA
                clr.w   $44(a1)
                clr.w   $54(a5)
                bsr.w   Enemy_Stage18FloaterInit
                move.l  #word_EB4A6,8(a5)
                bra.w   loc_301E6
; End of function Enemy_Stage18SpawnerMain
; Floater enemy initialization
Enemy_Stage18FloaterInit:                               ; CODE XREF: Enemy_Stage18SpawnerMain+B4   p  ; was: sub_2FFE0
                                        ; sub_304A4   j
                addq.w  #2,4(a5)
; End of function Enemy_Stage18FloaterInit
; Floater enemy main handler
Enemy_Stage18FloaterMain:                               ; CODE XREF: Enemy_Stage18SpawnerMain   p  ; was: sub_2FFE4
                move.w  #$CD00,2(a5)
                move.w  #$380,$E(a5)
                move.b  #$20,$20(a5)                    ; ' '
                move.b  #$C0,$21(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$28,$26(a5)                    ; '('
                move.w  #$100,$24(a5)
                tst.w   (word_FFFF0E).w
                beq.w   locret_30BB8
                move.w  #$104,$24(a5)
                rts
; End of function Enemy_Stage18FloaterMain
; ---------------------------------------------------------------------------
off_30028:      dc.l    word_EB51E                      ; DATA XREF: Enemy_Stage18SpawnerMain:loc_2FF4A   o
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
                dc.l    word_EB4EE
dword_30058:    dc.l    $80004, $40004, $40004, $40004, $40004, $40004
                                        ; DATA XREF: Enemy_Stage18SpawnerMain+34   o
off_30070:      dc.l    off_3007C                       ; DATA XREF: Boss_UpdateAnimationCycle+4   o
                                        ; Projectile_Stage18Homing+10   o
                dc.l    off_300BC
                dc.l    off_300FC
off_3007C:      dc.l    word_EB4A6                      ; DATA XREF: ROM:off_30070   o
                                        ; Enemy_Stage18FloaterAttack+18   o
                dc.l    word_EB4D6
                dc.l    word_EB4CA
                dc.l    word_EB4B2
                dc.l    word_EB4A6
                dc.l    word_EB4D6
                dc.l    word_EB4CA
                dc.l    word_EB4B2
                dc.l    word_EB4A6
                dc.l    word_EB4B2
                dc.l    word_EB4CA
                dc.l    word_EB4D6
                dc.l    word_EB4A6
                dc.l    word_EB4B2
                dc.l    word_EB4CA
                dc.l    word_EB4D6
off_300BC:      dc.l    word_EB4EE                      ; DATA XREF: ROM:00030074   o
                dc.l    word_EB512
                dc.l    word_EB506
                dc.l    word_EB4FA
                dc.l    word_EB4EE
                dc.l    word_EB512
                dc.l    word_EB506
                dc.l    word_EB4FA
                dc.l    word_EB4EE
                dc.l    word_EB4FA
                dc.l    word_EB506
                dc.l    word_EB512
                dc.l    word_EB4EE
                dc.l    word_EB4FA
                dc.l    word_EB506
                dc.l    word_EB512
off_300FC:      dc.l    word_EB51E                      ; DATA XREF: ROM:00030078   o
                dc.l    word_EB54E
                dc.l    word_EB542
                dc.l    word_EB52A
                dc.l    word_EB51E
                dc.l    word_EB54E
                dc.l    word_EB542
                dc.l    word_EB52A
                dc.l    word_EB51E
                dc.l    word_EB52A
                dc.l    word_EB542
                dc.l    word_EB54E
                dc.l    word_EB51E
                dc.l    word_EB52A
                dc.l    word_EB542
                dc.l    word_EB54E
word_3013C:     dc.w    $380, $380, $1B80, $1B80, $1B80, $1B80, $380, $380, $1380, $1380, $1380, $B80, $B80, $B80, $B80, $1380
                                        ; DATA XREF: Enemy_Stage18FloaterAttack+1C   o
                                        ; Boss_UpdateAnimationCycle+24   o

; Floater enemy attack pattern
Enemy_Stage18FloaterAttack:                             ; DATA XREF: ROM:0002FF16   o  ; was: sub_3015C
                bsr.w   Enemy_Stage18FloaterDeath
                bsr.w   Enemy_Stage18TurretInit
                addi.l  #$2000,$1C(a5)
                bsr.w   Enemy_Stage18TurretMain
                move.w  d0,$58(a5)
                lea     off_3007C(pc),a0
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                clr.w   d0
                move.w  #0,d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_301D6
                tst.w   $10(a5)
                bmi.s   loc_301A8
                cmpi.w  #$200,$14(a5)
                bcs.w   locret_30BB8
loc_301A8:                                              ; CODE XREF: Enemy_Stage18FloaterAttack+40   j
                move.w  #$1000,2(a5)
                movea.w $44(a5),a4
                tst.w   $44(a5)
                beq.w   locret_30BB8
                move.w  #$B,d6
loc_301BE:                                              ; CODE XREF: Enemy_Stage18FloaterAttack+74   j
                move.w  #$1000,2(a4)
                tst.w   $44(a4)
                beq.w   locret_30BB8
                movea.w $44(a4),a4
                dbf     d6,loc_301BE
                rts
; ---------------------------------------------------------------------------
loc_301D6:                                              ; CODE XREF: Enemy_Stage18FloaterAttack+3A   j
                move.b  #$EC,d0
                jsr     (Sound_PlaySFX).l
                jsr     (Physics_AlignToTerrain).l
loc_301E6:                                              ; CODE XREF: Enemy_Stage18SpawnerMain+C0   j
                move.l  #$FFFB0000,$1C(a5)
                move.l  $14(a5),$4C(a5)
                move.w  #6,$52(a5)
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$4C0,d0
                bcc.s   loc_30220
                eori.w  #1,$5A(a5)
                bne.s   loc_30220
                move.l  #$20000,$18(a5)
                move.l  $18(a5),$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_30220:                                              ; CODE XREF: Enemy_Stage18FloaterAttack+AA   j
                                        ; Enemy_Stage18FloaterAttack+B2   j
                move.l  #$FFFE0000,$18(a5)
                move.l  $18(a5),$48(a5)
                rts
; End of function Enemy_Stage18FloaterAttack
; Floater enemy death handler
Enemy_Stage18FloaterDeath:                              ; CODE XREF: Enemy_Stage18FloaterAttack   p  ; was: sub_30230
                tst.w   $52(a5)
                beq.w   locret_30BB8
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_30BB8
                move.l  #off_EB566,8(a0)
                movea.w a0,a4
                jsr     (Projectile_InitType88).l
                move.w  #$380,$E(a4)
loc_30258:                                              ; CODE XREF: Boss_UpdateFallingSpawner+42   p
                move.l  $10(a5),$10(a4)
                move.l  $14(a5),$14(a4)
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                bsr.w   Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a4)
                ext.l   d1
                asl.l   #3,d1
                move.l  d1,$1C(a4)
                rts
; End of function Enemy_Stage18FloaterDeath
; Turret enemy initialization
Enemy_Stage18TurretInit:                                ; CODE XREF: Enemy_Stage18FloaterAttack+4   p  ; was: sub_30288
                                        ; sub_304B0   p
                tst.w   $52(a5)
                beq.w   locret_30BB8
                subq.w  #1,$52(a5)
                bne.w   locret_30BB8
                tst.w   $44(a5)
                beq.w   locret_30BB8
                movea.w $44(a5),a0
                move.l  $48(a5),$18(a0)
                move.l  $48(a5),$48(a0)
                move.l  $4C(a5),$14(a0)
                move.l  $4C(a5),$4C(a0)
                move.l  #$FFFB0000,$1C(a0)
                move.w  #6,$52(a0)
                rts
; End of function Enemy_Stage18TurretInit
; Initializes 12 projectiles in spread pattern for Jetsripper boss
Boss_InitJetsripperSpread:                              ; DATA XREF: ROM:0002FF18   o  ; was: sub_302CC
                bsr.w   Boss_CalcRandomAngle
                move.l  d0,$18(a5)
                move.l  d1,$1C(a5)
                clr.w   $56(a5)
                clr.b   $21(a5)
                move.w  #0,d0
                jsr     (Boss_JetsripperAttackPattern1).l
                move.w  #$A,d5
                movea.w $44(a5),a4
                move.w  #$B,d6
loc_302F6:                                              ; CODE XREF: Boss_InitJetsripperSpread+6A   j
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_30314
                move.w  #$FF,d0
                jsr     (loc_2BD20).l
                move.w  $10(a4),$10(a0)
                move.w  $14(a4),$14(a0)
loc_30314:                                              ; CODE XREF: Boss_InitJetsripperSpread+30   j
                bsr.w   Boss_CalcRandomAngle
                move.l  d0,$18(a4)
                move.l  d1,$1C(a4)
                move.w  d5,$56(a4)
                move.w  #4,4(a4)
                clr.b   $21(a4)
                addi.w  #$A,d5
                movea.w $44(a4),a4
                dbf     d6,loc_302F6
                move.b  #$C1,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,4(a5)
                rts
; End of function Boss_InitJetsripperSpread
; Calculates random velocity at angle toward player
Boss_CalcRandomAngle:                                   ; CODE XREF: Boss_InitJetsripperSpread   p  ; was: sub_3034A
                                        ; sub_302CC:loc_30314   p
                jsr     (RandomNumber).l
                andi.w  #$FE,d0
                addi.w  #$100,d0
                bsr.w   Enemy_GustheadGetAngleToPlayer
                ext.l   d0
                asl.l   #3,d0
                ext.l   d1
                asl.l   #3,d1
                rts
; End of function Boss_CalcRandomAngle
; Updates falling entity that periodically spawns projectiles
Boss_UpdateFallingSpawner:                              ; DATA XREF: ROM:0002FF1A   o  ; was: sub_30366
                                        ; ROM:000304A2   o
                bsr.w   Boss_UpdateAnimationCycle
                addi.l  #$2000,$1C(a5)
                clr.w   d0
                clr.w   d1
                jsr     (Physics_AddEntityOffset).l
                bne.s   loc_303AE
                addq.w  #1,$56(a5)
                move.w  $56(a5),d0
                andi.w  #$1F,d0
                bne.w   locret_30BB8
loc_3038E:                                              ; CODE XREF: Boss_UpdateFallingSpawner+4E   j
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.w   locret_30BB8
                move.l  #off_E953C,8(a0)
                movea.w a0,a4
                jsr     (Projectile_InitType88).l
                bsr.w   loc_30258
                rts
; ---------------------------------------------------------------------------
loc_303AE:                                              ; CODE XREF: Boss_UpdateFallingSpawner+16   j
                move.w  #$1000,2(a5)
                bra.w   loc_3038E
; End of function Boss_UpdateFallingSpawner
; Updates animation and graphics based on rotation counter
Boss_UpdateAnimationCycle:                              ; CODE XREF: Boss_UpdateFallingSpawner   p  ; was: sub_303B8
                move.w  $54(a5),d0
                lea     off_30070(pc),a0
                movea.l (a0,d0.w),a0
                move.w  $58(a5),d0
                move.w  d0,d1
                andi.w  #$20,d0                         ; ' '
                addi.w  #4,d1
                andi.w  #$1C,d1
                or.w    d1,d0
                move.w  d0,$58(a5)
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                rts
; End of function Boss_UpdateAnimationCycle
; Turret enemy main handler
Enemy_Stage18TurretMain:                                ; CODE XREF: Enemy_Stage18FloaterAttack+10   p  ; was: sub_303F0
                                        ; Projectile_Stage18Homing+18   p
                bsr.w   Enemy_Stage18TurretAim
                tst.l   $18(a5)
                bpl.w   locret_30BB8
                addi.w  #$20,d0                         ; ' '
                rts
; End of function Enemy_Stage18TurretMain
; Turret aiming at player
Enemy_Stage18TurretAim:                                 ; CODE XREF: Enemy_Stage18TurretMain   p  ; was: sub_30402
                move.l  $1C(a5),d1
                move.l  $18(a5),d0
                bmi.s   Enemy_Stage18TurretFire
                tst.l   d1
                bpl.s   loc_30424
                neg.l   d1
                cmpi.l  #$40000,d1
                bcc.s   loc_30486
                cmpi.l  #$10000,d1
                bcc.s   Enemy_Stage18TurretDeath
                bra.s   loc_30462
; ---------------------------------------------------------------------------
loc_30424:                                              ; CODE XREF: Enemy_Stage18TurretAim+C   j
                cmpi.l  #$40000,d1
                bcc.s   loc_3046E
                cmpi.l  #$10000,d1
                bcc.s   loc_30468
                bra.s   loc_30462
; End of function Enemy_Stage18TurretAim
nullsub_73:
                rts
; End of function nullsub_73

; Turret firing projectile
Enemy_Stage18TurretFire:                                ; CODE XREF: Enemy_Stage18TurretAim+8   j  ; was: sub_30438
                tst.l   d1
                bpl.s   loc_30450
                neg.l   d1
                cmpi.l  #$40000,d1
                bcc.s   loc_30486
                cmpi.l  #$10000,d1
                bcc.s   loc_30480
                bra.s   loc_3047A
; ---------------------------------------------------------------------------
loc_30450:                                              ; CODE XREF: Enemy_Stage18TurretFire+2   j
                cmpi.l  #$40000,d1
                bcc.s   loc_3046E
                cmpi.l  #$10000,d1
                bcc.s   loc_30474
                bra.s   loc_3047A
; ---------------------------------------------------------------------------
loc_30462:                                              ; CODE XREF: Enemy_Stage18TurretAim+20   j
                                        ; Enemy_Stage18TurretAim+32   j
                move.w  #0,d0
                rts
; ---------------------------------------------------------------------------
loc_30468:                                              ; CODE XREF: Enemy_Stage18TurretAim+30   j
                move.w  #4,d0
                rts
; ---------------------------------------------------------------------------
loc_3046E:                                              ; CODE XREF: Enemy_Stage18TurretAim+28   j
                                        ; Enemy_Stage18TurretFire+1E   j
                move.w  #8,d0
                rts
; ---------------------------------------------------------------------------
loc_30474:                                              ; CODE XREF: Enemy_Stage18TurretFire+26   j
                move.w  #$C,d0
                rts
; ---------------------------------------------------------------------------
loc_3047A:                                              ; CODE XREF: Enemy_Stage18TurretFire+16   j
                                        ; Enemy_Stage18TurretFire+28   j
                move.w  #$10,d0
                rts
; ---------------------------------------------------------------------------
loc_30480:                                              ; CODE XREF: Enemy_Stage18TurretFire+14   j
                move.w  #$14,d0
                rts
; ---------------------------------------------------------------------------
loc_30486:                                              ; CODE XREF: Enemy_Stage18TurretAim+16   j
                                        ; Enemy_Stage18TurretFire+C   j
                move.w  #$18,d0
                rts
; End of function Enemy_Stage18TurretFire
; Turret death handler
Enemy_Stage18TurretDeath:                               ; CODE XREF: Enemy_Stage18TurretAim+1E   j  ; was: sub_3048C
                move.w  #$1C,d0
                rts
; End of function Enemy_Stage18TurretDeath
; Stage 18 bullet projectile
Projectile_Stage18Bullet:                               ; CODE XREF: Enemy_Stage18Init+4   j  ; was: sub_30492
                move.w  4(a5),d0
                lea     off_3049E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Stage18Bullet
; ---------------------------------------------------------------------------
off_3049E:      dc.w    Projectile_Stage18Missile-*     ; DATA XREF: Projectile_Stage18Bullet+4   o
                dc.w    Projectile_Stage18Laser-*
                dc.w    Boss_UpdateFallingSpawner-*

; Attributes: thunk
; Stage 18 missile projectile
Projectile_Stage18Missile:                              ; DATA XREF: ROM:off_3049E   o  ; was: sub_304A4
                bra.w   Enemy_Stage18FloaterInit
; End of function Projectile_Stage18Missile
; Stage 18 laser projectile
Projectile_Stage18Laser:                                ; DATA XREF: ROM:000304A0   o  ; was: sub_304A8
                tst.l   $18(a5)
                beq.w   locret_30BB8
; End of function Projectile_Stage18Laser
; Stage 18 homing projectile
Projectile_Stage18Homing:                               ; DATA XREF: ROM:off_2FC46   o  ; was: sub_304B0
                bsr.w   Enemy_Stage18TurretInit
                addi.l  #$2000,$1C(a5)
                move.w  $54(a5),d0
                lea     off_30070(pc),a0
                movea.l (a0,d0.w),a0
                bsr.w   Enemy_Stage18TurretMain
                move.w  d0,$58(a5)
                lea     word_3013C(pc),a1
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                move.w  (a1,d0.w),$E(a5)
                rts
; End of function Projectile_Stage18Homing
; State dispatcher for falling object enemy type
