//
//  Loading.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-05-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Loading.h"
#import "LoadingState.h"

@interface Loading()

@property (nonatomic, copy) NSString* ANIMATION;

@end

@implementation Loading

- (instancetype)init
{
    self = [super initWithID:@"loadingWheel"];
    
    [self setState:[LoadingState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0.5) duration:0.7 loopCount:0 startFrame:0 endFrame:33];
}

@end
