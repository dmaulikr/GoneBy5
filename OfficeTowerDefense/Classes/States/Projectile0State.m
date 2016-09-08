//
//  Projectile0State.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Projectile0State.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Projectile0.h"

@interface Projectile0State()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic, weak) Enemy* potentialTarget;

@end

@implementation Projectile0State

- (void)onEnter
{
    Projectile0* projectile = (Projectile0*)self.owner;
    
    self.animation = [projectile getAnimationWithName:projectile.ANIMATION_IDLE];
    [self.animation restart];

    self.potentialTarget = [self getClosestEnemy];
}

- (void)tick:(CCTime)delta
{
    Projectile0* projectile = (Projectile0*)self.owner;
    float dx = projectile.grid.x - projectile.startingGrid.x;
    
    if (fabs(dx) > projectile.gridDistance) {
        [projectile removeFromParent];
        return;
    }
    
    if (projectile.grid.x < 1 || projectile.grid.x >= 9) {
        [projectile removeFromParent];
        return;
    }
    
    Enemy* closestEnemy = [self getClosestEnemy];
    
    if (self.potentialTarget && closestEnemy != self.potentialTarget) {
        if ([self hitEnemy:self.potentialTarget]) {
            [self.potentialTarget takeDamage:projectile.damage overlay:OVERLAY_HIT dieAnimationName:@"die"];
            [projectile removeFromParent];
            return;
        }
    }
    
    self.potentialTarget = closestEnemy;

    if (closestEnemy && [self hitEnemy:closestEnemy]) {
        [closestEnemy takeDamage:projectile.damage overlay:OVERLAY_HIT dieAnimationName:@"die"];
        [projectile removeFromParent];
        return;
    }
    
    float speed = projectile.speed_per_sec * delta;

    if (projectile.scaleX == 1) {
        speed *= -1;
    }

    projectile.position = ccp(projectile.position.x + speed, projectile.position.y);
    [self.animation tick:delta];
}

- (void)onExit
{
    self.potentialTarget = nil;
}

- (Enemy*)getClosestEnemy
{
    Projectile0* projectile = (Projectile0*)self.owner;
    NSArray* enemies = [projectile.gameWorld getCharactersIntersectingGrid:projectile.grid];
    Enemy* closestEnemy;
    float distanceToClosestEnemy = MAXFLOAT;
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead) {
            continue;
        }
        
        if (projectile.scaleX == 1 && projectile.position.x < enemy.position.x) {
            continue;
        }
        else if (projectile.scaleX == -1 && projectile.position.x > enemy.position.x) {
            continue;
        }
        
        if (closestEnemy == nil) {
            closestEnemy = enemy;
        }
        else {
            float distanceToEnemy = enemy.position.x - projectile.position.x;
            
            distanceToClosestEnemy = closestEnemy.position.x - projectile.position.x;
            
            if (fabs(distanceToEnemy) < fabs(distanceToClosestEnemy)) {
                closestEnemy = enemy;
            }
        }
    }
    
    return closestEnemy;
}

- (BOOL)hitEnemy:(Enemy*)enemy
{
    Projectile0* projectile = (Projectile0*)self.owner;

    if (projectile.scaleX == 1 && projectile.position.x <= enemy.position.x) {
        return YES;
    }
    else if (projectile.scaleX == -1 && projectile.position.x >= enemy.position.x) {
        return YES;
    }
    
    return NO;
}

@end
