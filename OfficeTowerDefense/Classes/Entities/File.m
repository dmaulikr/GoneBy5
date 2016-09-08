//
//  File.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "File.h"

#import "Animation.h"
#import "FileIdleState.h"
#import "FilesFall.h"
#import "GameWorld.h"

@interface File()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) float maxHitPoints;
@property (nonatomic) float hitPoints;

@end

@implementation File

- (instancetype)initWithID:(NSString*)ID hitPoints:(float)hitPoints
{
    self = [super initWithID:ID];
    
    self.maxHitPoints = hitPoints;
    self.hitPoints = hitPoints;
    
    [self setState:[FileIdleState new]];

    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:0 startFrame:0 endFrame:1];
}

- (float)takeDamage:(float)damage
{
    float excessDamage = damage - self.hitPoints;
    
    self.hitPoints -= fminf(damage, self.hitPoints);
        
    return excessDamage;
}

@end
