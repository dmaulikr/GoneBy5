//
//  Trap8PourState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap8PourState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "SneakingRobot.h"
#import "Trap8.h"
#import "Trap8ReloadState.h"

@interface Trap8PourState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap8PourState

- (void)onEnter
{
    Trap8* trap = (Trap8*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_POUR];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap8* trap = (Trap8*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead) {
                continue;
            }
            
            float damage = trap.damage;
            
            if ([enemy isKindOfClass:[Robot class]]) {
                damage *= 2.0;
            }
            
            [enemy takeDamage:damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap8ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
