//
//  Trap17ReloadState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap17ReloadState.h"

#import "Animation.h"
#import "Trap17.h"
#import "Trap17DetectEnemyState.h"

@interface Trap17ReloadState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap17ReloadState

- (void)onEnter
{
    Trap17* trap = (Trap17*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_RELOAD];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap17DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
