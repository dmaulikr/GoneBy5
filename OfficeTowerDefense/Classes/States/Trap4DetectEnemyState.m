//
//  Trap4DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap4DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap4.h"
#import "Trap4DropState.h"

@interface Trap4DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap4DetectEnemyState

- (void)onEnter
{
    Trap4* trap = (Trap4*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap4* trap = (Trap4*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        float dx = trap.position.x - enemy.position.x;
        
        if (fabs(dx) < 10) {
            [trap setState:[Trap4DropState new]];
            return;
        }
    }
    
    [self.animation tick:delta];
}

@end
