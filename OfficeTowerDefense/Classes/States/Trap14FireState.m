//
//  Trap14FireState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap14FireState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "SneakingRobot.h"
#import "SoundManager.h"
#import "Trap14.h"
#import "Trap14ReloadState.h"

@interface Trap14FireState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap14FireState

- (void)onEnter
{
    Trap14* trap = (Trap14*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_FIRE];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap14* trap = (Trap14*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[SneakingRobot class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];\
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap14ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
