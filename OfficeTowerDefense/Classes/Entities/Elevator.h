//
//  Elevator.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-15.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEntity.h"

@class Animation;
@class Character;

@interface Elevator : GameEntity

- (instancetype)initWithID:(NSString*)ID capacity:(int)capacity delay:(float)delay_sec speed:(float)speed_per_sec;

- (Animation*)getAnimationWithName:(NSString*)name;
- (void)addOccupant:(Character*)occupant;

@property (nonatomic, copy, readonly) NSString* ANIMATION_BASE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_CABLE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_DOWN;
@property (nonatomic, copy, readonly) NSString* ANIMATION_STOPPED;
@property (nonatomic, copy, readonly) NSString* ANIMATION_UP;
@property (nonatomic, copy, readonly) NSString* ANIMATION_WHEEL;

@property (nonatomic, readonly) float delay_sec;
@property (nonatomic, readonly) float speed_per_sec;
@property (nonatomic, readonly) BOOL isEmpty;
@property (nonatomic, readonly) BOOL isFull;
@property (nonatomic, readonly) BOOL isWaiting;
@property (nonatomic, strong) NSMutableArray* occupants;

@property (nonatomic, strong) CCSprite* cableSprite;
@property (nonatomic, strong) CCSprite* wheelSprite;
@property (nonatomic, strong) CCSprite* elevatorSprite;

@property (nonatomic, readonly) CGPoint initialCablePosition;
@property (nonatomic, readonly) CGSize initialCableSize;
@property (nonatomic, readonly) CGPoint initialWheelPosition;


@end
