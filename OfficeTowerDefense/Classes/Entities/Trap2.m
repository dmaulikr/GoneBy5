//
//  Trap2.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap2.h"

#import "MetaDataController.h"
#import "Trap2DetectEnemyState.h"

@interface Trap2()

@property (nonatomic, copy) NSString* ANIMATION_BLOW;
@property (nonatomic, copy) NSString* ANIMATION_RELOAD;

@end

@implementation Trap2

- (instancetype)init
{
    self = [super initWithID:@"trap2"];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_BLOW = @"blow";
    self.ANIMATION_RELOAD = @"reload";
    
    NSArray* animationNames = @[self.ANIMATION_BLOW, self.ANIMATION_RELOAD];
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
    
    [self setState:[Trap2DetectEnemyState new]];
}

@end
