//
//  BossTransformState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-07.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossTransformState.h"

#import "Animation.h"
#import "Boss.h"
#import "BossWalkState.h"
#import "SoundManager.h"

@interface BossTransformState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation BossTransformState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_TRANSFORM];
    [self.animation restart];

    [SoundManager playEffect:BOSS_TRANSFORM];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Boss* boss = (Boss*)self.owner;
        [boss showFiles];
        
        [self.owner setState:[BossWalkState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
