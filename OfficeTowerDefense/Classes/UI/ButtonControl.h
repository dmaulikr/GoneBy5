//
//  ButtonControl.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-24.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
#import "CCSprite.h"

@class CCSpriteFrame;
@class GameWorld;

@protocol ButtonControlDelegate <NSObject>

- (void)onButtonControlTouchDown:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onButtonControlTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onButtonControlTouchUp:(CCTouch*)touch withEvent:(CCTouchEvent*)event;

@end

@interface ButtonControl : CCSprite

- (instancetype)initWithNormalFrame:(CCSpriteFrame*)normalFrame highlightedFrame:(CCSpriteFrame*)highlightedFrame disabledFrame:(CCSpriteFrame*)disabledFrame;

- (void)tick:(CCTime)delta;
- (void)addDelegate:(id <ButtonControlDelegate>)delegate;
- (void)removeDelegate:(id <ButtonControlDelegate>)delegate;
- (void)removeAllDelegates;
- (void)setCoolDownTime:(CCTime)coolDown_sec;
- (void)onTouchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event;

@property (nonatomic) BOOL enabled;

@end
