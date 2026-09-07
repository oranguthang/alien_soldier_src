Boss_CaterpillarMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_3D0AE
                move.w  4(a5),d0
                movea.w off_3D0BE(pc,d0.w),a0
                adda.l  #Boss_CaterpillarInit,a0
                jmp     (a0)
; End of function Boss_CaterpillarMain
; ---------------------------------------------------------------------------
off_3D0BE:      dc.w    Boss_CaterpillarInit-Boss_CaterpillarInit
                                        ; DATA XREF: Boss_CaterpillarMain+4   r
                dc.w    Boss_CaterpillarAnimateWave-Boss_CaterpillarInit

; Initializes caterpillar boss entity
Boss_CaterpillarInit:                                   ; DATA XREF: Boss_CaterpillarMain+8   o  ; was: sub_3D0C2
                                        ; ROM:off_3D0BE   o
                addq.w  #2,4(a5)
                bra.w   Boss_CaterpillarInitSegments
; End of function Boss_CaterpillarInit
; Animates wave pattern for caterpillar movement
Boss_CaterpillarAnimateWave:                            ; DATA XREF: ROM:0003D0C0   o  ; was: sub_3D0CA
                addq.w  #4,$56(a5)
                andi.w  #$1FE,$56(a5)
                move.w  $56(a5),d0
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$FFDA,d1
                moveq   #$A,d7
loc_3D0E2:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+1C   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                dbf     d7,loc_3D0E2
                subi.w  #$10,d0
                moveq   #3,d7
loc_3D0F0:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+28   j
                move.w  d0,(a0)+
                dbf     d7,loc_3D0F0
                add.w   d1,d0
                moveq   #$17,d7
loc_3D0FA:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+40   j
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                subq.w  #6,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                move.w  d0,(a0)+
                add.w   d1,d0
                dbf     d7,loc_3D0FA
                moveq   #9,d7
loc_3D110:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+4A   j
                move.w  d0,(a0)+
                addq.w  #6,d0
                dbf     d7,loc_3D110
                move.w  (dword_FFA908).w,d0
                subi.w  #$200,d0
                subq.w  #1,d0
                andi.w  #$FFF0,d0
                asr.w   #3,d0
                addi.w  #-$6800,d0
                movea.w d0,a0
                movea.w #(dword_FF8A00-M68K_RAM),a1
                lea     (word_1B514).l,a2
                move.w  #$1FE,d2
                move.w  #$10,d3
                moveq   #$13,d7
loc_3D142:                                              ; CODE XREF: Boss_CaterpillarAnimateWave+8A   j
                move.w  (a0)+,d0
                and.w   d2,d0
                move.w  (a2,d0.w),d1
                ext.l   d1
                asl.l   #6,d1
                swap    d1
                sub.w   d3,d1
                move.w  d1,(a1)+
                dbf     d7,loc_3D142
                rts
; End of function Boss_CaterpillarAnimateWave
; Initializes caterpillar body segments from table
