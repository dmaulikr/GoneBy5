//
//  BossWalkState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossWalkState.h"

#import "Actor.h"
#import "Animation.h"
#import "Boss.h"
#import "BossAttackState.h"
#import "Elevator.h"
#import "EnemyEnterElevatorState.h"
#import "EnemyWaitForElevatorState.h"
#import "GameWorld.h"

@interface BossWalkState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation BossWalkState

- (void)onEnter
{
    Boss* enemy = (Boss*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_WALK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Boss* enemy = (Boss*)self.owner;
        
    float speed = enemy.speed_per_sec * delta * enemy.speedModifier;
    Actor* actor = enemy.gameWorld.actor;
        
    if (floor(enemy.grid.y) == floor(actor.grid.y)) {
        CGPoint diff = ccpSub(actor.frontPosition, enemy.position);
            
        if (fabs(diff.x) <= fabs(speed)) {
            enemy.position = actor.frontPosition;
            [enemy setState:[BossAttackState new]];
        }
        else {
            enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
            [self.animation tick:delta];
        }
    }
    else {
        Elevator* elevator = [enemy.gameWorld getElevatorAtGrid:enemy.frontGrid];
            
        if (!elevator) {
            enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
            [self.animation tick:delta];
        }
        else {
            State* state = (elevator.isWaiting) ? [[EnemyEnterElevatorState alloc] initWithElevator:elevator] : [[EnemyWaitForElevatorState alloc] initWithElevator:elevator];
            [enemy setState:state];
        }
    }
}

@end
