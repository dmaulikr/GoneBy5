//
//  HitFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "HitFX.h"

@implementation HitFX

- (instancetype)init
{
    self = [super initWithID:@"fxHit0"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    unsigned int frame = arc4random() % 3;
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:1 startFrame:frame endFrame:frame];
}


@end
