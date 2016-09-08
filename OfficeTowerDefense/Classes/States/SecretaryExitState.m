//
//  SecretaryExitState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SecretaryExitState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Secretary.h"

@interface SecretaryExitState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation SecretaryExitState

- (void)onEnter
{
    Secretary* enemy = (Secretary*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_WALK];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Secretary* enemy = (Secretary*)self.owner;
    
    if (enemy.rearGrid.x >= 11) {
        [enemy removeFromParent];
    }
    else {
        float speed = enemy.speed_per_sec * delta * enemy.speedModifier;

        enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
        [self.animation tick:delta];
    }
}

@end
