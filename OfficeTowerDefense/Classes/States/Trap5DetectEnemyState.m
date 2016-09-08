//
//  Trap5DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap5DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap5.h"
#import "Trap5DropState.h"

@interface Trap5DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap5DetectEnemyState

- (void)onEnter
{
    Trap5* trap = (Trap5*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap5* trap = (Trap5*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        float dx = trap.position.x - enemy.position.x;
        
        if (fabs(dx) < 10) {
            [trap setState:[Trap5DropState new]];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
