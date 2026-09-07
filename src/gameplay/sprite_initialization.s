Effect_InitRandomizedObject:
                bra.w   *+4                             ; was: sub_1B906
; ---------------------------------------------------------------------------
loc_1B90A:                                              ; CODE XREF: Effect_InitRandomizedObject   j
                bne.w   locret_1B96E
                move.l  d7,$48(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.w  #1,$18(a0)
                move.l  #$FFFFE000,$58(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #$C,d0
                move.l  dword_1B970(pc,d0.w),$1C(a0)
                move.l  #$800,$5C(a0)
                cmpi.w  #8,d0
                bmi.w   locret_1B96E
                move.l  #$FFFFF800,$5C(a0)
locret_1B96E:                                           ; CODE XREF: Effect_InitRandomizedObject:loc_1B90A   j
                                        ; Effect_InitRandomizedObject+5C   j
                rts
; End of function Effect_InitRandomizedObject
; ---------------------------------------------------------------------------
dword_1B970:    dc.l    $FFFE8000, $FFFF8000, $8000, $18000
                                        ; DATA XREF: Effect_InitRandomizedObject+4A   r

; Clears specific flags from object buffer
Sprite_ClearObjectFlags:                                ; CODE XREF: Boss_JetsripperDeathInit+A   p  ; was: sub_1B980
                                        ; Boss_ShiperInitDefeat+6   p
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                moveq   #$3C,d7                         ; '<'
                move.b  #$92,d0
loc_1B98A:                                              ; CODE XREF: Sprite_ClearObjectFlags+1A   j
                move.b  $21(a0),d1
                and.b   d0,d1
                beq.s   loc_1B996
                clr.b   $21(a0)
loc_1B996:                                              ; CODE XREF: Sprite_ClearObjectFlags+10   j
                lea     $60(a0),a0
                dbf     d7,loc_1B98A
                rts
; End of function Sprite_ClearObjectFlags
; Initializes sprite from pointer table with offsets
Sprite_InitFromPointerTable:                            ; CODE XREF: Sprite_InitFromPointerTable+42   j  ; was: sub_1B9A0
                                        ; Boss_ShiperSetupState+136   p
                move.w  (a1)+,d0
                cmpi.w  #$FFFE,d0
                bne.s   loc_1B9AA
                rts
; ---------------------------------------------------------------------------
loc_1B9AA:                                              ; CODE XREF: Sprite_InitFromPointerTable+6   j
                movea.w d0,a0
                move.b  (a1)+,$21(a0)
                clr.b   $23(a0)
                move.b  (a1)+,d0
                bclr    #0,d0
                beq.s   Sprite_SetFlipFlag
                move.b  #$10,$23(a0)
; Sets horizontal flip flag in sprite properties byte
Sprite_SetFlipFlag:                                     ; CODE XREF: Sprite_InitFromPointerTable+1A   j  ; was: loc_1B9C2
                lsr.b   #1,d0
                move.b  d0,$25(a0)
                clr.b   $24(a0)
                move.l  (a1)+,$28(a0)
                move.l  (a1)+,$2C(a0)
                moveq   #0,d0
                move.b  (a1)+,d0
                asl.w   #1,d0
                move.w  d0,$26(a0)
                move.b  (a1)+,$23(a0)
                bra.s   Sprite_InitFromPointerTable
; End of function Sprite_InitFromPointerTable
; ---------------------------------------------------------------------------
word_1B9E4:     dc.w    $C620, $1050, $F010, $F010, 0, 0, $80
                                        ; DATA XREF: Boss_AntroidInitPhase+60   o
                dc.w    $C680, $5028, $F010, $F010, $F808, $F808, $2A00
                dc.w    $C6E0, $103C, $F808, $F808, 0, 0, 4
                dc.w    $C9E0, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w    $CA40, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w    $CDA0, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w    $CE60, $5008, $F808, $F808, $FC04, $FC04, $2A04
                dc.w    $FFFE
word_1BA48:     dc.w    $C620, $5014, $E61A, $E61A, $E818, $E818, $5B0D
                                        ; DATA XREF: Boss_ShellshogunSetupPhase+128   o
                dc.w    $C680, $1038, $F00C, $F40C, 0, 0, $80
                dc.w    $C920, $5020, $F808, $F808, $F808, $F808, $5005
                dc.w    $C9E0, $1020, $F808, $F808, 0, 0, 5
                dc.w    $CD40, $5020, $F808, $F808, $F808, $F808, $5005
                dc.w    $CE00, $1020, $F808, $F808, 0, 0, 5
                dc.w    $FFFE
word_1BA9E:     dc.w    $C620, $5008, $C808, $E214, $C808, $E214, $3C00
                                        ; DATA XREF: Boss_ShiperSetupState+130   o
                dc.w    $C680, $5008, $C000, $D81C, $C000, $D81C, $3C00
                dc.w    $CB60, $5020, $F40C, $F40C, $FA06, $FA06, $7F05
                dc.w    $CAA0, $5020, $F40C, $F40C, $F808, $F808, $7F05
                dc.w    $C9E0, $1020, $F40C, $F40C, $F60A, $F60A, $7F05
                dc.w    $CBC0, $1030, $F010, $F808, 0, 0, $80
                dc.w    $FFFE
word_1BAF4:     dc.w    $C620, $5024, $E820, $E020, $EC18, $EC18, $A080
                                        ; DATA XREF: Boss_MadamBarbarSetup+AA   o
                dc.w    $C6E0, $1010, $F20E, $F20E, 0, 0, 5
                dc.w    $C7A0, $5010, $F20E, $F20E, $F40C, $F40C, $4305
                dc.w    $C920, $1010, $F20E, $F20E, 0, 0, 5
                dc.w    $C9E0, $5010, $F20E, $F20E, $F40C, $F40C, $4305
                dc.w    $FFFE
word_1BB3C:     dc.w    $C620, $5038, $E830, $E020, $E830, $E020, $6E80
                                        ; DATA XREF: Boss_JokerSetup+70   o
                dc.w    $FFFE
word_1BB4C:     dc.w    $C620, $5040, $D40C, $B80C, $D40C, $B80C, $3C88
                                        ; DATA XREF: Boss_TerobusterSetup+A4   o
                dc.w    $C6E0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w    $C7A0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w    $C8C0, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w    $C980, $5008, $F010, $F010, $F808, $F808, $3C00
                dc.w    $FFFE
word_1BB94:     dc.w    $C620, $5038, 0, 0, 0, 0, $4204
                                        ; DATA XREF: Boss_FlyingNeoSetup+C4   o
                dc.w    $C9E0, $5050, $F808, $F20E, $F808, $F20E, $4280
                dc.w    $C800, $5008, $F812, $F808, $F812, $F808, $4204
                dc.w    $C980, $5008, $F812, $F808, $F812, $F808, $4204
                dc.w    $FFFE
word_1BBCE:     dc.w    $C620, $5030, $E826, $E020, $E826, $E020, $6C80
                                        ; DATA XREF: Boss_XiTigerSetup+5C   o
                dc.w    $C6E0, $1018, $F010, $F010, 0, 0, 5
                dc.w    $C7A0, $1018, $F010, $F010, 0, 0, 5
                dc.w    $C860, $5000, $EE12, $EE12, $F010, $F010, $B810
                dc.w    $C8C0, $1018, $F010, $F010, 0, 0, 5
                dc.w    $C980, $1018, $F010, $F010, 0, 0, 5
                dc.w    $CA40, $5000, $EE12, $EE12, $F010, $F010, $B810
                dc.w    $CB60, $5018, $F010, $F010, $F40C, $F40C, $6C04
                dc.w    $CC20, $1018, $F40C, $F40C, 0, 0, 4
                dc.w    $CDA0, $5018, $F010, $F010, $F40C, $F40C, $6C04
                dc.w    $CE60, $1018, $F40C, $F40C, 0, 0, 4
                dc.w    $FFFE
word_1BC6A:     dc.w    $C740, $103C, $F010, $F010, $FD0C, $F40C, 0
                                        ; DATA XREF: Boss_DeepStriderIntroRise+36   o
                dc.w    $C680, $103C, $F010, $F010, 0, 0, $80
                dc.w    $C7A0, $103C, $F40C, $F40C, 0, 0, 0
                dc.w    $C860, $1008, $F808, $F808, 0, 0, 0
                dc.w    $C8C0, $1008, $FC04, $FC04, 0, 0, 0
                dc.w    $FFFE
word_1BCB2:     dc.w    $C620, $1014, $F010, $F010, $F010, $F010, $4700
                                        ; DATA XREF: Boss_SharpssteelInit+4A   o
                dc.w    $C680, $1014, $E41C, $E41C, $F010, $F010, $4700
                dc.w    $C6E0, $1028, $EC14, $EC14, $F010, $F010, $4780
                dc.w    $C740, $1014, $F010, $F010, $F010, $F010, $4700
                dc.w    $C7A0, $1014, $F010, $F010, $F010, $F010, 0
                dc.w    $C800, $1014, $F010, $F010, $F010, $F010, 0
                dc.w    $C920, 0, $F010, $F010, $F808, $F808, 0
                dc.w    $C980, 0, $F010, $F010, $F010, $F010, 0
                dc.w    $CAA0, 0, $F010, $F010, $FA06, $FA06, 0
                dc.w    $CB00, 0, $F010, $F010, $FA06, $FA06, 0
                dc.w    $CB60, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w    $CBC0, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w    $CC20, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w    $CC80, 0, $F010, $F010, $F20E, $F20E, 0
                dc.w    $FFFE
word_1BD78:     dc.w    $C620, $502C, $E41C, $E41C, $E41C, $E41C, $3280
                                        ; DATA XREF: Boss_SunsetStingLoadGraphics+C   o
                dc.w    $C860, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w    $CA40, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w    $CC20, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w    $D400, $1004, $F010, $F010, $F808, $F808, $3200
                dc.w    $FFFE
word_1BDC0:     dc.w    $C6E0, $1020, $F010, $F010, $F808, $F808, $2204
                                        ; DATA XREF: Boss_BackStringerSpawn+68   o
                dc.w    $C740, $1020, $F010, $F010, $F808, $F808, $2204
                dc.w    $C7A0, $1038, $EC14, $EC14, $F808, $F808, $2280
                dc.w    $FFFE
word_1BDEC:     dc.w    $C620, $5004, $E004, $E040, $E0F8, $E030, $4309
                                        ; DATA XREF: Boss_WolfGaropaMovement3+106   o
                dc.w    $C8C0, 4, $F010, $F010, $FC04, $FC04, 9
                dc.w    $CC80, 4, $F010, $F010, $FC04, $FC04, 9
                dc.w    $C800, 4, $F010, $F010, 0, 0, 9
                dc.w    $CBC0, 4, $F010, $F010, 0, 0, 9
                dc.w    $D0A0, $1008, $F010, $F010, 0, 0, 9
                dc.w    $D100, $5028, $F20E, $E818, $FC04, $F80E, $4309
                dc.w    $CF80, 8, $F010, $FF24, $F010, $FC04, $2A04
                dc.w    $CFE0, $1038, $FC2C, $F010, 0, 0, $84
                dc.w    $FFFE
word_1BE6C:     dc.w    $C620, $501C, $D010, $F010, $D808, $F808, $6909
                                        ; DATA XREF: Boss_ValkirieInit+F6   o
                dc.w    $CB60, $5004, $F010, $F010, $FC04, $FC04, $7D09
                dc.w    $CCE0, $5004, $F010, $F010, $FC04, $FC04, $7D09
                dc.w    $CC20, $5004, $E41C, $F010, $F808, $FE02, $7D09
                dc.w    $CDA0, $5004, $E41C, $F010, $F808, $FE02, $7D09
                dc.w    $FFFE
word_1BEB4:     dc.w    $C620, $1018, $CC02, $EC14, 0, 0, $8F
                                        ; DATA XREF: Boss_ZLeoIntroInit+192   o
                dc.w    $FFFE
word_1BEC4:     dc.w    $C620, $5038, $F010, $F010, $EC14, $EC14, $6488
                                        ; DATA XREF: Boss_ValkirieIntroStop+46   o
                dc.w    $C6E0, $500C, $F010, $F010, $F010, $F010, $6408
                dc.w    $C7A0, $5000, $F60A, $F60A, $F010, $F010, $6410
                dc.w    $C980, $5000, $F60A, $F60A, $F010, $F010, $6410
word_1BEFC:     dc.w    $CBC0, $5004, $F010, $F010, $FA06, $FA06, $640C
                                        ; DATA XREF: Boss_ValkirieSpawnEffect   o
                dc.w    $CE00, $5004, $F010, $F010, $FA06, $FA06, $640C
                dc.w    $FFFE
word_1BF1A:     dc.w    $C620, $5018, $E020, $E020, $E818, $E41C, $8088
                                        ; DATA XREF: Boss_MedusaMovePattern2+4A   o
                dc.w    $FFFE
word_1BF2A:     dc.w    $C620, $5040, $EC14, $EC14, $EC14, $EC14, $3888
                                        ; DATA XREF: Boss_SireneShootPattern1+B4   o
                dc.w    $C920, $5000, $F010, $F010, $F010, $F010, $3810
                dc.w    $CCE0, $5000, $F010, $F010, $F010, $F010, $3810
                dc.w    $FFFE
byte_1BF56:     dc.b    $D1, 0, $10, $40, $F8, 8, $F8
                                        ; DATA XREF: Boss_ArtemisAttackState1+BA   o
                dc.b    8, 0, 0, 0, 0, 0, $88
word_1BF64:     dc.w    $C680, $5004, $F010, $F010, $EC14, $EC14, $2908
                                        ; DATA XREF: Projectile_ArtemisInitSprite1   o
                dc.w    $C6E0, $5004, $F010, $F010, $EC14, $EC14, $2908
                dc.w    $C7A0, $501C, $F808, $F808, $FA06, $FA06, $2905
                dc.w    $FFFE
word_1BF90:     dc.w    $C620, $5044, $EC14, $EC14, $EC14, $EC14, $5B08
                                        ; DATA XREF: Boss_Unknown1InitMetasprite+46   o
                dc.w    $FFFE
word_1BFA0:     dc.w    $C620, $5044, $EC14, $EC14, $EC14, $EC14, $5B08
                                        ; DATA XREF: Boss_ValkirieInitAlt+46   o
                dc.w    $FFFE
word_1BFB0:     dc.w    $C620, $5040, $EC14, $EC14, $EC14, $EC14, $5B88
                                        ; DATA XREF: Boss_SylpheedAnimationScript+68   o
                dc.w    $CB60, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w    $CC20, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w    $CCE0, $5000, $E41C, $E41C, $FC04, $FC04, $3710
                dc.w    $CE60, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w    $CF20, $5000, $EC14, $EC14, $FC04, $FC04, $3710
                dc.w    $CFE0, $5000, $E41C, $E41C, $FC04, $FC04, $3710
                dc.w    $FFFE

; Finds free enemy object slot with wraparound search
Sprite_FindFreeEnemySlot:                               ; CODE XREF: Enemy_DestroyOnContact+14   p  ; was: sub_1C014
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$F,d7
loc_1C01A:                                              ; CODE XREF: Sprite_FindFreeEnemySlot+E   j
                move.w  (a0),d0
                beq.s   locret_1C026
                lea     $60(a0),a0
                dbf     d7,loc_1C01A
locret_1C026:                                           ; CODE XREF: Sprite_FindFreeEnemySlot+8   j
                rts
; End of function Sprite_FindFreeEnemySlot
; Searches for free sprite slot in effect pool for explosions
Sprite_FindFreeEffectSlot:                              ; CODE XREF: Enemy_SpawnFallingHazard+2E   p  ; was: sub_1C028
                movea.w #(word_FFDB20-M68K_RAM),a0
                moveq   #3,d7
loc_1C02E:                                              ; CODE XREF: Sprite_FindFreeEffectSlot+E   j
                move.w  (a0),d0
                beq.s   locret_1C03A
                lea     $60(a0),a0
                dbf     d7,loc_1C02E
locret_1C03A:                                           ; CODE XREF: Sprite_FindFreeEffectSlot+8   j
                rts
; End of function Sprite_FindFreeEffectSlot
; Allocates free sprite slot with buffer search
Sprite_AllocateSlot:                                    ; CODE XREF: Effect_SpawnParticle+16   p  ; was: sub_1C03C
                                        ; sub_175B8:loc_175EE   p
                movea.w #(byte_FFC320-M68K_RAM),a0
                moveq   #6,d7
; End of function Sprite_AllocateSlot
; Finds free slot in object array
Sys_FindFreeObjectSlot:                                 ; CODE XREF: Effect_FindDashTrailSlot+6   j  ; was: sub_1C042
                                        ; Sprite_InitProjectile+36   p
                move.w  (a0),d0
                beq.s   locret_1C04E
                lea     $60(a0),a0
                dbf     d7,Sys_FindFreeObjectSlot
locret_1C04E:                                           ; CODE XREF: Sys_FindFreeObjectSlot+2   j
                rts
; End of function Sys_FindFreeObjectSlot
; Updates projectile trajectory and rotation
