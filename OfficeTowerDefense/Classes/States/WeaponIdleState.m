//
//  WeaponIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-17.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WeaponIdleState.h"

#import "Animation.h"
#import "Weapon.h"

@interface WeaponIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation WeaponIdleState

- (void)onEnter
{
    Weapon* weapon = (Weapon*)self.owner;
    
    self.animation = [weapon getAnimationWithName:weapon.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
