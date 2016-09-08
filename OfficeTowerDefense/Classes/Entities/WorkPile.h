//
//  WorkPile.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-05-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface WorkPile : GameEntity

- (instancetype)initWithHitPoints:(float)totalHitPoints;

- (void)addDamage:(float)damage;
- (void)removeDamage:(float)damage;

@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_0;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_1;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_2;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_3;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_4;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_5;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_6;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_7;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_8;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_9;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PILE_10;

@property (nonatomic, readonly) float totalHitPoints;
@property (nonatomic, readonly) float hitPoints;

@property (nonatomic) BOOL playAnimation;

@end
