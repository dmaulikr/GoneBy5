//
//  PowerUp2.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp2.h"

#import "MetaDataController.h"
#import "PowerUp2ScareState.h"
#import "Weapon.h"

@interface PowerUp2()

@property (nonatomic, copy) NSString* ANIMATION_DISAPPEAR;
@property (nonatomic, copy) NSString* ANIMATION_SCARE;

@property (nonatomic) float speed_per_sec;
@property (nonatomic) float scareTime_sec;

@end

@implementation PowerUp2

- (instancetype)init
{
    NSString* ID = @"powerUp2";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.anchorPoint = ccp(0.5, 0.5);
    self.speed_per_sec = [metaData[@"speed_per_sec"] floatValue];
    self.scareTime_sec = [metaData[@"scareTime_sec"] floatValue];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_DISAPPEAR = @"disappear";
    self.ANIMATION_SCARE = @"scare";
    
    NSArray* animationNames = @[self.ANIMATION_DISAPPEAR, self.ANIMATION_SCARE];
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[self.ID];
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

- (BOOL)canBePlaced
{
    if (self.grid.x < 1 || self.grid.x >= 9 || self.grid.y < 0 || self.grid.y > 3) {
        return NO;
    }
    
    return YES;
}

- (void)place
{
    [super place];
    
    [self setState:[PowerUp2ScareState new]];
}

@end
