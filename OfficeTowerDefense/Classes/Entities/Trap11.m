//
//  Trap11.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap11.h"

#import "MetaDataController.h"
#import "Trap11DetectEnemyState.h"

@interface Trap11()

@property (nonatomic, copy) NSString* ANIMATION_EXIT_HIVE;
@property (nonatomic, copy) NSString* ANIMATION_SWARM;
@property (nonatomic, copy) NSString* ANIMATION_ENTER_HIVE;

@end

@implementation Trap11

- (instancetype)init
{
    self = [self initWithID:@"trap11"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_EXIT_HIVE = @"exitHive";
    self.ANIMATION_SWARM = @"swarm";
    self.ANIMATION_ENTER_HIVE = @"enterHive";
    
    NSArray* animationNames = @[self.ANIMATION_EXIT_HIVE, self.ANIMATION_SWARM, self.ANIMATION_ENTER_HIVE];
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
    
    [self setState:[Trap11DetectEnemyState new]];
}

@end
