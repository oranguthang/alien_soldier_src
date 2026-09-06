Boss_MedusaSpawnProjectile4:                              ; CODE XREF: Boss_MedusaMovePattern1+2E   p  ; was: sub_570EC
                moveq   #7,d7
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_MedusaSpawnProjectile4
; ---------------------------------------------------------------------------
word_570F8:     dc.w $2020, 0, $FFFF    ; DATA XREF: Boss_MedusaPlayerInputControl:loc_56ADA   o
word_570FE:     dc.w $3060, 0, $2020, 0, $FFFE
                                        ; DATA XREF: Boss_MedusaMovePattern2+6   o
word_57108:     dc.w $2020, 0, $FFFF    ; DATA XREF: Boss_MedusaAnimationScript+D2   o
                                        ; sub_56B6C:loc_56C5C   o ...
word_5710E:     dc.w $1818, $10, $FFFF  ; DATA XREF: Boss_MedusaAnimationScript+2F8   o
word_57114:     dc.w $1010, $28, $FFFF  ; DATA XREF: Boss_MedusaAnimationScript:loc_56B80   o
                                        ; sub_56B6C:loc_56DAC   o
word_5711A:     dc.w $1010, $18, $FFFF  ; DATA XREF: Boss_MedusaAnimationScript:loc_56DD0   o
                                        ; Boss_MedusaAnimationScript+2AC   o
word_57120:     dc.w $308, $30, $E0E, $30, $408, $28, $1010
                                        ; DATA XREF: Boss_MedusaAnimationScript:loc_56BE6   o
                                        ; sub_56B6C:loc_56DB6   o
                dc.w $28, $FFFF
word_57132:     dc.w $401C, $1402, $14, 0, $C01C, $1402, $10
                                        ; DATA XREF: Boss_MedusaAttackState2+3C   o
                dc.w 0, $C0E4, $E4FE, $D0, 0, $401C, $1402
                dc.w $28, $1000, 0, 0, $FC00, 0, $401C
                dc.w $1402, 0, 0, $5018, $8F0, $1E0, 0
                dc.w $4018, $20F0, $238, $1800
word_57172:     dc.w 0, 0, $7090, 0     ; DATA XREF: Boss_MedusaMovePattern1+28   o


; Checks if boss takes damage
Boss_MedusaDamageCheck:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_5717A
                move.w  (dword_FFC630).w,$10(a5)
                clr.w   6(a5)
                move.w  4(a5),d0
                movea.w off_57194(pc,d0.w),a0
                adda.l  #Boss_MedusaUpdateHealth,a0
                jmp     (a0)
; End of function Boss_MedusaDamageCheck
; ---------------------------------------------------------------------------
off_57194:      dc.w Boss_MedusaUpdateHealth-Boss_MedusaUpdateHealth
                                        ; DATA XREF: Boss_MedusaDamageCheck+E   r
                dc.w Projectile_MedusaMain-Boss_MedusaUpdateHealth
                dc.w Boss_MedusaDefeatInit-Boss_MedusaUpdateHealth


; Updates boss health
Boss_MedusaUpdateHealth:                              ; DATA XREF: Boss_MedusaDamageCheck+12   o  ; was: sub_5719A
                                        ; ROM:off_57194   o ...
                addq.w  #2,4(a5)
                move.w  #$400,2(a5)
                move.w  #$C480,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.w  #$128,$14(a5)
loc_571BC:                              ; CODE XREF: Boss_MedusaDefeatInit+1C   j
                move.w  #2,4(a5)
                clr.l   $1C(a5)
                move.b  #1,$56(a5)
                rts
; End of function Boss_MedusaUpdateHealth
; Projectile main handler
Projectile_MedusaMain:                              ; DATA XREF: ROM:00057196   o  ; was: sub_571CE
                jsr (Player_ActionDispatcher).l
                btst    #0,6(a5)
                beq.s   loc_571DE
                rts
; ---------------------------------------------------------------------------
loc_571DE:                              ; CODE XREF: Projectile_MedusaMain+C   j
                move.w  #4,4(a5)
                clr.b   $56(a5)
                rts
; End of function Projectile_MedusaMain
; Defeat sequence initialization
Boss_MedusaDefeatInit:                              ; DATA XREF: ROM:00057198   o  ; was: sub_571EA
                cmpi.w  #7,$1C(a5)
                bpl.s   loc_571FA
                addi.l  #$4000,$1C(a5)
loc_571FA:                              ; CODE XREF: Boss_MedusaDefeatInit+6   j
                jsr (Player_CheckTerrainCollision).l
                btst    #0,6(a5)
                bne.w   loc_571BC
                rts
; End of function Boss_MedusaDefeatInit
; Flash effect on damage
Boss_MedusaFlashDamage:                              ; CODE XREF: Boss_MedusaAttackState1+40   p  ; was: sub_5720C
                tst.w   (word_FF9804).w
                beq.w   locret_572A0
                movea.l $59C(a5),a4
                moveq   #0,d1
                move.w  (word_FF9800).w,d1
                move.w  (a4,d1.w),d2
                bpl.s   loc_57244
                clr.w   (word_FF9800).w
                clr.w   (word_FF9804).w
                cmpi.w  #$FFFE,d2
                bne.s   loc_5723C
                move.l  #word_572B0,$59C(a5)
                rts
; ---------------------------------------------------------------------------
loc_5723C:                              ; CODE XREF: Boss_MedusaFlashDamage+24   j
                addq.w  #2,d1
                adda.l  d1,a4
                move.l  a4,$59C(a5)
loc_57244:                              ; CODE XREF: Boss_MedusaFlashDamage+16   j
                move.w  (dword_FFA900).w,d4
                cmp.w   d2,d4
                beq.s   loc_5724E
                bpl.s   locret_572A0
loc_5724E:                              ; CODE XREF: Boss_MedusaFlashDamage+3E   j
                addq.w  #8,(word_FF9800).w
                move.w  2(a4,d1.w),d5
                beq.w   loc_572A2
                tst.w   (word_FFFF0E).w
                bne.s   loc_57264
                tst.w   d5
                bmi.s   locret_572A0
loc_57264:                              ; CODE XREF: Boss_MedusaFlashDamage+52   j
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_572A0
                move.w  (a4,d1.w),d2
                sub.w   d4,d2
                addi.w  #$80,d2
                move.w  d2,$10(a0)
                andi.w  #$7FFF,d5
                move.w  d5,$14(a0)
                move.w  4(a4,d1.w),$5E(a0)
                move.w  6(a4,d1.w),(a0)
                bpl.s   locret_572A0
                cmpi.w  #$8000,(a0)
                bne.s   loc_5729A
                jmp     loc_2BD00
; ---------------------------------------------------------------------------
loc_5729A:                              ; CODE XREF: Boss_MedusaFlashDamage+86   j
                jmp Effect_SpawnDestructionBlast
; ---------------------------------------------------------------------------
locret_572A0:                           ; CODE XREF: Boss_MedusaFlashDamage+4   j
                                        ; Boss_MedusaFlashDamage+40   j ...
                rts
; ---------------------------------------------------------------------------
loc_572A2:                              ; CODE XREF: Boss_MedusaFlashDamage+4A   j
                move.w  6(a4,d1.w),$47E(a5)
                move.w  4(a4,d1.w),$5E(a5)
                rts
; End of function Boss_MedusaFlashDamage
; ---------------------------------------------------------------------------
word_572B0:	binclude	"data/other/word_572B0.bin"
word_572B0_End:
word_573E6:     dc.w $698, 0, 0, 8, $5D4, $11A, 0, $24C
                                        ; DATA XREF: Boss_MedusaAnimationScript+AE   o
                dc.w $4C4, 0, $120, 4, $4C0, $D0, 0, $8000
                dc.w $480, $130, 0, $8000, $408, $D0, 0, $8000
                dc.w $480, $130, 0, $8000, $3E8, $148, 0, $8001
                dc.w $360, $D0, 0, $8000, $340, $B0, 0, $8000
                dc.w $300, $D0, 0, $8000, $2C0, $B0, 0, $8000
                dc.w $280, $D0, 0, $8000, $240, $B0, 0, $8000
                dc.w $1D8, 0, $B0, 4, $1D0, $DC, 0, $24C
                dc.w $120, $8150, 0, $2B4, $E0, $150, 0, $8000
                dc.w $A0, $150, 0, $8000, $80, 0, 0, 2
                dc.w $60, $150, 0, $8000, $20, $150, 0, $8001
                dc.w $FFFE


; Intro animation init
Boss_SireneIntroInit:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_57498
                tst.w   4(a5)
                beq.w   loc_574E8
                tst.w   8(a5)
                beq.s   loc_574E8
                btst    #2,(byte_FF80EC).w
                bne.s   loc_574D4
                btst    #1,(byte_FF80EC).w
                bne.s   loc_574D4
                tst.w   (word_FF8200).w
                bne.s   loc_574D4
                move.b  #$C1,d0
                jsr (Sound_PlaySFX).l
                bclr    #7,(byte_FF8245).w
                moveq   #$E,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_574D4:                              ; CODE XREF: Boss_SireneIntroInit+14   j
                                        ; Boss_SireneIntroInit+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #$C,d0
                jsr (Boss_ValkirieUpdatePalette).l
loc_574E8:                              ; CODE XREF: Boss_SireneIntroInit+4   j
                                        ; Boss_SireneIntroInit+C   j
                move.w  4(a5),d0
                movea.w off_574F8(pc,d0.w),a0
                adda.l  #Boss_SireneIntroMove,a0
                jmp     (a0)
; End of function Boss_SireneIntroInit
; ---------------------------------------------------------------------------
off_574F8:      dc.w Boss_SireneIntroMove-Boss_SireneIntroMove
                                        ; DATA XREF: Boss_SireneIntroInit+54   r
                dc.w Boss_SirenePlayerInputControl-Boss_SireneIntroMove
                dc.w Boss_SireneBattleStart-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State2-Boss_SireneIntroMove
                dc.w Boss_MedusaStateInit_Return-Boss_SireneIntroMove
                dc.w Boss_SireneShootPattern1-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State6-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State7-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State8-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State10-Boss_SireneIntroMove
                dc.w Enemy_Projectile_State12-Boss_SireneIntroMove


; Intro movement
Boss_SireneIntroMove:                              ; CODE XREF: Boss_SireneShootPattern1   p  ; was: sub_5750E
                                        ; DATA XREF: Boss_SireneIntroInit+58   o ...
                bsr.s Boss_SireneIntroStop
                move.w  #2,$1DE(a5)
                move.w  #$8000,(word_FF808A).w
                bra.w   loc_575DE
; End of function Boss_SireneIntroMove
; Intro stop position
Boss_SireneIntroStop:                              ; CODE XREF: Boss_SireneIntroMove   p  ; was: sub_57520
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1B,d7
                movea.l #off_5A1D4,a0
                movea.l #word_5A244,a1
                movea.l #word_5A260,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A298,$2FC(a5)
                move.l  #word_57D18,$35C(a5)
                move.w  #$434,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                rts
; End of function Boss_SireneIntroStop
; Initializes Sirene boss position and state parameters
Boss_SireneInitPositionState:
                move.w  #2,4(a5)  ; was: sub_57568
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.w   (word_FFA02A).w
                move.w  #$FFF0,$3BC(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$120,$70(a5)
                move.w  #$100,$74(a5)
                move.w  #$C680,$48(a5)
                move.w  #$C680,$4A(a5)
; End of function Boss_SireneInitPositionState
; Processes player directional input to control Sirene during fight
Boss_SirenePlayerInputControl:                              ; DATA XREF: ROM:000574FA   o  ; was: sub_575B6
                btst    #2,(word_FFF706).w
                beq.s   loc_575C2
                addq.w  #2,$56(a5)
loc_575C2:                              ; CODE XREF: Boss_SirenePlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_575CE
                subq.w  #2,$56(a5)
loc_575CE:                              ; CODE XREF: Boss_SirenePlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_57C9A(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_575DE:                              ; CODE XREF: Boss_SireneIntroMove+E   j
                bset    #7,(byte_FF8245).w
                move.w  #$8000,(word_FF808A).w
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$FFF0,$3BC(a5)
                move.w  #$C680,$48(a5)
                move.w  #$C680,$4A(a5)
                move.w  #$80,$11C(a5)
                movea.l #word_57D18,a0
                bsr.w Boss_SireneMovePattern3
; End of function Boss_SirenePlayerInputControl
; Battle start initialization
Boss_SireneBattleStart:                              ; DATA XREF: ROM:000574FC   o  ; was: sub_5761C
                move.w  (dword_FFA410).w,$70(a5)
                move.w  (dword_FFA904).w,d0
                subi.w  #$E200,d0
                addi.w  #$1A0,d0
                move.w  d0,$74(a5)
                subq.w  #1,$11C(a5)
                bmi.s   loc_57642
                lea     word_57CBE(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_57642:                              ; CODE XREF: Boss_SireneBattleStart+1A   j
                addq.w  #2,4(a5)
                bset    #0,(byte_FF8245).w
                move.w  #$58,(word_FFA404).w ; 'X'
; Projectile state 2 tracking phase
Enemy_Projectile_State2:                              ; DATA XREF: ROM:000574FE   o  ; was: loc_57652
                move.w  $6D4(a5),(dword_FFA414).w
                move.w  $70(a5),(dword_FFA410).w
                tst.w   $58(a5)
                bmi.s   loc_5766E
                lea     word_57CBE(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_5766E:                              ; CODE XREF: Boss_SireneBattleStart+46   j
                addq.w  #2,4(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                move.b  #1,(byte_FFA958).w
                moveq   #0,d0
                moveq   #0,d1
                moveq   #0,d3
                moveq   #$1A,d7
                movea.w #(word_FFC680-M68K_RAM),a0
                jsr     (loc_1C290).l
                clr.w   2(a5)
                clr.w   8(a5)
                bset    #2,(byte_FF8144).w
                clr.w   (word_FFA404).w
                move.w  #$200,(dword_FFA414).w
; Return from Medusa boss state initialization
Boss_MedusaStateInit_Return:                           ; DATA XREF: ROM:00057500   o  ; was: locret_576AE
                rts
; End of function Boss_SireneBattleStart
; Shooting pattern 1
Boss_SireneShootPattern1:                              ; DATA XREF: ROM:00057502   o  ; was: sub_576B0
                bsr.w Boss_SireneIntroMove
                move.w  #$C,4(a5)
                move.w  #$FFF0,$3BC(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$180,$10(a5)
                move.w  #$188,$14(a5)
                bset    #0,2(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Projectile state 6 homing behavior
Enemy_Projectile_State6:                              ; DATA XREF: ROM:00057504   o  ; was: loc_576E4
                tst.b   (byte_FFA958).w
                bne.s   loc_576F4
                lea     word_57CAC(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_576F4:                              ; CODE XREF: Boss_SireneShootPattern1+38   j
                addq.w  #2,4(a5)
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #$A2FF,(word_FFA946).w
; Projectile state 7 acceleration
Enemy_Projectile_State7:                              ; DATA XREF: ROM:00057506   o  ; was: loc_5770A
                jsr (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bmi.s   loc_57720
                lea     word_57CAC(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_57720:                              ; CODE XREF: Boss_SireneShootPattern1+64   j
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5) ; '@'
; Projectile state 8 impact phase
Enemy_Projectile_State8:                              ; DATA XREF: ROM:00057508   o  ; was: loc_5772A
                subq.w  #1,$11C(a5)
                bpl.s   loc_57780
                bsr.w Projectile_SireneMain
                lea     (byte_C05C).l,a0
                jsr     (LoadPalette).l
                move.b  #$F9,d0
                jsr (Sound_PlaySFX).l
                clr.w   (word_FFA02A).w
                subi.w  #$20,(word_FFA970).w ; ' '
                addi.w  #$20,(word_FFA974).w ; ' '
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                movea.l #word_1BF2A,a1
                jsr (Sprite_InitFromPointerTable).l
                bclr    #0,2(a5)
                bset    #0,$62(a5)
                bra.w   loc_57794
; ---------------------------------------------------------------------------
loc_57780:                              ; CODE XREF: Boss_SireneShootPattern1+7E   j
                lea     word_57CAC(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_5778A:                              ; CODE XREF: Boss_SireneShootPattern1+15C   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_57794:                              ; CODE XREF: Boss_SireneShootPattern1+CC   j
                move.w  #$12,4(a5)
                move.w  #$C680,$48(a5)
                move.w  #$C680,$4A(a5)
; Projectile state 10 advanced tracking
Enemy_Projectile_State10:                              ; DATA XREF: ROM:0005750A   o  ; was: loc_577A6
                move.w  $54(a5),d1
                clr.w   $54(a5)
                move.w  $70(a5),d0
                cmp.w   (dword_FFDB30).w,d0
                bpl.s   loc_577BE
                move.w  #$100,$54(a5)
loc_577BE:                              ; CODE XREF: Boss_SireneShootPattern1+106   j
                cmp.w   $54(a5),d1
                bne.s   loc_577D6
                bsr.w Projectile_SireneLaser
                bsr.w Boss_SireneSpawnProjectile3
                lea     word_57CAC(pc),a1
                nop
                bra.w Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_577D6:                              ; CODE XREF: Boss_SireneShootPattern1+112   j
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                lea     off_5781C(pc),a0
                nop
                tst.w   $54(a5)
                bne.s   loc_577F8
                lea     off_5782C(pc),a0
                nop
loc_577F8:                              ; CODE XREF: Boss_SireneShootPattern1+140   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.l  (a0,d0.w),$71C(a5)
; Projectile state 12 final trajectory
Enemy_Projectile_State12:                              ; DATA XREF: ROM:0005750C   o  ; was: loc_57806
                tst.w   $58(a5)
                bpl.s   loc_57810
                bra.w   loc_5778A
; ---------------------------------------------------------------------------
loc_57810:                              ; CODE XREF: Boss_SireneShootPattern1+15A   j
                bsr.w Boss_SireneSpawnProjectile3
                movea.l $71C(a5),a1
                bra.w Boss_SireneIdleState
; End of function Boss_SireneShootPattern1
; ---------------------------------------------------------------------------
off_5781C:      dc.l word_57CD8         ; DATA XREF: Boss_SireneShootPattern1+136   o
                dc.l word_57CD8
                dc.l word_57CFC
                dc.l word_57CFC
off_5782C:      dc.l word_57CD8         ; DATA XREF: Boss_SireneShootPattern1+142   o
                dc.l word_57CD8
                dc.l word_57CEA
                dc.l word_57CEA


; Spawns projectile type 3
Boss_SireneSpawnProjectile3:                              ; CODE XREF: Boss_SireneShootPattern1+118   p  ; was: sub_5783C
                                        ; sub_576B0:loc_57810   p
                bsr.w Projectile_SireneBullet
                move.w  (dword_FFA410).w,d0
                move.w  (dword_FFA414).w,d1
                sub.w   (dword_FFDB30).w,d0
                sub.w   (dword_FFDB34).w,d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #5,d0
                muls.w  #$C,d1
                add.l   d0,(dword_FFA414).w
                add.l   d1,(dword_FFA410).w
                cmpi.w  #$159,(dword_FFA414).w
                bmi.s   loc_5788C
                move.w  #$158,(dword_FFA414).w
loc_5788C:                              ; CODE XREF: Boss_SireneSpawnProjectile3+48   j
                move.w  $70(a5),d0
                move.w  $74(a5),d1
                sub.w   (dword_FFDB30).w,d0
                sub.w   (dword_FFDB34).w,d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #4,d0
                muls.w  #$D,d1
                add.l   d0,$74(a5)
                add.l   d1,$70(a5)
                cmpi.w  #$159,$74(a5)
                bmi.s   loc_578D8
                move.w  #$158,$74(a5)
loc_578D8:                              ; CODE XREF: Boss_SireneSpawnProjectile3+94   j
                cmpi.w  #$7F,$74(a5)
                bpl.s   loc_578E6
                move.w  #$80,$74(a5)
loc_578E6:                              ; CODE XREF: Boss_SireneSpawnProjectile3+A2   j
                cmpi.w  #$5F,$70(a5) ; '_'
                bpl.s   loc_578F4
                move.w  #$60,$70(a5) ; '`'
loc_578F4:                              ; CODE XREF: Boss_SireneSpawnProjectile3+B0   j
                cmpi.w  #$1E1,$70(a5)
                bmi.s   loc_57902
                move.w  #$1E0,$70(a5)
loc_57902:                              ; CODE XREF: Boss_SireneSpawnProjectile3+BE   j
                move.l  #$FFFFD000,$47C(a5)
                move.l  #$FFFFEE00,$41C(a5)
                move.l  #$FFFFE000,$5FC(a5)
                move.l  #$FFFFE000,$59C(a5)
                move.l  $47C(a5),d3
                add.l   d3,$4DC(a5)
                move.l  $5FC(a5),d4
                add.l   d4,$65C(a5)
                move.l  $41C(a5),d5
                add.l   d5,$53C(a5)
                move.l  $59C(a5),d6
                add.l   d6,$6BC(a5)
                move.l  $4DC(a5),d3
                move.l  $53C(a5),d5
                btst    #0,(word_FFA000+1).w
                bne.s   loc_5795A
                move.l  $65C(a5),d3
                move.l  $6BC(a5),d5
loc_5795A:                              ; CODE XREF: Boss_SireneSpawnProjectile3+114   j
                movea.w #(byte_FFE602-M68K_RAM),a0
                movea.w a0,a1
                moveq   #$B,d7
                moveq   #0,d1
                move.w  (dword_FFA900).w,d2
                subi.w  #$60,d2 ; '`'
                neg.w   d2
loc_5796E:                              ; CODE XREF: Boss_SireneSpawnProjectile3+150   j
                lea     -$20(a1),a1
                swap    d1
                move.w  d2,d4
                add.w   d1,d4
                move.w  d4,(a0)
                neg.w   d1
                move.w  d2,d4
                add.w   d1,d4
                move.w  d4,(a1)
                neg.w   d1
                swap    d1
                add.l   d3,d1
                lea     $20(a0),a0
                dbf     d7,loc_5796E
                movea.w #(word_FFEC2A-M68K_RAM),a0
                movea.w a0,a1
                moveq   #9,d7
                moveq   #0,d1
loc_5799A:                              ; CODE XREF: Boss_SireneSpawnProjectile3+170   j
                subq.w  #4,a1
                swap    d1
                move.w  d1,(a0)
                neg.w   d1
                move.w  d1,(a1)
                neg.w   d1
                swap    d1
                add.l   d5,d1
                addq.w  #4,a0
                dbf     d7,loc_5799A
                rts
; End of function Boss_SireneSpawnProjectile3
; Projectile main handler
Projectile_SireneMain:                              ; CODE XREF: Boss_SireneShootPattern1+80   p  ; was: sub_579B2
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$48C,(a0)
                move.w  #$100,2(a0)
                clr.b   $21(a0)
                clr.b   $23(a0)
                move.w  #$120,$10(a0)
                move.w  #$F8,$14(a0)
                move.b  #6,(word_FFF7E6+1).w
                move.b  #$C,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                move.w  #0,(word_FFE320).w
                move.w  #$400,(word_FFE33A).w
                rts
; End of function Projectile_SireneMain
; Bullet projectile handler
Projectile_SireneBullet:                              ; CODE XREF: Boss_SireneSpawnProjectile3   p  ; was: sub_579F4
                movea.w #(word_FF9500-M68K_RAM),a0
                move.l  #$D0D0D0D0,d0
                move.l  #$DDDDDDDD,d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_57A0E
                exg     d0,d1
loc_57A0E:                              ; CODE XREF: Projectile_SireneBullet+16   j
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                move.l  d0,(a0)+
                move.l  d1,(a0)+
                movea.w #(word_FF9500-M68K_RAM),a0
                move.w  #$5FE0,d0
                move.w  #$8F02,d3
                move.l  #$94009310,d4
                jsr     (loc_1B78C).l
                btst    #0,(word_FFA000+1).w
                bne.s   loc_57A58
                move.w  #$F000,(word_FF9508).w
                move.w  #$E000,(word_FF951A).w
                move.w  #$820,(word_FFE33C).w
                move.w  #$E20,(word_FFE33E).w
                rts
; ---------------------------------------------------------------------------
loc_57A58:                              ; CODE XREF: Projectile_SireneBullet+48   j
                move.w  #$E0,(word_FF9510).w
                move.w  #$F0,(word_FF9502).w
                move.w  #$E00,(word_FFE33C).w
                move.w  #$A00,(word_FFE33E).w
                rts
; End of function Projectile_SireneBullet
; Idle state handler
Boss_SireneIdleState:                              ; CODE XREF: Boss_SirenePlayerInputControl+24   j  ; was: sub_57A72
                                        ; Boss_SireneBattleStart+22   j ...
                bsr.w Boss_SireneAttackState3
                bsr.w Boss_SireneAttackState1
                moveq   #$1A,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_SireneIdleState
; Attack state 1 handler
Boss_SireneAttackState1:                              ; CODE XREF: Boss_SireneIdleState+4   p  ; was: sub_57A82
                movea.w #(word_FF9800-M68K_RAM),a1
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$1D6(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                movea.w #(byte_FFC856-M68K_RAM),a2
                bsr.w Boss_SireneAttackState2
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$596(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                movea.w #(byte_FFCC16-M68K_RAM),a2
                bsr.w Boss_SireneAttackState2
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                addi.w  #$80,d0
                and.w   d7,d0
                move.w  d0,$8F6(a5)
                move.w  d0,$956(a5)
                movea.w #(byte_FFCFD6-M68K_RAM),a2
                moveq   #2,d7
loc_57AFA:                              ; CODE XREF: Boss_SireneAttackState1+8A   j
                moveq   #$B,d6
loc_57AFC:                              ; CODE XREF: Boss_SireneAttackState1+80   j
                move.w  (a1),d1
                move.w  d0,(a1)+
                move.w  d1,d0
                dbf     d6,loc_57AFC
                move.w  d0,(a2)
                lea     $60(a2),a2
                dbf     d7,loc_57AFA
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  $24(a0),d0
                ext.w   d0
                move.w  $232(a5),d1
                add.w   d0,d1
                move.w  d1,$234(a5)
                move.w  $292(a5),d1
                add.w   d0,d1
                move.w  d1,$294(a5)
                move.w  $2F2(a5),d1
                add.w   d0,d1
                move.w  d1,$2F4(a5)
                move.w  $352(a5),d1
                add.w   d0,d1
                move.w  d1,$354(a5)
                move.w  $5F2(a5),d1
                add.w   d0,d1
                move.w  d1,$5F4(a5)
                move.w  $652(a5),d1
                add.w   d0,d1
                move.w  d1,$654(a5)
                move.w  $6B2(a5),d1
                add.w   d0,d1
                move.w  d1,$6B4(a5)
                move.w  $712(a5),d1
                add.w   d0,d1
                move.w  d1,$714(a5)
                move.w  #$80,d6
                move.w  $3BE(a5),d0
                add.w   $3BC(a5),d0
                move.w  d0,$3BE(a5)
                and.w   d7,d0
                move.w  d0,d1
                move.w  d0,$3B6(a5)
                neg.w   d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,d1
                move.w  d0,$416(a5)
                neg.w   d1
                and.w   d7,d1
                move.w  d1,$7D6(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,d1
                move.w  d0,$476(a5)
                neg.w   d1
                and.w   d7,d1
                move.w  d1,$836(a5)
                add.w   d6,d0
                and.w   d7,d0
                move.w  d0,d1
                move.w  d0,$4D6(a5)
                neg.w   d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                rts
; End of function Boss_SireneAttackState1
; Attack state 2 handler
Boss_SireneAttackState2:                              ; CODE XREF: Boss_SireneAttackState1+26   p  ; was: sub_57BCA
                                        ; Boss_SireneAttackState1+4E   p
                and.w   d7,d0
                moveq   #3,d4
loc_57BCE:                              ; CODE XREF: Boss_SireneAttackState2+16   j
                moveq   #7,d5
loc_57BD0:                              ; CODE XREF: Boss_SireneAttackState2+C   j
                move.w  (a1),d1
                move.w  d0,(a1)+
                move.w  d1,d0
                dbf     d5,loc_57BD0
                move.w  d0,(a2)
                lea     $60(a2),a2
                dbf     d4,loc_57BCE
                rts
; End of function Boss_SireneAttackState2
; Attack state 3 handler
Boss_SireneAttackState3:                              ; CODE XREF: Boss_SireneIdleState   p  ; was: sub_57BE6
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_57C60
loc_57BF0:                              ; CODE XREF: Boss_SireneAttackState3+24   j
                                        ; Boss_SireneMovePattern1+E   j
                move.w  $58(a5),d0
                bmi.w   loc_57C70
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_57C0C
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_57BF0
; ---------------------------------------------------------------------------
loc_57C0C:                              ; CODE XREF: Boss_SireneAttackState3+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_SireneMovePattern1
                move.w  d3,$58(a5)
                bra.w   loc_57C70
; End of function Boss_SireneAttackState3
nullsub_130:
                rts
; End of function nullsub_130


; Movement pattern 1
Boss_SireneMovePattern1:                              ; CODE XREF: Boss_SireneAttackState3+2E   j  ; was: sub_57C20
                cmpi.w  #$FFFF,d3
                bne.s   loc_57C30
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_57BF0
; ---------------------------------------------------------------------------
loc_57C30:                              ; CODE XREF: Boss_SireneMovePattern1+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_SireneMovePattern2
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_57C70
loc_57C60:                              ; CODE XREF: Boss_SireneAttackState3+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #9,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_57C70:                              ; CODE XREF: Boss_SireneAttackState3+E   j
                                        ; Boss_SireneAttackState3+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_SireneMovePattern1
; Movement pattern 2
Boss_SireneMovePattern2:                              ; CODE XREF: Boss_SireneMovePattern1+24   p  ; was: sub_57C7A
                movea.l $2FC(a5),a1
                moveq   #9,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_SireneMovePattern2
; Movement pattern 3
Boss_SireneMovePattern3:                              ; CODE XREF: Boss_SirenePlayerInputControl+62   p  ; was: sub_57C8E
                moveq   #9,d7
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_SireneMovePattern3
; ---------------------------------------------------------------------------
word_57C9A:     dc.w $810, 0, $1010, 0, $810, $A, $1010, $A
                                        ; DATA XREF: Boss_SirenePlayerInputControl+1E   o
                dc.w $FFFF
word_57CAC:     dc.w $820, 0, $C0C, 0, $418, $A, $4040, $A
                                        ; DATA XREF: Boss_SireneShootPattern1+3A   o
                                        ; Boss_SireneShootPattern1+66   o ...
                dc.w $FFFF
word_57CBE:     dc.w $2050, $5A, $2020, $5A, $418, $64, $4040, $64
                                        ; DATA XREF: Boss_SireneBattleStart+1C   o
                                        ; Boss_SireneBattleStart+48   o
                dc.w $2050, $5A, $2020, $5A, $FFFE
word_57CD8:     dc.w $820, $14, $C0C, $14, $418, $1E, $4040, $1E
                                        ; DATA XREF: ROM:off_5781C   o
                                        ; ROM:00057820   o ...
                dc.w $FFFE
word_57CEA:     dc.w $820, $28, $C0C, $28, $418, $32, $4040, $32
                                        ; DATA XREF: ROM:00057834   o
                                        ; ROM:00057838   o
                dc.w $FFFE
word_57CFC:     dc.w $820, $3C, $C0C, $3C, $418, $46, $4040, $46
                                        ; DATA XREF: ROM:00057824   o
                                        ; ROM:00057828   o
                dc.w $FFFE, $820, $50, $1414, $50, $FFFE
word_57D18:     dc.w $88D2, $40F8, $2E4E, $3024, $B201, $9C00, $A0E0, $E0
                                        ; DATA XREF: Boss_SireneIntroStop+30   o
                                        ; Boss_SirenePlayerInputControl+5C   o
                dc.w $1FFA, $C5F8, $8800, $90D0, $20, $6060, $ACEE, $80E0
                dc.w $4800, $6068, $3000, $B814, $88C0, $30E8, $2E40, $2820
                dc.w $AEF4, $7800, $8410, $5874, $FED8, $C00A, $40A0, $2000
                dc.w $80, $D040, $80EE, $A020, $C0A0, $80, $20C0, $A014
                dc.w $9C00, $A0E0, $E0, $1FFA, $C5EE, $80E0, $6000, $2020
                dc.w $4000, $C0F8, $A030, $E0E0, $D0A0, $4000, $C00C


; Empty entity state handler in main dispatch table
Entity_EmptyState9:                              ; DATA XREF: ROM:off_5DC   o  ; was: nullsub_9
                rts
; End of function Entity_EmptyState9
; Laser projectile handler
Projectile_SireneLaser:                              ; CODE XREF: Boss_SireneShootPattern1+114   p  ; was: sub_57D88
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_57DF2
                movea.w #(byte_FFD880-M68K_RAM),a0
                jsr     (loc_1C144).l
                bne.s   locret_57DF2
                move.w  #$490,(a0)
                move.w  #$E100,2(a0)
                move.w  #$8480,$E(a0)
                move.l  #off_E975C,8(a0)
                clr.w   $C(a0)
                move.b  #4,$20(a0)
                move.b  #$40,$21(a0) ; '@'
                move.l  #$FC04FC04,$2C(a0)
                clr.b   $23(a0)
                move.w  #$50,$26(a0) ; 'P'
                move.w  $70(a5),$10(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $74(a5),d0
                move.w  d0,$14(a0)
locret_57DF2:                           ; CODE XREF: Projectile_SireneLaser+8   j
                                        ; Projectile_SireneLaser+14   j
                rts
; End of function Projectile_SireneLaser
; Homing projectile handler
Projectile_SireneHoming:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_57DF4
                cmpi.w  #$88,$14(a5)
                bmi.s   loc_57E18
                cmpi.w  #$170,$14(a5)
                bpl.s   loc_57E18
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$26C,d0
                bpl.s   loc_57E18
                cmpi.w  #$94,d0
                bpl.s   loc_57E20
loc_57E18:                              ; CODE XREF: Projectile_SireneHoming+6   j
                                        ; Projectile_SireneHoming+E   j ...
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_57E20:                              ; CODE XREF: Projectile_SireneHoming+22   j
                tst.w   (word_FF808C).w
                bpl.s   loc_57E66
                bclr    #7,$22(a5)
                beq.s   loc_57E7E
                bclr    #4,$22(a5)
                beq.s   loc_57E66
                move.w  (word_FFA000).w,d0
                andi.w  #$50,d0 ; 'P'
                bne.s   loc_57E66
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_57E66
                moveq   #1,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_57E54
                move.w  #7,d0
loc_57E54:                              ; CODE XREF: Projectile_SireneHoming+5A   j
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (loc_2BD20).l
loc_57E66:                              ; CODE XREF: Projectile_SireneHoming+30   j
                                        ; Projectile_SireneHoming+40   j ...
                move.b  #$2F,d0 ; '/'
                jsr (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_57E7E:                              ; CODE XREF: Projectile_SireneHoming+38   j
                move.w  (dword_FFDB30).w,d0
                move.w  (dword_FFDB34).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #4,d0
                muls.w  #$D,d1
                add.l   d0,$14(a5)
                add.l   d1,$10(a5)
                rts
; End of function Projectile_SireneHoming
; Intro stop position
Boss_ArtemisIntroStop:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_57EBE
                tst.w   4(a5)
                beq.w   loc_57F0E
                tst.w   8(a5)
                beq.s   loc_57F0E
                btst    #2,(byte_FF80EC).w
                bne.s   loc_57EEA
                btst    #1,(byte_FF80EC).w
                bne.s   loc_57EEA
                tst.w   (word_FF8200).w
                bne.s   loc_57EEA
                moveq   #8,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_57EEA:                              ; CODE XREF: Boss_ArtemisIntroStop+14   j
                                        ; Boss_ArtemisIntroStop+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #$12,d0
                jsr (Boss_ValkirieUpdatePalette).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
                clr.b   $3BD(a5)
loc_57F0E:                              ; CODE XREF: Boss_ArtemisIntroStop+4   j
                                        ; Boss_ArtemisIntroStop+C   j
                move.w  4(a5),d0
                movea.w off_57F1E(pc,d0.w),a0
                adda.l  #Boss_ArtemisBattleStart,a0
                jmp     (a0)
; End of function Boss_ArtemisIntroStop
; ---------------------------------------------------------------------------
off_57F1E:      dc.w Boss_ArtemisBattleStart-Boss_ArtemisBattleStart
                                        ; DATA XREF: Boss_ArtemisIntroStop+54   r
                dc.w Boss_ArtemisPlayerInputControl-Boss_ArtemisBattleStart
                dc.w Boss_ArtemisAttackState1-Boss_ArtemisBattleStart
                dc.w Boss_Medusa_State1-Boss_ArtemisBattleStart
                dc.w Boss_Medusa_State2-Boss_ArtemisBattleStart
                dc.w Boss_ArtemisShootPattern2-Boss_ArtemisBattleStart
                dc.w Boss_ArtemisSpawnProjectile3-Boss_ArtemisBattleStart
                dc.w Boss_ArtemisSpawnProjectile6-Boss_ArtemisBattleStart
                dc.w Projectile_ArtemisBullet1-Boss_ArtemisBattleStart
                dc.w Boss_ArtemisAnimationUpdate-Boss_ArtemisBattleStart
                dc.w Projectile_ArtemisHoming-Boss_ArtemisBattleStart
                dc.w Projectile_ArtemisSpread-Boss_ArtemisBattleStart


; Battle start initialization
Boss_ArtemisBattleStart:                              ; DATA XREF: Boss_ArtemisIntroStop+58   o  ; was: sub_57F36
                                        ; ROM:off_57F1E   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1D,d7
                movea.l #off_5A0EE,a0
                movea.l #word_5A166,a1
                movea.l #word_5A184,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A1C0,$2FC(a5)
                move.l  #word_5886C,$35C(a5)
                move.w  #$438,(a5)
                move.w  #$8C00,2(a5)
                clr.w   6(a5)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.w  $18(a0),$18(a5)
                move.w  $1C(a0),$1C(a5)
                move.b  #$10,(byte_FFA420).w
                move.w  #2,$1DE(a5)
                bra.w Boss_ArtemisIdleState
; End of function Boss_ArtemisBattleStart
; Initializes Artemis boss position and state parameters
Boss_ArtemisInitPositionState:
                move.w  #2,4(a5)  ; was: sub_57FA8
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CDA0,$4A(a5)
                move.w  #$130,$794(a5)
                move.w  a5,$48(a5)
                move.w  #$120,$10(a5)
                clr.w   (word_FFA02A).w
; End of function Boss_ArtemisInitPositionState
; Processes player directional input to control Artemis during fight
Boss_ArtemisPlayerInputControl:                              ; DATA XREF: ROM:00057F20   o  ; was: sub_57FDA
                btst    #2,(word_FFF706).w
                beq.s   loc_57FE6
                addq.w  #2,$56(a5)
loc_57FE6:                              ; CODE XREF: Boss_ArtemisPlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_57FF2
                subq.w  #2,$56(a5)
loc_57FF2:                              ; CODE XREF: Boss_ArtemisPlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_58786(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; End of function Boss_ArtemisPlayerInputControl
; Idle state handler
Boss_ArtemisIdleState:                              ; CODE XREF: Boss_ArtemisBattleStart+6E   j  ; was: sub_58002
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$FFE0,$50(a5)
                move.l  #$12000,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #2,d0
                move.l  d0,$18(a5)
                move.b  #$26,d0 ; '&'
                jsr (Sound_PlaySFX).l
; End of function Boss_ArtemisIdleState
; Attack state 1 handler
Boss_ArtemisAttackState1:                              ; DATA XREF: ROM:00057F22   o  ; was: sub_5803C
                cmpi.w  #$30,$14(a5) ; '0'
                bmi.s   loc_58066
                addq.w  #2,$50(a5)
                bmi.s   loc_5804E
                clr.w   $50(a5)
loc_5804E:                              ; CODE XREF: Boss_ArtemisAttackState1+C   j
                subi.l  #$1000,$1C(a5)
                subi.w  #$C,$56(a5)
                lea     word_58786(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_58066:                              ; CODE XREF: Boss_ArtemisAttackState1+6   j
                addq.w  #2,4(a5)
                clr.w   $50(a5)
                clr.w   $56(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
; Medusa boss initial movement
Boss_Medusa_State1:                              ; DATA XREF: ROM:00057F24   o  ; was: loc_5807A
                tst.b   (byte_FFA958).w
                bne.s   loc_5808A
                lea     word_58786(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_5808A:                              ; CODE XREF: Boss_ArtemisAttackState1+42   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CDA0,$4A(a5)
                move.w  #$170,$10(a5)
                move.w  #$FDC0,$794(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
; Medusa boss attack preparation
Boss_Medusa_State2:                              ; DATA XREF: ROM:00057F26   o  ; was: loc_580B6
                addi.l  #$78000,$794(a5)
                move.w  $794(a5),d0
                bsr.w Boss_ArtemisShootPattern3
                bpl.s   loc_580D2
                lea     word_58790(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; ---------------------------------------------------------------------------
loc_580D2:                              ; CODE XREF: Boss_ArtemisAttackState1+8A   j
                addq.w  #2,4(a5)
                move.w  #$C980,d0
                move.w  #$CDA0,d1
                bsr.w Boss_ArtemisShootPattern5
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$C2,d0
                jsr (Sound_PlaySFX).l
                movea.l #byte_1BF56,a1
                jsr (Sprite_InitFromPointerTable).l
; End of function Boss_ArtemisAttackState1
; Shooting pattern 2
Boss_ArtemisShootPattern2:                              ; DATA XREF: ROM:00057F28   o  ; was: sub_58102
                tst.w   $58(a5)
                bmi.s   loc_58112
                lea     word_5879E(pc),a1
                nop
                bra.w Boss_ArtemisShootPattern6
; ---------------------------------------------------------------------------
loc_58112:                              ; CODE XREF: Boss_ArtemisShootPattern2+4   j
                addq.w  #2,4(a5)
                move.b  #$F,$3BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bset    #0,2(a5)
                move.b  #$39,d0 ; '9'
                jsr (Sound_PlaySFX).l
; End of function Boss_ArtemisShootPattern2
; Spawns projectile type 3
Boss_ArtemisSpawnProjectile3:                              ; DATA XREF: ROM:00057F2A   o  ; was: sub_58136
                tst.w   $58(a5)
                bpl.s   loc_58158
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                clr.w   (word_FFA02A).w
                subi.w  #$40,(word_FFA970).w ; '@'
                addi.w  #$40,(word_FFA974).w ; '@'
                bra.s Boss_ArtemisSpawnProjectile5
; ---------------------------------------------------------------------------
loc_58158:                              ; CODE XREF: Boss_ArtemisSpawnProjectile3+4   j
                lea     word_587B0(pc),a1
                nop
                bra.w Boss_ArtemisShootPattern6
; End of function Boss_ArtemisSpawnProjectile3
; Spawns projectile type 4
Boss_ArtemisSpawnProjectile4:                              ; CODE XREF: Boss_ArtemisSpawnProjectile5   p  ; was: sub_58162
                                        ; sub_5818A   p
                move.w  #$E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$CF80,d1
                bra.w Boss_ArtemisShootPattern5
; End of function Boss_ArtemisSpawnProjectile4
; Spawns projectile type 5
Boss_ArtemisSpawnProjectile5:                              ; CODE XREF: Boss_ArtemisSpawnProjectile3+20   j  ; was: sub_58184
                                        ; Boss_ArtemisAnimationUpdate+4   j ...
                bsr.s Boss_ArtemisSpawnProjectile4
                bra.w   loc_581E0
; End of function Boss_ArtemisSpawnProjectile5
; Spawns Artemis projectile type 5 by calling projectile 4 spawn
Boss_ArtemisSpawnProjectile5Alt:
                bsr.s Boss_ArtemisSpawnProjectile4  ; was: sub_5818A
; End of function Boss_ArtemisSpawnProjectile5Alt
; Spawns projectile type 6
Boss_ArtemisSpawnProjectile6:                              ; DATA XREF: ROM:00057F2C   o  ; was: sub_5818C
                tst.w   $58(a5)
                bpl.s   loc_58204
                jsr (Boss_ValkirieSetFacing).l
                cmpi.w  #$A0,d0
                bpl.s   loc_581B2
                cmpi.w  #$E0,$BC(a5)
                bmi.s   loc_581B2
                cmpi.w  #$220,$BC(a5)
                bpl.s   loc_581B2
                bra.w Projectile_ArtemisLaser
; ---------------------------------------------------------------------------
loc_581B2:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+10   j
                                        ; Boss_ArtemisSpawnProjectile6+18   j ...
                btst    #0,(dword_FFFF08).w
                beq.s   loc_581E0
                move.w  #$1800,$11C(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_581D0
                move.w  (word_FFA000).w,d4
                andi.w  #7,d4
                bne.s   loc_581DC
loc_581D0:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+38   j
                cmpi.w  #$C0,d0
                bmi.s   loc_581DC
                move.w  #$B00,$11C(a5)
loc_581DC:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+42   j
                                        ; Boss_ArtemisSpawnProjectile6+48   j
                bra.w   loc_5822C
; ---------------------------------------------------------------------------
loc_581E0:                              ; CODE XREF: Boss_ArtemisSpawnProjectile5+2   j
                                        ; Boss_ArtemisSpawnProjectile6+2C   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  (dword_FFFF08).w,d1
                andi.w  #$1C,d1
                bne.s   loc_581FE
                move.b  #$39,d0 ; '9'
                jsr (Sound_PlaySFX).l
loc_581FE:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+66   j
                move.l  off_5820C(pc,d1.w),$41C(a5)
loc_58204:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+4   j
                movea.l $41C(a5),a1
                bra.w Boss_ArtemisShootPattern6
; ---------------------------------------------------------------------------
off_5820C:      dc.l word_587B0         ; DATA XREF: Boss_ArtemisSpawnProjectile6:loc_581FE   r
                dc.l word_58818
                dc.l word_58806
                dc.l word_58806
                dc.l word_587F4
                dc.l word_587F4
                dc.l word_587E2
                dc.l word_587E2
; ---------------------------------------------------------------------------
loc_5822C:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6:loc_581DC   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $3BC(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.l  #$FFFB0000,d0
                bsr.w Projectile_ArtemisBullet2
                move.w  a5,d0
                move.w  a5,d1
                jsr (Boss_ValkirieSpawnProjectile2).l
                move.w  #$8000,(dword_FF8066).w
                lea     word_582A0(pc),a0
                nop
                jsr (Boss_ValkirieUpdateParts).l
; End of function Boss_ArtemisSpawnProjectile6
; Bullet projectile type 1
Projectile_ArtemisBullet1:                              ; DATA XREF: ROM:00057F2E   o  ; was: sub_5826E
                bclr    #0,$23E(a5)
                bne.s   loc_582C2
                addi.l  #$4000,$1C(a5)
                lea     word_58826(pc),a1
                nop
                bsr.w Boss_ArtemisAttackState2
                moveq   #0,d0
                move.w  $11C(a5),d0
                tst.w   $18(a5)
                bpl.s   loc_5829A
                add.l   d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_5829A:                              ; CODE XREF: Projectile_ArtemisBullet1+24   j
                sub.l   d0,$18(a5)
                rts
; ---------------------------------------------------------------------------
word_582A0:     dc.w $B7, $7840, $C680, $EC14, $EC14, $C6E0, $EC14, $EC14
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+D6   o
                dc.w $C7A0, $FA06, $FA06, 0
word_582B8:     dc.w $FF00, $60, $C0, $120, 0
                                        ; DATA XREF: Projectile_ArtemisBullet1+6E   o
; ---------------------------------------------------------------------------
loc_582C2:                              ; CODE XREF: Projectile_ArtemisBullet1+6   j
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                move.b  #1,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$C980,d1
                bsr.w Boss_ArtemisShootPattern5
                lea     word_582B8(pc),a0
                jsr (Boss_ValkirieDestroyParts).l
                bsr.w Projectile_ArtemisInitSprite1
                move.b  #$C2,d0
                jsr (Sound_PlaySFX).l
; End of function Projectile_ArtemisBullet1
; Animation frame update
Boss_ArtemisAnimationUpdate:                              ; DATA XREF: ROM:00057F30   o  ; was: sub_582F4
                tst.w   $58(a5)
                bmi.w Boss_ArtemisSpawnProjectile5
                bsr.w Boss_ArtemisUpdatePaletteFlags
                lea     word_58826(pc),a1
                nop
                bra.w Boss_ArtemisShootPattern6
; End of function Boss_ArtemisAnimationUpdate
; Updates palette flags from animation state for Artemis
Boss_ArtemisUpdatePaletteFlags:                              ; CODE XREF: Boss_ArtemisAnimationUpdate+8   p  ; was: sub_5830A
                move.b  $23E(a5),d0
                andi.b  #$F,d0
                or.b    d0,$3BC(a5)
                rts
; End of function Boss_ArtemisUpdatePaletteFlags
; Bullet projectile type 2
Projectile_ArtemisBullet2:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+C2   p  ; was: sub_58318
                tst.w   $54(a5)
                beq.s   loc_58320
                neg.l   d0
loc_58320:                              ; CODE XREF: Projectile_ArtemisBullet2+4   j
                move.l  d0,$18(a5)
                rts
; End of function Projectile_ArtemisBullet2
; Initializes sprite graphics for Artemis projectile type 1
Projectile_ArtemisInitSprite1:                              ; CODE XREF: Projectile_ArtemisBullet1+78   p  ; was: sub_58326
                lea     (word_1BF64).l,a1
                jmp Sprite_InitFromPointerTable
; End of function Projectile_ArtemisInitSprite1
; Laser projectile handler
Projectile_ArtemisLaser:                              ; CODE XREF: Boss_ArtemisSpawnProjectile6+22   j  ; was: sub_58332
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$CDA0,d0
                move.w  #$CDA0,d1
                bsr.w Boss_ArtemisShootPattern5
                move.b  #4,$3BC(a5)
                move.b  #$DC,d0
                jsr (Sound_PlaySFX).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1C,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_5836E
                moveq   #0,d0
loc_5836E:                              ; CODE XREF: Projectile_ArtemisLaser+38   j
                lea     off_583D2(pc),a0
                nop
                movea.l (a0,d0.w),a0
                move.l  (a0)+,d5
                move.l  (a0)+,d4
                move.w  (a0)+,d7
                moveq   #$40,d6 ; '@'
                bsr.w Boss_ArtemisUpdateSprites
; End of function Projectile_ArtemisLaser
; Homing projectile handler
Projectile_ArtemisHoming:                              ; DATA XREF: ROM:00057F32   o  ; was: sub_58384
                bclr    #7,$23E(a5)
                bne.w Projectile_ArtemisWave
                bclr    #0,$23E(a5)
                beq.s   loc_583A8
                move.w  #$C980,d0
                move.w  #$C980,d1
                bsr.w Boss_ArtemisShootPattern5
                move.b  #1,$3BC(a5)
loc_583A8:                              ; CODE XREF: Projectile_ArtemisHoming+10   j
                bclr    #1,$23E(a5)
                beq.s   loc_583C2
                move.w  #$CBC0,d0
                move.w  #$CBC0,d1
                bsr.w Boss_ArtemisShootPattern5
                move.b  #3,$3BC(a5)
loc_583C2:                              ; CODE XREF: Projectile_ArtemisHoming+2A   j
                move.b  #1,$3BD(a5)
                lea     word_58848(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; End of function Projectile_ArtemisHoming
; ---------------------------------------------------------------------------
off_583D2:      dc.l word_583F2         ; DATA XREF: Projectile_ArtemisLaser:loc_5836E   o
                dc.l word_583F2
                dc.l word_583F2
                dc.l word_583FC
                dc.l word_58406
                dc.l word_58406
                dc.l word_58406
                dc.l word_58410
word_583F2:     dc.w 0, 0, 0, 0, $D8    ; DATA XREF: ROM:off_583D2   o
                                        ; ROM:000583D6   o ...
word_583FC:     dc.w 0, $2000, $FFFF, $D000, $CA
                                        ; DATA XREF: ROM:000583DE   o
word_58406:     dc.w 0, $2000, 0, $4000, $140
                                        ; DATA XREF: ROM:000583E2   o
                                        ; ROM:000583E6   o ...
word_58410:     dc.w 0, $2600, 0, $E00, $110
                                        ; DATA XREF: ROM:000583EE   o


; Wave projectile handler
Projectile_ArtemisWave:                              ; CODE XREF: Projectile_ArtemisHoming+6   j  ; was: sub_5841A
                addq.w  #2,4(a5)
                move.b  #$F,$3BC(a5)
                move.w  #$C980,d0
                move.w  #$CF80,d1
                bsr.w Boss_ArtemisShootPattern5
; End of function Projectile_ArtemisWave
; Spread projectile handler
Projectile_ArtemisSpread:                              ; DATA XREF: ROM:00057F34   o  ; was: sub_58430
                tst.w   $58(a5)
                bpl.s   loc_5843E
                clr.w   $56(a5)
                bra.w Boss_ArtemisSpawnProjectile5
; ---------------------------------------------------------------------------
loc_5843E:                              ; CODE XREF: Projectile_ArtemisSpread+4   j
                move.b  #1,$3BD(a5)
                lea     word_58848(pc),a1
                nop
                bra.w Boss_ArtemisAttackState2
; End of function Projectile_ArtemisSpread
; Shooting pattern 3
Boss_ArtemisShootPattern3:                              ; CODE XREF: Boss_ArtemisAttackState1+86   p  ; was: sub_5844E
                bmi.s   locret_5845E
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                cmp.w   d6,d0
locret_5845E:                           ; CODE XREF: Boss_ArtemisShootPattern3   j
                rts
; End of function Boss_ArtemisShootPattern3
; Shooting pattern 4
Boss_ArtemisShootPattern4:                              ; CODE XREF: Boss_ArtemisShootPattern5+6   p  ; was: sub_58460
                                        ; sub_5847C   p
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                rts
; End of function Boss_ArtemisShootPattern4
; Shooting pattern 5
Boss_ArtemisShootPattern5:                              ; CODE XREF: Boss_ArtemisAttackState1+A2   p  ; was: sub_5846E
                                        ; Boss_ArtemisSpawnProjectile4+1E   j ...
                jsr (Boss_ValkirieSpawnProjectile2).l
                bsr.s Boss_ArtemisShootPattern4
                move.w  d6,$14(a0)
                rts
; End of function Boss_ArtemisShootPattern5
; Shooting pattern 6
Boss_ArtemisShootPattern6:                              ; CODE XREF: Boss_ArtemisShootPattern2+C   j  ; was: sub_5847C
                                        ; Boss_ArtemisSpawnProjectile3+28   j ...
                bsr.s Boss_ArtemisShootPattern4
                movea.w $4A(a5),a0
                move.w  d6,$14(a0)
; End of function Boss_ArtemisShootPattern6
; Attack state 2 handler
Boss_ArtemisAttackState2:                              ; CODE XREF: Boss_ArtemisPlayerInputControl+24   j  ; was: sub_58486
                                        ; Boss_ArtemisAttackState1+26   j ...
                bsr.w Boss_ArtemisMovePattern1
                bsr.w Boss_ArtemisAttackState3
                moveq   #$1C,d7
                jsr (Sprite_InitMetaspriteSimple).l
                move.w  (dword_FFA904).w,d6
                subi.w  #$E200,d6
                addi.w  #$12A,d6
                btst    #0,$3BC(a5)
                beq.s   loc_584B0
                movea.w #(word_FFC980-M68K_RAM),a0
                bsr.s Projectile_ArtemisMain
loc_584B0:                              ; CODE XREF: Boss_ArtemisAttackState2+22   j
                btst    #1,$3BC(a5)
                beq.s   loc_584BE
                movea.w #(byte_FFCBC0-M68K_RAM),a0
                bsr.s Projectile_ArtemisMain
loc_584BE:                              ; CODE XREF: Boss_ArtemisAttackState2+30   j
                btst    #2,$3BC(a5)
                beq.s   loc_584CC
                movea.w #(word_FFCDA0-M68K_RAM),a0
                bsr.s Projectile_ArtemisMain
loc_584CC:                              ; CODE XREF: Boss_ArtemisAttackState2+3E   j
                btst    #3,$3BC(a5)
                beq.s   locret_584DA
                movea.w #(word_FFCF80-M68K_RAM),a0
                bra.s Projectile_ArtemisMain
; ---------------------------------------------------------------------------
locret_584DA:                           ; CODE XREF: Boss_ArtemisAttackState2+4C   j
                rts
; End of function Boss_ArtemisAttackState2
; Projectile main handler
Projectile_ArtemisMain:                              ; CODE XREF: Boss_ArtemisAttackState2+28   p  ; was: sub_584DC
                                        ; Boss_ArtemisAttackState2+36   p ...
                move.w  $14(a0),d0
                move.w  d6,$14(a0)
                sub.w   d6,d0
                sub.w   d0,$74(a0)
                rts
; End of function Projectile_ArtemisMain
; Attack state 3 handler
Boss_ArtemisAttackState3:                              ; CODE XREF: Boss_ArtemisAttackState2+4   p  ; was: sub_584EC
                moveq   #7,d6
                move.b  (a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$B6(a5)
                move.b  4(a0),d4
                asl.w   #1,d4
                and.w   d7,d4
                move.w  d4,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.w  d1,$1D6(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                moveq   #0,d0
                move.w  $10(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                swap    d0
                moveq   #0,d1
                move.w  $14(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $18(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$476(a5)
                moveq   #0,d0
                move.w  $20(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                swap    d0
                moveq   #0,d1
                move.w  $24(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$596(a5)
                move.w  d1,$5F6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $28(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$656(a5)
                moveq   #0,d0
                move.w  $2C(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.w  d0,d2
                subi.w  #$40,d2 ; '@'
                and.w   d7,d2
                move.w  d2,$716(a5)
                swap    d0
                moveq   #0,d1
                move.w  $30(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.w  d1,$7D6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $34(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$836(a5)
                moveq   #0,d0
                move.w  $38(a0),d0
                swap    d0
                asr.l   d6,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$896(a5)
                move.w  d0,d2
                subi.w  #$40,d2 ; '@'
                and.w   d7,d2
                move.w  d2,$8F6(a5)
                swap    d0
                moveq   #0,d1
                move.w  $3C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$956(a5)
                move.w  d1,$9B6(a5)
                swap    d1
                moveq   #0,d0
                move.w  $40(a0),d0
                swap    d0
                asr.l   d6,d0
                add.l   d1,d0
                swap    d0
                and.w   d7,d0
                move.w  d0,$A16(a5)
                moveq   #0,d0
                move.w  $44(a0),d0
                swap    d0
                asr.l   d6,d0
                move.l  #$1E00000,d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$A76(a5)
                swap    d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$AD6(a5)
                swap    d1
                add.l   d0,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$B36(a5)
                move.b  $48(a0),d1
                ext.w   d1
                move.w  $B2(a5),d0
                add.w   d1,d0
                move.w  d0,$B4(a5)
                move.w  $112(a5),d0
                add.w   d1,d0
                move.w  d0,$114(a5)
                tst.b   $3BD(a5)
                bne.s   loc_586AC
                clr.w   $4C(a0)
                rts
; ---------------------------------------------------------------------------
loc_586AC:                              ; CODE XREF: Boss_ArtemisAttackState3+1B8   j
                move.w  $4C(a0),d1
                asr.w   #6,d1
                and.w   d7,d1
                move.w  d1,$56(a5)
                rts
; End of function Boss_ArtemisAttackState3
; Movement pattern 1
Boss_ArtemisMovePattern1:                              ; CODE XREF: Boss_ArtemisAttackState2   p  ; was: sub_586BA
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_58734
loc_586C4:                              ; CODE XREF: Boss_ArtemisMovePattern1+24   j
                                        ; Boss_ArtemisMovePattern2+E   j
                move.w  $58(a5),d0
                bmi.w   loc_5874C
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_586E0
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_586C4
; ---------------------------------------------------------------------------
loc_586E0:                              ; CODE XREF: Boss_ArtemisMovePattern1+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_ArtemisMovePattern2
                move.w  d3,$58(a5)
                bra.w   loc_5874C
; End of function Boss_ArtemisMovePattern1
nullsub_131:
                rts
; End of function nullsub_131


; Movement pattern 2
Boss_ArtemisMovePattern2:                              ; CODE XREF: Boss_ArtemisMovePattern1+2E   j  ; was: sub_586F4
                cmpi.w  #$FFFF,d3
                bne.s   loc_58704
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_586C4
; ---------------------------------------------------------------------------
loc_58704:                              ; CODE XREF: Boss_ArtemisMovePattern2+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_ArtemisMovePattern3
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5874C
loc_58734:                              ; CODE XREF: Boss_ArtemisMovePattern1+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$13,d7
                tst.b   $3BD(a5)
                beq.s   loc_58746
                addq.w  #1,d7
loc_58746:                              ; CODE XREF: Boss_ArtemisMovePattern2+4E   j
                jsr (Anim_ApplyInterpolationStep).l
loc_5874C:                              ; CODE XREF: Boss_ArtemisMovePattern1+E   j
                                        ; Boss_ArtemisMovePattern1+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ArtemisMovePattern2
; Movement pattern 3
Boss_ArtemisMovePattern3:                              ; CODE XREF: Boss_ArtemisMovePattern2+24   p  ; was: sub_58756
                movea.l $2FC(a5),a1
                moveq   #$13,d7
                tst.b   $3BD(a5)
                beq.s   loc_58764
                addq.w  #1,d7
loc_58764:                              ; CODE XREF: Boss_ArtemisMovePattern3+A   j
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ArtemisMovePattern3
; Loads animation frame delays based on boss state
Boss_ArtemisLoadAnimationFrames:
                moveq   #$13,d7  ; was: sub_58772
                tst.b   $3BD(a5)
                beq.s   loc_5877C
                addq.w  #1,d7
loc_5877C:                              ; CODE XREF: Boss_ArtemisLoadAnimationFrames+6   j
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ArtemisLoadAnimationFrames
; ---------------------------------------------------------------------------
word_58786:     dc.w $1010, $50, $4040, $64, $FFFE
                                        ; DATA XREF: Boss_ArtemisPlayerInputControl+1E   o
                                        ; Boss_ArtemisAttackState1+20   o ...
word_58790:     dc.w $808, $50, $E10, $64, $4040, $64, $FFFE
                                        ; DATA XREF: Boss_ArtemisAttackState1+8C   o
word_5879E:     dc.w $C0C, $78, $1212, $8C, $840, $A0, $1818, $A0
                                        ; DATA XREF: Boss_ArtemisShootPattern2+6   o
                dc.w $FFFE
word_587B0:     dc.w $C14, 0, $40E, 0, $208, 0, $20B, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile3:loc_58158   o
                                        ; sub_5818C:off_5820C   o
                dc.w $208, 0, $20B, $3C, $208, 0, $20B, $3C
                dc.w $1010, 0, $80E, $28, $909, $28, $A0A, $3C
                dc.w $FFFE
word_587E2:     dc.w $810, 0, $80E, $28, $909, $28, $A0A, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+98   o
                                        ; Boss_ArtemisSpawnProjectile6+9C   o
                dc.w $FFFE
word_587F4:     dc.w $40A, 0, $60C, $28, $505, $28, $606, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+90   o
                                        ; Boss_ArtemisSpawnProjectile6+94   o
                dc.w $FFFE
word_58806:     dc.w $1034, 0, $30C, $28, $1010, $28, $410, $3C
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+88   o
                                        ; Boss_ArtemisSpawnProjectile6+8C   o
                dc.w $FFFE
word_58818:     dc.w $818, $28, $2020, $28, $1818, $3C, $FFFE
                                        ; DATA XREF: Boss_ArtemisSpawnProjectile6+84   o
word_58826:     dc.w $A0A, $B4, $808, $C8, $1515, $DC, $8001, $A0E
                                        ; DATA XREF: Projectile_ArtemisBullet1+10   o
                                        ; Boss_ArtemisAnimationUpdate+C   o
                dc.w $F0, $505, $F0, $800F, $818, $104, $A0A, $104
                dc.w $FFFE
word_58848:     dc.w $820, $118, $1A1A, $118, $8001, $E0E, $12C, $8002
                                        ; DATA XREF: Projectile_ArtemisHoming+44   o
                                        ; Projectile_ArtemisSpread+14   o
                dc.w $1111, $140, $1212, $154, $8080, $80E, $168, $C0C
                dc.w $168, $FFFE
word_5886C:	binclude	"data/other/word_5886C.bin"
word_5886C_End:


; Updates boss sprites
Boss_ArtemisUpdateSprites:                              ; CODE XREF: Projectile_ArtemisLaser+4E   p  ; was: sub_589E8
                tst.w   $54(a5)
                beq.s   loc_589FC
                move.w  #$100,d1
                sub.w   d7,d1
                move.w  d1,d7
                andi.w  #$1FE,d7
                neg.l   d5
loc_589FC:                              ; CODE XREF: Boss_ArtemisUpdateSprites+4   j
                jsr (Projectile_FindFreeSlot).l
                bne.w   locret_58A5C
                move.w  #$488,(a0)
                move.w  #$C100,2(a0)
                move.w  #$480,$E(a0)
                move.l  #word_E90C2,8(a0)
                move.b  $B00(a5),$20(a0)
                subq.b  #4,$20(a0)
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d7.w),d0
                move.w  (a1,d7.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
                move.w  d6,$48(a0)
                tst.w   (word_FFFF0E).w
                bne.s   loc_58A54
                moveq   #0,d4
                moveq   #0,d5
loc_58A54:                              ; CODE XREF: Boss_ArtemisUpdateSprites+66   j
                move.l  d5,$4C(a0)
                move.l  d4,$50(a0)
locret_58A5C:                           ; CODE XREF: Boss_ArtemisUpdateSprites+1A   j
                rts
; End of function Boss_ArtemisUpdateSprites
; Animation script interpreter
Boss_ArtemisAnimationScript:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_58A5E
                tst.w   $48(a5)
                bmi.s   loc_58ADA
                subq.w  #1,$48(a5)
                bpl.s   loc_58A9C
                move.b  #$CB,d0
                jsr (Sound_PlaySFX).l
                move.w  #$8D00,2(a5)
                move.w  #$A00,8(a5)
                move.w  #$F4F4,$A(a5)
                move.b  #$40,$21(a5) ; '@'
                move.l  #$FA06FA06,$2C(a5)
                move.w  #$C7,$26(a5)
                bra.s   loc_58ADA
; ---------------------------------------------------------------------------
loc_58A9C:                              ; CODE XREF: Boss_ArtemisAnimationScript+A   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   (word_FFD110).w,d0
                move.w  d0,$10(a5)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subq.w  #8,d0
                add.w   (word_FFD114).w,d0
                move.w  d0,$14(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.w Boss_ArtemisSpawnRadialProjectile
                bclr    #7,2(a5)
                bra.w Boss_ArtemisSpawnRadialProjectile
; ---------------------------------------------------------------------------
loc_58ADA:                              ; CODE XREF: Boss_ArtemisAnimationScript+4   j
                                        ; Boss_ArtemisAnimationScript+3C   j
                move.w  (dword_FFA904).w,d0
                subi.w  #$E200,d0
                addi.w  #$12A,d0
                cmp.w   $14(a5),d0
                bpl.s   loc_58AFC
                clr.l   $18(a5)
                move.l  #$FFFC0000,$1C(a5)
                bra.w   loc_58B68
; ---------------------------------------------------------------------------
loc_58AFC:                              ; CODE XREF: Boss_ArtemisAnimationScript+8C   j
                cmpi.w  #$80,$14(a5)
                bmi.s   loc_58B18
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                cmpi.w  #$26C,d0
                bpl.s   loc_58B18
                cmpi.w  #$94,d0
                bpl.s   loc_58B20
loc_58B18:                              ; CODE XREF: Boss_ArtemisAnimationScript+A4   j
                                        ; Boss_ArtemisAnimationScript+B2   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_58B20:                              ; CODE XREF: Boss_ArtemisAnimationScript+B8   j
                tst.w   (word_FF808C).w
                bpl.s   loc_58B50
                bclr    #7,$22(a5)
                beq.s   loc_58B7C
                bclr    #4,$22(a5)
                beq.s   loc_58B50
                jsr (Projectile_FindFreeSlot).l
                bne.s   loc_58B50
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (loc_2BD18).l
loc_58B50:                              ; CODE XREF: Boss_ArtemisAnimationScript+C6   j
                                        ; Boss_ArtemisAnimationScript+D6   j ...
                move.l  $18(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$18(a5)
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
loc_58B68:                              ; CODE XREF: Boss_ArtemisAnimationScript+9A   j
                move.w  #3,(word_FFA010).w
                move.l  #off_E953C,8(a5)
                jmp Sprite_SetObjectPointer
; ---------------------------------------------------------------------------
loc_58B7C:                              ; CODE XREF: Boss_ArtemisAnimationScript+CE   j
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_58BA2(pc,d0.w),$E(a5)
                move.l  $4C(a5),d0
                add.l   d0,$18(a5)
                move.l  $50(a5),d0
                add.l   d0,$1C(a5)
                bra.w Boss_ArtemisSpawnReflectedProjectile
; End of function Boss_ArtemisAnimationScript
nullsub_132:
                rts
; End of function nullsub_132
; ---------------------------------------------------------------------------
word_58BA2:     dc.w $4489, $4492, $449B, $4492
                                        ; DATA XREF: Boss_ArtemisAnimationScript+128   r


; Spawns projectile in random radial direction from Artemis
Boss_ArtemisSpawnRadialProjectile:                              ; CODE XREF: Boss_ArtemisAnimationScript+6E   j  ; was: sub_58BAA
                                        ; Boss_ArtemisAnimationScript+78   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_58C00
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_58C00
                lea     (dword_2AF1E).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                move.w  (dword_FFFF08).w,d5
                andi.w  #$1FE,d5
                lea     (word_1B514).l,a1
                move.w  word_1B494-word_1B514(a1,d5.w),d0
                move.w  (a1,d5.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$1C(a0)
                move.l  d1,$18(a0)
locret_58C00:                           ; CODE XREF: Boss_ArtemisSpawnRadialProjectile+8   j
                                        ; Boss_ArtemisSpawnRadialProjectile+10   j
                rts
; End of function Boss_ArtemisSpawnRadialProjectile
; Spawns projectile with reversed velocity every other frame
Boss_ArtemisSpawnReflectedProjectile:                              ; CODE XREF: Boss_ArtemisAnimationScript+13E   j  ; was: sub_58C02
                btst    #0,(word_FFA000+1).w
                bne.s   locret_58C60
                jsr (Projectile_FindFreeSlot).l
                bne.s   locret_58C60
                lea     (dword_2AC32).l,a1
                jsr (Sprite_InitFromTable).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$F,d0
                subi.w  #8,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.b  $20(a5),$20(a0)
                move.l  $18(a5),d0
                neg.l   d0
                move.l  d0,$18(a0)
                move.l  $1C(a5),d0
                neg.l   d0
                move.l  d0,$1C(a0)
locret_58C60:                           ; CODE XREF: Boss_ArtemisSpawnReflectedProjectile+6   j
                                        ; Boss_ArtemisSpawnReflectedProjectile+E   j
                rts
; End of function Boss_ArtemisSpawnReflectedProjectile
; Main loop handler for unknown boss or entity type 1
Boss_Unknown1MainLoop:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_58C62
                tst.w   4(a5)
                beq.w   loc_58C84
                tst.w   8(a5)
                beq.s   loc_58C84
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #$18,d0
                jsr (Boss_ValkirieUpdatePalette).l
loc_58C84:                              ; CODE XREF: Boss_Unknown1MainLoop+4   j
                                        ; Boss_Unknown1MainLoop+C   j
                move.w  4(a5),d0
                movea.w off_58C94(pc,d0.w),a0
                adda.l  #Boss_Unknown1InitMetasprite,a0
                jmp     (a0)
; End of function Boss_Unknown1MainLoop
; ---------------------------------------------------------------------------
off_58C94:      dc.w Boss_Unknown1InitMetasprite-Boss_Unknown1InitMetasprite
                                        ; DATA XREF: Boss_Unknown1MainLoop+26   r
                dc.w Boss_Unknown1PlayerInputControl-Boss_Unknown1InitMetasprite
                dc.w Boss_Sylpheed_AltState1-Boss_Unknown1InitMetasprite


; Initializes metasprite and graphics for unknown boss 1
Boss_Unknown1InitMetasprite:                              ; DATA XREF: Boss_Unknown1MainLoop+2A   o  ; was: sub_58C9A
                                        ; ROM:off_58C94   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$19,d7
                movea.l #off_5A356,a0
                movea.l #word_5A3CE,a1
                movea.l #word_5A3EC,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A428,$2FC(a5)
                move.l  #word_58FCA,$35C(a5)
                move.w  #$43C,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #word_1BF90,a1
                jsr (Sprite_InitFromPointerTable).l
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_58DAA
; End of function Boss_Unknown1InitMetasprite
; Initializes position state 2 for unknown boss 1
Boss_Unknown1InitPositionState2:
                move.w  #2,4(a5)  ; was: sub_58D00
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_Unknown1InitPositionState2
; Processes player directional input for unknown boss 1
Boss_Unknown1PlayerInputControl:                              ; DATA XREF: ROM:00058C96   o  ; was: sub_58D2C
                btst    #2,(word_FFF706).w
                beq.s   loc_58D38
                addq.w  #2,$56(a5)
loc_58D38:                              ; CODE XREF: Boss_Unknown1PlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_58D44
                subq.w  #2,$56(a5)
loc_58D44:                              ; CODE XREF: Boss_Unknown1PlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_58FC0(pc),a1
                nop
                bra.w   loc_58DD8
; End of function Boss_Unknown1PlayerInputControl
; Initializes position state 4 with timer for unknown boss 1
Boss_Unknown1InitPositionState4:
                move.w  #4,4(a5)  ; was: sub_58D54
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$1B58,(word_FF8200).w
                move.w  #$1B58,(word_FF8202).w
                move.w  #$80,$11C(a5)
                subq.w  #1,$11C(a5)
                bpl.s   loc_58DA0
                moveq   #8,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_58DA0:                              ; CODE XREF: Boss_Unknown1InitPositionState4+42   j
                lea     word_58FC0(pc),a1
                nop
                bra.w   loc_58DD8
; ---------------------------------------------------------------------------
loc_58DAA:                              ; CODE XREF: Boss_Unknown1InitMetasprite+62   j
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Sylpheed boss alternate state 1
Boss_Sylpheed_AltState1:                              ; DATA XREF: ROM:00058C98   o  ; was: loc_58DCE
                lea     word_58FC0(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_58DD8:                              ; CODE XREF: Boss_Unknown1PlayerInputControl+24   j
                                        ; Boss_Unknown1InitPositionState4+52   j ...
                bsr.w Boss_ValkirieAnimationScriptBase
                bsr.w Boss_ValkirieSetAnimationAngles
                moveq   #$18,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_Unknown1InitPositionState4
; Sets animation angle values for multiple sprite parts based on source data
Boss_ValkirieSetAnimationAngles:                              ; CODE XREF: Boss_Unknown1InitPositionState4+88   p  ; was: sub_58DE8
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                move.b  8(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$176(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d0,$356(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$4D6(a5)
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                addi.w  #$100,d0
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $38(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $3C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                addi.w  #$100,d0
                move.b  $40(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$9B6(a5)
                move.b  $44(a0),d1
                ext.w   d1
                move.w  $B2(a5),d0
                add.w   d1,d0
                move.w  d0,$B4(a5)
                move.w  $112(a5),d0
                add.w   d1,d0
                move.w  d0,$114(a5)
                rts
; End of function Boss_ValkirieSetAnimationAngles
; Processes animation script commands, handles frame delays and script control flow
Boss_ValkirieAnimationScriptBase:                              ; CODE XREF: Boss_Unknown1InitPositionState4:loc_58DD8   p  ; was: sub_58F0C
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_58F86
loc_58F16:                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+24   j
                                        ; Boss_ValkirieAnimationScriptContinue+E   j
                move.w  $58(a5),d0
                bmi.w   loc_58F96
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_58F32
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_58F16
; ---------------------------------------------------------------------------
loc_58F32:                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_ValkirieAnimationScriptContinue
                move.w  d3,$58(a5)
                bra.w   loc_58F96
; End of function Boss_ValkirieAnimationScriptBase
nullsub_133:
                rts
; End of function nullsub_133


; Continues animation script processing, handles loop and end commands
Boss_ValkirieAnimationScriptContinue:                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+2E   j  ; was: sub_58F46
                cmpi.w  #$FFFF,d3
                bne.s   loc_58F56
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_58F16
; ---------------------------------------------------------------------------
loc_58F56:                              ; CODE XREF: Boss_ValkirieAnimationScriptContinue+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_ValkirieSetupInterpolationBase
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_58F96
loc_58F86:                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$11,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_58F96:                              ; CODE XREF: Boss_ValkirieAnimationScriptBase+E   j
                                        ; Boss_ValkirieAnimationScriptBase+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationScriptContinue
; Sets up animation interpolation for 18 sprite parts, calculates deltas
Boss_ValkirieSetupInterpolationBase:                              ; CODE XREF: Boss_ValkirieAnimationScriptContinue+24   p  ; was: sub_58FA0
                movea.l $2FC(a5),a1
                moveq   #$11,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolationBase
; Loads frame delay values for animation system with 18 sprite parts
Boss_ValkirieLoadFrameDelaysBase:
                moveq   #$11,d7  ; was: sub_58FB4
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameDelaysBase
; ---------------------------------------------------------------------------
word_58FC0:     dc.w $2020, 0, $2020, $12, $FFFF
                                        ; DATA XREF: Boss_Unknown1PlayerInputControl+1E   o
                                        ; sub_58D54:loc_58DA0   o ...
word_58FCA:     dc.w $40F8, $C49A, $B80A, $E654, $E05E, $EE20, $2022, $12E0
                                        ; DATA XREF: Boss_Unknown1InitMetasprite+30   o
                dc.w $E000, $3E04, $C092, $C412, $F058, $D062, $E91C, $201E
                dc.w $17E4, $E002


; Main update routine for Valkyrie boss, handles state dispatch and palette updates
Boss_ValkirieMainAlt:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_58FEE
                tst.w   4(a5)
                beq.w   loc_5902E
                tst.w   8(a5)
                beq.s   loc_5902E
                btst    #2,(byte_FF80EC).w
                bne.s   loc_5901A
                btst    #1,(byte_FF80EC).w
                bne.s   loc_5901A
                tst.w   (word_FF8200).w
                bne.s   loc_5901A
                moveq   #$C,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_5901A:                              ; CODE XREF: Boss_ValkirieMainAlt+14   j
                                        ; Boss_ValkirieMainAlt+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #$1E,d0
                jsr (Boss_ValkirieUpdatePalette).l
loc_5902E:                              ; CODE XREF: Boss_ValkirieMainAlt+4   j
                                        ; Boss_ValkirieMainAlt+C   j
                move.w  4(a5),d0
                movea.w off_5903E(pc,d0.w),a0
                adda.l  #Boss_ValkirieInitAlt,a0
                jmp     (a0)
; End of function Boss_ValkirieMainAlt
; ---------------------------------------------------------------------------
off_5903E:      dc.w Boss_ValkirieInitAlt-Boss_ValkirieInitAlt
                                        ; DATA XREF: Boss_ValkirieMainAlt+44   r
                dc.w Boss_ValkirieState3Setup-Boss_ValkirieInitAlt
                dc.w Boss_Valkirie_AltState2-Boss_ValkirieInitAlt


; Initializes Valkyrie boss entity, sets up metasprites, animation data
Boss_ValkirieInitAlt:                              ; DATA XREF: Boss_ValkirieMainAlt+48   o  ; was: sub_59044
                                        ; ROM:off_5903E   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$8300,(dword_FF8040).w
                moveq   #$17,d7
                movea.l #off_5A2A2,a0
                movea.l #word_5A302,a1
                movea.l #word_5A31A,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A34A,$2FC(a5)
                move.l  #word_593BC,$35C(a5)
                move.w  #$440,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.l #word_1BFA0,a1
                jsr (Sprite_InitFromPointerTable).l
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_590E4
; End of function Boss_ValkirieInitAlt
; Initializes boss state 2, sets position to ($120,$E0), clears animation script pointer
Boss_ValkirieState2Init:
                move.w  #2,4(a5)  ; was: sub_590AA
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; End of function Boss_ValkirieState2Init
; Sets up boss state 3 animation, loads animation script and calls sprite rendering
Boss_ValkirieState3Setup:                              ; DATA XREF: ROM:00059040   o  ; was: sub_590DA
                lea     word_593B2(pc),a1
                nop
                bra.w   loc_59124
; ---------------------------------------------------------------------------
loc_590E4:                              ; CODE XREF: Boss_ValkirieInitAlt+62   j
                move.w  #4,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                clr.b   (byte_FF80EC).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$70,$11C(a5) ; 'p'
; Valkirie boss alternate attack state
Boss_Valkirie_AltState2:                              ; DATA XREF: ROM:00059042   o  ; was: loc_5911A
                lea     word_593B2(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_59124:                              ; CODE XREF: Boss_ValkirieState3Setup+6   j
                                        ; Boss_ValkirieState3Setup+46   j
                bsr.w Boss_ValkirieAnimationScriptAlt
                bsr.w Boss_ValkirieSetSymmetricAngles
                moveq   #$16,d7
                jmp Sprite_InitMetaspriteSimple
; End of function Boss_ValkirieState3Setup
; Sets symmetric sprite angles for left/right mirrored parts
Boss_ValkirieSetSymmetricAngles:                              ; CODE XREF: Boss_ValkirieState3Setup+4E   p  ; was: sub_59134
                move.w  #$100,d6
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$3B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$416(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$476(a5)
                move.b  $C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$4D6(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                move.w  d6,d5
                sub.w   d0,d5
                and.w   d7,d5
                move.w  d5,$536(a5)
                move.w  #$80,$B6(a5)
                move.w  #$80,$176(a5)
                move.b  $18(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$596(a5)
                move.w  d6,d5
                sub.w   d3,d5
                and.w   d7,d5
                move.w  d5,$6B6(a5)
                move.b  $1C(a0),d3
                asl.w   #1,d3
                and.w   d7,d3
                move.w  d3,$5F6(a5)
                move.w  d3,$656(a5)
                move.w  d6,d5
                sub.w   d3,d5
                and.w   d7,d5
                move.w  d5,$716(a5)
                move.w  d5,$776(a5)
                move.b  $20(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$7D6(a5)
                move.w  d2,$836(a5)
                move.w  d6,d5
                sub.w   d2,d5
                and.w   d7,d5
                move.w  d5,$896(a5)
                move.w  d5,$8F6(a5)
                move.b  $24(a0),d2
                asl.w   #1,d2
                and.w   d7,d2
                move.w  d2,$116(a5)
                move.b  $28(a0),d1
                ext.w   d1
                move.w  d1,d2
                asr.w   #1,d2
                move.w  $112(a5),d0
                sub.w   d2,d0
                move.w  d0,$114(a5)
                move.w  $B2(a5),d0
                add.w   d2,d0
                move.w  d0,$B4(a5)
                move.w  $592(a5),d0
                add.w   d1,d0
                move.w  d0,$594(a5)
                move.w  $5F2(a5),d0
                add.w   d2,d0
                move.w  d0,$5F4(a5)
                move.w  $652(a5),d0
                add.w   d2,d0
                move.w  d0,$654(a5)
                move.w  $6B2(a5),d0
                add.w   d1,d0
                move.w  d0,$6B4(a5)
                move.w  $712(a5),d0
                add.w   d2,d0
                move.w  d0,$714(a5)
                move.w  $772(a5),d0
                add.w   d2,d0
                move.w  d0,$774(a5)
                move.w  $7D2(a5),d0
                sub.w   d1,d0
                move.w  d0,$7D4(a5)
                move.w  $832(a5),d0
                sub.w   d1,d0
                move.w  d0,$834(a5)
                move.w  $892(a5),d0
                sub.w   d2,d0
                move.w  d0,$894(a5)
                move.w  $8F2(a5),d0
                sub.w   d2,d0
                move.w  d0,$8F4(a5)
                move.b  $2C(a0),d1
                ext.w   d1
                move.w  d1,d2
                move.w  $1D2(a5),d0
                add.w   d2,d0
                move.w  d0,$1D4(a5)
                move.w  $232(a5),d0
                add.w   d2,d0
                move.w  d0,$234(a5)
                move.w  $292(a5),d0
                add.w   d2,d0
                move.w  d0,$294(a5)
                move.w  $2F2(a5),d0
                add.w   d2,d0
                move.w  d0,$2F4(a5)
                move.w  $352(a5),d0
                add.w   d2,d0
                move.w  d0,$354(a5)
                move.w  $3B2(a5),d0
                add.w   d2,d0
                move.w  d0,$3B4(a5)
                move.w  $412(a5),d0
                add.w   d2,d0
                move.w  d0,$414(a5)
                move.w  $472(a5),d0
                add.w   d2,d0
                move.w  d0,$474(a5)
                move.w  $4D2(a5),d0
                add.w   d2,d0
                move.w  d0,$4D4(a5)
                move.w  $532(a5),d0
                add.w   d2,d0
                move.w  d0,$534(a5)
                rts
; End of function Boss_ValkirieSetSymmetricAngles
; Alternative animation script processor with 12 sprite parts instead of 18
Boss_ValkirieAnimationScriptAlt:                              ; CODE XREF: Boss_ValkirieState3Setup:loc_59124   p  ; was: sub_592FE
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_59378
loc_59308:                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+24   j
                                        ; Boss_ValkirieAnimationScriptAltContinue+E   j
                move.w  $58(a5),d0
                bmi.w   loc_59388
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_59324
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_59308
; ---------------------------------------------------------------------------
loc_59324:                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s Boss_ValkirieAnimationScriptAltContinue
                move.w  d3,$58(a5)
                bra.w   loc_59388
; End of function Boss_ValkirieAnimationScriptAlt
nullsub_134:
                rts
; End of function nullsub_134


; Continues alternative animation script processing for 12-part animations
Boss_ValkirieAnimationScriptAltContinue:                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+2E   j  ; was: sub_59338
                cmpi.w  #$FFFF,d3
                bne.s   loc_59348
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_59308
; ---------------------------------------------------------------------------
loc_59348:                              ; CODE XREF: Boss_ValkirieAnimationScriptAltContinue+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w Boss_ValkirieSetupInterpolationAlt
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_59388
loc_59378:                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr (Anim_ApplyInterpolationStep).l
loc_59388:                              ; CODE XREF: Boss_ValkirieAnimationScriptAlt+E   j
                                        ; Boss_ValkirieAnimationScriptAlt+34   j ...
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationScriptAltContinue
; Sets up animation interpolation for 12 sprite parts, alternative version
Boss_ValkirieSetupInterpolationAlt:                              ; CODE XREF: Boss_ValkirieAnimationScriptAltContinue+24   p  ; was: sub_59392
                movea.l $2FC(a5),a1
                moveq   #$B,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieSetupInterpolationAlt
; Loads frame delay values for 12-part animation system
Boss_ValkirieLoadFrameDelaysAlt:
                moveq   #$B,d7  ; was: sub_593A6
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp Anim_LoadFrameDelays
; End of function Boss_ValkirieLoadFrameDelaysAlt
; ---------------------------------------------------------------------------
word_593B2:     dc.w $2020, 0, $2020, $C, $FFFF
                                        ; DATA XREF: Boss_ValkirieState3Setup   o
                                        ; sub_590DA:loc_5911A   o
word_593BC:     dc.w $8080, $8080, $8040, $6060, $A040, 0, $8080, $8080
                                        ; DATA XREF: Boss_ValkirieInitAlt+30   o
                dc.w $8040, $6060, $A040, 0


; Intro stop position
Boss_SylpheedIntroStop:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_593D4
                tst.w   4(a5)
                beq.w   loc_59432
                tst.w   8(a5)
                beq.s   loc_59432
                btst    #2,(byte_FF80EC).w
                bne.s   loc_59400
                btst    #1,(byte_FF80EC).w
                bne.s   loc_59400
                tst.w   (word_FF8200).w
                bne.s   loc_59400
                moveq   #6,d0
                jmp Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_59400:                              ; CODE XREF: Boss_SylpheedIntroStop+14   j
                                        ; Boss_SylpheedIntroStop+1C   j ...
                lea     (word_3E4C).l,a2
                jsr (Gfx_ProcessColorFade).l
                moveq   #$24,d0 ; '$'
                jsr (Boss_ValkirieUpdatePalette).l
                cmpi.w  #$1E0,$10(a5)
                bmi.s   loc_59424
                move.w  #$1DF,$10(a5)
                bra.s   loc_59432
; ---------------------------------------------------------------------------
loc_59424:                              ; CODE XREF: Boss_SylpheedIntroStop+46   j
                cmpi.w  #$A0,$10(a5)
                bpl.s   loc_59432
                move.w  #$A1,$10(a5)
loc_59432:                              ; CODE XREF: Boss_SylpheedIntroStop+4   j
                                        ; Boss_SylpheedIntroStop+C   j ...
                move.w  4(a5),d0
                movea.w off_59442(pc,d0.w),a0
                adda.l  #Boss_SylpheedBattleStart,a0
                jmp     (a0)
; End of function Boss_SylpheedIntroStop
; ---------------------------------------------------------------------------
off_59442:      dc.w Boss_SylpheedBattleStart-Boss_SylpheedBattleStart
                                        ; DATA XREF: Boss_SylpheedIntroStop+62   r
                dc.w Boss_SylpheedState2-Boss_SylpheedBattleStart
                dc.w Boss_Sirene_AltState9-Boss_SylpheedBattleStart
                dc.w Boss_Sirene_AltState11-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedFlashDamage-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedJumpRising-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedJumpFalling-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedDiveRecovery-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedClimbPattern-Boss_SylpheedBattleStart
                dc.w Boss_Artemis_AltState2-Boss_SylpheedBattleStart
                dc.w Boss_Artemis_AltState3-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedShootPattern1-Boss_SylpheedBattleStart
                dc.w Boss_SylpheedShootPattern2-Boss_SylpheedBattleStart
                dc.w Boss_Sirene_AltState6-Boss_SylpheedBattleStart
                dc.w Boss_Sirene_AltState7-Boss_SylpheedBattleStart


; Battle start initialization
Boss_SylpheedBattleStart:                              ; DATA XREF: Boss_SylpheedIntroStop+66   o  ; was: sub_59460
                                        ; ROM:off_59442   o ...
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1A,d7
                movea.l #off_5A024,a0
                movea.l #word_5A090,a1
                movea.l #word_5A0AC,a2
                jsr (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A0E2,$2FC(a5)
                move.l  #word_59C9C,$35C(a5)
                move.w  #$444,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  $10(a0),$10(a5)
                move.w  $14(a0),$14(a5)
                move.l  $18(a0),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                move.l  $1C(a0),$1C(a5)
                move.w  #2,$1DE(a5)
                bra.w Boss_SylpheedIdleState
; End of function Boss_SylpheedBattleStart
; Initializes Sylpheed boss state, sets position, timers, and health values
Boss_SylpheedStateInit:
                move.w  #2,4(a5)  ; was: sub_594D0
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$1B58,(word_FF8200).w
                move.w  #$1B58,(word_FF8202).w
                clr.w   (word_FFA02A).w
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.w  #$80,$11C(a5)
; End of function Boss_SylpheedStateInit
; Sylpheed boss state 2 handler, loads animation script and branches to attack state
Boss_SylpheedState2:                              ; DATA XREF: ROM:00059444   o  ; was: sub_59512
                lea     word_59C26(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; End of function Boss_SylpheedState2
; Idle state handler
Boss_SylpheedIdleState:                              ; CODE XREF: Boss_SylpheedBattleStart+6C   j  ; was: sub_5951C
                move.w  #$12,4(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.l  (dword_FFDC58).w,$18(a5)
                move.l  (dword_FFDC5C).w,$1C(a5)
                move.w  #$FFE0,$50(a5)
                move.w  #$80,$56(a5)
                move.w  #$120,$3BC(a5)
                move.w  #$2E,(word_FFA02A).w ; '.'
; Artemis boss alternate health bar update
Boss_Artemis_AltState2:                              ; DATA XREF: ROM:00059454   o  ; was: loc_5954E
                cmpi.w  #$10,$14(a5)
                bmi.s   loc_59576
                addq.w  #1,$50(a5)
                bmi.s   loc_59560
                clr.w   $50(a5)
loc_59560:                              ; CODE XREF: Boss_SylpheedIdleState+3E   j
                subi.l  #$1000,$1C(a5)
                bsr.w Boss_SylpheedAttackState1
                lea     word_59C30(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_59576:                              ; CODE XREF: Boss_SylpheedIdleState+38   j
                addq.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #0,$14(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                clr.w   $50(a5)
                move.w  #$180,$56(a5)
                move.w  #$40,$11C(a5) ; '@'
; Artemis boss alternate score rendering
Boss_Artemis_AltState3:                              ; DATA XREF: ROM:00059456   o  ; was: loc_595A4
                subq.w  #1,$11C(a5)
                bmi.s   loc_595B4
                lea     word_59C30(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_595B4:                              ; CODE XREF: Boss_SylpheedIdleState+8C   j
                addq.w  #2,4(a5)
                move.l  #$38000,$1C(a5)
                move.b  #$D0,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_SylpheedIdleState
; Shooting pattern 1
Boss_SylpheedShootPattern1:                              ; DATA XREF: ROM:00059458   o  ; was: sub_595CA
                move.w  (dword_FFA410).w,$10(a5)
                move.w  (dword_FFA414).w,d0
                subi.w  #$20,d0 ; ' '
                cmp.w   $14(a5),d0
                bmi.w   loc_595EA
                lea     word_59C30(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_595EA:                              ; CODE XREF: Boss_SylpheedShootPattern1+12   j
                addq.w  #2,4(a5)
                clr.l   $1C(a5)
                move.b  #1,(byte_FFA958).w
                bclr    #4,(word_FFA40E).w
                move.w  #$80,$11C(a5)
                move.b  #$2B,d0 ; '+'
                jsr (Sound_PlaySFX).l
; End of function Boss_SylpheedShootPattern1
; Shooting pattern 2
Boss_SylpheedShootPattern2:                              ; DATA XREF: ROM:0005945A   o  ; was: sub_5960E
                subq.w  #1,$11C(a5)
                bmi.w Boss_SylpheedAnimationScript
                bsr.w Boss_SylpheedShootPattern3
                bsr.w Boss_SylpheedShootPattern4
                move.w  $10(a5),(dword_FFA410).w
                move.w  $14(a5),d0
                addi.w  #$20,d0 ; ' '
                move.w  d0,(dword_FFA414).w
                clr.l   (dword_FFA41C).w
                lea     word_59C30(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; End of function Boss_SylpheedShootPattern2
; Shooting pattern 3
Boss_SylpheedShootPattern3:                              ; CODE XREF: Boss_SylpheedShootPattern2+8   p  ; was: sub_5963E
                cmpi.w  #$100,$10(a5)
                beq.s   locret_59668
                bpl.s   loc_59656
                addq.w  #4,$10(a5)
                cmpi.w  #$120,$10(a5)
                bpl.s   loc_59662
                rts
; ---------------------------------------------------------------------------
loc_59656:                              ; CODE XREF: Boss_SylpheedShootPattern3+8   j
                subq.w  #4,$10(a5)
                cmpi.w  #$120,$10(a5)
                bpl.s   locret_59668
loc_59662:                              ; CODE XREF: Boss_SylpheedShootPattern3+14   j
                move.w  #$120,$10(a5)
locret_59668:                           ; CODE XREF: Boss_SylpheedShootPattern3+6   j
                                        ; Boss_SylpheedShootPattern3+22   j
                rts
; End of function Boss_SylpheedShootPattern3
; Shooting pattern 4
Boss_SylpheedShootPattern4:                              ; CODE XREF: Boss_SylpheedShootPattern2+C   p  ; was: sub_5966A
                cmpi.w  #$100,$14(a5)
                beq.s   locret_59694
                bpl.s   loc_59682
                addq.w  #2,$14(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   loc_5968E
                rts
; ---------------------------------------------------------------------------
loc_59682:                              ; CODE XREF: Boss_SylpheedShootPattern4+8   j
                subq.w  #2,$14(a5)
                cmpi.w  #$100,$14(a5)
                bpl.s   locret_59694
loc_5968E:                              ; CODE XREF: Boss_SylpheedShootPattern4+14   j
                move.w  #$100,$14(a5)
locret_59694:                           ; CODE XREF: Boss_SylpheedShootPattern4+6   j
                                        ; Boss_SylpheedShootPattern4+22   j
                rts
; End of function Boss_SylpheedShootPattern4
; Animation script interpreter
Boss_SylpheedAnimationScript:                              ; CODE XREF: Boss_SylpheedShootPattern2+4   j  ; was: sub_59696
                addq.w  #2,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.w   (word_FFA02A).w
                bset    #0,(byte_FF8144).w
                clr.w   (word_FFA404).w
                move.b  #$20,(byte_FFA420).w ; ' '
                move.l  #$FFFF0000,$18(a5)
                move.l  #$28000,$1C(a5)
; Sirene boss alternate weapon display
Boss_Sirene_AltState6:                              ; DATA XREF: ROM:0005945C   o  ; was: loc_596CC
                addi.l  #$1000,$18(a5)
                subi.l  #$1000,$1C(a5)
                subi.w  #8,$56(a5)
                bmi.s   loc_596EE
                lea     word_59C42(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_596EE:                              ; CODE XREF: Boss_SylpheedAnimationScript+4C   j
                addq.w  #2,4(a5)
                move.w  #$160,$3BC(a5)
                move.w  #$F0,$3BE(a5)
                movea.l #word_1BFB0,a1
                jsr (Sprite_InitFromPointerTable).l
                move.w  #$40,$11C(a5) ; '@'
; Sirene boss alternate counter update
Boss_Sirene_AltState7:                              ; DATA XREF: ROM:0005945E   o  ; was: loc_59710
                subq.w  #1,$11C(a5)
                bpl.s   loc_5972A
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                move.w  #4,4(a5)
                bra.w   loc_5975E
; ---------------------------------------------------------------------------
loc_5972A:                              ; CODE XREF: Boss_SylpheedAnimationScript+7E   j
                bsr.w Boss_SylpheedAnimationUpdate
                lea     word_59C42(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; End of function Boss_SylpheedAnimationScript
; Sylpheed boss idle waiting state, counts down timer and checks player conditions
Boss_SylpheedIdleWait:                              ; CODE XREF: Boss_SylpheedJumpFalling+4   j  ; was: sub_59738
                                        ; Boss_SylpheedClimbPattern+4   j
                move.w  #$60,$11E(a5) ; '`'
                tst.w   (word_FFFF0E).w
                beq.s   loc_5974A
                move.w  #$40,$11E(a5) ; '@'
loc_5974A:                              ; CODE XREF: Boss_SylpheedIdleWait+A   j
                                        ; Boss_SylpheedFlashDamage+4   j
                move.w  #4,4(a5)
                clr.b   $23E(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_5975E:                              ; CODE XREF: Boss_SylpheedAnimationScript+90   j
                move.w  #$160,$3BC(a5)
                move.w  #$F0,$3BE(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$10,d0
                move.w  d0,$11C(a5)
; Sirene boss alternate health bar
Boss_Sirene_AltState9:                              ; DATA XREF: ROM:00059446   o  ; was: loc_5977A
                subq.w  #1,$11E(a5)
                bpl.s   loc_597B4
                move.w  #$FFFF,$11E(a5)
                tst.w   (word_FFFF0E).w
                beq.s   loc_59794
                cmpi.w  #$2858,(word_FF8200).w
                bmi.s   loc_597A0
loc_59794:                              ; CODE XREF: Boss_SylpheedIdleWait+52   j
                btst    #2,(byte_FF8244).w
                beq.s   loc_597A0
                bra.w   loc_597C2
; ---------------------------------------------------------------------------
loc_597A0:                              ; CODE XREF: Boss_SylpheedIdleWait+5A   j
                                        ; Boss_SylpheedIdleWait+62   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_597B4
                btst    #0,(dword_FFFF08).w
                beq.w Boss_SylpheedJumpAttackInit
                bra.w Boss_SylpheedDiveSetup
; ---------------------------------------------------------------------------
loc_597B4:                              ; CODE XREF: Boss_SylpheedIdleWait+46   j
                                        ; Boss_SylpheedIdleWait+6C   j
                bsr.w Boss_SylpheedDefeatInit
                lea     word_59C54(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_597C2:                              ; CODE XREF: Boss_SylpheedIdleWait+64   j
                move.w  #6,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$2C000,$18(a5)
; Sirene boss alternate timer display
Boss_Sirene_AltState11:                              ; DATA XREF: ROM:00059448   o  ; was: loc_597DA
                tst.w   $58(a5)
                bmi.w   loc_597F4
                subi.l  #$1800,$18(a5)
                lea     word_59C66(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; ---------------------------------------------------------------------------
loc_597F4:                              ; CODE XREF: Boss_SylpheedIdleWait+A6   j
                addq.w  #2,4(a5)
                move.w  #$60,$11C(a5) ; '`'
                move.w  #$1D0,$3BC(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$F1,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_SylpheedIdleWait
; Flash effect on damage
Boss_SylpheedFlashDamage:                              ; DATA XREF: ROM:0005944A   o  ; was: sub_59818
                subq.w  #1,$11C(a5)
                bmi.w   loc_5974A
                btst    #2,(byte_FF8244).w
                beq.s   loc_5982E
                move.w  #$60,$11C(a5) ; '`'
loc_5982E:                              ; CODE XREF: Boss_SylpheedFlashDamage+E   j
                bsr.w Boss_SylpheedDefeatInit
                lea     word_59C42(pc),a1
                nop
                bra.w Boss_SylpheedAttackState2
; End of function Boss_SylpheedFlashDamage
; Initializes Sylpheed jump attack, sets upward velocity and plays jump sound
Boss_SylpheedJumpAttackInit:                              ; CODE XREF: Boss_SylpheedIdleWait+74   j  ; was: sub_5983C
                move.w  #$A,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$18000,$18(a5)
                move.l  #$C000,$1C(a5)
                move.b  #$DC,d0
                jsr (Sound_PlaySFX).l
; End of function Boss_SylpheedJumpAttackInit
; Handles Sylpheed rising jump movement with gravity deceleration
