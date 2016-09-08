//
//  ButtonControl.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-24.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ButtonControl.h"

#import "Animation.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"

@interface ButtonControl()

@property (nonatomic, strong) Animation* animation;
@property (nonatomic, strong) CCSprite* cooldownSprite;

@property (nonatomic, strong) NSMutableArray* delegates;
@property (nonatomic) BOOL isActive;

@property (nonatomic) CCTime coolDown_sec;
@property (nonatomic) CCTime remainingCoolDown_sec;

@end

@implementation ButtonControl

- (instancetype)initWithNormalFrame:(CCSpriteFrame*)normalFrame highlightedFrame:(CCSpriteFrame*)highlightedFrame disabledFrame:(CCSpriteFrame*)disabledFrame
{
    self = [super init];
    
    Animation* animation = [[Animation alloc] initWithSprite:self anchorPoint:ccp(0.5, 0) duration:1.0  loopCount:1];
    [animation addSpriteFrame:normalFrame];
    [animation addSpriteFrame:highlightedFrame];
    [animation addSpriteFrame:disabledFrame];
    
    self.animation = animation;
    self.isActive = NO;
    self.coolDown_sec = 0;
    self.remainingCoolDown_sec = 0;
    
    self.delegates = [NSMutableArray new];
    
    return self;
}

- (void)tick:(CCTime)delta
{
    if (self.remainingCoolDown_sec > 0) {
        self.remainingCoolDown_sec -= delta;
        
        float ratio = fmax(0, self.remainingCoolDown_sec / self.coolDown_sec);
        
        [self resizeSprite:self.cooldownSprite width:self.contentSize.width height:self.contentSize.height * ratio];
    }
    else {
        self.remainingCoolDown_sec = 0;

        if (self.cooldownSprite) {
            [self.cooldownSprite removeFromParent];
        }
    }
}

- (void)setEnabled:(BOOL)value
{
    _enabled = value;
    self.animation.currentFrame = (value) ? 0 : 2;
}

- (void)addDelegate:(id<ButtonControlDelegate>)delegate
{
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<ButtonControlDelegate>)delegate
{
    [self.delegates removeObject:delegate];
}

- (void)removeAllDelegates
{
    [self.delegates removeAllObjects];
}

- (void)setCoolDownTime:(CCTime)coolDown_sec
{
    if (coolDown_sec <= 0) {
        self.remainingCoolDown_sec = 0;
        
        return;
    }
    
    self.coolDown_sec = coolDown_sec;
    self.remainingCoolDown_sec = coolDown_sec;
    
    self.cooldownSprite = [CCSprite spriteWithImageNamed:@"trapHolder.png"];
    self.cooldownSprite.color = [CCColor blackColor];
    self.cooldownSprite.anchorPoint = ccp(0, 0);
    self.cooldownSprite.opacity = 0.6;
    
    [self addChild:self.cooldownSprite];
}

- (void)onTouchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    if (!self.enabled || ![self isTouched:touch] || self.remainingCoolDown_sec > 0) {
        return;
    }
    
    self.animation.currentFrame = 1;
    self.isActive = YES;
        
    for (id<ButtonControlDelegate> delegate in self.delegates) {
        [delegate onButtonControlTouchDown:touch withEvent:event];
    }
}

- (void)onTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    if (!self.isActive) {
        return;
    }
    
    for (id<ButtonControlDelegate> delegate in self.delegates) {
        [delegate onButtonControlTouchMoved:touch withEvent:event];
    }
}

- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    if (self.isActive) {
        for (id<ButtonControlDelegate> delegate in self.delegates) {
            [delegate onButtonControlTouchUp:touch withEvent:event];
        }
    }
    
    self.animation.currentFrame = (self.enabled) ? 0 : 2;
    self.isActive = NO;
}

- (void)onTouchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    if (self.isActive) {
        for (id<ButtonControlDelegate> delegate in self.delegates) {
            [delegate onButtonControlTouchUp:touch withEvent:event];
        }
    }
    
    self.animation.currentFrame = (self.enabled) ? 0 : 2;
    self.isActive = NO;
}

- (BOOL)isTouched:(CCTouch*)touch
{
    CGSize size = self.spriteFrame.rect.size;
    CGPoint position = [self.parent convertToWorldSpace:self.position];
    CGRect rect = CGRectMake(position.x - size.width / 2, position.y - size.height / 2, size.width, size.height);
    
    return CGRectContainsPoint(rect, touch.locationInWorld);
}

-(void)resizeSprite:(CCSprite*)sprite width:(float)width height:(float)height
{
    sprite.scaleX = fmax(0, width / sprite.contentSize.width);
    sprite.scaleY = fmax(0, height / sprite.contentSize.height);
}

@end