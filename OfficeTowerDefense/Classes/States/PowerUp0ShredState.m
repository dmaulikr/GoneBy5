//
//  PowerUp0ShredState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp0ShredState.h"

#import "Actor.h"
#import "Animation.h"
#import "GameWorld.h"
#import "PowerUp0.h"
#import "PowerUp0ShredState.h"
#import "SoundManager.h"

@interface PowerUp0ShredState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) int filesShredded;

@end

@implementation PowerUp0ShredState

- (void)onEnter
{
    PowerUp0* powerUp = (PowerUp0*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_SHRED];
    [self.animation restart];
    
    self.filesShredded = 0;
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        PowerUp0* powerUp = (PowerUp0*)self.owner;
        Actor* actor = powerUp.gameWorld.actor;
        
        if (actor.damage > 0) {
            [actor removeDamage:1];
        }
        
        self.filesShredded++;
        [self.animation restart];
        
        if (self.filesShredded == 3) {
            [powerUp removeFromParent];
        }
        
        [SoundManager playEffect:powerUp.sound];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
