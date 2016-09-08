//
//  Trap11EnterHiveState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap11EnterHiveState.h"

#import "Animation.h"
#import "Trap11.h"
#import "Trap11DetectEnemyState.h"

@interface Trap11EnterHiveState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap11EnterHiveState

- (void)onEnter
{
    Trap11* trap = (Trap11*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_ENTER_HIVE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap11DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
