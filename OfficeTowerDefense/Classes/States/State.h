//
//  State.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-17.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccTypes.h"

@class CCTouch;
@class CCTouchEvent;
@class UIEntity;

@interface State : NSObject

- (void)onEnter;
- (void)tick:(CCTime)delta;
- (void)onExit;
- (void)onTouchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event;
- (void)onTouchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event;

@property (nonatomic, weak) UIEntity* owner;

@end
