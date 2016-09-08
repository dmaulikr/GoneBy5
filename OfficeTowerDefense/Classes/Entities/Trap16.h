//
//  Trap16.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DamageTrap.h"

@interface Trap16 : DamageTrap

@property (nonatomic, copy, readonly) NSString* ANIMATION_COUNT_DOWN;
@property (nonatomic, copy, readonly) NSString* ANIMATION_EXPLODE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_DISAPPEAR;

@end
