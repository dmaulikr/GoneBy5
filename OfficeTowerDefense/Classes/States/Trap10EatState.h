//
//  Trap10EatState.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "State.h"

@class Enemy;

@interface Trap10EatState : State

- (instancetype)initWithEnemy:(Enemy*)enemy;

@end
