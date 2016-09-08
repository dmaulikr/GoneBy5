//
//  OverlayAnimationState.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OverlayAnimationState.h"

#import "Animation.h"
#import "OverlayFX.h"

@interface OverlayAnimationState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation OverlayAnimationState

- (void)onEnter
{
    OverlayFX* effect = (OverlayFX*)self.owner;
    
    self.animation = [effect getAnimationWithName:effect.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    OverlayFX* fx = (OverlayFX*)self.owner;
    
    if (self.animation.completed) {
        [fx removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
