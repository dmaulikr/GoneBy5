//
//  ClockUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@interface ClockUI : UIEntity

- (void)setElapsedTime:(CCTime)elapsedTime_sec;

@property (nonatomic, copy, readonly) NSString* ANIMATION;

@end
