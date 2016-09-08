//
//  PowerUp3.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp3.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "PowerUp3RunState.h"

@interface PowerUp3()

@property (nonatomic, copy) NSString* ANIMATION_RUN;
@property (nonatomic, copy) NSString* ANIMATION_BARK;

@property (nonatomic) float speed_per_sec;
@property (nonatomic) float damage;

@end

@implementation PowerUp3

- (instancetype)init
{
    NSString* ID = @"powerUp3";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.speed_per_sec = [metaData[@"speed_per_sec"] floatValue];
    self.damage = [metaData[@"damage"] floatValue];
    self.attackedEnemies = [NSMutableArray new];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_RUN = @"run";
    self.ANIMATION_BARK = @"bark";
    
    NSArray* animationNames = @[self.ANIMATION_RUN, self.ANIMATION_BARK];
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
    
    [self setState:[PowerUp3RunState new]];
}

@end
