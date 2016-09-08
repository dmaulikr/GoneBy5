//
//  Trap8ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap8ReloadState.h"

#import "Animation.h"
#import "Trap8.h"
#import "Trap8DetectEnemyState.h"

@interface Trap8ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap8ReloadState

- (void)onEnter
{
    Trap8* trap = (Trap8*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap8DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
