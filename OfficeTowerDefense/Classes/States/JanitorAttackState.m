//
//  JanitorAttackState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-26.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "JanitorAttackState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "JanitorPostAttackState.h"
#import "JanitorWalkState.h"
#import "Trap.h"
#import "PowerUp.h"
#import "Weapon.h"

@interface JanitorAttackState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, weak) Trap* trap;

@end

@implementation JanitorAttackState

- (void)onEnter
{
    Janitor* janitor = (Janitor*)self.owner;
    
    self.animation = [janitor getAnimationWithName:janitor.ANIMATION_ATTACK];
    [self.animation restart];
    
    NSArray* weapons = [janitor.gameWorld getWeaponsAtGrid:janitor.grid];
    
    for (Weapon* weapon in weapons) {
        if ([weapon isKindOfClass:[PowerUp class]]) {
            continue;
        }
        
        Trap* tempTrap = (Trap*)weapon;
        
        if (tempTrap.placement == PLACEMENT_BOTTOM) {
            self.trap = tempTrap;
            self.trap.isBeingRemoved = YES;
            break;
        }
    }
}

- (void)tick:(CCTime)delta
{
    Janitor* janitor = (Janitor*)self.owner;

    if (!self.trap.gameWorld) {
        [janitor setState:[JanitorWalkState new]];
    }
    else if (self.animation.completed) {
        [self.trap removeFromParent];
        
        [janitor setState:[JanitorPostAttackState new]];
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
