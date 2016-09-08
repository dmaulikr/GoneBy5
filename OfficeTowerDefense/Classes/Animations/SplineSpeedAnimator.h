//
//  SplineSpeedAnimator.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ccTypes.h"
#import "HermiteSpline.h"

@class CCNode;

@interface SplineSpeedAnimator : NSObject

- (instancetype)initWithSpline:(HermiteSpline*)spline node:(CCNode*)node speed:(float)speed maxSpeed:(float)maxSpeed_per_sec acceleration:(float)acceleration_per_sec;

- (void)tick:(CCTime)delta;

@property (nonatomic, readonly) BOOL completed;

@end
