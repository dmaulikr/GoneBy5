//
//  Trap0DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap0DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap0.h"
#import "Trap0CountDownState.h"

@interface Trap0DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap0DetectEnemyState

- (void)onEnter
{
    Trap0* trap = (Trap0*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap0* trap = (Trap0*)self.owner;    
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
            continue;
        }
        
        [trap setState:[Trap0CountDownState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
