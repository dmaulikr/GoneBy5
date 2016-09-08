//
//  GameSession.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameSession.h"

@interface GameSession()

@property (nonatomic) CCTime duration_sec;

@end

@implementation GameSession

+ (GameSession*)instance
{
    static GameSession* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GameSession alloc] init];
    });
    
    return _sharedInstance;
}

- (void)start
{
    self.timeScale = 1.0;
    self.elapsedTime_sec = 0.0;
    self.status = GAME_STATUS_IN_PROGRESS;
}

- (void)startWithDuration:(CCTime)duration_sec;
{
    self.duration_sec = duration_sec;
    
    [self start];
}

@end