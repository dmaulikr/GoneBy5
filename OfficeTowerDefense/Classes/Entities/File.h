//
//  File.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface File : GameEntity

- (instancetype)initWithID:(NSString*)ID hitPoints:(float)hitPoints;

- (float)takeDamage:(float)damage;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) float maxHitPoints;
@property (nonatomic, readonly) float hitPoints;

@end
