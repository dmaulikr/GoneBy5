//
//  Actor.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-16.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Actor.h"

#import "ActorDieState.h"
#import "ActorIdleState.h"
#import "BubbleFX.h"
#import "File.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "MetaDataController.h"
#import "WorkPile.h"

@interface Actor()

@property (nonatomic, copy) NSString* ANIMATION_PANIC;
@property (nonatomic, copy) NSString* ANIMATION_SUCCESS;
@property (nonatomic, copy) NSString* ANIMATION_TYPING;

@property (nonatomic) WorkPile* workPile;
@property (nonatomic) BOOL isHalfwayDone;
@property (nonatomic) BOOL isAlmostDone;

@end

@implementation Actor

- (instancetype)initWithID:(NSString *)ID hitPoints:(float)hitPoints
{
    self = [super initWithID:ID hitPoints:hitPoints];
    
    self.zOrder = 0;

    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_PANIC = @"panic";
    self.ANIMATION_TYPING = @"typing";
    self.ANIMATION_SUCCESS = @"success";
    
    self.isHalfwayDone = NO;
    self.isAlmostDone = NO;
    
    NSArray* animationNames = @[self.ANIMATION_PANIC, self.ANIMATION_SUCCESS, self.ANIMATION_TYPING];
    NSDictionary* metaData = [MetaDataController instance].characterMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    for (NSString* name in animationNames) {
        int startFrame = [animations[name][@"startFrame"] intValue];
        int endFrame = [animations[name][@"endFrame"] intValue];
        float duration = [animations[name][@"duration_sec"] floatValue];
        int loopCount = [animations[name][@"loop"] intValue];
        CGPoint anchor = ccp([animations[name][@"anchorX"] floatValue], [animations[name][@"anchorY"] floatValue]);
        
        [self createAnimationWithName:name anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];
    }
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    self.workPile = [[WorkPile alloc] initWithHitPoints:self.hitPoints];
    self.workPile.position = ccp(-10, 0);
    [self addChild:self.workPile];
    
    [self setState:[ActorIdleState new]];
}

- (void)addDamage:(float)damage
{
    [self.workPile addDamage:damage];
    [self takeDamage:damage overlay:OVERLAY_NONE dieAnimationName:@"die"];
}

- (void)removeDamage:(float)damage
{
    [self addHitPoints:damage];
    [self.workPile removeDamage:damage];
}

- (float)damage
{
    return self.workPile.hitPoints;
}

- (void)onDead:(NSString*)dieAnimationName
{
    [self setState:[ActorDieState new]];
}

- (void)addBubble:(BubbleTime)bubbleTime
{
    (bubbleTime == HALFWAY) ? [self addHalfwayBubble] : [self addAlmostDoneBubble];
}

- (void)addHalfwayBubble
{
    if (self.isHalfwayDone) {
        return;
    }
    
    BubbleFX* fx = [[BubbleFX alloc] initIsHalfway:NO];
    fx.position = ccp(-self.size.width / 2, self.height);
    [self addChild:fx];
    self.isHalfwayDone = YES;
}

- (void)addAlmostDoneBubble
{
    if (self.isAlmostDone) {
        return;
    }
    
    BubbleFX* fx = [[BubbleFX alloc] initIsHalfway:YES];
    fx.position = ccp(-self.size.width / 2, self.height);
    [self addChild:fx];
    self.isAlmostDone = YES;
}

@end
