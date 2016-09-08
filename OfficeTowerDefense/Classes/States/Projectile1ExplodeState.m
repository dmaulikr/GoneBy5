//
//  Projectile1ExplodeState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Projectile1ExplodeState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Projectile1.h"
#import "SoundManager.h"

@interface Projectile1ExplodeState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Projectile1ExplodeState

- (void)onEnter
{
    Projectile1* projectile = (Projectile1*)self.owner;
    
    self.animation = [projectile getAnimationWithName:projectile.ANIMATION_EXPLODE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Projectile1* projectile = (Projectile1*)self.owner;

        [SoundManager playEffect:projectile.sound];
        
        NSArray* enemies = [projectile.gameWorld getCharactersInGrid:projectile.grid];
        
        for (Enemy* enemy in enemies) {
            if (!enemy.isDead) {
                float diffX = enemy.position.x - projectile.position.x;
                
                if (fabs(diffX) < 20) {
                    [enemy takeDamage:projectile.damage overlay:OVERLAY_HIT dieAnimationName:@"die"];
                }
            }
        }
        
        [projectile removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
