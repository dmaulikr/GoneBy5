//
//  Clock.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@interface Clock : UIEntity

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_BEAT;
@property (nonatomic, copy, readonly) NSString* ANIMATION_FAST_BEAT;

@end
