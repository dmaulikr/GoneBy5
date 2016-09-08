//
//  Trap13.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap13.h"

#import "MetaDataController.h"
#import "Trap13DetectEnemyState.h"

@interface Trap13()

@property (nonatomic, copy) NSString* ANIMATION_SHOCK;
@property (nonatomic, copy) NSString* ANIMATION_RELOAD;

@end

@implementation Trap13

- (instancetype)init
{
    self = [super initWithID:@"trap13"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_SHOCK = @"shock";
    self.ANIMATION_RELOAD = @"reload";
    
    NSArray* animationNames = @[self.ANIMATION_SHOCK, self.ANIMATION_RELOAD];
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
    
    [self setState:[Trap13DetectEnemyState new]];
}

@end
