//
//  GameWorld.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Entity.h"
#import "CCDrawNode.h"

@class Actor;
@class Boss;
@class Elevator;

@interface GameWorld : Entity

- (instancetype)initWithLevelID:(NSString*)levelID;

- (CGPoint)getSpawnPoint;
- (CGPoint)getGridFromPosition:(CGPoint)position;
- (CGPoint)getPositionFromGrid:(CGPoint)grid;
- (CGPoint)getCeilingPositionFromGrid:(CGPoint)grid;
- (CGPoint)getFloorPositionFromGrid:(CGPoint)grid;
- (NSArray*)getCharactersInGrid:(CGPoint)grid;
- (NSArray*)getCharactersIntersectingGrid:(CGPoint)grid;
- (NSArray*)getWeaponsAtGrid:(CGPoint)grid;
- (Elevator*)getElevatorAtGrid:(CGPoint)grid;

@property (nonatomic, readonly) Actor* actor;
@property (nonatomic, readonly) Boss* boss;
@property (nonatomic, readonly) unsigned long enemiesOnScreen;

@property (nonatomic) CCDrawNode* drawNode;

@end
