//
//  CoinFX.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinFX.h"

#import "CoinFXAnimationState.h"

@interface CoinFX()

@property (nonatomic, copy) NSString* ANIMATION;

@end

@implementation CoinFX

- (instancetype)init
{
    self = [super initWithID:@"fxCoin0"];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:1 startFrame:0 endFrame:12];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[CoinFXAnimationState new]];
}

@end
