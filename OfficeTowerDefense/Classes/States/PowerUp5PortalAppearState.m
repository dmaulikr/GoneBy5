//
//  PowerUp5PortalAppearState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-22.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5PortalAppearState.h"

#import "Animation.h"
#import "PowerUp5Portal.h"
#import "PowerUp5PortalIdleState.h"

@interface PowerUp5PortalAppearState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp5PortalAppearState

- (void)onEnter
{
    PowerUp5Portal* powerUp = (PowerUp5Portal*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_PORTAL_APPEAR];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    (self.animation.completed) ? [self.owner setState:[PowerUp5PortalIdleState new]] : [self.animation tick:delta];
}

@end
