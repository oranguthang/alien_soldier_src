; Populate an otherwise unreferenced object-shaped record from player display
; fields, a fixed screen position, and zero velocity
UnreferencedPrepareObjectRecord:
                move.w  (PlayerObjectFlags).w,(OrphanedObjectFlags).w  ; was: sub_1CCB6
                move.l  (PlayerSpriteMapping).w,(OrphanedObjectSpriteMap).w
                move.w  (PlayerAnimationTimer).w,(OrphanedObjectAnimTimer).w
                move.w  (PlayerSpriteAttributes).w,(OrphanedObjectAttr).w
                move.w  #$120,(OrphanedObjectXPosition).w
                move.w  #$F0,(OrphanedObjectYPosition).w
                clr.w   (OrphanedObjectXFraction).w
                clr.w   (OrphanedObjectYFraction).w
                clr.l   (OrphanedObjectXVelocity).w
                clr.l   (OrphanedObjectYVelocity).w
                rts
; End of function UnreferencedPrepareObjectRecord
