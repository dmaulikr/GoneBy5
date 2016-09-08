//
//  PowerUp3RunState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-25.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp3RunState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "PowerUp3.h"
#import "PowerUp3BarkState.h"
#import "Robot.h"

@interface PowerUp3RunState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) int direction;

@end

@implementation PowerUp3RunState

- (void)onEnter
{
    PowerUp3* powerUp = (PowerUp3*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_RUN];
    [self.animation restart];

    int gridY = floor(powerUp.grid.y);
    
    if (gridY == 1) {
        powerUp.scaleX = -1;
        self.direction = 1;
    }
    else {
        powerUp.scaleX = 1;
        self.direction = -1;
    }
}

- (void)tick:(CCTime)delta
{
    PowerUp3* powerUp = (PowerUp3*)self.owner;
    CGPoint grid = powerUp.grid;

    if ((self.direction == 1 && grid.x >= 9) || (self.direction == -1 && grid.x < 1)) {
        [powerUp removeFromParent];
        return;
    }
    
    for (int i = 0; i < 1; i++) {
        grid.x += self.direction * i;

        NSArray* enemies = [powerUp.gameWorld getCharactersInGrid:powerUp.grid];
    
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [powerUp.attackedEnemies containsObject:enemy] || [enemy isKindOfClass:[Boss class]] || [enemy isKindOfClass:[Robot class]]) {
                continue;
            }
            
            if (self.direction == 1 && enemy.position.x <= powerUp.position.x) {
                continue;
            }
            
            if (self.direction == -1 && enemy.position.x >= powerUp.position.x) {
                continue;
            }
            
            if (ccpDistance(enemy.position, powerUp.position) < 10) {
                [powerUp setState:[PowerUp3BarkState new]];
                return;
            }
        }
    }
    
    float speed = powerUp.speed_per_sec * delta * self.direction;
    
    powerUp.position = ccp(powerUp.position.x + speed, powerUp.position.y);
    [self.animation tick:delta];
}

@end
