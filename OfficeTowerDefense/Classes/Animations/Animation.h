//
//  Animation.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-20.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ccTypes.h"

@class CCSprite;
@class CCSpriteFrame;

@interface Animation : NSObject

- (instancetype)initWithSprite:(CCSprite*)sprite anchorPoint:(CGPoint)anchorPoint duration:(float)duration_sec loopCount:(int)loopCount;
- (void)activate;
- (void)addSpriteFrame:(CCSpriteFrame*)frame;
- (void)restart;
- (void)tick:(CCTime)delta;

@property (nonatomic) unsigned long currentFrame;
@property (nonatomic, readonly) unsigned long totalFrames;
@property (nonatomic) BOOL reversed;
@property (nonatomic) BOOL paused;
@property (nonatomic, readonly) BOOL completed;

@end
