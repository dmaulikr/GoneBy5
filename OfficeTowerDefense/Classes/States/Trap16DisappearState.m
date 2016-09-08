//
//  Trap16DisappearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap16DisappearState.h"

#import "Animation.h"
#import "Trap16.h"

@interface Trap16DisappearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap16DisappearState

- (void)onEnter
{
    Trap16* trap = (Trap16*)self.owner;
    
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
