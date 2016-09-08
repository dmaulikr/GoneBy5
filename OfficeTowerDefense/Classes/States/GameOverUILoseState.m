//
//  GameOverUILoseState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOverUILoseState.h"

#import "Animation.h"
#import "GameOverUI.h"

@interface GameOverUILoseState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation GameOverUILoseState

- (void)onEnter
{
    GameOverUI* ui = (GameOverUI*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION_LOSE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
