//
//  Weapon.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-09.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@class GameWorld;

typedef enum {
    PLACEMENT_TOP,
    PLACEMENT_BOTTOM,
    PLACEMENT_NONE
} Placement;

@interface Weapon : GameEntity

- (void)snapToGrid:(float)scale;
- (BOOL)canBePlaced;
- (void)place;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) BOOL isPlaced;
@property (nonatomic) Placement placement;
@property (nonatomic, readonly) int cost;
@property (nonatomic, copy, readonly) NSString* sound;

@end
