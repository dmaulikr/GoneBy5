//
//  Trap3ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap3ReloadState.h"

#import "Animation.h"
#import "Trap3.h"
#import "Trap3DetectEnemyState.h"

@interface Trap3ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap3ReloadState

- (void)onEnter
{
    Trap3* trap = (Trap3*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap3DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
