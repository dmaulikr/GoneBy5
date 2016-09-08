//
//  Trap8DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap8DetectEnemyState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap8.h"
#import "Trap8PourState.h"

@interface Trap8DetectEnemyState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap8DetectEnemyState

- (void)onEnter
{
    Trap8* trap = (Trap8*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap8* trap = (Trap8*)self.owner;
    NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
    
    for (Enemy* enemy in enemies) {
        if (enemy.isDead || [enemy isKindOfClass:[Electrician class]]) {
            continue;
        }
        
        [trap setState:[Trap8PourState new]];
        return;
    }
    
    [self.animation tick:delta];
}

@end
