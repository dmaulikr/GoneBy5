//
//  Trap18ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap18ReloadState.h"

#import "Animation.h"
#import "Trap18.h"
#import "Trap18DetectEnemyState.h"

@interface Trap18ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap18ReloadState

- (void)onEnter
{
    Trap18* trap = (Trap18*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap18DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
