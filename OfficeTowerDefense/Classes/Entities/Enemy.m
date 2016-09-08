//
//  Enemy.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-28.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Enemy.h"

#import "Actor.h"
#import "Coin.h"
#import "EnemyDieState.h"
#import "EnemyIdleState.h"
#import "GameWorld.h"
#import "MetaDataController.h"

@interface Enemy()

@property (nonatomic, copy) NSString* ANIMATION_ATTACK;
@property (nonatomic, copy) NSString* ANIMATION_BURN;
@property (nonatomic, copy) NSString* ANIMATION_WALK;

@property (nonatomic) float speedModifier;
@property (nonatomic) float speedModifierDuration_sec;
@property (nonatomic) int coins;
@property (nonatomic) BOOL scared;

@end

@implementation Enemy

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec
{
    self = [super initWithID:ID hitPoints:hitPoints];
    
    self.coins = coins;
    self.speed_per_sec = speed_per_sec;
    self.speedModifier = 1.0;
    self.speedModifierDuration_sec = 0.0;
    self.scared = NO;
    self.scaleX = -1;
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_ATTACK = @"attack";
    self.ANIMATION_BURN = @"burn";
    self.ANIMATION_WALK = @"walk";
    
    NSArray* animationNames = @[self.ANIMATION_ATTACK, self.ANIMATION_BURN, self.ANIMATION_WALK];
    NSDictionary* metaData = [MetaDataController instance].characterMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    for (int i = 0; i < animationNames.count; i++) {
        NSString* name = animationNames[i];
        int startFrame = [animations[name][@"startFrame"] intValue];
        int endFrame = [animations[name][@"endFrame"] intValue];
        float duration = [animations[name][@"duration_sec"] floatValue];
        int loopCount = [animations[name][@"loop"] intValue];
        CGPoint anchor = ccp([animations[name][@"anchorX"] floatValue], [animations[name][@"anchorY"] floatValue]);
        
        [self createAnimationWithName:name anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];
    }
}

- (void)tick:(CCTime)delta
{
    if (self.speedModifierDuration_sec > 0.0) {
        self.speedModifierDuration_sec -= delta;
    }
    else {
        self.speedModifier = 1.0;
        self.speedModifierDuration_sec = 0.0;
    }

    [super tick:delta];
}

- (void)modifySpeed:(float)modifier duration:(float)duration_sec
{
    if (modifier >= self.speedModifier) {
        return;
    }
    
    self.speedModifier = modifier;
    self.speedModifierDuration_sec = duration_sec;
}

- (void)scare
{
}

- (void)exitElevator
{
}

- (void)onDead:(NSString*)dieAnimationName
{
    for (int i = 0; i < self.coins; i++) {
        float xOffset = drand48() * 40 - 20;
        
        CGPoint position = ccp(self.position.x + xOffset, self.position.y);
        Coin* coin = [[Coin alloc] initWithAmount:1 position:position];
        
        [self.gameWorld addChild:coin];
    }
    
    [self setState:[[EnemyDieState alloc] initWithAnimationName:dieAnimationName]];
}

- (BOOL)isIdle
{
    return [self.currentState isKindOfClass:[EnemyIdleState class]];
}

- (BOOL)isWalking
{
    return false;
}

@end
