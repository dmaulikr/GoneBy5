//
//  PowerUp1DropState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp1DropState.h"

#import "Actor.h"
#import "Animation.h"
#import "GameWorld.h"
#import "PowerUp1.h"
#import "PowerUp1GiveCoinState.h"

@interface PowerUp1DropState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp1DropState

- (void)onEnter
{
    PowerUp1* powerUp = (PowerUp1*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_DROP];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[PowerUp1GiveCoinState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
