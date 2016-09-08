//
//  ClockIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ClockIdleState.h"

#import "Animation.h"
#import "Clock.h"
#import "ClockBeatState.h"
#import "GameSession.h"

@interface ClockIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ClockIdleState

- (void)onEnter
{
    Clock* ui = (Clock*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < [GameSession instance].duration_sec / 2) {
        [self.owner setState:[ClockBeatState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
