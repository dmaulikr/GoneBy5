//
//  Game.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCScene.h"

@class Entity;
@class GameWorld;

@interface Game : CCScene

- (instancetype)initWithLevelID:(NSString*)levelID traps:(NSArray*)traps powerUps:(NSArray*)powerUps;

- (void)setupUI;
- (void)onUpdate:(CCTime)delta;

@property (nonatomic) GameWorld* gameWorld;

@property (nonatomic, readonly) BOOL hasBossFight;

@end
