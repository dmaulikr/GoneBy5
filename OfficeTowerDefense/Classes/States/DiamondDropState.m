//
//  DiamondDropState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-22.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondDropState.h"

#import "Animation.h"
#import "Diamond.h"
#import "DiamondCollectState.h"
#import "DiamondIdleState.h"

@interface DiamondDropState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) CGPoint velocity;

@end

@implementation DiamondDropState

- (void)onEnter
{
    Diamond* diamond = (Diamond*)self.owner;
    
    self.animation = [diamond getAnimationWithName:diamond.ANIMATION_IDLE];
    self.animation.currentFrame = arc4random() % self.animation.totalFrames;
    
    self.velocity = ccp(0, 5);
}

- (void)tick:(CCTime)delta
{
    const float GRAVITY_PER_SEC = -28;
    
    Diamond* diamond = (Diamond*)self.owner;
    float yVelocity = self.velocity.y + GRAVITY_PER_SEC * delta;

    self.velocity = ccp(self.velocity.x, yVelocity);
    diamond.position = ccpAdd(diamond.position, self.velocity);
    
    if (diamond.position.y <= diamond.idlePosition.y) {
        diamond.position = ccp(diamond.position.x, diamond.idlePosition.y);
        
        [diamond setState:[DiamondIdleState new]];
    }
    else {
        [self.animation tick:delta];
    }
}

- (void)onTouchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.owner setState:[DiamondCollectState new]];
}

@end
