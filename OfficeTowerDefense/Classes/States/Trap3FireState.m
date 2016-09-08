//
//  Trap3FireState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap3FireState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "SneakingRobot.h"
#import "SoundManager.h"
#import "Trap3.h"
#import "Trap3ReloadState.h"

@interface Trap3FireState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap3FireState

- (void)onEnter
{
    Trap3* trap = (Trap3*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_FIRE];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap3* trap = (Trap3*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[SneakingRobot class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap3ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
