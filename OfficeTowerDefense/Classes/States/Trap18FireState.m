//
//  Trap18FireState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap18FireState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Projectile0.h"
#import "SoundManager.h"
#import "Trap18.h"
#import "Trap18ReloadState.h"

@interface Trap18FireState()

@property (nonatomic, weak) Animation* animation;

@property (nonatomic) BOOL fired;
@property (nonatomic) int shotsFired;

@end

@implementation Trap18FireState

- (void)onEnter
{
    Trap18* trap = (Trap18*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_FIRE];
    [self.animation restart];
    
    self.fired = NO;
    self.shotsFired = 0;
}

- (void)tick:(CCTime)delta
{
    Trap18* trap = (Trap18*)self.owner;

    if (self.animation.completed) {
        if (self.shotsFired == trap.numberOfShots) {
            [trap setState:[Trap18ReloadState new]];
            return;
        }
        else {
            self.fired = NO;
            [self.animation restart];
        }
    }
    
    if (!self.fired) {
        Projectile0* projectile = [[Projectile0 alloc] initWithDamage:trap.damage speed:trap.projectileSpeed_per_sec startingGrid:trap.grid gridDistance:trap.gridDistance];
        projectile.scaleX = trap.scaleX;
        
        if (trap.scaleX == 1) {
            projectile.position = ccp(trap.position.x - 18, trap.position.y + 20);
        }
        else {
            projectile.position = ccp(trap.position.x + 18, trap.position.y + 20);
        }
        
        [SoundManager playEffect:trap.sound];
        [trap.gameWorld addChild:projectile];
        
        self.fired = YES;
        self.shotsFired++;
    }
        
    [self.animation tick:delta];
}

@end
