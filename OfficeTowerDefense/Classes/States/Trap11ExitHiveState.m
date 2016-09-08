//
//  Trap11ExitHiveState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap11ExitHiveState.h"

#import "Animation.h"
#import "Trap11.h"
#import "Trap11SwarmState.h"

@interface Trap11ExitHiveState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap11ExitHiveState

- (void)onEnter
{
    Trap11* trap = (Trap11*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_EXIT_HIVE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap11SwarmState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
