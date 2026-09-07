Boss_DestroyerMK2CopyEntityAddress:                     ; CODE XREF: Boss_DestroyerMK2DefeatShake+16   p  ; was: sub_4BD50
                                        ; Enemy_RotateAndMoveWithAccel+E   p
                movea.w a5,a0
; End of function Boss_DestroyerMK2CopyEntityAddress
; Plays boss intro sound
Boss_DestroyerMK2PlayIntroSFX:                          ; CODE XREF: Boss_DestroyerMK2ShootPattern3+DA   p  ; was: sub_4BD52
                addi.w  #$20,d2                         ; ' '
                andi.w  #$1C0,d2
                lsr.w   #4,d2
                move.l  off_4BD6C(pc,d2.w),8(a0)
                lsr.w   #1,d2
                move.w  word_4BD8C(pc,d2.w),$E(a0)
                rts
; End of function Boss_DestroyerMK2PlayIntroSFX
; ---------------------------------------------------------------------------
off_4BD6C:      dc.l    word_EC2C8                      ; DATA XREF: Boss_DestroyerMK2PlayIntroSFX+A   r
                dc.l    word_EC2CE
                dc.l    word_EC2D4
                dc.l    word_EC2CE
                dc.l    word_EC2C8
                dc.l    word_EC2DA
                dc.l    word_EC2E0
                dc.l    word_EC2DA
word_4BD8C:     dc.w    $6300, $6300, $6300, $6B00, $6300, $6B00, $6300, $6300, $838, 0, $F706, $6728, $838, 5, $F706, $670C
                                        ; DATA XREF: Boss_DestroyerMK2PlayIntroSFX+12   r

; Updates weapon cooldown timers
Boss_UpdateMultipleWeaponTimers:
                tst.w   (word_FFC804).w                 ; was: sub_4BDAC
                bne.s   loc_4BDB8
                move.w  #2,(word_FFC804).w
loc_4BDB8:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+4   j
                btst    #6,(word_FFF706).w
                beq.s   loc_4BDCC
                tst.w   (word_FFC7A4).w
                bne.s   loc_4BDCC
                move.w  #2,(word_FFC7A4).w
loc_4BDCC:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+12   j
                                        ; Boss_UpdateMultipleWeaponTimers+18   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4BDFC
                btst    #5,(word_FFF706).w
                beq.s   loc_4BDE8
                tst.w   (word_FFC8C4).w
                bne.s   loc_4BDE8
                move.w  #2,(word_FFC8C4).w
loc_4BDE8:                                              ; CODE XREF: Boss_UpdateMultipleWeaponTimers+2E   j
                                        ; Boss_UpdateMultipleWeaponTimers+34   j
                btst    #6,(word_FFF706).w
                beq.s   locret_4BDFC
                tst.w   (word_FFC864).w
                bne.s   locret_4BDFC
                move.w  #2,(word_FFC864).w
locret_4BDFC:                                           ; CODE XREF: Boss_UpdateMultipleWeaponTimers+26   j
                                        ; Boss_UpdateMultipleWeaponTimers+42   j
                rts
; End of function Boss_UpdateMultipleWeaponTimers
; Boss intro roar sound
Boss_DestroyerMK2IntroRoar:                             ; CODE XREF: Boss_DestroyerMK2Main+8   p  ; was: sub_4BDFE
                lea     (word_FFE480).w,a0
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                move.w  #$27,d7                         ; '''
loc_4BE0C:                                              ; CODE XREF: Boss_DestroyerMK2IntroRoar+12   j
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,loc_4BE0C
                rts
; End of function Boss_DestroyerMK2IntroRoar
; Debris projectile handler
Projectile_DestroyerMK2DebrisMain:                      ; CODE XREF: Effect_DestroyerMK2Explosion2   p  ; was: sub_4BE16
                                        ; DATA XREF: Effect_DestroyerMK2Explosion2   o
                jsr     (Gfx_UpdatePaletteFade).l
                jsr     (Effect_PlayRandomExplosionSound).l
                move.w  #2,(word_FFA014).w
                move.w  #4,(word_FFA010).w
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4BE98
                jsr     (Sprite_InitializeProperties).l
                clr.b   $20(a0)
                move.w  #6,$18(a0)
                move.w  (dword_FFFF08+2).w,$1A(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$1F,d0
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$24,d0                         ; '$'
                subi.w  #$24,d1                         ; '$'
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #7,d0
                add.w   d0,d0
                add.w   d0,d0
                move.l  off_4BE9A(pc,d0.w),8(a0)
                ori.w   #$8000,$E(a0)
locret_4BE98:                                           ; CODE XREF: Projectile_DestroyerMK2DebrisMain+1E   j
                rts
; End of function Projectile_DestroyerMK2DebrisMain
; ---------------------------------------------------------------------------
off_4BE9A:      dc.l    off_E953C                       ; DATA XREF: Projectile_DestroyerMK2DebrisMain+76   r
                dc.l    off_E95A4
                dc.l    off_E9560
                dc.l    off_E95C0
                dc.l    off_E9584
                dc.l    off_E95DC
                dc.l    off_E9584
                dc.l    off_E9604

nullsub_108:                                            ; CODE XREF: Boss_DestroyerMK2ComponentCheckDefeat+4   j
                                        ; Boss_DestroyerMK2ComponentCheckDefeat+14   j
                rts
; End of function nullsub_108

; Main handler for Bugmax boss
Boss_BugmaxMain:                                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BEBC
                tst.w   4(a5)
                beq.w   Boss_BugmaxMainDispatch
                lea     (word_3E3C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$58(a5)
                move.w  $5E(a5),d0
                lea     off_4BEE8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxMain
; ---------------------------------------------------------------------------
off_4BEE8:      dc.w    Boss_BugmaxUpdateLegs-*         ; DATA XREF: Boss_BugmaxMain+24   o
                dc.w    Boss_BugmaxRotateParts1-*
                dc.w    Boss_BugmaxRotateParts2-*
                dc.w    Boss_BugmaxCalculatePerspective-*

; Updates all leg positions
Boss_BugmaxUpdateLegs:                                  ; DATA XREF: ROM:off_4BEE8   o  ; was: sub_4BEF0
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$128,d0
                move.w  d0,(dword_FFA90C).w
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4BF2E:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+58   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4BF2E
                move.w  $10(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4BF58:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+6E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_4BF58
                move.w  -$C(a0),d4
                move.w  -2(a0),d5
                move.w  d4,d0
                move.w  (dword_FFC694).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                cmpi.w  #$1C0,d2
                bcs.s   loc_4BF8A
                move.w  #$1C0,d2
                bra.s   loc_4BF94
; ---------------------------------------------------------------------------
loc_4BF8A:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+92   j
                cmpi.w  #$140,d2
                bhi.s   loc_4BF94
                move.w  #$140,d2
loc_4BF94:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+98   j
                                        ; Boss_BugmaxUpdateLegs+9E   j
                move.w  d2,(word_FFC6CC).w
                move.w  d5,d0
                move.w  (dword_FFC6F4).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                cmpi.w  #$C0,d2
                bcs.s   loc_4BFB8
                move.w  #$C0,d2
                bra.s   loc_4BFC2
; ---------------------------------------------------------------------------
loc_4BFB8:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+C0   j
                cmpi.w  #$40,d2                         ; '@'
                bhi.s   loc_4BFC2
                move.w  #$40,d2                         ; '@'
loc_4BFC2:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+C6   j
                                        ; Boss_BugmaxUpdateLegs+CC   j
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4BFD0:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+EE   j
                move.w  #3,d6
loc_4BFD4:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+EA   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4BFD4
                dbf     d7,loc_4BFD0
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
; Updates leg segment positions in loop
Boss_BugmaxLegPositionLoop:                             ; CODE XREF: Boss_BugmaxUpdateLegs+110   j  ; was: loc_4BFF2
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,Boss_BugmaxLegPositionLoop
                bra.w   loc_4C392
; End of function Boss_BugmaxUpdateLegs
; Rotation pattern 1 for parts
Boss_BugmaxRotateParts1:                                ; DATA XREF: ROM:0004BEEA   o  ; was: sub_4C008
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1F0,(dword_FFA90C).w
                movea.w #(word_FFC860-M68K_RAM),a1
                movea.w #(word_FFC800-M68K_RAM),a0
                move.w  #3,d7
; Rotates segments using polar coordinates
Boss_BugmaxRotateSegments:                              ; CODE XREF: Boss_BugmaxRotateParts1+4C   j  ; was: loc_4C02A
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a1),d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     -$60(a0),a0
                dbf     d7,Boss_BugmaxRotateSegments
                movea.w a5,a0
                move.l  (dword_FFC6F0).w,d3
                move.l  (dword_FFC6F4).w,d4
                move.w  (word_FFC730).w,d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                bra.w   loc_4C392
; End of function Boss_BugmaxRotateParts1
; Rotation pattern 2 for parts
Boss_BugmaxRotateParts2:                                ; DATA XREF: ROM:0004BEEC   o  ; was: sub_4C09A
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1F0,(dword_FFA90C).w
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4C0D2:                                              ; CODE XREF: Boss_BugmaxRotateParts2+5A   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a0),d2
                move.w  $4C(a0),d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C0D2
                bra.w   loc_4C22C
; End of function Boss_BugmaxRotateParts2
; Calculates perspective distortion for Bugmax
Boss_BugmaxCalculatePerspective:                        ; DATA XREF: ROM:0004BEEE   o  ; was: sub_4C0FC
                move.w  #$190,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  #$60,d0                         ; '`'
                move.w  #$5F,d7                         ; '_'
                movea.w #(byte_FF9520-M68K_RAM),a0
loc_4C114:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1C   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_4C114
                tst.w   (dword_FF9400).w
                beq.w   loc_4C1E0
                tst.w   (dword_FF9400).w
                bmi.w   loc_4C184
                move.w  #$204,d0
                sub.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                moveq   #0,d2
                move.w  #$400,d2
                move.w  (dword_FF9400).w,d0
                divu.w  d0,d2
                swap    d2
                clr.w   d2
                lsr.l   #4,d2
                subi.l  #$10000,d2
                movea.w #(byte_FF9520-M68K_RAM),a0
                movea.w a0,a1
                move.w  $14(a5),d0
                subi.w  #8,d0
                subi.w  #$A0,d0
                andi.w  #$1FE,d0
                adda.w  d0,a0
                move.l  (dword_FFA90C).w,d1
                move.w  (dword_FF9400).w,d7
loc_4C170:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+82   j
                cmpa.w  a1,a0
                beq.w   loc_4C1E0
                sub.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,-(a0)
                dbf     d7,loc_4C170
                bra.s   loc_4C1E0
; ---------------------------------------------------------------------------
loc_4C184:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+2C   j
                move.w  #$22C,d0
                sub.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                moveq   #0,d2
                move.w  #$400,d2
                move.w  (dword_FF9400).w,d0
                neg.w   d0
                divu.w  d0,d2
                swap    d2
                clr.w   d2
                lsr.l   #4,d2
                subi.l  #$10000,d2
                movea.w #(byte_FF9520-M68K_RAM),a0
                movea.w a0,a1
                adda.w  #$C0,a1
                move.w  $14(a5),d0
                subi.w  #8,d0
                subi.w  #$A0,d0
                andi.w  #$1FE,d0
                adda.w  d0,a0
                move.l  (dword_FFA90C).w,d1
                move.w  (dword_FF9400).w,d7
                neg.w   d7
loc_4C1D0:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+E0   j
                cmpa.w  a1,a0
                beq.s   loc_4C1E0
                add.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,(a0)+
                dbf     d7,loc_4C1D0
loc_4C1E0:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+24   j
                                        ; Boss_BugmaxCalculatePerspective+76   j
                bsr.w   Boss_BugmaxPerspectiveHelper
                movea.w #(word_FFC680-M68K_RAM),a0
                cmpi.w  #$10,(a0)
                bne.w   loc_4C392
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4C20E:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+12C   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C20E
loc_4C22C:                                              ; CODE XREF: Boss_BugmaxRotateParts2+5E   j
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4C242:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+14C   j
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d7,loc_4C242
                move.l  -$18(a0),d5
                move.l  -4(a0),d6
                moveq   #0,d3
                moveq   #0,d4
                move.w  d5,d4
                swap    d5
                move.w  d5,d3
                sub.w   (dword_FFA900).w,d3
                swap    d3
                swap    d4
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  (dword_FF9414+2).w,d0
                addi.w  #$80,d0
                move.w  $50(a0),d2
                bsr.w   loc_4DB88
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  d2,(word_FFC6CC).w
                moveq   #0,d3
                moveq   #0,d4
                move.w  d6,d4
                swap    d6
                move.w  d6,d3
                sub.w   (dword_FFA900).w,d3
                swap    d3
                swap    d4
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  (dword_FF9414+2).w,d0
                subi.w  #$80,d0
                move.w  $50(a0),d2
                bsr.w   loc_4DB88
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4C2D6:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1E8   j
                move.w  #3,d6
loc_4C2DA:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1E4   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4C2DA
                dbf     d7,loc_4C2D6
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
loc_4C2F8:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+20A   j
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,loc_4C2F8
                move.w  (word_FFC6CC).w,d0
                add.w   d0,d0
                lea     (word_FF9680).w,a0
                move.w  #7,d7
loc_4C318:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+22A   j
                move.w  #7,d6
loc_4C31C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+226   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4C31C
                dbf     d7,loc_4C318
                movea.w #(word_FFC8C0-M68K_RAM),a0
                lea     (word_FF9680).w,a1
                move.w  #$10,d6
                move.w  #7,d7
loc_4C33A:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+24C   j
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4C33A
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
                move.w  (dword_FF9410+2).w,d2
                movea.w #(word_FFC680-M68K_RAM),a1
loc_4C35C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+28E   j
                tst.b   (dword_FF9418+2).w
                bne.s   loc_4C368
                move.w  $4C(a0),d0
                bra.s   loc_4C36C
; ---------------------------------------------------------------------------
loc_4C368:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+264   j
                move.w  (dword_FF9414).w,d0
loc_4C36C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+26A   j
                add.w   $4E(a0),d0
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C35C
                bsr.w   Boss_BugmaxToggleMouthSprite
loc_4C392:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+114   j
                                        ; Boss_BugmaxRotateParts1+8E   j
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_BugmaxMainDispatch
                btst    #1,(byte_FF80EC).w
                bne.w   Boss_BugmaxMainDispatch
                tst.w   (word_FF8200).w
                bne.s   Boss_BugmaxMainDispatch
                move.b  #2,(byte_FF80EC).w
loc_4C3B0:
                bset    #0,$5A(a5)
                move.w  #$56,4(a5)                      ; 'V'
                move.w  #1,(dword_FF9428+2).w
                bset    #0,(byte_FFA272).w
                bra.w   *+4
; ---------------------------------------------------------------------------
; Main state dispatcher for Bugmax boss
Boss_BugmaxMainDispatch:                                ; CODE XREF: Boss_BugmaxMain+4   j  ; was: loc_4C3CC
                                        ; Boss_BugmaxCalculatePerspective+29C   j
                move.w  4(a5),d0
                lea     off_4C3D8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxCalculatePerspective
; ---------------------------------------------------------------------------
off_4C3D8:      dc.w    Boss_BugmaxInit-*               ; DATA XREF: Boss_BugmaxCalculatePerspective+2D4   o
                dc.w    Boss_BugmaxShakeInit-*
                dc.w    Boss_BugmaxShaking-*
                dc.w    Boss_BugmaxVictoryCheck-*
                dc.w    Boss_BugmaxDefeatStart-*
                dc.w    Boss_BugmaxDefeatRise-*
                dc.w    Boss_BugmaxDefeatExplode-*
                dc.w    Boss_BugmaxSpinInit-*
                dc.w    Boss_BugmaxSpinning-*
                dc.w    Boss_BugmaxSpinReverse-*
                dc.w    Boss_BugmaxSpinSlowdown-*
                dc.w    Boss_BugmaxJumpPrepare-*
                dc.w    Boss_BugmaxJumpInit-*
                dc.w    Boss_BugmaxRotateMouthOpen-*
                dc.w    Boss_BugmaxRotateMouthClose-*
                dc.w    Boss_BugmaxLoadOpenMouthGfx-*
                dc.w    Boss_BugmaxLoadClosedMouthGfx-*
                dc.w    Boss_BugmaxMovementPhase1-*
                dc.w    Boss_BugmaxAttackPatternSelect-*
                dc.w    Boss_BugmaxEnterAttackStance1-*
                dc.w    Boss_BugmaxWaitAttackReady-*
                dc.w    Boss_BugmaxMoveAndCheckFlag-*
                dc.w    Boss_BugmaxProjectileAttack-*
                dc.w    Boss_BugmaxDistanceTrackLoop-*
                dc.w    Boss_BugmaxAttackCountdown-*
                dc.w    Boss_BugmaxPositionForHorizontal-*
                dc.w    Boss_BugmaxHorizontalMoveWait-*
                dc.w    Boss_BugmaxPrepareSpecialAttack-*
                dc.w    Boss_BugmaxAngleCalculateAttack-*
                dc.w    Boss_BugmaxSpecialAttackUpdate-*
                dc.w    Boss_BugmaxSpecialAttackWait-*
                dc.w    Boss_BugmaxSpecialAttackDecrement-*
                dc.w    Boss_BugmaxResetSpecialAttack-*
                dc.w    Boss_BugmaxSpecialAttackFinish-*
                dc.w    Boss_BugmaxEnterAttackStance2-*
                dc.w    Boss_BugmaxWaitCounter32-*
                dc.w    Boss_BugmaxSmartPositioning-*
                dc.w    Boss_BugmaxDistanceChasePlayer-*
                dc.w    Boss_BugmaxAttackDelay-*
                dc.w    Boss_BugmaxProjectileVerticalAttack-*
                dc.w    Boss_BugmaxHorizontalAttackLoop-*
                dc.w    Boss_BugmaxTimedStateTransition-*
                dc.w    Boss_BugmaxResetState-*
                dc.w    Boss_BugmaxLandCheck-*
                dc.w    Boss_BugmaxLandFlash-*
                dc.w    Boss_BugmaxScatterParts-*
                dc.w    Boss_BugmaxFallOffScreen-*
                dc.w    Boss_BugmaxWaitTimer-*
                dc.w    Boss_BugmaxRiseUp-*
                dc.w    Boss_BugmaxFallDown-*

; Initializes Bugmax with 7 parts
Boss_BugmaxInit:                                        ; DATA XREF: ROM:off_4C3D8   o  ; was: sub_4C43C
                tst.b   (word_FFF720).w
                bmi.w   locret_4C5BC
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #$300,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                clr.w   $5E(a5)
                move.w  #$604,d0
                move.w  d0,$5C(a5)
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$C8,$14(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #word_ECB94,8(a5)
                move.w  #$300,$E(a5)
                eori.w  #$800,$E(a5)
                move.w  #$CD80,2(a5)
                move.w  #$80,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.b  #$D0,$21(a5)
                move.w  #4,$24(a5)
                move.w  #$40,$50(a5)                    ; '@'
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.l  #word_ECB88,8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.l  #$F010F808,$28(a0)
                move.b  #$D0,$21(a0)
                move.b  #$80,$23(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$180,$4C(a0)
                move.w  #$50,$50(a0)                    ; 'P'
                move.w  #4,$24(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                moveq   #0,d6
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
loc_4C51E:                                              ; CODE XREF: Boss_BugmaxInit+144   j
                move.w  #$10,(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #4,$24(a0)
                move.b  $20(a5),$20(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F010,$28(a0)
                move.b  #$D0,$21(a0)
                move.w  #$80,$26(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$80,$4C(a0)
                lea     stru_4C5BE(pc),a1
                nop
                move.w  (a1,d6.w),$50(a0)
                move.l  4(a1,d6.w),8(a0)
                addq.w  #8,d6
                lea     $60(a0),a0
                dbf     d7,loc_4C51E
                bsr.w   Boss_BugmaxLoadGfx
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$128,d0
                move.w  d0,(dword_FFA90C).w
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4C5AC:                                              ; CODE XREF: Boss_BugmaxInit+17C   j
                move.w  #3,d6
; Clears position buffer with loop
Boss_BugmaxClearBuffer:                                 ; CODE XREF: Boss_BugmaxInit+178   j  ; was: loc_4C5B0
                move.w  #$80,(a0)+
                dbf     d6,Boss_BugmaxClearBuffer
                dbf     d7,loc_4C5AC
locret_4C5BC:                                           ; CODE XREF: Boss_BugmaxInit+4   j
                rts
; End of function Boss_BugmaxInit
; ---------------------------------------------------------------------------
stru_4C5BE:     dc.w    $5C                             ; field_0
                                        ; DATA XREF: Boss_BugmaxInit+12C   o
                dc.w    $FF                             ; field_2
                dc.l    word_ECB9A                      ; field_4
                dc.w    $40                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA0                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA0                      ; field_4
                dc.w    $2C                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA6                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA6                      ; field_4

; Loads Bugmax graphics
Boss_BugmaxLoadGfx:                                     ; CODE XREF: Boss_BugmaxInit+148   p  ; was: sub_4C5E6
                lea     word_4C5F2(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxLoadGfx
; ---------------------------------------------------------------------------
word_4C5F2:     dc.w    $6330, $2000, $104, $BEBF, $C2C3, $C6C7, $CACB, $CF
                                        ; DATA XREF: Boss_BugmaxLoadGfx   o

; Initializes shake animation
Boss_BugmaxShakeInit:                                   ; DATA XREF: ROM:0004C3DA   o  ; was: sub_4C602
                move.w  $5C(a5),$4A(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxShakeInit
; Shake animation state
Boss_BugmaxShaking:                                     ; DATA XREF: ROM:0004C3DC   o  ; was: sub_4C614
                subq.w  #1,$48(a5)
                beq.s   Boss_BugmaxShakeEnd
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                andi.w  #2,d7
                beq.s   loc_4C62C
                addi.w  #$60,d0                         ; '`'
loc_4C62C:                                              ; CODE XREF: Boss_BugmaxShaking+12   j
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
; Ends shaking and advances state
Boss_BugmaxShakeEnd:                                    ; CODE XREF: Boss_BugmaxShaking+4   j  ; was: loc_4C632
                move.w  $4A(a5),$5C(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxShaking
; Checks victory condition
Boss_BugmaxVictoryCheck:                                ; DATA XREF: ROM:0004C3DE   o  ; was: sub_4C644
                bsr.w   Boss_BugmaxClampLegPositions
                subq.w  #1,$48(a5)
                bne.s   locret_4C65C
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
locret_4C65C:                                           ; CODE XREF: Boss_BugmaxVictoryCheck+8   j
                rts
; End of function Boss_BugmaxVictoryCheck
; Starts defeat sequence
Boss_BugmaxDefeatStart:                                 ; DATA XREF: ROM:0004C3E0   o  ; was: sub_4C65E
                bsr.w   Boss_BugmaxClampLegPositions
                tst.w   (word_FF80C2).w
                bne.s   locret_4C680
                move.b  #$D0,$21(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (dword_FF9428+2).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
locret_4C680:                                           ; CODE XREF: Boss_BugmaxDefeatStart+8   j
                rts
; End of function Boss_BugmaxDefeatStart
; Boss rises during defeat
Boss_BugmaxDefeatRise:                                  ; DATA XREF: ROM:0004C3E2   o  ; was: sub_4C682
                bsr.w   Boss_BugmaxUpdateAllParts
                bsr.w   Boss_BugmaxClampLegPositions
                cmpi.w  #$6800,(word_FF8200).w
                bhi.s   locret_4C6A0
                addq.w  #2,4(a5)
                move.w  #3,d0
                bsr.w   Boss_BugmaxSpawnDebris
                bra.s   Boss_BugmaxDMADeathTiles
; ---------------------------------------------------------------------------
locret_4C6A0:                                           ; CODE XREF: Boss_BugmaxDefeatRise+E   j
                rts
; ---------------------------------------------------------------------------
; DMA transfers death animation tiles
Boss_BugmaxDMADeathTiles:                               ; CODE XREF: Boss_BugmaxDefeatRise+1C   j  ; was: loc_4C6A2
                lea     word_4C6AE(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxDefeatRise
; ---------------------------------------------------------------------------
word_4C6AE:     dc.w    $6330, $2000, $104, $BEBF, $C0C3, $C4C7, $C8CB, $CF
                                        ; DATA XREF: Boss_BugmaxDefeatRise:loc_4C6A2   o

; Spawns debris during defeat
Boss_BugmaxSpawnDebris:                                 ; CODE XREF: Boss_BugmaxDefeatRise+18   p  ; was: sub_4C6BE
                                        ; Boss_BugmaxDefeatExplode+20   p
                move.w  d0,d7
                subq.w  #1,d7
                clr.w   d6
; Spawns debris objects in loop
Boss_BugmaxSpawnDebrisLoop:                             ; CODE XREF: Boss_BugmaxSpawnDebris+38   j  ; was: loc_4C6C4
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4C6FA
                lea     word_4C70A(pc),a2
                nop
                move.w  (a2,d6.w),d0
                move.w  $E(a2,d6.w),d1
                move.w  $1C(a2,d6.w),d2
                movea.w word_4C6FC(pc,d6.w),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                jsr     (Projectile_InitDebrisObject).l
                addq.w  #2,d6
                dbf     d7,Boss_BugmaxSpawnDebrisLoop
locret_4C6FA:                                           ; CODE XREF: Boss_BugmaxSpawnDebris+C   j
                rts
; End of function Boss_BugmaxSpawnDebris
; ---------------------------------------------------------------------------
word_4C6FC:     dc.w    $C620, $C6E0, $C740, $C7A0, $C680, $C800, $C860
                                        ; DATA XREF: Boss_BugmaxSpawnDebris+20   r
word_4C70A:     dc.w    $40, $40, $40, $40, $28, $28, $18
                                        ; DATA XREF: Boss_BugmaxSpawnDebris+E   o
                dc.w    $20, $20, $20, $10, 8, 8, 4
                dc.w    $10, $10, $10, $10, 8, 8, 8

; Explosion during defeat
Boss_BugmaxDefeatExplode:                               ; DATA XREF: ROM:0004C3E4   o  ; was: sub_4C734
                bsr.w   Boss_BugmaxUpdateAllParts
                bsr.w   Boss_BugmaxClampLegPositions
                cmpi.w  #$6000,(word_FF8200).w
                bhi.s   locret_4C75A
                clr.l   $18(a5)
                addq.w  #2,$5E(a5)
                addq.w  #2,4(a5)
                move.w  #7,d0
                bsr.w   Boss_BugmaxSpawnDebris
                bra.s   Boss_BugmaxDMAExplodeTiles
; ---------------------------------------------------------------------------
locret_4C75A:                                           ; CODE XREF: Boss_BugmaxDefeatExplode+E   j
                rts
; ---------------------------------------------------------------------------
; DMA transfers explosion tiles
Boss_BugmaxDMAExplodeTiles:                             ; CODE XREF: Boss_BugmaxDefeatExplode+24   j  ; was: loc_4C75C
                lea     word_4C768(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxDefeatExplode
; ---------------------------------------------------------------------------
word_4C768:     dc.w    $6330, $2000, $104, $BCBD, $C1, $C5, $C9, $CD
                                        ; DATA XREF: Boss_BugmaxDefeatExplode:loc_4C75C   o

; Initializes spin attack
Boss_BugmaxSpinInit:                                    ; DATA XREF: ROM:0004C3E6   o  ; was: sub_4C778
                move.w  (word_FFC72C).w,$4C(a5)
                move.w  #$118,$4A(a5)
                move.w  #$80,(word_FFC8AC).w
                bsr.w   Boss_BugmaxSyncLegRotation
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxSpinInit
; Spinning attack state
Boss_BugmaxSpinning:                                    ; DATA XREF: ROM:0004C3E8   o  ; was: sub_4C794
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxUpdateLegSprite
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   $4A(a5),d0
                move.w  d0,(dword_FFC874).w
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4C7DA
                addq.w  #1,$48(a5)
                cmpi.w  #8,$48(a5)
                bcc.s   loc_4C7D0
                move.w  $48(a5),d0
                neg.w   d0
                bsr.w   Boss_BugmaxSetLegOffsets
                rts
; ---------------------------------------------------------------------------
loc_4C7D0:                                              ; CODE XREF: Boss_BugmaxSpinning+2E   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4C7DA:                                           ; CODE XREF: Boss_BugmaxSpinning+22   j
                rts
; End of function Boss_BugmaxSpinning
; Sets leg rotation offsets
Boss_BugmaxSetLegOffsets:                               ; CODE XREF: Boss_BugmaxSpinning+36   p  ; was: sub_4C7DC
                                        ; Boss_BugmaxSpinReverse+2A   p
                move.w  #6,d7
                moveq   #0,d6
                lea     word_4C7F8(pc),a1
                nop
; Sets leg angle offsets in loop
Boss_BugmaxSetLegOffsetsLoop:                           ; CODE XREF: Boss_BugmaxSetLegOffsets+16   j  ; was: loc_4C7E8
                movea.w (a1)+,a0
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                dbf     d7,Boss_BugmaxSetLegOffsetsLoop
                rts
; End of function Boss_BugmaxSetLegOffsets
; ---------------------------------------------------------------------------
word_4C7F8:     dc.w    $C860, $C800, $C7A0, $C740, $C6E0, $C620, $C680
                                        ; DATA XREF: Boss_BugmaxSetLegOffsets+6   o
                                        ; sub_4C806   o

; Synchronizes leg rotations
Boss_BugmaxSyncLegRotation:                             ; CODE XREF: Boss_BugmaxSpinInit+12   p  ; was: sub_4C806
                lea     word_4C7F8(pc),a1
                movea.w (a1)+,a0
                move.w  $4C(a0),d0
                move.w  #5,d7
loc_4C814:                                              ; CODE XREF: Boss_BugmaxSyncLegRotation+14   j
                movea.w (a1)+,a0
                move.w  d0,$4C(a0)
                dbf     d7,loc_4C814
                subi.w  #$100,(word_FFC6CC).w
                andi.w  #$1FF,(word_FFC6CC).w
                rts
; End of function Boss_BugmaxSyncLegRotation
; Updates leg sprite based on angle
Boss_BugmaxUpdateLegSprite:                             ; CODE XREF: Boss_BugmaxSpinning+4   p  ; was: sub_4C82C
                                        ; Boss_BugmaxSpinReverse+4   p
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                andi.w  #$F7FF,$E(a0)
                andi.w  #$EFFF,$E(a0)
                cmpi.w  #$160,d0
                bcs.s   loc_4C874
                cmpi.w  #$170,d0
                bhi.s   loc_4C864
                ori.w   #$800,$E(a0)
                move.l  #word_ECB7C,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4C864:                                              ; CODE XREF: Boss_BugmaxUpdateLegSprite+26   j
                ori.w   #$800,$E(a0)
                move.l  #word_ECB88,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4C874:                                              ; CODE XREF: Boss_BugmaxUpdateLegSprite+20   j
                ori.w   #$800,$E(a0)
                move.l  #word_ECB6A,8(a0)
                rts
; End of function Boss_BugmaxUpdateLegSprite
; Reverse spin attack
Boss_BugmaxSpinReverse:                                 ; DATA XREF: ROM:0004C3EA   o  ; was: sub_4C884
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxUpdateLegSprite
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   $4A(a5),d0
                move.w  d0,(dword_FFC874).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                subq.w  #1,d0
                addi.w  #8,d0
                neg.w   d0
                bsr.w   Boss_BugmaxSetLegOffsets
                subq.w  #1,$48(a5)
                bne.s   locret_4C8C2
                move.w  #$FFF8,$48(a5)
                addq.w  #2,4(a5)
locret_4C8C2:                                           ; CODE XREF: Boss_BugmaxSpinReverse+32   j
                rts
; End of function Boss_BugmaxSpinReverse
; Slows down spin attack
Boss_BugmaxSpinSlowdown:                                ; DATA XREF: ROM:0004C3EC   o  ; was: sub_4C8C4
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLegOffsets
                subq.w  #1,$48(a5)
                cmpi.w  #$FFEC,$48(a5)
                bne.s   locret_4C8DC
                addq.w  #2,4(a5)
locret_4C8DC:                                           ; CODE XREF: Boss_BugmaxSpinSlowdown+12   j
                rts
; End of function Boss_BugmaxSpinSlowdown
; Prepares jump attack
Boss_BugmaxJumpPrepare:                                 ; DATA XREF: ROM:0004C3EE   o  ; was: sub_4C8DE
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLegOffsets
                addq.w  #1,$48(a5)
                bne.s   locret_4C90A
                move.l  #$FFFA0000,(dword_FFC87C).w
                move.l  #$FFFD0000,(dword_FFC878).w
                addq.w  #2,4(a5)
                move.b  #$E4,d0
                jsr     (Sound_PlaySFX).l
locret_4C90A:                                           ; CODE XREF: Boss_BugmaxJumpPrepare+C   j
                rts
; End of function Boss_BugmaxJumpPrepare
; Adjusts angle based on horizontal scroll
Boss_BugmaxAdjustAngleByScroll:                         ; CODE XREF: Boss_BugmaxRotateMouthClose+8   p  ; was: sub_4C90C
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                btst    #0,d7
                bne.s   loc_4C920
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4C920:                                              ; CODE XREF: Boss_BugmaxAdjustAngleByScroll+C   j
                cmpi.w  #$410,(dword_FFA900).w
                bcc.s   loc_4C92E
                subi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
loc_4C92E:                                              ; CODE XREF: Boss_BugmaxAdjustAngleByScroll+1A   j
                addi.w  #$80,d0
                move.w  d0,$5C(a5)
                rts
; End of function Boss_BugmaxAdjustAngleByScroll
; DMA transfer wrapper for Bugmax graphics
Gfx_BugmaxDMATransferWrapper:                           ; CODE XREF: Boss_BugmaxRotateMouthClose+26   p  ; was: sub_4C938
                lea     word_4C944(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_BugmaxDMATransferWrapper
; ---------------------------------------------------------------------------
word_4C944:     dc.w    $6330, $2000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_BugmaxDMATransferWrapper   o

; Initializes jump attack phase
Boss_BugmaxJumpInit:                                    ; DATA XREF: ROM:0004C3F0   o  ; was: sub_4C954
                addq.w  #2,4(a5)
                move.l  (dword_FFC878).w,d0
                move.l  d0,$18(a5)
                move.l  (dword_FFC87C).w,d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                move.w  #$100,(dword_FF9414+2).w
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #word_ECB52,8(a5)
                move.w  #$300,$E(a5)
                move.w  #$CD80,2(a5)
                move.w  #$80,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #0,$4C(a5)
                move.w  #0,$4E(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  #word_ECB28,8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #$80,$26(a0)
                move.l  #$F808F808,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #$80,$23(a0)
                move.w  #$1C,$24(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$180,$4C(a0)
                move.w  #0,$4E(a0)
                move.w  #$40,$50(a0)                    ; '@'
                moveq   #0,d6
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
loc_4CA12:                                              ; CODE XREF: Boss_BugmaxJumpInit+110   j
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #$80,$26(a0)
                move.l  #$F808F808,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.b  $20(a5),$20(a0)
                move.w  #$80,$4C(a0)
                lea     stru_4CB06(pc),a1
                nop
                move.w  (a1,d6.w),$50(a0)
                move.w  2(a1,d6.w),$4E(a0)
                move.l  4(a1,d6.w),8(a0)
                addq.w  #8,d6
                lea     $60(a0),a0
                dbf     d7,loc_4CA12
                moveq   #0,d6
                lea     off_4CB2E(pc),a1
                nop
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4CA78:                                              ; CODE XREF: Boss_BugmaxJumpInit+146   j
                move.w  #$10,(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.b  $20(a5),$20(a0)
                move.l  (a1,d6.w),8(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4CA78
                move.l  #$FF01FF01,-$34(a0)
                move.w  #$10,-$3A(a0)
                move.b  #$40,-$3F(a0)                   ; '@'
                move.w  #$20,(dword_FF9410).w           ; ' '
                addq.w  #2,$5E(a5)
                move.w  $5C(a5),$4A(a5)
                move.w  #$180,(word_FFC6CC).w
                move.w  #$80,(word_FFC72C).w
                move.w  #$A0,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4CADA:                                              ; CODE XREF: Boss_BugmaxJumpInit+190   j
                move.w  #3,d6
loc_4CADE:                                              ; CODE XREF: Boss_BugmaxJumpInit+18C   j
                move.w  d0,(a0)+
                dbf     d6,loc_4CADE
                dbf     d7,loc_4CADA
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4CAFE:                                              ; CODE XREF: Boss_BugmaxJumpInit+1AC   j
                move.l  d0,(a0)+
                dbf     d7,loc_4CAFE
                rts
; End of function Boss_BugmaxJumpInit
; ---------------------------------------------------------------------------
stru_4CB06:     dc.w    $5C                             ; field_0
                                        ; DATA XREF: Boss_BugmaxJumpInit+F2   o
                dc.w    0                               ; field_2
                dc.l    word_ECB58                      ; field_4
                dc.w    $40                             ; field_0
                dc.w    $FFDC                           ; field_2
                dc.l    word_ECB5E                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    $FFD4                           ; field_2
                dc.l    word_ECB5E                      ; field_4
                dc.w    $2C                             ; field_0
                dc.w    $FFC8                           ; field_2
                dc.l    word_ECB64                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    $FFB8                           ; field_2
                dc.l    word_ECB64                      ; field_4
off_4CB2E:      dc.l    word_ECB46                      ; DATA XREF: Boss_BugmaxJumpInit+116   o
                dc.l    word_ECB46
                dc.l    word_ECB46
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C

; Rotates mouth opening animation
Boss_BugmaxRotateMouthOpen:                             ; DATA XREF: ROM:0004C3F2   o  ; was: sub_4CB4E
                addi.l  #$1800,$1C(a5)
                addi.w  #$10,(dword_FF9414+2).w
                andi.w  #$1F0,(dword_FF9414+2).w
                cmpi.w  #$140,(dword_FF9414+2).w
                bne.w   locret_4CB70
                addq.w  #2,4(a5)
locret_4CB70:                                           ; CODE XREF: Boss_BugmaxRotateMouthOpen+1A   j
                rts
; End of function Boss_BugmaxRotateMouthOpen
; Rotates mouth closing and inits battle
Boss_BugmaxRotateMouthClose:                            ; DATA XREF: ROM:0004C3F4   o  ; was: sub_4CB72
                addi.l  #$1800,$1C(a5)
                bsr.w   Boss_BugmaxAdjustAngleByScroll
                subi.w  #8,(dword_FF9414+2).w
                andi.w  #$1F8,(dword_FF9414+2).w
                cmpi.w  #$180,(dword_FF9414+2).w
                bne.w   locret_4CBFC
                addq.w  #2,4(a5)
                bsr.w   Gfx_BugmaxDMATransferWrapper
                move.b  #$D0,$21(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.b  #$D0,$21(a0)
                move.w  #$60,$50(a0)                    ; '`'
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #2,d7
loc_4CBBA:                                              ; CODE XREF: Boss_BugmaxRotateMouthClose+52   j
                move.b  #$D0,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4CBBA
                move.w  #$10,$48(a5)
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #2,(byte_FFA95B).w
                move.w  #$E,(word_FF8090).w
                move.w  #$140,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.l  #$C0000,(dword_FF9408).w
                addq.w  #2,$5E(a5)
locret_4CBFC:                                           ; CODE XREF: Boss_BugmaxRotateMouthClose+1E   j
                rts
; End of function Boss_BugmaxRotateMouthClose
; Loads compressed graphics for open mouth
Boss_BugmaxLoadOpenMouthGfx:                            ; DATA XREF: ROM:0004C3F6   o  ; was: sub_4CBFE
                subq.w  #1,$48(a5)
                bne.w   locret_4CC28
                addq.w  #2,4(a5)
                lea     word_4CC16(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_4CC16:     dc.w    $6330, $2000, $302, $B3B2, $B1B0, $B7B6, $B5B4, $BBBA, $B900
                                        ; DATA XREF: Boss_BugmaxLoadOpenMouthGfx+C   o
; ---------------------------------------------------------------------------
locret_4CC28:                                           ; CODE XREF: Boss_BugmaxLoadOpenMouthGfx+4   j
                rts
; End of function Boss_BugmaxLoadOpenMouthGfx
; Loads compressed graphics for closed mouth
Boss_BugmaxLoadClosedMouthGfx:                          ; DATA XREF: ROM:0004C3F8   o  ; was: sub_4CC2A
                tst.b   (word_FFF720).w
                bmi.s   locret_4CC52
                addq.w  #2,4(a5)
                lea     word_4CC40(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_4CC40:     dc.w    $6930, $2000, $302, $DBDA, $D900, $D7D6, $D5D4, $D3D2, $D1D0
                                        ; DATA XREF: Boss_BugmaxLoadClosedMouthGfx+A   o
; ---------------------------------------------------------------------------
locret_4CC52:                                           ; CODE XREF: Boss_BugmaxLoadClosedMouthGfx+4   j
                rts
; End of function Boss_BugmaxLoadClosedMouthGfx
; Updates movement and waits for angle counter
Boss_BugmaxMovementPhase1:                              ; DATA XREF: ROM:0004C3FA   o  ; was: sub_4CC54
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$18,(dword_FF9410).w
                bne.s   locret_4CC70
                clr.w   (dword_FF9424+2).w
                addq.w  #2,4(a5)
locret_4CC70:                                           ; CODE XREF: Boss_BugmaxMovementPhase1+12   j
                rts
; End of function Boss_BugmaxMovementPhase1
; Selects attack pattern based on player
Boss_BugmaxAttackPatternSelect:                         ; DATA XREF: ROM:0004C3FC   o  ; was: sub_4CC72
                clr.b   (dword_FF9418+1).w
                clr.w   (dword_FF9424).w
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  (word_FF8248).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcc.w   loc_4CD3A
loc_4CC8E:                                              ; CODE XREF: Boss_BugmaxAttackPhaseHandler+48   j
                clr.w   $54(a5)
                move.w  $56(a5),d0
                move.w  word_4CCBC(pc,d0.w),(dword_FF9424+2).w
                bsr.s   Boss_BugmaxAttackPatternDispatch
                addq.w  #2,$56(a5)
                andi.w  #$1E,$56(a5)
                rts
; End of function Boss_BugmaxAttackPatternSelect
; Dispatcher for attack pattern execution
Boss_BugmaxAttackPatternDispatch:                       ; CODE XREF: Boss_BugmaxAttackPatternSelect+2A   p  ; was: sub_4CCAA
                move.w  (dword_FF9424+2).w,d0
                lea     off_4CCB6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxAttackPatternDispatch
; ---------------------------------------------------------------------------
off_4CCB6:      dc.w    Boss_BugmaxAttackPattern2-*     ; DATA XREF: Boss_BugmaxAttackPatternDispatch+4   o
                dc.w    Boss_BugmaxInitAttackState-*
                dc.w    Boss_BugmaxAttackPhaseHandler-*
word_4CCBC:     dc.w    4, 0, 4, 2, 4, 0, 4, 2, 4, 2, 4, 0, 4, 2, 4, 0
                                        ; DATA XREF: Boss_BugmaxAttackPatternSelect+24   r

; Initializes attack state parameters
Boss_BugmaxInitAttackState:                             ; CODE XREF: Boss_BugmaxAttackPhaseHandler+16   j  ; was: sub_4CCDC
                                        ; Boss_BugmaxAttackPattern2+12   j
                                        ; DATA XREF:
                move.w  #$80,(dword_FF940C).w
                move.w  #$80,(dword_FF940C+2).w
                move.w  #$B0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$44,4(a5)                      ; 'D'
                rts
; End of function Boss_BugmaxInitAttackState
; Handles attack phase logic
Boss_BugmaxAttackPhaseHandler:                          ; DATA XREF: ROM:0004CCBA   o  ; was: sub_4CCFC
                tst.b   (dword_FF9418+3).w
                beq.s   loc_4CD1A
                bne.w   locret_4CD9A
                move.w  (word_FF824A).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcs.w   Boss_BugmaxInitAttackState
                bra.w   loc_4CD3A
; ---------------------------------------------------------------------------
loc_4CD1A:                                              ; CODE XREF: Boss_BugmaxAttackPhaseHandler+4   j
                move.w  #$80,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.w  #$C0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$26,4(a5)                      ; '&'
                rts
; ---------------------------------------------------------------------------
loc_4CD3A:                                              ; CODE XREF: Boss_BugmaxAttackPatternSelect+18   j
                                        ; Boss_BugmaxAttackPhaseHandler+1A   j
                addq.w  #1,$54(a5)
                andi.w  #3,$54(a5)
                beq.w   loc_4CC8E
                move.w  #$140,(dword_FF940C).w
                move.w  #$100,(dword_FF940C+2).w
                move.w  #$E0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$32,4(a5)                      ; '2'
                rts
; End of function Boss_BugmaxAttackPhaseHandler
; Attack pattern with specific coordinates
Boss_BugmaxAttackPattern2:                              ; DATA XREF: ROM:off_4CCB6   o  ; was: sub_4CD68
                tst.b   (dword_FF9418+3).w
                beq.s   loc_4CD82
                move.w  (word_FF824A).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcs.w   Boss_BugmaxInitAttackState
                bra.w   loc_4CD3A
; ---------------------------------------------------------------------------
loc_4CD82:                                              ; CODE XREF: Boss_BugmaxAttackPattern2+4   j
                move.w  #$140,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.w  #$C0,(dword_FF9420).w
                move.w  #$80,(dword_FF9420+2).w
locret_4CD9A:                                           ; CODE XREF: Boss_BugmaxAttackPhaseHandler+6   j
                rts
; End of function Boss_BugmaxAttackPattern2
; Sets up boss attack stance
Boss_BugmaxEnterAttackStance1:                          ; DATA XREF: ROM:0004C3FE   o  ; was: sub_4CD9C
                bsr.w   Boss_BugmaxUpdateMovement
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxEnterAttackStance1
; Waits for attack preparation counter
Boss_BugmaxWaitAttackReady:                             ; DATA XREF: ROM:0004C400   o  ; was: sub_4CDAC
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #1,(dword_FF9408).w
                cmpi.w  #$18,(dword_FF9408).w
                bne.s   locret_4CDE0
                clr.b   (dword_FF9418+1).w
                clr.w   (dword_FF9424).w
                bset    #0,(dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                move.w  #$10,$4A(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4CDE0:                                           ; CODE XREF: Boss_BugmaxWaitAttackReady+E   j
                rts
; End of function Boss_BugmaxWaitAttackReady
; Executes movement with horizontal AI
Boss_BugmaxMoveAndCheckFlag:                            ; DATA XREF: ROM:0004C402   o  ; was: sub_4CDE2
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                subq.w  #1,$48(a5)
                beq.s   loc_4CDF8
                bclr    #0,(dword_FF941C).w
                beq.s   locret_4CDFC
loc_4CDF8:                                              ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+C   j
                addq.w  #2,4(a5)
locret_4CDFC:                                           ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+14   j
                rts
; End of function Boss_BugmaxMoveAndCheckFlag
; Handles projectile attack with trajectory
Boss_BugmaxProjectileAttack:                            ; DATA XREF: ROM:0004C404   o  ; was: sub_4CDFE
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4CE1C
                bsr.w   Projectile_InitBugmaxSpread
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4CE1C:                                           ; CODE XREF: Boss_BugmaxProjectileAttack+E   j
                rts
; End of function Boss_BugmaxProjectileAttack
; Tracks player distance and loops attack
Boss_BugmaxDistanceTrackLoop:                           ; DATA XREF: ROM:0004C406   o  ; was: sub_4CE1E
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4CE44
                jsr     (Physics_CalculateDistanceTo).l
                subq.w  #1,$48(a5)
                bne.s   locret_4CE42
                subq.w  #1,$4A(a5)
                beq.s   loc_4CE44
                subq.w  #2,4(a5)
locret_4CE42:                                           ; CODE XREF: Boss_BugmaxDistanceTrackLoop+18   j
                rts
; ---------------------------------------------------------------------------
loc_4CE44:                                              ; CODE XREF: Boss_BugmaxDistanceTrackLoop+C   j
                                        ; Boss_BugmaxDistanceTrackLoop+1E   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxDistanceTrackLoop
; Countdown timer for state transition
Boss_BugmaxAttackCountdown:                             ; DATA XREF: ROM:0004C408   o  ; was: sub_4CE4A
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9408).w
                cmpi.w  #$C,(dword_FF9408).w
                bne.s   locret_4CE60
                move.w  #$24,4(a5)                      ; '$'
locret_4CE60:                                           ; CODE XREF: Boss_BugmaxAttackCountdown+E   j
                rts
; End of function Boss_BugmaxAttackCountdown
; Positions boss for horizontal movement
Boss_BugmaxPositionForHorizontal:                       ; DATA XREF: ROM:0004C40A   o  ; was: sub_4CE62
                bsr.w   Boss_BugmaxUpdateMovement
                clr.b   (dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                bset    #0,(dword_FF9418+1).w
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                subi.w  #$80,d0
                move.w  d0,(dword_FF9424).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxPositionForHorizontal
; Executes horizontal AI with timeout
Boss_BugmaxHorizontalMoveWait:                          ; DATA XREF: ROM:0004C40C   o  ; was: sub_4CE92
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                bclr    #0,(dword_FF941C).w
                bne.s   loc_4CEA8
                subq.w  #1,$48(a5)
                bne.s   locret_4CEB6
loc_4CEA8:                                              ; CODE XREF: Boss_BugmaxHorizontalMoveWait+E   j
                clr.b   (dword_FF9418+1).w
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
locret_4CEB6:                                           ; CODE XREF: Boss_BugmaxHorizontalMoveWait+14   j
                rts
; End of function Boss_BugmaxHorizontalMoveWait
; Prepares special attack with timer
Boss_BugmaxPrepareSpecialAttack:                        ; DATA XREF: ROM:0004C40E   o  ; was: sub_4CEB8
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$60,$48(a5)                    ; '`'
                move.b  #1,(dword_FF9418+2).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxPrepareSpecialAttack
; Calculates angle to player for attack
Boss_BugmaxAngleCalculateAttack:                        ; DATA XREF: ROM:0004C410   o  ; was: sub_4CECE
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  $48(a5),d0
                move.w  word_4CF20(pc,d0.w),(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                subq.w  #2,$48(a5)
                bpl.s   locret_4CF1E
                jsr     (Math_CalculateAngleToPlayer).l
                cmpi.w  #$100,d2
                bcc.s   loc_4CEFE
                cmpi.w  #$40,d2                         ; '@'
                bcs.s   loc_4CF08
                move.w  #$40,d2                         ; '@'
                bra.s   loc_4CF08
; ---------------------------------------------------------------------------
loc_4CEFE:                                              ; CODE XREF: Boss_BugmaxAngleCalculateAttack+22   j
                cmpi.w  #$1C0,d2
                bhi.s   loc_4CF08
                move.w  #$1C0,d2
loc_4CF08:                                              ; CODE XREF: Boss_BugmaxAngleCalculateAttack+28   j
                                        ; Boss_BugmaxAngleCalculateAttack+2E   j
                move.w  d2,(dword_FF9414).w
                bsr.w   Boss_BugmaxEnableHitbox
                addq.w  #2,4(a5)
                move.b  #$E2,d0
                jsr     (Sound_PlaySFX).l
locret_4CF1E:                                           ; CODE XREF: Boss_BugmaxAngleCalculateAttack+16   j
                rts
; End of function Boss_BugmaxAngleCalculateAttack
; ---------------------------------------------------------------------------
word_4CF20:     dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                                        ; DATA XREF: Boss_BugmaxAngleCalculateAttack+8   r
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19
                dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19
                dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19

; Updates special attack animation
Boss_BugmaxSpecialAttackUpdate:                         ; DATA XREF: ROM:0004C412   o  ; was: sub_4CF80
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxFlashEffect
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                tst.w   (dword_FF9410).w
                bne.s   locret_4CFA0
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4CFA0:                                           ; CODE XREF: Boss_BugmaxSpecialAttackUpdate+14   j
                rts
; End of function Boss_BugmaxSpecialAttackUpdate
; Waits 8 frames during special attack
Boss_BugmaxSpecialAttackWait:                           ; DATA XREF: ROM:0004C414   o  ; was: sub_4CFA2
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxFlashEffect
                subq.w  #1,$48(a5)
                bne.s   locret_4CFB4
                addq.w  #2,4(a5)
locret_4CFB4:                                           ; CODE XREF: Boss_BugmaxSpecialAttackWait+C   j
                rts
; End of function Boss_BugmaxSpecialAttackWait
; Decrements attack counter with animation
Boss_BugmaxSpecialAttackDecrement:                      ; DATA XREF: ROM:0004C416   o  ; was: sub_4CFB6
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxDisableFlashEffect
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$FFE0,(dword_FF9410).w
                bne.s   locret_4CFD2
                addq.w  #2,4(a5)
locret_4CFD2:                                           ; CODE XREF: Boss_BugmaxSpecialAttackDecrement+16   j
                rts
; End of function Boss_BugmaxSpecialAttackDecrement
; Resets special attack counter
Boss_BugmaxResetSpecialAttack:                          ; DATA XREF: ROM:0004C418   o  ; was: sub_4CFD4
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$20,(dword_FF9410).w           ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxResetSpecialAttack
; Finishes special attack and clears flags
Boss_BugmaxSpecialAttackFinish:                         ; DATA XREF: ROM:0004C41A   o  ; was: sub_4CFE4
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$18,(dword_FF9410).w
                bne.s   locret_4D006
                clr.b   (dword_FF9418+2).w
                clr.w   (dword_FF9414).w
                move.w  #$24,4(a5)                      ; '$'
locret_4D006:                                           ; CODE XREF: Boss_BugmaxSpecialAttackFinish+12   j
                rts
; End of function Boss_BugmaxSpecialAttackFinish
; Manual angle control via input buttons
Boss_BugmaxManualAngleControl:
                btst    #2,(word_FFF706).w              ; was: sub_4D008
                beq.s   loc_4D016
                addi.w  #-2,(dword_FF9410).w
loc_4D016:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4D024
                addi.w  #2,(dword_FF9410).w
loc_4D024:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+14   j
                cmpi.w  #$40,(dword_FF9410).w           ; '@'
                blt.w   loc_4D036
                move.w  #$40,(dword_FF9410).w           ; '@'
                bra.s   loc_4D046
; ---------------------------------------------------------------------------
loc_4D036:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+22   j
                cmpi.w  #$FFC0,(dword_FF9410).w
                bge.w   loc_4D046
                move.w  #$FFC0,(dword_FF9410).w
loc_4D046:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+2C   j
                                        ; Boss_BugmaxManualAngleControl+34   j
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                rts
; End of function Boss_BugmaxManualAngleControl
; Updates all boss body segment angles
Boss_BugmaxUpdateSegmentAngles:                         ; CODE XREF: Boss_BugmaxMovementPhase1+8   p  ; was: sub_4D04C
                                        ; Boss_BugmaxAngleCalculateAttack+E   p
                move.w  (dword_FF9410).w,d0
                add.w   d0,d0
                bpl.s   loc_4D056
                neg.w   d0
loc_4D056:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+6   j
                move.w  #$40,(dword_FF9410+2).w         ; '@'
                sub.w   d0,(dword_FF9410+2).w
                move.w  (dword_FF9410).w,d0
                moveq   #0,d6
                movea.w #(word_FFC8C0-M68K_RAM),a0
                move.w  #2,d7
loc_4D06E:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+2E   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D06E
                move.w  #2,d7
loc_4D082:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+44   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D082
                move.w  #1,d7
loc_4D098:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+5C   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D098
                rts
; End of function Boss_BugmaxUpdateSegmentAngles
; Sets up second attack stance
Boss_BugmaxEnterAttackStance2:                          ; DATA XREF: ROM:0004C41C   o  ; was: sub_4D0AE
                bsr.w   Boss_BugmaxUpdateMovement
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxEnterAttackStance2
; Waits for attack counter to reach $20
Boss_BugmaxWaitCounter32:                               ; DATA XREF: ROM:0004C41E   o  ; was: sub_4D0BE
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #1,(dword_FF9408).w
                cmpi.w  #$20,(dword_FF9408).w           ; ' '
                bne.s   locret_4D0D2
                addq.w  #2,4(a5)
locret_4D0D2:                                           ; CODE XREF: Boss_BugmaxWaitCounter32+E   j
                rts
; End of function Boss_BugmaxWaitCounter32
; Smart positioning based on camera scroll
Boss_BugmaxSmartPositioning:                            ; DATA XREF: ROM:0004C420   o  ; was: sub_4D0D4
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                clr.b   (dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                bset    #0,(dword_FF9418+1).w
                tst.b   (dword_FF9418+3).w
                bne.w   loc_4D124
                cmpi.b  #2,(dword_FF9424+2).w
                bne.w   loc_4D124
                cmpi.w  #$3C0,(dword_FFA900).w
                beq.s   loc_4D12A
                cmpi.w  #$460,(dword_FFA900).w
                beq.s   loc_4D13C
                btst    #2,(word_FFF706).w
                bne.s   loc_4D12A
                btst    #3,(word_FFF706).w
                bne.s   loc_4D13C
loc_4D124:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+22   j
                                        ; Boss_BugmaxSmartPositioning+2C   j
                clr.w   (dword_FF9424).w
                rts
; ---------------------------------------------------------------------------
loc_4D12A:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+36   j
                                        ; Boss_BugmaxSmartPositioning+46   j
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                addi.w  #$D0,d0
                move.w  d0,(dword_FF9424).w
                rts
; ---------------------------------------------------------------------------
loc_4D13C:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+3E   j
                                        ; Boss_BugmaxSmartPositioning+4E   j
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                addi.w  #-$D0,d0
                move.w  d0,(dword_FF9424).w
                rts
; End of function Boss_BugmaxSmartPositioning
; Chases player until within distance
Boss_BugmaxDistanceChasePlayer:                         ; DATA XREF: ROM:0004C422   o  ; was: sub_4D14E
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$20,d0                         ; ' '
                bcs.s   loc_4D170
                bclr    #0,(dword_FF941C).w
                bne.s   loc_4D170
                subq.w  #1,$48(a5)
                bne.s   locret_4D184
loc_4D170:                                              ; CODE XREF: Boss_BugmaxDistanceChasePlayer+12   j
                                        ; Boss_BugmaxDistanceChasePlayer+1A   j
                move.w  #8,$48(a5)
                clr.b   (dword_FF9418+1).w
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
locret_4D184:                                           ; CODE XREF: Boss_BugmaxDistanceChasePlayer+20   j
                rts
; End of function Boss_BugmaxDistanceChasePlayer
; 8 frame delay before next attack phase
Boss_BugmaxAttackDelay:                                 ; DATA XREF: ROM:0004C424   o  ; was: sub_4D186
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,$48(a5)
                bne.s   locret_4D19A
                move.w  #8,$4C(a5)
                addq.w  #2,4(a5)
locret_4D19A:                                           ; CODE XREF: Boss_BugmaxAttackDelay+8   j
                rts
; End of function Boss_BugmaxAttackDelay
; Updates movement and spawns vertical projectile
Boss_BugmaxProjectileVerticalAttack:                    ; DATA XREF: ROM:0004C426   o  ; was: sub_4D19C
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxVerticalControl
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D1BA
                bsr.w   Projectile_InitBugmaxSine
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4D1BA:                                           ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+E   j
                rts
; End of function Boss_BugmaxProjectileVerticalAttack
; Handles horizontal AI movement with attack loop counter
Boss_BugmaxHorizontalAttackLoop:                        ; DATA XREF: ROM:0004C428   o  ; was: sub_4D1BC
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                subq.w  #1,$48(a5)
                bne.s   locret_4D1D4
                subq.w  #1,$4C(a5)
                beq.s   loc_4D1D6
                subq.w  #2,4(a5)
locret_4D1D4:                                           ; CODE XREF: Boss_BugmaxHorizontalAttackLoop+C   j
                rts
; ---------------------------------------------------------------------------
loc_4D1D6:                                              ; CODE XREF: Boss_BugmaxHorizontalAttackLoop+12   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxHorizontalAttackLoop
; Manages state transition based on global timer
Boss_BugmaxTimedStateTransition:                        ; DATA XREF: ROM:0004C42A   o  ; was: sub_4D1DC
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9408).w
                cmpi.w  #$C,(dword_FF9408).w
                bne.s   locret_4D1F0
                addq.w  #2,4(a5)
locret_4D1F0:                                           ; CODE XREF: Boss_BugmaxTimedStateTransition+E   j
                rts
; End of function Boss_BugmaxTimedStateTransition
; Resets boss state machine to specific phase
Boss_BugmaxResetState:                                  ; DATA XREF: ROM:0004C42C   o  ; was: sub_4D1F2
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$24,4(a5)                      ; '$'
                rts
; End of function Boss_BugmaxResetState
; Checks landing condition
Boss_BugmaxLandCheck:                                   ; DATA XREF: ROM:0004C42E   o  ; was: sub_4D1FE
                bsr.w   Boss_BugmaxUpdateMovement
                tst.w   (dword_FF9400).w
                bmi.s   locret_4D226
                cmpi.w  #$20,(dword_FF9400).w           ; ' '
                bgt.s   locret_4D226
                clr.b   $21(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4D226:                                           ; CODE XREF: Boss_BugmaxLandCheck+8   j
                                        ; Boss_BugmaxLandCheck+10   j
                rts
; End of function Boss_BugmaxLandCheck
; Flash effect on landing
Boss_BugmaxLandFlash:                                   ; DATA XREF: ROM:0004C430   o  ; was: sub_4D228
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4D272
                subq.w  #2,$48(a5)
                bmi.s   loc_4D272
                move.w  $48(a5),d0
                andi.w  #$1E,d0
                move.w  word_4D252(pc,d0.w),d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; ---------------------------------------------------------------------------
word_4D252:     dc.w    0, 2, 4, 6, 8, $A, $C, $E, $E, $C, $A, 8, 6, 4, 2, 0
                                        ; DATA XREF: Boss_BugmaxLandFlash+14   r
; ---------------------------------------------------------------------------
loc_4D272:                                              ; CODE XREF: Boss_BugmaxLandFlash+4   j
                                        ; Boss_BugmaxLandFlash+A   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxLandFlash
; Scatters all boss parts
Boss_BugmaxScatterParts:                                ; DATA XREF: ROM:0004C432   o  ; was: sub_4D27E
                subq.w  #1,$48(a5)
                bne.w   locret_4D302
                move.w  #$CF80,d6
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$D,d7
loc_4D292:                                              ; CODE XREF: Boss_BugmaxScatterParts+3E   j
                move.w  #$344,(a0)
                move.w  d6,2(a0)
                clr.b   $21(a0)
                move.w  #$FFFE,$1C(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4D292
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4D2C8:                                              ; CODE XREF: Boss_BugmaxScatterParts+76   j
                move.w  #$344,(a0)
                move.w  #1,$5C(a0)
                clr.b   $21(a0)
                move.w  #$FFFE,$1C(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4D2C8
                move.w  #$FFFA,$1C(a5)
                addq.w  #2,4(a5)
locret_4D302:                                           ; CODE XREF: Boss_BugmaxScatterParts+4   j
                rts
; End of function Boss_BugmaxScatterParts
; Boss falls off screen
Boss_BugmaxFallOffScreen:                               ; DATA XREF: ROM:0004C434   o  ; was: sub_4D304
                cmpi.w  #$80,$14(a5)
                bgt.w   loc_4D3D4
                move.w  #$530,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                andi.w  #$7FFF,2(a5)
                clr.l   $1C(a5)
                move.w  #2,(dword_FF9408).w
                move.w  #$40,(dword_FF940C).w           ; '@'
                move.w  #$40,(dword_FF940C+2).w         ; '@'
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D372
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                andi.w  #$7FFF,$E(a0)
                addq.b  #4,$20(a0)
                move.l  #off_E953C,8(a0)
locret_4D372:                                           ; CODE XREF: Boss_BugmaxFallOffScreen+42   j
                rts
; End of function Boss_BugmaxFallOffScreen
; Wait timer state
Boss_BugmaxWaitTimer:                                   ; DATA XREF: ROM:0004C436   o  ; was: sub_4D374
                subq.w  #1,$48(a5)
                bne.s   locret_4D37E
                addq.w  #2,4(a5)
locret_4D37E:                                           ; CODE XREF: Boss_BugmaxWaitTimer+4   j
                rts
; End of function Boss_BugmaxWaitTimer
; Boss rises up
Boss_BugmaxRiseUp:                                      ; DATA XREF: ROM:0004C438   o  ; was: sub_4D380
                addi.l  #$800,$1C(a5)
                cmpi.l  #$8000,$1C(a5)
                bcs.s   locret_4D39C
                move.w  #$5C,(word_FF80C2).w            ; '\'
                addq.w  #2,4(a5)
locret_4D39C:                                           ; CODE XREF: Boss_BugmaxRiseUp+10   j
                rts
; End of function Boss_BugmaxRiseUp
; Boss falls down
Boss_BugmaxFallDown:                                    ; DATA XREF: ROM:0004C43A   o  ; was: sub_4D39E
                bsr.w   Boss_BugmaxCalculateWave
                move.l  (dword_FF9400).w,d0
                asr.l   #4,d0
                move.l  d0,$18(a5)
                cmpi.w  #$170,$14(a5)
                blt.s   locret_4D3C2
                move.b  #1,(byte_FF830E).w
                clr.w   (a5)
                move.w  #$1000,2(a5)
locret_4D3C2:                                           ; CODE XREF: Boss_BugmaxFallDown+14   j
                rts
; End of function Boss_BugmaxFallDown
; Falling debris with trail
Enemy_BugmaxDebrisFall:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D3C4
                addi.l  #$1000,$1C(a5)
                tst.w   $5C(a5)
                beq.s   loc_4D3D4
                rts
; ---------------------------------------------------------------------------
loc_4D3D4:                                              ; CODE XREF: Boss_BugmaxFallOffScreen+6   j
                                        ; Enemy_BugmaxDebrisFall+C   j
                move.w  a5,d7
                lsr.w   #4,d7
                add.w   (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4D43A
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D43A
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                andi.w  #$7FFF,$E(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                bne.s   locret_4D43A
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #6,d0
                move.w  word_4D43C(pc,d0.w),d0
                andi.w  #$FF,d0
                jsr     (Sound_PlaySFX).l
locret_4D43A:                                           ; CODE XREF: Enemy_BugmaxDebrisFall+1C   j
                                        ; Enemy_BugmaxDebrisFall+24   j
                rts
; End of function Enemy_BugmaxDebrisFall
; ---------------------------------------------------------------------------
word_4D43C:     dc.w    $BB, $BC, $BB, $C1              ; DATA XREF: Enemy_BugmaxDebrisFall+68   r

; Bugmax debris handler
Enemy_BugmaxDebrisMain:                                 ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D444
                addi.l  #$2000,$1C(a5)
                bsr.w   Boss_BugmaxAnimateFlip
                move.w  4(a5),d0
                lea     off_4D45C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_BugmaxDebrisMain
; ---------------------------------------------------------------------------
off_4D45C:      dc.w    Enemy_BugmaxDebrisInit-*        ; DATA XREF: Enemy_BugmaxDebrisMain+10   o
                dc.w    Enemy_BugmaxDebrisBounce-*
                dc.w    nullsub_109-*

; Initializes debris piece
Enemy_BugmaxDebrisInit:                                 ; DATA XREF: ROM:off_4D45C   o  ; was: sub_4D462
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                beq.s   locret_4D47C
                ori.w   #$8000,$E(a5)
locret_4D47C:                                           ; CODE XREF: Enemy_BugmaxDebrisInit+12   j
                rts
; End of function Enemy_BugmaxDebrisInit
; Debris bouncing physics
Enemy_BugmaxDebrisBounce:                               ; DATA XREF: ROM:0004D45E   o  ; was: sub_4D47E
                tst.b   $5F(a5)
                beq.s   loc_4D490
                bclr    #7,$22(a5)
                bne.s   loc_4D4CE
                bsr.w   Enemy_BugmaxDebrisFlicker
loc_4D490:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+4   j
                btst    #7,$1C(a5)
                bne.s   locret_4D4CC
                cmpi.w  #$130,$14(a5)
                blt.s   locret_4D4CC
                move.w  #$130,$14(a5)
                tst.b   $5F(a5)
                bne.s   loc_4D4F2
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                move.l  $18(a5),d0
                asr.l   #1,d0
                move.l  d0,$18(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_4D4CC
                addq.w  #2,4(a5)
locret_4D4CC:                                           ; CODE XREF: Enemy_BugmaxDebrisBounce+18   j
                                        ; Enemy_BugmaxDebrisBounce+20   j
                rts
; ---------------------------------------------------------------------------
loc_4D4CE:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+C   j
                bclr    #4,$22(a5)
                beq.s   loc_4D4DC
                jmp     Sprite_SetPointerClearD7
; ---------------------------------------------------------------------------
loc_4D4DC:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+56   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E95DC,8(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_4D4F2:                                              ; CODE XREF: Enemy_BugmaxDebrisBounce+2C   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$32,$26(a5)                    ; '2'
                jmp     Projectile_CheckLifetime
; End of function Enemy_BugmaxDebrisBounce
; Flickers debris sprite graphics
Enemy_BugmaxDebrisFlicker:                              ; CODE XREF: Enemy_BugmaxDebrisBounce+E   p  ; was: sub_4D506
                tst.b   $5F(a5)
                beq.s   locret_4D538
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                beq.s   locret_4D538
                cmpi.w  #1,d0
                beq.s   loc_4D532
                cmpi.w  #2,d0
                beq.s   loc_4D52A
                move.w  #$C4F7,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4D52A:                                              ; CODE XREF: Enemy_BugmaxDebrisFlicker+1A   j
                move.w  #$C4F6,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4D532:                                              ; CODE XREF: Enemy_BugmaxDebrisFlicker+14   j
                move.w  #$C4F1,$E(a5)
locret_4D538:                                           ; CODE XREF: Enemy_BugmaxDebrisFlicker+4   j
                                        ; Enemy_BugmaxDebrisFlicker+E   j
                rts
; End of function Enemy_BugmaxDebrisFlicker
nullsub_109:                                            ; DATA XREF: ROM:0004D460   o
                rts
; End of function nullsub_109

; Animates sprite flip
Boss_BugmaxAnimateFlip:                                 ; CODE XREF: Enemy_BugmaxDebrisMain+8   p  ; was: sub_4D53C
                                        ; sub_4D608   p
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_4D55E
                addq.w  #1,$4A(a5)
                andi.w  #3,$4A(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                move.w  word_4D560(pc,d0.w),d0
                eor.w   d0,$E(a5)
locret_4D55E:                                           ; CODE XREF: Boss_BugmaxAnimateFlip+8   j
                rts
; End of function Boss_BugmaxAnimateFlip
; ---------------------------------------------------------------------------
word_4D560:     dc.w    $1000, $800, $1000, $800
                                        ; DATA XREF: Boss_BugmaxAnimateFlip+1A   r

; Initializes spread projectile with random offset
Projectile_InitBugmaxSpread:                            ; CODE XREF: Boss_BugmaxProjectileAttack+10   p  ; was: sub_4D568
                move.w  #$33C,(a0)
                move.w  #$EF80,2(a0)
                move.l  #off_ECBD0,8(a0)
                move.w  $E(a5),$E(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FE02FC04,$2C(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$14,$26(a0)
                move.w  #$18,$24(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$40,d0                         ; '@'
                add.w   d0,$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFF,$1C(a0)
                rts
; End of function Projectile_InitBugmaxSpread
; Main controller with screen shake and state machine
Projectile_BugmaxMainController:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D5C8
                tst.l   $1C(a5)
                beq.s   loc_4D5F2
                move.w  (word_FFA000).w,d0
                andi.w  #1,d0
                beq.s   loc_4D5E6
                subi.w  #$20,$10(a5)                    ; ' '
                subi.w  #$20,$14(a5)                    ; ' '
                bra.s   loc_4D5F2
; ---------------------------------------------------------------------------
loc_4D5E6:                                              ; CODE XREF: Projectile_BugmaxMainController+E   j
                addi.w  #$20,$10(a5)                    ; ' '
                addi.w  #$20,$14(a5)                    ; ' '
loc_4D5F2:                                              ; CODE XREF: Projectile_BugmaxMainController+4   j
                                        ; Projectile_BugmaxMainController+1C   j
                move.w  4(a5),d0
                lea     off_4D5FE(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxMainController
; ---------------------------------------------------------------------------
off_4D5FE:      dc.w    Projectile_BugmaxFlyingPhase-*  ; DATA XREF: Projectile_BugmaxMainController+2E   o
                dc.w    Projectile_BugmaxFadeToBlack-*
                dc.w    Projectile_BugmaxExplosionWait-*
                dc.w    Projectile_BugmaxFadeFromBlack-*
                dc.w    nullsub_110-*

; Handles flying phase with collision and explosion
Projectile_BugmaxFlyingPhase:                           ; DATA XREF: ROM:off_4D5FE   o  ; was: sub_4D608
                bsr.w   Boss_BugmaxAnimateFlip
                addi.l  #$800,$1C(a5)
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4D668
                bclr    #7,$22(a5)
                beq.s   loc_4D668
                clr.l   $1C(a5)
                move.w  #$4D80,2(a5)
                move.b  #1,(dword_FF9418+3).w
                clr.w   $5C(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D690
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                move.w  #$FFFE,$1C(a0)
                rts
; ---------------------------------------------------------------------------
loc_4D668:                                              ; CODE XREF: Projectile_BugmaxFlyingPhase+10   j
                                        ; Projectile_BugmaxFlyingPhase+18   j
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                bne.s   loc_4D67C
                tst.w   (dword_FF9428+2).w
                beq.s   locret_4D690
loc_4D67C:                                              ; CODE XREF: Projectile_BugmaxFlyingPhase+6C   j
                move.l  #off_E95DC,8(a5)
                move.w  #$FFFE,$1C(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
locret_4D690:                                           ; CODE XREF: Projectile_BugmaxFlyingPhase+3C   j
                                        ; Projectile_BugmaxFlyingPhase+72   j
                rts
; End of function Projectile_BugmaxFlyingPhase
; Fades screen to black for impact effect
Projectile_BugmaxFadeToBlack:                           ; DATA XREF: ROM:0004D600   o  ; was: sub_4D692
                bsr.w   Gfx_ApplyDualPaletteFade
                subq.w  #2,$5C(a5)
                cmpi.w  #$FFF0,$5C(a5)
                bne.s   locret_4D6AC
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4D6AC:                                           ; CODE XREF: Projectile_BugmaxFadeToBlack+E   j
                rts
; End of function Projectile_BugmaxFadeToBlack
; Waits during explosion with timer countdown
Projectile_BugmaxExplosionWait:                         ; DATA XREF: ROM:0004D602   o  ; was: sub_4D6AE
                bsr.w   Gfx_ApplyDualPaletteFade
                subq.w  #1,$48(a5)
                bne.s   locret_4D6BC
                addq.w  #2,4(a5)
locret_4D6BC:                                           ; CODE XREF: Projectile_BugmaxExplosionWait+8   j
                rts
; End of function Projectile_BugmaxExplosionWait
; Fades screen back from black after explosion
Projectile_BugmaxFadeFromBlack:                         ; DATA XREF: ROM:0004D604   o  ; was: sub_4D6BE
                bsr.w   Gfx_ApplyDualPaletteFade
                move.w  (word_FFA000).w,d7
                andi.w  #$1F,d7
                bne.s   locret_4D6E6
                addq.w  #2,$5C(a5)
                cmpi.w  #2,$5C(a5)
                bne.s   locret_4D6E6
                clr.b   (dword_FF9418+3).w
                bset    #4,2(a5)
                addq.w  #2,4(a5)
locret_4D6E6:                                           ; CODE XREF: Projectile_BugmaxFadeFromBlack+C   j
                                        ; Projectile_BugmaxFadeFromBlack+18   j
                rts
; End of function Projectile_BugmaxFadeFromBlack
nullsub_110:                                            ; DATA XREF: ROM:0004D606   o
                rts
; End of function nullsub_110

; Applies palette fade to two ranges simultaneously
Gfx_ApplyDualPaletteFade:                               ; CODE XREF: Projectile_BugmaxFadeToBlack   p  ; was: sub_4D6EA
                                        ; sub_4D6AE   p
                move.w  $5C(a5),d0
                move.w  #$1F,d5
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5C(a5),d0
                move.w  #$F,d5
                move.w  #$E000,d7
                lea     (word_FFE360).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_ApplyDualPaletteFade
; Initializes sine wave projectile with angular trajectory
Projectile_InitBugmaxSine:                              ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+10   p  ; was: sub_4D718
                move.w  #$340,(a0)
                move.w  #$EF80,2(a0)
                move.l  #off_ECBDC,8(a0)
                move.w  $E(a5),$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #$80,$23(a0)
                move.l  #$FF01FF01,$2C(a0)
                move.l  #$F408F408,$28(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #$14,$26(a0)
                move.w  #$FF,$24(a0)
                move.w  $10(a5),$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                addi.w  #$40,(dword_FF9428).w           ; '@'
                move.w  (dword_FF9428).w,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  (a2,d0.w),d0
                ext.l   d0
                asl.l   #1,d0
                move.l  d0,$18(a0)
                move.w  $14(a5),$14(a0)
                move.w  $1C(a5),d0
                add.w   d0,$14(a0)
                rts
; End of function Projectile_InitBugmaxSine
; Main controller with collision and bounce physics
Projectile_BugmaxSineController:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4D79C
                addi.l  #$2000,$1C(a5)
                tst.w   (dword_FF9428+2).w
                bne.w   loc_4D82E
                bclr    #4,$22(a5)
                bne.w   Projectile_BugmaxSineDestroy
                bclr    #6,$22(a5)
                bne.w   Projectile_BugmaxSineDestroy
                bclr    #7,$22(a5)
                bne.w   loc_4D82E
                move.w  4(a5),d0
                lea     off_4D7D6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxSineController
; ---------------------------------------------------------------------------
off_4D7D6:      dc.w    Projectile_BugmaxSineBounce-*   ; DATA XREF: Projectile_BugmaxSineController+32   o
                dc.w    Projectile_BugmaxSineBounce_BounceLoop-*

; Handles bouncing physics with velocity reversal
Projectile_BugmaxSineBounce:                            ; DATA XREF: ROM:off_4D7D6   o  ; was: sub_4D7DA
                move.w  #3,$48(a5)
                addq.w  #2,4(a5)
; Check ground collision and execute sine bounce pattern
Projectile_BugmaxSineBounce_BounceLoop:                 ; DATA XREF: ROM:0004D7D8   o  ; was: loc_4D7E4
                btst    #7,$1C(a5)
                bne.s   locret_4D82C
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_4D82C
                subq.w  #1,$48(a5)
                beq.w   loc_4D82E
                move.l  $1C(a5),d0
                asr.l   #1,d0
                neg.l   d0
                move.l  d0,$1C(a5)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                move.w  d0,$18(a5)
                move.b  #$E3,d0
                jsr     (Sound_PlaySFX).l
locret_4D82C:                                           ; CODE XREF: Projectile_BugmaxSineBounce+10   j
                                        ; Projectile_BugmaxSineBounce+1E   j
                rts
; ---------------------------------------------------------------------------
loc_4D82E:                                              ; CODE XREF: Projectile_BugmaxSineController+C   j
                                        ; Projectile_BugmaxSineController+2A   j
                move.b  #$E4,d0
                jsr     (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C8,$26(a5)
                move.l  #$FC04F808,$2C(a5)
                jmp     Projectile_CheckLifetime
; End of function Projectile_BugmaxSineBounce
; Destroys sine projectile using destruction pattern
Projectile_BugmaxSineDestroy:                           ; CODE XREF: Projectile_BugmaxSineController+16   j  ; was: sub_4D854
                                        ; Projectile_BugmaxSineController+20   j
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; End of function Projectile_BugmaxSineDestroy
nullsub_111:
                rts
; End of function nullsub_111

; Enables hitbox collision and sets damage values
Boss_BugmaxEnableHitbox:                                ; CODE XREF: Boss_BugmaxAngleCalculateAttack+3E   p  ; was: sub_4D85E
                movea.w #(byte_FFCB60-M68K_RAM),a0
                move.b  #2,$21(a0)
                move.l  #$FC04FC04,$2C(a0)
                clr.b   $22(a0)
                rts
; End of function Boss_BugmaxEnableHitbox
; Manages white flash effect when taking damage
Boss_BugmaxFlashEffect:                                 ; CODE XREF: Boss_BugmaxSpecialAttackUpdate+4   p  ; was: sub_4D876
                                        ; Boss_BugmaxSpecialAttackWait+4   p
                movea.w #(byte_FFCB60-M68K_RAM),a0
                tst.w   $5C(a0)
                bne.s   loc_4D894
                bclr    #1,$22(a0)
                beq.s   locret_4D8C0
                bset    #1,(byte_FF825C).w
                move.w  #2,$5C(a0)
loc_4D894:                                              ; CODE XREF: Boss_BugmaxFlashEffect+8   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_4D8A2
                clr.w   $5C(a0)
                rts
; ---------------------------------------------------------------------------
loc_4D8A2:                                              ; CODE XREF: Boss_BugmaxFlashEffect+24   j
                move.w  #$2BC,(word_FF824E).w
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $10(a0),(word_FF8250).w
                move.w  $14(a0),(word_FF8252).w
locret_4D8C0:                                           ; CODE XREF: Boss_BugmaxFlashEffect+10   j
                rts
; End of function Boss_BugmaxFlashEffect
; Disables flash when health drops below threshold
Boss_BugmaxDisableFlashEffect:                          ; CODE XREF: Boss_BugmaxSpecialAttackDecrement+4   p  ; was: sub_4D8C2
                movea.w #(byte_FFCB60-M68K_RAM),a0
                cmpi.w  #$FFF0,(dword_FF9410).w
                bgt.s   Boss_BugmaxFlashEffect
                clr.b   $21(a0)
                rts
; End of function Boss_BugmaxDisableFlashEffect
; Updates all boss parts
Boss_BugmaxUpdateAllParts:                              ; CODE XREF: Boss_BugmaxDefeatRise   p  ; was: sub_4D8D4
                                        ; sub_4C734   p
                movem.w a5,-(sp)
                bsr.w   Boss_BugmaxSpawnProjectile
                move.w  #6,d7
                movea.w #(word_FFC680-M68K_RAM),a5
loc_4D8E4:                                              ; CODE XREF: Boss_BugmaxUpdateAllParts+18   j
                bsr.w   Boss_BugmaxSpawnProjectile
                lea     $60(a5),a5
                dbf     d7,loc_4D8E4
                movem.w (sp)+,a5
                bra.w   Boss_BugmaxAI
; End of function Boss_BugmaxUpdateAllParts
nullsub_112:
                rts
; End of function nullsub_112

; Spawns projectile from boss
Boss_BugmaxSpawnProjectile:                             ; CODE XREF: Boss_BugmaxUpdateAllParts+4   p  ; was: sub_4D8FA
                                        ; sub_4D8D4:loc_4D8E4   p
                bclr    #6,$22(a5)
                beq.w   locret_4DA18
                move.w  #4,(word_FFA014).w
                btst    #7,(dword_FFC638).w
                beq.s   loc_4D92E
                addi.l  #-$4000,(dword_FFC638).w
                cmpi.l  #$FFFE0000,(dword_FFC638).w
                blt.s   loc_4D948
                move.l  #$FFFE0000,(dword_FFC638).w
                bra.s   loc_4D948
; ---------------------------------------------------------------------------
loc_4D92E:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+16   j
                addi.l  #$4000,(dword_FFC638).w
                cmpi.l  #$20000,(dword_FFC638).w
                blt.s   loc_4D948
                move.l  #$20000,(dword_FFC638).w
loc_4D948:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+28   j
                                        ; Boss_BugmaxSpawnProjectile+32   j
                lea     (word_FFCF80).w,a0
                jsr     (loc_1C0A4).l
                bne.w   locret_4DA18
                move.w  #$338,(a0)
                move.w  (dword_FFC630).w,$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #8,$20(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                tst.w   (word_FFFF0E).w
                bne.s   loc_4D988
                andi.b  #7,d0
                bne.s   Boss_BugmaxSetupProjectile
                bra.s   loc_4D98E
; ---------------------------------------------------------------------------
loc_4D988:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+84   j
                andi.b  #3,d0
                bne.s   Boss_BugmaxSetupProjectile
loc_4D98E:                                              ; CODE XREF: Boss_BugmaxSpawnProjectile+8C   j
                move.b  #1,$5F(a0)
                move.w  #$8F80,2(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FE02FE02,$2C(a0)
                move.w  #$14,$26(a0)
                move.w  #2,$24(a0)
                move.l  #$FFFC0000,$1C(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                addq.w  #1,d0
                neg.w   d0
                move.w  d0,$18(a0)
                rts
; ---------------------------------------------------------------------------
; Sets up projectile velocity and tile
Boss_BugmaxSetupProjectile:                             ; CODE XREF: Boss_BugmaxSpawnProjectile+8A   j  ; was: loc_4D9E0
                                        ; Boss_BugmaxSpawnProjectile+92   j
                move.w  #$CF80,2(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #1,d0
                lsl.w   #2,d0
                move.l  off_4DA1A(pc,d0.w),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                neg.w   d0
                move.w  d0,$18(a0)
                move.b  (dword_FFFF08+2).w,d0
                andi.w  #7,d0
                subq.w  #4,d0
                move.w  d0,$1C(a0)
locret_4DA18:                                           ; CODE XREF: Boss_BugmaxSpawnProjectile+6   j
                                        ; Boss_BugmaxSpawnProjectile+58   j
                rts
; End of function Boss_BugmaxSpawnProjectile
; ---------------------------------------------------------------------------
off_4DA1A:      dc.l    word_ECB1C                      ; DATA XREF: Boss_BugmaxSpawnProjectile+F6   r
                dc.l    word_ECB22

; AI and movement control
Boss_BugmaxAI:                                          ; CODE XREF: Boss_BugmaxUpdateAllParts+20   j  ; was: sub_4DA22
                move.w  #$168,d0
                sub.w   (dword_FFA908).w,d0
                sub.w   $10(a5),d0
                beq.s   locret_4DA8A
                tst.w   d0
                bmi.s   loc_4DA60
                addi.l  #$4000,$18(a5)
                btst    #7,$18(a5)
                beq.s   loc_4DA4C
                addi.l  #$4000,$18(a5)
loc_4DA4C:                                              ; CODE XREF: Boss_BugmaxAI+20   j
                cmpi.l  #$FFFD8000,$18(a5)
                bgt.s   locret_4DA8A
                move.l  #$FFFD8000,$18(a5)
                bra.s   locret_4DA8A
; ---------------------------------------------------------------------------
loc_4DA60:                                              ; CODE XREF: Boss_BugmaxAI+10   j
                addi.l  #-$4000,$18(a5)
                btst    #7,$18(a5)
                bne.s   loc_4DA78
                addi.l  #-$4000,$18(a5)
loc_4DA78:                                              ; CODE XREF: Boss_BugmaxAI+4C   j
                cmpi.l  #$FFFD8000,$18(a5)
                bgt.s   locret_4DA8A
                move.l  #$FFFD8000,$18(a5)
locret_4DA8A:                                           ; CODE XREF: Boss_BugmaxAI+C   j
                                        ; Boss_BugmaxAI+32   j
                rts
; End of function Boss_BugmaxAI
; Clamps leg X positions to bounds
Boss_BugmaxClampLegPositions:                           ; CODE XREF: Boss_BugmaxVictoryCheck   p  ; was: sub_4DA8C
                                        ; sub_4C65E   p
                move.w  #$168,d2
                sub.w   (dword_FFA908).w,d2
                lea     word_4DAD2(pc),a2
                nop
                moveq   #0,d6
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #7,d7
loc_4DAA4:                                              ; CODE XREF: Boss_BugmaxClampLegPositions+40   j
                move.w  d2,d0
                move.w  d2,d1
                sub.w   (a2,d6.w),d0
                add.w   2(a2,d6.w),d1
                cmp.w   $10(a0),d0
                bcs.s   loc_4DABC
                move.w  d0,$10(a0)
                bra.s   Boss_BugmaxLegClampLoop
; ---------------------------------------------------------------------------
loc_4DABC:                                              ; CODE XREF: Boss_BugmaxClampLegPositions+28   j
                cmp.w   $10(a0),d1
                bhi.s   Boss_BugmaxLegClampLoop
                move.w  d1,$10(a0)
; Inner loop for leg position clamping
Boss_BugmaxLegClampLoop:                                ; CODE XREF: Boss_BugmaxClampLegPositions+2E   j  ; was: loc_4DAC6
                                        ; Boss_BugmaxClampLegPositions+34   j
                lea     $60(a0),a0
                addq.w  #4,d6
                dbf     d7,loc_4DAA4
                rts
; End of function Boss_BugmaxClampLegPositions
; ---------------------------------------------------------------------------
word_4DAD2:     dc.w    8, 8, $C, 8, $C, $C, $10, $10, $C, $10, $C, $C, 8, 8
                                        ; DATA XREF: Boss_BugmaxClampLegPositions+8   o

; Helper for 3D perspective calculation system
Boss_BugmaxPerspectiveHelper:                           ; CODE XREF: Boss_BugmaxCalculatePerspective:loc_4C1E0   p  ; was: sub_4DAEE
                move.w  (dword_FF9400).w,d0
                beq.s   locret_4DB2A
                tst.w   d0
                bpl.s   loc_4DB02
                neg.w   d0
                lea     word_4DB3E(pc),a0
                nop
                bra.s   loc_4DB08
; ---------------------------------------------------------------------------
loc_4DB02:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+8   j
                lea     word_4DB2C(pc),a0
                nop
loc_4DB08:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+12   j
                cmpi.w  #$40,d0                         ; '@'
                bcs.s   loc_4DB12
                move.w  #$40,d0                         ; '@'
loc_4DB12:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+1E   j
                lsr.w   #3,d0
                add.w   d0,d0
                move.w  (a0,d0.w),d0
                move.w  #$E000,d7
                lea     (word_3E2E).l,a4
                jmp     (VBlank_SharpssteelPaletteEffect).l
; ---------------------------------------------------------------------------
locret_4DB2A:                                           ; CODE XREF: Boss_BugmaxPerspectiveHelper+4   j
                rts
; End of function Boss_BugmaxPerspectiveHelper
; ---------------------------------------------------------------------------
word_4DB2C:     dc.w    $FFF8, $FFFA, $FFFA, $FFFC, $FFFC, $FFFE, $FFFE, 0, 0
                                        ; DATA XREF: Boss_BugmaxPerspectiveHelper:loc_4DB02   o
word_4DB3E:     dc.w    8, 6, 6, 4, 4, 2, 2, 0, 0
                                        ; DATA XREF: Boss_BugmaxPerspectiveHelper+C   o

; Toggles mouth open/close sprite
Boss_BugmaxToggleMouthSprite:                           ; CODE XREF: Boss_BugmaxCalculatePerspective+292   p  ; was: sub_4DB50
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                bne.s   locret_4DB7A
                movea.w #(word_FFC680-M68K_RAM),a0
                cmpi.l  #word_ECB28,8(a0)
                beq.s   loc_4DB72
                move.l  #word_ECB28,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4DB72:                                              ; CODE XREF: Boss_BugmaxToggleMouthSprite+16   j
                move.l  #word_ECB3A,8(a0)
locret_4DB7A:                                           ; CODE XREF: Boss_BugmaxToggleMouthSprite+8   j
                rts
; End of function Boss_BugmaxToggleMouthSprite
; Calculates polar coordinates to position
Math_CalculatePolarPosition:                            ; CODE XREF: Boss_BugmaxUpdateLegs+28   p  ; was: sub_4DB7C
                                        ; Boss_BugmaxUpdateLegs+46   p
                move.w  $50(a0),d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
loc_4DB88:                                              ; CODE XREF: Boss_BugmaxRotateParts1+3A   p
                                        ; Boss_BugmaxRotateParts1+6A   p
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   d3,d0
                add.l   d4,d1
                rts
; End of function Math_CalculatePolarPosition
; Updates boss movement
Boss_BugmaxUpdateMovement:                              ; CODE XREF: Boss_BugmaxMovementPhase1   p  ; was: sub_4DBA4
                                        ; Boss_BugmaxAttackPatternSelect+8   p
                bsr.s   Boss_BugmaxCalculateWave
                bsr.w   Boss_BugmaxHorizontalAI
                bsr.w   Boss_BugmaxVerticalControl
                rts
; End of function Boss_BugmaxUpdateMovement
; Calculates wave motion
Boss_BugmaxCalculateWave:                               ; CODE XREF: Boss_BugmaxFallDown   p  ; was: sub_4DBB0
                                        ; sub_4DBA4   p
                move.l  (dword_FF9408).w,d0
                add.l   d0,(dword_FF9404).w
                move.w  (dword_FF9404).w,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d0
                tst.w   d0
                bmi.s   loc_4DBD4
                muls.w  (dword_FF940C).w,d0
                bra.s   loc_4DBD8
; ---------------------------------------------------------------------------
loc_4DBD4:                                              ; CODE XREF: Boss_BugmaxCalculateWave+1C   j
                muls.w  (dword_FF940C+2).w,d0
loc_4DBD8:                                              ; CODE XREF: Boss_BugmaxCalculateWave+22   j
                move.l  d0,(dword_FF9400).w
                rts
; End of function Boss_BugmaxCalculateWave
; Horizontal AI and player tracking
Boss_BugmaxHorizontalAI:                                ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+4   p  ; was: sub_4DBDE
                                        ; Boss_BugmaxProjectileAttack+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1FE,d0
                move.l  (a0,d0.w),d6
                ext.l   d6
                bpl.s   loc_4DBF0
                neg.l   d6
loc_4DBF0:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+E   j
                asr.l   #2,d6
                move.w  (dword_FFA900).w,d0
                cmpi.w  #$410,d0
                bcc.s   loc_4DC0E
                cmpi.w  #$5E0,$58(a5)
                bgt.s   loc_4DC20
                cmpi.w  #$440,$58(a5)
                blt.s   loc_4DC2A
                bra.s   loc_4DC34
; ---------------------------------------------------------------------------
loc_4DC0E:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+1C   j
                cmpi.w  #$620,$58(a5)
                bgt.s   loc_4DC20
                cmpi.w  #$480,$58(a5)
                blt.s   loc_4DC2A
                bra.s   loc_4DC34
; ---------------------------------------------------------------------------
loc_4DC20:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+24   j
                                        ; Boss_BugmaxHorizontalAI+36   j
                move.l  #$2000,d6
                bra.w   loc_4DC9E
; ---------------------------------------------------------------------------
loc_4DC2A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+2C   j
                                        ; Boss_BugmaxHorizontalAI+3E   j
                move.l  #$2000,d6
                bra.w   loc_4DC98
; ---------------------------------------------------------------------------
loc_4DC34:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+2E   j
                                        ; Boss_BugmaxHorizontalAI+40   j
                btst    #0,(dword_FF9418+1).w
                bne.s   loc_4DC6A
                btst    #1,(dword_FF9418+1).w
                beq.s   loc_4DC60
                tst.l   $18(a5)
                beq.w   locret_4DCDA
                move.l  #$1000,d6
                btst    #7,$18(a5)
                bne.w   loc_4DC98
                bra.w   loc_4DC9E
; ---------------------------------------------------------------------------
loc_4DC60:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+64   j
                move.w  (word_FFA000).w,d7
                andi.w  #$7F,d7
                bne.s   loc_4DCA4
loc_4DC6A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+5C   j
                move.w  (dword_FF9424).w,d0
                beq.s   loc_4DC76
                sub.w   (dword_FFA900).w,d0
                bra.s   loc_4DC7A
; ---------------------------------------------------------------------------
loc_4DC76:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+90   j
                move.w  (word_FF8248).w,d0
loc_4DC7A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+96   j
                sub.w   $10(a5),d0
                move.w  d0,d1
                bpl.s   loc_4DC84
                neg.w   d1
loc_4DC84:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+A2   j
                cmpi.w  #$10,d1
                bcc.s   loc_4DC90
                bset    #0,(dword_FF941C).w
loc_4DC90:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+AA   j
                tst.w   d0
                beq.s   locret_4DCDA
                tst.w   d0
                bmi.s   loc_4DC9E
loc_4DC98:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+52   j
                                        ; Boss_BugmaxHorizontalAI+7A   j
                clr.b   (dword_FF9418).w
                bra.s   loc_4DCA4
; ---------------------------------------------------------------------------
loc_4DC9E:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+48   j
                                        ; Boss_BugmaxHorizontalAI+7E   j
                move.b  #1,(dword_FF9418).w
loc_4DCA4:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+8A   j
                                        ; Boss_BugmaxHorizontalAI+BE   j
                tst.b   (dword_FF9418).w
                bne.s   loc_4DCB0
                add.l   d6,$18(a5)
                bra.s   loc_4DCB4
; ---------------------------------------------------------------------------
loc_4DCB0:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+CA   j
                sub.l   d6,$18(a5)
loc_4DCB4:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+D0   j
                cmpi.l  #$20000,$18(a5)
                blt.s   loc_4DCC8
                move.l  #$20000,$18(a5)
                bra.s   locret_4DCDA
; ---------------------------------------------------------------------------
loc_4DCC8:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+DE   j
                cmpi.l  #$FFFE0000,$18(a5)
                bgt.s   locret_4DCDA
                move.l  #$FFFE0000,$18(a5)
locret_4DCDA:                                           ; CODE XREF: Boss_BugmaxHorizontalAI+6A   j
                                        ; Boss_BugmaxHorizontalAI+B4   j
                rts
; End of function Boss_BugmaxHorizontalAI
; Vertical movement control
Boss_BugmaxVerticalControl:                             ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+4   p  ; was: sub_4DCDC
                                        ; Boss_BugmaxUpdateMovement+6   p
                move.l  #$2000,d7
                move.w  (dword_FF9420).w,d0
                move.w  $14(a5),d1
                cmp.w   d0,d1
                blt.s   loc_4DD14
                add.w   (dword_FF9420+2).w,d0
                cmp.w   d0,d1
                bgt.s   loc_4DD1C
                move.w  (dword_FF9404).w,d0
                subi.w  #$80,d0
                andi.w  #$1FF,d0
                cmpi.w  #$100,d0
                bcc.s   loc_4DD0E
                sub.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD0E:                                              ; CODE XREF: Boss_BugmaxVerticalControl+2A   j
                add.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD14:                                              ; CODE XREF: Boss_BugmaxVerticalControl+10   j
                asr.l   #1,d7
                add.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD1C:                                              ; CODE XREF: Boss_BugmaxVerticalControl+18   j
                asr.l   #1,d7
                sub.l   d7,$1C(a5)
loc_4DD22:                                              ; CODE XREF: Boss_BugmaxVerticalControl+30   j
                                        ; Boss_BugmaxVerticalControl+36   j
                cmpi.l  #$20000,$1C(a5)
                blt.s   loc_4DD36
                move.l  #$20000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4DD36:                                              ; CODE XREF: Boss_BugmaxVerticalControl+4E   j
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_4DD48
                move.l  #$FFFE0000,$1C(a5)
locret_4DD48:                                           ; CODE XREF: Boss_BugmaxVerticalControl+62   j
                rts
; End of function Boss_BugmaxVerticalControl
; Debug control for manual angle adjustment
Boss_BugmaxDebugAngleControl:
                movea.w a5,a0                           ; was: sub_4DD4A
                btst    #2,(word_FFF706).w
                beq.s   loc_4DD5A
                addi.w  #-8,$4C(a0)
loc_4DD5A:                                              ; CODE XREF: Boss_BugmaxDebugAngleControl+8   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4DD68
                addi.w  #8,$4C(a0)
loc_4DD68:                                              ; CODE XREF: Boss_BugmaxDebugAngleControl+16   j
                andi.w  #$1FF,$4C(a0)
                rts
; End of function Boss_BugmaxDebugAngleControl
; Debug control for manual position adjustment
Boss_BugmaxDebugPositionControl:
                btst    #2,(word_FFF706).w              ; was: sub_4DD70
                beq.s   loc_4DD7E
                addi.w  #-2,$10(a5)
loc_4DD7E:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4DD8C
                addi.w  #2,$10(a5)
loc_4DD8C:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+14   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4DDAC
                btst    #5,(word_FFF706).w
                bne.s   loc_4DDA4
                addi.w  #-2,$14(a5)
                bra.s   loc_4DDAC
; ---------------------------------------------------------------------------
loc_4DDA4:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+2A   j
                addi.l  #$A0000,(dword_FF9400).w
loc_4DDAC:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+22   j
                                        ; Boss_BugmaxDebugPositionControl+32   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4DDD0
                btst    #5,(word_FFF706).w
                bne.s   loc_4DDC4
                addi.w  #2,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_4DDC4:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+4A   j
                addi.l  #-$A0000,(dword_FF9400).w
                tst.l   (dword_FF9400).w
locret_4DDD0:                                           ; CODE XREF: Boss_BugmaxDebugPositionControl+42   j
                rts
; End of function Boss_BugmaxDebugPositionControl
; Main boss handler
Boss_ShieldViperMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_4DDD2
                tst.w   4(a5)
                beq.w   loc_4DFDA
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5A(a5)
                bsr.w   Boss_ShieldViperSegmentUpdate
                jsr     (Gfx_InitPaletteFade).l
                btst    #1,(byte_FF80EC).w
                bne.s   loc_4DE16
                tst.w   (word_FF8200).w
                bne.s   loc_4DE16
                move.b  #2,(byte_FF80EC).w
                move.w  #$70,4(a5)                      ; 'p'
                bset    #0,$58(a5)
                bset    #0,(byte_FFA272).w
loc_4DE16:                                              ; CODE XREF: Boss_ShieldViperMain+24   j
                                        ; Boss_ShieldViperMain+2A   j
                btst    #0,$58(a5)
                bne.w   loc_4DFDA
                lea     (word_1B514).l,a3
                move.w  (dword_FF9410).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                move.w  -$80(a3,d0.w),d0
                ext.l   d0
                asl.l   #4,d0
                swap    d0
                move.w  d0,(dword_FF9418+2).w
                move.w  (dword_FF9410+2).w,d0
                add.w   d0,(dword_FF9410).w
                movea.w a5,a0
                bsr.w   Boss_ShieldViperCollision
                btst    #0,(dword_FF9414+1).w
                beq.w   loc_4DF72
                moveq   #0,d5
                moveq   #0,d6
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4DE62:                                              ; CODE XREF: Boss_ShieldViperMain+BC   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   d0,d5
                add.l   d1,d6
                move.l  d5,$48(a0)
                move.l  d6,$4C(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DE62
                movea.w (dword_FF9408).w,a0
                cmpa.w  a5,a0
                beq.s   loc_4DEA6
                move.l  $10(a0),d0
                sub.l   $48(a0),d0
                move.l  d0,$10(a5)
loc_4DEA6:                                              ; CODE XREF: Boss_ShieldViperMain+C6   j
                movea.w (dword_FF9408+2).w,a0
                cmpa.w  a5,a0
                beq.s   loc_4DEBA
                move.l  $14(a0),d0
                sub.l   $4C(a0),d0
                move.l  d0,$14(a5)
loc_4DEBA:                                              ; CODE XREF: Boss_ShieldViperMain+DA   j
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4DEC2:                                              ; CODE XREF: Boss_ShieldViperMain+10C   j
                move.l  $48(a0),d0
                add.l   $10(a5),d0
                move.l  d0,$10(a0)
                move.l  $4C(a0),d0
                add.l   $14(a5),d0
                move.l  d0,$14(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DEC2
                move.w  $4D6(a5),d0
                move.w  #$10,d7
                lea     (a5),a0
loc_4DEEC:                                              ; CODE XREF: Boss_ShieldViperMain+122   j
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DEEC
                move.w  #7,d7
                lea     $600(a5),a1
                lea     $660(a5),a0
loc_4DF04:                                              ; CODE XREF: Boss_ShieldViperMain+160   j
                move.w  $56(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a1),d0
                add.l   $14(a1),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4DF04
                move.w  $656(a5),d0
                add.w   $652(a5),d0
                lea     (word_FF9620).w,a0
                move.w  #$40,d7                         ; '@'
loc_4DF46:                                              ; CODE XREF: Boss_ShieldViperMain+17A   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_4DF46
                lea     (word_FF9620).w,a1
                lea     $660(a5),a0
                moveq   #0,d6
                move.w  #7,d7
loc_4DF5E:                                              ; CODE XREF: Boss_ShieldViperMain+198   j
                lea     $10(a1),a1
                move.w  (a1),$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DF5E
                bra.w   loc_4DFD6
; ---------------------------------------------------------------------------
loc_4DF72:                                              ; CODE XREF: Boss_ShieldViperMain+80   j
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
                move.w  $56(a5),d0
                move.w  $10(a5),d2
                swap    d2
                move.w  $14(a5),d2
                cmp.l   (dword_FF940C).w,d2
                beq.s   loc_4DFA6
                move.l  d2,(dword_FF940C).w
                move.w  #$60,d7                         ; '`'
loc_4DF96:                                              ; CODE XREF: Boss_ShieldViperMain+1D0   j
                move.w  (a1),d1
                move.w  d0,(a1)+
                move.w  d1,d0
                move.l  (a2),d3
                move.l  d2,(a2)+
                move.l  d3,d2
                dbf     d7,loc_4DF96
loc_4DFA6:                                              ; CODE XREF: Boss_ShieldViperMain+1BA   j
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
                lea     $60(a5),a0
                move.w  #$17,d7
loc_4DFB6:                                              ; CODE XREF: Boss_ShieldViperMain+200   j
                lea     8(a1),a1
                move.w  (a1),$56(a0)
                lea     $10(a2),a2
                move.l  (a2),d0
                move.w  d0,$14(a0)
                swap    d0
                move.w  d0,$10(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4DFB6
loc_4DFD6:                                              ; CODE XREF: Boss_ShieldViperMain+19C   j
                bsr.w   Boss_ShieldViperIdleState
loc_4DFDA:                                              ; CODE XREF: Boss_ShieldViperMain+4   j
                                        ; Boss_ShieldViperMain+4A   j
                move.w  4(a5),d0
                lea     off_4DFE6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperMain
; ---------------------------------------------------------------------------
off_4DFE6:      dc.w    Boss_ShieldViperDispatcher-*    ; DATA XREF: Boss_ShieldViperMain+20C   o
                dc.w    Boss_ShieldViperIntroMove-*
                dc.w    Boss_ShieldViper_IntroDelayLoop-*
                dc.w    Boss_ShieldViperIntroStop-*
                dc.w    Boss_ShieldViperBattleStart-*
                dc.w    nullsub_113-*
                dc.w    nullsub_114-*
                dc.w    nullsub_114-*
                dc.w    nullsub_114-*
                dc.w    Boss_ShieldViperInitAttackCycle-*
                dc.w    Boss_ShieldViperWaitForApproach-*
                dc.w    Boss_ShieldViperWaitForAngleMatch-*
                dc.w    Boss_ShieldViperWaitFor90DegRotation-*
                dc.w    Boss_ShieldViperInitRotationSpeed-*
                dc.w    Boss_ShieldViperWaitForRotationSync-*
                dc.w    Boss_ShieldViperMultiPhaseAttack-*
                dc.w    Boss_ShieldViperMultiPhaseAttack_InitRotation-*
                dc.w    Boss_ShieldViperAttackCycleCounter-*
                dc.w    Boss_ShieldViperSetRotationSpeed-*
                dc.w    Boss_ShieldViperWaitForRotationComplete-*
                dc.w    Boss_ShieldViperInitSpinAttack-*
                dc.w    Boss_ShieldViperSpinAttackTimer-*
                dc.w    Boss_ShieldViperSpinAttackUpdate-*
                dc.w    Boss_ShieldViperTransitionState-*
                dc.w    Boss_ShieldViperAdvanceState-*
                dc.w    Boss_ShieldViperSpawnProjectile1-*
                dc.w    Boss_ShieldViperSpawnProjectile1_InitTimers-*
                dc.w    Boss_ShieldViperSpawnProjectile1_AttackLoop-*
                dc.w    Boss_ShieldViperDifficultySetup-*
                dc.w    Boss_ShieldViperWaitAngleMatch-*
                dc.w    Boss_ShieldViperCheckVerticalPosition-*
                dc.w    Boss_ShieldViperRepositionSetup-*
                dc.w    Boss_ShieldViperWaitVerticalThreshold-*
                dc.w    Boss_ShieldViperAccelerateRotation-*
                dc.w    Boss_ShieldViperDelayBeforeFlip-*
                dc.w    Boss_ShieldViperFlipDelay-*
                dc.w    Boss_ShieldViperPrepareMultiShot-*
                dc.w    Boss_ShieldViperWaitRotation180-*
                dc.w    Boss_ShieldViperAscendCheck-*
                dc.w    Boss_ShieldViperDelayRotateUpdate-*
                dc.w    Boss_ShieldViperDelayRotateUpdate_WaitLoop-*
                dc.w    Boss_ShieldViperFlipWaitDelay-*
                dc.w    Boss_ShieldViperSpawnLinkedProjectiles-*
                dc.w    Boss_ShieldViperWaitTransition-*
                dc.w    Boss_ShieldViperSpawnScatteredProjectiles-*
                dc.w    Boss_ShieldViperWaitTimer-*
                dc.w    Boss_ShieldViperQuickTransition-*
                dc.w    Boss_ShieldViperRotateAndAccelerate-*
                dc.w    Boss_ShieldViperDoubleStateAdvance-*
                dc.w    Boss_ShieldViperDoubleStateAdvance_Second-*
                dc.w    Boss_ShieldViperSingleStateAdvance-*
                dc.w    Boss_ShieldViperInitChildEntityTimer-*
                dc.w    Boss_ShieldViperSpawnChildEntityArray-*
                dc.w    Boss_ShieldViperSpawnChildSequentially-*
                dc.w    Boss_ShieldViperChildMovementInit-*
                dc.w    Boss_ShieldViperHalveSpeedAndReset-*
                dc.w    Boss_ShieldViperDefeatInit-*
                dc.w    Projectile_ShieldViperUpdate1-*
                dc.w    Projectile_ShieldViperUpdate2-*
                dc.w    Projectile_ShieldViperExplode-*
                dc.w    Boss_ShieldViperTransitionOut-*

; Boss state dispatcher
Boss_ShieldViperDispatcher:                             ; DATA XREF: ROM:off_4DFE6   o  ; was: sub_4E060
                tst.b   (word_FFF720).w
                bmi.w   locret_4E1DE
                addq.w  #2,4(a5)
                move.w  #$34C,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                clr.w   (dword_FF9404).w
                move.b  #4,(byte_FFA420).w
                move.w  #$50,(dword_FF9418).w           ; 'P'
                move.w  #$14,(dword_FF941C).w
                move.w  a5,(dword_FF9408).w
                move.w  a5,(dword_FF9408+2).w
                move.w  #$160,$10(a5)
                move.w  #$180,$14(a5)
                move.w  #$A300,$E(a5)
                move.w  #$4C00,2(a5)
                move.l  #word_ECF8E,8(a5)
                clr.w   $C(a5)
                move.b  #$10,$20(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #$80,$26(a5)
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                moveq   #0,d6
                move.w  #$17,d7
                clr.w   d6
                lea     $60(a5),a0
                lea     stru_4E1E0(pc),a1
                nop
loc_4E100:                                              ; CODE XREF: Boss_ShieldViperDispatcher+116   j
                move.w  #$A300,$E(a0)
                move.w  #$CC00,2(a0)
                move.w  #$80,$26(a0)
                move.b  $20(a5),$20(a0)
                addq.b  #4,$20(a0)
                move.w  #$14,$24(a0)
                move.w  #$370,(a0)
                move.w  (a1),$50(a0)
                move.b  3(a1),$5E(a0)
                move.l  4(a1),8(a0)
                clr.w   $C(a0)
                lea     8(a1),a1
                cmpi.w  #6,d7
                bmi.s   loc_4E172
                btst    #0,d7
                bne.s   loc_4E16E
                move.b  #$D0,$21(a0)
                move.b  #4,$23(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$10,$24(a0)
                bra.s   loc_4E172
; ---------------------------------------------------------------------------
loc_4E16E:                                              ; CODE XREF: Boss_ShieldViperDispatcher+E8   j
                clr.l   $2C(a0)
loc_4E172:                                              ; CODE XREF: Boss_ShieldViperDispatcher+E2   j
                                        ; Boss_ShieldViperDispatcher+10C   j
                lea     $60(a0),a0
                dbf     d7,loc_4E100
                move.w  #$4C00,2(a0)
                move.w  #$10,(a0)
                move.l  #word_ECFFA,8(a0)
                move.w  #$8300,$E(a0)
                move.w  #$60,$50(a0)                    ; '`'
; End of function Boss_ShieldViperDispatcher
; Intro animation init
Boss_ShieldViperIntroInit:
                lea     $60(a0),a0                      ; was: sub_4E198
                move.w  #$3A8,(a0)
                move.w  #$C00,2(a0)
                move.w  #$18,d7
                move.w  #$80,d0
                movea.w a5,a0
loc_4E1B0:                                              ; CODE XREF: Boss_ShieldViperIntroInit+20   j
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4E1B0
                lea     (word_FF94A0).w,a1
                move.w  #$1F,d7
                move.l  #$800080,d0
loc_4E1CA:                                              ; CODE XREF: Boss_ShieldViperIntroInit+34   j
                move.l  d0,(a1)+
                dbf     d7,loc_4E1CA
                lea     (word_FF9620).w,a1
                move.w  #$1F,d7
loc_4E1D8:                                              ; CODE XREF: Boss_ShieldViperIntroInit+42   j
                move.l  d0,(a1)+
                dbf     d7,loc_4E1D8
locret_4E1DE:                                           ; CODE XREF: Boss_ShieldViperDispatcher+4   j
                rts
; End of function Boss_ShieldViperIntroInit
; ---------------------------------------------------------------------------
stru_4E1E0:     dc.w    $50                             ; field_0
                                        ; DATA XREF: Boss_ShieldViperDispatcher+9A   o
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $50                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE2                      ; field_4
                dc.w    $38                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE2                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE8                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFE8                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFEE                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    1                               ; field_2
                dc.l    word_ECFEE                      ; field_4

; Intro movement
Boss_ShieldViperIntroMove:                              ; DATA XREF: ROM:0004DFE8   o  ; was: sub_4E2A0
                addq.w  #2,4(a5)
                move.w  #$180,$10(a5)
                move.w  #$1A0,$14(a5)
                move.w  #$80,$56(a5)
                move.w  #$80,$48(a5)
; Decrements intro delay counter until ready to advance state
Boss_ShieldViper_IntroDelayLoop:                        ; DATA XREF: ROM:0004DFEA   o  ; was: loc_4E2BC
                subq.w  #1,$48(a5)
                bne.s   locret_4E2CC
                bset    #7,2(a5)
                addq.w  #2,4(a5)
locret_4E2CC:                                           ; CODE XREF: Boss_ShieldViperIntroMove+20   j
                rts
; End of function Boss_ShieldViperIntroMove
; Intro stop position
Boss_ShieldViperIntroStop:                              ; DATA XREF: ROM:0004DFEC   o  ; was: sub_4E2CE
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$E0,$14(a5)
                bgt.s   locret_4E2EE
                addq.w  #2,4(a5)
                move.w  #$FFF8,(dword_FF9400).w
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
locret_4E2EE:                                           ; CODE XREF: Boss_ShieldViperIntroStop+A   j
                rts
; End of function Boss_ShieldViperIntroStop
; Battle start initialization
Boss_ShieldViperBattleStart:                            ; DATA XREF: ROM:0004DFEE   o  ; was: sub_4E2F0
                bsr.w   Boss_ShieldViperAttackState1
                tst.w   (word_FF80C2).w
                bne.s   locret_4E304
                clr.b   (byte_FF80EC).w
                move.w  #$32,4(a5)                      ; '2'
locret_4E304:                                           ; CODE XREF: Boss_ShieldViperBattleStart+8   j
                rts
; End of function Boss_ShieldViperBattleStart
nullsub_113:                                            ; DATA XREF: ROM:0004DFF0   o
                rts
; End of function nullsub_113

nullsub_114:                                            ; DATA XREF: ROM:0004DFF2   o
                                        ; ROM:0004DFF4   o
                rts
; End of function nullsub_114

; Initializes attack cycle with alternating patterns
Boss_ShieldViperInitAttackCycle:                        ; DATA XREF: ROM:0004DFF8   o  ; was: sub_4E30A
                move.w  #$14,(dword_FF941C).w
                addq.w  #2,4(a5)
                move.w  #$180,$14(a5)
                move.w  #$80,$56(a5)
                addq.b  #1,(dword_FF9414+2).w
                btst    #0,(dword_FF9414+2).w
                beq.s   loc_4E340
                move.w  #$180,$10(a5)
                move.w  #$FFFC,(dword_FF9400).w
                move.w  #$100,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_4E340:                                              ; CODE XREF: Boss_ShieldViperInitAttackCycle+20   j
                move.w  #$C0,$10(a5)
                move.w  #4,(dword_FF9400).w
                move.w  #0,$4A(a5)
                rts
; End of function Boss_ShieldViperInitAttackCycle
; Waits for approach to target Y position
Boss_ShieldViperWaitForApproach:                        ; DATA XREF: ROM:0004DFFA   o  ; was: sub_4E354
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$140,$14(a5)
                bgt.s   locret_4E36A
                addq.w  #2,4(a5)
locret_4E36A:                                           ; CODE XREF: Boss_ShieldViperWaitForApproach+10   j
                rts
; End of function Boss_ShieldViperWaitForApproach
; Waits for rotation angle to match target
Boss_ShieldViperWaitForAngleMatch:                      ; DATA XREF: ROM:0004DFFC   o  ; was: sub_4E36C
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmp.w   $4A(a5),d0
                bne.s   locret_4E388
                addq.w  #2,4(a5)
locret_4E388:                                           ; CODE XREF: Boss_ShieldViperWaitForAngleMatch+16   j
                rts
; End of function Boss_ShieldViperWaitForAngleMatch
; Waits for 90 degree rotation and spawns projectile
Boss_ShieldViperWaitFor90DegRotation:                   ; DATA XREF: ROM:0004DFFE   o  ; was: sub_4E38A
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $4D6(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$80,d0
                bne.w   locret_4E3C0
                addq.w  #2,4(a5)
                move.w  d0,$4D6(a5)
                bsr.w   Boss_ShieldViperUpdateSegmentAngles
                lea     $480(a5),a0
                lea     $480(a5),a1
                move.w  a0,(dword_FF9408).w
                move.w  a1,(dword_FF9408+2).w
locret_4E3C0:                                           ; CODE XREF: Boss_ShieldViperWaitFor90DegRotation+16   j
                rts
; End of function Boss_ShieldViperWaitFor90DegRotation
; Initializes rotation speed based on attack direction
Boss_ShieldViperInitRotationSpeed:                      ; DATA XREF: ROM:0004E000   o  ; was: sub_4E3C2
                move.w  #$14,(dword_FF941C).w
                addq.w  #2,4(a5)
                move.w  #$18,(dword_FF9404).w
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E3DE
                neg.w   (dword_FF9404).w
loc_4E3DE:                                              ; CODE XREF: Boss_ShieldViperInitRotationSpeed+16   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                rts
; End of function Boss_ShieldViperInitRotationSpeed
; Waits for rotation to synchronize with target
Boss_ShieldViperWaitForRotationSync:                    ; DATA XREF: ROM:0004E002   o  ; was: sub_4E3E4
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E3FC
                addq.w  #2,4(a5)
locret_4E3FC:                                           ; CODE XREF: Boss_ShieldViperWaitForRotationSync+12   j
                rts
; End of function Boss_ShieldViperWaitForRotationSync
; Executes multi-phase rotating attack
Boss_ShieldViperMultiPhaseAttack:                       ; DATA XREF: ROM:0004E004   o  ; was: sub_4E3FE
                move.w  #$14,(dword_FF941C).w
                move.w  a5,(dword_FF9408).w
                addq.w  #2,4(a5)
                move.w  #$10,(dword_FF9410+2).w
                move.w  #$28,(dword_FF9404).w           ; '('
                move.w  #3,$4A(a5)
; Initialize rotation parameters for multi-phase attack
Boss_ShieldViperMultiPhaseAttack_InitRotation:          ; DATA XREF: ROM:0004E006   o  ; was: loc_4E41E
                move.w  #$14,(dword_FF941C).w
                move.w  #3,d0
                sub.w   $4A(a5),d0
                add.w   d0,d0
                move.w  word_4E44A(pc,d0.w),(dword_FF9404).w
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E440
                neg.w   (dword_FF9404).w
loc_4E440:                                              ; CODE XREF: Boss_ShieldViperMultiPhaseAttack+3C   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperMultiPhaseAttack
; ---------------------------------------------------------------------------
word_4E44A:     dc.w    $20, $3C, $20, $3C, $20
                                        ; DATA XREF: Boss_ShieldViperMultiPhaseAttack+30   r

; Counts remaining attack cycles and loops
Boss_ShieldViperAttackCycleCounter:                     ; DATA XREF: ROM:0004E008   o  ; was: sub_4E454
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E472
                subq.w  #1,$4A(a5)
                beq.s   loc_4E474
                subq.w  #2,4(a5)
locret_4E472:                                           ; CODE XREF: Boss_ShieldViperAttackCycleCounter+12   j
                rts
; ---------------------------------------------------------------------------
loc_4E474:                                              ; CODE XREF: Boss_ShieldViperAttackCycleCounter+18   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperAttackCycleCounter
; Sets rotation speed for next attack phase
Boss_ShieldViperSetRotationSpeed:                       ; DATA XREF: ROM:0004E00A   o  ; was: sub_4E47A
                move.w  #$14,(dword_FF941C).w
                move.w  #$20,(dword_FF9404).w           ; ' '
                btst    #0,(dword_FF9414+2).w
                bne.s   loc_4E492
                neg.w   (dword_FF9404).w
loc_4E492:                                              ; CODE XREF: Boss_ShieldViperSetRotationSpeed+12   j
                bsr.w   Boss_ShieldViperApplyRotationToSegments
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSetRotationSpeed
; Waits for current rotation cycle to complete
Boss_ShieldViperWaitForRotationComplete:                ; DATA XREF: ROM:0004E00C   o  ; was: sub_4E49C
                move.w  #$14,(dword_FF941C).w
                move.w  $54(a5),d0
                sub.w   $52(a5),d0
                andi.w  #$1FF,d0
                bne.s   locret_4E4B4
                addq.w  #2,4(a5)
locret_4E4B4:                                           ; CODE XREF: Boss_ShieldViperWaitForRotationComplete+12   j
                rts
; End of function Boss_ShieldViperWaitForRotationComplete
; Initializes spin attack with 64-frame timer
Boss_ShieldViperInitSpinAttack:                         ; DATA XREF: ROM:0004E00E   o  ; was: sub_4E4B6
                move.w  #$14,(dword_FF941C).w
                move.w  #$40,$48(a5)                    ; '@'
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperInitSpinAttack
; Counts down spin attack timer
Boss_ShieldViperSpinAttackTimer:                        ; DATA XREF: ROM:0004E010   o  ; was: sub_4E4CC
                move.w  #$14,(dword_FF941C).w
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E4E6
                move.w  #$10,$4A(a5)
                addq.w  #2,4(a5)
locret_4E4E6:                                           ; CODE XREF: Boss_ShieldViperSpinAttackTimer+E   j
                rts
; End of function Boss_ShieldViperSpinAttackTimer
; Spawns rotating projectile from boss angle
Projectile_ShieldViperSpawnRotating:                    ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+6   p  ; was: sub_4E4E8
                                        ; sub_4F5F0   p
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$120,d0
                andi.w  #$1C0,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                lea     $960(a5),a0
                eori.w  #$8000,2(a0)
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a5),d0
                add.l   $14(a5),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                rts
; End of function Projectile_ShieldViperSpawnRotating
; Disables projectile by clearing sprite attribute
Projectile_ShieldViperDisable:                          ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+80   p  ; was: sub_4E52A
                                        ; sub_4F64E   p
                andi.w  #$7FFF,$962(a5)
                rts
; End of function Projectile_ShieldViperDisable
; Updates spin attack and spawns projectiles
Boss_ShieldViperSpinAttackUpdate:                       ; DATA XREF: ROM:0004E012   o  ; was: sub_4E532
                move.w  #$14,(dword_FF941C).w
                bsr.w   Projectile_ShieldViperSpawnRotating
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bpl.s   locret_4E5BE
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4E5BE
                jsr     Projectile_ShieldViperSpawnEffect(pc)  ; (pc)
                nop
                move.b  $20(a5),$20(a0)
                move.w  $970(a5),$10(a0)
                move.w  $974(a5),$14(a0)
                lea     (word_1B514).l,a3
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$120,d0
                andi.w  #$1C0,d0
                add.w   (dword_FF9418+2).w,d0
                add.w   (dword_FF9418+2).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                move.w  #2,$48(a5)
                addi.w  #4,$56(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_4E5BE
                bsr.w   Projectile_ShieldViperDisable
                bsr.w   Boss_WolfGaropaMovement1
                addq.w  #2,4(a5)
locret_4E5BE:                                           ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+12   j
                                        ; Boss_ShieldViperSpinAttackUpdate+1A   j
                rts
; End of function Boss_ShieldViperSpinAttackUpdate
; Updates sprite flip based on player position
Boss_ShieldViperUpdateSpriteFlip:                       ; CODE XREF: Boss_ShieldViperInitSpinAttack+C   p  ; was: sub_4E5C0
                                        ; Boss_ShieldViperSpinAttackTimer+6   p
                moveq   #0,d0
                btst    #1,(word_FFA000+1).w
                bne.s   loc_4E5CE
                move.w  #$2000,d0
loc_4E5CE:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+8   j
                move.w  #$18,d7
                movea.w a5,a0
loc_4E5D4:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+3C   j
                andi.w  #$DFFF,$E(a0)
                or.w    d0,$E(a0)
                cmpi.w  #$370,(a0)
                bne.s   loc_4E5F8
                tst.w   $5C(a0)
                beq.s   loc_4E5F8
                movea.w $5C(a0),a1
                andi.w  #$DFFF,$E(a1)
                or.w    d0,$E(a1)
loc_4E5F8:                                              ; CODE XREF: Boss_ShieldViperUpdateSpriteFlip+22   j
                                        ; Boss_ShieldViperUpdateSpriteFlip+28   j
                lea     $60(a0),a0
                dbf     d7,loc_4E5D4
                rts
; End of function Boss_ShieldViperUpdateSpriteFlip
; Movement pattern 1
Boss_WolfGaropaMovement1:                               ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+84   p  ; was: sub_4E602
                                        ; Boss_ShieldViperWaitTransition+A   p
                move.w  #$18,d7
                movea.w a5,a0
loc_4E608:                                              ; CODE XREF: Boss_WolfGaropaMovement1+32   j
                andi.w  #$DFFF,$E(a0)
                ori.w   #$2000,$E(a0)
                cmpi.w  #$370,(a0)
                bne.s   loc_4E630
                tst.w   $5C(a0)
                beq.s   loc_4E630
                movea.w $5C(a0),a1
                andi.w  #$DFFF,$E(a1)
                ori.w   #$2000,$E(a1)
loc_4E630:                                              ; CODE XREF: Boss_WolfGaropaMovement1+16   j
                                        ; Boss_WolfGaropaMovement1+1C   j
                lea     $60(a0),a0
                dbf     d7,loc_4E608
                rts
; End of function Boss_WolfGaropaMovement1
; Triggers state transition and advances pointer
Boss_ShieldViperTransitionState:                        ; DATA XREF: ROM:0004E014   o  ; was: sub_4E63A
                bsr.w   Boss_ShieldViperCalculateTrailPositions
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperTransitionState
; Advances state machine to next state
Boss_ShieldViperAdvanceState:                           ; DATA XREF: ROM:0004E016   o  ; was: sub_4E644
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperAdvanceState
; Spawns projectile type 1
Boss_ShieldViperSpawnProjectile1:                       ; DATA XREF: ROM:0004E018   o  ; was: sub_4E64A
                move.w  #2,$4C(a5)
                clr.w   $4E(a5)
                addq.w  #2,4(a5)
; Initialize attack timers before projectile spawn
Boss_ShieldViperSpawnProjectile1_InitTimers:            ; DATA XREF: ROM:0004E01A   o  ; was: loc_4E658
                move.w  #1,$48(a5)
                move.w  #8,$4A(a5)
                addq.w  #2,4(a5)
; Execute attack state and check for damage application
Boss_ShieldViperSpawnProjectile1_AttackLoop:            ; DATA XREF: ROM:0004E01C   o  ; was: loc_4E668
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E68A
                subq.w  #1,$4A(a5)
                beq.s   loc_4E68C
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                move.w  #$10,$48(a5)
                bsr.w   Boss_ShieldViperDamage
locret_4E68A:                                           ; CODE XREF: Boss_ShieldViperSpawnProjectile1+26   j
                rts
; ---------------------------------------------------------------------------
loc_4E68C:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+2C   j
                subq.w  #1,$4C(a5)
                beq.s   loc_4E69A
                move.w  #$34,4(a5)                      ; '4'
                rts
; ---------------------------------------------------------------------------
loc_4E69A:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+46   j
                addq.w  #1,(word_FF9440).w
                andi.w  #1,(word_FF9440).w
                beq.s   loc_4E6CE
                cmpi.w  #$88,$10(a5)
                bcs.s   loc_4E6CE
                cmpi.w  #$1B8,$10(a5)
                bhi.s   loc_4E6CE
                cmpi.w  #$A8,$14(a5)
                bcs.s   loc_4E6CE
                cmpi.w  #$158,$14(a5)
                bhi.s   loc_4E6CE
                move.w  #$4E,4(a5)                      ; 'N'
                rts
; ---------------------------------------------------------------------------
loc_4E6CE:                                              ; CODE XREF: Boss_ShieldViperSpawnProjectile1+5A   j
                                        ; Boss_ShieldViperSpawnProjectile1+62   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnProjectile1
; Initializes based on difficulty flags
Boss_ShieldViperDifficultySetup:                        ; DATA XREF: ROM:0004E01E   o  ; was: sub_4E6D4
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                move.w  #$120,d0
                btst    #0,(dword_FFFF08).w
                bne.s   loc_4E6F8
                move.w  #$80,$4A(a5)
                move.w  #$80,d1
                bsr.w   Boss_ShieldViperDamage
                rts
; ---------------------------------------------------------------------------
loc_4E6F8:                                              ; CODE XREF: Boss_ShieldViperDifficultySetup+12   j
                move.w  #$180,$4A(a5)
                move.w  #$180,d1
                bsr.w   Boss_ShieldViperDamage
                rts
; End of function Boss_ShieldViperDifficultySetup
; Waits until rotation angle matches target
Boss_ShieldViperWaitAngleMatch:                         ; DATA XREF: ROM:0004E020   o  ; was: sub_4E708
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmp.w   $4A(a5),d0
                bne.s   locret_4E71E
                addq.w  #2,4(a5)
locret_4E71E:                                           ; CODE XREF: Boss_ShieldViperWaitAngleMatch+10   j
                rts
; End of function Boss_ShieldViperWaitAngleMatch
; Monitors vertical position for phase transition
Boss_ShieldViperCheckVerticalPosition:                  ; DATA XREF: ROM:0004E022   o  ; was: sub_4E720
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$180,$4A(a5)
                beq.s   loc_4E73C
                cmpi.w  #$60,$14(a5)                    ; '`'
                bgt.s   locret_4E74A
                move.w  #$3E,4(a5)                      ; '>'
                rts
; ---------------------------------------------------------------------------
loc_4E73C:                                              ; CODE XREF: Boss_ShieldViperCheckVerticalPosition+A   j
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4E74A
                move.w  #$32,4(a5)                      ; '2'
locret_4E74A:                                           ; CODE XREF: Boss_ShieldViperCheckVerticalPosition+12   j
                                        ; Boss_ShieldViperCheckVerticalPosition+22   j
                rts
; End of function Boss_ShieldViperCheckVerticalPosition
; Sets position and rotation based on difficulty
Boss_ShieldViperRepositionSetup:                        ; DATA XREF: ROM:0004E024   o  ; was: sub_4E74C
                addq.w  #2,4(a5)
                move.w  #$60,$14(a5)                    ; '`'
                move.w  #$180,$56(a5)
                addq.b  #1,(dword_FF9414+2).w
                btst    #1,(dword_FF9414+2).w
                beq.s   loc_4E776
                move.w  #$A0,$10(a5)
                move.w  #$FFFE,$4A(a5)
                rts
; ---------------------------------------------------------------------------
loc_4E776:                                              ; CODE XREF: Boss_ShieldViperRepositionSetup+1A   j
                move.w  #$1A0,$10(a5)
                move.w  #2,$4A(a5)
                rts
; End of function Boss_ShieldViperRepositionSetup
; Waits until position reaches threshold
Boss_ShieldViperWaitVerticalThreshold:                  ; DATA XREF: ROM:0004E026   o  ; was: sub_4E784
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$D0,$14(a5)
                blt.s   locret_4E7A0
                move.w  $4A(a5),(dword_FF9400).w
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
locret_4E7A0:                                           ; CODE XREF: Boss_ShieldViperWaitVerticalThreshold+A   j
                rts
; End of function Boss_ShieldViperWaitVerticalThreshold
; Increases rotation speed each cycle
Boss_ShieldViperAccelerateRotation:                     ; DATA XREF: ROM:0004E028   o  ; was: sub_4E7A2
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$FE,d0
                bne.s   locret_4E7C8
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                subq.w  #1,$48(a5)
                bne.s   locret_4E7C8
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4E7C8:                                           ; CODE XREF: Boss_ShieldViperAccelerateRotation+C   j
                                        ; Boss_ShieldViperAccelerateRotation+1A   j
                rts
; End of function Boss_ShieldViperAccelerateRotation
; Wait timer then trigger sprite flip
Boss_ShieldViperDelayBeforeFlip:                        ; DATA XREF: ROM:0004E02A   o  ; was: sub_4E7CA
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E7E2
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4E7E2:                                           ; CODE XREF: Boss_ShieldViperDelayBeforeFlip+8   j
                rts
; End of function Boss_ShieldViperDelayBeforeFlip
; Apply sprite flip and wait timer
Boss_ShieldViperFlipDelay:                              ; DATA XREF: ROM:0004E02C   o  ; was: sub_4E7E4
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E7FC
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4E7FC:                                           ; CODE XREF: Boss_ShieldViperFlipDelay+C   j
                rts
; End of function Boss_ShieldViperFlipDelay
; Prepares for multi-projectile attack
Boss_ShieldViperPrepareMultiShot:                       ; DATA XREF: ROM:0004E02E   o  ; was: sub_4E7FE
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                bsr.w   Boss_ShieldViperSpawnProjectileWithAngle
                subq.w  #1,$48(a5)
                bne.s   locret_4E818
                bsr.w   Debug_DisableProjectilesAndMove
                addq.w  #2,4(a5)
locret_4E818:                                           ; CODE XREF: Boss_ShieldViperPrepareMultiShot+10   j
                rts
; End of function Boss_ShieldViperPrepareMultiShot
; Waits for rotation to reach 180 degrees
Boss_ShieldViperWaitRotation180:                        ; DATA XREF: ROM:0004E030   o  ; was: sub_4E81A
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$180,d0
                bne.s   locret_4E830
                addq.w  #2,4(a5)
locret_4E830:                                           ; CODE XREF: Boss_ShieldViperWaitRotation180+10   j
                rts
; End of function Boss_ShieldViperWaitRotation180
; Monitors vertical position during ascent
Boss_ShieldViperAscendCheck:                            ; DATA XREF: ROM:0004E032   o  ; was: sub_4E832
                bsr.w   Boss_ShieldViperAttackState2
                cmpi.w  #$180,$14(a5)
                blt.s   locret_4E844
                move.w  #$32,4(a5)                      ; '2'
locret_4E844:                                           ; CODE XREF: Boss_ShieldViperAscendCheck+A   j
                rts
; End of function Boss_ShieldViperAscendCheck
; Initializes rotation speed doubling
Boss_ShieldViperDelayRotateUpdate:                      ; DATA XREF: ROM:0004E034   o  ; was: sub_4E846
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
; Wait for delay timer before advancing rotation
Boss_ShieldViperDelayRotateUpdate_WaitLoop:             ; DATA XREF: ROM:0004E036   o  ; was: loc_4E858
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E86C
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4E86C:                                           ; CODE XREF: Boss_ShieldViperDelayRotateUpdate+1A   j
                rts
; End of function Boss_ShieldViperDelayRotateUpdate
; Update sprite flip and wait countdown
Boss_ShieldViperFlipWaitDelay:                          ; DATA XREF: ROM:0004E038   o  ; was: sub_4E86E
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4E880
                addq.w  #2,4(a5)
locret_4E880:                                           ; CODE XREF: Boss_ShieldViperFlipWaitDelay+C   j
                rts
; End of function Boss_ShieldViperFlipWaitDelay
; Spawns linked projectiles with sequential delay
Boss_ShieldViperSpawnLinkedProjectiles:                 ; DATA XREF: ROM:0004E03A   o  ; was: sub_4E882
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                lea     $60(a5),a1
                move.w  #2,d6
                move.w  #$17,d7
loc_4E892:                                              ; CODE XREF: Boss_ShieldViperSpawnLinkedProjectiles+2E   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4E8B4
                move.w  #$10,(a0)
                move.w  a0,$5C(a1)
                move.w  d6,$48(a1)
                addq.w  #2,4(a1)
                addq.w  #2,d6
                lea     $60(a1),a1
                dbf     d7,loc_4E892
loc_4E8B4:                                              ; CODE XREF: Boss_ShieldViperSpawnLinkedProjectiles+16   j
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnLinkedProjectiles
; Waits for timer then transitions pattern
Boss_ShieldViperWaitTransition:                         ; DATA XREF: ROM:0004E03C   o  ; was: sub_4E8BE
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4E8D0
                bsr.w   Boss_WolfGaropaMovement1
                addq.w  #2,4(a5)
locret_4E8D0:                                           ; CODE XREF: Boss_ShieldViperWaitTransition+8   j
                rts
; End of function Boss_ShieldViperWaitTransition
; Spawns randomized projectile array
Boss_ShieldViperSpawnScatteredProjectiles:              ; DATA XREF: ROM:0004E03E   o  ; was: sub_4E8D2
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperGenerateProjectilePattern
                lea     (dword_FF9420).w,a1
                lea     word_4E944(pc),a2
                nop
                move.w  #$B,d7
                move.w  #$20,d6                         ; ' '
                moveq   #0,d5
loc_4E8EE:                                              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+64   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4E93A
                move.w  #$378,(a0)
                move.w  #$4C80,2(a0)
                move.w  $6E(a5),$E(a0)
                move.l  $68(a5),8(a0)
                move.w  (a1)+,d0
                move.w  d0,d1
                lsl.w   #3,d1
                lsl.w   #2,d0
                add.w   d0,d1
                move.w  (a2,d1.w),$10(a0)
                move.w  2(a2,d1.w),$14(a0)
                move.w  4(a2,d1.w),$4C(a0)
                move.w  8(a2,d1.w),$50(a0)
                move.w  d6,$4A(a0)
                addi.w  #$20,d6                         ; ' '
                dbf     d7,loc_4E8EE
loc_4E93A:                                              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+22   j
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSpawnScatteredProjectiles
; ---------------------------------------------------------------------------
word_4E944:     binclude "data/other/word_4E944.bin"
word_4E944_End:

; Generates randomized spawn pattern indices
Boss_ShieldViperGenerateProjectilePattern:              ; CODE XREF: Boss_ShieldViperSpawnScatteredProjectiles+4   p  ; was: sub_4EAC4
                lea     (dword_FF9420).w,a0
                move.w  #9,d7
                moveq   #0,d6
loc_4EACE:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+22   j
                jsr     (RandomNumber).l
                move.w  d6,d0
                btst    #0,(dword_FFFF08).w
                beq.s   loc_4EAE2
                addi.w  #$A,d0
loc_4EAE2:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+18   j
                move.w  d0,(a0)+
                addq.w  #1,d6
                dbf     d7,loc_4EACE
                move.w  #5,d7
                move.w  #$14,d6
loc_4EAF2:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+46   j
                jsr     (RandomNumber).l
                move.w  d6,d0
                btst    #0,(dword_FFFF08).w
                beq.s   loc_4EB06
                addi.w  #6,d0
loc_4EB06:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+3C   j
                move.w  d0,(a0)+
                addq.w  #1,d6
                dbf     d7,loc_4EAF2
                lea     (dword_FF9420).w,a0
                move.w  #7,d7
                moveq   #0,d6
loc_4EB18:                                              ; CODE XREF: Boss_ShieldViperGenerateProjectilePattern+74   j
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d1
                andi.w  #$F,d1
                add.w   d1,d1
                move.w  (a0,d6.w),d2
                move.w  (a0,d1.w),(a0,d6.w)
                move.w  d2,(a0,d1.w)
                addq.w  #2,d6
                dbf     d7,loc_4EB18
                rts
; End of function Boss_ShieldViperGenerateProjectilePattern
; Waits for countdown timer to expire
Boss_ShieldViperWaitTimer:                              ; DATA XREF: ROM:0004E040   o  ; was: sub_4EB3E
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4EB4C
                addq.w  #2,4(a5)
locret_4EB4C:                                           ; CODE XREF: Boss_ShieldViperWaitTimer+8   j
                rts
; End of function Boss_ShieldViperWaitTimer
; Immediately advances to next state
Boss_ShieldViperQuickTransition:                        ; DATA XREF: ROM:0004E042   o  ; was: sub_4EB4E
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperQuickTransition
; Rotates then doubles rotation speed
Boss_ShieldViperRotateAndAccelerate:                    ; DATA XREF: ROM:0004E044   o  ; was: sub_4EB58
                bsr.w   Boss_ShieldViperDamageCenterPoint
                bsr.w   Boss_ShieldViperAttackState1
                move.w  $56(a5),d0
                andi.w  #$1FC,d0
                cmpi.w  #$80,d0
                bne.s   locret_4EB7A
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                addq.w  #2,4(a5)
locret_4EB7A:                                           ; CODE XREF: Boss_ShieldViperRotateAndAccelerate+14   j
                rts
; End of function Boss_ShieldViperRotateAndAccelerate
; Advances state twice in sequence
Boss_ShieldViperDoubleStateAdvance:                     ; DATA XREF: ROM:0004E046   o  ; was: sub_4EB7C
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
; Execute second state advance in double advance
Boss_ShieldViperDoubleStateAdvance_Second:              ; DATA XREF: ROM:0004E048   o  ; was: loc_4EB84
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperDoubleStateAdvance
; Advances state once for next phase
Boss_ShieldViperSingleStateAdvance:                     ; DATA XREF: ROM:0004E04A   o  ; was: sub_4EB8E
                bsr.w   Boss_ShieldViperAttackState1
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperSingleStateAdvance
; Initializes child entity spawn with timer
Boss_ShieldViperInitChildEntityTimer:                   ; DATA XREF: ROM:0004E04C   o  ; was: sub_4EB98
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperInitChildEntityTimer
; Spawns array of 24 child entities
Boss_ShieldViperSpawnChildEntityArray:                  ; DATA XREF: ROM:0004E04E   o  ; was: sub_4EBAC
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4EBD2
                lea     $60(a5),a0
                move.w  a0,$4A(a5)
                move.w  #$18,$4C(a5)
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4EBD2:                                           ; CODE XREF: Boss_ShieldViperSpawnChildEntityArray+C   j
                rts
; End of function Boss_ShieldViperSpawnChildEntityArray
; Spawns child entities in sequence
Boss_ShieldViperSpawnChildSequentially:                 ; DATA XREF: ROM:0004E050   o  ; was: sub_4EBD4
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bpl.s   locret_4EC1A
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4EC1A
                move.w  #$10,(a0)
                movea.w $4A(a5),a1
                move.w  a0,$5C(a1)
                addq.w  #2,4(a1)
                subq.w  #1,$4C(a5)
                beq.s   loc_4EC10
                lea     $60(a1),a1
                move.w  a1,$4A(a5)
                move.w  #8,$48(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EC10:                                              ; CODE XREF: Boss_ShieldViperSpawnChildSequentially+2A   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4EC1A:                                           ; CODE XREF: Boss_ShieldViperSpawnChildSequentially+C   j
                                        ; Boss_ShieldViperSpawnChildSequentially+14   j
                rts
; End of function Boss_ShieldViperSpawnChildSequentially
; Initializes child circular movement
Boss_ShieldViperChildMovementInit:                      ; DATA XREF: ROM:0004E052   o  ; was: sub_4EC1C
                bsr.w   Boss_ShieldViperAttackState1
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                subq.w  #1,$48(a5)
                bne.s   locret_4EC40
                bsr.w   Boss_WolfGaropaMovement1
                move.w  (dword_FF9400).w,d0
                add.w   d0,(dword_FF9400).w
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4EC40:                                           ; CODE XREF: Boss_ShieldViperChildMovementInit+C   j
                rts
; End of function Boss_ShieldViperChildMovementInit
; Halves speed and resets state
Boss_ShieldViperHalveSpeedAndReset:                     ; DATA XREF: ROM:0004E054   o  ; was: sub_4EC42
                bsr.w   Boss_ShieldViperAttackState1
                subq.w  #1,$48(a5)
                bne.s   locret_4EC5C
                move.w  (dword_FF9400).w,d0
                asr.w   #1,d0
                move.w  d0,(dword_FF9400).w
                move.w  #$32,4(a5)                      ; '2'
locret_4EC5C:                                           ; CODE XREF: Boss_ShieldViperHalveSpeedAndReset+8   j
                rts
; End of function Boss_ShieldViperHalveSpeedAndReset
; Defeat sequence init
Boss_ShieldViperDefeatInit:                             ; DATA XREF: ROM:0004E056   o  ; was: sub_4EC5E
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4EC9E
                bsr.w   Boss_WolfGaropaMovement1
                move.w  #$37C,(a0)
                clr.w   4(a0)
                move.l  #stru_4F558,$4C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  $56(a5),$56(a0)
loc_4EC9E:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+6   j
                clr.b   $21(a5)
                bclr    #7,2(a5)
                move.w  #2,d6
                move.w  #$17,d7
                lea     $60(a5),a1
loc_4ECB4:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+96   j
                movea.w a1,a0
                tst.w   $5C(a1)
                beq.s   loc_4ECC6
                movea.w $5C(a1),a0
                move.w  #$1000,2(a1)
loc_4ECC6:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+5C   j
                btst    #7,2(a0)
                beq.s   loc_4ECF0
                move.w  #$37C,(a0)
                clr.w   4(a0)
                move.w  d6,$48(a0)
                addq.w  #2,d6
                tst.b   $5E(a1)
                bne.s   loc_4ECEC
                move.l  #stru_4F598,$4C(a0)
                bra.s   loc_4ECF0
; ---------------------------------------------------------------------------
loc_4ECEC:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+82   j
                clr.l   $4C(a0)
loc_4ECF0:                                              ; CODE XREF: Boss_ShieldViperDefeatInit+6E   j
                                        ; Boss_ShieldViperDefeatInit+8C   j
                lea     $60(a1),a1
                dbf     d7,loc_4ECB4
                move.w  d6,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperDefeatInit
; Projectile update 1
Projectile_ShieldViperUpdate1:                          ; DATA XREF: ROM:0004E058   o  ; was: sub_4ED02
                subq.w  #1,$48(a5)
                bne.s   locret_4ED12
                addi.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4ED12:                                           ; CODE XREF: Projectile_ShieldViperUpdate1+4   j
                rts
; End of function Projectile_ShieldViperUpdate1
; Projectile update 2
Projectile_ShieldViperUpdate2:                          ; DATA XREF: ROM:0004E05A   o  ; was: sub_4ED14
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_4ED28
                clr.w   $48(a5)
                addq.w  #2,4(a5)
locret_4ED28:                                           ; CODE XREF: Projectile_ShieldViperUpdate2+A   j
                rts
; End of function Projectile_ShieldViperUpdate2
; Projectile explosion
Projectile_ShieldViperExplode:                          ; DATA XREF: ROM:0004E05C   o  ; was: sub_4ED2A
                move.w  $48(a5),d0
                andi.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4ED70
                btst    #1,(word_FFA000+1).w
                bne.s   locret_4ED70
                addq.w  #1,$48(a5)
                cmpi.w  #$E,$48(a5)
                bne.s   locret_4ED70
                move.w  #$1000,$9C2(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_4ED70:                                           ; CODE XREF: Projectile_ShieldViperExplode+20   j
                                        ; Projectile_ShieldViperExplode+28   j
                rts
; End of function Projectile_ShieldViperExplode
; Transition out of boss
Boss_ShieldViperTransitionOut:                          ; DATA XREF: ROM:0004E05E   o  ; was: sub_4ED72
                move.w  #$E,d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jsr     (Gfx_ApplyPaletteFade).l
                subq.w  #1,$48(a5)
                bne.s   locret_4ED94
                move.w  #$1000,2(a5)
locret_4ED94:                                           ; CODE XREF: Boss_ShieldViperTransitionOut+1A   j
                rts
; End of function Boss_ShieldViperTransitionOut
; Spawns projectile type 2
Boss_ShieldViperSpawnProjectile2:                       ; DATA XREF: ROM:off_5DC   o  ; was: sub_4ED96
                movea.w a5,a0
                bsr.w   Boss_ShieldViperCollision
                move.w  4(a5),d0
                lea     off_4EDA8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperSpawnProjectile2
; ---------------------------------------------------------------------------
off_4EDA8:      dc.w    nullsub_115-*                   ; DATA XREF: Boss_ShieldViperSpawnProjectile2+A   o
                dc.w    Boss_ShieldViperChildCircularMotion-*
                dc.w    Boss_ShieldViperChildCircularMotion_UpdateLoop-*
                dc.w    Boss_ShieldViperChildBoundsCheck-*
                dc.w    nullsub_116-*
                dc.w    Boss_ShieldViperChildSpinAttack-*
                dc.w    Boss_ShieldViperChildSpinAttack_DecelerateLoop-*
                dc.w    Boss_ShieldViperChildReturnToParent-*

nullsub_115:                                            ; DATA XREF: ROM:off_4EDA8   o
                rts
; End of function nullsub_115

; Controls child entity circular motion
Boss_ShieldViperChildCircularMotion:                    ; DATA XREF: ROM:0004EDAA   o  ; was: sub_4EDBA
                movea.w $5C(a5),a0
                move.w  2(a5),2(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                andi.w  #$1FF,d0
                move.w  d0,$56(a0)
                clr.w   $50(a0)
                andi.w  #$7FFF,2(a5)
                move.b  $21(a5),$5A(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
; Update child position during circular motion
Boss_ShieldViperChildCircularMotion_UpdateLoop:         ; DATA XREF: ROM:0004EDAC   o  ; was: loc_4EDFE
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4EE52
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                btst    #7,(dword_FF9400).w
                beq.s   loc_4EE28
                addi.w  #-$80,d0
                bra.s   loc_4EE2C
; ---------------------------------------------------------------------------
loc_4EE28:                                              ; CODE XREF: Boss_ShieldViperChildCircularMotion+66   j
                addi.w  #$80,d0
loc_4EE2C:                                              ; CODE XREF: Boss_ShieldViperChildCircularMotion+6C   j
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  #$10,d0
                muls.w  #$10,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                addq.w  #2,4(a5)
locret_4EE52:                                           ; CODE XREF: Boss_ShieldViperChildCircularMotion+56   j
                rts
; End of function Boss_ShieldViperChildCircularMotion
; Checks child entity screen bounds
Boss_ShieldViperChildBoundsCheck:                       ; DATA XREF: ROM:0004EDAE   o  ; was: sub_4EE54
                movea.w $5C(a5),a0
                tst.b   $5E(a5)
                bne.s   loc_4EE62
                bsr.w   Projectile_ShieldViperUpdateRotation
loc_4EE62:                                              ; CODE XREF: Boss_ShieldViperChildBoundsCheck+8   j
                cmpi.w  #$60,$10(a0)                    ; '`'
                bcs.s   loc_4EE84
                cmpi.w  #$1E0,$10(a0)
                bhi.s   loc_4EE84
                cmpi.w  #$60,$14(a0)                    ; '`'
                bcs.s   loc_4EE84
                cmpi.w  #$1A0,$14(a0)
                bhi.s   loc_4EE84
                rts
; ---------------------------------------------------------------------------
loc_4EE84:                                              ; CODE XREF: Boss_ShieldViperChildBoundsCheck+14   j
                                        ; Boss_ShieldViperChildBoundsCheck+1C   j
                andi.w  #$7FFF,2(a0)
                move.w  #$1000,2(a0)
                clr.w   $5C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ShieldViperChildBoundsCheck
nullsub_116:                                            ; DATA XREF: ROM:0004EDB0   o
                rts
; End of function nullsub_116

; Spawns spinning child entity
Boss_ShieldViperChildSpinAttack:                        ; DATA XREF: ROM:0004EDB2   o  ; was: sub_4EE9C
                movea.w $5C(a5),a0
                move.w  2(a5),2(a0)
                bset    #7,2(a0)
                move.l  8(a5),8(a0)
                move.w  $E(a5),$E(a0)
                move.b  $20(a5),$20(a0)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$80,d0
                andi.w  #$1FF,d0
                move.w  d0,$56(a0)
                move.w  #$300,$50(a0)
                addq.w  #2,4(a5)
; Decelerate child during spin attack
Boss_ShieldViperChildSpinAttack_DecelerateLoop:         ; DATA XREF: ROM:0004EDB4   o  ; was: loc_4EEDC
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subi.w  #$10,$50(a0)
                bne.s   locret_4EEFC
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4EEFC:                                           ; CODE XREF: Boss_ShieldViperChildSpinAttack+54   j
                rts
; End of function Boss_ShieldViperChildSpinAttack
; Returns child to parent after attack
Boss_ShieldViperChildReturnToParent:                    ; DATA XREF: ROM:0004EDB6   o  ; was: sub_4EEFE
                movea.w $5C(a5),a0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperChildPositionUpdate
                subq.w  #1,$48(a5)
                bne.s   locret_4EF2C
                move.b  $5A(a5),$21(a5)
                ori.w   #$8000,2(a5)
                move.w  #$1000,2(a0)
                clr.w   $5C(a5)
                clr.w   4(a5)
locret_4EF2C:                                           ; CODE XREF: Boss_ShieldViperChildReturnToParent+12   j
                rts
; End of function Boss_ShieldViperChildReturnToParent
; Main handler for bullet state machine
Projectile_ShieldViperBulletMain:                       ; DATA XREF: ROM:off_5DC   o  ; was: sub_4EF2E
                btst    #0,(word_FFC678).w
                beq.s   loc_4EF5E
                btst    #7,2(a5)
                beq.s   loc_4EF56
                move.w  #4,$48(a5)
                move.l  #stru_4F598,$4C(a5)
                move.w  #$37C,(a5)
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EF56:                                              ; CODE XREF: Projectile_ShieldViperBulletMain+E   j
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4EF5E:                                              ; CODE XREF: Projectile_ShieldViperBulletMain+6   j
                move.w  4(a5),d0
                lea     off_4EF6A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_ShieldViperBulletMain
; ---------------------------------------------------------------------------
off_4EF6A:      dc.w    Projectile_ShieldViperBulletInit-*  ; DATA XREF: Projectile_ShieldViperBulletMain+34   o
                dc.w    Projectile_ShieldViperBulletBlink-*
                dc.w    Projectile_ShieldViperBulletBounds-*

; Initializes bullet with hitbox and visuals
Projectile_ShieldViperBulletInit:                       ; DATA XREF: ROM:off_4EF6A   o  ; was: sub_4EF70
                subq.w  #1,$4A(a5)
                bne.s   locret_4EFA2
                move.w  #$10,$48(a5)
                move.b  #$C0,$21(a5)
                move.b  #$10,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$80,$26(a5)
                addq.w  #2,4(a5)
locret_4EFA2:                                           ; CODE XREF: Projectile_ShieldViperBulletInit+4   j
                rts
; End of function Projectile_ShieldViperBulletInit
; Animates bullet blinking for 16 frames
Projectile_ShieldViperBulletBlink:                      ; DATA XREF: ROM:0004EF6C   o  ; was: sub_4EFA4
                bsr.w   Projectile_ShieldViperCopyEntity
                btst    #0,(word_FFA000+1).w
                beq.s   loc_4EFB8
                bclr    #7,2(a5)
                bra.s   loc_4EFBE
; ---------------------------------------------------------------------------
loc_4EFB8:                                              ; CODE XREF: Projectile_ShieldViperBulletBlink+A   j
                bset    #7,2(a5)
loc_4EFBE:                                              ; CODE XREF: Projectile_ShieldViperBulletBlink+12   j
                subq.w  #1,$48(a5)
                bne.s   locret_4EFDA
                bset    #7,2(a5)
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_4EFDA:                                           ; CODE XREF: Projectile_ShieldViperBulletBlink+1E   j
                rts
; End of function Projectile_ShieldViperBulletBlink
; Checks bounds and destroys when outside
Projectile_ShieldViperBulletBounds:                     ; DATA XREF: ROM:0004EF6E   o  ; was: sub_4EFDC
                bsr.w   Projectile_ShieldViperCopyEntity
                btst    #7,$18(a5)
                bne.s   loc_4EFF2
                cmpi.w  #$1E0,$10(a5)
                bhi.s   loc_4F016
                bra.s   loc_4EFFA
; ---------------------------------------------------------------------------
loc_4EFF2:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+A   j
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_4F016
loc_4EFFA:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+14   j
                btst    #7,$1C(a5)
                bne.s   loc_4F00C
                cmpi.w  #$1A0,$14(a5)
                bhi.s   loc_4F016
                bra.s   locret_4F01C
; ---------------------------------------------------------------------------
loc_4F00C:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+24   j
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_4F016
                rts
; ---------------------------------------------------------------------------
loc_4F016:                                              ; CODE XREF: Projectile_ShieldViperBulletBounds+12   j
                                        ; Projectile_ShieldViperBulletBounds+1C   j
                move.w  #$1000,2(a5)
locret_4F01C:                                           ; CODE XREF: Projectile_ShieldViperBulletBounds+2E   j
                rts
; End of function Projectile_ShieldViperBulletBounds
; Copies entity pointer for processing
Projectile_ShieldViperCopyEntity:                       ; CODE XREF: Projectile_ShieldViperBulletBlink   p  ; was: sub_4F01E
                                        ; sub_4EFDC   p
                movea.w a5,a0
; End of function Projectile_ShieldViperCopyEntity
; Updates projectile rotation by 16 per frame
Projectile_ShieldViperUpdateRotation:                   ; CODE XREF: Boss_ShieldViperChildBoundsCheck+A   p  ; was: sub_4F020
                move.w  $56(a0),d0
                lea     stru_4F598(pc),a1
                nop
                bsr.w   Boss_ShieldViperMovement1
                addi.w  #$10,$56(a0)
                rts
; End of function Projectile_ShieldViperUpdateRotation
; Updates child position using circular trajectory
Boss_ShieldViperChildPositionUpdate:                    ; CODE XREF: Boss_ShieldViperChildCircularMotion+4E   p  ; was: sub_4F036
                                        ; Boss_ShieldViperChildSpinAttack+4A   p
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                btst    #7,(dword_FF9400).w
                beq.s   loc_4F04C
                addi.w  #-$80,d0
                bra.s   loc_4F050
; ---------------------------------------------------------------------------
loc_4F04C:                                              ; CODE XREF: Boss_ShieldViperChildPositionUpdate+E   j
                addi.w  #$80,d0
loc_4F050:                                              ; CODE XREF: Boss_ShieldViperChildPositionUpdate+14   j
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                muls.w  $50(a0),d0
                muls.w  $50(a0),d1
                add.l   $10(a5),d0
                add.l   $14(a5),d1
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                tst.b   $5E(a5)
                bne.s   locret_4F08E
                move.w  $54(a0),d0
                bsr.w   Boss_ShieldViperMovement1
                addi.w  #$10,$54(a0)
locret_4F08E:                                           ; CODE XREF: Boss_ShieldViperChildPositionUpdate+48   j
                rts
; End of function Boss_ShieldViperChildPositionUpdate
; Boss collision handler
Boss_ShieldViperCollision:                              ; CODE XREF: Boss_ShieldViperMain+76   p  ; was: sub_4F090
                                        ; Boss_ShieldViperSpawnProjectile2+2   p
                move.w  #1,d7
loc_4F094:                                              ; CODE XREF: Boss_ShieldViperCollision:loc_4F0B4   j
                move.w  $54(a0),d0
                sub.w   $52(a0),d0
                andi.w  #$1FF,d0
                beq.s   locret_4F0B8
                cmpi.w  #$100,d0
                bcs.w   loc_4F0B0
                subq.w  #1,$52(a0)
                bra.s   loc_4F0B4
; ---------------------------------------------------------------------------
loc_4F0B0:                                              ; CODE XREF: Boss_ShieldViperCollision+16   j
                addq.w  #1,$52(a0)
loc_4F0B4:                                              ; CODE XREF: Boss_ShieldViperCollision+1E   j
                dbf     d7,loc_4F094
locret_4F0B8:                                           ; CODE XREF: Boss_ShieldViperCollision+10   j
                rts
; End of function Boss_ShieldViperCollision
; Spawns collision effect with sound
Projectile_ShieldViperSpawnEffect:                      ; CODE XREF: Boss_ShieldViperSpinAttackUpdate+1C   p  ; was: sub_4F0BA
                                        ; Boss_ShieldViperSpawnProjectileWithAngle+18   p
                move.w  #$374,(a0)
                move.w  #$CC80,2(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FF01FF01,$2C(a0)
                move.l  #word_ECFF4,8(a0)
                move.w  #$8300,$E(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.w  #$10,$48(a0)
                clr.w   $C(a0)
                btst    #1,(word_FFA000+1).w
                bne.s   locret_4F10A
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4F10A
                move.b  #$58,d0                         ; 'X'
                jsr     (Sound_PlaySFX).l
locret_4F10A:                                           ; CODE XREF: Projectile_ShieldViperSpawnEffect+3C   j
                                        ; Projectile_ShieldViperSpawnEffect+44   j
                rts
; End of function Projectile_ShieldViperSpawnEffect
; Handles bullet animation timing
Projectile_ShieldViperBulletAnimation:                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F10C
                bclr    #4,$22(a5)
                bne.s   loc_4F154
                tst.w   4(a5)
                beq.s   loc_4F126
                subq.w  #1,$48(a5)
                bne.s   locret_4F15C
                clr.w   4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F126:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+C   j
                move.w  $5C(a5),d0
                lea     stru_4F15E(pc),a1
                nop
                move.w  (a1,d0.w),$48(a5)
                bmi.s   loc_4F14C
                move.l  4(a1,d0.w),8(a5)
                clr.w   $C(a5)
                addq.w  #8,$5C(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F14C:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+2A   j
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_4F154:                                              ; CODE XREF: Projectile_ShieldViperBulletAnimation+6   j
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
locret_4F15C:                                           ; CODE XREF: Projectile_ShieldViperBulletAnimation+12   j
                rts
; End of function Projectile_ShieldViperBulletAnimation
; ---------------------------------------------------------------------------
stru_4F15E:     dc.w    2                               ; field_0
                                        ; DATA XREF: Projectile_ShieldViperBulletAnimation+1E   o
                dc.w    0                               ; field_2
                dc.l    word_ECFF4                      ; field_4
                dc.w    2                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ECFFA                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED000                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED006                      ; field_4
                dc.w    4                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED00C                      ; field_4
                dc.w    4                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED012                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED018                      ; field_4
                dc.w    3                               ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED01E                      ; field_4
                dc.w    $FFFF                           ; field_0
                dc.w    0                               ; field_2
                dc.l    word_ED01E                      ; field_4

; Defeat main handler
Boss_ShieldViperDefeatMain:                             ; DATA XREF: ROM:off_5DC   o  ; was: sub_4F1A6
                move.w  4(a5),d0
                lea     off_4F1B2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ShieldViperDefeatMain
; ---------------------------------------------------------------------------
off_4F1B2:      dc.w    Boss_ShieldViperDefeatState1-*  ; DATA XREF: Boss_ShieldViperDefeatMain+4   o
                dc.w    Boss_ShieldViperDefeatState2-*
                dc.w    nullsub_117-*

; Defeat state 1
Boss_ShieldViperDefeatState1:                           ; DATA XREF: ROM:off_4F1B2   o  ; was: sub_4F1B8
                subq.w  #1,$48(a5)
                bpl.s   locret_4F1FA
                move.w  #$CE80,2(a5)
                clr.b   $21(a5)
                addq.w  #2,4(a5)
                bsr.w   Boss_ShieldViperDefeatEffect
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asr.l   #3,d0
                asr.l   #3,d1
                move.l  d0,$58(a5)
                move.l  d1,$5C(a5)
locret_4F1FA:                                           ; CODE XREF: Boss_ShieldViperDefeatState1+4   j
                rts
; End of function Boss_ShieldViperDefeatState1
; Defeat state 2
Boss_ShieldViperDefeatState2:                           ; DATA XREF: ROM:0004F1B4   o  ; was: sub_4F1FC
                move.l  $58(a5),d0
                add.l   d0,$18(a5)
                move.l  $5C(a5),d0
                add.l   d0,$1C(a5)
                tst.l   $4C(a5)
                beq.s   locret_4F22A
                movea.l $4C(a5),a1
                movea.w a5,a0
                addi.w  #$10,$56(a5)
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                bsr.w   Boss_ShieldViperMovement1
locret_4F22A:                                           ; CODE XREF: Boss_ShieldViperDefeatState2+14   j
                rts
; End of function Boss_ShieldViperDefeatState2
; Defeat visual effect
Boss_ShieldViperDefeatEffect:                           ; CODE XREF: Boss_ShieldViperDefeatState1+14   p  ; was: sub_4F22C
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4F26A
                move.l  #off_E9560,8(a0)
                jsr     (Projectile_InitType88).l
                clr.b   $20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #$FFFE0000,$1C(a0)
                tst.w   $2C(a5)
                beq.s   locret_4F26A
                move.b  #$C1,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_4F26A:                                           ; CODE XREF: Boss_ShieldViperDefeatEffect+6   j
                                        ; Boss_ShieldViperDefeatEffect+32   j
                rts
; End of function Boss_ShieldViperDefeatEffect
nullsub_117:                                            ; DATA XREF: ROM:0004F1B6   o
                rts
; End of function nullsub_117

; Idle state handler
Boss_ShieldViperIdleState:                              ; CODE XREF: Boss_ShieldViperMain:loc_4DFD6   p  ; was: sub_4F26E
                move.w  (dword_FF941C+2).w,d0
                add.w   d0,d0
                move.w  word_4F28C(pc,d0.w),d0
                addi.w  #$10,d0
                move.w  d0,(dword_FF941C).w
                addq.w  #1,(dword_FF941C+2).w
                andi.w  #$1F,(dword_FF941C+2).w
                rts
; End of function Boss_ShieldViperIdleState
; ---------------------------------------------------------------------------
word_4F28C:     dc.w    0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1
                                        ; DATA XREF: Boss_ShieldViperIdleState+6   r
                dc.w    0, $FFFF, $FFFE, $FFFD, $FFFC, $FFFB, $FFFA, $FFF9, $FFF8, $FFF9, $FFFA, $FFFB, $FFFC, $FFFD, $FFFE, $FFFF

; Calculates 4 interpolated trail positions
Boss_ShieldViperCalculateTrailPositions:                ; CODE XREF: Boss_ShieldViperTransitionState   p  ; was: sub_4F2CC
                bclr    #0,(dword_FF9414+1).w
                move.w  #$18,d7
                lea     (a5),a0
                lea     (word_FF94A0).w,a1
                lea     (dword_FF9700).w,a2
loc_4F2E0:                                              ; CODE XREF: Boss_ShieldViperCalculateTrailPositions+5A   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                move.w  d0,$56(a0)
                clr.w   $52(a0)
                clr.w   $54(a0)
                move.w  $70(a0),d1
                sub.w   $10(a0),d1
                asr.w   #3,d1
                move.w  $74(a0),d2
                sub.w   $14(a0),d2
                asr.w   #3,d2
                move.w  $10(a0),d3
                move.w  $14(a0),d4
                move.w  #3,d6
loc_4F314:                                              ; CODE XREF: Boss_ShieldViperCalculateTrailPositions+52   j
                move.w  d0,(a1)+
                move.w  d3,(a2)+
                move.w  d4,(a2)+
                add.w   d1,d3
                add.w   d2,d4
                dbf     d6,loc_4F314
                lea     $60(a0),a0
                dbf     d7,loc_4F2E0
                rts
; End of function Boss_ShieldViperCalculateTrailPositions
; Updates rotation angles for all shield viper body segments based on head position
Boss_ShieldViperUpdateSegmentAngles:                    ; CODE XREF: Boss_ShieldViperWaitFor90DegRotation+22   p  ; was: sub_4F32C
                bset    #0,(dword_FF9414+1).w
                move.w  #$10,d7
                move.w  $4D6(a5),d0
                lea     (a5),a0
loc_4F33C:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+26   j
                move.w  $56(a0),d1
                sub.w   d0,d1
                move.w  d1,$52(a0)
                move.w  d1,$54(a0)
                move.w  d0,$56(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4F33C
                lea     $660(a5),a0
                lea     (word_FF9620).w,a1
                move.w  #7,d7
loc_4F362:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+48   j
                move.w  $56(a0),d0
                move.w  #7,d6
loc_4F36A:                                              ; CODE XREF: Boss_ShieldViperUpdateSegmentAngles+40   j
                move.w  d0,(a1)+
                dbf     d6,loc_4F36A
                lea     $60(a0),a0
                dbf     d7,loc_4F362
                move.w  d0,(a1)
                rts
; End of function Boss_ShieldViperUpdateSegmentAngles
; Attack state 1 handler
Boss_ShieldViperAttackState1:                           ; CODE XREF: Boss_ShieldViperBattleStart   p  ; was: sub_4F37C
                                        ; Boss_ShieldViperWaitForAngleMatch+6   p
                move.w  (dword_FF9400).w,d0
                add.w   d0,$56(a5)
                bsr.w   Boss_ShieldViperAttackState2
                rts
; End of function Boss_ShieldViperAttackState1
; Boss damage handler
Boss_ShieldViperDamage:                                 ; CODE XREF: Boss_ShieldViperSpawnProjectile1+3C   p  ; was: sub_4F38A
                                        ; Boss_ShieldViperDifficultySetup+1E   p
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                addi.w  #$100,d2
                sub.w   $56(a5),d2
                andi.w  #$1FF,d2
                cmpi.w  #$100,d2
                bcs.s   loc_4F3B2
                move.w  #$FFFC,(dword_FF9400).w
                bra.s   locret_4F3B8
; ---------------------------------------------------------------------------
loc_4F3B2:                                              ; CODE XREF: Boss_ShieldViperDamage+1E   j
                move.w  #4,(dword_FF9400).w
locret_4F3B8:                                           ; CODE XREF: Boss_ShieldViperDamage+26   j
                rts
; End of function Boss_ShieldViperDamage
; Calls shield viper damage check every 8 frames using player position
Boss_ShieldViperDamageEvery8Frames:
                move.w  (word_FFA000).w,d7              ; was: sub_4F3BA
                andi.w  #7,d7
                bne.s   locret_4F3D0
                move.w  (word_FF8248).w,d0
                move.w  (word_FF824A).w,d1
                bsr.w   Boss_ShieldViperDamage
locret_4F3D0:                                           ; CODE XREF: Boss_ShieldViperDamageEvery8Frames+8   j
                rts
; End of function Boss_ShieldViperDamageEvery8Frames
; Calls shield viper damage check at fixed center position (120,F0)
Boss_ShieldViperDamageCenterPoint:                      ; CODE XREF: Boss_ShieldViperRotateAndAccelerate   p  ; was: sub_4F3D2
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4F3E8
                move.w  #$120,d0
                move.w  #$F0,d1
                bsr.w   Boss_ShieldViperDamage
locret_4F3E8:                                           ; CODE XREF: Boss_ShieldViperDamageCenterPoint+8   j
                rts
; End of function Boss_ShieldViperDamageCenterPoint
; Calculates interpolated angles for shield viper segments between current and target angles
Boss_ShieldViperCalculateSegmentAngles:
                lea     (word_FF94A0).w,a1              ; was: sub_4F3EA
                move.w  #$F,d7
                lea     $60(a5),a0
loc_4F3F6:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+42   j
                move.w  $56(a0),d0
                move.w  $B6(a0),d1
                sub.w   d0,d1
                andi.w  #$1FF,d1
                cmpi.w  #$100,d1
                bcc.s   loc_4F40C
                bra.s   loc_4F41A
; ---------------------------------------------------------------------------
loc_4F40C:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+1E   j
                move.w  #$200,d2
                sub.w   d1,d2
                andi.w  #$1FF,d2
                move.w  d2,d1
                neg.w   d1
loc_4F41A:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+20   j
                asr.w   #3,d1
                move.w  #3,d6
loc_4F420:                                              ; CODE XREF: Boss_ShieldViperCalculateSegmentAngles+3A   j
                move.w  d0,(a1)+
                add.w   d1,d0
                dbf     d6,loc_4F420
                lea     $60(a0),a0
                dbf     d7,loc_4F3F6
                clr.w   (dword_FF9404).w
                rts
; End of function Boss_ShieldViperCalculateSegmentAngles
; Clamps shield viper X position between A0 and 150
Boss_ShieldViperClampXPosition:
                cmpi.w  #$A0,$14(a0)                    ; was: sub_4F436
                bgt.s   loc_4F444
                move.w  #$A2,$14(a0)
loc_4F444:                                              ; CODE XREF: Boss_ShieldViperClampXPosition+6   j
                cmpi.w  #$150,$14(a0)
                blt.s   locret_4F452
                move.w  #$14E,$14(a0)
locret_4F452:                                           ; CODE XREF: Boss_ShieldViperClampXPosition+14   j
                rts
; End of function Boss_ShieldViperClampXPosition
; Calculates rotation delta and direction for shield viper movement
Boss_ShieldViperCalculateRotationDelta:
                clr.w   $48(a5)                         ; was: sub_4F454
                sub.w   (dword_FF9404).w,d0
                beq.w   locret_4F478
                tst.w   d0
                bpl.s   loc_4F46E
                move.w  #$FFFF,$4C(a5)
                neg.w   d0
                bra.s   loc_4F474
; ---------------------------------------------------------------------------
loc_4F46E:                                              ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+E   j
                move.w  #1,$4C(a5)
loc_4F474:                                              ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+18   j
                move.w  d0,$48(a5)
locret_4F478:                                           ; CODE XREF: Boss_ShieldViperCalculateRotationDelta+8   j
                rts
; End of function Boss_ShieldViperCalculateRotationDelta
; Applies rotation delta to all shield viper body segments
Boss_ShieldViperApplyRotationToSegments:                ; CODE XREF: Boss_ShieldViperInitRotationSpeed:loc_4E3DE   p  ; was: sub_4F47A
                                        ; sub_4E3FE:loc_4E440   p
                move.w  (dword_FF9404).w,d5
                move.w  #2,d7
                lea     $480(a5),a0
                movea.w a0,a1
                moveq   #0,d0
                moveq   #0,d1
loc_4F48C:                                              ; CODE XREF: Boss_ShieldViperApplyRotationToSegments+26   j
                lea     -$60(a0),a0
                lea     $60(a1),a1
                add.w   d5,d0
                sub.w   d5,d1
                move.w  d0,$54(a0)
                move.w  d1,$54(a1)
                dbf     d7,loc_4F48C
                lea     -$60(a0),a0
                lea     $60(a1),a1
                sub.w   d5,d0
                sub.w   d5,d1
                move.w  d0,$54(a0)
                move.w  d1,$54(a1)
                move.w  #7,d7
loc_4F4BC:                                              ; CODE XREF: Boss_ShieldViperApplyRotationToSegments+4C   j
                lea     -$60(a0),a0
                sub.w   d5,d0
                move.w  d0,$54(a0)
                dbf     d7,loc_4F4BC
                rts
; End of function Boss_ShieldViperApplyRotationToSegments
; Attack state 2 handler
Boss_ShieldViperAttackState2:                           ; CODE XREF: Boss_ShieldViperIntroStop   p  ; was: sub_4F4CC
                                        ; Boss_ShieldViperWaitForApproach+6   p
                move.w  $56(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a3
                move.w  word_1B494-word_1B514(a3,d0.w),d1
loc_4F4E2:
                move.w  (a3,d0.w),d0
                move.w  (dword_FF941C).w,d2
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   d0,$10(a5)
                add.l   d1,$14(a5)
                rts
; End of function Boss_ShieldViperAttackState2
; Updates snake segments
Boss_ShieldViperSegmentUpdate:                          ; CODE XREF: Boss_ShieldViperMain+14   p  ; was: sub_4F4F8
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                lea     stru_4F558(pc),a1
                nop
                movea.w a5,a0
                bsr.w   Boss_ShieldViperMovement1
                move.w  #$11,d7
                lea     $60(a5),a0
                lea     stru_4F598(pc),a1
                nop
loc_4F51A:                                              ; CODE XREF: Boss_ShieldViperSegmentUpdate+32   j
                move.w  $56(a0),d0
                add.w   $52(a0),d0
                bsr.w   Boss_ShieldViperMovement1
                lea     $60(a0),a0
                dbf     d7,loc_4F51A
                rts
; End of function Boss_ShieldViperSegmentUpdate
; Movement pattern 1
Boss_ShieldViperMovement1:                              ; CODE XREF: Projectile_ShieldViperUpdateRotation+A   p  ; was: sub_4F530
                                        ; Boss_ShieldViperChildPositionUpdate+4E   p
                addi.w  #$20,d0                         ; ' '
                andi.w  #$1C0,d0
                lsr.w   #3,d0
                lea     (a1,d0.w),a2
                move.w  (a2),d0
                andi.w  #$F7FF,$E(a0)
                andi.w  #$EFFF,$E(a0)
                or.w    d0,$E(a0)
                move.l  4(a2),8(a0)
                rts
; End of function Boss_ShieldViperMovement1
; ---------------------------------------------------------------------------
stru_4F558:     dc.w    0                               ; field_0
                                        ; DATA XREF: Boss_ShieldViperDefeatInit+14   o
                                        ; Boss_ShieldViperSegmentUpdate+8   o
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF8E                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFA6                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFB8                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFD0                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF8E                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFA6                      ; field_4
                dc.w    0                               ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFB8                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECFD0                      ; field_4
stru_4F598:     dc.w    0                               ; field_0
                                        ; DATA XREF: Boss_ShieldViperDefeatInit+84   o
                                        ; Boss_ShieldViperChildCircularMotion+48   o
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF7C                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF82                      ; field_4
                dc.w    $1000                           ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF88                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF76                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF7C                      ; field_4
                dc.w    0                               ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF82                      ; field_4
                dc.w    $800                            ; field_0
                dc.w    $FFFF                           ; field_2
                dc.l    word_ECF88                      ; field_4

; Debug routine that updates shield viper debugging features
Debug_ShieldViperUpdate:
                bsr.w   Debug_RotateSegmentWithDPad     ; was: sub_4F5D8
                bsr.w   Debug_AdjustRotationWithDPad
                bsr.w   Debug_MoveCursorWithDPad
                rts
; End of function Debug_ShieldViperUpdate
; Debug routine that checks if button 2 is pressed
Debug_CheckButton2:
                btst    #6,(word_FFF706).w              ; was: sub_4F5E6
                beq.w   Debug_DisableProjectilesAndMove
; End of function Debug_CheckButton2
; Spawns shield viper projectile with calculated angle based on segment rotation
Boss_ShieldViperSpawnProjectileWithAngle:               ; CODE XREF: Boss_ShieldViperPrepareMultiShot+8   p  ; was: sub_4F5F0
                bsr.w   Projectile_ShieldViperSpawnRotating
                bsr.w   Boss_ShieldViperUpdateSpriteFlip
                btst    #0,(word_FFA000+1).w
                bne.s   locret_4F64C
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4F64C
                jsr     Projectile_ShieldViperSpawnEffect(pc)  ; (pc)
                move.b  $20(a5),$20(a0)
                move.w  $970(a5),$10(a0)
                move.w  $974(a5),$14(a0)
                lea     (word_1B514).l,a3
                move.w  $56(a5),d0
                add.w   $52(a5),d0
                addi.w  #$100,d0
                andi.w  #$1FE,d0
                move.w  -$80(a3,d0.w),d1
                move.w  (a3,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #5,d0
                asl.l   #5,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
locret_4F64C:                                           ; CODE XREF: Boss_ShieldViperSpawnProjectileWithAngle+E   j
                                        ; Boss_ShieldViperSpawnProjectileWithAngle+16   j
                rts
; End of function Boss_ShieldViperSpawnProjectileWithAngle
; Debug routine to disable projectiles and perform wolf garopa movement
