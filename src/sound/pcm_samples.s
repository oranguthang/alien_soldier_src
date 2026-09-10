; ROM-aligned DPCM banks addressed by descriptor high byte plus sample offset

Sound_PCMBank1: binclude "data/sound/PCMPart1.bin"
                ; was: PCMPart1
Sound_PCMBank1_End:
Sound_PCMBank2: binclude "data/sound/PCMPart2.bin"
                ; was: PCMPart2
Sound_PCMBank2_End:
Sound_PCMBank3: binclude "data/sound/PCMPart3.bin"
                ; was: PCMPart3
Sound_PCMBank3_End:
Sound_PCMBank4: binclude "data/sound/PCMPart4.bin"
                ; was: PCMPart4
Sound_PCMBank4_End:
Sound_PCMBank5: binclude "data/sound/PCMPart5.bin"
                ; was: PCMPart5
Sound_PCMBank5_End:
Sound_PCMBank6: binclude "data/sound/PCMPart6.bin"
                ; was: PCMPart6
Sound_PCMBank6_End:
Sound_PCMBank7: binclude "data/sound/PCMPart7.bin"
                ; was: PCMPart7
Sound_PCMBank7_End:
Sound_PCMBank8: binclude "data/sound/PCMPart8.bin"
                ; was: PCMPart8
Sound_PCMBank8_End:
Sound_PCMBank9: binclude "data/sound/PCMPart9.bin"
                ; was: PCMPart9
Sound_PCMBank9_End:
                ; Preserve the $E5A2-byte $FF gap after the final PCM bank
                org     $E8000
