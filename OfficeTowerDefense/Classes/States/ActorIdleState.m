//
//  ActorIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-18.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ActorIdleState.h"

#import "Actor.h"
#import "ActorPanicState.h"
#import "ActorTypingState.h"
#import "Animation.h"
#import "GameSession.h"
#import "GameWorld.h"

@interface ActorIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ActorIdleState

- (void)onEnter
{
    Actor* actor = (Actor*)self.owner;
    
    self.animation = [actor getAnimationWithName:actor.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Actor* actor = (Actor*)self.owner;
    CGPoint grid = actor.grid;
    
    for (int i = 0; i < 3; i++) {
        grid.x -= i;
        
        NSArray* characters = [actor.gameWorld getCharactersIntersectingGrid:grid];
        
        for (Character* character in characters) {
            if (character == self.owner) {
                continue;
            }
            
            [actor setState:[ActorPanicState new]];
            return;
        }
    }

    if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < 10) {
        [actor addBubble:ALMOST_DONE];
    }
    else if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < [GameSession instance].duration_sec / 2) {
        [actor addBubble:HALFWAY];
    }

    if (self.animation.completed) {
        [self setRandomState];
    }
    else {
        [self.animation tick:delta];
    }
}

- (void)setRandomState
{
    unsigned int random = arc4random() % 2;
    
    switch (random) {
        case 0:
            [self.owner setState:[ActorTypingState new]];
            break;
            
        default:
            [self.animation restart];
            break;
    }
}

@end
