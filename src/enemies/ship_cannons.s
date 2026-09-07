Enemy_ShipMain:                                         ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F5C0
                move.l  $54(a5),d0
                add.l   d0,(dword_FFA908).w
                move.w  4(a5),d0
                movea.w off_2F5D8(pc,d0.w),a0
                adda.l  #Enemy_ShipInit,a0
                jmp     (a0)
; End of function Enemy_ShipMain
; ---------------------------------------------------------------------------
off_2F5D8:      dc.w    Enemy_ShipInit-Enemy_ShipInit
                                        ; DATA XREF: Enemy_ShipMain+C   r
                dc.w    Enemy_ShipInitPosition_Return-Enemy_ShipInit
                dc.w    Enemy_ShipUpdatePosition-Enemy_ShipInit
                dc.w    Enemy_ShipSpawnCannons-Enemy_ShipInit
                dc.w    Enemy_ShipSpawnCannons_MainState-Enemy_ShipInit
                dc.w    Enemy_ShipSpawnCannons_RiseUp-Enemy_ShipInit
                dc.w    Enemy_ShipSpawnCannons_CheckDestruction-Enemy_ShipInit
                dc.w    Enemy_ShipSpawnCannons_MainLoop-Enemy_ShipInit

; Initializes ship platform entity
Enemy_ShipInit:                                         ; DATA XREF: Enemy_ShipMain+10   o  ; was: sub_2F5E8
                                        ; ROM:off_2F5D8   o
                addq.w  #2,4(a5)
                move.w  #$8D00,2(a5)
                move.w  #1,$24(a5)
                clr.w   $50(a5)
                clr.l   $54(a5)
                clr.w   $58(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$20,$21(a5)                    ; ' '
                move.w  #2,$46(a5)
                move.l  #$FFFC00F0,$28(a5)
                move.w  $10(a5),$4C(a5)
                move.w  $14(a5),$4E(a5)
; Return after ship enemy position init
Enemy_ShipInitPosition_Return:                          ; DATA XREF: ROM:0002F5DA   o  ; was: locret_2F62C
                rts
; End of function Enemy_ShipInit
; Updates ship platform position
Enemy_ShipUpdatePosition:                               ; DATA XREF: ROM:0002F5DC   o  ; was: sub_2F62E
                move.l  (dword_FFA900).w,-(sp)
                move.w  $50(a5),d0
                add.w   d0,(dword_FFA900).w
                jsr     (Gfx_GetCameraPosition).l
                move.l  (sp)+,(dword_FFA900).w
                addq.w  #8,$50(a5)
                cmpi.w  #$90,$50(a5)
                bmi.w   locret_2F8B6
                move.w  #$38,(word_FFF74A).w            ; '8'
                move.b  #3,(byte_FFA95A).w
                bset    #7,(dword_FFA20E).w
                addq.w  #2,4(a5)
                move.b  #$8B,d0
                jmp     Input_CheckButtonMode
; End of function Enemy_ShipUpdatePosition
; Spawns 4 cannons on ship
Enemy_ShipSpawnCannons:                                 ; DATA XREF: ROM:0002F5DE   o  ; was: sub_2F672
                move.b  #$55,d0                         ; 'U'
                jsr     (Sound_PlaySFX).l
loc_2F67C:                                              ; CODE XREF: Enemy_ShipSpawnCannons+68   j
                move.w  #2,$58(a5)
                move.l  #$22000,$1C(a5)
                move.w  #8,4(a5)
; Main state for spawning and managing ship cannons
Enemy_ShipSpawnCannons_MainState:                       ; DATA XREF: ROM:0002F5E0   o  ; was: loc_2F690
                tst.w   $24(a5)
                bmi.w   loc_2F700
                bclr    #1,$5A(a5)
                bne.s   loc_2F6BC
                bclr    #0,$5A(a5)
                bne.s   loc_2F6E8
                bsr.w   Enemy_ShipWaitForCannons
                bsr.w   Enemy_ShipCheckDestroyed
                bsr.w   Enemy_ShipExit
                bsr.w   Stage_ShipDestructionCheckInput
                bra.w   Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F6BC:                                              ; CODE XREF: Enemy_ShipSpawnCannons+2C   j
                                        ; Enemy_ShipSpawnCannons+80   j
                move.w  #$A,4(a5)
                move.l  #$FFFEF000,$1C(a5)
; Ship rises up with upward velocity acceleration
Enemy_ShipSpawnCannons_RiseUp:                          ; DATA XREF: ROM:0002F5E2   o  ; was: loc_2F6CA
                addi.l  #$210,$1C(a5)
                bmi.s   loc_2F6DC
                cmpi.w  #$12C,$14(a5)
                bpl.s   loc_2F67C
loc_2F6DC:                                              ; CODE XREF: Enemy_ShipSpawnCannons+60   j
                bsr.w   Enemy_ShipCheckDestroyed
                bsr.w   Stage_ShipDestructionCheckInput
                bra.w   Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F6E8:                                              ; CODE XREF: Enemy_ShipSpawnCannons+34   j
                addq.w  #4,4(a5)
; Checks destruction status and continues cannon spawning
Enemy_ShipSpawnCannons_CheckDestruction:                ; DATA XREF: ROM:0002F5E4   o  ; was: loc_2F6EC
                bclr    #1,$5A(a5)
                bne.s   loc_2F6BC
                bsr.w   Enemy_ShipCheckDestroyed
                bsr.w   Stage_ShipDestructionCheckInput
                bra.w   Enemy_ShipCannonSpawn
; ---------------------------------------------------------------------------
loc_2F700:                                              ; CODE XREF: Enemy_ShipSpawnCannons+22   j
                move.w  #$E,4(a5)
; Main state updating ship palette, cannon fire, debris, and spawn logic
Enemy_ShipSpawnCannons_MainLoop:                        ; DATA XREF: ROM:0002F5E6   o  ; was: loc_2F706
                lea     word_2F726(pc),a4
                nop
                jsr     (VBlank_UpdateSharpssteelPalette).l
                bsr.w   Enemy_ShipCannonFirePattern
                bsr.w   Enemy_ShipSpawnDebrisProjectile
                bsr.w   Enemy_ShipWaitForCannons
                bsr.w   Enemy_ShipCheckDestroyed
                bra.w   Enemy_ShipCannonSpawn
; End of function Enemy_ShipSpawnCannons
; ---------------------------------------------------------------------------
word_2F726:     dc.w    $A, $E322, $E324, $E326, $E328, $E32A, $E32C, $E32E, $E332, $E334, $E336, $E338
                                        ; DATA XREF: Enemy_ShipSpawnCannons:loc_2F706   o

; Waits for all cannons destroyed
Enemy_ShipWaitForCannons:                               ; CODE XREF: Enemy_ShipSpawnCannons+36   p  ; was: sub_2F73E
                                        ; Enemy_ShipSpawnCannons+A8   p
                tst.w   $58(a5)
                bne.s   loc_2F766
                cmpi.w  #$12E,$14(a5)
                bmi.s   loc_2F788
                move.l  $1C(a5),d0
                bpl.s   loc_2F75A
                cmpi.l  #$FFFF0000,d0
                bmi.s   locret_2F78E
loc_2F75A:                                              ; CODE XREF: Enemy_ShipWaitForCannons+12   j
                subi.l  #$2000,d0
                move.l  d0,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F766:                                              ; CODE XREF: Enemy_ShipWaitForCannons+4   j
                cmpi.w  #$13C,$14(a5)
                bpl.s   loc_2F788
                move.l  $1C(a5),d0
                bmi.s   loc_2F77C
                cmpi.l  #$10000,d0
                bpl.s   locret_2F78E
loc_2F77C:                                              ; CODE XREF: Enemy_ShipWaitForCannons+34   j
                addi.l  #$2000,d0
                move.l  d0,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F788:                                              ; CODE XREF: Enemy_ShipWaitForCannons+C   j
                                        ; Enemy_ShipWaitForCannons+2E   j
                eori.w  #2,$58(a5)
locret_2F78E:                                           ; CODE XREF: Enemy_ShipWaitForCannons+1A   j
                                        ; Enemy_ShipWaitForCannons+3C   j
                rts
; End of function Enemy_ShipWaitForCannons
; Checks if all cannons destroyed
Enemy_ShipCheckDestroyed:                               ; CODE XREF: Enemy_ShipSpawnCannons+3A   p  ; was: sub_2F790
                                        ; sub_2F672:loc_2F6DC   p
                cmpi.l  #$C000,(dword_FF830A).w
                bpl.s   loc_2F7A2
                addi.l  #$100,(dword_FF830A).w
loc_2F7A2:                                              ; CODE XREF: Enemy_ShipCheckDestroyed+8   j
                clr.l   (dword_FF8240).w
                btst    #5,(byte_FF8244).w
                bne.s   loc_2F7B6
                btst    #0,(byte_FF8244).w
                beq.s   loc_2F7C2
loc_2F7B6:                                              ; CODE XREF: Enemy_ShipCheckDestroyed+1C   j
                move.l  $54(a5),d0
                neg.l   d0
                asr.l   #2,d0
                move.l  d0,(dword_FF8240).w
loc_2F7C2:                                              ; CODE XREF: Enemy_ShipCheckDestroyed+24   j
                cmpi.l  #$B0000,$54(a5)
                bpl.s   locret_2F7D4
                addi.l  #$400,$54(a5)
locret_2F7D4:                                           ; CODE XREF: Enemy_ShipCheckDestroyed+3A   j
                rts
; End of function Enemy_ShipCheckDestroyed
; Ship exit sequence
Enemy_ShipExit:                                         ; CODE XREF: Enemy_ShipSpawnCannons+3E   p  ; was: sub_2F7D6
                tst.w   (word_FF80E6).w
                bne.w   Enemy_ShipCannonFirePattern
                btst    #0,(byte_FF8244).w
                bne.s   Enemy_ShipCannonFirePattern
                btst    #2,(word_FFF706).w
                beq.s   loc_2F80A
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bmi.s   loc_2F848
loc_2F7F6:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+10   j
                cmpi.l  #$FFFD0000,$18(a5)
                bmi.s   locret_2F808
                subi.l  #$2000,$18(a5)
locret_2F808:                                           ; CODE XREF: Enemy_ShipExit+28   j
                                        ; Enemy_ShipExit+4C   j
                rts
; ---------------------------------------------------------------------------
loc_2F80A:                                              ; CODE XREF: Enemy_ShipExit+16   j
                btst    #3,(word_FFF706).w
                beq.s   Enemy_ShipCannonFirePattern
                cmpi.w  #$100,$10(a5)
                bpl.s   loc_2F848
loc_2F81A:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+18   j
                cmpi.l  #$30000,$18(a5)
                bpl.s   locret_2F808
                addi.l  #$2000,$18(a5)
                rts
; End of function Enemy_ShipExit
; Cannon firing pattern logic
Enemy_ShipCannonFirePattern:                            ; CODE XREF: Enemy_ShipSpawnCannons+A0   p  ; was: sub_2F82E
                                        ; Enemy_ShipExit+4   j
                move.w  $10(a5),d0
                subi.w  #$B0,d0
                bmi.s   loc_2F840
                cmpi.w  #$10,d0
                bmi.s   loc_2F848
                bra.s   loc_2F7F6
; ---------------------------------------------------------------------------
loc_2F840:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+8   j
                cmpi.w  #$FFF0,d0
                bpl.s   loc_2F848
                bra.s   loc_2F81A
; ---------------------------------------------------------------------------
loc_2F848:                                              ; CODE XREF: Enemy_ShipExit+1E   j
                                        ; Enemy_ShipExit+42   j
                move.l  $18(a5),d0
                bpl.s   loc_2F858
                addi.l  #$1800,d0
                bmi.s   loc_2F862
                bra.s   loc_2F860
; ---------------------------------------------------------------------------
loc_2F858:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+1E   j
                subi.l  #$1800,d0
                bpl.s   loc_2F862
loc_2F860:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+28   j
                moveq   #0,d0
loc_2F862:                                              ; CODE XREF: Enemy_ShipCannonFirePattern+26   j
                                        ; Enemy_ShipCannonFirePattern+30   j
                move.l  d0,$18(a5)
                rts
; End of function Enemy_ShipCannonFirePattern
; Checks input flags for scroll updates
Stage_ShipDestructionCheckInput:                        ; CODE XREF: Enemy_ShipSpawnCannons+42   p  ; was: sub_2F868
                                        ; Enemy_ShipSpawnCannons+6E   p
                btst    #0,(word_FFA000+1).w
                beq.s   locret_2F884
                btst    #1,(word_FFA000+1).w
                beq.s   loc_2F886
                move.l  #$4C705B01,d0
                jsr     (Scroll_UpdateStage14Scroll).l
locret_2F884:                                           ; CODE XREF: Stage_ShipDestructionCheckInput+6   j
                rts
; ---------------------------------------------------------------------------
loc_2F886:                                              ; CODE XREF: Stage_ShipDestructionCheckInput+E   j
                move.l  #$4C705CA1,d0
                jsr     (Scroll_UpdateStage14Scroll).l
                rts
; End of function Stage_ShipDestructionCheckInput
; Spawns single cannon entity
Enemy_ShipCannonSpawn:                                  ; CODE XREF: Enemy_ShipSpawnCannons+46   j  ; was: sub_2F894
                                        ; Enemy_ShipSpawnCannons+72   j
                move.w  #$40,d0                         ; '@'
                sub.w   $10(a5),d0
                neg.w   d0
                move.w  d0,(word_FFE400).w
                move.w  $14(a5),d0
                addi.w  #-$30,d0
                neg.w   d0
                move.w  (word_FFA012).w,d1
                add.w   d1,d0
                move.w  d0,(word_FFEC00).w
locret_2F8B6:                                           ; CODE XREF: Enemy_ShipUpdatePosition+20   j
                rts
; End of function Enemy_ShipCannonSpawn
; Spawns debris projectile with random offset
Enemy_ShipSpawnDebrisProjectile:                        ; CODE XREF: Enemy_ShipSpawnCannons+A4   p  ; was: sub_2F8B8
                jsr     (Projectile_SpawnAtPosition).l
                bne.s   locret_2F90C
                jsr     (Sprite_InitFromTable).l
                move.b  #0,$20(a0)
                move.w  #$FFFD,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d0                         ; '?'
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$10,d0
                subi.w  #$18,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_2F90C:                                           ; CODE XREF: Enemy_ShipSpawnDebrisProjectile+6   j
                rts
; End of function Enemy_ShipSpawnDebrisProjectile
; Main handler for ship cannon 1
Enemy_ShipCannon1Main:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_2F90E
                move.w  4(a5),d0
                movea.w off_2F91E(pc,d0.w),a0
                adda.l  #Enemy_ShipCannon1Init,a0
                jmp     (a0)
; End of function Enemy_ShipCannon1Main
; ---------------------------------------------------------------------------
off_2F91E:      dc.w    Enemy_ShipCannon1Init-Enemy_ShipCannon1Init
                                        ; DATA XREF: Enemy_ShipCannon1Main+4   r
                dc.w    Enemy_ShipCannonEmptyWait-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Init_WaitCamera-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Wait-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Wait_FallGravity-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Destroyed-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Wait_FacePlayer-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Wait_SecondTimer-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Wait_ApplyGravity-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon1Destroyed_WaitTimer-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Main-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Init-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Dispatcher-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Dispatcher_FireState-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Wait-Enemy_ShipCannon1Init
                dc.w    Enemy_ShipCannon2Wait_ApplyGravity-Enemy_ShipCannon1Init

; Initializes ship cannon 1
Enemy_ShipCannon1Init:                                  ; DATA XREF: Enemy_ShipCannon1Main+8   o  ; was: sub_2F93E
                                        ; ROM:off_2F91E   o
                addq.w  #4,4(a5)
                move.w  #$ED00,2(a5)
                move.w  #$8000,$E(a5)
                move.l  #off_1A0F76,8(a5)
                clr.w   $C(a5)
                move.b  #$3C,$20(a5)                    ; '<'
                move.w  #$800,$24(a5)
                move.b  #$80,$21(a5)
                move.l  #$F60AF40C,$28(a5)
                move.w  #$120,$14(a5)
; Waits for camera position to reach threshold before activation
Enemy_ShipCannon1Init_WaitCamera:                       ; DATA XREF: ROM:0002F922   o  ; was: loc_2F97A
                cmpi.w  #$17A0,(dword_FFA900).w
                bmi.s   loc_2F9B8
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
loc_2F986:                                              ; CODE XREF: Enemy_ShipCannon1Init+56   j
                cmpi.w  #$36C,(a0)
                beq.s   loc_2F9B8
                lea     $60(a0),a0
                cmpa.w  #$DB20,a0
                bmi.s   loc_2F986
                bset    #0,(byte_FFA272).w
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.l  #off_1A0F62,8(a5)
                clr.w   $C(a5)
                clr.b   $21(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F9B8:                                              ; CODE XREF: Enemy_ShipCannon1Init+42   j
                                        ; Enemy_ShipCannon1Init+4C   j
                tst.w   $24(a5)
                bmi.s   loc_2F9C2
                bra.w   Enemy_CannonFireProjectile
; ---------------------------------------------------------------------------
loc_2F9C2:                                              ; CODE XREF: Enemy_ShipCannon1Init+7E   j
                clr.b   $21(a5)
                move.w  #2,4(a5)
                move.l  #off_1A0FD2,8(a5)
                clr.w   $C(a5)
                bclr    #0,(byte_FFA272).w
                rts
; End of function Enemy_ShipCannon1Init
; Empty wait handler for ship cannon enemy
Enemy_ShipCannonEmptyWait:                              ; CODE XREF: Enemy_ShipCannon1Wait+4   j  ; was: nullsub_71
                                        ; Enemy_ShipCannon1Wait+26   j
                rts
; End of function Enemy_ShipCannonEmptyWait
; Cannon 1 wait state
Enemy_ShipCannon1Wait:                                  ; DATA XREF: ROM:0002F924   o  ; was: sub_2F9E2
                subq.w  #1,$48(a5)
                bpl.s   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.l  #$FFFD8000,$1C(a5)
                move.l  #off_1A0EB6,8(a5)
                clr.w   $C(a5)
; Applies gravity until cannon reaches floor position at Y=120
Enemy_ShipCannon1Wait_FallGravity:                      ; DATA XREF: ROM:0002F926   o  ; was: loc_2FA00
                addi.l  #$3800,$1C(a5)
                bmi.s   Enemy_ShipCannonEmptyWait
                cmpi.w  #$120,$14(a5)
                bmi.s   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.w  #$120,$14(a5)
                clr.l   $1C(a5)
                move.l  #off_1A0FA6,8(a5)
                clr.w   $C(a5)
                btst    #0,(byte_FFA209).w
                bne.w   loc_2FA8E
                rts
; End of function Enemy_ShipCannon1Wait
; Cannon 1 destroyed state
Enemy_ShipCannon1Destroyed:                             ; DATA XREF: ROM:0002F928   o  ; was: sub_2FA3E
                bsr.w   Enemy_UpdateFlipToPlayer
                subq.w  #1,$48(a5)
                bpl.s   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$A0,$48(a5)
                move.l  #off_1A0F8A,8(a5)
                clr.w   $C(a5)
; Updates cannon flip direction to face player
Enemy_ShipCannon1Wait_FacePlayer:                       ; DATA XREF: ROM:0002F92A   o  ; was: loc_2FA5E
                bsr.w   Enemy_UpdateFlipToPlayer
                subq.w  #1,$48(a5)
                bpl.w   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                bclr    #3,$E(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.l  #off_1A0FB2,8(a5)
                clr.w   $C(a5)
; Second timer wait state before cannon fires
Enemy_ShipCannon1Wait_SecondTimer:                      ; DATA XREF: ROM:0002F92C   o  ; was: loc_2FA86
                subq.w  #1,$48(a5)
                bpl.w   Enemy_ShipCannonEmptyWait
loc_2FA8E:                                              ; CODE XREF: Enemy_ShipCannon1Wait+56   j
                move.w  #$10,4(a5)
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
                move.b  (byte_FFA420).w,$20(a5)
                move.l  #$FFFF5000,$18(a5)
                move.l  #$FFFA0000,$1C(a5)
; Applies upward then downward gravity to cannon
Enemy_ShipCannon1Wait_ApplyGravity:                     ; DATA XREF: ROM:0002F92E   o  ; was: loc_2FAB6
                addi.l  #$4000,$1C(a5)
                bmi.w   Enemy_ShipCannonEmptyWait
                bclr    #7,$E(a5)
                cmpi.l  #$54000,$1C(a5)
                bmi.w   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.w  #$E000,2(a5)
; Cannon post-destruction wait state before next animation phase
Enemy_ShipCannon1Destroyed_WaitTimer:                   ; DATA XREF: ROM:0002F930   o  ; was: loc_2FAE4
                bsr.w   Enemy_ShipCannon3Main
                subq.w  #1,$48(a5)
                bpl.w   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
                move.b  #$18,d0
                jmp     (Sound_PlaySFX).l
; End of function Enemy_ShipCannon1Destroyed
; Main handler for ship cannon 2
Enemy_ShipCannon2Main:                                  ; DATA XREF: ROM:0002F932   o  ; was: sub_2FB10
                bsr.w   Enemy_ShipCannon3Main
                subq.w  #1,$48(a5)
                bpl.w   Enemy_ShipCannonEmptyWait
                addq.w  #2,4(a5)
                move.l  #off_1A0ED2,8(a5)
                clr.w   $C(a5)
                addq.w  #2,(word_FFA950).w
                addq.w  #2,(word_FFDB24).w
                move.w  #$F,(word_FF829E).w
                bclr    #0,(byte_FFA272).w
                move.l  #off_1A0EB6,8(a5)
                rts
; End of function Enemy_ShipCannon2Main
; Initializes ship cannon 2
Enemy_ShipCannon2Init:                                  ; DATA XREF: ROM:0002F934   o  ; was: sub_2FB4A
                move.b  (byte_FFA420).w,$20(a5)
                bra.w   Enemy_ShipCannon3Main
; End of function Enemy_ShipCannon2Init
; State dispatcher for cannon 2
Enemy_ShipCannon2Dispatcher:                            ; DATA XREF: ROM:0002F936   o  ; was: sub_2FB54
                addq.w  #2,4(a5)
                move.l  #off_1A0EDE,8(a5)
                clr.w   $C(a5)
; Branches to cannon projectile fire routine
Enemy_ShipCannon2Dispatcher_FireState:                  ; DATA XREF: ROM:0002F938   o  ; was: loc_2FB64
                bra.w   Enemy_CannonFireProjectile
; End of function Enemy_ShipCannon2Dispatcher
; Cannon 2 wait state
Enemy_ShipCannon2Wait:                                  ; DATA XREF: ROM:0002F93A   o  ; was: sub_2FB68
                addq.w  #2,4(a5)
                move.l  #off_1A0FD6,8(a5)
                clr.w   $C(a5)
                move.w  #$EE00,2(a5)
; Applies upward velocity to cannon during wait state
Enemy_ShipCannon2Wait_ApplyGravity:                     ; DATA XREF: ROM:0002F93C   o  ; was: loc_2FB7E
                addi.l  #$2000,$1C(a5)
                rts
; End of function Enemy_ShipCannon2Wait
; Periodically fires downward projectiles with sound effect
Enemy_CannonFireProjectile:                             ; CODE XREF: Enemy_ShipCannon1Init+80   j  ; was: sub_2FB88
                                        ; sub_2FB54:loc_2FB64   j
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   locret_2FBE8
                move.b  #$2C,d0                         ; ','
                jsr     (Sound_PlaySFX).l
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2FBE8
                move.w  #$188,(a0)
                move.w  #$8500,2(a0)
                move.w  #$C168,$E(a0)
                move.w  #$D00,8(a0)
                move.w  #$F0F8,$A(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$FFFF,$1C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                subi.w  #$10,$14(a0)
                move.w  #$18,$48(a0)
locret_2FBE8:                                           ; CODE XREF: Enemy_CannonFireProjectile+8   j
                                        ; Enemy_CannonFireProjectile+1A   j
                rts
; End of function Enemy_CannonFireProjectile
; Main handler for ship cannon 3
Enemy_ShipCannon3Main:                                  ; CODE XREF: Enemy_ShipCannon1Destroyed:loc_2FAE4   p  ; was: sub_2FBEA
                                        ; sub_2FB10   p
                bset    #3,$E(a5)
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  $10(a0),d0
                addi.w  #$44,d0                         ; 'D'
                move.w  d0,$10(a5)
                move.w  $14(a0),d0
                subi.w  #$27,d0                         ; '''
                move.w  d0,$14(a5)
                rts
; End of function Enemy_ShipCannon3Main
; Updates horizontal sprite flip based on player X position
Enemy_UpdateFlipToPlayer:                               ; CODE XREF: Enemy_ShipCannon1Destroyed   p  ; was: sub_2FC0E
                                        ; sub_2FA3E:loc_2FA5E   p
                bclr    #3,$E(a5)
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                bpl.s   locret_2FC24
                bset    #3,$E(a5)
locret_2FC24:                                           ; CODE XREF: Enemy_UpdateFlipToPlayer+E   j
                rts
; End of function Enemy_UpdateFlipToPlayer
; Main dispatcher checking screen bounds and routing to state
Enemy_ProjectileMainDispatch:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_2FC26
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bpl.s   loc_2FC34
                move.w  #4,4(a5)
loc_2FC34:                                              ; CODE XREF: Enemy_ProjectileMainDispatch+6   j
                nop
                move.w  4(a5),d0
                movea.w off_2FC46(pc,d0.w),a0           ; debug this link
                adda.l  #Enemy_ProjectileInit,a0
                jmp     (a0)
; End of function Enemy_ProjectileMainDispatch
; ---------------------------------------------------------------------------
off_2FC46:      dc.w    Projectile_Stage18Homing+2-Enemy_ProjectileInit
                                        ; DATA XREF: Enemy_ProjectileMainDispatch+14   r
                                        ; debug this link
                dc.w    Enemy_SpawnFromTable-Enemy_ProjectileInit
                dc.w    Enemy_SpawnFromTable_CheckSpawn-Enemy_ProjectileInit

; Initializes projectile sprite with graphics and movement parameters
Enemy_ProjectileInit:                                   ; DATA XREF: Enemy_ProjectileMainDispatch+18   o  ; was: sub_2FC4C
                                        ; ROM:off_2FC46   o
                addq.w  #2,4(a5)
                move.w  #$100,2(a5)
                ori.w   #$8000,2(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   loc_2FC78
                move.w  #$C4AC,$E(a5)
                bra.s   loc_2FC7E
; ---------------------------------------------------------------------------
loc_2FC78:                                              ; CODE XREF: Enemy_ProjectileInit+22   j
                move.w  #$C4B4,$E(a5)
loc_2FC7E:                                              ; CODE XREF: Enemy_ProjectileInit+2A   j
                move.w  #$20,$4A(a5)                    ; ' '
                move.w  #5,$4E(a5)
                move.w  $5E(a5),d0
                move.w  word_2FCA8(pc,d0.w),$50(a5)
                move.w  #$4000,$52(a5)
                move.b  #0,$54(a5)
                move.b  #1,$55(a5)
                rts
; End of function Enemy_ProjectileInit
; ---------------------------------------------------------------------------
word_2FCA8:     dc.w    $42E5, $4291, $42B5, $42E1, $4285, $42B1, $42D5, $4281
                                        ; DATA XREF: Enemy_ProjectileInit+42   r

nullsub_72:                                             ; CODE XREF: Boss_EnableVisibilityFlag+4   j
                rts
; End of function nullsub_72

; Waits for animation then enables sprite visibility flag
Boss_EnableVisibilityFlag:
                tst.w   $48(a5)                         ; was: sub_2FCBA
                bne.s   nullsub_72
                bset    #4,2(a5)
                clr.w   $4C(a5)
                bra.w   loc_2F4DC
; End of function Boss_EnableVisibilityFlag
; Updates boss graphics tiles via DMA based on animation frame
Boss_UpdateTilesDMA:
                tst.w   $48(a5)                         ; was: sub_2FCCE
                bne.w   locret_2F418
                move.w  $4C(a5),d0
                move.w  word_2FCEC(pc,d0.w),$56(a5)
                movea.w a5,a0
                adda.w  #$50,a0                         ; 'P'
                jmp     Gfx_DMATransferTiles
; End of function Boss_UpdateTilesDMA
; ---------------------------------------------------------------------------
word_2FCEC:     dc.w    $878C, $888D, $898E, $8A8F, $8B90
                                        ; DATA XREF: Boss_UpdateTilesDMA+C   r

; Floating enemy that oscillates horizontally and vertically
