Entity_EmptyState3:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: nullsub_3
                rts
; End of function Entity_EmptyState3
; ---------------------------------------------------------------------------
word_5A43E:     binclude "data/other/word_5A43E.bin"
word_5A43E_End:
                ; dc.b [$257B2]$FF
                org     $82324

; Attributes: thunk
; Thunk to main sound driver update
