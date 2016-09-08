//
//  SplineSpeedAnimator.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SplineSpeedAnimator.h"

#import "CCNode.h"

@interface SplineSpeedAnimator()

@property (nonatomic) HermiteSpline* spline;
@property (nonatomic) CCNode* node;
@property (nonatomic) float maxSpeed_per_sec;
@property (nonatomic) float acceleration_per_sec;

@property (nonatomic) float speed;
@property (nonatomic) float distance;

@property (nonatomic) BOOL completed;

@end

@implementation SplineSpeedAnimator

- (instancetype)initWithSpline:(HermiteSpline*)spline node:(CCNode*)node speed:(float)speed maxSpeed:(float)maxSpeed_per_sec acceleration:(float)acceleration_per_sec
{
    self = [self init];
    
    self.spline = spline;
    self.node = node;
    self.maxSpeed_per_sec = maxSpeed_per_sec;
    self.acceleration_per_sec = acceleration_per_sec;
    self.speed = (acceleration_per_sec == 0) ? maxSpeed_per_sec : speed;
    self.distance = 0;
    self.completed = NO;
    
    self.node.position = [self.spline interpolate:self.distance];

    return self;
}

- (void)tick:(CCTime)delta
{
    if (self.completed) {
        return;
    }
    
    self.speed = fminf(self.maxSpeed_per_sec, self.speed + self.acceleration_per_sec * delta);
    self.distance += self.speed * delta;
    
    float t = [self.spline getParameter:self.distance];
    
    self.node.position = [self.spline interpolate:t];
    
    if (self.distance >= self.spline.length) {
        self.completed = YES;
    }
}

@end
