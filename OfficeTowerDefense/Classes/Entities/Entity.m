//
//  Entity.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Entity.h"

#import "State.h"

@implementation Entity

- (void)setup
{
    [super setup];
    
    self.flaggedForRemoval = NO;
}

- (void)removeFromParent
{
    self.flaggedForRemoval = YES;
}

- (void)tick:(CCTime)delta
{
    for (int i = (int)self.children.count - 1; i >= 0; i--) {
        CCNode* child = self.children[i];
        
        if ([child isKindOfClass:[Entity class]]) {
            Entity* entity = (Entity*)child;
            
            if (entity.flaggedForRemoval) {
                [self removeChild:entity];
            }
        }
    }
    
    [super tick:delta];
}

@end
