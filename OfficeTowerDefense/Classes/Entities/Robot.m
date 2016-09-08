//
//  Robot.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Robot.h"

#import "Diamond.h"
#import "GameWorld.h"
#import "SoundManager.h"

@interface Robot()

@property (nonatomic) float diamondDropPercentage;

@end

@implementation Robot

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec filePosition:(CGPoint)filePosition diamondDropPercentage:(float)diamondDropPercentage
{
    self = [super initWithID:ID coins:coins hitPoints:hitPoints speed:speed_per_sec filePosition:filePosition];
    
    self.diamondDropPercentage = diamondDropPercentage;
    
    return self;
}

- (void)onDead:(NSString*)dieAnimationName
{
    if (drand48() < self.diamondDropPercentage) {
        float xOffset = drand48() * 40 - 20;
        
        CGPoint position = ccp(self.position.x + xOffset, self.position.y);
        Diamond* diamond = [[Diamond alloc] initWithAmount:1 position:position];
        
        [self.gameWorld addChild:diamond];
    }
    
    [SoundManager playEffect:ROBOT_EXPLODE];
    [super onDead:dieAnimationName];
}

- (void)scare
{
}

@end
