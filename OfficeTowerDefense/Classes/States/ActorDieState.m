//
//  ActorDieState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-18.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ActorDieState.h"

#import "Actor.h"
#import "Animation.h"
#import "GameSession.h"
#import "NotificationNames.h"

@interface ActorDieState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) BOOL eventFired;

@end

@implementation ActorDieState

- (void)onEnter
{
    Actor* actor = (Actor*)self.owner;
    
    self.animation = [actor getAnimationWithName:actor.ANIMATION_DIE];
    self.eventFired = NO;
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        if (!self.eventFired) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ACTOR_DIED object:nil];
            self.eventFired = YES;
        }
    }
    else {
        [self.animation tick:delta];
    }
}

@end
