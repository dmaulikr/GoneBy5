//
//  ElectricianWalkState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-26.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ElectricianWalkState.h"

#import "Actor.h"
#import "Animation.h"
#import "Elevator.h"
#import "EnemyEnterElevatorState.h"
#import "EnemyWaitForElevatorState.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "ElectricianPreAttackState.h"
#import "Trap.h"
#import "PowerUp.h"

@interface ElectricianWalkState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ElectricianWalkState

- (void)onEnter
{
    Electrician* electrician = (Electrician*)self.owner;
    
    self.animation = [electrician getAnimationWithName:electrician.ANIMATION_WALK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Electrician* electrician = (Electrician*)self.owner;
    
    if (electrician.rearGrid.x >= 11) {
        [electrician removeFromParent];
    }
    else {
        float speed = (electrician.speed_per_sec * delta) * electrician.speedModifier;

        NSArray* weapons = [electrician.gameWorld getWeaponsAtGrid:electrician.grid];
    
        for (Weapon* weapon in weapons) {
            if ([weapon isKindOfClass:[PowerUp class]]) {
                continue;
            }

            Trap* trap = (Trap*)weapon;
            
            if (trap.placement == PLACEMENT_TOP && !trap.isBeingRemoved) {
                CGPoint diff = ccpSub(trap.position, electrician.position);
                
                if (fabs(diff.x) <= fabs(speed)) {
                    electrician.position = ccp(trap.position.x, electrician.position.y);
                    [electrician setState:[ElectricianPreAttackState new]];
                    return;
                }
            }
        }
    
        Elevator* elevator = [electrician.gameWorld getElevatorAtGrid:electrician.frontGrid];
    
        if (!elevator) {
            if (speed != 0) {
                electrician.position = ccp(electrician.position.x + speed, electrician.position.y);
                [self.animation tick:delta];
            }
        }
        else if (elevator.isWaiting) {
            State* state = [[EnemyEnterElevatorState alloc] initWithElevator:elevator];
            [electrician setState:state];
        }
        else {
            State *state = [[EnemyWaitForElevatorState alloc] initWithElevator:elevator];
            [electrician setState:state];
        }
    }
}

@end
