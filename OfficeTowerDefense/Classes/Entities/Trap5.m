//
//  Trap5.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap5.h"

#import "MetaDataController.h"
#import "Trap5DetectEnemyState.h"

@interface Trap5()

@property (nonatomic, copy) NSString* ANIMATION_DROP;
@property (nonatomic, copy) NSString* ANIMATION_RELOAD;

@end

@implementation Trap5

- (instancetype)init
{
    self = [super initWithID:@"trap5"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_DROP = @"drop";
    self.ANIMATION_RELOAD = @"reload";
    
    NSArray* animationNames = @[self.ANIMATION_DROP, self.ANIMATION_RELOAD];
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
    
   [self setState:[Trap5DetectEnemyState new]];
}

@end
