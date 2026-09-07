Gfx_BuildVDPCommandList:                                ; CODE XREF: Results_UpdateNumbers+128   p  ; was: sub_4594
                                        ; Results_UpdateNumbers+132   j
                movea.w (word_FFF70C).w,a1
                move.w  #$83,-(a1)
                move.w  d4,-(a1)
                move.b  (word_FFF70E).w,d1
                move.b  (word_FFF70E+1).w,d2
                asr.b   #1,d1
                roxr.b  #1,d2
                move.b  d2,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.l  #$8F02977F,-(a1)
                move.l  #$94009300,-(a1)
                move.b  d3,3(a1)
                move.w  a1,(word_FFF70C).w
                asl.w   #1,d3
                add.w   d3,(word_FFF70E).w
                rts
; End of function Gfx_BuildVDPCommandList
; Renders text string to VRAM using tile indices
UI_RenderTextString:                                    ; CODE XREF: Results_RenderAllStats+32   p  ; was: sub_45D2
                                        ; Results_RenderAllStats+46   p
                movea.w (word_FFF70E).w,a1
                moveq   #0,d7
loc_45D8:                                               ; CODE XREF: UI_RenderTextString+18   j
                moveq   #0,d2
                move.b  (a0)+,d2
                cmpi.b  #$FF,d2
                beq.s   loc_45EC
                asl.w   #1,d2
                add.w   d0,d2
                move.w  d2,(a1)+
                addq.w  #1,d7
                bra.s   loc_45D8
; ---------------------------------------------------------------------------
loc_45EC:                                               ; CODE XREF: UI_RenderTextString+E   j
                move.w  d7,d3
                subq.w  #1,d3
                movea.w (word_FFF70E).w,a0
loc_45F4:                                               ; CODE XREF: UI_RenderTextString+28   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d3,loc_45F4
                move.w  d7,d3
                bsr.w   Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d4,d5
                andi.w  #$DFFF,d5
                move.w  d7,d3
                bra.w   Gfx_BuildVDPCommandList
; End of function UI_RenderTextString
; Renders text string with plane wrapping support
UI_RenderTextStringWrapped:                             ; CODE XREF: RegionRestricted+3E   p  ; was: sub_4614
                                        ; RegionRestricted+52   p
                movea.w (word_FFF70E).w,a1
                moveq   #0,d7
loc_461A:                                               ; CODE XREF: UI_RenderTextStringWrapped+18   j
                moveq   #0,d2
                move.b  (a0)+,d2
                cmpi.b  #$FF,d2
                beq.s   loc_462E
                asl.w   #1,d2
                add.w   d0,d2
                move.w  d2,(a1)+
                addq.w  #1,d7
                bra.s   loc_461A
; ---------------------------------------------------------------------------
loc_462E:                                               ; CODE XREF: UI_RenderTextStringWrapped+E   j
                move.w  d7,d3
                subq.w  #1,d3
                movea.w (word_FFF70E).w,a0
loc_4636:                                               ; CODE XREF: UI_RenderTextStringWrapped+28   j
                move.w  (a0)+,d0
                addq.w  #1,d0
                move.w  d0,(a1)+
                dbf     d3,loc_4636
                move.w  d7,d3
                bsr.w   Gfx_BuildVDPCommandList
                addi.w  #$80,d4
                move.w  d4,d5
                andi.w  #$DFFF,d5
                cmpi.w  #$5000,d5
                bmi.s   UI_FinalizeTileRendering
                subi.w  #$1000,d4
; Finalizes tile rendering after text string display
UI_FinalizeTileRendering:                               ; CODE XREF: UI_RenderTextStringWrapped+40   j  ; was: loc_465A
                move.w  d7,d3
                bra.w   Gfx_BuildVDPCommandList
; End of function UI_RenderTextStringWrapped
; ---------------------------------------------------------------------------
byte_4660:      dc.b    0, 0, 0, 0, 0, 0, 0, 0
                                        ; DATA XREF: UI_UpdatePasswordDisplay+22   o
                dc.b    0, 0, 0, 0, 0, 0, 0, 0
                dc.b    $FF
byte_4671:      dc.b    $1C, 0, $F, 0, $B, 0, $E, 0, $23, $FF
                                        ; DATA XREF: UI_UpdatePasswordDisplay:loc_1E05A   o
                dc.b    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
byte_4687:      dc.b    1, 1                            ; DATA XREF: Results_RenderAllStats+9C   o
                                        ; Results_RenderAllStats+C4   o
byte_4689:      dc.b    1, 1, $FF                       ; DATA XREF: UI_RenderResultsHeaders+14   o
                                        ; Results_RenderScoreValues+32   o
byte_468C:      dc.b    1, 1, 1, 1, 1, 1, 1, 1, $1A, $1E, $1D, $FF
                                        ; DATA XREF: Results_RenderAllStats+4C   o
                                        ; Results_RenderAllStats+74   o
byte_4698:      dc.b    $11, $B, $17, $F, 0, $1D, $1E, $B
                                        ; DATA XREF: UI_RenderTitleOption1   o
                dc.b    $1C, $1E, $FF
byte_46A3:      dc.b    $19, $1A, $1E, $13, $19, $18, $1D, $FF
                                        ; DATA XREF: UI_RenderTitleOption2   o
                                        ; UI_InitOptionsScreen+BE   o
byte_46AB:      dc.b    $1A, $B, $1D, $1D, $21, $19, $1C, $E, $FF
                                        ; DATA XREF: UI_RenderTitleOption3   o
byte_46B4:      dc.b    $20, $13, $1D, $1F, $B, $16, $1D, $12
                                        ; DATA XREF: UI_InitTitleScreen+CE   o
                dc.b    $19, $D, $15, $29, 0, $1D, $1A, $F
                dc.b    $F, $E, $1D, $12, $19, $D, $15, $29
                dc.b    0, $1D, $19, $1F, $18, $E, $1D, $12
                dc.b    $19, $D, $15, $29, $FF
byte_46D9:      dc.b    $18, $19, $21, 0, $13, $1D, 0, $1E
                                        ; DATA XREF: UI_InitTitleScreen+E2   o
                dc.b    $13, $17, $F, 0, $1E, $19, 0, $1E
                dc.b    $12, $F, 0, 7, 9, 1, 1, 1
                dc.b    0, $12, $F, $B, $1C, $1E, 0, $19
                dc.b    $18, 0, $10, $13, $1C, $F, $29, $FF
byte_4701:      dc.b    $10, $19, $1C, 0, $17, $F, $11, $B
                                        ; DATA XREF: UI_InitTitleScreen+F6   o
                dc.b    $E, $1C, $13, $20, $F, $1C, $1D, 0
                dc.b    $D, $1F, $1D, $1E, $19, $17, $FF
byte_4718:      dc.b    0, $2F, $1D, $F, $11, $B, 0, $F
                                        ; DATA XREF: UI_InitTitleScreen+10A   o
                dc.b    $18, $1E, $F, $1C, $1A, $1C, $13, $1D
                dc.b    $F, $1D, $26, $16, $1E, $E, $25, 2
                dc.b    $A, $A, 6, $FF
byte_4734:      dc.b    $16, $F, $20, $F, $16, $FF, $17, $F
                                        ; DATA XREF: UI_InitOptionsScreen+D2   o
                dc.b    $1D, $1D, $B, $11, $F, 0, $1D, $21
                dc.b    $13, $1E, $D, $12, $FF
byte_4749:      dc.b    $C, $11, $17, 0, $1D, $21, $13, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+E6   o
                dc.b    $D, $12, $FF
byte_4754:      dc.b    $1D, $26, $F, 0, $1D, $21, $13, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+FA   o
                dc.b    $D, $12, $FF
byte_475F:      dc.b    $C, $11, $17, 0, $1E, $F, $1D, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+10E   o
                dc.b    $FF
byte_4768:      dc.b    $1D, $26, $F, 0, $1E, $F, $1D, $1E
                                        ; DATA XREF: UI_InitOptionsScreen+122   o
                dc.b    $FF
byte_4771:      dc.b    $20, $19, $13, $D, $F, 0, $1E, $F
                                        ; DATA XREF: UI_InitOptionsScreen+136   o
                dc.b    $1D, $1E, $FF
byte_477C:      dc.b    $1A, $1C, $F, $1D, $1D, 0, $1D, $1E, $B, $1C
                                        ; DATA XREF: UI_InitOptionsScreen+14A   o
                                        ; UI_InitPasswordScreen+F6   o
                dc.b    $1E, 0, $1E, $19, 0, $F, $22, $13, $1E, $FF
byte_4790:      dc.b    $D, $19, $18, $1E, $13, $18, $1F, $F, $FF, $11
                                        ; DATA XREF: UI_RenderContinuePrompt+4   o
                dc.b    $B, $17, $F, $F, $18, $E, $FF
byte_47A1:      dc.b    $1D, $1E, $B, $11, $F, $2E, $FF
                                        ; DATA XREF: Results_RenderScoreValues   o
byte_47A8:      dc.b    $1A, $B, $1D, $1D, $21, $19, $1C, $E
                                        ; DATA XREF: UI_RenderContinueText   o
                dc.b    $2E, $FF
byte_47B2:      dc.b    $D, $1C, $F, $E, $13, $1E, $2E, $FF
                                        ; DATA XREF: UI_RenderResultsHeaders   o
byte_47BA:      dc.b    $16, $F, $20, $F, $16, $2E, $FF
                                        ; DATA XREF: Results_RenderScoreValues+46   o
byte_47C1:      dc.b    $F, $B, $1D, $23, $FF
                                        ; DATA XREF: Results_RenderScoreValues+5A   o
byte_47C6:      dc.b    $12, $B, $1C, $E, $FF, $C9, $CA, $CB
                                        ; DATA XREF: Results_RenderScoreValues+66   o
                dc.b    $CC, $CD, $FF
byte_47D1:      dc.b    $23, $19, $1F, 0, $16, $19, $1D, $1E
                                        ; DATA XREF: Password_InitializeScreen+7A   o
                dc.b    0, 4, $D, $12, $B, $18, $D, $F
                dc.b    $1D, $25, $25, $25, $FF
byte_47E6:      dc.b    $1E, $1C, $23, 0, $B, $11, $B, $13
                                        ; DATA XREF: Password_InitializeScreen+8E   o
                dc.b    $18, $29, $29, $FF
byte_47F2:      dc.b    $1A, $1C, $F, $1D, $1D, 0, $1D, $1E
                                        ; DATA XREF: Password_InitializeScreen+A2   o
                                        ; sub_1E430   o
                dc.b    $B, $1C, $1E, $FF
byte_47FE:      dc.b    $1C, $F, $1D, $1F, $16, $1E, $1D, $FF
                                        ; DATA XREF: Results_RenderAllStats+24   o
byte_4806:      dc.b    $12, $13, $11, $12, 0, $1D, $D, $19
                                        ; DATA XREF: Results_RenderAllStats+38   o
                dc.b    $1C, $F, $FF
byte_4811:      dc.b    $1D, $D, $19, $1C, $F, $FF, $D, $19
                                        ; DATA XREF: Results_RenderAllStats+60   o
                dc.b    $18, $1E, $13, $18, $1F, $F, $FF
byte_4820:      dc.b    $E, $F, $1D, $1E, $1C, $19, $23, $F
                                        ; DATA XREF: Results_RenderAllStats+88   o
                dc.b    $E, 0, $F, $18, $F, $17, $13, $F
                dc.b    $1D, $FF
byte_4832:      dc.b    $1A, $16, $B, $23, $F, $1C, 0, $E
                                        ; DATA XREF: Results_RenderAllStats+B0   o
                dc.b    $B, $17, $B, $11, $F, $FF

; Clears scroll planes A/B and initializes display state
