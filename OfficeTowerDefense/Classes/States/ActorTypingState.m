//
//  ActorTypingState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-17.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ActorTypingState.h"

#import "Actor.h"
#import "ActorIdleState.h"
#import "ActorPanicState.h"
#import "Animation.h"
#import "GameSession.h"
#import "GameWorld.h"

@interface ActorTypingState()

@property (nonatomic, weak) Animation* animation;

@end


@implementation ActorTypingState

- (void)onEnter
{
    Actor* actor = (Actor*)self.owner;
    
    self.animation = [actor getAnimationWithName:actor.ANIMATION_TYPING];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self setRandomState];
    }
    else {
        Actor* actor = (Actor*)self.owner;
        CGPoint grid = actor.grid;
    
        for (int i = 0; i < 3; i++) {
            grid.x -= i;

            NSArray* characters = [actor.gameWorld getCharactersIntersectingGrid:grid];
        
            for (Character* character in characters) {
                if (character == self.owner) {
                    continue;
                }
            
                [self.owner setState:[ActorPanicState new]];
                return;
            }
        }

        [self.animation tick:delta];
        
        if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < 10) {
            [actor addBubble:ALMOST_DONE];
        }
        else if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < [GameSession instance].duration_sec / 2) {
            [actor addBubble:HALFWAY];
        }

    }
}

- (void)setRandomState
{
    unsigned int random = arc4random() % 2;
    
    switch (random) {
        case 0:
            [self.owner setState:[ActorIdleState new]];
            break;
            
        default:
            [self.animation restart];
            break;
    }
}

@end
