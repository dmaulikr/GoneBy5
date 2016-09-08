//
//  Trap15DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Trap15DetectEnemyState.h"

#import "Actor.h"
#import "Animation.h"
#import "CCParticleSystem.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "Trap15.h"

@interface Trap15DetectEnemyState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) NSMutableArray* enemies;
@property (nonatomic) CCParticleSystem* windParticleSystem;

@end

@implementation Trap15DetectEnemyState

- (void)onEnter
{
    Trap15* trap = (Trap15*)self.owner;
    
    self.animation = [trap getAnimationWithName:trap.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
    
    trap.scaleX = (floor(trap.grid.y) == 1) ? -1 : 1;

    self.enemies = [NSMutableArray new];
    self.windParticleSystem = [CCParticleSystem particleWithFile:@"windParticles.plist"];
    self.windParticleSystem.position = ccp(0, 15);
    [trap addChild:self.windParticleSystem];
}

- (void)tick:(CCTime)delta
{
    Trap15* trap = (Trap15*)self.owner;
    CGPoint grid = trap.grid;
    int direction = -trap.scaleX;
    
    for (int i = 0; i <= trap.gridDistance; i++) {
        grid.x = floor(trap.grid.x) + i * direction;
        
        NSArray* enemies = [trap.gameWorld getCharactersInGrid:grid];
        
        for (Enemy* enemy in enemies) {
            if ([enemy isKindOfClass:[Actor class]]) {
                continue;
            }
            
            [enemy modifySpeed:trap.speedModifier duration:0.05];
        }
    }
    
    [self.animation tick:delta];
}

- (void)onExit
{
    [self.windParticleSystem removeFromParent];
}

@end
