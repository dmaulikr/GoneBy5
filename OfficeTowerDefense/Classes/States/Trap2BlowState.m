//
//  Trap2BlowState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap2BlowState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "SneakingRobot.h"
#import "SoundManager.h"
#import "Trap2.h"
#import "Trap2ReloadState.h"

@interface Trap2BlowState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap2BlowState

- (void)onEnter
{
    Trap2* trap = (Trap2*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_BLOW];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap2* trap = (Trap2*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[SneakingRobot class]]) {
                continue;
            }

            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
        }
    
        [trap setState:[Trap2ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
