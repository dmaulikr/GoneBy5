//
//  PowerUp0DropState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp0DropState.h"

#import "Actor.h"
#import "Animation.h"
#import "GameWorld.h"
#import "PowerUp0.h"
#import "PowerUp0ShredState.h"

@interface PowerUp0DropState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp0DropState

- (void)onEnter
{
    PowerUp0* powerUp = (PowerUp0*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_DROP];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        PowerUp0* powerUp = (PowerUp0*)self.owner;
        Actor* actor = powerUp.gameWorld.actor;
        
        if (actor.damage > 0) {
            [powerUp setState:[PowerUp0ShredState new]];
        }
        else {
            [powerUp removeFromParent];
        }
    }
    else {
        [self.animation tick:delta];
    }
}

@end
