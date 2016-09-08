//
//  DizzyFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DizzyFX.h"

@implementation DizzyFX

- (instancetype)init
{
    self = [super initWithID:@"fxDizzy0"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:1 startFrame:0 endFrame:23];
}

@end
