//
//  DiamondFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-04-29.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondFX.h"
#import "DiamondFxState.h"

@interface DiamondFX()

@property (nonatomic, copy) NSString* ANIMATION;

@end

@implementation DiamondFX

- (instancetype)init
{
    self = [super initWithID:@"diamondsBig"];
    [self setState:[DiamondFxState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0.5) duration:1 loopCount:0 startFrame:0 endFrame:23];
}


@end
