//
//  SplineTableEntry.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplineTableEntry : NSObject

- (instancetype)initWithParameter:(float)t length:(float)length;

@property (nonatomic) float t;
@property (nonatomic) float length;

@end
