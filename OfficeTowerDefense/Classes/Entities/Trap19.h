//
//  Trap19.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap.h"

@interface Trap19 : Trap

@property (nonatomic, copy, readonly) NSString* ANIMATION_FIRE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_RELOAD;

@property (nonatomic, readonly) float damage;
@property (nonatomic, readonly) int gridDistance;
@property (nonatomic, readonly) float projectileSpeed_per_sec;

@end
