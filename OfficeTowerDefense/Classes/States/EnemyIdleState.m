//
//  EnemyIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EnemyIdleState.h"

#import "Animation.h"
#import "Enemy.h"

@interface EnemyIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation EnemyIdleState

- (void)onEnter
{
    Enemy* enemy = (Enemy*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}

@end
