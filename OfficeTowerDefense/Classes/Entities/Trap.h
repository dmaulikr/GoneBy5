//
//  Trap.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Weapon.h"

#import "OverlayFX.h"

@interface Trap : Weapon

@property (nonatomic, copy, readonly) NSString* ANIMATION_DETECT_ENEMY;

@property (nonatomic) BOOL isBeingRemoved;
@property (nonatomic, readonly) float purchaseInterval_sec;
@property (nonatomic, readonly) OverlayType overlayFX;

@end
