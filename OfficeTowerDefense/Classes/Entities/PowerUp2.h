//
//  PowerUp2.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp.h"

@interface PowerUp2 : PowerUp

@property (nonatomic, copy, readonly) NSString* ANIMATION_DISAPPEAR;
@property (nonatomic, copy, readonly) NSString* ANIMATION_SCARE;

@property (nonatomic, readonly) float speed_per_sec;
@property (nonatomic, readonly) float scareTime_sec;

@end
