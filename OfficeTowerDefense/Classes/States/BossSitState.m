//
//  BossSitState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossSitState.h"

#import "Animation.h"
#import "Boss.h"

@interface BossSitState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation BossSitState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_SIT];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
