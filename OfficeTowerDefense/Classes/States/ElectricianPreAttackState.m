//
//  ElectricianPreAttackState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ElectricianPreAttackState.h"

#import "Animation.h"
#import "Electrician.h"
#import "ElectricianAttackState.h"
#import "ElectricianWalkState.h"
#import "GameWorld.h"
#import "Trap.h"
#import "PowerUp.h"
#import "Weapon.h"

@interface ElectricianPreAttackState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, weak) Trap* trap;

@end

@implementation ElectricianPreAttackState

- (void)onEnter
{
    Electrician* electrician = (Electrician*)self.owner;
    
    self.animation = [electrician getAnimationWithName:electrician.ANIMATION_PRE_ATTACK];
    [self.animation restart];
    
    NSArray* weapons = [electrician.gameWorld getWeaponsAtGrid:electrician.grid];
    
    for (Weapon* weapon in weapons) {
        if ([weapon isKindOfClass:[PowerUp class]]) {
            continue;
        }
        
        Trap* tempTrap = (Trap*)weapon;
        
        if (tempTrap.placement == PLACEMENT_TOP) {
            self.trap = tempTrap;
            self.trap.isBeingRemoved = YES;
            break;
        }
    }
}

- (void)tick:(CCTime)delta
{
    Electrician* electrician = (Electrician*)self.owner;
    
    if (!self.trap.gameWorld) {
        [electrician setState:[ElectricianWalkState new]];
    }
    else if (self.animation.completed) {
        [electrician setState:[ElectricianAttackState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

- (void)onExit
{
    self.trap.isBeingRemoved = NO;
    self.trap = nil;
}

@end
