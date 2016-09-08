//
//  ColdFX.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ColdFX.h"

#import "CCSpriteFrameCache.h"
#import "Enemy.h"

@interface ColdFX()

@property (nonatomic, strong) Enemy *enemy;

@end

@implementation ColdFX

- (id)initWithCharacter:(Enemy *)enemy
{
    self = [self init];
    self.ID = @"fxCold0";
    self.enemy = enemy;
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", self.ID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    
    [self createAnimations];

    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:self.enemy.speedModifierDuration_sec loopCount:1 startFrame:0 endFrame:24];
}

@end
