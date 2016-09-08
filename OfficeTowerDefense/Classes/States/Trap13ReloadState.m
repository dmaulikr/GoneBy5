//
//  Trap13ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap13ReloadState.h"

#import "Animation.h"
#import "Trap13.h"
#import "Trap13DetectEnemyState.h"

@interface Trap13ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap13ReloadState

- (void)onEnter
{
    Trap13* trap = (Trap13*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap13DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
