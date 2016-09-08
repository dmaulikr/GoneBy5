//
//  ElevatorDownState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-19.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ElevatorDownState.h"

#import "Animation.h"
#import "CCSprite.h"
#import "Elevator.h"
#import "ElevatorExitState.h"
#import "Enemy.h"
#import "GameWorld.h"

@interface ElevatorDownState()

@property (nonatomic, weak) Animation* elevatorAnimation;
@property (nonatomic, weak) Animation* wheelAnimation;
@property (nonatomic, weak) Animation* cableAnimation;
@property (nonatomic) CGPoint targetPosition;

@end

@implementation ElevatorDownState

- (void)onEnter
{
    Elevator* elevator = (Elevator*)self.owner;
    
    self.elevatorAnimation = [elevator getAnimationWithName:elevator.ANIMATION_DOWN];
    self.cableAnimation = [elevator getAnimationWithName:elevator.ANIMATION_CABLE];
    self.wheelAnimation = [elevator getAnimationWithName:elevator.ANIMATION_WHEEL];
    self.wheelAnimation.reversed = NO;
        
    CGPoint grid = [elevator.gameWorld getGridFromPosition:elevator.position];
    CGPoint targetGrid = CGPointMake(grid.x, grid.y - 1);
    targetGrid.y = floor(targetGrid.y);
    
    self.targetPosition = [elevator.gameWorld getFloorPositionFromGrid:targetGrid];
}

- (void)tick:(CCTime)delta
{
    Elevator* elevator = (Elevator*)self.owner;
    
    float speed = elevator.speed_per_sec * delta;
    CGPoint target = ccp(elevator.elevatorSprite.position.x, elevator.elevatorSprite.position.y - speed);
    CGPoint position = [elevator convertToWorldSpace:target];
    CGPoint diff = ccpSub(self.targetPosition, position);
        
    if (diff.y >= 0) {
        CGPoint snap = [elevator convertToNodeSpace:self.targetPosition];
        
        elevator.elevatorSprite.position = snap;
        elevator.wheelSprite.position = ccp(elevator.wheelSprite.position.x, snap.y + elevator.initialWheelPosition.y);
        elevator.cableSprite.position = ccp(elevator.cableSprite.position.x, snap.y + elevator.initialCablePosition.y);
        
        for (Enemy* enemy in elevator.occupants) {
            enemy.position = ccp(enemy.position.x, self.targetPosition.y);
        }
        
        [elevator setState:[ElevatorExitState new]];
    }
    else {
        [self move:-speed];
        [self.elevatorAnimation tick:delta];
        
        if (self.wheelAnimation.completed) {
            [self.wheelAnimation restart];
        }
        else {
            [self.wheelAnimation tick:delta];
        }
    }
}

- (void)move:(float)deltaY
{
    Elevator* elevator = (Elevator*)self.owner;
    
    CGPoint tempPosition = elevator.elevatorSprite.position;
    tempPosition.y += deltaY;
    elevator.elevatorSprite.position = tempPosition;
    
    tempPosition = elevator.wheelSprite.position;
    tempPosition.y += deltaY;
    elevator.wheelSprite.position =  tempPosition;

    tempPosition = elevator.cableSprite.position;
    tempPosition.y += deltaY;
    elevator.cableSprite.position = tempPosition;
    elevator.cableSprite.scaleY = 1.0 + (elevator.initialCablePosition.y - tempPosition.y) / elevator.initialCableSize.height;
    
    for (Enemy* enemy in elevator.occupants) {
        enemy.position = ccp(enemy.position.x, enemy.position.y + deltaY);
    }
}

@end
