//
//  Trap2DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap2DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap2.h"
#import "Trap2BlowState.h"

@interface Trap2DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap2DetectEnemyState

- (void)onEnter
{
    Trap2* trap = (Trap2*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap2* trap = (Trap2*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        float diffX = enemy.position.x - trap.position.x;
        
        if (fabs(diffX) < 10) {
            [trap setState:[Trap2BlowState new]];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
