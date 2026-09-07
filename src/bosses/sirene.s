Boss_SireneIntroInit:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_57498
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
                jsr     (Sound_PlaySFX).l
                bclr    #7,(byte_FF8245).w
                moveq   #$E,d0
                jmp     Boss_MedusaIntroStop
; ---------------------------------------------------------------------------
loc_574D4:                                              ; CODE XREF: Boss_SireneIntroInit+14   j
                                        ; Boss_SireneIntroInit+1C   j
                lea     (word_3E4C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                moveq   #$C,d0
                jsr     (Boss_ValkirieUpdatePalette).l
loc_574E8:                                              ; CODE XREF: Boss_SireneIntroInit+4   j
                                        ; Boss_SireneIntroInit+C   j
                move.w  4(a5),d0
                movea.w off_574F8(pc,d0.w),a0
                adda.l  #Boss_SireneIntroMove,a0
                jmp     (a0)
; End of function Boss_SireneIntroInit
; ---------------------------------------------------------------------------
off_574F8:      dc.w    Boss_SireneIntroMove-Boss_SireneIntroMove
                                        ; DATA XREF: Boss_SireneIntroInit+54   r
                dc.w    Boss_SirenePlayerInputControl-Boss_SireneIntroMove
                dc.w    Boss_SireneBattleStart-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State2-Boss_SireneIntroMove
                dc.w    Boss_MedusaStateInit_Return-Boss_SireneIntroMove
                dc.w    Boss_SireneShootPattern1-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State6-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State7-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State8-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State10-Boss_SireneIntroMove
                dc.w    Enemy_Projectile_State12-Boss_SireneIntroMove

; Intro movement
Boss_SireneIntroMove:                                   ; CODE XREF: Boss_SireneShootPattern1   p  ; was: sub_5750E
                                        ; DATA XREF: Boss_SireneIntroInit+58   o
                bsr.s   Boss_SireneIntroStop
                move.w  #2,$1DE(a5)
                move.w  #$8000,(word_FF808A).w
                bra.w   loc_575DE
; End of function Boss_SireneIntroMove
; Intro stop position
Boss_SireneIntroStop:                                   ; CODE XREF: Boss_SireneIntroMove   p  ; was: sub_57520
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1B,d7
                movea.l #off_5A1D4,a0
                movea.l #word_5A244,a1
                movea.l #word_5A260,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.l  #word_5A298,$2FC(a5)
                move.l  #word_57D18,$35C(a5)
                move.w  #$434,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                rts
; End of function Boss_SireneIntroStop
; Initializes Sirene boss position and state parameters
Boss_SireneInitPositionState:
                move.w  #2,4(a5)                        ; was: sub_57568
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
Boss_SirenePlayerInputControl:                          ; DATA XREF: ROM:000574FA   o  ; was: sub_575B6
                btst    #2,(word_FFF706).w
                beq.s   loc_575C2
                addq.w  #2,$56(a5)
loc_575C2:                                              ; CODE XREF: Boss_SirenePlayerInputControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_575CE
                subq.w  #2,$56(a5)
loc_575CE:                                              ; CODE XREF: Boss_SirenePlayerInputControl+12   j
                andi.w  #$1FE,$56(a5)
                lea     word_57C9A(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_575DE:                                              ; CODE XREF: Boss_SireneIntroMove+E   j
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
                bsr.w   Boss_SireneMovePattern3
; End of function Boss_SirenePlayerInputControl
; Battle start initialization
Boss_SireneBattleStart:                                 ; DATA XREF: ROM:000574FC   o  ; was: sub_5761C
                move.w  (dword_FFA410).w,$70(a5)
                move.w  (dword_FFA904).w,d0
                subi.w  #$E200,d0
                addi.w  #$1A0,d0
                move.w  d0,$74(a5)
                subq.w  #1,$11C(a5)
                bmi.s   loc_57642
                lea     word_57CBE(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_57642:                                              ; CODE XREF: Boss_SireneBattleStart+1A   j
                addq.w  #2,4(a5)
                bset    #0,(byte_FF8245).w
                move.w  #$58,(word_FFA404).w            ; 'X'
; Projectile state 2 tracking phase
Enemy_Projectile_State2:                                ; DATA XREF: ROM:000574FE   o  ; was: loc_57652
                move.w  $6D4(a5),(dword_FFA414).w
                move.w  $70(a5),(dword_FFA410).w
                tst.w   $58(a5)
                bmi.s   loc_5766E
                lea     word_57CBE(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_5766E:                                              ; CODE XREF: Boss_SireneBattleStart+46   j
                addq.w  #2,4(a5)
                move.w  #$7000,(word_FF8200).w
                move.w  #$7000,(word_FF8202).w
                move.b  #1,(byte_FFA958).w
                moveq   #0,d0
                moveq   #0,d1
                moveq   #0,d3
                moveq   #$1A,d7
                movea.w #(word_FFC680-M68K_RAM),a0
                jsr     (Object_ClearAllExceptTypes_Loop).l
                clr.w   2(a5)
                clr.w   8(a5)
                bset    #2,(byte_FF8144).w
                clr.w   (word_FFA404).w
                move.w  #$200,(dword_FFA414).w
; Return from Medusa boss state initialization
Boss_MedusaStateInit_Return:                            ; DATA XREF: ROM:00057500   o  ; was: locret_576AE
                rts
; End of function Boss_SireneBattleStart
; Shooting pattern 1
Boss_SireneShootPattern1:                               ; DATA XREF: ROM:00057502   o  ; was: sub_576B0
                bsr.w   Boss_SireneIntroMove
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
Enemy_Projectile_State6:                                ; DATA XREF: ROM:00057504   o  ; was: loc_576E4
                tst.b   (byte_FFA958).w
                bne.s   loc_576F4
                lea     word_57CAC(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_576F4:                                              ; CODE XREF: Boss_SireneShootPattern1+38   j
                addq.w  #2,4(a5)
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                move.w  #$A2FF,(word_FFA946).w
; Projectile state 7 acceleration
Enemy_Projectile_State7:                                ; DATA XREF: ROM:00057506   o  ; was: loc_5770A
                jsr     (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bmi.s   loc_57720
                lea     word_57CAC(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_57720:                                              ; CODE XREF: Boss_SireneShootPattern1+64   j
                addq.w  #2,4(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Projectile state 8 impact phase
Enemy_Projectile_State8:                                ; DATA XREF: ROM:00057508   o  ; was: loc_5772A
                subq.w  #1,$11C(a5)
                bpl.s   loc_57780
                bsr.w   Projectile_SireneMain
                lea     (byte_C05C).l,a0
                jsr     (LoadPalette).l
                move.b  #$F9,d0
                jsr     (Sound_PlaySFX).l
                clr.w   (word_FFA02A).w
                subi.w  #$20,(word_FFA970).w            ; ' '
                addi.w  #$20,(word_FFA974).w            ; ' '
                clr.b   (byte_FF80EC).w
                bclr    #0,(byte_FFA272).w
                movea.l #Boss_SireneObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bclr    #0,2(a5)
                bset    #0,$62(a5)
                bra.w   loc_57794
; ---------------------------------------------------------------------------
loc_57780:                                              ; CODE XREF: Boss_SireneShootPattern1+7E   j
                lea     word_57CAC(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_5778A:                                              ; CODE XREF: Boss_SireneShootPattern1+15C   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_57794:                                              ; CODE XREF: Boss_SireneShootPattern1+CC   j
                move.w  #$12,4(a5)
                move.w  #$C680,$48(a5)
                move.w  #$C680,$4A(a5)
; Projectile state 10 advanced tracking
Enemy_Projectile_State10:                               ; DATA XREF: ROM:0005750A   o  ; was: loc_577A6
                move.w  $54(a5),d1
                clr.w   $54(a5)
                move.w  $70(a5),d0
                cmp.w   (dword_FFDB30).w,d0
                bpl.s   loc_577BE
                move.w  #$100,$54(a5)
loc_577BE:                                              ; CODE XREF: Boss_SireneShootPattern1+106   j
                cmp.w   $54(a5),d1
                bne.s   loc_577D6
                bsr.w   Projectile_SireneLaser
                bsr.w   Boss_SireneSpawnProjectile3
                lea     word_57CAC(pc),a1
                nop
                bra.w   Boss_SireneIdleState
; ---------------------------------------------------------------------------
loc_577D6:                                              ; CODE XREF: Boss_SireneShootPattern1+112   j
                move.w  #$14,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                lea     off_5781C(pc),a0
                nop
                tst.w   $54(a5)
                bne.s   loc_577F8
                lea     off_5782C(pc),a0
                nop
loc_577F8:                                              ; CODE XREF: Boss_SireneShootPattern1+140   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.l  (a0,d0.w),$71C(a5)
; Projectile state 12 final trajectory
Enemy_Projectile_State12:                               ; DATA XREF: ROM:0005750C   o  ; was: loc_57806
                tst.w   $58(a5)
                bpl.s   loc_57810
                bra.w   loc_5778A
; ---------------------------------------------------------------------------
loc_57810:                                              ; CODE XREF: Boss_SireneShootPattern1+15A   j
                bsr.w   Boss_SireneSpawnProjectile3
                movea.l $71C(a5),a1
                bra.w   Boss_SireneIdleState
; End of function Boss_SireneShootPattern1
; ---------------------------------------------------------------------------
off_5781C:      dc.l    word_57CD8                      ; DATA XREF: Boss_SireneShootPattern1+136   o
                dc.l    word_57CD8
                dc.l    word_57CFC
                dc.l    word_57CFC
off_5782C:      dc.l    word_57CD8                      ; DATA XREF: Boss_SireneShootPattern1+142   o
                dc.l    word_57CD8
                dc.l    word_57CEA
                dc.l    word_57CEA

; Spawns projectile type 3
Boss_SireneSpawnProjectile3:                            ; CODE XREF: Boss_SireneShootPattern1+118   p  ; was: sub_5783C
                                        ; sub_576B0:loc_57810   p
                bsr.w   Projectile_SireneBullet
                move.w  (dword_FFA410).w,d0
                move.w  (dword_FFA414).w,d1
                sub.w   (dword_FFDB30).w,d0
                sub.w   (dword_FFDB34).w,d1
                jsr     (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #5,d0
                muls.w  #$C,d1
                add.l   d0,(dword_FFA414).w
                add.l   d1,(dword_FFA410).w
                cmpi.w  #$159,(dword_FFA414).w
                bmi.s   loc_5788C
                move.w  #$158,(dword_FFA414).w
loc_5788C:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+48   j
                move.w  $70(a5),d0
                move.w  $74(a5),d1
                sub.w   (dword_FFDB30).w,d0
                sub.w   (dword_FFDB34).w,d1
                jsr     (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #4,d0
                muls.w  #$D,d1
                add.l   d0,$74(a5)
                add.l   d1,$70(a5)
                cmpi.w  #$159,$74(a5)
                bmi.s   loc_578D8
                move.w  #$158,$74(a5)
loc_578D8:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+94   j
                cmpi.w  #$7F,$74(a5)
                bpl.s   loc_578E6
                move.w  #$80,$74(a5)
loc_578E6:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+A2   j
                cmpi.w  #$5F,$70(a5)                    ; '_'
                bpl.s   loc_578F4
                move.w  #$60,$70(a5)                    ; '`'
loc_578F4:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+B0   j
                cmpi.w  #$1E1,$70(a5)
                bmi.s   loc_57902
                move.w  #$1E0,$70(a5)
loc_57902:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+BE   j
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
loc_5795A:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+114   j
                movea.w #(byte_FFE602-M68K_RAM),a0
                movea.w a0,a1
                moveq   #$B,d7
                moveq   #0,d1
                move.w  (dword_FFA900).w,d2
                subi.w  #$60,d2                         ; '`'
                neg.w   d2
loc_5796E:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+150   j
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
loc_5799A:                                              ; CODE XREF: Boss_SireneSpawnProjectile3+170   j
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
Projectile_SireneMain:                                  ; CODE XREF: Boss_SireneShootPattern1+80   p  ; was: sub_579B2
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
Projectile_SireneBullet:                                ; CODE XREF: Boss_SireneSpawnProjectile3   p  ; was: sub_579F4
                movea.w #(word_FF9500-M68K_RAM),a0
                move.l  #$D0D0D0D0,d0
                move.l  #$DDDDDDDD,d1
                btst    #0,(word_FFA000+1).w
                bne.s   loc_57A0E
                exg     d0,d1
loc_57A0E:                                              ; CODE XREF: Projectile_SireneBullet+16   j
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
                jsr     (VDP_QueueCommand_Build).l
                btst    #0,(word_FFA000+1).w
                bne.s   loc_57A58
                move.w  #$F000,(word_FF9508).w
                move.w  #$E000,(word_FF951A).w
                move.w  #$820,(word_FFE33C).w
                move.w  #$E20,(word_FFE33E).w
                rts
; ---------------------------------------------------------------------------
loc_57A58:                                              ; CODE XREF: Projectile_SireneBullet+48   j
                move.w  #$E0,(word_FF9510).w
                move.w  #$F0,(word_FF9502).w
                move.w  #$E00,(word_FFE33C).w
                move.w  #$A00,(word_FFE33E).w
                rts
; End of function Projectile_SireneBullet
; Idle state handler
Boss_SireneIdleState:                                   ; CODE XREF: Boss_SirenePlayerInputControl+24   j  ; was: sub_57A72
                                        ; Boss_SireneBattleStart+22   j
                bsr.w   Boss_SireneAttackState3
                bsr.w   Boss_SireneAttackState1
                moveq   #$1A,d7
                jmp     Sprite_InitMetaspriteSimple
; End of function Boss_SireneIdleState
; Attack state 1 handler
Boss_SireneAttackState1:                                ; CODE XREF: Boss_SireneIdleState+4   p  ; was: sub_57A82
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
                bsr.w   Boss_SireneAttackState2
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
                bsr.w   Boss_SireneAttackState2
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
loc_57AFA:                                              ; CODE XREF: Boss_SireneAttackState1+8A   j
                moveq   #$B,d6
loc_57AFC:                                              ; CODE XREF: Boss_SireneAttackState1+80   j
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
Boss_SireneAttackState2:                                ; CODE XREF: Boss_SireneAttackState1+26   p  ; was: sub_57BCA
                                        ; Boss_SireneAttackState1+4E   p
                and.w   d7,d0
                moveq   #3,d4
loc_57BCE:                                              ; CODE XREF: Boss_SireneAttackState2+16   j
                moveq   #7,d5
loc_57BD0:                                              ; CODE XREF: Boss_SireneAttackState2+C   j
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
Boss_SireneAttackState3:                                ; CODE XREF: Boss_SireneIdleState   p  ; was: sub_57BE6
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_57C60
loc_57BF0:                                              ; CODE XREF: Boss_SireneAttackState3+24   j
                                        ; Boss_SireneMovePattern1+E   j
                move.w  $58(a5),d0
                bmi.w   loc_57C70
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_57C0C
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_57BF0
; ---------------------------------------------------------------------------
loc_57C0C:                                              ; CODE XREF: Boss_SireneAttackState3+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_SireneMovePattern1
                move.w  d3,$58(a5)
                bra.w   loc_57C70
; End of function Boss_SireneAttackState3
nullsub_130:
                rts
; End of function nullsub_130

; Movement pattern 1
Boss_SireneMovePattern1:                                ; CODE XREF: Boss_SireneAttackState3+2E   j  ; was: sub_57C20
                cmpi.w  #$FFFF,d3
                bne.s   loc_57C30
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_57BF0
; ---------------------------------------------------------------------------
loc_57C30:                                              ; CODE XREF: Boss_SireneMovePattern1+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_SireneMovePattern2
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_57C70
loc_57C60:                                              ; CODE XREF: Boss_SireneAttackState3+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #9,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_57C70:                                              ; CODE XREF: Boss_SireneAttackState3+E   j
                                        ; Boss_SireneAttackState3+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_SireneMovePattern1
; Movement pattern 2
Boss_SireneMovePattern2:                                ; CODE XREF: Boss_SireneMovePattern1+24   p  ; was: sub_57C7A
                movea.l $2FC(a5),a1
                moveq   #9,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_SireneMovePattern2
; Movement pattern 3
Boss_SireneMovePattern3:                                ; CODE XREF: Boss_SirenePlayerInputControl+62   p  ; was: sub_57C8E
                moveq   #9,d7
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_SireneMovePattern3
; ---------------------------------------------------------------------------
word_57C9A:     dc.w    $810, 0, $1010, 0, $810, $A, $1010, $A
                                        ; DATA XREF: Boss_SirenePlayerInputControl+1E   o
                dc.w    $FFFF
word_57CAC:     dc.w    $820, 0, $C0C, 0, $418, $A, $4040, $A
                                        ; DATA XREF: Boss_SireneShootPattern1+3A   o
                                        ; Boss_SireneShootPattern1+66   o
                dc.w    $FFFF
word_57CBE:     dc.w    $2050, $5A, $2020, $5A, $418, $64, $4040, $64
                                        ; DATA XREF: Boss_SireneBattleStart+1C   o
                                        ; Boss_SireneBattleStart+48   o
                dc.w    $2050, $5A, $2020, $5A, $FFFE
word_57CD8:     dc.w    $820, $14, $C0C, $14, $418, $1E, $4040, $1E
                                        ; DATA XREF: ROM:off_5781C   o
                                        ; ROM:00057820   o
                dc.w    $FFFE
word_57CEA:     dc.w    $820, $28, $C0C, $28, $418, $32, $4040, $32
                                        ; DATA XREF: ROM:00057834   o
                                        ; ROM:00057838   o
                dc.w    $FFFE
word_57CFC:     dc.w    $820, $3C, $C0C, $3C, $418, $46, $4040, $46
                                        ; DATA XREF: ROM:00057824   o
                                        ; ROM:00057828   o
                dc.w    $FFFE, $820, $50, $1414, $50, $FFFE
word_57D18:     dc.w    $88D2, $40F8, $2E4E, $3024, $B201, $9C00, $A0E0, $E0
                                        ; DATA XREF: Boss_SireneIntroStop+30   o
                                        ; Boss_SirenePlayerInputControl+5C   o
                dc.w    $1FFA, $C5F8, $8800, $90D0, $20, $6060, $ACEE, $80E0
                dc.w    $4800, $6068, $3000, $B814, $88C0, $30E8, $2E40, $2820
                dc.w    $AEF4, $7800, $8410, $5874, $FED8, $C00A, $40A0, $2000
                dc.w    $80, $D040, $80EE, $A020, $C0A0, $80, $20C0, $A014
                dc.w    $9C00, $A0E0, $E0, $1FFA, $C5EE, $80E0, $6000, $2020
                dc.w    $4000, $C0F8, $A030, $E0E0, $D0A0, $4000, $C00C

; Empty entity state handler in main dispatch table
Entity_EmptyState9:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: nullsub_9
                rts
; End of function Entity_EmptyState9
; Laser projectile handler
Projectile_SireneLaser:                                 ; CODE XREF: Boss_SireneShootPattern1+114   p  ; was: sub_57D88
                move.w  (word_FFA000).w,d0
                andi.w  #$1F,d0
                bne.s   locret_57DF2
                movea.w #(byte_FFD880-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckFinalRange).l
                bne.s   locret_57DF2
                move.w  #$490,(a0)
                move.w  #$E100,2(a0)
                move.w  #$8480,$E(a0)
                move.l  #off_E975C,8(a0)
                clr.w   $C(a0)
                move.b  #4,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FC04FC04,$2C(a0)
                clr.b   $23(a0)
                move.w  #$50,$26(a0)                    ; 'P'
                move.w  $70(a5),$10(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $74(a5),d0
                move.w  d0,$14(a0)
locret_57DF2:                                           ; CODE XREF: Projectile_SireneLaser+8   j
                                        ; Projectile_SireneLaser+14   j
                rts
; End of function Projectile_SireneLaser
; Homing projectile handler
Projectile_SireneHoming:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_57DF4
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
loc_57E18:                                              ; CODE XREF: Projectile_SireneHoming+6   j
                                        ; Projectile_SireneHoming+E   j
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_57E20:                                              ; CODE XREF: Projectile_SireneHoming+22   j
                tst.w   (word_FF808C).w
                bpl.s   loc_57E66
                bclr    #7,$22(a5)
                beq.s   loc_57E7E
                bclr    #4,$22(a5)
                beq.s   loc_57E66
                move.w  (word_FFA000).w,d0
                andi.w  #$50,d0                         ; 'P'
                bne.s   loc_57E66
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_57E66
                moveq   #1,d0
                tst.w   (word_FFFF0E).w
                beq.s   loc_57E54
                move.w  #7,d0
loc_57E54:                                              ; CODE XREF: Projectile_SireneHoming+5A   j
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (loc_2BD20).l
loc_57E66:                                              ; CODE XREF: Projectile_SireneHoming+30   j
                                        ; Projectile_SireneHoming+40   j
                move.b  #$2F,d0                         ; '/'
                jsr     (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
loc_57E7E:                                              ; CODE XREF: Projectile_SireneHoming+38   j
                move.w  (dword_FFDB30).w,d0
                move.w  (dword_FFDB34).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_Arctan2Lookup).l
                asr.w   #7,d2
                addi.w  #$80,d2
                andi.w  #$1FE,d2
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d2.w),d0
                move.w  (a0,d2.w),d1
                muls.w  #4,d0
                muls.w  #$D,d1
                add.l   d0,$14(a5)
                add.l   d1,$10(a5)
                rts
; End of function Projectile_SireneHoming
; Intro stop position
