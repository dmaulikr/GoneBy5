//
//  Animation.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-20.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Animation.h"

#import "CCSprite.h"


@interface Animation()

@property (nonatomic, weak) CCSprite* sprite;
@property (nonatomic, strong) NSMutableArray* frames;
@property (nonatomic) CGPoint anchorPoint;
@property (nonatomic) float duration_sec;
@property (nonatomic) float frameDelay_sec;
@property (nonatomic) int loopCount;

@property (nonatomic) BOOL initialized;
@property (nonatomic) float runningFrameDelay_sec;
@property (nonatomic) BOOL completed;

@property (nonatomic) int currentLoopCount;

@end

@implementation Animation

- (instancetype)initWithSprite:(CCSprite*)sprite anchorPoint:(CGPoint)anchorPoint duration:(float)duration_sec loopCount:(int)loopCount
{
    self = [super init];
    
    self.sprite = sprite;
    self.anchorPoint = anchorPoint;
    self.duration_sec = duration_sec;
    self.loopCount = loopCount;
    self.frames = [NSMutableArray new];
    _currentFrame = 0;
    self.runningFrameDelay_sec = 0;
    self.initialized = NO;
    self.reversed = NO;
    self.paused = NO;
    self.completed = NO;
    self.currentLoopCount = 0;
    
    return self;
}

- (void)activate
{
    self.sprite.anchorPoint = self.anchorPoint;
    [self.sprite setSpriteFrame:self.frames[self.currentFrame]];
}

- (void)setCurrentFrame:(unsigned long)currentFrame
{
    if (currentFrame >= self.frames.count) {
        return;
    }
    
    _currentFrame = currentFrame;
    [self.sprite setSpriteFrame:self.frames[_currentFrame]];
}

- (unsigned long)totalFrames
{
    return self.frames.count;
}

- (void)addSpriteFrame:(CCSpriteFrame*)frame
{
    [self.frames addObject:frame];

    if (self.frames.count == 1) {
        [self.sprite setSpriteFrame:frame];
    }
}

- (void)restart
{
    self.paused = NO;
    self.completed = NO;
    self.currentLoopCount = 0;
    self.currentFrame = (!self.reversed) ? 0 : self.frames.count - 1;
    [self.sprite setSpriteFrame:self.frames[self.currentFrame]];
}

- (void)nextFrame
{
    if (self.currentFrame < self.frames.count - 1) {
        self.currentFrame++;
    }
    else if (self.currentFrame == self.frames.count - 1) {
        if (self.loopCount == 0) {
            [self restart];
        }
        else {
            self.currentLoopCount++;
            
            if (self.currentLoopCount == self.loopCount) {
                self.completed = YES;
            }
            else {
                self.currentFrame = 0;
            }
        }
    }
    
    [self.sprite setSpriteFrame:self.frames[self.currentFrame]];
}

- (void)previousFrame
{
    if (self.currentFrame > 0) {
        self.currentFrame--;
    }
    else if (self.currentFrame == 0) {
        if (self.loopCount == 0) {
            [self restart];
        }
        else {
            self.currentLoopCount++;

            if (self.currentLoopCount == self.loopCount) {
                self.completed = YES;
            }
            else {
                self.currentFrame = self.frames.count - 1;
            }
        }
    }
    
    [self.sprite setSpriteFrame:self.frames[self.currentFrame]];
}

- (void)tick:(CCTime)delta
{
    if (!self.initialized) {
        self.frameDelay_sec = self.duration_sec / self.frames.count;
        self.initialized = YES;
    }
    
    if (self.paused) {
        return;
    }
    
    self.runningFrameDelay_sec += delta;
    
    if (self.runningFrameDelay_sec >= self.frameDelay_sec) {
        self.runningFrameDelay_sec -= self.frameDelay_sec;
        
        (!self.reversed) ? [self nextFrame] : [self previousFrame];
    }
}

@end
