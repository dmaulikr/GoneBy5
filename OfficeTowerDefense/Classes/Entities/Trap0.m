//
//  Trap0.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap0.h"

#import "MetaDataController.h"
#import "Trap0DetectEnemyState.h"

@interface Trap0()

@property (nonatomic, copy) NSString* ANIMATION_COUNT_DOWN;
@property (nonatomic, copy) NSString* ANIMATION_EXPLODE;
@property (nonatomic, copy) NSString* ANIMATION_DISAPPEAR;

@end

@implementation Trap0

- (instancetype)init
{
    self = [super initWithID:@"trap0"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_COUNT_DOWN = @"countDown";
    self.ANIMATION_EXPLODE = @"explode";
    self.ANIMATION_DISAPPEAR = @"disappear";
    
    NSArray* animationNames = @[self.ANIMATION_COUNT_DOWN, self.ANIMATION_EXPLODE, self.ANIMATION_DISAPPEAR];
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
    
    [self setState:[Trap0DetectEnemyState new]];
}

@end
