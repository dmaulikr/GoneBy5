//
//  JanitorPostAttackState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "JanitorPostAttackState.h"

#import "Animation.h"
#import "Janitor.h"
#import "JanitorWalkState.h"

@interface JanitorPostAttackState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation JanitorPostAttackState

- (void)onEnter
{
    Janitor* janitor = (Janitor*)self.owner;
    
    self.animation = [janitor getAnimationWithName:janitor.ANIMATION_POST_ATTACK];
    [self.animation restart];    
}

- (void)tick:(CCTime)delta
{
    Janitor* janitor = (Janitor*)self.owner;
    
    if (self.animation.completed) {
        [janitor setState:[JanitorWalkState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
