//
//  Trap1CountDownState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap1CountDownState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Trap1.h"
#import "Trap1ExplodeState.h"

@interface Trap1CountDownState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap1CountDownState

- (void)onEnter
{
    Trap1* trap = (Trap1*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_COUNT_DOWN];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap1* trap = (Trap1*)self.owner;
        
        [trap setState:[Trap1ExplodeState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
