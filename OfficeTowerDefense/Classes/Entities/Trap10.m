//
//  Trap10.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap10.h"

#import "MetaDataController.h"
#import "Trap10DetectEnemyState.h"

@interface Trap10()

@property (nonatomic, copy) NSString* ANIMATION_MOVE_DOWN;
@property (nonatomic, copy) NSString* ANIMATION_MOVE_UP;
@property (nonatomic, copy) NSString* ANIMATION_EAT;

@end

@implementation Trap10

- (instancetype)init
{
    self = [self initWithID:@"trap10"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_MOVE_DOWN = @"moveDown";
    self.ANIMATION_MOVE_UP = @"moveUp";
    self.ANIMATION_EAT = @"eat";
    
    NSArray* animationNames = @[self.ANIMATION_MOVE_DOWN, self.ANIMATION_MOVE_UP, self.ANIMATION_EAT];
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
    
    [self setState:[Trap10DetectEnemyState new]];
}


@end
