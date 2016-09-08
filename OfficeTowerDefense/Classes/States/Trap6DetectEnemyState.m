//
//  Trap6DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap6DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap6.h"
#import "Trap6DropState.h"

@interface Trap6DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap6DetectEnemyState

- (void)onEnter
{
    Trap6* trap = (Trap6*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap6* trap = (Trap6*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        float dx = trap.position.x - enemy.position.x;
        
        if (fabs(dx) < 10) {
            [trap setState:[Trap6DropState new]];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
