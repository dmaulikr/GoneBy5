//
//  Entity.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-17.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEntity.h"

#import "GameSession.h"
#import "GameWorld.h"
#import "State.h"

@implementation GameEntity

- (CGPoint)frontPosition
{
    float halfSize = (self.scaleX == 1) ? -self.size.width / 2 : self.size.width / 2;
    CGPoint tempPosition = self.position;
    tempPosition.x += halfSize;
    
    return tempPosition;
}

- (CGPoint)rearPosition
{
    float halfSize = (self.scaleX == 1) ? self.size.width / 2 : -self.size.width / 2;
    CGPoint tempPosition = self.position;
    tempPosition.x += halfSize;
    
    return tempPosition;
}

- (CGPoint)frontGrid
{
    return [self.gameWorld getGridFromPosition:self.frontPosition];
}

- (CGPoint)grid
{
    return [self.gameWorld getGridFromPosition:self.position];
}

- (CGPoint)rearGrid
{
    return [self.gameWorld getGridFromPosition:self.rearPosition];
}

@end
