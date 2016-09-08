//
//  EnemyFactory.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Enemy;

@interface EnemyFactory : NSObject

+ (Enemy*)createEnemyWithID:(NSString*)ID;

@end
