word_1CF762:    dc.w    $810, $F00, $F020               ; DATA XREF: Stage24_Init+36   o
                dc.w    $800, $F00, $F040
                dc.w    $820, $F00, $F000
                dc.w    $830, $F00, $F0E0
                dc.w    $8840, $F00, $F0C0
word_1CF780:    dc.w    0, $F00, $F0C0                  ; DATA XREF: Stage24_Init+84   o
                dc.w    $860, $F00, $F0E0
                dc.w    $30, $F00, $F020
                dc.w    $8850, $F00, $F000
byte_1CF798:    dc.b    0, $24, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0
                                        ; DATA XREF: ROM:00011C5E   o
                dc.b    $5F, 0, 0, $53, 0, 0
byte_1CF7BE:    dc.b    0, $45, 0, 0, $24, $82, $24, 0, $88, 8, $88, $A, $98, $13, $69, $82
                                        ; DATA XREF: ROM:00011D7E   o
                dc.b    $82, $82, 0, $82, 0, $82, $82, 0, $82, $82, 0, $94, $32, $94, $33, $5F
                dc.b    0, 0, $98, $47, $90, $69, $9C, $D, $FC, $63, $5F, 0, 0, $5F, 0, 0
                dc.b    $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F, 0, 0, $5F
                dc.b    0, 0, $58, 0, 0, 0, 0
                ; dc.b [$307FA]$FF
                org     $1FFFFF
byte_1FFFFF:    dc.b    $FF                             ; DATA XREF: ROM:RomEnd   o
; end of 'ROM'
