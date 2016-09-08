//
//  PowerUp3BarkState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp3BarkState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "PowerUp3.h"
#import "PowerUp3RunState.h"
#import "Robot.h"
#import "SoundManager.h"

@interface PowerUp3BarkState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) int direction;
@property (nonatomic) NSMutableArray* currrentEnemies;

@end

@implementation PowerUp3BarkState

- (void)onEnter
{
    PowerUp3* powerUp = (PowerUp3*)self.owner;
    
    [SoundManager playEffect:powerUp.sound];
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_BARK];
    [self.animation restart];
    
    self.currrentEnemies = [NSMutableArray new];

    CGPoint grid = powerUp.grid;
    int gridY = floor(grid.y);
    
    self.direction = (gridY == 1) ? 1 : -1;

    for (int i = 0; i < 1; i++) {
        grid.x += self.direction * i;
        
        NSArray* enemies = [powerUp.gameWorld getCharactersInGrid:powerUp.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [powerUp.attackedEnemies containsObject:enemy] || [enemy isKindOfClass:[Boss class]] || [enemy isKindOfClass:[Robot class]]) {
                continue;
            }
            
            if (ccpDistance(enemy.position, powerUp.position) < 10) {
                [self.currrentEnemies addObject:enemy];
            }
        }
    }
}

- (void)tick:(CCTime)delta
{
    PowerUp3* powerUp = (PowerUp3*)self.owner;
    
    if (self.animation.completed) {
        for (Enemy* enemy in self.currrentEnemies) {
            [powerUp.attackedEnemies addObject:enemy];
            
            [enemy takeDamage:powerUp.damage overlay:OVERLAY_NONE dieAnimationName:@"die"];
        }
        
        [powerUp setState:[PowerUp3RunState new]];
    }
    else {
        for (Enemy* enemy in self.currrentEnemies) {
            [enemy modifySpeed:0 duration:0.1];
        }
        
        [self.animation tick:delta];
    }
}

- (void)onExit
{
    [self.currrentEnemies removeAllObjects];
}

@end
