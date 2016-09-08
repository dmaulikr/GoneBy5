//
//  Trap14ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap14ReloadState.h"

#import "Animation.h"
#import "Trap14.h"
#import "Trap14DetectEnemyState.h"

@interface Trap14ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap14ReloadState

- (void)onEnter
{
    Trap14* trap = (Trap14*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap14DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
