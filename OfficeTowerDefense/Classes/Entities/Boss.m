//
//  Boss.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Boss.h"
#import "BossDieState.h"
#import "BossPointState.h"
#import "BossSitState.h"
#import "BossWalkState.h"
#import "File.h"
#import "MetaDataController.h"

@interface Boss()

@property (nonatomic, strong) NSString* ANIMATION_LOSE;
@property (nonatomic, strong) NSString* ANIMATION_POINTING;
@property (nonatomic, strong) NSString* ANIMATION_SIT;
@property (nonatomic, strong) NSString* ANIMATION_TRANSFORM;

@end

@implementation Boss

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_LOSE = @"lose";
    self.ANIMATION_POINTING = @"pointing";
    self.ANIMATION_SIT = @"sit";
    self.ANIMATION_TRANSFORM = @"transform";

    NSArray* animationNames = @[self.ANIMATION_LOSE, self.ANIMATION_POINTING, self.ANIMATION_SIT, self.ANIMATION_TRANSFORM];
    NSDictionary* metaData = [MetaDataController instance].characterMetaData[self.ID];
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

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    for (File* file in self.files) {
        file.visible = NO;
    }
    
    [self setState:[BossSitState new]];
}

- (void)scare
{
}

- (void)exitElevator
{
    [self setState:[BossWalkState new]];
}

- (BOOL)isPointing
{
    return [self.currentState isKindOfClass:[BossPointState class]];
}

- (void)showFiles
{
    for (File* file in self.files) {
        file.visible = YES;
    }
}

- (void)onDead:(NSString*)dieAnimationName;
{
    [self setState:[BossDieState new]];
}

@end
