//
//  Trap18.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap.h"

@interface Trap18 : Trap

@property (nonatomic, copy, readonly) NSString* ANIMATION_FIRE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_RELOAD;

@property (nonatomic, readonly) float damage;
@property (nonatomic, readonly) int gridDistance;
@property (nonatomic, readonly) float projectileSpeed_per_sec;
@property (nonatomic, readonly) int numberOfShots;

@end
