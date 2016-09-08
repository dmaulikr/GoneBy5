//
//  PowerUp5DetectEnemyState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5DetectEnemyState.h"

#import "Animation.h"
#import "Boss.h"
#import "Enemy.h"
#import "GameWorld.h"
#import "PowerUp5.h"
#import "PowerUp5ExplodeState.h"
#import "PowerUp5Portal.h"
#import "PowerUp5PortalDisappearState.h"

@interface PowerUp5DetectEnemyState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) PowerUp5Portal* portal;

@end

@implementation PowerUp5DetectEnemyState

- (void)onEnter
{
    PowerUp5* powerUp = (PowerUp5*)self.owner;
    
    self.animation = [powerUp getAnimationWithName:powerUp.ANIMATION_DETECT_ENEMY];
    [self.animation restart];
    
    self.portal = [PowerUp5Portal new];
    self.portal.position = [powerUp.gameWorld getFloorPositionFromGrid:ccp(0.5, 2)];
    [powerUp.gameWorld addChild:self.portal];
    [self.portal place];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner setState:[PowerUp5ExplodeState new]];
    }
    else {
        PowerUp5* powerUp = (PowerUp5*)self.owner;
        NSArray* enemies = [powerUp.gameWorld getCharactersInGrid:powerUp.grid];
    
        for (Enemy* enemy in enemies) {
            if (enemy.isDead || [enemy isKindOfClass:[Boss class]]) {
                continue;
            }
            
            enemy.scaleX = -1;
            enemy.speed_per_sec = fabs(enemy.speed_per_sec);
            enemy.position = self.portal.position;
        }
    
        [self.animation tick:delta];
    }
}

- (void)onExit
{
    [self.portal setState:[PowerUp5PortalDisappearState new]];
}

@end
