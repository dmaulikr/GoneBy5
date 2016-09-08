//
//  ClockUIState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ClockUIState.h"

#import "Animation.h"
#import "ClockUI.h"
#import "GameSession.h"

@interface ClockUIState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ClockUIState

- (void)onEnter
{
    ClockUI* ui = (ClockUI*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION];

    [ui setElapsedTime:[GameSession instance].elapsedTime_sec];
}

- (void)tick:(CCTime)delta
{
    if ([GameSession instance].status != GAME_STATUS_IN_PROGRESS) {
        return;
    }
    
    ClockUI* ui = (ClockUI*)self.owner;
    
    [ui setElapsedTime:[GameSession instance].elapsedTime_sec];
    
    [self.animation tick:delta];
}

@end
