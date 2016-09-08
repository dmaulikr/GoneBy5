//
//  UIEntity.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@class Animation;
@class CCSprite;
@class State;

@interface UIEntity : CCNode

- (instancetype)initWithID:(NSString*)ID;

- (void)setup;
- (void)createAnimations;
- (void)createAnimationWithName:(NSString*)name anchorPoint:(CGPoint)anchorPoint duration:(float)duration_sec loopCount:(int)loopCount startFrame:(int)startFrame endFrame:(int)endFrame;
- (Animation*)getAnimationWithName:(NSString*)name;
- (void)setState:(State*)state;
- (void)pushState:(State*)state;
- (void)popState;
- (void)tick:(CCTime)delta;

- (void)onTouchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event;

@property (nonatomic) NSMutableArray* states;

@property (nonatomic, copy) NSString* ID;
@property (nonatomic) CCSprite* sprite;
@property (nonatomic, weak, readonly) State* currentState;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) float height;

@end
