//
//  EnemyDieState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EnemyDieState.h"

#import "Animation.h"
#import "Enemy.h"

@interface EnemyDieState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic, copy) NSString* animationName;

@end

@implementation EnemyDieState

- (instancetype)initWithAnimationName:(NSString*)animationName
{
    self = [super init];
    
    self.animationName = animationName;
    
    return self;
}

- (void)onEnter
{
    Enemy* enemy = (Enemy*)self.owner;
    
    self.animation = ([self.animationName isEqualToString:enemy.ANIMATION_BURN]) ? [enemy getAnimationWithName:enemy.ANIMATION_BURN] : [enemy getAnimationWithName:enemy.ANIMATION_DIE];

    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        Enemy* enemy = (Enemy*)self.owner;
        [enemy removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
