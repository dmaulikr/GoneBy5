//
//  Trap3DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap3DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap3.h"
#import "Trap3FireState.h"

@interface Trap3DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap3DetectEnemyState

- (void)onEnter
{
    Trap3* trap = (Trap3*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap3* trap = (Trap3*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap3FireState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
