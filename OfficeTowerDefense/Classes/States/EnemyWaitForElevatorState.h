//
//  EnemyWaitForElevatorState.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-19.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "State.h"

@class Elevator;

@interface EnemyWaitForElevatorState :  State

- (instancetype)initWithElevator:(Elevator*)elevator;

@end
