//
//  Trap0ExplodeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap0ExplodeState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "SoundManager.h"
#import "Trap0.h"
#import "Trap0DisappearState.h"

@interface Trap0ExplodeState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap0ExplodeState

- (void)onEnter
{
    Trap0* trap = (Trap0*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_EXPLODE];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap0* trap = (Trap0*)self.owner;
        
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[FlyingRobot class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap0DisappearState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
