//
//  Trap1ExplodeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap1ExplodeState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "SoundManager.h"
#import "Trap1.h"
#import "Trap1DisappearState.h"

@interface Trap1ExplodeState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap1ExplodeState

- (void)onEnter
{
    Trap1* trap = (Trap1*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_EXPLODE];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap1* trap = (Trap1*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[FlyingRobot class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap1DisappearState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
