//
//  Trap10MoveUpState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap10MoveUpState.h"

#import "Animation.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "Trap10.h"
#import "Trap10DetectEnemyState.h"
#import "Trap10EatState.h"

@interface Trap10MoveUpState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, weak) Enemy* enemy;

@end

@implementation Trap10MoveUpState

- (instancetype)initWithEnemy:(Enemy*)enemy
{
    self = [super init];
    
    self.enemy = enemy;
    
    return self;
}

- (void)onEnter
{
    Trap10* trap = (Trap10*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_MOVE_UP];
    [self.animation restart];    
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Trap10* trap = (Trap10*)self.owner;

        if (self.enemy) {
            [trap setState:[[Trap10EatState alloc] initWithEnemy:self.enemy]];
        }
        else {
            [trap setState:[Trap10DetectEnemyState new]];
        }
    }
    else {
        [self.animation tick:delta];
    }
}

@end
