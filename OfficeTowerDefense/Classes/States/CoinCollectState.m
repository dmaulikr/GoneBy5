//
//  CoinCollectState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-26.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinCollectState.h"

#import "Animation.h"
#import "Coin.h"
#import "CCDirector.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "HermiteSpline.h"
#import "NotificationNames.h"
#import "SoundManager.h"
#import "SplineSpeedAnimator.h"

@interface CoinCollectState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) SplineSpeedAnimator* splineAnimator;

@end

@implementation CoinCollectState

- (void)onEnter
{
    Coin* coin = (Coin*)self.owner;
    
    self.animation = [coin getAnimationWithName:coin.ANIMATION_IDLE];
    [self.animation restart];
    
    CGSize view = [[CCDirector sharedDirector] viewSize];
    CGPoint point1 = ccp(155, view.height - 38);
    float dx = point1.x - coin.position.x;
    CGPoint tangent0 = ccp(dx * 3, -200);
    CGPoint tangent1 = ccp(0, 0);
    
    HermiteSpline* spline = [[HermiteSpline alloc] initWithPoint0:coin.position point1:point1 tangent0:tangent0 tangent1:tangent1];

    self.splineAnimator = [[SplineSpeedAnimator alloc] initWithSpline:spline node:coin speed:0 maxSpeed:400 acceleration:0];
}

- (void)tick:(CCTime)delta
{
    if (self.splineAnimator.completed) {
        Coin* coin = (Coin*)self.owner;
        [coin removeFromParent];
        
        NSNumber* number = [NSNumber numberWithInt:coin.amount];
        NSDictionary* info = @{@"amount":number};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:COINS_COLLECTED object:nil userInfo:info];
        
        [SoundManager playEffect:COLLECT];
    }
    else {
        [self.splineAnimator tick:delta];
        [self.animation tick:delta];
    }
}

@end
