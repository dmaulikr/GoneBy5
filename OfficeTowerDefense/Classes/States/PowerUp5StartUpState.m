//
//  PowerUp5StartUpState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-20.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5StartUpState.h"

#import "Animation.h"
#import "PowerUp5.h"
#import "PowerUp5DetectEnemyState.h"

@interface PowerUp5StartUpState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp5StartUpState

- (void)onEnter
{
    PowerUp5* powerUp = (PowerUp5*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_START_UP];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    (self.animation.completed) ? [self.owner setState:[PowerUp5DetectEnemyState new]] : [self.animation tick:delta];
}

@end
