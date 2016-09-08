//
//  Trap0DisappearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap0DisappearState.h"

#import "Animation.h"
#import "Trap0.h"

@interface Trap0DisappearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap0DisappearState

- (void)onEnter
{
    Trap0* trap = (Trap0*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DISAPPEAR];
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
