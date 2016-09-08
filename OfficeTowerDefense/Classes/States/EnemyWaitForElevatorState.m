//
//  EnemyWaitForElevatorState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-19.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EnemyWaitForElevatorState.h"

#import "Animation.h"
#import "Elevator.h"
#import "ElevatorWaitState.h"
#import "Enemy.h"
#import "EnemyEnterElevatorState.h"

@interface EnemyWaitForElevatorState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, weak) Elevator* elevator;

@end

@implementation EnemyWaitForElevatorState

- (instancetype)initWithElevator:(Elevator*)elevator
{
    self = [super init];
    
    self.elevator = elevator;
    
    return self;
}

- (void)onEnter
{
    Enemy* enemy = (Enemy*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.elevator.isWaiting) {
        State* state = [[EnemyEnterElevatorState alloc] initWithElevator:self.elevator];
        [self.owner setState:state];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
