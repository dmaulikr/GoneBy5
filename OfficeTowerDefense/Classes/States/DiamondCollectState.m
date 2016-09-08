//
//  DiamondCollectState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-26.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondCollectState.h"

#import "Animation.h"
#import "CCDirector.h"
#import "Diamond.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "HermiteSpline.h"
#import "NotificationNames.h"
#import "SplineSpeedAnimator.h"

@interface DiamondCollectState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) SplineSpeedAnimator* splineAnimator;

@end

@implementation DiamondCollectState

- (void)onEnter
{
    Diamond* diamond = (Diamond*)self.owner;
    
    self.animation = [diamond getAnimationWithName:diamond.ANIMATION_IDLE];
    [self.animation restart];
    
    CGSize view = [[CCDirector sharedDirector] viewSize];
    CGPoint point1 = ccp(285, view.height - 38);
    float dx = point1.x - diamond.position.x;
    CGPoint tangent0 = ccp(dx * 3, 0);
    CGPoint tangent1 = ccp(0, 0);
    
    HermiteSpline* spline = [[HermiteSpline alloc] initWithPoint0:diamond.position point1:point1 tangent0:tangent0 tangent1:tangent1];

    self.splineAnimator = [[SplineSpeedAnimator alloc] initWithSpline:spline node:diamond speed:0 maxSpeed:400 acceleration:0];
}

- (void)tick:(CCTime)delta
{
    if (self.splineAnimator.completed) {
        Diamond* diamond = (Diamond*)self.owner;
        [diamond removeFromParent];
        
        NSNumber* number = [NSNumber numberWithInt:diamond.amount];
        NSDictionary* info = @{@"amount":number};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DIAMONDS_COLLECTED object:nil userInfo:info];
    }
    else {
        [self.splineAnimator tick:delta];
        [self.animation tick:delta];
    }
}

@end
