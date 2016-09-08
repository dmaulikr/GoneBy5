//
//  Trap10MoveDownState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap10MoveDownState.h"

#import "Animation.h"
#import "Boss.h"
#import "Electrician.h"
#import "Enemy.h"
#import "EnemyIdleState.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Robot.h"
#import "Trap10.h"
#import "Trap10MoveUpState.h"

@interface Trap10MoveDownState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation Trap10MoveDownState

- (void)onEnter
{
    Trap10* trap = (Trap10*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_MOVE_DOWN];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap10* trap = (Trap10*)self.owner;
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:trap.grid];
        Enemy* enemy;
        
        for (Enemy* tempEnemy in enemies) {
            if (tempEnemy.isDead || [tempEnemy isKindOfClass:[Boss class]] || [tempEnemy isKindOfClass:[Robot class]] || [tempEnemy isKindOfClass:[Electrician class]]) {
                continue;
            }
            
            [tempEnemy setState:[EnemyIdleState new]];
            tempEnemy.visible = NO;
            enemy = tempEnemy;
            break;
        }
        
        [trap setState:[[Trap10MoveUpState alloc] initWithEnemy:enemy]];
        
    }
    else {
        [self.animation tick:delta];
    }
}

@end
