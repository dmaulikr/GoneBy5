//
//  SecretaryAttackState.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-03.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SecretaryAttackState.h"

#import "Actor.h"
#import "Animation.h"
#import "GameWorld.h"
#import "Secretary.h"
#import "SecretaryExitState.h"
#import "SoundManager.h"

@interface SecretaryAttackState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation SecretaryAttackState

- (void)onEnter
{
    Secretary* character = (Secretary*)self.owner;
    
    self.animation = [character getAnimationWithName:character.ANIMATION_ATTACK];
    [self.animation restart];

    [SoundManager playEffect:FILES];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Secretary* enemy = (Secretary*)self.owner;
        Actor* actor = enemy.gameWorld.actor;

        [enemy givesFilesTo:actor];
        [enemy setState:[SecretaryExitState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
