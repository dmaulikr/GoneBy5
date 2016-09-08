//
//  Trap9PourState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap9PourState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "SneakingRobot.h"
#import "SoundManager.h"
#import "Trap9.h"
#import "Trap9ReloadState.h"

@interface Trap9PourState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap9PourState

- (void)onEnter
{
    Trap9* trap = (Trap9*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_POUR];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap9* trap = (Trap9*)self.owner;
        
        [SoundManager playEffect:trap.sound];
        
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead) {
                continue;
            }
            
            float damage = trap.damage;
            
            if ([enemy isKindOfClass:[Robot class]]) {
                damage *= 1.5;
            }

            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap9ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
