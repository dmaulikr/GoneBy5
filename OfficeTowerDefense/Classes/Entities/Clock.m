//
//  Clock.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Clock.h"

#import "ClockIdleState.h"

@interface Clock()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;
@property (nonatomic, copy) NSString* ANIMATION_BEAT;
@property (nonatomic, copy) NSString* ANIMATION_FAST_BEAT;

@end

@implementation Clock

- (instancetype)init
{
    self = [super initWithID:@"clock"];
    
    [self setState:[ClockIdleState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";
    self.ANIMATION_BEAT = @"beat";
    self.ANIMATION_FAST_BEAT = @"fastBeat";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0.5) duration:1 loopCount:0 startFrame:0 endFrame:0];
    [self createAnimationWithName:self.ANIMATION_BEAT anchorPoint:ccp(0.5, 0.5) duration:1 loopCount:0 startFrame:1 endFrame:25];
    [self createAnimationWithName:self.ANIMATION_FAST_BEAT anchorPoint:ccp(0.5, 0.5) duration:0.5 loopCount:0 startFrame:26 endFrame:36];
}

@end
