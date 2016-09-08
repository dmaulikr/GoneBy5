//
//  ActorPanicState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-18.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ActorPanicState.h"

#import "Actor.h"
#import "ActorIdleState.h"
#import "Animation.h"
#import "GameSession.h"
#import "GameWorld.h"

@interface ActorPanicState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ActorPanicState

- (void)onEnter
{
    Actor* actor = (Actor*)self.owner;
    
    self.animation = [actor getAnimationWithName:actor.ANIMATION_PANIC];
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
            
            if (!character.isDead) {
                [self.animation tick:delta];
                return;
            }
        }
    }
    
    if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < 10) {
        [actor addBubble:ALMOST_DONE];
    }
    else if ([GameSession instance].duration_sec - [GameSession instance].elapsedTime_sec < [GameSession instance].duration_sec / 2) {
        [actor addBubble:HALFWAY];
    }
    
    [self.owner setState:[ActorIdleState new]];
}

@end
