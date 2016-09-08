//
//  DiamondUIState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-10.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondUIState.h"

#import "Animation.h"
#import "DiamondUI.h"

@interface DiamondUIState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation DiamondUIState

- (void)onEnter
{
    DiamondUI* ui = (DiamondUI*)self.owner;
    
    self.animation = [ui getAnimationWithName:ui.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
