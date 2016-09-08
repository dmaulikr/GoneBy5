//
//  Character.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-15.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Character.h"

#import "Actor.h"
#import "Animation.h"
#import "ColdFX.h"
#import "DizzyFX.h"
#import "EnemyIdleState.h"
#import "HitFX.h"
#import "GameWorld.h"
#import "MetaDataController.h"
#import "SweatFX.h"

@interface Character()

@property (nonatomic, copy) NSString* ANIMATION_POST_ATTACK;
@property (nonatomic, copy) NSString* ANIMATION_PRE_ATTACK;
@property (nonatomic, copy) NSString* ANIMATION_DIE;
@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) float hitPoints;

@end

@implementation Character

- (instancetype)initWithID:(NSString*)ID hitPoints:(float)hitPoints;
{
    self = [super initWithID:ID];

    self.hitPoints = hitPoints;
    self.zOrder = 500;
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_DIE = @"die";
    self.ANIMATION_IDLE = @"idle";
    
    NSArray* animationNames = @[self.ANIMATION_DIE, self.ANIMATION_IDLE];
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

- (void)addHitPoints:(float)hitPoints
{
    self.hitPoints += hitPoints;
}

- (void)addOverlay:(OverlayType)overlayType
{
    for (CCNode* child in self.children) {
        if ([child isKindOfClass:[OverlayFX class]]) {
            return;
        }
    }
    
    OverlayFX* fx;
    
    switch (overlayType) {
        case OVERLAY_COLD:
            fx = [[ColdFX alloc] initWithCharacter:(Enemy *)self];
            fx.position = ccp(0, 0);
            break;
            
        case OVERLAY_DIZZY:
            fx = [DizzyFX new];
            fx.position = ccp(0, self.height);
            break;
            
        case OVERLAY_HIT:
            fx = [HitFX new];
            fx.position = ccp(0, self.height / 2 - 6);
            break;
            
        case OVERLAY_SWEAT:
            fx = [SweatFX new];
            fx.position = ccp(8, self.height / 2);
            break;
            
        default:
            fx = nil;
            break;
    }
    
    if (fx) {
        [self addChild:fx];
    }
}

- (void)removeOverlay:(OverlayType)overlayType
{
    for (CCNode* child in self.children) {
        switch (overlayType) {
            case OVERLAY_COLD:
                if ([child isKindOfClass:[ColdFX class]]) {
                    [self removeChild:child];
                }
                break;
                
            case OVERLAY_DIZZY:
                if ([child isKindOfClass:[DizzyFX class]]) {
                    [self removeChild:child];
                }
                break;
                
            case OVERLAY_HIT:
                if ([child isKindOfClass:[HitFX class]]) {
                    [self removeChild:child];
                }
                break;
                
            case OVERLAY_SWEAT:
                if ([child isKindOfClass:[SweatFX class]]) {
                    [self removeChild:child];
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)takeDamage:(float)damage overlay:(OverlayType)overlay dieAnimationName:(NSString*)animationName
{
    BOOL previouslyDead = self.isDead;
    
    self.hitPoints -= damage;

    if (!previouslyDead && self.isDead) {
        [self onDead:animationName];
        return;
    }

    [self addOverlay:overlay];
}

- (void)onDead:(NSString*)dieAnimationName
{
}

- (BOOL)isDead
{
    return self.hitPoints <= 0.0;
}

@end
