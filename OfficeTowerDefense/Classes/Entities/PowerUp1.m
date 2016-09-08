//
//  PowerUp1.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp1.h"

#import "MetaDataController.h"
#import "PowerUp1DropState.h"

@interface PowerUp1()

@property (nonatomic, copy) NSString* ANIMATION_DROP;

@property (nonatomic) int coins;
@property (nonatomic) float coinInterval_sec;

@end

@implementation PowerUp1

- (instancetype)init
{
    NSString* ID = @"powerUp1";
    
    self = [super initWithID:ID];
    
    self.zOrder = 100;
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.coins = [metaData[@"coins"] intValue];
    self.coinInterval_sec = [metaData[@"coinInterval_sec"] floatValue];

    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_DROP = @"drop";
    
    NSArray* animationNames = @[self.ANIMATION_DROP];
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

- (void)place
{
    [super place];
    
    [self setState:[PowerUp1DropState new]];
}

@end
