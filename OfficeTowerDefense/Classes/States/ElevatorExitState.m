//
//  ElevatorExitState.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2014-12-29.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ElevatorExitState.h"

#import "Elevator.h"
#import "ElevatorUpState.h"
#import "Enemy.h"
#import "GameWorld.h"

@interface ElevatorExitState()

@property (nonatomic) float exitDelay_sec;
@property (nonatomic, strong) NSMutableArray* occupantsToRemove;

@end

@implementation ElevatorExitState

- (void)onEnter
{
    self.exitDelay_sec = 1;
    self.occupantsToRemove = [NSMutableArray new];
}

- (void)tick:(CCTime)delta
{
    Elevator* elevator = (Elevator*)self.owner;
    
    for (Enemy* enemy in self.occupantsToRemove) {
        [elevator.occupants removeObject:enemy];
    }
    
    [self.occupantsToRemove removeAllObjects];
    
    if (elevator.isEmpty) {
        [elevator setState:[ElevatorUpState new]];
    }
    else {
        self.exitDelay_sec -= delta;

        CGPoint elevatorGrid = [elevator.gameWorld getGridFromPosition:elevator.position];
        elevatorGrid.x = floor(elevatorGrid.x);

        for (Enemy* enemy in elevator.occupants) {
            if (enemy.isIdle) {
                if (self.exitDelay_sec <= 0) {
                    self.exitDelay_sec += 1;
                    
                    [enemy exitElevator];
                }
            }
            else if (enemy.isWalking) {
                CGPoint enemyGrid = enemy.rearGrid;
                enemyGrid.x = floor(enemyGrid.x);
            
                if (enemy.speed_per_sec > 0 && elevatorGrid.x < enemyGrid.x) {
                    [self.occupantsToRemove addObject:enemy];
                }
                else if (enemy.speed_per_sec < 0 && elevatorGrid.x > enemyGrid.x) {
                    [self.occupantsToRemove addObject:enemy];
                }
            }
            else {
                [self.occupantsToRemove addObject:enemy];
            }
        }
    }
}

- (void)onExit
{
    Elevator* elevator = (Elevator*)self.owner;

    [elevator.occupants removeAllObjects];
    [self.occupantsToRemove removeAllObjects];
}

@end
