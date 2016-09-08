//
//  Coin.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Coin.h"

#import "CoinDropState.h"

@interface Coin()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) CGPoint idlePosition;
@property (nonatomic) int amount;

@end

@implementation Coin

- (instancetype)initWithAmount:(int)amount position:(CGPoint)position
{
    self = [super initWithID:@"coins"];
    
    self.zOrder = 3000;
    self.amount = amount;
    self.position = position;
    self.idlePosition = position;
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";

    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:0 startFrame:0 endFrame:7];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[CoinDropState new]];
}

- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    CGRect rect = CGRectMake(self.position.x - self.size.width / 2, self.position.y, self.size.width, self.size.height);
    
    if (CGRectContainsPoint(rect, touch.locationInWorld)) {
        [self.currentState onTouchBegan:touch withEvent:event];
    }
}

@end
