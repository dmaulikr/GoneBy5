//
//  WeaponFactory.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weapon;

@interface WeaponFactory : NSObject

+ (Weapon*)getWeaponWithID:(NSString*)ID;

@end
