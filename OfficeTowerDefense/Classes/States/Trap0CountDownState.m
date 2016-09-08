//
//  Trap0CountDownState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap0CountDownState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Trap0.h"
#import "Trap0ExplodeState.h"

@interface Trap0CountDownState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap0CountDownState

- (void)onEnter
{
    Trap0* trap = (Trap0*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_COUNT_DOWN];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap0* trap = (Trap0*)self.owner;
        [trap setState:[Trap0ExplodeState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
