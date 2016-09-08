//
//  HermiteSpline.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "HermiteSpline.h"

#import "SplineTableEntry.h"
#import "cocos2d.h"

@interface HermiteSpline()

@property (nonatomic) CGPoint point0;
@property (nonatomic) CGPoint point1;
@property (nonatomic) CGPoint tangent0;
@property (nonatomic) CGPoint tangent1;

@property (nonatomic) float subDivisionInterval;
@property (nonatomic) NSMutableArray* lookUpTable;

@end

@implementation HermiteSpline

- (instancetype)initWithPoint0:(CGPoint)point0 point1:(CGPoint)point1 tangent0:(CGPoint)tangent0 tangent1:(CGPoint)tangent1
{
    self = [self init];
    
    self.point0 = point0;
    self.point1 = point1;
    self.tangent0 = tangent0;
    self.tangent1 = tangent1;
    
    self.subDivisionInterval = 0.025;
    self.lookUpTable = [NSMutableArray new];
    
    [self calculateLength];
        
    return self;
}

- (void)calculateLength
{
    SplineTableEntry* entry = [[SplineTableEntry alloc] initWithParameter:0 length:0];
    [self.lookUpTable addObject:entry];
    
    float tempLength = 0;
    CGPoint previousPoint = self.point0;
    
    for (float t = self.subDivisionInterval; t < 1.0; t += self.subDivisionInterval) {
        CGPoint currentPoint = [self interpolate:t];
    
        tempLength += ccpDistance(previousPoint, currentPoint);
        entry = [[SplineTableEntry alloc] initWithParameter:t length:tempLength];
        [self.lookUpTable addObject:entry];
        
        previousPoint = currentPoint;
    }
    
    tempLength += ccpDistance(previousPoint, self.point1);
    entry = [[SplineTableEntry alloc] initWithParameter:1.0 length:tempLength];
    [self.lookUpTable addObject:entry];
}

- (CGPoint)interpolate:(float)t
{
    const float tSquared = t * t;
    const float tCubed = tSquared * t;

    const float A = 2 * tCubed - 3 * tSquared + 1;
    const float B = -2 * tCubed + 3 * tSquared;
    const float C = tCubed - 2 * tSquared + t;
    const float D = tCubed - tSquared;
    
    float x = A * self.point0.x + B * self.point1.x + C * self.tangent0.x + D * self.tangent1.x;
    float y = A * self.point0.y + B * self.point1.y + C * self.tangent0.y + D * self.tangent1.y;

    return CGPointMake(x, y);
}

- (float)getArcLength:(float)t
{
    int i = t / self.subDivisionInterval;
    SplineTableEntry* lowerBound = self.lookUpTable[i];
    
    if (i + 1 < self.lookUpTable.count) {
        SplineTableEntry* upperBound = self.lookUpTable[i + 1];
        float normalized = (t - lowerBound.t) / (upperBound.t - lowerBound.t);
    
        return lowerBound.length + normalized * (upperBound.length - lowerBound.length);
    }
    
    return lowerBound.length;
}

- (float)getParameter:(float)length;
{
    length = fminf(length, self.length);
    
    int low = 0;
    int high = (int)self.lookUpTable.count - 1;
    
    while (low < high) {
        int mid = (low + high) / 2;
        
        SplineTableEntry* entry = self.lookUpTable[mid];
        
        if (entry.length < length) {
            low = mid + 1;
        }
        else {
            high = mid;
        }
    }
    
    SplineTableEntry* lowerBound = self.lookUpTable[low];
    
    if (low + 1 < self.lookUpTable.count) {
        SplineTableEntry* upperBound = self.lookUpTable[low + 1];
        float normalized = (length - lowerBound.length) / (upperBound.length - lowerBound.length);
    
        return lowerBound.t + normalized * (upperBound.t - lowerBound.t);
    }
    
    return lowerBound.t;
}

- (float)length
{
    SplineTableEntry* entry = (self.lookUpTable.count > 0) ? self.lookUpTable[self.lookUpTable.count - 1] : nil;

    return (entry) ? entry.length : 0;
}

@end
