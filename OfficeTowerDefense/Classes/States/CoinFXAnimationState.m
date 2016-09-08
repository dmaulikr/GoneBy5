//
//  CoinFXAnimationState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinFXAnimationState.h"

#import "Animation.h"
#import "CoinFX.h"

@interface CoinFXAnimationState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation CoinFXAnimationState

- (void)onEnter
{
    CoinFX* effect = (CoinFX*)self.owner;
    
    self.animation = [effect getAnimationWithName:effect.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    CoinFX* fx = (CoinFX*)self.owner;
    
    if (self.animation.completed) {
        [fx removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
