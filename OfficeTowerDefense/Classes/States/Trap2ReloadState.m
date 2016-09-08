//
//  Trap2ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap2ReloadState.h"

#import "Animation.h"
#import "Trap2.h"
#import "Trap2DetectEnemyState.h"

@interface Trap2ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap2ReloadState

- (void)onEnter
{
    Trap2* trap = (Trap2*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap2DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
