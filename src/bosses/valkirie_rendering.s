Boss_ValkirieUpdateSprites:                             ; CODE XREF: Boss_ValkirieBattleStart+4   p  ; was: sub_5605C
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
                move.b  $48(a0),d1
                ext.w   d1
                move.w  $172(a5),d0
                add.w   d1,d0
                move.w  d0,$174(a5)
                rts
; End of function Boss_ValkirieUpdateSprites
; Animation script interpreter
Boss_ValkirieAnimationScript:                           ; CODE XREF: Boss_ValkirieBattleStart   p  ; was: sub_56190
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   loc_5620A
loc_5619A:                                              ; CODE XREF: Boss_ValkirieAnimationScript+24   j
                                        ; Boss_ValkirieAnimationLoop+E   j
                move.w  $58(a5),d0
                bmi.w   loc_5621A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_561B6
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   loc_5619A
; ---------------------------------------------------------------------------
loc_561B6:                                              ; CODE XREF: Boss_ValkirieAnimationScript+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Boss_ValkirieAnimationLoop
                move.w  d3,$58(a5)
                bra.w   loc_5621A
; End of function Boss_ValkirieAnimationScript
nullsub_128:
                rts
; End of function nullsub_128

; Animation loop handler
Boss_ValkirieAnimationLoop:                             ; CODE XREF: Boss_ValkirieAnimationScript+2E   j  ; was: sub_561CA
                cmpi.w  #$FFFF,d3
                bne.s   loc_561DA
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   loc_5619A
; ---------------------------------------------------------------------------
loc_561DA:                                              ; CODE XREF: Boss_ValkirieAnimationLoop+4   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                add.l   $35C(a5),d0
                movea.l d0,a0
                bsr.w   Boss_ValkirieAnimationUpdate
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   loc_5621A
loc_5620A:                                              ; CODE XREF: Boss_ValkirieAnimationScript+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$12,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_5621A:                                              ; CODE XREF: Boss_ValkirieAnimationScript+E   j
                                        ; Boss_ValkirieAnimationScript+34   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                rts
; End of function Boss_ValkirieAnimationLoop
; Animation frame update
Boss_ValkirieAnimationUpdate:                           ; CODE XREF: Boss_ValkirieAnimationLoop+24   p  ; was: sub_56224
                movea.l $2FC(a5),a1
                moveq   #$12,d7
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_ValkirieAnimationUpdate
; Loads 18 animation frame delays into RAM buffer at $FF9400
Anim_ValkirieLoadFrames:
                moveq   #$12,d7                         ; was: sub_56238
                movea.w #(dword_FF9400-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Anim_ValkirieLoadFrames
; ---------------------------------------------------------------------------
word_56244:     dc.w    $A0F, $190, $606, $190, $1C1C, $1A4, $8002, $A0F, $1B8, $606, $1B8, $1C1C, $1CC, $8001, $FFFF
                                        ; DATA XREF: Boss_ValkirieInitParts:loc_558AA   o
word_56262:     dc.w    $810, 0, $1010, 0, $8001, $810, $14, $1010, $14, $8001, $FFFF, $810, $140, $1010, $140, $8001
                                        ; DATA XREF: Boss_ValkirieIdleState:loc_55900   o
                                        ; sub_5590A:loc_55926   o
                dc.w    $810, $168, $1010, $168, $8001, $FFFF
word_5628E:     dc.w    $E12, $154, $8001, $808, $154, $E12, $17C, $8001, $707, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieAttackDecision:loc_55A32   o
                                        ; Boss_ValkirieRisingAttack+10   o
word_562A4:     dc.w    $101C, $1CC, $808, $1CC, $8081, $50C, $190, $808, $190, $101C, $1A4, $707, $1A4, $8082, $80C, $1B8
                                        ; DATA XREF: Boss_ValkirieHealthCheckAttack:loc_55B1C   o
                dc.w    $606, $1B8, $FFFF
word_562CA:     dc.w    $840, $28, $1018, $1E0, $1818, $1E0, $840, $1F4, $8001, $A0E, $1F4, $606, $1F4, $8008, $507, $208
                                        ; DATA XREF: Boss_ValkirieDamageCheck:loc_55D10   o
                dc.w    $808, $208, $FFFE
word_562F0:     dc.w    $4058, $21C, $7070, $21C, $FFFF
                                        ; DATA XREF: Boss_ValkirieDamageCheck:loc_55D60   o
word_562FA:     dc.w    $1020, $F0, $712, $244, $A0A, $244, $8001, $1258, $258, $608, $258, $8001, $3838, $258, $1870, $26C
                                        ; DATA XREF: Boss_ValkirieShootPattern3+8   o
                                        ; Boss_ValkirieShootPattern3+1E   o
                dc.w    $8001, $3232, $26C, $FFFE
word_56322:     dc.w    $A10, $280, $1313, $280, $815, $26C, $FFFE
                                        ; DATA XREF: Boss_ValkirieSpawnProjectile4+8   o
word_56330:     dc.w    $1010, $3C, $210, $50, $8003, $204, $50, $505, $50, $8004, $1418, $3C, $8008, $1818, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B62   o
word_56350:     dc.w    $1010, $3C, $210, $64, $8003, $204, $64, $404, $64, $8004, $1418, $3C, $8008, $1818, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B82   o
word_56370:     dc.w    $1A1A, $78, $420, $8C, $8003, $508, $8C, $808, $8C, $8004, $101A, $78, $8008, $1212, $17C, $FFFE
                                        ; DATA XREF: Boss_ValkirieChargeAttack:loc_55B96   o
word_56390:     dc.w    $408, $F0, $204, $F0, $303, $F0, $106, $12C, $8001, $204, $12C, $303, $12C, $8002, $306, $F0
                                        ; DATA XREF: Boss_ValkirieCollisionCheck+46   o
                                        ; Boss_ValkirieUpdateHealth+54   o
                dc.w    $204, $F0, $202, $F0, $106, $104, $8001, $204, $104, $303, $104, $8002, $106, $F0, $103, $F0
                dc.w    $202, $F0, $106, $104, $8001, $204, $118, $303, $118, $8002, $FFFF
word_563E6:     binclude "data/other/word_563E6.bin"
word_563E6_End:

; Movement pattern 1
Boss_ValkirieMovePattern1:                              ; CODE XREF: Boss_ValkirieIntroStop+52   p  ; was: sub_566B6
                                        ; Projectile_ValkirieBullet+46   p
                movea.w #(byte_FFCFE0-M68K_RAM),a0
                moveq   #5,d7
loc_566BC:                                              ; CODE XREF: Boss_ValkirieMovePattern1+C   j
                jsr     (Object_Clear96Bytes).l
                dbf     d7,loc_566BC
                movea.w #(byte_FFCFE0-M68K_RAM),a5
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #5,d7
                movea.l #Boss_ValkirieAuxiliaryMetaspritePartDescriptors,a0
                movea.l #Boss_ValkirieAuxiliaryMetaspriteInitialAngles,a1
                movea.l #Boss_ValkirieAuxiliaryMetaspritePartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$47C,(a5)
                move.w  #$8C00,2(a5)
                move.w  #$65,$206(a5)                   ; 'e'
                move.l  #$F808F808,$20C(a5)
                move.l  #$F010F010,$208(a5)
                move.b  #3,(byte_FFC9DE).w
                movea.w a5,a0
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_ValkirieMovePattern1
; Movement pattern 2
Boss_ValkirieMovePattern2:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_5671A
                btst    #1,(byte_FFC9DE).w
                beq.w   loc_56804
                bclr    #4,(byte_FFC9DE).w
                beq.s   loc_56770
                bclr    #1,(byte_FFC9DE).w
                move.w  #$D00,$1E2(a5)
                move.b  #$C0,$201(a5)
                move.b  #$10,$203(a5)
                move.w  #$D1C0,$48(a5)
                move.w  #$D1C0,$4A(a5)
                move.l  #$48000,d0
                clr.w   $23C(a5)
                tst.w   $54(a5)
                bne.s   loc_56768
                neg.l   d0
                move.w  #$100,$23C(a5)
loc_56768:                                              ; CODE XREF: Boss_ValkirieMovePattern2+44   j
                move.l  d0,$1F8(a5)
                bra.w   Boss_ValkirieUpdatePartPositions
; ---------------------------------------------------------------------------
loc_56770:                                              ; CODE XREF: Boss_ValkirieMovePattern2+10   j
                                        ; Boss_ValkirieMovePattern2+108   j
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  $54(a0),$54(a5)
                move.w  #$D160,$48(a5)
                move.w  #$D160,$4A(a5)
                move.w  $4F0(a0),$190(a5)
                move.w  $4F4(a0),$194(a5)
                move.w  $536(a0),$56(a5)
                bsr.w   Boss_ValkirieUpdatePartPositions
                moveq   #8,d5
                move.w  #$1F8,d6
                btst    #0,(byte_FFC9DE).w
                bne.s   loc_567D2
                cmpi.w  #$100,$B6(a5)
                beq.w   locret_568E2
                sub.w   d5,$B6(a5)
                and.w   d6,$B6(a5)
                move.w  $B6(a5),$116(a5)
                add.w   d5,$176(a5)
                and.w   d6,$176(a5)
                move.w  $176(a5),$1D6(a5)
                rts
; ---------------------------------------------------------------------------
loc_567D2:                                              ; CODE XREF: Boss_ValkirieMovePattern2+8E   j
                cmpi.w  #$140,$B6(a5)
                beq.w   locret_568E2
                add.w   d5,$B6(a5)
                and.w   d6,$B6(a5)
                move.w  $B6(a5),$116(a5)
                sub.w   d5,$176(a5)
                and.w   d6,$176(a5)
                move.w  $176(a5),$1D6(a5)
                cmpi.w  #$140,$B6(a5)
                bne.w   locret_568E2
                rts
; ---------------------------------------------------------------------------
loc_56804:                                              ; CODE XREF: Boss_ValkirieMovePattern2+6   j
                bclr    #5,(byte_FFC9DE).w
                beq.s   loc_56826
                bset    #1,(byte_FFC9DE).w
                clr.w   $1E2(a5)
                move.b  #$80,$201(a5)
                move.b  #$10,$203(a5)
                bra.w   loc_56770
; ---------------------------------------------------------------------------
loc_56826:                                              ; CODE XREF: Boss_ValkirieMovePattern2+F0   j
                move.w  $56(a5),d1
                addi.w  #$20,d1                         ; ' '
                andi.w  #$1E0,d1
                move.w  d1,$56(a5)
                bne.s   loc_56842
                move.b  #$C6,d0
                jsr     (Sound_PlaySFX).l
loc_56842:                                              ; CODE XREF: Boss_ValkirieMovePattern2+11C   j
                move.w  #$100,d1
                move.w  d1,$236(a5)
                subq.w  #1,$5C(a5)
                bne.s   loc_56858
                bset    #6,$21(a5)
                bra.s   loc_56860
; ---------------------------------------------------------------------------
loc_56858:                                              ; CODE XREF: Boss_ValkirieMovePattern2+134   j
                bpl.s   loc_56860
                move.w  #$FFFF,$5C(a5)
loc_56860:                                              ; CODE XREF: Boss_ValkirieMovePattern2+13C   j
                                        ; sub_5671A:loc_56858   j
                bsr.w   Boss_ValkirieUpdatePartPositions
                move.w  (dword_FFA900).w,d1
                add.w   $10(a5),d1
                move.w  $23C(a5),d2
                btst    #7,(byte_FFC9DE).w
                beq.s   loc_5687C
                bsr.w   Boss_ValkirieCalculateAngleToPlayer
loc_5687C:                                              ; CODE XREF: Boss_ValkirieMovePattern2+15C   j
                lea     (Math_SineTable).l,a1
                move.w  Math_QuarterSineTable-Math_SineTable(a1,d2.w),d0
                move.w  (a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                move.l  d0,d2
                move.l  d1,d3
                asl.l   #3,d2
                asl.l   #3,d3
                tst.l   d2
                bmi.s   loc_568AC
                add.l   d0,$1FC(a5)
                bmi.s   loc_568BC
                cmp.l   $1FC(a5),d2
                bpl.s   loc_568BC
                move.l  d2,$1FC(a5)
                bra.s   loc_568BC
; ---------------------------------------------------------------------------
loc_568AC:                                              ; CODE XREF: Boss_ValkirieMovePattern2+17E   j
                add.l   d0,$1FC(a5)
                bpl.s   loc_568BC
                cmp.l   $1FC(a5),d2
                bmi.s   loc_568BC
                move.l  d2,$1FC(a5)
loc_568BC:                                              ; CODE XREF: Boss_ValkirieMovePattern2+184   j
                                        ; Boss_ValkirieMovePattern2+18A   j
                tst.l   d3
                bmi.s   loc_568D2
                add.l   d1,$1F8(a5)
                bmi.s   locret_568E2
                cmp.l   $1F8(a5),d3
                bpl.s   locret_568E2
                move.l  d3,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_568D2:                                              ; CODE XREF: Boss_ValkirieMovePattern2+1A4   j
                add.l   d1,$1F8(a5)
                bpl.s   locret_568E2
                cmp.l   $1F8(a5),d3
                bmi.s   locret_568E2
                move.l  d3,$1F8(a5)
locret_568E2:                                           ; CODE XREF: Boss_ValkirieMovePattern2+96   j
                                        ; Boss_ValkirieMovePattern2+BE   j
                rts
; End of function Boss_ValkirieMovePattern2
; Sets part Y-velocity to $2C000 or $FFFD4000 based on flag in $23E
Boss_ValkirieSetPartVelocity1:
                tst.w   $23E(a5)                        ; was: sub_568E4
                beq.s   loc_568F4
                move.l  #$2C000,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_568F4:                                              ; CODE XREF: Boss_ValkirieSetPartVelocity1+4   j
                move.l  #$FFFD4000,$1F8(a5)
                rts
; End of function Boss_ValkirieSetPartVelocity1
; Clears flip flag, sets render depth, sets Y-velocity based on $23E flag
Boss_ValkirieSetPartVelocity2:
                bclr    #6,$21(a5)                      ; was: sub_568FE
                move.w  #4,$5C(a5)
                tst.w   $23E(a5)
                beq.s   loc_5691A
                move.l  #$12000,$1F8(a5)
                rts
; ---------------------------------------------------------------------------
loc_5691A:                                              ; CODE XREF: Boss_ValkirieSetPartVelocity2+10   j
                move.l  #$FFFEE000,$1F8(a5)
                rts
; End of function Boss_ValkirieSetPartVelocity2
; Updates the five-part group between Valkirie's two anchor objects
Boss_ValkirieUpdatePartPositions:                       ; CODE XREF: Boss_ValkirieMovePattern2+52   j  ; was: sub_56924
                                        ; Boss_ValkirieMovePattern2+7E   p
                moveq   #4,d7
                jmp     Boss_ValkirieUpdateAnchoredMetasprite
; End of function Boss_ValkirieUpdatePartPositions
; Calculates angle from boss to player position for targeting
Boss_ValkirieCalculateAngleToPlayer:                    ; CODE XREF: Boss_ValkirieMovePattern2+15E   p  ; was: sub_5692C
                move.w  (word_FFCB10).w,d0
                move.w  (word_FFCB14).w,d1
                sub.w   $1F0(a5),d0
                sub.w   $1F4(a5),d1
                jmp     (Math_CalculateDirectionIndex).l
; End of function Boss_ValkirieCalculateAngleToPlayer
; Updates boss palette colors
Boss_ValkirieUpdatePalette:                             ; CODE XREF: Boss_ValkirieIntroMove+3A   p  ; was: sub_56942
                                        ; Boss_MedusaAttackState1+3A   p
                btst    #0,(word_FFA000+1).w
                bne.s   loc_5695E
                move.w  (word_FFE3FA).w,(word_FFE37A).w
                move.w  (word_FFE3FC).w,(word_FFE37C).w
                move.w  (word_FFE3FE).w,(word_FFE37E).w
                rts
; ---------------------------------------------------------------------------
loc_5695E:                                              ; CODE XREF: Boss_ValkirieUpdatePalette+6   j
                move.w  word_56972(pc,d0.w),(word_FFE37A).w
                move.w  word_56972+2(pc,d0.w),(word_FFE37C).w
                move.w  word_56972+4(pc,d0.w),(word_FFE37E).w
                rts
; End of function Boss_ValkirieUpdatePalette
; ---------------------------------------------------------------------------
word_56972:     dc.w    $28A, $8EE, $CEE, $28A, $8EE, $CEE, $68
                                        ; DATA XREF: Boss_ValkirieUpdatePalette:loc_5695E   r
                                        ; Boss_ValkirieUpdatePalette+22   r
                dc.w    $4CE, $6EC, $A8, $6E, $8AC, $28A, $8EE
                dc.w    $CEE, $28A, $8EE, $CEE, $28A, $8EE, $CEE

; Attack state 1 handler
