//
//  PowerUp1GiveCoinState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp1GiveCoinState.h"

#import "Animation.h"
#import "Coin.h"
#import "GameWorld.h"
#import "PowerUp1.h"
#import "SoundManager.h"

@interface PowerUp1GiveCoinState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) int coinsGiven;
@property (nonatomic) CCTime coinInterval;

@end

@implementation PowerUp1GiveCoinState

- (void)onEnter
{
    PowerUp1* powerUp = (PowerUp1*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_IDLE];
    [self.animation restart];
    
    self.coinsGiven = 0;
    self.coinInterval = powerUp.coinInterval_sec;
}

- (void)tick:(CCTime)delta
{
    PowerUp1* powerUp = (PowerUp1*)self.owner;

    self.coinInterval -= delta;
    
    while (self.coinInterval <= 0) {
        self.coinInterval += powerUp.coinInterval_sec;

        float xOffset = drand48() * 40 - 20;
        CGPoint position = ccp(powerUp.position.x + xOffset, powerUp.position.y);

        [SoundManager playEffect:powerUp.sound];
        
        Coin* coin = [[Coin alloc] initWithAmount:1 position:position];
        [powerUp.gameWorld addChild:coin];
        
        self.coinsGiven++;
        
        if (self.coinsGiven == powerUp.coins) {
            [powerUp removeFromParent];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
