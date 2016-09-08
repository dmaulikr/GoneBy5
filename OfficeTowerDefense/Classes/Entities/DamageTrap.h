//
//  DamageTrap.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap.h"

@interface DamageTrap : Trap

@property (nonatomic, readonly) float damage;
@property (nonatomic, readonly) NSString* enemyDieAnimationName;
@property (nonatomic, readonly) float speedModifier;
@property (nonatomic, readonly) float speedModifierDuration_sec;

@end
