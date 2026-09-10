Stage_CheckPlayerPosTrigger:                            ; DATA XREF: ROM:0000C896   o  ; was: sub_CDFA
                cmpi.w  #$140,(dword_FFA410).w
                bmi.s   locret_CE0C
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FF8058).w           ; '@'
locret_CE0C:                                            ; CODE XREF: Stage_CheckPlayerPosTrigger+6   j
                rts
; End of function Stage_CheckPlayerPosTrigger
; Waits for timer then initiates stage transition
Stage_WaitAndTransition:                                ; DATA XREF: ROM:0000C898   o  ; was: sub_CE0E
                subq.w  #1,(dword_FF8058).w
                bmi.s   loc_CE16
locret_CE14:                                            ; CODE XREF: Stage_WaitAndTransition+C   j
                rts
; ---------------------------------------------------------------------------
loc_CE16:                                               ; CODE XREF: Stage_WaitAndTransition+4   j
                tst.w   (word_FF8230).w
                bne.s   locret_CE14
                move.b  #$89,(byte_FFA230).w
                move.l  #byte_1E587,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; End of function Stage_WaitAndTransition
; Writes boss parameter bytes to RAM structure
Stage_WriteBossParams:                                  ; CODE XREF: Stage_InitStage8Train+38   p  ; was: sub_CE2E
                                        ; Stage_FlyingNeoBattleStart+1A   p
                lea     (M68K_RAM_PHYSICAL+(byte_FF615D-M68K_RAM)).l,a0
                move.b  (a1)+,(a0)
                move.b  (a1)+,1(a0)
                move.b  (a1)+,8(a0)
                move.b  (a1)+,9(a0)
                move.b  (a1)+,$10(a0)
                move.b  (a1)+,$11(a0)
                rts
; End of function Stage_WriteBossParams
; ---------------------------------------------------------------------------
byte_CE4C:      dc.b    $19, $1A, $1E, $1F, $23, $24
                                        ; DATA XREF: Stage_InitStage8Train+34   o
byte_CE52:      dc.b    $1C, $1D, $21, $22, $26, $27
                                        ; DATA XREF: Stage_FlyingNeoBattleStart+16   o

; Initializes Stage 8 train with scroll and graphics
Stage_InitStage8Train:                                  ; DATA XREF: ROM:0000C89A   o  ; was: sub_CE58
                move.w  #1,(word_FF821E).w
                addq.w  #2,(word_FFA950).w
                move.w  #$730,(dword_FFA900).w
                move.w  #0,(dword_FFA904).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                move.w  (dword_FFA904).w,(word_FFA92C).w
                move.b  #3,(word_FFF7E6+1).w
                move.b  #$30,(byte_FFA95A).w            ; '0'
                move.b  #4,(byte_FFA95B).w
                lea     byte_CE4C(pc),a1
                bsr.s   Stage_WriteBossParams
                bsr.w   Stage_InitFlyingNeoEntity
                move.w  #$34,(word_FFA02A).w            ; '4'
                move.w  #$45C,(Entity_ObjectPool).w
                clr.w   (word_FFC624).w
; Checks scroll position during train stage initialization
Stage_InitStage8Train_ScrollCheck:                      ; DATA XREF: ROM:0000C89C   o  ; was: loc_CEA6
                cmpi.w  #$EC0,(dword_FFA900).w
                bmi.s   loc_CEB8
                move.w  #$16,(word_FFA02A).w
                bsr.w   Stage_TransitionToNextPhase
loc_CEB8:                                               ; CODE XREF: Stage_InitStage8Train+54   j
                bsr.w   Scroll_ApplyAcceleration
; End of function Stage_InitStage8Train
; Train scroll physics with velocity updates
Stage_TrainScrollPhysics:                               ; CODE XREF: Stage_TrainToFlyingNeoTransition+4   p  ; was: sub_CEBC
                                        ; Stage_FlyingNeoScrollUpdate+24   j
                move.l  #word_D84A,(dword_FF821A).w
                bsr.w   Effect_SpawnRandomLightning
                bsr.w   Stage_TrainParallaxCalc
                tst.w   (dword_FFA960).w
                bmi.s   locret_CEF8
                bne.s   loc_CEE4
                subi.l  #$1400,(dword_FFA904).w
                bpl.s   locret_CEF8
                addq.w  #1,(dword_FFA960).w
                bra.s   locret_CEF8
; ---------------------------------------------------------------------------
loc_CEE4:                                               ; CODE XREF: Stage_TrainScrollPhysics+16   j
                addi.l  #$1400,(dword_FFA904).w
                cmpi.w  #$18,(dword_FFA904).w
                bmi.s   locret_CEF8
                clr.w   (dword_FFA960).w
locret_CEF8:                                            ; CODE XREF: Stage_TrainScrollPhysics+14   j
                                        ; Stage_TrainScrollPhysics+20   j
                rts
; End of function Stage_TrainScrollPhysics
; Train background parallax calculation for depth effect
Stage_TrainParallaxCalc:                                ; CODE XREF: Stage_TrainScrollPhysics+C   p  ; was: sub_CEFA
                                        ; Stage_FlyingNeoVerticalScroll+2E   p
                movea.w #(byte_FF8800-M68K_RAM),a5
                subi.l  #$28000,(dword_FF8A00).w
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #8,d0
                subi.w  #$41,(word_FF8A04).w            ; 'A'
                sub.w   d0,(word_FF8A08).w
                subi.w  #$10,(word_FF8A0C).w
                subi.w  #$13,(word_FF8A10).w
                move.w  #$C,d6
                move.w  (word_FFA000).w,d0
                asl.w   #2,d0
                movea.w #(word_FF8A04-M68K_RAM),a0
                and.w   d6,d0
                move.w  (a0,d0.w),d1
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d2
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d3
                addq.w  #4,d0
                and.w   d6,d0
                move.w  (a0,d0.w),d4
                addq.w  #4,d0
                movea.w #(byte_FF8800-M68K_RAM),a5
                move.w  #$2F,d7                         ; '/'
; Fills VRAM buffer with parallax scroll data for train stage
Gfx_FillParallaxBuffer:                                 ; CODE XREF: Stage_TrainParallaxCalc+6A   j  ; was: loc_CF5C
                move.w  d1,(a5)+
                move.w  d2,(a5)+
                move.w  d3,(a5)+
                move.w  d4,(a5)+
                dbf     d7,Gfx_FillParallaxBuffer
                rts
; End of function Stage_TrainParallaxCalc
; Transitions from train to Flying-Neo boss battle
Stage_TrainToFlyingNeoTransition:                       ; DATA XREF: ROM:0000C89E   o  ; was: sub_CF6A
                bsr.w   Scroll_IncrementHorizontalFast
                bsr.w   Stage_TrainScrollPhysics
                cmpi.w  #$F00,(dword_FFA900).w
                bmi.s   locret_CF98
                addq.w  #2,(word_FFA950).w
                move.w  #$80,(dword_FFA960+2).w
                clr.l   (dword_FFA910).w
                move.w  #$F00,d0
                move.w  d0,(dword_FFA900).w
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
locret_CF98:                                            ; CODE XREF: Stage_TrainToFlyingNeoTransition+E   j
                rts
; End of function Stage_TrainToFlyingNeoTransition
; Updates scroll positions for Flying-Neo battle
Stage_FlyingNeoScrollUpdate:                            ; DATA XREF: ROM:0000C8A0   o  ; was: sub_CF9A
                subq.w  #1,(dword_FFA960+2).w
                bpl.s   Stage_SyncScrollPositions
                tst.w   (word_FF8138).w
                bne.s   Stage_SyncScrollPositions
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FFA964).w
                bsr.w   Stage_FlyingNeoSpawn
; Synchronizes scroll positions between camera and stage buffers
Stage_SyncScrollPositions:                              ; CODE XREF: Stage_FlyingNeoScrollUpdate+4   j  ; was: loc_CFB2
                                        ; Stage_FlyingNeoScrollUpdate+A   j
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                bra.w   Stage_TrainScrollPhysics
; End of function Stage_FlyingNeoScrollUpdate
; Decelerates vertical scroll to zero
Stage_FlyingNeoScrollDecel:                             ; DATA XREF: ROM:0000C8A4   o  ; was: sub_CFC2
                subi.l  #$1000,(dword_FFA964).w
                bpl.s   Stage_UpdateVerticalScroll
                addq.w  #2,(word_FFA950).w
                move.w  #1,(dword_FFA960).w
                move.w  #$40,(dword_FFA960+2).w         ; '@'
                bra.s   Stage_UpdateVerticalScroll
; End of function Stage_FlyingNeoScrollDecel
; Handles vertical scroll acceleration with boundaries
Stage_FlyingNeoVerticalScroll:                          ; DATA XREF: ROM:0000C8A2   o  ; was: sub_CFDE
                cmpi.w  #5,(dword_FFA964).w
                bpl.s   loc_CFEE
                addi.l  #$1000,(dword_FFA964).w
loc_CFEE:                                               ; CODE XREF: Stage_FlyingNeoVerticalScroll+6   j
                cmpi.w  #$40,(dword_FFA904).w           ; '@'
                bmi.s   Stage_UpdateVerticalScroll
                addq.w  #2,(word_FFA950).w
                move.w  #$1A,(word_FFA02A).w
; Updates vertical scroll with parallax and lightning effects for Flying-Neo stage
Stage_UpdateVerticalScroll:                             ; CODE XREF: Stage_FlyingNeoScrollDecel+8   j  ; was: loc_D000
                                        ; Stage_FlyingNeoScrollDecel+1A   j
                move.l  (dword_FFA964).w,d0
                add.l   d0,(dword_FFA904).w
                bsr.w   Scroll_UpdateCameraPositions
                bsr.w   Stage_TrainParallaxCalc
                move.l  #word_D864,(dword_FF821A).w
                bsr.w   Effect_SpawnRandomLightning
                rts
; End of function Stage_FlyingNeoVerticalScroll
; Starts Flying-Neo battle with palette and params
Stage_FlyingNeoBattleStart:                             ; DATA XREF: ROM:0000C8A6   o  ; was: sub_D01E
                subq.w  #1,(dword_FFA960+2).w
                bpl.s   loc_D040
                addq.w  #2,(word_FFA950).w
                lea     (Boss_FlyingNeoAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                lea     byte_CE52(pc),a1
                bsr.w   Stage_WriteBossParams
                bsr.w   Stage_FlyingNeoInitBoss
loc_D040:                                               ; CODE XREF: Stage_FlyingNeoBattleStart+4   j
                                        ; Stage_FlyingNeoBattleUpdate+4   j
                move.l  #word_D864,(dword_FF821A).w
                bsr.w   Effect_SpawnRandomLightning
                move.w  (dword_FFA900).w,(dword_FFA908).w
                move.w  (dword_FFA904).w,(dword_FFA90C).w
                bsr.w   Stage_TrainParallaxCalc
                tst.w   (dword_FFA960).w
                bne.s   Stage_IncrementVerticalPosition
                subi.l  #$4000,(dword_FFA904).w
                cmpi.w  #$60,(dword_FFA904).w           ; '`'
                bpl.s   locret_D076
                addq.w  #1,(dword_FFA960).w
locret_D076:                                            ; CODE XREF: Stage_FlyingNeoBattleStart+52   j
                                        ; Stage_FlyingNeoBattleStart+68   j
                rts
; ---------------------------------------------------------------------------
; Increments vertical scroll position until reaching threshold value
Stage_IncrementVerticalPosition:                        ; CODE XREF: Stage_FlyingNeoBattleStart+42   j  ; was: loc_D078
                addi.l  #$4000,(dword_FFA904).w
                cmpi.w  #$80,(dword_FFA904).w
                bmi.s   locret_D076
                clr.w   (dword_FFA960).w
                rts
; End of function Stage_FlyingNeoBattleStart
; Transitions to next stage after Flying-Neo defeat
Stage_PostFlyingNeoTransition:                          ; DATA XREF: ROM:0000C8AA   o  ; was: sub_D08E
                tst.w   (MessageSequenceState).w
                bne.w   Stage_FlyingNeoBattleUpdate
                tst.w   (word_FF8230).w
                bne.s   Stage_FlyingNeoBattleUpdate
                move.l  #byte_1E6C6,(dword_FFA22C).w
                tst.w   (MessageSequenceState).w
                beq.w   Stage_InitTransitionState
; End of function Stage_PostFlyingNeoTransition
; Updates Flying-Neo battle with vertical oscillation
Stage_FlyingNeoBattleUpdate:                            ; CODE XREF: Stage_PostFlyingNeoTransition+4   j  ; was: sub_D0AC
                                        ; Stage_PostFlyingNeoTransition+C   j
                                        ; DATA XREF:
                bsr.w   Camera_UpdateTowardsPlayer
                bra.w   loc_D040
; End of function Stage_FlyingNeoBattleUpdate
; Initializes Stage 9 with scroll and parameters
