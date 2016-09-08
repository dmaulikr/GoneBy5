//
//  Trap16CountDownState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap16CountDownState.h"

#import "Animation.h"
#import "Trap16.h"
#import "Trap16ExplodeState.h"

@interface Trap16CountDownState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap16CountDownState

- (void)onEnter
{
    Trap16* trap = (Trap16*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_COUNT_DOWN];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap16ExplodeState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
