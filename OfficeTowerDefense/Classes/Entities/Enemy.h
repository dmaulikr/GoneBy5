//
//  Enemy.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-28.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Character.h"

@interface Enemy : Character

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec;

- (void)modifySpeed:(float)modifier duration:(float)duration_sec;
- (void)scare;
- (void)exitElevator;

@property (nonatomic, copy, readonly) NSString* ANIMATION_ATTACK;
@property (nonatomic, copy, readonly) NSString* ANIMATION_BURN;
@property (nonatomic, copy, readonly) NSString* ANIMATION_WALK;

@property (nonatomic, readonly) int coins;
@property (nonatomic) float speed_per_sec;
@property (nonatomic, readonly) float speedModifier;
@property (nonatomic, readonly) float speedModifierDuration_sec;
@property (nonatomic, readonly) BOOL isWalking;
@property (nonatomic, readonly) BOOL scared;

@end
