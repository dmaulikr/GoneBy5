//
//  BossAttackState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BossAttackState.h"

#import "Actor.h"
#import "Animation.h"
#import "Boss.h"
#import "EnemyIdleState.h"
#import "GameWorld.h"
#import "SoundManager.h"

@interface BossAttackState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation BossAttackState

- (void)onEnter
{
    Boss* boss = (Boss*)self.owner;
    
    self.animation = [boss getAnimationWithName:boss.ANIMATION_ATTACK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Boss* boss = (Boss*)self.owner;
        Actor* actor = boss.gameWorld.actor;
        
        [boss givesFilesTo:actor];
        [actor takeDamage:actor.hitPoints overlay:OVERLAY_NONE dieAnimationName:@"die"];
        [boss setState:[EnemyIdleState new]];

        [SoundManager playEffect:FILES];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
