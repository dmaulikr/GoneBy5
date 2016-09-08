//
//  PowerUp1.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp.h"

@interface PowerUp1 : PowerUp

@property (nonatomic, copy, readonly) NSString* ANIMATION_DROP;

@property (nonatomic, readonly) int coins;
@property (nonatomic, readonly) float coinInterval_sec;

@end
