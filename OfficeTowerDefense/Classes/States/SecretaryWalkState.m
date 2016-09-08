//
//  SecretaryWalkState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SecretaryWalkState.h"

#import "Actor.h"
#import "Animation.h"
#import "Elevator.h"
#import "EnemyEnterElevatorState.h"
#import "EnemyWaitForElevatorState.h"
#import "GameWorld.h"
#import "Secretary.h"
#import "SecretaryAttackState.h"

@interface SecretaryWalkState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation SecretaryWalkState

- (void)onEnter
{
    Secretary* enemy = (Secretary*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_WALK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Secretary* enemy = (Secretary*)self.owner;
        
    float speed = enemy.speed_per_sec * delta * enemy.speedModifier;
    Actor* actor = enemy.gameWorld.actor;
    
    if (floor(enemy.grid.y) == floor(actor.grid.y)) {
        CGPoint diff = ccpSub(actor.frontPosition, enemy.position);
        
        if (fabs(diff.x) <= fabs(speed)) {
            enemy.position = actor.frontPosition;
            [enemy setState:[SecretaryAttackState new]];
            return;
        }
    }

    Elevator* elevator = [enemy.gameWorld getElevatorAtGrid:enemy.frontGrid];
    
    if (!elevator) {
        if (speed != 0.0) {
            enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
        
            [self.animation tick:delta];
        }
    }
    else {
        State* state = (elevator.isWaiting) ? [[EnemyEnterElevatorState alloc] initWithElevator:elevator] : [[EnemyWaitForElevatorState alloc] initWithElevator:elevator];
        [enemy setState:state];
    }
}

@end
