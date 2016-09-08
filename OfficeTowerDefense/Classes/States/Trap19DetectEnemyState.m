//
//  Trap19DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-08.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap19DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap19.h"
#import "Trap19FireState.h"

@interface Trap19DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap19DetectEnemyState

- (void)onEnter
{
    Trap19* trap = (Trap19*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
    
    trap.scaleX = (floor(trap.grid.y) == 1) ? -1 : 1;
}

- (void)tick:(CCTime)delta
{
    Trap19* trap = (Trap19*)self.owner;
    CGPoint grid = trap.grid;
    int direction = -trap.scaleX;
    
    grid.x = floor(trap.grid.x) + trap.gridDistance * direction;
    
    if (grid.x <= 0 || grid.x >= 9) {
        return;
    }
    
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:grid];
        
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
            continue;
        }
        
        [trap setState:[Trap19FireState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
