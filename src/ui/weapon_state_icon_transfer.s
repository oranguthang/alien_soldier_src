UI_QueuePendingWeaponStateIconTransfer:                 ; was: sub_133D4
                move.w  (WeaponIconTransferState).w,d0
                beq.s   UI_QueuePendingWeaponStateIconTransfer_Return
                cmpi.w  #1,d0
                beq.s   UI_QueuePendingWeaponStateIconTransfer_Return
                move.w  #1,(WeaponIconTransferState).w
                movea.w #(byte_FF8488-M68K_RAM),a5
                move.w  #$82,-(a5)
                move.w  #$7400,-(a5)
                lea     WeaponStateIconSourceTable(pc),a0
                nop
                subq.w  #4,d0
                move.l  (a0,d0.w),d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                move.b  d0,-(a5)
                move.b  #$95,-(a5)
                move.b  d1,-(a5)
                move.b  #$96,-(a5)
                move.b  d2,-(a5)
                move.b  #$97,-(a5)
                move.w  #$8F02,-(a5)
                move.l  #$94029300,-(a5)
UI_QueuePendingWeaponStateIconTransfer_Return:          ; was: locret_13428
                rts
; End of function UI_QueuePendingWeaponStateIconTransfer
; ---------------------------------------------------------------------------
WeaponStateIconSourceTable: dc.l    WeaponStateIconSpriteArtA  ; was: off_1342A
                dc.l    WeaponStateIconSpriteArtB
                dc.l    WeaponStateIconSpriteArtC
                dc.l    WeaponStateIconSpriteArtC
                dc.l    WeaponStateIconSpriteArtD
                dc.l    WeaponStateIconSpriteArtD
                dc.l    WeaponStateIconSpriteArtD
                dc.l    WeaponStateIconSpriteArtD

UI_QueueWeaponStateIconTransferFromSource:              ; was: sub_1344A
                move.w  #1,(WeaponIconTransferState).w
                movea.w #(byte_FF8488-M68K_RAM),a0
                move.w  #$82,-(a0)
                move.w  #$7400,-(a0)
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d2
                move.b  (dword_FF8040+1).w,d3
                andi.w  #$7F,d3
                move.b  d0,-(a0)
                move.b  #$95,-(a0)
                move.b  d2,-(a0)
                move.b  #$96,-(a0)
                move.b  d3,-(a0)
                move.b  #$97,-(a0)
                move.w  #$8F02,-(a0)
                move.l  d1,-(a0)
                rts
; End of function UI_QueueWeaponStateIconTransferFromSource
