//
//  EnemyFactory.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EnemyFactory.h"

#import "Boss.h"
#import "Electrician.h"
#import "FlyingRobot.h"
#import "Janitor.h"
#import "MetaDataController.h"
#import "Robot.h"
#import "Secretary.h"
#import "SneakingRobot.h"

@implementation EnemyFactory

+ (Enemy*)createEnemyWithID:(NSString*)ID
{
    NSDictionary* data = [MetaDataController instance].characterMetaData[ID];
    int coins = [data[@"coins"] intValue];
    float hitPoints = [data[@"hitPoints"] floatValue];
    float speed = [data[@"speed_per_sec"] floatValue];
    
    if ([ID hasPrefix:@"electrician"]) {
        return [[Electrician alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed];
    }
    else if ([ID hasPrefix:@"janitor"]) {
        return [[Janitor alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed];
    }
    else if ([ID hasPrefix:@"boss"]) {
        CGPoint filePosition = ccp([data[@"filePositionX"] floatValue], [data[@"filePositionY"] floatValue]);
        
        return [[Boss alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed filePosition:filePosition];
    }
    else if ([ID hasPrefix:@"robot"]) {
        CGPoint filePosition = ccp([data[@"filePositionX"] floatValue], [data[@"filePositionY"] floatValue]);
        float diamondDropPercentage = [data[@"diamondDropPercentage"] floatValue];
        
        if ([ID isEqualToString:@"robot1"]) {
            return [[SneakingRobot alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed filePosition:filePosition diamondDropPercentage:diamondDropPercentage];
        }
        else if ([ID isEqualToString:@"robot2"]) {
            return [[FlyingRobot alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed filePosition:filePosition diamondDropPercentage:diamondDropPercentage];
        }
        else {
            return [[Robot alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed filePosition:filePosition diamondDropPercentage:diamondDropPercentage];
        }
    }
    else {
        CGPoint filePosition = ccp([data[@"filePositionX"] floatValue], [data[@"filePositionY"] floatValue]);
        
        return [[Secretary alloc] initWithID:ID coins:coins hitPoints:hitPoints speed:speed filePosition:filePosition];
    }
}

@end
