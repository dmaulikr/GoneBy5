//
//  Trap15.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap15.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "Trap15DetectEnemyState.h"

@interface Trap15()

@property (nonatomic) float speedModifier;
@property (nonatomic) int gridDistance;

@end

@implementation Trap15

- (instancetype)init
{
    NSString* ID = @"trap15";
    
    self = [super initWithID:ID];
    
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
    
    self.speedModifier = [metaData[@"speedModifier"] floatValue];
    self.gridDistance = [metaData[@"gridDistance"] intValue];
    
    return self;
}

- (void)snapToGrid:(float)scale
{
    [super snapToGrid:scale];
    
    self.scaleX = (floor(self.grid.y) == 1) ? -scale : scale;
}

- (void)place
{
    [super place];
    
    [self setState:[Trap15DetectEnemyState new]];
}

@end
