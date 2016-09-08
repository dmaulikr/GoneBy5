//
//  Diamond.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-29.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Diamond.h"

#import "DiamondDropState.h"

@interface Diamond()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) CGPoint idlePosition;
@property (nonatomic) int amount;

@end

@implementation Diamond

- (instancetype)initWithAmount:(int)amount position:(CGPoint)position
{
    self = [super initWithID:@"diamonds"];
    
    self.zOrder = 3000;
    self.amount = amount;
    self.position = position;
    self.idlePosition = position;
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0) duration:1.0 loopCount:0 startFrame:0 endFrame:23];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[DiamondDropState new]];
}

- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    CGRect rect = CGRectMake(self.position.x - self.size.width / 2, self.position.y, self.size.width, self.size.height);
    
    if (CGRectContainsPoint(rect, touch.locationInWorld)) {
        [self.currentState onTouchBegan:touch withEvent:event];
    }
}

@end
