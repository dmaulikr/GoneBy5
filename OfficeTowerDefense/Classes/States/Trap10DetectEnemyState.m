//
//  Trap10DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap10DetectEnemyState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Robot.h"
#import "Trap10.h"
#import "Trap10MoveDownState.h"

@interface Trap10DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap10DetectEnemyState

- (void)onEnter
{
    Trap10* trap = (Trap10*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap10* trap = (Trap10*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Boss class]] || [enemy isKindOfClass:[Robot class]] || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap10MoveDownState new]];
        
        return;
    }
    
    [self.animation tick:delta];
}

@end
