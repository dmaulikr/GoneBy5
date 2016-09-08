//
//  Projectile0
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Projectile0.h"

#import "CCSprite.h"
#import "Projectile0State.h"

@interface Projectile0()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;

@property (nonatomic) float damage;
@property (nonatomic) float speed_per_sec;
@property (nonatomic) CGPoint startingGrid;
@property (nonatomic) int gridDistance;

@end

@implementation Projectile0

- (instancetype)initWithDamage:(float)damage speed:(float)speed_per_sec startingGrid:(CGPoint)startingGrid gridDistance:(int)gridDistance
{
    self = [super initWithID:@"projectile0"];
    
    self.damage = damage;
    self.speed_per_sec = speed_per_sec;
    self.startingGrid = startingGrid;
    self.gridDistance = gridDistance;
    
    self.sprite.anchorPoint = ccp(0, 0.5);
    
    [self setState:[Projectile0State new]];
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_IDLE = @"idle";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(1, 0.5) duration:1 loopCount:0 startFrame:0 endFrame:0];
}

@end
