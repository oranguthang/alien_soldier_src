Sys_CheckRegionLock:                                ; DATA XREF: Sys_DispatchGameState:off_C7C   o  ; was: sub_4BA
                tst.w   (GameSubstateIndex).w
                bne.w   locret_580
                move.b  (IO_PCBVER+1).l,d0
                bpl.s Sys_SetGameModeFlags
                btst    #6,d0
                beq.s   RegionRestricted

; Branch target that sets game mode flags after region check passes.
Sys_SetGameModeFlags:                                ; CODE XREF: Sys_CheckRegionLock+E   j  ; was: loc_4D0
                move.w  #4,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                rts
; End of function Sys_CheckRegionLock
RegionRestricted:                       ; CODE XREF: Sys_CheckRegionLock+14   j
                clr.w   (word_FFFF28).w
                jsr (Sys_InitFullGame).l
                move.b  #4,d0
                jsr (Input_ProcessButtons).l
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                jsr (Gfx_QueueVRAMCommand).l
                lea     (byte_BA4A).l,a0
                jsr     (LoadPalette).l
                move.w  #$8300,d0
                move.w  #$438C,d4
                lea     byte_582(pc),a0
                nop
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8300,d0
                move.w  #$4518,d4
                lea     byte_59E(pc),a0
                nop
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8300,d0
                move.w  #$46A4,d4
                lea     byte_5AE(pc),a0
                nop
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8300,d0
                move.w  #$4808,d4
                lea     byte_5B2(pc),a0
                nop
                jsr (UI_RenderTextStringWrapped).l
                move.w  #$8300,d0
                move.w  #$49A0,d4
                lea     byte_5D2(pc),a0
                nop
                jsr (UI_RenderTextStringWrapped).l
                bset    #6,(word_FFF7D2+1).w
                move.b  #$80,(byte_FFF755).w
                addq.w  #4,(GameSubstateIndex).w
locret_580:                             ; CODE XREF: Sys_CheckRegionLock+4   j
                rts
; End of function RegionRestricted
; ---------------------------------------------------------------------------
byte_582:       dc.b $E, $F, $20, $F, $16, $19, $1A, $F
                                        ; DATA XREF: RegionRestricted+38   o
                dc.b $E, 0, $10, $19, $1C, 0, $1F, $1D
                dc.b $F, 0, $19, $18, $16, $23, 0, $21
                dc.b $13, $1E, $12, $FF
byte_59E:       dc.b $18, $1E, $1D, $D, 0, $17, $F, $11
                                        ; DATA XREF: RegionRestricted+4C   o
                dc.b $B, 0, $E, $1C, $13, $20, $F, $FF
byte_5AE:       dc.b $B, $18, $E, $FF   ; DATA XREF: RegionRestricted+60   o
byte_5B2:       dc.b $1A, $B, $16, 0, $B, $18, $E, 0
                                        ; DATA XREF: RegionRestricted+74   o
                dc.b $10, $1C, $F, $18, $D, $12, 0, $1D
                dc.b $F, $D, $B, $17, 0, $17, $F, $11
                dc.b $B, 0, $E, $1C, $13, $20, $F, $FF
byte_5D2:       dc.b $1D, $23, $1D, $1E, $F, $17, $1D, $25
                                        ; DATA XREF: RegionRestricted+88   o
                dc.b $FF, $FF
