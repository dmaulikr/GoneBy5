//
//  UIEntity.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

#import "CCSprite.h"
#import "CCSpriteFrameCache.h"

#import "Animation.h"
#import "GameSession.h"
#import "State.h"

@interface UIEntity()

@property (nonatomic) NSMutableDictionary* animations;

@end

@implementation UIEntity

- (instancetype)init
{
    self = [super init];
    
    [self setup];
    
    return self;
}

- (instancetype)initWithID:(NSString*)ID
{
    self = [super init];
    
    self.ID = ID;
    
    [self setup];
    
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", ID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    
    [self createAnimations];
    
    return self;
}

- (void)setup
{
    self.states = [NSMutableArray new];
    self.animations = [NSMutableDictionary new];
    
    self.sprite = [CCSprite new];
    self.sprite.anchorPoint = ccp(0.5, 0);
    [self addChild:self.sprite];
}

- (void)createAnimations
{
}

- (void)createAnimationWithName:(NSString*)name anchorPoint:(CGPoint)anchorPoint duration:(float)duration_sec loopCount:(int)loopCount startFrame:(int)startFrame endFrame:(int)endFrame
{
    Animation* animation = [[Animation alloc] initWithSprite:self.sprite anchorPoint:anchorPoint duration:duration_sec loopCount:loopCount];
    
    for (int i = startFrame; i <= endFrame; i++) {
        NSString* frameName = [NSString stringWithFormat:@"%@_%d", self.ID, i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [animation addSpriteFrame:frame];
    }
    
    self.animations[name] = animation;
}

- (Animation*)getAnimationWithName:(NSString*)name
{
    Animation* animation = self.animations[name];
    [animation activate];
    
    return animation;
}

- (CGSize)size
{
    return self.sprite.spriteFrame.rect.size;
}

- (float)height
{
    return self.sprite.spriteFrame.rect.size.height;
}

- (State*)currentState
{
    return [self.states lastObject];
}

- (void)setState:(State*)state
{
    for (int i = 0; i < self.states.count; i++) {
        State* tempState = self.states[i];
        
        if (tempState == [self.states lastObject]) {
            [tempState onExit];
        }
        
        tempState.owner = nil;
    }
    
    [self.states removeAllObjects];
    [self pushState:state];
}

- (void)pushState:(State*)state
{
    if (self.states.count != 0) {
        State* tempState = [self.states lastObject];
        [tempState onExit];
    }
    
    [self.states addObject:state];
    state.owner = self;
    [state onEnter];
}

- (void)popState
{
    if (self.states.count == 0) {
        return;
    }
    
    State* state = [self.states lastObject];
    [state onExit];
    state.owner = nil;
    [self.states removeLastObject];
    
    state = [self.states lastObject];
    [state onEnter];
}

- (void)tick:(CCTime)delta
{
    [self.currentState tick:delta];
    
    for (int i = (int)self.children.count - 1; i >= 0; i--) {
        id child = self.children[i];
        
        if ([child respondsToSelector:@selector(tick:)]) {
            [child tick:delta];
        }
    }
}

- (void)onTouchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
}

- (void)onTouchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
}

- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
}

- (void)onTouchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
}

@end
