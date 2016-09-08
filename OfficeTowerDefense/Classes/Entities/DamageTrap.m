//
//  DamageTrap.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DamageTrap.h"

#include "MetaDataController.h"

@interface DamageTrap()

@property (nonatomic) float damage;
@property (nonatomic) NSString* enemyDieAnimationName;
@property (nonatomic) float speedModifier;
@property (nonatomic) float speedModifierDuration_sec;

@end

@implementation DamageTrap

- (instancetype)initWithID:(NSString *)ID
{
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.damage = [metaData[@"damage"] floatValue];
    self.enemyDieAnimationName = metaData[@"enemyDieAnimationName"];
    self.speedModifier = [metaData[@"speedModifier"] floatValue];
    self.speedModifierDuration_sec = [metaData[@"speedModifierDuration_sec"] floatValue];

    return self;
}

@end
