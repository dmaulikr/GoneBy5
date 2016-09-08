//
//  Trap7DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap7DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap7.h"

@interface Trap7DetectEnemyState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) NSMutableArray* enemies;
@property (nonatomic) int enemyCount;

@end

@implementation Trap7DetectEnemyState

- (void)onEnter
{
    Trap7* trap = (Trap7*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
    
    self.enemies = [NSMutableArray new];
    self.enemyCount = 0;
}

- (void)tick:(CCTime)delta
{
    Trap7* trap = (Trap7*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    if (self.enemyCount < trap.maxEnemies) {
        for (Enemy* enemy in enemies) {
            if ([self.enemies containsObject:enemy] || enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
                continue;
            }
        
            if (self.enemyCount < trap.maxEnemies) {
                [self.enemies addObject:enemy];
                self.enemyCount++;
            }
        }
    }
    
    for (int i = (int)self.enemies.count - 1; i >= 0; i--) {
        Enemy* enemy = self.enemies[i];
        
        if (!enemy.isDead && floor(enemy.grid.x) == floor(trap.grid.x)) {
            [enemy modifySpeed:trap.speedModifier duration:0.05];
        }
        else {
            [self.enemies removeObject:enemy];
        }
    }
    
    if (self.enemies.count == 0 && self.enemyCount == trap.maxEnemies) {
        [trap removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
