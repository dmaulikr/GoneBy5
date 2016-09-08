//
//  Projectile0.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface Projectile0 : GameEntity

- (instancetype)initWithDamage:(float)damage speed:(float)speed_per_sec startingGrid:(CGPoint)startingGrid gridDistance:(int)gridDistance;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) float damage;
@property (nonatomic, readonly) float speed_per_sec;
@property (nonatomic, readonly) CGPoint startingGrid;
@property (nonatomic, readonly) int gridDistance;

@end
