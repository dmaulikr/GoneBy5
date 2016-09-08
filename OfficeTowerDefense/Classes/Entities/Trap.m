//
//  Trap.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Trap.h"

#import "GameWorld.h"
#import "MetaDataController.h"

@interface Trap()

@property (nonatomic, copy) NSString* ANIMATION_DETECT_ENEMY;

@property (nonatomic) float purchaseInterval_sec;
@property (nonatomic) OverlayType overlayFX;

@end

@implementation Trap

- (instancetype)initWithID:(NSString*)ID
{
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.purchaseInterval_sec = [metaData[@"purchaseInterval_sec"] floatValue];
    self.overlayFX = [metaData[@"overlayFX"] intValue];
    self.isBeingRemoved = NO;
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_DETECT_ENEMY = @"detectEnemy";
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    int startFrame = [animations[self.ANIMATION_DETECT_ENEMY][@"startFrame"] intValue];
    int endFrame = [animations[self.ANIMATION_DETECT_ENEMY][@"endFrame"] intValue];
    float duration = [animations[self.ANIMATION_DETECT_ENEMY][@"duration_sec"] floatValue];
    int loopCount = [animations[self.ANIMATION_DETECT_ENEMY][@"loop"] intValue];
    CGPoint anchor = ccp([animations[self.ANIMATION_DETECT_ENEMY][@"anchorX"] floatValue], [animations[self.ANIMATION_DETECT_ENEMY][@"anchorY"] floatValue]);
    
    [self createAnimationWithName:self.ANIMATION_DETECT_ENEMY anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];
}

@end
