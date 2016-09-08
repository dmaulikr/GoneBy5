//
//  ElevatorWaitState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-17.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ElevatorWaitState.h"

#import "Animation.h"
#import "Elevator.h"
#import "ElevatorDownState.h"
#import "Enemy.h"
#import "GameWorld.h"

@interface ElevatorWaitState()

@property (nonatomic) float delay_sec;
@property (nonatomic, weak) Animation* animation;
@property (nonatomic, strong) NSMutableArray *deadCharacters;

@end

@implementation ElevatorWaitState

- (void)onEnter
{
    Elevator* elevator = (Elevator*)self.owner;
    
    self.deadCharacters = [NSMutableArray new];
    self.delay_sec = elevator.delay_sec;
    self.animation = [elevator getAnimationWithName:elevator.ANIMATION_STOPPED];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
    
    Elevator* elevator = (Elevator*)self.owner;

    for (Enemy* enemy in self.deadCharacters) {
        [elevator.occupants removeObject:enemy];
    }
    
    [self.deadCharacters removeAllObjects];
    
    for (Enemy* enemy in elevator.occupants) {
        if (enemy.isDead) {
            [self.deadCharacters addObject:enemy];
        }
        else if (enemy.isIdle) {
            if (enemy == [elevator.occupants lastObject]) {
                self.delay_sec -= delta;
                
                if (elevator.isFull) {
                    self.delay_sec = 0;
                }
            }
        }
        else {
            self.delay_sec = elevator.delay_sec;
            break;
        }
    }
    
    if (self.delay_sec <= 0) {
        [elevator setState:[ElevatorDownState new]];
    }
}

@end
