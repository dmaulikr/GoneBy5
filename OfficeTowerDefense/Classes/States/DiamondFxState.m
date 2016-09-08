//
//  DiamondFxState.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-04-29.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondFxState.h"

#import "Animation.h"
#import "DiamondFX.h"

@interface DiamondFxState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation DiamondFxState

- (void)onEnter
{
    DiamondFX* diamond = (DiamondFX*)self.owner;
    
    self.animation = [diamond getAnimationWithName:diamond.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}


@end
