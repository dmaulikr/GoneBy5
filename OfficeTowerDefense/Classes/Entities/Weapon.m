//
//  Weapon.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-09.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Weapon.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "WeaponIdleState.h"

@interface Weapon()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) BOOL isPlaced;
@property (nonatomic) int cost;
@property (nonatomic, copy) NSString* sound;

@end

@implementation Weapon

- (instancetype)initWithID:(NSString*)ID
{
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.placement = [metaData[@"placement"] intValue];
    self.cost = [metaData[@"cost"] intValue];
    self.sound = metaData[@"sound"];
    self.isPlaced = NO;
    
    switch (self.placement) {
        case PLACEMENT_BOTTOM:
            self.zOrder = 2000;
            break;
            
        case PLACEMENT_TOP:
            self.zOrder = 1000;
            break;
            
        case PLACEMENT_NONE:
            self.zOrder = 3000;
            break;
    }

    [self setState:[WeaponIdleState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    int startFrame = [animations[self.ANIMATION_IDLE][@"startFrame"] intValue];
    int endFrame = [animations[self.ANIMATION_IDLE][@"endFrame"] intValue];
    float duration = [animations[self.ANIMATION_IDLE][@"duration_sec"] floatValue];
    int loopCount = [animations[self.ANIMATION_IDLE][@"loop"] intValue];
    CGPoint anchor = ccp([animations[self.ANIMATION_IDLE][@"anchorX"] floatValue], [animations[self.ANIMATION_IDLE][@"anchorY"] floatValue]);
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];    
}

- (void)snapToGrid:(float)scale
{
    int column = floor(self.grid.x);
    
    if (self.placement == PLACEMENT_TOP) {
        self.position = [self.gameWorld getCeilingPositionFromGrid:ccp(column + 0.5, self.grid.y)];
    }
    else if (self.placement == PLACEMENT_BOTTOM) {
        self.position = [self.gameWorld getFloorPositionFromGrid:ccp(column + 0.5, self.grid.y)];
    }
    
    self.scale = scale;
}

- (BOOL)canBePlaced
{
    if (self.grid.x < 1 || self.grid.x >= 9 || self.grid.y < 0 || self.grid.y > 3) {
        return NO;
    }
    
    NSArray* weapons = [self.gameWorld getWeaponsAtGrid:self.grid];
    
    for (Weapon* weapon in weapons) {
        if (weapon.placement == self.placement) {
            return NO;
        }
    }
    
    return YES;
}

- (void)place
{
    self.isPlaced = YES;
    self.scaleX = (self.scaleX > 0) ? 1.0 : -1.0;
    self.scaleY = 1.0;
}

@end
