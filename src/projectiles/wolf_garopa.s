Boss_WolfGaropaShootPattern5:                           ; CODE XREF: Boss_WolfGaropaInitMultiPattern+12   j  ; was: sub_50220
                                        ; Boss_WolfGaropaShootPattern3+A8   j
                moveq   #$18,d7
                jsr     (Sprite_BeginMetaspritePartTraversal).l
                bsr.w   Boss_WolfGaropaCollision
                bsr.w   Boss_WolfGaropaCleanup
                move.w  $10(a5),$35E(a5)
                move.w  $14(a5),$3BC(a5)
                move.w  #$130,d0
                sub.w   $35E(a5),d0
                move.w  $3BC(a5),d1
                addi.w  #$10,d1
                move.w  d0,(dword_FFA908).w
                add.w   (word_FFA016).w,d0
                move.w  d1,(dword_FFA90C).w
                move.w  (dword_FFA908).w,d0
                bmi.s   loc_5026C
                cmpi.w  #$108,d0
                bmi.s   loc_50272
loc_50264:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+50   j
                move.w  #$FEF6,(dword_FFA908).w
                bra.s   loc_50272
; ---------------------------------------------------------------------------
loc_5026C:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+3C   j
                cmpi.w  #$FEF6,d0
                bmi.s   loc_50264
loc_50272:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+42   j
                                        ; Boss_WolfGaropaShootPattern5+4A   j
                move.w  $35E(a5),d0
                addi.w  #-$A,d0
                move.w  d0,$970(a5)
                move.w  $3BC(a5),d0
                addi.w  #-$34,d0
                move.w  d0,$974(a5)
                move.w  $53E(a5),d2
                sub.w   $A16(a5),d2
                bmi.w   loc_502B0
                cmpi.w  #4,d2
                bmi.s   loc_502C8
                cmpi.w  #$100,d2
                bpl.w   loc_502BE
loc_502A4:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+9A   j
                addq.w  #2,$A16(a5)
                andi.w  #$1FE,$A16(a5)
                bra.s   loc_502C8
; ---------------------------------------------------------------------------
loc_502B0:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+72   j
                cmpi.w  #$FFFC,d2
                bpl.s   loc_502C8
                cmpi.w  #$FF00,d2
                bmi.w   loc_502A4
loc_502BE:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+80   j
                subq.w  #2,$A16(a5)
                andi.w  #$1FE,$A16(a5)
loc_502C8:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+7A   j
                                        ; Boss_WolfGaropaShootPattern5+8E   j
                move.w  $A16(a5),d0
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   #3,d1
                asl.l   #4,d2
                swap    d1
                swap    d2
                move.w  $53C(a5),d0
                asr.w   #3,d0
                add.w   d0,d1
                add.w   $35E(a5),d2
                addi.w  #$12,d2
                move.w  d2,$9D0(a5)
                add.w   $3BC(a5),d1
                addi.w  #-$47,d1
                move.w  d1,$9D4(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  $3C(a0),d5
                ext.w   d5
                move.b  $40(a0),d6
                ext.w   d6
                move.w  $35E(a5),d2
                addi.w  #$38,d2                         ; '8'
                add.w   d5,d2
                move.w  d2,$A90(a5)
                move.w  $3BC(a5),d3
                addi.w  #-$1C,d3
                add.w   d6,d3
                move.w  d3,$A94(a5)
                moveq   #0,d7
                move.b  $38(a0),d7
                cmpi.w  #$30,d7                         ; '0'
                bmi.s   loc_5034E
                move.l  #word_ED352,d1
                addi.w  #$24,d2                         ; '$'
                addi.w  #-6,d3
                bra.s   loc_5035C
; ---------------------------------------------------------------------------
loc_5034E:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+11C   j
                move.l  #word_ED33A,d1
                addi.w  #$1E,d2
                addi.w  #-$12,d3
loc_5035C:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+12C   j
                move.l  d1,$A88(a5)
                move.l  #word_ED310,d1
                cmpi.w  #$40,d7                         ; '@'
                bpl.s   loc_50372
                move.l  #word_ED328,d1
loc_50372:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+14A   j
                move.l  d1,$AE8(a5)
                move.b  $44(a0),d6
                ext.w   d6
                move.w  d2,$AF0(a5)
                add.w   d6,d3
                move.w  d3,$AF4(a5)
                tst.w   (word_FF8200).w
                bne.s   loc_5038E
                bra.s   loc_503A4
; ---------------------------------------------------------------------------
loc_5038E:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+16A   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_503A4
                addi.w  #$20,(word_FFE37E).w            ; ' '
                andi.w  #$EE,(word_FFE37E).w
loc_503A4:                                              ; CODE XREF: Boss_WolfGaropaShootPattern5+16C   j
                                        ; Boss_WolfGaropaShootPattern5+176   j
                bsr.w   Boss_WolfGaropaSpawnProjectile3
                bra.w   Projectile_WolfGaropaMain
; End of function Boss_WolfGaropaShootPattern5
; Graphics update handler
Boss_WolfGaropaGraphicsUpdate:                          ; CODE XREF: Projectile_WolfGaropaBullet1+B2   p  ; was: sub_503AC
                move.w  (word_FF8248).w,d0
                sub.w   $9D0(a5),d0
                move.w  d0,d1
                bpl.s   loc_503BA
                neg.w   d0
loc_503BA:                                              ; CODE XREF: Boss_WolfGaropaGraphicsUpdate+A   j
                cmpi.w  #6,d0
                bmi.s   locret_503D0
                bset    #3,$9CE(a5)
                tst.w   d1
                bpl.s   locret_503D0
                bclr    #3,$9CE(a5)
locret_503D0:                                           ; CODE XREF: Boss_WolfGaropaGraphicsUpdate+12   j
                                        ; Boss_WolfGaropaGraphicsUpdate+1C   j
                rts
; End of function Boss_WolfGaropaGraphicsUpdate
; Check if bomb spawning conditions met and load bomb graphics tiles
Boss_WolfGaropaBombCheck1:                              ; CODE XREF: Boss_WolfGaropaRising+6   p  ; was: sub_503D2
                tst.b   (byte_FF9DBA).w
                beq.s   loc_503DA
locret_503D8:                                           ; CODE XREF: Boss_WolfGaropaBombCheck1+E   j
                rts
; ---------------------------------------------------------------------------
loc_503DA:                                              ; CODE XREF: Boss_WolfGaropaBombCheck1+4   j
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_503D8
                move.b  #1,(byte_FF9DBA).w
                moveq   #0,d0
                move.w  #$E2,d1
                bsr.w   Boss_ValkirieInitScreenPair
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                lea     word_50414(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                lea     word_50420(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck1
; ---------------------------------------------------------------------------
word_50414:     dc.w    $4658, $4000, $102, $2A2B, $2C2D, $2E2F
                                        ; DATA XREF: Boss_WolfGaropaBombCheck1+2A   o
word_50420:     dc.w    $4C50, $4000, $401, $3031, $3233, $2634, $3536, $3738
                                        ; DATA XREF: Boss_WolfGaropaBombCheck1+36   o

; Trigger bomb spawn check by calling bomb initialization
Boss_WolfGaropaBombTrigger:                             ; CODE XREF: Boss_WolfGaropaDiveLoop+1C   p  ; was: sub_50430
                tst.b   (byte_FF9DBA).w
                beq.s   Boss_WolfGaropaBombCheck2
locret_50436:                                           ; CODE XREF: Boss_WolfGaropaBombCheck2+6   j
                rts
; End of function Boss_WolfGaropaBombTrigger
; Second bomb check variant: load different compressed tile set
Boss_WolfGaropaBombCheck2:                              ; CODE XREF: Boss_WolfGaropaBombTrigger+4   j  ; was: sub_50438
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_50436
                move.b  #1,(byte_FF9DBA).w
                moveq   #1,d0
                move.w  #$DE,d1
                bsr.w   Boss_ValkirieInitScreenPair
                move.b  #$D0,d0
                jsr     (Sound_PlaySFX).l
                lea     word_50466(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck2
; ---------------------------------------------------------------------------
word_50466:     dc.w    $4458, $4000, $101, $3C3B, $3D3F
                                        ; DATA XREF: Boss_WolfGaropaBombCheck2+22   o

; Third bomb check variant: load additional compressed tile set
Boss_WolfGaropaBombCheck3:
                tst.b   (byte_FF9DBA).w                 ; was: sub_50470
                beq.s   loc_50478
locret_50476:                                           ; CODE XREF: Boss_WolfGaropaBombCheck3+E   j
                rts
; ---------------------------------------------------------------------------
loc_50478:                                              ; CODE XREF: Boss_WolfGaropaBombCheck3+4   j
                cmpi.w  #$10,(dword_FFA900).w
                bpl.s   locret_50476
                move.b  #1,(byte_FF9DBA).w
                lea     word_50492(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_WolfGaropaBombCheck3
; ---------------------------------------------------------------------------
word_50492:     dc.w    $4C50, $4000, $301, $4243, $4445, $4647, $4849
                                        ; DATA XREF: Boss_WolfGaropaBombCheck3+16   o

; Spawns projectile type 3
Boss_WolfGaropaSpawnProjectile3:                        ; CODE XREF: Boss_WolfGaropaShootPattern5:loc_503A4   p  ; was: sub_504A0
                subq.w  #4,$53C(a5)
                bpl.s   loc_504AA
                clr.w   $53C(a5)
loc_504AA:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+4   j
                move.w  $A76(a5),d0
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                moveq   #$20,d3                         ; ' '
                moveq   #$36,d4                         ; '6'
                sub.w   $53C(a5),d3
                sub.w   $53C(a5),d4
                muls.w  d3,d1
                muls.w  d4,d2
                swap    d1
                swap    d2
                cmpi.w  #$120,d0
                bmi.s   loc_504DC
                cmpi.w  #$1E0,d0
                bmi.s   loc_504DE
loc_504DC:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+34   j
                addq.w  #6,d1
loc_504DE:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+3A   j
                add.w   $974(a5),d1
                add.w   $970(a5),d2
                move.w  d1,$A34(a5)
                move.w  d2,$A30(a5)
                lea     off_50586(pc),a1
                nop
                movea.w #(byte_FFD040-M68K_RAM),a0
                andi.w  #$E7FF,$E(a0)
                jsr     (Sprite_UpdateFourDirectionFrame).l
                movea.w #(byte_FFD160-M68K_RAM),a0
                jsr     (loc_2A128).l
                move.w  $6BC(a5),d0
                btst    #3,$65E(a5)
                beq.s   loc_5052A
                addi.w  #$C,d0
                cmpi.w  #$180,d0
                bmi.s   loc_5053A
                move.w  #$180,d0
                bra.s   loc_5053A
; ---------------------------------------------------------------------------
loc_5052A:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+78   j
                subq.w  #2,d0
                bpl.s   loc_5053A
                bclr    #7,$B42(a5)
                clr.w   $6BC(a5)
                rts
; ---------------------------------------------------------------------------
loc_5053A:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+82   j
                                        ; Boss_WolfGaropaSpawnProjectile3+88   j
                move.w  d0,$6BC(a5)
                bset    #7,$B42(a5)
                btst    #1,$65E(a5)
                beq.s   loc_5055A
                btst    #2,(word_FFA000+1).w
                beq.s   loc_5055A
                bclr    #7,$B42(a5)
loc_5055A:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile3+AA   j
                                        ; Boss_WolfGaropaSpawnProjectile3+B2   j
                move.w  $A76(a5),d3
                lea     (Math_SineTable).l,a0
                move.w  Math_QuarterSineTable-Math_SineTable(a0,d3.w),d1
                move.w  (a0,d3.w),d2
                muls.w  d0,d1
                muls.w  d0,d2
                swap    d1
                swap    d2
                add.w   $A34(a5),d1
                add.w   $A30(a5),d2
                move.w  d1,$B54(a5)
                move.w  d2,$B50(a5)
                rts
; End of function Boss_WolfGaropaSpawnProjectile3
; ---------------------------------------------------------------------------
off_50586:      dc.l    word_ED190                      ; DATA XREF: Boss_WolfGaropaSpawnProjectile3+4E   o
                dc.l    word_ED19C
                dc.l    word_ED1AE
                dc.l    word_ED1BA

; Projectile main handler
Projectile_WolfGaropaMain:                              ; CODE XREF: Boss_WolfGaropaShootPattern5+188   j  ; was: sub_50596
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #$C,d0
                movea.l off_505AA(pc,d0.w),a0
                jmp     Gfx_LoadCompressedTiles
; End of function Projectile_WolfGaropaMain
; ---------------------------------------------------------------------------
off_505AA:      dc.l    byte_505BA                      ; DATA XREF: Projectile_WolfGaropaMain+A   r
                dc.l    byte_505C2
                dc.l    byte_505CA
                dc.l    byte_505C2
byte_505BA:     dc.b    $64, $92, $20, 0, 1, 0, $C, $D
                                        ; DATA XREF: ROM:off_505AA   o
byte_505C2:     dc.b    $64, $92, $20, 0, 1, 0, $E, $F
                                        ; DATA XREF: ROM:000505AE   o
                                        ; ROM:000505B6   o
byte_505CA:     dc.b    $64, $92, $20, 0, 1, 0, $10, $11
                                        ; DATA XREF: ROM:000505B2   o

; Shooting pattern 6
Boss_WolfGaropaShootPattern6:                           ; CODE XREF: Boss_WolfGaropaInitMultiPattern+E   p  ; was: sub_505D2
                                        ; Boss_WolfGaropaShootPattern3+7A   p
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_5064A
loc_505DC:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+24   j
                                        ; Boss_WolfGaropaShootPattern6+44   j
                move.w  $58(a5),d0
                bmi.w   loc_5065A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_505F8
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_505DC
; ---------------------------------------------------------------------------
loc_505F8:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_50608
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_50608:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+2E   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_50618
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_505DC
; ---------------------------------------------------------------------------
loc_50618:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+3A   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_508A2,d0
                movea.l d0,a0
                bsr.w   Boss_WolfGaropaSpawnProjectile1
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5065A
loc_5064A:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_5065A:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+E   j
                                        ; Boss_WolfGaropaShootPattern6+76   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #word_ED304,d5
                move.l  #word_ED30A,d6
                move.b  (a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $B2(a5),d0
                move.w  d0,$B4(a5)
                add.w   $112(a5),d1
                move.w  d1,$114(a5)
                move.b  4(a0),d0
                ext.w   d0
                move.w  d0,d1
                add.w   $172(a5),d0
                move.w  d0,$174(a5)
                add.w   $1D2(a5),d1
                move.w  d1,$1D4(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$236(a5)
                move.w  d0,$296(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$2F6(a5)
                move.w  d1,$356(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                and.w   d7,d2
                move.l  d5,$368(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_506E4
                cmpi.w  #$100,d2
                bpl.s   loc_506E4
                move.l  d6,$368(a5)
loc_506E4:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+106   j
                                        ; Boss_WolfGaropaShootPattern6+10C   j
                move.b  $14(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  d0,$476(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$4D6(a5)
                move.w  d1,$536(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                and.w   d7,d2
                move.l  d5,$548(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_5072C
                cmpi.w  #$100,d2
                bpl.s   loc_5072C
                move.l  d6,$548(a5)
loc_5072C:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+14E   j
                                        ; Boss_WolfGaropaShootPattern6+154   j
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                move.w  d0,$656(a5)
                move.b  $24(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$6B6(a5)
                move.w  d1,$716(a5)
                move.b  $28(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                addi.w  #$10,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$776(a5)
                and.w   d7,d2
                move.l  d5,$728(a5)
                cmpi.w  #$10,d2
                bmi.s   loc_50778
                cmpi.w  #$100,d2
                bpl.s   loc_50778
                move.l  d6,$728(a5)
loc_50778:                                              ; CODE XREF: Boss_WolfGaropaShootPattern6+19A   j
                                        ; Boss_WolfGaropaShootPattern6+1A0   j
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$7D6(a5)
                move.w  d0,$836(a5)
                move.b  $30(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $34(a0),d0
                asl.w   #1,d0
                move.w  d0,d2
                add.w   d1,d0
                addi.w  #$10,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                and.w   d7,d2
                move.l  d5,$908(a5)
                cmpi.w  #$10,d2
                bmi.s   locret_507C4
                cmpi.w  #$100,d2
                bpl.s   locret_507C4
                move.l  d6,$908(a5)
locret_507C4:                                           ; CODE XREF: Boss_WolfGaropaShootPattern6+1E6   j
                                        ; Boss_WolfGaropaShootPattern6+1EC   j
                rts
; End of function Boss_WolfGaropaShootPattern6
; Spawns projectile type 1
Boss_WolfGaropaSpawnProjectile1:                        ; CODE XREF: Boss_WolfGaropaShootPattern6+5C   p  ; was: sub_507C6
                lea     word_508A2(pc),a1
                nop
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_WolfGaropaSpawnProjectile1
; Load Wolf Garopa animation frame delays with count $12
Anim_WolfGaropaLoadFrames:
                moveq   #$12,d7                         ; was: sub_507DC
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Anim_WolfGaropaLoadFrames
; ---------------------------------------------------------------------------
                dc.b    $FF, $FF
word_507EA:     dc.w    $506, $36, $8089, $303, $48, $808A, $605, $5A, $808B, $205, $6C, $8004, $303, $6C, $80D, $12
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3+1C   o
                                        ; Boss_WolfGaropaShootPattern3+50   o
                dc.w    $505, $12, $808, $24, $FFFE
word_50814:     dc.w    $90A, $36, $8089, $404, $48, $808A, $807, $5A, $808B, $306, $6C, $8004, $303, $6C, $80D, $12
                                        ; DATA XREF: Boss_WolfGaropaShootPattern3:loc_4FEB8   o
                dc.w    $505, $12, $808, $24, $FFFE
word_5083E:     dc.w    $810, $B4, $606, $B4, $8040, $606, $B4, $8089, $FFFE
                                        ; DATA XREF: Boss_WolfGaropaFalling:loc_5002C   o
word_50850:     dc.w    $C0C, $7E, $808B, $A0A, $90, $8088, $C0C, $A2, $808A, $A0A, $B4, $8089, $FFFF
                                        ; DATA XREF: Boss_WolfGaropaFalling:loc_500A8   o
word_5086A:     dc.w    $408, $24, $808, $24, $FFFE
                                        ; DATA XREF: Boss_WolfGaropaFalling2+10   o
word_50874:     dc.w    $506, $36, $8089, $203, $48, $808A, $405, $5A, $808B, $104, $FC, $8044, $304, $FC, $A12, $C6
                                        ; DATA XREF: Boss_WolfGaropaInitMultiPattern+8   o
                                        ; sub_50160   o
                dc.w    $A0A, $C6, $606, $D8, $606, $EA, $FFFE
word_508A2:     binclude "data/other/word_508A2.bin"
word_508A2_End:

; Bullet projectile 2
Projectile_WolfGaropaBullet2:                           ; CODE XREF: Projectile_WolfGaropaBullet1+BE   p  ; was: sub_509B0
                movea.w #(byte_FFD040-M68K_RAM),a5
                jsr     (Math_CalculateAngleToPlayer).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                moveq   #0,d3
                moveq   #4,d7
                cmpi.w  #$14,$4DE(a5)
                beq.s   Boss_WolfGaropaSpawnProjectile4
                tst.w   $4DE(a5)
                bmi.s   Boss_WolfGaropaSpawnProjectile4
                moveq   #2,d7
; End of function Projectile_WolfGaropaBullet2
; Spawns projectile type 4
Boss_WolfGaropaSpawnProjectile4:                        ; CODE XREF: Projectile_WolfGaropaBullet1+44   j  ; was: sub_509D2
                                        ; Projectile_WolfGaropaBullet1+16C   p
                sub.w   $A76(a5),d2
                bmi.w   loc_509F6
                cmpi.w  #$C,d2
                bmi.w   loc_50A10
                cmpi.w  #$100,d2
                bpl.w   loc_50A04
loc_509EA:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+2E   j
                add.w   d7,$A76(a5)
                andi.w  #$1FE,$A76(a5)
                rts
; ---------------------------------------------------------------------------
loc_509F6:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+4   j
                cmpi.w  #$FFF4,d2
                bpl.s   loc_50A10
                cmpi.w  #$FF00,d2
                bmi.w   loc_509EA
loc_50A04:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+14   j
                sub.w   d7,$A76(a5)
                andi.w  #$1FE,$A76(a5)
                rts
; ---------------------------------------------------------------------------
loc_50A10:                                              ; CODE XREF: Boss_WolfGaropaSpawnProjectile4+C   j
                                        ; Boss_WolfGaropaSpawnProjectile4+28   j
                addq.w  #1,d3
                rts
; End of function Boss_WolfGaropaSpawnProjectile4
; Homing projectile
Projectile_WolfGaropaHoming:                            ; CODE XREF: Projectile_WolfGaropaBullet1+132   j  ; was: sub_50A14
                move.w  #1,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_50AEE
                movea.l #Weapon_SpreadShotInitialSpriteFrame,a1
                jsr     (Sprite_InitFromTable).l
                move.b  #4,$20(a0)
                move.w  #$8040,2(a0)
                movea.w a0,a3
                move.w  #$1C,$53C(a5)
                jsr     (Projectile_FindFreeSlot).l
                bne.w   locret_50AEE
                move.b  #$36,d0                         ; '6'
                jsr     (Sound_PlaySFX).l
                move.w  #$408,(a0)
                move.w  #$CC00,2(a0)
                move.b  #$42,$21(a0)                    ; 'B'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #4,$26(a0)
                move.b  #8,$20(a0)
                move.w  $A76(a5),d0
                move.w  d0,d2
                lea     (Math_SineTable).l,a2
                move.w  Math_QuarterSineTable-Math_SineTable(a2,d0.w),d3
                move.w  (a2,d0.w),d4
                muls.w  #$80,d3
                muls.w  #$80,d4
                move.l  d3,d5
                move.l  d4,d6
                swap    d5
                swap    d6
                add.w   $A34(a5),d5
                add.w   $A30(a5),d6
                move.w  d5,$14(a0)
                move.w  d6,$10(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d5
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,d6
                move.w  d5,$14(a3)
                move.w  d6,$10(a3)
                asr.l   #2,d3
                asr.l   #2,d4
                move.l  d3,$1C(a0)
                move.l  d4,$18(a0)
                move.w  #$8480,$E(a0)
                jmp     Projectile_WolfGaropaLaser
; ---------------------------------------------------------------------------
locret_50AEE:                                           ; CODE XREF: Projectile_WolfGaropaHoming+12   j
                                        ; Projectile_WolfGaropaHoming+3C   j
                rts
; End of function Projectile_WolfGaropaHoming
; Wave projectile
Projectile_WolfGaropaWave:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_50AF0
                tst.w   (word_FF808C).w
                bpl.s   loc_50B06
                btst    #7,$22(a5)
                beq.s   loc_50B3A
                btst    #4,$22(a5)
                beq.s   loc_50B24
loc_50B06:                                              ; CODE XREF: Projectile_WolfGaropaWave+4   j
                btst    #0,(dword_FFFF08+1).w
                bne.s   loc_50B44
                jsr     (Pickup_SpawnSmallFromCurrentObject).l
                ori.w   #$A00,2(a5)
                move.l  #$FFFA8000,$18(a5)
                rts
; ---------------------------------------------------------------------------
loc_50B24:                                              ; CODE XREF: Projectile_WolfGaropaWave+14   j
                neg.l   $18(a5)
loc_50B28:                                              ; CODE XREF: Projectile_WolfGaropaWave+8C   j
                neg.l   $1C(a5)
                move.l  #off_E95A4,8(a5)
                jmp     Sprite_InitType160FromCurrent
; ---------------------------------------------------------------------------
loc_50B3A:                                              ; CODE XREF: Projectile_WolfGaropaWave+C   j
                move.w  $10(a5),d0
                cmpi.w  #$78,d0                         ; 'x'
                bpl.s   loc_50B4C
loc_50B44:                                              ; CODE XREF: Projectile_WolfGaropaWave+1C   j
                                        ; Projectile_WolfGaropaWave+60   j
                bset    #4,2(a5)
locret_50B4A:                                           ; CODE XREF: Projectile_WolfGaropaWave+70   j
                rts
; ---------------------------------------------------------------------------
loc_50B4C:                                              ; CODE XREF: Projectile_WolfGaropaWave+52   j
                cmpi.w  #$288,d0
                bpl.s   loc_50B44
                cmpi.w  #$98,$14(a5)
                bmi.s   loc_50B44
                cmpi.w  #$150,$14(a5)
                bmi.s   locret_50B4A
                move.b  #$37,d0                         ; '7'
                jsr     (Sound_PlaySFX).l
                move.l  $18(a5),d0
                asr.l   #2,d0
                subi.l  #$28000,d0
                move.l  d0,$18(a5)
                bra.s   loc_50B28
; End of function Projectile_WolfGaropaWave
; Defeat sequence init
