UI_AddScoreBCD:                                         ; CODE XREF: Text_FinalizeAndSaveScore+14   p  ; was: sub_3954
                                        ; Collision_CheckWeaponProjectilesAgainstEnemies+E2   p
                tst.w   (StageTimeRemaining).w
                beq.s   locret_397C
                lea     (word_FFA216).w,a0
                clr.b   (byte_FFA005).w
                move.l  d0,(dword_FFA006).w
                lea     (word_FFA00A).w,a1
                sub.w   d0,d0
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                abcd    -(a1),-(a0)
                bcc.s   locret_397C
                move.l  #$99999999,(a0)
locret_397C:                                            ; CODE XREF: UI_AddScoreBCD+4   j
                                        ; UI_AddScoreBCD+20   j
                rts
; End of function UI_AddScoreBCD
nullsub_14:
                rts
; End of function nullsub_14

RandomNumber:                                           ; CODE XREF: Sys_VBlankHandler+52   p
                                        ; sub_7D68:loc_7DEA   p
                move.l  d1,-(sp)
                move.l  (dword_FFFF08).w,d1
                bne.s   loc_398E
                move.l  #'*m6Z',d1
loc_398E:                                               ; CODE XREF: RandomNumber+6   j
                move.l  d1,d0
                asl.l   #2,d1
                add.l   d0,d1
                asl.l   #3,d1
                add.l   d0,d1
                move.w  d1,d0
                swap    d1
                add.w   d1,d0
                move.w  d0,d1
                swap    d1
                move.l  d1,(dword_FFFF08).w
                move.l  (sp)+,d1
                rts
; End of function RandomNumber

; Handles palette fade transition with bit adjustments and color blending for screen transitions
