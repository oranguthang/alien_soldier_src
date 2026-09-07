Reset:                                  ; DATA XREF: ROM:00000004   o
                                        ; Reset:ChecksumCheck   o
                tst.l   (IO_CT1_CTRL).l
                bne.s   loc_20E
                tst.w   (IO_EXT_CTRL).l
loc_20E:                                ; CODE XREF: Reset+6   j
                bne.s Sys_InitBootstrap
                lea     word_28E(pc),a5
                movem.w (a5)+,d5-d7
                movem.l (a5)+,a0-a4
                move.b  -$10FF(a1),d0
                andi.b  #$F,d0
                beq.s   loc_22E
                move.l  #'SEGA',$2F00(a1)
loc_22E:                                ; CODE XREF: Reset+24   j
                move.w  (a4),d0
                moveq   #0,d0
                movea.l d0,a6
                move.l  a6,usp
                moveq   #$17,d1
loc_238:                                ; CODE XREF: Reset+3E   j
                move.b  (a5)+,d5
                move.w  d5,(a4)
                add.w   d7,d5
                dbf     d1,loc_238
                move.l  (a5)+,(a4)
                move.w  d0,(a3)
                move.w  d7,(a1)
                move.w  d7,(a2)
loc_24A:                                ; CODE XREF: Reset+4C   j
                btst    d0,(a1)
                bne.s   loc_24A
                moveq   #$25,d2 ; '%'
loc_250:                                ; CODE XREF: Reset+52   j
                move.b  (a5)+,(a0)+
                dbf     d2,loc_250
                move.w  d0,(a2)
                move.w  d0,(a1)
                move.w  d7,(a2)
loc_25C:                                ; CODE XREF: Reset+5E   j
                move.l  d0,-(a6)
                dbf     d6,loc_25C
                move.l  (a5)+,(a4)
                move.l  (a5)+,(a4)
                moveq   #$1F,d3
loc_268:                                ; CODE XREF: Reset+6A   j
                move.l  d0,(a3)
                dbf     d3,loc_268
                move.l  (a5)+,(a4)
                moveq   #$13,d4
loc_272:                                ; CODE XREF: Reset+74   j
                move.l  d0,(a3)
                dbf     d4,loc_272
                moveq   #3,d5
loc_27A:                                ; CODE XREF: Reset+7E   j
                move.b  (a5)+,$11(a3)
                dbf     d5,loc_27A
                move.w  d0,(a2)
                movem.l (a6),d0-d7/a0-a6
                move    #$2700,sr
; Jump target that branches to initialization code after register restoration during boot sequence.
Sys_InitBootstrap:                                ; CODE XREF: Reset:loc_20E   j  ; was: loc_28C
                bra.s   loc_2FA
; ---------------------------------------------------------------------------
word_28E:       dc.w $8000              ; DATA XREF: Reset+10   o
                dc.w $3FFF
                dc.w $100
                dc.l Z80_RAM
                dc.l IO_Z80BUS
                dc.l IO_Z80RES
                dc.l VDP_DATA
                dc.l VDP_CTRL
                dc.w $414, $303C, $76C, 0, 0, $FF00, $8137, 1, $100, $FF
                dc.w $FF00, $80, $4000, $80, $AF01, $D91F, $1127, $21, $2600, $F977
                dc.w $EDB0, $DDE1, $FDE1, $ED47, $ED4F, $D1E1, $F108, $D9C1, $D1E1, $F1F9
                dc.w $F3ED, $5636, $E9E9, $8104, $8F02, $C000, 0, $4000, $10, $9FBF
                dc.w $DFFF
; ---------------------------------------------------------------------------
loc_2FA:                                ; CODE XREF: Reset:loc_28C   j
                tst.w   (VDP_CTRL).l
                move    #$2700,sr
                move.w  #0,(IO_Z80RES).l
                move.w  #$100,(IO_Z80RES).l
                move.b  (IO_PCBVER+1).l,d0
                move.b  d0,d7
                andi.b  #$F,d0
                beq.s   loc_32C
                move.l  #'SEGA',(IO_TMSS).l
loc_32C:                                ; CODE XREF: Reset+120   j
                btst    #6,(IO_EXT_DATA+1).l
                beq.w   ChecksumCheck
                cmpi.l  #'TREA',(dword_FFFF10).w
                bne.w   ChecksumCheck
                cmpi.l  #'SURE',(dword_FFFF14).w
                beq.w   loc_3C8
ChecksumCheck:                          ; CODE XREF: Reset+134   j
                                        ; Reset+140   j
                movea.l #Reset,a0
                move.l  #$60000,d0
                moveq   #0,d1
loc_35E:                                ; CODE XREF: Reset+162   j
                add.w   (a0)+,d1
                cmp.l   a0,d0
                bcc.s   loc_35E
                movea.l #Checksum,a1
                cmp.w   (a1),d1
                bne.w   ShowRedScreen
                lea     (dword_FFFF00).w,a1
                moveq   #0,d1
                move.w  #$3F,d0 ; '?'
GameProgram:                            ; CODE XREF: Reset+17C   j
                move.l  d1,(a1)+
                dbf     d0,GameProgram
                move.l  #'TREA',(dword_FFFF10).w
                move.l  #'SURE',(dword_FFFF14).w
                move.b  (IO_PCBVER+1).l,(byte_FFFF26).w
                move.w  #2,(word_FFFF0E).w
                move.l  #$100000,(dword_FFFF2C).w
                move.w  #0,(word_FFFF2A).w
                move.b  #0,(byte_FFFF30).w
                clr.w   (word_FFFF38).w
                clr.w   (word_FFFF3E).w
                move.w  #0,(word_FFFF36).w
                move.l  #$1010101,(dword_FFFF3A).w
loc_3C8:                                ; CODE XREF: Reset+14C   j
                move.b  #0,(byte_FFFF31).w
                move.b  #6,(byte_FFFF20).w
                move.b  #6,(byte_FFFF21).w
                move.b  #4,(byte_FFFF22).w
                move.b  #4,(byte_FFFF23).w
                move.b  #5,(byte_FFFF24).w
                move.b  #5,(byte_FFFF25).w
                clr.w   (word_FFFF5A).w
                clr.w   (word_FFFF62).w
loc_3FA:                                ; CODE XREF: Reset+204   j
                move.w  (VDP_CTRL).l,d0
                btst    #1,d0
                bne.s   loc_3FA
                lea     (M68K_RAM).l,a0
                moveq   #0,d0
                move.w  #$3FBF,d1
loc_412:                                ; CODE XREF: Reset+214   j
                move.l  d0,(a0)+
                dbf     d1,loc_412
                jsr (Gfx_InitVDPRegisters).l
                jsr (Input_InitControllers).l
                jsr (Sys_ClearGameBuffers).l
loc_42A:                                ; CODE XREF: Reset+232   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_42A
                lea     (Z80_RAM).l,a0
                moveq   #0,d0
                move.w  #$7FF,d1
loc_440:                                ; CODE XREF: Reset+242   j
                move.l  d0,(a0)+
                dbf     d1,loc_440
                jsr (Sound_InitDriverThunk).l
                move.b  #4,(dword_FFF80A).w
                jsr (Sound_UpdateThunk).l
                move.b  #1,(byte_FFF704).w
                move    #$2300,sr
; Infinite loop that calls sound update and main game routine at the core of the game execution.
Sys_MainGameLoop:                                ; CODE XREF: Reset+26C   j  ; was: loc_462
                move    #$2300,sr
                jsr (Sys_DispatchDataLoader).l
                bra.s Sys_MainGameLoop
; End of function Reset


Reserv3F:                               ; DATA XREF: ROM:00000028   o
                                        ; ROM:0000002C   o ...
                stop    #$2700
; End of function Reserv3F


IRQ7:                                   ; DATA XREF: ROM:00000064   o
                                        ; ROM:00000068   o ...
                stop    #$2700
; End of function IRQ7


Trap15:                                 ; DATA XREF: ROM:00000080   o
                                        ; ROM:00000084   o ...
                stop    #$2700
; End of function Trap15


BusErr:                                 ; DATA XREF: ROM:00000008   o
                stop    #$2700
; End of function BusErr


AdrErr:                                 ; DATA XREF: ROM:0000000C   o
                stop    #$2700
; End of function AdrErr


InvOpCode:                              ; DATA XREF: ROM:00000010   o
                stop    #$2700
; End of function InvOpCode


DivBy0:                                 ; DATA XREF: ROM:00000014   o
                stop    #$2700
; End of function DivBy0


Check:                                  ; DATA XREF: ROM:00000018   o
                stop    #$2700
; End of function Check


TrapV:                                  ; DATA XREF: ROM:0000001C   o
                stop    #$2700
; End of function TrapV


GPF:                                    ; DATA XREF: ROM:00000020   o
                stop    #$2700
; End of function GPF


Trace:                                  ; DATA XREF: ROM:00000024   o
                stop    #$2700
; End of function Trace


ShowRedScreen:                          ; CODE XREF: Reset+16C   j
                jsr (Gfx_InitVDPRegisters).l
                move.l  #$C0000000,(VDP_CTRL).l
                moveq   #$3F,d7 ; '?'
endless_loop:                           ; CODE XREF: ShowRedScreen+1A   j
                move.w  #$E,(VDP_DATA).l
                dbf     d7,endless_loop
loc_4B8:                                ; CODE XREF: ShowRedScreen:loc_4B8   j
                bra.s   loc_4B8
; End of function ShowRedScreen


; Checks console region via IO_PCBVER and sets up region flags (region check disabled in this code).
