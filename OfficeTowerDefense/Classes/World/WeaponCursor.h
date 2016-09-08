//
//  WeaponCursor.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ButtonControl.h"

@class GameWorld;

@interface WeaponCursor : NSObject <ButtonControlDelegate>

- (instancetype)initWithWeaponID:(NSString*)weaponID gameWorld:(GameWorld*)gameWorld;

@end
