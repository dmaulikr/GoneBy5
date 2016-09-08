//
//  Trap13DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap13DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap13.h"
#import "Trap13ShockEnemyState.h"

@interface Trap13DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap13DetectEnemyState

- (void)onEnter
{
    Trap13* trap = (Trap13*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap13* trap = (Trap13*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
            continue;
        }
        
        if (ccpDistance(enemy.position, trap.position) < 10) {
            [trap setState:[Trap13ShockEnemyState new]];
        }
        
        return;
    }
    
    [self.animation tick:delta];
}

@end
