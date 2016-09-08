//
//  PowerUp5.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-20.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "PowerUp5StartUpState.h"

@interface PowerUp5()

@property (nonatomic, copy) NSString* ANIMATION_START_UP;
@property (nonatomic, copy) NSString* ANIMATION_DETECT_ENEMY;
@property (nonatomic, copy) NSString* ANIMATION_EXPLODE;

@end

@implementation PowerUp5

- (instancetype)init
{
    self = [super initWithID:@"powerUp5"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_START_UP = @"startUp";
    self.ANIMATION_DETECT_ENEMY = @"detectEnemy";
    self.ANIMATION_EXPLODE = @"explode";
    
    NSArray* animationNames = @[self.ANIMATION_START_UP, self.ANIMATION_DETECT_ENEMY, self.ANIMATION_EXPLODE];
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
    
    self.scaleX = (floor(self.grid.y) == 1) ? -scale : scale;

    int column = floor(self.grid.x);
    
    self.position = [self.gameWorld getFloorPositionFromGrid:ccp(column + 0.5, self.grid.y)];
}

- (void)place
{
    [super place];
    
    [self setState:[PowerUp5StartUpState new]];
}

@end
