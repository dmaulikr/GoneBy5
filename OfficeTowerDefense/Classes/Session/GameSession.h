//
//  GameSession.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccTypes.h"
typedef enum {
    GAME_STATUS_IN_PROGRESS,
    GAME_STATUS_LOSE,
    GAME_STATUS_WIN
} GameStatus;

@interface GameSession : NSObject

+ (GameSession *)instance;

- (void)start;
- (void)startWithDuration:(CCTime)duration_sec;

@property (nonatomic, copy, readonly) NSString* level;
@property (nonatomic) CCTime timeScale;
@property (nonatomic, readonly) CCTime duration_sec;
@property (nonatomic) CCTime elapsedTime_sec;
@property (nonatomic) GameStatus status;

@end
