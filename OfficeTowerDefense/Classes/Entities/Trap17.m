//
//  Trap17.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap17.h"

#import "MetaDataController.h"
#import "Trap17DetectEnemyState.h"

@interface Trap17()

@property (nonatomic, copy) NSString* ANIMATION_FIRE;
@property (nonatomic, copy) NSString* ANIMATION_RELOAD;

@property (nonatomic) float damage;
@property (nonatomic) int gridDistance;
@property (nonatomic) float projectileSpeed_per_sec;

@end

@implementation Trap17

- (instancetype)init
{
    NSString* ID = @"trap17";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.damage = [metaData[@"damage"] floatValue];
    self.gridDistance = [metaData[@"gridDistance"] intValue];
    self.projectileSpeed_per_sec = [metaData[@"projectileSpeed_per_sec"] floatValue];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_FIRE = @"fire";
    self.ANIMATION_RELOAD = @"reload";
    
    NSArray* animationNames = @[self.ANIMATION_FIRE, self.ANIMATION_RELOAD];
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

- (void)snapToGrid:(float)scale
{
    [super snapToGrid:scale];
    
    self.scaleX = (floor(self.grid.y) == 1) ? -scale : scale;
}


- (void)place
{
    [super place];
    
    [self setState:[Trap17DetectEnemyState new]];
}

@end
