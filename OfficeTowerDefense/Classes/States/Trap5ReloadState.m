//
//  Trap5ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap5ReloadState.h"

#import "Animation.h"
#import "Trap5.h"
#import "Trap5DetectEnemyState.h"

@interface Trap5ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap5ReloadState

- (void)onEnter
{
    Trap5* trap = (Trap5*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap5DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
