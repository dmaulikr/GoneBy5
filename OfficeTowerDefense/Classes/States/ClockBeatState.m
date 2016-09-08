//
//  ClockBeatState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ClockBeatState.h"

#import "Animation.h"
#import "Clock.h"
#import "ClockFastBeatState.h"
#import "GameSession.h"

@interface ClockBeatState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ClockBeatState

- (void)onEnter
{
    Clock* ui = (Clock*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION_BEAT];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < 10) {
        [self.owner setState:[ClockFastBeatState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
