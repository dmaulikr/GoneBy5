//
//  Trap19ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap19ReloadState.h"

#import "Animation.h"
#import "Trap19.h"
#import "Trap19DetectEnemyState.h"

@interface Trap19ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap19ReloadState

- (void)onEnter
{
    Trap19* trap = (Trap19*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap19DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
