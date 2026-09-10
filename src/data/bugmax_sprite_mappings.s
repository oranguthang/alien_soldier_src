; Bugmax sprite mappings and the two relative-offset projectile animations
; Numeric frame suffixes preserve ROM order without guessing overlapping body-part roles

Boss_BugmaxSpriteFrame00:   dc.w    $E8F2, $500, $F8F8  ; DATA XREF: ROM:Boss_BugmaxStandardHitFragmentMappings   o  ; was: word_ECB1C
Boss_BugmaxSpriteFrame01:   dc.w    $E8F6, 0, $FCFC     ; DATA XREF: ROM:0004DA1E   o  ; was: word_ECB22

Boss_BugmaxSpriteFrame02:   dc.w    $68FC, $600, $F0F0  ; DATA XREF: Boss_BugmaxInitializeBattleObjectChains+62   o  ; was: word_ECB28
                                        ; Boss_BugmaxToggleCentralPartMapping+E   o
                dc.w    $68F8, $500, $F000
                dc.w    $E8F7, 0, $F010
Boss_BugmaxSpriteFrame03:   dc.w    $6902, $500, $F000  ; DATA XREF: Boss_BugmaxToggleCentralPartMapping:Boss_BugmaxSelectAlternateCentralPartMapping   o  ; was: word_ECB3A
                dc.w    $E8FC, $600, $F0F0
Boss_BugmaxSpriteFrame04:   dc.w    $E907, 0, $FCFC     ; DATA XREF: ROM:Boss_BugmaxSecondaryLinkedPartMappings   o  ; was: word_ECB46
                                        ; ROM:0004CB32   o
Boss_BugmaxSpriteFrame05:   dc.w    $E906, 0, $FCFC     ; DATA XREF: ROM:0004CB3A   o  ; was: word_ECB4C
                                        ; ROM:0004CB3E   o
Boss_BugmaxSpriteFrame06:   dc.w    $E908, $F00, $F0F0  ; DATA XREF: Boss_BugmaxInitializeBattleObjectChains+22   o  ; was: word_ECB52
Boss_BugmaxSpriteFrame07:   dc.w    $E918, $A00, $F4F4  ; DATA XREF: ROM:Boss_BugmaxPrimaryLinkedPartDescriptors   o  ; was: word_ECB58
Boss_BugmaxSpriteFrame08:   dc.w    $E921, $500, $F8F8  ; DATA XREF: ROM:0004CB0E   o  ; was: word_ECB5E
                                        ; ROM:0004CB16   o
Boss_BugmaxSpriteFrame09:   dc.w    $E925, $500, $F8F8  ; DATA XREF: ROM:0004CB1E   o  ; was: word_ECB64
                                        ; ROM:0004CB26   o
Boss_BugmaxSpriteFrame10:   dc.w    $78FC, $600, $F2F4  ; DATA XREF: Boss_BugmaxSelectCentralPartFrameByAngle+4E   o  ; was: word_ECB6A
                dc.w    $78F8, $500, $FA04
                dc.w    $F8F7, 0, $214
Boss_BugmaxSpriteFrame11:   dc.w    $692F, $500, $F8    ; DATA XREF: Boss_BugmaxSelectCentralPartFrameByAngle+2E   o  ; was: word_ECB7C
                dc.w    $E929, $900, $F0F8
Boss_BugmaxSpriteFrame12:   dc.w    $6939, 0, $FCF3     ; DATA XREF: Boss_BugmaxInitializeEncounterState+88   o  ; was: word_ECB88
                                        ; Boss_BugmaxSelectCentralPartFrameByAngle+3E   o
                dc.w    $E933, $600, $F4FB
Boss_BugmaxSpriteFrame13:   dc.w    $E93A, $F00, $F0F0  ; DATA XREF: Boss_BugmaxInitializeEncounterState+3E   o  ; was: word_ECB94
Boss_BugmaxSpriteFrame14:   dc.w    $E94A, $A00, $F4F4  ; DATA XREF: ROM:Boss_BugmaxLinkedPartDescriptors   o  ; was: word_ECB9A
Boss_BugmaxSpriteFrame15:   dc.w    $E953, $500, $F8F8  ; DATA XREF: ROM:0004C5C6   o  ; was: word_ECBA0
                                        ; ROM:0004C5CE   o
Boss_BugmaxSpriteFrame16:   dc.w    $E957, $500, $F8F8  ; DATA XREF: ROM:0004C5D6   o  ; was: word_ECBA6
                                        ; ROM:0004C5DE   o
Boss_BugmaxSpriteFrame17:               dc.w    $E95B, $A00, $F4F4  ; DATA XREF: ROM:Projectile_BugmaxSpreadSpriteAnimation   o  ; was: word_ECBAC
Boss_BugmaxSpriteFrame18:               dc.w    $E976, $500, $F8F8  ; DATA XREF: ROM:000ECBD4   o  ; was: word_ECBB2
Boss_BugmaxSpriteFrame19:               dc.w    $E964, $A00, $F4F4  ; DATA XREF: ROM:Projectile_BugmaxSineSpriteAnimation   o  ; was: word_ECBB8
Boss_BugmaxSpriteFrame20:               dc.w    $E96D, $A00, $F4F4  ; DATA XREF: ROM:000ECBE0   o  ; was: word_ECBBE
Boss_BugmaxSpriteFrame21:               dc.w    $F164, $A00, $F4F4  ; DATA XREF: ROM:000ECBE4   o  ; was: word_ECBC4
Boss_BugmaxSpriteFrame22:               dc.w    $F16D, $A00, $F4F4  ; DATA XREF: ROM:000ECBE8   o  ; was: word_ECBCA
Projectile_BugmaxSpreadSpriteAnimation: dc.w    Boss_BugmaxSpriteFrame17-*  ; DATA XREF: Projectile_InitBugmaxSpread+A   o  ; was: off_ECBD0
                                        ; ROM:000ECBD8   o
                dc.w    2
                dc.w    Boss_BugmaxSpriteFrame18-*
                dc.w    2
                dc.w    Projectile_BugmaxSpreadSpriteAnimation-*
                dc.w    0
Projectile_BugmaxSineSpriteAnimation:   dc.w    Boss_BugmaxSpriteFrame19-*  ; DATA XREF: Projectile_InitBugmaxSine+A   o  ; was: off_ECBDC
                                        ; ROM:000ECBEC   o
                dc.w    6
                dc.w    Boss_BugmaxSpriteFrame20-*
                dc.w    6
                dc.w    Boss_BugmaxSpriteFrame21-*
                dc.w    6
                dc.w    Boss_BugmaxSpriteFrame22-*
                dc.w    6
                dc.w    Projectile_BugmaxSineSpriteAnimation-*
                dc.w    0
                dc.w    $6909, $D00, $F8
                dc.w    $6889, $D00, $F0F8
                dc.w    $E891, $200, $F0F0
                dc.w    $6894, $D00, $F8
                dc.w    $6891, $200, $F0F0
                dc.w    $E889, $D00, $F0F8
                dc.w    $E89C, $E00, $F0F0
                dc.w    $E8A8, $A00, $F4F3
                dc.w    $E8B1, $600, $F4F8
                dc.w    $E8B7, $A00, $F3F4
                dc.w    $68D6, $C00, $2F6
                dc.w    $E8D0, $900, $F2F6
                dc.w    $68D6, $C00, $2F3
                dc.w    $E8C8, $D00, $F2F3
                dc.w    $68C0, $D00, $F2F1
                dc.w    $E8D6, $C00, $2F1
                dc.w    $68DA, $900, $2F3
                dc.w    $E8C8, $D00, $F2F3
                dc.w    $E8E0, $700, $F1F8
                dc.w    $E8E8, $600, $F4F6
                dc.w    $E8EE, $A00, $F4F4
                dc.w    $E8F7, $A00, $F4F4
                dc.w    $E900, $500, $F8F8
                dc.w    $E904, $500, $F8F8
                dc.w    $E908, 0, $FCFC
