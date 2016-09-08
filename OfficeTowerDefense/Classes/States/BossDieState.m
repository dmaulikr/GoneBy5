//
//  BossDieState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-09.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossDieState.h"

#import "Animation.h"
#import "Boss.h"
#import "NotificationNames.h"
#import "SoundManager.h"

@interface BossDieState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) float removeDelay_sec;

@end

@implementation BossDieState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_DIE];
    self.removeDelay_sec = 2;
    
    if (![boss.ID isEqualToString:@"boss1"]) {
        [SoundManager playEffect:ROBOT_EXPLODE];
    }
}

- (void)tick:(CCTime)delta
{
    Boss* boss = (Boss*)self.owner;
    
    if (self.animation.completed) {
        self.removeDelay_sec -= delta;
        
        if (self.removeDelay_sec <= 0) {
            [boss removeFromParent];
            [[NSNotificationCenter defaultCenter] postNotificationName:BOSS_DIED object:nil];
        }
    }
    else {
        [self.animation tick:delta];
    }
}

@end
