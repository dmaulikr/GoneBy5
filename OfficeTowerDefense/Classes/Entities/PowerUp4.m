//
//  PowerUp4.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-20.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp4.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "PowerUp4ChargeState.h"

@interface PowerUp4()

@property (nonatomic, copy) NSString* ANIMATION_CHARGE;

@property (nonatomic) float speed_per_sec;

@end

@implementation PowerUp4

- (instancetype)init
{
    NSString* ID = @"powerUp4";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.speed_per_sec = [metaData[@"speed_per_sec"] floatValue];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_CHARGE = @"charge";
    
    NSArray* animationNames = @[self.ANIMATION_CHARGE];
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
    if (self.grid.x < 1 || self.grid.x >= 9) {
        return;
    }
    
    int row = floor(self.grid.y);
    int column;
    
    if (row == 1) {
        column = 1;
        self.scaleX = -scale;
    }
    else {
        column = 8;
        self.scaleX = scale;
    }
    
    self.position = [self.gameWorld getFloorPositionFromGrid:ccp(column + 0.5, self.grid.y)];
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
    
    [self setState:[PowerUp4ChargeState new]];
}

@end
