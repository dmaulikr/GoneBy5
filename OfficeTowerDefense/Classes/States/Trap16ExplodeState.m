//
//  Trap16ExplodeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap16ExplodeState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "SoundManager.h"
#import "Trap16.h"
#import "Trap16DisappearState.h"

@interface Trap16ExplodeState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap16ExplodeState

- (void)onEnter
{
    Trap16* trap = (Trap16*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_EXPLODE];
    [self.animation restart];
    
    [SoundManager playEffect:trap.sound];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap16* trap = (Trap16*)self.owner;
        
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (!enemy.isDead) {
                [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
                [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
            }
        }
        
        [trap setState:[Trap16DisappearState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
