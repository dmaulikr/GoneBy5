//
//  SpeechFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BubbleFX.h"

@interface BubbleFX()

@property (nonatomic) BOOL isHalfway;

@end

@implementation BubbleFX

- (instancetype)initIsHalfway:(BOOL)isHalfway
{
    self = [super initWithID:@"speakBubble"];
    self.isHalfway = isHalfway;
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    unsigned int frame;
    
    frame = (self.isHalfway) ? arc4random() % 3 + 3: arc4random() % 3;
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:5 loopCount:1 startFrame:frame endFrame:frame];
}

@end
