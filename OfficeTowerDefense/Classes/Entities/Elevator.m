//
//  Elevator.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-15.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Elevator.h"

#import "Animation.h"
#import "CCSprite.h"
#import "CCSpriteFrameCache.h"
#import "ElevatorWaitState.h"
#import "State.h"

@interface Elevator()

@property (nonatomic, copy) NSString* ANIMATION_BASE;
@property (nonatomic, copy) NSString* ANIMATION_CABLE;
@property (nonatomic, copy) NSString* ANIMATION_DOWN;
@property (nonatomic, copy) NSString* ANIMATION_STOPPED;
@property (nonatomic, copy) NSString* ANIMATION_UP;
@property (nonatomic, copy) NSString* ANIMATION_WHEEL;

@property (nonatomic) int capacity;
@property (nonatomic) float delay_sec;
@property (nonatomic) float speed_per_sec;

@property (nonatomic) NSMutableDictionary* animations;
@property (nonatomic) CGPoint initialCablePosition;
@property (nonatomic) CGSize initialCableSize;
@property (nonatomic) CGPoint initialWheelPosition;

@end

@implementation Elevator

- (instancetype)initWithID:(NSString*)ID capacity:(int)capacity delay:(float)delay_sec speed:(float)speed_per_sec;
{
    self = [super initWithID:ID];
    
    self.capacity = capacity;
    self.delay_sec = delay_sec;
    self.speed_per_sec = speed_per_sec;
    self.occupants = [NSMutableArray new];
    self.animations = [NSMutableDictionary new];

    self.ANIMATION_BASE = @"base";
    self.ANIMATION_CABLE = @"cable";
    self.ANIMATION_DOWN = @"down";
    self.ANIMATION_STOPPED = @"stopped";
    self.ANIMATION_UP = @"up";
    self.ANIMATION_WHEEL = @"wheel";

    NSString* filePath = [NSString stringWithFormat:@"%@.plist", ID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];

    CCSprite* sprite = [CCSprite new];
    sprite.anchorPoint = ccp(0.5, 0);
    sprite.position = ccp(0, 55);
    self.cableSprite = sprite;
    [self addChild:sprite];
    [self createAnimationWithName:self.ANIMATION_CABLE startFrame:11 endFrame:11 sprite:sprite];

    sprite = [CCSprite new];
    sprite.anchorPoint = ccp(0.5, 0);
    sprite.position = ccp(0, 69);
    [self addChild:sprite];
    [self createAnimationWithName:self.ANIMATION_BASE startFrame:10 endFrame:10 sprite:sprite];

    sprite = [CCSprite new];
    sprite.anchorPoint = ccp(0.5, 0);
    self.elevatorSprite = sprite;
    [self addChild:sprite];
    [self createAnimationWithName:self.ANIMATION_STOPPED startFrame:0 endFrame:0 sprite:sprite];
    [self createAnimationWithName:self.ANIMATION_DOWN startFrame:1 endFrame:1 sprite:sprite];
    [self createAnimationWithName:self.ANIMATION_UP startFrame:2 endFrame:2 sprite:sprite];
    
    sprite = [CCSprite new];
    sprite.anchorPoint = ccp(0.5, 0);
    sprite.position = ccp(0, 50);
    self.wheelSprite = sprite;
    [self addChild:sprite];
    [self createAnimationWithName:self.ANIMATION_WHEEL startFrame:3 endFrame:9 sprite:sprite];

    self.initialCablePosition = self.cableSprite.position;
    self.initialCableSize = self.cableSprite.boundingBox.size;

    self.initialWheelPosition = self.wheelSprite.position;
    
    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    [self setState:[ElevatorWaitState new]];
}

- (void)createAnimationWithName:(NSString*)name startFrame:(int)startFrame endFrame:(int)endFrame sprite:(CCSprite*)sprite
{
    Animation* animation = [[Animation alloc] initWithSprite:sprite anchorPoint:ccp(0.5, 0) duration:0.2 loopCount:0];
    
    for (int i = startFrame; i <= endFrame; i++) {
        NSString* frameName = [NSString stringWithFormat:@"%@_%d", self.ID, i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        
        [animation addSpriteFrame:frame];
    }
    
    self.animations[name] = animation;
}

- (Animation*)getAnimationWithName:(NSString*)name
{
    return self.animations[name];
}

- (void)addOccupant:(Character*)occupant
{
    if (self.isFull) {
        return;
    }
    
    [self.occupants addObject:occupant];
}

- (BOOL)isEmpty
{
    return (self.occupants.count == 0);
}

- (BOOL)isFull
{
    return (self.occupants.count == self.capacity);
}

- (BOOL)isWaiting
{
    return (!self.isFull && [self.currentState isKindOfClass:[ElevatorWaitState class]]);
}

@end
