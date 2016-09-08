//
//  Trap17FireState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-31.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap17FireState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Projectile0.h"
#import "SoundManager.h"
#import "Trap17.h"
#import "Trap17ReloadState.h"

@interface Trap17FireState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap17FireState

- (void)onEnter
{
    Trap17* trap = (Trap17*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_FIRE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap17* trap = (Trap17*)self.owner;
        
        Projectile0* projectile = [[Projectile0 alloc] initWithDamage:trap.damage speed:trap.projectileSpeed_per_sec startingGrid:trap.grid gridDistance:trap.gridDistance];
        projectile.scaleX = trap.scaleX;
        
        if (trap.scaleX == 1) {
            projectile.position = ccp(trap.position.x - 18, trap.position.y + 20);
        }
        else {
            projectile.position = ccp(trap.position.x + 18, trap.position.y + 20);
        }
        
        [trap.gameWorld addChild:projectile];
        [SoundManager playEffect:trap.sound];
        [trap setState:[Trap17ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
