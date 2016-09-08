//
//  Trap18DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap18DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap18.h"
#import "Trap18FireState.h"

@interface Trap18DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap18DetectEnemyState

- (void)onEnter
{
    Trap18* trap = (Trap18*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
    
    trap.scaleX = (floor(trap.grid.y) == 1) ? -1 : 1;
}

- (void)tick:(CCTime)delta
{
    Trap18* trap = (Trap18*)self.owner;
    CGPoint grid = trap.grid;
    int direction = -trap.scaleX;
    
    for (int i = 0; i <= trap.gridDistance; i++) {
        grid.x = floor(trap.grid.x) + i * direction;
        
        if (grid.x <= 0 || grid.x >= 9) {
            continue;
        }

        NSArray* enemies = [trap.gameWorld getCharactersInGrid:grid];
        
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
                continue;
            }
            
            [trap setState:[Trap18FireState new]];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
