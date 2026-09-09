; Victor, Sunset Sting, and Viblack sprite mappings
word_EBE94:     dc.w    $4038, $700, $F0F0              ; DATA XREF: Boss_VictorDeployRing+66   o
                                        ; Boss_VictorRetractRing+A6   o
                dc.w    $C838, $700, $F000
word_EBEA0:     dc.w    $C840, $A00, $F3F3              ; DATA XREF: Boss_VictorReverseRing+62   o
                                        ; Boss_SunsetStingUpdateMovement+108   o
word_EBEA6:     dc.w    $1810, $400, $ECF8              ; DATA XREF: ROM:0004330A   o
                dc.w    $9800, $F00, $F4F0
word_EBEB2:     dc.w    $1022, $400, $EDF6              ; DATA XREF: ROM:0004330E   o
                dc.w    $9012, $F00, $F5EF
word_EBEBE:     dc.w    $9024, $F00, $F2F1              ; DATA XREF: ROM:00043312   o
word_EBEC4:     dc.w    $1044, $100, $F7EB              ; DATA XREF: ROM:00043316   o
                dc.w    $9034, $F00, $F0F3
word_EBED0:     dc.w    $84E, $100, $F70D               ; DATA XREF: ROM:Boss_SunsetStingSegmentMappings   o
                dc.w    $1846, $D00, $FFED
                dc.w    $8846, $D00, $EFED
word_EBEE2:     dc.w    $1844, $100, $F60D              ; DATA XREF: ROM:000432FE   o
                dc.w    $9834, $F00, $EFED
word_EBEEE:     dc.w    $9824, $F00, $F1EF              ; DATA XREF: ROM:00043302   o
word_EBEF4:     dc.w    $1822, $400, $ECFA              ; DATA XREF: ROM:00043306   o
                dc.w    $9812, $F00, $F4F1
word_EBF00:     dc.w    $8865, $800, $FCF4              ; DATA XREF: ROM:Boss_SunsetStingDestroyedSegmentMappings   o
word_EBF06:     dc.w    $985F, $900, $F4F3              ; DATA XREF: ROM:0004331E   o
word_EBF0C:     dc.w    $1859, $100, $FEF8              ; DATA XREF: ROM:00043322   o
                dc.w    $985B, $500, $F600
word_EBF18:     dc.w    $9853, $600, $F4FB              ; DATA XREF: ROM:00043326   o
word_EBF1E:     dc.w    $9850, $200, $F4FC              ; DATA XREF: ROM:0004332A   o
word_EBF24:     dc.w    $9053, $600, $F4F5              ; DATA XREF: ROM:0004332E   o
word_EBF2A:     dc.w    $1059, $100, $FF01              ; DATA XREF: ROM:00043332   o
                dc.w    $905B, $500, $F7F1
word_EBF36:     dc.w    $905F, $900, $F5F6              ; DATA XREF: ROM:00043336   o
                dc.w    $986E, $400, $FBF6
                dc.w    $986C, $400, $FCF6
                dc.w    $986A, $400, $FCF4
                dc.w    $9868, $100, $F9FB
                dc.w    $8070, $100, $F9FC
                dc.w    $9068, $100, $F9FC
                dc.w    $906A, $400, $FCFB
                dc.w    $906C, $400, $FCFA
word_EBF6C:     dc.w    $BB, $D00, $FFE0                ; DATA XREF: ROM:off_43892   o
                dc.w    $88BB, $D00, $FF00
word_EBF78:     dc.w    $C3, $D00, $FFE0                ; DATA XREF: ROM:00043896   o
                dc.w    $88C3, $D00, $FF00
word_EBF84:     dc.w    $CB, $D00, $FFE0                ; DATA XREF: ROM:0004389A   o
                                        ; Boss_SunsetStingDefeatCoreInitializeState+6   o
                dc.w    $88CB, $D00, $FF00
word_EBF90:     dc.w    $8D3, $A00, $F6F4               ; DATA XREF: ROM:off_EBFC0   o
                dc.w    $88DF, $800, $8F4
word_EBF9C:     dc.w    $8D3, $A00, $F8F4               ; DATA XREF: ROM:000EBFC4   o
                                        ; ROM:off_EBFCC   o
                dc.w    $88DC, $800, $8F4
word_EBFA8:     dc.w    $8D3, $A00, $F7F4               ; DATA XREF: ROM:000EBFD0   o
                                        ; ROM:000EBFD8   o
                dc.w    $88DC, $800, $8F4
word_EBFB4:     dc.w    $8D3, $A00, $F6F4               ; DATA XREF: ROM:000EBFD4   o
                dc.w    $88DC, $800, $8F4
off_EBFC0:      dc.w    word_EBF90-*                    ; DATA XREF: ROM:0004393C   o
                                        ; ROM:000EBFC8   o
                dc.w    5
                dc.w    word_EBF9C-*
                dc.w    5
                dc.w    off_EBFC0-*
                dc.w    0
off_EBFCC:      dc.w    word_EBF9C-*                    ; DATA XREF: ROM:00043940   o
                                        ; Projectile_SpawnViblackMissile+1A   o
                dc.w    8
                dc.w    word_EBFA8-*
                dc.w    3
                dc.w    word_EBFB4-*
                dc.w    8
                dc.w    word_EBFA8-*
                dc.w    3
                dc.w    off_EBFCC-*
                dc.w    0
