//
//  Trap13ShockEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap13ShockEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "SoundManager.h"
#import "Trap13.h"
#import "Trap13ReloadState.h"

@interface Trap13ShockEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap13ShockEnemyState

- (void)onEnter
{
    Trap13* trap = (Trap13*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_SHOCK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[Trap13ReloadState new]];
    }
    else {
        Trap13* trap = (Trap13*)self.owner;
        
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[FlyingRobot class]]) {
                continue;
            }
            
            if (ccpDistance(enemy.position, trap.position) < 15) {
                [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
                [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
            }
        }

        [self.animation tick:delta];
    }
}

@end
