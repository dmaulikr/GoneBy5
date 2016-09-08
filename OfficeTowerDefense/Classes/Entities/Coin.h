//
//  Coin.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface Coin : GameEntity

- (instancetype)initWithAmount:(int)amount position:(CGPoint)position;

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;

@property (nonatomic, readonly) CGPoint idlePosition;
@property (nonatomic, readonly) int amount;

@end
