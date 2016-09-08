//
//  PowerUp0.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp0.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "PowerUp0DropState.h"

@interface PowerUp0()

@property (nonatomic, copy) NSString* ANIMATION_DROP;
@property (nonatomic, copy) NSString* ANIMATION_SHRED;

@end

@implementation PowerUp0

- (instancetype)init
{
    self = [super initWithID:@"powerUp0"];
    
    self.zOrder = 100;
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_DROP = @"drop";
    self.ANIMATION_SHRED = @"shred";
    
    NSArray* animationNames = @[self.ANIMATION_DROP, self.ANIMATION_SHRED];
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
    if (floor(self.grid.x) == 9 && floor(self.grid.y) == 0) {
        NSArray* weapons = [self.gameWorld getWeaponsAtGrid:self.grid];
    
        return (weapons.count == 0);
    }
    
    return NO;
}

- (void)place
{
    [super place];
    
    self.position = [self.gameWorld getFloorPositionFromGrid:ccp(9.3, 0)];
    [self setState:[PowerUp0DropState new]];
}

@end
