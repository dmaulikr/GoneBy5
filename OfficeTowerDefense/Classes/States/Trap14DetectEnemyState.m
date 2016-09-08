//
//  Trap14DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap14DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap14.h"
#import "Trap14FireState.h"

@interface Trap14DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap14DetectEnemyState

- (void)onEnter
{
    Trap14* trap = (Trap14*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap14* trap = (Trap14*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap14FireState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
