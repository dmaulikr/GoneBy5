//
//  Trap19FireState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap19FireState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Projectile1.h"
#import "Trap19.h"
#import "Trap19ReloadState.h"

@interface Trap19FireState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap19FireState

- (void)onEnter
{
    Trap19* trap = (Trap19*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_FIRE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap19* trap = (Trap19*)self.owner;
    
    if (self.animation.completed) {
        Projectile1* projectile = [[Projectile1 alloc] initWithDamage:trap.damage speed:trap.projectileSpeed_per_sec gridDistance:trap.gridDistance sound:trap.sound];
        projectile.scaleX = trap.scaleX;
        projectile.position = ccp(trap.position.x, trap.position.y + 35);
        
        [trap.gameWorld addChild:projectile];

        [trap setState:[Trap19ReloadState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
