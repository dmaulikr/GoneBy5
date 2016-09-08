//
//  Trap11SwarmState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap11SwarmState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Robot.h"
#import "SoundManager.h"
#import "Trap11.h"
#import "Trap11EnterHiveState.h"

@interface Trap11SwarmState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap11SwarmState

- (void)onEnter
{
    Trap11* trap = (Trap11*)self.owner;
    
    [SoundManager playEffect:trap.sound];
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_SWARM];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap11* trap = (Trap11*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[Boss class]] || [enemy isKindOfClass:[Robot class]] || [enemy isKindOfClass:[Electrician class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap11EnterHiveState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
