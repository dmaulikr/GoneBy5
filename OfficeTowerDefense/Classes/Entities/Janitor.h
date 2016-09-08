//
//  Janitor.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Enemy.h"

@interface Janitor : Enemy

@property (nonatomic, copy, readonly) NSString* ANIMATION_POST_ATTACK;
@property (nonatomic, copy, readonly) NSString* ANIMATION_PRE_ATTACK;

@end
