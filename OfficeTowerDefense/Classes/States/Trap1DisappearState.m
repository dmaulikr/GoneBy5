//
//  Trap1DisappearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap1DisappearState.h"

#import "Animation.h"
#import "Trap1.h"

@interface Trap1DisappearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap1DisappearState

- (void)onEnter
{
    Trap1* trap = (Trap1*)self.owner;
    
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
