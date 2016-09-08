//
//  Trap7.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap7.h"

#import "MetaDataController.h"
#import "Trap7DetectEnemyState.h"

@interface Trap7()

@property (nonatomic) float speedModifier;
@property (nonatomic) int maxEnemies;

@end

@implementation Trap7

- (instancetype)init
{
    NSString* ID = @"trap7";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.speedModifier = [metaData[@"speedModifier"] floatValue];
    self.maxEnemies = [metaData[@"maxEnemies"] intValue];
    
    return self;
}

- (void)place
{
    [super place];
    
    [self setState:[Trap7DetectEnemyState new]];
}

@end
