Cutscene_DispatchInit:                                  ; CODE XREF: Sys_TransitionToStageInit+5C   p  ; was: sub_1E83E
                move.w  (word_FFA29C).w,d0
                movea.w off_1E84E(pc,d0.w),a0
                adda.l  #Cutscene_DispatchUpdate,a0
                jmp     (a0)
; End of function Cutscene_DispatchInit
; ---------------------------------------------------------------------------
off_1E84E:      dc.w    Cutscene_LoadInitialAssets-Cutscene_DispatchUpdate
                                        ; DATA XREF: Cutscene_DispatchInit+4   r
                dc.w    Stage_InitPlayerAndScroll-Cutscene_DispatchUpdate
                dc.w    Stage_TransitionToCredits-Cutscene_DispatchUpdate

; Dispatcher for cutscene update
Cutscene_DispatchUpdate:                                ; CODE XREF: Sys_StageTransitionUpdate+18   p  ; was: sub_1E854
                                        ; DATA XREF: Cutscene_DispatchInit+8   o
                move.w  (word_FFA29C).w,d0
                movea.w off_1E864(pc,d0.w),a0
                adda.l  #Cutscene_LoadInitialAssets,a0
                jmp     (a0)
; End of function Cutscene_DispatchUpdate
; ---------------------------------------------------------------------------
off_1E864:      dc.w    Cutscene_UpdatePhysicsAndHUD-Cutscene_LoadInitialAssets
                                        ; DATA XREF: Cutscene_DispatchUpdate+4   r
                dc.w    Stage_UpdateGameplay-Cutscene_LoadInitialAssets
                dc.w    Stage_HandleCreditsOrAdvance-Cutscene_LoadInitialAssets

; Loads palette and graphics
Cutscene_LoadInitialAssets:                             ; DATA XREF: ROM:off_1E84E   o  ; was: sub_1E86A
                                        ; Cutscene_DispatchUpdate+8   o
                lea     stru_1E8A4(pc),a0
                nop
                jsr     (LoadObjData).l
                lea     (word_B9A0).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                move.w  (word_FFA216).w,(word_FF820A).w
                move.w  #$7000,d0
                move.w  d0,(word_FF8206).w
                move.w  d0,(word_FF8200).w
                move.w  d0,(word_FF8202).w
                bset    #0,(byte_FFA272).w
                jmp     Gfx_DecompressCutsceneData
; End of function Cutscene_LoadInitialAssets
; ---------------------------------------------------------------------------
stru_1E8A4:     dc.w    7                               ; field_0
                                        ; DATA XREF: Cutscene_LoadInitialAssets   o
                dc.l    tiles_1198E4                    ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_11A644                     ; field_2
                dc.w    $4000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_11A61A                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    3                               ; field_0
                dc.l    byte_18BE42                     ; field_2
                dc.w    0                               ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18C634                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_18C5E6                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_F10A4                     ; field_2
                dc.w    $9000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_19BA44                     ; field_2
                dc.w    $7000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    byte_18DF92                     ; field_2
                dc.w    $D000                           ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1195BA                    ; field_2
                dc.w    $7800                           ; field_6
                dc.w    $FFFF

; Updates physics and HUD
Cutscene_UpdatePhysicsAndHUD:                           ; DATA XREF: ROM:off_1E864   o  ; was: sub_1E8F6
                jsr     (Physics_ApplyFriction).l
                jsr     (UI_RenderHUDElement1).l
                move.w  (dword_FF8128).w,d0
                movea.w off_1E912(pc,d0.w),a0
                adda.l  #Cutscene_XiTigerSetup,a0
                jmp     (a0)
; End of function Cutscene_UpdatePhysicsAndHUD
; ---------------------------------------------------------------------------
off_1E912:      dc.w    Cutscene_XiTigerSetup-Cutscene_XiTigerSetup
                                        ; DATA XREF: Cutscene_UpdatePhysicsAndHUD+10   r
                dc.w    Cutscene_XiTigerWaitComplete-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerScrollUpdate-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerScrollSetup-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerScrollFadeIn-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerScrollFadeIn_CheckInput-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerFlashEffect-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerFadeOutAlt-Cutscene_XiTigerSetup
                dc.w    Cutscene_XiTigerFinish-Cutscene_XiTigerSetup

; Sets up Xi Tiger cutscene
Cutscene_XiTigerSetup:                                  ; DATA XREF: Cutscene_UpdatePhysicsAndHUD+14   o  ; was: sub_1E924
                                        ; ROM:off_1E912   o
                addq.w  #2,(dword_FF8128).w
                move.l  #$20000,(dword_FF812C).w
                move.w  #$100,(dword_FF8130).w
                move.b  #$1E,d0
                jsr     (Sound_PlaySFX).l
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                bsr.w   Cutscene_XiTigerInit
                lea     $60(a0),a0
                bsr.w   Cutscene_XiTigerInit
                bset    #3,$E(a0)
                move.w  #0,(dword_FFA900).w
                move.w  #$28,(dword_FFA908).w           ; '('
                lea     dword_1E97A(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                lea     dword_1E986(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; End of function Cutscene_XiTigerSetup
; ---------------------------------------------------------------------------
dword_1E97A:    dc.l    $44214000, $1020203, $B0C090A
                                        ; DATA XREF: Cutscene_XiTigerSetup+3E   o
dword_1E986:    dc.l    $68204000, $4010405, $607080D, $E0F1011
                                        ; DATA XREF: Cutscene_XiTigerSetup+4A   o

; Initializes Xi-Tiger cutscene with graphics
Cutscene_XiTigerInit:                                   ; CODE XREF: Cutscene_XiTigerSetup+20   p  ; was: sub_1E996
                                        ; Cutscene_XiTigerSetup+28   p
                move.w  #$10,(a0)
                move.w  #$CC00,2(a0)
                move.w  #$E3C0,$E(a0)
                move.l  #word_1198D2,8(a0)
locret_1E9AE:                                           ; CODE XREF: Cutscene_XiTigerScrollSetup+4   j
                                        ; Cutscene_XiTigerSkipCheck+6   j
                rts
; End of function Cutscene_XiTigerInit
; Updates scroll position and fade during Xi Tiger cutscene
Cutscene_XiTigerScrollUpdate:                           ; DATA XREF: ROM:0001E916   o  ; was: sub_1E9B0
                subi.l  #$1800,(dword_FF9F08).w
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_1E9D2
                addq.w  #2,(dword_FF8130+2).w
                cmpi.w  #$E,(dword_FF8130+2).w
                bmi.s   loc_1E9D2
                addq.w  #2,(dword_FF8128).w
loc_1E9D2:                                              ; CODE XREF: Cutscene_XiTigerScrollUpdate+10   j
                                        ; Cutscene_XiTigerScrollUpdate+1C   j
                bsr.w   Cutscene_XiTigerApplyFade
                bra.s   loc_1EA14
; End of function Cutscene_XiTigerScrollUpdate
; Waits and shows Xi Tiger
Cutscene_XiTigerWaitComplete:                           ; DATA XREF: ROM:0001E914   o  ; was: sub_1E9D8
                subq.w  #1,(dword_FF8130).w
                bpl.s   loc_1E9FA
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$50,(dword_FF8130).w           ; 'P'
                clr.w   (Entity_ObjectPool).w
                clr.w   (word_FFC680).w
loc_1E9FA:                                              ; CODE XREF: Cutscene_XiTigerWaitComplete+4   j
                bsr.w   Cutscene_XiTigerComplete
                move.w  (dword_FF8128+2).w,d0
                cmpi.w  #$200,d0
                bmi.s   loc_1EA14
                andi.w  #$F,d0
                bne.s   loc_1EA14
                moveq   #$E,d7
                bsr.w   Cutscene_XiTigerWaitForInput
loc_1EA14:                                              ; CODE XREF: Cutscene_XiTigerScrollUpdate+26   j
                                        ; Cutscene_XiTigerWaitComplete+2E   j
                bsr.w   Cutscene_XiTigerProcessCommands
                bsr.w   Cutscene_XiTigerFrameUpdate
                jmp     Gfx_LoadCutsceneFrame
; End of function Cutscene_XiTigerWaitComplete
; Sets up Xi Tiger scroll
Cutscene_XiTigerScrollSetup:                            ; DATA XREF: ROM:0001E918   o  ; was: sub_1EA22
                subq.w  #1,(dword_FF8130).w
                bpl.w   locret_1E9AE
                move.b  #$82,d0
                jsr     (Sys_WaitVBlank).l
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
                jsr     (Scroll_GetForegroundPosition).l
                move.w  #$1E0,(dword_FFA900).w
                jmp     Scroll_GetBackgroundPosition
; End of function Cutscene_XiTigerScrollSetup
; Scrolls and fades in Xi Tiger
Cutscene_XiTigerScrollFadeIn:                           ; DATA XREF: ROM:0001E91A   o  ; was: sub_1EA9A
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   Cutscene_XiTigerScrollFadeIn_CheckInput
                subq.w  #2,(dword_FF8130+2).w
                bne.s   Cutscene_XiTigerScrollFadeIn_CheckInput
                addq.w  #2,(dword_FF8128).w
; Checks input flag bit 0 and updates scroll counters during cutscene
Cutscene_XiTigerScrollFadeIn_CheckInput:                ; CODE XREF: Cutscene_XiTigerScrollFadeIn+8   j  ; was: loc_1EAAE
                                        ; Cutscene_XiTigerScrollFadeIn+E   j
                                        ; DATA XREF:
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1EAC0
                addq.w  #1,(dword_FF8134+2).w
                bmi.s   loc_1EAC0
                clr.w   (dword_FF8134+2).w
loc_1EAC0:                                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+1A   j
                                        ; Cutscene_XiTigerScrollFadeIn+20   j
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$C0,(dword_FF8128+2).w
                bne.s   loc_1EAEE
                move.b  #$11,d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,(dword_FF8128).w
                move.w  #$48,(word_FFE3BA).w            ; 'H'
                move.w  #$2AE,(word_FFE3BC).w
                move.w  #$C,(dword_FF8130+2).w
                bra.s   Cutscene_XiTigerFlashEffect
; ---------------------------------------------------------------------------
loc_1EAEE:                                              ; CODE XREF: Cutscene_XiTigerScrollFadeIn+30   j
                bsr.w   Cutscene_XiTigerUpdateScroll
                bsr.w   Cutscene_XiTigerApplyFade
                bra.w   Cutscene_XiTigerFrameUpdate
; End of function Cutscene_XiTigerScrollFadeIn
; Applies Xi Tiger flash effect
Cutscene_XiTigerFlashEffect:                            ; CODE XREF: Cutscene_XiTigerScrollFadeIn+52   j  ; was: sub_1EAFA
                                        ; DATA XREF: ROM:0001E91E   o
                addq.w  #1,(dword_FF8128+2).w
                cmpi.w  #$160,(dword_FF8128+2).w
                bne.s   loc_1EB0C
                addq.w  #2,(dword_FF8128).w
                bra.s   Cutscene_XiTigerFadeOutAlt
; ---------------------------------------------------------------------------
loc_1EB0C:                                              ; CODE XREF: Cutscene_XiTigerFlashEffect+A   j
                subq.w  #1,(dword_FF8130+2).w
                bpl.s   loc_1EB16
                clr.w   (dword_FF8130+2).w
loc_1EB16:                                              ; CODE XREF: Cutscene_XiTigerFlashEffect+16   j
                movea.w #(byte_FFE322-M68K_RAM),a0
                move.w  #$8000,d7
                moveq   #$E,d5
                bsr.w   loc_1EC2A
                bsr.w   Cutscene_XiTigerUpdateScroll
                bra.w   Cutscene_XiTigerFrameUpdate
; End of function Cutscene_XiTigerFlashEffect
; Fades out Xi Tiger cutscene
Cutscene_XiTigerFadeOutAlt:                             ; CODE XREF: Cutscene_XiTigerFlashEffect+10   j  ; was: sub_1EB2C
                                        ; DATA XREF: ROM:0001E920   o
                subq.w  #2,(dword_FF8134+2).w
                addq.w  #1,(dword_FF8130+2).w
                cmpi.w  #$10,(dword_FF8130+2).w
                bne.s   loc_1EB42
                addq.w  #2,(dword_FF8128).w
                rts
; ---------------------------------------------------------------------------
loc_1EB42:                                              ; CODE XREF: Cutscene_XiTigerFadeOutAlt+E   j
                bsr.w   Cutscene_XiTigerUpdateScroll
                bsr.w   Cutscene_XiTigerFrameUpdate
                bra.w   Cutscene_XiTigerApplyFade
; End of function Cutscene_XiTigerFadeOutAlt
; Completes Xi Tiger cutscene
Cutscene_XiTigerFinish:                                 ; DATA XREF: ROM:0001E922   o  ; was: sub_1EB4E
                jsr     (Stage_DispatchObjectLoader).l
                move.w  #$80,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                move.w  #0,(word_FF814C).w
                rts
; End of function Cutscene_XiTigerFinish
; Updates cutscene frame with timing
Cutscene_XiTigerFrameUpdate:                            ; CODE XREF: Cutscene_XiTigerWaitComplete+40   p  ; was: sub_1EB66
                                        ; Cutscene_XiTigerScrollFadeIn+5C   j
                movea.w #(dword_FFA100-M68K_RAM),a0
                move.w  #$C3DC,d0
                move.w  #$F00,d1
                move.w  #$A0,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   Cutscene_XiTigerLoadFrame
                move.w  #$140,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   Cutscene_XiTigerLoadFrame
                move.w  #$160,d3
                add.w   (dword_FF8134+2).w,d3
                bsr.s   Cutscene_XiTigerLoadFrame
                move.w  #$FFFF,(a0)
                movea.w #(dword_FFA100-M68K_RAM),a0
                jmp     (Sprite_AddToOAMBuffer).l
; End of function Cutscene_XiTigerFrameUpdate
; Loads cutscene frame data to VRAM
Cutscene_XiTigerLoadFrame:                              ; CODE XREF: Cutscene_XiTigerFrameUpdate+14   p  ; was: sub_1EB9E
                                        ; Cutscene_XiTigerFrameUpdate+1E   p
                move.w  #$80,d2
                moveq   #9,d7
loc_1EBA4:                                              ; CODE XREF: Cutscene_XiTigerLoadFrame+12   j
                move.w  d3,(a0)+
                move.w  d1,(a0)+
                move.w  d0,(a0)+
                move.w  d2,(a0)+
                addi.w  #$20,d2                         ; ' '
                dbf     d7,loc_1EBA4
                rts
; End of function Cutscene_XiTigerLoadFrame
; Processes cutscene command sequence
Cutscene_XiTigerProcessCommands:                        ; CODE XREF: Cutscene_XiTigerWaitComplete:loc_1EA14   p  ; was: sub_1EBB6
                addi.l  #$800,(dword_FF812C).w
                move.w  (dword_FF812C).w,d0
                add.w   d0,(dword_FF8128+2).w
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                movea.w #(word_FFC680-M68K_RAM),a1
                move.w  (dword_FF8128+2).w,d0
                andi.w  #$3F,d0                         ; '?'
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   loc_1EBE4
                subi.w  #$20,d0                         ; ' '
                eori.w  #$1F,d0
loc_1EBE4:                                              ; CODE XREF: Cutscene_XiTigerProcessCommands+24   j
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
                                        ; Cutscene_XiTigerScrollFadeIn+58   p
                movea.w #(word_FFE300-M68K_RAM),a0
                move.w  #$E000,d7
                moveq   #$3F,d5                         ; '?'
loc_1EC2A:                                              ; CODE XREF: Cutscene_XiTigerFlashEffect+26   p
                move.w  (dword_FF8130+2).w,d0
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Cutscene_XiTigerApplyFade
; Updates scroll with wave distortion effect
Cutscene_XiTigerUpdateScroll:                           ; CODE XREF: Cutscene_XiTigerScrollFadeIn:loc_1EAEE   p  ; was: sub_1EC34
                                        ; Cutscene_XiTigerFlashEffect+2A   p
                movea.w #(word_FFE402-M68K_RAM),a0
                lea     (Math_QuarterSineTable).l,a1
                moveq   #0,d0
                addi.w  #$108,(dword_FF8134).w
                move.w  (dword_FF8134).w,d0
                move.l  #$1814000,d3
                move.w  #$DF,d7
loc_1EC54:                                              ; CODE XREF: Cutscene_XiTigerUpdateScroll+3A   j
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
                andi.w  #$3F,d0                         ; '?'
                btst    #6,(dword_FF8130+1).w
                beq.s   loc_1ECA0
                eori.w  #$3F,d0                         ; '?'
                btst    #0,(word_FFA000+1).w
                bne.s   loc_1ECA0
                addq.w  #1,(dword_FF8130).w
loc_1ECA0:                                              ; CODE XREF: Cutscene_XiTigerUpdateScroll+5A   j
                                        ; Cutscene_XiTigerUpdateScroll+66   j
                subi.w  #$20,d0                         ; ' '
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
word_1ED28:     dc.w    $26, $68C, 2, 0                 ; DATA XREF: Cutscene_XiTigerUpdateScroll+E0   r
                                        ; Cutscene_XiTigerUpdateScroll+E6   r
                dc.w    $48, $248, 4, 0

; Waits for player input to continue
Cutscene_XiTigerWaitForInput:                           ; CODE XREF: Cutscene_XiTigerWaitComplete+38   p  ; was: sub_1ED38
                bsr.s   Cutscene_XiTigerSkipCheck
                neg.w   d7
; End of function Cutscene_XiTigerWaitForInput
; Checks if player wants to skip cutscene
Cutscene_XiTigerSkipCheck:                              ; CODE XREF: Cutscene_XiTigerWaitForInput   p  ; was: sub_1ED3C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_1E9AE
                move.w  #$120,$10(a0)
                add.w   d7,$10(a0)
                lea     (Cutscene_XiTigerSkipSpriteFrames).l,a1
                jsr     (Sprite_InitFromTable).l
                move.w  #$274,(a0)
                rts
; End of function Cutscene_XiTigerSkipCheck
; Fades out cutscene graphics
Cutscene_XiTigerFadeOut:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_1ED62
                move.w  #$E1,d0
                sub.w   (word_FF9F14).w,d0
                move.w  d0,$14(a5)
                jsr     (Anim_UpdateSpriteFrame).l
                bset    #7,$E(a5)
                rts
; End of function Cutscene_XiTigerFadeOut
; Completes cutscene advancing to gameplay
Cutscene_XiTigerComplete:                               ; CODE XREF: Cutscene_XiTigerWaitComplete:loc_1E9FA   p  ; was: sub_1ED7C
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_1E9AE
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$3F,d0                         ; '?'
                addi.w  #$100,d0
                move.w  d0,$14(a0)
                lea     (Cutscene_XiTigerCompletionSpriteFrames).l,a1
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                addq.w  #8,d0
                neg.w   d0
                move.w  d0,$1C(a0)
                jmp     Sprite_InitFromTable
; End of function Cutscene_XiTigerComplete
; Initializes player and scroll
