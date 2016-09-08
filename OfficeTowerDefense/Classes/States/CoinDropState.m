//
//  CoinDropState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-22.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinDropState.h"

#import "CCDirector.h"
#import "Animation.h"
#import "Coin.h"
#import "CoinCollectState.h"
#import "CoinIdleState.h"

@interface CoinDropState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) CGPoint velocity;

@end

@implementation CoinDropState

- (void)onEnter
{
    Coin* coin = (Coin*)self.owner;
    
    self.animation = [coin getAnimationWithName:coin.ANIMATION_IDLE];
    self.animation.currentFrame = arc4random() % self.animation.totalFrames;
    
    self.velocity = ccp(0, 3.75 * [CCDirector sharedDirector].contentScaleFactor);
}

- (void)tick:(CCTime)delta
{
    const float GRAVITY_PER_SEC = -13 * [CCDirector sharedDirector].contentScaleFactor;
    
    Coin* coin = (Coin*)self.owner;
    float yVelocity = self.velocity.y + GRAVITY_PER_SEC * delta;

    self.velocity = ccp(self.velocity.x, yVelocity);
    coin.position = ccpAdd(coin.position, self.velocity);
    
    if (coin.position.y <= coin.idlePosition.y) {
        coin.position = ccp(coin.position.x, coin.idlePosition.y);
        
        [coin setState:[CoinIdleState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

- (void)onTouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.owner setState:[CoinCollectState new]];
}

@end
