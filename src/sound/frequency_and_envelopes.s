word_84C18:     dc.w    $356, $326, $2F9                ; DATA XREF: Sound_ProcessNoteData+10   o
                dc.w    $2CE, $2A5, $280
                dc.w    $25C, $23A, $21A
                dc.w    $1FB, $1DF, $1C4
                dc.w    $1AB, $193, $17D
                dc.w    $167, $153, $140
                dc.w    $12E, $11D, $10D
                dc.w    $FE, $EF, $E2
                dc.w    $D6, $C9, $BE
                dc.w    $B4, $A9, $A0
                dc.w    $97, $8F, $87
                dc.w    $7F, $78, $71
                dc.w    $6B, $65, $5F
                dc.w    $5A, $55, $50
                dc.w    $4B, $47, $43
                dc.w    $40, $3C, $39
                dc.w    $36, $33, $30
                dc.w    $2D, $2B, $28
                dc.w    $26, $24, $22
                dc.w    $20, $1F, $1D
                dc.w    $1B, $1A, $18
                dc.w    $17, $16, $15
                dc.w    $13, $12, $11
                dc.w    0
SoundDataPointerTable:
                dc.l    SoundPriorityTable
                dc.l    SpecialSFX_PointerTable
                dc.l    BGM_PointerTable
                dc.l    SFX_PointerTable
                dc.l    ModulationEnvelopePointerTable
                dc.l    PSGVolumeEnvelopePointerTable
                dc.l    $A0
                dc.l    Sound_UpdateDriver              ; debug this
                dc.l    SFX_40_7F_PointerTable
ModulationEnvelopePointerTable: dc.l    ModulationEnvelope_1  ; DATA XREF: Sound_ApplyPitchEffects+C   o
                                        ; ROM:00084CB4   o
                dc.l    ModulationEnvelope_2
                dc.l    ModulationEnvelope_3
                dc.l    ModulationEnvelope_4
                dc.l    ModulationEnvelope_5
                dc.l    ModulationEnvelope_6
                dc.l    ModulationEnvelope_7
                dc.l    ModulationEnvelope_8
ModulationEnvelope_1:   dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E, $F
                                        ; DATA XREF: ROM:ModulationEnvelopePointerTable   o
                dc.b    $10, $11, $12, $13, $14, $83
ModulationEnvelope_2:   dc.b    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, $A, $B, $C, $D, $E, $F
                                        ; DATA XREF: ROM:00084CCC   o
                dc.b    $10, $11, $12, $13, $14, $80
ModulationEnvelope_3:   dc.b    $D8, $E2, $EC, $F6, 0, $A, $14, $1E, $28, $83
                                        ; DATA XREF: ROM:00084CD0   o
ModulationEnvelope_4:   dc.b    $D8, $E2, $EC, $F6, 0, $A, $14, $1E, $28, $80
                                        ; DATA XREF: ROM:00084CD4   o
ModulationEnvelope_6:   dc.b    4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084CDC   o
ModulationEnvelope_5:   dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084CD8   o
                dc.b    1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
                dc.b    3, 3, 3, 3, 3, 3, 3, 3, 4, $83
ModulationEnvelope_7:   dc.b    2, $83                  ; DATA XREF: ROM:00084CE0   o
ModulationEnvelope_8:   dc.b    0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2
                                        ; DATA XREF: ROM:00084CE4   o
                dc.b    3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6
                dc.b    6, 6, 6, 6, 7, 7, 7, $83
PSGVolumeEnvelopePointerTable:  dc.l    PSGVolumeEnvelope_1  ; DATA XREF: Sound_ProcessFMModulation+14   o
                                        ; ROM:00084CB8   o
                dc.l    PSGVolumeEnvelope_2
                dc.l    PSGVolumeEnvelope_3
                dc.l    PSGVolumeEnvelope_4
                dc.l    PSGVolumeEnvelope_5
                dc.l    PSGVolumeEnvelope_6
                dc.l    PSGVolumeEnvelope_7
                dc.l    PSGVolumeEnvelope_8
                dc.l    PSGVolumeEnvelope_9
                dc.l    PSGVolumeEnvelope_10
PSGVolumeEnvelope_1:    dc.b    0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5
                                        ; DATA XREF: ROM:PSGVolumeEnvelopePointerTable   o
                dc.b    5, 5, 6, 6, 6, 7, $83
PSGVolumeEnvelope_2:    dc.b    0, 2, 4, 6, 8, $10, $83
                                        ; DATA XREF: ROM:00084D90   o
PSGVolumeEnvelope_3:    dc.b    0, 0, 1, 1, 3, 3, 4, 5, $83
                                        ; DATA XREF: ROM:00084D94   o
PSGVolumeEnvelope_4:    dc.b    0, 0, 2, 3, 4, 4, 5, 5, 5, 6, $83
                                        ; DATA XREF: ROM:00084D98   o
PSGVolumeEnvelope_6:    dc.b    4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084DA0   o
PSGVolumeEnvelope_5:    dc.b    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
                                        ; DATA XREF: ROM:00084D9C   o
                dc.b    1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2
                dc.b    3, 3, 3, 3, 3, 3, 3, 3, 4, $83
PSGVolumeEnvelope_7:    dc.b    2, $83                  ; DATA XREF: ROM:00084DA4   o
PSGVolumeEnvelope_8:    dc.b    0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2
                                        ; DATA XREF: ROM:00084DA8   o
                dc.b    3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6
                dc.b    6, 6, 6, 6, 7, 7, 7, $83
PSGVolumeEnvelope_9:    dc.b    8, 8, 7, 7, 7, 7, 6, 6, 6, 6, 5, 5, 5, 5, 4, 4
                                        ; DATA XREF: ROM:00084DAC   o
                dc.b    4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 0, $81
PSGVolumeEnvelope_10:   dc.b    8, 7, 6, 5, 4, 3, 3, 2, 2, 1, 1, 0, $81, 0
                                        ; DATA XREF: ROM:00084DB0   o
