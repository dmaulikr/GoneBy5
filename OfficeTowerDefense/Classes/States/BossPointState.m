//
//  BossPointState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossPointState.h"

#import "Animation.h"
#import "Boss.h"
#import "BossSitState.h"
#import "SoundManager.h"

@interface BossPointState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation BossPointState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_POINTING];
    [self.animation restart];

    int x = arc4random() % 100;
    if (x < 10) {
        // 25% chance to play sound effect.
        if ([boss.ID isEqualToString:@"boss3"]) {
            [SoundManager playEffect:BOSS_FEMALE_ANGRY];
        }
        else {
            [SoundManager playEffect:BOSS_ANGRY];
        }
    }
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[BossSitState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
