//
//  PowerUp4ChargeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-20.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp4ChargeState.h"

#import "Animation.h"
#import "Boss.h"
#import "CCSprite.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "PowerUp4.h"
#import "SoundManager.h"

@interface PowerUp4ChargeState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) int direction;

@end

@implementation PowerUp4ChargeState

- (void)onEnter
{
    PowerUp4* powerUp = (PowerUp4*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_CHARGE];
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
    
    [SoundManager playEffect:powerUp.sound];
}

- (void)tick:(CCTime)delta
{
    PowerUp4* powerUp = (PowerUp4*)self.owner;
    CGPoint grid = powerUp.grid;
    
    if ((self.direction == 1 && grid.x >= 9) || (self.direction == -1 && grid.x < 1)) {
        [powerUp removeFromParent];
        return;
    }
    
    for (int i = 0; i < 1; i++) {
        grid.x += self.direction * i;
        
        NSArray* weapons = [powerUp.gameWorld getWeaponsAtGrid:powerUp.grid];
        
        for (Weapon* weapon in weapons) {
            if (weapon == powerUp) {
                continue;
            }
            
            float distance = (weapon.sprite.boundingBox.size.width + powerUp.sprite.boundingBox.size.width) / 2.0;
            
            if (weapon.placement == PLACEMENT_BOTTOM && ccpDistance(weapon.position, powerUp.position) <= distance) {
                [weapon removeFromParent];
            }
        }
        
        NSArray* enemies = [powerUp.gameWorld getCharactersInGrid:powerUp.grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead) {
                continue;
            }
            
            float distance = (enemy.sprite.boundingBox.size.width + powerUp.sprite.boundingBox.size.width) / 2.0;
            
            if (ccpDistance(enemy.position, powerUp.position) <= distance) {
                if ([enemy isKindOfClass:[Boss class]]) {
                    [powerUp removeFromParent];
                    return;
                }
                else {
                    [enemy takeDamage:enemy.hitPoints overlay:OVERLAY_HIT dieAnimationName:@"die"];
                }
            }
        }
    }
    
    float speed = powerUp.speed_per_sec * delta * self.direction;
    
    powerUp.position = ccp(powerUp.position.x + speed, powerUp.position.y);
    [self.animation tick:delta];
}

@end
