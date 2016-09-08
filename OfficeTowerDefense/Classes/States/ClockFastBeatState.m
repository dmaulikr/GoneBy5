//
//  ClockFastBeatState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ClockFastBeatState.h"

#import "Animation.h"
#import "Clock.h"

@interface ClockFastBeatState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ClockFastBeatState

- (void)onEnter
{
    Clock* ui = (Clock*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION_FAST_BEAT];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
