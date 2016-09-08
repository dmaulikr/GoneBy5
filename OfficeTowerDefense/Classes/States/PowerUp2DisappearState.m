//
//  PowerUp2DisappearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp2DisappearState.h"

#import "Animation.h"
#import "PowerUp2.h"

@interface PowerUp2DisappearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp2DisappearState

- (void)onEnter
{
    PowerUp2* powerUp = (PowerUp2*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_DISAPPEAR];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
