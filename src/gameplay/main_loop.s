Sys_GameplayMainLoop:                                   ; DATA XREF: Sys_DispatchGameState+66   o  ; was: sub_1C65C
                bsr.w   nullsub_2
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C672
                move.w  #$C7F0,(word_FF8110).w
                move.w  #$20,(word_FF8112).w            ; ' '
loc_1C672:                                              ; CODE XREF: Sys_GameplayMainLoop+8   j
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C68A
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$822,(VDP_DATA).l
loc_1C68A:                                              ; CODE XREF: Sys_GameplayMainLoop+1A   j
                bsr.w   Gfx_UpdateScrollPosition
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6A6
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
loc_1C6A6:                                              ; CODE XREF: Sys_GameplayMainLoop+36   j
                jsr     (Boss_UpdateCollisionSystem).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6C4
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C6C4:                                              ; CODE XREF: Sys_GameplayMainLoop+54   j
                jsr     (Sys_InitObjectPointers).l
                bsr.w   UI_CheckVBlankFlag
                bsr.w   UI_SetWeaponIconIndex
                jsr     (Gfx_PrimaryEffectDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C6F0
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
loc_1C6F0:                                              ; CODE XREF: Sys_GameplayMainLoop+80   j
                jsr     (Physics_ApplyFriction).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C70E
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E0,(VDP_DATA).l
loc_1C70E:                                              ; CODE XREF: Sys_GameplayMainLoop+9E   j
                jsr     (Player_Update).l
                jsr     (UI_UpdateWeaponDisplay).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C732
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C732:                                              ; CODE XREF: Sys_GameplayMainLoop+C2   j
                jsr     (Sys_UpdateObjectSpawner).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C750
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E00,(VDP_DATA).l
loc_1C750:                                              ; CODE XREF: Sys_GameplayMainLoop+E0   j
                jsr     (Sys_ProcessProjectiles).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C76E
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C76E:                                              ; CODE XREF: Sys_GameplayMainLoop+FE   j
                jsr     (Boss_JetsripperMoveLeft).l
                jsr     (Effect_PaletteDispatcher).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C792
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C792:                                              ; CODE XREF: Sys_GameplayMainLoop+122   j
                jsr     (Stage_ProcessHandler).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C7B0
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$EEE,(VDP_DATA).l
loc_1C7B0:                                              ; CODE XREF: Sys_GameplayMainLoop+140   j
                jsr     (Gfx_SecondaryEffectDispatcher).l
                bsr.w   Sys_UpdateObjectCount
                jsr     (Player_BehaviorDispatcher).l
                jsr     (UI_RenderHUDElement1).l
                bsr.w   Effect_ScreenShakeUpdate
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C7E2
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #$E,(VDP_DATA).l
loc_1C7E2:                                              ; CODE XREF: Sys_GameplayMainLoop+172   j
                jsr     (Sys_ProcessObjectList).l
                tst.b   (byte_FFF746).w
                bpl.s   loc_1C800
                move.l  #$C0420000,(VDP_CTRL).l
                move.w  #0,(VDP_DATA).l
loc_1C800:                                              ; CODE XREF: Sys_GameplayMainLoop+190   j
                jsr     (Gfx_FadePaletteTransition).l
                bclr    #0,(word_FF80F4).w
                beq.s   loc_1C816
loc_1C80E:                                              ; CODE XREF: Sys_GameplayMainLoop+1C6   j
                move.b  #$41,(byte_FFF705).w            ; 'A'
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C816:                                              ; CODE XREF: Sys_GameplayMainLoop+1B0   j
                bclr    #1,(word_FF80F4).w
                beq.s   loc_1C860
                move.w  (word_FF8230).w,d0
                beq.s   loc_1C80E
                clr.w   (word_FFA21E).w
                cmpi.w  #1,d0
                bne.s   loc_1C844
                move.w  #$2C,(GameModeIndex).w          ; ','
                clr.w   (GameSubstateIndex).w
                move.b  #4,d0
                jsr     (Sound_PlaySFX).l
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C844:                                              ; CODE XREF: Sys_GameplayMainLoop+1D0   j
                cmpi.w  #3,d0
                bne.s   loc_1C856
                move.w  #$34,(GameModeIndex).w          ; '4'
                clr.w   (GameSubstateIndex).w
                bra.s   loc_1C860
; ---------------------------------------------------------------------------
loc_1C856:                                              ; CODE XREF: Sys_GameplayMainLoop+1EC   j
                move.w  #$68,(GameModeIndex).w          ; 'h'
                clr.w   (GameSubstateIndex).w
loc_1C860:                                              ; CODE XREF: Sys_GameplayMainLoop+1B8   j
                                        ; Sys_GameplayMainLoop+1C0   j
                tst.b   (byte_FFF705).w
                bmi.s   loc_1C884
                addq.w  #1,(word_FFA000).w
                subq.w  #1,(word_FF813C).w
                bpl.s   loc_1C87C
                move.w  #$FFFF,(word_FF813C).w
                move.b  #0,d0
                bra.s   loc_1C880
; ---------------------------------------------------------------------------
loc_1C87C:                                              ; CODE XREF: Sys_GameplayMainLoop+212   j
                move.b  #$80,d0
loc_1C880:                                              ; CODE XREF: Sys_GameplayMainLoop+21E   j
                move.b  d0,(byte_FF813E).w
loc_1C884:                                              ; CODE XREF: Sys_GameplayMainLoop+208   j
                move.b  (byte_FFF705).w,d0
                or.b    d0,(byte_FF813E).w
                jmp     (Gfx_ClearBackgroundColor).l
; End of function Sys_GameplayMainLoop
; Set game state to $40
Sys_SetState40:
                move.w  #$40,(GameModeIndex).w          ; '@'  ; was: sub_1C892
                clr.w   (GameSubstateIndex).w
                rts
; End of function Sys_SetState40
; Set game state to $3C with input
Sys_SetState3CWithInput:
                move.w  #$3C,(GameModeIndex).w          ; '<'  ; was: sub_1C89E
                clr.w   (GameSubstateIndex).w
                move.b  #1,d0
                jmp     (Input_ProcessButtons).l
; End of function Sys_SetState3CWithInput
; Sets weapon icon index from weapon ID lookup
UI_SetWeaponIconIndex:                                  ; CODE XREF: Sys_GameplayMainLoop+72   p  ; was: sub_1C8B2
                move.w  (StageTableIndex).w,d0
                asr.w   #1,d0
                move.b  byte_1C8C0(pc,d0.w),(byte_FF8232).w
                rts
; End of function UI_SetWeaponIconIndex
; ---------------------------------------------------------------------------
byte_1C8C0:     dc.b    1, 2, 3, 4, 5, 6, 7, 8, 9, $10
                                        ; DATA XREF: UI_SetWeaponIconIndex+6   r
                dc.b    $11, $12, $13, $14, $15, $16, $17, $18, $19, $20
                dc.b    $21, $22, $23, $24, $25, $26, $27, $28, $29, $30
                dc.b    $31, $32, $33, $34, $35, $36, $37, $38, $39, $40
                dc.b    $41, $42, $43, $44, $45, $46, $47, $48, $49, $50

; Checks VBlank flag and conditionally writes VDP value
UI_CheckVBlankFlag:                                     ; CODE XREF: Sys_StoryScreenMainLoop+2C   p  ; was: sub_1C8F2
                                        ; UI_UpdateOptionsScreen+52   p
                tst.b   (byte_FF813E).w
                bmi.w   locret_1C900
                move.w  #$ED00,(word_FFF758).w
locret_1C900:                                           ; CODE XREF: UI_CheckVBlankFlag+4   j
                rts
; End of function UI_CheckVBlankFlag
; Calculates number of active visible objects from list pointer
Sys_UpdateObjectCount:                                  ; CODE XREF: Sys_StoryScreenMainLoop+44   p  ; was: sub_1C902
                                        ; UI_UpdateOptionsScreen+62   p
                tst.b   (byte_FF813E).w
                bmi.w   locret_1C918
                move.w  (word_FFF758).w,d0
                subi.w  #$ED00,d0
                lsr.w   #1,d0
                move.w  d0,(word_FFF75A).w
locret_1C918:                                           ; CODE XREF: Sys_UpdateObjectCount+4   j
                rts
; End of function Sys_UpdateObjectCount
; Display pause menu graphics
UI_DisplayPauseGraphics:
                move.b  (byte_FFF705).w,d0              ; was: sub_1C91A
                bpl.w   locret_1C944
                btst    #6,d0
                beq.w   locret_1C944
                move.b  (word_FFF706).w,d0
                or.b    (word_FFF706+1).w,d0
                andi.b  #$40,d0                         ; '@'
                bne.w   locret_1C944
                btst    #4,(word_FFA280+1).w
                bne.w   loc_1C946
locret_1C944:                                           ; CODE XREF: UI_DisplayPauseGraphics+4   j
                                        ; UI_DisplayPauseGraphics+C   j
                rts
; ---------------------------------------------------------------------------
loc_1C946:                                              ; CODE XREF: UI_DisplayPauseGraphics+26   j
                lea     (dword_FFA100).w,a0
                movea.w a0,a1
                move.l  #byte_A00C00,(a1)+
                move.w  #$C7EB,(a1)+
                move.w  #$C0,(a1)+
                move.l  #Z80_RAM,(a1)+
                move.w  #$C7EF,(a1)+
                move.w  #$E0,(a1)+
                move.w  #$FFFF,(a1)
                jmp     (Sprite_AddToOAMBuffer).l
; End of function UI_DisplayPauseGraphics
; ---------------------------------------------------------------------------
word_1C972:     dc.w    0, $800, $1800, $1000
                                        ; DATA XREF: Gfx_UpdateScrollPosition:loc_1C982   o
                                        ; Boss_StateDispatcher+7C   o

; Updates camera scroll position based on player
Gfx_UpdateScrollPosition:                               ; CODE XREF: Sys_StoryScreenMainLoop:loc_491C   p  ; was: sub_1C97A
                                        ; UI_UpdateOptionsScreen+46   p
                tst.b   (byte_FF813E).w
                bpl.s   loc_1C982
                rts
; ---------------------------------------------------------------------------
loc_1C982:                                              ; CODE XREF: Gfx_UpdateScrollPosition+4   j
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
loc_1C9C6:                                              ; CODE XREF: Gfx_UpdateScrollPosition+48   j
                btst    #7,(byte_FFA959).w
                beq.s   loc_1C9D0
                moveq   #0,d1
loc_1C9D0:                                              ; CODE XREF: Gfx_UpdateScrollPosition+52   j
                tst.w   d0
                bne.s   loc_1C9DA
                tst.w   d1
                beq.w   loc_1CA3A
loc_1C9DA:                                              ; CODE XREF: Gfx_UpdateScrollPosition+58   j
                move.b  #3,d5
                move.b  #2,d6
                move.b  #0,d7
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   loc_1C9FC
                bsr.w   Physics_ApplyVelocityWithBounds
                bsr.w   Physics_ApplyPositionOffset
                bsr.w   Projectile_CheckBounds
loc_1C9FC:                                              ; CODE XREF: Gfx_UpdateScrollPosition+74   j
                move.w  (word_FFF75A).w,d4
                beq.s   locret_1CA38
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
loc_1CA08:                                              ; CODE XREF: Gfx_UpdateScrollPosition:loc_1CA34   j
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   loc_1CA34
                btst    d5,d2
                beq.s   loc_1CA1C
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
loc_1CA1C:                                              ; CODE XREF: Gfx_UpdateScrollPosition+98   j
                btst    d6,d2
                beq.s   loc_1CA28
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
loc_1CA28:                                              ; CODE XREF: Gfx_UpdateScrollPosition+A4   j
                btst    d7,d2
                beq.s   loc_1CA34
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
loc_1CA34:                                              ; CODE XREF: Gfx_UpdateScrollPosition+94   j
                                        ; Gfx_UpdateScrollPosition+B0   j
                dbf     d4,loc_1CA08
locret_1CA38:                                           ; CODE XREF: Gfx_UpdateScrollPosition+86   j
                rts
; ---------------------------------------------------------------------------
loc_1CA3A:                                              ; CODE XREF: Gfx_UpdateScrollPosition+5C   j
                move.b  #3,d5
                move.b  #2,d6
                lea     (word_FFA400).w,a5
                move.b  word_FFA402-word_FFA400(a5),d2
                beq.s   loc_1CA54
                bsr.w   Physics_ApplyVelocityWithBounds
                bsr.w   Projectile_CheckBounds
loc_1CA54:                                              ; CODE XREF: Gfx_UpdateScrollPosition+D0   j
                move.w  (word_FFF75A).w,d4
                beq.s   locret_1CA84
                subq.w  #1,d4
                lea     (word_FFED00).w,a4
loc_1CA60:                                              ; CODE XREF: Gfx_UpdateScrollPosition:loc_1CA80   j
                movea.w (a4)+,a5
                move.b  2(a5),d2
                beq.s   loc_1CA80
                btst    d5,d2
                beq.s   loc_1CA74
                move.l  $18(a5),d3
                add.l   d3,$10(a5)
loc_1CA74:                                              ; CODE XREF: Gfx_UpdateScrollPosition+F0   j
                btst    d6,d2
                beq.s   loc_1CA80
                move.l  $1C(a5),d3
                add.l   d3,$14(a5)
loc_1CA80:                                              ; CODE XREF: Gfx_UpdateScrollPosition+EC   j
                                        ; Gfx_UpdateScrollPosition+FC   j
                dbf     d4,loc_1CA60
locret_1CA84:                                           ; CODE XREF: Gfx_UpdateScrollPosition+DE   j
                rts
; End of function Gfx_UpdateScrollPosition
; Applies velocity with boundary clamping
Physics_ApplyVelocityWithBounds:                        ; CODE XREF: Gfx_UpdateScrollPosition+76   p  ; was: sub_1CA86
                                        ; Gfx_UpdateScrollPosition+D2   p
                btst    d5,d2
                beq.s   loc_1CABA
                move.l  $18(a5),d3
                move.l  (dword_FF8240).w,d4
                btst    #1,(byte_FF8244).w
                beq.s   loc_1CA9C
                asr.l   #2,d4
loc_1CA9C:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+12   j
                add.l   d4,d3
                move.l  (dword_FFA938).w,d4
                tst.l   d3
                bmi.s   loc_1CAAE
                cmp.l   d4,d3
                bmi.s   loc_1CAB6
                move.l  d4,d3
                bra.s   loc_1CAB6
; ---------------------------------------------------------------------------
loc_1CAAE:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+1E   j
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   loc_1CAB6
                move.l  d4,d3
loc_1CAB6:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+22   j
                                        ; Physics_ApplyVelocityWithBounds+26   j
                add.l   d3,$10(a5)
loc_1CABA:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+2   j
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
loc_1CAD6:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+46   j
                neg.l   d4
                cmp.l   d4,d3
                bpl.s   loc_1CADE
                move.l  d4,d3
loc_1CADE:                                              ; CODE XREF: Physics_ApplyVelocityWithBounds+4A   j
                                        ; Physics_ApplyVelocityWithBounds+4E   j
                add.l   d3,$14(a5)
locret_1CAE2:                                           ; CODE XREF: Physics_ApplyVelocityWithBounds+36   j
                rts
; End of function Physics_ApplyVelocityWithBounds
; Applies position offset based on direction flags
Physics_ApplyPositionOffset:                            ; CODE XREF: Gfx_UpdateScrollPosition+7A   p  ; was: sub_1CAE4
                btst    d7,d2
                beq.s   locret_1CAF0
                sub.w   d0,$10(a5)
                add.w   d1,$14(a5)
locret_1CAF0:                                           ; CODE XREF: Physics_ApplyPositionOffset+2   j
                rts
; End of function Physics_ApplyPositionOffset
; Checks if projectile is out of bounds
Projectile_CheckBounds:                                 ; CODE XREF: Gfx_UpdateScrollPosition+7E   p  ; was: sub_1CAF2
                                        ; Gfx_UpdateScrollPosition+D6   p
                btst    #1,(byte_FF8245).w
                bne.s   loc_1CB18
                cmpi.w  #$90,$10(a5)
                bpl.s   loc_1CB0A
                move.w  #$90,$10(a5)
                bra.s   loc_1CB18
; ---------------------------------------------------------------------------
loc_1CB0A:                                              ; CODE XREF: Projectile_CheckBounds+E   j
                cmpi.w  #$1B0,$10(a5)
                bmi.s   loc_1CB18
                move.w  #$1AF,$10(a5)
loc_1CB18:                                              ; CODE XREF: Projectile_CheckBounds+6   j
                                        ; Projectile_CheckBounds+16   j
                btst    #2,(byte_FF8245).w
                bne.s   locret_1CB2E
                cmpi.w  #$98,$14(a5)
                bpl.s   locret_1CB2E
                move.w  #$98,$14(a5)
locret_1CB2E:                                           ; CODE XREF: Projectile_CheckBounds+2C   j
                                        ; Projectile_CheckBounds+34   j
                rts
; End of function Projectile_CheckBounds
nullsub_2:                                              ; CODE XREF: Sys_GameplayMainLoop   p
                rts
; End of function nullsub_2

; Toggle debug flag on button press
