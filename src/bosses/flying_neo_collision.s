Boss_FlyingNeoCollisionCheck:                           ; CODE XREF: Boss_FlyingNeoUpdateSprites+38   p  ; was: sub_3CDAE
                clr.w   $23E(a5)
                move.w  $536(a5),d0
                andi.w  #$3FC,d0
                move.w  (dword_FFFF08).w,d1
                andi.w  #$F,d1
                beq.s   locret_3CDE8
                tst.w   $17C(a5)
                bne.s   loc_3CDEA
                cmpi.w  #$200,d0
                bmi.s   loc_3CDE2
                cmpi.w  #$340,d0
                bpl.s   loc_3CDDC
loc_3CDD6:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+32   j
                addq.w  #2,$17C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CDDC:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+26   j
                andi.w  #3,d1
                beq.s   loc_3CDD6
loc_3CDE2:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+20   j
                move.w  #$FFE0,$23E(a5)
locret_3CDE8:                                           ; CODE XREF: Boss_FlyingNeoCollisionCheck+14   j
                rts
; ---------------------------------------------------------------------------
loc_3CDEA:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+1A   j
                cmpi.w  #$200,d0
                bpl.s   loc_3CE0C
                cmpi.w  #$C0,d0
                bmi.s   loc_3CDFC
loc_3CDF6:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+5C   j
                clr.w   $17C(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CDFC:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+46   j
                moveq   #3,d2
                btst    #0,(word_FFA000).w
                beq.s   loc_3CE08
                moveq   #7,d2
loc_3CE08:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+56   j
                and.w   d2,d1
                beq.s   loc_3CDF6
loc_3CE0C:                                              ; CODE XREF: Boss_FlyingNeoCollisionCheck+40   j
                move.w  #$20,$23E(a5)                   ; ' '
                rts
; End of function Boss_FlyingNeoCollisionCheck
; Flips boss direction loading corresponding tile graphics
Boss_FlyingNeoFlipDirection:                            ; CODE XREF: Boss_FlyingNeoSetup+130   p  ; was: sub_3CE14
                                        ; Boss_FlyingNeoPlayerControlled+50   p
                moveq   #3,d0
                movea.w #(word_FFCA40-M68K_RAM),a0
                moveq   #8,d7
                tst.w   $54(a5)
                bne.w   loc_3CE62
                move.l  #$E01CD42E,$28(a5)
                bset    d0,$3CE(a5)
                bclr    d0,$6E(a5)
                move.w  #$E2F4,$6A(a5)
                bset    d0,$12E(a5)
                bset    d0,$2AE(a5)
                bset    d0,$1EE(a5)
                bset    d0,$36E(a5)
loc_3CE4A:                                              ; CODE XREF: Boss_FlyingNeoFlipDirection+3E   j
                bclr    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3CE4A
                lea     word_3CEAE(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
loc_3CE62:                                              ; CODE XREF: Boss_FlyingNeoFlipDirection+C   j
                move.l  #$E01CF040,$28(a5)
                bclr    d0,$3CE(a5)
                bset    d0,$6E(a5)
                move.w  #$F4,$6A(a5)
                bclr    d0,$12E(a5)
                bclr    d0,$2AE(a5)
                bclr    d0,$1EE(a5)
                bclr    d0,$36E(a5)
; Sets flip bits on all body segments and loads tiles
Boss_FlyingNeoSetFlipBits:                              ; CODE XREF: Boss_FlyingNeoFlipDirection+7C   j  ; was: loc_3CE88
                bset    d0,$E(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_FlyingNeoSetFlipBits
                lea     word_3CEBC(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Boss_FlyingNeoFlipDirection
; ---------------------------------------------------------------------------
word_3CEA0:     dc.w    $6C0C, $4000, $301, $5656, $5656, $5656, $5656
                                        ; DATA XREF: Boss_FlyingNeoDefeatState4+94   o
word_3CEAE:     dc.w    $6C0C, $2000, $301, $3031, $3233, $3435, $3637
                                        ; DATA XREF: Boss_FlyingNeoFlipDirection+42   o
word_3CEBC:     dc.w    $6C0C, $2000, $301, $3839, $3A3B, $373D, $3E3F
                                        ; DATA XREF: Boss_FlyingNeoFlipDirection+80   o

; Initializes enemy sprite parameters from table
Boss_FlyingNeoInitSprites:                              ; CODE XREF: Boss_FlyingNeoSetup+9C   p  ; was: sub_3CECA
                                        ; Boss_FlyingNeoSetup+A8   p
                move.w  d0,(a0)
                move.b  #$18,$20(a0)
                move.w  d2,2(a0)
                move.w  (a1),$E(a0)
                move.w  2(a1),8(a0)
                move.w  4(a1),$A(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_FlyingNeoInitSprites
                rts
; End of function Boss_FlyingNeoInitSprites
; ---------------------------------------------------------------------------
word_3CEF0:     dc.w    $6386, $A00, $F4F4              ; DATA XREF: Boss_FlyingNeoSetup+94   o
word_3CEF6:     dc.w    $638F, $500, $F8F8              ; DATA XREF: Boss_FlyingNeoSetup+A0   o
word_3CEFC:     dc.w    $6393, $500, $F8F8              ; DATA XREF: Boss_FlyingNeoSetup+AC   o
word_3CF02:     dc.w    $6397, 0, $FCFC                 ; DATA XREF: Boss_FlyingNeoSetup+B8   o

nullsub_78:
                rts
; End of function nullsub_78

; Processes animation with interpolation and angle updates
Boss_FlyingNeoProcessAnimation:                         ; CODE XREF: Boss_FlyingNeoIntroWait+10   p  ; was: sub_3CF0A
                                        ; Boss_FlyingNeoPlayerControlled+72   p
                clr.w   $A(a5)
                tst.w   $C(a5)
                bpl.s   loc_3CF8C
loc_3CF14:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3CF9C
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3CF36
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3CF36:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3CF46
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3CF46:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3CF56
                clr.w   $58(a5)
                clr.w   6(a5)
                bra.s   loc_3CF14
; ---------------------------------------------------------------------------
loc_3CF56:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3D082,d0
                movea.l d0,a0
                bsr.w   Boss_FlyingNeoCalculateDeltas
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,6(a5)
                addq.w  #1,$A(a5)
                tst.w   $C(a5)
                bmi.s   loc_3CF9C
loc_3CF8C:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #3,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_3CF9C:                                              ; CODE XREF: Boss_FlyingNeoProcessAnimation+E   j
                                        ; Boss_FlyingNeoProcessAnimation+80   j
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$1FE,d7
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.w  d0,$176(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$1D6(a5)
                move.w  d1,$236(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$296(a5)
                move.w  d0,$2F6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$356(a5)
                move.w  d1,$3B6(a5)
                rts
; End of function Boss_FlyingNeoProcessAnimation
; Calculates interpolation deltas for animation system
Boss_FlyingNeoCalculateDeltas:                          ; CODE XREF: Boss_FlyingNeoProcessAnimation+62   p  ; was: sub_3CFE8
                movea.l #word_34F86,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #3,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_FlyingNeoCalculateDeltas
; Load animation frame delays for Flying-Neo boss
Boss_FlyingNeoLoadFrameDelays:
                movea.w #(dword_FF9400-M68K_RAM),a1     ; was: sub_3CFFE
                moveq   #3,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_FlyingNeoLoadFrameDelays
; ---------------------------------------------------------------------------
word_3D00A:     dc.w    $408, 0, $808, 0, $408, 4, $808, 4
                                        ; DATA XREF: Boss_FlyingNeoIntroWait+A   o
                                        ; sub_3C4E2:loc_3C54E   o
                dc.w    $FFFF
word_3D01C:     dc.w    $612, 0, $1212, 0, $612, 4, $1212, 4
                                        ; DATA XREF: Boss_FlyingNeoSwoopAttack:loc_3C762   o
                dc.w    $FFFF
word_3D02E:     dc.w    $828, 8, $E0E, 8, $A10, $C, $A0A, $C
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision+1F6   o
                dc.w    $80AF, $828, $10, $E0E, $10, $A10, $14, $A0A
                dc.w    $14, $80AF, $FFFF
word_3D054:     dc.w    $70C, $18, $4040, $18, $FFFE
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C836   o
word_3D05E:     dc.w    $210, $1C, $606, $1C, $220, $20, $808, $20
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C8A8   o
                dc.w    $FFFF
word_3D070:     dc.w    $820, $1C, $1216, $1C, $820, $20, $1216, $20
                                        ; DATA XREF: Boss_FlyingNeoHoverDecision:loc_3C924   o
                dc.w    $FFFF
word_3D082:     dc.w    $868, $1C70, $1C70, $868, $3010, $470, $1020, $501B
                                        ; DATA XREF: Boss_FlyingNeoProcessAnimation+5A   o
                dc.w    $470, $3010, $5020, $1020, $6850, $6850, $7800, $870
                dc.w    $1860, $7008, $6C24, $878, $F860, $6024

; Main caterpillar boss handler with state dispatch
