Stage24_UpdateBackground:                               ; DATA XREF: ROM:00033A62   o  ; was: sub_33C4A
                bclr    #7,2(a5)
                move.w  (dword_FFDB34).w,$14(a5)
                bsr.w   Stage24_PaletteUpdate
                move.w  #4,$48(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                move.w  #4,$4C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Stage24_UpdateBackground
; Foreground update
Stage24_UpdateForeground:                               ; DATA XREF: ROM:00033A64   o  ; was: sub_33C72
                move.w  (dword_FFDB34).w,$14(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_33CD6
                subq.w  #1,$4C(a5)
                beq.s   loc_33CD8
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   loc_33CD0
                move.w  #$10,(a0)
                move.l  #off_E95DC,8(a0)
                jsr     (Sprite_InitType160).l
                move.b  #$60,$20(a0)                    ; '`'
                move.l  #$FE02F40C,$2C(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$32,$26(a0)                    ; '2'
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),d0
                sub.w   $4A(a5),d0
                move.w  d0,$14(a0)
                addi.w  #8,$4A(a5)
loc_33CD0:                                              ; CODE XREF: Stage24_UpdateForeground+18   j
                move.w  #4,$48(a5)
locret_33CD6:                                           ; CODE XREF: Stage24_UpdateForeground+A   j
                rts
; ---------------------------------------------------------------------------
loc_33CD8:                                              ; CODE XREF: Stage24_UpdateForeground+10   j
                move.w  $4A(a5),d0
                sub.w   d0,$14(a5)
                move.l  #off_E953C,8(a5)
                jmp     Sprite_InitType160FromCurrent
; End of function Stage24_UpdateForeground
; Palette update
Stage24_PaletteUpdate:                                  ; CODE XREF: Stage24_UpdateBackground+C   p  ; was: sub_33CEE
                move.w  #2,d7
                move.w  #$40,d6                         ; '@'
                lea     (Math_SineTable).l,a3
loc_33CFC:                                              ; CODE XREF: Stage24_PaletteUpdate+28   j
                move.w  d6,d5
                move.w  (a3,d5.w),d2
                move.w  -$80(a3,d5.w),d3
                ext.l   d2
                ext.l   d3
                asl.l   #3,d2
                asl.l   #3,d3
                bsr.w   Stage24_TileUpdate
                addi.w  #$40,d6                         ; '@'
                dbf     d7,loc_33CFC
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
                rts
; End of function Stage24_PaletteUpdate
; Tile update
Stage24_TileUpdate:                                     ; CODE XREF: Stage24_PaletteUpdate+20   p  ; was: sub_33D26
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_33D56
                jsr     (Sprite_InitType160).l
                move.b  #$60,$20(a0)                    ; '`'
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  d2,$18(a0)
                move.l  d3,$1C(a0)
locret_33D56:                                           ; CODE XREF: Stage24_TileUpdate+6   j
                rts
; End of function Stage24_TileUpdate
; Initializes Missiray bullet projectile with graphics and parameters
Projectile_InitMissirayBullet:                          ; CODE XREF: Orphaned_RisingShotPairFireMissirayShot+2C   p  ; was: sub_33D58
                                        ; Segment_MissirayType1Fire+54   p
                move.w  #$3CC,(a0)
                move.l  #off_ED152,8(a0)
                clr.w   $C(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #$EC00,2(a0)
                move.w  #$300,$E(a0)
                move.b  #$C0,$21(a0)
                move.b  #8,$23(a0)
                move.w  #$28,$24(a0)                    ; '('
                move.w  #$50,$26(a0)                    ; 'P'
                move.b  #$60,$20(a0)                    ; '`'
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.l  d2,$58(a0)
                rts
; End of function Projectile_InitMissirayBullet
; Dispatches boss projectile state based on damage and conditions
