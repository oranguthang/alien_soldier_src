; Viblack missile mappings and two relative animation streams
Projectile_ViblackMissileMappingA:  dc.w    $8D3, $A00, $F6F4  ; was: word_EBF90
                dc.w    $88DF, $800, $8F4
Projectile_ViblackMissileMappingB:  dc.w    $8D3, $A00, $F8F4  ; was: word_EBF9C
                dc.w    $88DC, $800, $8F4
Projectile_ViblackMissileMappingC:  dc.w    $8D3, $A00, $F7F4  ; was: word_EBFA8
                dc.w    $88DC, $800, $8F4
Projectile_ViblackMissileMappingD:  dc.w    $8D3, $A00, $F6F4  ; was: word_EBFB4
                dc.w    $88DC, $800, $8F4
Projectile_ViblackMissileAnimationA:    dc.w    Projectile_ViblackMissileMappingA-*  ; was: off_EBFC0
                dc.w    5
                dc.w    Projectile_ViblackMissileMappingB-*
                dc.w    5
                dc.w    Projectile_ViblackMissileAnimationA-*
                dc.w    0
Projectile_ViblackMissileAnimationB:    dc.w    Projectile_ViblackMissileMappingB-*  ; was: off_EBFCC
                dc.w    8
                dc.w    Projectile_ViblackMissileMappingC-*
                dc.w    3
                dc.w    Projectile_ViblackMissileMappingD-*
                dc.w    8
                dc.w    Projectile_ViblackMissileMappingC-*
                dc.w    3
                dc.w    Projectile_ViblackMissileAnimationB-*
                dc.w    0
