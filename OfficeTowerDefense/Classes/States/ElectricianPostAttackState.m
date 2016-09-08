//
//  ElectricianPostAttackState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ElectricianPostAttackState.h"

#import "Animation.h"
#import "Electrician.h"
#import "ElectricianWalkState.h"

@interface ElectricianPostAttackState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ElectricianPostAttackState

- (void)onEnter
{
    Electrician* electrician = (Electrician*)self.owner;
    
    self.animation = [electrician getAnimationWithName:electrician.ANIMATION_POST_ATTACK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Electrician* electrician = (Electrician*)self.owner;
    
    if (self.animation.completed) {
        [electrician setState:[ElectricianWalkState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
