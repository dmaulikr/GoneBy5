//
//  Trap11DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap11DetectEnemyState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Robot.h"
#import "Trap11.h"
#import "Trap11ExitHiveState.h"

@interface Trap11DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap11DetectEnemyState

- (void)onEnter
{
    Trap11* trap = (Trap11*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap11* trap = (Trap11*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Boss class]] || [enemy isKindOfClass:[Robot class]] || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap11ExitHiveState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
