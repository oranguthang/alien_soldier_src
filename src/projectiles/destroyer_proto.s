Boss_JetsripperSpawnProjectiles:                        ; CODE XREF: Boss_DestroyerProtoAttack4Rise+1A   p  ; was: sub_32158
                lea     (word_FFC740).w,a4
                lea     (word_FFC8C0).w,a0
                bsr.w   Boss_JetsripperInitProjectile
                lea     (word_FFC860).w,a4
                lea     (word_FFCEC0).w,a0
; End of function Boss_JetsripperSpawnProjectiles
; Initializes Jetsripper boss projectile with position, velocity, and graphics data
Boss_JetsripperInitProjectile:                          ; CODE XREF: Boss_DestroyerProtoInitProjectile   p  ; was: sub_3216C
                                        ; Boss_JetsripperSpawnProjectiles+8   p
                move.w  #$EC00,word_FFCEC2-word_FFCEC0(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$64,$26(a0)                    ; 'd'
                move.l  #off_E968C,8(a0)
                move.w  #$3B8,(a0)
                move.w  $40(a4),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                lsr.w   #3,d0
                move.w  d0,$54(a0)
                lea     word_31FF8(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$4C(a0)
                lea     dword_32078(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $10(a4),d1
                move.l  d1,$10(a0)
                lea     word_32038(pc),a1
                move.l  (a1,d0.w),d1
                move.l  d1,$50(a0)
                lea     dword_320B8(pc),a1
                move.l  (a1,d0.w),d1
                add.l   $14(a4),d1
                move.l  d1,$14(a0)
                move.b  #0,$20(a0)
                move.w  #$480,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a0)
                move.w  #6,$48(a0)
                move.w  #8,$4A(a0)
                clr.w   4(a0)
                rts
; End of function Boss_JetsripperInitProjectile
; Projectile main handler
Projectile_DestroyerProtoMain:                          ; DATA XREF: ROM:000314D4   o  ; was: sub_32208
                bsr.w   Enemy_DeathExplode
                move.w  4(a5),d0
                lea     off_32218(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_DestroyerProtoMain
; ---------------------------------------------------------------------------
off_32218:      dc.w    Boss_JetsripperProjectileSpreadInit-*  ; DATA XREF: Projectile_DestroyerProtoMain+8   o
                dc.w    Projectile_DestroyerProtoUpdate-*
                dc.w    Boss_JetsripperProjectileReturn-*
                dc.w    Boss_JetsripperProjectileTurretCheck-*
                dc.w    Boss_JetsripperProjectileBounce-*

; Creates spread pattern of 7 projectile copies with staggered delays
Boss_JetsripperProjectileSpreadInit:                    ; DATA XREF: ROM:off_32218   o  ; was: sub_32222
                subq.w  #1,$4A(a5)
                bne.w   locret_30BB8
                move.l  $4C(a5),$18(a5)
                move.l  $50(a5),$1C(a5)
                move.w  $54(a5),d0
                lea     off_322C8(pc),a0
                nop
                move.l  (a0,d0.w),8(a5)
                lsr.w   #1,d0
                lea     word_320F8(pc),a0
                move.w  (a0,d0.w),$E(a5)
                move.w  #$CC00,2(a5)
                movea.w a5,a4
                move.w  #6,d0
loc_3225E:                                              ; CODE XREF: Boss_JetsripperProjectileSpreadInit+9C   j
                adda.w  #$60,a4                         ; '`'
                move.w  #$CC00,2(a4)
                move.w  #$3B8,(a4)
                move.w  #6,$48(a4)
                move.w  #4,4(a4)
                move.l  $4C(a5),$4C(a4)
                move.l  $50(a5),$50(a4)
                move.l  8(a5),8(a4)
                move.w  $E(a5),$E(a4)
                move.b  $21(a5),$21(a4)
                move.l  $10(a5),$10(a4)
                move.l  $14(a5),$14(a4)
                move.l  $2C(a5),$2C(a4)
                move.l  $28(a5),$28(a4)
                move.w  #$64,$26(a4)                    ; 'd'
                move.w  d0,d1
                addq.w  #1,d1
                lsl.w   #2,d1
                move.w  d1,$4A(a4)
                dbf     d0,loc_3225E
                addq.w  #2,4(a5)
                rts
; End of function Boss_JetsripperProjectileSpreadInit
; ---------------------------------------------------------------------------
off_322C8:      dc.l    word_ECF52                      ; DATA XREF: Boss_DestroyerProtoInitProjectile+14   o
                                        ; Boss_JetsripperProjectileSpreadInit+18   o
                dc.l    word_ECF58
                dc.l    word_ECF5E
                dc.l    word_ECF64
                dc.l    word_ECF6A
                dc.l    word_ECF64
                dc.l    word_ECF5E
                dc.l    word_ECF58
                dc.l    word_ECF52
                dc.l    word_ECF58
                dc.l    word_ECF5E
                dc.l    word_ECF64
                dc.l    word_ECF6A
                dc.l    word_ECF64
                dc.l    word_ECF5E
                dc.l    word_ECF58

; Handles projectile bounce behavior when collision flag is set
Boss_JetsripperProjectileBounce:                        ; DATA XREF: ROM:00032220   o  ; was: sub_32308
                bclr    #4,$22(a5)
                bne.s   Boss_JetsripperProjectileReflect
                bra.s   Projectile_DestroyerProtoUpdate
; End of function Boss_JetsripperProjectileBounce
; Updates projectile state and checks collision flag for turret mode
Boss_JetsripperProjectileTurretCheck:                   ; DATA XREF: ROM:0003221E   o  ; was: sub_32312
                bclr    #4,$22(a5)
                bne.s   Enemy_Stage14TurretMain
; End of function Boss_JetsripperProjectileTurretCheck
; Projectile update handler
Projectile_DestroyerProtoUpdate:                        ; CODE XREF: Boss_DestroyerProtoState4+4   j  ; was: sub_3231A
                                        ; Boss_DestroyerProtoState5+40   j
                cmpi.w  #$60,$10(a5)                    ; '`'
                bcs.s   loc_3233C
                cmpi.w  #$1E0,$10(a5)
                bcc.s   loc_3233C
                cmpi.w  #$60,$14(a5)                    ; '`'
                bcs.s   loc_3233C
                cmpi.w  #$180,$14(a5)
                bcc.s   loc_3233C
                rts
; ---------------------------------------------------------------------------
loc_3233C:                                              ; CODE XREF: Projectile_DestroyerProtoUpdate+6   j
                                        ; Projectile_DestroyerProtoUpdate+E   j
                move.w  #$1000,2(a5)
                rts
; End of function Projectile_DestroyerProtoUpdate
; Turret enemy main handler
