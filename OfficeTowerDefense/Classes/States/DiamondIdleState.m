//
//  DiamondIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondIdleState.h"

#import "Animation.h"
#import "Diamond.h"
#import "DiamondCollectState.h"

@interface DiamondIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation DiamondIdleState

- (void)onEnter
{
    Diamond* diamond = (Diamond*)self.owner;
    
    self.animation = [diamond getAnimationWithName:diamond.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

- (void)onTouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.owner setState:[DiamondCollectState new]];
}

@end
