//
//  SweatFX.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-06-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SweatFX.h"

@implementation SweatFX

- (instancetype)init
{
    self = [super initWithID:@"fxSweat"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:0 startFrame:0 endFrame:6];
}

@end
