; Copy object data to buffer
Object_CopyDataBlock:
                move.w  (word_FFA402).w,(word_FFA802).w  ; was: sub_1CCB6
                move.l  (dword_FFA408).w,(dword_FFA808).w
                move.w  (word_FFA40C).w,(word_FFA80C).w
                move.w  (word_FFA40E).w,(word_FFA80E).w
                move.w  #$120,(word_FFA810).w
                move.w  #$F0,(word_FFA814).w
                clr.w   (word_FFA812).w
                clr.w   (word_FFA816).w
                clr.l   (dword_FFA818).w
                clr.l   (dword_FFA81C).w
                rts
; End of function Object_CopyDataBlock
