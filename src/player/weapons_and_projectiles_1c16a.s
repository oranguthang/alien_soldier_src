Projectile_FindFreeSlot:                              ; CODE XREF: Enemy_SpawnProjectileAtAngle   p  ; was: sub_1C16A
                                        ; sub_2A0D6   p ...
                movea.w #(byte_FFD9A0-M68K_RAM),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   locret_1C282
                lea     -$60(a0),a0
                move.w  (a0),d0
                beq.w   *+4
locret_1C282:                           ; CODE XREF: Projectile_FindFreeSlot+6   j
                                        ; Projectile_FindFreeSlot+10   j ...
                rts
; End of function Projectile_FindFreeSlot
; Clear registers d0 and d1
Math_ClearD0D1:
                moveq   #0,d0  ; was: sub_1C284
                moveq   #0,d1
; End of function Math_ClearD0D1
; Clears all objects except specified types
Sprite_ClearAllExcept:                              ; CODE XREF: Cutscene_ShipAnimationLoop+26   j  ; was: sub_1C288
                                        ; Stage_CaterpillarShipMovement+A0   p ...
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                moveq   #0,d3
                moveq   #$3C,d7 ; '<'
loc_1C290:                              ; CODE XREF: Sprite_ClearAllExcept+76   j
                                        ; Boss_SireneBattleStart+74   p
                move.w  (a0),d2
                beq.s   loc_1C2FA
                cmp.w   d0,d2
                beq.s   loc_1C2FA
                cmp.w   d1,d2
                beq.s   loc_1C2FA
                move.l  d3,(a0)
                move.l  d3,4(a0)
                move.l  d3,8(a0)
                move.l  d3,$C(a0)
                move.l  d3,$10(a0)
                move.l  d3,$14(a0)
                move.l  d3,$18(a0)
                move.l  d3,$1C(a0)
                move.l  d3,$20(a0)
                move.l  d3,$24(a0)
                move.l  d3,$28(a0)
                move.l  d3,$2C(a0)
                move.l  d3,$30(a0)
                move.l  d3,$34(a0)
                move.l  d3,$38(a0)
                move.l  d3,$3C(a0)
                move.l  d3,$40(a0)
                move.l  d3,$44(a0)
                move.l  d3,$48(a0)
                move.l  d3,$4C(a0)
                move.l  d3,$50(a0)
                move.l  d3,$54(a0)
                move.l  d3,$58(a0)
                move.l  d3,$5C(a0)
loc_1C2FA:                              ; CODE XREF: Sprite_ClearAllExcept+A   j
                                        ; Sprite_ClearAllExcept+E   j ...
                lea     $60(a0),a0
                dbf     d7,loc_1C290
                rts
; End of function Sprite_ClearAllExcept
; Finds free projectile slot and clears
Projectile_FindFreeSlotAndClear:                              ; CODE XREF: Projectile_SpawnQuadPattern:loc_E294   p  ; was: sub_1C304
                                        ; sub_2FF1C:loc_2FF62   p ...
                movem.l d7,-(sp)
                jsr Projectile_UpdateTrajectory(pc)   ; (pc)
                beq.s   loc_1C32A
                movea.w #(word_FFCF80-M68K_RAM),a0
                moveq   #$1A,d7
loc_1C314:                              ; CODE XREF: Projectile_FindFreeSlotAndClear+20   j
                move.w  (a0),d0
                beq.s   loc_1C32A
                btst    #6,3(a0)
                bne.s   loc_1C330
                lea     $60(a0),a0
                dbf     d7,loc_1C314
                moveq   #1,d7
loc_1C32A:                              ; CODE XREF: Projectile_FindFreeSlotAndClear+8   j
                                        ; Projectile_FindFreeSlotAndClear+12   j
                movem.l (sp)+,d7
                rts
; ---------------------------------------------------------------------------
loc_1C330:                              ; CODE XREF: Projectile_FindFreeSlotAndClear+1A   j
                moveq   #0,d7
                move.l  d7,(a0)
                move.l  d7,4(a0)
                move.l  d7,8(a0)
                move.l  d7,$C(a0)
                move.l  d7,$10(a0)
                move.l  d7,$14(a0)
                move.l  d7,$18(a0)
                move.l  d7,$1C(a0)
                move.l  d7,$20(a0)
                move.l  d7,$24(a0)
                move.l  d7,$28(a0)
                move.l  d7,$2C(a0)
                move.l  d7,$30(a0)
                move.l  d7,$34(a0)
                move.l  d7,$38(a0)
                move.l  d7,$3C(a0)
                move.l  d7,$40(a0)
                move.l  d7,$44(a0)
                move.l  d7,$48(a0)
                move.l  d7,$4C(a0)
                move.l  d7,$50(a0)
                move.l  d7,$54(a0)
                move.l  d7,$58(a0)
                move.l  d7,$5C(a0)
                moveq   #0,d7
                movem.l (sp)+,d7
                rts
; End of function Projectile_FindFreeSlotAndClear
; Clear 96 bytes of object data
Object_Clear96Bytes:                              ; CODE XREF: Boss_ValkirieMovePattern1:loc_566BC   p  ; was: sub_1C398
                moveq   #0,d3
                move.l  d3,(a0)
                move.l  d3,4(a0)
                move.l  d3,8(a0)
                move.l  d3,$C(a0)
                move.l  d3,$10(a0)
                move.l  d3,$14(a0)
                move.l  d3,$18(a0)
                move.l  d3,$1C(a0)
                move.l  d3,$20(a0)
                move.l  d3,$24(a0)
                move.l  d3,$28(a0)
                move.l  d3,$2C(a0)
                move.l  d3,$30(a0)
                move.l  d3,$34(a0)
                move.l  d3,$38(a0)
                move.l  d3,$3C(a0)
                move.l  d3,$40(a0)
                move.l  d3,$44(a0)
                move.l  d3,$48(a0)
                move.l  d3,$4C(a0)
                move.l  d3,$50(a0)
                move.l  d3,$54(a0)
                move.l  d3,$58(a0)
                move.l  d3,$5C(a0)
                rts
; End of function Object_Clear96Bytes
; Loads stage background graphics with DMA and palette transitions
Stage_LoadBackgroundGraphics:                              ; DATA XREF: Sys_DispatchGameState+62   o  ; was: sub_1C3FA
                tst.b   (word_FFF720).w
                bmi.s   locret_1C448
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_1C4C2
                move.w  (GameSubstateIndex).w,d0
                bne.s   loc_1C44A
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Sys_InitGraphicsChain).l
                jsr (Gfx_LoadVDPRegisters).l
                jsr (Stage_StateDispatcher).l
                jsr (Sys_InitStageState).l
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA900).w,(word_FFA946).w
                move.w  (dword_FFA904).w,(word_FFA948).w
locret_1C448:                           ; CODE XREF: Stage_LoadBackgroundGraphics+4   j
                                        ; Stage_LoadBackgroundGraphics+8E   j ...
                rts
; ---------------------------------------------------------------------------
loc_1C44A:                              ; CODE XREF: Stage_LoadBackgroundGraphics+14   j
                move.w  (word_FF80AA).w,d0
                bne.s   loc_1C46A
                clr.w   (word_FFA946).w
                move.w  #$4000,(dword_FFA940).w
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                bmi.s   loc_1C4AA
                rts
; ---------------------------------------------------------------------------
loc_1C46A:                              ; CODE XREF: Stage_LoadBackgroundGraphics+54   j
                bpl.s   loc_1C48E
                andi.w  #$7FFF,d0
                lea     off_1C536(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr (Gfx_RenderLayeredBackground).l
                jsr (Gfx_RenderLayeredBackground).l
                bpl.w   locret_1C448
                bra.s   loc_1C4AA
; ---------------------------------------------------------------------------
loc_1C48E:                              ; CODE XREF: Stage_LoadBackgroundGraphics:loc_1C46A   j
                lea     off_1C536(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C448
loc_1C4AA:                              ; CODE XREF: Stage_LoadBackgroundGraphics+6C   j
                                        ; Stage_LoadBackgroundGraphics+92   j
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA908).w,(word_FFA946).w
                move.w  (dword_FFA90C).w,(word_FFA948).w
                rts
; ---------------------------------------------------------------------------
loc_1C4C2:                              ; CODE XREF: Stage_LoadBackgroundGraphics+C   j
                move.w  (word_FF80AC).w,d0
                bne.s   loc_1C4E2
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                bmi.s   loc_1C4FE
                rts
; ---------------------------------------------------------------------------
loc_1C4E2:                              ; CODE XREF: Stage_LoadBackgroundGraphics+CC   j
                lea     off_1C53E(pc),a0
                nop
                move.l  -4(a0,d0.w),(dword_FFA940).w
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C448
loc_1C4FE:                              ; CODE XREF: Stage_LoadBackgroundGraphics+E4   j
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
; Jumps to stage handler routine after setup completion
Stage_JumpToHandler:                              ; DATA XREF: Stage_XiTigerHandler+88   r  ; was: loc_1C530
                jmp Stage_ProcessHandler
; End of function Stage_LoadBackgroundGraphics
; ---------------------------------------------------------------------------
off_1C536:      dc.l dword_11316        ; DATA XREF: Stage_LoadBackgroundGraphics+76   o
                                        ; sub_1C3FA:loc_1C48E   o ...
off_1C53A:      dc.l dword_11326        ; DATA XREF: Stage_XiTigerHandler+DA   r
off_1C53E:      dc.l dword_11336        ; DATA XREF: Stage_LoadBackgroundGraphics:loc_1C4E2   o
                                        ; sub_1C546:loc_1C61C   o
                dc.l dword_11346


; Xi Tiger stage initialization
Stage_XiTigerHandler:                              ; DATA XREF: Sys_DispatchGameState+D6   o  ; was: sub_1C546
                tst.b   (word_FFF720).w
                bmi.s   locret_1C5A8
                cmpi.w  #4,(GameSubstateIndex).w
                beq.w   loc_1C5FC
                move.w  (GameSubstateIndex).w,d0
                bne.s   loc_1C5AA
                jsr (Sys_InitGraphicsChain).l
                jsr (Gfx_LoadVDPRegisters).l
                jsr (Stage_LoadXiTigerGraphics).l
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA900).w,(word_FFA946).w
                move.w  (dword_FFA904).w,(word_FFA948).w
locret_1C5A8:                           ; CODE XREF: Stage_XiTigerHandler+4   j
                                        ; Stage_XiTigerHandler+9A   j ...
                rts
; ---------------------------------------------------------------------------
loc_1C5AA:                              ; CODE XREF: Stage_XiTigerHandler+14   j
                move.w  (word_FF80AA).w,d0
                bne.s   loc_1C5CA
                clr.w   (word_FFA946).w
                move.w  #$4000,(dword_FFA940).w
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                bmi.s   loc_1C5E4
                rts
; ---------------------------------------------------------------------------
loc_1C5CA:                              ; CODE XREF: Stage_XiTigerHandler+68   j
                lea     off_1C536(pc),a0
                move.l  off_1C536-4-off_1C536(a0,d0.w),(dword_FFA940).w
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C5A8
loc_1C5E4:                              ; CODE XREF: Stage_XiTigerHandler+80   j
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$1F,(word_FFA944).w
                move.w  (dword_FFA908).w,(word_FFA946).w
                move.w  (dword_FFA90C).w,(word_FFA948).w
                rts
; ---------------------------------------------------------------------------
loc_1C5FC:                              ; CODE XREF: Stage_XiTigerHandler+C   j
                move.w  (word_FF80AC).w,d0
                bne.s   loc_1C61C
                clr.w   (word_FFA946).w
                move.w  #$6000,(dword_FFA940).w
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                bmi.s   loc_1C636
                rts
; ---------------------------------------------------------------------------
loc_1C61C:                              ; CODE XREF: Stage_XiTigerHandler+BA   j
                lea     off_1C53E(pc),a0
                move.l  off_1C53A-off_1C53E(a0,d0.w),(dword_FFA940).w
                jsr (Gfx_RenderScrollingBackground).l
                jsr (Gfx_RenderScrollingBackground).l
                bpl.w   locret_1C5A8
loc_1C636:                              ; CODE XREF: Stage_XiTigerHandler+D2   j
                move.w  #$10,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.b   (byte_FFF705).w
                move.w  #$8004,(word_FF80F2).w
                move.w  #$10,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jmp Stage_ProcessHandler
; End of function Stage_XiTigerHandler
; Main gameplay loop processing player
Sys_GameplayMainLoop:                              ; DATA XREF: Sys_DispatchGameState+66   o  ; was: sub_1C65C
                bsr.w   nullsub_2
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C672
                move.w  #$C7F0,(word_FF8110).w
                move.w  #$20,(word_FF8112).w ; ' '
loc_1C672:                              ; CODE XREF: Sys_GameplayMainLoop+8   j
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C68A
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$822,(VDP_DATA).l
loc_1C68A:                              ; CODE XREF: Sys_GameplayMainLoop+1A   j
                bsr.w Gfx_UpdateScrollPosition
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6A6
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
loc_1C6A6:                              ; CODE XREF: Sys_GameplayMainLoop+36   j
                jsr (Boss_UpdateCollisionSystem).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6C4
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C6C4:                              ; CODE XREF: Sys_GameplayMainLoop+54   j
                jsr (Sys_InitObjectPointers).l
                bsr.w UI_CheckVBlankFlag
                bsr.w UI_SetWeaponIconIndex
                jsr (Gfx_PrimaryEffectDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6F0
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
loc_1C6F0:                              ; CODE XREF: Sys_GameplayMainLoop+80   j
                jsr (Physics_ApplyFriction).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C70E
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E0,(VDP_DATA).l
loc_1C70E:                              ; CODE XREF: Sys_GameplayMainLoop+9E   j
                jsr (Player_Update).l
                jsr (UI_UpdateWeaponDisplay).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C732
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C732:                              ; CODE XREF: Sys_GameplayMainLoop+C2   j
                jsr (Sys_UpdateObjectSpawner).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C750
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
loc_1C750:                              ; CODE XREF: Sys_GameplayMainLoop+E0   j
                jsr (Sys_ProcessProjectiles).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C76E
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C76E:                              ; CODE XREF: Sys_GameplayMainLoop+FE   j
                jsr (Boss_JetsripperMoveLeft).l
                jsr (Effect_PaletteDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C792
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C792:                              ; CODE XREF: Sys_GameplayMainLoop+122   j
                jsr (Stage_ProcessHandler).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C7B0
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
loc_1C7B0:                              ; CODE XREF: Sys_GameplayMainLoop+140   j
                jsr (Gfx_SecondaryEffectDispatcher).l
                bsr.w Sys_UpdateObjectCount
                jsr (Player_BehaviorDispatcher).l
                jsr (UI_RenderHUDElement1).l
                bsr.w Effect_ScreenShakeUpdate
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C7E2
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C7E2:                              ; CODE XREF: Sys_GameplayMainLoop+172   j
                jsr (Sys_ProcessObjectList).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C800
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C800:                              ; CODE XREF: Sys_GameplayMainLoop+190   j
                jsr (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1C816
loc_1C80E:                              ; CODE XREF: Sys_GameplayMainLoop+1C6   j
                move.b  #$41,(byte_FFF705).w ; 'A'
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C816:                              ; CODE XREF: Sys_GameplayMainLoop+1B0   j
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1C860
                move.w  (word_FF8230).w,d0
                beq.s   loc_1C80E
                clr.w   (word_FFA21E).w
                cmpi.w  #1,d0
                bne.s   loc_1C844
                move.w  #$2C,(GameModeIndex).w ; ','
                clr.w   (GameSubstateIndex).w
                move.b  #4,d0
                jsr (Sound_PlaySFX).l
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C844:                              ; CODE XREF: Sys_GameplayMainLoop+1D0   j
                cmpi.w  #3,d0
                bne.s   loc_1C856
                move.w  #$34,(GameModeIndex).w ; '4'
                clr.w   (GameSubstateIndex).w
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C856:                              ; CODE XREF: Sys_GameplayMainLoop+1EC   j
                move.w  #$68,(GameModeIndex).w ; 'h'
                clr.w   (GameSubstateIndex).w
loc_1C860:                              ; CODE XREF: Sys_GameplayMainLoop+1B8   j
                                        ; Sys_GameplayMainLoop+1C0   j ...
                tst.b   (byte_FFF705).w
                bmi.s   loc_1C884
                addq.w  #1,(word_FFA000).w
                subq.w  #1,(word_FF813C).w
                bpl.s   loc_1C87C
                move.w  #$FFFF,(word_FF813C).w
                move.b  #0,d0
                bra.s   loc_1C880
; ---------------------------------------------------------------------------
loc_1C87C:                              ; CODE XREF: Sys_GameplayMainLoop+212   j
                move.b  #$80,d0
loc_1C880:                              ; CODE XREF: Sys_GameplayMainLoop+21E   j
                move.b  d0,(byte_FF813E).w
loc_1C884:                              ; CODE XREF: Sys_GameplayMainLoop+208   j
                move.b  (byte_FFF705).w,d0
                or.b    d0,(byte_FF813E).w
                jmp (Gfx_ClearBackgroundColor).l
; End of function Sys_GameplayMainLoop
; Set game state to $40
Sys_SetState40:
                move.w  #$40,(GameModeIndex).w ; '@'  ; was: sub_1C892
                clr.w   (GameSubstateIndex).w
                rts
; End of function Sys_SetState40
; Set game state to $3C with input
Sys_SetState3CWithInput:
                move.w  #$3C,(GameModeIndex).w ; '<'  ; was: sub_1C89E
                clr.w   (GameSubstateIndex).w
                move.b  #1,d0
                jmp (Input_ProcessButtons).l
; End of function Sys_SetState3CWithInput
; Sets weapon icon index from weapon ID lookup
UI_SetWeaponIconIndex:                              ; CODE XREF: Sys_GameplayMainLoop+72   p  ; was: sub_1C8B2
                move.w  (StageTableIndex).w,d0
                asr.w   #1,d0
                move.b  byte_1C8C0(pc,d0.w),(byte_FF8232).w
                rts
; End of function UI_SetWeaponIconIndex
; ---------------------------------------------------------------------------
byte_1C8C0:     dc.b 1, 2, 3, 4, 5, 6, 7, 8, 9, $10
                                        ; DATA XREF: UI_SetWeaponIconIndex+6   r
                dc.b $11, $12, $13, $14, $15, $16, $17, $18, $19, $20
                dc.b $21, $22, $23, $24, $25, $26, $27, $28, $29, $30
                dc.b $31, $32, $33, $34, $35, $36, $37, $38, $39, $40
                dc.b $41, $42, $43, $44, $45, $46, $47, $48, $49, $50


; Checks VBlank flag and conditionally writes VDP value
UI_CheckVBlankFlag:                              ; CODE XREF: Sys_StoryScreenMainLoop+2C   p  ; was: sub_1C8F2
                                        ; UI_UpdateOptionsScreen+52   p ...
                tst.b   (byte_FF813E).w
                bmi.w   locret_1C900
                move.w  #$ED00,(word_FFF758).w
locret_1C900:                           ; CODE XREF: UI_CheckVBlankFlag+4   j
                rts
; End of function UI_CheckVBlankFlag
; Calculates number of active visible objects from list pointer
Sys_UpdateObjectCount:                              ; CODE XREF: Sys_StoryScreenMainLoop+44   p  ; was: sub_1C902
                                        ; UI_UpdateOptionsScreen+62   p ...
                tst.b   (byte_FF813E).w
                bmi.w   locret_1C918
                move.w  (word_FFF758).w,d0
                subi.w  #$ED00,d0
                lsr.w   #1,d0
                move.w  d0,(word_FFF75A).w
locret_1C918:                           ; CODE XREF: Sys_UpdateObjectCount+4   j
                rts
; End of function Sys_UpdateObjectCount
; Display pause menu graphics
UI_DisplayPauseGraphics:
                move.b  (byte_FFF705).w,d0  ; was: sub_1C91A
                bpl.w   locret_1C944
                btst    #6,d0
                beq.w   locret_1C944
                move.b  (word_FFF706).w,d0
                or.b    (word_FFF706+1).w,d0
                andi.b  #$40,d0 ; '@'
                bne.w   locret_1C944
                btst    #4,(word_FFA280+1).w
                bne.w   loc_1C946
locret_1C944:                           ; CODE XREF: UI_DisplayPauseGraphics+4   j
                                        ; UI_DisplayPauseGraphics+C   j ...
                rts
; ---------------------------------------------------------------------------
loc_1C946:                              ; CODE XREF: UI_DisplayPauseGraphics+26   j
                lea     (dword_FFA100).w,a0
                movea.w a0,a1
                move.l  #byte_A00C00,(a1)+
                move.w  #$C7EB,(a1)+
                move.w  #$C0,(a1)+
                move.l  #Z80_RAM,(a1)+
                move.w  #$C7EF,(a1)+
                move.w  #$E0,(a1)+
                move.w  #$FFFF,(a1)
                jmp (Sprite_AddToOAMBuffer).l
; End of function UI_DisplayPauseGraphics
; ---------------------------------------------------------------------------
word_1C972:     dc.w 0, $800, $1800, $1000
                                        ; DATA XREF: Gfx_UpdateScrollPosition:loc_1C982   o
                                        ; Boss_StateDispatcher+7C   o ...


; Updates camera scroll position based on player
Gfx_UpdateScrollPosition:                              ; CODE XREF: Sys_StoryScreenMainLoop:loc_491C   p  ; was: sub_1C97A
                                        ; UI_UpdateOptionsScreen+46   p ...
                tst.b   (byte_FF813E).w
                bpl.s   loc_1C982
                rts
; ---------------------------------------------------------------------------
loc_1C982:                              ; CODE XREF: Gfx_UpdateScrollPosition+4   j
                movea.l #word_1C972,a0
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  (a0,d0.w),(word_FF8092).w
                move.w  (dword_FFA900).w,d0
                sub.w   (word_FFA928).w,d0
                move.w  (dword_FFA904).w,d1
                sub.w   (word_FFA92C).w,d1
                move.w  d0,(dword_FFA910).w
                move.w  d1,(word_FFA914).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                btst    #6,(byte_FFA959).w
                beq.s   loc_1C9C6
                moveq   #0,d0
loc_1C9C6:                              ; CODE XREF: Gfx_UpdateScrollPosition+48   j
                btst    #7,(byte_FFA959).w
                beq.s   loc_1C9D0
                moveq   #0,d1
loc_1C9D0:                              ; CODE XREF: Gfx_UpdateScrollPosition+52   j
                tst.w   d0
                bne.s   loc_1C9DA
                tst.w   d1
                beq.w   loc_1CA3A
loc_1C9DA:                              ; CODE XREF: Gfx_UpdateScrollPosition+58   j
                move.b  #3,d5
                move.b  #2,d6
                move.b  #0,d7
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   loc_1C9FC
                bsr.w Physics_ApplyVelocityWithBounds
                bsr.w Physics_ApplyPositionOffset
                bsr.w Projectile_CheckBounds
loc_1C9FC:                              ; CODE XREF: Gfx_UpdateScrollPosition+74   j
                move.w  (word_FFF75A).w,d4
                beq.s   locret_1CA38
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
loc_1CA08:                              ; CODE XREF: Gfx_UpdateScrollPosition:loc_1CA34   j
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   loc_1CA34
                btst    d5,d2
                beq.s   loc_1CA1C
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
loc_1CA1C:                              ; CODE XREF: Gfx_UpdateScrollPosition+98   j
                btst    d6,d2
                beq.s   loc_1CA28
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
loc_1CA28:                              ; CODE XREF: Gfx_UpdateScrollPosition+A4   j
                btst    d7,d2
                beq.s   loc_1CA34
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
loc_1CA34:                              ; CODE XREF: Gfx_UpdateScrollPosition+94   j
                                        ; Gfx_UpdateScrollPosition+B0   j
                dbf     d4,loc_1CA08
locret_1CA38:                           ; CODE XREF: Gfx_UpdateScrollPosition+86   j
                rts
; ---------------------------------------------------------------------------
loc_1CA3A:                              ; CODE XREF: Gfx_UpdateScrollPosition+5C   j
                move.b  #3,d5
                move.b  #2,d6
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   loc_1CA54
                bsr.w Physics_ApplyVelocityWithBounds
                bsr.w Projectile_CheckBounds
loc_1CA54:                              ; CODE XREF: Gfx_UpdateScrollPosition+D0   j
                move.w  (word_FFF75A).w,d4
                beq.s   locret_1CA84
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
loc_1CA60:                              ; CODE XREF: Gfx_UpdateScrollPosition:loc_1CA80   j
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   loc_1CA80
                btst    d5,d2
                beq.s   loc_1CA74
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
loc_1CA74:                              ; CODE XREF: Gfx_UpdateScrollPosition+F0   j
                btst    d6,d2
                beq.s   loc_1CA80
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
loc_1CA80:                              ; CODE XREF: Gfx_UpdateScrollPosition+EC   j
                                        ; Gfx_UpdateScrollPosition+FC   j
                dbf     d4,loc_1CA60
locret_1CA84:                           ; CODE XREF: Gfx_UpdateScrollPosition+DE   j
                rts
; End of function Gfx_UpdateScrollPosition
; Applies velocity with boundary clamping
Physics_ApplyVelocityWithBounds:                              ; CODE XREF: Gfx_UpdateScrollPosition+76   p  ; was: sub_1CA86
                                        ; Gfx_UpdateScrollPosition+D2   p
                btst    d5,d2
                beq.s   loc_1CABA
                move.l  $18(a5),d3
                move.l  (dword_FF8240).w,d4
                btst    #1,(byte_FF8244).w
                beq.s   loc_1CA9C
                asr.l   #2,d4
loc_1CA9C:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+12   j
                add.l   d4,d3
                move.l  (dword_FFA938).w,d4
                tst.l   d3
                bmi.s   loc_1CAAE
                cmp.l   d4,d3
                bmi.s   loc_1CAB6
                move.l  d4,d3
                bra.s   loc_1CAB6
; ---------------------------------------------------------------------------
loc_1CAAE:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+1E   j
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   loc_1CAB6
                move.l  d4,d3
loc_1CAB6:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+22   j
                                        ; Physics_ApplyVelocityWithBounds+26   j ...
                add.l   d3,$10(a5)
loc_1CABA:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+2   j
                btst    d6,d2
                beq.s   locret_1CAE2
                move.l  $1C(a5),d3
                add.l   (dword_FF830A).w,d3
                move.l  (dword_FFA93C).w,d4
                tst.l   d3
                bmi.s   loc_1CAD6
                cmp.l   d4,d3
                bmi.s   loc_1CADE
                move.l  d4,d3
                bra.s   loc_1CADE
; ---------------------------------------------------------------------------
loc_1CAD6:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+46   j
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   loc_1CADE
                move.l  d4,d3
loc_1CADE:                              ; CODE XREF: Physics_ApplyVelocityWithBounds+4A   j
                                        ; Physics_ApplyVelocityWithBounds+4E   j ...
                add.l   d3,$14(a5)
locret_1CAE2:                           ; CODE XREF: Physics_ApplyVelocityWithBounds+36   j
                rts
; End of function Physics_ApplyVelocityWithBounds
; Applies position offset based on direction flags
Physics_ApplyPositionOffset:                              ; CODE XREF: Gfx_UpdateScrollPosition+7A   p  ; was: sub_1CAE4
                btst    d7,d2
                beq.s   locret_1CAF0
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
locret_1CAF0:                           ; CODE XREF: Physics_ApplyPositionOffset+2   j
                rts
; End of function Physics_ApplyPositionOffset
; Checks if projectile is out of bounds
Projectile_CheckBounds:                              ; CODE XREF: Gfx_UpdateScrollPosition+7E   p  ; was: sub_1CAF2
                                        ; Gfx_UpdateScrollPosition+D6   p
                btst    #1,(byte_FF8245).w
                bne.s   loc_1CB18
                cmpi.w  #$90,$10(a5)
                bpl.s   loc_1CB0A
                move.w  #$90,$10(a5)
                bra.s   loc_1CB18
; ---------------------------------------------------------------------------
loc_1CB0A:                              ; CODE XREF: Projectile_CheckBounds+E   j
                cmpi.w  #$1B0,$10(a5)
                bmi.s   loc_1CB18
                move.w  #$1AF,$10(a5)
loc_1CB18:                              ; CODE XREF: Projectile_CheckBounds+6   j
                                        ; Projectile_CheckBounds+16   j ...
                btst    #2,(byte_FF8245).w
                bne.s   locret_1CB2E
                cmpi.w  #$98,$14(a5)
                bpl.s   locret_1CB2E
                move.w  #$98,$14(a5)
locret_1CB2E:                           ; CODE XREF: Projectile_CheckBounds+2C   j
                                        ; Projectile_CheckBounds+34   j
                rts
; End of function Projectile_CheckBounds
nullsub_2:                              ; CODE XREF: Sys_GameplayMainLoop   p
                rts
; End of function nullsub_2


; Toggle debug flag on button press
Input_ToggleDebugFlag:
                move.b  (byte_FFF705).w,d0  ; was: sub_1CB32
                bpl.w   locret_1CB58
                btst    #6,d0
                beq.w   locret_1CB58
                move.b  (word_FFF708).w,d0
                or.b    (word_FFF708+1).w,d0
                btst    #5,d0
                beq.w   locret_1CB58
                eori.b  #$80,(byte_FFF746).w
locret_1CB58:                           ; CODE XREF: Input_ToggleDebugFlag+4   j
                                        ; Input_ToggleDebugFlag+C   j ...
                rts
; End of function Input_ToggleDebugFlag
; Updates screen shake effect by modifying scroll registers with decay timer
Effect_ScreenShakeUpdate:                              ; CODE XREF: Sys_GameplayMainLoop+16A   p  ; was: sub_1CB5A
                tst.b   (byte_FF813E).w
                bmi.s   locret_1CBB8
                move.w  (word_FFA012).w,(word_FF8086).w
                move.w  (word_FFA016).w,(word_FF8088).w
                move.w  (word_FFA000).w,d0
                tst.w   (word_FFA010).w
                bne.s   loc_1CB7C
loc_1CB76:                              ; CODE XREF: Effect_ScreenShakeUpdate+26   j
                clr.w   (word_FFA012).w
                bra.s   loc_1CB94
; ---------------------------------------------------------------------------
loc_1CB7C:                              ; CODE XREF: Effect_ScreenShakeUpdate+1A   j
                btst    #1,d0
                bne.s   loc_1CB76
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   loc_1CB8E
                subq.w  #1,(word_FFA010).w
loc_1CB8E:                              ; CODE XREF: Effect_ScreenShakeUpdate+2E   j
                move.w  (word_FFA010).w,(word_FFA012).w
loc_1CB94:                              ; CODE XREF: Effect_ScreenShakeUpdate+20   j
                tst.w   (word_FFA014).w
                bne.s   loc_1CBA0
loc_1CB9A:                              ; CODE XREF: Effect_ScreenShakeUpdate+4A   j
                clr.w   (word_FFA016).w
                rts
; ---------------------------------------------------------------------------
loc_1CBA0:                              ; CODE XREF: Effect_ScreenShakeUpdate+3E   j
                btst    #1,d0
                bne.s   loc_1CB9A
                move.w  d0,d1
                andi.w  #7,d1
                bne.s   loc_1CBB2
                subq.w  #1,(word_FFA014).w
loc_1CBB2:                              ; CODE XREF: Effect_ScreenShakeUpdate+52   j
                move.w  (word_FFA014).w,(word_FFA016).w
locret_1CBB8:                           ; CODE XREF: Effect_ScreenShakeUpdate+4   j
                rts
; End of function Effect_ScreenShakeUpdate
; Debug Y-axis camera adjustment
Camera_DebugAdjustY:
                btst    #4,(word_FFF706+1).w  ; was: sub_1CBBA
                beq.w   locret_1CBE0
                btst    #0,(word_FFF708+1).w
                beq.w   loc_1CBD2
                addq.w  #1,(word_FFA00E).w
loc_1CBD2:                              ; CODE XREF: Camera_DebugAdjustY+10   j
                btst    #1,(word_FFF708+1).w
                beq.w   locret_1CBE0
                subq.w  #1,(word_FFA00E).w
locret_1CBE0:                           ; CODE XREF: Camera_DebugAdjustY+6   j
                                        ; Camera_DebugAdjustY+1E   j
                rts
; End of function Camera_DebugAdjustY
; Debug XY camera adjustment
Camera_DebugAdjustXY:
                btst    #4,(word_FFF706+1).w  ; was: sub_1CBE2
                bne.w   locret_1CC2C
                btst    #0,(word_FFF708+1).w
                beq.w   loc_1CBFC
                subi.w  #$20,(word_FFA00C).w ; ' '
loc_1CBFC:                              ; CODE XREF: Camera_DebugAdjustXY+10   j
                btst    #1,(word_FFF708+1).w
                beq.w   loc_1CC0C
                addi.w  #$20,(word_FFA00C).w ; ' '
loc_1CC0C:                              ; CODE XREF: Camera_DebugAdjustXY+20   j
                btst    #2,(word_FFF708+1).w
                beq.w   loc_1CC1C
                subi.w  #$20,(word_FFA00A).w ; ' '
loc_1CC1C:                              ; CODE XREF: Camera_DebugAdjustXY+30   j
                btst    #3,(word_FFF708+1).w
                beq.w   locret_1CC2C
                addi.w  #$20,(word_FFA00A).w ; ' '
locret_1CC2C:                           ; CODE XREF: Camera_DebugAdjustXY+6   j
                                        ; Camera_DebugAdjustXY+40   j
                rts
; End of function Camera_DebugAdjustXY
; Process debug movement inputs
Input_ProcessDebugMovement:
                clr.l   (dword_FFA9D0).w  ; was: sub_1CC2E
                clr.l   (dword_FFA9D4).w
                btst    #0,(word_FFF706+1).w
                beq.w   loc_1CC46
                move.w  #$FFFF,(dword_FFA9D4).w
loc_1CC46:                              ; CODE XREF: Input_ProcessDebugMovement+E   j
                btst    #1,(word_FFF706+1).w
                beq.w   loc_1CC56
                move.w  #1,(dword_FFA9D4).w
loc_1CC56:                              ; CODE XREF: Input_ProcessDebugMovement+1E   j
                btst    #2,(word_FFF706+1).w
                beq.w   loc_1CC66
                move.w  #$FFFF,(dword_FFA9D0).w
loc_1CC66:                              ; CODE XREF: Input_ProcessDebugMovement+2E   j
                btst    #3,(word_FFF706+1).w
                beq.w   loc_1CC76
                move.w  #1,(dword_FFA9D0).w
loc_1CC76:                              ; CODE XREF: Input_ProcessDebugMovement+3E   j
                btst    #6,(word_FFF708+1).w
                beq.w   loc_1CC86
                move.w  #1,(word_FFA9C0).w
loc_1CC86:                              ; CODE XREF: Input_ProcessDebugMovement+4E   j
                btst    #4,(word_FFF708+1).w
                beq.w   locret_1CC96
                move.w  #1,(word_FFA980).w
locret_1CC96:                           ; CODE XREF: Input_ProcessDebugMovement+5E   j
                rts
; End of function Input_ProcessDebugMovement
; Display debug marker sprites
Sprite_DisplayDebugMarker:
                lea     word_1CCA4(pc),a0  ; was: sub_1CC98
                nop
                jmp (Sprite_AddToOAMBuffer).l
; End of function Sprite_DisplayDebugMarker
; ---------------------------------------------------------------------------
word_1CCA4:     dc.w $100, $F80, $4300, $100, $140, $F80, $8300, $140, $FFFF
                                        ; DATA XREF: Sprite_DisplayDebugMarker   o


; Copy object data to buffer
Object_CopyDataBlock:
                move.w  (word_FFA402).w,(word_FFA802).w  ; was: sub_1CCB6
                move.l  (dword_FFA408).w,(dword_FFA808).w
                move.w  (word_FFA40C).w,(word_FFA80C).w
                move.w  (word_FFA40E).w,(word_FFA80E).w
                move.w  #$120,(word_FFA810).w
                move.w  #$F0,(word_FFA814).w
                clr.w   (word_FFA812).w
                clr.w   (word_FFA816).w
                clr.l   (dword_FFA818).w
                clr.l   (dword_FFA81C).w
                rts
; End of function Object_CopyDataBlock
; Sets password confirmation flag and jumps to initialization
UI_SetPasswordConfirmFlag:                              ; CODE XREF: UI_HandlePasswordInput+284   j  ; was: sub_1CCEC
                bset    #0,(byte_FFA209).w
                bra.s   loc_1CD02
; End of function UI_SetPasswordConfirmFlag
; Initializes game state variables for menu/title screen
UI_InitializeGameVariables:                              ; CODE XREF: UI_HandleTitleInput+8A   p  ; was: sub_1CCF4
                                        ; UI_HandleTitleInput+BA   j ...
                clr.w   (StageTableIndex).w
                move.w  #2,(word_FFA22A).w
                clr.b   (byte_FFA209).w
loc_1CD02:                              ; CODE XREF: UI_SetPasswordConfirmFlag+6   j
                move.w  #$200,(word_FFA216).w
                move.w  #$200,(word_FFA218).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                move.w  #3,(word_FFA228).w
                clr.w   (word_FFFF40).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.w UI_InitializeScoreBuffer
                bra.s   loc_1CDB8
; End of function UI_InitializeGameVariables
; Initializes game state after continue, sets weapon ammo and clears menu flags
UI_InitGameStateFromContinue:                              ; CODE XREF: UI_TransitionFromContinue+28   j  ; was: sub_1CD3A
                                        ; UI_UpdatePasswordDisplay+12   j
                move.w  (word_FFA218).w,(word_FFA216).w
                tst.w   (word_FFFF0E).w
                beq.s   loc_1CD5A
                move.w  #$3E8,d0
                move.w  d0,(word_FFA268).w
                move.w  d0,(word_FFA26A).w
                move.w  d0,(word_FFA26C).w
                move.w  d0,(word_FFA26E).w
loc_1CD5A:                              ; CODE XREF: UI_InitGameStateFromContinue+A   j
                move.w  (word_FFA268).w,(word_FFA260).w
                move.w  (word_FFA26A).w,(word_FFA262).w
                move.w  (word_FFA26C).w,(word_FFA264).w
                move.w  (word_FFA26E).w,(word_FFA266).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (word_FFA21C).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.s UI_ResetMenuBufferAndState
                move.w  #$50,(word_FF80C2).w ; 'P'
                move.w  (StageTableIndex).w,d0
                asr.b   #1,d0
                move.b  byte_1CDCE(pc,d0.w),(dword_FF80C8).w
                rts
; End of function UI_InitGameStateFromContinue
; Clears password input flags and menu state variables
UI_ClearPasswordFlags:                              ; CODE XREF: Password_HandleInput+12   p  ; was: sub_1CDA8
                clr.w   (word_FF822A).w
                clr.w   (word_FFA21C).w
                clr.w   (word_FF8090).w
; End of function UI_ClearPasswordFlags
; Clears menu buffer at FFE300 and resets menu state to 4
UI_ResetMenuBufferAndState:                              ; CODE XREF: UI_InitGameStateFromContinue+58   p  ; was: sub_1CDB4
                bsr.w Enemy_UpdateBehavior
loc_1CDB8:                              ; CODE XREF: UI_UpdateOptionsScreen+12   j
                                        ; Sys_RunOptionsMenuLoop+12   j ...
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7 ; '?'
; Clears menu buffer at word_FFE300 with 64 iterations
UI_ClearMenuBuffer:                              ; CODE XREF: UI_ResetMenuBufferAndState+E   j  ; was: loc_1CDC0
                move.l  d0,(a0)+
                dbf d7,UI_ClearMenuBuffer
                move.w  #4,(word_FFFF2A).w
                rts
; End of function UI_ResetMenuBufferAndState
; ---------------------------------------------------------------------------
byte_1CDCE:     dc.b $18, $18, $18, $18, $18, $18, $18, $18, $18, $18
                                        ; DATA XREF: UI_InitGameStateFromContinue+66   r
                dc.b $18, $18, $18, $18, $18, $18, $18, $18, $18, 0
                dc.b $18, $18, $18, $18, $18, $18, $18, $18, $18, $18
                dc.b $18, $18, $18, $18, $18, $18, $18, $18


; Stores current weapon selection value to buffer
UI_StoreWeaponSelection:                              ; CODE XREF: Text_AdvancePhase+30   p  ; was: sub_1CDF4
                movea.w #(word_FFAA00-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (word_FFA270).w,(a0,d0.w)
                rts
; End of function UI_StoreWeaponSelection
; Store weapon selection to buffer
UI_StoreWeaponToBuffer:                              ; CODE XREF: Text_CompleteWithSound:loc_B0FE   p  ; was: sub_1CE04
                                        ; Boss_ZLeoDefeatedDelay+2E   j
                movea.w #(word_FFAA80-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (word_FFA270).w,(a0,d0.w)
                rts
; End of function UI_StoreWeaponToBuffer
; Increments score counter with maximum value check
UI_IncrementScoreCounter:                              ; CODE XREF: Results_UpdateAndDisplay+2A   p  ; was: sub_1CE14
                movea.w #(word_FFAB00-M68K_RAM),a0
                adda.w  (StageTableIndex).w,a0
                cmpi.w  #$3E7,(a0)
                bpl.s   locret_1CE24
                addq.w  #1,(a0)
locret_1CE24:                           ; CODE XREF: UI_IncrementScoreCounter+C   j
                rts
; End of function UI_IncrementScoreCounter
; Initializes score buffer with -1 values
UI_InitializeScoreBuffer:                              ; CODE XREF: UI_InitializeGameVariables+40   p  ; was: sub_1CE26
                movea.w #(word_FFAA00-M68K_RAM),a0
                move.w  #$FFFF,d0
                move.w  #$BF,d7
; Loop that fills score buffer with data
UI_InitScoreBufferLoop:                              ; CODE XREF: UI_InitializeScoreBuffer+E   j  ; was: loc_1CE32
                move.w  d0,(a0)+
                dbf d7,UI_InitScoreBufferLoop
                rts
; End of function UI_InitializeScoreBuffer
; Updates enemy AI behavior state
Enemy_UpdateBehavior:                              ; CODE XREF: Player_Initialize+4   p  ; was: sub_1CE3A
                                        ; sub_1CDB4   p
                lea     word_1CE4C(pc),a0
                nop
                move.w  (StageTableIndex).w,d0
                move.w  (a0,d0.w),(word_FFA270).w
                rts
; End of function Enemy_UpdateBehavior
; ---------------------------------------------------------------------------
word_1CE4C:     dc.w $200, $240, $300, $330, $330
                                        ; DATA XREF: Enemy_UpdateBehavior   o
                                        ; Results_InitializeDataDisplay+4E   o ...
                dc.w $210, $220, $300, $340, $300
                dc.w $320, $410, $200, $200, $240
                dc.w $340, $300, $400, $220, $950
                dc.w $200, $200, $410, $220, $555


; Sets up results screen graphics and memory state
UI_InitializeResultsScreen:                              ; DATA XREF: Sys_DispatchGameState+5A   o  ; was: sub_1CE7E
                tst.w   (GameSubstateIndex).w
                bne.s UI_LoadResultsPalette
                jsr (Sys_InitGameMode).l
                movea.l #stru_1CEFC,a0
                jsr     (LoadObjData).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (word_FFF7F4+1).w
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                rts
; ---------------------------------------------------------------------------
; Loads palette and data tables for results screen
UI_LoadResultsPalette:                              ; CODE XREF: UI_InitializeResultsScreen+4   j  ; was: loc_1CEB6
                move.w  #8,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #$F0,(word_FF8100).w
                move.w  #0,d0
                move.w  #0,d1
                jsr (Data_LoadPointerTable1).l
                move.w  #0,d0
                move.w  #0,d1
                jsr (Data_LoadPointerTable2).l
                movea.l #word_B988,a4
                jsr (Gfx_LoadMultiplePalettes).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                rts
; End of function UI_InitializeResultsScreen
; ---------------------------------------------------------------------------
stru_1CEFC:     dc.w 7                  ; field_0
                                        ; DATA XREF: UI_InitializeResultsScreen+C   o
                dc.l byte_18140E        ; field_2
                dc.w $C000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $E000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Main game loop update with object processing
Sys_UpdateGameLoop:                              ; DATA XREF: Sys_DispatchGameState+5E   o  ; was: sub_1CF16
                tst.w   (word_FFF720).w
                bmi.s   loc_1CF2E
                cmpi.w  #4,(GameSubstateIndex).w
                bcs.s   loc_1CF2E
                btst    #7,(word_FFF708).w
                bne.w   loc_1D3A8
loc_1CF2E:                              ; CODE XREF: Sys_UpdateGameLoop+4   j
                                        ; Sys_UpdateGameLoop+C   j
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w UI_DispatchMenuState
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                addq.w  #1,(word_FFA000).w
                rts
; End of function Sys_UpdateGameLoop
; Dispatches to menu state handler based on index
UI_DispatchMenuState:                              ; CODE XREF: Sys_UpdateGameLoop+30   p  ; was: sub_1CF62
                move.w  (GameSubstateIndex).w,d0
                movea.w off_1CF72(pc,d0.w),a0
                adda.l  #UI_InitializeSEGAScreen,a0
                jmp     (a0)
; End of function UI_DispatchMenuState
; ---------------------------------------------------------------------------
off_1CF72:      dc.w UI_InitializeSEGAScreen-UI_InitializeSEGAScreen
                                        ; DATA XREF: UI_DispatchMenuState+4   r
                dc.w UI_DispatchCutsceneState-UI_InitializeSEGAScreen
                dc.w UI_InitializeTitleScreen-UI_InitializeSEGAScreen
                dc.w UI_DispatchStoryState-UI_InitializeSEGAScreen
                dc.w Stage_InitializeTransition-UI_InitializeSEGAScreen
                dc.w Stage_SetupScrollPlanesThunk-UI_InitializeSEGAScreen
                dc.w Cutscene_InitializeScene-UI_InitializeSEGAScreen
                dc.w Cutscene_HandleScrollInput-UI_InitializeSEGAScreen


; Initializes SEGA logo screen with graphics and palettes
UI_InitializeSEGAScreen:                              ; DATA XREF: UI_DispatchMenuState+8   o  ; was: sub_1CF82
                                        ; ROM:off_1CF72   o ...
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Gfx_QueueVRAMCommand).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                movea.l #stru_A1B6,a0
                jsr     (LoadObjData).l
                movea.l #$FFFF2020,a0
                move.w  #$8000,d0
                move.w  #$FF00,d1
                move.w  #$BF,d7
                jsr (Gfx_UpdateTilemapIndices).l
                bsr.w Gfx_CopyPaletteLines
                lea     (dword_FF4000).l,a0
                move.w  #$7FF,d0
loc_1CFD0:                              ; CODE XREF: UI_InitializeSEGAScreen+58   j
                move.l  (a0),d1
                ori.l   #$E000E000,d1
                move.l  d1,(a0)+
                dbf     d0,loc_1CFD0
                lea     (dword_11336).l,a0
                move.w  #$600,d0
                move.w  #0,d1
                move.w  d0,(dword_FFA908).w
                move.w  d1,(dword_FFA90C).w
                jsr (Gfx_DirectVRAMTransfer).l
                lea     (M68K_RAM).l,a0
                moveq   #$FFFFFFFF,d0
                move.w  #$F,d1
loc_1D006:                              ; CODE XREF: UI_InitializeSEGAScreen+86   j
                move.l  d0,(a0)+
                dbf     d1,loc_1D006
                move.w  #$400,(word_FF00DC).l
                move.w  #$E8,(word_FF00D4).l
                move.w  #$120,(word_FF00D6).l
                move.w  #0,(word_FF00D8).l
                move.w  #2,(word_FF00DA).l
                move.l  #$40000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr (Cutscene_PlanetRotate).l
                jsr (Cutscene_PlanetScroll).l
                clr.w   (word_FF00EC).l
                clr.w   (word_FF0178).l
                move.b  #$87,d0
                jsr (Input_ProcessButtons).l
                addq.w  #2,(GameSubstateIndex).w
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                movea.l #word_E8000,a0
                movea.w #(byte_FFE3C0-M68K_RAM),a1
                moveq   #7,d7
loc_1D09E:                              ; CODE XREF: UI_InitializeSEGAScreen+11E   j
                move.l  (a0)+,(a1)+
                dbf     d7,loc_1D09E
                movea.w (word_FFF70C).w,a0
                move.w  #$82,-(a0)
                move.w  #$6000,-(a0)
                move.l  #sega_tiles,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+3).w,-(a0)
                move.b  #$95,-(a0)
                move.b  (dword_FF8040+2).w,-(a0)
                move.b  #$96,-(a0)
                move.b  (dword_FF8040+1).w,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  #$94039300,-(a0)
                move.w  a0,(word_FFF70C).w
                move    #$2300,sr
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$C200,$E(a0)
                clr.b   $20(a0)
                move.l  #word_E98B0,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E8,$14(a0)
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                rts
; End of function UI_InitializeSEGAScreen
; Copies two palette lines between RAM buffers
Gfx_CopyPaletteLines:                              ; CODE XREF: UI_InitializeSEGAScreen+40   p  ; was: sub_1D120
                lea     (word_FFE362).w,a0
                lea     (word_FFE302).w,a1
                lea     (word_FFE3E2).w,a2
                lea     (word_FFE382).w,a3
                move.w  #$E,d0
loc_1D134:                              ; CODE XREF: Gfx_CopyPaletteLines+18   j
                move.w  (a0)+,(a1)+
                move.w  (a2)+,(a3)+
                dbf     d0,loc_1D134
                rts
; End of function Gfx_CopyPaletteLines
; Dispatches cutscene state based on frame counter
UI_DispatchCutsceneState:                              ; DATA XREF: ROM:0001CF74   o  ; was: sub_1D13E
                move.w  (word_FF00EC).l,d0
                lea     off_1D14C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_DispatchCutsceneState
; ---------------------------------------------------------------------------
off_1D14C:      dc.w Effect_FadeOutPlanet-*        ; DATA XREF: UI_DispatchCutsceneState+6   o
                dc.w Sys_WaitForFrameDelay-*
                dc.w Effect_UpdatePlanetRotation-*


; Fades out planet graphic and transitions state
Effect_FadeOutPlanet:                              ; DATA XREF: ROM:off_1D14C   o  ; was: sub_1D152
                jsr (Cutscene_PlanetScroll).l
                jsr (Gfx_FadeOutPalette).l
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_1D3D8
                move.w  #$40,(word_FF8100).w ; '@'
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Effect_FadeOutPlanet
; Waits for frame delay timer to expire
Sys_WaitForFrameDelay:                              ; DATA XREF: ROM:0001D14E   o  ; was: sub_1D178
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForFrameDelay
; Updates planet rotation effect and checks completion
Effect_UpdatePlanetRotation:                              ; DATA XREF: ROM:0001D150   o  ; was: sub_1D188
                jsr (Cutscene_PlanetScroll).l
                jsr (Gfx_UpdateVDPRegistersWithMask).l
                tst.w   (word_FF00C6).l
                bpl.w   locret_1D3D8
                move.w  #$80,(word_FF8100).w
                addq.w  #2,(GameSubstateIndex).w
                rts
; End of function Effect_UpdatePlanetRotation
; Sets up title screen with palettes and graphics
UI_InitializeTitleScreen:                              ; DATA XREF: ROM:0001CF76   o  ; was: sub_1D1AA
                addq.w  #2,(GameSubstateIndex).w
                movea.l #dword_1D25E,a0
                movea.w #(word_FFE340-M68K_RAM),a1
                moveq   #7,d7
; Loads title screen data structures in loop
UI_LoadTitleData:                              ; CODE XREF: UI_InitializeTitleScreen+12   j  ; was: loc_1D1BA
                move.l  (a0)+,(a1)+
                dbf d7,UI_LoadTitleData
                movea.l #stru_1D254,a0
                jsr (Data_ProcessPointer).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$C200,$E(a0)
                clr.b   $20(a0)
                move.l  #word_E98C2,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E4,$14(a0)
                move.w  #$400,(word_FF00DC).l
                move.w  #$E8,(word_FF00D4).l
                move.w  #$120,(word_FF00D6).l
                move.w  #2,(word_FF00D8).l
                move.w  #1,(word_FF00DA).l
                move.l  #$40000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr (Cutscene_PlanetRotate).l
                jsr (Cutscene_PlanetScroll).l
                clr.w   (word_FF00EC).l
                rts
; End of function UI_InitializeTitleScreen
; ---------------------------------------------------------------------------
stru_1D254:     dc.w 7                  ; field_0
                                        ; DATA XREF: UI_InitializeTitleScreen+16   o
                dc.l tiles_ED4B4        ; field_2
                dc.w $A000              ; field_6
                dc.w $FFFF
dword_1D25E:    dc.l 0, $EEE0F00        ; DATA XREF: UI_InitializeTitleScreen+4   o
                dc.l 2, $E240602
                dc.l $AE0000, 0
                dc.l 0, 0


; Dispatches story screen state handler
UI_DispatchStoryState:                              ; DATA XREF: ROM:0001CF78   o  ; was: sub_1D27E
                move.w  (word_FF00EC).l,d0
                lea     off_1D28C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function UI_DispatchStoryState
; ---------------------------------------------------------------------------
off_1D28C:      dc.w Effect_FadeOutStoryScreen-*        ; DATA XREF: UI_DispatchStoryState+6   o
                dc.w Sys_WaitForStoryDelay-*
                dc.w UI_InitializeGameScreen-*
                dc.w Effect_FadeOutStoryScreen-*
                dc.w Sys_WaitForGameDelay-*
                dc.w Effect_UpdateGameRotation-*
                dc.w Sys_TransitionToStoryScreen-*


; Fades out story screen and transitions
Effect_FadeOutStoryScreen:                              ; DATA XREF: ROM:off_1D28C   o  ; was: sub_1D29A
                                        ; ROM:0001D292   o
                jsr (Cutscene_PlanetScroll).l
                jsr (Gfx_FadeOutPalette).l
                cmpi.w  #$40,(word_FF00C6).l ; '@'
                bne.w   locret_1D3D8
                move.w  #$40,(word_FF8100).w ; '@'
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Effect_FadeOutStoryScreen
; Waits for story screen delay timer
Sys_WaitForStoryDelay:                              ; DATA XREF: ROM:0001D28E   o  ; was: sub_1D2C0
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForStoryDelay
; Initializes game screen with DMA and rotation setup
UI_InitializeGameScreen:                              ; DATA XREF: ROM:0001D290   o  ; was: sub_1D2D0
                jsr (Cutscene_PlanetScroll).l
                jsr (Gfx_UpdateVDPRegistersWithMask).l
                tst.w   (word_FF00C6).l
                bpl.w   locret_1D3D8
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C000,2(a0)
                move.w  #$A000,$E(a0)
                clr.b   $20(a0)
                move.l  #word_1D5E0,8(a0)
                move.w  #$120,$10(a0)
                move.w  #$E8,$14(a0)
                move.w  #$400,(word_FF00DC).l
                move.w  #$E8,(word_FF00D4).l
                move.w  #$120,(word_FF00D6).l
                move.w  #1,(word_FF00D8).l
                move.w  #5,(word_FF00DA).l
                move.l  #$40000002,(dword_FF00C0).l
                move.w  #$F,(word_FF00C4).l
                move.w  #0,(word_FF00C8).l
                clr.w   (word_FF00C6).l
                jsr (Cutscene_PlanetRotate).l
                jsr (Cutscene_PlanetScroll).l
                addq.w  #2,(word_FF00EC).l
                rts
; End of function UI_InitializeGameScreen
; Waits for game screen delay timer
Sys_WaitForGameDelay:                              ; DATA XREF: ROM:0001D294   o  ; was: sub_1D36E
                subq.w  #1,(word_FF8100).w
                bne.w   locret_1D3D8
                addq.w  #2,(word_FF00EC).l
                rts
; End of function Sys_WaitForGameDelay
; Updates game rotation effect and checks state
Effect_UpdateGameRotation:                              ; DATA XREF: ROM:0001D296   o  ; was: sub_1D37E
                jsr (Cutscene_PlanetScroll).l
                jsr (Gfx_UpdateVDPRegistersWithMask).l
                tst.w   (word_FF00C6).l
                bpl.w   locret_1D3D8
                clr.w   (word_FFC622).w
                move.w  #6,(GameSubstateIndex).w
                move.w  #$C,(word_FF00EC).l
                rts
; ---------------------------------------------------------------------------
loc_1D3A8:                              ; CODE XREF: Sys_UpdateGameLoop+14   j
                cmpi.w  #6,(GameSubstateIndex).w
                bne.s   loc_1D3BC
                cmpi.w  #$C,(word_FF00EC).l
                beq.w   locret_1D3D8
loc_1D3BC:                              ; CODE XREF: Effect_UpdateGameRotation+30   j
                move.w  #$28,(GameModeIndex).w ; '('
                jmp     (loc_5102).l
; End of function Effect_UpdateGameRotation
; Clears boss data and transitions to story screen
Sys_TransitionToStoryScreen:                              ; DATA XREF: ROM:0001D298   o  ; was: sub_1D3C8
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #$24,(GameModeIndex).w ; '$'
                clr.w   (GameSubstateIndex).w
locret_1D3D8:                           ; CODE XREF: Effect_FadeOutPlanet+14   j
                                        ; Sys_WaitForFrameDelay+4   j ...
                rts
; End of function Sys_TransitionToStoryScreen
; Initializes stage transition
Stage_InitializeTransition:                              ; DATA XREF: ROM:0001CF7A   o  ; was: sub_1D3DA
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                movea.l #stru_1D420,a0
                jsr     (LoadObjData).l
                movea.l #word_B978,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$400,d0
                move.w  #0,d1
                jsr (Data_LoadPointerTable2).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_SetupScrollPlanes
; End of function Stage_InitializeTransition
; ---------------------------------------------------------------------------
stru_1D420:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitializeTransition+A   o
                dc.l byte_18140E        ; field_2
                dc.w $E000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $D000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184590        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_184688        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF


; Attributes: thunk
; Thunk to Gfx_SetupScrollPlanes
Stage_SetupScrollPlanesThunk:                              ; DATA XREF: ROM:0001CF7C   o  ; was: sub_1D44A
                jmp Gfx_SetupScrollPlanes
; End of function Stage_SetupScrollPlanesThunk
; Initializes cutscene with data loading
Cutscene_InitializeScene:                              ; DATA XREF: ROM:0001CF7E   o  ; was: sub_1D450
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                clr.b   (word_FFF7F2+1).w
                clr.b   (word_FFF7F4+1).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                movea.l #stru_1D492,a0
                jsr     (LoadObjData).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jsr (Gfx_DecompressCutsceneData).l
                jmp Gfx_SetupScrollPlanes
; End of function Cutscene_InitializeScene
; ---------------------------------------------------------------------------
stru_1D492:     dc.w 7                  ; field_0
                                        ; DATA XREF: Cutscene_InitializeScene+1A   o
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $C000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $E000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Handles input for cutscene scrolling
Cutscene_HandleScrollInput:                              ; DATA XREF: ROM:0001CF80   o  ; was: sub_1D4B4
                btst    #0,(word_FFF706).w
                beq.s   loc_1D4C4
                addi.l  #$1000,(dword_FF9408).w
loc_1D4C4:                              ; CODE XREF: Cutscene_HandleScrollInput+6   j
                btst    #1,(word_FFF706).w
                beq.s   loc_1D4D4
                subi.l  #$1000,(dword_FF9408).w
loc_1D4D4:                              ; CODE XREF: Cutscene_HandleScrollInput+16   j
                move.l  (dword_FF9408).w,d0
                cmpi.l  #$20000,d0
                bmi.s   loc_1D4E6
                move.l  #$20000,d0
loc_1D4E6:                              ; CODE XREF: Cutscene_HandleScrollInput+2A   j
                tst.l   d0
                bpl.s   loc_1D4F0
                move.l  #$20000,d0
loc_1D4F0:                              ; CODE XREF: Cutscene_HandleScrollInput+34   j
                move.l  d0,(dword_FF9408).w
                asr.l   #8,d0
                asr.w   #4,d0
                andi.w  #$C,d0
                move.l  Cutscene_UpdateAndSetupPlanes(pc,d0.w),(dword_FF9400).w
                jmp Gfx_LoadCutsceneFrame
; End of function Cutscene_HandleScrollInput
; Updates cutscene and scroll planes
Cutscene_UpdateAndSetupPlanes:                              ; DATA XREF: Cutscene_HandleScrollInput+48   r  ; was: sub_1D508
                bsr.w Cutscene_AnimateScroll
                jmp Gfx_SetupScrollPlanes
; End of function Cutscene_UpdateAndSetupPlanes
; Animates cutscene scrolling
Cutscene_AnimateScroll:                              ; CODE XREF: Cutscene_UpdateAndSetupPlanes   p  ; was: sub_1D512
                cmpi.w  #$E00,(dword_FFA900).w
                bmi.s   loc_1D520
                subi.w  #$D00,(dword_FFA900).w
loc_1D520:                              ; CODE XREF: Cutscene_AnimateScroll+6   j
                addi.l  #$10000,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                asr.w   #2,d0
                move.w  d0,(dword_FFA908).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$180,d0
                move.w  (dword_FFA904).w,d1
                jmp Gfx_RenderTilemap
; End of function Cutscene_AnimateScroll
; ---------------------------------------------------------------------------
unused_4:	binclude	"data/other/unused_4.bin"
word_1D5E0:     dc.w $316, $100, $B8, $32C, $100, $C4, $326, $100
                                        ; DATA XREF: UI_InitializeGameScreen+2E   o
                dc.w $D0, $31E, $100, $DC, $330, $100, $E8, $33A
                dc.w $100, 0, $332, $100, $C, $32C, $100, $18
                dc.w $31C, $100, $24, $326, $100, $30, $31E, $100
                dc.w $3C, $8338, $100, $48


; Initializes stage select screen with graphics setup
UI_InitializeStageSelect:                              ; DATA XREF: Sys_DispatchGameState+82   o  ; was: sub_1D628
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1D69C
                tst.w   (word_FFF720).w
                bpl.s   loc_1D636
                rts
; ---------------------------------------------------------------------------
loc_1D636:                              ; CODE XREF: UI_InitializeStageSelect+A   j
                jsr (Sys_InitGameMode).l
                movea.l #stru_1D70A,a0
                jsr     (LoadObjData).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bset    #1,(byte_FFA209).w
                movea.w #(word_FFFF42-M68K_RAM),a0
                movea.w #(word_FF804A-M68K_RAM),a1
                move.w  #1,(word_FF8048).w
                sub.w   d1,d1
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                bcc.s   loc_1D688
                move.w  #$9999,(word_FFFF40).w
loc_1D688:                              ; CODE XREF: UI_InitializeStageSelect+58   j
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_1D69C:                              ; CODE XREF: UI_InitializeStageSelect+4   j
                move.w  #$30,(GameModeIndex).w ; '0'
                clr.w   (GameSubstateIndex).w
                lea     (byte_BAF0).l,a0
                jsr     (LoadPalette).l
                jsr (Gfx_FadePaletteTransition).l
                clr.w   (word_FF8014).w
                move.w  #$FFF2,(word_FF8016).w
                bsr.w UI_FadePaletteColors
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FF00,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                move.w  #$FF00,(dword_FFA90C).w
                move.w  #$10,(dword_FFA908).w
                move.b  #4,(byte_FFA95B).w
                jsr (Gfx_SetupScrollPlanes).l
; Resets stage select variables and frame counter
UI_ResetStageSelectVars:                              ; CODE XREF: Stage_InitializeStageSelect+86   j  ; was: loc_1D6F4
                move.b  #3,(word_FFF7E6+1).w
                move.b  #0,(word_FFF7F4+1).w
                bsr.w Results_InitializeDisplay
                clr.w   (word_FFA000).w
                rts
; End of function UI_InitializeStageSelect
; ---------------------------------------------------------------------------
stru_1D70A:     dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitializeStageSelect+14   o
                                        ; Stage_InitializeStageSelect+C   o
                dc.l byte_18C72C        ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CC50        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CD7C        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Initializes stage select screen
Stage_InitializeStageSelect:                              ; DATA XREF: Sys_DispatchGameState+AA   o  ; was: sub_1D734
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1D778
                jsr (Sys_InitGameMode).l
                movea.l #stru_1D70A,a0
                jsr     (LoadObjData).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp VDP_SetupPaletteTransfer
; ---------------------------------------------------------------------------
loc_1D778:                              ; CODE XREF: Stage_InitializeStageSelect+4   j
                move.w  #$30,(GameModeIndex).w ; '0'
                move.w  #6,(GameSubstateIndex).w
                lea     (byte_BAF0).l,a0
                jsr     (LoadPalette).l
                jsr (Gfx_FadePaletteTransition).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                move.w  #$FF00,(dword_FFA90C).w
                move.w  #0,(dword_FFA908).w
                jsr (Gfx_SetupScrollPlanes).l
                move.w  #2,(dword_FF8066+2).w
                bra.w UI_ResetStageSelectVars
; End of function Stage_InitializeStageSelect
; Dispatches stage select state handler
UI_DispatchStageState:                              ; DATA XREF: Sys_DispatchGameState+86   o  ; was: sub_1D7BE
                move.w  (GameSubstateIndex).w,d0
                movea.w off_1D7CE(pc,d0.w),a0
                adda.l  #UI_UpdateStageScroll,a0
                jmp     (a0)
; End of function UI_DispatchStageState
; ---------------------------------------------------------------------------
off_1D7CE:      dc.w UI_UpdateStageScroll-UI_UpdateStageScroll
                                        ; DATA XREF: UI_DispatchStageState+4   r
                dc.w UI_HandleStageFadeOut-UI_UpdateStageScroll
                dc.w Results_UpdateAndDisplay-UI_UpdateStageScroll
                dc.w Results_HandleCompletion-UI_UpdateStageScroll
                dc.w Gfx_FadeOutResults-UI_UpdateStageScroll
                dc.w UI_InitializeContinueScreen-UI_UpdateStageScroll
                dc.w UI_UpdateContinueDisplay-UI_UpdateStageScroll
                dc.w UI_HandleContinueInput-UI_UpdateStageScroll
                dc.w UI_TransitionFromContinue-UI_UpdateStageScroll
                dc.w UI_HandleGameOverTransition-UI_UpdateStageScroll


; Updates stage select scroll position and checks input
UI_UpdateStageScroll:                              ; DATA XREF: UI_DispatchStageState+8   o  ; was: sub_1D7E2
                                        ; ROM:off_1D7CE   o ...
                addq.w  #1,(word_FFA000).w
                cmpi.w  #$20,(word_FFA000).w ; ' '
                beq.s   loc_1D7F6
                cmpi.w  #$24,(word_FFA000).w ; '$'
                bne.s   loc_1D800
loc_1D7F6:                              ; CODE XREF: UI_UpdateStageScroll+A   j
                move.b  #$1D,d0
                jsr (Input_ProcessButtons).l
loc_1D800:                              ; CODE XREF: UI_UpdateStageScroll+12   j
                cmpi.w  #$3C0,(dword_FFA900).w
                bmi.s   loc_1D86A
                addq.w  #2,(GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                bra.s   loc_1D86A
; End of function UI_UpdateStageScroll
; Handles fade out effect for stage transition
UI_HandleStageFadeOut:                              ; DATA XREF: ROM:0001D7D0   o  ; was: sub_1D81E
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1D86A
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (word_FFF7E6+1).w
                move.b  #$12,(word_FFF7F4+1).w
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jmp VDP_SetupDMA
; ---------------------------------------------------------------------------
loc_1D86A:                              ; CODE XREF: UI_UpdateStageScroll+24   j
                                        ; UI_UpdateStageScroll+3A   j ...
                jsr (Gfx_FadePaletteTransition).l
                jsr (Gfx_SetupScrollPlanes).l
                move.l  #$FFFF0000,d0
                bsr.w Gfx_CalculateParallaxScroll
                addq.w  #8,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$1C0,d0
                move.w  (dword_FFA904).w,d1
                jsr (Gfx_RenderTilemap).l
                addq.w  #4,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$1C0,d0
                move.w  (dword_FFA904).w,d1
                jmp Gfx_RenderTilemap
; End of function UI_HandleStageFadeOut
; Calculates parallax scrolling for background
Gfx_CalculateParallaxScroll:                              ; CODE XREF: UI_HandleStageFadeOut+5E   p  ; was: sub_1D8AC
                movea.w #(word_FFE400-M68K_RAM),a0
                move.l  (dword_FFA900).w,d1
                neg.l   d1
                move.w  #$6F,d7 ; 'o'
                move.l  d1,d2
                addi.l  #0,d2
                btst    #0,(word_FFA280+1).w
                bne.s   loc_1D8CC
                exg     d1,d2
loc_1D8CC:                              ; CODE XREF: Gfx_CalculateParallaxScroll+1C   j
                swap    d1
                swap    d2
loc_1D8D0:                              ; CODE XREF: Gfx_CalculateParallaxScroll+38   j
                move.w  d1,(a0)
                addq.w  #4,a0
                swap    d1
                add.l   d0,d1
                swap    d1
                move.w  d2,(a0)
                addq.w  #4,a0
                swap    d2
                add.l   d0,d2
                swap    d2
                dbf     d7,loc_1D8D0
                rts
; End of function Gfx_CalculateParallaxScroll
; Fades multiple palette color ranges
UI_FadePaletteColors:                              ; CODE XREF: UI_InitializeStageSelect+9A   p  ; was: sub_1D8EA
                movea.w #(word_FFE386-M68K_RAM),a1
                movea.w #(word_FFE306-M68K_RAM),a2
                moveq   #3,d5
loc_1D8F4:                              ; CODE XREF: UI_FadePaletteColors+20   j
                move.w  (a1)+,d6
                move.w  (word_FF8014).w,d0
                jsr (Gfx_PrepareRGBComponents).l
                moveq   #$FFFFFFFF,d0
                jsr (Gfx_AdjustPaletteBits).l
                move.w  d6,(a2)+
                dbf     d5,loc_1D8F4
                movea.w #(dword_FFE3A0+2-M68K_RAM),a1
                movea.w #(byte_FFE322-M68K_RAM),a2
                moveq   #4,d5
                bsr.s UI_FadePaletteRange
                movea.w #(dword_FFE3C2-M68K_RAM),a1
                movea.w #(word_FFE342-M68K_RAM),a2
                moveq   #4,d5
                bsr.s UI_FadePaletteRange
                movea.w #(word_FFE3E2-M68K_RAM),a1
                movea.w #(word_FFE362-M68K_RAM),a2
                moveq   #4,d5
; End of function UI_FadePaletteColors
; Fades single palette color range
UI_FadePaletteRange:                              ; CODE XREF: UI_FadePaletteColors+2E   p  ; was: sub_1D930
                                        ; UI_FadePaletteColors+3A   p ...
                move.w  (a1)+,d6
                move.w  (word_FF8016).w,d0
                jsr (Gfx_PrepareRGBComponents).l
                moveq   #$FFFFFFFF,d0
                jsr (Gfx_AdjustPaletteBits).l
                move.w  d6,(a2)+
                dbf d5,UI_FadePaletteRange
                rts
; End of function UI_FadePaletteRange
; Updates results display
UI_UpdateResultsDisplay:                              ; CODE XREF: UI_TransitionFromContinue   p  ; was: sub_1D94C
                btst    #1,(word_FFA280+1).w
                bne.s Results_UpdateTimeDisplay
                move.w  #$2302,d1
                bra.s   loc_1D95E
; End of function UI_UpdateResultsDisplay
; Updates time display on results screen
Results_UpdateTimeDisplay:                              ; CODE XREF: UI_UpdateResultsDisplay+6   j  ; was: sub_1D95A
                                        ; UI_UpdateContinueDisplay+C   p ...
                move.w  #$4302,d1
loc_1D95E:                              ; CODE XREF: UI_UpdateResultsDisplay+C   j
                tst.w   (word_FFFF0E).w
                bne.s   loc_1D966
                rts
; ---------------------------------------------------------------------------
loc_1D966:                              ; CODE XREF: Results_UpdateTimeDisplay+8   j
                moveq   #0,d0
                move.w  (word_FFA228).w,d0
                move.w  #$6B42,d4
                moveq   #2,d7
                jmp (Results_UpdateNumbers).l
; End of function Results_UpdateTimeDisplay
; Renders text headers for results screen
UI_RenderResultsHeaders:                              ; CODE XREF: UI_InitializeContinueScreen+90   j  ; was: sub_1D978
                lea     (byte_47B2).l,a0
                move.w  #$2300,d0
                move.w  #$6B34,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_4689).l,a0
                move.w  #$300,d0
                move.w  #$6B42,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderResultsHeaders
; Renders continue prompt text on screen
UI_RenderContinuePrompt:                              ; CODE XREF: UI_InitializeContinueScreen+4C   p  ; was: sub_1D9A0
                move.w  #$6300,d0
                movea.l #byte_4790,a0
                move.w  #$669E,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderContinuePrompt
; Displays current stage number on results
Results_DisplayStageNumber:                              ; CODE XREF: UI_HandleContinueInput+4   p  ; was: sub_1D9B4
                moveq   #0,d0
                move.w  (dword_FF8066+2).w,d0
                move.w  #$4302,d1
                move.w  #$66B0,d4
                moveq   #1,d7
                jsr (Results_UpdateNumbers).l
; End of function Results_DisplayStageNumber
; Renders score values and labels on results
Results_RenderScoreValues:                              ; CODE XREF: UI_InitializeContinueScreen+50   p  ; was: sub_1D9CA
                lea     (byte_47A1).l,a0
                move.w  #$2300,d0
                move.w  #$6B06,d4
                jsr (UI_RenderTextStringWrapped).l
                moveq   #0,d0
                move.w  (StageTableIndex).w,d0
                addq.w  #2,d0
                jsr (Math_LookupCosineValue).l
                move.w  #$4302,d1
                move.w  #$6B12,d4
                moveq   #2,d7
                jsr (Results_UpdateNumbers).l
                lea     (byte_4689).l,a0
                move.w  #$300,d0
                move.w  #$6B12,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_47BA).l,a0
                move.w  #$2300,d0
                move.w  #$6B1A,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_47C1).l,a0
                tst.w   (word_FFFF0E).w
                beq.s   loc_1DA36
                lea     (byte_47C6).l,a0
loc_1DA36:                              ; CODE XREF: Results_RenderScoreValues+64   j
                move.w  #$4300,d0
                move.w  #$6B26,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function Results_RenderScoreValues
; Renders continue text with stage name
UI_RenderContinueText:                              ; CODE XREF: UI_InitializeContinueScreen:loc_1DB24   j  ; was: sub_1DA44
                lea     (byte_47A8).l,a0
                move.w  #$2300,d0
                move.w  #$6B32,d4
                jsr (UI_RenderTextStringWrapped).l
                move.w  (StageTableIndex).w,d0
                asl.w   #2,d0
                addi.l  #word_A82A,d0
                moveq   #0,d1
                move.w  (word_FFFF0E).w,d1
                asl.w   #1,d1
                add.l   d1,d0
                movea.l d0,a0
                movea.w #(byte_FF9980-M68K_RAM),a1
                move.l  (a0),(a1)+
                move.l  (a0),(dword_FFFF3A).w
                move.b  #$FF,(a1)
                movea.w #(byte_FF9980-M68K_RAM),a0
                move.w  #$4300,d0
                move.w  #$6B44,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderContinueText
; Initializes continue screen with palettes and graphics
UI_InitializeContinueScreen:                              ; DATA XREF: ROM:0001D7D8   o  ; was: sub_1DA90
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                clr.l   (dword_FFA900).w
                clr.l   (dword_FFA904).w
                clr.l   (dword_FFA908).w
                clr.l   (dword_FFA90C).w
                tst.w   (word_FFA228).w
                bne.s   loc_1DABC
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DABC:                              ; CODE XREF: UI_InitializeContinueScreen+1E   j
                addq.w  #2,(GameSubstateIndex).w
                move.l  #$A0000,(dword_FF8066+2).w
                subi.l  #$200,(dword_FF8066+2).w
                lea     (word_B95A).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                bsr.w UI_RenderContinuePrompt
                bsr.w Results_RenderScoreValues
                move.w  #$4000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr (VDP_SetupDMA).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                tst.w   (word_FFFF0E).w
                beq.s   loc_1DB24
                bra.w UI_RenderResultsHeaders
; ---------------------------------------------------------------------------
loc_1DB24:                              ; CODE XREF: UI_InitializeContinueScreen+8E   j
                bra.w UI_RenderContinueText
; End of function UI_InitializeContinueScreen
; Updates continue screen display with fade effects
UI_UpdateContinueDisplay:                              ; DATA XREF: ROM:0001D7DA   o  ; was: sub_1DB28
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                bsr.w Results_UpdateTimeDisplay
                jsr (Gfx_SetupScrollPlanes).l
                jsr (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DB5A
                addq.w  #2,(GameSubstateIndex).w
                move.b  #$94,d0
                jsr (Sys_WaitVBlank).l
locret_1DB5A:                           ; CODE XREF: UI_UpdateContinueDisplay+22   j
                rts
; End of function UI_UpdateContinueDisplay
; Handles player input on continue screen
UI_HandleContinueInput:                              ; DATA XREF: ROM:0001D7DC   o  ; was: sub_1DB5C
                bsr.w Results_UpdateTimeDisplay
                bsr.w Results_DisplayStageNumber
                move.b  (word_FFF708).w,d0
                andi.b  #$70,d0 ; 'p'
                beq.s   loc_1DB80
                move.b  #$A2,d0
                jsr (Input_ProcessButtons).l
                subq.w  #1,(dword_FF8066+2).w
                bmi.s   loc_1DB8E
                bra.s   loc_1DBC0
; ---------------------------------------------------------------------------
loc_1DB80:                              ; CODE XREF: UI_HandleContinueInput+10   j
                move.w  (dword_FF8066+2).w,d0
                subi.l  #$200,(dword_FF8066+2).w
                bpl.s   loc_1DBB0
loc_1DB8E:                              ; CODE XREF: UI_HandleContinueInput+20   j
                addq.w  #4,(GameSubstateIndex).w
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                bra.w   loc_1DBFA
; ---------------------------------------------------------------------------
loc_1DBB0:                              ; CODE XREF: UI_HandleContinueInput+30   j
                cmp.w   (dword_FF8066+2).w,d0
                beq.s   loc_1DBC0
                move.b  #$A2,d0
                jsr (Input_ProcessButtons).l
loc_1DBC0:                              ; CODE XREF: UI_HandleContinueInput+22   j
                                        ; UI_HandleContinueInput+58   j
                btst    #7,(word_FFF708).w
                beq.s   loc_1DBFA
                addq.w  #2,(GameSubstateIndex).w
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                tst.w   (word_FFFF0E).w
                beq.s   loc_1DBFA
                sub.w   d0,d0
                move.b  (word_FFA228+1).w,d0
                moveq   #1,d1
                sbcd    d1,d0
                move.b  d0,(word_FFA228+1).w
loc_1DBFA:                              ; CODE XREF: UI_HandleContinueInput+50   j
                                        ; UI_HandleContinueInput+6A   j ...
                jsr (Gfx_FadePaletteTransition).l
                jmp Gfx_SetupScrollPlanes
; End of function UI_HandleContinueInput
; Transitions away from continue screen based on choice
UI_TransitionFromContinue:                              ; DATA XREF: ROM:0001D7DE   o  ; was: sub_1DC06
                bsr.w UI_UpdateResultsDisplay
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1DBFA
                tst.w   (word_FFFF0E).w
                beq.s   loc_1DC24
                move.w  #$3C,(GameModeIndex).w ; '<'
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DC24:                              ; CODE XREF: UI_TransitionFromContinue+10   j
                move.w  #$70,(GameModeIndex).w ; 'p'
                clr.w   (GameSubstateIndex).w
                jmp UI_InitGameStateFromContinue
; End of function UI_TransitionFromContinue
; Handles game over screen fade transition
UI_HandleGameOverTransition:                              ; DATA XREF: ROM:0001D7E0   o  ; was: sub_1DC34
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1DBFA
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function UI_HandleGameOverTransition
; Initializes results display by calling render functions
Results_InitializeDisplay:                              ; CODE XREF: UI_InitializeStageSelect+D8   p  ; was: sub_1DC4C
                bsr.w Results_RenderAllStats
                rts
; End of function Results_InitializeDisplay
; Updates results screen with score and time display
Results_UpdateAndDisplay:                              ; DATA XREF: ROM:0001D7D2   o  ; was: sub_1DC52
                move.w  #$50,(dword_FFA90C).w ; 'P'
                addq.w  #1,(word_FFA000).w
                bsr.w Results_DisplayTime
                bsr.w Results_DisplayScore
                jsr (Gfx_SetupScrollPlanes).l
                jsr (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DCB0
                addq.w  #2,(GameSubstateIndex).w
                jsr (UI_IncrementScoreCounter).l
                lea     stru_1DCB2(pc),a0
                nop
                jsr     (LoadObjData).l
                movea.l #$FFFF2020,a0
                move.w  #$4000,d0
                moveq   #$F,d7
                jsr (Gfx_AdjustTileIndices).l
                movea.l #byte_1DCC4,a0
                jsr (Gfx_LoadCompressedTiles).l
                clr.w   (dword_FFA908).w
locret_1DCB0:                           ; CODE XREF: Results_UpdateAndDisplay+24   j
                rts
; End of function Results_UpdateAndDisplay
; ---------------------------------------------------------------------------
stru_1DCB2:     dc.w 7                  ; field_0
                                        ; DATA XREF: Results_UpdateAndDisplay+30   o
                dc.l tiles_1850C6       ; field_2
                dc.w $2000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_185268        ; field_2
                dc.w $2020              ; field_6
                dc.w $FFFF
byte_1DCC4:     dc.b $69, 0, $20, 0, $F, 0, 1, 2, 3, 4
                                        ; DATA XREF: Results_UpdateAndDisplay+4E   o
                dc.b 5, 6, 7, 8, 9, $A, $B, $C, $D, $E
                dc.b $F, $10


; Handles results screen completion and button input
Results_HandleCompletion:                              ; DATA XREF: ROM:0001D7D4   o  ; was: sub_1DCDA
                addq.w  #1,(word_FFA000).w
                jsr (Results_CheckSkipButton).l
                bsr.w Results_DisplayTime
                bsr.w Results_DisplayScore
                jsr (Gfx_SetupScrollPlanes).l
                jsr (Gfx_FadePaletteTransition).l
                btst    #7,(word_FFF708).w
                beq.s   locret_1DD14
                addq.w  #2,(GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
locret_1DD14:                           ; CODE XREF: Results_HandleCompletion+24   j
                rts
; End of function Results_HandleCompletion
; Fades out results screen graphics
Gfx_FadeOutResults:                              ; DATA XREF: ROM:0001D7D6   o  ; was: sub_1DD16
                jsr (Gfx_FadePaletteTransition).l
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1DD2C
                addq.w  #2,(GameSubstateIndex).w
                clr.b   (word_FFF7F4+1).w
locret_1DD2C:                           ; CODE XREF: Gfx_FadeOutResults+C   j
                rts
; End of function Gfx_FadeOutResults
; Initializes results screen
Results_InitializeScreen:                              ; DATA XREF: Sys_DispatchGameState+DA   o  ; was: sub_1DD2E
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1DD8A
                addq.w  #2,(GameSubstateIndex).w
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                lea     stru_1DDC2(pc),a0
                nop
                jsr (Data_ProcessPointer).l
                clr.w   (dword_FF84A0).w
                clr.w   (dword_FF8500).w
                clr.w   (dword_FF8560).w
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
locret_1DD88:                           ; CODE XREF: Results_InitializeScreen+60   j
                rts
; ---------------------------------------------------------------------------
loc_1DD8A:                              ; CODE XREF: Results_InitializeScreen+4   j
                tst.w   (word_FFF720).w
                bmi.s   locret_1DD88
                addq.w  #4,(GameModeIndex).w
                move.w  #2,(GameSubstateIndex).w
                lea     (word_B96E).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                bsr.w Results_RenderAllStats
                move.b  #$12,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp (Gfx_FadePaletteTransition).l
; End of function Results_InitializeScreen
; ---------------------------------------------------------------------------
stru_1DDC2:     dc.w 7                  ; field_0
                                        ; DATA XREF: Results_InitializeScreen+2E   o
                dc.l byte_18140E        ; field_2
                dc.w $D000              ; field_6
                dc.w $FFFF


; Renders all statistics on results screen
Results_RenderAllStats:                              ; CODE XREF: Results_InitializeDisplay   p  ; was: sub_1DDCC
                                        ; Results_InitializeScreen+78   p
                move.l  (dword_FFA212).w,d0
                cmp.l   (dword_FFFF2C).w,d0
                bmi.s   loc_1DDE0
                move.l  d0,(dword_FFFF2C).w
                move.w  #$FFFF,(word_FFA270).w
loc_1DDE0:                              ; CODE XREF: Results_RenderAllStats+8   j
                bsr.w Results_DisplayTime
                bsr.w Results_DisplayScore
                bsr.w Results_DisplayContinues
                bsr.w Results_DisplayBonus
                lea     (byte_47FE).l,a0
                move.w  #$E300,d0
                move.w  #$5120,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4806).l,a0
                move.w  #$8300,d0
                move.w  #$528A,d4
                jsr (UI_RenderTextString).l
                lea     (byte_468C).l,a0
                move.w  #$A300,d0
                move.w  #$52AA,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4811).l,a0
                move.w  #$8300,d0
                move.w  #$538A,d4
                jsr (UI_RenderTextString).l
                lea     (byte_468C).l,a0
                move.w  #$A300,d0
                move.w  #$53AA,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4820).l,a0
                move.w  #$8300,d0
                move.w  #$558A,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4687).l,a0
                move.w  #$A300,d0
                move.w  #$55B8,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4832).l,a0
                move.w  #$8300,d0
                move.w  #$568A,d4
                jsr (UI_RenderTextString).l
                lea     (byte_4687).l,a0
                move.w  #$A300,d0
                move.w  #$56B8,d4
                jmp (UI_RenderTextString).l
; End of function Results_RenderAllStats
; Display completion time
Results_DisplayTime:                              ; CODE XREF: Results_UpdateAndDisplay+A   p  ; was: sub_1DEA4
                                        ; Results_HandleCompletion+A   p ...
                move.l  (dword_FFFF2C).w,d0
                move.w  #$C302,d1
                move.w  #$52AA,d4
                moveq   #8,d7
                cmpi.w  #$FFFF,(word_FFA270).w
                bne.s   loc_1DEC6
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1DEC6
                move.w  #$8302,d1
loc_1DEC6:                              ; CODE XREF: Results_DisplayTime+14   j
                                        ; Results_DisplayTime+1C   j
                jmp (Results_UpdateNumbers).l
; End of function Results_DisplayTime
; Display score value
Results_DisplayScore:                              ; CODE XREF: Results_UpdateAndDisplay+E   p  ; was: sub_1DECC
                                        ; Results_HandleCompletion+E   p ...
                move.l  (dword_FFA212).w,d0
                move.w  #$C302,d1
                move.w  #$53AA,d4
                moveq   #8,d7
                cmpi.w  #$FFFF,(word_FFA270).w
                bne.s   loc_1DEF2
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1DEF2
                move.w  #$8302,d1
                move.l  (dword_FFFF2C).w,d0
loc_1DEF2:                              ; CODE XREF: Results_DisplayScore+14   j
                                        ; Results_DisplayScore+1C   j
                jmp (Results_UpdateNumbers).l
; End of function Results_DisplayScore
; Displays stage bonus value
Results_DisplayStageBonus:
                moveq   #0,d0  ; was: sub_1DEF8
                move.w  (word_FFFF40).w,d0
                move.w  #$C302,d1
                move.w  #$5538,d4
                moveq   #4,d7
                jmp (Results_UpdateNumbers).l
; End of function Results_DisplayStageBonus
; Display continues used
Results_DisplayContinues:                              ; CODE XREF: Results_RenderAllStats+1C   p  ; was: sub_1DF0E
                moveq   #0,d0
                move.w  (word_FFFF42).w,d0
                move.w  #$C302,d1
                move.w  #$55B8,d4
                moveq   #4,d7
                jmp (Results_UpdateNumbers).l
; End of function Results_DisplayContinues
; Display bonus points
Results_DisplayBonus:                              ; CODE XREF: Results_RenderAllStats+20   p  ; was: sub_1DF24
                moveq   #0,d0
                move.w  (word_FFFF44).w,d0
                move.w  #$C302,d1
                move.w  #$56B8,d4
                moveq   #4,d7
                jmp (Results_UpdateNumbers).l
; End of function Results_DisplayBonus
; Main loop for results screen
Results_MainLoop:                              ; DATA XREF: Sys_DispatchGameState+DE   o  ; was: sub_1DF3A
                addq.w  #1,(word_FFA000).w
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1DF52
                jsr (Results_CheckSkipButton).l
                bsr.w Results_DisplayTime
                bsr.w Results_DisplayScore
loc_1DF52:                              ; CODE XREF: Results_MainLoop+8   j
                jsr (Gfx_SetupScrollPlanes).l
                jsr (Gfx_FadePaletteTransition).l
                cmpi.w  #2,(GameSubstateIndex).w
                bne.s   loc_1DF74
                bclr    #0,(word_FF80F4).w
                beq.s   locret_1DFB4
                clr.w   (GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1DF74:                              ; CODE XREF: Results_MainLoop+2A   j
                cmpi.w  #4,(GameSubstateIndex).w
                beq.s   loc_1DFA2
                btst    #7,(word_FFF708).w
                beq.s   locret_1DFB4
                tst.w   (GameSubstateIndex).w
                beq.s   loc_1DF90
                move.w  #4,(GameSubstateIndex).w
loc_1DF90:                              ; CODE XREF: Results_MainLoop+4E   j
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                rts
; ---------------------------------------------------------------------------
loc_1DFA2:                              ; CODE XREF: Results_MainLoop+40   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1DFB4
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_1DFB4:                           ; CODE XREF: Results_MainLoop+32   j
                                        ; Results_MainLoop+48   j ...
                rts
; End of function Results_MainLoop
; Initializes password entry screen with graphics
UI_InitializePasswordScreen:                              ; DATA XREF: Sys_DispatchGameState+92   o  ; was: sub_1DFB6
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Sys_InitGameMode).l
                jsr (Gfx_QueueFontDMATransfer).l
                jsr (Stage_DispatchObjectLoader).l
                movea.l #stru_1E012,a0
                jsr     (LoadObjData).l
                addq.w  #4,(GameModeIndex).w
                move.w  #$40,(GameSubstateIndex).w ; '@'
                jsr (Gfx_QueueFontDMATransfer).l
                lea     (byte_BAD2).l,a0
                jsr     (LoadPalette).l
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp Input_GetMappedButton
; End of function UI_InitializePasswordScreen
; ---------------------------------------------------------------------------
stru_1E012:     dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitializePasswordScreen+1C   o
                                        ; Password_HandleInput+18   o ...
                dc.l byte_18DA38        ; field_2
                dc.w $F680              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F276E        ; field_2
                dc.w $DE00              ; field_6
                dc.w $FFFF


; Updates password display with blinking cursor
UI_UpdatePasswordDisplay:                              ; DATA XREF: Sys_DispatchGameState+96   o  ; was: sub_1E024
                move.w  (GameSubstateIndex).w,d0
                subq.w  #1,d0
                bpl.s   loc_1E03C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp UI_InitGameStateFromContinue
; ---------------------------------------------------------------------------
loc_1E03C:                              ; CODE XREF: UI_UpdatePasswordDisplay+6   j
                move.w  d0,(GameSubstateIndex).w
                andi.w  #8,d0
                bne.s   loc_1E05A
                movea.l #byte_4660,a0
                move.w  #$C6A0,d0
                move.w  #$46A0,d4
                jmp (UI_RenderTextStringWrapped).l
; ---------------------------------------------------------------------------
loc_1E05A:                              ; CODE XREF: UI_UpdatePasswordDisplay+20   j
                movea.l #byte_4671,a0
                move.w  #$C6A0,d0
                move.w  #$46A0,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_UpdatePasswordDisplay
; Initializes password screen
Password_InitializeScreen:                              ; DATA XREF: Sys_DispatchGameState+AE   o  ; was: sub_1E06E
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1E0C4
                addq.w  #2,(GameSubstateIndex).w
                jsr (Sys_InitGameMode).l
                jsr (Stage_DispatchObjectLoader).l
                jsr (Sys_ClearBossDataBuffer).l
                lea     (byte_BAF0).l,a0
                jsr     (LoadPalette).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #0,(word_FFF7F4+1).w
                jmp Gfx_QueueVRAMCommand
; ---------------------------------------------------------------------------
loc_1E0C4:                              ; CODE XREF: Password_InitializeScreen+4   j
                addq.w  #4,(GameModeIndex).w
                jsr (Gfx_FadePaletteTransition).l
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                jsr (Gfx_SetupScrollPlanes).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                lea     (byte_47D1).l,a0
                move.w  #$C300,d0
                move.w  #$4198,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_47E6).l,a0
                move.w  #$C300,d0
                move.w  #$448A,d4
                jsr (UI_RenderTextStringWrapped).l
                lea     (byte_47F2).l,a0
                move.w  #$C300,d0
                move.w  #$4A9C,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function Password_InitializeScreen
; Handles password screen input
Password_HandleInput:                              ; DATA XREF: Sys_DispatchGameState+B2   o  ; was: sub_1E124
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1E14C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jsr (UI_ClearPasswordFlags).l
                lea     stru_1E012(pc),a0
                jsr     (LoadObjData).l
                jmp Input_GetMappedButton
; ---------------------------------------------------------------------------
loc_1E14C:                              ; CODE XREF: Password_HandleInput+6   j
                tst.w   (word_FF80F2).w
                bne.s   loc_1E164
                btst    #7,(word_FFF708).w
                beq.s   loc_1E164
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
loc_1E164:                              ; CODE XREF: Password_HandleInput+2C   j
                                        ; Password_HandleInput+34   j
                jsr (Gfx_FadePaletteTransition).l
                rts
; End of function Password_HandleInput
; Initializes credits screen
Credits_InitializeScreen:                              ; DATA XREF: Sys_DispatchGameState+B6   o  ; was: sub_1E16C
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1E1BE
                addq.w  #2,(GameSubstateIndex).w
                jsr (Sys_InitGameMode).l
                lea     stru_1E204(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (byte_BB72).l,a0
                jsr     (LoadPalette).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.b  #0,(word_FFF7F4+1).w
                rts
; ---------------------------------------------------------------------------
loc_1E1BE:                              ; CODE XREF: Credits_InitializeScreen+4   j
                addq.w  #4,(GameModeIndex).w
                jsr (Gfx_FadePaletteTransition).l
                movea.l #dword_1E236,a0
                move.w  #$800,d0
                move.w  #$FF00,d1
                jsr (Gfx_DirectVRAMTransfer).l
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA904).w
                jsr (Gfx_SetupScrollPlanes).l
                move.w  #0,(word_FF807A).w
                jsr (Effect_TransitionDispatcher).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                rts
; End of function Credits_InitializeScreen
; ---------------------------------------------------------------------------
stru_1E204:     dc.w 7                  ; field_0
                                        ; DATA XREF: Credits_InitializeScreen+10   o
                dc.l tiles_18B2FA       ; field_2
                dc.w $6000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18D562        ; field_2
                dc.w $E000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CC50        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18CD7C        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18454C        ; field_2
                dc.w $7000              ; field_6
                dc.w $FFFF
dword_1E236:    dc.l $FFFF7000, $FFFF6000, $FFFF4000, $4000
                                        ; DATA XREF: Credits_InitializeScreen+5C   o


; Updates credits palette effects
Credits_UpdateEffects:                              ; DATA XREF: Sys_DispatchGameState+BA   o  ; was: sub_1E246
                jsr (Gfx_FadePaletteTransition).l
                jsr (Effect_PaletteDispatcher).l
                rts
; End of function Credits_UpdateEffects
; Checks button input mode and branches to handler
Input_CheckButtonModeAndBranch:                              ; CODE XREF: UI_InitializeWeaponSelect+12   j  ; was: sub_1E254
                move.b  (byte_FFA230).w,d0
                beq.s   loc_1E260
                jsr (Input_CheckButtonMode).l
loc_1E260:                              ; CODE XREF: Input_CheckButtonModeAndBranch+4   j
                bra.w UI_TransitionToStageLoad
; End of function Input_CheckButtonModeAndBranch
; Initializes weapon selection screen
UI_InitializeWeaponSelect:                              ; DATA XREF: Sys_DispatchGameState+8A   o  ; was: sub_1E264
                tst.w   (GameSubstateIndex).w
                bne.s UI_WeaponSelectTransition
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                bra.w Input_CheckButtonModeAndBranch
; End of function UI_InitializeWeaponSelect
; Prepares weapon select graphics
UI_PrepareWeaponSelectGfx:
                bclr    #6,(word_FFF7D2+1).w  ; was: sub_1E27A
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                move.w  #$6000,(word_FF8146).w
                move.w  #$F,(word_FF8148).w
                move.w  #0,(word_FF814A).w
                lea     (stru_1E012).l,a0
                jmp (Data_ProcessPointer).l
; End of function UI_PrepareWeaponSelectGfx
; Handles weapon select transition
UI_WeaponSelectTransition:                              ; CODE XREF: UI_InitializeWeaponSelect+4   j  ; was: sub_1E2A6
                cmpi.w  #4,(GameSubstateIndex).w
                beq.s   loc_1E2C6
                tst.b   (word_FFF720).w
                bmi.w   locret_1E40A
                jsr (VDP_TransferFontTile).l
                bpl.w   locret_1E40A
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1E2C6:                              ; CODE XREF: UI_WeaponSelectTransition+6   j
                move.w  #$38,(GameModeIndex).w ; '8'
                clr.w   (GameSubstateIndex).w
                move.b  (byte_FFA230).w,d0
                beq.s   loc_1E2DC
                jsr (Input_CheckButtonMode).l
loc_1E2DC:                              ; CODE XREF: UI_WeaponSelectTransition+2E   j
                lea     off_1E334(pc),a0
                nop
                jsr (Gfx_LoadFourPalettes).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #0,(word_FFF7F4+1).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                bsr.w UI_RenderMenuText
                clr.w   (dword_FFA904).w
                clr.w   (dword_FFA900).w
                clr.w   (dword_FFA90C).w
                clr.w   (dword_FFA908).w
                jmp Gfx_SetupScrollPlanes
; End of function UI_WeaponSelectTransition
; ---------------------------------------------------------------------------
off_1E334:      dc.l dword_1E344        ; DATA XREF: UI_WeaponSelectTransition:loc_1E2DC   o
                dc.l dword_1E344
                dc.l dword_1E344
                dc.l dword_1E344
dword_1E344:    dc.l 0, $CAA0A88, $8660644, 0
                                        ; DATA XREF: ROM:off_1E334   o
                                        ; ROM:0001E338   o ...
                dc.l 0, $8660644, $4220000, 0


; Manages menu text and transition
UI_HandleMenuTextTransition:                              ; DATA XREF: Sys_DispatchGameState+8E   o  ; was: sub_1E364
                tst.b   (word_FFF720).w
                bmi.w   locret_1E3D4
                tst.w   (GameSubstateIndex).w
                beq.s   loc_1E38E
                btst    #7,(word_FFF708).w
                beq.s   loc_1E38E
                clr.w   (GameSubstateIndex).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
loc_1E38E:                              ; CODE XREF: UI_HandleMenuTextTransition+C   j
                                        ; UI_HandleMenuTextTransition+14   j
                move.l  (dword_FFA22C).w,d0
                beq.s   loc_1E3C2
                movea.l d0,a0
                moveq   #0,d4
                move.b  (a0)+,d4
                asl.w   #7,d4
                addi.w  #$400C,d4
                move.w  #$C300,d0
                jsr (UI_RenderTextStringWrapped).l
                asr.w   #1,d3
                addq.w  #2,d3
                ext.l   d3
                add.l   d3,(dword_FFA22C).w
                movea.l (dword_FFA22C).w,a0
                cmpi.b  #$FD,(a0)
                bne.s   loc_1E3C2
                clr.l   (dword_FFA22C).w
loc_1E3C2:                              ; CODE XREF: UI_HandleMenuTextTransition+2E   j
                                        ; UI_HandleMenuTextTransition+58   j
                jsr (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1E3D6
                addq.w  #2,(GameSubstateIndex).w
locret_1E3D4:                           ; CODE XREF: UI_HandleMenuTextTransition+4   j
                                        ; UI_HandleMenuTextTransition+78   j
                rts
; ---------------------------------------------------------------------------
loc_1E3D6:                              ; CODE XREF: UI_HandleMenuTextTransition+6A   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1E3D4
; Transitions from menu to stage loading
UI_TransitionToStageLoad:                              ; CODE XREF: Input_CheckButtonModeAndBranch:loc_1E260   j  ; was: loc_1E3DE
                                        ; Stage_HandleCreditsOrAdvance+32   j
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jsr (UI_UpdateWeaponSelection).l
                move.w  #$50,(word_FF80C2).w ; 'P'
                move.w  (StageTableIndex).w,d0
                asr.b   #1,d0
                move.b  byte_1E40C(pc,d0.w),(dword_FF80C8).w
                clr.b   (byte_FFA272).w
                jsr (Stage_DispatchObjectLoader).l
locret_1E40A:                           ; CODE XREF: UI_WeaponSelectTransition+C   j
                                        ; UI_WeaponSelectTransition+16   j
                rts
; End of function UI_HandleMenuTextTransition
; ---------------------------------------------------------------------------
byte_1E40C:     dc.b $18, 0, 0          ; DATA XREF: UI_HandleMenuTextTransition+96   r
                dc.b 0, $18, 0
                dc.b 0, $18, 0
                dc.b $18, 0, 0
                dc.b 0, $18, 0
                dc.b 0, 0, $18
                dc.b 0, 0, 0
                dc.b 0, 0, 0
                dc.b 0, 0, 0
                dc.b 0, 0, 0
                dc.b 0, 0, 0
                dc.b 0, 0, 0


; Renders static menu text
UI_RenderMenuText:                              ; CODE XREF: UI_WeaponSelectTransition+74   p  ; was: sub_1E430
                lea     (byte_47F2).l,a0
                move.w  #$C100,d0
                move.w  #$4B9E,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderMenuText
; ---------------------------------------------------------------------------
byte_1E444:     dc.b 3, $DA, 0, $58, $79, $42, $36, $3F, $34, $43, $39, 0, $3E, $3B, $42, $D8
                                        ; DATA XREF: Sys_UpdateGameplayLoop+7A   o
                dc.b $D8, $D8, 0, $DA, $FF, 6, $31, $4E, $D8, $30, $31, $3C, $6F, $36, 0, $9E ; text?
                dc.b $84, $AB, $3D, $31, $63, $5C, $3F, $40, $5D, $30, $6E, $44, $31, $DB, $DB, $FF
                dc.b 8, $61, $37, $30, $37, $4A, $6B, $32, $48, $91, $A6, $A3, $8B, $92, $AE, $A4
                dc.b $DA, $C2, $D8, $FF, $A, $DE, $7F, $94, $9D, $A4, $AD, $C5, $AB, $AE, $DF, $48
                dc.b 0, $67, $31, $3B, $5C, $54, $76, $37, $45, $FF, $C, $36, $78, $32, $4B, $43
                dc.b $35, $44, $3B, $4F, $5D, 0, $39, $67, $4E, $3C, $55, $D8, $D8, $D8, $FF, $F
                dc.b $36, $76, $41, $53, $48, $3E, $5C, $62, $31, $E2, 0, $59, $55, $3B, $42, $49
                dc.b $34, $38, $44, $31, $DB, $DB, $FF, $11, $3A, $30, $82, $80, $A3, $7F, $AB, $8D
                dc.b $A4, $B2, $C5, $DA, $DB, $DB, 0, $30, $6C, $56, $42, $39, $31, $DB, $DB, $FF
                dc.b $FD
byte_1E4E5:     dc.b 3, $DA, 0, $3B, $48, $6D, $5A, $55, $6D, $78, $32, $4E, 0, $58, $5D, $42
                                        ; DATA XREF: Stage_CheckTransitionReady+E   o
                                        ; Stage_PostXiTigerTransition+16   o ...
                dc.b $D8, $D8, $D8, 0, $DA, $FF, 6, $3F, $3F, $35, $31, $49, $D8, $9E, $84, $AB
                dc.b $39, $37, $3A, $31, $37, $32, $39, $32, $4C, $43, $FF, 8, $3E, $48, $BD, $8E
                dc.b $80, $E2, 0, $32, $41, $3C, $D9, $FF, $A, $82, $80, $A3, $7F, $AB, $8D, $A4
                dc.b $B2, $C5, $DA, $5D, $D8, $40, $35, $64, $31, $42, $31, $55, $3F, $51, $FF, $C
                dc.b $42, $36, $48, 0, $3F, $31, $3B, $78, $32, $DE, $AA, $AB, $B6, $BB, $DF, $5D
                dc.b $D8, $4A, $39, $32, $36, $6A, $FF, $E, $B3, $A2, $35, $57, $32, $79, $42, 0
                dc.b $98, $A2, $53, $3B, $31, $D9, $FF, $11, $DE, $A7, $A6, $81, $D8, $3E, $32, $49
                dc.b $31, $35, $47, $33, $DB, $DB, $DF, $FF, $13, $3E, $48, $43, $36, $D8, $84, $A5
                dc.b $48, $3D, $44, $35, $45, 0, $94, $BD, $31, $80, $8E, $9E, $5D, $D8, $D8, $D8
                dc.b $FF, $FD
byte_1E587:	binclude	"data/other/byte_1E587.bin"
byte_1E587_End:
byte_1E6C6:     dc.b 3, $DA, 0, $39, $32, $6B, $31, $40, $4E, $5C, $A0, $DA, $92, $A4, $48, 0
                                        ; DATA XREF: Stage_PostFlyingNeoTransition+E   o
                dc.b $A7, $BF, $81, 0, $DA, $FF, 6, $3A, $7A, $D8, $48, $39, $55, $49, 0, $7F
                dc.b $94, $9D, $A4, $AD, $C5, $AB, $AE, $48, $BA, $AB, $D8, $FF, 8, $AA, $AB, $B6
                dc.b $BB, $E2, 0, $3F, $34, $3C, $67, $38, $DB, $DB, $FF, $B, $63, $6B, $32, $3E
                dc.b $32, $63, $77, $32, $48, 0, $4A, $39, $32, $36, $48, 0, $32, $33, $49, $FF
                dc.b $D, $3A, $50, $31, $5D, $D8, $AA, $AB, $B6, $BB, $43, $82, $80, $A3, $7F, $AB
                dc.b $8D, $A4, $B2, $C5, $DA, $48, $FF, $F, $45, $53, $4F, $30, $31, $49, 0, $47
                dc.b $79, $36, $9F, $AB, $9F, $AB, $67, $DB, $DB, $FF, $12, $3B, $35, $3B, $D8, $3E
                dc.b $48, $32, $3B, $57, $35, $53, 0, $63, $76, $30, $37, $6A, $36, $78, $67, $31
                dc.b $44, $FF, $14, $84, $AF, $5D, $D8, $40, $35, $64, $36, $41, $41, $30, $79, $3F
                dc.b $D8, $D8, $D8, $FF, $FD, $FF


; Initializes stage transition fade
Sys_TransitionToStageInit:                              ; DATA XREF: Sys_DispatchGameState+BE   o  ; was: sub_1E76C
                tst.w   (GameSubstateIndex).w
                bne.s   loc_1E7A8
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                clr.b   (word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_WriteVDPCommand
; ---------------------------------------------------------------------------
loc_1E7A8:                              ; CODE XREF: Sys_TransitionToStageInit+4   j
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                bset    #0,(byte_FFA209).w
                moveq   #0,d0
                move.l  d0,(dword_FF8128).w
                move.l  d0,(dword_FF812C).w
                move.l  d0,(dword_FF8130).w
                move.l  d0,(dword_FF8134).w
                bsr.w Cutscene_DispatchInit
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp (Gfx_FadePaletteTransition).l
; End of function Sys_TransitionToStageInit
; Updates stage transition
Sys_StageTransitionUpdate:                              ; DATA XREF: Sys_DispatchGameState+C2   o  ; was: sub_1E7DE
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w Cutscene_DispatchUpdate
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jsr (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1E824
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1E824:                              ; CODE XREF: Sys_StageTransitionUpdate+3E   j
                bclr    #1,(word_FF80F4).w
                beq.s   locret_1E83C
                move.w  #$C,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                jmp Stage_DispatchObjectLoader
; ---------------------------------------------------------------------------
locret_1E83C:                           ; CODE XREF: Sys_StageTransitionUpdate+4C   j
                rts
; End of function Sys_StageTransitionUpdate
; Dispatcher for cutscene init
Cutscene_DispatchInit:                              ; CODE XREF: Sys_TransitionToStageInit+5C   p  ; was: sub_1E83E
                move.w  (word_FFA29C).w,d0
                movea.w off_1E84E(pc,d0.w),a0
                adda.l  #Cutscene_DispatchUpdate,a0
                jmp     (a0)
; End of function Cutscene_DispatchInit
; ---------------------------------------------------------------------------
off_1E84E:      dc.w Cutscene_LoadInitialAssets-Cutscene_DispatchUpdate
                                        ; DATA XREF: Cutscene_DispatchInit+4   r
                dc.w Stage_InitPlayerAndScroll-Cutscene_DispatchUpdate
                dc.w Stage_TransitionToCredits-Cutscene_DispatchUpdate


; Dispatcher for cutscene update
Cutscene_DispatchUpdate:                              ; CODE XREF: Sys_StageTransitionUpdate+18   p  ; was: sub_1E854
                                        ; DATA XREF: Cutscene_DispatchInit+8   o ...
                move.w  (word_FFA29C).w,d0
                movea.w off_1E864(pc,d0.w),a0
                adda.l  #Cutscene_LoadInitialAssets,a0
                jmp     (a0)
; End of function Cutscene_DispatchUpdate
; ---------------------------------------------------------------------------
off_1E864:      dc.w Cutscene_UpdatePhysicsAndHUD-Cutscene_LoadInitialAssets
                                        ; DATA XREF: Cutscene_DispatchUpdate+4   r
                dc.w Stage_UpdateGameplay-Cutscene_LoadInitialAssets
                dc.w Stage_HandleCreditsOrAdvance-Cutscene_LoadInitialAssets


; Loads palette and graphics
Cutscene_LoadInitialAssets:                              ; DATA XREF: ROM:off_1E84E   o  ; was: sub_1E86A
                                        ; Cutscene_DispatchUpdate+8   o ...
                lea     stru_1E8A4(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (word_B9A0).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  (word_FFA216).w,(word_FF820A).w
                move.w  #$7000,d0
                move.w  d0,(word_FF8206).w
                move.w  d0,(word_FF8200).w
                move.w  d0,(word_FF8202).w
                bset    #0,(byte_FFA272).w
                jmp Gfx_DecompressCutsceneData
; End of function Cutscene_LoadInitialAssets
; ---------------------------------------------------------------------------
stru_1E8A4:     dc.w 7                  ; field_0
                                        ; DATA XREF: Cutscene_LoadInitialAssets   o
                dc.l tiles_1198E4       ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_11A644        ; field_2
                dc.w $4000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_11A61A        ; field_2
                dc.w $6000              ; field_6
                dc.w 3                  ; field_0
                dc.l byte_18BE42        ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18C634        ; field_2
                dc.w $2020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18C5E6        ; field_2
                dc.w $6800              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_19BA44        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18DF92        ; field_2
                dc.w $D000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_1195BA       ; field_2
                dc.w $7800              ; field_6
                dc.w $FFFF


; Updates physics and HUD
Cutscene_UpdatePhysicsAndHUD:                              ; DATA XREF: ROM:off_1E864   o  ; was: sub_1E8F6
                jsr (Physics_ApplyFriction).l
                jsr (UI_RenderHUDElement1).l
                move.w  (dword_FF8128).w,d0
                movea.w off_1E912(pc,d0.w),a0
                adda.l  #Cutscene_XiTigerSetup,a0
                jmp     (a0)
; End of function Cutscene_UpdatePhysicsAndHUD
; ---------------------------------------------------------------------------
off_1E912:      dc.w Cutscene_XiTigerSetup-Cutscene_XiTigerSetup
                                        ; DATA XREF: Cutscene_UpdatePhysicsAndHUD+10   r
                dc.w Cutscene_XiTigerWaitComplete-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerScrollUpdate-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerScrollSetup-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerScrollFadeIn-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerScrollFadeIn_CheckInput-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerFlashEffect-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerFadeOutAlt-Cutscene_XiTigerSetup
                dc.w Cutscene_XiTigerFinish-Cutscene_XiTigerSetup


; Sets up Xi Tiger cutscene
Cutscene_XiTigerSetup:                              ; DATA XREF: Cutscene_UpdatePhysicsAndHUD+14   o  ; was: sub_1E924
                                        ; ROM:off_1E912   o ...
                addq.w  #2,(dword_FF8128).w
                move.l  #$20000,(dword_FF812C).w
                move.w  #$100,(dword_FF8130).w
                move.b  #$1E,d0
                jsr (Sound_PlaySFX).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                bsr.w Cutscene_XiTigerInit
                lea     $60(a0),a0
                bsr.w Cutscene_XiTigerInit
                bset    #3,$E(a0)
                move.w  #0,(dword_FFA900).w
                move.w  #$28,(dword_FFA908).w ; '('
                lea     dword_1E97A(pc),a0
                nop
                jsr (Gfx_DMATransferTiles).l
                lea     dword_1E986(pc),a0
                nop
                jmp Gfx_LoadCompressedTiles
; End of function Cutscene_XiTigerSetup
; ---------------------------------------------------------------------------
dword_1E97A:    dc.l $44214000, $1020203, $B0C090A
                                        ; DATA XREF: Cutscene_XiTigerSetup+3E   o
dword_1E986:    dc.l $68204000, $4010405, $607080D, $E0F1011
                                        ; DATA XREF: Cutscene_XiTigerSetup+4A   o


; Initializes Xi-Tiger cutscene with graphics
Cutscene_XiTigerInit:                              ; CODE XREF: Cutscene_XiTigerSetup+20   p  ; was: sub_1E996
                                        ; Cutscene_XiTigerSetup+28   p
                move.w  #$10,(a0)
                move.w  #$CC00,2(a0)
                move.w  #$E3C0,$E(a0)
                move.l  #word_1198D2,8(a0)
locret_1E9AE:                           ; CODE XREF: Cutscene_XiTigerScrollSetup+4   j
                                        ; Cutscene_XiTigerSkipCheck+6   j ...
                rts
; End of function Cutscene_XiTigerInit
; Updates scroll position and fade during Xi Tiger cutscene
Cutscene_XiTigerScrollUpdate:                              ; DATA XREF: ROM:0001E916   o  ; was: sub_1E9B0
                subi.l  #$1800,(dword_FF9F08).w
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_1E9D2
                addq.w  #2,(dword_FF8130+2).w
                cmpi.w  #$E,(dword_FF8130+2).w
                bmi.s   loc_1E9D2
                addq.w  #2,(dword_FF8128).w
loc_1E9D2:                              ; CODE XREF: Cutscene_XiTigerScrollUpdate+10   j
                                        ; Cutscene_XiTigerScrollUpdate+1C   j
                bsr.w Cutscene_XiTigerApplyFade
                bra.s   loc_1EA14
; End of function Cutscene_XiTigerScrollUpdate
; Waits and shows Xi Tiger
Cutscene_XiTigerWaitComplete:                              ; DATA XREF: ROM:0001E914   o  ; was: sub_1E9D8
                subq.w  #1,(dword_FF8130).w
                bpl.s   loc_1E9FA
                move.b  #$A5,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$50,(dword_FF8130).w ; 'P'
                clr.w   (Entity_ObjectPool).w
                clr.w   (word_FFC680).w
loc_1E9FA:                              ; CODE XREF: Cutscene_XiTigerWaitComplete+4   j
                bsr.w Cutscene_XiTigerComplete
                move.w  (dword_FF8128+2).w,d0
                cmpi.w  #$200,d0
                bmi.s   loc_1EA14
                andi.w  #$F,d0
                bne.s   loc_1EA14
                moveq   #$E,d7
                bsr.w Cutscene_XiTigerWaitForInput
loc_1EA14:                              ; CODE XREF: Cutscene_XiTigerScrollUpdate+26   j
                                        ; Cutscene_XiTigerWaitComplete+2E   j ...
                bsr.w Cutscene_XiTigerProcessCommands
                bsr.w Cutscene_XiTigerFrameUpdate
                jmp Gfx_LoadCutsceneFrame
; End of function Cutscene_XiTigerWaitComplete
; Sets up Xi Tiger scroll
Cutscene_XiTigerScrollSetup:                              ; DATA XREF: ROM:0001E918   o  ; was: sub_1EA22
                subq.w  #1,(dword_FF8130).w
                bpl.w   locret_1E9AE
                move.b  #$82,d0
                jsr (Sys_WaitVBlank).l
                addq.w  #2,(dword_FF8128).w
                clr.w   (word_FFE3BA).w
                clr.w   (word_FFE3BC).w
                clr.w   (dword_FF8128+2).w
                move.l  #$1820000,(dword_FF812C).w
                clr.w   (dword_FF8130).w
                move.w  #$FFE0,(dword_FF8134+2).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #7,(word_FFF7E6+1).w
                move.b  #6,(byte_FFA95A).w
                move.b  #9,(byte_FFA95B).w
                move.w  #0,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  #0,(dword_FFA908).w
                move.w  #0,(dword_FFA90C).w
                jsr (Scroll_GetForegroundPosition).l
                move.w  #$1E0,(dword_FFA900).w
                jmp Scroll_GetBackgroundPosition
; End of function Cutscene_XiTigerScrollSetup
; Scrolls and fades in Xi Tiger
Cutscene_XiTigerScrollFadeIn:                              ; DATA XREF: ROM:0001E91A   o  ; was: sub_1EA9A
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s Cutscene_XiTigerScrollFadeIn_CheckInput
                subq.w  #2,(dword_FF8130+2).w
                bne.s Cutscene_XiTigerScrollFadeIn_CheckInput
                addq.w  #2,(dword_FF8128).w
; Checks input flag bit 0 and updates scroll counters during cutscene
Cutscene_XiTigerScrollFadeIn_CheckInput:                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+8   j  ; was: loc_1EAAE
                                        ; Cutscene_XiTigerScrollFadeIn+E   j
                                        ; DATA XREF: ...
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1EAC0
                addq.w  #1,(dword_FF8134+2).w
                bmi.s   loc_1EAC0
                clr.w   (dword_FF8134+2).w
loc_1EAC0:                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+1A   j
                                        ; Cutscene_XiTigerScrollFadeIn+20   j
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$C0,(dword_FF8128+2).w
                bne.s   loc_1EAEE
                move.b  #$11,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$48,(word_FFE3BA).w ; 'H'
                move.w  #$2AE,(word_FFE3BC).w
                move.w  #$C,(dword_FF8130+2).w
                bra.s Cutscene_XiTigerFlashEffect
; ---------------------------------------------------------------------------
loc_1EAEE:                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+30   j
                bsr.w Cutscene_XiTigerUpdateScroll
                bsr.w Cutscene_XiTigerApplyFade
                bra.w Cutscene_XiTigerFrameUpdate
; End of function Cutscene_XiTigerScrollFadeIn
; Applies Xi Tiger flash effect
Cutscene_XiTigerFlashEffect:                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+52   j  ; was: sub_1EAFA
                                        ; DATA XREF: ROM:0001E91E   o
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$160,(dword_FF8128+2).w
                bne.s   loc_1EB0C
                addq.w  #2,(dword_FF8128).w
                bra.s Cutscene_XiTigerFadeOutAlt
; ---------------------------------------------------------------------------
loc_1EB0C:                              ; CODE XREF: Cutscene_XiTigerFlashEffect+A   j
                subq.w  #1,(dword_FF8130+2).w
                bpl.s   loc_1EB16
                clr.w   (dword_FF8130+2).w
loc_1EB16:                              ; CODE XREF: Cutscene_XiTigerFlashEffect+16   j
                movea.w #(byte_FFE322-M68K_RAM),a0
                move.w  #$8000,d7
                moveq   #$E,d5
                bsr.w   loc_1EC2A
                bsr.w Cutscene_XiTigerUpdateScroll
                bra.w Cutscene_XiTigerFrameUpdate
; End of function Cutscene_XiTigerFlashEffect
; Fades out Xi Tiger cutscene
Cutscene_XiTigerFadeOutAlt:                              ; CODE XREF: Cutscene_XiTigerFlashEffect+10   j  ; was: sub_1EB2C
                                        ; DATA XREF: ROM:0001E920   o
                subq.w  #2,(dword_FF8134+2).w
                addq.w  #1,(dword_FF8130+2).w
                cmpi.w  #$10,(dword_FF8130+2).w
                bne.s   loc_1EB42
                addq.w  #2,(dword_FF8128).w
                rts
; ---------------------------------------------------------------------------
loc_1EB42:                              ; CODE XREF: Cutscene_XiTigerFadeOutAlt+E   j
                bsr.w Cutscene_XiTigerUpdateScroll
                bsr.w Cutscene_XiTigerFrameUpdate
                bra.w Cutscene_XiTigerApplyFade
; End of function Cutscene_XiTigerFadeOutAlt
; Completes Xi Tiger cutscene
Cutscene_XiTigerFinish:                              ; DATA XREF: ROM:0001E922   o  ; was: sub_1EB4E
                jsr (Stage_DispatchObjectLoader).l
                move.w  #$80,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #0,(word_FF814C).w
                rts
; End of function Cutscene_XiTigerFinish
; Updates cutscene frame with timing
Cutscene_XiTigerFrameUpdate:                              ; CODE XREF: Cutscene_XiTigerWaitComplete+40   p  ; was: sub_1EB66
                                        ; Cutscene_XiTigerScrollFadeIn+5C   j ...
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$C3DC,d0
                move.w  #$F00,d1
                move.w  #$A0,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s Cutscene_XiTigerLoadFrame
                move.w  #$140,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s Cutscene_XiTigerLoadFrame
                move.w  #$160,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s Cutscene_XiTigerLoadFrame
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp (Sprite_AddToOAMBuffer).l
; End of function Cutscene_XiTigerFrameUpdate
; Loads cutscene frame data to VRAM
Cutscene_XiTigerLoadFrame:                              ; CODE XREF: Cutscene_XiTigerFrameUpdate+14   p  ; was: sub_1EB9E
                                        ; Cutscene_XiTigerFrameUpdate+1E   p ...
                move.w  #$80,d2
                moveq   #9,d7
loc_1EBA4:                              ; CODE XREF: Cutscene_XiTigerLoadFrame+12   j
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d0,(a0)+
                move.w  d2,(a0)+
                addi.w  #$20,d2 ; ' '
                dbf     d7,loc_1EBA4
                rts
; End of function Cutscene_XiTigerLoadFrame
; Processes cutscene command sequence
Cutscene_XiTigerProcessCommands:                              ; CODE XREF: Cutscene_XiTigerWaitComplete:loc_1EA14   p  ; was: sub_1EBB6
                addi.l  #$800,(dword_FF812C).w
                move.w  (dword_FF812C).w,d0
                add.w   d0,(dword_FF8128+2).w
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                movea.w #(word_FFC680-M68K_RAM),a1
                move.w  (dword_FF8128+2).w,d0
                andi.w  #$3F,d0 ; '?'
                cmpi.w  #$20,d0 ; ' '
                bmi.s   loc_1EBE4
                subi.w  #$20,d0 ; ' '
                eori.w  #$1F,d0
loc_1EBE4:                              ; CODE XREF: Cutscene_XiTigerProcessCommands+24   j
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                addi.w  #$133,d0
                move.w  d0,$14(a0)
                move.w  d0,$14(a1)
                asr.w   #1,d2
                move.w  #$14E,d0
                add.w   d2,d0
                move.w  d0,$10(a0)
                move.w  #$F2,d0
                sub.w   d2,d0
                move.w  d0,$10(a1)
                asr.w   #1,d1
                addq.w  #1,d1
                move.w  d1,(dword_FFA90C).w
                asr.w   #1,d1
                subi.w  #$18,d1
                move.w  d1,(word_FF9F14).w
                rts
; End of function Cutscene_XiTigerProcessCommands
; Applies palette fade effect to cutscene
Cutscene_XiTigerApplyFade:                              ; CODE XREF: Cutscene_XiTigerScrollUpdate:loc_1E9D2   p  ; was: sub_1EC20
                                        ; Cutscene_XiTigerScrollFadeIn+58   p ...
                movea.w #(word_FFE300-M68K_RAM),a0
                move.w  #$E000,d7
                moveq   #$3F,d5 ; '?'
loc_1EC2A:                              ; CODE XREF: Cutscene_XiTigerFlashEffect+26   p
                move.w  (dword_FF8130+2).w,d0
                jmp (Gfx_ApplyPaletteFade).l
; End of function Cutscene_XiTigerApplyFade
; Updates scroll with wave distortion effect
Cutscene_XiTigerUpdateScroll:                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn:loc_1EAEE   p  ; was: sub_1EC34
                                        ; Cutscene_XiTigerFlashEffect+2A   p ...
                movea.w #(word_FFE402-M68K_RAM),a0
                lea     (word_1B494).l,a1
                moveq   #0,d0
                addi.w  #$108,(dword_FF8134).w
                move.w  (dword_FF8134).w,d0
                move.l  #$1814000,d3
                move.w  #$DF,d7
loc_1EC54:                              ; CODE XREF: Cutscene_XiTigerUpdateScroll+3A   j
                move.w  d0,d2
                andi.w  #$1FE,d2
                move.w  (a1,d2.w),d1
                ext.l   d1
                asl.l   #8,d1
                swap    d1
                move.w  d1,(a0)
                swap    d0
                add.l   d3,d0
                swap    d0
                addq.w  #4,a0
                dbf     d7,loc_1EC54
                subq.w  #4,(dword_FFA90C).w
                move.w  (dword_FF8134+2).w,d7
                asr.w   #1,d7
                addq.w  #1,(dword_FF8130).w
                move.w  (dword_FF8130).w,d0
                andi.w  #$3F,d0 ; '?'
                btst    #6,(dword_FF8130+1).w
                beq.s   loc_1ECA0
                eori.w  #$3F,d0 ; '?'
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1ECA0
                addq.w  #1,(dword_FF8130).w
loc_1ECA0:                              ; CODE XREF: Cutscene_XiTigerUpdateScroll+5A   j
                                        ; Cutscene_XiTigerUpdateScroll+66   j
                subi.w  #$20,d0 ; ' '
                ext.l   d0
                asl.l   #8,d0
                asl.l   #5,d0
                move.l  #$FFF80000,d1
                sub.l   d0,d1
                move.l  d1,d2
                swap    d2
                sub.w   d7,d2
                move.w  d2,(word_FFEC18).w
                move.w  d2,(word_FFEC34).w
                sub.l   d0,d1
                swap    d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC14).w
                move.w  d1,(word_FFEC10).w
                move.w  d1,(word_FFEC0C).w
                move.w  d1,(word_FFEC08).w
                move.w  d1,(word_FFEC38).w
                move.w  d1,(word_FFEC3C).w
                move.w  d1,(word_FFEC40).w
                move.w  d1,(word_FFEC44).w
                moveq   #$FFFFFFF6,d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC1C).w
                move.w  d1,(word_FFEC30).w
                moveq   #$FFFFFFF4,d1
                swap    d0
                add.w   d0,d1
                sub.w   d7,d1
                move.w  d1,(word_FFEC20).w
                move.w  d1,(word_FFEC24).w
                move.w  d1,(word_FFEC28).w
                move.w  d1,(word_FFEC2C).w
                move.w  (word_FFA000).w,d0
                andi.w  #2,d0
                asl.w   #2,d0
                move.w  word_1ED28(pc,d0.w),(word_FFE326).w
                move.w  word_1ED28+2(pc,d0.w),(word_FFE328).w
                move.w  word_1ED28+4(pc,d0.w),(word_FFE324).w
                rts
; End of function Cutscene_XiTigerUpdateScroll
; ---------------------------------------------------------------------------
word_1ED28:     dc.w $26, $68C, 2, 0    ; DATA XREF: Cutscene_XiTigerUpdateScroll+E0   r
                                        ; Cutscene_XiTigerUpdateScroll+E6   r ...
                dc.w $48, $248, 4, 0


; Waits for player input to continue
Cutscene_XiTigerWaitForInput:                              ; CODE XREF: Cutscene_XiTigerWaitComplete+38   p  ; was: sub_1ED38
                bsr.s Cutscene_XiTigerSkipCheck
                neg.w   d7
; End of function Cutscene_XiTigerWaitForInput
; Checks if player wants to skip cutscene
Cutscene_XiTigerSkipCheck:                              ; CODE XREF: Cutscene_XiTigerWaitForInput   p  ; was: sub_1ED3C
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_1E9AE
                move.w  #$120,$10(a0)
                add.w   d7,$10(a0)
                lea     (dword_2AE48).l,a1
                jsr (Sprite_InitFromTable).l
                move.w  #$274,(a0)
                rts
; End of function Cutscene_XiTigerSkipCheck
; Fades out cutscene graphics
Cutscene_XiTigerFadeOut:                              ; DATA XREF: ROM:off_5DC   o  ; was: sub_1ED62
                move.w  #$E1,d0
                sub.w   (word_FF9F14).w,d0
                move.w  d0,$14(a5)
                jsr (Anim_UpdateSpriteFrame).l
                bset    #7,$E(a5)
                rts
; End of function Cutscene_XiTigerFadeOut
; Completes cutscene advancing to gameplay
Cutscene_XiTigerComplete:                              ; CODE XREF: Cutscene_XiTigerWaitComplete:loc_1E9FA   p  ; was: sub_1ED7C
                jsr (Projectile_UpdateTrajectory).l
                bne.w   locret_1E9AE
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0 ; '?'
                addi.w  #$100,d0
                move.w  d0,$14(a0)
                lea     (dword_2AE2E).l,a1
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                jmp Sprite_InitFromTable
; End of function Cutscene_XiTigerComplete
; Initializes player and scroll
Stage_InitPlayerAndScroll:                              ; DATA XREF: ROM:0001E850   o  ; was: sub_1EDC2
                move.w  #$7FFF,(word_FFA270).w
                jsr (Player_InitializeStats).l
                move.w  #$5C,(word_FFA404).w ; '\'
                move.b  #0,(word_FFF7F4+1).w
                lea     stru_1EE12(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (word_B9E6).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                move.w  #$1000,(dword_FFA900).w
                move.w  #$EC00,(dword_FFA904).w
                jsr (Scroll_GetForegroundPosition).l
                move.w  #$EC10,(dword_FFA904).w
                move.w  #$8000,(word_FF808A).w
                rts
; End of function Stage_InitPlayerAndScroll
; ---------------------------------------------------------------------------
stru_1EE12:     dc.w 7                  ; field_0
                                        ; DATA XREF: Stage_InitPlayerAndScroll+18   o
                dc.l tiles_1CA32E       ; field_2
                dc.w 0                  ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD746        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1CD7EC        ; field_2
                dc.w $4020              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_1C1A36        ; field_2
                dc.w $7000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w $FFFF


; Main gameplay update loop
Stage_UpdateGameplay:                              ; DATA XREF: ROM:0001E866   o  ; was: sub_1EE3C
                jsr (Player_Update).l
                jsr (Boss_ZLeoMainController).l
                jsr (Sys_UpdateObjectSpawner).l
                jsr (Sys_ProcessProjectiles).l
                jmp Gfx_GetCameraPosition
; End of function Stage_UpdateGameplay
; Transitions to credits screen
Stage_TransitionToCredits:                              ; DATA XREF: ROM:0001E852   o  ; was: sub_1EE5A
                move.b  #0,(word_FFF7F4+1).w
                jmp (Cutscene_InitCreditsScreen).l
; End of function Stage_TransitionToCredits
; Handles credits or advances stage
Stage_HandleCreditsOrAdvance:                              ; DATA XREF: ROM:0001E868   o  ; was: sub_1EE66
                tst.w   (dword_FF8128).w
                bne.w   loc_1EE74
                jmp (Cutscene_CreditsDispatcher).l
; ---------------------------------------------------------------------------
loc_1EE74:                              ; CODE XREF: Stage_HandleCreditsOrAdvance+4   j
                clr.w   (word_FF820C).w
                addq.w  #2,(StageTableIndex).w
                bclr    #7,(dword_FFA20E).w
                clr.b   (byte_FFA209).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #$97,d0
                jsr (Sys_WaitVBlank).l
                jmp UI_TransitionToStageLoad
; End of function Stage_HandleCreditsOrAdvance
; Initializes stage start with full game setup
UI_InitializeStageStart:                              ; DATA XREF: Sys_DispatchGameState+C6   o  ; was: sub_1EE9E
                tst.w   (GameSubstateIndex).w
                bne.s UI_LoadStageGraphics
                clr.w   (word_FFA29C).w
                clr.b   (byte_FFFF31).w
                move.w  #2,(word_FFA22A).w
                jsr (Sys_InitGameMode).l
                jsr (Sys_ClearBossDataBuffer).l
                move.w  #4,(word_FF80F2).w
                move.w  #$FFF4,(word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                jsr (Gfx_FadePaletteTransition).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                addq.w  #2,(GameSubstateIndex).w
                jmp Gfx_WriteVDPCommand
; ---------------------------------------------------------------------------
; Loads stage graphics palettes and initializes systems
UI_LoadStageGraphics:                              ; CODE XREF: UI_InitializeStageStart+4   j  ; was: loc_1EEEA
                addq.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                lea     stru_1EFB8(pc),a0
                nop
                jsr     (LoadObjData).l
                move.b  #1,(byte_FF7001).l
                clr.w   d0
                clr.w   d1
                lea     (dword_11326).l,a0
                jsr (Gfx_DirectVRAMTransfer).l
                jsr     (nullsub_1).l
                bsr.w Stage_InitializeState
                jsr (Player_InitializeStats).l
                bsr.w Gfx_InitColorTables
                move.w  #$20,(word_FFF74A).w ; ' '
                clr.w   (word_FFF74E).w
                move.w  #6,(word_FF8090).w
                move.b  #2,(byte_FFA95A).w
                move.w  #$7000,d0
                move.w  d0,(word_FF8200).w
                move.w  d0,(word_FF8202).w
                move.w  d0,(word_FF8206).w
                move.w  (word_FFA216).w,(word_FF820A).w
                move.w  #$12,(word_FFA02A).w
                move.w  #$DA,(dword_FFA410).w
                move.w  #$130,(dword_FFA414).w
                move.w  #$330,(word_FFA270).w
                bset    #0,(byte_FFA272).w
                move.w  #$8000,(word_FF808A).w
                lea     (word_B94E).l,a4
                jsr (Gfx_LoadMultiplePalettes).l
                bsr.w Gfx_SetupWeaponSprites
                jsr (Gfx_LoadPaletteData).l
                move.b  #$8E,d0
                jsr (Sys_WaitVBlank).l
                move.l  #$1400000,(dword_FF8130).w
                clr.w   (dword_FF8134).w
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                jmp (Gfx_FadePaletteTransition).l
; End of function UI_InitializeStageStart
; ---------------------------------------------------------------------------
stru_1EFB8:     dc.w 3                  ; field_0
                                        ; DATA XREF: UI_InitializeStageStart+54   o
                dc.l byte_18DFFA        ; field_2
                dc.w $5800              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18140E        ; field_2
                dc.w $E000              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18E24C        ; field_2
                dc.w $E300              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F10A4        ; field_2
                dc.w $9000              ; field_6
                dc.w 7                  ; field_0
                dc.l tiles_F276E        ; field_2
                dc.w $DE00              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18E350        ; field_2
                dc.w $6000              ; field_6
                dc.w 6                  ; field_0
                dc.l byte_18E2A2        ; field_2
                dc.w $4020              ; field_6
                dc.w 7                  ; field_0
                dc.l byte_18DF92        ; field_2
                dc.w $D000              ; field_6
                dc.w 3                  ; field_0 ; another compression type?
                dc.l byte_18DA38        ; field_2
                dc.w $F680              ; field_6
                dc.w $FFFF


; Initializes color lookup tables in RAM
Gfx_InitColorTables:                              ; CODE XREF: UI_InitializeStageStart+88   p  ; was: sub_1F002
                lea     (word_FF0D00).l,a0
                lea     (word_FF0D80).l,a1
                lea     (word_FF0E00).l,a2
                move.w  #$FF,d1
                moveq   #$3F,d7 ; '?'
loc_1F01A:                              ; CODE XREF: Gfx_InitColorTables+1E   j
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                dbf     d7,loc_1F01A
                move.b  #$82,(byte_FF78FF).l
                rts
; End of function Gfx_InitColorTables
; Sets up weapon sprite tiles in VDP
Gfx_SetupWeaponSprites:                              ; CODE XREF: UI_InitializeStageStart+E8   p  ; was: sub_1F02E
                bsr.w UI_RenderDifficultyText
                bsr.w UI_MapDifficultyIndex
                bsr.w UI_RenderControlsText
                bsr.w UI_RenderSoundText
                lea     word_1F5EE(pc),a2
                nop
                moveq   #0,d7
loc_1F046:                              ; CODE XREF: Gfx_SetupWeaponSprites+2C   j
                move.w  (a2,d7.w),d3
                subq.w  #6,d3
                move.w  d7,d0
                jsr (Sprite_SetupTileVDP).l
                addq.w  #2,d7
                cmpi.w  #$C,d7
                bmi.s   loc_1F046
locret_1F05C:                           ; CODE XREF: Stage_HandleTransition+C   j
                                        ; UI_HandleMenuNavigation+C   j ...
                rts
; End of function Gfx_SetupWeaponSprites
; Initializes stage state machine
Stage_InitializeState:                              ; CODE XREF: UI_InitializeStageStart+7E   p  ; was: sub_1F05E
                clr.w   (word_FFA24E).w
                clr.w   (word_FFA250).w
                clr.w   (word_FFA252).w
                clr.w   (word_FFA254).w
                clr.w   (word_FFA256).w
; End of function Stage_InitializeState
; Updates UI menu state and rendering
UI_UpdateMenuState:                              ; CODE XREF: Stage_HandleTransition+16   p  ; was: sub_1F072
                                        ; UI_HandleTitleMenuInput+C   p ...
                movea.w #(word_FFA260-M68K_RAM),a0
                move.w  #$3E8,d0
                moveq   #7,d7
loc_1F07C:                              ; CODE XREF: UI_UpdateMenuState+C   j
                move.w  d0,(a0)+
                dbf     d7,loc_1F07C
                rts
; End of function UI_UpdateMenuState
; Main gameplay loop with player physics and rendering
Sys_UpdateGameplayLoop:                              ; DATA XREF: Sys_DispatchGameState+CA   o  ; was: sub_1F084
                jsr (Gfx_UpdateScrollPosition).l
                jsr (Boss_UpdateCollisionSystem).l
                jsr (Sys_InitObjectPointers).l
                jsr (UI_CheckVBlankFlag).l
                jsr (Physics_ApplyFriction).l
                jsr (UI_RenderHUDElement1).l
                jsr (Player_Update).l
                jsr (UI_UpdateWeaponDisplay).l
                jsr (Sys_ProcessProjectiles).l
                jsr (Sys_ProcessVisibleObjects).l
                bsr.w Stage_LoadAssets
                jsr (Sys_UpdateObjectCount).l
                jsr (Sys_ProcessObjectList).l
                jsr (Gfx_FadePaletteTransition).l
                jsr (Gfx_SetupScrollPlanes).l
                addq.w  #1,(word_FFA000).w
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1F0EE
                addq.w  #2,(GameSubstateIndex).w
                rts
; ---------------------------------------------------------------------------
loc_1F0EE:                              ; CODE XREF: Sys_UpdateGameplayLoop+62   j
                bclr    #1,(word_FF80F4).w
                bne.s   loc_1F0F8
                rts
; ---------------------------------------------------------------------------
loc_1F0F8:                              ; CODE XREF: Sys_UpdateGameplayLoop+70   j
                tst.w   (StageTableIndex).w
                bne.s UI_TransitionToContinueScreen
                move.l  #byte_1E444,(dword_FFA22C).w ; text?
                move.w  #$34,(GameModeIndex).w ; '4'
                clr.w   (GameSubstateIndex).w
                jsr (Input_GetMappedButton).l
                jmp UI_InitializeGameVariables
; ---------------------------------------------------------------------------
; Transitions to continue screen after stage end
UI_TransitionToContinueScreen:                              ; CODE XREF: Sys_UpdateGameplayLoop+78   j  ; was: loc_1F11C
                move.w  #$3C,(GameModeIndex).w ; '<'
                clr.w   (GameSubstateIndex).w
                jmp     loc_1CDB8
; End of function Sys_UpdateGameplayLoop
; Loads stage assets and data
Stage_LoadAssets:                              ; CODE XREF: Sys_UpdateGameplayLoop+3C   p  ; was: sub_1F12C
                bsr.w Gfx_Update3DPlanetEffect
                move.w  (word_FFA29C).w,d0
                movea.w off_1F140(pc,d0.w),a0
                adda.l  #Stage_HandleTransition,a0
                jmp     (a0)
; End of function Stage_LoadAssets
; ---------------------------------------------------------------------------
off_1F140:      dc.w Stage_HandleTransition-Stage_HandleTransition
                                        ; DATA XREF: Stage_LoadAssets+8   r
                dc.w UI_HandleMenuNavigation-Stage_HandleTransition
                dc.w UI_HandleWeaponMenuNavigation-Stage_HandleTransition
                dc.w Sprite_ExecuteFadeTransition-Stage_HandleTransition
                dc.w Gfx_LoadMenuGraphics-Stage_HandleTransition
                dc.w UI_WaitForButtonPress-Stage_HandleTransition
                dc.w UI_MenuEmptyState-Stage_HandleTransition


; Handles stage state transitions
Stage_HandleTransition:                              ; DATA XREF: Stage_LoadAssets+C   o  ; was: sub_1F14E
                                        ; ROM:off_1F140   o ...
                bsr.w Gfx_RenderMenuSprites
                bsr.w Gfx_UpdatePaletteIndices
                bsr.w Gfx_InterpolateScrollPosition
                bne.w   locret_1F05C
                move.w  #$12,(word_FFA02A).w
                bsr.w UI_UpdateMenuState
                bsr.w UI_HandleOptionSelection
                btst    #0,(word_FFA280+1).w
                bne.s Gfx_RenderWeaponCursor
                rts
; ---------------------------------------------------------------------------
; Renders weapon selection cursor sprite
Gfx_RenderWeaponCursor:                              ; CODE XREF: Stage_HandleTransition+24   j  ; was: loc_1F176
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  (dword_FF8128).w,d0
                move.w  word_1F1A6(pc,d0.w),(a1)+
                move.w  #$B00,(a1)+
                move.w  #$C6F0,(a1)+
                move.w  word_1F19A(pc,d0.w),(a1)+
                move.w  #$FFFF,(a1)+
                jmp (Sprite_AddToOAMBuffer).l
; End of function Stage_HandleTransition
; ---------------------------------------------------------------------------
word_1F19A:     dc.w $97, $127, $97, $127, $97, $127
                                        ; DATA XREF: Stage_HandleTransition+3E   r
word_1F1A6:     dc.w $B8, $B8, $C8, $C8, $D8, $D8
                                        ; DATA XREF: Stage_HandleTransition+32   r


; Processes menu navigation input and state changes for title screen
UI_HandleTitleMenuInput:
                bsr.w Gfx_RenderMenuSprites  ; was: sub_1F1B2
                bsr.w Gfx_InterpolateScrollPosition
                bne.w   loc_1F5AE
                bsr.w UI_UpdateMenuState
                move.w  (word_FFA22A).w,d1
                beq.s   loc_1F1D2
                btst    #2,(word_FFF708).w
                beq.s   loc_1F1D2
                moveq   #0,d1
loc_1F1D2:                              ; CODE XREF: UI_HandleTitleMenuInput+14   j
                                        ; UI_HandleTitleMenuInput+1C   j
                tst.w   d1
                bne.s   loc_1F1E0
                btst    #3,(word_FFF708).w
                beq.s   loc_1F1E0
                moveq   #2,d1
loc_1F1E0:                              ; CODE XREF: UI_HandleTitleMenuInput+22   j
                                        ; UI_HandleTitleMenuInput+2A   j
                cmp.w   (word_FFA22A).w,d1
                beq.s   loc_1F1F4
                move.w  d1,(word_FFA22A).w
                move.b  #$DB,d0
                jsr (Sound_PlaySFX).l
loc_1F1F4:                              ; CODE XREF: UI_HandleTitleMenuInput+32   j
                move.b  (word_FFF708).w,d0
                btst    #1,d0
                bne.s   loc_1F204
                andi.b  #$E0,d0
                beq.s   loc_1F21C
loc_1F204:                              ; CODE XREF: UI_HandleTitleMenuInput+4A   j
                addq.w  #2,(word_FFA29C).w
                subi.w  #$10,(dword_FF8128+2).w
                move.b  #$AD,d0
                jsr (Sound_PlaySFX).l
                bra.w UI_RenderTitleMenuOptions
; ---------------------------------------------------------------------------
loc_1F21C:                              ; CODE XREF: UI_HandleTitleMenuInput+50   j
                btst    #4,(word_FFF708).w
                beq.w UI_RenderTitleMenuOptions
                subq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8128+2).w
                move.w  #$12,(word_FFA02A).w
                bra.w UI_RenderTitleMenuOptions
; End of function UI_HandleTitleMenuInput
; Handles menu navigation with directional input
UI_HandleMenuNavigation:                              ; DATA XREF: ROM:0001F142   o  ; was: sub_1F238
                bsr.w Gfx_RenderMenuSprites
                bsr.w Gfx_UpdatePaletteIndices
                bsr.w Gfx_InterpolateScrollPosition
                bne.w   locret_1F05C
                bsr.w UI_UpdateMenuState
                move.w  (dword_FF812C).w,d1
                beq.s   loc_1F25C
                btst    #2,(word_FFF708).w
                beq.s   loc_1F25C
                subq.w  #1,d1
loc_1F25C:                              ; CODE XREF: UI_HandleMenuNavigation+18   j
                                        ; UI_HandleMenuNavigation+20   j
                cmpi.w  #$19,d1
                bpl.s   loc_1F26C
                btst    #3,(word_FFF708).w
                beq.s   loc_1F26C
                addq.w  #1,d1
loc_1F26C:                              ; CODE XREF: UI_HandleMenuNavigation+28   j
                                        ; UI_HandleMenuNavigation+30   j
                cmp.w   (dword_FF812C).w,d1
                beq.s   loc_1F280
                move.w  d1,(dword_FF812C).w
                move.b  #$DB,d0
                jsr (Sound_PlaySFX).l
loc_1F280:                              ; CODE XREF: UI_HandleMenuNavigation+38   j
                move.b  (word_FFF708).w,d0
                btst    #1,d0
                bne.s   loc_1F290
                andi.b  #$E0,d0
                beq.s   loc_1F2AE
loc_1F290:                              ; CODE XREF: UI_HandleMenuNavigation+50   j
                move.w  #$E,(dword_FF8134).w
                addq.w  #2,(word_FFA29C).w
                subi.w  #$10,(dword_FF8128+2).w
                move.b  #$AD,d0
                jsr (Sound_PlaySFX).l
                bra.w UI_UpdateMenuCursor
; ---------------------------------------------------------------------------
loc_1F2AE:                              ; CODE XREF: UI_HandleMenuNavigation+56   j
                btst    #0,(word_FFF708).w
                bne.s UI_HandleMenuUpInput
                btst    #4,(word_FFF708).w
                beq.w UI_UpdateMenuCursor
; Handles up direction input on menu
UI_HandleMenuUpInput:                              ; CODE XREF: UI_HandleMenuNavigation+7C   j  ; was: loc_1F2C0
                move.w  #$E,(dword_FF8134).w
                subq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8128+2).w
                bra.w UI_UpdateMenuCursor
; End of function UI_HandleMenuNavigation
; ---------------------------------------------------------------------------
off_1F2D2:      dc.l byte_1FA82         ; DATA XREF: UI_RenderSelectedDifficulty+10   o
                dc.l byte_1FA8A
                dc.l byte_1FA92
                dc.l byte_1FA9A
                dc.l byte_1FAA2
                dc.l byte_1FAAA
                dc.l byte_1FAB2
                dc.l byte_1FABA
                dc.l byte_1FAC2
                dc.l byte_1FACA
                dc.l byte_1FAD2
                dc.l byte_1FADA
                dc.l byte_1FAE2
                dc.l byte_1FAEA
                dc.l byte_1FAF2
                dc.l byte_1FAFA
                dc.l byte_1FB02
                dc.l byte_1FB0A
                dc.l byte_1FB12
                dc.l byte_1FB1A
                dc.l byte_1FB22
                dc.l byte_1FB2A
                dc.l byte_1FB32
                dc.l byte_1FB3A
                dc.l byte_1FB42
                dc.l byte_1FB4A
byte_1F33A:     dc.b 0, 7, $38, 2, 4, 1, 6, 3
                                        ; DATA XREF: UI_MapDifficultyIndex   o
                                        ; UI_RenderSelectedDifficulty+4   o
                dc.b 5, $10, 8, $20, $18, $30, $28, $15
                dc.b $B, $26, $19, $34, $2A, $24, $22, 9
                dc.b $A, $14, $11, 0


; Handles weapon menu directional navigation
UI_HandleWeaponMenuNavigation:                              ; DATA XREF: ROM:0001F144   o  ; was: sub_1F356
                bsr.w Gfx_RenderMenuSprites
                bsr.w Gfx_UpdatePaletteIndices
                bsr.w Gfx_InterpolateScrollPosition
                bne.w   locret_1F05C
                bsr.w UI_UpdateMenuState
                move.b  (word_FFF708).w,d0
                andi.b  #$E0,d0
                beq.s   loc_1F392
                move.w  #$E,(dword_FF8134).w
                addq.w  #2,(word_FFA29C).w
                move.w  #$6000,(dword_FFA940).w
                move.w  #$1F,(word_FFA944).w
                clr.w   (word_FFA946).w
                bra.w UI_UpdateWeaponCursor
; ---------------------------------------------------------------------------
loc_1F392:                              ; CODE XREF: UI_HandleWeaponMenuNavigation+1C   j
                btst    #0,(word_FFF708).w
                bne.s UI_HandleWeaponMenuUp
                btst    #4,(word_FFF708).w
                beq.w UI_UpdateWeaponCursor
; Handles up direction on weapon selection menu
UI_HandleWeaponMenuUp:                              ; CODE XREF: UI_HandleWeaponMenuNavigation+42   j  ; was: loc_1F3A4
                move.w  #$E,(dword_FF8134).w
                subq.w  #2,(word_FFA29C).w
                addi.w  #$10,(dword_FF8128+2).w
                bra.w UI_UpdateWeaponCursor
; End of function UI_HandleWeaponMenuNavigation
; Executes sprite fade with DMA transfers
Sprite_ExecuteFadeTransition:                              ; DATA XREF: ROM:0001F146   o  ; was: sub_1F3B8
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                jsr (Sprite_SetupDMA).l
                tst.w   (word_FFA944).w
                bpl.w   locret_1F05C
                addq.w  #2,(word_FFA29C).w
                clr.w   (word_FFA02A).w
                clr.w   (dword_FFA90C).w
                rts
; End of function Sprite_ExecuteFadeTransition
; Loads menu graphic elements in loop
Gfx_LoadMenuGraphics:                              ; DATA XREF: ROM:0001F148   o  ; was: sub_1F3E6
                addq.w  #2,(word_FFA29C).w
                clr.w   (dword_FF8040).w
; Renders menu text strings in loop
Gfx_RenderMenuTextLoop:                              ; CODE XREF: Gfx_LoadMenuGraphics+30   j  ; was: loc_1F3EE
                lea     stru_1F424(pc),a1
                nop
                move.w  (dword_FF8040).w,d1
                move.w  (a1,d1.w),d0
                move.w  2(a1,d1.w),d4
                movea.l 4(a1,d1.w),a0
                jsr (UI_RenderTextStringWrapped).l
                addi.w  #8,(dword_FF8040).w
                cmpi.w  #$40,(dword_FF8040).w ; '@'
                bne.s Gfx_RenderMenuTextLoop
                lea     (word_B954).l,a4
                jmp Gfx_LoadMultiplePalettes
; End of function Gfx_LoadMenuGraphics
; ---------------------------------------------------------------------------
stru_1F424:     dc.w $8100              ; field_0
                                        ; DATA XREF: Gfx_LoadMenuGraphics:loc_1F3EE   o
                dc.w $629C              ; field_2
                dc.l byte_1FB57         ; field_4
                dc.w $A100              ; field_0
                dc.w $6410              ; field_2
                dc.l byte_1FB64         ; field_4
                dc.w $A100              ; field_0
                dc.w $6522              ; field_2
                dc.l byte_1FB77         ; field_4
                dc.w $A100              ; field_0
                dc.w $6622              ; field_2
                dc.l byte_1FB81         ; field_4
                dc.w $A100              ; field_0
                dc.w $6788              ; field_2
                dc.l byte_1FB8B         ; field_4
                dc.w $A100              ; field_0
                dc.w $6910              ; field_2
                dc.l byte_1FBA7         ; field_4
                dc.w $A100              ; field_0
                dc.w $6A10              ; field_2
                dc.l byte_1FBBF         ; field_4
                dc.w $A100              ; field_0
                dc.w $6B1A              ; field_2
                dc.l byte_1FBD7         ; field_4


; Waits for button press before proceeding
UI_WaitForButtonPress:                              ; DATA XREF: ROM:0001F14A   o  ; was: sub_1F464
                bsr.w Gfx_RenderConfirmSprites
                btst    #7,(word_FFF708).w
                bne.s UI_ConfirmMenuSelection
                rts
; ---------------------------------------------------------------------------
; Confirms menu selection and triggers fade
UI_ConfirmMenuSelection:                              ; CODE XREF: UI_WaitForButtonPress+A   j  ; was: loc_1F472
                addq.w  #2,(word_FFA29C).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #1,d0
                jsr (Input_ProcessButtons).l
                bra.w UI_UpdateMenuState
; End of function UI_WaitForButtonPress
; Empty UI menu state handler
UI_MenuEmptyState:                             ; DATA XREF: ROM:0001F14C   o  ; was: nullsub_53
                rts
; End of function UI_MenuEmptyState
; Handles option selection with directional controls
UI_HandleOptionSelection:                              ; CODE XREF: Stage_HandleTransition+1A   p  ; was: sub_1F496
                move.b  (word_FFF708).w,d0
                andi.b  #$E0,d0
                beq.s   loc_1F4D2
                move.w  #$E,(dword_FF8134).w
                move.b  #$DF,d0
                jsr (Sound_PlaySFX).l
                addq.w  #2,(word_FFA24E).w
                cmpi.w  #8,(word_FFA24E).w
                bmi.s   loc_1F4D2
                move.w  #6,(word_FFA24E).w
                addq.w  #2,(word_FFA29C).w
                move.w  #$FFE0,(dword_FF8128+2).w
                move.w  #$14,(word_FFA02A).w
loc_1F4D2:                              ; CODE XREF: UI_HandleOptionSelection+8   j
                                        ; UI_HandleOptionSelection+24   j
                tst.w   (word_FFA24E).w
                beq.s   loc_1F51A
                btst    #4,(word_FFF708).w
                beq.s   loc_1F51A
                move.w  #$E,(dword_FF8134).w
                move.b  #$DE,d0
                jsr (Sound_PlaySFX).l
                subq.w  #2,(word_FFA24E).w
                bpl.s   loc_1F4FA
                clr.w   (word_FFA24E).w
loc_1F4FA:                              ; CODE XREF: UI_HandleOptionSelection+5E   j
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),(dword_FF8128).w
                move.w  (word_FFA24E).w,(word_FF803C).w
                clr.w   (word_FF8238).w
                jsr (UI_IncrementWeaponSelection).l
                bra.w   loc_1F5AE
; ---------------------------------------------------------------------------
loc_1F51A:                              ; CODE XREF: UI_HandleOptionSelection+40   j
                                        ; UI_HandleOptionSelection+48   j
                move.w  (word_FFA24E).w,(word_FF803C).w
                move.w  (dword_FF8128).w,d0
                andi.w  #$C,d0
                move.w  (dword_FF8128).w,d1
                andi.w  #2,d1
                moveq   #0,d2
                tst.w   d0
                beq.s   loc_1F542
                btst    #0,(word_FFF708).w
                beq.s   loc_1F542
                subq.w  #4,d0
                addq.w  #1,d2
loc_1F542:                              ; CODE XREF: UI_HandleOptionSelection+9E   j
                                        ; UI_HandleOptionSelection+A6   j
                cmpi.w  #8,d0
                beq.s   loc_1F554
                btst    #1,(word_FFF708).w
                beq.s   loc_1F554
                addq.w  #4,d0
                addq.w  #1,d2
loc_1F554:                              ; CODE XREF: UI_HandleOptionSelection+B0   j
                                        ; UI_HandleOptionSelection+B8   j
                tst.w   d1
                bne.s   loc_1F564
                btst    #3,(word_FFF708).w
                beq.s   loc_1F564
                addq.w  #2,d1
                addq.w  #1,d2
loc_1F564:                              ; CODE XREF: UI_HandleOptionSelection+C0   j
                                        ; UI_HandleOptionSelection+C8   j
                tst.w   d1
                beq.s   loc_1F574
                btst    #2,(word_FFF708).w
                beq.s   loc_1F574
                subq.w  #2,d1
                addq.w  #1,d2
loc_1F574:                              ; CODE XREF: UI_HandleOptionSelection+D0   j
                                        ; UI_HandleOptionSelection+D8   j
                add.w   d0,d1
                move.w  d1,(dword_FF8128).w
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (dword_FF8128).w,d0
                move.w  d0,(a0)
                move.w  d2,(dword_FF8040).w
                jsr (Gfx_LoadPaletteData).l
                move.w  (dword_FF8040).w,d2
                tst.w   d2
                beq.s   loc_1F5AE
                move.b  #$DB,d0
                jsr (Sound_PlaySFX).l
                clr.w   (word_FF8238).w
                jsr (UI_IncrementWeaponSelection).l
loc_1F5AE:                              ; CODE XREF: UI_HandleTitleMenuInput+8   j
                                        ; UI_HandleOptionSelection+80   j ...
                clr.w   (dword_FF8040).w
loc_1F5B2:                              ; CODE XREF: UI_HandleOptionSelection+154   j
                move.w  (dword_FF8040).w,d1
                move.w  #$8100,d0
                tst.w   (word_FFA29C).w
                bne.s UI_RenderOptionMenuText
                cmp.w   (dword_FF8128).w,d1
                bne.s UI_RenderOptionMenuText
                move.w  #$E100,d0
; Renders option menu text strings using lookup table
UI_RenderOptionMenuText:                              ; CODE XREF: UI_HandleOptionSelection+128   j  ; was: loc_1F5CA
                                        ; UI_HandleOptionSelection+12E   j
                lea     word_1F5EE(pc),a1
                nop
                move.w  (a1,d1.w),d4
                asl.w   #1,d1
                movea.l $C(a1,d1.w),a0
                jsr (UI_RenderTextStringWrapped).l
                addq.w  #2,(dword_FF8040).w
                cmpi.w  #$C,(dword_FF8040).w
                bne.s   loc_1F5B2
                rts
; End of function UI_HandleOptionSelection
; ---------------------------------------------------------------------------
word_1F5EE:     dc.w $640C, $6430, $650C, $6530, $660C, $6630
                                        ; DATA XREF: Gfx_SetupWeaponSprites+10   o
                                        ; sub_1F496:loc_1F5CA   o
                dc.l byte_1FA0F
                dc.l byte_1FA1C
                dc.l byte_1FA29
                dc.l byte_1FA35
                dc.l byte_1FA42
                dc.l byte_1FA4E


; Renders difficulty selection text
UI_RenderDifficultyText:                              ; CODE XREF: Gfx_SetupWeaponSprites   p  ; was: sub_1F612
                move.w  #$A100,d0
                lea     byte_1F9FA(pc),a0
                nop
                move.w  #$6294,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderDifficultyText
; Renders title menu text options with highlight colors
UI_RenderTitleMenuOptions:                              ; CODE XREF: UI_HandleTitleMenuInput+66   j  ; was: sub_1F626
                                        ; UI_HandleTitleMenuInput+70   j ...
                move.w  #$8100,d0
                cmpi.w  #2,(word_FFA29C).w
                bne.s   loc_1F63A
                btst    #1,(word_FFA000+1).w
                bne.s   loc_1F63E
loc_1F63A:                              ; CODE XREF: UI_RenderTitleMenuOptions+A   j
                move.w  #$A100,d0
loc_1F63E:                              ; CODE XREF: UI_RenderTitleMenuOptions+12   j
                lea     byte_1FA5B(pc),a0
                nop
                move.w  #$680E,d4
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8100,d0
                tst.w   (word_FFA22A).w
                beq.s   loc_1F65C
                move.w  #$A100,d0
loc_1F65C:                              ; CODE XREF: UI_RenderTitleMenuOptions+30   j
                lea     byte_1FA69(pc),a0
                nop
                move.w  #$6830,d4
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8100,d0
                tst.w   (word_FFA22A).w
                bne.s   loc_1F67A
                move.w  #$A100,d0
loc_1F67A:                              ; CODE XREF: UI_RenderTitleMenuOptions+4E   j
                lea     byte_1FA70(pc),a0
                nop
                move.w  #$6840,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderTitleMenuOptions
; Updates menu cursor position display
UI_UpdateMenuCursor:                              ; CODE XREF: UI_HandleMenuNavigation+72   j  ; was: sub_1F68A
                                        ; UI_HandleMenuNavigation+84   j ...
                move.w  #$E100,d0
                cmpi.w  #2,(word_FFA29C).w
                beq.s   loc_1F69A
; End of function UI_UpdateMenuCursor
; Renders control settings text
UI_RenderControlsText:                              ; CODE XREF: Gfx_SetupWeaponSprites+8   p  ; was: sub_1F696
                move.w  #$8100,d0
loc_1F69A:                              ; CODE XREF: UI_UpdateMenuCursor+A   j
                lea     byte_1FA74(pc),a0
                nop
                move.w  #$680E,d4
                jsr (UI_RenderTextStringWrapped).l
                bra.s UI_RenderSelectedDifficulty
; End of function UI_RenderControlsText
; Maps difficulty byte to menu index
UI_MapDifficultyIndex:                              ; CODE XREF: Gfx_SetupWeaponSprites+4   p  ; was: sub_1F6AC
                lea     byte_1F33A(pc),a0
                move.b  (byte_FFFF30).w,d0
                moveq   #0,d1
                moveq   #$19,d7
loc_1F6B8:                              ; CODE XREF: UI_MapDifficultyIndex+12   j
                cmp.b   (a0)+,d0
                beq.s   loc_1F6C8
                addq.w  #1,d1
                dbf     d7,loc_1F6B8
                move.b  #0,(byte_FFFF30).w
loc_1F6C8:                              ; CODE XREF: UI_MapDifficultyIndex+E   j
                move.b  d1,(dword_FF812C+1).w
                rts
; End of function UI_MapDifficultyIndex
; Renders currently selected difficulty option
UI_RenderSelectedDifficulty:                              ; CODE XREF: UI_RenderControlsText+14   j  ; was: sub_1F6CE
                move.w  (dword_FF812C).w,d1
                lea     byte_1F33A(pc),a0
                move.b  (a0,d1.w),(byte_FFFF30).w
                asl.w   #2,d1
                lea     off_1F2D2(pc),a0
                movea.l (a0,d1.w),a0
                move.w  #$E100,d0
                cmpi.w  #2,(word_FFA29C).w
                beq.s   loc_1F6F6
                move.w  #$8100,d0
loc_1F6F6:                              ; CODE XREF: UI_RenderSelectedDifficulty+22   j
                move.w  #$6830,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderSelectedDifficulty
; Updates weapon selection cursor position
UI_UpdateWeaponCursor:                              ; CODE XREF: UI_HandleWeaponMenuNavigation+38   j  ; was: sub_1F700
                                        ; UI_HandleWeaponMenuNavigation+4A   j ...
                move.w  #$E100,d0
                cmpi.w  #4,(word_FFA29C).w
                beq.s   loc_1F710
; End of function UI_UpdateWeaponCursor
; Renders sound settings text
UI_RenderSoundText:                              ; CODE XREF: Gfx_SetupWeaponSprites+C   p  ; was: sub_1F70C
                move.w  #$8100,d0
loc_1F710:                              ; CODE XREF: UI_UpdateWeaponCursor+A   j
                lea     byte_1FB52(pc),a0
                nop
                move.w  #$690E,d4
                jmp (UI_RenderTextStringWrapped).l
; End of function UI_RenderSoundText
; Smoothly interpolates scroll position to target
Gfx_InterpolateScrollPosition:                              ; CODE XREF: Stage_HandleTransition+8   p  ; was: sub_1F720
                                        ; UI_HandleTitleMenuInput+4   p ...
                move.w  (dword_FFA90C).w,d0
                cmp.w   (dword_FF8128+2).w,d0
                beq.s   locret_1F73A
                bmi.s   loc_1F734
                subq.w  #4,(dword_FFA90C).w
                moveq   #1,d0
                rts
; ---------------------------------------------------------------------------
loc_1F734:                              ; CODE XREF: Gfx_InterpolateScrollPosition+A   j
                addq.w  #4,(dword_FFA90C).w
                moveq   #1,d0
locret_1F73A:                           ; CODE XREF: Gfx_InterpolateScrollPosition+8   j
                rts
; End of function Gfx_InterpolateScrollPosition
; Renders menu sprite graphics conditionally
Gfx_RenderMenuSprites:                              ; CODE XREF: Stage_HandleTransition   p  ; was: sub_1F73C
                                        ; sub_1F1B2   p ...
                btst    #3,(word_FFA000+1).w
                bne.s   loc_1F746
                rts
; ---------------------------------------------------------------------------
loc_1F746:                              ; CODE XREF: Gfx_RenderMenuSprites+6   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D4,(a1)+
                move.w  #$158,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2D8,(a1)+
                move.w  #$178,(a1)+
                move.w  d0,(a1)+
                move.w  #$400,(a1)+
                move.w  #$C2DC,(a1)+
                move.w  #$198,(a1)+
                move.w  #$FFFF,(a1)+
                jmp (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderMenuSprites
; Renders confirmation button sprites
Gfx_RenderConfirmSprites:                              ; CODE XREF: UI_WaitForButtonPress   p  ; was: sub_1F784
                btst    #3,(word_FFA000+1).w
                bne.s   loc_1F78E
                rts
; ---------------------------------------------------------------------------
loc_1F78E:                              ; CODE XREF: Gfx_RenderConfirmSprites+6   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                movea.w a0,a1
                move.w  #$146,d0
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2DE,(a1)+
                move.w  #$164,(a1)+
                move.w  d0,(a1)+
                move.w  #$C00,(a1)+
                move.w  #$C2E2,(a1)+
                move.w  #$184,(a1)+
                move.w  #$FFFF,(a1)+
                jmp (Sprite_AddToOAMBuffer).l
; End of function Gfx_RenderConfirmSprites
; Updates palette color indices for animation
Gfx_UpdatePaletteIndices:                              ; CODE XREF: Stage_HandleTransition+4   p  ; was: sub_1F7BE
                                        ; UI_HandleMenuNavigation+4   p ...
                move.w  (dword_FF8134).w,d0
                bne.s   loc_1F7D0
                btst    #0,(word_FFA280+1).w
                bne.s Gfx_WritePaletteColors
                addq.w  #2,d0
                bra.s Gfx_WritePaletteColors
; ---------------------------------------------------------------------------
loc_1F7D0:                              ; CODE XREF: Gfx_UpdatePaletteIndices+4   j
                subq.w  #2,(dword_FF8134).w
; Writes calculated palette colors to RAM
Gfx_WritePaletteColors:                              ; CODE XREF: Gfx_UpdatePaletteIndices+C   j  ; was: loc_1F7D4
                                        ; Gfx_UpdatePaletteIndices+10   j
                andi.w  #$E,d0
                move.w  word_1F7E6(pc,d0.w),(word_FFE362).w
                move.w  word_1F7F6(pc,d0.w),(word_FFE364).w
                rts
; End of function Gfx_UpdatePaletteIndices
; ---------------------------------------------------------------------------
word_1F7E6:     dc.w $400, $400, $400, $400, $400, $200, 0, $600
                                        ; DATA XREF: Gfx_UpdatePaletteIndices+1A   r
word_1F7F6:     dc.w $EEE, $EEC, $ECA, $CA8, $A86, $864, $642, $EEE
                                        ; DATA XREF: Gfx_UpdatePaletteIndices+20   r
word_1F806:     dc.w $200, $400, $622, $844, $A66, $C88, $CAA, $ACC, $8EE, $6CE
                                        ; DATA XREF: Gfx_Update3DPlanetEffect+52   r
word_1F81A:     dc.w $48E, $24E, $2C, $A, 8, 6, 4, 2, 0, 0
                                        ; DATA XREF: Gfx_Update3DPlanetEffect+4C   r


; Updates 3D planet rotation and parallax effect
Gfx_Update3DPlanetEffect:                              ; CODE XREF: Stage_LoadAssets   p  ; was: sub_1F82E
                cmpi.w  #$A,(word_FFA29C).w
                bpl.s   loc_1F852
                subi.l  #$18000,(dword_FF8130).w
                cmpi.l  #$B00000,(dword_FF8130).w
                bpl.s   loc_1F86C
                move.l  #$1500000,(dword_FF8130).w
                bra.s   loc_1F86C
; ---------------------------------------------------------------------------
loc_1F852:                              ; CODE XREF: Gfx_Update3DPlanetEffect+6   j
                addi.l  #$18000,(dword_FF8130).w
                cmpi.l  #$1500000,(dword_FF8130).w
                bmi.s   loc_1F86C
                move.l  #$B00000,(dword_FF8130).w
loc_1F86C:                              ; CODE XREF: Gfx_Update3DPlanetEffect+18   j
                                        ; Gfx_Update3DPlanetEffect+22   j ...
                move.w  (dword_FF8130).w,d0
                asr.w   #3,d0
                subi.w  #$16,d0
                andi.w  #$1E,d0
                move.w  word_1F81A(pc,d0.w),(word_FFE37C).w
                move.w  word_1F806(pc,d0.w),(word_FFE37E).w
                movea.w #(byte_FF9C1E-M68K_RAM),a0
                moveq   #1,d0
                move.w  #$60,d7 ; '`'
loc_1F890:                              ; CODE XREF: Gfx_Update3DPlanetEffect+66   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_1F890
                movea.w #(byte_FF9C80-M68K_RAM),a0
                move.l  (dword_FF8130).w,d0
                subi.l  #Z80_RAM,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F8AE:                              ; CODE XREF: Gfx_Update3DPlanetEffect+AE   j
                swap    d0
                move.w  d0,d3
                addq.w  #6,d3
                neg.w   d3
                move.w  d0,d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                move.w  d0,d3
                addq.w  #4,d3
                move.w  d0,d2
                addq.w  #2,d2
                neg.w   d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                swap    d0
                add.l   d1,d0
                cmpi.l  #$600000,d0
                bmi.s   loc_1F8AE
                move.l  (dword_FF8130).w,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F8EA:                              ; CODE XREF: Gfx_Update3DPlanetEffect+EA   j
                swap    d0
                move.w  d0,d3
                addq.w  #2,d3
                neg.w   d3
                move.w  d0,d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                move.w  d0,d3
                subq.w  #8,d3
                move.w  d0,d2
                addq.w  #2,d2
                neg.w   d2
                andi.w  #$FFFE,d2
                move.w  d3,(a0,d2.w)
                swap    d0
                add.l   d1,d0
                cmpi.l  #$600000,d0
                bmi.s   loc_1F8EA
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.l  #$EEEEEEEE,d0
                moveq   #$FFFFFFFF,d1
                moveq   #0,d2
                moveq   #$13,d7
loc_1F92A:                              ; CODE XREF: Gfx_Update3DPlanetEffect+10C   j
                move.l  d0,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d1,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                move.l  d2,(a0)+
                dbf     d7,loc_1F92A
                move.l  (dword_FF8130).w,d0
                subi.l  #Z80_RAM,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F950:                              ; CODE XREF: Gfx_Update3DPlanetEffect+148   j
                swap    d0
                btst    #0,d0
                beq.s   loc_1F962
                move.w  #$F,d1
                move.w  #$F,d2
                bra.s   loc_1F96A
; ---------------------------------------------------------------------------
loc_1F962:                              ; CODE XREF: Gfx_Update3DPlanetEffect+128   j
                move.w  #$F0,d1
                move.w  #$FF,d2
loc_1F96A:                              ; CODE XREF: Gfx_Update3DPlanetEffect+132   j
                bsr.s Gfx_WritePixelData
                swap    d0
                add.l   d1,d0
                cmpi.l  #Z80_RAM,d0
                bmi.s   loc_1F950
                move.l  (dword_FF8130).w,d0
                move.l  d0,d1
                move.l  d0,d2
                lsr.l   #1,d2
                sub.l   d2,d0
loc_1F984:                              ; CODE XREF: Gfx_Update3DPlanetEffect+17C   j
                swap    d0
                btst    #0,d0
                beq.s   loc_1F996
                move.w  #$E,d1
                move.w  #$FE,d2
                bra.s   loc_1F99E
; ---------------------------------------------------------------------------
loc_1F996:                              ; CODE XREF: Gfx_Update3DPlanetEffect+15C   j
                move.w  #$E0,d1
                move.w  #$EF,d2
loc_1F99E:                              ; CODE XREF: Gfx_Update3DPlanetEffect+166   j
                bsr.s Gfx_WritePixelData
                swap    d0
                add.l   d1,d0
                cmpi.l  #Z80_RAM,d0
                bmi.s   loc_1F984
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  #$7000,d0
                move.w  #$8F02,d3
                move.l  #$94019340,d4
                jmp     loc_1B78C
; End of function Gfx_Update3DPlanetEffect
; Writes pixel data to graphics buffer
Gfx_WritePixelData:                              ; CODE XREF: Gfx_Update3DPlanetEffect:loc_1F96A   p  ; was: sub_1F9C4
                                        ; sub_1F82E:loc_1F99E   p
                move.w  d0,d3
                move.w  d0,d4
                asr.w   #1,d3
                andi.w  #3,d3
                andi.w  #$FFF8,d4
                asl.w   #2,d4
                add.w   d3,d4
                addi.w  #-$6C00,d4
                movea.w d4,a0
                move.b  d1,4(a0)
                move.b  d1,8(a0)
                move.b  d1,$C(a0)
                move.b  d2,$10(a0)
                move.b  d1,$14(a0)
                move.b  d1,$18(a0)
                move.b  d1,$1C(a0)
                rts
; End of function Gfx_WritePixelData
; ---------------------------------------------------------------------------
byte_1F9FA:     dc.b 0, $1D, $F, $1E, $1F, $1A, 0, $23, $19, $1F, $1C, 0, $21, $F, $B, $1A
                                        ; DATA XREF: UI_RenderDifficultyText+4   o
                dc.b $19, $18, $1D, 0, $FF
byte_1FA0F:     dc.b $C, $1F, $1D, $1E, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F5FA   o
byte_1FA1C:     dc.b $1C, $B, $18, $11, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F5FE   o
byte_1FA29:     dc.b $10, $16, $B, $17, $F, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F602   o
byte_1FA35:     dc.b $12, $19, $17, $13, $18, $11, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F606   o
byte_1FA42:     dc.b $1D, $21, $19, $1C, $E, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F60A   o
byte_1FA4E:     dc.b $16, $B, $18, $D, $F, $1C, 0, $10, $19, $1C, $D, $F, $FF
                                        ; DATA XREF: ROM:0001F60E   o
byte_1FA5B:     dc.b $1D, $12, $19, $19, $1E, $13, $18, $11, 0, $17, $19, $E, $F, $FF
                                        ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F63E   o
byte_1FA69:     dc.b $17, $19, $20, $13, $18, $11, $FF
                                        ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F65C   o
byte_1FA70:     dc.b $10, $13, $22, $FF ; DATA XREF: UI_RenderTitleMenuOptions:loc_1F67A   o
byte_1FA74:     dc.b $1D, $1E, $B, $1E, $1F, $1D, 0, $21, $13, $18, $E, $19, $21, $FF
                                        ; DATA XREF: UI_RenderControlsText:loc_1F69A   o
byte_1FA82:     dc.b $1E, $23, $1A, $F, $2E, 2, 0, $FF
                                        ; DATA XREF: ROM:off_1F2D2   o
byte_1FA8A:     dc.b $1E, $23, $1A, $F, $2E, 3, 0, $FF
                                        ; DATA XREF: ROM:0001F2D6   o
byte_1FA92:     dc.b $1E, $23, $1A, $F, $2E, 4, 0, $FF
                                        ; DATA XREF: ROM:0001F2DA   o
byte_1FA9A:     dc.b $1E, $23, $1A, $F, $2E, 5, 0, $FF
                                        ; DATA XREF: ROM:0001F2DE   o
byte_1FAA2:     dc.b $1E, $23, $1A, $F, $2E, 6, 0, $FF
                                        ; DATA XREF: ROM:0001F2E2   o
byte_1FAAA:     dc.b $1E, $23, $1A, $F, $2E, 7, 0, $FF
                                        ; DATA XREF: ROM:0001F2E6   o
byte_1FAB2:     dc.b $1E, $23, $1A, $F, $2E, 8, 0, $FF
                                        ; DATA XREF: ROM:0001F2EA   o
byte_1FABA:     dc.b $1E, $23, $1A, $F, $2E, 9, 0, $FF
                                        ; DATA XREF: ROM:0001F2EE   o
byte_1FAC2:     dc.b $1E, $23, $1A, $F, $2E, $A, 0, $FF
                                        ; DATA XREF: ROM:0001F2F2   o
byte_1FACA:     dc.b $1E, $23, $1A, $F, $2E, 2, 1, $FF
                                        ; DATA XREF: ROM:0001F2F6   o
byte_1FAD2:     dc.b $1E, $23, $1A, $F, $2E, 2, 2, $FF
                                        ; DATA XREF: ROM:0001F2FA   o
byte_1FADA:     dc.b $1E, $23, $1A, $F, $2E, 2, 3, $FF
                                        ; DATA XREF: ROM:0001F2FE   o
byte_1FAE2:     dc.b $1E, $23, $1A, $F, $2E, 2, 4, $FF
                                        ; DATA XREF: ROM:0001F302   o
byte_1FAEA:     dc.b $1E, $23, $1A, $F, $2E, 2, 5, $FF
                                        ; DATA XREF: ROM:0001F306   o
byte_1FAF2:     dc.b $1E, $23, $1A, $F, $2E, 2, 6, $FF
                                        ; DATA XREF: ROM:0001F30A   o
byte_1FAFA:     dc.b $1E, $23, $1A, $F, $2E, 2, 7, $FF
                                        ; DATA XREF: ROM:0001F30E   o
byte_1FB02:     dc.b $1E, $23, $1A, $F, $2E, 2, 8, $FF
                                        ; DATA XREF: ROM:0001F312   o
byte_1FB0A:     dc.b $1E, $23, $1A, $F, $2E, 2, 9, $FF
                                        ; DATA XREF: ROM:0001F316   o
byte_1FB12:     dc.b $1E, $23, $1A, $F, $2E, 2, $A, $FF
                                        ; DATA XREF: ROM:0001F31A   o
byte_1FB1A:     dc.b $1E, $23, $1A, $F, $2E, 3, 1, $FF
                                        ; DATA XREF: ROM:0001F31E   o
byte_1FB22:     dc.b $1E, $23, $1A, $F, $2E, 3, 2, $FF
                                        ; DATA XREF: ROM:0001F322   o
byte_1FB2A:     dc.b $1E, $23, $1A, $F, $2E, 3, 3, $FF
                                        ; DATA XREF: ROM:0001F326   o
byte_1FB32:     dc.b $1E, $23, $1A, $F, $2E, 3, 4, $FF
                                        ; DATA XREF: ROM:0001F32A   o
byte_1FB3A:     dc.b $1E, $23, $1A, $F, $2E, 3, 5, $FF
                                        ; DATA XREF: ROM:0001F32E   o
byte_1FB42:     dc.b $1E, $23, $1A, $F, $2E, 3, 6, $FF
                                        ; DATA XREF: ROM:0001F332   o
byte_1FB4A:     dc.b $1E, $23, $1A, $F, $2E, 3, 7, $FF
                                        ; DATA XREF: ROM:0001F336   o
byte_1FB52:     dc.b $F, $22, $13, $1E, $FF
                                        ; DATA XREF: UI_RenderSoundText:loc_1F710   o
byte_1FB57:     dc.b $D, $19, $18, $1E, $1C, $19, $16, 0, $1E, $F, $1D, $1E, $FF
                                        ; DATA XREF: ROM:stru_1F424   o
byte_1FB64:     dc.b $21, $F, $B, $1A, $19, $18, 0, $1D, $F, $16, $F, $D, $1E, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F42C   o
                dc.b $E0, $E1, $FF
byte_1FB77:     dc.b $1D, $12, $19, $1E, 0, $2E, 0, $E2, $E3, $FF
                                        ; DATA XREF: ROM:0001F434   o
byte_1FB81:     dc.b $14, $1F, $17, $1A, 0, $2E, 0, $E4, $E5, $FF
                                        ; DATA XREF: ROM:0001F43C   o
byte_1FB8B:     dc.b $1D, $12, $19, $19, $1E, 0, $17, $19, $E, $F, 0, $D, $12, $B, $18, $11
                                        ; DATA XREF: ROM:0001F444   o
                dc.b $F, 0, $2E, 0, $E6, $E7, 0, $E8, 0, $E0, $E1, $FF
byte_1FBA7:     dc.b $24, $F, $1C, $19, 0, $1E, $F, $16, $F, $1A, $19, $1C, $1E, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F44C   o
                dc.b $E6, $E7, 0, $E8, 0, $E4, $E5, $FF
byte_1FBBF:     dc.b $D, $19, $1F, $18, $1E, $F, $1C, 0, $10, $19, $1C, $D, $F, 0, $2E, 0
                                        ; DATA XREF: ROM:0001F454   o
                dc.b $E2, $E3, 0, $E8, 0, $E2, $E3, $FF
byte_1FBD7:     dc.b $12, $19, $20, $F, $1C, $13, $18, $11, 0, $2E, 0, $14, $1F, $17, $1A, 0
                                        ; DATA XREF: ROM:0001F45C   o
                dc.b $E8, 0, $E4, $E5, $FF


; Checks if player pressed button to skip results
Results_CheckSkipButton:                              ; CODE XREF: Results_HandleCompletion+4   p  ; was: sub_1FBEC
                                        ; Results_MainLoop+A   p
                bsr.s Results_DispatchHandler
                move.w  (dword_FFA900).w,(dword_FFA908).w
                tst.w   (word_FF9442).w
                beq.s   locret_1FC0C
                btst    #7,(word_FFF708).w
                beq.s   locret_1FC0C
                move.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
locret_1FC0C:                           ; CODE XREF: Results_CheckSkipButton+C   j
                                        ; Results_CheckSkipButton+14   j
                rts
; End of function Results_CheckSkipButton
; Dispatches results screen handler by state
Results_DispatchHandler:                              ; CODE XREF: Results_CheckSkipButton   p  ; was: sub_1FC0E
                move.w  (dword_FF9400).w,d0
                lea     off_1FC1A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Results_DispatchHandler
; ---------------------------------------------------------------------------
off_1FC1A:      dc.w Results_InitializeDataDisplay-*        ; DATA XREF: Results_DispatchHandler+4   o
                dc.w UI_RenderResultsDataRow-*
                dc.w UI_ScrollResultsScreen-*
                dc.w UI_RenderResultsRowWithScroll-*
                dc.w UI_CompleteResultsScroll-*
                dc.w UI_WaitForResultsTransition-*


; Initializes results data display with score breakdown
Results_InitializeDataDisplay:                              ; DATA XREF: ROM:off_1FC1A   o  ; was: sub_1FC26
                addq.w  #2,(dword_FF9400).w
                move.w  #1,d0
                move.w  (word_FFFF46).w,(word_FF9442).w
                clr.w   (word_FFFF46).w
                tst.w   (word_FF9442).w
                bne.s   loc_1FC50
                tst.w   d0
                bne.s   loc_1FC50
                move.w  #$13,(dword_FF943C+2).w
                move.w  #$FF40,(dword_FF943C).w
                bra.s   loc_1FC5C
; ---------------------------------------------------------------------------
loc_1FC50:                              ; CODE XREF: Results_InitializeDataDisplay+16   j
                                        ; Results_InitializeDataDisplay+1A   j
                move.w  #$17,(dword_FF943C+2).w
                move.w  #$FEF0,(dword_FF943C).w
loc_1FC5C:                              ; CODE XREF: Results_InitializeDataDisplay+28   j
                move.w  #$50,(dword_FFA90C).w ; 'P'
                move.w  #$F0,(dword_FFA904).w
                clr.w   (dword_FFA900).w
                move.w  #$18,d7
                lea     ((dword_FF944E+2)).w,a0
                lea     (word_1CE4C).l,a1
                lea     (word_FFAA00).w,a2
                lea     (word_FFAA80).w,a3
                lea     (word_FFAB00).w,a4
                moveq   #1,d5
                moveq   #0,d6
loc_1FC8A:                              ; CODE XREF: Results_InitializeDataDisplay+190   j
                sub.w   d4,d4
                abcd    d5,d6
                move.w  d6,d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                move.w  (dword_FF9400+2).w,d0
                addq.w  #2,(dword_FF9400+2).w
                cmp.w   (StageTableIndex).w,d0
                bhi.s   loc_1FCCC
                tst.w   (a2)
                bpl.s   loc_1FCB4
                cmp.w   (StageTableIndex).w,d0
                bne.s   loc_1FCCC
loc_1FCB4:                              ; CODE XREF: Results_InitializeDataDisplay+86   j
                move.w  (a1),(dword_FF9408+2).w
                move.b  (a1),d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WritePercentSign
                move.b  1(a1),d0
                bsr.w UI_ConvertBCDToDigits
                bra.s   loc_1FCE0
; ---------------------------------------------------------------------------
loc_1FCCC:                              ; CODE XREF: Results_InitializeDataDisplay+82   j
                                        ; Results_InitializeDataDisplay+8C   j
                bsr.w UI_WriteAsterisk
                bsr.w UI_WriteAsterisk
                bsr.w UI_WritePercentSign
                bsr.w UI_WriteAsterisk
                bsr.w UI_WriteAsterisk
loc_1FCE0:                              ; CODE XREF: Results_InitializeDataDisplay+A4   j
                addq.w  #2,a1
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                move.w  (a2)+,(dword_FF940C).w
                bmi.s   loc_1FD02
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C).w,(dword_FF9410).w
                bsr.w UI_FormatTimeDifference
                bra.s   loc_1FD16
; ---------------------------------------------------------------------------
loc_1FD02:                              ; CODE XREF: Results_InitializeDataDisplay+C8   j
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
loc_1FD16:                              ; CODE XREF: Results_InitializeDataDisplay+DA   j
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                move.w  (a3)+,(dword_FF940C+2).w
                bmi.s   loc_1FD36
                move.w  (dword_FF940C).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w UI_FormatTimeDifference
                bra.s   loc_1FD4A
; ---------------------------------------------------------------------------
loc_1FD36:                              ; CODE XREF: Results_InitializeDataDisplay+FC   j
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
loc_1FD4A:                              ; CODE XREF: Results_InitializeDataDisplay+10E   j
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                tst.w   (dword_FF940C+2).w
                bmi.s   loc_1FD6A
                move.w  (dword_FF9408+2).w,(dword_FF9410+2).w
                move.w  (dword_FF940C+2).w,(dword_FF9410).w
                bsr.w UI_FormatTimeDifference
                bra.s   loc_1FD7E
; ---------------------------------------------------------------------------
loc_1FD6A:                              ; CODE XREF: Results_InitializeDataDisplay+130   j
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
                bsr.w UI_WritePercentSign
                move.b  #$FF,d0
                bsr.w UI_ConvertBCDToDigits
loc_1FD7E:                              ; CODE XREF: Results_InitializeDataDisplay+142   j
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                move.w  (a4)+,d0
                bpl.s   loc_1FD90
                tst.w   -2(a3)
                bmi.s   loc_1FDA6
loc_1FD90:                              ; CODE XREF: Results_InitializeDataDisplay+162   j
                addq.w  #1,d0
                movem.w a0,-(sp)
                lea     (word_5A43E).l,a0
                add.w   d0,d0
                move.w  (a0,d0.w),d0
                movem.w (sp)+,a0
loc_1FDA6:                              ; CODE XREF: Results_InitializeDataDisplay+168   j
                bsr.w UI_ConvertBCDWordToDigits
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteNullByte
                bsr.w UI_WriteEndMarker
                dbf     d7,loc_1FC8A
                move.w  #5,d6
loc_1FDBE:                              ; CODE XREF: Results_InitializeDataDisplay+1A8   j
                move.w  #$24,d7 ; '$'
loc_1FDC2:                              ; CODE XREF: Results_InitializeDataDisplay+1A0   j
                bsr.w UI_WriteNullByte
                dbf     d7,loc_1FDC2
                bsr.w UI_WriteEndMarker
                dbf     d6,loc_1FDBE
                bsr.w UI_PrepareResultsData
                clr.w   (dword_FF9400+2).w
                clr.w   (dword_FF9404).w
                clr.w   (dword_FF9404+2).w
                clr.w   (dword_FF9408).w
                clr.w   (dword_FF9424).w
                rts
; End of function Results_InitializeDataDisplay
; Renders a single row of results screen data with time/percentage display
UI_RenderResultsDataRow:                              ; DATA XREF: ROM:0001FC1C   o  ; was: sub_1FDEC
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9404+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  #$4006,d4
                add.w   (dword_FF9404).w,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   (dword_FF9400+2).w,d3
                beq.s   loc_1FE2C
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_1FE1A
                move.w  #$2300,d0
                bra.s   loc_1FE1E
; ---------------------------------------------------------------------------
loc_1FE1A:                              ; CODE XREF: UI_RenderResultsDataRow+26   j
                move.w  #$4300,d0
loc_1FE1E:                              ; CODE XREF: UI_RenderResultsDataRow+2C   j
                cmp.w   (dword_FF9418).w,d4
                bne.s   loc_1FE40
                move.w  #$FFFF,(dword_FF9418).w
                bra.s   loc_1FE40
; ---------------------------------------------------------------------------
loc_1FE2C:                              ; CODE XREF: UI_RenderResultsDataRow+1E   j
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
loc_1FE40:                              ; CODE XREF: UI_RenderResultsDataRow+36   j
                                        ; UI_RenderResultsDataRow+3E   j
                jsr (UI_RenderTextStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0 ; '"'
                bne.s   loc_1FE6E
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_1FE62
                move.w  #$2300,d0
                bra.s   loc_1FE66
; ---------------------------------------------------------------------------
loc_1FE62:                              ; CODE XREF: UI_RenderResultsDataRow+6E   j
                move.w  #$4300,d0
loc_1FE66:                              ; CODE XREF: UI_RenderResultsDataRow+74   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_1FE7C
; ---------------------------------------------------------------------------
loc_1FE6E:                              ; CODE XREF: UI_RenderResultsDataRow+66   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_1FE7C:                              ; CODE XREF: UI_RenderResultsDataRow+80   j
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr (UI_RenderTextStringWrapped).l
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w ; '&'
                addi.w  #$16,(dword_FF941C+2).w
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$A,(dword_FF9400+2).w
                bcs.s   locret_1FEAC
                addq.w  #2,(dword_FF9400).w
locret_1FEAC:                           ; CODE XREF: UI_RenderResultsDataRow+BA   j
                rts
; End of function UI_RenderResultsDataRow
; Handles vertical scrolling of results screen with position updates
UI_ScrollResultsScreen:                              ; DATA XREF: ROM:0001FC1E   o  ; was: sub_1FEAE
                subq.w  #2,(dword_FFA90C).w
                subq.w  #2,(dword_FFA904).w
                cmpi.w  #$90,(dword_FFA904).w
                bne.s   locret_1FEE0
                addq.w  #2,(dword_FF9400).w
                tst.w   (word_FF9442).w
                bne.s   loc_1FEDA
                move.w  (StageTableIndex).w,d0
                lsl.w   #3,d0
                neg.w   d0
                addi.w  #$90,d0
                move.w  d0,(dword_FF9408).w
                rts
; ---------------------------------------------------------------------------
loc_1FEDA:                              ; CODE XREF: UI_ScrollResultsScreen+18   j
                move.w  #$FEF0,(dword_FF9408).w
locret_1FEE0:                           ; CODE XREF: UI_ScrollResultsScreen+E   j
                rts
; End of function UI_ScrollResultsScreen
; Renders results data row while handling screen scroll position
UI_RenderResultsRowWithScroll:                              ; DATA XREF: ROM:0001FC20   o  ; was: sub_1FEE2
                bsr.w UI_CheckResultsScoreReached
                move.w  (dword_FF9408).w,d0
                cmp.w   (dword_FFA904).w,d0
                beq.s   loc_1FEF4
                subq.w  #2,(dword_FFA904).w
loc_1FEF4:                              ; CODE XREF: UI_RenderResultsRowWithScroll+C   j
                lea     ((dword_FF944E+2)).w,a0
                adda.w  (dword_FF9404+2).w,a0
                move.w  a0,(dword_FF9420+2).w
                move.w  #$4006,d4
                add.w   (dword_FF9404).w,d4
                move.w  (StageTableIndex).w,d3
                lsr.w   #1,d3
                cmp.w   (dword_FF9400+2).w,d3
                beq.s   loc_1FF28
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_1FF22
                move.w  #$2300,d0
                bra.s   loc_1FF3C
; ---------------------------------------------------------------------------
loc_1FF22:                              ; CODE XREF: UI_RenderResultsRowWithScroll+38   j
                move.w  #$4300,d0
                bra.s   loc_1FF3C
; ---------------------------------------------------------------------------
loc_1FF28:                              ; CODE XREF: UI_RenderResultsRowWithScroll+30   j
                move.w  #$6300,d0
                move.w  (dword_FF9404+2).w,(dword_FF9414+2).w
                move.w  (dword_FF941C+2).w,(dword_FF9420).w
                move.w  d4,(dword_FF9418).w
loc_1FF3C:                              ; CODE XREF: UI_RenderResultsRowWithScroll+3E   j
                                        ; UI_RenderResultsRowWithScroll+44   j
                jsr (UI_RenderTextStringWrapped).l
                movea.w (dword_FF9420+2).w,a0
                move.b  $B(a0),d0
                cmpi.b  #$22,d0 ; '"'
                bne.s   loc_1FF6A
                cmpi.b  #$2A,4(a0) ; '*'
                bne.s   loc_1FF5E
                move.w  #$2300,d0
                bra.s   loc_1FF62
; ---------------------------------------------------------------------------
loc_1FF5E:                              ; CODE XREF: UI_RenderResultsRowWithScroll+74   j
                move.w  #$4300,d0
loc_1FF62:                              ; CODE XREF: UI_RenderResultsRowWithScroll+7A   j
                lea     word_20650(pc),a0
                nop
                bra.s   loc_1FF78
; ---------------------------------------------------------------------------
loc_1FF6A:                              ; CODE XREF: UI_RenderResultsRowWithScroll+6C   j
                move.w  #$6300,d0
                lea     word_20666(pc),a0
                nop
                adda.w  (dword_FF941C+2).w,a0
loc_1FF78:                              ; CODE XREF: UI_RenderResultsRowWithScroll+86   j
                move.w  #$4050,d4
                add.w   (dword_FF9404).w,d4
                jsr (UI_RenderTextStringWrapped).l
                addi.w  #$16,(dword_FF941C+2).w
                addi.w  #$100,(dword_FF9404).w
                addi.w  #$26,(dword_FF9404+2).w ; '&'
                addq.w  #1,(dword_FF9400+2).w
                cmpi.w  #$10,(dword_FF9400+2).w
                bcs.s   locret_1FFA8
                addq.w  #2,(dword_FF9400).w
locret_1FFA8:                           ; CODE XREF: UI_RenderResultsRowWithScroll+C0   j
                rts
; End of function UI_RenderResultsRowWithScroll
; Completes results screen scroll animation and advances state
UI_CompleteResultsScroll:                              ; DATA XREF: ROM:0001FC22   o  ; was: sub_1FFAA
                bsr.w UI_CheckResultsScoreReached
                bsr.s UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   loc_1FFC4
                bsr.s UI_CheckResultsScrollBounds
                tst.w   (dword_FF941C).w
                beq.s   loc_1FFC4
                bsr.w UI_RenderResultsCursor
                rts
; ---------------------------------------------------------------------------
loc_1FFC4:                              ; CODE XREF: UI_CompleteResultsScroll+A   j
                                        ; UI_CompleteResultsScroll+12   j
                addq.w  #2,(dword_FF9400).w
                rts
; End of function UI_CompleteResultsScroll
; Checks if results screen scroll position is within valid bounds
UI_CheckResultsScrollBounds:                              ; CODE XREF: UI_CompleteResultsScroll+4   p  ; was: sub_1FFCA
                                        ; UI_CompleteResultsScroll+C   p
                move.w  (dword_FF9408).w,d0
                cmp.w   (dword_FFA904).w,d0
                beq.s   loc_1FFEA
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                ble.s   loc_1FFEA
                move.w  #$FFFF,(dword_FF941C).w
                bsr.w UI_UpdateResultsViewport
                rts
; ---------------------------------------------------------------------------
loc_1FFEA:                              ; CODE XREF: UI_CheckResultsScrollBounds+8   j
                                        ; UI_CheckResultsScrollBounds+12   j
                clr.w   (dword_FF941C).w
                rts
; End of function UI_CheckResultsScrollBounds
; Checks if results screen scroll reached score threshold and plays sound
UI_CheckResultsScoreReached:                              ; CODE XREF: UI_RenderResultsRowWithScroll   p  ; was: sub_1FFF0
                                        ; sub_1FFAA   p
                tst.w   (dword_FF9424).w
                bne.s   locret_20014
                move.w  (dword_FF9408).w,d0
                addi.w  #$48,d0 ; 'H'
                cmp.w   (dword_FFA904).w,d0
                blt.s   locret_20014
                move.w  #1,(dword_FF9424).w
                move.b  #$85,d0
                jsr (Sound_PlaySFX).l
locret_20014:                           ; CODE XREF: UI_CheckResultsScoreReached+4   j
                                        ; UI_CheckResultsScoreReached+12   j
                rts
; End of function UI_CheckResultsScoreReached
; Waits for results screen transition with double call pattern
UI_WaitForResultsTransition:                              ; DATA XREF: ROM:0001FC24   o  ; was: sub_20016
                bsr.w Input_HandleResultsNavigation
                bsr.w Input_HandleResultsNavigation
                bsr.w UI_RenderResultsCursor
                rts
; End of function UI_WaitForResultsTransition
; Handles D-pad input and navigation for results screen browsing
Input_HandleResultsNavigation:                              ; CODE XREF: UI_WaitForResultsTransition   p  ; was: sub_20024
                                        ; UI_WaitForResultsTransition+4   p
                btst    #2,(word_FFF706).w
                beq.s   loc_2004C
                move.w  (dword_FFA900).w,d0
                addi.w  #-1,d0
                cmpi.w  #0,d0
                blt.s   loc_20074
                move.w  #1,(dword_FF9438+2).w
                move.w  #$FFFF,(dword_FF9418+2).w
                addi.w  #-1,(dword_FFA900).w
loc_2004C:                              ; CODE XREF: Input_HandleResultsNavigation+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_2008C
                move.w  (dword_FFA900).w,d0
                addq.w  #1,d0
                cmpi.w  #$D0,d0
                bgt.s   loc_20074
                move.w  #1,(dword_FF9438+2).w
                move.w  #1,(dword_FF9418+2).w
                addi.w  #1,(dword_FFA900).w
                bra.s   loc_2008C
; ---------------------------------------------------------------------------
loc_20074:                              ; CODE XREF: Input_HandleResultsNavigation+14   j
                                        ; Input_HandleResultsNavigation+3A   j
                tst.w   (dword_FF9438+2).w
                beq.s   loc_20088
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr (Sound_PlaySFX).l
loc_20088:                              ; CODE XREF: Input_HandleResultsNavigation+54   j
                clr.w   (dword_FF9418+2).w
loc_2008C:                              ; CODE XREF: Input_HandleResultsNavigation+2E   j
                                        ; Input_HandleResultsNavigation+4E   j
                btst    #0,(word_FFF706).w
                beq.s   loc_200A8
                move.w  (dword_FFA904).w,d0
                addq.w  #1,d0
                cmpi.w  #$90,d0
                bgt.s   loc_200CA
                move.w  #1,(dword_FF941C).w
                bra.s   loc_200C4
; ---------------------------------------------------------------------------
loc_200A8:                              ; CODE XREF: Input_HandleResultsNavigation+6E   j
                btst    #1,(word_FFF706).w
                beq.w   loc_200D0
                move.w  (dword_FFA904).w,d0
                subq.w  #1,d0
                cmp.w   (dword_FF943C).w,d0
                blt.s   loc_200CA
                move.w  #$FFFF,(dword_FF941C).w
loc_200C4:                              ; CODE XREF: Input_HandleResultsNavigation+82   j
                bsr.w UI_UpdateResultsViewport
                rts
; ---------------------------------------------------------------------------
loc_200CA:                              ; CODE XREF: Input_HandleResultsNavigation+7A   j
                                        ; Input_HandleResultsNavigation+98   j
                clr.w   (dword_FF941C).w
                rts
; ---------------------------------------------------------------------------
loc_200D0:                              ; CODE XREF: Input_HandleResultsNavigation+8A   j
                tst.w   (dword_FF9418+2).w
                beq.s   loc_2012C
                move.w  (dword_FF9418+2).w,d0
                add.w   d0,(dword_FFA900).w
                move.w  (dword_FFA900).w,d0
                andi.w  #$F,d0
                bne.s   loc_2012C
                tst.w   (dword_FFA900).w
                beq.s   loc_2010E
                cmpi.w  #$30,(dword_FFA900).w ; '0'
                beq.s   loc_2010E
                cmpi.w  #$60,(dword_FFA900).w ; '`'
                beq.s   loc_2010E
                cmpi.w  #$A0,(dword_FFA900).w
                beq.s   loc_2010E
                cmpi.w  #$D0,(dword_FFA900).w
                bne.s   loc_2012C
loc_2010E:                              ; CODE XREF: Input_HandleResultsNavigation+C8   j
                                        ; Input_HandleResultsNavigation+D0   j ...
                tst.b   (word_FFF706).w
                bne.s   loc_20128
                tst.w   (dword_FF9438+2).w
                beq.s   loc_20128
                clr.w   (dword_FF9438+2).w
                move.b  #$DB,d0
                jsr (Sound_PlaySFX).l
loc_20128:                              ; CODE XREF: Input_HandleResultsNavigation+EE   j
                                        ; Input_HandleResultsNavigation+F4   j
                clr.w   (dword_FF9418+2).w
loc_2012C:                              ; CODE XREF: Input_HandleResultsNavigation+B0   j
                                        ; Input_HandleResultsNavigation+C2   j ...
                cmpi.w  #$D0,(dword_FFA900).w
                blt.s   loc_2013E
                move.w  #$D0,(dword_FFA900).w
                clr.w   (dword_FF9418+2).w
loc_2013E:                              ; CODE XREF: Input_HandleResultsNavigation+10E   j
                cmpi.w  #0,(dword_FFA900).w
                bgt.s   loc_20150
                move.w  #0,(dword_FFA900).w
                clr.w   (dword_FF9418+2).w
loc_20150:                              ; CODE XREF: Input_HandleResultsNavigation+120   j
                tst.w   (dword_FF941C).w
                beq.s   loc_20168
                bsr.w UI_UpdateResultsViewport
                move.w  (dword_FFA904).w,d0
                andi.w  #$F,d0
                bne.s   loc_20168
                clr.w   (dword_FF941C).w
loc_20168:                              ; CODE XREF: Input_HandleResultsNavigation+130   j
                                        ; Input_HandleResultsNavigation+13E   j
                cmpi.w  #$90,(dword_FFA904).w
                blt.s   loc_2017A
                move.w  #$90,(dword_FFA904).w
                clr.w   (dword_FF941C).w
loc_2017A:                              ; CODE XREF: Input_HandleResultsNavigation+14A   j
                move.w  (dword_FFA904).w,d0
                cmp.w   (dword_FF943C).w,d0
                bgt.s   locret_2018E
                move.w  (dword_FF943C).w,(dword_FFA904).w
                clr.w   (dword_FF941C).w
locret_2018E:                           ; CODE XREF: Input_HandleResultsNavigation+15E   j
                rts
; End of function Input_HandleResultsNavigation
; Writes end marker (0xFF) to UI text buffer
