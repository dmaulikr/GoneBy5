//
//  Character.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-15.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEntity.h"

#import "OverlayFX.h"

@class Animation;

@interface Character : GameEntity

- (instancetype)initWithID:(NSString*)ID hitPoints:(float)hitPoints;
- (void)addHitPoints:(float)hitPoints;
- (void)addOverlay:(OverlayType)overlayType;
- (void)removeOverlay:(OverlayType)overlayType;
- (void)takeDamage:(float)damage overlay:(OverlayType)overlay dieAnimationName:(NSString*)animationName;
- (void)onDead:(NSString*)dieAnimationName;

@property (nonatomic, copy, readonly) NSString* ANIMATION_DIE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) float hitPoints;
@property (nonatomic, readonly) BOOL isIdle;
@property (nonatomic, readonly) BOOL isDead;

@end
