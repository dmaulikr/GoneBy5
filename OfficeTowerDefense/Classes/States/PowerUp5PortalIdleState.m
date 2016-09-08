//
//  PowerUp5PortalIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5PortalIdleState.h"

#import "Animation.h"
#import "PowerUp5Portal.h"

@interface PowerUp5PortalIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation PowerUp5PortalIdleState

- (void)onEnter
{
    PowerUp5Portal* powerUp = (PowerUp5Portal*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_PORTAL_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
