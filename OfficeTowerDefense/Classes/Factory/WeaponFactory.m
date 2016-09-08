//
//  WeaponFactory.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WeaponFactory.h"

#import "MetaDataController.h"
#import "PowerUp.h"
#import "PowerUp0.h"
#import "PowerUp1.h"
#import "PowerUp2.h"
#import "PowerUp3.h"
#import "PowerUp4.h"
#import "PowerUp5.h"
#import "Trap0.h"
#import "Trap1.h"
#import "Trap2.h"
#import "Trap3.h"
#import "Trap4.h"
#import "Trap5.h"
#import "Trap6.h"
#import "Trap7.h"
#import "Trap8.h"
#import "Trap9.h"
#import "Trap10.h"
#import "Trap11.h"
#import "Trap12.h"
#import "Trap13.h"
#import "Trap14.h"
#import "Trap15.h"
#import "Trap16.h"
#import "Trap17.h"
#import "Trap18.h"
#import "Trap19.h"
#import "Weapon.h"

@implementation WeaponFactory

+ (Weapon*)getWeaponWithID:(NSString*)ID
{
    if ([ID hasPrefix:@"trap"]) {
        return [WeaponFactory getTrapWithID:ID];
    }
    else if ([ID hasPrefix:@"powerUp"]) {
        return [WeaponFactory getPowerUpWithID:ID];
    }
    
    return nil;
}

+ (Trap*)getTrapWithID:(NSString*)ID
{
    if ([ID isEqualToString:@"trap0"]) {
        return [Trap0 new];
    }
    else if ([ID isEqualToString:@"trap1"]) {
        return [Trap1 new];
    }
    else if ([ID isEqualToString:@"trap2"]) {
        return [Trap2 new];
    }
    else if ([ID isEqualToString:@"trap3"]) {
        return [Trap3 new];
    }
    else if ([ID isEqualToString:@"trap4"]) {
        return [Trap4 new];
    }
    else if ([ID isEqualToString:@"trap5"]) {
        return [Trap5 new];
    }
    else if ([ID isEqualToString:@"trap6"]) {
        return [Trap6 new];
    }
    else if ([ID isEqualToString:@"trap7"]) {
        return [Trap7 new];
    }
    else if ([ID isEqualToString:@"trap8"]) {
        return [Trap8 new];
    }
    else if ([ID isEqualToString:@"trap9"]) {
        return [Trap9 new];
    }
    else if ([ID isEqualToString:@"trap10"]) {
        return [Trap10 new];
    }
    else if ([ID isEqualToString:@"trap11"]) {
        return [Trap11 new];
    }
    else if ([ID isEqualToString:@"trap12"]) {
        return [Trap12 new];
    }
    else if ([ID isEqualToString:@"trap13"]) {
        return [Trap13 new];
    }
    else if ([ID isEqualToString:@"trap14"]) {
        return [Trap14 new];
    }
    else if ([ID isEqualToString:@"trap15"]) {
        return [Trap15 new];
    }
    else if ([ID isEqualToString:@"trap16"]) {
        return [Trap16 new];
    }
    else if ([ID isEqualToString:@"trap17"]) {
        return [Trap17 new];
    }
    else if ([ID isEqualToString:@"trap18"]) {
        return [Trap18 new];
    }
    else if ([ID isEqualToString:@"trap19"]) {
        return [Trap19 new];
    }
    
    return nil;
}

+ (PowerUp*)getPowerUpWithID:(NSString*)ID
{
    if ([ID isEqualToString:@"powerUp0"]) {
        return [PowerUp0 new];
    }
    else if ([ID isEqualToString:@"powerUp1"]) {
        return [PowerUp1 new];
    }
    else if ([ID isEqualToString:@"powerUp2"]) {
        return [PowerUp2 new];
    }
    else if ([ID isEqualToString:@"powerUp3"]) {
        return [PowerUp3 new];
    }
    else if ([ID isEqualToString:@"powerUp4"]) {
        return [PowerUp4 new];
    }
    else if ([ID isEqualToString:@"powerUp5"]) {
        return [PowerUp5 new];
    }
    
    return nil;
}

@end
