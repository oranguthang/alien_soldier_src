; Updates a type-$B8 converted defeat part with repeated bounces and optional rotation frames
Effect_TerobusterDefeatPartUpdate:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_390F0
                jsr     (RandomNumber).l
                tst.w   4(a5)
                bne.s   Effect_TerobusterDefeatPartUpdateBounce
                addq.w  #2,4(a5)
                move.w  #$CF00,2(a5)
                tst.l   $4C(a5)
                bne.s   Effect_TerobusterDefeatPartInitialize
                move.w  #$8F00,2(a5)
Effect_TerobusterDefeatPartInitialize:                  ; CODE XREF: Effect_TerobusterDefeatPartUpdate+1A   j  ; was: loc_39112
                move.w  #1,$48(a5)
                move.w  (dword_FFFF08+2).w,$56(a5)
                bra.s   Effect_TerobusterDefeatPartLaunchBounce
; ---------------------------------------------------------------------------
Effect_TerobusterDefeatPartUpdateBounce:                ; CODE XREF: Effect_TerobusterDefeatPartUpdate+A   j  ; was: loc_39120
                btst    #0,(word_FFA000+1).w
                beq.s   Effect_TerobusterDefeatPartApplyGravity
                tst.w   $54(a5)
                bpl.s   Effect_TerobusterDefeatPartDecreaseRotationStep
                cmpi.w  #$FFFF,$54(a5)
                beq.s   Effect_TerobusterDefeatPartApplyGravity
                addq.w  #1,$54(a5)
                bra.s   Effect_TerobusterDefeatPartApplyGravity
; ---------------------------------------------------------------------------
Effect_TerobusterDefeatPartDecreaseRotationStep:        ; CODE XREF: Effect_TerobusterDefeatPartUpdateBounce+10   j  ; was: loc_3913C
                cmpi.w  #1,$54(a5)
                beq.s   Effect_TerobusterDefeatPartApplyGravity
                subq.w  #1,$54(a5)
Effect_TerobusterDefeatPartApplyGravity:                ; CODE XREF: Effect_TerobusterDefeatPartUpdateBounce+2   j  ; was: loc_39148
                                        ; Effect_TerobusterDefeatPartUpdateBounce+14   j
                addi.l  #$4000,$1C(a5)
                bmi.s   Effect_TerobusterDefeatPartUpdateAnimation
                tst.w   $48(a5)
                beq.s   Effect_TerobusterDefeatPartUpdateAnimation
                cmpi.w  #$140,$14(a5)
                bmi.s   Effect_TerobusterDefeatPartUpdateAnimation
                clr.w   $48(a5)
Effect_TerobusterDefeatPartLaunchBounce:                ; CODE XREF: Effect_TerobusterDefeatPartInitialize+E   j  ; was: loc_39164
                move.l  #$FFFCF000,$1C(a5)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #7,d0
                swap    d0
                subi.l  #$38000,d0
                move.l  d0,$18(a5)
                tst.w   $18(a5)
                bmi.s   Effect_TerobusterDefeatPartSetNegativeRotationStep
                move.w  #8,$54(a5)
                bra.s   Effect_TerobusterDefeatPartUpdateAnimation
; ---------------------------------------------------------------------------
Effect_TerobusterDefeatPartSetNegativeRotationStep:     ; CODE XREF: Effect_TerobusterDefeatPartLaunchBounce+2C   j  ; was: loc_39190
                move.w  #$FFF8,$54(a5)
Effect_TerobusterDefeatPartUpdateAnimation:             ; CODE XREF: Effect_TerobusterDefeatPartApplyGravity+6   j  ; was: loc_39196
                                        ; Effect_TerobusterDefeatPartApplyGravity+C   j
                move.l  $4C(a5),d1
                beq.s   Effect_TerobusterDefeatPartReturn
                movea.l d1,a0
                andi.w  #$E7FF,$E(a5)
                move.w  $56(a5),d0
                add.w   $54(a5),d0
                move.w  d0,$56(a5)
                andi.w  #$2C,d0                         ; ','
                cmpi.w  #$20,d0                         ; ' '
                bmi.s   Effect_TerobusterDefeatPartSelectFrame
                bset    #3,$E(a5)
Effect_TerobusterDefeatPartSelectFrame:                 ; CODE XREF: Effect_TerobusterDefeatPartUpdateAnimation+2A   j  ; was: loc_391C0
                andi.w  #$1C,d0
                move.l  (a0,d0.w),8(a5)
Effect_TerobusterDefeatPartReturn:                      ; CODE XREF: Effect_TerobusterDefeatPartUpdateAnimation+4   j  ; was: locret_391CA
                rts
; End of function Effect_TerobusterDefeatPartUpdate
