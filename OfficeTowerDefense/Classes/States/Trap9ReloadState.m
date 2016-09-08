//
//  Trap9ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap9ReloadState.h"

#import "Animation.h"
#import "Trap9.h"
#import "Trap9DetectEnemyState.h"

@interface Trap9ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap9ReloadState

- (void)onEnter
{
    Trap9* trap = (Trap9*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}


- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap9DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
