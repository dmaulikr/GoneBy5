//
//  Projectile1LaunchState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Projectile1LaunchState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "HermiteSpline.h"
#import "Projectile1.h"
#import "Projectile1ExplodeState.h"
#import "SplineSpeedAnimator.h"

@interface Projectile1LaunchState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) SplineSpeedAnimator* splineAnimator;

@end

@implementation Projectile1LaunchState

- (void)onEnter
{
    Projectile1* projectile = (Projectile1*)self.owner;
    
    self.animation = [projectile getAnimationWithName:projectile.ANIMATION_IDLE];
    [self.animation restart];
    
    CGPoint targetGrid = ccp(projectile.grid.x - projectile.scaleX * projectile.gridDistance, projectile.grid.y);
    CGPoint point1 = [projectile.gameWorld getFloorPositionFromGrid:targetGrid];
    CGPoint tangent0 = (projectile.scaleX == 1) ? ccp(-400, 100) : ccp(400, 100);
    CGPoint tangent1 = ccp(0, 0);
    
    HermiteSpline* spline = [[HermiteSpline alloc] initWithPoint0:projectile.position point1:point1 tangent0:tangent0 tangent1:tangent1];    
    
    self.splineAnimator = [[SplineSpeedAnimator alloc] initWithSpline:spline node:projectile speed:400 maxSpeed:700 acceleration:350];
}

- (void)tick:(CCTime)delta
{
    if (self.splineAnimator.completed) {
        [self.owner setState:[Projectile1ExplodeState new]];
    }
    else {
        [self.splineAnimator tick:delta];
        [self.animation tick:delta];
    }
}

@end
