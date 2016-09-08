//
//  BossLoseState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-07.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossLoseState.h"

#import "Animation.h"
#import "Boss.h"
#import "NotificationNames.h"

@interface BossLoseState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) BOOL eventFired;

@end

@implementation BossLoseState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_LOSE];
    [self.animation restart];
    
    self.eventFired = NO;
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        if (!self.eventFired) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BOSS_LOSE object:nil];
            self.eventFired = YES;
        }
    }
    else {
        [self.animation tick:delta];
    }
}

@end
