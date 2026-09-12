; Shellshogun falling-debris spawner

; Spawns falling debris projectiles at random horizontal positions during Shellshogun boss fight
Boss_ShellshogunSpawnFallingDebris:
                moveq   #0,d7                           ; was: sub_37160
                tst.w   (DifficultyMode).w
                beq.s   Boss_ShellshogunSpawnFallingDebrisNext
                moveq   #2,d7
Boss_ShellshogunSpawnFallingDebrisNext:                 ; CODE XREF: Boss_ShellshogunSpawnFallingDebris+6   j  ; was: loc_3716A
                                        ; Boss_ShellshogunSpawnFallingDebris+82   j
                jsr     (RandomNumber).l
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   Boss_ShellshogunSpawnFallingDebrisReturn
                move.w  #$108,(a0)
                move.w  #$ED80,2(a0)
                move.w  #$8480,$E(a0)
                move.b  #$10,$20(a0)
                move.l  #SharedCombatSpriteAnimation24,8(a0)
                clr.w   $C(a5)
                move.b  #$80,$21(a0)
                move.l  #$FE06FE06,$28(a0)
                move.l  #$FFFF6000,$18(a0)
                move.w  #2,$1C(a0)
                move.w  (RandomNumberState).w,$1E(a0)
                move.w  #$90,$14(a0)
                move.b  (RandomNumberState).w,d0
                andi.w  #$F,d0
                add.w   d0,$14(a0)
                move.w  (RandomNumberState).w,d0
                andi.w  #$7F,d0
                add.w   (PlayerXPosition).w,d0
                move.w  d0,$10(a0)
                dbf     d7,Boss_ShellshogunSpawnFallingDebrisNext
Boss_ShellshogunSpawnFallingDebrisReturn:               ; CODE XREF: Boss_ShellshogunSpawnFallingDebris+1A   j  ; was: locret_371E6
                rts
; End of function Boss_ShellshogunSpawnFallingDebris
