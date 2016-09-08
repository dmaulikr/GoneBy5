//
//  Trap6ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap6ReloadState.h"

#import "Animation.h"
#import "Trap6.h"
#import "Trap6DetectEnemyState.h"

@interface Trap6ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap6ReloadState

- (void)onEnter
{
    Trap6* trap = (Trap6*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap6DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
