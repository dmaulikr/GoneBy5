//
//  Trap4ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-29.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap4ReloadState.h"

#import "Animation.h"
#import "Trap4.h"
#import "Trap4DetectEnemyState.h"

@interface Trap4ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap4ReloadState

- (void)onEnter
{
    Trap4* trap = (Trap4*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap4DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
