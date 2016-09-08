//
//  Trap12.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap12.h"

#import "MetaDataController.h"
#import "Trap12DetectEnemyState.h"

@interface Trap12()

@property (nonatomic) float damage;
@property (nonatomic) NSString* enemyDieAnimationName;
@property (nonatomic) float speedModifier;

@end

@implementation Trap12

- (instancetype)init
{
    NSString* ID = @"trap12";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.damage = [metaData[@"damage"] floatValue];
    self.enemyDieAnimationName = metaData[@"enemyDieAnimationName"];
    self.speedModifier = [metaData[@"speedModifier"] floatValue];
    
    return self;
}

- (void)place
{
    [super place];
    
    [self setState:[Trap12DetectEnemyState new]];
}

@end
