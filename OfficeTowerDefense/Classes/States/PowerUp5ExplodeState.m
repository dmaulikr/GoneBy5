//
//  PowerUp5ExplodeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5ExplodeState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "PowerUp5.h"

@interface PowerUp5ExplodeState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp5ExplodeState

- (void)onEnter
{
    PowerUp5* powerUp = (PowerUp5*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_EXPLODE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    (self.animation.completed) ? [self.owner removeFromParent] : [self.animation tick:delta];
}

@end
