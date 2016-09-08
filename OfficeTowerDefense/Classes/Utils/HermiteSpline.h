//
//  HermiteSpline.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HermiteSpline : NSObject

- (instancetype)initWithPoint0:(CGPoint)point0 point1:(CGPoint)point1 tangent0:(CGPoint)tangent0 tangent1:(CGPoint)tangent1;

- (CGPoint)interpolate:(float)t;
- (float)getParameter:(float)length;

@property (nonatomic, readonly) float length;

@end
