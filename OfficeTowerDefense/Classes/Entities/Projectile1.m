//
//  Projectile1.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Projectile1.h"

#import "Projectile1LaunchState.h"

@interface Projectile1()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;
@property (nonatomic, copy) NSString* ANIMATION_EXPLODE;

@property (nonatomic) float damage;
@property (nonatomic) float speed_per_sec;
@property (nonatomic) int gridDistance;
@property (nonatomic, copy) NSString* sound;

@end

@implementation Projectile1

- (instancetype)initWithDamage:(float)damage speed:(float)speed_per_sec gridDistance:(int)gridDistance sound:(NSString*)sound
{
    self = [super initWithID:@"projectile1"];
    
    self.damage = damage;
    self.speed_per_sec = speed_per_sec;
    self.gridDistance = gridDistance;
    self.sound = sound;

    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_IDLE = @"idle";
    self.ANIMATION_EXPLODE = @"explode";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:0 endFrame:0];
    [self createAnimationWithName:self.ANIMATION_EXPLODE anchorPoint:ccp(0.5, 0) duration:0.25 loopCount:1 startFrame:1 endFrame:8];
}

- (void)onEnter
{
    [super onEnter];
    
    [self setState:[Projectile1LaunchState new]];
}

@end
