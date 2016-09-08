//
//  Trap9DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap9DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap9.h"
#import "Trap9PourState.h"

@interface Trap9DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap9DetectEnemyState

- (void)onEnter
{
    Trap9* trap = (Trap9*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap9* trap = (Trap9*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap9PourState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
