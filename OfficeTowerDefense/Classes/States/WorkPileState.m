//
//  WorkPileState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-05-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WorkPileState.h"

#import "Animation.h"
#import "WorkPile.h"

@interface WorkPileState()

@property (nonatomic, weak) Animation* animation;
@property (nonatomic) int animationIndex;
@property (nonatomic) BOOL animationChanged;

@end

@implementation WorkPileState

- (void)onEnter
{
    WorkPile* workPile = (WorkPile*)self.owner;
    
    self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_0];
    [self.animation restart];

    self.animationIndex = 0;
    self.animationChanged = NO;
}

- (void)tick:(CCTime)delta
{
    WorkPile* workPile = (WorkPile*)self.owner;

    if (!workPile.playAnimation) {
        return;
    }
    
    int percentage = ceil(workPile.hitPoints / workPile.totalHitPoints * 10);
    
    if (percentage != self.animationIndex) {
        self.animationIndex = percentage;
            
        switch (percentage) {
            case 0:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_0];
                break;
                
            case 1:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_1];
                break;
            
            case 2:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_2];
                break;
            
            case 3:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_3];
                break;
            
            case 4:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_4];
                break;
                
            case 5:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_5];
                break;
            
            case 6:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_6];
                break;
                
            case 7:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_7];
                break;
                
            case 8:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_8];
                break;
                
            case 9:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_9];
                break;
                
            case 10:
                self.animation = [workPile getAnimationWithName:workPile.ANIMATION_PILE_10];
                break;
        }
            
        [self.animation restart];
    }
        
    if (self.animation.completed) {
        [self.animation restart];
        workPile.playAnimation = NO;
    }
    else {
        [self.animation tick:delta];
    }
}

@end
