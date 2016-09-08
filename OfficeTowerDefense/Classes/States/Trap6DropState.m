//
//  Trap6DropState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap6DropState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "SneakingRobot.h"
#import "Trap6.h"
#import "Trap6ReloadState.h"

@interface Trap6DropState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap6DropState

- (void)onEnter
{
    Trap6* trap = (Trap6*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DROP];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap6* trap = (Trap6*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[SneakingRobot class]]) {
                continue;
            }
            
            [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
            [enemy modifySpeed:trap.speedModifier duration:trap.speedModifierDuration_sec];
        }
        
        [trap setState:[Trap6ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
