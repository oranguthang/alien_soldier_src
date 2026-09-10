Gfx_LoadStage18Tiles:                                   ; CODE XREF: Stage_Stage18StartBattle+6   p  ; was: sub_10026
                                        ; sub_E4FC   p
                bsr.w   Gfx_AccelerateScroll
loc_1002A:                                              ; CODE XREF: Gfx_LoadDestroyerMK2Tiles+1A   j
                bsr.w   Camera_Stage18Lock
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  (dword_FFA904).w,d1
                lea     Gfx_DefaultVRAMTransferParameters(pc),a0
                nop
                bra.w   loc_10704
; End of function Gfx_LoadStage18Tiles
; Loads Destroyer-MK2 tiles
Gfx_LoadDestroyerMK2Tiles:                              ; CODE XREF: Stage_DestroyerMK2Init   p  ; was: sub_10044
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   loc_10056
                btst    #1,(byte_FFA407).w
                beq.s   loc_10056
                rts
; ---------------------------------------------------------------------------
loc_10056:                                              ; CODE XREF: Gfx_LoadDestroyerMK2Tiles+6   j
                                        ; Gfx_LoadDestroyerMK2Tiles+E   j
                addi.l  #$10000,(dword_FFA900).w
                bra.s   loc_1002A
; End of function Gfx_LoadDestroyerMK2Tiles
; Updates scroll with player following
Gfx_UpdateScroll:                                       ; CODE XREF: Stage_UpdateLogic:loc_C8C6   p  ; was: sub_10060
                                        ; sub_C92E   p
                bsr.w   Gfx_AccelerateScroll
                bra.w   Gfx_GetCameraPosition
; End of function Gfx_UpdateScroll
; Loads boss tile graphics into VRAM
Gfx_LoadBossTiles:                                      ; CODE XREF: Stage_InitBossIntro   p  ; was: sub_10068
                                        ; sub_C944   p
                cmpi.w  #$91,(dword_FFA410).w
                bpl.s   loc_1007A
                btst    #1,(byte_FFA407).w
                beq.s   loc_1007A
                rts
; ---------------------------------------------------------------------------
loc_1007A:                                              ; CODE XREF: Gfx_LoadBossTiles+6   j
                                        ; Gfx_LoadBossTiles+E   j
                addi.l  #$10000,(dword_FFA900).w
                bra.w   Gfx_GetCameraPosition
; End of function Gfx_LoadBossTiles
; Updates camera position towards player
Camera_UpdateTowardsPlayer:                             ; CODE XREF: Camera_BossPhaseHandler:loc_C91A   p  ; was: sub_10086
                                        ; Camera_Stage2PhaseHandler+4   p
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.w   locret_1032C
                moveq   #0,d0
                move.l  (dword_FFA900).w,d6
                bra.w   Camera_SmoothFollowPlayer
; End of function Camera_UpdateTowardsPlayer
; Smoothly follows player vertically with bounds
Camera_BoundedVerticalFollow:
                move.w  $10(a5),d0                      ; was: sub_100A0
                subi.w  #$130,d0
                bmi.s   loc_100DA
                swap    d0
                asr.l   #4,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_100BC
                move.l  #$60000,d0
loc_100BC:                                              ; CODE XREF: Camera_BoundedVerticalFollow+14   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_100D2
                bmi.s   loc_100D2
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_100D2:                                              ; CODE XREF: Camera_BoundedVerticalFollow+28   j
                                        ; Camera_BoundedVerticalFollow+2A   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
locret_100D8:                                           ; CODE XREF: Camera_BoundedVerticalFollow+42   j
                rts
; ---------------------------------------------------------------------------
loc_100DA:                                              ; CODE XREF: Camera_BoundedVerticalFollow+8   j
                move.w  $10(a5),d0
                subi.w  #$110,d0
                bpl.s   locret_100D8
                swap    d0
                asr.l   #4,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_100F6
                move.l  #$FFFA0000,d0
loc_100F6:                                              ; CODE XREF: Camera_BoundedVerticalFollow+4E   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_1010C
                bpl.s   loc_1010C
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1010C:                                              ; CODE XREF: Camera_BoundedVerticalFollow+62   j
                                        ; Camera_BoundedVerticalFollow+64   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_BoundedVerticalFollow
; Smoothly follows player with speed limits
Camera_SmoothFollowPlayer:                              ; CODE XREF: Camera_UpdateTowardsPlayer+16   j  ; was: sub_10114
                moveq   #3,d1
                btst    #3,$E(a5)
                beq.s   loc_1015C
                move.w  #$C8,d0
                sub.w   $10(a5),d0
                bpl.s   loc_10168
                moveq   #4,d1
loc_1012A:                                              ; CODE XREF: Camera_SmoothFollowPlayer+50   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1013E
                move.l  #$60000,d0
loc_1013E:                                              ; CODE XREF: Camera_SmoothFollowPlayer+22   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_10154
                bmi.s   loc_10154
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_10154:                                              ; CODE XREF: Camera_SmoothFollowPlayer+36   j
                                        ; Camera_SmoothFollowPlayer+38   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1015C:                                              ; CODE XREF: Camera_SmoothFollowPlayer+8   j
                move.w  #$178,d0
                sub.w   $10(a5),d0
                bmi.s   loc_1012A
                moveq   #4,d1
loc_10168:                                              ; CODE XREF: Camera_SmoothFollowPlayer+12   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_1017C
                move.l  #$FFFA0000,d0
loc_1017C:                                              ; CODE XREF: Camera_SmoothFollowPlayer+60   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_10192
                bpl.s   loc_10192
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_10192:                                              ; CODE XREF: Camera_SmoothFollowPlayer+74   j
                                        ; Camera_SmoothFollowPlayer+76   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_SmoothFollowPlayer
; Constrains camera to screen bounds
Camera_ConstrainToScreenBounds:                         ; CODE XREF: Stage_ViblackScroll+1E   j  ; was: sub_1019A
                                        ; sub_DF8E   j
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.w   locret_1032C
                moveq   #0,d0
                move.l  (dword_FFA900).w,d6
                moveq   #3,d1
                btst    #3,$E(a5)
                beq.s   loc_101F8
                move.w  #$120,d0
                sub.w   $10(a5),d0
                bpl.s   loc_10204
                moveq   #4,d1
loc_101C6:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+66   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_101DA
                move.l  #$60000,d0
loc_101DA:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+38   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA974).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_101F0
                bmi.s   loc_101F0
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_101F0:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+4C   j
                                        ; Camera_ConstrainToScreenBounds+4E   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_101F8:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+1E   j
                move.w  #$120,d0
                sub.w   $10(a5),d0
                bmi.s   loc_101C6
                moveq   #4,d1
loc_10204:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+28   j
                neg.w   d0
                swap    d0
                asr.l   d1,d0
                cmpi.l  #$FFFA0000,d0
                bpl.s   loc_10218
                move.l  #$FFFA0000,d0
loc_10218:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+76   j
                add.l   d0,d6
                moveq   #0,d0
                move.w  (word_FFA970).w,d0
                swap    d0
                cmp.l   d6,d0
                beq.s   loc_1022E
                bpl.s   loc_1022E
                move.l  d6,(dword_FFA900).w
                rts
; ---------------------------------------------------------------------------
loc_1022E:                                              ; CODE XREF: Camera_ConstrainToScreenBounds+8A   j
                                        ; Camera_ConstrainToScreenBounds+8C   j
                move.l  d0,d6
                move.l  d6,(dword_FFA900).w
                rts
; End of function Camera_ConstrainToScreenBounds
; Adjusts camera based on player state flags
Camera_AdjustForPlayerState:
                btst    #5,(byte_FF8244).w              ; was: sub_10236
                bne.w   locret_1032C
                tst.w   (a5)
                beq.s   locret_10272
                moveq   #0,d0
                move.b  $69(a5),d0
                btst    #2,d0
                beq.s   loc_10256
                btst    #4,d0
                bne.s   loc_10274
loc_10256:                                              ; CODE XREF: Camera_AdjustForPlayerState+18   j
                move.w  $10(a5),d0
                subi.w  #$130,d0
                bpl.s   locret_10272
                swap    d0
                asr.l   #3,d0
loc_10264:                                              ; CODE XREF: Camera_AdjustForPlayerState+4E   j
                cmp.l   (dword_FFA930).w,d0
                bpl.s   loc_1026E
                move.l  (dword_FFA930).w,d0
loc_1026E:                                              ; CODE XREF: Camera_AdjustForPlayerState+32   j
                add.l   d0,(dword_FFA900).w
locret_10272:                                           ; CODE XREF: Camera_AdjustForPlayerState+C   j
                                        ; Camera_AdjustForPlayerState+28   j
                rts
; ---------------------------------------------------------------------------
loc_10274:                                              ; CODE XREF: Camera_AdjustForPlayerState+1E   j
                move.w  #$160,d0
                sub.w   $10(a5),d0
                bmi.s   locret_10272
                neg.w   d0
                swap    d0
                asr.l   #5,d0
                bra.s   loc_10264
; End of function Camera_AdjustForPlayerState
; Applies scroll acceleration with boundary checking
Scroll_ApplyAcceleration:                               ; CODE XREF: Stage_InitStage8Train:loc_CEB8   p  ; was: sub_10286
                bsr.w   Gfx_AccelerateScroll
loc_1028A:                                              ; CODE XREF: Scroll_IncrementHorizontalFast+8   j
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                move.w  (dword_FFA900).w,d0
                addi.w  #$158,d0
                move.w  #$F700,d1
                lea     Gfx_ScrollVRAMTransferParameters(pc),a0
                nop
                jmp     loc_10704(pc)                   ; (pc)
; End of function Scroll_ApplyAcceleration
; No operation placeholder routine
Scroll_NoOp1:
                nop                                     ; was: sub_102AC
; End of function Scroll_NoOp1
; Increments horizontal scroll by 65536 fixed point
Scroll_IncrementHorizontalFast:                         ; CODE XREF: Stage_TrainToFlyingNeoTransition   p  ; was: sub_102AE
                addi.l  #$10000,(dword_FFA900).w
                bra.s   loc_1028A
; End of function Scroll_IncrementHorizontalFast
; Updates camera scroll positions with offset calculation
Scroll_UpdateCameraPositions:                           ; CODE XREF: Stage_FlyingNeoVerticalScroll+2A   p  ; was: sub_102B8
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0                         ; '`'
                move.w  (dword_FFA904).w,d1
                addi.w  #-$910,d1
                lea     Gfx_ScrollVRAMTransferParameters(pc),a0
                nop
                jmp     loc_109E0(pc)                   ; (pc)
; End of function Scroll_UpdateCameraPositions
; No operation placeholder routine
Scroll_NoOp2:
                nop                                     ; was: sub_102DE
; End of function Scroll_NoOp2
; Calculates scroll position from camera
Gfx_CalculateScrollPosition:                            ; CODE XREF: Stage_UpdateLogic+8   p  ; was: sub_102E0
                                        ; Stage_InitBossIntro+4   p
                move.w  (dword_FFA900).w,d0
                asr.w   #2,d0
                move.w  d0,(dword_FFA908).w
                rts
; End of function Gfx_CalculateScrollPosition
; Adds scroll delta to main scroll position
Scroll_AddDeltaToScroll:                                ; CODE XREF: Stage_Stage10CheckTransition+4   p  ; was: sub_102EC
                                        ; Stage_DeepStriderTransition+4   p
                moveq   #0,d0
                move.w  (dword_FFA910).w,d0
                swap    d0
                asr.l   #2,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Scroll_AddDeltaToScroll
; Accelerates scroll based on player position
Gfx_AccelerateScroll:                                   ; CODE XREF: Gfx_LoadStage18Tiles   p  ; was: sub_102FC
                                        ; sub_10060   p
                btst    #5,(byte_FF8244).w
                bne.w   locret_1032C
                tst.w   (a5)
                beq.s   locret_1032C
                moveq   #0,d0
                move.w  $10(a5),d0
                subi.w  #$F0,d0
                bmi.s   locret_1032C
                swap    d0
                asr.l   #3,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_10328
                move.l  #$60000,d0
loc_10328:                                              ; CODE XREF: Gfx_AccelerateScroll+24   j
                add.l   d0,(dword_FFA900).w
locret_1032C:                                           ; CODE XREF: Camera_UpdateTowardsPlayer+6   j
                                        ; Camera_UpdateTowardsPlayer+C   j
                rts
; End of function Gfx_AccelerateScroll
; Follows player when right of screen center
Camera_RightEdgeFollow:
                move.w  #$C0,d0                         ; was: sub_1032E
                sub.w   $10(a5),d0
                bpl.s   locret_1032C
                neg.w   d0
                swap    d0
                asr.l   #5,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1034C
                move.l  #$60000,d0
loc_1034C:                                              ; CODE XREF: Camera_RightEdgeFollow+16   j
                add.l   d0,(dword_FFA900).w
                rts
; End of function Camera_RightEdgeFollow
; Updates scroll state and renders Sylpheed
Scroll_RenderSylpheedWithUpdate:                        ; CODE XREF: Stage_ScrollCheckTransition   p  ; was: sub_10352
                bsr.w   Camera_VerticalBoundaryFollow
                bra.w   Gfx_RenderSylpheedBackground
; End of function Scroll_RenderSylpheedWithUpdate
; Updates vertical scroll
Scroll_UpdateVerticalScroll:                            ; CODE XREF: Stage_SunsetStingTransition   p  ; was: sub_1035A
                                        ; Stage_ViblackScroll+14   p
                addi.l  #$8000,(dword_FFA904).w
                bra.w   Gfx_RenderSylpheedBackground
; End of function Scroll_UpdateVerticalScroll
; Follows player vertically when below screen
Camera_VerticalBoundaryFollow:                          ; CODE XREF: Scroll_RenderSylpheedWithUpdate   p  ; was: sub_10366
                tst.w   (a5)
                beq.s   locret_1038E
                moveq   #0,d0
                move.w  $14(a5),d0
                subi.w  #$108,d0
                bpl.s   locret_1038E
                neg.w   d0
                swap    d0
                asr.l   #3,d0
                cmpi.l  #$60000,d0
                bmi.s   loc_1038A
                move.l  #$60000,d0
loc_1038A:                                              ; CODE XREF: Camera_VerticalBoundaryFollow+1C   j
                add.l   d0,(dword_FFA904).w
locret_1038E:                                           ; CODE XREF: Camera_VerticalBoundaryFollow+2   j
                                        ; Camera_VerticalBoundaryFollow+E   j
                rts
; End of function Camera_VerticalBoundaryFollow
; Initializes stage transition state with cutscene parameters
Stage_InitTransitionState:                              ; CODE XREF: Stage_CheckTransitionReady+16   j  ; was: sub_10390
                                        ; Stage_WaitAndTransition+1C   j
                move.w  #3,(word_FF8230).w
                move.w  #2,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                bra.w   loc_103C0
; End of function Stage_InitTransitionState
; Initializes transition between stage sections
Stage_InitSectionChange:                                ; CODE XREF: Camera_Stage2PhaseHandler   p  ; was: sub_103B0
                                        ; sub_C98E   p
                tst.w   (word_FF80C2).w
                bne.s   locret_103D2
                addq.w  #2,(word_FFA950).w
                move.w  #$50,(word_FF80C2).w            ; 'P'
loc_103C0:                                              ; CODE XREF: Stage_InitTransitionState+1C   j
                clr.w   (word_FF820C).w
                addq.w  #2,(StageTableIndex).w
                bclr    #7,(dword_FFA20E).w
                clr.b   (byte_FFA209).w
locret_103D2:                                           ; CODE XREF: Stage_InitSectionChange+4   j
                rts
; End of function Stage_InitSectionChange
; Initializes score display timer to 0x5C
UI_InitScoreTimer:                                      ; CODE XREF: Camera_AntroidBossInit+A   p  ; was: sub_103D4
                                        ; Stage_InitPostBoss+12   p
                move.w  #$5C,(word_FF80C2).w            ; '\'
                bra.s   loc_103E2
; End of function UI_InitScoreTimer
; Triggers transition to next stage phase
Stage_TriggerPhaseTransition:                           ; CODE XREF: Camera_BossPhaseHandler+6   p  ; was: sub_103DC
                                        ; Stage_PostJokerBoss+A   p
                move.w  #$2E,(word_FF80C2).w            ; '.'
loc_103E2:                                              ; CODE XREF: UI_InitScoreTimer+6   j
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA209).w
                addq.w  #2,(StageTableIndex).w
                jsr     (Stage_StateDispatcher).l
                subq.w  #2,(StageTableIndex).w
                rts
; End of function Stage_TriggerPhaseTransition
; Sets up VDP scroll plane registers
Gfx_SetupScrollPlanes:                                  ; CODE XREF: Gfx_ClearPlanesAndInit+8A   p  ; was: sub_103FA
                                        ; Sys_StoryScreenMainLoop+56   p
                move.w  #$8230,(word_FFF7D4).w
                move.w  #$8407,(word_FFF7D8).w
                tst.w   (word_FF8640).w
                beq.s   loc_10418
                move.w  #$8238,(word_FFF7D4).w
                move.w  #$8406,(word_FFF7D8).w
loc_10418:                                              ; CODE XREF: Gfx_SetupScrollPlanes+10   j
                move.b  (word_FFF7E6+1).w,d3
                move.b  d3,d4
                andi.w  #3,d3
                andi.w  #4,d4
                move.b  (byte_FFA95A).w,d5
                movea.w #(word_FFE400-M68K_RAM),a0
                movea.w #(word_FFE480-M68K_RAM),a1
                adda.w  (word_FF8640).w,a0
                adda.w  (word_FF8640).w,a1
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                move.w  (word_FFA012).w,d1
                bsr.w   Gfx_WriteScrollValue
                movea.w #(word_FFEC00-M68K_RAM),a0
                adda.w  (word_FF8640).w,a0
                move.w  (dword_FFA904).w,d0
                neg.w   d0
                add.w   (word_FFA012).w,d0
                bsr.w   Gfx_WriteScrollValues
                move.b  (byte_FFA95B).w,d5
                movea.w #(word_FFE402-M68K_RAM),a0
                movea.w #(byte_FFE482-M68K_RAM),a1
                suba.w  (word_FF8640).w,a0
                suba.w  (word_FF8640).w,a1
                move.w  (dword_FFA908).w,d0
                neg.w   d0
                move.w  (word_FFA016).w,d1
                bsr.w   Gfx_WriteScrollValue
                movea.w #(word_FFEC02-M68K_RAM),a0
                suba.w  (word_FF8640).w,a0
                move.w  (dword_FFA90C).w,d0
                neg.w   d0
                add.w   (word_FFA016).w,d0
                bra.w   Gfx_WriteScrollValues
; End of function Gfx_SetupScrollPlanes
; Writes scroll value with flag checks
