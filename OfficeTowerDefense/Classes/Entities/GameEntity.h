//
//  Entity.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-17.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Entity.h"

@class GameWorld;

@interface GameEntity : Entity

@property (nonatomic, weak) GameWorld* gameWorld;

@property (nonatomic, readonly) CGPoint frontPosition;
@property (nonatomic, readonly) CGPoint rearPosition;
@property (nonatomic, readonly) CGPoint frontGrid;
@property (nonatomic, readonly) CGPoint grid;
@property (nonatomic, readonly) CGPoint rearGrid;

@end
