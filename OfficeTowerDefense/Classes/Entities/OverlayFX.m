//
//  OverlayFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OverlayFX.h"

#import "OverlayAnimationState.h"

@interface OverlayFX()

@property (nonatomic, copy) NSString* ANIMATION;

@end

@implementation OverlayFX

- (void)createAnimations
{
    self.ANIMATION = @"animation";
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[OverlayAnimationState new]];
}

@end
