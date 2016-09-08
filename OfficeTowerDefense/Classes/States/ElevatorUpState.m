//
//  ElevatorUpState.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2014-12-25.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ElevatorUpState.h"

#import "Animation.h"
#import "CCSprite.h"
#import "Elevator.h"
#import "ElevatorWaitState.h"
#import "GameWorld.h"

@interface ElevatorUpState()

@property (nonatomic, weak) Animation* elevatorAnimation;
@property (nonatomic, weak) Animation* wheelAnimation;
@property (nonatomic, weak) Animation* cableAnimation;
@property (nonatomic) CGPoint targetPosition;

@end

@implementation ElevatorUpState

- (void)onEnter
{
    Elevator* elevator = (Elevator*)self.owner;
    
    self.elevatorAnimation = [elevator getAnimationWithName:elevator.ANIMATION_UP];
    self.cableAnimation = [elevator getAnimationWithName:elevator.ANIMATION_CABLE];
    self.wheelAnimation = [elevator getAnimationWithName:elevator.ANIMATION_WHEEL];
    self.wheelAnimation.reversed = YES;
    
    CGPoint grid = [elevator.gameWorld getGridFromPosition:elevator.position];
    
    self.targetPosition = [elevator.gameWorld getPositionFromGrid:grid];
}

- (void)tick:(CCTime)delta
{
    Elevator* elevator = (Elevator*)self.owner;

    float speed = elevator.speed_per_sec * delta;
    CGPoint target = ccp(elevator.elevatorSprite.position.x, elevator.elevatorSprite.position.y + speed);
    CGPoint position = [elevator convertToWorldSpace:target];
    CGPoint diff = ccpSub(self.targetPosition, position);
    
    if (diff.y <= 0) {
        CGPoint snap = [elevator convertToNodeSpace:self.targetPosition];
        
        elevator.elevatorSprite.position = snap;
        elevator.wheelSprite.position = ccp(elevator.wheelSprite.position.x, snap.y + elevator.initialWheelPosition.y);
        elevator.cableSprite.position = ccp(elevator.cableSprite.position.x, snap.y + elevator.initialCablePosition.y);

        [elevator setState:[ElevatorWaitState new]];
    }
    else {
        [self move:speed];
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
}

@end
