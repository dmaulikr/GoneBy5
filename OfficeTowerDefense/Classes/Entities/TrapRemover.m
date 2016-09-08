//
//  TrapRemover.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TrapRemover.h"

#import "Trap.h"
#import "WeaponIdleState.h"

@interface TrapRemover()

@property (nonatomic, copy) NSString* ANIMATION_IDLE;
@property (nonatomic, copy) NSString* ANIMATION_REMOVE_TRAP;

@end

@implementation TrapRemover

- (instancetype)init
{
    self = [super initWithID:@"trapRemover"];
    
    self.zOrder = 4000;
    
    [self setState:[WeaponIdleState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_IDLE = @"idle";
    self.ANIMATION_REMOVE_TRAP = @"removeTrap";
    
    [self createAnimationWithName:self.ANIMATION_IDLE anchorPoint:ccp(0.5, 0.5) duration:1 loopCount:0 startFrame:0 endFrame:0];
    [self createAnimationWithName:self.ANIMATION_REMOVE_TRAP anchorPoint:ccp(0.5, 0.5) duration:0.75 loopCount:0 startFrame:0 endFrame:20];
}

@end
