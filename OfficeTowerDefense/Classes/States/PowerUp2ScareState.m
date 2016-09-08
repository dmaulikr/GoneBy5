//
//  PowerUp2ScareState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp2ScareState.h"

#import "Actor.h"
#import "Animation.h"
#import "Boss.h"
#import "CCDirector.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "PowerUp2.h"
#import "PowerUp2DisappearState.h"
#import "Robot.h"
#import "SoundManager.h"

@interface PowerUp2ScareState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) CCTime scareInterval;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) float wanderDistance;
@property (nonatomic) float wanderAngle_rad;

@end

@implementation PowerUp2ScareState

- (void)onEnter
{
    PowerUp2* powerUp = (PowerUp2*)self.owner;
    
    [SoundManager playEffect:powerUp.sound];
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_SCARE];
    [self.animation restart];
    
    self.scareInterval = powerUp.scareTime_sec;
    self.velocity = ccp(-1, 0);
    self.wanderAngle_rad = drand48() * 360.0 * M_PI / 180.0;
}

- (void)tick:(CCTime)delta
{
    PowerUp2* powerUp = (PowerUp2*)self.owner;
    NSArray* characters = [powerUp.gameWorld getCharactersIntersectingGrid:powerUp.grid];
    
    for (Character* character in characters) {
        if (character.isDead || character == powerUp.gameWorld.actor) {
            continue;
        }
        
        Enemy* enemy = (Enemy*)character;
        float distance = 26 * [CCDirector sharedDirector].contentScaleFactor;
        
        if (ccpDistance(powerUp.position, enemy.position) <= distance) {
            if (self.velocity.x < 0 && enemy.speed_per_sec > 0 && powerUp.position.x >= enemy.position.x) {
                [enemy scare];
            }
            else if (self.velocity.x > 0 && enemy.speed_per_sec < 0 && powerUp.position.x <= enemy.position.x) {
                [enemy scare];
            }
        }
    }
    
    const float DEG_TO_RAD = M_PI / 180.0;
    const float MIN_HORIZONTAL = 1.5;
    const float MAX_HORIZONTAL = 8.5;
    const float MIN_VERTICAL = 0.5;
    const float MAX_VERTICAL = 2.25;
    
    if (powerUp.grid.x <= MIN_HORIZONTAL && self.velocity.x < 0) {
        if (powerUp.grid.y <= MIN_VERTICAL) {
            self.wanderAngle_rad = drand48() * 80.0 * DEG_TO_RAD;
        }
        else if (powerUp.grid.y >= MAX_VERTICAL) {
            self.wanderAngle_rad = drand48() * -80.0 * DEG_TO_RAD;
        }
        else {
            self.wanderAngle_rad = (drand48() * 80.0 - 80.0) * DEG_TO_RAD;
        }
    }
    else if (powerUp.grid.x >= MAX_HORIZONTAL && self.velocity.x > 0) {
        if (powerUp.grid.y <= MIN_VERTICAL) {
            self.wanderAngle_rad = (drand48() * 80.0 + 100.0) * DEG_TO_RAD;
        }
        else if (powerUp.grid.y >= MAX_VERTICAL) {
            self.wanderAngle_rad = (drand48() * 70.0 + 190.0) * DEG_TO_RAD;
        }
        else {
            self.wanderAngle_rad += (drand48() * 100.0 + 170.0) * DEG_TO_RAD;
        }
    }
    else if (powerUp.grid.y <= MIN_VERTICAL && self.velocity.y < 0) {
        self.wanderAngle_rad = drand48() * 180.0 * DEG_TO_RAD;
    }
    else if (powerUp.grid.y >= MAX_VERTICAL && self.velocity.y > 0) {
        self.wanderAngle_rad = drand48() * -180.0 * DEG_TO_RAD;
    }
    else {
        self.wanderAngle_rad += (drand48() - drand48()) * 0.1;
    }
    
    self.velocity = ccp(cos(self.wanderAngle_rad) * 0.5, sin(self.wanderAngle_rad) * 0.5);
    powerUp.position = ccpAdd(powerUp.position, self.velocity);
    
    if (self.velocity.x < 0) {
        powerUp.scaleX = 1;
    }
    else if (self.velocity.x > 0) {
        powerUp.scaleX = -1;
    }
    
    [self.animation tick:delta];
    
    self.scareInterval -= delta;

    if (self.scareInterval <= 0) {
        [powerUp setState:[PowerUp2DisappearState new]];
    }
}

@end
