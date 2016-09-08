//
//  CoinUIState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinUIState.h"

#import "Animation.h"
#import "CoinUI.h"

@interface CoinUIState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation CoinUIState

- (void)onEnter
{
    CoinUI* ui = (CoinUI*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
