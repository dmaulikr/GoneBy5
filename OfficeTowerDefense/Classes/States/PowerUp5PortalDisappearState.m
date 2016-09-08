//
//  PowerUp5PortalDisappearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-22.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5PortalDisappearState.h"

#import "Animation.h"
#import "PowerUp5Portal.h"

@interface PowerUp5PortalDisappearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp5PortalDisappearState

- (void)onEnter
{
    PowerUp5Portal* powerUp = (PowerUp5Portal*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_PORTAL_DISAPPEAR];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    (self.animation.completed) ? [self.owner removeFromParent] : [self.animation tick:delta];
}

@end
