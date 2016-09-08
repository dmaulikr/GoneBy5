//
//  Robot.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Secretary.h"

@interface Robot : Secretary

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec filePosition:(CGPoint)filePosition diamondDropPercentage:(float)diamondDropPercentage;

@end
