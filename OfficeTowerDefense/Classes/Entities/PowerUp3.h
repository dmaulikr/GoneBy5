//
//  PowerUp3.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp.h"

@interface PowerUp3 : PowerUp

@property (nonatomic, copy, readonly) NSString* ANIMATION_RUN;
@property (nonatomic, copy, readonly) NSString* ANIMATION_BARK;

@property (nonatomic, readonly) float speed_per_sec;
@property (nonatomic, readonly) float damage;

@property (nonatomic) NSMutableArray* attackedEnemies;

@end
