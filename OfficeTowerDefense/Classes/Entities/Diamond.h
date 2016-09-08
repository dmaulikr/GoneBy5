//
//  Diamond.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-29.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface Diamond : GameEntity

- (instancetype)initWithAmount:(int)amount position:(CGPoint)position;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) CGPoint idlePosition;
@property (nonatomic, readonly) int amount;

@end
