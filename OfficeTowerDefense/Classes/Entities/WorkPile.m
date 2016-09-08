//
//  WorkPile.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-05-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WorkPile.h"

#import "WorkPileState.h"

@interface WorkPile()

@property (nonatomic, copy) NSString* ANIMATION_PILE_0;
@property (nonatomic, copy) NSString* ANIMATION_PILE_1;
@property (nonatomic, copy) NSString* ANIMATION_PILE_2;
@property (nonatomic, copy) NSString* ANIMATION_PILE_3;
@property (nonatomic, copy) NSString* ANIMATION_PILE_4;
@property (nonatomic, copy) NSString* ANIMATION_PILE_5;
@property (nonatomic, copy) NSString* ANIMATION_PILE_6;
@property (nonatomic, copy) NSString* ANIMATION_PILE_7;
@property (nonatomic, copy) NSString* ANIMATION_PILE_8;
@property (nonatomic, copy) NSString* ANIMATION_PILE_9;
@property (nonatomic, copy) NSString* ANIMATION_PILE_10;

@property (nonatomic) float totalHitPoints;
@property (nonatomic) float hitPoints;
@property (nonatomic) NSMutableArray* damages;

@end

@implementation WorkPile

- (instancetype)initWithHitPoints:(float)totalHitPoints
{
    self = [super initWithID:@"workPile"];
    
    self.totalHitPoints = totalHitPoints;
    self.hitPoints = 0;
    self.damages = [NSMutableArray new];
    self.playAnimation = NO;
    
    [self setState:[WorkPileState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_PILE_0 = @"pile0";
    self.ANIMATION_PILE_1 = @"pile1";
    self.ANIMATION_PILE_2 = @"pile2";
    self.ANIMATION_PILE_3 = @"pile3";
    self.ANIMATION_PILE_4 = @"pile4";
    self.ANIMATION_PILE_5 = @"pile5";
    self.ANIMATION_PILE_6 = @"pile6";
    self.ANIMATION_PILE_7 = @"pile7";
    self.ANIMATION_PILE_8 = @"pile8";
    self.ANIMATION_PILE_9 = @"pile9";
    self.ANIMATION_PILE_10 = @"pile10";

    NSArray* animationNames = @[self.ANIMATION_PILE_0, self.ANIMATION_PILE_1, self.ANIMATION_PILE_2, self.ANIMATION_PILE_3, self.ANIMATION_PILE_4, self.ANIMATION_PILE_5, self.ANIMATION_PILE_6, self.ANIMATION_PILE_7, self.ANIMATION_PILE_8, self.ANIMATION_PILE_9, self.ANIMATION_PILE_10];
    
    int i = 0;
    
    for (NSString* name in animationNames) {
        int startFrame = i;
        int endFrame = (i == 0) ? 0 : MIN(250, i + 24);
        
        [self createAnimationWithName:name anchorPoint:ccp(0.5, 0) duration:1 loopCount:1 startFrame:startFrame endFrame:endFrame];
        
        i = endFrame + 1;
    }
}

- (void)addDamage:(float)damage
{
    self.hitPoints += damage;
    [self.damages addObject:[NSNumber numberWithFloat:damage]];
    self.playAnimation = YES;
}

- (void)removeDamage:(float)damage
{
    self.hitPoints = MAX(0, self.hitPoints - damage);
    self.playAnimation = YES;
    
    while (damage > 0 && self.damages.count > 0) {
        NSNumber* number = self.damages[self.damages.count - 1];
        float value = [number floatValue];
    
        [self.damages removeLastObject];
        
        if (value <= damage) {
            damage -= value;
        }
        else {
            [self.damages addObject:[NSNumber numberWithFloat:damage]];
            damage = 0;
        }
    }
}

@end
