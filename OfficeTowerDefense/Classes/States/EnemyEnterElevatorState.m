//
//  EnemyEnterElevatorState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EnemyEnterElevatorState.h"

#import "Animation.h"
#import "Elevator.h"
#import "Enemy.h"
#import "EnemyIdleState.h"

@interface EnemyEnterElevatorState()

@property (nonatomic, weak) Elevator* elevator;
@property (nonatomic) double xOffset;
@property (nonatomic, weak) Animation* animation;

@end

@implementation EnemyEnterElevatorState

- (instancetype)initWithElevator:(Elevator*)elevator
{
    self = [super init];
    
    self.elevator = elevator;
    self.xOffset = drand48() * 10;
    
    return self;
}

- (void)onEnter
{
    Enemy* enemy = (Enemy*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_WALK];
    
    [self.elevator addOccupant:enemy];
}

- (void)tick:(CCTime)delta
{
    Enemy* enemy = (Enemy*)self.owner;
    float speed = enemy.speed_per_sec * delta;
    CGPoint target = self.elevator.position;
    target.x += self.xOffset;

    CGPoint diff = ccpSub(target, enemy.position);
    
    if (fabs(diff.x) <= fabs(speed)) {
        enemy.speed_per_sec *= -1;
        enemy.scaleX = -enemy.scaleX;
        enemy.position = target;

        [enemy setState:[EnemyIdleState new]];
    }
    else {
        enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
        [self.animation tick:delta];
    }
}

@end
