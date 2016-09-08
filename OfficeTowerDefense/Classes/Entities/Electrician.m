//
//  Electrician.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-24.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Electrician.h"

#import "ElectricianScaredState.h"
#import "ElectricianWalkState.h"
#import "EnemyEnterElevatorState.h"
#import "MetaDataController.h"

@interface Electrician()

@property (nonatomic, copy) NSString* ANIMATION_POST_ATTACK;
@property (nonatomic, copy) NSString* ANIMATION_PRE_ATTACK;

@end

@implementation Electrician

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[ElectricianWalkState new]];
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_POST_ATTACK = @"postAttack";
    self.ANIMATION_PRE_ATTACK = @"preAttack";
    
    NSArray* animationNames = @[self.ANIMATION_POST_ATTACK, self.ANIMATION_PRE_ATTACK];
    NSDictionary* metaData = [MetaDataController instance].characterMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    for (int i = 0; i < animationNames.count; i++) {
        NSString* name = animationNames[i];
        int startFrame = [animations[name][@"startFrame"] intValue];
        int endFrame = [animations[name][@"endFrame"] intValue];
        float duration = [animations[name][@"duration_sec"] floatValue];
        int loopCount = [animations[name][@"loop"] intValue];
        CGPoint anchor = ccp([animations[name][@"anchorX"] floatValue], [animations[name][@"anchorY"] floatValue]);
        
        [self createAnimationWithName:name anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];
    }
}

- (void)scare
{
    if ([self.currentState isKindOfClass:[ElectricianScaredState class]] || [self.currentState isKindOfClass:[EnemyEnterElevatorState class]]) {
        return;
    }
    
    [self setState:[ElectricianScaredState new]];
}

- (void)exitElevator
{
    [self setState:[ElectricianWalkState new]];
}

- (BOOL)isWalking
{
    return [self.currentState isKindOfClass:[ElectricianWalkState class]];
}

@end
