//
//  SplineTableEntry.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SplineTableEntry.h"

@implementation SplineTableEntry

- (instancetype)initWithParameter:(float)t length:(float)length
{
    self = [self init];
    
    self.t = t;
    self.length = length;
    
    return self;
}

@end
