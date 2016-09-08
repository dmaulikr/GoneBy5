//
//  OverlayFX.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Entity.h"

typedef enum {
    OVERLAY_NONE,
    OVERLAY_HIT,
    OVERLAY_COLD,
    OVERLAY_DIZZY,
    OVERLAY_SPEECH,
    OVERLAY_SWEAT
} OverlayType;


@interface OverlayFX : Entity

@property (nonatomic, copy, readonly) NSString* ANIMATION;

@end
