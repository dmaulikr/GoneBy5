//
//  Projectile1.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface Projectile1 : GameEntity

- (instancetype)initWithDamage:(float)damage speed:(float)speed_per_sec gridDistance:(int)gridDistance sound:(NSString*)sound;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_EXPLODE;

@property (nonatomic, readonly) float damage;
@property (nonatomic, readonly) float speed_per_sec;
@property (nonatomic, readonly) int gridDistance;
@property (nonatomic, copy, readonly) NSString* sound;

@end
