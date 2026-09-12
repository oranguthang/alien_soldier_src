; Runs the terrain-tile animation on even global frames
TerrainTileAnimation_EvenFrameHandler:                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F396
                moveq   #0,d0
                bra.s   TerrainTileAnimation_SetFramePhase
; End of function TerrainTileAnimation_EvenFrameHandler
; Runs the terrain-tile animation on odd global frames
TerrainTileAnimation_OddFrameHandler:                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F39A
                move.w  #1,d0
TerrainTileAnimation_SetFramePhase:                     ; CODE XREF: TerrainTileAnimation_EvenFrameHandler+2   j  ; was: loc_2F39E
                move.w  (FrameCounter).w,d1
                andi.w  #1,d1
                eor.w   d0,d1
                move.w  d1,$48(a5)
                move.w  4(a5),d0
                beq.s   TerrainTileAnimation_DispatchState
                cmpi.w  #4,d0
                beq.s   TerrainTileAnimation_DispatchState
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bpl.s   TerrainTileAnimation_DispatchStateNoOp
                move.w  #4,4(a5)
                bra.s   TerrainTileAnimation_DispatchState
; ---------------------------------------------------------------------------
TerrainTileAnimation_DispatchStateNoOp:                 ; CODE XREF: TerrainTileAnimation_OddFrameHandler+24   j  ; was: loc_2F3C8
                nop
; Dispatches the terrain-tile animation state
TerrainTileAnimation_DispatchState:                     ; CODE XREF: TerrainTileAnimation_OddFrameHandler+16   j  ; was: loc_2F3CA
                                        ; TerrainTileAnimation_OddFrameHandler+1C   j
                move.w  4(a5),d0
                movea.w TerrainTileAnimation_StateOffsets(pc,d0.w),a0
                adda.l  #TerrainTileAnimation_Initialize,a0
                jmp     (a0)
; End of function TerrainTileAnimation_OddFrameHandler
; ---------------------------------------------------------------------------
TerrainTileAnimation_StateOffsets:  dc.w    TerrainTileAnimation_Initialize-TerrainTileAnimation_Initialize  ; was: off_2F3DA
                                        ; DATA XREF: TerrainTileAnimation_OddFrameHandler+34   r
                dc.w    TerrainTileAnimation_WaitForActivation-TerrainTileAnimation_Initialize
                dc.w    TerrainTileAnimation_Finish-TerrainTileAnimation_Initialize
                dc.w    TerrainTileAnimation_AdvanceFrame-TerrainTileAnimation_Initialize
                dc.w    TerrainTileAnimation_HoldPeakFrame-TerrainTileAnimation_Initialize
                dc.w    TerrainTileAnimation_RewindFrame-TerrainTileAnimation_Initialize

; Initializes the five-frame terrain-layout animation
TerrainTileAnimation_Initialize:                        ; DATA XREF: TerrainTileAnimation_OddFrameHandler+38   o  ; was: sub_2F3E6
                                        ; ROM:TerrainTileAnimation_StateOffsets   o
                addq.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                move.w  #5,$4E(a5)
                move.w  $5E(a5),d0
                move.w  TerrainTileAnimation_LayoutBases(pc,d0.w),$50(a5)
                move.w  #$4000,$52(a5)
                move.b  #0,$54(a5)
                move.b  #1,$55(a5)
TerrainTileAnimation_Return:                            ; CODE XREF: TerrainTileAnimation_Finish+18   j  ; was: locret_2F418
                                        ; TerrainTileAnimation_TransferIfScheduled+4   j
                rts
; End of function TerrainTileAnimation_Initialize
; ---------------------------------------------------------------------------
TerrainTileAnimation_LayoutBases:   dc.w    $42E4, $4290, $42B4, $42E0, $4284, $42B0, $42D4, $4280  ; was: word_2F41A
                                        ; DATA XREF: TerrainTileAnimation_Initialize+1A   r

; Waits until the layout cell is near the viewport, then starts its cue effect
TerrainTileAnimation_WaitForActivation:                 ; DATA XREF: ROM:0002F3DC   o  ; was: sub_2F42A
                cmpi.w  #$1A8,$10(a5)
                bpl.s   TerrainTileAnimation_WaitReturn
                subq.w  #1,$4A(a5)
                bpl.s   TerrainTileAnimation_WaitReturn
                move.w  #6,4(a5)
                jsr     (Sprite_FindFreeEnemySlot).l
                bne.s   TerrainTileAnimation_WaitReturn
                move.w  #$2B0,(a0)
                move.b  #$B,$5F(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #8,$14(a0)
                move.b  #$45,d0                         ; 'E'
                jsr     (Sound_PlaySFX).l
TerrainTileAnimation_WaitReturn:                        ; CODE XREF: TerrainTileAnimation_WaitForActivation+6   j  ; was: locret_2F46A
                                        ; TerrainTileAnimation_WaitForActivation+C   j
                rts
; End of function TerrainTileAnimation_WaitForActivation
; Advances toward the fifth tile pattern on the selected frame phase
TerrainTileAnimation_AdvanceFrame:                      ; DATA XREF: ROM:0002F3E0   o  ; was: sub_2F46C
                tst.w   $48(a5)
                bne.s   TerrainTileAnimation_StateReturn
                addq.w  #2,$4C(a5)
                cmpi.w  #8,$4C(a5)
                bne.w   TerrainTileAnimation_TransferFrame
                addq.w  #2,4(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                bra.w   TerrainTileAnimation_TransferFrame
; End of function TerrainTileAnimation_AdvanceFrame
; Holds the peak tile pattern before rewinding
TerrainTileAnimation_HoldPeakFrame:                     ; DATA XREF: ROM:0002F3E2   o  ; was: sub_2F48E
                subq.w  #1,$4A(a5)
                bpl.s   TerrainTileAnimation_StateReturn
                addq.w  #2,4(a5)
TerrainTileAnimation_StateReturn:                       ; CODE XREF: TerrainTileAnimation_AdvanceFrame+4   j  ; was: locret_2F498
                                        ; TerrainTileAnimation_HoldPeakFrame+4   j
                rts
; End of function TerrainTileAnimation_HoldPeakFrame
; Rewinds to the first pattern and repeats the animation five times
TerrainTileAnimation_RewindFrame:                       ; DATA XREF: ROM:0002F3E4   o  ; was: sub_2F49A
                tst.w   $48(a5)
                bne.s   TerrainTileAnimation_StateReturn
                subq.w  #2,$4C(a5)
                bne.w   TerrainTileAnimation_TransferFrame
                subq.w  #1,$4E(a5)
                bmi.s   TerrainTileAnimation_Complete
                move.w  #2,4(a5)
                move.w  (RandomNumberState).w,d0
                andi.w  #$7F,d0
                addi.w  #$40,d0                         ; '@'
                move.w  d0,$4A(a5)
                bra.w   TerrainTileAnimation_TransferFrame
; End of function TerrainTileAnimation_RewindFrame
; Restores the first tile pattern and retires the controller
TerrainTileAnimation_Finish:                            ; DATA XREF: ROM:0002F3DE   o  ; was: sub_2F4C8
                tst.w   $48(a5)
                bne.s   TerrainTileAnimation_StateReturn
TerrainTileAnimation_Complete:                          ; CODE XREF: TerrainTileAnimation_RewindFrame+12   j  ; was: loc_2F4CE
                bset    #4,2(a5)
                clr.w   $4C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
TerrainTileAnimation_TransferIfScheduled:               ; CODE XREF: TerrainTileAnimation_Finish+10   j  ; was: loc_2F4DC
                                        ; OrphanedTerrainTileAnimationReveal+10   j
                tst.w   $48(a5)
                bne.w   TerrainTileAnimation_Return
; Writes the selected pattern into the terrain layout via the shared DMA helper
TerrainTileAnimation_TransferFrame:                     ; CODE XREF: TerrainTileAnimation_AdvanceFrame+10   j  ; was: loc_2F4E4
                                        ; TerrainTileAnimation_AdvanceFrame+1E   j
                move.w  $4C(a5),d0
                move.w  TerrainTileAnimation_FramePatterns(pc,d0.w),$56(a5)
                movea.w a5,a0
                adda.w  #$50,a0                         ; 'P'
                jmp     Tilemap_QueueIndexedColumns
; End of function TerrainTileAnimation_Finish
; ---------------------------------------------------------------------------
TerrainTileAnimation_FramePatterns: dc.w    $878C, $888D, $898E, $8A8F, $8B90  ; was: word_2F4FA
                                        ; DATA XREF: TerrainTileAnimation_Finish+20   r

; Initialize the six ambient screen particles shared by Stages 10 and 11
Midgame_InitializeAmbientParticles:                     ; CODE XREF: Midgame_InitializeRasterAndAmbientEffects+A   p  ; was: sub_2F504
                movea.w #(byte_FFD8E0-M68K_RAM),a0
                moveq   #5,d7
Midgame_InitializeAmbientParticles_Loop:                ; CODE XREF: Midgame_InitializeAmbientParticles+C   j  ; was: loc_2F50A
                bsr.s   Midgame_InitializeAmbientParticle
                lea     $60(a0),a0
                dbf     d7,Midgame_InitializeAmbientParticles_Loop
                rts
; End of function Midgame_InitializeAmbientParticles
; Initializes one non-colliding ambient particle
Midgame_InitializeAmbientParticle:                      ; CODE XREF: Midgame_InitializeAmbientParticles:Midgame_InitializeAmbientParticles_Loop   p  ; was: sub_2F516
                move.w  #$208,(a0)
                move.w  #$8C80,2(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$7C,$20(a0)                    ; '|'
                move.w  (PrimaryCameraXPosition).w,$48(a0)
                move.w  #$44F5,$E(a0)
; Gives the particle a new randomized screen position and vertical motion
Midgame_ResetAmbientParticle:                           ; CODE XREF: Midgame_UpdateAmbientParticle+8   j  ; was: loc_2F53E
                                        ; Midgame_UpdateAmbientParticle+12   j
                moveq   #0,d0
                move.w  (RandomNumberState+2).w,d0
                andi.w  #$7FFF,d0
                addi.w  #-$8000,d0
                move.l  d0,$1C(a0)
                move.b  (RandomNumberState).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  (PrimaryCameraXPosition).w,d1
                sub.w   $48(a0),d1
                add.w   d1,d0
                move.w  d0,$10(a0)
                move.b  (RandomNumberState+1).w,d0
                andi.w  #$7F,d0
                addi.w  #$80,d0
                move.w  d0,$14(a0)
                jmp     (RandomNumber).l
; End of function Midgame_InitializeAmbientParticle
; Keep a shared Stage 10/11 ambient particle inside the screen region
Midgame_UpdateAmbientParticle:                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F580
                movea.w a5,a0
                cmpi.w  #$80,$10(a5)
                bmi.w   Midgame_ResetAmbientParticle
                cmpi.w  #$1C0,$10(a5)
                bpl.w   Midgame_ResetAmbientParticle
                cmpi.w  #$138,$14(a5)
                bpl.w   Midgame_ResetAmbientParticle
                move.w  (PrimaryCameraXPosition).w,d0
                sub.w   $48(a5),d0
                asr.w   #1,d0
                sub.w   d0,$10(a5)
                move.w  (PrimaryCameraXPosition).w,$48(a5)
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                move.l  d0,$18(a5)
                rts
; End of function Midgame_UpdateAmbientParticle
