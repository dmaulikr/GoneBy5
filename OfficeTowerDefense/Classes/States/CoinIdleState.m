//
//  CoinIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinIdleState.h"

#import "Animation.h"
#import "Coin.h"
#import "CoinCollectState.h"

@interface CoinIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation CoinIdleState

- (void)onEnter
{
    Coin* coin = (Coin*)self.owner;
    
    self.animation = [coin getAnimationWithName:coin.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

- (void)onTouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.owner setState:[CoinCollectState new]];
}

@end
