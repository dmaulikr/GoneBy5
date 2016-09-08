//
//  Trap1DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-12.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap1DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "FlyingRobot.h"
#import "GameWorld.h"
#import "Janitor.h"
#import "Trap1.h"
#import "Trap1CountDownState.h"

@interface Trap1DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap1DetectEnemyState

- (void)onEnter
{
    Trap1* trap = (Trap1*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap1* trap = (Trap1*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Janitor class]] || [enemy isKindOfClass:[FlyingRobot class]]) {
            continue;
        }
        
        [trap setState:[Trap1CountDownState new]];
        
        return;
    }
    
    [self.animation tick:delta];
}

@end
