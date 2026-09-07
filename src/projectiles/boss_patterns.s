Boss_ProjectileStateDispatcher:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_33DB0
                tst.w   4(a5)
                beq.s   loc_33DDE
                bclr    #7,$22(a5)
                bne.s   loc_33DCC
                btst    #1,(byte_FF80EC).w
                bne.s   loc_33DCC
                tst.w   $24(a5)
                bpl.s   loc_33DDE
loc_33DCC:                                              ; CODE XREF: Boss_ProjectileStateDispatcher+C   j
                                        ; Boss_ProjectileStateDispatcher+14   j
                cmpi.w  #$C,4(a5)
                bcc.s   loc_33DDE
                move.w  #$C,4(a5)
                clr.b   $21(a5)
loc_33DDE:                                              ; CODE XREF: Boss_ProjectileStateDispatcher+4   j
                                        ; Boss_ProjectileStateDispatcher+1A   j
                move.w  4(a5),d0
                lea     off_33DEA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_ProjectileStateDispatcher
; ---------------------------------------------------------------------------
off_33DEA:      dc.w    Boss_ProjectileInitFall-*       ; DATA XREF: Boss_ProjectileStateDispatcher+32   o
                dc.w    Boss_ProjectileDecelerate-*
                dc.w    Boss_ProjectileSetTimer-*
                dc.w    Boss_ProjectileTransformAttack-*
                dc.w    Boss_ProjectileWaitAnimation-*
                dc.w    Boss_ProjectileAccelerateAndExit-*
                dc.w    Boss_ProjectileInitSpreadFire-*
                dc.w    Boss_ProjectileSpreadFireLoop-*

; Initializes falling motion with velocity for boss projectile
Boss_ProjectileInitFall:                                ; DATA XREF: ROM:off_33DEA   o  ; was: sub_33DFA
                move.l  #$40000,$1C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileInitFall
; Decelerates boss projectile fall over timer duration
Boss_ProjectileDecelerate:                              ; DATA XREF: ROM:00033DEC   o  ; was: sub_33E0E
                subi.l  #$3800,$1C(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33E24
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_33E24:                                           ; CODE XREF: Boss_ProjectileDecelerate+C   j
                rts
; End of function Boss_ProjectileDecelerate
; Sets timer value for next boss projectile state
Boss_ProjectileSetTimer:                                ; DATA XREF: ROM:00033DEE   o  ; was: sub_33E26
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileSetTimer
; Transforms projectile graphics and velocity for attack phase
Boss_ProjectileTransformAttack:                         ; DATA XREF: ROM:00033DF0   o  ; was: sub_33E32
                subq.w  #1,$48(a5)
                bne.s   locret_33E64
                move.l  #off_ED156,8(a5)
                clr.w   $C(a5)
                move.l  #$FF01D62A,$2C(a5)
                move.l  #$F808D030,$28(a5)
                move.b  #$10,$23(a5)
                move.l  $58(a5),$1C(a5)
                addq.w  #2,4(a5)
locret_33E64:                                           ; CODE XREF: Boss_ProjectileTransformAttack+4   j
                rts
; End of function Boss_ProjectileTransformAttack
; Waits for animation frame threshold before next state
Boss_ProjectileWaitAnimation:                           ; DATA XREF: ROM:00033DF2   o  ; was: sub_33E66
                cmpi.w  #$80,$C(a5)
                bcs.s   locret_33E7E
                move.l  #off_ED13E,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_33E7E:                                           ; CODE XREF: Boss_ProjectileWaitAnimation+6   j
                rts
; End of function Boss_ProjectileWaitAnimation
; Accelerates projectile and marks for deletion when off-screen
Boss_ProjectileAccelerateAndExit:                       ; DATA XREF: ROM:00033DF4   o  ; was: sub_33E80
                cmpi.l  #$1C000,$1C(a5)
                bge.s   loc_33E92
                addi.l  #$800,$1C(a5)
loc_33E92:                                              ; CODE XREF: Boss_ProjectileAccelerateAndExit+8   j
                cmpi.w  #$180,$14(a5)
                blt.s   locret_33EA0
                move.w  #$1000,2(a5)
locret_33EA0:                                           ; CODE XREF: Boss_ProjectileAccelerateAndExit+18   j
                rts
; End of function Boss_ProjectileAccelerateAndExit
; Initializes parameters for spread fire attack pattern
Boss_ProjectileInitSpreadFire:                          ; DATA XREF: ROM:00033DF6   o  ; was: sub_33EA2
                clr.l   $1C(a5)
                move.w  #2,$48(a5)
                move.w  #4,$4A(a5)
                move.w  #8,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_ProjectileInitSpreadFire
; Fires projectiles in spread pattern with alternating angles
Boss_ProjectileSpreadFireLoop:                          ; DATA XREF: ROM:00033DF8   o  ; was: sub_33EBE
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33EFC
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_33EEC
                move.w  $4C(a5),d0
                bsr.w   Projectile_SpawnBulletAtOffset
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_33EEC
                move.w  $4C(a5),d0
                neg.w   d0
                bsr.w   Projectile_SpawnBulletAtOffset
loc_33EEC:                                              ; CODE XREF: Boss_ProjectileSpreadFireLoop+12   j
                                        ; Boss_ProjectileSpreadFireLoop+22   j
                subq.w  #1,$4A(a5)
                beq.s   loc_33EFE
                addq.w  #8,$4C(a5)
                move.w  #2,$48(a5)
locret_33EFC:                                           ; CODE XREF: Boss_ProjectileSpreadFireLoop+A   j
                rts
; ---------------------------------------------------------------------------
loc_33EFE:                                              ; CODE XREF: Boss_ProjectileSpreadFireLoop+32   j
                move.w  #$1000,2(a5)
                rts
; End of function Boss_ProjectileSpreadFireLoop
; Spawns bullet projectile at offset position from source
Projectile_SpawnBulletAtOffset:                         ; CODE XREF: Boss_ProjectileSpreadFireLoop+18   p  ; was: sub_33F06
                                        ; Boss_ProjectileSpreadFireLoop+2A   p
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (Sprite_InitType160).l
                move.b  #$60,$20(a0)                    ; '`'
                andi.w  #$FEFF,2(a0)
                rts
; End of function Projectile_SpawnBulletAtOffset
; Loads animation frame data into sprite
Sprite_LoadAnimationFrame:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_33F30
                bsr.w   Sprite_InitializeObject
                bsr.w   Sprite_UpdateAnimationTimer
                bsr.s   Boss_UpdateTimedSoundEffect
                cmpi.w  #2,4(a5)
                bls.w   locret_343CC
                bsr.w   Sprite_SetTileProperties
                bsr.w   Sprite_ApplyFrameData
                bsr.w   Sprite_CalculateFrameOffset
                bsr.w   Gfx_SetPaletteUpdateFlag
                rts
; End of function Sprite_LoadAnimationFrame
; Updates timer and plays sound effect at intervals based on offset table
Boss_UpdateTimedSoundEffect:                            ; CODE XREF: Sprite_LoadAnimationFrame+8   p  ; was: sub_33F56
                tst.w   $50(a5)
                beq.s   locret_33F78
                subq.w  #1,(dword_FF9400).w
                bpl.s   locret_33F78
                move.w  $50(a5),d0
                add.w   d0,d0
                move.w  word_33F7A(pc,d0.w),(dword_FF9400).w
                move.b  #$54,d0                         ; 'T'
                jsr     (Sound_PlaySFX).l
locret_33F78:                                           ; CODE XREF: Boss_UpdateTimedSoundEffect+4   j
                                        ; Boss_UpdateTimedSoundEffect+A   j
                rts
; End of function Boss_UpdateTimedSoundEffect
; ---------------------------------------------------------------------------
word_33F7A:     dc.w    0, $28, $20, $2C, $18
                                        ; DATA XREF: Boss_UpdateTimedSoundEffect+12   r

; Initializes sprite object with default values
Sprite_InitializeObject:                                ; CODE XREF: Sprite_LoadAnimationFrame   p  ; was: sub_33F84
                cmpi.w  #2,4(a5)
                bls.w   locret_343CC
                btst    #1,(byte_FF80EC).w
                bne.w   locret_343CC
                tst.w   (word_FF8200).w
                bne.w   locret_343CC
                move.w  #2,4(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #7,d7
                lea     (word_FFC680).w,a0
loc_33FB6:                                              ; CODE XREF: Sprite_InitializeObject+6C   j
                move.w  word_FFC6CC-word_FFC680(a0),d2
                add.w   $4C(a5),d2
                add.w   d2,d2
                lea     (Math_SineTable).l,a1
                move.w  (a1,d2.w),d0
                move.w  -$80(a1,d2.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #4,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (Sprite_InitType160).l
                adda.w  #$60,a0                         ; '`'
                dbf     d7,loc_33FB6
                move.w  #3,d1
                move.w  #0,d2
                jsr     (Gfx_SetAnimationPointer).l
                move.w  #4,d1
                move.w  #$20,d2                         ; ' '
                jsr     (Gfx_SetAnimationPointer).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.w  #4,(word_FFA010).w
                move.w  (word_FFA010).w,(word_FFA014).w
                rts
; End of function Sprite_InitializeObject
; Sets palette update flag when sprite flag bit 6 is set
Gfx_SetPaletteUpdateFlag:                               ; CODE XREF: Sprite_LoadAnimationFrame+20   p  ; was: sub_34028
                bclr    #6,$22(a5)
                beq.w   locret_343CC
                move.w  #4,(word_FFA010).w
                move.w  (word_FFA010).w,(word_FFA014).w
                rts
; End of function Gfx_SetPaletteUpdateFlag
; Sets sprite tile VDP properties and flags
Sprite_SetTileProperties:                               ; CODE XREF: Sprite_LoadAnimationFrame+14   p  ; was: sub_34040
                move.l  $50(a5),d0
                add.l   d0,$4C(a5)
                andi.l  #$FFFFFF,$4C(a5)
                move.l  $58(a5),d0
                add.l   d0,$54(a5)
                andi.l  #$FFFFFF,$54(a5)
                tst.l   $58(a5)
                beq.s   loc_34074
                move.w  $5E(a5),d0
                add.w   d0,$5C(a5)
                andi.w  #$FF,$5C(a5)
loc_34074:                                              ; CODE XREF: Sprite_SetTileProperties+24   j
                cmpi.w  #$A,4(a5)
                bcs.w   locret_343CC
                move.l  $50(a5),d0
                asr.l   #2,d0
                tst.l   $18(a5)
                bpl.s   loc_3408C
                neg.l   d0
loc_3408C:                                              ; CODE XREF: Sprite_SetTileProperties+48   j
                move.l  d0,$18(a5)
                cmpi.w  #$140,$10(a5)
                bcs.s   loc_340A2
                cmpi.w  #$1A0,$10(a5)
                bhi.s   loc_340A2
                rts
; ---------------------------------------------------------------------------
loc_340A2:                                              ; CODE XREF: Sprite_SetTileProperties+56   j
                                        ; Sprite_SetTileProperties+5E   j
                neg.l   $18(a5)
                move.l  $18(a5),d0
                add.l   d0,$10(a5)
                rts
; End of function Sprite_SetTileProperties
; Calculates animation frame offset from index
Sprite_CalculateFrameOffset:                            ; CODE XREF: Sprite_LoadAnimationFrame+1C   p  ; was: sub_340B0
                tst.l   (dword_FFC6DC).w
                beq.w   locret_343CC
                move.l  (dword_FFC6DC).w,d0
                add.l   d0,$1C(a5)
                move.l  $1C(a5),d0
                tst.l   d0
                bmi.s   loc_340CA
                neg.l   d0
loc_340CA:                                              ; CODE XREF: Sprite_CalculateFrameOffset+16   j
                cmpi.l  #$FFFF8000,d0
                bne.w   locret_343CC
                neg.l   (dword_FFC6DC).w
                rts
; End of function Sprite_CalculateFrameOffset
; Applies frame data to sprite object
Sprite_ApplyFrameData:                                  ; CODE XREF: Sprite_LoadAnimationFrame+18   p  ; was: sub_340DA
                move.w  #7,d7
                lea     (word_FFC680).w,a0
loc_340E2:                                              ; CODE XREF: Sprite_ApplyFrameData+98   j
                move.w  word_FFC6CC-word_FFC680(a0),d0
                add.w   $4C(a5),d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (Math_SineTable).l,a1
                move.w  (a1,d0.w),d1
                move.w  -$80(a1,d0.w),d2
                muls.w  $4A(a0),d1
                muls.w  $4A(a0),d2
                swap    d2
                move.w  d2,d5
                move.w  $54(a5),d3
                add.w   d3,d3
                move.w  -$80(a1,d3.w),d4
                muls.w  d4,d2
                asl.l   #2,d2
                move.w  (a1,d3.w),d4
                muls.w  d4,d5
                swap    d5
                andi.w  #$FF,d5
                add.b   $20(a5),d5
                move.b  d5,$20(a0)
                swap    d1
                swap    d2
                move.w  $5C(a5),d0
                add.w   d0,d0
                move.w  (a1,d0.w),d3
                move.w  -$80(a1,d0.w),d4
                muls.w  d1,d3
                muls.w  d2,d4
                sub.l   d4,d3
                asl.l   #2,d3
                move.l  d3,d5
                move.w  (a1,d0.w),d3
                move.w  -$80(a1,d0.w),d4
                muls.w  d1,d4
                muls.w  d2,d3
                add.l   d4,d3
                asl.l   #2,d3
                move.l  d3,d6
                move.l  d5,d1
                move.l  d6,d2
                add.l   $10(a5),d1
                add.l   $14(a5),d2
                move.l  d1,$10(a0)
                move.l  d2,$14(a0)
                adda.w  #$60,a0                         ; '`'
                dbf     d7,loc_340E2
                rts
; End of function Sprite_ApplyFrameData
; Updates sprite animation timer and frame
Sprite_UpdateAnimationTimer:                            ; CODE XREF: Sprite_LoadAnimationFrame+4   p  ; was: sub_34178
                move.w  4(a5),d0
                lea     off_34184(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Sprite_UpdateAnimationTimer
; ---------------------------------------------------------------------------
off_34184:      dc.w    Sprite_AdvanceToNextFrame-*     ; DATA XREF: Sprite_UpdateAnimationTimer+4   o
                dc.w    Sprite_DestroyObject-*
                dc.w    Sprite_LoadFrameTiles-*
                dc.w    Sprite_ApplyTileMapping-*
                dc.w    Boss_CheckPositionAndSetVelocity-*
                dc.w    Boss_InitializeAngleOffset-*
                dc.w    Boss_HomingProjectileAttack-*
                dc.w    Boss_MultiProjectileSpread-*
                dc.w    Boss_WaitTimerComplete-*
                dc.w    Boss_IncrementVelocityUntilMax-*

; Advances sprite to next animation frame
Sprite_AdvanceToNextFrame:                              ; DATA XREF: ROM:off_34184   o  ; was: sub_34198
                move.l  #word_EB592,8(a5)
                move.w  #$B00,$E(a5)
                move.w  #$CC00,2(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$200,$10(a5)
                move.w  #$118,$14(a5)
                move.l  #$F010F010,$28(a5)
                move.b  #$50,$21(a5)                    ; 'P'
                move.w  #2,$26(a5)
                clr.w   (word_FF8200).w
                move.w  #$28,$24(a5)                    ; '('
                move.b  #6,(byte_FF80EC).w
                move.b  #$80,$23(a5)
                move.w  #7,d7
                clr.w   d6
                lea     (word_FFC680).w,a0
loc_341F2:                                              ; CODE XREF: Sprite_AdvanceToNextFrame+9E   j
                move.w  #$10,(a0)
                move.l  #word_EB5B0,8(a0)
                move.w  #$B00,$E(a0)
                move.w  #$CC00,2(a0)
                move.b  #$50,$21(a0)                    ; 'P'
                move.w  #2,$26(a0)
                move.l  #$FC04FC04,$28(a0)
                move.b  #$10,$23(a0)
                move.w  d6,$4C(a0)
                move.w  #$BC,$4A(a0)
                addi.w  #$20,d6                         ; ' '
                adda.w  #$60,a0                         ; '`'
                dbf     d7,loc_341F2
                move.l  #$FFFF8000,$1C(a5)
                move.l  #$800,(dword_FFC6DC).w
                move.w  #4,4(a5)
                movem.l a5,-(sp)
                lea     stru_34266(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
                movem.l (sp)+,a5
                rts
; End of function Sprite_AdvanceToNextFrame
; ---------------------------------------------------------------------------
stru_34266:     dc.w    7                               ; field_0
                                        ; DATA XREF: Sprite_AdvanceToNextFrame+BC   o
                dc.l    tiles_10F51C                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    $FFFF

; Clears sprite object flag destroying it
Sprite_DestroyObject:                                   ; DATA XREF: ROM:00034186   o  ; was: sub_34270
                clr.w   (a5)
                rts
; End of function Sprite_DestroyObject
; Loads frame tile indices into sprite
Sprite_LoadFrameTiles:                                  ; DATA XREF: ROM:00034188   o  ; was: sub_34274
                tst.w   (word_FFF720).w
                bmi.w   locret_343CC
                move.w  #$C0,$54(a5)
                move.l  #$40000,$50(a5)
                move.w  #2,$5E(a5)
                move.l  #$FFFF0000,$18(a5)
                addq.w  #2,4(a5)
                rts
; End of function Sprite_LoadFrameTiles
; Applies tile mapping to sprite object
Sprite_ApplyTileMapping:                                ; DATA XREF: ROM:0003418A   o  ; was: sub_3429E
                cmpi.w  #$1C0,$10(a5)
                bcc.w   locret_343CC
                move.w  #$1E00,(word_FF8202).w
                move.w  #$1E00,(word_FF8200).w
                clr.b   (byte_FF80EC).w
                addq.w  #2,4(a5)
                rts
; End of function Sprite_ApplyTileMapping
; Checks if X position < 0x180 then sets velocity to 0x8000
Boss_CheckPositionAndSetVelocity:                       ; DATA XREF: ROM:0003418C   o  ; was: sub_342BE
                cmpi.w  #$180,$10(a5)
                bcc.w   locret_343CC
                move.l  #$8000,$58(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_CheckPositionAndSetVelocity
; Initializes angle offset from timer with adjustment based on direction flag
Boss_InitializeAngleOffset:                             ; DATA XREF: ROM:0003418E   o  ; was: sub_342D6
                addq.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                move.w  d0,$48(a5)
                tst.w   (word_FFFF0E).w
                bne.w   locret_343CC
                addi.w  #$40,$48(a5)                    ; '@'
                rts
; End of function Boss_InitializeAngleOffset
; Calculates angle to player and spawns homing projectiles after timer expires
Boss_HomingProjectileAttack:                            ; DATA XREF: ROM:00034190   o  ; was: sub_342F6
                subq.w  #1,$48(a5)
                bpl.w   loc_34326
                jsr     (Math_CalculateAngleToPlayer).l
                move.w  d2,d6
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_343CC
                move.w  #$FFE8,d0
                clr.w   d1
                move.w  #$8004,d2
                jsr     (Enemy_InitHomingProjectile).l
                move.w  #$A,4(a5)
loc_34326:                                              ; CODE XREF: Boss_HomingProjectileAttack+4   j
                tst.l   $54(a5)
                bne.w   locret_343CC
                eori.b  #1,$4A(a5)
                clr.l   $58(a5)
                move.w  #$E,4(a5)
                rts
; End of function Boss_HomingProjectileAttack
; Spawns 8 spread projectiles in circular pattern when counter reaches zero
Boss_MultiProjectileSpread:                             ; DATA XREF: ROM:00034192   o  ; was: sub_34340
                subi.l  #$800,$50(a5)
                bne.w   locret_343CC
                addq.w  #2,4(a5)
                tst.w   (word_FFFF0E).w
                beq.w   locret_343CC
                move.w  #$20,$48(a5)                    ; ' '
                movem.w a5,-(sp)
                lea     (word_FFC680).w,a5
                move.w  #7,d4
loc_3436A:                                              ; CODE XREF: Boss_MultiProjectileSpread+52   j
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_34396
                clr.w   d0
                clr.w   d1
                move.w  #$8004,d2
                move.w  $4C(a5),d6
                add.w   (word_FFC66C).w,d6
                andi.w  #$FF,d6
                add.w   d6,d6
                jsr     (Enemy_InitHomingProjectile).l
                adda.w  #$60,a5                         ; '`'
                dbf     d4,loc_3436A
loc_34396:                                              ; CODE XREF: Boss_MultiProjectileSpread+30   j
                movem.w (sp)+,a5
                rts
; End of function Boss_MultiProjectileSpread
; Waits for timer countdown then advances to next state
Boss_WaitTimerComplete:                                 ; DATA XREF: ROM:00034194   o  ; was: sub_3439C
                subq.w  #1,$48(a5)
                bpl.w   locret_343CC
                addq.w  #2,4(a5)
                rts
; End of function Boss_WaitTimerComplete
; Increases velocity by 0x800 until reaching 0x40000 threshold
Boss_IncrementVelocityUntilMax:                         ; DATA XREF: ROM:00034196   o  ; was: sub_343AA
                addi.l  #$800,$50(a5)
                cmpi.l  #$40000,$50(a5)
                bcs.w   locret_343CC
                move.l  #$8000,$58(a5)
                move.w  #$A,4(a5)
locret_343CC:                                           ; CODE XREF: Sprite_LoadAnimationFrame+10   j
                                        ; Sprite_InitializeObject+6   j
                rts
; End of function Boss_IncrementVelocityUntilMax
; Initializes metasprite with simple parameter setup
