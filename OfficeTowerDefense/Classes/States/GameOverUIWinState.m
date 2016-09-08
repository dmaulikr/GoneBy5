//
//  GameOverUIWinState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOverUIWinState.h"

#import "Animation.h"
#import "GameOverUI.h"

@interface GameOverUIWinState()

@property (nonatomic, strong) Animation* animation;

@end

@implementation GameOverUIWinState

- (void)onEnter
{
    GameOverUI* ui = (GameOverUI*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION_WIN];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
