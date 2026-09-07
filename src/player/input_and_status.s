Input_ReadPlayerInput:                              ; CODE XREF: Player_Update+1A   p  ; was: sub_16B04
                tst.w   (word_FFA02A).w
                bne.s   locret_16B22
                move.b  (word_FFF706).w,$69(a5)
                move.b  (word_FFF708).w,$6A(a5)
                move.b  (byte_FF830F).w,d0
                and.b   d0,$69(a5)
                and.b   d0,$6A(a5)
locret_16B22:                           ; CODE XREF: Input_ReadPlayerInput+4   j
                rts
; End of function Input_ReadPlayerInput
; Updates weapon switch timer and cooldown
Player_UpdateWeaponSwitchTimer:                              ; CODE XREF: Player_Update:loc_15030   p  ; was: sub_16B24
                                        ; sub_19DAE:loc_19DC8   p
                subq.w  #1,(word_FF826A).w
                bmi.s   loc_16B3A
                btst    #4,$6A(a5)
                beq.s   loc_16B4E
                bset    #0,(byte_FF826C).w
                bra.s   loc_16B4E
; ---------------------------------------------------------------------------
loc_16B3A:                              ; CODE XREF: Player_UpdateWeaponSwitchTimer+4   j
                move.w  #$FFFF,(word_FF826A).w
                btst    #4,$6A(a5)
                beq.s   loc_16B4E
                move.w  #$10,(word_FF826A).w
loc_16B4E:                              ; CODE XREF: Player_UpdateWeaponSwitchTimer+C   j
                                        ; Player_UpdateWeaponSwitchTimer+14   j ...
                move.w  (word_FFA216).w,d0
                sub.w   (word_FFA218).w,d0
                move.w  d0,(word_FF8304).w
                rts
; End of function Player_UpdateWeaponSwitchTimer
; Updates player direction bit from controller state
Player_UpdateDirectionBit:                              ; CODE XREF: Player_Update:loc_15038   p  ; was: sub_16B5C
                                        ; sub_19DAE:loc_19DE4   p
                btst    #5,(byte_FF8244).w
                bne.s   locret_16B72
                bclr    #7,$E(a5)
                move.w  (word_FF808A).w,d0
                or.w    d0,$E(a5)
locret_16B72:                           ; CODE XREF: Player_UpdateDirectionBit+6   j
                rts
; End of function Player_UpdateDirectionBit
; Sets player hit box collision boundaries with direction mirroring
Player_SetHitbox:                              ; CODE XREF: Player_Update+AE   p  ; was: sub_16B74
                                        ; Boss_SylpheedSpawnProjectile1+48   p
                move.w  $5C(a5),d0
                beq.s   locret_16BB0
                clr.w   $5C(a5)
                subq.w  #4,d0
                move.l  dword_16BB2(pc,d0.w),d0
                btst    #4,$E(a5)
                beq.s Player_ApplyHitboxOffset
                move.l  d0,(dword_FF8040).w
                move.l  d0,(dword_FF8044).w
                move.b  (dword_FF8044).w,d1
                neg.b   d1
                move.b  d1,(dword_FF8040+1).w
                move.b  (dword_FF8044+1).w,d1
                neg.b   d1
                move.b  d1,(dword_FF8040).w
                move.l  (dword_FF8040).w,d0
; Applies calculated hitbox offset values to player entity
Player_ApplyHitboxOffset:                              ; CODE XREF: Player_SetHitbox+16   j  ; was: loc_16BAC
                move.l  d0,$28(a5)
locret_16BB0:                           ; CODE XREF: Player_SetHitbox+4   j
                rts
; End of function Player_SetHitbox
; ---------------------------------------------------------------------------
dword_16BB2:    dc.l $E01EF808, $FC1EF808, $E018F808, $E01CF808, $FC1CF808, $E016F808, $E012F808
                                        ; DATA XREF: Player_SetHitbox+C   r


; Calculates player center position from hitbox bounds
Player_CalculateCenterPosition:                              ; CODE XREF: Player_Update+B6   j  ; was: sub_16BCE
                                        ; Boss_SylpheedSpawnProjectile1+52   j
                move.b  $2A(a5),d0
                ext.w   d0
                move.b  $2B(a5),d1
                ext.w   d1
                add.w   d1,d0
                asr.w   #1,d0
                add.w   $10(a5),d0
                move.w  d0,(word_FF8248).w
                move.b  $28(a5),d0
                ext.w   d0
                move.b  $29(a5),d1
                ext.w   d1
                add.w   d1,d0
                asr.w   #1,d0
                add.w   $14(a5),d0
                move.w  d0,(word_FF824A).w
                rts
; End of function Player_CalculateCenterPosition
; Manages player invulnerability and flash timer
Player_UpdateInvulnerabilityTimer:                              ; CODE XREF: Player_Update+AA   p  ; was: sub_16C00
                                        ; Boss_SylpheedSpawnProjectile1+42   p
                bset    #7,2(a5)
                subq.w  #1,$5E(a5)
                bpl.s   loc_16C22
                move.w  #$FFFF,$5E(a5)
                btst    #6,$21(a5)
                bne.s   locret_16C3E
                bclr    #4,$23(a5)
                rts
; ---------------------------------------------------------------------------
loc_16C22:                              ; CODE XREF: Player_UpdateInvulnerabilityTimer+A   j
                bset    #4,$23(a5)
                btst    #5,(byte_FF8244).w
                bne.s   locret_16C3E
                btst    #0,(word_FFA000+1).w
                beq.s   locret_16C3E
                bclr    #7,2(a5)
locret_16C3E:                           ; CODE XREF: Player_UpdateInvulnerabilityTimer+18   j
                                        ; Player_UpdateInvulnerabilityTimer+2E   j ...
                rts
; End of function Player_UpdateInvulnerabilityTimer
; Updates player horizontal facing bit from input
Player_UpdateHorizontalFacing:                              ; CODE XREF: Player_HandleSpecialAttack+B0   p  ; was: sub_16C40
                                        ; Player_CheckSpecialAttack+1E   p ...
                btst    #2,$69(a5)
                beq.s   loc_16C50
                bclr    #3,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_16C50:                              ; CODE XREF: Player_UpdateHorizontalFacing+6   j
                btst    #3,$69(a5)
                beq.w   locret_16C60
                bset    #3,$E(a5)
locret_16C60:                           ; CODE XREF: Player_UpdateHorizontalFacing+16   j
                rts
; End of function Player_UpdateHorizontalFacing
; Finds free object slot for dash trail effect
Effect_FindDashTrailSlot:                              ; CODE XREF: Effect_CreateDashTrail:loc_177D8   p  ; was: sub_16C62
                                        ; Effect_CreateDashTrail+7A   p
                movea.w #(dword_FFBFC0-M68K_RAM),a0
                moveq   #$B,d7
                jmp Sys_FindFreeObjectSlot
; End of function Effect_FindDashTrailSlot
; Loads player sprite palette based on state
Gfx_LoadPlayerPaletteData:                              ; CODE XREF: Player_Update+54   p  ; was: sub_16C6E
                                        ; sub_19DAE   p
                tst.w   (word_FF8304).w
                bne.s   loc_16C8C
                move.w  (word_FFA000).w,d0
                btst    #4,d0
                bne.s   loc_16C8C
                andi.w  #3,d0
                bne.s   loc_16C8C
                lea     word_16CC0(pc),a0
                nop
                bra.s Gfx_CopyPlayerPaletteWords
; ---------------------------------------------------------------------------
loc_16C8C:                              ; CODE XREF: Gfx_LoadPlayerPaletteData+4   j
                                        ; Gfx_LoadPlayerPaletteData+E   j ...
                lea     word_16CB0(pc),a0
                nop
                tst.w   (word_FFA22A).w
                beq.s Gfx_CopyPlayerPaletteWords
                lea     word_16CB8(pc),a0
                nop
; Copies 8 bytes of player palette data to two RAM locations
Gfx_CopyPlayerPaletteWords:                              ; CODE XREF: Gfx_LoadPlayerPaletteData+1C   j  ; was: loc_16C9E
                                        ; Gfx_LoadPlayerPaletteData+28   j
                movea.w #(byte_FFE352-M68K_RAM),a1
                movea.w #(dword_FFE3D2-M68K_RAM),a2
                move.l  (a0),(a1)+
                move.l  (a0)+,(a2)+
                move.l  (a0),(a1)+
                move.l  (a0)+,(a2)+
                rts
; End of function Gfx_LoadPlayerPaletteData
; ---------------------------------------------------------------------------
word_16CB0:     dc.w $22, $46, $488, $8CC
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData:loc_16C8C   o
word_16CB8:     dc.w $220, $442, $888, $CCC
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData+2A   o
word_16CC0:     dc.w $C88, $EAA, $ECC, $EEE
                                        ; DATA XREF: Gfx_LoadPlayerPaletteData+16   o


; Terrain collision wrapper checking flag before testing walls
