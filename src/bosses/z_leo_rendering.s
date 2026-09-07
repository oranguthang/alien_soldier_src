Boss_ZLeoPaletteRotate:                                 ; CODE XREF: Boss_ZLeoAttackSequence:loc_524F6   p  ; was: sub_52512
                                        ; Boss_ZLeoRisingAttack+60   p
                move.w  (word_FFA000).w,d0
                asl.w   #3,d0
                andi.w  #$18,d0
                move.w  word_52530(pc,d0.w),(word_FFE364).w
                move.w  word_52530+2(pc,d0.w),(word_FFE37C).w
                move.w  word_52530+4(pc,d0.w),(word_FFE37E).w
                rts
; End of function Boss_ZLeoPaletteRotate
; ---------------------------------------------------------------------------
word_52530:     dc.w    $2A2, $EEE, $6C6, 0, $AEC, $40, $4E8, 0, $EEC, $62, $6EC, 0, $EEE, $AEA, $EEC, 0
                                        ; DATA XREF: Boss_ZLeoPaletteRotate+A   r
                                        ; Boss_ZLeoPaletteRotate+10   r

; Z-Leo rising attack phase - moves boss upward while tracking player position and spawning projectiles
Boss_ZLeoRisingAttack:                                  ; CODE XREF: Boss_ZLeoAttackSequence+18C   j  ; was: sub_52550
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.l  #$2400000,d0
                move.l  d0,$35C(a5)
                addi.w  #$F0,$35C(a5)
                move.w  #$E000,$59E(a5)
                clr.w   $11C(a5)
                move.w  #$200,$5B4(a5)
; Z-Leo boss final attack 5
Boss_ZLeoAttack_State48:                                ; DATA XREF: ROM:00051BB6   o  ; was: loc_5257E
                move.l  $41C(a5),d0
                add.l   d0,$35C(a5)
                bsr.w   Boss_ZLeoScrollUpdate
                tst.w   $11C(a5)
                beq.w   loc_525A4
loc_52592:                                              ; CODE XREF: Boss_ZLeoRisingAttack+88   j
                cmpi.w  #$F0,$35C(a5)
                bmi.s   loc_525E4
                lea     word_52D5E(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_525A4:                                              ; CODE XREF: Boss_ZLeoRisingAttack+3E   j
                move.w  #$FFF6,$59C(a5)
                tst.w   (word_FF9500).w
                beq.s   loc_525B4
                bsr.w   Boss_ZLeoPaletteRotate
loc_525B4:                                              ; CODE XREF: Boss_ZLeoRisingAttack+5E   j
                move.w  $5B4(a5),d0
                addq.w  #4,d0
                cmp.w   (dword_FFDB34).w,d0
                bpl.s   loc_525DA
                move.b  #$F0,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #1,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                bra.s   loc_52592
; ---------------------------------------------------------------------------
loc_525DA:                                              ; CODE XREF: Boss_ZLeoRisingAttack+6E   j
                lea     word_52D58(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_525E4:                                              ; CODE XREF: Boss_ZLeoRisingAttack+48   j
                addq.w  #2,4(a5)
                move.l  #$100000,(dword_FFA90C).w
                move.l  #$F00000,$35C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                bclr    #1,(byte_FF80EC).w
                move.b  #$10,$21(a5)
; Z-Leo boss ultimate finale
Boss_ZLeoAttack_State50:                                ; DATA XREF: ROM:00051BB8   o  ; was: loc_5260A
                subq.w  #1,$11C(a5)
                bpl.s   loc_5261A
                move.w  #$80,$11C(a5)
                bra.w   Boss_ZLeoAttackPattern1
; ---------------------------------------------------------------------------
loc_5261A:                                              ; CODE XREF: Boss_ZLeoRisingAttack+BE   j
                lea     word_52D5E(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_52624:                                              ; CODE XREF: Boss_ZLeoBattleState2+C   j
                                        ; Boss_ZLeoBattleState2+30   j
                move.w  $5B4(a5),d0
                addq.w  #4,d0
                move.w  d0,(dword_FFDB34).w
loc_5262E:                                              ; CODE XREF: Boss_ZLeoIntroSetup+54   j
                                        ; Boss_ZLeoIntroMove+24   j
                bsr.w   Boss_ZLeoUpdateSegments
                moveq   #$F,d7
                jsr     (Sprite_InitMetaspriteSimple).l
                move.w  #$120,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA900).w
                move.w  $14(a5),d0
                addi.w  #-$104,d0
                sub.w   (word_FFA012).w,d0
                move.w  d0,(dword_FFA904).w
                bsr.w   Boss_ZLeoUpdateBladeSprite
                bsr.w   Boss_ZLeoUpdateWingSprites
                bsr.w   Boss_ZLeoSpriteUpdate
                bsr.w   Boss_ZLeoTileUpdate
                bsr.w   Boss_ZLeoGraphicsInit2
                btst    #1,(word_FFA000+1).w
                bne.s   loc_5267A
                move.w  #$8C,(word_FFE37E).w
                rts
; ---------------------------------------------------------------------------
loc_5267A:                                              ; CODE XREF: Boss_ZLeoRisingAttack+120   j
                move.w  #$2EE,(word_FFE37E).w
                rts
; End of function Boss_ZLeoRisingAttack
; Tile update handler
Boss_ZLeoTileUpdate:                                    ; CODE XREF: Boss_ZLeoAttackSequence+F2   p  ; was: sub_52682
                                        ; Boss_ZLeoRisingAttack+112   p
                movea.w #(byte_FF9604-M68K_RAM),a3
                lea     word_5271E(pc),a4
                nop
                move.w  (word_FF9600).w,d7
                move.w  (dword_FFA904).w,d0
                addi.w  #$20,d0                         ; ' '
                bmi.w   nullsub_120
                move.w  (word_FF9602).w,d1
                move.w  d0,(word_FF9602).w
                cmp.w   d1,d0
                beq.w   nullsub_120
                lea     word_5270E(pc),a0
                nop
                bpl.s   loc_526E2
                cmp.w   2(a0,d7.w),d0
                bpl.w   nullsub_120
                addq.w  #2,(word_FF9600).w
                move.w  (a4,d7.w),(a3)+
                move.w  #$2000,(a3)+
                move.b  #5,(a3)+
                move.b  #0,(a3)+
                lea     off_5272A(pc),a1
                nop
                asl.w   #1,d7
                movea.l (a1,d7.w),a1
                move.l  (a1)+,(a3)+
                move.w  (a1)+,(a3)+
                bra.w   loc_52704
; ---------------------------------------------------------------------------
loc_526E2:                                              ; CODE XREF: Boss_ZLeoTileUpdate+2E   j
                cmp.w   (a0,d7.w),d0
                bmi.w   nullsub_120
                subq.w  #2,(word_FF9600).w
                move.w  -2(a4,d7.w),(a3)+
                move.w  #$2000,(a3)+
                move.b  #5,(a3)+
                move.b  #0,(a3)+
                moveq   #0,d0
                move.l  d0,(a3)+
                move.w  d0,(a3)+
loc_52704:                                              ; CODE XREF: Boss_ZLeoTileUpdate+5C   j
                movea.w #(byte_FF9604-M68K_RAM),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_ZLeoTileUpdate
; ---------------------------------------------------------------------------
word_5270E:     dc.w    $7FFF, $C0, $A0, $80, $60, $40, $20, 0
                                        ; DATA XREF: Boss_ZLeoTileUpdate+28   o
word_5271E:     dc.w    $4410, $4610, $4810, $4A10, $4C10, $4E10
                                        ; DATA XREF: Boss_ZLeoTileUpdate+4   o
off_5272A:      dc.l    byte_52742                      ; DATA XREF: Boss_ZLeoTileUpdate+4C   o
                dc.l    byte_52748
                dc.l    byte_5274E
                dc.l    byte_52754
                dc.l    byte_5275A
                dc.l    byte_52760
byte_52742:     dc.b    0, 0, 1, 2, 0, 0                ; DATA XREF: ROM:off_5272A   o
byte_52748:     dc.b    3, 4, 5, 6, 7, 8                ; DATA XREF: ROM:0005272E   o
byte_5274E:     dc.b    9, $A, $B, $C, $D, $E
                                        ; DATA XREF: ROM:00052732   o
byte_52754:     dc.b    0, $F, $10, $11, $12, 0
                                        ; DATA XREF: ROM:00052736   o
byte_5275A:     dc.b    0, $13, $14, $15, $16, 0
                                        ; DATA XREF: ROM:0005273A   o
byte_52760:     dc.b    $17, $18, $19, $1A, $1B, $1C
                                        ; DATA XREF: ROM:0005273E   o

; Enable boss parts flags
Boss_ZLeoEnableParts:                                   ; CODE XREF: Boss_ZLeoBattleState1+E   p  ; was: sub_52766
                moveq   #7,d0
                bset    d0,$7EE(a5)
                bset    d0,$90E(a5)
                bset    d0,$A2E(a5)
                bset    d0,$84E(a5)
                bset    d0,$96E(a5)
                bset    d0,$A8E(a5)
                rts
; End of function Boss_ZLeoEnableParts
; Disables all 6 Z-Leo body part sprites by clearing bit 7 in their control bytes
Boss_ZLeoDisableParts:
                moveq   #7,d0                           ; was: sub_52782
                bclr    d0,$7EE(a5)
                bclr    d0,$90E(a5)
                bclr    d0,$A2E(a5)
                bclr    d0,$84E(a5)
                bclr    d0,$96E(a5)
                bclr    d0,$A8E(a5)
                rts
; End of function Boss_ZLeoDisableParts
; Graphics init handler 1
Boss_ZLeoGraphicsInit1:                                 ; CODE XREF: Boss_ZLeoInit+4C   p  ; was: sub_5279E
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$40C,(a0)
                move.w  #$400,2(a0)
                clr.w   $56(a0)
                move.b  #$20,$21(a0)                    ; ' '
                move.w  #6,$46(a0)
                move.l  #$FF000100,$28(a0)
                move.w  #$150,d6
                move.w  #$120,d7
                move.w  d6,$10(a0)
                move.w  d7,$14(a0)
                move.w  d6,$48(a0)
                move.w  d7,$4C(a0)
                rts
; End of function Boss_ZLeoGraphicsInit1
; Load defeat tiles
Boss_ZLeoLoadDefeatTiles:                               ; CODE XREF: Boss_ZLeoBattleState1+30   p  ; was: sub_527DE
                                        ; Boss_ZLeoAttackPattern1+70   p
                lea     word_527EA(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_ZLeoLoadDefeatTiles
; ---------------------------------------------------------------------------
word_527EA:     dc.w    $4820, $2000, $100, $B0C
                                        ; DATA XREF: Boss_ZLeoLoadDefeatTiles   o

; Animation update handler 1
Boss_ZLeoAnimationUpdate1:                              ; CODE XREF: Boss_ZLeoBattleStart+A8   p  ; was: sub_527F2
                                        ; Boss_ZLeoAttackPattern2+46   p
                lea     word_527FE(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_ZLeoAnimationUpdate1
; ---------------------------------------------------------------------------
word_527FE:     dc.w    $4820, $2000, $100, $1F20
                                        ; DATA XREF: Boss_ZLeoAnimationUpdate1   o

; Graphics init handler 2
Boss_ZLeoGraphicsInit2:                                 ; CODE XREF: Boss_ZLeoInit+50   p  ; was: sub_52806
                                        ; sub_51C32   p
                movea.w #(word_FF9E00-M68K_RAM),a0
                move.w  (dword_FFA904).w,d7
                neg.w   d7
                move.w  (dword_FFDB34).w,d0
                subi.w  #$8B,d0
                beq.s   loc_52822
                bmi.s   loc_52822
                cmpi.w  #$DE,d0
                bmi.s   loc_52826
loc_52822:                                              ; CODE XREF: Boss_ZLeoGraphicsInit2+12   j
                                        ; Boss_ZLeoGraphicsInit2+14   j
                move.w  #$FF,d0
loc_52826:                                              ; CODE XREF: Boss_ZLeoGraphicsInit2+1A   j
                ori.w   #$8A00,d0
                move.w  d0,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                move.w  #$8A1F,d2
                cmpi.w  #$148,(dword_FFDB34).w
                bmi.s   loc_52846
                move.w  #$8AFF,d2
loc_52846:                                              ; CODE XREF: Boss_ZLeoGraphicsInit2+3A   j
                move.w  d2,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                move.w  #$8AFF,(a0)+
                move.w  (dword_FFDB34).w,d1
                addi.w  #$98,d1
                neg.w   d1
                move.w  d1,(a0)+
                move.w  #$8B02,(a0)+
                move.w  #$8210,(a0)+
                move.w  #$8AFF,(a0)+
                move.w  d7,(a0)+
                move.w  #$8B00,(a0)+
                move.w  #$8230,(a0)+
                rts
; End of function Boss_ZLeoGraphicsInit2
; Graphics init handler 3
Boss_ZLeoGraphicsInit3:                                 ; CODE XREF: Boss_ZLeoInit+54   p  ; was: sub_5287A
                movea.l #word_52892,a0
                jsr     (Gfx_LoadCompressedTiles).l
                move.w  #$81,d0
                moveq   #3,d7
                jmp     Gfx_SetSpritePattern
; End of function Boss_ZLeoGraphicsInit3
; ---------------------------------------------------------------------------
word_52892:     dc.w    $4E00, $4000, $900, $2A2B, $2A2B, $2A2B, $2A2B, $2A2B, $4E00, $4000, $900, $2D2E, $2D2E, $2D2E, $2D2E, $2D2E
                                        ; DATA XREF: Boss_ZLeoGraphicsInit3   o

; Update blade sprite
Boss_ZLeoUpdateBladeSprite:                             ; CODE XREF: Boss_ZLeoRisingAttack+106   p  ; was: sub_528B2
                lea     off_528C8(pc),a1
                nop
                movea.w #(word_FFC860-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jmp     Sprite_UpdateBossBladeSprite
; End of function Boss_ZLeoUpdateBladeSprite
; ---------------------------------------------------------------------------
off_528C8:      dc.l    word_ED3F4                      ; DATA XREF: Boss_ZLeoUpdateBladeSprite   o
                dc.l    word_ED40C
                dc.l    word_ED424
                dc.l    word_ED43C

; Update wing sprites
Boss_ZLeoUpdateWingSprites:                             ; CODE XREF: Boss_ZLeoRisingAttack+10A   p  ; was: sub_528D8
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  $34(a0),d2
                ext.w   d2
                movea.w #(word_FFCDA0-M68K_RAM),a0
                moveq   #$FFFFFFFE,d0
                moveq   #$FFFFFFF6,d1
                bsr.s   Boss_ZLeoUpdateWingPositions
                movea.w #(word_FFCEC0-M68K_RAM),a0
                moveq   #0,d0
                moveq   #0,d1
                bsr.s   Boss_ZLeoUpdateWingPositions
                movea.w #(byte_FFCFE0-M68K_RAM),a0
                moveq   #2,d0
                moveq   #$A,d1
; End of function Boss_ZLeoUpdateWingSprites
; Calculate wing positions
Boss_ZLeoUpdateWingPositions:                           ; CODE XREF: Boss_ZLeoUpdateWingSprites+12   p  ; was: sub_528FE
                                        ; Boss_ZLeoUpdateWingSprites+1C   p
                add.w   $5B0(a5),d1
                move.w  d1,$10(a0)
                add.w   d0,d1
                move.w  d1,$70(a0)
                add.w   d0,d1
                move.w  d1,$D0(a0)
                moveq   #$FFFFFFF4,d0
                move.w  $5B4(a5),d4
                move.w  d2,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$D4(a0)
                move.w  d2,d3
                asr.w   #1,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$74(a0)
                move.w  d2,d3
                asr.w   #2,d3
                add.w   d4,d3
                add.w   d0,d3
                move.w  d3,$14(a0)
                rts
; End of function Boss_ZLeoUpdateWingPositions
; Sprite update handler
Boss_ZLeoSpriteUpdate:                                  ; CODE XREF: Boss_ZLeoRisingAttack+10E   p  ; was: sub_5293C
                movea.w #(byte_FFD100-M68K_RAM),a0
                move.w  #$FFDE,d0
                bsr.s   Boss_ZLeoUpdateHeadPosition
                movea.w #(byte_FFD220-M68K_RAM),a0
                move.w  #$22,d0                         ; '"'
; End of function Boss_ZLeoSpriteUpdate
; Update head sprite positions
Boss_ZLeoUpdateHeadPosition:                            ; CODE XREF: Boss_ZLeoSpriteUpdate+8   p  ; was: sub_5294E
                move.w  #$FFD7,d1
                move.w  $48(a0),d2
                beq.s   loc_5295E
                subq.w  #1,d2
                move.w  d2,$48(a0)
loc_5295E:                                              ; CODE XREF: Boss_ZLeoUpdateHeadPosition+8   j
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.w  d0,$70(a0)
                move.w  d0,$D0(a0)
                add.w   $14(a5),d1
                add.w   d2,d1
                move.w  d1,$14(a0)
                asr.w   #1,d2
                addi.w  #-$20,d1
                add.w   d2,d1
                move.w  d1,$74(a0)
                addi.w  #-$1C,d1
                add.w   d2,d1
                move.w  d1,$D4(a0)
                rts
; End of function Boss_ZLeoUpdateHeadPosition
; Applies palette fade effect to Z-Leo colors - fades palettes at $FFE302 and $FFE342 towards black ($E000)
Boss_ZLeoFadeoutPalette:                                ; CODE XREF: Boss_ZLeoAttackPattern2:loc_520DE   p  ; was: sub_52990
                                        ; sub_52138:loc_5214E   p
                move.w  #6,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.w  $11C(a5),d0
                asl.w   #1,d0
                cmpi.w  #$E,d0
                bmi.s   loc_529AA
                moveq   #$E,d0
loc_529AA:                                              ; CODE XREF: Boss_ZLeoFadeoutPalette+16   j
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$F,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $11C(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1E,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_ZLeoFadeoutPalette
; Animation update handler 2
Boss_ZLeoAnimationUpdate2:                              ; CODE XREF: Boss_ZLeoAttackPattern2+68   p  ; was: sub_529CE
                                        ; Boss_ZLeoAttackPattern2+9C   p
                jsr     (Effect_PlayRandomExplosionSound).l
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_52A52
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                bne.s   loc_529F0
                jsr     (Effect_InitDebrisSprite).l
                bra.w   loc_52A24
; ---------------------------------------------------------------------------
loc_529F0:                                              ; CODE XREF: Boss_ZLeoAnimationUpdate2+16   j
                jsr     (Sprite_InitializeProperties).l
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_52A24
                move.l  #off_E9560,8(a0)
                clr.w   $1C(a0)
loc_52A24:                                              ; CODE XREF: Boss_ZLeoAnimationUpdate2+1E   j
                                        ; Boss_ZLeoAnimationUpdate2+48   j
                move.b  #0,$20(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$7F,d0
                andi.w  #$7F,d1
                subi.w  #$40,d0                         ; '@'
                subi.w  #$20,d1                         ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_52A52:                                           ; CODE XREF: Boss_ZLeoAnimationUpdate2+C   j
                rts
; End of function Boss_ZLeoAnimationUpdate2
; Animation update handler 3
Boss_ZLeoAnimationUpdate3:                              ; CODE XREF: Boss_ZLeoAttackPattern2+6C   p  ; was: sub_52A54
                tst.w   (word_FFF74A).w
                beq.s   locret_52A7E
                cmpi.w  #$200,(dword_FFDB34).w
                bmi.s   loc_52A76
                clr.l   $1C(a5)
                move.w  #$200,(dword_FFDB34).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                rts
; ---------------------------------------------------------------------------
loc_52A76:                                              ; CODE XREF: Boss_ZLeoAnimationUpdate3+C   j
                addi.l  #$800,(dword_FFDB3C).w
locret_52A7E:                                           ; CODE XREF: Boss_ZLeoAnimationUpdate3+4   j
                rts
; End of function Boss_ZLeoAnimationUpdate3
; Update boss segments
Boss_ZLeoUpdateSegments:                                ; CODE XREF: Boss_ZLeoRisingAttack:loc_5262E   p  ; was: sub_52A80
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_52AF8
loc_52A8A:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+24   j
                                        ; Boss_ZLeoUpdateSegments+44   j
                move.w  $58(a5),d0
                bmi.w   loc_52B08
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_52AA6
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_52A8A
; ---------------------------------------------------------------------------
loc_52AA6:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_52AB6
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_52AB6:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_52AC6
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_52A8A
; ---------------------------------------------------------------------------
loc_52AC6:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_52D68,d0
                movea.l d0,a0
                bsr.w   Boss_ZLeoAnimationCalc
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_52B08
loc_52AF8:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$D,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_52B08:                                              ; CODE XREF: Boss_ZLeoUpdateSegments+E   j
                                        ; Boss_ZLeoUpdateSegments+76   j
                moveq   #7,d6
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$116(a5)
                moveq   #0,d2
                move.w  8(a0),d2
                swap    d2
                asr.l   d6,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$176(a5)
                swap    d2
                moveq   #0,d1
                move.w  $C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$1D6(a5)
                swap    d1
                moveq   #0,d2
                move.w  $10(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$236(a5)
                swap    d2
                moveq   #0,d1
                move.w  $14(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$296(a5)
                moveq   #0,d2
                move.w  $18(a0),d2
                swap    d2
                asr.l   d6,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$2F6(a5)
                move.w  d2,$356(a5)
                swap    d2
                moveq   #0,d1
                move.w  $1C(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$3B6(a5)
                move.w  d1,$416(a5)
                swap    d1
                moveq   #0,d2
                move.w  $20(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$476(a5)
                move.w  d2,$4D6(a5)
                swap    d2
                moveq   #0,d1
                move.w  $24(a0),d1
                swap    d1
                asr.l   d6,d1
                add.l   d2,d1
                swap    d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.w  d1,$596(a5)
                swap    d1
                moveq   #0,d2
                move.w  $28(a0),d2
                swap    d2
                asr.l   d6,d2
                add.l   d1,d2
                swap    d2
                and.w   d7,d2
                move.w  d2,$5F6(a5)
                move.b  $2C(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $2FC(a5),d0
                move.w  d0,$10(a5)
                asr.w   #2,d1
                addi.w  #$20,d1                         ; ' '
                move.w  d1,(dword_FFA908).w
                move.b  $30(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $35C(a5),d0
                move.w  d0,$14(a5)
                tst.b   $47C(a5)
                bne.s   locret_52C32
                asr.w   #2,d1
                move.w  #$20,d0                         ; ' '
                sub.w   d1,d0
                move.w  d0,(dword_FFA90C).w
locret_52C32:                                           ; CODE XREF: Boss_ZLeoUpdateSegments+1A4   j
                rts
; End of function Boss_ZLeoUpdateSegments
; Animation calculation
Boss_ZLeoAnimationCalc:                                 ; CODE XREF: Boss_ZLeoUpdateSegments+5C   p  ; was: sub_52C34
                lea     word_52D68(pc),a1
                nop
                moveq   #$D,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ZLeoAnimationCalc
; Loads animation frame delay data for Z-Leo using 13 animation channels
Boss_ZLeoAnimationLoadDelays:
                moveq   #$D,d7                          ; was: sub_52C4A
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Boss_ZLeoAnimationLoadDelays
; ---------------------------------------------------------------------------
word_52C56:     dc.w    $810, $E, $1010, $E, $810, $1C, $1010, $1C, $FFFF
                                        ; DATA XREF: Boss_ZLeoIntroSetup+4E   o
word_52C68:     dc.w    $3030, $62, $C18, $70, $3030, $70, $C18, $62, $FFFF
                                        ; DATA XREF: Boss_ZLeoAttackPattern2+70   o
                                        ; Boss_ZLeoAttackPattern2+A0   o
word_52C7A:     dc.w    $810, $E, $1010, $E, $810, $1C, $1010, $1C, $FFFF
                                        ; DATA XREF: Boss_ZLeoIntroMove+1E   o
                                        ; Boss_ZLeoBattleStart+48   o
word_52C8C:     dc.w    $1818, $2A, $8001, $1010, $38, $2020, $46, $FFFE
                                        ; DATA XREF: Boss_ZLeoBattleState1:loc_51FBC   o
word_52C9C:     dc.w    $218, $46, $278, $54, $FFFF, $2020, $54, $1010, $54, $FFFF
                                        ; DATA XREF: Boss_ZLeoBattleState2+6   o
word_52CB0:     dc.w    $1020, $7E, $2020, $7E, $1020, $8C, $2020, $8C, $FFFF
                                        ; DATA XREF: Boss_ZLeoBattleState2+2A   o
                                        ; sub_52028:loc_5203C   o
word_52CC2:     dc.w    $1020, $8C, $2020, $8C, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackState1:loc_522EC   o
word_52CCC:     dc.w    $2830, $9A, $3030, $9A, $8001, $5060, $A8, $4040, $A8, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1:off_5225C   o
word_52CE0:     dc.w    $2830, $B6, $3030, $B6, $8001, $5060, $C4, $4040, $C4, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+9E   o
word_52CF4:     dc.w    $2830, $D2, $3030, $D2, $8001, $5060, $E0, $4040, $E0, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+A2   o
word_52D08:     dc.w    $2830, $EE, $3030, $EE, $8001, $5060, $FC, $4040, $FC, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackPattern1+A6   o
word_52D1C:     dc.w    $1218, $10A, $707, $10A, $1014, $118, $1A1A, $118, $340, $126, $8001, $90E, $126, $1A1A, $126, $1818
                                        ; DATA XREF: Boss_ZLeoAttackInit+2C   o
                                        ; sub_52368:loc_5238C   o
                dc.w    $134, $343C, $142, $FFFE
word_52D44:     dc.w    $60A, $142, $A0A, $142, $8001, $103, $150, $303, $150, $FFFE
                                        ; DATA XREF: Boss_ZLeoAttackSequence:loc_523E2   o
                                        ; Boss_ZLeoAttackSequence+D4   o
word_52D58:     dc.w    $404, $15E, $FFFE               ; DATA XREF: Boss_ZLeoRisingAttack:loc_525DA   o
word_52D5E:     dc.w    $810, $16C, $3030, $16C, $FFFE
                                        ; DATA XREF: Boss_ZLeoRisingAttack+4A   o
                                        ; sub_52550:loc_5261A   o
word_52D68:     binclude "data/other/word_52D68.bin"
word_52D68_End:

; Empty entity state handler in main dispatch table
