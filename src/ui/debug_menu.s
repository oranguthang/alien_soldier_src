UI_DispatchStatusUpdate:                                ; CODE XREF: DebugMenu_UpdateActive+60   p  ; was: sub_1372A
                                        ; DebugMenu_UpdateActive+78   p
                bsr.w   UI_QueuePendingWeaponStateIconTransfer
                move.w  (word_FF8660).w,d0
                movea.w off_1373E(pc,d0.w),a0
                adda.l  #UI_MenuSelectStage,a0
                jmp     (a0)
; End of function UI_DispatchStatusUpdate
; ---------------------------------------------------------------------------
off_1373E:      dc.w    UI_MenuSelectStage-UI_MenuSelectStage
                                        ; DATA XREF: UI_DispatchStatusUpdate+8   r
                dc.w    UI_MenuSelectWeapon-UI_MenuSelectStage
                dc.w    UI_MenuResetOption-UI_MenuSelectStage
                dc.w    UI_MenuNavigateVertical-UI_MenuSelectStage
                dc.w    UI_MenuColorPicker-UI_MenuSelectStage

; Handles stage selection menu navigation
UI_MenuSelectStage:                                     ; DATA XREF: UI_DispatchStatusUpdate+C   o  ; was: sub_13748
                                        ; ROM:off_1373E   o
                clr.w   (word_FF8666).w
                btst    #3,(VBlankFrameCounter+1).w
                bne.s   loc_1375A
                move.w  #$C7E5,(word_FF8512).w
loc_1375A:                                              ; CODE XREF: UI_MenuSelectStage+A   j
                move.b  (byte_FF866B).w,d0
                moveq   #1,d1
                movea.w #(word_FFF706-M68K_RAM),a0
                tst.w   (word_FF866C).w
                beq.s   loc_1376E
                movea.w #(word_FFF708-M68K_RAM),a0
loc_1376E:                                              ; CODE XREF: UI_MenuSelectStage+20   j
                btst    #2,(a0)
                beq.s   loc_1378C
                cmpi.b  #0,d0
                beq.s   loc_13786
                cmpi.b  #$FF,d0
                beq.s   loc_137AC
                sub.w   d2,d2
                sbcd    d1,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_13786:                                              ; CODE XREF: UI_MenuSelectStage+30   j
                move.b  #$FF,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_1378C:                                              ; CODE XREF: UI_MenuSelectStage+2A   j
                btst    #3,(a0)
                beq.s   loc_137AC
                cmpi.b  #$FF,d0
                bne.s   loc_1379C
                moveq   #0,d0
                bra.s   loc_137AC
; ---------------------------------------------------------------------------
loc_1379C:                                              ; CODE XREF: UI_MenuSelectStage+4E   j
                sub.w   d2,d2
                abcd    d1,d0
                move.w  #$400,d1
                asr.w   #4,d1
                cmp.b   d1,d0
                bmi.s   loc_137AC
                move.b  d1,d0
loc_137AC:                                              ; CODE XREF: UI_MenuSelectStage+36   j
                                        ; UI_MenuSelectStage+3C   j
                clr.w   (word_FF822A).w
                move.b  d0,(byte_FF866B).w
                cmpi.b  #$FF,d0
                bne.s   locret_137BE
                addq.w  #2,(word_FF822A).w
locret_137BE:                                           ; CODE XREF: UI_MenuSelectStage+70   j
                rts
; End of function UI_MenuSelectStage
; Handles weapon selection menu navigation
UI_MenuSelectWeapon:                                    ; DATA XREF: ROM:00013740   o  ; was: sub_137C0
                btst    #3,(VBlankFrameCounter+1).w
                bne.s   loc_137CE
                move.w  #$C7E5,(word_FF8572).w
loc_137CE:                                              ; CODE XREF: UI_MenuSelectWeapon+6   j
                move.b  (word_FF8228).w,d0
                movea.w #(word_FFF706-M68K_RAM),a0
                tst.w   (word_FF866C).w
                beq.s   loc_137E0
                movea.w #(word_FFF708-M68K_RAM),a0
loc_137E0:                                              ; CODE XREF: UI_MenuSelectWeapon+1A   j
                btst    #2,(a0)
                beq.s   loc_137EE
                subq.b  #1,d0
                move.b  d0,(word_FF8228).w
                rts
; ---------------------------------------------------------------------------
loc_137EE:                                              ; CODE XREF: UI_MenuSelectWeapon+24   j
                btst    #3,(a0)
                beq.s   locret_137FA
                addq.w  #1,d0
                move.b  d0,(word_FF8228).w
locret_137FA:                                           ; CODE XREF: UI_MenuSelectWeapon+32   j
                rts
; End of function UI_MenuSelectWeapon
; Handles B button press to reset option
UI_MenuResetOption:                                     ; DATA XREF: ROM:00013742   o  ; was: sub_137FC
                btst    #4,(word_FFF708).w
                beq.s   loc_13808
                clr.w   (word_FF8200).w
loc_13808:                                              ; CODE XREF: UI_MenuResetOption+6   j
                btst    #3,(VBlankFrameCounter+1).w
                bne.s   locret_13816
                move.w  #$C7E5,(word_FF8522).w
locret_13816:                                           ; CODE XREF: UI_MenuResetOption+12   j
                rts
; End of function UI_MenuResetOption
; Handles up/down menu navigation
UI_MenuNavigateVertical:                                ; DATA XREF: ROM:00013744   o  ; was: sub_13818
                btst    #3,(VBlankFrameCounter+1).w
                bne.s   loc_13826
                move.w  #$C7E5,(word_FF8582).w
loc_13826:                                              ; CODE XREF: UI_MenuNavigateVertical+6   j
                move.b  (word_FFF708).w,d0
                andi.b  #$C,d0
                beq.s   locret_1383A
                addq.w  #2,(word_FF8662).w
                andi.w  #6,(word_FF8662).w
locret_1383A:                                           ; CODE XREF: UI_MenuNavigateVertical+16   j
                rts
; End of function UI_MenuNavigateVertical
; Handles RGB color picker navigation
UI_MenuColorPicker:                                     ; DATA XREF: ROM:00013746   o  ; was: sub_1383C
                btst    #3,(VBlankFrameCounter+1).w
                bne.s   loc_13858
                tst.w   (word_FF8666).w
                beq.s   loc_13852
                move.w  #$C7E5,(word_FF8554).w
                bra.s   loc_13858
; ---------------------------------------------------------------------------
loc_13852:                                              ; CODE XREF: UI_MenuColorPicker+C   j
                move.w  #$C7E5,(word_FF8532).w
loc_13858:                                              ; CODE XREF: UI_MenuColorPicker+6   j
                                        ; UI_MenuColorPicker+14   j
                tst.w   (word_FF8666).w
                beq.w   loc_138A2
                bsr.w   UI_UpdateColorValue
                btst    #4,(word_FFF708).w
                beq.s   loc_13872
                clr.w   (word_FF8666).w
                rts
; ---------------------------------------------------------------------------
loc_13872:                                              ; CODE XREF: UI_MenuColorPicker+2E   j
                btst    #2,(word_FFF708).w
                beq.s   loc_13888
                subq.w  #2,(word_FF8668).w
                bpl.s   locret_138A0
                move.w  #4,(word_FF8668).w
                rts
; ---------------------------------------------------------------------------
loc_13888:                                              ; CODE XREF: UI_MenuColorPicker+3C   j
                btst    #3,(word_FFF708).w
                beq.s   locret_138A0
                addq.w  #2,(word_FF8668).w
                cmpi.w  #6,(word_FF8668).w
                bmi.s   locret_138A0
                clr.w   (word_FF8668).w
locret_138A0:                                           ; CODE XREF: UI_MenuColorPicker+42   j
                                        ; UI_MenuColorPicker+52   j
                rts
; ---------------------------------------------------------------------------
loc_138A2:                                              ; CODE XREF: UI_MenuColorPicker+20   j
                btst    #4,(word_FFF708).w
                beq.s   loc_138B4
                addq.w  #1,(word_FF8666).w
                clr.w   (word_FF8668).w
                rts
; ---------------------------------------------------------------------------
loc_138B4:                                              ; CODE XREF: UI_MenuColorPicker+6C   j
                btst    #2,(word_FFF708).w
                beq.s   loc_138C2
                subq.w  #2,(word_FF8664).w
                bra.s   loc_138CE
; ---------------------------------------------------------------------------
loc_138C2:                                              ; CODE XREF: UI_MenuColorPicker+7E   j
                btst    #3,(word_FFF708).w
                beq.s   loc_138CE
                addq.w  #2,(word_FF8664).w
loc_138CE:                                              ; CODE XREF: UI_MenuColorPicker+84   j
                                        ; UI_MenuColorPicker+8C   j
                andi.w  #$1E,(word_FF8664).w
                rts
; End of function UI_MenuColorPicker
; Renders menu selection cursor
UI_RenderMenuSelection1:                                ; CODE XREF: DebugMenu_UpdateActive+80   p  ; was: sub_138D6
                btst    #2,(VBlankFrameCounter+1).w
                bne.s   locret_138EC
                move.w  (word_FF8664).w,d0
                addi.w  #-$7A6C,d0
                movea.w d0,a0
                move.w  #$D7E4,(a0)
locret_138EC:                                           ; CODE XREF: UI_RenderMenuSelection1+6   j
                rts
; End of function UI_RenderMenuSelection1
; Renders color picker cursor
UI_RenderColorCursor:                                   ; CODE XREF: DebugMenu_UpdateActive+6C   p  ; was: sub_138EE
                tst.w   (word_FF8666).w
                beq.s   locret_1390A
                btst    #2,(VBlankFrameCounter+1).w
                bne.s   locret_1390A
                move.w  (word_FF8668).w,d0
                addi.w  #-$7AAA,d0
                movea.w d0,a0
                move.w  #$C7E4,(a0)
locret_1390A:                                           ; CODE XREF: UI_RenderColorCursor+4   j
                                        ; UI_RenderColorCursor+C   j
                rts
; End of function UI_RenderColorCursor
; Converts stage number to tilemap digits
UI_RenderStageNumber:                                   ; CODE XREF: DebugMenu_UpdateActive+64   p  ; was: sub_1390C
                move.b  (byte_FF866B).w,d0
                cmpi.b  #$FF,d0
                bne.s   loc_13924
                move.w  #$C7E2,(word_FF851E).w
                move.w  #$C7DE,(word_FF8520).w
                rts
; ---------------------------------------------------------------------------
loc_13924:                                              ; CODE XREF: UI_RenderStageNumber+8   j
                move.b  d0,d1
                andi.w  #$F,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF8520).w
                asr.w   #4,d1
                andi.w  #$F,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF851E).w
                rts
; End of function UI_RenderStageNumber
; Converts weapon number to tilemap digits
UI_RenderWeaponNumber:                                  ; CODE XREF: DebugMenu_UpdateActive+88   p  ; was: sub_13942
                move.b  (word_FF8228).w,d0
                move.b  d0,d1
                andi.w  #$F,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF8580).w
                asr.w   #4,d1
                andi.w  #$F,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF857E).w
                rts
; End of function UI_RenderWeaponNumber
; Loads weapon icon tiles
UI_LoadWeaponTiles:                                     ; CODE XREF: DebugMenu_UpdateActive+68   p  ; was: sub_13964
                moveq   #0,d0
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                addi.l  #word_13992,d0
                movea.l d0,a0
                movea.w #(byte_FF8534-M68K_RAM),a1
                moveq   #$F,d7
loc_1397A:                                              ; CODE XREF: UI_LoadWeaponTiles+18   j
                move.w  (a0)+,(a1)+
                dbf     d7,loc_1397A
                rts
; End of function UI_LoadWeaponTiles
; Renders weapon type number as digit
UI_RenderWeaponType:                                    ; CODE XREF: DebugMenu_UpdateActive+7C   p  ; was: sub_13982
                move.w  (word_FF8662).w,d0
                asr.w   #1,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF858A).w
                rts
; End of function UI_RenderWeaponType
; ---------------------------------------------------------------------------
word_13992:     dc.w    $87B4, $87B5, $87B6, $87B7, $87B8, $87B9, $87BA, $87BB
                                        ; DATA XREF: UI_LoadWeaponTiles+8   o
                dc.w    $87BC, $87BD, $87BE, $87BF, $87C0, $87C1, $87C2, $87C3
                dc.w    $A7B4, $A7B5, $A7B6, $A7B7, $A7B8, $A7B9, $A7BA, $A7BB
                dc.w    $A7BC, $A7BD, $A7BE, $A7BF, $A7C0, $A7C1, $A7C2, $A7C3
                dc.w    $C7B4, $C7B5, $C7B6, $C7B7, $C7B8, $C7B9, $C7BA, $C7BB
                dc.w    $C7BC, $C7BD, $C7BE, $C7BF, $C7C0, $C7C1, $C7C2, $C7C3
                dc.w    $E7B4, $E7B5, $E7B6, $E7B7, $E7B8, $E7B9, $E7BA, $E7BB
                dc.w    $E7BC, $E7BD, $E7BE, $E7BF, $E7C0, $E7C1, $E7C2, $E7C3

; Decodes and displays RGB color value
UI_DecodeColorValue:                                    ; CODE XREF: DebugMenu_UpdateActive+84   p  ; was: sub_13A12
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                add.w   (word_FF8664).w,d0
                addi.w  #-$1C80,d0
                movea.w d0,a0
                move.w  (a0),d0
                move.w  d0,d1
                move.w  d1,d2
                andi.w  #$E00,d0
                asr.w   #8,d0
                addi.w  #-$383C,d0
                move.w  d0,(word_FF85B6).w
                andi.w  #$E0,d1
                asr.w   #4,d1
                addi.w  #-$383C,d1
                move.w  d1,(word_FF85B8).w
                andi.w  #$E,d2
                addi.w  #-$383C,d2
                move.w  d2,(word_FF85BA).w
                rts
; End of function UI_DecodeColorValue
; Updates RGB color value from input
UI_UpdateColorValue:                                    ; CODE XREF: UI_MenuColorPicker+24   p  ; was: sub_13A52
                move.w  (word_FF8662).w,d0
                asl.w   #4,d0
                add.w   (word_FF8664).w,d0
                addi.w  #-$1C80,d0
                movea.w d0,a0
                move.b  (word_FFF708).w,d1
                move.w  (a0),d0
                move.w  d0,d2
                move.w  (word_FF8668).w,d3
                beq.s   loc_13AB6
                cmpi.w  #2,d3
                beq.s   loc_13A96
                andi.w  #$EE0,d0
                btst    #0,d1
                beq.s   loc_13A86
                subi.w  #2,d2
                bra.s   loc_13A90
; ---------------------------------------------------------------------------
loc_13A86:                                              ; CODE XREF: UI_UpdateColorValue+2C   j
                btst    #1,d1
                beq.s   loc_13A90
                addi.w  #2,d2
loc_13A90:                                              ; CODE XREF: UI_UpdateColorValue+32   j
                                        ; UI_UpdateColorValue+38   j
                andi.w  #$E,d2
                bra.s   loc_13AD4
; ---------------------------------------------------------------------------
loc_13A96:                                              ; CODE XREF: UI_UpdateColorValue+22   j
                andi.w  #$E0E,d0
                btst    #0,d1
                beq.s   loc_13AA6
                subi.w  #$20,d2                         ; ' '
                bra.s   loc_13AB0
; ---------------------------------------------------------------------------
loc_13AA6:                                              ; CODE XREF: UI_UpdateColorValue+4C   j
                btst    #1,d1
                beq.s   loc_13AB0
                addi.w  #$20,d2                         ; ' '
loc_13AB0:                                              ; CODE XREF: UI_UpdateColorValue+52   j
                                        ; UI_UpdateColorValue+58   j
                andi.w  #$E0,d2
                bra.s   loc_13AD4
; ---------------------------------------------------------------------------
loc_13AB6:                                              ; CODE XREF: UI_UpdateColorValue+1C   j
                andi.w  #$EE,d0
                btst    #0,d1
                beq.s   loc_13AC6
                subi.w  #$200,d2
                bra.s   loc_13AD0
; ---------------------------------------------------------------------------
loc_13AC6:                                              ; CODE XREF: UI_UpdateColorValue+6C   j
                btst    #1,d1
                beq.s   loc_13AD0
                addi.w  #$200,d2
loc_13AD0:                                              ; CODE XREF: UI_UpdateColorValue+72   j
                                        ; UI_UpdateColorValue+78   j
                andi.w  #$E00,d2
loc_13AD4:                                              ; CODE XREF: UI_UpdateColorValue+42   j
                                        ; UI_UpdateColorValue+62   j
                add.w   d2,d0
                move.w  d0,-$80(a0)
                move.w  d0,(a0)
                rts
; End of function UI_UpdateColorValue
; Updates all boss collision detection systems including terrain and projectiles
