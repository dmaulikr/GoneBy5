//
//  Trap12DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap12DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Robot.h"
#import "Trap12.h"

@interface Trap12DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap12DetectEnemyState

- (void)onEnter
{
    Trap12* trap = (Trap12*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap12* trap = (Trap12*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[Robot class]]) {
            continue;
        }
        
        [enemy takeDamage:trap.damage overlay:trap.overlayFX dieAnimationName:trap.enemyDieAnimationName];
        [enemy modifySpeed:trap.speedModifier duration:0.05];
    }
    
    [self.animation tick:delta];
}

@end
