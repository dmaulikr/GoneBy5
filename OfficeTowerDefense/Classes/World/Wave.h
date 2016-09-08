//
//  Wave.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ccTypes.h"

@class Enemy;
@class GameWorld;

@interface Wave : NSObject

- (instancetype)initWithLevelID:(NSString*)levelID waveIndex:(int)waveIndex;

- (void)tick:(CCTime)delta gameWorld:(GameWorld*)gameWorld;

@property (nonatomic, readonly) float triggerPercentage;


@end
