//
//  Trap10EatState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap10EatState.h"

#import "Animation.h"
#import "Enemy.h"
#import "Trap10.h"
#import "Trap10DetectEnemyState.h"

@interface Trap10EatState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, weak) Enemy* enemy;

@end

@implementation Trap10EatState

- (instancetype)initWithEnemy:(Enemy*)enemy
{
    self = [super init];
    
    self.enemy = enemy;
    
    return self;
}

- (void)onEnter
{
    Trap10* trap = (Trap10*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_EAT];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    Trap10* trap = (Trap10*)self.owner;

    if (self.animation.completed) {
        [self.enemy takeDamage:self.enemy.hitPoints overlay:trap.overlayFX dieAnimationName:@"die"];
        self.enemy = nil;
        
        [trap setState:[Trap10DetectEnemyState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

- (void)onExit
{
    if (self.enemy) {
        [self.enemy removeFromParent];
    }
}

@end
