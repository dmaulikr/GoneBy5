//
//  ElectricianScaredState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-05-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ElectricianScaredState.h"

#import "Animation.h"
#import "GameWorld.h"
#import "Electrician.h"
#import "ElectricianWalkState.h"

@interface ElectricianScaredState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation ElectricianScaredState

- (void)onEnter
{
    Electrician* enemy = (Electrician*)self.owner;
    
    self.animation = [enemy getAnimationWithName:enemy.ANIMATION_WALK];
    [self.animation restart];
    
    [enemy addOverlay:OVERLAY_SWEAT];
    
    enemy.scaleX *= -1;
    enemy.speed_per_sec *= -1;
}

- (void)tick:(CCTime)delta
{
    Electrician* enemy = (Electrician*)self.owner;
    
    float speed = enemy.speed_per_sec * delta * enemy.speedModifier;
    
    if (speed != 0.0) {
        enemy.position = ccp(enemy.position.x + speed, enemy.position.y);
        
        [self.animation tick:delta];
    }
    
    if ((enemy.speed_per_sec > 0 && enemy.grid.x >=  9) || (enemy.speed_per_sec < 0 && enemy.grid.x <= 1)) {
        enemy.scaleX *= -1;
        enemy.speed_per_sec *= -1;
        [enemy setState:[ElectricianWalkState new]];
    }
}

- (void)onExit
{
    Electrician* enemy = (Electrician*)self.owner;
    [enemy removeOverlay:OVERLAY_SWEAT];
}

@end
