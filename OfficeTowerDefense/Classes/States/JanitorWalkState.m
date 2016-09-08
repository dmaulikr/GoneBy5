//
//  JanitorWalkState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-26.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "JanitorWalkState.h"

#import "Actor.h"
#import "Animation.h"
#import "Elevator.h"
#import "EnemyEnterElevatorState.h"
#import "EnemyWaitForElevatorState.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "JanitorPreAttackState.h"
#import "Trap.h"
#import "PowerUp.h"

@interface JanitorWalkState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation JanitorWalkState

- (void)onEnter
{
    Janitor* janitor = (Janitor*)self.owner;
    
    self.animation = [janitor getAnimationWithName:janitor.ANIMATION_WALK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Janitor* janitor = (Janitor*)self.owner;
    
    if (janitor.rearGrid.x >= 11) {
        [janitor removeFromParent];
    }
    else {
        float speed = janitor.speed_per_sec * delta * janitor.speedModifier;
        
        NSArray* weapons = [janitor.gameWorld getWeaponsAtGrid:janitor.grid];
        
        for (Weapon* weapon in weapons) {
            if ([weapon isKindOfClass:[PowerUp class]]) {
                continue;
            }
            
            Trap* trap = (Trap*)weapon;
            
            if (trap.placement == PLACEMENT_BOTTOM && !trap.isBeingRemoved) {
                CGPoint diff = ccpSub(trap.position, janitor.position);
                
                if (fabs(diff.x) <= fabs(speed)) {
                    janitor.position = ccp(trap.position.x, janitor.position.y);
                    [janitor setState:[JanitorPreAttackState new]];
                    return;
                }
            }
        }
        
        Elevator* elevator = [janitor.gameWorld getElevatorAtGrid:janitor.frontGrid];
        
        if (!elevator) {
            if (speed != 0) {
                janitor.position = ccp(janitor.position.x + speed, janitor.position.y);
                [self.animation tick:delta];
            }
        }
        else if (elevator.isWaiting) {
            State* state = [[EnemyEnterElevatorState alloc] initWithElevator:elevator];
            [janitor setState:state];
        }
        else {
            State *state = [[EnemyWaitForElevatorState alloc] initWithElevator:elevator];
            [janitor setState:state];
        }
    }
}

@end
